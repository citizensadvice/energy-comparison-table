from aws_cdk import Duration, RemovalPolicy, Stack
from aws_cdk.aws_ecr import LifecycleRule, Repository, TagStatus
from constructs import Construct


class EcrRepository(Stack):
    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        Repository(
            self,
            "Default",
            removal_policy=RemovalPolicy.DESTROY,
            auto_delete_images=True,
            image_scan_on_push=True,
            repository_name="energy-comparison-table",
            lifecycle_rules=[
                LifecycleRule(
                    description="Delete untagged images",
                    max_image_age=Duration.days(3),
                    tag_status=TagStatus.UNTAGGED,
                    rule_priority=1,
                ),
                LifecycleRule(
                    description="Delete dev images",
                    max_image_age=Duration.days(30 * 3),
                    tag_prefix_list=["dev_"],
                    rule_priority=2,
                ),
            ],
        )
