#!/usr/bin/env python3

import aws_cdk as cdk

from stacks.ecr import EcrRepository

app = cdk.App()

EcrRepository(
    app,
    "EnergyComparisonTableEcrRepo",
    # cita-devops
    env=cdk.Environment(
        account=app.node.get_context("qa")["AWS_ACCOUNT"], region="eu-west-1"
    ),
    tags={"Environment": "prod"},
)

cdk.Tags.of(app).add("Product", "energy_comparison_table")
app.synth()
