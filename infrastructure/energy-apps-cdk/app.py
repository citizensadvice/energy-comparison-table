#!/usr/bin/env python3

import aws_cdk as cdk
from aws_cdk.aws_iam import AccountPrincipal

from stacks.ecr import EcrRepository

app = cdk.App()

dev_acount = app.node.get_context("dev")["AWS_ACCOUNT"]
prod_acount = app.node.get_context("prod")["AWS_ACCOUNT"]

EcrRepository(
    app,
    "EnergyAppsEcrRepo",
    env=cdk.Environment(account=dev_acount, region="eu-west-1"),
    pull_principals=[AccountPrincipal(prod_acount)],
    tags={"Environment": "prod"},
)

cdk.Tags.of(app).add("Product", "energy_apps")
app.synth()
