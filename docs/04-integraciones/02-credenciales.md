# MCP y credenciales

Buenas prácticas para autenticar servidores MCP sin exponer secretos.

## MCP y credenciales

Un MCP puede necesitar autenticarse contra servicios externos.

Por ejemplo:

```text
MCP
 ↓
Servicio de Fabric
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

La identidad utilizada por el servidor para acceder a Fabric puede ser distinta de la cuenta Business con la que iniciamos sesión en Codex. Debemos comprobar qué cuenta y permisos usa la conexión para el modelo concreto; la suscripción no concede por sí sola acceso al servicio.

Usar una variable de entorno o un gestor de credenciales no garantiza que el valor nunca se exponga: un proceso puede imprimirlo o incluirlo en un resultado. Preferimos que la conexión utilice la credencial sin devolver su valor al modelo. El capítulo de [permisos, sandbox y secretos](../04-seguridad-y-hooks/01-permisos-sandbox-y-secretos.md) desarrolla este recorrido.

## Comprueba que lo entiendes

**¿Estar autenticado en Codex demuestra que puedo modificar un modelo de Fabric?**

No. Hay que comprobar la identidad y los permisos de la conexión al modelo, además del alcance autorizado de la tarea.

---

[← Anterior](01-configuracion.md) · [Índice](../../README.md) · [Siguiente →](03-mcp-vs-tool-retrieval.md)

