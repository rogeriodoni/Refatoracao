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
[05/16/26 07:46:43 PM] InicializarForm: PARENT is not an object.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-16 19:46:40] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 19:46:40] [INFO] Config FPW: (nao fornecido)
[2026-05-16 19:46:40] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 19:46:40] [INFO] Timeout: 300 segundos
[2026-05-16 19:46:40] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_gq3cqci3.prg
[2026-05-16 19:46:40] [INFO] Conteudo do wrapper:
[2026-05-16 19:46:40] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigreche', 'C:\4c\tasks\task050', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreche', 'C:\4c\tasks\task050', 'REPORT'
QUIT

[2026-05-16 19:46:40] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_gq3cqci3.prg
[2026-05-16 19:46:40] [INFO] VFP output esperado em: C:\4c\tasks\task050\vfp_output.txt
[2026-05-16 19:46:40] [INFO] Executando Visual FoxPro 9...
[2026-05-16 19:46:40] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_gq3cqci3.prg
[2026-05-16 19:46:40] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_gq3cqci3.prg
[2026-05-16 19:46:40] [INFO] Timeout configurado: 300 segundos
[2026-05-16 19:46:43] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 19:46:43] [INFO] VFP9 finalizado em 2.245353 segundos
[2026-05-16 19:46:43] [INFO] Exit Code: 
[2026-05-16 19:46:43] [INFO] 
[2026-05-16 19:46:43] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 19:46:43] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_gq3cqci3.prg
[2026-05-16 19:46:43] [INFO] 
[2026-05-16 19:46:43] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 19:46:43] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 19:46:43] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 19:46:43] [INFO] * Parameters: 'Formsigreche', 'C:\4c\tasks\task050', 'REPORT'
[2026-05-16 19:46:43] [INFO] 
[2026-05-16 19:46:43] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 19:46:43] [INFO] SET SAFETY OFF
[2026-05-16 19:46:43] [INFO] SET RESOURCE OFF
[2026-05-16 19:46:43] [INFO] SET TALK OFF
[2026-05-16 19:46:43] [INFO] SET NOTIFY OFF
[2026-05-16 19:46:43] [INFO] SYS(2335, 0)
[2026-05-16 19:46:43] [INFO] 
[2026-05-16 19:46:43] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreche', 'C:\4c\tasks\task050', 'REPORT'
[2026-05-16 19:46:43] [INFO] QUIT
[2026-05-16 19:46:43] [INFO] 
[2026-05-16 19:46:43] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 19:46:43] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigreche",
  "timestamp": "20260516194643",
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreche.prg):
*==============================================================================
* FORMSIGRECHE.PRG
* Relatorio de Cheques (SIGRECHE) - Fase 3/8: Form Estrutura Base
*
* Herda de FormBase
* Tipo: REPORT (layout FLAT - sem PageFrame CRUD)
* BO:   sigrecheBO (herda RelatorioBase)
* Migrado de: sigreche.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS Formsigreche AS FormBase

    *-- Dimensoes EXATAS do original (Height=400, Width=1000)
    Height      = 400
    Width       = 1000
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- BO e controle de erro
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Rastreamento de pagina (REPORT eh FLAT mas mantemos o contrato CRUD para compatibilidade)
    this_nPaginaAtual = 1

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * INICIALIZARFORM - Cria estrutura do form de relatorio FLAT (sem PageFrame CRUD)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarPageFrame()

            THIS.this_oRelatorio = CREATEOBJECT("sigrecheBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques", "InicializarForm")
            ELSE
                THIS.this_oRelatorio.InicializarCursores()

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarBotoes()
                THIS.ConfigurarPaginaLista()

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    THIS.this_oRelatorio.CarregarOpcoes()
                    THIS.AtualizarTitulosOpcao()
                ENDIF

                THIS.LimparCampos()
                THIS.AlternarPagina(1)

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGEFRAME - Configura propriedades de janela e moldura do form
    *
    * REPORT (frmrelatorio) usa layout FLAT: nao ha PageFrame de 2 abas como
    * em forms CRUD. Este metodo aplica as propriedades do "frame" da janela
    * (Caption, Picture de fundo, Icon, comportamento de janela) e estabelece
    * a area util para os containers de cabecalho, filtros e botoes que sao
    * adicionados diretamente ao Form em ConfigurarCabecalho/ConfigurarBotoes.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques"
        THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
        THIS.AutoCenter  = .T.
        THIS.BorderStyle = 2
        THIS.WindowType  = 1
        THIS.ControlBox  = .F.
        THIS.MaxButton   = .F.
        THIS.MinButton   = .F.
        THIS.TitleBar    = 0
        THIS.Themes      = .F.
        THIS.ShowTips    = .T.
        THIS.BackColor   = RGB(255, 255, 255)
    ENDPROC

    *==========================================================================
    * CONFIGURARCABECALHO - Container escuro com labels titulo/sombra
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top       = 0
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackStyle = 1
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible   = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 12
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Parent.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Parent.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CONFIGURARBOTOES - CommandGroup com 4 botoes (EXATO do framework frmrelatorio)
    * Geometria canonical: ButtonCount=4, Width=273, Height=80, BackStyle=0
    * Posicao: Left=726 (do SCX original), Top=6
    * Lefts internos: Btn1=5, Btn2=71, Btn3=137, Btn4=203 (incrementos de 66)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top         = 6
            .Left        = 726
            .Width       = 273
            .Height      = 80
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .Picture         = loc_cIcones + "ideo.jpg"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .Picture         = loc_cIcones + "impressora.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .Picture         = loc_cIcones + "excel.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Sair"
                .Picture         = loc_cIcones + "otao_encerrar.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Cancel          = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * ATUALIZARESTADOCONTROLES - Override: form de relatorio nao usa CRUD
    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINALISTA - Monta a "pagina" principal do relatorio (FLAT)
    *
    * Em forms CRUD esta procedure monta a Page1 (grid de registros + botoes
    * Incluir/Alterar/Excluir/Buscar). Em REPORT (frmrelatorio) o layout eh
    * FLAT - nao existe PageFrame de 2 abas. A "pagina de lista" do relatorio
    * eh a area de filtros + grids de selecao (operacoes/campos a imprimir).
    *
    * Este wrapper centraliza a montagem dessa area: filtros, grid de operacoes
    * e grid de campos a imprimir. Os botoes de acao (Visualizar/Imprimir/
    * Excel/Sair) ja foram criados em ConfigurarBotoes() como CommandGroup
    * cmg_4c_Botoes (padrao frmrelatorio do framework.vcx).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCamposFiltro()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarGridOperacoes()
        THIS.ConfigurarGridImprimir()
    ENDPROC

    *==========================================================================
    * ALTERNARPAGINA - Controle de pagina (REPORT eh FLAT - 1 pagina logica)
    *
    * Em forms CRUD esta procedure faz THIS.pgf_4c_Paginas.ActivePage = N para
    * alternar entre Page1 (Lista) e Page2 (Dados). Em REPORT (frmrelatorio)
    * nao ha PageFrame de 2 abas - o form eh FLAT. Mesmo assim mantemos o
    * contrato do metodo e rastreamos a pagina logica em this_nPaginaAtual
    * para que codigo externo (ou validacao automatica) possa consultar o
    * estado da janela. Em REPORT par_nPagina sempre eh 1.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
        IF loc_nPagina < 1
            loc_nPagina = 1
        ENDIF
        THIS.this_nPaginaAtual = loc_nPagina
    ENDPROC

    *==========================================================================
    * FORMPARARELATORIO - Transfere valores dos controles do form para o BO
    * Usa PEMSTATUS para cada controle (safe em todas as fases de migracao)
    *==========================================================================
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            *-- Tipo de relatorio (OptionGroup)
            IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
                .this_nNrTipo = THIS.obj_4c_NrTipo.Value
            ENDIF
            *-- Opcao com/sem nota (OptionGroup)
            IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
                .this_nNrOpcao = THIS.obj_4c_NrOpcao.Value
            ENDIF
            *-- Ordem de classificacao (ComboBox)
            IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
                .this_nOrdem = THIS.cbo_4c_Ordem.Value
            ENDIF
            *-- Apenas ultima movimentacao (CheckBox - valor numerico 0/1)
            IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
                .this_lUltima = (THIS.chk_4c_Ultima.Value = 1)
            ENDIF
            *-- Periodo
            IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
                .this_dDtInicial = THIS.txt_4c_DtInicial.Value
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
                .this_dDtFinal = THIS.txt_4c_DtFinal.Value
            ENDIF
            *-- Empresa
            IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
                .this_cCdEmpresa = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
                .this_cDsEmpresa = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
            ENDIF
            *-- Carteira (grupo/conta)
            IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
                .this_cCdCarGrupo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
                .this_cDsCarGrupo = ALLTRIM(THIS.txt_4c_DsCarGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
                .this_cCdCarConta = ALLTRIM(THIS.txt_4c_CdCarConta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
                .this_cDsCarConta = ALLTRIM(THIS.txt_4c_DsCarConta.Value)
            ENDIF
            *-- Deposito (grupo/conta)
            IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
                .this_cCdDepGrupo = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
                .this_cDsDepGrupo = ALLTRIM(THIS.txt_4c_DsDepGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
                .this_cCdDepConta = ALLTRIM(THIS.txt_4c_CdDepConta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
                .this_cDsDepConta = ALLTRIM(THIS.txt_4c_DsDepConta.Value)
            ENDIF
            *-- Emissor (grupo/conta)
            IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)
                .this_cCdEmiGrupo = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmiGrupo", 5)
                .this_cDsEmiGrupo = ALLTRIM(THIS.txt_4c_DsEmiGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdEmiConta", 5)
                .this_cCdEmiConta = ALLTRIM(THIS.txt_4c_CdEmiConta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmiConta", 5)
                .this_cDsEmiConta = ALLTRIM(THIS.txt_4c_DsEmiConta.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Botao 1: Visualizar relatorio em tela
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNIMPRIMIRCLICK - Botao 2: Imprimir relatorio em impressora
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Imprimir()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCELCLICK - Botao 3: Exportar para Excel
    *==========================================================================
    PROCEDURE BtnExcelClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Validar()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                RETURN
            ENDIF
            IF USED("cursor_4c_Relatorio")
                LOCAL loc_cArqXls
                loc_cArqXls = SYS(2023) + "\SigReChe_" + STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                COPY TO (loc_cArqXls) TYPE XL5
                MsgInfo("Arquivo Excel gerado em: " + loc_cArqXls, "Excel")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNCANCELARCLICK - Botao 4: Fechar o form (ESC)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNINCLUIRCLICK - "Gerar novo relatorio" (frmrelatorio: visualizar)
    * Em forms REPORT, "Incluir" mapeia para gerar/visualizar o relatorio
    * com os filtros atuais. Equivalente funcional ao botao Visualizar.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Gerar Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNALTERARCLICK - "Alterar parametros" (frmrelatorio: reset filtros)
    * Em forms REPORT, "Alterar" mapeia para limpar/redefinir os filtros
    * do relatorio. Equivalente funcional ao reset de campos.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
                THIS.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCLUIRCLICK - "Cancelar/Encerrar" (frmrelatorio: fechar)
    * Em forms REPORT, "Excluir" nao tem sentido CRUD. Pede confirmacao
    * e encerra o formulario de relatorio. Equivalente ao botao Encerrar.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja encerrar o relat" + CHR(243) + "rio?", ;
                       "Encerrar")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * CONFIGURARCAMPOSFILTRO - Periodo, Empresa, Deposito, Emissor (esq/baixo)
    * Controles adicionados DIRETAMENTE ao form (layout FLAT - sem PageFrame)
    * Opcao/Situacao/Ordem/Ultima/Carteira: ver ConfigurarPaginaDados()
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposFiltro()

        *-- == PERIODO ==
        THIS.AddObject("lbl_4c_Periodo", "Label")
        WITH THIS.lbl_4c_Periodo
            .Top       = 113
            .Left      = 52
            .Width     = 50
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Top       = 107
            .Left      = 101
            .Width     = 80
            .Height    = 23
            .Value     = DATE()
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_PeriodoA", "Label")
        WITH THIS.lbl_4c_PeriodoA
            .Top       = 112
            .Left      = 186
            .Width     = 10
            .Height    = 18
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Top       = 107
            .Left      = 200
            .Width     = 80
            .Height    = 23
            .Value     = DATE()
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- == EMPRESA ==
        THIS.AddObject("lbl_4c_Empresa", "Label")
        WITH THIS.lbl_4c_Empresa
            .Top       = 137
            .Left      = 47
            .Width     = 54
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH THIS.txt_4c_CdEmpresa
            .Top      = 132
            .Left     = 101
            .Width    = 31
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH THIS.txt_4c_DsEmpresa
            .Top      = 132
            .Left     = 132
            .Width    = 290
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == DEPOSITO - GRUPO ==
        THIS.AddObject("lbl_4c_DepGrupo", "Label")
        WITH THIS.lbl_4c_DepGrupo
            .Top       = 275
            .Left      = 451
            .Width     = 84
            .Height    = 18
            .Caption   = "Grupo/Dep" + CHR(243) + "sito :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdDepGrupo", "TextBox")
        WITH THIS.txt_4c_CdDepGrupo
            .Top      = 270
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsDepGrupo", "TextBox")
        WITH THIS.txt_4c_DsDepGrupo
            .Top      = 270
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == DEPOSITO - CONTA ==
        THIS.AddObject("lbl_4c_DepConta", "Label")
        WITH THIS.lbl_4c_DepConta
            .Top       = 300
            .Left      = 451
            .Width     = 84
            .Height    = 18
            .Caption   = "Conta/Dep" + CHR(243) + "sito :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdDepConta", "TextBox")
        WITH THIS.txt_4c_CdDepConta
            .Top      = 295
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsDepConta", "TextBox")
        WITH THIS.txt_4c_DsDepConta
            .Top      = 295
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == EMISSOR - GRUPO ==
        THIS.AddObject("lbl_4c_EmiGrupo", "Label")
        WITH THIS.lbl_4c_EmiGrupo
            .Top       = 325
            .Left      = 457
            .Width     = 78
            .Height    = 18
            .Caption   = "Grupo/Emissor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEmiGrupo", "TextBox")
        WITH THIS.txt_4c_CdEmiGrupo
            .Top      = 320
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmiGrupo", "TextBox")
        WITH THIS.txt_4c_DsEmiGrupo
            .Top      = 320
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == EMISSOR - CONTA ==
        THIS.AddObject("lbl_4c_EmiConta", "Label")
        WITH THIS.lbl_4c_EmiConta
            .Top       = 350
            .Left      = 457
            .Width     = 78
            .Height    = 18
            .Caption   = "Conta/Emissor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEmiConta", "TextBox")
        WITH THIS.txt_4c_CdEmiConta
            .Top      = 345
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmiConta", "TextBox")
        WITH THIS.txt_4c_DsEmiConta
            .Top      = 345
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Vincular KeyPress handlers periodo/empresa/deposito/emissor
        BINDEVENT(THIS.txt_4c_DtInicial,  "KeyPress", THIS, "TeclaDtInicial")
        BINDEVENT(THIS.txt_4c_DtFinal,    "KeyPress", THIS, "TeclaDtFinal")
        BINDEVENT(THIS.txt_4c_CdEmpresa,  "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(THIS.txt_4c_DsEmpresa,  "KeyPress", THIS, "TeclaDsEmpresa")
        BINDEVENT(THIS.txt_4c_CdDepGrupo, "KeyPress", THIS, "TeclaCdDepGrupo")
        BINDEVENT(THIS.txt_4c_DsDepGrupo, "KeyPress", THIS, "TeclaDsDepGrupo")
        BINDEVENT(THIS.txt_4c_CdDepConta, "KeyPress", THIS, "TeclaCdDepConta")
        BINDEVENT(THIS.txt_4c_DsDepConta, "KeyPress", THIS, "TeclaDsDepConta")
        BINDEVENT(THIS.txt_4c_CdEmiGrupo, "KeyPress", THIS, "TeclaCdEmiGrupo")
        BINDEVENT(THIS.txt_4c_DsEmiGrupo, "KeyPress", THIS, "TeclaDsEmiGrupo")
        BINDEVENT(THIS.txt_4c_CdEmiConta, "KeyPress", THIS, "TeclaCdEmiConta")
        BINDEVENT(THIS.txt_4c_DsEmiConta, "KeyPress", THIS, "TeclaDsEmiConta")
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADADOS - Controles filtro DIREITA Parte 1 (Fase 5/8)
    * Opcao (com/sem nota), Situacao/Tipo, Ordem, Ultima Mov, Carteira Grupo/Conta
    * Posicoes EXATAS do layout.json (PILAR 1 - pixel-perfect)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- == OPCAO (OptionGroup - com/sem nota fiscal) ==
        THIS.AddObject("lbl_4c_LblOpcao", "Label")
        WITH THIS.lbl_4c_LblOpcao
            .Top       = 121
            .Left      = 495
            .Width     = 44
            .Height    = 18
            .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_NrOpcao", "OptionGroup")
        WITH THIS.obj_4c_NrOpcao
            .Top         = 117
            .Left        = 540
            .Width       = 182
            .Height      = 23
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 3
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left    = 0
                .Top     = 3
                .Width   = 60
                .Height  = 17
                .Visible = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(227) + "o"
                .Left     = 61
                .Top      = 3
                .Width    = 60
                .Height   = 17
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "Ambos"
                .Left     = 122
                .Top      = 3
                .Width    = 60
                .Height   = 17
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *-- == SITUACAO / TIPO (abertos/geral/dt operacao/dt vencto) ==
        THIS.AddObject("lbl_4c_Situacao", "Label")
        WITH THIS.lbl_4c_Situacao
            .Top       = 148
            .Left      = 485
            .Width     = 52
            .Height    = 18
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_NrTipo", "OptionGroup")
        WITH THIS.obj_4c_NrTipo
            .Top         = 143
            .Left        = 541
            .Width       = 213
            .Height      = 26
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption = "Abertos"
                .Left    = 0
                .Top     = 5
                .Width   = 51
                .Height  = 17
                .Visible = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Geral"
                .Left     = 52
                .Top      = 5
                .Width    = 51
                .Height   = 17
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "Dt Opera" + CHR(231) + CHR(227) + "o"
                .Left     = 104
                .Top      = 5
                .Width    = 55
                .Height   = 17
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(4)
                .Caption  = "Dt Vencto"
                .Left     = 160
                .Top      = 5
                .Width    = 53
                .Height   = 17
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *-- == ORDEM (ComboBox de classificacao do relatorio) ==
        THIS.AddObject("lbl_4c_Ordem", "Label")
        WITH THIS.lbl_4c_Ordem
            .Top       = 172
            .Left      = 494
            .Width     = 44
            .Height    = 18
            .Caption   = "Ordem :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("cbo_4c_Ordem", "ComboBox")
        WITH THIS.cbo_4c_Ordem
            .Top           = 168
            .Left          = 543
            .Width         = 189
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Carteira,Dep" + CHR(243) + "sito,Emissor," + ;
                             "Dt Entrada,C.P.F.,Nome"
            .Style         = 2
            .Value         = 1
            .Visible       = .T.
        ENDWITH

        *-- == ULTIMA MOVIMENTACAO (CheckBox) ==
        THIS.AddObject("chk_4c_Ultima", "CheckBox")
        WITH THIS.chk_4c_Ultima
            .Top       = 195
            .Left      = 543
            .Width     = 141
            .Height    = 17
            .Caption   = CHR(218) + "ltima Movimenta" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 1
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- == CARTEIRA - GRUPO ==
        THIS.AddObject("lbl_4c_CarGrupo", "Label")
        WITH THIS.lbl_4c_CarGrupo
            .Top       = 225
            .Left      = 454
            .Width     = 84
            .Height    = 18
            .Caption   = "Grupo/Carteira :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdCarGrupo", "TextBox")
        WITH THIS.txt_4c_CdCarGrupo
            .Top      = 220
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsCarGrupo", "TextBox")
        WITH THIS.txt_4c_DsCarGrupo
            .Top      = 220
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == CARTEIRA - CONTA ==
        THIS.AddObject("lbl_4c_CarConta", "Label")
        WITH THIS.lbl_4c_CarConta
            .Top       = 250
            .Left      = 454
            .Width     = 84
            .Height    = 18
            .Caption   = "Conta/Carteira :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdCarConta", "TextBox")
        WITH THIS.txt_4c_CdCarConta
            .Top      = 245
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsCarConta", "TextBox")
        WITH THIS.txt_4c_DsCarConta
            .Top      = 245
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Vincular KeyPress handlers para carteira (F4=115, ENTER=13, TAB=9)
        BINDEVENT(THIS.txt_4c_CdCarGrupo, "KeyPress", THIS, "TeclaCdCarGrupo")
        BINDEVENT(THIS.txt_4c_DsCarGrupo, "KeyPress", THIS, "TeclaDsCarGrupo")
        BINDEVENT(THIS.txt_4c_CdCarConta, "KeyPress", THIS, "TeclaCdCarConta")
        BINDEVENT(THIS.txt_4c_DsCarConta, "KeyPress", THIS, "TeclaDsCarConta")
    ENDPROC

    *==========================================================================
    * CONFIGURARGRIDOPERACOES - Grid de selecao de operacoes (3 colunas)
    * Cursor: cursor_4c_Operacoes (Marcas L, Operacaos C15, Tipos C2)
    * Original: grdOperacaos Top=158, Left=101, Width=188, Height=147
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridOperacoes()
        LOCAL loc_oGrid, loc_oCol

        THIS.AddObject("lbl_4c_Operacao", "Label")
        WITH THIS.lbl_4c_Operacao
            .Top       = 160
            .Left      = 41
            .Width     = 57
            .Height    = 18
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("grd_4c_Operacoes", "Grid")
        WITH THIS.grd_4c_Operacoes
            .Top          = 158
            .Left         = 101
            .Width        = 188
            .Height       = 147
            .ColumnCount  = 3
            .RecordSource = "cursor_4c_Operacoes"
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ScrollBars   = 2
            .RowHeight    = 18
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .GridLineColor = RGB(238, 238, 238)
            .HighlightStyle = 2
            .Visible      = .T.

            *-- Coluna 1: CheckBox para marcar operacao (LOGICAL)
            WITH .Column1
                .Width   = 22
                .Resizable = .F.
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Caption  = ""
                    .Value    = 0
                    .Visible  = .T.
                ENDWITH
                .CurrentControl  = "Check1"
                .ControlSource   = "cursor_4c_Operacoes.Marcas"
                .Header1.Caption = ""
            ENDWITH

            *-- Coluna 2: Descricao da operacao
            WITH .Column2
                .Width          = 96
                .ControlSource  = "cursor_4c_Operacoes.Operacaos"
                .ReadOnly       = .T.
                .Header1.Caption = ""
            ENDWITH

            *-- Coluna 3: Tipo da operacao
            WITH .Column3
                .Width          = 40
                .ControlSource  = "cursor_4c_Operacoes.Tipos"
                .ReadOnly       = .T.
                .Header1.Caption = ""
            ENDWITH
        ENDWITH

        loc_oGrid = THIS.grd_4c_Operacoes
        BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckOperacoes")
        BINDEVENT(loc_oGrid.Column1.Check1, "Click",    THIS, "CliqueCheckOperacoes")
    ENDPROC

    *==========================================================================
    * CONFIGURARGRIDIMPRIMIR - Grid de selecao de campos de impressao (2 colunas)
    * Cursor: cursor_4c_Imprimir (Marcas L, Campos C20)
    * Original: grdImprimir Top=311, Left=101, Width=188, Height=58
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridImprimir()
        LOCAL loc_oGrid

        THIS.AddObject("lbl_4c_Campos", "Label")
        WITH THIS.lbl_4c_Campos
            .Top       = 311
            .Left      = 50
            .Width     = 50
            .Height    = 18
            .Caption   = "Campos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("grd_4c_Imprimir", "Grid")
        WITH THIS.grd_4c_Imprimir
            .Top          = 311
            .Left         = 101
            .Width        = 188
            .Height       = 58
            .ColumnCount  = 2
            .RecordSource = "cursor_4c_Imprimir"
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ScrollBars   = 2
            .RowHeight    = 18
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .GridLineColor = RGB(238, 238, 238)
            .HighlightStyle = 2
            .Visible      = .T.

            *-- Coluna 1: CheckBox para marcar campo (LOGICAL)
            WITH .Column1
                .Width   = 22
                .Resizable = .F.
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Caption  = ""
                    .Value    = 0
                    .Visible  = .T.
                ENDWITH
                .CurrentControl  = "Check1"
                .ControlSource   = "cursor_4c_Imprimir.Marcas"
                .Header1.Caption = ""
            ENDWITH

            *-- Coluna 2: Nome do campo de impressao
            WITH .Column2
                .Width           = 146
                .ControlSource   = "cursor_4c_Imprimir.Campos"
                .ReadOnly        = .T.
                .Header1.Caption = ""
            ENDWITH
        ENDWITH

        loc_oGrid = THIS.grd_4c_Imprimir
        BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckImprimir")
        BINDEVENT(loc_oGrid.Column1.Check1, "Click",    THIS, "CliqueCheckImprimir")
    ENDPROC

    *==========================================================================
    * LIMPARCAMPOS - Restaura campos de filtro para valores padrao
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
            THIS.txt_4c_DtInicial.Value = DATE()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
            THIS.txt_4c_DtFinal.Value = DATE()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
            THIS.txt_4c_CdEmpresa.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
            THIS.txt_4c_DsEmpresa.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
            THIS.txt_4c_CdCarGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
            THIS.txt_4c_DsCarGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
            THIS.txt_4c_CdCarConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
            THIS.txt_4c_DsCarConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
            THIS.txt_4c_CdDepGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
            THIS.txt_4c_DsDepGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
            THIS.txt_4c_CdDepConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
            THIS.txt_4c_DsDepConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)
            THIS.txt_4c_CdEmiGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmiGrupo", 5)
            THIS.txt_4c_DsEmiGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmiConta", 5)
            THIS.txt_4c_CdEmiConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmiConta", 5)
            THIS.txt_4c_DsEmiConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
            THIS.obj_4c_NrOpcao.Value = 3
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
            THIS.obj_4c_NrTipo.Value = 2
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
            THIS.cbo_4c_Ordem.Value = 1
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
            THIS.chk_4c_Ultima.Value = 1
        ENDIF
    ENDPROC

    *==========================================================================
    * ATUALIZARTITULOSOPCAO - Aplica titulos dinamicos do SigCdPac ao OptionGroup
    * Chamado apos CarregarOpcoes() quando ha conexao disponivel
    *==========================================================================
    PROCEDURE AtualizarTitulosOpcao()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
            RETURN
        ENDIF
        WITH THIS.obj_4c_NrOpcao
            .Buttons(1).Caption = THIS.this_oRelatorio.this_cTituloOpcao1
            .Buttons(2).Caption = THIS.this_oRelatorio.this_cTituloOpcao2
            .Buttons(3).Caption = THIS.this_oRelatorio.this_cTituloOpcao3
        ENDWITH
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLA - KeyPress para campos de filtro (F4=115, ENTER=13, TAB=9)
    * Campos de data nao tem lookup - handlers vazios conforme padrao
    *==========================================================================
    PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdCarGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCarGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdCarGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsCarGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCarGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsCarGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdCarConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCarConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdCarConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsCarConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCarConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsCarConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdDepGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDepGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdDepGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsDepGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDepGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsDepGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdDepConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDepConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdDepConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsDepConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDepConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsDepConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEmiGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmiGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmiGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmiGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmiGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmiGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEmiConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmiConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmiConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmiConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmiConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmiConta()
        ENDIF
    ENDPROC

    *==========================================================================
    * TECLACHECK* - Toggle de checkbox nos grids via teclado (ENTER=13 / SPACE=32)
    *==========================================================================
    PROCEDURE TeclaCheckOperacoes(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 32
            IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
                SELECT cursor_4c_Operacoes
                REPLACE Marcas WITH !Marcas
                THIS.grd_4c_Operacoes.Refresh()
            ENDIF
        ENDIF
        IF par_nKeyCode = 9
            IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
                THIS.obj_4c_NrTipo.Buttons(1).SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaCheckImprimir(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 32
            IF USED("cursor_4c_Imprimir") AND !EOF("cursor_4c_Imprimir")
                SELECT cursor_4c_Imprimir
                REPLACE Marcas WITH !Marcas
                THIS.grd_4c_Imprimir.Refresh()
            ENDIF
        ENDIF
        IF par_nKeyCode = 9
            IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
                THIS.cbo_4c_Ordem.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CLIQUECHECKOPERACOES - Refresh do grid apos toggle por clique de mouse
    * O ControlSource atualiza Marcas automaticamente; apenas sincroniza display
    *==========================================================================
    PROCEDURE CliqueCheckOperacoes()
        IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CLIQUECHECKIMPRIMIR - Refresh do grid apos toggle por clique de mouse
    *==========================================================================
    PROCEDURE CliqueCheckImprimir()
        IF PEMSTATUS(THIS, "grd_4c_Imprimir", 5)
            THIS.grd_4c_Imprimir.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - EMPRESA
    * Tabela: SigCdEmp, Codigo: cEmps, Descricao: Razas
    *==========================================================================
    PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Emps, Razas FROM SigCdEmp WHERE Emps = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0 AND USED("cursor_4c_EmpVal")
            SELECT cursor_4c_EmpVal
            IF !EOF()
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(Razas)
            ELSE
                THIS.txt_4c_CdEmpresa.Value = ""
                THIS.txt_4c_DsEmpresa.Value = ""
                THIS.AbrirBuscaEmpresa()
            ENDIF
            USE IN cursor_4c_EmpVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cNome
        loc_cNome = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cNome)
            THIS.txt_4c_CdEmpresa.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEmpresa()
    ENDPROC

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loLookup, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loLookup) = "O"
                loLookup.this_cCursorDestino = "cursor_4c_EmpLst"
                loLookup.ConfigurarBusca("SigCdEmp", "cEmps", "Razas", ;
                    "Empresa", ALLTRIM(THIS.txt_4c_CdEmpresa.Value))
                loLookup.Show()
                IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                    THIS.txt_4c_CdEmpresa.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                    THIS.txt_4c_DsEmpresa.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                ENDIF
                loLookup = .NULL.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - CARTEIRA GRUPO
    * Grupo de carteira (fAcessoContab no legado)
    *==========================================================================
    PROCEDURE ValidarCdCarGrupo()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsCarGrupo.Value = ""
            THIS.txt_4c_CdCarConta.Value = ""
            THIS.txt_4c_DsCarConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL    = "SELECT DISTINCT GruCarts AS Codigo, GruCarts AS Descricao " + ;
                      "FROM SigCqChm WHERE GruCarts = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarGrupoVal")
        IF loc_nResult > 0 AND USED("cursor_4c_CarGrupoVal")
            SELECT cursor_4c_CarGrupoVal
            IF !EOF()
                THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(Codigo)
            ELSE
                THIS.txt_4c_CdCarGrupo.Value = ""
                THIS.txt_4c_DsCarGrupo.Value = ""
                THIS.txt_4c_CdCarConta.Value = ""
                THIS.txt_4c_DsCarConta.Value = ""
            ENDIF
            USE IN cursor_4c_CarGrupoVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsCarGrupo()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsCarGrupo.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdCarGrupo.Value = ""
            THIS.txt_4c_CdCarConta.Value = ""
            THIS.txt_4c_DsCarConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaCarGrupo()
    ENDPROC

    PROCEDURE AbrirBuscaCarGrupo()
        LOCAL loLookup, loc_cSQL, loc_nResult
        TRY
            loc_cSQL = "SELECT DISTINCT GruCarts AS codigo, GruCarts AS descricao " + ;
                       "FROM SigCqChm ORDER BY GruCarts"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarGrupoLst")
            IF loc_nResult > 0 AND USED("cursor_4c_CarGrupoLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_CarGrupoLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_CarGrupoLst", ;
                        "codigo", "descricao", "Grupo Carteira", ;
                        ALLTRIM(THIS.txt_4c_CdCarGrupo.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdCarGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                        THIS.txt_4c_CdCarConta.Value = ""
                        THIS.txt_4c_DsCarConta.Value = ""
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_CarGrupoLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCarGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - CARTEIRA CONTA
    * Conta dentro do grupo de carteira selecionado
    *==========================================================================
    PROCEDURE ValidarCdCarConta()
        LOCAL loc_cGrupo, loc_cCodigo, loc_cSQL, loc_nResult
        loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdCarConta.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsCarConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT DISTINCT ConCarts AS Codigo, Iclis AS Descricao " + ;
                   "FROM SigCqChm WHERE ConCarts = " + EscaparSQL(loc_cCodigo)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND GruCarts = " + EscaparSQL(loc_cGrupo)
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarContaVal")
        IF loc_nResult > 0 AND USED("cursor_4c_CarContaVal")
            SELECT cursor_4c_CarContaVal
            IF !EOF()
                THIS.txt_4c_DsCarConta.Value = ALLTRIM(Codigo)
            ELSE
                MsgAviso("Acesso Negado!!", "Carteira")
                THIS.txt_4c_CdCarConta.Value = ""
                THIS.txt_4c_DsCarConta.Value = ""
            ENDIF
            USE IN cursor_4c_CarContaVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsCarConta()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsCarConta.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdCarConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaCarConta()
    ENDPROC

    PROCEDURE AbrirBuscaCarConta()
        LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
        TRY
            loc_cGrupo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
            loc_cSQL   = "SELECT DISTINCT ConCarts AS codigo, ConCarts AS descricao " + ;
                         "FROM SigCqChm"
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " WHERE GruCarts = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY ConCarts"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarContaLst")
            IF loc_nResult > 0 AND USED("cursor_4c_CarContaLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_CarContaLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_CarContaLst", ;
                        "codigo", "descricao", "Conta Carteira", ;
                        ALLTRIM(THIS.txt_4c_CdCarConta.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdCarConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsCarConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_CarContaLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCarConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - DEPOSITO GRUPO
    *==========================================================================
    PROCEDURE ValidarCdDepGrupo()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsDepGrupo.Value = ""
            THIS.txt_4c_CdDepConta.Value = ""
            THIS.txt_4c_DsDepConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL    = "SELECT DISTINCT Grupos AS Codigo, Grupos AS Descricao " + ;
                      "FROM SigCqChm WHERE Grupos = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepGrupoVal")
        IF loc_nResult > 0 AND USED("cursor_4c_DepGrupoVal")
            SELECT cursor_4c_DepGrupoVal
            IF !EOF()
                THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(Codigo)
            ELSE
                THIS.txt_4c_CdDepGrupo.Value = ""
                THIS.txt_4c_DsDepGrupo.Value = ""
                THIS.txt_4c_CdDepConta.Value = ""
                THIS.txt_4c_DsDepConta.Value = ""
            ENDIF
            USE IN cursor_4c_DepGrupoVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsDepGrupo()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsDepGrupo.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdDepGrupo.Value = ""
            THIS.txt_4c_CdDepConta.Value = ""
            THIS.txt_4c_DsDepConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDepGrupo()
    ENDPROC

    PROCEDURE AbrirBuscaDepGrupo()
        LOCAL loLookup, loc_cSQL, loc_nResult
        TRY
            loc_cSQL    = "SELECT DISTINCT Grupos AS codigo, Grupos AS descricao " + ;
                          "FROM SigCqChm ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepGrupoLst")
            IF loc_nResult > 0 AND USED("cursor_4c_DepGrupoLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_DepGrupoLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_DepGrupoLst", ;
                        "codigo", "descricao", "Grupo Dep" + CHR(243) + "sito", ;
                        ALLTRIM(THIS.txt_4c_CdDepGrupo.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdDepGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                        THIS.txt_4c_CdDepConta.Value = ""
                        THIS.txt_4c_DsDepConta.Value = ""
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_DepGrupoLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDepGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - DEPOSITO CONTA
    * Conta de deposito (link SigCqChm.Contas ? SigCdCli.Iclis)
    *==========================================================================
    PROCEDURE ValidarCdDepConta()
        LOCAL loc_cGrupo, loc_cCodigo, loc_cSQL, loc_nResult
        loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdDepConta.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsDepConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT a.Contas AS Codigo, e.Rclis AS Descricao " + ;
                   "FROM SigCqChm a JOIN SigCdCli e ON a.Contas = e.Iclis " + ;
                   "WHERE a.Contas = " + EscaparSQL(loc_cCodigo)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepContaVal")
        IF loc_nResult > 0 AND USED("cursor_4c_DepContaVal")
            SELECT cursor_4c_DepContaVal
            IF !EOF()
                THIS.txt_4c_DsDepConta.Value = ALLTRIM(Descricao)
            ELSE
                MsgAviso("Acesso Negado!!", "Dep" + CHR(243) + "sito")
                THIS.txt_4c_CdDepConta.Value = ""
                THIS.txt_4c_DsDepConta.Value = ""
            ENDIF
            USE IN cursor_4c_DepContaVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsDepConta()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsDepConta.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdDepConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDepConta()
    ENDPROC

    PROCEDURE AbrirBuscaDepConta()
        LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
        TRY
            loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
            loc_cSQL    = "SELECT DISTINCT a.Contas AS codigo, e.Rclis AS descricao " + ;
                          "FROM SigCqChm a JOIN SigCdCli e ON a.Contas = e.Iclis"
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " WHERE a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cSQL    = loc_cSQL + " ORDER BY e.Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepContaLst")
            IF loc_nResult > 0 AND USED("cursor_4c_DepContaLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_DepContaLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_DepContaLst", ;
                        "codigo", "descricao", "Conta Dep" + CHR(243) + "sito", ;
                        ALLTRIM(THIS.txt_4c_CdDepConta.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdDepConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsDepConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_DepContaLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDepConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - EMISSOR GRUPO
    *==========================================================================
    PROCEDURE ValidarCdEmiGrupo()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsEmiGrupo.Value = ""
            THIS.txt_4c_CdEmiConta.Value = ""
            THIS.txt_4c_DsEmiConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL    = "SELECT DISTINCT Grclis AS Codigo, Grclis AS Descricao " + ;
                      "FROM SigCqChm WHERE Grclis = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiGrupoVal")
        IF loc_nResult > 0 AND USED("cursor_4c_EmiGrupoVal")
            SELECT cursor_4c_EmiGrupoVal
            IF !EOF()
                THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(Codigo)
            ELSE
                THIS.txt_4c_CdEmiGrupo.Value = ""
                THIS.txt_4c_DsEmiGrupo.Value = ""
                THIS.txt_4c_CdEmiConta.Value = ""
                THIS.txt_4c_DsEmiConta.Value = ""
            ENDIF
            USE IN cursor_4c_EmiGrupoVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsEmiGrupo()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsEmiGrupo.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdEmiGrupo.Value = ""
            THIS.txt_4c_CdEmiConta.Value = ""
            THIS.txt_4c_DsEmiConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEmiGrupo()
    ENDPROC

    PROCEDURE AbrirBuscaEmiGrupo()
        LOCAL loLookup, loc_cSQL, loc_nResult
        TRY
            loc_cSQL    = "SELECT DISTINCT Grclis AS codigo, Grclis AS descricao " + ;
                          "FROM SigCqChm ORDER BY Grclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiGrupoLst")
            IF loc_nResult > 0 AND USED("cursor_4c_EmiGrupoLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_EmiGrupoLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_EmiGrupoLst", ;
                        "codigo", "descricao", "Grupo Emissor", ;
                        ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdEmiGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                        THIS.txt_4c_CdEmiConta.Value = ""
                        THIS.txt_4c_DsEmiConta.Value = ""
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_EmiGrupoLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaEmiGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - EMISSOR CONTA
    * Conta de emissor (link SigCqChm.Iclis ? SigCdCli.Iclis)
    *==========================================================================
    PROCEDURE ValidarCdEmiConta()
        LOCAL loc_cGrupo, loc_cCodigo, loc_cSQL, loc_nResult
        loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmiConta.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsEmiConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT DISTINCT a.Iclis AS Codigo, d.Rclis AS Descricao " + ;
                   "FROM SigCqChm a JOIN SigCdCli d ON a.Iclis = d.Iclis " + ;
                   "WHERE a.Iclis = " + EscaparSQL(loc_cCodigo)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND a.Grclis = " + EscaparSQL(loc_cGrupo)
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiContaVal")
        IF loc_nResult > 0 AND USED("cursor_4c_EmiContaVal")
            SELECT cursor_4c_EmiContaVal
            IF !EOF()
                THIS.txt_4c_DsEmiConta.Value = ALLTRIM(Descricao)
            ELSE
                MsgAviso("Acesso Negado!!", "Emissor")
                THIS.txt_4c_CdEmiConta.Value = ""
                THIS.txt_4c_DsEmiConta.Value = ""
            ENDIF
            USE IN cursor_4c_EmiContaVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsEmiConta()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsEmiConta.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdEmiConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEmiConta()
    ENDPROC

    PROCEDURE AbrirBuscaEmiConta()
        LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
        TRY
            loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
            loc_cSQL    = "SELECT DISTINCT a.Iclis AS codigo, d.Rclis AS descricao " + ;
                          "FROM SigCqChm a JOIN SigCdCli d ON a.Iclis = d.Iclis"
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " WHERE a.Grclis = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cSQL    = loc_cSQL + " ORDER BY d.Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiContaLst")
            IF loc_nResult > 0 AND USED("cursor_4c_EmiContaLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_EmiContaLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_EmiContaLst", ;
                        "codigo", "descricao", "Conta Emissor", ;
                        ALLTRIM(THIS.txt_4c_CdEmiConta.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdEmiConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsEmiConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_EmiContaLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaEmiConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNBUSCARCLICK - "Buscar" no contexto de relatorio: gerar visualizacao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Gerar Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNENCERRARCLICK - Encerrar/fechar o form de relatorio
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNSALVARCLICK - "Salvar" no contexto de relatorio: imprimir
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Imprimir()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FORMPARABO - Alias de FormParaRelatorio (compatibilidade com FormBase)
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *==========================================================================
    * BOPARAFORM - Carrega estado do BO de volta para os controles do form
    * Inverso de FormParaRelatorio: popula controles com valores atuais do BO
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
                THIS.obj_4c_NrTipo.Value = .this_nNrTipo
            ENDIF
            IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
                THIS.obj_4c_NrOpcao.Value = .this_nNrOpcao
            ENDIF
            IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
                THIS.cbo_4c_Ordem.Value = .this_nOrdem
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
                THIS.chk_4c_Ultima.Value = IIF(.this_lUltima = .T., 1, 0)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
                THIS.txt_4c_DtInicial.Value = .this_dDtInicial
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
                THIS.txt_4c_DtFinal.Value = .this_dDtFinal
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
                THIS.txt_4c_CdEmpresa.Value = ALLTRIM(.this_cCdEmpresa)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(.this_cDsEmpresa)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
                THIS.txt_4c_CdCarGrupo.Value = ALLTRIM(.this_cCdCarGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
                THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(.this_cDsCarGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
                THIS.txt_4c_CdCarConta.Value = ALLTRIM(.this_cCdCarConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
                THIS.txt_4c_DsCarConta.Value = ALLTRIM(.this_cDsCarConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
                THIS.txt_4c_CdDepGrupo.Value = ALLTRIM(.this_cCdDepGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
                THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(.this_cDsDepGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
                THIS.txt_4c_CdDepConta.Value = ALLTRIM(.this_cCdDepConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
                THIS.txt_4c_DsDepConta.Value = ALLTRIM(.this_cDsDepConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)
                THIS.txt_4c_CdEmiGrupo.Value = ALLTRIM(.this_cCdEmiGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmiGrupo", 5)
                THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(.this_cDsEmiGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdEmiConta", 5)
                THIS.txt_4c_CdEmiConta.Value = ALLTRIM(.this_cCdEmiConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmiConta", 5)
                THIS.txt_4c_DsEmiConta.Value = ALLTRIM(.this_cDsEmiConta)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * HABILITARCAMPOS - Habilita/desabilita todos os controles de filtro
    * par_lHabilitar: .T. = editavel, .F. = somente leitura
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(PCOUNT() < 1 OR VARTYPE(par_lHabilitar) != "L", .T., par_lHabilitar)

        IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
            THIS.txt_4c_DtInicial.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
            THIS.txt_4c_DtFinal.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
            THIS.txt_4c_CdEmpresa.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
            THIS.txt_4c_DsEmpresa.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
            THIS.txt_4c_CdCarGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
            THIS.txt_4c_DsCarGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
            THIS.txt_4c_CdCarConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
            THIS.txt_4c_DsCarConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
            THIS.txt_4c_CdDepGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
            THIS.txt_4c_DsDepGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
            THIS.txt_4c_CdDepConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
            THIS.txt_4c_DsDepConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)
            THIS.txt_4c_CdEmiGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmiGrupo", 5)
            THIS.txt_4c_DsEmiGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmiConta", 5)
            THIS.txt_4c_CdEmiConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmiConta", 5)
            THIS.txt_4c_DsEmiConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
            THIS.obj_4c_NrOpcao.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
            THIS.obj_4c_NrTipo.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
            THIS.cbo_4c_Ordem.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
            THIS.chk_4c_Ultima.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * CARREGARLISTA - Recarrega grids de operacoes e campos de impressao
    * Para forms REPORT, recria cursores e atualiza opcoes do BO via banco
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                loc_lSucesso = .F.
            ENDIF
            THIS.this_oRelatorio.InicializarCursores()
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                THIS.this_oRelatorio.CarregarOpcoes()
                THIS.AtualizarTitulosOpcao()
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
                THIS.grd_4c_Operacoes.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Imprimir", 5)
                THIS.grd_4c_Imprimir.Refresh()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AJUSTARBOTOESPORMODO - Ajusta estado dos botoes
    * Para forms REPORT, todos os botoes de acao permanecem habilitados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        IF !PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            RETURN
        ENDIF
        WITH THIS.cmg_4c_Botoes
            .Buttons(1).Enabled = .T.
            .Buttons(2).Enabled = .T.
            .Buttons(3).Enabled = .T.
            .Buttons(4).Enabled = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * DESTROY - Limpeza de recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecheBO.prg):
*==============================================================================
* SIGRECHEBO.PRG
* Business Object para Relatorio de Cheques (SIGRECHE)
*
* Herda de RelatorioBase
* Filtros: periodo, empresa, tipo, opcao, ordem, ultima movimentacao,
*          carteira (grupo/conta), deposito (grupo/conta), emissor (grupo/conta)
* Tabelas principais: SigCqChm, SigChe, SigCdCli, SigCdOpt, SigCdPac, SigCdEmp
*==============================================================================

DEFINE CLASS sigrecheBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoFrx        = ""
    this_cTitulo            = ""

    *-- Nomes dos cursores
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"
    this_cCursorOperacoes   = "cursor_4c_Operacoes"
    this_cCursorImprimir    = "cursor_4c_Imprimir"

    *-- Filtros de periodo (get_dt_inicial / get_dt_final)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtros de empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Tipo de relatorio: 1=Abertos, 2=Geral, 3=DtOperacao, 4=DtVencimento
    this_nNrTipo            = 1

    *-- Opcao (com/sem nota): 1=Sim, 2=Nao, 3=Ambos
    this_nNrOpcao           = 3

    *-- Ordem de classificacao: 1=Carteira,2=Deposito,3=Emissor,4=DtEntrada,5=CPF,6=Nome
    this_nOrdem             = 1

    *-- Apenas ultima movimentacao por cheque
    this_lUltima            = .T.

    *-- Titulos dinamicos carregados de SigCdPac
    this_cTituloOpcao1      = "Sim"
    this_cTituloOpcao2      = "N" + CHR(227) + "o"
    this_cTituloOpcao3      = "Ambos"

    *-- Filtros de carteira (get_cd_car_grupo / get_ds_car_grupo / ...)
    this_cCdCarGrupo        = ""
    this_cDsCarGrupo        = ""
    this_cCdCarConta        = ""
    this_cDsCarConta        = ""

    *-- Filtros de deposito (get_cd_dep_grupo / get_ds_dep_grupo / ...)
    this_cCdDepGrupo        = ""
    this_cDsDepGrupo        = ""
    this_cCdDepConta        = ""
    this_cDsDepConta        = ""

    *-- Filtros de emissor (get_cd_emi_grupo / get_ds_emi_grupo / ...)
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *--------------------------------------------------------------------------
    * Init - Configura caminho do FRX e titulo; inicializa datas com hoje
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFrx = gc_4c_CaminhoReports + "SigReChe.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Cheques"
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursor_4c_Imprimir (campos opcionals de impressao)
    * e cursor_4c_Operacoes vazio (preenchido por CarregarOpcoes)
    * Chamado pelo Form em InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorImprimir)
                USE IN (THIS.this_cCursorImprimir)
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Imprimir (Marcas L(1), Campos C(20))
            SET NULL OFF
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.T., "C" + CHR(243) + "digo")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "C.P.F.")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "Nome")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "C.P.F. T")
            GO TOP IN cursor_4c_Imprimir

            IF USED(THIS.this_cCursorOperacoes)
                USE IN (THIS.this_cCursorOperacoes)
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Operacoes (Marcas L(1), Operacaos C(15), Tipos C(2))
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarCursores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOpcoes - Carrega SigCdOpt ? cursor_4c_Operacoes
    * e titulos de opcao de SigCdPac (para o OptionGroup do form)
    * Chamado pelo Form apos InicializarCursores()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOpcoes()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Operacaos, Tipos FROM SigCdOpt"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpt")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpOpt")
                SELECT cursor_4c_TmpOpt
                GO TOP
                SCAN
                    INSERT INTO cursor_4c_Operacoes (Marcas, Operacaos, Tipos) ;
                        VALUES (.F., cursor_4c_TmpOpt.Operacaos, cursor_4c_TmpOpt.Tipos)
                ENDSCAN
                USE IN cursor_4c_TmpOpt
            ENDIF
            GO TOP IN cursor_4c_Operacoes

            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPac")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpPac")
                SELECT cursor_4c_TmpPac
                GO TOP
                IF !EOF()
                    IF !EMPTY(ALLTRIM(TitOpcS))
                        THIS.this_cTituloOpcao1 = ALLTRIM(TitOpcS)
                    ENDIF
                    IF !EMPTY(ALLTRIM(TitOpcN))
                        THIS.this_cTituloOpcao2 = ALLTRIM(TitOpcN)
                    ENDIF
                    IF !EMPTY(ALLTRIM(TitOpcA))
                        THIS.this_cTituloOpcao3 = ALLTRIM(TitOpcA)
                    ENDIF
                ENDIF
                USE IN cursor_4c_TmpPac
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarOpcoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Validar - Valida filtros antes de gerar relatorio
    * Retorna .T. se tudo ok; caso contrario seta this_cMensagemErro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_nMarcados

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data inicial inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data final inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagemErro = "Data inicial maior que data final!"
            RETURN .F.
        ENDIF

        loc_nMarcados = 0
        IF USED(THIS.this_cCursorOperacoes)
            SELECT (THIS.this_cCursorOperacoes)
            SCAN
                IF Marcas
                    loc_nMarcados = loc_nMarcados + 1
                ENDIF
            ENDSCAN
        ENDIF
        IF loc_nMarcados = 0
            THIS.this_cMensagemErro = "Selecione ao menos uma Opera" + CHR(231) + CHR(227) + "o!"
            RETURN .F.
        ENDIF

        loc_nMarcados = 0
        IF USED(THIS.this_cCursorImprimir)
            SELECT (THIS.this_cCursorImprimir)
            SCAN
                IF Marcas
                    loc_nMarcados = loc_nMarcados + 1
                ENDIF
            ENDSCAN
        ENDIF
        IF loc_nMarcados = 0
            THIS.this_cMensagemErro = "Selecione ao menos um Campo para Impress" + CHR(227) + "o!"
            RETURN .F.
        ENDIF

        IF USED(THIS.this_cCursorImprimir)
            SELECT (THIS.this_cCursorImprimir)
            SCAN
                IF !Marcas
                    IF (Campos = "C.P.F." .AND. THIS.this_nOrdem = 5) .OR. ;
                       (Campos = "Nome"   .AND. THIS.this_nOrdem = 6)
                        THIS.this_cMensagemErro = "Esta Ordem Necessita Que Selecione o " + ;
                            "Campo de Impress" + CHR(227) + "o " + ALLTRIM(Campos) + "!"
                        RETURN .F.
                    ENDIF
                ENDIF
            ENDSCAN
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros, executa via SQLEXEC, filtra
    * por operacoes selecionadas e popula cursor_4c_Cabecalho + cursor_4c_Relatorio
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerCarGrupo, loc_cVerCarConta
        LOCAL loc_cVerDepGrupo, loc_cVerDepConta
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta
        LOCAL loc_cVerAberto, loc_cOrdenaPor, loc_cQuebra, loc_cTituloOrdem
        LOCAL loc_cTitulo, loc_cNomeEmpresa, loc_cPeriodo
        LOCAL loc_cCarteira, loc_cDeposito, loc_cEmissor, loc_cOperacao
        LOCAL loc_lCpfs, loc_lRclis, loc_lCpft
        LOCAL loc_cSQL, loc_cNum

        loc_lSucesso = .F.
        loc_lCpfs    = .F.
        loc_lRclis   = .F.
        loc_lCpft    = .F.

        TRY
            *-- 2. Filtros opcionais de empresa, opcao, carteira, deposito, emissor
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cVerEmpresa = ""
            ELSE
                loc_cVerEmpresa = " AND a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            IF THIS.this_nNrOpcao = 1
                loc_cVerOpcao = " AND a.notas <> '" + SPACE(6) + "'"
            ENDIF
            IF THIS.this_nNrOpcao = 2
                loc_cVerOpcao = " AND a.notas = '" + SPACE(6) + "'"
            ENDIF
            IF THIS.this_nNrOpcao = 3
                loc_cVerOpcao = ""
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdCarGrupo))
                loc_cVerCarGrupo = ""
            ELSE
                loc_cVerCarGrupo = " AND a.grucarts = " + EscaparSQL(ALLTRIM(THIS.this_cCdCarGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdCarConta))
                loc_cVerCarConta = ""
            ELSE
                loc_cVerCarConta = " AND a.concarts = " + EscaparSQL(ALLTRIM(THIS.this_cCdCarConta))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdDepGrupo))
                loc_cVerDepGrupo = ""
            ELSE
                loc_cVerDepGrupo = " AND a.grupos = " + EscaparSQL(ALLTRIM(THIS.this_cCdDepGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdDepConta))
                loc_cVerDepConta = ""
            ELSE
                loc_cVerDepConta = " AND a.contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdDepConta))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo))
                loc_cVerEmiGrupo = ""
            ELSE
                loc_cVerEmiGrupo = " AND a.grclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiConta))
                loc_cVerEmiConta = ""
            ELSE
                loc_cVerEmiConta = " AND a.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiConta))
            ENDIF

            *-- Filtro de abertos aplicado no filtro local pos-SQLEXEC
            IF THIS.this_nNrTipo = 1
                loc_cVerAberto = " AND c.Tipos = 'DB'"
            ELSE
                loc_cVerAberto = ""
            ENDIF

            *-- 3. ORDER BY, campo Quebra e sufixo do titulo conforme ordem
            DO CASE
                CASE THIS.this_nOrdem = 1
                    loc_cOrdenaPor  = "a.GruCarts, a.ConCarts, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Carteira: ' + a.GruCarts + '/' + a.ConCarts"
                    loc_cTituloOrdem = "Carteira"
                CASE THIS.this_nOrdem = 2
                    loc_cOrdenaPor  = "a.Grupos, a.Contas, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Dep' + CHR(243) + 'sito: ' + a.Grupos + '/' + a.Contas"
                    loc_cTituloOrdem = "Dep" + CHR(243) + "sito"
                CASE THIS.this_nOrdem = 3
                    loc_cOrdenaPor  = "a.Grclis, a.Iclis, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Emissor: ' + a.Grclis + '/' + a.Iclis"
                    loc_cTituloOrdem = "Emissor"
                CASE THIS.this_nOrdem = 4
                    loc_cOrdenaPor  = "a.Dtents, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Entrada: ' + DTOC(a.Dtents)"
                    loc_cTituloOrdem = "Data de Entrada"
                CASE THIS.this_nOrdem = 5
                    loc_cOrdenaPor  = "a.Cpfs, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'C.P.F.: ' + a.Cpfs"
                    loc_cTituloOrdem = "C.P.F."
                OTHERWISE
                    loc_cOrdenaPor  = "a.Rclis, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Nome: ' + a.Rclis"
                    loc_cTituloOrdem = "Nome do Cliente"
            ENDCASE

            *-- 4. Titulo do relatorio
            loc_cTitulo = "Relat" + CHR(243) + "rio de Cheques - "
            DO CASE
                CASE THIS.this_nNrTipo = 1
                    loc_cTitulo = loc_cTitulo + "Abertos"
                CASE THIS.this_nNrTipo = 2
                    loc_cTitulo = loc_cTitulo + "Geral"
                CASE THIS.this_nNrTipo = 3
                    loc_cTitulo = loc_cTitulo + "Data de Opera" + CHR(231) + CHR(227) + "o"
                OTHERWISE
                    loc_cTitulo = loc_cTitulo + "Data de Vencimento"
            ENDCASE
            loc_cTitulo = loc_cTitulo + " - Ordem: " + loc_cTituloOrdem

            *-- 5. Nome da empresa corrente
            loc_cNomeEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Emps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmp")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpEmp")
                SELECT cursor_4c_TmpEmp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_TmpEmp
            ENDIF

            *-- 6. Textos descritivos para o cabecalho do relatorio
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + IIF(EMPTY(ALLTRIM(THIS.this_cCdEmpresa)), ;
                               "Geral", ;
                               ALLTRIM(THIS.this_cCdEmpresa) + " - " + ALLTRIM(THIS.this_cDsEmpresa))

            loc_cCarteira = "Grupo / Conta Carteira : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdCarGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdCarGrupo) + " - " + ALLTRIM(THIS.this_cDsCarGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdCarConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdCarConta) + " - " + ALLTRIM(THIS.this_cDsCarConta))

            loc_cDeposito = "Grupo / Conta Deposito : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdDepGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdDepGrupo) + " - " + ALLTRIM(THIS.this_cDsDepGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdDepConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdDepConta) + " - " + ALLTRIM(THIS.this_cDsDepConta))

            loc_cEmissor = "Grupo / Conta Emissor  : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdEmiGrupo) + " - " + ALLTRIM(THIS.this_cDsEmiGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdEmiConta) + " - " + ALLTRIM(THIS.this_cDsEmiConta))

            *-- 7. Texto das operacoes selecionadas
            loc_cOperacao = "Opera" + CHR(231) + CHR(227) + "o : "
            IF USED(THIS.this_cCursorOperacoes)
                SELECT (THIS.this_cCursorOperacoes)
                SCAN
                    IF Marcas
                        IF LEN(ALLTRIM(loc_cOperacao)) > 12
                            loc_cOperacao = loc_cOperacao + " / "
                        ENDIF
                        loc_cOperacao = loc_cOperacao + ALLTRIM(Operacaos)
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 8. Flags de campos de impressao (Cpfs, Rclis, CpfsT)
            IF USED(THIS.this_cCursorImprimir)
                SELECT (THIS.this_cCursorImprimir)
                SCAN
                    IF Marcas
                        IF Campos = "C.P.F."
                            loc_lCpfs = (THIS.this_nOrdem # 5)
                        ENDIF
                        IF Campos = "Nome"
                            loc_lRclis = (THIS.this_nOrdem # 6)
                        ENDIF
                        IF Campos = "C.P.F. T"
                            loc_lCpft = .T.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 9. Cursor de cabecalho do relatorio
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                               Operacao C(200), Carteira C(80), Deposito C(80), ;
                                               Emissor C(80), Tipo N(1), ;
                                               Cpfs L(1), Rclis L(1), Cpfst L(1))
            SET NULL OFF
            INSERT INTO cursor_4c_Cabecalho ;
                (NomeEmpresa, Titulo, Periodo, Operacao, Carteira, ;
                 Deposito, Emissor, Tipo, Cpfs, Rclis, Cpfst) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cOperacao, ;
                        loc_cCarteira, loc_cDeposito, loc_cEmissor, THIS.this_nOrdem, ;
                        loc_lCpfs, loc_lRclis, loc_lCpft)

            *-- 10. SQL principal via SQLEXEC (SigCqChm + SigChe + SigCdCli x3)
            IF USED("cursor_4c_Relatorio0")
                USE IN cursor_4c_Relatorio0
            ENDIF
            loc_cSQL = "SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, " + ;
                       "a.Contas + '-' + e.rclis AS Contas, a.Grclis, a.Iclis, a.Dtsis, " + ;
                       "b.Vencs, b.Valors, b.Emps, b.Bancos, b.Agencias, b.Ncontas, b.Ncheques, " + ;
                       "b.Bancos + '-' + b.Agencias + '-' + b.Ncontas + '-' + b.Ncheques AS Cheques, " + ;
                       "a.codigos AS Operacaos, d.Cpfs, d.Rclis, a.hists, f.cpfs AS cpfsT " + ;
                       "FROM SigCqChm a, SigCdCli d, SigCdCli e, " + ;
                       "SigChe b LEFT JOIN SigCdCli f ON b.grupot = f.grupos AND b.contat = f.iclis " + ;
                       "WHERE a.Nums = b.Nums AND b.Iclis = d.Iclis AND a.contas = e.Iclis" + ;
                       loc_cVerEmpresa + loc_cVerOpcao + ;
                       loc_cVerCarGrupo + loc_cVerCarConta + ;
                       loc_cVerDepGrupo + loc_cVerDepConta + ;
                       loc_cVerEmiGrupo + loc_cVerEmiConta
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Relatorio0")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cheques."
                loc_lSucesso = .F.
            ENDIF

            *-- 11. Filtrar por operacoes selecionadas e montar cursor final
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF

            IF THIS.this_lUltima
                *-- Apenas ultima movimentacao por numero de cheque
                *-- Cria cursor-modelo com campo Quebra adicional
                SELECT *, SPACE(100) AS Quebra ;
                    FROM cursor_4c_Relatorio0 ;
                    WHERE 0 = 1 ;
                    INTO CURSOR cursor_4c_Resultado READWRITE

                *-- Seleciona com Quebra calculada, ordenado por Nums + Dtsis DESC
                SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
                       a.Contas, a.Grclis, a.Iclis, a.Dtsis, ;
                       a.Vencs, a.Valors, a.Emps, a.Cheques, ;
                       a.Operacaos, a.Cpfs, a.Rclis, a.cpfsT, ;
                       &loc_cQuebra. AS Quebra, a.hists ;
                       FROM cursor_4c_Relatorio0 a, cursor_4c_Operacoes c ;
                       WHERE c.Marcas AND a.Operacaos = c.Operacaos &loc_cVerAberto. ;
                       INTO CURSOR cursor_4c_Selecao ;
                       ORDER BY a.Nums, a.Dtsis DESCENDING

                *-- Pega primeiro registro de cada grupo Nums (= mais recente)
                SELECT cursor_4c_Selecao
                GO TOP
                SCAN
                    loc_cNum = Nums
                    SCATTER MEMVAR MEMO
                    SELECT cursor_4c_Resultado
                    APPEND BLANK
                    GATHER MEMVAR MEMO
                    SELECT cursor_4c_Selecao
                    SCAN WHILE Nums = loc_cNum
                    ENDSCAN
                    SKIP -1
                ENDSCAN

                SELECT a.* FROM cursor_4c_Resultado a ;
                    ORDER BY &loc_cOrdenaPor. ;
                    INTO CURSOR cursor_4c_Relatorio

                IF USED("cursor_4c_Resultado")
                    USE IN cursor_4c_Resultado
                ENDIF
                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF
            ELSE
                *-- Todas as movimentacoes
                SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
                       a.Contas, a.Grclis, a.Iclis, a.Dtsis, ;
                       a.Vencs, a.Valors, a.Emps, a.Cheques, ;
                       a.Operacaos, a.Cpfs, a.Rclis, &loc_cQuebra. AS Quebra, a.hists, a.cpfsT ;
                       FROM cursor_4c_Relatorio0 a, cursor_4c_Operacoes c ;
                       WHERE c.Marcas AND a.Operacaos = c.Operacaos &loc_cVerAberto. ;
                       ORDER BY &loc_cOrdenaPor. ;
                       INTO CURSOR cursor_4c_Relatorio
            ENDIF

            IF USED("cursor_4c_Relatorio0")
                USE IN cursor_4c_Relatorio0
            ENDIF

            SELECT cursor_4c_Relatorio
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Valida, prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.Validar()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFrx) TO PRINTER PROMPT NOCONSOLE
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Valida, prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.Validar()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFrx) PREVIEW NOCONSOLE
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO=" + ALLTRIM(STR(THIS.this_nNrTipo, 1)) + ;
                     ";OPC="  + ALLTRIM(STR(THIS.this_nNrOpcao, 1)) + ;
                     ";ORD="  + ALLTRIM(STR(THIS.this_nOrdem, 1)) + ;
                     ";DT="   + DTOC(THIS.this_dDtInicial) + ;
                     "-"      + DTOC(THIS.this_dDtFinal) + ;
                     ";EMP="  + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";CAR="  + ALLTRIM(THIS.this_cCdCarGrupo) + "/" + ALLTRIM(THIS.this_cCdCarConta) + ;
                     ";DEP="  + ALLTRIM(THIS.this_cCdDepGrupo) + "/" + ALLTRIM(THIS.this_cCdDepConta) + ;
                     ";EMI="  + ALLTRIM(THIS.this_cCdEmiGrupo) + "/" + ALLTRIM(THIS.this_cCdEmiConta) + ;
                     ";ULT="  + IIF(THIS.this_lUltima, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Para BO de relatorio, o cursor pode armazenar parametros previamente usados
    * par_cAliasCursor: nome do cursor com colunas dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.dDtInicial") = "D"
                        THIS.this_dDtInicial = m.dDtInicial
                    ENDIF
                    IF TYPE("m.dDtFinal") = "D"
                        THIS.this_dDtFinal = m.dDtFinal
                    ENDIF
                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.nNrTipo") = "N"
                        THIS.this_nNrTipo = m.nNrTipo
                    ENDIF
                    IF TYPE("m.nNrOpcao") = "N"
                        THIS.this_nNrOpcao = m.nNrOpcao
                    ENDIF
                    IF TYPE("m.nOrdem") = "N"
                        THIS.this_nOrdem = m.nOrdem
                    ENDIF
                    IF TYPE("m.lUltima") = "L"
                        THIS.this_lUltima = m.lUltima
                    ENDIF
                    IF TYPE("m.cCdCarGrupo") = "C"
                        THIS.this_cCdCarGrupo = ALLTRIM(m.cCdCarGrupo)
                    ENDIF
                    IF TYPE("m.cDsCarGrupo") = "C"
                        THIS.this_cDsCarGrupo = ALLTRIM(m.cDsCarGrupo)
                    ENDIF
                    IF TYPE("m.cCdCarConta") = "C"
                        THIS.this_cCdCarConta = ALLTRIM(m.cCdCarConta)
                    ENDIF
                    IF TYPE("m.cDsCarConta") = "C"
                        THIS.this_cDsCarConta = ALLTRIM(m.cDsCarConta)
                    ENDIF
                    IF TYPE("m.cCdDepGrupo") = "C"
                        THIS.this_cCdDepGrupo = ALLTRIM(m.cCdDepGrupo)
                    ENDIF
                    IF TYPE("m.cDsDepGrupo") = "C"
                        THIS.this_cDsDepGrupo = ALLTRIM(m.cDsDepGrupo)
                    ENDIF
                    IF TYPE("m.cCdDepConta") = "C"
                        THIS.this_cCdDepConta = ALLTRIM(m.cCdDepConta)
                    ENDIF
                    IF TYPE("m.cDsDepConta") = "C"
                        THIS.this_cDsDepConta = ALLTRIM(m.cDsDepConta)
                    ENDIF
                    IF TYPE("m.cCdEmiGrupo") = "C"
                        THIS.this_cCdEmiGrupo = ALLTRIM(m.cCdEmiGrupo)
                    ENDIF
                    IF TYPE("m.cDsEmiGrupo") = "C"
                        THIS.this_cDsEmiGrupo = ALLTRIM(m.cDsEmiGrupo)
                    ENDIF
                    IF TYPE("m.cCdEmiConta") = "C"
                        THIS.this_cCdEmiConta = ALLTRIM(m.cCdEmiConta)
                    ENDIF
                    IF TYPE("m.cDsEmiConta") = "C"
                        THIS.this_cDsEmiConta = ALLTRIM(m.cDsEmiConta)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        LOCAL loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReChe") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores locais e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_Relatorio")
            USE IN cursor_4c_Relatorio
        ENDIF
        IF USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF
        IF USED(THIS.this_cCursorImprimir)
            USE IN (THIS.this_cCursorImprimir)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

