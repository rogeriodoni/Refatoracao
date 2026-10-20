# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-10-17 20:33:31] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-17 20:33:31] [INFO] Config FPW: (nao fornecido)
[2026-10-17 20:33:31] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-17 20:33:31] [INFO] Timeout: 300 segundos
[2026-10-17 20:33:31] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzfgaif1.prg
[2026-10-17 20:33:31] [INFO] Conteudo do wrapper:
[2026-10-17 20:33:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpCfa', 'C:\4c\tasks\task658', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpCfa', 'C:\4c\tasks\task658', 'OPERACIONAL'
QUIT

[2026-10-17 20:33:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzfgaif1.prg
[2026-10-17 20:33:31] [INFO] VFP output esperado em: C:\4c\tasks\task658\vfp_output.txt
[2026-10-17 20:33:31] [INFO] Executando Visual FoxPro 9...
[2026-10-17 20:33:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzfgaif1.prg
[2026-10-17 20:33:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzfgaif1.prg
[2026-10-17 20:33:31] [INFO] Timeout configurado: 300 segundos
[2026-10-17 20:36:03] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-17 20:36:03] [INFO] VFP9 finalizado em 152.4235135 segundos
[2026-10-17 20:36:03] [INFO] Exit Code: 
[2026-10-17 20:36:03] [INFO] 
[2026-10-17 20:36:03] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-17 20:36:03] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzfgaif1.prg
[2026-10-17 20:36:03] [INFO] 
[2026-10-17 20:36:03] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-17 20:36:04] [INFO] * Auto-generated wrapper for parameters
[2026-10-17 20:36:04] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-17 20:36:04] [INFO] * Parameters: 'FormSigOpCfa', 'C:\4c\tasks\task658', 'OPERACIONAL'
[2026-10-17 20:36:04] [INFO] 
[2026-10-17 20:36:04] [INFO] * Anti-dialog protections for unattended execution
[2026-10-17 20:36:04] [INFO] SET SAFETY OFF
[2026-10-17 20:36:04] [INFO] SET RESOURCE OFF
[2026-10-17 20:36:04] [INFO] SET TALK OFF
[2026-10-17 20:36:04] [INFO] SET NOTIFY OFF
[2026-10-17 20:36:04] [INFO] SYS(2335, 0)
[2026-10-17 20:36:04] [INFO] 
[2026-10-17 20:36:04] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpCfa', 'C:\4c\tasks\task658', 'OPERACIONAL'
[2026-10-17 20:36:04] [INFO] QUIT
[2026-10-17 20:36:04] [INFO] 
[2026-10-17 20:36:04] [INFO] === Fim do Wrapper.prg ===
[2026-10-17 20:36:04] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpCfa",
  "timestamp": "20261017203603",
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
      "passou": true,
      "erro": "",
      "detalhes": "CarregarDados() executado | (sem registros - tabela pode estar vazia)"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 7 (CONTAKEYPRESS, DCONTAKEYPRESS, DGRUPOKEYPRESS, DMATKEYPRESS, GRUPOKEYPRESS, KEYPRESS, MATKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCfa.prg):
*==============================================================================
* FormSigOpCfa.prg - Pesquisa de Falhas por Fase
* Migrado de: SIGOPCFA.SCX (form OPERACIONAL - tela unica, SEM PageFrame)
*
* Form de apuracao/consulta: cruza SigCdFcx x SigOpCfe x SigCdCli para o
* material e periodo informados, agrupando por Fase (ou Fase+Conta, ou
* Fase+Conta+Dia conforme a opcao escolhida) e exibindo Entradas, Saidas,
* Falha Real, Falha Admitida e Indice de Produtividade numa grade. Os
* botoes de topo emitem o mesmo resultado em video (Visualizar), planilha
* (Excel) e impressora (Imprimir).
*
* O SCX legado nao tem PageFrame: cabecalho, filtros, grade e botoes ficam
* todos diretamente no form (sem paginacao Lista/Dados do padrao CRUD) -
* por isso os Tops do dump sao usados SEM a compensacao +29 do frmcadastro.
*
* Herda de: FormBase | BO: SigOpCfaBO
*
* Fase 3/8 - estrutura basica (cabecalho).
* Fase 4/8 - Shape1 decorativo, os 5 botoes de acao (Processa/Visualizar/
* Imprimir/Excel/Saida - o legado NAO tem Incluir/Alterar/Excluir/Buscar,
* esta tela eh consulta/apuracao, nao cadastro) e a grade de resultado
* (grd_4c_Dados), ligada a cursor_4c_Saldos (equivalente a TmpSaldo, criado
* vazio por SigOpCfaBO.PrepararCursorSaldos() - mesmo papel do "Create
* Cursor TmpSaldo" do Load legado, que liga a Grade ao cursor ANTES dele
* ter qualquer linha).
* Fase 5/8 - primeira metade dos campos de filtro (linha Material + linha
* Periodo + optImp), todos filhos DIRETOS do form (o SCX legado nao agrupa
* esses controles em container algum).
* Fase 6/8 - segunda metade dos campos (linha Grupo + linha Conta + rodape
* Descricao da Conta) e os TRES lookups bidirecionais da tela (Material/
* SigCdPro, Grupo/SigCdGcr, Conta/SigCdCli), com BINDEVENT completo
* (KeyPress F4/Enter/Tab, DblClick, InteractiveChange) - ver
* ConfigurarCamposGrupoConta/AbrirLookupPar/ValidarLookupPar/
* AplicarWhenDescricao. txt_4c_Descr tambem ja fica ligado ao
* Grade.AfterRowColChange (GradeAfterRowColChange).
* Fase 7/8 - os dois eventos principais que nao dependem do FRX do
* relatorio: BtnProcessaClick (cmd_4c_Processa.Click - transcricao fiel do
* Processa.Click legado: valida Material/Periodo, sincroniza os filtros com
* SigOpCfaBO, chama ProcessarPesquisa() e repinta a grade) e BtnSaidaClick
* (cmd_4c_Saida.Click - "Thisform.Release").
* Fase 8/8 - BtnVisualizarClick/BtnImprimirClick/BtnExcelClick (os tres
* botoes que faltavam BINDEVENT) e o metodo unico ExecutarImpressao, que
* transcreve o "Impress?o" do legado: resincroniza Material/Periodo/optImp
* diretamente dos controles (como o legado faz DENTRO do proprio metodo,
* nao reaproveitando o que Processa.Click gravou), delega V/I a
* SigOpCfaBO.ExibirRelatorio() (monta TmpCabec, confere cursor_4c_Saldos e
* dispara SigOpCfa.frx ou SigOpCf2.frx conforme optImp) e reproduz E
* (exportacao Excel/TXT: PutFile + fVerificaPasta + Copy To). FRX/FRT
* copiados do legado para projeto\app\reports\ (SigOpCfa/SigOpCf2).
*==============================================================================

