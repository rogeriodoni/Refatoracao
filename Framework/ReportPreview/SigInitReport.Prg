**
*=======================================================
* Report Preview
*=======================================================
#Include "gdiplus.h"

Public PREVIEW_WILL_HAVE_TOOLBAR	&& Essa var é usada internamente no comando do Report. Tem que ser pública.
PREVIEW_WILL_HAVE_TOOLBAR = .T.

Public poRptPreview As Object 
poRptPreview = CreateObject( "CUSTOM" )

*-------------------------------------------------------
* TollBar Type:
*-------------------------------------------------------
** O param 2 na prop abaixo é o modelo de toolbar com botões personalizados ( FrxPreviewToolBar2 ) . Se for criado outro modelo (ex.: 3, 4, etc.. ), atualizar a função:
** Projeto ReportPreview -> FrxPreview.vcx - FrxPreviewForm.CreateToolbar(), com o novo modelo
poRptPreview.AddProperty( "ToolBar_Type", 2 )	&& param 1 é a ToolBar padrão

*-------------------------------------------------------
* TollBar Dock:
*-------------------------------------------------------
*!*	nLocation = Specifies the location to dock the toolbar or form. 
*!*	The following table lists the values for nLocation. 
*!*	nLocation  Description  FoxPro.h constant  
*!*	–1	Undocks the toolbar or form.														TOOL_NOTDOCKED
*!*	0	Positions the toolbar or form at the top of the main Visual FoxPro window.			TOOL_TOP
*!*	1	Positions the toolbar or form at the left side of the main Visual FoxPro window.	TOOL_LEFT
*!*	2	Positions the toolbar or form at the right side of the main Visual FoxPro window.	TOOL_RIGHT
*!*	3	Positions the toolbar or form at the bottom of the main Visual FoxPro window.		TOOL_BOTTOM
*!*	4	Tab docks a form with another window. (Forms only)									TOOL_TAB
poRptPreview.AddProperty( "UI_TOOLBAR_DOCK", 0 )
*-------------------------------------------------------

*-------------------------------------------------------
* Zoom Level prompts:
*-------------------------------------------------------
** Indica Qual o percentual do Zoom que inicia na tela do Report, Conforme num. abaixo:
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT", 5 )	&& 5-> inicia o zoom em 100%
*
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_10_LOC", "10%" )		&& 1
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_25_LOC", "25%" )		&& 2
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_50_LOC", "50%" )		&& 3
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_75_LOC", "75%" )		&& 4
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_100_LOC", "100%" )		&& 5
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_150_LOC", "150%" )		&& 6
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_200_LOC", "200%" )		&& 7
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_300_LOC", "300%" )		&& 8
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_500_LOC", "500%" )		&& 9
poRptPreview.AddProperty( "ZOOM_LEVEL_PROMPT_WHOLE_PAGE_LOC", "Whole Page" )

*-------------------------------------------------------
* Office CommandButton Preview:
*-------------------------------------------------------
poRptPreview.AddProperty( "Allow_OFFICE_FromPreview", .F. )	&& Se for .F., esconde os botões do WORD/EXCEL, independente do valor das prop. abaixo.
*
poRptPreview.AddProperty( "Allow_Word_FromPreview", poRptPreview.Allow_OFFICE_FromPreview )
poRptPreview.AddProperty( "Allow_RTF_FromPreview", poRptPreview.Allow_OFFICE_FromPreview )
poRptPreview.AddProperty( "Allow_Excel_FromPreview", poRptPreview.Allow_OFFICE_FromPreview )
*
If poRptPreview.Allow_OFFICE_FromPreview = .T.
	Local lcVersao As String
	lcVersao = ""	&& EXCEL/WORD - Retorno -> "2003", "2007", etc...
	If fVerificaVersaoOFFICE( "EXCEL", @lcVersao ) = .F.				&& Função fVerificaVersaoOFFICE está no final desse Prg
		poRptPreview.AddProperty( "Allow_Excel_FromPreview", .F. )
	EndIf
	lcVersao = ""	&& EXCEL/WORD - Retorno -> "2003", "2007", etc...
	If fVerificaVersaoOFFICE( "WORD", @lcVersao ) = .F.					&& Função fVerificaVersaoOFFICE está no final desse Prg
		poRptPreview.AddProperty( "Allow_Word_FromPreview", .F. )
		poRptPreview.AddProperty( "Allow_RTF_FromPreview", .F. )
	EndIf
EndIf

*-------------------------------------------------------------
* Essas vars. controlam se os Botões irão aparecer na toolbar
*-------------------------------------------------------------
poRptPreview.AddProperty( "Allow_Print_FromPreview", .T. )
poRptPreview.AddProperty( "Allow_HTML_FromPreview", .F. )
poRptPreview.AddProperty( "Allow_PDF_FromPreview", .T. )
poRptPreview.AddProperty( "Allow_IMG_FromPreview", .F. )
poRptPreview.AddProperty( "Allow_XML_FromPreview", .F. )


