# Configuración de Power BI MCP para Codex en VS Code

Esta guía describe el flujo utilizado en este proyecto: OpenAI Codex como agente dentro de VS Code y la extensión Microsoft Power BI Modeling MCP como servidor MCP local.

## Componentes

```text
VS Code
├── OpenAI Codex Extension
│   └── agente y panel de conversación
│
└── Power BI Modeling MCP Server Extension
    └── servidor MCP y Tools de Power BI
```

En el flujo previsto por esta plantilla, la extensión de Power BI proporciona el servidor y Codex lo utiliza desde su runtime sin registrar las Tools una por una. Codex también admite configuración de servidores MCP mediante `~/.codex/config.toml`, un `.codex/config.toml` de proyecto o la interfaz del cliente; `.vscode/mcp.json` no debe asumirse como formato estándar de Codex sin verificar la extensión concreta.

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
4. Si no aparece, reiniciar VS Code y comprobar que ambas extensiones están habilitadas.

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

El prompt MCP equivalente es `ConnectToPBIP`. Esta conexión es diferente de la instancia viva cargada por Power BI Desktop.

## Conectar con Fabric

```text
Conéctate al modelo semántico «Nombre del modelo» del workspace de Fabric «Nombre del workspace».
```

La conexión requiere que la cuenta de Codex tenga acceso al workspace y al modelo correspondiente.

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
