Attribute VB_Name = "FormatosCeldas"
' =============================================================
' Módulo : FormatosCeldas
' Descripción: Macros para aplicar y limpiar formatos en rangos
'              de celdas (fuentes, colores, bordes, etc.).
' Autor   : Jesus Gutierrez
' =============================================================
Option Explicit

' Resalta en amarillo las celdas seleccionadas
Sub ResaltarCeldas()
    If TypeName(Selection) <> "Range" Then
        MsgBox "Selecciona un rango de celdas primero.", vbExclamation, "Aviso"
        Exit Sub
    End If
    Selection.Interior.Color = RGB(255, 255, 0)
    MsgBox "Celdas resaltadas en amarillo.", vbInformation, "Listo"
End Sub

' Aplica negrita, tamaño 12 y color de fuente azul al rango seleccionado
Sub AplicarEstiloTitulo()
    If TypeName(Selection) <> "Range" Then
        MsgBox "Selecciona un rango de celdas primero.", vbExclamation, "Aviso"
        Exit Sub
    End If

    With Selection.Font
        .Bold = True
        .Size = 12
        .Color = RGB(0, 70, 127)
    End With

    MsgBox "Estilo de título aplicado.", vbInformation, "Listo"
End Sub

' Aplica un borde delgado alrededor de todas las celdas del rango seleccionado
Sub AplicarBordes()
    If TypeName(Selection) <> "Range" Then
        MsgBox "Selecciona un rango de celdas primero.", vbExclamation, "Aviso"
        Exit Sub
    End If

    With Selection.Borders
        .LineStyle = xlContinuous
        .Weight = xlThin
        .Color = RGB(0, 0, 0)
    End With

    MsgBox "Bordes aplicados al rango seleccionado.", vbInformation, "Listo"
End Sub

' Limpia todo el formato del rango seleccionado
Sub LimpiarFormato()
    If TypeName(Selection) <> "Range" Then
        MsgBox "Selecciona un rango de celdas primero.", vbExclamation, "Aviso"
        Exit Sub
    End If

    Selection.ClearFormats
    MsgBox "Formato limpiado del rango seleccionado.", vbInformation, "Listo"
End Sub

' Ajusta el ancho de todas las columnas usadas en la hoja activa
Sub AjustarColumnas()
    ActiveSheet.UsedRange.Columns.AutoFit
    MsgBox "Columnas ajustadas automáticamente.", vbInformation, "Listo"
End Sub
