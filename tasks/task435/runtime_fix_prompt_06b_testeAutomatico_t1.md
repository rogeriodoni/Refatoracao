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
[06/08/2026 09:00:14 PM] Erro Init: Erro em FormFUN.InicializarForm: Alias 'CURSOR_4C_DADOS' is not found. | Linha: 576


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-06 20:59:13] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 20:59:13] [INFO] Config FPW: (nao fornecido)
[2026-08-06 20:59:13] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 20:59:13] [INFO] Timeout: 300 segundos
[2026-08-06 20:59:13] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5pcn2twe.prg
[2026-08-06 20:59:13] [INFO] Conteudo do wrapper:
[2026-08-06 20:59:13] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFUN', 'C:\4c\tasks\task435', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFUN', 'C:\4c\tasks\task435', 'CRUD'
QUIT

[2026-08-06 20:59:13] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5pcn2twe.prg
[2026-08-06 20:59:13] [INFO] VFP output esperado em: C:\4c\tasks\task435\vfp_output.txt
[2026-08-06 20:59:13] [INFO] Executando Visual FoxPro 9...
[2026-08-06 20:59:13] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5pcn2twe.prg
[2026-08-06 20:59:13] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5pcn2twe.prg
[2026-08-06 20:59:13] [INFO] Timeout configurado: 300 segundos
[2026-08-06 21:00:14] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 21:00:14] [INFO] VFP9 finalizado em 60.1527155 segundos
[2026-08-06 21:00:14] [INFO] Exit Code: 
[2026-08-06 21:00:14] [INFO] 
[2026-08-06 21:00:14] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 21:00:14] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5pcn2twe.prg
[2026-08-06 21:00:14] [INFO] 
[2026-08-06 21:00:14] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 21:00:14] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 21:00:14] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 21:00:14] [INFO] * Parameters: 'FormFUN', 'C:\4c\tasks\task435', 'CRUD'
[2026-08-06 21:00:14] [INFO] 
[2026-08-06 21:00:14] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 21:00:14] [INFO] SET SAFETY OFF
[2026-08-06 21:00:14] [INFO] SET RESOURCE OFF
[2026-08-06 21:00:14] [INFO] SET TALK OFF
[2026-08-06 21:00:14] [INFO] SET NOTIFY OFF
[2026-08-06 21:00:14] [INFO] SYS(2335, 0)
[2026-08-06 21:00:14] [INFO] 
[2026-08-06 21:00:14] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFUN', 'C:\4c\tasks\task435', 'CRUD'
[2026-08-06 21:00:14] [INFO] QUIT
[2026-08-06 21:00:14] [INFO] 
[2026-08-06 21:00:14] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 21:00:14] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFUN",
  "timestamp": "20260806210014",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFUN.prg):
*==============================================================================
* FormFUN.prg - Formulario Cadastro de Fundicoes (SIGCDFUN)
* Arquitetura: FormBase -> FUNBO -> DataAccess (SQL Server)
* Tabelas: SIGCDFUN (cabecalho) + SigCdFud (detalhe tubos)
*==============================================================================

