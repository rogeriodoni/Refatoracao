# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[16/05/2026 12:59:11 PM] Erro: Erro ao inicializar FormSIGREAUP:Linha: 795Property FORECOLOR is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-16 12:59:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 12:59:10] [INFO] Config FPW: (nao fornecido)
[2026-05-16 12:59:10] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 12:59:10] [INFO] Timeout: 300 segundos
[2026-05-16 12:59:10] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_slmj5boq.prg
[2026-05-16 12:59:10] [INFO] Conteudo do wrapper:
[2026-05-16 12:59:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGREAUP', 'C:\4c\tasks\task036', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREAUP', 'C:\4c\tasks\task036', 'REPORT'
QUIT

[2026-05-16 12:59:10] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_slmj5boq.prg
[2026-05-16 12:59:10] [INFO] VFP output esperado em: C:\4c\tasks\task036\vfp_output.txt
[2026-05-16 12:59:10] [INFO] Executando Visual FoxPro 9...
[2026-05-16 12:59:10] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_slmj5boq.prg
[2026-05-16 12:59:10] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_slmj5boq.prg
[2026-05-16 12:59:10] [INFO] Timeout configurado: 300 segundos
[2026-05-16 12:59:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 12:59:12] [INFO] VFP9 finalizado em 1.9088467 segundos
[2026-05-16 12:59:12] [INFO] Exit Code: 
[2026-05-16 12:59:12] [INFO] 
[2026-05-16 12:59:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 12:59:12] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_slmj5boq.prg
[2026-05-16 12:59:12] [INFO] 
[2026-05-16 12:59:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 12:59:12] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 12:59:12] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 12:59:12] [INFO] * Parameters: 'FormSIGREAUP', 'C:\4c\tasks\task036', 'REPORT'
[2026-05-16 12:59:12] [INFO] 
[2026-05-16 12:59:12] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 12:59:12] [INFO] SET SAFETY OFF
[2026-05-16 12:59:12] [INFO] SET RESOURCE OFF
[2026-05-16 12:59:12] [INFO] SET TALK OFF
[2026-05-16 12:59:12] [INFO] SET NOTIFY OFF
[2026-05-16 12:59:12] [INFO] SYS(2335, 0)
[2026-05-16 12:59:12] [INFO] 
[2026-05-16 12:59:12] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREAUP', 'C:\4c\tasks\task036', 'REPORT'
[2026-05-16 12:59:12] [INFO] QUIT
[2026-05-16 12:59:12] [INFO] 
[2026-05-16 12:59:12] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 12:59:12] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGREAUP",
  "timestamp": "20260516125911",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
  }
}



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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAUP.prg):
*==============================================================================
* FormSIGREAUP.PRG
* Formulario de Relatorio de Tipos de Autorizacoes de Producao
* Herda de FormBase
*
* Tipo: REPORT (frmrelatorio) - Layout FLAT do legado, encapsulado em PageFrame
* BO: SIGREAUPBO (heranca de RelatorioBase)
* Reports: SigReAu1.frx (listagem), SigReAu2.frx (percentual)
*
* Migrado de: SIGREAUP.SCX (frmrelatorio)
* Filtros: Periodo, Grupo, Conta, Envelope, Codigo NCF, Ordem, Percentual
*
* Estrutura (Fase 3 - Estrutura Base):
*   * Init() delega para FormBase via DODEFAULT()
*   * InicializarForm() instancia BO, cria cabecalho, botoes e PageFrame de 1 pagina
*   * ConfigurarCabecalho() - cnt_4c_Cabecalho cinza medio com titulo
*   * ConfigurarBotoes()    - cmg_4c_Botoes (CommandGroup 4 botoes)
*   * ConfigurarPageFrame() - pgf_4c_Paginas com 1 pagina "Filtros"
*   * Eventos Click dos botoes (Visualizar/Imprimir/Documento/Encerrar)
*   * Destroy() libera referencia ao BO
*
* Fase 4: ConfigurarCamposFiltro + FormParaRelatorio + lookups (Grupo/Conta/NCF) completos
* Fase 5: ConfigurarPaginaDados() com BINDEVENTs de lookup (5 KeyPress)
* Fase 6: DblClick BINDEVENTs para todos os 5 campos de lookup + handlers DblClick
*==============================================================================

