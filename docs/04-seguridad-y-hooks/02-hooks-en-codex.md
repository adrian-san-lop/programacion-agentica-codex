# Hooks en Codex

Un hook permite decirle a Codex: **«Cuando ocurra este evento, ejecuta este programa»**. Por ejemplo, mostrar un aviso al iniciar una sesión o comprobar una operación antes de ejecutarla.

Si conoces los manejadores de eventos de programación, la idea es parecida: conectas un evento con el código que debe responder a él.

## Qué ofrece Codex y qué puedes crear tú

Puedes escribir tus propios programas para hooks. Codex proporciona los momentos en los que permite intervenir y las reglas para comunicarte con ellos.

| Pieza | Quién la define | Ejemplo |
|---|---|---|
| Evento: cuándo puede intervenir el hook | Codex | `SessionStart`, al iniciar una sesión |
| Configuración: qué programa conectar a ese evento | Tú o quien configura el entorno | Ejecutar `avisar-inicio.ps1` |
| Programa: qué hacer cuando se ejecute | Tú, tu equipo o el autor de un hook reutilizado | Devolver un aviso de inicio |
| Formato de entrada y salida | Codex | Recibir datos del evento y devolver un resultado admitido |

`SessionStart` y `PreToolUse` son nombres de eventos. No son scripts completos con reglas de negocio. Puedes escribir un script llamado `revisar-dax.ps1`, pero inventar el evento `AntesDeRevisarDAX` no hace que Codex lo emita.

