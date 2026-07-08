# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[05/19/26 09:27:33 AM] sigrecrtBO.CarregarParametros: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-19 09:26:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-19 09:26:19] [INFO] Config FPW: (nao fornecido)
[2026-05-19 09:26:19] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-19 09:26:19] [INFO] Timeout: 300 segundos
[2026-05-19 09:26:19] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_wutlbzb5.prg
[2026-05-19 09:26:19] [INFO] Conteudo do wrapper:
[2026-05-19 09:26:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrecrt', 'C:\4c\tasks\task068', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecrt', 'C:\4c\tasks\task068', 'REPORT'
QUIT

[2026-05-19 09:26:19] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_wutlbzb5.prg
[2026-05-19 09:26:19] [INFO] VFP output esperado em: C:\4c\tasks\task068\vfp_output.txt
[2026-05-19 09:26:19] [INFO] Executando Visual FoxPro 9...
[2026-05-19 09:26:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_wutlbzb5.prg
[2026-05-19 09:26:19] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_wutlbzb5.prg
[2026-05-19 09:26:19] [INFO] Timeout configurado: 300 segundos
[2026-05-19 09:26:25] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-19 09:26:25] [INFO] VFP9 finalizado em 6.175698 segundos
[2026-05-19 09:26:25] [INFO] Exit Code: 
[2026-05-19 09:26:25] [INFO] 
[2026-05-19 09:26:25] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-19 09:26:25] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_wutlbzb5.prg
[2026-05-19 09:26:25] [INFO] 
[2026-05-19 09:26:25] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-19 09:26:25] [INFO] * Auto-generated wrapper for parameters
[2026-05-19 09:26:25] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-19 09:26:25] [INFO] * Parameters: 'Formsigrecrt', 'C:\4c\tasks\task068', 'REPORT'
[2026-05-19 09:26:25] [INFO] 
[2026-05-19 09:26:25] [INFO] * Anti-dialog protections for unattended execution
[2026-05-19 09:26:25] [INFO] SET SAFETY OFF
[2026-05-19 09:26:25] [INFO] SET RESOURCE OFF
[2026-05-19 09:26:25] [INFO] SET TALK OFF
[2026-05-19 09:26:25] [INFO] SET NOTIFY OFF
[2026-05-19 09:26:25] [INFO] SYS(2335, 0)
[2026-05-19 09:26:25] [INFO] 
[2026-05-19 09:26:25] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecrt', 'C:\4c\tasks\task068', 'REPORT'
[2026-05-19 09:26:25] [INFO] QUIT
[2026-05-19 09:26:25] [INFO] 
[2026-05-19 09:26:25] [INFO] === Fim do Wrapper.prg ===
[2026-05-19 09:26:25] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-05-19 09:27:27] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-19 09:27:27] [INFO] Config FPW: (nao fornecido)
[2026-05-19 09:27:27] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-19 09:27:27] [INFO] Timeout: 300 segundos
[2026-05-19 09:27:27] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pui0kjab.prg
[2026-05-19 09:27:27] [INFO] Conteudo do wrapper:
[2026-05-19 09:27:27] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrecrt', 'C:\4c\tasks\task068', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecrt', 'C:\4c\tasks\task068', 'REPORT'
QUIT

[2026-05-19 09:27:27] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pui0kjab.prg
[2026-05-19 09:27:27] [INFO] VFP output esperado em: C:\4c\tasks\task068\vfp_output.txt
[2026-05-19 09:27:27] [INFO] Executando Visual FoxPro 9...
[2026-05-19 09:27:27] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pui0kjab.prg
[2026-05-19 09:27:27] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pui0kjab.prg
[2026-05-19 09:27:27] [INFO] Timeout configurado: 300 segundos
[2026-05-19 09:27:33] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-19 09:27:33] [INFO] VFP9 finalizado em 5.4896987 segundos
[2026-05-19 09:27:33] [INFO] Exit Code: 
[2026-05-19 09:27:33] [INFO] 
[2026-05-19 09:27:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-19 09:27:33] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_pui0kjab.prg
[2026-05-19 09:27:33] [INFO] 
[2026-05-19 09:27:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-19 09:27:33] [INFO] * Auto-generated wrapper for parameters
[2026-05-19 09:27:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-19 09:27:33] [INFO] * Parameters: 'Formsigrecrt', 'C:\4c\tasks\task068', 'REPORT'
[2026-05-19 09:27:33] [INFO] 
[2026-05-19 09:27:33] [INFO] * Anti-dialog protections for unattended execution
[2026-05-19 09:27:33] [INFO] SET SAFETY OFF
[2026-05-19 09:27:33] [INFO] SET RESOURCE OFF
[2026-05-19 09:27:33] [INFO] SET TALK OFF
[2026-05-19 09:27:33] [INFO] SET NOTIFY OFF
[2026-05-19 09:27:33] [INFO] SYS(2335, 0)
[2026-05-19 09:27:33] [INFO] 
[2026-05-19 09:27:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecrt', 'C:\4c\tasks\task068', 'REPORT'
[2026-05-19 09:27:33] [INFO] QUIT
[2026-05-19 09:27:33] [INFO] 
[2026-05-19 09:27:33] [INFO] === Fim do Wrapper.prg ===
[2026-05-19 09:27:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigrecrt",
  "timestamp": "20260519092733",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "FormParaRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo FormParaRelatorio encontrado"
    },
    {
      "nome": "BotoesRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Visualizar=SIM Imprimir=SIM"
    },
    {
      "nome": "ModoVisualizar",
      "passou": true,
      "erro": "",
      "detalhes": "Propriedade this_cModoAtual configurada"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form REPORT com BtnIncluirClick sem navegacao por PageFrame (OK)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)",
      "detalhes": ""
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrt.prg):
*==============================================================================
* FORMSIGRECRT.PRG
* Relatorio de Cheques Da Carteira (SIGRECRT) - FASE 8/8 COMPLETO
*
* Herda de FormBase
* Tipo: REPORT (layout FLAT - sem PageFrame CRUD)
* BO:   sigrecrtBO (herda RelatorioBase)
* Migrado de: sigrecrt.SCX (frmrelatorio), original: 800x500
*==============================================================================

