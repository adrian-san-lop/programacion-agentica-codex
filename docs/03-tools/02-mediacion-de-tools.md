# Mediación de Tools, proxies y gateways

Una Tool no tiene por qué comunicarse directamente con el servicio externo. Entre el agente y la capacidad real puede existir una **capa de mediación** que controle, transforme y observe las llamadas.

```text
Usuario
  ↓
Agente / runtime
  ↓
Capa de mediación
  ├── valida la llamada
  ├── aplica permisos
  ├── transforma el protocolo
  ├── registra la operación
  └── filtra o reduce el resultado
       ↓
Tool / MCP / API / base de datos / servicio externo
```

Esta capa es un patrón general de programación agéntica. Puede utilizarse aunque la capacidad externa no use MCP.

## Terminología

- **Tool proxy**: intermediario que recibe una llamada y la reenvía a otra Tool o servicio.
- **Tool Gateway**: punto de entrada centralizado para varias Tools, normalmente con políticas, identidad, observabilidad y control de acceso.
- **Adapter**: componente que traduce la interfaz de una Tool a otra interfaz.
- **Sidecar**: proceso auxiliar que acompaña al agente o al servicio y media sus comunicaciones.

En la práctica, un mismo componente puede cumplir varias de estas funciones.

## Por qué utilizar una capa de mediación

Un proxy o gateway permite mantener las políticas fuera del prompt y fuera de cada Tool individual.

Casos habituales:

- Permitir sólo determinadas Tools o métodos.
- Validar tipos, rangos y relaciones entre argumentos.
- Bloquear operaciones destructivas o exigir aprobación adicional.
- Ocultar credenciales al LLM y al cliente.
- Redactar secretos o datos personales de las respuestas.
- Aplicar rate limits, timeouts, reintentos y circuit breakers.
- Normalizar errores y formatos de respuesta.
- Registrar quién llamó, qué pidió, qué se ejecutó y qué resultado obtuvo.
- Simular servicios externos durante pruebas.
- Centralizar el acceso a varios proveedores o versiones de una API.

## Patrones de arquitectura

### Proxy local de stdio

El runtime inicia un proceso local y se comunica con él por entrada y salida estándar. El proxy inicia o conecta con el servicio real.

```text
Codex / runtime
      │ stdio
      ▼
Proxy local
      │ HTTP, stdio, SDK o proceso hijo
      ▼
Servicio externo
```

Es útil cuando el agente sólo conoce una Tool local y se quiere introducir validación, logging o transformación sin cambiar el agente.

### Gateway HTTP

El agente se conecta a un endpoint controlado por la organización. El gateway decide a qué servicio interno o externo reenviar cada operación.

```text
Agente
  ↓ HTTPS
Tool Gateway
  ├── API de datos
  ├── servicio interno
  ├── servidor MCP
  └── proveedor externo
```

Es adecuado para políticas centralizadas, varios agentes y servicios compartidos.

### Adapter o bridge de protocolos

El intermediario traduce entre interfaces diferentes, por ejemplo una Tool de un SDK a una operación HTTP o un cliente local a un servidor MCP.

```text
Interfaz que conoce el agente
          ↓
       Adapter
          ↓
Interfaz del servicio real
```

La traducción no debe alterar silenciosamente el significado de los argumentos ni ocultar errores del servicio de destino.

## Proxy autorizado frente a Man-in-the-Middle

No son sinónimos.

Un **proxy autorizado** es un componente conocido por el agente, el operador y el servicio. Tiene una función definida, una identidad verificable y límites documentados.

Un **Man-in-the-Middle malicioso** intercepta o modifica comunicaciones sin autorización. Puede leer credenciales, alterar argumentos, sustituir respuestas o hacerse pasar por el servicio real.

En documentación técnica conviene utilizar:

```text
proxy autorizado
Tool Gateway
reverse proxy
adapter
sidecar
```

y reservar **Man-in-the-Middle** para describir una amenaza o un escenario de seguridad, no como nombre genérico de cualquier proxy.

## Seguridad mínima

La capa de mediación se convierte en un punto de confianza importante. Debe:

- Autenticar al cliente y autorizar cada operación.
- Validar los argumentos con un schema y reglas de negocio.
- Mantener la validación también en el servicio final.
- Verificar certificados TLS y el nombre del host.
- No desactivar la validación TLS para resolver errores de conexión.
- Utilizar secretos desde un gestor de credenciales o variables de entorno protegidas.
- Evitar que tokens, cookies, prompts o resultados sensibles lleguen a logs.
- Separar logs técnicos de auditoría y definir su retención.
- Limitar red, filesystem, procesos y destinos accesibles por el proxy.
- Impedir que una respuesta del servicio pueda modificar las políticas del proxy.
- Revisar cambios de configuración y dependencias.
- Exigir aprobación explícita para operaciones de escritura o alto impacto.

La inspección TLS puede existir en entornos corporativos controlados, pero requiere autorización, gestión correcta de certificados y una política clara de privacidad. No debe presentarse como una técnica necesaria para configurar una Tool.

## Flujo de una llamada mediada

```text
LLM propone Tool Call
          ↓
Runtime aplica permisos del agente
          ↓
Proxy valida nombre y argumentos
          ↓
Proxy autentica y reenvía
          ↓
Servicio ejecuta la operación
          ↓
Proxy valida y redacta el resultado
          ↓
Runtime devuelve el resultado al LLM
```

El proxy no sustituye las aprobaciones del runtime. Son controles distintos: el runtime decide si la sesión puede invocar una Tool y el proxy decide si esa llamada concreta cumple la política del servicio.

## Relación con MCP

MCP es uno de los protocolos que puede atravesar una capa de mediación, pero no define por sí mismo que exista un proxy.

```text
Tool Gateway
├── Tool local
├── API REST
├── base de datos
├── servidor MCP
└── servicio interno
```

En Codex, el runtime puede presentar al agente una Tool directa o una Tool proporcionada por un servidor mediado. La elección depende de los requisitos de seguridad, observabilidad, despliegue y latencia del proyecto.

## Testing y observabilidad

Un proxy facilita probar el comportamiento del agente sin ejecutar siempre el servicio real.

Conviene cubrir:

- Argumentos válidos, inválidos y límite.
- Intentos de invocar Tools no permitidas.
- Repetición de una misma operación.
- Timeouts y respuestas parciales.
- Errores de autenticación y autorización.
- Redacción de datos sensibles.
- Operaciones de lectura frente a operaciones con efectos secundarios.
- Caída del servicio upstream.

La auditoría debería permitir reconstruir la operación sin almacenar secretos: identidad, Tool lógica, operación autorizada, resultado resumido, latencia, estado y motivo de rechazo.

---

[← Anterior](01-tool-calling.md) · [Índice](../../README.md) · [Siguiente →](03-tool-definitions-upfront.md)
