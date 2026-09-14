# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 189: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2567 linhas total):

*-- Linhas 103 a 200:
103: 	PROTECTED PROCEDURE ConfigurarCabecalho()
104: 		THIS.AddObject("cnt_4c_Cabecalho", "Container")
105: 		WITH THIS.cnt_4c_Cabecalho
106: 			.Top = 0
107: 			.Left = 0
108: 			.Width = THIS.Width
109: 			.Height = 80
110: 			.BackStyle = 1
111: 			.BackColor = RGB(100, 100, 100)
112: 			.BorderWidth = 0
113: 			.Visible = .T.
114: 
115: 			.AddObject("lbl_4c_Sombra", "Label")
116: 			WITH .lbl_4c_Sombra
117: 				.AutoSize = .F.
118: 				.FontBold = .T.
119: 				.FontName = "Tahoma"
120: 				.FontSize = 18
121: 				.WordWrap = .T.
122: 				.Alignment = 0
123: 				.BackStyle = 0
124: 				.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
125: 				.Height = 40
126: 				.Left = 10
127: 				.Top = 18
128: 				.Width = THIS.Width
129: 				.ForeColor = RGB(0, 0, 0)
130: 			ENDWITH
131: 
132: 			.AddObject("lbl_4c_Titulo", "Label")
133: 			WITH .lbl_4c_Titulo
134: 				.AutoSize = .F.
135: 				.FontBold = .T.
136: 				.FontName = "Tahoma"
137: 				.FontSize = 18
138: 				.WordWrap = .T.
139: 				.Alignment = 0
140: 				.BackStyle = 0
141: 				.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
142: 				.Height = 46
143: 				.Left = 10
144: 				.Top = 17
145: 				.Width = THIS.Width
146: 				.ForeColor = RGB(255, 255, 255)
147: 			ENDWITH
148: 		ENDWITH
149: 	ENDPROC
150: 
151: 	*====================================================================
152: 	* ConfigurarBotoesAcao - CommandGroup Imprimir + Encerrar
153: 	*====================================================================
154: 	PROTECTED PROCEDURE ConfigurarBotoesAcao()
155: 		THIS.AddObject("cmg_4c_BtnReport", "CommandGroup")
156: 		WITH THIS.cmg_4c_BtnReport
157: 			.Top = -2
158: 			.Left = THIS.Width - 162
159: 			.Width = 162
160: 			.Height = 85
161: 			.BackStyle = 0
162: 			.BorderStyle = 0
163: 			.SpecialEffect = 1
164: 			.ButtonCount = 2
165: 			.Themes = .F.
166: 			.ZOrder(0)
167: 
168: 			WITH .Buttons(1)
169: 				.Top = 5
170: 				.Left = 5
171: 				.Height = 75
172: 				.Width = 75
173: 				.FontBold = .T.
174: 				.FontItalic = .T.
175: 				.WordWrap = .T.
176: 				.Picture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
177: 				.Caption = "\<Imprimir"
178: 				.ForeColor = RGB(90, 90, 90)
179: 				.BackColor = RGB(255, 255, 255)
180: 				.Themes = .F.
181: 			ENDWITH
182: 
183: 			WITH .Buttons(2)
184: 				.Top = 5
185: 				.Left = 81
186: 				.Height = 75
187: 				.Width = 75
188: 				.FontBold = .T.
189: 				.FontItalic = .T.
190: 				.FontName = "Comic Sans MS"
191: 				.FontSize = 8
192: 				.WordWrap = .T.
193: 				.Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
194: 				.Cancel = .T.
195: 				.Caption = "Encerrar"
196: 				.ForeColor = RGB(90, 90, 90)
197: 				.BackColor = RGB(255, 255, 255)
198: 				.Themes = .F.
199: 			ENDWITH
200: 		ENDWITH

*-- Linhas 249 a 495:
249: 		*-- Linha 1: Empresa / Operacao (top=88)
250: 		loc_nTop = 88
251: 
252: 		THIS.AddObject("lbl_4c_LEmps", "Label")
253: 		WITH THIS.lbl_4c_LEmps
254: 			.AutoSize  = .F.
255: 			.Caption   = "Empresa:"
256: 			.Top       = loc_nTop + 3
257: 			.Left      = 12
258: 			.Width     = 58
259: 			.Height    = 18
260: 			.FontName  = "Tahoma"
261: 			.FontSize  = 8
262: 			.BackStyle = 0
263: 			.ForeColor = RGB(255, 255, 255)
264: 		ENDWITH
265: 
266: 		THIS.AddObject("txt_4c_Emps", "TextBox")
267: 		WITH THIS.txt_4c_Emps
268: 			.Top       = loc_nTop
269: 			.Left      = 73
270: 			.Width     = 36
271: 			.Height    = 22
272: 			.FontName  = "Tahoma"
273: 			.FontSize  = 8
274: 			.MaxLength = 3
275: 		ENDWITH
276: 
277: 		THIS.AddObject("lbl_4c_DEmps", "Label")
278: 		WITH THIS.lbl_4c_DEmps
279: 			.AutoSize  = .F.
280: 			.Caption   = ""
281: 			.Top       = loc_nTop + 3
282: 			.Left      = 112
283: 			.Width     = 200
284: 			.Height    = 18
285: 			.FontName  = "Tahoma"
286: 			.FontSize  = 8
287: 			.BackStyle = 0
288: 			.ForeColor = RGB(255, 255, 255)
289: 		ENDWITH
290: 
291: 		THIS.AddObject("lbl_4c_LDopes", "Label")
292: 		WITH THIS.lbl_4c_LDopes
293: 			.AutoSize  = .F.
294: 			.Caption   = "Opera" + CHR(231) + CHR(227) + "o:"
295: 			.Top       = loc_nTop + 3
296: 			.Left      = 320
297: 			.Width     = 65
298: 			.Height    = 18
299: 			.FontName  = "Tahoma"
300: 			.FontSize  = 8
301: 			.BackStyle = 0
302: 			.ForeColor = RGB(255, 255, 255)
303: 		ENDWITH
304: 
305: 		THIS.AddObject("txt_4c_Dopes", "TextBox")
306: 		WITH THIS.txt_4c_Dopes
307: 			.Top       = loc_nTop
308: 			.Left      = 388
309: 			.Width     = 195
310: 			.Height    = 22
311: 			.FontName  = "Tahoma"
312: 			.FontSize  = 8
313: 			.MaxLength = 20
314: 		ENDWITH
315: 
316: 		THIS.AddObject("lbl_4c_LNumes", "Label")
317: 		WITH THIS.lbl_4c_LNumes
318: 			.AutoSize  = .F.
319: 			.Caption   = "N" + CHR(250) + "m.:"
320: 			.Top       = loc_nTop + 3
321: 			.Left      = 590
322: 			.Width     = 35
323: 			.Height    = 18
324: 			.FontName  = "Tahoma"
325: 			.FontSize  = 8
326: 			.BackStyle = 0
327: 			.ForeColor = RGB(255, 255, 255)
328: 		ENDWITH
329: 
330: 		THIS.AddObject("txt_4c_Numes", "TextBox")
331: 		WITH THIS.txt_4c_Numes
332: 			.Top       = loc_nTop
333: 			.Left      = 628
334: 			.Width     = 55
335: 			.Height    = 22
336: 			.FontName  = "Tahoma"
337: 			.FontSize  = 8
338: 			.Value     = 0
339: 		ENDWITH
340: 
341: 		*-- Linha 2: Produto / Qtde (top=116)
342: 		loc_nTop = 116
343: 
344: 		THIS.AddObject("lbl_4c_LCpros", "Label")
345: 		WITH THIS.lbl_4c_LCpros
346: 			.AutoSize  = .F.
347: 			.Caption   = "Produto:"
348: 			.Top       = loc_nTop + 3
349: 			.Left      = 12
350: 			.Width     = 58
351: 			.Height    = 18
352: 			.FontName  = "Tahoma"
353: 			.FontSize  = 8
354: 			.BackStyle = 0
355: 			.ForeColor = RGB(255, 255, 255)
356: 		ENDWITH
357: 
358: 		THIS.AddObject("txt_4c_Cpros", "TextBox")
359: 		WITH THIS.txt_4c_Cpros
360: 			.Top       = loc_nTop
361: 			.Left      = 73
362: 			.Width     = 110
363: 			.Height    = 22
364: 			.FontName  = "Tahoma"
365: 			.FontSize  = 8
366: 			.MaxLength = 14
367: 		ENDWITH
368: 
369: 		THIS.AddObject("txt_4c_Dpros", "TextBox")
370: 		WITH THIS.txt_4c_Dpros
371: 			.Top       = loc_nTop
372: 			.Left      = 186
373: 			.Width     = 270
374: 			.Height    = 22
375: 			.FontName  = "Tahoma"
376: 			.FontSize  = 8
377: 			.MaxLength = 40
378: 		ENDWITH
379: 
380: 		THIS.AddObject("lbl_4c_LQtds", "Label")
381: 		WITH THIS.lbl_4c_LQtds
382: 			.AutoSize  = .F.
383: 			.Caption   = "Qtd:"
384: 			.Top       = loc_nTop + 3
385: 			.Left      = 460
386: 			.Width     = 30
387: 			.Height    = 18
388: 			.FontName  = "Tahoma"
389: 			.FontSize  = 8
390: 			.BackStyle = 0
391: 			.ForeColor = RGB(255, 255, 255)
392: 		ENDWITH
393: 
394: 		THIS.AddObject("txt_4c_Qtds", "TextBox")
395: 		WITH THIS.txt_4c_Qtds
396: 			.Top       = loc_nTop
397: 			.Left      = 493
398: 			.Width     = 65
399: 			.Height    = 22
400: 			.FontName  = "Tahoma"
401: 			.FontSize  = 8
402: 			.Value     = 0
403: 		ENDWITH
404: 
405: 		THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
406: 		WITH THIS.cmd_4c_BtnCarregar
407: 			.Top             = loc_nTop
408: 			.Left            = 373
409: 			.Width           = 26
410: 			.Height          = 26
411: 			.Caption         = ""
412: 			.Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
413: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
414: 			.ToolTipText     = "Carregar de movimento"
415: 			.Themes          = .T.
416: 		ENDWITH
417: 
418: 		THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
419: 		WITH THIS.cmd_4c_BtnExcluir
420: 			.Top             = loc_nTop
421: 			.Left            = 21
422: 			.Width           = 26
423: 			.Height          = 26
424: 			.Caption         = ""
425: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
426: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
427: 			.ToolTipText     = "Excluir linha selecionada"
428: 			.Themes          = .T.
429: 		ENDWITH
430: 
431: 		*-- Linha 3: Lista de Precos (top=144)
432: 		loc_nTop = 144
433: 
434: 		THIS.AddObject("lbl_4c_LLpreco", "Label")
435: 		WITH THIS.lbl_4c_LLpreco
436: 			.AutoSize  = .F.
437: 			.Caption   = "Lista Pre" + CHR(231) + "o:"
438: 			.Top       = loc_nTop + 3
439: 			.Left      = 12
440: 			.Width     = 70
441: 			.Height    = 18
442: 			.FontName  = "Tahoma"
443: 			.FontSize  = 8
444: 			.BackStyle = 0
445: 			.ForeColor = RGB(255, 255, 255)
446: 		ENDWITH
447: 
448: 		THIS.AddObject("txt_4c_Lpreco", "TextBox")
449: 		WITH THIS.txt_4c_Lpreco
450: 			.Top       = loc_nTop
451: 			.Left      = 85
452: 			.Width     = 80
453: 			.Height    = 22
454: 			.FontName  = "Tahoma"
455: 			.FontSize  = 8
456: 			.MaxLength = 10
457: 		ENDWITH
458: 
459: 		THIS.AddObject("txt_4c_LPreco2", "TextBox")
460: 		WITH THIS.txt_4c_LPreco2
461: 			.Top      = loc_nTop
462: 			.Left     = 170
463: 			.Width    = 210
464: 			.Height   = 22
465: 			.FontName = "Tahoma"
466: 			.FontSize = 8
467: 			.ReadOnly = .T.
468: 		ENDWITH
469: 
470: 		THIS.AddObject("chk_4c_Lista", "CheckBox")
471: 		WITH THIS.chk_4c_Lista
472: 			.Top       = loc_nTop
473: 			.Left      = 390
474: 			.Width     = 130
475: 			.Height    = 22
476: 			.Caption   = "Usar Lista Pre" + CHR(231) + "o"
477: 			.FontName  = "Tahoma"
478: 			.FontSize  = 8
479: 			.BackStyle = 0
480: 			.ForeColor = RGB(255, 255, 255)
481: 			.Value     = 0
482: 		ENDWITH
483: 
484: 		THIS.AddObject("chk_4c_Precio", "CheckBox")
485: 		WITH THIS.chk_4c_Precio
486: 			.Top       = loc_nTop
487: 			.Left      = 528
488: 			.Width     = 145
489: 			.Height    = 22
490: 			.Caption   = "Usar Pre" + CHR(231) + "o Produto"
491: 			.FontName  = "Tahoma"
492: 			.FontSize  = 8
493: 			.BackStyle = 0
494: 			.ForeColor = RGB(255, 255, 255)
495: 			.Value     = 0

