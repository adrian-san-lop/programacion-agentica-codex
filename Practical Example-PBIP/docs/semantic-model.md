# Accounting semantic model

Complete this document with the actual project names. Do not invent tables, relationships, or measures that do not exist in the model.

## Grain

Document the level of detail of the main table here. For example:

```text
One row represents one general ledger transaction.
```

## Main tables

| Table | Type | Description |
|---|---|---|
| `FactGeneralLedger` | Fact | General ledger transactions |
| `DimDate` | Dimension | Fiscal calendar |
| `DimAccount` | Dimension | Chart of accounts |
| `DimCompany` | Dimension | Group companies |
| `DimCostCenter` | Dimension | Cost centres |

Replace this table with the actual model inventory.

## Critical relationships

Document relationships that affect financial measures:

```text
FactGeneralLedger[DateKey] → DimDate[DateKey]
FactGeneralLedger[AccountKey] → DimAccount[AccountKey]
```

## Important measures

| Measure | Table | Purpose | Dependencies |
|---|---|---|---|
| `Gross Margin` | `Measures` | Gross margin | Sales and cost |
| `Gross Margin YTD` | `Measures` | Year-to-date margin | `Gross Margin`, `DimDate` |

## Open questions

- What is the actual fact table?
- Is there a fiscal calendar?
- Which measures are certified?
- Which relationships are bidirectional, and why?
