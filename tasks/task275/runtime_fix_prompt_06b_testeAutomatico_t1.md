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
[15/07/2026 08:57:52 PM] Erro InicializarForm Formsigprdis: Command is missing required clause. LN=75 PROC=inicializarform


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-15 20:57:32] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 20:57:32] [INFO] Config FPW: (nao fornecido)
[2026-07-15 20:57:32] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 20:57:32] [INFO] Timeout: 300 segundos
[2026-07-15 20:57:32] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1qsfkkly.prg
[2026-07-15 20:57:32] [INFO] Conteudo do wrapper:
[2026-07-15 20:57:32] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprdis', 'C:\4c\tasks\task275', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprdis', 'C:\4c\tasks\task275', 'CRUD'
QUIT

[2026-07-15 20:57:32] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1qsfkkly.prg
[2026-07-15 20:57:32] [INFO] VFP output esperado em: C:\4c\tasks\task275\vfp_output.txt
[2026-07-15 20:57:32] [INFO] Executando Visual FoxPro 9...
[2026-07-15 20:57:32] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1qsfkkly.prg
[2026-07-15 20:57:32] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1qsfkkly.prg
[2026-07-15 20:57:32] [INFO] Timeout configurado: 300 segundos
[2026-07-15 20:57:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 20:57:52] [INFO] VFP9 finalizado em 20.151456 segundos
[2026-07-15 20:57:52] [INFO] Exit Code: 
[2026-07-15 20:57:52] [INFO] 
[2026-07-15 20:57:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 20:57:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1qsfkkly.prg
[2026-07-15 20:57:52] [INFO] 
[2026-07-15 20:57:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 20:57:52] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 20:57:52] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 20:57:52] [INFO] * Parameters: 'Formsigprdis', 'C:\4c\tasks\task275', 'CRUD'
[2026-07-15 20:57:52] [INFO] 
[2026-07-15 20:57:52] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 20:57:52] [INFO] SET SAFETY OFF
[2026-07-15 20:57:52] [INFO] SET RESOURCE OFF
[2026-07-15 20:57:52] [INFO] SET TALK OFF
[2026-07-15 20:57:52] [INFO] SET NOTIFY OFF
[2026-07-15 20:57:52] [INFO] SYS(2335, 0)
[2026-07-15 20:57:52] [INFO] 
[2026-07-15 20:57:52] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprdis', 'C:\4c\tasks\task275', 'CRUD'
[2026-07-15 20:57:52] [INFO] QUIT
[2026-07-15 20:57:52] [INFO] 
[2026-07-15 20:57:52] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 20:57:52] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigprdis",
  "timestamp": "20260715205752",
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdis.prg):
*==============================================================================
* Formsigprdis.prg - Formulario OPERACIONAL: Distribui" + CHR(231) + CHR(227) + "o de Produtos
* Equivalente ao SIGPRDIS.SCX do legado
* Tipo: OPERACIONAL - lista de lotes (Page1) + processamento (Page2 inner 3-pages)
* Herda de FormBase
*==============================================================================
DEFINE CLASS Formsigprdis AS FormBase

    Width       = 1000
    Height      = 600
    Caption     = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
    ShowWindow  = 1
    WindowType  = 1
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    AutoCenter  = .T.
    BorderStyle = 2
    Themes      = .F.
    DataSession = 2

    this_oBusinessObject           = .NULL.
    this_cEscolha                  = ""
    this_cCodigos                  = ""
    this_cUltimoCGrupoValidado     = ""
    this_cUltimoDGrupoValidado     = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_aCursores[8], loc_i
        loc_aCursores[1] = "cursor_4c_Dados"
        loc_aCursores[2] = "cursor_4c_Estoques"
        loc_aCursores[3] = "cursor_4c_Disponivel"
        loc_aCursores[4] = "cursor_4c_Distribui"
        loc_aCursores[5] = "cursor_4c_CabOpera"
        loc_aCursores[6] = "cursor_4c_ItensOper"
        loc_aCursores[7] = "cursor_4c_LotePrDis"
        loc_aCursores[8] = "cursor_4c_Produto"
        FOR loc_i = 1 TO 8
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT loc_i
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("sigprdisBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar sigprdisBO.", "Erro InicializarForm")
            ELSE
                *-- Placeholders para ControlSource em DataSession=2
                *-- Fechados/substituidos pelos metodos do BO antes de cada SQLEXEC
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (Codigos C(20), Datas T)
                SELECT 0 AS nMarca, SPACE(36) AS cidchaves, SPACE(4) AS emps, ;
                    SPACE(10) AS grupos, SPACE(15) AS contas ;
                    INTO CURSOR cursor_4c_Estoques READWRITE NOFILTER
                SELECT SPACE(14) AS cpros, SPACE(65) AS dpros, SPACE(4) AS codcors, ;
                    SPACE(4) AS codtams, 0.00 AS QtdEstoque, 0.00 AS QtdSaida, 0.00 AS QtdSaldo ;
                    INTO CURSOR cursor_4c_Disponivel READWRITE NOFILTER
                CREATE CURSOR cursor_4c_Distribui (emps C(4), grupos C(10), contas C(15), QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
                SELECT SPACE(4) AS emps, SPACE(20) AS dopes, SPACE(10) AS numes, ;
                    DATETIME() AS datas, SPACE(10) AS grupos, SPACE(40) AS empdopnums, ;
                    SPACE(3) AS empds, SPACE(10) AS contaos, SPACE(10) AS grupods, ;
                    SPACE(10) AS contads ;
                    INTO CURSOR cursor_4c_CabOpera READWRITE NOFILTER
                SELECT SPACE(14) AS cpros, SPACE(65) AS dpros, SPACE(4) AS codcors, ;
                    SPACE(4) AS codtams, 0.00 AS qtds, SPACE(10) AS locals ;
                    INTO CURSOR cursor_4c_ItensOper READWRITE NOFILTER
                SET NULL OFF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarSaida()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Page1 BINDEVENTs
                LOCAL loc_oPg1 AS Object
                loc_oPg1 = THIS.pgf_4c_Paginas.Page1
                BINDEVENT(loc_oPg1.txt_4c_DtInicial, "LostFocus",     THIS, "TxtDtInicialValid")
                BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "LostFocus",     THIS, "TxtDtFinalValid")
                BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "KeyPress", THIS, "TxtDtFinalLostFocus")
                BINDEVENT(loc_oPg1.cmd_4c_Novo,       "Click",    THIS, "BtnNovoClick")
                BINDEVENT(loc_oPg1.cmd_4c_Abrir,      "Click",    THIS, "BtnAbrirClick")
                BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

                *-- Page2 BINDEVENTs
                LOCAL loc_oPg2 AS Object
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2
                BINDEVENT(loc_oPg2.cmd_4c_VoltarLista, "Click", THIS, "BtnVoltarListaClick")

                *-- Inner pageframe sub-page BINDEVENTs
                LOCAL loc_oPf1 AS Object
                loc_oPf1 = loc_oPg2.pgf_4c_Pageframe1

                *-- SubPage1 (Estoques)
                LOCAL loc_oSub1 AS Object
                loc_oSub1 = loc_oPf1.Page1
                BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(1), "Click", THIS, "BtnMarcarClick")
                BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(2), "Click", THIS, "BtnDesmarcarClick")
                BINDEVENT(loc_oSub1.cmd_4c_Processar,                  "Click", THIS, "BtnProcessarPage1Click")
                BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "MouseUp",  THIS, "ChkMarcaMouseUp")
                BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")

                *-- SubPage2 (Distribuicao)
                LOCAL loc_oSub2 AS Object
                loc_oSub2 = loc_oPf1.Page2
                BINDEVENT(loc_oSub2.cmd_4c_VoltarEst,      "Click",              THIS, "BtnVoltarEstClick")
                BINDEVENT(loc_oSub2.cmd_4c_Salvar,         "Click",              THIS, "BtnSalvarClick")
                BINDEVENT(loc_oSub2.cmd_4c_Filtrar,        "Click",              THIS, "BtnFiltrarClick")
                BINDEVENT(loc_oSub2.img_4c_FigJpg,         "Click",              THIS, "ImgFotoClick")
                BINDEVENT(loc_oSub2.txt_4c_CodGrupo,       "KeyPress",             THIS, "TxtCGrupoValid")
                BINDEVENT(loc_oSub2.txt_4c_DsGrupo,        "KeyPress",             THIS, "TxtDGrupoValid")
                BINDEVENT(loc_oSub2.txt_4c_CodSgrupo,      "KeyPress",             THIS, "TxtCodSgrupoValid")
                BINDEVENT(loc_oSub2.txt_4c_DsSgrupo,       "KeyPress",             THIS, "TxtDsSgrupoValid")
                BINDEVENT(loc_oSub2.txt_4c_ProdutoInicial, "LostFocus",              THIS, "TxtProdutoInicialValid")
                BINDEVENT(loc_oSub2.grd_4c_Disponivel,     "AfterRowColChange",  THIS, "GrdDisponivelAfterRowColChange")
                BINDEVENT(loc_oSub2.grd_4c_Distribui.Column3.Text1, "KeyPress", THIS, "GrdDistribuiQtdLostFocus")
                BINDEVENT(loc_oSub2.grd_4c_Distribui.Column4.Text1, "Valid",     THIS, "GrdDistribuiLocalValid")
                BINDEVENT(loc_oSub2.grd_4c_Distribui.Column4.Text1, "KeyPress",  THIS, "TxtLocalKeyPress")

                *-- SubPage3 (Operacoes)
                LOCAL loc_oSub3 AS Object
                loc_oSub3 = loc_oPf1.Page3
                BINDEVENT(loc_oSub3.cmdg_4c_ProcOper.Buttons(1), "Click",             THIS, "BtnProcOperClick")
                BINDEVENT(loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas, "AfterRowColChange", THIS, "GrdCabOperasAfterRowColChange")

                THIS.TornarControlesVisiveis(THIS)

                *-- Disable pages 2 and 3 until estoques processed
                loc_oPf1.Page2.Enabled = .F.
                loc_oPf1.Page3.Enabled = .F.

                *-- Initial date range = today
                THIS.this_oBusinessObject.this_dDataInicial = DATE()
                THIS.this_oBusinessObject.this_dDataFinal   = DATE()
                loc_oPg1.txt_4c_DtInicial.Value = DATE()
                loc_oPg1.txt_4c_DtFinal.Value   = DATE()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                    loc_oPg1.grd_4c_Grade.SetFocus()
                ELSE
                    loc_oPg1.cmd_4c_Novo.SetFocus()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprdis")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), ;
                    "LBL_4C_LBLTITF", "LBL_4C_LBLTITT", "LBL_4C_LABEL3")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 45
            .BorderWidth= 0
            .BackStyle  = 1
            .BackColor  = RGB(90,90,90)
            .Visible     = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
            .Top       = 12
            .Left      = 12
            .Width     = THIS.Width
            .Height    = 30
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(0,0,0)
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
            .Top       = 10
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 30
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(255,255,255)
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.Picture    = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Left      = 0
            .Top       = 45
            .Width     = THIS.Width
            .Height    = THIS.Height - 45
            .PageCount = 2
            .Tabs      = .F.
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSaida()
    *==========================================================================
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Name        = "cnt_4c_Saida"
            .Left        = 917
            .Top         = 45
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
            .ZOrder(0)
        ENDWITH
        THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
            .Name     = "cmd_4c_Encerrar"
            .Left     = 5
            .Top      = 5
            .Width    = 75
            .Height   = 75
            .Caption  = "Encerrar"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oPg1 AS Object
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_oPg1.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPg1.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 35
            .Top       = 89
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg1.txt_4c_DtInicial
            .Left     = 103
            .Top      = 105
            .Width    = 90
            .Height   = 22
            .Value    = DATE()
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oPg1.lbl_4c_Sep
            .Caption   = CHR(224)
            .Left      = 195
            .Top       = 109
            .Width     = 12
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg1.txt_4c_DtFinal
            .Left     = 206
            .Top      = 105
            .Width    = 90
            .Height   = 22
            .Value    = DATE()
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg1.AddObject("cmd_4c_Novo", "CommandButton")
        WITH loc_oPg1.cmd_4c_Novo
            .Caption  = "Nova Distribui" + CHR(231) + CHR(227) + "o"
            .Left     = 315
            .Top      = 102
            .Width    = 140
            .Height   = 28
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg1.AddObject("cmd_4c_Abrir", "CommandButton")
        WITH loc_oPg1.cmd_4c_Abrir
            .Caption  = "Abrir Selecionado"
            .Left     = 465
            .Top      = 102
            .Width    = 130
            .Height   = 28
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_TituloLista", "Label")
        WITH loc_oPg1.lbl_4c_TituloLista
            .Caption   = "Lotes de Distribui" + CHR(231) + CHR(227) + "o"
            .Left      = 35
            .Top       = 140
            .Width     = 200
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
        ENDWITH

        loc_oPg1.AddObject("grd_4c_Grade", "Grid")
        WITH loc_oPg1.grd_4c_Grade
            .Left              = 24
            .Top               = 157
            .Width             = 870
            .Height            = 340
            .RecordSource      = ""
            .RecordSourceType  = 1
            .ColumnCount       = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .GridLines         = 1
            .ReadOnly          = .T.
            .Themes            = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
        ENDWITH
        WITH loc_oPg1.grd_4c_Grade.Column1
            .ControlSource   = "cursor_4c_Dados.Codigos"
            .Width           = 140
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oPg1.grd_4c_Grade.Column2
            .ControlSource   = "cursor_4c_Dados.Datas"
            .Width           = 700
            .Header1.Caption = "Data"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
        LOCAL loc_oPg2 AS Object
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.AddObject("cmd_4c_VoltarLista", "CommandButton")
        WITH loc_oPg2.cmd_4c_VoltarLista
            .Caption  = CHR(171) + " Lista"
            .Left     = 5
            .Top      = 5
            .Width    = 80
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Lote", "Label")
        WITH loc_oPg2.lbl_4c_Lote
            .Caption   = "Lote:"
            .Left      = 96
            .Top       = 10
            .Width     = 35
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPg2.AddObject("txt_4c_LoteCodigo", "TextBox")
        WITH loc_oPg2.txt_4c_LoteCodigo
            .Left      = 132
            .Top       = 7
            .Width     = 180
            .Height    = 22
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Modo", "Label")
        WITH loc_oPg2.lbl_4c_Modo
            .Caption   = ""
            .Left      = 320
            .Top       = 10
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0,0,180)
        ENDWITH

        *-- Inner pageframe (3 sub-pages: Estoques, Distribuicao, Operacoes)
        loc_oPg2.AddObject("pgf_4c_Pageframe1", "PageFrame")
        WITH loc_oPg2.pgf_4c_Pageframe1
            .Left      = 0
            .Top       = 35
            .Width     = 910
            .Height    = 515
            .PageCount = 3
            .Tabs      = .T.
            .Page1.Caption = "1 - Estoques"
            .Page2.Caption = "2 - Distribui" + CHR(231) + CHR(227) + "o"
            .Page3.Caption = "3 - Opera" + CHR(231) + CHR(245) + "es"
        ENDWITH

        THIS.ConfigurarSubPaginaEstoques()
        THIS.ConfigurarSubPaginaDistribuicao()
        THIS.ConfigurarSubPaginaOperacoes()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaEstoques()
    *==========================================================================
        LOCAL loc_oSub AS Object
        loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1

        loc_oSub.AddObject("lbl_4c_TituloEst", "Label")
        WITH loc_oSub.lbl_4c_TituloEst
            .Caption   = "Estoques para distribuir"
            .Left      = 338
            .Top       = 189
            .Width     = 200
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
        ENDWITH

        loc_oSub.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oSub.cmd_4c_Processar
            .Caption  = "Processar >>"
            .Left     = 730
            .Top      = 10
            .Width    = 120
            .Height   = 28
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oSub.AddObject("cmdg_4c_MarcaDesmarca", "CommandGroup")
        WITH loc_oSub.cmdg_4c_MarcaDesmarca
            .Left        = 617
            .Top         = 351
            .Width       = 160
            .Height      = 50
            .ButtonCount = 2
        ENDWITH
        WITH loc_oSub.cmdg_4c_MarcaDesmarca.Buttons(1)
            .Caption = "Marcar Todos"
            .Left    = 5
            .Top     = 5
            .Width   = 72
            .Height  = 40
        ENDWITH
        WITH loc_oSub.cmdg_4c_MarcaDesmarca.Buttons(2)
            .Caption = "Desmarcar"
            .Left    = 82
            .Top     = 5
            .Width   = 72
            .Height  = 40
        ENDWITH

        loc_oSub.AddObject("grd_4c_Estoques", "Grid")
        WITH loc_oSub.grd_4c_Estoques
            .Left             = 335
            .Top              = 207
            .Width            = 280
            .Height           = 244
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 4
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.grd_4c_Estoques.Column1
            .ControlSource   = "cursor_4c_Estoques.nMarca"
            .Width           = 30
            .Sparse          = .F.
            .Header1.Caption = ""
        ENDWITH
        loc_oSub.grd_4c_Estoques.Column1.AddObject("chk_4c_Marca", "CheckBox")
        WITH loc_oSub.grd_4c_Estoques.Column1.chk_4c_Marca
            .Caption = ""
            .Width   = 24
            .Height  = 17
        ENDWITH
        loc_oSub.grd_4c_Estoques.Column1.CurrentControl = "chk_4c_Marca"
        WITH loc_oSub.grd_4c_Estoques.Column2
            .ControlSource   = "cursor_4c_Estoques.emps"
            .Width           = 55
            .ReadOnly        = .T.
            .Header1.Caption = "Empresa"
        ENDWITH
        WITH loc_oSub.grd_4c_Estoques.Column3
            .ControlSource   = "cursor_4c_Estoques.grupos"
            .Width           = 90
            .ReadOnly        = .T.
            .Header1.Caption = "Grupo"
        ENDWITH
        WITH loc_oSub.grd_4c_Estoques.Column4
            .ControlSource   = "cursor_4c_Estoques.contas"
            .Width           = 90
            .ReadOnly        = .T.
            .Header1.Caption = "Conta"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaDistribuicao()
    *==========================================================================
        LOCAL loc_oSub AS Object
        loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2

        loc_oSub.AddObject("cmd_4c_VoltarEst", "CommandButton")
        WITH loc_oSub.cmd_4c_VoltarEst
            .Caption  = CHR(171) + " Estoques"
            .Left     = 5
            .Top      = 5
            .Width    = 90
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oSub.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oSub.cmd_4c_Salvar
            .Caption  = "Salvar"
            .Left     = 730
            .Top      = 5
            .Width    = 80
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Product image area
        loc_oSub.AddObject("shp_4c_Shape5", "Shape")
        WITH loc_oSub.shp_4c_Shape5
            .Left      = 4
            .Top       = 35
            .Width     = 163
            .Height    = 93
            .BackStyle = 1
            .BackColor = RGB(200,200,200)
        ENDWITH

        loc_oSub.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oSub.img_4c_FigJpg
            .Left    = 7
            .Top     = 36
            .Width   = 159
            .Height  = 89
            .Stretch = 1
        ENDWITH

        *-- Group filter
        loc_oSub.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oSub.lbl_4c_LblGrupo
            .Caption   = "Grupo :"
            .Left      = 174
            .Top       = 59
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oSub.AddObject("txt_4c_CodGrupo", "TextBox")
        WITH loc_oSub.txt_4c_CodGrupo
            .Left     = 175
            .Top      = 74
            .Width    = 35
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oSub.AddObject("txt_4c_DsGrupo", "TextBox")
        WITH loc_oSub.txt_4c_DsGrupo
            .Left     = 211
            .Top      = 74
            .Width    = 208
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oSub.AddObject("cmd_4c_Filtrar", "CommandButton")
        WITH loc_oSub.cmd_4c_Filtrar
            .Caption  = "Filtrar"
            .Left     = 424
            .Top      = 73
            .Width    = 60
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Product search
        loc_oSub.AddObject("lbl_4c_LblProduto", "Label")
        WITH loc_oSub.lbl_4c_LblProduto
            .Caption   = "Procurar"
            .Left      = 4
            .Top       = 100
            .Width     = 50
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oSub.AddObject("txt_4c_ProdutoInicial", "TextBox")
        WITH loc_oSub.txt_4c_ProdutoInicial
            .Left     = 2
            .Top      = 116
            .Width    = 108
            .Height   = 22
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Disponivel grid
        loc_oSub.AddObject("grd_4c_Disponivel", "Grid")
        WITH loc_oSub.grd_4c_Disponivel
            .Left             = 1
            .Top              = 141
            .Width            = 663
            .Height           = 327
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 7
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .ReadOnly         = .T.
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column1
            .ControlSource   = "cursor_4c_Disponivel.cpros"
            .Width           = 90
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column2
            .ControlSource   = "cursor_4c_Disponivel.dpros"
            .Width           = 140
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column3
            .ControlSource   = "cursor_4c_Disponivel.codcors"
            .Width           = 55
            .Header1.Caption = "Cor"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column4
            .ControlSource   = "cursor_4c_Disponivel.codtams"
            .Width           = 55
            .Header1.Caption = "Tam"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column5
            .ControlSource   = "cursor_4c_Disponivel.QtdEstoque"
            .Width           = 80
            .Header1.Caption = "Estoque"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column6
            .ControlSource   = "cursor_4c_Disponivel.QtdSaida"
            .Width           = 80
            .Header1.Caption = "Distribuido"
        ENDWITH
        WITH loc_oSub.grd_4c_Disponivel.Column7
            .ControlSource   = "cursor_4c_Disponivel.QtdSaldo"
            .Width           = 80
            .Header1.Caption = "Saldo"
        ENDWITH

        *-- Distribui grid (Column3=QtdDistr editable, Column4=locals editable)
        loc_oSub.AddObject("grd_4c_Distribui", "Grid")
        WITH loc_oSub.grd_4c_Distribui
            .Left             = 664
            .Top              = 141
            .Width            = 234
            .Height           = 327
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 4
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.grd_4c_Distribui.Column1
            .ControlSource   = "cursor_4c_Distribui.emps"
            .Width           = 50
            .ReadOnly        = .T.
            .Header1.Caption = "Empresa"
        ENDWITH
        WITH loc_oSub.grd_4c_Distribui.Column2
            .ControlSource   = "cursor_4c_Distribui.QtdSaldo"
            .Width           = 55
            .ReadOnly        = .T.
            .Header1.Caption = "Saldo"
        ENDWITH
        WITH loc_oSub.grd_4c_Distribui.Column3
            .ControlSource   = "cursor_4c_Distribui.QtdDistr"
            .Width           = 65
            .Header1.Caption = "Quantidade"
        ENDWITH
        WITH loc_oSub.grd_4c_Distribui.Column4
            .ControlSource   = "cursor_4c_Distribui.locals"
            .Width           = 55
            .Header1.Caption = "Local"
        ENDWITH

        *-- Product info panel (read-only) - bottom of page
        loc_oSub.AddObject("lbl_4c_LblGrupoP", "Label")
        WITH loc_oSub.lbl_4c_LblGrupoP
            .Caption   = "Grupo :"
            .Left      = 67
            .Top       = 474
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH loc_oSub.txt_4c_CdGrupo
            .Left      = 116
            .Top       = 470
            .Width     = 65
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsGrupoP", "TextBox")
        WITH loc_oSub.txt_4c_DsGrupoP
            .Left      = 182
            .Top       = 470
            .Width     = 270
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 470 right side: Linha
        loc_oSub.AddObject("lbl_4c_LblLinha", "Label")
        WITH loc_oSub.lbl_4c_LblLinha
            .Caption   = "Linha :"
            .Left      = 549
            .Top       = 473
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CdLinha", "TextBox")
        WITH loc_oSub.txt_4c_CdLinha
            .Left      = 593
            .Top       = 470
            .Width     = 80
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsLinha", "TextBox")
        WITH loc_oSub.txt_4c_DsLinha
            .Left      = 674
            .Top       = 470
            .Width     = 220
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 492 left side: Subgrupo (produto)
        loc_oSub.AddObject("lbl_4c_LblSgrupoP", "Label")
        WITH loc_oSub.lbl_4c_LblSgrupoP
            .Caption   = "Subgrupo :"
            .Left      = 50
            .Top       = 497
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CdSgrupoP", "TextBox")
        WITH loc_oSub.txt_4c_CdSgrupoP
            .Left      = 116
            .Top       = 492
            .Width     = 65
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsSgrupoP", "TextBox")
        WITH loc_oSub.txt_4c_DsSgrupoP
            .Left      = 182
            .Top       = 492
            .Width     = 270
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 492 right side: Fornecedor
        loc_oSub.AddObject("lbl_4c_LblForn", "Label")
        WITH loc_oSub.lbl_4c_LblForn
            .Caption   = "Fornecedor :"
            .Left      = 519
            .Top       = 496
            .Width     = 72
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CdFornecedor", "TextBox")
        WITH loc_oSub.txt_4c_CdFornecedor
            .Left      = 593
            .Top       = 492
            .Width     = 80
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsFornecedor", "TextBox")
        WITH loc_oSub.txt_4c_DsFornecedor
            .Left      = 674
            .Top       = 492
            .Width     = 220
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 514: Modelo (left) + Ref Fornecedor (right)
        loc_oSub.AddObject("lbl_4c_LblModelo", "Label")
        WITH loc_oSub.lbl_4c_LblModelo
            .Caption   = "Modelo :"
            .Left      = 62
            .Top       = 517
            .Width     = 50
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CodFinP", "TextBox")
        WITH loc_oSub.txt_4c_CodFinP
            .Left      = 116
            .Top       = 514
            .Width     = 65
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DesFinP", "TextBox")
        WITH loc_oSub.txt_4c_DesFinP
            .Left      = 182
            .Top       = 514
            .Width     = 270
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("lbl_4c_LblRefForn", "Label")
        WITH loc_oSub.lbl_4c_LblRefForn
            .Caption   = "Ref. Fornecedor :"
            .Left      = 495
            .Top       = 517
            .Width     = 92
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_RefFornecedor", "TextBox")
        WITH loc_oSub.txt_4c_RefFornecedor
            .Left      = 593
            .Top       = 514
            .Width     = 190
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Row 537: Grupo de Venda (left) + PrecoVenda/Peso (right)
        loc_oSub.AddObject("lbl_4c_LblGrpVenda", "Label")
        WITH loc_oSub.lbl_4c_LblGrpVenda
            .Caption   = "Grupo de Venda :"
            .Left      = 19
            .Top       = 540
            .Width     = 92
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_GrpVenda", "TextBox")
        WITH loc_oSub.txt_4c_GrpVenda
            .Left      = 116
            .Top       = 537
            .Width     = 80
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_GrDvenda", "TextBox")
        WITH loc_oSub.txt_4c_GrDvenda
            .Left      = 197
            .Top       = 537
            .Width     = 255
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("lbl_4c_LblPrVenda", "Label")
        WITH loc_oSub.lbl_4c_LblPrVenda
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .Left      = 538
            .Top       = 540
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_PrVenda", "TextBox")
        WITH loc_oSub.txt_4c_PrVenda
            .Left      = 593
            .Top       = 536
            .Width     = 108
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_MoedaPrVenda", "TextBox")
        WITH loc_oSub.txt_4c_MoedaPrVenda
            .Left      = 703
            .Top       = 536
            .Width     = 31
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("lbl_4c_LblPeso", "Label")
        WITH loc_oSub.lbl_4c_LblPeso
            .Caption   = "Peso :"
            .Left      = 740
            .Top       = 540
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_PesoMedio", "TextBox")
        WITH loc_oSub.txt_4c_PesoMedio
            .Left      = 781
            .Top       = 537
            .Width     = 75
            .Height    = 21
            .ReadOnly  = .T.
            .BackColor = RGB(230,230,230)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Filter row 2: Subgrupo filter
        loc_oSub.AddObject("lbl_4c_LblSgrupoF", "Label")
        WITH loc_oSub.lbl_4c_LblSgrupoF
            .Caption   = "Subgrupo :"
            .Left      = 174
            .Top       = 100
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_CodSgrupo", "TextBox")
        WITH loc_oSub.txt_4c_CodSgrupo
            .Left     = 175
            .Top      = 115
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        loc_oSub.AddObject("txt_4c_DsSgrupo", "TextBox")
        WITH loc_oSub.txt_4c_DsSgrupo
            .Left     = 228
            .Top      = 115
            .Width    = 236
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaOperacoes()
    *==========================================================================
        LOCAL loc_oSub AS Object
        loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3

        *-- Obs container
        loc_oSub.AddObject("cnt_4c_Operacao", "Container")
        WITH loc_oSub.cnt_4c_Operacao
            .Left        = 3
            .Top         = 13
            .Width       = 564
            .Height      = 165
            .BackColor   = RGB(240,240,240)
            .BorderWidth = 1
            .BackStyle   = 1
            .Visible     = .T.
        ENDWITH
        loc_oSub.cnt_4c_Operacao.AddObject("lbl_4c__Obs", "Label")
        WITH loc_oSub.cnt_4c_Operacao.lbl_4c__Obs
            .Caption   = "Obs. :"
            .Left      = 12
            .Top       = 10
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oSub.cnt_4c_Operacao.AddObject("txt_4c_CodObs", "TextBox")
        WITH loc_oSub.cnt_4c_Operacao.txt_4c_CodObs
            .Left     = 52
            .Top      = 10
            .Width    = 27
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        loc_oSub.cnt_4c_Operacao.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oSub.cnt_4c_Operacao.obj_4c_GetObs
            .Left     = 83
            .Top      = 10
            .Width    = 407
            .Height   = 112
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Process commandgroup (1 button: Processar Distribuicao)
        loc_oSub.AddObject("cmdg_4c_ProcOper", "CommandGroup")
        WITH loc_oSub.cmdg_4c_ProcOper
            .Left        = 733
            .Top         = 11
            .Width       = 120
            .Height      = 122
            .ButtonCount = 1
        ENDWITH
        WITH loc_oSub.cmdg_4c_ProcOper.Buttons(1)
            .Caption = "Processar Distribui" + CHR(231) + CHR(227) + "o"
            .Left    = 5
            .Top     = 5
            .Width   = 106
            .Height  = 110
            .Picture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
        ENDWITH

        *-- Operations pageframe (Movimentacoes + Itens)
        loc_oSub.AddObject("pgf_4c_Operacoes", "PageFrame")
        WITH loc_oSub.pgf_4c_Operacoes
            .Left      = 1
            .Top       = 191
            .Width     = 997
            .Height    = 377
            .PageCount = 2
            .Tabs      = .T.
            .Page1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
            .Page2.Caption = "Itens"
        ENDWITH

        *-- grdCabOperas: 8 columns matching legacy (emps/dopes/numes/empds/grupos/contaos/grupods/contads)
        loc_oSub.pgf_4c_Operacoes.Page1.AddObject("grd_4c_CabOperas", "Grid")
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
            .Left             = 9
            .Top              = 6
            .Width            = 975
            .Height           = 339
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 8
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .ReadOnly         = .T.
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1
            .ControlSource   = "cursor_4c_CabOpera.emps"
            .Width           = 45
            .Header1.Caption = "Emp O"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2
            .ControlSource   = "cursor_4c_CabOpera.dopes"
            .Width           = 250
            .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3
            .ControlSource   = "cursor_4c_CabOpera.numes"
            .Width           = 80
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4
            .ControlSource   = "cursor_4c_CabOpera.empds"
            .Width           = 45
            .Header1.Caption = "Emp D"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5
            .ControlSource   = "cursor_4c_CabOpera.grupos"
            .Width           = 80
            .Header1.Caption = "Grupo Orig"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6
            .ControlSource   = "cursor_4c_CabOpera.contaos"
            .Width           = 80
            .Header1.Caption = "Conta Orig"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column7
            .ControlSource   = "cursor_4c_CabOpera.grupods"
            .Width           = 80
            .Header1.Caption = "Grupo Dest"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column8
            .ControlSource   = "cursor_4c_CabOpera.contads"
            .Width           = 80
            .Header1.Caption = "Conta Dest"
        ENDWITH

        *-- grdItnOperas: 6 columns (cpros/dpros/codcors/codtams/qtds/locals)
        loc_oSub.pgf_4c_Operacoes.Page2.AddObject("grd_4c_ItnOperas", "Grid")
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
            .Left             = 9
            .Top              = 5
            .Width            = 975
            .Height           = 340
            .RecordSource     = ""
            .RecordSourceType = 1
            .ColumnCount      = 6
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .GridLines        = 1
            .ReadOnly         = .T.
            .Themes           = .F.
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1
            .ControlSource   = "cursor_4c_ItensOper.cpros"
            .Width           = 106
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2
            .ControlSource   = "cursor_4c_ItensOper.dpros"
            .Width           = 382
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3
            .ControlSource   = "cursor_4c_ItensOper.codcors"
            .Width           = 60
            .Header1.Caption = "Cor"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4
            .ControlSource   = "cursor_4c_ItensOper.codtams"
            .Width           = 60
            .Header1.Caption = "Tam"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5
            .ControlSource   = "cursor_4c_ItensOper.qtds"
            .Width           = 150
            .Header1.Caption = "Quantidade"
        ENDWITH
        WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column6
            .ControlSource   = "cursor_4c_ItensOper.locals"
            .Width           = 150
            .Header1.Caption = "Local"
        ENDWITH
    ENDPROC

    *==========================================================================
    * METODOS DE NEGOCIO
    *==========================================================================

    PROCEDURE CarregarLista()
    *==========================================================================
        THIS.this_oBusinessObject.this_dDataInicial = ;
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value
        THIS.this_oBusinessObject.this_dDataFinal = ;
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value
        THIS.this_oBusinessObject.Buscar("")
        THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = ""
        IF USED("cursor_4c_Dados")
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 2
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.ControlSource = "cursor_4c_Dados.Codigos"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.ControlSource = "cursor_4c_Dados.Datas"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.Header1.Caption = "Data"
        ENDIF
        THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
    ENDPROC

    PROCEDURE AbrirNovoBatch()
    *==========================================================================
        THIS.this_cEscolha = "INSERIR"
        THIS.this_cCodigos = ALLTRIM(TRANSFORM(fGerUniqueKey("SIGPRDIS"), "@L 9999999999"))
        THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = THIS.this_cCodigos
        THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "NOVO"

        IF THIS.this_oBusinessObject.BuscarEstoques()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF

        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
    ENDPROC

    PROCEDURE AbrirBatchExistente(par_cCodigos)
    *==========================================================================
        THIS.this_cEscolha = "ALTERAR"
        THIS.this_cCodigos = par_cCodigos
        THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = par_cCodigos
        THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "EDITAR"

        THIS.this_oBusinessObject.InicializarLote(par_cCodigos)

        IF THIS.this_oBusinessObject.BuscarEstoques()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF

        *-- Pre-marcar estoques do lote
        IF USED("cursor_4c_Estoques") AND USED("cursor_4c_LotePrDis")
            LOCAL loc_cEmpEst AS String
            SELECT cursor_4c_Estoques
            GO TOP
            DO WHILE !EOF("cursor_4c_Estoques")
                loc_cEmpEst = ALLTRIM(cursor_4c_Estoques.emps)
                SELECT cursor_4c_LotePrDis
                LOCATE FOR ALLTRIM(empds) = loc_cEmpEst
                IF FOUND()
                    REPLACE nMarca WITH 1 IN cursor_4c_Estoques
                ENDIF
                SELECT cursor_4c_Estoques
                SKIP
            ENDDO
            GO TOP IN cursor_4c_Estoques
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF

        *-- Carregar operacoes existentes
        IF THIS.this_oBusinessObject.BuscarOperacoes(par_cCodigos)
            LOCAL loc_oGrdCab AS Object
            loc_oGrdCab = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
            loc_oGrdCab.RecordSource = ""
            loc_oGrdCab.ColumnCount  = 8
            loc_oGrdCab.RecordSource = "cursor_4c_CabOpera"
            loc_oGrdCab.Column1.ControlSource   = "cursor_4c_CabOpera.emps"
            loc_oGrdCab.Column1.Header1.Caption = "Emp O"
            loc_oGrdCab.Column2.ControlSource   = "cursor_4c_CabOpera.dopes"
            loc_oGrdCab.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
            loc_oGrdCab.Column3.ControlSource   = "cursor_4c_CabOpera.numes"
            loc_oGrdCab.Column3.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrdCab.Column4.ControlSource   = "cursor_4c_CabOpera.empds"
            loc_oGrdCab.Column4.Header1.Caption = "Emp D"
            loc_oGrdCab.Column5.ControlSource   = "cursor_4c_CabOpera.grupos"
            loc_oGrdCab.Column5.Header1.Caption = "Grupo Orig"
            loc_oGrdCab.Column6.ControlSource   = "cursor_4c_CabOpera.contaos"
            loc_oGrdCab.Column6.Header1.Caption = "Conta Orig"
            loc_oGrdCab.Column7.ControlSource   = "cursor_4c_CabOpera.grupods"
            loc_oGrdCab.Column7.Header1.Caption = "Grupo Dest"
            loc_oGrdCab.Column8.ControlSource   = "cursor_4c_CabOpera.contads"
            loc_oGrdCab.Column8.Header1.Caption = "Conta Dest"
            loc_oGrdCab.Refresh()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .T.
        ENDIF

        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        IF par_nPagina = 1
            THIS.CarregarLista()
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
            ELSE
                THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
            ENDIF
        ENDIF
        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS
    *==========================================================================

    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    PROCEDURE BtnNovoClick()
    *==========================================================================
        THIS.AbrirNovoBatch()
    ENDPROC

    PROCEDURE BtnAbrirClick()
    *==========================================================================
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 ;
                AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCAL loc_cCodigos AS String
            loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
            IF !EMPTY(loc_cCodigos)
                THIS.AbrirBatchExistente(loc_cCodigos)
            ENDIF
        ELSE
            MsgAviso("Selecione um lote na lista.", "Aviso")
        ENDIF
    ENDPROC

    PROCEDURE TxtDtInicialValid()
    *==========================================================================
        LOCAL loc_oDtI AS Object, loc_oDtF AS Object
        loc_oDtI = THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial
        loc_oDtF = THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal
        IF loc_oDtI.Value > loc_oDtF.Value
            loc_oDtF.Value = loc_oDtI.Value
        ENDIF
    ENDPROC

    PROCEDURE TxtDtFinalValid()
    *==========================================================================
        LOCAL loc_oDtI AS Object, loc_oDtF AS Object
        loc_oDtI = THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial
        loc_oDtF = THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal
        IF loc_oDtF.Value < loc_oDtI.Value
            loc_oDtI.Value = loc_oDtF.Value
        ENDIF
    ENDPROC

    PROCEDURE TxtDtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        THIS.CarregarLista()
        THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
    ENDPROC

    PROCEDURE BtnVoltarListaClick()
    *==========================================================================
        THIS.pgf_4c_Paginas.Visible = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.CarregarLista()
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
        ELSE
            THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE BtnVoltarEstClick()
    *==========================================================================
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 1
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
    ENDPROC

    PROCEDURE BtnMarcarClick()
    *==========================================================================
        IF USED("cursor_4c_Estoques")
            SELECT cursor_4c_Estoques
            REPLACE ALL nMarca WITH 1
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarClick()
    *==========================================================================
        IF USED("cursor_4c_Estoques")
            SELECT cursor_4c_Estoques
            REPLACE ALL nMarca WITH 0
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
    *==========================================================================
        NODEFAULT
        IF USED("cursor_4c_Estoques")
            SELECT cursor_4c_Estoques
            REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF INLIST(par_nKeyCode, 13, 32)
            NODEFAULT
            IF USED("cursor_4c_Estoques")
                SELECT cursor_4c_Estoques
                REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnProcessarPage1Click()
    *==========================================================================
        IF THIS.this_oBusinessObject.PrepararCursoresDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
            LOCAL loc_oSub2 AS Object
            loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
            loc_oSub2.grd_4c_Disponivel.RecordSource = ""
            IF USED("cursor_4c_Disponivel")
                loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
                loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
                loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
                loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
                loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
                loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
                loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
                loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
                loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
                loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
                loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
                loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
                loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
                loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
            ENDIF
            loc_oSub2.grd_4c_Disponivel.Refresh()
            loc_oSub2.grd_4c_Distribui.RecordSource = ""
            IF USED("cursor_4c_Distribui")
                loc_oSub2.grd_4c_Distribui.ColumnCount = 4
                loc_oSub2.grd_4c_Distribui.RecordSource = "cursor_4c_Distribui"
                loc_oSub2.grd_4c_Distribui.Column1.ControlSource = "cursor_4c_Distribui.emps"
                loc_oSub2.grd_4c_Distribui.Column1.Header1.Caption = "Empresa"
                loc_oSub2.grd_4c_Distribui.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
                loc_oSub2.grd_4c_Distribui.Column2.Header1.Caption = "Saldo"
                loc_oSub2.grd_4c_Distribui.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
                loc_oSub2.grd_4c_Distribui.Column3.Header1.Caption = "Quantidade"
                loc_oSub2.grd_4c_Distribui.Column4.ControlSource = "cursor_4c_Distribui.locals"
                loc_oSub2.grd_4c_Distribui.Column4.Header1.Caption = "Local"
            ENDIF
            loc_oSub2.grd_4c_Distribui.Refresh()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .T.
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 2
            loc_oSub2.grd_4c_Disponivel.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
    *==========================================================================
        IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel")
            LOCAL loc_cCpros AS String
            SELECT cursor_4c_Disponivel
            loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
            IF !EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.BuscarProduto(loc_cCpros)
                LOCAL loc_oSub2 AS Object, loc_cCGru AS String, loc_cSGru AS String
                LOCAL loc_nRes AS Number, loc_oErro
                loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
                SELECT cursor_4c_Produto
                loc_cCGru = TratarNulo(cgrus,  "C")
                loc_cSGru = TratarNulo(sgrus,  "C")
                loc_oSub2.txt_4c_CdGrupo.Value       = loc_cCGru
                loc_oSub2.txt_4c_DsGrupoP.Value      = TratarNulo(dgrus,       "C")
                loc_oSub2.txt_4c_CdLinha.Value        = TratarNulo(linhas,      "C")
                loc_oSub2.txt_4c_DsLinha.Value        = TratarNulo(desclin,     "C")
                loc_oSub2.txt_4c_CdSgrupoP.Value      = loc_cSGru
                loc_oSub2.txt_4c_CdFornecedor.Value   = TratarNulo(ifors,       "C")
                loc_oSub2.txt_4c_DsFornecedor.Value   = TratarNulo(rclis,       "C")
                loc_oSub2.txt_4c_CodFinP.Value        = TratarNulo(codfinp,     "C")
                loc_oSub2.txt_4c_DesFinP.Value        = TratarNulo(descfeitio,  "C")
                loc_oSub2.txt_4c_RefFornecedor.Value  = TratarNulo(reffs,       "C")
                loc_oSub2.txt_4c_GrpVenda.Value       = TratarNulo(colecoes,    "C")
                loc_oSub2.txt_4c_GrDvenda.Value       = ""
                loc_oSub2.txt_4c_PrVenda.Value        = TratarNulo(pvens,       "N")
                loc_oSub2.txt_4c_MoedaPrVenda.Value   = TratarNulo(moevs,       "C")
                loc_oSub2.txt_4c_PesoMedio.Value      = TratarNulo(pesoms,      "N")

                *-- Subgrupo description from SigCdPsg (separate query like original)
                IF !EMPTY(loc_cSGru)
                    TRY
                        IF USED("cursor_4c_TmpSgru")
                            USE IN cursor_4c_TmpSgru
                        ENDIF
                        loc_nRes = SQLEXEC(gnConnHandle, ;
                            "SELECT s.descricaos FROM SigCdPsg s" + ;
                            " WHERE s.cgrus = " + EscaparSQL(loc_cCGru) + ;
                            " AND s.codigos = " + EscaparSQL(loc_cSGru), ;
                            "cursor_4c_TmpSgru")
                        IF loc_nRes > 0 AND USED("cursor_4c_TmpSgru") AND RECCOUNT("cursor_4c_TmpSgru") > 0
                            SELECT cursor_4c_TmpSgru
                            loc_oSub2.txt_4c_DsSgrupoP.Value = TratarNulo(descricaos, "C")
                        ELSE
                            loc_oSub2.txt_4c_DsSgrupoP.Value = ""
                        ENDIF
                        IF USED("cursor_4c_TmpSgru")
                            USE IN cursor_4c_TmpSgru
                        ENDIF
                    CATCH TO loc_oErro
                        MsgErro(loc_oErro.Message, "Erro lookup subgrupo")
                    ENDTRY
                ELSE
                    loc_oSub2.txt_4c_DsSgrupoP.Value = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE GrdDistribuiQtdLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        IF USED("cursor_4c_Disponivel") AND USED("cursor_4c_Distribui") ;
                AND !EOF("cursor_4c_Disponivel")
            LOCAL loc_cCpros AS String, loc_cCodCors AS String, loc_cCodTams AS String
            SELECT cursor_4c_Disponivel
            loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
            loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
            loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)
            THIS.this_oBusinessObject.CalcularSaldo(loc_cCpros, loc_cCodCors, loc_cCodTams)
            LOCAL loc_oSub2 AS Object
            loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
            loc_oSub2.grd_4c_Disponivel.Refresh()
            loc_oSub2.grd_4c_Distribui.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE GrdDistribuiLocalValid()
    *==========================================================================
        LOCAL loc_cLocal AS String, loc_nRes AS Number, loc_oLookup AS Object
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cLocal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2 ;
                .grd_4c_Distribui.Column4.Text1.Value)
            IF !EMPTY(loc_cLocal)
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Codigos LIKE " + ;
                    EscaparSQL(loc_cLocal + "%") + " ORDER BY Codigos", ;
                    "cursor_4c_Locais", "Codigos", loc_cLocal, ;
                    "Localiza" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.AddColuna("Codigos",    "", "Localiza" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.AddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.Show()
                    IF USED("cursor_4c_Locais") AND RECCOUNT("cursor_4c_Locais") > 0
                        IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
                            REPLACE cursor_4c_Distribui.locals WITH ALLTRIM(cursor_4c_Locais.Codigos)
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_Locais")
                        USE IN cursor_4c_Locais
                    ENDIF
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Lookup Local")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        DO CASE
            CASE par_nKeyCode = 9
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Column1.SetFocus()
                NODEFAULT
            CASE par_nKeyCode = 115
                THIS.GrdDistribuiLocalValid()
                NODEFAULT
        ENDCASE
    ENDPROC

    PROCEDURE TxtProdutoInicialValid()
    *==========================================================================
        LOCAL loc_cCpros AS String, loc_nRec AS Number
        loc_cCpros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.txt_4c_ProdutoInicial.Value)
        IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Disponivel")
            SELECT cursor_4c_Disponivel
            loc_nRec = RECNO()
            GO TOP
            LOCATE FOR ALLTRIM(cpros) >= loc_cCpros
            IF EOF()
                GO loc_nRec
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE TxtCodSgrupoValid(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cCodigo AS String, loc_nRes AS Number, loc_oLookup AS Object, loc_oErro
        LOCAL loc_oSub2 AS Object
        loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        DO CASE
            CASE par_nKeyCode = 13 OR par_nKeyCode = 115
                NODEFAULT
            CASE par_nKeyCode = 9
                NODEFAULT
            OTHERWISE
                RETURN
        ENDCASE
        loc_cCodigo = ALLTRIM(loc_oSub2.txt_4c_CodSgrupo.Value)
        IF EMPTY(loc_cCodigo)
            loc_oSub2.txt_4c_DsSgrupo.Value = ""
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_SgruBusca")
                USE IN cursor_4c_SgruBusca
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos LIKE " + ;
                EscaparSQL(loc_cCodigo + "%") + " ORDER BY codigos", ;
                "cursor_4c_SgruBusca")
            IF loc_nRes > 0 AND USED("cursor_4c_SgruBusca") AND RECCOUNT("cursor_4c_SgruBusca") > 0
                IF RECCOUNT("cursor_4c_SgruBusca") = 1
                    SELECT cursor_4c_SgruBusca
                    loc_oSub2.txt_4c_CodSgrupo.Value = ALLTRIM(cursor_4c_SgruBusca.codigos)
                    loc_oSub2.txt_4c_DsSgrupo.Value  = ALLTRIM(cursor_4c_SgruBusca.descricaos)
                ELSE
                    loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                        "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos LIKE " + ;
                        EscaparSQL(loc_cCodigo + "%") + " ORDER BY codigos", ;
                        "cursor_4c_SgruBuscaD", "codigos", loc_cCodigo, "Subgrupos")
                    IF VARTYPE(loc_oLookup) = "O"
                        loc_oLookup.AddColuna("codigos",    "XXXXXXXXXX", "C" + CHR(243) + "digo")
                        loc_oLookup.AddColuna("descricaos", "",            "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.Show()
                        IF USED("cursor_4c_SgruBuscaD") AND RECCOUNT("cursor_4c_SgruBuscaD") > 0
                            SELECT cursor_4c_SgruBuscaD
                            loc_oSub2.txt_4c_CodSgrupo.Value = ALLTRIM(cursor_4c_SgruBuscaD.codigos)
                            loc_oSub2.txt_4c_DsSgrupo.Value  = ALLTRIM(cursor_4c_SgruBuscaD.descricaos)
                        ENDIF
                        IF USED("cursor_4c_SgruBuscaD")
                            USE IN cursor_4c_SgruBuscaD
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                loc_oSub2.txt_4c_CodSgrupo.Value = ""
                loc_oSub2.txt_4c_DsSgrupo.Value  = ""
            ENDIF
            IF USED("cursor_4c_SgruBusca")
                USE IN cursor_4c_SgruBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro lookup Subgrupo C" + CHR(243) + "digo")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDsSgrupoValid(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cDesc AS String, loc_oLookup AS Object, loc_oErro
        LOCAL loc_oSub2 AS Object
        loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        DO CASE
            CASE par_nKeyCode = 13 OR par_nKeyCode = 115
                NODEFAULT
            CASE par_nKeyCode = 9
                NODEFAULT
            OTHERWISE
                RETURN
        ENDCASE
        loc_cDesc = ALLTRIM(loc_oSub2.txt_4c_DsSgrupo.Value)
        IF EMPTY(loc_cDesc)
            loc_oSub2.txt_4c_CodSgrupo.Value = ""
            RETURN
        ENDIF
        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SELECT descricaos, codigos FROM SigCdPsg ORDER BY descricaos", ;
                "cursor_4c_SgruBuscaDesc", "descricaos", loc_cDesc, "Subgrupos")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.AddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.AddColuna("codigos",    "", "C" + CHR(243) + "digo")
                loc_oLookup.Show()
                IF USED("cursor_4c_SgruBuscaDesc") AND RECCOUNT("cursor_4c_SgruBuscaDesc") > 0
                    SELECT cursor_4c_SgruBuscaDesc
                    loc_oSub2.txt_4c_CodSgrupo.Value = ALLTRIM(cursor_4c_SgruBuscaDesc.codigos)
                    loc_oSub2.txt_4c_DsSgrupo.Value  = ALLTRIM(cursor_4c_SgruBuscaDesc.descricaos)
                ELSE
                    loc_oSub2.txt_4c_CodSgrupo.Value = ""
                    loc_oSub2.txt_4c_DsSgrupo.Value  = ""
                ENDIF
                IF USED("cursor_4c_SgruBuscaDesc")
                    USE IN cursor_4c_SgruBuscaDesc
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro lookup Subgrupo Descri" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    PROCEDURE TxtCGrupoValid(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cCodigo AS String, loc_nRes AS Number, loc_oLookup AS Object, loc_oErro
        LOCAL loc_oSub2 AS Object
        loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        loc_cCodigo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
        IF loc_cCodigo == THIS.this_cUltimoCGrupoValidado
            RETURN
        ENDIF
        IF EMPTY(loc_cCodigo)
            loc_oSub2.txt_4c_DsGrupo.Value     = ""
            THIS.this_cUltimoCGrupoValidado     = ""
        ELSE
            TRY
                IF USED("cursor_4c_GrpBusca")
                    USE IN cursor_4c_GrpBusca
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
                    EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", "cursor_4c_GrpBusca")
                IF loc_nRes > 0 AND USED("cursor_4c_GrpBusca") AND RECCOUNT("cursor_4c_GrpBusca") > 0
                    IF RECCOUNT("cursor_4c_GrpBusca") = 1
                        SELECT cursor_4c_GrpBusca
                        loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBusca.CGrus)
                        loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBusca.DGrus)
                        THIS.this_cUltimoCGrupoValidado = ALLTRIM(cursor_4c_GrpBusca.CGrus)
                    ELSE
                        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                            "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
                            EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", ;
                            "cursor_4c_GrpBuscaD", "CGrus", loc_cCodigo, "Grupos")
                        IF VARTYPE(loc_oLookup) = "O"
                            loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
                            loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oLookup.Show()
                            IF USED("cursor_4c_GrpBuscaD") AND RECCOUNT("cursor_4c_GrpBuscaD") > 0
                                SELECT cursor_4c_GrpBuscaD
                                loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaD.CGrus)
                                loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaD.DGrus)
                                THIS.this_cUltimoCGrupoValidado = ALLTRIM(cursor_4c_GrpBuscaD.CGrus)
                            ENDIF
                            IF USED("cursor_4c_GrpBuscaD")
                                USE IN cursor_4c_GrpBuscaD
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    loc_oSub2.txt_4c_CodGrupo.Value = ""
                    loc_oSub2.txt_4c_DsGrupo.Value  = ""
                    THIS.this_cUltimoCGrupoValidado  = ""
                ENDIF
                IF USED("cursor_4c_GrpBusca")
                    USE IN cursor_4c_GrpBusca
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro lookup Grupo C" + CHR(243) + "digo")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE TxtDGrupoValid(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_cDesc AS String, loc_oLookup AS Object, loc_oErro
        LOCAL loc_oSub2 AS Object
        loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        loc_cDesc  = ALLTRIM(loc_oSub2.txt_4c_DsGrupo.Value)
        IF loc_cDesc == THIS.this_cUltimoDGrupoValidado
            RETURN
        ENDIF
        IF EMPTY(loc_cDesc)
            loc_oSub2.txt_4c_CodGrupo.Value    = ""
            THIS.this_cUltimoDGrupoValidado     = ""
        ELSE
            TRY
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SELECT DGrus, CGrus FROM SigCdGrp ORDER BY DGrus", ;
                    "cursor_4c_GrpBuscaDesc", "DGrus", loc_cDesc, "Grupos")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oLookup.Show()
                    IF USED("cursor_4c_GrpBuscaDesc") AND RECCOUNT("cursor_4c_GrpBuscaDesc") > 0
                        SELECT cursor_4c_GrpBuscaDesc
                        loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaDesc.CGrus)
                        loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaDesc.DGrus)
                        THIS.this_cUltimoDGrupoValidado = ALLTRIM(cursor_4c_GrpBuscaDesc.DGrus)
                    ELSE
                        loc_oSub2.txt_4c_CodGrupo.Value = ""
                        loc_oSub2.txt_4c_DsGrupo.Value  = ""
                        THIS.this_cUltimoDGrupoValidado = ""
                    ENDIF
                    IF USED("cursor_4c_GrpBuscaDesc")
                        USE IN cursor_4c_GrpBuscaDesc
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro lookup Grupo Descri" + CHR(231) + CHR(227) + "o")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE BtnFiltrarClick()
    *==========================================================================
        LOCAL loc_oSub2 AS Object, loc_cCGrupo AS String, loc_nRes AS Number, loc_oErro
        loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
        loc_cCGrupo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
        IF !USED("cursor_4c_Disponivel")
            RETURN
        ENDIF
        IF EMPTY(loc_cCGrupo)
            loc_oSub2.grd_4c_Disponivel.RecordSource = ""
            loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
            loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
            loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
            loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
            loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
            loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
            loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
            loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
            loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
            loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
            loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
            loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
            loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
            loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
            loc_oSub2.grd_4c_Disponivel.Refresh()
        ELSE
            TRY
                IF USED("cursor_4c_DispFiltro")
                    USE IN cursor_4c_DispFiltro
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT DISTINCT a.cpros," + ;
                    "  ISNULL(p.dpros,'') AS dpros," + ;
                    "  a.codcors, a.codtams," + ;
                    "  SUM(a.qtdos) AS QtdEstoque," + ;
                    "  SUM(a.qtds) AS QtdSaida," + ;
                    "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
                    " FROM SigPrDis a" + ;
                    " INNER JOIN SigCdPro p ON p.cpros = a.cpros" + ;
                    " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                    "   AND p.cgrus = " + EscaparSQL(loc_cCGrupo) + ;
                    " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
                    " ORDER BY a.cpros, a.codcors, a.codtams", "cursor_4c_DispFiltro")
                IF loc_nRes > 0
                    loc_oSub2.grd_4c_Disponivel.RecordSource = ""
                    loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
                    loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_DispFiltro"
                    loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_DispFiltro.cpros"
                    loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_DispFiltro.dpros"
                    loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_DispFiltro.codcors"
                    loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
                    loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_DispFiltro.codtams"
                    loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
                    loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_DispFiltro.QtdEstoque"
                    loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
                    loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_DispFiltro.QtdSaida"
                    loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
                    loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_DispFiltro.QtdSaldo"
                    loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
                    loc_oSub2.grd_4c_Disponivel.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro Filtrar")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE ImgFotoClick()
    *==========================================================================
        LOCAL loc_nRes AS Number, loc_cArquivo AS String, loc_oErro
        IF !USED("cursor_4c_Disponivel") OR EOF("cursor_4c_Disponivel")
            RETURN
        ENDIF
        TRY
            SELECT cursor_4c_Disponivel
            LOCAL loc_cCpros AS String
            loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
            IF !EMPTY(loc_cCpros)
                IF USED("cursor_4c_TmpFoto")
                    USE IN cursor_4c_TmpFoto
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros), ;
                    "cursor_4c_TmpFoto")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpFoto") > 0
                    SELECT cursor_4c_TmpFoto
                    IF !EMPTY(cursor_4c_TmpFoto.FigJpgs) AND !ISNULL(cursor_4c_TmpFoto.FigJpgs)
                        LOCAL loc_cBase64 AS String, loc_cBin AS String
                        loc_cBase64 = STRTRAN(STRTRAN(STRTRAN( ;
                            cursor_4c_TmpFoto.FigJpgs, ;
                            "data:image/png;base64,",  ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,",  "")
                        loc_cBin     = STRCONV(loc_cBase64, 14)
                        loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                        STRTOFILE(loc_cBin, loc_cArquivo)
                        IF FILE(loc_cArquivo)
                            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.img_4c_FigJpg.Picture = ;
                                loc_cArquivo
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_TmpFoto")
                    USE IN cursor_4c_TmpFoto
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar foto do produto")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSalvarClick()
    *==========================================================================
        IF THIS.this_oBusinessObject.ProcessarDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
            MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso.", "Sucesso")
            THIS.this_cEscolha = "ALTERAR"
            THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption = "EDITAR"
            *-- Switch to operacoes page
            IF THIS.this_oBusinessObject.BuscarOperacoes(THIS.this_cCodigos)
                LOCAL loc_oSub3 AS Object
                loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
                LOCAL loc_oGrdCab2 AS Object
                loc_oGrdCab2 = loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
                loc_oGrdCab2.RecordSource = ""
                IF USED("cursor_4c_CabOpera")
                    loc_oGrdCab2.ColumnCount  = 8
                    loc_oGrdCab2.RecordSource = "cursor_4c_CabOpera"
                    loc_oGrdCab2.Column1.ControlSource   = "cursor_4c_CabOpera.emps"
                    loc_oGrdCab2.Column1.Header1.Caption = "Emp O"
                    loc_oGrdCab2.Column2.ControlSource   = "cursor_4c_CabOpera.dopes"
                    loc_oGrdCab2.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                    loc_oGrdCab2.Column3.ControlSource   = "cursor_4c_CabOpera.numes"
                    loc_oGrdCab2.Column3.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrdCab2.Column4.ControlSource   = "cursor_4c_CabOpera.empds"
                    loc_oGrdCab2.Column4.Header1.Caption = "Emp D"
                    loc_oGrdCab2.Column5.ControlSource   = "cursor_4c_CabOpera.grupos"
                    loc_oGrdCab2.Column5.Header1.Caption = "Grupo Orig"
                    loc_oGrdCab2.Column6.ControlSource   = "cursor_4c_CabOpera.contaos"
                    loc_oGrdCab2.Column6.Header1.Caption = "Conta Orig"
                    loc_oGrdCab2.Column7.ControlSource   = "cursor_4c_CabOpera.grupods"
                    loc_oGrdCab2.Column7.Header1.Caption = "Grupo Dest"
                    loc_oGrdCab2.Column8.ControlSource   = "cursor_4c_CabOpera.contads"
                    loc_oGrdCab2.Column8.Header1.Caption = "Conta Dest"
                ENDIF
                loc_oGrdCab2.Refresh()
                loc_oSub3.Enabled = .T.
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 3
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnProcOperClick()
    *==========================================================================
        LOCAL loc_oSub3 AS Object, loc_cCodObs AS String, loc_cObs AS String
        loc_oSub3   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
        loc_cCodObs = ALLTRIM(loc_oSub3.cnt_4c_Operacao.txt_4c_CodObs.Value)
        loc_cObs    = ALLTRIM(loc_oSub3.cnt_4c_Operacao.obj_4c_GetObs.Value)
        MsgAviso("Processamento de opera" + CHR(231) + CHR(245) + "es n" + ;
                 CHR(227) + "o implementado nesta vers" + CHR(227) + "o." + CHR(13) + ;
                 "O lote j" + CHR(225) + " foi salvo em SigPrDis.", "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE GrdCabOperasAfterRowColChange(par_nColIndex)
    *==========================================================================
        IF USED("cursor_4c_CabOpera") AND !EOF("cursor_4c_CabOpera")
            SELECT cursor_4c_CabOpera
            LOCAL loc_cEmpDopNums AS String
            loc_cEmpDopNums = ALLTRIM(cursor_4c_CabOpera.empdopnums)
            IF !EMPTY(loc_cEmpDopNums) AND THIS.this_oBusinessObject.BuscarItensOperacao(loc_cEmpDopNums)
                LOCAL loc_oSub3 AS Object
                loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
                LOCAL loc_oGrdItn AS Object
                loc_oGrdItn = loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
                loc_oGrdItn.RecordSource = ""
                IF USED("cursor_4c_ItensOper")
                    loc_oGrdItn.ColumnCount  = 6
                    loc_oGrdItn.RecordSource = "cursor_4c_ItensOper"
                    loc_oGrdItn.Column1.ControlSource   = "cursor_4c_ItensOper.cpros"
                    loc_oGrdItn.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrdItn.Column2.ControlSource   = "cursor_4c_ItensOper.dpros"
                    loc_oGrdItn.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrdItn.Column3.ControlSource   = "cursor_4c_ItensOper.codcors"
                    loc_oGrdItn.Column3.Header1.Caption = "Cor"
                    loc_oGrdItn.Column4.ControlSource   = "cursor_4c_ItensOper.codtams"
                    loc_oGrdItn.Column4.Header1.Caption = "Tam"
                    loc_oGrdItn.Column5.ControlSource   = "cursor_4c_ItensOper.qtds"
                    loc_oGrdItn.Column5.Header1.Caption = "Quantidade"
                    loc_oGrdItn.Column6.ControlSource   = "cursor_4c_ItensOper.locals"
                    loc_oGrdItn.Column6.Header1.Caption = "Local"
                ENDIF
                loc_oGrdItn.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere filtros de data do form para o BO
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg1 AS Object
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        THIS.this_oBusinessObject.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
        THIS.this_oBusinessObject.this_dDataFinal   = loc_oPg1.txt_4c_DtFinal.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO de volta para o form
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg1 AS Object
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(THIS.this_oBusinessObject.this_dDataInicial) = "D" ;
                AND !EMPTY(THIS.this_oBusinessObject.this_dDataInicial)
            loc_oPg1.txt_4c_DtInicial.Value = THIS.this_oBusinessObject.this_dDataInicial
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject.this_dDataFinal) = "D" ;
                AND !EMPTY(THIS.this_oBusinessObject.this_dDataFinal)
            loc_oPg1.txt_4c_DtFinal.Value = THIS.this_oBusinessObject.this_dDataFinal
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Atualiza lista com filtros de data atuais do form
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.FormParaBO()
        THIS.CarregarLista()
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
        ELSE
            THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao em Page2 e volta para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF MsgConfirma("Cancelar e voltar para a lista de lotes?", ;
                "Cancelar Opera" + CHR(231) + CHR(227) + "o")
            THIS.this_cEscolha = ""
            THIS.this_cCodigos = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = ""
            THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.CarregarLista()
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
            ELSE
                THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos de filtro de data (Page1)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1 AS Object
        IF VARTYPE(par_lHabilitar) != "L"
            par_lHabilitar = .T.
        ENDIF
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg1.txt_4c_DtInicial.Enabled = par_lHabilitar
        loc_oPg1.txt_4c_DtFinal.Enabled   = par_lHabilitar
        loc_oPg1.cmd_4c_Novo.Enabled       = par_lHabilitar
        loc_oPg1.cmd_4c_Abrir.Enabled      = par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta filtros de data para hoje e recarrega lista
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_dHoje AS Date
        loc_dHoje = DATE()
        THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value = loc_dHoje
        THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value   = loc_dHoje
        THIS.this_oBusinessObject.this_dDataInicial = loc_dHoje
        THIS.this_oBusinessObject.this_dDataFinal   = loc_dHoje
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo ativo
    * Modo "LISTA": todos os botoes da Page1 habilitados
    * Modo "DADOS": botoes da Page1 desabilitados enquanto edita lote
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lEmLista AS Logical
        IF VARTYPE(par_cModo) != "C"
            par_cModo = "LISTA"
        ENDIF
        loc_lEmLista = (UPPER(ALLTRIM(par_cModo)) = "LISTA")
        THIS.HabilitarCampos(loc_lEmLista)
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        THIS.AbrirNovoBatch()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
        LOCAL loc_cCodigos AS String
        loc_cCodigos = ""
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF
        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um lote na lista.", "Aviso")
            RETURN
        ENDIF
        THIS.AbrirBatchExistente(loc_cCodigos)
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
        LOCAL loc_cCodigos AS String
        loc_cCodigos = ""
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF
        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um lote na lista.", "Aviso")
            RETURN
        ENDIF
        THIS.AbrirBatchExistente(loc_cCodigos)
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        LOCAL loc_cCodigos AS String, loc_lResultado AS Logical, loc_nRes AS Number, loc_oErro AS Object
        loc_lResultado = .F.
        loc_cCodigos = ""
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
        ENDIF
        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um lote na lista.", "Aviso")
            RETURN
        ENDIF
        IF !MsgConfirma("Confirmar exclus" + CHR(227) + "o do lote " + loc_cCodigos + "?", "Excluir Lote")
            RETURN
        ENDIF
        TRY
            loc_nRes = SQLEXEC(gnConnHandle, "DELETE FROM SigPrDis WHERE Codigos = " + EscaparSQL(loc_cCodigos))
            IF loc_nRes >= 0
                loc_lResultado = .T.
                MsgInfo("Lote exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao excluir lote: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprdisBO.prg):
*=============================================================================*
* sigprdisBO.prg - Business Object para Distribuicao de Produtos
*=============================================================================*
* Herda de: BusinessBase
* Form associado: Formsigprdis.prg (forms\operacionais\)
* Tabela principal: sigprdis (PK: cidchaves)
* Tabela auxiliar : SIGTEMPD  (cidchaves C64 - temp de processamento)
*
* Descricao: Gerencia a distribuicao de produtos entre empresas/estoques.
*   - Page1 (Lista): lista de distribuicoes por periodo (TmpSigPrDis)
*   - Page2 (Dados): grade de disponivel (crDisponivel) e distribuicao
*                    (crDistribui) por empresa/grupo/conta
*   - Page3 (Ops)  : historico de operacoes geradas pelo processamento
*
* Campos sigprdis:
*   cidchaves C(20)   PK auto (fUniqueIds por linha)
*   codigos   C(10)   chave de lote (agrupa N linhas do mesmo lote)
*   datas     T       data/hora do lote
*   dtalts    T       data/hora ultima alteracao
*   cpros     C(14)   codigo do produto
*   codcors   C(4)    codigo da cor
*   codtams   C(4)    codigo do tamanho
*   empdopnums C(29)  empresa+operacao+numero destino gerado
*   empds     C(3)    empresa destino
*   empgruests C(23)  empresa+grupo+conta (composto 3+10+10)
*   locals    C(10)   localizacao/enderecamento
*   qtds      N(10,2) quantidade distribuida
*   qtdos     N(10,2) quantidade original (pre-distribuicao)
*   usuars    C(10)   usuario que criou
*   usualts   C(10)   usuario que alterou por ultimo
*   oridopnums C(29)  empresa+operacao+numero origem
*=============================================================================*

DEFINE CLASS sigprdisBO AS BusinessBase

    *-- Identificacao do lote (chave de negocio usada nos SELECTs de listagem)
    this_cCodigos       = ""

    *-- PK fisica de cada linha da distribuicao (gerada por fUniqueIds)
    this_cCidChaves     = ""

    *-- Data e hora do lote
    this_dDatas         = {}

    *-- Data e hora da ultima alteracao
    this_dDtAlts        = {}

    *-- Codigo do produto distribuido
    this_cCpros         = ""

    *-- Codigo da cor do produto
    this_cCodCors       = ""

    *-- Codigo do tamanho do produto
    this_cCodTams       = ""

    *-- Empresa + Operacao + Numero destino (composto char 29)
    this_cEmpDopNums    = ""

    *-- Empresa destino (char 3)
    this_cEmpDs         = ""

    *-- Empresa + Grupo + Conta composto (char 23 = 3+10+10)
    this_cEmpGruEsts    = ""

    *-- Localizacao / enderecamento do estoque (char 10)
    this_cLocals        = ""

    *-- Quantidade distribuida
    this_nQtds          = 0

    *-- Quantidade original (antes da distribuicao, preenchida no processamento)
    this_nQtdOs         = 0

    *-- Usuario que criou o lancamento
    this_cUsuars        = ""

    *-- Usuario da ultima alteracao
    this_cUsuAlts       = ""

    *-- Empresa + Operacao + Numero origem (char 29)
    this_cOriDopNums    = ""

    *-- Filtros de pesquisa de lotes (usados em Buscar)
    this_dDataInicial   = {}
    this_dDataFinal     = {}

    *-- Chave de query temporaria (cidquerys em SIGTEMPD, gerada por fUniqueIds)
    this_cCidQuerys     = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "sigprdis"
        THIS.this_cCampoChave  = "cidchaves"
        THIS.this_dDataInicial = DATE()
        THIS.this_dDataFinal   = DATE()
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * METODOS CRUD (BusinessBase)
    *==========================================================================

    *--------------------------------------------------------------------------
    * Buscar - Lista lotes de distribuicao por periodo (cursor_4c_Dados)
    * Colunas: Codigos, Datas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cWhere)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
                       " WHERE CAST(Datas AS date) BETWEEN " + ;
                       FormatarDataSQL(THIS.this_dDataInicial) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDataFinal) + ;
                       " ORDER BY Datas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar distribui" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeira linha de um lote pelo campo Codigos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT TOP 1 * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY cidchaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso             = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_cCodigos       = ALLTRIM(par_cCodigos)
                THIS.this_lNovoRegistro  = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves   = TratarNulo(cidchaves,   "C")
            THIS.this_cCodigos     = TratarNulo(codigos,     "C")
            THIS.this_dDatas       = IIF(ISNULL(datas),  {}, datas)
            THIS.this_dDtAlts      = IIF(ISNULL(dtalts), {}, dtalts)
            THIS.this_cCpros       = TratarNulo(cpros,       "C")
            THIS.this_cCodCors     = TratarNulo(codcors,     "C")
            THIS.this_cCodTams     = TratarNulo(codtams,     "C")
            THIS.this_cEmpDopNums  = TratarNulo(empdopnums,  "C")
            THIS.this_cEmpDs       = TratarNulo(empds,       "C")
            THIS.this_cEmpGruEsts  = TratarNulo(empgruests,  "C")
            THIS.this_cLocals      = TratarNulo(locals,      "C")
            THIS.this_nQtds        = TratarNulo(qtds,        "N")
            THIS.this_nQtdOs       = TratarNulo(qtdos,       "N")
            THIS.this_cUsuars      = TratarNulo(usuars,      "C")
            THIS.this_cUsuAlts     = TratarNulo(usualts,     "C")
            THIS.this_cOriDopNums  = TratarNulo(oridopnums,  "C")
            loc_lSucesso           = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigPrDis" + ;
                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)                       + "," + ;
                       EscaparSQL(THIS.this_cCodigos)                         + "," + ;
                       EscaparSQL(THIS.this_cCodCors)                         + "," + ;
                       EscaparSQL(THIS.this_cCodTams)                         + "," + ;
                       EscaparSQL(THIS.this_cCpros)                           + "," + ;
                       "GETDATE(),"                                                  + ;
                       "GETDATE(),"                                                  + ;
                       EscaparSQL(THIS.this_cEmpDopNums)                      + "," + ;
                       EscaparSQL(THIS.this_cEmpDs)                           + "," + ;
                       EscaparSQL(THIS.this_cEmpGruEsts)                      + "," + ;
                       EscaparSQL(THIS.this_cLocals)                          + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs)                    + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtds)                     + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(THIS.this_cOriDopNums)                      + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrDis SET" + ;
                       "  codcors    = " + EscaparSQL(THIS.this_cCodCors)              + "," + ;
                       "  codtams    = " + EscaparSQL(THIS.this_cCodTams)              + "," + ;
                       "  cpros      = " + EscaparSQL(THIS.this_cCpros)                + "," + ;
                       "  dtalts     = GETDATE(),"                                           + ;
                       "  empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)           + "," + ;
                       "  empds      = " + EscaparSQL(THIS.this_cEmpDs)                + "," + ;
                       "  empgruests = " + EscaparSQL(THIS.this_cEmpGruEsts)           + "," + ;
                       "  locals     = " + EscaparSQL(THIS.this_cLocals)               + "," + ;
                       "  qtdos      = " + FormatarNumeroSQL(THIS.this_nQtdOs)         + "," + ;
                       "  qtds       = " + FormatarNumeroSQL(THIS.this_nQtds)          + "," + ;
                       "  usualts    = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))   + "," + ;
                       "  oridopnums = " + EscaparSQL(THIS.this_cOriDopNums)                  + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do lote completo de SigPrDis (por Codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir lote de distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * METODOS DE NEGOCIO (operacional - distribuicao de produtos)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BuscarEstoques - Carrega SigCdCeg (tpcads=3) com flag nMarca para selecao
    * Cria cursor_4c_Estoques: nMarca, cidchaves, emps, grupos, contas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEstoques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Estoques")
                USE IN cursor_4c_Estoques
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarca, cidchaves AS cidchaves, emps AS emps, grupos AS grupos, contas AS contas" + ;
                       " FROM SigCdCeg" + ;
                       " WHERE tpcads = 3" + ;
                       " ORDER BY emps, grupos, contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoques")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Estoques")
                    GO TOP IN cursor_4c_Estoques
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarEstoques:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarLote - Carrega todas as linhas SigPrDis de um lote
    * Cria cursor_4c_LotePrDis com todos os campos de SigPrDis
    *--------------------------------------------------------------------------
    PROCEDURE InicializarLote(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LotePrDis")
                USE IN cursor_4c_LotePrDis
            ENDIF

            loc_cSQL = "SELECT * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LotePrDis")

            IF loc_nResultado < 0
                MsgErro("Erro ao inicializar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_LotePrDis")
                    GO TOP IN cursor_4c_LotePrDis
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em InicializarLote:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresDistribuicao
    * Prepara cursor_4c_Disponivel e cursor_4c_Distribui a partir dos
    * estoques marcados em cursor_4c_Estoques.
    * par_cCodigos : codigo do lote (vazio se INSERIR)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursoresDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nSel
        LOCAL loc_cEmp, loc_cGrupo, loc_cConta, loc_nQtdDistr
        loc_lSucesso = .F.

        TRY
            *-- Contar estoques marcados
            loc_nSel = 0
            IF USED("cursor_4c_Estoques")
                SELECT cursor_4c_Estoques
                COUNT FOR nMarca = 1 TO loc_nSel
            ENDIF

            IF loc_nSel = 0
                MsgAviso("Nenhum estoque foi selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Fechar cursores anteriores
            IF USED("cursor_4c_Disponivel")
                USE IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                USE IN cursor_4c_Distribui
            ENDIF

            *-- Montar cursor_4c_Disponivel
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "SELECT a.cpros AS cpros, ISNULL(p.dpros,'') AS dpros," + ;
                           "  a.codcors AS codcors, a.codtams AS codtams," + ;
                           "  SUM(a.qtdos) AS QtdEstoque," + ;
                           "  SUM(a.qtds)  AS QtdSaida," + ;
                           "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
                           " FROM SigPrDis a" + ;
                           " LEFT JOIN SigCdPro p ON p.cpros = a.cpros" + ;
                           " WHERE a.Codigos = " + EscaparSQL(par_cCodigos) + ;
                           " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
                           " ORDER BY a.cpros, a.codcors, a.codtams"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Disponivel")
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar produtos disponivel:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Disponivel ;
                    (cpros C(14), dpros C(65), codcors C(4), codtams C(4), ;
                     QtdEstoque N(10,2), QtdSaida N(10,2), QtdSaldo N(10,2))
                SET NULL OFF
            ENDIF

            *-- Montar cursor_4c_Distribui a partir dos estoques marcados
            SET NULL ON
            CREATE CURSOR cursor_4c_Distribui ;
                (emps C(3), grupos C(10), contas C(10), ;
                 QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
            SET NULL OFF

            SELECT cursor_4c_Estoques
            GO TOP
            DO WHILE !EOF("cursor_4c_Estoques")
                IF cursor_4c_Estoques.nMarca = 1
                    loc_cEmp   = ALLTRIM(cursor_4c_Estoques.emps)
                    loc_cGrupo = ALLTRIM(cursor_4c_Estoques.grupos)
                    loc_cConta = ALLTRIM(cursor_4c_Estoques.contas)
                    loc_nQtdDistr = 0

                    IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND ;
                       !EMPTY(par_cCodigos) AND ;
                       USED("cursor_4c_LotePrDis")
                        SELECT cursor_4c_LotePrDis
                        GO TOP
                        SCAN FOR ALLTRIM(empds) = loc_cEmp
                            loc_nQtdDistr = loc_nQtdDistr + qtds
                        ENDSCAN
                    ENDIF

                    INSERT INTO cursor_4c_Distribui ;
                        (emps, grupos, contas, QtdSaldo, QtdDistr, locals) ;
                        VALUES (loc_cEmp, loc_cGrupo, loc_cConta, 0, loc_nQtdDistr, "")
                ENDIF
                SELECT cursor_4c_Estoques
                SKIP
            ENDDO

            IF USED("cursor_4c_Disponivel")
                GO TOP IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                GO TOP IN cursor_4c_Distribui
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em PrepararCursoresDistribuicao:" + CHR(13) + ;
                    loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularSaldo - Recalcula QtdSaldo em cursor_4c_Disponivel
    * Chamado apos edicao de QtdDistr em cursor_4c_Distribui
    * par_cCpros/par_cCodCors/par_cCodTams: produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE CalcularSaldo(par_cCpros, par_cCodCors, par_cCodTams)
        LOCAL loc_nQtdDistr, loc_nQtdEstoque, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Distribui") OR !USED("cursor_4c_Disponivel")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Distribui
            SUM QtdDistr TO loc_nQtdDistr

            SELECT cursor_4c_Disponivel
            LOCATE FOR ALLTRIM(cpros)   = ALLTRIM(par_cCpros)  AND ;
                        ALLTRIM(codcors) = ALLTRIM(par_cCodCors) AND ;
                        ALLTRIM(codtams) = ALLTRIM(par_cCodTams)

            IF FOUND()
                loc_nQtdEstoque = cursor_4c_Disponivel.QtdEstoque

                IF loc_nQtdEstoque - loc_nQtdDistr < 0
                    MsgAviso("Saldo insuficiente para movimentar.", "Aviso")
                    SELECT cursor_4c_Distribui
                    GO TOP
                    REPLACE ALL QtdDistr WITH 0
                    loc_nQtdDistr = 0
                    *-- Recalcular apos zerar
                    SELECT cursor_4c_Distribui
                    SUM QtdDistr TO loc_nQtdDistr
                ENDIF

                SELECT cursor_4c_Disponivel
                REPLACE QtdSaida WITH loc_nQtdDistr
                REPLACE QtdSaldo WITH (loc_nQtdEstoque - loc_nQtdDistr)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em CalcularSaldo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Carrega detalhes de produto para exibicao no painel lateral
    * Cria cursor_4c_Produto com campos do SigCdPro + joins
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.cgrus, a.dpros, a.sgrus, a.cunis," + ;
                       "  a.reffs, a.valors, a.moedas, a.pvens, a.moevs," + ;
                       "  a.pesoms, a.linhas, a.situas, a.colecoes," + ;
                       "  a.pcuss, a.moecs, a.pvideals, a.ifors, a.codfinp," + ;
                       "  ISNULL(c.Rclis, '') AS rclis," + ;
                       "  ISNULL(g.dgrus, '') AS dgrus," + ;
                       "  ISNULL(l.descs,  '') AS desclin," + ;
                       "  ISNULL(f.descs,  '') AS descfeitio" + ;
                       " FROM SigCdPro a" + ;
                       " LEFT JOIN SigCdCli c ON c.iclis  = a.ifors" + ;
                       " LEFT JOIN SigCdGrp g ON g.cgrus  = a.cgrus" + ;
                       " LEFT JOIN SigCdLin l ON l.linhas = a.linhas" + ;
                       " LEFT JOIN SigPrFti f ON f.cods   = a.cftios" + ;
                       " WHERE a.cpros = " + EscaparSQL(par_cCpros)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Produto") > 0
                GO TOP IN cursor_4c_Produto
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarProduto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDistribuicao
    * Grava o lote de distribuicao em SigPrDis a partir de cursor_4c_Distribui
    * e cursor_4c_Disponivel. Usa transacao explicita para garantir atomicidade.
    * par_cCodigos : codigo do lote (Codigos)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_lTransacaoAberta
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cCidChaves, loc_cCpros, loc_cCodCors, loc_cCodTams
        LOCAL loc_nQtdDistr, loc_cEmps, loc_cGrupos, loc_cContas
        LOCAL loc_nTotDis, loc_nQtdNeg

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.

        *-- Validar cursor_4c_Distribui tem quantidades
        IF !USED("cursor_4c_Distribui")
            MsgAviso("Cursor de distribui" + CHR(231) + CHR(227) + CHR(227) + ;
                     "o n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Distribui
        SUM QtdDistr TO loc_nTotDis
        IF loc_nTotDis = 0
            MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
            RETURN .F.
        ENDIF

        *-- Validar sem saldos negativos em cursor_4c_Disponivel
        IF USED("cursor_4c_Disponivel")
            SELECT cursor_4c_Disponivel
            GO TOP
            COUNT FOR QtdSaldo < 0 TO loc_nQtdNeg
            IF loc_nQtdNeg > 0
                MsgAviso("Existem produtos distribu" + CHR(237) + "dos que est" + ;
                         CHR(227) + "o ficando com saldo negativo." + CHR(13) + ;
                         "Favor checar antes de processar.", "Aviso")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacaoAberta = .T.

            *-- Se ALTERAR: remover linhas existentes do lote
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                           EscaparSQL(par_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    MsgErro("Erro ao remover lote anterior:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Para cada produto disponivel x empresa distribui: INSERT em SigPrDis
            IF USED("cursor_4c_Disponivel")
                SELECT cursor_4c_Disponivel
                GO TOP
                DO WHILE !EOF("cursor_4c_Disponivel")
                    loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
                    loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
                    loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)

                    SELECT cursor_4c_Distribui
                    GO TOP
                    DO WHILE !EOF("cursor_4c_Distribui")
                        loc_nQtdDistr = cursor_4c_Distribui.QtdDistr
                        loc_cEmps     = ALLTRIM(cursor_4c_Distribui.emps)
                        loc_cGrupos   = ALLTRIM(cursor_4c_Distribui.grupos)
                        loc_cContas   = ALLTRIM(cursor_4c_Distribui.contas)

                        IF loc_nQtdDistr > 0
                            loc_cCidChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigPrDis" + ;
                                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidChaves)                               + "," + ;
                                       EscaparSQL(par_cCodigos)                                 + "," + ;
                                       EscaparSQL(loc_cCodCors)                                 + "," + ;
                                       EscaparSQL(loc_cCodTams)                                 + "," + ;
                                       EscaparSQL(loc_cCpros)                                   + "," + ;
                                       "GETDATE(),"                                                    + ;
                                       "GETDATE(),"                                                    + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(loc_cEmps)                                    + "," + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Distribui.locals))          + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       "'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                MsgErro("Erro ao inserir linha de distribui" + ;
                                        CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_Distribui
                        SKIP
                    ENDDO

                    SELECT cursor_4c_Disponivel
                    SKIP
                ENDDO
            ENDIF

            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            loc_lTransacaoAberta = .F.

            THIS.this_cCodigos = par_cCodigos
            THIS.RegistrarAuditoria(IIF(UPPER(ALLTRIM(par_cEscolha)) = "INSERIR", "INSERT", "UPDATE"))
            loc_lSucesso = .T.

        CATCH TO loException
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            MsgErro("Erro em ProcessarDistribuicao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega operacoes de SigMvCab geradas pela distribuicao
    * Cria cursor_4c_CabOpera: cidchaves, emps, dopes, numes, grupos, datas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CabOpera")
                USE IN cursor_4c_CabOpera
            ENDIF

            loc_cSQL = "SELECT m.cidchaves AS cidchaves, m.emps AS emps, m.dopes AS dopes, m.numes AS numes," + ;
                       "  m.empds AS empds, m.grupos AS grupos, m.contaos AS contaos," + ;
                       "  m.grupods AS grupods, m.contads AS contads," + ;
                       "  m.datas AS datas, m.empdopnums AS empdopnums" + ;
                       " FROM SigMvCab m" + ;
                       " WHERE m.empdopnums IN (" + ;
                       "   SELECT DISTINCT empdopnums FROM sigprdis" + ;
                       "   WHERE Codigos = " + EscaparSQL(par_cCodigos) + ")" + ;
                       " ORDER BY m.emps, m.dopes, m.numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOpera")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_CabOpera")
                    GO TOP IN cursor_4c_CabOpera
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarOperacoes:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensOperacao - Carrega itens distribuidos de uma operacao/lote
    * Cria cursor_4c_ItensOper: cidchaves, cpros, dpros, codcors, codtams, qtds, locals
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensOperacao(par_cEmpdopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ItensOper")
                USE IN cursor_4c_ItensOper
            ENDIF

            loc_cSQL = "SELECT d.cidchaves, d.cpros, ISNULL(p.dpros,'') AS dpros," + ;
                       "  d.codcors, d.codtams, d.qtds, d.locals" + ;
                       " FROM sigprdis d" + ;
                       " LEFT JOIN SigCdPro p ON p.cpros = d.cpros" + ;
                       " WHERE d.empdopnums = " + EscaparSQL(par_cEmpdopNums) + ;
                       " ORDER BY d.cpros, d.codcors, d.codtams"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensOper")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar itens da opera" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ItensOper")
                    GO TOP IN cursor_4c_ItensOper
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarItensOperacao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

