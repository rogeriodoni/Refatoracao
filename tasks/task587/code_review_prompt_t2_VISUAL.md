# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3516 linhas total):

*-- Linhas 119 a 128:
119: 				THIS.ConfigurarPageFrame()
120: 				THIS.ConfigurarCabecalho()
121: 
122: 				THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_cTituloForm
123: 				THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_cTituloForm
124: 
125: 				*-- Campos de filtro (area "Filtros" do legado, acima da grade) -
126: 				*-- Fase 5 trouxe a 1a metade (Fornecedor/Linha/Grande Grupo/
127: 				*-- Grupo Venda/Grupo/Markup/Subgrupo/Encargo); Fase 6 completa
128: 				*-- a 2a metade (Unidade/Moeda/Variacao/Feitio/OpcaoMoeda/

*-- Linhas 200 a 244:
200: 	PROTECTED PROCEDURE ConfigurarCabecalho()
201: 		THIS.AddObject("cnt_4c_Cabecalho", "Container")
202: 		WITH THIS.cnt_4c_Cabecalho
203: 			.Top         = 0
204: 			.Left        = 0
205: 			.Width       = THIS.Width
206: 			.Height      = 80
207: 			.BackStyle   = 1
208: 			.BackColor   = RGB(100, 100, 100)
209: 			.BorderWidth = 0
210: 			.Visible     = .T.
211: 
212: 			.AddObject("lbl_4c_Sombra", "Label")
213: 			WITH .lbl_4c_Sombra
214: 				.AutoSize  = .F.
215: 				.Top       = 18
216: 				.Left      = 10
217: 				.Width     = THIS.Width
218: 				.Height    = 40
219: 				.FontBold  = .T.
220: 				.FontName  = "Tahoma"
221: 				.FontSize  = 18
222: 				.BackStyle = 0
223: 				.ForeColor = RGB(0, 0, 0)
224: 				.Caption   = " "
225: 			ENDWITH
226: 
227: 			.AddObject("lbl_4c_Titulo", "Label")
228: 			WITH .lbl_4c_Titulo
229: 				.AutoSize  = .F.
230: 				.Top       = 17
231: 				.Left      = 10
232: 				.Width     = THIS.Width
233: 				.Height    = 46
234: 				.FontBold  = .T.
235: 				.FontName  = "Tahoma"
236: 				.FontSize  = 18
237: 				.BackStyle = 0
238: 				.ForeColor = RGB(255, 255, 255)
239: 				.Caption   = " "
240: 			ENDWITH
241: 		ENDWITH
242: 	ENDPROC
243: 
244: 	*====================================================================

*-- Linhas 258 a 273:
258: 			*--                      corrente tem foto; quem decide eh
259: 			*--                      GrdProdutosAfterRowColChange. Mostrar aqui
260: 			*--                      deixaria um retangulo vazio permanente.
261: 			*--   CMD_4C_IMPRIMIR  - Visible vem de fChecaAcesso("SigPrCcp",
262: 			*--   SHP_4C_SHAPE2      "IMPRIMIR"), igual ao legado
263: 			*--                      (Impress?o.Visible = fChecaAcesso(...) no
264: 			*--                      Init); o Shape acompanha o botao. Forcar
265: 			*--                      .T. aqui REVERTERIA o controle de acesso e
266: 			*--                      exibiria o botao para quem nao pode
267: 			*--                      imprimir - sem erro nenhum na tela.
268: 			IF INLIST(UPPER(loc_oCtrl.Name), "IMG_4C_FIGJPG", "CMD_4C_IMPRIMIR", "SHP_4C_SHAPE2")
269: 				LOOP
270: 			ENDIF
271: 
272: 			IF PEMSTATUS(loc_oCtrl, "Visible", 5)
273: 				loc_oCtrl.Visible = .T.

*-- Linhas 321 a 487:
321: 		*-- Titulo da secao "Filtros" (Label1 do legado) - Tahoma 12 Bold,
322: 		*-- ForeColor(90,90,90) EXATOS do dump (nao 36,84,155 - essa cor eh
323: 		*-- so para titulo de secao COM declaracao explicita no SCX legado)
324: 		THIS.AddObject("lbl_4c_TituloFiltros", "Label")
325: 		WITH THIS.lbl_4c_TituloFiltros
326: 			.Top       = 94
327: 			.Left      = 11
328: 			.Width     = 53
329: 			.Height    = 21
330: 			.AutoSize  = .F.
331: 			.BackStyle = 0
332: 			.FontName  = "Tahoma"
333: 			.FontSize  = 12
334: 			.FontBold  = .T.
335: 			.ForeColor = RGB(90, 90, 90)
336: 			.Caption   = "Filtros"
337: 		ENDWITH
338: 
339: 		*-- Fornecedor (getCFornecs/getDFornecs) - SigCdPro.ifors char(10).
340: 		*-- Lookup (fAcessoContas no legado) fica para fase posterior -
341: 		*-- txt_4c_DescFornecedor eh somente-leitura (When retorna .F. no
342: 		*-- legado: getDFornecs so eh preenchido pelo lookup).
343: 		THIS.AddObject("lbl_4c_Fornecedor", "Label")
344: 		WITH THIS.lbl_4c_Fornecedor
345: 			.Top       = 92
346: 			.Left      = 79
347: 			.Width     = 64
348: 			.Height    = 15
349: 			.AutoSize  = .F.
350: 			.BackStyle = 0
351: 			.FontName  = loc_cFonte
352: 			.FontSize  = 8
353: 			.ForeColor = RGB(90, 90, 90)
354: 			.Caption   = "Fornecedor :"
355: 		ENDWITH
356: 
357: 		THIS.AddObject("txt_4c_Fornecedor", "TextBox")
358: 		WITH THIS.txt_4c_Fornecedor
359: 			.Top       = 88
360: 			.Left      = 145
361: 			.Width     = 80
362: 			.Height    = 23
363: 			.FontName  = loc_cFonte
364: 			.FontSize  = 8
365: 			.Format    = "K!"
366: 			.MaxLength = 10
367: 			.Value     = ""
368: 		ENDWITH
369: 
370: 		THIS.AddObject("txt_4c_DescFornecedor", "TextBox")
371: 		WITH THIS.txt_4c_DescFornecedor
372: 			.Top       = 88
373: 			.Left      = 228
374: 			.Width     = 197
375: 			.Height    = 23
376: 			.FontName  = loc_cFonte
377: 			.FontSize  = 8
378: 			.MaxLength = 40
379: 			.ReadOnly  = .T.
380: 			.TabStop   = .F.
381: 			.Value     = ""
382: 		ENDWITH
383: 
384: 		*-- Linha (GetLini/GetLinf) - SigCdPro.linhas char(10)
385: 		THIS.AddObject("lbl_4c_Linha", "Label")
386: 		WITH THIS.lbl_4c_Linha
387: 			.Top       = 92
388: 			.Left      = 503
389: 			.Width     = 34
390: 			.Height    = 15
391: 			.AutoSize  = .F.
392: 			.BackStyle = 0
393: 			.FontName  = loc_cFonte
394: 			.FontSize  = 8
395: 			.ForeColor = RGB(90, 90, 90)
396: 			.Caption   = "Linha :"
397: 		ENDWITH
398: 
399: 		THIS.AddObject("txt_4c_LinhaI", "TextBox")
400: 		WITH THIS.txt_4c_LinhaI
401: 			.Top       = 88
402: 			.Left      = 539
403: 			.Width     = 84
404: 			.Height    = 23
405: 			.FontName  = loc_cFonte
406: 			.FontSize  = 8
407: 			.MaxLength = 10
408: 			.Value     = ""
409: 		ENDWITH
410: 
411: 		THIS.AddObject("lbl_4c_AteLinha", "Label")
412: 		WITH THIS.lbl_4c_AteLinha
413: 			.Top       = 92
414: 			.Left      = 627
415: 			.Width     = 20
416: 			.Height    = 15
417: 			.AutoSize  = .F.
418: 			.BackStyle = 0
419: 			.FontName  = loc_cFonte
420: 			.FontSize  = 8
421: 			.ForeColor = RGB(90, 90, 90)
422: 			.Caption   = "at" + CHR(233)
423: 		ENDWITH
424: 
425: 		THIS.AddObject("txt_4c_LinhaF", "TextBox")
426: 		WITH THIS.txt_4c_LinhaF
427: 			.Top       = 88
428: 			.Left      = 649
429: 			.Width     = 84
430: 			.Height    = 23
431: 			.FontName  = loc_cFonte
432: 			.FontSize  = 8
433: 			.MaxLength = 10
434: 			.Value     = ""
435: 		ENDWITH
436: 
437: 		*-- Grande Grupo (getMercI/getMercF) - SigCdPro.mercs char(3),
438: 		*-- mapeia this_cMercI/this_cMercF no BO ("Mercs" em AcrescentarFaixa)
439: 		THIS.AddObject("txt_4c_GrandeGrupoI", "TextBox")
440: 		WITH THIS.txt_4c_GrandeGrupoI
441: 			.Top       = 113
442: 			.Left      = 145
443: 			.Width     = 31
444: 			.Height    = 23
445: 			.FontName  = loc_cFonte
446: 			.FontSize  = 8
447: 			.MaxLength = 3
448: 			.Value     = ""
449: 		ENDWITH
450: 
451: 		THIS.AddObject("lbl_4c_GrandeGrupo", "Label")
452: 		WITH THIS.lbl_4c_GrandeGrupo
453: 			.Top       = 117
454: 			.Left      = 67
455: 			.Width     = 76
456: 			.Height    = 15
457: 			.AutoSize  = .F.
458: 			.BackStyle = 0
459: 			.FontName  = loc_cFonte
460: 			.FontSize  = 8
461: 			.ForeColor = RGB(90, 90, 90)
462: 			.Caption   = "Grande Grupo :"
463: 		ENDWITH
464: 
465: 		THIS.AddObject("lbl_4c_AteGrandeGrupo", "Label")
466: 		WITH THIS.lbl_4c_AteGrandeGrupo
467: 			.Top       = 117
468: 			.Left      = 179
469: 			.Width     = 20
470: 			.Height    = 15
471: 			.AutoSize  = .F.
472: 			.BackStyle = 0
473: 			.FontName  = loc_cFonte
474: 			.FontSize  = 8
475: 			.ForeColor = RGB(90, 90, 90)
476: 			.Caption   = "at" + CHR(233)
477: 		ENDWITH
478: 
479: 		THIS.AddObject("txt_4c_GrandeGrupoF", "TextBox")
480: 		WITH THIS.txt_4c_GrandeGrupoF
481: 			.Top       = 113
482: 			.Left      = 198
483: 			.Width     = 31
484: 			.Height    = 23
485: 			.FontName  = loc_cFonte
486: 			.FontSize  = 8
487: 			.MaxLength = 3

*-- Linhas 493 a 758:
493: 		*-- AcrescentarFaixa). Rotulo "Grupo Venda :" transcrito do SCX -
494: 		*-- diverge do nome interno do objeto legado (Col = SigCdCol),
495: 		*-- mas o texto exibido eh a fonte de verdade da UI (Pilar 1).
496: 		THIS.AddObject("lbl_4c_GrupoVenda", "Label")
497: 		WITH THIS.lbl_4c_GrupoVenda
498: 			.Top       = 117
499: 			.Left      = 466
500: 			.Width     = 71
501: 			.Height    = 15
502: 			.AutoSize  = .F.
503: 			.BackStyle = 0
504: 			.FontName  = loc_cFonte
505: 			.FontSize  = 8
506: 			.ForeColor = RGB(90, 90, 90)
507: 			.Caption   = "Grupo Venda :"
508: 		ENDWITH
509: 
510: 		THIS.AddObject("txt_4c_ColecaoI", "TextBox")
511: 		WITH THIS.txt_4c_ColecaoI
512: 			.Top       = 113
513: 			.Left      = 539
514: 			.Width     = 84
515: 			.Height    = 23
516: 			.FontName  = loc_cFonte
517: 			.FontSize  = 8
518: 			.MaxLength = 10
519: 			.Value     = ""
520: 		ENDWITH
521: 
522: 		THIS.AddObject("lbl_4c_AteColecao", "Label")
523: 		WITH THIS.lbl_4c_AteColecao
524: 			.Top       = 117
525: 			.Left      = 627
526: 			.Width     = 20
527: 			.Height    = 15
528: 			.AutoSize  = .F.
529: 			.BackStyle = 0
530: 			.FontName  = loc_cFonte
531: 			.FontSize  = 8
532: 			.ForeColor = RGB(90, 90, 90)
533: 			.Caption   = "at" + CHR(233)
534: 		ENDWITH
535: 
536: 		THIS.AddObject("txt_4c_ColecaoF", "TextBox")
537: 		WITH THIS.txt_4c_ColecaoF
538: 			.Top       = 113
539: 			.Left      = 649
540: 			.Width     = 84
541: 			.Height    = 23
542: 			.FontName  = loc_cFonte
543: 			.FontSize  = 8
544: 			.MaxLength = 10
545: 			.Value     = ""
546: 		ENDWITH
547: 
548: 		*-- Grupo (getCgrui/getCgruf) - SigCdPro.cgrus char(3)
549: 		THIS.AddObject("txt_4c_GrupoI", "TextBox")
550: 		WITH THIS.txt_4c_GrupoI
551: 			.Top       = 138
552: 			.Left      = 145
553: 			.Width     = 31
554: 			.Height    = 23
555: 			.FontName  = loc_cFonte
556: 			.FontSize  = 8
557: 			.MaxLength = 3
558: 			.Value     = ""
559: 		ENDWITH
560: 
561: 		THIS.AddObject("lbl_4c_Grupo", "Label")
562: 		WITH THIS.lbl_4c_Grupo
563: 			.Top       = 142
564: 			.Left      = 105
565: 			.Width     = 38
566: 			.Height    = 15
567: 			.AutoSize  = .F.
568: 			.BackStyle = 0
569: 			.FontName  = loc_cFonte
570: 			.FontSize  = 8
571: 			.ForeColor = RGB(90, 90, 90)
572: 			.Caption   = "Grupo :"
573: 		ENDWITH
574: 
575: 		THIS.AddObject("lbl_4c_AteGrupo", "Label")
576: 		WITH THIS.lbl_4c_AteGrupo
577: 			.Top       = 142
578: 			.Left      = 179
579: 			.Width     = 20
580: 			.Height    = 15
581: 			.AutoSize  = .F.
582: 			.BackStyle = 0
583: 			.FontName  = loc_cFonte
584: 			.FontSize  = 8
585: 			.ForeColor = RGB(90, 90, 90)
586: 			.Caption   = "at" + CHR(233)
587: 		ENDWITH
588: 
589: 		THIS.AddObject("txt_4c_GrupoF", "TextBox")
590: 		WITH THIS.txt_4c_GrupoF
591: 			.Top       = 138
592: 			.Left      = 198
593: 			.Width     = 31
594: 			.Height    = 23
595: 			.FontName  = loc_cFonte
596: 			.FontSize  = 8
597: 			.MaxLength = 3
598: 			.Value     = ""
599: 		ENDWITH
600: 
601: 		*-- Markup (GetMrki/GetMrkf) - SigCdPro.margems numeric(9,6),
602: 		*-- BO formata/compara com 2 casas (FormatarNumeroSQL(...,2))
603: 		THIS.AddObject("lbl_4c_Markup", "Label")
604: 		WITH THIS.lbl_4c_Markup
605: 			.Top       = 142
606: 			.Left      = 493
607: 			.Width     = 44
608: 			.Height    = 15
609: 			.AutoSize  = .F.
610: 			.BackStyle = 0
611: 			.FontName  = loc_cFonte
612: 			.FontSize  = 8
613: 			.ForeColor = RGB(90, 90, 90)
614: 			.Caption   = "Markup :"
615: 		ENDWITH
616: 
617: 		THIS.AddObject("txt_4c_MarkupI", "TextBox")
618: 		WITH THIS.txt_4c_MarkupI
619: 			.Top       = 138
620: 			.Left      = 539
621: 			.Width     = 84
622: 			.Height    = 23
623: 			.FontName  = loc_cFonte
624: 			.FontSize  = 8
625: 			.InputMask = "999.99"
626: 			.Value     = 0
627: 		ENDWITH
628: 
629: 		THIS.AddObject("lbl_4c_AteMarkup", "Label")
630: 		WITH THIS.lbl_4c_AteMarkup
631: 			.Top       = 142
632: 			.Left      = 627
633: 			.Width     = 20
634: 			.Height    = 15
635: 			.AutoSize  = .F.
636: 			.BackStyle = 0
637: 			.FontName  = loc_cFonte
638: 			.FontSize  = 8
639: 			.ForeColor = RGB(90, 90, 90)
640: 			.Caption   = "at" + CHR(233)
641: 		ENDWITH
642: 
643: 		THIS.AddObject("txt_4c_MarkupF", "TextBox")
644: 		WITH THIS.txt_4c_MarkupF
645: 			.Top       = 138
646: 			.Left      = 649
647: 			.Width     = 84
648: 			.Height    = 23
649: 			.FontName  = loc_cFonte
650: 			.FontSize  = 8
651: 			.InputMask = "999.99"
652: 			.Value     = 0
653: 		ENDWITH
654: 
655: 		*-- Subgrupo (getSgruI/getSgruF) - SigCdPro.sgrus char(6)
656: 		THIS.AddObject("txt_4c_SubGrupoI", "TextBox")
657: 		WITH THIS.txt_4c_SubGrupoI
658: 			.Top       = 163
659: 			.Left      = 145
660: 			.Width     = 52
661: 			.Height    = 23
662: 			.FontName  = loc_cFonte
663: 			.FontSize  = 8
664: 			.MaxLength = 6
665: 			.Value     = ""
666: 		ENDWITH
667: 
668: 		THIS.AddObject("lbl_4c_Subgrupo", "Label")
669: 		WITH THIS.lbl_4c_Subgrupo
670: 			.Top       = 167
671: 			.Left      = 88
672: 			.Width     = 55
673: 			.Height    = 15
674: 			.AutoSize  = .F.
675: 			.BackStyle = 0
676: 			.FontName  = loc_cFonte
677: 			.FontSize  = 8
678: 			.ForeColor = RGB(90, 90, 90)
679: 			.Caption   = "Subgrupo :"
680: 		ENDWITH
681: 
682: 		THIS.AddObject("lbl_4c_AteSubgrupo", "Label")
683: 		WITH THIS.lbl_4c_AteSubgrupo
684: 			.Top       = 167
685: 			.Left      = 201
686: 			.Width     = 20
687: 			.Height    = 15
688: 			.AutoSize  = .F.
689: 			.BackStyle = 0
690: 			.FontName  = loc_cFonte
691: 			.FontSize  = 8
692: 			.ForeColor = RGB(90, 90, 90)
693: 			.Caption   = "at" + CHR(233)
694: 		ENDWITH
695: 
696: 		THIS.AddObject("txt_4c_SubGrupoF", "TextBox")
697: 		WITH THIS.txt_4c_SubGrupoF
698: 			.Top       = 163
699: 			.Left      = 220
700: 			.Width     = 52
701: 			.Height    = 23
702: 			.FontName  = loc_cFonte
703: 			.FontSize  = 8
704: 			.MaxLength = 6
705: 			.Value     = ""
706: 		ENDWITH
707: 
708: 		*-- Encargo (Get_EncI/Get_Encf) - SigCdPro.encargos numeric(7,4),
709: 		*-- BO formata/compara com 2 casas (FormatarNumeroSQL(...,2))
710: 		THIS.AddObject("lbl_4c_Encargo", "Label")
711: 		WITH THIS.lbl_4c_Encargo
712: 			.Top       = 167
713: 			.Left      = 486
714: 			.Width     = 51
715: 			.Height    = 15
716: 			.AutoSize  = .F.
717: 			.BackStyle = 0
718: 			.FontName  = loc_cFonte
719: 			.FontSize  = 8
720: 			.ForeColor = RGB(90, 90, 90)
721: 			.Caption   = "Encargo :"
722: 		ENDWITH
723: 
724: 		THIS.AddObject("txt_4c_EncargoI", "TextBox")
725: 		WITH THIS.txt_4c_EncargoI
726: 			.Top       = 163
727: 			.Left      = 539
728: 			.Width     = 84
729: 			.Height    = 23
730: 			.FontName  = loc_cFonte
731: 			.FontSize  = 8
732: 			.InputMask = "999.99"
733: 			.Value     = 0
734: 		ENDWITH
735: 
736: 		THIS.AddObject("lbl_4c_AteEncargo", "Label")
737: 		WITH THIS.lbl_4c_AteEncargo
738: 			.Top       = 167
739: 			.Left      = 627
740: 			.Width     = 20
741: 			.Height    = 15
742: 			.AutoSize  = .F.
743: 			.BackStyle = 0
744: 			.FontName  = loc_cFonte
745: 			.FontSize  = 8
746: 			.ForeColor = RGB(90, 90, 90)
747: 			.Caption   = "at" + CHR(233)
748: 		ENDWITH
749: 
750: 		THIS.AddObject("txt_4c_EncargoF", "TextBox")
751: 		WITH THIS.txt_4c_EncargoF
752: 			.Top       = 163
753: 			.Left      = 649
754: 			.Width     = 84
755: 			.Height    = 23
756: 			.FontName  = loc_cFonte
757: 			.FontSize  = 8
758: 			.InputMask = "999.99"

