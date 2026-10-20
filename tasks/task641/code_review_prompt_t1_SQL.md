# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CATIVOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CCARGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS

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
  ControlSource = ""
  ControlSource = ""
	lcQuery = [Select a.Usuarios, a.Senhas, a.CCargs From SigCdUsu a Where Not a.cAtivos='N' and a.usuarios = '] + lcUser + [' order by 1]
	ThisForm.poDataMgr.SQLExecute(lcQuery, 'crUsuar')
lcQuery = [select a.usuarios, a.senhas from SigCdUsu a where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' order by 1]
ThisForm.poDataMgr.SQLExecute(lcQuery, 'crUsuar')
	lcQuery = [select a.usuarios, a.senhas, a.cCargs from SigCdUsu a where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' order by 1]
	ThisForm.poDataMgr.SQLExecute(lcQuery, 'crUsuar')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpAlC.prg) - PRIMEIRAS 756 de 756 linhas:
*====================================================================
* FormSigOpAlC.prg
*
* Dialogo modal de autorizacao para Alteracao de Cotacao de moeda
* (SIGOPALC do legado). Recebe moeda/cotacao-sugerida/data na abertura
* - equivalente a Init(lcMoeda, lnCotacao, ldData) do legado -, valida
* usuario+senha+cargo via SigOpAlCBO e devolve o resultado em
* THIS.this_cRetorno ("OK"+Chr(13)+cotacao+Chr(13)+usuario, ou
* "CANCELADO" - igual ao ThisForm.Retorna original).
*
* Form OPERACIONAL - layout CUSTOMIZADO (flat, SEM PageFrame): o SCX
* legado nao tem Page1/Page2, e um dialogo unico (CLAUDE.md: forms
* OPERACIONAIS nao seguem o padrao Lista/Dados do CRUD - analisar o
* original).
*
* FASE 3/8 - ESTRUTURA BASE: cria o Business Object, carrega a moeda
* (fiel ao CursorQuery('SigCdMoe',...) do Init legado) e monta so os
* elementos decorativos do layout (faixa do cabecalho + os 2 Shapes).
*
* FASE 4/8 - BOTOES: cria obj_4c_CntBotoes (cntBotoes do legado,
* ButtonCount=2 - Confirmar/Sair), posicao e picture EXATOS do dump.
* NAO ha Grid/Page1-Lista/6-botoes-CRUD nesta fase porque o legado NAO
* TEM (form flat sem PageFrame, sem lista de registros - ver comentario
* de ConfigurarBotoes()).
*
* FASE 5/8 - CAMPOS (PARTE 1): cria os 2 campos do bloco "Usuario"
* (dentro de shp_4c_Shape1 - Get_Usuario/Say2 e Get_Senha/Say3 do
* dump), com InputMask/PasswordChar/MaxLength/Alignment EXATOS.
*
* FASE 6/8 - CAMPOS (PARTE 2) E VALIDACOES: completa o bloco
* "Moeda/Cotacao" (dentro de shp_4c_Shape2 - Get_Moeda/Say4 e
* Get_Cotacao/Say1 do dump) e liga os handlers que simulam o Valid de
* cada campo (BINDEVENT "Valid" nao funciona em TextBox - usar KeyPress
* com guarda de Enter/Tab). Este dialogo NAO tem lookup/picker nenhum
* no legado (sem fwBuscaExt/sigacess/F4) - a "validacao de campo" aqui
* eh consulta direta (usuario/senha/cargo/variacao de cotacao), ja
* exposta pelo SigOpAlCBO.
*
* FASE 7/8 - EVENTOS PRINCIPAIS: liga os 2 botoes de obj_4c_CntBotoes
* (BtnConfirmarClick/BtnCancelarClick, equivalentes a btnConfirmar.Click/
* btnSair.Click do legado) fechando o fluxo via
* THIS.this_oBusinessObject.ProcessarAutorizacao()/CancelarAutorizacao().
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO: FormParaBO()/
* BOParaForm() (Form<->BO dos campos Usuario/Senha/Cotacao/Moeda,
* chamados em BtnConfirmarClick/InicializarForm), Activate() (fecha o
* dialogo sozinho quando a moeda nao permite alteracao de cotacao -
* equivalente ao Activate do legado, gap que faltava desde a Fase 3) e
* o fix de THIS.Init() que tratava parametro moeda ausente com NVL()
* em vez de VARTYPE() (regra #15 do CLAUDE.md - NVL so substitui
* .NULL., e parametro nao informado chega como .F., nao .NULL.).
* BtnSalvarClick/BtnBuscarClick/BtnEncerrarClick/CarregarLista/
* AjustarBotoesPorModo/HabilitarCampos/LimparCampos NAO se aplicam -
* ver o comentario dedicado antes de Destroy().
*
* Herda de: FormBase
*====================================================================

DEFINE CLASS FormSigOpAlC AS FormBase

    *-- Propriedades visuais (copiadas do SCX legado - SIGOPALC)
    this_cMensagemErro = ""
    Width        = 540
    Height       = 170
    Caption      = "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o"
    DataSession  = 2
    ShowWindow = 1
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.

    *-- Propriedades do Form (equivalentes as custom properties do legado:
    *   Cotacao/Data/poDataMgr/Retorna)
    this_oBusinessObject = .NULL.
    this_cMoedaParam      = ""        && par_cMoeda recebido no Init (lcMoeda)
    this_nCotacaoParam    = 0         && par_nCotacao recebido no Init (lnCotacao)
    this_dDataParam       = {}        && par_dData recebido no Init (ldData)
    this_nCotacaoOficial  = 0         && ThisForm.Cotacao do legado (fBuscarCotacao)
    this_cRetorno         = "CANCELADO"    && ThisForm.Retorna do legado

    *====================================================================
    * Init - equivalente a Init(lcMoeda, lnCotacao, ldData) do legado.
    * Guarda os parametros ANTES de acionar a cadeia do FormBase (que
    * aplica SET DATE TO BRITISH/SET CENTURY ON e chama InicializarForm).
    *====================================================================
    PROCEDURE Init(par_cMoeda, par_nCotacao, par_dData)
        LOCAL loc_lSucesso

        *-- Parametro ausente chega como .F. (Logico), nao como .NULL. -
        *   NVL(par_cMoeda, "") nao pega esse caso (NVL so substitui
        *   .NULL., e .F. nao eh .NULL.). Testar VARTYPE, igual aos
        *   outros dois parametros.
        THIS.this_cMoedaParam   = IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, "")
        THIS.this_nCotacaoParam = IIF(VARTYPE(par_nCotacao) = "N", par_nCotacao, 0)
        THIS.this_dDataParam    = IIF(VARTYPE(par_dData) = "D", par_dData, DATE())

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarForm - cria o Business Object, carrega a moeda e monta
    * a estrutura visual basica (faixa do cabecalho + shapes).
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpAlCBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_dData    = THIS.this_dDataParam
                THIS.this_oBusinessObject.this_nCotacao = THIS.this_nCotacaoParam

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.this_oBusinessObject.CarregarMoeda(THIS.this_cMoedaParam)

                    *-- Init legado: If !crMoe.Cotas / Messagebox('Esta moeda
                    *   nao permite Alteracao de Cotacao...') / Endif. O
                    *   fechamento em si (ThisForm.Release do Activate legado)
                    *   fica em THIS.Activate() - o dialogo nunca chega a ficar
                    *   interativo, so o aviso sai aqui.
                    IF !THIS.this_oBusinessObject.this_lMoedaPermiteAlteracao
                        MsgAviso("Esta moeda n" + CHR(227) + "o permite Altera" + CHR(231) + ;
                            CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o...", ;
                            "Aten" + CHR(231) + CHR(227) + "o!!!")
                        THIS.this_cRetorno = "CANCELADO"
                    ENDIF
                ENDIF

                THIS.ConfigurarLayoutBase()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()
                THIS.ConfigurarEventosCampos()
                THIS.ConfigurarEventosBotoes()

                *-- So reflete o BO depois de CarregarMoeda ter rodado de
                *   verdade - em gb_4c_ValidandoUI (CarregarMoeda pulado
                *   acima) this_cMoeda fica no default "" da property, e
                *   sobrescrever txt_4c_Moeda apagaria o valor de teste que
                *   ConfigurarCampos ja colocou a partir de this_cMoedaParam.
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.BOParaForm()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar Altera" + ;
                CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfigurarLayoutBase - fundo (Picture do legado), faixa do
    * cabecalho (cnt_4c_Sombra, equivalente ao cntSombra legado) e os 2
    * Shapes decorativos (Shape1/Shape2). Campos (Get_Usuario/Get_Senha/
    * Get_Cotacao/Get_Moeda) e o grupo de botoes (cntBotoes) entram nas
    * fases seguintes.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarLayoutBase()
        THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .AutoSize      = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = THIS.Width - 20
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = THIS.Width - 20
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 96
            .Left          = 103
            .Height        = 58
            .Width         = 162
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Curvature     = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top           = 96
            .Left          = 275
            .Height        = 58
            .Width         = 162
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Curvature     = 0
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarBotoes - grupo de botoes (cntBotoes do legado:
    * ButtonCount=2, Buttons(1)=btnConfirmar/"Salvar", Buttons(2)=
    * btnSair/"Cancelar", Cancel=.T.).
    *
    * FASE 4/8: o template generico desta fase pede "Grid e 6 botoes
    * CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar/Encerrar) na
    * Page1". Este form NAO TEM Page1/Page2 (eh FLAT, sem PageFrame -
    * ver ConfigurarLayoutBase/Fase 3), NAO TEM Grid e NAO TEM lista de
    * registros (analise.json: temGrid=false; layout.json nao tem
    * nenhum BaseClass grid/pageframe) - eh um dialogo modal unico de
    * autorizacao (usuario+senha+alcada) para alterar UMA cotacao, SEM
    * CRUD. Inventar os 6 botoes CRUD ou um PageFrame Lista/Dados
    * violaria o PILAR 1 (UX identica ao legado) e a regra "NUNCA
    * inventar funcionalidade que o legado nao tem" (CLAUDE.md).
    *
    * O que esta fase tem de real para fazer eh exatamente isto: criar
    * os 2 botoes que o legado de fato tem, com posicao/picture/caption
    * EXATOS do dump (SigOpAlC_form_codigo_fonte.txt:344-400). Os
    * handlers de Click (validacao completa de usuario/senha/alcada/
    * cotacao, igual a btnConfirmar.Click/btnSair.Click do legado)
    * dependem dos campos Get_Usuario/Get_Senha/Get_Cotacao/Get_Moeda,
    * que ainda nao existem neste arquivo (entram nas Fases 5-6) - ficam
    * para a fase de eventos, junto com esses campos.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
        WITH THIS.obj_4c_CntBotoes
            .Top         = -2
            .Left        = 385
            .Width       = 160
            .Height      = 85
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption         = "Confirmar"
                .MousePointer    = 15
                .ToolTipText     = "Gravar os Dados Informados"
                .SpecialEffect   = 0
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Cancelar"
                .MousePointer    = 15
                .ToolTipText     = "Sair Sem Gravar os Dados"
                .SpecialEffect   = 0
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarCampos - bloco "Usuario" (Fase 5/8, dentro da moldura
    * shp_4c_Shape1 - Left=103..265) + bloco "Moeda/Cotacao" (Fase 6/8,
    * dentro da moldura shp_4c_Shape2 - Left=275..437). Transcrito de
    * SIGOPALC.Get_Usu(a)rio/Say2, SIGOPALC.Get_Senha/Say3,
    * SIGOPALC.Get_Moeda/Say4 e SIGOPALC.Get_Cota(")ao/Say1
    * (SigOpAlC_form_codigo_fonte.txt:219-340).
    *
    * Get_Moeda eh somente-leitura (When = .F. no legado - o usuario
    * nunca digita a moeda, ela vem do parametro de abertura) e jah
    * chega preenchida com THIS.this_cMoedaParam. Get_Cotacao chega
    * preenchida com THIS.this_nCotacaoParam (cotacao sugerida).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Say2 "Usuario :" (lbl_4c_Label2)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Left      = 123
            .Top       = 104
            .Width     = 49
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Usuario (txt_4c_Usuario) - SigCdUsu.Usuarios char(10)
        THIS.AddObject("txt_4c_Usuario", "TextBox")
        WITH THIS.txt_4c_Usuario
            .Value         = ""
            .Height        = 23
            .Left          = 176
            .Top           = 101
            .Width         = 84
            .MaxLength     = 10
            .InputMask     = "!!!!!!!!!!"
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .TabIndex      = 1
            .Visible       = .T.
        ENDWITH

        *-- Say3 "Senha :" (lbl_4c_Label3)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Senha :"
            .Left      = 129
            .Top       = 129
            .Width     = 43
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Senha (txt_4c_Senha) - SigCdUsu.Senhas char(10)
        THIS.AddObject("txt_4c_Senha", "TextBox")
        WITH THIS.txt_4c_Senha
            .Value         = ""
            .Height        = 23
            .Left          = 176
            .Top           = 126
            .Width         = 84
            .MaxLength     = 10
            .PasswordChar  = "*"
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .TabIndex      = 3
            .Visible       = .T.
        ENDWITH

        *-- Say4 "Moeda :" (lbl_4c_Label4)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Moeda :"
            .Left      = 291
            .Top       = 104
            .Width     = 45
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Moeda (txt_4c_Moeda) - SigCdMoe.Cmoes char(3), somente
        *   leitura (When = .F. no legado) - exibe a moeda recebida no
        *   Init (par_cMoeda), NUNCA editavel pelo usuario.
        THIS.AddObject("txt_4c_Moeda", "TextBox")
        WITH THIS.txt_4c_Moeda
            .Value             = THIS.this_cMoedaParam
            .Height            = 23
            .Left              = 338
            .Top               = 101
            .Width             = 34
            .Alignment         = 3
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .TabIndex          = 5
            .Visible           = .T.
        ENDWITH

        *-- Say1 "Cotacao :" (lbl_4c_Label1)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
            .Left      = 283
            .Top       = 129
            .Width     = 53
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Cotacao (txt_4c_Cotacao) - cotacao digitada pelo usuario,
        *   pre-preenchida com a cotacao sugerida (par_nCotacao do Init).
        THIS.AddObject("txt_4c_Cotacao", "TextBox")
        WITH THIS.txt_4c_Cotacao
            .Value         = THIS.this_nCotacaoParam
            .Height        = 23
            .Left          = 338
            .Top           = 126
            .Width         = 94
            .InputMask     = "9999999.9999"
            .Alignment     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .TabIndex      = 5
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarEventosCampos - liga os handlers que simulam o Valid do
    * legado (BINDEVENT "Valid" NAO funciona em TextBox - usar KeyPress
    * com guarda de Enter/Tab, regra geral do projeto). Get_Usuario.Valid
    * e Get_Senha.Valid/Get_Cotacao.Valid do dump
    * (SigOpAlC_form_codigo_fonte.txt:513-598).
    *
    * Get_Moeda nao recebe handler - eh ReadOnly e o legado tem
    * When = .F. (campo nunca editavel). O guard equivalente ao When de
    * Get_Cotacao (Return Not Empty(ThisForm.Get_Usuario.Value) - so
    * libera a cotacao depois do usuario preenchido) vai no GotFocus de
    * txt_4c_Cotacao.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarEventosCampos()
        BINDEVENT(THIS.txt_4c_Usuario, "KeyPress", THIS, "ValidarUsuario")
        BINDEVENT(THIS.txt_4c_Senha,   "KeyPress", THIS, "ValidarSenha")
        BINDEVENT(THIS.txt_4c_Cotacao, "GotFocus", THIS, "ValidarAcessoCotacao")
        BINDEVENT(THIS.txt_4c_Cotacao, "KeyPress", THIS, "ValidarCotacao")
    ENDPROC

    *====================================================================
    * ConfigurarEventosBotoes - liga os 2 botoes de obj_4c_CntBotoes
    * (Fase 7/8 - eventos principais) aos handlers equivalentes a
    * btnConfirmar.Click/btnSair.Click do legado. Buttons(1) = Confirmar
    * (Command1/btnConfirmar), Buttons(2) = Cancelar (Command2/btnSair) -
    * ver ConfigurarBotoes().
    *====================================================================
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(2), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *====================================================================
    * ValidarUsuario - Get_Usuario.Valid do legado. So valida se o
    * campo nao esta vazio (If Not Empty(This.Value) do dump); achando
    * usuario invalido OU cargo sem acesso para alterar cotacao, BLOQUEIA
    * a saida do campo (o legado faz Return 0 nos dois casos) devolvendo
    * o foco e exibindo a mensagem que o BO deixou em this_cMensagemErro.
    *
    * PUBLIC (sem PROTECTED) - BINDEVENT so funciona com metodo PUBLIC.
    *====================================================================
    PROCEDURE ValidarUsuario(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.txt_4c_Usuario.Value))
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarUsuario(THIS.txt_4c_Usuario.Value)
            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.txt_4c_Usuario.SetFocus()
            NODEFAULT
        ENDIF
    ENDPROC

    *====================================================================
    * ValidarSenha - Get_Senha.Valid do legado. Usuario nao encontrado
    * usa "Return -1" no dump - numerico diferente de zero EH TRUTHY em
    * VFP9, ou seja NAO bloqueia a saida do campo (so avisa); senha
    * incorreta nem tem Return (tambem nao bloqueia). Replicar fielmente:
    * SEMPRE mostrar o aviso quando a validacao falhar, NUNCA devolver o
    * foco (a gravacao real so bloqueia depois, no clique de Confirmar).
    *====================================================================
    PROCEDURE ValidarSenha(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarSenha(THIS.txt_4c_Usuario.Value, THIS.txt_4c_Senha.Value)
            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o!!!")
        ENDIF
    ENDPROC

    *====================================================================
    * ValidarAcessoCotacao - equivalente ao When de Get_Cotacao do legado
    * (Return Not Empty(ThisForm.Get_Usuario.Value)): sem o Usuario
    * preenchido, o campo nao pode ser editado - devolve o foco para
    * txt_4c_Usuario.
    *====================================================================
    PROCEDURE ValidarAcessoCotacao()
        IF EMPTY(ALLTRIM(THIS.txt_4c_Usuario.Value))
            THIS.txt_4c_Usuario.SetFocus()
        ENDIF
    ENDPROC

    *====================================================================
    * ValidarCotacao - Get_Cotacao.Valid do legado: busca a cotacao
    * oficial (fBuscarCotacao) e bloqueia (Return 0) so quando a variacao
    * percentual excede o limite do cargo do usuario E o valor digitado
    * eh diferente de zero - formula/condicao transcritas literalmente
    * do dump, via SigOpAlCBO.ValidarVariacaoCotacao.
    *====================================================================
    PROCEDURE ValidarCotacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nCotacaoOficial
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF THIS.txt_4c_Cotacao.Value = 0
            RETURN
        ENDIF

        loc_nCotacaoOficial = THIS.this_oBusinessObject.ObterCotacaoOficial(THIS.txt_4c_Moeda.Value, ;
            THIS.this_dDataParam)

        IF !THIS.this_oBusinessObject.ValidarVariacaoCotacao(THIS.txt_4c_Cotacao.Value, loc_nCotacaoOficial)
            MsgAviso("Cota" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida", "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.txt_4c_Cotacao.SetFocus()
            NODEFAULT
        ENDIF
    ENDPROC

    *====================================================================
    * BtnConfirmarClick - btnConfirmar.Click do legado (Fase 7/8).
    * Delega a SigOpAlCBO.ProcessarAutorizacao, que encadeia ValidarUsuario
    * -> ValidarSenha -> cotacao preenchida -> variacao maxima do cargo, na
    * MESMA ordem/mensagens do dump. Autorizado: copia this_cRetorno do BO
    * (equivalente a ThisForm.Retorna = "OK"+Chr(13)+cotacao+Chr(13)+
    * usuario), reseta SET DECIMALS TO 2 (igual ao legado, logo antes do
    * Release) e fecha o dialogo. Recusado: exibe a mensagem do BO
    * (MsgAviso - validacao de entrada, nao excecao) e devolve o foco ao
    * campo indicado em this_cCampoFoco, mantendo o dialogo aberto.
    *
    * PUBLIC (sem PROTECTED) - BINDEVENT so funciona com metodo PUBLIC.
    *====================================================================
    PROCEDURE BtnConfirmarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.ProcessarAutorizacao(THIS.txt_4c_Usuario.Value, ;
                THIS.txt_4c_Senha.Value, THIS.txt_4c_Cotacao.Value)

            THIS.this_cRetorno = THIS.this_oBusinessObject.this_cRetorno
            SET DECIMALS TO 2
            THIS.Release()
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o!!!")
            ENDIF

            DO CASE
                CASE THIS.this_oBusinessObject.this_cCampoFoco == "USUARIO"
                    THIS.txt_4c_Usuario.SetFocus()
                CASE THIS.this_oBusinessObject.this_cCampoFoco == "SENHA"
                    THIS.txt_4c_Senha.SetFocus()
                CASE THIS.this_oBusinessObject.this_cCampoFoco == "COTACAO"
                    THIS.txt_4c_Cotacao.SetFocus()
            ENDCASE
        ENDIF
    ENDPROC

    *====================================================================
    * BtnCancelarClick - btnSair.Click do legado (Fase 7/8): equivalente
    * literal a ThisForm.Retorna = "CANCELADO" + ThisForm.Release. Delega
    * a SigOpAlCBO.CancelarAutorizacao() e copia this_cRetorno do BO.
    *
    * PUBLIC (sem PROTECTED) - BINDEVENT so funciona com metodo PUBLIC.
    *====================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.CancelarAutorizacao()
        THIS.this_cRetorno = THIS.this_oBusinessObject.this_cRetorno
        THIS.Release()
    ENDPROC

    *====================================================================
    * FormParaBO - transfere os campos editaveis (Usuario/Senha/Cotacao)
    * para as properties do BO. Chamado no inicio de BtnConfirmarClick,
    * antes de ProcessarAutorizacao() - este.this_cUsuario eh depois
    * sobrescrito pelo proprio ValidarUsuario com o valor confirmado em
    * SigCdUsu (fonte de verdade), e this_cSenha/this_nCotacao sao
    * reatribuidos por ProcessarAutorizacao com os mesmos parametros;
    * ainda assim o Form->BO fica explicito aqui, no padrao do projeto.
    * Get_Moeda nao entra - eh somente-leitura (When=.F. no legado).
    *====================================================================
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cUsuario = ALLTRIM(THIS.txt_4c_Usuario.Value)
        THIS.this_oBusinessObject.this_cSenha   = ALLTRIM(THIS.txt_4c_Senha.Value)
        THIS.this_oBusinessObject.this_nCotacao = THIS.txt_4c_Cotacao.Value
    ENDPROC

    *====================================================================
    * BOParaForm - transfere do BO para o Form apos CarregarMoeda: a
    * moeda exibida passa a ser a confirmada/normalizada por
    * CarregarDoCursor (this_cMoeda, PADR a 3 chars), nao mais o
    * parametro cru do Init. A cotacao sugerida so eh sobrescrita
    * quando o BO ja tem um valor diferente de zero (CarregarMoeda nao
    * altera this_nCotacao - ela so muda de novo apos THIS.FormParaBO()
    * no clique de Confirmar, entao aqui o valor ainda eh o sugerido na
    * abertura).
    *====================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.txt_4c_Moeda.Value = THIS.this_oBusinessObject.this_cMoeda

        IF THIS.this_oBusinessObject.this_nCotacao <> 0
            THIS.txt_4c_Cotacao.Value = THIS.this_oBusinessObject.this_nCotacao
        ENDIF
    ENDPROC

    *====================================================================
    * Activate - equivalente ao Activate do legado (If crMoe.Cotas /
    * ThisForm.Visible=.t. / Else / ThisForm.Release / EndIf): quando a
    * moeda carregada em InicializarForm NAO permite alteracao de
    * cotacao (this_lMoedaPermiteAlteracao = .F.), o dialogo fecha
    * sozinho ao tentar ficar ativo, sem exigir nenhum clique do
    * usuario - o aviso correspondente ja foi exibido em
    * InicializarForm (equivalente ao Messagebox do Init legado).
    *
    * Guard de gb_4c_ValidandoUI: em modo de validacao de UI,
    * CarregarMoeda() eh pulado (regra ja usada em InicializarForm) e
    * this_lMoedaPermiteAlteracao fica no default .F. da property -
    * sem este guard o harness nunca conseguiria inspecionar os
    * controles, porque o form se fecharia antes.
    *====================================================================
    PROCEDURE Activate()
        IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                !THIS.this_oBusinessObject.this_lMoedaPermiteAlteracao
            THIS.Release()
        ENDIF
    ENDPROC

    *====================================================================
    * Metodos CRUD-canonicos que NAO se aplicam a este dialogo (Fase
    * 8/8 - consolidacao final). SigOpAlC eh um dialogo modal UNICO de
    * autorizacao, sem Page1(Lista)/Page2(Dados), sem lista de
    * registros e sem modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR - a
    * mesma analise ja feita nas Fases 3/4/6/7 deste arquivo. Exigir
    * qualquer um deles obrigaria a inventar estrutura que o legado nao
    * tem (viola o PILAR 1 e a regra "NUNCA inventar funcionalidade")
    * ou a criar metodo vazio (stub proibido pela regra de completude):
    *
    *   BtnSalvarClick/BtnBuscarClick/BtnEncerrarClick - convencao de
    *     form CRUD (Page1 "Lista" com Buscar/Encerrar, Page2 "Dados"
    *     com Salvar/Cancelar). O botao de acao deste legado se chama
    *     "Confirmar" (BtnConfirmarClick, ja implementado) e o de saida
    *     "Cancelar" (BtnCancelarClick, ja implementado) - ambos
    *     presentes acima, com os nomes que o legado de fato usa.
    *   CarregarLista/AjustarBotoesPorModo - pressupoem grid de LISTA e
    *     modo atual (this_cModoAtual). analise.json confirma
    *     temGrid=false; layout.json nao declara nenhum BaseClass
    *     grid/pageframe. O "carregamento" real deste dialogo eh
    *     CarregarMoeda() (chamado em InicializarForm), que busca a
    *     UNICA moeda recebida por parametro - nao uma lista.
    *   HabilitarCampos/LimparCampos - pressupoem alternancia entre
    *     modo de edicao e modo de consulta/lista. Aqui so ha UM modo:
    *     o dialogo abre, o usuario se autentica e confirma ou cancela;
    *     nao ha "limpar para o proximo Incluir" nem campo que mude de
    *     ReadOnly por modo (Get_Moeda eh ReadOnly SEMPRE, regra fixa do
    *     legado, ja aplicada em ConfigurarCampos).
    *====================================================================

    *====================================================================
    * Destroy - DODEFAULT() libera o Business Object e rebuilda os
    * popups do menu principal (fix menu-shrinks de forms modais).
    *====================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

### BO (C:\4c\projeto\app\classes\SigOpAlCBO.prg):
*====================================================================
* SigOpAlCBO.prg
*
* Business Object para Alteracao de Cotacao (SigOpAlC)
* Dialogo de autorizacao: usuario+senha com permissao de cargo
* (AltCots = 'S') autoriza a mudanca da cotacao de uma moeda,
* respeitando a variacao maxima percentual do cargo (VarCots).
* Tabela de referencia: SigCdMoe (Cmoes/Cotas)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpAlCBO AS BusinessBase

    *-- Dados de entrada (parametros recebidos pelo form na abertura)
    this_cMoeda = ""    && SigCdMoe.Cmoes char(3) - moeda cuja cotacao sera alterada
    this_cDescricaoMoeda = ""    && SigCdMoe.dmoes char(15) - descricao da moeda
    this_dData  = {}    && Data de referencia para a cotacao (par_ldData do legado)

    *-- Cotacao digitada pelo usuario e cotacao oficial para comparacao
    this_nCotacao       = 0     && Get_Cotacao.Value - valor digitado pelo usuario
    this_nCotacaoAtual  = 0     && ThisForm.Cotacao - cotacao oficial (fBuscarCotacao)

    *-- Autorizacao (usuario + senha + cargo)
    this_cUsuario           = ""    && SigCdUsu.Usuarios - usuario que autoriza
    this_cSenha             = ""    && Senha digitada (nao persistida - uso transitorio na validacao)
    this_cCargoUsuario      = ""    && SigCdUsu.CCargs - cargo do usuario autenticado
    this_nVariacaoMaxima    = 0     && SigCdCrg.VarCots - variacao percentual maxima permitida ao cargo
    this_cAutorizaCotacao   = ""    && SigCdCrg.AltCots ('S'/'N') - cargo pode alterar cotacao

    *-- Estado da moeda e resultado final do dialogo
    this_lMoedaPermiteAlteracao = .F.    && SigCdMoe.Cotas - moeda permite alteracao de cotacao
    this_cRetorno               = ""     && "OK" + Chr(13) + valor + Chr(13) + usuario, ou "CANCELADO"
    this_cCampoFoco             = ""     && "USUARIO"/"SENHA"/"COTACAO" - campo a focar apos falha

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMoe"
            THIS.this_cCampoChave = "Cmoes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpAlCBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - sobrescreve o hook de BusinessBase mapeando as
    * colunas de SigCdMoe (tabela/chave deste BO) do cursor aberto para
    * as propriedades. Fonte UNICA da leitura: nenhum outro metodo le as
    * colunas da moeda direto do cursor.
    *
    * NAO leva PROTECTED - CarregarDoCursor eh PUBLIC na BusinessBase e o
    * Form pode chama-lo de fora; PROTECTED em qualquer nivel da heranca
    * faz a chamada externa estourar "Property not found" em runtime.
    *
    * SELECT (par_cAliasCursor) ANTES de acessar os campos: a sintaxe
    * campo nao existe em VFP9.
    *
    * Existencia de campo conferida com TYPE(alias + ".col") - PEMSTATUS
    * exige OBJETO no 1o argumento e estoura com nome de cursor.
    *
    * cotas eh bit NOT NULL no schema e chega ao VFP ora como Logico ora
    * como Numerico conforme o driver ODBC, por isso o VARTYPE antes de
    * comparar. TratarNulo NAO serve para esta coluna: ele devolve o valor
    * padrao para QUALQUER logico vazio, e .F. eh valor legitimo de cotas.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- cmoes char(3) - chave da moeda
                    IF TYPE(loc_cAlias + ".cmoes") == "C"
                        THIS.this_cMoeda = TratarNulo(cmoes, "")
                    ENDIF

                    *-- dmoes char(15) - descricao da moeda
                    IF TYPE(loc_cAlias + ".dmoes") == "C"
                        THIS.this_cDescricaoMoeda = TratarNulo(dmoes, "")
                    ENDIF

                    *-- cotas bit - moeda permite alteracao de cotacao
                    IF TYPE(loc_cAlias + ".cotas") != "U"
                        THIS.this_lMoedaPermiteAlteracao = IIF(VARTYPE(cotas) = "L", ;
                            cotas, (NVL(cotas, 0) = 1))
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados da moeda:" + CHR(13) + ;
                loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarMoeda - Init legado: CursorQuery('SigCdMoe','CrMoe','Cmoes',
    * Padr(lcMoeda,3)) + checagem de crMoe.Cotas. Carrega this_cMoeda e
    * this_lMoedaPermiteAlteracao; quem decide fechar o dialogo quando a
    * moeda nao permite (Activate.Else do legado: ThisForm.Release) eh o
    * Form, apos chamar este metodo.
    *====================================================================
    PROCEDURE CarregarMoeda(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_cMoeda = PADR(ALLTRIM(NVL(par_cMoeda, "")), 3)
        THIS.this_lMoedaPermiteAlteracao = .F.

        TRY
            IF USED("cursor_4c_Moe")
                USE IN cursor_4c_Moe
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, cotas FROM SigCdMoe " + ;
                       "WHERE cmoes = " + EscaparSQL(THIS.this_cMoeda)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe")

            IF loc_nResultado > 0 AND USED("cursor_4c_Moe") AND !EOF("cursor_4c_Moe")
                *-- a leitura das colunas fica concentrada em CarregarDoCursor
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moe")
                IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Falha ao ler os dados da moeda."
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Moeda n" + CHR(227) + "o cadastrada."
            ENDIF

            IF USED("cursor_4c_Moe")
                USE IN cursor_4c_Moe
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarUsuario - Get_Usuario.Valid / 1a parte do btnConfirmar.Click:
    * localiza o usuario ATIVO em SigCdUsu e confere se o cargo dele
    * (SigCdCrg.AltCots = 'S') autoriza alteracao de cotacao. Preenche
    * this_cUsuario/this_cCargoUsuario/this_nVariacaoMaxima/
    * this_cAutorizaCotacao. NAO valida a senha (ver ValidarSenha).
    *====================================================================
    PROCEDURE ValidarUsuario(par_cUsuario)
        LOCAL loc_lSucesso, loc_cUsuarioPad, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cUsuarioPad = PADR(ALLTRIM(NVL(par_cUsuario, "")), 10)

        IF EMPTY(ALLTRIM(loc_cUsuarioPad))
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido !!"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            loc_cSQL = "SELECT usuarios, senhas, ccargs FROM SigCdUsu " + ;
                       "WHERE cativos <> 'N' AND usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                       " ORDER BY usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuar")

            IF loc_nResultado <= 0 OR !USED("cursor_4c_Usuar") OR RECCOUNT("cursor_4c_Usuar") = 0
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido !!"
            ELSE
                SELECT cursor_4c_Usuar
                GO TOP
                THIS.this_cUsuario      = TratarNulo(usuarios, "")
                THIS.this_cCargoUsuario = TratarNulo(ccargs, "")

                IF THIS.ValidarCargoAutorizacao(THIS.this_cCargoUsuario)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio sem acesso para alterar cota" + ;
                        CHR(231) + CHR(227) + "o !!"
                ENDIF
            ENDIF

            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarCargoAutorizacao - confere SigCdCrg.AltCots = 'S' para o cargo
    * informado e carrega this_nVariacaoMaxima (VarCots), usado depois por
    * ValidarVariacaoCotacao.
    *====================================================================
    PROCEDURE ValidarCargoAutorizacao(par_cCargo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCargoPad
        loc_lSucesso = .F.

        loc_cCargoPad = PADR(ALLTRIM(NVL(par_cCargo, "")), 10)
        THIS.this_cAutorizaCotacao = ""
        THIS.this_nVariacaoMaxima  = 0

        TRY
            IF USED("cursor_4c_Carg")
                USE IN cursor_4c_Carg
            ENDIF

            loc_cSQL = "SELECT ccargs, altcots, varcots FROM SigCdCrg " + ;
                       "WHERE ccargs = " + EscaparSQL(loc_cCargoPad)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carg")

            IF loc_nResultado > 0 AND USED("cursor_4c_Carg") AND !EOF("cursor_4c_Carg")
                SELECT cursor_4c_Carg
                THIS.this_cAutorizaCotacao = TratarNulo(altcots, "")
                THIS.this_nVariacaoMaxima  = TratarNulo(varcots, 0)
                loc_lSucesso = (THIS.this_cAutorizaCotacao == "S")
            ENDIF

            IF USED("cursor_4c_Carg")
                USE IN cursor_4c_Carg
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarSenha - Get_Senha.Valid / 2a parte do btnConfirmar.Click:
    * confere a senha digitada contra SigCdUsu.Senhas (via fCriptografar)
    * para o usuario informado. Mesma comparacao do legado: Padr(Alltrim(
    * senha_digitada),10) == fCriptografar(crUsuar.Senhas).
    *====================================================================
    PROCEDURE ValidarSenha(par_cUsuario, par_cSenha)
        LOCAL loc_lSucesso, loc_cUsuarioPad, loc_cSenhaPad, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cUsuarioPad = PADR(ALLTRIM(NVL(par_cUsuario, "")), 10)
        loc_cSenhaPad   = PADR(ALLTRIM(NVL(par_cSenha, "")), 10)

        TRY
            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            loc_cSQL = "SELECT usuarios, senhas FROM SigCdUsu " + ;
                       "WHERE cativos <> 'N' AND usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                       " ORDER BY usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuar")

            IF loc_nResultado <= 0 OR !USED("cursor_4c_Usuar") OR RECCOUNT("cursor_4c_Usuar") = 0
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido !!"
            ELSE
                SELECT cursor_4c_Usuar
                GO TOP
                IF loc_cSenhaPad == fCriptografar(senhas)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Senha incorreta !!"
                ENDIF
            ENDIF

            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterCotacaoOficial - fBuscarCotacao(moeda, data, poDataMgr) do
    * legado. Guarda o resultado em this_nCotacaoAtual.
    *====================================================================
    PROCEDURE ObterCotacaoOficial(par_cMoeda, par_dData)
        THIS.this_nCotacaoAtual = fBuscarCotacao(par_cMoeda, par_dData, gnConnHandle)
        RETURN THIS.this_nCotacaoAtual
    ENDPROC

    *====================================================================
    * ValidarVariacaoCotacao - Get_Cotacao.Valid / btnConfirmar.Click:
    *   VarCot = (Round(cotacaoDigitada / cotacaoOficial, 2) - 1) * 100
    * Autorizado somente se Abs(VarCot) <= VarCots (variacao maxima do
    * cargo, carregada por ValidarCargoAutorizacao). Formula transcrita
    * literalmente do legado - NAO reescrever (regra do calculo legado).
    *====================================================================
    PROCEDURE ValidarVariacaoCotacao(par_nCotacaoDigitada, par_nCotacaoOficial)
        LOCAL loc_nVariacao
        loc_nVariacao = (ROUND(par_nCotacaoDigitada / par_nCotacaoOficial, 2) - 1) * 100
        RETURN (ABS(loc_nVariacao) <= THIS.this_nVariacaoMaxima)
    ENDPROC

    *====================================================================
    * ProcessarAutorizacao - btnConfirmar.Click do legado: encadeia
    * ValidarUsuario -> ValidarSenha -> cotacao preenchida -> variacao
    * percentual maxima, na MESMA ordem e com as MESMAS mensagens do
    * legado. Quando autoriza, monta this_cRetorno = "OK" + Chr(13) +
    * cotacao + Chr(13) + usuario (igual a ThisForm.Retorna original).
    * Em caso de falha, this_cMensagemErro e this_cCampoFoco ("USUARIO"/
    * "SENHA"/"COTACAO") indicam o que exibir e onde dar SetFocus - quem
    * exibe a mensagem (MsgAviso) e da o SetFocus eh o Form.
    *====================================================================
    PROCEDURE ProcessarAutorizacao(par_cUsuario, par_cSenha, par_nCotacao)
        THIS.this_cMensagemErro = ""
        THIS.this_cCampoFoco    = ""
        THIS.this_cRetorno      = ""
        THIS.this_cSenha        = PADR(ALLTRIM(NVL(par_cSenha, "")), 10)

        IF !THIS.ValidarUsuario(par_cUsuario)
            THIS.this_cCampoFoco = "USUARIO"
            RETURN .F.
        ENDIF

        IF !THIS.ValidarSenha(par_cUsuario, par_cSenha)
            THIS.this_cCampoFoco = "SENHA"
            RETURN .F.
        ENDIF

        IF NVL(par_nCotacao, 0) = 0
            THIS.this_cMensagemErro = "Cota" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!"
            THIS.this_cCampoFoco = "COTACAO"
            RETURN .F.
        ENDIF

        THIS.this_nCotacao = par_nCotacao
        THIS.ObterCotacaoOficial(THIS.this_cMoeda, THIS.this_dData)

        IF !THIS.ValidarVariacaoCotacao(THIS.this_nCotacao, THIS.this_nCotacaoAtual)
            THIS.this_cMensagemErro = "Cota" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!"
            THIS.this_cCampoFoco = "COTACAO"
            RETURN .F.
        ENDIF

        THIS.this_cRetorno = "OK" + CHR(13) + ;
            STR(THIS.this_nCotacao, 15, 4) + CHR(13) + ;
            ALLTRIM(THIS.this_cUsuario)

        RETURN .T.
    ENDPROC

    *====================================================================
    * CancelarAutorizacao - btnSair.Click do legado: ThisForm.Retorna =
    * "CANCELADO". Quem fecha o form (Release) eh quem chama este metodo.
    *====================================================================
    PROCEDURE CancelarAutorizacao()
        THIS.this_cRetorno = "CANCELADO"
        RETURN .T.
    ENDPROC

    *====================================================================
    * Este dialogo NAO persiste nenhuma tabela propria (SigOpAlC nao
    * existe no banco - e um dialogo modal de autorizacao que apenas LE
    * SigCdMoe/SigCdUsu/SigCdCrg e devolve this_cRetorno para quem abriu).
    * Inserir()/Atualizar()/ExecutarExclusao()/ObterChavePrimaria() e
    * RegistrarAuditoria() NAO sao sobrescritos aqui - o comportamento
    * padrao herdado de BusinessBase ja eh o correto para este caso.
    *====================================================================

ENDDEFINE

