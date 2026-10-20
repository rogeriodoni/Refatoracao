*==============================================================================
* Formsigopbus.prg - Dialogo de Busca de Produto (por Descricao, Codigo,
* Referencia de Fornecedor ou Descritivo)
* Form OPERACIONAL FLAT (sem PageFrame) - dialogo modal reutilizavel chamado
* por outros forms/BOs para resolver o codigo de um produto.
* Herda de: FormBase
*
* Legado (SIGOPBUS.SCX): BaseClass = form (generico), sem PageFrame, sem
* grid, sem botao CRUD - apenas 4 TextBox de criterio de busca (Get_Descricao,
* Get_Produto, Get_RefFor, get_DPro2s), cada um abrindo o picker fwBuscaExt
* (equivalente a FormBuscaAuxiliar no migrado) sobre SigCdPro, e um unico
* CommandButton "Sair".
*
* Historico de fases:
*   Fase 1/2: sigopbusBO.prg (propriedades de criterio/resultado + Init)
*   Fase 2/8: sigopbusBO.prg (CarregarDoCursor/ObterCodigoRetorno/
*             ObterFiltroSituacao/ObterChavePrimaria/LimparDados)
*   Fase 3/8: Formsigopbus.prg - estrutura base (Init, InicializarForm,
*             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
*             lbl_4c_LblTitulo). Form FLAT: o legado nao tem PageFrame nem
*             Page nenhuma - nenhum pgf_4c_* eh criado neste form (mesma
*             familia do SIGOPBIN/FormSIGOPBIN).
*   Fase 4/8 (CONCLUIDA COMO NO-OP JUSTIFICADO): nao ha Grid nem botoes
*             CRUD a acrescentar - tasks\task649\analise.json/layout.json
*             nao declaram grid nem PageFrame, e o SCX legado (SIGOPBUS)
*             nao tem UMA lista sequer: a arvore inteira (layout.json) eh
*             Form + cntSombra decorativo + 6 Label + 4 TextBox (Get_Descricao/
*             Get_Produto/Get_RefFor/get_DPro2s) + 1 CommandButton (Sair).
*             Os 4 TextBox sao campos de ENTRADA (cada um com Valid abrindo
*             fwBuscaExt sobre SigCdPro - comportamento.json confirma
*             temLookup=true nos 4 e funcoesExternas=["fwBuscaExt"]) e o
*             Sair so faz ThisForm.Release - nenhum verbo CRUD. Este eh um
*             dialogo FLAT de CAPTURA (campos editaveis, sem lista, sem
*             botao CRUD) - mesma familia do SIGMVVDE/FormSigMvVde e do
*             SIGOPBIN/FormSIGOPBIN, documentada no gate da Fase 4 do
*             OrquestradorMigracao.ps1 (ramo "layout captura"). Inventar
*             Page1/Grid/6 botoes CRUD aqui violaria o PILAR 1 (o legado eh
*             um popup de busca 412x336 com 4 campos, nao um cadastro) e a
*             regra "NUNCA inventar" (CLAUDE.md). Os 6 Label, os 4 TextBox
*             (com os respectivos Valid/lookup) e o CommandButton Sair
*             ficam para as Fases 5 a 7.
*   Fase 5/8: ConfigurarPaginaDados() - metade dos campos (layout.json, ordem
*             do dump): Label1/lbl_4c_Label1 + Get_Descricao/txt_4c_Descricao
*             (criterio Dpros) e Label3/lbl_4c_Label3 + Get_Produto/
*             txt_4c_Produto (criterio Cpros). Valor inicial de cada TextBox
*             vem do BO (this_cDpros/this_cCpros - fonte unica), sem
*             BINDEVENT ainda - o Valid/lookup fwBuscaExt de cada campo entra
*             na Fase 6, junto com Label5/Get_RefFor e Label6/get_DPro2s
*             (segunda metade). Label4 (instrucao ESC) e Sair ficam para a
*             Fase 7.
*   Fase 6/8: ConfigurarPaginaDados() - segunda metade dos campos
*             (Label5/txt_4c_RefFor - criterio Reffs; Label6/txt_4c_DPro2s -
*             criterio Dpro2s) + BINDEVENT "LostFocus" nos 4 campos +
*             metodos <Campo>LostFocus/<Campo>LostFocusExec completos
*             (equivalentes aos 4 PROCEDURE Valid do legado), com guarda
*             de reentrancia this_lEmLookup. Cada Exec abre
*             FormBuscaAuxiliar sobre SigCdPro com as colunas e o filtro
*             de situacao exatos do dump (coluna "CnjLacto" do legado
*             omitida - nao existe em SigCdPro).
*   Fase 7/8: ConfigurarBotaoSair() - Label4 (instrucao ESC, Visible=.T.
*             por default - o dump NAO sobrescreve Visible, os 4 Valid()
*             so reforcam ".t." quando ha tentativa de busca) + o unico
*             CommandButton do legado (cmd_4c_Sair, Top/Left/Width/Height/
*             Caption/Style exatos do dump). ".Cancel = .T." reproduz o
*             "[Pressione <ESC> para cancelar]" nativamente - o legado NAO
*             tem PROCEDURE KeyPress nenhuma no form nem nos TextBox para
*             ESC; eh o VFP9 que aciona o Click do botao Cancel quando o
*             usuario pressiona ESC. BtnSairClick transcreve literalmente
*             o Click do legado ("x=Inkey(.1) / ThisForm.Release" - a
*             pausa de 0.1s antes de liberar o form, regra #17/#31).
*             Corrigidos tambem 3 desvios de fidelidade (PILAR 1) achados
*             nas Fases 5/6 ao conferir o dump linha a linha: MaxLength de
*             txt_4c_Descricao (65 -> 40, o dump declara 40 para este
*             campo de CRITERIO de busca - igual aos outros 3 - a largura
*             da coluna Dpros no schema nao se aplica aqui), BackColor
*             255,255,234 ausente nos 4 TextBox (tom amarelo-claro que o
*             SCX declara em todos) e FontSize de Label1/Label3/Label5/
*             Label6 (8 -> 12, valor exato do dump).
*   Fase 8/8 (CONCLUIDA COM 1 METODO REAL + NO-OP JUSTIFICADO no resto):
*             ObterProduto() - unico item desta fase com equivalente real
*             no legado: PROCEDURE Unload / Return(Thisform.Produto). O
*             legado era aberto via "DO FORM SigOpBus WITH ... TO lcVar"
*             (o VFP captura nessa clausula o retorno do Unload); este form
*             migrado eh aberto por CREATEOBJECT + Show() modal (sem DO
*             FORM/TO), entao o metodo publico ObterProduto() eh como o
*             form chamador le o resultado - padrao identico ao irmao desta
*             mesma familia de dialogo FLAT, FormSIGOPBIN.ObterResultadoSaida()/
*             SIGOPBINBO.ObterResultadoSaida() (mesmo equivalente de Unload).
*             Seguro ler apos o Show() retornar porque THIS.Release() (que
*             os 4 LostFocusExec/BtnSairClick chamam) NAO destroi o objeto
*             enquanto o CALLER mantiver a variavel viva - FormBase.Destroy()
*             so zera this_oBusinessObject quando a ultima referencia cai
*             (loForm = .NULL. no caller), nao no instante do Release()
*             interno. Convencao de chamada: loForm = CREATEOBJECT(...) /
*             loForm.Show() / lcCodigo = loForm.ObterProduto() / loForm =
*             .NULL..
*
*             FormParaBO() / BOParaForm() / LimparCampos() - hooks REAIS,
*             nao convencao vazia de Page2 de Dados. Os 4 TextBox deste
*             dialogo sao campos EDITAVEIS que alimentam a operacao da tela
*             (a consulta a SigCdPro), e o legado le cada um deles com
*             "This.Value" dentro do proprio PROCEDURE Valid. FormParaBO()
*             centraliza essa leitura (os 4 Exec passaram a pegar o criterio
*             da property do BO, fonte unica, em vez de reler o controle);
*             BOParaForm() centraliza a carga inversa, que estava inline em
*             cada AddObject (".Value = TratarNulo(...)") e agora tem UM
*             ponto de recarga; LimparCampos() devolve o dialogo ao estado
*             do Init legado ("ThisForm.Produto = Space(14)" com os 4 campos
*             vazios - o SCX nao declara Value nem ControlSource em nenhum).
*             Os TRES sao PROTECTED porque FormBase declara os hooks
*             PROTECTED e VFP9 nao permite ALARGAR escopo de metodo herdado.
*             BOParaForm() NAO substitui o eco por campo que cada Exec faz
*             depois de uma selecao: o legado escreve SO no proprio campo
*             ("This.Value = CrListaRemota.Dpros"), e reescrever os quatro
*             ali seria desvio do PILAR 1.
*
*             Os demais itens do roteiro generico desta fase (BtnBuscarClick/
*             BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick/CarregarLista/
*             HabilitarCampos/AjustarBotoesPorModo) sao NO-OP JUSTIFICADO:
*             sao vocabulario de form CRUD (frmcadastro, Page1=Lista/
*             Page2=Dados com Confirmar/Cancelar/Encerrar) e este dialogo
*             FLAT nao tem CRUD nenhum - o legado (SIGOPBUS.SCX) nao declara
*             UM botao Buscar/Salvar/Cancelar/Encerrar, nem Grid, nem
*             PageFrame (ver nota da Fase 4), logo nao ha lista a carregar
*             nem modo de edicao a alternar. O unico botao do legado (Sair)
*             ja foi implementado na Fase 7 (BtnSairClick, transcricao
*             literal do Click) e eh ele mesmo o caminho de cancelamento,
*             com ".Cancel = .T." respondendo ao ESC - por isso nao existe
*             um "BtnCancelarClick" separado: criar um alias faria o nome
*             MENTIR sobre o objeto do legado que o handler representa.
*             Inventar esses metodos aqui violaria o PILAR 1 ("NUNCA
*             inventar", CLAUDE.md) - mesma justificativa documentada em
*             FormSIGOPBIN.prg (Fase 7/8, "CONCLUIDA COMO NO-OP
*             JUSTIFICADO").
*
*             DIVERGENCIA DECLARADA (ausencia que tem de ficar VISIVEL,
*             CLAUDE.md #27): o picker legado exibe a FOTO do produto -
*             "loLista.mAddColuna('figjpgs', .f., .f., .f., .f., .t.)", em
*             que o 6o argumento marca a coluna como IMAGEM. O
*             FormBuscaAuxiliar desta arquitetura tem mAddColuna de TRES
*             parametros (campo, mascara, titulo) e nao suporta coluna de
*             imagem, entao os 4 lookups desta tela saem SEM a miniatura.
*             A coluna figjpgs EXISTE em SigCdPro (conferido no
*             docs/schema.sql) - o que falta eh o suporte no picker, nao o
*             dado. Nao foi criado stub que finja exibir a imagem.
*
*             Tambem NAO ha equivalente a "Thisform.PodataMgr.Release" do
*             PROCEDURE Release do legado (DoDefault() + libera a conexao
*             fSqlConector criada no Init): esta arquitetura nao cria
*             conexao por form (sem poDataMgr) - sigopbusBO.Init() usa o
*             gnConnHandle global, igual a TODOS os outros BOs do projeto
*             (CCJBO, EndBO, ProdutoBO, SigOpAlCBO etc. documentam a mesma
*             substituicao). Nao ha conexao a liberar, logo nao ha Release()
*             a sobrescrever neste form.
*
*             Integracao (menu.prg): NAO adicionado item de menu. Este eh um
*             dialogo modal REUTILIZAVEL (ver cabecalho do arquivo), chamado
*             com parametros por outros forms/BOs que precisem resolver o
*             codigo de um produto - o legado nunca o expos como entrada de
*             menu independente (nenhum "DO FORM SigOpBus" solto em menu;
*             sempre invocado de dentro de outro metodo, com os 6 parametros
*             de comportamento). Adicionar entrada de menu criaria um
*             fluxo que o legado nao tem, violando o PILAR 1. SET PROCEDURE
*             nao e necessario (config.prg ja carrega Form*.prg/*BO.prg via
*             ADIR() dinamico, CLAUDE.md "config.prg - Dynamic Loading").
*==============================================================================
DEFINE CLASS Formsigopbus AS FormBase

    *-- Parametros de entrada recebidos no Init (equivalem as Lparameters do
    *-- legado: pRetorno, pSituacao, pConjunto, pCodMacro, pFiltraSit, pCnj)

    *-- Guarda de reentrancia (regra #37/#47): FormBuscaAuxiliar eh MODAL e
    *-- tira o foco do TextBox, o que redispara o proprio LostFocus.
    this_lEmLookup = .F.

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPBUS)
    Width       = 412
    Height      = 336
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    BorderStyle = 2
    Caption     = ""
    ClipControls = .F.
    AlwaysOnTop = .T.

    *--------------------------------------------------------------------------
    * Init - Recebe os parametros de comportamento do dialogo (equivale ao
    * "Lparameters pRetorno, pSituacao, pConjunto, pCodMacro, pFiltraSit, pCnj"
    * do legado) e cria o Business Object antes de inicializar a parte visual
    * (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lTipoRetorno, par_nSituas, par_lConjunto, ;
            par_lCodMacro, par_nFiltraSituas, par_lCnjLacto)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopbusBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigopbusBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigopbus.Init")
            ELSE
                *-- ThisForm.Tiporetorno = pRetorno
                THIS.this_oBusinessObject.this_lTipoRetorno = ;
                    IIF(VARTYPE(par_lTipoRetorno) = "L", par_lTipoRetorno, .F.)

                *-- ThisForm.Situas = Iif(Type('pSituacao')='N', pSituacao, 0)
                THIS.this_oBusinessObject.this_nSituas = ;
                    IIF(VARTYPE(par_nSituas) = "N", par_nSituas, 0)

                *-- ThisForm.FiltraSituas = Iif(Type('pFiltraSit')='N', pFiltraSit, 0)
                THIS.this_oBusinessObject.this_nFiltraSituas = ;
                    IIF(VARTYPE(par_nFiltraSituas) = "N", par_nFiltraSituas, 0)

                *-- ThisFOrm.Conjunto = pConjunto
                THIS.this_oBusinessObject.this_lConjunto = ;
                    IIF(VARTYPE(par_lConjunto) = "L", par_lConjunto, .F.)

                *-- ThisFOrm.CodMacro = pCodMacro
                THIS.this_oBusinessObject.this_lCodMacro = ;
                    IIF(VARTYPE(par_lCodMacro) = "L", par_lCodMacro, .F.)

                *-- ThisForm.Cnjlacto = pCnj
                THIS.this_oBusinessObject.this_lCnjLacto = ;
                    IIF(VARTYPE(par_lCnjLacto) = "L", par_lCnjLacto, .F.)

                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Monta o cabecalho (unico elemento estrutural deste form FLAT)
            THIS.ConfigurarPageFrame()

            *-- Campos de criterio de busca (Fases 5 e 6/8)
            THIS.ConfigurarPaginaDados()

            *-- Label de instrucao ESC + unico botao do dialogo (Fase 7/8)
            THIS.ConfigurarBotaoSair()

            *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
    *   Form OPERACIONAL FLAT: o legado (SIGOPBUS.SCX) nao tem PageFrame nem
    *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
    *   metodo mantido por convencao do orquestrador de migracao (nenhum
    *   AddObject("pgf_4c_...") eh feito aqui).
    *   Demais controles do legado (Label1/Get_Descricao, Label3/Get_Produto,
    *   Sair, Label4, Label5/Get_RefFor, Label6/get_DPro2s) entram em fase
    *   posterior (campos de dados / eventos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro
        TRY
            *-- cntSombra original: Top=0, Left=-2, Width=800 (-> THIS.Width),
            *-- Height=80, BackColor=100,100,100
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *-- Labels adicionados FORA do WITH do container (WITH aninhado com
            *-- AddObject ignora propriedades silenciosamente - regra conhecida)
            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Busca  de  Produto"
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = "Busca  de  Produto"
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = 769
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Campos de criterio de busca, filhos diretos do
    * form (FLAT, sem PageFrame/Page - mesma observacao da regra #30/#31 nao
    * se aplica aqui porque nao ha container intermediario).
    *
    * Fase 5/8: PRIMEIRA METADE (ordem do layout.json/dump legado):
    *   Label1        -> lbl_4c_Label1  (Top=90,  Left=52, Width=209, H=21)
    *   Get_Descricao -> txt_4c_Descricao (Top=112, Left=52, Width=295, H=23)
    *   Label3        -> lbl_4c_Label3  (Top=145, Left=52, Width=193, H=21)
    *   Get_Produto   -> txt_4c_Produto (Top=167, Left=52, Width=113, H=23)
    *
    * Fase 6/8: SEGUNDA METADE (ordem do layout.json/dump legado):
    *   Label5      -> lbl_4c_Label5  (Top=199, Left=52, Width=254, H=21)
    *   Get_RefFor  -> txt_4c_RefFor  (Top=221, Left=52, Width=160, H=23)
    *   Label6      -> lbl_4c_Label6  (Top=253, Left=52, Width=212, H=21)
    *   get_DPro2s  -> txt_4c_DPro2s  (Top=275, Left=52, Width=295, H=23)
    * mais o BINDEVENT "LostFocus" (regra #47 - o legado valida no Valid,
    * ou seja ao SAIR do campo) + os 4 metodos <Campo>LostFocus/
    * <Campo>LostFocusExec completos (logo apos TornarControlesVisiveis,
    * antes do ENDDEFINE).
    *
    * Label4 (instrucao ESC) e o CommandButton Sair entram na Fase 7/8.
    *
    * Os Say* do legado sao classe "say" pura (sem Width/Alignment no dump -
    * regra #23): AutoSize=.F. + Alignment=0 + ForeColor=RGB(90,90,90)
    * (regra #12 - nao ha container escuro aqui, a pagina eh clara).
    *
    * Valor inicial de cada TextBox vem do BO (this_cDpros/this_cCpros/
    * this_cReffs/this_cDpro2s - fonte unica, equivalente ao "ThisForm.
    * Produto = Space(14)" do Init legado que LimparDados() do BO
    * reproduz), nao de literal "". MaxLength = largura da coluna no
    * schema (Dpros char(65), Cpros char(14), Reffs char(40), Dpro2s
    * char(45) - docs/schema.sql), NUNCA o Width em pixels (regra #19).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            *-- Label1 (Say) + Get_Descricao -> criterio de busca por Descricao (Dpros)
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 12
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Busca Produto pela Descri" + CHR(231) + CHR(227) + "o"
                .Height    = 21
                .Left      = 52
                .Top       = 90
                .Width     = 209
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("txt_4c_Descricao", "TextBox")
            WITH THIS.txt_4c_Descricao
                .Value     = ""                 && carga real centralizada em BOParaForm() - fonte unica (this_cDpros)
                .MaxLength = 40
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Left      = 52
                .Top       = 112
                .Width     = 295
                .Height    = 23
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 234)
            ENDWITH

            *-- Label3 (Say) + Get_Produto -> criterio de busca por Codigo (Cpros)
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 12
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Busca Produto pelo C" + CHR(243) + "digo"
                .Height    = 21
                .Left      = 52
                .Top       = 145
                .Width     = 193
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("txt_4c_Produto", "TextBox")
            WITH THIS.txt_4c_Produto
                .Value     = ""                 && carga real centralizada em BOParaForm() - fonte unica (this_cCpros)
                .MaxLength = 14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Left      = 52
                .Top       = 167
                .Width     = 113
                .Height    = 23
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 234)
            ENDWITH

            *-- Label5 (Say) + Get_RefFor -> criterio de busca por Referencia de
            *-- Fornecedor (Reffs). MaxLength=20 eh o valor EXPLICITO do dump
            *-- legado (Reffs char(40) no schema permitiria mais, mas este eh
            *-- um campo de CRITERIO DE BUSCA, nunca gravado - a restricao de
            *-- digitacao do SCX prevalece, regra PILAR 1).
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontSize  = 12
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Busca Produto pela Ref. Fornecedor"
                .Height    = 21
                .Left      = 52
                .Top       = 199
                .Width     = 254
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("txt_4c_RefFor", "TextBox")
            WITH THIS.txt_4c_RefFor
                .Value     = ""                 && carga real centralizada em BOParaForm() - fonte unica (this_cReffs)
                .MaxLength = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Left      = 52
                .Top       = 221
                .Width     = 160
                .Height    = 23
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 234)
            ENDWITH

            *-- Label6 (Say) + get_DPro2s -> criterio de busca por Descritivo (Dpro2s)
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontName  = "Tahoma"
                .FontSize  = 12
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Busca Produto pelo Descritivo"
                .Height    = 21
                .Left      = 52
                .Top       = 253
                .Width     = 212
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("txt_4c_DPro2s", "TextBox")
            WITH THIS.txt_4c_DPro2s
                .Value     = ""                 && carga real centralizada em BOParaForm() - fonte unica (this_cDpro2s)
                .MaxLength = 40
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Left      = 52
                .Top       = 275
                .Width     = 295
                .Height    = 23
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 234)
            ENDWITH

            *-- BINDEVENT "LostFocus" nos 4 campos de criterio (regra #47 - o
            *-- legado valida no Valid, ou seja ao SAIR do campo, NUNCA em
            *-- KeyPress sem testar a tecla). Handlers completos logo apos
            *-- TornarControlesVisiveis.
            BINDEVENT(THIS.txt_4c_Descricao, "LostFocus", THIS, "DescricaoLostFocus")
            BINDEVENT(THIS.txt_4c_Produto,   "LostFocus", THIS, "ProdutoLostFocus")
            BINDEVENT(THIS.txt_4c_RefFor,    "LostFocus", THIS, "RefForLostFocus")
            BINDEVENT(THIS.txt_4c_DPro2s,    "LostFocus", THIS, "DPro2sLostFocus")

            *-- Carga INICIAL dos 4 criterios a partir do BO. Centralizada
            *-- aqui (e nao inline em cada AddObject) para que exista UM
            *-- ponto de recarga - o mesmo metodo eh reusado por
            *-- LimparCampos(). Ver nota da Fase 8/8 no cabecalho.
            THIS.BOParaForm()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoSair - Label4 (instrucao de ESC) + cmd_4c_Sair, os
    * dois unicos controles do legado que ainda faltavam (ver nota da Fase
    * 7/8 no cabecalho do arquivo).
    *
    * Label4: classe "label" pura, sem Width/Alignment no dump a nao ser
    * AutoSize=.T. - regra #23 (AutoSize eh no-op em Label criado por
    * AddObject) manda escrever AutoSize=.F. + Width/Height EXATOS do SCX
    * (219x18) em vez de confiar no auto-calculo. Visible fica no default
    * .T. (o dump NAO declara Visible para Label4 - os 4 Valid() so
    * reforcam ".t." quando ha uma tentativa de busca, redundante com o
    * estado inicial).
    *
    * cmd_4c_Sair: unico CommandButton do legado (BaseClass=commandbutton
    * puro, sem Picture no dump). .Cancel = .T. eh o que faz o VFP9
    * acionar o Click deste botao quando o usuario pressiona ESC - eh
    * exatamente o que o Label4 anuncia ("[Pressione <ESC> para
    * cancelar]"). Sem equivalente a THIS.lbl_4c_Label4.Visible = .t. aqui
    * porque o controle ja nasce visivel (ver acima).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoSair()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "[Pressione <ESC> para cancelar]"
                .Height    = 18
                .Left      = 88
                .Top       = 308
                .Width     = 219
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("cmd_4c_Sair", "CommandButton")
            WITH THIS.cmd_4c_Sair
                .Top     = 272
                .Left    = 358
                .Width   = 75
                .Height  = 75
                .Caption = "Encerrar"
                .Style   = 1
                .Cancel  = .T.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.ConfigurarBotaoSair")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - cmd_4c_Sair.Click. Transcricao literal do Click do
    * legado (regra #17/#31):
    *   PROCEDURE Click
    *   x=Inkey(.1)
    *   ThisForm.Release
    * INKEY(0.1) eh a mesma pausa de 0.1s do legado antes de liberar o
    * form (nao ha nada mais a fazer com o retorno - a variavel "x" do
    * legado tambem era descartada).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_nTecla
        loc_nTecla = INKEY(0.1)
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oErro
        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FASE 6/8 - Lookups completos dos 4 campos de criterio (equivalentes aos
    * PROCEDURE Valid de Get_Descricao/Get_Produto/Get_RefFor/get_DPro2s do
    * SIGOPBUS.SCX). Padrao: wrapper PUBLIC ligado via BINDEVENT "LostFocus"
    * (regra #47) com guarda de reentrancia this_lEmLookup (regra #37/#47 -
    * FormBuscaAuxiliar eh MODAL e tira o foco, o que redispara o proprio
    * LostFocus) + corpo em <Nome>LostFocusExec() PROTECTED, que devolve
    * .T./.F. indicando se o dialogo deve ser fechado (ThisForm.Release do
    * legado).
    *
    * Cada Exec reproduz literalmente (regra CLAUDE.md #17/#31 - transcrever,
    * nunca reescrever, mesmo quando parece estranho):
    *   - a ORDEM e o CONJUNTO de colunas do mAddColuna de cada campo (sao
    *     DIFERENTES entre si - Produto nao tem CnjLacto nem erra em ter
    *     cgrus a mais, RefFor nao tem cgrus, DPro2s troca cgrus por
    *     ObsPes/ObsPeds);
    *   - o filtro de Situacao (BO.ObterFiltroSituacao()) aplicado em
    *     Descricao/Produto/DPro2s e NUNCA em RefFor;
    *   - o campo ecoado de volta no TextBox apos a selecao: Descricao/
    *     Produto ecoam Dpros (SIM, Get_Produto.Valid tambem usa
    *     CrListaRemota.Dpros no legado - nao eh erro de transcricao, eh o
    *     dump original), RefFor ecoa Cpros, DPro2s ecoa Dpro2s;
    *   - Get_RefFor.Valid tem "ThisForm.Release" FORA do "If Not
    *     Empty(This.Value)" - o dialogo fecha ao sair do campo RefFor
    *     mesmo SEM ter digitado nada. Os outros 3 so fecham apos uma
    *     tentativa de busca (campo preenchido).
    *
    * "CnjLacto" (coluna condicional do legado quando ThisForm.CnjLacto eh
    * .T.) NAO existe em SigCdPro (docs/schema.sql, regra #14/#22/#48) -
    * omitida nos 4 campos. Conjunts e CodMacro existem e sao preservados.
    *==========================================================================

    *--------------------------------------------------------------------------
    * DescricaoLostFocus - wrapper PUBLIC (BINDEVENT) do criterio Dpros
    *--------------------------------------------------------------------------
    PROCEDURE DescricaoLostFocus()
        LOCAL loc_oErro, loc_lFechar
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        loc_lFechar = .F.
        TRY
            loc_lFechar = THIS.DescricaoLostFocusExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.DescricaoLostFocus")
        ENDTRY
        THIS.this_lEmLookup = .F.
        IF loc_lFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DescricaoLostFocusExec - Equivalente ao Valid de Get_Descricao. Busca
    * por Dpros LIKE '%valor%' (fwBuscaExt com busca parcial no legado),
    * filtrada por situacao quando aplicavel. Devolve .T. se o dialogo deve
    * ser fechado (campo nao estava vazio).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION DescricaoLostFocusExec()
        LOCAL loc_oBusca, loc_cFiltro, loc_cValor, loc_lFechar
        loc_lFechar = .F.
        *-- FormParaBO() transfere os 4 criterios digitados da tela para o BO.
        *-- O criterio desta busca eh lido DE LA (fonte unica), nunca mais do
        *-- controle - equivale ao "This.Value" do Valid legado.
        THIS.FormParaBO()
        loc_cValor  = ALLTRIM(THIS.this_oBusinessObject.this_cDpros)

        IF !EMPTY(loc_cValor)
            loc_lFechar = .T.

            IF PEMSTATUS(THIS, "lbl_4c_Label4", 5)
                THIS.lbl_4c_Label4.Visible = .T.
            ENDIF

            loc_cFiltro = THIS.this_oBusinessObject.ObterFiltroSituacao()

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProduto", "Dpros", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", .F., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dpros",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("cgrus",  "", "Grupo")
                    loc_oBusca.mAddColuna("Dpro2s", "", "Descritivo")
                    loc_oBusca.mAddColuna("PesoMs", "99,999.999", "Peso M" + CHR(233) + "dio")
                    IF THIS.this_oBusinessObject.this_lConjunto
                        loc_oBusca.mAddColuna("Conjunts", "", "Cod. Pai")
                    ENDIF
                    IF THIS.this_oBusinessObject.this_lCodMacro
                        loc_oBusca.mAddColuna("CodMacro", "", "Cod. Macro")
                    ENDIF
                    loc_oBusca.Show()
                ENDIF

                THIS.this_oBusinessObject.this_cProduto = SPACE(14)

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_BuscaProduto")
                    THIS.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDpros)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaProduto")
                USE IN cursor_4c_BuscaProduto
            ENDIF
        ENDIF

        RETURN loc_lFechar
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProdutoLostFocus - wrapper PUBLIC (BINDEVENT) do criterio Cpros
    *--------------------------------------------------------------------------
    PROCEDURE ProdutoLostFocus()
        LOCAL loc_oErro, loc_lFechar
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        loc_lFechar = .F.
        TRY
            loc_lFechar = THIS.ProdutoLostFocusExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.ProdutoLostFocus")
        ENDTRY
        THIS.this_lEmLookup = .F.
        IF loc_lFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProdutoLostFocusExec - Equivalente ao Valid de Get_Produto. Busca por
    * Cpros, filtrada por situacao quando aplicavel (legado: "If Situas=0
    * Or FiltraSituas=0" sem filtro, senao aplica o Do Case - equivalente a
    * chamar ObterFiltroSituacao() incondicionalmente, que ja tem esse
    * mesmo guard). Devolve .T. se o dialogo deve ser fechado.
    *
    * NOTA DE FIDELIDADE: o legado ecoa This.Value = CrListaRemota.Dpros
    * (a DESCRICAO, nao o Cpros) mesmo neste campo de busca por codigo -
    * confirmado linha a linha no dump (sigopbus_form_codigo_fonte.txt).
    * Preservado literalmente (regra #17/#31); sem efeito pratico porque o
    * dialogo fecha imediatamente apos.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProdutoLostFocusExec()
        LOCAL loc_oBusca, loc_cFiltro, loc_cValor, loc_lFechar
        loc_lFechar = .F.
        *-- FormParaBO() transfere os 4 criterios digitados da tela para o BO.
        *-- O criterio desta busca eh lido DE LA (fonte unica), nunca mais do
        *-- controle - equivale ao "This.Value" do Valid legado.
        THIS.FormParaBO()
        loc_cValor  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF !EMPTY(loc_cValor)
            loc_lFechar = .T.

            IF PEMSTATUS(THIS, "lbl_4c_Label4", 5)
                THIS.lbl_4c_Label4.Visible = .T.
            ENDIF

            loc_cFiltro = THIS.this_oBusinessObject.ObterFiltroSituacao()

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProduto", "Cpros", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", .F., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Dpros",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cgrus",  "", "Grupo")
                    loc_oBusca.mAddColuna("Dpro2s", "", "Descritivo")
                    loc_oBusca.mAddColuna("PesoMs", "99,999.999", "Peso M" + CHR(233) + "dio")
                    IF THIS.this_oBusinessObject.this_lConjunto
                        loc_oBusca.mAddColuna("Conjunts", "", "Cod. Pai")
                    ENDIF
                    IF THIS.this_oBusinessObject.this_lCodMacro
                        loc_oBusca.mAddColuna("CodMacro", "", "Cod. Macro")
                    ENDIF
                    loc_oBusca.Show()
                ENDIF

                THIS.this_oBusinessObject.this_cProduto = SPACE(14)

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_BuscaProduto")
                    THIS.txt_4c_Produto.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDpros)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaProduto")
                USE IN cursor_4c_BuscaProduto
            ENDIF
        ENDIF

        RETURN loc_lFechar
    ENDFUNC

    *--------------------------------------------------------------------------
    * RefForLostFocus - wrapper PUBLIC (BINDEVENT) do criterio Reffs
    *--------------------------------------------------------------------------
    PROCEDURE RefForLostFocus()
        LOCAL loc_oErro, loc_lFechar
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        loc_lFechar = .F.
        TRY
            loc_lFechar = THIS.RefForLostFocusExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.RefForLostFocus")
        ENDTRY
        THIS.this_lEmLookup = .F.
        IF loc_lFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RefForLostFocusExec - Equivalente ao Valid de Get_RefFor. Busca por
    * Reffs (ALLTRIM, sem filtro de situacao - o legado NUNCA aplica o Do
    * Case de Situas neste campo). Legado so mostra o picker "If Not
    * loLista.plAchouRegistro" (equivalente ao this_lAchouRegistro do
    * FormBuscaAuxiliar - unico dos 4 campos que ja tem esse guard no
    * dump).
    *
    * NOTA DE FIDELIDADE (regra #17/#31 - transcrever mesmo o que parece
    * estranho): no dump, "ThisForm.Release" fica FORA do "If Not
    * Empty(This.Value)" - ao contrario dos outros 3 campos, o dialogo
    * SEMPRE fecha quando o foco sai de Get_RefFor, mesmo com o campo
    * vazio (sem nenhuma busca ter sido tentada). Por isso este Exec
    * devolve .T. incondicionalmente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION RefForLostFocusExec()
        LOCAL loc_oBusca, loc_cValor

        *-- FormParaBO() transfere os 4 criterios digitados da tela para o BO.
        *-- O criterio desta busca eh lido DE LA (fonte unica), nunca mais do
        *-- controle - equivale ao "This.Value" do Valid legado.
        THIS.FormParaBO()
        loc_cValor = ALLTRIM(THIS.this_oBusinessObject.this_cReffs)

        IF !EMPTY(loc_cValor)
            IF PEMSTATUS(THIS, "lbl_4c_Label4", 5)
                THIS.lbl_4c_Label4.Visible = .T.
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProduto", "Reffs", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", .F., .F., "")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Reffs",  "", "Ref.Fornecedor")
                    loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Dpros",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Dpro2s", "", "Descritivo")
                    loc_oBusca.mAddColuna("PesoMs", "99,999.999", "Peso M" + CHR(233) + "dio")
                    IF THIS.this_oBusinessObject.this_lConjunto
                        loc_oBusca.mAddColuna("Conjunts", "", "Cod. Pai")
                    ENDIF
                    IF THIS.this_oBusinessObject.this_lCodMacro
                        loc_oBusca.mAddColuna("CodMacro", "", "Cod. Macro")
                    ENDIF
                    loc_oBusca.Show()
                ENDIF

                THIS.this_oBusinessObject.this_cProduto = SPACE(14)

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_BuscaProduto")
                    THIS.txt_4c_RefFor.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaProduto")
                USE IN cursor_4c_BuscaProduto
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * DPro2sLostFocus - wrapper PUBLIC (BINDEVENT) do criterio Dpro2s
    *--------------------------------------------------------------------------
    PROCEDURE DPro2sLostFocus()
        LOCAL loc_oErro, loc_lFechar
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        loc_lFechar = .F.
        TRY
            loc_lFechar = THIS.DPro2sLostFocusExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.DPro2sLostFocus")
        ENDTRY
        THIS.this_lEmLookup = .F.
        IF loc_lFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DPro2sLostFocusExec - Equivalente ao Valid de get_DPro2s. Busca por
    * Dpro2s LIKE '%valor%', filtrada por situacao quando aplicavel. As
    * colunas do picker trocam cgrus por ObsPes/ObsPeds (fieis ao dump -
    * este campo nao exibe Grupo, exibe as duas observacoes do produto).
    * Devolve .T. se o dialogo deve ser fechado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION DPro2sLostFocusExec()
        LOCAL loc_oBusca, loc_cFiltro, loc_cValor, loc_lFechar
        loc_lFechar = .F.
        *-- FormParaBO() transfere os 4 criterios digitados da tela para o BO.
        *-- O criterio desta busca eh lido DE LA (fonte unica), nunca mais do
        *-- controle - equivale ao "This.Value" do Valid legado.
        THIS.FormParaBO()
        loc_cValor  = ALLTRIM(THIS.this_oBusinessObject.this_cDpro2s)

        IF !EMPTY(loc_cValor)
            loc_lFechar = .T.

            IF PEMSTATUS(THIS, "lbl_4c_Label4", 5)
                THIS.lbl_4c_Label4.Visible = .T.
            ENDIF

            loc_cFiltro = THIS.this_oBusinessObject.ObterFiltroSituacao()

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProduto", "Dpro2s", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", .F., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dpro2s",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Cpros",   "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("ObsPes",  "", "Obs 1")
                    loc_oBusca.mAddColuna("ObsPeds", "", "Obs 2")
                    loc_oBusca.mAddColuna("PesoMs",  "99,999.999", "Peso M" + CHR(233) + "dio")
                    IF THIS.this_oBusinessObject.this_lConjunto
                        loc_oBusca.mAddColuna("Conjunts", "", "Cod. Pai")
                    ENDIF
                    IF THIS.this_oBusinessObject.this_lCodMacro
                        loc_oBusca.mAddColuna("CodMacro", "", "Cod. Macro")
                    ENDIF
                    loc_oBusca.Show()
                ENDIF

                THIS.this_oBusinessObject.this_cProduto = SPACE(14)

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_BuscaProduto")
                    THIS.txt_4c_DPro2s.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDpro2s)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaProduto")
                USE IN cursor_4c_BuscaProduto
            ENDIF
        ENDIF

        RETURN loc_lFechar
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere os 4 criterios de busca da tela para o Business
    * Object. NAO eh convencao vazia de Page2 de Dados: estes 4 TextBox sao
    * campos EDITAVEIS que alimentam a operacao desta tela (a consulta a
    * SigCdPro), e o legado le cada um deles com "This.Value" dentro do
    * proprio PROCEDURE Valid. Centralizar a leitura aqui da aos 4 handlers
    * UMA fonte unica para o criterio, em vez de cada um reler o controle.
    *
    * PROTECTED porque FormBase declara o hook PROTECTED e VFP9 nao permite
    * ALARGAR o escopo de metodo herdado.
    *
    * Sem guarda de "branco nao sobrescreve": aqui o branco eh SIGNIFICATIVO
    * (criterio de busca que o usuario apagou), ao contrario de tela de
    * configuracao, onde apagar o campo zeraria valor ja resolvido no Init.
    * Os PEMSTATUS existem porque o metodo tambem eh alcancavel por
    * FormBase.Salvar() antes de ConfigurarPaginaDados() ter criado os
    * controles.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                    "o inicializado.", "Formsigopbus.FormParaBO")
            ELSE
                IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
                    THIS.this_oBusinessObject.this_cDpros = ALLTRIM(THIS.txt_4c_Descricao.Value)
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
                    THIS.this_oBusinessObject.this_cCpros = ALLTRIM(THIS.txt_4c_Produto.Value)
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_RefFor", 5)
                    THIS.this_oBusinessObject.this_cReffs = ALLTRIM(THIS.txt_4c_RefFor.Value)
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_DPro2s", 5)
                    THIS.this_oBusinessObject.this_cDpro2s = ALLTRIM(THIS.txt_4c_DPro2s.Value)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Inverso de FormParaBO: escreve nos 4 TextBox o valor que
    * esta nas properties de criterio do BO. Eh o ponto UNICO de carga dos
    * campos - chamado no fim de ConfigurarPaginaDados() (carga inicial, no
    * lugar do ".Value = TratarNulo(...)" que estava inline em cada
    * AddObject) e por LimparCampos() (recarga).
    *
    * PROTECTED pelo mesmo motivo de FormParaBO (hook PROTECTED em FormBase).
    *
    * NAO substitui o eco por campo que cada Exec faz depois de uma selecao:
    * o legado escreve SO no proprio campo ("This.Value =
    * CrListaRemota.Dpros"), e reescrever os quatro ali seria desvio do
    * PILAR 1.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                    "o inicializado.", "Formsigopbus.BOParaForm")
            ELSE
                IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
                    THIS.txt_4c_Descricao.Value = TratarNulo(THIS.this_oBusinessObject.this_cDpros, "")
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
                    THIS.txt_4c_Produto.Value = TratarNulo(THIS.this_oBusinessObject.this_cCpros, "")
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_RefFor", 5)
                    THIS.txt_4c_RefFor.Value = TratarNulo(THIS.this_oBusinessObject.this_cReffs, "")
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_DPro2s", 5)
                    THIS.txt_4c_DPro2s.Value = TratarNulo(THIS.this_oBusinessObject.this_cDpro2s, "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera os 4 criterios e o resultado, devolvendo o dialogo
    * ao estado em que o Init legado o deixava ("ThisForm.Produto =
    * Space(14)", com os 4 TextBox vazios porque o SCX nao declara Value
    * nem ControlSource em nenhum deles). Delega ao BO (fonte unica dos
    * valores) e repinta a tela por BOParaForm().
    *
    * PROTECTED - FormBase declara LimparCampos() PROTECTED.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparDados()
            ENDIF
            THIS.BOParaForm()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopbus.LimparCampos")
        ENDTRY
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterProduto - Equivalente ao PROCEDURE Unload do legado:
    *   Return(Thisform.Produto)
    * O form chamador le este valor apos o Show() modal retornar, antes de
    * liberar o dialogo (ver nota da Fase 8/8 no cabecalho do arquivo).
    *--------------------------------------------------------------------------
    FUNCTION ObterProduto()
        RETURN THIS.this_oBusinessObject.ObterProduto()
    ENDFUNC

ENDDEFINE
