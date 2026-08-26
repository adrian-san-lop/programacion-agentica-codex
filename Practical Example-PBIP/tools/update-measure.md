# Tool: update_measure

## Objective

Update the expression and, if applicable, the documentation of an existing measure.

## Parameters

- `table`: table containing the measure.
- `measure`: measure name.
- `expression`: new DAX expression.
- `description`: optional updated description.

## Rules

- Requires approval before execution.
- Keep a comparison with the previous expression.
- Validate dependencies and results after the change.
