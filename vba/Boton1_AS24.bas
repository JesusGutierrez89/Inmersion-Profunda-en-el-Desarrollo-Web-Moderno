Attribute VB_Name = "Boton1_AS24"
Option Explicit

Sub Botón1_Haga_clic_en()

    ' ===============================
    ' CONSTANTES
    ' ===============================
    Const PASSWORD         As String = "1234"
    Const COL_GASOLEO      As String = "60230000"
    Const COL_LAVADO       As String = "62909300"
    Const COL_PARKING      As String = "62916000"
    Const COL_DEFAULT      As String = "62900000"
    Const COL_ULTIMA_FILA  As String = "55500060"
    Const NO_ENCONTRADO    As String = "NO SE ENCUENTRA"

    ' ===============================
    ' VARIABLES
    ' ===============================
    Dim wsAsientos          As Worksheet
    Dim wsAS24              As Worksheet
    Dim wsAnaliticos        As Worksheet
    Dim wbNuevo             As Workbook
    Dim wsNuevo             As Worksheet
    Dim dictAB              As Object
    Dim ultimaFila          As Long
    Dim ultimaFilaAnaliticos As Long
    Dim i                   As Long
    Dim filaDestino         As Long
    Dim fechaTmp            As Variant
    Dim textoAW             As String
    Dim textoBJ             As String
    Dim numero              As Double
    Dim sumaTotal           As Double
    Dim claveK              As String
    Dim meses(1 To 12)      As String

    ' Array de nombres de mes en español
    meses(1)  = "ENERO":      meses(2)  = "FEBRERO":    meses(3)  = "MARZO"
    meses(4)  = "ABRIL":      meses(5)  = "MAYO":       meses(6)  = "JUNIO"
    meses(7)  = "JULIO":      meses(8)  = "AGOSTO":     meses(9)  = "SEPTIEMBRE"
    meses(10) = "OCTUBRE":    meses(11) = "NOVIEMBRE":  meses(12) = "DICIEMBRE"

    Application.ScreenUpdating = False
    Application.Calculation = xlCalculationManual

    On Error GoTo Cleanup

    ' ===============================
    ' DEFINICIÓN DE HOJAS
    ' ===============================
    Set wsAsientos   = ThisWorkbook.Sheets("ASIENTOS")
    Set wsAS24       = ThisWorkbook.Sheets("AS24 sheet")
    Set wsAnaliticos = ThisWorkbook.Sheets("ANALITICOS")

    ' ===============================
    ' LIMPIAR ASIENTOS (EXCEPTO FILA 1)
    ' ===============================
    With wsAsientos
        .Unprotect Password:=PASSWORD
        With .Rows("2:" & .Rows.Count)
            .ClearContents
            .Interior.Pattern = xlSolid
            .Interior.Color = RGB(255, 255, 255)
        End With
    End With

    ' ===============================
    ' ÚLTIMA FILA REAL AS24
    ' ===============================
    ultimaFila = Application.WorksheetFunction.Max( _
        wsAS24.Cells(wsAS24.Rows.Count, "A").End(xlUp).Row, _
        wsAS24.Cells(wsAS24.Rows.Count, "K").End(xlUp).Row, _
        wsAS24.Cells(wsAS24.Rows.Count, "BJ").End(xlUp).Row _
    )

    ' ===============================
    ' VALORES FIJOS
    ' ===============================
    With wsAsientos
        With .Range("A2:A" & ultimaFila + 1)
            .Value = Date
            .NumberFormat = "dd/mm/yyyy"
        End With
        .Range("H2:H" & ultimaFila + 1).Value = "28"
        .Range("F2:F" & ultimaFila + 1).Value = "T"
        .Range("G2:G" & ultimaFila + 1).Value = "RASPASO"
        .Range("M2:M" & ultimaFila + 1).Value = 0
        .Range("Q2:Q" & ultimaFila + 1).Value = 99
    End With

    ' ===============================
    ' FECHAS AS24!E → ASIENTOS!E
    ' ===============================
    For i = 2 To ultimaFila
        fechaTmp = wsAS24.Cells(i, "E").Value
        If IsDate(fechaTmp) Then
            With wsAsientos.Cells(i, "E")
                .Value = CDate(fechaTmp)
                .NumberFormat = "dd-mm-yyyy"
            End With
        End If
    Next i

    ' Fecha fila final
    fechaTmp = wsAS24.Cells(ultimaFila, "E").Value
    If IsDate(fechaTmp) Then
        With wsAsientos.Cells(ultimaFila + 1, "E")
            .Value = CDate(fechaTmp)
            .NumberFormat = "dd-mm-yyyy"
        End With
    End If

    ' ===============================
    ' TEXTO FACTURA + CONDICIÓN AW → C (bucle unificado)
    ' ===============================
    For i = 2 To ultimaFila + 1

        ' Texto FACTURA según mes de la fecha
        If IsDate(wsAsientos.Cells(i, "E").Value) Then
            wsAsientos.Cells(i, "I").Value = "FACTURA AS24 " & meses(Month(wsAsientos.Cells(i, "E").Value))
        End If

        ' Cuenta contable según descripción AW (solo filas de datos)
        If i <= ultimaFila Then
            textoAW = LCase(Trim(wsAS24.Cells(i, "AW").Value))
            If textoAW Like "*ad blue*" Or textoAW Like "*gasoleo*" Then
                wsAsientos.Cells(i, "C").Value = COL_GASOLEO
            ElseIf textoAW Like "*lavado*" Then
                wsAsientos.Cells(i, "C").Value = COL_LAVADO
            ElseIf textoAW Like "*parking*" Then
                wsAsientos.Cells(i, "C").Value = COL_PARKING
            Else
                wsAsientos.Cells(i, "C").Value = COL_DEFAULT
            End If
        End If

    Next i

    ' ===============================
    ' CRUCE AS24!K → ANALITICOS!A → ASIENTOS!AB
    ' ===============================
    Set dictAB = CreateObject("Scripting.Dictionary")
    dictAB.CompareMode = vbTextCompare

    ultimaFilaAnaliticos = wsAnaliticos.Cells(wsAnaliticos.Rows.Count, "A").End(xlUp).Row

    For i = 2 To ultimaFilaAnaliticos
        claveK = Trim(wsAnaliticos.Cells(i, "A").Value)
        If claveK <> "" Then dictAB(claveK) = wsAnaliticos.Cells(i, "C").Value
    Next i

    For i = 2 To ultimaFila - 1
        claveK = Trim(wsAS24.Cells(i, "K").Value)
        If claveK <> "" And dictAB.Exists(claveK) Then
            wsAsientos.Cells(i, "AB").Value = dictAB(claveK)
        Else
            wsAsientos.Cells(i, "AB").Value = NO_ENCONTRADO
        End If
    Next i

    ' ===============================
    ' BJ → R (SALTA 0,00 Y COMPACTA)
    ' ===============================
    filaDestino = 2
    sumaTotal = 0
    wsAsientos.Columns("R").NumberFormat = "@"

    For i = 2 To ultimaFila
        ' Normalizar separador decimal antes de cualquier comparación o conversión
        textoBJ = Replace(Trim(wsAS24.Cells(i, "BJ").Text), ",", ".")
        If textoBJ <> "" And textoBJ <> "0" And textoBJ <> "0.00" Then
            numero = CDbl(textoBJ)
            sumaTotal = sumaTotal + numero
            wsAsientos.Cells(filaDestino, "R").Value = textoBJ
            filaDestino = filaDestino + 1
        End If
    Next i

    ' Total final
    wsAsientos.Cells(filaDestino, "R").Value = Replace(Format(sumaTotal, "0.00"), ",", ".")

    ' ===============================
    ' Z / AA / J  (filas de datos) + C / J ÚLTIMA FILA
    ' ===============================
    If filaDestino > 2 Then
        wsAsientos.Range("Z2:Z"   & filaDestino - 1).Value = "T08"
        wsAsientos.Range("AA2:AA" & filaDestino - 1).Value = "08"
        wsAsientos.Range("J2:J"   & filaDestino - 1).Value = 1
    End If

    wsAsientos.Cells(filaDestino, "C").Value = COL_ULTIMA_FILA
    wsAsientos.Cells(filaDestino, "J").Value = 2

    ' Limpiar AB en última fila si no tiene analítico
    If UCase(Trim(wsAsientos.Cells(filaDestino, "AB").Value)) = NO_ENCONTRADO Then
        wsAsientos.Cells(filaDestino, "AB").ClearContents
    End If

    ' ===============================
    ' COLUMNAS AF / AG (FORZAR TEXTO)
    ' ===============================
    If filaDestino > 2 Then
        wsAsientos.Columns("AF").NumberFormat = "@"
        wsAsientos.Range("AF2:AF" & filaDestino - 1).Value = "$0000"
        wsAsientos.Range("AG2:AG" & filaDestino - 1).Value = "R"
    End If

    ' ===============================
    ' BORRAR AF / AG / AA SI AB = "NO SE ENCUENTRA"
    ' (EXCEPTO ÚLTIMA FILA)
    ' ===============================
    For i = 2 To filaDestino - 1
        If UCase(Trim(wsAsientos.Cells(i, "AB").Value)) = NO_ENCONTRADO Then
            wsAsientos.Cells(i, "AF").ClearContents
            wsAsientos.Cells(i, "AG").ClearContents
            wsAsientos.Cells(i, "AA").ClearContents
        End If
    Next i

    ' ===============================
    ' RELLENO VERDE CLARO ÚLTIMA FILA
    ' ===============================
    With wsAsientos.Range("A" & filaDestino & ":R" & filaDestino).Interior
        .Pattern = xlSolid
        .Color = RGB(198, 239, 206)
    End With

    ' Limpiar filas sobrantes
    wsAsientos.Rows(filaDestino + 1 & ":" & wsAsientos.Rows.Count).ClearContents

    ' ===============================
    ' PROTEGER FILA 1
    ' ===============================
    wsAsientos.Rows(1).Locked = True
    wsAsientos.Protect Password:=PASSWORD, UserInterfaceOnly:=True

    ' ===============================
    ' CREAR EXCEL NUEVO Y COPIAR ASIENTOS
    ' ===============================
    Set wbNuevo = Workbooks.Add
    Set wsNuevo = wbNuevo.Sheets(1)

    wsAsientos.Cells.Copy
    With wsNuevo
        .Cells.PasteSpecial Paste:=xlPasteValues
        .Cells.PasteSpecial Paste:=xlPasteFormats
        .Name = "AS24"
        .Columns.AutoFit
    End With

    Application.CutCopyMode = False

Cleanup:
    Application.ScreenUpdating = True
    Application.Calculation = xlCalculationAutomatic
    If Err.Number <> 0 Then
        MsgBox "Error " & Err.Number & ": " & Err.Description, vbCritical
    End If

End Sub
