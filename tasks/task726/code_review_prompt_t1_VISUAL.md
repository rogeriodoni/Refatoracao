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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1456 linhas total):

*-- Linhas 49 a 69:
49: *------------------------------------------------------------------------------
50: * ESCOPO JA ENTREGUE
51: *
52: * Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump,
53: * Init (contexto do pai + BO + InicializarForm), cabecalho cinza
54: * (cntSombra -> cnt_4c_Sombra com os dois labels) e Destroy.
55: *
56: * Fase 4/8 - Grid1 -> grd_4c_Dados (ConfigurarGrid: 7 colunas, headers,
57: * fonte e cores do dump - AINDA SEM RecordSource/ControlSource, que dependem
58: * do cursor_4c_Dados so criado na Fase 8), Shape1 -> shp_4c_Shape1 decorativo
59: * e CmdCat -> cmd_4c_Encerrar (ConfigurarBotoes), nesta ordem de AddObject
60: * (identica ao dump: cabecalho, Grid1, Shape1, CmdCat).
61: *
62: * NAO existem aqui PageFrame nem pagina Lista/Dados: o SCX legado nao tem
63: * Page nenhuma (layout FLAT) e tem apenas 1 botao (CmdCat, "Encerrar") -
64: * nunca os 5 botoes CRUD do padrao frmcadastro. Inventar PageFrame Lista/
65: * Dados e botoes CRUD canonicos violaria o PILAR 1.
66: *
67: * Fase 5/8 - superficie de DADOS. Esta tela NAO tem campo solto algum: a
68: * unica superficie de dados sao as 7 celulas da grade (todas ReadOnly = .T.
69: * no dump), entao "metade dos campos da Page2" e vazio aqui por construcao -

