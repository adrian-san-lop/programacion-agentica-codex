# Configuración de Power BI MCP para Codex en VS Code

Esta guía prepara la fase práctica futura: Codex en VS Code con la suscripción Business del curso y un servidor compatible con Power BI. No representa una conexión ya validada en esta plantilla.

## Componentes

```text
VS Code
├── OpenAI Codex Extension
│   └── agente y panel de conversación
│
└── Power BI Modeling MCP Server Extension
    └── servidor MCP y Tools de Power BI
```

Instalar el servidor no demuestra que esté conectado a Codex. Hay que verificar esa conexión por separado. Codex guarda configuración MCP en `~/.codex/config.toml` o, para proyectos de confianza, `.codex/config.toml`. No hace falta definir cada Tool manualmente: se comprueban las capacidades que expone el servidor conectado.

## Requisitos previos

- Windows con Power BI Desktop instalado si se va a trabajar con un modelo local.
- VS Code.
- Extensión OpenAI Codex instalada y autenticada.
- Extensión Microsoft Power BI Modeling MCP Server instalada y habilitada.
- Un proyecto PBIP real cuando se vaya a trabajar con archivos o con su modelo abierto en Power BI Desktop.

## Verificar la instalación

1. Abrir la raíz real del proyecto PBIP en VS Code.
2. Abrir el panel de Codex.
3. Comprobar en las Tools disponibles que aparece `powerbi-modeling-mcp`.
4. Si no aparece, comprobar la configuración del servidor en Codex y los diagnósticos. Seguir las instrucciones oficiales para la versión instalada, sin inventar rutas o comandos de arranque.

## Conectar con Power BI Desktop

1. Abrir el archivo `.pbip` real en Power BI Desktop.
2. Esperar a que el informe y el modelo semántico estén completamente cargados.
3. En Codex, solicitar:

```text
Conéctate a la instancia de Power BI Desktop de este proyecto e inspecciona el modelo semántico.
```

El prompt MCP equivalente, si está disponible, es `ConnectToPowerBIDesktop`.

## Conectar con los archivos PBIP

Cuando el objetivo sea inspeccionar la definición almacenada en disco:

```text
Conéctate al proyecto PBIP de este workspace e inspecciona la definición del modelo semántico.
```

El prompt MCP equivalente, si está disponible en el cliente y servidor, es `ConnectToPBIP`. Esta conexión es diferente de la instancia viva cargada por Power BI Desktop.

## Conectar con Fabric

```text
Conéctate al modelo semántico «Nombre del modelo» del workspace de Fabric «Nombre del workspace».
```

La identidad utilizada por la conexión a Fabric debe tener acceso al workspace y al modelo. No hay que dar por hecho que sea la misma cuenta con la que se inicia sesión en Codex.

## Prueba de conexión

Después de conectar, usar primero consultas de solo lectura:

```text
Lista las tablas y medidas disponibles en el modelo conectado.
```

```text
Muestra la definición de la medida Gross Margin YTD. No modifiques nada.
```

## Seguridad y cambios

- Comenzar siempre con operaciones de inspección.
- Revisar y aprobar explícitamente cualquier operación de escritura.
- No utilizar opciones que desactiven confirmaciones.
- No almacenar credenciales, tokens o secretos en el repositorio.
- Mantener fuera del control de versiones `.pbi/localSettings.json` y `.pbi/cache.abf`.

Para ampliar la información, consulta la [guía general de configuración MCP](../../docs/04-integraciones/01-configuracion.md), la [documentación de la extensión Codex](https://developers.openai.com/codex/ide) y el [repositorio oficial de Power BI Modeling MCP](https://github.com/microsoft/powerbi-modeling-mcp).
