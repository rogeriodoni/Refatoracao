# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 340: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpr.prg) - TRECHOS RELEVANTES PARA PASS GRID (889 linhas total):

*-- Linhas 326 a 389:
326: 			.Themes          = .F.
327: 			.SpecialEffect   = 0
328: 			.MousePointer    = 15
329: 			.WordWrap        = .T.
330: 			.AutoSize        = .F.
331: 			.Visible         = .T.
332: 		ENDWITH
333: 		BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335: 		*-- Grid de lista (Grade: Top=121+29=150, Left=12, Width=935, Height=470)
336: 		loc_oPagina.AddObject("grd_4c_Lista", "Grid")
337: 		loc_oGrid = loc_oPagina.grd_4c_Lista
338: 
339: 		loc_oGrid.ColumnCount = 3
340: 		loc_oGrid.RecordSource = "cursor_4c_Dados"
341: 		loc_oGrid.ColumnCount  = 2
342: 
343: 		WITH loc_oGrid
344: 			.Top                = 150
345: 			.Left               = 12
346: 			.Width              = 935
347: 			.Height             = 470
348: 			.FontName           = "Tahoma"
349: 			.FontSize           = 8
350: 			.ForeColor          = RGB(90, 90, 90)
351: 			.BackColor          = RGB(255, 255, 255)
352: 			.GridLineColor      = RGB(238, 238, 238)
353: 			.HighlightBackColor = RGB(255, 255, 255)
354: 			.HighlightForeColor = RGB(15, 41, 104)
355: 			.HighlightStyle     = 2
356: 			.DeleteMark         = .F.
357: 			.RecordMark         = .F.
358: 			.RowHeight          = 16
359: 			.ScrollBars         = 2
360: 			.GridLines          = 3
361: 			.Visible            = .T.
362: 		ENDWITH
363: 
364: 		*-- ControlSource e Headers APOS RecordSource (VFP reseta headers ao mudar RecordSource)
365: 		WITH loc_oGrid.Column1
366: 			.ControlSource   = "cursor_4c_Dados.Cods"
367: 			.Width           = 60
368: 			.Header1.Caption = "C" + CHR(243) + "digos"
369: 		ENDWITH
370: 
371: 		WITH loc_oGrid.Column2
372: 			.ControlSource   = "cursor_4c_Dados.Descs"
373: 			.Width           = 150
374: 			.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
375: 		ENDWITH
376: 
377: 		THIS.TornarControlesVisiveis(loc_oPagina)
378: 	ENDPROC
379: 
380: 	*====================================================================
381: 	* ConfigurarPaginaDados - Page2 (Dados)
382: 	* Grupo_Salva: Left=819,Top=10 -> Top=10+29=39
383: 	* Say1 (C" + CHR(243) + "digo): Top=157+29=186, Left=374
384: 	* getCods (txt_4c_Codigo): Top=153+29=182, Left=422, Width=31
385: 	*====================================================================
386: 	PROTECTED PROCEDURE ConfigurarPaginaDados()
387: 		LOCAL loc_oPagina
388: 		loc_oPagina = THIS.pgf_4c_Paginas.Page2
389: 

*-- Linhas 528 a 566:
528: 
529: 	*====================================================================
530: 	* CarregarLista - Carrega dados no Grid da Page1
531: 	* Busca todos os registros de SigCdFip e popula grd_4c_Lista
532: 	*====================================================================
533: 	PROCEDURE CarregarLista()
534: 		LOCAL loc_lResultado, loc_oGrid
535: 		loc_lResultado = .F.
536: 
537: 		IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
538: 			loc_lResultado = .T.
539: 		ELSE
540: 			TRY
541: 				loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
542: 
543: 				IF !THIS.this_oBusinessObject.Buscar("")
544: 					loc_lResultado = .F.
545: 				ELSE
546: 					loc_oGrid.ColumnCount = 2
547: 					loc_oGrid.RecordSource = "cursor_4c_Dados"
548: 					loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
549: 					loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
550: 					loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
551: 					loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
552: 					loc_oGrid.Column1.Width           = 60
553: 					loc_oGrid.Column2.Width           = 150
554: 					THIS.FormatarGridLista(loc_oGrid)
555: 					loc_lResultado = .T.
556: 				ENDIF
557: 
558: 			CATCH TO loException
559: 				MostrarErro(loException, "FormFpr.CarregarLista")
560: 				loc_lResultado = .F.
561: 			ENDTRY
562: 		ENDIF
563: 
564: 		RETURN loc_lResultado
565: 	ENDPROC
566: 

