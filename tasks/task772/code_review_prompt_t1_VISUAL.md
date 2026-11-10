# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 653: FontName 'Comic Sans MS' e o dump do legado NAO declara essa fonte em lugar nenhum - trocar por 'Tahoma' NESTA linha (conferir o controle no dump antes).
- [FONTNAME-ERRADO] Linha 677: FontName 'Comic Sans MS' e o dump do legado NAO declara essa fonte em lugar nenhum - trocar por 'Tahoma' NESTA linha (conferir o controle no dump antes).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2160 linhas total):

*-- Linhas 39 a 54:
39: *     FormSIGMVMVT: instanciado via OLEControl com o mesmo ProgID do
40: *     legado, guardado em TRY/CATCH e pulado em modo teste/validacao de
41: *     UI - ver feedback_mscomctl_treectrl_trava_em_modal_de_licenca), mais
42: *     lbl_4c_Label3 ("O.P. :"), lbl_4c_Label1 ("Envelope :"), txt_4c_OP
43: *     (GetOP) e txt_4c_Envelope (GetEnvelope).
44: *   cnt_4c_Container2 -> lbl_4c_Label1 ("AGUARDE!") e lbl_4c_Label2
45: *     ("Pesquisando as Movimentacoes") - conteudo do painel flutuante.
46: *   Form (sem container, fiel ao SCX) -> cmg_4c_Commandgroup1 (unico
47: *     botao "Encerrar" - nome canonico cmg_4c_, NAO o obj_4c_ do
48: *     mapeamento.json gerado: ver feedback_commandgroup_obj_4c_reprova_
49: *     gate_fase4), cmd_4c_Fwbtng1 ("Expandir"), cmd_4c_Fwbtng2
50: *     ("Regredir") e img_4c_Imagem (imagem do produto).
51: *
52: * Mais o METODO DE CARGA desta tela, que aqui NAO alimenta uma grade e sim
53: * a ARVORE (o SCX nao tem Grid nem PageFrame - a superficie de lista eh o
54: * TreeView ActiveX, dirigido pela API de nos AddPictureNode/NodeExpanded/

*-- Linhas 282 a 290:
282: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
283: 			MsgErro("Falha ao criar SIGOPNOPBO", "Erro")
284: 		ELSE
285: 			THIS.Caption = "An" + CHR(225) + "lise de OP/Envelopes"
286: 
287: 			*-- Picture = ..\framework\imagens\new_background.jpg no legado -
288: 			*-- caminho resolvido via gc_4c_CaminhoFramework (regra CLAUDE.md
289: 			*-- #27/Pattern #170 - NUNCA montar esse caminho a partir de gc_4c_CaminhoBase).
290: 			IF FILE(gc_4c_CaminhoFramework + "imagens\new_background.jpg")

*-- Linhas 375 a 384:
375: 		THIS.AddObject("cnt_4c_Container1", "Container")
376: 		loc_oCnt = THIS.cnt_4c_Container1
377: 		WITH loc_oCnt
378: 			.Top           = 136
379: 			.Left          = 23
380: 			.Height        = 456
381: 			.Width         = 744
382: 			.BackStyle     = 0
383: 			.BorderWidth   = 0
384: 			.TabIndex      = 1

*-- Linhas 394 a 403:
394: 		THIS.AddObject("cnt_4c_Container2", "Container")
395: 		loc_oCnt = THIS.cnt_4c_Container2
396: 		WITH loc_oCnt
397: 			.Top           = 267
398: 			.Left          = 221
399: 			.Height        = 65
400: 			.Width         = 358
401: 			.SpecialEffect = 0
402: 			.TabIndex      = 3
403: 			.BackColor     = RGB(255, 255, 255)

*-- Linhas 460 a 507:
460: 			TRY
461: 				THIS.cnt_4c_Container1.AddObject("obj_4c_TreeView", "OLEControl", "cttree.cttreeview")
462: 				WITH THIS.cnt_4c_Container1.obj_4c_TreeView
463: 					.Top     = 28
464: 					.Left    = 9
465: 					.Height  = 421
466: 					.Width   = 725
467: 					.Visible = .T.
468: 				ENDWITH
469: 			CATCH TO loc_oErrOle
470: 				MsgErro("Controle de " + CHR(225) + "rvore (ctTree.ocx) indispon" + ;
471: 						CHR(237) + "vel nesta esta" + CHR(231) + CHR(227) + "o: " + ;
472: 						loc_oErrOle.Message, "Aviso")
473: 			ENDTRY
474: 		ENDIF
475: 
476: 		*-- lbl_4c_Label3 ("O.P. :") - AutoSize = .F. + Width/Height do dump
477: 		*-- (35x15). Ver nota de AutoSize em ConfigurarControles.
478: 		THIS.cnt_4c_Container1.AddObject("lbl_4c_Label3", "Label")
479: 		WITH THIS.cnt_4c_Container1.lbl_4c_Label3
480: 			.AutoSize  = .F.
481: 			.FontName  = "Verdana"
482: 			.FontSize  = 8
483: 			.BackStyle = 0
484: 			.Caption   = "O.P. :"
485: 			.Top       = 6
486: 			.Left      = 12
487: 			.Width     = 35
488: 			.Height    = 15
489: 			.ForeColor = RGB(36, 84, 155)
490: 			.Visible   = .T.
491: 		ENDWITH
492: 
493: 		*-- lbl_4c_Label1 ("Envelope :") - dump 63x15.
494: 		THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
495: 		WITH THIS.cnt_4c_Container1.lbl_4c_Label1
496: 			.AutoSize  = .F.
497: 			.FontName  = "Verdana"
498: 			.FontSize  = 8
499: 			.BackStyle = 0
500: 			.Caption   = "Envelope :"
501: 			.Top       = 7
502: 			.Left      = 146
503: 			.Width     = 63
504: 			.Height    = 15
505: 			.ForeColor = RGB(36, 84, 155)
506: 			.Visible   = .T.
507: 		ENDWITH

*-- Linhas 516 a 527:
516: 			.Format            = "R"
517: 			.Height            = 23
518: 			.InputMask         = "9999999999"
519: 			.Left              = 49
520: 			.MaxLength         = 10
521: 			.SpecialEffect     = 1
522: 			.Top               = 2
523: 			.Width             = 86
524: 			.DisabledBackColor = RGB(255, 255, 255)
525: 			.DisabledForeColor = RGB(0, 0, 128)
526: 			.BorderColor       = RGB(36, 84, 155)
527: 			.Visible           = .T.

*-- Linhas 536 a 591:
536: 			.Format            = "R"
537: 			.Height            = 23
538: 			.InputMask         = "9999999999"
539: 			.Left              = 210
540: 			.MaxLength         = 10
541: 			.SpecialEffect     = 1
542: 			.Top               = 3
543: 			.Width             = 86
544: 			.DisabledBackColor = RGB(255, 255, 255)
545: 			.DisabledForeColor = RGB(0, 0, 128)
546: 			.BorderColor       = RGB(36, 84, 155)
547: 			.Visible           = .T.
548: 		ENDWITH
549: 
550: 		*-- ===== Conteudo de cnt_4c_Container2 (painel "AGUARDE!" -
551: 		*-- flutuante, nasce invisivel - ver ConfigurarContainers/Fase 3) =====
552: 
553: 		*-- lbl_4c_Label1 ("AGUARDE!") - dump 114x25. Com AutoSize = .T. e sem
554: 		*-- Width a caixa ficaria nos 100 do default e o texto (Verdana 14
555: 		*-- bold, Alignment = 2) sairia CORTADO.
556: 		THIS.cnt_4c_Container2.AddObject("lbl_4c_Label1", "Label")
557: 		WITH THIS.cnt_4c_Container2.lbl_4c_Label1
558: 			.AutoSize  = .F.
559: 			.FontBold  = .T.
560: 			.FontName  = "Verdana"
561: 			.FontSize  = 14
562: 			.Alignment = 2
563: 			.BackStyle = 0
564: 			.Caption   = "AGUARDE!"
565: 			.Top       = 2
566: 			.Left      = 122
567: 			.Width     = 114
568: 			.Height    = 25
569: 			.ForeColor = RGB(240, 0, 0)
570: 			.Visible   = .T.
571: 		ENDWITH
572: 
573: 		*-- lbl_4c_Label2 ("Pesquisando as Movimentacoes") - dump 279x20. Eh o
574: 		*-- caso mais grave do AutoSize: 279 contra os 100 do default, ou seja
575: 		*-- a frase apareceria pela METADE no painel de aguarde.
576: 		THIS.cnt_4c_Container2.AddObject("lbl_4c_Label2", "Label")
577: 		WITH THIS.cnt_4c_Container2.lbl_4c_Label2
578: 			.AutoSize  = .F.
579: 			.FontBold  = .T.
580: 			.FontName  = "Verdana"
581: 			.FontSize  = 12
582: 			.Alignment = 2
583: 			.BackStyle = 0
584: 			.Caption   = "Pesquisando as Movimenta" + CHR(231) + CHR(245) + "es"
585: 			.Top       = 31
586: 			.Left      = 39
587: 			.Width     = 279
588: 			.Height    = 20
589: 			.ForeColor = RGB(36, 84, 155)
590: 			.Visible   = .T.
591: 		ENDWITH

*-- Linhas 600 a 683:
600: 		THIS.AddObject("cmg_4c_Commandgroup1", "CommandGroup")
601: 		WITH THIS.cmg_4c_Commandgroup1
602: 			.ButtonCount   = 1
603: 			.Top           = 7
604: 			.Left          = 691
605: 			.Height        = 110
606: 			.Width         = 90
607: 			.BackStyle     = 0
608: 			.SpecialEffect = 1
609: 			.BorderColor   = RGB(136, 189, 188)
610: 			.Themes        = .F.
611: 
612: 			WITH .Buttons(1)
613: 				.Top       = 5
614: 				.Left      = 5
615: 				.Height    = 100
616: 				.Width     = 80
617: 				.FontName  = "Verdana"
618: 				.FontSize  = 8
619: 				.WordWrap  = .T.
620: 				.Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
621: 				.Cancel    = .T.
622: 				.Caption   = "Encerrar"
623: 				.ForeColor = RGB(36, 84, 155)
624: 				.BackColor = RGB(255, 255, 255)
625: 				.Themes    = .F.
626: 			ENDWITH
627: 
628: 			.Value   = 0
629: 			.Visible = .T.
630: 		ENDWITH
631: 
632: 		*-- cmd_4c_Fwbtng1 ("Expandir" - seta para baixo). O SCX declara so
633: 		*-- Top/Left/Picture/Caption/ToolTipText: todo o resto vem da classe
634: 		*-- "fwbtng" do framework.vcx, lida em docs\FRAMEWORK_class_codigo_fonte.txt
635: 		*-- (NUNCA chutar propriedade herdada - regra CLAUDE.md #30/#31):
636: 		*--   Height=100  Width=80  FontBold=.T.  FontItalic=.T.
637: 		*--   FontName="Comic Sans MS"  FontSize=8  WordWrap=.T.
638: 		*--   MousePointer=15  ForeColor=90,90,90  BackColor=255,255,255
639: 		*-- Unico desvio deliberado: Themes = .T. (a classe tem .F.).
640: 		*-- CommandButton STANDALONE com .Picture exige Themes=.T. +
641: 		*-- DisabledPicture, senao o icone nao renderiza (Pattern #99) - e
642: 		*-- como o Caption eh "", sem icone o botao fica um retangulo vazio.
643: 		THIS.AddObject("cmd_4c_Fwbtng1", "CommandButton")
644: 		WITH THIS.cmd_4c_Fwbtng1
645: 			.Top             = 12
646: 			.Left            = 12
647: 			.Height          = 100
648: 			.Width           = 80
649: 			.Picture         = gc_4c_CaminhoIcones + "geral_seta_bai_60.jpg"
650: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_bai_60.jpg"
651: 			.Caption         = ""
652: 			.ToolTipText     = "Expandir"
653: 			.FontName        = "Comic Sans MS"
654: 			.FontSize        = 8
655: 			.FontBold        = .T.
656: 			.FontItalic      = .T.
657: 			.WordWrap        = .T.
658: 			.MousePointer    = 15
659: 			.ForeColor       = RGB(90, 90, 90)
660: 			.BackColor       = RGB(255, 255, 255)
661: 			.Themes          = .T.
662: 			.Visible         = .T.
663: 		ENDWITH
664: 
665: 		*-- cmd_4c_Fwbtng2 ("Regredir" - seta para cima). Mesma heranca da
666: 		*-- classe fwbtng e mesma observacao de Themes do Fwbtng1 acima.
667: 		THIS.AddObject("cmd_4c_Fwbtng2", "CommandButton")
668: 		WITH THIS.cmd_4c_Fwbtng2
669: 			.Top             = 12
670: 			.Left            = 96
671: 			.Height          = 100
672: 			.Width           = 80
673: 			.Picture         = gc_4c_CaminhoIcones + "geral_seta_cim_60.jpg"
674: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_cim_60.jpg"
675: 			.Caption         = ""
676: 			.ToolTipText     = "Regredir"
677: 			.FontName        = "Comic Sans MS"
678: 			.FontSize        = 8
679: 			.FontBold        = .T.
680: 			.FontItalic      = .T.
681: 			.WordWrap        = .T.
682: 			.MousePointer    = 15
683: 			.ForeColor       = RGB(90, 90, 90)

*-- Linhas 694 a 703:
694: 			.Stretch     = 1
695: 			.Enabled     = .T.
696: 			.Height      = 109
697: 			.Left        = 474
698: 			.Top         = 11
699: 			.Width       = 192
700: 			.ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
701: 			.Visible     = .F.
702: 		ENDWITH
703: 	ENDPROC

*-- Linhas 849 a 858:
849: 
850: 		*-- Fwbtng1/Fwbtng2: navegacao de nivel da arvore (Expandir/Regredir).
851: 		*-- Sao CommandButton SOLTOS na Form no legado, nao membros de grupo.
852: 		BINDEVENT(THIS.cmd_4c_Fwbtng1, "Click", THIS, "CmdExpandirClick")
853: 		BINDEVENT(THIS.cmd_4c_Fwbtng2, "Click", THIS, "CmdRegredirClick")
854: 
855: 		*-- obj_4c_TreeView: KeyPress (ESC) e NodeClick (no selecionado) do
856: 		*-- TreeView legado. O DblClick do TreeView legado esta VAZIO no dump
857: 		*-- ("*** ActiveX Control Event ***" e mais nada), entao nao ha o que
858: 		*-- ligar nele - ligar um handler ali seria inventar comportamento.


### BO (C:\4c\projeto\app\classes\SIGOPNOPBO.prg):
*==============================================================================
* SIGOPNOPBO.PRG
* Business Object para FormSIGOPNOP - Analise de OP/Envelopes
*
* Form OPERACIONAL de consulta (sem tabela unica): pesquisa movimentacoes de
* producao por numero de Envelope (SigCdNei/SigCdNec) ou por numero de O.P.
* (SigCdNei/SigCdNec/SigOpPic/SigPdMvf), monta a arvore de resultado e exibe
* a figura do produto (SigCdPro.FigJpgs) extraida para arquivo temporario.
*==============================================================================

DEFINE CLASS SIGOPNOPBO AS BusinessBase

	*-- Criterios de pesquisa (espelham Container1.GetOP e Container1.GetEnvelope do legado)
	this_nNumeroOP = 0
	this_nNumeroEnvelope = 0

	*-- Cursores de resultado populados pelas pesquisas (Fase 2)
	this_cCursorArvore = "cursor_4c_Arvore"
	this_cCursorProduto = "cursor_4c_Produto"
	this_lRegistroEncontrado = .F.

	*-- Figura do produto extraida de SigCdPro.FigJpgs para arquivo temporario
	this_cArquivoImagem = ""

	*-- REGISTRO CORRENTE da arvore de resultado (THIS.this_cCursorArvore),
	*-- carregado por CarregarDoCursor(). Os nomes espelham as colunas do cursor
	*-- (que por sua vez espelham as colunas do legado lidas no Scan de
	*-- MakeTree/MakeTreeEnv sobre CrSigCdNei).
	this_cCidchaves = ""
	this_nNenvs = 0
	this_cEmpDnPs = ""
	this_dDatas = {}
	this_cGrupoos = ""
	this_cContaos = ""
	this_cGrupods = ""
	this_cContads = ""
	this_lServicos = .F.
	this_nNops = 0
	this_cCmats = ""
	this_cDpros = ""
	this_nQtds = 0
	this_cCunis = ""
	this_nPeso2s = 0
	this_cCunips = ""
	this_nPesos = 0
	this_nTotPesos = 0
	this_cCpros = ""
	this_nNopMaes = 0

	*-- Decomposicao POSICIONAL de EmpDnPs char(33) = Emps(3) + Dopps(20) +
	*-- Str(Numps, 10). O legado decompoe assim no TreeView.DblClick:
	*-- Left(NodeCargo,3) / Substr(NodeCargo,4,20) / Val(Alltrim(Substr(NodeCargo,24)))
	this_cEmps = ""
	this_cDopps = ""
	this_nNumps = 0

	*==============================================================================
	* Init - Inicializa Business Object
	*==============================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- Consulta multi-tabela (SigCdNei/SigCdNec/SigCdPro/SigOpPic/SigPdMvf):
		*-- nao existe tabela mestre unica. O registro eh identificado pela chave de
		*-- movimentacao EmpDnPs char(33), compartilhada pelas tabelas envolvidas.
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = "EmpDnPs"

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_cCursorArvore = "cursor_4c_Arvore"
		THIS.this_cCursorProduto = "cursor_4c_Produto"
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""

		THIS.ResetarRegistroCorrente()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
	* sobrescritos aqui: este form eh de CONSULTA (pesquisa movimentacoes de
	* producao por Envelope ou O.P. em SigCdNei/SigCdNec/SigCdPro/SigOpPic/
	* SigPdMvf), sem INSERT/UPDATE/DELETE no legado - o unico efeito colateral
	* eh a extracao da figura do produto para um arquivo temporario (apagado ao
	* Encerrar). O comportamento padrao herdado de BusinessBase para
	* Inserir/Atualizar/ExecutarExclusao/RegistrarAuditoria ja eh o correto para
	* este BO.
	*
	* Conferido no dump legado (SIGOPNOP_form_codigo_fonte.txt): ZERO ocorrencia
	* de TABLEUPDATE(, ZERO de .AddCursor( e ZERO alvo de Insert Into / Update /
	* Delete From. O unico Delete do legado eh "Delete File (ThisForm.Arqfigura)",
	* que apaga o arquivo temporario da figura e nao toca no banco - reproduzido
	* aqui em ExcluirImagemTemporaria(). Inventar um INSERT/UPDATE para este BO
	* exigiria adivinhar a lista de colunas, o que a regra #22 do CLAUDE.md
	* proibe (a lista vem do schema, nunca de adivinhacao).
	*
	* ObterChavePrimaria() SIM eh sobrescrito, porque a identidade do registro
	* corrente (EmpDnPs) nao eh derivavel de this_cTabela/this_cCampoChave.
	*==============================================================================

	*==============================================================================
	* PesquisarPorEnvelope - Pesquisa movimentacoes de producao por numero de
	* Envelope. Equivale ao PROCEDURE Valid de Container1.GetEnvelope no legado
	* (SigCdNei/SigCdNec/SigCdPro), que monta o cursor CrSigCdNei consumido pela
	* arvore (ThisForm.MakeTreeEnv no legado).
	*==============================================================================
	PROCEDURE PesquisarPorEnvelope(par_nNumeroEnvelope)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroEnvelope) != "N" OR par_nNumeroEnvelope = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroEnvelope = par_nNumeroEnvelope

		loc_cSQL = "SELECT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, b.Grupoos, b.Contaos, " + ;
			"b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, a.Nops, a.Cmats, c.Dpros, a.Qtds, c.Cunis, " + ;
			"a.Peso2s, c.Cunips, a.Pesos, SPACE(14) AS Cpros, 0 AS NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroEnvelope, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			THIS.this_cMensagemErro = "Envelope N" + CHR(227) + "o Localizado !!!"
			USE IN cursor_4c_Nensi
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* PesquisarPorOP - Pesquisa movimentacoes de producao por numero de O.P.
	* Equivale ao PROCEDURE Valid de Container1.GetOP no legado: primeiro tenta a
	* consulta de movimentacao normal (SigCdNei/SigCdNec/SigCdPro/SigOpPic, nos
	* dois sentidos - O.P. propria e O.P. filha de um Envelope); se nao encontrar
	* nada, cai no fallback de O.P. ainda sem movimentacao gerada (SigPdMvf/
	* SigCdNec). Em qualquer dos dois casos, busca a figura do produto em
	* SigCdPro e extrai para arquivo temporario (THIS.this_cArquivoImagem).
	*==============================================================================
	PROCEDURE PesquisarPorOP(par_nNumeroOP)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cProduto

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroOP) != "N" OR par_nNumeroOP = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroOP = par_nNumeroOP

		loc_cSQL = "SELECT DISTINCT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nops = d.Nops " + ;
			"UNION ALL " + ;
			"SELECT DISTINCT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.Nops <> " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nenvs = d.Nops " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			*-- O.P. ainda sem movimentacao gerada - cai no fallback de SigPdMvf,
			*-- igual ao legado ("Nenhum" material agregado, pesos/qtds zerados)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF

			loc_cSQL = "SELECT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
				"b.Grupoos, b.Contaos, b.Grupods, b.Contads, 0 AS Servicos, " + ;
				"0 AS Nops, 'Nenhum        ' AS Cmats, " + ;
				"'Nenhum Material Agregado' AS Dpros, 0 AS Qtds, '   ' AS Cunis, " + ;
				"0 AS Peso2s, '   ' AS Cunips, 0 AS Pesos, a.CodPds AS Cpros, 0 AS NopMaes " + ;
				"FROM SigPdMvf a, SigCdNec b " + ;
				"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
				" AND a.EmpDnPs = b.EmpDnPs " + ;
				"ORDER BY b.Cidchaves, a.Nops"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
				RETURN .F.
			ENDIF

			SELECT cursor_4c_Nensi
			GO TOP

			IF EOF("cursor_4c_Nensi")
				THIS.this_cMensagemErro = "O.P. N" + CHR(227) + "o Localizada !!!"
				USE IN cursor_4c_Nensi
				RETURN .F.
			ENDIF
		ENDIF

		loc_cProduto = ALLTRIM(cursor_4c_Nensi.Cpros)

		IF !THIS.BuscarImagemProduto(loc_cProduto)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarCursorArvore - Agrupa os pesos por movimentacao (EmpDnPs, excluindo
	* linhas de servico) e junta o total (TotPesos) a cada linha do cursor de
	* origem, gravando o resultado em THIS.this_cCursorArvore. Equivale ao bloco
	* final repetido no Valid de GetEnvelope e de GetOP do legado (Select ...
	* Sum(Pesos) ... Group by 1 + Select a.*, b.TotPesos ... Into Cursor
	* CrSigCdNei Order by CidChaves, Nops, Cmats).
	*==============================================================================
	PROTECTED PROCEDURE MontarCursorArvore(par_cCursorOrigem)
		LOCAL loc_cCursorTotais

		loc_cCursorTotais = "cursor_4c_Totais"

		IF !USED(par_cCursorOrigem)
			RETURN .F.
		ENDIF

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		SELECT EmpDnPs, SUM(Pesos) AS TotPesos FROM (par_cCursorOrigem) WHERE Servicos = 0 ;
			INTO CURSOR (loc_cCursorTotais) GROUP BY 1

		IF USED(THIS.this_cCursorArvore)
			USE IN (THIS.this_cCursorArvore)
		ENDIF

		SELECT a.*, b.TotPesos FROM (par_cCursorOrigem) a, (loc_cCursorTotais) b ;
			WHERE a.EmpDnPs = b.EmpDnPs ;
			INTO CURSOR (THIS.this_cCursorArvore) READWRITE ;
			ORDER BY a.CidChaves, a.Nops, a.Cmats

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		RETURN USED(THIS.this_cCursorArvore) AND RECCOUNT(THIS.this_cCursorArvore) > 0
	ENDPROC

	*==============================================================================
	* BuscarImagemProduto - Localiza o produto em SigCdPro e extrai a figura
	* (FigJpgs) para um arquivo .jpg temporario, exatamente como o legado faz no
	* final do Valid de GetOP (StrToFile sobre o campo memo). Ausencia de figura
	* NAO eh erro - THIS.this_cArquivoImagem fica vazio e o Form nao exibe nada.
	*==============================================================================
	PROTECTED PROCEDURE BuscarImagemProduto(par_cProduto)
		LOCAL loc_cSQL, loc_nResultado, loc_cNomeArquivo

		THIS.this_cArquivoImagem = ""

		IF VARTYPE(par_cProduto) != "C" OR EMPTY(ALLTRIM(par_cProduto))
			RETURN .T.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			USE IN (THIS.this_cCursorProduto)
		ENDIF

		loc_cSQL = "SELECT Cpros, Dpros, FigJpgs FROM SigCdPro WHERE Cpros = " + ;
			EscaparSQL(par_cProduto)

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProduto)

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			SELECT (THIS.this_cCursorProduto)
			GO TOP

			IF !EOF() ;
					AND !EMPTY(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs")) ;
					AND !ISNULL(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"))

				loc_cNomeArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + ".jpg"

				IF STRTOFILE(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"), loc_cNomeArquivo) > 0
					THIS.this_cArquivoImagem = loc_cNomeArquivo
				ENDIF
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC


	*==============================================================================
	* CarregarDoCursor - Carrega o registro CORRENTE do cursor da arvore para as
	* propriedades do BO. Eh o que o Form consome ao montar a arvore e ao tratar o
	* no selecionado: no legado, cada iteracao do "Scan" de MakeTree/MakeTreeEnv
	* le essas MESMAS colunas direto do cursor CrSigCdNei.
	*
	* Sem par_cAliasCursor assume THIS.this_cCursorArvore.
	*
	* A work area corrente eh SALVA e RESTAURADA: o Form chama este metodo de
	* dentro de lacos que percorrem o proprio cursor, e trocar a area sem repor
	* quebraria o SCAN do chamador. Por isso ha um unico RETURN, no fim.
	*==============================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_nAreaAnterior, loc_lSucesso, loc_cChave

		loc_lSucesso = .F.

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			ALLTRIM(par_cAliasCursor), THIS.this_cCursorArvore)

		IF !USED(loc_cAlias)
			THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
				"o est" + CHR(225) + " aberto."
		ELSE
			loc_nAreaAnterior = SELECT()
			SELECT (loc_cAlias)

			*-- Cursor em EOF/BOF nao eh falha: apenas nao ha registro corrente
			*-- para carregar (a arvore chama este metodo dentro de laco)
			IF !EOF() AND !BOF()
				THIS.this_cCidchaves = TratarNulo(Cidchaves, "")
				THIS.this_nNenvs     = TratarNulo(Nenvs, 0)
				THIS.this_cEmpDnPs   = TratarNulo(EmpDnPs, "")
				THIS.this_dDatas     = ConverterParaData(Datas)
				THIS.this_cGrupoos   = TratarNulo(Grupoos, "")
				THIS.this_cContaos   = TratarNulo(Contaos, "")
				THIS.this_cGrupods   = TratarNulo(Grupods, "")
				THIS.this_cContads   = TratarNulo(Contads, "")
				THIS.this_nNops      = TratarNulo(Nops, 0)
				THIS.this_cCmats     = TratarNulo(Cmats, "")
				THIS.this_cDpros     = TratarNulo(Dpros, "")
				THIS.this_nQtds      = TratarNulo(Qtds, 0)
				THIS.this_cCunis     = TratarNulo(Cunis, "")
				THIS.this_nPeso2s    = TratarNulo(Peso2s, 0)
				THIS.this_cCunips    = TratarNulo(Cunips, "")
				THIS.this_nPesos     = TratarNulo(Pesos, 0)
				THIS.this_cCpros     = TratarNulo(Cpros, "")
				THIS.this_nNopMaes   = TratarNulo(NopMaes, 0)

				*-- Servicos eh coluna bit no SQL Server. O SELECT do BO a traz
				*-- como CAST(... AS INT), entao chega SEMPRE numerica ao cursor.
				*-- A conversao aqui entrega um LOGICO de verdade ao Form, que
				*-- precisa dele para usar IIF() (IIF exige logico no 1o argumento).
				THIS.this_lServicos = ConverterParaLogico(TratarNulo(Servicos, 0))

				*-- TotPesos so existe no cursor da arvore (eh o total agregado por
				*-- movimentacao). Alias cru de SQLEXEC nao tem essa coluna, e nome
				*-- de campo inexistente estoura "Variable ... is not found" - por
				*-- isso o TYPE() antes (PEMSTATUS NAO serve para cursor).
				IF TYPE(loc_cAlias + ".TotPesos") = "N"
					THIS.this_nTotPesos = TratarNulo(EVALUATE(loc_cAlias + ".TotPesos"), 0)
				ELSE
					THIS.this_nTotPesos = 0
				ENDIF

				*-- EmpDnPs char(33) eh chave POSICIONAL: Emps(3) + Dopps(20) +
				*-- Str(Numps, 10). O legado decompoe exatamente nessas fatias
				*-- (Left / Substr / Val) no TreeView.DblClick. O PADR garante as
				*-- 33 posicoes antes de fatiar; NUNCA aplicar ALLTRIM nas partes
				*-- INTERIORES, porque o padding FAZ PARTE da chave.
				loc_cChave = PADR(THIS.this_cEmpDnPs, 33)
				THIS.this_cEmps  = LEFT(loc_cChave, 3)
				THIS.this_cDopps = SUBSTR(loc_cChave, 4, 20)
				THIS.this_nNumps = VAL(ALLTRIM(SUBSTR(loc_cChave, 24)))

				loc_lSucesso = .T.
			ENDIF

			IF loc_nAreaAnterior > 0
				SELECT (loc_nAreaAnterior)
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarChaveEmpDnPs - Remonta a chave POSICIONAL EmpDnPs:
	*     Emps char(3) + Dopps char(20) + Str(Numps, 10) = char(33)
	* A largura do char(33) destino (SigCdNei / SigCdNec / SigPdMvf / SigOpPic) eh
	* a conferencia da montagem: 3 + 20 + 10 = 33.
	*
	* PADR EXPLICITO em cada parte. ALLTRIM nas partes INTERIORES encurtaria a
	* chave, ela nunca casaria no WHERE e o SELECT devolveria ZERO linhas em
	* SILENCIO - sem erro e sem log. Nao confiar no padding que o cursor por
	* acaso traz: as propriedades do BO podem ter vindo de um TextBox.
	*==============================================================================
	PROCEDURE MontarChaveEmpDnPs(par_cEmps, par_cDopps, par_nNumps)
		LOCAL loc_cEmps, loc_cDopps, loc_nNumps

		loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
		loc_cDopps = IIF(VARTYPE(par_cDopps) = "C", par_cDopps, "")
		loc_nNumps = IIF(VARTYPE(par_nNumps) = "N", par_nNumps, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopps, 20) + STR(loc_nNumps, 10)
	ENDPROC

	*==============================================================================
	* ObterChavePrimaria - Identidade do registro corrente, usada pela auditoria
	* da BusinessBase. Nesta consulta nao existe tabela mestre unica: o registro
	* eh identificado pela chave de movimentacao EmpDnPs, coluna char(33) que
	* SigCdNei, SigCdNec, SigPdMvf e SigOpPic compartilham.
	*
	* ALLTRIM aqui eh na chave INTEIRA (no fim), nao nas partes - isso eh
	* inofensivo, porque char no SQL Server compara com blank-padding ANSI.
	*==============================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		LOCAL loc_cChave

		loc_cChave = ALLTRIM(THIS.this_cEmpDnPs)

		IF EMPTY(loc_cChave)
			loc_cChave = ALLTRIM(THIS.MontarChaveEmpDnPs(THIS.this_cEmps, ;
				THIS.this_cDopps, THIS.this_nNumps))
		ENDIF

		RETURN loc_cChave
	ENDPROC

	*==============================================================================
	* ResetarRegistroCorrente - Zera as propriedades do registro corrente da
	* arvore. Chamado pelo Init e pelo LimparDados: o Form nao eh fechado entre
	* uma pesquisa e outra, entao sem este reset a pesquisa seguinte exibiria
	* residuo da anterior quando o novo cursor viesse vazio.
	*==============================================================================
	PROTECTED PROCEDURE ResetarRegistroCorrente()
		THIS.this_cCidchaves = ""
		THIS.this_nNenvs     = 0
		THIS.this_cEmpDnPs   = ""
		THIS.this_dDatas     = {}
		THIS.this_cGrupoos   = ""
		THIS.this_cContaos   = ""
		THIS.this_cGrupods   = ""
		THIS.this_cContads   = ""
		THIS.this_lServicos  = .F.
		THIS.this_nNops      = 0
		THIS.this_cCmats     = ""
		THIS.this_cDpros     = ""
		THIS.this_nQtds      = 0
		THIS.this_cCunis     = ""
		THIS.this_nPeso2s    = 0
		THIS.this_cCunips    = ""
		THIS.this_nPesos     = 0
		THIS.this_nTotPesos  = 0
		THIS.this_cCpros     = ""
		THIS.this_nNopMaes   = 0
		THIS.this_cEmps      = ""
		THIS.this_cDopps     = ""
		THIS.this_nNumps     = 0

		RETURN .T.
	ENDPROC

	*==============================================================================
	* LimparDados - Zera criterios de pesquisa e registro corrente, fechando os
	* cursores de resultado. O Form chama isto ao limpar a tela (no legado os dois
	* TextBox se zeram mutuamente: GetOP.GotFocus zera GetEnvelope e o GotFocus de
	* GetEnvelope zera GetOP).
	*==============================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cMensagemErro = ""

		THIS.ResetarRegistroCorrente()
		THIS.FecharCursoresResultado()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* FecharCursoresResultado - Fecha os cursores de resultado da consulta.
	*
	* O guard eh pelo BUFFERING, nao so pelo USED(): TABLEREVERT() EXIGE row ou
	* table buffering e, sem ele, dispara o erro 1586 em vez de ser no-op. Cursor
	* nascido de CREATE CURSOR ou de SELECT INTO CURSOR vem com Buffering = 1, e
	* nesse caso USE IN fecha o alias sozinho, mesmo com buffer sujo.
	*==============================================================================
	PROCEDURE FecharCursoresResultado()
		LOCAL ARRAY loc_aCursores[3]
		LOCAL loc_nI, loc_cCursor

		loc_aCursores[1] = THIS.this_cCursorArvore
		loc_aCursores[2] = THIS.this_cCursorProduto
		loc_aCursores[3] = "cursor_4c_Nensi"

		FOR loc_nI = 1 TO ALEN(loc_aCursores)
			loc_cCursor = loc_aCursores[loc_nI]

			IF VARTYPE(loc_cCursor) = "C" AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
				IF CURSORGETPROP("Buffering", loc_cCursor) > 1
					TABLEREVERT(.T., loc_cCursor)
				ENDIF
				USE IN (loc_cCursor)
			ENDIF
		ENDFOR

		RETURN .T.
	ENDPROC

	*==============================================================================
	* ExcluirImagemTemporaria - Apaga o .jpg que BuscarImagemProduto extraiu de
	* SigCdPro.FigJpgs. Equivale ao "Delete File (ThisForm.Arqfigura)" que o legado
	* executa no Click do botao de saida (Commandgroup1).
	*
	* CLEAR RESOURCES antes de apagar: o VFP mantem o bitmap em cache e o arquivo
	* fica preso enquanto o cache nao eh liberado (o legado faz o mesmo antes de
	* trocar a figura). SET SAFETY OFF em volta do DELETE FILE porque com SAFETY ON
	* ele abre dialogo de confirmacao, e dialogo modal travaria o pipeline.
	*==============================================================================
	PROCEDURE ExcluirImagemTemporaria()
		LOCAL loc_cArquivo, loc_cSafety

		loc_cArquivo = ALLTRIM(THIS.this_cArquivoImagem)
		THIS.this_cArquivoImagem = ""

		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
			CLEAR RESOURCES

			loc_cSafety = SET("SAFETY")
			SET SAFETY OFF

			DELETE FILE (loc_cArquivo)

			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Destroy - Libera os cursores de resultado e o arquivo temporario da figura.
	*==============================================================================
	PROCEDURE Destroy()
		THIS.ExcluirImagemTemporaria()
		THIS.FecharCursoresResultado()

		DODEFAULT()
	ENDPROC
ENDDEFINE

