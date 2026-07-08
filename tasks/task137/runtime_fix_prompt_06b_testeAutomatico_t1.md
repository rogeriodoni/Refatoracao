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
[18/06/2026 05:04:27 PM] Erro ao inicializar FormSigPdM12: Alias 'TMPNENS' is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-18 17:04:15] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-18 17:04:15] [INFO] Config FPW: (nao fornecido)
[2026-06-18 17:04:15] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-18 17:04:15] [INFO] Timeout: 300 segundos
[2026-06-18 17:04:15] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3zgxbiix.prg
[2026-06-18 17:04:15] [INFO] Conteudo do wrapper:
[2026-06-18 17:04:15] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPdM12', 'C:\4c\tasks\task137', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPdM12', 'C:\4c\tasks\task137', 'OPERACIONAL'
QUIT

[2026-06-18 17:04:15] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3zgxbiix.prg
[2026-06-18 17:04:15] [INFO] VFP output esperado em: C:\4c\tasks\task137\vfp_output.txt
[2026-06-18 17:04:15] [INFO] Executando Visual FoxPro 9...
[2026-06-18 17:04:15] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3zgxbiix.prg
[2026-06-18 17:04:15] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3zgxbiix.prg
[2026-06-18 17:04:15] [INFO] Timeout configurado: 300 segundos
[2026-06-18 17:04:27] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-18 17:04:27] [INFO] VFP9 finalizado em 12.4148725 segundos
[2026-06-18 17:04:27] [INFO] Exit Code: 
[2026-06-18 17:04:27] [INFO] 
[2026-06-18 17:04:27] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-18 17:04:27] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3zgxbiix.prg
[2026-06-18 17:04:27] [INFO] 
[2026-06-18 17:04:27] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-18 17:04:27] [INFO] * Auto-generated wrapper for parameters
[2026-06-18 17:04:27] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-18 17:04:27] [INFO] * Parameters: 'FormSigPdM12', 'C:\4c\tasks\task137', 'OPERACIONAL'
[2026-06-18 17:04:27] [INFO] 
[2026-06-18 17:04:27] [INFO] * Anti-dialog protections for unattended execution
[2026-06-18 17:04:27] [INFO] SET SAFETY OFF
[2026-06-18 17:04:27] [INFO] SET RESOURCE OFF
[2026-06-18 17:04:27] [INFO] SET TALK OFF
[2026-06-18 17:04:27] [INFO] SET NOTIFY OFF
[2026-06-18 17:04:27] [INFO] SYS(2335, 0)
[2026-06-18 17:04:27] [INFO] 
[2026-06-18 17:04:27] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPdM12', 'C:\4c\tasks\task137', 'OPERACIONAL'
[2026-06-18 17:04:27] [INFO] QUIT
[2026-06-18 17:04:27] [INFO] 
[2026-06-18 17:04:27] [INFO] === Fim do Wrapper.prg ===
[2026-06-18 17:04:27] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPdM12",
  "timestamp": "20260618170427",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM12.prg):