DEFINE CLASS FormFUN AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Fundi" + CHR(231) + CHR(245) + "es"
    BackColor   = RGB(100, 100, 100)
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Estado dos filtros da Lista
    this_cPEmps   = ""
    this_dDtIni   = {}
    this_dDtFim   = {}
    this_cAntEmpr = ""
    this_dAntDtI  = {}
    this_dAntDtF  = {}

    *-- Controle operacional dos tubos
    this_nMaqTubos  = 0
    this_nTuboAtual = 0

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("FUNBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar FUNBO.", "Erro Init")
                loc_lSucesso = .F.
            ELSE
                *-- Criar cursores de trabalho locais (DataSession=2 privada)
                SET SAFETY OFF
                SET NULL ON

                CREATE CURSOR TmpCera ( ;
                    Tubos    N(2,0),   ;
                    BCeras   N(12,2),  ;
                    Bases    N(12,2),  ;
                    Ceras    N(12,2),  ;
                    PMetals  N(12,2),  ;
                    CodCors  C(4)  NULL, ;
                    Obss     M     NULL, ;
                    TempMets C(15) NULL, ;
                    TempAmbs C(15) NULL, ;
                    TempTubs C(15) NULL, ;
                    TempAgus C(15) NULL, ;
                    CodArvs  C(10) NULL, ;
                    Descs    C(40) NULL, ;
                    Formulas M     NULL, ;
                    MetalNvs N(12,2),  ;
                    pmetalrs N(12,2),  ;
                    nStatus  N(1,0)    ;
                )
                INDEX ON STR(Tubos, 2) TAG Tubos

                CREATE CURSOR TmpTrf ( ;
                    Dopes    C(20),  ;
                    Numes    N(6,0), ;
                    Tubos    N(2,0), ;
                    nNumes   N(10,0) ;
                )
                INDEX ON STR(Tubos, 2) + Dopes + STR(Numes, 6) TAG Tubos

                CREATE CURSOR TmpNop ( ;
                    Nops       N(10,0),  ;
                    Cpros      C(14),    ;
                    Qtds       N(10,3),  ;
                    Tubos      N(2,0),   ;
                    Qtdos      N(10,3),  ;
                    Numes      N(6,0),   ;
                    EmpDopNums C(29),    ;
                    DtEnts     D         ;
                )
                INDEX ON STR(Tubos, 2) + STR(Nops, 10) TAG Tubos

                SET NULL OFF

                *-- Carregar tipos de arvore para lookup local
                THIS.CarregarArvores()

                *-- Montar interface
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Valores iniciais dos filtros
                THIS.this_cPEmps  = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
                THIS.this_dDtIni  = DATE()
                THIS.this_dDtFim  = DATE()
                THIS.this_cAntEmpr = THIS.this_cPEmps
                THIS.this_dAntDtI  = THIS.this_dDtIni
                THIS.this_dAntDtF  = THIS.this_dDtFim

                *-- Preencher campos de filtro na tela
                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
                    .txt_4c_CdEmpresa.Value = THIS.this_cPEmps
                    .txt_4c_DtInicial.Value  = THIS.this_dDtIni
                    .txt_4c_DtFinal.Value    = THIS.this_dDtFim
                    .Visible     = .T.
                ENDWITH

                *-- Vincular eventos base
                BINDEVENT(THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.cmd_4c_Encerrar, ;
                    "Click", THIS, "BtnEncerrarClick")

                *-- Carregar lista inicial
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.InicializarForm: " + loc_oErro.Message + ;
                " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page1
            .Caption   = "Lista"
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page2
            .Caption   = "Dados"
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        IF FILE(gc_4c_CaminhoIcones + "fundo_cad_1003.jpg")
            THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDIF

        THIS.pgf_4c_Paginas.Visible = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * cnt_4c_Cabecalho - Faixa escura superior com titulo do form
        * Top canônico: 2 + 29 (compensação PageFrame) = 31
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de Fundi" + CHR(231) + CHR(245) + "es"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Fundi" + CHR(231) + CHR(245) + "es"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Botoes - Container botoes CRUD (Fase 4 adiciona os botoes)
        * Top canônico: 0 + 29 = 29; Left=542
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 370
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Saida - Botao Encerrar (padrao canonico)
        * Left=917, Width=90, cmd_4c_Encerrar Width=75, Height=75
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Periodo - Filtro empresa + periodo de datas
        * Original: top=119, left=12, width=421, height=36 -> comp +29 = 148
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
        WITH loc_oPagina.cnt_4c_Periodo
            .Top         = 148
            .Left        = 12
            .Width       = 421
            .Height      = 36
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Empresa
            .Caption   = "Empresa : "
            .Top       = 9
            .Left      = 14
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_CdEmpresa
            .Value     = ""
            .Top       = 6
            .Left      = 77
            .Width     = 35
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .Top       = 9
            .Left      = 174
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial
            .Value     = {}
            .Top       = 6
            .Left      = 231
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Ate
            .Caption   = CHR(224)
            .Top       = 9
            .Left      = 316
            .Width     = 10
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal
            .Value     = {}
            .Top       = 6
            .Left      = 329
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_CdEmpresa, "KeyPress", THIS, "EmpresaLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")

        *----------------------------------------------------------------------
        * cmd_4c_BtnAguarde - Mensagem de espera durante carregamento
        * Original: top=266, left=339, width=322, height=72, visible=false -> comp +29 = 295
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_BtnAguarde", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnAguarde
            .Caption   = "Aguarde!  Atualizando  Dados . . ."
            .Top       = 295
            .Left      = 339
            .Width     = 322
            .Height    = 72
            .FontName  = "Tahoma"
            .FontSize  = 11
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(200, 200, 200)
            .Enabled   = .F.
            .Visible   = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * txt_4c_Botao1 - TextBox display desabilitado na Lista
        * Original: Botao1 textbox, top=132, left=438, width=27, height=22 -> comp +29 = 161
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Botao1", "TextBox")
        WITH loc_oPagina.txt_4c_Botao1
            .Value     = ""
            .Top       = 161
            .Left      = 438
            .Width     = 27
            .Height    = 22
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Botoes ajuste Width para 5 botoes de 75px (5+75+5+75+...= 380)
        *----------------------------------------------------------------------
        loc_oPagina.cnt_4c_Botoes.Width = 390

        *----------------------------------------------------------------------
        * Botoes CRUD dentro de cnt_4c_Botoes
        *----------------------------------------------------------------------
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * grd_4c_Dados - Grade principal de listagem
        * Original: Grade.Top=157, Left=12, Width=944, Height=434 -> comp +29 = 186
        * ColumnCount DEVE ser setado FORA do WITH (nao cria colunas dentro do WITH)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.ColumnCount = 5
        WITH loc_oPagina.grd_4c_Dados
            .Top                = 186
            .Left               = 12
            .Width              = 944
            .Height             = 434
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 158, 162)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column1
            .ControlSource   = "cursor_4c_Dados.codigos"
            .Width           = 52
            .Alignment       = 2
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column2
            .ControlSource   = "cursor_4c_Dados.datas"
            .Width           = 75
            .Header1.Caption = "Data"
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column3
            .ControlSource   = "cursor_4c_Dados.usuars"
            .Width           = 80
            .Header1.Caption = "Usu" + CHR(225) + "rio"
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column4
            .ControlSource   = "cursor_4c_Dados.codmaqfs"
            .Width           = 80
            .Header1.Caption = "M" + CHR(225) + "quina"
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column5
            .ControlSource   = "cursor_4c_Dados.obss"
            .Width           = 330
            .Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- RecordSource APOS ControlSources: previne autobind por posicao de campo
        loc_oPagina.grd_4c_Dados.ColumnCount = 3
        loc_oPagina.grd_4c_Dados.RecordSource     = "cursor_4c_Dados"
        loc_oPagina.grd_4c_Dados.RecordSourceType = 1

        BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * cnt_4c_Salva - Botoes Confirmar/Cancelar (Fase 4 adiciona os botoes)
        * Canonico: Top=33, Left=842, Width=160, Height=85
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top           = 33
            .Left          = 842
            .Width         = 160
            .Height        = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Container2 - 24 checkboxes de tubos + opt_status (Fase 5)
        * Original: top=5, left=9, width=296, height=594 -> comp +29 = 34
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Container2", "Container")
        WITH loc_oPagina.cnt_4c_Container2
            .Top         = 34
            .Left        = 9
            .Width       = 296
            .Height      = 594
            .BackStyle   = 1
            .BackColor   = RGB(225, 225, 225)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Container1 - Dados principais: codigos, data, maquina, usuario (Fase 5)
        * Original: top=15, left=320, width=348, height=72 -> comp +29 = 44
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Container1", "Container")
        WITH loc_oPagina.cnt_4c_Container1
            .Top         = 44
            .Left        = 320
            .Width       = 348
            .Height      = 72
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Container5 - Conversao Cera/Metal (Fase 5)
        * Original: top=140, left=303, width=247, height=148 -> comp +29 = 169
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Container5", "Container")
        WITH loc_oPagina.cnt_4c_Container5
            .Top         = 169
            .Left        = 303
            .Width       = 247
            .Height      = 148
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Container3 - Secao O.P. com grades de NOP e Transformacoes (Fase 5)
        * Original: top=132, left=549, width=445, height=345 -> comp +29 = 161
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Container3", "Container")
        WITH loc_oPagina.cnt_4c_Container3
            .Top         = 161
            .Left        = 549
            .Width       = 445
            .Height      = 345
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Container6 - Temperaturas de fundicao e revestimento (Fase 5)
        * Original: top=300, left=303, width=247, height=126 -> comp +29 = 329
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Container6", "Container")
        WITH loc_oPagina.cnt_4c_Container6
            .Top         = 329
            .Left        = 303
            .Width       = 247
            .Height      = 126
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Container4 - Observacoes por tubo e observacao geral (Fase 5)
        * Original: top=479, left=311, width=679, height=118 -> comp +29 = 508
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Container4", "Container")
        WITH loc_oPagina.cnt_4c_Container4
            .Top         = 508
            .Left        = 311
            .Width       = 679
            .Height      = 118
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Total - Painel totais de metal (inicialmente oculto)
        * Original: cntTotal, top=202, left=246, width=508, height=200 -> comp +29 = 231
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Total", "Container")
        WITH loc_oPagina.cnt_4c_Total
            .Top         = 231
            .Left        = 246
            .Width       = 508
            .Height      = 200
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
            .BorderWidth = 1
            .Visible     = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * Botoes Confirmar/Cancelar dentro de cnt_4c_Salva
        * Original Grupo_Salva: Salva.Left=5, Cancelar.Left=88 (ambos Top=5)
        *----------------------------------------------------------------------
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.ConfigurarContainer1(loc_oPagina)
        THIS.ConfigurarContainer2(loc_oPagina)
        THIS.ConfigurarContainer3(loc_oPagina)
        THIS.ConfigurarContainer4(loc_oPagina)
        THIS.ConfigurarContainer5(loc_oPagina)
        THIS.ConfigurarContainer6(loc_oPagina)
        THIS.ConfigurarCntTotal(loc_oPagina)
        THIS.ConfigurarCamposPage2(loc_oPagina)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarArvores()
    *==========================================================================
        LOCAL loc_nResultado
        loc_nResultado = 0

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                *-- Sem conexao SQL durante validacao de UI - pular
            ELSE
                IF USED("cursor_4c_Arvores")
                    USE IN cursor_4c_Arvores
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT a.codigos, a.descs, a.formulas, a.percs," + ;
                    " a.tempmets, a.temptubs, a.tempambs, a.tempagus" + ;
                    " FROM sigcdarv a ORDER BY a.codigos", ;
                    "cursor_4c_Arvores")

                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar " + CHR(225) + "rvores:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.CarregarArvores: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    FUNCTION CarregarLista()
    *==========================================================================
        LOCAL loc_lSucesso, loc_cFiltro
        LOCAL loc_cEmps, loc_dDtIni, loc_dDtFim
        LOCAL loc_cDtIniSQL, loc_cDtFimSQL
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                *-- Ler filtros da tela
                loc_cEmps  = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_CdEmpresa.Value)
                loc_dDtIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
                loc_dDtFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value

                IF EMPTY(loc_cEmps)
                    loc_cEmps = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
                ENDIF
                IF EMPTY(loc_dDtIni)
                    loc_dDtIni = DATE()
                ENDIF
                IF EMPTY(loc_dDtFim)
                    loc_dDtFim = DATE()
                ENDIF

                THIS.this_cPEmps  = loc_cEmps
                THIS.this_dDtIni  = loc_dDtIni
                THIS.this_dDtFim  = loc_dDtFim
                THIS.this_cAntEmpr = loc_cEmps
                THIS.this_dAntDtI  = loc_dDtIni
                THIS.this_dAntDtF  = loc_dDtFim

                *-- Mostrar aguarde
                THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .T.
                THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Refresh()

                *-- Formatar datas para SQL Server DATETIME
                loc_cDtIniSQL = "'" + STUFF(STUFF(DTOS(loc_dDtIni), 5, 0, "-"), 8, 0, "-") + " 00:00:00'"
                loc_cDtFimSQL = "'" + STUFF(STUFF(DTOS(loc_dDtFim), 5, 0, "-"), 8, 0, "-") + " 23:59:59'"

                loc_cFiltro = "a.emps = " + EscaparSQL(loc_cEmps) + ;
                    " AND a.datas >= " + loc_cDtIniSQL + ;
                    " AND a.datas <= " + loc_cDtFimSQL

                loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)

                *-- Re-definir ControlSources apos Buscar() recriar cursor_4c_Dados (autobind por posicao)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
                    LOCAL loc_oGrd
                    loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                    loc_oGrd.ColumnCount = 5
                    loc_oGrd.RecordSource          = "cursor_4c_Dados"
                    loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.codigos"
                    loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.datas"
                    loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.usuars"
                    loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.codmaqfs"
                    loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.obss"
                ENDIF

                *-- Ocultar aguarde
                THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.CarregarLista: " + loc_oErro.Message, "Erro")
            TRY
                THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
            CATCH
            ENDTRY
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_i, loc_oObjeto, loc_cNome

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oObjeto) != "O"
                LOOP
            ENDIF

            loc_cNome = UPPER(loc_oObjeto.Name)

            *-- containers ocultos: recursao nos filhos mas nao altera Visible
            IF INLIST(loc_cNome, "CNT_4C_TOTAL", "CNT_4C_CABECALHO", "CNT_4C_SALVA")
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                loc_oObjeto.Visible = .T.
            ENDIF

            *-- PageFrame: iterar Pages
            IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                LOCAL loc_p
                FOR loc_p = 1 TO loc_oObjeto.PageCount
                    THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_p))
                ENDFOR
            ENDIF

            *-- Container/Page: recursao nos filhos
            IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                THIS.TornarControlesVisiveis(loc_oObjeto)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
    *==========================================================================
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.this_lEmEdicao  = .T.
            THIS.AlternarPagina(2)
            THIS.AtualizarEstadoControles()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BtnIncluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
        LOCAL loc_nCodigos, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro selecionado.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                loc_nCodigos = cursor_4c_Dados.codigos

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.this_lEmEdicao  = .T.
                    THIS.AlternarPagina(2)
                    THIS.ChkTubo(1)
                    THIS.AtualizarEstadoControles()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BtnAlterarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
        LOCAL loc_nCodigos, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro selecionado.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                loc_nCodigos = cursor_4c_Dados.codigos

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.this_lEmEdicao  = .F.
                    THIS.AlternarPagina(2)
                    THIS.ChkTubo(1)
                    THIS.AtualizarEstadoControles()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        LOCAL loc_nCodigos, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro selecionado.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                loc_nCodigos = cursor_4c_Dados.codigos

                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da fundi" + CHR(231) + ;
                    CHR(227) + "o " + TRANSFORM(loc_nCodigos) + "?", "Excluir")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
                        IF THIS.this_oBusinessObject.Excluir()
                            THIS.CarregarLista()
                            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
                                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                            ENDIF
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BtnExcluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *==========================================================================
        TRY
            THIS.CarregarLista()
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BtnBuscarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.SalvarDadosTubo()
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Salvo")
                THIS.this_lEmEdicao  = .F.
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                THIS.AtualizarEstadoControles()
                loc_lSucesso = .T.
            ELSE
                MsgErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao salvar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BtnSalvarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *==========================================================================
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso  = .F.
        loc_lContinuar = .T.

        IF THIS.this_lEmEdicao
            IF !MsgConfirma("Deseja cancelar a edi" + CHR(231) + CHR(227) + "o?", "Cancelar")
                loc_lContinuar = .F.
            ENDIF
        ENDIF

        IF loc_lContinuar
            TRY
                THIS.this_lEmEdicao  = .F.
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                THIS.AtualizarEstadoControles()
                loc_lSucesso = .T.
            CATCH TO loc_oErro
                MsgErro("Erro em FormFUN.BtnCancelarClick: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
    *==========================================================================
        LOCAL loc_lEmLista, loc_lEmEdicao, loc_oPg1, loc_oPg2, loc_lOk
        loc_lEmLista  = (THIS.this_cModoAtual = "LISTA")
        loc_lEmEdicao = !loc_lEmLista
        loc_lOk = TYPE("THIS.pgf_4c_Paginas") = "O" AND !ISNULL(THIS.pgf_4c_Paginas)

        TRY
            IF loc_lOk
                loc_oPg1 = THIS.pgf_4c_Paginas.Page1
                IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                        loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
                        loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
                        loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
                        loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
                        loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
                    ENDIF
                ENDIF

                loc_oPg2 = THIS.pgf_4c_Paginas.Page2
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                        loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
                            (loc_lEmEdicao AND THIS.this_cModoAtual != "VISUALIZAR")
                        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.AtualizarEstadoControles: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        TRY
            IF USED("TmpCera")
                USE IN TmpCera
            ENDIF
            IF USED("TmpTrf")
                USE IN TmpTrf
            ENDIF
            IF USED("TmpNop")
                USE IN TmpNop
            ENDIF
            IF USED("cursor_4c_Arvores")
                USE IN cursor_4c_Arvores
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_TubosFund")
                USE IN cursor_4c_TubosFund
            ENDIF
            IF USED("cursor_4c_BuscaAux")
                USE IN cursor_4c_BuscaAux
            ENDIF
            IF USED("cursor_4c_TmpTot")
                USE IN cursor_4c_TmpTot
            ENDIF
        CATCH
            *-- Silencioso no Destroy
        ENDTRY

        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer1(par_oPagina)
    *==========================================================================
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Container1

        *-- lbl_4c_FundNo (Say2): "Fundicao No :"
        loc_oCnt.AddObject("lbl_4c_FundNo", "Label")
        WITH loc_oCnt.lbl_4c_FundNo
            .Caption   = "Fundi" + CHR(231) + CHR(227) + "o N" + CHR(186) + " :"
            .Left      = 5
            .Top       = 10
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- txt_4c_Codigos (getCodigos): numero sequencial, somente leitura
        loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oCnt.txt_4c_Codigos
            .Value     = 0
            .InputMask = "999999"
            .MaxLength = 7
            .Left      = 96
            .Top       = 5
            .Width     = 52
            .Height    = 25
            .ReadOnly  = .T.
        ENDWITH

        *-- lbl_4c_MaquinaLabel (Say4): "Maquina :"
        loc_oCnt.AddObject("lbl_4c_MaquinaLabel", "Label")
        WITH loc_oCnt.lbl_4c_MaquinaLabel
            .Caption   = "M" + CHR(225) + "quina :"
            .Left      = 188
            .Top       = 10
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- txt_4c_Maq (GetMaq): codigo da maquina, lookup LostFocus -> ValidarMaquina
        loc_oCnt.AddObject("txt_4c_Maq", "TextBox")
        WITH loc_oCnt.txt_4c_Maq
            .Value     = ""
            .MaxLength = 10
            .Left      = 254
            .Top       = 5
            .Width     = 79
            .Height    = 25
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Maq, "KeyPress", THIS, "ValidarMaquina")

        *-- lbl_4c_DataLabel (Say3): "Data :"
        loc_oCnt.AddObject("lbl_4c_DataLabel", "Label")
        WITH loc_oCnt.lbl_4c_DataLabel
            .Caption   = "Data :"
            .Left      = 54
            .Top       = 41
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- txt_4c_Datas (getDatas): data da fundicao
        loc_oCnt.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oCnt.txt_4c_Datas
            .Value     = {}
            .MaxLength = 10
            .Left      = 96
            .Top       = 36
            .Width     = 79
            .Height    = 25
        ENDWITH

        *-- lbl_4c_UsuarioLabel (Say1): "Usuario :"
        loc_oCnt.AddObject("lbl_4c_UsuarioLabel", "Label")
        WITH loc_oCnt.lbl_4c_UsuarioLabel
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Left      = 192
            .Top       = 41
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- txt_4c_Usu (Getusu): usuario que registrou, sempre somente leitura
        loc_oCnt.AddObject("txt_4c_Usu", "TextBox")
        WITH loc_oCnt.txt_4c_Usu
            .Value     = ""
            .MaxLength = 10
            .Left      = 254
            .Top       = 36
            .Width     = 79
            .Height    = 25
            .ReadOnly  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer2(par_oPagina)
    *==========================================================================
        LOCAL loc_oCnt, loc_oChk, loc_cNomeChk, loc_n
        LOCAL loc_nRow, loc_nCol, loc_nLeft, loc_nTop, loc_cPic
        LOCAL ARRAY loc_aTops[6]
        LOCAL ARRAY loc_aLefts[4]

        loc_oCnt = par_oPagina.cnt_4c_Container2

        *-- Cor vermelha conforme legado (BackStyle=0 = transparente sobre fundo vermelho)
        loc_oCnt.BackColor = RGB(255, 0, 0)
        loc_oCnt.BackStyle = 0

        *-- lbl_4c_Tubos (Label1): cabecalho da secao de tubos
        loc_oCnt.AddObject("lbl_4c_Tubos", "Label")
        WITH loc_oCnt.lbl_4c_Tubos
            .Caption   = "\<Tubos"
            .Left      = 5
            .Top       = 1
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontBold  = .T.
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(210, 210, 210)
        ENDWITH

        *-- opt_4c_Status: OptionGroup 4 opcoes de status (Nenhum/Cera/Fundir/Peca)
        loc_oCnt.AddObject("opt_4c_Status", "OptionGroup")
        WITH loc_oCnt.opt_4c_Status
            .ButtonCount    = 4
            .Left           = 69
            .Top            = -3
            .Width          = 228
            .Height         = 25
            .AutoSize       = .T.
            .BackStyle      = 0
            .Buttons(1).Caption  = "Nenhum"
            .Buttons(1).Left     = 5
            .Buttons(1).Top      = 5
            .Buttons(1).AutoSize = .T.
            .Buttons(2).Caption  = "Cera"
            .Buttons(2).Left     = 72
            .Buttons(2).Top      = 5
            .Buttons(2).AutoSize = .T.
            .Buttons(3).Caption  = "Fundir"
            .Buttons(3).Left     = 120
            .Buttons(3).Top      = 5
            .Buttons(3).Width    = 54
            .Buttons(3).Height   = 15
            .Buttons(3).AutoSize = .T.
            .Buttons(3).FontName = "Verdana"
            .Buttons(3).FontSize = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).ForeColor = RGB(36, 84, 155)
            .Buttons(4).Caption  = "Pe" + CHR(231) + "a"
            .Buttons(4).Left     = 177
            .Buttons(4).Top      = 5
            .Buttons(4).Width    = 46
            .Buttons(4).Height   = 15
            .Buttons(4).AutoSize = .T.
            .Buttons(4).FontName = "Verdana"
            .Buttons(4).FontSize = 8
            .Buttons(4).BackStyle = 0
            .Buttons(4).ForeColor = RGB(36, 84, 155)
        ENDWITH
        BINDEVENT(loc_oCnt.opt_4c_Status, "InteractiveChange", THIS, "OptStatusChanged")

        *-- 24 CheckBoxes: grade 4 colunas x 6 linhas (Style=1 grafico, PicturePosition=13)
        *   Colunas  Left: 3, 76, 149, 222
        *   Linhas   Top:  20, 116, 212, 308, 404, 500
        loc_aTops[1]  = 20
        loc_aTops[2]  = 116
        loc_aTops[3]  = 212
        loc_aTops[4]  = 308
        loc_aTops[5]  = 404
        loc_aTops[6]  = 500
        loc_aLefts[1] = 3
        loc_aLefts[2] = 76
        loc_aLefts[3] = 149
        loc_aLefts[4] = 222

        FOR loc_n = 1 TO 24
            loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
            loc_nRow = INT((loc_n - 1) / 4) + 1
            loc_nCol = MOD(loc_n - 1, 4) + 1
            loc_nTop  = loc_aTops[loc_nRow]
            loc_nLeft = loc_aLefts[loc_nCol]

            DO CASE
                CASE loc_n = 1
                    loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
                CASE loc_n = 2
                    loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
                CASE loc_n = 3
                    loc_cPic = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
                OTHERWISE
                    loc_cPic = ""
            ENDCASE

            loc_oCnt.AddObject(loc_cNomeChk, "CheckBox")
            loc_oChk = EVALUATE("loc_oCnt." + loc_cNomeChk)
            WITH loc_oChk
                .Caption         = PADL(TRANSFORM(loc_n), 2, "0")
                .Style           = 1
                .PicturePosition = 13
                .Alignment       = 0
                .Top             = loc_nTop
                .Left            = loc_nLeft
                .Height          = 90
                .Width           = 70
                .FontName        = "Verdana"
                .FontSize        = 8
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Value           = 0
                .Tag             = "TUBE:" + TRANSFORM(loc_n)
            ENDWITH
            IF !EMPTY(loc_cPic) AND FILE(loc_cPic)
                loc_oCnt.Picture = loc_cPic
            ENDIF
            BINDEVENT(loc_oChk, "Click", THIS, "ChkTuboClick")
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE ChkTuboClick()
    *==========================================================================
        LOCAL loc_cTag, loc_nTubo

        TRY
            loc_cTag  = _VFP.ActiveForm.ActiveControl.Tag
            loc_nTubo = 0
            IF LEFT(loc_cTag, 5) = "TUBE:"
                loc_nTubo = VAL(SUBSTR(loc_cTag, 6))
            ENDIF
            IF loc_nTubo > 0
                THIS.ChkTubo(loc_nTubo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.ChkTuboClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE OptStatusChanged()
    *==========================================================================
        LOCAL loc_nStatus, loc_nMaqTubos, loc_n, loc_cNomeChk, loc_oCnt

        TRY
            loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
            loc_nStatus   = loc_oCnt.opt_4c_Status.Value
            loc_nMaqTubos = THIS.this_nMaqTubos

            FOR loc_n = 1 TO loc_nMaqTubos
                loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
                IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
                    IF loc_oCnt.Value = 1
                        SELECT TmpCera
                        SET ORDER TO Tubos
                        IF SEEK(STR(loc_n, 2))
                            DO CASE
                                CASE loc_nStatus = 1
                                    REPLACE nStatus WITH 1 IN TmpCera
                                    loc_oCnt.Picture = ""
                                CASE loc_nStatus = 2
                                    REPLACE nStatus WITH 2 IN TmpCera
                                    loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
                                CASE loc_nStatus = 3
                                    REPLACE nStatus WITH 3 IN TmpCera
                                    loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
                                CASE loc_nStatus = 4
                                    REPLACE nStatus WITH 4 IN TmpCera
                                    loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
                            ENDCASE
                        ENDIF
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.OptStatusChanged: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarMaquina(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cCodMaq, loc_nResultado, loc_nTubos, loc_oCnt1

        TRY
            loc_oCnt1   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
            loc_cCodMaq = ALLTRIM(loc_oCnt1.txt_4c_Maq.Value)

            IF EMPTY(loc_cCodMaq)
                THIS.this_nMaqTubos = 0
                THIS.AtualizarVisibilidadeCheckboxes(0)
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT m.codigos, m.tubos FROM SigCfMqf m WHERE m.codigos = " + ;
                    EscaparSQL(loc_cCodMaq), ;
                    "cursor_4c_BuscaMaq")

                loc_nTubos = 0
                IF loc_nResultado > 0 AND USED("cursor_4c_BuscaMaq") AND ;
                        RECCOUNT("cursor_4c_BuscaMaq") > 0
                    SELECT cursor_4c_BuscaMaq
                    loc_nTubos = cursor_4c_BuscaMaq.tubos
                    THIS.this_nMaqTubos = loc_nTubos
                    THIS.AtualizarVisibilidadeCheckboxes(loc_nTubos)
                ELSE
                    MsgAviso("M" + CHR(225) + "quina '" + loc_cCodMaq + ;
                        "' n" + CHR(227) + "o encontrada.", ;
                        "M" + CHR(225) + "quina")
                    loc_oCnt1.txt_4c_Maq.Value = ""
                    THIS.this_nMaqTubos = 0
                    THIS.AtualizarVisibilidadeCheckboxes(0)
                ENDIF

                IF USED("cursor_4c_BuscaMaq")
                    USE IN cursor_4c_BuscaMaq
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.ValidarMaquina: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AtualizarVisibilidadeCheckboxes(par_nMaqTubos)
    *==========================================================================
        LOCAL loc_oCnt, loc_n, loc_cNomeChk, loc_oChk

        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
            FOR loc_n = 1 TO 24
                loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
                IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
                    loc_oChk = EVALUATE("loc_oCnt." + loc_cNomeChk)
                    loc_oChk.Visible = (loc_n <= par_nMaqTubos)
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.AtualizarVisibilidadeCheckboxes: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ChkTubo(par_nTubo)
    *==========================================================================
        LOCAL loc_n, loc_nMaqTubos, loc_oCnt, loc_cNomeChk, loc_cPic

        TRY
            *-- Salvar dados do tubo anterior antes de trocar
            IF THIS.this_nTuboAtual > 0 AND THIS.this_nTuboAtual != par_nTubo
                THIS.SalvarDadosTubo()
            ENDIF

            THIS.this_nTuboAtual = par_nTubo
            loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
            loc_nMaqTubos = THIS.this_nMaqTubos

            *-- Atualizar caption do tubo corrente em Container4 (se lbl_4c_SayTubo existir)
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "lbl_4c_SayTubo", 5)
                IF par_nTubo > 0
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.lbl_4c_SayTubo.Caption = ;
                        "( " + PADL(TRANSFORM(par_nTubo), 2, "0") + " )"
                ELSE
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.lbl_4c_SayTubo.Caption = "( )"
                ENDIF
            ENDIF

            *-- Atualizar imagens dos checkboxes baseado em TmpTrf/TmpNop/TmpCera
            FOR loc_n = 1 TO loc_nMaqTubos
                loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
                IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
                    loc_cPic = ""

                    *-- Tubo com transformacao metalica em andamento
                    IF USED("TmpTrf") AND RECCOUNT("TmpTrf") > 0
                        SELECT TmpTrf
                        SET ORDER TO 0
                        LOCATE FOR TmpTrf.Tubos = loc_n
                        IF FOUND()
                            loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
                        ENDIF
                    ENDIF

                    *-- Tubo com peca pronta (ordem de producao concluida)
                    IF USED("TmpNop") AND RECCOUNT("TmpNop") > 0
                        SELECT TmpNop
                        SET ORDER TO 0
                        LOCATE FOR TmpNop.Tubos = loc_n
                        IF FOUND()
                            loc_cPic = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
                        ENDIF
                    ENDIF

                    *-- Tubo com status Cera (sem transformacao/nop)
                    IF EMPTY(loc_cPic) AND USED("TmpCera") AND RECCOUNT("TmpCera") > 0
                        SELECT TmpCera
                        SET ORDER TO Tubos
                        IF SEEK(STR(loc_n, 2)) AND TmpCera.nStatus = 2
                            loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
                        ENDIF
                    ENDIF

                    loc_oCnt.Picture = loc_cPic
                ENDIF
            ENDFOR

            *-- Carregar dados do tubo selecionado nas abas Container5/6/4 e Page2
            IF par_nTubo > 0 AND USED("TmpCera")
                loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
                loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
                loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
                loc_oPg2  = THIS.pgf_4c_Paginas.Page2

                SELECT TmpCera
                SET ORDER TO Tubos
                IF SEEK(STR(par_nTubo, 2))
                    *-- Container5: Cera/Metal
                    IF PEMSTATUS(loc_oCnt5, "txt_4c_Cor", 5)
                        loc_oCnt5.txt_4c_Cor.Value     = ALLTRIM(NVL(TmpCera.CodCors, ""))
                        loc_oCnt5.txt_4c_Basec.Value   = NVL(TmpCera.BCeras, 0)
                        loc_oCnt5.txt_4c_Base.Value    = NVL(TmpCera.Bases, 0)
                        loc_oCnt5.txt_4c_Cera.Value    = NVL(TmpCera.Ceras, 0)
                        loc_oCnt5.txt_4c_Metal.Value   = NVL(TmpCera.PMetals, 0)
                        loc_oCnt5.txt_4c_Mreal.Value   = NVL(TmpCera.pmetalrs, 0)
                        loc_oCnt5.txt_4c_metnovo.Value = NVL(TmpCera.MetalNvs, 0)
                    ENDIF
                    *-- Container6: Temperaturas
                    IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
                        loc_oCnt6.txt_4c_TempMet.Value = ALLTRIM(NVL(TmpCera.TempMets, ""))
                        loc_oCnt6.txt_4c_TempTub.Value = ALLTRIM(NVL(TmpCera.TempTubs, ""))
                        loc_oCnt6.txt_4c_TempAmb.Value = ALLTRIM(NVL(TmpCera.TempAmbs, ""))
                        loc_oCnt6.txt_4c_TempAgu.Value = ALLTRIM(NVL(TmpCera.TempAgus, ""))
                    ENDIF
                    *-- Container4: Observacao do tubo
                    IF PEMSTATUS(loc_oCnt4, "edt_4c_Obs", 5)
                        loc_oCnt4.edt_4c_Obs.Value = NVL(TmpCera.Obss, "")
                    ENDIF
                    *-- Page2: Tipo Arvore
                    IF PEMSTATUS(loc_oPg2, "txt_4c_codarvore", 5)
                        loc_oPg2.txt_4c_codarvore.Value  = ALLTRIM(NVL(TmpCera.CodArvs, ""))
                        loc_oPg2.txt_4c_descarvore.Value = ALLTRIM(NVL(TmpCera.Descs, ""))
                    ENDIF
                ELSE
                    THIS.LimparCamposTubo()
                ENDIF

                *-- Filtrar TmpNop e TmpTrf para o tubo corrente e atualizar grades
                IF USED("TmpNop")
                    SELECT TmpNop
                    SET ORDER TO Tubos
                    SET FILTER TO TmpNop.Tubos = THIS.this_nTuboAtual
                    GO TOP
                ENDIF
                IF USED("TmpTrf")
                    SELECT TmpTrf
                    SET ORDER TO Tubos
                    SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
                    GO TOP
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_Gradenop", 5)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_Gradenop.Refresh()
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
                ENDIF
            ELSE
                THIS.LimparCamposTubo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.ChkTubo " + TRANSFORM(par_nTubo) + ": " + ;
                loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE LimparCampos()
    *==========================================================================
        LOCAL loc_oCnt1, loc_oCnt2, loc_oCnt3, loc_n, loc_cNomeChk, loc_oChk

        TRY
            loc_oCnt1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
            loc_oCnt2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2

            *-- Limpar campos do cabecalho (Container1)
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Codigos", 5)
                loc_oCnt1.txt_4c_Codigos.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Datas", 5)
                loc_oCnt1.txt_4c_Datas.Value = {}
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Usu", 5)
                loc_oCnt1.txt_4c_Usu.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Maq", 5)
                loc_oCnt1.txt_4c_Maq.Value = ""
            ENDIF

            *-- Resetar OptionGroup e checkboxes (Container2)
            IF PEMSTATUS(loc_oCnt2, "opt_4c_Status", 5)
                loc_oCnt2.opt_4c_Status.Value = 1
            ENDIF

            FOR loc_n = 1 TO 24
                loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
                IF PEMSTATUS(loc_oCnt2, loc_cNomeChk, 5)
                    loc_oChk = EVALUATE("loc_oCnt2." + loc_cNomeChk)
                    loc_oChk.Value   = 0
                    loc_oChk.Picture = ""
                ENDIF
            ENDFOR

            *-- Zerar cursores de trabalho
            IF USED("TmpCera")
                ZAP IN TmpCera
            ENDIF
            IF USED("TmpTrf")
                ZAP IN TmpTrf
            ENDIF
            IF USED("TmpNop")
                ZAP IN TmpNop
            ENDIF

            THIS.this_nMaqTubos  = 0
            THIS.this_nTuboAtual = 0
            THIS.AtualizarVisibilidadeCheckboxes(0)

            *-- Limpar campos de entrada de Container3 se ja existem
            loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
            IF PEMSTATUS(loc_oCnt3, "txt_4c_Nop", 5)
                loc_oCnt3.txt_4c_Nop.Value  = 0
                loc_oCnt3.txt_4c_QtTb.Value = 0
                IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
                    loc_oCnt3.txt_4c_Qtd.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
                    loc_oCnt3.txt_4c_Pecas.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
                    loc_oCnt3.txt_4c_Operacao.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oCnt3, "txt_4c_Trf", 5)
                    loc_oCnt3.txt_4c_Trf.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oCnt3, "txt_4c_Tubo", 5)
                    loc_oCnt3.txt_4c_Tubo.Value = 0
                ENDIF
            ENDIF

            *-- Limpar observacao geral
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "edt_4c_ObsG", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.edt_4c_ObsG.Value = ""
            ENDIF

            THIS.LimparCamposTubo()

        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.LimparCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BOParaForm()
    *==========================================================================
        LOCAL loc_oBO, loc_oCnt1, loc_oCnt2, loc_nResultado, loc_nCodigos
        LOCAL loc_n, loc_cNomeChk, loc_cPic
        LOCAL loc_nTubo, loc_nBCeras, loc_nBases, loc_nCeras, loc_nPMetals
        LOCAL loc_cCodCors, loc_mObss, loc_cTmpMets, loc_cTmpAmbs
        LOCAL loc_cTmpTubs, loc_cTmpAgus, loc_cCodArvs, loc_cDescs
        LOCAL loc_mFormulas, loc_nMetalNvs, loc_nPmetalrs, loc_nNStatus

        TRY
            loc_oBO      = THIS.this_oBusinessObject
            loc_oCnt1    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
            loc_oCnt2    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
            loc_nCodigos = loc_oBO.this_nCodigos

            *-- Preencher Container1 com dados do cabecalho (SIGCDFUN)
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Codigos", 5)
                loc_oCnt1.txt_4c_Codigos.Value = loc_nCodigos
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Datas", 5)
                loc_oCnt1.txt_4c_Datas.Value = loc_oBO.this_dDatas
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Usu", 5)
                loc_oCnt1.txt_4c_Usu.Value = ALLTRIM(loc_oBO.this_cUsuars)
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Maq", 5)
                loc_oCnt1.txt_4c_Maq.Value = ALLTRIM(loc_oBO.this_cCodMaqfs)
            ENDIF

            *-- Numero de tubos da maquina -> visibilidade dos checkboxes
            THIS.this_nMaqTubos = loc_oBO.this_nNTubos
            THIS.AtualizarVisibilidadeCheckboxes(THIS.this_nMaqTubos)

            *-- Limpar cursores antes de recarregar
            IF USED("TmpCera")
                ZAP IN TmpCera
            ENDIF
            IF USED("TmpTrf")
                ZAP IN TmpTrf
            ENDIF
            IF USED("TmpNop")
                ZAP IN TmpNop
            ENDIF

            *-- Carregar detalhe dos tubos de SigCdFud para TmpCera
            IF loc_nCodigos > 0
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT d.tubos, d.bceras, d.bases," + ;
                    " CAST(0 AS NUMERIC(12,2)) AS ceras," + ;
                    " d.metals AS pmetals," + ;
                    " d.codcors, d.obss, d.tempmets, d.tempambs, d.temptubs," + ;
                    " d.tempagus, d.codarvs," + ;
                    " ISNULL(a.descs, '') AS descs," + ;
                    " ISNULL(a.formulas, '') AS formulas," + ;
                    " d.metalnvs, CAST(0 AS NUMERIC(12,2)) AS pmetalrs, d.nstatus" + ;
                    " FROM SigCdFud d" + ;
                    " LEFT JOIN SigCdArv a ON a.codigos = d.codarvs" + ;
                    " WHERE d.codigos = " + TRANSFORM(loc_nCodigos) + ;
                    " AND d.nops = 0 AND d.nnumes = 0" + ;
                    " ORDER BY d.tubos", ;
                    "cursor_4c_TubosFund")

                IF loc_nResultado > 0 AND USED("cursor_4c_TubosFund") AND ;
                        RECCOUNT("cursor_4c_TubosFund") > 0
                    SELECT cursor_4c_TubosFund
                    GO TOP
                    DO WHILE !EOF()
                        loc_nTubo     = cursor_4c_TubosFund.tubos
                        loc_nBCeras   = cursor_4c_TubosFund.bceras
                        loc_nBases    = cursor_4c_TubosFund.bases
                        loc_nCeras    = cursor_4c_TubosFund.ceras
                        loc_nPMetals  = cursor_4c_TubosFund.pmetals
                        loc_cCodCors  = cursor_4c_TubosFund.codcors
                        loc_mObss     = cursor_4c_TubosFund.obss
                        loc_cTmpMets  = cursor_4c_TubosFund.tempmets
                        loc_cTmpAmbs  = cursor_4c_TubosFund.tempambs
                        loc_cTmpTubs  = cursor_4c_TubosFund.temptubs
                        loc_cTmpAgus  = cursor_4c_TubosFund.tempagus
                        loc_cCodArvs  = cursor_4c_TubosFund.codarvs
                        loc_cDescs    = cursor_4c_TubosFund.descs
                        loc_mFormulas = cursor_4c_TubosFund.formulas
                        loc_nMetalNvs = cursor_4c_TubosFund.metalnvs
                        loc_nPmetalrs = cursor_4c_TubosFund.pmetalrs
                        loc_nNStatus  = cursor_4c_TubosFund.nstatus

                        INSERT INTO TmpCera (Tubos, BCeras, Bases, Ceras, PMetals, ;
                            CodCors, Obss, TempMets, TempAmbs, TempTubs, TempAgus, ;
                            CodArvs, Descs, Formulas, MetalNvs, pmetalrs, nStatus) ;
                        VALUES (loc_nTubo, loc_nBCeras, loc_nBases, loc_nCeras, ;
                            loc_nPMetals, loc_cCodCors, loc_mObss, loc_cTmpMets, ;
                            loc_cTmpAmbs, loc_cTmpTubs, loc_cTmpAgus, loc_cCodArvs, ;
                            loc_cDescs, loc_mFormulas, loc_nMetalNvs, loc_nPmetalrs, ;
                            loc_nNStatus)

                        SELECT cursor_4c_TubosFund
                        SKIP
                    ENDDO
                ENDIF
            ENDIF

            *-- Carregar TmpTrf de SigCdFud (nnumes <> 0 = linhas de transferencia)
            IF loc_nCodigos > 0
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT d.tubos, d.nnumes," + ;
                    " ISNULL(m.dopes, '') AS dopes" + ;
                    " FROM SigCdFud d" + ;
                    " LEFT JOIN SigMvCab m ON m.numes = d.nnumes" + ;
                    " WHERE d.codigos = " + TRANSFORM(loc_nCodigos) + ;
                    " AND d.nnumes <> 0" + ;
                    " ORDER BY d.tubos", ;
                    "cursor_4c_TrfFund")

                IF loc_nResultado > 0 AND USED("cursor_4c_TrfFund") AND ;
                        RECCOUNT("cursor_4c_TrfFund") > 0
                    SELECT cursor_4c_TrfFund
                    GO TOP
                    DO WHILE !EOF()
                        INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
                            VALUES (ALLTRIM(NVL(cursor_4c_TrfFund.dopes, "")), ;
                                    0, ;
                                    cursor_4c_TrfFund.tubos, ;
                                    cursor_4c_TrfFund.nnumes)
                        SELECT cursor_4c_TrfFund
                        SKIP
                    ENDDO
                ENDIF
                IF USED("cursor_4c_TrfFund")
                    USE IN cursor_4c_TrfFund
                ENDIF
            ENDIF

            *-- Carregar TmpNop de SigCdFud (nops <> 0 e nnumes = 0 = ordens de producao)
            IF loc_nCodigos > 0
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT d.tubos, d.nops, d.qtds, d.qtdos," + ;
                    " ISNULL(o.cpros, '') AS cpros," + ;
                    " ISNULL(o.numes, 0) AS numes," + ;
                    " ISNULL(CAST(o.dtents AS DATE), CAST(GETDATE() AS DATE)) AS dtents" + ;
                    " FROM SigCdFud d" + ;
                    " OUTER APPLY (SELECT TOP 1 oo.cpros, oo.numes, oo.dtents" + ;
                    " FROM SigOpPic oo WHERE oo.nops = d.nops" + ;
                    " AND oo.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))) + ;
                    ") o WHERE d.codigos = " + TRANSFORM(loc_nCodigos) + ;
                    " AND d.nops <> 0 AND d.nnumes = 0" + ;
                    " ORDER BY d.tubos, d.nops", ;
                    "cursor_4c_NopFund")

                IF loc_nResultado > 0 AND USED("cursor_4c_NopFund") AND ;
                        RECCOUNT("cursor_4c_NopFund") > 0
                    SELECT cursor_4c_NopFund
                    GO TOP
                    DO WHILE !EOF()
                        INSERT INTO TmpNop (Nops, Cpros, Qtds, Tubos, Qtdos, Numes, ;
                                            EmpDopNums, DtEnts) ;
                            VALUES (cursor_4c_NopFund.nops, ;
                                    ALLTRIM(NVL(cursor_4c_NopFund.cpros, "")), ;
                                    cursor_4c_NopFund.qtds, ;
                                    cursor_4c_NopFund.tubos, ;
                                    cursor_4c_NopFund.qtdos, ;
                                    cursor_4c_NopFund.numes, ;
                                    PADR(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, "")), 29), ;
                                    cursor_4c_NopFund.dtents)
                        SELECT cursor_4c_NopFund
                        SKIP
                    ENDDO
                ENDIF
                IF USED("cursor_4c_NopFund")
                    USE IN cursor_4c_NopFund
                ENDIF
            ENDIF

            *-- Carregar observacao geral
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "edt_4c_ObsG", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.edt_4c_ObsG.Value = ;
                    NVL(loc_oBO.this_mObsG, "")
            ENDIF

            *-- Atualizar imagens dos checkboxes baseado em TmpCera.nStatus
            IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
                SELECT TmpCera
                SET ORDER TO Tubos
                GO TOP
                DO WHILE !EOF()
                    loc_n = TmpCera.Tubos
                    IF loc_n >= 1 AND loc_n <= 24
                        loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
                        IF PEMSTATUS(loc_oCnt2, loc_cNomeChk, 5)
                            DO CASE
                                CASE TmpCera.nStatus = 2
                                    loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
                                CASE TmpCera.nStatus = 3
                                    loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
                                CASE TmpCera.nStatus = 4
                                    loc_cPic = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
                                OTHERWISE
                                    loc_cPic = ""
                            ENDCASE
                            loc_oCnt2.Picture = loc_cPic
                            loc_oCnt2.Value   = 1
                        ENDIF
                    ENDIF
                    SKIP
                ENDDO
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BOParaForm: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE FormParaBO()
    *==========================================================================
        LOCAL loc_oBO, loc_oCnt1

        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_oCnt1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1

            *-- Transferir campos editaveis do cabecalho para o BO
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Datas", 5)
                loc_oBO.this_dDatas = loc_oCnt1.txt_4c_Datas.Value
            ENDIF
            IF PEMSTATUS(loc_oCnt1, "txt_4c_Maq", 5)
                loc_oBO.this_cCodMaqfs = ALLTRIM(loc_oCnt1.txt_4c_Maq.Value)
            ENDIF

            *-- Usuario e empresa (preenchidos automaticamente)
            loc_oBO.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            loc_oBO.this_cEmps   = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))

            *-- Numero de tubos da maquina corrente
            loc_oBO.this_nNTubos = THIS.this_nMaqTubos

            *-- Observacao geral
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "edt_4c_ObsG", 5)
                loc_oBO.this_mObsG = ;
                    ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.edt_4c_ObsG.Value)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.FormParaBO: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer3(par_oPagina)
    *==========================================================================
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Container3

        loc_oCnt.AddObject("lbl_4c_SayNop", "Label")
        WITH loc_oCnt.lbl_4c_SayNop
            .Caption   = "O.P. n" + CHR(186) + " :"
            .Left      = 20
            .Top       = 6
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Nop", "TextBox")
        WITH loc_oCnt.txt_4c_Nop
            .Value     = 0
            .InputMask = "9999999999"
            .Left      = 73
            .Top       = 4
            .Width     = 94
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Nop, "KeyPress", THIS, "NopLostFocus")

        loc_oCnt.AddObject("lbl_4c_SayComp", "Label")
        WITH loc_oCnt.lbl_4c_SayComp
            .Caption   = "Componentes:"
            .Left      = 171
            .Top       = 6
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Qtd", "TextBox")
        WITH loc_oCnt.txt_4c_Qtd
            .Value     = 0
            .Left      = 260
            .Top       = 4
            .Width     = 87
            .Height    = 20
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_SayQtTb", "Label")
        WITH loc_oCnt.lbl_4c_SayQtTb
            .Caption   = "Qtde Tubo :"
            .Left      = 2
            .Top       = 27
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_QtTb", "TextBox")
        WITH loc_oCnt.txt_4c_QtTb
            .Value     = 0
            .InputMask = "9999999999.999"
            .Left      = 73
            .Top       = 25
            .Width     = 94
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_QtTb, "KeyPress", THIS, "QtTbLostFocus")

        loc_oCnt.AddObject("lbl_4c_SayPecas", "Label")
        WITH loc_oCnt.lbl_4c_SayPecas
            .Caption   = "Qtd. Pe" + CHR(231) + "as :"
            .Left      = 185
            .Top       = 27
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Pecas", "TextBox")
        WITH loc_oCnt.txt_4c_Pecas
            .Value     = 0
            .Left      = 260
            .Top       = 25
            .Width     = 87
            .Height    = 20
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
        ENDWITH

        loc_oCnt.AddObject("grd_4c_Gradenop", "Grid")
        loc_oCnt.grd_4c_Gradenop.ColumnCount = 5
        loc_oCnt.grd_4c_Gradenop.RecordSource = "TmpNop"
        WITH loc_oCnt.grd_4c_Gradenop
            .Top          = 48
            .Left         = 7
            .Width        = 435
            .Height       = 122
            .FontName     = "Tahoma"
            .FontSize     = 8
            .ReadOnly     = .T.
            .GridLines    = 1
            .HeaderHeight = 17
            .RowHeight    = 17
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        WITH loc_oCnt.grd_4c_Gradenop.Column1
            .Header1.Caption = "O.P."
            .ControlSource   = "TmpNop.Nops"
            .Width           = 60
        ENDWITH

        WITH loc_oCnt.grd_4c_Gradenop.Column2
            .Header1.Caption = "Produto"
            .ControlSource   = "TmpNop.Cpros"
            .Width           = 110
        ENDWITH

        WITH loc_oCnt.grd_4c_Gradenop.Column3
            .Header1.Caption = "Qtde"
            .ControlSource   = "TmpNop.Qtds"
            .Width           = 60
        ENDWITH

        WITH loc_oCnt.grd_4c_Gradenop.Column4
            .Header1.Caption = "Pedido"
            .ControlSource   = "TmpNop.Numes"
            .Width           = 50
        ENDWITH

        WITH loc_oCnt.grd_4c_Gradenop.Column5
            .Header1.Caption = "Data Entrega"
            .ControlSource   = "TmpNop.DtEnts"
            .Width           = 90
        ENDWITH
        BINDEVENT(loc_oCnt.grd_4c_Gradenop, "AfterRowColChange", THIS, "GradenopAfterRowColChange")

        loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
        WITH loc_oCnt.txt_4c_Operacao
            .Value     = ""
            .Left      = 18
            .Top       = 171
            .Width     = 290
            .Height    = 25
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_AdicionarNop", "CommandButton")
        WITH loc_oCnt.cmd_4c_AdicionarNop
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 4
            .Top             = 172
            .Left            = 384
            .Width           = 40
            .Height          = 40
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_AdicionarNop, "Click", THIS, "AdicionarNopClick")

        loc_oCnt.AddObject("lbl_4c_SayCopiar", "Label")
        WITH loc_oCnt.lbl_4c_SayCopiar
            .Caption   = "Copiar Tubo :"
            .Left      = 5
            .Top       = 232
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Tubo", "TextBox")
        WITH loc_oCnt.txt_4c_Tubo
            .Value     = 0
            .InputMask = "99"
            .Left      = 89
            .Top       = 230
            .Width     = 21
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Tubo, "KeyPress", THIS, "TuboLostFocus")

        loc_oCnt.AddObject("chk_4c_ChkRep", "CheckBox")
        WITH loc_oCnt.chk_4c_ChkRep
            .Caption   = "Repetir nosTubos"
            .Left      = 5
            .Top       = 253
            .Width     = 118
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_SayTrf", "Label")
        WITH loc_oCnt.lbl_4c_SayTrf
            .Caption   = "Transforma" + CHR(231) + CHR(245) + "es :"
            .Left      = 5
            .Top       = 275
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Trf", "TextBox")
        WITH loc_oCnt.txt_4c_Trf
            .Value     = ""
            .MaxLength = 20
            .Left      = 108
            .Top       = 273
            .Width     = 80
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Trf, "KeyPress", THIS, "TrfLostFocus")

        loc_oCnt.AddObject("grd_4c_GradeTrf", "Grid")
        loc_oCnt.grd_4c_GradeTrf.ColumnCount = 2
        loc_oCnt.grd_4c_GradeTrf.RecordSource = "TmpTrf"
        WITH loc_oCnt.grd_4c_GradeTrf
            .Top          = 216
            .Left         = 209
            .Width        = 233
            .Height       = 122
            .FontName     = "Tahoma"
            .FontSize     = 8
            .ReadOnly     = .T.
            .GridLines    = 1
            .HeaderHeight = 17
            .RowHeight    = 17
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        WITH loc_oCnt.grd_4c_GradeTrf.Column1
            .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .ControlSource   = "TmpTrf.Dopes"
            .Width           = 155
        ENDWITH

        WITH loc_oCnt.grd_4c_GradeTrf.Column2
            .Header1.Caption = "Numes"
            .ControlSource   = "TmpTrf.Numes"
            .Width           = 55
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_RemoverTrf", "CommandButton")
        WITH loc_oCnt.cmd_4c_RemoverTrf
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 4
            .Top             = 297
            .Left            = 165
            .Width           = 40
            .Height          = 40
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_RemoverTrf, "Click", THIS, "RemoverTrfClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer4(par_oPagina)
    *==========================================================================
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Container4

        loc_oCnt.AddObject("lbl_4c_ObsTubo", "Label")
        WITH loc_oCnt.lbl_4c_ObsTubo
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Tubo"
            .Left      = 14
            .Top       = 3
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_SayTubo", "Label")
        WITH loc_oCnt.lbl_4c_SayTubo
            .Caption   = "( )"
            .Left      = 148
            .Top       = 3
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_ObsGeral", "Label")
        WITH loc_oCnt.lbl_4c_ObsGeral
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o Geral"
            .Left      = 342
            .Top       = 2
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
        WITH loc_oCnt.edt_4c_Obs
            .Value      = ""
            .Left       = 9
            .Top        = 19
            .Width      = 328
            .Height     = 95
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ScrollBars = 2
        ENDWITH
        BINDEVENT(loc_oCnt.edt_4c_Obs, "LostFocus", THIS, "SalvarDadosTubo")

        loc_oCnt.AddObject("edt_4c_ObsG", "EditBox")
        WITH loc_oCnt.edt_4c_ObsG
            .Value      = ""
            .Left       = 340
            .Top        = 18
            .Width      = 328
            .Height     = 95
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ScrollBars = 2
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer5(par_oPagina)
    *==========================================================================
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Container5

        loc_oCnt.AddObject("lbl_4c_ConvTitle", "Label")
        WITH loc_oCnt.lbl_4c_ConvTitle
            .Caption   = "Convers" + CHR(227) + "o Cera/Metal"
            .Left      = 4
            .Top       = 2
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_CorLabel", "Label")
        WITH loc_oCnt.lbl_4c_CorLabel
            .Caption   = "Cor"
            .Left      = 5
            .Top       = 19
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cor", "TextBox")
        WITH loc_oCnt.txt_4c_Cor
            .Value     = ""
            .MaxLength = 4
            .Left      = 5
            .Top       = 33
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Cor, "KeyPress",  THIS, "CorKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Cor, "DblClick",  THIS, "CorDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Cor, "KeyPress", THIS, "ValidarCor")

        loc_oCnt.AddObject("lbl_4c_BasecLabel", "Label")
        WITH loc_oCnt.lbl_4c_BasecLabel
            .Caption   = "Base Cera"
            .Left      = 45
            .Top       = 19
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Basec", "TextBox")
        WITH loc_oCnt.txt_4c_Basec
            .Value     = 0
            .InputMask = "999999999.99"
            .Left      = 44
            .Top       = 33
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Basec, "KeyPress", THIS, "BasecLostFocus")

        loc_oCnt.AddObject("lbl_4c_BaseLabel", "Label")
        WITH loc_oCnt.lbl_4c_BaseLabel
            .Caption   = "Base"
            .Left      = 145
            .Top       = 20
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Base", "TextBox")
        WITH loc_oCnt.txt_4c_Base
            .Value     = 0
            .InputMask = "999999999.99"
            .Left      = 144
            .Top       = 33
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Base, "KeyPress", THIS, "BaseLostFocus")

        loc_oCnt.AddObject("lbl_4c_CeraLabel", "Label")
        WITH loc_oCnt.lbl_4c_CeraLabel
            .Caption   = "Cera"
            .Left      = 5
            .Top       = 61
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cera", "TextBox")
        WITH loc_oCnt.txt_4c_Cera
            .Value     = 0
            .InputMask = "999999999.99"
            .Left      = 5
            .Top       = 74
            .Width     = 83
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_PesoMetalLabel", "Label")
        WITH loc_oCnt.lbl_4c_PesoMetalLabel
            .Caption   = "Peso Metal"
            .Left      = 88
            .Top       = 61
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Metal", "TextBox")
        WITH loc_oCnt.txt_4c_Metal
            .Value     = 0
            .InputMask = "999999999.99"
            .Left      = 88
            .Top       = 74
            .Width     = 82
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_PesoRealLabel", "Label")
        WITH loc_oCnt.lbl_4c_PesoRealLabel
            .Caption   = "Peso Metal Real"
            .Left      = 5
            .Top       = 102
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Mreal", "TextBox")
        WITH loc_oCnt.txt_4c_Mreal
            .Value     = 0
            .InputMask = "999999999.99"
            .Left      = 5
            .Top       = 115
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Mreal, "LostFocus", THIS, "SalvarDadosTubo")

        loc_oCnt.AddObject("lbl_4c_MetalNovoLabel", "Label")
        WITH loc_oCnt.lbl_4c_MetalNovoLabel
            .Caption   = "Metal Novo"
            .Left      = 106
            .Top       = 102
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_metnovo", "TextBox")
        WITH loc_oCnt.txt_4c_metnovo
            .Value     = 0
            .InputMask = "999999999.99"
            .Left      = 106
            .Top       = 115
            .Width     = 100
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer6(par_oPagina)
    *==========================================================================
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Container6

        loc_oCnt.AddObject("lbl_4c_TempFundTitle", "Label")
        WITH loc_oCnt.lbl_4c_TempFundTitle
            .Caption   = "Temperatura Fundi" + CHR(231) + CHR(227) + "o"
            .Left      = 5
            .Top       = 2
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TempMetLabel", "Label")
        WITH loc_oCnt.lbl_4c_TempMetLabel
            .Caption   = "Metal"
            .Left      = 5
            .Top       = 20
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TempMet", "TextBox")
        WITH loc_oCnt.txt_4c_TempMet
            .Value     = ""
            .MaxLength = 15
            .Left      = 5
            .Top       = 36
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_TempMet, "LostFocus", THIS, "SalvarDadosTubo")

        loc_oCnt.AddObject("lbl_4c_TempTubLabel", "Label")
        WITH loc_oCnt.lbl_4c_TempTubLabel
            .Caption   = "Tubo"
            .Left      = 123
            .Top       = 20
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TempTub", "TextBox")
        WITH loc_oCnt.txt_4c_TempTub
            .Value     = ""
            .MaxLength = 15
            .Left      = 123
            .Top       = 36
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_TempTub, "LostFocus", THIS, "SalvarDadosTubo")

        loc_oCnt.AddObject("lbl_4c_TempRevTitle", "Label")
        WITH loc_oCnt.lbl_4c_TempRevTitle
            .Caption   = "Temperatura Revestimento"
            .Left      = 4
            .Top       = 61
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TempAmbLabel", "Label")
        WITH loc_oCnt.lbl_4c_TempAmbLabel
            .Caption   = "Ambiente"
            .Left      = 5
            .Top       = 77
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TempAmb", "TextBox")
        WITH loc_oCnt.txt_4c_TempAmb
            .Value     = ""
            .MaxLength = 15
            .Left      = 5
            .Top       = 93
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_TempAmb, "LostFocus", THIS, "SalvarDadosTubo")

        loc_oCnt.AddObject("lbl_4c_TempAguLabel", "Label")
        WITH loc_oCnt.lbl_4c_TempAguLabel
            .Caption   = CHR(193) + "gua"
            .Left      = 123
            .Top       = 77
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TempAgu", "TextBox")
        WITH loc_oCnt.txt_4c_TempAgu
            .Value     = ""
            .MaxLength = 15
            .Left      = 123
            .Top       = 93
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_TempAgu, "LostFocus", THIS, "SalvarDadosTubo")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntTotal(par_oPagina)
    *==========================================================================
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Total

        loc_oCnt.AddObject("lbl_4c_TotalMetal", "Label")
        WITH loc_oCnt.lbl_4c_TotalMetal
            .Caption   = "Total de Metal"
            .Left      = 6
            .Top       = 5
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        loc_oCnt.AddObject("grd_4c_TmpTot", "Grid")
        loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
        WITH loc_oCnt.grd_4c_TmpTot
            .Top                     = 49
            .Left                    = 28
            .Width                   = 354
            .Height                  = 122
            .FontName                = "Tahoma"
            .FontSize                = 8
            .ReadOnly                = .T.
            .GridLines               = 1
            .HeaderHeight            = 17
            .RowHeight               = 17
            .Column1.Header1.Caption = "Tipo " + CHR(193) + "rvore"
            .Column1.Width           = 80
            .Column2.Header1.Caption = "Metal Real"
            .Column2.Width           = 80
            .Column3.Header1.Caption = "Metal Novo"
            .Column3.Width           = 80
            .Column4.Header1.Caption = "Metal Ligado"
            .Column4.Width           = 80
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Retornar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Retornar
            .Caption         = "Retornar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 415
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Retornar, "Click", THIS, "BtnCancelarTotalClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPage2(par_oPagina)
    *==========================================================================
        *-- lbl_4c_TipoArvoreLabel: Say4 top=98+29=127, left=327
        par_oPagina.AddObject("lbl_4c_TipoArvoreLabel", "Label")
        WITH par_oPagina.lbl_4c_TipoArvoreLabel
            .Caption   = "Tipo " + CHR(193) + "rvore :"
            .Left      = 327
            .Top       = 127
            .AutoSize  = .T.
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- txt_4c_codarvore: top=93+29=122, left=416
        par_oPagina.AddObject("txt_4c_codarvore", "TextBox")
        WITH par_oPagina.txt_4c_codarvore
            .Value     = ""
            .MaxLength = 10
            .Left      = 416
            .Top       = 122
            .Width     = 79
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_codarvore, "KeyPress",  THIS, "ArvoreKeyPress")
        BINDEVENT(par_oPagina.txt_4c_codarvore, "DblClick",  THIS, "ArvoreDblClick")
        BINDEVENT(par_oPagina.txt_4c_codarvore, "KeyPress", THIS, "ValidarArvore")

        *-- txt_4c_descarvore: top=93+29=122, left=497
        par_oPagina.AddObject("txt_4c_descarvore", "TextBox")
        WITH par_oPagina.txt_4c_descarvore
            .Value     = ""
            .MaxLength = 40
            .Left      = 497
            .Top       = 122
            .Width     = 200
            .Height    = 25
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_descarvore, "KeyPress", THIS, "ArvoreDescKeyPress")
        BINDEVENT(par_oPagina.txt_4c_descarvore, "DblClick", THIS, "ArvoreDescDblClick")

        *-- cmd_4c_BtnTotal: top=12+29=41, left=718
        par_oPagina.AddObject("cmd_4c_BtnTotal", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnTotal
            .Caption         = "Total Metal"
            .Picture         = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
            .PicturePosition = 13
            .Top             = 41
            .Left            = 718
            .Width           = 80
            .Height          = 100
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(par_oPagina.cmd_4c_BtnTotal, "Click", THIS, "BtnTotalClick")
    ENDPROC

    *==========================================================================
    PROCEDURE SalvarDadosTubo()
    *==========================================================================
        LOCAL loc_oCnt4, loc_oCnt5, loc_oCnt6, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
                SELECT TmpCera
                SET ORDER TO Tubos
                IF SEEK(STR(THIS.this_nTuboAtual, 2))
                    loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
                    loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
                    loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6

                    IF PEMSTATUS(loc_oCnt4, "edt_4c_Obs", 5)
                        REPLACE Obss WITH loc_oCnt4.edt_4c_Obs.Value IN TmpCera
                    ENDIF
                    IF PEMSTATUS(loc_oCnt5, "txt_4c_Mreal", 5)
                        REPLACE pmetalrs WITH NVL(loc_oCnt5.txt_4c_Mreal.Value, 0) IN TmpCera
                    ENDIF
                    IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
                        REPLACE TempMets WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempMet.Value, "")) IN TmpCera
                        REPLACE TempTubs WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempTub.Value, "")) IN TmpCera
                        REPLACE TempAmbs WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempAmb.Value, "")) IN TmpCera
                        REPLACE TempAgus WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempAgu.Value, "")) IN TmpCera
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.SalvarDadosTubo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE CorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCor()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CorDblClick()
    *==========================================================================
        THIS.AbrirLookupCor()
    ENDPROC

    *==========================================================================
    PROCEDURE AbrirLookupCor()
    *==========================================================================
        LOCAL loc_oCnt5, loc_cAtual, loc_oBusca

        TRY
            loc_oCnt5  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
            loc_cAtual = ALLTRIM(NVL(loc_oCnt5.txt_4c_Cor.Value, ""))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SigCdCor", ;
                "cgrus", ;
                loc_cAtual, ;
                loc_oCnt5.txt_4c_Cor, ;
                "Selecionar Cor", ;
                .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cgrus", "9999", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "X(30)", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                THIS.ValidarCor()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.AbrirLookupCor: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarCor(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oCnt5, loc_cCodCor, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oCnt5   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
            loc_cCodCor = ALLTRIM(NVL(loc_oCnt5.txt_4c_Cor.Value, ""))

            IF EMPTY(loc_cCodCor)
                IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
                    SELECT TmpCera
                    SET ORDER TO Tubos
                    IF SEEK(STR(THIS.this_nTuboAtual, 2))
                        REPLACE CodCors WITH "" IN TmpCera
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT c.cods FROM SigCdCor c WHERE c.cods = " + ;
                    EscaparSQL(loc_cCodCor), ;
                    "cursor_4c_BuscaCor")

                IF loc_nResultado > 0 AND USED("cursor_4c_BuscaCor") AND ;
                        RECCOUNT("cursor_4c_BuscaCor") > 0
                    IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
                        SELECT TmpCera
                        SET ORDER TO Tubos
                        IF SEEK(STR(THIS.this_nTuboAtual, 2))
                            REPLACE CodCors WITH loc_cCodCor IN TmpCera
                        ENDIF
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Cor '" + loc_cCodCor + "' n" + CHR(227) + "o encontrada.", "Cor")
                    loc_oCnt5.txt_4c_Cor.Value = ""
                ENDIF

                IF USED("cursor_4c_BuscaCor")
                    USE IN cursor_4c_BuscaCor
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.ValidarCor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE ArvoreKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupArvore()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ArvoreDblClick()
    *==========================================================================
        THIS.AbrirLookupArvore()
    ENDPROC

    *==========================================================================
    PROCEDURE AbrirLookupArvore()
    *==========================================================================
        LOCAL loc_oPg2, loc_cAtual, loc_oBusca

        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cAtual = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))

            IF !USED("cursor_4c_Arvores")
                THIS.CarregarArvores()
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                "cursor_4c_Arvores", ;
                "codigos", ;
                loc_cAtual, ;
                loc_oPg2.txt_4c_codarvore, ;
                "Selecionar " + CHR(193) + "rvore", ;
                .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                THIS.ValidarArvore()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.AbrirLookupArvore: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarArvore(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oPg2, loc_cCodArv, loc_cDescs, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oPg2    = THIS.pgf_4c_Paginas.Page2
            loc_cCodArv = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))

            IF EMPTY(loc_cCodArv)
                IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
                    loc_oPg2.txt_4c_descarvore.Value = ""
                ENDIF
                IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
                    SELECT TmpCera
                    SET ORDER TO Tubos
                    IF SEEK(STR(THIS.this_nTuboAtual, 2))
                        REPLACE CodArvs WITH "", Descs WITH "" IN TmpCera
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF !USED("cursor_4c_Arvores")
                    THIS.CarregarArvores()
                ENDIF

                IF USED("cursor_4c_Arvores")
                    SELECT cursor_4c_Arvores
                    LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
                    IF FOUND()
                        loc_cDescs = ALLTRIM(NVL(cursor_4c_Arvores.descs, ""))
                        IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
                            loc_oPg2.txt_4c_descarvore.Value = loc_cDescs
                        ENDIF
                        IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
                            SELECT TmpCera
                            SET ORDER TO Tubos
                            IF SEEK(STR(THIS.this_nTuboAtual, 2))
                                REPLACE CodArvs WITH loc_cCodArv, Descs WITH loc_cDescs IN TmpCera
                            ENDIF
                        ENDIF
                        THIS.CalcMetal()
                        loc_lSucesso = .T.
                    ELSE
                        MsgAviso(CHR(193) + "rvore '" + loc_cCodArv + ;
                            "' n" + CHR(227) + "o encontrada.", CHR(193) + "rvore")
                        loc_oPg2.txt_4c_codarvore.Value  = ""
                        IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
                            loc_oPg2.txt_4c_descarvore.Value = ""
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.ValidarArvore: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE ArvoreDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupArvoreDesc()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ArvoreDescDblClick()
    *==========================================================================
        THIS.AbrirLookupArvoreDesc()
    ENDPROC

    *==========================================================================
    PROCEDURE AbrirLookupArvoreDesc()
    *==========================================================================
        LOCAL loc_oPg2, loc_cAtual, loc_oBusca

        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cAtual = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))

            IF !USED("cursor_4c_Arvores")
                THIS.CarregarArvores()
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                "cursor_4c_Arvores", ;
                "codigos", ;
                loc_cAtual, ;
                loc_oPg2.txt_4c_codarvore, ;
                "Selecionar " + CHR(193) + "rvore", ;
                .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                THIS.ValidarArvore()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.AbrirLookupArvoreDesc: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CalcMetal()
    *==========================================================================
        LOCAL loc_oCnt5, loc_oPg2, loc_cCodArv, loc_cFormula
        LOCAL loc_nBCeras, loc_nBases, loc_nCeras, loc_nPesoMetal, loc_nMetalNovo, loc_nPercs
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
                SELECT TmpCera
                SET ORDER TO Tubos
                IF SEEK(STR(THIS.this_nTuboAtual, 2))
                    loc_nBCeras = NVL(TmpCera.BCeras, 0)
                    loc_nBases  = NVL(TmpCera.Bases, 0)

                    IF loc_nBCeras > 0 AND loc_nBases > 0 AND loc_nBCeras < loc_nBases
                        MsgAviso("Base com Cera n" + CHR(227) + "o pode ser menor que a Base.", "Aviso")
                        REPLACE Bases WITH 0 IN TmpCera
                        loc_nBases = 0
                    ENDIF

                    loc_nCeras = loc_nBCeras - loc_nBases
                    REPLACE Ceras WITH loc_nCeras IN TmpCera

                    loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
                    IF PEMSTATUS(loc_oCnt5, "txt_4c_Cera", 5)
                        loc_oCnt5.txt_4c_Cera.Value = loc_nCeras
                    ENDIF

                    loc_oPg2    = THIS.pgf_4c_Paginas.Page2
                    loc_cCodArv = ""
                    IF PEMSTATUS(loc_oPg2, "txt_4c_codarvore", 5)
                        loc_cCodArv = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))
                    ENDIF

                    loc_nPesoMetal = 0
                    loc_nMetalNovo = 0
                    loc_nPercs     = 0

                    IF !EMPTY(loc_cCodArv) AND USED("cursor_4c_Arvores")
                        SELECT cursor_4c_Arvores
                        LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
                        IF FOUND()
                            loc_cFormula = ALLTRIM(NVL(cursor_4c_Arvores.formulas, ""))
                            loc_nPercs   = NVL(cursor_4c_Arvores.percs, 0)
                            IF !EMPTY(loc_cFormula)
                                SELECT TmpCera
                                TRY
                                    loc_nPesoMetal = EVALUATE(loc_cFormula)
                                CATCH
                                    loc_nPesoMetal = 0
                                ENDTRY
                                loc_nMetalNovo = (loc_nPesoMetal * loc_nPercs) / 100
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT TmpCera
                    SET ORDER TO Tubos
                    IF SEEK(STR(THIS.this_nTuboAtual, 2))
                        REPLACE PMetals WITH loc_nPesoMetal, MetalNvs WITH loc_nMetalNovo IN TmpCera
                    ENDIF

                    IF PEMSTATUS(loc_oCnt5, "txt_4c_Metal", 5)
                        loc_oCnt5.txt_4c_Metal.Value   = loc_nPesoMetal
                    ENDIF
                    IF PEMSTATUS(loc_oCnt5, "txt_4c_metnovo", 5)
                        loc_oCnt5.txt_4c_metnovo.Value = loc_nMetalNovo
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.CalcMetal: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BasecLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oCnt5, loc_nBCeras, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oCnt5  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
            loc_nBCeras = NVL(loc_oCnt5.txt_4c_Basec.Value, 0)

            IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
                SELECT TmpCera
                SET ORDER TO Tubos
                IF SEEK(STR(THIS.this_nTuboAtual, 2))
                    REPLACE BCeras WITH loc_nBCeras IN TmpCera
                ENDIF
            ENDIF

            THIS.CalcMetal()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BasecLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BaseLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oCnt5, loc_nBases, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oCnt5  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
            loc_nBases = NVL(loc_oCnt5.txt_4c_Base.Value, 0)

            IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
                SELECT TmpCera
                SET ORDER TO Tubos
                IF SEEK(STR(THIS.this_nTuboAtual, 2))
                    REPLACE Bases WITH loc_nBases IN TmpCera
                ENDIF
            ENDIF

            THIS.CalcMetal()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BaseLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE EmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cEmps, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cEmps = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_CdEmpresa.Value, ""))
            IF loc_cEmps != THIS.this_cAntEmpr
                THIS.this_cAntEmpr = loc_cEmps
                THIS.CarregarLista()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.EmpresaLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_dDtIni, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_dDtIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
            IF loc_dDtIni != THIS.this_dAntDtI
                THIS.this_dAntDtI = loc_dDtIni
                THIS.CarregarLista()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.DtInicialLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_dDtFim, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_dDtFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
            IF loc_dDtFim != THIS.this_dAntDtF
                THIS.this_dAntDtF = loc_dDtFim
                THIS.CarregarLista()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.DtFinalLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE NopLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oCnt3, loc_nNop, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
            loc_nNop  = NVL(loc_oCnt3.txt_4c_Nop.Value, 0)

            IF loc_nNop <= 0
                IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
                    loc_oCnt3.txt_4c_Qtd.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
                    loc_oCnt3.txt_4c_Pecas.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
                    loc_oCnt3.txt_4c_Operacao.Value = ""
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT o.nops, o.cpros, o.qtds, o.numes, o.dtents" + ;
                    " FROM SigOpPic o" + ;
                    " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
                    " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
                    "cursor_4c_BuscaNop")

                IF loc_nResultado > 0 AND USED("cursor_4c_BuscaNop") AND ;
                        RECCOUNT("cursor_4c_BuscaNop") > 0
                    SELECT cursor_4c_BuscaNop
                    IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
                        loc_oCnt3.txt_4c_Qtd.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
                        loc_oCnt3.txt_4c_Pecas.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
                        loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(cursor_4c_BuscaNop.cpros, ""))
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O.P. n" + CHR(186) + " " + TRANSFORM(loc_nNop) + ;
                        " n" + CHR(227) + "o encontrada.", "O.P.")
                    loc_oCnt3.txt_4c_Nop.Value = 0
                    IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
                        loc_oCnt3.txt_4c_Qtd.Value = 0
                    ENDIF
                    IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
                        loc_oCnt3.txt_4c_Pecas.Value = 0
                    ENDIF
                    IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
                        loc_oCnt3.txt_4c_Operacao.Value = ""
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaNop")
                    USE IN cursor_4c_BuscaNop
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.NopLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE QtTbLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oCnt3, loc_nQtTb, loc_nMaxQtd, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oCnt3   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
            loc_nQtTb   = NVL(loc_oCnt3.txt_4c_QtTb.Value, 0)
            loc_nMaxQtd = 0
            IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
                loc_nMaxQtd = NVL(loc_oCnt3.txt_4c_Qtd.Value, 0)
            ENDIF

            IF loc_nMaxQtd > 0 AND loc_nQtTb > loc_nMaxQtd
                MsgAviso("Quantidade solicitada (" + TRANSFORM(loc_nQtTb) + ;
                    ") excede quantidade dispon" + CHR(237) + "vel (" + ;
                    TRANSFORM(loc_nMaxQtd) + ").", "Quantidade")
                loc_oCnt3.txt_4c_QtTb.Value = loc_nMaxQtd
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.QtTbLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE TuboLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oCnt3, loc_nTuboFonte, loc_nTuboAtual
        LOCAL loc_nTotal, loc_nI, loc_cDopes, loc_nNumes, loc_nNNumes
        LOCAL loc_lSucesso
        LOCAL ARRAY loc_aTrfs[1, 3]
        loc_lSucesso = .F.
        loc_nTotal   = 0

        TRY
            loc_oCnt3      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
            loc_nTuboFonte = NVL(loc_oCnt3.txt_4c_Tubo.Value, 0)
            loc_nTuboAtual = THIS.this_nTuboAtual

            IF loc_nTuboFonte > 0 AND loc_nTuboAtual > 0 AND ;
                    loc_nTuboFonte != loc_nTuboAtual AND USED("TmpTrf")
                *-- Coletar registros do tubo fonte
                SELECT TmpTrf
                SET ORDER TO 0
                GO TOP
                DO WHILE !EOF("TmpTrf")
                    IF TmpTrf.Tubos = loc_nTuboFonte
                        loc_nTotal = loc_nTotal + 1
                        DIMENSION loc_aTrfs[loc_nTotal, 3]
                        loc_aTrfs[loc_nTotal, 1] = TmpTrf.Dopes
                        loc_aTrfs[loc_nTotal, 2] = TmpTrf.Numes
                        loc_aTrfs[loc_nTotal, 3] = TmpTrf.nNumes
                    ENDIF
                    SKIP
                ENDDO

                *-- Inserir no tubo destino se nao existir
                FOR loc_nI = 1 TO loc_nTotal
                    loc_cDopes  = loc_aTrfs[loc_nI, 1]
                    loc_nNumes  = loc_aTrfs[loc_nI, 2]
                    loc_nNNumes = loc_aTrfs[loc_nI, 3]
                    SELECT TmpTrf
                    LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cDopes
                    IF !FOUND()
                        INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
                            VALUES (loc_cDopes, loc_nNumes, loc_nTuboAtual, loc_nNNumes)
                    ENDIF
                ENDFOR

                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.TuboLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE TrfLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oCnt3, loc_cTrf, loc_nResultado, loc_lSucesso
        LOCAL loc_nTuboAtual, loc_lRep, loc_nNNumes, loc_nT
        loc_lSucesso = .F.

        TRY
            loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
            loc_cTrf  = ALLTRIM(NVL(loc_oCnt3.txt_4c_Trf.Value, ""))

            IF EMPTY(loc_cTrf)
                loc_lSucesso = .T.
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 m.dopes, m.numes FROM SigMvCab m" + ;
                    " WHERE m.dopes = " + EscaparSQL(loc_cTrf) + ;
                    " AND m.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))) + ;
                    " ORDER BY m.numes DESC", ;
                    "cursor_4c_BuscaTrf")

                IF loc_nResultado > 0 AND USED("cursor_4c_BuscaTrf") AND ;
                        RECCOUNT("cursor_4c_BuscaTrf") > 0
                    loc_nTuboAtual = THIS.this_nTuboAtual
                    loc_lRep       = .F.
                    IF PEMSTATUS(loc_oCnt3, "chk_4c_ChkRep", 5)
                        loc_lRep = (loc_oCnt3.chk_4c_ChkRep.Value = 1)
                    ENDIF

                    SELECT cursor_4c_BuscaTrf
                    loc_nNNumes = NVL(cursor_4c_BuscaTrf.numes, 0)

                    IF loc_nTuboAtual > 0 AND USED("TmpTrf")
                        SELECT TmpTrf
                        LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cTrf
                        IF !FOUND()
                            INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
                                VALUES (loc_cTrf, 0, loc_nTuboAtual, loc_nNNumes)
                        ENDIF

                        IF loc_lRep
                            FOR loc_nT = 1 TO THIS.this_nMaqTubos
                                IF loc_nT != loc_nTuboAtual
                                    SELECT TmpTrf
                                    LOCATE FOR TmpTrf.Tubos = loc_nT AND TmpTrf.Dopes = loc_cTrf
                                    IF !FOUND()
                                        INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
                                            VALUES (loc_cTrf, 0, loc_nT, loc_nNNumes)
                                    ENDIF
                                ENDIF
                            ENDFOR
                        ENDIF

                        IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5)
                            loc_oCnt3.grd_4c_GradeTrf.Refresh()
                        ENDIF
                    ENDIF
                    loc_oCnt3.txt_4c_Trf.Value = ""
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o '" + loc_cTrf + ;
                        "' n" + CHR(227) + "o encontrada.", ;
                        "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oCnt3.txt_4c_Trf.Value = ""
                ENDIF

                IF USED("cursor_4c_BuscaTrf")
                    USE IN cursor_4c_BuscaTrf
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.TrfLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE AdicionarNopClick()
    *==========================================================================
        LOCAL loc_oCnt3, loc_nNop, loc_nQtTb, loc_nTuboAtual
        LOCAL loc_cCpros, loc_nQtds, loc_nNumes, loc_nRes2
        LOCAL loc_dDtEnt, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oCnt3      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
            loc_nNop       = NVL(loc_oCnt3.txt_4c_Nop.Value, 0)
            loc_nQtTb      = NVL(loc_oCnt3.txt_4c_QtTb.Value, 0)
            loc_nTuboAtual = THIS.this_nTuboAtual

            IF loc_nNop <= 0
                MsgAviso("Informe o n" + CHR(186) + " da O.P.", "O.P.")
            ELSE
                IF loc_nTuboAtual <= 0
                MsgAviso("Selecione um tubo antes de adicionar a O.P.", "Tubo")
            ELSE
                IF loc_nQtTb <= 0
                MsgAviso("Informe a quantidade do tubo.", "Quantidade")
            ELSE
                loc_cCpros = ""
                loc_nQtds  = 0
                loc_nNumes = 0

                loc_nRes2 = SQLEXEC(gnConnHandle, ;
                    "SELECT o.cpros, o.qtds, o.numes FROM SigOpPic o" + ;
                    " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
                    " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
                    "cursor_4c_BuscaNop2")

                IF loc_nRes2 > 0 AND USED("cursor_4c_BuscaNop2") AND ;
                        RECCOUNT("cursor_4c_BuscaNop2") > 0
                    SELECT cursor_4c_BuscaNop2
                    loc_cCpros = ALLTRIM(NVL(cursor_4c_BuscaNop2.cpros, ""))
                    loc_nQtds  = NVL(cursor_4c_BuscaNop2.qtds, 0)
                    loc_nNumes = NVL(cursor_4c_BuscaNop2.numes, 0)

                    IF USED("cursor_4c_BuscaNop2")
                        USE IN cursor_4c_BuscaNop2
                    ENDIF

                    IF USED("TmpNop")
                        SELECT TmpNop
                        LOCATE FOR TmpNop.Tubos = loc_nTuboAtual AND TmpNop.Nops = loc_nNop
                        IF !FOUND()
                            loc_dDtEnt = DATE()
                            INSERT INTO TmpNop (Nops, Cpros, Qtds, Tubos, Qtdos, Numes, ;
                                               EmpDopNums, DtEnts) ;
                                VALUES (loc_nNop, loc_cCpros, loc_nQtTb, loc_nTuboAtual, ;
                                        loc_nQtds, loc_nNumes, ;
                                        PADR(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, "")), 29), ;
                                        loc_dDtEnt)
                        ENDIF

                        IF PEMSTATUS(loc_oCnt3, "grd_4c_Gradenop", 5)
                            loc_oCnt3.grd_4c_Gradenop.Refresh()
                        ENDIF
                    ENDIF

                    loc_oCnt3.txt_4c_Nop.Value  = 0
                    loc_oCnt3.txt_4c_QtTb.Value = 0
                    IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
                        loc_oCnt3.txt_4c_Qtd.Value = 0
                    ENDIF
                    IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
                        loc_oCnt3.txt_4c_Pecas.Value = 0
                    ENDIF
                    IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
                        loc_oCnt3.txt_4c_Operacao.Value = ""
                    ENDIF

                    THIS.CalcMetal()
                    loc_lSucesso = .T.
                ELSE
                    IF USED("cursor_4c_BuscaNop2")
                        USE IN cursor_4c_BuscaNop2
                    ENDIF
                    MsgAviso("O.P. n" + CHR(186) + " " + TRANSFORM(loc_nNop) + ;
                        " n" + CHR(227) + "o encontrada.", "O.P.")
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.AdicionarNopClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE RemoverTrfClick()
    *==========================================================================
        LOCAL loc_oCnt3, loc_nTuboAtual, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oCnt3     = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
            loc_nTuboAtual = THIS.this_nTuboAtual

            IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5) AND USED("TmpTrf")
                SELECT TmpTrf
                IF !EOF("TmpTrf") AND TmpTrf.Tubos = loc_nTuboAtual
                    DELETE
                    SET FILTER TO
                    PACK NOOPTIMIZE
                    SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
                    GO TOP
                    loc_oCnt3.grd_4c_GradeTrf.Refresh()
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.RemoverTrfClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE GradenopAfterRowColChange(par_nColIndex)
    *==========================================================================
        LPARAMETERS par_nColIndex
        LOCAL loc_oCnt3, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
            IF USED("TmpNop") AND !EOF("TmpNop") AND PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
                SELECT TmpNop
                IF !EOF("TmpNop")
                    loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(TmpNop.Cpros, "")) + ;
                        "  Qt: " + TRANSFORM(NVL(TmpNop.Qtds, 0), "999,999.999")
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.GradenopAfterRowColChange: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnTotalClick()
    *==========================================================================
        LOCAL loc_oCnt, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpTot")
                USE IN cursor_4c_TmpTot
            ENDIF

            IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
                SELECT TmpCera.CodArvs AS CodArvs, ;
                       TmpCera.Descs   AS Descs,   ;
                       SUM(TmpCera.pmetalrs) AS PesoRealTotal, ;
                       SUM(TmpCera.MetalNvs) AS MetalNovoTotal, ;
                       SUM(TmpCera.PMetals)  AS PesoMetalTotal  ;
                FROM TmpCera ;
                WHERE TmpCera.nStatus = 3 ;
                GROUP BY TmpCera.CodArvs, TmpCera.Descs ;
                INTO CURSOR cursor_4c_TmpTot NOFILTER
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_TmpTot ( ;
                    CodArvs        C(10), ;
                    Descs          C(40), ;
                    PesoRealTotal  N(12,2), ;
                    MetalNovoTotal N(12,2), ;
                    PesoMetalTotal N(12,2) ;
                )
                SET NULL OFF
            ENDIF

            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Total
            IF PEMSTATUS(loc_oCnt, "grd_4c_TmpTot", 5)
                loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
                loc_oCnt.grd_4c_TmpTot.RecordSource            = "cursor_4c_TmpTot"
                loc_oCnt.grd_4c_TmpTot.Column1.ControlSource   = "cursor_4c_TmpTot.CodArvs"
                loc_oCnt.grd_4c_TmpTot.Column2.ControlSource   = "cursor_4c_TmpTot.PesoRealTotal"
                loc_oCnt.grd_4c_TmpTot.Column3.ControlSource   = "cursor_4c_TmpTot.MetalNovoTotal"
                loc_oCnt.grd_4c_TmpTot.Column4.ControlSource   = "cursor_4c_TmpTot.PesoMetalTotal"
                loc_oCnt.grd_4c_TmpTot.Refresh()
            ENDIF

            loc_oCnt.Visible = .T.
            loc_oCnt.ZOrder(0)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BtnTotalClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarTotalClick()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Total.Visible = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.BtnCancelarTotalClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCamposTubo()
    *==========================================================================
        LOCAL loc_oCnt4, loc_oCnt5, loc_oCnt6, loc_oPg2

        TRY
            loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
            loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
            loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oCnt4, "edt_4c_Obs", 5)
                loc_oCnt4.edt_4c_Obs.Value = ""
            ENDIF

            IF PEMSTATUS(loc_oCnt5, "txt_4c_Cor", 5)
                loc_oCnt5.txt_4c_Cor.Value     = ""
                loc_oCnt5.txt_4c_Basec.Value   = 0
                loc_oCnt5.txt_4c_Base.Value    = 0
                loc_oCnt5.txt_4c_Cera.Value    = 0
                loc_oCnt5.txt_4c_Metal.Value   = 0
                loc_oCnt5.txt_4c_Mreal.Value   = 0
                loc_oCnt5.txt_4c_metnovo.Value = 0
            ENDIF

            IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
                loc_oCnt6.txt_4c_TempMet.Value = ""
                loc_oCnt6.txt_4c_TempTub.Value = ""
                loc_oCnt6.txt_4c_TempAmb.Value = ""
                loc_oCnt6.txt_4c_TempAgu.Value = ""
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_codarvore", 5)
                loc_oPg2.txt_4c_codarvore.Value  = ""
                loc_oPg2.txt_4c_descarvore.Value = ""
            ENDIF

            IF USED("TmpNop")
                SELECT TmpNop
                SET FILTER TO
                GO TOP
            ENDIF
            IF USED("TmpTrf")
                SELECT TmpTrf
                SET FILTER TO
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormFUN.LimparCamposTubo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FUNBO.prg):
*==============================================================================
* FUNBO.prg - Business Object para Cadastro de Fundicoes (SIGCDFUN)
* Tabela principal : SIGCDFUN (cabecalho)
* Tabela detalhe   : SigCdFud (tubos, ordens de producao, transferencias)
*==============================================================================

