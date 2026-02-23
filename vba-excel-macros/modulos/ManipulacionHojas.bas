Attribute VB_Name = "ManipulacionHojas"
' =============================================================
' Módulo : ManipulacionHojas
' Descripción: Macros para crear, renombrar, copiar y eliminar
'              hojas de cálculo en un libro de Excel.
' Autor   : Jesus Gutierrez
' =============================================================
Option Explicit

' Crea una nueva hoja con el nombre proporcionado por el usuario
Sub CrearHoja()
    Dim nombreHoja As String
    nombreHoja = InputBox("Introduce el nombre de la nueva hoja:", "Nueva hoja")

    If nombreHoja = "" Then
        MsgBox "Operación cancelada.", vbInformation, "Cancelado"
        Exit Sub
    End If

    ' Verificar si ya existe una hoja con ese nombre (comparación sin distinción de mayúsculas)
    Dim hoja As Worksheet
    For Each hoja In ThisWorkbook.Worksheets
        If StrComp(hoja.Name, nombreHoja, vbTextCompare) = 0 Then
            MsgBox "Ya existe una hoja con el nombre '" & nombreHoja & "'.", vbExclamation, "Error"
            Exit Sub
        End If
    Next hoja

    On Error GoTo ErrorCrear
    ThisWorkbook.Worksheets.Add(After:=ThisWorkbook.Worksheets(ThisWorkbook.Worksheets.Count)).Name = nombreHoja
    MsgBox "Hoja '" & nombreHoja & "' creada correctamente.", vbInformation, "Listo"
    Exit Sub
ErrorCrear:
    MsgBox "No se pudo crear la hoja. El nombre puede contener caracteres no válidos o superar 31 caracteres.", _
           vbExclamation, "Error"
End Sub

' Renombra la hoja activa con un nuevo nombre introducido por el usuario
Sub RenombrarHojaActiva()
    Dim nuevoNombre As String
    nuevoNombre = InputBox("Introduce el nuevo nombre para la hoja activa:", "Renombrar hoja", ActiveSheet.Name)

    If nuevoNombre = "" Or nuevoNombre = ActiveSheet.Name Then
        MsgBox "Operación cancelada.", vbInformation, "Cancelado"
        Exit Sub
    End If

    On Error GoTo ErrorRenombrar
    ActiveSheet.Name = nuevoNombre
    MsgBox "Hoja renombrada a '" & nuevoNombre & "'.", vbInformation, "Listo"
    Exit Sub
ErrorRenombrar:
    MsgBox "No se pudo renombrar la hoja. El nombre puede contener caracteres no válidos o superar 31 caracteres.", _
           vbExclamation, "Error"
End Sub

' Lista los nombres de todas las hojas del libro en la hoja activa (columna A)
Sub ListarHojas()
    Dim hoja As Worksheet
    Dim i As Integer
    Dim hojaActiva As Worksheet
    Set hojaActiva = ActiveSheet

    hojaActiva.Range("A1").Value = "Hojas del libro"
    i = 2
    For Each hoja In ThisWorkbook.Worksheets
        hojaActiva.Cells(i, 1).Value = hoja.Name
        i = i + 1
    Next hoja

    MsgBox "Se listaron " & (i - 2) & " hoja(s) en la columna A.", vbInformation, "Listo"
End Sub

' Elimina la hoja activa (con confirmación del usuario)
Sub EliminarHojaActiva()
    Dim respuesta As Integer
    respuesta = MsgBox("¿Estás seguro de que deseas eliminar la hoja '" & ActiveSheet.Name & "'?", _
                       vbYesNo + vbExclamation, "Confirmar eliminación")

    If respuesta = vbYes Then
        Application.DisplayAlerts = False
        ActiveSheet.Delete
        Application.DisplayAlerts = True
        MsgBox "Hoja eliminada.", vbInformation, "Listo"
    End If
End Sub
