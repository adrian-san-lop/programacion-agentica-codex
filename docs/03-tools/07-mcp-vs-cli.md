# MCP vs CLI

MCP y CLI son dos formas de dar capacidades externas a un agente. No son equivalentes ni compiten necesariamente: pueden participar en el mismo Agent Loop.

```text
                         CODEX
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
          AGENTS.md      Skills       Tools
                                         │
                              ┌──────────┴──────────┐
                              ▼                     ▼
                            MCP                    CLI
                              │                     │
                    Power BI / Fabric       Git / scripts / tests
```

## MCP

MCP es apropiado cuando el agente necesita interactuar con un servicio mediante una interfaz estructurada y especializada.

En un proyecto Power BI puede proporcionar operaciones como:

- Inspeccionar el modelo semántico.
- Consultar tablas, medidas y relaciones.
- Ejecutar consultas DAX.
- Crear o modificar elementos soportados por el servidor.

Las capacidades reales dependen de las Tools que exponga el servidor. No se debe dar por hecho que todo Power BI o Fabric está cubierto.

## CLI

CLI significa una interfaz de línea de comandos. El agente suele ejecutar el comando mediante su Tool de shell o terminal.

Es apropiado para:

- `git status`, `git diff` y otras operaciones del repositorio.
- Ejecutar validadores, tests y scripts.
- Convertir o inspeccionar archivos.
- Automatizar tareas del entorno local.

CLI no es una Skill. La Skill explica al agente cuándo y cómo utilizarlo; la Tool de shell ejecuta el comando real.

## Papel de las Skills y Commands

```text
Command
  └── inicia un workflow solicitado por el usuario

Skill
  └── define reglas, pasos, validaciones y criterios de salida

MCP / CLI
  └── ejecutan las operaciones concretas
```

Por ejemplo, `/commit` puede iniciar el workflow, una Skill de Git puede exigir revisión y validación, y la CLI puede ejecutar `git diff` o `git commit`.

Una Skill DAX puede combinar MCP y CLI:

```text
Skill DAX
  ↓
Inspeccionar medida y relaciones       ← MCP
  ↓
Proponer o aplicar cambio               ← MCP
  ↓
Ejecutar DAX de validación              ← MCP
  ↓
Revisar diff del proyecto               ← CLI
  ↓
Ejecutar validador                      ← CLI
```

La separación importante no es elegir uno para todo, sino asignar cada operación al mecanismo que ofrece el contexto, la seguridad y la interfaz adecuados.

---

[← Anterior](06-tool-search.md) · [Índice](../../README.md) · [Siguiente →](08-estrategia-hibrida.md)
