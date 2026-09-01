# Guía práctica de Tools en Codex para VS Code

Esta guía reúne el flujo completo para descubrir, cargar y ejecutar Tools cuando trabajamos con **Codex dentro de VS Code**. El objetivo es distinguir el patrón conceptual de las capacidades concretas que ofrece cada runtime.

## 1. Flujo canónico

Un agente no ejecuta directamente una Tool porque el usuario la mencione. El runtime y el modelo colaboran en varias fases. El siguiente diagrama resume el flujo completo:

![Flujo canónico de ejecución de Tools en Codex para VS Code](../../assets/images/tools/codex-tools-flow.png)

La decisión del modelo no equivale a la ejecución. El agente o runtime es responsable de aplicar permisos, validar argumentos y ejecutar la operación autorizada.

## 2. Tres capas que no deben confundirse

### Catálogo

Es el inventario mínimo que permite saber que existe una capacidad:

```text
execute_query → ejecutar una consulta contra PostgreSQL
describe_table → obtener la estructura de una tabla
```

Puede incluir nombre, descripción breve, categoría, palabras clave o metadatos. Su objetivo es facilitar el descubrimiento con poco contexto.

### Definición o contrato

Es la información necesaria para utilizar la Tool correctamente:

```json
{
  "name": "execute_query",
  "description": "Execute a read-only SQL query",
  "parameters": {
    "type": "object",
    "properties": {
      "query": { "type": "string" }
    },
    "required": ["query"]
  }
}
```

Incluye descripción, schema de argumentos, restricciones, ejemplos y posibles errores. No debería cargarse para todas las Tools si no es necesario.

### Invocación y resultado

La invocación es la llamada concreta que el modelo propone y el agente valida:

```text
Tool Call: execute_query
Arguments: { "query": "SELECT count(*) FROM users" }
```

El resultado vuelve al modelo como contexto dinámico. El modelo puede responder al usuario o solicitar otra Tool si el objetivo aún no está cumplido.

## 3. Aplicación en VS Code con Codex

En este proyecto VS Code proporciona la interfaz y Codex actúa como agente. Las extensiones o servidores conectados pueden exponer Tools MCP; el terminal permite ejecutar CLI y scripts. Las Skills y `AGENTS.md` describen reglas y procedimientos, pero no son Tools por sí mismas.

