import aws_cdk as core
import aws_cdk.assertions as assertions

from energy_comparison_table.energy_comparison_table_stack import EnergyComparisonTableStack

# example tests. To run these tests, uncomment this file along with the example
# resource in energy_comparison_table/energy_comparison_table_stack.py
def test_sqs_queue_created():
    app = core.App()
    stack = EnergyComparisonTableStack(app, "energy-comparison-table")
    template = assertions.Template.from_stack(stack)

#     template.has_resource_properties("AWS::SQS::Queue", {
#         "VisibilityTimeout": 300
#     })