*-- Linhas 775 a 1064:
775: 		*-- Unidade (getCunii/getCunif) - SigCdPro.unids char(3)
776: 		THIS.AddObject("txt_4c_UnidadeI", "TextBox")
777: 		WITH THIS.txt_4c_UnidadeI
778: 			.Top       = 189
779: 			.Left      = 145
780: 			.Width     = 31
781: 			.Height    = 23
782: 			.FontName  = loc_cFonte
783: 			.FontSize  = 8
784: 			.MaxLength = 3
785: 			.Value     = ""
786: 		ENDWITH
787: 
788: 		THIS.AddObject("lbl_4c_Unidade", "Label")
789: 		WITH THIS.lbl_4c_Unidade
790: 			.Top       = 193
791: 			.Left      = 95
792: 			.Width     = 48
793: 			.Height    = 15
794: 			.AutoSize  = .F.
795: 			.BackStyle = 0
796: 			.FontName  = loc_cFonte
797: 			.FontSize  = 8
798: 			.ForeColor = RGB(90, 90, 90)
799: 			.Caption   = "Unidade :"
800: 		ENDWITH
801: 
802: 		THIS.AddObject("lbl_4c_AteUnidade", "Label")
803: 		WITH THIS.lbl_4c_AteUnidade
804: 			.Top       = 193
805: 			.Left      = 179
806: 			.Width     = 20
807: 			.Height    = 15
808: 			.AutoSize  = .F.
809: 			.BackStyle = 0
810: 			.FontName  = loc_cFonte
811: 			.FontSize  = 8
812: 			.ForeColor = RGB(90, 90, 90)
813: 			.Caption   = "at" + CHR(233)
814: 		ENDWITH
815: 
816: 		THIS.AddObject("txt_4c_UnidadeF", "TextBox")
817: 		WITH THIS.txt_4c_UnidadeF
818: 			.Top       = 189
819: 			.Left      = 198
820: 			.Width     = 31
821: 			.Height    = 23
822: 			.FontName  = loc_cFonte
823: 			.FontSize  = 8
824: 			.MaxLength = 3
825: 			.Value     = ""
826: 		ENDWITH
827: 
828: 		*-- Variacao (%) (Get_Variacao) - faixa usada em BtnProcessarClick
829: 		*-- para excluir da grade linhas com PVarias fora da faixa
830: 		THIS.AddObject("lbl_4c_Variacao", "Label")
831: 		WITH THIS.lbl_4c_Variacao
832: 			.Top       = 193
833: 			.Left      = 456
834: 			.Width     = 81
835: 			.Height    = 15
836: 			.AutoSize  = .F.
837: 			.BackStyle = 0
838: 			.FontName  = loc_cFonte
839: 			.FontSize  = 8
840: 			.ForeColor = RGB(90, 90, 90)
841: 			.Caption   = "Varia" + CHR(231) + CHR(227) + "o ( % ) : "
842: 		ENDWITH
843: 
844: 		THIS.AddObject("txt_4c_Variacao", "TextBox")
845: 		WITH THIS.txt_4c_Variacao
846: 			.Top       = 189
847: 			.Left      = 539
848: 			.Width     = 80
849: 			.Height    = 23
850: 			.Alignment = 3
851: 			.FontName  = loc_cFonte
852: 			.FontSize  = 8
853: 			.InputMask = "999.99"
854: 			.Value     = 0
855: 		ENDWITH
856: 
857: 		*-- Codigo MKP / Feitio (Get_Feitio) - SigPrFti.cods char(2),
858: 		*-- casa cFtios OU cFtioCs em MontarWhereFiltros
859: 		THIS.AddObject("lbl_4c_Feitio", "Label")
860: 		WITH THIS.lbl_4c_Feitio
861: 			.Top       = 193
862: 			.Left      = 639
863: 			.Width     = 68
864: 			.Height    = 15
865: 			.AutoSize  = .F.
866: 			.BackStyle = 0
867: 			.FontName  = loc_cFonte
868: 			.FontSize  = 8
869: 			.ForeColor = RGB(90, 90, 90)
870: 			.Caption   = "C" + CHR(243) + "digo MKP : "
871: 		ENDWITH
872: 
873: 		THIS.AddObject("txt_4c_Feitio", "TextBox")
874: 		WITH THIS.txt_4c_Feitio
875: 			.Top       = 189
876: 			.Left      = 709
877: 			.Width     = 24
878: 			.Height    = 23
879: 			.FontName  = loc_cFonte
880: 			.FontSize  = 8
881: 			.MaxLength = 2
882: 			.Value     = ""
883: 		ENDWITH
884: 
885: 		*-- Moeda (GetMoedai/GetMoedaf) - SigCdPro.moedas/moevs char(3)
886: 		*-- (qual dos dois campos eh filtrado depende de obj_4c_OpcaoMoeda)
887: 		THIS.AddObject("txt_4c_MoedaI", "TextBox")
888: 		WITH THIS.txt_4c_MoedaI
889: 			.Top       = 213
890: 			.Left      = 145
891: 			.Width     = 31
892: 			.Height    = 23
893: 			.FontName  = loc_cFonte
894: 			.FontSize  = 8
895: 			.MaxLength = 3
896: 			.Value     = ""
897: 		ENDWITH
898: 
899: 		THIS.AddObject("lbl_4c_Moeda", "Label")
900: 		WITH THIS.lbl_4c_Moeda
901: 			.Top       = 217
902: 			.Left      = 102
903: 			.Width     = 41
904: 			.Height    = 15
905: 			.AutoSize  = .F.
906: 			.BackStyle = 0
907: 			.FontName  = loc_cFonte
908: 			.FontSize  = 8
909: 			.ForeColor = RGB(90, 90, 90)
910: 			.Caption   = "Moeda :"
911: 		ENDWITH
912: 
913: 		THIS.AddObject("lbl_4c_AteMoeda", "Label")
914: 		WITH THIS.lbl_4c_AteMoeda
915: 			.Top       = 217
916: 			.Left      = 179
917: 			.Width     = 20
918: 			.Height    = 15
919: 			.AutoSize  = .F.
920: 			.BackStyle = 0
921: 			.FontName  = loc_cFonte
922: 			.FontSize  = 8
923: 			.ForeColor = RGB(90, 90, 90)
924: 			.Caption   = "at" + CHR(233)
925: 		ENDWITH
926: 
927: 		THIS.AddObject("txt_4c_MoedaF", "TextBox")
928: 		WITH THIS.txt_4c_MoedaF
929: 			.Top       = 213
930: 			.Left      = 198
931: 			.Width     = 31
932: 			.Height    = 23
933: 			.FontName  = loc_cFonte
934: 			.FontSize  = 8
935: 			.MaxLength = 3
936: 			.Value     = ""
937: 		ENDWITH
938: 
939: 		*-- Opcao de Moeda para a faixa acima (fwoption1 no legado):
940: 		*-- Ideal (Moedas) / Venda (Moevs) - Value=1 default ("Ideal")
941: 		THIS.AddObject("obj_4c_OpcaoMoeda", "OptionGroup")
942: 		WITH THIS.obj_4c_OpcaoMoeda
943: 			.Top         = 211
944: 			.Left        = 234
945: 			.Width       = 106
946: 			.Height      = 26
947: 			.ButtonCount = 2
948: 			.Value       = 1
949: 
950: 			WITH .Buttons(1)
951: 				.Caption  = "Ideal"
952: 				.Top      = 5
953: 				.Left     = 5
954: 				.FontName = loc_cFonte
955: 				.FontSize = 8
956: 			ENDWITH
957: 			WITH .Buttons(2)
958: 				.Caption  = "Venda"
959: 				.Top      = 6
960: 				.Left     = 53
961: 				.Width    = 48
962: 				.FontName = loc_cFonte
963: 				.FontSize = 8
964: 			ENDWITH
965: 		ENDWITH
966: 
967: 		*-- Situacao (Opc_situacao) - Ativos/Inativos/Todos - Value=1 default
968: 		THIS.AddObject("lbl_4c_Situacao", "Label")
969: 		WITH THIS.lbl_4c_Situacao
970: 			.Top       = 217
971: 			.Left      = 486
972: 			.Width     = 58
973: 			.Height    = 15
974: 			.AutoSize  = .F.
975: 			.BackStyle = 0
976: 			.FontName  = loc_cFonte
977: 			.FontSize  = 8
978: 			.ForeColor = RGB(90, 90, 90)
979: 			.Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
980: 		ENDWITH
981: 
982: 		THIS.AddObject("obj_4c_Situacao", "OptionGroup")
983: 		WITH THIS.obj_4c_Situacao
984: 			.Top         = 214
985: 			.Left        = 536
986: 			.Width       = 189
987: 			.Height      = 21
988: 			.ButtonCount = 3
989: 			.Value       = 1
990: 
991: 			WITH .Buttons(1)
992: 				.Caption  = "Ativos"
993: 				.Top      = 3
994: 				.Left     = 5
995: 				.FontName = loc_cFonte
996: 				.FontSize = 8
997: 			ENDWITH
998: 			WITH .Buttons(2)
999: 				.Caption  = "Inativos"
1000: 				.Top      = 2
1001: 				.Left     = 59
1002: 				.FontName = loc_cFonte
1003: 				.FontSize = 8
1004: 			ENDWITH
1005: 			WITH .Buttons(3)
1006: 				.Caption   = "Todos"
1007: 				.Top       = 2
1008: 				.Left      = 125
1009: 				.Width     = 61
1010: 				.Height    = 17
1011: 				.FontName  = loc_cFonte
1012: 				.FontSize  = 8
1013: 				.ForeColor = RGB(90, 90, 90)
1014: 			ENDWITH
1015: 		ENDWITH
1016: 
1017: 		*-- Compra (Opc_Compra) - Comprar/Nao Comprar/Todos - Value=3
1018: 		*-- default ("Todos") - EXATO do dump legado
1019: 		THIS.AddObject("lbl_4c_Compra", "Label")
1020: 		WITH THIS.lbl_4c_Compra
1021: 			.Top       = 237
1022: 			.Left      = 490
1023: 			.Width     = 46
1024: 			.Height    = 15
1025: 			.AutoSize  = .F.
1026: 			.BackStyle = 0
1027: 			.FontName  = loc_cFonte
1028: 			.FontSize  = 8
1029: 			.ForeColor = RGB(90, 90, 90)
1030: 			.Caption   = "Compra :"
1031: 		ENDWITH
1032: 
1033: 		THIS.AddObject("obj_4c_Compra", "OptionGroup")
1034: 		WITH THIS.obj_4c_Compra
1035: 			.Top         = 234
1036: 			.Left        = 536
1037: 			.Width       = 204
1038: 			.Height      = 21
1039: 			.ButtonCount = 3
1040: 			.Value       = 3
1041: 
1042: 			WITH .Buttons(1)
1043: 				.Caption  = "Comprar"
1044: 				.Top      = 3
1045: 				.Left     = 5
1046: 				.FontName = loc_cFonte
1047: 				.FontSize = 8
1048: 			ENDWITH
1049: 			WITH .Buttons(2)
1050: 				.Caption  = "N" + CHR(227) + "o Comprar"
1051: 				.Top      = 3
1052: 				.Left     = 67
1053: 				.FontName = loc_cFonte
1054: 				.FontSize = 8
1055: 			ENDWITH
1056: 			WITH .Buttons(3)
1057: 				.Caption   = "Todos"
1058: 				.Top       = 2
1059: 				.Left      = 152
1060: 				.Width     = 61
1061: 				.Height    = 17
1062: 				.FontName  = loc_cFonte
1063: 				.FontSize  = 8
1064: 				.ForeColor = RGB(90, 90, 90)

