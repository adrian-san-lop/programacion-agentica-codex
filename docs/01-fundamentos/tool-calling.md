# Tool Calling

Cómo solicita el modelo una acción y cómo se ejecuta realmente.

# 4. Tools / Herramientas

Las **Tools** son capacidades que el agente puede utilizar para interactuar con su entorno.

Ejemplos:

```text
read_file()
write_file()

execute_sql()

list_measures()
get_measure()
create_measure()
update_measure()

execute_dax()
```

Una Tool suele tener:

- Nombre.
- Descripción.
- Parámetros de entrada.
- Schema de dichos parámetros.
- Opcionalmente, descripción de su resultado.

Ejemplo conceptual:

```json
{
  "name": "execute_dax",
  "description": "Executes a DAX query against a semantic model",
  "parameters": {
    "semantic_model": "string",
    "query": "string"
  }
}
```

El LLM necesita conocer suficiente información sobre una Tool para poder solicitar correctamente su ejecución.

---

---

# 5. Tool Call

Una **Tool Call** es una solicitud del LLM para utilizar una herramienta.

Ejemplo:

```text
Usuario:

"¿Cuántas ventas tuvimos este año?"
```

El LLM puede razonar:

```text
Necesito consultar el modelo semántico.
```

Y solicitar:

```text
execute_dax(
    semantic_model="Sales",
    query="..."
)
```

Pero el LLM **no ejecuta realmente `execute_dax()`**.

El flujo es:

```text
LLM
 │
 │ solicita Tool Call
 ▼
Agente / Orquestador
 │
 │ valida y ejecuta
 ▼
Tool
 │
 ▼
Power BI / Fabric
 │
 │ resultado
 ▼
Tool
 │
 ▼
Agente
 │
 │ añade resultado al contexto
 ▼
LLM
```

Por tanto:

> El LLM decide qué Tool quiere utilizar.
>
> El agente/orquestador ejecuta realmente la Tool.

---

