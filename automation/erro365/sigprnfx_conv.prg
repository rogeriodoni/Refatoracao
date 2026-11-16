*==============================================================================
* Procedure:		SigPrNfx
* Purpose:			Print a horizontally paginated cross-tab report
* Author:			Doug Hennig
* Copyright:		(c) 1996 Stonefield Systems Group Inc.
* Last Revision:	01/01/97
* Parameters:		tcColumn - the heading to print for the first column
*					tcHeader - the header to print on each page
*					tcOutput - the output device (if it isn't passed, 'PREVIEW'
*						is used
*					tnMargin - the left margin for the report (if it isn't
*						passed, 0 is used)
* Environment in:	the selected table has 3 columns (the names of which are
*						unimportant) -- the first column contains the "row"
*						values, the second column contains the "column" values,
*						and the third column contains the count. The table can
*						have additional columns, but they're ignored.
* Environment out:	the report has been printed
*==============================================================================
#define GDIPLUS_FontStyle_Regular     0
#DEFINE FRX_OBJCOD_DETAIL 4
*-- MIGRADO: constantes do gdiplus.h usadas aqui (evita #INCLUDE dependente do diretorio de compilacao)
#DEFINE GDIPLUS_FontStyle_Bold        1
#DEFINE GDIPLUS_Unit_World            0
#DEFINE GDIPLUS_Unit_Point            3
#DEFINE GDIPLUS_STRINGALIGNMENT_Near  0
#DEFINE GDIPLUS_STRINGALIGNMENT_Center 1
#DEFINE GDIPLUS_STRINGALIGNMENT_Far   2

lparameters lcSourceRep,lcPrinterName,lcOutput,lnMargin,lnPaperSize,lnFatorV1,lnFatorH1,lnTpMargem1, lnFtGDI
local lnAliasSelect,;
	lcReport,;
    lcOutput,;
	lnMargin,;
	lcField1,;
	lcField2,;
	lcField3,;
	lcAlias,;
	lnTotColumns,;
	lnCurrSelect,;
	lcTotals,;
	lcXTab,;
	lcIndex,;
	lcKey,;
	lcReport,;
	lnWidth1,;
	lnWidth2,;
	lnCurrAscii,;
	pcStrgMes,;
	lcFLinha,lcFColuna,lcFConteudo,lcFStyle,lcFFname,lcFFsize,lcFAngulo,llReportGDI

* These variables need to be defined as PRIVATE even in VFP because some
* subroutines use these values.

private pcHeader,;
	pcColumn,;
	paColumns,;
	pnColsPerPage,;
	pnTotalHPages,;
	pcVertKey,;
	plDoneVert,;
	pnHPage


m.lcSourceRep = iif(type('m.lcSourceRep')=='C'.and.used(m.lcSourceRep),m.lcSourceRep,select())
m.lcPrinterName = iif(type('m.lcPrinterName')=='C'.and..not.IsEmpty(m.lcPrinterName),m.lcPrinterName,'')
m.lcOutput = iif(type('m.lcOutput')=='C'.and..not.IsEmpty(m.lcOutput),m.lcOutput,'preview')
m.lnMargin = iif(type('m.lnMargin')=='N',m.lnMargin,0)
m.lnPaperSize = iif(type('m.lnPaperSize')=='N',m.lnPaperSize,0)
m.lnFatorV1 = iif((type('m.lnFatorV1')=='N' And Not IsEmpty(m.lnFatorV1)),m.lnFatorV1,0)
m.lnFatorH1 = iif((type('m.lnFatorH1')=='N' And Not IsEmpty(m.lnFatorH1)),m.lnFatorH1,0)
m.lnAliasSelect = select()
*-- MIGRADO: o app roda em REPORTBEHAVIOR 90 (config.prg); o FRX gerado aqui eh do padrao
*   legado (posicoes por FONTMETRIC) e eh renderizado em 80 - restaurado no fim.
m.lnBehaviorOrig = Set('ReportBehavior')
m.lnTpMargem1 = Iif(Type('m.lnTpMargem1')=='N',m.lnTpMargem1,0)

* Create an FRX to use for the report. Define the number of horizontal columns
* per page and the total number of horizontal pages needed.

m.lcReport = Lower(AddBs(Sys(2023))+Right(Sys(2015),8))
if used('crTmpRepNf')
	use in ('crTmpRepNf')
EndIf 

m.lcFLinha    = ('a.' + Field(1,m.lcSourceRep)) && campo que se refere a linha de posicao de impressao...
m.lcFColuna   = ('a.' + Field(2,m.lcSourceRep)) && campo que se refere a coluna de posicao de impressao...
m.lcFConteudo = ('a.' + Field(3,m.lcSourceRep)) && campo texto de conteudo da impressao...
m.lcFStyle    = ('a.' + Field(4,m.lcSourceRep)) && campo de estilo da fonte de impressao...
m.lcFFname    = ('a.' + Field(5,m.lcSourceRep)) && campo que se refere ao nome da fonte de impressao...
m.lcFFsize    = ('a.' + Field(6,m.lcSourceRep)) && campo que se refere ao tamanho da fonte de impressao...
m.lcFAngulo   = ('a.' + Field(7,m.lcSourceRep)) && campo que se refere ao angulo de impressao do conteudo
m.lcFAlign    = ('a.' + Field(8,m.lcSourceRep)) && campo que se refere ao alinhamento
m.lcFMaxLen   = ('a.' + Field(9,m.lcSourceRep)) && campo que se refere ao tamanho maximo dos campos

Select Transform((&lcFLinha.*1000000000)+(&lcFLinha.*100),'@L 99999999999999999999') as cordemrep1s,;
		&lcFLinha. As Linha,;
		&lcFColuna. As Coluna,;
		&lcFConteudo. As Conteudo,;
		&lcFStyle. As Style,;
		&lcFFname. As fontname,;
		&lcFFsize. As fontsize,;
		&lcFAngulo. As Angulo,;
		&lcFAlign. As Align, ;
		&lcFMaxLen. As MaxLen ;
	From (m.lcSourceRep) a;
	Order By 1;
	Into Cursor crTmpRepNf

Select crTmpRepNf
Locate For Not Angulo==0

m.llReportGDI = (Not Eof('crTmpRepNf'))

Locate 

= CreateReport(m.lcReport,'crTmpRepNf',m.lcPrinterName,m.lnMargin,m.lnPaperSize,m.lnFatorV1,lnFatorH1,lnTpMargem1)

set printer to name (m.lcPrinterName)

select (m.lcSourceRep)
set order to ('') in (m.lcSourceRep)
locate

Compile Report (m.lcReport)

If m.llReportGDI
	Use (m.lcReport+'.FRX') Again In 0 Alias 'FRX'

	Set ReportBehavior 90

	oListener = CREATEOBJECT("ImpNf")

	If m.lnFtGDI==0
		oListener.pnFatorLinhaGDI = .83

	Else
		oListener.pnFatorLinhaGDI = m.lnFtGDI

	EndIf 

	If( lcOutPut == 'Preview' ) Then
		oListener.ListenerType = 1
		REPORT FORM (m.lcReport) OBJECT oListener next 1

	Else
		oListener.ListenerType = 0
		REPORT FORM (m.lcReport) OBJECT oListener To Printer next 1

	Endif	

	Use in FRX

Else
	Set ReportBehavior 80
	Report Form (m.lcReport) &lcOutput. Next 1

EndIf 

Select (m.lnAliasSelect)

erase (m.lcReport+'.frx')
erase (m.lcReport+'.frt')

Set ReportBehavior (m.lnBehaviorOrig)

*-- MIGRADO (Erro63): a toolbar do preview corrompe o _MSYSMENU - recria o menu principal
If Lower(m.lcOutput) == 'preview'
	Try
		Set Sysmenu To Default
		Release Popup popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
		CriarMenuPrincipal()
	Catch
		*-- CriarMenuPrincipal fora do escopo (teste automatizado) - o menu nao existe para recriar
	EndTry
EndIf

endproc

*/////////////////*
*// Function: CreateReport
*// Environment in:	a table (which one is unimportant) is open in the current
*//					workarea
*/////////////////*

function CreateReport(m.lcLocalReport,m.lcSourceRep,m.lcPrinterName,m.lnMargin,m.lnPaperSize,m.lnFatorV1,lnFatorH1,m.lnTpMargem1)
	private pnVPosFactor,pnHFieldFactor,pnHTextFactor,pnWFieldFactor,pnWTextFactor,pnWFieldFactor2
	Local lnAliasSelect,lcReport,lnHeaderBand,lnDetailBand,lnPageFooterBand,lnSummaryBand,lcExprHeader,lnFontStyle,;
	      lnLastRow1

	#define ccFont                      'Courier New'
	#define cnSize                      9
	#define cnFactor                    (10000.0000/(12 * 8)) && 104.1666
	#define cnFactorV                   (10000.0000/(12 * FontMetric(1, ccFont, cnSize)))
	#define cnFactorH                   (10000.0000/(12 * FontMetric(7, ccFont, cnSize)))

	m.pnVPosFactor   = ((fontmetric(1, ccFont, cnSize) + 2) * cnFactor)
	m.pnHFieldFactor = ((fontmetric(1, ccFont, cnSize) + 2) * cnFactor)
	m.pnHTextFactor  = (fontmetric(1, ccFont, cnSize) * cnFactor)
	m.pnHPosFactor   = (fontmetric(7, ccFont, cnSize) * cnFactor)
	m.pnWFieldFactor = (fontmetric(7, ccFont, cnSize) * cnFactor)
	m.pnWTextFactor  = (fontmetric(6, ccFont, cnSize) * cnFactor)

	*// Create the report file...

	m.lnAliasSelect = select()

	create report (m.lcLocalReport) from (alias())
	m.lcReport = CreateUniqueAlias()
	use (m.lcLocalReport+'.frx') alias (m.lcReport) exclusive in 0
	zap in (m.lcReport)

	m.lnHeaderBand = 1
	m.lnDetailBand = 2
	m.lnPageFooterBand = 3
	m.lnSummaryBand = 4
	m.lcExprHeader = (	[DRIVER=winspool]+chr(13)+chr(10)+;
						[DEVICE=]+AllTrim(m.lcPrinterName)+chr(13)+chr(10)+;
						[OUTPUT=]+AllTrim(m.lcPrinterName)+chr(13)+chr(10)+;
						[ORIENTATION=0]+chr(13)+chr(10)+;
						[PAPERSIZE=]+AllTrim(Str(m.lnPaperSize,20,0))+chr(13)+chr(10)+;
						[ASCII=]+AllTrim(Str(m.lnPaperSize,20,0))+chr(13)+chr(10))
						


	m.lnLastRow1 = 0

	do InsertHeader with m.lcReport,m.lcExprHeader,m.lnTpMargem1 in SigPrNfx
	do InsertBand with m.lcReport,0,'page header',0 in SigPrNfx
	do InsertBand with m.lcReport,0,'detail',1 in SigPrNfx
	do InsertBand with m.lcReport,0,'page footer',0 in SigPrNfx
	do InsertBand with m.lcReport,0,'summary',0 in SigPrNfx

	select (m.lcSourceRep)
	set order to ('') in (m.lcSourceRep)
	locate

	Scan
		m.pnWFieldFactor2 = (Fontmetric(7, Alltrim(evaluate(m.lcSourceRep+'.fontname')),;
								Evaluate(m.lcSourceRep+'.fontsize'),Alltrim(evaluate(m.lcSourceRep+'.style'))) * cnFactor)
		If pnWFieldFactor2<pnWFieldFactor
			pnWFieldFactor2 = pnWFieldFactor
		EndIf 
		m.lcConteudo = ''
		m.lnFontStyle = 0
		m.lnLastRow1 = Max(Evaluate(m.lcSourceRep+'.linha'),0)

		lnMax = Evaluate(m.lcSourceRep + [.MaxLen])
		lcAln = Alltrim(Evaluate(m.lcSourceRep + [.Align]))
		lcAln = Iif(lcAln = [R], [Right], Iif(lcAln = [C], [Center], [Left]))
		
		If lower(evaluate(m.lcSourceRep+'.style'))=='b'
			m.lcConteudo = rtrim(evaluate(m.lcSourceRep+'.conteudo'))
			m.lnFontStyle = 1
		Else
			if Lower(evaluate(m.lcSourceRep+'.style'))== 'x' Or (lcAln = [Right])
				If (lnMax = 0)
					m.lcConteudo = rtrim(evaluate(m.lcSourceRep+'.conteudo'))
				Else
					m.lcConteudo = Padl(Alltrim(evaluate(m.lcSourceRep+'.conteudo')), lnMax)
				EndIf
			else
				m.lcConteudo = alltrim(evaluate(m.lcSourceRep+'.conteudo'))
			EndIf 
		EndIf
		lnLen = len(m.lcConteudo)
		
		do InsertField with m.lcReport, m.lnDetailBand, ["]+m.lcConteudo+["], lnLen, 1, ;
							max(evaluate(m.lcSourceRep+'.linha'),0), max(evaluate(m.lcSourceRep+'.coluna'),0), ;
							lcAln, .f., '', '', alltrim(evaluate(m.lcSourceRep+'.fontname')), ;
							evaluate(m.lcSourceRep+'.fontsize'), m.lnFontStyle, -1, -1, -1, -1, ;
							-1, -1, 1, m.lnFatorV1, m.lnFatorH1, Str(max(evaluate(m.lcSourceRep+'.angulo'),0),3) in SigPrNfx
	endscan

	update (m.lcReport) set height=(m.pnHFieldFactor * m.lnLastRow1) where objtype=9 and objcode=4
	Update (m.lcReport) set Tag2 = [fImpresso()] Where ObjType = 9 And ObjCode=8

	do InsertTrailer with m.lcReport in SigPrNfx
	if at('visual',lower(alltrim(version())))>0
		do InsertDE with m.lcReport in SigPrNfx
	endif at('visual',lower(alltrim(version())))>0

	use in (m.lcReport)

	select (m.lnAliasSelect)
endfunc

*==============================================================================
* Function:			GetColumn
* Purpose:			UDF called from the column headings in the FRX: gets the
*						heading for the specified column from the paColumns
*						array
* Author:			Doug Hennig
* Copyright:		(c) 1996 Stonefield Systems Group Inc.
* Last Revision:	01/01/97
* Parameters:		tnColumn - the column number
* Returns:			the column heading for the specified column or a blank
*						value if there is no such column
* Environment in:	pnHPage and pnColsPerPage have been defined
*					the paColumns array contains the column headings
* Environment out:	none
*==============================================================================

*!*	function GetColumn
*!*	parameters tnColumn
*!*	private lnColumn
*!*	lnColumn = pnHPage * pnColsPerPage + tnColumn
*!*	return iif(lnColumn > alen(paColumns), '', paColumns[lnColumn])

*==============================================================================
* Function:			GetCell
* Purpose:			UDF called from each cell in the FRX: gets the value for
*						the specified column from the current row
* Author:			Doug Hennig
* Copyright:		(c) 1996 Stonefield Systems Group Inc.
* Last Revision:	01/01/97
* Parameters:		tnColumn - the column number
* Returns:			the column heading for the specified column or a blank
*						value if there is no such column
* Environment in:	pnHPage, pnColsPerPage, and plDoneVert have been defined
*					the paColumns array contains the column headings
*					the cross-tab cursor is selected and indexed
* Environment out:	the cross-tab cursor may have been positioned to a new
*						record
*==============================================================================

function GetCell
parameters tnColumn
private lnColumn,;
	luReturn,;
	lnRecno,;
	lcXTab1,;
	lcXTab2
lnColumn = pnHPage * pnColsPerPage + tnColumn

return luReturn

*==============================================================================
* Function:			NewPage
* Purpose:			UDF called from the FRX: handle a new page
* Author:			Doug Hennig
* Copyright:		(c) 1996 Stonefield Systems Group Inc.
* Last Revision:	01/01/97
* Parameters:		none
* Returns:			a blank value
* Environment in:	pnHPage, pnTotalHPages, and pcVertKey have been defined
*					the cross-tab cursor is selected and indexed
* Environment out:	pnHPage is set to the next horizontal page
*					plDoneVert is set to .F.
*					if this is the first horizontal page, pcVertKey is set to
*						the key value for the current record
*					if this isn't the first horizontal page, the cross-tab
*						cursor is positioned to the same record as the first
*						row for the first horizontal page for this vertical
*						page
*==============================================================================

function NewPage
pnHPage    = ((_pageno - 1) % pnTotalHPages)
plDoneVert = .F.
if pnHPage = 0
	pcVertKey = evaluate(key(val(sys(21))))
else
	seek pcVertKey
endif pnHPage = 0
return ''

*==============================================================================
* Function:			NewRow
* Purpose:			UDF called from the FRX: handle the end of a row
* Author:			Doug Hennig
* Copyright:		(c) 1996 Stonefield Systems Group Inc.
* Last Revision:	01/01/97
* Parameters:		none
* Returns:			a blank value
* Environment in:	pnHPage, pnTotalHPages, plDoneVert, and pcVertKey have been
*						defined
*					the cross-tab cursor is selected and indexed
* Environment out:	the cross-tab cursor is positioned to the record before the
*						next row for the current horizontal and vertical page
*						(it's the record before because the FRX does its own
*						SKIP)
*					if there are no more records but we're not done all the
*						horizontal pages, plDoneVert is set to .T. (we're done
*						the vertical pages) and the cross-tab cursor is
*						positioned to the same record as the first row for the
*						first horizontal page for this vertical page
*==============================================================================

function NewRow
private lcField,;
	lcValue
lcField = field(1)
lcValue = evaluate(lcField)
scan while &lcField = lcValue
endscan while &lcField = lcValue
if eof() and pnHPage + 1 < pnTotalHPages
	plDoneVert = .T.
	seek pcVertKey
else
	skip -1
endif eof() ...
return ''

*/////////////////*
function InsertHeader(m.lcReport,m.lcExpression,m.lnTpMargem1)
*/////////////////*
	m.lcExpression = iif(type('m.lcExpression')=='C',m.lcExpression,'')
	m.lnTpMargem1 = Iif(Type('m.lnTpMargem1')=='N',m.lnTpMargem1,0)
   insert into (m.lcReport);
         (platform,;
         uniqueid,;
         objtype,;
         objcode,;
         expr,;
         vpos,;
         width,;
         fontface,;
         fontsize,;
         ruler,;
         grid,;
         gridv,;
         gridh,;
         addalias,;
         curpos,;
         top);
      values;
         ('WINDOWS',;
         sys(2015),;
         1,;
         53,;
         m.lcExpression,;
         1,;
         -1,;
         ccFont,;
         cnSize,;
         1,;
         .t.,;
         12,;
         12,;
         .t.,;
         .t.,;
         (m.lnTpMargem1==1))
endfunc

*/////////////////*
function InsertBand(m.lcReport,m.lnBand,m.lcBand,m.lnHeight)
*/////////////////*
	local lnCode
	do case
		case Lower(AllTrim(m.lcBand))=='page header'
			m.lnCode = 1
		case Lower(AllTrim(m.lcBand))=='detail'
			m.lnCode = 4
		case Lower(AllTrim(m.lcBand))=='page footer'
			m.lnCode = 7
		case Lower(AllTrim(m.lcBand))=='summary'
			m.lnCode = 8
	endcase
	insert into (m.lcReport);
	         (platform,;
	         uniqueid,;
	         objtype,;
	         objcode,;
	         height);
		values;
			('WINDOWS',;
			sys(2015),;
			9,;
			m.lnCode,;
			(m.lnHeight * m.pnVPosFactor + (m.lnBand - 1) * cnFactor))
endfunc

*/////////////////*
function InsertField(m.lcReport,m.lnBand,m.lcExpression,m.lnWidth,m.lnHeight,m.lnVPos,m.lnHPos,;
                     m.tcAlign,m.llStretch,m.lcStyle,m.lcPicture,m.lcFontName,m.lnFontSize,m.lnFontStyle,;
                     m.lnPenRed,m.lnPenGreen,m.lnPenBlue,m.lnFillRed,m.lnFillGreen,m.lnFillBlue,m.lnMode,;
                     m.lnFatorV1,m.lnFatorH1,m.lcComment)
*/////////////////*
	do case
		case type('m.tcAlign') <> 'C' or IsEmpty(m.tcAlign) or m.tcAlign = 'Left'
			m.lnAlign = 0
		case m.tcAlign = 'Right'
			m.lnAlign = 1
		otherwise
			m.lnAlign = 2
	EndCase	
	m.lnFatorV1 = iif(type('m.lnFatorV1')=='N',m.lnFatorV1,0)
	m.lnFatorH1 = iif(type('m.lnFatorH1')=='N',m.lnFatorH1,0)
	m.lcPicture = iif(IsEmpty(m.lcPicture), '', m.lcPicture)
	m.lcStyle   = iif(IsEmpty(m.lcStyle),   '', m.lcStyle)
	m.lnWidth   = (m.lnWidth * m.pnWFieldFactor2)
	m.lnVPos    = ((m.lnVPos  * m.pnVPosFactor + (m.lnBand - 1) * cnFactor) + m.lnFatorV1)
	m.lnHPos    = ((m.lnHPos  * m.pnHPosFactor) + m.lnFatorH1)
	m.lcFontname = iif(type('m.lcFontname')='C',m.lcFontname,ccFont)
	m.lnFontsize = iif(type('m.lnFontSize')='N',m.lnFontSize,8)
	m.lnFontStyle = iif(type('m.lnFontStyle')='N',m.lnFontStyle,0)
	m.lnPenRed = iif(type('m.lnPenRed')='N',m.lnPenRed,-1)
	m.lnPenGreen = iif(type('m.lnPenGreen')='N',m.lnPenGreen,-1)
	m.lnPenBlue = iif(type('m.lnPenBlue')='N',m.lnPenBlue,-1)
	m.lnFillRed = iif(type('m.lnFillRed')='N',m.lnFillRed,-1)
	m.lnFillGreen = iif(type('m.lnFillGreen')='N',m.lnFillGreen,-1)
	m.lnFillBlue  = iif(type('m.lnFillBlue')='N',m.lnFillBlue,-1)
	m.lnMode  = iif(type('m.lnMode')='N',m.lnMode,1)
	m.lcComment = Iif(IsEmpty(m.lcComment), '0', m.lcComment)
	
	insert into (m.lcReport); &&1
	      (platform,;       &&2
	      uniqueid,;        &&3
	      objtype,;         &&4
	      objcode,;         &&5
	      expr,;            &&6
	      height,;          &&7
	      width,;           &&8
	      vpos,;            &&9
	      hpos,;            &&10
	      picture,;         &&11
	      style,;           &&12
	      penred,;          &&13
	      pengreen,;        &&14
	      penblue,;         &&15
	      fillred,;         &&16
	      fillgreen,;       &&17
	      fillblue,;        &&18
	      mode,;            &&19
	      top,;             &&20
	      resettotal,;      &&21
	      suprpcol,;        &&22
	      stretch,;         &&23
	      offset,;          &&24
	      supalways,;       &&25
	      fontface,;        &&26
	      fontsize,;
	      fontstyle,;
	      supexpr,;
	      comment);
		values;
			('WINDOWS',;
			sys(2015),;
			8,;
			0,;
			m.lcExpression,;
			(m.pnHFieldFactor * m.lnHeight),;
			m.lnWidth,;
			m.lnVPos,;
			m.lnHPos,;
			m.lcPicture,;
			m.lcStyle,;
			m.lnPenRed,;
			m.lnPenGreen,;
			m.lnPenBlue,;
			m.lnFillRed,;
			m.lnFillGreen,;
			m.lnFillBlue,;
			m.lnMode,;
			.T.,;
			1,;
			3,;
			m.llStretch,;
			m.lnAlign,;
			.t.,;
			m.lcFontname,;
			m.lnFontSize,;
			m.lnFontStyle,;
			"",;
			m.lcComment)
endfunc

*/////////////////*
function InsertTrailer(m.lcReport)
*/////////////////*
	insert into (m.lcReport);
		  (platform,;
		  uniqueid,;
		  objtype,;
		  vpos,;
		  hpos,;
		  height,;
		  width,;
		  penred,;
		  fontface,;
		  fontsize);
		values;
			('WINDOWS',;
			sys(2015),;
			23,;
			16,;
			8,;
			12,;
			8,;
			4,;
			ccFont,;
			cnSize)
endfunc

*****************
function InsertDE
*****************

parameters tcReport
insert into (tcReport) ;
		(PLATFORM, ;
		UNIQUEID, ;
		OBJTYPE, ;
		NAME, ;
		EXPR, ;
		TAG ) ;
	values ;
		('WINDOWS', ;
		sys(2015), ;
		25, ;
		'dataenvironment', ;
		'Name = "Dataenvironment"', ;
		'PROCEDURE Init'+Chr(13)+Chr(10)+;
		'If WExist("Report Designer")'+Chr(13)+Chr(10)+;
		'   Zoom Window "Report Designer" Max'+Chr(13)+Chr(10)+;
		'EndIf'+Chr(13)+Chr(10)+;
		'EndProc')
return

********************
function InsertShape
********************

parameters tcReport,;
	tnBand,;
	tcExpression,;
	tnWidth,;
	tnHeight,;
	tnVPos,;
	tnHPos,;
	tcAlign,;
	tlStretch,;
	tcStyle,;
	tcPicture,;
	tnFontSize,;
	tnFontStyle,;
	tnPenRed,;
	tnPenGreen,;
	tnPenBlue,;
	tnFillRed,;
	tnFillGreen,;
	tnFillBlue,;
	tnMode
private lnAlign,;
	lcPicture,;
	lcStyle,;
	lnWidth,;
	lnVPos,;
	lnHPos,;
	lnFontSize,;
	lnFontStyle,;
	lnPenRed,;
	lnPenGreen,;
	lnPenBlue,;
	lnFillRed,;
	lnFillGreen,;
	lnFillBlue,;
	lnMode
do case
	case type('tcAlign') <> 'C' or IsEmpty(tcAlign) or tcAlign = 'Left'
		lnAlign = 0
	case tcAlign = 'Right'
		lnAlign = 1
	otherwise
		lnAlign = 2
endcase

lcPicture = iif(IsEmpty(tcPicture), '', tcPicture)
lcStyle   = iif(IsEmpty(tcStyle),   '', tcStyle)
lnWidth   = tnWidth * pnWFieldFactor
lnVPos    = tnVPos  * m.pnVPosFactor + (tnBand - 1) * cnFactor
lnHPos    = tnHPos  * m.pnHPosFactor
lnFontsize = iif(type('tnFontSize')='N',tnFontSize,6)
lnFontStyle = iif(type('tnFontStyle')='N',tnFontStyle,0)
lnPenRed = iif(type('tnPenRed')='N',tnPenRed,-1)
lnPenGreen = iif(type('tnPenGreen')='N',tnPenGreen,-1)
lnPenBlue = iif(type('tnPenBlue')='N',tnPenBlue,-1)
lnFillRed = iif(type('tnFillRed')='N',tnFillRed,-1)
lnFillGreen = iif(type('tnFillGreen')='N',tnFillGreen,-1)
lnFillBlue  = iif(type('tnFillBlue')='N',tnFillBlue,-1)
lnMode  = iif(type('tnMode')='N',tnMode,1)
insert into (tcReport); &&1
		(PLATFORM,;	&&2
		UNIQUEID,;	&&3
		OBJTYPE,;	&&4
		OBJCODE,;	&&5
		EXPR,;	&&6
		HEIGHT,;	&&7
		WIDTH,;	&&8
		VPOS,;		&&9
		HPOS,;		&&10
		PICTURE,;	&&11
		STYLE,;	&&12
		PENRED,;	&&13
		PENGREEN,;	&&14
		PENBLUE,;	&&15
		FILLRED,;	&&16
		FILLGREEN,;&&17
		FILLBLUE,;	&&18
		MODE,;		&&19
		TOP,;		&&20
		RESETTOTAL,;	&&21
		SUPRPCOL,;		&&22
		STRETCH,;		&&23
		OFFSET,;		&&24
		SUPALWAYS,;	&&25
		FONTFACE,;		&&26
		FONTSIZE,;
		FONTSTYLE,;
		PENSIZE,;
		PENPAT,;
		FILLPAT,;
		SUPEXPR);	
	values;
		('WINDOWS',;
		sys(2015),;
		7,;
		4,;
		tcExpression,;
		pnHFieldFactor * tnHeight,;
		lnWidth,;
		lnVPos,;
		lnHPos,;
		lcPicture,;
		lcStyle,;
		0,;
		0,;
		0,;
		lnFillRed,;
		lnFillGreen,;
		lnFillBlue,;
		lnMode,;
		.T.,;
		1,;
		3,;
		tlStretch,;
		lnAlign,;
		.T.,;
		ccFont,;
		0,;
		0,;
		1,;
		0,;
		1,;
		"")
return

*******************
function InsertText
*******************

parameters tcReport,;
	tnBand,;
	tcExpression,;
	tnWidth,;
	tnVPos,;
	tnHPos,;
	tcAlign,;
	tcStyle,;
	tnFontSize 
private lnAlign,;
	lcStyle,;
	lnWidth,;
	lnVPos,;
	lnHPos
do case
	case type('tcAlign') <> 'C' or IsEmpty(tcAlign) or tcAlign = 'Left'
		lnAlign = 0
	case tcAlign = 'Right'
		lnAlign = 1
	otherwise
		lnAlign = 2
endcase
lcStyle = iif(IsEmpty(tcStyle), '', tcStyle)
lnWidth = tnWidth * pnWTextFactor
lnVPos  = tnVPos  * m.pnVPosFactor + tnBand * cnFactor
lnHPos  = tnHPos  * m.pnHPosFactor
lnFontsize = iif(type('tnFontSize')='N',tnFontSize,8)
insert into (tcReport);
		(PLATFORM,;
		UNIQUEID,;
		OBJTYPE,;
		OBJCODE,;
		EXPR,;
		HEIGHT,;
		WIDTH,;
		VPOS,;
		HPOS,;
		STYLE,;
		PENRED,;
		PENGREEN,;
		PENBLUE,;
		FILLRED,;
		FILLGREEN,;
		FILLBLUE,;
		MODE,;
		TOP,;
		RESETTOTAL,;
		SUPRPCOL,;
		STRETCH,;
		OFFSET,;
		SUPALWAYS,;
		FONTFACE,;
		FONTSIZE,;
		SUPEXPR);
	values;
		('WINDOWS',;
		sys(2015),;
		5,;
		0,;
		tcExpression,;
		pnHTextFactor,;
		lnWidth,;
		lnVPos,;
		lnHPos,;
		lcStyle,;
		-1,;
		-1,;
		-1,;
		-1,;
		-1,;
		-1,;
		1,;
		.T.,;
		1,;
		3,;
		.T.,;
		lnAlign,;
		.T.,;
		ccFont,;
		lnFontSIZE,;
		"")
return

*******************
function InsertLine
*******************
parameters tcReport,;
	tnBand,;
	tnWidth,;
	tnVPos,;
	tnHPos,;
	tnHeight,;
	tnPenSize
private lnHeight
lnHeight = iif(type('tnHeight')='N',tnHeight* pnHFieldFactor,cnFactor)
lnPenSize = iif(type('tnPenSize')='N',tnPenSize,0)
insert into (tcReport);
		(PLATFORM,;
		UNIQUEID,;
		OBJTYPE,;
		OBJCODE,;
		HEIGHT,;
		WIDTH,;
		VPOS,;
		HPOS,;
		FLOAT,;
		PENSIZE,;
		PENPAT,;
		SUPALWAYS,;
		SUPEXPR);
	values;
		('WINDOWS',;
		sys(2015),;
		6,;
		0,;
		lnHeight,;
		tnWidth * pnWFieldFactor,;
		tnVPos * m.pnVPosFactor + (tnBand - 1) * cnFactor + 8 * cnFactor,;
		tnHPos * m.pnHPosFactor,;
		.t.,;
		lnPenSize,;
		8,;
		.T.,;
		"")
return


*******************
function InsertGroup
*******************
parameters tcReport,;
	tcGroup
insert into (tcReport);
		(PLATFORM,;
		UNIQUEID,;
		EXPR,;
		OBJTYPE,;
		OBJCODE,;
		NOREPEAT,;
		PAGEBREAK,;
		COLBREAK,;
		RESETPAGE);
	values;
		('WINDOWS',;
		sys(2015),;
		"PAGINAS",;
		9,;
		3,;
		.T.,;
		.T.,;
		.F.,;
		.F.)
return

**********************
function InsertPicture
**********************

parameters tcReport,;
	tnBand,;
	tcExpression,;
	tnWidth,;
	tnHeight,;
	tnVPos,;
	tnHPos,;
	tcPicture
private lcPicture,;
	lnWidth,;
	lnVPos,;
	lnHPos,;
	lnHeight

lcPicture = iif(IsEmpty(tcPicture), '', '"'+tcPicture+'"')
lnHeight = iif(type('tnHeight')='N',tnHeight*pnHFieldFactor,cnFactor)
lnWidth   = tnWidth * pnWFieldFactor
lnVPos    = tnVPos  * m.pnVPosFactor + (tnBand - 1) * cnFactor
lnHPos    = tnHPos  * m.pnHPosFactor
insert into (tcReport);
		(PLATFORM,;	
		UNIQUEID,;	
		OBJTYPE,;	
		OBJCODE,;	
		EXPR,;	
		HEIGHT,;	
		WIDTH,;	
		VPOS,;		
		HPOS,;		
		PICTURE,;	
		GENERAL,;
		MODE,;		
		SUPALWAYS);
	values;
		('WINDOWS',;
		sys(2015),;
		17,;
		0,;
		tcExpression,;
		pnHFieldFactor * tnHeight,;
		lnWidth,;
		lnVPos,;
		lnHPos,;
		lcPicture,;
		1,;
		1,;
		.T.)
return

**************************
 Function InsertNewPage
**************************

Select (lcReport)

*// The width of the report in characters is the width of the report in 0.1 mm
*// (as returned by either PRTINFO(4) or PRTINFO(4), depending on whether we're
*// using portrait or landscape, which is returned in PRTINFO(1)) divided by 254
*// (0.1 mm per inch) to give inches, less 2 x 0.25" margins (left and right
*// margins for a typical laser printer), and multiplied by the number of
*// characters per inch (10000/m.pnHPosFactor).

lnRepWidth = 180

*// Find out where the each band starts. Column headers will go on line 5 and the
*// detail band will be 3 rows plus the header height lower than that.

lnHeader     = 11
lnDetail     = lnHeader + tnHeadHeight + 1
lnHeaderBand = 1
lnDetailBand = 2
lnDetailInic = 500

*// Put in the report header and band records.

do InsertHeader with lcReport
do InsertBand   with lcReport, 1, 'Page Header', lnDetail - 1
do InsertBand   with lcReport, 2, 'Detail',  15000

do InsertBand   with lcReport, 3, 'Page Footer', 0

do InsertLine  with lcReport, lnHeaderBand, .165, 4 , tnMargin ,7,3
replace float with .t.,top with .f.,bottom with .f.

do InsertLine  with lcReport, lnHeaderBand, 169,4, tnMargin,'',4
replace float with .t.,top with .f.,bottom with .f.

do InsertLine  with lcReport, lnHeaderBand, .165, 4 , tnMargin+169 ,7,3
replace float with .t.,top with .f.,bottom with .f.

return

**************************
 Function InsertNewHeader
**************************

lcPicture = 'CADASTRO.BMP'
do InsertPicture with lcReport, lnHeaderBand,'',15,10,6,2,lcPicture

lnPenRed = 0
lnPenGreen = 0
lnPenBlue = 160
pcHeader = 'Programa de Produ' + CHR(231) + '' + CHR(227) + 'o Textura' + CHR(231) + '' + CHR(227) + 'o '
do InsertField with lcReport, lnHeaderBand,;
	'"Programa de Produ' + CHR(231) + '' + CHR(227) + 'o Textura' + CHR(231) + '' + CHR(227) + 'o "', 50, 2, 5, 60,;
	'Center', .T., 'C', '"@I"',9,1,lnPenRed,lnPenGreen,lnPenBlue

lnPenRed = 255
lnPenGreen = 0
lnPenBlue = 0
do InsertText  with lcReport, lnHeaderBand, '"M' + CHR(234) + 's : "', 6,5,140,'','',8
do InsertField with lcReport, lnHeaderBand, 'tcmes+"/"+tcano',;
	20, 2, 5, 146, 'Left',.f.,.f.,'',8,0,lnPenRed,lnPenGreen,lnPenBlue

lnPenRed = 0
lnPenGreen = 0
lnPenBlue = 160
pcHeader = 'Unidade Jacare' + CHR(237) + ''
do InsertField with lcReport, lnHeaderBand,;
	'"Unidade Jacare' + CHR(237) + '"', 50, 2, 7, 60,;
	'Center', .T., 'C', '"@I"',9,1,lnPenRed,lnPenGreen,lnPenBlue
	
lnPenRed = 255
lnPenGreen = 0
lnPenBlue = 0
do InsertField with lcReport, lnHeaderBand, '"Vers' + CHR(227) + 'o "+tcversao',;
	9, 2, 7.2, 140, 'Left',.f.,.f.,'',8,0,lnPenRed,lnPenGreen,lnPenBlue

do InsertText  with lcReport, lnHeaderBand, '"Data de Emiss' + CHR(227) + 'o : "', 18, 9.5,140,'','',7
do InsertField with lcReport, lnHeaderBand, 'date()',;
	iif(set('CENTURY') = 'ON', 10, 8), 1, 9.5, 150, 'Right',.f.,.f.,'',7 &&tnMargin
do InsertLine  with lcReport, lnHeaderBand, .165, lnHeader-1 , tnMargin ,2.5,3
do InsertLine  with lcReport, lnHeaderBand, 169, lnHeader - 1, tnMargin,.2,3
do InsertLine  with lcReport, lnHeaderBand, 169, lnHeader + tnHeadHeight+2,;
	tnMargin,.2,3

*// Add a line just above the details with a Print When so it only appears for
*// the "totals" record. Use "lnDetail - 0.5" instead of "lnDetail - 1" for a
*// report with less space between rows.


*// Put the first table column in the first column of the report.
tnMargin = 9
ndiames = val(left(dtoc(GoMonth(ctod('1/'+tcmesano),1)-1),2))
for lncolumn  = 1 to ndiames
	pcColumn = padc(transform(lncolumn,'@Z 99'),6)
	tnWidth1 = 6
	tnMargin = tnMargin + 5
	do InsertLine  with lcReport, lnHeaderBand, .165, lnHeader-1 , tnMargin ,2.2
	ndsemana = str(lncolumn,2)+'/'+tcmesano
	If Inlist(dow(ctod(ndsemana)),1,7)
			lnPenRed = 0
			lnPenGreen = 0
			lnPenBlue = 0
			lnFillRed = 210
			lnFillGreen = 210
			lnFillBlue = 210
		do InsertShape with lcReport, lnHeaderBand, '',;
			 tnWidth1-1.3, tnHeadHeight+.35,  lnHeader-.16, tnMargin+.26, 'Left',;
			.f., '', '','6','',lnPenRed ,lnPenGreen,lnPenBlue ,lnFillRed,;
			lnFillGreen ,lnFillBlue,0
	Endif
	do InsertField with lcReport, lnHeaderBand, pcColumn, tnWidth1,;
		tnHeadHeight, lnHeader, tnMargin , '2', .f.,'','',6,1
EndFor
tnMargin = tnMargin + 5 
do InsertLine  with lcReport, lnDetailBand, .165, lnDetail-1.2 , tnMargin ,2.2,3
tnMargin = tnMargin + (5 * (31-ndiames))
do InsertLine  with lcReport, lnDetailBand, .165, lnDetail-.8 , tnMargin ,2.2,3
do InsertLine  with lcReport, lnHeaderBand, .165, lnHeader-1 , tnMargin ,2.5,3

return
*****************************
 Function InsertLastRowPage
*****************************
do InsertLine  with lcReport, lnDetailBand, 169, lnDetail-.9 , 0,.2,3
do InsertLine  with lcReport, lnDetailBand, .165, lnDetail-.9 , 0 ,2.2,3
tnMargin = 9
ndiames = val(left(dtoc(GoMonth(ctod('1/'+tcmesano),1)-1),2))
for lncolumn  = 1 to ndiames
	pcColumn = padc(transform(lncolumn,'@Z 99'),6)
	tnWidth1 = 6
	tnMargin = tnMargin + 5
	do InsertLine  with lcReport, lnDetailBand, .165, lnDetail-.9 , tnMargin ,2.2
	ndsemana = str(lncolumn,2)+'/'+tcmesano
	If Inlist(dow(ctod(ndsemana)),1,7)
			lnPenRed = 0
			lnPenGreen = 0
			lnPenBlue = 0
			lnFillRed = 210
			lnFillGreen = 210
			lnFillBlue = 210
		do InsertShape with lcReport, lnDetailBand, '',;
			 tnWidth1-1.3, 2.1, lnDetail-.18, tnMargin+.28, 'Left',;
			.f., '', '','6','',lnPenRed ,lnPenGreen,lnPenBlue ,lnFillRed,;
			lnFillGreen ,lnFillBlue,0
	Endif
	do InsertField with lcReport, lnDetailBand, pcColumn, tnWidth1,;
		2, lnDetail, tnMargin , '2', .f.,'','',6,1
EndFor
tnMargin = tnMargin + 5 
do InsertLine  with lcReport, lnDetailBand, .165, lnDetail-1 , tnMargin ,2.2,3
tnMargin = tnMargin + (5 * (31-ndiames))
do InsertLine  with lcReport, lnDetailBand, .165, lnDetail-1 , tnMargin ,2.2,3
do InsertLine  with lcReport, lnDetailBand, 169, lnDetail+1.2 , 0,.2,3

tnMargin = 1

lcLegenda = 'Lotes de Ensaio'
do InsertShape with lcReport,  lnDetailBand, '',;
	 2, 1.8, lnDetail+3, tnMargin, 'Left',;
	.f., '', '','6','',-1 ,-1,-1 ,249,251,145,0
do InsertField with lcReport,  lnDetailBand,;
	'"'+lcLegenda+'"', len(lcLegenda), 1, lnDetail+3, tnMargin+2.5

tnMargin = tnMargin + 13
 	
lcLegenda = 'Perda de Produ' + CHR(231) + '' + CHR(227) + 'o / Ensaio'
do InsertShape with lcReport,  lnDetailBand, '',;
	 2, 1.8, lnDetail+3, tnMargin, 'Left',;
	.f., '', '','6','',-1 ,-1,-1 ,248,239 ,239,0
do InsertField with lcReport,  lnDetailBand,;
	'"'+lcLegenda+'"', len(lcLegenda), 1, lnDetail+3, tnMargin+2.5
	
tnMargin = tnMargin + 20
lcLegenda = 'Queda de Energia'
do InsertShape with lcReport,  lnDetailBand, '',;
	 2, 1.8, lnDetail+3, tnMargin, 'Left',;
	.f., '', '','6','',-1 ,-1,-1 ,230,230,255,0
do InsertField with lcReport,  lnDetailBand,;
	'"'+lcLegenda+'"', len(lcLegenda), 1, lnDetail+3,tnMargin+2.5
	
tnMargin = tnMargin + 15
lcLegenda = 'Manuten' + CHR(231) + '' + CHR(227) + 'o'
do InsertShape with lcReport,  lnDetailBand, '',;
	 2, 1.8, lnDetail+3, tnMargin, 'Left',;
	.f., '', '','6','',-1 ,-1,-1 ,255,0 ,0,0
do InsertField with lcReport,  lnDetailBand,;
	'"'+lcLegenda+'"', len(lcLegenda), 1, lnDetail+3, tnMargin+2.5

tnMargin = tnMargin + 12
lcLegenda = 'Textura' + CHR(231) + '' + CHR(227) + 'o'
do InsertShape with lcReport,  lnDetailBand, '',;
	 2, 1.8, lnDetail+3, tnMargin, 'Left',;
	.f., '', '','6','',-1 ,-1,-1 ,234,255 ,255,0
do InsertField with lcReport,  lnDetailBand,;
	'"'+lcLegenda+'"', len(lcLegenda), 1, lnDetail+3, tnMargin+2.5

tnMargin = tnMargin + 12
lcLegenda = 'Reserva T' + CHR(233) + 'cnica'
do InsertShape with lcReport,  lnDetailBand, '',;
	 2, 1.8, lnDetail+3, tnMargin, 'Left',;
	.f., '', '','6','',-1 ,-1,-1 ,183,254 ,158,0
do InsertField with lcReport,  lnDetailBand,;
	'"'+lcLegenda+'"', len(lcLegenda), 1, lnDetail+3, tnMargin+2.5

return
*==============================================================================
*// Function:			CreateUniqueAlias
*// Purpose:			Creates a unique alias
*// Author:			Doug Hennig
*// Copyright:		(c) 1996 Stonefield Systems Group Inc.
*// Last Revision:	01/01/97
*// Parameters:		none
*// Returns:			a unique alias
*// Environment in:	none
*// Environment out:	none
*==============================================================================

function CreateUniqueAlias
local lcAlias
m.lcAlias = sys(2015)
do while used(m.lcAlias)
	m.lcAlias = sys(2015)
enddo while used(m.lcAlias)
return(m.lcAlias)

*===========================================================================
*// Function:			NumericPicture
*// Purpose:			Calculate the picture for a numeric field with commas
*// Author:			Doug Hennig
*// Copyright:		(c) 1996 Stonefield Systems Group Inc.
*// Last Revision:	10/14/96
*// Parameters:		tnWidth - the width of the field
*// Returns:			a numeric picture string with commas
*// Environment in:	none
*// Environment out:	none
*// Routines used:	none
*===========================================================================

function NumericPicture
parameters tnWidth
private lcPicture
lcPicture = '9'
do while len(lcPicture) < tnWidth
	if mod(len(lcPicture) + 1, 4) = 0
		lcPicture = '9,' + lcPicture
	else
		lcPicture = '9' + lcPicture
	endif mod(len(lcPicture) ...
enddo while len(lcPicture) < tnWidth
return lcPicture


DEFINE CLASS ImpNF as ReportListener
	oGraphics = .NULL.
	oFont = .NULL.
	oFormat = .NULL.
	oFillColor = .NULL.
	oBrush = .NULL.
	oPen = .Null.
	oBmp = .Null.
	oImage = .Null.
	lDetail = .f.
	pnFatorLinhaGDI = 0
	ListenerType = 1
	DynamicLineHeight = .F.
	
	PROCEDURE Init
		*!* Unfortunately, StringTrimming isn't just a property we can flip.
		*!* It's part of the formatting we use to draw a string. Hence, to
		*!* change this, we need to do all the work needed to actually
		*!* draw the string.
		*!*
		*!* Note, of course, that there's a setting you can change within the
		*!* Report Designer to change the behavior of StringTrimming. This 
		*!* code just shows how to do it with a ReportListener.

		*!* gpGraphics gives us a surface to draw on.
		This.oGraphics = NEWOBJECT("gpGraphics", gc_4c_CaminhoFramework + "ClassGdi.vcx")				

		This.oFont = NEWOBJECT("gpFont", gc_4c_CaminhoFramework + "ClassGdi.vcx")
		This.oFont.Create(Alltrim(FRX.FontFace), FRX.FontSize, GDIPLUS_FontStyle_Regular, GDIPLUS_Unit_Point)

		This.oFormat = NEWOBJECT("gpStringFormat", gc_4c_CaminhoFramework + "ClassGdi.vcx")
		This.oFormat.Create()

		This.oFillColor = NEWOBJECT("gpColor", gc_4c_CaminhoFramework + "ClassGdi.vcx")
		This.oFillColor.Set(0, 0, 0, 255)	&& RGB + Alpha (transparency)
		
		This.oBrush = NEWOBJECT("gpSolidBrush", gc_4c_CaminhoFramework + "ClassGdi.vcx")
		This.oBrush.Create(This.oFillColor)

		This.oPen = NEWOBJECT("gpPen", gc_4c_CaminhoFramework + "ClassGdi.vcx")

		This.oPen.Create()
		This.oPen.PenColor = This.oBrush.BrushColor

		This.oBmp = NEWOBJECT("gpBitMap", gc_4c_CaminhoFramework + "ClassGdi.vcx")

		This.oImage = NEWOBJECT("gpImage", gc_4c_CaminhoFramework + "ClassGdi.vcx")

	ENDPROC

	PROCEDURE Destroy
		This.oGraphics = .NULL.
		This.oFont = .NULL.
		This.oFormat = .NULL.
		This.oFillColor = .NULL.
		This.oBrush = .NULL.
	ENDPROC
	
	*!* In here, we only want to change the text in the detail lines. So,
	*!* on the way into the detail band, we set a property to tell us
	*!* that we're in that band. On the way out, we turn it back off.
	PROCEDURE BeforeBand
		LPARAMETERS nBandObjCode, nFRXRecNo
		
		IF nBandObjCode = FRX_OBJCOD_DETAIL
			This.lDetail = .T.
		ENDIF
	ENDPROC
	
	PROCEDURE AfterBand
		LPARAMETERS nBandObjCode, nFRXRecNo
		
		IF nBandObjCode = FRX_OBJCOD_DETAIL
			This.lDetail = .F.
		ENDIF
		DODEFAULT(nBandObjCode, nFRXRecNo)
	ENDPROC
	
	Procedure EvaluateContents(nFrxRecno, oObjProperties)

	EndProc 
	
	PROCEDURE Render
		LPARAMETERS nFRXRecNo,;
					nLeft, nTop, nWidth, nHeight,;
					nObjectContinuationType, ;
					cContentsToBeRendered, GDIPlusImage

		Local oBounds,lnWRect1,lnHRect1,lnRec1,lnColRect1,lnLLabel1,lnTLabel1,lnPosPag1,lnTamAux,lnFator

		IF This.lDetail

			*!* Tell the graphics class what we're drawing on
			This.oGraphics.SetHandle(This.GDIPlusGraphics)
			This.oGraphics.ResetTransform()								

			m.lnFator = 12
			m.lcContext1 = Alltrim(Strconv(m.cContentsToBeRendered, 6))

			Go nFrxRecno in FRX							

			If( nLeft+nWidth > oListener.GetPageWidth() ) Then
				nWidth = oListener.GetPageWidth()-nLeft

			EndIf

			This.mMakeField(m.lcContext1, ;
							nLeft, ;
							(nTop * This.pnFatorLinhaGDI), ;
							nWidth, ;
							nHeight, ;
							Alltrim(FRX.FontFace), ;
							(FRX.FontSize * m.lnFator), ;
							Substr('left  right centerleft  ', ((Val(FRX.supexpr) + 1) * 6 - 5), 6), ;
							Val(FRX.Comment), ;
							Rgb(0, 0, 0),; 
							Rgb(255, 255, 255), ;
							Iif(FRX.FontStyle==1, 1, 0), ;
							nLeft, ;
							nTop)

		Else 
			*!* If we're not in the detail band, let Fox draw the text as
			*!* usual.

			DODEFAULT(nFRXRecNo, nLeft, nTop, nWidth, nHeight, ;
				nObjectContinuationType, cContentsToBeRendered, GDIPlusImage)

		EndIf 

		*!* Since we already drew the text, we don't want the default
		*!* behavior to occur.
		NODEFAULT

	EndProc			

	Procedure mMakeField

		Lparameters pcConteudo, pnLeft, pnTop, pnWidth, pnLenght, pcFontName, pnFontSize, pcAligment, ;
					lnAngulo, pnColor, bcColor, pnNegrito, nLeft, nTop

		Local lcColor, lnRed, lnGreen, lnBlue
		
		If Len(pcConteudo) < 3 And Val(pcConteudo) = 0
			pnWidth = pnWidth * 1.5
		Endif 

		This.oGraphics.ResetTransform()

		If ! lnAngulo = 0
			This.oGraphics.TranslateTransform(nLeft, nTop, 0)
			This.oGraphics.RotateTransform(lnAngulo,0)
			This.oGraphics.TranslateTransform(-nLeft, -nTop, 0)
		Else
			This.oGraphics.RotateTransform(lnAngulo,0)
		Endif

		lcRect = This.oGraphics.MakeGdipRectF(pnLeft, pnTop, pnWidth, pnLenght)

		This.oFont.Create( pcFontName ;	
						  , pnFontSize;	
						  , Iif(pnNegrito = 1, GDIPLUS_FontStyle_Bold, GDIPLUS_FontStyle_Regular);	
						  , GDIPLUS_Unit_World)	

		Do Case 
			
			Case Upper(pcAligment) = 'LEFT'
				This.oFormat.Alignment = GDIPLUS_STRINGALIGNMENT_Near

			Case Upper(pcAligment) = 'CENTER'
				This.oFormat.Alignment = GDIPLUS_STRINGALIGNMENT_Center

			Case Upper(pcAligment) = 'RIGHT'
				This.oFormat.Alignment = GDIPLUS_STRINGALIGNMENT_Far	
				
		EndCase

		This.oGraphics.DrawStringA(pcConteudo, This.oFont, lcRect, This.oFormat, This.oBrush)	
		
	EndProc
	
EndDefine

