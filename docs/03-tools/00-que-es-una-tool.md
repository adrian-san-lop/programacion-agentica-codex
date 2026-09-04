# Qué es una Tool

## Definición

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

[← Anterior](../02-componentes/03-commands.md) · [Índice](../../README.md) · [Siguiente →](01-tool-calling.md)

