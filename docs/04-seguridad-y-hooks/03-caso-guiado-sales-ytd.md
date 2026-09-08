# Caso guiado: revisar Sales YTD con controles

Este caso une contexto, Tools, permisos y hooks. Es una historia conceptual con capacidades ficticias; no presupone una conexión real ni instala controles.

## Encargo y criterio de salida

> Analiza la medida Sales YTD y explica si hay algún problema. No modifiques nada.

El resultado esperado es una explicación con fuentes y límites. Si falta la expresión o información del modelo, una entrega correcta debe señalarlo.

Supongamos dos capacidades ilustrativas, `consultar_medida` y `modificar_medida`, y una política de revisión que rechaza la segunda en las llamadas cubiertas. Los nombres reales se comprobarían en el servidor instalado.

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

```text
Recibir la llamada cubierta por el evento
Comprobar que corresponde a la política de revisión
Si solicita la capacidad ficticia modificar_medida:
    devolver un rechazo explícito con su motivo
En otro caso:
    no rechazar desde este control
    mantener los demás permisos y políticas
```

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

**¿El rechazo autoriza a intentar la misma escritura con otra herramienta?**

No. El encargo sigue siendo de sólo lectura.

**¿Qué falta para convertir esta historia en una práctica?**

Identificar el entorno, las capacidades y permisos reales; implementar y revisar el control; probar consultas, rechazos y fallos con datos ficticios antes de conectarlo a un modelo de prueba.

---

[← Anterior](02-hooks-en-codex.md) · [Índice](../../README.md) · [Siguiente →](../05-trabajo-en-equipo/00-introduccion.md)
