# Proyecto VBA para Macros de Excel

Este proyecto contiene macros de Excel escritas en VBA (Visual Basic for Applications).

## Estructura del proyecto

```
vba-excel-macros/
├── modulos/
│   ├── OperacionesBasicas.bas      ' Operaciones matemáticas y de texto
│   ├── ManipulacionHojas.bas       ' Crear, renombrar y eliminar hojas
│   └── FormatosCeldas.bas          ' Aplicar formatos a rangos de celdas
├── formularios/
│   └── README.md                   ' Instrucciones para formularios (UserForms)
└── README.md
```

## ¿Cómo usar los módulos?

1. Abre Excel y presiona `Alt + F11` para abrir el Editor de VBA.
2. En el menú, ve a **Archivo > Importar archivo...** (o `Ctrl + M`).
3. Selecciona el archivo `.bas` que deseas importar.
4. El módulo aparecerá en el explorador de proyectos.
5. Presiona `F5` para ejecutar la macro seleccionada o llámala desde Excel con `Alt + F8`.

## Requisitos

- Microsoft Excel 2010 o superior (Windows o Mac).
- Macros habilitadas: **Archivo > Opciones > Centro de confianza > Configuración del Centro de confianza > Configuración de macros > Habilitar todas las macros**.

## Convenciones de código

- Los nombres de subrutinas y funciones usan **PascalCase**.
- Las variables locales usan **camelCase**.
- Cada módulo incluye un encabezado con descripción y autor.
- Se usa `Option Explicit` en todos los módulos para declaración obligatoria de variables.