*-------------------------------------------------------
* OutFile CommandButton Preview:
*-------------------------------------------------------
poRptPreview.AddProperty( "Allow_Video_FromOutFile", .F. )
poRptPreview.AddProperty( "Allow_Impressora_FromOutFile", .F. )
poRptPreview.AddProperty( "Allow_EMAIL_FromOutFile", .T. )
poRptPreview.AddProperty( "Allow_Arquivo_FromOutFile", .F. )

poRptPreview.AddProperty( "FromOutFile_EMAIL_TO", "" )
poRptPreview.AddProperty( "FromOutFile_EMAIL_FROM", "" )
poRptPreview.AddProperty( "FromOutFile_EMAIL_CC", "" )
poRptPreview.AddProperty( "FromOutFile_EMAIL_Assunto", "" )
poRptPreview.AddProperty( "FromOutFile_EMAIL_Corpo", "" )

poRptPreview.AddProperty( "ReportFullName", "" )
poRptPreview.AddProperty( "FRXDataSession", 0 )
poRptPreview.AddProperty( "FRXCurrentDataSession", 0 )

poRptPreview.AddProperty( "DEBUG_LARGE_FONT_SUPPORT", .F. )
poRptPreview.AddProperty( "DEBUG_SUSPEND_ON_ERROR", .T. )
poRptPreview.AddProperty( "FRXCOMMON_PRG_CLASSLIB", "frxcommon.prg" )
poRptPreview.AddProperty( "REPORTPREVIEW_RESOURCE_ID", "9REPPREVIEW" )

*-------------------------------------------------------
* Dialog Captions: 
*-------------------------------------------------------
poRptPreview.AddProperty( "DEFAULT_MBOX_TITLE_LOC", "Report Preview" )
poRptPreview.AddProperty( "REPORT_PREVIEW_CAPTION", "Report Preview" )
poRptPreview.AddProperty( "REPORT_PREVIEW_PAGE_CAPTION", " - Página " )
poRptPreview.AddProperty( "REPORT_PREVIEW_GOTO_PAGE_LOC", "Ir para página número:" )
poRptPreview.AddProperty( "TOOLBAR_CAPTION", "Visualizar Impressão" )


*-------------------------------------------------------
* Message box strings: 
*-------------------------------------------------------
poRptPreview.AddProperty( "RP_INVALID_PARAMETERS_LOC", "ReportPreview.app has been called with invalid parameters." )
poRptPreview.AddProperty( "RP_INVALID_INITIALIZATION_LOC", "Report Preview has not been initialized correctly. It requires a ReportListener reference." )
poRptPreview.AddProperty( "RP_INVALID_PAGE_NUMBER_LOC", "Page number must be in range " )
poRptPreview.AddProperty( "RP_NO_OUTPUT_PAGES_LOC", "There are no pages available to preview." )
poRptPreview.AddProperty( "RP_OUTPUTPAGE_ERROR_LOC", "An exception ocurred invoking .OutputPage():" )


*-------------------------------------------------------
* Magic Numbers
*-------------------------------------------------------
** Colunas do Array
poRptPreview.AddProperty( "ZOOM_LEVEL_PERCENT", 2 )
poRptPreview.AddProperty( "ZOOM_LEVEL_CANVAS", 3 )
poRptPreview.AddProperty( "CANVAS_LEFT", 1 )
poRptPreview.AddProperty( "CANVAS_TOP", 2 )
poRptPreview.AddProperty( "SHOW_TOOLBAR_ENABLED", .T. )
poRptPreview.AddProperty( "SHOW_TOOLBAR_DISABLED", .F. )
poRptPreview.AddProperty( "SHOWWINDOW_IN_SCREEN", 0 )
poRptPreview.AddProperty( "SHOWWINDOW_IN_TOPFORM", 1 )
poRptPreview.AddProperty( "SHOWWINDOW_AS_TOPFORM", 2 )
poRptPreview.AddProperty( "WINDOWTYPE_MODELESS", 0 )
poRptPreview.AddProperty( "WINDOWTYPE_MODAL", 1 )

*-------------------------------------------------------
* Context menu prompts:
*-------------------------------------------------------
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_FIRST_PAGE_LOC", "Primeira Página" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_PREVIOUS_LOC", "Anterior" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_NEXT_LOC", "Próxima" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_LAST_PAGE_LOC", "Última página" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_GO_TO_PAGE_LOC", "Ir para página..." )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_ZOOM_LOC", "Zoom" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_PAGES_TO_DISPLAY_LOC", "Páginas para visualizar" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_TOOLBAR_LOC", "Toolbar" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_PRINT_LOC", "Imprimir" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_CLOSE_LOC", "Fechar" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_INFODEBUG_LOC", "Info...[DEBUG]" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_1PAGE_LOC", "1 página" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_2PAGES_LOC", "2 páginas" )
poRptPreview.AddProperty( "CONTEXT_MENU_PROMPT_4PAGES_LOC", "4 páginas" )