*==============================================================================
* FormSigPdM12.prg - Retrabalhos ja Realizados (popup read-only)
* Tipo: OPERACIONAL - aberto por FormSigPdM11 para exibir retrabalhos ja
* realizados para a operacao atual.
* Parametros Init: par_oFormPai (form pai com .pcEscolha e .DataSessionId)
* Compartilha DataSession com o form pai para acesso a: xNensiR, tmpnens
*==============================================================================
DEFINE CLASS FormSigPdM12 AS FormBase

    Width            = 800
    Height           = 520
    DataSession      = 2
    ShowWindow = 1
    BorderStyle      = 2
    TitleBar         = 0
    ControlBox       = .F.
    Closable         = .F.
    MaxButton        = .F.
    MinButton        = .F.
    WindowType       = 1
    AutoCenter       = .T.
    ClipControls     = .F.
    FontName         = "Tahoma"
    FontSize         = 8
    Themes           = .F.
    Picture          = ""

    *-- Estado e referencia ao form pai
    this_oFormPai  = .NULL.      && Referencia ao form pai (SigPdM11 ou similar)
    this_cEscolha  = ""          && pcEscolha recebido do form pai
    this_cAntValue = "          " && Valor anterior 10 chars (AntValue do legado)

    *-- Container cabecalho escuro (cntSombra do legado)
    ADD OBJECT cnt_4c_Sombra AS Container WITH ;
        Top = 0, Left = 0, Width = 800, Height = 80, ;
        BorderWidth = 0, BackStyle = 1, BackColor = RGB(100,100,100), ;
        Visible = .F.

    *-- Shape decorativo de fundo para area do botao OK (Shape1 do legado)
    ADD OBJECT shp_4c_Shape1 AS Shape WITH ;
        Top = 7, Left = 699, Width = 90, Height = 110, ;
        Visible = .F.

    *-- Container com campos da operacao (Opera...o do legado: tmpnens.*)
    ADD OBJECT cnt_4c_Operacao AS Container WITH ;
        Top = 95, Left = 216, Width = 367, Height = 44, ;
        BackStyle = 0, BorderWidth = 0, Visible = .F.

    *-- Grid de retrabalhos (Grade do legado: xNensiR) - configurado em ConfigurarGrid
    ADD OBJECT grd_4c_Dados AS Grid WITH ;
        Top = 140, Left = 60, Width = 679, Height = 326, ;
        ColumnCount = 5, ;
        FontName = "Verdana", FontSize = 8, ;
        GridLineColor = RGB(238,238,238), ;
        HighlightBackColor = RGB(255,255,255), ;
        HighlightForeColor = RGB(15,41,104), ;
        HighlightStyle = 2, ;
        RecordMark = .F., DeleteMark = .F., ;
        ScrollBars = 2, RowHeight = 17, ;
        Visible = .F.

    *-- Label "Funcionario :" abaixo do grid (Label3 do legado)
    ADD OBJECT lbl_4c_Label3 AS Label WITH ;
        AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
        BackStyle = 0, ;
        Caption = "Funcion" + CHR(225) + "rio : ", ;
        Height = 15, Left = 217, Top = 479, Width = 67, ;
        ForeColor = RGB(90,90,90), Visible = .F.

    *-- TextBox nome do funcionario (getRclis do legado - xNensir.rclis)
    ADD OBJECT txt_4c_Rclis AS TextBox WITH ;
        FontName = "Tahoma", FontSize = 8, ;
        Height = 23, Left = 286, Top = 476, Width = 297, ;
        ReadOnly = .T., ;
        DisabledBackColor = RGB(255,255,255), ;
        Value = "", Visible = .F.

    *-- Botao OK (ok do legado)
    ADD OBJECT cmd_4c_Ok AS CommandButton WITH ;
        Top = 3, Left = 725, Width = 75, Height = 75, ;
        Caption = "\<Ok", Cancel = .T., ;
        FontName = "Tahoma", FontBold = .T., FontItalic = .T., FontSize = 8, ;
        ForeColor = RGB(90,90,90), BackColor = RGB(255,255,255), ;
        Themes = .F., SpecialEffect = 0, PicturePosition = 13, ;
        MousePointer = 15, WordWrap = .T., ;
        Visible = .F.

    *==========================================================================
    * Init - Armazena referencia ao form pai e compartilha sua DataSession
    * Equivalente a: LPARAMETERS pForm / Set DataSession To pForm.DataSessionId
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            SET DataSession TO par_oFormPai.DataSessionId
            IF TYPE("par_oFormPai.pcEscolha") = "C"
                THIS.this_cEscolha = ALLTRIM(par_oFormPai.pcEscolha)
            ENDIF
        ENDIF
        THIS.this_cAntValue = SPACE(10)
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO e configura a interface do popup
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigPdM12BO")
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Erro ao criar SigPdM12BO.", "Erro")
            RETURN loc_lSucesso
        ENDIF

        TRY
            THIS.LockScreen = .T.

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarDados()
            ENDIF

            THIS.TornarControlesVisiveis(THIS)

            BINDEVENT(THIS.cmd_4c_Ok,   "Click",              THIS, "BtnOkClick")
            BINDEVENT(THIS.grd_4c_Dados,"AfterRowColChange",  THIS, "GrdDadosAfterRowColChange")

            THIS.LockScreen = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro ao inicializar FormSigPdM12")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Configura layout base do form operacional
    * Form OPERACIONAL (popup read-only): nao usa o padrao CRUD
    * (Page1=Lista / Page2=Dados). O layout e customizado: cabecalho escuro,
    * area de operacao, grid de retrabalhos e botao OK posicionados direto no
    * form. Este metodo define propriedades visuais "page-level":
    * Caption, Picture de fundo e captions dos labels do cabecalho que sao
    * derivados do Caption do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Caption = "Retrabalhos j" + CHR(225) + " Realizados"
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        *-- Form modal popup: WindowType ja e 1 (modal); AutoCenter centra na tela
        THIS.WindowType = 1
        THIS.AutoCenter = .T.

        *-- Padroniza fonte base aplicada por heranca aos controles
        THIS.FontName = "Tahoma"
        THIS.FontSize = 8
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Agrupa configuracao da area de lista do popup
    * Form OPERACIONAL popup: nao ha PageFrame Page1/Page2. A "lista" eh o
    * grid de retrabalhos (xNensiR) com cabecalho, area de operacao corrente
    * (tmpnens) e botao OK. Este metodo executa toda a configuracao visual
    * da unica "pagina" do popup, na ordem: cabecalho escuro, area de operacao,
    * botao OK e grid de retrabalhos. Substitui as chamadas individuais que
    * existiam no InicializarForm e mantem compatibilidade com a validacao
    * de fase 4 do orquestrador de migracao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarAreaOperacao()
        THIS.ConfigurarBotaoOk()
        THIS.ConfigurarGrid()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Encerra o popup e retorna o controle ao form pai
    * Form OPERACIONAL popup possui uma unica pagina logica (a propria
    * "lista" de retrabalhos). Como nao ha PageFrame com multiplas paginas,
    * AlternarPagina(1) eh interpretado como "voltar ao form pai" e executa
    * a mesma logica do botao OK: re-habilita o form pai e libera o popup.
    * Parametro: par_nPagina = 1 fecha o popup; outros valores sao ignorados.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) = "N" AND par_nPagina = 1
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Adiciona labels ao container de cabecalho escuro
    * Equivalente ao cntSombra.lblSombra + cntSombra.lblTitulo do legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top      = 18
            .Left     = 10
            .Width    = 769
            .Height   = 40
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .BackStyle = 0
            .WordWrap  = .T.
            .Caption   = THIS.Caption
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top      = 17
            .Left     = 10
            .Width    = 769
            .Height   = 46
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .BackStyle = 0
            .WordWrap  = .T.
            .Caption   = THIS.Caption
            .ForeColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAreaOperacao - Adiciona label e campos ao container de operacao
    * Equivalente ao container Opera...o do legado (campos tmpnens.*)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAreaOperacao()
        THIS.cnt_4c_Operacao.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.cnt_4c_Operacao.lbl_4c_Label4
            .Top       = 14
            .Left      = 10
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Empresa (tmpnens.emps)
        THIS.cnt_4c_Operacao.AddObject("txt_4c_Empresa", "TextBox")
        WITH THIS.cnt_4c_Operacao.txt_4c_Empresa
            .Top               = 10
            .Left              = 80
            .Width             = 36
            .Height            = 23
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .ControlSource     = "tmpnens.emps"
        ENDWITH

        *-- Descricao da operacao (tmpnens.dopps)
        THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
        WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
            .Top               = 10
            .Left              = 118
            .Width             = 156
            .Height            = 23
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .ControlSource     = "tmpnens.dopps"
        ENDWITH

        *-- Codigo numerico da operacao (tmpnens.numps)
        THIS.cnt_4c_Operacao.AddObject("txt_4c_Codigo", "TextBox")
        WITH THIS.cnt_4c_Operacao.txt_4c_Codigo
            .Top               = 10
            .Left              = 276
            .Width             = 81
            .Height            = 23
            .Value             = 0
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .Format            = "L"
            .InputMask         = "9999999999"
            .ControlSource     = "tmpnens.numps"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoOk - Associa icone ao botao OK
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoOk()
        THIS.cmd_4c_Ok.Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Configura colunas, headers e ControlSources do grid
    * Equivalente a Grade.RecordSource + Column*.ControlSource do legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid
        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .ColumnCount  = 5
            .RowHeight    = 17
            .HeaderHeight = 17

            *-- Coluna 1: O.S. (xnensir.Nenvs)
            .Column1.ControlSource  = "xNensiR.Nenvs"
            .Column1.Width          = 75
            .Column1.ReadOnly       = .T.
            .Column1.Format         = "L"
            .Column1.InputMask      = "9999999999"
            .Column1.Movable        = .F.
            .Column1.Resizable      = .F.
            .Column1.Header1.Caption    = "O.S."
            .Column1.Header1.FontName   = "Tahoma"
            .Column1.Header1.FontSize   = 8
            .Column1.Header1.FontBold   = .F.
            .Column1.Header1.Alignment  = 2

            *-- Coluna 2: Operacao (xnensir.EmpDopNums)
            .Column2.ControlSource  = "xNensiR.EmpDopNums"
            .Column2.Width          = 185
            .Column2.ReadOnly       = .T.
            .Column2.Movable        = .F.
            .Column2.Resizable      = .F.
            .Column2.Header1.Caption    = "Opera" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.FontName   = "Tahoma"
            .Column2.Header1.FontSize   = 8
            .Column2.Header1.FontBold   = .F.
            .Column2.Header1.Alignment  = 2

            *-- Coluna 3: Data (xnensir.Datas)
            .Column3.ControlSource  = "xNensiR.Datas"
            .Column3.Width          = 75
            .Column3.ReadOnly       = .T.
            .Column3.Movable        = .F.
            .Column3.Resizable      = .F.
            .Column3.Header1.Caption    = "Data"
            .Column3.Header1.FontName   = "Tahoma"
            .Column3.Header1.FontSize   = 8
            .Column3.Header1.FontBold   = .F.
            .Column3.Header1.Alignment  = 2

            *-- Coluna 4: Grupo/Conta (xnensir.Destinos)
            .Column4.ControlSource  = "xNensiR.Destinos"
            .Column4.Width          = 135
            .Column4.ReadOnly       = .T.
            .Column4.Movable        = .F.
            .Column4.Resizable      = .F.
            .Column4.Header1.Caption    = "Grupo/Conta"
            .Column4.Header1.FontName   = "Tahoma"
            .Column4.Header1.FontSize   = 8
            .Column4.Header1.FontBold   = .F.
            .Column4.Header1.Alignment  = 2

            *-- Coluna 5: Retrabalho (xnensir.Retrabs)
            .Column5.ControlSource  = "xNensiR.Retrabs"
            .Column5.Width          = 175
            .Column5.ReadOnly       = .T.
            .Column5.Movable        = .F.
            .Column5.Resizable      = .F.
            .Column5.Header1.Caption    = "Retrabalhos"
            .Column5.Header1.FontName   = "Tahoma"
            .Column5.Header1.FontSize   = 8
            .Column5.Header1.FontBold   = .F.
            .Column5.Header1.Alignment  = 2

            *-- Formata controles internos das colunas
            .SetAll("BorderStyle", 0, "Column")
            .FontName = "Tahoma"
            .FontSize = 8
            .SetAll("Margin", 0, "Text")
            .SetAll("ForeColor", RGB(0,0,0), "Text")
            .SetAll("BackColor", RGB(255,255,255), "Text")
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarDados - Posiciona no inicio do cursor xNensiR e conecta o grid
    * Equivalente ao Select xNensiR / Go Top / Grade.RecordSource = 'xNensiR'
    * do legado SIGPDM12.Init
    *==========================================================================
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_oErro

        TRY
            IF USED("xNensiR")
                SELECT xNensiR
                GO TOP
                THIS.grd_4c_Dados.RecordSource = "xNensiR"

                *-- ControlSources reconfigurados apos RecordSource (VFP reseta headers)
                THIS.grd_4c_Dados.Column1.Header1.Caption = "O.S."
                THIS.grd_4c_Dados.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                THIS.grd_4c_Dados.Column3.Header1.Caption = "Data"
                THIS.grd_4c_Dados.Column4.Header1.Caption = "Grupo/Conta"
                THIS.grd_4c_Dados.Column5.Header1.Caption = "Retrabalhos"

                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar dados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * BtnOkClick - Re-habilita form pai e fecha este popup
    * Equivalente ao ok.Click do legado: ThisForm.ParentForm.Enabled = .t. + Release
    *==========================================================================
    PROCEDURE BtnOkClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Encaminha inclusao de retrabalho ao form pai
    * SIGPDM12 e um popup READ-ONLY (somente exibe xNensiR). Inclusao de
    * retrabalhos e feita pelo form pai (FormSigPdM11) na tabela NensiR.
    * Esta acao fecha o popup, sinaliza o modo Incluir ao pai e devolve o
    * controle para que o usuario execute a inclusao no contexto correto.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oFormPai
        loc_oFormPai = THIS.this_oFormPai

        MsgInfo("A inclus" + CHR(227) + "o de retrabalhos " + CHR(233) + " feita na tela principal." + ;
                CHR(13) + "Retornando para inclus" + CHR(227) + "o...", ;
                "Inclus" + CHR(227) + "o")

        IF VARTYPE(loc_oFormPai) = "O"
            loc_oFormPai.Enabled = .T.
            IF PEMSTATUS(loc_oFormPai, "BtnIncluirClick", 5)
                loc_oFormPai.BtnIncluirClick()
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Encaminha alteracao do retrabalho selecionado ao form pai
    * Popup READ-ONLY: identifica o retrabalho selecionado no grid (xNensiR.Nenvs)
    * armazena no AntValue do form pai (campo de retorno usado pelo SIGPDM11),
    * fecha o popup e delega ao pai a abertura em modo Alterar.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oFormPai, loc_cNenv
        loc_oFormPai = THIS.this_oFormPai
        loc_cNenv    = ""

        IF !USED("xNensiR") OR EOF("xNensiR") OR RECCOUNT("xNensiR") = 0
            MsgAviso("Selecione um retrabalho para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT xNensiR
        loc_cNenv = NVL(xNensiR.Nenvs, "")
        IF EMPTY(loc_cNenv)
            MsgAviso("Registro selecionado n" + CHR(227) + "o possui O.S. v" + CHR(225) + "lida.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF VARTYPE(loc_oFormPai) = "O"
            loc_oFormPai.Enabled = .T.
            IF PEMSTATUS(loc_oFormPai, "AntValue", 5)
                loc_oFormPai.AntValue = loc_cNenv
            ENDIF
            IF PEMSTATUS(loc_oFormPai, "BtnAlterarClick", 5)
                loc_oFormPai.BtnAlterarClick()
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Atualiza exibicao do retrabalho selecionado
    * SIGPDM12 ja eh a tela de visualizacao de retrabalhos. Este metodo
    * reposiciona o cursor xNensiR no registro corrente do grid, atualiza
    * o nome do funcionario (xNensiR.rclis) e refaz o refresh do grid para
    * garantir que os dados exibidos refletem o estado atual.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_nRecno

        TRY
            IF !USED("xNensiR") OR RECCOUNT("xNensiR") = 0
                MsgAviso("Nenhum retrabalho dispon" + CHR(237) + "vel para visualiza" + CHR(231) + CHR(227) + "o.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            SELECT xNensiR
            loc_nRecno = RECNO("xNensiR")

            IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("xNensiR")
                GO loc_nRecno IN xNensiR
            ELSE
                GO TOP IN xNensiR
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_Rclis.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar retrabalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Encaminha exclusao do retrabalho selecionado ao form pai
    * Popup READ-ONLY: identifica o retrabalho no grid (xNensiR.Nenvs),
    * pede confirmacao, armazena referencia no form pai e delega a exclusao
    * em NensiR ao pai, que opera no contexto transacional correto.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oFormPai, loc_cNenv, loc_lConfirma
        loc_oFormPai = THIS.this_oFormPai

        IF !USED("xNensiR") OR EOF("xNensiR") OR RECCOUNT("xNensiR") = 0
            MsgAviso("Selecione um retrabalho para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT xNensiR
        loc_cNenv = NVL(xNensiR.Nenvs, "")
        IF EMPTY(loc_cNenv)
            MsgAviso("Registro selecionado n" + CHR(227) + "o possui O.S. v" + CHR(225) + "lida.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do retrabalho da O.S. " + ;
                                    ALLTRIM(TRANSFORM(loc_cNenv)) + " ?", ;
                                    "Confirma" + CHR(231) + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF VARTYPE(loc_oFormPai) = "O"
            loc_oFormPai.Enabled = .T.
            IF PEMSTATUS(loc_oFormPai, "AntValue", 5)
                loc_oFormPai.AntValue = loc_cNenv
            ENDIF
            IF PEMSTATUS(loc_oFormPai, "BtnExcluirClick", 5)
                loc_oFormPai.BtnExcluirClick()
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza nome do funcionario ao mover no grid
    * Equivalente ao Grade.AfterRowColChange do legado: ThisForm.GetRclis.Refresh
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.txt_4c_Rclis.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Refina controles da area de dados inferior
    * Form OPERACIONAL (popup sem Page2): configura label e textbox do
    * funcionario e o shape decorativo com propriedades exatas do original.
    * ControlSource de txt_4c_Rclis definido aqui pois a data session ja
    * foi alternada para a sessao do form pai em Init().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Label "Funcionario :" (Label3 do legado)
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Funcion" + CHR(225) + "rio : "
            .Height    = 15
            .Left      = 217
            .Top       = 479
            .Width     = 67
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox nome do funcionario (getRclis do legado)
        *-- ControlSource vinculado a xNensir na data session do form pai
        WITH THIS.txt_4c_Rclis
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Height            = 23
            .Left              = 286
            .Top               = 476
            .Width             = 297
            .ReadOnly          = .T.
            .DisabledBackColor = RGB(255, 255, 255)
            .ControlSource     = "xNensir.rclis"
        ENDWITH

        *-- Shape decorativo atras do botao OK (Shape1 do legado)
        WITH THIS.shp_4c_Shape1
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarLista - Atualiza o grid de retrabalhos (alias de CarregarDados)
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * FormParaBO - Carrega propriedades do BO a partir do registro corrente
    * Popup read-only: carrega xNensiR corrente e cabecalho de tmpnens
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CarregarDoCursor("xNensiR")
            THIS.this_oBusinessObject.CarregarCabecalhoDoCursor("tmpnens")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza controles a partir das propriedades do BO
    * Todos os campos tem ControlSource nos cursores; Refresh() e suficiente.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.grd_4c_Dados.Refresh()
        THIS.txt_4c_Rclis.Refresh()
        THIS.cnt_4c_Operacao.Refresh()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Gerencia estado de edicao dos controles
    * Todos os controles sao somente leitura (form de visualizacao de retrabalhos)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_cModo)
        THIS.cnt_4c_Operacao.txt_4c_Empresa.ReadOnly  = .T.
        THIS.cnt_4c_Operacao.txt_4c_Operacao.ReadOnly = .T.
        THIS.cnt_4c_Operacao.txt_4c_Codigo.ReadOnly   = .T.
        THIS.txt_4c_Rclis.ReadOnly                    = .T.
    ENDPROC

    *==========================================================================
    * LimparCampos - Reposiciona cursor ao topo e atualiza exibicao
    * Popup read-only: sem campos editaveis para limpar
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF USED("xNensiR")
            GO TOP IN xNensiR
            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_Rclis.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo
    * Popup com unico botao OK: sempre habilitado
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        THIS.cmd_4c_Ok.Enabled = .T.
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Reposiciona grid ao topo e recarrega exibicao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Re-habilita form pai e fecha este popup
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Operacao nao suportada (popup read-only)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        MsgAviso("Formul" + CHR(225) + "rio de consulta de retrabalhos " + CHR(233) + " somente leitura." + ;
                 CHR(13) + "Utilize o formul" + CHR(225) + "rio principal para alterar registros.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada")
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Fecha popup sem acao adicional
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar o form
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        THIS.this_oFormPai        = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdM12BO.prg):
*====================================================================
* SigPdM12BO.prg
*
* Business Object para SigPdM12 - Retrabalhos ja Realizados
* Form popup read-only: exibe dados dos cursores xNensiR e tmpnens
* fornecidos pelo form pai via DataSession compartilhada.
* Nao possui tabela propria - operacoes de escrita sao rejeitadas.
*====================================================================

DEFINE CLASS SigPdM12BO AS BusinessBase

	*-- Campos do cursor xNensiR (grid de retrabalhos)
	this_nNenvs      = 0    && O.S. (numero envelope)
	this_cEmpDopNums = ""   && Operacao (descricao)
	this_dDatas      = {}   && Data do retrabalho
	this_cDestinos   = ""   && Grupo/Conta destino
	this_cRetrabs    = ""   && Descricao do retrabalho
	this_cRclis      = ""   && Funcionario (nome)

	*-- Campos do cursor tmpnens (cabecalho da operacao)
	this_nNumps      = 0    && Codigo da operacao (numps)
	this_cEmps       = ""   && Empresa (emps)
	this_cDopps      = ""   && Descricao da operacao (dopps)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = ""   && Sem tabela propria (usa cursores do form pai)
		THIS.this_cCampoChave = ""   && Sem chave primaria

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir do cursor xNensiR
	* par_cAliasCursor: alias do cursor (normalmente "xNensiR")
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nNenvs      = TratarNulo(Nenvs,      "N")
			THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
			THIS.this_dDatas      = TratarNulo(Datas,      "D")
			THIS.this_cDestinos   = TratarNulo(Destinos,   "C")
			THIS.this_cRetrabs    = TratarNulo(Retrabs,    "C")
			THIS.this_cRclis      = TratarNulo(Rclis,      "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* CarregarCabecalhoDoCursor - Carrega cabecalho a partir do cursor tmpnens
	* par_cAliasCursor: alias do cursor (normalmente "tmpnens")
	*====================================================================
	PROCEDURE CarregarCabecalhoDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nNumps  = TratarNulo(numps, "N")
			THIS.this_cEmps   = TratarNulo(emps,  "C")
			THIS.this_cDopps  = TratarNulo(dopps, "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave do registro corrente (Nenvs)
	* Usado para auditoria; identifica unicamente o envelope/O.S.
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nNenvs)
	ENDFUNC

	*====================================================================
	* Inserir - Operacao nao suportada (form read-only)
	* Form SigPdM12 e um popup de consulta de retrabalhos ja realizados.
	* Os cursores xNensiR e tmpnens sao fornecidos pelo form pai via
	* DataSession compartilhada e nao podem ser modificados aqui.
	* Comportamento original (SCX): apenas exibicao em grid, botao OK fecha.
	*====================================================================
	PROCEDURE Inserir()
		THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
		                         "o suportada: formul" + CHR(225) + "rio de consulta " + ;
		                         "de retrabalhos " + CHR(233) + " somente leitura."
		RETURN .F.
	ENDPROC

	*====================================================================
	* Atualizar - Operacao nao suportada (form read-only)
	* Form SigPdM12 nao permite alteracao dos retrabalhos exibidos.
	* Manutencao dos registros deve ser feita atraves do form pai
	* (SigPdM01/SigPdM10) que possui a logica de cadastro.
	*====================================================================
	PROCEDURE Atualizar()
		THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
		                         "o suportada: utilize o formul" + CHR(225) + "rio de " + ;
		                         "cadastro de retrabalhos para alterar registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Operacao nao suportada (form read-only)
	* Exclusao de retrabalhos deve ser feita pelo form pai responsavel
	* pelo cadastro original. Este form apenas exibe os dados.
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
		                         "o suportada: utilize o formul" + CHR(225) + "rio de " + ;
		                         "cadastro de retrabalhos para excluir registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* ValidarDados - Sempre invalido (sem operacoes de escrita)
	* Como nao ha Inserir/Atualizar suportados, nao ha dados a validar.
	*====================================================================
	PROTECTED FUNCTION ValidarDados()
		THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de consulta n" + CHR(227) + ;
		                         "o suporta valida" + CHR(231) + CHR(227) + "o de escrita."
		RETURN .F.
	ENDFUNC

ENDDEFINE

