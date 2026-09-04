# Estrategia híbrida de Tools

Las herramientas frecuentes pueden cargarse upfront y las especializadas bajo demanda.

## Estrategia híbrida

Upfront y Retrieval tampoco tienen por qué ser 100 % excluyentes.

Se pueden combinar.

Por ejemplo:

```text
100 Tools disponibles
        │
        ├── 5 Tools fundamentales
        │       ↓
        │    Upfront
        │
        └── 95 Tools especializadas
                ↓
             Retrieval
```

El LLM podría tener siempre disponibles:

```text
read_file()
search()
list_directory()
tool_search()
get_help()
```

Y descubrir dinámicamente herramientas más específicas:

```text
execute_dax()
create_measure()
update_relationship()
deploy_semantic_model()
...
```

Esto permite equilibrar:

```text
simplicidad
+
flexibilidad
+
consumo de contexto
```

---

## Tool Calling después de Upfront o Retrieval

Independientemente de cómo haya conocido la Tool el LLM:

```text
             Upfront
                │
                │
                ▼
              TOOL
                ▲
                │
                │
            Retrieval
```

una vez dispone de suficiente información:

```text
LLM
 ↓
Tool Call
 ↓
Agente / Orquestador
 ↓
valida
 ↓
ejecuta Tool
 ↓
resultado
 ↓
LLM
```

Si el LLM necesita más información:

```text
resultado
   ↓
LLM
   ↓
"Necesito otra Tool"
   ↓
Tool Call
   ↓
resultado
   ↓
LLM
```

Eso forma parte del **Agent Loop**.

---

## Resumen del ciclo completo de Tools

La representación correcta es:

```text
                    TOOLS DISPONIBLES
                           │
                           ▼
                ¿Cómo las conoce el LLM?
                           │
              ┌────────────┴────────────┐
              │                         │
              ▼                         ▼
           UPFRONT                  RETRIEVAL
              │                         │
     schemas completos        descubrir relevantes
       desde inicio              y cargar schemas
              │                         │
              └────────────┬────────────┘
                           │
                           ▼
                   LLM conoce la Tool
                           │
                           ▼
                       TOOL CALL
                           │
                           ▼
                  AGENTE / ORQUESTADOR
                           │
                           ▼
                         TOOL
                           │
                           ▼
                    SISTEMA EXTERNO
                           │
                           ▼
                       RESULTADO
                           │
                           ▼
                          LLM
                           │
                   ¿Objetivo cumplido?
                      │          │
                     SÍ         NO
                      │          │
                      ▼          └──────┐
                  RESPUESTA             │
                                       ▼
                                  NUEVA TOOL CALL
```

---


[← Anterior](07-mcp-vs-cli.md) · [Índice](../../README.md) · [Siguiente →](09-guia-practica-tools-en-codex.md)