*-------------------------------------------------------
* UI control captions (not already LOC'd) :
*-------------------------------------------------------
poRptPreview.AddProperty( "USE_LOC_STRINGS_IN_UI", .T. )	&& Set this .T. to enable these LOC strings in UI controls

poRptPreview.AddProperty( "UI_CMD_OK_LOC", "OK" )
poRptPreview.AddProperty( "UI_CMD_CANCEL_LOC", "Cancela" )
poRptPreview.AddProperty( "UI_TOOLBAR_GOTOPAGE_LOC", "Ir para página" )
poRptPreview.AddProperty( "UI_TOOLBAR_CLOSE_LOC", "Fechar" )
poRptPreview.AddProperty( "UI_TOOLBAR_PRINT_LOC", "Imprimir" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_FIRST_LOC", "Primeira Página (Tecla HOME)" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_BACK_LOC", "Página Anterior (Tecla PageUP)" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_GOTOPAGE_LOC", "Ir para página" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_NEXT_LOC", "Próxima Página (Tecla PageDown)" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_LAST_LOC", "Última Página (Tecla END)" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_ZOOMLEVEL_LOC", "Choose page magnification (Teclas INS e DEL)" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_1PAGE_LOC", "Layout 1 Página (Tecla 1 )" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_2PAGES_LOC", "Layout 2 Páginas (Tecla 2 )" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_4PAGES_LOC", "Layout 4 Páginas (Tecla 4 )" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_CLOSE_LOC", "Fechar janela de Previo (Tecla ESC)" )
poRptPreview.AddProperty( "UI_TOOLBAR_TT_PRINT_LOC", "Imprimir relatório" )


*-------------------------------------------------------
* Canvas Offsets
*-------------------------------------------------------
poRptPreview.AddProperty( "CANVAS_TOP_OFFSET_PIXELS", 15 )
poRptPreview.AddProperty( "CANVAS_LEFT_OFFSET_PIXELS", 15 )
poRptPreview.AddProperty( "CANVAS_VERTICAL_GAP_PIXELS", 10 )
poRptPreview.AddProperty( "CANVAS_HORIZONTAL_GAP_PIXELS", 10 )


*-------------------------------------------------------
* Page Layout:
*-------------------------------------------------------
poRptPreview.AddProperty( "ORIENTATION_PORTRAIT", 0 )
poRptPreview.AddProperty( "ORIENTATION_LANDSCAPE", 1 )



**====================================================================================================================================
**====================================================================================================================================
**====================================================================================================================================

*--------------------------------------------------------------------------------------------------------------
*!*	lcVersao = ""	&& EXCEL/WORD - Retorno -> "2003", "2007", etc...
*!*	If fVerificaVersaoOFFICE( "EXCEL/WORD", @lcVersao ) = .F.
*!*		MessageBox( "Verifique se o EXCEL/WORD está Instalado.", 48, "Atenção" )
*!*		Return( .F. )
*!*	EndIf
**
Function fVerificaVersaoOFFICE
Lparameters tcNomeAPP As String, tcVersaoAPP As String

If IsNull( tcNomeAPP ) OR Empty( tcNomeAPP )
	Return( .F. )
EndIf

tcNomeAPP = Upper( Alltrim( tcNomeAPP ) )

Local loObjOffice As Object

Do Case
Case "EXCEL" $ tcNomeAPP OR "XLS" $ tcNomeAPP

	** Vou testar se o EXCEL está instalado...
	If ( Type( "CreateObject('Excel.Application')" ) == "O" )
		loObjOffice = Createobject( "Excel.Application" )
	Else
		** O EXCEL não está instalado...  :(
		Return( .F. )
	EndIf

Case "WORD" $ tcNomeAPP OR "DOC" $ tcNomeAPP

	** Vou testar se o WORD está instalado...
	If ( Type( "CreateObject('Word.Application')" ) == "O" )
		loObjOffice = Createobject( "Word.Application" )
	Else
		** O WORD não está instalado...  :(
		Return( .F. )
	EndIf

Otherwise
	Return( .F. )

EndCase

** Ok, Está instalado... vou pegar a Versão agora.  :)
lnVersao = Val( loObjOffice.Application.Version )

Release loObjOffice

Do Case
Case lnVersao = 7
	tcVersaoAPP = "95"

Case lnVersao = 8
	tcVersaoAPP = "97"

Case lnVersao = 9
	tcVersaoAPP = "2000"

Case lnVersao = 10
	tcVersaoAPP = "2002"

Case lnVersao = 11
	tcVersaoAPP = "2003"

Case lnVersao = 12
	tcVersaoAPP = "2007"

Case lnVersao = 14
	tcVersaoAPP = "2010"

Otherwise
	tcVersaoAPP = "???[" + Alltrim( Str( lnVersao ) ) + "]"

EndCase

Return( .T. )
EndFunc
**====================================================================================================================================