*-- Linhas 502 a 524:
502: 		THIS.grd_4c_Etiquetas.RecordSource     = "cursor_4c_Etiquetas"
503: 		THIS.grd_4c_Etiquetas.ColumnCount      = 7
504: 		WITH THIS.grd_4c_Etiquetas
505: 			.Top              = 172
506: 			.Left             = 12
507: 			.Width            = 818
508: 			.Height           = 200
509: 			.GridLines        = 1
510: 			.DeleteMark       = .F.
511: 			.RecordMark       = .F.
512: 			.AllowRowSizing   = .F.
513: 			.HeaderHeight     = 22
514: 			.RowHeight        = 20
515: 			.FontName         = "Tahoma"
516: 			.FontSize         = 8
517: 
518: 			WITH .Columns(1)
519: 				.Header1.Caption = "C" + CHR(243) + "digo"
520: 				.Width           = 110
521: 				.ControlSource   = "cursor_4c_Etiquetas.Cpros"
522: 				.Sparse          = .F.
523: 				.AddObject("txt_4c_GrdCpros", "TextBox")
524: 				WITH .txt_4c_GrdCpros

*-- Linhas 530 a 538:
530: 			ENDWITH
531: 
532: 			WITH .Columns(2)
533: 				.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
534: 				.Width           = 270
535: 				.ControlSource   = "cursor_4c_Etiquetas.DPros"
536: 				.Sparse          = .F.
537: 				.AddObject("txt_4c_GrdDpros", "TextBox")
538: 				WITH .txt_4c_GrdDpros

*-- Linhas 544 a 552:
544: 			ENDWITH
545: 
546: 			WITH .Columns(3)
547: 				.Header1.Caption = "Qtde"
548: 				.Width           = 65
549: 				.ControlSource   = "cursor_4c_Etiquetas.Qtds"
550: 				.Sparse          = .F.
551: 				.AddObject("txt_4c_GrdQtds", "TextBox")
552: 				WITH .txt_4c_GrdQtds

*-- Linhas 558 a 566:
558: 			ENDWITH
559: 
560: 			WITH .Columns(4)
561: 				.Header1.Caption = "Refer" + CHR(234) + "ncia Fornecedor"
562: 				.Width           = 135
563: 				.ControlSource   = "cursor_4c_Etiquetas.Reffs"
564: 				.Sparse          = .F.
565: 				.AddObject("txt_4c_GrdReffs", "TextBox")
566: 				WITH .txt_4c_GrdReffs

*-- Linhas 572 a 580:
572: 			ENDWITH
573: 
574: 			WITH .Columns(5)
575: 				.Header1.Caption = "Parcelas"
576: 				.Width           = 60
577: 				.ControlSource   = "cursor_4c_Etiquetas.Parcelas"
578: 				.Sparse          = .F.
579: 				.AddObject("txt_4c_GrdParcelas", "TextBox")
580: 				WITH .txt_4c_GrdParcelas

*-- Linhas 586 a 594:
586: 			ENDWITH
587: 
588: 			WITH .Columns(6)
589: 				.Header1.Caption = "Pre" + CHR(231) + "o"
590: 				.Width           = 70
591: 				.ControlSource   = "cursor_4c_Etiquetas.PVens"
592: 				.ReadOnly        = .T.
593: 				.Sparse          = .F.
594: 				.AddObject("txt_4c_GrdPvens", "TextBox")

*-- Linhas 602 a 610:
602: 			ENDWITH
603: 
604: 			WITH .Columns(7)
605: 				.Header1.Caption = "Pre" + CHR(231) + "o De"
606: 				.Width           = 70
607: 				.ControlSource   = "cursor_4c_Etiquetas.PrecoDe"
608: 				.ReadOnly        = .T.
609: 				.Sparse          = .F.
610: 				.AddObject("txt_4c_GrdPrecoDe", "TextBox")

*-- Linhas 632 a 641:
632: 		BINDEVENT(THIS.txt_4c_Qtds,                  "KeyPress", THIS, "TxtQtdsKeyPress")
633: 		BINDEVENT(THIS.txt_4c_Lpreco,                "KeyPress", THIS, "TxtLprecoKeyPress")
634: 		BINDEVENT(THIS.txt_4c_LPreco2,               "KeyPress", THIS, "TxtLPreco2KeyPress")
635: 		BINDEVENT(THIS.cmd_4c_BtnCarregar,           "Click",    THIS, "CmdBtnCarregarClick")
636: 		BINDEVENT(THIS.cmd_4c_BtnExcluir,            "Click",    THIS, "CmdBtnExcluirClick")
637: 		BINDEVENT(THIS.grd_4c_Etiquetas,             "KeyPress", THIS, "GrdEtiquetasKeyPress")
638: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(1), "Click",    THIS, "BtnImprimirClick")
639: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(2), "Click",    THIS, "BtnEncerrarClick")
640: 		BINDEVENT(THIS.txt_4c_Numes,                 "KeyPress", THIS, "TxtNumesKeyPress")
641: 		BINDEVENT(THIS.chk_4c_Lista,                 "Click",    THIS, "ChkListaClick")

