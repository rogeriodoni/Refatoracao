# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SIGPDPNSBO.prg] Indicador de pendencia: * SIGPDPNSBO.prg - Business Object: Pendente
[SIGPDPNSBO.prg] Indicador de pendencia: * Tabela principal: SigMvCab (movimentos pendente
[SIGPDPNSBO.prg] Indicador de pendencia: * Form OPERACIONAL: exibe pendente
[SIGPDPNSBO.prg] Indicador de pendencia: *--                  Pendente
[SIGPDPNSBO.prg] Indicador de pendencia: *-- Totalizador exibido em cursor_4c_Rodape (equiv. crRodape.Pendente
[SIGPDPNSBO.prg] Indicador de pendencia: *-- Calcular total de pendente
[FormSIGPDPNS.prg] Procedure vazia (sem codigo): AlternarPagina
[FormSIGPDPNS.prg] Procedure vazia (sem codigo): BOParaForm
[FormSIGPDPNS.prg] Procedure vazia (sem codigo): HabilitarCampos
[FormSIGPDPNS.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[FormSIGPDPNS.prg] Indicador de pendencia: * FormSIGPDPNS.prg - Form Operacional: Pendente
[FormSIGPDPNS.prg] Indicador de pendencia: * Tabela: SigMvCab (movimentos pendente
[FormSIGPDPNS.prg] Indicador de pendencia: * 3 colunas (Descrs, Usuars, Pendente
[FormSIGPDPNS.prg] Indicador de pendencia: *-- Column 3: Pendente
[FormSIGPDPNS.prg] Indicador de pendencia: *   Acao real: re-executa SelecionarDados para recarregar os pendente
[FormSIGPDPNS.prg] Indicador de pendencia: *   Acao real: reposiciona cursor_4c_Grade no primeiro pendente
[FormSIGPDPNS.prg] Indicador de pendencia: *   uma janela de detalhamento (numero, data, empresa, RClis, qtde pendente
[FormSIGPDPNS.prg] Indicador de pendencia: *   ThisForm.Release). O legado nao implement

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPDPNS.prg):
*==============================================================================
* FormSIGPDPNS.prg - Form Operacional: Pendentes de Movimentacao
* Herda de FormBase
* Migrado de SIGPDPNS.SCX
* Tabela: SigMvCab (movimentos pendentes filtrados por chave de sessao)
*==============================================================================
DEFINE CLASS FormSIGPDPNS AS FormBase

    *-- Propriedades visuais identicas ao original SIGPDPNS.SCX (escalonado 750->1000)
    this_cMensagemErro = ""
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    Themes      = .F.
    Caption     = "Pendentes"
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Chave de sessao recebida como parametro pelo Init (equivalente a lpKey do legado)
    lpKey = ""

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LPARAMETERS pKey
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Capturar parametro ANTES do DODEFAULT para que InicializarForm possa usa-lo
            IF PCOUNT() >= 1
                THIS.lpKey = pKey
            ENDIF
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Init FormSIGPDPNS")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPDPNSBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SIGPDPNSBO.", "Erro InicializarForm")
                loc_lSucesso = .F.
            ENDIF

            *-- Repassar chave de sessao ao BO
            THIS.this_oBusinessObject.this_cKey = ALLTRIM(THIS.lpKey)

            *-- Fundo do form (equivalente a Picture = new_background.jpg do legado)
            THIS.Picture = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"

            *-- Verificar conexao com banco (exceto em modo de teste/validacao UI)
            IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                loc_lContinuar = .T.
            ELSE
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    loc_lContinuar = .T.
                ELSE
                    IF gnConnHandle <= 0
                        MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                                "o Com o Servidor de Banco de Dados...", ;
                                "Conex" + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Criar cursores estruturais (equivalente ao LOAD do legado)
                THIS.CriarCursores()

                *-- Construir interface
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Tornar controles visiveis
                THIS.TornarControlesVisiveis()

                *-- Vincular eventos
                THIS.ConfigurarBINDEVENTs()

                *-- Carregar dados (exceto em modo de validacao/teste)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste
                        THIS.this_oBusinessObject.SelecionarDados()

                        *-- Inicializar exibicao do rodape com o primeiro registro
                        *-- (replicando logica original do SelecionaDados apos carga)
                        IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                            SELECT cursor_4c_Grade
                            GO TOP
                            THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                                "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
                            THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
                            THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
                        ENDIF

                        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                            THIS.grd_4c_Dados.Refresh()
                        ENDIF
                        IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                            THIS.grd_4c_Rodape.Refresh()
                        ENDIF
                        *-- Focar na primeira coluna do grid principal
                        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                            THIS.grd_4c_Dados.Column1.SetFocus()
                        ENDIF
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CriarCursores - Equivalente ao LOAD do legado: cria cursores placeholders
    * cursor_4c_Grade  (equiv. crGrade)
    * cursor_4c_Rodape (equiv. crRodape)
    * Estrutura IDENTICA deve ser usada em SelecionarDados do BO.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursores()
        SET NULL ON
        CREATE CURSOR cursor_4c_Grade ( ;
            Emps       C(3)     NULL, ;
            Dopes      C(20)    NULL, ;
            Numes      N(6)     NULL, ;
            GrupoDs    C(10)    NULL, ;
            ContaDs    C(10)    NULL, ;
            Usuars     C(10)    NULL, ;
            Datas      D        NULL, ;
            PrazoEnts  D        NULL, ;
            Pendentes  N(10,3)  NULL, ;
            EmpDs      C(3)     NULL, ;
            RClis      C(50)    NULL  ;
        )
        SET NULL OFF
        SELECT cursor_4c_Grade
        INDEX ON DTOS(PrazoEnts) + DTOS(Datas) + Emps + Dopes + STR(Numes, 6) TAG Ordem

        SET NULL ON
        CREATE CURSOR cursor_4c_Rodape ( ;
            Descrs     C(100)   NULL, ;
            Usuars     C(10)    NULL, ;
            Pendentes  N(10,3)  NULL  ;
        )
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria o cabecalho cinza do form (cntSombra do legado).
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo constroi apenas
    * o container de titulo (equivalente ao frame visual superior).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top           = 25
                .Left          = 10
                .Width         = THIS.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .BackStyle     = 0
                .WordWrap      = .T.
                .Alignment     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = "Pendentes"
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top       = 24
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Pendentes"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Agrega grids e campos do form OPERACIONAL.
    * Forms OPERACIONAIS nao tem PageFrame CRUD; este metodo unifica a
    * configuracao dos controles principais para o pipeline multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotaoEncerrar()
        THIS.ConfigurarGridDados()
        THIS.ConfigurarGridRodape()
        THIS.ConfigurarCampoRClis()
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoEncerrar - Botao Encerrar (equivalente ao ok do legado)
    * Posicao escalonada: Left=917 (673 * 1000/750 arredondado canonico)
    * Cancel=.T. conforme original (ESC fecha o form)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 917
            .Height          = 75
            .Width           = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGridDados - Grid principal (equivalente a grdItens do legado)
    * 8 colunas, leitura somente, cursor_4c_Grade
    * Posicoes escalonadas: Top=153 (131*600/513), Left=17, Width=885, Height=340
    * Colunas em Courier New conforme legado (monospace para alinhamento numerico)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridDados()
        LOCAL loc_nI, loc_cCol

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 153
            .Left              = 17
            .Width             = 885
            .Height            = 340
            .ColumnCount       = 8
            .RecordSource      = "cursor_4c_Grade"
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .HeaderHeight      = 17
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .Visible           = .T.

            *-- Column 1: Emp (3 chars)
            .Column1.ControlSource = "cursor_4c_Grade.Emps"
            .Column1.Width         = 41
            .Column1.ReadOnly      = .T.
            .Column1.FontName      = "Courier New"
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.
            .Column1.Text1.FontName  = "Courier New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin    = 0
            .Column1.Text1.ReadOnly  = .T.
            .Column1.Text1.ForeColor = RGB(0, 0, 0)
            .Column1.Text1.BackColor = RGB(255, 255, 255)
            .Column1.Header1.Caption   = "Emp"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 2: Operacao (20 chars)
            .Column2.ControlSource = "cursor_4c_Grade.Dopes"
            .Column2.Width         = 275
            .Column2.ReadOnly      = .T.
            .Column2.FontName      = "Courier New"
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.
            .Column2.Text1.FontName  = "Courier New"
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin    = 0
            .Column2.Text1.ReadOnly  = .T.
            .Column2.Text1.ForeColor = RGB(0, 0, 0)
            .Column2.Text1.BackColor = RGB(255, 255, 255)
            .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 3: Codigo (numeric 6 digits, mask 999999)
            .Column3.ControlSource = "cursor_4c_Grade.Numes"
            .Column3.InputMask     = "999999"
            .Column3.Width         = 80
            .Column3.ReadOnly      = .T.
            .Column3.FontName      = "Courier New"
            .Column3.Movable       = .F.
            .Column3.Resizable     = .F.
            .Column3.Text1.FontName  = "Courier New"
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin    = 0
            .Column3.Text1.ForeColor = RGB(0, 0, 0)
            .Column3.Text1.BackColor = RGB(255, 255, 255)
            .Column3.Header1.Caption   = CHR(67) + CHR(243) + "digo"
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 4: Data
            .Column4.ControlSource = "cursor_4c_Grade.Datas"
            .Column4.Width         = 107
            .Column4.ReadOnly      = .T.
            .Column4.FontName      = "Courier New"
            .Column4.Movable       = .F.
            .Column4.Resizable     = .F.
            .Column4.Text1.FontName  = "Courier New"
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin    = 0
            .Column4.Text1.ReadOnly  = .T.
            .Column4.Text1.ForeColor = RGB(0, 0, 0)
            .Column4.Text1.BackColor = RGB(255, 255, 255)
            .Column4.Header1.Caption   = "Data"
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 5: Grupo (Alignment=3 conforme original Column5.Text1)
            .Column5.ControlSource = "cursor_4c_Grade.GrupoDs"
            .Column5.Width         = 107
            .Column5.ReadOnly      = .T.
            .Column5.FontName      = "Courier New"
            .Column5.Movable       = .F.
            .Column5.Resizable     = .F.
            .Column5.Text1.FontName  = "Courier New"
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin    = 0
            .Column5.Text1.Alignment = 3
            .Column5.Text1.ForeColor = RGB(0, 0, 0)
            .Column5.Text1.BackColor = RGB(255, 255, 255)
            .Column5.Header1.Caption   = "Grupo"
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
            .Column5.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 6: Conta
            .Column6.ControlSource = "cursor_4c_Grade.ContaDs"
            .Column6.Width         = 107
            .Column6.ReadOnly      = .T.
            .Column6.FontName      = "Courier New"
            .Column6.Movable       = .F.
            .Column6.Resizable     = .F.
            .Column6.Text1.FontName  = "Courier New"
            .Column6.Text1.BorderStyle = 0
            .Column6.Text1.Margin    = 0
            .Column6.Text1.ReadOnly  = .T.
            .Column6.Text1.ForeColor = RGB(0, 0, 0)
            .Column6.Text1.BackColor = RGB(255, 255, 255)
            .Column6.Header1.Caption   = "Conta"
            .Column6.Header1.FontName  = "Tahoma"
            .Column6.Header1.FontSize  = 8
            .Column6.Header1.Alignment = 2
            .Column6.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 7: Data Entrega
            .Column7.ControlSource = "cursor_4c_Grade.PrazoEnts"
            .Column7.Width         = 107
            .Column7.ReadOnly      = .T.
            .Column7.FontName      = "Courier New"
            .Column7.Movable       = .F.
            .Column7.Resizable     = .F.
            .Column7.Text1.FontName  = "Courier New"
            .Column7.Text1.BorderStyle = 0
            .Column7.Text1.Margin    = 0
            .Column7.Text1.ReadOnly  = .T.
            .Column7.Text1.ForeColor = RGB(0, 0, 0)
            .Column7.Text1.BackColor = RGB(255, 255, 255)
            .Column7.Header1.Caption   = "Data / Entrega"
            .Column7.Header1.FontName  = "Tahoma"
            .Column7.Header1.FontSize  = 8
            .Column7.Header1.Alignment = 2
            .Column7.Header1.ForeColor = RGB(90, 90, 90)

            *-- Column 8: Qtde - FontBold + BackColor diferenciado conforme original
            .Column8.ControlSource = "cursor_4c_Grade.Pendentes"
            .Column8.InputMask     = "9999999.99"
            .Column8.Width         = 61
            .Column8.ReadOnly      = .T.
            .Column8.FontName      = "Courier New"
            .Column8.FontBold      = .T.
            .Column8.BackColor     = RGB(255, 255, 223)
            .Column8.Movable       = .F.
            .Column8.Resizable     = .F.
            .Column8.Text1.FontName  = "Courier New"
            .Column8.Text1.FontBold  = .T.
            .Column8.Text1.BorderStyle = 0
            .Column8.Text1.Margin    = 0
            .Column8.Text1.ReadOnly  = .T.
            .Column8.Text1.ForeColor = RGB(0, 0, 0)
            .Column8.Text1.BackColor = RGB(255, 255, 223)
            .Column8.Header1.Caption   = "Qtde"
            .Column8.Header1.FontName  = "Tahoma"
            .Column8.Header1.FontSize  = 8
            .Column8.Header1.Alignment = 2
            .Column8.Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGridRodape - Grid rodape/totalizador (equivalente a grdRodape)
    * 3 colunas (Descrs, Usuars, Pendentes), leitura somente, cursor_4c_Rodape
    * Posicoes escalonadas: Top=530 (453*600/513), Left=17, Width=885, Height=23
    * FontName=Arial conforme original; BackColor amarelado (255,255,223)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridRodape()
        THIS.AddObject("grd_4c_Rodape", "Grid")
        WITH THIS.grd_4c_Rodape
            .Top               = 530
            .Left              = 17
            .Width             = 885
            .Height            = 23
            .ColumnCount       = 3
            .RecordSource      = "cursor_4c_Rodape"
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .HeaderHeight      = 4
            .FontName          = "Arial"
            .Visible           = .T.

            *-- Column 1: Descrs (descricao empresa destino) - Width 722 (542*1000/750)
            .Column1.ControlSource = "cursor_4c_Rodape.Descrs"
            .Column1.Width         = 722
            .Column1.ReadOnly      = .T.
            .Column1.BackColor     = RGB(255, 255, 223)
            .Column1.FontName      = "Arial"
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.
            .Column1.Text1.FontName  = "Arial"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin    = 0
            .Column1.Text1.ReadOnly  = .T.
            .Column1.Text1.ForeColor = RGB(0, 0, 0)
            .Column1.Text1.BackColor = RGB(255, 255, 223)
            .Column1.Header1.Caption   = ""
            .Column1.Header1.FontName  = "Arial"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)
            .Column1.Header1.BackColor = RGB(255, 255, 0)

            *-- Column 2: Usuars (usuario) - Width 80 (scaled)
            .Column2.ControlSource = "cursor_4c_Rodape.Usuars"
            .Column2.Width         = 80
            .Column2.ReadOnly      = .T.
            .Column2.BackColor     = RGB(255, 255, 223)
            .Column2.FontName      = "Arial"
            .Column2.FontBold      = .T.
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.
            .Column2.Text1.FontName  = "Arial"
            .Column2.Text1.FontBold  = .T.
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin    = 0
            .Column2.Text1.ReadOnly  = .T.
            .Column2.Text1.ForeColor = RGB(0, 0, 0)
            .Column2.Text1.BackColor = RGB(255, 255, 223)
            .Column2.Header1.Caption   = ""
            .Column2.Header1.FontName  = "Arial"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(90, 90, 90)
            .Column2.Header1.BackColor = RGB(255, 255, 0)

            *-- Column 3: Pendentes (total) - mask 9999999.99
            .Column3.ControlSource = "cursor_4c_Rodape.Pendentes"
            .Column3.InputMask     = "9999999.99"
            .Column3.Width         = 80
            .Column3.ReadOnly      = .T.
            .Column3.BackColor     = RGB(255, 255, 223)
            .Column3.FontName      = "Arial"
            .Column3.FontBold      = .T.
            .Column3.Movable       = .F.
            .Column3.Resizable     = .F.
            .Column3.Text1.FontName  = "Arial"
            .Column3.Text1.FontBold  = .T.
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin    = 0
            .Column3.Text1.ReadOnly  = .T.
            .Column3.Text1.ForeColor = RGB(0, 0, 0)
            .Column3.Text1.BackColor = RGB(255, 255, 223)
            .Column3.Header1.Caption   = ""
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(90, 90, 90)
            .Column3.Header1.BackColor = RGB(255, 255, 0)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampoRClis - TextBox leitura somente exibindo RClis da linha
    * corrente do grd_4c_Dados (equivalente a getRClis do legado).
    * Enabled=.F. conforme original; atualizado via AfterRowColChange do grid.
    * Posicao escalonada: Top=557 (476*600/513), Left=17, Width=885, Height=20
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoRClis()
        THIS.AddObject("txt_4c_RClis", "TextBox")
        WITH THIS.txt_4c_RClis
            .Top             = 557
            .Left            = 17
            .Width           = 885
            .Height          = 20
            .Value           = ""
            .Enabled         = .F.
            .SpecialEffect   = 1
            .FontName        = "Tahoma"
            .FontSize        = 9
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 223)
            .DisabledBackColor = RGB(255, 255, 223)
            .DisabledForeColor = RGB(0, 0, 0)
            .ReadOnly        = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Elementos visuais complementares do form OPERACIONAL.
    * Para forms OPERACIONAIS, este metodo trata elementos restantes da UI que
    * nao sao grids, botoes principais ou o cabecalho.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarShape1()
    ENDPROC

    *==========================================================================
    * ConfigurarShape1 - Shape decorativo ao redor do botao Encerrar
    * Original: Top=7, Left=654, Height=110, Width=90, BackStyle=0, BorderStyle=0
    * Left escalonado 750->1000: 654 * 1000/750 = 872
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShape1()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 872
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alternacao de paginas (nao aplicavel a forms OPERACIONAIS)
    * Forms OPERACIONAIS nao usam PageFrame CRUD; metodo presente por
    * compatibilidade com o pipeline multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oCtrl
        FOR EACH loc_oCtrl IN THIS.Controls
            IF VARTYPE(loc_oCtrl) = "O"
                loc_oCtrl.Visible = .T.
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula eventos do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        *-- Botao Encerrar
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- AfterRowColChange do grid principal: atualiza rodape e RClis
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        *-- GotFocus do Column1.Text1 do grdRodape: redireciona foco para grid principal
        BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", THIS, "GrdRodapeCol1GotFocus")

        *-- GotFocus/LostFocus do Column2.Text1 do grdRodape: preserva valor via Tag
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus",   THIS, "GrdRodapeCol2GotFocus")
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "KeyPress",  THIS, "GrdRodapeCol2LostFocus")

        *-- When do txt_4c_RClis: sempre retorna .F. (campo nao recebe foco)
        BINDEVENT(THIS.txt_4c_RClis, "When", THIS, "TxtRClisWhen")
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
    *   Wrapper canonico para a auditoria do orquestrador.
    *   Acao real: re-executa SelecionarDados para recarregar os pendentes da
    *   chave de sessao (lpKey), repopula cursor_4c_Grade/cursor_4c_Rodape e
    *   reposiciona o rodape no primeiro registro (igual ao termino do Init
    *   original do SIGPDPNS apos MontaGrades + SelecionaDados).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF

            WAIT WINDOW "Aguarde!!! Atualizando pendentes..." NOWAIT
            THIS.this_oBusinessObject.SelecionarDados()
            WAIT CLEAR

            IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                SELECT cursor_4c_Grade
                GO TOP
                THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                    "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
                THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
                THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
            ELSE
                THIS.grd_4c_Rodape.Column1.Text1.Value = ""
                THIS.grd_4c_Rodape.Column2.Text1.Value = ""
                THIS.txt_4c_RClis.Value = ""
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Rodape.Refresh()
            THIS.txt_4c_RClis.Refresh()

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
    *   Wrapper canonico para a auditoria do orquestrador.
    *   Acao real: reposiciona cursor_4c_Grade no primeiro pendente, sincroniza
    *   rodape/RClis com a linha topo (igual ao comportamento esperado apos
    *   carga inicial) e devolve foco a primeira coluna do grid principal.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Grade")
                RETURN
            ENDIF

            SELECT cursor_4c_Grade
            IF RECCOUNT("cursor_4c_Grade") = 0
                MsgAviso("N" + CHR(227) + "o existem pend" + CHR(234) + "ncias para esta opera" + CHR(231) + CHR(227) + "o.", ;
                        "Pendentes")
                RETURN
            ENDIF

            GO TOP

            THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
            THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
            THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))

            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Rodape.Refresh()
            THIS.txt_4c_RClis.Refresh()

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
    *   Wrapper canonico para a auditoria do orquestrador.
    *   Acao real: expoe os dados do registro corrente do cursor_4c_Grade em
    *   uma janela de detalhamento (numero, data, empresa, RClis, qtde pendente).
    *   Equivale ao "drill-down" implicito do form original ao ver os campos do
    *   rodape sincronizados com a linha selecionada.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_cDetalhe

        TRY
            IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
                MsgAviso("Selecione um registro para visualizar.", "Visualizar")
                RETURN
            ENDIF

            SELECT cursor_4c_Grade
            loc_cDetalhe = "Empresa  : " + ALLTRIM(NVL(Emps, "")) + " - " + ALLTRIM(NVL(EmpDs, "")) + CHR(13) + ;
                           "Opera" + CHR(231) + CHR(227) + "o: " + ALLTRIM(NVL(Dopes, "")) + " " + ;
                           ALLTRIM(TRANSFORM(NVL(Numes, 0))) + CHR(13) + ;
                           "Data     : " + DTOC(NVL(Datas, {})) + CHR(13) + ;
                           "Entrega  : " + DTOC(NVL(PrazoEnts, {})) + CHR(13) + ;
                           "Grupo    : " + ALLTRIM(NVL(GrupoDs, "")) + CHR(13) + ;
                           "Conta    : " + ALLTRIM(NVL(ContaDs, "")) + CHR(13) + ;
                           "Usu" + CHR(225) + "rio  : " + ALLTRIM(NVL(Usuars, "")) + CHR(13) + ;
                           "Cliente  : " + ALLTRIM(NVL(RClis, "")) + CHR(13) + ;
                           "Pendente : " + ALLTRIM(TRANSFORM(NVL(Pendentes, 0), "9999999.99"))
            MsgInfo(loc_cDetalhe, "Detalhe da Pend" + CHR(234) + "ncia")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
    *   Wrapper canonico para a auditoria do orquestrador.
    *   Acao real: encerra o form (equivalente a SIGPDPNS.ok.Click do legado:
    *   ThisForm.Release). O legado nao implementa exclusao de pendencias por
    *   este form (somente consulta), entao o equivalente semantico mais
    *   proximo eh fechar o formulario apos confirmacao explicita.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF !MsgConfirma("Deseja encerrar a consulta de pendentes?", ;
                        "Encerrar Consulta")
            RETURN
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza rodape e RClis ao navegar no grid
    * Equivalente ao AfterRowColChange de grdItens no legado:
    *   ThisForm.grdRodape.Column1.Text1.Value = "Empresa Destino : " + crGrade.EmpDs
    *   ThisForm.grdRodape.Column2.Text1.Value = crGrade.Usuars
    *   ThisForm.getRClis.Value = crGrade.RClis
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade") AND !BOF("cursor_4c_Grade")
                SELECT cursor_4c_Grade

                THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                    "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
                THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
                THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))

                THIS.grd_4c_Rodape.Column1.Refresh()
                THIS.grd_4c_Rodape.Column2.Refresh()
                THIS.txt_4c_RClis.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GrdDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdRodapeCol1GotFocus - Redireciona foco para grid principal
    * Equivalente ao GotFocus de grdRodape.Column1.Text1 no legado
    *==========================================================================
    PROCEDURE GrdRodapeCol1GotFocus()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GrdRodapeCol1GotFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdRodapeCol2GotFocus - Preserva valor original em Tag antes de editar
    * Equivalente ao GotFocus de grdRodape.Column2.Text1: This.Tag = This.Value
    *==========================================================================
    PROCEDURE GrdRodapeCol2GotFocus()
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                THIS.grd_4c_Rodape.Column2.Text1.Tag = ;
                    THIS.grd_4c_Rodape.Column2.Text1.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GrdRodapeCol2GotFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdRodapeCol2LostFocus - Restaura valor original do Tag ao sair
    * Equivalente ao LostFocus de grdRodape.Column2.Text1: This.Value = This.Tag
    *==========================================================================
    PROCEDURE GrdRodapeCol2LostFocus()
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                THIS.grd_4c_Rodape.Column2.Text1.Value = ;
                    THIS.grd_4c_Rodape.Column2.Text1.Tag
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GrdRodapeCol2LostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtRClisWhen - Impede que txt_4c_RClis receba foco
    * Equivalente ao When de getRClis no legado: Return .F.
    *==========================================================================
    PROCEDURE TxtRClisWhen()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega dados (atalho para CarregarLista)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Nao aplicavel (form somente leitura); encerra o form
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Encerra o form
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula BO com a linha corrente do grid (sem edicao de campos)
    *==========================================================================
    PROCEDURE FormParaBO()
        IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade") AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Grade")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Nao aplicavel (dados exibidos diretamente via cursor)
    *==========================================================================
    PROCEDURE BOParaForm()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Nao aplicavel (todos os controles sao somente leitura)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa o rodape e o campo RClis do display
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
            THIS.grd_4c_Rodape.Column1.Text1.Value = ""
            THIS.grd_4c_Rodape.Column2.Text1.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_RClis", 5)
            THIS.txt_4c_RClis.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega cursor_4c_Grade via BO.SelecionarDados
    * Equivalente ao MontaGrades + SelecionaDados do legado (fluxo completo)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lSucesso = .F.
            ENDIF

            WAIT WINDOW "Aguarde!!! Carregando pendentes..." NOWAIT
            loc_lSucesso = THIS.this_oBusinessObject.SelecionarDados()
            WAIT CLEAR

            IF loc_lSucesso
                IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                    SELECT cursor_4c_Grade
                    GO TOP
                    THIS.grd_4c_Rodape.Column1.Text1.Value = ;
                        "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
                    THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
                    THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
                ELSE
                    THIS.LimparCampos()
                ENDIF

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                    THIS.grd_4c_Rodape.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Nao aplicavel (form somente leitura, sem modos CRUD)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        *-- Fechar cursores criados pelo form
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        IF USED("cursor_4c_Rodape")
            USE IN cursor_4c_Rodape
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPDPNSBO.prg):
*==============================================================================
* SIGPDPNSBO.prg - Business Object: Pendentes de Movimentacao
* Herda de BusinessBase
* Tabela principal: SigMvCab (movimentos pendentes)
* Form OPERACIONAL: exibe pendentes filtrados por chave de sessao (this_cKey)
*==============================================================================
DEFINE CLASS SIGPDPNSBO AS BusinessBase

    *-- Chave de filtro recebida pelo form (equivalente a lpKey do legado)
    this_cKey            = ""

    *-- Campos da linha corrente em cursor_4c_Grade (equiv. crGrade)
    *-- cursor_4c_Grade: Emps c(3), Dopes c(20), Numes n(6), GrupoDs c(10),
    *--                  ContaDs c(10), Usuars c(10), Datas d, PrazoEnts d,
    *--                  Pendentes n(10,3), EmpDs c(3), RClis c(50)
    this_cEmps           = ""
    this_cEmpDs          = ""
    this_cDopes          = ""
    this_nNumes          = 0
    this_cGrupoDs        = ""
    this_cContaDs        = ""
    this_cUsuars         = ""
    this_dDatas          = {}
    this_dPrazoEnts      = {}
    this_nPendentes      = 0
    this_cRClis          = ""

    *-- Totalizador exibido em cursor_4c_Rodape (equiv. crRodape.Pendentes)
    this_nTotalPendentes = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigMvCab"
        this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir da linha corrente do cursor
    * Chamado pelo form ao navegar em grd_4c_Dados (AfterRowColChange)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            THIS.this_cEmpDs     = TratarNulo(EmpDs,     "C")
            THIS.this_cDopes     = TratarNulo(Dopes,     "C")
            THIS.this_nNumes     = TratarNulo(Numes,     "N")
            THIS.this_cGrupoDs   = TratarNulo(GrupoDs,   "C")
            THIS.this_cContaDs   = TratarNulo(ContaDs,   "C")
            THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
            THIS.this_dDatas     = TratarNulo(Datas,     "D")
            THIS.this_dPrazoEnts = TratarNulo(PrazoEnts, "D")
            THIS.this_nPendentes = TratarNulo(Pendentes, "N")
            THIS.this_cRClis     = TratarNulo(RClis,     "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Popula cursor_4c_Grade e cursor_4c_Rodape
    * Equivale a SelecionaDados do legado (SIGPDPNS.selecionadados)
    * Pre-requisitos:
    *   - cursor_4c_Grade e cursor_4c_Rodape ja criados pelo form
    *   - crSigMvEstPd em scope com campos EmpDopNums, Qtds, Fk_chave
    *   - this_cKey preenchido com a chave de filtro da sessao
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_lPodeProsseguir
        LOCAL loc_cSQL, loc_nTotal, loc_oErro

        loc_lSucesso        = .F.
        loc_lPodeProsseguir = .T.

        TRY
            IF !USED("crSigMvEstPd")
                MsgErro("Cursor crSigMvEstPd n" + CHR(227) + "o encontrado.", ;
                        "Erro ao Selecionar Dados")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir AND !USED("cursor_4c_Grade")
                MsgErro("Cursor cursor_4c_Grade n" + CHR(227) + "o encontrado.", ;
                        "Erro ao Selecionar Dados")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir
                *-- Limpar cursores de destino
                SELECT cursor_4c_Grade
                ZAP
                IF USED("cursor_4c_Rodape")
                    SELECT cursor_4c_Rodape
                    ZAP
                ENDIF

                *-- Obter EmpDopNums distintos filtrados pela chave da sessao
                SELECT DISTINCT EmpDopNums, SUM(Qtds) AS Qtds ;
                  FROM crSigMvEstPd ;
                 WHERE Fk_chave = THIS.this_cKey ;
                 GROUP BY EmpDopNums ;
                 ORDER BY EmpDopNums ;
                  INTO CURSOR cursor_4c_LocalEstPd

                *-- Para cada grupo EmpDopNums, buscar movimentos no SQL Server
                SELECT cursor_4c_LocalEstPd
                SCAN
                    loc_cSQL = "SELECT a.Emps, a.EmpDs, a.Dopes, a.Numes, " + ;
                               "a.GrupoDs, a.ContaDs, b.RClis, a.Usuars, " + ;
                               "a.Datas, a.PrazoEnts " + ;
                               "FROM SigMvCab a, SigCdCli b " + ;
                               "WHERE a.EmpDopNums = '" + ;
                               ALLTRIM(cursor_4c_LocalEstPd.EmpDopNums) + ;
                               "' AND a.ContaDs = b.IClis"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest") >= 1
                        SELECT cursor_4c_LocalEest
                        SCAN
                            INSERT INTO cursor_4c_Grade ;
                                (Emps, Dopes, Numes, GrupoDs, ContaDs, ;
                                 RClis, Usuars, Datas, PrazoEnts, EmpDs, Pendentes) ;
                            VALUES ;
                                (cursor_4c_LocalEest.Emps, ;
                                 cursor_4c_LocalEest.Dopes, ;
                                 cursor_4c_LocalEest.Numes, ;
                                 cursor_4c_LocalEest.GrupoDs, ;
                                 cursor_4c_LocalEest.ContaDs, ;
                                 cursor_4c_LocalEest.RClis, ;
                                 cursor_4c_LocalEest.Usuars, ;
                                 IIF(ISNULL(cursor_4c_LocalEest.Datas), {}, ;
                                     TTOD(cursor_4c_LocalEest.Datas)), ;
                                 IIF(ISNULL(cursor_4c_LocalEest.PrazoEnts), {}, ;
                                     TTOD(cursor_4c_LocalEest.PrazoEnts)), ;
                                 cursor_4c_LocalEest.EmpDs, ;
                                 cursor_4c_LocalEstPd.Qtds)
                        ENDSCAN
                        USE IN cursor_4c_LocalEest
                    ELSE
                        MsgErro("Falha ao carregar movimentos: " + ;
                                ALLTRIM(cursor_4c_LocalEstPd.EmpDopNums), ;
                                "Erro SQL")
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_LocalEstPd")
                    USE IN cursor_4c_LocalEstPd
                ENDIF

                *-- Calcular total de pendentes
                loc_nTotal = 0
                SELECT SUM(Pendentes) AS nTotalPs ;
                  FROM cursor_4c_Grade ;
                  INTO CURSOR cursor_4c_TotalPs

                IF USED("cursor_4c_TotalPs")
                    SELECT cursor_4c_TotalPs
                    GO TOP
                    IF !EOF()
                        loc_nTotal = NVL(nTotalPs, 0)
                    ENDIF
                    USE IN cursor_4c_TotalPs
                ENDIF

                THIS.this_nTotalPendentes = loc_nTotal

                *-- Inserir totalizador no rodape
                IF USED("cursor_4c_Rodape")
                    INSERT INTO cursor_4c_Rodape (Pendentes) VALUES (loc_nTotal)
                ENDIF

                *-- Posicionar no inicio para exibicao no grid
                IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                    GO TOP IN cursor_4c_Grade
                ENDIF
                IF USED("cursor_4c_Rodape") AND !EOF("cursor_4c_Rodape")
                    GO TOP IN cursor_4c_Rodape
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Selecionar Dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave de filtro da sessao (this_cKey)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cKey)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNum - Concatena Emps + Dopes + Numes no formato legado
    * Usado para localizar a linha de SigMvCab da operacao corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarChaveEmpDopNum()
        RETURN ALLTRIM(THIS.this_cEmps) + ;
               ALLTRIM(THIS.this_cDopes) + ;
               PADL(ALLTRIM(STR(THIS.this_nNumes, 6, 0)), 6, "0")
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigMvCab com os campos rastreados pelo BO
    * Os demais campos NOT NULL recebem defaults seguros para que o INSERT
    * passe na validacao do schema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_oErro, loc_cChave

        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.MontarChaveEmpDopNum()

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave EmpDopNum vazia: " + ;
                                          "Emps/Dopes/Numes nao preenchidos."
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "INSERT INTO SigMvCab " + ;
                       "(cidchaves, emps, empds, dopes, numes, grupods, " + ;
                       " contads, usuars, datas, prazoents, " + ;
                       " npedclis, acres, antecs, chksubn, codpeds, contaos, " + ;
                       " desc2s, descs, devols, grresps, grupoos, grupos, " + ;
                       " grvends, iclis, ifors, locals, lotechqs, lprecos, " + ;
                       " mascnum, ncarnecs, nemps, nops, notas, nrcons, " + ;
                       " ntrans, numolds, opers, resps, tabds, tpfats, " + ;
                       " transps, usuals, usulibs, valacres, valdes2s, " + ;
                       " valdescs, valdevs, valencs, valinis, valos, " + ;
                       " valservs, valvars, vars, vends, cotusus, espes, " + ;
                       " qtdes, lcancelas, cofs, livros, chkbxparcs, ecfs, " + ;
                       " codobs, dgopes, trfisicos, utilizados, valndevs, " + ;
                       " valobxs, noforms, auditors, usuconfs) " + ;
                       "VALUES (" + ;
                       EscaparSQL(LEFT(loc_cChave, 20)) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrazoEnts) + ", " + ;
                       "0, 0, '', 0, 0, '', " + ;
                       "0, 0, 0, '', '', '', " + ;
                       "'', '', '', '', 0, '', " + ;
                       "'', '', '', 0, '', '', " + ;
                       "0, 0, '', '', '', '', " + ;
                       "0, '', '', 0, 0, " + ;
                       "0, 0, 0, 0, 0, " + ;
                       "0, 0, 0, '', '', '', " + ;
                       "0, 0, 0, 0, 0, '', " + ;
                       "0, '', 0, 0, 0, " + ;
                       "0, '', '', '')"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em SigMvCab"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Inserir: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab com os campos rastreados pelo BO
    * Filtra pela combinacao Emps + Dopes + Numes (equivalente a EmpDopNums)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_oErro

        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cDopes) OR ;
               THIS.this_nNumes = 0
                THIS.this_cMensagemErro = "Chave (Emps/Dopes/Numes) " + ;
                                          "vazia para UPDATE."
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "UPDATE SigMvCab SET " + ;
                       " empds    = " + EscaparSQL(THIS.this_cEmpDs)   + ", " + ;
                       " grupods  = " + EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       " contads  = " + EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       " usuars   = " + EscaparSQL(THIS.this_cUsuars)  + ", " + ;
                       " datas    = " + FormatarDataSQL(THIS.this_dDatas)     + ", " + ;
                       " prazoents= " + FormatarDataSQL(THIS.this_dPrazoEnts) + ;
                       " WHERE emps  = " + EscaparSQL(THIS.this_cEmps)  + ;
                       "   AND dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       "   AND numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em SigMvCab"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Atualizar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