*-- Linhas 87 a 95:
87: *       dump sao os Text1 NATIVOS das 7 Column do Grid1 (regra #18), ja
88: *       entregues com a propria grade nas Fases 4/5; o dump nao tem UM
89: *       controle de entrada fora da grade (nenhum textbox/editbox/combobox/
90: *       listbox/checkbox/optiongroup/spinner cujo Parent nao seja uma
91: *       Column). E todos sao somente-leitura no legado: Grid1.ReadOnly=.T.,
92: *       Column1..Column7.ReadOnly=.T. e Text1.ReadOnly=.T. em Column1..6
93: *       (Column7.Text1 nao declara, herda do Grid/Column - por isso o
94: *       migrado tambem nao declara la). Campo ReadOnly nao recebe lookup por
95: *       definicao: nao ha onde o usuario digitar codigo para o picker

*-- Linhas 112 a 120:
112: *       FormSigOpClp (task704: grade de 7 colunas + UM botao Encerrar, o
113: *       analogo exato desta tela) e SIGMVCHV -> FormSigMvChv.
114: *
115: *   (c) O QUE ESTA FASE ENTREGA DE VERDADE - a Fase 4 criou cmd_4c_Encerrar
116: *       (CmdCat do legado) SEM handler e SEM BINDEVENT: o unico botao da
117: *       tela estava inerte, e o usuario clicava nele sem nada acontecer. O
118: *       unico evento de controle que o dump tem - CmdCat.Click, de uma linha
119: *       so ("Release Windows") - passou a existir aqui, em BtnEncerrarClick
120: *       + BINDEVENT no fim de ConfigurarBotoes. Deixar o botao morto para

*-- Linhas 172 a 180:
172: *            "DO FORM ... TO <var>". Onde ha resultado a ler, Release()
173: *            mataria a referencia do chamador (licao do FormSigOpCtd,
174: *            task715) - nao e o caso desta tela;
175: *         5. o ESC nao precisa de segundo handler - cmd_4c_Encerrar tem
176: *            Cancel = .T. transcrito do dump, e a tecla de cancelamento
177: *            dispara o Click do proprio botao, que e justamente o evento
178: *            interceptado pelo BINDEVENT.
179: *
180: *   (d) NAO ha outro evento a portar. O dump nao tem evento algum de Grid

*-- Linhas 553 a 561:
553:                 *-- por CarregarLista no fim deste metodo - regra #41)
554:                 THIS.ConfigurarGrid()
555: 
556:                 *-- Shape1 decorativo + CmdCat -> cmd_4c_Encerrar (mesma ordem
557:                 *-- de criacao do dump: Grid1 antes, Shape1 e CmdCat depois)
558:                 THIS.ConfigurarBotoes()
559: 
560:                 *-- AddObject cria tudo com Visible = .F.
561:                 THIS.TornarControlesVisiveis()

*-- Linhas 637 a 700:
637:     *
638:     * O cabecalho e o PRIMEIRO AddObject da tela (regra #11), para que
639:     * Shape/Grid/botao criados na Fase 4 desenhem POR CIMA dele.
640:     *==========================================================================
641:     PROTECTED PROCEDURE ConfigurarCabecalho()
642:         THIS.AddObject("cnt_4c_Sombra", "Container")
643:         WITH THIS.cnt_4c_Sombra
644:             .Top           = 0
645:             .Left          = 0
646:             .Width         = THIS.Width
647:             .Height        = 80
648:             .BorderWidth   = 0
649:             .BackStyle     = 1
650:             .BackColor     = RGB(100, 100, 100)
651:             .SpecialEffect = 0
652:             .Visible       = .T.
653:         ENDWITH
654: 
655:         *-- Label de sombra: preto, efeito de relevo 1px abaixo do titulo
656:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
657:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
658:             *-- AutoSize = .F. explicito: AutoSize e NO-OP em Label criado
659:             *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
660:             *-- corta o texto (regra #23).
661:             .AutoSize      = .F.
662:             .FontName      = "Tahoma"
663:             .FontSize      = 18
664:             .FontBold      = .T.
665:             .FontUnderline = .F.
666:             .WordWrap      = .T.
667:             .Alignment     = 0
668:             .BackStyle     = 0
669:             .Caption       = THIS.Caption
670:             .Top           = 18
671:             .Left          = 10
672:             .Width         = 769
673:             .Height        = 40
674:             .ForeColor     = RGB(0, 0, 0)
675:             *-- Rotation = 0 esta no dump; e o DEFAULT, atribuicao inerte,
676:             *-- transcrita por fidelidade literal (regra #49: diferente de
677:             *-- Format/InputMask vazios, aqui o dump declara um VALOR).
678:             .Rotation      = 0
679:             .Visible       = .T.
680:         ENDWITH
681: 
682:         *-- Label do titulo: branco sobre o cinza do container OPACO - este
683:         *-- e o caso em que o branco esta CORRETO (regra #12)
684:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
685:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
686:             .AutoSize    = .F.
687:             .FontName    = "Tahoma"
688:             .FontSize    = 18
689:             .FontBold    = .T.
690:             .WordWrap    = .T.
691:             .Alignment   = 0
692:             .BackStyle   = 0
693:             .Caption     = THIS.Caption
694:             .Top         = 17
695:             .Left        = 10
696:             .Width       = 769
697:             .Height      = 46
698:             .ForeColor   = RGB(255, 255, 255)
699:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
700:             .Rotation    = 0

*-- Linhas 735 a 744:
735:     PROTECTED PROCEDURE ConfigurarGrid()
736:         THIS.AddObject("grd_4c_Dados", "Grid")
737:         WITH THIS.grd_4c_Dados
738:             .Top               = 94
739:             .Left              = 94
740:             .Width             = 611
741:             .Height            = 92
742:             .ColumnCount       = 7
743:             .FontName          = "Tahoma"
744:             .FontSize          = 8

*-- Linhas 767 a 775:
767:                 .FontName  = "Tahoma"
768:                 .FontSize  = 8
769:                 .Alignment = 2
770:                 .Caption   = "Valor"
771:                 .ForeColor = RGB(36, 84, 155)
772:             ENDWITH
773:             WITH .Text1
774:                 .FontName  = "Tahoma"
775:                 .FontSize  = 8

*-- Linhas 796 a 804:
796:                 .FontName  = "Tahoma"
797:                 .FontSize  = 8
798:                 .Alignment = 2
799:                 .Caption   = "Itens"
800:                 .ForeColor = RGB(36, 84, 155)
801:             ENDWITH
802:             WITH .Text1
803:                 .FontName  = "Tahoma"
804:                 .FontSize  = 8

*-- Linhas 825 a 833:
825:                 .FontName  = "Tahoma"
826:                 .FontSize  = 8
827:                 .Alignment = 2
828:                 .Caption   = "Mapa"
829:                 .ForeColor = RGB(36, 84, 155)
830:             ENDWITH
831:             WITH .Text1
832:                 .FontName  = "Tahoma"
833:                 .FontSize  = 8

*-- Linhas 854 a 862:
854:                 .FontName  = "Tahoma"
855:                 .FontSize  = 8
856:                 .Alignment = 2
857:                 .Caption   = "N" + CHR(227) + "o Fiscal"
858:                 .ForeColor = RGB(36, 84, 155)
859:             ENDWITH
860:             WITH .Text1
861:                 .FontName  = "Tahoma"
862:                 .FontSize  = 8

*-- Linhas 883 a 891:
883:                 .FontName  = "Tahoma"
884:                 .FontSize  = 8
885:                 .Alignment = 2
886:                 .Caption   = "Diferen" + CHR(231) + "a Mr"
887:                 .ForeColor = RGB(36, 84, 155)
888:             ENDWITH
889:             WITH .Text1
890:                 .FontName  = "Tahoma"
891:                 .FontSize  = 8

*-- Linhas 912 a 920:
912:                 .FontName  = "Tahoma"
913:                 .FontSize  = 8
914:                 .Alignment = 2
915:                 .Caption   = "Diferen" + CHR(231) + "a IT"
916:                 .ForeColor = RGB(36, 84, 155)
917:             ENDWITH
918:             WITH .Text1
919:                 .FontName    = "Tahoma"
920:                 .FontSize    = 8

*-- Linhas 939 a 947:
939:                 .FontName  = "Tahoma"
940:                 .FontSize  = 8
941:                 .Alignment = 2
942:                 .Caption   = "Caixa"
943:                 .ForeColor = RGB(36, 84, 155)
944:             ENDWITH
945:             WITH .Text1
946:                 .FontName    = "Tahoma"
947:                 .FontSize    = 8

*-- Linhas 1143 a 1157:
1143:             .Column7.Width = 33
1144: 
1145:             *-- Captions do dump
1146:             .Column1.Header1.Caption = "Valor"
1147:             .Column2.Header1.Caption = "Itens"
1148:             .Column3.Header1.Caption = "Mapa"
1149:             .Column4.Header1.Caption = "N" + CHR(227) + "o Fiscal"
1150:             .Column5.Header1.Caption = "Diferen" + CHR(231) + "a Mr"
1151:             .Column6.Header1.Caption = "Diferen" + CHR(231) + "a IT"
1152:             .Column7.Header1.Caption = "Caixa"
1153:         ENDWITH
1154: 
1155:         RETURN .T.
1156:     ENDPROC
1157: 

*-- Linhas 1249 a 1308:
1249: 
1250: 
1251:     *==========================================================================
1252:     * ConfigurarBotoes - Shape1 decorativo + CmdCat -> cmd_4c_Encerrar
1253:     *
1254:     * Dump: Shape1 Top=7 Left=698 Width=90 Height=110 BackStyle=0
1255:     *       BorderStyle=0 BorderColor=136,189,188. Left+Width=788 < 800
1256:     *       (regra #30 - controle fora do pai e recortado - cabe sem
1257:     *       ajuste).
1258:     *
1259:     * CmdCat Top=3 Left=725 Picture=cadastro_sair_60.jpg Cancel=.T.
1260:     *       Caption="Encerrar". Left+Width(725+75)=800 = Form.Width, encosta
1261:     *       exatamente na borda direita sem exceder. O botao fica dentro da
1262:     *       faixa do cabecalho (Top 0..80) de proposito - e desenhado DEPOIS
1263:     *       do cnt_4c_Sombra, logo aparece por cima (regra #11, mesmo
1264:     *       principio do bloco Saida dos forms CRUD).
1265:     *
1266:     * Width/Height=75x75 e Themes=.T.+DisabledPicture: nao vem do dump (a
1267:     * classe fwbtng do legado ja traz o tamanho via VCX), mas e o padrao
1268:     * canonico confirmado em outros dialogos OPERACIONAIS com botao
1269:     * standalone fora de container (FormSigPrGmi e demais - regra "standalone
1270:     * CommandButton com Picture precisa de Themes=.T. + DisabledPicture").
1271:     *
1272:     * Nome: o legado chama o metodo CmdCat.Click, mas o PILAR 3 pede nome
1273:     * NOVO e semantico - cmd_4c_Encerrar segue o canonico do projeto para
1274:     * botao de saida (nao cmd_4c_CmdCat, nome generico do mapeamento
1275:     * automatico).
1276:     *
1277:     * Fecha ligando o UNICO evento de controle do dump (CmdCat.Click) ao
1278:     * handler BtnEncerrarClick. O BINDEVENT fica no FIM deste metodo, depois
1279:     * do AddObject - antes dele o objeto nem existe e o bind estouraria.
1280:     *==========================================================================
1281:     PROTECTED PROCEDURE ConfigurarBotoes()
1282:         THIS.AddObject("shp_4c_Shape1", "Shape")
1283:         WITH THIS.shp_4c_Shape1
1284:             .Top         = 7
1285:             .Left        = 698
1286:             .Width       = 90
1287:             .Height      = 110
1288:             .BackStyle   = 0
1289:             .BorderStyle = 0
1290:             .BorderColor = RGB(136, 189, 188)
1291:             .Visible     = .T.
1292:         ENDWITH
1293: 
1294:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
1295:         WITH THIS.cmd_4c_Encerrar
1296:             .Top             = 3
1297:             .Left            = 725
1298:             .Height          = 75
1299:             .Width           = 75
1300:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1301:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1302:             .Cancel          = .T.
1303:             .Caption         = "Encerrar"
1304:             .FontName        = "Tahoma"
1305:             .FontBold        = .T.
1306:             .FontItalic      = .T.
1307:             .FontSize        = 8
1308:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 1319 a 1327:
1319:         *-- CmdCat.Click do legado. Alvo PUBLIC (regra #3): em metodo
1320:         *-- PROTECTED o BINDEVENT falha EM SILENCIO e o botao ficaria inerte
1321:         *-- sem erro nenhum.
1322:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1323: 
1324:         RETURN .T.
1325:     ENDPROC
1326: 
1327: 

*-- Linhas 1350 a 1358:
1350:     * entao nao ha o que reabilitar - e mexer no Enabled de uma tela que nem
1351:     * foi migrada seria inventar comportamento.
1352:     *
1353:     * Atende tambem o ESC sem segundo handler: cmd_4c_Encerrar tem
1354:     * Cancel = .T. (transcrito do dump), e a tecla de cancelamento dispara o
1355:     * evento Click do proprio botao - o MESMO evento que o BINDEVENT acima
1356:     * intercepta.
1357:     *
1358:     * PUBLIC de proposito (sem PROTECTED): alvo de BINDEVENT (regra #3).


### BO (C:\4c\projeto\app\classes\SIGOPDVMBO.prg):
*==============================================================================
* SIGOPDVMBO.prg
*
* Business Object para SIGOPDVM (Diferencas Vendas x Mapa Resumo)
*
* Este form NAO persiste em tabela propria: ele compara, para a empresa/data
* informados, os cursores ja carregados na data session do form pai
* (crCaixa, crCaixaI, crCaixaFIN, crSigFiMpi) e grava as diferencas no
* cursor crImpressao, que alimenta o Grid1.
*==============================================================================

DEFINE CLASS SIGOPDVMBO AS BusinessBase

    *-- Parametros recebidos do form pai (filtro da comparacao)
    this_cEmps = ""                 && Codigo da empresa (SigFiMpi.emps - char(3))
    this_dDatas = {}                && Data do movimento comparado

    *-- Propriedades do registro corrente de crImpressao (uma linha do Grid)
    this_cCaixas = ""               && Codigo do caixa (SigFiMpi.ncaixa - char(3))
    this_nValCxs = 0                && Valor apurado no caixa (crCaixa/crCaixaFIN)
    this_nValItens = 0              && Valor apurado nos itens (crCaixaI)
    this_nValMrs = 0                && Valor do mapa resumo (crSigFiMpi.VlContabil + Iss)
    this_nValNfs = 0                && Valor nao fiscal

    *-- Cursores de origem: aliases que o form/BO pai ja carregou na mesma
    *-- data session (crCaixa/crCaixaI/crCaixaFIN/crSigFiMpi no legado).
    *-- Ficam vazios por padrao - DefinirCursoresOrigem() os recebe do
    *-- chamador antes de GerarComparacao() rodar.
    this_cCursorCaixa = ""          && Totais por caixa  (Emps, Datas, Ecfs, Valos)
    this_cCursorCaixaItens = ""     && Totais por caixa, itens (mesmas 4 colunas)
    this_cCursorCaixaFin = ""       && Totais por caixa, financeiro (mesmas 4 colunas)
    this_cCursorMapaResumo = ""     && Mapa resumo fiscal (NCaixa, VlContabil, Iss, Isento)

    *-- Cursor de saida que alimenta o Grid1 (crImpressao no legado) -
    *-- este sim eh nosso, por isso tem nome e valor padrao proprios.
    this_cCursorDestino = "cursor_4c_Dados"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- Sem tabela persistida: a comparacao roda sobre cursores
        *-- ja presentes na data session do form pai.
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = "Caixas"

        RETURN .T.
    ENDPROC

    *====================================================================
    * FASE 2/8 - METODOS DE ACESSO AO REGISTRO E GERACAO DA COMPARACAO
    *
    * ESCOPO DESTA FASE NESTE BO
    * --------------------------
    * O trio canonico de um BO de cadastro eh CarregarDoCursor() para ler a
    * linha, Inserir() para o INSERT e Atualizar() para o UPDATE. Este BO
    * nao tem tabela propria (THIS.this_cTabela = "" no Init, de proposito):
    * conferido no dump tasks\task726\SIGOPDVM_form_codigo_fonte.txt, o SCX
    * legado nao tem UMA LINHA de gravacao - zero TABLEUPDATE(, zero
    * .AddCursor(, zero Insert/Update/Delete contra tabela do SQL Server. O
    * UNICO "Insert Into" do legado grava no cursor crImpressao, que eh
    * resultado de CALCULO (comparacao Caixa x Itens x Mapa Resumo), nao
    * persistencia de cadastro.
    *
    * Por isso:
    *   - Inserir(), Atualizar() e ExecutarExclusao() ficam SEM override: o
    *     comportamento herdado de BusinessBase (recusar a operacao e
    *     reportar pelo ExibirFalha do Salvar - regra #20) ja eh o correto,
    *     porque nao existe tabela de destino para gravar. Escrever um
    *     INSERT/UPDATE aqui exigiria adivinhar colunas de uma tabela que
    *     nao existe.
    *   - RegistrarAuditoria() segue herdado pelo mesmo motivo: a base so a
    *     chama em operacao de ESCRITA (Inserir/Atualizar/ExecutarExclusao),
    *     e esta tela nao executa nenhuma.
    *   - ObterChavePrimaria() EH sobrescrito, porque a linha corrente da
    *     grade tem identidade (o codigo do caixa).
    *   - GerarComparacao() EH o metodo que de fato produz dados nesta
    *     tela: transcricao literal do SCAN em dois passos do Init legado
    *     (regra de formula/logica legado - transcrever, nunca reescrever),
    *     substituindo as referencias a pcForm.Pagina.Dados... por
    *     THIS.this_cEmps/this_dDatas e os cursores literais crCaixa/
    *     crCaixaI/crCaixaFIN/crSigFiMpi pelos aliases recebidos via
    *     DefinirCursoresOrigem().
    *
    * ESCOPO DE CADA METODO
    * ---------------------
    *   DefinirCursoresOrigem   recebe os 4 aliases do chamador
    *   DefinirParametrosComparacao  recebe Empresa/Data do chamador
    *   GerarComparacao         transcricao do Init legado - popula o cursor
    *                           de destino com as linhas divergentes
    *   CarregarDoCursor        le a linha corrente do cursor de destino
    *   LimparDados             zera as 5 propriedades de linha
    *   ObterChavePrimaria      codigo do caixa da linha corrente
    *====================================================================

    *====================================================================
    * DefinirCursoresOrigem - recebe os aliases dos cursores de origem
    *
    * par_cCursorCaixa       - crCaixa no legado (Emps, Datas, Ecfs, Valos)
    * par_cCursorCaixaItens  - crCaixaI no legado (mesmas 4 colunas)
    * par_cCursorCaixaFin    - crCaixaFIN no legado (mesmas 4 colunas)
    * par_cCursorMapaResumo  - crSigFiMpi no legado (NCaixa, VlContabil,
    *                          Iss, Isento), ja filtrado por Empresa/Data
    *                          por quem o carregou - este BO so faz SCAN
    *                          nele, igual ao legado.
    *
    * Os 4 parametros sao OBRIGATORIOS (sem eles GerarComparacao nao tem o
    * que comparar). VARTYPE eh conferido porque um alias ausente chega
    * como .F. (logico), nunca como string vazia.
    *
    * Retorno: .T. quando os 4 vieram como texto nao vazio; .F. caso
    * contrario, com this_cMensagemErro preenchido.
    *====================================================================
    PROCEDURE DefinirCursoresOrigem(par_cCursorCaixa, par_cCursorCaixaItens, ;
            par_cCursorCaixaFin, par_cCursorMapaResumo)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        THIS.this_cCursorCaixa = IIF(VARTYPE(par_cCursorCaixa) = "C", ;
            ALLTRIM(par_cCursorCaixa), "")
        THIS.this_cCursorCaixaItens = IIF(VARTYPE(par_cCursorCaixaItens) = "C", ;
            ALLTRIM(par_cCursorCaixaItens), "")
        THIS.this_cCursorCaixaFin = IIF(VARTYPE(par_cCursorCaixaFin) = "C", ;
            ALLTRIM(par_cCursorCaixaFin), "")
        THIS.this_cCursorMapaResumo = IIF(VARTYPE(par_cCursorMapaResumo) = "C", ;
            ALLTRIM(par_cCursorMapaResumo), "")

        IF EMPTY(THIS.this_cCursorCaixa) OR EMPTY(THIS.this_cCursorCaixaItens) OR ;
                EMPTY(THIS.this_cCursorCaixaFin) OR EMPTY(THIS.this_cCursorMapaResumo)
            THIS.this_cMensagemErro = "Os cursores de caixa, itens, financeiro e " + ;
                "mapa resumo s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
        ELSE
            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DefinirParametrosComparacao - recebe Empresa e Data do chamador
    *
    * par_cEmps  - pcForm.Pagina.Dados.PageFrame1.Page1.Get_emps.Value no
    *              legado (char(3))
    * par_dDatas - pcForm.Pagina.Dados.PageFrame1.Page1.Get_datas.Value no
    *              legado (data do movimento comparado)
    *
    * VARTYPE eh conferido em par_cEmps porque TextBox.Value pode chegar
    * como .F. quando o controle nasceu sem inicializacao, e ALLTRIM de
    * logico dispara o erro 11 do VFP9. par_dDatas aceita DATE ou DATETIME
    * (ConverterParaData normaliza os dois - regra #16, TTOD so aceita
    * DATETIME).
    *
    * Retorno: .T. quando os dois vieram preenchidos; .F. caso contrario,
    * com this_cMensagemErro preenchido.
    *====================================================================
    PROCEDURE DefinirParametrosComparacao(par_cEmps, par_dDatas)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        THIS.this_cEmps = IIF(VARTYPE(par_cEmps) = "C", ALLTRIM(par_cEmps), "")
        THIS.this_dDatas = ConverterParaData(par_dDatas)

        IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_dDatas)
            THIS.this_cMensagemErro = "Informe Empresa e Data antes de comparar " + ;
                "Vendas x Mapa Resumo."
        ELSE
            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GerarComparacao - transcricao do Init legado (os dois SCAN)
    *
    * PASSO 1 (SCAN em crSigFiMpi): para cada caixa do mapa resumo, soma
    * Valos de crCaixa/crCaixaI/crCaixaFIN filtrados por Empresa + Data +
    * SUBSTR(Ecfs,1,3) = NCaixa. Se o total contabil (VlContabil + Iss +
    * Isento) nao bate com o total do caixa, OU o total do caixa nao bate
    * com o total dos itens, grava uma linha em crImpressao com
    * ValCxs = TotalCaixa - TotalFinanceiro (regra do legado: o financeiro
    * eh DESCONTADO do caixa, nao somado - regra #17, transcrever sem
    * reescrever).
    *
    * PASSO 2 (SCAN no total geral de crCaixa por caixa): cobre o caso
    * oposto - caixa com movimento mas SEM nenhuma linha no mapa resumo
    * (Locate For NCaixa = Caixa / Eof()). Aqui ValCxs eh o total do caixa
    * SEM descontar o financeiro (o legado nao desconta neste ramo - essa
    * assimetria eh regra de negocio, nao erro de transcricao) e ValMrs
    * fica 0.
    *
    * Os cursores de trabalho (equivalentes a crTotCaixa/crTotCaixaI/
    * crTotCaixaFIN do legado) usam sufixo _4c_ proprio e sao fechados no
    * fim do metodo - nao sao cursores que sobrevivem ao form.
    *
    * SELECT (loc_cMapa) + SCAN leem os campos pelo nome NU (NCaixa,
    * VlContabil, Iss, Isento) porque a area de trabalho corrente eh a do
    * cursor - a sintaxe campo nao existe em VFP9. Dentro das
    * SELECT...INTO CURSOR as variaveis locais entram com o prefixo "m."
    * (regra: SELECT VFP local referenciando var local sem "m." estoura
    * "Column ... is not found").
    *
    * Retorno: .T. quando a comparacao rodou (mesmo que zero linhas
    * divergentes tenham sido encontradas - lista vazia eh resultado
    * valido, nao erro); .F. quando faltou parametro/cursor de origem ou
    * SELECT/SCAN estourou, com this_cMensagemErro preenchido.
    *====================================================================
    PROCEDURE GerarComparacao()
        LOCAL loc_lSucesso, loc_cCaixa, loc_cItens, loc_cFin, loc_cMapa, loc_cDestino
        LOCAL loc_cAliasAnterior, loc_dData, loc_cEmps
        LOCAL loc_cCaixaAtual, loc_nVlContabil, loc_nIss, loc_nIsento
        LOCAL loc_nValCxs, loc_nValCxsFin, loc_nValItens
        LOCAL loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()

        loc_cCaixa   = ALLTRIM(THIS.this_cCursorCaixa)
        loc_cItens   = ALLTRIM(THIS.this_cCursorCaixaItens)
        loc_cFin     = ALLTRIM(THIS.this_cCursorCaixaFin)
        loc_cMapa    = ALLTRIM(THIS.this_cCursorMapaResumo)
        loc_cDestino = ALLTRIM(THIS.this_cCursorDestino)
        loc_cEmps    = ALLTRIM(THIS.this_cEmps)
        loc_dData    = THIS.this_dDatas

        TRY
            DO CASE
                CASE EMPTY(loc_cEmps) OR EMPTY(loc_dData)
                    THIS.this_cMensagemErro = "Informe Empresa e Data antes de " + ;
                        "comparar Vendas x Mapa Resumo."

                CASE EMPTY(loc_cCaixa) OR !USED(loc_cCaixa) OR ;
                     EMPTY(loc_cItens) OR !USED(loc_cItens) OR ;
                     EMPTY(loc_cFin) OR !USED(loc_cFin) OR ;
                     EMPTY(loc_cMapa) OR !USED(loc_cMapa)
                    THIS.this_cMensagemErro = "Os cursores de caixa e mapa " + ;
                        "resumo n" + CHR(227) + "o foram recebidos da tela de origem."

                CASE EMPTY(loc_cDestino)
                    THIS.this_cMensagemErro = "Cursor de destino da compara" + ;
                        CHR(231) + CHR(227) + "o n" + CHR(227) + "o definido."

                OTHERWISE
                    *-- Select crImpressao / Zap do legado - recria se nao
                    *-- existir, esvazia se ja existir (mesma estrutura em
                    *-- cada ponto de criacao - regra de CREATE CURSOR).
                    IF USED(loc_cDestino)
                        SELECT (loc_cDestino)
                        ZAP
                    ELSE
                        CREATE CURSOR (loc_cDestino) ;
                            (Datas T, Emps C(3), Caixas C(3), ValCxs N(14,2), ;
                             ValItens N(14,2), ValMrs N(14,2), ValNfs N(14,2))
                    ENDIF

                    IF USED("crTotCaixa_4c")
                        USE IN crTotCaixa_4c
                    ENDIF
                    IF USED("crTotCaixaI_4c")
                        USE IN crTotCaixaI_4c
                    ENDIF
                    IF USED("crTotCaixaFIN_4c")
                        USE IN crTotCaixaFIN_4c
                    ENDIF
                    IF USED("crTotCaixaGeral_4c")
                        USE IN crTotCaixaGeral_4c
                    ENDIF
                    IF USED("crTotCaixaI2_4c")
                        USE IN crTotCaixaI2_4c
                    ENDIF

                    *-- PASSO 1 - Scan crSigFiMpi (legado: "Select crSigFiMpi / Scan")
                    SELECT (loc_cMapa)
                    SCAN
                        loc_cCaixaAtual = NCaixa
                        loc_nVlContabil = TratarNulo(VlContabil, 0)
                        loc_nIss = TratarNulo(Iss, 0)
                        loc_nIsento = TratarNulo(Isento, 0)

                        SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                            FROM (loc_cCaixa) ;
                            WHERE Emps = m.loc_cEmps ;
                              AND Datas = m.loc_dData ;
                              AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                            GROUP BY 1 INTO CURSOR crTotCaixa_4c READWRITE
                        loc_nValCxs = TratarNulo(crTotCaixa_4c.Valos, 0)

                        SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                            FROM (loc_cItens) ;
                            WHERE Emps = m.loc_cEmps ;
                              AND Datas = m.loc_dData ;
                              AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                            GROUP BY 1 INTO CURSOR crTotCaixaI_4c READWRITE
                        loc_nValItens = TratarNulo(crTotCaixaI_4c.Valos, 0)

                        SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                            FROM (loc_cFin) ;
                            WHERE Emps = m.loc_cEmps ;
                              AND Datas = m.loc_dData ;
                              AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                            GROUP BY 1 INTO CURSOR crTotCaixaFIN_4c READWRITE
                        loc_nValCxsFin = TratarNulo(crTotCaixaFIN_4c.Valos, 0)

                        IF ROUND(loc_nVlContabil, 2) + ROUND(loc_nIss, 2) + ;
                                ROUND(loc_nIsento, 2) <> ROUND(loc_nValCxs, 2) OR ;
                                ROUND(loc_nValCxs, 2) <> ROUND(loc_nValItens, 2)
                            INSERT INTO (loc_cDestino) ;
                                (Datas, Emps, Caixas, ValCxs, ValItens, ValMrs) ;
                                VALUES (loc_dData, loc_cEmps, loc_cCaixaAtual, ;
                                    loc_nValCxs - loc_nValCxsFin, loc_nValItens, ;
                                    loc_nVlContabil + loc_nIss)
                        ENDIF

                        SELECT (loc_cMapa)
                    ENDSCAN

                    *-- PASSO 2 - total geral de crCaixa por caixa (legado repete
                    *-- o mesmo Select, sem o filtro de NCaixa, antes do 2o Scan)
                    SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                        FROM (loc_cCaixa) ;
                        WHERE Emps = m.loc_cEmps ;
                          AND Datas = m.loc_dData ;
                        GROUP BY 1 INTO CURSOR crTotCaixaGeral_4c READWRITE

                    SELECT crTotCaixaGeral_4c
                    SCAN
                        loc_cCaixaAtual = cCaixas
                        loc_nValCxs = TratarNulo(Valos, 0)

                        SELECT (loc_cMapa)
                        LOCATE FOR NCaixa = loc_cCaixaAtual

                        IF EOF()
                            SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                                FROM (loc_cItens) ;
                                WHERE Emps = m.loc_cEmps ;
                                  AND Datas = m.loc_dData ;
                                  AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                                GROUP BY 1 INTO CURSOR crTotCaixaI2_4c READWRITE
                            loc_nValItens = TratarNulo(crTotCaixaI2_4c.Valos, 0)

                            INSERT INTO (loc_cDestino) ;
                                (Datas, Emps, Caixas, ValCxs, ValItens, ValMrs) ;
                                VALUES (loc_dData, loc_cEmps, loc_cCaixaAtual, ;
                                    loc_nValCxs, loc_nValItens, 0)
                        ENDIF

                        SELECT crTotCaixaGeral_4c
                    ENDSCAN

                    *-- Select crImpressao / Index On Caixas Tag Caixas / Go Top
                    SELECT (loc_cDestino)
                    IF TAGNO("Caixas", "", loc_cDestino) = 0
                        INDEX ON Caixas TAG Caixas
                    ENDIF
                    SET ORDER TO TAG Caixas
                    GO TOP

                    IF USED("crTotCaixa_4c")
                        USE IN crTotCaixa_4c
                    ENDIF
                    IF USED("crTotCaixaI_4c")
                        USE IN crTotCaixaI_4c
                    ENDIF
                    IF USED("crTotCaixaFIN_4c")
                        USE IN crTotCaixaFIN_4c
                    ENDIF
                    IF USED("crTotCaixaGeral_4c")
                        USE IN crTotCaixaGeral_4c
                    ENDIF
                    IF USED("crTotCaixaI2_4c")
                        USE IN crTotCaixaI2_4c
                    ENDIF

                    THIS.this_cMensagemErro = ""
                    loc_lSucesso = .T.
            ENDCASE
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em GerarComparacao")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - le a linha corrente do cursor de destino
    *
    * par_cAliasCursor - alias a ler. Normalmente THIS.this_cCursorDestino,
    *                    mas fica parametrizado para manter a assinatura da
    *                    base (BusinessBase.CarregarDoCursor(pcCursor)).
    *
    * SELECT (alias) antes de tocar nos campos - a sintaxe campo
    * nao existe em VFP9. A area de trabalho anterior eh restaurada no fim
    * (sessao compartilhada com o chamador). A existencia de cada coluna eh
    * conferida com TYPE(alias + ".campo"), nunca com PEMSTATUS (que exige
    * objeto no 1o argumento e estoura com alias de cursor).
    *
    * Retorno: .T. quando havia linha e as 5 propriedades foram
    * preenchidas; .F. quando o alias nao existe, esta em EOF/BOF ou nao
    * tem a estrutura esperada - nesse caso as propriedades sao zeradas.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior, loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        IF EMPTY(loc_cAlias)
            loc_cAlias = ALLTRIM(THIS.this_cCursorDestino)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) ;
                    AND TYPE(loc_cAlias + ".Caixas") != "U" ;
                    AND TYPE(loc_cAlias + ".ValCxs") != "U" ;
                    AND TYPE(loc_cAlias + ".ValItens") != "U" ;
                    AND TYPE(loc_cAlias + ".ValMrs") != "U" ;
                    AND TYPE(loc_cAlias + ".ValNfs") != "U"

                SELECT (loc_cAlias)

                IF !EOF() AND !BOF()
                    THIS.this_cCaixas = ALLTRIM(TratarNulo(Caixas, ""))
                    THIS.this_nValCxs = TratarNulo(ValCxs, 0)
                    THIS.this_nValItens = TratarNulo(ValItens, 0)
                    THIS.this_nValMrs = TratarNulo(ValMrs, 0)
                    THIS.this_nValNfs = TratarNulo(ValNfs, 0)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF !loc_lSucesso
                *-- Sem linha para ler: zera, para a tela nao exibir o resto
                *-- de uma leitura anterior como se fosse a linha atual.
                THIS.this_cCaixas = ""
                THIS.this_nValCxs = 0
                THIS.this_nValItens = 0
                THIS.this_nValMrs = 0
                THIS.this_nValNfs = 0
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - zera as propriedades de linha
    *
    * DODEFAULT() limpa this_cMensagemErro na base. Os parametros da
    * comparacao (this_cEmps/this_dDatas) e os aliases dos cursores de
    * origem/destino NAO sao limpos aqui de proposito: eles identificam a
    * CONSULTA aberta na tela, nao a linha selecionada.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCaixas = ""
        THIS.this_nValCxs = 0
        THIS.this_nValItens = 0
        THIS.this_nValMrs = 0
        THIS.this_nValNfs = 0
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - identidade da linha corrente da grade
    *
    * Sobrescreve o hook de BusinessBase. Continua PROTECTED porque na base
    * ele eh PROTECTED: de fora ninguem chama este metodo (regra #51).
    *
    * A chave eh o codigo do caixa (coluna unica, nao composta - diferente
    * da regra #42 de chave posicional concatenada, que nao se aplica aqui
    * porque so ha UM campo).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCaixas)
    ENDPROC

ENDDEFINE