*-- Linhas 676 a 684:
676: 				"cursor_4c_BuscaEmp")
677: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
678: 				SELECT cursor_4c_BuscaEmp
679: 				THIS.lbl_4c_DEmps.Caption = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
680: 				USE IN cursor_4c_BuscaEmp
681: 				THIS.txt_4c_Dopes.SetFocus()
682: 				RETURN
683: 			ENDIF
684: 			IF USED("cursor_4c_BuscaEmp")

*-- Linhas 697 a 705:
697: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
698: 				SELECT cursor_4c_BuscaEmp
699: 				THIS.txt_4c_Emps.Value     = ALLTRIM(cursor_4c_BuscaEmp.Emps)
700: 				THIS.lbl_4c_DEmps.Caption  = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
701: 				USE IN cursor_4c_BuscaEmp
702: 				THIS.txt_4c_Dopes.SetFocus()
703: 			ENDIF
704: 		ENDIF
705: 	ENDPROC

*-- Linhas 1454 a 1596:
1454: 	PROTECTED PROCEDURE ConfigurarPaginaDados()
1455: 
1456: 		*-- Label titulo secao (sobre o grid)
1457: 		THIS.AddObject("lbl_4c_LblTituloGrd", "Label")
1458: 		WITH THIS.lbl_4c_LblTituloGrd
1459: 			.AutoSize  = .F.
1460: 			.Caption   = " \<Etiquetas Selecionadas "
1461: 			.Top       = 375
1462: 			.Left      = 10
1463: 			.Width     = 210
1464: 			.Height    = 15
1465: 			.FontBold  = .T.
1466: 			.FontName  = "Tahoma"
1467: 			.FontSize  = 8
1468: 			.BackStyle = 0
1469: 			.ForeColor = RGB(90, 90, 90)
1470: 		ENDWITH
1471: 
1472: 		*-- Label "Tipo de Etiqueta"
1473: 		THIS.AddObject("lbl_4c_TipoEtq", "Label")
1474: 		WITH THIS.lbl_4c_TipoEtq
1475: 			.AutoSize  = .F.
1476: 			.FontBold  = .T.
1477: 			.FontName  = "Tahoma"
1478: 			.FontSize  = 8
1479: 			.BackStyle = 0
1480: 			.Caption   = " Tipo de Etiqueta "
1481: 			.Height    = 15
1482: 			.Left      = 23
1483: 			.Top       = 415
1484: 			.Width     = 110
1485: 			.ForeColor = RGB(90, 90, 90)
1486: 		ENDWITH
1487: 
1488: 		*-- OptionGroup Tipo Etiqueta (1 botao inicial: Rabicho)
1489: 		*-- PopularTiposEtiqueta() adiciona botoes dinamicamente via BO.CarregarTiposEtiqueta()
1490: 		THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
1491: 		WITH THIS.obj_4c_Opt_Tipo
1492: 			.ButtonCount   = 1
1493: 			.BackStyle     = 0
1494: 			.Value         = 1
1495: 			.Height        = 182
1496: 			.Left          = 13
1497: 			.SpecialEffect = 1
1498: 			.Top           = 431
1499: 			.Width         = 240
1500: 			.Themes        = .F.
1501: 			WITH .Buttons(1)
1502: 				.BackStyle = 0
1503: 				.Caption   = "Rabicho"
1504: 				.Height    = 16
1505: 				.Left      = 9
1506: 				.Style     = 0
1507: 				.Top       = 10
1508: 				.Width     = 197
1509: 				.ForeColor = RGB(90, 90, 90)
1510: 			ENDWITH
1511: 		ENDWITH
1512: 
1513: 		*-- Shape3 (borda visual do bloco impressora)
1514: 		THIS.AddObject("shp_4c_Shape3", "Shape")
1515: 		WITH THIS.shp_4c_Shape3
1516: 			.Top           = 431
1517: 			.Left          = 260
1518: 			.Height        = 106
1519: 			.Width         = 254
1520: 			.BackStyle     = 0
1521: 			.BorderWidth   = 1
1522: 			.SpecialEffect = 1
1523: 		ENDWITH
1524: 
1525: 		*-- Label "Impressora"
1526: 		THIS.AddObject("lbl_4c_LImpressora", "Label")
1527: 		WITH THIS.lbl_4c_LImpressora
1528: 			.AutoSize  = .F.
1529: 			.FontBold  = .T.
1530: 			.FontName  = "Tahoma"
1531: 			.FontSize  = 8
1532: 			.BackStyle = 0
1533: 			.Caption   = " Impressora "
1534: 			.Height    = 15
1535: 			.Left      = 271
1536: 			.Top       = 415
1537: 			.Width     = 80
1538: 			.ForeColor = RGB(90, 90, 90)
1539: 		ENDWITH
1540: 
1541: 		*-- Opt_Impressora (legado - Visible=.F., mantido por compatibilidade)
1542: 		THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1543: 		WITH THIS.obj_4c_Opt_Impressora
1544: 			.ButtonCount   = 1
1545: 			.BackStyle     = 0
1546: 			.Value         = 1
1547: 			.Height        = 47
1548: 			.Left          = 260
1549: 			.SpecialEffect = 1
1550: 			.Top           = 431
1551: 			.Width         = 254
1552: 			.Themes        = .F.
1553: 			.Visible       = .F.
1554: 			WITH .Buttons(1)
1555: 				.BackStyle = 0
1556: 				.Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1557: 				.Height    = 16
1558: 				.Left      = 9
1559: 				.Style     = 0
1560: 				.Top       = 52
1561: 				.Width     = 210
1562: 				.ForeColor = RGB(36, 84, 155)
1563: 			ENDWITH
1564: 		ENDWITH
1565: 
1566: 		*-- Label "Sistema" (impressora sistema)
1567: 		THIS.AddObject("lbl_4c_LSistema", "Label")
1568: 		WITH THIS.lbl_4c_LSistema
1569: 			.AutoSize  = .F.
1570: 			.FontName  = "Tahoma"
1571: 			.FontSize  = 8
1572: 			.BackStyle = 0
1573: 			.Caption   = "Sistema"
1574: 			.Height    = 15
1575: 			.Left      = 270
1576: 			.Top       = 437
1577: 			.Width     = 55
1578: 			.ForeColor = RGB(90, 90, 90)
1579: 		ENDWITH
1580: 
1581: 		*-- Label "Windows" (impressora Windows)
1582: 		THIS.AddObject("lbl_4c_LWindows", "Label")
1583: 		WITH THIS.lbl_4c_LWindows
1584: 			.AutoSize  = .F.
1585: 			.FontName  = "Tahoma"
1586: 			.FontSize  = 8
1587: 			.BackStyle = 0
1588: 			.Caption   = "Windows"
1589: 			.Height    = 15
1590: 			.Left      = 383
1591: 			.Top       = 437
1592: 			.Width     = 60
1593: 			.ForeColor = RGB(90, 90, 90)
1594: 		ENDWITH
1595: 
1596: 		*-- ComboBox lista de impressoras (Get_Printer)

*-- Linhas 1603 a 1718:
1603: 			.BoundColumn   = 1
1604: 			.BoundTo       = .F.
1605: 			.Height        = 23
1606: 			.Left          = 268
1607: 			.SpecialEffect = 1
1608: 			.Style         = 2
1609: 			.Top           = 453
1610: 			.Width         = 239
1611: 		ENDWITH
1612: 
1613: 		*-- Container ajustes impressora (Cnt_Impressora)
1614: 		THIS.AddObject("cnt_4c_Impressora", "Container")
1615: 		WITH THIS.cnt_4c_Impressora
1616: 			.Top         = 539
1617: 			.Left        = 260
1618: 			.Width       = 254
1619: 			.Height      = 80
1620: 			.BackStyle   = 0
1621: 			.BorderWidth = 0
1622: 
1623: 			*-- OptionGroup tipo impressora: 1=Allegro 2=Zebra ZPL 3=Zebra EPL
1624: 			.AddObject("obj_4c_OpcaoImp", "OptionGroup")
1625: 			WITH .obj_4c_OpcaoImp
1626: 				.ButtonCount = 3
1627: 				.Height      = 24
1628: 				.Left        = 5
1629: 				.Top         = 3
1630: 				.Width       = 241
1631: 				WITH .Buttons(1)
1632: 					.Caption   = "Allegro"
1633: 					.Left      = 2
1634: 					.Top       = 4
1635: 					.Width     = 51
1636: 					.AutoSize  = .F.
1637: 					.ForeColor = RGB(90, 90, 90)
1638: 					.BackStyle = 0
1639: 				ENDWITH
1640: 				WITH .Buttons(2)
1641: 					.Caption   = "Zebra ZPL"
1642: 					.Left      = 75
1643: 					.Top       = 4
1644: 					.Width     = 70
1645: 					.AutoSize  = .F.
1646: 					.FontName  = "Tahoma"
1647: 					.FontSize  = 8
1648: 					.ForeColor = RGB(90, 90, 90)
1649: 					.BackStyle = 0
1650: 				ENDWITH
1651: 				WITH .Buttons(3)
1652: 					.Caption   = "Zebra EPL"
1653: 					.Left      = 164
1654: 					.Top       = 4
1655: 					.Width     = 70
1656: 					.AutoSize  = .F.
1657: 					.Height    = 15
1658: 					.FontName  = "Tahoma"
1659: 					.FontSize  = 8
1660: 					.BackStyle = 0
1661: 					.ForeColor = RGB(90, 90, 90)
1662: 				ENDWITH
1663: 			ENDWITH
1664: 
1665: 			*-- Labels ajuste
1666: 			.AddObject("lbl_4c_SAjVerts", "Label")
1667: 			WITH .lbl_4c_SAjVerts
1668: 				.AutoSize  = .F.
1669: 				.Caption   = "Vertical"
1670: 				.Left      = 5
1671: 				.Top       = 32
1672: 				.Width     = 55
1673: 				.Height    = 15
1674: 				.FontName  = "Tahoma"
1675: 				.FontSize  = 8
1676: 				.BackStyle = 0
1677: 				.ForeColor = RGB(90, 90, 90)
1678: 			ENDWITH
1679: 
1680: 			.AddObject("lbl_4c_SAjHorzs", "Label")
1681: 			WITH .lbl_4c_SAjHorzs
1682: 				.AutoSize  = .F.
1683: 				.Caption   = "Horizontal"
1684: 				.Left      = 70
1685: 				.Top       = 32
1686: 				.Width     = 62
1687: 				.Height    = 15
1688: 				.FontName  = "Tahoma"
1689: 				.FontSize  = 8
1690: 				.BackStyle = 0
1691: 				.ForeColor = RGB(90, 90, 90)
1692: 			ENDWITH
1693: 
1694: 			.AddObject("lbl_4c_SAjDenss", "Label")
1695: 			WITH .lbl_4c_SAjDenss
1696: 				.AutoSize  = .F.
1697: 				.Caption   = "Densidade"
1698: 				.Left      = 140
1699: 				.Top       = 32
1700: 				.Width     = 60
1701: 				.Height    = 15
1702: 				.FontName  = "Tahoma"
1703: 				.FontSize  = 8
1704: 				.BackStyle = 0
1705: 				.ForeColor = RGB(90, 90, 90)
1706: 			ENDWITH
1707: 
1708: 			.AddObject("lbl_4c_SAjVelos", "Label")
1709: 			WITH .lbl_4c_SAjVelos
1710: 				.AutoSize  = .F.
1711: 				.Caption   = "Velocidade"
1712: 				.Left      = 205
1713: 				.Top       = 32
1714: 				.Width     = 65
1715: 				.Height    = 15
1716: 				.FontName  = "Tahoma"
1717: 				.FontSize  = 8
1718: 				.BackStyle = 0

