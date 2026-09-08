# Hooks en Codex

Un **hook** es un programa o integración que el runtime ejecuta cuando ocurre un evento configurado. Permite automatizar una comprobación sin depender de que el modelo recuerde solicitarla.

## Del evento al resultado

Para entenderlo necesitamos tres piezas:

| Pieza | Ejemplo conceptual |
|---|---|
| Evento | Está a punto de utilizarse una Tool |
| Filtro o `matcher` | Coincide con el nombre de la herramienta que revisamos |
| Programa del hook | Examina la llamada y devuelve una decisión |

```text
El modelo propone una llamada
  → ocurre el evento compatible
  → se comprueba el filtro
  → se ejecuta el hook
  → Codex interpreta su resultado
  → continúa o rechaza según los controles aplicables
```

Es un esquema didáctico, no una reconstrucción del orden interno de todas las políticas. Si el filtro no coincide o el hook no está activo, esa comprobación no ocurre.

## Antes y después de una Tool

`PreToolUse` interviene antes de una llamada cubierta y puede rechazarla. `PostToolUse` interviene después; no deshace el efecto ya producido. Un hook asíncrono se ejecuta en segundo plano y no puede bloquear la operación que lo originó. [Hooks oficiales de Codex](https://learn.chatgpt.com/docs/hooks).

En la revisión de Sales YTD, una comprobación previa puede rechazar una escritura. Una comprobación posterior puede registrar un resultado mínimo o detectar que faltó evidencia. Son funciones distintas.

## Un rechazo ilustrativo

La salida documentada para rechazar una llamada cubierta en `PreToolUse` tiene esta forma:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Esta revisión sólo permite consultar la medida."
  }
}
```

Es una salida de ejemplo. No configura ni activa un hook en este repositorio.

Actualmente `permissionDecision: "ask"` no está admitido en ese evento: una salida no soportada puede fallar y dejar continuar la llamada. No debemos confundir el fallo del hook con un rechazo efectivo. [Contrato de PreToolUse](https://learn.chatgpt.com/docs/hooks#pretooluse).

## Aplicación a VS Code y Windows

Codex admite configuración de hooks en `hooks.json` o tablas de `config.toml`, incluidas las capas de usuario y proyecto. Los hooks locales requieren confianza en el proyecto y los no administrados requieren revisión. Existe `commandWindows` para indicar un comando específico de Windows. [Configuración de hooks](https://learn.chatgpt.com/docs/hooks).

En una práctica posterior podríamos utilizar PowerShell. Separaríamos el evento recibido, la comprobación y el resultado. No hace falta aprender Bash para entender el patrón.

Antes de dar por operativo un ejemplo verificaríamos la versión de la extensión, las políticas administradas, la carga del hook y una evidencia de ejecución. No trasladamos automáticamente a VS Code los comandos de gestión que una guía documenta para la CLI.

## Límites y confianza

La cobertura de hooks tiene excepciones; no es una frontera completa de seguridad. [Cobertura oficial](https://learn.chatgpt.com/docs/hooks#tool-coverage).

Además, el hook es código que se ejecuta. Debemos revisar qué lee, qué escribe y qué devuelve. Un hook que vuelca las variables de entorno o la conversación completa puede crear la exposición que pretendíamos evitar.

Para una auditoría sencilla basta con un identificador de operación, la decisión y un motivo sin secretos. Que una llamada no sea rechazada por el hook no concede por sí solo permisos adicionales.

## Ampliación opcional

Los eventos de inicio de sesión, compactación, aprobación y parada permiten otros flujos. Se estudiarán cuando ayuden a una tarea concreta. Un hook de Codex y un hook de Git pertenecen a ciclos distintos: configurar uno no configura el otro.

## Comprueba que lo entiendes

**¿Una Skill y un hook hacen lo mismo?**

No. La Skill aporta instrucciones al agente; el hook ejecuta una comprobación ante un evento configurado.

**¿Un hook que falla demuestra que la operación fue bloqueada?**

No. Hay que comprobar el resultado efectivo y el comportamiento del evento.

Fuentes de producto revisadas el 2026-09-08. La ejecución real en nuestra extensión queda pendiente de la fase práctica.

---

[← Anterior](01-permisos-sandbox-y-secretos.md) · [Índice](../../README.md) · [Siguiente →](03-caso-guiado-sales-ytd.md)
