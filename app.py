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

devs_sso_role = Role.from_role_arn(
    stack,
    "CPRoleLookup",
    role_arn="arn:aws:iam::979633842206:role/aws-reserved/sso.amazonaws.com/eu-west-1/AWSReservedSSO_DeveloperAccess_01b2760b4a4ce7c9",
)
stack.lambda_function.add_permission("LetDevsInvokeIt", principal=devs_sso_role)

cdk.Tags.of(app).add("Product", "energy_tables_comparison")
app.synth()
