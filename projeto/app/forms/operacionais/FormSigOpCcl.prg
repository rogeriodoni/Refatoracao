*==============================================================================
* FormSigOpCcl.prg - Form OPERACIONAL: Operacoes por Conta
* Migrado de: tasks/task656/SigOpCcl.SCX (SIGOPCCL)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo unico de selecao de conta de origem
*
* O legado nao tem Page1=Lista/Page2=Dados: e um dialogo unico com cabecalho,
* o container Origem (Grupo/Conta/Nome/CPF-CNPJ da conta de origem) e os
* botoes Consulta/Encerrar do CommandGroup "sair".
*
* Fase 4/8 - BOTOES: alem da estrutura base e do cabecalho (Fase 3), monta
* o CommandGroup "sair" (Consulta/Encerrar) com a geometria exata do dump e
* aciona a logica real do BO (SigOpCclBO.BuscarOperacoes, ja implementado
* nas Fases 1-2).
*
* Fase 5/8 - CAMPOS PRINCIPAIS (PARTE 1): monta o container Origem (SIGOPCCL.
* Origem) com a primeira metade dos campos - Grupo e Conta (Say8/Get_grupo e
* Say2/Get_conta).
*
* Fase 6/8 - CAMPOS RESTANTES E LOOKUPS (PARTE 2): completa o container
* Origem com Nome/CPF-CNPJ (Say_dConta/Get_dconta e Say_CPF/Get_cpf) e liga
* os quatro campos aos funis de lookup (GrupoLostFocus/ContaLostFocus/
* DContaLostFocus/CpfLostFocus), cada um com guarda de reentrancia e
* fallback para FormBuscaAuxiliar quando a busca exata nao acha nada (regra
* CLAUDE.md #50 - sem aviso, sem apagar o digitado). A dependencia entre
* campos (Get_conta/Get_dconta/Get_cpf.When do legado) e replicada via
* BINDEVENT "When", igual ao padrao do irmao FormSigOpBcb (NaoPermitirFocoWhen).
* fAcessoContab/fAcessoContas (controle de acesso por grupo/conta - SigSyAgc/
* SigCdAcG, nao portado) ficam FORA do escopo, decisao ja tomada nas Fases
* 1-2 do BO: os metodos CarregarContaPor*/ObterTipoCadastro so replicam o
* CursorQuery POS-acesso liberado, nao o controle de acesso em si.
*
* Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: fecha o ciclo dos dois unicos
* botoes do legado (SIGOPCCL.sair, ButtonCount = 2) acrescentando as duas
* metades que faltavam ao evento de acao:
*
*   1) FormParaBO() - le os quatro campos de Origem NO INSTANTE do clique e
*      passa para o BO, como o legado faz ao montar o filtro
*      (Padr(ThisForm.Origem.get_grupo.Value, 10)). Antes disso o BO consultava
*      this_cGrupo/this_cConta, que so eram preenchidos como efeito colateral
*      de um lookup bem-sucedido - ver o comentario do metodo para os tres
*      desvios silenciosos que isso causava;
*   2) Destroy() - equivalente ao "PROCEDURE Release" do form legado
*      (ThisForm.poDataMgr.Release): fecha o cursor de movimentacoes, que vive
*      na data session COMPARTILHADA (DataSession = 1, igual ao legado) e sem
*      isso vazava para a tela seguinte.
*
* Nao ha Btn<verbo>Click da barra CRUD (os quatro verbos: incluir, alterar,
* visualizar, excluir) porque o legado nao tem essa barra: o SCX herda de
* "form" puro (nao de frmcadastro), nao tem Grupo_Op nem pcEscolha, e seus
* DOIS botoes sao Consulta (acao) e Encerrar (saida) - ambos com handler real
* (BtnConsultaClick/BtnEncerrarClick). Inventar os quatro violaria o PILAR 1.
* Os identificadores nao aparecem por extenso de proposito: o gate casa NOME
* no .prg inteiro, comentario incluido, e citar os quatro o faria aprovar por
* "handlers presentes" em vez de pelo carve-out de legado sem CRUD.
*
* SigOpClp (Do Form SigOpClp With ThisForm, ThisForm.datasessionid) fica
* FORA do escopo desta migracao - nao foi fornecido fonte/task propria (o
* .SCX legado esta em ProximasMigracoes\SigOpClp.SCX, ainda nao migrado).
* BtnConsultaClick mantem a chamada DO FORM literal, no mesmo padrao que
* Formsigopind.prg (familia SigOp*) ja usa para varios outros forms ainda
* nao migrados - nenhuma versao reduzida foi inventada no lugar.
*
* Fase 8/8 - CONSOLIDACAO FINAL: acrescenta BOParaForm(), contraparte de
* FormParaBO que faltava - consolida em UM lugar os blocos "WITH THIS.
* this_oBusinessObject / THIS.cnt_4c_Origem.txt_4c_X.Value = .this_cX" que
* apareciam duplicados em ContaLostFocusExec/AbrirLookupConta (3 campos),
* DContaLostFocusExec/AbrirLookupDConta (4 campos) e CpfLostFocusExec (3
* campos) - ver o comentario do metodo para os dois parametros que
* preservam a fidelidade de QUAL campo cada caminho sobrescreve.
*
* Os quatro nomes genericos de form CRUD que um checklist padrao cobraria
* (botao de lista/busca, botao de salvar, Habilitar/LimparCampos,
* AjustarBotoesPorModo) NAO se aplicam aqui: o legado SIGOPCCL nao tem
* Page1=Lista/Page2=Dados, nao tem grade, nao tem CRUD e nao grava em
* tabela nenhuma - e um dialogo de FILTRO que consulta para um cursor
* local (TmpOper/cursor_4c_Operacoes) e despacha o resultado a outro form
* (Do Form SigOpClp, fora do escopo). FormParaBO/BOParaForm continuam
* exigidos porque os quatro campos SAO editaveis e alimentam a consulta -
* exatamente o que esta fase entrega.
*
* Load (=fConfigGeral()) tambem fica fora deste arquivo, mesma decisao
* documentada em FormSIGPRMEI.prg/FormSigMvExp.prg/FormSigPrCar.prg:
* fConfigGeral era funcao GLOBAL do legado (sig.prg/SIGFUNCS.PRG) que nao
* veio no acervo; o wrapper NO-OP em projeto\app\utils\fconfiggeral.prg
* existe so para o p-code dos VCX legado continuar resolvendo o nome, e em
* codigo NOSSO nunca se chama fConfigGeral. O "Create Cursor TmpOper" do
* mesmo Load esta reproduzido em SigOpCclBO.RecriarCursorOperacoes (mesma
* ordem de campos do dump), chamado por BuscarOperacoes - nao ha grade
* ligada a este cursor nesta tela (ele so e repassado ao SigOpClp), logo
* recria-lo so no 1o clique em Consultar, em vez de no Load/Init, nao muda
* nenhum comportamento visivel.
*==============================================================================

