# Formularios (UserForms)

Los **UserForms** son formularios personalizados que se pueden crear en el Editor de VBA para interactuar con el usuario de manera más visual.

## ¿Cómo crear un UserForm?

1. Abre el Editor de VBA (`Alt + F11`).
2. En el menú, ve a **Insertar > UserForm**.
3. Usa el **Cuadro de herramientas** para agregar controles (botones, cuadros de texto, etiquetas, etc.).
4. Haz doble clic en un control para escribir el código de su evento.
5. Para mostrar el formulario desde una macro, usa:

```vba
Sub MostrarFormulario()
    UserForm1.Show
End Sub
```

## Controles más comunes

| Control       | Descripción                          |
|---------------|--------------------------------------|
| `Label`       | Muestra texto estático               |
| `TextBox`     | Permite entrada de texto al usuario  |
| `CommandButton` | Botón ejecutable                  |
| `ComboBox`    | Lista desplegable                    |
| `CheckBox`    | Casilla de verificación              |
| `ListBox`     | Lista de opciones                    |

> Los archivos de formulario tienen extensión `.frm` (diseño) y `.frx` (datos binarios).
> Se exportan desde el Editor de VBA con **Archivo > Exportar archivo...**.
