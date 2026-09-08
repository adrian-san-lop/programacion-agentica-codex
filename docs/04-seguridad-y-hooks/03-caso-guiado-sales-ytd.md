# Caso guiado: revisar Sales YTD con controles

Este caso une contexto, Tools, permisos y hooks. Es una historia conceptual con capacidades ficticias; no presupone una conexión real ni instala controles.

## Encargo y criterio de salida

> Analiza la medida Sales YTD y explica si hay algún problema. No modifiques nada.

El resultado esperado es una explicación con fuentes y límites. Si falta la expresión o información del modelo, una entrega correcta debe señalarlo.

Supongamos dos capacidades ilustrativas, `consultar_medida` y `modificar_medida`, y una política de revisión que rechaza la segunda en las llamadas cubiertas. Los nombres reales se comprobarían en el servidor instalado.

## Del aviso a una comprobación

En el capítulo anterior conectamos `SessionStart` con un script que devolvía un aviso. Ahora conectamos `PreToolUse` con un programa que revisa una operación antes de ejecutarla.

| Pieza | Qué usaríamos en esta historia |
|---|---|
| Evento ofrecido por Codex | `PreToolUse` |
| Configuración que prepararíamos | Seleccionar las dos capacidades ficticias y ejecutar nuestro programa |
| Programa propio | `revisar-operacion.ps1`, con la regla de sólo lectura |
| Datos entregados por Codex | Nombre de la Tool y argumentos |
| Resultado del programa | Rechazar la modificación o no rechazar desde este control |

`revisar-operacion.ps1` es un nombre elegido para explicar el caso, no una función predefinida de OpenAI. La política tampoco se instala automáticamente por escribir «no modifiques nada» en el prompt. Seguimos una configuración hipotética activa y revisada.

## Recorrido

| Paso | Qué sucede | Qué revisamos |
|---|---|---|
| 1 | Codex consulta instrucciones y reglas DAX | Que correspondan al proyecto |
| 2 | El modelo propone consultar Sales YTD | Identidad del modelo y nombre de la medida |
| 3 | El control previo no rechaza la consulta | Esto no sustituye los permisos de conexión |
| 4 | La Tool devuelve la expresión | Si es suficiente o hacen falta relaciones |
| 5 | El modelo propone modificarla | La propuesta excede el encargo |
| 6 | Un hook activo rechaza esa llamada cubierta | La Tool de escritura no llega a ejecutarse por esa vía |
| 7 | Codex explica la mejora propuesta y el límite | No busca otra vía para realizar la escritura |

El paso 5 representa un desvío posible que queremos comprender. Un agente que siga correctamente el encargo puede completar la revisión sin proponer ninguna llamada de escritura.

## Lógica conceptual del control

Supongamos que Codex entrega este extracto de evento. Los nombres y argumentos de las herramientas son ficticios:

```json
{
  "hook_event_name": "PreToolUse",
  "tool_name": "modificar_medida",
  "tool_input": { "measure": "Sales YTD" }
}
```

Nuestro programa lee esos campos y aplica la regla que hemos escrito:

```text
Recibir la llamada cubierta por el evento
Comprobar que corresponde a la política de revisión
Si solicita la capacidad ficticia modificar_medida:
    devolver un rechazo explícito con su motivo
En otro caso:
    no rechazar desde este control
mantener los demás permisos y políticas
```

Al detectar `modificar_medida`, el programa devuelve esta salida admitida por Codex:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Esta revisión sólo permite consultar la medida."
  }
}
```

La regla de nuestro programa produce el rechazo. Codex interpreta `deny` e impide esa llamada cubierta. El modelo recibe el motivo y puede explicar la propuesta sin ejecutarla. [Resultado de PreToolUse](https://learn.chatgpt.com/docs/hooks#pretooluse).

Si la llamada es `consultar_medida`, el programa puede terminar correctamente sin salida: este hook no la rechaza y siguen aplicándose los demás controles. Esto no concede un permiso de acceso que la conexión no tenga.

En este evento, devolver `permissionDecision: "ask"` no solicita aprobación: actualmente es una salida no admitida que puede provocar un fallo y dejar continuar la llamada. Por eso el caso enseña un rechazo explícito, con un resultado definido. [Contrato del evento](https://learn.chatgpt.com/docs/hooks#pretooluse).

Esta lógica ilustra el alcance de una comprobación. No busca palabras en un comando ni garantiza cubrir todas las vías de escritura. Otra Tool, un script o una integración diferente exigirían revisar su cobertura y sus permisos.

Si no podemos conocer con fiabilidad qué operación representa la llamada, no podemos afirmar que este control la clasifique correctamente. La política y su implementación deben revisarse antes de utilizarlas.

## Qué demostraría una prueba posterior

| Observación | Conclusión que permite |
|---|---|
| Existe un archivo de configuración | Se ha escrito una configuración |
| El hook aparece cargado y confiable | Está disponible para sus eventos compatibles |
| Una prueba de rechazo evita una ejecución ficticia | Funciona ese caso por esa vía |
| Un error del programa aparece en la interfaz | Hubo un fallo; falta comprobar si la operación continuó |
| El estado del modelo permanece igual | No se observan cambios en la comparación realizada |

Un diff local vacío no demuestra por sí solo que el modelo remoto permanezca igual. La comprobación debe hacerse sobre el sistema que podría haber recibido el cambio.

## Entrega al usuario

```text
Fuentes utilizadas:
Hallazgos comprobados:
Mejora propuesta:
Datos que faltan:
Operaciones rechazadas y motivo, si las hubo:
Cambios realizados y comprobación disponible:
```

## Comprueba que lo entiendes

Para relacionar estos controles con las decisiones del agente, sigue la [revisión narrada de Sales YTD](04-lectura-guiada-decisiones-sales-ytd.md): un recorrido completo explicado y dos variaciones que muestran cómo cambia la respuesta al faltar información o aparecer una instrucción sospechosa. No se ejecutan herramientas.

**¿El rechazo autoriza a intentar la misma escritura con otra herramienta?**

No. El encargo sigue siendo de sólo lectura.

**¿Qué falta para convertir esta historia en una práctica?**

Identificar el entorno, las capacidades y permisos reales; implementar y revisar el control; probar consultas, rechazos y fallos con datos ficticios antes de conectarlo a un modelo de prueba.

---

[← Anterior](02-hooks-en-codex.md) · [Índice](../../README.md) · [Siguiente →](../05-trabajo-en-equipo/00-introduccion.md)
