# Cambios realizados respecto al código original

El archivo `Boton1_AS24.bas` es la versión refactorizada del macro original
`Sub Botón1_Haga_clic_en()`. A continuación se detallan **todos los cambios**
realizados. La funcionalidad final es idéntica al original.

---

## 1. `Option Explicit` añadido

**Original:** no existía.  
**Refactorizado:** primera línea del módulo.

```vb
' NUEVO
Option Explicit
```

> Obliga a declarar todas las variables. Cualquier typo en un nombre de
> variable se detecta en tiempo de compilación en lugar de generar un error
> silencioso en ejecución.

---

## 2. Declaraciones `Dim` agrupadas al inicio

**Original:** parte de las variables (`wsAnaliticos`, `dictAB`,
`ultimaFilaAnaliticos`, `claveK`) se declaraban a mitad del procedimiento,
justo antes del bloque "CRUCE AS24!K → ANALITICOS".

**Refactorizado:** **todas** las variables `Dim` están al principio del `Sub`,
incluyendo la nueva `meses(1 To 12)`.

```vb
' ORIGINAL (declaraciones dispersas, ejemplo)
' ...código...
Dim wsAnaliticos As Worksheet
Dim dictAB As Object
' ...más código...

' REFACTORIZADO (todas al inicio)
Dim wsAsientos           As Worksheet
Dim wsAS24               As Worksheet
Dim wsAnaliticos         As Worksheet
' ...todas las demás...
Dim meses(1 To 12)       As String
```

---

## 3. Constantes en lugar de literales de texto/número

**Original:** valores como `"1234"`, `"60230000"`, `"NO SE ENCUENTRA"`, etc.
aparecían repetidos directamente en el código.

**Refactorizado:** definidos como `Const` al comienzo del `Sub`.

| Constante | Valor original |
|---|---|
| `PASSWORD` | `"1234"` |
| `COL_GASOLEO` | `"60230000"` |
| `COL_LAVADO` | `"62909300"` |
| `COL_PARKING` | `"62916000"` |
| `COL_DEFAULT` | `"62900000"` |
| `COL_ULTIMA_FILA` | `"55500060"` |
| `NO_ENCONTRADO` | `"NO SE ENCUENTRA"` |

```vb
' ORIGINAL
wsAsientos.Unprotect Password:="1234"
' ...
wsAsientos.Cells(i, "C").Value = "60230000"

' REFACTORIZADO
Const PASSWORD        As String = "1234"
Const COL_GASOLEO     As String = "60230000"
' ...
wsAsientos.Unprotect Password:=PASSWORD
wsAsientos.Cells(i, "C").Value = COL_GASOLEO
```

---

## 4. `Select Case` de meses → array `meses()`

**Original:** bloque `Select Case` con 12 ramas para obtener el nombre del mes.

**Refactorizado:** array `meses(1 To 12)` pre-cargado; se accede con
`meses(Month(...))`.

```vb
' ORIGINAL (12 ramas)
Select Case Month(wsAsientos.Cells(i, "E").Value)
    Case 1: nombreMes = "ENERO"
    Case 2: nombreMes = "FEBRERO"
    ' ... 10 más ...
    Case 12: nombreMes = "DICIEMBRE"
End Select
wsAsientos.Cells(i, "I").Value = "FACTURA AS24 " & nombreMes

' REFACTORIZADO (1 línea)
wsAsientos.Cells(i, "I").Value = "FACTURA AS24 " & meses(Month(wsAsientos.Cells(i, "E").Value))
```

La variable auxiliar `nombreMes` ya no es necesaria y se eliminó.

---

## 5. Dos bucles `For` fusionados en uno

**Original:** existían **dos bucles separados** que recorrían prácticamente el
mismo rango:

- Bucle "TEXTO FACTURA": `For i = 2 To ultimaFila + 1`
- Bucle "CONDICIÓN AW → C": `For i = 2 To ultimaFila`

**Refactorizado:** **un solo bucle** `For i = 2 To ultimaFila + 1`, con la
condición de AW protegida por `If i <= ultimaFila`.

```vb
' REFACTORIZADO
For i = 2 To ultimaFila + 1

    If IsDate(wsAsientos.Cells(i, "E").Value) Then
        wsAsientos.Cells(i, "I").Value = "FACTURA AS24 " & meses(Month(wsAsientos.Cells(i, "E").Value))
    End If

    If i <= ultimaFila Then
        textoAW = LCase(Trim(wsAS24.Cells(i, "AW").Value))
        ' ...lógica de cuenta contable...
    End If

Next i
```

---

## 6. Dos bloques `If filaDestino > 2` consolidados en uno

**Original:** existían **dos bloques `If filaDestino > 2 Then`** separados:
uno asignaba las columnas Z y AA, y otro asignaba la columna J.