DEFINE CLASS FUNBO AS BusinessBase

	*-- SIGCDFUN: campos do cabecalho
	this_nCodigos   = 0    && codigos   numeric(6,0) - ID da fundicao
	this_cCidChaves = ""   && cidchaves char(20)     - PK fisica
	this_cEmps      = ""   && emps      char(3)      - empresa
	this_dDatas     = {}   && datas     datetime     - data da fundicao
	this_cCodMaqfs  = ""   && codmaqfs  char(10)     - codigo da maquina
	this_cUsuars    = ""   && usuars    char(10)      - usuario que registrou
	this_mObsG      = ""   && obss      text         - observacao geral do cabecalho

	*-- Propriedade de trabalho: numero de tubos da maquina (SigCfMqf.Tubos)
	*   Lido no CarregarPorCodigo via JOIN, devolvido ao form em BOParaForm
	this_nNTubos    = 0

	*==========================================================================
	PROCEDURE Init()
	*==========================================================================
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDFUN"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*==========================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
	*==========================================================================
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*==========================================================================
	* Buscar - Retorna lista de fundicoes em cursor_4c_Dados
	* par_cFiltro: fragmento WHERE sem a palavra WHERE
	*==========================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF VARTYPE(par_cFiltro) != "C"
				par_cFiltro = ""
			ENDIF

			loc_cSQL = "SELECT f.codigos, f.emps, f.datas, f.usuars, f.codmaqfs," + ;
			           " f.ntubos," + ;
			           " ISNULL(CAST(f.obss AS NVARCHAR(200)), '') AS obss" + ;
			           " FROM SIGCDFUN f"

			IF !EMPTY(ALLTRIM(par_cFiltro))
				loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY f.datas DESC, f.codigos DESC"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
					    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
					SET NULL OFF
				ENDIF
				MsgErro("Erro ao buscar fundi" + CHR(231) + CHR(245) + "es:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.Buscar: " + loc_oErro.Message, "Erro")
			IF !USED("cursor_4c_Dados")
				SET NULL ON
				CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
				    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
				SET NULL OFF
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarPorCodigo - Carrega registro pelo codigos (ID numerico)
	* Tambem carrega this_nNTubos (numero de tubos da maquina) via JOIN SigCfMqf
	*==========================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigos)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT f.codigos, f.cidchaves, f.emps, f.datas," + ;
			           " f.codmaqfs, f.usuars," + ;
			           " ISNULL(CAST(f.obss AS NVARCHAR(MAX)), '') AS obss," + ;
			           " ISNULL(m.tubos, 24) AS ntubos" + ;
			           " FROM SIGCDFUN f" + ;
			           " LEFT JOIN SigCfMqf m ON m.codigos = f.codmaqfs" + ;
			           " WHERE f.codigos = " + TRANSFORM(par_nCodigos)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND ;
			        RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Fundi" + CHR(231) + CHR(227) + "o " + ;
				    TRANSFORM(par_nCodigos) + " n" + CHR(227) + "o encontrada.", "Aviso")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarDoCursor - Popula propriedades a partir de cursor aberto
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nCodigos   = TratarNulo(codigos,   "N")
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cEmps      = TratarNulo(emps,      "C")
			THIS.this_dDatas     = TratarNulo(datas,     "D")
			THIS.this_cCodMaqfs  = TratarNulo(codmaqfs,  "C")
			THIS.this_cUsuars    = TratarNulo(usuars,    "C")
			THIS.this_mObsG      = TratarNulo(obss,      "C")
			THIS.this_nNTubos    = TratarNulo(ntubos,    "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Inserir - INSERT SIGCDFUN + SigCdFud (PROTECTED - chamado por Salvar())
	*==========================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
		LOCAL loc_nCodigos, loc_cChave, loc_nNTuboFlag
		loc_lSucesso = .F.

		TRY
			*-- Flag de tubos em producao (nTubos em SIGCDFUN): 1 se nStatus 2 ou 3
			loc_nNTuboFlag = THIS.CalcularFlagNTubos()

			*-- Gerar proximo codigos via SQL Server
			loc_nResultado = SQLEXEC(gnConnHandle, ;
			    "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox FROM SIGCDFUN", ;
			    "cursor_4c_FunNextId")
			IF loc_nResultado < 0 OR !USED("cursor_4c_FunNextId")
				MsgErro("Erro ao gerar ID de fundi" + CHR(231) + CHR(227) + "o: " + ;
				    CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_nCodigos = cursor_4c_FunNextId.prox
				USE IN cursor_4c_FunNextId

				THIS.this_nCodigos = loc_nCodigos

				*-- Gerar cidchaves (20 chars via SYS(2015))
				loc_cChave = SYS(2015) + SYS(2015)
				THIS.this_cCidChaves = loc_cChave

				*-- Campos automaticos
				IF EMPTY(THIS.this_cUsuars)
					THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
				ENDIF
				IF EMPTY(THIS.this_cEmps)
					THIS.this_cEmps = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
				ENDIF

				SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

				loc_cSQL = "INSERT INTO SIGCDFUN" + ;
				    " (cidchaves, codigos, emps, datas, datars," + ;
				    " codmaqfs, horas, ntubos, usuars, obss)" + ;
				    " VALUES (" + ;
				    EscaparSQL(loc_cChave) + "," + ;
				    TRANSFORM(loc_nCodigos) + "," + ;
				    EscaparSQL(THIS.this_cEmps) + "," + ;
				    FormatarDataSQL(THIS.this_dDatas) + "," + ;
				    GETDATE() + "," + ;
				    EscaparSQL(ALLTRIM(NVL(THIS.this_cCodMaqfs, ""))) + "," + ;
				    EscaparSQL(SUBSTR(TIME(), 1, 8)) + "," + ;
				    TRANSFORM(loc_nNTuboFlag) + "," + ;
				    EscaparSQL(ALLTRIM(NVL(THIS.this_cUsuars, ""))) + "," + ;
				    THIS.PrepararMemoSQL(THIS.this_mObsG) + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao inserir fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					IF THIS.InserirDetalhesSigCdFud(loc_nCodigos)
						SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.Inserir: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - UPDATE SIGCDFUN + recriar SigCdFud (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nNTuboFlag
		loc_lSucesso = .F.

		TRY
			loc_nNTuboFlag = THIS.CalcularFlagNTubos()

			IF EMPTY(THIS.this_cUsuars)
				THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
			ENDIF

			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

			loc_cSQL = "UPDATE SIGCDFUN SET" + ;
			    " emps     = " + EscaparSQL(THIS.this_cEmps) + "," + ;
			    " datas    = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
			    " datars   = " + GETDATE() + "," + ;
			    " codmaqfs = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cCodMaqfs, ""))) + "," + ;
			    " horas    = " + EscaparSQL(SUBSTR(TIME(), 1, 8)) + "," + ;
			    " ntubos   = " + TRANSFORM(loc_nNTuboFlag) + "," + ;
			    " usuars   = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cUsuars, ""))) + "," + ;
			    " obss     = " + THIS.PrepararMemoSQL(THIS.this_mObsG) + ;
			    " WHERE codigos = " + TRANSFORM(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
				MsgErro("Erro ao atualizar fundi" + CHR(231) + CHR(227) + "o:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- Excluir detalhes antigos e reinserir dos cursores de trabalho
				loc_nResultado = SQLEXEC(gnConnHandle, ;
				    "DELETE FROM SigCdFud WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao excluir detalhes antigos da fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					IF THIS.InserirDetalhesSigCdFud(THIS.this_nCodigos)
						SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
						THIS.RegistrarAuditoria("UPDATE")
						loc_lSucesso = .T.
					ELSE
						SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.Atualizar: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - DELETE SIGCDFUN + SigCdFud (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lSucesso, loc_nResultado
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

			loc_nResultado = SQLEXEC(gnConnHandle, ;
			    "DELETE FROM SIGCDFUN WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
			IF loc_nResultado < 0
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
				MsgErro("Erro ao excluir fundi" + CHR(231) + CHR(227) + "o:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, ;
				    "DELETE FROM SigCdFud WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao excluir detalhes da fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
					THIS.RegistrarAuditoria("DELETE")
					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.ExecutarExclusao: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InserirDetalhesSigCdFud - Insere linhas de SigCdFud a partir de
	*   TmpTrf (transferencias), TmpNop (ordens de producao), TmpCera (tubos)
	*==========================================================================
	PROTECTED PROCEDURE InserirDetalhesSigCdFud(par_nCodigos)
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cChave
		LOCAL loc_cDopes, loc_nNNumes, loc_nTubos
		LOCAL loc_nNops, loc_nQtds, loc_nQtdos
		LOCAL loc_nBCeras, loc_nBases, loc_cCodCors, loc_cCodArvs
		LOCAL loc_nMetals, loc_nMetalNvs, loc_nNStatus
		LOCAL loc_cTmpMets, loc_cTmpAmbs, loc_cTmpTubs, loc_cTmpAgus
		loc_lSucesso = .T.

		TRY
			*------------------------------------------------------------------
			* 1. TmpTrf -> SigCdFud (transferencias/lancamentos de operacao)
			*    Condicao de skip: Dopes vazio OU nNumes = 0
			*------------------------------------------------------------------
			IF USED("TmpTrf") AND RECCOUNT("TmpTrf") > 0
				SELECT TmpTrf
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_cDopes  = ALLTRIM(TmpTrf.Dopes)
					loc_nNNumes = TmpTrf.nNumes
					loc_nTubos  = TmpTrf.Tubos

					IF !EMPTY(loc_cDopes) AND loc_nNNumes > 0
						loc_cChave  = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos, nnumes, nops, qtds, qtdos," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, obss," + ;
						    " tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    TRANSFORM(loc_nNNumes) + "," + ;
						    "0,0,0," + ;
						    "0,0,0,0,0," + ;
						    "'','',NULL," + ;
						    "'','','','')"
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir transfer" + CHR(234) + "ncia" + ;
							    " (tubo " + TRANSFORM(loc_nTubos) + ") em SigCdFud:" + ;
							    CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpTrf
					SKIP
				ENDDO
			ENDIF

			*------------------------------------------------------------------
			* 2. TmpNop -> SigCdFud (ordens de producao)
			*    Condicao de skip: nops = 0 OU qtdos = 0
			*------------------------------------------------------------------
			IF loc_lSucesso AND USED("TmpNop") AND RECCOUNT("TmpNop") > 0
				SELECT TmpNop
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_nNops  = TmpNop.Nops
					loc_nQtds  = TmpNop.Qtds
					loc_nTubos = TmpNop.Tubos
					loc_nQtdos = TmpNop.Qtdos

					IF loc_nNops > 0 AND loc_nQtdos > 0
						loc_cChave = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos, nops, qtds, qtdos, nnumes," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, obss," + ;
						    " tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    TRANSFORM(loc_nNops) + "," + ;
						    FormatarNumeroSQL(loc_nQtds, 3) + "," + ;
						    FormatarNumeroSQL(loc_nQtdos, 3) + "," + ;
						    "0," + ;
						    "0,0,0,0,0," + ;
						    "'','',NULL," + ;
						    "'','','','')"
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir O.P. " + TRANSFORM(loc_nNops) + ;
							    " (tubo " + TRANSFORM(loc_nTubos) + ") em SigCdFud:" + ;
							    CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpNop
					SKIP
				ENDDO
			ENDIF

			*------------------------------------------------------------------
			* 3. TmpCera -> SigCdFud (dados de cera/metal por tubo)
			*    Condicao de skip: bceras = 0 E bases = 0 (tubo sem dados)
			*    metals em SigCdFud = pmetalrs (peso real do metal, digitado)
			*------------------------------------------------------------------
			IF loc_lSucesso AND USED("TmpCera") AND RECCOUNT("TmpCera") > 0
				SELECT TmpCera
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_nBCeras   = TmpCera.BCeras
					loc_nBases    = TmpCera.Bases
					loc_nTubos    = TmpCera.Tubos
					loc_cCodCors  = ALLTRIM(NVL(TmpCera.CodCors, ""))
					loc_cCodArvs  = ALLTRIM(NVL(TmpCera.CodArvs, ""))
					loc_nMetals   = TmpCera.pmetalrs   && peso real (digitado)
					loc_nMetalNvs = TmpCera.MetalNvs
					loc_nNStatus  = TmpCera.nStatus
					loc_cTmpMets  = ALLTRIM(NVL(TmpCera.TempMets, ""))
					loc_cTmpAmbs  = ALLTRIM(NVL(TmpCera.TempAmbs, ""))
					loc_cTmpTubs  = ALLTRIM(NVL(TmpCera.TempTubs, ""))
					loc_cTmpAgus  = ALLTRIM(NVL(TmpCera.TempAgus, ""))

					IF !(loc_nBCeras = 0 AND loc_nBases = 0)
						loc_cChave = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, nnumes, nops, qtds, qtdos," + ;
						    " obss, tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    FormatarNumeroSQL(loc_nBCeras, 2) + "," + ;
						    FormatarNumeroSQL(loc_nBases,  2) + "," + ;
						    FormatarNumeroSQL(loc_nMetals,   2) + "," + ;
						    FormatarNumeroSQL(loc_nMetalNvs, 2) + "," + ;
						    TRANSFORM(loc_nNStatus) + "," + ;
						    EscaparSQL(loc_cCodCors) + "," + ;
						    EscaparSQL(loc_cCodArvs) + "," + ;
						    "0,0,0,0," + ;
						    THIS.PrepararMemoSQL(NVL(TmpCera.Obss, "")) + "," + ;
						    EscaparSQL(loc_cTmpMets) + "," + ;
						    EscaparSQL(loc_cTmpAmbs) + "," + ;
						    EscaparSQL(loc_cTmpTubs) + "," + ;
						    EscaparSQL(loc_cTmpAgus) + ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir tubo " + TRANSFORM(loc_nTubos) + ;
							    " em SigCdFud:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpCera
					SKIP
				ENDDO
			ENDIF

		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.InserirDetalhesSigCdFud: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CalcularFlagNTubos - Retorna 1 se ha tubos em producao (nStatus 2 ou 3)
	*   Corresponde ao campo SIGCDFUN.ntubos (flag vermelho na grade)
	*==========================================================================
	PROTECTED PROCEDURE CalcularFlagNTubos()
		LOCAL loc_nFlag
		loc_nFlag = 0

		IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
			SELECT TmpCera
			LOCATE FOR TmpCera.nStatus = 2 OR TmpCera.nStatus = 3
			IF FOUND()
				loc_nFlag = 1
			ENDIF
		ENDIF

		RETURN loc_nFlag
	ENDPROC

	*==========================================================================
	* PrepararMemoSQL - Prepara campo memo/texto para SQL (NULL ou 'texto')
	*==========================================================================
	PROTECTED PROCEDURE PrepararMemoSQL(par_mTexto)
		LOCAL loc_cValor
		loc_cValor = ALLTRIM(NVL(CAST(par_mTexto AS CHARACTER), ""))

		IF EMPTY(loc_cValor)
			RETURN "NULL"
		ENDIF

		loc_cValor = SUBSTR(loc_cValor, 1, 4000)
		loc_cValor = STRTRAN(loc_cValor, "'", "''")

		RETURN "'" + loc_cValor + "'"
	ENDPROC

ENDDEFINE

