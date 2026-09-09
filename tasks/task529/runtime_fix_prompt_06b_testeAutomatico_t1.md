# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARLISTA is not found. | Detalhes: Linha: 831, Proc: testecarregardadosreais; Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[08/09/2026 07:34:17 PM] Erro: Erro ao buscar tabelas de desconto:Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-08 19:32:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-08 19:32:38] [INFO] Config FPW: (nao fornecido)
[2026-09-08 19:32:38] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-08 19:32:38] [INFO] Timeout: 300 segundos
[2026-09-08 19:32:38] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d1viygji.prg
[2026-09-08 19:32:38] [INFO] Conteudo do wrapper:
[2026-09-08 19:32:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormTbd', 'C:\4c\tasks\task529', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormTbd', 'C:\4c\tasks\task529', 'OPERACIONAL'
QUIT

[2026-09-08 19:32:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d1viygji.prg
[2026-09-08 19:32:38] [INFO] VFP output esperado em: C:\4c\tasks\task529\vfp_output.txt
[2026-09-08 19:32:38] [INFO] Executando Visual FoxPro 9...
[2026-09-08 19:32:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d1viygji.prg
[2026-09-08 19:32:38] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d1viygji.prg
[2026-09-08 19:32:38] [INFO] Timeout configurado: 300 segundos
[2026-09-08 19:34:17] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-08 19:34:17] [INFO] VFP9 finalizado em 99.0254701 segundos
[2026-09-08 19:34:17] [INFO] Exit Code: 
[2026-09-08 19:34:17] [INFO] 
[2026-09-08 19:34:17] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-08 19:34:17] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d1viygji.prg
[2026-09-08 19:34:17] [INFO] 
[2026-09-08 19:34:17] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-08 19:34:17] [INFO] * Auto-generated wrapper for parameters
[2026-09-08 19:34:17] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-08 19:34:17] [INFO] * Parameters: 'FormTbd', 'C:\4c\tasks\task529', 'OPERACIONAL'
[2026-09-08 19:34:17] [INFO] 
[2026-09-08 19:34:17] [INFO] * Anti-dialog protections for unattended execution
[2026-09-08 19:34:17] [INFO] SET SAFETY OFF
[2026-09-08 19:34:17] [INFO] SET RESOURCE OFF
[2026-09-08 19:34:17] [INFO] SET TALK OFF
[2026-09-08 19:34:17] [INFO] SET NOTIFY OFF
[2026-09-08 19:34:17] [INFO] SYS(2335, 0)
[2026-09-08 19:34:17] [INFO] 
[2026-09-08 19:34:17] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormTbd', 'C:\4c\tasks\task529', 'OPERACIONAL'
[2026-09-08 19:34:17] [INFO] QUIT
[2026-09-08 19:34:17] [INFO] 
[2026-09-08 19:34:17] [INFO] === Fim do Wrapper.prg ===
[2026-09-08 19:34:17] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormTbd",
  "timestamp": "20260908193417",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Property CARREGARLISTA is not found.",
      "detalhes": "Linha: 831, Proc: testecarregardadosreais"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "2/2 paginas navegadas com sucesso"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick e PageFrame - navegacao Page2 nao aplicavel"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 2 (COLCODIGOSKEYPRESS, KEYPRESS)"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormTbd.prg):
