from typing import Sequence
from aws_cdk import RemovalPolicy, Stack
from aws_cdk.aws_ecr import Repository
from aws_cdk.aws_iam import IPrincipal
from constructs import Construct
from ca_cdk_constructs.ecr.ecr_repository import ECRRepository


class EcrRepository(Stack):
    def __init__(
        self,
        scope: Construct,
        id: str,
        pull_principals: Sequence[IPrincipal] = [],
        **kwargs
    ) -> None:
        super().__init__(scope, id, **kwargs)

        repo: Repository = ECRRepository(
            self, "Default", name="energy-comparison-table"
        ).repository

        repo.apply_removal_policy(RemovalPolicy.DESTROY)

        for principal in pull_principals:
            repo.grant_pull(principal)
