# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormCliente.prg] Procedure vazia (sem codigo): FormParaBO
[FormCliente.prg] Procedure vazia (sem codigo): BOParaForm
[FormCliente.prg] Indicador de pendencia: *-- getCpf2 (TextBox CPF socio/dependente
[FormCliente.prg] Indicador de pendencia: *-- getRG2 (TextBox RG socio/dependente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormCliente.prg):
*==============================================================================
* FormCliente.prg
* Form Cadastro de Cliente (OPERACIONAL - wrapper clsconta / ClassResp.vcx)
* Migrado de SIGCDCLI.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (852x600)
*   BD   -> SIGCDCLI via clsconta.mGravaDados/mValidaObj
*   CODE -> arquitetura em camadas (FormBase / ClienteBO)
*
* Parametros Init: pCpf, pGrupo, pCep, pVal, pCli, pcTpBloqCar, pcMudaCpfCgc
* Retorno (Unload): RetCodCliente (IClis ou CPF/CNPJ gravado)
*==============================================================================

DEFINE CLASS FormCliente AS FormBase

    *-- Propriedades visuais (copiadas do original)
    Height       = 600
    Width        = 852
    AutoCenter   = .T.
    Caption      = "Cadastro de Cliente"
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    WindowType   = 1
    DataSession  = 2
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades customizadas (conforme RESERVED3/ClassInfo do original)
    this_cMensagemErro = ""
    mudavend           = .F.
    plaltcd            = .F.
    RetCodCliente      = " "
    pcEscolha          = ""

    *-- Integracao com BusinessObject (cliBO)
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *-- Parametros recebidos em Init (armazenados para uso em InicializarForm)
    this_cCpf         = ""
    this_cGrupo       = ""
    this_nCep         = 0
    this_lVal         = .F.
    this_cCli         = ""
    this_cTpBloqCar   = "0"
    this_cMudaCpfCgc  = "0"

    *============================================================
    PROCEDURE Init
    *============================================================
        LPARAMETERS par_cCpf, par_cGrupo, par_nCep, par_lVal, par_cCli, par_cTpBloqCar, par_cMudaCpfCgc

        *-- Normalizar e armazenar parametros antes de DODEFAULT (que chama InicializarForm)
        THIS.this_cCpf        = IIF(TYPE("par_cCpf")        = "C", PADR(par_cCpf, 20),        SPACE(20))
        THIS.this_cGrupo      = IIF(TYPE("par_cGrupo")      = "C", PADR(par_cGrupo, 10),      SPACE(10))
        THIS.this_nCep        = IIF(TYPE("par_nCep")        = "N", par_nCep,                  0)
        THIS.this_lVal        = IIF(TYPE("par_lVal")        = "L", par_lVal,                  .F.)
        THIS.this_cCli        = IIF(TYPE("par_cCli")        = "C", PADR(par_cCli, 10),        SPACE(10))
        THIS.this_cTpBloqCar  = IIF(TYPE("par_cTpBloqCar")  = "C", par_cTpBloqCar,            "0")
        THIS.this_cMudaCpfCgc = IIF(TYPE("par_cMudaCpfCgc") = "C", par_cMudaCpfCgc,           "0")

        RETURN DODEFAULT()
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE InicializarForm
    *============================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cCpf, loc_cGrupo, loc_lRetLeDados
        loc_lSucesso = .F.

        TRY
            *-- Instanciar Business Object (cliBO)
            THIS.this_oBusinessObject = CREATEOBJECT("cliBO")

            *-- Fundo de tela
            THIS.Picture = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"

            *-- Normalizar CPF (remover pontuacao para verificacao)
            loc_cCpf = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(THIS.this_cCpf), ".", ""), "-", ""), "/", "")

            *-- Determinar grupo padrao se nao informado
            loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
            IF EMPTY(loc_cGrupo) AND USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                LOCATE
                IF !EOF("crSigCdPam")
                    loc_cGrupo = PADR(crSigCdPam.GrPadClis, 10)
                    THIS.this_cGrupo = loc_cGrupo
                ENDIF
            ENDIF

            *-- Verificar grupo configurado
            IF EMPTY(ALLTRIM(THIS.this_cGrupo))
                MsgAviso("Grupo Padr" + CHR(227) + "o N" + CHR(227) + "o Configurado.")
            ELSE
                *-- Definir modo (INSERIR / ALTERAR)
                THIS.mudavend = .T.
                IF EMPTY(ALLTRIM(THIS.this_cCli))
                    THIS.pcEscolha       = "INSERIR"
                    THIS.this_cModoAtual = "INCLUIR"
                    THIS.plaltcd         = .F.
                ELSE
                    THIS.plaltcd         = .T.
                    THIS.pcEscolha       = "ALTERAR"
                    THIS.this_cModoAtual = "ALTERAR"
                ENDIF

                *-- Criar componentes visuais
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarContaCls()
                THIS.ConfigurarBotoesSair()
                THIS.TornarControlesVisiveis()

                *-- Inicializar clsconta
                THIS.cnt_4c_Conta.mIniConta()
                THIS.cnt_4c_Conta.pgframeDados.Top = 0
                THIS.cnt_4c_Conta.cmdgPessoal.cmdPessoal.ToolTipText = "F5 - Dados Pessoais/Comerciais"

                *-- Ajustar navegacao inicial do PageFrame interno (pgframeDados)
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaDados2()

                *-- Carregar dados do cliente
                loc_lRetLeDados = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, THIS.this_cCli, "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)

                IF loc_lRetLeDados
                    THIS.cnt_4c_Conta.cmdgftec.Visible = .F.

                    IF THIS.pcEscolha = "INSERIR" AND !EMPTY(loc_cCpf)
                        WITH THIS.cnt_4c_Conta.pgframeDados.pgframeDados1
                            .OpcaoCPFCGC.Value = IIF(LEN(loc_cCpf) <> 14, 1, 2)
                            .GetCPFCGC.Value   = THIS.this_cCpf
                        ENDWITH
                        THIS.cnt_4c_Conta.mAtuGetCpf()
                    ENDIF

                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro Na Leitura dos Dados", "Erro")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *============================================================
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top        = -1
            .Left       = -1
            .Width      = THIS.Width
            .Height     = 80
            .BorderWidth = 0
            .BackColor  = RGB(100,100,100)
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Cadastro de Cliente"
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Caption    = "Cadastro de Cliente"
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = 769
            .ForeColor  = RGB(255,255,255)
            .Visible    = .T.
        ENDWITH
        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarContaCls
    *============================================================
        LOCAL loc_oErro, loc_cVcx1, loc_cVcx2, loc_cVcx3
        loc_cVcx1 = gc_4c_CaminhoBase + "Framework\framework.vcx"
        loc_cVcx2 = gc_4c_CaminhoBase + "Framework\classobj.vcx"
        loc_cVcx3 = gc_4c_CaminhoBase + "Framework\classresp.vcx"

        TRY
            IF FILE(loc_cVcx1)
                SET CLASSLIB TO (loc_cVcx1) ADDITIVE
            ENDIF
            IF FILE(loc_cVcx2)
                SET CLASSLIB TO (loc_cVcx2) ADDITIVE
            ENDIF
            IF FILE(loc_cVcx3)
                SET CLASSLIB TO (loc_cVcx3) ADDITIVE
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar biblioteca de classes: " + loc_oErro.Message, "Erro")
        ENDTRY

        THIS.AddObject("cnt_4c_Conta", "clsconta")
        WITH THIS.cnt_4c_Conta
            .Top    = 132
            .Left   = 12
            .Width  = 768
            .Height = 450
            .Visible     = .T.
        ENDWITH
        *-- cnt_4c_Conta permanece oculto ate mLeDados retornar .T. em InicializarForm
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarBotoesSair
    *============================================================
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Sair", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Sair
        WITH loc_oCmg
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 85
            .Left          = 688
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 161
        ENDWITH
        WITH loc_oCmg.Buttons(1)
            .Top        = 5
            .Left       = 5
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption    = "\<Ok"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH loc_oCmg.Buttons(2)
            .Top        = 5
            .Left       = 81
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "\<Cancelar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        THIS.cmg_4c_Sair.Visible = .T.

        *-- Bind eventos dos botoes (metodos PUBLIC por padrao VFP9)
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "BtnOkClick")
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *============================================================
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_i)
            *-- cnt_4c_Conta permanece oculto ate mLeDados ter sucesso
            IF UPPER(loc_oCtrl.Name) = "CNT_4C_CONTA"
                LOOP
            ENDIF
            loc_oCtrl.Visible = .T.
        ENDFOR
    ENDPROC

    *============================================================
    * Botao Ok / Gravar
    *============================================================
    PROCEDURE BtnOkClick
        LOCAL loc_nRetorno, loc_cCpfCgc

        loc_nRetorno = THIS.cnt_4c_Conta.mValidaObj()

        IF loc_nRetorno >= 0
            IF loc_nRetorno > 0
                IF THIS.cnt_4c_Conta.mGravaDados() > 0
                    loc_cCpfCgc = ALLTRIM(STRTRAN(STRTRAN(STRTRAN( ;
                        THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.GetCPFCGC.Value, ;
                        ".", ""), "-", ""), "/", ""))

                    IF EMPTY(loc_cCpfCgc)
                        THIS.RetCodCliente = THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value
                    ELSE
                        THIS.RetCodCliente = THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.GetCPFCGC.Value
                    ENDIF
                    THIS.Release()
                ELSE
                    MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados, " + ;
                        "Favor Clicar no Bot" + CHR(227) + "o [OK] Novamente.", "Erro")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *============================================================
    * Botao Cancelar
    *============================================================
    PROCEDURE BtnCancelarClick
        LOCAL loc_nCodigo, loc_nIdConta, loc_oErro

        *-- Liberar sequencial automatico se estava inserindo
        IF THIS.pcEscolha = "INSERIR"
            TRY
                IF USED("crSigCdCli")
                    SELECT crSigCdCli
                    loc_nCodigo  = crSigCdCli.NClis
                    loc_nIdConta = crSigCdCli.IdConta
                ELSE
                    loc_nCodigo  = 0
                    loc_nIdConta = 0
                ENDIF

                IF USED("crSigCdGcr")
                    SELECT crSigCdGcr
                    IF crSigCdGcr.TpCods = 1
                        IF crSigCdGcr.TpEmps = 1
                            = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos) + go_4c_Sistema.cCodEmpresa)
                        ELSE
                            = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos))
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                *-- fCanUniqueKey pode nao estar portada; nao bloquear o cancelamento
            ENDTRY
        ENDIF

        THIS.RetCodCliente = " "
        THIS.Release()
    ENDPROC

    *============================================================
    * ConfigurarPaginaLista - configura o estado inicial da pagina
    * principal (pgframeDados1) do PageFrame interno de clsconta.
    *
    * Forms OPERACIONAIS deste tipo (wrapper de clsconta) NAO usam
    * o padrao CRUD Page1=Lista/Page2=Dados. A "pagina de listagem"
    * corresponde a pgframeDados1 (Cadastro principal) do clsconta,
    * que exibe os campos primarios do cliente. O paginado interno
    * eh alternado via cmdgPessoal (F5) ou via THIS.AlternarPagina().
    *============================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        LOCAL loc_oPgf

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        loc_oPgf.Top        = 0
        loc_oPgf.ActivePage = 1
        loc_oPgf.Visible    = .T.

        *-- Realcar botao da pagina ativa (cmdgCadastro se existir)
        IF PEMSTATUS(THIS.cnt_4c_Conta, "cmdgCadastro", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Conta.cmdgCadastro, "cmdCadastro", 5)
            THIS.cnt_4c_Conta.cmdgCadastro.cmdCadastro.SetFocus()
        ENDIF
    ENDPROC

    *============================================================
    * AlternarPagina - alterna entre as paginas do pgframeDados
    * interno de clsconta (1 = Cadastro, 2 = Dados Pessoais/Comerciais).
    *
    * Chamada por KeyPress (F5) ou por logica interna do form.
    * par_nPagina: se informada e valida (1..PageCount), navega
    * diretamente; caso contrario, alterna entre 1 e 2.
    *============================================================
    PROCEDURE AlternarPagina
        LPARAMETERS par_nPagina
        LOCAL loc_oPgf, loc_nDestino

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        IF TYPE("par_nPagina") = "N" AND par_nPagina >= 1 AND par_nPagina <= loc_oPgf.PageCount
            loc_nDestino = par_nPagina
        ELSE
            loc_nDestino = IIF(loc_oPgf.ActivePage = 1, 2, 1)
        ENDIF

        loc_oPgf.ActivePage = loc_nDestino

        *-- Delegar ao botao de comando correspondente do clsconta
        *-- para preservar comportamento original (highlight, refresh, etc.)
        DO CASE
        CASE loc_nDestino = 2 AND PEMSTATUS(THIS.cnt_4c_Conta, "cmdgPessoal", 5) ;
             AND PEMSTATUS(THIS.cnt_4c_Conta.cmdgPessoal, "cmdPessoal", 5)
            THIS.cnt_4c_Conta.cmdgPessoal.cmdPessoal.Click()
        CASE loc_nDestino = 1 AND PEMSTATUS(THIS.cnt_4c_Conta, "cmdgCadastro", 5) ;
             AND PEMSTATUS(THIS.cnt_4c_Conta.cmdgCadastro, "cmdCadastro", 5)
            THIS.cnt_4c_Conta.cmdgCadastro.cmdCadastro.Click()
        ENDCASE
    ENDPROC

    *============================================================
    PROCEDURE KeyPress
    *============================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = -4  && F5 = Aba Dados Pessoais/Comerciais
            NODEFAULT
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *============================================================
    PROCEDURE Unload
    *============================================================
        RETURN THIS.RetCodCliente
    ENDPROC

    *============================================================
    * ConfigurarPaginaDados - Aplica overrides visuais do SCX
    * legado nos controles internos de cnt_4c_Conta.pgframeDados1
    * (primeira metade: Shapes + primeiros Labels e TextBoxes).
    *============================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        LOCAL loc_oPgf, loc_oPg1, loc_oErro, loc_cNomeEndCtrl, loc_oEndCtrl, loc_cNomeRazCtrl, loc_oRazCtrl

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        TRY
            IF PEMSTATUS(loc_oPgf, "ErasePage", 5)
                loc_oPgf.ErasePage = .T.
            ENDIF

            IF !PEMSTATUS(loc_oPgf, "pgframeDados1", 5)
                RETURN
            ENDIF
            loc_oPg1 = loc_oPgf.pgframeDados1

            *-- Propriedades da pagina
            IF PEMSTATUS(loc_oPg1, "FontName", 5)
                loc_oPg1.FontName = "Tahoma"
            ENDIF
            IF PEMSTATUS(loc_oPg1, "BackColor", 5)
                loc_oPg1.BackColor = RGB(255,255,255)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "ForeColor", 5)
                loc_oPg1.ForeColor = RGB(90,90,90)
            ENDIF

            *-- Shape1 (borda secao principal)
            IF PEMSTATUS(loc_oPg1, "Shape1", 5)
                WITH loc_oPg1.Shape1
                    .Top           = 2
                    .Left          = 6
                    .Height        = 195
                    .Width         = 751
                    .SpecialEffect = 1
                    .BorderColor   = RGB(136,188,189)
                ENDWITH
            ENDIF

            *-- Shape2 (borda secao dados pessoais)
            IF PEMSTATUS(loc_oPg1, "Shape2", 5)
                WITH loc_oPg1.Shape2
                    .Top           = 196
                    .Left          = 6
                    .Width         = 751
                    .SpecialEffect = 1
                    .BorderColor   = RGB(136,188,189)
                ENDWITH
            ENDIF

            *-- Shape4 (borda secao observacoes)
            IF PEMSTATUS(loc_oPg1, "Shape4", 5)
                WITH loc_oPg1.Shape4
                    .Top           = 344
                    .Left          = 6
                    .SpecialEffect = 1
                    .BorderColor   = RGB(136,188,189)
                ENDWITH
            ENDIF

            *-- Shape3 (area foto)
            IF PEMSTATUS(loc_oPg1, "Shape3", 5)
                WITH loc_oPg1.Shape3
                    .Top    = 71
                    .Left   = 573
                    .Height = 77
                    .Width  = 182
                ENDWITH
            ENDIF

            *-- Shape5 (borda cabecalho foto)
            IF PEMSTATUS(loc_oPg1, "Shape5", 5)
                WITH loc_oPg1.Shape5
                    .Top         = 8
                    .Left        = 573
                    .Width       = 182
                    .BorderColor = RGB(100,100,100)
                ENDWITH
            ENDIF

            *-- Say2 (label nome/razao)
            IF PEMSTATUS(loc_oPg1, "Say2", 5)
                WITH loc_oPg1.Say2
                    .FontName  = "Tahoma"
                    .Left      = 31
                    .Top       = 58
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say12 (label empresa)
            IF PEMSTATUS(loc_oPg1, "Say12", 5)
                WITH loc_oPg1.Say12
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .Left      = 17
                    .Top       = 81
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say16 (label codigo)
            IF PEMSTATUS(loc_oPg1, "Say16", 5)
                WITH loc_oPg1.Say16
                    .FontName  = "Tahoma"
                    .Left      = 67
                    .Top       = 15
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say22 (label inscr. estadual)
            IF PEMSTATUS(loc_oPg1, "Say22", 5)
                WITH loc_oPg1.Say22
                    .FontName  = "Tahoma"
                    .Left      = 17
                    .Top       = 104
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayConjuges (label conjuge)
            IF PEMSTATUS(loc_oPg1, "sayConjuges", 5)
                WITH loc_oPg1.sayConjuges
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .Left      = 19
                    .Top       = 150
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDtncons (label aniversario)
            IF PEMSTATUS(loc_oPg1, "sayDtncons", 5)
                WITH loc_oPg1.sayDtncons
                    .FontName  = "Tahoma"
                    .Caption   = "Aniv : "
                    .Left      = 362
                    .Top       = 150
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDtcasas (label data casamento)
            IF PEMSTATUS(loc_oPg1, "sayDtcasas", 5)
                WITH loc_oPg1.sayDtcasas
                    .FontName  = "Tahoma"
                    .Left      = 330
                    .Top       = 173
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say29 (label usuario alt.)
            IF PEMSTATUS(loc_oPg1, "Say29", 5)
                WITH loc_oPg1.Say29
                    .FontName  = "Tahoma"
                    .Left      = 575
                    .Top       = 45
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say30 (label usuario cadastro)
            IF PEMSTATUS(loc_oPg1, "Say30", 5)
                WITH loc_oPg1.Say30
                    .FontName  = "Tahoma"
                    .Left      = 578
                    .Top       = 17
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say3 (label)
            IF PEMSTATUS(loc_oPg1, "Say3", 5)
                WITH loc_oPg1.Say3
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayIm (label inscr. municipal)
            IF PEMSTATUS(loc_oPg1, "SayIm", 5)
                WITH loc_oPg1.SayIm
                    .FontName  = "Tahoma"
                    .Left      = 390
                    .Top       = 105
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- lblCpf2 (label CPF/CNPJ socio)
            IF PEMSTATUS(loc_oPg1, "lblCpf2", 5)
                WITH loc_oPg1.lblCpf2
                    .FontName  = "Tahoma"
                    .Left      = 39
                    .Top       = 173
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say31 (label foto)
            IF PEMSTATUS(loc_oPg1, "Say31", 5)
                WITH loc_oPg1.Say31
                    .FontName  = "Tahoma"
                    .Left      = 619
                    .Top       = 77
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- lblRg2 (label RG socio)
            IF PEMSTATUS(loc_oPg1, "lblRg2", 5)
                WITH loc_oPg1.lblRg2
                    .FontName  = "Tahoma"
                    .Left      = 181
                    .Top       = 173
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayRgIe (label RG/IE)
            IF PEMSTATUS(loc_oPg1, "SayRgIe", 5)
                WITH loc_oPg1.SayRgIe
                    .FontName  = "Tahoma"
                    .Left      = 263
                    .Top       = 35
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDatNas (label data nascimento)
            IF PEMSTATUS(loc_oPg1, "sayDatNas", 5)
                WITH loc_oPg1.sayDatNas
                    .FontName  = "Tahoma"
                    .Left      = 444
                    .Top       = 58
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayResp (label responsavel)
            IF PEMSTATUS(loc_oPg1, "SayResp", 5)
                WITH loc_oPg1.SayResp
                    .FontName  = "Tahoma"
                    .Left      = 29
                    .Top       = 128
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say1 (label)
            IF PEMSTATUS(loc_oPg1, "Say1", 5)
                WITH loc_oPg1.Say1
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SaySexo (label sexo)
            IF PEMSTATUS(loc_oPg1, "SaySexo", 5)
                WITH loc_oPg1.SaySexo
                    .FontName  = "Tahoma"
                    .Left      = 443
                    .Top       = 35
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say21 (label)
            IF PEMSTATUS(loc_oPg1, "Say21", 5)
                WITH loc_oPg1.Say21
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say25 (label)
            IF PEMSTATUS(loc_oPg1, "Say25", 5)
                WITH loc_oPg1.Say25
                    .FontName  = "Tahoma"
                    .Left      = 581
                    .Top       = 139
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say32 (label)
            IF PEMSTATUS(loc_oPg1, "Say32", 5)
                WITH loc_oPg1.Say32
                    .FontName  = "Tahoma"
                    .Left      = 244
                    .Top       = 10
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say23 (label)
            IF PEMSTATUS(loc_oPg1, "Say23", 5)
                WITH loc_oPg1.Say23
                    .FontName  = "Tahoma"
                    .Left      = 600
                    .Top       = 123
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say33 (label)
            IF PEMSTATUS(loc_oPg1, "Say33", 5)
                WITH loc_oPg1.Say33
                    .FontName  = "Tahoma"
                    .Left      = 594
                    .Top       = 100
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- lblEstCivil (label estado civil)
            IF PEMSTATUS(loc_oPg1, "lblEstCivil", 5)
                WITH loc_oPg1.lblEstCivil
                    .FontName  = "Tahoma"
                    .Left      = 503
                    .Top       = 174
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Get_usualt (TextBox usuario alteracao)
            IF PEMSTATUS(loc_oPg1, "Get_usualt", 5)
                WITH loc_oPg1.Get_usualt
                    .Left      = 590
                    .Top       = 42
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Get_usuar (TextBox usuario cadastro)
            IF PEMSTATUS(loc_oPg1, "Get_usuar", 5)
                WITH loc_oPg1.Get_usuar
                    .Left      = 590
                    .Top       = 14
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Data_ent (TextBox data entrada)
            IF PEMSTATUS(loc_oPg1, "Data_ent", 5)
                WITH loc_oPg1.Data_ent
                    .Left      = 670
                    .Top       = 14
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Data_alt (TextBox data alteracao)
            IF PEMSTATUS(loc_oPg1, "Data_alt", 5)
                WITH loc_oPg1.Data_alt
                    .Left      = 670
                    .Top       = 42
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- GetCodigo (TextBox codigo)
            IF PEMSTATUS(loc_oPg1, "GetCodigo", 5)
                WITH loc_oPg1.GetCodigo
                    .Left = 290
                    .Top  = 8
                ENDWITH
            ENDIF

            *-- Get_Grupo (TextBox grupo)
            IF PEMSTATUS(loc_oPg1, "Get_Grupo", 5)
                WITH loc_oPg1.Get_Grupo
                    .Left = 108
                    .Top  = 8
                ENDWITH
            ENDIF

            *-- GetNome (TextBox nome)
            IF PEMSTATUS(loc_oPg1, "GetNome", 5)
                WITH loc_oPg1.GetNome
                    .Left = 70
                    .Top  = 55
                ENDWITH
            ENDIF

            *-- GetCPFCGC (TextBox CPF/CNPJ)
            IF PEMSTATUS(loc_oPg1, "GetCPFCGC", 5)
                WITH loc_oPg1.GetCPFCGC
                    .Left = 108
                    .Top  = 32
                ENDWITH
            ENDIF

            *-- GetRG (TextBox RG/IE)
            IF PEMSTATUS(loc_oPg1, "GetRG", 5)
                WITH loc_oPg1.GetRG
                    .Height = 23
                    .Left   = 290
                    .Top    = 32
                    .Width  = 149
                ENDWITH
            ENDIF

            *-- getSexo (ComboBox sexo)
            IF PEMSTATUS(loc_oPg1, "getSexo", 5)
                WITH loc_oPg1.getSexo
                    .Left = 483
                    .Top  = 32
                ENDWITH
            ENDIF

            *-- GetDatNas (TextBox data nascimento)
            IF PEMSTATUS(loc_oPg1, "GetDatNas", 5)
                WITH loc_oPg1.GetDatNas
                    .Left = 483
                    .Top  = 55
                ENDWITH
            ENDIF

            *-- getResp (TextBox codigo responsavel)
            IF PEMSTATUS(loc_oPg1, "getResp", 5)
                WITH loc_oPg1.getResp
                    .Left = 151
                    .Top  = 124
                ENDWITH
            ENDIF

            *-- Get_grupoven (TextBox grupo de vendas)
            IF PEMSTATUS(loc_oPg1, "Get_grupoven", 5)
                WITH loc_oPg1.Get_grupoven
                    .Left = 70
                    .Top  = 124
                ENDWITH
            ENDIF

            *-- getNresp (TextBox numero do responsavel)
            IF PEMSTATUS(loc_oPg1, "getNresp", 5)
                WITH loc_oPg1.getNresp
                    .Left = 232
                    .Top  = 124
                ENDWITH
            ENDIF

            *-- Get_Emps (TextBox codigo empresa)
            IF PEMSTATUS(loc_oPg1, "Get_Emps", 5)
                WITH loc_oPg1.Get_Emps
                    .Left = 70
                    .Top  = 101
                ENDWITH
            ENDIF

            *-- Get_DEmps (TextBox descricao empresa)
            IF PEMSTATUS(loc_oPg1, "Get_DEmps", 5)
                WITH loc_oPg1.Get_DEmps
                    .Left = 100
                    .Top  = 101
                ENDWITH
            ENDIF

            *-- Get_InsMuns (TextBox inscricao municipal)
            IF PEMSTATUS(loc_oPg1, "Get_InsMuns", 5)
                WITH loc_oPg1.Get_InsMuns
                    .Height = 23
                    .Left   = 431
                    .Top    = 101
                    .Width  = 141
                ENDWITH
            ENDIF

            *-- Get_Situa (TextBox situacao do cliente)
            IF PEMSTATUS(loc_oPg1, "Get_Situa", 5)
                WITH loc_oPg1.Get_Situa
                    .Left = 673
                    .Top  = 74
                ENDWITH
            ENDIF

            *-- getTelem (TextBox telefone celular)
            IF PEMSTATUS(loc_oPg1, "getTelem", 5)
                WITH loc_oPg1.getTelem
                    .Left = 673
                    .Top  = 97
                ENDWITH
            ENDIF

            *-- getClacod (TextBox classe do codigo)
            IF PEMSTATUS(loc_oPg1, "getClacod", 5)
                WITH loc_oPg1.getClacod
                    .Left = 673
                    .Top  = 120
                ENDWITH
            ENDIF

            *-- getConjuges (TextBox conjuge)
            IF PEMSTATUS(loc_oPg1, "getConjuges", 5)
                WITH loc_oPg1.getConjuges
                    .Left = 70
                    .Top  = 147
                ENDWITH
            ENDIF

            *-- getDtncons (TextBox aniversario conjuge)
            IF PEMSTATUS(loc_oPg1, "getDtncons", 5)
                WITH loc_oPg1.getDtncons
                    .Left = 396
                    .Top  = 147
                ENDWITH
            ENDIF

            *-- getDtcasas (TextBox data casamento)
            IF PEMSTATUS(loc_oPg1, "getDtcasas", 5)
                WITH loc_oPg1.getDtcasas
                    .Left = 396
                    .Top  = 170
                ENDWITH
            ENDIF

            *-- getCpf2 (TextBox CPF socio/dependente)
            IF PEMSTATUS(loc_oPg1, "getCpf2", 5)
                WITH loc_oPg1.getCpf2
                    .Left = 70
                    .Top  = 170
                ENDWITH
            ENDIF

            *-- getRG2 (TextBox RG socio/dependente)
            IF PEMSTATUS(loc_oPg1, "getRG2", 5)
                WITH loc_oPg1.getRG2
                    .Left = 211
                    .Top  = 170
                ENDWITH
            ENDIF

            *-- cmbEstcivils (ComboBox estado civil)
            IF PEMSTATUS(loc_oPg1, "cmbEstcivils", 5)
                WITH loc_oPg1.cmbEstcivils
                    .Left = 572
                    .Top  = 170
                ENDWITH
            ENDIF

            *-- chkInativa (CheckBox cliente inativado)
            IF PEMSTATUS(loc_oPg1, "chkInativa", 5)
                WITH loc_oPg1.chkInativa
                    .FontName  = "Tahoma"
                    .Alignment = 0
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- OpcaoCPFCGC (OptionGroup tipo documento - posicao)
            IF PEMSTATUS(loc_oPg1, "OpcaoCPFCGC", 5)
                WITH loc_oPg1.OpcaoCPFCGC
                    .Left = 14
                    .Top  = 33
                ENDWITH
            ENDIF

            *-- GetCEP (TextBox CEP)
            IF PEMSTATUS(loc_oPg1, "GetCEP", 5)
                WITH loc_oPg1.GetCEP
                    .Left = 102
                    .Top  = 200
                ENDWITH
            ENDIF

            *-- GetPais (TextBox pais)
            IF PEMSTATUS(loc_oPg1, "GetPais", 5)
                WITH loc_oPg1.GetPais
                    .Left = 230
                    .Top  = 200
                ENDWITH
            ENDIF

            *-- GetEndere?o (TextBox endereco - nome com cedilha CHR(231))
            loc_cNomeEndCtrl = "GetEndere" + CHR(231) + "o"
            IF PEMSTATUS(loc_oPg1, loc_cNomeEndCtrl, 5)
                loc_oEndCtrl = EVALUATE("loc_oPg1." + loc_cNomeEndCtrl)
                WITH loc_oEndCtrl
                    .Left = 102
                    .Top  = 223
                ENDWITH
                loc_oEndCtrl = .NULL.
            ENDIF

            *-- Get_num (TextBox numero do endereco)
            IF PEMSTATUS(loc_oPg1, "Get_num", 5)
                WITH loc_oPg1.Get_num
                    .Left = 561
                    .Top  = 223
                ENDWITH
            ENDIF

            *-- Get_comp (TextBox complemento)
            IF PEMSTATUS(loc_oPg1, "Get_comp", 5)
                WITH loc_oPg1.Get_comp
                    .Left = 102
                    .Top  = 246
                ENDWITH
            ENDIF

            *-- GetBairro (TextBox bairro)
            IF PEMSTATUS(loc_oPg1, "GetBairro", 5)
                WITH loc_oPg1.GetBairro
                    .Left = 334
                    .Top  = 246
                ENDWITH
            ENDIF

            *-- GetCidade (TextBox cidade)
            IF PEMSTATUS(loc_oPg1, "GetCidade", 5)
                WITH loc_oPg1.GetCidade
                    .Height = 23
                    .Left   = 102
                    .Top    = 269
                    .Width  = 230
                ENDWITH
            ENDIF

            *-- getCidasIBGE (TextBox codigo IBGE da cidade)
            IF PEMSTATUS(loc_oPg1, "getCidasIBGE", 5)
                WITH loc_oPg1.getCidasIBGE
                    .Left = 334
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- GetEstado (TextBox UF/Estado)
            IF PEMSTATUS(loc_oPg1, "GetEstado", 5)
                WITH loc_oPg1.GetEstado
                    .Left = 483
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- getUFIBGE (TextBox codigo IBGE da UF)
            IF PEMSTATUS(loc_oPg1, "getUFIBGE", 5)
                WITH loc_oPg1.getUFIBGE
                    .Left = 508
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- Get_Regiao (TextBox regiao)
            IF PEMSTATUS(loc_oPg1, "Get_Regiao", 5)
                WITH loc_oPg1.Get_Regiao
                    .Left = 596
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- getDdds (TextBox DDD)
            IF PEMSTATUS(loc_oPg1, "getDdds", 5)
                WITH loc_oPg1.getDdds
                    .Left = 102
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- GetTel1 (TextBox telefone 1)
            IF PEMSTATUS(loc_oPg1, "GetTel1", 5)
                WITH loc_oPg1.GetTel1
                    .Left = 179
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- GetTel2 (TextBox telefone 2)
            IF PEMSTATUS(loc_oPg1, "GetTel2", 5)
                WITH loc_oPg1.GetTel2
                    .Left = 385
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- GetFax (TextBox fax)
            IF PEMSTATUS(loc_oPg1, "GetFax", 5)
                WITH loc_oPg1.GetFax
                    .Left = 596
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- Say13 (label secao dados comerciais/endereco)
            IF PEMSTATUS(loc_oPg1, "Say13", 5)
                WITH loc_oPg1.Say13
                    .Left = 61
                    .Top  = 295
                ENDWITH
            ENDIF

            *-- GetEmail (TextBox e-mail)
            IF PEMSTATUS(loc_oPg1, "GetEmail", 5)
                WITH loc_oPg1.GetEmail
                    .Left = 102
                    .Top  = 315
                ENDWITH
            ENDIF

            *-- Say19 (label e-mail)
            IF PEMSTATUS(loc_oPg1, "Say19", 5)
                WITH loc_oPg1.Say19
                    .Left = 55
                    .Top  = 318
                ENDWITH
            ENDIF

            *-- GetCodFun (TextBox codigo funcao)
            IF PEMSTATUS(loc_oPg1, "GetCodFun", 5)
                WITH loc_oPg1.GetCodFun
                    .Left = 97
                    .Top  = 349
                ENDWITH
            ENDIF

            *-- GetDesFun (TextBox descricao funcao)
            IF PEMSTATUS(loc_oPg1, "GetDesFun", 5)
                WITH loc_oPg1.GetDesFun
                    .Left = 130
                    .Top  = 349
                ENDWITH
            ENDIF

            *-- Say17 (label funcao/cargo do cliente)
            IF PEMSTATUS(loc_oPg1, "Say17", 5)
                WITH loc_oPg1.Say17
                    .Left = 13
                    .Top  = 352
                ENDWITH
            ENDIF

            *-- cmdEnderecos (CommandGroup multiplos enderecos)
            IF PEMSTATUS(loc_oPg1, "cmdEnderecos", 5)
                WITH loc_oPg1.cmdEnderecos
                    .Left = 444
                    .Top  = 360
                ENDWITH
            ENDIF

            *-- lblObs (label area de observacoes)
            IF PEMSTATUS(loc_oPg1, "lblObs", 5)
                WITH loc_oPg1.lblObs
                    .Left = 62
                    .Top  = 371
                ENDWITH
            ENDIF

            *-- chkObservas (CheckBox filtrar por observacao)
            IF PEMSTATUS(loc_oPg1, "chkObservas", 5)
                WITH loc_oPg1.chkObservas
                    .Top       = 387
                    .Left      = 59
                    .Alignment = 0
                ENDWITH
            ENDIF

            *-- MemoFun (EditBox observacoes/memo)
            IF PEMSTATUS(loc_oPg1, "MemoFun", 5)
                WITH loc_oPg1.MemoFun
                    .Left = 97
                    .Top  = 373
                ENDWITH
            ENDIF

            *-- GetRaz?o (TextBox razao social - nome com til CHR(227))
            loc_cNomeRazCtrl = "GetRaz" + CHR(227) + "o"
            IF PEMSTATUS(loc_oPg1, loc_cNomeRazCtrl, 5)
                loc_oRazCtrl = EVALUATE("loc_oPg1." + loc_cNomeRazCtrl)
                WITH loc_oRazCtrl
                    .Left = 70
                    .Top  = 78
                ENDWITH
                loc_oRazCtrl = .NULL.
            ENDIF

            *-- Say9 (label)
            IF PEMSTATUS(loc_oPg1, "Say9", 5)
                WITH loc_oPg1.Say9
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say14 (label)
            IF PEMSTATUS(loc_oPg1, "Say14", 5)
                WITH loc_oPg1.Say14
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say24 (label)
            IF PEMSTATUS(loc_oPg1, "Say24", 5)
                WITH loc_oPg1.Say24
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *============================================================
    * checaibge - Validacao de codigo IBGE de municipio/UF.
    * Metodo PUBLIC chamado internamente pelo clsconta via
    * ThisForm.checaibge(pMun, pUFs, obCidade, obUF).
    *============================================================
    PROCEDURE checaibge
        LPARAMETERS par_cMun, par_cUFs, par_oObC, par_oObU
        LOCAL loc_nRtC, loc_nRtU, loc_cQuery, loc_oErro

        loc_nRtC = 9999999
        loc_nRtU = 99

        TRY
            *-- Buscar codigo IBGE do municipio
            loc_cQuery = "SELECT a.Codigos " + ;
                        "FROM SigCdMun a, SigCdUfs b " + ;
                        "WHERE RTRIM(a.Descs) = '" + ;
                            PADR(UPPER(ALLTRIM(par_cMun)), 40) + "'" + ;
                        " AND a.UFIBGEs = b.UFIBGEs" + ;
                        " AND b.Estados = '" + PADR(par_cUFs, 2) + "'"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalMunic") > 0
                IF USED("cursor_4c_LocalMunic")
                    SELECT cursor_4c_LocalMunic
                    GO TOP IN cursor_4c_LocalMunic
                    IF !EOF("cursor_4c_LocalMunic")
                        loc_nRtC = INT(VAL(ALLTRIM(TRANSFORM(cursor_4c_LocalMunic.Codigos))))
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_LocalMunic")
                USE IN cursor_4c_LocalMunic
            ENDIF

            par_oObC.Value    = loc_nRtC
            par_oObC.Refresh()
            par_oObC.ForeColor = IIF(loc_nRtC = 9999999, RGB(255,0,0), RGB(0,0,0))

            *-- Buscar codigo IBGE da UF
            loc_cQuery = "SELECT UFIBGEs FROM SigCdUfs " + ;
                        "WHERE Estados = '" + PADR(par_cUFs, 2) + "'"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalUF") > 0
                IF USED("cursor_4c_LocalUF")
                    SELECT cursor_4c_LocalUF
                    GO TOP IN cursor_4c_LocalUF
                    IF !EOF("cursor_4c_LocalUF")
                        loc_nRtU = cursor_4c_LocalUF.UFIBGEs
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_LocalUF")
                USE IN cursor_4c_LocalUF
            ENDIF

            par_oObU.Value    = loc_nRtU
            par_oObU.Refresh()
            par_oObU.ForeColor = IIF(loc_nRtU = 99, RGB(255,0,0), RGB(0,0,0))

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em checaibge")
        ENDTRY
    ENDPROC

    *============================================================
    * ConfigurarPaginaDados2 - Aplica overrides visuais do SCX
    * legado nos controles internos de cnt_4c_Conta.pgframeDados2
    * (aba de Dados Pessoais/Comerciais do cliente).
    *============================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados2
        LOCAL loc_oPgf, loc_oPg2, loc_oErro

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        IF !PEMSTATUS(loc_oPgf, "pgframeDados2", 5)
            RETURN
        ENDIF
        loc_oPg2 = loc_oPgf.pgframeDados2

        TRY
            IF PEMSTATUS(loc_oPg2, "FontName", 5)
                loc_oPg2.FontName = "Tahoma"
            ENDIF
            IF PEMSTATUS(loc_oPg2, "ForeColor", 5)
                loc_oPg2.ForeColor = RGB(90,90,90)
            ENDIF

            *-- Say4 (label)
            IF PEMSTATUS(loc_oPg2, "Say4", 5)
                WITH loc_oPg2.Say4
                    .FontName  = "Tahoma"
                    .Left      = 72
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say5 (label)
            IF PEMSTATUS(loc_oPg2, "Say5", 5)
                WITH loc_oPg2.Say5
                    .FontName  = "Tahoma"
                    .Left      = 76
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDtcasas (label data casamento - pg2)
            IF PEMSTATUS(loc_oPg2, "sayDtcasas", 5)
                WITH loc_oPg2.sayDtcasas
                    .FontName  = "Tahoma"
                    .Left      = 296
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say6 (label)
            IF PEMSTATUS(loc_oPg2, "Say6", 5)
                WITH loc_oPg2.Say6
                    .FontName  = "Tahoma"
                    .Left      = 316
                    .Top       = 231
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say7 (label)
            IF PEMSTATUS(loc_oPg2, "Say7", 5)
                WITH loc_oPg2.Say7
                    .FontName  = "Tahoma"
                    .Left      = 52
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say8 (label)
            IF PEMSTATUS(loc_oPg2, "Say8", 5)
                WITH loc_oPg2.Say8
                    .FontName  = "Tahoma"
                    .Left      = 98
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say9 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say9", 5)
                WITH loc_oPg2.Say9
                    .FontName  = "Tahoma"
                    .Left      = 84
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say10 (label)
            IF PEMSTATUS(loc_oPg2, "Say10", 5)
                WITH loc_oPg2.Say10
                    .FontName  = "Tahoma"
                    .Left      = 537
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say11 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say11", 5)
                WITH loc_oPg2.Say11
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say12 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say12", 5)
                WITH loc_oPg2.Say12
                    .FontName  = "Tahoma"
                    .Left      = 92
                    .Top       = 279
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say14 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say14", 5)
                WITH loc_oPg2.Say14
                    .FontName  = "Tahoma"
                    .Left      = 47
                    .Top       = 302
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say15 (label)
            IF PEMSTATUS(loc_oPg2, "Say15", 5)
                WITH loc_oPg2.Say15
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say16 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say16", 5)
                WITH loc_oPg2.Say16
                    .FontName  = "Tahoma"
                    .Left      = 25
                    .Top       = 333
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say17 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say17", 5)
                WITH loc_oPg2.Say17
                    .FontName  = "Tahoma"
                    .Left      = 504
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say18 (label)
            IF PEMSTATUS(loc_oPg2, "Say18", 5)
                WITH loc_oPg2.Say18
                    .FontName  = "Tahoma"
                    .Left      = 294
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say19 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say19", 5)
                WITH loc_oPg2.Say19
                    .FontName  = "Tahoma"
                    .Left      = 536
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say20 (label)
            IF PEMSTATUS(loc_oPg2, "Say20", 5)
                WITH loc_oPg2.Say20
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say21 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say21", 5)
                WITH loc_oPg2.Say21
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say22 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say22", 5)
                WITH loc_oPg2.Say22
                    .FontName  = "Tahoma"
                    .Left      = 85
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say23 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say23", 5)
                WITH loc_oPg2.Say23
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say24 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say24", 5)
                WITH loc_oPg2.Say24
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say25 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say25", 5)
                WITH loc_oPg2.Say25
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say3 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say3", 5)
                WITH loc_oPg2.Say3
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayTel1 (label telefone comercial)
            IF PEMSTATUS(loc_oPg2, "SayTel1", 5)
                WITH loc_oPg2.SayTel1
                    .FontName  = "Tahoma"
                    .Left      = 91
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- say_Limite (label limite de credito)
            IF PEMSTATUS(loc_oPg2, "say_Limite", 5)
                WITH loc_oPg2.say_Limite
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- getGrauParens (TextBox grau de parentesco)
            IF PEMSTATUS(loc_oPg2, "getGrauParens", 5)
                WITH loc_oPg2.getGrauParens
                    .Left = 376
                    .Top  = 299
                ENDWITH
            ENDIF

            *-- Cnt_Limite.Say1 (label dentro do container de limite)
            IF PEMSTATUS(loc_oPg2, "Cnt_Limite", 5)
                IF PEMSTATUS(loc_oPg2.Cnt_Limite, "Say1", 5)
                    WITH loc_oPg2.Cnt_Limite.Say1
                        .FontName  = "Tahoma"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarPaginaDados2")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnIncluirClick - Limpar clsconta para inclusao de novo cliente
    *============================================================
    PROCEDURE BtnIncluirClick
        LOCAL loc_lRet, loc_oErro
        TRY
            THIS.pcEscolha       = "INSERIR"
            THIS.this_cModoAtual = "INCLUIR"
            THIS.plaltcd         = .F.
            THIS.this_cCli       = SPACE(10)
            THIS.RetCodCliente   = " "
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, SPACE(10), "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                    IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                        THIS.cmg_4c_Sair.Buttons(1).Enabled = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao inicializar formul" + CHR(225) + "rio para inclus" + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnAlterarClick - Recarregar cliente em modo de alteracao
    *============================================================
    PROCEDURE BtnAlterarClick
        LOCAL loc_cCodigoCli, loc_lRet, loc_oErro
        TRY
            *-- Obter codigo do cliente atual do controle interno do clsconta
            loc_cCodigoCli = ""
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
                    loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
                ENDIF
            ENDIF
            IF EMPTY(loc_cCodigoCli)
                loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
            ENDIF

            IF EMPTY(loc_cCodigoCli)
                MsgAviso("Nenhum cliente selecionado para altera" + CHR(231) + CHR(227) + "o.")
                RETURN
            ENDIF

            THIS.pcEscolha       = "ALTERAR"
            THIS.this_cModoAtual = "ALTERAR"
            THIS.plaltcd         = .T.
            THIS.this_cCli       = PADR(loc_cCodigoCli, 10)

            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, THIS.this_cCli, "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                    IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                        THIS.cmg_4c_Sair.Buttons(1).Enabled = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar dados para altera" + CHR(231) + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnVisualizarClick - Modo somente leitura (desabilita gravacao)
    *============================================================
    PROCEDURE BtnVisualizarClick
        LOCAL loc_cCodigoCli, loc_lRet, loc_oErro
        TRY
            loc_cCodigoCli = ""
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
                    loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
                ENDIF
            ENDIF
            IF EMPTY(loc_cCodigoCli)
                loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
            ENDIF

            IF EMPTY(loc_cCodigoCli)
                MsgAviso("Nenhum cliente selecionado para visualiza" + CHR(231) + CHR(227) + "o.")
                RETURN
            ENDIF

            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.pcEscolha       = "VISUALIZAR"

            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, PADR(loc_cCodigoCli, 10), "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                ENDIF
            ENDIF

            *-- Desabilitar botao OK em modo de visualizacao (impede gravacao acidental)
            IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                THIS.cmg_4c_Sair.Buttons(1).Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnExcluirClick - Confirmar e excluir cliente atual
    *============================================================
    PROCEDURE BtnExcluirClick
        LOCAL loc_cCodigoCli, loc_lConfirma, loc_lSucesso, loc_cSQL, loc_oErro
        TRY
            loc_cCodigoCli = ""
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
                    loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
                ENDIF
            ENDIF
            IF EMPTY(loc_cCodigoCli)
                loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
            ENDIF

            IF EMPTY(loc_cCodigoCli)
                MsgAviso("Nenhum cliente selecionado para exclus" + CHR(227) + "o.")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do cliente " + ;
                loc_cCodigoCli + "?" + CHR(13) + ;
                "Esta opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser desfeita.", ;
                "Exclus" + CHR(227) + "o de Cliente")

            IF !loc_lConfirma
                RETURN
            ENDIF

            *-- Verificar dependencias em movimentos (SigIvTrh)
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigIvTrh " + ;
                "WHERE IClis = " + EscaparSQL(loc_cCodigoCli)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepMov") > 0
                IF USED("cursor_4c_DepMov")
                    SELECT cursor_4c_DepMov
                    IF NVL(cursor_4c_DepMov.nExiste, 0) > 0
                        USE IN cursor_4c_DepMov
                        MsgAviso("Cliente possui movimentos vinculados e n" + CHR(227) + ;
                            "o pode ser exclu" + CHR(237) + "do.", ;
                            "Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida")
                        RETURN
                    ENDIF
                    USE IN cursor_4c_DepMov
                ENDIF
            ENDIF

            *-- Verificar dependencias em contas a receber (SigIvDre)
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigIvDre " + ;
                "WHERE IClis = " + EscaparSQL(loc_cCodigoCli)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepDre") > 0
                IF USED("cursor_4c_DepDre")
                    SELECT cursor_4c_DepDre
                    IF NVL(cursor_4c_DepDre.nExiste, 0) > 0
                        USE IN cursor_4c_DepDre
                        MsgAviso("Cliente possui t" + CHR(237) + "tulos a receber vinculados e n" + CHR(227) + ;
                            "o pode ser exclu" + CHR(237) + "do.", ;
                            "Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida")
                        RETURN
                    ENDIF
                    USE IN cursor_4c_DepDre
                ENDIF
            ENDIF

            *-- Executar exclusao via BO
            THIS.this_oBusinessObject.this_cIclis = loc_cCodigoCli
            loc_lSucesso = THIS.this_oBusinessObject.Excluir()

            IF loc_lSucesso
                THIS.RetCodCliente = " "
                THIS.Release()
            ELSE
                MsgErro("Erro ao excluir o cliente." + CHR(13) + ;
                    THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro na Exclus" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *============================================================
    * CarregarLista - Recarregar dados do cliente atual via clsconta.mLeDados
    * (este form nao possui grade de listagem - "lista" = estado atual do cliente)
    *============================================================
    PROCEDURE CarregarLista
        LOCAL loc_lRet, loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.cnt_4c_Conta.mLeDados(THIS.this_cGrupo, THIS.this_cCli, "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                ELSE
                    MsgErro("Erro ao recarregar dados do cliente.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *============================================================
    * AjustarBotoesPorModo - Habilitar/desabilitar botoes conforme modo
    *============================================================
    PROCEDURE AjustarBotoesPorModo
        LOCAL loc_lHabilitaOk
        loc_lHabilitaOk = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
        IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
            THIS.cmg_4c_Sair.Buttons(1).Enabled = loc_lHabilitaOk
        ENDIF
    ENDPROC

    *============================================================
    * HabilitarCampos - Habilitar ou desabilitar campos conforme modo
    * O clsconta gerencia seus campos internamente; aqui so se controla
    * o botao de confirmacao.
    *============================================================
    PROCEDURE HabilitarCampos
        LPARAMETERS par_lHabilitar
        IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
            THIS.cmg_4c_Sair.Buttons(1).Enabled = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)
        ENDIF
    ENDPROC

    *============================================================
    * LimparCampos - Limpar e reinicializar para novo cliente
    *============================================================
    PROCEDURE LimparCampos
        THIS.this_cCli       = SPACE(10)
        THIS.RetCodCliente   = " "
        THIS.pcEscolha       = "INSERIR"
        THIS.this_cModoAtual = "INCLUIR"
        THIS.plaltcd         = .F.
        THIS.CarregarLista()
    ENDPROC

    *============================================================
    * FormParaBO - Transferencia form -> BO
    * O clsconta (mGravaDados) gerencia transferencia internamente.
    *============================================================
    PROCEDURE FormParaBO
        *-- Nenhum mapeamento adicional: clsconta.mGravaDados() e responsavel
        *-- pela coleta de todos os campos do formulario legado.
    ENDPROC

    *============================================================
    * BOParaForm - Transferencia BO -> form
    * O clsconta (mLeDados) gerencia transferencia internamente.
    *============================================================
    PROCEDURE BOParaForm
        *-- Nenhum mapeamento adicional: clsconta.mLeDados() e responsavel
        *-- pela populacao de todos os campos do formulario legado.
    ENDPROC

    *============================================================
    * BtnSalvarClick - Alias de BtnOkClick (validar e gravar)
    *============================================================
    PROCEDURE BtnSalvarClick
        THIS.BtnOkClick()
    ENDPROC

    *============================================================
    * BtnEncerrarClick - Fechar sem gravar (alias de BtnCancelarClick)
    *============================================================
    PROCEDURE BtnEncerrarClick
        THIS.BtnCancelarClick()
    ENDPROC

    *============================================================
    * BtnBuscarClick - Abrir busca de cliente para carregar em edicao
    *============================================================
    PROCEDURE BtnBuscarClick
        LOCAL loc_oBusca, loc_cCodigoCli, loc_lSelecionou, loc_oErro
        TRY
            loc_cCodigoCli = ""
            loc_lSelecionou = .F.

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "IClis", "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Cliente", .T., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "",           "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    SELECT cursor_4c_BuscaCli
                    GO TOP IN cursor_4c_BuscaCli
                    IF !EOF("cursor_4c_BuscaCli")
                        loc_cCodigoCli = ALLTRIM(cursor_4c_BuscaCli.IClis)
                    ENDIF
                    USE IN cursor_4c_BuscaCli
                    loc_lSelecionou = !EMPTY(loc_cCodigoCli)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF loc_lSelecionou
                THIS.this_cCli       = PADR(loc_cCodigoCli, 10)
                THIS.pcEscolha       = "ALTERAR"
                THIS.this_cModoAtual = "ALTERAR"
                THIS.plaltcd         = .T.
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnBuscarClick")
        ENDTRY
    ENDPROC

    *============================================================
    PROCEDURE Destroy
    *============================================================
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ClienteBO.prg):
*==============================================================================
* CLIENTEBO.PRG
* Business Object para Cadastro de Cliente (SIGCDCLI)
*
* Tabela Principal : SIGCDCLI - Cadastro de clientes
* Chave Primaria   : iclis char(10)
*
* Nota: Form OPERACIONAL - wrapping do container clsconta (framework).
*       BO gerencia CRUD direto no SQL Server para a entidade Cliente.
*==============================================================================

DEFINE CLASS cliBO AS BusinessBase

    *-- Identificacao
    this_cIclis            = ""    && iclis     char(10) PK - Codigo do cliente
    this_nNclis            = 0     && nclis     numeric(10,0) - Numero sequencial
    this_nIdcontas         = 0     && idcontas  numeric(6,0) - ID conta vinculada
    this_nIdconta          = 0     && idconta   numeric(10,0) - ID conta

    *-- Dados cadastrais basicos
    this_cRclis            = ""    && rclis     char(50) - Razao social / Nome
    this_cRazaos           = ""    && razaos    char(50) - Razao social alternativa
    this_cNomearts         = ""    && nomearts  char(50) - Nome artistico
    this_cCpfs             = ""    && cpfs      char(20) - CPF ou CNPJ
    this_cCpfcs            = ""    && cpfcs     char(11) - CPF conjuge
    this_cRgs              = ""    && rgs       char(20) - RG ou IE
    this_cRgconjuges       = ""    && rgconjuges char(13) - RG conjuge
    this_cRgcs             = ""    && rgcs      char(9) - RG codigo
    this_cEmissors         = ""    && emissors  char(15) - Emissor RG
    this_cSexos            = ""    && sexos     char(1) - Sexo (M/F)
    this_cEstcivils        = ""    && estcivils char(20) - Estado civil
    this_cNacionals        = ""    && nacionals char(15) - Nacionalidade
    this_cProfiss          = ""    && profiss   char(20) - Profissao
    this_cConjuges         = ""    && conjuges  char(40) - Nome do conjuge
    this_cPis              = ""    && pis       char(14) - PIS/PASEP
    this_cSuframas         = ""    && suframas  char(15) - Suframa
    this_cInscmuns         = ""    && inscmuns  char(20) - Inscricao municipal
    this_cMicroemps        = ""    && microemps char(1) - Micro empresa (S/N)
    this_cOptsimples       = ""    && optsimples char(1) - Optante simples (S/N)

    *-- Datas
    this_dNascs            = {}    && nascs     datetime - Data nascimento
    this_dDtcasas          = {}    && dtcasas   datetime - Data casamento
    this_dDtncons          = {}    && dtncons   datetime - Data aniversario conjuge
    this_dDataincs         = {}    && dataincs  datetime - Data inclusao
    this_dDtalts           = {}    && dtalts    datetime - Data alteracao
    this_dDatatrans        = {}    && datatrans datetime - Data transacao
    this_dUltcomps         = {}    && ultcomps  datetime - Ultima compra
    this_dDtfilms          = {}    && dtfilms   datetime - Data filme
    this_dDtfats           = {}    && dtfats    datetime - Data faturamento
    this_dDtmacums         = {}    && dtmacums  datetime - Data macro acumulado
    this_dDtadmis          = {}    && dtadmis   datetime - Data admissao trabalho
    this_dDtvals           = {}    && dtvals    datetime - Data validade
    this_dAutdtavld        = {}    && autdtavld datetime - Data validade LGPD
    this_dPenultcomp       = {}    && penultcomp datetime - Penultima compra
    this_dDataesp          = {}    && dataesp   datetime - Data especial

    *-- Datas parciais (dia/mes)
    this_cDmcasas          = ""    && dmcasas   char(4) - Dia/Mes casamento
    this_cDmconjs          = ""    && dmconjs   char(4) - Dia/Mes conjuge
    this_cDmnascs          = ""    && dmnascs   char(4) - Dia/Mes nascimento

    *-- Endereco residencial
    this_cEndes            = ""    && endes     char(60) - Endereco
    this_cNums             = ""    && nums      char(10) - Numero
    this_cCompls           = ""    && compls    char(50) - Complemento
    this_cBairs            = ""    && bairs     char(40) - Bairro
    this_cCidas            = ""    && cidas     char(30) - Cidade
    this_cEstas            = ""    && estas     char(2) - Estado (UF)
    this_cCeps             = ""    && ceps      char(9) - CEP
    this_cPaises           = ""    && paises    char(30) - Pais
    this_nNmuncips         = 0     && nmuncips  numeric(4,0) - Codigo IBGE municipio

    *-- Contatos
    this_cDdds             = ""    && ddds      char(4) - DDD telefone 1
    this_cTel1s            = ""    && tel1s     char(20) - Telefone 1
    this_cDdd2s            = ""    && ddd2s     char(4) - DDD telefone 2
    this_cTel2s            = ""    && tel2s     char(20) - Telefone 2
    this_cTel3s            = ""    && tel3s     char(20) - Telefone 3
    this_cFaxs             = ""    && faxs      char(20) - Fax
    this_cRamals           = ""    && ramals    char(4) - Ramal
    this_cEmails           = ""    && emails    char(50) - Email
    this_cContato          = ""    && contato   char(40) - Contato
    this_cContats          = ""    && contats   char(20) - Contatos adicionais
    this_cCtelems          = ""    && ctelems   char(3) - Celular DDD
    this_cObspagto         = ""    && obspagto  char(30) - Observacao pagamento
    this_nValemail         = 0     && valemail  numeric(1,0) - Validacao email

    *-- Empresa / Grupo / Comercial
    this_cEmps             = ""    && emps      char(3) - Codigo empresa
    this_cGrupos           = ""    && grupos    char(10) - Grupo do cliente
    this_cGrupovens        = ""    && grupovens char(10) - Grupo vendas
    this_cGrupomats        = ""    && grupomats char(10) - Grupo matrizes
    this_cGrupocobs        = ""    && grupocobs char(10) - Grupo cobran?as
    this_cGrupocents       = ""    && grupocents char(10) - Grupo centros
    this_cGruprods         = ""    && gruprods  char(10) - Grupo produtos
    this_cGrufals          = ""    && grufals   char(10) - Grupo falencia
    this_cContavens        = ""    && contavens char(10) - Conta vendas
    this_cContaven2s       = ""    && contaven2s char(10) - Conta vendas 2
    this_cContamats        = ""    && contamats char(10) - Conta matrizes
    this_cContacobs        = ""    && contacobs char(10) - Conta cobranca
    this_cContacents       = ""    && contacents char(10) - Conta centros
    this_cCcontabs         = ""    && ccontabs  char(10) - Conta contabil
    this_cConprods         = ""    && conprods  char(10) - Conta produtos
    this_cCodigos          = ""    && codigos   char(10) - Codigo auxiliar
    this_cHists            = ""    && hists     char(30) - Historico
    this_nTphists          = 0     && tphists   numeric(1,0) - Tipo historico
    this_cRegiaos          = ""    && regiaos   char(10) - Regiao
    this_cSituas           = ""    && situas    char(3) - Situacao
    this_cCodegs           = ""    && codsegs   char(10) - Codigo segmento
    this_cFpags            = ""    && fpags     char(12) - Forma de pagamento
    this_cTabds            = ""    && tabds     char(10) - Tabela de desconto
    this_cTabd2s           = ""    && tabd2s    char(10) - Tabela desconto 2
    this_cLprecos          = ""    && lprecos   char(30) - Lista de precos
    this_cTransps          = ""    && transps   char(10) - Transportadora

    *-- Limites e valores comerciais
    this_nLimcres          = 0     && limcres   numeric(11,2) - Limite de credito
    this_nComis            = 0     && comis     numeric(5,2) - Comissao
    this_nJuros            = 0     && juros     numeric(5,2) - Juros
    this_nPercdescli       = 0     && percdescli numeric(5,2) - Percentual desconto
    this_nMacums           = 0     && macums    numeric(11,2) - Macro acumulado
    this_nMfats            = 0     && mfats     numeric(11,2) - Media faturamento
    this_nVultcomps        = 0     && vultcomps numeric(11,2) - Valor ultima compra
    this_nMaxtransps       = 0     && maxtransps numeric(11,2) - Max transportadora
    this_nPrazoents        = 0     && prazoents numeric(3,0) - Prazo de entrega
    this_nDiasPEntrega     = 0     && DiasPEntrega numeric(3,0) - Dias para entrega

    *-- Flags de controle
    this_nTpcads           = 0     && tpcads    numeric(1,0) - Tipo cadastro
    this_nTpclis           = 0     && tpclis    numeric(1,0) - Tipo cliente
    this_cTpcps            = ""    && tpcps     char(2) - Tipo de CPF
    this_nInativas         = 0     && inativas  numeric(1,0) - Inativo
    this_nColetors         = 0     && coletors  numeric(1,0) - Cobrador
    this_nVcolets          = 0     && vcolets   numeric(3,0) - Valor cobran?a
    this_nConcilias        = 0     && concilias numeric(1,0) - Concilia
    this_nGerbals          = 0     && gerbals   numeric(1,0) - Gera balancete
    this_nPagfals          = 0     && pagfals   numeric(1,0) - Pagamento falencia
    this_nRecfals          = 0     && recfals   numeric(1,0) - Recebe falencia
    this_nIntconts         = 0     && intconts  numeric(1,0) - Integra contas
    this_nVinculas         = 0     && vinculas  numeric(1,0) - Vincula
    this_nConsigs          = 0     && consigs   numeric(1,0) - Consignacao
    this_nConsignas        = 0     && consignas numeric(1,0) - Consignado
    this_nMsgpends         = 0     && msgpends  numeric(1,0) - Mensagem pendente
    this_nPatrietqs        = 0     && patrietqs numeric(1,0) - Patrimonial/ETQS
    this_nRestfors         = 0     && restfors  numeric(1,0) - Restricao fornecedor
    this_nComcargs         = 0     && comcargs  numeric(1,0) - Comercio exterior
    this_nMasters          = 0     && masters   numeric(1,0) - Master
    this_nLibtabcmvs       = 0     && libtabcmvs numeric(1,0) - Libera tabela CMV
    this_nAptos            = 0     && aptos     numeric(5,0) - Apontamentos
    this_nChkexcdre        = 0     && chkexcdre numeric(1,0) - Check excede RE
    this_nInvisivel        = 0     && invisivel numeric(1,0) - Invisivel

    *-- Dados LGPD / Autorizacoes
    this_nAutdados         = 0     && autdados  numeric(1,0) - Autoriza dados
    this_nAutemail         = 0     && autemail  numeric(1,0) - Autoriza email
    this_nAutsms           = 0     && autsms    numeric(1,0) - Autoriza SMS
    this_nAutwhats         = 0     && autwhats  numeric(1,0) - Autoriza WhatsApp
    this_nAutteleg         = 0     && autteleg  numeric(1,0) - Autoriza Telegram
    this_nCtaencrypt       = 0     && ctaencrypt numeric(1,0) - Criptografar conta
    this_cFiglgpds         = ""    && figlgpds  text - Figura LGPD

    *-- Biometria (dedos)
    this_nDdpolegar        = 0     && ddpolegar numeric(2,0) - Dedo polegar
    this_nDdindicado       = 0     && ddindicado numeric(2,0) - Dedo indicador
    this_nDdmedio          = 0     && ddmedio   numeric(2,0) - Dedo medio
    this_nDdanular         = 0     && ddanular  numeric(2,0) - Dedo anular
    this_nDdminimo         = 0     && ddminimo  numeric(2,0) - Dedo minimo

    *-- Valorizacao
    this_nVlrvaltransp     = 0     && vlrvaltransp numeric(12,2) - Valor val transporte
    this_nVlrvalref        = 0     && vlrvalref  numeric(12,2) - Valor val refeicao
    this_nVlrvalalim       = 0     && vlrvalalim numeric(12,2) - Valor val alimentacao
    this_nVlrplansaude     = 0     && vlrplansaude numeric(12,2) - Plano saude
    this_nVlrplandent      = 0     && vlrplandent numeric(12,2) - Plano dental

    *-- Endereco de cobranca
    this_cEndcobs          = ""    && endcobs   char(80) - Endereco cobranca
    this_cBaicobs          = ""    && baicobs   char(20) - Bairro cobranca
    this_cCidcobs          = ""    && cidcobs   char(20) - Cidade cobranca
    this_cEstcobs          = ""    && estcobs   char(2) - Estado cobranca
    this_cCepcobs          = ""    && cepcobs   char(9) - CEP cobranca
    this_cPaicobs          = ""    && paicobs   char(30) - Pais cobranca
    this_cContacobs        = ""    && contacobs char(10) - Conta cobranca

    *-- Endereco trabalho
    this_cEndtrabs         = ""    && endtrabs  char(48) - Endereco trabalho
    this_cNumtrabs         = ""    && numtrabs  char(10) - Numero trabalho
    this_cCompltrabs       = ""    && compltrabs char(25) - Complemento trabalho
    this_cBairtrabs        = ""    && bairtrabs char(40) - Bairro trabalho
    this_cCidatrabs        = ""    && cidatrabs char(30) - Cidade trabalho
    this_cEstatrabs        = ""    && estatrabs char(2) - Estado trabalho
    this_cCeptrabs         = ""    && ceptrabs  char(9) - CEP trabalho
    this_cPaitrabs         = ""    && paitrabs  char(30) - Pais trabalho
    this_cEmptrabs         = ""    && emptrabs  char(50) - Empresa trabalho
    this_cCnpjtrabs        = ""    && cnpjtrabs char(20) - CNPJ empresa trabalho
    this_cTeltrabs         = ""    && teltrabs  char(20) - Telefone trabalho
    this_nSalarios         = 0     && salarios  numeric(11,2) - Salario
    this_nRendafams        = 0     && rendafams numeric(11,2) - Renda familiar
    this_cGrauparens       = ""    && grauparens char(30) - Grau parentesco

    *-- Enderecos alternativos (entrega/outro)
    this_cEndcos           = ""    && endcos    char(60) - Endereco alternativo
    this_cNomecos          = ""    && nomecos   char(50) - Nome alternativo
    this_cBaicos           = ""    && baicos    char(30) - Bairro alternativo
    this_cCidcos           = ""    && cidcos    char(30) - Cidade alternativa
    this_cEstcos           = ""    && estcos    char(2) - Estado alternativo
    this_cCepcos           = ""    && cepcos    char(9) - CEP alternativo
    this_nNumcos           = 0     && numcos    numeric(5,0) - Numero alternativo
    this_cComplcos         = ""    && complcos  char(25) - Complemento alternativo

    *-- Fiscal / Tributario
    this_cCfos             = ""    && cfos      char(10) - CFO
    this_cCodtifs          = ""    && codtifs   char(3) - Codigo TIF
    this_cFpubls           = ""    && fpubls    char(3) - Funcionario publico
    this_cCfgfiscos        = ""    && cfgfiscos char(50) - Config fiscal COS
    this_cCfgfiscss        = ""    && cfgfiscss char(50) - Config fiscal CSS
    this_cCfgfisics        = ""    && cfgfisics char(50) - Config fiscal ICS
    this_cCfgfisiis        = ""    && cfgfisiis char(50) - Config fiscal IIS
    this_cCfgfisins        = ""    && cfgfisins char(50) - Config fiscal INS
    this_cCfgfisips        = ""    && cfgfisips char(50) - Config fiscal IPS
    this_cCfgfisirs        = ""    && cfgfisirs char(50) - Config fiscal IRS
    this_cCfgfisiss        = ""    && cfgfisiss char(50) - Config fiscal ISS
    this_cCfgfispis        = ""    && cfgfispis char(50) - Config fiscal PIS
    this_cCcargs           = ""    && ccargs    char(10) - Cargo
    this_nEan13ents        = 0     && ean13ents numeric(13,0) - EAN13 entrega
    this_nEan13cobs        = 0     && ean13cobs numeric(13,0) - EAN13 cobranca

    *-- Vendedor / Pra?a
    this_cPracas           = ""    && pracas    char(40) - Praca de venda
    this_cCodvendedor      = ""    && codvendedor char(10) - Codigo vendedor

    *-- Auditoria / Sistema
    this_cUsuars           = ""    && usuars    char(10) - Usuario inclusao
    this_cUsualts          = ""    && usualts   char(10) - Usuario alteracao
    this_cUsuariocrm       = ""    && usuariocrm char(50) - Usuario CRM
    this_cSenhas           = ""    && senhas    char(10) - Senha
    this_cCcartoes         = ""    && ccartoes  char(60) - Cartoes

    *-- Memo / texto livre
    this_cObs              = ""    && obs       text - Observacoes
    this_cCobs             = ""    && cobs      char(250) - Observacoes cobranca
    this_cPerfils          = ""    && perfils   text - Perfil do cliente
    this_cPastas           = ""    && pastas    text - Pastas
    this_cFigjpgs          = ""    && figjpgs   text - Figura JPG (base64)

    *-- Pais / Mae
    this_cPais             = ""    && pais      char(50) - Nome do pais
    this_cMaes             = ""    && maes      char(50) - Nome da mae

    *===========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDCLI"
        THIS.this_cCampoChave = "iclis"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIclis
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cIclis))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do cliente obrigat" + CHR(243) + "rio."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cRclis))
            THIS.this_cMensagemErro = "Nome / Raz" + CHR(227) + "o Social obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor VFP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                *-- Identificacao
                THIS.this_cIclis         = TratarNulo(iclis, "C")
                THIS.this_nNclis         = TratarNulo(nclis, "N")
                THIS.this_nIdcontas      = TratarNulo(idcontas, "N")
                THIS.this_nIdconta       = TratarNulo(idconta, "N")
                *-- Dados cadastrais
                THIS.this_cRclis         = TratarNulo(rclis, "C")
                THIS.this_cRazaos        = TratarNulo(razaos, "C")
                THIS.this_cNomearts      = TratarNulo(nomearts, "C")
                THIS.this_cCpfs          = TratarNulo(cpfs, "C")
                THIS.this_cCpfcs         = TratarNulo(cpfcs, "C")
                THIS.this_cRgs           = TratarNulo(rgs, "C")
                THIS.this_cRgconjuges    = TratarNulo(rgconjuges, "C")
                THIS.this_cRgcs          = TratarNulo(rgcs, "C")
                THIS.this_cEmissors      = TratarNulo(emissors, "C")
                THIS.this_cSexos         = TratarNulo(sexos, "C")
                THIS.this_cEstcivils     = TratarNulo(estcivils, "C")
                THIS.this_cNacionals     = TratarNulo(nacionals, "C")
                THIS.this_cProfiss       = TratarNulo(profiss, "C")
                THIS.this_cConjuges      = TratarNulo(conjuges, "C")
                THIS.this_cPis           = TratarNulo(pis, "C")
                THIS.this_cSuframas      = TratarNulo(suframas, "C")
                THIS.this_cInscmuns      = TratarNulo(inscmuns, "C")
                THIS.this_cMicroemps     = TratarNulo(microemps, "C")
                THIS.this_cOptsimples    = TratarNulo(optsimples, "C")
                *-- Datas
                THIS.this_dNascs         = TratarNulo(nascs, "D")
                THIS.this_dDtcasas       = TratarNulo(dtcasas, "D")
                THIS.this_dDtncons       = TratarNulo(dtncons, "D")
                THIS.this_dDataincs      = TratarNulo(dataincs, "D")
                THIS.this_dDtalts        = TratarNulo(dtalts, "D")
                THIS.this_dDatatrans     = TratarNulo(datatrans, "D")
                THIS.this_dUltcomps      = TratarNulo(ultcomps, "D")
                THIS.this_dDtfilms       = TratarNulo(dtfilms, "D")
                THIS.this_dDtfats        = TratarNulo(dtfats, "D")
                THIS.this_dDtmacums      = TratarNulo(dtmacums, "D")
                THIS.this_dDtadmis       = TratarNulo(dtadmis, "D")
                THIS.this_dDtvals        = TratarNulo(dtvals, "D")
                THIS.this_dAutdtavld     = TratarNulo(autdtavld, "D")
                THIS.this_dPenultcomp    = TratarNulo(penultcomp, "D")
                THIS.this_dDataesp       = TratarNulo(dataesp, "D")
                *-- Datas parciais dia/mes
                THIS.this_cDmcasas       = TratarNulo(dmcasas, "C")
                THIS.this_cDmconjs       = TratarNulo(dmconjs, "C")
                THIS.this_cDmnascs       = TratarNulo(dmnascs, "C")
                *-- Endereco residencial
                THIS.this_cEndes         = TratarNulo(endes, "C")
                THIS.this_cNums          = TratarNulo(nums, "C")
                THIS.this_cCompls        = TratarNulo(compls, "C")
                THIS.this_cBairs         = TratarNulo(bairs, "C")
                THIS.this_cCidas         = TratarNulo(cidas, "C")
                THIS.this_cEstas         = TratarNulo(estas, "C")
                THIS.this_cCeps          = TratarNulo(ceps, "C")
                THIS.this_cPaises        = TratarNulo(paises, "C")
                THIS.this_nNmuncips      = TratarNulo(nmuncips, "N")
                *-- Contatos
                THIS.this_cDdds          = TratarNulo(ddds, "C")
                THIS.this_cTel1s         = TratarNulo(tel1s, "C")
                THIS.this_cDdd2s         = TratarNulo(ddd2s, "C")
                THIS.this_cTel2s         = TratarNulo(tel2s, "C")
                THIS.this_cTel3s         = TratarNulo(tel3s, "C")
                THIS.this_cFaxs          = TratarNulo(faxs, "C")
                THIS.this_cRamals        = TratarNulo(ramals, "C")
                THIS.this_cEmails        = TratarNulo(emails, "C")
                THIS.this_cContato       = TratarNulo(contato, "C")
                THIS.this_cContats       = TratarNulo(contats, "C")
                THIS.this_cCtelems       = TratarNulo(ctelems, "C")
                THIS.this_cObspagto      = TratarNulo(obspagto, "C")
                THIS.this_nValemail      = TratarNulo(valemail, "N")
                *-- Empresa / Grupo / Comercial
                THIS.this_cEmps          = TratarNulo(emps, "C")
                THIS.this_cGrupos        = TratarNulo(grupos, "C")
                THIS.this_cGrupovens     = TratarNulo(grupovens, "C")
                THIS.this_cGrupomats     = TratarNulo(grupomats, "C")
                THIS.this_cGrupocobs     = TratarNulo(grupocobs, "C")
                THIS.this_cGrupocents    = TratarNulo(grupocents, "C")
                THIS.this_cGruprods      = TratarNulo(gruprods, "C")
                THIS.this_cGrufals       = TratarNulo(grufals, "C")
                THIS.this_cContavens     = TratarNulo(contavens, "C")
                THIS.this_cContaven2s    = TratarNulo(contaven2s, "C")
                THIS.this_cContamats     = TratarNulo(contamats, "C")
                THIS.this_cContacobs     = TratarNulo(contacobs, "C")
                THIS.this_cContacents    = TratarNulo(contacents, "C")
                THIS.this_cCcontabs      = TratarNulo(ccontabs, "C")
                THIS.this_cConprods      = TratarNulo(conprods, "C")
                THIS.this_cCodigos       = TratarNulo(codigos, "C")
                THIS.this_cHists         = TratarNulo(hists, "C")
                THIS.this_nTphists       = TratarNulo(tphists, "N")
                THIS.this_cRegiaos       = TratarNulo(regiaos, "C")
                THIS.this_cSituas        = TratarNulo(situas, "C")
                THIS.this_cCodegs        = TratarNulo(codsegs, "C")
                THIS.this_cFpags         = TratarNulo(fpags, "C")
                THIS.this_cTabds         = TratarNulo(tabds, "C")
                THIS.this_cTabd2s        = TratarNulo(tabd2s, "C")
                THIS.this_cLprecos       = TratarNulo(lprecos, "C")
                THIS.this_cTransps       = TratarNulo(transps, "C")
                *-- Limites e valores comerciais
                THIS.this_nLimcres       = TratarNulo(limcres, "N")
                THIS.this_nComis         = TratarNulo(comis, "N")
                THIS.this_nJuros         = TratarNulo(juros, "N")
                THIS.this_nPercdescli    = TratarNulo(percdescli, "N")
                THIS.this_nMacums        = TratarNulo(macums, "N")
                THIS.this_nMfats         = TratarNulo(mfats, "N")
                THIS.this_nVultcomps     = TratarNulo(vultcomps, "N")
                THIS.this_nMaxtransps    = TratarNulo(maxtransps, "N")
                THIS.this_nPrazoents     = TratarNulo(prazoents, "N")
                THIS.this_nDiasPEntrega  = TratarNulo(DiasPEntrega, "N")
                *-- Flags de controle
                THIS.this_nTpcads        = TratarNulo(tpcads, "N")
                THIS.this_nTpclis        = TratarNulo(tpclis, "N")
                THIS.this_cTpcps         = TratarNulo(tpcps, "C")
                THIS.this_nInativas      = TratarNulo(inativas, "N")
                THIS.this_nColetors      = TratarNulo(coletors, "N")
                THIS.this_nVcolets       = TratarNulo(vcolets, "N")
                THIS.this_nConcilias     = TratarNulo(concilias, "N")
                THIS.this_nGerbals       = TratarNulo(gerbals, "N")
                THIS.this_nPagfals       = TratarNulo(pagfals, "N")
                THIS.this_nRecfals       = TratarNulo(recfals, "N")
                THIS.this_nIntconts      = TratarNulo(intconts, "N")
                THIS.this_nVinculas      = TratarNulo(vinculas, "N")
                THIS.this_nConsigs       = TratarNulo(consigs, "N")
                THIS.this_nConsignas     = TratarNulo(consignas, "N")
                THIS.this_nMsgpends      = TratarNulo(msgpends, "N")
                THIS.this_nPatrietqs     = TratarNulo(patrietqs, "N")
                THIS.this_nRestfors      = TratarNulo(restfors, "N")
                THIS.this_nComcargs      = TratarNulo(comcargs, "N")
                THIS.this_nMasters       = TratarNulo(masters, "N")
                THIS.this_nLibtabcmvs    = TratarNulo(libtabcmvs, "N")
                THIS.this_nAptos         = TratarNulo(aptos, "N")
                THIS.this_nChkexcdre     = TratarNulo(chkexcdre, "N")
                THIS.this_nInvisivel     = TratarNulo(invisivel, "N")
                *-- LGPD / Autorizacoes
                THIS.this_nAutdados      = TratarNulo(autdados, "N")
                THIS.this_nAutemail      = TratarNulo(autemail, "N")
                THIS.this_nAutsms        = TratarNulo(autsms, "N")
                THIS.this_nAutwhats      = TratarNulo(autwhats, "N")
                THIS.this_nAutteleg      = TratarNulo(autteleg, "N")
                THIS.this_nCtaencrypt    = TratarNulo(ctaencrypt, "N")
                *-- Biometria
                THIS.this_nDdpolegar     = TratarNulo(ddpolegar, "N")
                THIS.this_nDdindicado    = TratarNulo(ddindicado, "N")
                THIS.this_nDdmedio       = TratarNulo(ddmedio, "N")
                THIS.this_nDdanular      = TratarNulo(ddanular, "N")
                THIS.this_nDdminimo      = TratarNulo(ddminimo, "N")
                *-- Valorizacao
                THIS.this_nVlrvaltransp  = TratarNulo(vlrvaltransp, "N")
                THIS.this_nVlrvalref     = TratarNulo(vlrvalref, "N")
                THIS.this_nVlrvalalim    = TratarNulo(vlrvalalim, "N")
                THIS.this_nVlrplansaude  = TratarNulo(vlrplansaude, "N")
                THIS.this_nVlrplandent   = TratarNulo(vlrplandent, "N")
                *-- Endereco cobranca
                THIS.this_cEndcobs       = TratarNulo(endcobs, "C")
                THIS.this_cBaicobs       = TratarNulo(baicobs, "C")
                THIS.this_cCidcobs       = TratarNulo(cidcobs, "C")
                THIS.this_cEstcobs       = TratarNulo(estcobs, "C")
                THIS.this_cCepcobs       = TratarNulo(cepcobs, "C")
                THIS.this_cPaicobs       = TratarNulo(paicobs, "C")
                *-- Endereco trabalho
                THIS.this_cEndtrabs      = TratarNulo(endtrabs, "C")
                THIS.this_cNumtrabs      = TratarNulo(numtrabs, "C")
                THIS.this_cCompltrabs    = TratarNulo(compltrabs, "C")
                THIS.this_cBairtrabs     = TratarNulo(bairtrabs, "C")
                THIS.this_cCidatrabs     = TratarNulo(cidatrabs, "C")
                THIS.this_cEstatrabs     = TratarNulo(estatrabs, "C")
                THIS.this_cCeptrabs      = TratarNulo(ceptrabs, "C")
                THIS.this_cPaitrabs      = TratarNulo(paitrabs, "C")
                THIS.this_cEmptrabs      = TratarNulo(emptrabs, "C")
                THIS.this_cCnpjtrabs     = TratarNulo(cnpjtrabs, "C")
                THIS.this_cTeltrabs      = TratarNulo(teltrabs, "C")
                THIS.this_nSalarios      = TratarNulo(salarios, "N")
                THIS.this_nRendafams     = TratarNulo(rendafams, "N")
                THIS.this_cGrauparens    = TratarNulo(grauparens, "C")
                *-- Enderecos alternativos
                THIS.this_cEndcos        = TratarNulo(endcos, "C")
                THIS.this_cNomecos       = TratarNulo(nomecos, "C")
                THIS.this_cBaicos        = TratarNulo(baicos, "C")
                THIS.this_cCidcos        = TratarNulo(cidcos, "C")
                THIS.this_cEstcos        = TratarNulo(estcos, "C")
                THIS.this_cCepcos        = TratarNulo(cepcos, "C")
                THIS.this_cComplcos      = TratarNulo(complcos, "C")
                THIS.this_nNumcos        = TratarNulo(numcos, "N")
                *-- Fiscal / Tributario
                THIS.this_cCfos          = TratarNulo(cfos, "C")
                THIS.this_cCodtifs       = TratarNulo(codtifs, "C")
                THIS.this_cFpubls        = TratarNulo(fpubls, "C")
                THIS.this_cCfgfiscos     = TratarNulo(cfgfiscos, "C")
                THIS.this_cCfgfiscss     = TratarNulo(cfgfiscss, "C")
                THIS.this_cCfgfisics     = TratarNulo(cfgfisics, "C")
                THIS.this_cCfgfisiis     = TratarNulo(cfgfisiis, "C")
                THIS.this_cCfgfisins     = TratarNulo(cfgfisins, "C")
                THIS.this_cCfgfisips     = TratarNulo(cfgfisips, "C")
                THIS.this_cCfgfisirs     = TratarNulo(cfgfisirs, "C")
                THIS.this_cCfgfisiss     = TratarNulo(cfgfisiss, "C")
                THIS.this_cCfgfispis     = TratarNulo(cfgfispis, "C")
                THIS.this_cCcargs        = TratarNulo(ccargs, "C")
                THIS.this_nEan13ents     = TratarNulo(ean13ents, "N")
                THIS.this_nEan13cobs     = TratarNulo(ean13cobs, "N")
                *-- Vendedor / Praca
                THIS.this_cPracas        = TratarNulo(pracas, "C")
                THIS.this_cCodvendedor   = TratarNulo(codvendedor, "C")
                *-- Auditoria / Sistema
                THIS.this_cUsuars        = TratarNulo(usuars, "C")
                THIS.this_cUsualts       = TratarNulo(usualts, "C")
                THIS.this_cUsuariocrm    = TratarNulo(usuariocrm, "C")
                THIS.this_cSenhas        = TratarNulo(senhas, "C")
                THIS.this_cCcartoes      = TratarNulo(ccartoes, "C")
                THIS.this_cCobs          = TratarNulo(cobs, "C")
                THIS.this_cPais          = TratarNulo(pais, "C")
                THIS.this_cMaes          = TratarNulo(maes, "C")
                *-- Memo / texto livre (nullable - verificar existencia no cursor)
                IF TYPE("obs") != "U"
                    THIS.this_cObs       = TratarNulo(obs, "C")
                ENDIF
                IF TYPE("perfils") != "U"
                    THIS.this_cPerfils   = TratarNulo(perfils, "C")
                ENDIF
                IF TYPE("pastas") != "U"
                    THIS.this_cPastas    = TratarNulo(pastas, "C")
                ENDIF
                IF TYPE("figjpgs") != "U"
                    THIS.this_cFigjpgs   = TratarNulo(figjpgs, "C")
                ENDIF
                IF TYPE("figlgpds") != "U"
                    THIS.this_cFiglgpds  = TratarNulo(figlgpds, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SIGCDCLI com todos os campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cCols, loc_cVals, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Bloco de colunas
            loc_cCols = "iclis, nclis, idcontas, idconta, rclis, razaos, nomearts, cpfs, cpfcs, rgs, " + ;
                "rgconjuges, rgcs, emissors, sexos, estcivils, nacionals, profiss, conjuges, pis, suframas, " + ;
                "inscmuns, microemps, optsimples, nascs, dtcasas, dtncons, dataincs, dtalts, datatrans, " + ;
                "ultcomps, dtfilms, dtfats, dtmacums, dtadmis, dtvals, autdtavld, penultcomp, dataesp, " + ;
                "dmcasas, dmconjs, dmnascs, endes, nums, compls, bairs, cidas, estas, ceps, paises, nmuncips, " + ;
                "ddds, tel1s, ddd2s, tel2s, tel3s, faxs, ramals, emails, contato, contats, ctelems, obspagto, " + ;
                "valemail, emps, grupos, grupovens, grupomats, grupocobs, grupocents, gruprods, grufals, " + ;
                "contavens, contaven2s, contamats, contacobs, contacents, ccontabs, conprods, codigos, hists, " + ;
                "tphists, regiaos, situas, codsegs, fpags, tabds, tabd2s, lprecos, transps, limcres, comis, " + ;
                "juros, percdescli, macums, mfats, vultcomps, maxtransps, prazoents, DiasPEntrega, tpcads, " + ;
                "tpclis, tpcps, inativas, coletors, vcolets, concilias, gerbals, pagfals, recfals, intconts, " + ;
                "vinculas, consigs, consignas, msgpends, patrietqs, restfors, comcargs, masters, libtabcmvs, " + ;
                "aptos, chkexcdre, invisivel, autdados, autemail, autsms, autwhats, autteleg, ctaencrypt, " + ;
                "ddpolegar, ddindicado, ddmedio, ddanular, ddminimo, vlrvaltransp, vlrvalref, vlrvalalim, " + ;
                "vlrplansaude, vlrplandent, endcobs, baicobs, cidcobs, estcobs, cepcobs, paicobs, endtrabs, " + ;
                "numtrabs, compltrabs, bairtrabs, cidatrabs, estatrabs, esttrabs, ceptrabs, paitrabs, emptrabs, " + ;
                "cnpjtrabs, teltrabs, salarios, rendafams, grauparens, endcos, nomecos, baicos, cidcos, estcos, " + ;
                "cepcos, complcos, numcos, cfos, codtifs, fpubls, cfgfiscos, cfgfiscss, cfgfisics, cfgfisiis, " + ;
                "cfgfisins, cfgfisips, cfgfisirs, cfgfisiss, cfgfispis, ccargs, ean13ents, ean13cobs, pracas, " + ;
                "codvendedor, usuars, usualts, usuariocrm, senhas, ccartoes, cobs, pais, maes, " + ;
                "obs, perfils, pastas, figjpgs, figlgpds, figuras"

            *-- Bloco de valores
            loc_cVals = ;
                EscaparSQL(THIS.this_cIclis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIdcontas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIdconta, 0) + ", " + ;
                EscaparSQL(THIS.this_cRclis) + ", " + ;
                EscaparSQL(THIS.this_cRazaos) + ", " + ;
                EscaparSQL(THIS.this_cNomearts) + ", " + ;
                EscaparSQL(THIS.this_cCpfs) + ", " + ;
                EscaparSQL(THIS.this_cCpfcs) + ", " + ;
                EscaparSQL(THIS.this_cRgs) + ", " + ;
                EscaparSQL(THIS.this_cRgconjuges) + ", " + ;
                EscaparSQL(THIS.this_cRgcs) + ", " + ;
                EscaparSQL(THIS.this_cEmissors) + ", " + ;
                EscaparSQL(THIS.this_cSexos) + ", " + ;
                EscaparSQL(THIS.this_cEstcivils) + ", " + ;
                EscaparSQL(THIS.this_cNacionals) + ", " + ;
                EscaparSQL(THIS.this_cProfiss) + ", " + ;
                EscaparSQL(THIS.this_cConjuges) + ", " + ;
                EscaparSQL(THIS.this_cPis) + ", " + ;
                EscaparSQL(THIS.this_cSuframas) + ", " + ;
                EscaparSQL(THIS.this_cInscmuns) + ", " + ;
                EscaparSQL(THIS.this_cMicroemps) + ", " + ;
                EscaparSQL(THIS.this_cOptsimples) + ", " + ;
                FormatarDataSQL(THIS.this_dNascs) + ", " + ;
                FormatarDataSQL(THIS.this_dDtcasas) + ", " + ;
                FormatarDataSQL(THIS.this_dDtncons) + ", " + ;
                FormatarDataSQL(THIS.this_dDataincs) + ", " + ;
                FormatarDataSQL(THIS.this_dDtalts) + ", " + ;
                FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                FormatarDataSQL(THIS.this_dUltcomps) + ", " + ;
                FormatarDataSQL(THIS.this_dDtfilms) + ", " + ;
                FormatarDataSQL(THIS.this_dDtfats) + ", " + ;
                FormatarDataSQL(THIS.this_dDtmacums) + ", " + ;
                FormatarDataSQL(THIS.this_dDtadmis) + ", " + ;
                FormatarDataSQL(THIS.this_dDtvals) + ", " + ;
                FormatarDataSQL(THIS.this_dAutdtavld) + ", " + ;
                FormatarDataSQL(THIS.this_dPenultcomp) + ", " + ;
                FormatarDataSQL(THIS.this_dDataesp) + ", " + ;
                EscaparSQL(THIS.this_cDmcasas) + ", " + ;
                EscaparSQL(THIS.this_cDmconjs) + ", " + ;
                EscaparSQL(THIS.this_cDmnascs) + ", " + ;
                EscaparSQL(THIS.this_cEndes) + ", " + ;
                EscaparSQL(THIS.this_cNums) + ", " + ;
                EscaparSQL(THIS.this_cCompls) + ", " + ;
                EscaparSQL(THIS.this_cBairs) + ", " + ;
                EscaparSQL(THIS.this_cCidas) + ", " + ;
                EscaparSQL(THIS.this_cEstas) + ", " + ;
                EscaparSQL(THIS.this_cCeps) + ", " + ;
                EscaparSQL(THIS.this_cPaises) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNmuncips, 0)

            loc_cVals = loc_cVals + ", " + ;
                EscaparSQL(THIS.this_cDdds) + ", " + ;
                EscaparSQL(THIS.this_cTel1s) + ", " + ;
                EscaparSQL(THIS.this_cDdd2s) + ", " + ;
                EscaparSQL(THIS.this_cTel2s) + ", " + ;
                EscaparSQL(THIS.this_cTel3s) + ", " + ;
                EscaparSQL(THIS.this_cFaxs) + ", " + ;
                EscaparSQL(THIS.this_cRamals) + ", " + ;
                EscaparSQL(THIS.this_cEmails) + ", " + ;
                EscaparSQL(THIS.this_cContato) + ", " + ;
                EscaparSQL(THIS.this_cContats) + ", " + ;
                EscaparSQL(THIS.this_cCtelems) + ", " + ;
                EscaparSQL(THIS.this_cObspagto) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValemail, 0) + ", " + ;
                EscaparSQL(THIS.this_cEmps) + ", " + ;
                EscaparSQL(THIS.this_cGrupos) + ", " + ;
                EscaparSQL(THIS.this_cGrupovens) + ", " + ;
                EscaparSQL(THIS.this_cGrupomats) + ", " + ;
                EscaparSQL(THIS.this_cGrupocobs) + ", " + ;
                EscaparSQL(THIS.this_cGrupocents) + ", " + ;
                EscaparSQL(THIS.this_cGruprods) + ", " + ;
                EscaparSQL(THIS.this_cGrufals) + ", " + ;
                EscaparSQL(THIS.this_cContavens) + ", " + ;
                EscaparSQL(THIS.this_cContaven2s) + ", " + ;
                EscaparSQL(THIS.this_cContamats) + ", " + ;
                EscaparSQL(THIS.this_cContacobs) + ", " + ;
                EscaparSQL(THIS.this_cContacents) + ", " + ;
                EscaparSQL(THIS.this_cCcontabs) + ", " + ;
                EscaparSQL(THIS.this_cConprods) + ", " + ;
                EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cHists) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTphists, 0) + ", " + ;
                EscaparSQL(THIS.this_cRegiaos) + ", " + ;
                EscaparSQL(THIS.this_cSituas) + ", " + ;
                EscaparSQL(THIS.this_cCodegs) + ", " + ;
                EscaparSQL(THIS.this_cFpags) + ", " + ;
                EscaparSQL(THIS.this_cTabds) + ", " + ;
                EscaparSQL(THIS.this_cTabd2s) + ", " + ;
                EscaparSQL(THIS.this_cLprecos) + ", " + ;
                EscaparSQL(THIS.this_cTransps) + ", " + ;
                FormatarNumeroSQL(THIS.this_nLimcres, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nComis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nJuros, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPercdescli, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMacums, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMfats, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVultcomps, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMaxtransps, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPrazoents, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDiasPEntrega, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpcads, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpclis, 0) + ", " + ;
                EscaparSQL(THIS.this_cTpcps)

            loc_cVals = loc_cVals + ", " + ;
                FormatarNumeroSQL(THIS.this_nInativas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nColetors, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVcolets, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConcilias, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGerbals, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPagfals, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRecfals, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntconts, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVinculas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConsigs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConsignas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMsgpends, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPatrietqs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRestfors, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nComcargs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMasters, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nLibtabcmvs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAptos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkexcdre, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInvisivel, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutdados, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutemail, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutsms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutwhats, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutteleg, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtaencrypt, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdpolegar, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdindicado, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdmedio, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdanular, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdminimo, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrvaltransp, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrvalref, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrvalalim, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrplansaude, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrplandent, 2) + ", " + ;
                EscaparSQL(THIS.this_cEndcobs) + ", " + ;
                EscaparSQL(THIS.this_cBaicobs) + ", " + ;
                EscaparSQL(THIS.this_cCidcobs) + ", " + ;
                EscaparSQL(THIS.this_cEstcobs) + ", " + ;
                EscaparSQL(THIS.this_cCepcobs) + ", " + ;
                EscaparSQL(THIS.this_cPaicobs) + ", " + ;
                EscaparSQL(THIS.this_cEndtrabs) + ", " + ;
                EscaparSQL(THIS.this_cNumtrabs) + ", " + ;
                EscaparSQL(THIS.this_cCompltrabs) + ", " + ;
                EscaparSQL(THIS.this_cBairtrabs) + ", " + ;
                EscaparSQL(THIS.this_cCidatrabs) + ", " + ;
                EscaparSQL(THIS.this_cEstatrabs) + ", " + ;
                EscaparSQL(THIS.this_cEstatrabs) + ", " + ;
                EscaparSQL(THIS.this_cCeptrabs) + ", " + ;
                EscaparSQL(THIS.this_cPaitrabs) + ", " + ;
                EscaparSQL(THIS.this_cEmptrabs) + ", " + ;
                EscaparSQL(THIS.this_cCnpjtrabs) + ", " + ;
                EscaparSQL(THIS.this_cTeltrabs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSalarios, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRendafams, 2) + ", " + ;
                EscaparSQL(THIS.this_cGrauparens) + ", " + ;
                EscaparSQL(THIS.this_cEndcos) + ", " + ;
                EscaparSQL(THIS.this_cNomecos) + ", " + ;
                EscaparSQL(THIS.this_cBaicos) + ", " + ;
                EscaparSQL(THIS.this_cCidcos) + ", " + ;
                EscaparSQL(THIS.this_cEstcos) + ", " + ;
                EscaparSQL(THIS.this_cCepcos) + ", " + ;
                EscaparSQL(THIS.this_cComplcos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumcos, 0) + ", " + ;
                EscaparSQL(THIS.this_cCfos) + ", " + ;
                EscaparSQL(THIS.this_cCodtifs) + ", " + ;
                EscaparSQL(THIS.this_cFpubls) + ", " + ;
                EscaparSQL(THIS.this_cCfgfiscos) + ", " + ;
                EscaparSQL(THIS.this_cCfgfiscss) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisics) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisiis) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisins) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisips) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisirs) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisiss) + ", " + ;
                EscaparSQL(THIS.this_cCfgfispis) + ", " + ;
                EscaparSQL(THIS.this_cCcargs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nEan13ents, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nEan13cobs, 0) + ", " + ;
                EscaparSQL(THIS.this_cPracas) + ", " + ;
                EscaparSQL(THIS.this_cCodvendedor) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                EscaparSQL(THIS.this_cUsuariocrm) + ", " + ;
                EscaparSQL(THIS.this_cSenhas) + ", " + ;
                EscaparSQL(THIS.this_cCcartoes) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCobs, 250)) + ", " + ;
                EscaparSQL(THIS.this_cPais) + ", " + ;
                EscaparSQL(THIS.this_cMaes) + ", " + ;
                IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs)) + ", " + ;
                IIF(EMPTY(THIS.this_cPerfils), "NULL", EscaparSQL(THIS.this_cPerfils)) + ", " + ;
                IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                IIF(EMPTY(THIS.this_cFigjpgs), "NULL", EscaparSQL(THIS.this_cFigjpgs)) + ", " + ;
                IIF(EMPTY(THIS.this_cFiglgpds), "NULL", EscaparSQL(THIS.this_cFiglgpds)) + ", " + ;
                "NULL"

            loc_cSQL = "INSERT INTO SIGCDCLI (" + loc_cCols + ") VALUES (" + loc_cVals + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cUsuars = gc_4c_UsuarioLogado
                THIS.this_dDataincs = DATETIME()
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir cliente no banco de dados."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SIGCDCLI com todos os campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SIGCDCLI SET " + ;
                "rclis = " + EscaparSQL(THIS.this_cRclis) + ", " + ;
                "razaos = " + EscaparSQL(THIS.this_cRazaos) + ", " + ;
                "nomearts = " + EscaparSQL(THIS.this_cNomearts) + ", " + ;
                "cpfs = " + EscaparSQL(THIS.this_cCpfs) + ", " + ;
                "cpfcs = " + EscaparSQL(THIS.this_cCpfcs) + ", " + ;
                "rgs = " + EscaparSQL(THIS.this_cRgs) + ", " + ;
                "rgconjuges = " + EscaparSQL(THIS.this_cRgconjuges) + ", " + ;
                "rgcs = " + EscaparSQL(THIS.this_cRgcs) + ", " + ;
                "emissors = " + EscaparSQL(THIS.this_cEmissors) + ", " + ;
                "sexos = " + EscaparSQL(THIS.this_cSexos) + ", " + ;
                "estcivils = " + EscaparSQL(THIS.this_cEstcivils) + ", " + ;
                "nacionals = " + EscaparSQL(THIS.this_cNacionals) + ", " + ;
                "profiss = " + EscaparSQL(THIS.this_cProfiss) + ", " + ;
                "conjuges = " + EscaparSQL(THIS.this_cConjuges) + ", " + ;
                "pis = " + EscaparSQL(THIS.this_cPis) + ", " + ;
                "suframas = " + EscaparSQL(THIS.this_cSuframas) + ", " + ;
                "inscmuns = " + EscaparSQL(THIS.this_cInscmuns) + ", " + ;
                "microemps = " + EscaparSQL(THIS.this_cMicroemps) + ", " + ;
                "optsimples = " + EscaparSQL(THIS.this_cOptsimples) + ", " + ;
                "nascs = " + FormatarDataSQL(THIS.this_dNascs) + ", " + ;
                "dtcasas = " + FormatarDataSQL(THIS.this_dDtcasas) + ", " + ;
                "dtncons = " + FormatarDataSQL(THIS.this_dDtncons) + ", " + ;
                "dataincs = " + FormatarDataSQL(THIS.this_dDataincs) + ", " + ;
                "dtalts = " + "GETDATE()" + ", " + ;
                "datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                "ultcomps = " + FormatarDataSQL(THIS.this_dUltcomps) + ", " + ;
                "dtfilms = " + FormatarDataSQL(THIS.this_dDtfilms) + ", " + ;
                "dtfats = " + FormatarDataSQL(THIS.this_dDtfats) + ", " + ;
                "dtmacums = " + FormatarDataSQL(THIS.this_dDtmacums) + ", " + ;
                "dtadmis = " + FormatarDataSQL(THIS.this_dDtadmis) + ", " + ;
                "dtvals = " + FormatarDataSQL(THIS.this_dDtvals) + ", " + ;
                "autdtavld = " + FormatarDataSQL(THIS.this_dAutdtavld) + ", " + ;
                "penultcomp = " + FormatarDataSQL(THIS.this_dPenultcomp) + ", " + ;
                "dataesp = " + FormatarDataSQL(THIS.this_dDataesp) + ", " + ;
                "dmcasas = " + EscaparSQL(THIS.this_cDmcasas) + ", " + ;
                "dmconjs = " + EscaparSQL(THIS.this_cDmconjs) + ", " + ;
                "dmnascs = " + EscaparSQL(THIS.this_cDmnascs) + ", " + ;
                "endes = " + EscaparSQL(THIS.this_cEndes) + ", " + ;
                "nums = " + EscaparSQL(THIS.this_cNums) + ", " + ;
                "compls = " + EscaparSQL(THIS.this_cCompls) + ", " + ;
                "bairs = " + EscaparSQL(THIS.this_cBairs) + ", " + ;
                "cidas = " + EscaparSQL(THIS.this_cCidas) + ", " + ;
                "estas = " + EscaparSQL(THIS.this_cEstas) + ", " + ;
                "ceps = " + EscaparSQL(THIS.this_cCeps) + ", " + ;
                "paises = " + EscaparSQL(THIS.this_cPaises) + ", " + ;
                "nmuncips = " + FormatarNumeroSQL(THIS.this_nNmuncips, 0) + ", " + ;
                "ddds = " + EscaparSQL(THIS.this_cDdds) + ", " + ;
                "tel1s = " + EscaparSQL(THIS.this_cTel1s) + ", " + ;
                "ddd2s = " + EscaparSQL(THIS.this_cDdd2s) + ", " + ;
                "tel2s = " + EscaparSQL(THIS.this_cTel2s) + ", "

            loc_cSQL = loc_cSQL + ;
                "tel3s = " + EscaparSQL(THIS.this_cTel3s) + ", " + ;
                "faxs = " + EscaparSQL(THIS.this_cFaxs) + ", " + ;
                "ramals = " + EscaparSQL(THIS.this_cRamals) + ", " + ;
                "emails = " + EscaparSQL(THIS.this_cEmails) + ", " + ;
                "contato = " + EscaparSQL(THIS.this_cContato) + ", " + ;
                "contats = " + EscaparSQL(THIS.this_cContats) + ", " + ;
                "ctelems = " + EscaparSQL(THIS.this_cCtelems) + ", " + ;
                "obspagto = " + EscaparSQL(THIS.this_cObspagto) + ", " + ;
                "valemail = " + FormatarNumeroSQL(THIS.this_nValemail, 0) + ", " + ;
                "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                "grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
                "grupovens = " + EscaparSQL(THIS.this_cGrupovens) + ", " + ;
                "grupomats = " + EscaparSQL(THIS.this_cGrupomats) + ", " + ;
                "grupocobs = " + EscaparSQL(THIS.this_cGrupocobs) + ", " + ;
                "grupocents = " + EscaparSQL(THIS.this_cGrupocents) + ", " + ;
                "gruprods = " + EscaparSQL(THIS.this_cGruprods) + ", " + ;
                "grufals = " + EscaparSQL(THIS.this_cGrufals) + ", " + ;
                "contavens = " + EscaparSQL(THIS.this_cContavens) + ", " + ;
                "contaven2s = " + EscaparSQL(THIS.this_cContaven2s) + ", " + ;
                "contamats = " + EscaparSQL(THIS.this_cContamats) + ", " + ;
                "contacobs = " + EscaparSQL(THIS.this_cContacobs) + ", " + ;
                "contacents = " + EscaparSQL(THIS.this_cContacents) + ", " + ;
                "ccontabs = " + EscaparSQL(THIS.this_cCcontabs) + ", " + ;
                "conprods = " + EscaparSQL(THIS.this_cConprods) + ", " + ;
                "codigos = " + EscaparSQL(THIS.this_cCodigos) + ", " + ;
                "hists = " + EscaparSQL(THIS.this_cHists) + ", " + ;
                "tphists = " + FormatarNumeroSQL(THIS.this_nTphists, 0) + ", " + ;
                "regiaos = " + EscaparSQL(THIS.this_cRegiaos) + ", " + ;
                "situas = " + EscaparSQL(THIS.this_cSituas) + ", " + ;
                "codsegs = " + EscaparSQL(THIS.this_cCodegs) + ", " + ;
                "fpags = " + EscaparSQL(THIS.this_cFpags) + ", " + ;
                "tabds = " + EscaparSQL(THIS.this_cTabds) + ", " + ;
                "tabd2s = " + EscaparSQL(THIS.this_cTabd2s) + ", " + ;
                "lprecos = " + EscaparSQL(THIS.this_cLprecos) + ", " + ;
                "transps = " + EscaparSQL(THIS.this_cTransps) + ", " + ;
                "limcres = " + FormatarNumeroSQL(THIS.this_nLimcres, 2) + ", " + ;
                "comis = " + FormatarNumeroSQL(THIS.this_nComis, 2) + ", " + ;
                "juros = " + FormatarNumeroSQL(THIS.this_nJuros, 2) + ", " + ;
                "percdescli = " + FormatarNumeroSQL(THIS.this_nPercdescli, 2) + ", " + ;
                "macums = " + FormatarNumeroSQL(THIS.this_nMacums, 2) + ", " + ;
                "mfats = " + FormatarNumeroSQL(THIS.this_nMfats, 2) + ", " + ;
                "vultcomps = " + FormatarNumeroSQL(THIS.this_nVultcomps, 2) + ", " + ;
                "maxtransps = " + FormatarNumeroSQL(THIS.this_nMaxtransps, 2) + ", " + ;
                "prazoents = " + FormatarNumeroSQL(THIS.this_nPrazoents, 0) + ", " + ;
                "DiasPEntrega = " + FormatarNumeroSQL(THIS.this_nDiasPEntrega, 0) + ", " + ;
                "tpcads = " + FormatarNumeroSQL(THIS.this_nTpcads, 0) + ", " + ;
                "tpclis = " + FormatarNumeroSQL(THIS.this_nTpclis, 0) + ", " + ;
                "tpcps = " + EscaparSQL(THIS.this_cTpcps) + ", "

            loc_cSQL = loc_cSQL + ;
                "inativas = " + FormatarNumeroSQL(THIS.this_nInativas, 0) + ", " + ;
                "coletors = " + FormatarNumeroSQL(THIS.this_nColetors, 0) + ", " + ;
                "vcolets = " + FormatarNumeroSQL(THIS.this_nVcolets, 0) + ", " + ;
                "concilias = " + FormatarNumeroSQL(THIS.this_nConcilias, 0) + ", " + ;
                "gerbals = " + FormatarNumeroSQL(THIS.this_nGerbals, 0) + ", " + ;
                "pagfals = " + FormatarNumeroSQL(THIS.this_nPagfals, 0) + ", " + ;
                "recfals = " + FormatarNumeroSQL(THIS.this_nRecfals, 0) + ", " + ;
                "intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ", " + ;
                "vinculas = " + FormatarNumeroSQL(THIS.this_nVinculas, 0) + ", " + ;
                "consigs = " + FormatarNumeroSQL(THIS.this_nConsigs, 0) + ", " + ;
                "consignas = " + FormatarNumeroSQL(THIS.this_nConsignas, 0) + ", " + ;
                "msgpends = " + FormatarNumeroSQL(THIS.this_nMsgpends, 0) + ", " + ;
                "patrietqs = " + FormatarNumeroSQL(THIS.this_nPatrietqs, 0) + ", " + ;
                "restfors = " + FormatarNumeroSQL(THIS.this_nRestfors, 0) + ", " + ;
                "comcargs = " + FormatarNumeroSQL(THIS.this_nComcargs, 0) + ", " + ;
                "masters = " + FormatarNumeroSQL(THIS.this_nMasters, 0) + ", " + ;
                "libtabcmvs = " + FormatarNumeroSQL(THIS.this_nLibtabcmvs, 0) + ", " + ;
                "aptos = " + FormatarNumeroSQL(THIS.this_nAptos, 0) + ", " + ;
                "chkexcdre = " + FormatarNumeroSQL(THIS.this_nChkexcdre, 0) + ", " + ;
                "invisivel = " + FormatarNumeroSQL(THIS.this_nInvisivel, 0) + ", " + ;
                "autdados = " + FormatarNumeroSQL(THIS.this_nAutdados, 0) + ", " + ;
                "autemail = " + FormatarNumeroSQL(THIS.this_nAutemail, 0) + ", " + ;
                "autsms = " + FormatarNumeroSQL(THIS.this_nAutsms, 0) + ", " + ;
                "autwhats = " + FormatarNumeroSQL(THIS.this_nAutwhats, 0) + ", " + ;
                "autteleg = " + FormatarNumeroSQL(THIS.this_nAutteleg, 0) + ", " + ;
                "ctaencrypt = " + FormatarNumeroSQL(THIS.this_nCtaencrypt, 0) + ", " + ;
                "ddpolegar = " + FormatarNumeroSQL(THIS.this_nDdpolegar, 0) + ", " + ;
                "ddindicado = " + FormatarNumeroSQL(THIS.this_nDdindicado, 0) + ", " + ;
                "ddmedio = " + FormatarNumeroSQL(THIS.this_nDdmedio, 0) + ", " + ;
                "ddanular = " + FormatarNumeroSQL(THIS.this_nDdanular, 0) + ", " + ;
                "ddminimo = " + FormatarNumeroSQL(THIS.this_nDdminimo, 0) + ", " + ;
                "vlrvaltransp = " + FormatarNumeroSQL(THIS.this_nVlrvaltransp, 2) + ", " + ;
                "vlrvalref = " + FormatarNumeroSQL(THIS.this_nVlrvalref, 2) + ", " + ;
                "vlrvalalim = " + FormatarNumeroSQL(THIS.this_nVlrvalalim, 2) + ", " + ;
                "vlrplansaude = " + FormatarNumeroSQL(THIS.this_nVlrplansaude, 2) + ", " + ;
                "vlrplandent = " + FormatarNumeroSQL(THIS.this_nVlrplandent, 2) + ", " + ;
                "endcobs = " + EscaparSQL(THIS.this_cEndcobs) + ", " + ;
                "baicobs = " + EscaparSQL(THIS.this_cBaicobs) + ", " + ;
                "cidcobs = " + EscaparSQL(THIS.this_cCidcobs) + ", " + ;
                "estcobs = " + EscaparSQL(THIS.this_cEstcobs) + ", " + ;
                "cepcobs = " + EscaparSQL(THIS.this_cCepcobs) + ", " + ;
                "paicobs = " + EscaparSQL(THIS.this_cPaicobs) + ", " + ;
                "endtrabs = " + EscaparSQL(THIS.this_cEndtrabs) + ", " + ;
                "numtrabs = " + EscaparSQL(THIS.this_cNumtrabs) + ", " + ;
                "compltrabs = " + EscaparSQL(THIS.this_cCompltrabs) + ", " + ;
                "bairtrabs = " + EscaparSQL(THIS.this_cBairtrabs) + ", " + ;
                "cidatrabs = " + EscaparSQL(THIS.this_cCidatrabs) + ", " + ;
                "estatrabs = " + EscaparSQL(THIS.this_cEstatrabs) + ", " + ;
                "esttrabs = " + EscaparSQL(THIS.this_cEstatrabs) + ", " + ;
                "ceptrabs = " + EscaparSQL(THIS.this_cCeptrabs) + ", " + ;
                "paitrabs = " + EscaparSQL(THIS.this_cPaitrabs) + ", " + ;
                "emptrabs = " + EscaparSQL(THIS.this_cEmptrabs) + ", " + ;
                "cnpjtrabs = " + EscaparSQL(THIS.this_cCnpjtrabs) + ", " + ;
                "teltrabs = " + EscaparSQL(THIS.this_cTeltrabs) + ", " + ;
                "salarios = " + FormatarNumeroSQL(THIS.this_nSalarios, 2) + ", " + ;
                "rendafams = " + FormatarNumeroSQL(THIS.this_nRendafams, 2) + ", " + ;
                "grauparens = " + EscaparSQL(THIS.this_cGrauparens) + ", " + ;
                "endcos = " + EscaparSQL(THIS.this_cEndcos) + ", " + ;
                "nomecos = " + EscaparSQL(THIS.this_cNomecos) + ", " + ;
                "baicos = " + EscaparSQL(THIS.this_cBaicos) + ", " + ;
                "cidcos = " + EscaparSQL(THIS.this_cCidcos) + ", " + ;
                "estcos = " + EscaparSQL(THIS.this_cEstcos) + ", " + ;
                "cepcos = " + EscaparSQL(THIS.this_cCepcos) + ", " + ;
                "complcos = " + EscaparSQL(THIS.this_cComplcos) + ", " + ;
                "numcos = " + FormatarNumeroSQL(THIS.this_nNumcos, 0) + ", " + ;
                "cfos = " + EscaparSQL(THIS.this_cCfos) + ", " + ;
                "codtifs = " + EscaparSQL(THIS.this_cCodtifs) + ", " + ;
                "fpubls = " + EscaparSQL(THIS.this_cFpubls) + ", " + ;
                "cfgfiscos = " + EscaparSQL(THIS.this_cCfgfiscos) + ", " + ;
                "cfgfiscss = " + EscaparSQL(THIS.this_cCfgfiscss) + ", " + ;
                "cfgfisics = " + EscaparSQL(THIS.this_cCfgfisics) + ", " + ;
                "cfgfisiis = " + EscaparSQL(THIS.this_cCfgfisiis) + ", " + ;
                "cfgfisins = " + EscaparSQL(THIS.this_cCfgfisins) + ", " + ;
                "cfgfisips = " + EscaparSQL(THIS.this_cCfgfisips) + ", " + ;
                "cfgfisirs = " + EscaparSQL(THIS.this_cCfgfisirs) + ", " + ;
                "cfgfisiss = " + EscaparSQL(THIS.this_cCfgfisiss) + ", " + ;
                "cfgfispis = " + EscaparSQL(THIS.this_cCfgfispis) + ", " + ;
                "ccargs = " + EscaparSQL(THIS.this_cCcargs) + ", " + ;
                "ean13ents = " + FormatarNumeroSQL(THIS.this_nEan13ents, 0) + ", " + ;
                "ean13cobs = " + FormatarNumeroSQL(THIS.this_nEan13cobs, 0) + ", " + ;
                "pracas = " + EscaparSQL(THIS.this_cPracas) + ", " + ;
                "codvendedor = " + EscaparSQL(THIS.this_cCodvendedor) + ", " + ;
                "usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "usuariocrm = " + EscaparSQL(THIS.this_cUsuariocrm) + ", " + ;
                "senhas = " + EscaparSQL(THIS.this_cSenhas) + ", " + ;
                "ccartoes = " + EscaparSQL(THIS.this_cCcartoes) + ", " + ;
                "cobs = " + EscaparSQL(LEFT(THIS.this_cCobs, 250)) + ", " + ;
                "pais = " + EscaparSQL(THIS.this_cPais) + ", " + ;
                "maes = " + EscaparSQL(THIS.this_cMaes) + ", " + ;
                "obs = " + IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs)) + ", " + ;
                "perfils = " + IIF(EMPTY(THIS.this_cPerfils), "NULL", EscaparSQL(THIS.this_cPerfils)) + ", " + ;
                "pastas = " + IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                "figjpgs = " + IIF(EMPTY(THIS.this_cFigjpgs), "NULL", EscaparSQL(THIS.this_cFigjpgs)) + ", " + ;
                "figlgpds = " + IIF(EMPTY(THIS.this_cFiglgpds), "NULL", EscaparSQL(THIS.this_cFiglgpds)) + " " + ;
                "WHERE iclis = " + EscaparSQL(THIS.this_cIclis)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cUsualts = gc_4c_UsuarioLogado
                THIS.this_dDtalts  = DATETIME()
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar cliente no banco de dados."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SIGCDCLI
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SIGCDCLI WHERE iclis = " + EscaparSQL(THIS.this_cIclis)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir cliente do banco de dados."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