*==============================================================================
* FormTbd.prg - Tabelas de Desconto por Operacao (sub-form modal / popup)
* Form OPERACIONAL - abre sobre o form pai (form de Operacoes)
* Chamada: CREATEOBJECT("FormTbd", oParentForm, cDopes)
* Herda de: FormBase
*
* Form OPERACIONAL (sub-form modal). Botoes do SCX original: Inserir, Excluir,
* Confirmar (grava tudo e fecha), Cancelar (fecha sem gravar). Edicao inline
* no grid (codigo da tabela de desconto com lookup F4 em SigOpTdz).
*
* Historico de fases:
*   Fase 1/2: TbdBO.prg (propriedades + CRUD + BuscarPorOperacao/SalvarPorOperacao)
*   Fase 3:   FormTbd.prg - estrutura base (heranca, Init, InicializarForm)
*   Fase 4:   Grid grd_4c_Dados (2 colunas), botoes Inserir/Excluir (cnt_4c_Botoes)
*   Fase 5:   Cabecalho Page2 espelhado, BeforeRowColChange/AfterRowColChange
*   Fase 6:   Lookup do codigo (KeyPress F4/Enter/Tab -> SigOpTdz, espelha
*             Column1.Text1.Valid), container cnt_4c_BotoesAcao (Confirmar/
*             Cancelar) e BtnConfirmarClick (duplicidade + SalvarPorOperacao +
*             fecha) / BtnCancelarClick (fecha sem gravar) - espelham
*             cmdSair.Click/Cancela.Click do legado
*==============================================================================
DEFINE CLASS FormTbd AS FormBase

    *-- Propriedades do SCX original (RESERVED3: gravadados / antvalue / parentform)
    GravaDados        = .F.      && .T. quando usuario alterou dados no grid
    AntValue          = .NULL.   && valor anterior capturado no When da Column1
    this_oParentForm  = .NULL.   && referencia ao form pai (Operacao) para reabilitar no Destroy
    this_cDopes       = ""       && codigo/descricao da operacao (dopes char 20 - FK SigCdOpe.dopes)

    *-- Propriedades locais (NAO persistem - apenas estado/UI)
    this_cDescOperacao = ""      && descricao da operacao exibida no cabecalho (= crSigCdOpe.Dopes)

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Controle de modo (padrao CRUD - usado por AlternarPagina em fases futuras)
    this_cModoAtual = "LISTA"   && LISTA / DADOS / INCLUIR / ALTERAR / VISUALIZAR

    *-- Guard anti-recursao no AfterRowColChange (redirect When behavior)
    this_lRedirigindo = .F.

    *-- Propriedades visuais (PILAR 1 - valores exatos do layout.json original)
    Width        = 800
    Height       = 400
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    Caption      = "Tabelas de Desconto"
    FontName     = "Tahoma"
    FontSize     = 8
    DataSession  = 2

    *--------------------------------------------------------------------------
    * Init - Recebe ref ao pai e codigo/descricao da operacao (Dopes)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cDopes)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_oParentForm = par_oParentForm
            THIS.this_cDopes      = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")

            THIS.this_oBusinessObject = CREATEOBJECT("TbdBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar TbdBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTbd.Init")
            ELSE
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .F.
                ENDIF
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura visual base do form
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- 1. PageFrame com Page1 (Lista) e Page2 (Dados)
            THIS.ConfigurarPageFrame()

            *-- 2. Containers vazios em cada Page (Fase 4+ populam grid/botoes)
            THIS.ConfigurarContainersBase()

            *-- 2.1 Grid + botoes Inserir/Excluir (Page1)
            THIS.ConfigurarPaginaLista()

            *-- 2.2 Cabecalho da Page2 (espelha visualmente o cabecalho da Page1)
            THIS.ConfigurarPaginaDados()

            *-- 2.3 Carrega tabelas de desconto ja vinculadas a operacao
            THIS.CarregarLista()

            *-- 3. Monta o Caption a partir da operacao e propaga para as Pages
            *--    (espelha o Init legado: .Caption = [Grupos de Produtos ] +
            *--    AllTrim(crSigCdOpe.Dopes) copiado para lblSombra/lblTitulo)
            THIS.BOParaForm()

            *-- 4. Ativa Page1 (Lista) como padrao
            THIS.pgf_4c_Paginas.Visible    = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual           = "LISTA"

            *-- 5. Torna toda a arvore visivel
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Tabs ocultas (Top=-29, Tabs=.F.) - navegacao via AlternarPagina()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .Top         = -29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = THIS.Height + 29
                .PageCount   = 2
                .Tabs        = .F.
                .BorderWidth = 0

                .Page1.Caption = "Lista"
                .Page2.Caption = "Dados"

                *-- Fundo das Pages (espelha SIGCDTBD.Picture do legado:
                *-- ..\framework\imagens\new_background.jpg)
                .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersBase - Cria containers vazios em cada Page
    * cnt_4c_Cabecalho + cnt_4c_Botoes em Page1 (fase 4 popula grid+Inserir/Excluir)
    * cnt_4c_BotoesAcao em Page2 (fase 6 popula Confirmar/Cancelar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersBase()
        LOCAL loc_oPag1, loc_oPag2, loc_oErro
        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            *-- Page1: cabecalho escuro (topo)
            loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag1.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            *-- Labels no cabecalho escuro (sombra + titulo) - fase 4 refina Caption
            loc_oPag1.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oPag1.cnt_4c_Cabecalho.lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width - 31
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            loc_oPag1.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oPag1.cnt_4c_Cabecalho.lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width - 31
                .ForeColor = RGB(255, 255, 255)
            ENDWITH

            *-- Page1: container de botoes de manutencao do grid (Inserir/Excluir)
            *-- Legado: cmdInserir Left=500, cmdExcluir Left=575 (form Width=800)
            loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPag1.cnt_4c_Botoes
                .Top         = 0 + 29
                .Left        = 495
                .Width       = 155
                .Height      = 85
                .BorderWidth = 0
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            *-- Page2: container de botoes de acao (populado em ConfigurarPaginaDados)
            *-- Legado: cmdSair(Confirmar) Left=650, Cancela Left=725 (form Width=800)
            loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPag2.cnt_4c_BotoesAcao
                .Top         = 4 + 29
                .Left        = 645
                .Width       = 155
                .Height      = 85
                .BorderWidth = 0
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.ConfigurarContainersBase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Grid de tabelas de desconto (espelha GradeOpe do
    * SCX original) + botoes Inserir/Excluir dentro de cnt_4c_Botoes (Page1).
    * Coluna 1 (codigos) editavel - lookup F4/Enter/Tab -> ColCodigosKeyPress.
    * Coluna 2 (descrs) somente leitura - no legado o Text1.When retorna .F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            *-- Grid principal (espelha SIGCDTBD.GradeOpe: Top=98,Left=236,W=313,H=274)
            loc_oPag.AddObject("grd_4c_Dados", "Grid")
            WITH loc_oPag.grd_4c_Dados
                .Top           = 98 + 29
                .Left          = 236
                .Width         = 313
                .Height        = 274
                .ColumnCount   = 2
                .ScrollBars    = 2
                .DeleteMark    = .F.
                .RecordMark    = .F.
                .GridLineColor = RGB(238, 238, 238)
                .ReadOnly      = .F.
                .Visible       = .T.

                .Column1.Width      = 80
                .Column1.Movable    = .F.
                .Column1.Resizable  = .F.
                .Column1.Header1.Caption   = "Tabela"
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Text1.FontName    = "Courier New"
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                .Column2.Width      = 200
                .Column2.Movable    = .F.
                .Column2.Resizable  = .F.
                .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Text1.FontName    = "Courier New"
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
                .Column2.Text1.ReadOnly    = .T.
            ENDWITH

            *-- Botoes de manutencao do grid (espelham cmdInserir/cmdExcluir)
            *-- AddObject SEMPRE fora de WITH aninhado (evita props ignoradas)
            loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Inserir
                .Top             = 5
                .Left            = 5
                .Width           = 70
                .Height          = 75
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
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

            loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir
                .Top             = 5
                .Left            = 80
                .Width           = 70
                .Height          = 75
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
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

            BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Inserir, "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

            *-- Lookup do codigo da tabela de desconto (espelha Column1.Text1.Valid
            *-- do legado: CreateObject('fwbuscaext', ..., 'SigOpTdz', ...)).
            *-- F4 abre a busca direto; ENTER/TAB validam o valor digitado.
            BINDEVENT(loc_oPag.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "ColCodigosKeyPress")

            *-- Espelha Column1.When (Thisform.AntValue = This.Value) e
            *-- Column2.When (Return .F. - bloqueia entrada na coluna Descricao,
            *-- somente leitura) via eventos de grid (colunas nao expoem When
            *-- fora de classes customizadas de Column).
            BINDEVENT(loc_oPag.grd_4c_Dados, "BeforeRowColChange", THIS, "GridBeforeRowColChange")
            BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cabecalho da Page2 (mesmo estilo/Caption da
    * Page1). No SCX original o form eh uma unica tela (grid + Inserir/Excluir/
    * Confirmar/Cancelar juntos); a migracao separa em Page1(Lista)/Page2(acao)
    * mas mantem o cabecalho espelhado nas duas paginas para consistencia
    * visual (PILAR 1). cnt_4c_BotoesAcao ja foi criado em
    * ConfigurarContainersBase (Fase 3) - populado com Confirmar/Cancelar
    * na Fase 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page2

            loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width - 31
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width - 31
                .ForeColor = RGB(255, 255, 255)
            ENDWITH

            *-- Botoes de acao (espelham cmdSair/Confirmar Left=650 e
            *-- Cancela/Cancelar Left=725 do legado - relativos ao container
            *-- cnt_4c_BotoesAcao com Left=645: 650-645=5, 725-645=80)
            loc_oPag.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
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

            loc_oPag.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
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

            BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GridBeforeRowColChange - Espelha Column1.When (Thisform.AntValue =
    * This.Value): captura o valor corrente do codigo ANTES da troca de
    * coluna/linha (usado como referencia de estado; a validacao/lookup do
    * codigo em si roda em ColCodigosKeyPress/ValidarCodigoTabela).
    *--------------------------------------------------------------------------
    PROCEDURE GridBeforeRowColChange(par_nColIndex)
        LOCAL loc_oGrid, loc_oErro
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            IF loc_oGrid.ActiveColumn = 1 AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                THIS.AntValue = cursor_4c_Dados.codigos
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.GridBeforeRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GridAfterRowColChange - Espelha Column2.When (Return .F.): a coluna
    * Descricao eh somente leitura (preenchida via lookup do codigo), entao
    * o legado bloqueava a entrada nela. Aqui redireciona o foco de volta
    * para a Column1 quando o usuario tenta navegar ate a Column2.
    * Guard this_lRedirigindo evita recursao via SetFocus/ActiveColumn.
    *--------------------------------------------------------------------------
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        LOCAL loc_oGrid, loc_oErro
        IF THIS.this_lRedirigindo
            RETURN
        ENDIF
        TRY
            IF par_nColIndex = 2
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                THIS.this_lRedirigindo = .T.
                loc_oGrid.ActiveColumn = 1
                IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
                    loc_oGrid.Column1.Text1.SetFocus
                ENDIF
                THIS.this_lRedirigindo = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.GridAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ColCodigosKeyPress - Handler de KeyPress da Column1.Text1 (codigo da
    * tabela de desconto). Espelha Column1.Text1.Valid do legado:
    *   - F4 (115): abre a busca (FormBuscaAuxiliar) direto
    *   - ENTER (13) / TAB (9): valida o valor digitado; se encontrar na
    *     SigOpTdz preenche a descricao, senao abre a busca (nunca deixa o
    *     campo com descricao desatualizada nem mostra aviso redundante -
    *     Pattern #114)
    *--------------------------------------------------------------------------
    PROCEDURE ColCodigosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        TRY
            IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
                THIS.AbrirLookupTabelaDesconto()
                NODEFAULT
            ELSE
                IF INLIST(par_nKeyCode, 13, 9)
                    THIS.ValidarCodigoTabela()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.ColCodigosKeyPress")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoTabela - Valida o codigo digitado na linha corrente do
    * grid contra SigOpTdz. Encontrado -> preenche descrs. Nao encontrado ->
    * abre a busca direto (sem MsgAviso redundante - Pattern #114).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCodigoTabela()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oGrid, loc_oErro
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cValor = ALLTRIM(cursor_4c_Dados.codigos)

                IF EMPTY(loc_cValor)
                    SELECT cursor_4c_Dados
                    REPLACE descrs WITH ""
                ELSE
                    IF USED("cursor_4c_ValTbd")
                        USE IN cursor_4c_ValTbd
                    ENDIF

                    loc_cSQL = "SELECT codigos, descrs FROM SigOpTdz" + ;
                               " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cValor)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValTbd")

                    IF loc_nResultado > 0 AND USED("cursor_4c_ValTbd") AND ;
                       RECCOUNT("cursor_4c_ValTbd") > 0
                        SELECT cursor_4c_Dados
                        REPLACE descrs WITH ALLTRIM(cursor_4c_ValTbd.descrs)
                        THIS.GravaDados = .T.

                        IF USED("cursor_4c_ValTbd")
                            USE IN cursor_4c_ValTbd
                        ENDIF

                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                        loc_oGrid.Refresh
                    ELSE
                        IF USED("cursor_4c_ValTbd")
                            USE IN cursor_4c_ValTbd
                        ENDIF
                        THIS.AbrirLookupTabelaDesconto()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.ValidarCodigoTabela")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTabelaDesconto - Abre FormBuscaAuxiliar sobre SigOpTdz
    * (codigos/descrs). Espelha CreateObject('fwbuscaext', ..., 'SigOpTdz',
    * 'CrListaRemota', 'Codigos', This.Value, 'Tabelas de Desconto', .t.) do
    * legado. Pattern A manual (Erro114): SQL no caller com LIKE 'valor%' +
    * fallback SHOW-ALL + FormBuscaAuxiliar sem parametros + DefinirCursor +
    * Mostrar().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupTabelaDesconto()
        LOCAL loc_oGrid, loc_cValor, loc_cSQL, loc_nResultado, loc_oBusca, loc_oErro
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cValor = ALLTRIM(cursor_4c_Dados.codigos)

                IF USED("cursor_4c_LkpTbd")
                    USE IN cursor_4c_LkpTbd
                ENDIF

                IF !EMPTY(loc_cValor)
                    loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs FROM SigOpTdz" + ;
                               " WHERE codigos LIKE " + EscaparSQL(loc_cValor + "%") + ;
                               " ORDER BY codigos"
                ELSE
                    loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs FROM SigOpTdz" + ;
                               " ORDER BY codigos"
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTbd")

                *-- Fallback SHOW-ALL: prefixo nao bateu, lista tudo
                IF loc_nResultado > 0 AND USED("cursor_4c_LkpTbd") AND ;
                   RECCOUNT("cursor_4c_LkpTbd") = 0 AND !EMPTY(loc_cValor)
                    USE IN cursor_4c_LkpTbd
                    loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs FROM SigOpTdz" + ;
                               " ORDER BY codigos"
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTbd")
                ENDIF

                IF loc_nResultado > 0 AND USED("cursor_4c_LkpTbd") AND ;
                   RECCOUNT("cursor_4c_LkpTbd") > 0

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.DefinirCursor("cursor_4c_LkpTbd", "Cods", "Descs", ;
                            "Tabelas de Desconto")

                        IF loc_oBusca.Mostrar()
                            SELECT cursor_4c_Dados
                            REPLACE codigos WITH LEFT(ALLTRIM(loc_oBusca.cCodigoSelecionado), 10), ;
                                    descrs  WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                            THIS.GravaDados = .T.

                            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                            loc_oGrid.Refresh
                        ENDIF
                    ENDIF
                ELSE
                    MsgAviso("Nenhuma tabela de desconto encontrada" + ;
                        IIF(!EMPTY(loc_cValor), " para [" + loc_cValor + "]", "") + ".", ;
                        "Tabelas de Desconto")
                ENDIF

                IF USED("cursor_4c_LkpTbd")
                    USE IN cursor_4c_LkpTbd
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.AbrirLookupTabelaDesconto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca as tabelas de desconto ja vinculadas a operacao
    * corrente (THIS.this_cDopes) e vincula cursor_4c_Dados ao grid.
    * RecordSource reseta Column.Width/Header1.Caption (Problema 48) - por
    * isso a reconfiguracao acontece SEMPRE apos o ControlSource.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarLista()
        LOCAL loc_oGrid, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               THIS.this_oBusinessObject.BuscarPorOperacao(THIS.this_cDopes)

                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                loc_oGrid.RecordSource = ""
                loc_oGrid.ColumnCount  = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"

                *-- Reconfigura Width/Header1.Caption (perdidos ao resetar RecordSource)
                loc_oGrid.Column1.Width           = 80
                loc_oGrid.Column1.Header1.Caption = "Tabela"
                loc_oGrid.Column2.Width           = 200
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Text1.ReadOnly  = .T.

                loc_oGrid.Refresh

                THIS.GravaDados = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * HabilitarEdicaoGrid - Liga/desliga a edicao inline do codigo no grid.
    * Column2 (Descricao) permanece SEMPRE somente-leitura (espelha
    * Column2.When = Return .F. do legado). Os botoes NAO sao desabilitados:
    * Enabled = .F. em CommandButton com Picture apaga o icone - o bloqueio do
    * modo VISUALIZAR eh feito por guard dentro de cada handler.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarEdicaoGrid(par_lHabilitar)
        LOCAL loc_lEdita, loc_oErro
        loc_lEdita = (VARTYPE(par_lHabilitar) != "L" OR par_lHabilitar)
        TRY
            WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                .ReadOnly               = !loc_lEdita
                .Column1.ReadOnly       = !loc_lEdita
                .Column1.Text1.ReadOnly = !loc_lEdita
                .Column2.ReadOnly       = .T.
                .Column2.Text1.ReadOnly = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.HabilitarEdicaoGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Adiciona linha em branco no cursor_4c_Dados e coloca
    * o foco na coluna do codigo para digitacao. Espelha cmdInserir.Click do
    * legado: Insert Into xOpe (codigos) Values (Space(10)) / GravaDados = .t.
    * / GradeOpe.Column1.SetFocus. Handler ligado ao botao Inserir da Page1.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
                    CHR(225) + " carregada.", "Aviso")
            ELSE
                *-- Sai do modo somente-leitura (caso venha de VISUALIZAR)
                THIS.HabilitarEdicaoGrid(.T.)
                THIS.this_cModoAtual = "INCLUIR"

                INSERT INTO cursor_4c_Dados (codigos) VALUES (SPACE(10))

                THIS.GravaDados = .T.
                THIS.AntValue   = SPACE(10)

                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.Refresh
                loc_oGrid.SetFocus
                loc_oGrid.ActiveColumn = 1
                IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
                    loc_oGrid.Column1.Text1.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Coloca a linha selecionada do grid em edicao. O legado
    * altera inline (nao ha botao dedicado): a troca do codigo acontece ao
    * digitar sobre a Column1 da linha corrente. Guarda o valor anterior em
    * AntValue (espelha Column1.When: Thisform.AntValue = This.Value) e devolve
    * o foco a coluna do codigo, de onde F4/ENTER/TAB acionam o lookup SigOpTdz.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
                    CHR(225) + " carregada.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                IF RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
                    MsgAviso("Selecione uma tabela de desconto na lista.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.HabilitarEdicaoGrid(.T.)
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.AntValue        = cursor_4c_Dados.codigos

                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                    loc_oGrid.Refresh
                    loc_oGrid.SetFocus
                    loc_oGrid.ActiveColumn = 1
                    IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
                        loc_oGrid.Column1.Text1.SetFocus
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Consulta somente-leitura da tabela de desconto
    * selecionada: bloqueia a edicao inline do grid e le o cadastro em
    * SigOpTdz (mesma origem do lookup Column1.Text1.Valid do legado),
    * exibindo Operacao/Codigo/Descricao do registro. Se o codigo da linha nao
    * estiver cadastrado em SigOpTdz, avisa (dado orfao no vinculo).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oGrid, loc_oErro
        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
                    CHR(225) + " carregada.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                IF RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
                    MsgAviso("Selecione uma tabela de desconto na lista.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarEdicaoGrid(.F.)

                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                    loc_oGrid.Refresh

                    loc_cValor = ALLTRIM(cursor_4c_Dados.codigos)

                    IF EMPTY(loc_cValor)
                        MsgAviso("Linha sem c" + CHR(243) + "digo de tabela informado.", ;
                            "Tabelas de Desconto")
                    ELSE
                        IF USED("cursor_4c_VisTbd")
                            USE IN cursor_4c_VisTbd
                        ENDIF

                        loc_cSQL = "SELECT codigos, descrs FROM SigOpTdz" + ;
                                   " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cValor)

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisTbd")

                        IF loc_nResultado > 0 AND USED("cursor_4c_VisTbd") AND ;
                           RECCOUNT("cursor_4c_VisTbd") > 0

                            MsgInfo("Opera" + CHR(231) + CHR(227) + "o: " + ;
                                ALLTRIM(THIS.this_cDopes) + CHR(13) + ;
                                "C" + CHR(243) + "digo: " + ;
                                ALLTRIM(NVL(cursor_4c_VisTbd.codigos, "")) + CHR(13) + ;
                                "Descri" + CHR(231) + CHR(227) + "o: " + ;
                                ALLTRIM(NVL(cursor_4c_VisTbd.descrs, "")), ;
                                "Tabela de Desconto")

                            USE IN cursor_4c_VisTbd
                        ELSE
                            IF USED("cursor_4c_VisTbd")
                                USE IN cursor_4c_VisTbd
                            ENDIF

                            MsgAviso("Tabela de desconto [" + loc_cValor + "] n" + ;
                                CHR(227) + "o cadastrada em SigOpTdz.", ;
                                "Tabelas de Desconto")
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Dados
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Remove a linha corrente do cursor_4c_Dados. Espelha
    * cmdExcluir.Click do legado (Delete / Skip / Go Bott se Eof / GravaDados
    * = .t.) - sem confirmacao, igual ao original. Bloqueado em VISUALIZAR.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
                    CHR(225) + " carregada.", "Aviso")
            ELSE
                IF THIS.this_cModoAtual = "VISUALIZAR"
                    MsgAviso("Lista em modo de visualiza" + CHR(231) + CHR(227) + "o." + ;
                        CHR(13) + "Clique em Inserir ou volte a alterar a linha " + ;
                        "antes de excluir.", "Tabelas de Desconto")
                ELSE
                    SELECT cursor_4c_Dados
                    IF !EOF()
                        DELETE
                        SKIP
                        IF EOF()
                            GO BOTTOM
                        ENDIF
                    ENDIF

                    THIS.GravaDados = .T.

                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                    loc_oGrid.Refresh
                    loc_oGrid.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Grava as tabelas de desconto da operacao e fecha o
    * form (espelha cmdSair.Click). Se GravaDados = .F. (nada foi alterado),
    * apenas reabilita o form pai e fecha, sem tocar o banco. Se houver
    * codigos duplicados no grid, aborta com MsgErro e mantem o form aberto
    * (unico caso de "Return .f." no legado). Uma falha na gravacao em si
    * (SalvarPorOperacao) apenas exibe o erro mas NAO impede o fechamento -
    * no legado o "MessageBox('Erro na Gravacao...')" nao tem Return .f.
    * apos ele, o fluxo cai direto em ParentForm.Enabled=.T./Release. Usa
    * TbdBO.VerificarDuplicidade + SalvarPorOperacao (DELETE + INSERT por
    * operacao, ja implementados na Fase 1/2).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lPodeFechar, loc_oErro
        loc_lPodeFechar = .T.
        TRY
            *-- Toda a gravacao (FormParaBO + duplicidade + SalvarPorOperacao)
            *-- esta em BtnSalvarClick; aqui so decidimos se o form fecha.
            loc_lPodeFechar = THIS.BtnSalvarClick()
        CATCH TO loc_oErro
            loc_lPodeFechar = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnConfirmarClick")
        ENDTRY

        IF loc_lPodeFechar
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o form sem gravar (espelha Cancela.Click)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere o estado do form para as propriedades do TbdBO.
    * Neste form OPERACIONAL a edicao acontece inline no grid (nao ha pagina
    * de campos), entao o "estado do form" eh: a operacao corrente (Dopes,
    * recebida no Init) mais a linha selecionada do cursor_4c_Dados. Espelha
    * o cmdSair.Click do legado, que monta o registro a partir de
    * crSigCdOpe.Dopes + xOpe.codigos antes de gravar.
    * Retorna .F. (com aviso) quando o form nao tem operacao definida - sem
    * Dopes o DELETE/INSERT por operacao apagaria a faixa errada.
    *--------------------------------------------------------------------------
    FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgAviso("Business Object n" + CHR(227) + "o inicializado.", ;
                    "Tabelas de Desconto")
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cDopes))
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                        "o informada." + CHR(13) + "Selecione a opera" + CHR(231) + ;
                        CHR(227) + "o antes de gravar as tabelas de desconto.", ;
                        "Tabelas de Desconto")
                ELSE
                    THIS.this_oBusinessObject.this_cDopes = ;
                        LEFT(ALLTRIM(THIS.this_cDopes), 20)
                    THIS.this_oBusinessObject.this_cDescOperacao = ;
                        ALLTRIM(THIS.this_cDescOperacao)

                    *-- Linha corrente do grid (pode nao existir em lista vazia)
                    IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                        THIS.this_oBusinessObject.this_cCodigos = ;
                            LEFT(ALLTRIM(NVL(cursor_4c_Dados.codigos, "")), 10)

                        IF TYPE("cursor_4c_Dados.cidchaves") != "U"
                            THIS.this_oBusinessObject.this_cCidChaves = ;
                                LEFT(ALLTRIM(NVL(cursor_4c_Dados.cidchaves, "")), 20)
                        ELSE
                            THIS.this_oBusinessObject.this_cCidChaves = ""
                        ENDIF
                    ELSE
                        THIS.this_oBusinessObject.this_cCodigos   = ""
                        THIS.this_oBusinessObject.this_cCidChaves = ""
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.FormParaBO")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere as propriedades do TbdBO de volta para o form.
    * Reproduz o trecho do Init legado que monta o titulo a partir da operacao
    *     .Caption = [Grupos de Produtos ] + AllTrim(crSigCdOpe.Dopes)
    *     cntSombra.lblSombra.Caption = ThisForm.Caption
    *     cntSombra.lblTitulo.Caption = ThisForm.Caption
    * e, quando o BO carrega um registro (CarregarPorCodigo/CarregarDoCursor),
    * devolve codigos/descrs para a linha corrente do grid. A descricao eh
    * relida de SigOpTdz - a mesma origem do lookup - porem SEM abrir o
    * FormBuscaAuxiliar quando o codigo nao existe (transferencia de dados
    * nao deve disparar dialogo; quem faz isso eh ValidarCodigoTabela).
    *--------------------------------------------------------------------------
    FUNCTION BOParaForm()
        LOCAL loc_lSucesso, loc_cCaption, loc_cCodigo, loc_cSQL
        LOCAL loc_nResultado, loc_cDescricao, loc_oGrid, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgAviso("Business Object n" + CHR(227) + "o inicializado.", ;
                    "Tabelas de Desconto")
            ELSE
                *-- 1. Operacao: BO eh a fonte quando ja carregou um registro
                IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDopes))
                    THIS.this_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDescOperacao))
                    THIS.this_cDescOperacao = ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cDescOperacao)
                ENDIF

                *-- 2. Titulo (string exata do legado) propagado para as 2 Pages
                loc_cCaption = "Grupos de Produtos " + ALLTRIM(THIS.this_cDopes)
                THIS.Caption = loc_cCaption
                THIS.AtualizarTitulo(loc_cCaption)

                *-- 3. Linha corrente do grid a partir do registro do BO
                loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)

                IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados") AND ;
                   !EOF("cursor_4c_Dados")

                    loc_cDescricao = ""

                    IF USED("cursor_4c_BoTbd")
                        USE IN cursor_4c_BoTbd
                    ENDIF

                    loc_cSQL = "SELECT codigos, descrs FROM SigOpTdz" + ;
                               " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cCodigo)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BoTbd")

                    IF loc_nResultado > 0 AND USED("cursor_4c_BoTbd") AND ;
                       RECCOUNT("cursor_4c_BoTbd") > 0
                        loc_cDescricao = ALLTRIM(NVL(cursor_4c_BoTbd.descrs, ""))
                    ENDIF

                    IF USED("cursor_4c_BoTbd")
                        USE IN cursor_4c_BoTbd
                    ENDIF

                    SELECT cursor_4c_Dados
                    REPLACE codigos WITH LEFT(loc_cCodigo, 10), ;
                            descrs  WITH loc_cDescricao

                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                    loc_oGrid.Refresh
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.BOParaForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarTitulo - Propaga o caption para os cabecalhos das duas Pages
    * (Page1/Lista e Page2/Dados). Espelha as duas linhas do Init legado que
    * copiam ThisForm.Caption para cntSombra.lblSombra e cntSombra.lblTitulo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTitulo(par_cCaption)
        LOCAL loc_nPag, loc_oPag, loc_oErro
        TRY
            FOR loc_nPag = 1 TO THIS.pgf_4c_Paginas.PageCount
                loc_oPag = THIS.pgf_4c_Paginas.Pages(loc_nPag)

                IF PEMSTATUS(loc_oPag, "cnt_4c_Cabecalho", 5)
                    IF PEMSTATUS(loc_oPag.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
                        loc_oPag.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = par_cCaption
                    ENDIF
                    IF PEMSTATUS(loc_oPag.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
                        loc_oPag.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = par_cCaption
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.AtualizarTitulo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Grava as tabelas de desconto da operacao SEM fechar o
    * form. Concentra a logica de gravacao do cmdSair.Click legado:
    *   If ThisForm.GravaDados
    *       <checa duplicidade> -> Return .f.
    *       Zap crSigCdTbd / Scan xOpe -> Insert / Delete From SigCdTbd / Update
    *       If erro -> MessageBox (sem Return .f.)
    *   EndIf
    * Retorno: .T. = fluxo pode prosseguir (nada a gravar, ou gravacao
    * tentada); .F. = duplicidade detectada, o usuario precisa corrigir o
    * grid. Esse retorno eh o que BtnConfirmarClick usa para decidir se fecha
    * o form - no legado somente a duplicidade tem "Return .f.": um erro de
    * gravacao exibe a mensagem mas o form fecha assim mesmo.
    *--------------------------------------------------------------------------
    FUNCTION BtnSalvarClick()
        LOCAL loc_lProsseguir, loc_oErro
        loc_lProsseguir = .T.
        TRY
            IF THIS.GravaDados
                IF !THIS.FormParaBO()
                    *-- Sem operacao definida: FormParaBO ja avisou o usuario
                    loc_lProsseguir = .F.
                ELSE
                    IF THIS.this_oBusinessObject.VerificarDuplicidade("cursor_4c_Dados")
                        MsgErro("Existem lan" + CHR(231) + "amentos de Tabelas de " + ;
                            "Desconto em duplicidade!!!", "Duplicidade")
                        loc_lProsseguir = .F.
                    ELSE
                        IF THIS.this_oBusinessObject.SalvarPorOperacao( ;
                                THIS.this_cDopes, "cursor_4c_Dados")
                            THIS.GravaDados = .F.
                        ELSE
                            *-- Legado NAO interrompe o fluxo nesse caso (nao ha
                            *-- Return .f. apos o MessageBox de erro de gravacao)
                            MsgErro("Erro na grava" + CHR(231) + CHR(227) + ;
                                "o dos dados!!!" + CHR(13) + ;
                                THIS.this_oBusinessObject.ObterMensagemErro(), "Erro")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lProsseguir = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnSalvarClick")
        ENDTRY
        RETURN loc_lProsseguir
    ENDFUNC

    *--------------------------------------------------------------------------
    * AlternarPagina - Troca a pagina ativa do pgf_4c_Paginas (1=Lista/2=Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) = "N" AND INLIST(par_nPagina, 1, 2)
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (percorre Pages de PageFrames alem de Controls de Containers)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_nP, loc_oControl, loc_oErro
        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                        FOR loc_nP = 1 TO loc_oControl.PageCount
                            THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                        ENDFOR
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormTbd.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reabilita form pai e libera cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\TbdBO.prg):
*====================================================================
* TbdBO.prg
*
* Business Object para Tabelas de Desconto por Operacao
* Tabela principal: SigCdTbd (cidchaves PK)
* Tabela pai: SigCdOpe (dopes) - Operacao a qual as tabelas pertencem
* Tabela de referencia (lookup): SigOpTdz (codigos) - Tabela de Desconto
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TbdBO AS BusinessBase

	*-- Propriedades da entidade (SigCdTbd)
	this_cCodigos     = ""   && codigos char(10)   - codigo da tabela de desconto (FK SigOpTdz.codigos)
	this_cCidChaves   = ""   && cidchaves char(20) - PK (chave unica Fortyus)
	this_cDopes       = ""   && dopes char(20)     - codigo/descricao da operacao (FK SigCdOpe.dopes)

	*-- Propriedades locais (NAO persistem - apenas estado/UI)
	this_cDescOperacao = ""  && descricao da operacao exibida no cabecalho (= crSigCdOpe.Dopes)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdTbd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCodigos   = TratarNulo(codigos, "C")
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cDopes     = TratarNulo(dopes, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, dopes" + ;
			           " FROM SigCdTbd" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cCidChaves)
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
			           " VALUES (" + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           EscaparSQL(THIS.this_cCidChaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdTbd SET" + ;
			           " codigos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           " dopes = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarPorOperacao - Carrega TODAS as tabelas de desconto vinculadas
	* a uma operacao (Dopes), com a descricao da tabela (SigOpTdz.descrs).
	* Espelha o SELECT original do Init() legado:
	*   Select a.*, b.descrs From SigCdTbd a, SigOpTdz b
	*   Where a.Dopes = <dopes> And a.codigos = b.codigos
	* cursor_4c_Dados eh convertido para READWRITE (SQLEXEC gera cursor
	* somente-leitura) pois o grid permite Inserir/Excluir/editar linhas
	* localmente antes de Confirmar (SalvarPorOperacao).
	*====================================================================
	PROCEDURE BuscarPorOperacao(par_cDopes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cSQL = "SELECT a.codigos AS codigos, a.cidchaves AS cidchaves," + ;
			           " a.dopes AS dopes, b.descrs AS descrs" + ;
			           " FROM SigCdTbd a INNER JOIN SigOpTdz b ON a.codigos = b.codigos" + ;
			           " WHERE RTRIM(a.dopes) = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
			           " ORDER BY a.codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResultado >= 0
				SELECT codigos, cidchaves, dopes, descrs ;
					FROM cursor_4c_DadosTmp ;
					INTO CURSOR cursor_4c_Dados READWRITE

				IF USED("cursor_4c_DadosTmp")
					USE IN cursor_4c_DadosTmp
				ENDIF

				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_DadosTmp")
				USE IN cursor_4c_DadosTmp
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SalvarPorOperacao - Grava a lista completa de tabelas de desconto
	* de uma operacao (Dopes), substituindo os registros existentes.
	* Espelha o cmdSair.Click original: Delete From SigCdTbd Where dopes = ?
	* seguido de Insert Into SigCdTbd para cada linha nao vazia do grid.
	* par_cAliasCursor: cursor com as linhas do grid (coluna codigos).
	*====================================================================
	PROCEDURE SalvarPorOperacao(par_cDopes, par_cAliasCursor)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves

		loc_lSucesso = .F.

		IF !USED(par_cAliasCursor)
			THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + "o localizado"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(dopes) = " + ;
			           EscaparSQL(ALLTRIM(par_cDopes))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado < 0
				MsgErro("Erro ao excluir tabelas de desconto anteriores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.

				SELECT (par_cAliasCursor)
				SCAN WHILE loc_lSucesso
					IF !EMPTY(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")))
						loc_cCidChaves = LEFT(fUniqueIds(), 20)

						loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
						           " VALUES (" + ;
						           EscaparSQL(LEFT(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")), 10)) + "," + ;
						           EscaparSQL(loc_cCidChaves) + "," + ;
						           EscaparSQL(LEFT(ALLTRIM(par_cDopes), 20)) + ;
						           ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

						IF loc_nResultado < 0
							MsgErro("Erro ao gravar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ELSE
							THIS.this_cCidChaves = loc_cCidChaves
							THIS.this_cCodigos   = ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos"))
							THIS.this_cDopes     = ALLTRIM(par_cDopes)
							THIS.RegistrarAuditoria("INSERT")
						ENDIF
					ENDIF
				ENDSCAN

				SELECT (par_cAliasCursor)
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gravar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Verifica se ha codigos de tabela duplicados
	* no cursor do grid (espelha a checagem do cmdSair.Click original):
	*   Select Codigos, Sum(1) as Qt From xOpe Group by 1
	*   Into Cursor Selecao where codigos <> ' ' having Sum(1) > 1
	*====================================================================
	FUNCTION VerificarDuplicidade(par_cAliasCursor)
		LOCAL loc_lDuplicado

		loc_lDuplicado = .F.

		IF !USED(par_cAliasCursor)
			RETURN .F.
		ENDIF

		IF USED("cursor_4c_Duplicados")
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT codigos, COUNT(*) AS Qt FROM (par_cAliasCursor) ;
			WHERE ALLTRIM(codigos) <> "" ;
			GROUP BY codigos ;
			HAVING COUNT(*) > 1 ;
			INTO CURSOR cursor_4c_Duplicados

		IF USED("cursor_4c_Duplicados")
			IF RECCOUNT("cursor_4c_Duplicados") > 0
				loc_lDuplicado = .T.
			ENDIF
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT (par_cAliasCursor)

		RETURN loc_lDuplicado
	ENDFUNC

ENDDEFINE

