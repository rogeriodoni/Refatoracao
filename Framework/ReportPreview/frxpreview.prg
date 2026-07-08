*=======================================================
* Report Preview - main program
*
* In VFP9, a program or app may be assigned as the
* "Report Preview" application:
*
*    _REPORTPREVIEW = home()+"reportpreview.app"
*
* This program is the main program of the application
* that forms the default "preview factory" implementation.
*
* roRef is passed by reference. It must be assigned
* a reference to a Preview form before returning.
*
*=======================================================
#Include foxpro_reporting.h

Lparameters roRef

*--------------------------------------------------------------
* Ensure some essential files are built in:
*--------------------------------------------------------------
External Class     frxPreview.vcx

*-----------------------------------------------------------
* We've been passed an object var to place the preview form
* reference into. Called from inside the REPORT FORM ... command.
* Return a reference to the preview container:
*-----------------------------------------------------------
If Set("TALK")="ON"
	Set Talk Off
	roRef = NewObject("frxPreviewProxy") &&NewObject("frxPreviewProxy","frxPreview.vcx")
	Set Talk On
Else
	roRef = NewObject("frxPreviewProxy") &&NewObject("frxPreviewProxy","frxPreview.vcx")
EndIf 
Return


*===========================================
* Class ErrorHandler
*
* A basic error handler.
*
* Useage:
* x = newobject("ErrorHandler","frxPreview.prg")
* x.Handle( iError, cMethod, iLine, THIS )
* if x.cancelled
*  :
* if x.suspened
*  :
*
*===========================================
Define Class ErrorHandler As Custom

	suspended = .F.
	cancelled = .F.
	errorText = ""

*------------------------------------------
	Procedure Handle
*------------------------------------------
	Lparameters iError, cMethod, iLine, oRef

	Store .F. To This.cancelled, This.suspended

	Local cErrorMsg, iRetval
	cErrorMsg = Message()

	cErrorMsg = m.cErrorMsg + Chr(13) + ;
		"Line " + Transform(m.iLine) + " in " + m.cMethod + "()"

	If Not Empty( Message(1) )
		cErrorMsg = m.cErrorMsg + ":" + Chr(13) + Message(1)
	EndIf 
*if not empty( sys(2018) )
*	cErrorMsg = m.cErrorMsg + chr(13) + sys(2018)
*endif 
	If Parameters() > 3
		cErrorMsg = m.cErrorMsg + Chr(13) + oRef.Name + ".Error()"
	EndIf 

*------------------------------------------------------
* Save the error message so that it can be retrieved
*------------------------------------------------------
	This.errorText = m.cErrorMsg

	If poRptPreview.DEBUG_SUSPEND_ON_ERROR
		cErrorMsg = m.cErrorMsg + Chr(13)+Chr(13) + "Do you want to suspend execution?"

		iRetval = MessageBox( cErrorMsg, 3+16+512, poRptPreview.DEFAULT_MBOX_TITLE_LOC + " Error" )
		Do Case
		Case m.iRetval = 6 && yes
			This.suspended = .T.

		Case m.iRetval = 2 && cancel
			This.cancelled = .T.

		EndCase 
	Else
		=MessageBox( cErrorMsg, 0+16, poRptPreview.DEFAULT_MBOX_TITLE_LOC + " Error" )
		This.cancelled = .T.
	EndIf 

	Return .F.
	EndProc 

EndDefine 
