# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = "crSigSyCom.hands"
  ControlSource = "crSigSyCom.settings"
  ControlSource = "crSigSyCom.dtrs"
  ControlSource = "crSigSyCom.rtss"
  ControlSource = "crSigSyCom.portas"
  ControlSource = ""
  ControlSource = "crSigSyCom.inbufs"
  ControlSource = "crSigSyCom.outbufs"
  ControlSource = "crSigSyCom.inmodes"
  ControlSource = "crSigSyCom.inlens"
  ControlSource = "crSigSyCom.TpLeChqs"
  ControlSource = "crSigSyCom.tpBarras"
  ControlSource = "crSigSyCom.bompara"
  ControlSource = "crSigSyCom.nominal"
  ControlSource = "crSigSyCom.cruzado"
		lcQryCFis = [Select * From SigSyCom]
		Select crSigSyCom
		If Not Seek(Padr('Balança',20))
			Insert Into crSigSyCom (Tipos, CidChaves) Values ('Balança',fUniqueIds())
		If Not Seek(Padr('Cupom Fiscal',20))
			Insert Into crSigSyCom (Tipos, CidChaves) Values ('Cupom Fiscal',fUniqueIds())
		If Not Seek(Padr('Leitora Cheques',20))
			Insert Into crSigSyCom (Tipos, CidChaves) Values ('Leitora Cheques',fUniqueIds())
		If Not Seek(Padr('Leitora Codigo Barra',20))
			Insert Into crSigSyCom (Tipos, CidChaves) Values ('Leitora Codigo Barra',fUniqueIds())
		If Not Seek(Padr('Impressora de Cheque',20))
			Insert Into crSigSyCom (Tipos, CidChaves) Values ('Impressora de Cheque',fUniqueIds())
		If Not Seek(Padr('Gaveta Serial',20))
			Insert Into crSigSyCom (Tipos, CidChaves) Values ('Gaveta Serial',fUniqueIds())
If Seek(ThisForm.Cmb_Tipo.value,'crSigSyCom','PesqTipo')
If Seek(This.value,'crSigSyCom','PesqTipo')
If Not ThisForm.poDataMgr.Update('crSigSyCom')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigSyCom)')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCPE.prg) - TRECHOS RELEVANTES PARA PASS SQL (2305 linhas total):

*-- Linhas 14 a 32:
14: * Page2=Dados do CRUD (frmcadastro) - criar PageFrame aqui inventaria
15: * estrutura que o legado nao tem (viola o PILAR 1).
16: *
17: * O usuario escolhe o dispositivo no Cmb_Tipo (sem ControlSource - so
18: * reposiciona o cursor via SEEK, igual ao legado) e edita os campos da
19: * linha corrente do cursor_4c_Dados (equivalente a crSigSyCom); o botao
20: * Confirmar grava com SIGOPCPEBO.Atualizar() e Encerrar fecha sem gravar.
21: *
22: * FASE 3/8: Estrutura base do Form - DEFINE CLASS com as propriedades
23: * visuais transcritas do dump (Width=800/Height=355/BorderStyle=2/
24: * DataSession=2/TitleBar=0 - ver SECAO 2 do dump para SIGOPCPE),
25: * Init()/InicializarForm() e dois blocos:
26: *   - ConfigurarCabecalho() - cntSombra/lblSombra/lblTitulo do legado,
27: *     transcrito COM os valores exatos do dump (Left=7 no cntSombra,
28: *     Top=18/17 nos labels - nao e o padrao canonico injetado da regra
29: *     CLAUDE.md #11, que e para forms CRUD sem essa faixa no SCX; aqui a
30: *     faixa JA EXISTE no legado e e so transcrita).
31: *   - ConfigurarBotoes() - container cnt_4c_Botoes na posicao dos botoes
32: *     Ok/cancela do legado (Left=649..800, Top=3), deixado VAZIO

