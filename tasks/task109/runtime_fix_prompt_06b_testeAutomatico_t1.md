# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'FormParaRelatorio': Metodo FormParaRelatorio nao encontrado

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-05 21:21:42] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-05 21:21:42] [INFO] Config FPW: (nao fornecido)
[2026-06-05 21:21:42] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-05 21:21:42] [INFO] Timeout: 300 segundos
[2026-06-05 21:21:42] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q153mtfg.prg
[2026-06-05 21:21:42] [INFO] Conteudo do wrapper:
[2026-06-05 21:21:42] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigregnf', 'C:\4c\tasks\task109', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigregnf', 'C:\4c\tasks\task109', 'REPORT'
QUIT

[2026-06-05 21:21:42] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q153mtfg.prg
[2026-06-05 21:21:42] [INFO] VFP output esperado em: C:\4c\tasks\task109\vfp_output.txt
[2026-06-05 21:21:42] [INFO] Executando Visual FoxPro 9...
[2026-06-05 21:21:42] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q153mtfg.prg
[2026-06-05 21:21:42] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q153mtfg.prg
[2026-06-05 21:21:42] [INFO] Timeout configurado: 300 segundos
[2026-06-05 21:21:50] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-05 21:21:50] [INFO] VFP9 finalizado em 7.6778229 segundos
[2026-06-05 21:21:50] [INFO] Exit Code: 
[2026-06-05 21:21:50] [INFO] 
[2026-06-05 21:21:50] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-05 21:21:50] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q153mtfg.prg
[2026-06-05 21:21:50] [INFO] 
[2026-06-05 21:21:50] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-05 21:21:50] [INFO] * Auto-generated wrapper for parameters
[2026-06-05 21:21:50] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-05 21:21:50] [INFO] * Parameters: 'Formsigregnf', 'C:\4c\tasks\task109', 'REPORT'
[2026-06-05 21:21:50] [INFO] 
[2026-06-05 21:21:50] [INFO] * Anti-dialog protections for unattended execution
[2026-06-05 21:21:50] [INFO] SET SAFETY OFF
[2026-06-05 21:21:50] [INFO] SET RESOURCE OFF
[2026-06-05 21:21:50] [INFO] SET TALK OFF
[2026-06-05 21:21:50] [INFO] SET NOTIFY OFF
[2026-06-05 21:21:50] [INFO] SYS(2335, 0)
[2026-06-05 21:21:50] [INFO] 
[2026-06-05 21:21:50] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigregnf', 'C:\4c\tasks\task109', 'REPORT'
[2026-06-05 21:21:50] [INFO] QUIT
[2026-06-05 21:21:50] [INFO] 
[2026-06-05 21:21:50] [INFO] === Fim do Wrapper.prg ===
[2026-06-05 21:21:50] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigregnf",
  "timestamp": "20260605212150",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "FormParaRelatorio",
      "passou": false,
      "erro": "Metodo FormParaRelatorio nao encontrado",
      "detalhes": ""
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
      "detalhes": "Modo VISUALIZAR configurado"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form REPORT com BtnIncluirClick sem navegacao por PageFrame (OK)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
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
      "detalhes": "AbrirLookup: 2 (ABRIRLOOKUPSERIE, ABRIRLOOKUPUSUARS) | KeyPress handlers: 3 (KEYPRESS, TECLASERIEKEYPRESS, TECLAUSUARSKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigregnf.prg):
*==============================================================================
* FORMSIGREGNF.PRG
* Formulario: Emissao Global de Nota Fiscal
* Tipo: RELATORIO / OPERACIONAL (frmrelatorio)
* Herda de: FormBase
*
* Migracao de: SIGREGNF.SCX
* Entidade: Notas Fiscais (SigMvNfi)
*==============================================================================

