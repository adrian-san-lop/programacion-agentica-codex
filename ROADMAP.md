# Roadmap de programación agéntica

## Objetivo y alcance

Ayudar a un data scientist con experiencia en programación y Power BI, pero sin experiencia agéntica, a comprender, orientar y evaluar Codex en VS Code con una suscripción de ChatGPT Business.

La fase actual es conceptual. Power BI y Fabric aportan contexto familiar; la integración real llegará cuando el curso alcance la práctica.

Quedan fuera la documentación de la API de OpenAI, sus ejemplos, parámetros, endpoints, precios y enlaces, también como comparaciones o ampliaciones. No construiremos otro runtime ni conectaremos la simulación Python a un proveedor.

## Cómo incorporar nuevas notas

1. Capturar dudas y contenido del curso en [notes.txt](docs/notes.txt).
2. Comprobar si ayuda a entender al agente, orientar a Codex o evaluar su trabajo.
3. Separar patrón general, capacidad documentada de Codex, observación local e inferencia.
4. Verificar las afirmaciones de producto con documentación oficial de Codex.
5. Incorporar sólo lo que encaje en la fase del curso y actualizar este roadmap.

Las notas históricas pueden contener referencias fuera de alcance o afirmaciones aún no verificadas. Se conservan como material de captura, no como instrucciones para añadirlas al temario.

## Estados

- **Cubierto:** explicación disponible; no implica validación práctica.
- **Parcial:** hay una base, pero faltan aspectos concretos.
- **Pendiente:** aún no desarrollado.
- **Futuro:** reservado para otra fase.
- **Investigación:** necesita evidencia de producto o de la instalación.

## Situación actual

| Bloque | Estado | Evidencia y siguiente paso |
|---|---|---|
| Objetivo y Agent Loop | Cubierto | [Introducción](docs/00-introduccion/00-que-es-un-agente.md): script frente a agente, responsabilidades y condiciones de parada |
| Vocabulario | Cubierto como base | [Conceptos](docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md): revisar comprensión con un lector principiante |
| Contexto y recuperación | Cubierto como base conceptual | [Recuperación](docs/01-context-engineering/07-recuperacion-profunda.md): pertinencia, vigencia, suficiencia y fuentes contradictorias |
| Consumo y caching | Cubierto al nivel necesario | [Uso](docs/01-context-engineering/05-costes-basicos-de-llm.md) y [caching opcional](docs/01-context-engineering/06-prompt-caching.md); sin ejercicios de infraestructura |
| Compactación | Cubierto conceptualmente | [Continuidad de la sesión](docs/01-context-engineering/08-compactacion-de-contexto-en-codex.md): validar en la práctica sin dar por preservado cada detalle |
| Instrucciones y Skills | Cubierto como base | [Componentes](docs/02-componentes/00-system-prompt.md): reglas, procedimiento y conocimiento separados |
| Tools y errores | Cubierto como base | [Guía conceptual](docs/03-tools/09-guia-practica-tools-en-codex.md): una descripción no crea una Tool |
| Frontera de control | Cubierto | [Codex por suscripción](docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md): qué configura la persona y qué no puede deducirse |
| MCP | Parcial | [Introducción](docs/04-integraciones/00-mcp-introduccion.md); conexión real de Power BI pendiente de validar en la fase práctica |
| Colaboración y Git | Cubierto como base | [Trabajo en equipo](docs/05-trabajo-en-equipo/00-introduccion.md) |
| Subagentes | Parcial | [Delegación](docs/05-trabajo-en-equipo/04-subagentes-y-delegacion.md); ampliar cuándo no delegar y cómo revisar resultados |
| Simulación Python | Material opcional disponible | [Ejemplo](docs/06-ejemplos/00-agent-loop-minimo.md); sólo ilustra la mecánica, no interpreta lenguaje libre |
| Power BI / Fabric | Futuro — fase práctica | [Plantilla y recorrido](docs/06-ejemplos/01-power-bi-fabric.md); no hay una integración completa validada |

## 1. Validar la comprensión antes de ampliar