*-- Linhas 1728 a 1737:
1728: 				.Increment        = 1
1729: 				.FontName         = "Tahoma"
1730: 				.FontSize         = 8
1731: 				.Left             = 5
1732: 				.Top              = 50
1733: 				.Width            = 57
1734: 				.Height           = 22
1735: 				.SpecialEffect    = 1
1736: 			ENDWITH
1737: 

*-- Linhas 1743 a 1752:
1743: 				.Increment        = 1
1744: 				.FontName         = "Tahoma"
1745: 				.FontSize         = 8
1746: 				.Left             = 70
1747: 				.Top              = 50
1748: 				.Width            = 57
1749: 				.Height           = 22
1750: 				.SpecialEffect    = 1
1751: 			ENDWITH
1752: 

*-- Linhas 1758 a 1767:
1758: 				.Increment        = 1
1759: 				.FontName         = "Tahoma"
1760: 				.FontSize         = 8
1761: 				.Left             = 140
1762: 				.Top              = 50
1763: 				.Width            = 57
1764: 				.Height           = 22
1765: 				.SpecialEffect    = 1
1766: 			ENDWITH
1767: 

*-- Linhas 1773 a 2085:
1773: 				.Increment        = 1
1774: 				.FontName         = "Tahoma"
1775: 				.FontSize         = 8
1776: 				.Left             = 205
1777: 				.Top              = 50
1778: 				.Width            = 45
1779: 				.Height           = 22
1780: 				.SpecialEffect    = 1
1781: 			ENDWITH
1782: 		ENDWITH
1783: 
1784: 		*-- Label "Separadora"
1785: 		THIS.AddObject("lbl_4c_LblSeparador", "Label")
1786: 		WITH THIS.lbl_4c_LblSeparador
1787: 			.AutoSize  = .F.
1788: 			.FontName  = "Tahoma"
1789: 			.FontSize  = 8
1790: 			.BackStyle = 0
1791: 			.Caption   = "Separadora :"
1792: 			.Height    = 15
1793: 			.Left      = 532
1794: 			.Top       = 417
1795: 			.Width     = 65
1796: 			.ForeColor = RGB(90, 90, 90)
1797: 		ENDWITH
1798: 
1799: 		*-- OptionGroup Separadora (opt_separador): 1=Sim 2=Nao
1800: 		THIS.AddObject("obj_4c_OptSeparador", "OptionGroup")
1801: 		WITH THIS.obj_4c_OptSeparador
1802: 			.ButtonCount   = 2
1803: 			.BackStyle     = 0
1804: 			.Value         = 1
1805: 			.Height        = 25
1806: 			.Left          = 601
1807: 			.SpecialEffect = 1
1808: 			.Top           = 412
1809: 			.Width         = 198
1810: 			.Themes        = .F.
1811: 			WITH .Buttons(1)
1812: 				.BackStyle = 0
1813: 				.Caption   = "Sim"
1814: 				.Height    = 15
1815: 				.Left      = 5
1816: 				.Top       = 5
1817: 				.Width     = 34
1818: 				.AutoSize  = .F.
1819: 				.ForeColor = RGB(90, 90, 90)
1820: 			ENDWITH
1821: 			WITH .Buttons(2)
1822: 				.FontName  = "Tahoma"
1823: 				.FontSize  = 8
1824: 				.BackStyle = 0
1825: 				.Caption   = "N" + CHR(227) + "o"
1826: 				.Height    = 15
1827: 				.Left      = 70
1828: 				.Top       = 5
1829: 				.Width     = 37
1830: 				.AutoSize  = .F.
1831: 				.ForeColor = RGB(90, 90, 90)
1832: 			ENDWITH
1833: 		ENDWITH
1834: 
1835: 		*-- Label "Preco"
1836: 		THIS.AddObject("lbl_4c_LblPreco", "Label")
1837: 		WITH THIS.lbl_4c_LblPreco
1838: 			.AutoSize  = .F.
1839: 			.FontName  = "Tahoma"
1840: 			.FontSize  = 8
1841: 			.BackStyle = 0
1842: 			.Caption   = "Pre" + CHR(231) + "o :"
1843: 			.Height    = 15
1844: 			.Left      = 561
1845: 			.Top       = 440
1846: 			.Width     = 36
1847: 			.ForeColor = RGB(90, 90, 90)
1848: 		ENDWITH
1849: 
1850: 		*-- OptionGroup Preco (opt_Preco): 1=Sim 2=Nao 3=Ideal 4=Atual 5=PrecoDe/Por 6=Parcelamento
1851: 		THIS.AddObject("obj_4c_OptPreco", "OptionGroup")
1852: 		WITH THIS.obj_4c_OptPreco
1853: 			.ButtonCount   = 6
1854: 			.BackStyle     = 0
1855: 			.Value         = 1
1856: 			.Height        = 95
1857: 			.Left          = 601
1858: 			.SpecialEffect = 1
1859: 			.Top           = 439
1860: 			.Width         = 198
1861: 			.Themes        = .F.
1862: 			WITH .Buttons(1)
1863: 				.BackStyle = 0
1864: 				.Caption   = "Sim"
1865: 				.Height    = 15
1866: 				.Left      = 8
1867: 				.Top       = 7
1868: 				.Width     = 34
1869: 				.AutoSize  = .F.
1870: 				.ForeColor = RGB(90, 90, 90)
1871: 			ENDWITH
1872: 			WITH .Buttons(2)
1873: 				.FontName  = "Tahoma"
1874: 				.FontSize  = 8
1875: 				.BackStyle = 0
1876: 				.Caption   = "N" + CHR(227) + "o"
1877: 				.Height    = 15
1878: 				.Left      = 61
1879: 				.Top       = 7
1880: 				.Width     = 37
1881: 				.AutoSize  = .F.
1882: 				.ForeColor = RGB(90, 90, 90)
1883: 			ENDWITH
1884: 			WITH .Buttons(3)
1885: 				.FontName  = "Tahoma"
1886: 				.FontSize  = 8
1887: 				.BackStyle = 0
1888: 				.Caption   = "Ideal"
1889: 				.Height    = 15
1890: 				.Left      = 8
1891: 				.Top       = 28
1892: 				.Width     = 42
1893: 				.AutoSize  = .F.
1894: 				.ForeColor = RGB(90, 90, 90)
1895: 			ENDWITH
1896: 			WITH .Buttons(4)
1897: 				.FontName  = "Tahoma"
1898: 				.FontSize  = 8
1899: 				.BackStyle = 0
1900: 				.Caption   = "Atual"
1901: 				.Height    = 15
1902: 				.Left      = 61
1903: 				.Top       = 28
1904: 				.Width     = 43
1905: 				.AutoSize  = .F.
1906: 				.ForeColor = RGB(90, 90, 90)
1907: 			ENDWITH
1908: 			WITH .Buttons(5)
1909: 				.FontName  = "Tahoma"
1910: 				.FontSize  = 8
1911: 				.BackStyle = 0
1912: 				.Caption   = "Pre" + CHR(231) + "o DE \ Por"
1913: 				.Height    = 15
1914: 				.Left      = 8
1915: 				.Top       = 51
1916: 				.Width     = 87
1917: 				.AutoSize  = .F.
1918: 				.ForeColor = RGB(90, 90, 90)
1919: 			ENDWITH
1920: 			WITH .Buttons(6)
1921: 				.FontName  = "Tahoma"
1922: 				.FontSize  = 8
1923: 				.BackStyle = 0
1924: 				.Caption   = "Parcelamento"
1925: 				.Height    = 15
1926: 				.Left      = 8
1927: 				.Top       = 73
1928: 				.Width     = 83
1929: 				.AutoSize  = .F.
1930: 				.ForeColor = RGB(90, 90, 90)
1931: 			ENDWITH
1932: 		ENDWITH
1933: 
1934: 		*-- Label "Peso"
1935: 		THIS.AddObject("lbl_4c_LblPeso", "Label")
1936: 		WITH THIS.lbl_4c_LblPeso
1937: 			.AutoSize  = .F.
1938: 			.FontName  = "Tahoma"
1939: 			.FontSize  = 8
1940: 			.BackStyle = 0
1941: 			.Caption   = "Peso :"
1942: 			.Height    = 15
1943: 			.Left      = 565
1944: 			.Top       = 540
1945: 			.Width     = 32
1946: 			.ForeColor = RGB(90, 90, 90)
1947: 		ENDWITH
1948: 
1949: 		*-- OptionGroup Peso (opt_peso): 1=Sim 2=Nao
1950: 		THIS.AddObject("obj_4c_OptPeso", "OptionGroup")
1951: 		WITH THIS.obj_4c_OptPeso
1952: 			.ButtonCount   = 2
1953: 			.BackStyle     = 0
1954: 			.Value         = 1
1955: 			.Height        = 25
1956: 			.Left          = 601
1957: 			.SpecialEffect = 1
1958: 			.Top           = 535
1959: 			.Width         = 198
1960: 			.Themes        = .F.
1961: 			WITH .Buttons(1)
1962: 				.BackStyle = 0
1963: 				.Caption   = "Sim"
1964: 				.Height    = 15
1965: 				.Left      = 5
1966: 				.Top       = 5
1967: 				.Width     = 41
1968: 				.AutoSize  = .F.
1969: 				.ForeColor = RGB(90, 90, 90)
1970: 			ENDWITH
1971: 			WITH .Buttons(2)
1972: 				.FontName  = "Tahoma"
1973: 				.FontSize  = 8
1974: 				.BackStyle = 0
1975: 				.Caption   = "N" + CHR(227) + "o"
1976: 				.Height    = 15
1977: 				.Left      = 70
1978: 				.Top       = 5
1979: 				.Width     = 41
1980: 				.AutoSize  = .F.
1981: 				.ForeColor = RGB(90, 90, 90)
1982: 			ENDWITH
1983: 		ENDWITH
1984: 
1985: 		*-- Label "Composicao"
1986: 		THIS.AddObject("lbl_4c_LblCompos", "Label")
1987: 		WITH THIS.lbl_4c_LblCompos
1988: 			.AutoSize  = .F.
1989: 			.FontName  = "Tahoma"
1990: 			.FontSize  = 8
1991: 			.BackStyle = 0
1992: 			.Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
1993: 			.Height    = 15
1994: 			.Left      = 531
1995: 			.Top       = 567
1996: 			.Width     = 70
1997: 			.ForeColor = RGB(90, 90, 90)
1998: 		ENDWITH
1999: 
2000: 		*-- OptionGroup Composicao (optCompos): 1=Sim 2=Nao
2001: 		THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
2002: 		WITH THIS.obj_4c_OptCompos
2003: 			.ButtonCount   = 2
2004: 			.BackStyle     = 0
2005: 			.Value         = 1
2006: 			.Height        = 25
2007: 			.Left          = 601
2008: 			.SpecialEffect = 1
2009: 			.Top           = 562
2010: 			.Width         = 198
2011: 			.Themes        = .F.
2012: 			WITH .Buttons(1)
2013: 				.BackStyle = 0
2014: 				.Caption   = "Sim"
2015: 				.Height    = 15
2016: 				.Left      = 5
2017: 				.Top       = 5
2018: 				.Width     = 41
2019: 				.AutoSize  = .F.
2020: 				.ForeColor = RGB(90, 90, 90)
2021: 			ENDWITH
2022: 			WITH .Buttons(2)
2023: 				.FontName  = "Tahoma"
2024: 				.FontSize  = 8
2025: 				.BackStyle = 0
2026: 				.Caption   = "N" + CHR(227) + "o"
2027: 				.Height    = 15
2028: 				.Left      = 70
2029: 				.Top       = 5
2030: 				.Width     = 41
2031: 				.AutoSize  = .F.
2032: 				.ForeColor = RGB(90, 90, 90)
2033: 			ENDWITH
2034: 		ENDWITH
2035: 
2036: 		*-- Label "Ordem"
2037: 		THIS.AddObject("lbl_4c_LblOrdem", "Label")
2038: 		WITH THIS.lbl_4c_LblOrdem
2039: 			.AutoSize  = .F.
2040: 			.FontName  = "Tahoma"
2041: 			.FontSize  = 8
2042: 			.BackStyle = 0
2043: 			.Caption   = "Ordem :"
2044: 			.Height    = 15
2045: 			.Left      = 556
2046: 			.Top       = 594
2047: 			.Width     = 41
2048: 			.ForeColor = RGB(90, 90, 90)
2049: 		ENDWITH
2050: 
2051: 		*-- OptionGroup Ordem (OptOrdem): 1=Produto 2=Nenhuma
2052: 		THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
2053: 		WITH THIS.obj_4c_OptOrdem
2054: 			.ButtonCount   = 2
2055: 			.BackStyle     = 0
2056: 			.Value         = 1
2057: 			.Height        = 25
2058: 			.Left          = 601
2059: 			.SpecialEffect = 1
2060: 			.Top           = 589
2061: 			.Width         = 198
2062: 			.Themes        = .F.
2063: 			WITH .Buttons(1)
2064: 				.BackStyle = 0
2065: 				.Caption   = "Produto"
2066: 				.Height    = 15
2067: 				.Left      = 5
2068: 				.Top       = 4
2069: 				.Width     = 56
2070: 				.AutoSize  = .F.
2071: 				.ForeColor = RGB(90, 90, 90)
2072: 			ENDWITH
2073: 			WITH .Buttons(2)
2074: 				.FontName  = "Tahoma"
2075: 				.FontSize  = 8
2076: 				.BackStyle = 0
2077: 				.Caption   = "Nenhuma"
2078: 				.Height    = 15
2079: 				.Left      = 70
2080: 				.Top       = 4
2081: 				.Width     = 63
2082: 				.AutoSize  = .F.
2083: 				.ForeColor = RGB(90, 90, 90)
2084: 			ENDWITH
2085: 		ENDWITH

