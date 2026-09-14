# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 342: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpr.prg) - TRECHOS RELEVANTES PARA PASS GRID (890 linhas total):

*-- Linhas 328 a 390:
328: 			.Themes          = .F.
329: 			.SpecialEffect   = 0
330: 			.MousePointer    = 15
331: 			.WordWrap        = .T.
332: 			.AutoSize        = .F.
333: 			.Visible         = .T.
334: 		ENDWITH
335: 		BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
336: 
337: 		*-- Grid de lista (Grade: Top=121+29=150, Left=12, Width=935, Height=470)
338: 		loc_oPagina.AddObject("grd_4c_Lista", "Grid")
339: 		loc_oGrid = loc_oPagina.grd_4c_Lista
340: 
341: 		loc_oGrid.ColumnCount  = 2
342: 		loc_oGrid.RecordSource = "cursor_4c_Dados"
343: 
344: 		WITH loc_oGrid
345: 			.Top                = 150
346: 			.Left               = 12
347: 			.Width              = 935
348: 			.Height             = 470
349: 			.FontName           = "Tahoma"
350: 			.FontSize           = 8
351: 			.ForeColor          = RGB(90, 90, 90)
352: 			.BackColor          = RGB(255, 255, 255)
353: 			.GridLineColor      = RGB(238, 238, 238)
354: 			.HighlightBackColor = RGB(255, 255, 255)
355: 			.HighlightForeColor = RGB(15, 41, 104)
356: 			.HighlightStyle     = 2
357: 			.DeleteMark         = .F.
358: 			.RecordMark         = .F.
359: 			.RowHeight          = 16
360: 			.ScrollBars         = 2
361: 			.GridLines          = 3
362: 			.Visible            = .T.
363: 		ENDWITH
364: 
365: 		*-- ControlSource e Headers APOS RecordSource (VFP reseta headers ao mudar RecordSource)
366: 		WITH loc_oGrid.Column1
367: 			.ControlSource   = "cursor_4c_Dados.Cods"
368: 			.Width           = 60
369: 			.Header1.Caption = "C" + CHR(243) + "digos"
370: 		ENDWITH
371: 
372: 		WITH loc_oGrid.Column2
373: 			.ControlSource   = "cursor_4c_Dados.Descs"
374: 			.Width           = 150
375: 			.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
376: 		ENDWITH
377: 
378: 		THIS.TornarControlesVisiveis(loc_oPagina)
379: 	ENDPROC
380: 
381: 	*====================================================================
382: 	* ConfigurarPaginaDados - Page2 (Dados)
383: 	* Grupo_Salva: Left=819,Top=10 -> Top=10+29=39
384: 	* Say1 (C" + CHR(243) + "digo): Top=157+29=186, Left=374
385: 	* getCods (txt_4c_Codigo): Top=153+29=182, Left=422, Width=31
386: 	*====================================================================
387: 	PROTECTED PROCEDURE ConfigurarPaginaDados()
388: 		LOCAL loc_oPagina
389: 		loc_oPagina = THIS.pgf_4c_Paginas.Page2
390: 

*-- Linhas 529 a 567:
529: 
530: 	*====================================================================
531: 	* CarregarLista - Carrega dados no Grid da Page1
532: 	* Busca todos os registros de SigCdFip e popula grd_4c_Lista
533: 	*====================================================================
534: 	PROCEDURE CarregarLista()
535: 		LOCAL loc_lResultado, loc_oGrid
536: 		loc_lResultado = .F.
537: 
538: 		IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
539: 			loc_lResultado = .T.
540: 		ELSE
541: 			TRY
542: 				loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
543: 
544: 				IF !THIS.this_oBusinessObject.Buscar("")
545: 					loc_lResultado = .F.
546: 				ELSE
547: 					loc_oGrid.ColumnCount = 2
548: 					loc_oGrid.RecordSource = "cursor_4c_Dados"
549: 					loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
550: 					loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
551: 					loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
552: 					loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
553: 					loc_oGrid.Column1.Width           = 60
554: 					loc_oGrid.Column2.Width           = 150
555: 					THIS.FormatarGridLista(loc_oGrid)
556: 					loc_lResultado = .T.
557: 				ENDIF
558: 
559: 			CATCH TO loException
560: 				MostrarErro(loException, "FormFpr.CarregarLista")
561: 				loc_lResultado = .F.
562: 			ENDTRY
563: 		ENDIF
564: 
565: 		RETURN loc_lResultado
566: 	ENDPROC
567: 

