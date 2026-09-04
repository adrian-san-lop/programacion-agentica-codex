# Trabajo en equipo

Hasta ahora hemos visto cómo funciona un agente y cómo se organiza su contexto. Este capítulo reúne esas piezas para trabajar con Codex en VS Code de forma colaborativa.

El trabajo en equipo tiene dos dimensiones:

```text
Equipo humano
→ repositorio, documentación, ramas, commits y pull requests

Equipo de agentes
→ agente principal, Skills y subagentes
```

MCP, CLI, Skills y subagentes no son alternativas del mismo nivel:

| Elemento | Función |
|---|---|
| `AGENTS.md` | Reglas y mapa de navegación del proyecto |
| `docs/` | Conocimiento y documentación conceptual |
| Skill | Workflow reutilizable |
| Command | Forma breve de iniciar un workflow |
| Tool | Capacidad ejecutable |
| MCP | Protocolo para exponer Tools externas |
| CLI | Interfaz de comandos local |
| Subagente | Agente especializado al que se delega una tarea |

La colaboración funciona mejor cuando cada elemento conserva su responsabilidad y el contexto se entrega progresivamente.

La persona mantiene la responsabilidad de definir el objetivo, revisar las propuestas y aceptar los cambios relevantes. La autonomía del agente describe su capacidad de avanzar dentro de unas reglas; no elimina los permisos ni la supervisión humana.

---

[← Anterior](../04-integraciones/03-mcp-vs-tool-retrieval.md) · [Índice](../../README.md) · [Siguiente →](01-personas-agentes-y-responsabilidades.md)