La [extensión IDE de Codex](https://developers.openai.com/codex/ide) debe considerarse el punto de entrada de la sesión. La disponibilidad concreta de Tools, búsqueda y aprobación depende de la versión instalada, la configuración y los servidores conectados.

No se debe asumir que Codex reproduce el mecanismo interno de Filesystem Retrieval de Cursor ni el Tool Search de Claude. En cada instalación hay que comprobar qué capacidades aparecen realmente en el panel de Codex y qué operaciones puede ejecutar el agente.

## 4. Implementar Filesystem Retrieval de forma portable

Cuando el runtime no ofrece una búsqueda nativa de Tools, se puede versionar un catálogo ligero dentro del workspace:

```text
tools/
└── postgres/
    ├── index.md
    ├── execute-query.md
    └── describe-table.md
```

`index.md` contiene únicamente el inventario resumido:

```markdown
# PostgreSQL Tools

- `execute_query`: ejecutar consultas SQL de solo lectura.
- `describe_table`: consultar columnas y tipos de una tabla.
```

`execute-query.md` contiene el contrato completo, por ejemplo:

```markdown
# execute_query

## Propósito

Ejecuta una consulta SQL de solo lectura contra la base de datos configurada.

## Argumentos

- `query` (string, obligatorio): consulta SQL.
- No permite `INSERT`, `UPDATE`, `DELETE`, `DROP` ni sentencias múltiples.

## Resultado

Devuelve filas y metadatos de columnas.
```

El flujo portable sería:

1. El usuario pregunta: “¿Cuántos usuarios hay registrados?”.
2. Codex identifica que necesita consultar una base de datos.
3. El agente busca `execute_query` en el índice.
4. Lee `execute-query.md` para cargar el contrato completo.
5. El modelo propone la llamada y sus argumentos.
6. El agente valida la consulta y la ejecuta mediante el MCP autorizado.
7. El resultado se devuelve al modelo para redactar la respuesta.

En Codex, esta búsqueda puede apoyarse en las Tools de filesystem disponibles, `rg`, una Skill o un índice propio. El hecho de que los archivos existan en el workspace no garantiza por sí solo que el modelo los haya leído.

## 5. Seguridad del contexto recuperado

Un archivo recuperado es información para razonar, no una autorización automática. Puede estar desactualizado, contener errores o incluir instrucciones maliciosas.

Aplicar siempre estas reglas:

- Separar documentación, datos y políticas de ejecución.
- No permitir que una definición recuperada eleve permisos o cambie las reglas del agente.
- Validar el nombre de la Tool y sus argumentos contra el contrato real.
- Aplicar allowlists para operaciones destructivas o con acceso a datos sensibles.
- Solicitar aprobación humana antes de escribir, borrar, publicar o modificar sistemas externos.
- Tratar el contenido del workspace como potencialmente no confiable si procede de terceros.
- No desactivar validación TLS ni registrar secretos en prompts, resultados o trazas.
- Registrar la Tool lógica, identidad, operación, resultado resumido, latencia y motivo de rechazo, sin almacenar credenciales.

El patrón de Filesystem Retrieval amplía el contexto dinámico, pero también amplía la superficie de prompt injection. La recuperación debe reducir contexto, no eliminar controles.

## 6. Medición y comparación

No es correcto trasladar directamente a Codex porcentajes publicados por Cursor o Anthropic. Las cifras dependen del modelo, runtime, catálogo, caché, tarea y metodología.

Para comparar una estrategia en este proyecto, registrar al menos:

| Métrica | Qué indica |
|---|---|
| Tokens de contexto inicial | Coste de cargar prompt, catálogo y reglas |
| Tokens totales | Coste completo de descubrimiento y ejecución |
| Latencia | Tiempo añadido por búsqueda y carga del contrato |
| Tools recuperadas | Precisión y tamaño de la selección |
| Tool Calls inválidas | Calidad del contrato y de la validación |
| Tasa de éxito | Porcentaje de tareas completadas correctamente |
| Aprobaciones y rechazos | Riesgo operativo y fricción para el usuario |
| Coste | Impacto económico del workflow |

La comparación mínima debería ejecutar el mismo conjunto de tareas con tres configuraciones:

1. Todas las definiciones upfront.
2. Catálogo ligero más Filesystem Retrieval.
3. Tool Search nativo, si el runtime utilizado lo ofrece.

El resultado debe incluir calidad, coste y latencia. Ahorrar tokens no compensa recuperar una Tool incorrecta o ejecutar una operación insegura.

## 7. Tabla de decisión

| Necesidad | Mecanismo recomendado en VS Code + Codex |
|---|---|
| Tool crítica y usada en casi todas las tareas | Definición upfront |
| Muchas Tools especializadas | Catálogo ligero y retrieval |
| Búsqueda gestionada por el runtime | Tool Search, solo si está disponible y verificado |
| Operaciones sobre el repositorio | CLI, terminal y Skills |
| Operaciones estructuradas sobre Power BI | MCP conectado al modelo o servicio autorizado |
| Procedimiento reutilizable | Skill |
| Inicio explícito de un workflow | Command o petición explícita al agente |
| Documentación o métricas de negocio | Archivos versionados y recuperación bajo demanda |

La decisión debe considerar también permisos, auditabilidad, latencia, coste y facilidad de mantenimiento.

## 8. Regla práctica para este repositorio

Para trabajar con Codex en VS Code:

1. Mantener las reglas generales en `AGENTS.md`.
2. Mantener procedimientos reutilizables en `skills/`.
3. Usar MCP para capacidades estructuradas de Power BI/Fabric.
4. Usar CLI para Git, validadores, tests y scripts locales.
5. Usar archivos de documentación para el conocimiento de negocio que no deba cargarse siempre.
6. Pedir a Codex que compruebe las Tools disponibles antes de asumir que existe una capacidad.
7. Revisar y validar cada Tool Call antes de permitir efectos externos.

La configuración y los servidores MCP concretos de este proyecto se documentan en [Configuración de MCP en Codex para VS Code](../04-integraciones/01-configuracion.md).

---

[← Anterior](08-estrategia-hibrida.md) · [Índice](../../README.md) · [Siguiente →](../04-integraciones/00-mcp-introduccion.md)