DEFINE CLASS FormSIGREAUP AS FormBase

    *-- Propriedades visuais EXATAS do original SIGREAUP.SCX
    Height       = 300
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Relat" + CHR(243) + "rio de Tipos de Autoriza" + CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o"
    ControlBox   = .F.
    ClipControls = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    WindowType   = 1
    BackColor    = RGB(192, 192, 192)
    ShowWindow   = 1

    *-- Referencia ao Business Object do relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que invoca THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption e Picture (fundo do form)
    *   2. Instancia SIGREAUPBO
    *   3. Monta cabecalho escuro com titulo
    *   4. Monta CommandGroup de 4 botoes (Visualizar/Imprimir/Documento/Encerrar)
    *   5. Monta PageFrame de 1 pagina ("Filtros") onde os filtros serao adicionados
    *   6. Inicializa filtros do BO com valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Garantir caminho de icones disponivel
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Verificar conexao SQL (exceto em modo validacao UI)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                    MsgErro("Erro de conex" + CHR(227) + "o com banco de dados.", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Instanciar Business Object de relatorio
            IF loc_lContinuar
                THIS.this_oRelatorio = CREATEOBJECT("SIGREAUPBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar SIGREAUPBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente cntSombra/lblTitulo do frmrelatorio)
                THIS.ConfigurarCabecalho()

                *-- CommandGroup com 4 botoes (Visualizar/Imprimir/Documento/Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame de 1 pagina ("Filtros") - hospeda os campos de filtro
                THIS.ConfigurarPageFrame()

                *-- Campos de filtro dentro da Page1 (TextBoxes, OptionGroup, CheckBox)
                THIS.ConfigurarCamposFiltro()

                *-- BINDEVENTs de lookup nos campos de filtro (Fase 5)
                THIS.ConfigurarPaginaDados()

                *-- Cursores auxiliares para validacao de lookup por SEEK
                THIS.CarregarCursoresLookup()

                *-- Garantir captions do cabecalho coerentes
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Inicializa filtros do BO (pula em modo validacao UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.LimparCampos()
                ENDIF

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGREAUP:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do relatorio
    *   Equivalente ao cntSombra/lblSombra/lblTitulo do framework frmrelatorio
    *   BackColor=RGB(100,100,100) cinza medio OPACO (BackStyle=1)
    *   Titulo branco sobre fundo escuro (ForeColor=RGB(255,255,255))
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

        *-- Sombra do texto (efeito 3D - texto preto ligeiramente deslocado)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .T.
            .Caption   = "Relat" + CHR(243) + "rio de Tipos de Autoriza" + ;
                         CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Titulo principal (texto branco sobre fundo cinza escuro)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 20
            .Left      = 10
            .AutoSize  = .T.
            .Caption   = "Relat" + CHR(243) + "rio de Tipos de Autoriza" + ;
                         CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do framework frmrelatorio (btnReport do original):
    *   Left=528, Top=0, Width=273, Height=80, ButtonCount=4
    *   Incremento entre botoes: 66px (Left: 5, 71, 137, 203)
    *   Buttons(4).Cancel = .T. (ESC fecha o form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 528
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao 1: Visualizar (preview na tela)
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        *-- Botao 2: Imprimir (com dialogo de selecao de impressora)
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        *-- Botao 3: Documento (impressao direta sem dialogo)
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Documento"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")

        *-- Botao 4: Encerrar (ESC fecha via .Cancel = .T.)
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame de 1 pagina ("Filtros")
    *   O form legado SIGREAUP e FLAT (sem PageFrame), mas no novo padrao os
    *   campos de filtro sao agrupados em um PageFrame de 1 pagina para
    *   consistencia visual e arquitetural com o restante do sistema.
    *
    *   O PageFrame fica logo abaixo do cabecalho (Top=85) e cobre o restante
    *   do form ate o bottom. Os filtros (TextBoxes, OptionGroup, CheckBox)
    *   serao adicionados DENTRO da Page1 nas Fases 5-6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Logo abaixo do cabecalho (80px) ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa filtros do BO e dos campos do form com valores padrao
    *   Chamado no InicializarForm() e apos execucao do relatorio
    *   Periodo default = data corrente; demais filtros vazios
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina

        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_dDtInicial = DATE()
            THIS.this_oRelatorio.this_dDtFinal   = DATE()
            THIS.this_oRelatorio.this_cGrupo     = ""
            THIS.this_oRelatorio.this_cDGrupo    = ""
            THIS.this_oRelatorio.this_cConta     = ""
            THIS.this_oRelatorio.this_cDConta    = ""
            THIS.this_oRelatorio.this_nEnvelope  = 0
            THIS.this_oRelatorio.this_cCodigo    = ""
            THIS.this_oRelatorio.this_nOrdem     = 1
            THIS.this_oRelatorio.this_nPercent   = 0
        ENDIF

        *-- Resetar campos do form (so apos ConfigurarCamposFiltro ter sido chamado)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
                loc_oPagina.txt_4c_DtInicial.Value = DATE()
                loc_oPagina.txt_4c_DtFinal.Value   = DATE()
                loc_oPagina.txt_4c_Grupo.Value     = ""
                loc_oPagina.txt_4c_DGrupo.Value    = ""
                loc_oPagina.txt_4c_Conta.Value     = ""
                loc_oPagina.txt_4c_DConta.Value    = ""
                loc_oPagina.txt_4c_Envelope.Value  = 0
                loc_oPagina.txt_4c_Codigo.Value    = ""
                loc_oPagina.opt_4c_Ordem.Value     = 1
                loc_oPagina.chk_4c_Percent.Value   = 0
                *-- Estado inicial: DGrupo editavel, Conta/DConta desabilitados
                loc_oPagina.txt_4c_DGrupo.Enabled = .T.
                loc_oPagina.txt_4c_Conta.Enabled  = .F.
                loc_oPagina.txt_4c_DConta.Enabled = .F.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Valida filtros e exibe relatorio em preview
    *   Original: PROCEDURE visualizacao (Report Form ... Preview NoConsole)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.ValidarFiltros()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Valida filtros e imprime com dialogo de impressora
    *   Original: PROCEDURE impressao (Report Form ... To Printer Prompt NoConsole)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.ValidarFiltros()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Envia direto para impressora padrao (sem dialogo)
    *   Original: PROCEDURE documento (Report Form ... to Print NoConsole)
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.ValidarFiltros()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.Documento()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario (equivalente a btnReport.Sair)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT: "novo relatorio" reseta todos os filtros
    *
    *   Forms frmrelatorio NAO tem ciclo CRUD (Incluir/Alterar/Excluir) porque
    *   nao manipulam registros - apenas consultam e exibem dados. A semantica
    *   "Incluir" mapeia para "iniciar nova consulta", limpando filtros para
    *   permitir nova selecao de criterios.
    *
    *   Reset completo: datas voltam para DATE() (hoje), codigos vazios,
    *   OptionGroup volta para opcao 1, CheckBox de percentual desmarcado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_DtInicial", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT: recalcula estado dos campos de filtro
    *
    *   Forms frmrelatorio NAO tem operacao "Alterar registro" (sem CRUD).
    *   A semantica mais proxima eh "ajustar filtros" - refaz as regras de
    *   habilitacao condicional dos campos (DGrupo ativo quando Grupo vazio,
    *   Conta ativo quando Grupo set, DConta ativo quando Conta vazio).
    *
    *   Util quando o usuario manipula filtros e quer reaplicar regras de
    *   dependencia entre campos sem perder valores ja digitados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT: limpa filtros e foca data inicial
    *
    *   Forms frmrelatorio NAO tem operacao "Excluir registro" (sem CRUD).
    *   A semantica mais proxima eh "descartar criterios atuais" - efetua o
    *   mesmo reset de LimparCampos() mas direciona o foco para o primeiro
    *   campo, sinalizando ao usuario que pode comecar a montar uma nova
    *   selecao do zero.
    *
    *   Diferenca em relacao a BtnIncluirClick: ambos resetam, mas Incluir
    *   sugere "preparar nova consulta" enquanto Excluir sugere "descartar a
    *   consulta atual". Funcionalmente identicos no contexto de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_DtInicial", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO ao fechar o formulario
    *   IMPORTANTE: BO eh Custom, NAO chamar .Release() - apenas atribuir .NULL.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        IF USED("cursor_4c_SigCdGcr")
            USE IN cursor_4c_SigCdGcr
        ENDIF
        IF USED("cursor_4c_SigCdCli")
            USE IN cursor_4c_SigCdCli
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposFiltro - Adiciona campos de filtro ao PageFrame Page1
    *   Controles EXATOS do original SIGREAUP.SCX
    *   Posicoes: page_top = form_top - PageFrame.Top(85)
    *   Estados iniciais: DGrupo habilitado, Conta/DConta desabilitados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_oPagina

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Label Periodo (form top=111 -> page top=26)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 26
            .Left      = 199
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data Inicial (form top=108 -> page top=23)
        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Width         = 80
            .Left          = 249
            .Top           = 23
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- Separador "a" entre datas (form top=111 -> page top=26)
        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .Top       = 26
            .Left      = 334
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data Final (form top=108 -> page top=23)
        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Width         = 80
            .Left          = 348
            .Top           = 23
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- Label Grupo (form top=136 -> page top=51)
        loc_oPagina.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPagina.lbl_4c_LblGrupo
            .AutoSize  = .T.
            .Caption   = "Grupo :"
            .Top       = 51
            .Left      = 206
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Grupo (form top=133 -> page top=48) - lookup SigCdGcr.Codigos
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Height        = 23
            .Width         = 80
            .Left          = 249
            .Top           = 48
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .MaxLength     = 10
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Descricao do Grupo (form top=133 -> page top=48)
        *-- When original: habilitado so quando codigo Grupo VAZIO (busca alternativa)
        loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Height        = 23
            .Width         = 150
            .Left          = 330
            .Top           = 48
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .MaxLength     = 20
            .Value         = ""
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label Conta (form top=160 -> page top=75)
        loc_oPagina.AddObject("lbl_4c_LblConta", "Label")
        WITH loc_oPagina.lbl_4c_LblConta
            .AutoSize  = .T.
            .Caption   = "Conta :"
            .Top       = 75
            .Left      = 206
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo da Conta (form top=157 -> page top=72)
        *-- When original: habilitado so quando Grupo preenchido
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Width         = 80
            .Left          = 249
            .Top           = 72
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Descricao da Conta (form top=157 -> page top=72)
        *-- When original: habilitado quando Grupo set E Conta vazio
        loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPagina.txt_4c_DConta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Width         = 290
            .Left          = 330
            .Top           = 72
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label O.S. / Envelope (form top=183 -> page top=98)
        loc_oPagina.AddObject("lbl_4c_OS", "Label")
        WITH loc_oPagina.lbl_4c_OS
            .AutoSize  = .T.
            .Caption   = "O.S. :"
            .Top       = 98
            .Left      = 213
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Numero O.S. / Envelope (form top=180 -> page top=95) - numerico alinhado direita
        loc_oPagina.AddObject("txt_4c_Envelope", "TextBox")
        WITH loc_oPagina.txt_4c_Envelope
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Value         = 0
            .Format        = "K"
            .InputMask     = ""
            .Height        = 23
            .Width         = 80
            .Left          = 249
            .Top           = 95
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label Codigo NCF (form top=207 -> page top=122)
        loc_oPagina.AddObject("lbl_4c_LblCodigo", "Label")
        WITH loc_oPagina.lbl_4c_LblCodigo
            .AutoSize  = .T.
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 122
            .Left      = 202
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo NCF (form top=204 -> page top=119) - lookup SigCdNcf.Cods
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Format        = "K"
            .Height        = 23
            .Width         = 80
            .Left          = 249
            .Top           = 119
            .MaxLength     = 10
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Em Percentual (%) (form top=209 -> page top=124)
        loc_oPagina.AddObject("chk_4c_Percent", "CheckBox")
        WITH loc_oPagina.chk_4c_Percent
            .Top       = 124
            .Left      = 455
            .Height    = 15
            .Width     = 108
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Em Percentual (%)"
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Label Quebra (form top=234 -> page top=149)
        loc_oPagina.AddObject("lbl_4c_Quebra", "Label")
        WITH loc_oPagina.lbl_4c_Quebra
            .Caption   = "Quebra :"
            .Top       = 149
            .Left      = 199
            .Width     = 45
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Ordem de Quebra (form top=229 -> page top=144)
        *-- Option1="Grupo/conta" Option2="Tipo de Autorizacao"
        loc_oPagina.AddObject("opt_4c_Ordem", "OptionGroup")
        WITH loc_oPagina.opt_4c_Ordem
            .AutoSize    = .T.
            .ButtonCount = 2
            .BorderStyle = 0
            .Height      = 25
            .Width       = 224
            .Left        = 245
            .Top         = 144
            .BackStyle   = 0
            .ForeColor   = RGB(90, 90, 90)
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Ordem.Buttons(1)
            .Caption  = "Grupo/conta"
            .BackStyle = 0
            .Height   = 15
            .Left     = 5
            .Style    = 0
            .Top      = 5
            .Width    = 78
            .AutoSize = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Ordem.Buttons(2)
            .Caption  = "Tipo de Autoriza" + CHR(231) + CHR(227) + "o"
            .BackStyle = 0
            .Height   = 15
            .Left     = 101
            .Style    = 0
            .Top      = 5
            .Width    = 113
            .AutoSize = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos campos do form para o BO
    *   Chamado ANTES de ValidarFiltros/Visualizar/Imprimir/Documento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina

        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_dDtInicial = loc_oPagina.txt_4c_DtInicial.Value
            .this_dDtFinal   = loc_oPagina.txt_4c_DtFinal.Value
            .this_cGrupo     = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            .this_cDGrupo    = ALLTRIM(loc_oPagina.txt_4c_DGrupo.Value)
            .this_cConta     = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            .this_cDConta    = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
            .this_nEnvelope  = loc_oPagina.txt_4c_Envelope.Value
            .this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
            .this_nOrdem     = loc_oPagina.opt_4c_Ordem.Value
            .this_nPercent   = loc_oPagina.chk_4c_Percent.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Atualiza Enabled dos campos conforme regras do original:
    *   DGrupo: habilitado quando Grupo vazio (busca alternativa por descricao)
    *   Conta:  habilitado quando Grupo preenchido
    *   DConta: habilitado quando Grupo preenchido E Conta vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPagina, loc_lGrupoSet, loc_lContaSet

        loc_oPagina  = THIS.pgf_4c_Paginas.Page1
        loc_lGrupoSet = !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
        loc_lContaSet = !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))

        loc_oPagina.txt_4c_DGrupo.Enabled = !loc_lGrupoSet
        loc_oPagina.txt_4c_Conta.Enabled  = loc_lGrupoSet
        loc_oPagina.txt_4c_DConta.Enabled = loc_lGrupoSet AND !loc_lContaSet
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupo - KeyPress do campo codigo Grupo: F4/F5=busca, ENTER/TAB=valida
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaGrupo()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarGrupo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDGrupo - KeyPress do campo descricao Grupo: F4/F5=busca, ENTER/TAB=valida
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaDGrupo()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDGrupo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaConta - KeyPress do campo codigo Conta: F4/F5=busca, ENTER/TAB=valida
    *--------------------------------------------------------------------------
    PROCEDURE TeclaConta(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaConta()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarConta()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDConta - KeyPress do campo descricao Conta: F4/F5=busca, ENTER/TAB=valida
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDConta(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaDConta()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDConta()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCodigoNCF - KeyPress do campo Codigo NCF: F4/F5=busca, ENTER/TAB=valida
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCodigoNCF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaNCF()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCodigoNCF()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida codigo digitado contra SigCdGcr.Codigos
    *   Se vazio: limpa codigo+descricao+Conta/DConta, reset estados
    *   Se nao encontrado: abre busca interativa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarGrupo()
        LOCAL loc_oPagina, loc_cValor

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(UPPER(loc_oPagina.txt_4c_Grupo.Value))

        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Grupo.Value  = ""
            loc_oPagina.txt_4c_DGrupo.Value = ""
            loc_oPagina.txt_4c_Conta.Value  = ""
            loc_oPagina.txt_4c_DConta.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF

        IF USED("cursor_4c_SigCdGcr") AND ;
           SEEK(loc_cValor, "cursor_4c_SigCdGcr", "TCodigos")
            SELECT cursor_4c_SigCdGcr
            loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_SigCdGcr.Codigos)
            loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_SigCdGcr.Descrs)
        ELSE
            THIS.AbrirBuscaGrupo()
            RETURN
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDGrupo - Valida descricao digitada contra SigCdGcr.Descrs
    *   Se nao encontrado: abre busca por descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDGrupo()
        LOCAL loc_oPagina, loc_cValor

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(UPPER(loc_oPagina.txt_4c_DGrupo.Value))

        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Grupo.Value  = ""
            loc_oPagina.txt_4c_DGrupo.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF

        IF USED("cursor_4c_SigCdGcr") AND ;
           SEEK(loc_cValor, "cursor_4c_SigCdGcr", "TDescrs")
            SELECT cursor_4c_SigCdGcr
            loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_SigCdGcr.Codigos)
            loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_SigCdGcr.Descrs)
        ELSE
            THIS.AbrirBuscaDGrupo()
            RETURN
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida codigo digitado contra SigCdCli.IClis
    *   Conta so disponivel quando Grupo preenchido (When do original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarConta()
        LOCAL loc_oPagina, loc_cValor

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(UPPER(loc_oPagina.txt_4c_Conta.Value))

        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Conta.Value  = ""
            loc_oPagina.txt_4c_DConta.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF

        IF USED("cursor_4c_SigCdCli") AND ;
           SEEK(loc_cValor, "cursor_4c_SigCdCli", "TIClis")
            SELECT cursor_4c_SigCdCli
            loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_SigCdCli.IClis)
            loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_SigCdCli.RClis)
        ELSE
            THIS.AbrirBuscaConta()
            RETURN
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDConta - Valida descricao digitada contra SigCdCli.RClis
    *   DConta so disponivel quando Grupo set E Conta vazio (When do original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDConta()
        LOCAL loc_oPagina, loc_cValor

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(UPPER(loc_oPagina.txt_4c_DConta.Value))

        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Conta.Value  = ""
            loc_oPagina.txt_4c_DConta.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF

        IF USED("cursor_4c_SigCdCli") AND ;
           SEEK(loc_cValor, "cursor_4c_SigCdCli", "TRClis")
            SELECT cursor_4c_SigCdCli
            loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_SigCdCli.IClis)
            loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_SigCdCli.RClis)
        ELSE
            THIS.AbrirBuscaDConta()
            RETURN
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoNCF - Valida codigo digitado contra SigCdNcf.Cods
    *   Filtra por empresa ou espaco (empresa generica), como no original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCodigoNCF()
        LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)

        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Codigo.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT Cods, Descs FROM SigCdNcf " + ;
                   "WHERE Cods = " + EscaparSQL(loc_cValor) + ;
                   " AND (Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                   " OR Emps = '  ')"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NcfVal")

        IF loc_nResult > 0 AND !EOF("cursor_4c_NcfVal")
            SELECT cursor_4c_NcfVal
            loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_NcfVal.Cods)
            IF USED("cursor_4c_NcfVal")
                USE IN cursor_4c_NcfVal
            ENDIF
        ELSE
            IF USED("cursor_4c_NcfVal")
                USE IN cursor_4c_NcfVal
            ENDIF
            THIS.AbrirBuscaNCF()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - FormBuscaAuxiliar para SigCdGcr por codigo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oPagina, loc_cValor, loc_oForm

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_GcbBusca", "Codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupos")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_GcbBusca
            IF !EOF("cursor_4c_GcbBusca")
                loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbBusca.Codigos)
                loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbBusca.Descrs)
            ENDIF
        ELSE
            loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_GcbBusca")
                    SELECT cursor_4c_GcbBusca
                    IF !EOF("cursor_4c_GcbBusca")
                        loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbBusca.Codigos)
                        loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbBusca.Descrs)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_GcbBusca")
            USE IN cursor_4c_GcbBusca
        ENDIF
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Release()
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDGrupo - FormBuscaAuxiliar para SigCdGcr por descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaDGrupo()
        LOCAL loc_oPagina, loc_cValor, loc_oForm

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DGrupo.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_GcbDescBusca", "Descrs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupos")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_GcbDescBusca
            IF !EOF("cursor_4c_GcbDescBusca")
                loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbDescBusca.Codigos)
                loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbDescBusca.Descrs)
            ENDIF
        ELSE
            loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_GcbDescBusca")
                    SELECT cursor_4c_GcbDescBusca
                    IF !EOF("cursor_4c_GcbDescBusca")
                        loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbDescBusca.Codigos)
                        loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbDescBusca.Descrs)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_GcbDescBusca")
            USE IN cursor_4c_GcbDescBusca
        ENDIF
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Release()
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaConta - FormBuscaAuxiliar para SigCdCli por codigo IClis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaConta()
        LOCAL loc_oPagina, loc_cValor, loc_oForm

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_CliBusca", "IClis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Contas")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_CliBusca
            IF !EOF("cursor_4c_CliBusca")
                loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliBusca.IClis)
                loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliBusca.RClis)
            ENDIF
        ELSE
            loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_CliBusca")
                    SELECT cursor_4c_CliBusca
                    IF !EOF("cursor_4c_CliBusca")
                        loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliBusca.IClis)
                        loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliBusca.RClis)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_CliBusca")
            USE IN cursor_4c_CliBusca
        ENDIF
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Release()
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDConta - FormBuscaAuxiliar para SigCdCli por descricao RClis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaDConta()
        LOCAL loc_oPagina, loc_cValor, loc_oForm

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_CliDescBusca", "RClis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Contas")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_CliDescBusca
            IF !EOF("cursor_4c_CliDescBusca")
                loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDescBusca.IClis)
                loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliDescBusca.RClis)
            ENDIF
        ELSE
            loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_CliDescBusca")
                    SELECT cursor_4c_CliDescBusca
                    IF !EOF("cursor_4c_CliDescBusca")
                        loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDescBusca.IClis)
                        loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliDescBusca.RClis)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_CliDescBusca")
            USE IN cursor_4c_CliDescBusca
        ENDIF
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Release()
        ENDIF

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Registra BINDEVENTs de lookup nos campos de filtro
    *   Em forms REPORT (layout FLAT), nao existe Page2 separada para "Dados".
    *   Esta nomenclatura segue o padrao multi-fase do pipeline:
    *     Fase 4 (ConfigurarCamposFiltro) = cria controles visuais na Page1
    *     Fase 5 (ConfigurarPaginaDados)  = registra eventos de comportamento
    *   Eventos: F4/F5=lookup direto, ENTER/TAB=valida valor digitado e preenche
    *   descricao correspondente (busca bidirecional codigo <-> descricao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Grupo: F4/F5=busca por codigo (SigCdGcr.Codigos), ENTER/TAB=valida
        BINDEVENT(loc_oPagina.txt_4c_Grupo,  "KeyPress", THIS, "TeclaGrupo")

        *-- DGrupo: F4/F5=busca por descricao (SigCdGcr.Descrs), ENTER/TAB=valida
        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "KeyPress", THIS, "TeclaDGrupo")

        *-- Conta: F4/F5=busca IClis (SigCdCli), ENTER/TAB=valida (so quando Grupo set)
        BINDEVENT(loc_oPagina.txt_4c_Conta,  "KeyPress", THIS, "TeclaConta")

        *-- DConta: F4/F5=busca RClis (SigCdCli), ENTER/TAB=valida (Grupo set E Conta vazio)
        BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress", THIS, "TeclaDConta")

        *-- Codigo NCF: F4/F5=busca SigCdNcf.Cods, ENTER/TAB=valida codigo digitado
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "TeclaCodigoNCF")

        *-- DblClick: abre lookup diretamente ao dar duplo clique no campo
        BINDEVENT(loc_oPagina.txt_4c_Grupo,  "DblClick", THIS, "GrupoDblClick")
        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "DblClick", THIS, "DGrupoDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Conta,  "DblClick", THIS, "ContaDblClick")
        BINDEVENT(loc_oPagina.txt_4c_DConta, "DblClick", THIS, "DContaDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "DblClick", THIS, "CodigoNCFDblClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Equivalente a "lista" em forms REPORT
    *   Forms frmrelatorio NAO tem Page de lista CRUD - tem apenas uma Page
    *   unica de filtros. Este metodo delega para ConfigurarCamposFiltro()
    *   que adiciona os campos de filtro a Page1.
    *
    *   Mantido para uniformidade com a interface padrao de FormBase, que
    *   espera este metodo nos formularios. Em REPORT, "lista" = "filtros".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Em REPORT, a unica "pagina" eh a de filtros (Page1)
        *-- Garante que os campos de filtro foram criados na Page1
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_DtInicial", 5)
                THIS.ConfigurarCamposFiltro()
                THIS.ConfigurarPaginaDados()
            ENDIF
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursoresLookup - Carrega cursores auxiliares para validacao por SEEK
    *   Replica logica do legado: carrega SigCdGcr e SigCdCli completos
    *   com indices para SEEK por codigo (TCodigos/TIClis) e descricao (TDescrs/TRClis)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCursoresLookup()
        LOCAL loc_cSQL

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        IF USED("cursor_4c_SigCdGcr")
            USE IN cursor_4c_SigCdGcr
        ENDIF
        loc_cSQL = "SELECT Codigos, Descrs, GerBals FROM SigCdGcr"
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdGcr") > 0
            SELECT cursor_4c_SigCdGcr
            INDEX ON UPPER(ALLTRIM(Codigos)) TAG TCodigos CANDIDATE
            INDEX ON UPPER(ALLTRIM(Descrs))  TAG TDescrs
            GO TOP
        ENDIF

        IF USED("cursor_4c_SigCdCli")
            USE IN cursor_4c_SigCdCli
        ENDIF
        loc_cSQL = "SELECT IClis, RClis, Inativas FROM SigCdCli"
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdCli") > 0
            SELECT cursor_4c_SigCdCli
            INDEX ON UPPER(ALLTRIM(IClis)) TAG TIClis CANDIDATE
            INDEX ON UPPER(ALLTRIM(RClis)) TAG TRClis
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna pagina ativa do PageFrame
    *   par_nPagina: numero da pagina (1 = Filtros)
    *
    *   Forms REPORT tem apenas 1 pagina (Filtros), entao este metodo apenas
    *   garante que Page1 esta ativa. Mantido para uniformidade com a
    *   interface padrao de forms CRUD que possui esta navegacao.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1
            loc_nPagina = par_nPagina
        ELSE
            loc_nPagina = 1
        ENDIF

        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            *-- REPORT tem PageCount=1, sempre ativa Page1
            IF loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaNCF - FormBuscaAuxiliar para SigCdNcf por codigo Cods
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaNCF()
        LOCAL loc_oPagina, loc_cValor, loc_oForm

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdNcf", "cursor_4c_NcfBusca", "Cods", loc_cValor, ;
            "N" + CHR(227) + "o Conformidade")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_NcfBusca
            IF !EOF("cursor_4c_NcfBusca")
                loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_NcfBusca.Cods)
            ENDIF
        ELSE
            loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_NcfBusca")
                    SELECT cursor_4c_NcfBusca
                    IF !EOF("cursor_4c_NcfBusca")
                        loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_NcfBusca.Cods)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_NcfBusca")
            USE IN cursor_4c_NcfBusca
        ENDIF
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoDblClick - DblClick no campo codigo Grupo abre busca imediatamente
    *--------------------------------------------------------------------------
    PROCEDURE GrupoDblClick()
        THIS.AbrirBuscaGrupo()
    ENDPROC

    *--------------------------------------------------------------------------
    * DGrupoDblClick - DblClick no campo descricao Grupo abre busca imediatamente
    *--------------------------------------------------------------------------
    PROCEDURE DGrupoDblClick()
        THIS.AbrirBuscaDGrupo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaDblClick - DblClick no campo codigo Conta abre busca imediatamente
    *--------------------------------------------------------------------------
    PROCEDURE ContaDblClick()
        IF THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Enabled
            THIS.AbrirBuscaConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DContaDblClick - DblClick no campo descricao Conta abre busca imediatamente
    *--------------------------------------------------------------------------
    PROCEDURE DContaDblClick()
        IF THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Enabled
            THIS.AbrirBuscaDConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CodigoNCFDblClick - DblClick no campo Codigo NCF abre busca imediatamente
    *--------------------------------------------------------------------------
    PROCEDURE CodigoNCFDblClick()
        THIS.AbrirBuscaNCF()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: acionar visualizacao (busca = preview)
    *   Equivalente a "Buscar" em CRUD, mas em relatorio significa exibir
    *   preview dos dados conforme filtros preenchidos atualmente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (complementar a BtnSairClick)
    *   Mantido para compatibilidade com interface padrao do FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT: executar impressao direta (sem dialogo)
    *   Forms REPORT nao tem operacao "Salvar registro" (sem CRUD).
    *   A semantica mais proxima eh imprimir o relatorio diretamente
    *   na impressora padrao (equivalente ao botao "Documento").
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnDocumentoClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT: fechar/encerrar o formulario
    *   Forms REPORT nao tem operacao "Cancelar edicao" (sem CRUD).
    *   A semantica eh encerrar a sessao de consulta atual.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de compatibilidade para FormParaRelatorio()
    *   Forms CRUD chamam FormParaBO() ao salvar. Forms REPORT usam
    *   FormParaRelatorio(). Este metodo garante que chamadas genericas
    *   de FormBase que invoquem FormParaBO() funcionem corretamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Recarrega campos do form a partir dos valores do BO
    *   Em REPORT nao ha ciclo de edicao de registro, mas este metodo
    *   permite restaurar os filtros do form a partir do estado atual do BO
    *   (util apos PrepararDados ou ValidarFiltros alterar propriedades do BO).
    *   Todos os campos de filtro sao recarregados do BO correspondente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina

        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF !PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
            RETURN
        ENDIF

        WITH THIS.this_oRelatorio
            loc_oPagina.txt_4c_DtInicial.Value  = .this_dDtInicial
            loc_oPagina.txt_4c_DtFinal.Value    = .this_dDtFinal
            loc_oPagina.txt_4c_Grupo.Value      = .this_cGrupo
            loc_oPagina.txt_4c_DGrupo.Value     = .this_cDGrupo
            loc_oPagina.txt_4c_Conta.Value      = .this_cConta
            loc_oPagina.txt_4c_DConta.Value     = .this_cDConta
            loc_oPagina.txt_4c_Envelope.Value   = .this_nEnvelope
            loc_oPagina.txt_4c_Codigo.Value     = .this_cCodigo
            loc_oPagina.opt_4c_Ordem.Value      = .this_nOrdem
            loc_oPagina.chk_4c_Percent.Value    = .this_nPercent
        ENDWITH

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Atualiza estado de habilitacao dos campos de filtro
    *   Em REPORT, habilita/desabilita os campos conforme dependencias
    *   definidas no original: DGrupo ativo quando Grupo vazio, Conta ativo
    *   quando Grupo preenchido, DConta ativo quando Grupo set E Conta vazio.
    *   Delega para AtualizarEstadoCampos() que implementa as regras do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT nao ha lista/grid de registros para carregar
    *   Forms CRUD carregam grid de registros neste metodo. Forms REPORT
    *   nao tem grid de lista - exibem apenas filtros na Page1.
    *   Retorna .T. (sucesso) para compatibilidade com chamadas genericas
    *   do FormBase que verificam o retorno deste metodo.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT os botoes ficam sempre habilitados
    *   Forms CRUD alternam habilitacao dos botoes conforme o modo atual
    *   (LISTA/DADOS/INCLUIR/ALTERAR/VISUALIZAR). Forms REPORT nao tem
    *   modos CRUD - os 4 botoes do CommandGroup ficam sempre ativos apos
    *   o InicializarForm(). Metodo mantido para uniformidade de interface.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREAUPBO.prg):
