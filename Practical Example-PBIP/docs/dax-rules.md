# DAX rules

## Conventions

- Use English measure names unless the project defines another convention.
- Prefer explicit measures over calculated columns when the calculation depends on context.
- Keep measures grouped in a measures table if the model follows that pattern.
- Document complex financial measures.

## Performance

- Avoid iterating over complete tables when a more selective alternative exists.
- Review relationships and filter propagation before changing an expression.
- Do not optimise only for shorter expressions; preserve semantics.

## Validation

At a minimum, compare:

- Grand total.
- Monthly periods.
- YTD values.
- Filters by company, account, and cost centre.
- Empty and blank-value cases.

## Safety rule

If the functional intent of a measure is unknown, analyse and propose; do not replace it automatically.