DEFINE CLASS Formsigrecrt AS FormBase

    Height      = 600
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

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""
    this_nPaginaAtual  = 1

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * INICIALIZARFORM - Cria estrutura base do form de relatorio FLAT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarPageFrame()

            THIS.this_oRelatorio = CREATEOBJECT("sigrecrtBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques Da Carteira", ;
                        "InicializarForm")
            ELSE
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarBotoes()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarCamposFiltro()

                THIS.AtualizarTitulosOpcao()
                THIS.LimparCampos()

                THIS.Visible   = .T.
                loc_lSucesso   = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGEFRAME - Propriedades de janela do form de relatorio
    *
    * REPORT usa layout FLAT: nao ha PageFrame de 2 abas como em forms CRUD.
    * Este metodo aplica as propriedades da janela (Caption, Picture, Icon,
    * comportamento) e prepara a area util para os containers que sao
    * adicionados diretamente ao Form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques Da Carteira"
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
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

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
                .Caption   = THIS.Caption
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
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CONFIGURARBOTOES - CommandGroup com 4 botoes (padrao frmrelatorio)
    * Geometria canonical: ButtonCount=4, Width=273, Height=80, BackStyle=0
    * Left=726 (proporcional ao form de 1000px), Top=6
    * Lefts internos: Btn1=5, Btn2=71, Btn3=137, Btn4=203 (incrementos de 66)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 6
            .Left          = 726
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

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
    * ALTERNARPAGINA - Controle de pagina (REPORT eh FLAT - 1 pagina logica)
    *
    * Form de relatorio nao tem PageFrame de 2 abas. Mantemos o contrato do
    * metodo para compatibilidade com FormBase e rastreamos em this_nPaginaAtual.
    * Se o caller solicitar a "pagina de lista" (1), delegamos para
    * ConfigurarPaginaLista() que reseta os filtros e devolve o foco para o
    * primeiro campo editavel - comportamento equivalente ao "voltar para
    * lista" de forms CRUD adaptado ao contexto de REPORT.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
        IF loc_nPagina < 1
            loc_nPagina = 1
        ENDIF
        THIS.this_nPaginaAtual = loc_nPagina
        IF loc_nPagina = 1
            THIS.ConfigurarPaginaLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINALISTA - Override: REPORT nao tem Page1 (Lista) de CRUD
    *
    * Forms de relatorio (frmrelatorio) usam layout FLAT, sem Page1/Page2 e
    * sem grid de lista. O equivalente conceitual da "Page1 - Lista" eh a
    * area de FILTROS ja configurada em ConfigurarCamposFiltro() (Fase 4
    * desta migracao). Este metodo eh mantido para compatibilidade com o
    * contrato esperado de FormBase e implementa o "voltar para a lista":
    *  - Reseta todos os filtros para os valores padrao (LimparCampos)
    *  - Re-aplica os titulos dinamicos do opt_nr_opcao (SigCdPac)
    *  - Esconde o OptionGroup opt_Bons quando o TipoRel nao for "BONS"
    *  - Devolve o foco para o primeiro campo editavel (data inicial)
    *==========================================================================
    PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nTipoRel
        TRY
            THIS.LimparCampos()
            THIS.AtualizarTitulosOpcao()

            IF PEMSTATUS(THIS, "cbo_4c_GetTipoRel", 5) ;
               AND PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
                loc_nTipoRel = THIS.cbo_4c_GetTipoRel.ListIndex
                THIS.obj_4c_Opt_Bons.Visible = (loc_nTipoRel = 4)
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
                IF VARTYPE(THIS.txt_4c__dt_inicial) = "O" ;
                   AND THIS.txt_4c__dt_inicial.Enabled ;
                   AND THIS.txt_4c__dt_inicial.Visible
                    THIS.txt_4c__dt_inicial.SetFocus()
                ENDIF
            ENDIF

            THIS.this_nPaginaAtual = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FORMPARARELATORIO - Transfere valores dos controles do form para o BO
    * Usa PEMSTATUS para cada controle (seguro em todas as fases de migracao)
    *
    * Controles mapeados (mapeamento.json):
    *   obj_4c_GetTipoDat    <- getTipoDat  (tipo data: 1=Vencimento, 2=Emissao)
    *   txt_4c__dt_inicial   <- get_dt_inicial
    *   txt_4c__dt_final     <- get_dt_final
    *   txt_4c__cd_empresa   <- get_cd_empresa
    *   txt_4c__ds_empresa   <- get_ds_empresa
    *   txt_4c_Juros         <- getJuros
    *   cbo_4c_GetTipoRel    <- GetTipoRel  (tipo relatorio: 1-5)
    *   obj_4c_Opt_nr_opcao  <- opt_nr_opcao (opcao nota: 1=Sim, 2=Nao, 3=Ambos)
    *   cbo_4c_Get_ordem     <- get_ordem   (ordem: 1=VALOR, 2=DATA VEN, 3=DATA OP)
    *   obj_4c_Opt_Bons      <- Opt_Bons    (1=Ativos, 2=Todos; visivel em TipoRel=4)
    *   txt_4c__cd_emi_grupo <- get_cd_emi_grupo
    *   txt_4c__ds_emi_grupo <- get_ds_emi_grupo
    *   txt_4c__cd_emi_conta <- get_cd_emi_conta
    *   txt_4c__ds_emi_conta <- get_ds_emi_conta
    *   txt_4c_CGrupoO       <- GetCGrupoO  (origem grupo)
    *   txt_4c_DGrupoO       <- GetDGrupoO  (origem grupo descricao)
    *   txt_4c_CContaO       <- GetCContaO  (origem conta)
    *   txt_4c_DContaO       <- GetDContaO  (origem conta descricao)
    *   txt_4c__cd_dep_grupo <- get_cd_dep_grupo
    *   txt_4c__ds_dep_grupo <- get_ds_dep_grupo
    *   txt_4c__cd_dep_conta <- get_cd_dep_conta
    *   txt_4c__ds_dep_conta <- get_ds_dep_conta
    *==========================================================================
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            *-- Tipo de data (OptionGroup: 1=Vencimento, 2=Emissao)
            IF PEMSTATUS(THIS, "obj_4c_GetTipoDat", 5)
                .this_nTipoDat = THIS.obj_4c_GetTipoDat.Value
            ENDIF
            *-- Periodo
            IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
                .this_dDtInicial = THIS.txt_4c__dt_inicial.Value
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__dt_final", 5)
                .this_dDtFinal = THIS.txt_4c__dt_final.Value
            ENDIF
            *-- Empresa
            IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
                .this_cCdEmpresa = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_empresa", 5)
                .this_cDsEmpresa = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
            ENDIF
            *-- Juros mensal (%)
            IF PEMSTATUS(THIS, "txt_4c_Juros", 5)
                .this_nJuros = THIS.txt_4c_Juros.Value
            ENDIF
            *-- Tipo de relatorio (ComboBox ListIndex: 1=ATIVOS, 2=BAIXADOS, 3=NEG.PG, 4=BONS, 5=DEVOLVIDOS)
            IF PEMSTATUS(THIS, "cbo_4c_GetTipoRel", 5)
                .this_nTipoRel = THIS.cbo_4c_GetTipoRel.ListIndex
            ENDIF
            *-- Opcao nota (OptionGroup: 1=Sim, 2=Nao, 3=Ambos)
            IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
                .this_nNrOpcao = THIS.obj_4c_Opt_nr_opcao.Value
            ENDIF
            *-- Ordem de classificacao (ComboBox ListIndex: 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO)
            IF PEMSTATUS(THIS, "cbo_4c_Get_ordem", 5)
                .this_nIndexOrdem = THIS.cbo_4c_Get_ordem.ListIndex
            ENDIF
            *-- Opcao bons (OptionGroup: 1=Ativos, 2=Todos; visivel apenas quando TipoRel=4)
            IF PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
                .this_nOptBons = THIS.obj_4c_Opt_Bons.Value
            ENDIF
            *-- Emissor/Carteira: grupo e conta
            IF PEMSTATUS(THIS, "txt_4c__cd_emi_grupo", 5)
                .this_cCdEmiGrupo = ALLTRIM(THIS.txt_4c__cd_emi_grupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_emi_grupo", 5)
                .this_cDsEmiGrupo = ALLTRIM(THIS.txt_4c__ds_emi_grupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__cd_emi_conta", 5)
                .this_cCdEmiConta = ALLTRIM(THIS.txt_4c__cd_emi_conta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_emi_conta", 5)
                .this_cDsEmiConta = ALLTRIM(THIS.txt_4c__ds_emi_conta.Value)
            ENDIF
            *-- Origem: grupo e conta (GetCGrupoO / GetDGrupoO / GetCContaO / GetDContaO)
            IF PEMSTATUS(THIS, "txt_4c_CGrupoO", 5)
                .this_cCdOriGrupo = ALLTRIM(THIS.txt_4c_CGrupoO.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DGrupoO", 5)
                .this_cDsOriGrupo = ALLTRIM(THIS.txt_4c_DGrupoO.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CContaO", 5)
                .this_cCdOriConta = ALLTRIM(THIS.txt_4c_CContaO.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DContaO", 5)
                .this_cDsOriConta = ALLTRIM(THIS.txt_4c_DContaO.Value)
            ENDIF
            *-- Destino/Deposito: grupo e conta
            IF PEMSTATUS(THIS, "txt_4c__cd_dep_grupo", 5)
                .this_cCdDesGrupo = ALLTRIM(THIS.txt_4c__cd_dep_grupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_dep_grupo", 5)
                .this_cDsDesGrupo = ALLTRIM(THIS.txt_4c__ds_dep_grupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__cd_dep_conta", 5)
                .this_cCdDesConta = ALLTRIM(THIS.txt_4c__cd_dep_conta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_dep_conta", 5)
                .this_cDsDesConta = ALLTRIM(THIS.txt_4c__ds_dep_conta.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Botao 1: Visualizar relatorio em tela (preview)
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
    * BTNEXCELCLICK - Botao 3: Exportar dados para Excel
    *==========================================================================
    PROCEDURE BtnExcelClick()
        LOCAL loc_lSucesso, loc_cArqXls
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                RETURN
            ENDIF
            IF USED("CsRelatorio")
                loc_cArqXls = SYS(2023) + "\SigReCrt_" + STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                SELECT CsRelatorio
                COPY TO (loc_cArqXls) TYPE XL5
                THIS.this_oRelatorio.LimparCursores()
                MsgInfo("Arquivo Excel gerado em: " + loc_cArqXls, "Excel")
                loc_lSucesso = .T.
            ELSE
                MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para exportar.", "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNCANCELARCLICK - Botao 4: Fechar o form (ESC / Sair)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNINCLUIRCLICK - Mapeia "Incluir" de CRUD para Visualizar em REPORT
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
    * BTNALTERARCLICK - Mapeia "Alterar" de CRUD para LimparCampos em REPORT
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        TRY
            THIS.LimparCampos()
            IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
                IF VARTYPE(THIS.txt_4c__dt_inicial) = "O"
                    THIS.txt_4c__dt_inicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCLUIRCLICK - Mapeia "Excluir" de CRUD para Encerrar em REPORT
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja encerrar o relat" + CHR(243) + "rio?", "Encerrar")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * LIMPARCAMPOS - Reseta todos os filtros para os valores padrao
    * Usa PEMSTATUS para ser seguro antes de ConfigurarCamposFiltro() (Fase 4)
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "obj_4c_GetTipoDat", 5)
            THIS.obj_4c_GetTipoDat.Value = 1
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
            THIS.txt_4c__dt_inicial.Value = DATE()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__dt_final", 5)
            THIS.txt_4c__dt_final.Value = DATE()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
            THIS.txt_4c__cd_empresa.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_empresa", 5)
            THIS.txt_4c__ds_empresa.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Juros", 5)
            THIS.txt_4c_Juros.Value = 0
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_GetTipoRel", 5)
            THIS.cbo_4c_GetTipoRel.ListIndex = 1
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
            THIS.obj_4c_Opt_nr_opcao.Value = 3
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_Get_ordem", 5)
            THIS.cbo_4c_Get_ordem.ListIndex = 1
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
            THIS.obj_4c_Opt_Bons.Value   = 1
            THIS.obj_4c_Opt_Bons.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_emi_grupo", 5)
            THIS.txt_4c__cd_emi_grupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_emi_grupo", 5)
            THIS.txt_4c__ds_emi_grupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_emi_conta", 5)
            THIS.txt_4c__cd_emi_conta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_emi_conta", 5)
            THIS.txt_4c__ds_emi_conta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CGrupoO", 5)
            THIS.txt_4c_CGrupoO.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DGrupoO", 5)
            THIS.txt_4c_DGrupoO.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CContaO", 5)
            THIS.txt_4c_CContaO.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DContaO", 5)
            THIS.txt_4c_DContaO.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_dep_grupo", 5)
            THIS.txt_4c__cd_dep_grupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_dep_grupo", 5)
            THIS.txt_4c__ds_dep_grupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_dep_conta", 5)
            THIS.txt_4c__cd_dep_conta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_dep_conta", 5)
            THIS.txt_4c__ds_dep_conta.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * ATUALIZARTITULOSOPCAO - Atualiza captions do opt_nr_opcao com titulos
    * dinamicos carregados de SigCdPac pelo BO em CarregarParametros()
    *==========================================================================
    PROCEDURE AtualizarTitulosOpcao()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
            IF VARTYPE(THIS.obj_4c_Opt_nr_opcao) = "O"
                WITH THIS.obj_4c_Opt_nr_opcao
                    .Buttons(1).Caption = THIS.this_oRelatorio.this_cTituloOpcao1
                    .Buttons(2).Caption = THIS.this_oRelatorio.this_cTituloOpcao2
                    .Buttons(3).Caption = THIS.this_oRelatorio.this_cTituloOpcao3
                ENDWITH
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * DESTROY - Libera BO e recursos (NAO usar Release no BO - Custom sem Release)
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADADOS - Cria controles de filtro: primeira metade
    * Mapeamento.json itens 1-17: getTipoDat, periodo, juros, operacao,
    * tipo-rel, nr_opcao, empresa, emissor-grupo e emissor-conta (codigo)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_cFonte
        loc_cFonte = "Tahoma"

        THIS.AddObject("obj_4c_GetTipoDat", "OptionGroup")
        WITH THIS.obj_4c_GetTipoDat
            .Top         = 104
            .Left        = 237
            .Width       = 157
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .ToolTipText = "Emiss" + CHR(227) + "o = a data de inclus" + CHR(227) + ;
                           "o da movimenta" + CHR(231) + CHR(227) + "o"
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Vencimento"
                .Left      = 0
                .Top       = 0
                .Width     = 78
                .Height    = 22
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Emiss" + CHR(227) + "o"
                .Left      = 80
                .Top       = 0
                .Width     = 72
                .Height    = 22
                .AutoSize  = .F.
                .FontName  = loc_cFonte
                .FontSize  = 9
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH THIS.lbl_4c_Lbl_empresa
            .Top       = 221
            .Left      = 183
            .Width     = 50
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Empresa :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top       = 135
            .Left      = 435
            .Width     = 123
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Juros :                  ao m" + CHR(234) + "s"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_empresa", "TextBox")
        WITH THIS.txt_4c__ds_empresa
            .Top       = 217
            .Left      = 270
            .Width     = 337
            .Height    = 20
            .MaxLength = 40
            .ReadOnly  = .T.
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(245, 245, 245)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Juros", "TextBox")
        WITH THIS.txt_4c_Juros
            .Top       = 131
            .Left      = 471
            .Width     = 45
            .Height    = 20
            .FontName  = loc_cFonte
            .FontSize  = 9
            .InputMask = "999.99"
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_empresa", "TextBox")
        WITH THIS.txt_4c__cd_empresa
            .Top       = 217
            .Left      = 237
            .Width     = 31
            .Height    = 20
            .MaxLength = 3
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH THIS.lbl_4c_Lbl_periodo
            .Top       = 136
            .Left      = 188
            .Width     = 45
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Per" + CHR(237) + "odo :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH THIS.txt_4c__dt_inicial
            .Top       = 132
            .Left      = 237
            .Width     = 80
            .Height    = 20
            .FontName  = loc_cFonte
            .FontSize  = 9
            .Format    = "D"
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH THIS.lbl_4c_Lbl_periodo_a
            .Top       = 136
            .Left      = 323
            .Width     = 8
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = CHR(225)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_final", "TextBox")
        WITH THIS.txt_4c__dt_final
            .Top       = 132
            .Left      = 336
            .Width     = 80
            .Height    = 20
            .FontName  = loc_cFonte
            .FontSize  = 9
            .Format    = "D"
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 193
            .Left      = 192
            .Width     = 41
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Ordem :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
        WITH THIS.lbl_4c_Lbl_operacao
            .Top       = 165
            .Left      = 177
            .Width     = 56
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_opcao", "Label")
        WITH THIS.lbl_4c_Lbl_opcao
            .Top       = 193
            .Left      = 382
            .Width     = 50
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Op" + CHR(231) + CHR(227) + "o : "
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Opt_nr_opcao", "OptionGroup")
        WITH THIS.obj_4c_Opt_nr_opcao
            .Top         = 189
            .Left        = 428
            .Width       = 192
            .Height      = 23
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 0
                .Top       = 0
                .Width     = 63
                .Height    = 21
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 65
                .Top       = 0
                .Width     = 63
                .Height    = 21
                .AutoSize  = .F.
                .FontName  = loc_cFonte
                .FontSize  = 9
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ambos"
                .Left      = 130
                .Top       = 0
                .Width     = 60
                .Height    = 21
                .AutoSize  = .F.
                .FontName  = loc_cFonte
                .FontSize  = 9
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        THIS.AddObject("txt_4c__cd_emi_grupo", "TextBox")
        WITH THIS.txt_4c__cd_emi_grupo
            .Top       = 261
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_emi_grupo", "TextBox")
        WITH THIS.txt_4c__ds_emi_grupo
            .Top         = 261
            .Left        = 319
            .Width       = 150
            .Height      = 20
            .MaxLength   = 20
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_emi_conta", "TextBox")
        WITH THIS.txt_4c__cd_emi_conta
            .Top       = 289
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.txt_4c__cd_empresa,   "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(THIS.txt_4c__ds_empresa,   "KeyPress", THIS, "TeclaDsEmpresa")
        BINDEVENT(THIS.txt_4c__cd_emi_grupo, "KeyPress", THIS, "TeclaCdEmiGrupo")
        BINDEVENT(THIS.txt_4c__ds_emi_grupo, "KeyPress", THIS, "TeclaDsEmiGrupo")
        BINDEVENT(THIS.txt_4c__cd_emi_conta, "KeyPress", THIS, "TeclaCdEmiConta")
        BINDEVENT(THIS.txt_4c__cd_empresa,   "DblClick", THIS, "DblClickCdEmpresa")
        BINDEVENT(THIS.txt_4c__cd_emi_grupo, "DblClick", THIS, "DblClickCdEmiGrupo")
        BINDEVENT(THIS.txt_4c__cd_emi_conta, "DblClick", THIS, "DblClickCdEmiConta")
    ENDPROC

    *==========================================================================
    * CONFIGURARCAMPOSFILTRO - Cria controles de filtro: segunda metade
    * Mapeamento.json itens 18-35: emi-conta-descricao, ordem, bons, tipo-rel,
    * dep-grupo, dep-conta, ori-grupo, ori-conta e todos os labels Say2-Say6
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_cFonte
        loc_cFonte = "Tahoma"

        THIS.AddObject("txt_4c__ds_emi_conta", "TextBox")
        WITH THIS.txt_4c__ds_emi_conta
            .Top         = 289
            .Left        = 319
            .Width       = 290
            .Height      = 20
            .MaxLength   = 50
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cbo_4c_Get_ordem", "ComboBox")
        WITH THIS.cbo_4c_Get_ordem
            .Top           = 188
            .Left          = 237
            .Width         = 134
            .Height        = 20
            .Style         = 2
            .RowSourceType = 1
            .RowSource     = "VALOR,DATA VENCIMENTO,DATA OPERA" + CHR(199) + CHR(195) + "O"
            .FontName      = loc_cFonte
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Opt_Bons", "OptionGroup")
        WITH THIS.obj_4c_Opt_Bons
            .Top         = 160
            .Left        = 378
            .Width       = 163
            .Height      = 22
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Ativos"
                .Left      = 0
                .Top       = 0
                .Width     = 78
                .Height    = 22
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Todos"
                .Left      = 80
                .Top       = 0
                .Width     = 78
                .Height    = 22
                .AutoSize  = .F.
                .FontName  = loc_cFonte
                .FontSize  = 9
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        THIS.AddObject("cbo_4c_GetTipoRel", "ComboBox")
        WITH THIS.cbo_4c_GetTipoRel
            .Top           = 160
            .Left          = 237
            .Width         = 134
            .Height        = 20
            .Style         = 2
            .RowSourceType = 1
            .RowSource     = "ATIVOS,BAIXADOS,NEG.PG,BONS,DEVOLVIDOS"
            .FontName      = loc_cFonte
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ToolTipText   = "ATIVOS=Entradas  BAIXADOS=Saidas  NEG.PG=Devolvidos " + ;
                             "BONS=Depositados Sem Devolvidos DEVOLVIDOS=Devolvidos"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_dep_grupo", "TextBox")
        WITH THIS.txt_4c__cd_dep_grupo
            .Top       = 372
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 404
            .Left      = 170
            .Width     = 63
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Conta Dest :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_dep_grupo", "TextBox")
        WITH THIS.txt_4c__ds_dep_grupo
            .Top         = 372
            .Left        = 319
            .Width       = 150
            .Height      = 20
            .MaxLength   = 20
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DGrupoO", "TextBox")
        WITH THIS.txt_4c_DGrupoO
            .Top         = 317
            .Left        = 319
            .Width       = 150
            .Height      = 20
            .MaxLength   = 20
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CContaO", "TextBox")
        WITH THIS.txt_4c_CContaO
            .Top       = 345
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_dep_conta", "TextBox")
        WITH THIS.txt_4c__cd_dep_conta
            .Top       = 400
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_dep_conta", "TextBox")
        WITH THIS.txt_4c__ds_dep_conta
            .Top         = 400
            .Left        = 319
            .Width       = 290
            .Height      = 20
            .MaxLength   = 50
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DContaO", "TextBox")
        WITH THIS.txt_4c_DContaO
            .Top         = 345
            .Left        = 319
            .Width       = 290
            .Height      = 20
            .MaxLength   = 50
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 293
            .Left      = 155
            .Width     = 78
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Conta/Emissor :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 376
            .Left      = 170
            .Width     = 63
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Grupo Dest :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 321
            .Left      = 172
            .Width     = 61
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Grupo Orig :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 265
            .Left      = 155
            .Width     = 78
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Grupo/Emissor :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_dep_conta", "Label")
        WITH THIS.lbl_4c_Lbl_dep_conta
            .Top       = 349
            .Left      = 172
            .Width     = 61
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Conta Orig :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CGrupoO", "TextBox")
        WITH THIS.txt_4c_CGrupoO
            .Top       = 317
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.cbo_4c_GetTipoRel,   "InteractiveChange", THIS, "MudarTipoRel")
        BINDEVENT(THIS.txt_4c__ds_emi_conta, "KeyPress", THIS, "TeclaDsEmiConta")
        BINDEVENT(THIS.txt_4c_CGrupoO,       "KeyPress", THIS, "TeclaCGrupoO")
        BINDEVENT(THIS.txt_4c_DGrupoO,       "KeyPress", THIS, "TeclaDGrupoO")
        BINDEVENT(THIS.txt_4c_CContaO,       "KeyPress", THIS, "TeclaCContaO")
        BINDEVENT(THIS.txt_4c_DContaO,       "KeyPress", THIS, "TeclaDContaO")
        BINDEVENT(THIS.txt_4c__cd_dep_grupo, "KeyPress", THIS, "TeclaCdDepGrupo")
        BINDEVENT(THIS.txt_4c__ds_dep_grupo, "KeyPress", THIS, "TeclaDsDepGrupo")
        BINDEVENT(THIS.txt_4c__cd_dep_conta, "KeyPress", THIS, "TeclaCdDepConta")
        BINDEVENT(THIS.txt_4c__ds_dep_conta, "KeyPress", THIS, "TeclaDsDepConta")
        BINDEVENT(THIS.txt_4c_CGrupoO,       "DblClick", THIS, "DblClickCGrupoO")
        BINDEVENT(THIS.txt_4c_CContaO,       "DblClick", THIS, "DblClickCContaO")
        BINDEVENT(THIS.txt_4c__cd_dep_grupo, "DblClick", THIS, "DblClickCdDepGrupo")
        BINDEVENT(THIS.txt_4c__cd_dep_conta, "DblClick", THIS, "DblClickCdDepConta")
    ENDPROC

    *==========================================================================
    * MUDARTIPORE - InteractiveChange do cbo_4c_GetTipoRel
    * Exibe obj_4c_Opt_Bons somente quando operacao=BONS (ListIndex=4)
    *==========================================================================
    PROCEDURE MudarTipoRel()
        IF PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
            THIS.obj_4c_Opt_Bons.Visible = (THIS.cbo_4c_GetTipoRel.ListIndex = 4)
        ENDIF
    ENDPROC

    *==========================================================================
    * TECLA* - Handlers de KeyPress (PUBLIC para BINDEVENT)
    * F4=115 / F5=116 abrem lookup; Enter=13 / Tab=9 validam codigo
    *==========================================================================
    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEmiGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
                "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta", "Emissor")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
                "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmiGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
                "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta", "Emissor")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEmiConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
                "txt_4c__ds_emi_conta", "Conta Emissor")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
                "txt_4c__ds_emi_conta")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmiConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
                "txt_4c__ds_emi_conta", "Conta Emissor")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCGrupoO(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
                "txt_4c_CContaO", "txt_4c_DContaO", "Origem")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
                "txt_4c_CContaO", "txt_4c_DContaO")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDGrupoO(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
                "txt_4c_CContaO", "txt_4c_DContaO", "Origem")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCContaO(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
                "txt_4c_DContaO", "Conta Origem")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
                "txt_4c_DContaO")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDContaO(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
                "txt_4c_DContaO", "Conta Origem")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdDepGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
                "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta", "Destino")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
                "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsDepGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
                "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta", "Destino")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdDepConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
                "txt_4c__ds_dep_conta", "Conta Destino")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
                "txt_4c__ds_dep_conta")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsDepConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
                "txt_4c__ds_dep_conta", "Conta Destino")
        ENDIF
    ENDPROC

    *==========================================================================
    * ABRIRLOOKUPEMPRESA - Busca empresa em sigcdemp (cemps/razas)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_cCodAtual
        loc_oBusca    = .NULL.
        loc_cCodAtual = ""
        TRY
            IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
                loc_cCodAtual = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "sigcdemp", "cursor_4c_Busca", "cemps", loc_cCodAtual, ;
                "Empresa", .F., .T., "")
            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar busca de empresa.", "AbrirLookupEmpresa")
            ELSE
                loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        THIS.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
                        THIS.txt_4c__ds_empresa.Value = ALLTRIM(razas)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupEmpresa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDARCDEMPRESA - Valida codigo digitado contra sigcdemp
    *==========================================================================
    PROTECTED PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cCod, loc_cDs, loc_nCount, loc_cSQL, loc_lEncontrou
        loc_cCod       = ""
        loc_cDs        = ""
        loc_lEncontrou = .F.
        TRY
            IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
                loc_cCod = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
                IF !EMPTY(loc_cCod)
                    loc_cSQL   = "SELECT razas FROM sigcdemp WHERE cemps = " + EscaparSQL(loc_cCod)
                    loc_nCount = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")
                    IF loc_nCount > 0 AND USED("cursor_4c_Valid")
                        IF RECCOUNT("cursor_4c_Valid") > 0
                            SELECT cursor_4c_Valid
                            loc_cDs        = ALLTRIM(razas)
                            loc_lEncontrou = .T.
                        ENDIF
                        USE IN cursor_4c_Valid
                    ENDIF
                    IF loc_lEncontrou
                        THIS.txt_4c__ds_empresa.Value = loc_cDs
                    ELSE
                        THIS.txt_4c__ds_empresa.Value = ""
                        THIS.AbrirLookupEmpresa()
                    ENDIF
                ELSE
                    THIS.txt_4c__ds_empresa.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdEmpresa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ABRIRLOOKUPGRUPO - Busca grupo em SigCdGcr (codigos/descrs)
    * Generico para emissor, origem e destino
    * Ao selecionar, limpa os campos de conta associados
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrupo(par_cCtrlCd, par_cCtrlDs, par_cCtrlCdConta, par_cCtrlDsConta, par_cTitulo)
        LOCAL loc_oBusca, loc_cCodAtual
        LOCAL loc_oCtrlCd, loc_oCtrlDs, loc_oCtrlCdConta, loc_oCtrlDsConta
        loc_oBusca    = .NULL.
        loc_cCodAtual = ""
        TRY
            loc_oCtrlCd      = EVALUATE("THIS." + par_cCtrlCd)
            loc_oCtrlDs      = EVALUATE("THIS." + par_cCtrlDs)
            loc_oCtrlCdConta = EVALUATE("THIS." + par_cCtrlCdConta)
            loc_oCtrlDsConta = EVALUATE("THIS." + par_cCtrlDsConta)
            loc_cCodAtual    = ALLTRIM(loc_oCtrlCd.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Busca", "codigos", loc_cCodAtual, ;
                par_cTitulo, .F., .T., "")
            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar busca de grupo.", "AbrirLookupGrupo")
            ELSE
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oCtrlCd.Value      = ALLTRIM(codigos)
                        loc_oCtrlDs.Value      = ALLTRIM(descrs)
                        loc_oCtrlCdConta.Value = ""
                        loc_oCtrlDsConta.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDARCDGRUPO - Valida codigo de grupo digitado contra SigCdGcr
    * Generico para emissor, origem e destino
    *==========================================================================
    PROTECTED PROCEDURE ValidarCdGrupo(par_cCtrlCd, par_cCtrlDs, par_cCtrlCdConta, par_cCtrlDsConta)
        LOCAL loc_oCtrlCd, loc_oCtrlDs, loc_oCtrlCdConta, loc_oCtrlDsConta
        LOCAL loc_cCod, loc_cDs, loc_nCount, loc_cSQL, loc_lEncontrou
        loc_cCod       = ""
        loc_cDs        = ""
        loc_lEncontrou = .F.
        TRY
            loc_oCtrlCd      = EVALUATE("THIS." + par_cCtrlCd)
            loc_oCtrlDs      = EVALUATE("THIS." + par_cCtrlDs)
            loc_oCtrlCdConta = EVALUATE("THIS." + par_cCtrlCdConta)
            loc_oCtrlDsConta = EVALUATE("THIS." + par_cCtrlDsConta)
            loc_cCod         = ALLTRIM(loc_oCtrlCd.Value)
            IF !EMPTY(loc_cCod)
                loc_cSQL   = "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod)
                loc_nCount = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")
                IF loc_nCount > 0 AND USED("cursor_4c_Valid")
                    IF RECCOUNT("cursor_4c_Valid") > 0
                        SELECT cursor_4c_Valid
                        loc_cDs        = ALLTRIM(descrs)
                        loc_lEncontrou = .T.
                    ENDIF
                    USE IN cursor_4c_Valid
                ENDIF
                IF loc_lEncontrou
                    loc_oCtrlDs.Value = loc_cDs
                ELSE
                    loc_oCtrlDs.Value      = ""
                    loc_oCtrlCdConta.Value = ""
                    loc_oCtrlDsConta.Value = ""
                    THIS.AbrirLookupGrupo(par_cCtrlCd, par_cCtrlDs, par_cCtrlCdConta, par_cCtrlDsConta, "Grupo")
                ENDIF
            ELSE
                loc_oCtrlDs.Value      = ""
                loc_oCtrlCdConta.Value = ""
                loc_oCtrlDsConta.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ABRIRLOOKUPCO NTA - Busca conta em SigCdCli (iclis/rclis)
    * Filtra por grupo via 9o parametro do FormBuscaAuxiliar (par_cFiltro)
    * Generico para emissor, origem e destino
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupConta(par_cCtrlGrupo, par_cCtrlCd, par_cCtrlDs, par_cTitulo)
        LOCAL loc_oBusca, loc_cCodAtual, loc_cGrupo, loc_cFiltro
        LOCAL loc_oCtrlGrupo, loc_oCtrlCd, loc_oCtrlDs
        loc_oBusca    = .NULL.
        loc_cCodAtual = ""
        loc_cGrupo    = ""
        loc_cFiltro   = ""
        TRY
            loc_oCtrlGrupo = EVALUATE("THIS." + par_cCtrlGrupo)
            loc_oCtrlCd    = EVALUATE("THIS." + par_cCtrlCd)
            loc_oCtrlDs    = EVALUATE("THIS." + par_cCtrlDs)
            loc_cGrupo     = ALLTRIM(loc_oCtrlGrupo.Value)
            loc_cCodAtual  = ALLTRIM(loc_oCtrlCd.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_Busca", "iclis", loc_cCodAtual, ;
                par_cTitulo, .F., .T., loc_cFiltro)
            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar busca de conta.", "AbrirLookupConta")
            ELSE
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oCtrlCd.Value = ALLTRIM(iclis)
                        loc_oCtrlDs.Value = ALLTRIM(rclis)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DBLCLICK* - Handlers de DblClick nos campos de codigo (PUBLIC para BINDEVENT)
    * Abrem o lookup correspondente, mesmo comportamento que F4/F5
    *==========================================================================
    PROCEDURE DblClickCdEmpresa()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    PROCEDURE DblClickCdEmiGrupo()
        THIS.AbrirLookupGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
            "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta", "Emissor")
    ENDPROC

    PROCEDURE DblClickCdEmiConta()
        THIS.AbrirLookupConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
            "txt_4c__ds_emi_conta", "Conta Emissor")
    ENDPROC

    PROCEDURE DblClickCGrupoO()
        THIS.AbrirLookupGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
            "txt_4c_CContaO", "txt_4c_DContaO", "Origem")
    ENDPROC

    PROCEDURE DblClickCContaO()
        THIS.AbrirLookupConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
            "txt_4c_DContaO", "Conta Origem")
    ENDPROC

    PROCEDURE DblClickCdDepGrupo()
        THIS.AbrirLookupGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
            "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta", "Destino")
    ENDPROC

    PROCEDURE DblClickCdDepConta()
        THIS.AbrirLookupConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
            "txt_4c__ds_dep_conta", "Conta Destino")
    ENDPROC

    *==========================================================================
    * BTNSALVARCLICK - Mapeia "Salvar" de CRUD para Imprimir em REPORT
    *
    * Forms REPORT (frmrelatorio) nao tem operacao Salvar - o "resultado" do
    * formulario eh o relatorio impresso. Delegamos para o fluxo de impressao,
    * que monta os filtros (FormParaRelatorio) e dispara o REPORT FORM via BO.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *==========================================================================
    * FORMPARABO - Wrapper de FormParaRelatorio (CRUD -> REPORT semantica)
    *
    * Em forms CRUD, FormParaBO transfere valores do form para o BusinessObject.
    * Em forms REPORT, o equivalente eh FormParaRelatorio (transfere filtros
    * para o RelatorioBase). Mantemos o contrato CRUD delegando para o metodo
    * de REPORT que faz o trabalho real.
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *==========================================================================
    * BOPARAFORM - Em REPORT, restaura tela de filtros para estado padrao
    *
    * Forms CRUD usam BOParaForm para carregar valores do BO nos controles
    * apos um Buscar. Forms REPORT nao tem registro persistido nem operacao
    * de Buscar; o equivalente conceitual eh "voltar a tela de filtros ao
    * estado padrao" - delegamos para LimparCampos + AtualizarTitulosOpcao.
    *==========================================================================
    PROCEDURE BOParaForm()
        TRY
            THIS.LimparCampos()
            THIS.AtualizarTitulosOpcao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CARREGARLISTA - Em REPORT, configura a tela de filtros (sem grid de lista)
    *
    * Forms CRUD usam CarregarLista para popular o grid de Page1 a partir de
    * Buscar() no BO. Forms REPORT nao tem grid de lista - a "lista" conceitual
    * eh a propria area de filtros que o usuario preenche para gerar o relatorio.
    * Este metodo eh mantido para compatibilidade com chamadas genericas do
    * FormBase e delega para ConfigurarPaginaLista (reset de filtros + foco).
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * VALIDARCDCONTA - Valida codigo de conta digitado contra SigCdCli
    * Filtra por grupo quando preenchido; generico para emissor, origem, destino
    *==========================================================================
    PROTECTED PROCEDURE ValidarCdConta(par_cCtrlGrupo, par_cCtrlCd, par_cCtrlDs)
        LOCAL loc_oCtrlGrupo, loc_oCtrlCd, loc_oCtrlDs
        LOCAL loc_cCod, loc_cGrupo, loc_cDs, loc_nCount, loc_cSQL, loc_lEncontrou
        loc_cCod       = ""
        loc_cGrupo     = ""
        loc_cDs        = ""
        loc_lEncontrou = .F.
        TRY
            loc_oCtrlGrupo = EVALUATE("THIS." + par_cCtrlGrupo)
            loc_oCtrlCd    = EVALUATE("THIS." + par_cCtrlCd)
            loc_oCtrlDs    = EVALUATE("THIS." + par_cCtrlDs)
            loc_cCod       = ALLTRIM(loc_oCtrlCd.Value)
            loc_cGrupo     = ALLTRIM(loc_oCtrlGrupo.Value)
            IF !EMPTY(loc_cCod)
                loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCod)
                loc_nCount = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")
                IF loc_nCount > 0 AND USED("cursor_4c_Valid")
                    IF RECCOUNT("cursor_4c_Valid") > 0
                        SELECT cursor_4c_Valid
                        loc_cDs        = ALLTRIM(rclis)
                        loc_lEncontrou = .T.
                    ENDIF
                    USE IN cursor_4c_Valid
                ENDIF
                IF loc_lEncontrou
                    loc_oCtrlDs.Value = loc_cDs
                ELSE
                    loc_oCtrlDs.Value = ""
                    THIS.AbrirLookupConta(par_cCtrlGrupo, par_cCtrlCd, par_cCtrlDs, "Conta")
                ENDIF
            ELSE
                loc_oCtrlDs.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdConta")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecrtBO.prg):
