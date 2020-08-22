Sub summary()

Dim ticker As String
Dim openPrice As Double
Dim closePrice As Double
Dim yearlyChange As Double
Dim percentChange As Double
Dim totalVolume As Double

totalVolume = 0

'locate each ticker in the summmary table

Dim summary_table_row As Integer


For Each ws In Worksheets
    
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"
    ws.Range("P1").Value = "Ticker"
    ws.Range("Q1").Value = "Value"
    ws.Range("O2").Value = "Greatest % Increase"
    ws.Range("O3").Value = "Greatest % Decrease"
    ws.Range("O4").Value = "Greatest Total Volume"

    summary_table_row = 2

    lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    For i = 2 To lastRow
        
        On Error Resume Next
    
        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
        
            ticker = ws.Cells(i, 1).Value
            
            openPrice = ws.Cells(i - 260, 3).Value
            
            closePrice = ws.Cells(i, 6).Value
            
            yearlyChange = closePrice - openPrice
            
            percentChange = (closePrice - openPrice) / openPrice
            
            
            totalVolume = totalVolume + ws.Cells(i, 7).Value
            
            ws.Range("I" & summary_table_row).Value = ticker
            
            ws.Range("J" & summary_table_row).Value = yearlyChange
            
            If ws.Range("J" & summary_table_row).Value > 0 Then
                ws.Range("J" & summary_table_row).Interior.ColorIndex = 4
            Else
                ws.Range("J" & summary_table_row).Interior.ColorIndex = 3
            End If
                
            ws.Range("K" & summary_table_row).Value = percentChange
            
            ws.Range("K" & summary_table_row).NumberFormat = "0.00%"
            
            ws.Range("L" & summary_table_row).Value = totalVolume
            
            summary_table_row = summary_table_row + 1
            
            totalVolume = 0
        Else
            totalVolume = totalVolume + ws.Cells(i, 7).Value
        End If
    Next i
    
    
    lRow = ws.Cells(Rows.Count, 11).End(xlUp).Row
    minValue = 0
    maxValue = 0
    maxTotalVolume = 0
    
    For i = 2 To lRow
    
        If ws.Cells(i, 11) > maxValue Then
            maxValue = ws.Cells(i, 11)
            maxTicker = ws.Cells(i, 9)
        Else
            maxValue = maxValue
        End If
        
        If ws.Cells(i, 11) < minValue Then
            minValue = ws.Cells(i, 11)
            minTicker = ws.Cells(i, 9)
        Else
            minValue = minValue
        End If
        
        If ws.Cells(i, 12) > maxTotalVolume Then
            maxTotalVolume = ws.Cells(i, 12)
            maxTotalVolumeTicker = ws.Cells(i, 9)
        Else
            maxTotalVolume = maxTotalVolume
        End If
        
    Next i
    
    ws.Range("P2").Value = maxTicker
    ws.Range("Q2").Value = maxValue
    ws.Range("Q2").NumberFormat = "0.00%"
    ws.Range("P3").Value = minTicker
    ws.Range("Q3").Value = minValue
    ws.Range("Q3").NumberFormat = "0.00%"
    ws.Range("P4").Value = maxTotalVolumeTicker
    ws.Range("Q4").Value = maxTotalVolume
    
    ws.Columns("I:Q").AutoFit
    
Next ws

End Sub