*-- Linhas 1079 a 1359:
1079: 		*-- Linha separadora (Line1 do legado)
1080: 		THIS.AddObject("lin_4c_Separador", "Line")
1081: 		WITH THIS.lin_4c_Separador
1082: 			.Top    = 258
1083: 			.Left   = 13
1084: 			.Width  = 738
1085: 			.Height = 0
1086: 		ENDWITH
1087: 
1088: 		*-- Titulo da secao "Dados" (Label2 do legado)
1089: 		THIS.AddObject("lbl_4c_TituloDados", "Label")
1090: 		WITH THIS.lbl_4c_TituloDados
1091: 			.Top       = 270
1092: 			.Left      = 12
1093: 			.Width     = 52
1094: 			.Height    = 21
1095: 			.AutoSize  = .F.
1096: 			.BackStyle = 0
1097: 			.FontName  = "Tahoma"
1098: 			.FontSize  = 12
1099: 			.FontBold  = .T.
1100: 			.ForeColor = RGB(90, 90, 90)
1101: 			.Caption   = "Dados"
1102: 		ENDWITH
1103: 
1104: 		*-- Reajuste (Get_Reajuste) - percentual de reajuste (1 + Value/100)
1105: 		THIS.AddObject("lbl_4c_Reajuste", "Label")
1106: 		WITH THIS.lbl_4c_Reajuste
1107: 			.Top       = 304
1108: 			.Left      = 91
1109: 			.Width     = 52
1110: 			.Height    = 15
1111: 			.AutoSize  = .F.
1112: 			.BackStyle = 0
1113: 			.FontName  = loc_cFonte
1114: 			.FontSize  = 8
1115: 			.ForeColor = RGB(90, 90, 90)
1116: 			.Caption   = "Reajuste :"
1117: 		ENDWITH
1118: 
1119: 		THIS.AddObject("txt_4c_Reajuste", "TextBox")
1120: 		WITH THIS.txt_4c_Reajuste
1121: 			.Top       = 300
1122: 			.Left      = 148
1123: 			.Width     = 80
1124: 			.Height    = 23
1125: 			.Alignment = 3
1126: 			.FontName  = loc_cFonte
1127: 			.FontSize  = 8
1128: 			.InputMask = "999,999.999"
1129: 			.Value     = 0
1130: 		ENDWITH
1131: 
1132: 		*-- Novo Encargo (get_Encargo)
1133: 		THIS.AddObject("lbl_4c_NovoEncargo", "Label")
1134: 		WITH THIS.lbl_4c_NovoEncargo
1135: 			.Top       = 304
1136: 			.Left      = 245
1137: 			.Width     = 79
1138: 			.Height    = 15
1139: 			.AutoSize  = .F.
1140: 			.BackStyle = 0
1141: 			.FontName  = loc_cFonte
1142: 			.FontSize  = 8
1143: 			.ForeColor = RGB(90, 90, 90)
1144: 			.Caption   = "Novo Encargo : "
1145: 		ENDWITH
1146: 
1147: 		THIS.AddObject("txt_4c_NovoEncargo", "TextBox")
1148: 		WITH THIS.txt_4c_NovoEncargo
1149: 			.Top       = 300
1150: 			.Left      = 326
1151: 			.Width     = 80
1152: 			.Height    = 23
1153: 			.Alignment = 3
1154: 			.FontName  = loc_cFonte
1155: 			.FontSize  = 8
1156: 			.InputMask = "999,999.99"
1157: 			.Value     = 0
1158: 		ENDWITH
1159: 
1160: 		*-- Atualiza Val.Venda (Opc_pven) - Sim/Nao - Value=2 default
1161: 		*-- ("Nao") - EXATO do dump legado
1162: 		THIS.AddObject("lbl_4c_AtualizaVenda", "Label")
1163: 		WITH THIS.lbl_4c_AtualizaVenda
1164: 			.Top       = 304
1165: 			.Left      = 448
1166: 			.Width     = 98
1167: 			.Height    = 15
1168: 			.AutoSize  = .F.
1169: 			.BackStyle = 0
1170: 			.FontName  = loc_cFonte
1171: 			.FontSize  = 8
1172: 			.ForeColor = RGB(90, 90, 90)
1173: 			.Caption   = "Atualiza Val.Venda :"
1174: 		ENDWITH
1175: 
1176: 		THIS.AddObject("obj_4c_AtualizaVenda", "OptionGroup")
1177: 		WITH THIS.obj_4c_AtualizaVenda
1178: 			.Top         = 298
1179: 			.Left        = 544
1180: 			.Width       = 102
1181: 			.Height      = 27
1182: 			.ButtonCount = 2
1183: 			.Value       = 2
1184: 
1185: 			WITH .Buttons(1)
1186: 				.Caption  = "Sim"
1187: 				.Top      = 5
1188: 				.Left     = 5
1189: 				.FontName = loc_cFonte
1190: 				.FontSize = 8
1191: 			ENDWITH
1192: 			WITH .Buttons(2)
1193: 				.Caption   = "N" + CHR(227) + "o"
1194: 				.Top       = 5
1195: 				.Left      = 53
1196: 				.Width     = 44
1197: 				.Height    = 17
1198: 				.FontName  = loc_cFonte
1199: 				.FontSize  = 8
1200: 			ENDWITH
1201: 		ENDWITH
1202: 
1203: 		*-- Novo Markup (GetnMrk)
1204: 		THIS.AddObject("lbl_4c_NovoMarkup", "Label")
1205: 		WITH THIS.lbl_4c_NovoMarkup
1206: 			.Top       = 330
1207: 			.Left      = 71
1208: 			.Width     = 72
1209: 			.Height    = 15
1210: 			.AutoSize  = .F.
1211: 			.BackStyle = 0
1212: 			.FontName  = loc_cFonte
1213: 			.FontSize  = 8
1214: 			.ForeColor = RGB(90, 90, 90)
1215: 			.Caption   = "Novo Markup :"
1216: 		ENDWITH
1217: 
1218: 		THIS.AddObject("txt_4c_NovoMarkup", "TextBox")
1219: 		WITH THIS.txt_4c_NovoMarkup
1220: 			.Top       = 326
1221: 			.Left      = 148
1222: 			.Width     = 80
1223: 			.Height    = 23
1224: 			.Alignment = 3
1225: 			.FontName  = loc_cFonte
1226: 			.FontSize  = 8
1227: 			.InputMask = "999,999.99"
1228: 			.Value     = 0
1229: 		ENDWITH
1230: 
1231: 		*-- Novo MKP (getNewMkp) - codigo do feitio novo, so usado quando
1232: 		*-- Recalcula = Markup Custo(7)/Markup Venda(8) - ver
1233: 		*-- AtualizarEstadoCalculo()
1234: 		THIS.AddObject("lbl_4c_NovoMkp", "Label")
1235: 		WITH THIS.lbl_4c_NovoMkp
1236: 			.Top       = 330
1237: 			.Left      = 264
1238: 			.Width     = 60
1239: 			.Height    = 15
1240: 			.AutoSize  = .F.
1241: 			.BackStyle = 0
1242: 			.FontName  = loc_cFonte
1243: 			.FontSize  = 8
1244: 			.ForeColor = RGB(90, 90, 90)
1245: 			.Caption   = "Novo MKP : "
1246: 		ENDWITH
1247: 
1248: 		THIS.AddObject("txt_4c_NovoMkp", "TextBox")
1249: 		WITH THIS.txt_4c_NovoMkp
1250: 			.Top       = 326
1251: 			.Left      = 326
1252: 			.Width     = 24
1253: 			.Height    = 23
1254: 			.FontName  = loc_cFonte
1255: 			.FontSize  = 8
1256: 			.MaxLength = 2
1257: 			.Value     = ""
1258: 		ENDWITH
1259: 
1260: 		*-- Recalcula (Opc_Recalc) - 8 opcoes de tipo de recalculo -
1261: 		*-- Value=1 default ("Composicao")
1262: 		THIS.AddObject("lbl_4c_Recalcula", "Label")
1263: 		WITH THIS.lbl_4c_Recalcula
1264: 			.Top       = 263
1265: 			.Left      = 89
1266: 			.Width     = 58
1267: 			.Height    = 15
1268: 			.AutoSize  = .F.
1269: 			.BackStyle = 0
1270: 			.FontName  = loc_cFonte
1271: 			.FontSize  = 8
1272: 			.ForeColor = RGB(90, 90, 90)
1273: 			.Caption   = "Recalcula :"
1274: 		ENDWITH
1275: 
1276: 		THIS.AddObject("obj_4c_Recalcula", "OptionGroup")
1277: 		WITH THIS.obj_4c_Recalcula
1278: 			.Top         = 258
1279: 			.Left        = 142
1280: 			.Width       = 439
1281: 			.Height      = 41
1282: 			.ButtonCount = 8
1283: 			.Value       = 1
1284: 
1285: 			WITH .Buttons(1)
1286: 				.Caption   = "Composi" + CHR(231) + CHR(227) + "o"
1287: 				.Top       = 5
1288: 				.Left      = 5
1289: 				.FontName  = loc_cFonte
1290: 				.FontSize  = 8
1291: 				.ForeColor = RGB(90, 90, 90)
1292: 			ENDWITH
1293: 			WITH .Buttons(2)
1294: 				.Caption   = "Custo Venda"
1295: 				.Top       = 5
1296: 				.Left      = 98
1297: 				.FontName  = loc_cFonte
1298: 				.FontSize  = 8
1299: 				.ForeColor = RGB(90, 90, 90)
1300: 			ENDWITH
1301: 			WITH .Buttons(3)
1302: 				.Caption   = "Ambos"
1303: 				.Top       = 5
1304: 				.Left      = 213
1305: 				.Width     = 50
1306: 				.Height    = 15
1307: 				.FontName  = loc_cFonte
1308: 				.FontSize  = 8
1309: 				.ForeColor = RGB(90, 90, 90)
1310: 			ENDWITH
1311: 			WITH .Buttons(4)
1312: 				.Caption   = "Peso Componentes"
1313: 				.Top       = 4
1314: 				.Left      = 312
1315: 				.Width     = 110
1316: 				.Height    = 15
1317: 				.FontName  = loc_cFonte
1318: 				.FontSize  = 8
1319: 				.ForeColor = RGB(90, 90, 90)
1320: 			ENDWITH
1321: 			WITH .Buttons(5)
1322: 				.Caption   = "C" + CHR(226) + "mbio"
1323: 				.Top       = 23
1324: 				.Left      = 5
1325: 				.Width     = 53
1326: 				.Height    = 15
1327: 				.FontName  = loc_cFonte
1328: 				.FontSize  = 8
1329: 				.ForeColor = RGB(90, 90, 90)
1330: 			ENDWITH
1331: 			WITH .Buttons(6)
1332: 				.Caption   = "C" + CHR(226) + "mbio (Inteiros)"
1333: 				.Top       = 23
1334: 				.Left      = 98
1335: 				.Width     = 101
1336: 				.Height    = 15
1337: 				.FontName  = loc_cFonte
1338: 				.FontSize  = 8
1339: 				.ForeColor = RGB(90, 90, 90)
1340: 			ENDWITH
1341: 			WITH .Buttons(7)
1342: 				.Caption   = "Markup Custo"
1343: 				.Top       = 23
1344: 				.Left      = 213
1345: 				.Width     = 84
1346: 				.Height    = 15
1347: 				.FontName  = loc_cFonte
1348: 				.FontSize  = 8
1349: 				.ForeColor = RGB(90, 90, 90)
1350: 			ENDWITH
1351: 			WITH .Buttons(8)
1352: 				.Caption   = "Markup Venda"
1353: 				.Top       = 22
1354: 				.Left      = 312
1355: 				.Width     = 86
1356: 				.Height    = 15
1357: 				.FontName  = loc_cFonte
1358: 				.FontSize  = 8
1359: 				.ForeColor = RGB(90, 90, 90)