*==============================================================================
* SIGRECRTBO.PRG
* Business Object para Relatorio de Cheques Da Carteira (SIGRECRT)
* Herda de RelatorioBase
*
* Filtros:
*   - Tipo de data: 1=Vencimento, 2=Emissao
*   - Periodo (data inicial / data final)
*   - Empresa (codigo + descricao)
*   - Tipo de relatorio: 1=Ativos, 2=Baixados, 3=Neg.PG, 4=Bons, 5=Devolvidos
*   - Opcao nota: 1=Sim, 2=Nao, 3=Ambos
*   - Ordem: 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO
*   - Juros mensal (%)
*   - Opcao Bons: 1=Ativos, 2=Todos (visivel apenas em TipoRel=4)
*   - Emissor (grupo/conta)
*   - Origem (grupo/conta)
*   - Destino (grupo/conta)
* Tabelas: SigCcChm, SigChe, SigCdCli, SigCdOpt, SigCdPac, SigCdPam, SigCdEmp, SigCqLcm
*==============================================================================

DEFINE CLASS sigrecrtBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoFrx        = ""
    this_cTitulo            = ""

    *-- Nomes dos cursores principais
    this_cCursorDados       = "CsRelatorio"
    this_cCursorCabecalho   = "CsCabecalho"
    this_cCursorOperacoes   = "cursor_4c_SigCdOpt"

    *-- Filtro: tipo de data (1=Vencimento, 2=Emissao)
    this_nTipoDat           = 1

    *-- Filtro: periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro: empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Filtro: tipo relatorio (GetTipoRel.ListIndex)
    *-- 1=Ativos, 2=Baixados, 3=Neg.PG, 4=Bons, 5=Devolvidos
    this_nTipoRel           = 1

    *-- Filtro: opcao nota (opt_nr_opcao.Value): 1=Sim, 2=Nao, 3=Ambos
    this_nNrOpcao           = 3

    *-- Titulos dinamicos carregados de SigCdPac (captions do opt_nr_opcao)
    this_cTituloOpcao1      = "Sim"
    this_cTituloOpcao2      = "N" + CHR(227) + "o"
    this_cTituloOpcao3      = "Ambos"

    *-- Filtro: ordem de classificacao (get_ordem.ListIndex)
    *-- 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO
    this_nIndexOrdem        = 1

    *-- Filtro: taxa de juros mensal %
    this_nJuros             = 0

    *-- Filtro: opcao bons (Opt_Bons.Value): 1=Ativos, 2=Todos
    this_nOptBons           = 1

    *-- Tipo de juros de SigCdPam.JuroCarts: 1=Simples, 2=Compostos
    this_nJurosCarts        = 1

    *-- Filtro emissor/carteira
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *-- Filtro origem
    this_cCdOriGrupo        = ""
    this_cDsOriGrupo        = ""
    this_cCdOriConta        = ""
    this_cDsOriConta        = ""

    *-- Filtro destino/deposito
    this_cCdDesGrupo        = ""
    this_cDsDesGrupo        = ""
    this_cCdDesConta        = ""
    this_cDsDesConta        = ""

    *--------------------------------------------------------------------------
    * Init - Configura FRX, titulo, datas iniciais e carrega parametros auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cArquivoFrx = gc_4c_CaminhoReports + "SigReCrt.frx"
            THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Cheques Da Carteira"
            THIS.this_dDtInicial  = DATE()
            THIS.this_dDtFinal    = DATE()
            IF DODEFAULT()
                THIS.CarregarParametros()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdOpt (indexado), SigCdPac e SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Operacoes de cheque: necessario para filtros de tipo no PrepararDados
            loc_cSQL = "SELECT * FROM SigCdOpt"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpt")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar SigCdOpt"
            ELSE
                SELECT cursor_4c_SigCdOpt
                INDEX ON operacaos TAG operacaos
                GO TOP

                *-- Titulos das opcoes de nota (SigCdPac)
                loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdPac
                    GO TOP
                    THIS.this_cTituloOpcao1 = IIF(!EMPTY(ALLTRIM(TitOpcS)), ALLTRIM(TitOpcS), "Sim")
                    THIS.this_cTituloOpcao2 = IIF(!EMPTY(ALLTRIM(TitOpcN)), ALLTRIM(TitOpcN), "N" + CHR(227) + "o")
                    THIS.this_cTituloOpcao3 = IIF(!EMPTY(ALLTRIM(TitOpcA)), ALLTRIM(TitOpcA), "Ambos")
                    USE IN cursor_4c_SigCdPac
                ENDIF

                *-- Parametros de juros (SigCdPam.JuroCarts: 1=Simples, 2=Compostos)
                loc_cSQL = "SELECT JuroCarts FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdPam
                    GO TOP
                    THIS.this_nJurosCarts = IIF(!EOF(), NVL(JuroCarts, 1), 1)
                    USE IN cursor_4c_SigCdPam
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.CarregarParametros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros, executa e popula CsRelatorio/CsCabecalho
    * Replica o processamento() do form legado SIGRECRT
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_lOK
        LOCAL loc_nTipoDat, loc_dDtInicial, loc_dDtFinal
        LOCAL loc_cCdEmpresa, loc_cDsEmpresa, loc_nNrOpcao
        LOCAL loc_cCdEmiGrupo, loc_cDsEmiGrupo, loc_cCdEmiConta, loc_cDsEmiConta
        LOCAL loc_cCdOriGrupo, loc_cDsOriGrupo, loc_cCdOriConta, loc_cDsOriConta
        LOCAL loc_cCdDesGrupo, loc_cDsDesGrupo, loc_cCdDesConta, loc_cDsDesConta
        LOCAL loc_nTipoRel, loc_nJuros, loc_nIndexOrdem, loc_nOptBons
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta
        LOCAL loc_cVerOriGrupo, loc_cVerOriConta
        LOCAL loc_cVerDesGrupo, loc_cVerDesConta
        LOCAL loc_cVerOrdem, loc_cVerTipo
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cEmissor, loc_cDestino, loc_cOrigem
        LOCAL loc_cTipoD, loc_cSQL, loc_nResult
        LOCAL loc_nDias, loc_nTxDia, loc_nVJuros, loc_dVen, loc_dDat

        loc_lSucesso = .F.
        TRY
            loc_lOK = .T.

            *-- Copiar filtros das propriedades para variaveis locais
            *-- (necessario: ?var em SQLEXEC exige variaveis no escopo local/private)
            loc_nTipoDat    = THIS.this_nTipoDat
            loc_dDtInicial  = THIS.this_dDtInicial
            loc_dDtFinal    = THIS.this_dDtFinal
            loc_cCdEmpresa  = THIS.this_cCdEmpresa
            loc_cDsEmpresa  = THIS.this_cDsEmpresa
            loc_nNrOpcao    = THIS.this_nNrOpcao
            loc_cCdEmiGrupo = THIS.this_cCdEmiGrupo
            loc_cDsEmiGrupo = THIS.this_cDsEmiGrupo
            loc_cCdEmiConta = THIS.this_cCdEmiConta
            loc_cDsEmiConta = THIS.this_cDsEmiConta
            loc_cCdOriGrupo = THIS.this_cCdOriGrupo
            loc_cDsOriGrupo = THIS.this_cDsOriGrupo
            loc_cCdOriConta = THIS.this_cCdOriConta
            loc_cDsOriConta = THIS.this_cDsOriConta
            loc_cCdDesGrupo = THIS.this_cCdDesGrupo
            loc_cDsDesGrupo = THIS.this_cDsDesGrupo
            loc_cCdDesConta = THIS.this_cCdDesConta
            loc_cDsDesConta = THIS.this_cDsDesConta
            loc_nTipoRel    = THIS.this_nTipoRel
            loc_nJuros      = THIS.this_nJuros
            loc_nIndexOrdem = THIS.this_nIndexOrdem
            loc_nOptBons    = THIS.this_nOptBons

            *-- Clausulas WHERE para SQLEXEC (usa ?var para parametrizacao de data/string)
            loc_cVerData = IIF(loc_nTipoDat = 2, ;
                " and b.datas between ?loc_dDtInicial and ?loc_dDtFinal ", ;
                " and b.vencs between ?loc_dDtInicial and ?loc_dDtFinal ")
            loc_cVerEmpresa  = IIF(EMPTY(ALLTRIM(loc_cCdEmpresa)), "", ;
                                   " and a.emps = ?loc_cCdEmpresa ")
            loc_cVerOpcao    = IIF(loc_nNrOpcao = 1, ;
                                   " and not a.notas = '" + SPACE(6) + "' ", ;
                                   IIF(loc_nNrOpcao = 2, ;
                                       " and a.notas = '" + SPACE(6) + "' ", ;
                                       ""))
            loc_cVerEmiGrupo = IIF(EMPTY(ALLTRIM(loc_cCdEmiGrupo)), "", ;
                                   " and b.grupoT = ?loc_cCdEmiGrupo ")
            loc_cVerEmiConta = IIF(EMPTY(ALLTRIM(loc_cCdEmiConta)), "", ;
                                   " and b.contaT = ?loc_cCdEmiConta ")
            loc_cVerOriGrupo = IIF(EMPTY(ALLTRIM(loc_cCdOriGrupo)), "", ;
                                   " and e.grupoOs = ?loc_cCdOriGrupo ")
            loc_cVerOriConta = IIF(EMPTY(ALLTRIM(loc_cCdOriConta)), "", ;
                                   " and e.contaOs = ?loc_cCdOriConta ")
            loc_cVerDesGrupo = IIF(EMPTY(ALLTRIM(loc_cCdDesGrupo)), "", ;
                                   " and e.grupoDs = ?loc_cCdDesGrupo ")
            loc_cVerDesConta = IIF(EMPTY(ALLTRIM(loc_cCdDesConta)), "", ;
                                   " and e.contaDs = ?loc_cCdDesConta ")
            loc_cVerOrdem    = IIF(loc_nIndexOrdem = 1, " ORDER BY 2", ;
                                IIF(loc_nIndexOrdem = 2, " ORDER BY 3", " ORDER BY 4"))

            *-- Filtro de tipo de relatorio: subselects em cursor_4c_SigCdOpt (VFP local)
            DO CASE
            CASE loc_nTipoRel = 2
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='CR' and devolvidos = 'N'] + ;
                               [ and opants not in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'S'))]
            CASE loc_nTipoRel = 3
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'S')]
            CASE loc_nTipoRel = 4
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where devolvidos <> 'S' and ] + ;
                               IIF(loc_nOptBons = 1, [tipos='DB' And Ordens = 1], [0 = 0]) + [)]
                loc_cVerTipo = loc_cVerTipo + ;
                               [ and a.contat Not in(Select Iclis from cursor_4c_CliCqDev)]
            CASE loc_nTipoRel = 5
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where devolvidos = 'S')]
            OTHERWISE
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'N')]
            ENDCASE

            *-- Clientes com cheque devolvido (necessario para filtro tipo 4 - Bons)
            IF USED("cursor_4c_CliCqDev")
                USE IN cursor_4c_CliCqDev
            ENDIF
            loc_cSQL = "select distinct contat as iclis from sigche" + ;
                       " where umovs in (Select operacaos from SigCdOpt where devolvidos = 'S')"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliCqDev")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar lista de cheques devolvidos"
                loc_lOK = .F.
            ENDIF

            *-- Query principal: cheques com joins em clientes, lancamentos e movimentacoes
            IF loc_lOK
                IF USED("cursor_4c_SqlTmp0")
                    USE IN cursor_4c_SqlTmp0
                ENDIF
                loc_cSQL = "select a.nums, b.valors, b.vencs, b.datas as dtBai, b.datas as dtEmi," + ;
                           " b.grclis, b.iclis, c.rclis as rclisT, d.rclis as rclisO, f.rclis as rclisD," + ;
                           " b.bancos, b.agencias, b.ncontas, b.ncheques, a.numlotes," + ;
                           " b.emps, b.umovs, e.codigos, b.contat, b.grupot, a.valjuros, a.cotas" + ;
                           " from SigCcChm a left join sigcdcli c" + ;
                           " on a.grupot = c.grupos and a.contat = c.iclis," + ;
                           " SigChe b, sigcdcli d, SigCqLcm e, sigcdcli f" + ;
                           " where a.nums = b.nums" + ;
                           " and a.numlotes = e.numlotes" + ;
                           " and b.umovs = e.codigos" + ;
                           " and e.grupoos = d.grupos and e.contaos = d.iclis" + ;
                           " and e.grupods = f.grupos and e.contads = f.iclis" + ;
                           loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                           loc_cVerEmiGrupo + loc_cVerEmiConta + ;
                           loc_cVerOriGrupo + loc_cVerOriConta + ;
                           loc_cVerDesGrupo + loc_cVerDesConta + ;
                           " Order by a.nums, a.numlotes, b.datas, b.grclis, b.iclis," + ;
                           " b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques," + ;
                           " b.valors, b.emps, b.umovs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlTmp0")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados de cheques da carteira"
                    loc_lOK = .F.
                ENDIF
            ENDIF

            IF loc_lOK
                *-- Aplicar filtro de tipo via SELECT local VFP
                *-- (cursor_4c_SigCdOpt e cursor_4c_CliCqDev sao referenciados como VFP aliases)
                IF USED("CsRelatorio")
                    USE IN CsRelatorio
                ENDIF
                SELECT *, 0000000.00 AS cotasE, 0000000.00 AS valsai, 0000000.00 AS valent, ;
                       0000000.00 AS Dif, 0000000.00 AS valliq, SPACE(50) AS NomeCF ;
                    FROM cursor_4c_SqlTmp0 a WHERE 1=1 &loc_cVerTipo ;
                    INTO CURSOR CsRelatorio &loc_cVerOrdem. READWRITE

                *-- Buscar nome da empresa para o cabecalho
                loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cEmpresa)

                *-- Textos do cabecalho do relatorio
                loc_cTipoD = IIF(loc_nTipoDat = 1, "VENCIMENTO", "EMISSAO")
                DO CASE
                CASE loc_nTipoRel = 1
                    loc_cTitulo = "ATIVOS POR " + loc_cTipoD
                CASE loc_nTipoRel = 2
                    loc_cTitulo = "BAIXADOS POR " + loc_cTipoD
                CASE loc_nTipoRel = 3
                    loc_cTitulo = "NEG.PG"
                CASE loc_nTipoRel = 4
                    loc_cTitulo = "BONS"
                OTHERWISE
                    loc_cTitulo = "DEVOLVIDOS"
                ENDCASE

                loc_cPeriodo = IIF(loc_nTipoDat = 2, "Emiss" + CHR(227) + "o: ", "Vencimento: ") + ;
                               DTOC(loc_dDtInicial) + " " + CHR(224) + " " + DTOC(loc_dDtFinal) + ;
                               " - Empresa: " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmpresa)), "Geral", ;
                                   ALLTRIM(loc_cCdEmpresa) + " - " + ALLTRIM(loc_cDsEmpresa))
                loc_cEmissor = "Grupo/Conta Emissor  : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmiGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdEmiGrupo) + " - " + ALLTRIM(loc_cDsEmiGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmiConta)), "Todas", ;
                                   ALLTRIM(loc_cCdEmiConta) + " - " + ALLTRIM(loc_cDsEmiConta))
                loc_cDestino = "Grupo/Conta Destino  : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdDesGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdDesGrupo) + " - " + ALLTRIM(loc_cDsDesGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdDesConta)), "Todas", ;
                                   ALLTRIM(loc_cCdDesConta) + " - " + ALLTRIM(loc_cDsDesConta))
                loc_cOrigem  = "Grupo/Conta Origem   : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdOriGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdOriGrupo) + " - " + ALLTRIM(loc_cDsOriGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdOriConta)), "Todas", ;
                                   ALLTRIM(loc_cCdOriConta) + " - " + ALLTRIM(loc_cDsOriConta))

                *-- Cursor de cabecalho para o FRX
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                CREATE CURSOR CsCabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                           Operacao C(80), Emissor C(80), Destino C(80), Origem C(80))
                INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo, Emissor, Destino, Origem) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, ;
                            loc_cEmissor, loc_cDestino, loc_cOrigem)

                *-- Percorrer registros para calcular cotasE, valsai, Dif, valliq, juros
                SELECT CsRelatorio
                GO TOP
                SCAN
                    *-- Buscar cotas de entrada do cheque para calculo de diferencas
                    loc_cSQL = "select a.cotas, e.codigos from SigCcChm a, SigCqLcm e" + ;
                               " where a.numlotes = e.numlotes" + ;
                               " and a.bancos   ='" + ALLTRIM(CsRelatorio.bancos)   + "'" + ;
                               " and a.agencias ='" + ALLTRIM(CsRelatorio.agencias) + "'" + ;
                               " and a.ncontas  ='" + ALLTRIM(CsRelatorio.ncontas)  + "'" + ;
                               " and a.ncheques ='" + ALLTRIM(CsRelatorio.ncheques) + "'"
                    IF USED("cursor_4c_Cur1")
                        USE IN cursor_4c_Cur1
                    ENDIF
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cur1")

                    IF USED("cursor_4c_Cur2")
                        USE IN cursor_4c_Cur2
                    ENDIF
                    SELECT cotas FROM cursor_4c_Cur1 ;
                        WHERE codigos IN (SELECT operacaos FROM cursor_4c_SigCdOpt ;
                                          WHERE tipos = 'DB' AND devolvidos = 'N') ;
                        INTO CURSOR cursor_4c_Cur2
                    SELECT cursor_4c_Cur2
                    GO TOP
                    SELECT CsRelatorio
                    REPLACE cotasE WITH IIF(!EOF("cursor_4c_Cur2"), cursor_4c_Cur2.cotas, 1.00) ;
                        IN CsRelatorio
                    REPLACE rclisT WITH IIF(ISNULL(rclisT), "", rclisT) IN CsRelatorio
                    REPLACE NomeCF WITH IIF(INLIST(loc_nTipoRel, 1, 3), rclisO, rclisD) IN CsRelatorio

                    DO CASE
                    CASE loc_nTipoRel = 1 AND loc_nTipoDat = 2
                        REPLACE valjuros WITH 0 IN CsRelatorio
                        REPLACE valsai   WITH 0 IN CsRelatorio
                        REPLACE Dif      WITH ROUND(valors / cotas, 2) IN CsRelatorio
                        REPLACE valliq   WITH 0 IN CsRelatorio
                        REPLACE dtBai    WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 1 AND loc_nTipoDat = 1
                        REPLACE valsai WITH 0 IN CsRelatorio
                        REPLACE Dif    WITH ROUND(valors / cotas, 2) IN CsRelatorio
                        REPLACE valliq WITH 0 IN CsRelatorio
                        REPLACE dtBai  WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 2
                        REPLACE valsai WITH ROUND(valjuros / cotas, 2) IN CsRelatorio
                        REPLACE valent WITH ROUND(valjuros / cotasE, 2) IN CsRelatorio
                        REPLACE Dif    WITH valsai - valent IN CsRelatorio
                        REPLACE valliq WITH valsai + Dif IN CsRelatorio
                        REPLACE dtEmi  WITH CTOD("  /  /  ") IN CsRelatorio
                        REPLACE vencs  WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 4 AND loc_nOptBons = 1
                        REPLACE dtBai WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 4 AND loc_nOptBons = 2
                        IF SEEK(CsRelatorio.umovs, "cursor_4c_SigCdOpt", "operacaos")
                            IF cursor_4c_SigCdOpt.Ordens = 1
                                REPLACE dtBai WITH CTOD("  /  /  ")
                            ENDIF
                        ENDIF
                        SELECT CsRelatorio

                    CASE INLIST(loc_nTipoRel, 3, 5)
                        REPLACE vencs  WITH CsRelatorio.Vencs IN CsRelatorio
                        REPLACE valsai WITH ROUND(valjuros / cotas, 2) IN CsRelatorio
                        REPLACE Dif    WITH 0 IN CsRelatorio
                        REPLACE valliq WITH 0 IN CsRelatorio

                        IF loc_nJuros > 0
                            loc_dVen   = DATE()
                            loc_dDat   = TTOD(CsRelatorio.Vencs)
                            loc_nDias  = IIF(loc_dDat >= loc_dVen, 0, loc_dVen - loc_dDat)
                            loc_nTxDia = loc_nJuros / 30
                            IF THIS.this_nJurosCarts = 2
                                loc_nVJuros = ROUND(CsRelatorio.valors * ;
                                              (((1 + loc_nTxDia / 100) ^ (loc_nDias)) - 1), 2)
                            ELSE
                                loc_nVJuros = ROUND(CsRelatorio.valors * ;
                                              (loc_nJuros / 100) * (loc_nDias / 30), 2)
                            ENDIF
                            REPLACE ValJuros WITH loc_nVJuros IN CsRelatorio
                        ENDIF
                    ENDCASE
                ENDSCAN

                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT CsRelatorio
                REPORT FORM (THIS.this_cArquivoFrx) TO PRINTER PROMPT NOCONSOLE
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT CsRelatorio
                REPORT FORM (THIS.this_cArquivoFrx) PREVIEW NOCONSOLE
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    * Relatorios nao tem PK fisica - chave eh composta pelos filtros principais.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECRT|" + ;
                     STR(THIS.this_nTipoDat, 1) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     STR(THIS.this_nTipoRel, 1) + "|" + ;
                     STR(THIS.this_nNrOpcao, 1) + "|" + ;
                     STR(THIS.this_nIndexOrdem, 1) + "|" + ;
                     STR(THIS.this_nOptBons, 1) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmiGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmiConta) + "|" + ;
                     ALLTRIM(THIS.this_cCdOriGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdOriConta) + "|" + ;
                     ALLTRIM(THIS.this_cCdDesGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdDesConta)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros previamente salva.
    * par_cAliasCursor: alias do cursor com colunas TipoDat, DtInicial, DtFinal,
    *   CdEmpresa, DsEmpresa, TipoRel, NrOpcao, IndexOrdem, Juros, OptBons,
    *   CdEmiGrupo, DsEmiGrupo, CdEmiConta, DsEmiConta,
    *   CdOriGrupo, DsOriGrupo, CdOriConta, DsOriConta,
    *   CdDesGrupo, DsDesGrupo, CdDesConta, DsDesConta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".TipoDat") = "N"
                    THIS.this_nTipoDat = EVALUATE(loc_cAlias + ".TipoDat")
                ENDIF
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmpresa") = "C"
                    THIS.this_cCdEmpresa = EVALUATE(loc_cAlias + ".CdEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmpresa") = "C"
                    THIS.this_cDsEmpresa = EVALUATE(loc_cAlias + ".DsEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".TipoRel") = "N"
                    THIS.this_nTipoRel = EVALUATE(loc_cAlias + ".TipoRel")
                ENDIF
                IF TYPE(loc_cAlias + ".NrOpcao") = "N"
                    THIS.this_nNrOpcao = EVALUATE(loc_cAlias + ".NrOpcao")
                ENDIF
                IF TYPE(loc_cAlias + ".IndexOrdem") = "N"
                    THIS.this_nIndexOrdem = EVALUATE(loc_cAlias + ".IndexOrdem")
                ENDIF
                IF TYPE(loc_cAlias + ".Juros") = "N"
                    THIS.this_nJuros = EVALUATE(loc_cAlias + ".Juros")
                ENDIF
                IF TYPE(loc_cAlias + ".OptBons") = "N"
                    THIS.this_nOptBons = EVALUATE(loc_cAlias + ".OptBons")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmiGrupo") = "C"
                    THIS.this_cCdEmiGrupo = EVALUATE(loc_cAlias + ".CdEmiGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmiGrupo") = "C"
                    THIS.this_cDsEmiGrupo = EVALUATE(loc_cAlias + ".DsEmiGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmiConta") = "C"
                    THIS.this_cCdEmiConta = EVALUATE(loc_cAlias + ".CdEmiConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmiConta") = "C"
                    THIS.this_cDsEmiConta = EVALUATE(loc_cAlias + ".DsEmiConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdOriGrupo") = "C"
                    THIS.this_cCdOriGrupo = EVALUATE(loc_cAlias + ".CdOriGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsOriGrupo") = "C"
                    THIS.this_cDsOriGrupo = EVALUATE(loc_cAlias + ".DsOriGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdOriConta") = "C"
                    THIS.this_cCdOriConta = EVALUATE(loc_cAlias + ".CdOriConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsOriConta") = "C"
                    THIS.this_cDsOriConta = EVALUATE(loc_cAlias + ".DsOriConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdDesGrupo") = "C"
                    THIS.this_cCdDesGrupo = EVALUATE(loc_cAlias + ".CdDesGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsDesGrupo") = "C"
                    THIS.this_cDsDesGrupo = EVALUATE(loc_cAlias + ".DsDesGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdDesConta") = "C"
                    THIS.this_cCdDesConta = EVALUATE(loc_cAlias + ".CdDesConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsDesConta") = "C"
                    THIS.this_cDsDesConta = EVALUATE(loc_cAlias + ".DsDesConta")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("cursor_4c_SqlTmp0")
            USE IN cursor_4c_SqlTmp0
        ENDIF
        IF USED("cursor_4c_CliCqDev")
            USE IN cursor_4c_CliCqDev
        ENDIF
        IF USED("cursor_4c_Cur1")
            USE IN cursor_4c_Cur1
        ENDIF
        IF USED("cursor_4c_Cur2")
            USE IN cursor_4c_Cur2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro registrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores permanentes e libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        IF USED("cursor_4c_SigCdOpt")
            USE IN cursor_4c_SigCdOpt
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

