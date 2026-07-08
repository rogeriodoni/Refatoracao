* Contains:
*
*	NameValuePairManager
*   ResourceManager


*=================================================
* Class: NameValuePairManager
*
* This Name-Value pair manager class is used
* by frxEvent to store session-level data. It is
* also very useful when you need to take a memo
* of name-value pairs (say, the header EXPR field)
* and get at the individual data items easily.
*=================================================

Define Class NameValuePairManager As Custom

*-------------------------------------------------
* Properties:
*-------------------------------------------------
	Dimension Keys[1]
	Dimension Values[1]

	stripDelimiters = .T.

*------------------------------------------
	Function Get
*------------------------------------------
	Lparameter cToken

	Local retVal
	retVal = ""
	If Not Empty( m.cToken )
*iIndex = ascan(this.keys, "|"+alltrim(upper(cToken))+"|" )
		iIndex = Ascan(This.Keys, "|"+Alltrim(cToken)+"|", 1, Alen(This.Keys), 1, 7)
		If iIndex > 0
			Return This.Values[m.iIndex]
		EndIf 
	EndIf 
	Return m.retVal
	EndFunc 

*------------------------------------------
	Function Set
*------------------------------------------
	Lparameters cKey, vValue

	Local iIndex, iKeyCount
	If Not Empty( m.cKey )
*iIndex = ascan(this.keys, "|"+alltrim(upper(cKey))+"|" )
		iIndex = Ascan(This.Keys, "|"+Alltrim(cKey)+"|", 1, Alen(This.Keys), 1, 7)
		If iIndex > 0
			This.Values[m.iIndex] = m.vValue
		Else
			iKeyCount = Alen(This.Keys,1)+1

			Dimension This.Keys[m.iKeyCount]
			Dimension This.Values[m.iKeyCount]
			This.Keys[m.iKeyCount]   = "|"+m.cKey+"|"
			This.Values[m.iKeyCount] = m.vValue
		EndIf 
	EndIf 

	EndFunc 

*------------------------------------------
	Function getMemo
* returns a CRLF delimited string
*------------------------------------------
	Local iPair, cText
	cText = ""
	For iPair = 2 To Alen( This.Keys )
		cText = cText + Strextract(This.Keys[m.iPair],"|","|") + " = " + Transform(This.Values[m.iPair]) + Chr(13)+Chr(10)
	EndFor 
	Return m.cText
	EndFunc 

*------------------------------------------
	Procedure Reset
*------------------------------------------
	Dimension This.Keys[1]
	Dimension This.Values[1]
	This.Keys   = .F.
	This.Values = .F.
	EndProc 

*------------------------------------------
	Function loadMemo
* expects a CRLF delimited string
* Values will be stored as strings
*------------------------------------------
	Lparameter cText

	If Empty( cText )
		Return .F.
	EndIf 

* populate arrays:
*
	Local i, iLineCount, iKeyCount, cBuff, q, cKey, cValue
	Private aTemp

	iLineCount = Alines( aTemp, cText )
	iKeyCount  = 0
	For i = 1 To iLineCount
		If Empty( aTemp[m.i] ) ;
				or Inlist( Left( aTemp[m.i], 1 ), "[", ";", "*" )
* do nothing
		Else
			iKeyCount  = iKeyCount + 1

* extract the key:
			cBuff = Alltrim(aTemp[m.i])
			q = Min( At(" ",m.cBuff+" "), At("=",m.cBuff+"="), At(Chr(9),m.cBuff+Chr(9)) )
			cKey = Alltrim(Left(m.cBuff,q-1))

* extract the value:
			cBuff  = Alltrim( aTemp[m.i])
			cValue = Alltrim( Substr( m.cBuff, At("=", m.cBuff)+1 ) )

			If This.stripDelimiters
* quote removal:
				If Left( m.cValue ,1) = ["] And Right(m.cValue ,1) = ["]
					cValue  = Substr( m.cValue , 2, Len(m.cValue )-2)
				EndIf 
				If Left( m.cValue ,1) = ['] And Right(m.cValue ,1) = [']
					cValue  = Substr( m.cValue , 2, Len(m.cValue )-2)
				EndIf 
			EndIf 
			cValue = Alltrim(m.cValue )

* load them into the property:
*
			This.Set( m.cKey, m.cValue )
		EndIf  
	EndFor 
	Return .T.
	EndFunc 

EndDefine 

*=================================================
* Class: ResourceManager
*
* This class is derived from NameValuePairManager
* and contains additional logic for saving and
* restoring name-value pairs to the resource file
*=================================================
Define Class ResourceManager As NameValuePairManager

	currentWorkArea  = 0
	resourceWorkArea = 0

*-----------------------------------------------
* OpenResourceFile()
*   returns .T. if successfully opened the resource file
*-----------------------------------------------
	Procedure OpenResourceFile

	If File( Set("RESOURCE",1) ) And Set("RESOURCE")="ON"

		This.currentWorkArea = Select()

		Select 0
		Use (Set("RESOURCE",1)) Again Shared
		Set Order To 1
		This.resourceWorkArea = Select()

		Return .T.
	EndIf 
	Return .F.
	EndProc 

*-----------------------------------------------
* LoadResource( ID, NAME )
* locates and loads a specified resource record
*    into the name-value pairs.
* Currently leaves resource file open.
*-----------------------------------------------
	Procedure LoadResource
	Lparameter cID, cNAME

	If This.OpenResourceFile()

		If Seek( PadR("PREFW",12)+PadR(m.cID,12) + m.cNAME )

			This.loadMemo( Data )

		EndIf 

		Select (This.currentWorkArea)
		Return
	EndIf 
	Return .F.
	EndProc 