*-- Linhas 1813 a 1821:
1813: 
1814: 	*====================================================================
1815: 	* ConfigurarGridProdutos - Grade de recalculo (Grd_Produto no legado):
1816: 	* 9 colunas (Column1 = checkbox de selecao/lMarca, Column2..Column9
1817: 	* somente leitura), cria o cursor local que a alimenta e liga o
1818: 	* RecordSource - transcricao literal do "Create Cursor CrProdutos(...)"
1819: 	* + WITH ThisForm.Grd_Produto do Init legado. Dimensoes/mascaras/
1820: 	* captions EXATAS do SCX (form flat 1000x600, sem PageFrame - nao ha
1821: 	* compensacao de offset a aplicar).

*-- Linhas 1829 a 1838:
1829: 	PROTECTED PROCEDURE ConfigurarGridProdutos()
1830: 		THIS.AddObject("grd_4c_Produtos", "Grid")
1831: 		WITH THIS.grd_4c_Produtos
1832: 			.Top         = 351
1833: 			.Left        = 12
1834: 			.Width       = 935
1835: 			.Height      = 244
1836: 			.FontName    = "Tahoma"
1837: 			.FontSize    = 8
1838: 			.RowHeight   = 16

*-- Linhas 1848 a 1861:
1848: 			.Column1.Movable         = .F.
1849: 			.Column1.Resizable       = .F.
1850: 			.Column1.Sparse          = .F.
1851: 			.Column1.Header1.Caption = ""
1852: 
1853: 			*-- Coluna checkbox (Check1 no legado) - regra #18: precisa de
1854: 			*-- AddObject + CurrentControl para o controle realmente aparecer
1855: 			.Column1.AddObject("chk_4c_Marca", "CheckBox")
1856: 			.Column1.chk_4c_Marca.Caption = ""
1857: 			.Column1.chk_4c_Marca.Visible = .T.
1858: 			.Column1.CurrentControl       = "chk_4c_Marca"
1859: 			.Column1.ReadOnly             = .F.
1860: 
1861: 			.Column2.FontName          = "Tahoma"

