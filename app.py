#!/usr/bin/env python3

import aws_cdk as cdk

from stacks.ecr import EcrRepository

app = cdk.App()
dev_env = cdk.Environment(account="979633842206", region="eu-west-1")

EcrRepository(
    app,
    "EnergyComparisonTableEcrRepo",
    env=dev_env,
)


cdk.Tags.of(app).add("Product", "energy_table_comparison")
app.synth()