**Estado: Pendiente de prueba con el alumno.**

Utilizar la historia «Analiza Sales YTD. No modifiques nada» y comprobar que el lector puede explicar:

- qué información falta y dónde buscarla;
- quién propone, quién coordina y quién ejecuta;
- por qué una Skill no sustituye a una Tool;
- qué hacer si faltan datos o hay un rechazo;
- por qué una propuesta no autoriza una escritura;
- cuándo hay suficiente evidencia para terminar.

Si hay dudas, mejorar la explicación antes de añadir términos.

## 2. Recuperación de contexto en una sesión observable

**Estado: Futuro — validación práctica.**

Comparar tareas equivalentes en Codex observando fuentes consultadas, repeticiones, información faltante, errores y calidad final. Registrar tiempo e indicadores de uso sólo cuando el cliente los muestre.

No reconstruir una petición interna ni exigir puntuaciones de relevancia. Un indicador bajo de contexto no demuestra, por sí solo, una mejor recuperación.

## 3. Seguridad y evaluación

**Estado: Parcial.**

Consolidar ejemplos de contenido no confiable, permisos, lectura frente a escritura y protección de secretos.

Más adelante, preparar un conjunto pequeño de tareas con criterios de aceptación: respuesta correcta, evidencia suficiente, restricciones respetadas y límites declarados. Registrar regresiones al cambiar instrucciones o Skills.

## 4. Capacidades de Codex que requieren mantenimiento

**Estado: Investigación continua, no requisito para empezar.**

| Capacidad | Base de consulta | Comprobación pendiente |
|---|---|---|
| Instrucciones | [AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md) | Mantener ámbitos y precedencia al cambiar el producto |
| Skills | [Build skills](https://learn.chatgpt.com/docs/build-skills) | Verificar disponibilidad y selección en la instalación |
| MCP | [MCP](https://learn.chatgpt.com/docs/extend/mcp) | Registrar servidor, cuenta, destino y operaciones reales |
| Compactación | [Comandos IDE](https://learn.chatgpt.com/docs/developer-commands?surface=ide) | Observar continuidad y límites del resumen |
| Tool Retrieval | [Límites de lo observable](docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md) | No atribuir una estrategia interna sin evidencia específica |

Fecha de revisión de estas fuentes: 2026-09-07. Entorno objetivo: extensión IDE de Codex para VS Code, suscripción Business. Esta revisión documental no sustituye una prueba local con Power BI.

Para nuevas comprobaciones registrar versión, fecha, configuración relevante, acción visible, resultado y fuente. No usar comportamientos de otros clientes como evidencia de Codex.

## 5. Delegación y modos de trabajo

**Estado: Parcial / pendiente según el tema.**

Cuando aparezcan en el curso:

- explicar cuándo una tarea puede aislarse para delegar y cuándo no;
- definir el contexto y criterio de entrega del subagente;
- revisar coordinación y resultados;
- distinguir planificación, análisis e implementación según los modos realmente disponibles;
- introducir hooks sólo si ayudan a comprender controles alrededor del Agent Loop.

No asumir nombres ni capacidades idénticos entre productos.

## 6. Práctica Power BI / Fabric

**Estado: Futuro.**

Cuando llegue el momento:

1. Preparar el proyecto PBIP y completar los datos de la plantilla.
2. Verificar la conexión y las capacidades reales en Codex.
3. Revisar Sales YTD en sólo lectura.
4. Contrastar las conclusiones con el modelo.
5. Solicitar una modificación acotada sólo si se desea.
6. Validar resultados, revisar cambios y registrar decisiones.

El éxito será una tarea fiable y revisable, no un porcentaje de ahorro de tokens.

## Registro de actualizaciones

| Fecha | Decisión | Resultado |
|---|---|---|
| 2026-09-03 | Crear seguimiento desde notas | Roadmap inicial |
| 2026-09-07 | Alinear el objetivo con Codex en VS Code mediante Business | Exclusión de contenido de la API; fundamentos y ampliaciones separados; caso conceptual compartido y comprobaciones de comprensión |
