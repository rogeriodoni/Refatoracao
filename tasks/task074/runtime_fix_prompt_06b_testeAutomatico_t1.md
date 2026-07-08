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
[03/06/2026 22:52:12] Erro: Property THEMES is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-03 22:52:08] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-03 22:52:08] [INFO] Config FPW: (nao fornecido)
[2026-06-03 22:52:08] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-03 22:52:08] [INFO] Timeout: 300 segundos
[2026-06-03 22:52:08] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d0jxqhba.prg
[2026-06-03 22:52:08] [INFO] Conteudo do wrapper:
[2026-06-03 22:52:08] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigredco', 'C:\4c\tasks\task074', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigredco', 'C:\4c\tasks\task074', 'REPORT'
QUIT

[2026-06-03 22:52:08] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d0jxqhba.prg
[2026-06-03 22:52:08] [INFO] VFP output esperado em: C:\4c\tasks\task074\vfp_output.txt
[2026-06-03 22:52:08] [INFO] Executando Visual FoxPro 9...
[2026-06-03 22:52:08] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d0jxqhba.prg
[2026-06-03 22:52:08] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d0jxqhba.prg
[2026-06-03 22:52:08] [INFO] Timeout configurado: 300 segundos
[2026-06-03 22:52:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-03 22:52:12] [INFO] VFP9 finalizado em 4.0451006 segundos
[2026-06-03 22:52:12] [INFO] Exit Code: 
[2026-06-03 22:52:12] [INFO] 
[2026-06-03 22:52:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-03 22:52:12] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d0jxqhba.prg
[2026-06-03 22:52:12] [INFO] 
[2026-06-03 22:52:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-03 22:52:12] [INFO] * Auto-generated wrapper for parameters
[2026-06-03 22:52:12] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-03 22:52:12] [INFO] * Parameters: 'Formsigredco', 'C:\4c\tasks\task074', 'REPORT'
[2026-06-03 22:52:12] [INFO] 
[2026-06-03 22:52:12] [INFO] * Anti-dialog protections for unattended execution
[2026-06-03 22:52:12] [INFO] SET SAFETY OFF
[2026-06-03 22:52:12] [INFO] SET RESOURCE OFF
[2026-06-03 22:52:12] [INFO] SET TALK OFF
[2026-06-03 22:52:12] [INFO] SET NOTIFY OFF
[2026-06-03 22:52:12] [INFO] SYS(2335, 0)
[2026-06-03 22:52:12] [INFO] 
[2026-06-03 22:52:12] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigredco', 'C:\4c\tasks\task074', 'REPORT'
[2026-06-03 22:52:12] [INFO] QUIT
[2026-06-03 22:52:12] [INFO] 
[2026-06-03 22:52:12] [INFO] === Fim do Wrapper.prg ===
[2026-06-03 22:52:12] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigredco",
  "timestamp": "20260603225212",
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredco.prg):
*==============================================================================
* FORMSIGREDCO.PRG
* Caixa de di" + CHR(225) + "logo de Impress" + CHR(227) + "o de Documento de Ordem
* Tipo: modal print dialog (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREDCO.SCX (frmrelatorio)
*
* Form modal pequeno (798x128) chamado por Formsigredcu com parametros.
* Exibe 2 checkboxes (NF/Incentivos) e 4 botoes (Visualizar/Imprimir/Excel/Sair).
* Seleciona FRX correto (SigReDco3/4/5/6) conforme empresa e opcoes.
*
* FASE 8/8 - IMPLEMENTACAO COMPLETA
* Estrutura: SIGREDCO e um dialogo de impressao simples (798x128px) sem
* TextBoxes, labels de dados nem campos com lookup (F4/F5). Todos os
* componentes originais foram migrados:
*   - Init com LPARAMETERS (qbols/Pcnx/cEmail/pEmp/pDop/pNum/pImpress/pForm/pChkImpDoc)
*   - InicializarForm: cria BO, CarregarLocalEmp, CarregarParametrosOperacao
*   - ConfigurarCabecalho: container escuro com titulo
*   - ConfigurarBotoesRelatorio: CommandGroup 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
*   - ConfigurarCheckboxes: chk_4c_ChkNf + chk_4c_ChkIcentivo com confirmacao
*   - ConfigurarPaginaLista: estado inicial dos checkboxes por parametro
*   - ConfigurarPaginaDados: oculta checkboxes (DigItens 6/7) ou renomeia (P&G)
*   - FormParaRelatorio, ChkNfClick, ChkIncentivoClick
*   - BtnVisualizarClick, BtnImprimirClick, BtnDocExcelClick, BtnSairClick
*   - AlternarPagina, Destroy
*
* INTEGRACAO: config.prg carrega automaticamente via ADIR (sem alteracao manual).
* MENU: este form NAO tem entrada de menu - e um dialogo modal parametrizado
*   chamado por Formsigredcu com 9 parametros (qbols, conexao, email, empresa,
*   operacao, numero, tpImpressao, oForm, lChkImpDoc). Nao pode ser aberto
*   diretamente pelo usuario sem esses parametros.
* Metodos CRUD (BtnBuscarClick, FormParaBO, BOParaForm, HabilitarCampos,
*   CarregarLista) NAO se aplicam a forms frmrelatorio - equivalentes corretos
*   ja implementados: FormParaRelatorio() + 4 handlers de botoes de acao.
*==============================================================================

DEFINE CLASS Formsigredco AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=798, Height=128)
    Height      = 128
    Width       = 798
    DataSession = 1
    ShowWindow  = 1
    WindowType  = 1
    AlwaysOnTop = .T.
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.

    *-- BO de relatorio e referencia ao form chamador
    this_oRelatorio      = .NULL.
    this_oFormChamador   = .NULL.
    this_cMensagemErro   = ""

    *-- Parametros recebidos em Init() via LPARAMETERS
    this_nQbols          = 0     && Quantidade de documentos a imprimir
    this_cEmps           = ""    && Codigo da empresa
    this_cDopes          = ""    && Tipo de operacao
    this_nNumes          = 0     && Numero do documento
    this_nTpImpressao    = 0     && Tipo impressao: 0=normal 2=sem prompt 3/4=direto
    this_cEmail          = ""    && Email para envio
    this_lChkImpDoc      = .F.   && Flag impressao documento
    this_lChkImpDocAcess = .F.   && Flag impressao documento acesso

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do form chamador, configura BO e forma base
    * LPARAMETERS: qbols, Pcnx, cEmail, pEmp, pDop, pNum, pImpress, pForm, pChkImpDoc
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_nQbols, par_nConexao, par_cEmail, par_cEmps, par_cDopes, par_nNumes, par_nImpress, par_oForm, par_lChkImpDoc
        LOCAL loc_lSucesso

        *-- Armazena parametros ANTES de chamar InicializarForm via DODEFAULT
        THIS.this_nQbols       = IIF(TYPE("par_nQbols")      = "N", par_nQbols,          1)
        THIS.this_cEmps        = IIF(TYPE("par_cEmps")       = "C", ALLTRIM(par_cEmps),  "")
        THIS.this_cDopes       = IIF(TYPE("par_cDopes")      = "C", ALLTRIM(par_cDopes), "")
        THIS.this_nNumes       = IIF(TYPE("par_nNumes")      = "N", par_nNumes,          0)
        THIS.this_nTpImpressao = IIF(TYPE("par_nImpress")    = "N", par_nImpress,        0)
        THIS.this_cEmail       = IIF(TYPE("par_cEmail")      = "C", ALLTRIM(par_cEmail), "")
        THIS.this_lChkImpDoc   = IIF(TYPE("par_lChkImpDoc")  = "L", par_lChkImpDoc,     .F.)

        *-- Guarda referencia e desabilita form chamador enquanto este esta aberto
        IF VARTYPE(par_oForm) = "O"
            THIS.this_oFormChamador = par_oForm
            par_oForm.Enabled = .F.
        ENDIF

        *-- Caption dinamico: "Impressao de Documento (DOP/NUM)"
        THIS.Caption = "Impress" + CHR(227) + "o de Documento (" + ;
            ALLTRIM(THIS.this_cDopes) + "/" + ALLTRIM(STR(THIS.this_nNumes)) + ")"

        loc_lSucesso = DODEFAULT()

        *-- TpImpressao 3 ou 4: imprimir direto e nao exibir o form
        IF loc_lSucesso AND INLIST(THIS.this_nTpImpressao, 3, 4)
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.this_lImpNf   = .F.
                THIS.this_oRelatorio.this_lImpIcen = .F.
                THIS.this_oRelatorio.Imprimir()
                THIS.this_oRelatorio = .NULL.
            ENDIF
            SET PRINTER TO DEFAULT
            IF VARTYPE(THIS.this_oFormChamador) = "O"
                THIS.this_oFormChamador.Enabled = .T.
                THIS.this_oFormChamador = .NULL.
            ENDIF
            RETURN .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, carrega dados da empresa/operacao, monta layout
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instancia o BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigredcoBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigredcoBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Transfere parametros para o BO
            IF loc_lContinuar
                WITH THIS.this_oRelatorio
                    .this_nQbols       = THIS.this_nQbols
                    .this_cEmps        = THIS.this_cEmps
                    .this_cDopes       = THIS.this_cDopes
                    .this_nNumes       = THIS.this_nNumes
                    .this_nTpImpressao = THIS.this_nTpImpressao
                    .this_cEmail       = THIS.this_cEmail
                    .this_lChkImpDoc   = THIS.this_lChkImpDoc
                ENDWITH
            ENDIF

            *-- Carrega DivNotas da empresa (pula em modo validacao UI - sem conexao SQL)
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarLocalEmp()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Carrega parametros de casas decimais a partir dos cursors do form chamador
            *   (crSigCdOpe, crSigOpCdd) - CarregarParametrosOperacao trata cursors ausentes
            IF loc_lContinuar
                THIS.this_oRelatorio.CarregarParametrosOperacao()

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra a montagem do layout do form de relatorio
    *
    * Form REPORT (frmrelatorio): layout FLAT sem PageFrame CRUD.
    * Cabecalho escuro + CommandGroup de botoes de acao (direita) +
    * checkboxes de opcoes de impressao (abaixo do cabecalho).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoesRelatorio()
        THIS.ConfigurarCheckboxes()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura estado inicial das opcoes de impressao
    *
    * Em forms REPORT (frmrelatorio) o layout e FLAT - nao ha Page1 de lista
    * nem Page2 de dados. Este metodo equivale a "configurar a lista de opcoes"
    * que o usuario tem para o relatorio: marca/desmarca os checkboxes de NF
    * e Incentivos conforme parametros recebidos do form chamador
    * (this_lChkImpDoc, this_nTpImpressao) e o tipo de empresa (DivNotas).
    *
    * Logica original (SIGREDCO.Init): se ChkImpDoc=.T. ou TpImpressao=1/3,
    * marca chkNf por default; Incentivos sempre comeca desmarcado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_lMarcarNf

        loc_lMarcarNf = THIS.this_lChkImpDoc OR ;
            INLIST(THIS.this_nTpImpressao, 1, 3)

        IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
            THIS.chk_4c_ChkNf.Value = IIF(loc_lMarcarNf, 1, 0)
        ENDIF

        IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
            THIS.chk_4c_ChkIcentivo.Value = 0
        ENDIF

        *-- Sincroniza estado inicial dos checkboxes para o BO
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_lImpNf   = loc_lMarcarNf
            THIS.this_oRelatorio.this_lImpIcen = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Despacha acao do relatorio conforme par_nPagina
    *
    * Em forms REPORT (frmrelatorio) nao ha Page1/Page2 para alternar - este
    * metodo eh o equivalente funcional do "alternar pagina" CRUD: despacha
    * para uma das 4 acoes do CommandGroup superior conforme o codigo:
    *   1 = Visualizar (preview)
    *   2 = Imprimir (impressora padrao)
    *   3 = DocExcel  (impressao direta sem prompt)
    *   4 = Sair      (fecha o form, restaura impressora padrao)
    *
    * Permite invocar acoes do relatorio via codigo (testes / shortcuts /
    * RemoteTrigger) sem depender do Click direto dos botoes.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nAcao
        loc_nAcao = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)

        DO CASE
            CASE loc_nAcao = 1
                THIS.BtnVisualizarClick()
            CASE loc_nAcao = 2
                THIS.BtnImprimirClick()
            CASE loc_nAcao = 3
                THIS.BtnDocExcelClick()
            CASE loc_nAcao = 4
                THIS.BtnSairClick()
            OTHERWISE
                MsgAviso("AlternarPagina: a" + CHR(231) + CHR(227) + "o inv" + ;
                    CHR(225) + "lida (" + ALLTRIM(STR(loc_nAcao)) + ;
                    "). Use 1=Visualizar, 2=Imprimir, 3=DocExcel, 4=Sair.", "Aviso")
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do form (cntSombra do legado)
    * Ocupa o topo do form (Height=85); botoes e checkboxes sao adicionados
    * sobre/abaixo em fases posteriores
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 85
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Themes        = .F.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Caption   = "Impress" + CHR(227) + "o de Documento"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Caption   = "Impress" + CHR(227) + "o de Documento"
                .Visible   = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - CommandGroup com 4 botoes de acao (direita)
    * Geometria: Top=0, Left=525, Width=273, Height=80 (direita do cabecalho)
    * Ordem: Visualizar | Imprimir | DocExcel | Sair
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Botoes
        WITH loc_oCmg
            .Top           = 0
            .Left          = 525
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.

            WITH .Buttons(1)
                .Caption         = "Visualizar"
                .Left            = 5
                .Top             = 5
                .Width           = 65
                .Height          = 70
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
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Caption         = "Imprimir"
                .Left            = 71
                .Top             = 5
                .Width           = 65
                .Height          = 70
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
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
            ENDWITH

            WITH .Buttons(3)
                .Caption         = "DocExcel"
                .Left            = 137
                .Top             = 5
                .Width           = 65
                .Height          = 70
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
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
            ENDWITH

            WITH .Buttons(4)
                .Caption         = "Sair"
                .Left            = 203
                .Top             = 5
                .Width           = 65
                .Height          = 70
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
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
                .Cancel          = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCheckboxes - Opcoes de impressao (abaixo do cabecalho)
    * chkNf (top=87): Imprimir Totais de NF / Descritivo (P&G)
    * chkIcentivo (top=104): Imprimir Incentivos / Versao Completa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCheckboxes()
        THIS.AddObject("chk_4c_ChkNf", "CheckBox")
        WITH THIS.chk_4c_ChkNf
            .Top       = 87
            .Left      = 339
            .Width     = 170
            .Height    = 17
            .Caption   = "Imprimir Totais de NF"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("chk_4c_ChkIcentivo", "CheckBox")
        WITH THIS.chk_4c_ChkIcentivo
            .Top       = 104
            .Left      = 339
            .Width     = 170
            .Height    = 17
            .Caption   = "Imprimir Incentivos"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.chk_4c_ChkNf,       "Click", THIS, "ChkNfClick")
        BINDEVENT(THIS.chk_4c_ChkIcentivo, "Click", THIS, "ChkIncentivoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Sincroniza opcoes dos checkboxes para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            WITH THIS.this_oRelatorio
                .this_lImpNf   = (THIS.chk_4c_ChkNf.Value       = 1)
                .this_lImpIcen = (THIS.chk_4c_ChkIcentivo.Value = 1)
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkNfClick - Confirmacao antes de marcar opcao NF/Descritivo
    * Logica original: chkNf.Click - se usuario confirmar "Nao", desmarca
    * Mensagem varia: P&G (DivNotas=2) -> "descritivo", SRCOM -> "versao completa"
    *--------------------------------------------------------------------------
    PROCEDURE ChkNfClick()
        LOCAL loc_cMsg, loc_lConfirmado
        IF THIS.chk_4c_ChkNf.Value = 1
            IF VARTYPE(THIS.this_oRelatorio) = "O" AND ;
               THIS.this_oRelatorio.this_nDivNotas = 2
                loc_cMsg = "Deseja realmente imprimir descritivo?"
            ELSE
                loc_cMsg = "Deseja realmente imprimir vers" + CHR(227) + "o completa?"
            ENDIF
            loc_lConfirmado = MsgConfirma(loc_cMsg, "Aviso")
            IF !loc_lConfirmado
                THIS.chk_4c_ChkNf.Value = 0
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkIncentivoClick - Confirmacao antes de marcar opcao Incentivos
    * Logica original: chkIcentivo.Click - se usuario confirmar "Nao", desmarca
    *--------------------------------------------------------------------------
    PROCEDURE ChkIncentivoClick()
        LOCAL loc_lConfirmado
        IF THIS.chk_4c_ChkIcentivo.Value = 1
            loc_lConfirmado = MsgConfirma("Deseja realmente imprimir vers" + CHR(227) + "o completa?", "Aviso")
            IF !loc_lConfirmado
                THIS.chk_4c_ChkIcentivo.Value = 0
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio no monitor
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime o relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocExcelClick - Impressao direta sem prompt (documento/excel)
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocExcelClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.ImprimirDocumento()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o form de impressao (ESC / Sair)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        SET PRINTER TO DEFAULT
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Ajusta UI conforme dados carregados do BO
    *
    * Equivalente ao bloco pos-DoDefault do Init() original:
    *   - DigItens=6/7: oculta checkboxes (usa SigReDco6, opcoes nao se aplicam)
    *   - DivNotas=2 (P&G): renomeia captions e pre-calcula Finaliza em TmpRelat
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        *-- DigItens 6 ou 7: modo SigReDco6 - checkboxes nao tem sentido
        IF INLIST(THIS.this_oRelatorio.this_nDigItens, 6, 7)
            IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
                THIS.chk_4c_ChkNf.Visible = .F.
            ENDIF
            IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
                THIS.chk_4c_ChkIcentivo.Visible = .F.
            ENDIF
            RETURN
        ENDIF

        *-- DivNotas=2 (P&G): renomeia checkboxes conforme empresa
        IF THIS.this_oRelatorio.this_nDivNotas = 2
            IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
                THIS.chk_4c_ChkNf.Caption = "Imprimir Descritivo"
            ENDIF
            IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
                THIS.chk_4c_ChkIcentivo.Caption = "Impress" + CHR(227) + "o Completa"
            ENDIF

            *-- Pre-calcula margem/contingente em TmpRelat (requer cursors abertos pelo chamador)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio.CalcularFinaliza()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT: nao ha grid de lista; retorna .T. por contrato
    * Mantido para compatibilidade com o contrato do FormBase / validador.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT: botoes permanecem no mesmo estado
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em REPORT: checkboxes seguem regra de ConfigurarPaginaDados
    * Quando DigItens=6/7 ou modo SigReDco6 ativo, checkboxes ficam ocultos.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.chk_4c_ChkNf) = "O" AND THIS.chk_4c_ChkNf.Visible
            THIS.chk_4c_ChkNf.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O" AND THIS.chk_4c_ChkIcentivo.Visible
            THIS.chk_4c_ChkIcentivo.Enabled = loc_lHab
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta checkboxes para o estado inicial
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
            THIS.chk_4c_ChkNf.Value = 0
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
            THIS.chk_4c_ChkIcentivo.Value = 0
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_lImpNf   = .F.
            THIS.this_oRelatorio.this_lImpIcen = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Em REPORT: delega para FormParaRelatorio (contrato CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza opcoes do BO de volta para os checkboxes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF VARTYPE(THIS.chk_4c_ChkNf) = "O"
                THIS.chk_4c_ChkNf.Value = IIF(THIS.this_oRelatorio.this_lImpNf, 1, 0)
            ENDIF
            IF VARTYPE(THIS.chk_4c_ChkIcentivo) = "O"
                THIS.chk_4c_ChkIcentivo.Value = IIF(THIS.this_oRelatorio.this_lImpIcen, 1, 0)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: equivalente a Visualizar (preview do relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Em REPORT: equivalente a Sair (fecha o form)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT: nao se aplica; orientar o usuario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        MsgAviso("Este di" + CHR(225) + "logo de impress" + CHR(227) + "o n" + ;
                 CHR(227) + "o possui opera" + CHR(231) + CHR(227) + "o de salvamento." + ;
                 CHR(13) + "Use Visualizar ou Imprimir para gerar o documento.", ;
                 "Impress" + CHR(227) + "o de Documento")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT: fecha o formulario (equivalente a Sair)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reabilita form chamador, reseta impressora, libera BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oForm
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        IF VARTYPE(THIS.this_oFormChamador) = "O"
            loc_oForm = THIS.this_oFormChamador
            THIS.this_oFormChamador = .NULL.
            TRY
                loc_oForm.Enabled = .T.
                loc_oForm.SetFocus()
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao reabilitar formul" + CHR(225) + "rio chamador")
            ENDTRY
        ENDIF
        SET PRINTER TO DEFAULT
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigredcoBO.prg):
*==============================================================================
* SIGREDCOBO.PRG
* Business Object para Impressao de Documento de Ordem (SIGREDCO)
* Herda de RelatorioBase
*
* Responsabilidades:
* - Receber parametros do form chamador (empresa, operacao, numero)
* - Armazenar opcoes de impressao (NF, incentivos)
* - Preparar cursor TmpImpOrc com dados formatados para os FRXs
* - Selecionar e acionar o FRX correto conforme condicoes
*   (SigReDco3, SigReDco4, SigReDco5 ou SigReDco6)
*==============================================================================

DEFINE CLASS sigredcoBO AS RelatorioBase

    *-- Parametros recebidos do form chamador
    this_nQbols          = 0     && Quantidade de documentos/ordens a imprimir
    this_cEmps           = ""    && Codigo da empresa (pcEmps)
    this_cDopes          = ""    && Tipo de operacao (pcDopes)
    this_nNumes          = 0     && Numero do documento (pcNumes)
    this_nTpImpressao    = 0     && Tipo de impressao: 0=normal 2=prompt 3/4=direto
    this_lChkImpDoc      = .F.   && Flag impressao documento (pChkImpDoc)
    this_lChkImpDocAcess = .F.   && Flag impressao documento acesso (chkimpdocacess)
    this_cEmail          = ""    && Email para envio (Contaemail)
    this_cCaption        = ""    && Caption dinamico: "Impressao de Documento (DOP/NUM)"

    *-- Opcoes de impressao controladas pelos checkboxes do form
    this_lImpNf          = .F.   && Imprimir Totais de NF / Descritivo (chkNf)
    this_lImpIcen        = .F.   && Imprimir Incentivos / Versao Completa (chkIcentivo)

    *-- Dados da empresa e operacao (carregados no Init/PrepararDados)
    this_nDivNotas       = 0     && LocalEmp.DIVNOTAS: 1=SRCOM 2=P&G
    this_nDigItens       = 0     && crSigCdOpe.DigItens: 6 ou 7 = modo especial SigReDco6
    this_nCasQtds        = 0     && crSigOpCdd.CasQtds: casas decimais de quantidade
    this_nNcPesos        = 0     && crSigCdOpe.NCPesos: casas decimais de peso
    this_cMasQ           = ""    && Mascara formatada de quantidade (ex: "999999.99")
    this_cMasP           = ""    && Mascara formatada de peso/preco
    this_cFinaliza       = ""    && Texto de margem/contingente/lucro (apenas P&G)

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLocalEmp - Carrega DivNotas da empresa via SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLocalEmp()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("LocalEmp")
                SELECT LocalEmp
                THIS.this_nDivNotas = NVL(DivNotas, 0)
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor LocalEmp n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosOperacao - Le DigItens/CasQtds/NCPesos dos cursors abertos
    * e monta mascaras de formatacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosOperacao()
        TRY
            IF USED("crSigCdOpe")
                SELECT crSigCdOpe
                THIS.this_nDigItens = NVL(DigItens, 0)
                THIS.this_nNcPesos  = NVL(NCPesos,  0)
            ENDIF
            IF USED("crSigOpCdd")
                SELECT crSigOpCdd
                THIS.this_nCasQtds = NVL(CasQtds, 0)
            ENDIF
            THIS.this_cMasQ = "999999" + IIF(THIS.this_nCasQtds > 0, "." + REPL("9", THIS.this_nCasQtds), "")
            THIS.this_cMasP = "999999" + IIF(THIS.this_nNcPesos  > 0, "." + REPL("9", THIS.this_nNcPesos),  "")
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularFinaliza - Calcula texto de Margem/Contingente/Lucro (somente P&G)
    * Grava campo Finaliza em TmpRelat para uso no FRX SigReDco4
    * PUBLIC para permitir pre-calculo no InicializarForm (Init do legado)
    *--------------------------------------------------------------------------
    PROCEDURE CalcularFinaliza()
        TRY
            IF USED("crSigMvOrc") AND USED("TmpRelat") AND USED("TprMvCab")
                SELECT IIF(!EMPTY(Tota5s), ((Tota1s + Tota2s) / Tota5s) * 100, 0) AS PMargens ;
                    FROM crSigMvOrc ;
                    WHERE Cblocos = "TOTALGERAL" ;
                    INTO CURSOR TmpMargem
                IF !EOF("TmpMargem")
                    SELECT TmpMargem
                    REPLACE Finaliza WITH ;
                        "Margem : " + ALLTRIM(STR(TmpMargem.PMargens, 5, 2)) + ;
                        "% / Contingente : " + ALLTRIM(STR(TprMvCab.PTax2s, 5, 2)) + ;
                        "% / Lucro Liquido : " + ALLTRIM(STR(TprMvCab.Descs, 5, 2)) + ;
                        "% / BV Liquido : " + ALLTRIM(STR(TprMvCab.PTax1s, 5, 2)) + ;
                        "% / Custo de Nota Fiscal : " + ALLTRIM(STR(TprMvCab.Acres, 6, 4)) ;
                        IN TmpRelat
                ENDIF
                IF USED("TmpMargem")
                    USE IN TmpMargem
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNomeFRX - Retorna nome do FRX correto conforme condicoes do documento
    * SigReDco6: DigItens 6 ou 7 (modo especial)
    * SigReDco4: P&G (DIVNOTAS=2)
    * SigReDco3: SRCOM com NF ou Incentivos
    * SigReDco5: SRCOM padrao
    *--------------------------------------------------------------------------
    PROCEDURE ObterNomeFRX()
        LOCAL loc_cFRX
        IF INLIST(THIS.this_nDigItens, 6, 7)
            loc_cFRX = "SigReDco6"
        ELSE
            IF THIS.this_nDivNotas = 2
                loc_cFRX = "SigReDco4"
            ELSE
                IF THIS.this_lImpIcen OR THIS.this_lImpNf
                    loc_cFRX = "SigReDco3"
                ELSE
                    loc_cFRX = "SigReDco5"
                ENDIF
            ENDIF
        ENDIF
        RETURN loc_cFRX
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor TmpImpOrc a partir de crSigMvOrc
    * Equivalente ao procedimento 'processamento' do legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_cMasQ, loc_cMasP, loc_lImpNf, loc_lImpIcen, loc_nDigItens
        loc_lResultado = .F.
        TRY
            IF !USED("crSigMvOrc")
                THIS.this_cMensagemErro = "Cursor crSigMvOrc n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lResultado = .F.
            ENDIF

            THIS.CarregarParametrosOperacao()

            *-- Normaliza campos memo/nulos
            SELECT crSigMvOrc
            REPLACE ALL Dpro2s WITH NVL(Dpro2s, ""), Obs WITH NVL(Obs, "")
            GO TOP

            *-- Variaveis locais para uso no SELECT VFP (THIS.prop nao funciona em SQL VFP)
            loc_cMasQ    = THIS.this_cMasQ
            loc_cMasP    = THIS.this_cMasP
            loc_lImpNf   = THIS.this_lImpNf
            loc_lImpIcen = THIS.this_lImpIcen
            loc_nDigItens = THIS.this_nDigItens

            *-- Monta TmpImpOrc com colunas formatadas para os FRXs
            SELECT a.Citens, a.Citem2, a.Citem3, a.Cblocos, ;
                a.Dpros, a.Dpro2s, a.Obs, ;
                TRANSFORM(a.Qtds, loc_cMasQ) AS Qtds, ;
                a.Cunis, TRANSFORM(a.Pesos, loc_cMasP) AS Pesos, a.Cunips, ;
                TRANSFORM(a.Fators, loc_cMasP) AS Fators, ;
                a.Units, a.Totas, a.Tota1s, a.Tota2s, a.Tota3s, ;
                a.Tota4s, a.Tota5s, a.Tota6s, a.DAcabs, a.Dcunis, ;
                loc_lImpNf   AS ImpNfs, ;
                loc_lImpIcen AS ImpIcens, ;
                a.RGBS ;
            FROM crSigMvOrc a ;
            WHERE IIF(INLIST(loc_nDigItens, 6, 7), a.Visivels = 1, .T.) ;
            INTO CURSOR TmpImpOrc READWRITE ;
            ORDER BY a.Citens

            IF USED("TmpRelat")
                SELECT TmpRelat
                GO TOP
            ENDIF
            SELECT TmpImpOrc
            GO TOP

            *-- Calcula Finaliza (margem P&G) somente quando necessario
            IF THIS.this_nDivNotas = 2
                THIS.CalcularFinaliza()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Preview do relatorio (equivalente a 'visualizacao' do legado)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_cFRX, loc_nCnt
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cFRX = THIS.ObterNomeFRX()
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            ENDFOR
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o relatorio (equivalente a 'impressao' do legado)
    * TpImpressao 2 ou 4 = sem dialogo de impressora; outros = com PROMPT
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_cFRX, loc_nCnt, loc_lPrompt
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cFRX   = THIS.ObterNomeFRX()
            loc_lPrompt = !INLIST(THIS.this_nTpImpressao, 2, 4)
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF loc_lPrompt
                    REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
                ENDIF
            ENDFOR
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDocumento - Impressao direta sem prompt nem loop de Qbols
    * Equivalente ao procedimento 'documento' do legado
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDocumento()
        LOCAL loc_lResultado, loc_cFRX
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cFRX = THIS.ObterNomeFRX()
            REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor de origem
    * Para relatorios, mapeia parametros de operacao/empresa/casas decimais
    * a partir dos cursors abertos pelo form chamador (crSigCdOpe, crSigOpCdd,
    * cursor_4c_LocalEmp). Usado tambem pelo PrepararDados via
    * CarregarParametrosOperacao().
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o dispon" + ;
                    CHR(237) + "vel: " + TRANSFORM(par_cAliasCursor)
            ELSE
                SELECT (par_cAliasCursor)
                loc_cAlias = UPPER(ALLTRIM(par_cAliasCursor))
                DO CASE
                    CASE loc_cAlias == "CRSIGCDOPE"
                        THIS.this_nDigItens = NVL(DigItens, 0)
                        THIS.this_nNcPesos  = NVL(NCPesos,  0)
                        THIS.this_cMasP     = "999999" + ;
                            IIF(THIS.this_nNcPesos > 0, "." + REPL("9", THIS.this_nNcPesos), "")
                        loc_lResultado = .T.
                    CASE loc_cAlias == "CRSIGOPCDD"
                        THIS.this_nCasQtds = NVL(CasQtds, 0)
                        THIS.this_cMasQ    = "999999" + ;
                            IIF(THIS.this_nCasQtds > 0, "." + REPL("9", THIS.this_nCasQtds), "")
                        loc_lResultado = .T.
                    CASE loc_cAlias == "CURSOR_4C_LOCALEMP"
                        THIS.this_nDivNotas = NVL(DivNotas, 0)
                        loc_lResultado = .T.
                    OTHERWISE
                        THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o reconhecido: " + ;
                            ALLTRIM(par_cAliasCursor)
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - N" + CHR(227) + "o aplicavel a relatorio (sem persistencia)
    * RelatorioBase nao executa INSERT - operacao bloqueada com mensagem clara
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o INSERIR n" + ;
            CHR(227) + "o se aplica a relat" + CHR(243) + "rio de impress" + ;
            CHR(227) + "o de documento"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorio (sem persistencia)
    * RelatorioBase nao executa UPDATE - operacao bloqueada com mensagem clara
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o ATUALIZAR n" + ;
            CHR(227) + "o se aplica a relat" + CHR(243) + "rio de impress" + ;
            CHR(227) + "o de documento"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorio nao gera auditoria (operacao read-only)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

