from aws_cdk import Annotations, CfnOutput, Stack
from aws_cdk.aws_iam import AccountRootPrincipal, Role
from aws_cdk.aws_kms import ViaServicePrincipal
from constructs import Construct


class K8sDeploymentRoleStack(Stack):
    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)
        self.role = Role(
            self,
            "Default",
            assumed_by=ViaServicePrincipal(
                service_name="lambda.amazonaws.com",
                base_principal=AccountRootPrincipal(),
            ),
            role_name="EnergyComparisonTableDeploymentRole",
            description="Role used by the EnergyComparisonTable CDK IaC to deploy to one or more clusters in this account",
        )

        Annotations.of(self.role).add_info(
            "This is the cdk kubectl role used to deploy k8s resources with the cdk. Add it to aws-auth"
        )

        CfnOutput(self, "K8sDeploymentRoleArn", value=self.role.role_arn)