DEFINE CLASS Formsigregnf AS FormBase
	ShowWindow = 1
	WindowType = 1

    *-- Propriedades especificas deste formulario
    this_oBusinessObject = .NULL.
    this_lNotasAnt       = .F.
    this_cSerieAnterior  = ""    && Valor anterior da serie (GotFocus)
    this_cUsuarsAnterior = ""    && Valor anterior do usuario (GotFocus)

    *--------------------------------------------------------------------------
    * Init - Delega ao FormBase que chama InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura formulario de emissao global de NF
    * Os cursores de trabalho (cursor_4c_TmpNFis, cursor_4c_SigCdSer) sao
    * criados pelo sigregnfBO.Init() ao chamar CREATEOBJECT abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Criar Business Object (BO.Init() cria cursores e carrega SigCdPam/SigCdSer)
            THIS.this_oBusinessObject = CREATEOBJECT("sigregnfBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio de " + ;
                        "Emiss" + CHR(227) + "o Global de Nota Fiscal", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Propriedades visuais do form (EXATAS do original)
            THIS.Width        = 800
            THIS.Height       = 700
            THIS.AutoCenter   = .T.
            THIS.BorderStyle  = 2
            THIS.Caption      = "Emiss" + CHR(227) + "o Global de Nota Fiscal"
            THIS.FontName     = "Tahoma"
            THIS.FontSize     = 8
            THIS.MaxButton    = .F.
            THIS.MinButton    = .F.

            *-- Configurar elementos visuais
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoesRelatorio()
            THIS.ConfigurarPageFrame()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            THIS.Visible  = .T.
            loc_lSucesso  = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do formulario
    *   Replica cntSombra do frmrelatorio framework.vcx
    *   BackColor = RGB(100,100,100): cinza medio opaco (NAO escuro)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0,0,0)
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o Global de Nota Fiscal"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255,255,255)
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o Global de Nota Fiscal"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - CommandGroup com 4 botoes do relatorio
    * Geometria EXATA do frmrelatorio framework.vcx (btnReport original):
    *   cmg_4c_Botoes: Left=526 (original btnReport.Left=526), Width=273, Height=80
    *   Botoes: Width=65, Height=70, PicturePosition=13 (icone acima da legenda)
    *   Lefts: Buttons(1)=5, Buttons(2)=71, Buttons(3)=137, Buttons(4)=203
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 526
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136,189,188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption         = "Visualizar"
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Caption         = "Imprimir"
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
            ENDWITH

            WITH .Buttons(3)
                .Caption         = "DocExcel"
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
            ENDWITH

            WITH .Buttons(4)
                .Caption         = "Sair"
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
                .Cancel          = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura layout principal do form REPORT (FLAT)
    *   Este form herda de FormBase mas eh do tipo OPERACIONAL/REPORT (frmrelatorio):
    *   NAO usa PageFrame com Page1=Lista/Page2=Dados. O layout eh plano,
    *   com cabecalho + botoes de relatorio (topo) + corpo (filtros + grid +
    *   botoes auxiliares de selecao).
    *
    *   Este metodo cria o container cnt_4c_Corpo que hospedara nas fases
    *   seguintes: filtros de Serie/Usuario (Fase 5), grid de notas fiscais
    *   selecionaveis com CheckBox (Fase 4), botoes Processar/SelTudo/Apaga
    *   (Fase 6) e BINDEVENTs com toda logica de selecao e impressao (Fase 7-8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Corpo", "Container")
        WITH THIS.cnt_4c_Corpo
            .Top         = 85
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height - 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Filtros de entrada (Serie + Usuario)
    *   Form REPORT FLAT (sem PageFrame): "Dados" representa os campos de
    *   filtro/parametro do relatorio (analogo a Page2.Dados de CRUD).
    *   Replica Say1/Say2/Get_S?rie/getUsuars do SIGREGNF.SCX original.
    *   Top: original-85 (cnt_4c_Corpo comeca em 85, original mede do form).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCp
        loc_oCp = THIS.cnt_4c_Corpo

        *-- Label Serie (original: top=173, left=48 -> corpo: top=88)
        loc_oCp.AddObject("lbl_4c_Serie", "Label")
        WITH loc_oCp.lbl_4c_Serie
            .Top       = 88
            .Left      = 48
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "S" + CHR(233) + "rie : "
            .Visible   = .T.
        ENDWITH

        *-- TextBox Serie (original: top=169, left=93, w=34, h=23 -> corpo: top=84)
        loc_oCp.AddObject("txt_4c_Serie", "TextBox")
        WITH loc_oCp.txt_4c_Serie
            .Top                = 84
            .Left               = 93
            .Width              = 34
            .Height             = 23
            .Value              = SPACE(3)
            .FontName           = "Tahoma"
            .FontSize           = 8
            .MaxLength          = 3
            .Alignment          = 3
            .ForeColor          = RGB(0,0,0)
            .DisabledBackColor  = RGB(255,255,255)
            .Visible            = .T.
        ENDWITH

        *-- Label Usuario (original: top=173, left=138 -> corpo: top=88)
        loc_oCp.AddObject("lbl_4c_Usuars", "Label")
        WITH loc_oCp.lbl_4c_Usuars
            .Top       = 88
            .Left      = 138
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Visible   = .T.
        ENDWITH

        *-- TextBox Usuario (original: top=169, left=198, w=80, h=23 -> corpo: top=84)
        loc_oCp.AddObject("txt_4c_Usuars", "TextBox")
        WITH loc_oCp.txt_4c_Usuars
            .Top                = 84
            .Left               = 198
            .Width              = 80
            .Height             = 23
            .Value              = SPACE(10)
            .FontName           = "Tahoma"
            .FontSize           = 8
            .MaxLength          = 10
            .Alignment          = 3
            .ForeColor          = RGB(0,0,0)
            .DisabledBackColor  = RGB(255,255,255)
            .Visible            = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    * BO.Destroy() e responsavel por fechar os cursores de trabalho.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Popula cnt_4c_Corpo com grid de NFs e botoes de
    *   selecao (Processar/SelTudo/Apaga). Os filtros (Serie/Usuario) sao
    *   criados em ConfigurarPaginaDados (chamado antes deste metodo).
    *   Replica layout do SIGREGNF.SCX (posicoes relativas ao corpo = original - 85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oCp
        loc_oCp = THIS.cnt_4c_Corpo

        *-- Botao Processar (original: top=96, left=696 -> corpo: top=11)
        loc_oCp.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oCp.cmd_4c_Processar
            .Top             = 11
            .Left            = 696
            .Width           = 75
            .Height          = 75
            .Caption         = "P\<rocessar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid de NFs (original: top=195, left=30, w=739, h=364 -> corpo: top=110)
        THIS.ConfigurarGridNF(loc_oCp)

        *-- Botao SelTudo (original: top=561, left=30, w=45, h=45)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top           = 561
            .Left          = 30
            .Width         = 45
            .Height        = 45
            .Caption       = ""
            .FontName      = "Verdana"
            .FontSize      = 8
            .SpecialEffect = 0
            .ForeColor     = RGB(36,84,155)
            .BackColor     = RGB(255,255,255)
            .Themes        = .F.
            .MousePointer  = 15
            .ToolTipText   = "Selecionar Tudo"
            .Visible       = .T.
        ENDWITH

        *-- Botao Apaga (original: top=561, left=75, w=45, h=45)
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top           = 561
            .Left          = 75
            .Width         = 45
            .Height        = 45
            .Caption       = ""
            .FontName      = "Verdana"
            .FontSize      = 8
            .SpecialEffect = 0
            .ForeColor     = RGB(36,84,155)
            .BackColor     = RGB(255,255,255)
            .Themes        = .F.
            .MousePointer  = 15
            .ToolTipText   = "Desmarcar Tudo"
            .Visible       = .T.
        ENDWITH

        THIS.VincularEventos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridNF - Grid de 9 colunas: CheckBox(Flag), Num, Serie, Emis,
    *   Op, CFOP, Valor, Operacao, Emitente. Ordem obrigatoria Column1:
    *   AddObject -> Caption -> CurrentControl -> ControlSource (Error 1767)
    *   ColumnOrder: Column4.ColumnOrder=5, Column5.ColumnOrder=4 (Op exibe
    *   antes de Emissao, replicando ColumnOrder do original SIGREGNF.Grade).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridNF(par_oCp)
        par_oCp.AddObject("grd_4c_Dados", "Grid")
        WITH par_oCp.grd_4c_Dados
            .Top                = 110
            .Left               = 30
            .Width              = 739
            .Height             = 364
            .ColumnCount        = 9
            .RecordSource       = "cursor_4c_TmpNFis"
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .FontName           = "Tahoma"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .HighlightStyle     = 2
            .GridLineColor      = RGB(238,238,238)
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)
            .ForeColor          = RGB(90,90,90)
            .BackColor          = RGB(255,255,255)
            .Visible            = .T.

            WITH .Column1
                .Width             = 15
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .Sparse            = .F.
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Caption   = ""
                    .Value     = 0
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                .CurrentControl    = "Check1"
                .ControlSource     = "cursor_4c_TmpNFis.Flag"
                .Header1.Caption   = ""
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column2
                .Width             = 45
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontBold          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.NFis"
                .Header1.Caption   = "N" + CHR(250) + "mero"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column3
                .Width             = 28
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.Series"
                .Header1.Caption   = "S" + CHR(233) + "rie"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column4
                .Width             = 62
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ColumnOrder       = 5
                .ControlSource     = "cursor_4c_TmpNFis.Emis"
                .Header1.Caption   = "Emiss" + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column5
                .Width             = 18
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ColumnOrder       = 4
                .ControlSource     = "cursor_4c_TmpNFis.Operas"
                .Header1.Caption   = "Op"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column6
                .Width             = 60
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.CFis"
                .Header1.Caption   = "CFOP"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column7
                .Width             = 75
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .InputMask         = "999,999,999.99"
                .ControlSource     = "cursor_4c_TmpNFis.TotNotas"
                .Header1.Caption   = "Valor Total"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column8
                .Width             = 150
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.Operacao"
                .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column9
                .Width             = 246
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.Conta"
                .Header1.Caption   = "Emitente / Detinat" + CHR(225) + "rio"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Refresh da area de dados (form FLAT sem page switching)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
                THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia filtros do form para o BO antes de SelecionarDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cSeries = PADR(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value), 3)
            .this_cUsuars = PADR(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value), 10)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventos - BINDEVENTs para filtros e botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventos()
        BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Serie, "GotFocus", THIS, "SerieGotFocus")
        BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Serie, "KeyPress", THIS, "TeclaSerieKeyPress")
        BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Usuars, "GotFocus", THIS, "UsuarsGotFocus")
        BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Usuars, "KeyPress", THIS, "TeclaUsuarsKeyPress")
        BINDEVENT(THIS.cnt_4c_Corpo.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * SerieGotFocus - Salva valor inicial da serie para deteccao de mudanca
    *--------------------------------------------------------------------------
    PROCEDURE SerieGotFocus()
        THIS.this_cSerieAnterior = PADR(THIS.cnt_4c_Corpo.txt_4c_Serie.Value, 3)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaSerieKeyPress - F4(115)=lookup direto, ENTER(13)/TAB(9)=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaSerieKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSerie()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cSerie
            loc_cSerie = PADR(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value), 3)
            IF !EMPTY(ALLTRIM(loc_cSerie))
                THIS.ValidarSerie(loc_cSerie)
            ENDIF
            IF PADR(THIS.this_cSerieAnterior, 3) # PADR(THIS.cnt_4c_Corpo.txt_4c_Serie.Value, 3)
                THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSerie - Abre FormBuscaAuxiliar para selecao de serie (SigCnFNf)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSerie()
        LOCAL loc_oLookup, loc_cSerie
        loc_cSerie = ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value)
        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                      "SigCnFNf", "cursor_4c_BuscaSerie", "Series", loc_cSerie, ;
                      "Sele" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.mAddColuna("Series", "", "S" + CHR(233) + "rie")
            IF !loc_oLookup.this_lSelecionou
                loc_oLookup.Show()
            ENDIF
            IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaSerie")
                SELECT cursor_4c_BuscaSerie
                IF !EOF()
                    THIS.cnt_4c_Corpo.txt_4c_Serie.Value = PADR(ALLTRIM(Series), 3)
                    THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
                ENDIF
                USE IN cursor_4c_BuscaSerie
            ENDIF
            loc_oLookup.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSerie - Valida serie digitada contra SigCnFNf; abre lookup se nao achar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarSerie(par_cSerie)
        LOCAL loc_nResult, loc_lAchou
        loc_lAchou = .F.
        IF USED("cursor_4c_SerieVal")
            USE IN cursor_4c_SerieVal
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 Series FROM SigCnFNf WHERE Series = " + EscaparSQL(par_cSerie), ;
            "cursor_4c_SerieVal")
        IF loc_nResult > 0 AND USED("cursor_4c_SerieVal")
            SELECT cursor_4c_SerieVal
            loc_lAchou = !EOF()
            USE IN cursor_4c_SerieVal
        ENDIF
        IF !loc_lAchou
            IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
                THIS.AbrirLookupSerie()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarsGotFocus - Salva valor inicial do usuario para deteccao de mudanca
    *--------------------------------------------------------------------------
    PROCEDURE UsuarsGotFocus()
        THIS.this_cUsuarsAnterior = PADR(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value, 10)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaUsuarsKeyPress - F4(115)=lookup direto, ENTER(13)/TAB(9)=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaUsuarsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupUsuars()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cUsuars
            loc_cUsuars = PADR(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value), 10)
            IF !EMPTY(ALLTRIM(loc_cUsuars))
                THIS.ValidarUsuars(loc_cUsuars)
            ENDIF
            IF PADR(THIS.this_cUsuarsAnterior, 10) # PADR(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value, 10)
                THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUsuars - Abre FormBuscaAuxiliar para selecao de usuario (SigCdUsu)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUsuars()
        LOCAL loc_oLookup, loc_cUsuars
        loc_cUsuars = ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value)
        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                      "SigCdUsu", "cursor_4c_BuscaUsuars", "Usuars", loc_cUsuars, ;
                      "Sele" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.mAddColuna("Usuars", "", "Usu" + CHR(225) + "rio")
            IF !loc_oLookup.this_lSelecionou
                loc_oLookup.Show()
            ENDIF
            IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaUsuars")
                SELECT cursor_4c_BuscaUsuars
                IF !EOF()
                    THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = PADR(ALLTRIM(Usuars), 10)
                    THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
                ENDIF
                USE IN cursor_4c_BuscaUsuars
            ENDIF
            loc_oLookup.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuars - Valida usuario digitado contra SigCdUsu; abre lookup se nao achar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarUsuars(par_cUsuars)
        LOCAL loc_nResult, loc_lAchou
        loc_lAchou = .F.
        IF USED("cursor_4c_UsuarsVal")
            USE IN cursor_4c_UsuarsVal
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 Usuars FROM SigCdUsu WHERE Usuars = " + EscaparSQL(par_cUsuars), ;
            "cursor_4c_UsuarsVal")
        IF loc_nResult > 0 AND USED("cursor_4c_UsuarsVal")
            SELECT cursor_4c_UsuarsVal
            loc_lAchou = !EOF()
            USE IN cursor_4c_UsuarsVal
        ENDIF
        IF !loc_lAchou
            IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
                THIS.AbrirLookupUsuars()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Executa SelecionarDados e preenche o grid com NFs
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.SelecionarDados()
            THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .F.
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
        IF USED("cursor_4c_TmpNFis") AND !EOF("cursor_4c_TmpNFis")
            THIS.cnt_4c_Corpo.grd_4c_Dados.Column1.Check1.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTudoClick - Marca todos os registros do grid (Flag=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTudoClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodos()
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnApagaClick - Desmarca todos os registros do grid (Flag=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnApagaClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DesmarcarTodos()
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza NF do registro corrente no grid via SigPrNfs
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        IF !USED("cursor_4c_TmpNFis") OR EOF("cursor_4c_TmpNFis")
            MsgAviso("Nenhuma nota fiscal dispon" + CHR(237) + "vel para visualizar.", ;
                     "Visualizar")
            RETURN
        ENDIF
        IF !THIS.this_oBusinessObject.Processamento()
            RETURN
        ENDIF
        IF !THIS.this_oBusinessObject.Visualizacao()
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Processa e imprime todas as NFs marcadas (Flag=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        IF !USED("cursor_4c_TmpNFis") OR RECCOUNT("cursor_4c_TmpNFis") = 0
            MsgAviso("Nenhuma nota fiscal dispon" + CHR(237) + "vel para impress" + ;
                     CHR(227) + "o.", "Impress" + CHR(227) + "o")
            RETURN
        ENDIF
        GO TOP IN cursor_4c_TmpNFis
        IF !THIS.this_oBusinessObject.Processamento()
            RETURN
        ENDIF
        IF !THIS.this_oBusinessObject.Impressao()
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
        THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exportacao Excel nao disponivel para este relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o DocExcel n" + CHR(227) + ;
                 "o dispon" + CHR(237) + "vel para este relat" + CHR(243) + "rio.", ;
                 "DocExcel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Form REPORT/OPERACIONAL: incluir nao se aplica.
    *   Mapeado para Processar (seleciona NFs nao impressas para a Serie/Usuario
    *   informados), que e a unica operacao de "carga/inclusao" do form SIGREGNF.
    *   Habilita visibilmente o botao caso o usuario chegue via tecla padrao CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
                THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
            ENDIF
        ENDIF
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Form REPORT/OPERACIONAL: alterar nao se aplica.
    *   Mapeado para Visualizar (preview da NF do registro corrente do grid),
    *   que e a operacao mais proxima de "abrir/editar" no fluxo do SIGREGNF.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_TmpNFis") OR EOF("cursor_4c_TmpNFis")
            MsgAviso("Processe a sele" + CHR(231) + CHR(227) + "o de notas fiscais " + ;
                     "antes de visualizar.", "Visualizar")
            RETURN
        ENDIF
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Form REPORT/OPERACIONAL: excluir nao se aplica.
    *   Mapeado para Apaga (desmarca todas as NFs do grid), que e a operacao
    *   de "limpeza/exclusao" disponivel no fluxo do SIGREGNF.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED("cursor_4c_TmpNFis") OR RECCOUNT("cursor_4c_TmpNFis") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas fiscais para " + ;
                     "desmarcar.", "Desmarcar")
            RETURN
        ENDIF
        THIS.BtnApagaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Form REPORT: buscar equivale a Processar (carregar grid)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Form REPORT: salvar equivale a Imprimir NFs marcadas
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa filtros e grid, reseta estado do formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia filtros do BO de volta para os campos do form
    * Para form REPORT: repoe Serie e Usuario conforme propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        WITH THIS.this_oBusinessObject
            THIS.cnt_4c_Corpo.txt_4c_Serie.Value  = PADR(ALLTRIM(.this_cSeries), 3)
            THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = PADR(ALLTRIM(.this_cUsuars), 10)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de filtro
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.cnt_4c_Corpo) # "O"
            RETURN
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Serie", 5)
            THIS.cnt_4c_Corpo.txt_4c_Serie.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Usuars", 5)
            THIS.cnt_4c_Corpo.txt_4c_Usuars.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
            THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
            THIS.cmd_4c_SelTudo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
            THIS.cmd_4c_Apaga.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa filtros, esvazia grid e reseta botao Processar
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Serie", 5)
                THIS.cnt_4c_Corpo.txt_4c_Serie.Value  = SPACE(3)
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Usuars", 5)
                THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = SPACE(10)
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
                THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .F.
            ENDIF
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cSeries  = ""
            THIS.this_oBusinessObject.this_cUsuars  = ""
            THIS.this_oBusinessObject.this_lNotasAnt = .F.
            IF USED("cursor_4c_TmpNFis")
                ZAP IN cursor_4c_TmpNFis
            ENDIF
        ENDIF
        THIS.this_cSerieAnterior  = ""
        THIS.this_cUsuarsAnterior = ""
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
                THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega o grid com dados do banco (se filtros preenchidos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value))
            RETURN .F.
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        THIS.FormParaBO()
        loc_lSucesso = THIS.this_oBusinessObject.SelecionarDados()
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
                THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme disponibilidade de dados
    * Form REPORT: habilita/desabilita Processar conforme Serie informada
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemSerie, loc_lTemDados
        IF VARTYPE(THIS.cnt_4c_Corpo) # "O"
            RETURN
        ENDIF
        loc_lTemSerie = !EMPTY(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value))
        loc_lTemDados = USED("cursor_4c_TmpNFis") AND RECCOUNT("cursor_4c_TmpNFis") > 0

        IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
            THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = loc_lTemSerie
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
            THIS.cmd_4c_SelTudo.Enabled = loc_lTemDados
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
            THIS.cmd_4c_Apaga.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigregnfBO.prg):
