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

## La Tool como contrato de una capacidad

Para entender una Tool no basta con conocer su nombre. Hay que distinguir tres niveles:

```text
Catálogo
  → sabemos que `get_measure` existe
Contrato
  → sabemos qué argumentos acepta y qué devuelve
Invocación
  → se solicita su ejecución con valores concretos
```

El runtime puede rechazar una invocación aunque el modelo la haya propuesto: el nombre puede no estar disponible, faltar argumentos, haber tipos incorrectos o no existir permiso para realizar la operación. La Tool describe una capacidad; no concede por sí misma autorización.

En Power BI, `get_measure` y `update_measure` pueden parecer similares por el nombre, pero tienen riesgos distintos: una consulta una definición y la otra puede cambiar el proyecto o el modelo. Esta diferencia debe formar parte del diseño y de la revisión humana.

---

[← Anterior](../02-componentes/03-commands.md) · [Índice](../../README.md) · [Siguiente →](01-tool-calling.md)

