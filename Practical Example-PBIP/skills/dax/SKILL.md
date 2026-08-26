# Skill: DAX

## When to use

Use for creating, reviewing, explaining, or optimising DAX measures and expressions.

## Procedure

1. Identify the measure and its table.
2. Read `docs/semantic-model.md`.
3. Inspect the tables, columns, and relationships used.
4. Analyse filter context, row context, and context transition.
5. Review performance and readability.
6. Propose the modification with a functional explanation.
7. Validate results across several periods and filters.

## Precautions

- Do not change semantics without stating it.
- Do not assume a relationship exists because column names match.
- Do not delete a measure before checking its dependencies.
- Do not apply destructive changes without approval.

## Delivery format

```text
Affected measure:
Problem found:
Proposed change:
Functional impact:
Validation performed:
Files changed:
```
