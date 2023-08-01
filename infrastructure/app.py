#!/usr/bin/env python3

import aws_cdk as cdk

from stacks.ecr import EcrRepository
from stacks.eks_role import K8sDeploymentRoleStack

app = cdk.App()

# cita-devops
dev_env = cdk.Environment(account="979633842206", region="eu-west-1")
# cab-prod2
prod_env = cdk.Environment(account="912473634278", region="eu-west-1")

EcrRepository(
    app,
    "EnergyComparisonTableEcrRepo",
    env=dev_env,
)

K8sDeploymentRoleStack(app, "DevEnergyComparisonTableEKSRole", env=dev_env)
K8sDeploymentRoleStack(app, "ProdEnergyComparisonTableEKSRole", env=prod_env)


cdk.Tags.of(app).add("Product", "energy_table_comparison")
app.synth()