*-- Linhas 1867 a 1925:
1867: 			.Column2.Header1.FontName  = "Tahoma"
1868: 			.Column2.Header1.FontSize  = 8
1869: 			.Column2.Header1.Alignment = 2
1870: 			.Column2.Header1.Caption   = "Produto"
1871: 			.Column2.Header1.ForeColor = RGB(36, 84, 155)
1872: 
1873: 			.Column3.FontName          = "Tahoma"
1874: 			.Column3.FontSize          = 8
1875: 			.Column3.Width             = 290
1876: 			.Column3.Movable           = .F.
1877: 			.Column3.Resizable         = .F.
1878: 			.Column3.ReadOnly          = .T.
1879: 			.Column3.Header1.FontName  = "Tahoma"
1880: 			.Column3.Header1.FontSize  = 8
1881: 			.Column3.Header1.Alignment = 2
1882: 			.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1883: 			.Column3.Header1.ForeColor = RGB(36, 84, 155)
1884: 
1885: 			.Column4.FontName          = "Tahoma"
1886: 			.Column4.FontSize          = 8
1887: 			.Column4.Width             = 80
1888: 			.Column4.Movable           = .F.
1889: 			.Column4.Resizable         = .F.
1890: 			.Column4.ReadOnly          = .T.
1891: 			.Column4.Header1.FontName  = "Tahoma"
1892: 			.Column4.Header1.FontSize  = 8
1893: 			.Column4.Header1.Alignment = 2
1894: 			.Column4.Header1.Caption   = "Venda Ant."
1895: 			.Column4.Header1.ForeColor = RGB(36, 84, 155)
1896: 			.Column4.Text1.InputMask   = "999,999,999.99"
1897: 
1898: 			.Column5.FontName          = "Tahoma"
1899: 			.Column5.FontSize          = 8
1900: 			.Column5.Width             = 80
1901: 			.Column5.Movable           = .F.
1902: 			.Column5.Resizable         = .F.
1903: 			.Column5.ReadOnly          = .T.
1904: 			.Column5.Header1.FontName  = "Tahoma"
1905: 			.Column5.Header1.FontSize  = 8
1906: 			.Column5.Header1.Alignment = 2
1907: 			.Column5.Header1.Caption   = "Venda Atual"
1908: 			.Column5.Header1.ForeColor = RGB(36, 84, 155)
1909: 			.Column5.Text1.InputMask   = "9,999,999.99"
1910: 
1911: 			.Column6.FontName          = "Tahoma"
1912: 			.Column6.FontSize          = 8
1913: 			.Column6.Width             = 80
1914: 			.Column6.Movable           = .F.
1915: 			.Column6.Resizable         = .F.
1916: 			.Column6.ReadOnly          = .T.
1917: 			.Column6.Header1.FontName  = "Tahoma"
1918: 			.Column6.Header1.FontSize  = 8
1919: 			.Column6.Header1.Alignment = 2
1920: 			.Column6.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1921: 			.Column6.Header1.ForeColor = RGB(36, 84, 155)
1922: 			.Column6.Text1.InputMask   = "999,999.99"
1923: 			.Column6.Text1.ForeColor   = RGB(0, 0, 0)
1924: 			.Column6.Text1.BackColor   = RGB(255, 255, 255)
1925: 

*-- Linhas 1932 a 1940:
1932: 			.Column7.Header1.FontName  = "Tahoma"
1933: 			.Column7.Header1.FontSize  = 8
1934: 			.Column7.Header1.Alignment = 2
1935: 			.Column7.Header1.Caption   = "Custo Ant."
1936: 			.Column7.Text1.InputMask   = "999,999,999.9999"
1937: 			.Column7.Text1.ForeColor   = RGB(0, 0, 0)
1938: 			.Column7.Text1.BackColor   = RGB(255, 255, 255)
1939: 
1940: 			.Column8.FontName          = "Tahoma"

*-- Linhas 1946 a 1954:
1946: 			.Column8.Header1.FontName  = "Tahoma"
1947: 			.Column8.Header1.FontSize  = 8
1948: 			.Column8.Header1.Alignment = 2
1949: 			.Column8.Header1.Caption   = "Custo Atual"
1950: 			.Column8.Text1.InputMask   = "999,999,999.9999"
1951: 			.Column8.Text1.ForeColor   = RGB(0, 0, 0)
1952: 			.Column8.Text1.BackColor   = RGB(255, 255, 255)
1953: 
1954: 			.Column9.FontName          = "Tahoma"

*-- Linhas 1960 a 1968:
1960: 			.Column9.Header1.FontName  = "Tahoma"
1961: 			.Column9.Header1.FontSize  = 8
1962: 			.Column9.Header1.Alignment = 2
1963: 			.Column9.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1964: 			.Column9.Text1.InputMask   = "999,999.99"
1965: 			.Column9.Text1.ForeColor   = RGB(0, 0, 0)
1966: 			.Column9.Text1.BackColor   = RGB(255, 255, 255)
1967: 		ENDWITH
1968: 

*-- Linhas 2004 a 2033:
2004: 		*-- reconfigurar SEMPRE depois de vincular (CLAUDE.md Problema 48)
2005: 		THIS.grd_4c_Produtos.Column1.Width           = 17
2006: 		THIS.grd_4c_Produtos.Column2.Width           = 108
2007: 		THIS.grd_4c_Produtos.Column2.Header1.Caption = "Produto"
2008: 		THIS.grd_4c_Produtos.Column3.Width           = 290
2009: 		THIS.grd_4c_Produtos.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2010: 		THIS.grd_4c_Produtos.Column4.Width           = 80
2011: 		THIS.grd_4c_Produtos.Column4.Header1.Caption = "Venda Ant."
2012: 		THIS.grd_4c_Produtos.Column5.Width           = 80
2013: 		THIS.grd_4c_Produtos.Column5.Header1.Caption = "Venda Atual"
2014: 		THIS.grd_4c_Produtos.Column6.Width           = 80
2015: 		THIS.grd_4c_Produtos.Column6.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o (%)"
2016: 		THIS.grd_4c_Produtos.Column7.Width           = 80
2017: 		THIS.grd_4c_Produtos.Column7.Header1.Caption = "Custo Ant."
2018: 		THIS.grd_4c_Produtos.Column8.Width           = 80
2019: 		THIS.grd_4c_Produtos.Column8.Header1.Caption = "Custo Atual"
2020: 		THIS.grd_4c_Produtos.Column9.Width           = 80
2021: 		THIS.grd_4c_Produtos.Column9.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o (%)"
2022: 
2023: 		*-- RecordSource tambem pode derrubar CurrentControl/Sparse da coluna checkbox
2024: 		THIS.grd_4c_Produtos.Column1.CurrentControl = "chk_4c_Marca"
2025: 		THIS.grd_4c_Produtos.Column1.Sparse         = .F.
2026: 		THIS.grd_4c_Produtos.Column1.ReadOnly       = .F.
2027: 
2028: 		*-- CheckBox de coluna de Grid nao alterna pelo binding nativo: os 4
2029: 		*-- eventos tem de ser ligados (KeyPress alterna; Click/MouseDown/
2030: 		*-- MouseUp suprimem o toggle padrao para nao alternar duas vezes)
2031: 		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
2032: 		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "MouseUp", THIS, "ChkMarcaMouseUp")
2033: 		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "MouseDown", THIS, "ChkMarcaMouseDown")

*-- Linhas 2049 a 2058:
2049: 	PROTECTED PROCEDURE ConfigurarFotoProduto()
2050: 		THIS.AddObject("img_4c_FigJpg", "Image")
2051: 		WITH THIS.img_4c_FigJpg
2052: 			.Top     = 128
2053: 			.Left    = 764
2054: 			.Width   = 223
2055: 			.Height  = 190
2056: 			.Stretch = 1
2057: 			.Picture = ""
2058: 			.Visible = .F.

*-- Linhas 2230 a 2239:
2230: 	ENDPROC
2231: 
2232: 	*====================================================================
2233: 	* Toggle do CheckBox da coluna 1 da grade (Column1.Check1 do legado).
2234: 	* CheckBox em coluna de Grid NAO alterna pelo binding nativo: o valor
2235: 	* tem de ser trocado por codigo, e os tres eventos de mouse precisam
2236: 	* suprimir o comportamento padrao (NODEFAULT) para nao alternar duas
2237: 	* vezes. Os quatro handlers sao PUBLIC (alvo de BINDEVENT).
2238: 	*
2239: 	* O gate vem do "When" legado (Return(!Empty(CrProdutos.CPros))): a

*-- Linhas 2278 a 2318:
2278: 		*-- CommandGroup Sair do legado -> Processar / Atualizar / Encerrar
2279: 		THIS.AddObject("cmg_4c_Acoes", "CommandGroup")
2280: 		WITH THIS.cmg_4c_Acoes
2281: 			.Top         = -2
2282: 			.Left        = 770
2283: 			.Width       = 235
2284: 			.Height      = 85
2285: 			.BackStyle   = 0
2286: 			.BorderStyle = 0
2287: 			.ButtonCount = 3
2288: 			.Themes      = .F.
2289: 			.Value       = 1
2290: 
2291: 			WITH .Buttons(1)
2292: 				.Top        = 5
2293: 				.Left       = 5
2294: 				.Width      = 75
2295: 				.Height     = 75
2296: 				.Caption    = "Processar"
2297: 				.Picture    = loc_cIcones + "geral_processar_60.jpg"
2298: 				.FontName   = "Comic Sans MS"
2299: 				.FontBold   = .T.
2300: 				.FontItalic = .T.
2301: 				.FontSize   = 8
2302: 				.ForeColor  = RGB(90, 90, 90)
2303: 				.BackColor  = RGB(255, 255, 255)
2304: 				.Themes     = .F.
2305: 				.WordWrap   = .T.
2306: 			ENDWITH
2307: 
2308: 			WITH .Buttons(2)
2309: 				.Top        = 5
2310: 				.Left       = 80
2311: 				.Width      = 75
2312: 				.Height     = 75
2313: 				.Caption    = "Atualizar"
2314: 				.Picture    = loc_cIcones + "cadastro_salvar_60.jpg"
2315: 				.FontName   = "Comic Sans MS"
2316: 				.FontBold   = .T.
2317: 				.FontItalic = .T.
2318: 				.FontSize   = 8

*-- Linhas 2324 a 2337:
2324: 			ENDWITH
2325: 
2326: 			WITH .Buttons(3)
2327: 				.Top        = 5
2328: 				.Left       = 155
2329: 				.Width      = 75
2330: 				.Height     = 75
2331: 				.Cancel     = .T.
2332: 				.Caption    = "Encerrar"
2333: 				.Picture    = loc_cIcones + "cadastro_sair_60.jpg"
2334: 				.FontName   = "Comic Sans MS"
2335: 				.FontBold   = .T.
2336: 				.FontItalic = .T.
2337: 				.FontSize   = 8

*-- Linhas 2348 a 2375:
2348: 		*-- Decorativo (Shape2 do legado) - acompanha a visibilidade do Imprimir
2349: 		THIS.AddObject("shp_4c_Shape2", "Shape")
2350: 		WITH THIS.shp_4c_Shape2
2351: 			.Top         = 6
2352: 			.Left        = 650
2353: 			.Width       = 10
2354: 			.Height      = 6
2355: 			.BackStyle   = 0
2356: 			.BorderStyle = 0
2357: 			.BorderColor = RGB(136, 189, 188)
2358: 		ENDWITH
2359: 
2360: 		*-- Imprimir (Impress?o no legado) - abre o relatorio ja migrado
2361: 		*-- (FormSIGPRCCR), equivalente a "Do Form SigPrCcr". Comeca
2362: 		*-- desabilitado ate o 1o Processar bem sucedido (Init legado:
2363: 		*-- Impress?o.Enabled = .f.)
2364: 		THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
2365: 		WITH THIS.cmd_4c_Imprimir
2366: 			.Top             = 3
2367: 			.Left            = 700
2368: 			.Width           = 75
2369: 			.Height          = 75
2370: 			.Caption         = "Imprimir"
2371: 			.Picture         = loc_cIcones + "geral_impressora_normal_60.jpg"
2372: 			.DisabledPicture = loc_cIcones + "geral_impressora_normal_60.jpg"
2373: 			.Themes          = .T.
2374: 			.FontName        = "Comic Sans MS"
2375: 			.FontBold        = .T.