*==============================================================================
* SIGREAUPBO.PRG
* Business Object - Relatorio de Tipos de Autorizacoes de Producao
* Herda de RelatorioBase
*
* Filtros: Periodo, Grupo, Conta, Envelope, Codigo NCF, Ordem, Percentual
* Tabela principal: SigOpInc (joins: SigCdNcf, SigCdCli)
* Reports: SigReAu1 (listagem), SigReAu2 (percentual)
*==============================================================================

DEFINE CLASS SIGREAUPBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigOpInc"
    this_cCampoChave    = ""
    this_cMensagemErro  = ""

    *-- Filtros de periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro de grupo (codigo + descricao para lookup bidirecional)
    this_cGrupo         = ""
    this_cDGrupo        = ""

    *-- Filtro de conta (codigo + descricao para lookup bidirecional)
    this_cConta         = ""
    this_cDConta        = ""

    *-- Filtro de envelope (numerico)
    this_nEnvelope      = 0

    *-- Filtro de codigo NCF
    this_cCodigo        = ""

    *-- Opcao de ordem: 1=Grupo/Conta, 2=Tipo de Autorizacao
    this_nOrdem         = 1

    *-- Exibir em percentual: 0=nao, 1=sim
    this_nPercent       = 0

    *-- Nome do cursor principal de dados gerado por PrepararDados
    this_cCursorDados   = "cursor_4c_SigOpInc"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros obrigatorios antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data Inicial inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data Final inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagemErro = "A Data Final n" + CHR(227) + "o pode ser menor que a Inicial!"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores para o relatorio
    * Replica logica do procedimento 'processamento' do legado:
    *   1. Carrega nome da empresa para cabecalho
    *   2. Cria cursor_4c_Cabecalho com titulo/subtitulo
    *   3. Executa query principal em SigOpInc (joins SigCdNcf, SigCdCli)
    *   4. Transforma cursor: percentual (TmpInc) ou listagem (Selecao+index)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cEmp, loc_cCab, loc_cSub
        LOCAL loc_nQbr, loc_nWQtd

        loc_lSucesso  = .F.
        loc_nWQtd     = 0
        loc_nQbr      = THIS.this_nOrdem
        THIS.this_cMensagemErro = ""

        TRY
            *-- 1. Nome da empresa para cabecalho (via go_4c_Sistema)
            loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            *-- 2. Monta cabecalho e subtitulo do relatorio
            loc_cCab = "Relat" + CHR(243) + "rio de Tipo de Autoriza" + ;
                       CHR(231) + CHR(245) + "es"
            loc_cSub = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                       " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)
            IF !EMPTY(THIS.this_cGrupo)
                loc_cSub = loc_cSub + " - Grupo : " + ALLTRIM(THIS.this_cGrupo)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cSub = loc_cSub + " - Contas : " + ALLTRIM(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_nEnvelope)
                loc_cSub = loc_cSub + " - Envelope : " + ALLTRIM(STR(THIS.this_nEnvelope))
            ENDIF
            IF !EMPTY(THIS.this_cCodigo)
                loc_cSub = loc_cSub + " - C" + CHR(243) + "digo : " + ALLTRIM(THIS.this_cCodigo)
            ENDIF

            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho ;
                (Titulo C(100), SubTitulo C(100), NomeEmpresa C(100))
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp)
            SET NULL OFF

            *-- 3. Monta clausula WHERE da query principal
            loc_cWhere = "a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                         " AND a.Datas < DATEADD(day, 1, " + ;
                         FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                         " AND a.Cods = b.Cods" + ;
                         " AND (b.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                         " OR b.Emps = '  ')" + ;
                         " AND a.Contas = d.IClis" + ;
                         " AND a.Cpros = ' '"

            IF !EMPTY(THIS.this_cGrupo)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Grupos = " + EscaparSQL(THIS.this_cGrupo)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Contas = " + EscaparSQL(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_cCodigo)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Cods = " + EscaparSQL(THIS.this_cCodigo)
            ENDIF
            IF !EMPTY(THIS.this_nEnvelope)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Nenvs = " + TRANSFORM(THIS.this_nEnvelope)
            ENDIF

            *-- 4. Query principal: SigOpInc + SigCdNcf + SigCdCli
            loc_cSQL = "SELECT a.*, d.RClis, b.Descs AS DescTabs, b.fixos " + ;
                       "FROM SigOpInc a, SigCdNcf b, SigCdCli d " + ;
                       "WHERE " + loc_cWhere + " " + ;
                       "ORDER BY a.Grupos, a.Contas, a.Datas, a.Nenvs, a.Cods"

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de autoriza" + ;
                    CHR(231) + CHR(245) + "es de produ" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF

            *-- 5. Transforma cursor conforme modo: percentual ou listagem
            IF THIS.this_nPercent = 1

                SELECT (THIS.this_cCursorDados)
                SUM 1 TO loc_nWQtd

                IF loc_nWQtd > 0
                    SELECT Cods, ;
                           IIF(fixos <> 2, DescTabs, Descs) AS DescTabs, ;
                           IIF(loc_nQbr = 1, Grupos, SPACE(10)) AS Grupos, ;
                           IIF(loc_nQbr = 1, Contas, SPACE(10)) AS Contas, ;
                           SUM(1) AS Qtds, ;
                           SUM(1 / loc_nWQtd * 100.00) AS Percs ;
                    FROM (THIS.this_cCursorDados) ;
                    INTO CURSOR cursor_4c_TmpInc ;
                    GROUP BY 1, 2, 3, 4 ;
                    ORDER BY 1, 2, 3, 4
                ELSE
                    SET NULL ON
                    CREATE CURSOR cursor_4c_TmpInc ;
                        (Cods C(10), DescTabs C(50), Grupos C(10), ;
                         Contas C(10), Qtds N(10,0), Percs N(10,2))
                    SET NULL OFF
                ENDIF

            ELSE

                SELECT IIF(loc_nQbr = 1, ;
                           Grupos + "/" + Contas + "-" + RClis, ;
                           Cods + "-" + IIF(fixos <> 2, DescTabs, Descs)) AS Quebra1, ;
                       IIF(loc_nQbr = 1, ;
                           Cods + "-" + DescTabs, ;
                           Grupos + "/" + Contas + "-" + RClis) AS Quebra2, ;
                       IIF(fixos <> 2, DescTabs, Descs) AS DescTabs, * ;
                FROM (THIS.this_cCursorDados) ;
                INTO CURSOR cursor_4c_Selecao

                SELECT cursor_4c_Selecao
                INDEX ON Quebra1 + Quebra2 + DTOS(Datas) + STR(Nenvs, 10) TAG Ordem
                GO TOP

            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
            THIS.RegistrarAuditoria("VISUALIZAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.RegistrarAuditoria("IMPRIMIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Prepara dados e envia direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) TO PRINT NOCONSOLE
            THIS.RegistrarAuditoria("DOCUMENTO")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    * Compoe identificador unico com empresa + filtros principais + periodo
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa, loc_cTipo

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        loc_cTipo = IIF(THIS.this_nPercent = 1, "PERCENT", "LISTAGEM") + ;
                    "/ORD" + ALLTRIM(STR(THIS.this_nOrdem))

        loc_cChave = loc_cEmpresa + "/" + loc_cTipo + "/" + ;
                     DTOC(THIS.this_dDtInicial) + "/" + ;
                     DTOC(THIS.this_dDtFinal)

        IF !EMPTY(THIS.this_cGrupo)
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF

        IF !EMPTY(THIS.this_cConta)
            loc_cChave = loc_cChave + "/C:" + ALLTRIM(THIS.this_cConta)
        ENDIF

        IF !EMPTY(THIS.this_cCodigo)
            loc_cChave = loc_cChave + "/N:" + ALLTRIM(THIS.this_cCodigo)
        ENDIF

        IF THIS.this_nEnvelope > 0
            loc_cChave = loc_cChave + "/E:" + ALLTRIM(STR(THIS.this_nEnvelope))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    * par_cOperacao: VISUALIZAR, IMPRIMIR, DOCUMENTO, EXPORTAR
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAUP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter o contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida via SQLEXEC sobre o
    *     periodo filtrado (cursor_4c_Cabecalho, cursor_4c_TmpInc, cursor_4c_Selecao)
    *   - Imprimir() / Visualizar() / Documento() consomem esses cursores
    *     atraves dos .FRX SigReAu1 (listagem) / SigReAu2 (percentual)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores auxiliares abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigOpInc")
            USE IN cursor_4c_SigOpInc
        ENDIF
        IF USED("cursor_4c_TmpInc")
            USE IN cursor_4c_TmpInc
        ENDIF
        IF USED("cursor_4c_Selecao")
            USE IN cursor_4c_Selecao
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

