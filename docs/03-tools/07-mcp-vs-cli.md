# MCP vs CLI

MCP y CLI son dos formas de dar capacidades externas a un agente. No son equivalentes ni compiten necesariamente: pueden participar en el mismo Agent Loop.

Para distinguir además Tool, Skill, Command y Tool Retrieval, consulta [Conceptos que no deben confundirse](../00-introduccion/02-conceptos-que-no-deben-confundirse.md).

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
  └── controla la sesión o inicia un procedimiento

Skill
  └── define reglas, pasos, validaciones y criterios de salida

Tool del servidor MCP
  └── ejecuta la operación solicitada mediante el protocolo MCP

Tool de terminal
  └── ejecuta el programa de línea de comandos
```

Por ejemplo, una petición de revisión puede iniciar un procedimiento de Git. La Skill indica qué comprobar y la Tool de terminal ejecuta `git diff`. Un atajo personalizado como `/commit` sólo sería otra entrada si el cliente lo ofreciera; no lo presuponemos disponible en Codex.

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

La distribución Power BI mediante MCP y Git mediante CLI es ilustrativa del curso, no una división obligatoria: un servidor puede ofrecer operaciones Git y un programa de terminal puede consultar un servicio externo. Las capacidades reales dependen de las herramientas y programas disponibles. Consulta [Flujo Git y pull requests](../05-trabajo-en-equipo/05-flujo-git-y-pull-requests.md).

[Continuar con lo esencial: guía de lectura de una tarea →](09-guia-practica-tools-en-codex.md). La estrategia híbrida es opcional.

[← Anterior](06-tool-search.md) · [Índice](../../README.md) · [Siguiente →](08-estrategia-hibrida.md)
