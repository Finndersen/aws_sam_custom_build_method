from aws_lambda_powertools import Tracer

from shared.shared_module import print_event

tracer = Tracer()


@tracer.capture_lambda_handler
def lambda_handler(event, context):
    print_event("B", event)