Estas posibilidades están descritas en la [documentación oficial de hooks](https://learn.chatgpt.com/docs/hooks).

## Primero, un ejemplo que sólo muestra un aviso

Queremos que, al comenzar una sesión, aparezca un aviso indicando que nuestro programa se ha ejecutado. Todavía no vamos a bloquear herramientas.

Seguiremos tres piezas: configuración, programa y resultado. Los archivos y la ruta del ejemplo son ficticios; se muestran para entender el mecanismo, sin instalarlos en este repositorio.

### 1. La configuración conecta el evento con el programa

Supongamos un proyecto de ejemplo en Windows:

```text
C:/curso/proyecto/
  .codex/
    hooks.json          ← cuándo y qué ejecutar
    avisar-inicio.ps1   ← código que hemos escrito
```

Dentro de `hooks.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "^startup$",
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -NoProfile -File C:/curso/proyecto/.codex/avisar-inicio.ps1"
          }
        ]
      }
    ]
  }
}
```

Leído en castellano: «En el evento de inicio de sesión, si el motivo es un inicio nuevo, ejecuta este script de PowerShell».

- `SessionStart` elige el evento.
- `matcher` es el filtro. Aquí `^startup$` selecciona exactamente el motivo `startup`.
- `type: command` indica que se ejecutará un comando.
- `command` identifica el programa y su ruta.

La ruta absoluta facilita seguir el ejemplo; no es una ruta que exista en tu equipo ni una plantilla portable. Este comando corresponde a Windows nativo, no a WSL.

### 2. Codex entrega los datos al programa

Cuando ocurre el evento seleccionado, Codex inicia el script y le entrega datos en JSON por la entrada estándar del proceso, llamada `stdin`.

Para seguir el ejemplo basta con este extracto ficticio:

```json
{
  "hook_event_name": "SessionStart",
  "source": "startup"
}
```

El evento real puede incluir más campos. Es Codex quien prepara esos datos; no tienes que escribir este JSON cada vez ni pedir al modelo que ejecute el script.

### 3. Nuestro programa prepara un aviso

El contenido de `avisar-inicio.ps1` sería:

```powershell
$evento = [Console]::In.ReadToEnd() | ConvertFrom-Json
$aviso = "Hook ejecutado: $($evento.hook_event_name) / $($evento.source)"

@{ systemMessage = $aviso } | ConvertTo-Json -Compress
```

La primera línea lee los datos del evento. La segunda construye el texto. La última devuelve un JSON por la salida estándar, llamada `stdout`.

El resultado sería:

```json
{"systemMessage":"Hook ejecutado: SessionStart / startup"}
```

Codex interpreta `systemMessage` como un aviso para la interfaz o el flujo de eventos. Es un resultado del programa, no una respuesta redactada por el modelo. La presentación concreta debe comprobarse en el cliente utilizado. [Entrada, salida y SessionStart](https://learn.chatgpt.com/docs/hooks#sessionstart).

### 4. Qué ha sucedido de principio a fin

```text
Se inicia una sesión
  → Codex detecta SessionStart con source startup
  → encuentra nuestra configuración activa y confiable
  → el filtro coincide
  → inicia avisar-inicio.ps1 y le entrega el JSON
  → el script devuelve el aviso
  → Codex interpreta el resultado y continúa
```

No hemos creado un nuevo evento de Codex. Hemos creado una respuesta propia a uno que ya ofrece.

## Quién hace que se ejecute

El runtime de Codex dispara el hook configurado cuando corresponde. El modelo no tiene que decidir recordar este paso.

La diferencia con una Skill es concreta: una Skill puede indicar al agente que revise reglas DAX; un hook conecta un evento con la ejecución de un programa. Ambos requieren una configuración adecuada y cumplen funciones distintas.

Un script guardado sin esa conexión sigue siendo un script. Escribir «usa mi hook» en `AGENTS.md` tampoco sustituye la configuración de eventos.

## Después, aplicamos la misma idea a seguridad

Ahora cambiamos el objetivo: antes de una llamada cubierta, comprobar si solicita una escritura durante nuestra revisión de sólo lectura.

| Pieza | Aviso del ejemplo anterior | Comprobación de seguridad |
|---|---|---|
| Evento | `SessionStart` | `PreToolUse` |
| Datos utilizados | Motivo del inicio | Herramienta y argumentos propuestos |
| Código propio | Construye un aviso | Aplica la regla de revisión |
| Resultado | Mensaje informativo | Rechazo explícito si corresponde |

`PreToolUse` identifica el momento. La regla «no modificar medidas durante esta revisión» debe estar implementada en el programa que conectamos.

El [caso de Sales YTD](03-caso-guiado-sales-ytd.md) desarrolla esa comprobación y muestra de dónde sale la decisión de rechazo.

Los hooks también sirven para avisos, validaciones o registros mínimos. La seguridad es uno de sus usos.

## Qué hace falta para utilizarlo en nuestra extensión

Nuestro entorno es Codex en VS Code con suscripción Business. Antes de activar un hook real, hay que revisar el programa, adaptar su ruta y comprobar que el cliente lo carga y permite ejecutarlo.

La configuración del proyecto requiere confianza y los hooks no administrados necesitan revisión. Las políticas de la organización pueden limitar su uso. No damos por instalado un hook sólo porque exista su archivo. [Carga y confianza](https://learn.chatgpt.com/docs/hooks#review-and-trust-hooks).

El ejemplo de este capítulo permite entender las piezas; la prueba de activación en la extensión se reserva para la fase práctica.

## Ampliación: límites que conviene conocer después

- Un hook anterior a la llamada puede rechazar las operaciones cubiertas; uno posterior no deshace lo ejecutado.
- Un hook asíncrono trabaja en segundo plano y no puede bloquear la operación que lo originó.
- El resultado admitido depende del evento. Un error del script o una salida incorrecta no equivalen necesariamente a un rechazo.
- Los hooks no cubren todas las vías de ejecución y su código también necesita revisión.

Estos límites se consultan en la [referencia oficial](https://learn.chatgpt.com/docs/hooks) al preparar una implementación concreta. No hace falta memorizar todos los eventos para comprender el ejemplo.

## Comprueba que lo entiendes

**¿Sólo puedo usar programas escritos por OpenAI?**

No. Puedes escribir el programa y conectarlo a un evento admitido por Codex.

**¿Quién decide mostrar el aviso de nuestro ejemplo: el modelo o el script?**

El script construye el aviso; Codex lo ejecuta e interpreta su salida.

**¿Puedo inventar un evento llamado `AlCambiarUnaMedida`?**

No basta con ponerle ese nombre. Debes utilizar un evento disponible y filtrar las operaciones que te interesan.

**¿`PreToolUse` ya contiene una regla para proteger mis medidas?**

No. Es el punto donde puede ejecutarse tu comprobación; la regla debe definirla el programa.

Fuentes revisadas el 2026-09-08. No se han instalado hooks ni validado su activación en la extensión.

---

[← Anterior](01-permisos-sandbox-y-secretos.md) · [Índice](../../README.md) · [Siguiente →](03-caso-guiado-sales-ytd.md)
