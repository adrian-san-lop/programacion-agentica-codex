# MCP y credenciales

Buenas prácticas para autenticar servidores MCP sin exponer secretos.

## MCP y credenciales

Un MCP puede necesitar autenticarse contra servicios externos.

Por ejemplo:

```text
MCP
 ↓
Fabric API
 ↓
Azure / Entra ID
```

No es recomendable almacenar secretos directamente en archivos versionados.

Evitar:

```json
{
  "password": "MiPassword123"
}
```

Preferir mecanismos como:

```text
Environment Variables
Secret Stores
Credential Managers
OAuth
Managed Identity
```

dependiendo del entorno.

---



---

[← Anterior](01-configuracion.md) · [Índice](../../README.md) · [Siguiente →](03-mcp-vs-tool-retrieval.md)

