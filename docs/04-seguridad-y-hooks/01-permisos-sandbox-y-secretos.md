# Permisos, sandbox y secretos

El primer paso para entender la seguridad es distinguir qué puede leer, escribir, ejecutar y comunicar el entorno utilizado por Codex.

## Permisos y aprobaciones

Un permiso delimita una capacidad; una aprobación decide sobre una operación que necesita autorización adicional. No todas las operaciones provocan una pregunta: depende de la política efectiva.

Para revisar Sales YTD buscamos acceso suficiente para inspeccionar y explicar. Dar acceso de escritura no es necesario sólo porque quizá encontremos algo mejorable.

En Codex, los perfiles de permisos documentados incluyen opciones de lectura y de escritura en el workspace. Los perfiles están en beta y conviven con una configuración anterior del sandbox: no se deben mezclar ambas formas al preparar una configuración. Las políticas administradas pueden restringir las opciones disponibles. [Permisos de Codex](https://learn.chatgpt.com/docs/permissions).

No necesitamos copiar una configuración ahora. Primero identificaremos cliente, versión, entorno de ejecución y política activa cuando llegue la práctica.

## Qué limita el sandbox

Un **sandbox** aplica límites técnicos a las operaciones que se ejecutan dentro de él. No equivale necesariamente a permitir acceso sólo a la carpeta abierta: lectura y escritura pueden tener alcances diferentes.

Los perfiles locales cubren comandos ejecutados en el sandbox. MCP, conectores y otras superficies tienen controles propios. Una restricción de escritura local no demuestra que una Tool remota carezca de permiso para modificar Fabric. Las restricciones por dominio del tráfico de comandos requieren el proxy de red activo. [Alcance de los permisos](https://learn.chatgpt.com/docs/permissions).

En nuestra historia comprobamos dos ámbitos: los archivos del proyecto y la conexión que permite consultar el modelo. El resultado de una comprobación local no prueba los permisos del servicio externo.

## Windows nativo y WSL2

Codex puede ejecutarse de forma nativa en Windows o mediante WSL2, el entorno Linux disponible en Windows. El primer caso utiliza el sandbox de Windows; el segundo, el de Linux. La extensión IDE permite utilizar WSL2. [Sandbox por sistema operativo](https://learn.chatgpt.com/docs/agent-approvals-security).

Tener VS Code abierto en Windows no basta para deducir cuál está ejecutando los comandos. Tampoco la suscripción Business determina por sí sola el sandbox o los permisos de una conexión.

## Cómo se expone un secreto

Un secreto puede recorrer varias etapas:

```text
Almacenamiento de credenciales
  → proceso que necesita autenticarse
  → salida del comando o de la Tool
  → contexto de la conversación o registro
```

Un gestor de contraseñas protege el almacenamiento. Si después se imprime el valor recuperado, puede quedar expuesto. Una variable de entorno puede ser heredada por procesos; no es una garantía de confidencialidad.

Por eso distinguimos usar una credencial para autenticar una conexión de mostrar su valor al modelo. Revisamos qué proceso la necesita y evitamos incluirla en prompts, ejemplos, logs o resultados.

Los archivos `.env`, claves SSH y credenciales de firma merecen atención. `.gitignore` ayuda a evitar su incorporación a Git, pero no es un control de lectura. Tampoco tener una clave SSH prueba que pueda firmar commits: importan el tipo de clave, su configuración y el acceso efectivo.

La expresión «fichero export» de las notas no identifica un archivo concreto de nuestro entorno. No la convertimos en una instrucción de configuración; estudiamos qué información hereda cada proceso.

## Ampliación futura: contenedores

Dev Containers y Docker Sandbox requieren una revisión específica antes de incorporarlos a la práctica. No los tratamos como nombres equivalentes ni asumimos qué archivos globales montan.

OpenAI describe un recorrido con Dev Containers. La utilidad para este curso dependerá de sus montajes, credenciales y acceso a Power BI Desktop; esos aspectos siguen pendientes de comprobar. [Dev Containers en la documentación de Codex](https://learn.chatgpt.com/docs/agent-approvals-security).

## Comprueba que lo entiendes

**¿Sólo lectura local garantiza que una Tool MCP no modifique el modelo remoto?**

No. Hay que comprobar también los controles de la integración y del servicio.

**¿Un secreto está protegido por estar en una variable de entorno?**

No necesariamente. Puede llegar a procesos, salidas o registros que no deberían recibirlo.

---

[← Anterior](00-seguridad-en-el-agent-loop.md) · [Índice](../../README.md) · [Siguiente →](02-hooks-en-codex.md)