*-----------------------------------------------
* SaveResource( ID, NAME )
* locates and saves the current name-value pairs
*    to a specified resource record.
* Opens the resource file if necessary.
* Closes the resource file when finished.
*-----------------------------------------------
	Procedure SaveResource
	Lparameter cID, cNAME

	If Empty( This.resourceWorkArea )
		If Not This.OpenResourceFile()
			Return .F.
		EndIf 
	Else
		Select (This.resourceWorkArea )
	EndIf 

	Local lRetVal
	If Not IsReadOnly()

		Local cData
		cData = This.getMemo()

		If Not Seek( PadR("PREFW",12) + PadR(m.cID,12) + m.cNAME )

			Append Blank
			Replace ;
				TYPE		With "PREFW",;
				ID			With m.cID, ;
				NAME		With m.cNAME, ;
				READONLY 	With .F.
		EndIf 

		If Not ReadOnly
			Replace	Data 	With m.cData, ;
				CKVAL 	With Val(Sys(2007, m.cData )), ;
				UPDATED With Date()
		EndIf 

		m.lRetVal = .T.
	Else
		m.lRetVal = .F.
	EndIf 

*-------------------------------- Close the resource file:
	Use In (This.resourceWorkArea)
	This.resourceWorkArea = 0

*-------------------------------- Restore the current workarea:
	Select (This.currentWorkArea)
	Return (m.lRetVal)
	EndProc 

*-----------------------------------------------
* Destroy()
* Close the resource file if open
*-----------------------------------------------
	Procedure Destroy

	If Not Empty( This.resourceWorkArea )
		Use In (This.resourceWorkArea)
		This.resourceWorkArea = 0
	EndIf 
	If Not Empty( This.currentWorkArea )
		Select (This.currentWorkArea)
	EndIf 
	EndProc 

*-----------------------------------------------
* SaveFontState( THIS )
* Saves Font Style properties into the specified
* resource file record
*   THIS  - object reference that has FontXxxx properties
*-----------------------------------------------
	Procedure SaveFontState
	Lparameters oRef

	This.Set(oRef.Name + ".FontName",   oRef.FontName )
	This.Set(oRef.Name + ".FontSize",   oRef.FontSize )
	This.Set(oRef.Name + ".FontBold",   oRef.FontBold )
	This.Set(oRef.Name + ".FontItalic", oRef.FontItalic )

	EndProc 


*-----------------------------------------------
* RestoreFontState( THIS )
* Restores form properties from the specified
* resource file record
*   THIS  - object reference that has FontXxxx properties
*-----------------------------------------------
	Procedure RestoreFontState
	Lparameters oRef

	Local cValue
	cValue = This.Get(oRef.Name + ".FontName")
	If Not Empty( m.cValue )
		oRef.FontName = m.cValue
	EndIf 
	cValue = This.Get(oRef.Name + ".FontSize")
	If Not Empty( m.cValue )
		oRef.FontSize = Int(Val(m.cValue ))
	EndIf 
	cValue = This.Get(oRef.Name + ".FontBold")
	If Not Empty( m.cValue )
		oRef.FontBold = (Upper(m.cValue)=".T.")
	EndIf 
	cValue = This.Get(oRef.Name + ".FontItalic")
	If Not Empty( m.cValue )
		oRef.FontItalic = (Upper(m.cValue)=".T.")
	EndIf 

	EndProc 

*-----------------------------------------------
* SaveWindowState( THIS )
* Saves form properties into the specified
* resource file record
*   THIS  - object reference to form
*-----------------------------------------------
	Procedure SaveWindowState
	Lparameters oRef

	Local iCurrentState
	iCurrentState = oRef.WindowState
	If oRef.WindowState <> 0
		This.WindowState = 0
	EndIf 

	This.Set(oRef.Name + ".Top", oRef.Top )
	This.Set(oRef.Name + ".Left", oRef.Left )
	This.Set(oRef.Name + ".Width", oRef.Width )
	This.Set(oRef.Name + ".Height", oRef.Height )
	This.Set(oRef.Name + ".WindowState", m.iCurrentState )

	EndProc 

*-----------------------------------------------
* RestoreWindowState( THIS )
* Restores form properties from the specified
* resource file record
*   THIS  - object reference to form
*-----------------------------------------------
	Procedure RestoreWindowState
	Lparameters oRef

	Local cValue

	cValue = This.Get(oRef.Name + ".Top")
	If Not Empty( m.cValue )
		oRef.Top = Int(Val( m.cValue ))
	EndIf 
	cValue = This.Get(oRef.Name + ".Left")
	If Not Empty( m.cValue )
		oRef.Left = Int(Val( m.cValue ))
	EndIf 
	cValue = This.Get(oRef.Name + ".Width")
	If Not Empty( m.cValue )
		oRef.Width = Int(Val( m.cValue ))
	EndIf 
	cValue = This.Get(oRef.Name + ".Height")
	If Not Empty( m.cValue )
		oRef.Height = Int(Val( m.cValue ))
	EndIf 
	cValue = This.Get(oRef.Name + ".WindowState")
	If Not Empty( m.cValue )
		oRef.WindowState = Int(Val( m.cValue ))
	EndIf 
	EndProc 

EndDefine 
