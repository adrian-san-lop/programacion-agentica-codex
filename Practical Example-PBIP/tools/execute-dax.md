# Tool: execute_dax

## Objective

Execute a DAX query against the semantic model.

## Parameters

- `query`: DAX query.
- `model`: target semantic model.

## Rules

- Run read-only queries first.
- Limit results to the required columns and rows.
- Do not use this Tool to modify the model.
- Record filters and the analysed period.