*-- Linhas 2385 a 2425:
2385: 			.Enabled         = .F.
2386: 			.Visible         = fChecaAcesso("SigPrCcp", "IMPRIMIR")
2387: 		ENDWITH
2388: 		BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "BtnImprimirClick")
2389: 		THIS.shp_4c_Shape2.Visible = THIS.cmd_4c_Imprimir.Visible
2390: 
2391: 		*-- Selecionar/Desmarcar Tudo (cmdSelemp/CmdApgEmp no legado)
2392: 		THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
2393: 		WITH THIS.cmd_4c_SelTudo
2394: 			.Top             = 433
2395: 			.Left            = 955
2396: 			.Width           = 33
2397: 			.Height          = 33
2398: 			.Caption         = ""
2399: 			.Picture         = loc_cIcones + "geral_adicao_26.jpg"
2400: 			.DisabledPicture = loc_cIcones + "geral_adicao_26.jpg"
2401: 			.Themes          = .T.
2402: 			.ToolTipText     = "Selecionar Tudo"
2403: 			.TabStop         = .F.
2404: 		ENDWITH
2405: 		BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
2406: 
2407: 		THIS.AddObject("cmd_4c_Apaga", "CommandButton")
2408: 		WITH THIS.cmd_4c_Apaga
2409: 			.Top             = 473
2410: 			.Left            = 955
2411: 			.Width           = 33
2412: 			.Height          = 33
2413: 			.Caption         = ""
2414: 			.Picture         = loc_cIcones + "cadastro_excluir_26.jpg"
2415: 			.DisabledPicture = loc_cIcones + "cadastro_excluir_26.jpg"
2416: 			.Themes          = .T.
2417: 			.ToolTipText     = "Desmarcar Tudo"
2418: 			.TabStop         = .F.
2419: 		ENDWITH
2420: 		BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
2421: 	ENDPROC
2422: 
2423: 	*====================================================================
2424: 	* FormParaBO - Hook canonico de FormBase: copia o Value de TODOS os
2425: 	* campos/grupos da tela (area "Filtros" + area "Dados") para as

*-- Linhas 2518 a 2538:
2518: 			THIS.txt_4c_MoedaI.Value         = ALLTRIM(.this_cMoedaI)
2519: 			THIS.txt_4c_MoedaF.Value         = ALLTRIM(.this_cMoedaF)
2520: 
2521: 			THIS.txt_4c_MarkupI.Value        = .this_nMarkupI
2522: 			THIS.txt_4c_MarkupF.Value        = .this_nMarkupF
2523: 			THIS.txt_4c_EncargoI.Value       = .this_nEncargoI
2524: 			THIS.txt_4c_EncargoF.Value       = .this_nEncargoF
2525: 			THIS.txt_4c_Variacao.Value       = .this_nVariacao
2526: 
2527: 			THIS.txt_4c_Feitio.Value         = ALLTRIM(.this_cFeitio)
2528: 			THIS.txt_4c_NovoMkp.Value        = ALLTRIM(.this_cNovoFeitio)
2529: 
2530: 			*-- Dados
2531: 			THIS.txt_4c_Reajuste.Value       = .this_nReajuste
2532: 			THIS.txt_4c_NovoMarkup.Value     = .this_nNovoMarkup
2533: 			THIS.txt_4c_NovoEncargo.Value    = .this_nNovoEncargo
2534: 		ENDWITH
2535: 
2536: 		*-- OptionGroups FORA do WITH, com o caminho escrito por inteiro: um
2537: 		*-- WITH aberto sequestra a resolucao de todo nome que comeca por ponto,
2538: 		*-- e chamada de metodo do form com argumentos ".this_n*" dentro dele eh

*-- Linhas 2567 a 2575:
2567: 	*
2568: 	* ZAP, nunca USE IN + CREATE CURSOR: recriar o cursor derrubaria
2569: 	* RecordSource/ControlSource do Grid (e com eles Column.Width,
2570: 	* Header1.Caption, Sparse e CurrentControl do CheckBox).
2571: 	*
2572: 	* PROTECTED porque o hook homonimo de FormBase eh PROTECTED e subclasse
2573: 	* NAO pode alargar o escopo herdado.
2574: 	*====================================================================
2575: 	PROTECTED PROCEDURE LimparCampos()

*-- Linhas 2668 a 2680:
2668: 		*-- por Enabled: sao botoes SO de icone (Caption = "") e, com
2669: 		*-- Enabled = .F., o VFP9 nao desenha o icone - o botao viraria um
2670: 		*-- retangulo vazio na tela em vez de um botao apagado.
2671: 		IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
2672: 			THIS.cmd_4c_SelTudo.Visible = loc_lLiga
2673: 		ENDIF
2674: 		IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
2675: 			THIS.cmd_4c_Apaga.Visible = loc_lLiga
2676: 		ENDIF
2677: 
2678: 		IF loc_lLiga
2679: 			*-- getDFornecs tem "Return .F." no When do legado: a descricao do
2680: 			*-- fornecedor eh preenchida pelo lookup e nunca recebe foco.

*-- Linhas 2724 a 2734:
2724: 			THIS.cmg_4c_Acoes.Buttons(2).Refresh()
2725: 		ENDIF
2726: 
2727: 		IF PEMSTATUS(THIS, "cmd_4c_Imprimir", 5)
2728: 			THIS.cmd_4c_Imprimir.Enabled = loc_lProcessado
2729: 			THIS.cmd_4c_Imprimir.Refresh()
2730: 		ENDIF
2731: 	ENDPROC
2732: 
2733: 	*====================================================================
2734: 	* CarregarLista - Consulta os produtos que atendem aos filtros


### BO (C:\4c\projeto\app\classes\sigprccpBO.prg):
*====================================================================
* sigprccpBO.prg
*
* Business Object para sigprccp (Recalculo de Precos)
* Tabela principal atualizada pelo processamento: SigCdPro (cpros)
* Tabela de presets de filtro (somente LEITURA, nunca gravada por
* este form): SigCdCcp (cIdChaves)
*
* Form legado: SIGPRCCP - "Recalculo de Precos"
* Forma OPERACIONAL: recalcula Custo/Venda de produtos filtrados,
* grava o resultado em SigCdPro e registra o historico do calculo.
*====================================================================

