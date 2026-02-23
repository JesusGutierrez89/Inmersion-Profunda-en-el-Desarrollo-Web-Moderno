Attribute VB_Name = "OperacionesBasicas"
' =============================================================
' Módulo : OperacionesBasicas
' Descripción: Macros de ejemplo para operaciones matemáticas
'              y manipulación de texto en celdas de Excel.
' Autor   : Jesus Gutierrez
' =============================================================
Option Explicit

' Muestra un saludo en la celda A1 de la hoja activa
Sub HolaMundo()
    Dim hoja As Worksheet
    Set hoja = ActiveSheet
    hoja.Range("A1").Value = "¡Hola, Mundo!"
    MsgBox "Macro ejecutada correctamente.", vbInformation, "Hola Mundo"
End Sub

' Calcula la suma de dos celdas (B1 y B2) y escribe el resultado en B3
Sub SumarCeldas()
    Dim hoja As Worksheet
    Dim resultado As Double
    Set hoja = ActiveSheet

    If IsNumeric(hoja.Range("B1").Value) And IsNumeric(hoja.Range("B2").Value) Then
        resultado = hoja.Range("B1").Value + hoja.Range("B2").Value
        hoja.Range("B3").Value = resultado
        MsgBox "Resultado: " & resultado, vbInformation, "Suma"
    Else
        MsgBox "Las celdas B1 y B2 deben contener valores numéricos.", vbExclamation, "Error"
    End If
End Sub

' Recorre el rango A1:A10 y escribe números del 1 al 10
Sub LlenarRango()
    Dim hoja As Worksheet
    Dim i As Integer
    Set hoja = ActiveSheet

    For i = 1 To 10
        hoja.Cells(i, 1).Value = i
    Next i

    MsgBox "Rango A1:A10 llenado con valores del 1 al 10.", vbInformation, "Listo"
End Sub

' Convierte el texto de la celda seleccionada a mayúsculas
Sub TextoAMayusculas()
    Dim celda As Range
    If TypeName(Selection) <> "Range" Then
        MsgBox "Selecciona una celda con texto primero.", vbExclamation, "Aviso"
        Exit Sub
    End If

    For Each celda In Selection
        If celda.Value <> "" Then
            celda.Value = UCase(celda.Value)
        End If
    Next celda
End Sub
