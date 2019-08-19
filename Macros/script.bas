Sub excelAutomation()
    
    Dim Rng As Range 'cells Range
    Dim IE As Object 'Internet Explorer
    Dim FullAdd As String 'Full Address
    Dim S_Text As String 'text for searching
    Set Rng = Selection 'Select cell/cells Range
    
    Set IE = CreateObject("InternetExplorer.Application")
    IE.Visible = False 'True if the actions performed are visible in the internet explorer browser
    Dim doc As HTMLDocument
    
    Dim PClass As String 'Property Class
    
    
    
    
    'For every cell in selected range select the corresponding Full Address cell and extract S_Text(i.e text for searching)
    For Each i In Rng
   
        FullAdd = i.Offset(0, -1).Value ' One cell to the left from selected cell/range
        'eg. FullAdd = "120 VALLEY VIEW LN SANTA CRUZ CA 95076" or "120 VALLEY VIEW LN T SANTA CRUZ CA 95076"
        
        'if empty cell then fill "no input"
        If FullAdd = "" Then
            i.Value = "no input"
            GoTo NextIteration
               
        'else first look by city names; extract all the text left of the city name and store under S_Text(i.e. text for searching)
        ElseIf FullAdd Like "* SANTA CRUZ CA *" Then
            Pos = InStr(1, FullAdd, " SANTA CRUZ CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* WATSONVILLE CA *" Then 'if * pattern * in text
            Pos = InStr(1, FullAdd, " WATSONVILLE CA ", vbBinaryCompare) - 1 'then position is strating position of pattern - 1
            S_Text = Trim(Left(FullAdd, Pos)) 'and S-Text(i.e text for searching) is left of position
            GoTo ContinueHere
        ElseIf FullAdd Like "* FREEDOM CA *" Then
            Pos = InStr(1, FullAdd, " FREEDOM CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* SCOTTS VALLEY CA *" Then
            Pos = InStr(1, FullAdd, " SCOTTS VALLEY CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* SOQUEL CA *" Then
            Pos = InStr(1, FullAdd, " SOQUEL CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* CAPITOLA CA *" Then
            Pos = InStr(1, FullAdd, " CAPITOLA CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* APTOS CA *" Then
            Pos = InStr(1, FullAdd, " APTOS CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* DAVENPORT CA *" Then
            Pos = InStr(1, FullAdd, " DAVENPORT CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* LA SELVA BCH CA *" Then
            Pos = InStr(1, FullAdd, " LA SELVA BCH CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* PARADISE PARK CA*" Then
            Pos = InStr(1, FullAdd, " PARADISE PARK CA", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* BONNY DOON CA *" Then
            Pos = InStr(1, FullAdd, " BONNY DOON CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* FELTON CA *" Then
            Pos = InStr(1, FullAdd, " FELTON CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* MT HERMON CA *" Then
            Pos = InStr(1, FullAdd, " MT HERMON CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* BEN LOMOND CA *" Then
            Pos = InStr(1, FullAdd, " BEN LOMOND CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* BOULDER CREEK CA *" Then
            Pos = InStr(1, FullAdd, " BOULDER CREEK CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* BROOKDALE CA *" Then
            Pos = InStr(1, FullAdd, " BROOKDALE CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* LOS GATOS CA *" Then
            Pos = InStr(1, FullAdd, " LOS GATOS CA ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
            
        'if no city name spotted then look by AVE, ST, DR, etc.; extract all the text left of AVE, ST etc. and store under S_text(i.e. text for searching)
        ElseIf FullAdd Like "* ST *" Then
            Pos = InStr(1, FullAdd, " ST ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* DR *" Then
            Pos = InStr(1, FullAdd, " DR ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* AVE *" Then
            Pos = InStr(1, FullAdd, " AVE ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* LN *" Then
            Pos = InStr(1, FullAdd, " LN ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* RD *" Then
            Pos = InStr(1, FullAdd, " RD ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* BLVD *" Then
            Pos = InStr(1, FullAdd, " BLVD ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* CT *" Then
            Pos = InStr(1, FullAdd, " CT ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* CIR *" Then
            Pos = InStr(1, FullAdd, " CIR ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* PL *" Then
            Pos = InStr(1, FullAdd, " PL ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* WAY *" Then
            Pos = InStr(1, FullAdd, " WAY ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* TER *" Then
            Pos = InStr(1, FullAdd, " TER ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* LP *" Then
            Pos = InStr(1, FullAdd, " LP ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* LOOP *" Then
            Pos = InStr(1, FullAdd, " LOOP ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* PKWY *" Then
            Pos = InStr(1, FullAdd, " PKWY ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
        ElseIf FullAdd Like "* AVENUE *" Then
            Pos = InStr(1, FullAdd, " AVENUE ", vbBinaryCompare) - 1
            S_Text = Trim(Left(FullAdd, Pos))
            GoTo ContinueHere
            
        'if none of the above text found then leave the Full Address as it is and store under S_Text(i.e. text for searching)
        Else: S_Text = FullAdd
        End If
        
ContinueHere:
        IE.navigate "https://sccounty01.co.santa-cruz.ca.us/ASR/"
        'Wait/loop till the page loads
        Do While IE.Busy
            Application.Wait DateAdd("s", 1, Now)
        Loop
        
        

        Set doc = IE.document
TrySearchAgain:
        doc.getElementById("txtSitus").Value = S_Text 'Fill the address value/criteria with S_Text(i.e. text for searching)
        doc.getElementById("butSearch").Click 'Click on Search button
        
        'Wait/loop till the next page loads
        
        Do While IE.Busy
            Application.Wait DateAdd("s", 4, Now)
        Loop
        
        Set doc = IE.document
        
        'Save the title of the resulting/next page
        Title = doc.getElementsByTagName("title")(0).innerText
        
        'if the title is "Home Page" that means the next page didn't load probably because of invalid S_Text(i.e. text for searching)
        If Title = "Home Page" Then
            
            'Then try adding '#' to S_Text(i.e. text for searching) eg. "120 VALLEY VIEW LN #T"
            
            If Right(S_Text, 2) Like "* [A-Z0-9]*" Then 'eg. if S_Text = "120 VALLEY VIEW LN T"
                S_Text = Left(S_Text, Len(S_Text) - 1) & "#" & Right(S_Text, 1) 'Then add # before last char i.e "120 VALLEY VIEW LN #T"
                GoTo TrySearchAgain
            ElseIf Right(S_Text, 3) Like "* [A-Z0-9][A-Z0-9]*" Then 'eg. if S_Text = "120 VALLEY VIEW LN TT"
                S_Text = Left(S_Text, Len(S_Text) - 2) & "#" & Right(S_Text, 2) 'Then add # before 2nd char from the last i.e "120 VALLEY VIEW LN #TT"
                GoTo TrySearchAgain
            ElseIf Right(S_Text, 4) Like "* [A-Z0-9][A-Z0-9][A-Z0-9]*" Then 'eg. if S_Text = "120 VALLEY VIEW LN TTT"
                S_Text = Left(S_Text, Len(S_Text) - 3) & "#" & Right(S_Text, 3) 'Then add # before 3rd char from the last i.e "120 VALLEY VIEW LN #TTT"
                GoTo TrySearchAgain
            ElseIf Right(S_Text, 5) Like "* [A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]*" Then 'eg. if S_Text = "120 VALLEY VIEW LN TTT"
                S_Text = Left(S_Text, Len(S_Text) - 4) & "#" & Right(S_Text, 4) 'Then add # before 3rd char from the last i.e "120 VALLEY VIEW LN #TTT"
                GoTo TrySearchAgain
            Else: i.Value = "invalid input" 'if none of the string type above matches then just output "invalid input"
                GoTo NextIteration
            End If
        End If
        
        'otherwise resulting page loaded successfully
        
        'Set element = all the html elements with class="plmTr"
        Set element = doc.getElementsByClassName("plmTr")
        
        'For every j/row/"plmTr" in element
        For Each j In element
            addy = j.getElementsByClassName("plmTd")(1).innerText
            'if "(Inactive)" doesn't appear
            If (Not j.innerText Like "* (Inactive) *") Then
                'then add the desired answer to the corresponding cell
                PClass = j.getElementsByClassName("plmTd")(2).innerText
                'LArray = Split(PClass, "-")
                i.Value = Mid(PClass, 5, Len(PClass))
                GoTo NextIteration
           
            Else:
                i.Value = "error"
            End If
        Next
            
        
NextIteration:
    Next
    
End Sub