*==============================================================================
* SIGREGNFBO.PRG
* Business Object - Emissao Global de Nota Fiscal
*
* Herda de RelatorioBase
* Selecao, verificacao, impressao e visualizacao de NFs
* Form legado: sigregnf.SCX (classe frmrelatorio)
*==============================================================================

DEFINE CLASS sigregnfBO AS RelatorioBase

    *-- Filtros de selecao (preenchidos pelo form antes de SelecionarDados)
    this_cSeries            = ""    && Serie da NF para filtro (C, 3)
    this_cUsuars            = ""    && Usuario para filtro (C, 10 - vazio = todos)

    *-- Estado interno do processamento
    this_lNotasAnt          = .F.   && .T. se existem notas anteriores nao impressas desta serie

    *-- Dados auxiliares carregados no Init
    this_cMascNums          = ""    && Mascara de numeracao de SigCdPam.MascNums

    *-- Nomes dos cursors de trabalho persistentes
    this_cCursorNFis        = "cursor_4c_TmpNFis"     && Dados das NFs selecionadas (usado no grid)
    this_cCursorClientes    = "cursor_4c_Clientes"    && Cache de clientes (Iclis/RClis)
    this_cCursorSeries      = "cursor_4c_SigCdSer"    && Series carregadas no Init (persiste para busca)

    *-- Mensagem de erro para o form exibir
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Cria cursors de trabalho e carrega dados auxiliares do banco
    * Equivalente ao Load + Init do legado: fConfigGeral + SigCdPam + SigCdSer
    * Em modo gb_4c_ValidandoUI (.T.) os cursores sao criados vazios sem SQL.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Cursor principal: equivalente ao TmpNFis do legado
            IF USED(THIS.this_cCursorNFis)
                USE IN (THIS.this_cCursorNFis)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorNFis) ;
                (Flag l, ;
                 Emis d, ;
                 Series c(3), ;
                 Operas c(1), ;
                 CFis c(10), ;
                 NFis c(6), ;
                 TotNotas n(12,2), ;
                 Conta c(40), ;
                 Operacao c(30), ;
                 Emps c(3), ;
                 Dopes c(20), ;
                 Numes n(6))
            INDEX ON NFis TAG NFis

            *-- Cursor auxiliar de clientes: equivalente ao crClientes do legado
            IF USED(THIS.this_cCursorClientes)
                USE IN (THIS.this_cCursorClientes)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorClientes) ;
                (Iclis c(10), RClis c(50))
            INDEX ON Iclis TAG Iclis

            *-- Em modo ValidarUI sem conexao SQL, cursores vazios sao suficientes
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = DODEFAULT()
            ELSE
                *-- Carregar mascara de numeracao de SigCdPam
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT MascNums FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nResult > 0 AND USED("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    IF !EOF()
                        THIS.this_cMascNums = ALLTRIM(NVL(MascNums, ""))
                    ENDIF
                    USE IN cursor_4c_SigCdPam
                ENDIF

                *-- Carregar series para validacao em SelecionarDados (mantido aberto)
                IF USED(THIS.this_cCursorSeries)
                    USE IN (THIS.this_cCursorSeries)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT EmpCods, TipoNfs FROM SigCdSer", ;
                    THIS.this_cCursorSeries)
                IF loc_nResult > 0 AND USED(THIS.this_cCursorSeries)
                    SELECT (THIS.this_cCursorSeries)
                    INDEX ON EmpCods TAG EmpCods
                    loc_lSucesso = DODEFAULT()
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdSer"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro do BO
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Hook de RelatorioBase: prepara dados para a tela/relatorio
    * Delega para SelecionarDados que monta filtros (Serie + Usuario opcional)
    * e popula cursor_4c_TmpNFis com as NFs disponiveis para impressao
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cSeries))
                THIS.this_cMensagemErro = "S" + CHR(233) + "rie n" + CHR(227) + ;
                                          "o informada"
            ELSE
                loc_lSucesso = THIS.SelecionarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente em cursor_4c_TmpNFis
    * Formato: Emps + Dopes + Numes (mesmo padrao EmpDopNums do legado)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED(THIS.this_cCursorNFis)
            SELECT (THIS.this_cCursorNFis)
            IF !EOF() AND !BOF()
                loc_cChave = EVALUATE(THIS.this_cCursorNFis + ".Emps") + ;
                             ALLTRIM(EVALUATE(THIS.this_cCursorNFis + ".Dopes")) + ;
                             STR(EVALUATE(THIS.this_cCursorNFis + ".Numes"), 6)
            ENDIF
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de emissao/visualizacao de NFs
    * Insere em LogAuditoria via INSERT direto (sem BusinessBase neste fluxo)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF !EMPTY(loc_cChave)
                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                           "(Tabela, ChaveRegistro, Operacao, Usuario, DataHora) VALUES (" + ;
                           EscaparSQL("SigMvNfi") + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           "GETDATE())"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lSucesso = (loc_nResult >= 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Seleciona NFs disponiveis para impressao
    * Filtra por Serie (obrigatorio) e Usuario (opcional)
    * Popula cursor_4c_TmpNFis com NFs nao impressas/canceladas
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_lAbortado
        LOCAL loc_cEmpr, loc_cSeries, loc_cUsuars
        LOCAL loc_lcCli, loc_cDopes, loc_cEmps, loc_cMvSeries, loc_nNumes
        LOCAL loc_dEmis, loc_cOperas, loc_cCFis, loc_cNFis, loc_nTotNotas, loc_cCliFors
        loc_lSucesso = .F.
        TRY
            ZAP IN (THIS.this_cCursorNFis)
            WAIT WINDOW "Aguarde!!! Selecionando Notas Fiscais..." NOWAIT

            loc_cEmpr   = go_4c_Sistema.cCodEmpresa
            loc_cSeries = PADR(THIS.this_cSeries, 3)
            loc_cUsuars = PADR(THIS.this_cUsuars, 10)
            loc_lAbortado = .F.

            *-- Seleciona NFs nao impressas/canceladas da serie indicada
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                *-- Sem filtro de usuario: query direta em SigMvNfi
                loc_cSQL = "SELECT a.Emis, a.Series, a.Operas, a.CFis, a.NFis, " + ;
                           "a.TotNotas, a.CliFors, a.Emps, a.Dopes, a.Numes, b.Rclis " + ;
                           "FROM SigMvNfi a " + ;
                           "LEFT JOIN SigCdCli b ON b.Iclis = a.CliFors " + ;
                           "WHERE a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                           " AND a.Series = " + EscaparSQL(loc_cSeries) + ;
                           " AND a.Cancelas = 0 AND a.Impress = 0 " + ;
                           "ORDER BY a.NFis"
            ELSE
                *-- Com filtro de usuario: join via SigMvCab para filtrar por Usuars
                loc_cSQL = "SELECT a.Emis, a.Series, a.Operas, a.CFis, a.NFis, " + ;
                           "a.TotNotas, a.CliFors, a.Emps, a.Dopes, a.Numes, c.Rclis " + ;
                           "FROM SigMvNfi a " + ;
                           "INNER JOIN SigMvCab cab ON cab.EmpDopNums = a.EmpDopNums " + ;
                           "LEFT JOIN SigCdCli c ON c.Iclis = a.CliFors " + ;
                           "WHERE a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                           " AND a.Series = " + EscaparSQL(loc_cSeries) + ;
                           " AND cab.Usuars = " + EscaparSQL(loc_cUsuars) + ;
                           " AND a.Cancelas = 0 AND a.Impress = 0 " + ;
                           "ORDER BY a.NFis"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao selecionar NFs"
                loc_lAbortado = .T.
            ENDIF

            IF !loc_lAbortado
                *-- Carrega operacoes para filtragem por tipo
                IF USED("cursor_4c_SigCdOpe")
                    USE IN cursor_4c_SigCdOpe
                ENDIF
                loc_nResult2 = SQLEXEC(gnConnHandle, ;
                    "SELECT Dopes, TipoNfs, Nfiscals, Agrupas FROM SigCdOpe", ;
                    "cursor_4c_SigCdOpe")
                IF loc_nResult2 < 1 OR !USED("cursor_4c_SigCdOpe")
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdOpe)"
                    loc_lAbortado = .T.
                ELSE
                    SELECT cursor_4c_SigCdOpe
                    INDEX ON Dopes TAG Dopes ADDITIVE
                ENDIF
            ENDIF

            IF !loc_lAbortado
                *-- Scan: aplica filtros de tipo e insere em cursor_4c_TmpNFis
                SELECT cursor_4c_SigMvNfi
                SCAN
                    *-- Captura campos antes de mudar work area
                    loc_lcCli     = ALLTRIM(NVL(cursor_4c_SigMvNfi.Rclis, ""))
                    loc_cDopes    = cursor_4c_SigMvNfi.Dopes
                    loc_cEmps     = cursor_4c_SigMvNfi.Emps
                    loc_cMvSeries = cursor_4c_SigMvNfi.Series
                    loc_nNumes    = cursor_4c_SigMvNfi.Numes
                    loc_dEmis     = cursor_4c_SigMvNfi.Emis
                    loc_cOperas   = cursor_4c_SigMvNfi.Operas
                    loc_cCFis     = cursor_4c_SigMvNfi.CFis
                    loc_cNFis     = cursor_4c_SigMvNfi.NFis
                    loc_nTotNotas = cursor_4c_SigMvNfi.TotNotas
                    loc_cCliFors  = cursor_4c_SigMvNfi.CliFors

                    =SEEK(loc_cDopes, "cursor_4c_SigCdOpe", "Dopes")

                    IF !SEEK(loc_cEmpr + loc_cMvSeries, THIS.this_cCursorSeries, "EmpCods")
                        =SEEK(SPACE(3) + loc_cMvSeries, THIS.this_cCursorSeries, "EmpCods")
                    ENDIF

                    *-- Filtra por tipo de NF (igual ao legado)
                    IF !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.TipoNfs = 4
                        IF EOF(THIS.this_cCursorSeries) OR ;
                           EVALUATE(THIS.this_cCursorSeries + ".TipoNfs") = 2
                            LOOP
                        ENDIF
                    ELSE
                        IF !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.TipoNfs = 2
                            LOOP
                        ENDIF
                        IF EOF(THIS.this_cCursorSeries) OR ;
                           EVALUATE(THIS.this_cCursorSeries + ".TipoNfs") = 2
                            LOOP
                        ENDIF
                    ENDIF

                    INSERT INTO (THIS.this_cCursorNFis) ;
                        (Flag, Emis, Series, Operas, CFis, NFis, TotNotas, Conta, ;
                         Operacao, Emps, Dopes, Numes) ;
                        VALUES (.T., ;
                                NVL(loc_dEmis, CTOD("")), ;
                                loc_cMvSeries, ;
                                loc_cOperas, ;
                                loc_cCFis, ;
                                loc_cNFis, ;
                                loc_nTotNotas, ;
                                loc_cCliFors + " " + loc_lcCli, ;
                                loc_cEmps + ALLTRIM(loc_cDopes) + ;
                                    " " + ALLTRIM(fGerMascara(loc_nNumes)), ;
                                loc_cEmps, ;
                                loc_cDopes, ;
                                loc_nNumes)
                ENDSCAN

                IF USED("cursor_4c_SigCdOpe")
                    USE IN cursor_4c_SigCdOpe
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            WAIT CLEAR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarNf - Verifica se existem NFs anteriores nao impressas da serie
    * Retorna .T. se pode prosseguir, .F. se ha bloqueio por nota anterior
    *--------------------------------------------------------------------------
    PROCEDURE VerificarNf()
        LOCAL loc_lSucesso, loc_nResult, loc_lAbortado
        LOCAL loc_lcEdn, loc_lcSql, loc_lcNota, loc_lcTxt
        LOCAL loc_cVEmps, loc_cVDopes, loc_cVSeries, loc_nVNumes, loc_cVNFis
        loc_lSucesso = .T.
        TRY
            loc_lAbortado = .F.
            SELECT (THIS.this_cCursorNFis)
            SCAN WHILE !loc_lAbortado
                IF !Flag
                    LOOP
                ENDIF
                loc_cVEmps   = Emps
                loc_cVDopes  = Dopes
                loc_cVSeries = Series
                loc_nVNumes  = Numes
                loc_cVNFis   = NFis

                loc_lcEdn = loc_cVEmps + loc_cVDopes + STR(loc_nVNumes, 6)

                loc_lcSql = "SELECT DISTINCT c.Nfis, c.EmpDopNums " + ;
                            "FROM SigMvNfi c, SigCdOpe a " + ;
                            "WHERE c.emps = " + EscaparSQL(loc_cVEmps) + ;
                            " AND c.series = " + EscaparSQL(loc_cVSeries) + ;
                            " AND c.Impress = 0 AND c.cancelas = 0" + ;
                            " AND c.dopes = a.dopes AND a.nfiscals IN (1,2)" + ;
                            " AND a.tiponfs <> 4 AND a.agrupas = 1" + ;
                            " UNION ALL " + ;
                            "SELECT DISTINCT c.Nfis, c.EmpDopNums " + ;
                            "FROM SigMvNfi c, SigCdOpe a, SigCdSer b " + ;
                            "WHERE c.emps = " + EscaparSQL(loc_cVEmps) + ;
                            " AND c.series = " + EscaparSQL(loc_cVSeries) + ;
                            " AND c.Impress = 0 AND c.cancelas = 0" + ;
                            " AND c.series = b.cods AND c.dopes = a.dopes" + ;
                            " AND a.nfiscals IN (1,2) AND a.tiponfs = 4 AND b.impnfs = 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_TmpFiscal")
                IF loc_nResult < 0
                    MsgErro("Favor reinicializar o processo.", ;
                            "Falha na Conex" + CHR(227) + "o (TmpFiscal)")
                    loc_lSucesso  = .F.
                    loc_lAbortado = .T.
                ELSE
                    SELECT cursor_4c_TmpFiscal
                    IF RECCOUNT() > 0
                        LOCATE FOR EmpDopNums = loc_lcEdn
                        loc_lcNota = loc_cVNFis

                        SELECT * FROM cursor_4c_TmpFiscal ;
                            WHERE Nfis < loc_lcNota ;
                            INTO CURSOR cursor_4c_Selecao

                        SELECT cursor_4c_Selecao
                        IF RECCOUNT() > 0
                            loc_lcTxt = ""
                            SCAN
                                loc_lcTxt = loc_lcTxt + CHR(13) + ;
                                    "Nota : " + cursor_4c_Selecao.NFis + ;
                                    " - Opera" + CHR(231) + CHR(227) + "o : " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 01, 03)) + ;
                                    " / " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 04, 20)) + ;
                                    " / " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 24, 06)) + ;
                                    SPACE(10)
                            ENDSCAN
                            MsgAviso("Existem Notas Anteriores Desta S" + CHR(233) + ;
                                     "rie Ainda N" + CHR(227) + ;
                                     "o Impressas!!!" + loc_lcTxt, ;
                                     "Aten" + CHR(231) + CHR(227) + "o!!!")
                            loc_lSucesso = .F.
                        ENDIF
                        IF USED("cursor_4c_Selecao")
                            USE IN cursor_4c_Selecao
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_TmpFiscal")
                        USE IN cursor_4c_TmpFiscal
                    ENDIF
                ENDIF
            ENDSCAN

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - Verifica sequencia de NFs antes de imprimir
    * Consulta SigCnFn2 e chama VerificarNf para detectar notas anteriores
    * Deve ser chamado pelo form antes de Impressao()
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cSeries, loc_cEmps
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorNFis) OR EOF(THIS.this_cCursorNFis)
            RETURN .F.
        ENDIF

        TRY
            THIS.this_lNotasAnt = .F.

            loc_cSeries = EVALUATE(THIS.this_cCursorNFis + ".Series")
            loc_cEmps   = EVALUATE(THIS.this_cCursorNFis + ".Emps")

            loc_cSQL = "SELECT Series, Emps, VSeqNota FROM SigCnFn2 " + ;
                       "WHERE Series = " + EscaparSQL(loc_cSeries) + ;
                       " AND Emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND VSeqNota = 1"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCnFnfT")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigCnFnfT)")
            ELSE
                SELECT cursor_4c_SigCnFnfT
                IF !EOF()
                    IF !THIS.VerificarNf()
                        THIS.this_lNotasAnt = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_SigCnFnfT")
                    USE IN cursor_4c_SigCnFnfT
                ENDIF

                SELECT (THIS.this_cCursorNFis)
                GO TOP

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Impressao - Imprime todas as NFs marcadas (Flag=.T.)
    * Chama SigPrNfs para cada NF marcada e recarrega lista ao final
    *--------------------------------------------------------------------------
    PROCEDURE Impressao()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_cEdn, loc_lAbortado
        LOCAL loc_lFlag, loc_cEmps, loc_cDopes, loc_nNumes, loc_cNFis
        loc_lSucesso = .F.

        IF THIS.this_lNotasAnt
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_TprMvCab")
                USE IN cursor_4c_TprMvCab
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))
            SET NULL OFF

            GO BOTTOM IN (THIS.this_cCursorNFis)
            GO TOP IN (THIS.this_cCursorNFis)

            loc_lAbortado = .F.
            SELECT (THIS.this_cCursorNFis)
            SCAN WHILE !loc_lAbortado
                loc_lFlag  = Flag
                loc_cEmps  = Emps
                loc_cDopes = Dopes
                loc_nNumes = Numes
                loc_cNFis  = NFis

                IF loc_lFlag
                    WAIT WINDOW "Imprimindo Nota Fiscal n" + CHR(186) + " " + ;
                        loc_cNFis NOWAIT

                    ZAP IN cursor_4c_TprMvCab

                    loc_cEdn = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)

                    *-- Busca cabecalho em SigMvCab
                    loc_cSQL = "SELECT Emps, Dopes, Numes, ContaOs, ContaDs, " + ;
                               "TpFats, Obses, ValVars FROM SigMvCab " + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCab")
                    IF loc_nResult < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (SigMvCab)")
                        loc_lAbortado = .T.
                    ENDIF

                    IF !loc_lAbortado
                        GO TOP IN cursor_4c_SigMvCab

                        INSERT INTO cursor_4c_TprMvCab ;
                            (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
                            VALUES (cursor_4c_SigMvCab.Emps, cursor_4c_SigMvCab.Dopes, ;
                                    cursor_4c_SigMvCab.Numes, cursor_4c_SigMvCab.ContaOs, ;
                                    cursor_4c_SigMvCab.ContaDs, cursor_4c_SigMvCab.TpFats, ;
                                    cursor_4c_SigMvCab.Obses, cursor_4c_SigMvCab.ValVars)

                        *-- Busca itens em SigMvNfi
                        loc_cSQL = "SELECT * FROM SigMvNfi " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                        loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
                        IF loc_nResult2 < 1
                            MsgErro("Favor Reinicializar o Processo!!!", ;
                                    "Falha na Conex" + CHR(227) + "o (SigMvNfi)")
                            loc_lAbortado = .T.
                        ENDIF
                    ENDIF

                    IF !loc_lAbortado
                        GO TOP IN cursor_4c_SigMvNfi

                        *-- Imprime usando rotina legada SigPrNfs.prg
                        DO SigPrNfs WITH "I", loc_cEmps, loc_cDopes, loc_nNumes

                        SELECT (THIS.this_cCursorNFis)
                        DELETE
                    ENDIF
                ENDIF
            ENDSCAN

            IF !loc_lAbortado
                IF USED("cursor_4c_SigMvCab")
                    USE IN cursor_4c_SigMvCab
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF
                THIS.SelecionarDados()
                WAIT CLEAR
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizacao - Visualiza a NF do registro corrente do cursor
    * Cursor cursor_4c_TmpNFis deve estar posicionado no registro desejado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizacao()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_cEdn, loc_lAbortado
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes
        loc_lSucesso = .F.

        IF THIS.this_lNotasAnt
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorNFis)
        IF EOF() OR BOF() OR !Flag
            RETURN .F.
        ENDIF

        TRY
            loc_cEmps  = EVALUATE(THIS.this_cCursorNFis + ".Emps")
            loc_cDopes = EVALUATE(THIS.this_cCursorNFis + ".Dopes")
            loc_nNumes = EVALUATE(THIS.this_cCursorNFis + ".Numes")

            IF USED("cursor_4c_TprMvCab")
                USE IN cursor_4c_TprMvCab
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))
            SET NULL OFF

            loc_cEdn = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)
            loc_lAbortado = .F.

            *-- Busca cabecalho em SigMvCab
            loc_cSQL = "SELECT Emps, Dopes, Numes, ContaOs, ContaDs, " + ;
                       "TpFats, Obses, ValVars FROM SigMvCab " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCab")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigMvCab)")
                loc_lAbortado = .T.
            ENDIF

            IF !loc_lAbortado
                GO TOP IN cursor_4c_SigMvCab

                INSERT INTO cursor_4c_TprMvCab ;
                    (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
                    VALUES (cursor_4c_SigMvCab.Emps, cursor_4c_SigMvCab.Dopes, ;
                            cursor_4c_SigMvCab.Numes, cursor_4c_SigMvCab.ContaOs, ;
                            cursor_4c_SigMvCab.ContaDs, cursor_4c_SigMvCab.TpFats, ;
                            cursor_4c_SigMvCab.Obses, cursor_4c_SigMvCab.ValVars)

                *-- Busca itens em SigMvNfi
                loc_cSQL = "SELECT * FROM SigMvNfi " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
                IF loc_nResult2 < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigMvNfi)")
                    loc_lAbortado = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortado
                GO TOP IN cursor_4c_SigMvNfi

                *-- Visualiza usando rotina legada SigPrNfs.prg
                DO SigPrNfs WITH "V", loc_cEmps, loc_cDopes, loc_nNumes

                IF USED("cursor_4c_SigMvCab")
                    USE IN cursor_4c_SigMvCab
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF

                SELECT (THIS.this_cCursorNFis)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os registros do cursor TmpNFis (Flag=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        IF USED(THIS.this_cCursorNFis)
            UPDATE (THIS.this_cCursorNFis) SET Flag = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os registros do cursor TmpNFis (Flag=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF USED(THIS.this_cCursorNFis)
            UPDATE (THIS.this_cCursorNFis) SET Flag = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursors abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(10), loc_nI

        loc_aCursors(1)  = THIS.this_cCursorNFis
        loc_aCursors(2)  = THIS.this_cCursorClientes
        loc_aCursors(3)  = THIS.this_cCursorSeries
        loc_aCursors(4)  = "cursor_4c_TmpFiscal"
        loc_aCursors(5)  = "cursor_4c_SigCdOpe"
        loc_aCursors(6)  = "cursor_4c_SigMvNfi"
        loc_aCursors(7)  = "cursor_4c_SigMvCab"
        loc_aCursors(8)  = "cursor_4c_SigCnFnfT"
        loc_aCursors(9)  = "cursor_4c_TprMvCab"
        loc_aCursors(10) = "cursor_4c_Selecao"

        FOR loc_nI = 1 TO 10
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

