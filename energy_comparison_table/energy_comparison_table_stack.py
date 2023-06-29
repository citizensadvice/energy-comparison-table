from aws_cdk import (
    RemovalPolicy,
    Stack,
)
from aws_cdk.aws_cloudfront import BehaviorOptions, Distribution, OriginAccessIdentity
from aws_cdk.aws_cloudfront_origins import S3Origin
from aws_cdk.aws_ecr_assets import DockerImageAsset, Platform
from aws_cdk.aws_lambda import (
    Architecture,
    DockerImageCode,
    DockerImageFunction,
)
from aws_cdk.aws_s3 import Bucket, BucketAccessControl
from constructs import Construct


class EnergyComparisonTableStack(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # let the cdn access the private bucket
        cdn_identity = OriginAccessIdentity(
            self,
            "OriginAccessIdentity",
            comment=f"Origin identity for {Stack.of(self).stack_name}",
        )

        # where the static website lives
        bucket = Bucket(
            self,
            "Bucket",
            access_control=BucketAccessControl.PRIVATE,
            removal_policy=RemovalPolicy.DESTROY,
        )

        bucket.grant_read(cdn_identity)

        # build and push the lambda image
        # containing the site + ruby runtime
        image = DockerImageAsset(
            self,
            "DockerImage",
            directory="bridgetown",
            platform=Platform.LINUX_AMD64,
        )

        # create a lambda from the image
        site_generator = DockerImageFunction(
            self,
            "Lambda",
            environment={
                "BUCKET_NAME": bucket.bucket_name,
            },
            architecture=Architecture.X86_64,
            code=DockerImageCode.from_ecr(
                repository=image.repository, tag=image.image_tag
            ),
        )

        # the lambda must write to the bucket
        bucket.grant_read_write(site_generator)

        cdn = Distribution(
            self,
            "Cdn",
            default_root_object="index.html",
            default_behavior=BehaviorOptions(
                origin=S3Origin(bucket=bucket, origin_access_identity=cdn_identity)
            ),
        )
        cdn.grant_create_invalidation(site_generator)
        site_generator.add_environment("DISTRIBUTION_ID", cdn.distribution_id)
