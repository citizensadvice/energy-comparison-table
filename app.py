#!/usr/bin/env python3
import os

import aws_cdk as cdk
from aws_cdk.aws_iam import Role

from energy_comparison_table.energy_comparison_table_stack import (
    EnergyComparisonTableStack,
)


app = cdk.App()
stack = EnergyComparisonTableStack(
    app,
    "EnergyComparisonTableStack",
    env=cdk.Environment(account="979633842206", region="eu-west-1"),
)

content_platform_sso_role = Role.from_role_arn(
    stack,
    "CPRoleLookup",
    role_arn="arn:aws:iam::979633842206:role/aws-reserved/sso.amazonaws.com/eu-west-1/AWSReservedSSO_ContentPlatformKubernetesAccess_bf30f39d4ac36a3d",
)
stack.lambda_function.grant_invoke(content_platform_sso_role)
stack.lambda_function.grant_invoke_url(content_platform_sso_role)

cdk.Tags.of(app).add("Product", "energy_tables_comparison")
app.synth()
