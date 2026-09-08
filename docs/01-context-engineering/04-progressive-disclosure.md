# Progressive Disclosure

Patrón para cargar únicamente la información relevante cuando aparece la necesidad.

## Definición

**Progressive Disclosure** consiste en no cargar toda la información desde el principio.

En su lugar:

```text
Contexto mínimo
      ↓
El agente detecta una necesidad
      ↓
Busca información adicional
      ↓
Carga sólo lo relevante
      ↓
Continúa trabajando
```

Objetivos:

```text
menos tokens
+
menos ruido
+
contexto más relevante
+
mejor atención
```

No consiste únicamente en ahorrar tokens.

También busca que el modelo tenga:

> La información correcta, en el momento correcto.

Ejemplo:

```text
❌ Cargar siempre:

DAX
Power Query
SQL
PySpark
Deployment
Testing
Power BI
Fabric
Azure
...

────────────────────────

✅ Progressive Disclosure:

Tarea DAX
   ↓
cargar Skill DAX
   ↓
cargar documentación DAX
   ↓
continuar
```

---

Este patrón también organiza el trabajo colaborativo: `AGENTS.md` apunta a la documentación, las Skills cargan workflows específicos y los subagentes reciben solo el contexto necesario. Consulta [Trabajo en equipo](../05-trabajo-en-equipo/00-introduccion.md).

## Nuestra historia y comprobación

Para revisar Sales YTD, las reglas DAX pueden ser necesarias y las de diseño de tarjetas no. Si después aparece una duda sobre relaciones, se amplía la consulta: seleccionar contexto no significa prohibir toda lectura adicional.

**¿Hay progressive disclosure sólo por dividir un texto en diez archivos?**

No. La división facilita seleccionar, pero hace falta orientar la consulta y comprobar que se lee lo pertinente. Un bajo consumo de contexto tampoco prueba por sí solo una buena respuesta.

[← Anterior](03-dynamic-context.md) · [Índice](../../README.md) · [Siguiente →](05-costes-basicos-de-llm.md)

