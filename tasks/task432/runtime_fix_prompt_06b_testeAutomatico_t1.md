# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 56% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542; Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[06/08/2026 07:07:49 AM] Permissão: Operação não permitida.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-06 07:06:49] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 07:06:49] [INFO] Config FPW: (nao fornecido)
[2026-08-06 07:06:49] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 07:06:49] [INFO] Timeout: 300 segundos
[2026-08-06 07:06:49] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_do2gfiyx.prg
[2026-08-06 07:06:49] [INFO] Conteudo do wrapper:
[2026-08-06 07:06:49] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFte', 'C:\4c\tasks\task432', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFte', 'C:\4c\tasks\task432', 'CRUD'
QUIT

[2026-08-06 07:06:49] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_do2gfiyx.prg
[2026-08-06 07:06:49] [INFO] VFP output esperado em: C:\4c\tasks\task432\vfp_output.txt
[2026-08-06 07:06:49] [INFO] Executando Visual FoxPro 9...
[2026-08-06 07:06:49] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_do2gfiyx.prg
[2026-08-06 07:06:49] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_do2gfiyx.prg
[2026-08-06 07:06:49] [INFO] Timeout configurado: 300 segundos
[2026-08-06 07:07:49] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 07:07:49] [INFO] VFP9 finalizado em 60.1439598 segundos
[2026-08-06 07:07:49] [INFO] Exit Code: 
[2026-08-06 07:07:49] [INFO] 
[2026-08-06 07:07:49] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 07:07:49] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_do2gfiyx.prg
[2026-08-06 07:07:49] [INFO] 
[2026-08-06 07:07:49] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 07:07:49] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 07:07:49] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 07:07:49] [INFO] * Parameters: 'FormFte', 'C:\4c\tasks\task432', 'CRUD'
[2026-08-06 07:07:49] [INFO] 
[2026-08-06 07:07:49] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 07:07:49] [INFO] SET SAFETY OFF
[2026-08-06 07:07:49] [INFO] SET RESOURCE OFF
[2026-08-06 07:07:49] [INFO] SET TALK OFF
[2026-08-06 07:07:49] [INFO] SET NOTIFY OFF
[2026-08-06 07:07:49] [INFO] SYS(2335, 0)
[2026-08-06 07:07:49] [INFO] 
[2026-08-06 07:07:49] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFte', 'C:\4c\tasks\task432', 'CRUD'
[2026-08-06 07:07:49] [INFO] QUIT
[2026-08-06 07:07:49] [INFO] 
[2026-08-06 07:07:49] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 07:07:49] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFte",
  "timestamp": "20260806070749",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": false,
      "erro": "Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)",
      "detalhes": ""
    },
    {
      "nome": "ModoIncluir",
      "passou": false,
      "erro": "Property ALTERNARPAGINA is not found.",
      "detalhes": "Linha: 412"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 542"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": false,
      "erro": "BtnIncluirClick nao navegou para Page2 (ActivePage=1)",
      "detalhes": ""
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
    "passou": 5,
    "falhou": 4,
    "percentual": 56
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFte.prg):
*==============================================================================
* FormFte.prg - Formulario de Fichas Tecnicas
* Tabela: SigCdFtr
* Herda de: FormBase
* Tipo: CRUD (frmcadastro)
* Migrado de: SigCdFte.SCX (SIGCDFTE)
*
* Particularidades:
*   - Abre com parametros: par_cGrupos, par_cSubGrp, par_cCargos, par_cTitulos,
*                          par_cEscolha, par_nTipo
*   - Contexto fixo: fichas tecnicas de um Cargo/Titulo especifico
*   - Caption dinamico baseado no contexto: "Ficha Tecnica - Cargo - Titulo"
*   - Permissoes: pEsc INSERIR|ALTERAR -> editar; CONSULTAR|EXCLUIR -> leitura
*==============================================================================

