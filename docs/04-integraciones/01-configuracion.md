# Configuración de MCP en Codex para VS Code

La configuración de MCP depende del cliente que ejecuta el agente. En este proyecto utilizamos **OpenAI Codex dentro de VS Code**, junto con la extensión **Power BI Modeling MCP Server** de Microsoft.

## Qué instala cada extensión

```text
VS Code
├── OpenAI Codex
│   └── interfaz para conversar con el agente
│
└── Power BI Modeling MCP Server
    └── servidor MCP local para Power BI y Fabric
```

Codex actúa como cliente MCP y la extensión de Power BI proporciona el servidor y sus Tools. No es necesario registrar manualmente cada Tool.

## Preparación para la fase práctica

Instalar el servidor y conectarlo a Codex son pasos distintos. No damos por comprobada una conexión automática por tener ambas extensiones instaladas. Codex admite configuración MCP en `~/.codex/config.toml` y, en proyectos de confianza, `.codex/config.toml`. La conexión concreta de Power BI debe verificarse cuando llegue la práctica; no es un requisito de los fundamentos.

El procedimiento es:

1. Instalar o actualizar la extensión **OpenAI Codex** para VS Code.
2. Instalar la extensión **Power BI Modeling MCP Server** de Microsoft.
3. Reiniciar VS Code si la extensión no aparece inmediatamente.
4. Abrir el panel de Codex.
5. Comprobar si el servidor de Power BI está configurado y conectado en Codex. Si falta, seguir las instrucciones del servidor y la configuración MCP de Codex; no inventar rutas o comandos.
6. Verificar las capacidades realmente disponibles e iniciar una consulta de sólo lectura.

La extensión de Codex es la interfaz del agente; la extensión de Power BI es la integración que expone el servidor MCP. No hay que confundir la instalación de una extensión con la configuración manual de un cliente MCP externo.

## Conectar con un modelo

### Power BI Desktop

Con Power BI Desktop abierto y el modelo cargado, pedir a Codex:

```text
Conéctate a la instancia de Power BI Desktop del proyecto accounting.pbip e inspecciona el modelo semántico.
```

También puede utilizarse el prompt MCP `ConnectToPowerBIDesktop` si aparece entre los prompts disponibles.

### Proyecto PBIP en disco

Para trabajar con la definición del proyecto y no con la instancia viva de Power BI Desktop:

```text
Conéctate al proyecto PBIP de este workspace e inspecciona la definición del modelo semántico.
```

También puede utilizarse el prompt MCP `ConnectToPBIP` si está disponible en el cliente y servidor utilizados.

### Modelo semántico de Fabric

```text
Conéctate al modelo semántico «Nombre del modelo» del workspace de Fabric «Nombre del workspace».
```

La disponibilidad de esta conexión depende de la versión del servidor MCP, del acceso al workspace y de la autenticación de la cuenta.

## Comprobar que funciona

Después de conectar el modelo, ejecutar una comprobación de solo lectura:

```text
Lista las tablas y medidas disponibles en el modelo conectado.
```

Y después:

```text
Muestra la definición de la medida Gross Margin YTD. No modifiques nada.
```

Si Codex no puede utilizar el MCP:

- Comprueba que las dos extensiones están instaladas y habilitadas.
- Revisa que `powerbi-modeling-mcp` aparece en las Tools disponibles.
- Reinicia VS Code para que el servidor vuelva a anunciar sus Tools.
- Comprueba que Power BI Desktop está abierto cuando se usa la conexión al modelo vivo.
- Revisa la salida o los diagnósticos del servidor desde la interfaz de Codex.

La configuración puede compartirse entre la aplicación de escritorio de ChatGPT, Codex CLI y la extensión IDE cuando utilizan el mismo host de Codex. Para opciones avanzadas, consulta la [documentación oficial de MCP en Codex](https://learn.chatgpt.com/docs/extend/mcp).

## Configuración manual

En Codex, la configuración MCP se guarda en `config.toml`. Configurar el servidor no requiere escribir una definición por cada Tool. Los detalles de instalación y autenticación se verificarán para la versión elegida en la fase práctica.

La documentación oficial de Codex describe la extensión IDE como la interfaz para trabajar junto al código. Para la instalación del servidor Power BI, consulta también la [extensión oficial Power BI Modeling MCP](https://marketplace.visualstudio.com/items?itemName=analysis-services.powerbi-modeling-mcp) y el [repositorio oficial de Microsoft](https://github.com/microsoft/powerbi-modeling-mcp).

---

[← Anterior](00-mcp-introduccion.md) · [Índice](../../README.md) · [Siguiente →](02-credenciales.md)
