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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppag.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2950 linhas total):

*-- Linhas 53 a 67:
53: *   Top/Left/Width/Height do dump; sem Format/InputMask porque o dump
54: *   nao declara nenhum para estes controles (regra #49 - "" no dump e
55: *   override vazio do Form Designer, nao se transcreve). A segunda
56: *   metade (bloco de Totais/Saldo/Variacao/checkboxes/avisos de porta)
57: *   entrou na Fase 6/8, abaixo.
58: *
59: * Fase 6/8 - CAMPOS RESTANTES (PARTE 2/2) E LOOKUPS:
60: *   ConfigurarCamposTotais(): segunda metade dos campos soltos do dump -
61: *   o bloco "Valores Totais/Saldo/Variacao/Desconto%/Cambio/Bonus" e os
62: *   checkboxes de atalho (Bot_TotForma/Bot_TotItem/Bot_Cotacoes/Bot_Cpg/
63: *   btnMascPgto/btnCash) e os 6 avisos de porta (AvisoPorta*), ainda fora
64: *   dos containers flutuantes de forma de pagamento (esses continuam na
65: *   Fase 7/8, junto com os Click/When/InteractiveChange).
66: *
67: *   ConfigurarLookups(): os DOIS lookups que o dump tem em controle

*-- Linhas 106 a 114:
106: *   (parcelas, CPF, tabela de desconto, bonus, autorizacao via
107: *   SigOpSen) e regra de GRAVACAO, nao de lookup - fica para a Fase 7/8.
108: *
109: * Fase 7/8 - EVENTOS DOS 5 BOTOES REAIS DE ACAO (cmd_4c_BtnRetCash/Apaga/
110: * Totite/Ok/Cancela - NAO os genericos Incluir/Alterar/Visualizar/Excluir
111: * do padrao CRUD, que este form OPERACIONAL nao tem, regra do cabecalho):
112: *   ConfigurarEventosBotoes(): BINDEVENT do Click dos 5 botoes a metodos
113: *   PUBLIC (regra #3). btnRetCash tambem tem When no dump, mas CommandButton
114: *   do VFP9 nao tem evento When nativo (era campo GET da base fwbutton do

*-- Linhas 362 a 422:
362: 	PROTECTED PROCEDURE ConfigurarLayout()
363: 		THIS.AddObject("cnt_4c_Cabecalho", "Container")
364: 		WITH THIS.cnt_4c_Cabecalho
365: 			.Top = 0
366: 			.Left = 0
367: 			.Width = THIS.Width
368: 			.Height = 80
369: 			.BackStyle = 1
370: 			.BackColor = RGB(100, 100, 100)
371: 			.BorderWidth = 0
372: 			.SpecialEffect = 0
373: 			.Visible = .T.
374: 
375: 			.AddObject("lbl_4c_Sombra", "Label")
376: 			WITH .lbl_4c_Sombra
377: 				.Top = 15
378: 				.Left = 10
379: 				.Width = THIS.Width
380: 				.Height = 40
381: 				.FontName = "Tahoma"
382: 				.FontSize = 16
383: 				.FontBold = .T.
384: 				.ForeColor = RGB(0, 0, 0)
385: 				.BackStyle = 0
386: 				.AutoSize = .F.
387: 				.Caption = THIS.Caption
388: 				.Visible = .T.
389: 			ENDWITH
390: 
391: 			.AddObject("lbl_4c_Titulo", "Label")
392: 			WITH .lbl_4c_Titulo
393: 				.Top = 18
394: 				.Left = 10
395: 				.Width = THIS.Width
396: 				.Height = 46
397: 				.FontName = "Tahoma"
398: 				.FontSize = 16
399: 				.FontBold = .T.
400: 				.ForeColor = RGB(255, 255, 255)
401: 				.BackStyle = 0
402: 				.AutoSize = .F.
403: 				.Caption = THIS.Caption
404: 				.Visible = .T.
405: 			ENDWITH
406: 		ENDWITH
407: 
408: 		*-- Container dos botoes de acao. Transparente (BackStyle = 0) para
409: 		*-- a faixa cinza aparecer por tras, e criado DEPOIS da faixa para
410: 		*-- desenhar por cima dela. Left = 660 (1050 - 390) alinha o
411: 		*-- container ao primeiro botao do legado (btnRetCash, Left = 672
412: 		*-- absoluto -> 12 relativo); o ultimo (Cancela, 973 absoluto ->
413: 		*-- 313 relativo) termina em 388, dentro dos 390 de largura.
414: 		THIS.AddObject("cnt_4c_Botoes", "Container")
415: 		WITH THIS.cnt_4c_Botoes
416: 			.Top = 0
417: 			.Left = THIS.Width - 390
418: 			.Width = 390
419: 			.Height = 80
420: 			.BackStyle = 0
421: 			.BorderWidth = 0
422: 			.Visible = .T.

*-- Linhas 451 a 462:
451: 		*-- btnRetCash "Retorna Bonus" - nasce INVISIVEL no legado
452: 		*-- (Visible = .F. no dump); so aparece quando a operacao tem
453: 		*-- bonus/cashback liberado.
454: 		loc_oCnt.AddObject("cmd_4c_BtnRetCash", "CommandButton")
455: 		WITH loc_oCnt.cmd_4c_BtnRetCash
456: 			.Top = 3
457: 			.Left = 12
458: 			.Width = 75
459: 			.Height = 75
460: 			.FontName = "Comic Sans MS"
461: 			.FontSize = 8
462: 			.FontBold = .T.

*-- Linhas 471 a 488:
471: 			.PicturePosition = 7
472: 			.Picture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
473: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
474: 			.Caption = "Retorna B" + CHR(244) + "nus"
475: 			.ToolTipText = "Retorna B" + CHR(244) + "nus"
476: 			.Visible = .F.
477: 		ENDWITH
478: 
479: 		*-- Apaga "Excluir Condicao" - remove a condicao selecionada na grade
480: 		loc_oCnt.AddObject("cmd_4c_Apaga", "CommandButton")
481: 		WITH loc_oCnt.cmd_4c_Apaga
482: 			.Top = 3
483: 			.Left = 88
484: 			.Width = 75
485: 			.Height = 75
486: 			.FontName = "Comic Sans MS"
487: 			.FontSize = 8
488: 			.FontBold = .T.

*-- Linhas 496 a 513:
496: 			.PicturePosition = 7
497: 			.Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
498: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
499: 			.Caption = "Excluir Condi" + CHR(231) + CHR(227) + "o"
500: 			.ToolTipText = "Apagar Condi" + CHR(231) + CHR(227) + "o de Pagamento"
501: 			.Visible = .T.
502: 		ENDWITH
503: 
504: 		*-- totite "Total dos Produtos"
505: 		loc_oCnt.AddObject("cmd_4c_Totite", "CommandButton")
506: 		WITH loc_oCnt.cmd_4c_Totite
507: 			.Top = 3
508: 			.Left = 163
509: 			.Width = 75
510: 			.Height = 75
511: 			.FontName = "Comic Sans MS"
512: 			.FontSize = 8
513: 			.FontBold = .T.

*-- Linhas 521 a 538:
521: 			.PicturePosition = 7
522: 			.Picture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
523: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
524: 			.Caption = "Total dos Produtos"
525: 			.ToolTipText = "Total da Movimenta" + CHR(231) + CHR(227) + "o"
526: 			.Visible = .T.
527: 		ENDWITH
528: 
529: 		*-- Ok "Confirmar" - o "\<" do dump e o marcador de tecla de acesso
530: 		loc_oCnt.AddObject("cmd_4c_Ok", "CommandButton")
531: 		WITH loc_oCnt.cmd_4c_Ok
532: 			.Top = 3
533: 			.Left = 238
534: 			.Width = 75
535: 			.Height = 75
536: 			.FontName = "Comic Sans MS"
537: 			.FontSize = 8
538: 			.FontBold = .T.

*-- Linhas 545 a 566:
545: 			.PicturePosition = 13
546: 			.Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
547: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
548: 			.Caption = "\<Confirmar"
549: 			.Cancel = .T.
550: 			.Visible = .T.
551: 		ENDWITH
552: 
553: 		*-- Cancela "Encerrar" - criado DEPOIS do Ok de proposito: o dump
554: 		*-- traz Cancel = .T. nos DOIS botoes e, em VFP9, o ultimo a
555: 		*-- receber Cancel = .T. e quem responde ao ESC. Mantendo a ordem
556: 		*-- do legado, o ESC continua fechando a tela ([ESC] Sair no
557: 		*-- ToolTipText do proprio dump).
558: 		loc_oCnt.AddObject("cmd_4c_Cancela", "CommandButton")
559: 		WITH loc_oCnt.cmd_4c_Cancela
560: 			.Top = 3
561: 			.Left = 313
562: 			.Width = 75
563: 			.Height = 75
564: 			.FontName = "Comic Sans MS"
565: 			.FontSize = 8
566: 			.FontBold = .T.

*-- Linhas 573 a 581:
573: 			.PicturePosition = 13
574: 			.Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
575: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
576: 			.Caption = "Encerrar"
577: 			.Cancel = .T.
578: 			.ToolTipText = "[ESC] Sair"
579: 			.Visible = .T.
580: 		ENDWITH
581: 	ENDPROC

*-- Linhas 625 a 634:
625: 
626: 		THIS.AddObject("grd_4c_Condicoes", "Grid")
627: 		WITH THIS.grd_4c_Condicoes
628: 			.Top = 107
629: 			.Left = 444
630: 			.Width = 573
631: 			.Height = 246
632: 			.FontName = "Verdana"
633: 			.FontSize = 8
634: 			.HeaderHeight = 18

*-- Linhas 700 a 1550:
700: 	* controles, nas posicoes e tamanhos exatos do dump.
701: 	*
702: 	* Mapeamento (SCX legado -> migrado), Top/Left/Width/Height do dump:
703: 	*   Say12          -> lbl_4c_Condicao     (147,96)  "Condicao :"
704: 	*   Get_modfpg     -> txt_4c_Modfpg       (142,178,36,25)  numeric
705: 	*   Get_fpg        -> txt_4c_Fpg          (142,218,147,25) char(12)
706: 	*   Say13          -> lbl_4c_Parcelas     (174,119) "Parcelas :"
707: 	*   Get_npar       -> txt_4c_Npar         (169,178,36,25)  numeric
708: 	*   GetPorc        -> txt_4c_Porc         (169,218,147,25) numeric
709: 	*   Say17          -> lbl_4c_Valor        (228,135) "Valor :"
710: 	*   Get_vpar       -> txt_4c_Vpar         (223,178,186,25) numeric
711: 	*   Say2           -> lbl_4c_Vencimento   (254,96)  "Vencimento :"
712: 	*   Get_Dias       -> txt_4c_Dias         (250,178,36,25)  numeric
713: 	*   Dataget_venc   -> txt_4c_DataVenc     (250,218,146,25) date
714: 	*   Say20          -> lbl_4c_Moeda        (302,132) "Moeda :"
715: 	*   Get_moeoper    -> txt_4c_MoeOper      (297,182,35,25)  char(3)
716: 	*   Say24          -> lbl_4c_Original     (329,129) "Original :"
717: 	*   Get_valinic    -> txt_4c_ValInic      (324,182,146,25) numeric
718: 	*   Line1          -> lin_4c_Line1        (292,41,370,1)   divisor
719: 	*   Shape1         -> shp_4c_Shape1       (9,640,1,27)     divisor
720: 	*====================================================================
721: 	PROTECTED PROCEDURE ConfigurarCamposCondicao()
722: 		*-- Condicao (fpags - char(12)) + modalidade da forma de pgto
723: 		THIS.AddObject("lbl_4c_Condicao", "Label")
724: 		WITH THIS.lbl_4c_Condicao
725: 			.Top = 147
726: 			.Left = 96
727: 			.Width = 78
728: 			.AutoSize = .F.
729: 			.Alignment = 0
730: 			.FontName = "Tahoma"
731: 			.FontSize = 8
732: 			.ForeColor = RGB(90, 90, 90)
733: 			.BackStyle = 0
734: 			.Caption = "Condi" + CHR(231) + CHR(227) + "o :"
735: 			.Visible = .T.
736: 		ENDWITH
737: 
738: 		THIS.AddObject("txt_4c_Modfpg", "TextBox")
739: 		WITH THIS.txt_4c_Modfpg
740: 			.Top = 142
741: 			.Left = 178
742: 			.Width = 36
743: 			.Height = 25
744: 			.FontName = "Tahoma"
745: 			.FontSize = 8
746: 			.Value = 0
747: 			.Visible = .T.
748: 		ENDWITH
749: 
750: 		THIS.AddObject("txt_4c_Fpg", "TextBox")
751: 		WITH THIS.txt_4c_Fpg
752: 			.Top = 142
753: 			.Left = 218
754: 			.Width = 147
755: 			.Height = 25
756: 			.FontName = "Tahoma"
757: 			.FontSize = 8
758: 			.Value = ""
759: 			.Visible = .T.
760: 		ENDWITH
761: 
762: 		*-- Parcelas (nparcs) + % de variacao (pVarias)
763: 		THIS.AddObject("lbl_4c_Parcelas", "Label")
764: 		WITH THIS.lbl_4c_Parcelas
765: 			.Top = 174
766: 			.Left = 119
767: 			.Width = 55
768: 			.AutoSize = .F.
769: 			.Alignment = 0
770: 			.FontName = "Tahoma"
771: 			.FontSize = 8
772: 			.ForeColor = RGB(90, 90, 90)
773: 			.BackStyle = 0
774: 			.Caption = "Parcelas :"
775: 			.Visible = .T.
776: 		ENDWITH
777: 
778: 		THIS.AddObject("txt_4c_Npar", "TextBox")
779: 		WITH THIS.txt_4c_Npar
780: 			.Top = 169
781: 			.Left = 178
782: 			.Width = 36
783: 			.Height = 25
784: 			.FontName = "Tahoma"
785: 			.FontSize = 8
786: 			.Value = 0
787: 			.Visible = .T.
788: 		ENDWITH
789: 
790: 		THIS.AddObject("txt_4c_Porc", "TextBox")
791: 		WITH THIS.txt_4c_Porc
792: 			.Top = 169
793: 			.Left = 218
794: 			.Width = 147
795: 			.Height = 25
796: 			.FontName = "Tahoma"
797: 			.FontSize = 8
798: 			.Value = 0
799: 			.Visible = .T.
800: 		ENDWITH
801: 
802: 		*-- Valor da parcela (valos)
803: 		THIS.AddObject("lbl_4c_Valor", "Label")
804: 		WITH THIS.lbl_4c_Valor
805: 			.Top = 228
806: 			.Left = 135
807: 			.Width = 39
808: 			.AutoSize = .F.
809: 			.Alignment = 0
810: 			.FontName = "Tahoma"
811: 			.FontSize = 8
812: 			.ForeColor = RGB(90, 90, 90)
813: 			.BackStyle = 0
814: 			.Caption = "Valor :"
815: 			.Visible = .T.
816: 		ENDWITH
817: 
818: 		THIS.AddObject("txt_4c_Vpar", "TextBox")
819: 		WITH THIS.txt_4c_Vpar
820: 			.Top = 223
821: 			.Left = 178
822: 			.Width = 186
823: 			.Height = 25
824: 			.FontName = "Tahoma"
825: 			.FontSize = 8
826: 			.Value = 0
827: 			.Visible = .T.
828: 		ENDWITH
829: 
830: 		*-- Vencimento (vencs) + dias (Dias)
831: 		THIS.AddObject("lbl_4c_Vencimento", "Label")
832: 		WITH THIS.lbl_4c_Vencimento
833: 			.Top = 254
834: 			.Left = 96
835: 			.Width = 78
836: 			.AutoSize = .F.
837: 			.Alignment = 0
838: 			.FontName = "Tahoma"
839: 			.FontSize = 8
840: 			.ForeColor = RGB(90, 90, 90)
841: 			.BackStyle = 0
842: 			.Caption = "Vencimento :"
843: 			.Visible = .T.
844: 		ENDWITH
845: 
846: 		THIS.AddObject("txt_4c_Dias", "TextBox")
847: 		WITH THIS.txt_4c_Dias
848: 			.Top = 250
849: 			.Left = 178
850: 			.Width = 36
851: 			.Height = 25
852: 			.FontName = "Tahoma"
853: 			.FontSize = 8
854: 			.Value = 0
855: 			.Visible = .T.
856: 		ENDWITH
857: 
858: 		THIS.AddObject("txt_4c_DataVenc", "TextBox")
859: 		WITH THIS.txt_4c_DataVenc
860: 			.Top = 250
861: 			.Left = 218
862: 			.Width = 146
863: 			.Height = 25
864: 			.FontName = "Tahoma"
865: 			.FontSize = 8
866: 			.Value = {}
867: 			.Visible = .T.
868: 		ENDWITH
869: 
870: 		*-- Moeda da operacao (Cmoes) + valor original (Valinis)
871: 		THIS.AddObject("lbl_4c_Moeda", "Label")
872: 		WITH THIS.lbl_4c_Moeda
873: 			.Top = 302
874: 			.Left = 132
875: 			.Width = 46
876: 			.AutoSize = .F.
877: 			.Alignment = 0
878: 			.FontName = "Tahoma"
879: 			.FontSize = 8
880: 			.ForeColor = RGB(90, 90, 90)
881: 			.BackStyle = 0
882: 			.Caption = "Moeda :"
883: 			.Visible = .T.
884: 		ENDWITH
885: 
886: 		THIS.AddObject("txt_4c_MoeOper", "TextBox")
887: 		WITH THIS.txt_4c_MoeOper
888: 			.Top = 297
889: 			.Left = 182
890: 			.Width = 35
891: 			.Height = 25
892: 			.FontName = "Tahoma"
893: 			.FontSize = 8
894: 			.Value = ""
895: 			.Visible = .T.
896: 		ENDWITH
897: 
898: 		THIS.AddObject("lbl_4c_Original", "Label")
899: 		WITH THIS.lbl_4c_Original
900: 			.Top = 329
901: 			.Left = 129
902: 			.Width = 49
903: 			.AutoSize = .F.
904: 			.Alignment = 0
905: 			.FontName = "Tahoma"
906: 			.FontSize = 8
907: 			.ForeColor = RGB(90, 90, 90)
908: 			.BackStyle = 0
909: 			.Caption = "Original :"
910: 			.Visible = .T.
911: 		ENDWITH
912: 
913: 		THIS.AddObject("txt_4c_ValInic", "TextBox")
914: 		WITH THIS.txt_4c_ValInic
915: 			.Top = 324
916: 			.Left = 182
917: 			.Width = 146
918: 			.Height = 25
919: 			.FontName = "Tahoma"
920: 			.FontSize = 8
921: 			.Value = 0
922: 			.Visible = .T.
923: 		ENDWITH
924: 
925: 		*-- Divisores decorativos do dump (Line1/Shape1), sem funcao de
926: 		*-- dado - so separam visualmente o bloco de condicao do restante
927: 		THIS.AddObject("lin_4c_Line1", "Line")
928: 		WITH THIS.lin_4c_Line1
929: 			.Top = 292
930: 			.Left = 41
931: 			.Width = 370
932: 			.Height = 1
933: 			.Visible = .T.
934: 		ENDWITH
935: 
936: 		THIS.AddObject("shp_4c_Shape1", "Shape")
937: 		WITH THIS.shp_4c_Shape1
938: 			.Top = 9
939: 			.Left = 640
940: 			.Width = 1
941: 			.Height = 27
942: 			.Visible = .T.
943: 		ENDWITH
944: 	ENDPROC
945: 
946: 	*====================================================================
947: 	* ConfigurarCamposTotais - PARTE 2/2 dos campos soltos do dump que
948: 	* ficam direto em SIGOPPAG: o bloco "Valores Totais / Saldo /
949: 	* Variacao / Desconto % / Cambio / Bonus" mais os checkboxes de
950: 	* atalho e os 6 avisos de porta. Sem ControlSource/eventos ainda
951: 	* (Fases 7-8) - so os controles, nas posicoes e tamanhos exatos do
952: 	* dump (layout.json).
953: 	*
954: 	* Mapeamento (SCX legado -> migrado), Top/Left/Width/Height do dump:
955: 	*   Say6           -> lbl_4c_ValoresTotais (273,70,87,16) "Valores Totais"
956: 	*   Get_TotServico -> txt_4c_TotServico    (351,182,146,25) numeric
957: 	*   Say21          -> lbl_4c_Servicos      (356,124) "Servicos :"
958: 	*   getValTrans    -> txt_4c_ValTrans      (378,182,146,25) numeric
959: 	*   Say7           -> lbl_4c_Transporte    (383,108) "Transporte :"
960: 	*   Get_Variacao   -> txt_4c_Variacao      (405,182,146,25) numeric
961: 	*   Say5           -> lbl_4c_Variacao      (410,123) "Variacao :"
962: 	*   Get_valtot     -> txt_4c_ValTot        (432,182,146,25) numeric
963: 	*   Get_pVaria     -> txt_4c_PVaria        (513,182,146,25) numeric
964: 	*   Say3           -> lbl_4c_DescontoPercent (514,90,88,16) "Desconto (%) :"
965: 	*   Get_Saldo      -> txt_4c_Saldo         (486,182,146,25) numeric
966: 	*   Say1           -> lbl_4c_Saldo         (491,134) "Saldo :"
967: 	*   Get_TotForma   -> txt_4c_TotForma      (459,182,146,25) numeric
968: 	*   Say4           -> lbl_4c_DescontoCifrao (545,95,83,16) "Desconto ($) :"
969: 	*   Get_TVaria     -> txt_4c_TVaria        (540,182,146,25) numeric
970: 	*   Get_pDescP     -> txt_4c_PDescP        (570,769,71,23) numeric
971: 	*   Get_VDescP     -> txt_4c_VDescP        (570,858,111,23) numeric
972: 	*   Label2         -> lbl_4c_PercentVDescP (575,750,16,15) "%"
973: 	*   Label1         -> lbl_4c_CifraoVDescP  (575,845,10,15) "$"
974: 	*   lblValUtiCsh   -> lbl_4c_ValUtiCsh     (86,758) "Bonus :"
975: 	*   getValUtiCsh   -> txt_4c_ValUtiCsh     (82,805,117,25) numeric
976: 	*   btnCash        -> chk_4c_BtnCash       (83,924,111,23) "Aplicar Bonus"
977: 	*   Get_COTACAO    -> txt_4c_Cotacao       (196,178,100,25) numeric - oculto no dump
978: 	*   alteracotacao  -> cmd_4c_AlteraCotacao (196,281,26,26) "\<C$" - oculto no dump
979: 	*   Say_Cotacao    -> lbl_4c_Cambio        (201,123) "Cambio :" - oculto no dump
980: 	*   Bot_Cpg        -> chk_4c_BotCpg        (142,368,26,26) "$"
981: 	*   Bot_Cotacoes   -> chk_4c_BotCotacoes   (297,220,33,26)
982: 	*   Bot_TotItem    -> chk_4c_BotTotItem    (324,331,33,26)
983: 	*   Bot_TotForma   -> chk_4c_BotTotForma   (459,331,33,26)
984: 	*   btnMascPgto    -> chk_4c_BtnMascPgto   (142,397,26,26) "..." - oculto no dump
985: 	*   Say10          -> lbl_4c_Movimentacao  (437,90) "Movimentacao :"
986: 	*   Say23          -> lbl_4c_Recebimento   (464,96) "Recebimento :"
987: 	*   lbl_Mensagem   -> lbl_4c_Mensagem      (85,444,276,18) "Mensagem" - oculto no dump
988: 	*   AvisoPortaS/M/T/C/A/K -> txt_4c_AvisoPorta<X> (108/132/156/180/204/228, 1020,20,23)
989: 	*====================================================================
990: 	PROTECTED PROCEDURE ConfigurarCamposTotais()
991: 		*-- Titulo da secao "Valores Totais" (Say6 - classe say pura, sem
992: 		*-- Width/Alignment declarados no dump, regra #23)
993: 		THIS.AddObject("lbl_4c_ValoresTotais", "Label")
994: 		WITH THIS.lbl_4c_ValoresTotais
995: 			.Top = 273
996: 			.Left = 70
997: 			.Width = 87
998: 			.Height = 16
999: 			.AutoSize = .F.
1000: 			.Alignment = 0
1001: 			.FontName = "Tahoma"
1002: 			.FontSize = 8
1003: 			.ForeColor = RGB(90, 90, 90)
1004: 			.BackStyle = 0
1005: 			.Caption = "Valores Totais"
1006: 			.Visible = .T.
1007: 		ENDWITH
1008: 
1009: 		*-- Total de servicos (Get_TotServico)
1010: 		THIS.AddObject("lbl_4c_Servicos", "Label")
1011: 		WITH THIS.lbl_4c_Servicos
1012: 			.Top = 356
1013: 			.Left = 124
1014: 			.Width = 55
1015: 			.AutoSize = .F.
1016: 			.Alignment = 0
1017: 			.FontName = "Tahoma"
1018: 			.FontSize = 8
1019: 			.ForeColor = RGB(90, 90, 90)
1020: 			.BackStyle = 0
1021: 			.Caption = "Servi" + CHR(231) + "os :"
1022: 			.Visible = .T.
1023: 		ENDWITH
1024: 
1025: 		THIS.AddObject("txt_4c_TotServico", "TextBox")
1026: 		WITH THIS.txt_4c_TotServico
1027: 			.Top = 351
1028: 			.Left = 182
1029: 			.Width = 146
1030: 			.Height = 25
1031: 			.FontName = "Tahoma"
1032: 			.FontSize = 8
1033: 			.Value = 0
1034: 			.Visible = .T.
1035: 		ENDWITH
1036: 
1037: 		*-- Valor de transporte/frete (getValTrans)
1038: 		THIS.AddObject("lbl_4c_Transporte", "Label")
1039: 		WITH THIS.lbl_4c_Transporte
1040: 			.Top = 383
1041: 			.Left = 108
1042: 			.Width = 70
1043: 			.AutoSize = .F.
1044: 			.Alignment = 0
1045: 			.FontName = "Tahoma"
1046: 			.FontSize = 8
1047: 			.ForeColor = RGB(90, 90, 90)
1048: 			.BackStyle = 0
1049: 			.Caption = "Transporte :"
1050: 			.Visible = .T.
1051: 		ENDWITH
1052: 
1053: 		THIS.AddObject("txt_4c_ValTrans", "TextBox")
1054: 		WITH THIS.txt_4c_ValTrans
1055: 			.Top = 378
1056: 			.Left = 182
1057: 			.Width = 146
1058: 			.Height = 25
1059: 			.FontName = "Tahoma"
1060: 			.FontSize = 8
1061: 			.Value = 0
1062: 			.Visible = .T.
1063: 		ENDWITH
1064: 
1065: 		*-- Variacao (desconto/acrescimo manual total - Get_Variacao)
1066: 		THIS.AddObject("lbl_4c_Variacao", "Label")
1067: 		WITH THIS.lbl_4c_Variacao
1068: 			.Top = 410
1069: 			.Left = 123
1070: 			.Width = 55
1071: 			.AutoSize = .F.
1072: 			.Alignment = 0
1073: 			.FontName = "Tahoma"
1074: 			.FontSize = 8
1075: 			.ForeColor = RGB(90, 90, 90)
1076: 			.BackStyle = 0
1077: 			.Caption = "Varia" + CHR(231) + CHR(227) + "o :"
1078: 			.Visible = .T.
1079: 		ENDWITH
1080: 
1081: 		THIS.AddObject("txt_4c_Variacao", "TextBox")
1082: 		WITH THIS.txt_4c_Variacao
1083: 			.Top = 405
1084: 			.Left = 182
1085: 			.Width = 146
1086: 			.Height = 25
1087: 			.FontName = "Tahoma"
1088: 			.FontSize = 8
1089: 			.Value = 0
1090: 			.Visible = .T.
1091: 		ENDWITH
1092: 
1093: 		*-- Valor total do movimento (Get_valtot)
1094: 		THIS.AddObject("txt_4c_ValTot", "TextBox")
1095: 		WITH THIS.txt_4c_ValTot
1096: 			.Top = 432
1097: 			.Left = 182
1098: 			.Width = 146
1099: 			.Height = 25
1100: 			.FontName = "Tahoma"
1101: 			.FontSize = 8
1102: 			.Value = 0
1103: 			.Visible = .T.
1104: 		ENDWITH
1105: 
1106: 		*-- Total das formas de pagamento ja lancadas (Get_TotForma)
1107: 		THIS.AddObject("txt_4c_TotForma", "TextBox")
1108: 		WITH THIS.txt_4c_TotForma
1109: 			.Top = 459
1110: 			.Left = 182
1111: 			.Width = 146
1112: 			.Height = 25
1113: 			.FontName = "Tahoma"
1114: 			.FontSize = 8
1115: 			.Value = 0
1116: 			.Visible = .T.
1117: 		ENDWITH
1118: 
1119: 		*-- Saldo a distribuir (Get_Saldo)
1120: 		THIS.AddObject("lbl_4c_Saldo", "Label")
1121: 		WITH THIS.lbl_4c_Saldo
1122: 			.Top = 491
1123: 			.Left = 134
1124: 			.Width = 39
1125: 			.AutoSize = .F.
1126: 			.Alignment = 0
1127: 			.FontName = "Tahoma"
1128: 			.FontSize = 8
1129: 			.ForeColor = RGB(90, 90, 90)
1130: 			.BackStyle = 0
1131: 			.Caption = "Saldo :"
1132: 			.Visible = .T.
1133: 		ENDWITH
1134: 
1135: 		THIS.AddObject("txt_4c_Saldo", "TextBox")
1136: 		WITH THIS.txt_4c_Saldo
1137: 			.Top = 486
1138: 			.Left = 182
1139: 			.Width = 146
1140: 			.Height = 25
1141: 			.FontName = "Tahoma"
1142: 			.FontSize = 8
1143: 			.Value = 0
1144: 			.Visible = .T.
1145: 		ENDWITH
1146: 
1147: 		*-- Desconto em percentual sobre a parcela corrente (Get_pVaria)
1148: 		THIS.AddObject("lbl_4c_DescontoPercent", "Label")
1149: 		WITH THIS.lbl_4c_DescontoPercent
1150: 			.Top = 514
1151: 			.Left = 90
1152: 			.Width = 88
1153: 			.Height = 16
1154: 			.AutoSize = .F.
1155: 			.Alignment = 0
1156: 			.FontName = "Tahoma"
1157: 			.FontSize = 8
1158: 			.ForeColor = RGB(90, 90, 90)
1159: 			.BackStyle = 0
1160: 			.Caption = "Desconto (%) :"
1161: 			.Visible = .T.
1162: 		ENDWITH
1163: 
1164: 		THIS.AddObject("txt_4c_PVaria", "TextBox")
1165: 		WITH THIS.txt_4c_PVaria
1166: 			.Top = 513
1167: 			.Left = 182
1168: 			.Width = 146
1169: 			.Height = 25
1170: 			.FontName = "Tahoma"
1171: 			.FontSize = 8
1172: 			.Value = 0
1173: 			.Visible = .T.
1174: 		ENDWITH
1175: 
1176: 		*-- Desconto em valor sobre a parcela corrente (Get_TVaria)
1177: 		THIS.AddObject("lbl_4c_DescontoCifrao", "Label")
1178: 		WITH THIS.lbl_4c_DescontoCifrao
1179: 			.Top = 545
1180: 			.Left = 95
1181: 			.Width = 83
1182: 			.Height = 16
1183: 			.AutoSize = .F.
1184: 			.Alignment = 0
1185: 			.FontName = "Tahoma"
1186: 			.FontSize = 8
1187: 			.ForeColor = RGB(90, 90, 90)
1188: 			.BackStyle = 0
1189: 			.Caption = "Desconto ($) :"
1190: 			.Visible = .T.
1191: 		ENDWITH
1192: 
1193: 		THIS.AddObject("txt_4c_TVaria", "TextBox")
1194: 		WITH THIS.txt_4c_TVaria
1195: 			.Top = 540
1196: 			.Left = 182
1197: 			.Width = 146
1198: 			.Height = 25
1199: 			.FontName = "Tahoma"
1200: 			.FontSize = 8
1201: 			.Value = 0
1202: 			.Visible = .T.
1203: 		ENDWITH
1204: 
1205: 		*-- Percentual e valor de desconto financeiro (Get_pDescP/Get_VDescP)
1206: 		THIS.AddObject("txt_4c_PDescP", "TextBox")
1207: 		WITH THIS.txt_4c_PDescP
1208: 			.Top = 570
1209: 			.Left = 769
1210: 			.Width = 71
1211: 			.Height = 23
1212: 			.FontName = "Tahoma"
1213: 			.FontSize = 8
1214: 			.Value = 0
1215: 			.Visible = .T.
1216: 		ENDWITH
1217: 
1218: 		THIS.AddObject("lbl_4c_PercentVDescP", "Label")
1219: 		WITH THIS.lbl_4c_PercentVDescP
1220: 			.Top = 575
1221: 			.Left = 750
1222: 			.Width = 16
1223: 			.Height = 15
1224: 			.AutoSize = .F.
1225: 			.Alignment = 0
1226: 			.FontName = "Tahoma"
1227: 			.FontSize = 8
1228: 			.ForeColor = RGB(90, 90, 90)
1229: 			.BackStyle = 0
1230: 			.Caption = "%"
1231: 			.Visible = .T.
1232: 		ENDWITH
1233: 
1234: 		THIS.AddObject("txt_4c_VDescP", "TextBox")
1235: 		WITH THIS.txt_4c_VDescP
1236: 			.Top = 570
1237: 			.Left = 858
1238: 			.Width = 111
1239: 			.Height = 23
1240: 			.FontName = "Tahoma"
1241: 			.FontSize = 8
1242: 			.Value = 0
1243: 			.Visible = .T.
1244: 		ENDWITH
1245: 
1246: 		THIS.AddObject("lbl_4c_CifraoVDescP", "Label")
1247: 		WITH THIS.lbl_4c_CifraoVDescP
1248: 			.Top = 575
1249: 			.Left = 845
1250: 			.Width = 10
1251: 			.Height = 15
1252: 			.AutoSize = .F.
1253: 			.Alignment = 0
1254: 			.FontName = "Tahoma"
1255: 			.FontSize = 8
1256: 			.ForeColor = RGB(90, 90, 90)
1257: 			.BackStyle = 0
1258: 			.Caption = "$"
1259: 			.Visible = .T.
1260: 		ENDWITH
1261: 
1262: 		*-- Bonus/cashback disponivel (lblValUtiCsh/getValUtiCsh) + checkbox
1263: 		*-- "Aplicar Bonus" (btnCash)
1264: 		THIS.AddObject("lbl_4c_ValUtiCsh", "Label")
1265: 		WITH THIS.lbl_4c_ValUtiCsh
1266: 			.Top = 86
1267: 			.Left = 758
1268: 			.Width = 45
1269: 			.AutoSize = .F.
1270: 			.Alignment = 0
1271: 			.FontName = "Tahoma"
1272: 			.FontSize = 8
1273: 			.ForeColor = RGB(90, 90, 90)
1274: 			.BackStyle = 0
1275: 			.Caption = "B" + CHR(244) + "nus :"
1276: 			.Visible = .T.
1277: 		ENDWITH
1278: 
1279: 		THIS.AddObject("txt_4c_ValUtiCsh", "TextBox")
1280: 		WITH THIS.txt_4c_ValUtiCsh
1281: 			.Top = 82
1282: 			.Left = 805
1283: 			.Width = 117
1284: 			.Height = 25
1285: 			.FontName = "Tahoma"
1286: 			.FontSize = 8
1287: 			.Value = 0
1288: 			.Visible = .T.
1289: 		ENDWITH
1290: 
1291: 		THIS.AddObject("chk_4c_BtnCash", "CheckBox")
1292: 		WITH THIS.chk_4c_BtnCash
1293: 			.Top = 83
1294: 			.Left = 924
1295: 			.Width = 111
1296: 			.Height = 23
1297: 			.FontName = "Tahoma"
1298: 			.FontSize = 8
1299: 			.ForeColor = RGB(90, 90, 90)
1300: 			.Caption = "Aplicar B" + CHR(244) + "nus"
1301: 			.Value = 0
1302: 			.Visible = .T.
1303: 		ENDWITH
1304: 
1305: 		*-- Cambio manual (Get_COTACAO/alteracotacao/Say_Cotacao) - OCULTOS
1306: 		*-- no dump (visible:false): so aparecem quando a moeda da forma de
1307: 		*-- pagamento exige cotacao manual (CrSigCdCrg.AltCots - Fase 7/8).
1308: 		THIS.AddObject("lbl_4c_Cambio", "Label")
1309: 		WITH THIS.lbl_4c_Cambio
1310: 			.Top = 201
1311: 			.Left = 123
1312: 			.Width = 45
1313: 			.AutoSize = .F.
1314: 			.Alignment = 0
1315: 			.FontName = "Tahoma"
1316: 			.FontSize = 8
1317: 			.ForeColor = RGB(90, 90, 90)
1318: 			.BackStyle = 0
1319: 			.Caption = "C" + CHR(226) + "mbio :"
1320: 			.Visible = .F.
1321: 		ENDWITH
1322: 
1323: 		THIS.AddObject("txt_4c_Cotacao", "TextBox")
1324: 		WITH THIS.txt_4c_Cotacao
1325: 			.Top = 196
1326: 			.Left = 178
1327: 			.Width = 100
1328: 			.Height = 25
1329: 			.FontName = "Tahoma"
1330: 			.FontSize = 8
1331: 			.Value = 0
1332: 			.Visible = .F.
1333: 		ENDWITH
1334: 
1335: 		THIS.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
1336: 		WITH THIS.cmd_4c_AlteraCotacao
1337: 			.Top = 196
1338: 			.Left = 281
1339: 			.Width = 26
1340: 			.Height = 26
1341: 			.FontName = "Tahoma"
1342: 			.FontSize = 8
1343: 			.ForeColor = RGB(90, 90, 90)
1344: 			.BackColor = RGB(255, 255, 255)
1345: 			.Caption = "\<C$"
1346: 			.Visible = .F.
1347: 		ENDWITH
1348: 
1349: 		*-- Checkboxes de atalho (Bot_TotForma/Bot_TotItem/Bot_Cotacoes/
1350: 		*-- Bot_Cpg) - togglers de grade auxiliar/modo de calculo, sem
1351: 		*-- Caption proprio no dump (so Bot_Cpg tem "$")
1352: 		THIS.AddObject("chk_4c_BotTotForma", "CheckBox")
1353: 		WITH THIS.chk_4c_BotTotForma
1354: 			.Top = 459
1355: 			.Left = 331
1356: 			.Width = 33
1357: 			.Height = 26
1358: 			.Caption = ""
1359: 			.Value = 0
1360: 			.Visible = .T.
1361: 		ENDWITH
1362: 
1363: 		THIS.AddObject("chk_4c_BotTotItem", "CheckBox")
1364: 		WITH THIS.chk_4c_BotTotItem
1365: 			.Top = 324
1366: 			.Left = 331
1367: 			.Width = 33
1368: 			.Height = 26
1369: 			.Caption = ""
1370: 			.Value = 0
1371: 			.Visible = .T.
1372: 		ENDWITH
1373: 
1374: 		THIS.AddObject("chk_4c_BotCotacoes", "CheckBox")
1375: 		WITH THIS.chk_4c_BotCotacoes
1376: 			.Top = 297
1377: 			.Left = 220
1378: 			.Width = 33
1379: 			.Height = 26
1380: 			.Caption = ""
1381: 			.Value = 0
1382: 			.Visible = .T.
1383: 		ENDWITH
1384: 
1385: 		THIS.AddObject("chk_4c_BotCpg", "CheckBox")
1386: 		WITH THIS.chk_4c_BotCpg
1387: 			.Top = 142
1388: 			.Left = 368
1389: 			.Width = 26
1390: 			.Height = 26
1391: 			.FontName = "Tahoma"
1392: 			.FontSize = 8
1393: 			.ForeColor = RGB(90, 90, 90)
1394: 			.Caption = "$"
1395: 			.Value = 0
1396: 			.Visible = .T.
1397: 		ENDWITH
1398: 
1399: 		*-- Mascara de cartao (btnMascPgto) - OCULTO no dump; abre o
1400: 		*-- container flutuante cntFundo.cntMascPgto (Fase 7/8)
1401: 		THIS.AddObject("chk_4c_BtnMascPgto", "CheckBox")
1402: 		WITH THIS.chk_4c_BtnMascPgto
1403: 			.Top = 142
1404: 			.Left = 397
1405: 			.Width = 26
1406: 			.Height = 26
1407: 			.FontName = "Tahoma"
1408: 			.FontSize = 8
1409: 			.ForeColor = RGB(90, 90, 90)
1410: 			.Caption = "..."
1411: 			.Value = 0
1412: 			.Visible = .F.
1413: 		ENDWITH
1414: 
1415: 		*-- Titulos "Movimentacao :" / "Recebimento :" (separadores de
1416: 		*-- secao da area de totais, classe say pura)
1417: 		THIS.AddObject("lbl_4c_Movimentacao", "Label")
1418: 		WITH THIS.lbl_4c_Movimentacao
1419: 			.Top = 437
1420: 			.Left = 90
1421: 			.Width = 90
1422: 			.AutoSize = .F.
1423: 			.Alignment = 0
1424: 			.FontName = "Tahoma"
1425: 			.FontSize = 8
1426: 			.ForeColor = RGB(90, 90, 90)
1427: 			.BackStyle = 0
1428: 			.Caption = "Movimenta" + CHR(231) + CHR(227) + "o :"
1429: 			.Visible = .T.
1430: 		ENDWITH
1431: 
1432: 		THIS.AddObject("lbl_4c_Recebimento", "Label")
1433: 		WITH THIS.lbl_4c_Recebimento
1434: 			.Top = 464
1435: 			.Left = 96
1436: 			.Width = 85
1437: 			.AutoSize = .F.
1438: 			.Alignment = 0
1439: 			.FontName = "Tahoma"
1440: 			.FontSize = 8
1441: 			.ForeColor = RGB(90, 90, 90)
1442: 			.BackStyle = 0
1443: 			.Caption = "Recebimento :"
1444: 			.Visible = .T.
1445: 		ENDWITH
1446: 
1447: 		*-- Mensagem de status (lbl_Mensagem) - OCULTO no dump; usado pelo
1448: 		*-- fluxo de confirmacao/erro de TEF (Fase 7/8)
1449: 		THIS.AddObject("lbl_4c_Mensagem", "Label")
1450: 		WITH THIS.lbl_4c_Mensagem
1451: 			.Top = 85
1452: 			.Left = 444
1453: 			.Width = 276
1454: 			.Height = 18
1455: 			.AutoSize = .F.
1456: 			.Alignment = 0
1457: 			.FontName = "Tahoma"
1458: 			.FontSize = 8
1459: 			.ForeColor = RGB(90, 90, 90)
1460: 			.BackStyle = 0
1461: 			.Caption = "Mensagem"
1462: 			.Visible = .F.
1463: 		ENDWITH
1464: 
1465: 		*-- Avisos de porta aberta do leitor serial de cheques
1466: 		*-- (AvisoPortaS/M/T/C/A/K - readcomm, container deferido para
1467: 		*-- Fase 7/8; os 6 TextBox ficam direto no form no dump)
1468: 		THIS.AddObject("txt_4c_AvisoPortaS", "TextBox")
1469: 		WITH THIS.txt_4c_AvisoPortaS
1470: 			.Top = 108
1471: 			.Left = 1020
1472: 			.Width = 20
1473: 			.Height = 23
1474: 			.FontName = "Tahoma"
1475: 			.FontSize = 8
1476: 			.Value = ""
1477: 			.Visible = .T.
1478: 		ENDWITH
1479: 
1480: 		THIS.AddObject("txt_4c_AvisoPortaM", "TextBox")
1481: 		WITH THIS.txt_4c_AvisoPortaM
1482: 			.Top = 132
1483: 			.Left = 1020
1484: 			.Width = 20
1485: 			.Height = 23
1486: 			.FontName = "Tahoma"
1487: 			.FontSize = 8
1488: 			.Value = ""
1489: 			.Visible = .T.
1490: 		ENDWITH
1491: 
1492: 		THIS.AddObject("txt_4c_AvisoPortaT", "TextBox")
1493: 		WITH THIS.txt_4c_AvisoPortaT
1494: 			.Top = 156
1495: 			.Left = 1020
1496: 			.Width = 20
1497: 			.Height = 23
1498: 			.FontName = "Tahoma"
1499: 			.FontSize = 8
1500: 			.Value = ""
1501: 			.Visible = .T.
1502: 		ENDWITH
1503: 
1504: 		THIS.AddObject("txt_4c_AvisoPortaC", "TextBox")
1505: 		WITH THIS.txt_4c_AvisoPortaC
1506: 			.Top = 180
1507: 			.Left = 1020
1508: 			.Width = 20
1509: 			.Height = 23
1510: 			.FontName = "Tahoma"
1511: 			.FontSize = 8
1512: 			.Value = ""
1513: 			.Visible = .T.
1514: 		ENDWITH
1515: 
1516: 		THIS.AddObject("txt_4c_AvisoPortaA", "TextBox")
1517: 		WITH THIS.txt_4c_AvisoPortaA
1518: 			.Top = 204
1519: 			.Left = 1020
1520: 			.Width = 20
1521: 			.Height = 23
1522: 			.FontName = "Tahoma"
1523: 			.FontSize = 8
1524: 			.Value = ""
1525: 			.Visible = .T.
1526: 		ENDWITH
1527: 
1528: 		THIS.AddObject("txt_4c_AvisoPortaK", "TextBox")
1529: 		WITH THIS.txt_4c_AvisoPortaK
1530: 			.Top = 228
1531: 			.Left = 1020
1532: 			.Width = 20
1533: 			.Height = 23
1534: 			.FontName = "Tahoma"
1535: 			.FontSize = 8
1536: 			.Value = ""
1537: 			.Visible = .T.
1538: 		ENDWITH
1539: 
1540: 		*-- Icone decorativo da secao "Valores Totais" (Image1 - dump nao
1541: 		*-- declara .Picture, regra #25: NUNCA inventar nome de arquivo)
1542: 		THIS.AddObject("img_4c_Imagem1", "Image")
1543: 		WITH THIS.img_4c_Imagem1
1544: 			.Top = 266
1545: 			.Left = 41
1546: 			.Width = 26
1547: 			.Height = 26
1548: 			.BorderStyle = 0
1549: 			.Visible = .T.
1550: 		ENDWITH

*-- Linhas 1621 a 1634:
1621: 
1622: 					*-- 5) Header1.Caption (idem - resetado pelo RecordSource).
1623: 					*-- Alignment = 2 (centralizado) em todos, como no dump.
1624: 					.Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
1625: 					.Column2.Header1.Caption = "Valor"
1626: 					.Column3.Header1.Caption = "Vencimento"
1627: 					.Column4.Header1.Caption = "Moe"
1628: 					.Column5.Header1.Caption = "C" + CHR(226) + "mbio"
1629: 					.Column6.Header1.Caption = "Desconto"
1630: 
1631: 					.Column1.Header1.Alignment = 2
1632: 					.Column2.Header1.Alignment = 2
1633: 					.Column3.Header1.Alignment = 2
1634: 					.Column4.Header1.Alignment = 2

*-- Linhas 2108 a 2120:
2108: 
2109: 		loc_oCnt = THIS.cnt_4c_Botoes
2110: 
2111: 		BINDEVENT(loc_oCnt.cmd_4c_BtnRetCash, "Click", THIS, "BtnRetCashClick")
2112: 		BINDEVENT(loc_oCnt.cmd_4c_Apaga, "Click", THIS, "BtnExcluirCondicaoClick")
2113: 		BINDEVENT(loc_oCnt.cmd_4c_Totite, "Click", THIS, "BtnTotalProdutosClick")
2114: 		BINDEVENT(loc_oCnt.cmd_4c_Ok, "Click", THIS, "BtnConfirmarClick")
2115: 		BINDEVENT(loc_oCnt.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
2116: 	ENDPROC
2117: 
2118: 	*====================================================================
2119: 	* AjustarBotoesPorModo - Fase 8/8: centraliza o Enabled dos 5 botoes de
2120: 	* acao conforme THIS.this_cOpEscolha (equivalente ao modo pcEscolha do

*-- Linhas 2145 a 2163:
2145: 		*-- btnRetCash: Enabled pelo proprio When ja portado (3 valores no
2146: 		*-- Click do dump - linha 6432 - contra 2 no When do botao; sao
2147: 		*-- regras DIFERENTES do mesmo controle, nao inconsistencia).
2148: 		loc_oCnt.cmd_4c_BtnRetCash.Enabled = THIS.BtnRetCashWhen()
2149: 
2150: 		*-- Apaga/Ok: o Click dos dois exige INSERIR/ALTERAR (regra #40) -
2151: 		*-- refletir no Enabled evita o clique inerte em modo CONSULTAR.
2152: 		loc_oCnt.cmd_4c_Apaga.Enabled = loc_lEdicao
2153: 		loc_oCnt.cmd_4c_Ok.Enabled    = loc_lEdicao
2154: 
2155: 		*-- Totite (sem When no dump) e Cancela (precisa fechar a tela
2156: 		*-- mesmo em CONSULTAR) ficam sempre habilitados.
2157: 		loc_oCnt.cmd_4c_Totite.Enabled  = .T.
2158: 		loc_oCnt.cmd_4c_Cancela.Enabled = .T.
2159: 	ENDPROC
2160: 
2161: 	*====================================================================
2162: 	* HabilitarCampos - Fase 8/8: habilita/desabilita os campos soltos do
2163: 	* bloco "Condicao" conforme o modo do form pai e o preenchimento da

*-- Linhas 2183 a 2191:
2183: 	*   - Get_COTACAO.When/alteracotacao.When exigem Seek em crSigCdCrg
2184: 	*     (cargo do usuario logado) e CrSigCdMoe.Cotas - nenhum dos dois
2185: 	*     cursores existe no projeto novo; txt_4c_Cotacao/
2186: 	*     cmd_4c_AlteraCotacao seguem Visible = .F., como no dump (Fase
2187: 	*     6/8), e nao sao tocados aqui.
2188: 	*
2189: 	* PUBLIC - chamado por InicializarForm() e por AbrirBuscaFormaPagamento()
2190: 	* (o valor de Fpg so e conhecido depois do lookup resolver) e por
2191: 	* LimparCampos() (abaixo).


### BO (C:\4c\projeto\app\classes\sigoppagBO.prg):
*====================================================================
* sigoppagBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPPAG" ("Recebimento" -
* condicoes de pagamento/recebimento de um movimento). O legado abre
* este form como FILHO do form de cabecalho do movimento (Lparameters
* pForm, datses, plAltDireta, plAutomatico - Set Datasession To datses,
* isto e, o filho passa a compartilhar a MESMA data session do pai, com
* os cursores xPar/TprMvCab/crSigCdOpe/crSigMvNfi/crSigCdCfo/crSigCdPam
* ja abertos por ele).
*
* Tabelas envolvidas: SigMvPar (condicoes de pagamento/parcelas do
* movimento - cursor legado xPar, chave cidchaves), SigMvCab (cabecalho
* do movimento - espelhado no cursor temporario TprMvCab do pai),
* SigCdOpe (configuracao da operacao), SigOpFp (catalogo de formas de
* pagamento), SigCdMoe (moedas), SigCdCrt (bandeiras de cartao),
* SigCdCad (adquirentes/modalidades - tipocads = 'ADQUIRENTE'),
* SigCdMod (modalidades de pagamento), SigCqChm/SigChe (protocolo e
* cheque), SigCdCtt (protocolo de cartao de credito).
*
* Referencias legado -> BO (linha do xPar sendo incluida/alterada,
* mapeamento 1-para-1 para SigMvPar):
*   xPar.Agencias/Bancos/Cartaos/Contas/CotFPgs/Dopes/EmpOs/FPags/
*   InsChs/MoeFPgs/NCarnes/NCarts/NoCreditos/Nsu/NumChqs/Numeros/Numes/
*   NumOlds/Obs/Outros/Trocos/ValDescs/Valos/Vencs/adquirente/autoriza/
*   cnIdTefs/nIdCheps/Parcs/TParcs/VPags ->
*       this_cAgencias/this_cBancos/this_cCartaos/this_cContas/
*       this_nCotfpgs/this_cDopes/this_cEmpos/this_cFpags/this_lInschs/
*       this_cMoefpgs/this_cNcarnes/this_nNcarts/this_cNocreditos/
*       this_cNsu/this_cNumchqs/this_cNumeros/this_nNumes/
*       this_nNumolds/this_cObs/this_cOutros/this_nTrocos/
*       this_nValdescs/this_nValos/this_dVencs/this_cAdquirente/
*       this_cAutoriza/this_cCnidtefs/this_nNidcheps/this_nParcs/
*       this_nTparcs/this_nVpags
*   (demais colunas de SigMvPar sem uso direto no codigo analisado -
*   declaradas do mesmo jeito, para paridade de schema/INSERT futuro:
*   this_nEcNumes/this_cGrclis/this_cIclis/this_cImpcars/this_cLocals/
*   this_nNcopias/this_nNopers/this_nNrecs/this_nNtrans/this_cCotusus/
*   this_cCnnsuparcs/this_nNumlotechs/this_cCidchaves/this_nValocurs/
*   this_cEmpdopnums/this_cPagos/this_dDtalts/this_cCpfs/
*   this_cDigagencs/this_cDigchqs/this_cDigcontas/this_cPracas/
*   this_cCodbcrts/this_lLcancelas/this_nVcofins/this_nVcsll/this_nVirf/
*   this_nVlrtrbfs/this_nVpis/this_cChaveexterna/this_dDatas/
*   this_dDatatrans/this_cDcarts/this_dDpags/this_dDtdeps/this_cEmps)
*
* Cabecalho do movimento (TprMvCab/SigMvCab), lido via Emps+Dopes+Numes
* (this_cEmps/this_cDopes/this_nNumes abaixo). Sufixo "Cab" evita colisao
* com propriedades de mesmo nome da linha de SigMvPar (ex.: this_nValos
* e o valor da PARCELA; this_nValosCab e o total do movimento):
*   TprMvCab.ContaOs/ContaDs/Datas/Notas/PrazoEnts/TabDs/TpFats/ValDevs/
*   ValEncs/ValInis/ValServs/ValTrans/ValUtiCsh/ValVarPs/ValVars/Valos/
*   VarTots/Vars -> this_cContaOsCab/this_cContaDsCab/this_dDatasCab/
*   this_cNotasCab/this_dPrazoEntsCab/this_cTabDsCab/this_cTpFatsCab/
*   this_nValDevsCab/this_nValEncsCab/this_nValInisCab/this_nValServsCab/
*   this_nValTransCab/this_nValUtiCshCab/this_nValVarPsCab/
*   this_nValVarsCab/this_nValosCab/this_nVarTotsCab/this_nVarsCab
*   (TabDs/TpFats corrigidos para CHAR na Fase 7/8 - docs\schema.sql mostra
*   SigMvCab.tabds char(10) e tpfats char(3); a Fase 1 os declarara como
*   numeric por engano e nenhum outro arquivo do projeto os referenciava
*   ainda, regra #19 - MaxLength/tipo vem do schema, nunca de palpite)
*
* Configuracao da operacao (SigCdOpe), lida via Dopes = this_cDopes.
* Sufixo "Ope" pelo mesmo motivo (SigCdOpe.Vars/parcs tambem colidiriam
* com propriedades de SigMvPar/outro config):
*   SigCdOpe.BlqDatas/CMoes/COpers/Caixas/Confes/Deacrs/DtEntrs/EdComis/
*   FPagOpCrs/HabServs/LPrecos/Opers/ParRecals/parcs/PesoVts/PrecoAuts/
*   PrecoVts/ValPres/Vars/aptpfats/cheqs/cupfis ->
*       this_nBlqDatasOpe/this_cCMoesOpe/this_nCopersOpe/this_nCaixasOpe/
*       this_nConfesOpe/this_nDeacrsOpe/this_nDtEntrsOpe/this_nEdComisOpe/
*       this_cFPagOpCrsOpe/this_nHabServsOpe/this_nLPrecosOpe/
*       this_nOpersOpe/this_nParRecalsOpe/this_nParcsOpe/this_nPesoVtsOpe/
*       this_nPrecoAutsOpe/this_nPrecoVtsOpe/this_nValPresOpe/
*       this_nVarsOpe/this_nAptpfatsOpe/this_nCheqsOpe/this_nCupfisOpe
*
* Flags recebidas do form pai na abertura (legado: plAltDireta,
* plAutomatico) -> this_lAltDireta/this_lAutomatico. poForm (referencia
* de UI) e a troca de DataSession ficam no FORM.
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). A leitura de SigMvCab/SigCdOpe (os
* campos *Cab/*Ope acima) sera carregada por metodo proprio em fase
* posterior - os valores abaixo ficam com o default ate la.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria()
* para a CONDICAO/PARCELA de SigMvPar (chave cidchaves), com
* RegistrarAuditoria() (herdado de BusinessBase) chamado em
* Inserir/Atualizar. cidchaves e a chave Fortyus (fUniqueIds(), regra
* #22) gerada no Inserir quando ainda vazia; empdopnums e a chave
* posicional Emps(3)+Dopes(20)+Str(Numes,6) (regra #42 - PADR explicito,
* nunca ALLTRIM nas partes).
*
* Fase 7/8 - CarregarConfiguracao() (SigMvCab/SigCdOpe, equivalentes aos
* cursores que o FORM PAI legado ja tinha abertos - regra #35/cabecalho
* acima), CarregarCondicoes() (leitura de SigMvPar para a grade - o
* legado faz isso via AddCursor no Init do pai; aqui e feito por SQLEXEC
* em cursor temporario + ZAP/APPEND no cursor ja ligado ao Grid, regra
* "SQLEXEC sobre alias de grid zera o ColumnCount") e ExcluirCondicao()
* (DELETE por cidchaves, chamado pelo Apaga.Click do form quando a linha
* corrente ja foi persistida em SigMvPar).
*====================================================================

DEFINE CLASS sigoppagBO AS BusinessBase

	*-- Flags recebidas do form pai na abertura (legado: Lparameters
	*-- pForm, datses, plAltDireta, plAutomatico). poForm (referencia de
	*-- UI) e a troca de DataSession ficam no Form.
	this_lAltDireta = .F.           && plAltDireta - fluxo de alteracao direta da condicao (pula parte da validacao de limite)
	this_lAutomatico = .F.          && plAutomatico - fluxo automatico (sem interacao do usuario, ex.: TEF/cartao processado por integracao)

	*-- Identificacao do cabecalho do movimento (legado: TprMvCab.Emps/
	*-- Dopes/Numes, compartilhados pela DataSession do pai). O form
	*-- migrado repassa so os valores escalares - mesmos valores que
	*-- aparecem tambem em cada linha de SigMvPar (emps/dopes/numes).
	this_cEmps = ""                 && Empresa do movimento (TprMvCab.Emps / SigMvCab.emps / SigMvPar.emps)
	this_cDopes = ""                && Documento de Operacao (TprMvCab.Dopes / SigMvCab.dopes / SigMvPar.dopes)
	this_nNumes = 0                 && Numero do movimento (TprMvCab.Numes / SigMvCab.numes / SigMvPar.numes)

	*-- Cabecalho do movimento (TprMvCab/SigMvCab), lido via Emps+Dopes+
	*-- Numes acima. Sufixo "Cab" para nao colidir com propriedade de
	*-- mesmo nome da linha de SigMvPar (ex.: valos). Populados em fase
	*-- posterior (leitura via SQLEXEC); default abaixo.
	this_cContaOsCab = ""           && TprMvCab.ContaOs - conta de origem do movimento (credito a estornar/base de calculo)
	this_cContaDsCab = ""           && TprMvCab.ContaDs - conta de destino do movimento (cliente/fornecedor, usado em Chklimite/CursorQuery de SigCdCli)
	this_dDatasCab = {}             && TprMvCab.Datas - data do movimento, base do vencimento default da parcela
	this_cNotasCab = ""             && TprMvCab.Notas - numero/mascara da nota fiscal do movimento (usado na mensagem de confirmacao do Ok.Click)
	this_dPrazoEntsCab = {}         && TprMvCab.PrazoEnts - prazo de entrega, usado como base alternativa do vencimento quando CrSigOpFp.TpVencs = 2
	this_cTabDsCab = ""             && TprMvCab.TabDs - tabela de preco de destino (char(10) no schema - SigMvCab.tabds)
	this_cTpFatsCab = ""            && TprMvCab.TpFats - tipo de faturamento do movimento (char(3) no schema - SigMvCab.tpfats; chave de SigCdTif.Codigos no Ok.Click)
	this_nValDevsCab = 0            && TprMvCab.ValDevs - valor de devolucao (usado no calculo do total a receber quando Vars = 4)
	this_nValEncsCab = 0            && TprMvCab.ValEncs - valor de encargos do movimento
	this_nValInisCab = 0            && TprMvCab.ValInis - valor inicial do movimento (base de calculo de desconto/acrescimo)
	this_nValServsCab = 0           && TprMvCab.ValServs - valor total de servicos do movimento (somado ao valor de produto no calculo de variacao)
	this_nValTransCab = 0           && TprMvCab.ValTrans - valor de transporte/frete do movimento
	this_nValUtiCshCab = 0          && TprMvCab.ValUtiCsh - valor de cashback/bonus utilizado no movimento
	this_nValVarPsCab = 0           && TprMvCab.ValVarPs - percentual de variacao (desconto/acrescimo) aplicado ao movimento
	this_nValVarsCab = 0            && TprMvCab.ValVars - valor de variacao (desconto negativo/acrescimo positivo) do movimento
	this_nValosCab = 0              && TprMvCab.Valos - valor total do movimento (a ratear entre as condicoes de pagamento)
	this_nVarTotsCab = 0            && TprMvCab.VarTots - total de variacao acumulado do movimento
	this_nVarsCab = 0               && TprMvCab.Vars - percentual de variacao do movimento (espelha ValVarPs em alguns pontos do legado)

	*-- Configuracao da operacao (SigCdOpe), lida via Dopes = this_cDopes.
	*-- Sufixo "Ope" pelo mesmo motivo de colisao de nomes (Vars/parcs
	*-- tambem existem em outras origens). Populados em fase posterior;
	*-- default abaixo.
	this_nBlqDatasOpe = 0           && SigCdOpe.BlqDatas - bloqueia alteracao de vencimento (1=sempre, 3=so para tras) no Valid de Dataget_venc
	this_cCMoesOpe = ""             && SigCdOpe.CMoes - moeda padrao da operacao (usada na cotacao de moeda da operacao x moeda de pagamento)
	this_nCopersOpe = 0             && SigCdOpe.COpers - tipo de calculo de troco/complemento (1=debita da conta, 2=credita)
	this_nCaixasOpe = 0             && SigCdOpe.Caixas - 1 = operacao movimenta caixa (habilita protocolo de cheque obrigatorio)
	this_nConfesOpe = 0             && SigCdOpe.Confes - 1 = condicao de pagamento ja confirmada (desabilita cartao de credito manual)
	this_nDeacrsOpe = 0             && SigCdOpe.Deacrs - habilita os containers de desconto/acrescimo manual (Get_PorcVariacao/Get_TotVariacao)
	this_nDtEntrsOpe = 0            && SigCdOpe.DtEntrs - habilita uso do prazo de entrega como base alternativa do vencimento (confirmar tipo exato no schema)
	this_nEdComisOpe = 0            && SigCdOpe.EdComis - habilita edicao manual do numero de parcelas (Get_npar)
	this_cFPagOpCrsOpe = ""         && SigCdOpe.FPagOpCrs - forma de pagamento padrao/credito da operacao (usada em Apaga.Click/comparacoes de forma)
	this_nHabServsOpe = 0           && SigCdOpe.HabServs - habilita o campo de total de servicos (Get_TotServico)
	this_nLPrecosOpe = 0            && SigCdOpe.LPrecos - operacao usa lista de precos (afeta regra de variacao/desconto)
	this_nOpersOpe = 0              && SigCdOpe.Opers - 1=Entrada/2=Saida, direcao da operacao
	this_nParRecalsOpe = 0          && SigCdOpe.ParRecals - recalcula parcelas automaticamente ao mudar o valor
	this_nParcsOpe = 0              && SigCdOpe.parcs - 1 = operacao permite parcelamento (habilita Get_npar/Get_vpar)
	this_nPesoVtsOpe = 0            && SigCdOpe.PesoVts - operacao totaliza por peso (usado em Bot_TotItem.Click)
	this_nPrecoAutsOpe = 0          && SigCdOpe.PrecoAuts - autoriza precificacao automatica (espelha o uso em outros BOs de item)
	this_nPrecoVtsOpe = 0           && SigCdOpe.PrecoVts - operacao totaliza por valor de venda (usado em Bot_TotItem.Click)
	this_nValPresOpe = 0            && SigCdOpe.ValPres - operacao exige valor presente (desconta juros/calcula a valor presente)
	this_nVarsOpe = 0               && SigCdOpe.Vars - tipo de variacao permitido na operacao (3 = bloqueia Desconto/Acrescimo)
	this_nAptpfatsOpe = 0           && SigCdOpe.aptpfats - tipo de fatura/apuracao da operacao
	this_nCheqsOpe = 0              && SigCdOpe.cheqs - operacao aceita cheque como forma de pagamento
	this_nCupfisOpe = 0             && SigCdOpe.cupfis - 3 = cupom fiscal/nao fiscal (regras de TEF e bloqueio de valor zero)
	this_nParAutosOpe = 0           && SigCdOpe.parautos - 4 = bloqueia exclusao de condicao InsChs (Apaga.Click); 5 = bloqueia o proprio botao Apaga (regra externa ao Click, nao portada nesta fase)

	*-- Nome do cursor que este BO popula/consome (constante, para o Form
	*-- referenciar sem repetir literal - equivalente ao alias global do
	*-- legado xPar)
	this_cCursorCondicoes = "cursor_4c_Condicoes"  && Grade de condicoes de pagamento do movimento (SigMvPar)

	*-- Propriedades da entidade (mapeamento 1-para-1 para a tabela
	*-- SigMvPar - uma CONDICAO/PARCELA de pagamento do movimento, chave
	*-- cidchaves). this_cEmps/this_cDopes/this_nNumes acima JA cobrem as
	*-- colunas emps/dopes/numes - nao duplicar.
	this_cAgencias     = ""   && agencias char(4) - agencia bancaria do cheque
	this_cBancos       = ""   && bancos char(3) - banco do cheque
	this_cCartaos      = ""   && cartaos char(20) - numero do cartao de credito
	this_cContas       = ""   && contas char(10) - conta bancaria do cheque
	this_nCotfpgs      = 0    && cotfpgs numeric(11,4) - cotacao da moeda de pagamento na data da condicao
	this_dDatas        = {}   && datas datetime - data da condicao (preenchimento conforme regra de negocio da operacao)
	this_dDatatrans    = {}   && datatrans datetime - data da transacao (TEF/cartao)
	this_cDcarts       = ""   && dcarts char(12) - data de validade do cartao (MM/AAAA ou similar, mascara do legado)
	this_nEcNumes      = 0    && ec_numes numeric(6,0) - numero do comprovante eletronico de cheque (DOC/TED)
	this_cFpags        = ""   && fpags char(12) - codigo da forma de pagamento (SigOpFp.Fpags)
	this_cGrclis       = ""   && grclis char(10) - grupo do cliente/conta na data da condicao
	this_cIclis        = ""   && iclis char(10) - codigo da conta (cliente/fornecedor) associada a condicao
	this_cImpcars      = ""   && impcars char(1) - indicador de impressao do carne/boleto
	this_lInschs       = .F.  && inschs bit - condicao inserida via leitor de cheque (insercao automatica)
	this_cLocals       = ""   && locals char(10) - local/filial de recebimento
	this_cMoefpgs      = ""   && moefpgs char(3) - moeda da forma de pagamento
	this_cNcarnes      = ""   && ncarnes char(11) - numero do carne de pagamento
	this_nNcarts       = 0    && ncarts numeric(10,0) - numero sequencial de protocolo do cartao de credito
	this_nNcopias      = 0    && ncopias numeric(6,0) - numero de copias impressas do comprovante
	this_cNocreditos   = ""   && nocreditos char(10) - numero/codigo de aprovacao do credito (cartao/cheque pre-datado)
	this_nNopers       = 0    && nopers numeric(7,0) - numero da operacao de TEF/cartao
	this_nNrecs        = 0    && nrecs numeric(11,0) - numero do recibo gerado para a condicao
	this_nNtrans       = 0    && ntrans numeric(6,0) - numero da transacao (TEF)
	this_cNumchqs      = ""   && numchqs char(8) - numero do cheque
	this_cNumeros      = ""   && numeros char(6) - numero da conta bancaria do cheque (complemento de contas)
	this_nNumolds      = 0    && numolds numeric(6,0) - numero antigo/sequencia de regravacao da condicao (controle de aprovacao)
	this_cOutros       = ""   && outros char(20) - campo livre complementar da condicao
	this_nValos        = 0    && valos numeric(11,2) - valor da parcela/condicao de pagamento
	this_dVencs        = {}   && vencs datetime - data de vencimento da parcela
	this_nVpags        = 0    && vpags numeric(11,2) - valor efetivamente pago/recebido da parcela
	this_cCotusus      = ""   && cotusus char(30) - usuario que autorizou a cotacao manual
	this_cObs          = ""   && obs text - observacao da condicao de pagamento
	this_nParcs        = 0    && parcs numeric(2,0) - numero da parcela (sequencial dentro do total de parcelas)
	this_cCnidtefs     = ""   && cnidtefs char(10) - identificador da transacao TEF
	this_cCnnsuparcs   = ""   && cnnsuparcs char(12) - NSU da parcela (TEF/cartao)
	this_nNumlotechs   = 0    && numlotechs numeric(8,0) - numero do lote de cheques
	this_nNidcheps     = 0    && nidcheps numeric(10,0) - identificador do cheque pre-datado associado
	this_cEmpos        = ""   && empos char(3) - empresa de origem (quando a condicao se refere a outra empresa do grupo)
	this_cCidchaves    = ""   && cidchaves char(20) - PK (fUniqueIds())
	this_nValocurs     = 0    && valocurs numeric(11,2) - valor da condicao convertido na moeda corrente
	this_nTrocos       = 0    && trocos numeric(1,0) - 1 = condicao representa troco/complemento devolvido ao cliente
	this_cEmpdopnums   = ""   && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6), chave posicional que liga a condicao ao cabecalho (regra #42)
	this_cPagos        = ""   && pagos char(1) - indicador S/N de condicao ja liquidada
	this_dDtalts       = {}   && dtalts datetime - data da ultima alteracao da condicao
	this_cCpfs         = ""   && cpfs char(20) - CPF/CNPJ do titular do cartao/cheque, quando divergente da conta
	this_cDigagencs    = ""   && digagencs char(1) - digito verificador da agencia bancaria
	this_cDigchqs      = ""   && digchqs char(1) - digito verificador do cheque
	this_cDigcontas    = ""   && digcontas char(1) - digito verificador da conta bancaria
	this_cPracas       = ""   && pracas char(3) - praca bancaria do cheque
	this_nTparcs       = 0    && tparcs numeric(2,0) - total de parcelas da condicao (denominador de Parcs)
	this_nValdescs     = 0    && valdescs numeric(11,2) - valor de desconto aplicado a esta condicao
	this_cCodbcrts     = ""   && codbcrts char(5) - codigo da bandeira do cartao (SigCdCrt)
	this_lLcancelas    = .F.  && lcancelas bit - condicao cancelada (exclusao logica)
	this_nVcofins      = 0    && vcofins numeric(14,2) - valor de COFINS retido na condicao
	this_nVcsll        = 0    && vcsll numeric(14,2) - valor de CSLL retido na condicao
	this_nVirf         = 0    && virf numeric(14,2) - valor de IRF retido na condicao
	this_nVlrtrbfs     = 0    && vlrtrbfs numeric(14,2) - valor de tributo federal retido na condicao
	this_nVpis         = 0    && vpis numeric(14,2) - valor de PIS retido na condicao
	this_cAdquirente   = ""   && adquirente char(8) - codigo da adquirente do cartao (SigCdCad, tipocads = 'ADQUIRENTE')
	this_cAutoriza     = ""   && autoriza char(6) - codigo de autorizacao da transacao de cartao
	this_cNsu          = ""   && nsu char(50) - NSU (Numero Sequencial Unico) da transacao de cartao/TEF
	this_cChaveexterna = ""   && chaveexterna char(33) - chave de integracao externa (TEF/adquirente)

	*====================================================================
	* Init - Inicializa Business Object
	* Parametros equivalentes ao Lparameters pForm, datses, plAltDireta,
	* plAutomatico do Init do form legado - o form migrado repassa os
	* valores escalares que identificam o cabecalho do movimento
	* (par_cEmps/par_cDopes/par_nNumes, lidos pelo form a partir do
	* chamador) alem das duas flags de comportamento (poForm/datses, que
	* sao referencia de UI e troca de DataSession, ficam no Form).
	*====================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_lAltDireta, par_lAutomatico)
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvPar"
		THIS.this_cCampoChave = "cidchaves"

		IF VARTYPE(par_cEmps) = "C"
			THIS.this_cEmps = par_cEmps
		ENDIF

		IF VARTYPE(par_cDopes) = "C"
			THIS.this_cDopes = par_cDopes
		ENDIF

		IF VARTYPE(par_nNumes) = "N"
			THIS.this_nNumes = par_nNumes
		ENDIF

		IF VARTYPE(par_lAltDireta) = "L"
			THIS.this_lAltDireta = par_lAltDireta
		ENDIF

		IF VARTYPE(par_lAutomatico) = "L"
			THIS.this_lAutomatico = par_lAutomatico
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia uma linha de SigMvPar (cursor populado por
	* SQLEXEC, ex.: this_cCursorCondicoes) para as properties desta
	* condicao/parcela. NAO eh PROTECTED (regra #51 - BusinessBase declara
	* publico e o Form chama direto ao posicionar a linha da grade).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cEmps         = TratarNulo(emps, "")
			THIS.this_cDopes        = TratarNulo(dopes, "")
			THIS.this_nNumes        = TratarNulo(numes, 0)
			THIS.this_cAgencias     = TratarNulo(agencias, "")
			THIS.this_cBancos       = TratarNulo(bancos, "")
			THIS.this_cCartaos      = TratarNulo(cartaos, "")
			THIS.this_cContas       = TratarNulo(contas, "")
			THIS.this_nCotfpgs      = TratarNulo(cotfpgs, 0)
			THIS.this_dDatas        = TratarNulo(datas, {})
			THIS.this_dDatatrans    = TratarNulo(datatrans, {})
			THIS.this_cDcarts       = TratarNulo(dcarts, "")
			THIS.this_nEcNumes      = TratarNulo(ec_numes, 0)
			THIS.this_cFpags        = TratarNulo(fpags, "")
			THIS.this_cGrclis       = TratarNulo(grclis, "")
			THIS.this_cIclis        = TratarNulo(iclis, "")
			THIS.this_cImpcars      = TratarNulo(impcars, "")
			THIS.this_lInschs       = ConverterParaLogico(inschs)
			THIS.this_cLocals       = TratarNulo(locals, "")
			THIS.this_cMoefpgs      = TratarNulo(moefpgs, "")
			THIS.this_cNcarnes      = TratarNulo(ncarnes, "")
			THIS.this_nNcarts       = TratarNulo(ncarts, 0)
			THIS.this_nNcopias      = TratarNulo(ncopias, 0)
			THIS.this_cNocreditos   = TratarNulo(nocreditos, "")
			THIS.this_nNopers       = TratarNulo(nopers, 0)
			THIS.this_nNrecs        = TratarNulo(nrecs, 0)
			THIS.this_nNtrans       = TratarNulo(ntrans, 0)
			THIS.this_cNumchqs      = TratarNulo(numchqs, "")
			THIS.this_cNumeros      = TratarNulo(numeros, "")
			THIS.this_nNumolds      = TratarNulo(numolds, 0)
			THIS.this_cOutros       = TratarNulo(outros, "")
			THIS.this_nValos        = TratarNulo(valos, 0)
			THIS.this_dVencs        = TratarNulo(vencs, {})
			THIS.this_nVpags        = TratarNulo(vpags, 0)
			THIS.this_cCotusus      = TratarNulo(cotusus, "")
			THIS.this_cObs          = TratarNulo(obs, "")
			THIS.this_nParcs        = TratarNulo(parcs, 0)
			THIS.this_cCnidtefs     = TratarNulo(cnidtefs, "")
			THIS.this_cCnnsuparcs   = TratarNulo(cnnsuparcs, "")
			THIS.this_nNumlotechs   = TratarNulo(numlotechs, 0)
			THIS.this_nNidcheps     = TratarNulo(nidcheps, 0)
			THIS.this_cEmpos        = TratarNulo(empos, "")
			THIS.this_cCidchaves    = TratarNulo(cidchaves, "")
			THIS.this_nValocurs     = TratarNulo(valocurs, 0)
			THIS.this_nTrocos       = TratarNulo(trocos, 0)
			THIS.this_cEmpdopnums   = TratarNulo(empdopnums, "")
			THIS.this_cPagos        = TratarNulo(pagos, "")
			THIS.this_dDtalts       = TratarNulo(dtalts, {})
			THIS.this_cCpfs         = TratarNulo(cpfs, "")
			THIS.this_cDigagencs    = TratarNulo(digagencs, "")
			THIS.this_cDigchqs      = TratarNulo(digchqs, "")
			THIS.this_cDigcontas    = TratarNulo(digcontas, "")
			THIS.this_cPracas       = TratarNulo(pracas, "")
			THIS.this_nTparcs       = TratarNulo(tparcs, 0)
			THIS.this_nValdescs     = TratarNulo(valdescs, 0)
			THIS.this_cCodbcrts     = TratarNulo(codbcrts, "")
			THIS.this_lLcancelas    = ConverterParaLogico(lcancelas)
			THIS.this_nVcofins      = TratarNulo(vcofins, 0)
			THIS.this_nVcsll        = TratarNulo(vcsll, 0)
			THIS.this_nVirf         = TratarNulo(virf, 0)
			THIS.this_nVlrtrbfs     = TratarNulo(vlrtrbfs, 0)
			THIS.this_nVpis         = TratarNulo(vpis, 0)
			THIS.this_cAdquirente   = TratarNulo(adquirente, "")
			THIS.this_cAutoriza     = TratarNulo(autoriza, "")
			THIS.this_cNsu          = TratarNulo(nsu, "")
			THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
	* nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidchaves
	ENDPROC

	*====================================================================
	* Inserir - INSERT completo em SigMvPar (condicao/parcela do
	* movimento). cidchaves (PK) e gerada aqui se ainda vazia (regra #22
	* - fUniqueIds(), NUNCA string vazia). empdopnums e a chave posicional
	* Emps(3)+Dopes(20)+Str(Numes,6) (regra #42 - PADR explicito, NUNCA
	* ALLTRIM nas partes). dpags/dtdeps (datetime NULL, sem uso no
	* codigo legado analisado) ficam fora da lista - SQL Server grava
	* NULL por omissao, o que e permitido pelo schema.
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.

		IF EMPTY(THIS.this_cCidchaves)
			THIS.this_cCidchaves = fUniqueIds()
		ENDIF

		THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + ;
			PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigMvPar (
					emps, dopes, numes, agencias, bancos, cartaos, contas, cotfpgs,
					datas, datatrans, dcarts, ec_numes, fpags, grclis, iclis, impcars,
					inschs, locals, moefpgs, ncarnes, ncarts, ncopias, nocreditos,
					nopers, nrecs, ntrans, numchqs, numeros, numolds, outros, valos,
					vencs, vpags, cotusus, obs, parcs, cnidtefs, cnnsuparcs,
					numlotechs, nidcheps, empos, cidchaves, valocurs, trocos,
					empdopnums, pagos, dtalts, cpfs, digagencs, digchqs, digcontas,
					pracas, tparcs, valdescs, codbcrts, lcancelas, vcofins, vcsll,
					virf, vlrtrbfs, vpis, adquirente, autoriza, nsu, chaveexterna
				)
				VALUES (
					<<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cAgencias, 4))>>,
					<<EscaparSQL(LEFT(THIS.this_cBancos, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cCartaos, 20))>>,
					<<EscaparSQL(LEFT(THIS.this_cContas, 10))>>,
					<<FormatarNumeroSQL(THIS.this_nCotfpgs, 4)>>,
					<<FormatarDataSQL(THIS.this_dDatas)>>,
					<<FormatarDataSQL(THIS.this_dDatatrans)>>,
					<<EscaparSQL(LEFT(THIS.this_cDcarts, 12))>>,
					<<FormatarNumeroSQL(THIS.this_nEcNumes, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cFpags, 12))>>,
					<<EscaparSQL(LEFT(THIS.this_cGrclis, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cImpcars, 1))>>,
					<<IIF(THIS.this_lInschs, "1", "0")>>,
					<<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cMoefpgs, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cNcarnes, 11))>>,
					<<FormatarNumeroSQL(THIS.this_nNcarts, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNcopias, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cNocreditos, 10))>>,
					<<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNrecs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cNumchqs, 8))>>,
					<<EscaparSQL(LEFT(THIS.this_cNumeros, 6))>>,
					<<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cOutros, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nValos, 2)>>,
					<<FormatarDataSQL(THIS.this_dVencs)>>,
					<<FormatarNumeroSQL(THIS.this_nVpags, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cCotusus, 30))>>,
					<<EscaparSQL(THIS.this_cObs)>>,
					<<FormatarNumeroSQL(THIS.this_nParcs, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cCnidtefs, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cCnnsuparcs, 12))>>,
					<<FormatarNumeroSQL(THIS.this_nNumlotechs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNidcheps, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nValocurs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nTrocos, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					<<EscaparSQL(LEFT(THIS.this_cPagos, 1))>>,
					<<FormatarDataSQL(THIS.this_dDtalts)>>,
					<<EscaparSQL(LEFT(THIS.this_cCpfs, 20))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigagencs, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigchqs, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigcontas, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cPracas, 3))>>,
					<<FormatarNumeroSQL(THIS.this_nTparcs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cCodbcrts, 5))>>,
					<<IIF(THIS.this_lLcancelas, "1", "0")>>,
					<<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVcsll, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVirf, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVlrtrbfs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cAdquirente, 8))>>,
					<<EscaparSQL(LEFT(THIS.this_cAutoriza, 6))>>,
					<<EscaparSQL(LEFT(THIS.this_cNsu, 50))>>,
					<<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERIR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE completo em SigMvPar pela PK cidchaves. emps/
	* dopes/numes/cidchaves identificam o registro e NAO entram no SET.
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.

		THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + ;
			PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigMvPar SET
					agencias     = <<EscaparSQL(LEFT(THIS.this_cAgencias, 4))>>,
					bancos       = <<EscaparSQL(LEFT(THIS.this_cBancos, 3))>>,
					cartaos      = <<EscaparSQL(LEFT(THIS.this_cCartaos, 20))>>,
					contas       = <<EscaparSQL(LEFT(THIS.this_cContas, 10))>>,
					cotfpgs      = <<FormatarNumeroSQL(THIS.this_nCotfpgs, 4)>>,
					datas        = <<FormatarDataSQL(THIS.this_dDatas)>>,
					datatrans    = <<FormatarDataSQL(THIS.this_dDatatrans)>>,
					dcarts       = <<EscaparSQL(LEFT(THIS.this_cDcarts, 12))>>,
					ec_numes     = <<FormatarNumeroSQL(THIS.this_nEcNumes, 0)>>,
					fpags        = <<EscaparSQL(LEFT(THIS.this_cFpags, 12))>>,
					grclis       = <<EscaparSQL(LEFT(THIS.this_cGrclis, 10))>>,
					iclis        = <<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
					impcars      = <<EscaparSQL(LEFT(THIS.this_cImpcars, 1))>>,
					inschs       = <<IIF(THIS.this_lInschs, "1", "0")>>,
					locals       = <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
					moefpgs      = <<EscaparSQL(LEFT(THIS.this_cMoefpgs, 3))>>,
					ncarnes      = <<EscaparSQL(LEFT(THIS.this_cNcarnes, 11))>>,
					ncarts       = <<FormatarNumeroSQL(THIS.this_nNcarts, 0)>>,
					ncopias      = <<FormatarNumeroSQL(THIS.this_nNcopias, 0)>>,
					nocreditos   = <<EscaparSQL(LEFT(THIS.this_cNocreditos, 10))>>,
					nopers       = <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
					nrecs        = <<FormatarNumeroSQL(THIS.this_nNrecs, 0)>>,
					ntrans       = <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
					numchqs      = <<EscaparSQL(LEFT(THIS.this_cNumchqs, 8))>>,
					numeros      = <<EscaparSQL(LEFT(THIS.this_cNumeros, 6))>>,
					numolds      = <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
					outros       = <<EscaparSQL(LEFT(THIS.this_cOutros, 20))>>,
					valos        = <<FormatarNumeroSQL(THIS.this_nValos, 2)>>,
					vencs        = <<FormatarDataSQL(THIS.this_dVencs)>>,
					vpags        = <<FormatarNumeroSQL(THIS.this_nVpags, 2)>>,
					cotusus      = <<EscaparSQL(LEFT(THIS.this_cCotusus, 30))>>,
					obs          = <<EscaparSQL(THIS.this_cObs)>>,
					parcs        = <<FormatarNumeroSQL(THIS.this_nParcs, 0)>>,
					cnidtefs     = <<EscaparSQL(LEFT(THIS.this_cCnidtefs, 10))>>,
					cnnsuparcs   = <<EscaparSQL(LEFT(THIS.this_cCnnsuparcs, 12))>>,
					numlotechs   = <<FormatarNumeroSQL(THIS.this_nNumlotechs, 0)>>,
					nidcheps     = <<FormatarNumeroSQL(THIS.this_nNidcheps, 0)>>,
					empos        = <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
					valocurs     = <<FormatarNumeroSQL(THIS.this_nValocurs, 2)>>,
					trocos       = <<FormatarNumeroSQL(THIS.this_nTrocos, 0)>>,
					empdopnums   = <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					pagos        = <<EscaparSQL(LEFT(THIS.this_cPagos, 1))>>,
					dtalts       = <<FormatarDataSQL(THIS.this_dDtalts)>>,
					cpfs         = <<EscaparSQL(LEFT(THIS.this_cCpfs, 20))>>,
					digagencs    = <<EscaparSQL(LEFT(THIS.this_cDigagencs, 1))>>,
					digchqs      = <<EscaparSQL(LEFT(THIS.this_cDigchqs, 1))>>,
					digcontas    = <<EscaparSQL(LEFT(THIS.this_cDigcontas, 1))>>,
					pracas       = <<EscaparSQL(LEFT(THIS.this_cPracas, 3))>>,
					tparcs       = <<FormatarNumeroSQL(THIS.this_nTparcs, 0)>>,
					valdescs     = <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
					codbcrts     = <<EscaparSQL(LEFT(THIS.this_cCodbcrts, 5))>>,
					lcancelas    = <<IIF(THIS.this_lLcancelas, "1", "0")>>,
					vcofins      = <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
					vcsll        = <<FormatarNumeroSQL(THIS.this_nVcsll, 2)>>,
					virf         = <<FormatarNumeroSQL(THIS.this_nVirf, 2)>>,
					vlrtrbfs     = <<FormatarNumeroSQL(THIS.this_nVlrtrbfs, 2)>>,
					vpis         = <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
					adquirente   = <<EscaparSQL(LEFT(THIS.this_cAdquirente, 8))>>,
					autoriza     = <<EscaparSQL(LEFT(THIS.this_cAutoriza, 6))>>,
					nsu          = <<EscaparSQL(LEFT(THIS.this_cNsu, 50))>>,
					chaveexterna = <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>
				WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("ALTERAR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarConfiguracao - le o cabecalho do movimento (TprMvCab, cursor
	* que o FORM PAI legado ja deixa aberto na DataSession compartilhada -
	* regra #35/cabecalho do topo deste arquivo) e a configuracao da
	* operacao (SigCdOpe, via SQLEXEC por Dopes). Chamado pelo Form logo
	* apos instanciar o BO, ANTES de CarregarCondicoes()/CarregarLista().
	*
	* TprMvCab e um cursor MONTADO pelo form pai (nao necessariamente
	* 1-para-1 com as colunas de SigMvCab) - por isso cada leitura e
	* guardada por TYPE() != "U": campo ausente la NAO e erro aqui, so
	* mantem o default ja declarado na propriedade.
	*====================================================================
	PROCEDURE CarregarConfiguracao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			IF USED("TprMvCab")
				SELECT TprMvCab
				IF RECCOUNT() > 0 AND !EOF()
					IF TYPE("TprMvCab.contaos") != "U"
						THIS.this_cContaOsCab = TratarNulo(contaos, "")
					ENDIF
					IF TYPE("TprMvCab.contads") != "U"
						THIS.this_cContaDsCab = TratarNulo(contads, "")
					ENDIF
					IF TYPE("TprMvCab.datas") != "U"
						THIS.this_dDatasCab = TratarNulo(datas, {})
					ENDIF
					IF TYPE("TprMvCab.notas") != "U"
						THIS.this_cNotasCab = TratarNulo(notas, "")
					ENDIF
					IF TYPE("TprMvCab.prazoents") != "U"
						THIS.this_dPrazoEntsCab = TratarNulo(prazoents, {})
					ENDIF
					IF TYPE("TprMvCab.tabds") != "U"
						THIS.this_cTabDsCab = TratarNulo(tabds, "")
					ENDIF
					IF TYPE("TprMvCab.tpfats") != "U"
						THIS.this_cTpFatsCab = TratarNulo(tpfats, "")
					ENDIF
					IF TYPE("TprMvCab.valdevs") != "U"
						THIS.this_nValDevsCab = TratarNulo(valdevs, 0)
					ENDIF
					IF TYPE("TprMvCab.valencs") != "U"
						THIS.this_nValEncsCab = TratarNulo(valencs, 0)
					ENDIF
					IF TYPE("TprMvCab.valinis") != "U"
						THIS.this_nValInisCab = TratarNulo(valinis, 0)
					ENDIF
					IF TYPE("TprMvCab.valservs") != "U"
						THIS.this_nValServsCab = TratarNulo(valservs, 0)
					ENDIF
					IF TYPE("TprMvCab.valtrans") != "U"
						THIS.this_nValTransCab = TratarNulo(valtrans, 0)
					ENDIF
					IF TYPE("TprMvCab.valuticsh") != "U"
						THIS.this_nValUtiCshCab = TratarNulo(valuticsh, 0)
					ENDIF
					IF TYPE("TprMvCab.valvarps") != "U"
						THIS.this_nValVarPsCab = TratarNulo(valvarps, 0)
					ENDIF
					IF TYPE("TprMvCab.valvars") != "U"
						THIS.this_nValVarsCab = TratarNulo(valvars, 0)
					ENDIF
					IF TYPE("TprMvCab.valos") != "U"
						THIS.this_nValosCab = TratarNulo(valos, 0)
					ENDIF
					IF TYPE("TprMvCab.vartots") != "U"
						THIS.this_nVarTotsCab = TratarNulo(vartots, 0)
					ENDIF
					IF TYPE("TprMvCab.vars") != "U"
						THIS.this_nVarsCab = TratarNulo(vars, 0)
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_SigCdOpeTmp")
				USE IN cursor_4c_SigCdOpeTmp
			ENDIF

			IF !EMPTY(THIS.this_cDopes)
				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT blqdatas, cmoes, copers, caixas, confes, deacrs, dtentrs,
						   edcomis, fpagopcrs, habservs, lprecos, opers, parrecals,
						   parcs, pesovts, precoauts, precovts, valpres, vars,
						   aptpfats, cheqs, cupfis, parautos
					FROM SigCdOpe
					WHERE dopes = <<EscaparSQL(THIS.this_cDopes)>>
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeTmp")

				IF loc_nResultado >= 0 AND USED("cursor_4c_SigCdOpeTmp") AND !EOF("cursor_4c_SigCdOpeTmp")
					SELECT cursor_4c_SigCdOpeTmp
					THIS.this_nBlqDatasOpe  = TratarNulo(blqdatas, 0)
					THIS.this_cCMoesOpe     = TratarNulo(cmoes, "")
					THIS.this_nCopersOpe    = TratarNulo(copers, 0)
					THIS.this_nCaixasOpe    = TratarNulo(caixas, 0)
					THIS.this_nConfesOpe    = TratarNulo(confes, 0)
					THIS.this_nDeacrsOpe    = TratarNulo(deacrs, 0)
					THIS.this_nDtEntrsOpe   = TratarNulo(dtentrs, 0)
					THIS.this_nEdComisOpe   = TratarNulo(edcomis, 0)
					THIS.this_cFPagOpCrsOpe = TratarNulo(fpagopcrs, "")
					THIS.this_nHabServsOpe  = TratarNulo(habservs, 0)
					THIS.this_nLPrecosOpe   = TratarNulo(lprecos, 0)
					THIS.this_nOpersOpe     = TratarNulo(opers, 0)
					THIS.this_nParRecalsOpe = TratarNulo(parrecals, 0)
					THIS.this_nParcsOpe     = TratarNulo(parcs, 0)
					THIS.this_nPesoVtsOpe   = TratarNulo(pesovts, 0)
					THIS.this_nPrecoAutsOpe = TratarNulo(precoauts, 0)
					THIS.this_nPrecoVtsOpe  = TratarNulo(precovts, 0)
					THIS.this_nValPresOpe   = TratarNulo(valpres, 0)
					THIS.this_nVarsOpe      = TratarNulo(vars, 0)
					THIS.this_nAptpfatsOpe  = TratarNulo(aptpfats, 0)
					THIS.this_nCheqsOpe     = TratarNulo(cheqs, 0)
					THIS.this_nCupfisOpe    = TratarNulo(cupfis, 0)
					THIS.this_nParAutosOpe  = TratarNulo(parautos, 0)
				ENDIF

				IF USED("cursor_4c_SigCdOpeTmp")
					USE IN cursor_4c_SigCdOpeTmp
				ENDIF
			ENDIF

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o do movimento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.CarregarConfiguracao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarCondicoes - porta PARCIAL do carregamento de condicoes de
	* SigMvPar para a grade. No legado isso e feito pelo FORM PAI, via
	* AddCursor no seu proprio Init, deixando xPar ja aberto e
	* compartilhado com este form filho (regra #35/cabecalho). Quando este
	* form roda ISOLADO (sem pai - modo de teste/validacao de UI), xPar
	* nao existe: este metodo busca SigMvPar por Emps+Dopes+Numes via
	* SQLEXEC e substitui o CONTEUDO do cursor_4c_Condicoes (ja criado e
	* ligado ao Grid por Formsigoppag::ConfigurarGrid) SEM refazer a
	* estrutura - SQLEXEC direto no alias do grid zeraria o ColumnCount.
	*====================================================================
	PROCEDURE CarregarCondicoes()
		LOCAL loc_cSQL, loc_nResultado, loc_cCursorTmp, loc_lSucesso, loc_oErro

		loc_lSucesso   = .F.
		loc_cCursorTmp = "cursor_4c_CondicoesTmp"

		IF !USED(THIS.this_cCursorCondicoes)
			RETURN loc_lSucesso
		ENDIF

		TRY
			IF USED(loc_cCursorTmp)
				USE IN (loc_cCursorTmp)
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT cidchaves, emps, dopes, numes, fpags, valos, vencs,
					   moefpgs, cotfpgs, valdescs, inschs, numchqs, nidcheps, trocos
				FROM SigMvPar
				WHERE emps = <<EscaparSQL(THIS.this_cEmps)>>
				  AND dopes = <<EscaparSQL(THIS.this_cDopes)>>
				  AND numes = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>
				ORDER BY vencs
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

			IF loc_nResultado >= 0 AND USED(loc_cCursorTmp)
				SELECT (THIS.this_cCursorCondicoes)
				ZAP
				APPEND FROM (DBF(loc_cCursorTmp))

				USE IN (loc_cCursorTmp)

				SELECT (THIS.this_cCursorCondicoes)
				GO TOP

				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.CarregarCondicoes")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExcluirCondicao - DELETE direto em SigMvPar pela PK cidchaves, usado
	* pelo Apaga.Click do form (regra #22 - cidchaves e a PK Fortyus).
	* Linha que nunca foi persistida (cidchaves ainda vazio) nao precisa de
	* DELETE remoto - retorna sucesso sem tocar no banco.
	*====================================================================
	PROCEDURE ExcluirCondicao(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		IF EMPTY(par_cCidchaves)
			RETURN .T.
		ENDIF

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				DELETE FROM SigMvPar WHERE cidchaves = <<EscaparSQL(LEFT(par_cCidchaves, 20))>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.ExcluirCondicao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