DEFINE CLASS FormFte AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Fichas Tecnicas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(100, 100, 100)
    DataSession = 2

    *-- Business Object e estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *-- Contexto de abertura (definidos em Init antes do DODEFAULT)
    this_cContextGrupos  = ""
    this_cContextSubGrp  = ""
    this_cContextCargos  = ""
    this_cContextTitulos = ""
    this_cEscolha        = ""
    this_nTipo           = 0
    this_lPermiteEditar  = .F.

    *==========================================================================
    * Init - Recebe parametros de contexto, salva nas propriedades e delega
    *        para FormBase (que por sua vez chama InicializarForm)
    *
    * par_cGrupos  = codigo do grupo (PADR 3 se pTipo=0, 20 caso contrario)
    * par_cSubGrp  = sub-grupo (PADR 6)
    * par_cCargos  = codigo do cargo (PADR 20)
    * par_cTitulos = codigo do titulo (PADR 20)
    * par_cEscolha = "INSERIR"|"ALTERAR"|"CONSULTAR"|"EXCLUIR"
    * par_nTipo    = 0 -> grupos de 3 chars; outro -> grupos de 20 chars
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_cGrupos, par_cSubGrp, par_cCargos, par_cTitulos, par_cEscolha, par_nTipo
        LOCAL loc_lSucesso, loc_nLargGrupos
        loc_lSucesso = .F.

        TRY
            *-- Determinar largura do campo Grupos
            loc_nLargGrupos = IIF(VARTYPE(par_nTipo) = "N" AND par_nTipo = 0, 3, 20)

            *-- Salvar contexto ANTES do DODEFAULT para que InicializarForm() acesse
            THIS.this_cContextGrupos  = PADR(IIF(VARTYPE(par_cGrupos)  = "C", par_cGrupos,  ""), loc_nLargGrupos)
            THIS.this_cContextSubGrp  = PADR(IIF(VARTYPE(par_cSubGrp)  = "C", par_cSubGrp,  ""), 6)
            THIS.this_cContextCargos  = PADR(IIF(VARTYPE(par_cCargos)  = "C", par_cCargos,  ""), 20)
            THIS.this_cContextTitulos = PADR(IIF(VARTYPE(par_cTitulos) = "C", par_cTitulos, ""), 20)
            THIS.this_cEscolha        = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")
            THIS.this_nTipo           = IIF(VARTYPE(par_nTipo) = "N", par_nTipo, 0)

            *-- Permissao de edicao: apenas INSERIR ou ALTERAR habilitam operacoes
            THIS.this_lPermiteEditar = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")

            *-- DODEFAULT() chama FormBase.Init() que chama InicializarForm()
            loc_lSucesso = DODEFAULT()

        CATCH TO loException
            MsgErro("Erro em FormFte.Init:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria a estrutura do formulario
    * Chamado automaticamente por FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("FteBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar FteBO" + CHR(13) + "VARTYPE: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                *-- Propagar contexto para o BO antes de qualquer operacao
                THIS.this_oBusinessObject.this_cContextGrupos  = THIS.this_cContextGrupos
                THIS.this_oBusinessObject.this_cContextSubGrp  = THIS.this_cContextSubGrp
                THIS.this_oBusinessObject.this_cContextCargos  = THIS.this_cContextCargos
                THIS.this_oBusinessObject.this_cContextTitulos = THIS.this_cContextTitulos

                *-- Caption dinamico: "Ficha Tecnica - Cargo - Titulo"
                THIS.Caption = "Ficha T" + CHR(233) + "cnica - " + ;
                               ALLTRIM(THIS.this_cContextCargos) + " - " + ;
                               ALLTRIM(THIS.this_cContextTitulos)

                *-- Montar estrutura visual base
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar caption nos labels de titulo (sombra/titulo em ambas paginas)
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption  = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption  = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_sombra2.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_titulo2.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                THIS.AjustarBotoesPorModo()
                THIS.CarregarLista()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormFte.InicializarForm:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas e containers base
    *
    * Compensacao PageFrame.Top = -29:
    *   Todos os controles dentro das Pages compensam +29 no Top.
    *   cntSombra (original Top=2) -> Top = 31
    *   grupo_op  (original Top=-1) -> Top = 28 -> canonico: 29
    *   grupo_salva (original Top=4) -> Top = 33
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 631    && VFP9 adiciona +4 em runtime -> total 635
            .Tabs      = .F.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * PAGE 1 - Container sombra/titulo (cntSombra Top=2 + comp29 = 31)
        *----------------------------------------------------------------------
        THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 12
            .Width     = 980
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 980
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD - Page1
        *-- Canonico: Left=542 (escalonado de grupo_op.Left=344 na form 800->1000px)
        THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 380
            .Height      = 88
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container botao Encerrar - Page1 (canonico: Left=917, Width=90)
        THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * PAGE 2 - Container sombra/titulo (compensacao Top = 2 + 29 = 31)
        *----------------------------------------------------------------------
        THIS.pgf_4c_Paginas.Page2.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.AddObject("lbl_4c_sombra2", "Label")
        WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_sombra2
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 12
            .Width     = 980
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.AddObject("lbl_4c_titulo2", "Label")
        WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_titulo2
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 980
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes Salvar/Cancelar - Page2
        *-- grupo_salva: Top=4 + comp29 = 33, Left=842 (canonico)
        THIS.pgf_4c_Paginas.Page2.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Adiciona botoes CRUD e Grid em Page1
    * Os containers cnt_4c_Botoes e cnt_4c_Saida foram criados em
    * ConfigurarPageFrame(). Aqui populamos os botoes e criamos o Grid.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCnt, loc_oCntSaida

        loc_oPg1      = THIS.pgf_4c_Paginas.Page1
        loc_oCnt      = loc_oPg1.cnt_4c_Botoes
        loc_oCntSaida = loc_oPg1.cnt_4c_Saida

        *----------------------------------------------------------------------
        * Botoes CRUD - Left=5/80/155/230/305, Top=5, 75x75
        * Ordem original: inserir, consultar, alterar, excluir, procurar
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * Botao Encerrar (padrao canonico: cnt_4c_Saida.Left=917, Width=90)
        *----------------------------------------------------------------------
        loc_oCntSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oCntSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCntSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Grid de listagem - grd_4c_Lista
        * FontName=Tahoma, FontSize=8, RowHeight=16, ForeColor=90,90,90
        * Top = cnt_4c_Sombra.Top(31) + cnt_4c_Sombra.Height(80) + 6 = 117
        * 2 colunas: Column1=Resps (Respostas), Column2=nResps (Fixa Sim/Nao)
        * ColumnCount FORA do WITH para evitar Problema 36 (criacao imediata)
        *----------------------------------------------------------------------
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.ColumnCount = 2

        WITH loc_oPg1.grd_4c_Lista
            .Top                = 117
            .Left               = 10
            .Width              = 880
            .Height             = 440
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .Column1.Header1.Caption = "Respostas"
            .Column1.Alignment       = 0
            .Column2.Header1.Caption = "Fixa"
            .Column2.Alignment       = 2
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca fichas tecnicas do contexto e vincula ao Grid
    * FteBO.Buscar("") retorna cursor_4c_Dados com: cIdChaves, Resps, nResps, ...
    * Column2 usa IIF para exibir "Sim"/"Nao" baseado em nResps
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        *-- Pular carga SQL quando validando UI (sem conexao disponivel)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF THIS.this_oBusinessObject.Buscar("")
                *-- RecordSource FORA do WITH (Problema 36) para criacao imediata das colunas
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.Resps"
                    .Column1.Width           = 795
                    .Column1.Header1.Caption = "Respostas"
                    .Column1.Alignment       = 0
                    .Column2.ControlSource   = "IIF(cursor_4c_Dados.nResps=1,'Sim','N" + CHR(227) + "o')"
                    .Column2.Width           = 75
                    .Column2.Header1.Caption = "Fixa"
                    .Column2.Alignment       = 2
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro em CarregarLista:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista automaticamente.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme modo atual
    * LISTA:      botoes CRUD habilitados por permissao; Confirmar n/a
    * INCLUIR/ALTERAR: Confirmar e Cancelar habilitados
    * VISUALIZAR: Confirmar desabilitado; Cancelar habilitado
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_oCntAcao

        loc_oCnt     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        DO CASE
            CASE THIS.this_cModoAtual = "LISTA"
                IF VARTYPE(loc_oCnt) = "O" AND PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
                    loc_oCnt.cmd_4c_Incluir.Enabled    = THIS.this_lPermiteEditar
                    loc_oCnt.cmd_4c_Alterar.Enabled    = THIS.this_lPermiteEditar
                    loc_oCnt.cmd_4c_Excluir.Enabled    = THIS.this_lPermiteEditar
                    loc_oCnt.cmd_4c_Visualizar.Enabled = .T.
                    loc_oCnt.cmd_4c_Buscar.Enabled     = .T.
                ENDIF

            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                IF VARTYPE(loc_oCntAcao) = "O" AND PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
                    loc_oCntAcao.cmd_4c_Confirmar.Enabled = .T.
                    loc_oCntAcao.cmd_4c_Cancelar.Enabled  = .T.
                ENDIF

            CASE THIS.this_cModoAtual = "VISUALIZAR"
                IF VARTYPE(loc_oCntAcao) = "O" AND PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
                    loc_oCntAcao.cmd_4c_Confirmar.Enabled = .F.
                    loc_oCntAcao.cmd_4c_Cancelar.Enabled  = .T.
                ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorPermissao - Aplica restricoes de permissao nos botoes CRUD
    * Mantido para compatibilidade; internamente delega para AjustarBotoesPorModo
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorPermissao()
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Pages de PageFrames E Controls de Containers (Problema 6 / FormCor)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
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
    * FormatarGridLista - Aplica formatacao visual ao grid (FontName/Size)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * Handlers dos botoes CRUD (PUBLIC para BINDEVENT - CLAUDE.md #3)
    * Todos os metodos BtnXxxClick sao PUBLIC (sem PROTECTED)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        IF !THIS.this_lPermiteEditar
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                     "o permitida.", "Permiss" + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cIdChave
        loc_cIdChave = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cIdChave = ALLTRIM(cursor_4c_Dados.cIdChaves)

        IF EMPTY(loc_cIdChave)
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChave)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cIdChave
        loc_cIdChave = ""

        IF !THIS.this_lPermiteEditar
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                     "o permitida.", "Permiss" + CHR(227) + "o")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cIdChave = ALLTRIM(cursor_4c_Dados.cIdChaves)

        IF EMPTY(loc_cIdChave)
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cIdChave
        loc_cIdChave = ""

        IF !THIS.this_lPermiteEditar
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                     "o permitida.", "Permiss" + CHR(227) + "o")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cIdChave = ALLTRIM(cursor_4c_Dados.cIdChaves)

        IF EMPTY(loc_cIdChave)
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta ficha t" + CHR(233) + "cnica?", ;
                       "Confirmar Exclus" + CHR(227) + "o")
            IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChave)
                MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Erro")
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Ficha t" + CHR(233) + "cnica exclu" + CHR(237) + "da com sucesso.", "Sucesso")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria campos da Page2 (edicao/visualizacao)
    *
    * Fase 5 (primeira metade): botoes Confirmar/Cancelar + label + EditBox Resps
    * Compensacao PageFrame.Top=-29: todos os controles Top += 29.
    *
    * Original getResps: Top=217, Left=196, Width=408, Height=72
    *   -> migrado edt_4c_Resps: Top=246 (217+29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oCntAcao

        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_oCntAcao = loc_oPg2.cnt_4c_BotoesAcao

        *----------------------------------------------------------------------
        * Botoes Confirmar/Cancelar
        * Container cnt_4c_BotoesAcao ja criado em ConfigurarPageFrame:
        *   Left=842, Top=33, Width=160, Height=85
        * grupo_salva.salva.Left=5 / .cancelar.Left=80 (do original)
        *----------------------------------------------------------------------
        loc_oCntAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCntAcao.cmd_4c_Confirmar
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCntAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oCntAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCntAcao.cmd_4c_Cancelar
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCntAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * Label "Resposta:" - alinhado ao topo do EditBox
        * EditBox.Left=196, portanto label ocupa Left=10..193
        *----------------------------------------------------------------------
        loc_oPg2.AddObject("lbl_4c_Resps", "Label")
        WITH loc_oPg2.lbl_4c_Resps
            .Caption   = "Resposta:"
            .Top       = 246
            .Left      = 10
            .Width     = 183
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * EditBox para Resps (getResps original: fwmemo/editbox)
        * Original: Top=217, Left=196, Width=408, Height=72
        * Migrado:  Top=246 (217+29)
        * When event mapeado em HabilitarCampos() (fase 6)
        *----------------------------------------------------------------------
        loc_oPg2.AddObject("edt_4c_Resps", "EditBox")
        WITH loc_oPg2.edt_4c_Resps
            .Top        = 246
            .Left       = 196
            .Width      = 408
            .Height     = 72
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .ScrollBars = 2
            .Enabled    = .T.
            .Visible    = .T.
            .Value      = ""
        ENDWITH

        *----------------------------------------------------------------------
        * CheckBox "Resposta Fixa" (chkRespFixa original)
        * Original: Top=294, Left=196, Width=109, Height=19
        * Migrado:  Top=323 (294+29, compensacao PageFrame)
        *----------------------------------------------------------------------
        loc_oPg2.AddObject("chk_4c_RespFixa", "CheckBox")
        WITH loc_oPg2.chk_4c_RespFixa
            .Caption   = "Resposta Fixa"
            .Top       = 323
            .Left      = 196
            .Width     = 109
            .Height    = 19
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida, salva e retorna para lista
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cResps
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cResps = ALLTRIM(loc_oPg2.edt_4c_Resps.Value)

        IF EMPTY(loc_cResps)
            MsgAviso("O campo Resposta " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.edt_4c_Resps.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Ficha t" + CHR(233) + "cnica salva com sucesso.", "Sucesso")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do form para o BO (chamado antes de Salvar)
    * Em modo INCLUIR propaga contexto de abertura (equivalente ao Replace
    * CGrus/SGrus/CCars/CTits/GruCarTits do click do grupo_op legado)
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cResps  = ALLTRIM(loc_oPg2.edt_4c_Resps.Value)
        THIS.this_oBusinessObject.this_nNResps = loc_oPg2.chk_4c_RespFixa.Value

        IF THIS.this_cModoAtual = "INCLUIR"
            THIS.this_oBusinessObject.this_cCGrus = THIS.this_cContextGrupos
            THIS.this_oBusinessObject.this_cSGrus = THIS.this_cContextSubGrp
            THIS.this_oBusinessObject.this_cCCars = THIS.this_cContextCargos
            THIS.this_oBusinessObject.this_cCTits = THIS.this_cContextTitulos
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.edt_4c_Resps.Value    = THIS.this_oBusinessObject.this_cResps
        loc_oPg2.chk_4c_RespFixa.Value = THIS.this_oBusinessObject.this_nNResps
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta campos de edicao para valores em branco
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.edt_4c_Resps.Value    = ""
        loc_oPg2.chk_4c_RespFixa.Value = 0
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla editabilidade dos campos conforme modo
    * par_lHabilitar = .T. em INCLUIR/ALTERAR, .F. em VISUALIZAR
    * Equivalente ao When event: Return(InList(pcEscolha,'INSERIR','ALTERAR'))
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oCntAcao
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_oCntAcao = loc_oPg2.cnt_4c_BotoesAcao

        loc_oPg2.edt_4c_Resps.Enabled        = par_lHabilitar
        loc_oPg2.chk_4c_RespFixa.Enabled     = par_lHabilitar
        loc_oCntAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FteBO.prg):
*==============================================================================
* FteBO.prg - Business Object para Fichas Tecnicas
* Tabela: SigCdFtr
* PK: cIdChaves
*==============================================================================
DEFINE CLASS FteBO AS BusinessBase

    *-- Chave primaria
    this_cIdChaves    = ""

    *-- Campos de contexto (filtro/PK composta)
    this_cCGrus       = ""    && CGrus - Grupo
    this_cSGrus       = ""    && SGrus - SubGrupo
    this_cCCars       = ""    && CCars - Cargo
    this_cCTits       = ""    && CTits - Titulo
    this_cGruCarTits  = ""    && GruCarTits - Chave composta (CGrus+CCars+CTits+SGrus)

    *-- Campos de conteudo
    this_cResps       = ""    && Resps - Texto da resposta (memo)
    this_nNResps      = 0     && nResps - Resposta Fixa (0=Nao, 1=Sim)

    *-- Contexto de abertura (parametros recebidos pelo form)
    this_cContextGrupos  = ""
    this_cContextSubGrp  = ""
    this_cContextCargos  = ""
    this_cContextTitulos = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdFtr"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT filtrado pelo contexto (GruCarTits = CGrus+CCars+CTits+SGrus)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cChave, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.this_cContextGrupos + THIS.this_cContextCargos + ;
                         THIS.this_cContextTitulos + THIS.this_cContextSubGrp

            loc_cSQL = "SELECT cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits," + ;
                       " Resps, nResps" + ;
                       " FROM SigCdFtr" + ;
                       " WHERE GruCarTits = " + EscaparSQL(loc_cChave)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cIdChaves"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar fichas t" + CHR(233) + "cnicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por PK (cIdChaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits," + ;
                       " Resps, nResps" + ;
                       " FROM SigCdFtr" + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves   = TratarNulo(cIdChaves,   "C")
            THIS.this_cCGrus      = TratarNulo(CGrus,        "C")
            THIS.this_cSGrus      = TratarNulo(SGrus,        "C")
            THIS.this_cCCars      = TratarNulo(CCars,        "C")
            THIS.this_cCTits      = TratarNulo(CTits,        "C")
            THIS.this_cGruCarTits = TratarNulo(GruCarTits,   "C")
            THIS.this_cResps      = TratarNulo(Resps,        "C")
            THIS.this_nNResps     = TratarNulo(nResps,       "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_cNovaChave, loc_nResId, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = ""
            loc_nResId = SQLEXEC(gnConnHandle, "SELECT CONVERT(varchar(36), NEWID()) AS NovaChave", "cursor_4c_NewId")
            IF loc_nResId >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                loc_cNovaChave = ALLTRIM(cursor_4c_NewId.NovaChave)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF

            IF EMPTY(loc_cNovaChave)
                MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ELSE
                THIS.this_cIdChaves   = loc_cNovaChave
                THIS.this_cGruCarTits = THIS.this_cCGrus + THIS.this_cCCars + ;
                                        THIS.this_cCTits + THIS.this_cSGrus

                loc_cSQL = "INSERT INTO SigCdFtr" + ;
                           " (cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits, Resps, nResps)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cIdChaves)   + ", " + ;
                           EscaparSQL(THIS.this_cCGrus)      + ", " + ;
                           EscaparSQL(THIS.this_cSGrus)      + ", " + ;
                           EscaparSQL(THIS.this_cCCars)      + ", " + ;
                           EscaparSQL(THIS.this_cCTits)      + ", " + ;
                           EscaparSQL(THIS.this_cGruCarTits) + ", " + ;
                           EscaparSQL(THIS.this_cResps)      + ", " + ;
                           FormatarNumeroSQL(THIS.this_nNResps) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cGruCarTits = THIS.this_cCGrus + THIS.this_cCCars + ;
                                    THIS.this_cCTits + THIS.this_cSGrus

            loc_cSQL = "UPDATE SigCdFtr SET" + ;
                       " CGrus = "      + EscaparSQL(THIS.this_cCGrus)      + "," + ;
                       " SGrus = "      + EscaparSQL(THIS.this_cSGrus)      + "," + ;
                       " CCars = "      + EscaparSQL(THIS.this_cCCars)      + "," + ;
                       " CTits = "      + EscaparSQL(THIS.this_cCTits)      + "," + ;
                       " GruCarTits = " + EscaparSQL(THIS.this_cGruCarTits) + "," + ;
                       " Resps = "      + EscaparSQL(THIS.this_cResps)      + "," + ;
                       " nResps = "     + FormatarNumeroSQL(THIS.this_nNResps) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFtr" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