DEFINE CLASS sigprccpBO AS BusinessBase

	*-- Modo de execucao (Automatico = .T. quando chamado via ProcessarAutomatico,
	*-- percorrendo os presets de SigCdCcp; .F. quando disparado manualmente)
	this_lAutomatico = .F.

	*-- Filtros - Fornecedor
	this_cFornecs = ""
	this_cDFornecs = ""

	*-- Filtros - Faixas de classificacao do produto (SigCdCcp.merci/mercf etc)
	this_cMercI = ""
	this_cMercF = ""
	this_cGrupoI = ""
	this_cGrupoF = ""
	this_cSubGrupoI = ""
	this_cSubGrupoF = ""
	this_cUnidadeI = ""
	this_cUnidadeF = ""
	this_cLinhaI = ""
	this_cLinhaF = ""
	this_cColecaoI = ""
	this_cColecaoF = ""
	this_cMoedaI = ""
	this_cMoedaF = ""

	*-- Filtros - Faixas numericas (Markup/Encargo/Variacao)
	this_nMarkupI = 0
	this_nMarkupF = 0
	this_nEncargoI = 0
	this_nEncargoF = 0
	this_nVariacao = 0

	*-- Filtros - Feitio (SigPrFti) usado como referencia de calculo
	this_cFeitio = ""

	*-- Opcoes de processamento (OptionGroups do form - valores 1-based).
	*-- this_nAtualizaVenda=2 ("Nao") e this_nOpcaoCompra=3 ("Todos") sao
	*-- os defaults EXATOS do SCX legado (Opc_pven.Value=2/Opc_Compra.Value=3)
	this_nOpcaoMoeda = 1
	this_nSituacao = 1
	this_nTipoRecalculo = 1
	this_nAtualizaVenda = 2
	this_nOpcaoCompra = 3

	*-- Dados de recalculo
	this_nReajuste = 0
	this_nNovoEncargo = 0
	this_nNovoMarkup = 0
	this_cNovoFeitio = ""

	*-- Produto corrente (linha da grade marcada para gravacao do preco
	*-- recalculado) - mapeia SigCdPro.cpros, o registro efetivamente
	*-- atualizado por Inserir/Atualizar/ObterChavePrimaria/CarregarDoCursor
	this_cCpros = ""                && cpros char(14) - PK
	this_cDescricaoProduto = ""     && dpros char(65) - somente referencia
	this_nCustoAtual = 0            && custofs numeric(11,3)
	this_nVendaAtual = 0            && pvens numeric(11,5)
	this_nVendaIdeal = 0            && pvideals numeric(11,5)
	this_nFatorCusto = 0            && fcustos numeric(11,5)
	this_nFatorVenda = 0            && fvendas numeric(7,3)
	this_cMoedaCusto = ""           && moecs char(3)
	this_cMoedaVenda = ""           && moevs char(3)

	*-- Flag "Confirma a Impressao das Etiquetas?" do metodo "atualizar"
	*-- legado (m.ImpEtiqs = llImpEtiq gravado junto com o preco novo).
	*-- NUMERICO 0/1 porque impetiqs eh bit e o CheckBox/confirmacao do
	*-- form trabalha com 0/1 (nunca .T./.F.)
	this_nImpEtiqs = 0              && impetiqs bit

	*-- Subgrupo recalculado por faixa de preco (SigCdPsg.nfaixafins),
	*-- aplicado somente quando SigCdPaC.nchksubgrs = 1 - transcricao do
	*-- bloco "If crSigCdPac.nChkSubGrs = 1 ... Replace sGrus With
	*-- csSigCdPsg.Codigos" do metodo "atualizar" legado.
	*-- this_lAtualizarSubGrupo controla se Atualizar() inclui sgrus no
	*-- UPDATE: o legado so troca o subgrupo quando acha a faixa.
	this_cSubGrupo = ""             && sgrus char(6)
	this_lAtualizarSubGrupo = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		*-- Tabela efetivamente atualizada pelo processamento (SigCdPro),
		*-- pois SigCdCcp (presets de filtro) e somente LEITURA neste form.
		THIS.this_cTabela = "SigCdPro"
		THIS.this_cCampoChave = "cpros"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave do produto sendo gravado
	* (usada por RegistrarAuditoria em Atualizar)
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCpros)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega os dados do produto (linha da grade de
	* recalculo) para as propriedades this_c*/this_n* correspondentes.
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				*-- TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR default do
				*-- tipo da coluna, NUNCA um codigo de tipo ("C"/"N") - com a coluna
				*-- NULL, "C" gravaria a string literal "C" na property e "N" poria
				*-- uma STRING numa property this_n*, estourando FormatarNumeroSQL.
				THIS.this_cCpros            = TratarNulo(cpros,    "")
				THIS.this_cDescricaoProduto = TratarNulo(dpros,    "")
				THIS.this_nCustoAtual       = TratarNulo(custofs,  0)
				THIS.this_nVendaAtual       = TratarNulo(pvens,    0)
				THIS.this_nVendaIdeal       = TratarNulo(pvideals, 0)
				THIS.this_nFatorCusto       = TratarNulo(fcustos,  0)
				THIS.this_nFatorVenda       = TratarNulo(fvendas,  0)
				THIS.this_cMoedaCusto       = TratarNulo(moecs,    "")
				THIS.this_cMoedaVenda       = TratarNulo(moevs,    "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar produto do cursor:" + CHR(13) + ;
				loException.Message, "sigprccpBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Grava o preco/custo recalculado de volta em SigCdPro
	* Equivalente a PROCEDURE atualizar do legado: Scatter/Gather do
	* registro com DataAlts/UsuaAlts atualizados e commit do preco novo.
	*
	* Inserir()/ExecutarExclusao() NAO sao sobrescritos neste BO: o
	* recalculo so ATUALIZA produtos ja cadastrados em SigCdPro - nunca
	* cria nem apaga produto - entao o comportamento herdado de
	* BusinessBase (recusar a operacao) ja eh o correto para os dois.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_cSubGru, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- sgrus so entra no UPDATE quando a faixa de SigCdPsg foi
			*-- localizada (legado: "If ! Eof() / Replace sGrus With
			*-- csSigCdPsg.Codigos") - fora disso o subgrupo nao se mexe.
			loc_cSubGru = ""
			IF THIS.this_lAtualizarSubGrupo AND !EMPTY(ALLTRIM(THIS.this_cSubGrupo))
				loc_cSubGru = "sgrus = " + ;
					EscaparSQL(LEFT(ALLTRIM(THIS.this_cSubGrupo), 6)) + ","
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdPro
				SET custofs  = <<FormatarNumeroSQL(THIS.this_nCustoAtual, 3)>>,
					pvens    = <<FormatarNumeroSQL(THIS.this_nVendaAtual, 5)>>,
					pvideals = <<FormatarNumeroSQL(THIS.this_nVendaIdeal, 5)>>,
					fcustos  = <<FormatarNumeroSQL(THIS.this_nFatorCusto, 5)>>,
					fvendas  = <<FormatarNumeroSQL(THIS.this_nFatorVenda, 3)>>,
					moecs    = <<EscaparSQL(THIS.this_cMoedaCusto)>>,
					moevs    = <<EscaparSQL(THIS.this_cMoedaVenda)>>,
					impetiqs = <<FormatarNumeroSQL(IIF(THIS.this_nImpEtiqs = 1, 1, 0), 0)>>,
					<<loc_cSubGru>>
					dtalts   = GETDATE(),
					usuaalts = <<EscaparSQL(LEFT(gc_4c_UsuarioLogado, 20))>>
				WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar pre" + CHR(231) + "o do produto:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprccpBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AcrescentarFaixa - Helper de MontarWhereFiltros: acrescenta a faixa
	* (BETWEEN/>=/<=) de UM campo a clausula WHERE em construcao. Espelha
	* o corpo do "For lnConta = 1 To 7" do metodo "processar" legado
	* (SIGPRCCP): so entra em ">= "/"<= "/"Between" quando pelo menos um
	* dos limites foi informado, e "And" so precede quando ja existe algo
	* acumulado em par_cWhereAtual.
	*====================================================================
	PROTECTED FUNCTION AcrescentarFaixa(par_cWhereAtual, par_cCampo, par_cInicio, par_cFim)
		LOCAL loc_cWhere, loc_cIni, loc_cFim
		loc_cWhere = par_cWhereAtual
		loc_cIni   = ALLTRIM(TratarNulo(par_cInicio, ""))
		loc_cFim   = ALLTRIM(TratarNulo(par_cFim, ""))

		IF !EMPTY(loc_cIni) OR !EMPTY(loc_cFim)
			IF !EMPTY(loc_cWhere)
				loc_cWhere = loc_cWhere + " And "
			ENDIF

			IF EMPTY(loc_cIni)
				loc_cWhere = loc_cWhere + par_cCampo + " <= " + EscaparSQL(loc_cFim)
			ELSE
				IF EMPTY(loc_cFim)
					loc_cWhere = loc_cWhere + par_cCampo + " >= " + EscaparSQL(loc_cIni)
				ELSE
					loc_cWhere = loc_cWhere + par_cCampo + " Between " + ;
						EscaparSQL(loc_cIni) + " And " + EscaparSQL(loc_cFim)
				ENDIF
			ENDIF
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* MontarWhereFiltros - Constroi a clausula WHERE dos filtros de faixa
	* (Grande Grupo/Grupo/Subgrupo/Unidade/Linha/Colecao/Moeda), Situacao,
	* Fornecedor, Opcao de Compra, Markup, Encargo e Feitio - transcricao
	* literal do bloco de montagem de lcWhere do metodo "processar" legado
	* (laCampo/laVarias percorrendo os 7 pares de faixa, seguido dos IIF de
	* Situas/Ifors/ForaLinha/Margems/Encargos/cFtios+cFtioCs).
	*====================================================================
	PROTECTED FUNCTION MontarWhereFiltros()
		LOCAL loc_cWhere, loc_cCampoMoeda

		*-- laCampo[5] do legado: 'Moedas', ou 'Moevs' quando fwoption1.Value = 2
		loc_cCampoMoeda = IIF(THIS.this_nOpcaoMoeda = 2, "Moevs", "Moedas")

		loc_cWhere = ""
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "CGrus",     THIS.this_cGrupoI,    THIS.this_cGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Cunis",     THIS.this_cUnidadeI,  THIS.this_cUnidadeF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Linhas",    THIS.this_cLinhaI,    THIS.this_cLinhaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Colecoes",  THIS.this_cColecaoI,  THIS.this_cColecaoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, loc_cCampoMoeda, THIS.this_cMoedaI, THIS.this_cMoedaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "SGrus",     THIS.this_cSubGrupoI, THIS.this_cSubGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Mercs",     THIS.this_cMercI,     THIS.this_cMercF)

		loc_cWhere = ALLTRIM(loc_cWhere)
		IF EMPTY(loc_cWhere)
			loc_cWhere = "1=1"
		ENDIF
		IF UPPER(RIGHT(loc_cWhere, 3)) == "AND"
			loc_cWhere = ALLTRIM(SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3))
		ENDIF

		*-- Situacao (Opc_situacao): 1=Ativos, 2=Inativos, 3=Todos (sem filtro)
		IF INLIST(THIS.this_nSituacao, 1, 2)
			loc_cWhere = loc_cWhere + " And Situas = " + FormatarNumeroSQL(THIS.this_nSituacao, 0)
		ENDIF

		*-- Fornecedor (getCFornecs)
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFornecs, "")))
			loc_cWhere = loc_cWhere + " And Ifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecs))
		ENDIF

		*-- Opc_Compra: 1=Comprar (ForaLinha=0), 2=Nao Comprar (ForaLinha=1), 3=Todos
		IF INLIST(THIS.this_nOpcaoCompra, 1, 2)
			loc_cWhere = loc_cWhere + " And ForaLinha = " + IIF(THIS.this_nOpcaoCompra = 1, "0", "1")
		ENDIF

		*-- Faixa de Markup (GetMrki/GetMrkf)
		IF THIS.this_nMarkupI > 0
			loc_cWhere = loc_cWhere + " And Margems Between " + ;
				FormatarNumeroSQL(THIS.this_nMarkupI, 2) + " And " + FormatarNumeroSQL(THIS.this_nMarkupF, 2)
		ENDIF

		*-- Faixa de Encargo (Get_EncI/Get_Encf)
		IF THIS.this_nEncargoI > 0
			loc_cWhere = loc_cWhere + " And Encargos Between " + ;
				FormatarNumeroSQL(THIS.this_nEncargoI, 2) + " And " + FormatarNumeroSQL(THIS.this_nEncargoF, 2)
		ENDIF

		*-- Feitio (Get_Feitio) - casa tanto o feitio de venda quanto o de custo
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFeitio, "")))
			loc_cWhere = loc_cWhere + " And (cFtios = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ;
				" Or cFtioCs = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ")"
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* BuscarProdutosFiltrados - Consulta SigCdPro com a clausula WHERE de
	* MontarWhereFiltros (transcricao da fase de consulta do metodo
	* "processar" legado: "lcQuery = [Select * From SigCdPro Where ] +
	* lcWhere + ..."). O calculo de reajuste (conversao de moeda, peso de
	* composicao e markup de grupo) que o legado aplica DEPOIS desta
	* consulta usa this_nReajuste/this_nNovoMarkup/this_nNovoEncargo, que
	* espelham os controles Get_Reajuste/GetnMrk/Get_Encargo do formulario.
	*
	* Resultado fica em cursor_4c_ProdutosSQL (cpros/dpros/pvens/custofs/
	* pvideals/fcustos/fvendas/moecs/moevs) para o Form transferir para o
	* cursor da grade (cursor_4c_Produtos) em CarregarLista.
	*====================================================================
	FUNCTION BuscarProdutosFiltrados()
		LOCAL loc_cWhere, loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cWhere = THIS.MontarWhereFiltros()

			IF USED("cursor_4c_ProdutosSQL")
				USE IN cursor_4c_ProdutosSQL
			ENDIF

			*-- cgrus nao aparece na grade, mas viaja junto porque a
			*-- reclassificacao de subgrupo por faixa (ResolverSubGrupoPorFaixa)
			*-- precisa do grupo do produto na hora de gravar
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT cpros, dpros, pvens, custofs, pvideals, fcustos, fvendas,
					moecs, moevs, cgrus
				FROM SigCdPro
				WHERE <<loc_cWhere>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosSQL")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao consultar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao buscar produtos:" + CHR(13) + loException.Message, ;
				"sigprccpBO.BuscarProdutosFiltrados")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


	*====================================================================
	* BuscarPresetsAutomaticos - Le os presets de recalculo ativos de
	* SigCdCcp para o modo Automatico. Transcricao literal da consulta do
	* metodo "processaautomatico" legado:
	*     lcQuery = [Select * From SigCdCcp Where Inativas <> 1]
	*
	* Resultado em cursor_4c_PresetsCcp (uma linha por preset, na ordem
	* natural da tabela - o legado nao ordena).
	*====================================================================
	FUNCTION BuscarPresetsAutomaticos()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_PresetsCcp")
				USE IN cursor_4c_PresetsCcp
			ENDIF

			loc_cSQL = "SELECT * FROM SigCdCcp WHERE Inativas <> 1"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PresetsCcp")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
					CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o (SigCdCcp)")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler presets de rec" + CHR(225) + "lculo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.BuscarPresetsAutomaticos")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterChkSubGrupos - Le SigCdPaC.nchksubgrs, o parametro que liga a
	* reclassificacao de subgrupo por faixa de preco no fim do metodo
	* "atualizar" legado (If crSigCdPac.nChkSubGrs = 1). O legado carrega
	* esse valor no Init (CursorQuery 'SigCdPaC' ... 'Calccusts,NCHKSUBGRS').
	*
	* Retorno: NUMERICO (0 quando o parametro nao existe ou a consulta
	* falha) - nchksubgrs eh numeric(1,0), nao bit, entao chega SEMPRE
	* numerico e nao precisa de teste de VARTYPE para Logico.
	*====================================================================
	FUNCTION ObterChkSubGrupos()
		LOCAL loc_cSQL, loc_nResultado, loc_nChk
		loc_nChk = 0

		TRY
			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF

			loc_cSQL = "SELECT TOP 1 nchksubgrs FROM SigCdPaC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PacChk")

			IF loc_nResultado >= 0 AND USED("cursor_4c_PacChk")
				SELECT cursor_4c_PacChk
				GO TOP
				IF !EOF()
					loc_nChk = TratarNulo(cursor_4c_PacChk.nchksubgrs, 0)
				ENDIF
			ENDIF

			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler par" + CHR(226) + "metro de subgrupo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ObterChkSubGrupos")
		ENDTRY

		RETURN loc_nChk
	ENDFUNC

	*====================================================================
	* ResolverSubGrupoPorFaixa - Devolve o subgrupo (SigCdPsg.codigos) cuja
	* faixa comporta o preco de venda informado. Transcricao do bloco do
	* metodo "atualizar" legado:
	*     Select * From SigCdPsg Where CGrus = '<grupo>' Order By nFaixaFins
	*     Locate For nFaixaFins >= lnPVens
	*     If ! Eof() -> Replace sGrus With csSigCdPsg.Codigos
	* O "Locate" sobre o cursor ORDENADO por nFaixaFins pega a PRIMEIRA
	* faixa cujo limite superior alcanca o preco - equivalente exato ao
	* TOP 1 ... ORDER BY nfaixafins abaixo.
	*
	* Retorno: CHAR com o codigo do subgrupo, "" quando nao ha faixa
	* (caso em que o legado NAO troca o subgrupo).
	*====================================================================
	FUNCTION ResolverSubGrupoPorFaixa(par_cGrupo, par_nVenda)
		LOCAL loc_cSQL, loc_nResultado, loc_cCodigo
		loc_cCodigo = ""

		TRY
			IF !EMPTY(ALLTRIM(TratarNulo(par_cGrupo, "")))
				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF

				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT TOP 1 codigos
					FROM SigCdPsg
					WHERE cgrus = <<EscaparSQL(ALLTRIM(par_cGrupo))>>
						AND nfaixafins >= <<FormatarNumeroSQL(par_nVenda, 2)>>
					ORDER BY nfaixafins
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Psg")

				IF loc_nResultado >= 0 AND USED("cursor_4c_Psg")
					SELECT cursor_4c_Psg
					GO TOP
					IF !EOF()
						loc_cCodigo = ALLTRIM(TratarNulo(cursor_4c_Psg.codigos, ""))
					ENDIF
				ENDIF

				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao resolver subgrupo por faixa:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ResolverSubGrupoPorFaixa")
		ENDTRY

		RETURN loc_cCodigo
	ENDFUNC

	*====================================================================
	* ColunasComunsProPrc - Lista das 121 colunas presentes ao mesmo tempo
	* em SigCdPro e SigCdPrc (extraidas de docs/schema.sql). O legado copia
	* o registro INTEIRO com "Scatter Memvar Memo" + "Insert Into
	* CrSigCdPrc From MemVar", que preenche apenas os campos de nome igual
	* nas duas tabelas - esta lista eh exatamente esse conjunto.
	*
	* par_lOrigem = .T. devolve as EXPRESSOES do SELECT sobre SigCdPro,
	* com LEFT() nas 3 colunas que sao mais CURTAS no destino (locals
	* 10->6, sittricms 3->2, codtams 4->2); sem o LEFT o SQL Server recusa
	* o INSERT com "String or binary data would be truncated".
	* par_lOrigem = .F. devolve os nomes crus, para a lista de destino.
	*====================================================================
	PROTECTED FUNCTION ColunasComunsProPrc(par_lOrigem)
		LOCAL loc_c
		loc_c = ""
		loc_c = loc_c + "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, "
		loc_c = loc_c + "cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, "
		loc_c = loc_c + "fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(locals, 6)", "locals") + ", "
		loc_c = loc_c + "margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, "
		loc_c = loc_c + "obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, "
		loc_c = loc_c + "reffs, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(sittricms, 2)", "sittricms") + ", "
		loc_c = loc_c + "tcomps, tipos, transps, valors, varias, situas, "
		loc_c = loc_c + "dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, "
		loc_c = loc_c + "codcors, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(codtams, 2)", "codtams") + ", "
		loc_c = loc_c + "compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, "
		loc_c = loc_c + "chkfunds, casas, impetiqs, qtdcpnts, dpro2s, dsccompras, encoms, obscompras, "
		loc_c = loc_c + "codacbs, cravcers, cunips, ipis, mercs, pesobs, tamhs, tamls, "
		loc_c = loc_c + "tamps, tptribs, volumes, obsetqs, ultcomps, vultcomps, multcomps, markupa, "
		loc_c = loc_c + "tinsts, cclass, cftiocs, figtecs, nivelqs, pftiocs, usuincs, diasinas, "
		loc_c = loc_c + "idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, contaccus, "
		loc_c = loc_c + "gruccus, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, "
		loc_c = loc_c + "idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, "
		loc_c = loc_c + "conjunts"

		RETURN loc_c
	ENDFUNC

	*====================================================================
	* GravarHistoricoPreco - Registra em SigCdPrc o retrato do produto
	* ANTES da gravacao do preco novo. Transcricao do bloco do metodo
	* "atualizar" legado:
	*     lcSql = [Select * From SigCdPro Where Cpros = ']+m.cpros+[']
	*     Select TmpPro2 / Scatter Memvar Memo
	*     m.DataAlts = Datetime() / m.HoraAlts = Substr(Ttoc(...),12,8)
	*     m.UsuaAlts = Usuar / m.cIdChaves = fUniqueIds()
	*     m.Origem   = Ttoc(Datetime()) + [ SigPrCcp]
	*     Insert Into CrSigCdPrc From MemVar
	* Feito com INSERT ... SELECT (server-side) para nao trazer as 121
	* colunas para o VFP so para devolve-las.
	*
	* As 15 colunas NOT NULL que existem em SigCdPrc e NAO em SigCdPro
	* recebem o valor em branco do tipo - equivalente ao registro em
	* branco do cursor do legado, que o "Insert From Memvar" nao toca.
	* SigCdPrc nao tem nenhum DEFAULT, entao omitir qualquer uma delas
	* faria o SQL Server recusar o INSERT inteiro (CLAUDE.md regra #22).
	* figuras (image) fica de fora porque aceita NULL.
	*
	* IMPORTANTE: chamar ANTES de Salvar()/Atualizar(), senao o historico
	* guarda o preco NOVO em vez do antigo.
	*====================================================================
	FUNCTION GravarHistoricoPreco(par_cCpros)
		LOCAL loc_cSQL, loc_cDestino, loc_cOrigem, loc_cExtras, loc_cValores
		LOCAL loc_cHora, loc_cOrigemTxt, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- m.HoraAlts = Substr(Ttoc(m.DataAlts),12,8) do legado
			loc_cHora = SUBSTR(TTOC(DATETIME()), 12, 8)

			*-- m.Origem = Ttoc(Datetime()) + [ SigPrCcp] do legado
			loc_cOrigemTxt = LEFT(TTOC(DATETIME()) + " SigPrCcp", 30)

			loc_cExtras  = "codcpds, cbms, caracts, cunifors, custocvs, ltmins, markcvs, pesomts, " + ;
				"pidealcvs, qtdias, retiras, codccnjs, montagens, tmontas, codconc"
			loc_cValores = EscaparSQL("") + ", 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ;
				", 0, 0, 0, 0, 0, 0, 0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ;
				", " + EscaparSQL("")

			loc_cDestino = THIS.ColunasComunsProPrc(.F.)
			loc_cOrigem  = THIS.ColunasComunsProPrc(.T.)

			loc_cSQL = "INSERT INTO SigCdPrc " + ;
				"(dataalts, horaalts, usuaalts, cidchaves, origem, " + ;
				loc_cExtras + ", " + loc_cDestino + ") " + ;
				"SELECT GETDATE(), " + ;
				EscaparSQL(loc_cHora) + ", " + ;
				EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
				EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
				EscaparSQL(loc_cOrigemTxt) + ", " + ;
				loc_cValores + ", " + loc_cOrigem + " " + ;
				"FROM SigCdPro WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
					"rico de pre" + CHR(231) + "o (SigCdPrc) do produto " + ;
					ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de pre" + CHR(231) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.GravarHistoricoPreco")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* GravarHistoricoComposicao - Copia a composicao corrente do produto
	* (SigPrCpo) para SigPrCp2. Transcricao do bloco do metodo "atualizar"
	* legado:
	*     Select * From SigPrCpo Where CPros = '<cpros>' -> TmpCompo
	*     Scan / Scatter MemVar Memo
	*        m.DataAlts/HoraAlts/UsuaAlts / m.cIdChaves = fUniqueIds()
	*        Insert Into CrSigPrCp2 From MemVar
	*     EndScan
	* Como o legado gera um cIdChaves NOVO por LINHA, a gravacao eh feita
	* linha a linha (um INSERT ... SELECT por cidchaves de origem) - um
	* unico INSERT em conjunto repetiria a mesma chave em todas as linhas
	* e colidiria no indice unico.
	*
	* SigPrCp2 = SigPrCpo menos PedraPrincipal, mais dataalts/horaalts/
	* usuaalts; dcompos eh char(30) contra char(40) na origem, por isso o
	* LEFT(dcompos, 30).
	*====================================================================
	FUNCTION GravarHistoricoComposicao(par_cCpros)
		LOCAL loc_cSQL, loc_cCols, loc_cColsOrig, loc_cHora, loc_cUsuario
		LOCAL loc_nResultado, loc_lSucesso, loc_lProsseguir
		loc_lSucesso    = .F.
		loc_lProsseguir = .T.

		TRY
			loc_cHora    = SUBSTR(TTOC(DATETIME()), 12, 8)
			loc_cUsuario = LEFT(gc_4c_UsuarioLogado, 10)

			loc_cCols = ""
			loc_cCols = loc_cCols + "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, "
			loc_cCols = loc_cCols + "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, "
			loc_cCols = loc_cCols + "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, dtmovs, "
			loc_cCols = loc_cCols + "cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, "
			loc_cCols = loc_cCols + "tipos, matriz, obsofs"

			*-- Mesma lista, com LEFT() na unica coluna mais curta no destino
			loc_cColsOrig = STRTRAN(loc_cCols, "dcompos,", "LEFT(dcompos, 30),")

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF

			loc_cSQL = "SELECT cidchaves FROM SigPrCpo WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoOrig")

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Falha ao ler composi" + CHR(231) + CHR(227) + ;
					"o do produto " + ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				*-- Produto sem composicao: nada a historiar, e o legado
				*-- tambem apenas nao entra no Scan (sucesso)
				loc_lSucesso = .T.

				SELECT cursor_4c_CompoOrig
				SCAN
					loc_cSQL = "INSERT INTO SigPrCp2 " + ;
						"(dataalts, horaalts, usuaalts, cidchaves, " + loc_cCols + ") " + ;
						"SELECT GETDATE(), " + ;
						EscaparSQL(loc_cHora) + ", " + ;
						EscaparSQL(loc_cUsuario) + ", " + ;
						EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
						loc_cColsOrig + " " + ;
						"FROM SigPrCpo WHERE cidchaves = " + ;
						EscaparSQL(ALLTRIM(cursor_4c_CompoOrig.cidchaves))

					IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
						THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
							"rico de composi" + CHR(231) + CHR(227) + "o (SigPrCp2) do produto " + ;
							ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
						MsgErro(THIS.this_cMensagemErro, "Erro SQL")
						loc_lSucesso = .F.
						EXIT
					ENDIF

					SELECT cursor_4c_CompoOrig
				ENDSCAN
			ENDIF

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de composi" + ;
				CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, ;
				"sigprccpBO.GravarHistoricoComposicao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ExcluirPrecosTabela - Apaga os precos de tabela do produto, que
	* passam a estar defasados depois do recalculo. Transcricao literal do
	* metodo "atualizar" legado:
	*     [Delete From SigPrPrt Where CPros = '] + m.CPros + [' ]
	*====================================================================
	FUNCTION ExcluirPrecosTabela(par_cCpros)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigPrPrt WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao excluir pre" + CHR(231) + ;
					"os de tabela (SigPrPrt) do produto " + ALLTRIM(par_cCpros) + ;
					": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao excluir pre" + CHR(231) + "os de tabela:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ExcluirPrecosTabela")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* IniciarTransacao / ConfirmarTransacao / DesfazerTransacao
	*
	* Equivalentes de ThisForm.poDataMgr.Commit() / .RollBack() do legado,
	* que existem porque o fSqlConector legado abre a conexao com
	* Transactions = 2 (manual). Neste ambiente a conexao JA nasce em
	* transacao manual (SQLGETPROP(0,"Transactions") = 2 num VFP9 virgem),
	* entao nao ha nada a abrir: IniciarTransacao apenas confere o handle e
	* limpa a mensagem de erro; o que importa eh o par SQLCOMMIT/
	* SQLROLLBACK no fim - sem eles a transacao nunca eh fechada e a
	* gravacao SOME se o processo morrer antes do disconnect limpo.
	*====================================================================
	FUNCTION IniciarTransacao()
		THIS.this_cMensagemErro = ""
		RETURN (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
	ENDFUNC

	FUNCTION ConfirmarTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLCOMMIT(gnConnHandle) > 0)
			IF !loc_lSucesso
				THIS.this_cMensagemErro = "Falha ao confirmar a transa" + CHR(231) + ;
					CHR(227) + "o: " + CapturarErroSQL()
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.ConfirmarTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	FUNCTION DesfazerTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLROLLBACK(gnConnHandle) > 0)
		CATCH TO loException
			MostrarErro("Erro ao desfazer transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.DesfazerTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


ENDDEFINE

