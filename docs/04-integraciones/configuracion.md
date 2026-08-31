# Configuración de MCP

La configuración indica al cliente cómo conectarse a un servidor MCP.

## Configuración de un MCP

Dependiendo del cliente, la configuración puede vivir en:

```text
config.toml
mcp.json
settings.json
...
```

Por ejemplo, conceptualmente en Codex:

```toml
[mcp_servers.powerbi]
command = "..."
args = ["..."]
```

Esto significa:

```text
Codex
   ↓
conéctate a este MCP
   ↓
Power BI MCP
   ↓
expone sus capacidades
```

IMPORTANTE:

```text
MCP
≠
mcp.json
```

MCP es el **protocolo**.

`mcp.json`, `config.toml`, etc. son mecanismos de configuración utilizados por diferentes clientes.

---



---

[← Anterior](mcp-introduccion.md) · [Índice](../../README.md) · [Siguiente →](credenciales.md)

