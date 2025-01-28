from typing import Any


def print_event(lambda_name: str, event: dict[str, Any]) -> None:
    print(f"Lambda {lambda_name} invoked with event: {event}")