# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[19/08/2026 06:48:09 AM] Erro: Erro em: FormMPD.ConfigurarPgEstoque | Linha: 2634 | Connection handle is invalid. | Procedure: configurarpgestoque
[19/08/2026 06:48:09 AM] Erro: Erro em: FormMPD.TornarControlesVisiveis | Linha: 540 | Property CONTROLCOUNT is not found. | Detalhes: CONTROLCOUNT | Procedure: tornarcontrolesvisiveis
[19/08/2026 06:48:09 AM] Erro: Erro em: FormMPD.TornarControlesVisiveis | Linha: 540 | Property CONTROLCOUNT is not found. | Detalhes: CONTROLCOUNT | Procedure: tornarcontrolesvisiveis
[19/08/2026 06:48:09 AM] Erro: Erro em: FormMPD.TornarControlesVisiveis | Linha: 540 | Property CONTROLCOUNT is not found. | Detalhes: CONTROLCOUNT | Procedure: tornarcontrolesvisiveis


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-19 06:46:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-19 06:46:56] [INFO] Config FPW: (nao fornecido)
[2026-08-19 06:46:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 06:46:56] [INFO] Timeout: 300 segundos
[2026-08-19 06:46:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_202groen.prg
[2026-08-19 06:46:56] [INFO] Conteudo do wrapper:
[2026-08-19 06:46:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormMPD', 'C:\4c\tasks\task465', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMPD', 'C:\4c\tasks\task465', 'CRUD'
QUIT

[2026-08-19 06:46:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_202groen.prg
[2026-08-19 06:46:56] [INFO] VFP output esperado em: C:\4c\tasks\task465\vfp_output.txt
[2026-08-19 06:46:56] [INFO] Executando Visual FoxPro 9...
[2026-08-19 06:46:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_202groen.prg
[2026-08-19 06:46:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_202groen.prg
[2026-08-19 06:46:56] [INFO] Timeout configurado: 300 segundos
[2026-08-19 06:48:09] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-19 06:48:09] [INFO] VFP9 finalizado em 73.2341106 segundos
[2026-08-19 06:48:09] [INFO] Exit Code: 
[2026-08-19 06:48:09] [INFO] 
[2026-08-19 06:48:09] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-19 06:48:09] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_202groen.prg
[2026-08-19 06:48:09] [INFO] 
[2026-08-19 06:48:09] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-19 06:48:09] [INFO] * Auto-generated wrapper for parameters
[2026-08-19 06:48:09] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-19 06:48:09] [INFO] * Parameters: 'FormMPD', 'C:\4c\tasks\task465', 'CRUD'
[2026-08-19 06:48:09] [INFO] 
[2026-08-19 06:48:09] [INFO] * Anti-dialog protections for unattended execution
[2026-08-19 06:48:09] [INFO] SET SAFETY OFF
[2026-08-19 06:48:09] [INFO] SET RESOURCE OFF
[2026-08-19 06:48:09] [INFO] SET TALK OFF
[2026-08-19 06:48:09] [INFO] SET NOTIFY OFF
[2026-08-19 06:48:09] [INFO] SYS(2335, 0)
[2026-08-19 06:48:09] [INFO] 
[2026-08-19 06:48:09] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMPD', 'C:\4c\tasks\task465', 'CRUD'
[2026-08-19 06:48:09] [INFO] QUIT
[2026-08-19 06:48:09] [INFO] 
[2026-08-19 06:48:09] [INFO] === Fim do Wrapper.prg ===
[2026-08-19 06:48:09] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormMPD",
  "timestamp": "20260819064809",
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
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
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
      "detalhes": "BtnIncluirClick navegou para Page2 | BtnCancelarClick retornou para Page1"
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
      "detalhes": "AbrirLookup: 22 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPCONTACCUS, ABRIRLOOKUPCONTADEST, ABRIRLOOKUPCONTAORIG, ABRIRLOOKUPEMPENHO, ABRIRLOOKUPEMPLANC, ABRIRLOOKUPGRUCCUS, ABRIRLOOKUPGRUFIN, ABRIRLOOKUPGRUPODEST, ABRIRLOOKUPGRUPOORIG, ABRIRLOOKUPGRUPOPCC, ABRIRLOOKUPGRUPOVEND, ABRIRLOOKUPNIVEL, ABRIRLOOKUPOBSFINS, ABRIRLOOKUPOBSINIS, ABRIRLOOKUPOBSPADS, ABRIRLOOKUPOPCONTA, ABRIRLOOKUPPRODUTO, ABRIRLOOKUPRETALHO, ABRIRLOOKUPSEMI, ABRIRLOOKUPTPOP, ABRIRLOOKUPTPPADRAO) | KeyPress handlers: 22 (CONTACCUSKEYPRESS, CONTADESTKEYPRESS, CONTAORIGKEYPRESS, EMPENHOKEYPRESS, EMPLANCKEYPRESS, GRUCCUSKEYPRESS, GRUFINKEYPRESS, GRUPODESTKEYPRESS, GRUPOORIGKEYPRESS, GRUPOPCCKEYPRESS, GRUPOVENDKEYPRESS, KEYPRESS, NIVELKEYPRESS, OBSFINSKEYPRESS, OBSINISKEYPRESS, OBSPADSKEYPRESS, OPCONTAKEYPRESS, PRODUTOKEYPRESS, RETALHOKEYPRESS, SEMIKEYPRESS, TPOPKEYPRESS, TPPADRAOKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMPD.prg):
*==============================================================================
* FormMPD.prg - Movimenta" + CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o
* Migrado de: SIGCDMPD | Fase 4/8: Grid e Bot" + CHR(245) + "es CRUD
*==============================================================================
DEFINE CLASS FormMPD AS FormBase

    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.Caption = "Movimenta" + CHR(231) + CHR(245) + ;
                "es de Produ" + CHR(231) + CHR(227) + "o"
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            THIS.this_oBusinessObject = CREATEOBJECT("MPDBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar MPDBO", "FormMPD.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormMPD.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .PageCount = 2
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height + 29
                .Tabs      = .F.
                .Visible   = .T.
                .Page1.Caption = "Lista"
                .Page2.Caption = "Dados"
                .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDWITH
            THIS.ConfigurarContaineresPage1()
            THIS.ConfigurarContaineresPage2()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ConfigurarContaineresPage1()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPg.cnt_4c_Cabecalho
                .Top        = 31
                .Left       = 0
                .Width      = THIS.Width
                .Height     = 80
                .BackColor  = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible    = .T.
                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top      = 15
                    .Left     = 12
                    .Width    = THIS.Width
                    .Height   = 40
                    .AutoSize = .F.
                    .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
                        "es de Produ" + CHR(231) + CHR(227) + "o"
                    .FontName = "Tahoma"
                    .FontSize = 16
                    .FontBold = .T.
                    .ForeColor = RGB(0,0,0)
                    .BackStyle = 0
                    .Visible  = .T.
                ENDWITH
                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Top      = 18
                    .Left     = 10
                    .Width    = THIS.Width
                    .Height   = 46
                    .AutoSize = .F.
                    .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
                        "es de Produ" + CHR(231) + CHR(227) + "o"
                    .FontName = "Tahoma"
                    .FontSize = 16
                    .FontBold = .T.
                    .ForeColor = RGB(255,255,255)
                    .BackStyle = 0
                    .Visible  = .T.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPg.cnt_4c_Botoes
                .Top        = 29
                .Left       = 542
                .Width      = 390
                .Height     = 85
                .BackStyle  = 1
                .BackColor  = RGB(53,53,53)
                .BorderWidth = 0
                .Visible    = .T.
            ENDWITH
            loc_oPg.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPg.cnt_4c_Saida
                .Top        = 29
                .Left       = 917
                .Width      = 90
                .Height     = 85
                .BackStyle  = 0
                .BorderWidth = 0
                .Visible    = .T.
            ENDWITH
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarContaineresPage1")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ConfigurarContaineresPage2()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPg.cnt_4c_Cabecalho
                .Top        = 31
                .Left       = 0
                .Width      = THIS.Width
                .Height     = 80
                .BackColor  = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible    = .T.
                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top      = 15
                    .Left     = 12
                    .Width    = THIS.Width
                    .Height   = 40
                    .AutoSize = .F.
                    .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
                        "es de Produ" + CHR(231) + CHR(227) + "o"
                    .FontName = "Tahoma"
                    .FontSize = 16
                    .FontBold = .T.
                    .ForeColor = RGB(0,0,0)
                    .BackStyle = 0
                    .Visible  = .T.
                ENDWITH
                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Top      = 18
                    .Left     = 10
                    .Width    = THIS.Width
                    .Height   = 46
                    .AutoSize = .F.
                    .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
                        "es de Produ" + CHR(231) + CHR(227) + "o"
                    .FontName = "Tahoma"
                    .FontSize = 16
                    .FontBold = .T.
                    .ForeColor = RGB(255,255,255)
                    .BackStyle = 0
                    .Visible  = .T.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPg.cnt_4c_BotoesAcao
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH
            loc_oPg.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPg.cnt_4c_Saida
                .Top        = 29
                .Left       = 917
                .Width      = 90
                .Height     = 85
                .BackStyle  = 0
                .BorderWidth = 0
                .Visible    = .T.
            ENDWITH
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarContaineresPage2")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg, loc_oCnt
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oCnt = loc_oPg.cnt_4c_Botoes
            loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Incluir
                .Top      = 5
                .Left     = 5
                .Width    = 75
                .Height   = 75
                .Caption  = "Incluir"
                .Picture  = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
            loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Visualizar
                .Top      = 5
                .Left     = 82
                .Width    = 75
                .Height   = 75
                .Caption  = "Visualizar"
                .Picture  = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Alterar
                .Top      = 5
                .Left     = 159
                .Width    = 75
                .Height   = 75
                .Caption  = "Alterar"
                .Picture  = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
            loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Excluir
                .Top      = 5
                .Left     = 236
                .Width    = 75
                .Height   = 75
                .Caption  = "Excluir"
                .Picture  = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
            loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Buscar
                .Top      = 5
                .Left     = 313
                .Width    = 75
                .Height   = 75
                .Caption  = "Buscar"
                .Picture  = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
            loc_oCnt = loc_oPg.cnt_4c_Saida
            loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Encerrar
                .Top      = 5
                .Left     = 5
                .Width    = 75
                .Height   = 75
                .Caption  = "Encerrar"
                .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
            loc_oPg.AddObject("cmd_4c_CadOpe", "CommandButton")
            WITH loc_oPg.cmd_4c_CadOpe
                .Top      = 33
                .Left     = 324
                .Width    = 60
                .Height   = 75
                .Caption  = "Estoque"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPg.AddObject("cmd_4c_ExpXML", "CommandButton")
            WITH loc_oPg.cmd_4c_ExpXML
                .Top      = 33
                .Left     = 399
                .Width    = 60
                .Height   = 75
                .Caption  = "Exporta XML"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPg.AddObject("cmd_4c_ImpXML", "CommandButton")
            WITH loc_oPg.cmd_4c_ImpXML
                .Top      = 33
                .Left     = 474
                .Width    = 60
                .Height   = 75
                .Caption  = "Importa XML"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPg.AddObject("grd_4c_Lista", "Grid")
            WITH loc_oPg.grd_4c_Lista
                .Top          = 117
                .Left         = 26
                .Width        = 890
                .Height       = 450
                .ReadOnly     = .T.
                .GridLines    = 1
                .RowHeight    = 20
                .HeaderHeight = 25
                .ScrollBars   = 3
                .DeleteMark   = .F.
                .Themes       = .F.
                .FontName     = "Verdana"
                .FontSize     = 8
                .ColumnCount  = 4
                .Visible      = .T.
                .RecordMark   = .F.
            ENDWITH
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        TRY
            THIS.this_oBusinessObject.Buscar("")
            IF USED("cursor_4c_Dados")
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
                    .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    .Column1.Width           = 300
                    .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
                    .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
                    .Column2.Width           = 80
                    .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
                    .Column3.Header1.Caption = "Ordem"
                    .Column3.Width           = 60
                    .Column4.ControlSource   = "cursor_4c_Dados.Hists"
                    .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
                    .Column4.Width           = 420
                ENDWITH
                loc_lSucesso = .T.
            ENDIF
            THIS.AjustarBotoesPorModo()
        CATCH TO loException
            MostrarErro(loException, "FormMPD.CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormMPD.AlternarPagina")
        ENDTRY
    ENDPROC

    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        CATCH TO loException
            MostrarErro(loException, "FormMPD.BtnIncluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDopps
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro.", "Aviso")
            ELSE
                loc_cDopps = ALLTRIM(cursor_4c_Dados.Dopps)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopps)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormMPD.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cDopps
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro.", "Aviso")
            ELSE
                loc_cDopps = ALLTRIM(cursor_4c_Dados.Dopps)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopps)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormMPD.BtnAlterarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cDopps, loc_lConfirma
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro.", "Aviso")
            ELSE
                loc_cDopps    = ALLTRIM(cursor_4c_Dados.Dopps)
                loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o?", "Confirmar")
                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.Excluir(loc_cDopps)
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormMPD.BtnExcluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro
        TRY
            loc_cFiltro = INPUTBOX("Pesquisar por descri" + CHR(231) + CHR(227) + "o:", ;
                "Busca", "")
            THIS.this_oBusinessObject.Buscar(loc_cFiltro)
            IF USED("cursor_4c_Dados")
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
                    .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    .Column1.Width           = 300
                    .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
                    .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
                    .Column2.Width           = 80
                    .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
                    .Column3.Header1.Caption = "Ordem"
                    .Column3.Width           = 60
                    .Column4.ControlSource   = "cursor_4c_Dados.Hists"
                    .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
                    .Column4.Width           = 420
                ENDWITH
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormMPD.BtnBuscarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro(loException, "FormMPD.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            par_oGrid.FontName = "Verdana"
            par_oGrid.FontSize = 8
        CATCH TO loException
            MostrarErro(loException, "FormMPD.FormatarGridLista")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oCtrl
        TRY
            FOR loc_nI = 1 TO par_oContainer.ControlCount
                loc_oCtrl = par_oContainer.Controls(loc_nI)
                IF !INLIST(LOWER(loc_oCtrl.Name), "cnt_4c_cabecalho")
                    loc_oCtrl.Visible = .T.
                    IF loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loException
            MostrarErro(loException, "FormMPD.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg, loc_oCnt
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPg.cnt_4c_Cabecalho.Visible = .F.
            loc_oCnt = loc_oPg.cnt_4c_BotoesAcao
            loc_oCnt.AddObject("cmd_4c_Salvar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Salvar
                .Top      = 5
                .Left     = 5
                .Width    = 75
                .Height   = 75
                .Caption  = "Salvar"
                .Picture  = gc_4c_CaminhoIcones + "cadastro_gravar_60.jpg"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
            loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Cancelar
                .Top      = 5
                .Left     = 82
                .Width    = 75
                .Height   = 75
                .Caption  = "Encerrar"
                .Picture  = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
            loc_oCnt = loc_oPg.cnt_4c_Saida
            loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Encerrar
                .Top      = 5
                .Left     = 5
                .Width    = 75
                .Height   = 75
                .Caption  = "Encerrar"
                .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
            * Campos de cabecalho da aba Dados (top + 29 compensa pgf_4c_Paginas.Top=-29)
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Top       = 74
                .Left      = 64
                .Width     = 58
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Desc", "TextBox")
            WITH loc_oPg.txt_4c_Desc
                .Top       = 70
                .Left      = 132
                .Width     = 150
                .Height    = 23
                .MaxLength = 40
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label25", "Label")
            WITH loc_oPg.lbl_4c_Label25
                .Top       = 74
                .Left      = 332
                .Width     = 71
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o :"
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Nope", "TextBox")
            WITH loc_oPg.txt_4c_Nope
                .Top      = 70
                .Left     = 416
                .Width    = 29
                .Height   = 23
                .ReadOnly = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label28", "Label")
            WITH loc_oPg.lbl_4c_Label28
                .Top       = 74
                .Left      = 466
                .Width     = 44
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Ordem : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Ordem", "TextBox")
            WITH loc_oPg.txt_4c_Ordem
                .Top     = 71
                .Left    = 518
                .Width   = 27
                .Height  = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("obj_4c_CmdGarqicone", "CommandButton")
            WITH loc_oPg.obj_4c_CmdGarqicone
                .Top     = 69
                .Left    = 287
                .Width   = 25
                .Height  = 25
                .Caption = "..."
                .Themes  = .T.
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oPg.obj_4c_CmdGarqicone, "Click", THIS, "CmdGarqiconeClick")
            * PageFrame interno: 5 abas (Operacao, Estoque, Componente, Documento, Diversas)
            loc_oPg.AddObject("pgf_4c_PagDados", "PageFrame")
            WITH loc_oPg.pgf_4c_PagDados
                .Top       = 150
                .Left      = 6
                .Width     = 987
                .Height    = 475
                .PageCount = 5
                .Visible   = .T.
                .Page1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                .Page2.Caption = "Estoque"
                .Page3.Caption = "Componente"
                .Page4.Caption = "Documento"
                .Page5.Caption = "Diversas"
            ENDWITH
            THIS.ConfigurarPgOperacao()
            THIS.ConfigurarPgEstoque()
            THIS.ConfigurarPgComponente()
            THIS.ConfigurarPgDocumento()
            THIS.ConfigurarPgDiversas()
            THIS.TornarControlesVisiveis(loc_oPg)
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPgOperacao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        TRY
            loc_oPg.AddObject("shp_4c_Shape7", "Shape")
            WITH loc_oPg.shp_4c_Shape7
                .Top     = 192
                .Left    = 7
                .Width   = 287
                .Height  = 162
                .Visible = .T.
            ENDWITH
            * Labels coluna esquerda
            loc_oPg.AddObject("lbl_4c_Label36", "Label")
            WITH loc_oPg.lbl_4c_Label36
                .Top       = 15
                .Left      = 60
                .Width     = 60
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Imagem : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPg.lbl_4c_Label2
                .Top       = 34
                .Left      = 68
                .Width     = 60
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Boleto : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label31", "Label")
            WITH loc_oPg.lbl_4c_Label31
                .Top       = 54
                .Left      = 44
                .Width     = 80
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Documento : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPg.lbl_4c_Label6
                .Top       = 74
                .Left      = 84
                .Width     = 30
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "OP : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPg.lbl_4c_Label7
                .Top       = 94
                .Left      = 32
                .Width     = 90
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Componentes : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPg.lbl_4c_Label9
                .Top       = 116
                .Left      = 14
                .Width     = 105
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Aparece no Menu : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label21", "Label")
            WITH loc_oPg.lbl_4c_Label21
                .Top       = 136
                .Left      = 23
                .Width     = 100
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Op. Autom" + CHR(225) + "tica : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPg.lbl_4c_Label10
                .Top       = 158
                .Left      = 20
                .Width     = 87
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Hist" + CHR(243) + "rico Padr" + CHR(227) + "o : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPg.lbl_4c_Label8
                .Top       = 178
                .Left      = 7
                .Width     = 138
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Tratamento do SubN" + CHR(237) + "vel"
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label34", "Label")
            WITH loc_oPg.lbl_4c_Label34
                .Top       = 198
                .Left      = 61
                .Width     = 100
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Tem SubN" + CHR(237) + "vel : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label35", "Label")
            WITH loc_oPg.lbl_4c_Label35
                .Top       = 220
                .Left      = 84
                .Width     = 70
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "SubN" + CHR(237) + "vel : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPg.lbl_4c_Label4
                .Top       = 241
                .Left      = 40
                .Width     = 97
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "T" + CHR(237) + "tulo do SubN" + CHR(237) + "vel : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPg.lbl_4c_Label5
                .Top       = 262
                .Left      = 37
                .Width     = 100
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Artigo do SubN" + CHR(237) + "vel : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Top       = 285
                .Left      = 21
                .Width     = 130
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Faz Baixa Autom" + CHR(225) + "tica ? "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label23", "Label")
            WITH loc_oPg.lbl_4c_Label23
                .Top       = 305
                .Left      = 53
                .Width     = 90
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Excluir Subnivel ?"
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label28", "Label")
            WITH loc_oPg.lbl_4c_Label28
                .Top       = 325
                .Left      = 54
                .Width     = 83
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Checa SubN" + CHR(237) + "vel : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label25", "Label")
            WITH loc_oPg.lbl_4c_Label25
                .Top       = 360
                .Left      = 18
                .Width     = 140
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o Bx Empenho : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label27", "Label")
            WITH loc_oPg.lbl_4c_Label27
                .Top       = 384
                .Left      = 47
                .Width     = 108
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Somente p/ Empresa : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            * Labels coluna direita
            loc_oPg.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPg.lbl_4c_Label3
                .Top       = 14
                .Left      = 497
                .Width     = 160
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Checa Sequ" + CHR(234) + "ncia de Produ" + CHR(231) + CHR(227) + "o : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label11", "Label")
            WITH loc_oPg.lbl_4c_Label11
                .Top       = 35
                .Left      = 538
                .Width     = 120
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Agrega Mat" + CHR(233) + "ria-Prima : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label12", "Label")
            WITH loc_oPg.lbl_4c_Label12
                .Top       = 55
                .Left      = 523
                .Width     = 135
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Checa Repeti" + CHR(231) + CHR(227) + "o de Fase : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label14", "Label")
            WITH loc_oPg.lbl_4c_Label14
                .Top       = 75
                .Left      = 529
                .Width     = 130
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Checa Saldo de Estoque : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label15", "Label")
            WITH loc_oPg.lbl_4c_Label15
                .Top       = 95
                .Left      = 514
                .Width     = 145
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Inibir Mensagens Seq. Prod : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPg.lbl_4c_Label16
                .Top       = 116
                .Left      = 547
                .Width     = 115
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Mensagem de Falha : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label17", "Label")
            WITH loc_oPg.lbl_4c_Label17
                .Top       = 137
                .Left      = 493
                .Width     = 165
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Busca No. Envelope Autom" + CHR(225) + "tico : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label19", "Label")
            WITH loc_oPg.lbl_4c_Label19
                .Top       = 157
                .Left      = 546
                .Width     = 115
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Bot" + CHR(227) + "o de Retrabalho : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label20", "Label")
            WITH loc_oPg.lbl_4c_Label20
                .Top       = 176
                .Left      = 530
                .Width     = 130
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Bot" + CHR(227) + "o de N" + CHR(227) + "o Conforme : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label22", "Label")
            WITH loc_oPg.lbl_4c_Label22
                .Top       = 194
                .Left      = 559
                .Width     = 100
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Bot" + CHR(227) + "o de Servi" + CHR(231) + "os : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label24", "Label")
            WITH loc_oPg.lbl_4c_Label24
                .Top       = 214
                .Left      = 559
                .Width     = 95
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Bot" + CHR(227) + "o de Etiqueta : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label13", "Label")
            WITH loc_oPg.lbl_4c_Label13
                .Top       = 234
                .Left      = 580
                .Width     = 74
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Apontamento : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label26", "Label")
            WITH loc_oPg.lbl_4c_Label26
                .Top       = 255
                .Left      = 647
                .Width     = 120
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = CHR(205) + "cone Barra Acesso : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label18", "Label")
            WITH loc_oPg.lbl_4c_Label18
                .Top       = 304
                .Left      = 538
                .Width     = 130
                .Height    = 15
                .AutoSize  = .F.
                .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o : "
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            * TextBoxes
            loc_oPg.AddObject("txt_4c_Hists", "TextBox")
            WITH loc_oPg.txt_4c_Hists
                .Top       = 154
                .Left      = 108
                .Width     = 223
                .Height    = 23
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Nivel", "TextBox")
            WITH loc_oPg.txt_4c_Nivel
                .Top     = 216
                .Left    = 141
                .Width   = 150
                .Height  = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Titulo", "TextBox")
            WITH loc_oPg.txt_4c_Titulo
                .Top       = 238
                .Left      = 141
                .Width     = 124
                .Height    = 21
                .MaxLength = 15
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Artigo", "TextBox")
            WITH loc_oPg.txt_4c_Artigo
                .Top       = 260
                .Left      = 141
                .Width     = 17
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_ArqIcone", "TextBox")
            WITH loc_oPg.txt_4c_ArqIcone
                .Top       = 270
                .Left      = 645
                .Width     = 110
                .Height    = 21
                .MaxLength = 64
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c__Empenho", "TextBox")
            WITH loc_oPg.txt_4c__Empenho
                .Top       = 357
                .Left      = 160
                .Width     = 134
                .Height    = 23
                .MaxLength = 20
                .FontName  = "Courier New"
                .Visible   = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_EmpLanc", "TextBox")
            WITH loc_oPg.txt_4c_EmpLanc
                .Top      = 381
                .Left     = 160
                .Width    = 34
                .Height   = 23
                .FontName = "Courier New"
                .Visible  = .T.
            ENDWITH
            * Image e CommandButton para icone da barra de acesso
            loc_oPg.AddObject("img_4c_ImgIcone", "Image")
            WITH loc_oPg.img_4c_ImgIcone
                .Top     = 263
                .Left    = 785
                .Width   = 32
                .Height  = 32
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("cmd_4c_CmdIcone", "CommandButton")
            WITH loc_oPg.cmd_4c_CmdIcone
                .Top     = 268
                .Left    = 755
                .Width   = 24
                .Height  = 24
                .Caption = "..."
                .Themes  = .T.
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_CmdIcone, "Click", THIS, "CmdIconeClick")
            * OptionGroups coluna esquerda
            loc_oPg.AddObject("obj_4c_Op_imagem", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_imagem
                .Top         = 13
                .Left        = 108
                .Width       = 89
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_boleto", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_boleto
                .Top         = 32
                .Left        = 108
                .Width       = 130
                .Height      = 17
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 38
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 44
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 38
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top     = 2
                    .Left    = 88
                    .Caption = "Tela"
                    .Width   = 38
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption8", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption8
                .Top         = 52
                .Left        = 108
                .Width       = 89
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption5
                .Top         = 73
                .Left        = 107
                .Width       = 92
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opt_compo", "OptionGroup")
            WITH loc_oPg.obj_4c_Opt_compo
                .Top         = 90
                .Left        = 107
                .Width       = 89
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opt_Menu", "OptionGroup")
            WITH loc_oPg.obj_4c_Opt_Menu
                .Top         = 114
                .Left        = 108
                .Width       = 89
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_ObjAutos", "OptionGroup")
            WITH loc_oPg.obj_4c_ObjAutos
                .Top         = 134
                .Left        = 108
                .Width       = 193
                .Height      = 20
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Movim."
                    .Width   = 60
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 66
                    .Caption = "Encerra"
                    .Width   = 60
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top     = 2
                    .Left    = 130
                    .Caption = "Nenhum"
                    .Width   = 60
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_subn", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_subn
                .Top         = 195
                .Left        = 141
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_BxAuto", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_BxAuto
                .Top         = 283
                .Left        = 141
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption2
                .Top         = 303
                .Left        = 141
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption1
                .Top         = 323
                .Left        = 141
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            * OptionGroups coluna direita
            loc_oPg.AddObject("obj_4c_GetSequencia", "OptionGroup")
            WITH loc_oPg.obj_4c_GetSequencia
                .Top         = 12
                .Left        = 656
                .Width       = 88
                .Height      = 21
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_agregas", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_agregas
                .Top         = 33
                .Left        = 656
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_repete", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_repete
                .Top         = 53
                .Left        = 656
                .Width       = 160
                .Height      = 20
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 50
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 56
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 50
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top     = 2
                    .Left    = 109
                    .Caption = "Por Setor"
                    .Width   = 50
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_Saldo", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_Saldo
                .Top         = 73
                .Left        = 656
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_inib", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_inib
                .Top         = 93
                .Left        = 656
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_ObjMenFalha", "OptionGroup")
            WITH loc_oPg.obj_4c_ObjMenFalha
                .Top         = 114
                .Left        = 656
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_ObjBusEnv", "OptionGroup")
            WITH loc_oPg.obj_4c_ObjBusEnv
                .Top         = 135
                .Left        = 656
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_ObjRetrabs", "OptionGroup")
            WITH loc_oPg.obj_4c_ObjRetrabs
                .Top         = 155
                .Left        = 656
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Objnaoconform", "OptionGroup")
            WITH loc_oPg.obj_4c_Objnaoconform
                .Top         = 174
                .Left        = 656
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Objpagamento", "OptionGroup")
            WITH loc_oPg.obj_4c_Objpagamento
                .Top         = 192
                .Left        = 656
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption3
                .Top         = 212
                .Left        = 656
                .Width       = 88
                .Height      = 20
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Sim"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width   = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption4
                .Top         = 232
                .Left        = 656
                .Width       = 155
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Caption = "Op"
                    .Width   = 47
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 53
                    .Caption = "Env"
                    .Width   = 47
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top     = 2
                    .Left    = 103
                    .Caption = "Nenhum"
                    .Width   = 47
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opt_tipomov", "OptionGroup")
            WITH loc_oPg.obj_4c_Opt_tipomov
                .Top         = 302
                .Left        = 665
                .Width       = 237
                .Height      = 98
                .ButtonCount = 11
                .Visible     = .T.
                WITH .Buttons(1)
                    .Left    = 3
                    .Top     = 2
                    .Caption = "Envelopagem"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Left    = 107
                    .Top     = 2
                    .Caption = "Nenhum"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Left    = 3
                    .Top     = 17
                    .Caption = "Encerra"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(4)
                    .Left    = 107
                    .Top     = 17
                    .Caption = "Dev.Pedra"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(5)
                    .Left    = 3
                    .Top     = 33
                    .Caption = "Sep. Pedra"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(6)
                    .Left    = 107
                    .Top     = 33
                    .Caption = "Reposi" + CHR(231) + CHR(227) + "o"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(7)
                    .Left    = 3
                    .Top     = 49
                    .Caption = "Mov. Externa"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(8)
                    .Left    = 107
                    .Top     = 49
                    .Caption = "Mov.Pedra"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(9)
                    .Left    = 3
                    .Top     = 64
                    .Caption = "Muda de Fase"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(10)
                    .Left    = 107
                    .Top     = 64
                    .Caption = "Mov Op Envelopado"
                    .Width   = 114
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(11)
                    .Left    = 3
                    .Top     = 80
                    .Caption = "Mov Material"
                    .Width   = 100
                    .Height  = 14
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            * BINDEVENTs lookups Operacao
            BINDEVENT(loc_oPg.txt_4c_Nivel,    "KeyPress", THIS, "NivelKeyPress")
            BINDEVENT(loc_oPg.txt_4c_Nivel,    "DblClick", THIS, "AbrirLookupNivel")
            BINDEVENT(loc_oPg.txt_4c__Empenho, "KeyPress", THIS, "EmpenhoKeyPress")
            BINDEVENT(loc_oPg.txt_4c__Empenho, "DblClick", THIS, "AbrirLookupEmpenho")
            BINDEVENT(loc_oPg.txt_4c_EmpLanc,  "KeyPress", THIS, "EmpLancKeyPress")
            BINDEVENT(loc_oPg.txt_4c_EmpLanc,  "DblClick", THIS, "AbrirLookupEmpLanc")
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarPgOperacao")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaBO()
            loc_lSucesso = THIS.this_oBusinessObject.Salvar()
            IF loc_lSucesso
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                THIS.CarregarLista()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormMPD.BtnSalvarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro(loException, "FormMPD.BtnCancelarClick")
        ENDTRY
    ENDPROC

    PROCEDURE CmdGarqiconeClick()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT carqicones FROM SigSyIco ORDER BY carqicones"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_Icn"
                loc_oFrm.DefinirCursor("cursor_4c_Icn", "carqicones", "carqicones", CHR(205) + "cone")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2
                    loc_oPg.txt_4c_Desc.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_Icn")
                    USE IN cursor_4c_Icn
                ENDIF
            ELSE
                MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormMPD.CmdGarqiconeClick")
        ENDTRY
    ENDPROC

    PROCEDURE CmdIconeClick()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT carqicones FROM SigSyIco ORDER BY carqicones"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn2")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_Icn2"
                loc_oFrm.DefinirCursor("cursor_4c_Icn2", "carqicones", "carqicones", CHR(205) + "cone Barra")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
                    loc_oPg.txt_4c_ArqIcone.Value = loc_oFrm.cCodigoSelecionado
                    IF !EMPTY(loc_oFrm.cCodigoSelecionado)
                        loc_oPg.img_4c_ImgIcone.Picture = gc_4c_CaminhoIcones + ALLTRIM(loc_oFrm.cCodigoSelecionado)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Icn2")
                    USE IN cursor_4c_Icn2
                ENDIF
            ELSE
                MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormMPD.CmdIconeClick")
        ENDTRY
    ENDPROC

    * ============================================================
    * ConfigurarPgEstoque
    * ============================================================
    PROTECTED PROCEDURE ConfigurarPgEstoque()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
        TRY
            * Shapes
            loc_oPg.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPg.shp_4c_Shape1
                .Top = 84
                .Left = 5
                .Width = 671
                .Height = 72
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("shp_4c_Shape3", "Shape")
            WITH loc_oPg.shp_4c_Shape3
                .Top = 205
                .Left = 5
                .Width = 671
                .Height = 73
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPg.shp_4c_Shape2
                .Top = 317
                .Left = 10
                .Width = 303
                .Height = 29
                .Visible = .T.
            ENDWITH
            * Labels
            loc_oPg.AddObject("lbl_4c_Label21", "Label")
            WITH loc_oPg.lbl_4c_Label21
                .Top = 15
                .Left = 27
                .Width = 90
                .Height = 15
                .AutoSize = .F.
                .Caption = "Numera" + CHR(231) + CHR(227) + "o : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label25", "Label")
            WITH loc_oPg.lbl_4c_Label25
                .Top = 15
                .Left = 521
                .Width = 106
                .Height = 15
                .AutoSize = .F.
                .Caption = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPg.lbl_4c_Label7
                .Top = 71
                .Left = 6
                .Width = 120
                .Height = 15
                .AutoSize = .F.
                .Caption = "Origem da Opera" + CHR(231) + CHR(227) + "o"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Top = 49
                .Left = 38
                .Width = 64
                .Height = 15
                .AutoSize = .F.
                .Caption = "Tem Origem?"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPg.lbl_4c_Label6
                .Top = 94
                .Left = 10
                .Width = 42
                .Height = 15
                .AutoSize = .F.
                .Caption = "Grupo : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label22", "Label")
            WITH loc_oPg.lbl_4c_Label22
                .Top = 115
                .Left = 11
                .Width = 41
                .Height = 15
                .AutoSize = .F.
                .Caption = "Conta : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPg.lbl_4c_Label16
                .Top = 116
                .Left = 411
                .Width = 55
                .Height = 15
                .AutoSize = .F.
                .Caption = "Fase Ant : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPg.lbl_4c_Label10
                .Top = 92
                .Left = 391
                .Width = 72
                .Height = 15
                .AutoSize = .F.
                .Caption = "Op. Estoque : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label18", "Label")
            WITH loc_oPg.lbl_4c_Label18
                .Top = 135
                .Left = 253
                .Width = 52
                .Height = 15
                .AutoSize = .F.
                .Caption = "M" + CHR(225) + "scara : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label14", "Label")
            WITH loc_oPg.lbl_4c_Label14
                .Top = 192
                .Left = 6
                .Width = 120
                .Height = 15
                .AutoSize = .F.
                .Caption = "Destino da Opera" + CHR(231) + CHR(227) + "o"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label12", "Label")
            WITH loc_oPg.lbl_4c_Label12
                .Top = 171
                .Left = 12
                .Width = 66
                .Height = 15
                .AutoSize = .F.
                .Caption = "Tem Destino?"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPg.lbl_4c_Label4
                .Top = 171
                .Left = 221
                .Width = 133
                .Height = 15
                .AutoSize = .F.
                .Caption = "Repete Origem no Destino?"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPg.lbl_4c_Label2
                .Top = 215
                .Left = 10
                .Width = 42
                .Height = 15
                .AutoSize = .F.
                .Caption = "Grupo : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPg.lbl_4c_Label3
                .Top = 236
                .Left = 11
                .Width = 41
                .Height = 15
                .AutoSize = .F.
                .Caption = "Conta : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label17", "Label")
            WITH loc_oPg.lbl_4c_Label17
                .Top = 237
                .Left = 411
                .Width = 55
                .Height = 15
                .AutoSize = .F.
                .Caption = "Fase Ant : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label11", "Label")
            WITH loc_oPg.lbl_4c_Label11
                .Top = 213
                .Left = 391
                .Width = 72
                .Height = 15
                .AutoSize = .F.
                .Caption = "Op. Estoque : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label20", "Label")
            WITH loc_oPg.lbl_4c_Label20
                .Top = 256
                .Left = 252
                .Width = 52
                .Height = 15
                .AutoSize = .F.
                .Caption = "M" + CHR(225) + "scara : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label13", "Label")
            WITH loc_oPg.lbl_4c_Label13
                .Top = 323
                .Left = 15
                .Width = 50
                .Height = 15
                .AutoSize = .F.
                .Caption = "Grupo : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label15", "Label")
            WITH loc_oPg.lbl_4c_Label15
                .Top = 304
                .Left = 11
                .Width = 100
                .Height = 15
                .AutoSize = .F.
                .Caption = "Respons" + CHR(225) + "vel "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label19", "Label")
            WITH loc_oPg.lbl_4c_Label19
                .Top = 284
                .Left = 12
                .Width = 91
                .Height = 15
                .AutoSize = .F.
                .Caption = "Tem Respons" + CHR(225) + "vel?"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            * OptionGroups
            loc_oPg.AddObject("obj_4c_Op_Numeracao", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_Numeracao
                .Top = 10
                .Left = 100
                .Width = 373
                .Height = 27
                .ButtonCount = 4
                .Visible = .T.
                WITH .Buttons(1)
                    .Top  = 2
                    .Left = 3
                    .Width = 88
                    .Caption = "Manual"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top  = 2
                    .Left = 94
                    .Width = 88
                    .Caption = "Autom" + CHR(225) + "tica"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top  = 2
                    .Left = 185
                    .Width = 88
                    .Caption = "SubN" + CHR(237) + "vel"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(4)
                    .Top  = 2
                    .Left = 276
                    .Width = 88
                    .Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_origem", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_origem
                .Top = 49
                .Left = 94
                .Width = 106
                .Height = 20
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 54
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_EstOrig", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_EstOrig
                .Top = 87
                .Left = 468
                .Width = 200
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 62
                    .Caption = "Entrada"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 68
                    .Width = 62
                    .Caption = "Sa" + CHR(237) + "da"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 133
                    .Width = 62
                    .Caption = "Nenhuma"
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_ConOSub", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_ConOSub
                .Top = 110
                .Left = 467
                .Width = 201
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 62
                    .Caption = "Origem"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 68
                    .Width = 62
                    .Caption = "Destino"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 133
                    .Width = 62
                    .Caption = "Nenhuma"
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_BxOEst", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_BxOEst
                .Top = 133
                .Left = 467
                .Width = 186
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Prod. Acabado"
                    .Width = 88
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 94
                    .Caption = "Mat. Prima"
                    .Width = 88
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_destino", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_destino
                .Top = 169
                .Left = 94
                .Width = 106
                .Height = 20
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 54
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Get_Repete", "OptionGroup")
            WITH loc_oPg.obj_4c_Get_Repete
                .Top = 169
                .Left = 380
                .Width = 106
                .Height = 20
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 54
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_EstDest", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_EstDest
                .Top = 208
                .Left = 468
                .Width = 200
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 62
                    .Caption = "Entrada"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 68
                    .Width = 62
                    .Caption = "Sa" + CHR(237) + "da"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 133
                    .Width = 62
                    .Caption = "Nenhuma"
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_ConDSub", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_ConDSub
                .Top = 231
                .Left = 468
                .Width = 200
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 62
                    .Caption = "Origem"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 68
                    .Width = 62
                    .Caption = "Destino"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 133
                    .Width = 62
                    .Caption = "Nenhuma"
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_BxDEst", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_BxDEst
                .Top = 254
                .Left = 468
                .Width = 187
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Prod. Acabado"
                    .Width = 88
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 94
                    .Caption = "Mat. Prima"
                    .Width = 88
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_vende", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_vende
                .Top = 282
                .Left = 104
                .Width = 106
                .Height = 20
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 54
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            * CheckBoxes
            loc_oPg.AddObject("chk_4c_Chk_Grupoo", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_Grupoo
                .Top = 89
                .Left = 53
                .Width = 20
                .Height = 19
                .Caption = ""
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_Chk_Contao", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_Contao
                .Top = 110
                .Left = 53
                .Width = 20
                .Height = 19
                .Caption = ""
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_ChkSenhaO", "CheckBox")
            WITH loc_oPg.chk_4c_ChkSenhaO
                .Top = 134
                .Left = 71
                .Width = 120
                .Height = 19
                .Caption = "Verificar Senha"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_Chk_Grupod", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_Grupod
                .Top = 210
                .Left = 53
                .Width = 20
                .Height = 19
                .Caption = ""
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_Chk_Contad", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_Contad
                .Top = 231
                .Left = 53
                .Width = 20
                .Height = 19
                .Caption = ""
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_ChkSenhaD", "CheckBox")
            WITH loc_oPg.chk_4c_ChkSenhaD
                .Top = 255
                .Left = 71
                .Width = 120
                .Height = 19
                .Caption = "Verificar Senha"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_Chk_Grupov", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_Grupov
                .Top = 322
                .Left = 58
                .Width = 20
                .Height = 19
                .Caption = ""
                .Value = 0
                .Visible = .T.
            ENDWITH
            * TextBoxes
            loc_oPg.AddObject("txt_4c_GrupoOrig", "TextBox")
            WITH loc_oPg.txt_4c_GrupoOrig
                .Top = 88
                .Left = 73
                .Width = 78
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Dgrupoo", "TextBox")
            WITH loc_oPg.txt_4c_Dgrupoo
                .Top = 88
                .Left = 152
                .Width = 150
                .Height = 21
                .ReadOnly = .T.
                .DisabledBackColor = RGB(240,240,240)
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_ContaOrig", "TextBox")
            WITH loc_oPg.txt_4c_ContaOrig
                .Top = 109
                .Left = 73
                .Width = 78
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Dcontao", "TextBox")
            WITH loc_oPg.txt_4c_Dcontao
                .Top = 109
                .Left = 152
                .Width = 231
                .Height = 21
                .ReadOnly = .T.
                .DisabledBackColor = RGB(240,240,240)
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Mascos", "TextBox")
            WITH loc_oPg.txt_4c_Mascos
                .Top = 131
                .Left = 305
                .Width = 78
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_GrupoDest", "TextBox")
            WITH loc_oPg.txt_4c_GrupoDest
                .Top = 209
                .Left = 73
                .Width = 78
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Dgrupod", "TextBox")
            WITH loc_oPg.txt_4c_Dgrupod
                .Top = 209
                .Left = 152
                .Width = 150
                .Height = 21
                .ReadOnly = .T.
                .DisabledBackColor = RGB(240,240,240)
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_ContaDest", "TextBox")
            WITH loc_oPg.txt_4c_ContaDest
                .Top = 230
                .Left = 73
                .Width = 78
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Dcontad", "TextBox")
            WITH loc_oPg.txt_4c_Dcontad
                .Top = 230
                .Left = 152
                .Width = 231
                .Height = 21
                .ReadOnly = .T.
                .DisabledBackColor = RGB(240,240,240)
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Mascds", "TextBox")
            WITH loc_oPg.txt_4c_Mascds
                .Top = 253
                .Left = 304
                .Width = 78
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_GrupoVend", "TextBox")
            WITH loc_oPg.txt_4c_GrupoVend
                .Top = 321
                .Left = 78
                .Width = 78
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Dgrupov", "TextBox")
            WITH loc_oPg.txt_4c_Dgrupov
                .Top = 321
                .Left = 157
                .Width = 150
                .Height = 21
                .ReadOnly = .T.
                .DisabledBackColor = RGB(240,240,240)
                .Visible = .T.
            ENDWITH
            * ComboBox
            loc_oPg.AddObject("cbo_4c_CmbTOpers", "ComboBox")
            WITH loc_oPg.cbo_4c_CmbTOpers
                .Top = 11
                .Left = 630
                .Width = 208
                .Height = 24
                .Style = 2
                .Visible = .T.
            ENDWITH
            * Popula ComboBox Tipo Operacao (SigCdToi)
            LOCAL loc_cSqlToi, loc_nResToi, loc_cCodToi
            loc_cSqlToi = "SELECT Codigos, Descrs FROM SigCdToi ORDER BY Codigos"
            loc_nResToi = SQLEXEC(gnConnHandle, loc_cSqlToi, "cursor_4c_Toi")
            IF loc_nResToi >= 0
                SELECT cursor_4c_Toi
                SCAN
                    IF VARTYPE(cursor_4c_Toi.Codigos) = "N"
                        loc_cCodToi = PADL(ALLTRIM(cursor_4c_Toi.Codigos), 2, "0")
                    ELSE
                        loc_cCodToi = PADL(ALLTRIM(cursor_4c_Toi.Codigos), 2, "0")
                    ENDIF
                    loc_oPg.cbo_4c_CmbTOpers.AddItem(loc_cCodToi + "-" + ALLTRIM(cursor_4c_Toi.Descrs))
                ENDSCAN
                IF USED("cursor_4c_Toi")
                    USE IN cursor_4c_Toi
                ENDIF
            ENDIF
            * BINDEVENTs lookups Estoque
            BINDEVENT(loc_oPg.txt_4c_GrupoOrig, "KeyPress", THIS, "GrupoOrigKeyPress")
            BINDEVENT(loc_oPg.txt_4c_GrupoOrig, "DblClick", THIS, "AbrirLookupGrupoOrig")
            BINDEVENT(loc_oPg.txt_4c_ContaOrig, "KeyPress", THIS, "ContaOrigKeyPress")
            BINDEVENT(loc_oPg.txt_4c_ContaOrig, "DblClick", THIS, "AbrirLookupContaOrig")
            BINDEVENT(loc_oPg.txt_4c_GrupoDest, "KeyPress", THIS, "GrupoDestKeyPress")
            BINDEVENT(loc_oPg.txt_4c_GrupoDest, "DblClick", THIS, "AbrirLookupGrupoDest")
            BINDEVENT(loc_oPg.txt_4c_ContaDest, "KeyPress", THIS, "ContaDestKeyPress")
            BINDEVENT(loc_oPg.txt_4c_ContaDest, "DblClick", THIS, "AbrirLookupContaDest")
            BINDEVENT(loc_oPg.txt_4c_GrupoVend, "KeyPress", THIS, "GrupoVendKeyPress")
            BINDEVENT(loc_oPg.txt_4c_GrupoVend, "DblClick", THIS, "AbrirLookupGrupoVend")
            * BINDEVENTs comportamento interativo Estoque
            BINDEVENT(loc_oPg.obj_4c_Op_origem,  "InteractiveChange", THIS, "OpOrigemChange")
            BINDEVENT(loc_oPg.obj_4c_Op_destino, "InteractiveChange", THIS, "OpDestinoChange")
            BINDEVENT(loc_oPg.obj_4c_Op_vende,   "InteractiveChange", THIS, "OpVendeChange")
            BINDEVENT(loc_oPg.obj_4c_Op_EstOrig, "InteractiveChange", THIS, "OpEstOrigChange")
            BINDEVENT(loc_oPg.obj_4c_Op_EstDest, "InteractiveChange", THIS, "OpEstDestChange")
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarPgEstoque")
        ENDTRY
    ENDPROC

    * ============================================================
    * ConfigurarPgComponente
    * ============================================================
    PROTECTED PROCEDURE ConfigurarPgComponente()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
        TRY
            * Labels
            loc_oPg.AddObject("lbl_4c_Label15", "Label")
            WITH loc_oPg.lbl_4c_Label15
                .Top = 13
                .Left = 38
                .Width = 145
                .Height = 15
                .AutoSize = .F.
                .Caption = "Grade Ordens de Produ" + CHR(231) + CHR(227) + "o : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label14", "Label")
            WITH loc_oPg.lbl_4c_Label14
                .Top = 33
                .Left = 55
                .Width = 130
                .Height = 15
                .AutoSize = .F.
                .Caption = "Grade de Componentes : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPg.lbl_4c_Label5
                .Top = 53
                .Left = 64
                .Width = 115
                .Height = 15
                .AutoSize = .F.
                .Caption = "Agrupa Componentes : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPg.lbl_4c_Label8
                .Top = 73
                .Left = 66
                .Width = 113
                .Height = 15
                .AutoSize = .F.
                .Caption = "Separa" + CHR(231) + CHR(227) + "o de Pedras : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label12", "Label")
            WITH loc_oPg.lbl_4c_Label12
                .Top = 13
                .Left = 487
                .Width = 135
                .Height = 15
                .AutoSize = .F.
                .Caption = "Tipo de Opera" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label35", "Label")
            WITH loc_oPg.lbl_4c_Label35
                .Top = 35
                .Left = 507
                .Width = 115
                .Height = 15
                .AutoSize = .F.
                .Caption = "Opera" + CHR(231) + CHR(227) + "o de Retalho : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPg.lbl_4c_Label6
                .Top = 56
                .Left = 548
                .Width = 75
                .Height = 15
                .AutoSize = .F.
                .Caption = "Fase do PCC : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPg.lbl_4c_Label4
                .Top = 105
                .Left = 529
                .Width = 95
                .Height = 15
                .AutoSize = .F.
                .Caption = "Checar Fundi" + CHR(231) + CHR(227) + "o : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPg.lbl_4c_Label2
                .Top = 124
                .Left = 545
                .Width = 80
                .Height = 15
                .AutoSize = .F.
                .Caption = "Peso Vari" + CHR(225) + "vel : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPg.lbl_4c_Label7
                .Top = 161
                .Left = 512
                .Width = 112
                .Height = 15
                .AutoSize = .F.
                .Caption = "Pagamento Servi" + CHR(231) + "os : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPg.lbl_4c_Label9
                .Top = 181
                .Left = 555
                .Width = 70
                .Height = 15
                .AutoSize = .F.
                .Caption = "Mensagens : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPg.lbl_4c_Label10
                .Top = 201
                .Left = 508
                .Width = 117
                .Height = 15
                .AutoSize = .F.
                .Caption = "Envelope Obrigat" + CHR(243) + "rio : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label21", "Label")
            WITH loc_oPg.lbl_4c_Label21
                .Top = 191
                .Left = 78
                .Width = 107
                .Height = 15
                .AutoSize = .F.
                .Caption = "Diferen" + CHR(231) + "a de  Peso : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label11", "Label")
            WITH loc_oPg.lbl_4c_Label11
                .Top = 242
                .Left = 488
                .Width = 137
                .Height = 15
                .AutoSize = .F.
                .Caption = "Peso somente via Balan" + CHR(231) + "a: "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPg.lbl_4c_Label3
                .Top = 274
                .Left = 85
                .Width = 95
                .Height = 15
                .AutoSize = .F.
                .Caption = "Grupo Transit" + CHR(243) + "rio : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label13", "Label")
            WITH loc_oPg.lbl_4c_Label13
                .Top = 310
                .Left = 29
                .Width = 150
                .Height = 15
                .AutoSize = .F.
                .Caption = "Checar Separa" + CHR(231) + CHR(227) + "o de Pedras : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Top = 359
                .Left = 128
                .Width = 55
                .Height = 15
                .AutoSize = .F.
                .Caption = "Etiqueta : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPg.lbl_4c_Label16
                .Top = 380
                .Left = 71
                .Width = 110
                .Height = 15
                .AutoSize = .F.
                .Caption = "Desagregar Material : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label17", "Label")
            WITH loc_oPg.lbl_4c_Label17
                .Top = 416
                .Left = 25
                .Width = 155
                .Height = 15
                .AutoSize = .F.
                .Caption = "Quebra Impress" + CHR(227) + "o por Pedido : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label18", "Label")
            WITH loc_oPg.lbl_4c_Label18
                .Top = 259
                .Left = 539
                .Width = 90
                .Height = 15
                .AutoSize = .F.
                .Caption = "Transfere Peso:"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label19", "Label")
            WITH loc_oPg.lbl_4c_Label19
                .Top = 254
                .Left = 81
                .Width = 100
                .Height = 15
                .AutoSize = .F.
                .Caption = "Crava" + CHR(231) + CHR(227) + "o na Cera : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label20", "Label")
            WITH loc_oPg.lbl_4c_Label20
                .Top = 127
                .Left = 51
                .Width = 135
                .Height = 15
                .AutoSize = .F.
                .Caption = "% toler" + CHR(226) + "ncia Sep. Pedra : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label22", "Label")
            WITH loc_oPg.lbl_4c_Label22
                .Top = 168
                .Left = 70
                .Width = 115
                .Height = 15
                .AutoSize = .F.
                .Caption = "Limite de Qtd Por Os : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label23", "Label")
            WITH loc_oPg.lbl_4c_Label23
                .Top = 190
                .Left = 322
                .Width = 40
                .Height = 15
                .AutoSize = .F.
                .Caption = "( P/Q )"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label24", "Label")
            WITH loc_oPg.lbl_4c_Label24
                .Top = 233
                .Left = 60
                .Width = 120
                .Height = 15
                .AutoSize = .F.
                .Caption = "Solicita  Cod.Libera" + CHR(231) + CHR(227) + "o : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label25", "Label")
            WITH loc_oPg.lbl_4c_Label25
                .Top = 221
                .Left = 491
                .Width = 135
                .Height = 15
                .AutoSize = .F.
                .Caption = "Valor do Item Obrigat" + CHR(243) + "rio :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label26", "Label")
            WITH loc_oPg.lbl_4c_Label26
                .Top = 147
                .Left = 35
                .Width = 145
                .Height = 15
                .AutoSize = .F.
                .Caption = "Baixar Pedras na Finaliza" + CHR(231) + CHR(227) + "o :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label27", "Label")
            WITH loc_oPg.lbl_4c_Label27
                .Top = 356
                .Left = 542
                .Width = 80
                .Height = 15
                .AutoSize = .F.
                .Caption = "Bloqueia Qtde : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label28", "Label")
            WITH loc_oPg.lbl_4c_Label28
                .Top = 80
                .Left = 537
                .Width = 90
                .Height = 15
                .AutoSize = .F.
                .Caption = "Material Padr" + CHR(227) + "o :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label29", "Label")
            WITH loc_oPg.lbl_4c_Label29
                .Top = 214
                .Left = 60
                .Width = 120
                .Height = 15
                .AutoSize = .F.
                .Caption = "Checar Somente Metal : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label30", "Label")
            WITH loc_oPg.lbl_4c_Label30
                .Top = 376
                .Left = 535
                .Width = 80
                .Height = 15
                .AutoSize = .F.
                .Caption = "Resumo por OP : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label31", "Label")
            WITH loc_oPg.lbl_4c_Label31
                .Top = 396
                .Left = 458
                .Width = 170
                .Height = 15
                .AutoSize = .F.
                .Caption = "Permite Mat. Principal Diferente : "
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            * OptionGroups
            loc_oPg.AddObject("obj_4c_Op_grprod", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_grprod
                .Top = 9
                .Left = 183
                .Width = 92
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_grcomp", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_grcomp
                .Top = 29
                .Left = 183
                .Width = 92
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_compagru", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_compagru
                .Top = 49
                .Left = 183
                .Width = 178
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 55
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 61
                    .Width = 55
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 119
                    .Width = 55
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_SepPedra", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_SepPedra
                .Top = 69
                .Left = 183
                .Width = 140
                .Height = 42
                .ButtonCount = 4
                .Visible = .T.
                WITH .Buttons(1)
                    .Left = 3
                    .Top = 2
                    .Width = 65
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Left = 71
                    .Top = 2
                    .Width = 65
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Left = 3
                    .Top = 22
                    .Width = 65
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(4)
                    .Left = 71
                    .Top = 22
                    .Width = 65
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_OptBxPedFins", "OptionGroup")
            WITH loc_oPg.obj_4c_OptBxPedFins
                .Top = 142
                .Left = 182
                .Width = 107
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 54
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_GrTrans", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_GrTrans
                .Top = 270
                .Left = 182
                .Width = 133
                .Height = 40
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Left = 3
                    .Top = 2
                    .Width = 40
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Left = 46
                    .Top = 2
                    .Width = 40
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Left = 3
                    .Top = 22
                    .Width = 83
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_ObjChkQP", "OptionGroup")
            WITH loc_oPg.obj_4c_ObjChkQP
                .Top = 306
                .Left = 182
                .Width = 171
                .Height = 39
                .ButtonCount = 4
                .Visible = .T.
                WITH .Buttons(1)
                    .Left = 3
                    .Top = 2
                    .Width = 80
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Left = 86
                    .Top = 2
                    .Width = 80
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Left = 3
                    .Top = 22
                    .Width = 80
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(4)
                    .Left = 86
                    .Top = 22
                    .Width = 80
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_ObjReinop", "OptionGroup")
            WITH loc_oPg.obj_4c_ObjReinop
                .Top = 378
                .Left = 182
                .Width = 204
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 68
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 133
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Op_etiq", "OptionGroup")
            WITH loc_oPg.obj_4c_Op_etiq
                .Top = 356
                .Left = 182
                .Width = 275
                .Height = 25
                .ButtonCount = 4
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 65
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 71
                    .Width = 65
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 139
                    .Width = 65
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(4)
                    .Top = 2
                    .Left = 207
                    .Width = 65
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opt_quebraimp", "OptionGroup")
            WITH loc_oPg.obj_4c_Opt_quebraimp
                .Top = 412
                .Left = 182
                .Width = 92
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opt_codlib", "OptionGroup")
            WITH loc_oPg.obj_4c_Opt_codlib
                .Top = 229
                .Left = 182
                .Width = 92
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opt_cravacera", "OptionGroup")
            WITH loc_oPg.obj_4c_Opt_cravacera
                .Top = 250
                .Left = 182
                .Width = 92
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption2
                .Top = 210
                .Left = 181
                .Width = 92
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            * Right column OptionGroups
            loc_oPg.AddObject("obj_4c_Opc_Chkf", "OptionGroup")
            WITH loc_oPg.obj_4c_Opc_Chkf
                .Top = 100
                .Left = 626
                .Width = 110
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 54
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opc_fix", "OptionGroup")
            WITH loc_oPg.obj_4c_Opc_fix
                .Top = 119
                .Left = 626
                .Width = 202
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 68
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 133
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opc_PagSer", "OptionGroup")
            WITH loc_oPg.obj_4c_Opc_PagSer
                .Top = 155
                .Left = 626
                .Width = 206
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 68
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 133
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opc_mens", "OptionGroup")
            WITH loc_oPg.obj_4c_Opc_mens
                .Top = 175
                .Left = 626
                .Width = 110
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 54
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption1
                .Top = 215
                .Left = 626
                .Width = 209
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 96
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 102
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 96
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opc_env", "OptionGroup")
            WITH loc_oPg.obj_4c_Opc_env
                .Top = 195
                .Left = 626
                .Width = 209
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 68
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 133
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Opc_pesobal", "OptionGroup")
            WITH loc_oPg.obj_4c_Opc_pesobal
                .Top = 236
                .Left = 626
                .Width = 209
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 68
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 133
                    .Width = 62
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Chk_TrfPeso", "OptionGroup")
            WITH loc_oPg.obj_4c_Chk_TrfPeso
                .Top = 253
                .Left = 626
                .Width = 203
                .Height = 87
                .ButtonCount = 7
                .Visible = .T.
                WITH .Buttons(1)
                    .Left = 3
                    .Top = 2
                    .Width = 95
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Left = 101
                    .Top = 2
                    .Width = 95
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Left = 3
                    .Top = 18
                    .Width = 95
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(4)
                    .Left = 101
                    .Top = 18
                    .Width = 95
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(5)
                    .Left = 3
                    .Top = 34
                    .Width = 95
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(6)
                    .Left = 101
                    .Top = 34
                    .Width = 95
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(7)
                    .Left = 3
                    .Top = 50
                    .Width = 193
                    .Height = 14
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Optqtdneg", "OptionGroup")
            WITH loc_oPg.obj_4c_Optqtdneg
                .Top = 351
                .Left = 626
                .Width = 291
                .Height = 25
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 90
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 96
                    .Width = 90
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 189
                    .Width = 90
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption3
                .Top = 370
                .Left = 626
                .Width = 110
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 54
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_OptMatPrncDif", "OptionGroup")
            WITH loc_oPg.obj_4c_OptMatPrncDif
                .Top = 390
                .Left = 627
                .Width = 110
                .Height = 25
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 54
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 48
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            * CheckBoxes
            loc_oPg.AddObject("chk_4c_ChkCarQtde", "CheckBox")
            WITH loc_oPg.chk_4c_ChkCarQtde
                .Top = 105
                .Left = 199
                .Width = 160
                .Height = 19
                .Caption = "N" + CHR(227) + "o carrega Qtde e Peso"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_OptChkPeso", "CheckBox")
            WITH loc_oPg.chk_4c_OptChkPeso
                .Top = 339
                .Left = 198
                .Width = 80
                .Height = 19
                .Caption = "Checa peso"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_Chk_LibRein", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_LibRein
                .Top = 398
                .Left = 198
                .Width = 145
                .Height = 19
                .Caption = "Liberar Peso/Qtde (+/-)"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_ObjAgSep", "CheckBox")
            WITH loc_oPg.chk_4c_ObjAgSep
                .Top = 337
                .Left = 632
                .Width = 120
                .Height = 19
                .Caption = "Agrupa Sep. Pedra"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_ChkMatPrinc", "CheckBox")
            WITH loc_oPg.chk_4c_ChkMatPrinc
                .Top = 81
                .Left = 738
                .Width = 180
                .Height = 19
                .Caption = "Checar Material Principal"
                .Value = 0
                .Visible = .T.
            ENDWITH
            * TextBoxes
            loc_oPg.AddObject("txt_4c_TpPadrao", "TextBox")
            WITH loc_oPg.txt_4c_TpPadrao
                .Top = 10
                .Left = 624
                .Width = 150
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Retalho", "TextBox")
            WITH loc_oPg.txt_4c_Retalho
                .Top = 32
                .Left = 624
                .Width = 150
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_GrupoPcc", "TextBox")
            WITH loc_oPg.txt_4c_GrupoPcc
                .Top = 54
                .Left = 624
                .Width = 78
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c__produto", "TextBox")
            WITH loc_oPg.txt_4c__produto
                .Top = 77
                .Left = 623
                .Width = 108
                .Height = 23
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Difp", "TextBox")
            WITH loc_oPg.txt_4c_Difp
                .Top = 123
                .Left = 186
                .Width = 58
                .Height = 23
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c__limqtd", "TextBox")
            WITH loc_oPg.txt_4c__limqtd
                .Top = 166
                .Left = 186
                .Width = 80
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_DifPeso", "TextBox")
            WITH loc_oPg.txt_4c_DifPeso
                .Top = 187
                .Left = 186
                .Width = 68
                .Height = 23
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Tfalhas", "TextBox")
            WITH loc_oPg.txt_4c_Tfalhas
                .Top = 187
                .Left = 305
                .Width = 17
                .Height = 23
                .Visible = .T.
            ENDWITH
            * ComboBox
            loc_oPg.AddObject("cbo_4c_Get_Sinal", "ComboBox")
            WITH loc_oPg.cbo_4c_Get_Sinal
                .Top = 187
                .Left = 255
                .Width = 48
                .Height = 24
                .Style = 2
                .Visible = .T.
                .AddItem("+")
                .AddItem("-")
            ENDWITH
            * BINDEVENTs lookups Componente
            BINDEVENT(loc_oPg.txt_4c_TpPadrao, "KeyPress", THIS, "TpPadraoKeyPress")
            BINDEVENT(loc_oPg.txt_4c_TpPadrao, "DblClick", THIS, "AbrirLookupTpPadrao")
            BINDEVENT(loc_oPg.txt_4c_Retalho,  "KeyPress", THIS, "RetalhoKeyPress")
            BINDEVENT(loc_oPg.txt_4c_Retalho,  "DblClick", THIS, "AbrirLookupRetalho")
            BINDEVENT(loc_oPg.txt_4c_GrupoPcc, "KeyPress", THIS, "GrupoPccKeyPress")
            BINDEVENT(loc_oPg.txt_4c_GrupoPcc, "DblClick", THIS, "AbrirLookupGrupoPcc")
            BINDEVENT(loc_oPg.txt_4c__produto,  "KeyPress", THIS, "ProdutoKeyPress")
            BINDEVENT(loc_oPg.txt_4c__produto,  "DblClick", THIS, "AbrirLookupProduto")
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarPgComponente")
        ENDTRY
    ENDPROC

    * ============================================================
    * ConfigurarPgDocumento
    * ============================================================
    PROTECTED PROCEDURE ConfigurarPgDocumento()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page4
        TRY
            loc_oPg.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPg.shp_4c_Shape1
                .Top           = 26
                .Left          = 23
                .Width         = 329
                .Height        = 131
                .BackStyle     = 0
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label25", "Label")
            WITH loc_oPg.lbl_4c_Label25
                .Top      = 35
                .Left     = 33
                .Width    = 119
                .Height   = 15
                .AutoSize = .F.
                .FontBold = .T.
                .Caption  = "Impress" + CHR(227) + "o de Boleto"
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Top = 69
                .Left = 88
                .Width = 64
                .Height = 15
                .AutoSize = .F.
                .Caption = "Imprimir OP :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPg.lbl_4c_Label2
                .Top = 95
                .Left = 64
                .Width = 88
                .Height = 15
                .AutoSize = .F.
                .Caption = "Imprimir Material :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPg.lbl_4c_Label3
                .Top = 122
                .Left = 67
                .Width = 85
                .Height = 15
                .AutoSize = .F.
                .Caption = "Imprimir Servi" + CHR(231) + "o :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("obj_4c_Optiongroup1", "OptionGroup")
            WITH loc_oPg.obj_4c_Optiongroup1
                .Top = 64
                .Left = 176
                .Width = 102
                .Height = 26
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 44
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 50
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 44
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Optiongroup2", "OptionGroup")
            WITH loc_oPg.obj_4c_Optiongroup2
                .Top = 90
                .Left = 176
                .Width = 164
                .Height = 26
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top     = 2
                    .Left    = 3
                    .Width   = 50
                    .Caption = "Sim"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top     = 2
                    .Left    = 56
                    .Width   = 50
                    .Caption = "N" + CHR(227) + "o"
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top     = 2
                    .Left    = 109
                    .Width   = 50
                    .Caption = "Pedra"
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Optiongroup3", "OptionGroup")
            WITH loc_oPg.obj_4c_Optiongroup3
                .Top = 116
                .Left = 176
                .Width = 102
                .Height = 26
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 44
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 50
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 44
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarPgDocumento")
        ENDTRY
    ENDPROC

    * ============================================================
    * ConfigurarPgDiversas
    * ============================================================
    PROTECTED PROCEDURE ConfigurarPgDiversas()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
        TRY
            * Line
            loc_oPg.AddObject("lin_4c_Line1", "Line")
            WITH loc_oPg.lin_4c_Line1
                .Top = 11
                .Left = 591
                .Width = 0
                .Height = 418
                .Visible = .T.
            ENDWITH
            * Labels
            loc_oPg.AddObject("lbl_4c_Label26", "Label")
            WITH loc_oPg.lbl_4c_Label26
                .Top = 16
                .Left = 8
                .Width = 101
                .Height = 15
                .AutoSize = .F.
                .Caption = "Casas Decimais qtd :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_LblObspads", "Label")
            WITH loc_oPg.lbl_4c_LblObspads
                .Top = 45
                .Left = 12
                .Width = 104
                .Height = 15
                .AutoSize = .F.
                .Caption = "Observa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPg.lbl_4c_Label6
                .Top = 45
                .Left = 160
                .Width = 22
                .Height = 15
                .AutoSize = .F.
                .Caption = "De :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPg.lbl_4c_Label10
                .Top = 45
                .Left = 217
                .Width = 18
                .Height = 15
                .AutoSize = .F.
                .Caption = "at" + CHR(233)
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label17", "Label")
            WITH loc_oPg.lbl_4c_Label17
                .Top = 72
                .Left = 12
                .Width = 170
                .Height = 15
                .AutoSize = .F.
                .Caption = "Checar Unidade  p/gerar Etiqueta :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Top = 93
                .Left = 29
                .Width = 150
                .Height = 15
                .AutoSize = .F.
                .Caption = "Divis" + CHR(227) + "o de Op C/Envelopagem :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label13", "Label")
            WITH loc_oPg.lbl_4c_Label13
                .Top = 117
                .Left = 40
                .Width = 142
                .Height = 15
                .AutoSize = .F.
                .Caption = "Tipo de Ordem de Produ" + CHR(231) + CHR(227) + "o :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPg.lbl_4c_Label8
                .Top = 144
                .Left = 92
                .Width = 90
                .Height = 15
                .AutoSize = .F.
                .Caption = "Grupo Financeiro :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label35", "Label")
            WITH loc_oPg.lbl_4c_Label35
                .Top = 170
                .Left = 74
                .Width = 108
                .Height = 15
                .AutoSize = .F.
                .Caption = "Opera" + CHR(231) + CHR(227) + "o do Contas :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPg.lbl_4c_Label2
                .Top = 197
                .Left = 32
                .Width = 145
                .Height = 15
                .AutoSize = .F.
                .Caption = "Aceite - Agrupa por Envelope :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPg.lbl_4c_Label3
                .Top = 221
                .Left = 88
                .Width = 90
                .Height = 15
                .AutoSize = .F.
                .Caption = "Controle de Lotes :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPg.lbl_4c_Label16
                .Top = 254
                .Left = 119
                .Width = 63
                .Height = 15
                .AutoSize = .F.
                .Caption = "Grupo C.C. :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPg.lbl_4c_Label4
                .Top = 278
                .Left = 119
                .Width = 63
                .Height = 15
                .AutoSize = .F.
                .Caption = "Conta C.C. :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label25", "Label")
            WITH loc_oPg.lbl_4c_Label25
                .Top = 318
                .Left = 55
                .Width = 128
                .Height = 15
                .AutoSize = .F.
                .Caption = "Opera" + CHR(231) + CHR(227) + "o Semiacabados :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPg.lbl_4c_Label5
                .Top = 341
                .Left = 93
                .Width = 85
                .Height = 15
                .AutoSize = .F.
                .Caption = "Utiliza Peso Total :"
                .BackStyle = 0
                .Visible = .T.
            ENDWITH
            * Spinner
            loc_oPg.AddObject("obj_4c_Spn_NCqtd", "Spinner")
            WITH loc_oPg.obj_4c_Spn_NCqtd
                .Top = 11
                .Left = 111
                .Width = 52
                .Height = 25
                .SpinnerLowValue = 0
                .SpinnerHighValue = 9
                .Increment = 1
                .Visible = .T.
            ENDWITH
            * TextBoxes
            loc_oPg.AddObject("txt_4c_Obspads", "TextBox")
            WITH loc_oPg.txt_4c_Obspads
                .Top = 42
                .Left = 121
                .Width = 31
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_ObsInis", "TextBox")
            WITH loc_oPg.txt_4c_ObsInis
                .Top = 42
                .Left = 182
                .Width = 31
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_ObsFins", "TextBox")
            WITH loc_oPg.txt_4c_ObsFins
                .Top = 42
                .Left = 236
                .Width = 31
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_TpOp", "TextBox")
            WITH loc_oPg.txt_4c_TpOp
                .Top = 113
                .Left = 187
                .Width = 80
                .Height = 23
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_GruFin", "TextBox")
            WITH loc_oPg.txt_4c_GruFin
                .Top = 140
                .Left = 187
                .Width = 80
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_DGruFin", "TextBox")
            WITH loc_oPg.txt_4c_DGruFin
                .Top = 140
                .Left = 270
                .Width = 150
                .Height = 21
                .ReadOnly = .T.
                .DisabledBackColor = RGB(240,240,240)
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_OpConta", "TextBox")
            WITH loc_oPg.txt_4c_OpConta
                .Top = 168
                .Left = 187
                .Width = 233
                .Height = 21
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c__gruccus", "TextBox")
            WITH loc_oPg.txt_4c__gruccus
                .Top = 250
                .Left = 186
                .Width = 80
                .Height = 23
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
            WITH loc_oPg.txt_4c__dgruccus
                .Top = 250
                .Left = 268
                .Width = 318
                .Height = 23
                .ReadOnly = .T.
                .DisabledBackColor = RGB(240,240,240)
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
            WITH loc_oPg.txt_4c__contaccus
                .Top = 275
                .Left = 186
                .Width = 80
                .Height = 23
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
            WITH loc_oPg.txt_4c__dcontaccus
                .Top = 275
                .Left = 268
                .Width = 318
                .Height = 23
                .ReadOnly = .T.
                .DisabledBackColor = RGB(240,240,240)
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("txt_4c_Semi", "TextBox")
            WITH loc_oPg.txt_4c_Semi
                .Top = 315
                .Left = 186
                .Width = 134
                .Height = 23
                .Visible = .T.
            ENDWITH
            * OptionGroups
            loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption1
                .Top = 71
                .Left = 181
                .Width = 92
                .Height = 20
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption2
                .Top = 92
                .Left = 181
                .Width = 92
                .Height = 20
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption3
                .Top = 196
                .Left = 180
                .Width = 92
                .Height = 20
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption4
                .Top = 220
                .Left = 180
                .Width = 92
                .Height = 20
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 46
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 40
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption5
                .Top = 338
                .Left = 184
                .Width = 182
                .Height = 21
                .ButtonCount = 3
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Width = 55
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 61
                    .Width = 55
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Top = 2
                    .Left = 119
                    .Width = 55
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            loc_oPg.AddObject("obj_4c_Optiongroup1", "OptionGroup")
            WITH loc_oPg.obj_4c_Optiongroup1
                .Top = 80
                .Left = 818
                .Width = 119
                .Height = 19
                .ButtonCount = 2
                .Visible = .T.
                WITH .Buttons(1)
                    .Top = 2
                    .Left = 3
                    .Caption = "Sim"
                    .Width = 54
                    .AutoSize = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Top = 2
                    .Left = 60
                    .Caption = "N" + CHR(227) + "o"
                    .Width = 54
                    .AutoSize = .F.
                ENDWITH
            ENDWITH
            * CheckBoxes
            loc_oPg.AddObject("chk_4c_Chk_Pcc", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_Pcc
                .Top = 12
                .Left = 604
                .Width = 200
                .Height = 19
                .Caption = "Marcar OP como cancelada"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_Chk_imp", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_imp
                .Top = 29
                .Left = 604
                .Width = 250
                .Height = 19
                .Caption = "Imprimir Somente Peso do Material Principal"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_Chk_InibAlt", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_InibAlt
                .Top = 46
                .Left = 604
                .Width = 280
                .Height = 19
                .Caption = "Inibir Inserir/Alterar/Excluir Dos Componentes"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
            WITH loc_oPg.chk_4c_Fwcheckbox1
                .Top = 64
                .Left = 604
                .Width = 230
                .Height = 19
                .Caption = "Checar Conta Destino (Sep.Pedra)"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_Fwcheckbox8", "CheckBox")
            WITH loc_oPg.chk_4c_Fwcheckbox8
                .Top = 81
                .Left = 604
                .Width = 210
                .Height = 19
                .Caption = "Pedir Senha para Exclus" + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o"
                .Value = 0
                .Visible = .T.
            ENDWITH
            loc_oPg.AddObject("chk_4c_ChkOpLote", "CheckBox")
            WITH loc_oPg.chk_4c_ChkOpLote
                .Top = 223
                .Left = 337
                .Width = 135
                .Height = 19
                .Caption = "Checar OP do Lote"
                .Value = 0
                .Visible = .T.
            ENDWITH
            * BINDEVENTs lookups Diversas
            BINDEVENT(loc_oPg.txt_4c_Obspads,   "KeyPress", THIS, "ObspadsKeyPress")
            BINDEVENT(loc_oPg.txt_4c_Obspads,   "DblClick", THIS, "AbrirLookupObspads")
            BINDEVENT(loc_oPg.txt_4c_ObsInis,   "KeyPress", THIS, "ObsInisKeyPress")
            BINDEVENT(loc_oPg.txt_4c_ObsInis,   "DblClick", THIS, "AbrirLookupObsInis")
            BINDEVENT(loc_oPg.txt_4c_ObsFins,   "KeyPress", THIS, "ObsFinsKeyPress")
            BINDEVENT(loc_oPg.txt_4c_ObsFins,   "DblClick", THIS, "AbrirLookupObsFins")
            BINDEVENT(loc_oPg.txt_4c_GruFin,    "KeyPress", THIS, "GruFinKeyPress")
            BINDEVENT(loc_oPg.txt_4c_GruFin,    "DblClick", THIS, "AbrirLookupGruFin")
            BINDEVENT(loc_oPg.txt_4c_OpConta,   "KeyPress", THIS, "OpContaKeyPress")
            BINDEVENT(loc_oPg.txt_4c_OpConta,   "DblClick", THIS, "AbrirLookupOpConta")
            BINDEVENT(loc_oPg.txt_4c_TpOp,      "KeyPress", THIS, "TpOpKeyPress")
            BINDEVENT(loc_oPg.txt_4c_TpOp,      "DblClick", THIS, "AbrirLookupTpOp")
            BINDEVENT(loc_oPg.txt_4c__gruccus,  "KeyPress", THIS, "GruccusKeyPress")
            BINDEVENT(loc_oPg.txt_4c__gruccus,  "DblClick", THIS, "AbrirLookupGruccus")
            BINDEVENT(loc_oPg.txt_4c__contaccus,"KeyPress", THIS, "ContaccusKeyPress")
            BINDEVENT(loc_oPg.txt_4c__contaccus,"DblClick", THIS, "AbrirLookupContaccus")
            BINDEVENT(loc_oPg.txt_4c_Semi,      "KeyPress", THIS, "SemiKeyPress")
            BINDEVENT(loc_oPg.txt_4c_Semi,      "DblClick", THIS, "AbrirLookupSemi")
        CATCH TO loException
            MostrarErro(loException, "FormMPD.ConfigurarPgDiversas")
        ENDTRY
    ENDPROC

    * ============================================================
    * FormParaBO
    * ============================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPD, loc_oPOp, loc_oPEst, loc_oPCom, loc_oPDoc, loc_oPDiv
        TRY
            loc_oPD   = THIS.pgf_4c_Paginas.Page2
            loc_oPOp  = loc_oPD.pgf_4c_PagDados.Page1
            loc_oPEst = loc_oPD.pgf_4c_PagDados.Page2
            loc_oPCom = loc_oPD.pgf_4c_PagDados.Page3
            loc_oPDoc = loc_oPD.pgf_4c_PagDados.Page4
            loc_oPDiv = loc_oPD.pgf_4c_PagDados.Page5
            * Header
            THIS.this_oBusinessObject.this_cDopps  = ALLTRIM(loc_oPD.txt_4c_Desc.Value)
            THIS.this_oBusinessObject.this_nNdopps = ALLTRIM(STR(loc_oPD.txt_4c_Nope.Value))
            THIS.this_oBusinessObject.this_nOrdes  = ALLTRIM(STR(loc_oPD.txt_4c_Ordem.Value))
            * Aba Operacao
            THIS.this_oBusinessObject.this_nImagems    = loc_oPOp.obj_4c_Op_imagem.Value
            THIS.this_oBusinessObject.this_nBoletos    = loc_oPOp.obj_4c_Op_boleto.Value
            THIS.this_oBusinessObject.this_nDocus      = loc_oPOp.obj_4c_Fwoption8.Value
            THIS.this_oBusinessObject.this_nBolops     = loc_oPOp.obj_4c_Fwoption5.Value
            THIS.this_oBusinessObject.this_nBolcomps   = loc_oPOp.obj_4c_Opt_compo.Value
            THIS.this_oBusinessObject.this_nMenus      = loc_oPOp.obj_4c_Opt_Menu.Value
            THIS.this_oBusinessObject.this_nAutos      = loc_oPOp.obj_4c_ObjAutos.Value
            THIS.this_oBusinessObject.this_cHists      = ALLTRIM(loc_oPOp.txt_4c_Hists.Value)
            THIS.this_oBusinessObject.this_nChktemsubn = loc_oPOp.obj_4c_Op_subn.Value
            THIS.this_oBusinessObject.this_cNivels     = ALLTRIM(loc_oPOp.txt_4c_Nivel.Value)
            THIS.this_oBusinessObject.this_cTnivels    = ALLTRIM(loc_oPOp.txt_4c_Titulo.Value)
            THIS.this_oBusinessObject.this_cArtigos    = ALLTRIM(loc_oPOp.txt_4c_Artigo.Value)
            THIS.this_oBusinessObject.this_nBxautos    = loc_oPOp.obj_4c_Op_BxAuto.Value
            THIS.this_oBusinessObject.this_nExclsubns  = loc_oPOp.obj_4c_Fwoption2.Value
            THIS.this_oBusinessObject.this_nChktemsubn = loc_oPOp.obj_4c_Fwoption1.Value
            THIS.this_oBusinessObject.this_nSeqs       = loc_oPOp.obj_4c_GetSequencia.Value
            THIS.this_oBusinessObject.this_nAgregas    = loc_oPOp.obj_4c_Op_agregas.Value
            THIS.this_oBusinessObject.this_nChkfases   = loc_oPOp.obj_4c_Op_repete.Value
            THIS.this_oBusinessObject.this_nCestoqs    = loc_oPOp.obj_4c_Op_Saldo.Value
            THIS.this_oBusinessObject.this_nInibmens   = loc_oPOp.obj_4c_Op_inib.Value
            THIS.this_oBusinessObject.this_nMenfalhas  = loc_oPOp.obj_4c_ObjMenFalha.Value
            THIS.this_oBusinessObject.this_nBuscaenvs  = loc_oPOp.obj_4c_ObjBusEnv.Value
            THIS.this_oBusinessObject.this_nBtnrets    = loc_oPOp.obj_4c_ObjRetrabs.Value
            THIS.this_oBusinessObject.this_nBtnincs    = loc_oPOp.obj_4c_Objnaoconform.Value
            THIS.this_oBusinessObject.this_nBtnpags    = loc_oPOp.obj_4c_Objpagamento.Value
            THIS.this_oBusinessObject.this_nEtiqenvs   = loc_oPOp.obj_4c_Fwoption3.Value
            THIS.this_oBusinessObject.this_nApontas    = loc_oPOp.obj_4c_Fwoption4.Value
            THIS.this_oBusinessObject.this_nChkdests   = loc_oPOp.obj_4c_Opt_tipomov.Value
            THIS.this_oBusinessObject.this_cCarqIcones = ALLTRIM(loc_oPOp.txt_4c_ArqIcone.Value)
            THIS.this_oBusinessObject.this_cDopemphs   = ALLTRIM(loc_oPOp.txt_4c__Empenho.Value)
            THIS.this_oBusinessObject.this_cEmplancs   = ALLTRIM(loc_oPOp.txt_4c_EmpLanc.Value)
            * Aba Estoque
            THIS.this_oBusinessObject.this_nNumeras    = loc_oPEst.obj_4c_Op_Numeracao.Value
            THIS.this_oBusinessObject.this_nOrigems    = loc_oPEst.obj_4c_Op_origem.Value
            THIS.this_oBusinessObject.this_nEstorigs   = loc_oPEst.obj_4c_Op_EstOrig.Value
            THIS.this_oBusinessObject.this_nFixgorigs  = IIF(loc_oPEst.chk_4c_Chk_Grupoo.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nFixcorigs  = IIF(loc_oPEst.chk_4c_Chk_Contao.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nConosubs   = loc_oPEst.obj_4c_Op_ConOSub.Value
            THIS.this_oBusinessObject.this_nBxoests    = loc_oPEst.obj_4c_Op_BxOEst.Value
            THIS.this_oBusinessObject.this_nSenhaos    = IIF(loc_oPEst.chk_4c_ChkSenhaO.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_cMascos     = ALLTRIM(loc_oPEst.txt_4c_Mascos.Value)
            THIS.this_oBusinessObject.this_nDestinos   = loc_oPEst.obj_4c_Op_destino.Value
            THIS.this_oBusinessObject.this_nCrepls     = loc_oPEst.obj_4c_Get_Repete.Value
            THIS.this_oBusinessObject.this_nEstdests   = loc_oPEst.obj_4c_Op_EstDest.Value
            THIS.this_oBusinessObject.this_nFixgdests  = IIF(loc_oPEst.chk_4c_Chk_Grupod.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nFixcdests  = IIF(loc_oPEst.chk_4c_Chk_Contad.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nCondsubs   = loc_oPEst.obj_4c_Op_ConDSub.Value
            THIS.this_oBusinessObject.this_nBxdests    = loc_oPEst.obj_4c_Op_BxDEst.Value
            THIS.this_oBusinessObject.this_nSenhads    = IIF(loc_oPEst.chk_4c_ChkSenhaD.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_cMascds     = ALLTRIM(loc_oPEst.txt_4c_Mascds.Value)
            THIS.this_oBusinessObject.this_nVends      = loc_oPEst.obj_4c_Op_vende.Value
            THIS.this_oBusinessObject.this_nFixgvends  = IIF(loc_oPEst.chk_4c_Chk_Grupov.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_cGruorigs   = ALLTRIM(loc_oPEst.txt_4c_GrupoOrig.Value)
            THIS.this_oBusinessObject.this_cConorigs   = ALLTRIM(loc_oPEst.txt_4c_ContaOrig.Value)
            THIS.this_oBusinessObject.this_cGrudests   = ALLTRIM(loc_oPEst.txt_4c_GrupoDest.Value)
            THIS.this_oBusinessObject.this_cCondests   = ALLTRIM(loc_oPEst.txt_4c_ContaDest.Value)
            THIS.this_oBusinessObject.this_cGrvends    = ALLTRIM(loc_oPEst.txt_4c_GrupoVend.Value)
            LOCAL loc_cTioVal
            loc_cTioVal = ALLTRIM(loc_oPEst.cbo_4c_CmbTOpers.Value)
            THIS.this_oBusinessObject.this_nTipoops = IIF(!EMPTY(loc_cTioVal), VAL(LEFT(loc_cTioVal, 2)), 0)
            * Aba Componente
            THIS.this_oBusinessObject.this_nGrprods    = loc_oPCom.obj_4c_Op_grprod.Value
            THIS.this_oBusinessObject.this_nGrcomps    = loc_oPCom.obj_4c_Op_grcomp.Value
            THIS.this_oBusinessObject.this_nCompagrus  = loc_oPCom.obj_4c_Op_compagru.Value
            THIS.this_oBusinessObject.this_nSeppedras  = loc_oPCom.obj_4c_Op_SepPedra.Value
            THIS.this_oBusinessObject.this_nBxpedfins  = loc_oPCom.obj_4c_OptBxPedFins.Value
            THIS.this_oBusinessObject.this_nGrodns     = loc_oPCom.obj_4c_Op_GrTrans.Value
            THIS.this_oBusinessObject.this_nNcarqtds   = IIF(loc_oPCom.chk_4c_ChkCarQtde.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nDiflancs   = ALLTRIM(loc_oPCom.txt_4c_Difp.Value)
            THIS.this_oBusinessObject.this_nLimqtds    = ALLTRIM(loc_oPCom.txt_4c__limqtd.Value)
            THIS.this_oBusinessObject.this_nDifpesags  = ALLTRIM(loc_oPCom.txt_4c_DifPeso.Value)
            THIS.this_oBusinessObject.this_cTppadraos  = ALLTRIM(loc_oPCom.txt_4c_TpPadrao.Value)
            THIS.this_oBusinessObject.this_cRetalhos   = ALLTRIM(loc_oPCom.txt_4c_Retalho.Value)
            THIS.this_oBusinessObject.this_cPccfases   = ALLTRIM(loc_oPCom.txt_4c_GrupoPcc.Value)
            THIS.this_oBusinessObject.this_cMatpads    = ALLTRIM(loc_oPCom.txt_4c__produto.Value)
            THIS.this_oBusinessObject.this_cPqs        = ALLTRIM(loc_oPCom.txt_4c_Tfalhas.Value)
            THIS.this_oBusinessObject.this_nSinals     = IIF(loc_oPCom.cbo_4c_Get_Sinal.Value = "-", -1, 1)
            THIS.this_oBusinessObject.this_nChkfunds   = loc_oPCom.obj_4c_Opc_Chkf.Value
            THIS.this_oBusinessObject.this_nPesofixs   = loc_oPCom.obj_4c_Opc_fix.Value
            THIS.this_oBusinessObject.this_nPagservs   = loc_oPCom.obj_4c_Opc_PagSer.Value
            THIS.this_oBusinessObject.this_nMensagens  = loc_oPCom.obj_4c_Opc_mens.Value
            THIS.this_oBusinessObject.this_nEnvobrigs  = loc_oPCom.obj_4c_Opc_env.Value
            THIS.this_oBusinessObject.this_nPesobals   = loc_oPCom.obj_4c_Opc_pesobal.Value
            THIS.this_oBusinessObject.this_nValobrigs  = loc_oPCom.obj_4c_Fwoption1.Value
            THIS.this_oBusinessObject.this_nTrfpesas   = loc_oPCom.obj_4c_Chk_TrfPeso.Value
            THIS.this_oBusinessObject.this_nQtdnegs    = loc_oPCom.obj_4c_Optqtdneg.Value
            THIS.this_oBusinessObject.this_nReinops    = loc_oPCom.obj_4c_ObjReinop.Value
            THIS.this_oBusinessObject.this_nEtiqs      = loc_oPCom.obj_4c_Op_etiq.Value
            THIS.this_oBusinessObject.this_nQuebras    = loc_oPCom.obj_4c_Opt_quebraimp.Value
            THIS.this_oBusinessObject.this_nSolcdlbs   = loc_oPCom.obj_4c_Opt_codlib.Value
            THIS.this_oBusinessObject.this_nCravcers   = loc_oPCom.obj_4c_Opt_cravacera.Value
            THIS.this_oBusinessObject.this_nChkmetal   = loc_oPCom.obj_4c_Fwoption2.Value
            THIS.this_oBusinessObject.this_nLibrpqs    = IIF(loc_oPCom.chk_4c_Chk_LibRein.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nAgseps     = IIF(loc_oPCom.chk_4c_ObjAgSep.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nChkpesos   = IIF(loc_oPCom.chk_4c_OptChkPeso.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nChkmtprs   = IIF(loc_oPCom.chk_4c_ChkMatPrinc.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nResumopop  = loc_oPCom.obj_4c_Fwoption3.Value
            THIS.this_oBusinessObject.this_nMatprncdif = loc_oPCom.obj_4c_OptMatPrncDif.Value
            THIS.this_oBusinessObject.this_nChkqtdps   = loc_oPCom.obj_4c_ObjChkQP.Value
            * Aba Documento
            THIS.this_oBusinessObject.this_nDckcabec   = loc_oPDoc.obj_4c_Optiongroup1.Value
            THIS.this_oBusinessObject.this_nDckitens   = loc_oPDoc.obj_4c_Optiongroup2.Value
            THIS.this_oBusinessObject.this_nDckresu    = loc_oPDoc.obj_4c_Optiongroup3.Value
            * Aba Diversas
            THIS.this_oBusinessObject.this_nCasqtds    = loc_oPDiv.obj_4c_Spn_NCqtd.Value
            THIS.this_oBusinessObject.this_nObspads    = ALLTRIM(loc_oPDiv.txt_4c_Obspads.Value)
            THIS.this_oBusinessObject.this_nObsinis    = ALLTRIM(loc_oPDiv.txt_4c_ObsInis.Value)
            THIS.this_oBusinessObject.this_nObsfins    = ALLTRIM(loc_oPDiv.txt_4c_ObsFins.Value)
            THIS.this_oBusinessObject.this_nChkunis    = loc_oPDiv.obj_4c_Fwoption1.Value
            THIS.this_oBusinessObject.this_nEnvelopes  = loc_oPDiv.obj_4c_Fwoption2.Value
            THIS.this_oBusinessObject.this_nAcenvs     = loc_oPDiv.obj_4c_Fwoption3.Value
            THIS.this_oBusinessObject.this_nCtrlotes   = loc_oPDiv.obj_4c_Fwoption4.Value
            THIS.this_oBusinessObject.this_cCodtgops   = ALLTRIM(loc_oPDiv.txt_4c_TpOp.Value)
            THIS.this_oBusinessObject.this_cGrufins    = ALLTRIM(loc_oPDiv.txt_4c_GruFin.Value)
            THIS.this_oBusinessObject.this_cDopcs      = ALLTRIM(loc_oPDiv.txt_4c_OpConta.Value)
            THIS.this_oBusinessObject.this_cGruccus    = ALLTRIM(loc_oPDiv.txt_4c__gruccus.Value)
            THIS.this_oBusinessObject.this_cContaccus  = ALLTRIM(loc_oPDiv.txt_4c__contaccus.Value)
            THIS.this_oBusinessObject.this_cDopsemis   = ALLTRIM(loc_oPDiv.txt_4c_Semi.Value)
            THIS.this_oBusinessObject.this_nChkpesotot = loc_oPDiv.obj_4c_Fwoption5.Value
            THIS.this_oBusinessObject.this_nTpsenexc   = loc_oPDiv.obj_4c_Optiongroup1.Value
            THIS.this_oBusinessObject.this_nPccs       = IIF(loc_oPDiv.chk_4c_Chk_Pcc.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nPesmatps   = IIF(loc_oPDiv.chk_4c_Chk_imp.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nInibAlts   = IIF(loc_oPDiv.chk_4c_Chk_InibAlt.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nChkctdes   = IIF(loc_oPDiv.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nChksenexc  = IIF(loc_oPDiv.chk_4c_Fwcheckbox8.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nChkoplts   = IIF(loc_oPDiv.chk_4c_ChkOpLote.Value = 1, 1, 0)
        CATCH TO loException
            MostrarErro(loException, "FormMPD.FormParaBO")
        ENDTRY
    ENDPROC

    * ============================================================
    * BOParaForm
    * ============================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPD, loc_oPOp, loc_oPEst, loc_oPCom, loc_oPDoc, loc_oPDiv, loc_oBO
        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_oPD   = THIS.pgf_4c_Paginas.Page2
            loc_oPOp  = loc_oPD.pgf_4c_PagDados.Page1
            loc_oPEst = loc_oPD.pgf_4c_PagDados.Page2
            loc_oPCom = loc_oPD.pgf_4c_PagDados.Page3
            loc_oPDoc = loc_oPD.pgf_4c_PagDados.Page4
            loc_oPDiv = loc_oPD.pgf_4c_PagDados.Page5
            * Header
            loc_oPD.txt_4c_Desc.Value  = loc_oBO.this_cDopps
            loc_oPD.txt_4c_Nope.Value  = loc_oBO.this_nNdopps
            loc_oPD.txt_4c_Ordem.Value = loc_oBO.this_nOrdes
            * Aba Operacao
            loc_oPOp.obj_4c_Op_imagem.Value    = IIF(loc_oBO.this_nImagems > 0, loc_oBO.this_nImagems, 2)
            loc_oPOp.obj_4c_Op_boleto.Value    = IIF(loc_oBO.this_nBoletos > 0, loc_oBO.this_nBoletos, 1)
            loc_oPOp.obj_4c_Fwoption8.Value    = IIF(loc_oBO.this_nDocus > 0, loc_oBO.this_nDocus, 2)
            loc_oPOp.obj_4c_Fwoption5.Value    = IIF(loc_oBO.this_nBolops > 0, loc_oBO.this_nBolops, 2)
            loc_oPOp.obj_4c_Opt_compo.Value    = IIF(loc_oBO.this_nBolcomps > 0, loc_oBO.this_nBolcomps, 2)
            loc_oPOp.obj_4c_Opt_Menu.Value     = IIF(loc_oBO.this_nMenus > 0, loc_oBO.this_nMenus, 2)
            loc_oPOp.obj_4c_ObjAutos.Value     = IIF(loc_oBO.this_nAutos > 0, loc_oBO.this_nAutos, 1)
            loc_oPOp.txt_4c_Hists.Value        = loc_oBO.this_cHists
            loc_oPOp.obj_4c_Op_subn.Value      = IIF(loc_oBO.this_nChktemsubn > 0, loc_oBO.this_nChktemsubn, 2)
            loc_oPOp.txt_4c_Nivel.Value        = loc_oBO.this_cNivels
            loc_oPOp.txt_4c_Titulo.Value       = loc_oBO.this_cTnivels
            loc_oPOp.txt_4c_Artigo.Value       = loc_oBO.this_cArtigos
            loc_oPOp.obj_4c_Op_BxAuto.Value    = IIF(loc_oBO.this_nBxautos > 0, loc_oBO.this_nBxautos, 2)
            loc_oPOp.obj_4c_Fwoption2.Value    = IIF(loc_oBO.this_nExclsubns > 0, loc_oBO.this_nExclsubns, 2)
            loc_oPOp.obj_4c_Fwoption1.Value    = IIF(loc_oBO.this_nChktemsubn > 0, loc_oBO.this_nChktemsubn, 2)
            loc_oPOp.obj_4c_GetSequencia.Value = IIF(loc_oBO.this_nSeqs > 0, loc_oBO.this_nSeqs, 2)
            loc_oPOp.obj_4c_Op_agregas.Value   = IIF(loc_oBO.this_nAgregas > 0, loc_oBO.this_nAgregas, 2)
            loc_oPOp.obj_4c_Op_repete.Value    = IIF(loc_oBO.this_nChkfases > 0, loc_oBO.this_nChkfases, 1)
            loc_oPOp.obj_4c_Op_Saldo.Value     = IIF(loc_oBO.this_nCestoqs > 0, loc_oBO.this_nCestoqs, 2)
            loc_oPOp.obj_4c_Op_inib.Value      = IIF(loc_oBO.this_nInibmens > 0, loc_oBO.this_nInibmens, 2)
            loc_oPOp.obj_4c_ObjMenFalha.Value  = IIF(loc_oBO.this_nMenfalhas > 0, loc_oBO.this_nMenfalhas, 2)
            loc_oPOp.obj_4c_ObjBusEnv.Value    = IIF(loc_oBO.this_nBuscaenvs > 0, loc_oBO.this_nBuscaenvs, 2)
            loc_oPOp.obj_4c_ObjRetrabs.Value   = IIF(loc_oBO.this_nBtnrets > 0, loc_oBO.this_nBtnrets, 2)
            loc_oPOp.obj_4c_Objnaoconform.Value = IIF(loc_oBO.this_nBtnincs > 0, loc_oBO.this_nBtnincs, 2)
            loc_oPOp.obj_4c_Objpagamento.Value = IIF(loc_oBO.this_nBtnpags > 0, loc_oBO.this_nBtnpags, 2)
            loc_oPOp.obj_4c_Fwoption3.Value    = IIF(loc_oBO.this_nEtiqenvs > 0, loc_oBO.this_nEtiqenvs, 2)
            loc_oPOp.obj_4c_Fwoption4.Value    = IIF(loc_oBO.this_nApontas > 0, loc_oBO.this_nApontas, 1)
            loc_oPOp.obj_4c_Opt_tipomov.Value  = IIF(loc_oBO.this_nChkdests > 0, loc_oBO.this_nChkdests, 1)
            loc_oPOp.txt_4c_ArqIcone.Value     = loc_oBO.this_cCarqIcones
            loc_oPOp.txt_4c__Empenho.Value     = loc_oBO.this_cDopemphs
            loc_oPOp.txt_4c_EmpLanc.Value      = loc_oBO.this_cEmplancs
            * Aba Estoque
            loc_oPEst.obj_4c_Op_Numeracao.Value = IIF(loc_oBO.this_nNumeras > 0, loc_oBO.this_nNumeras, 1)
            loc_oPEst.obj_4c_Op_origem.Value    = IIF(loc_oBO.this_nOrigems > 0, loc_oBO.this_nOrigems, 2)
            loc_oPEst.obj_4c_Op_EstOrig.Value   = IIF(loc_oBO.this_nEstorigs > 0, loc_oBO.this_nEstorigs, 1)
            loc_oPEst.chk_4c_Chk_Grupoo.Value   = loc_oBO.this_nFixgorigs
            loc_oPEst.chk_4c_Chk_Contao.Value   = loc_oBO.this_nFixcorigs
            loc_oPEst.obj_4c_Op_ConOSub.Value   = IIF(loc_oBO.this_nConosubs > 0, loc_oBO.this_nConosubs, 1)
            loc_oPEst.obj_4c_Op_BxOEst.Value    = IIF(loc_oBO.this_nBxoests > 0, loc_oBO.this_nBxoests, 2)
            loc_oPEst.chk_4c_ChkSenhaO.Value    = loc_oBO.this_nSenhaos
            loc_oPEst.txt_4c_Mascos.Value        = loc_oBO.this_cMascos
            loc_oPEst.obj_4c_Op_destino.Value   = IIF(loc_oBO.this_nDestinos > 0, loc_oBO.this_nDestinos, 2)
            loc_oPEst.obj_4c_Get_Repete.Value   = IIF(loc_oBO.this_nCrepls > 0, loc_oBO.this_nCrepls, 2)
            loc_oPEst.obj_4c_Op_EstDest.Value   = IIF(loc_oBO.this_nEstdests > 0, loc_oBO.this_nEstdests, 1)
            loc_oPEst.chk_4c_Chk_Grupod.Value   = loc_oBO.this_nFixgdests
            loc_oPEst.chk_4c_Chk_Contad.Value   = loc_oBO.this_nFixcdests
            loc_oPEst.obj_4c_Op_ConDSub.Value   = IIF(loc_oBO.this_nCondsubs > 0, loc_oBO.this_nCondsubs, 1)
            loc_oPEst.obj_4c_Op_BxDEst.Value    = IIF(loc_oBO.this_nBxdests > 0, loc_oBO.this_nBxdests, 2)
            loc_oPEst.chk_4c_ChkSenhaD.Value    = loc_oBO.this_nSenhads
            loc_oPEst.txt_4c_Mascds.Value        = loc_oBO.this_cMascds
            loc_oPEst.obj_4c_Op_vende.Value     = IIF(loc_oBO.this_nVends > 0, loc_oBO.this_nVends, 2)
            loc_oPEst.chk_4c_Chk_Grupov.Value   = loc_oBO.this_nFixgvends
            loc_oPEst.txt_4c_GrupoOrig.Value     = loc_oBO.this_cGruorigs
            loc_oPEst.txt_4c_ContaOrig.Value     = loc_oBO.this_cConorigs
            loc_oPEst.txt_4c_GrupoDest.Value     = loc_oBO.this_cGrudests
            loc_oPEst.txt_4c_ContaDest.Value     = loc_oBO.this_cCondests
            loc_oPEst.txt_4c_GrupoVend.Value     = loc_oBO.this_cGrvends
            LOCAL loc_nTioI, loc_cTioCod
            loc_oPEst.cbo_4c_CmbTOpers.Value = ""
            loc_cTioCod = PADL(ALLTRIM(STR(loc_oBO.this_nTipoops, 2)), 2, "0")
            FOR loc_nTioI = 1 TO loc_oPEst.cbo_4c_CmbTOpers.ListCount
                IF LEFT(loc_oPEst.cbo_4c_CmbTOpers.List(loc_nTioI), 2) = loc_cTioCod
                    loc_oPEst.cbo_4c_CmbTOpers.Value = loc_oPEst.cbo_4c_CmbTOpers.List(loc_nTioI)
                    EXIT
                ENDIF
            ENDFOR
            * Aba Componente
            loc_oPCom.obj_4c_Op_grprod.Value    = IIF(loc_oBO.this_nGrprods > 0, loc_oBO.this_nGrprods, 2)
            loc_oPCom.obj_4c_Op_grcomp.Value    = IIF(loc_oBO.this_nGrcomps > 0, loc_oBO.this_nGrcomps, 2)
            loc_oPCom.obj_4c_Op_compagru.Value  = IIF(loc_oBO.this_nCompagrus > 0, loc_oBO.this_nCompagrus, 1)
            loc_oPCom.obj_4c_Op_SepPedra.Value  = IIF(loc_oBO.this_nSeppedras > 0, loc_oBO.this_nSeppedras, 1)
            loc_oPCom.obj_4c_OptBxPedFins.Value = IIF(loc_oBO.this_nBxpedfins > 0, loc_oBO.this_nBxpedfins, 2)
            loc_oPCom.obj_4c_Op_GrTrans.Value   = IIF(loc_oBO.this_nGrodns > 0, loc_oBO.this_nGrodns, 1)
            loc_oPCom.chk_4c_ChkCarQtde.Value   = loc_oBO.this_nNcarqtds
            loc_oPCom.txt_4c_Difp.Value          = loc_oBO.this_nDiflancs
            loc_oPCom.txt_4c__limqtd.Value       = loc_oBO.this_nLimqtds
            loc_oPCom.txt_4c_DifPeso.Value       = loc_oBO.this_nDifpesags
            loc_oPCom.txt_4c_TpPadrao.Value      = loc_oBO.this_cTppadraos
            loc_oPCom.txt_4c_Retalho.Value       = loc_oBO.this_cRetalhos
            loc_oPCom.txt_4c_GrupoPcc.Value      = loc_oBO.this_cPccfases
            loc_oPCom.txt_4c__produto.Value      = loc_oBO.this_cMatpads
            loc_oPCom.txt_4c_Tfalhas.Value       = loc_oBO.this_cPqs
            loc_oPCom.cbo_4c_Get_Sinal.Value     = IIF(loc_oBO.this_nSinals < 0, "-", "+")
            loc_oPCom.obj_4c_Opc_Chkf.Value     = IIF(loc_oBO.this_nChkfunds > 0, loc_oBO.this_nChkfunds, 2)
            loc_oPCom.obj_4c_Opc_fix.Value       = IIF(loc_oBO.this_nPesofixs > 0, loc_oBO.this_nPesofixs, 1)
            loc_oPCom.obj_4c_Opc_PagSer.Value    = IIF(loc_oBO.this_nPagservs > 0, loc_oBO.this_nPagservs, 1)
            loc_oPCom.obj_4c_Opc_mens.Value      = IIF(loc_oBO.this_nMensagens > 0, loc_oBO.this_nMensagens, 2)
            loc_oPCom.obj_4c_Opc_env.Value       = IIF(loc_oBO.this_nEnvobrigs > 0, loc_oBO.this_nEnvobrigs, 1)
            loc_oPCom.obj_4c_Opc_pesobal.Value   = IIF(loc_oBO.this_nPesobals > 0, loc_oBO.this_nPesobals, 1)
            loc_oPCom.obj_4c_Fwoption1.Value     = IIF(loc_oBO.this_nValobrigs > 0, loc_oBO.this_nValobrigs, 2)
            loc_oPCom.obj_4c_Chk_TrfPeso.Value   = IIF(loc_oBO.this_nTrfpesas > 0, loc_oBO.this_nTrfpesas, 1)
            loc_oPCom.obj_4c_Optqtdneg.Value     = IIF(loc_oBO.this_nQtdnegs > 0, loc_oBO.this_nQtdnegs, 1)
            loc_oPCom.obj_4c_ObjReinop.Value     = IIF(loc_oBO.this_nReinops > 0, loc_oBO.this_nReinops, 1)
            loc_oPCom.obj_4c_Op_etiq.Value       = IIF(loc_oBO.this_nEtiqs > 0, loc_oBO.this_nEtiqs, 1)
            loc_oPCom.obj_4c_Opt_quebraimp.Value = IIF(loc_oBO.this_nQuebras > 0, loc_oBO.this_nQuebras, 2)
            loc_oPCom.obj_4c_Opt_codlib.Value    = IIF(loc_oBO.this_nSolcdlbs > 0, loc_oBO.this_nSolcdlbs, 2)
            loc_oPCom.obj_4c_Opt_cravacera.Value = IIF(loc_oBO.this_nCravcers > 0, loc_oBO.this_nCravcers, 2)
            loc_oPCom.obj_4c_Fwoption2.Value     = IIF(loc_oBO.this_nChkmetal > 0, loc_oBO.this_nChkmetal, 2)
            loc_oPCom.chk_4c_Chk_LibRein.Value   = loc_oBO.this_nLibrpqs
            loc_oPCom.chk_4c_ObjAgSep.Value      = loc_oBO.this_nAgseps
            loc_oPCom.chk_4c_OptChkPeso.Value    = loc_oBO.this_nChkpesos
            loc_oPCom.chk_4c_ChkMatPrinc.Value   = loc_oBO.this_nChkmtprs
            loc_oPCom.obj_4c_Fwoption3.Value     = IIF(loc_oBO.this_nResumopop > 0, loc_oBO.this_nResumopop, 2)
            loc_oPCom.obj_4c_OptMatPrncDif.Value = IIF(loc_oBO.this_nMatprncdif > 0, loc_oBO.this_nMatprncdif, 2)
            loc_oPCom.obj_4c_ObjChkQP.Value      = IIF(loc_oBO.this_nChkqtdps > 0, loc_oBO.this_nChkqtdps, 1)
            * Aba Documento
            loc_oPDoc.obj_4c_Optiongroup1.Value  = IIF(loc_oBO.this_nDckcabec > 0, loc_oBO.this_nDckcabec, 2)
            loc_oPDoc.obj_4c_Optiongroup2.Value  = IIF(loc_oBO.this_nDckitens > 0, loc_oBO.this_nDckitens, 1)
            loc_oPDoc.obj_4c_Optiongroup3.Value  = IIF(loc_oBO.this_nDckresu > 0, loc_oBO.this_nDckresu, 2)
            * Aba Diversas
            loc_oPDiv.obj_4c_Spn_NCqtd.Value    = loc_oBO.this_nCasqtds
            loc_oPDiv.txt_4c_Obspads.Value       = loc_oBO.this_nObspads
            loc_oPDiv.txt_4c_ObsInis.Value       = loc_oBO.this_nObsinis
            loc_oPDiv.txt_4c_ObsFins.Value       = loc_oBO.this_nObsfins
            loc_oPDiv.obj_4c_Fwoption1.Value     = IIF(loc_oBO.this_nChkunis > 0, loc_oBO.this_nChkunis, 2)
            loc_oPDiv.obj_4c_Fwoption2.Value     = IIF(loc_oBO.this_nEnvelopes > 0, loc_oBO.this_nEnvelopes, 2)
            loc_oPDiv.obj_4c_Fwoption3.Value     = IIF(loc_oBO.this_nAcenvs > 0, loc_oBO.this_nAcenvs, 2)
            loc_oPDiv.obj_4c_Fwoption4.Value     = IIF(loc_oBO.this_nCtrlotes > 0, loc_oBO.this_nCtrlotes, 2)
            loc_oPDiv.txt_4c_TpOp.Value          = loc_oBO.this_cCodtgops
            loc_oPDiv.txt_4c_GruFin.Value        = loc_oBO.this_cGrufins
            loc_oPDiv.txt_4c_OpConta.Value       = loc_oBO.this_cDopcs
            loc_oPDiv.txt_4c__gruccus.Value      = loc_oBO.this_cGruccus
            loc_oPDiv.txt_4c__contaccus.Value    = loc_oBO.this_cContaccus
            loc_oPDiv.txt_4c_Semi.Value          = loc_oBO.this_cDopsemis
            loc_oPDiv.obj_4c_Fwoption5.Value     = IIF(loc_oBO.this_nChkpesotot > 0, loc_oBO.this_nChkpesotot, 1)
            loc_oPDiv.obj_4c_Optiongroup1.Value  = IIF(loc_oBO.this_nTpsenexc > 0, loc_oBO.this_nTpsenexc, 1)
            loc_oPDiv.chk_4c_Chk_Pcc.Value      = loc_oBO.this_nPccs
            loc_oPDiv.chk_4c_Chk_imp.Value       = loc_oBO.this_nPesmatps
            loc_oPDiv.chk_4c_Chk_InibAlt.Value  = loc_oBO.this_nInibAlts
            loc_oPDiv.chk_4c_Fwcheckbox1.Value   = loc_oBO.this_nChkctdes
            loc_oPDiv.chk_4c_Fwcheckbox8.Value   = loc_oBO.this_nChksenexc
            loc_oPDiv.chk_4c_ChkOpLote.Value     = loc_oBO.this_nChkoplts
        CATCH TO loException
            MostrarErro(loException, "FormMPD.BOParaForm")
        ENDTRY
    ENDPROC

    * ============================================================
    * HabilitarCampos
    * ============================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPD
        TRY
            loc_oPD = THIS.pgf_4c_Paginas.Page2
            loc_oPD.txt_4c_Desc.Enabled                      = par_lHabilitar
            loc_oPD.txt_4c_Nope.Enabled                      = par_lHabilitar
            loc_oPD.txt_4c_Ordem.Enabled                     = par_lHabilitar
            loc_oPD.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled  = par_lHabilitar
        CATCH TO loException
            MostrarErro(loException, "FormMPD.HabilitarCampos")
        ENDTRY
    ENDPROC

    * ============================================================
    * LimparCampos
    * ============================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPD, loc_oPOp, loc_oPEst, loc_oPCom, loc_oPDoc, loc_oPDiv
        TRY
            loc_oPD   = THIS.pgf_4c_Paginas.Page2
            loc_oPOp  = loc_oPD.pgf_4c_PagDados.Page1
            loc_oPEst = loc_oPD.pgf_4c_PagDados.Page2
            loc_oPCom = loc_oPD.pgf_4c_PagDados.Page3
            loc_oPDoc = loc_oPD.pgf_4c_PagDados.Page4
            loc_oPDiv = loc_oPD.pgf_4c_PagDados.Page5
            loc_oPD.txt_4c_Desc.Value  = ""
            loc_oPD.txt_4c_Nope.Value  = 0
            loc_oPD.txt_4c_Ordem.Value = 0
            loc_oPOp.txt_4c_Hists.Value   = ""
            loc_oPOp.txt_4c_Nivel.Value   = ""
            loc_oPOp.txt_4c_Titulo.Value  = ""
            loc_oPOp.txt_4c_Artigo.Value  = ""
            loc_oPOp.txt_4c_ArqIcone.Value = ""
            loc_oPOp.txt_4c__Empenho.Value = ""
            loc_oPOp.txt_4c_EmpLanc.Value  = ""
            loc_oPEst.txt_4c_GrupoOrig.Value = ""
            loc_oPEst.txt_4c_Dgrupoo.Value = ""
            loc_oPEst.txt_4c_ContaOrig.Value = ""
            loc_oPEst.txt_4c_Dcontao.Value = ""
            loc_oPEst.txt_4c_GrupoDest.Value = ""
            loc_oPEst.txt_4c_Dgrupod.Value = ""
            loc_oPEst.txt_4c_ContaDest.Value = ""
            loc_oPEst.txt_4c_Dcontad.Value = ""
            loc_oPEst.txt_4c_GrupoVend.Value = ""
            loc_oPEst.txt_4c_Dgrupov.Value = ""
            loc_oPEst.txt_4c_Mascos.Value = ""
            loc_oPEst.txt_4c_Mascds.Value = ""
            loc_oPCom.txt_4c_TpPadrao.Value = ""
            loc_oPCom.txt_4c_Retalho.Value = ""
            loc_oPCom.txt_4c_GrupoPcc.Value = ""
            loc_oPCom.txt_4c__produto.Value = ""
            loc_oPCom.txt_4c_Tfalhas.Value  = ""
            loc_oPCom.txt_4c_Difp.Value = 0
            loc_oPCom.txt_4c__limqtd.Value = 0
            loc_oPCom.txt_4c_DifPeso.Value = 0
            loc_oPDiv.txt_4c_Obspads.Value  = 0
            loc_oPDiv.txt_4c_ObsInis.Value = 0
            loc_oPDiv.txt_4c_ObsFins.Value  = 0
            loc_oPDiv.txt_4c_TpOp.Value = ""
            loc_oPDiv.txt_4c_GruFin.Value   = ""
            loc_oPDiv.txt_4c_DGruFin.Value = ""
            loc_oPDiv.txt_4c_OpConta.Value  = ""
            loc_oPDiv.txt_4c__gruccus.Value = ""
            loc_oPDiv.txt_4c__dgruccus.Value = ""
            loc_oPDiv.txt_4c__contaccus.Value = ""
            loc_oPDiv.txt_4c__dcontaccus.Value = ""
            loc_oPDiv.txt_4c_Semi.Value = ""
        CATCH TO loException
            MostrarErro(loException, "FormMPD.LimparCampos")
        ENDTRY
    ENDPROC

    * ============================================================
    * LOOKUP HANDLERS - Operacao
    * ============================================================
    PROCEDURE NivelKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupNivel()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupNivel()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Dopps, Ndopps FROM SigCdOpd ORDER BY Dopps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nivel")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_Nivel"
                loc_oFrm.DefinirCursor("cursor_4c_Nivel", "Dopps", "Ndopps", "SubN" + CHR(237) + "vel")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
                    loc_oPg.txt_4c_Nivel.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_Nivel")
                    USE IN cursor_4c_Nivel
                ENDIF
            ELSE
                MsgErro("Erro ao buscar n" + CHR(237) + "veis.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupNivel")
        ENDTRY
    ENDPROC

    PROCEDURE EmpenhoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupEmpenho()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupEmpenho()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Dopps, hists FROM SigCdOpd ORDER BY Dopps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empenho")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_Empenho"
                loc_oFrm.DefinirCursor("cursor_4c_Empenho", "Dopps", "hists", "Opera" + CHR(231) + CHR(227) + "o Empenho")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
                    loc_oPg.txt_4c__Empenho.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_Empenho")
                    USE IN cursor_4c_Empenho
                ENDIF
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupEmpenho")
        ENDTRY
    ENDPROC

    PROCEDURE EmpLancKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupEmpLanc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupEmpLanc()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT cemps, razas FROM SigCdEmp ORDER BY cemps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpLanc")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_EmpLanc"
                loc_oFrm.DefinirCursor("cursor_4c_EmpLanc", "cemps", "razas", "Empresa")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
                    loc_oPg.txt_4c_EmpLanc.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_EmpLanc")
                    USE IN cursor_4c_EmpLanc
                ENDIF
            ELSE
                MsgErro("Erro ao buscar empresas.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupEmpLanc")
        ENDTRY
    ENDPROC

    * ============================================================
    * LOOKUP HANDLERS - Estoque
    * ============================================================
    PROCEDURE GrupoOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupGrupoOrig()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupGrupoOrig()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoO")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_GrupoO"
                loc_oFrm.DefinirCursor("cursor_4c_GrupoO", "codigos", "descrs", "Grupo Orig.")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
                    loc_oPg.txt_4c_GrupoOrig.Value = loc_oFrm.cCodigoSelecionado
                    loc_oPg.txt_4c_Dgrupoo.Value   = loc_oFrm.cDescricaoSelecionada
                ENDIF
                IF USED("cursor_4c_GrupoO")
                    USE IN cursor_4c_GrupoO
                ENDIF
            ELSE
                MsgErro("Erro ao buscar grupos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoOrig")
        ENDTRY
    ENDPROC

    PROCEDURE ContaOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupContaOrig()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupContaOrig()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaO")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_ContaO"
                loc_oFrm.DefinirCursor("cursor_4c_ContaO", "codigos", "descrs", "Conta Orig.")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
                    loc_oPg.txt_4c_ContaOrig.Value = loc_oFrm.cCodigoSelecionado
                    loc_oPg.txt_4c_Dcontao.Value   = loc_oFrm.cDescricaoSelecionada
                ENDIF
                IF USED("cursor_4c_ContaO")
                    USE IN cursor_4c_ContaO
                ENDIF
            ELSE
                MsgErro("Erro ao buscar contas.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupContaOrig")
        ENDTRY
    ENDPROC

    PROCEDURE GrupoDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupGrupoDest()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupGrupoDest()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoD")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_GrupoD"
                loc_oFrm.DefinirCursor("cursor_4c_GrupoD", "codigos", "descrs", "Grupo Dest.")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
                    loc_oPg.txt_4c_GrupoDest.Value = loc_oFrm.cCodigoSelecionado
                    loc_oPg.txt_4c_Dgrupod.Value   = loc_oFrm.cDescricaoSelecionada
                ENDIF
                IF USED("cursor_4c_GrupoD")
                    USE IN cursor_4c_GrupoD
                ENDIF
            ELSE
                MsgErro("Erro ao buscar grupos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoDest")
        ENDTRY
    ENDPROC

    PROCEDURE ContaDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupContaDest()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupContaDest()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaD")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_ContaD"
                loc_oFrm.DefinirCursor("cursor_4c_ContaD", "codigos", "descrs", "Conta Dest.")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
                    loc_oPg.txt_4c_ContaDest.Value = loc_oFrm.cCodigoSelecionado
                    loc_oPg.txt_4c_Dcontad.Value   = loc_oFrm.cDescricaoSelecionada
                ENDIF
                IF USED("cursor_4c_ContaD")
                    USE IN cursor_4c_ContaD
                ENDIF
            ELSE
                MsgErro("Erro ao buscar contas.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupContaDest")
        ENDTRY
    ENDPROC

    PROCEDURE GrupoVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupGrupoVend()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupGrupoVend()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoV")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_GrupoV"
                loc_oFrm.DefinirCursor("cursor_4c_GrupoV", "codigos", "descrs", "Grupo Venda")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
                    loc_oPg.txt_4c_GrupoVend.Value = loc_oFrm.cCodigoSelecionado
                    loc_oPg.txt_4c_Dgrupov.Value   = loc_oFrm.cDescricaoSelecionada
                ENDIF
                IF USED("cursor_4c_GrupoV")
                    USE IN cursor_4c_GrupoV
                ENDIF
            ELSE
                MsgErro("Erro ao buscar grupos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoVend")
        ENDTRY
    ENDPROC

    * ============================================================
    * COMPORTAMENTO INTERATIVO - Estoque
    * ============================================================
    PROCEDURE OpOrigemChange()
        LOCAL loc_oPg, loc_lSim
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
            loc_lSim = (loc_oPg.obj_4c_Op_origem.Value = 1)
            loc_oPg.txt_4c_GrupoOrig.Enabled   = loc_lSim
            loc_oPg.txt_4c_Dgrupoo.Enabled     = loc_lSim
            loc_oPg.txt_4c_ContaOrig.Enabled   = loc_lSim
            loc_oPg.txt_4c_Dcontao.Enabled     = loc_lSim
            loc_oPg.chk_4c_Chk_Grupoo.Enabled  = loc_lSim
            loc_oPg.chk_4c_Chk_Contao.Enabled  = loc_lSim
            loc_oPg.obj_4c_Op_ConOSub.Enabled  = loc_lSim
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormMPD.OpOrigemChange")
        ENDTRY
    ENDPROC

    PROCEDURE OpDestinoChange()
        LOCAL loc_oPg, loc_lSim
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
            loc_lSim = (loc_oPg.obj_4c_Op_destino.Value = 1)
            loc_oPg.obj_4c_Get_Repete.Enabled  = loc_lSim
            loc_oPg.txt_4c_GrupoDest.Enabled   = loc_lSim
            loc_oPg.txt_4c_Dgrupod.Enabled     = loc_lSim
            loc_oPg.txt_4c_ContaDest.Enabled   = loc_lSim
            loc_oPg.txt_4c_Dcontad.Enabled     = loc_lSim
            loc_oPg.chk_4c_Chk_Grupod.Enabled  = loc_lSim
            loc_oPg.chk_4c_Chk_Contad.Enabled  = loc_lSim
            loc_oPg.obj_4c_Op_ConDSub.Enabled  = loc_lSim
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormMPD.OpDestinoChange")
        ENDTRY
    ENDPROC

    PROCEDURE OpVendeChange()
        LOCAL loc_oPg, loc_lSim
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
            loc_lSim = (loc_oPg.obj_4c_Op_vende.Value = 1)
            loc_oPg.txt_4c_GrupoVend.Enabled  = loc_lSim
            loc_oPg.txt_4c_Dgrupov.Enabled    = loc_lSim
            loc_oPg.chk_4c_Chk_Grupov.Enabled = loc_lSim
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormMPD.OpVendeChange")
        ENDTRY
    ENDPROC

    PROCEDURE OpEstOrigChange()
        LOCAL loc_oPg, loc_nOrig, loc_nDest
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
            loc_nOrig = loc_oPg.obj_4c_Op_EstOrig.Value
            loc_nDest = loc_oPg.obj_4c_Op_EstDest.Value
            IF loc_nOrig <> 3 AND loc_nOrig = loc_nDest
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o de estoque conflitante.")
                loc_oPg.obj_4c_Op_EstOrig.Value = 3
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormMPD.OpEstOrigChange")
        ENDTRY
    ENDPROC

    PROCEDURE OpEstDestChange()
        LOCAL loc_oPg, loc_nOrig, loc_nDest
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
            loc_nOrig = loc_oPg.obj_4c_Op_EstOrig.Value
            loc_nDest = loc_oPg.obj_4c_Op_EstDest.Value
            IF loc_nDest <> 3 AND loc_nDest = loc_nOrig
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o de estoque conflitante.")
                loc_oPg.obj_4c_Op_EstDest.Value = 3
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormMPD.OpEstDestChange")
        ENDTRY
    ENDPROC

    * ============================================================
    * LOOKUP HANDLERS - Componente
    * ============================================================
    PROCEDURE TpPadraoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupTpPadrao()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupTpPadrao()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Cods, Descrs FROM SigOpOpt ORDER BY Cods"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpPad")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_TpPad"
                loc_oFrm.DefinirCursor("cursor_4c_TpPad", "Cods", "Descrs", "Tipo Padr" + CHR(227) + "o")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
                    loc_oPg.txt_4c_TpPadrao.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_TpPad")
                    USE IN cursor_4c_TpPad
                ENDIF
            ELSE
                MsgErro("Erro ao buscar tipos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupTpPadrao")
        ENDTRY
    ENDPROC

    PROCEDURE RetalhoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupRetalho()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupRetalho()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Cods, Descrs FROM SigOpOpt ORDER BY Cods"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Retalho")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_Retalho"
                loc_oFrm.DefinirCursor("cursor_4c_Retalho", "Cods", "Descrs", "Retalho")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
                    loc_oPg.txt_4c_Retalho.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_Retalho")
                    USE IN cursor_4c_Retalho
                ENDIF
            ELSE
                MsgErro("Erro ao buscar retalhos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupRetalho")
        ENDTRY
    ENDPROC

    PROCEDURE GrupoPccKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupGrupoPcc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupGrupoPcc()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoPcc")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_GrupoPcc"
                loc_oFrm.DefinirCursor("cursor_4c_GrupoPcc", "codigos", "descrs", "Fase PCC")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
                    loc_oPg.txt_4c_GrupoPcc.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_GrupoPcc")
                    USE IN cursor_4c_GrupoPcc
                ENDIF
            ELSE
                MsgErro("Erro ao buscar grupos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoPcc")
        ENDTRY
    ENDPROC

    PROCEDURE ProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupProduto()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupProduto()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_Produto"
                loc_oFrm.DefinirCursor("cursor_4c_Produto", "cpros", "dpros", "Material Padr" + CHR(227) + "o")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
                    loc_oPg.txt_4c__produto.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF
            ELSE
                MsgErro("Erro ao buscar produtos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupProduto")
        ENDTRY
    ENDPROC

    * ============================================================
    * LOOKUP HANDLERS - Diversas
    * ============================================================
    PROCEDURE ObspadsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupObspads()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupObspads()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsPad")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_ObsPad"
                loc_oFrm.DefinirCursor("cursor_4c_ObsPad", "Codigos", "Descrs", "Observa" + CHR(231) + CHR(227) + "o")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
                    loc_oPg.txt_4c_Obspads.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_ObsPad")
                    USE IN cursor_4c_ObsPad
                ENDIF
            ELSE
                MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupObspads")
        ENDTRY
    ENDPROC

    PROCEDURE ObsInisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupObsInis()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupObsInis()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsIni")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_ObsIni"
                loc_oFrm.DefinirCursor("cursor_4c_ObsIni", "Codigos", "Descrs", "Obs. Inicial")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
                    loc_oPg.txt_4c_ObsInis.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_ObsIni")
                    USE IN cursor_4c_ObsIni
                ENDIF
            ELSE
                MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupObsInis")
        ENDTRY
    ENDPROC

    PROCEDURE ObsFinsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupObsFins()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupObsFins()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsFin")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_ObsFin"
                loc_oFrm.DefinirCursor("cursor_4c_ObsFin", "Codigos", "Descrs", "Obs. Final")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
                    loc_oPg.txt_4c_ObsFins.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_ObsFin")
                    USE IN cursor_4c_ObsFin
                ENDIF
            ELSE
                MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupObsFins")
        ENDTRY
    ENDPROC

    PROCEDURE GruFinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupGruFin()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupGruFin()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruFin")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_GruFin"
                loc_oFrm.DefinirCursor("cursor_4c_GruFin", "codigos", "descrs", "Grupo Financeiro")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
                    loc_oPg.txt_4c_GruFin.Value  = loc_oFrm.cCodigoSelecionado
                    loc_oPg.txt_4c_DGruFin.Value = loc_oFrm.cDescricaoSelecionada
                ENDIF
                IF USED("cursor_4c_GruFin")
                    USE IN cursor_4c_GruFin
                ENDIF
            ELSE
                MsgErro("Erro ao buscar grupos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupGruFin")
        ENDTRY
    ENDPROC

    PROCEDURE OpContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupOpConta()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupOpConta()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Dopes, Ndopes FROM SigOpOpe ORDER BY Dopes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpConta")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_OpConta"
                loc_oFrm.DefinirCursor("cursor_4c_OpConta", "Dopes", "Ndopes", "Opera" + CHR(231) + CHR(227) + "o Contas")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
                    loc_oPg.txt_4c_OpConta.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_OpConta")
                    USE IN cursor_4c_OpConta
                ENDIF
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupOpConta")
        ENDTRY
    ENDPROC

    PROCEDURE TpOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupTpOp()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupTpOp()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigInTgo ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpOp")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_TpOp"
                loc_oFrm.DefinirCursor("cursor_4c_TpOp", "Codigos", "Descrs", "Tipo de Ordem")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
                    loc_oPg.txt_4c_TpOp.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_TpOp")
                    USE IN cursor_4c_TpOp
                ENDIF
            ELSE
                MsgErro("Erro ao buscar tipos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupTpOp")
        ENDTRY
    ENDPROC

    PROCEDURE GruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupGruccus()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupGruccus()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gruccus")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_Gruccus"
                loc_oFrm.DefinirCursor("cursor_4c_Gruccus", "codigos", "descrs", "Grupo C.C.")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
                    loc_oPg.txt_4c__gruccus.Value  = loc_oFrm.cCodigoSelecionado
                    loc_oPg.txt_4c__dgruccus.Value = loc_oFrm.cDescricaoSelecionada
                ENDIF
                IF USED("cursor_4c_Gruccus")
                    USE IN cursor_4c_Gruccus
                ENDIF
            ELSE
                MsgErro("Erro ao buscar grupos.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupGruccus")
        ENDTRY
    ENDPROC

    PROCEDURE ContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupContaccus()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupContaccus()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contaccus")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_Contaccus"
                loc_oFrm.DefinirCursor("cursor_4c_Contaccus", "codigos", "descrs", "Conta C.C.")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
                    loc_oPg.txt_4c__contaccus.Value  = loc_oFrm.cCodigoSelecionado
                    loc_oPg.txt_4c__dcontaccus.Value = loc_oFrm.cDescricaoSelecionada
                ENDIF
                IF USED("cursor_4c_Contaccus")
                    USE IN cursor_4c_Contaccus
                ENDIF
            ELSE
                MsgErro("Erro ao buscar contas.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupContaccus")
        ENDTRY
    ENDPROC

    PROCEDURE SemiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 116
            THIS.AbrirLookupSemi()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupSemi()
        LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
        TRY
            loc_cSQL = "SELECT Dopps, hists FROM SigCdOpd ORDER BY Dopps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Semi")
            IF loc_nResult >= 0
                loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oFrm.this_cCursorDestino = "cursor_4c_Semi"
                loc_oFrm.DefinirCursor("cursor_4c_Semi", "Dopps", "hists", "Opera" + CHR(231) + CHR(227) + "o Semiacabados")
                loc_oFrm.Mostrar()
                IF loc_oFrm.this_lSelecionou
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
                    loc_oPg.txt_4c_Semi.Value = loc_oFrm.cCodigoSelecionado
                ENDIF
                IF USED("cursor_4c_Semi")
                    USE IN cursor_4c_Semi
                ENDIF
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormMPD.AbrirLookupSemi")
        ENDTRY
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes, loc_lTemSelecao
        TRY
            loc_oBotoes     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_lTemSelecao = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            WITH loc_oBotoes
                .cmd_4c_Incluir.Enabled    = .T.
                .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
                .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
                .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
                .cmd_4c_Buscar.Enabled     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormMPD.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

### BO (C:\4c\projeto\app\classes\MPDBO.prg):
* MPDBO.prg
* BO: Movimentacoes de Producao (SigCdOpd)

DEFINE CLASS MPDBO AS BusinessBase

  * ============================================================
  * IDENTIFICACAO
  * ============================================================
  this_cDopps      = ""    && char(20) - codigo da operacao (chave de negocio)
  this_nNdopps     = 0     && numeric(3) - numero da operacao
  this_nOrdes      = 0     && numeric(3) - ordem
  this_cCidchaves  = ""    && char(20) - PK tecnica do banco

  * ============================================================
  * ABA OPERACAO
  * ============================================================
  this_nSubns      = 0     && numeric(1) - tem subnivel (1=Sim 2=Nao)
  this_cNivels     = ""    && char(20) - subnivel
  this_cTnivels    = ""    && char(15) - titulo do subnivel
  this_cArtigos    = ""    && char(1)  - artigo do subnivel
  this_cCarqIcones = ""    && char(64) - arquivo icone
  this_nImagems    = 0     && numeric(1) - usa imagem
  this_nBoletos    = 0     && numeric(1) - gera boleto
  this_nMenus      = 0     && numeric(1) - exibe no menu
  this_nAutos      = 0     && numeric(1) - lancamento automatico
  this_nBxautos    = 0     && numeric(1) - baixa automatica
  this_nBtnpags    = 0     && numeric(1) - botao pagamento
  this_nBuscaenvs  = 0     && numeric(1) - busca envio
  this_nApontas    = 0     && numeric(1) - apontamento
  this_nChkdests   = 0     && numeric(2) - checkdests
  this_nCestoqs    = 0     && numeric(1) - centraliza estoques
  this_nChkfases   = 0     && numeric(1) - check fases
  this_nSeqs       = 0     && numeric(1) - sequencia
  this_nInibmens   = 0     && numeric(1) - inibe mensagem
  this_cHists      = ""    && char(30) - historico
  this_nMenfalhas  = 0     && numeric(1) - mensagem de falhas
  this_nBtnrets    = 0     && numeric(1) - botao retrabalho
  this_nBtnincs    = 0     && numeric(1) - botao inserir componente
  this_nExclsubns  = 0     && numeric(1) - excluir subnivel
  this_nEtiqenvs   = 0     && numeric(1) - etiqueta envio
  this_nChktemsubn = 0     && numeric(1) - tem subnivel check
  this_cDopemphs   = ""    && char(20) - operacao empenho
  this_cEmplancs   = ""    && char(3)  - empresa lancamento
  this_nBolops     = 0     && numeric(1) - boleto operacao
  this_nBolcomps   = 0     && numeric(1) - boleto componente
  this_nAgregas    = 0     && numeric(1) - agrega
  this_nTipoops    = 0     && numeric(2) - tipo operacao

  * ============================================================
  * ABA ESTOQUE
  * ============================================================
  this_nDocus      = 0     && numeric(1) - documentos
  this_nEstorigs   = 0     && numeric(1) - estoque origem
  this_nDestinos   = 0     && numeric(1) - destino
  this_nEstdests   = 0     && numeric(1) - estoque destino
  this_nCrepls     = 0     && numeric(1) - crepls
  this_nOrigems    = 0     && numeric(1) - origem (1=usa)
  this_nVends      = 0     && numeric(1) - venda
  this_nFixgorigs  = 0     && bit - fixa grupo origem
  this_nFixcorigs  = 0     && bit - fixa conta origem
  this_nFixgdests  = 0     && bit - fixa grupo destino
  this_nFixcdests  = 0     && bit - fixa conta destino
  this_nConosubs   = 0     && numeric(1) - con ori sub
  this_nCondsubs   = 0     && numeric(1) - con dest sub
  this_nBxoests    = 0     && numeric(1) - baixa estoque origem
  this_nBxdests    = 0     && numeric(1) - baixa estoque destino
  this_cGruorigs   = ""    && char(10) - grupo origem
  this_cGrudests   = ""    && char(10) - grupo destino
  this_cGrvends    = ""    && char(10) - grupo venda
  this_cConorigs   = ""    && char(10) - conta origem
  this_cCondests   = ""    && char(10) - conta destino
  this_nFixgvends  = 0     && bit - fixa grupo venda
  this_nSenhaos    = 0     && numeric(1) - senha origem
  this_nSenhads    = 0     && numeric(1) - senha destino
  this_cMascos     = ""    && char(10) - mascara origem
  this_cMascds     = ""    && char(10) - mascara destino
  this_nNumeras    = 0     && numeric(1) - numeracao

  * ============================================================
  * ABA COMPONENTE
  * ============================================================
  this_nGrcomps    = 0     && numeric(1) - grade componente
  this_nEtiqs      = 0     && numeric(1) - etiqueta
  this_nChkfunds   = 0     && numeric(1) - check fundo
  this_nGrodns     = 0     && numeric(1) - grade ordem
  this_nReinops    = 0     && numeric(1) - reinoperacao
  this_nMatprncdif = 0     && numeric(1) - mat principal diferente
  this_nResumopop  = 0     && numeric(1) - resumo op
  this_nQtdnegs    = 0     && numeric(1) - quantidade negativa
  this_nSeppedras  = 0     && numeric(1) - separacao pedras (1/3/4=sim)
  this_nTrfpesas   = 0     && numeric(1) - transfere pesas
  this_cPqs        = ""    && char(1) - pqs
  this_nPesobals   = 0     && numeric(1) - peso balanca
  this_nEnvobrigs  = 0     && numeric(1) - envio obrigatorio
  this_nMensagens  = 0     && numeric(1) - mensagens
  this_nPagservs   = 0     && numeric(1) - pagamento servico
  this_nGrprods    = 0     && numeric(1) - grade produto
  this_nCompagrus  = 0     && numeric(1) - componente agrupado
  this_nPesofixs   = 0     && numeric(1) - peso fixo
  this_nChkqtdps   = 0     && numeric(1) - chk qtd pcs
  this_cTppadraos  = ""    && char(15) - tipo padrao
  this_cRetalhos   = ""    && char(15) - retalho
  this_nValobrigs  = 0     && numeric(1) - valor obrigatorio
  this_nBxpedfins  = 0     && numeric(1) - baixa ped fins
  this_cPccfases   = ""    && char(10) - pcc fases
  this_nLimqtds    = 0     && numeric(9,3) - limite quantidade
  this_nDiflancs   = 0     && numeric(4,2) - diferenca lancamentos
  this_nDifpesags  = 0     && numeric(9,3) - diferenca pesagem
  this_nSinals     = 0     && numeric(1) - sinal
  this_nLibrpqs    = 0     && numeric(1) - libera pqs
  this_nAgseps     = 0     && numeric(1) - agrupamento separacao
  this_nQuebras    = 0     && numeric(1) - quebra
  this_nCravcers   = 0     && numeric(1) - cravacao cera
  this_nSolcdlbs   = 0     && numeric(1) - sol cd libs
  this_nNcarqtds   = 0     && numeric(1) - n car qtds
  this_cMatpads    = ""    && char(14) - material padrao
  this_nChkpesos   = 0     && numeric(1) - check pesos
  this_nChkmtprs   = 0     && numeric(1) - check mat principal
  this_nChkmetal   = 0     && numeric(1) - check metal

  * ============================================================
  * ABA DOCUMENTO
  * ============================================================
  this_nDckcabec   = 0     && numeric(1) - dck cabecalho
  this_nDckitens   = 0     && numeric(1) - dck itens
  this_nDckresu    = 0     && numeric(1) - dck resumo

  * ============================================================
  * ABA DIVERSAS
  * ============================================================
  this_nCasqtds    = 0     && numeric(2) - casas decimais qtd
  this_nObspads    = 0     && numeric(3) - obs padrao
  this_nObsinis    = 0     && numeric(3) - obs iniciais
  this_nObsfins    = 0     && numeric(3) - obs finais
  this_nCtrlotes   = 0     && numeric(1) - controle lotes
  this_nAcenvs     = 0     && numeric(1) - ac envios
  this_nEnvelopes  = 0     && numeric(1) - envelopes
  this_nChkunis    = 0     && numeric(1) - check unidade
  this_cGrufins    = ""    && char(10) - grupo financeiro
  this_nChkpesotot = 0     && numeric(1) - check peso total
  this_cDopcs      = ""    && char(20) - dop cs
  this_nPccs       = 0     && bit - pccs
  this_nPesmatps   = 0     && bit - peso mat principal
  this_nInibAlts   = 0     && bit - inibe alteracao
  this_nChkctdes   = 0     && numeric(1) - check ct des
  this_cCodtgops   = ""    && char(10) - cod tg ops
  this_cGruccus    = ""    && char(10) - grupo custo cus
  this_cContaccus  = ""    && char(10) - conta custo cus
  this_nChkoplts   = 0     && numeric(1) - check op lotes
  this_cDopsemis   = ""    && char(20) - dop semis
  this_nChksenexc  = 0     && numeric(1) - check senha exclusao
  this_nTpsenexc   = 0     && numeric(1) - tipo senha exclusao

  * ============================================================
  * INIT
  * ============================================================
  FUNCTION Init()
    DODEFAULT()
    this_cTabela     = "SigCdOpd"
    this_cCampoChave = "Dopps"
  ENDFUNC

  *--------------------------------------------------------------------------
  FUNCTION ObterChavePrimaria()
    RETURN THIS.this_cDopps
  ENDFUNC

  *--------------------------------------------------------------------------
  PROCEDURE Buscar(par_cFiltro)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "SELECT Dopps, Ndopps, Ordes, hists FROM SigCdOpd"
      IF !EMPTY(ALLTRIM(par_cFiltro))
        loc_cSQL = loc_cSQL + " WHERE Dopps LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
      ENDIF
      loc_cSQL = loc_cSQL + " ORDER BY Ndopps, Ordes"
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
      IF loc_nResultado >= 0
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROCEDURE CarregarPorCodigo(par_cDopps)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "SELECT * FROM SigCdOpd WHERE Dopps = " + EscaparSQL(par_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
      IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
        THIS.this_lNovoRegistro = .F.
      ENDIF
      IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
      IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
      ENDIF
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    LOCAL loc_lSucesso
    loc_lSucesso = .F.
    IF USED(par_cAliasCursor)
      SELECT (par_cAliasCursor)
      THIS.this_cDopps        = TratarNulo(Dopps,        "C")
      THIS.this_nNdopps       = TratarNulo(Ndopps,       "N")
      THIS.this_nOrdes        = TratarNulo(Ordes,        "N")
      THIS.this_cCidchaves    = TratarNulo(Cidchaves,    "C")
      THIS.this_nSubns        = TratarNulo(subns,        "N")
      THIS.this_nAgregas      = TratarNulo(agregas,      "N")
      THIS.this_cNivels       = TratarNulo(nivels,       "C")
      THIS.this_cTnivels      = TratarNulo(Tnivels,      "C")
      THIS.this_cArtigos      = TratarNulo(Artigos,      "C")
      THIS.this_cCarqIcones   = TratarNulo(cArqIcones,   "C")
      THIS.this_nImagems      = TratarNulo(imagems,      "N")
      THIS.this_nBoletos      = TratarNulo(boletos,      "N")
      THIS.this_nMenus        = TratarNulo(menus,        "N")
      THIS.this_nAutos        = TratarNulo(autos,        "N")
      THIS.this_nBxautos      = TratarNulo(bxautos,      "N")
      THIS.this_nBtnpags      = TratarNulo(btnpags,      "N")
      THIS.this_nBuscaenvs    = TratarNulo(BuscaEnvs,    "N")
      THIS.this_nApontas      = TratarNulo(apontas,      "N")
      THIS.this_nChkdests     = TratarNulo(ChkDests,     "N")
      THIS.this_nCestoqs      = TratarNulo(cestoqs,      "N")
      THIS.this_nChkfases     = TratarNulo(chkfases,     "N")
      THIS.this_nSeqs         = TratarNulo(seqs,         "N")
      THIS.this_nInibmens     = TratarNulo(Inibmens,     "N")
      THIS.this_cHists        = TratarNulo(hists,        "C")
      THIS.this_nMenfalhas    = TratarNulo(Menfalhas,    "N")
      THIS.this_nBtnrets      = TratarNulo(btnrets,      "N")
      THIS.this_nBtnincs      = TratarNulo(btnincs,      "N")
      THIS.this_nExclsubns    = TratarNulo(exclsubns,    "N")
      THIS.this_nEtiqenvs     = TratarNulo(etiqenvs,     "N")
      THIS.this_nChktemsubn   = TratarNulo(chkTemSubn,   "N")
      THIS.this_cDopemphs     = TratarNulo(dopemphs,     "C")
      THIS.this_cEmplancs     = TratarNulo(emplancs,     "C")
      THIS.this_nBolops       = TratarNulo(bolops,       "N")
      THIS.this_nBolcomps     = TratarNulo(bolcomps,     "N")
      THIS.this_nTipoops      = TratarNulo(tipoops,      "N")
      THIS.this_nDocus        = TratarNulo(Docus,        "N")
      THIS.this_nEstorigs     = TratarNulo(EstOrigs,     "N")
      THIS.this_nDestinos     = TratarNulo(Destinos,     "N")
      THIS.this_nEstdests     = TratarNulo(EstDests,     "N")
      THIS.this_nCrepls       = TratarNulo(CRepls,       "N")
      THIS.this_nOrigems      = TratarNulo(Origems,      "N")
      THIS.this_nVends        = TratarNulo(Vends,        "N")
      THIS.this_nFixgorigs    = TratarNulo(FixGOrigs,    "N")
      THIS.this_nFixcorigs    = TratarNulo(FixCOrigs,    "N")
      THIS.this_nFixgdests    = TratarNulo(FixGDests,    "N")
      THIS.this_nFixcdests    = TratarNulo(FixCDests,    "N")
      THIS.this_nConosubs     = TratarNulo(conosubs,     "N")
      THIS.this_nCondsubs     = TratarNulo(condsubs,     "N")
      THIS.this_nBxoests      = TratarNulo(BxOEsts,      "N")
      THIS.this_nBxdests      = TratarNulo(BxDEsts,      "N")
      THIS.this_cGruorigs     = TratarNulo(GruOrigs,     "C")
      THIS.this_cGrudests     = TratarNulo(GruDests,     "C")
      THIS.this_cGrvends      = TratarNulo(grvends,      "C")
      THIS.this_cConorigs     = TratarNulo(ConOrigs,     "C")
      THIS.this_cCondests     = TratarNulo(ConDests,     "C")
      THIS.this_nFixgvends    = TratarNulo(FixGVends,    "N")
      THIS.this_nSenhaos      = TratarNulo(Senhaos,      "N")
      THIS.this_nSenhads      = TratarNulo(Senhads,      "N")
      THIS.this_cMascos       = TratarNulo(mascos,       "C")
      THIS.this_cMascds       = TratarNulo(mascds,       "C")
      THIS.this_nNumeras      = TratarNulo(Numeras,      "N")
      THIS.this_nGrcomps      = TratarNulo(grcomps,      "N")
      THIS.this_nEtiqs        = TratarNulo(etiqs,        "N")
      THIS.this_nChkfunds     = TratarNulo(chkfunds,     "N")
      THIS.this_nGrodns       = TratarNulo(grodns,       "N")
      THIS.this_nReinops      = TratarNulo(reinops,      "N")
      THIS.this_nMatprncdif   = TratarNulo(MatPrncDif,   "N")
      THIS.this_nResumopop    = TratarNulo(ResumoPOp,    "N")
      THIS.this_nQtdnegs      = TratarNulo(QtdNegs,      "N")
      THIS.this_nSeppedras    = TratarNulo(seppedras,    "N")
      THIS.this_nTrfpesas     = TratarNulo(trfpesas,     "N")
      THIS.this_cPqs          = TratarNulo(Pqs,          "C")
      THIS.this_nPesobals     = TratarNulo(PesoBals,     "N")
      THIS.this_nEnvobrigs    = TratarNulo(EnvObrigs,    "N")
      THIS.this_nMensagens    = TratarNulo(mensagens,    "N")
      THIS.this_nPagservs     = TratarNulo(pagservs,     "N")
      THIS.this_nGrprods      = TratarNulo(grprods,      "N")
      THIS.this_nCompagrus    = TratarNulo(compagrus,    "N")
      THIS.this_nPesofixs     = TratarNulo(pesofixs,     "N")
      THIS.this_nChkqtdps     = TratarNulo(CHKQTDPS,    "N")
      THIS.this_cTppadraos    = TratarNulo(TpPadraos,    "C")
      THIS.this_cRetalhos     = TratarNulo(retalhos,     "C")
      THIS.this_nValobrigs    = TratarNulo(ValObrigs,    "N")
      THIS.this_nBxpedfins    = TratarNulo(BxPedFins,    "N")
      THIS.this_cPccfases     = TratarNulo(PccFases,     "C")
      THIS.this_nLimqtds      = TratarNulo(LimQtds,      "N")
      THIS.this_nDiflancs     = TratarNulo(diflancs,     "N")
      THIS.this_nDifpesags    = TratarNulo(difpesags,    "N")
      THIS.this_nSinals       = TratarNulo(Sinals,       "N")
      THIS.this_nLibrpqs      = TratarNulo(Librpqs,      "N")
      THIS.this_nAgseps       = TratarNulo(agseps,       "N")
      THIS.this_nQuebras      = TratarNulo(quebras,      "N")
      THIS.this_nCravcers     = TratarNulo(CravCers,     "N")
      THIS.this_nSolcdlbs     = TratarNulo(SolCdlbs,    "N")
      THIS.this_nNcarqtds     = TratarNulo(nCarQtds,    "N")
      THIS.this_cMatpads      = TratarNulo(MatPads,     "C")
      THIS.this_nChkpesos     = TratarNulo(chkPesos,    "N")
      THIS.this_nChkmtprs     = TratarNulo(ChkMtPrs,    "N")
      THIS.this_nChkmetal     = TratarNulo(chkMetal,    "N")
      THIS.this_nDckcabec     = TratarNulo(dckcabec,    "N")
      THIS.this_nDckitens     = TratarNulo(dckItens,    "N")
      THIS.this_nDckresu      = TratarNulo(dckResu,     "N")
      THIS.this_nCasqtds      = TratarNulo(CasQtds,    "N")
      THIS.this_nObspads      = TratarNulo(obspads,     "N")
      THIS.this_nObsinis      = TratarNulo(obsinis,     "N")
      THIS.this_nObsfins      = TratarNulo(obsfins,     "N")
      THIS.this_nCtrlotes     = TratarNulo(CtrLotes,    "N")
      THIS.this_nAcenvs       = TratarNulo(AcEnvs,      "N")
      THIS.this_nEnvelopes    = TratarNulo(envelopes,   "N")
      THIS.this_nChkunis      = TratarNulo(chkunis,     "N")
      THIS.this_cGrufins      = TratarNulo(grufins,     "C")
      THIS.this_nChkpesotot   = TratarNulo(chkPesoTot, "N")
      THIS.this_cDopcs        = TratarNulo(dopcs,       "C")
      THIS.this_nPccs         = TratarNulo(pccs,        "N")
      THIS.this_nPesmatps     = TratarNulo(pesmatps,    "N")
      THIS.this_nInibAlts     = TratarNulo(InibAlts,    "N")
      THIS.this_nChkctdes     = TratarNulo(ChkCtDes,   "N")
      THIS.this_cCodtgops     = TratarNulo(CodTgOps,   "C")
      THIS.this_cGruccus      = TratarNulo(gruccus,    "C")
      THIS.this_cContaccus    = TratarNulo(contaccus,  "C")
      THIS.this_nChkoplts     = TratarNulo(chkoplts,   "N")
      THIS.this_cDopsemis     = TratarNulo(dopsemis,   "C")
      THIS.this_nChksenexc    = TratarNulo(chksenexc,  "N")
      THIS.this_nTpsenexc     = TratarNulo(tpsenexc,   "N")
      loc_lSucesso = .T.
    ENDIF
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE Inserir()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "INSERT INTO SigCdOpd (" + ;
                 "Dopps, Ndopps, Ordes, Cidchaves," + ;
                 " subns, agregas, nivels, Tnivels, Artigos, cArqIcones," + ;
                 " imagems, boletos, menus, autos, bxautos, btnpags, BuscaEnvs," + ;
                 " apontas, ChkDests, cestoqs, chkfases, seqs, Inibmens, hists," + ;
                 " Menfalhas, btnrets, btnincs, exclsubns, etiqenvs, chkTemSubn," + ;
                 " dopemphs, emplancs, bolops, bolcomps, tipoops," + ;
                 " Docus, EstOrigs, Destinos, EstDests, CRepls, Origems, Vends," + ;
                 " FixGOrigs, FixCOrigs, FixGDests, FixCDests, conosubs, condsubs," + ;
                 " BxOEsts, BxDEsts, GruOrigs, GruDests, grvends, ConOrigs, ConDests," + ;
                 " FixGVends, Senhaos, Senhads, mascos, mascds, Numeras," + ;
                 " grcomps, etiqs, chkfunds, grodns, reinops, MatPrncDif, ResumoPOp," + ;
                 " QtdNegs, seppedras, trfpesas, Pqs, PesoBals, EnvObrigs, mensagens," + ;
                 " pagservs, grprods, compagrus, pesofixs, CHKQTDPS, TpPadraos, retalhos," + ;
                 " ValObrigs, BxPedFins, PccFases, LimQtds, diflancs, difpesags, Sinals," + ;
                 " Librpqs, agseps, quebras, CravCers, SolCdlbs, nCarQtds, MatPads," + ;
                 " chkPesos, ChkMtPrs, chkMetal," + ;
                 " dckcabec, dckItens, dckResu," + ;
                 " CasQtds, obspads, obsinis, obsfins, CtrLotes, AcEnvs, envelopes," + ;
                 " chkunis, grufins, chkPesoTot, dopcs, pccs, pesmatps, InibAlts," + ;
                 " ChkCtDes, CodTgOps, gruccus, contaccus, chkoplts, dopsemis, chksenexc, tpsenexc" + ;
                 ") VALUES (" + ;
                 EscaparSQL(THIS.this_cDopps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNdopps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nOrdes) + "," + ;
                 EscaparSQL(THIS.this_cCidchaves) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSubns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAgregas) + "," + ;
                 EscaparSQL(THIS.this_cNivels) + "," + ;
                 EscaparSQL(THIS.this_cTnivels) + "," + ;
                 EscaparSQL(THIS.this_cArtigos) + "," + ;
                 EscaparSQL(THIS.this_cCarqIcones) + "," + ;
                 FormatarNumeroSQL(THIS.this_nImagems) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBoletos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMenus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAutos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxautos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnpags) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBuscaenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nApontas) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCestoqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkfases) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSeqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nInibmens) + "," + ;
                 EscaparSQL(THIS.this_cHists) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMenfalhas) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnrets) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnincs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nExclsubns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEtiqenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChktemsubn) + "," + ;
                 EscaparSQL(THIS.this_cDopemphs) + "," + ;
                 EscaparSQL(THIS.this_cEmplancs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBolops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBolcomps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTipoops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDocus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEstorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDestinos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEstdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCrepls) + "," + ;
                 FormatarNumeroSQL(THIS.this_nOrigems) + "," + ;
                 FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixcorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixcdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nConosubs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCondsubs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxoests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxdests) + "," + ;
                 EscaparSQL(THIS.this_cGruorigs) + "," + ;
                 EscaparSQL(THIS.this_cGrudests) + "," + ;
                 EscaparSQL(THIS.this_cGrvends) + "," + ;
                 EscaparSQL(THIS.this_cConorigs) + "," + ;
                 EscaparSQL(THIS.this_cCondests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgvends) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSenhaos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSenhads) + "," + ;
                 EscaparSQL(THIS.this_cMascos) + "," + ;
                 EscaparSQL(THIS.this_cMascds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNumeras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrcomps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEtiqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkfunds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrodns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nReinops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMatprncdif) + "," + ;
                 FormatarNumeroSQL(THIS.this_nResumopop) + "," + ;
                 FormatarNumeroSQL(THIS.this_nQtdnegs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSeppedras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                 EscaparSQL(THIS.this_cPqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesobals) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEnvobrigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMensagens) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPagservs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrprods) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesofixs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkqtdps) + "," + ;
                 EscaparSQL(THIS.this_cTppadraos) + "," + ;
                 EscaparSQL(THIS.this_cRetalhos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nValobrigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxpedfins) + "," + ;
                 EscaparSQL(THIS.this_cPccfases) + "," + ;
                 FormatarNumeroSQL(THIS.this_nLimqtds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDiflancs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                 FormatarNumeroSQL(THIS.this_nLibrpqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAgseps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nQuebras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCravcers) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSolcdlbs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNcarqtds) + "," + ;
                 EscaparSQL(THIS.this_cMatpads) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkpesos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkmtprs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkmetal) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckcabec) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckitens) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckresu) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCasqtds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObspads) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObsinis) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObsfins) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAcenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEnvelopes) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkunis) + "," + ;
                 EscaparSQL(THIS.this_cGrufins) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkpesotot) + "," + ;
                 EscaparSQL(THIS.this_cDopcs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPccs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesmatps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nInibAlts) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkctdes) + "," + ;
                 EscaparSQL(THIS.this_cCodtgops) + "," + ;
                 EscaparSQL(THIS.this_cGruccus) + "," + ;
                 EscaparSQL(THIS.this_cContaccus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkoplts) + "," + ;
                 EscaparSQL(THIS.this_cDopsemis) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChksenexc) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTpsenexc) + ;
                 ")"
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("INSERT")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE Atualizar()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "UPDATE SigCdOpd SET" + ;
                 " Ndopps = " + FormatarNumeroSQL(THIS.this_nNdopps) + "," + ;
                 " Ordes = " + FormatarNumeroSQL(THIS.this_nOrdes) + "," + ;
                 " subns = " + FormatarNumeroSQL(THIS.this_nSubns) + "," + ;
                 " agregas = " + FormatarNumeroSQL(THIS.this_nAgregas) + "," + ;
                 " nivels = " + EscaparSQL(THIS.this_cNivels) + "," + ;
                 " Tnivels = " + EscaparSQL(THIS.this_cTnivels) + "," + ;
                 " Artigos = " + EscaparSQL(THIS.this_cArtigos) + "," + ;
                 " cArqIcones = " + EscaparSQL(THIS.this_cCarqIcones) + "," + ;
                 " imagems = " + FormatarNumeroSQL(THIS.this_nImagems) + "," + ;
                 " boletos = " + FormatarNumeroSQL(THIS.this_nBoletos) + "," + ;
                 " menus = " + FormatarNumeroSQL(THIS.this_nMenus) + "," + ;
                 " autos = " + FormatarNumeroSQL(THIS.this_nAutos) + "," + ;
                 " bxautos = " + FormatarNumeroSQL(THIS.this_nBxautos) + "," + ;
                 " btnpags = " + FormatarNumeroSQL(THIS.this_nBtnpags) + "," + ;
                 " BuscaEnvs = " + FormatarNumeroSQL(THIS.this_nBuscaenvs) + "," + ;
                 " apontas = " + FormatarNumeroSQL(THIS.this_nApontas) + "," + ;
                 " ChkDests = " + FormatarNumeroSQL(THIS.this_nChkdests) + "," + ;
                 " cestoqs = " + FormatarNumeroSQL(THIS.this_nCestoqs) + "," + ;
                 " chkfases = " + FormatarNumeroSQL(THIS.this_nChkfases) + "," + ;
                 " seqs = " + FormatarNumeroSQL(THIS.this_nSeqs) + "," + ;
                 " Inibmens = " + FormatarNumeroSQL(THIS.this_nInibmens) + "," + ;
                 " hists = " + EscaparSQL(THIS.this_cHists) + "," + ;
                 " Menfalhas = " + FormatarNumeroSQL(THIS.this_nMenfalhas) + "," + ;
                 " btnrets = " + FormatarNumeroSQL(THIS.this_nBtnrets) + "," + ;
                 " btnincs = " + FormatarNumeroSQL(THIS.this_nBtnincs) + "," + ;
                 " exclsubns = " + FormatarNumeroSQL(THIS.this_nExclsubns) + "," + ;
                 " etiqenvs = " + FormatarNumeroSQL(THIS.this_nEtiqenvs) + "," + ;
                 " chkTemSubn = " + FormatarNumeroSQL(THIS.this_nChktemsubn) + "," + ;
                 " dopemphs = " + EscaparSQL(THIS.this_cDopemphs) + "," + ;
                 " emplancs = " + EscaparSQL(THIS.this_cEmplancs) + "," + ;
                 " bolops = " + FormatarNumeroSQL(THIS.this_nBolops) + "," + ;
                 " bolcomps = " + FormatarNumeroSQL(THIS.this_nBolcomps) + "," + ;
                 " tipoops = " + FormatarNumeroSQL(THIS.this_nTipoops) + "," + ;
                 " Docus = " + FormatarNumeroSQL(THIS.this_nDocus) + "," + ;
                 " EstOrigs = " + FormatarNumeroSQL(THIS.this_nEstorigs) + "," + ;
                 " Destinos = " + FormatarNumeroSQL(THIS.this_nDestinos) + "," + ;
                 " EstDests = " + FormatarNumeroSQL(THIS.this_nEstdests) + "," + ;
                 " CRepls = " + FormatarNumeroSQL(THIS.this_nCrepls) + "," + ;
                 " Origems = " + FormatarNumeroSQL(THIS.this_nOrigems) + "," + ;
                 " Vends = " + FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                 " FixGOrigs = " + FormatarNumeroSQL(THIS.this_nFixgorigs) + "," + ;
                 " FixCOrigs = " + FormatarNumeroSQL(THIS.this_nFixcorigs) + "," + ;
                 " FixGDests = " + FormatarNumeroSQL(THIS.this_nFixgdests) + "," + ;
                 " FixCDests = " + FormatarNumeroSQL(THIS.this_nFixcdests) + "," + ;
                 " conosubs = " + FormatarNumeroSQL(THIS.this_nConosubs) + "," + ;
                 " condsubs = " + FormatarNumeroSQL(THIS.this_nCondsubs) + "," + ;
                 " BxOEsts = " + FormatarNumeroSQL(THIS.this_nBxoests) + "," + ;
                 " BxDEsts = " + FormatarNumeroSQL(THIS.this_nBxdests) + "," + ;
                 " GruOrigs = " + EscaparSQL(THIS.this_cGruorigs) + "," + ;
                 " GruDests = " + EscaparSQL(THIS.this_cGrudests) + "," + ;
                 " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                 " ConOrigs = " + EscaparSQL(THIS.this_cConorigs) + "," + ;
                 " ConDests = " + EscaparSQL(THIS.this_cCondests) + "," + ;
                 " FixGVends = " + FormatarNumeroSQL(THIS.this_nFixgvends) + "," + ;
                 " Senhaos = " + FormatarNumeroSQL(THIS.this_nSenhaos) + "," + ;
                 " Senhads = " + FormatarNumeroSQL(THIS.this_nSenhads) + "," + ;
                 " mascos = " + EscaparSQL(THIS.this_cMascos) + "," + ;
                 " mascds = " + EscaparSQL(THIS.this_cMascds) + "," + ;
                 " Numeras = " + FormatarNumeroSQL(THIS.this_nNumeras) + "," + ;
                 " grcomps = " + FormatarNumeroSQL(THIS.this_nGrcomps) + "," + ;
                 " etiqs = " + FormatarNumeroSQL(THIS.this_nEtiqs) + "," + ;
                 " chkfunds = " + FormatarNumeroSQL(THIS.this_nChkfunds) + "," + ;
                 " grodns = " + FormatarNumeroSQL(THIS.this_nGrodns) + "," + ;
                 " reinops = " + FormatarNumeroSQL(THIS.this_nReinops) + "," + ;
                 " MatPrncDif = " + FormatarNumeroSQL(THIS.this_nMatprncdif) + "," + ;
                 " ResumoPOp = " + FormatarNumeroSQL(THIS.this_nResumopop) + "," + ;
                 " QtdNegs = " + FormatarNumeroSQL(THIS.this_nQtdnegs) + "," + ;
                 " seppedras = " + FormatarNumeroSQL(THIS.this_nSeppedras) + "," + ;
                 " trfpesas = " + FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                 " Pqs = " + EscaparSQL(THIS.this_cPqs) + "," + ;
                 " PesoBals = " + FormatarNumeroSQL(THIS.this_nPesobals) + "," + ;
                 " EnvObrigs = " + FormatarNumeroSQL(THIS.this_nEnvobrigs) + "," + ;
                 " mensagens = " + FormatarNumeroSQL(THIS.this_nMensagens) + "," + ;
                 " pagservs = " + FormatarNumeroSQL(THIS.this_nPagservs) + "," + ;
                 " grprods = " + FormatarNumeroSQL(THIS.this_nGrprods) + "," + ;
                 " compagrus = " + FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                 " pesofixs = " + FormatarNumeroSQL(THIS.this_nPesofixs) + "," + ;
                 " CHKQTDPS = " + FormatarNumeroSQL(THIS.this_nChkqtdps) + "," + ;
                 " TpPadraos = " + EscaparSQL(THIS.this_cTppadraos) + "," + ;
                 " retalhos = " + EscaparSQL(THIS.this_cRetalhos) + "," + ;
                 " ValObrigs = " + FormatarNumeroSQL(THIS.this_nValobrigs) + "," + ;
                 " BxPedFins = " + FormatarNumeroSQL(THIS.this_nBxpedfins) + "," + ;
                 " PccFases = " + EscaparSQL(THIS.this_cPccfases) + "," + ;
                 " LimQtds = " + FormatarNumeroSQL(THIS.this_nLimqtds) + "," + ;
                 " diflancs = " + FormatarNumeroSQL(THIS.this_nDiflancs) + "," + ;
                 " difpesags = " + FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                 " Sinals = " + FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                 " Librpqs = " + FormatarNumeroSQL(THIS.this_nLibrpqs) + "," + ;
                 " agseps = " + FormatarNumeroSQL(THIS.this_nAgseps) + "," + ;
                 " quebras = " + FormatarNumeroSQL(THIS.this_nQuebras) + "," + ;
                 " CravCers = " + FormatarNumeroSQL(THIS.this_nCravcers) + "," + ;
                 " SolCdlbs = " + FormatarNumeroSQL(THIS.this_nSolcdlbs) + "," + ;
                 " nCarQtds = " + FormatarNumeroSQL(THIS.this_nNcarqtds) + "," + ;
                 " MatPads = " + EscaparSQL(THIS.this_cMatpads) + "," + ;
                 " chkPesos = " + FormatarNumeroSQL(THIS.this_nChkpesos) + "," + ;
                 " ChkMtPrs = " + FormatarNumeroSQL(THIS.this_nChkmtprs) + "," + ;
                 " chkMetal = " + FormatarNumeroSQL(THIS.this_nChkmetal) + "," + ;
                 " dckcabec = " + FormatarNumeroSQL(THIS.this_nDckcabec) + "," + ;
                 " dckItens = " + FormatarNumeroSQL(THIS.this_nDckitens) + "," + ;
                 " dckResu = " + FormatarNumeroSQL(THIS.this_nDckresu) + "," + ;
                 " CasQtds = " + FormatarNumeroSQL(THIS.this_nCasqtds) + "," + ;
                 " obspads = " + FormatarNumeroSQL(THIS.this_nObspads) + "," + ;
                 " obsinis = " + FormatarNumeroSQL(THIS.this_nObsinis) + "," + ;
                 " obsfins = " + FormatarNumeroSQL(THIS.this_nObsfins) + "," + ;
                 " CtrLotes = " + FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                 " AcEnvs = " + FormatarNumeroSQL(THIS.this_nAcenvs) + "," + ;
                 " envelopes = " + FormatarNumeroSQL(THIS.this_nEnvelopes) + "," + ;
                 " chkunis = " + FormatarNumeroSQL(THIS.this_nChkunis) + "," + ;
                 " grufins = " + EscaparSQL(THIS.this_cGrufins) + "," + ;
                 " chkPesoTot = " + FormatarNumeroSQL(THIS.this_nChkpesotot) + "," + ;
                 " dopcs = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                 " pccs = " + FormatarNumeroSQL(THIS.this_nPccs) + "," + ;
                 " pesmatps = " + FormatarNumeroSQL(THIS.this_nPesmatps) + "," + ;
                 " InibAlts = " + FormatarNumeroSQL(THIS.this_nInibAlts) + "," + ;
                 " ChkCtDes = " + FormatarNumeroSQL(THIS.this_nChkctdes) + "," + ;
                 " CodTgOps = " + EscaparSQL(THIS.this_cCodtgops) + "," + ;
                 " gruccus = " + EscaparSQL(THIS.this_cGruccus) + "," + ;
                 " contaccus = " + EscaparSQL(THIS.this_cContaccus) + "," + ;
                 " chkoplts = " + FormatarNumeroSQL(THIS.this_nChkoplts) + "," + ;
                 " dopsemis = " + EscaparSQL(THIS.this_cDopsemis) + "," + ;
                 " chksenexc = " + FormatarNumeroSQL(THIS.this_nChksenexc) + "," + ;
                 " tpsenexc = " + FormatarNumeroSQL(THIS.this_nTpsenexc) + ;
                 " WHERE Dopps = " + EscaparSQL(THIS.this_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("UPDATE")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE ExecutarExclusao()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "DELETE FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("DELETE")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

ENDDEFINE