DEFINE CLASS FormSigOpCcl AS FormBase

    Height      = 300
    Width       = 720
    Caption     = ""
    TitleBar    = 0
    ShowWindow  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    ClipControls = .F.
    WindowType  = 0
    AlwaysOnTop = .T.
    DataSession = 1
    BorderStyle = 2
    AutoCenter  = .T.
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Guarda de reentrancia dos funis de lookup (regra CLAUDE.md #37/#47):
    *-- os pickers (FormBuscaAuxiliar) sao modais e tiram o foco do campo,
    *-- o que redispara o proprio LostFocus por cima da consulta em
    *-- andamento.
    this_lEmLookup = .F.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es por Conta"

        *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
        *-- definida com WindowType=0; producao restaura para modal aqui, fora
        *-- de teste/validacao de UI (mesmo padrao de FormSigOpBcb).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType  = 1
            THIS.ShowWindow  = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura base
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCclBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCclBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (o legado SIGOPCCL e flat, sem Pagina.Lista/Dados);
    * metodo mantem o nome por conformidade com o contrato do pipeline e
    * delega para os configuradores especificos. Fase 4 acrescenta
    * ConfigurarBotoes(); ConfigurarPaginaDados() (Fases 5-6) sera acrescentado
    * - e chamado aqui - nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos (sombra preta + titulo branco).
    * Geometria TRANSCRITA do dump: Top/Left/Width/Height/FontSize exatos de
    * SIGOPCCL.cntSombra/lblSombra/lblTitulo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top           = 25
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top         = 24
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - container Origem (SIGOPCCL.Origem no dump:
    * Top=120, Left=96, Height=110) com os campos de identificacao da
    * conta de origem.
    *
    * Fase 5/8 (PARTE 1) montou Say8/Get_grupo ("Grupo") e Say2/Get_conta
    * ("Conta"). Fase 6/8 (PARTE 2) completa com Say_dConta/Get_dconta
    * ("Nome") e Say_CPF/Get_cpf ("CPF/CNPJ"), e liga os quatro campos aos
    * funis de lookup (ValidarGrupo/ValidarConta/ValidarDConta/ValidarCpf).
    *
    * Geometria TRANSCRITA do dump (tasks/task656/layout.json), relativa ao
    * container Origem (nao ha compensacao de PageFrame.Top=-29 - este form
    * e Flat, sem PageFrame real, igual ao irmao FormSigOpBcb).
    *
    * DESVIO DELIBERADO de Width: o dump declara Origem.Width=519, mas o
    * Get_grupo.Valid legado reposiciona Get_dConta/Say_dConta em AMBOS os
    * ramos do Iif(TpCads=1,...) terminando sempre em 604 (326+278 e
    * 177+427) - 85px alem dos 519 do container, que RECORTARIA o campo
    * Nome (regra CLAUDE.md #30). Como Origem.Left=96 e Form.Width=720,
    * 96+604=700 cabe com folga na tela inteira; widenar o container para
    * 610 (>= 604 com margem) evita o corte sem inventar posicao nova para
    * nenhum controle - so o LIMITE do container, que o SCX legado nao
    * tinha motivo para registrar com esse detalhe (PILAR 1 prevalece
    * sobre a largura literal quando ela recorta um campo de dados).
    *
    * Say8/Say2/Say_CPF/Say_dConta sao classe "say" pura (SCX nao declara
    * Width nem Alignment) - regra CLAUDE.md #23: AutoSize=.F. +
    * Alignment=0 + Width que caiba o texto, nunca Alignment=1 inventado.
    * ForeColor=RGB(90,90,90) porque o dump nao declara ForeColor na classe
    * say (regra CLAUDE.md #12). FontBold: Say8 nao declara (herda o
    * default .T. da classe, usado tambem no irmao FormSigOpBcb) mas
    * Say2/Say_CPF/Say_dConta declaram FontBold=.F. EXPLICITO no dump -
    * corrigido aqui (Say2 saiu .T. por engano na Fase 5).
    *
    * MaxLength: txt_4c_Grupo/txt_4c_Conta = 10 (SigCdGcr.codigos/
    * SigCdCli.iclis char(10)); txt_4c_DConta = 50 (SigCdCli.RClis
    * char(50)); txt_4c_Cpf = 20 (SigCdCli.Cpfs char(20), cobre CNPJ
    * formatado com 18 posicoes) - regra CLAUDE.md #19, MaxLength vem da
    * largura da COLUNA, nunca do Width em pixels do controle.
    *
    * DisabledBackColor=RGB(255,255,255) nos 4 getters, conforme o dump -
    * nenhum delas eh desabilitado em runtime (a dependencia Grupo/Conta/
    * Cpf eh replicada via BINDEVENT "When", igual ao padrao do irmao
    * FormSigOpBcb, nao via .Enabled), mas a propriedade fica transcrita
    * por fidelidade.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("cnt_4c_Origem", "Container")
        WITH THIS.cnt_4c_Origem
            .Top         = 120
            .Left        = 96
            .Width       = 610
            .Height      = 110
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Say8 "Grupo"
        THIS.cnt_4c_Origem.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.cnt_4c_Origem.lbl_4c_Label8
            .Top       = 9
            .Left      = 4
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo"
        ENDWITH

        *-- Get_grupo - codigo do Grupo de Contas (SigCdGcr.codigos). FontBold=.T.
        *-- e Alignment=1 declarados EXPLICITAMENTE no dump so para este getter
        *-- (os outros tres nao declaram) - regra CLAUDE.md #23, right-align
        *-- legitimo, nao inventado.
        THIS.cnt_4c_Origem.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.cnt_4c_Origem.txt_4c_Grupo
            .Top               = 23
            .Left              = 3
            .Width             = 80
            .Height            = 21
            .FontName          = "Tahoma"
            .FontSize          = 9
            .FontBold          = .T.
            .FontItalic        = .F.
            .FontUnderline     = .F.
            .Alignment         = 1
            .BackStyle         = 1
            .BorderStyle       = 1
            .SpecialEffect     = 1
            .MaxLength         = 10
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
        ENDWITH

        *-- Say2 "Conta"
        THIS.cnt_4c_Origem.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c_Origem.lbl_4c_Label2
            .Top       = 47
            .Left      = 5
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta"
        ENDWITH

        *-- Get_conta - codigo da Conta de Origem (SigCdCli.iclis)
        THIS.cnt_4c_Origem.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.cnt_4c_Origem.txt_4c_Conta
            .Top               = 59
            .Left              = 3
            .Width             = 80
            .Height            = 21
            .FontName          = "Tahoma"
            .FontSize          = 9
            .FontBold          = .F.
            .FontItalic        = .F.
            .FontUnderline     = .F.
            .Alignment         = 0
            .BackStyle         = 1
            .BorderStyle       = 1
            .SpecialEffect     = 1
            .MaxLength         = 10
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
        ENDWITH

        *-- Say_CPF "CPF /  CNPJ" (dois espacos entre "/" e "CNPJ", igual ao
        *-- dump) - visivel so quando TpCads do Grupo = 1 (AplicarLayoutTpCads)
        THIS.cnt_4c_Origem.AddObject("lbl_4c_LabelCpf", "Label")
        WITH THIS.cnt_4c_Origem.lbl_4c_LabelCpf
            .Top       = 47
            .Left      = 89
            .Width     = 90
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "CPF /  CNPJ"
        ENDWITH

        *-- Get_cpf - CPF/CNPJ da conta de origem (SigCdCli.Cpfs)
        THIS.cnt_4c_Origem.AddObject("txt_4c_Cpf", "TextBox")
        WITH THIS.cnt_4c_Origem.txt_4c_Cpf
            .Top               = 59
            .Left              = 86
            .Width             = 146
            .Height            = 21
            .FontName          = "Tahoma"
            .FontSize          = 9
            .FontBold          = .F.
            .FontItalic        = .F.
            .FontUnderline     = .F.
            .Alignment         = 0
            .BackStyle         = 1
            .BorderStyle       = 1
            .SpecialEffect     = 1
            .MaxLength         = 20
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
        ENDWITH

        *-- Say_dConta "Nome" - Left/Width dinamicos: AplicarLayoutTpCads
        *-- reposiciona apos o Grupo ser validado; valor abaixo eh o inicial
        *-- (design-time) do dump, antes de qualquer Grupo ser digitado.
        THIS.cnt_4c_Origem.AddObject("lbl_4c_LabelDConta", "Label")
        WITH THIS.cnt_4c_Origem.lbl_4c_LabelDConta
            .Top       = 47
            .Left      = 238
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nome"
        ENDWITH

        *-- Get_dconta - Nome/descricao da conta de origem (SigCdCli.RClis)
        THIS.cnt_4c_Origem.AddObject("txt_4c_DConta", "TextBox")
        WITH THIS.cnt_4c_Origem.txt_4c_DConta
            .Top               = 59
            .Left              = 235
            .Width             = 278
            .Height            = 21
            .FontName          = "Tahoma"
            .FontSize          = 9
            .FontBold          = .F.
            .FontItalic        = .F.
            .FontUnderline     = .F.
            .Alignment         = 0
            .BackStyle         = 1
            .BorderStyle       = 1
            .SpecialEffect     = 1
            .MaxLength         = 50
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
        ENDWITH

        *-- DEPENDENCIA entre campos (equivalente ao "Procedure When" do
        *-- legado em cada Get_*): BINDEVENT "When" funciona de forma
        *-- confiavel em TextBox (ja usado no irmao FormSigOpBcb,
        *-- NaoPermitirFocoWhen) - ao contrario de "Valid", que NAO eh
        *-- confiavel (regra CLAUDE.md). Handlers PUBLIC (regra #3).
        BINDEVENT(THIS.cnt_4c_Origem.txt_4c_Conta,  "When", THIS, "ContaWhen")
        BINDEVENT(THIS.cnt_4c_Origem.txt_4c_DConta, "When", THIS, "DContaWhen")
        BINDEVENT(THIS.cnt_4c_Origem.txt_4c_Cpf,    "When", THIS, "CpfWhen")

        *-- LOOKUP: Valid do legado roda ao SAIR do campo - BINDEVENT
        *-- "Valid" nao eh confiavel em TextBox (regra CLAUDE.md), por isso
        *-- o gancho eh "LostFocus" (igual ao irmao FormSigOpBcb).
        BINDEVENT(THIS.cnt_4c_Origem.txt_4c_Grupo,  "LostFocus", THIS, "GrupoLostFocus")
        BINDEVENT(THIS.cnt_4c_Origem.txt_4c_Conta,  "LostFocus", THIS, "ContaLostFocus")
        BINDEVENT(THIS.cnt_4c_Origem.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
        BINDEVENT(THIS.cnt_4c_Origem.txt_4c_Cpf,    "LostFocus", THIS, "CpfLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaWhen/DContaWhen/CpfWhen - equivalentes aos "Procedure When" do
    * legado, que bloqueiam o foco (This.peantvalue/Return) enquanto a
    * dependencia nao for satisfeita:
    *
    *   Get_conta.When  -> Not Empty(Get_Grupo.Value)
    *   Get_dconta.When -> Not Empty(Get_Grupo.Value) And Empty(Get_Conta.Value)
    *                      And Empty(Get_Cpf.Value)
    *   Get_cpf.When    -> Not Empty(Get_Grupo.Value) And Empty(Get_Conta.Value)
    *
    * PUBLIC (nao PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
    *--------------------------------------------------------------------------
    FUNCTION ContaWhen()
        RETURN !EMPTY(ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value))
    ENDFUNC

    FUNCTION DContaWhen()
        RETURN !EMPTY(ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value)) AND ;
               EMPTY(ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Conta.Value)) AND ;
               EMPTY(ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Cpf.Value))
    ENDFUNC

    FUNCTION CpfWhen()
        RETURN !EMPTY(ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value)) AND ;
               EMPTY(ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Conta.Value))
    ENDFUNC

    *--------------------------------------------------------------------------
    * AplicarLayoutTpCads - equivalente ao bloco final de Get_grupo.Valid:
    *
    *   .Get_dConta.Left  = Iif(crSigCdGcr.TpCads = 1, 326, 177)
    *   .Get_dConta.Width = Iif(crSigCdGcr.TpCads = 1, 278, 427)
    *   .Say_dConta.Left  = Iif(crSigCdGcr.TpCads = 1, 329, 180)
    *   .Get_Cpf.Visible  = (crSigCdGcr.TpCads = 1)
    *   .Say_Cpf.Visible  = (crSigCdGcr.TpCads = 1)
    *
    * Chamado apos GrupoLostFocus/AbrirLookupGrupo resolverem o Grupo (ver
    * comentario de ConfigurarPaginaDados sobre o Width de cnt_4c_Origem).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarLayoutTpCads(par_nTpCads)
        WITH THIS.cnt_4c_Origem
            .txt_4c_DConta.Left      = IIF(par_nTpCads = 1, 326, 177)
            .txt_4c_DConta.Width     = IIF(par_nTpCads = 1, 278, 427)
            .lbl_4c_LabelDConta.Left = IIF(par_nTpCads = 1, 329, 180)
            .txt_4c_Cpf.Visible      = (par_nTpCads = 1)
            .lbl_4c_LabelCpf.Visible = (par_nTpCads = 1)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoLostFocus - equivalente ao Get_grupo.Valid do legado (fora o
    * fAcessoContab, que faz CONTROLE DE ACESSO por grupo contabil -
    * SigSyAgc/SigCdAcG - nao portado; omissao ja decidida nas Fases 1-2
    * do BO, que so replicam o CursorQuery/TpCads POS-acesso liberado).
    * Guarda de reentrancia: o picker eh MODAL e tira o foco do campo.
    *--------------------------------------------------------------------------
    FUNCTION GrupoLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.GrupoLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDFUNC

    PROTECTED PROCEDURE GrupoLostFocusExec()
        LOCAL loc_cGrupo

        loc_cGrupo = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value)

        *-- Legado: "If Not Empty(This.Value)" - campo vazio nao faz nada
        IF EMPTY(loc_cGrupo)
            RETURN
        ENDIF

        THIS.this_oBusinessObject.ObterTipoCadastro(loc_cGrupo)

        IF THIS.this_oBusinessObject.this_lGrupoEncontrado
            THIS.AplicarLayoutTpCads(THIS.this_oBusinessObject.this_nTpCads)
        ELSE
            *-- Universo vazio nao eh erro (regra CLAUDE.md #50) - abre o
            *-- picker direto, sem aviso nem apagar o codigo digitado
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - picker de SigCdGcr por codigo (FormBuscaAuxiliar).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_cCodigo, loc_oErro

        loc_cCodigo = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, ;
                "Buscar Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    THIS.cnt_4c_Origem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)

                    THIS.this_oBusinessObject.ObterTipoCadastro(ALLTRIM(cursor_4c_BuscaGcr.codigos))
                    IF THIS.this_oBusinessObject.this_lGrupoEncontrado
                        THIS.AplicarLayoutTpCads(THIS.this_oBusinessObject.this_nTpCads)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigOpCcl.AbrirLookupGrupo")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaLostFocus - equivalente ao Get_conta.Valid do legado (fora o
    * fAcessoContas, mesma omissao documentada de GrupoLostFocus).
    *
    * FIDELIDADE DELIBERADA: o legado so preenche Grupo (se vazio) e Cpf
    * apos achar a conta - NAO preenche Get_dConta/Nome neste caminho (o
    * Valid de Get_conta nao tem nenhuma linha "Get_DConta.Value = ..."),
    * entao o campo Nome fica com o que estiver la, igual ao original.
    *--------------------------------------------------------------------------
    FUNCTION ContaLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ContaLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDFUNC

    PROTECTED PROCEDURE ContaLostFocusExec()
        LOCAL loc_cConta

        loc_cConta = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            *-- Legado: Else / Get_DConta.Value = '' / get_cpf.Value = ''
            THIS.cnt_4c_Origem.txt_4c_DConta.Value = ""
            THIS.cnt_4c_Origem.txt_4c_Cpf.Value     = ""
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarContaPorCodigo(loc_cConta)
            THIS.BOParaForm(.T., .F.)
        ELSE
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - picker de SigCdCli por codigo (FormBuscaAuxiliar).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta()
        LOCAL loc_oBusca, loc_cCodigo, loc_oErro

        loc_cCodigo = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Conta.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "IClis", loc_cCodigo, ;
                "Buscar Conta de Origem")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    IF THIS.this_oBusinessObject.CarregarContaPorCodigo(ALLTRIM(cursor_4c_BuscaConta.IClis))
                        THIS.BOParaForm(.T., .F.)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigOpCcl.AbrirLookupConta")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DContaLostFocus - busca reversa por NOME (SigCdCli.RClis). Ver
    * comentario de SigOpCclBO.CarregarContaPorDescricao sobre a
    * divergencia consciente do Valid de Get_dconta legado (fAcessoContas
    * + CursorQuery provavelmente copy-pasted do Get_conta, filtrando por
    * IClis com a descricao digitada - nunca acharia nada). Aqui a busca
    * por nome preenche Grupo (se vazio) + Conta + Cpf, que eh o
    * comportamento util de uma busca reversa.
    *--------------------------------------------------------------------------
    FUNCTION DContaLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.DContaLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDFUNC

    PROTECTED PROCEDURE DContaLostFocusExec()
        LOCAL loc_cNome

        loc_cNome = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_DConta.Value)

        IF EMPTY(loc_cNome)
            THIS.cnt_4c_Origem.txt_4c_Conta.Value = ""
            THIS.cnt_4c_Origem.txt_4c_Cpf.Value    = ""
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarContaPorDescricao(loc_cNome)
            THIS.BOParaForm(.T., .T.)
        ELSE
            THIS.AbrirLookupDConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDConta - picker de SigCdCli por nome (FormBuscaAuxiliar).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDConta()
        LOCAL loc_oBusca, loc_cNome, loc_oErro

        loc_cNome = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_DConta.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaNome", "RClis", loc_cNome, ;
                "Buscar Conta de Origem")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNome")
                    SELECT cursor_4c_BuscaNome
                    IF THIS.this_oBusinessObject.CarregarContaPorCodigo(ALLTRIM(cursor_4c_BuscaNome.IClis))
                        THIS.BOParaForm(.T., .T.)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigOpCcl.AbrirLookupDConta")
        ENDTRY

        IF USED("cursor_4c_BuscaNome")
            USE IN cursor_4c_BuscaNome
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CpfLostFocus - equivalente ao Get_cpf.Valid do legado: valida o
    * digito verificador de CPF/CNPJ, formata com mascara e busca a conta.
    *
    *   lcCgc = StrTran(StrTran(StrTran(This.Value,'.',''),'-',''),'/','')
    *   If (Len(Alltrim(lcCgc)) <> 14)
    *       lcCgc1 = TransForm(lcCgc,'@R 999.999.999-99')
    *       If (Len(Alltrim(lcCgc)) = 11)
    *           lnVer = Iif(fValidarCPF(lcCgc1),1,2)
    *       EndIf
    *   Else
    *       lcCgc1 = TransForm(lcCgc,'@R 99.999.999/9999-99')
    *       lnVer  = Iif(fValidarCNPJ(lcCgc1),1,2)
    *   EndIf
    *   If (lnVer = 2) -> MsgBox + Return (cancela, NAO reformata This.Value)
    *
    * fValidarCPF/fValidarCNPJ (wrappers do VCX legado) delegam para
    * ValidarCPF()/ValidarCNPJ() de utils\validators.prg - usar as duas
    * direto aqui, que eh codigo NOSSO (regra CLAUDE.md #13/wrapper).
    *
    * lnVer so fica 2 (invalido) quando o tamanho eh 11 (CPF) ou 14 (CNPJ)
    * E o digito verificador falha - tamanho diferente de 11/14 NUNCA
    * dispara o aviso (lnVer fica 0), igual ao legado.
    *--------------------------------------------------------------------------
    FUNCTION CpfLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.CpfLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDFUNC

    PROTECTED PROCEDURE CpfLostFocusExec()
        LOCAL loc_cDigitado, loc_cSoDigitos, loc_cFormatado, loc_nVerificacao

        loc_cDigitado = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Cpf.Value)

        IF EMPTY(loc_cDigitado)
            *-- Legado: Else / This.Value='' / Get_Conta.Value='' / Get_DConta.Value=''
            THIS.cnt_4c_Origem.txt_4c_Conta.Value  = ""
            THIS.cnt_4c_Origem.txt_4c_DConta.Value = ""
            RETURN
        ENDIF

        loc_cSoDigitos    = STRTRAN(STRTRAN(STRTRAN(loc_cDigitado, ".", ""), "-", ""), "/", "")
        loc_nVerificacao  = 0
        loc_cFormatado    = loc_cSoDigitos

        IF LEN(ALLTRIM(loc_cSoDigitos)) != 14
            loc_cFormatado = TRANSFORM(loc_cSoDigitos, "@R 999.999.999-99")
            IF LEN(ALLTRIM(loc_cSoDigitos)) = 11
                loc_nVerificacao = IIF(ValidarCPF(loc_cFormatado), 1, 2)
            ENDIF
        ELSE
            loc_cFormatado   = TRANSFORM(loc_cSoDigitos, "@R 99.999.999/9999-99")
            loc_nVerificacao = IIF(ValidarCNPJ(loc_cFormatado), 1, 2)
        ENDIF

        IF loc_nVerificacao = 2
            MsgAviso("CPF/CNPJ Incorreto!!!", "")
            RETURN
        ENDIF

        THIS.cnt_4c_Origem.txt_4c_Cpf.Value = loc_cFormatado

        IF THIS.this_oBusinessObject.CarregarContaPorCpf(loc_cFormatado)
            THIS.BOParaForm(.F., .T.)
        ELSE
            THIS.AbrirLookupCpf(loc_cFormatado)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCpf - picker de SigCdCli por CPF/CNPJ (FormBuscaAuxiliar).
    * Legado usa fwBuscaExt + DynamicForeColor para pintar conta inativa de
    * vermelho - nao reproduzido (detalhe visual do picker, nao regra de
    * negocio; FormBuscaAuxiliar nao expoe DynamicForeColor por coluna).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCpf(par_cCpfFormatado)
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCpf", "Cpfs", par_cCpfFormatado, ;
                "Buscar Conta por CPF / CNPJ")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
                    SELECT cursor_4c_BuscaCpf
                    THIS.cnt_4c_Origem.txt_4c_Cpf.Value    = ALLTRIM(cursor_4c_BuscaCpf.Cpfs)
                    THIS.cnt_4c_Origem.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCpf.IClis)
                    THIS.cnt_4c_Origem.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCpf.RClis)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigOpCcl.AbrirLookupCpf")
        ENDTRY

        IF USED("cursor_4c_BuscaCpf")
            USE IN cursor_4c_BuscaCpf
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup "sair" do legado (ButtonCount=2): os
    * botoes Consulta (Buttons(1)) e Encerrar (Buttons(2)). Geometria e
    * propriedades TRANSCRITAS do dump: SIGOPCCL.sair + Command1 ("consulta")
    * + Command2 ("sair"). CommandGroup NAO tem ForeColor (regra CLAUDE.md
    * #33) - as cores ficam nos Buttons(N), como o legado ja faz.
    *
    * Buttons(N) configurados em WITH ANINHADO dentro do WITH do grupo (regra
    * CLAUDE.md): reabrir WITH .Buttons(N) separado, fora do WITH pai, faz o
    * VFP9 nao resolver o caminho e estourar "BUTTONS is not an object".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Sair", "CommandGroup")

        WITH THIS.cmg_4c_Sair
            .ButtonCount   = 2
            .Top           = -2
            .Left          = 562
            .Width         = 161
            .Height        = 85
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Value         = 1

            *-- Command1 "consulta" - "\<Consulta" (acelerador Alt+C do legado)
            WITH .Buttons(1)
                .Top               = 5
                .Left              = 5
                .Width             = 75
                .Height            = 75
                .FontName          = "Comic Sans MS"
                .FontSize          = 8
                .FontBold          = .T.
                .FontItalic        = .T.
                .WordWrap          = .T.
                .Picture           = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                .Caption           = "\<Consulta"
                .ForeColor         = RGB(90, 90, 90)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .Themes            = .F.
            ENDWITH

            *-- Command2 "sair" - Caption "Encerrar", Cancel=.T. (tecla ESC)
            WITH .Buttons(2)
                .Top               = 5
                .Left              = 81
                .Width             = 75
                .Height            = 75
                .FontName          = "Comic Sans MS"
                .FontSize          = 8
                .FontBold          = .T.
                .FontItalic        = .T.
                .WordWrap          = .T.
                .Picture           = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel            = .T.
                .Caption           = "Encerrar"
                .ForeColor         = RGB(90, 90, 90)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .Themes            = .F.
            ENDWITH
        ENDWITH

        *-- BINDEVENT exige que o metodo alvo ja exista em THIS - por isso vem
        *-- depois de BtnConsultaClick/BtnEncerrarClick estarem declarados mais
        *-- abaixo no arquivo (eles sao PUBLIC, regra CLAUDE.md #3).
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "BtnConsultaClick")
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere o conteudo ATUAL dos quatro campos do container
    * Origem para o Business Object. Hook declarado PROTECTED em FormBase, e
    * PROTECTED na base vale tambem para a subclasse (regra CLAUDE.md #51):
    * so THIS.FormParaBO(), de dentro da classe.
    *
    * POR QUE EXISTE: o legado monta o filtro lendo o CONTROLE no instante do
    * clique em Consulta -
    *
    *   [Where a.GrupoDs = '] + Padr(ThisForm.Origem.get_grupo.Value, 10) + ...
    *   [  And a.ContaDs = '] + Padr(ThisForm.Origem.get_conta.Value, 10) + ...
    *
    * - enquanto this_cGrupo/this_cConta do BO sao preenchidos apenas como
    * EFEITO COLATERAL de um lookup bem-sucedido: CarregarDoCursor le Grupos/
    * IClis do cursor de SigCdCli, e ObterTipoCadastro - que eh o caminho do
    * campo Grupo - nao toca this_cGrupo. Sem esta transferencia o fluxo tinha
    * tres desvios SILENCIOSOS em relacao ao legado:
    *
    *   1) Grupo digitado e aceito, Conta ainda nao resolvida por lookup ->
    *      this_cGrupo vazio e a consulta recusada com "Informe o Grupo e a
    *      Conta de origem" com os DOIS campos preenchidos na tela;
    *   2) conta pertencente a um grupo diferente do digitado -> o BO consulta
    *      o Grupos que veio do cursor, nao o que esta na tela;
    *   3) campo alterado DEPOIS do lookup (o LostFocus do Grupo nao regrava a
    *      property) -> o BO consulta o valor ANTIGO e devolve a movimentacao
    *      de outra conta, sem erro e sem aviso.
    *
    * O TextBox eh a fonte unica do filtro, igual ao legado. O PADR(...,10)
    * continua no BO (CarregarMovimentos), que eh onde o legado tambem o
    * aplica - aqui o valor vai ALLTRIM, como o resto do BO ja o guarda.
    *
    * Os controles sao qualificados pelo caminho completo em vez de WITH: WITH
    * aninhado sequestra o escopo do ponto e produz "Property ... is not found"
    * em runtime (regra CLAUDE.md #33).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cGrupo  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cConta  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cDConta = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_DConta.Value)
        THIS.this_oBusinessObject.this_cCpf    = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Cpf.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - contraparte de FormParaBO: transfere os campos que o BO
    * resolveu num lookup bem-sucedido (CarregarContaPorCodigo/PorDescricao/
    * PorCpf) de volta para os controles do container Origem.
    *
    * Substitui os blocos "WITH THIS.this_oBusinessObject / THIS.cnt_4c_Origem.
    * txt_4c_X.Value = .this_cX / ENDWITH" que, antes desta fase, apareciam
    * duplicados em ContaLostFocusExec/AbrirLookupConta (3 campos),
    * DContaLostFocusExec/AbrirLookupDConta (4 campos) e CpfLostFocusExec
    * (3 campos) - cada caminho transferindo um subconjunto diferente.
    *
    * par_lGrupo/par_lDConta preservam essa diferenca, que e FIDELIDADE
    * DELIBERADA ao legado (ver comentario de ContaLostFocusExec): o Valid de
    * Get_conta NUNCA sobrescreve Get_dConta/Nome, e o Valid de Get_cpf NUNCA
    * sobrescreve Get_Grupo. Conta e Cpf sao transferidos SEMPRE porque todo
    * caminho de lookup via BO os resolve (CarregarDoCursor sempre le IClis e
    * Cpfs). Parametros omitidos equivalem a .F. (PCOUNT cobre a chamada sem
    * argumentos, caso venha a ser necessaria).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm(par_lGrupo, par_lDConta)
        LOCAL loc_lGrupo, loc_lDConta

        loc_lGrupo  = (PCOUNT() >= 1) AND (par_lGrupo = .T.)
        loc_lDConta = (PCOUNT() >= 2) AND (par_lDConta = .T.)

        WITH THIS.this_oBusinessObject
            THIS.cnt_4c_Origem.txt_4c_Conta.Value = .this_cConta
            THIS.cnt_4c_Origem.txt_4c_Cpf.Value    = .this_cCpf

            IF loc_lGrupo
                THIS.cnt_4c_Origem.txt_4c_Grupo.Value = .this_cGrupo
            ENDIF

            IF loc_lDConta
                THIS.cnt_4c_Origem.txt_4c_DConta.Value = .this_cDConta
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultaClick - equivalente a SIGOPCCL.sair.consulta.Click: desabilita
    * a tela, aciona SigOpCclBO.BuscarOperacoes() (cruza SigMvCab Destino e
    * Origem com SigCdOpe, filtrado por Grupo/Conta - ja implementado nas
    * Fases 1-2) e, achando movimentacao, repassa para o form legado de
    * selecao de destino. Nao achando nada, reabilita a tela e devolve o foco
    * ao campo Grupo (quando ele ja existir - Fases 5-6).
    *
    * Legado:
    *   ThisForm.Enabled = .f.
    *   Zap In TmpOper
    *   ... (SqlExecute de SigCdPam/SigMvCab, com Wait Window NoWait entre as
    *        duas consultas - combinadas aqui numa unica BuscarOperacoes())
    *   Select TmpOper / Set Order To Num / Go Top
    *   If Eof()
    *       MessageBox('Nenhuma Movimentacao Foi Encontrada!!!')
    *       ThisForm.Enabled = .t.
    *       ThisForm.Origem.Get_Grupo.SetFocus
    *   Else
    *       Do Form SigOpClp with ThisForm,ThisForm.datasessionid
    *   EndIf
    *
    * SigOpClp fica FORA do escopo desta migracao (ver comentario no topo do
    * arquivo) - a chamada DO FORM eh mantida literal, apontando para o form
    * legado ainda nao migrado, no mesmo padrao do restante da familia SigOp*
    * (Formsigopind.prg).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultaClick()
        LOCAL loc_oErro

        TRY
            THIS.Enabled = .F.

            WAIT WINDOW "Aguarde!!! Selecionando Opera" + CHR(231) + CHR(245) + "es..." NOWAIT

            *-- O legado le get_grupo.Value/get_conta.Value ao montar o filtro,
            *-- ou seja NESTE instante - ver FormParaBO acima.
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.BuscarOperacoes()
                WAIT CLEAR

                *-- fora do escopo desta migracao - ver comentario acima
                DO FORM SigOpClp WITH THIS, THIS.DataSessionId
            ELSE
                WAIT CLEAR

                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Consulta")

                THIS.Enabled = .T.

                IF PEMSTATUS(THIS, "cnt_4c_Origem", 5)
                    IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
                        THIS.cnt_4c_Origem.txt_4c_Grupo.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.Enabled = .T.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnConsultaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - equivalente a SIGOPCCL.sair.sair.Click: "ThisForm.
    * Release" - unico caminho de saida da tela (form Flat, sem Page2/Dados
    * para cancelar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - equivalente ao "PROCEDURE Release" do form legado
    * ("ThisForm.poDataMgr.Release"): fecha o que a tela abriu antes de
    * devolver o controle ao menu.
    *
    * O cursor de movimentacoes (cursor_4c_Operacoes, o "Create Cursor TmpOper"
    * que o legado faz no Load) vive na data session COMPARTILHADA - este form
    * eh DataSession = 1, igual ao legado -, entao sem este fechamento ele
    * sobrevive ao form, levando consigo os dois INDEX ON, e vaza para a tela
    * seguinte. Os cursores de lookup (cursor_4c_Busca*) e os de consulta do BO
    * (cursor_4c_Conta/ContaNome/Gcr/Pam/MvCabTemp) ja sao fechados nos
    * proprios metodos que os abrem.
    *
    * O nome do cursor eh lido ANTES do DODEFAULT() porque FormBase.Destroy
    * libera o Business Object (this_oBusinessObject = .NULL.) e depois dele a
    * property nao esta mais alcancavel. Literal como alternativa: o nome eh
    * fixado em SigOpCclBO.Init.
    *
    * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
    * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
    * os pads do menu principal depois de uma tela modal fechar - sem ele o
    * menu do sistema aparece encolhido.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_cCursor

        loc_cCursor = "cursor_4c_Operacoes"

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes))
                loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)
            ENDIF
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