*-- Linhas 54 a 111:
54: *   Say6/Cmb_Tipo, Say1/Spinner1, Say2/Cmb_Hand, Say3/Get_Set,
55: *   Say4/chk_dtr, Say5/chk_rts, Say7/Get_inbuf
56: * Os Top do SCX entram ABSOLUTOS (sem o "+29" dos forms CRUD - nao ha
57: * PageFrame) e o ControlSource de cada campo eh TRANSCRITO do SCX, com o
58: * alias do cursor novo (crSigSyCom -> cursor_4c_Dados): a ligacao campo
59: * <-> cursor eh o proprio mecanismo da tela no legado. Para isso o
60: * cursor eh aberto e posicionado ANTES de criar os campos, pelo
61: * SIGOPCPEBO.CarregarDados() chamado no InicializarForm - binding para
62: * alias fechado derrubaria o Init (CLAUDE.md regra #41).
63: *
64: * FASE 6/8 (ESTE ARQUIVO): ConfigurarCamposSecundarios() - COLUNA
65: * DIREITA, os 17 controles restantes: Say8/Get_outbuf, Say9/Get_inmode,
66: * Say11, Say10/Get_inlen (bloco numerico sempre visivel) e os dois
67: * blocos que o Init/InteractiveChange legado mostram/escondem conforme o
68: * Tipo escolhido - Say12/Get_TpLeChq, Say14/Chk_Bompara, Say15/
69: * chk_nominal, Say16/chk_cruzado (cheque) e Say13/Opt_leitor (leitor de
70: * codigo de barra). Todos nascem com .Visible = .T. no AddObject e quem
71: * decide a visibilidade de verdade eh AplicarVisibilidadePorTipo(),
72: * chamado no fim do InicializarForm - DEPOIS do TornarControlesVisiveis,
73: * que forca .T. em tudo. Say13 tem ZOrderSet = 12 no dump - bookkeeping
74: * do Form Designer, DESCARTADO (CLAUDE.md regra #33). Opt_leitor eh OptionGroup
75: * com ControlSource numerico direto (tpbarras numeric(1,0)): Value = indice
76: * do botao marcado (2 = Teclado, default do SCX), sem +1/-1 (regra #45);
77: * Option1/Option2.Value do dump (0/1) sao residuo do Form Designer e NAO
78: * sao transcritos nos botoes individuais - so o Value do GRUPO manda.
79: *
80: * Esta fase tambem entrega o que faz esses campos FUNCIONAREM, porque a
81: * regra governa os campos que ela acrescenta:
82: *   - ConfigurarEventos() - BINDEVENT do unico evento de campo do dump
83: *     (Cmb_Tipo.InteractiveChange).
84: *   - ValidarTipo() - transcricao desse InteractiveChange: SEEK(PADR(
85: *     valor,20)) na tag PesqTipo, Refresh so quando acha a linha, e
86: *     alternancia dos blocos condicionais sempre.
87: *   - AplicarVisibilidadePorTipo() - o bloco de esconder/reexibir que o
88: *     legado repete no Init e no InteractiveChange, com fonte unica.
89: * Nao ha lookup a implementar: o dump nao tem fwBusca*, mAddColuna,
90: * sigacess nem Acesso*, e nenhum campo tem Valid/When/LostFocus - o
91: * unico When (Chk_Bompara) esta com o corpo VAZIO no legado.
92: *
93: * FASE 7: os eventos dos DOIS unicos botoes do legado, que sao tambem os
94: * dois unicos Click do dump inteiro:
95: *   - BtnConfirmarClick() - Ok.Click: grava o cursor INTEIRO em SigSyCom
96: *     (GravarTodosOsTipos, equivalente ao poDataMgr.Update), confirma a
97: *     transacao (ConfirmarTransacao, equivalente ao Commit() < 1) e fecha.
98: *   - BtnEncerrarClick() - cancela.Click: Release, descartando o que
99: *     estiver so no cursor.
100: * O legado NAO tem barra CRUD (classe base [form] puro, sem frmcadastro,
101: * sem Grupo_Op, sem pcEscolha), por isso esta fase nao entrega
102: * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick -
103: * nao existe botao para eles no SCX e inventar um violaria o PILAR 1.
104: *
105: * FASE 8/8 (ESTE ARQUIVO): eventos auxiliares e consolidacao. O que entra:
106: *   - CarregarLista() - FUNIL unico de carga do cursor de trabalho
107: *     (SIGOPCPEBO.CarregarDados + reposicionamento + repintar guardado).
108: *     O InicializarForm passou a chamar o funil em vez do BO direto.
109: *   - BOParaForm() - properties do BO -> os 15 controles de dados + o
110: *     seletor Cmb_Tipo, com as conversoes de tipo explicitas. Passou a ser
111: *     o repintar do ValidarTipo, antes feito a mao ali dentro.

*-- Linhas 205 a 223:
205: 
206:             *-- O cursor de trabalho tem de existir e estar POSICIONADO antes
207:             *-- de ConfigurarCamposPrincipais: os campos sao ligados a ele por
208:             *-- ControlSource (como no legado) e binding para alias fechado
209:             *-- derruba o Init inteiro (CLAUDE.md regra #41). Equivale ao
210:             *-- AddCursor + ReQuery + Index + Go Top que o Init legado executa
211:             *-- ANTES de qualquer Refresh de controle.
212:             *--
213:             *-- Falhando a carga, a tela NAO abre - mesmo comportamento do
214:             *-- legado, que faz [Return .f.] quando o fSqlConector nao
215:             *-- conecta. CarregarLista/CarregarDados ja exibiram a mensagem,
216:             *-- por isso aqui nao se repete (CLAUDE.md regra #20).
217:             *--
218:             *-- FASE 8: a chamada passa pelo FUNIL CarregarLista() em vez de
219:             *-- ir direto ao BO. Aqui os controles ainda NAO existem, entao o
220:             *-- funil carrega, indexa, semeia e posiciona o cursor e PULA o
221:             *-- repintar - o combo fica em branco, que eh o estado real do
222:             *-- legado na abertura (ver cabecalho de CarregarLista).
223:             IF !THIS.CarregarLista()

*-- Linhas 341 a 359:
341:     * Confirmar = cadastro_salvar_60.jpg, Encerrar = cadastro_sair_60.jpg.
342:     *
343:     * BINDEVENT dos Click fica para as Fases 7-8 (guard de conexao do
344:     * Init legado + fluxo de Update/Commit/fGrvSettings do Ok.Click e
345:     * Release do cancela.Click, ver comportamento.json).
346:     *==========================================================================
347:     PROTECTED PROCEDURE ConfigurarBotoes()
348:         THIS.AddObject("cnt_4c_Botoes", "Container")
349:         WITH THIS.cnt_4c_Botoes
350:             .Top         = 0
351:             .Left        = 649
352:             .Width       = 151
353:             .Height      = 85
354:             .BackStyle   = 0
355:             .BorderWidth = 0
356:             .Visible     = .T.
357:         ENDWITH
358: 
359:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirmar", "CommandButton")

*-- Linhas 439 a 477:
439:     * Top 0..80 e o primeiro controle de dados esta em Top = 106, entao
440:     * nada fica soterrado e nao ha re-layout a fazer.
441:     *
442:     * ControlSource TRANSCRITO do SCX: o legado liga cada controle direto ao
443:     * cursor (ControlSource = "crSigSyCom.<coluna>") e eh esse binding que
444:     * faz a tela funcionar - trocar o Tipo no Cmb_Tipo so reposiciona o
445:     * cursor, e sao os controles ligados que passam a exibir a nova linha.
446:     * Aqui o alias muda de nome (crSigSyCom -> cursor_4c_Dados, PILAR 3) e o
447:     * resto eh identico, coluna por coluna.
448:     *
449:     * Pre-requisito INDISPENSAVEL: o cursor ja esta aberto e posicionado
450:     * quando este metodo roda - o InicializarForm chama
451:     * this_oBusinessObject.CarregarDados() ANTES daqui, do mesmo jeito que o
452:     * Init legado faz AddCursor + ReQuery + Index + Go Top antes de qualquer
453:     * Refresh de controle. Sem isso o binding estouraria
454:     * [Alias CURSOR_4C_DADOS is not found] e a tela nao abriria
455:     * (CLAUDE.md regra #41).
456:     *
457:     * O .ControlSource eh a ULTIMA propriedade de cada bloco WITH: o .Value
458:     * que vem antes serve apenas para o controle nascer com o TIPO da coluna
459:     * destino (char -> vazio, numeric -> 0, bit -> logico no cursor); a
460:     * partir do binding quem manda eh o campo do cursor.
461:     *
462:     * EXCECAO: o Cmb_Tipo NAO eh ligado - no dump o ControlSource dele eh
463:     * string VAZIA. Ele nao grava nada, apenas escolhe a linha a posicionar.
464:     *
465:     * Propriedades vindas da CLASSE do Framework (framework.vcx), e nao do
466:     * SCX - o SCX so declara o que sobrescreve, entao o que ele NAO
467:     * declara tem de vir da classe, nunca de palpite
468:     * (docs/FRAMEWORK_class_codigo_fonte.txt):
469:     *   say         -> Height 15, BackStyle 0, ForeColor 90,90,90
470:     *   fwget       -> Height 23, Width 100, Format K, Themes .F.,
471:     *                  DisabledBackColor 192,192,192 / DisabledForeColor 0,0,0
472:     *   fwcombo     -> Height 24, Width 100, Style 2 (dropdown LIST),
473:     *                  Themes .F., DisabledForeColor 0,0,0
474:     *   fwcheckbox  -> Height 17, Width 60, Alignment 0, BackStyle 0,
475:     *                  ForeColor 90,90,90, Themes .F.
476:     * NAO sao atribuidas BackStyle em ComboBox/Spinner nem ForeColor em
477:     * Spinner-grupo: ComboBox e Spinner nao TEM BackStyle (conferido em

*-- Linhas 487 a 506:
487:         *----------------------------------------------------------------------
488:         * Say6 "Tipo : " + Cmb_Tipo - escolha do dispositivo
489:         *
490:         * O Cmb_Tipo eh o UNICO controle da tela sem ControlSource tambem no
491:         * legado (ControlSource vazio no dump): ele nao grava nada, apenas
492:         * reposiciona o cursor via SEEK no InteractiveChange. Os 6 itens sao
493:         * os mesmos tipos que o Init legado GARANTE existirem na tabela,
494:         * lidos do BO (SIGOPCPEBO.ObterTipoPorIndice) para nao duplicar aqui
495:         * os literais com CHR() de Balanca (CLAUDE.md regra #4).
496:         *----------------------------------------------------------------------
497:         THIS.AddObject("lbl_4c_Label6", "Label")
498:         WITH THIS.lbl_4c_Label6
499:             .Top       = 110
500:             .Left      = 117
501:             *-- Width = 152 (Left do Cmb_Tipo) - 117: eh o vao que o legado
502:             *-- reservou para este texto. A classe say eh AutoSize = .T. /
503:             *-- Alignment = 0, mas AutoSize eh NO-OP em Label criado por
504:             *-- AddObject (fica nos 100 do default), por isso Width e Height
505:             *-- explicitos e Alignment = 0 (CLAUDE.md regra #23).
506:             .Width     = 35

*-- Linhas 543 a 561:
543:             .Clear()
544:         ENDWITH
545: 
546:         *-- Itens na MESMA ordem dos Insert Into / AddItem do Init legado
547:         FOR loc_nI = 1 TO THIS.this_oBusinessObject.this_nTotalTipos
548:             loc_cTipo = THIS.this_oBusinessObject.ObterTipoPorIndice(loc_nI)
549:             IF !EMPTY(loc_cTipo)
550:                 THIS.cbo_4c_Cmb_Tipo.AddItem(loc_cTipo)
551:             ENDIF
552:         ENDFOR
553: 
554:         *-- ListIndex = 0 (nenhum item pre-selecionado) eh o estado REAL do
555:         *-- legado: o With do Init faz .ListIndex = 1 ANTES do .Clear, e o
556:         *-- Clear zera o ListIndex - entao o combo abre em branco. Por isso
557:         *-- o [If Seek(ThisForm.Cmb_Tipo.value, ...)] logo abaixo falha e o
558:         *-- cursor permanece onde o Go Top o deixou. Explicito aqui para que
559:         *-- o estado inicial seja intencional, e nao acidental.
560:         THIS.cbo_4c_Cmb_Tipo.ListIndex = 0
561: 

*-- Linhas 605 a 635:
605:             *-- "No. Porta Comunicacao"
606:             .ToolTipText       = "No. Porta Comunica" + CHR(231) + CHR(227) + "o"
607:             .Visible           = .T.
608:             *-- ControlSource transcrito do SCX legado
609:             *-- (obj_4c_Spinner1.ControlSource = "crSigSyCom.portas"). Por ultimo no
610:             *-- bloco: o .Value acima so semeia o TIPO da coluna; a
611:             *-- partir do binding o valor vem da linha corrente do
612:             *-- cursor, que CarregarDados ja abriu e posicionou.
613:             .ControlSource = "cursor_4c_Dados.portas"
614:         ENDWITH
615: 
616:         *----------------------------------------------------------------------
617:         * Say2 "HandShaking : " + Cmb_Hand - protocolo de controle de fluxo
618:         *
619:         * Os 4 itens (0-None, 1-Xon Xoff, 2-RTS e um em BRANCO) sao
620:         * transcritos do With This.Cmb_Hand do Init legado. Com ControlSource
621:         * char (hands char(20)), o valor gravado eh o TEXTO do item escolhido
622:         * - e o item em branco existe para permitir deixar o campo sem
623:         * protocolo nenhum.
624:         *----------------------------------------------------------------------
625:         THIS.AddObject("lbl_4c_Label2", "Label")
626:         WITH THIS.lbl_4c_Label2
627:             .Top       = 163
628:             .Left      = 75
629:             .Width     = 77
630:             .Height    = 15
631:             .AutoSize  = .F.
632:             .Alignment = 0
633:             .WordWrap  = .F.
634:             .BackStyle = 0
635:             .FontName  = "Tahoma"

*-- Linhas 666 a 689:
666:             .AddItem("1-Xon Xoff")
667:             .AddItem("2-RTS")
668:             .AddItem(" ")
669:             *-- ControlSource transcrito do SCX legado
670:             *-- (cbo_4c_Cmb_Hand.ControlSource = "crSigSyCom.hands"). Por ultimo no
671:             *-- bloco: o .Value acima so semeia o TIPO da coluna; a
672:             *-- partir do binding o valor vem da linha corrente do
673:             *-- cursor, que CarregarDados ja abriu e posicionou.
674:             .ControlSource = "cursor_4c_Dados.hands"
675:         ENDWITH
676: 
677:         *----------------------------------------------------------------------
678:         * Say3 "Settings : " + Get_Set - baud rate / paridade / bits
679:         *
680:         * Width NAO eh declarado no SCX: vem dos 100 da classe fwget. Format
681:         * K tambem eh da classe (seleciona o conteudo ao entrar no campo).
682:         * O default 9600,n,8,1 que o legado repoe quando a coluna chega
683:         * vazia esta em SIGOPCPEBO.this_cSettingsPadrao e eh aplicado na
684:         * carga do cursor, nao aqui.
685:         *----------------------------------------------------------------------
686:         THIS.AddObject("lbl_4c_Label3", "Label")
687:         WITH THIS.lbl_4c_Label3
688:             .Top       = 188
689:             .Left      = 98

*-- Linhas 719 a 756:
719:             .Value             = ""
720:             .ToolTipText       = "Baud Rate, Parity, Databit, StopBit"
721:             .Visible           = .T.
722:             *-- ControlSource transcrito do SCX legado
723:             *-- (txt_4c_Set.ControlSource = "crSigSyCom.settings"). Por ultimo no
724:             *-- bloco: o .Value acima so semeia o TIPO da coluna; a
725:             *-- partir do binding o valor vem da linha corrente do
726:             *-- cursor, que CarregarDados ja abriu e posicionou.
727:             .ControlSource = "cursor_4c_Dados.settings"
728:         ENDWITH
729: 
730:         *----------------------------------------------------------------------
731:         * Say4 "DTRenable : " + chk_dtr  /  Say5 "RTSenable : " + chk_rts
732:         *
733:         * Height 17 / Width 60 vem da classe fwcheckbox - o SCX declara
734:         * AutoSize = .T. nos dois, mas AutoSize eh NO-OP em CheckBox criado
735:         * por AddObject (fica nos 100x17 do default), entao as duas
736:         * dimensoes vao explicitas.
737:         *
738:         * .Value = 0 serve apenas de semente ANTES do binding; a partir do
739:         * .ControlSource quem define o tipo e o valor do CheckBox eh a
740:         * coluna do cursor. dtrs/rtss sao bit do SQL Server e chegam ao VFP
741:         * como LOGICO (no ramo sem conexao o CREATE CURSOR do BO tambem as
742:         * declara como L), entao o CheckBox ligado opera sobre logico -
743:         * igual ao legado, que liga chk_dtr/chk_rts direto nessas colunas.
744:         * Por isso NAO ha conversao a fazer aqui: as propriedades
745:         * this_lDtrs/this_lRtss do BO sao alimentadas pelo CarregarDoCursor,
746:         * a partir da mesma linha do cursor.
747:         *----------------------------------------------------------------------
748:         THIS.AddObject("lbl_4c_Label4", "Label")
749:         WITH THIS.lbl_4c_Label4
750:             .Top       = 210
751:             .Left      = 85
752:             .Width     = 67
753:             .Height    = 15
754:             .AutoSize  = .F.
755:             .Alignment = 0
756:             .WordWrap  = .F.

*-- Linhas 779 a 802:
779:             .TabIndex  = 5
780:             .Value     = 0
781:             .Visible   = .T.
782:             *-- ControlSource transcrito do SCX legado
783:             *-- (chk_4c_Chk_dtr.ControlSource = "crSigSyCom.dtrs"). Por ultimo no
784:             *-- bloco: o .Value acima so semeia o TIPO da coluna; a
785:             *-- partir do binding o valor vem da linha corrente do
786:             *-- cursor, que CarregarDados ja abriu e posicionou.
787:             .ControlSource = "cursor_4c_Dados.dtrs"
788:         ENDWITH
789: 
790:         THIS.AddObject("lbl_4c_Label5", "Label")
791:         WITH THIS.lbl_4c_Label5
792:             .Top       = 230
793:             .Left      = 86
794:             .Width     = 66
795:             .Height    = 15
796:             .AutoSize  = .F.
797:             .Alignment = 0
798:             .WordWrap  = .F.
799:             .BackStyle = 0
800:             .FontName  = "Tahoma"
801:             .FontSize  = 8
802:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 821 a 844:
821:             .TabIndex  = 6
822:             .Value     = 0
823:             .Visible   = .T.
824:             *-- ControlSource transcrito do SCX legado
825:             *-- (chk_4c_Chk_rts.ControlSource = "crSigSyCom.rtss"). Por ultimo no
826:             *-- bloco: o .Value acima so semeia o TIPO da coluna; a
827:             *-- partir do binding o valor vem da linha corrente do
828:             *-- cursor, que CarregarDados ja abriu e posicionou.
829:             .ControlSource = "cursor_4c_Dados.rtss"
830:         ENDWITH
831: 
832:         *----------------------------------------------------------------------
833:         * Say7 "InBufferMode : " + Get_inbuf - tamanho do buffer de recepcao
834:         *
835:         * Ultimo controle da coluna esquerda. Value NUMERICO (inbufs
836:         * numeric(8,0)). O SCX nao declara InputMask nem MaxLength neste
837:         * campo (nem a classe fwget tem), portanto NENHUM dos dois eh
838:         * inventado aqui - inventar restricao que o legado nao tem muda o
839:         * comportamento da tela (CLAUDE.md regra #49) e MaxLength nunca sai
840:         * do Width em pixels (regra #19).
841:         *----------------------------------------------------------------------
842:         THIS.AddObject("lbl_4c_Label7", "Label")
843:         WITH THIS.lbl_4c_Label7
844:             .Top       = 252

*-- Linhas 876 a 933:
876:             *-- "Tamanho Buffer Recepcao"
877:             .ToolTipText       = "Tamanho Buffer Recep" + CHR(231) + CHR(227) + "o"
878:             .Visible           = .T.
879:             *-- ControlSource transcrito do SCX legado
880:             *-- (txt_4c_Inbuf.ControlSource = "crSigSyCom.inbufs"). Por ultimo no
881:             *-- bloco: o .Value acima so semeia o TIPO da coluna; a
882:             *-- partir do binding o valor vem da linha corrente do
883:             *-- cursor, que CarregarDados ja abriu e posicionou.
884:             .ControlSource = "cursor_4c_Dados.inbufs"
885:         ENDWITH
886:     ENDPROC
887: 
888:     *==========================================================================
889:     * ConfigurarCamposSecundarios - FASE 6/8 - COLUNA DIREITA da tela
890:     *
891:     * 17 controles restantes. Quatro deles (Say8/Get_outbuf, Say9/
892:     * Get_inmode, Say11, Say10/Get_inlen) formam o bloco numerico SEMPRE
893:     * visivel do dump; os outros treze pertencem aos dois blocos que o
894:     * Init/Cmb_Tipo.InteractiveChange do legado mostram/escondem conforme
895:     * o Tipo selecionado - cheque (Say12/Get_TpLeChq/Say14/Chk_Bompara/
896:     * Say15/chk_nominal/Say16/chk_cruzado) e leitor de codigo de barra
897:     * (Say13/Opt_leitor). A alternancia de Visible por Tipo fica para a
898:     * Fase 7 (Cmb_Tipo.InteractiveChange) - aqui todos nascem Visible =
899:     * .T., igual aos controles da Fase 5, porque TornarControlesVisiveis
900:     * (chamado no fim do InicializarForm) forca .T. em tudo mesmo; sem a
901:     * logica de reexibicao ainda implementada, esconder agora so
902:     * deixaria os blocos presos ocultos ate a Fase 7.
903:     *
904:     * Mesmas convencoes da Fase 5: Top ABSOLUTO (sem PageFrame, sem +29),
905:     * ControlSource TRANSCRITO do SCX com o alias trocado (crSigSyCom ->
906:     * cursor_4c_Dados), .Value antes do .ControlSource so para semear o
907:     * TIPO da coluna, Width do Label = gap exato ate o Left do controle
908:     * vizinho (mesma convencao da Fase 5 - conferido contra o dump:
909:     * Say13 e a unica label com Width/Height DECLARADOS no SCX, 80/15,
910:     * usados aqui ao inves do gap calculado).
911:     *
912:     * Say11 ("( 0 - Text , 1- Binary )") eh nota solta, sem controle de
913:     * dados vizinho - Width = 170 (texto + margem), sem gap para calcular.
914:     *
915:     * ZOrderSet = 12 do Say13 no dump eh bookkeeping do Form Designer -
916:     * NAO existe em runtime, DESCARTADO (CLAUDE.md regra #33).
917:     *
918:     * Opt_leitor (OptionGroup, ButtonCount = 3): ControlSource direto em
919:     * coluna numerica (tpbarras numeric(1,0)) grava a ORDEM do botao
920:     * marcado - Value = indice 1-based, SEM +1/-1 (CLAUDE.md regra #45).
921:     * O SCX declara Value = 2 (Teclado pre-selecionado). OptionGroup NAO
922:     * tem BorderStyle (so BackStyle) - regra #33, BorderStyle = 0 do dump
923:     * eh DESCARTADO. Option1.Value = 0 / Option2.Value = 1 no dump sao
924:     * residuo do Form Designer (o Value do GRUPO eh quem manda) e NAO
925:     * sao transcritos nos botoes individuais - atribuir Value != 0 num
926:     * Buttons(N) marca TODOS os botoes ao mesmo tempo (regra sobre
927:     * OptionGroup.Buttons(N).Value espurio).
928:     *==========================================================================
929:     PROTECTED PROCEDURE ConfigurarCamposSecundarios()
930:         *----------------------------------------------------------------------
931:         * Say8 "OutBufferMode : " + Get_outbuf - tamanho do buffer de
932:         * transmissao. Value NUMERICO (outbufs numeric(8,0)).
933:         *----------------------------------------------------------------------

*-- Linhas 968 a 989:
968:             *-- "Tamanho Buffer Transmissao"
969:             .ToolTipText       = "Tamanho Buffer Transmiss" + CHR(227) + "o"
970:             .Visible           = .T.
971:             *-- ControlSource transcrito do SCX legado
972:             *-- (txt_4c_Outbuf.ControlSource = "crSigSyCom.outbufs"). Por
973:             *-- ultimo no bloco: o .Value acima so semeia o TIPO da coluna.
974:             .ControlSource = "cursor_4c_Dados.outbufs"
975:         ENDWITH
976: 
977:         *----------------------------------------------------------------------
978:         * Say9 "InModes : " + Get_inmode  /  Say11 "( 0 - Text , 1- Binary )"
979:         *
980:         * Say11 eh so uma nota explicando o dominio de InModes - sem
981:         * controle associado. Get_inmode.Value NUMERICO (inmodes
982:         * numeric(1,0)); o dominio {0,1} esta documentado na propria
983:         * tela pelo Say11, nao transcrito como InputMask/lista (o legado
984:         * nao declara nenhum dos dois neste campo).
985:         *----------------------------------------------------------------------
986:         THIS.AddObject("lbl_4c_Label9", "Label")
987:         WITH THIS.lbl_4c_Label9
988:             .Top       = 134
989:             .Left      = 394

*-- Linhas 1019 a 1039:
1019:             .Value             = 0
1020:             .ToolTipText       = "Data Type"
1021:             .Visible           = .T.
1022:             *-- ControlSource transcrito do SCX legado
1023:             *-- (txt_4c_Inmode.ControlSource = "crSigSyCom.inmodes").
1024:             .ControlSource = "cursor_4c_Dados.inmodes"
1025:         ENDWITH
1026: 
1027:         THIS.AddObject("lbl_4c_Label11", "Label")
1028:         WITH THIS.lbl_4c_Label11
1029:             .Top       = 135
1030:             .Left      = 475
1031:             .Width     = 170
1032:             .Height    = 15
1033:             .AutoSize  = .F.
1034:             .Alignment = 0
1035:             .WordWrap  = .F.
1036:             .BackStyle = 0
1037:             .FontName  = "Tahoma"
1038:             .FontSize  = 8
1039:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1083 a 1115:
1083:             .ToolTipText       = "No. Caracteres lidos no buffer de recep" + ;
1084:                                   CHR(231) + CHR(227) + "o"
1085:             .Visible           = .T.
1086:             *-- ControlSource transcrito do SCX legado
1087:             *-- (txt_4c_Inlen.ControlSource = "crSigSyCom.inlens").
1088:             .ControlSource = "cursor_4c_Dados.inlens"
1089:         ENDWITH
1090: 
1091:         *----------------------------------------------------------------------
1092:         * BLOCO CONDICIONAL "Cheque" - Say12/Get_TpLeChq (tipo de leitora
1093:         * de cheque), Say14/Chk_Bompara, Say15/chk_nominal, Say16/
1094:         * chk_cruzado. O legado so exibe este bloco quando Tipos =
1095:         * 'Leitora Cheques' ou 'Impressora de Cheque' (Fase 7).
1096:         *
1097:         * Get_TpLeChq: ComboBox Style = 2 (dropdown list), RowSourceType = 1
1098:         * com RowSource NAO VAZIO - a lista de itens vem do proprio
1099:         * RowSource (diferente de Cmb_Hand/Cmb_Tipo, que tem RowSource
1100:         * vazio e recebem os itens via .AddItem no Init). ControlSource
1101:         * char(1) (tplechqs): o valor gravado eh a INICIAL de cada item
1102:         * (T/S/P/M/C/K/H/U), TRANSCRITO LITERAL do dump - inclusive o
1103:         * item "P" sem descricao, que o legado tambem nao descreve.
1104:         *----------------------------------------------------------------------
1105:         THIS.AddObject("lbl_4c_Label12", "Label")
1106:         WITH THIS.lbl_4c_Label12
1107:             .Top       = 185
1108:             .Left      = 345
1109:             .Width     = 105
1110:             .Height    = 15
1111:             .AutoSize  = .F.
1112:             .Alignment = 0
1113:             .WordWrap  = .F.
1114:             .BackStyle = 0
1115:             .FontName  = "Tahoma"

*-- Linhas 1142 a 1162:
1142:             *-- Value CHARACTER: coluna tplechqs char(1)
1143:             .Value             = ""
1144:             .Visible           = .T.
1145:             *-- ControlSource transcrito do SCX legado
1146:             *-- (cbo_4c_Get_TpLeChq.ControlSource = "crSigSyCom.TpLeChqs").
1147:             .ControlSource = "cursor_4c_Dados.tplechqs"
1148:         ENDWITH
1149: 
1150:         THIS.AddObject("lbl_4c_Label14", "Label")
1151:         WITH THIS.lbl_4c_Label14
1152:             .Top       = 231
1153:             .Left      = 390
1154:             .Width     = 59
1155:             .Height    = 15
1156:             .AutoSize  = .F.
1157:             .Alignment = 0
1158:             .WordWrap  = .F.
1159:             .BackStyle = 0
1160:             .FontName  = "Tahoma"
1161:             .FontSize  = 8
1162:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1183 a 1203:
1183:             *-- sobre coluna numerica grava 0/1 (nao eh indice 1-based).
1184:             .Value     = 0
1185:             .Visible   = .T.
1186:             *-- ControlSource transcrito do SCX legado
1187:             *-- (chk_4c_Chk_Bompara.ControlSource = "crSigSyCom.bompara").
1188:             .ControlSource = "cursor_4c_Dados.bompara"
1189:         ENDWITH
1190: 
1191:         THIS.AddObject("lbl_4c_Label15", "Label")
1192:         WITH THIS.lbl_4c_Label15
1193:             .Top       = 248
1194:             .Left      = 398
1195:             .Width     = 51
1196:             .Height    = 15
1197:             .AutoSize  = .F.
1198:             .Alignment = 0
1199:             .WordWrap  = .F.
1200:             .BackStyle = 0
1201:             .FontName  = "Tahoma"
1202:             .FontSize  = 8
1203:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1223 a 1243:
1223:             *-- Value NUMERICO: coluna nominal numeric(1,0)
1224:             .Value     = 0
1225:             .Visible   = .T.
1226:             *-- ControlSource transcrito do SCX legado
1227:             *-- (chk_4c_Chk_nominal.ControlSource = "crSigSyCom.nominal").
1228:             .ControlSource = "cursor_4c_Dados.nominal"
1229:         ENDWITH
1230: 
1231:         THIS.AddObject("lbl_4c_Label16", "Label")
1232:         WITH THIS.lbl_4c_Label16
1233:             .Top       = 264
1234:             .Left      = 395
1235:             .Width     = 54
1236:             .Height    = 15
1237:             .AutoSize  = .F.
1238:             .Alignment = 0
1239:             .WordWrap  = .F.
1240:             .BackStyle = 0
1241:             .FontName  = "Tahoma"
1242:             .FontSize  = 8
1243:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1263 a 1283:
1263:             *-- Value NUMERICO: coluna cruzado numeric(1,0)
1264:             .Value     = 0
1265:             .Visible   = .T.
1266:             *-- ControlSource transcrito do SCX legado
1267:             *-- (chk_4c_Chk_cruzado.ControlSource = "crSigSyCom.cruzado").
1268:             .ControlSource = "cursor_4c_Dados.cruzado"
1269:         ENDWITH
1270: 
1271:         *----------------------------------------------------------------------
1272:         * BLOCO CONDICIONAL "Leitor de Codigo de Barra" - Say13/Opt_leitor.
1273:         * O legado exibe quando Tipos = 'Leitora Codigo Barra' ou
1274:         * 'Leitora Cheques' (e tambem 'Impressora de Cheque' no
1275:         * InteractiveChange - Fase 7).
1276:         *
1277:         * Say13.Width/Height (80/15) vem DECLARADOS no dump - usados
1278:         * direto, ao inves do gap calculado (CLAUDE.md regra #23: usar o
1279:         * que o SCX declara). ZOrderSet = 12 do dump eh bookkeeping do
1280:         * Form Designer e NAO existe em runtime - DESCARTADO (regra #33).
1281:         *----------------------------------------------------------------------
1282:         THIS.AddObject("lbl_4c_Label13", "Label")
1283:         WITH THIS.lbl_4c_Label13

*-- Linhas 1297 a 1315:
1297:         ENDWITH
1298: 
1299:         *-- Opt_leitor: OptionGroup de 3 botoes (Serial/Teclado/Paralelo),
1300:         *-- ControlSource direto em tpbarras numeric(1,0). BorderStyle do
1301:         *-- dump eh DESCARTADO (OptionGroup nao tem essa propriedade -
1302:         *-- regra #33); so .BackStyle eh transcrito.
1303:         THIS.AddObject("obj_4c_Opt_leitor", "OptionGroup")
1304:         WITH THIS.obj_4c_Opt_leitor
1305:             .Top         = 209
1306:             .Left        = 445
1307:             .Width       = 205
1308:             .Height      = 24
1309:             .ButtonCount = 3
1310:             .AutoSize    = .F.
1311:             .BackStyle   = 0
1312:             .TabIndex    = 12
1313:             .Visible     = .T.
1314: 
1315:             WITH .Buttons(1)

*-- Linhas 1350 a 1371:
1350: 
1351:             *-- Value = indice 1-based do botao marcado (2 = Teclado, o
1352:             *-- default do SCX). Por ultimo no bloco, junto do
1353:             *-- ControlSource transcrito do SCX legado
1354:             *-- (obj_4c_Opt_leitor.ControlSource = "crSigSyCom.tpBarras").
1355:             .Value         = 2
1356:             .ControlSource = "cursor_4c_Dados.tpbarras"
1357:         ENDWITH
1358:     ENDPROC
1359: 
1360:     *==========================================================================
1361:     * ConfigurarEventos - Liga os eventos dos campos desta fase
1362:     *
1363:     * O legado tem UM unico evento sobre os campos: o
1364:     * Cmb_Tipo.InteractiveChange (SECAO 3 do dump, objeto SIGOPCPE.Cmb_Tipo).
1365:     * Eh ele que torna a tela utilizavel - sem ele o usuario escolhe o
1366:     * dispositivo no combo e NADA acontece: o cursor fica na linha em que o
1367:     * CarregarDados o deixou e todos os campos continuam mostrando (e
1368:     * gravando) a configuracao de OUTRO aparelho.
1369:     *
1370:     * InteractiveChange eh evento normal e aceita BINDEVENT - ao contrario do
1371:     * Valid em TextBox, que nao dispara (CLAUDE.md regra #3). Nao passa

*-- Linhas 1412 a 1430:
1412:     *   EndIf
1413:     *   <esconde os 10 controles condicionais e reexibe conforme Tipos>
1414:     *
1415:     * O combo eh o UNICO controle da tela sem ControlSource (tambem no
1416:     * legado): ele nao grava nada, so RESOLVE qual linha do cursor_4c_Dados
1417:     * os demais campos passam a exibir e editar.
1418:     *
1419:     * O SEEK usa PADR(valor, 20) porque a tag PesqTipo indexa tipos
1420:     * char(20): chave de largura fixa casa exato tanto sob SET EXACT ON
1421:     * quanto sob SET EXACT OFF - e este form tem DataSession = 2, que
1422:     * devolve os SET ao default do VFP, entao depender do valor global
1423:     * seria aposta. Eh o mesmo PADR(...,20) com que o
1424:     * SIGOPCPEBO.CarregarDados semeia e procura as linhas.
1425:     *
1426:     * O Refresh so acontece quando o SEEK ACHA a linha, igual ao legado -
1427:     * tipo inexistente na tabela deixa os campos como estavam, em vez de
1428:     * repintar com o registro errado. A alternancia de visibilidade roda
1429:     * SEMPRE, achando ou nao, tambem como no legado: ela le o Tipos da linha
1430:     * CORRENTE, qualquer que seja.

*-- Linhas 1444 a 1462:
1444: 
1445:             IF USED("cursor_4c_Dados") AND !EMPTY(loc_cTipo)
1446:                 IF SEEK(PADR(loc_cTipo, 20), "cursor_4c_Dados", "PesqTipo")
1447:                     *-- Linha achada: os campos ligados por ControlSource
1448:                     *-- passam a mostrar a configuracao deste aparelho. O BO
1449:                     *-- acompanha a linha corrente (equivalente, na
1450:                     *-- arquitetura em camadas, ao cursor unico que o
1451:                     *-- poDataMgr do legado grava inteiro).
1452:                     *--
1453:                     *-- FASE 8: o repintar passou a ser BOParaForm(), que
1454:                     *-- percorre os 15 controles a partir das properties do
1455:                     *-- BO com as conversoes de tipo explicitas - fonte unica
1456:                     *-- com a recarga feita pelo CarregarLista(), que chama o
1457:                     *-- mesmo metodo. O [Thisform.Refresh] do legado continua
1458:                     *-- aqui, DEPOIS, para repintar tambem o que nao passa
1459:                     *-- pelo mapeamento (labels e os dois blocos de botao).
1460:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
1461:                         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
1462:                         THIS.BOParaForm()

*-- Linhas 1551 a 1571:
1551:     *==========================================================================
1552:     * BtnConfirmarClick - FASE 7 - transcricao do SIGOPCPE.Ok.Click
1553:     *
1554:     *   If Not ThisForm.poDataMgr.Update('crSigSyCom')
1555:     *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ;
1556:     *                   'Falha na Conexao (Update - SigSyCom)')
1557:     *       Return 0
1558:     *   EndIf
1559:     *   If (ThisForm.poDataMgr.Commit() < 1)
1560:     *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ;
1561:     *                   'Falha na Conexao (Commit)')
1562:     *       Return 0
1563:     *   EndIf
1564:     *   =fGrvSettings('CrSigSyCom')
1565:     *   Thisform.Release
1566:     *
1567:     * Os TRES passos do legado, na mesma ordem e com os mesmos caminhos de
1568:     * falha: cada [Return 0] ABORTA deixando a tela ABERTA (o usuario corrige
1569:     * e tenta de novo), e so o caminho inteiro bem-sucedido fecha o form.
1570:     *
1571:     * O passo 2 (Commit) eh um passo com caminho de falha PROPRIO, nao

*-- Linhas 1608 a 1652:
1608:         LOCAL loc_lProsseguir
1609: 
1610:         *-- FASE 8 - Passo 0: descarrega a tela na linha CORRENTE do cursor
1611:         *-- antes de gravar. No legado isso eh efeito do ControlSource (o
1612:         *-- controle grava no cursor ao perder o foco, e acionar o botao faz
1613:         *-- o campo perder o foco); o FormParaBO repete o REPLACE de forma
1614:         *-- explicita, cobrindo a edicao ainda nao confirmada no campo em que o
1615:         *-- usuario estava.
1616:         *--
1617:         *-- O retorno .F. NAO aborta a gravacao, e isso eh deliberado: ele
1618:         *-- significa apenas "nao havia linha corrente para descarregar"
1619:         *-- (cursor em EOF). O legado grava o cursor INTEIRO, entao as 6
1620:         *-- linhas semeadas tem de ser gravadas mesmo que o usuario abra a
1621:         *-- tela e clique Confirmar sem escolher dispositivo nenhum - que eh
1622:         *-- exatamente o estado da abertura, com o Cmb_Tipo em branco.
1623:         *-- Abortar aqui faria a tela recusar justamente a primeira gravacao.
1624:         THIS.FormParaBO()
1625: 
1626:         *-- Passo 1 - equivalente ao poDataMgr.Update('crSigSyCom'): joga o
1627:         *-- cursor INTEIRO de volta para SigSyCom.
1628:         loc_lProsseguir = THIS.GravarTodosOsTipos()
1629: 
1630:         IF !loc_lProsseguir
1631:             *-- A falha JA foi mostrada com o texto do SQL Server pelo
1632:             *-- BusinessBase/BO (CLAUDE.md regra #20); a mensagem generica do
1633:             *-- legado so sai quando nada mais apareceu, para nao empilhar
1634:             *-- dois dialogos dizendo a mesma coisa.
1635:             IF !THIS.this_oBusinessObject.this_lErroExibido
1636:                 MsgErro("Favor Reinicializar o Processo!!!", ;
1637:                         "Falha na Conex" + CHR(227) + "o (Update - SigSyCom)")
1638:             ENDIF
1639:         ELSE
1640:             *-- Passo 2 - equivalente ao poDataMgr.Commit() < 1
1641:             IF !THIS.ConfirmarTransacao()
1642:                 MsgErro("Favor Reinicializar o Processo!!!", ;
1643:                         "Falha na Conex" + CHR(227) + "o (Commit)")
1644:             ELSE
1645:                 *-- Passo 3 - fGrvSettings: ver PERDA DOCUMENTADA no
1646:                 *-- cabecalho deste metodo.
1647:                 *-- Passo 4 - [Thisform.Release] do legado.
1648:                 THIS.Release()
1649:             ENDIF
1650:         ENDIF
1651:     ENDPROC
1652: 

*-- Linhas 1662 a 1706:
1662:     *
1663:     * Sair SEM gravar DESCARTA as alteracoes, exatamente como no legado, e
1664:     * isso acontece sozinho: o que o usuario digita vai para o cursor
1665:     * cursor_4c_Dados (ControlSource), e quem leva o cursor para o banco eh
1666:     * SO o BtnConfirmarClick. Nada a desfazer aqui - por isso nao ha
1667:     * CancelarEdicao() nem TABLEREVERT: o cursor morre com o form, no
1668:     * Destroy, e TABLEREVERT em cursor sem buffering dispara erro 1586
1669:     * (CLAUDE.md regra #52).
1670:     *
1671:     * Release() e nao Hide(): este eh form de topo, aberto pelo menu, sem
1672:     * form pai esperando ler propriedade depois do fechamento.
1673:     *
1674:     * PUBLIC (sem PROTECTED) porque eh delegado de BINDEVENT (regra #3).
1675:     *==========================================================================
1676:     PROCEDURE BtnEncerrarClick()
1677:         THIS.Release()
1678:     ENDPROC
1679: 
1680:     *==========================================================================
1681:     * GravarTodosOsTipos - equivalente ao poDataMgr.Update('crSigSyCom')
1682:     *
1683:     * No legado o Update eh um TABLEUPDATE sobre o cursor bufferizado INTEIRO:
1684:     * ele grava TODAS as linhas de uma vez - INSERT nas que o Init
1685:     * acrescentou (os tipos de dispositivo que ainda nao existiam na tabela)
1686:     * e UPDATE nas que o usuario editou. Por isso aqui tambem se percorre o
1687:     * cursor TODO, e nao apenas a linha que o Cmb_Tipo deixou corrente: quem
1688:     * troca de dispositivo, mexe em dois e clica Confirmar tem de ver os dois
1689:     * gravados - gravar so a linha corrente perderia a outra em silencio.
1690:     *
1691:     * INSERT ou UPDATE se decide pela PK cidchaves: as linhas semeadas pelo
1692:     * SIGOPCPEBO.CarregarDados nascem com cidchaves novo (fUniqueIds) e ainda
1693:     * NAO existem na tabela. A fotografia das chaves ja gravadas eh UMA ida ao
1694:     * banco (nao uma por linha), feita no inicio.
1695:     *
1696:     * NovoRegistro() vem ANTES do CarregarDoCursor de proposito: ele chama
1697:     * LimparDados(), que hoje na BusinessBase so limpa a mensagem de erro, mas
1698:     * que uma subclasse pode passar a usar para zerar as properties - na ordem
1699:     * inversa a limpeza apagaria os valores recem-lidos do cursor.
1700:     *
1701:     * Quem grava eh Salvar() (PUBLIC na BusinessBase), nao Inserir()/
1702:     * Atualizar() direto: assim passam os hooks ValidarDados/AntesDeGravar/
1703:     * DepoisDeGravar e a auditoria, e a falha NUNCA fica muda (regra #20).
1704:     *
1705:     * Na PRIMEIRA falha o laco PARA (EXIT) - igual ao [Return 0] do legado,
1706:     * que aborta sem tentar o resto. EXIT dentro de TRY eh seguro; RETURN nao

*-- Linhas 1737 a 1833:
1737:         IF loc_lProsseguir AND !USED(loc_cAlias)
1738:             MsgErro("Cursor de trabalho n" + CHR(227) + "o dispon" + CHR(237) + ;
1739:                     "vel - reabra a tela.", ;
1740:                     "Falha na Conex" + CHR(227) + "o (Update - SigSyCom)")
1741:             THIS.this_oBusinessObject.this_lErroExibido = .T.
1742:             loc_lProsseguir = .F.
1743:         ENDIF
1744: 
1745:         IF loc_lProsseguir
1746:             TRY
1747:                 *-- Fotografia das PKs ja gravadas em SigSyCom.
1748:                 IF USED(loc_cAliasChaves)
1749:                     USE IN (loc_cAliasChaves)
1750:                 ENDIF
1751: 
1752:                 IF SQLEXEC(gnConnHandle, "SELECT cidchaves FROM SigSyCom", ;
1753:                            loc_cAliasChaves) > 0
1754:                     SELECT (loc_cAlias)
1755:                     loc_nTotal     = RECCOUNT(loc_cAlias)
1756:                     loc_lResultado = .T.
1757: 
1758:                     FOR loc_nI = 1 TO loc_nTotal
1759:                         *-- Reposicionamento EXPLICITO a cada volta: o LOCATE
1760:                         *-- abaixo e o SQLEXEC do BO trabalham em outras areas,
1761:                         *-- e CarregarDoCursor le a linha CORRENTE do alias.
1762:                         SELECT (loc_cAlias)
1763:                         GO loc_nI
1764: 
1765:                         *-- tipos eh a chave de negocio char(20) NOT NULL: linha
1766:                         *-- sem tipo nao existe no legado (o Init semeia os 6) e
1767:                         *-- nao teria como ser gravada.
1768:                         IF EMPTY(ALLTRIM(NVL(cursor_4c_Dados.tipos, "")))
1769:                             LOOP
1770:                         ENDIF
1771: 
1772:                         loc_cChave  = ALLTRIM(NVL(cursor_4c_Dados.cidchaves, ""))
1773:                         loc_lExiste = .F.
1774: 
1775:                         IF !EMPTY(loc_cChave) AND USED(loc_cAliasChaves)
1776:                             SELECT (loc_cAliasChaves)
1777:                             LOCATE FOR ALLTRIM(NVL(cidchaves, "")) == loc_cChave
1778:                             loc_lExiste = FOUND()
1779:                         ENDIF
1780: 
1781:                         SELECT (loc_cAlias)
1782:                         GO loc_nI
1783: 
1784:                         IF loc_lExiste
1785:                             THIS.this_oBusinessObject.CarregarDoCursor(loc_cAlias)
1786:                             THIS.this_oBusinessObject.EditarRegistro()
1787:                         ELSE
1788:                             THIS.this_oBusinessObject.NovoRegistro()
1789:                             THIS.this_oBusinessObject.CarregarDoCursor(loc_cAlias)
1790:                         ENDIF
1791: 
1792:                         IF !THIS.this_oBusinessObject.Salvar()
1793:                             loc_lResultado = .F.
1794:                             EXIT
1795:                         ENDIF
1796:                     ENDFOR
1797: 
1798:                     IF USED(loc_cAliasChaves)
1799:                         USE IN (loc_cAliasChaves)
1800:                     ENDIF
1801: 
1802:                     *-- Devolve a linha corrente ao tipo que esta na tela: o
1803:                     *-- laco varreu o cursor e os campos sao ligados a ele por
1804:                     *-- ControlSource - sem isto a tela passaria a exibir a
1805:                     *-- ULTIMA linha percorrida, e nao o dispositivo escolhido
1806:                     *-- no Cmb_Tipo.
1807:                     SELECT (loc_cAlias)
1808:                     IF !EMPTY(ALLTRIM(THIS.this_cTipoSelecionado))
1809:                         IF SEEK(PADR(ALLTRIM(THIS.this_cTipoSelecionado), 20), ;
1810:                                 loc_cAlias, "PesqTipo")
1811:                             THIS.Refresh()
1812:                         ENDIF
1813:                     ENDIF
1814:                 ELSE
1815:                     THIS.this_cMensagemErro = CapturarErroSQL()
1816:                     MsgErro("Erro ao conferir os registros j" + CHR(225) + ;
1817:                             " gravados:" + CHR(13) + THIS.this_cMensagemErro, ;
1818:                             "Falha na Conex" + CHR(227) + "o (Update - SigSyCom)")
1819:                     THIS.this_oBusinessObject.this_lErroExibido = .T.
1820:                     loc_lResultado = .F.
1821:                 ENDIF
1822: 
1823:             CATCH TO loc_oErro
1824:                 THIS.this_cMensagemErro = loc_oErro.Message
1825:                 MsgErro(loc_oErro.Message + CHR(13) + ;
1826:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1827:                         "Procedure: " + loc_oErro.Procedure, ;
1828:                         "Erro em FormSIGOPCPE.GravarTodosOsTipos")
1829:                 THIS.this_oBusinessObject.this_lErroExibido = .T.
1830:                 loc_lResultado = .F.
1831:             ENDTRY
1832:         ENDIF
1833: 

*-- Linhas 1877 a 1911:
1877:     *
1878:     *   .AddCursor('SigSyCom','Tipos','crSigSyCom','','',lcQryCFis)
1879:     *   .poDataMgr.ReQuery('crSigSyCom')
1880:     *   Select crSigSyCom / Index On Tipos Tag PesqTipo / Go Top
1881:     *   <semeia os 6 tipos que faltarem + Settings default 9600,n,8,1>
1882:     *
1883:     * O trabalho em si fica no SIGOPCPEBO.CarregarDados (camada de dados); o
1884:     * que esta fase acrescenta eh o FUNIL: ANTES o InicializarForm chamava
1885:     * CarregarDados direto, e qualquer recarga futura teria de repetir a mao o
1886:     * reposicionamento e o repintar. Com o funil, recarregar a tela passa a
1887:     * ter UM caminho so - o cursor volta posicionado no dispositivo que esta
1888:     * na tela (e nao na primeira linha), o BO acompanha a linha corrente e os
1889:     * campos sao repintados. Metodo unico eh a mesma exigencia que a regra
1890:     * #21 faz para grade e a regra #45 para dependencia entre campos.
1891:     *
1892:     * Chamado em DOIS momentos com exigencias opostas, e por isso o repintar
1893:     * eh GUARDADO:
1894:     *   - do InicializarForm, ANTES de ConfigurarCamposPrincipais: o cursor
1895:     *     TEM de existir e estar posicionado antes dos controles, porque eles
1896:     *     sao ligados a ele por ControlSource e binding para alias fechado
1897:     *     derruba o Init inteiro (CLAUDE.md regra #41). Nesse momento
1898:     *     cbo_4c_Cmb_Tipo ainda NAO existe, o BOParaForm eh pulado e o combo
1899:     *     permanece em branco - que eh o estado REAL do legado na abertura
1900:     *     (o With do Init faz .ListIndex = 1 ANTES do .Clear, e o Clear zera
1901:     *     o ListIndex).
1902:     *   - de uma recarga com a tela montada: ai os controles existem e o
1903:     *     BOParaForm repinta.
1904:     * PEMSTATUS(THIS, "<nome>", 5) responde exatamente essa pergunta -
1905:     * "o AddObject ja rodou?" -, que eh checagem de EXISTENCIA e nao de
1906:     * escopo (o uso que as regras #3/#34 proibem eh o oposto: confiar nele
1907:     * para saber se um membro eh alcancavel).
1908:     *
1909:     * SEEK que FALHA deixa o ponteiro em EOF no VFP9; por isso o GO TOP de
1910:     * reserva no ramo de falha, para a tela nunca ficar sem linha corrente
1911:     * numa recarga (os 6 itens do combo sao os 6 tipos que CarregarDados

*-- Linhas 1931 a 1959:
1931:             IF loc_lResultado AND USED("cursor_4c_Dados")
1932:                 loc_cTipo = ALLTRIM(THIS.this_cTipoSelecionado)
1933: 
1934:                 SELECT cursor_4c_Dados
1935: 
1936:                 IF EMPTY(loc_cTipo)
1937:                     *-- Abertura: [Go Top] do legado.
1938:                     GO TOP
1939:                 ELSE
1940:                     *-- Recarga: volta para o dispositivo que esta na tela.
1941:                     *-- PADR(...,20) porque tipos eh char(20) e o padding faz
1942:                     *-- parte da chave do indice PesqTipo (regra #42).
1943:                     IF !SEEK(PADR(loc_cTipo, 20), "cursor_4c_Dados", "PesqTipo")
1944:                         SELECT cursor_4c_Dados
1945:                         GO TOP
1946:                     ENDIF
1947:                 ENDIF
1948: 
1949:                 IF !EOF("cursor_4c_Dados") AND VARTYPE(THIS.this_oBusinessObject) = "O"
1950:                     THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
1951:                 ENDIF
1952: 
1953:                 *-- Repinta SO se os controles ja existem (ver cabecalho).
1954:                 IF PEMSTATUS(THIS, "cbo_4c_Cmb_Tipo", 5)
1955:                     THIS.BOParaForm()
1956:                 ENDIF
1957:             ENDIF
1958: 
1959:         CATCH TO loc_oErro

*-- Linhas 1971 a 2018:
1971:     *==========================================================================
1972:     * BOParaForm - FASE 8 - propriedades do BO -> controles da tela
1973:     *
1974:     * Os 15 controles de dados sao ligados por ControlSource a linha corrente
1975:     * do cursor_4c_Dados (transcricao do legado, que liga cada controle a
1976:     * crSigSyCom.<coluna>), entao o cursor eh o BUFFER DE EDICAO e o VFP9 ja
1977:     * mantem controle e linha em sincronia. Este metodo nao substitui esse
1978:     * mecanismo: ele fecha o circuito da arquitetura em camadas, deixando as
1979:     * properties do BO - que sao o que a camada de dados grava - como a fonte
1980:     * do que a tela mostra. Como as properties acabaram de ser lidas DESSA
1981:     * MESMA linha pelo CarregarDoCursor, cada atribuicao abaixo escreve de
1982:     * volta o valor que ja estava lah: nao ha como as duas versoes divergirem.
1983:     *
1984:     * Mapeamento COMPLETO - os 15 controles com ControlSource mais o seletor:
1985:     *
1986:     *   cbo_4c_Cmb_Tipo      (seletor, SEM ControlSource)  <- this_cTipos
1987:     *   obj_4c_Spinner1      portas    numeric(1,0)        <- this_nPortas
1988:     *   cbo_4c_Cmb_Hand      hands     char(20)            <- this_cHands
1989:     *   txt_4c_Set           settings  char(20)            <- this_cSettings
1990:     *   chk_4c_Chk_dtr       dtrs      bit    -> LOGICO    <- this_lDtrs
1991:     *   chk_4c_Chk_rts       rtss      bit    -> LOGICO    <- this_lRtss
1992:     *   txt_4c_Inbuf         inbufs    numeric(8,0)        <- this_nInbufs
1993:     *   txt_4c_Outbuf        outbufs   numeric(8,0)        <- this_nOutbufs
1994:     *   txt_4c_Inmode        inmodes   numeric(1,0)        <- this_nInmodes
1995:     *   txt_4c_Inlen         inlens    numeric(8,0)        <- this_nInlens
1996:     *   cbo_4c_Get_TpLeChq   tplechqs  char(1)             <- this_cTplechqs
1997:     *   chk_4c_Chk_Bompara   bompara   numeric(1,0)        <- this_nBompara
1998:     *   chk_4c_Chk_nominal   nominal   numeric(1,0)        <- this_nNominal
1999:     *   chk_4c_Chk_cruzado   cruzado   numeric(1,0)        <- this_nCruzado
2000:     *   obj_4c_Opt_leitor    tpbarras  numeric(1,0)        <- this_nTpbarras
2001:     *
2002:     * cidchaves (PK) e nomeimp char(40) NAO tem controle no SCX e por isso
2003:     * nao aparecem aqui - quem cuida das duas eh o INSERT/UPDATE do BO, que
2004:     * precisa cobri-las porque sao NOT NULL (CLAUDE.md regra #22).
2005:     *
2006:     * TIPOS, nos dois sentidos (CheckBox ligado a coluna exige conversao
2007:     * EXPLICITA - o .Value assume o tipo do campo ligado):
2008:     *   - dtrs/rtss sao bit do SQL Server e chegam como LOGICO, logo os dois
2009:     *     CheckBox operam sobre logico -> ConverterParaLogico().
2010:     *   - bompara/nominal/cruzado sao numeric(1,0), logo esses CheckBox
2011:     *     operam sobre numerico {0,1} -> IIF(ConverterParaLogico(...), 1, 0),
2012:     *     que tolera as duas formas sem supor qual o driver entregou.
2013:     *
2014:     * SELETOR por ListIndex e nao por .Value: com Style = 2 e
2015:     * RowSourceType = 1, atribuir um .Value que nao esta na lista deixa o
2016:     * combo em estado ambiguo (ListIndex = 0 com texto solto). Procurar o
2017:     * item e marcar o ListIndex eh deterministico - e tipo FORA da lista dos
2018:     * 6 (linha extra que alguem tenha gravado na tabela) cai em

*-- Linhas 2050 a 2068:
2050: 
2051:                 loc_oBO = THIS.this_oBusinessObject
2052: 
2053:                 *-- SELETOR - Cmb_Tipo, o unico controle sem ControlSource
2054:                 loc_cTipo   = ALLTRIM(NVL(loc_oBO.this_cTipos, ""))
2055:                 loc_nIndice = 0
2056: 
2057:                 FOR loc_nI = 1 TO THIS.cbo_4c_Cmb_Tipo.ListCount
2058:                     IF ALLTRIM(THIS.cbo_4c_Cmb_Tipo.List(loc_nI)) == loc_cTipo
2059:                         loc_nIndice = loc_nI
2060:                         EXIT
2061:                     ENDIF
2062:                 ENDFOR
2063: 
2064:                 *-- Atribui SO quando muda de verdade: este metodo tambem eh
2065:                 *-- chamado de DENTRO do InteractiveChange do proprio combo
2066:                 *-- (pelo ValidarTipo), e reescrever o ListIndex no meio da
2067:                 *-- interacao nao tem efeito util nenhum - o item ja eh o que
2068:                 *-- o usuario acabou de escolher.

*-- Linhas 2123 a 2166:
2123:     * esta no cabecalho dele). Dois passos, nesta ordem:
2124:     *
2125:     *   1. REPLACE dos valores da tela na linha CORRENTE do cursor_4c_Dados.
2126:     *      Eh o mesmo efeito que o ControlSource produz quando o controle
2127:     *      perde o foco, e serve de rede para o unico caso em que isso pode
2128:     *      nao ter acontecido ainda: a edicao que o usuario deixou sem confirmar
2129:     *      no campo em que estava ao acionar o botao.
2130:     *   2. CarregarDoCursor, que repassa a linha as properties do BO.
2131:     *
2132:     * Fazer tela -> cursor -> BO (e nao tela -> BO) eh o que garante UMA
2133:     * fonte: quem grava eh o GravarTodosOsTipos, que percorre o cursor
2134:     * INTEIRO linha a linha chamando CarregarDoCursor (o legado faz o mesmo
2135:     * com poDataMgr.Update('crSigSyCom'), que eh um TABLEUPDATE do cursor
2136:     * inteiro). Se este metodo escrevesse so nas properties, o laco as
2137:     * sobrescreveria com o conteudo do cursor e o trabalho dele seria
2138:     * descartado em silencio - exatamente o tipo de divergencia muda que a
2139:     * regra #45 manda evitar com fonte unica.
2140:     *
2141:     * TIPOS no caminho de volta: ConverterParaNumero nas colunas numericas
2142:     * (devolve o proprio valor quando ja eh numerico) e ConverterParaLogico
2143:     * nas bit; os tres CheckBox sobre numeric(1,0) viram {0,1} com
2144:     * IIF(ConverterParaLogico(...), 1, 0), que aceita .Value logico ou
2145:     * numerico sem supor o que o driver entregou. tpbarras vai DIRETO, sem
2146:     * +1/-1 e sem promover 0 (regra #45).
2147:     *
2148:     * tipos NAO eh gravado por este metodo, e isso eh fidelidade: no legado o
2149:     * Cmb_Tipo nao tem ControlSource - ele escolhe QUAL linha a tela edita,
2150:     * nunca renomeia o dispositivo. cidchaves e nomeimp tambem ficam de fora
2151:     * por nao terem controle no SCX (quem as cobre eh o INSERT do BO).
2152:     *
2153:     * Linha corrente AUSENTE (cursor fechado ou em EOF) devolve .F. SEM
2154:     * escrever nada - REPLACE em EOF nao tem alvo. No VFP9 um SEEK que falha
2155:     * deixa o ponteiro justamente em EOF, e o legado tem esse mesmo
2156:     * comportamento no [If Seek(...)] do InteractiveChange.
2157:     *
2158:     * PROTECTED pelo MESMO motivo do BOParaForm: o FormBase declara
2159:     * [PROTECTED PROCEDURE FormParaBO()] (formbase.prg:285) e o PROTECTED da
2160:     * base prevalece sobre o override. O unico chamador eh o
2161:     * BtnConfirmarClick, com THIS. (regra #8).
2162:     *==========================================================================
2163:     PROTECTED FUNCTION FormParaBO()
2164:         LOCAL loc_lResultado, loc_oErro
2165:         LOCAL loc_nPortas, loc_cHands, loc_cSettings, loc_lDtrs, loc_lRtss
2166:         LOCAL loc_nInbufs, loc_nOutbufs, loc_nInmodes, loc_nInlens

*-- Linhas 2202 a 2220:
2202:                     *-- Indice 1-based do OptionGroup, DIRETO
2203:                     loc_nTpbarras = ConverterParaNumero(THIS.obj_4c_Opt_leitor.Value)
2204: 
2205:                     SELECT cursor_4c_Dados
2206:                     REPLACE portas   WITH loc_nPortas, ;
2207:                             hands    WITH loc_cHands, ;
2208:                             settings WITH loc_cSettings, ;
2209:                             dtrs     WITH loc_lDtrs, ;
2210:                             rtss     WITH loc_lRtss, ;
2211:                             inbufs   WITH loc_nInbufs, ;
2212:                             outbufs  WITH loc_nOutbufs, ;
2213:                             inmodes  WITH loc_nInmodes, ;
2214:                             inlens   WITH loc_nInlens, ;
2215:                             tplechqs WITH loc_cTplechqs, ;
2216:                             bompara  WITH loc_nBompara, ;
2217:                             nominal  WITH loc_nNominal, ;
2218:                             cruzado  WITH loc_nCruzado, ;
2219:                             tpbarras WITH loc_nTpbarras ;
2220:                         IN cursor_4c_Dados


### BO (C:\4c\projeto\app\classes\SIGOPCPEBO.prg):
*==============================================================================
* SIGOPCPEBO.prg - Business Object para Porta de Comunicacao (SIGOPCPE)
*
* Form OPERACIONAL de configuracao de hardware serial/paralelo.
* Tabela principal: SigSyCom (chave primaria: cidchaves char(20))
*
* Legado: SIGOPCPE.SCX - o Init() carrega TODA a tabela num cursor
* (crSigSyCom, query [Select * From SigSyCom]), indexa por Tipos
* (tag PesqTipo) e GARANTE a existencia dos 6 registros fixos de tipo de
* dispositivo, inserindo os que faltarem com Tipos + CidChaves = fUniqueIds()
* e repondo Settings = '9600,n,8,1' quando chega vazio. O usuario escolhe o
* dispositivo no Cmb_Tipo (que NAO tem ControlSource - ele apenas reposiciona
* o cursor via SEEK) e edita os campos da linha corrente; o botao Ok grava com
* poDataMgr.Update('crSigSyCom') + Commit() + fGrvSettings('CrSigSyCom').
*
* Mapeamento ControlSource legado -> propriedade (todas as 17 colunas de
* SigSyCom sao NOT NULL - ver docs/schema.sql):
*   Spinner1     -> crSigSyCom.portas    -> this_nPortas     numeric(1,0)
*   Cmb_Hand     -> crSigSyCom.hands     -> this_cHands      char(20)
*   Get_Set      -> crSigSyCom.settings  -> this_cSettings   char(20)
*   chk_dtr      -> crSigSyCom.dtrs      -> this_lDtrs       bit
*   chk_rts      -> crSigSyCom.rtss      -> this_lRtss       bit
*   Get_inbuf    -> crSigSyCom.inbufs    -> this_nInbufs     numeric(8,0)
*   Get_outbuf   -> crSigSyCom.outbufs   -> this_nOutbufs    numeric(8,0)
*   Get_inmode   -> crSigSyCom.inmodes   -> this_nInmodes    numeric(1,0)
*   Get_inlen    -> crSigSyCom.inlens    -> this_nInlens     numeric(8,0)
*   Get_TpLeChq  -> crSigSyCom.TpLeChqs  -> this_cTplechqs   char(1)
*   Opt_leitor   -> crSigSyCom.tpBarras  -> this_nTpbarras   numeric(1,0)
*   Chk_Bompara  -> crSigSyCom.bompara   -> this_nBompara    numeric(1,0)
*   chk_nominal  -> crSigSyCom.nominal   -> this_nNominal    numeric(1,0)
*   chk_cruzado  -> crSigSyCom.cruzado   -> this_nCruzado    numeric(1,0)
*   Cmb_Tipo     -> (sem ControlSource)  -> this_cTipos      char(20)
*   (sem controle na tela)               -> this_cCidchaves  char(20) - PK
*   (sem controle na tela)               -> this_cNomeimp    char(40)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SIGOPCPEBO AS BusinessBase

    *==========================================================================
    * Identificacao do registro / chave
    *==========================================================================
    *-- Tipos: char(20) - nome do dispositivo. No legado eh a chave de
    *-- pesquisa (Index On Tipos Tag PesqTipo) e o valor escolhido no
    *-- Cmb_Tipo; as comparacoes por SEEK usam PADR(...,20), porque o padding
    *-- faz parte da chave posicional do indice (CLAUDE.md regra #42).
    this_cTipos      = ""   && char(20) NOT NULL - tipo de dispositivo

    *-- CidChaves: char(20) - PRIMARY KEY (constraint sigsycom_cidchaves).
    *-- Gerada pelo fUniqueIds() do Fortyus no Insert Into do Init legado -
    *-- NUNCA vazia, senao o segundo registro colide no indice unico
    *-- (CLAUDE.md regra #22).
    this_cCidchaves  = ""   && char(20) NOT NULL - chave primaria

    *==========================================================================
    * Configuracao da porta serial (bloco esquerdo da tela, sempre visivel)
    *==========================================================================
    *-- Portas: numeric(1,0) - numero da porta de comunicacao. O Spinner1 do
    *-- legado limita 1..10 (SpinnerLowValue 1 / SpinnerHighValue 10,
    *-- KeyboardLowValue 1 / KeyboardHighValue 10) com Value inicial 1.
    this_nPortas     = 0    && numeric(1,0) NOT NULL - No. da porta COM

    *-- Hands: char(20) - HandShaking. O Cmb_Hand (RowSourceType 1) recebe no
    *-- Init legado os itens '0-None', '1-Xon Xoff', '2-RTS' e ' '; com
    *-- ControlSource char, o valor gravado eh o TEXTO do item escolhido.
    this_cHands      = ""   && char(20) NOT NULL - HandShaking

    *-- Settings: char(20) - configuracao da porta no formato
    *-- 'baud,paridade,databits,stopbits'. O Init legado repoe o default
    *-- '9600,n,8,1' em todo registro que chega vazio (this_cSettingsPadrao).
    this_cSettings   = ""   && char(20) NOT NULL - Settings da porta

    *-- Dtrs / Rtss: colunas bit do SQL Server, que chegam ao VFP como LOGICO
    *-- (.T./.F.) - por isso this_l*, e nao this_n* (bit -> LOGICAL;
    *-- numeric(1,0) -> NUMERIC). Ligadas a chk_dtr / chk_rts.
    this_lDtrs       = .F.  && bit NOT NULL - DTRenable
    this_lRtss       = .F.  && bit NOT NULL - RTSenable

    *-- Buffers e modo de leitura (Get_inbuf / Get_outbuf / Get_inmode /
    *-- Get_inlen). O dominio de InModes esta documentado na propria tela
    *-- pelo Say11: "( 0 - Text , 1- Binary )".
    this_nInbufs     = 0    && numeric(8,0) NOT NULL - InBufferMode
    this_nOutbufs    = 0    && numeric(8,0) NOT NULL - OutBufferMode
    this_nInmodes    = 0    && numeric(1,0) NOT NULL - InModes (0=Text, 1=Binary)
    this_nInlens     = 0    && numeric(8,0) NOT NULL - InLen

    *==========================================================================
    * Bloco de cheque (Say12/Say14/Say15/Say16 + controles) - o legado so
    * exibe estes controles quando Tipos = 'Leitora Cheques' OU
    * 'Impressora de Cheque' (Init e Cmb_Tipo.InteractiveChange).
    *==========================================================================
    *-- TpLeChqs: char(1) - leitora de cheques. O Get_TpLeChq eh ComboBox com
    *-- Style = 2 (dropdown list) e RowSource
    *-- "T-Teclado ,S-Serial,P,M-Manual,C-Cheque Pre,K-Pertochek,H-Check-Pronto,U-USB";
    *-- com ControlSource char, o valor gravado eh a INICIAL da opcao
    *-- escolhida (T/S/P/M/C/K/H/U).
    this_cTplechqs   = ""   && char(1) NOT NULL - tipo de leitora de cheque

    *-- BomPara / Nominal / Cruzado: numeric(1,0) ligadas a CheckBox
    *-- (Chk_Bompara / chk_nominal / chk_cruzado). CheckBox sobre coluna
    *-- numerica grava 0 ou 1 - nao eh o indice 1-based de OptionGroup/
    *-- ComboBox -, por isso propriedade NUMERICA com dominio {0,1} e
    *-- conversao explicita nos dois sentidos no Form.
    this_nBompara    = 0    && numeric(1,0) NOT NULL - imprime "Bom Para"
    this_nNominal    = 0    && numeric(1,0) NOT NULL - imprime nominal
    this_nCruzado    = 0    && numeric(1,0) NOT NULL - imprime cruzado

    *==========================================================================
    * Bloco de leitor de codigo de barra (Say13 + Opt_leitor) - o legado
    * exibe quando Tipos = 'Leitora Codigo Barra' OU 'Leitora Cheques' (Init)
    * e tambem 'Impressora de Cheque' (Cmb_Tipo.InteractiveChange).
    *==========================================================================
    *-- TpBarras: numeric(1,0) ligada ao Opt_leitor, OptionGroup de 3 botoes
    *-- (Option1 "Serial", Option2 "Teclado", Option3 "Paralelo") com
    *-- ControlSource direto: o valor gravado eh a ORDEM do botao marcado
    *-- (1=Serial, 2=Teclado, 3=Paralelo), 1-based e SEM +1/-1
    *-- (CLAUDE.md regra #45). O SCX declara Value = 2, logo o default de
    *-- tela eh "Teclado".
    this_nTpbarras   = 0    && numeric(1,0) NOT NULL - 1=Serial 2=Teclado 3=Paralelo

    *==========================================================================
    * Coluna NOT NULL sem controle na tela
    *==========================================================================
    *-- NomeImp: char(40) - nome da impressora associada ao dispositivo. Nao
    *-- tem controle no SCX e nao eh citada em metodo nenhum do legado:
    *-- existia apenas no registro em branco do cursor (AddCursor sem lista
    *-- de colunas = Select * + TableUpdate) e por isso continuava sendo
    *-- gravada em branco. Declarada aqui porque eh NOT NULL e o INSERT da
    *-- Fase 2 tem de cobri-la (CLAUDE.md regra #22).
    this_cNomeimp    = ""   && char(40) NOT NULL - nome da impressora

    *==========================================================================
    * Estado / apoio ao fluxo do form
    *==========================================================================
    *-- Alias do cursor que recebe TODA a tabela (equivalente ao crSigSyCom
    *-- do legado). O form percorre/posiciona este cursor conforme o Cmb_Tipo.
    this_cCursorDados     = "cursor_4c_Dados"

    *-- Lista dos 6 tipos de dispositivo que o Init legado GARANTE existirem
    *-- na tabela, na mesma ordem em que sao inseridos e em que o Cmb_Tipo os
    *-- apresenta (AddItem). Preenchida no Init() porque "Balanca" leva
    *-- cedilha e literal acentuado em .PRG eh proibido (CLAUDE.md regra #4).
    this_cTiposPadrao     = ""
    this_nTotalTipos      = 6

    *-- Settings default aplicado pelo Init legado a todo registro cujo
    *-- Settings chega vazio. Fica em propriedade propria, e nao na lista
    *-- acima, porque o proprio valor contem virgulas.
    this_cSettingsPadrao  = "9600,n,8,1"

    *-- Tipo selecionado no Cmb_Tipo. Guardado separado de this_cTipos para o
    *-- form saber qual linha reposicionar sem depender do estado do cursor.
    this_cTipoSelecionado = ""

    *-- Quantidade de registros carregados no cursor de dados.
    this_nQtdeRegistros   = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Define a tabela principal e a chave primaria REAL de SigSyCom
    * (cidchaves - constraint sigsycom_cidchaves, ver docs/schema.sql), monta
    * a lista dos 6 tipos de dispositivo usando CHR() no lugar dos acentos e
    * zera o estado de edicao herdado de BusinessBase.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigSyCom")

            THIS.this_cTabela     = "SigSyCom"
            THIS.this_cCampoChave = "cidchaves"

            *-- Os 6 tipos fixos, na ordem dos Insert Into / AddItem do legado.
            *-- "Balanca" = "Balan" + CHR(231) + "a"  (CHR(231) = c-cedilha)
            THIS.this_cTiposPadrao = "Balan" + CHR(231) + "a" + ;
                                     ",Cupom Fiscal" + ;
                                     ",Leitora Cheques" + ;
                                     ",Leitora Codigo Barra" + ;
                                     ",Impressora de Cheque" + ;
                                     ",Gaveta Serial"
            THIS.this_nTotalTipos = 6

            *-- Estado inicial: consulta, nenhum registro posicionado.
            THIS.this_cTipoSelecionado = ""
            THIS.this_nQtdeRegistros   = 0
            THIS.this_lEmEdicao        = .F.
            THIS.this_lNovoRegistro    = .F.
            THIS.this_lDadosAlterados  = .F.
            THIS.this_cMensagemErro    = ""
            THIS.this_lErroExibido     = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar SIGOPCPEBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterTipoPorIndice - Devolve o nome do tipo de dispositivo na posicao
    * informada (1..this_nTotalTipos), na mesma ordem do Cmb_Tipo legado.
    * Indice fora da faixa devolve string vazia.
    *
    * Sem PROTECTED de proposito: o Form chama de fora para popular o
    * Cmb_Tipo e para resolver a linha a posicionar no cursor (CLAUDE.md
    * regra #51 - metodo que o form chama nunca pode ser PROTECTED).
    *==========================================================================
    FUNCTION ObterTipoPorIndice(par_nIndice)
        LOCAL loc_cRetorno, loc_nLinhas
        LOCAL ARRAY loc_aTipos[1]
        loc_cRetorno = ""

        IF VARTYPE(par_nIndice) = "N" AND par_nIndice >= 1
            loc_nLinhas = ALINES(loc_aTipos, THIS.this_cTiposPadrao, 1, ",")
            IF par_nIndice <= loc_nLinhas
                loc_cRetorno = ALLTRIM(loc_aTipos[par_nIndice])
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Valor da chave primaria para a auditoria
    * (BusinessBase.RegistrarAuditoria). A PK de SigSyCom eh cidchaves.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as 17 colunas da linha corrente do
    * alias informado para as propriedades this_*. Usado tanto para a linha
    * reposicionada pelo Cmb_Tipo (equivalente ao Seek legado) quanto para o
    * proprio cursor_4c_Dados.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C"
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cTipos     = TratarNulo(tipos, "")
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                THIS.this_nPortas    = TratarNulo(portas, 0)
                THIS.this_cHands     = TratarNulo(hands, "")
                THIS.this_cSettings  = TratarNulo(settings, "")

                *-- dtrs/rtss sao colunas bit do SQL Server - chegam ao VFP
                *-- como LOGICO (CLAUDE.md regra correlata a bit/numeric(1,0)).
                THIS.this_lDtrs      = dtrs
                THIS.this_lRtss      = rtss

                THIS.this_nInbufs    = TratarNulo(inbufs, 0)
                THIS.this_nOutbufs   = TratarNulo(outbufs, 0)
                THIS.this_nInmodes   = TratarNulo(inmodes, 0)
                THIS.this_nInlens    = TratarNulo(inlens, 0)
                THIS.this_cTplechqs  = TratarNulo(tplechqs, "")
                THIS.this_nTpbarras  = TratarNulo(tpbarras, 0)
                THIS.this_nBompara   = TratarNulo(bompara, 0)
                THIS.this_nNominal   = TratarNulo(nominal, 0)
                THIS.this_nCruzado   = TratarNulo(cruzado, 0)
                THIS.this_cNomeimp   = TratarNulo(nomeimp, "")

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigSyCom (as 17 colunas, todas NOT NULL).
    *
    * cidchaves eh a PK Fortyus (CLAUDE.md regra #22): gerada por
    * fUniqueIds() quando ainda esta vazia, NUNCA deixada em branco -
    * senao o proximo registro colide no indice unico sigsycom_cidchaves.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND EMPTY(ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cSQL = "INSERT INTO SigSyCom " + ;
                    "(tipos, portas, dtrs, rtss, hands, settings, inbufs, outbufs, " + ;
                    "inmodes, inlens, tpbarras, cidchaves, tplechqs, bompara, cruzado, " + ;
                    "nominal, nomeimp) VALUES (" + ;
                    EscaparSQL(LEFT(THIS.this_cTipos, 20)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nPortas, 0) + ", " + ;
                    IIF(THIS.this_lDtrs, "1", "0") + ", " + ;
                    IIF(THIS.this_lRtss, "1", "0") + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cHands, 20)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cSettings, 20)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInbufs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOutbufs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInmodes, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInlens, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTpbarras, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cTplechqs, 1)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBompara, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nCruzado, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNominal, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cNomeimp, 40)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao incluir Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Incluir")
                    loc_lResultado = .F.
                ENDIF

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = "Erro ao incluir Porta de Comunica" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message
                MsgErro(THIS.this_cMensagemErro, "Erro ao Incluir")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE completo em SigSyCom, filtrado pela PK cidchaves.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND EMPTY(ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cMensagemErro = "Registro sem chave prim" + CHR(225) + "ria - n" + ;
                CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel alterar."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cSQL = "UPDATE SigSyCom SET " + ;
                    "tipos = "    + EscaparSQL(LEFT(THIS.this_cTipos, 20)) + ", " + ;
                    "portas = "   + FormatarNumeroSQL(THIS.this_nPortas, 0) + ", " + ;
                    "dtrs = "     + IIF(THIS.this_lDtrs, "1", "0") + ", " + ;
                    "rtss = "     + IIF(THIS.this_lRtss, "1", "0") + ", " + ;
                    "hands = "    + EscaparSQL(LEFT(THIS.this_cHands, 20)) + ", " + ;
                    "settings = " + EscaparSQL(LEFT(THIS.this_cSettings, 20)) + ", " + ;
                    "inbufs = "   + FormatarNumeroSQL(THIS.this_nInbufs, 0) + ", " + ;
                    "outbufs = "  + FormatarNumeroSQL(THIS.this_nOutbufs, 0) + ", " + ;
                    "inmodes = "  + FormatarNumeroSQL(THIS.this_nInmodes, 0) + ", " + ;
                    "inlens = "   + FormatarNumeroSQL(THIS.this_nInlens, 0) + ", " + ;
                    "tpbarras = " + FormatarNumeroSQL(THIS.this_nTpbarras, 0) + ", " + ;
                    "tplechqs = " + EscaparSQL(LEFT(THIS.this_cTplechqs, 1)) + ", " + ;
                    "bompara = "  + FormatarNumeroSQL(THIS.this_nBompara, 0) + ", " + ;
                    "cruzado = "  + FormatarNumeroSQL(THIS.this_nCruzado, 0) + ", " + ;
                    "nominal = "  + FormatarNumeroSQL(THIS.this_nNominal, 0) + ", " + ;
                    "nomeimp = "  + EscaparSQL(LEFT(THIS.this_cNomeimp, 40)) + ;
                    " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao alterar Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Alterar")
                    loc_lResultado = .F.
                ENDIF

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = "Erro ao alterar Porta de Comunica" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message
                MsgErro(THIS.this_cMensagemErro, "Erro ao Alterar")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDados - Monta o cursor de trabalho da tela (equivalente EXATO ao
    * bloco de abertura do Init legado).
    *
    * O legado faz, nesta ordem:
    *   .AddCursor('SigSyCom','Tipos','crSigSyCom','','',[Select * From SigSyCom])
    *   .ReQuery('crSigSyCom')
    *   Select crSigSyCom / Index On Tipos Tag PesqTipo / Go Top
    *   para cada um dos 6 tipos: If Not Seek(Padr(<tipo>,20))
    *                                 Insert Into crSigSyCom (Tipos, CidChaves) ...
    *                             EndIf
    *                             If IsEmpty(Settings) -> Replace com '9600,n,8,1'
    *
    * Reproduzido aqui porque esse cursor NAO eh um detalhe de carga: os
    * controles da tela sao ligados a ele por ControlSource (como no legado),
    * entao ele tem de EXISTIR e estar POSICIONADO antes de
    * ConfigurarCamposPrincipais rodar - ControlSource apontando para alias
    * fechado derruba o Init inteiro com [Alias ... is not found]
    * (CLAUDE.md regra #41). Por isso o Form chama este metodo ANTES de criar
    * os campos, e por isso o ramo sem conexao tambem cria o cursor (com a
    * estrutura das 17 colunas de SigSyCom): sem alias vivo a tela nao abre
    * nem em modo de teste.
    *
    * READWRITE eh obrigatorio: os controles editam a linha corrente e o
    * bloco de semeadura faz INSERT/REPLACE no proprio cursor - cursor de
    * SQLEXEC nasce SOMENTE-LEITURA.
    *
    * Sem PROTECTED de proposito - o Form chama de fora (CLAUDE.md regra #51).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado
        LOCAL loc_nI, loc_cTipo, loc_cAlias, loc_cAliasTmp, loc_oErro

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        loc_cAlias      = THIS.this_cCursorDados
        loc_cAliasTmp   = loc_cAlias + "_Tmp"

        TRY
            *-- Fecha o alias anterior. O TABLEREVERT so entra se houver
            *-- buffering de verdade: sem buffering ele NAO eh no-op, dispara
            *-- erro 1586 (CLAUDE.md regra #52). USE IN fecha o alias mesmo
            *-- com buffer sujo.
            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF
            IF USED(loc_cAliasTmp)
                USE IN (loc_cAliasTmp)
            ENDIF

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                *-- Mesma query do lcQryCFis legado: a tabela INTEIRA.
                loc_cSQL = "SELECT tipos, portas, dtrs, rtss, hands, settings, " + ;
                    "inbufs, outbufs, inmodes, inlens, tpbarras, cidchaves, " + ;
                    "tplechqs, bompara, cruzado, nominal, nomeimp FROM SigSyCom"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

                *-- SELECT bem-sucedido devolve 1 (um result set). O > 0 eh
                *-- estrito de proposito: o passo seguinte DEPENDE do cursor
                *-- temporario existir.
                IF loc_nResultado > 0
                    *-- SQLEXEC gera cursor SOMENTE-LEITURA; READWRITE eh
                    *-- obrigatorio porque os controles editam a linha e a
                    *-- semeadura faz INSERT/REPLACE no proprio cursor.
                    SELECT * FROM (loc_cAliasTmp) INTO CURSOR (loc_cAlias) READWRITE
                    IF USED(loc_cAliasTmp)
                        USE IN (loc_cAliasTmp)
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Carregar")
                    loc_lProsseguir = .F.
                ENDIF
            ELSE
                *-- Sem conexao (modo de teste / validacao de UI): cursor vazio
                *-- com a estrutura REAL de SigSyCom (docs/schema.sql). dtrs e
                *-- rtss sao Logicos porque bit do SQL Server chega ao VFP
                *-- como Logico - e sao eles que alimentam os CheckBox ligados
                *-- por ControlSource.
                CREATE CURSOR (loc_cAlias) ( ;
                    tipos     C(20), ;
                    portas    N(1, 0), ;
                    dtrs      L, ;
                    rtss      L, ;
                    hands     C(20), ;
                    settings  C(20), ;
                    inbufs    N(8, 0), ;
                    outbufs   N(8, 0), ;
                    inmodes   N(1, 0), ;
                    inlens    N(8, 0), ;
                    tpbarras  N(1, 0), ;
                    cidchaves C(20), ;
                    tplechqs  C(1), ;
                    bompara   L, ;
                    cruzado   L, ;
                    nominal   L, ;
                    nomeimp   C(40) )
            ENDIF

            IF loc_lProsseguir
                SELECT (loc_cAlias)

                *-- Index On Tipos Tag PesqTipo + Go Top do legado. A tag eh
                *-- consultada por SEEK a partir do Cmb_Tipo; chave de coluna
                *-- UNICA (char(20)), logo o SEEK usa PADR(...,20) e casa
                *-- exato mesmo com SET EXACT ON.
                INDEX ON tipos TAG PesqTipo
                GO TOP

                *-- Semeadura dos 6 tipos, igual ao legado: o que faltar eh
                *-- inserido com Tipos + CidChaves = fUniqueIds(); as demais
                *-- colunas ficam no valor em branco do cursor, exatamente
                *-- como no Insert Into de duas colunas do legado. Em seguida,
                *-- Settings vazio recebe o default '9600,n,8,1'.
                FOR loc_nI = 1 TO THIS.this_nTotalTipos
                    loc_cTipo = THIS.ObterTipoPorIndice(loc_nI)

                    IF !EMPTY(loc_cTipo)
                        IF !SEEK(PADR(loc_cTipo, 20), loc_cAlias, "PesqTipo")
                            INSERT INTO (loc_cAlias) (tipos, cidchaves) ;
                                VALUES (PADR(loc_cTipo, 20), LEFT(fUniqueIds(), 20))
                        ENDIF

                        IF EMPTY(ALLTRIM(EVALUATE(loc_cAlias + ".settings")))
                            REPLACE settings WITH THIS.this_cSettingsPadrao ;
                                IN (loc_cAlias)
                        ENDIF
                    ENDIF
                ENDFOR

                SELECT (loc_cAlias)
                GO TOP

                THIS.this_nQtdeRegistros = RECCOUNT(loc_cAlias)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar Porta de Comunica" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

