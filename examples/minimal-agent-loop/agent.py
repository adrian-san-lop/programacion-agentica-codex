"""Minimal Agent Loop without external dependencies.

The model is simulated so the example can run locally and expose the mechanics
without requiring an API key or a provider-specific SDK.
"""

import json
from typing import Any


def calculate(operation: str, a: float, b: float) -> float:
    """Tool implementation executed by the runtime."""
    if operation == "add":
        return a + b
    if operation == "multiply":
        return a * b
    raise ValueError(f"Unsupported operation: {operation}")


def model(messages: list[dict[str, Any]]) -> dict[str, Any]:
    """Deterministic model stand-in: request a tool, then use its result."""
    if messages[-1]["role"] == "user":
        return {
            "type": "tool_call",
            "name": "calculate",
            "arguments": {"operation": "multiply", "a": 6, "b": 7},
        }
    return {"type": "final", "content": f"El resultado es {messages[-1]['content']}."}


def validate_tool_call(call: dict[str, Any]) -> None:
    """Runtime validation for the selected Tool and its arguments."""
    if call["name"] != "calculate":
        raise ValueError("Tool no disponible")
    arguments = call["arguments"]
    if arguments["operation"] not in {"add", "multiply"}:
        raise ValueError("Operación no permitida")
    if not all(isinstance(arguments[key], (int, float)) for key in ("a", "b")):
        raise TypeError("Los operandos deben ser numéricos")


def run_agent(user_request: str) -> str:
    messages: list[dict[str, Any]] = [{"role": "user", "content": user_request}]

    for _ in range(3):
        response = model(messages)
        print("MODEL:", json.dumps(response, ensure_ascii=False))

        if response["type"] == "final":
            return response["content"]

        validate_tool_call(response)
        result = calculate(**response["arguments"])
        messages.append({"role": "tool", "name": response["name"], "content": result})
        print("RUNTIME: Tool ejecutada ->", result)

    raise RuntimeError("Se alcanzó el límite de iteraciones")


if __name__ == "__main__":
    print("USER: ¿Cuánto es 6 por 7?")
    print("FINAL:", run_agent("¿Cuánto es 6 por 7?"))
