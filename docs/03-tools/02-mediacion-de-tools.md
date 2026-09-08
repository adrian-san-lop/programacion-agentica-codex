# Mediación de Tools, proxies y gateways

**Ampliación opcional.** No necesitas desplegar un intermediario para seguir el curso.

## Lo esencial

Entre una Tool y el sistema que consulta puede haber un componente que aplique controles adicionales. A esto lo llamamos **mediación**.

La distinción que importa al principiante es que las instrucciones al modelo no sustituyen los controles de ejecución.

## Nuestra historia

Codex propone consultar Sales YTD. El runtime comprueba si puede solicitar la operación y el sistema conectado comprueba si la cuenta tiene acceso al modelo.

Si la consulta se rechaza, el agente debe explicar el problema. No debe buscar una manera de saltarse los permisos.

## Vocabulario opcional

- **Proxy:** intermediario que recibe y reenvía una operación.
- **Gateway:** punto de entrada común que puede aplicar políticas a varias capacidades.
- **Adaptador:** componente que traduce entre interfaces.

Son posibilidades de arquitectura, no componentes que debas instalar en Codex para aprender a utilizar Tools.

```text
Modelo propone una llamada
  ↓
Runtime aplica permisos y coordina
  ↓
Intermediario, si existe, aplica sus controles
  ↓
Sistema conectado ejecuta o rechaza
  ↓
El resultado vuelve al modelo a través del runtime
```

## Seguridad que sí debemos conservar

- Conocer qué sistema y cuenta reciben la operación.
- No guardar secretos en instrucciones ni resultados.
- Respetar los rechazos de acceso.
- No confundir «analiza» con «modifica».
- Comprobar que la respuesta procede del sistema esperado.

Una capa adicional no garantiza seguridad por sí sola ni sustituye a la revisión humana.

Un intermediario de comunicaciones y un [hook de Codex](../04-seguridad-y-hooks/02-hooks-en-codex.md) tienen funciones distintas: el hook se ejecuta ante un evento configurado del agente. El bloque de seguridad explica cuándo puede intervenir y qué operaciones quedan fuera de su cobertura.

## Comprueba que lo entiendes

**¿Una instrucción en una Skill puede conceder acceso que el sistema rechaza?**

No. Un procedimiento describe cómo trabajar; no concede permisos.

---

[← Anterior](01-tool-calling.md) · [Índice](../../README.md) · [Siguiente →](03-tool-definitions-upfront.md)