*-- Linhas 2120 a 2133:
2120: 				loc_cCaption = ALLTRIM(NVL(cursor_4c_TiposEtq.cEtiquetas, "Tipo " + TRANSFORM(loc_i)))
2121: 				WITH .Buttons(loc_i)
2122: 					.BackStyle = 0
2123: 					.Caption   = loc_cCaption
2124: 					.Tag       = TRANSFORM(NVL(cursor_4c_TiposEtq.nTipos, loc_i))
2125: 					.Height    = 16
2126: 					.Left      = 9
2127: 					.Style     = 0
2128: 					.Top       = loc_nTopo
2129: 					.Width     = 197
2130: 					.ForeColor = RGB(90, 90, 90)
2131: 				ENDWITH
2132: 				loc_nTopo = loc_nTopo + 18
2133: 				SKIP IN cursor_4c_TiposEtq

*-- Linhas 2490 a 2499:
2490: 		IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5) AND VARTYPE(THIS.txt_4c_LPreco2) = "O"
2491: 			THIS.txt_4c_LPreco2.Value = ""
2492: 		ENDIF
2493: 		IF PEMSTATUS(THIS, "lbl_4c_DEmps", 5) AND VARTYPE(THIS.lbl_4c_DEmps) = "O"
2494: 			THIS.lbl_4c_DEmps.Caption = ""
2495: 		ENDIF
2496: 		IF PEMSTATUS(THIS, "chk_4c_Lista", 5) AND VARTYPE(THIS.chk_4c_Lista) = "O"
2497: 			THIS.chk_4c_Lista.Value = 0
2498: 		ENDIF
2499: 		IF PEMSTATUS(THIS, "chk_4c_Precio", 5) AND VARTYPE(THIS.chk_4c_Precio) = "O"


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SigPrEtqBO.prg - Business Object para Impressao de Etiquetas Selecionadas
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Identificacao (sem tabela primaria - form OPERACIONAL)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Filtros do cabecalho (campos de selecao do form)
    this_cEmps        = ""    && Empresa (C3)
    this_cDopes       = ""    && Operacao (C20)
    this_nNumes       = 0     && Numero da operacao (N6)
    this_cLpreco      = ""    && Lista de Precos 1 (C30)
    this_cLpreco2     = ""    && Lista de Precos 2 (C30)

    *-- Configuracoes de impressao (lidas de SigCdPam / SigCdPac)
    this_nTpEti       = 0     && Tipo de etiqueta selecionado
    this_nTpImp       = 1     && Tipo de impressora (1=Allegro, 2=ZPL, 3=EPL)
    this_nAjVerts     = 0     && Ajuste vertical
    this_nAjHorzs     = 0     && Ajuste horizontal
    this_nAjDenss     = 20    && Densidade
    this_nAjVelos     = 1     && Velocidade
    this_cNomeImp     = ""    && Nome da impressora selecionada
    this_nMaxTpEtis   = 7     && Maximo de tipos de etiqueta (de SigCdPam)
    this_nTpEtiPadrao = 1     && Tipo padrao (TpEtiPads em SigCdPam)

    *-- Opcoes de impressao selecionadas pelo usuario
    this_nImpPreco    = 1     && Opcao de preco (1=Sim, 2=Nao, 3=Ideal, 4=Atual, 5=PrecoDe/Por, 6=Parcelamento)
    this_lImpSepar    = .T.   && Imprimir separadora (opt_separador)
    this_lImpPeso     = .T.   && Imprimir peso (opt_peso)
    this_lCompo       = .T.   && Imprimir composicao (optCompos)
    this_nOrdem       = 1     && Ordenacao (1=Produto, 2=Nenhuma)

    *-- Estado interno
    this_lCarregouItens = .F. && Flag: itens foram carregados no cursor
    this_cBop           = ""  && Codigo BOP para impressao (Ndopes padded + Numes padded)

    *-- Item corrente do grid (cursor_4c_Etiquetas - campos de dbImpressao)
    this_cItemCpros      = ""    && Codigo produto (C14)
    this_cItemDpros      = ""    && Descricao produto (C40)
    this_cItemDpro2s     = ""    && Descritivo/Referencia fornecedor (C45)
    this_cItemReffs      = ""    && Referencia interna (C40)
    this_nItemQtds       = 0     && Quantidade (N10,3)
    this_nItemQtdeEtiq   = 0     && Quantidade de etiquetas (N10,3)
    this_cItemObs        = ""    && Observacao/codigo lista de precos (C10)
    this_cItemPedido     = ""    && Pedido (C30)
    this_nItemPvens      = 0     && Preco de venda (N12,2)
    this_nItemPrecoDe    = 0     && Preco DE (N12,2)
    this_nItemParcelas   = 0     && Parcelas (N2,0)
    this_cItemEmpos      = ""    && Empresa (C3)
    this_cItemEmpdopnums = ""    && Chave EmpDopNums (C29)
    this_nItemCitens     = 0     && Numero do item/citens (N10)
    this_nItemPesos      = 0     && Peso medio (N12,2)
    this_cItemCodTams    = ""    && Codigo tamanho (C4)
    this_cItemCpros2     = ""    && Produto alternativo 2 (C14)
    this_cItemCpros3     = ""    && Produto alternativo 3 (C14)
    this_cItemCpros4     = ""    && Produto alternativo 4 (C14)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo do produto atual como chave de auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cItemCpros)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Le SigCdPam e SigCdPac para configurar impressora
    * Retorna .T. se leu com sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            LOCAL loc_cSql, loc_cCpos

            loc_cCpos = "nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, TpInstalas, AjVerts, AjHorzs, TpCBars"
            loc_cSql = "SELECT " + loc_cCpos + " FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    GO TOP
                    THIS.this_nMaxTpEtis   = NVL(cursor_4c_Pam.nMaxTpEtis, 7)
                    THIS.this_nTpEtiPadrao = NVL(cursor_4c_Pam.TpEtiPads, 1)
                    THIS.this_nAjVerts     = NVL(cursor_4c_Pam.AjVerts, 0)
                    THIS.this_nAjHorzs     = NVL(cursor_4c_Pam.AjHorzs, 0)
                    THIS.this_nTpImp       = IIF(NVL(cursor_4c_Pam.ImpEtis, 0) <> 0, NVL(cursor_4c_Pam.ImpEtis, 1), 1)
                ENDIF
            ENDIF

            LOCAL loc_cSqlPac
            loc_cSqlPac = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSqlPac, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    GO TOP
                    THIS.this_nAjDenss = IIF(EMPTY(cursor_4c_Pac.AjDens), 20, NVL(cursor_4c_Pac.AjDens, 20))
                    THIS.this_nAjVelos = IIF(EMPTY(cursor_4c_Pac.AjVelos), 1, NVL(cursor_4c_Pac.AjVelos, 1))
                    THIS.this_lImpSepar = (NVL(cursor_4c_Pac.EtqSeps, 1) = 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(245) + "es")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Le SigCdTpe e retorna cursor cursor_4c_TiposEtq
    * Retorna contagem de tipos ativos ou -1 em erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarTiposEtiqueta()
        LOCAL loc_nTipos, loc_oErro
        loc_nTipos = -1

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT nTipos, cEtiquetas, cOrdems, nSituas " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE nSituas = 1 " + ;
                       "ORDER BY cOrdems, cEtiquetas"

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TiposEtq") > 0
                IF USED("cursor_4c_TiposEtq")
                    loc_nTipos = RECCOUNT("cursor_4c_TiposEtq")
                ELSE
                    loc_nTipos = 0
                ENDIF
            ELSE
                loc_nTipos = 0
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar tipos de etiqueta")
            loc_nTipos = -1
        ENDTRY

        RETURN loc_nTipos
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Le impressoras do sistema e do Windows
    * Preenche cursor_4c_Impressoras com IDupla, impres, impresS
    * Retorna contagem de impressoras ou -1 em erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarImpressoras()
        LOCAL loc_nImpressoras, loc_oErro
        loc_nImpressoras = -1

        TRY
            LOCAL loc_cSql, loc_cSqlGrupo

            *-- Impressoras do sistema autorizadas ao usuario via usuario direto
            loc_cSql = "SELECT b.Impres " + ;
                       "FROM SigSyImp a, SigCdmp b " + ;
                       "WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.CImps = b.Impres AND b.nTpImpres = 2 " + ;
                       "UNION ALL " + ;
                       "SELECT c.Impres " + ;
                       "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                       "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.Grupos = b.GrAcess " + ;
                       "AND b.CImps = c.Impres AND c.nTpImpres = 2"

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpCimp") <= 0
                *-- Fallback: todas as impressoras de etiqueta
                LOCAL loc_cSqlAll
                loc_cSqlAll = "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSqlAll, "cursor_4c_TmpCimp") < 1
                    loc_nImpressoras = 0
                    loc_lSucesso = loc_nImpressoras
                ENDIF
            ENDIF

            *-- Obtem impressoras distintas autorizadas
            IF USED("cursor_4c_TmpCimp") AND RECCOUNT("cursor_4c_TmpCimp") > 0
                SELECT DISTINCT Impres FROM cursor_4c_TmpCimp ORDER BY Impres INTO CURSOR cursor_4c_SigCdmp READWRITE
            ELSE
                LOCAL loc_cSqlAll2
                loc_cSqlAll2 = "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSqlAll2, "cursor_4c_SigCdmp") < 1
                    loc_nImpressoras = 0
                    loc_lSucesso = loc_nImpressoras
                ENDIF
            ENDIF

            IF USED("cursor_4c_TmpCimp")
                USE IN cursor_4c_TmpCimp
            ENDIF

            loc_nImpressoras = IIF(USED("cursor_4c_SigCdmp"), RECCOUNT("cursor_4c_SigCdmp"), 0)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar impressoras")
            loc_nImpressoras = -1
        ENDTRY

        RETURN loc_nImpressoras
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigo - Busca produto por CPros em SigCdPro
    * Preenche cursor_4c_Produto com dados do produto
    * Retorna .T. se encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT CPros, DPros, Dpro2s, PVens, PrecoDe, PesoMs, CUnis, Ean13, CBars " + ;
                       "FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(PADR(par_cCodigo, 14))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Produto") > 0
                IF USED("cursor_4c_Produto") AND !EOF("cursor_4c_Produto")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorDescricao - Busca produto por DPros em SigCdPro
    * Preenche cursor_4c_ProdutoBusca
    * Retorna .T. se encontrou exato, .F. se abriu picker
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorDescricao(par_cDescricao)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_ProdutoBusca")
                USE IN cursor_4c_ProdutoBusca
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT TOP 1 CPros, DPros, Dpro2s " + ;
                       "FROM SigCdPro " + ;
                       "WHERE DPros = " + EscaparSQL(par_cDescricao)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdutoBusca") > 0
                IF USED("cursor_4c_ProdutoBusca") AND !EOF("cursor_4c_ProdutoBusca")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto por descri" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorEan - Busca produto por EAN13/codigo de barras
    * Retorna CPros encontrado ou "" se nao encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorEan(par_nEan)
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT CPros FROM SigCdPro WHERE Ean13 = " + FormatarNumeroSQL(par_nEan, 0)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdEan") > 0
                IF USED("cursor_4c_ProdEan") AND !EOF("cursor_4c_ProdEan")
                    loc_cCodigo = ALLTRIM(cursor_4c_ProdEan.CPros)
                ENDIF
            ENDIF

            IF USED("cursor_4c_ProdEan")
                USE IN cursor_4c_ProdEan
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar EAN")
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigoBarras - Busca por CBars (codigo de barras numerico)
    * Retorna CPros encontrado ou "" se nao encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorCodigoBarras(par_nCBars)
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT CPros FROM SigCdPro WHERE CBars = " + FormatarNumeroSQL(INT(VAL(TRANSFORM(par_nCBars))), 0)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdCBars") > 0
                IF USED("cursor_4c_ProdCBars") AND !EOF("cursor_4c_ProdCBars")
                    loc_cCodigo = ALLTRIM(cursor_4c_ProdCBars.CPros)
                ENDIF
            ENDIF

            IF USED("cursor_4c_ProdCBars")
                USE IN cursor_4c_ProdCBars
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar por c" + CHR(243) + "digo de barras")
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarUnidadeProduto - Verifica se produto usa etiqueta individual
    * Retorna .T. se produto PODE ser impresso em etiqueta selecionada
    * Retorna .F. se deve usar reimp. individual (Etiqs='S' e EtiqDups<>1)
    *--------------------------------------------------------------------------
    FUNCTION ValidarUnidadeProduto(par_cCpros, par_cCUnis)
        LOCAL loc_lPermitido, loc_oErro
        loc_lPermitido = .T.

        TRY
            IF EMPTY(par_cCUnis)
                loc_lSucesso = .T.
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT Etiqs, EtiqDups FROM SigCdUni WHERE CUnis = " + EscaparSQL(par_cCUnis)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Unidade") > 0
                IF USED("cursor_4c_Unidade") AND !EOF("cursor_4c_Unidade")
                    SELECT cursor_4c_Unidade
                    IF ALLTRIM(cursor_4c_Unidade.Etiqs) = "S" AND NVL(cursor_4c_Unidade.EtiqDups, 0) <> 1
                        loc_lPermitido = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_Unidade")
                USE IN cursor_4c_Unidade
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar unidade do produto")
        ENDTRY

        RETURN loc_lPermitido
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarListaPrecos - Busca em SigCdLpc por codigo de lista
    * Preenche cursor_4c_ListaPrecos
    * Retorna .T. se encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarListaPrecos(par_cLista)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_ListaPrecos")
                USE IN cursor_4c_ListaPrecos
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT LPrecos FROM SigCdLpc WHERE LPrecos = " + EscaparSQL(par_cLista)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ListaPrecos") > 0
                IF USED("cursor_4c_ListaPrecos") AND !EOF("cursor_4c_ListaPrecos")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar lista de pre" + CHR(231) + "os")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensDaLista - Carrega itens de SigCdLpi para dbImpressao
    * par_cLista: codigo da lista de precos (C30)
    * Preenche cursor cursor_4c_ItensDaLista
    * Retorna contagem de itens carregados
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensDaLista(par_cLista)
        LOCAL loc_nItens, loc_oErro
        loc_nItens = 0

        TRY
            IF USED("cursor_4c_ItensDaLista")
                USE IN cursor_4c_ItensDaLista
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT LPrecos, CPros, DPros, PVens, Precode, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLista, 30))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ItensDaLista") > 0
                IF USED("cursor_4c_ItensDaLista")
                    loc_nItens = RECCOUNT("cursor_4c_ItensDaLista")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar itens da lista de pre" + CHR(231) + "os")
        ENDTRY

        RETURN loc_nItens
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarPrecoListaPorProduto - Busca preco de lista especifica para produto
    * Retorna .T. se encontrou registro valido
    *--------------------------------------------------------------------------
    FUNCTION BuscarPrecoListaPorProduto(par_cLista, par_cCpros)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_PrecoLista")
                USE IN cursor_4c_PrecoLista
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLista, 30)) + ;
                       " AND CPros = " + EscaparSQL(PADR(par_cCpros, 14))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_PrecoLista") > 0
                IF USED("cursor_4c_PrecoLista") AND !EOF("cursor_4c_PrecoLista")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar pre" + CHR(231) + "o da lista")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensDaOperacao - Carrega itens de SigMvItn por EmpDopNums
    * par_cEdn: chave concatenada Emps(3)+Dopes(20)+Numes(6)
    * Preenche cursor_4c_ItensOp
    * Retorna contagem de itens ou -1 em erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensDaOperacao(par_cEdn)
        LOCAL loc_nItens, loc_oErro
        loc_nItens = -1

        TRY
            IF USED("cursor_4c_ItensOp")
                USE IN cursor_4c_ItensOp
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT CPros, DPros, Units, Qtds, Citens " + ;
                       "FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(par_cEdn)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ItensOp") > 0
                IF USED("cursor_4c_ItensOp")
                    loc_nItens = RECCOUNT("cursor_4c_ItensOp")
                ELSE
                    loc_nItens = 0
                ENDIF
            ELSE
                loc_nItens = 0
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar itens da opera" + CHR(231) + CHR(227) + "o")
            loc_nItens = -1
        ENDTRY

        RETURN loc_nItens
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDadosProdutoParaImpressao - Le PVens, PrecoDe, PesoMs de SigCdPro
    * Retorna .T. se encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarDadosProdutoParaImpressao(par_cCpros)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_DadosProd")
                USE IN cursor_4c_DadosProd
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT PVens, PrecoDe, PesoMs " + ;
                       "FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(PADR(par_cCpros, 14))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DadosProd") > 0
                IF USED("cursor_4c_DadosProd") AND !EOF("cursor_4c_DadosProd")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar dados do produto para impress" + CHR(227) + "o")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarNumeracaoOperacao - Busca NDopes em SigCdOpe para montar lcBop
    * par_cDopes: codigo da operacao (C20)
    * Retorna NDopes ou "" se nao encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarNumeracaoOperacao(par_cDopes)
        LOCAL loc_cNDopes, loc_oErro
        loc_cNDopes = ""

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT NDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(par_cDopes)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Ope") > 0
                IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                    loc_cNDopes = ALLTRIM(NVL(cursor_4c_Ope.NDopes, ""))
                ENDIF
            ENDIF

            IF USED("cursor_4c_Ope")
                USE IN cursor_4c_Ope
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_cNDopes
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarCodigoBop - Monta codigo BOP para chamada SigOpEtq
    * par_cDopes: operacao, par_nNumes: numero
    * Seta this_cBop e retorna valor
    *--------------------------------------------------------------------------
    FUNCTION MontarCodigoBop(par_cDopes, par_nNumes)
        LOCAL loc_cBop, loc_cNDopes

        loc_cBop = ""

        IF !EMPTY(par_cDopes) AND par_nNumes > 0
            loc_cNDopes = THIS.BuscarNumeracaoOperacao(par_cDopes)
            IF !EMPTY(loc_cNDopes)
                loc_cBop = PADL(loc_cNDopes, 4, "0") + PADL(TRANSFORM(par_nNumes), 6, "0")
            ENDIF
        ENDIF

        THIS.this_cBop = loc_cBop
        RETURN loc_cBop
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharCursoresTemporarios - Fecha cursores auxiliares usados durante carga
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursoresTemporarios()
        LOCAL loc_aCursores(15), loc_i

        loc_aCursores(1)  = "cursor_4c_Pam"
        loc_aCursores(2)  = "cursor_4c_Pac"
        loc_aCursores(3)  = "cursor_4c_TiposEtq"
        loc_aCursores(4)  = "cursor_4c_SigCdmp"
        loc_aCursores(5)  = "cursor_4c_TmpCimp"
        loc_aCursores(6)  = "cursor_4c_Produto"
        loc_aCursores(7)  = "cursor_4c_ProdutoBusca"
        loc_aCursores(8)  = "cursor_4c_ProdEan"
        loc_aCursores(9)  = "cursor_4c_ProdCBars"
        loc_aCursores(10) = "cursor_4c_Unidade"
        loc_aCursores(11) = "cursor_4c_ListaPrecos"
        loc_aCursores(12) = "cursor_4c_ItensDaLista"
        loc_aCursores(13) = "cursor_4c_PrecoLista"
        loc_aCursores(14) = "cursor_4c_ItensOp"
        loc_aCursores(15) = "cursor_4c_DadosProd"

        FOR loc_i = 1 TO 15
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as 19 colunas do cursor para propriedades
    * par_cAlias: nome do cursor (normalmente "cursor_4c_Etiquetas")
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAlias)
            SELECT (par_cAlias)
            THIS.this_cItemCpros      = ALLTRIM(NVL(Cpros,      ""))
            THIS.this_cItemDpros      = ALLTRIM(NVL(DPros,      ""))
            THIS.this_cItemDpro2s     = ALLTRIM(NVL(DPro2s,     ""))
            THIS.this_cItemReffs      = ALLTRIM(NVL(Reffs,      ""))
            THIS.this_nItemQtds       = NVL(Qtds,       0)
            THIS.this_nItemQtdeEtiq   = NVL(QtdeEtiq,   0)
            THIS.this_cItemObs        = ALLTRIM(NVL(Obs,        ""))
            THIS.this_cItemPedido     = ALLTRIM(NVL(Pedido,     ""))
            THIS.this_nItemPvens      = NVL(PVens,      0)
            THIS.this_nItemPrecoDe    = NVL(PrecoDe,    0)
            THIS.this_nItemParcelas   = NVL(Parcelas,   0)
            THIS.this_cItemEmpos      = ALLTRIM(NVL(empos,      ""))
            THIS.this_cItemEmpdopnums = ALLTRIM(NVL(empdopnums, ""))
            THIS.this_nItemCitens     = NVL(citens,     0)
            THIS.this_nItemPesos      = NVL(Pesos,      0)
            THIS.this_cItemCodTams    = ALLTRIM(NVL(CodTams,    ""))
            THIS.this_cItemCpros2     = ALLTRIM(NVL(Cpros2,     ""))
            THIS.this_cItemCpros3     = ALLTRIM(NVL(Cpros3,     ""))
            THIS.this_cItemCpros4     = ALLTRIM(NVL(Cpros4,     ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida propriedades do item antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cItemCpros))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        IF THIS.this_nItemQtds <= 0
            THIS.this_cMensagemErro = "Quantidade inv" + CHR(225) + "lida. Informe valor maior que zero."
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO cursor_4c_Etiquetas com todos os campos do item
    * Equivalente ao Insert Into dbImpressao do legado
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_Etiquetas")
                THIS.this_cMensagemErro = "Cursor de etiquetas n" + CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lSucesso = .F.
            ENDIF

            INSERT INTO cursor_4c_Etiquetas ;
                (Cpros, DPros, Reffs, Qtds, QtdeEtiq, ;
                 Pedido, Obs, PVens, PrecoDe, Parcelas, ;
                 Cpros2, Cpros3, Cpros4, empos, empdopnums, ;
                 citens, Pesos, CodTams, DPro2s) ;
                VALUES ;
                (PADR(THIS.this_cItemCpros, 14), ;
                 LEFT(THIS.this_cItemDpros, 40), ;
                 LEFT(THIS.this_cItemReffs, 40), ;
                 THIS.this_nItemQtds, ;
                 THIS.this_nItemQtdeEtiq, ;
                 LEFT(THIS.this_cItemPedido, 30), ;
                 LEFT(THIS.this_cItemObs, 10), ;
                 THIS.this_nItemPvens, ;
                 THIS.this_nItemPrecoDe, ;
                 INT(THIS.this_nItemParcelas), ;
                 PADR(THIS.this_cItemCpros2, 14), ;
                 PADR(THIS.this_cItemCpros3, 14), ;
                 PADR(THIS.this_cItemCpros4, 14), ;
                 LEFT(THIS.this_cItemEmpos, 3), ;
                 LEFT(THIS.this_cItemEmpdopnums, 29), ;
                 THIS.this_nItemCitens, ;
                 THIS.this_nItemPesos, ;
                 LEFT(THIS.this_cItemCodTams, 4), ;
                 LEFT(THIS.this_cItemDpro2s, 45))

            THIS.RegistrarAuditoria("INCLUIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir etiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - REPLACE na linha corrente de cursor_4c_Etiquetas
    * Equivalente ao Replace ... In dbImpressao do legado
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_Etiquetas")
                THIS.this_cMensagemErro = "Cursor de etiquetas n" + CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Etiquetas
            REPLACE Cpros      WITH PADR(THIS.this_cItemCpros, 14), ;
                    DPros      WITH LEFT(THIS.this_cItemDpros, 40), ;
                    Reffs      WITH LEFT(THIS.this_cItemReffs, 40), ;
                    Qtds       WITH THIS.this_nItemQtds, ;
                    QtdeEtiq   WITH THIS.this_nItemQtdeEtiq, ;
                    Pedido     WITH LEFT(THIS.this_cItemPedido, 30), ;
                    Obs        WITH LEFT(THIS.this_cItemObs, 10), ;
                    PVens      WITH THIS.this_nItemPvens, ;
                    PrecoDe    WITH THIS.this_nItemPrecoDe, ;
                    Parcelas   WITH INT(THIS.this_nItemParcelas), ;
                    Cpros2     WITH PADR(THIS.this_cItemCpros2, 14), ;
                    Cpros3     WITH PADR(THIS.this_cItemCpros3, 14), ;
                    Cpros4     WITH PADR(THIS.this_cItemCpros4, 14), ;
                    empos      WITH LEFT(THIS.this_cItemEmpos, 3), ;
                    empdopnums WITH LEFT(THIS.this_cItemEmpdopnums, 29), ;
                    citens     WITH THIS.this_nItemCitens, ;
                    Pesos      WITH THIS.this_nItemPesos, ;
                    CodTams    WITH LEFT(THIS.this_cItemCodTams, 4), ;
                    DPro2s     WITH LEFT(THIS.this_cItemDpro2s, 45) ;
                    IN cursor_4c_Etiquetas

            THIS.RegistrarAuditoria("ALTERAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar etiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararImpressao - Orquestra a impressao de etiquetas
    * Chamado pelo Form apos confirmacao do usuario (Imprime.Click)
    * Reordena cursor, monta lcBop e chama SigOpEtq (funcao legado)
    * par_nImpPreco: opcao de preco (1=Sim,2=Nao,3=Ideal,4=Atual,5=PrecoDe/Por,6=Parcelamento)
    * par_lImpSepar: .T. = imprimir separadora
    * par_lImpPeso : .T. = imprimir peso
    * par_lCompo   : .T. = imprimir composicao
    * par_nTpEti   : tipo de etiqueta (INT do .Tag do botao Opt_Tipo selecionado)
    * par_nTpImp   : tipo de impressora (1=Allegro, 2=ZPL, 3=EPL)
    * par_nAjVerts : ajuste vertical
    * par_nAjHorzs : ajuste horizontal
    * par_nAjDenss : densidade
    * par_nAjVelos : velocidade
    * par_cNomeImp : nome da impressora (de crImpreV.impres)
    * par_nOrdem   : ordenacao (1=Produto, 2=Nenhuma/por insercao)
    * par_cLp1     : lista de precos 1 (get_lpreco)
    * par_cLp2     : lista de precos 2 (getLPreco2)
    * Retorna .T. se impressao concluida
    *--------------------------------------------------------------------------
    FUNCTION PrepararImpressao(par_nImpPreco, par_lImpSepar, par_lImpPeso, par_lCompo, ;
                                par_nTpEti, par_nTpImp, par_nAjVerts, par_nAjHorzs, ;
                                par_nAjDenss, par_nAjVelos, par_cNomeImp, ;
                                par_nOrdem, par_cLp1, par_cLp2)
        LOCAL loc_lSucesso, loc_oErro, loc_cBop, loc_nItens
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Etiquetas")
                THIS.this_cMensagemErro = "Sem itens para imprimir."
                loc_lSucesso = .F.
            ENDIF

            *-- Remove itens com quantidade zero ou negativa
            SELECT cursor_4c_Etiquetas
            DELETE FROM cursor_4c_Etiquetas WHERE Qtds <= 0

            *-- Conta itens validos
            SELECT cursor_4c_Etiquetas
            loc_nItens = 0
            COUNT TO loc_nItens FOR !DELETED()

            IF loc_nItens = 0
                THIS.this_cMensagemErro = "Nenhum item v" + CHR(225) + "lido para imprimir."
                loc_lSucesso = .F.
            ENDIF

            *-- Reordena cursor conforme opcao (1=por Produto, 2=por insercao)
            IF par_nOrdem = 1
                SELECT cursor_4c_Etiquetas
                SET ORDER TO Cpros
            ELSE
                SELECT cursor_4c_Etiquetas
                SET ORDER TO Registros
            ENDIF

            *-- Copia para cursor ordenado preservando a ordem escolhida
            SELECT * FROM cursor_4c_Etiquetas WHERE !DELETED() ;
                INTO CURSOR cursor_4c_EtqOrdenado READWRITE

            SET ORDER TO

            SELECT cursor_4c_Etiquetas
            ZAP

            SELECT cursor_4c_EtqOrdenado
            SCAN
                SCATTER MEMVAR MEMO
                SELECT cursor_4c_Etiquetas
                INSERT INTO cursor_4c_Etiquetas FROM MEMVAR
            ENDSCAN

            IF USED("cursor_4c_EtqOrdenado")
                USE IN cursor_4c_EtqOrdenado
            ENDIF

            *-- Monta codigo BOP se operacao e numero informados
            loc_cBop = ""
            IF !EMPTY(THIS.this_cDopes) AND THIS.this_nNumes > 0
                loc_cBop = THIS.MontarCodigoBop(THIS.this_cDopes, THIS.this_nNumes)
            ENDIF

            *-- Posiciona no cursor_4c_Etiquetas (SigOpEtq usa area de trabalho corrente)
            SELECT cursor_4c_Etiquetas
            GO TOP

            *-- Chama funcao de impressao do sistema legado (dbImpressao=cursor_4c_Etiquetas)
            =SigOpEtq(gnConnHandle, par_nImpPreco, par_lImpSepar, par_nTpEti, par_nTpImp, ;
                      par_nAjVerts, par_nAjHorzs, par_nAjDenss, .F., .F., .F., ;
                      par_cNomeImp, .F., .F., par_nAjVelos, par_lImpPeso, ;
                      loc_cBop, par_cLp1, par_cLp2, .F., .F., par_lCompo)

            THIS.RegistrarAuditoria("IMPRIMIR")

            *-- Limpa grid apos impressao bem-sucedida
            SELECT cursor_4c_Etiquetas
            ZAP
            APPEND BLANK IN cursor_4c_Etiquetas
            GO TOP IN cursor_4c_Etiquetas

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir etiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

