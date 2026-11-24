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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpTrf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3034 linhas total):

*-- Linhas 132 a 155:
132: *   | metodo                      | conteudo |
133: *   |-----------------------------|----------|
134: *   | ConfigurarGradeOperacoes()  | grd_4c_Operacoes (GradeOpe) - so o que nao depende de dado (regra #41) |
135: *   | ConfigurarBotoes()          | shp_4c_Shape1 (ANTES, regra #30) + cmd_4c_CmdSair/CmdInserir/CmdExcluir/Command2/Command1 |
136: *   | ConfigurarGradeItens()      | grd_4c_Itens (GradePro) + chama AplicarFormatoGrade() |
137: *   | AplicarFormatoGrade()       | PUBLIC, FONTE UNICA de Column.Width/Header1.Caption das DUAS grades |
138: *   | CarregarLista()             | PUBLIC, funil: BO.CarregarRegras + bind das 2 grades + filtro inicial + Refresh |
139: *   | FiltrarItensPorOperacaoCorrente() | SET KEY TO do legado (mestre-detalhe, so a carga INICIAL) |
140: *
141: *   Ordem de criacao = ordem do dump (SECAO 1): GradeOpe, Shape1+botoes,
142: *   GradePro - igual ao legado, embora nenhum destes controles se
143: *   sobreponha de fato (conferido Left+Width/Top+Height de todos contra
144: *   os vizinhos).
145: *
146: *   cmd_4c_CmdSair eh fwbtng (75x75, canonico de icone 60px - Width/Height
147: *   nao constam do dump, propriedade da classe de framework.vcx); os
148: *   outros 4 sao fwbtnp (36x36, canonico de icone 26px) - mesma convencao
149: *   de FormSigOpMpn.prg/FormSigOpMpd.prg. 455+75=530=Form.Width (igual ao
150: *   irmao FormSigOpTop, cmd_4c_Encerrar fechando exatamente na borda).
151: *   ToolTipText = "Inserir" nos 4 botoes fwbtnp (inclusive CmdExcluir e
152: *   Command1, que EXCLUEM) eh LITERAL do dump - artefato de copia do Form
153: *   Designer no legado, transcrito sem correcao por fidelidade (PILAR 1).
154: *
155: *   GradePro.Column2 (col_dpros, "Descricao") recebe .ReadOnly = .T.: o

*-- Linhas 424 a 432:
424: 
425:     *-- Caption do SCX ("Opera??es Autom?ticas") - sobrescrito em
426:     *-- InicializarForm com o codigo da operacao de origem, igual ao
427:     *-- legado (.Caption = 'Operacoes Automaticas P/ ' +
428:     *-- AllTrim(crSigCdOpe.Dopes))
429:     Caption = "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas"
430: 
431:     *-- ControlBox = .F. / Movable = .F. / TitleBar = 0 / ClipControls = .F.
432:     *-- - literais do dump. MaxButton/Closable/MinButton NAO declarados no

*-- Linhas 561 a 571:
561:                 *-- Legado: .ParentForm.Enabled = .f.
562:                 THIS.CarregarContextoFormPai()
563: 
564:                 *-- Legado: .Caption = 'Operacoes Automaticas P/ ' +
565:                 *-- AllTrim(crSigCdOpe.Dopes)
566:                 THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas P/ " + ;
567:                                ALLTRIM(THIS.this_cDopes)
568: 
569:                 THIS.this_oBusinessObject.this_cTituloDialogo = THIS.Caption
570: 
571:                 *-- Fundo do form (Picture do SCX)

*-- Linhas 670 a 678:
670:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
671:     *
672:     * O Init legado sobrescreve os dois Caption com ThisForm.Caption
673:     * ("Operacoes Automaticas P/ <operacao>"), por isso .Caption =
674:     * THIS.Caption (dinamico) - o literal do dump ("Cadastro de Testes") eh
675:     * so o default do Form Designer, nunca chega a ser exibido.
676:     *
677:     * Width do container usa THIS.Width - padrao canonico da faixa, regra
678:     * #11 - em vez do literal 800: o SCX declara o CONTAINER mais largo que

*-- Linhas 691 a 746:
691:         *-- Container da faixa (cntSombra)
692:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
693:         WITH THIS.cnt_4c_Cabecalho
694:             .Top           = 0
695:             .Left          = 0
696:             .Width         = THIS.Width
697:             .Height        = 80
698:             .BorderWidth   = 0
699:             .BackStyle     = 1
700:             .BackColor     = RGB(100, 100, 100)
701:             .SpecialEffect = 0
702:             .Visible       = .T.
703:         ENDWITH
704: 
705:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
706:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
707:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
708:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
709:             .AutoSize      = .F.
710:             .FontBold      = .T.
711:             .FontName      = "Tahoma"
712:             .FontSize      = 18
713:             .FontUnderline = .F.
714:             .WordWrap      = .T.
715:             .Alignment     = 0
716:             .BackStyle     = 0
717:             .Caption       = THIS.Caption
718:             .Top           = 18
719:             .Left          = 10
720:             .Width         = THIS.Width - 20
721:             .Height        = 40
722:             .ForeColor     = RGB(0, 0, 0)
723:             .Rotation      = 0
724:             .Visible       = .T.
725:         ENDWITH
726: 
727:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
728:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
729:         *-- regra #12)
730:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
731:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
732:             .AutoSize  = .F.
733:             .FontBold  = .T.
734:             .FontName  = "Tahoma"
735:             .FontSize  = 18
736:             .WordWrap  = .T.
737:             .Alignment = 0
738:             .BackStyle = 0
739:             .Caption   = THIS.Caption
740:             .Top       = 17
741:             .Left      = 10
742:             .Width     = THIS.Width - 20
743:             .Height    = 46
744:             .ForeColor = RGB(255, 255, 255)
745:             .Rotation  = 0
746:             .Visible   = .T.

*-- Linhas 781 a 790:
781:             .ColumnCount   = 1
782:             .FontName      = "Tahoma"
783:             .FontSize      = 8
784:             .Top           = 133
785:             .Left          = 5
786:             .Height        = 221
787:             .Width         = 180
788:             .ScrollBars    = 2
789:             .DeleteMark    = .F.
790:             .RecordMark    = .F.

*-- Linhas 847 a 872:
847:         *-- Shape1 (decoracao invisivel) - PRIMEIRO, ver acima
848:         THIS.AddObject("shp_4c_Shape1", "Shape")
849:         WITH THIS.shp_4c_Shape1
850:             .Top         = 12
851:             .Left        = 432
852:             .Height      = 110
853:             .Width       = 90
854:             .BackStyle   = 0
855:             .BorderStyle = 0
856:             .BorderColor = RGB(136, 189, 188)
857:             .Visible     = .T.
858:         ENDWITH
859: 
860:         *-- cmdSair ("Encerrar") -> cmd_4c_CmdSair
861:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
862:         WITH THIS.cmd_4c_CmdSair
863:             .Top          = 3
864:             .Left         = 455
865:             .Width        = 75
866:             .Height       = 75
867:             .Caption      = "Encerrar"
868:             .Cancel       = .T.
869:             .TabIndex     = 8
870:             .FontName     = "Comic Sans MS"
871:             .FontSize     = 8
872:             .FontBold     = .T.

*-- Linhas 887 a 902:
887:             .Visible = .T.
888:         ENDWITH
889: 
890:         *-- cmdInserir -> cmd_4c_CmdInserir (opera a grade de OPERACOES)
891:         THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
892:         WITH THIS.cmd_4c_CmdInserir
893:             .Top          = 91
894:             .Left         = 5
895:             .Width        = 36
896:             .Height       = 36
897:             .Caption      = ""
898:             .ToolTipText  = "Inserir"
899:             .FontName     = "Verdana"
900:             .FontSize     = 8
901:             .ForeColor    = RGB(36, 84, 155)
902:             .BackColor    = RGB(255, 255, 255)

*-- Linhas 912 a 927:
912:             .Visible = .T.
913:         ENDWITH
914: 
915:         *-- cmdExcluir -> cmd_4c_CmdExcluir (opera a grade de OPERACOES)
916:         THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
917:         WITH THIS.cmd_4c_CmdExcluir
918:             .Top          = 91
919:             .Left         = 45
920:             .Width        = 36
921:             .Height       = 36
922:             .Caption      = ""
923:             .ToolTipText  = "Inserir"
924:             .FontName     = "Verdana"
925:             .FontSize     = 8
926:             .ForeColor    = RGB(36, 84, 155)
927:             .BackColor    = RGB(255, 255, 255)

*-- Linhas 937 a 952:
937:             .Visible = .T.
938:         ENDWITH
939: 
940:         *-- Command2 -> cmd_4c_Command2 (opera a grade de PRODUTOS - insere)
941:         THIS.AddObject("cmd_4c_Command2", "CommandButton")
942:         WITH THIS.cmd_4c_Command2
943:             .Top          = 91
944:             .Left         = 190
945:             .Width        = 36
946:             .Height       = 36
947:             .Caption      = ""
948:             .ToolTipText  = "Inserir"
949:             .FontName     = "Verdana"
950:             .FontSize     = 8
951:             .ForeColor    = RGB(36, 84, 155)
952:             .BackColor    = RGB(255, 255, 255)

*-- Linhas 962 a 977:
962:             .Visible = .T.
963:         ENDWITH
964: 
965:         *-- Command1 -> cmd_4c_Command1 (opera a grade de PRODUTOS - exclui)
966:         THIS.AddObject("cmd_4c_Command1", "CommandButton")
967:         WITH THIS.cmd_4c_Command1
968:             .Top          = 91
969:             .Left         = 230
970:             .Width        = 36
971:             .Height       = 36
972:             .Caption      = ""
973:             .ToolTipText  = "Inserir"
974:             .FontName     = "Verdana"
975:             .FontSize     = 8
976:             .ForeColor    = RGB(36, 84, 155)
977:             .BackColor    = RGB(255, 255, 255)

*-- Linhas 1012 a 1021:
1012:         THIS.AddObject("grd_4c_Itens", "Grid")
1013:         WITH THIS.grd_4c_Itens
1014:             .ColumnCount = 2
1015:             .Top         = 133
1016:             .Left        = 190
1017:             .Height      = 220
1018:             .Width       = 335
1019:             .ScrollBars  = 2
1020:             .TabIndex    = 8
1021:             .DeleteMark  = .F.

*-- Linhas 1080 a 1088:
1080:                 .Column1.Resizable         = .F.
1081:                 .Column1.FontName          = "Tahoma"
1082:                 .Column1.FontSize          = 8
1083:                 .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
1084:                 .Column1.Header1.FontName  = "Tahoma"
1085:                 .Column1.Header1.FontSize  = 8
1086:                 .Column1.Header1.Alignment = 2
1087:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
1088: 

*-- Linhas 1109 a 1117:
1109:                 .Column1.Resizable         = .F.
1110:                 .Column1.FontName          = "Courier New"
1111:                 .Column1.Alignment         = 3
1112:                 .Column1.Header1.Caption   = "Produto"
1113:                 .Column1.Header1.FontName  = "Tahoma"
1114:                 .Column1.Header1.FontSize  = 8
1115:                 .Column1.Header1.Alignment = 2
1116:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
1117: 

*-- Linhas 1132 a 1140:
1132:                 .Column2.FontName          = "Courier New"
1133:                 .Column2.FontSize          = 9
1134:                 .Column2.ReadOnly          = .T.
1135:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1136:                 .Column2.Header1.FontName  = "Tahoma"
1137:                 .Column2.Header1.FontSize  = 8
1138:                 .Column2.Header1.Alignment = 2
1139:                 .Column2.Header1.ForeColor = RGB(90, 90, 90)
1140:                 .Column2.Text1.FontName    = "Courier New"

*-- Linhas 1876 a 1888:
1876:     * nao eh confiavel (regra #46).
1877:     *==========================================================================
1878:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1879:         BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "CmdInserirClick")
1880:         BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
1881:         BINDEVENT(THIS.cmd_4c_Command2,   "Click", THIS, "CmdInserirItemClick")
1882:         BINDEVENT(THIS.cmd_4c_Command1,   "Click", THIS, "CmdExcluirItemClick")
1883:         BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "BtnSairClick")
1884: 
1885:         BINDEVENT(THIS.grd_4c_Operacoes, "AfterRowColChange", ;
1886:                   THIS, "GradeOperacoesAfterRowColChange")
1887:     ENDPROC
1888: 

*-- Linhas 2874 a 2882:
2874:     * qualquer modo (legado: txt_dpros.When retorna .F.) e quem a trava eh
2875:     * AplicarFormatoGrade.
2876:     *
2877:     * cmd_4c_CmdSair fica SEMPRE habilitado: com TitleBar = 0 e
2878:     * ControlBox = .F. o Encerrar eh a saida da tela, e desabilita-lo
2879:     * prenderia o usuario - e perderia o lote, que so eh gravado por ele.
2880:     *
2881:     * Metodo PUBLIC (regra #3/#51): o harness de teste o alcanca de fora.
2882:     *==========================================================================

*-- Linhas 2913 a 2939:
2913: 
2914:         *-- Os 4 botoes de linha do legado (cmdInserir/cmdExcluir da grade de
2915:         *-- operacoes e Command2/Command1 da de produtos)
2916:         IF PEMSTATUS(THIS, "cmd_4c_CmdInserir", 5)
2917:             THIS.cmd_4c_CmdInserir.Enabled = loc_lHabilitar
2918:         ENDIF
2919: 
2920:         IF PEMSTATUS(THIS, "cmd_4c_CmdExcluir", 5)
2921:             THIS.cmd_4c_CmdExcluir.Enabled = loc_lHabilitar
2922:         ENDIF
2923: 
2924:         IF PEMSTATUS(THIS, "cmd_4c_Command2", 5)
2925:             THIS.cmd_4c_Command2.Enabled = loc_lHabilitar
2926:         ENDIF
2927: 
2928:         IF PEMSTATUS(THIS, "cmd_4c_Command1", 5)
2929:             THIS.cmd_4c_Command1.Enabled = loc_lHabilitar
2930:         ENDIF
2931: 
2932:         *-- Saida da tela - nunca desabilitada
2933:         IF PEMSTATUS(THIS, "cmd_4c_CmdSair", 5)
2934:             THIS.cmd_4c_CmdSair.Enabled = .T.
2935:         ENDIF
2936:     ENDPROC
2937: 
2938:     *==========================================================================
2939:     * AjustarBotoesPorModo - nome canonico do projeto para "reaplicar o estado


### BO (C:\4c\projeto\app\classes\SigOpTrfBO.prg):
*==============================================================================
* SIGOPTRFBO.PRG
* Business Object do dialogo "Operacoes Automaticas" (SIGOPTRF - regras de
* TRANSFERENCIA de produtos entre operacoes), aberto pelo form pai de
* Cadastro de Operacoes (SigCdOpe) via
* "Do Form SigOpTrf With ThisForm, nDataSession", NAO acessivel direto
* pelo menu.
*
* Tabela persistida : SigOpTrf  (regras de transferencia gravadas)
* Chave Real (PK)    : cidchaves  CHAR(20)
* Colunas da tabela  : cpros CHAR(14), dopeds CHAR(20), dopes CHAR(20),
*                       cidchaves CHAR(20) - schema.sql conferido (regra #14
*                       do CLAUDE.md, leitura via Get-Content -Raw).
*
* NATUREZA DESTE DIALOGO (lido do legado, SigOpTrf_form_codigo_fonte.txt):
*   O Init recebe (poForm, pnDataSes): poForm e o form PAI (SigCdOpe) e
*   pnDataSes e a DataSession do pai - o dialogo faz "Set DataSession to
*   pnDataSes" para conseguir ler crSigCdOpe (cursor do pai, linha corrente
*   = operacao de ORIGEM) antes de abrir a propria DataSession = 2 privada.
*
*   O Caption e montado como:
*     'Operacoes Automaticas P/ ' + AllTrim(crSigCdOpe.Dopes)
*   e replicado em cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
*   Duas grades, mestre-detalhe por codigo da OPERACAO DE DESTINO:
*     - GradeOpe (grade superior, 1 coluna) <- xOpe (Dopes C(20)) - lista
*       DISTINTA das operacoes de destino ja usadas nas regras desta
*       operacao de origem. Column2.Text1.Valid valida o codigo digitado
*       contra TmpOpe (Select Dopes,nDopes From SigCdOpe Where Dopes <>
*       <crSigCdOpe.Dopes>), abrindo fwBuscaInt quando nao encontra, e
*       recusa duplicata (MessageBox + Delete da linha repetida).
*     - GradePro (grade inferior, 2 colunas) <- xTrf (Dopes C(20),
*       Dopeds C(20), Cpros C(14), Dpros C(60)) - produtos que migram para
*       a operacao de destino selecionada na grade de cima. AfterRowColChange
*       da GradeOpe faz "Set Key To crSigCdOpe.Dopes+xOpe.Dopes" em xTrf
*       (indexado por Dopes+Dopeds) para filtrar so as linhas da operacao de
*       destino corrente. txt_cpros.Valid valida o produto contra SigCdPro
*       (fwBuscaExt quando nao encontra) e recusa duplicata na MESMA
*       operacao de destino.
*
*   Ao abrir (Init), as regras ja gravadas em SigOpTrf para a operacao de
*   origem (crSigOpTrf, AddCursor com Select * From SigOpTrf Where Dopes =
*   '<crSigCdOpe.Dopes>') sao expandidas para xTrf (com Dpros resolvido via
*   SqlExecute em SigCdPro) e xOpe (Dopeds distintos).
*
*   Ao Encerrar (cmdSair.Click), SE ThisForm.GravaDados: crSigOpTrf e
*   recriado do zero (Delete All + Scan em xTrf inserindo as linhas com
*   Dopes/Dopeds/Cpros todos preenchidos; se NENHUMA linha de xTrf for
*   valida, grava uma linha por xOpe.Dopes com Cpros vazio - "operacao de
*   destino sem produto especifico, migra tudo") e e persistido no SQL
*   Server via poDataMgr.UpDate('crSigOpTrf') + Commit() dentro de
*   ThisForm. cIdChaves de cada linha nova vem de fUniqueIds() (regra #22
*   do CLAUDE.md - NUNCA string vazia, senao a 2a linha colide no indice
*   unico). O botao reabilita o form pai e libera o dialogo:
*     Thisform.ParentForm.Enabled = .T.
*     ThisForm.Release
*
*   Por isso este BO sobrescreve Inserir() e Atualizar() operando sobre UMA
*   regra por vez (identificada por cidchaves) - primitivas que o fluxo de
*   gravacao em lote do Encerrar (fases seguintes) vai chamar em loop, uma
*   vez por linha de xTrf/xOpe, dentro do "apaga tudo e reinsere" do legado
*   (Delete All em crSigOpTrf + Scan inserindo cada linha nova). NAO
*   sobrescreve ExecutarExclusao(): nao ha exclusao unitaria no legado, a
*   remocao de uma regra e so o efeito colateral de ela nao ser reinserida
*   no lote seguinte.
*
* FASE 4 (acrescentada ao BO desta vez, alem do Form): CarregarRegras() -
*   a carga inicial completa (equivalente ao trecho do Init legado que
*   monta crSigOpTrf/TmpOpe via AddCursor e expande para xTrf/xOpe),
*   porque e consulta SQL - pertence ao BO, nao ao Form (arquitetura em
*   camadas). FecharCursoresTrabalho() da reentrancia a essa carga.
*==============================================================================

DEFINE CLASS SigOpTrfBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdOpe (crSigCdOpe no legado, cursor do form pai)
    * Operacao de ORIGEM cujas regras de transferencia estao sendo editadas.
    * this_cDopes e usado tanto como filtro das consultas quanto como o
    * valor da coluna "dopes" de cada linha de SigOpTrf (as duas coisas sao
    * sempre o mesmo codigo, por desenho deste dialogo).
    *--------------------------------------------------------------------------
    this_cDopes          = ""  && SigCdOpe.Dopes CHAR(20) - operacao de origem (contexto, vindo do form pai)
    this_cTituloDialogo  = ""  && Caption montado: "Operacoes Automaticas P/ " + this_cDopes

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DA REGRA DE TRANSFERENCIA (SigOpTrf / crSigOpTrf)
    *--------------------------------------------------------------------------
    this_cCidChaves      = ""  && cidchaves CHAR(20) - PK, gerada com fUniqueIds() ao inserir
    this_cDopeds         = ""  && dopeds    CHAR(20) - codigo da operacao de DESTINO
    this_cCpros          = ""  && cpros     CHAR(14) - codigo do produto (pode ficar vazio - ver cabecalho)
    this_cDpros          = ""  && descricao do produto (SigCdPro.Dpros) - NAO persistida em SigOpTrf, so exibicao (equivale a xTrf.Dpros do legado)

    *--------------------------------------------------------------------------
    * CURSORES DE TRABALHO - nomes fixos, populados pelo Form/BO nas fases
    * seguintes. Nenhum deles e SQLEXEC direto no cursor ligado ao Grid
    * (regra do CLAUDE.md sobre SQLEXEC derrubar ColumnCount de Grid).
    *--------------------------------------------------------------------------
    this_cCursorRegras           = "cursor_4c_Regras"            && crSigOpTrf no legado - regras ja gravadas em SigOpTrf para this_cDopes
    this_cCursorOperacoesDestino = "cursor_4c_OperacoesDestino"  && TmpOpe no legado - Select Dopes,nDopes From SigCdOpe Where Dopes <> this_cDopes (lookup/picker da operacao de destino)
    this_cCursorOperacoes        = "cursor_4c_Operacoes"         && xOpe no legado - lista DISTINTA das operacoes de destino (grade superior)
    this_cCursorItens            = "cursor_4c_Itens"             && xTrf no legado - regras detalhadas Dopes+Dopeds+Cpros+Dpros (grade inferior, filtrada pela operacao de destino selecionada)

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    *--------------------------------------------------------------------------
    this_lDadosAlterados = .F.  && ThisForm.GravaDados no legado - .T. quando algo foi incluido/excluido e precisa regravar ao Encerrar
    this_nTotalOperacoes = 0    && RECCOUNT de this_cCursorOperacoes apos a carga
    this_nTotalItens      = 0   && RECCOUNT de this_cCursorItens apos a carga (linhas visiveis na grade inferior, filtradas pela operacao de destino corrente)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * this_cTabela/this_cCampoChave apontam para a tabela REALMENTE gravada
    * por este dialogo (SigOpTrf) - diferente de SIGOPTOP/SIGOPTOR (so
    * leitura) e de SIGOPTOT (area de troca SigTempD).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpTrf"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cDopes         = ""
            THIS.this_cTituloDialogo = ""

            THIS.this_cCidChaves = ""
            THIS.this_cDopeds    = ""
            THIS.this_cCpros     = ""
            THIS.this_cDpros     = ""

            THIS.this_lDadosAlterados = .F.
            THIS.this_nTotalOperacoes = 0
            THIS.this_nTotalItens     = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da linha de SigOpTrf (cidchaves).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega cidchaves/dopes/dopeds/cpros da linha
    * corrente de um alias no formato real de SigOpTrf (this_cCursorRegras
    * por default - crSigOpTrf do legado). Se o alias tambem tiver a coluna
    * dpros (caso de this_cCursorItens, equivalente a xTrf, que resolve a
    * descricao do produto via SigCdPro so para exibicao), carrega tambem
    * this_cDpros; senao, limpa.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorRegras)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cCidChaves = TratarNulo(cidchaves, "")
        THIS.this_cDopes     = TratarNulo(dopes, "")
        THIS.this_cDopeds    = TratarNulo(dopeds, "")
        THIS.this_cCpros     = TratarNulo(cpros, "")

        IF TYPE(loc_cAlias + ".dpros") != "U"
            THIS.this_cDpros = TratarNulo(dpros, "")
        ELSE
            THIS.this_cDpros = ""
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma regra de transferencia em SigOpTrf.
    * cidchaves (PK real, regra #22 do CLAUDE.md) e gerado com fUniqueIds()
    * quando ainda nao foi atribuido - NUNCA string vazia, senao a 2a linha
    * do lote colide no indice unico sigoptrf_cidchaves. cpros pode ficar
    * vazio (regra de negocio do legado: operacao de destino sem produto
    * especifico migra tudo), por isso NAO e validado como obrigatorio aqui.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cCidChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigOpTrf (cidchaves, dopes, dopeds, cpros)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       EscaparSQL(THIS.this_cDopeds) + "," + ;
                       EscaparSQL(THIS.this_cCpros) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir regra de transfer" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir regra de transfer" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de uma regra de transferencia ja gravada,
    * localizada por cidchaves. Usado quando o lote do Encerrar preserva uma
    * linha existente (cidchaves ja atribuido) e so muda dopeds/cpros.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cMensagemErro = "Registro sem chave para altera" + CHR(231) + CHR(227) + "o"
            ELSE
                loc_cSQL = "UPDATE SigOpTrf SET" + ;
                           " dopes = "  + EscaparSQL(THIS.this_cDopes) + "," + ;
                           " dopeds = " + EscaparSQL(THIS.this_cDopeds) + "," + ;
                           " cpros = "  + EscaparSQL(THIS.this_cCpros) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar regra de transfer" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar regra de transfer" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ApagarRegrasDaOrigem - apaga TODAS as regras de transferencia da
    * operacao de origem corrente (this_cDopes). Equivale ao "SELECT
    * crSigOpTrf / DELETE ALL" do cmdSair.Click legado: a view crSigOpTrf
    * nasce filtrada por "Where Dopes = '<crSigCdOpe.Dopes>'" (ver
    * CarregarRegras), logo o DELETE ALL dela apaga exatamente as regras
    * desta origem - nunca a tabela inteira.
    *
    * Primitiva do "apaga tudo e regrava" que o Encerrar faz em lote
    * (FormSigOpTrf.PersistirRegras, Fase 7). O legado NAO tem exclusao
    * unitaria de regra, e por isso este BO nao sobrescreve
    * ExecutarExclusao() - Excluir() por cidchaves nao serviria aqui: seriam
    * N comandos para o que o legado resolve em UM, e a base recusa a
    * operacao sem o hook (o stub herdado devolve .F.).
    *
    * Esta no BO, e nao no Form, porque eh SQL (PILAR 3 - arquitetura em
    * camadas): o Form orquestra o lote, o BO fala com o banco.
    *
    * A auditoria de um DELETE em LOTE nao tem uma PK unica para registrar,
    * entao a chave logada eh o codigo da operacao de ORIGEM - que eh o que
    * identifica o conjunto afetado. this_cCidChaves eh preservado e
    * reposto: ele pertence a linha corrente, nao a este comando.
    *
    * EscaparSQL(this_cDopes) com o valor ALLTRIM'd eh a mesma forma usada
    * em CarregarRegras: dopes eh CHAR(20) e o SQL Server compara CHAR com
    * blank-padding ANSI, entao o WHERE casa com o valor gravado (ALLTRIM na
    * chave INTEIRA eh inofensivo - regra #42 proibe ALLTRIM nas PARTES de
    * chave concatenada, que nao eh o caso).
    *
    * O RETURN de guarda fica FORA do TRY e o RETURN final eh unico
    * (regra #1).
    *
    * Metodo PUBLIC: chamado pelo Form (PersistirRegras) e pelo harness de
    * teste - metodo que o form chama de fora NUNCA pode ser PROTECTED
    * (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE ApagarRegrasDaOrigem()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChaveAnterior, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de origem n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigOpTrf" + ;
                       " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                *-- Auditoria do lote pela operacao de origem (ver cabecalho)
                loc_cChaveAnterior   = THIS.this_cCidChaves
                THIS.this_cCidChaves = ALLTRIM(THIS.this_cDopes)
                THIS.RegistrarAuditoria("DELETE")
                THIS.this_cCidChaves = loc_cChaveAnterior

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao apagar as regras de transfer" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao apagar as regras de transfer" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursoresTrabalho - fecha os 4 cursores de trabalho (regra #52 -
    * TABLEREVERT so quando ha buffering, senao dispara o erro 1586).
    * Chamado no INICIO de CarregarRegras (reentrancia - este dialogo pode
    * ser aberto mais de uma vez na mesma sessao do processo) e pelo
    * Destroy do Form (teardown final).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresTrabalho()
        LOCAL loc_nI, loc_aCursores(4), loc_cAlias

        loc_aCursores(1) = THIS.this_cCursorRegras
        loc_aCursores(2) = THIS.this_cCursorOperacoesDestino
        loc_aCursores(3) = THIS.this_cCursorOperacoes
        loc_aCursores(4) = THIS.this_cCursorItens

        FOR loc_nI = 1 TO 4
            loc_cAlias = loc_aCursores(loc_nI)
            IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarRegras - carga inicial do dialogo (trecho principal do Init
    * legado): monta os 4 cursores de trabalho e EXPANDE as regras ja
    * gravadas em SigOpTrf (this_cCursorRegras) para as duas grades
    * mestre-detalhe do Form (this_cCursorOperacoes/this_cCursorItens),
    * resolvendo a descricao do produto via SigCdPro (SqlExecute do
    * legado).
    *
    *   Legado (Init):
    *     .AddCursor('SigOpTrf',...,'crSigOpTrf','Dopes',.f.,
    *         [Select * From SigOpTrf Where Dopes = ']+crSigCdOpe.Dopes+['
    *         Order by Dopes])
    *     .AddCursor('SigCdOpe',...,'TmpOpe','Dopes',.f.,
    *         [Select Dopes,nDopes From SigCdOpe Where Dopes <> ']+
    *         crSigCdOpe.Dopes+[' order by Dopes])
    *     Select TmpOpe / Index on Dopes Tag Dopes
    *     Create Cursor xTrf (Dopes c(20), Dopeds c(20), Cpros c(14), Dpros c(60))
    *     Index on Cpros Tag Cpros / Index on Dopes + Dopeds Tag Dopes / Set Order to
    *     Create Cursor xOpe ( Dopes c(20) ) / Index on Dopes Tag Dopes / Set Order to
    *     Select crSigOpTrf
    *     Scan While Dopes = crSigCdOpe.Dopes
    *         ... SqlExecute(Select cPros,dPros From SigCdPro Where Cpros=?m.cPros)
    *         Insert Into xTrf (...) Value (...)
    *         Se Dopeds novo -> Insert Into xOpe (Dopes) Value (Dopeds)
    *     EndScan
    *
    * this_cCursorOperacoesDestino (TmpOpe) fica populado e INDEXADO para
    * o lookup da Fase 7/8 (Column2.Text1.Valid - Seek(valor,'TmpOpe',
    * 'Dopes')); nao e varrido aqui.
    *
    * FecharCursoresTrabalho() no INICIO garante reentrancia - os CREATE
    * CURSOR abaixo estourariam "Cursor ja existe" se os 2 cursores locais
    * (xTrf/xOpe) ja estivessem abertos de uma chamada anterior.
    *
    * Metodo PUBLIC: chamado pelo Form (CarregarLista, Fase 4) e pelo
    * harness de teste.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarRegras()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cAliasProTemp, ;
              loc_nResultadoTemp, loc_cDopesRegra, loc_cDopedsRegra, ;
              loc_cProsRegra, loc_cDpros, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de origem n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            THIS.FecharCursoresTrabalho()

            *-- crSigOpTrf: regras ja gravadas para a operacao de origem
            loc_cSQL = "SELECT cidchaves, dopes, dopeds, cpros FROM SigOpTrf" + ;
                       " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       " ORDER BY dopes"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorRegras)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao consultar regras de transfer" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL()
                loc_lSucesso = .F.
            ELSE
                *-- TmpOpe: operacoes candidatas a destino (lookup da Fase 7/8)
                loc_cSQL = "SELECT dopes, ndopes FROM SigCdOpe" + ;
                           " WHERE dopes <> " + EscaparSQL(THIS.this_cDopes) + ;
                           " ORDER BY dopes"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacoesDestino)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao consultar opera" + CHR(231) + CHR(245) + "es de destino:" + CHR(13) + CapturarErroSQL()
                    loc_lSucesso = .F.
                ELSE
                    IF USED(THIS.this_cCursorOperacoesDestino)
                        SELECT (THIS.this_cCursorOperacoesDestino)
                        INDEX ON dopes TAG Dopes
                        SET ORDER TO
                    ENDIF

                    *-- xTrf / xOpe: cursores LOCAIS editaveis (INSERT INTO
                    *-- direto, nunca SQLEXEC - regra do SQLEXEC derrubar
                    *-- Grid.ColumnCount nao se aplica, mas o padrao do
                    *-- projeto eh o mesmo: estes dois nunca sao alvo de SQLEXEC)
                    CREATE CURSOR (THIS.this_cCursorItens) (Dopes C(20), Dopeds C(20), Cpros C(14), Dpros C(60))
                    INDEX ON Cpros TAG Cpros
                    INDEX ON Dopes + Dopeds TAG Dopes
                    SET ORDER TO

                    CREATE CURSOR (THIS.this_cCursorOperacoes) (Dopes C(20))
                    INDEX ON Dopes TAG Dopes
                    SET ORDER TO

                    *-- Expansao: cada regra ja gravada entra em xTrf,
                    *-- resolvendo a descricao do produto via SigCdPro; e
                    *-- alimenta xOpe com os codigos de operacao-destino
                    *-- DISTINTOS
                    SELECT (THIS.this_cCursorRegras)
                    SCAN
                        loc_cDopesRegra  = dopes
                        loc_cDopedsRegra = dopeds
                        loc_cProsRegra   = cpros
                        loc_cDpros       = ""

                        IF !EMPTY(ALLTRIM(loc_cProsRegra))
                            loc_cAliasProTemp = "cursor_4c_RegraProTmp"
                            loc_cSQL = "SELECT dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cProsRegra)
                            loc_nResultadoTemp = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasProTemp)

                            IF loc_nResultadoTemp >= 0 AND USED(loc_cAliasProTemp)
                                IF RECCOUNT(loc_cAliasProTemp) > 0
                                    SELECT (loc_cAliasProTemp)
                                    loc_cDpros = TratarNulo(dpros, "")
                                ENDIF
                                USE IN (loc_cAliasProTemp)
                            ENDIF
                        ENDIF

                        INSERT INTO (THIS.this_cCursorItens) (Dopes, Dopeds, Cpros, Dpros) ;
                            VALUES (loc_cDopesRegra, loc_cDopedsRegra, loc_cProsRegra, loc_cDpros)

                        IF !SEEK(loc_cDopedsRegra, THIS.this_cCursorOperacoes, "Dopes")
                            INSERT INTO (THIS.this_cCursorOperacoes) (Dopes) VALUES (loc_cDopedsRegra)
                        ENDIF

                        SELECT (THIS.this_cCursorRegras)
                    ENDSCAN

                    SELECT (THIS.this_cCursorOperacoes)
                    SET ORDER TO
                    GO TOP

                    SELECT (THIS.this_cCursorItens)
                    SET ORDER TO Dopes
                    GO TOP

                    THIS.this_nTotalOperacoes = RECCOUNT(THIS.this_cCursorOperacoes)
                    THIS.this_nTotalItens     = RECCOUNT(THIS.this_cCursorItens)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar regras de transfer" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