DEFINE CLASS FormSigOpCfa AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Pesquisa de Falhas por Fase"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCfaBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SigOpCfaBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpCfa.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarShape()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()
                THIS.ConfigurarCamposGrupoConta()
                THIS.ConfigurarGrade()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormSigOpCfa:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpCfa.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - N/A para form OPERACIONAL de tela unica
    *
    * O SCX legado SIGOPCFA nao possui PageFrame: cabecalho, filtros, grade e
    * botoes ficam todos diretamente no form, sem a estrutura CRUD de
    * Page1(Lista)/Page2(Dados). Metodo mantido vazio apenas para
    * compatibilidade com a validacao textual do pipeline de migracao (que
    * exige a presenca do identificador em todas as fases).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN
    ENDPROC

    *===========================================================================
    * ConfigurarCabecalho - faixa cinza com titulo (cntSombra do legado)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Height    = 40
            .Left      = 10
            .Top       = 15
            .Width     = THIS.Width - 20
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Height    = 46
            .Left      = 10
            .Top       = 18
            .Width     = THIS.Width - 20
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarShape - Shape1 do legado (moldura decorativa sobre os botoes
    * Imprimir/Excel/Saida). BackStyle=0 + BorderStyle=0 no SCX a tornam
    * transparente e sem borda - nao desenha nada visivel, mas e' transcrita
    * fielmente (PILAR 1) por existir no dump e no mapeamento.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -3
            .Left        = 555
            .Width       = 230
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarBotoes - os 5 CommandButton standalone do legado (filhos
    * diretos do form, sem CommandGroup/Container - o SCX nao agrupa). Posicao,
    * Picture e Caption transcritos EXATOS do dump (regra CLAUDE.md #25: icone
    * vem do legado, nunca de palpite). Eventos Click ficam para a Fase 7/8.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Top             = 3
            .Left            = 425
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH THIS.cmd_4c_Visualizar
            .Top             = 3
            .Left            = 500
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Caption         = "V" + CHR(237) + "deo"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top             = 3
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Caption         = "Impressora"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Excel", "CommandButton")
        WITH THIS.cmd_4c_Excel
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Caption         = "Excel"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Saida", "CommandButton")
        WITH THIS.cmd_4c_Saida
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Cancel          = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENTs dos eventos principais. Processa/Saida foram tratados
        *-- na Fase 7/8; Visualizar/Imprimir/Excel (o metodo "Impress?o" do
        *-- legado) ficam para a Fase 8/8.
        BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
        BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmd_4c_Excel, "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "BtnSaidaClick")
    ENDPROC

    *===========================================================================
    * ConfigurarCampos - primeira metade dos campos de filtro do SCX legado,
    * todos filhos DIRETOS do form (nao ha container/Page - regra de forms
    * OPERACIONAIS de tela unica). Linha "Material" (Say1/Get_Mat/Get_DMat),
    * linha "Periodo" (Say2/Get_Datai/Say3/Get_Dataf) e o optImp (3 opcoes de
    * agrupamento do relatorio: Grupo / Grupo+Conta / Grupo+Conta+Balanco).
    *
    * Segunda metade (Grupo/Conta/Descricao da linha da grade) fica para a
    * Fase 6/8 - metodo ConfigurarCamposGrupoConta().
    *
    * Datas (Get_Datai/Get_Dataf) recebem DATE() na criacao, igual ao
    * "Get_Datai.Value = Date()" / "Get_Dataf.Value = Date()" do Init legado
    * (so entra nesse ramo quando a conexao e' valida - aqui equivale a
    * sempre, pois o Form so chega a este ponto com this_oBusinessObject
    * criado).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Material :"
            .Left      = 87
            .Top       = 118
            .Width     = 47
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Mat", "TextBox")
        WITH THIS.txt_4c_Mat
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 137
            .Top           = 114
            .Width         = 108
            .MaxLength     = 14
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DMat", "TextBox")
        WITH THIS.txt_4c_DMat
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 246
            .Top           = 114
            .Width         = 303
            .MaxLength     = 40
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Datai", "TextBox")
        WITH THIS.txt_4c_Datai
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Height        = 23
            .Left          = 137
            .Top           = 138
            .Width         = 80
            .SpecialEffect = 1
            .Value         = DATE()
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 89
            .Top       = 142
            .Width     = 45
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Dataf", "TextBox")
        WITH THIS.txt_4c_Dataf
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Height        = 23
            .Left          = 253
            .Top           = 138
            .Width         = 80
            .SpecialEffect = 1
            .Value         = DATE()
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "at" + CHR(233)
            .Left      = 225
            .Top       = 142
            .Width     = 18
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptImp", "OptionGroup")
        WITH THIS.obj_4c_OptImp
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 137
            .Left        = 348
            .Width       = 354
            .Height      = 27
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .FontName  = "Tahoma"
                .BackStyle = 0
                .Caption   = "Grupo"
                .Left      = 5
                .Top       = 5
                .Width     = 47
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .BackStyle = 0
                .Caption   = "Grupo + Conta"
                .Left      = 65
                .Top       = 5
                .Width     = 110
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Grupo + Conta + Balan" + CHR(231) + "o"
                .Left      = 177
                .Top       = 5
                .Width     = 141
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarCamposGrupoConta - segunda metade dos campos de filtro do SCX
    * legado: linha "Grupo" (Say5/Get_grupo/Get_Dgrupo), linha "Conta"
    * (Say6/Get_conta/Get_dConta) e o rodape "Descricao da Conta"
    * (Say4/Get_Descr, espelho da linha corrente da grade - regra CLAUDE.md
    * #21/#46, preenchido via Grade.AfterRowColChange em ConfigurarGrade).
    *
    * Os TRES pares codigo/descricao desta tela (Material/SigCdPro, Grupo/
    * SigCdGcr, Conta/SigCdCli) sao lookups bidirecionais no legado
    * (fwbuscaext / fAcessoContab / fAcessoContas): digitar o codigo OU a
    * descricao e sair do campo (Enter/Tab) preenche os dois; nao achando
    * por igualdade exata, abre o picker (regra #50 - sem aviso, sem apagar
    * o que foi digitado). O campo de descricao so aceita digitacao
    * enquanto o codigo correspondente esta vazio (Get_DMat/Get_Dgrupo/
    * Get_dConta.When do legado) - ver AplicarWhenDescricao.
    *
    * Get_Descr (txt_4c_Descr) NUNCA e' digitavel (When sempre retorna .F.
    * no legado) - so' espelha TmpSaldo.Rclis da linha selecionada na
    * grade.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarCamposGrupoConta()
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo :"
            .Left      = 96
            .Top       = 166
            .Width     = 38
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 137
            .Top           = 162
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Dgrupo", "TextBox")
        WITH THIS.txt_4c_Dgrupo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 218
            .Top           = 162
            .Width         = 282
            .MaxLength     = 20
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Conta :"
            .Left      = 96
            .Top       = 189
            .Width     = 38
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 137
            .Top           = 186
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DConta", "TextBox")
        WITH THIS.txt_4c_DConta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 218
            .Top           = 186
            .Width         = 282
            .MaxLength     = 50
            .SpecialEffect = 1
            .Value         = ""
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
            .Left      = 109
            .Top       = 512
            .Width     = 110
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .T.
            .Height            = 23
            .Left              = 107
            .Top               = 527
            .Width             = 369
            .SpecialEffect     = 1
            .Value             = ""
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 221)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(100, 100, 100)
            .Themes            = .T.
            .ReadOnly          = .T.
            .TabStop           = .F.
            .Visible           = .T.
        ENDWITH

        *-- Estado inicial dos pares codigo/descricao (campos vazios -> as
        *-- tres descricoes comecam digitaveis, igual ao legado)
        THIS.AplicarWhenDescricao(THIS.txt_4c_Mat, THIS.txt_4c_DMat)
        THIS.AplicarWhenDescricao(THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo)
        THIS.AplicarWhenDescricao(THIS.txt_4c_Conta, THIS.txt_4c_DConta)

        *-- BINDEVENTs dos TRES pares de lookup bidirecional (Material,
        *-- Grupo, Conta) - F4/DblClick abrem o picker direto; Enter/Tab
        *-- tentam o match exato antes (regra #47 - lookup NUNCA em
        *-- "KeyPress" sem testar a tecla)
        BINDEVENT(THIS.txt_4c_Mat, "KeyPress", THIS, "MatKeyPress")
        BINDEVENT(THIS.txt_4c_Mat, "DblClick", THIS, "MatDblClick")
        BINDEVENT(THIS.txt_4c_Mat, "InteractiveChange", THIS, "MatInteractiveChange")
        BINDEVENT(THIS.txt_4c_DMat, "KeyPress", THIS, "DMatKeyPress")
        BINDEVENT(THIS.txt_4c_DMat, "DblClick", THIS, "DMatDblClick")

        BINDEVENT(THIS.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
        BINDEVENT(THIS.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")
        BINDEVENT(THIS.txt_4c_Grupo, "InteractiveChange", THIS, "GrupoInteractiveChange")
        BINDEVENT(THIS.txt_4c_Dgrupo, "KeyPress", THIS, "DgrupoKeyPress")
        BINDEVENT(THIS.txt_4c_Dgrupo, "DblClick", THIS, "DgrupoDblClick")

        BINDEVENT(THIS.txt_4c_Conta, "KeyPress", THIS, "ContaKeyPress")
        BINDEVENT(THIS.txt_4c_Conta, "DblClick", THIS, "ContaDblClick")
        BINDEVENT(THIS.txt_4c_Conta, "InteractiveChange", THIS, "ContaInteractiveChange")
        BINDEVENT(THIS.txt_4c_DConta, "KeyPress", THIS, "DContaKeyPress")
        BINDEVENT(THIS.txt_4c_DConta, "DblClick", THIS, "DContaDblClick")
    ENDPROC

    *===========================================================================
    * ConfigurarGrade - grd_4c_Dados (Grade do legado), ligada a
    * cursor_4c_Saldos (equivalente a TmpSaldo). O cursor e' preparado VAZIO
    * por SigOpCfaBO.PrepararCursorSaldos() ANTES do RecordSource/
    * ControlSource (regra CLAUDE.md #41 - ControlSource de cursor
    * inexistente derruba o Init), exatamente como o Load legado cria
    * TmpSaldo antes da Grade ser exibida.
    *
    * A ordem de colunas usada aqui e' a ColumnOrder (posicao VISUAL) do
    * dump, nao o nome interno Column1..Column9 do SCX - no legado esses
    * nomes ficaram embaralhados por reordenacoes no Form Designer
    * (Column4 do dump = "Falha Total", Column5 = "Falha Real" etc.), mas a
    * ordem da TELA (ColumnOrder 1..9) e' sempre: Fase, Conta, Entradas,
    * Saidas, Pesagem, Falha Real, Falha Admitida, Indice Produtividade,
    * Falha Total.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrid, loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        THIS.this_oBusinessObject.PrepararCursorSaldos()

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top           = 216
            .Left          = 23
            .Width         = 754
            .Height        = 293
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowHeight     = 17
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLineColor = RGB(238, 238, 238)
            .ColumnCount   = 9
            .RecordSource  = loc_cCursor
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        THIS.ConfigurarColunaGrade(loc_oGrid.Column1, loc_cCursor + ".Fase",     "Fase",     73)
        THIS.ConfigurarColunaGrade(loc_oGrid.Column2, loc_cCursor + ".Conta",    "Conta",    75)
        THIS.ConfigurarColunaGrade(loc_oGrid.Column3, loc_cCursor + ".Entradas", "Entradas", 80)
        THIS.ConfigurarColunaGrade(loc_oGrid.Column4, loc_cCursor + ".Saidas",   "Sa" + CHR(237) + "das", 80)
        THIS.ConfigurarColunaGrade(loc_oGrid.Column5, loc_cCursor + ".Pesagems", "Pesagem",  80)
        THIS.ConfigurarColunaGrade(loc_oGrid.Column6, loc_cCursor + ".FReals",   "Falha Real", 80)
        THIS.ConfigurarColunaGrade(loc_oGrid.Column7, loc_cCursor + ".FAdmins",  "Falha Admitida", 80)
        THIS.ConfigurarColunaGrade(loc_oGrid.Column8, loc_cCursor + ".IndProds", CHR(205) + "ndice Produt.", 80)
        THIS.ConfigurarColunaGrade(loc_oGrid.Column9, loc_cCursor + ".fTotals",  "Falha Total", 80)

        *-- Equivalente ao "Grade.AfterRowColChange" do legado (Get_Descr.Value
        *-- = TmpSaldo.Rclis) - carrega detalhe da linha corrente, sem filtro
        *-- de coluna (regra CLAUDE.md #46, uso correto de AfterRowColChange)
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        THIS.CarregarDados()
    ENDPROC

    *===========================================================================
    * ConfigurarColunaGrade - aplica a UMA Column o ControlSource/Width/
    * Header1 (ForeColor 36,84,155 + Alignment=2, do dump) e o Text1
    * (BorderStyle=0, Margin=0, ReadOnly, cores) comuns a todas as colunas
    * de grd_4c_Dados. Helper para nao repetir o mesmo bloco 9 vezes.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarColunaGrade(par_oColuna, par_cControlSource, par_cCaption, par_nWidth)
        WITH par_oColuna
            .ControlSource = par_cControlSource
            .Width         = par_nWidth
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8

            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)

            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = par_cCaption
            .Header1.ForeColor = RGB(36, 84, 155)
        ENDWITH
    ENDPROC

    *===========================================================================
    * CarregarDados - (re)pinta grd_4c_Dados a partir de cursor_4c_Saldos.
    * Equivalente a "ThisForm.Grade.Refresh" do legado (fim do
    * Processa.Click) - chamado aqui na abertura (grade ainda vazia, mesmo
    * estado do Load legado) e sera chamado de novo apos
    * SigOpCfaBO.ProcessarPesquisa() repopular o cursor (Fase 7/8). Regra
    * CLAUDE.md #21: popular cursor NAO repinta a grade por si so - precisa
    * do GO TOP + Refresh.
    *===========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF USED(loc_cCursor)
            GO TOP IN (loc_cCursor)
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * GradeAfterRowColChange - repinta txt_4c_Descr com a descricao da linha
    * corrente da grade (equivalente ao "ThisForm.Get_Descr.Value =
    * TmpSaldo.Rclis" do legado). PUBLIC - exigido por BINDEVENT (regra #3).
    *===========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CarregarDoCursor()
            THIS.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDescricaoLinha
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnProcessaClick - evento do botao Processar (SIGOPCFA.Processa.Click).
    *
    * Transcricao fiel do Click legado: le Material/Datas/Grupo/Conta
    * diretamente dos controles (forms OPERACIONAIS de tela unica nao tem
    * FormParaBO/BOParaForm - os campos sao lidos na hora, como o legado),
    * valida Material obrigatorio e Data Final >= Data Inicial - as DUAS
    * validacoes devolvem o foco a txt_4c_Mat, EXATAMENTE como o legado
    * (ThisForm.Get_Mat.SetFocus nos dois ramos, mesmo na checagem de data) -
    * delega o cruzamento SigCdFcx x SigOpCfe x SigCdCli a
    * SigOpCfaBO.ProcessarPesquisa() e repinta a grade.
    *
    * MsgAviso (nao MsgErro) para as validacoes de tela - mesmo icone "nao
    * critico" do Messagebox(...,32,...) do legado (regra CLAUDE.md: MsgAviso
    * para validacao de UI).
    *===========================================================================
    PROCEDURE BtnProcessaClick()
        LOCAL loc_oErro, loc_cCursorDados

        IF EMPTY(ALLTRIM(THIS.txt_4c_Mat.Value))
            MsgAviso("O Produto Deve Ser Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Mat.SetFocus()
            RETURN
        ENDIF

        IF ConverterParaData(THIS.txt_4c_Dataf.Value) < ConverterParaData(THIS.txt_4c_Datai.Value)
            MsgAviso("Data Final Deve Ser Maior Que a Data Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Mat.SetFocus()
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel.", "Erro em FormSigOpCfa.BtnProcessaClick")
            RETURN
        ENDIF

        TRY
            THIS.this_oBusinessObject.this_cMaterial     = ALLTRIM(THIS.txt_4c_Mat.Value)
            THIS.this_oBusinessObject.this_cDescMaterial = ALLTRIM(THIS.txt_4c_DMat.Value)
            THIS.this_oBusinessObject.this_dDataInicial  = ConverterParaData(THIS.txt_4c_Datai.Value)
            THIS.this_oBusinessObject.this_dDataFinal    = ConverterParaData(THIS.txt_4c_Dataf.Value)
            THIS.this_oBusinessObject.this_cGrupo        = ALLTRIM(THIS.txt_4c_Grupo.Value)
            THIS.this_oBusinessObject.this_cDescGrupo    = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
            THIS.this_oBusinessObject.this_cConta        = ALLTRIM(THIS.txt_4c_Conta.Value)
            THIS.this_oBusinessObject.this_cDescConta    = ALLTRIM(THIS.txt_4c_DConta.Value)
            THIS.this_oBusinessObject.this_nTipoRelatorio = THIS.obj_4c_OptImp.Value

            THIS.MousePointer = 11

            IF THIS.this_oBusinessObject.ProcessarPesquisa()
                THIS.CarregarDados()

                *-- Legado: "Set Order To SeqFase / Go Top / If Eof() /
                *-- Messagebox('Nenhuma Falha Selecionada!!!', 32)". Depois do
                *-- Append Blank incondicional das 2 linhas finais (separador +
                *-- total) o cursor nunca fica realmente vazio, mas a guarda do
                *-- legado e' transcrita fielmente mesmo assim (regra CLAUDE.md
                *-- #17 - guarda do legado nao se descarta so' por parecer
                *-- inatingivel).
                loc_cCursorDados = THIS.this_oBusinessObject.this_cCursorDados
                IF !USED(loc_cCursorDados) OR EOF(loc_cCursorDados)
                    MsgAviso("Nenhuma Falha Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF

                THIS.grd_4c_Dados.SetFocus()
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            THIS.MousePointer = 0
        CATCH TO loc_oErro
            THIS.MousePointer = 0
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpCfa.BtnProcessaClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSaidaClick - evento do botao Encerrar (SIGOPCFA.Saida.Click).
    * Legado: "Thisform.Release" - FormBase.Release() cuida do resto (regra
    * do projeto: form nunca chama Release() duas vezes).
    *===========================================================================
    PROCEDURE BtnSaidaClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick / BtnImprimirClick / BtnExcelClick - eventos dos tres
    * botoes do metodo "Impress?o" do legado (SIGOPCFA.Visualizar.Click /
    * SIGOPCFA.Imprimir.Click / SIGOPCFA.Excel.Click), que so' diferem no
    * parametro passado a ThisForm.Impress?o('V'/'I'/'E'). PUBLIC - exigido
    * por BINDEVENT (regra #3).
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.ExecutarImpressao("V")
    ENDPROC

    PROCEDURE BtnImprimirClick()
        THIS.ExecutarImpressao("I")
    ENDPROC

    PROCEDURE BtnExcelClick()
        THIS.ExecutarImpressao("E")
    ENDPROC

    *===========================================================================
    * ExecutarImpressao - transcricao do metodo "Impress?o" do legado
    * (SIGOPCFA.Impress?o), que os tres botoes acima chamam passando 'V'
    * (video/preview), 'I' (impressora, com prompt) ou 'E' (planilha Excel/
    * TXT).
    *
    * O legado le Get_Mat/Get_DMat/Get_Datai/Get_Dataf/optImp.Value
    * DIRETAMENTE dos controles dentro do proprio Impress?o - NAO reusa o
    * que o Processa.Click gravou antes. Resincronizar aqui (em vez de so'
    * confiar nas propriedades que BtnProcessaClick ja preencheu) reproduz
    * esse detalhe: se o usuario editar o Material/Periodo/optImp DEPOIS de
    * processar e ANTES de visualizar/imprimir, o cabecalho do relatorio usa
    * o texto mais recente da tela - exatamente como no legado.
    *
    * Os TRES destinos passam pela MESMA guarda do legado ("Select TmpSaldo
    * / Set Order to SeqFase / Go Top / If Eof()") antes de se ramificar -
    * por isso 'E' TAMBEM delega a THIS.this_oBusinessObject.ExibirRelatorio()
    * primeiro (monta TmpCabec + confere cursor_4c_Saldos; em V/I ja dispara
    * o FRX certo, em E so' confirma que ha' o que exportar). Regra
    * CLAUDE.md #17 - a guarda do legado nao se descarta so' por parecer
    * redundante num dos ramos. So' depois da guarda passar 'E' reproduz o
    * bloco de exportacao do legado: PutFile + fVerificaPasta (regra
    * CLAUDE.md #27 - wrapper que FALTAVA teria estourado "File
    * 'fverificapasta.prg' does not exist" em runtime) + Copy To (Xls ou
    * Delimited, conforme a extensao escolhida).
    *===========================================================================
    PROTECTED PROCEDURE ExecutarImpressao(par_cSaida)
        LOCAL loc_oErro, loc_cArq

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel.", "Erro em FormSigOpCfa.ExecutarImpressao")
            RETURN
        ENDIF

        TRY
            THIS.MousePointer = 11

            THIS.this_oBusinessObject.this_cMaterial      = ALLTRIM(THIS.txt_4c_Mat.Value)
            THIS.this_oBusinessObject.this_cDescMaterial  = ALLTRIM(THIS.txt_4c_DMat.Value)
            THIS.this_oBusinessObject.this_dDataInicial   = ConverterParaData(THIS.txt_4c_Datai.Value)
            THIS.this_oBusinessObject.this_dDataFinal     = ConverterParaData(THIS.txt_4c_Dataf.Value)
            THIS.this_oBusinessObject.this_nTipoRelatorio = THIS.obj_4c_OptImp.Value

            IF !THIS.this_oBusinessObject.ExibirRelatorio(par_cSaida)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF par_cSaida == "E"
                    loc_cArq = PUTFILE("Nome da Planilha", "", "XLS;TXT")

                    IF !EMPTY(loc_cArq)
                        IF fVerificaPasta(loc_cArq, 2)
                            SELECT (THIS.this_oBusinessObject.this_cCursorDados)

                            IF LOWER(ALLTRIM(JUSTEXT(loc_cArq))) == "xls"
                                COPY TO (loc_cArq) TYPE XLS
                            ELSE
                                COPY TO (loc_cArq) DELIMITED WITH "" WITH CHARACTER ";"
                            ENDIF

                            IF FILE(loc_cArq)
                                MsgInfo("Planilha Gerada Com Sucesso!!!", "Confirmar")
                            ENDIF
                        ELSE
                            MsgAviso("Erro na Gera" + CHR(231) + CHR(227) + "o da Planilha," + CHR(13) + ;
                                "Verificar Diret" + CHR(243) + "rio ou Planilha J" + CHR(225) + " Aberta...", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            THIS.MousePointer = 0
        CATCH TO loc_oErro
            THIS.MousePointer = 0
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpCfa.ExecutarImpressao")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AplicarWhenDescricao - replica o "PROCEDURE When / Return Empty(
    * ThisForm.Get_<Codigo>.Value)" dos tres campos de descricao do legado
    * (Get_DMat/Get_Dgrupo/Get_dConta): a descricao so aceita digitacao
    * enquanto o campo de codigo correspondente esta vazio (e' assim que o
    * usuario pode localizar o registro DIGITANDO a descricao). Assim que o
    * codigo e' preenchido - digitado, validado ou trazido pelo lookup - a
    * descricao passa a ser so espelho do que foi resolvido.
    *
    * BINDEVENT nao executa o retorno de um "When" (regra CLAUDE.md #3), por
    * isso o efeito e' reproduzido com ReadOnly + TabStop - NUNCA Enabled,
    * que o legado nao acinzenta o campo.
    *===========================================================================
    PROTECTED PROCEDURE AplicarWhenDescricao(par_oTxtCod, par_oTxtDesc)
        LOCAL loc_lPodeDigitar
        loc_lPodeDigitar = EMPTY(par_oTxtCod.Value)
        par_oTxtDesc.ReadOnly = !loc_lPodeDigitar
        par_oTxtDesc.TabStop  = loc_lPodeDigitar
    ENDPROC

    *===========================================================================
    * AbrirLookupPar - abre o picker canonico (FormBuscaAuxiliar via
    * AbrirLookupCanonico, herdado de FormBase) para um dos tres pares
    * codigo/descricao bidirecionais desta tela. Usado por F4 e DblClick, que
    * sempre abrem a busca direta (regra: "F4 sempre abre lookup direto").
    *===========================================================================
    PROTECTED PROCEDURE AbrirLookupPar(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc, ;
            par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo)
        THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, ;
            ALLTRIM(par_oTxtDigitado.Value), par_oTxtCod, par_oTxtDesc)

        *-- O picker preenche codigo E descricao de uma vez: reavaliar o When
        *-- do campo de descricao (regra acima)
        THIS.AplicarWhenDescricao(par_oTxtCod, par_oTxtDesc)
    ENDPROC

    *===========================================================================
    * ValidarLookupPar - usado por Enter/Tab: tenta achar o valor digitado por
    * igualdade EXATA primeiro (equivalente ao Seek/fwbuscaext com match
    * unico do legado); so abre o picker se nao encontrar - SEM aviso e SEM
    * apagar o valor digitado (regra CLAUDE.md #50 - havendo picker, ele
    * proprio ja' e' o feedback de "nao encontrado"). Campo vazio nao valida
    * (mesmo guard do legado: "If Not Empty(This.Value)").
    *===========================================================================
    PROTECTED PROCEDURE ValidarLookupPar(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc, ;
            par_cTabela, par_cCampoDigitado, par_cCampoCod, par_cCampoDesc, par_cTitulo)
        LOCAL loc_cValor, loc_nResultado, loc_cCursor, loc_cSQL
        loc_cValor  = ALLTRIM(par_oTxtDigitado.Value)
        loc_cCursor = "cursor_4c_ChkLookupPar"

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF
        loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
            " FROM " + par_cTabela + ;
            " WHERE " + par_cCampoDigitado + " = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado >= 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
            SELECT (loc_cCursor)
            par_oTxtCod.Value  = ALLTRIM(TratarNulo(Cods, "C"))
            par_oTxtDesc.Value = ALLTRIM(TratarNulo(Descs, "C"))
            USE IN SELECT(loc_cCursor)
            THIS.AplicarWhenDescricao(par_oTxtCod, par_oTxtDesc)
            RETURN
        ENDIF
        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF

        THIS.AbrirLookupPar(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc, ;
            par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo)
    ENDPROC

    *===========================================================================
    * Lookup de Material (txt_4c_Mat/txt_4c_DMat) - SigCdPro.CPros/DPros.
    * Original: Get_Mat.Valid / Get_DMat.Valid (fwbuscaext). PUBLIC - exigido
    * por BINDEVENT (regra #3).
    *===========================================================================
    PROCEDURE MatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4 - abre lookup direto
            THIS.AbrirLookupPar(THIS.txt_4c_Mat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
                "SigCdPro", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarLookupPar(THIS.txt_4c_Mat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
            "SigCdPro", "CPros", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
    ENDPROC

    PROCEDURE MatDblClick()
        THIS.AbrirLookupPar(THIS.txt_4c_Mat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
            "SigCdPro", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
    ENDPROC

    PROCEDURE MatInteractiveChange()
        THIS.AplicarWhenDescricao(THIS.txt_4c_Mat, THIS.txt_4c_DMat)
    ENDPROC

    PROCEDURE DMatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4 - abre lookup direto
            THIS.AbrirLookupPar(THIS.txt_4c_DMat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
                "SigCdPro", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarLookupPar(THIS.txt_4c_DMat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
            "SigCdPro", "DPros", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
    ENDPROC

    PROCEDURE DMatDblClick()
        THIS.AbrirLookupPar(THIS.txt_4c_DMat, THIS.txt_4c_Mat, THIS.txt_4c_DMat, ;
            "SigCdPro", "CPros", "DPros", "Sele" + CHR(231) + CHR(227) + "o de Produto")
    ENDPROC

    *===========================================================================
    * Lookup de Grupo (txt_4c_Grupo/txt_4c_Dgrupo) - SigCdGcr.Codigos/Descrs.
    * Original: Get_grupo.Valid / Get_Dgrupo.Valid (fAcessoContab). PUBLIC -
    * exigido por BINDEVENT (regra #3).
    *===========================================================================
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4 - abre lookup direto
            THIS.AbrirLookupPar(THIS.txt_4c_Grupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
                "SigCdGcr", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarLookupPar(THIS.txt_4c_Grupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
            "SigCdGcr", "Codigos", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
    ENDPROC

    PROCEDURE GrupoDblClick()
        THIS.AbrirLookupPar(THIS.txt_4c_Grupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
            "SigCdGcr", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
    ENDPROC

    PROCEDURE GrupoInteractiveChange()
        THIS.AplicarWhenDescricao(THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo)
    ENDPROC

    PROCEDURE DgrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4 - abre lookup direto
            THIS.AbrirLookupPar(THIS.txt_4c_Dgrupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
                "SigCdGcr", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarLookupPar(THIS.txt_4c_Dgrupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
            "SigCdGcr", "Descrs", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
    ENDPROC

    PROCEDURE DgrupoDblClick()
        THIS.AbrirLookupPar(THIS.txt_4c_Dgrupo, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, ;
            "SigCdGcr", "Codigos", "Descrs", "Sele" + CHR(231) + CHR(227) + "o de Grupo")
    ENDPROC

    *===========================================================================
    * Lookup de Conta (txt_4c_Conta/txt_4c_DConta) - SigCdCli.IClis/RClis.
    * Original: Get_conta.Valid / Get_dConta.Valid (fAcessoContas). PUBLIC -
    * exigido por BINDEVENT (regra #3).
    *===========================================================================
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4 - abre lookup direto
            THIS.AbrirLookupPar(THIS.txt_4c_Conta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
                "SigCdCli", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarLookupPar(THIS.txt_4c_Conta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
            "SigCdCli", "IClis", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
    ENDPROC

    PROCEDURE ContaDblClick()
        THIS.AbrirLookupPar(THIS.txt_4c_Conta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
            "SigCdCli", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
    ENDPROC

    PROCEDURE ContaInteractiveChange()
        THIS.AplicarWhenDescricao(THIS.txt_4c_Conta, THIS.txt_4c_DConta)
    ENDPROC

    PROCEDURE DContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4 - abre lookup direto
            THIS.AbrirLookupPar(THIS.txt_4c_DConta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
                "SigCdCli", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.ValidarLookupPar(THIS.txt_4c_DConta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
            "SigCdCli", "RClis", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
    ENDPROC

    PROCEDURE DContaDblClick()
        THIS.AbrirLookupPar(THIS.txt_4c_DConta, THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
            "SigCdCli", "IClis", "RClis", "Sele" + CHR(231) + CHR(227) + "o de Conta")
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * Precisa iterar Pages de PageFrame e Controls de Container (AddObject cria
    * controles com Visible=.F. por padrao).
    *===========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) == "PAGEFRAME"
                    LOCAL loc_nP
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
    ENDPROC

    *===========================================================================
    * Destroy - libera recursos
    *===========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCfaBO.prg):
*============================================================================
* SigOpCfaBO.prg - Business Object para Pesquisa de Falhas por Fase
*
* Form OPERACIONAL de consulta/apuracao - nao existe tabela de cadastro
* "SigOpCfa" no schema. O processamento cruza:
*   SigCdFcx (ficha de controle)  x  SigOpCfe (apontamento por fase)
*   x  SigCdCli (contas)  x  SigCdCle (classificacao/rateio de fase)
* para apurar entradas, saidas, falha real, falha admitida e indice de
* produtividade por fase/conta, num periodo e material informados.
*
* Tabela: (nenhuma - consulta parametrizada, sem persistencia propria)
*
* Inserir(), Atualizar() e ExecutarExclusao() permanecem SEM override - o
* comportamento padrao herdado de BusinessBase (recusar a operacao com
* mensagem clara) ja eh o correto para este BO, porque nao ha NENHUMA
* tabela proprietaria para gravar (regra CLAUDE.md "BO somente-leitura").
* ObterChavePrimaria() tambem nao se aplica - a tela nao exibe/edita um
* registro de tabela, ela monta um cursor de apuracao (TmpSaldo/
* cursor_4c_Saldos) a partir de uma pesquisa.
*
* Fase 2/8 - no lugar do CRUD generico, as operacoes de dados deste BO sao
* as que o Click de "Processa" e o metodo "Impress?o" do legado executam:
*
*   PrepararCursorSaldos()    deixa cursor_4c_Saldos pronto e VAZIO, com a
*                             MESMA estrutura e os MESMOS indices do
*                             "Create Cursor TmpSaldo" do Load legado (ZAP
*                             quando ja existe, para nao derrubar o binding
*                             do Grid - igual ao "Select TmpSaldo / Zap").
*   CarregarDoCursor()        linha corrente de cursor_4c_Saldos ->
*                             propriedades de linha; eh o
*                             Grade.AfterRowColChange do legado
*                             (Get_Descr.Value = TmpSaldo.Rclis).
*   MontarCursorCabecalho()   cria e popula TmpCabec (Titulo/SubTitulo/
*                             Empresa) do metodo "Impress?o", exigido pelo
*                             FRX.
*   ProcessarPesquisa()       Processa.Click: cruza SigCdFcx x SigOpCfe x
*                             SigCdCli, filtra por Grupo/Conta em memoria,
*                             rateia pelo Setor de SigCdCle e agrega
*                             Entradas/Saidas/FReal/FAdmin/Pesagem/IndProd
*                             por Fase (ou Fase+Conta ou Fase+Conta+Dia,
*                             conforme optImp), com as duas linhas finais
*                             de separador e totais.
*   ObterDescricaoEmpresa()  CursorQuery('SigCdEmp','crSigCdEmp','Cemps',
*                             _Empr,'Razas') do metodo Impress?o, que monta
*                             o cabecalho do relatorio/planilha.
*
* Fase 8/8 - a parte do metodo "Impress?o" legado que dispara o relatorio
* (ramos lcSaida = 'V'/'I' - a exportacao Excel/TXT fica no Form, que eh
* quem chama PutFile):
*
*   ExecutarReportForm()      REPORT FORM propriamente, com o isolamento de
*                             locale/REPORTBEHAVIOR e a restauracao de menu
*                             do padrao canonico do projeto.
*   ExibirRelatorio()         monta TmpCabec, confere "Set Order To SeqFase
*                             / Go Top / If Eof()" em cursor_4c_Saldos (a
*                             MESMA guarda vale para V/I/E) e, em V/I,
*                             escolhe SigOpCf2.frx (optImp=3, Grupo+Conta+
*                             Balanco) ou SigOpCfa.frx (demais opcoes).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init | Completado na Fase 2 - Metodos
*           | Fase 8 - ExecutarReportForm/ExibirRelatorio
*============================================================================

DEFINE CLASS SigOpCfaBO AS BusinessBase

    *==========================================================================
    * Propriedades dos filtros de pesquisa (espelham os controles da tela)
    *==========================================================================
    this_cMaterial        = ""    && char(14) - codigo do produto/material (Get_Mat)
    this_cDescMaterial    = ""    && char(40) - descricao do produto/material (Get_DMat)
    this_dDataInicial     = {}    && date     - data inicial do periodo (Get_Datai)
    this_dDataFinal       = {}    && date     - data final do periodo (Get_Dataf)
    this_cGrupo           = ""    && char(10) - codigo do grupo/fase filtrado (Get_grupo)
    this_cDescGrupo       = ""    && char(20) - descricao do grupo/fase (Get_Dgrupo)
    this_cConta           = ""    && char(10) - codigo da conta filtrada (Get_conta)
    this_cDescConta       = ""    && char(40) - descricao da conta (Get_dConta)
    this_nTipoRelatorio   = 1     && numeric  - 1=Grupo 2=Grupo+Conta 3=Grupo+Conta+Balanco (optImp.Value)
    this_cDescricaoLinha  = ""    && char(40) - descricao da linha corrente da grade (Get_Descr)
    this_cFaseLinha       = ""    && char(10) - Fase  da linha corrente da grade (cursor_4c_Saldos.Fase)
    this_cContaLinha      = ""    && char(10) - Conta da linha corrente da grade (cursor_4c_Saldos.Conta)

    *==========================================================================
    * Cursores utilizados pelo processamento (equivalentes aos do legado)
    *==========================================================================
    this_cCursorDados    = "cursor_4c_Saldos"    && equivalente a TmpSaldo (grade de resultado)
    this_cCursorFcx       = "cursor_4c_Fcx"        && equivalente a crSigCdFcx (SQL cruzado)
    this_cCursorClaes      = "cursor_4c_Claes"      && equivalente a CrTmpClaes (classificacao/rateio)
    this_cCursorEmpresa    = "cursor_4c_Empresa"    && equivalente a crSigCdEmp (cabecalho do relatorio)

    *-- O cursor do cabecalho MANTEM o nome legado "TmpCabec" de proposito: as
    *-- expressoes do FRX SigOpCfa.frx referenciam o alias EXPLICITAMENTE
    *-- (TmpCabec.Titulo / TmpCabec.SubTitulo - conferido no .frt). Renomear
    *-- para o padrao cursor_4c_* faria o relatorio abortar com
    *-- "Alias TMPCABEC is not found". Mesmo tratamento de sigreanrBO.
    this_cCursorCabecalho  = "TmpCabec"             && equivalente a TmpCabec (exigido pelo FRX)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Form operacional sem tabela de cadastro: nao ha operacao de CRUD
    * (Inserir/Atualizar/ExecutarExclusao) a sobrescrever. O comportamento
    * padrao herdado de BusinessBase para essas operacoes ja eh o correto.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PrepararCursorSaldos - deixa cursor_4c_Saldos pronto e VAZIO, com a MESMA
    * ordem de campos e os MESMOS indices do "Create Cursor TmpSaldo" do Load
    * legado. E' PUBLIC porque o Form o chama de fora (na abertura, para ligar
    * o Grid ao cursor ainda vazio, como o legado liga a Grade a TmpSaldo no
    * Load) - metodo chamado de fora NUNCA pode ser PROTECTED (regra #51).
    *
    * Cursor JA existente eh limpo com ZAP, nao fechado e recriado: fechar o
    * alias (USE IN + CREATE CURSOR) derruba Grid.RecordSource e as
    * Column.ControlSource ligadas na abertura do Form, e a grade fica
    * permanentemente vazia com o cursor cheio - sem erro e sem log. O legado
    * faz "Select TmpSaldo / Zap" exatamente por isso.
    *
    * O ZAP vai cercado de SET SAFETY OFF: SAFETY eh escopado por data session
    * e volta a ON dentro de form com DataSession = 2 (mesmo mecanismo da regra
    * #9.4), onde o ZAP abriria o dialogo "Are you sure?" e CONGELARIA a tela.
    *
    * Ponto UNICO de criacao do cursor (CLAUDE.md exige estrutura IDENTICA em
    * todos os pontos que criam o mesmo cursor - com um ponto so nao ha como
    * divergir).
    *==========================================================================
    PROCEDURE PrepararCursorSaldos()
        LOCAL loc_cSafety

        IF USED(THIS.this_cCursorDados) ;
                AND TYPE(THIS.this_cCursorDados + ".Seqs") == "C" ;
                AND TYPE(THIS.this_cCursorDados + ".IndProds") == "N"
            *-- Estrutura esperada ja esta no lugar: so limpa os registros,
            *-- preservando os indices e o binding do Grid.
            SELECT (THIS.this_cCursorDados)

            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            ZAP
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ELSE
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorDados) ;
                (Fase C(10), Conta C(10), Rclis C(40), Entradas N(12,2), Saidas N(12,2), ;
                 Pesagems N(12,2), FReals N(12,2), FAdmins N(12,2), fTotals N(12,2), ;
                 Seqs C(1), pFalhas N(8,2), IndProds N(12,3), Codigos N(6), Datas D)

            INDEX ON Seqs + Fase + Conta + STR(Codigos, 6) TAG SeqFase
            INDEX ON Fase + Conta + STR(Codigos) TAG Fase
        ENDIF

        SELECT (THIS.this_cCursorDados)
        SET ORDER TO TAG Fase

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ProcessarPesquisa - equivalente ao SIGOPCFA.Processa.Click.
    *
    * Le os filtros diretamente das propriedades (this_cMaterial,
    * this_dDataInicial, this_dDataFinal, this_cGrupo, this_cConta,
    * this_nTipoRelatorio), que o Form sincroniza a partir da tela ANTES de
    * chamar este metodo (mesmo padrao de FormParaBO).
    *
    * As validacoes de UI (SetFocus) ficam no Form; aqui fica a MESMA
    * checagem de conteudo (material obrigatorio, periodo invertido), como
    * rede de seguranca - este metodo pode ser chamado de qualquer lugar.
    *
    * _Empr (global legada) -> go_4c_Sistema.cCodEmpresa (CLAUDE.md
    * "_EMPR: LEGACY - NEVER use"). fDtoSQL do legado -> FormatarDataSQL()
    * (helper padrao do projeto, regra CLAUDE.md #5); Data Final recebe
    * hora 23:59:59 para fechar o dia inteiro, igual a
    * fDtoSQL(ldDataFim, '23:59:59') do legado.
    *
    * Cascata fiel ao legado: 1) cruza SigCdFcx x SigOpCfe x SigCdCli para
    * o material e periodo informados; 2) por linha, filtra Grupo/Conta EM
    * MEMORIA (nao no WHERE do SQL - o legado faz exatamente assim); 3)
    * resolve o Setor via SigCdCle (rateio fase->setor); 4) monta a chave
    * de agrupamento conforme this_nTipoRelatorio (1=Grupo, 2=Grupo+Conta,
    * 3=Grupo+Conta+Dia) e agrega Entradas/Saidas/FReal/FAdmin/Pesagem/
    * IndProd na linha correspondente de cursor_4c_Saldos; 5) ao final,
    * acrescenta a linha separadora (Seqs='1') e a linha de totais
    * (Seqs='2'), e recalcula fTotals em TODAS as linhas - exatamente como
    * o legado, inclusive as duas linhas extras serem adicionadas de forma
    * INCONDICIONAL (mesmo sem nenhuma falha encontrada).
    *
    * Retorno: .T. se o processamento rodou sem erro de SQL/validacao (o
    * cursor pode legitimamente ficar so com as 2 linhas de totais, zeradas,
    * quando a pesquisa nao encontra nenhuma falha - o mesmo que acontece
    * no legado). .F. com THIS.this_cMensagemErro preenchido quando faltou
    * preencher o material, o periodo esta invertido ou algum SQLEXEC falhou.
    *==========================================================================
    PROCEDURE ProcessarPesquisa()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cDtInicio, loc_cDtFim
        LOCAL loc_tDataFinal, loc_cGrupo2, loc_cChave, loc_nFalha, loc_oErro
        LOCAL loc_nTotFReal, loc_nTotFAdm, loc_nTotSaida, loc_nTotEnt, loc_nTotPsg, loc_nTotIndProd
        LOCAL loc_cExact, loc_cFiltroGrupo, loc_cFiltroConta, loc_cGrupoLinha, loc_cContaLinha

        loc_lSucesso = .T.
        THIS.this_cMensagemErro = ""

        *-- SET EXACT eh ON no startup (start\config.prg) e com ON o SEEK exige
        *-- a chave INTEIRA do indice: a chave de agrupamento montada aqui eh
        *-- PARCIAL (Fase, ou Fase+Conta, contra o indice Fase+Conta+STR(Codigos)),
        *-- entao TODO SEEK falharia e cada linha da consulta viraria uma linha
        *-- nova na grade, em vez de somar na linha do grupo. O legado Fortyus
        *-- roda com EXACT OFF. Guardado e restaurado no fim do metodo.
        loc_cExact = SET("EXACT")
        SET EXACT OFF

        TRY
            IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cMaterial, "")))
                loc_lSucesso = .F.
                THIS.this_cMensagemErro = "O Produto Deve Ser Informado!!!"
            ELSE
                *-- O legado NAO exige periodo preenchido: so compara as duas
                *-- datas. Data vazia vira NULL no SQL (FormatarDataSQL) e a
                *-- consulta volta sem linhas, igual ao legado - NAO inventar
                *-- aqui uma obrigatoriedade que a tela original nao tem.
                IF THIS.this_dDataFinal < THIS.this_dDataInicial
                    loc_lSucesso = .F.
                    THIS.this_cMensagemErro = "Data Final Deve Ser Maior Que a Data Inicial!!!"
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.PrepararCursorSaldos()

                loc_cFiltroGrupo = ALLTRIM(TratarNulo(THIS.this_cGrupo, ""))
                loc_cFiltroConta = ALLTRIM(TratarNulo(THIS.this_cConta, ""))

                *-- fDtoSQL(ldDataFim, '23:59:59') do legado: a data final fecha
                *-- o dia INTEIRO, senao a coluna datetime perde os lancamentos
                *-- do ultimo dia com hora. DATETIME() exige ano/mes/dia validos
                *-- (com data vazia dispara erro 11), por isso o guard - com data
                *-- vazia FormatarDataSQL devolve NULL e a consulta nao traz
                *-- linha, que eh o mesmo resultado do legado.
                loc_cDtInicio = FormatarDataSQL(ConverterParaData(THIS.this_dDataInicial))

                IF EMPTY(ConverterParaData(THIS.this_dDataFinal))
                    loc_cDtFim = "NULL"
                ELSE
                    loc_tDataFinal = DATETIME(YEAR(ConverterParaData(THIS.this_dDataFinal)), ;
                        MONTH(ConverterParaData(THIS.this_dDataFinal)), ;
                        DAY(ConverterParaData(THIS.this_dDataFinal)), 23, 59, 59)
                    loc_cDtFim = FormatarDataSQL(loc_tDataFinal)
                ENDIF

                IF USED(THIS.this_cCursorFcx)
                    USE IN (THIS.this_cCursorFcx)
                ENDIF

                loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, b.CPros, b.Entradas, b.Saldos," + ;
                           " b.Saidas, b.Pesagems, b.FReals, b.FAdmins, b.cIdChaves, a.Contas," + ;
                           " c.Rclis, b.IndProds, a.Datas" + ;
                           " FROM SigCdFcx a, SigOpCfe b, SigCdCli c" + ;
                           " WHERE a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
                           " AND a.Datas BETWEEN " + loc_cDtInicio + " AND " + loc_cDtFim + ;
                           " AND a.Emps = b.Emps AND a.Codigos = b.Codigos" + ;
                           " AND b.Cpros = " + EscaparSQL(THIS.this_cMaterial) + ;
                           " AND a.Contas = c.Iclis" + ;
                           " ORDER BY a.Emps, a.Codigos, a.Grupos, b.CPros, b.Entradas, b.Saldos," + ;
                           " b.Saidas, b.Pesagems, b.FReals, b.FAdmins, b.cIdChaves, a.Contas, c.Rclis"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFcx)

                IF loc_nResultado < 1
                    loc_lSucesso = .F.
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigCdFcx)" + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT (THIS.this_cCursorFcx)
                    SCAN
                        *-- Filtro de Grupo/Conta em MEMORIA, nao no WHERE do SQL
                        *-- (o legado faz exatamente assim). Comparacao com "=="
                        *-- (exata) porque o SET EXACT esta OFF neste metodo por
                        *-- causa do SEEK parcial: com "!=" e EXACT OFF, grupo
                        *-- "1" casaria com "100" e traria linha de outro grupo.
                        loc_cGrupoLinha = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorFcx + ".Grupos"), ""))
                        loc_cContaLinha = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorFcx + ".Contas"), ""))

                        IF (!EMPTY(loc_cFiltroGrupo) AND !(loc_cGrupoLinha == loc_cFiltroGrupo)) ;
                                OR (!EMPTY(loc_cFiltroConta) AND !(loc_cContaLinha == loc_cFiltroConta))
                            LOOP
                        ENDIF

                        loc_cSQL = "SELECT Setors" + ;
                                   " FROM SigCdCle" + ;
                                   " WHERE ClaGrupos = " + EscaparSQL(EVALUATE(THIS.this_cCursorFcx + ".Grupos")) + ;
                                   " AND ClaContas = " + EscaparSQL(EVALUATE(THIS.this_cCursorFcx + ".Contas"))

                        IF USED(THIS.this_cCursorClaes)
                            USE IN (THIS.this_cCursorClaes)
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorClaes)

                        IF loc_nResultado < 1
                            loc_lSucesso = .F.
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigCdCle)" + ;
                                CHR(13) + CapturarErroSQL()
                            EXIT
                        ENDIF

                        loc_cGrupo2 = EVALUATE(THIS.this_cCursorFcx + ".Grupos")
                        IF RECCOUNT(THIS.this_cCursorClaes) > 0
                            loc_cGrupo2 = EVALUATE(THIS.this_cCursorClaes + ".Setors")
                        ENDIF

                        loc_cChave = loc_cGrupo2
                        DO CASE
                            CASE THIS.this_nTipoRelatorio = 2 && Grupo + Conta
                                loc_cChave = loc_cGrupo2 + EVALUATE(THIS.this_cCursorFcx + ".Contas")
                            CASE THIS.this_nTipoRelatorio = 3 && Grupo + Conta + Balanco
                                loc_cChave = loc_cGrupo2 + EVALUATE(THIS.this_cCursorFcx + ".Contas") + ;
                                    STR(EVALUATE(THIS.this_cCursorFcx + ".Codigos"), 6)
                        ENDCASE

                        IF !SEEK(loc_cChave, THIS.this_cCursorDados)
                            INSERT INTO (THIS.this_cCursorDados) (Fase, Conta, Rclis, Codigos, Datas) VALUES ;
                                (loc_cGrupo2, ;
                                 IIF(INLIST(THIS.this_nTipoRelatorio, 2, 3), ;
                                     ALLTRIM(EVALUATE(THIS.this_cCursorFcx + ".Contas")), ""), ;
                                 IIF(INLIST(THIS.this_nTipoRelatorio, 2, 3), ;
                                     ALLTRIM(EVALUATE(THIS.this_cCursorFcx + ".Rclis")), ""), ;
                                 IIF(THIS.this_nTipoRelatorio = 3, ;
                                     EVALUATE(THIS.this_cCursorFcx + ".Codigos"), 0), ;
                                 IIF(THIS.this_nTipoRelatorio = 3, ;
                                     ConverterParaData(EVALUATE(THIS.this_cCursorFcx + ".Datas")), {}))
                        ENDIF

                        REPLACE Entradas WITH Entradas + EVALUATE(THIS.this_cCursorFcx + ".Entradas") + ;
                                    EVALUATE(THIS.this_cCursorFcx + ".Saldos"), ;
                                Saidas   WITH Saidas + EVALUATE(THIS.this_cCursorFcx + ".Saidas"), ;
                                FReals   WITH FReals + EVALUATE(THIS.this_cCursorFcx + ".FReals"), ;
                                FAdmins  WITH FAdmins + EVALUATE(THIS.this_cCursorFcx + ".FAdmins"), ;
                                Pesagems WITH Pesagems + EVALUATE(THIS.this_cCursorFcx + ".Pesagems"), ;
                                IndProds WITH IndProds + (EVALUATE(THIS.this_cCursorFcx + ".IndProds") - ;
                                    EVALUATE(THIS.this_cCursorFcx + ".FReals")) ;
                            IN (THIS.this_cCursorDados)

                        loc_nFalha = IIF(EVALUATE(THIS.this_cCursorDados + ".Saidas") = 0, 0, ;
                            (EVALUATE(THIS.this_cCursorDados + ".FReals") / ;
                             EVALUATE(THIS.this_cCursorDados + ".Saidas") * 100))
                        REPLACE pFalhas WITH loc_nFalha IN (THIS.this_cCursorDados)
                    ENDSCAN

                    IF loc_lSucesso
                        SELECT (THIS.this_cCursorDados)
                        APPEND BLANK
                        REPLACE Seqs WITH "1"

                        SUM FReals, FAdmins, Saidas, Entradas, Pesagems, IndProds ;
                            TO loc_nTotFReal, loc_nTotFAdm, loc_nTotSaida, loc_nTotEnt, loc_nTotPsg, loc_nTotIndProd

                        APPEND BLANK
                        REPLACE Seqs WITH "2", ;
                                Fase WITH "Total", ;
                                FReals WITH loc_nTotFReal, ;
                                FAdmins WITH loc_nTotFAdm, ;
                                Saidas WITH loc_nTotSaida, ;
                                Entradas WITH loc_nTotEnt, ;
                                Pesagems WITH loc_nTotPsg, ;
                                IndProds WITH loc_nTotIndProd

                        loc_nFalha = IIF(EVALUATE(THIS.this_cCursorDados + ".Saidas") = 0, 0, ;
                            (EVALUATE(THIS.this_cCursorDados + ".FReals") / ;
                             EVALUATE(THIS.this_cCursorDados + ".Saidas") * 100))
                        REPLACE pFalhas WITH loc_nFalha IN (THIS.this_cCursorDados)

                        REPLACE ALL fTotals WITH fReals - fAdmins IN (THIS.this_cCursorDados)

                        SELECT (THIS.this_cCursorDados)
                        SET ORDER TO TAG SeqFase
                        GO TOP
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED(THIS.this_cCursorFcx)
            USE IN (THIS.this_cCursorFcx)
        ENDIF
        IF USED(THIS.this_cCursorClaes)
            USE IN (THIS.this_cCursorClaes)
        ENDIF

        *-- Restaura o SET EXACT do ambiente (vale tambem quando o CATCH disparou)
        IF loc_cExact = "ON"
            SET EXACT ON
        ELSE
            SET EXACT OFF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDescricaoEmpresa - equivalente ao CursorQuery('SigCdEmp',
    * 'crSigCdEmp', 'Cemps', _Empr, 'Razas') feito no metodo Impress?o do
    * legado, que monta o cabecalho do relatorio/planilha (TmpCabec.Empresa)
    * com a razao social da empresa corrente.
    *
    * _Empr (global legada) -> go_4c_Sistema.cCodEmpresa (CLAUDE.md
    * "_EMPR: LEGACY - NEVER use"). SigCdEmp.Cemps eh char(3) -> PADR(...,3).
    *
    * Retorna "" quando a empresa nao existe ou o SQL falha - equivalente ao
    * Iif(Eof('crSigCdEmp'), '', crSigCdEmp.Razas) do legado, que usa string
    * vazia como fallback silencioso (nao eh erro bloqueante: so afeta o
    * texto do cabecalho do relatorio).
    *==========================================================================
    PROCEDURE ObterDescricaoEmpresa()
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_oErro

        loc_cDescricao = ""

        TRY
            loc_cSQL = "SELECT Razas" + ;
                       " FROM SigCdEmp" + ;
                       " WHERE Cemps = " + EscaparSQL(PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3))

            IF USED(THIS.this_cCursorEmpresa)
                USE IN (THIS.this_cCursorEmpresa)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEmpresa)

            IF loc_nResultado >= 1 AND RECCOUNT(THIS.this_cCursorEmpresa) > 0
                loc_cDescricao = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorEmpresa + ".Razas"), ""))
            ENDIF
        CATCH TO loc_oErro
            loc_cDescricao = ""
        ENDTRY

        IF USED(THIS.this_cCursorEmpresa)
            USE IN (THIS.this_cCursorEmpresa)
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega a LINHA CORRENTE do cursor de apuracao para as
    * propriedades de linha do BO (hook padrao de BusinessBase: cursor ->
    * propriedades).
    *
    * Equivale ao Grade.AfterRowColChange do legado, que a cada troca de linha
    * faz "ThisForm.Get_Descr.Value = TmpSaldo.Rclis" - a descricao da conta da
    * linha selecionada aparece no campo de rodape da tela. Aqui a leitura do
    * cursor fica no BO e o Form apenas espelha this_cDescricaoLinha no
    * TextBox, em vez de ler o cursor direto da camada de UI.
    *
    * Fase e Conta vem junto porque sao a identificacao da linha no cursor
    * (as duas colunas que compoem a chave de agrupamento) - o Form usa para
    * saber QUAL linha esta selecionada sem reabrir o cursor.
    *
    * par_cAliasCursor eh opcional: sem ele usa cursor_4c_Saldos (o cursor da
    * grade), que eh o unico cursor de linha desta tela.
    *
    * Retorna .F. (e limpa as propriedades) quando o cursor nao existe, esta
    * vazio ou o ponteiro esta em EOF/BOF - o estado em que a tela abre, antes
    * do primeiro clique em Processar. Nas duas linhas que o legado acrescenta
    * no fim (separador e Total) a leitura ACONTECE e devolve .T.: Rclis eh
    * vazio nelas, e o campo de descricao da tela fica em branco - igual ao
    * legado, que atribui TmpSaldo.Rclis sem testar a linha.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.

        loc_cAlias = THIS.this_cCursorDados
        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ENDIF

        THIS.this_cFaseLinha      = ""
        THIS.this_cContaLinha     = ""
        THIS.this_cDescricaoLinha = ""

        TRY
            IF USED(loc_cAlias)
                IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias) AND !BOF(loc_cAlias)
                    *-- TYPE() antes de ler: o alias pode existir com outra
                    *-- estrutura (PEMSTATUS nao vale para cursor - regra #61).
                    IF TYPE(loc_cAlias + ".Rclis") == "C" AND TYPE(loc_cAlias + ".Fase") == "C"
                        THIS.this_cFaseLinha      = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Fase"), ""))
                        THIS.this_cContaLinha     = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Conta"), ""))
                        THIS.this_cDescricaoLinha = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Rclis"), ""))
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarCursorCabecalho - transcricao do bloco de cabecalho do metodo
    * "Impress?o" do legado:
    *
    *   Create Cursor TmpCabec (Titulo c(100), SubTitulo c(100), Empresa c(100))
    *   CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,'Razas')
    *   lcTitulo    = 'Falhas por Fase'
    *   lcSubTitulo = 'Material : ' + ... + Chr(13) + 'Periodo : ' + ... + ' - ' + ...
    *   Insert Into TmpCabec (Empresa, Titulo, SubTitulo) Values (...)
    *
    * O alias segue sendo TmpCabec porque o FRX referencia TmpCabec.Titulo e
    * TmpCabec.SubTitulo explicitamente (ver comentario da property
    * this_cCursorCabecalho). Os textos sao transcritos LITERALMENTE, com as
    * acentuacoes por CHR() (regra #4): CHR(237) = i-acute em "Per?odo".
    *
    * A razao social vem de ObterDescricaoEmpresa() (o CursorQuery do legado).
    * Empresa nao eh usada pelo SigOpCfa.frx, mas eh gravada igual ao legado -
    * a estrutura do cursor tem de continuar identica.
    *
    * Retorna .T. quando o cursor ficou criado e com a linha de cabecalho.
    *==========================================================================
    PROCEDURE MontarCursorCabecalho()
        LOCAL loc_lSucesso, loc_cTitulo, loc_cSubTitulo, loc_cEmpresa, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (Titulo C(100), SubTitulo C(100), Empresa C(100))

            loc_cTitulo = "Falhas por Fase"

            loc_cSubTitulo = "Material : " + ALLTRIM(TratarNulo(THIS.this_cMaterial, "")) + " - " + ;
                ALLTRIM(TratarNulo(THIS.this_cDescMaterial, "")) + CHR(13) + ;
                "Per" + CHR(237) + "odo : " + DTOC(ConverterParaData(THIS.this_dDataInicial)) + " - " + ;
                DTOC(ConverterParaData(THIS.this_dDataFinal))

            loc_cEmpresa = THIS.ObterDescricaoEmpresa()

            INSERT INTO (THIS.this_cCursorCabecalho) (Empresa, Titulo, SubTitulo) ;
                VALUES (LEFT(loc_cEmpresa, 100), LEFT(loc_cTitulo, 100), LEFT(loc_cSubTitulo, 100))

            GO TOP IN (THIS.this_cCursorCabecalho)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - dispara o REPORT FORM propriamente, com o mesmo
    * isolamento de locale/REPORTBEHAVIOR e restauracao de menu do padrao
    * canonico do projeto (ver SigReCgcBO.ExecutarReportForm). par_cModo:
    * "PREVIEW" (Report Form ... Preview NoConsole, legado lcSaida='V') ou
    * "PRINTER_PROMPT" (Report Form ... To PRINTER Prompt, legado lcSaida='I').
    *
    * O cursor-vazio e o cabecalho (TmpCabec) ja' foram checados/preparados
    * por THIS.ExibirRelatorio() - este metodo so cuida do REPORT FORM.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu apos preview (Erro63): REPORT FORM PREVIEW abre
        *-- toolbar propria que corrompe o cache visual do _MSYSMENU.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExibirRelatorio - equivalente ao bloco "Select TmpSaldo / Set Order to
    * SeqFase / Go Top / If Eof() ... Else ... EndIf" do metodo "Impress?o"
    * do legado: monta TmpCabec e confere se ha linha em cursor_4c_Saldos -
    * essa MESMA guarda envolve os TRES destinos (V/I/E) no legado, por isso
    * vale igual para par_cSaida = "E" (so' depois dela o legado se ramifica
    * em Report Form / Report Form To PRINTER / exportacao de planilha).
    *
    * par_cSaida: "V" (preview), "I" (impressora, com prompt) ou "E" (so'
    * valida a guarda - quem exporta a planilha, com PutFile/Copy To, eh o
    * Form, que eh o dono dos dialogos de UI). Para "V"/"I", escolhe o FRX
    * certo - SigOpCf2 quando this_nTipoRelatorio = 3 (Grupo + Conta +
    * Balanco), SigOpCfa nos outros dois modos - exatamente o "If
    * ThisForm.optImp.Value = 3" do legado.
    *
    * TmpCabec fica aberto DURANTE o REPORT FORM (o FRX referencia
    * TmpCabec.Titulo/TmpCabec.SubTitulo explicitamente) e so' e' fechado no
    * fim deste metodo - igual ao "Use In TmpCabec" que fecha o bloco inteiro
    * do Impress?o legado, depois do If/Else (fica aberto tambem durante o
    * ramo "E", sem uso - o legado faz exatamente isso, de forma
    * incondicional).
    *
    * Retorna .T. quando a guarda passou (e, para V/I, o relatorio foi
    * disparado); .F. com THIS.this_cMensagemErro preenchido quando nao ha
    * linha selecionada ou algo falhou (cabecalho/SQL/FRX ausente).
    *==========================================================================
    PROCEDURE ExibirRelatorio(par_cSaida)
        LOCAL loc_lSucesso, loc_cFrx, loc_cModo, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.MontarCursorCabecalho()
                loc_lSucesso = .F.
            ELSE
                IF !USED(THIS.this_cCursorDados)
                    THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                ELSE
                    SELECT (THIS.this_cCursorDados)
                    SET ORDER TO TAG SeqFase
                    GO TOP

                    IF EOF()
                        THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                    ELSE
                        DO CASE
                            CASE par_cSaida == "V" OR par_cSaida == "I"
                                loc_cFrx  = IIF(THIS.this_nTipoRelatorio = 3, "SigOpCf2", "SigOpCfa")
                                loc_cModo = IIF(par_cSaida == "V", "PREVIEW", "PRINTER_PROMPT")
                                loc_lSucesso = THIS.ExecutarReportForm(loc_cFrx, loc_cModo)

                            CASE par_cSaida == "E"
                                *-- Guarda passou - a exportacao em si (PutFile +
                                *-- fVerificaPasta + Copy To) fica no Form, que
                                *-- eh quem exibe os dialogos de UI.
                                loc_lSucesso = .T.
                        ENDCASE
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