**Refactorizado:** **un único bloque** que asigna Z, AA y J a la vez.

```vb
' ORIGINAL (dos bloques)
If filaDestino > 2 Then
    wsAsientos.Range("Z2:Z"   & filaDestino - 1).Value = "T08"
    wsAsientos.Range("AA2:AA" & filaDestino - 1).Value = "08"
End If
' ...código entre medias...
If filaDestino > 2 Then
    wsAsientos.Range("J2:J" & filaDestino - 1).Value = 1
End If

' REFACTORIZADO (un bloque)
If filaDestino > 2 Then
    wsAsientos.Range("Z2:Z"   & filaDestino - 1).Value = "T08"
    wsAsientos.Range("AA2:AA" & filaDestino - 1).Value = "08"
    wsAsientos.Range("J2:J"   & filaDestino - 1).Value = 1
End If
```

---

## 7. Normalización del separador decimal en el bucle BJ → R

**Original:** se tomaba el texto tal cual, se comparaba con `"0,00"`, `"0"` y
`"0.00"`, y luego se aplicaba `Replace` al escribir en la celda.

**Refactorizado:** se normaliza el texto **antes** de la comparación y de
`CDbl`, eliminando el caso `"0,00"` redundante y garantizando que `CDbl`
siempre recibe un número con separador de punto.

```vb
' ORIGINAL
textoBJ = Trim(wsAS24.Cells(i, "BJ").Text)
If textoBJ <> "" And textoBJ <> "0,00" And textoBJ <> "0" And textoBJ <> "0.00" Then
    numero = CDbl(textoBJ)
    wsAsientos.Cells(filaDestino, "R").Value = Replace(textoBJ, ",", ".")

' REFACTORIZADO
textoBJ = Replace(Trim(wsAS24.Cells(i, "BJ").Text), ",", ".")
If textoBJ <> "" And textoBJ <> "0" And textoBJ <> "0.00" Then
    numero = CDbl(textoBJ)
    wsAsientos.Cells(filaDestino, "R").Value = textoBJ
```

---

## 8. Rendimiento: `ScreenUpdating` y `Calculation`

**Original:** no existían estas líneas.

**Refactorizado:** se deshabilitan al inicio y se restauran al final
(también en caso de error).

```vb
Application.ScreenUpdating = False
Application.Calculation = xlCalculationManual
' ...procesamiento...
Application.ScreenUpdating = True
Application.Calculation = xlCalculationAutomatic
```

> Con hojas grandes esto puede reducir el tiempo de ejecución de forma
> significativa al evitar repintados y recálculos en cada escritura de celda.

---

## 9. Gestión de errores con `On Error GoTo Cleanup`

**Original:** no había ningún control de errores. Si ocurría un fallo
en mitad del macro, `ScreenUpdating` y `Calculation` quedaban en estado
incorrecto y Excel podía quedar inutilizable hasta reiniciar.

**Refactorizado:** etiqueta `Cleanup` que siempre restaura la configuración
de la aplicación y muestra el mensaje de error.

```vb
On Error GoTo Cleanup
' ...código...
Cleanup:
    Application.ScreenUpdating = True
    Application.Calculation = xlCalculationAutomatic
    If Err.Number <> 0 Then
        MsgBox "Error " & Err.Number & ": " & Err.Description, vbCritical
    End If
```

---

## 10. Bloques `With` más consistentes

**Original:** algunos accesos repetidos al mismo objeto usaban la referencia
completa en cada línea.

**Refactorizado:** se usan bloques `With` siempre que se accede a la misma
celda o rango en varias propiedades consecutivas.

```vb
' ORIGINAL
wsAsientos.Range("A2:A" & ultimaFila + 1).Value = Date
wsAsientos.Range("A2:A" & ultimaFila + 1).NumberFormat = "dd/mm/yyyy"

' REFACTORIZADO
With .Range("A2:A" & ultimaFila + 1)
    .Value = Date
    .NumberFormat = "dd/mm/yyyy"
End With
```

---

## Resumen de cambios

| # | Tipo de cambio | Impacto |
|---|---|---|
| 1 | `Option Explicit` | Seguridad / mantenibilidad |
| 2 | `Dim` agrupados al inicio | Legibilidad |
| 3 | Constantes en lugar de literales | Mantenibilidad |
| 4 | Array `meses()` vs. `Select Case` | Legibilidad / menos líneas |
| 5 | Dos bucles → uno | Rendimiento / legibilidad |
| 6 | Dos bloques `If` → uno | Legibilidad |
| 7 | Normalización decimal BJ | Corrección / robustez |
| 8 | `ScreenUpdating` / `Calculation` | Rendimiento |
| 9 | `On Error GoTo Cleanup` | Robustez / mantenibilidad |
| 10 | Bloques `With` consistentes | Legibilidad |
