# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 8/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-14 21:22:03] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-14 21:22:03] [INFO] Config FPW: (nao fornecido)
[2026-11-14 21:22:04] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-14 21:22:05] [INFO] Timeout: 300 segundos
[2026-11-14 21:22:06] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2st5etbu.prg
[2026-11-14 21:22:07] [INFO] Conteudo do wrapper:
[2026-11-14 21:22:08] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigoppro', 'C:\4c\tasks\task790\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigoppro', 'C:\4c\tasks\task790\logs\06_testForm.log'
QUIT

[2026-11-14 21:22:09] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2st5etbu.prg
[2026-11-14 21:22:10] [INFO] VFP output esperado em: C:\4c\tasks\task790\vfp_output.txt
[2026-11-14 21:22:11] [INFO] Executando Visual FoxPro 9...
[2026-11-14 21:22:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2st5etbu.prg
[2026-11-14 21:22:13] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2st5etbu.prg
[2026-11-14 21:22:14] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigoppro
Inicio: 14/11/2026 21:22:16

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 14/11/2026 21:23:54
Duracao: 98 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-14 21:23:54] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-14 21:23:55] [INFO] VFP9 finalizado em 103.2413497 segundos
[2026-11-14 21:23:57] [INFO] Exit Code: 
[2026-11-14 21:23:58] [INFO] 
[2026-11-14 21:23:59] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-14 21:24:00] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2st5etbu.prg
[2026-11-14 21:24:02] [INFO] 
[2026-11-14 21:24:03] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-14 21:24:04] [INFO] * Auto-generated wrapper for parameters
[2026-11-14 21:24:06] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-14 21:24:07] [INFO] * Parameters: 'Formsigoppro', 'C:\4c\tasks\task790\logs\06_testForm.log'
[2026-11-14 21:24:08] [INFO] 
[2026-11-14 21:24:09] [INFO] * Anti-dialog protections for unattended execution
[2026-11-14 21:24:11] [INFO] SET SAFETY OFF
[2026-11-14 21:24:12] [INFO] SET RESOURCE OFF
[2026-11-14 21:24:13] [INFO] SET TALK OFF
[2026-11-14 21:24:14] [INFO] SET NOTIFY OFF
[2026-11-14 21:24:15] [INFO] SYS(2335, 0)
[2026-11-14 21:24:16] [INFO] 
[2026-11-14 21:24:18] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigoppro', 'C:\4c\tasks\task790\logs\06_testForm.log'
[2026-11-14 21:24:19] [INFO] QUIT
[2026-11-14 21:24:20] [INFO] 
[2026-11-14 21:24:21] [INFO] === Fim do Wrapper.prg ===
[2026-11-14 21:24:22] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppro.prg):
*==============================================================================
* Formsigoppro.prg - Produtos (SIGOPPRO)
* Form OPERACIONAL com 4 abas visiveis (Tabs=.T.), espelhando o pgfPagina do
* legado: pgProds (PageOrder=1), pgContas (PageOrder=2), pgFiscs (PageOrder=3),
* pgPrecos (PageOrder=4). Entidade principal: Item de Movimentacao (SigMvItn).
* Migrado de SIGOPPRO.SCX (herda de form generico, framework Fortyus).
*==============================================================================

DEFINE CLASS Formsigoppro AS FormBase

    this_cMensagemErro = ""
    DataSession  = 2
    Width        = 1050
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    BorderStyle  = 2
    KeyPreview   = .T.
    Caption      = "Produtos"
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Guarda de reentrancia dos lookups abertos de LostFocus (regra #37)
    this_lEmLookup = .F.

    *-- Espelha ThisForm.Op_Escolha do legado (Init recebe de poForm.pcEscolha
    *-- do form pai de Movimentacao; aqui comeca em modo seguro ate a
    *-- integracao com o pai ser conectada numa fase posterior)
    this_cOpEscolha  = "CONSULTAR"
    this_oParentForm = .NULL.

    *-- Chave da movimentacao corrente (empdopnums char(29) de SigMvItn).
    *-- No legado vem de TprMvCab, no data session do form pai; aqui o
    *-- chamador preenche antes do Show, ou informa as tres partes abaixo.
    this_cEmpDopNums = ""
    this_cEmps       = ""
    this_cDopes      = ""
    this_nNumes      = 0

    *-- Espelha ThisForm.CItem do legado: ultimo numero de item (citens)
    *-- entregue a grade. O legado inicializa com "Count To lnCount /
    *-- Thisform.CItem = lnCount" no Init e incrementa em minserelinha.
    this_nCItem      = 0

    *-- Espelha crSigCdOpe.qtdites (maximo de itens que a operacao aceita),
    *-- que no legado vem do cursor de configuracao da operacao, vivo no data
    *-- session do form pai. ZERO = sem limite: o legado so compara
    *-- "wRegistros < crSigCdOpe.qtdites" quando a operacao define o teto, e
    *-- o chamador/pai preenche esta property antes do Show quando ele existe.
    this_nQtdItes    = 0

    *-- Campos de cabecalho de TprMvCab (Page2/pgContas) - o cursor do
    *-- cabecalho vive no form pai; estas properties sao o canal de entrada
    *-- enquanto a integracao com o pai nao esta conectada (ver
    *-- ConfigurarPaginaDados).
    this_cMascnum    = ""
    this_cTabds      = ""
    this_cTpfats     = ""
    this_cMoeits     = ""
    this_cGrupoos    = ""
    this_cContaos    = ""
    this_cDContaos   = ""
    this_cGrupods    = ""
    this_cContads    = ""
    this_cDContads   = ""
    this_cEmpds      = ""
    this_cLPrecos    = ""

    *-- Espelhos das colunas de configuracao da operacao que no legado vivem
    *-- em crSigCdOpe / crSigOpCdc / crSigOpCdd / crSigOpCdi, cursores do data
    *-- session do form PAI de Movimentacao. Mesmo canal de entrada de
    *-- this_nQtdItes: o chamador preenche antes do Show. Valor ZERO deixa o
    *-- teste do legado inerte, que eh exatamente o que o legado faz quando a
    *-- configuracao nao traz aquela opcao ligada.
    this_nZerQtds    = 0     && crSigCdOpe.ZerQtds  (2 = qtde 1 automatica)
    this_nImagems    = 0     && crSigCdOpe.Imagems  (1 = exibe foto do produto)
    this_nObsItems   = 0     && crSigCdOpe.ObsItems (1 = observacao obrigatoria)
    this_nAltDescs   = 0     && crSigCdOpe.AltDescs (1 = descricao editavel)
    this_nEditDecls  = 0     && crSigOpCdc.EditDecls
    this_nOperacao   = 0     && crSigCdOpe.Opers    (1 = entrada)
    this_nCasas      = 2     && crSigCdOpe.Casas    (decimais do valor unitario)
    this_nValiNotas  = 0     && crSigCdOpe.ValiNotas (1 = documento unico)
    this_nEditDocs   = 0     && crSigCdOpe.EditDocs  (5 = documento obrigatorio)
    this_nOpVlUnis   = 0     && crSigOpCdc.OpVlUnis  (1 = valor vem do doc.)
    this_nParcs      = 0     && crSigCdOpe.Parcs     (1 = operacao parcelada)

    *-- Estado de tela do legado (properties homonimas do SIGOPPRO original)
    this_nBarra      = 0     && ThisForm.Barra        - barra lida na digitacao
    this_lValidOk    = .F.   && ThisForm.ValidOk
    this_lProcuraCB  = .F.   && ThisForm.lProcuraCB   - procura em andamento
    this_lNovaLinha  = .F.   && ThisForm.lNovaLinha
    this_lWhenGetObs = .F.   && ThisForm.lWhenGetObs
    this_cAntCPro    = ""    && ThisForm.AntCPro      - produto anterior

    *-- Guarda de reentrancia do painel flutuante da observacao: fechar o
    *-- painel tira o foco do EditBox de dentro dele, o que dispara de novo o
    *-- LostFocus ligado a este mesmo metodo. Sem a guarda a chamada se
    *-- aninha ate "Allowed DO nesting or expression evaluation level
    *-- exceeded" (medido no probe da Fase 8).
    this_lFechandoObs = .F.

    *-- Guarda de valor-nao-mudou dos LostFocus de CodCors/CodTams: LostFocus
    *-- dispara SEMPRE que o controle perde o foco, mas o Valid do legado so
    *-- dispara quando o valor MUDA - sem esta guarda o lookup abriria a cada
    *-- vez que o usuario apenas passasse pelo campo sem alterar o valor.
    this_cUltimoValidarCodCorLostFocusValidado = ""
    this_cUltimoValidarCodTamLostFocusValidado = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        THIS.Caption = "Produtos"
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores e recursos
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loc_oErro
            *-- nao exibir erro no Destroy
        ENDTRY
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopproBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Falha ao criar sigopproBO.", "Erro")
            ELSE
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()

                *-- Cursores ANTES das paginas: os campos de Page1/Page3 e a
                *-- grade de Page4 usam ControlSource, e ControlSource de alias
                *-- que ainda nao existe derruba o Init (regra #41).
                THIS.CriarCursorItens()
                THIS.CriarCursorPrecos()

                THIS.ConfigurarPaginaProduto()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaFiscal()
                THIS.ConfigurarPaginaPrecos()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarBotoesTopo()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarGridDados()

                *-- AfterRowColChange: handler DECLARA par_nColIndex porque o
                *-- evento passa o argumento (regra #3). Uso de LINHA corrente
                *-- (carregar o detalhe), nunca validacao de celula (regra #46).
                BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, ;
                          "GradeAfterRowColChange")

                THIS.TornarControlesVisiveis(THIS)
                THIS.ReaplicarVisibilidadeInicial()
                THIS.AplicarModoNaGrade()
                THIS.AjustarBotoesPorModo()
                THIS.HabilitarCampos(INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1

                *-- Carga da grade: pulada em validacao de UI/modo teste (sem
                *-- gnConnHandle a consulta nao tem como rodar).
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste
                        THIS.CarregarDados()
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                     "Proc: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (CLAUDE.md regra #11) e bloco
    * canonico de Saida/Encerrar (CLAUDE.md regra #10), ambos na raiz do form
    * (este form usa abas visiveis, Tabs=.T., sem o truque PageFrame.Top=-29
    * das telas CRUD - entao nao ha compensacao de +29 a aplicar aqui).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 15
            .Left      = 10
            .Width     = THIS.cnt_4c_Cabecalho.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Caption   = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.cnt_4c_Cabecalho.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Caption   = THIS.Caption
        ENDWITH

        *-- cnt_4c_Saida: padrao canonico (CLAUDE.md regra #10), prevalece
        *-- sobre a posicao do botao "Retornar" (OK.btnSair) do SCX legado.
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top         = 0
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Comic Sans MS"
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Containers vazios para os botoes de acao da tela
    * (toolbar superior e inferior do legado, Top=81 e Top=359).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = 81
            .Left        =  542
            .Width       = THIS.Width - 14
            .Height      = 40
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH THIS.cnt_4c_BotoesAcao
            .Top         = 359
            .Left        = 7
            .Width       = THIS.Width - 14
            .Height      = 40
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - pgf_4c_Paginas com as 4 abas visiveis do legado,
    * na ordem visual (PageOrder) do pgfPagina original:
    *   Page1 = pgProds  (PageOrder=1) "Dados do Produto"
    *   Page2 = pgContas (PageOrder=2) "Dados da Movimentacao"
    *   Page3 = pgFiscs  (PageOrder=3) "Dados Fiscais"
    *   Page4 = pgPrecos (PageOrder=4) "Precificacao"
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = 403
            .Left      = 7
            .Width     = 1035
            .Height    = 198
            .Tabs      = .T.
            .PageCount = 4
            .Visible   = .F.
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page1
            .Caption   = "Dados do Produto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page2
            .Caption   = "Dados da Movimenta" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page3
            .Caption   = "Dados Fiscais"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page4
            .Caption   = "Precifica" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2 (pgContas no legado) "Dados da
    * Movimentacao": campos de cabecalho de TprMvCab (mascnum/tabds/tpfats/
    * MoeIts/grupoos/contaos/grupods/contads/empds/LPrecos). TprMvCab vive no
    * data session do form PAI (Movimentacao) - este form eh DataSession=2
    * (privado) e ainda nao tem a ponte com o pai conectada (ver comentario
    * de this_cOpEscolha no cabecalho da classe). Por isso os campos usam
    * .Value direto (sem ControlSource) a partir de properties locais
    * this_cMascnum/this_cTabds/this_cTpfats/this_cMoeits, que uma fase
    * posterior de integracao com o form pai ira popular.
    *
    * FASE 6/8 (Parte 2 de 2): completa os containers desta pagina com
    * cnt_4c_Origem, cnt_4c_Destino, cnt_4c_EmpDes, cnt_4c_LPrecos.
    *
    * SEM LOOKUP nestes quatro: no legado, Get_grupo/Get_conta/Get_dconta de
    * cntOrigem/cntDestino tem ReadOnly=.T. no dump E o proprio When() do SCX
    * retorna .F. sempre (Return .F.) - sao espelhos read-only do cabecalho
    * TprMvCab (que vive no data session do form PAI), nunca campos
    * digitaveis. getEmpDs (cntEmpDes) tambem tem When() = Return(.F.). So
    * getLPrecos (cntLPrecos) eh editavel no legado, mas nao tem
    * CreateObject('fwbuscaext'/'fwBuscaSel') nem sigacess() no Valid - eh
    * texto livre (Format="K", MaxLength=30), sem tabela de referencia.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page2

        *-- cnt_4c_Codigos (cntCodigos no legado) -----------------------------
        loc_oPag.AddObject("cnt_4c_Codigos", "Container")
        WITH loc_oPag.cnt_4c_Codigos
            .Top         = -2
            .Left        = 10
            .Width       = 67
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_Codigos.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPag.cnt_4c_Codigos.txt_4c_Codigos
            .Top           = 20
            .Left          = 3
            .Width         = 61
            .Height        = 23
            .FontBold      = .T.
            .FontSize      = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .Value         = THIS.this_cMascnum
            .ToolTipText   = "C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o"
        ENDWITH

        loc_oPag.cnt_4c_Codigos.AddObject("lbl_4c_LblCodigos", "Label")
        WITH loc_oPag.cnt_4c_Codigos.lbl_4c_LblCodigos
            .Top       = 3
            .Left      = 3
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C" + CHR(243) + "digo"
        ENDWITH

        *-- cnt_4c_TabDs (cntTabDs no legado) ----------------------------------
        loc_oPag.AddObject("cnt_4c_TabDs", "Container")
        WITH loc_oPag.cnt_4c_TabDs
            .Top         = -2
            .Left        = 77
            .Width       = 86
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_TabDs.AddObject("lbl_4c_LblTabDes", "Label")
        WITH loc_oPag.cnt_4c_TabDs.lbl_4c_LblTabDes
            .Top       = 3
            .Left      = 3
            .Width     = 78
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tb. Varia" + CHR(231) + CHR(227) + "o"
        ENDWITH

        loc_oPag.cnt_4c_TabDs.AddObject("txt_4c_TabDes", "TextBox")
        WITH loc_oPag.cnt_4c_TabDs.txt_4c_TabDes
            .Top           = 20
            .Left          = 3
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .Value         = THIS.this_cTabds
            .ToolTipText   = "Tabela de Desconto"
        ENDWITH

        *-- cnt_4c_TpFats (cntTpFats no legado) --------------------------------
        loc_oPag.AddObject("cnt_4c_TpFats", "Container")
        WITH loc_oPag.cnt_4c_TpFats
            .Top         = -2
            .Left        = 163
            .Width       = 41
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_TpFats.AddObject("txt_4c_TpFats", "TextBox")
        WITH loc_oPag.cnt_4c_TpFats.txt_4c_TpFats
            .Top           = 20
            .Left          = 3
            .Width         = 29
            .Height        = 23
            .Format        = "K"
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = THIS.this_cTpfats
            .ToolTipText   = "Tipo de Faturamento"
        ENDWITH

        loc_oPag.cnt_4c_TpFats.AddObject("lbl_4c_LblTpFats", "Label")
        WITH loc_oPag.cnt_4c_TpFats.lbl_4c_LblTpFats
            .Top       = 3
            .Left      = 3
            .Width     = 36
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tp.Fat"
        ENDWITH

        *-- cnt_4c_Moedas (cntMoedas no legado) ---------------------------------
        loc_oPag.AddObject("cnt_4c_Moedas", "Container")
        WITH loc_oPag.cnt_4c_Moedas
            .Top         = -2
            .Left        = 204
            .Width       = 35
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_Moedas.AddObject("txt_4c_Moedas", "TextBox")
        WITH loc_oPag.cnt_4c_Moedas.txt_4c_Moedas
            .Top           = 20
            .Left          = 3
            .Width         = 29
            .Height        = 23
            .Format        = "K"
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = THIS.this_cMoeits
            .ToolTipText   = "Moeda dos Itens"
        ENDWITH

        loc_oPag.cnt_4c_Moedas.AddObject("lbl_4c_LblMoedas", "Label")
        WITH loc_oPag.cnt_4c_Moedas.lbl_4c_LblMoedas
            .Top       = 3
            .Left      = 3
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moe"
        ENDWITH

        *-- cnt_4c_Origem (cntOrigem no legado) --------------------------------
        loc_oPag.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPag.cnt_4c_Origem
            .Top           = 43
            .Left          = 10
            .Width         = 456
            .Height        = 42
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(240, 240, 240)
            .BorderColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_Origem.AddObject("lbl_4c_Origem", "Label")
        WITH loc_oPag.cnt_4c_Origem.lbl_4c_Origem
            .Top       = 3
            .Left      = 3
            .Width     = 43
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Origem"
        ENDWITH

        loc_oPag.cnt_4c_Origem.AddObject("txt_4c_GrupoOs", "TextBox")
        WITH loc_oPag.cnt_4c_Origem.txt_4c_GrupoOs
            .Top               = 20
            .Left              = 3
            .Width             = 80
            .Height            = 21
            .FontBold          = .T.
            .Alignment         = 1
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = THIS.this_cGrupoos
            .ToolTipText       = "Grupo de Origem"
        ENDWITH

        loc_oPag.cnt_4c_Origem.AddObject("txt_4c_ContaOs", "TextBox")
        WITH loc_oPag.cnt_4c_Origem.txt_4c_ContaOs
            .Top               = 20
            .Left              = 84
            .Width             = 80
            .Height            = 21
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = THIS.this_cContaos
            .ToolTipText       = "Conta de Origem"
        ENDWITH

        loc_oPag.cnt_4c_Origem.AddObject("txt_4c_DContaOs", "TextBox")
        WITH loc_oPag.cnt_4c_Origem.txt_4c_DContaOs
            .Top               = 20
            .Left              = 165
            .Width             = 290
            .Height            = 21
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = THIS.this_cDContaos
            .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o da Conta de Origem"
        ENDWITH

        *-- cnt_4c_Destino (cntDestino no legado) ------------------------------
        loc_oPag.AddObject("cnt_4c_Destino", "Container")
        WITH loc_oPag.cnt_4c_Destino
            .Top           = 85
            .Left          = 10
            .Width         = 456
            .Height        = 42
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(240, 240, 240)
            .BorderColor   = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_Destino.AddObject("lbl_4c_Destino", "Label")
        WITH loc_oPag.cnt_4c_Destino.lbl_4c_Destino
            .Top       = 3
            .Left      = 3
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Destino"
        ENDWITH

        loc_oPag.cnt_4c_Destino.AddObject("txt_4c_GrupoDs", "TextBox")
        WITH loc_oPag.cnt_4c_Destino.txt_4c_GrupoDs
            .Top               = 20
            .Left              = 3
            .Width             = 80
            .Height            = 21
            .FontBold          = .T.
            .Alignment         = 1
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = THIS.this_cGrupods
            .ToolTipText       = "Grupo de Destino"
        ENDWITH

        loc_oPag.cnt_4c_Destino.AddObject("txt_4c_ContaDs", "TextBox")
        WITH loc_oPag.cnt_4c_Destino.txt_4c_ContaDs
            .Top               = 20
            .Left              = 84
            .Width             = 80
            .Height            = 21
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = THIS.this_cContads
            .ToolTipText       = "Conta de Destino"
        ENDWITH

        loc_oPag.cnt_4c_Destino.AddObject("txt_4c_DContaDs", "TextBox")
        WITH loc_oPag.cnt_4c_Destino.txt_4c_DContaDs
            .Top               = 20
            .Left              = 165
            .Width             = 290
            .Height            = 21
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = THIS.this_cDContads
            .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o da Conta de Destino"
        ENDWITH

        *-- cnt_4c_EmpDes (cntEmpDes no legado) --------------------------------
        loc_oPag.AddObject("cnt_4c_EmpDes", "Container")
        WITH loc_oPag.cnt_4c_EmpDes
            .Top         = -2
            .Left        = 240
            .Width       = 37
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_EmpDes.AddObject("lbl_4c_EmpDs", "Label")
        WITH loc_oPag.cnt_4c_EmpDes.lbl_4c_EmpDs
            .Top       = 3
            .Left      = 3
            .Width     = 26
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Dest."
        ENDWITH

        loc_oPag.cnt_4c_EmpDes.AddObject("txt_4c_EmpDs", "TextBox")
        WITH loc_oPag.cnt_4c_EmpDes.txt_4c_EmpDs
            .Top           = 20
            .Left          = 3
            .Width         = 31
            .Height        = 23
            .SpecialEffect = 1
            .Value         = THIS.this_cEmpds
            .ToolTipText   = "Empresa de Destino"
        ENDWITH

        *-- cnt_4c_LPrecos (cntLPrecos no legado) ------------------------------
        loc_oPag.AddObject("cnt_4c_LPrecos", "Container")
        WITH loc_oPag.cnt_4c_LPrecos
            .Top         = -2
            .Left        = 277
            .Width       = 223
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .BackColor   = RGB(240, 240, 240)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_LPrecos.AddObject("txt_4c_LPrecos", "TextBox")
        WITH loc_oPag.cnt_4c_LPrecos.txt_4c_LPrecos
            .Top           = 20
            .Left          = 3
            .Width         = 217
            .Height        = 23
            .FontName      = "Tahoma"
            .Format        = "K"
            .MaxLength     = 30
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Value         = THIS.this_cLPrecos
            .ToolTipText   = "Lista de Pre" + CHR(231) + "os"
        ENDWITH

        loc_oPag.cnt_4c_LPrecos.AddObject("lbl_4c_LPrecos", "Label")
        WITH loc_oPag.cnt_4c_LPrecos.lbl_4c_LPrecos
            .Top       = 3
            .Left      = 3
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F.;
    * percorre recursivamente Controls (que inclui Pages de PageFrame).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_oCtrl, loc_oErro
        TRY
            FOR EACH loc_oCtrl IN par_oContainer.Controls
                IF VARTYPE(loc_oCtrl) = "O"
                    *-- Containers que o proprio ConfigurarXxx ja deixa no
                    *-- estado correto (visivel ou oculto por desenho, ex.: o
                    *-- painel flutuante da observacao). Forcar Visible = .T.
                    *-- aqui destruiria esse estado - DESCE para os filhos
                    *-- mesmo assim, para que os controles de dentro estejam
                    *-- visiveis quando o container for exibido.
                    IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_CABECALHO", ;
                              "CNT_4C_CODIGOS", "CNT_4C_OBS", "CNT_4C_REFFS", ;
                              "CNT_4C_ITEM")
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                        LOOP
                    ENDIF

                    loc_oCtrl.Visible = .T.
                    IF PEMSTATUS(loc_oCtrl, "Controls", 5) AND loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            *-- continua silenciosamente
        ENDTRY
    ENDPROC

    *==========================================================================
    * CriarCursorItens - Cursor de trabalho (espelha crTpmMvItn do legado),
    * compartilhado pela grade grd_4c_Dados e pelo sigopproBO.CarregarDoCursor.
    * Mantido num unico CREATE CURSOR para que as paginas de Dados/Fiscal/
    * Precificacao (fases seguintes) liguem campos nele sem recriar a
    * estrutura (regra #41 - Column.ControlSource exige o cursor ja existir).
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorItens()
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Itens ( ;
            cidchaves C(20), citens N(10,0), cpros C(14), dpros C(65), ;
            codbarras N(14,0), cunis C(3), cunips C(3), fators N(8,3), ;
            opers C(1), qtds N(9,3), pesos N(9,3), units N(15,6), ;
            moedas C(3), totas N(11,2), tpesos N(11,2), abrevis C(3), ;
            locals C(10), localos C(10), compris N(6,2), qtreservas N(9,3), ;
            ckpresente N(1,0), codcors C(4), codtams C(4), servicos N(1,0), ;
            aqtds N(9,3), datatrans T NULL, descvals N(7,2), dopes C(20), ;
            emps C(3), etiesps L, fatvals N(15,6), fvals L, iconfs L, ;
            moefats C(3), moevals N(15,6), notas C(6), nrcons C(10), ;
            ntrans N(6,0), numes N(6,0), numolds N(6,0), obs M NULL, ;
            qtbaixas N(9,3), qtbxprods N(9,3), qtprods N(9,3), ;
            unitembs N(11,4), univals N(15,6), vcoms N(8,2), aliqs N(4,2), ;
            sitribs C(2), tpipis C(1), valipis N(11,2), aliqicms N(5,2), ;
            valdescs N(9,2), empos C(3), moevs C(3), utilizas N(4,0), ;
            ncodigos N(10,0), nlotes N(10,0), dtalts T NULL, empdopnums C(29), ;
            baseicms N(11,2), chksubn L, unit2s N(15,6), usulibs C(10), ;
            valrats N(14,6), codlprecs N(6,0), motdscs C(10), tipos C(1), ;
            unitinfs N(14,6), cpro2s C(50), bcicmss N(15,2), bcipis N(15,2), ;
            icms N(15,2), icmss N(15,2), pdescs N(5,2), nchvtbds N(6,0), ;
            idpro N(10,0), unitorigs N(14,6), origmercs C(1), ;
            baseicm2s N(11,2), baseicm3s N(11,2), baseipi2s N(11,2), ;
            baseipi3s N(11,2), cfops C(10), ratdacs N(11,2), ratfrts N(11,2), ;
            raticmds N(11,2), raticms N(11,2), ratsegs N(11,2), sittricms C(3), ;
            aliqiis N(4,2), citem2 N(10,0), taxaiis N(11,2), vcofins N(11,2), ;
            vpis N(11,2), aliqorigs N(4,2), lcancelas L, codfabs C(60), ;
            nadis N(3,0), niadis N(3,0), aliqcofs N(4,2), aliqpis N(4,2), ;
            cssl N(11,2), inss N(11,2), irrf N(11,2), iss N(11,2), ;
            valbases N(11,2), pfcpst N(5,2), vfcpst N(11,2), ob2s C(100), ;
            pedidoweb C(50), qtresres N(9,3), barraref N(14,0), itemped C(4), ;
            numeronota C(10), dopesorig C(20), chaveexterna C(33), ;
            gravacao C(20), ifors C(10), propriedades C(40) NULL, ;
            unidade1 C(15) NULL, resultado1 C(15) NULL, valorMinimo C(15) NULL, ;
            valorMaximo C(15) NULL, metodoReferencia1 C(15) NULL)
        SET NULL OFF

        INDEX ON citens TAG citens

        *-- SET DELETED eh escopado por DATA SESSION e este form eh
        *-- DataSession = 2: na sessao privada ele volta ao default OFF, e com
        *-- OFF a linha excluida do cursor CONTINUA aparecendo na grade (que
        *-- tem DeleteMark = .F., entao nem a marca de exclusao denuncia) e
        *-- ainda eh contada por COUNT/SCAN. A exclusao de linha e a
        *-- renumeracao dos itens dependem disso.
        SET DELETED ON
    ENDPROC

    *==========================================================================
    * ConfigurarGridDados - grd_4c_Dados (fwGrade do legado): grade principal
    * de itens da movimentacao, 22 colunas na mesma ordem/largura do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridDados()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 122
            .Left              = 7
            .Width             = 1035
            .Height            = 233
            .ColumnCount       = 22
            .RecordSource      = "cursor_4c_Itens"
            .FontName          = "Courier New"
            .FontSize          = 9
            .HeaderHeight      = 16
            .RowHeight         = 16
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLineColor     = RGB(238, 238, 238)
            .ToolTipText       = "Grade de Produtos"
        ENDWITH

        *-- Column1: PRODUTO (estilo link - sublinhado/azul, igual ao legado)
        WITH THIS.grd_4c_Dados.Column1
            .ControlSource     = "cursor_4c_Itens.cpros"
            .Width             = 108
            .FontBold          = .T.
            .FontName          = "Courier New"
            .FontSize          = 9
            .FontUnderline     = .T.
            .ForeColor         = RGB(0, 0, 255)
            .Format            = "K!"
            .InputMask         = REPLICATE("!", 14)
            .Header1.FontBold  = .T.
            .Header1.FontName  = "Arial"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Produto"
        ENDWITH

        *-- Column2: FATOR
        WITH THIS.grd_4c_Dados.Column2
            .ControlSource     = "cursor_4c_Itens.fators"
            .Width             = 50
            .InputMask         = "99999.999"
            .Header1.Alignment = 2
            .Header1.Caption   = "Fator"
        ENDWITH

        *-- Column3: OPERACAO (Format=M -> InputMask eh a LISTA, regra #24)
        WITH THIS.grd_4c_Dados.Column3
            .ControlSource     = "cursor_4c_Itens.opers"
            .Width             = 14
            .Format            = "M"
            .InputMask         = "E,S"
            .Header1.Caption   = "Op"
        ENDWITH

        *-- Column4: QTD
        WITH THIS.grd_4c_Dados.Column4
            .ControlSource     = "cursor_4c_Itens.qtds"
            .Width             = 64
            .InputMask         = "99999.999"
            .Header1.Alignment = 2
            .Header1.Caption   = "Qtd."
        ENDWITH

        *-- Column5: PESO
        WITH THIS.grd_4c_Dados.Column5
            .ControlSource     = "cursor_4c_Itens.pesos"
            .Width             = 60
            .InputMask         = "99999.999"
            .Header1.Alignment = 2
            .Header1.Caption   = "Peso"
        ENDWITH

        *-- Column6: VALOR
        WITH THIS.grd_4c_Dados.Column6
            .ControlSource     = "cursor_4c_Itens.units"
            .Width             = 90
            .InputMask         = "99999999.99"
            .Header1.Alignment = 2
            .Header1.Caption   = "Valor"
        ENDWITH

        *-- Column7: MOEDA
        WITH THIS.grd_4c_Dados.Column7
            .ControlSource     = "cursor_4c_Itens.moedas"
            .Width             = 24
            .Header1.Alignment = 2
            .Header1.Caption   = "Moe"
        ENDWITH

        *-- Column8: TOTAL
        WITH THIS.grd_4c_Dados.Column8
            .ControlSource     = "cursor_4c_Itens.totas"
            .Width             = 107
            .InputMask         = "9999999999.99"
            .Header1.Alignment = 2
            .Header1.Caption   = "Total"
        ENDWITH

        *-- Column9: pesotot
        WITH THIS.grd_4c_Dados.Column9
            .ControlSource     = "cursor_4c_Itens.tpesos"
            .Width             = 64
            .InputMask         = "9999999.99"
            .Header1.Alignment = 2
            .Header1.Caption   = "Total Peso"
        ENDWITH

        *-- Column10: item (numero sequencial, sem legenda no legado)
        WITH THIS.grd_4c_Dados.Column10
            .ControlSource     = "cursor_4c_Itens.citens"
            .Width             = 31
            .InputMask         = "9999"
            .Header1.Caption   = ""
        ENDWITH

        *-- Column11: UNIDADE
        WITH THIS.grd_4c_Dados.Column11
            .ControlSource     = "cursor_4c_Itens.cunis"
            .Width             = 30
            .Header1.Alignment = 2
            .Header1.Caption   = "Uni"
        ENDWITH

        *-- Column12: UNIPESO (desabilitada, igual ao legado)
        WITH THIS.grd_4c_Dados.Column12
            .ControlSource     = "cursor_4c_Itens.cunips"
            .Width             = 31
            .Enabled           = .F.
            .Header1.Alignment = 2
            .Header1.Caption   = "Uni"
        ENDWITH

        *-- Column13: PEDIDO
        WITH THIS.grd_4c_Dados.Column13
            .ControlSource     = "cursor_4c_Itens.abrevis"
            .Width             = 40
            .Header1.Alignment = 2
            .Header1.Caption   = "Ped"
        ENDWITH

        *-- Column14: DESCRS
        WITH THIS.grd_4c_Dados.Column14
            .ControlSource     = "cursor_4c_Itens.dpros"
            .Width             = 290
            .Header1.Alignment = 2
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- Column15: cor
        WITH THIS.grd_4c_Dados.Column15
            .ControlSource     = "cursor_4c_Itens.codcors"
            .Width             = 24
            .Header1.Alignment = 2
            .Header1.Caption   = "Cor"
        ENDWITH

        *-- Column16: Local
        WITH THIS.grd_4c_Dados.Column16
            .ControlSource     = "cursor_4c_Itens.locals"
            .Width             = 80
            .Header1.Alignment = 2
            .Header1.Caption   = "Local"
        ENDWITH

        *-- Column17: Comprimento
        WITH THIS.grd_4c_Dados.Column17
            .ControlSource     = "cursor_4c_Itens.compris"
            .Width             = 50
            .InputMask         = "9999.99"
            .Header1.Alignment = 2
            .Header1.Caption   = "Compr."
        ENDWITH

        *-- Column18: LocalO
        WITH THIS.grd_4c_Dados.Column18
            .ControlSource     = "cursor_4c_Itens.localos"
            .Width             = 80
            .Header1.Alignment = 2
            .Header1.Caption   = "Local Ori"
        ENDWITH

        *-- Column19: Tamanho
        WITH THIS.grd_4c_Dados.Column19
            .ControlSource     = "cursor_4c_Itens.codtams"
            .Width             = 35
            .Header1.Alignment = 2
            .Header1.Caption   = "Tam."
        ENDWITH

        *-- Column20: Reserva (ReadOnly, igual ao legado)
        WITH THIS.grd_4c_Dados.Column20
            .ControlSource     = "cursor_4c_Itens.qtreservas"
            .Width             = 64
            .ReadOnly          = .T.
            .InputMask         = "999999.999"
            .Header1.Alignment = 2
            .Header1.Caption   = "Reserva"
        ENDWITH

        *-- Column21 (Presente) e Column22 (O.S.): CheckBox de coluna.
        *-- Aqui so o BIND e a largura/header. O AddObject do CheckBox roda
        *-- DEPOIS, em InstalarCheckBoxesGrade(), porque Column.AddObject de
        *-- CheckBox ESTOURA enquanto a coluna estiver ligada (pelo auto-bind
        *-- do RecordSource) a um campo de outro tipo: com ColumnCount = 22 o
        *-- VFP liga Column22 ao 22o campo do cursor, que eh codcors C(4), e
        *-- adicionar um controle numerico ali da
        *-- "Error with CHK_4C_SERVICO - Value : Data type mismatch."
        *-- A falha eh TOTAL e MUDA: cai no TRY do InicializarForm, que
        *-- devolve .F., CREATEOBJECT devolve o logico .F. e a tela
        *-- simplesmente nao abre - sem erro na tela e sem log.
        WITH THIS.grd_4c_Dados.Column21
            .ControlSource     = "cursor_4c_Itens.ckpresente"
            .Width             = 50
            .Header1.Alignment = 2
            .Header1.Caption   = "Presente"
        ENDWITH

        WITH THIS.grd_4c_Dados.Column22
            .ControlSource     = "cursor_4c_Itens.servicos"
            .Width             = 50
            .Header1.Alignment = 2
            .Header1.Caption   = "O.S."
        ENDWITH

        *-- Todas as colunas ja estao bindadas: agora os CheckBox.
        THIS.InstalarCheckBoxesGrade()
    ENDPROC

    *==========================================================================
    * InstalarCheckBoxesGrade - Instala os CheckBox das colunas Presente e
    * O.S. na ordem que o VFP9 exige (medido): ColumnCount -> RecordSource ->
    * ControlSource de TODAS as colunas -> Column.AddObject + Value ->
    * Sparse + CurrentControl. Invertido, o AddObject estoura por causa do
    * auto-bind do RecordSource (ver comentario em ConfigurarGridDados).
    *
    * IDEMPOTENTE e vive no funil: reatribuir RecordSource/ColumnCount ou
    * fechar o alias destroi os objetos postos na Column, entao a instalacao
    * tem de poder rodar de novo sem duplicar o AddObject.
    *==========================================================================
    PROTECTED PROCEDURE InstalarCheckBoxesGrade()
        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN
        ENDIF

        IF THIS.grd_4c_Dados.ColumnCount < 22
            RETURN
        ENDIF

        THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column21, "chk_4c_Presente")
        THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column22, "chk_4c_Servico")
    ENDPROC

    *==========================================================================
    * InstalarCheckBoxColuna - Poe UM CheckBox numa Column. Propriedades: so
    * as que o VFP9 de fato aplica em controle de Column criado em runtime
    * (Caption/Alignment/ReadOnly/Visible/FontName/FontSize/Value). Top/Left/
    * Width/Height sao DESCARTADAS nesse contexto - escrever a geometria do
    * dump aqui eh codigo morto que sugere area clicavel calibrada.
    *==========================================================================
    PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNomeChk)
        IF VARTYPE(par_oColuna) <> "O" OR VARTYPE(par_cNomeChk) <> "C"
            RETURN
        ENDIF

        IF !PEMSTATUS(par_oColuna, par_cNomeChk, 5)
            par_oColuna.AddObject(par_cNomeChk, "CheckBox")
        ENDIF

        *-- Membro alcancado por NOME: EVALUATE para ler, STORE para atribuir
        *-- (Column nao eh colecao por chave - regra #34).
        STORE ""   TO ("par_oColuna." + par_cNomeChk + ".Caption")
        STORE 0    TO ("par_oColuna." + par_cNomeChk + ".Alignment")
        STORE .F.  TO ("par_oColuna." + par_cNomeChk + ".ReadOnly")
        STORE .T.  TO ("par_oColuna." + par_cNomeChk + ".Visible")
        STORE "Courier New" TO ("par_oColuna." + par_cNomeChk + ".FontName")
        STORE 9    TO ("par_oColuna." + par_cNomeChk + ".FontSize")
        STORE 0    TO ("par_oColuna." + par_cNomeChk + ".Value")

        *-- Sparse = .F. senao o CheckBox so aparece na linha ativa;
        *-- CurrentControl com o NOME do objeto, senao a coluna segue
        *-- desenhando o Text1 dela (regra #18).
        par_oColuna.Sparse         = .F.
        par_oColuna.CurrentControl = par_cNomeChk
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesTopo - Preenche cnt_4c_Botoes (Top=81 no legado) com a
    * barra de botoes auxiliares. Posicoes/icones/visibilidade EXATOS do dump
    * (layout.json/sigoppro_form_codigo_fonte_slim.txt); Left relativo ao
    * container (absoluto do legado menos 7, regra "Left relativo em botoes
    * de container").
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesTopo()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Botoes

        loc_oCnt.AddObject("cmd_4c_BtnTotItens", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnTotItens
            .Left            = 7
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Total de Produtos"
            .ToolTipText     = "Total dos Produtos"
            .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnTotItens, "Click", THIS, "BtnTotItensClick")

        loc_oCnt.AddObject("cmd_4c_BtnCotacao", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnCotacao
            .Left            = 109
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "C" + CHR(226) + "mbio de Produtos"
            .ToolTipText     = "Edita os Valores de Cota" + CHR(231) + CHR(227) + "o das Moedas"
            .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnCotacao, "Click", THIS, "BtnCotacaoClick")

        loc_oCnt.AddObject("cmd_4c_BtnAltImps", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnAltImps
            .Left            = 211
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Alterar Impostos"
            .ToolTipText     = "Alterar Impostos"
            .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnAltImps, "Click", THIS, "BtnAltImpsClick")

        loc_oCnt.AddObject("chk_4c_BtnVerImps", "CheckBox")
        WITH loc_oCnt.chk_4c_BtnVerImps
            .Left            = 313
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .Style           = 1
            .Alignment       = 2
            *-- CheckBox.Value SEMPRE numerico (0/1). O SCX legado declara
            *-- Value = .F., mas misturar Logico e Numerico no mesmo controle
            *-- estoura "Operator/operand type mismatch" na primeira
            *-- comparacao com 0/1 feita em outro metodo.
            .Value           = 0
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Visualizar Impostos"
            .ToolTipText     = "Visualizar Impostos"
            .Picture         = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.chk_4c_BtnVerImps, "Click", THIS, "BtnVerImpsClick")

        loc_oCnt.AddObject("cmd_4c_BtnRecImps", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnRecImps
            .Left            = 414
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Recalcular Impostos"
            .ToolTipText     = "Recalcular Impostos"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnRecImps, "Click", THIS, "BtnRecImpsClick")

        loc_oCnt.AddObject("cmd_4c_Btndevolu", "CommandButton")
        WITH loc_oCnt.cmd_4c_Btndevolu
            .Left            = 517
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Devolu" + CHR(231) + CHR(227) + "o"
            .ToolTipText     = "Devolu" + CHR(231) + CHR(227) + "o"
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Btndevolu, "Click", THIS, "BtndevoluClick")

        loc_oCnt.AddObject("cmd_4c_BtnIteSub", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnIteSub
            .Left            = 618
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Itens Subn" + CHR(237) + "vel"
            .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnIteSub, "Click", THIS, "BtnIteSubClick")

        loc_oCnt.AddObject("cmd_4c_CmdXml", "CommandButton")
        WITH loc_oCnt.cmd_4c_CmdXml
            .Left            = 720
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Importar XML"
            .ToolTipText     = "Importar XML"
            .Picture         = gc_4c_CaminhoIcones + "images.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "images.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_CmdXml, "Click", THIS, "CmdXmlClick")

        loc_oCnt.AddObject("cmd_4c_Btncarregar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Btncarregar
            .Left            = 822
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Carrega Cadastro"
            .ToolTipText     = "Carregar Cadastro"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Btncarregar, "Click", THIS, "BtncarregarClick")

        loc_oCnt.AddObject("cmd_4c_BtnRetCash", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnRetCash
            .Left            = 924
            .Top             = 0
            .Width           = 102
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Retorna B" + CHR(244) + "nus"
            .ToolTipText     = "Retorna B" + CHR(244) + "nus"
            .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnRetCash, "Click", THIS, "BtnRetCashClick")
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Preenche cnt_4c_BotoesAcao (Top=359 no legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_BotoesAcao

        loc_oCnt.AddObject("cmd_4c_BtnCadPro", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnCadPro
            .Left            = 39
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Ca\<dastro de Produtos"
            .ToolTipText     = "Cadastro de Produtos"
            .Picture         = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnCadPro, "Click", THIS, "BtnCadProClick")

        loc_oCnt.AddObject("cmd_4c_BtnPApaga", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnPApaga
            .Left            = 139
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "E\<xclus" + CHR(227) + "o de Produtos"
            .ToolTipText     = "Apagar Produto da Grade"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnPApaga, "Click", THIS, "BtnPApagaClick")

        loc_oCnt.AddObject("cmd_4c_BtnCompos", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnCompos
            .Left            = 239
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Carregar Compo\<si" + CHR(231) + CHR(227) + "o"
            .ToolTipText     = "Componentes"
            .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnCompos, "Click", THIS, "BtnComposClick")

        loc_oCnt.AddObject("cmd_4c_BtnAltPrecos", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnAltPrecos
            .Left            = 339
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Al\<tera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
            .ToolTipText     = "Alterar Pre" + CHR(231) + "os"
            .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnAltPrecos, "Click", THIS, "BtnAltPrecosClick")

        loc_oCnt.AddObject("cmd_4c_BtnPBuscas", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnPBuscas
            .Left            = 439
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Proc\<ura de Produtos"
            .ToolTipText     = "Procurar Produtos"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnPBuscas, "Click", THIS, "BtnPBuscasClick")

        loc_oCnt.AddObject("cmd_4c_BtnPedido", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnPedido
            .Left            = 539
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Informar Pedido"
            .Picture         = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnPedido, "Click", THIS, "BtnPedidoClick")

        loc_oCnt.AddObject("cmd_4c_Btnsubcp", "CommandButton")
        WITH loc_oCnt.cmd_4c_Btnsubcp
            .Left            = 639
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "\<Substituir Composi" + CHR(231) + CHR(227) + "o"
            .ToolTipText     = "Componentes"
            .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Btnsubcp, "Click", THIS, "BtnsubcpClick")

        loc_oCnt.AddObject("cmd_4c_BtnDet", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnDet
            .Left            = 639
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Detalhes"
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnDet, "Click", THIS, "BtnDetClick")

        *-- cmd_4c_BtnOptFin e cmd_4c_BtnDesc ocupam o MESMO Left=746 no SCX legado
        *-- (feature mutuamente exclusiva por configuracao da operacao) -
        *-- transcrito literal do dump, sem inventar posicao nova.
        loc_oCnt.AddObject("cmd_4c_BtnOptFin", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnOptFin
            .Left            = 739
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Finalidade"
            .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnOptFin, "Click", THIS, "BtnOptFinClick")

        loc_oCnt.AddObject("cmd_4c_BtnDesc", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnDesc
            .Left            = 739
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Descontos"
            .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnDesc, "Click", THIS, "BtnDescClick")

        loc_oCnt.AddObject("cmd_4c_BtnLocDes", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnLocDes
            .Left            = 839
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Local. Destino"
            .ToolTipText     = "Selecionar Localiza" + CHR(231) + CHR(227) + "o de Destino do Produto"
            .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnLocDes, "Click", THIS, "BtnLocDesClick")

        loc_oCnt.AddObject("cmd_4c_BtnLocOri", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnLocOri
            .Left            = 939
            .Top             = 0
            .Width           = 100
            .Height          = 40
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 7
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .PicturePosition = 1
            .MousePointer    = 15
            .Caption         = "Local. Origem"
            .ToolTipText     = "Selecionar Localiza" + CHR(231) + CHR(227) + "o de Origem do Produto"
            .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnLocOri, "Click", THIS, "BtnLocOriClick")
    ENDPROC

    *==========================================================================
    * ReaplicarVisibilidadeInicial - TornarControlesVisiveis forca Visible=.T.
    * em tudo; aqui escondemos de volta os botoes que o SCX legado declara
    * Visible=.F. por padrao (toggle condicional a configuracao da operacao,
    * ainda nao conectada nesta fase).
    *==========================================================================
    PROTECTED PROCEDURE ReaplicarVisibilidadeInicial()
        THIS.cnt_4c_Botoes.cmd_4c_BtnRetCash.Visible    = .F.
        THIS.cnt_4c_Botoes.cmd_4c_Btndevolu.Visible      = .F.
        THIS.cnt_4c_Botoes.cmd_4c_BtnRecImps.Visible     = .F.
        THIS.cnt_4c_Botoes.cmd_4c_BtnAltImps.Visible     = .F.
        THIS.cnt_4c_Botoes.cmd_4c_BtnCotacao.Visible     = .F.
        THIS.cnt_4c_Botoes.cmd_4c_BtnTotItens.Visible    = .F.
        THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Visible     = .F.
        THIS.cnt_4c_Botoes.cmd_4c_Btncarregar.Visible    = .F.
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocDes.Visible  = .F.
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDet.Visible     = .F.

        *-- Page1 (pgProds): controles que o SCX legado declara Visible = .F.
        WITH THIS.pgf_4c_Paginas.Page1
            .cnt_4c_Obs.Visible        = .F.
            .img_4c_ImgProds.Visible   = .F.
            .txt_4c_Valors.Visible     = .F.
            .lbl_4c_LblValors.Visible  = .F.
            .txt_4c_CodCors.Visible    = .F.
            .lbl_4c_LblCodCors.Visible = .F.
            .txt_4c_CodTams.Visible    = .F.
            .lbl_4c_LblCodTams.Visible = .F.
            .txt_4c_GerDIfors.Visible  = .F.
            .lbl_4c_Label15.Visible    = .F.
        ENDWITH

        *-- Page4 (pgPrecos): a grade de precificacao nasce oculta no legado.
        *-- Mesmo nome do grid principal (eh o que o mapeamento do form manda),
        *-- mas outro PAI - o caminho completo nao deixa ambiguidade.
        THIS.pgf_4c_Paginas.Page4.grd_4c_Dados.Visible = .F.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Espelha os guards When do legado (InList sobre
    * Op_Escolha + linha corrente na grade). Chamado no fim de InicializarForm
    * e deve ser repetido apos qualquer troca de modo/linha (regra #40).
    * PUBLIC: o TesteAutomatico chama THIS.oForm.AjustarBotoesPorModo() de
    * FORA da classe, e PEMSTATUS(...,5) devolve .T. mesmo para PROTECTED
    * (so testa existencia, nao escopo) - entao o harness entraria no branch
    * e a chamada estouraria em runtime (regra #3).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEdicao, loc_lTemLinha

        loc_lEdicao   = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
        loc_lTemLinha = USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") ;
                        AND RECCOUNT("cursor_4c_Itens") > 0

        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnCadPro.Enabled    = loc_lEdicao AND loc_lTemLinha
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPApaga.Enabled    = loc_lEdicao AND loc_lTemLinha
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnCompos.Enabled    = loc_lEdicao AND loc_lTemLinha
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnAltPrecos.Enabled = loc_lEdicao AND loc_lTemLinha
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPedido.Enabled    = loc_lEdicao AND loc_lTemLinha
        THIS.cnt_4c_BotoesAcao.cmd_4c_Btnsubcp.Enabled     = loc_lTemLinha
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDet.Enabled       = loc_lTemLinha
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnOptFin.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDesc.Enabled      = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocOri.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocDes.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
        THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPBuscas.Enabled   = .T.

        THIS.cnt_4c_Botoes.cmd_4c_BtnIteSub.Enabled    = loc_lEdicao
        THIS.cnt_4c_Botoes.cmd_4c_CmdXml.Enabled       = loc_lEdicao
        THIS.cnt_4c_Botoes.cmd_4c_Btncarregar.Enabled  = loc_lEdicao
        THIS.cnt_4c_Botoes.cmd_4c_BtnTotItens.Enabled  = loc_lEdicao
        THIS.cnt_4c_Botoes.cmd_4c_BtnCotacao.Enabled   = loc_lEdicao
        THIS.cnt_4c_Botoes.cmd_4c_BtnAltImps.Enabled   = loc_lEdicao AND loc_lTemLinha
        THIS.cnt_4c_Botoes.cmd_4c_BtnRecImps.Enabled   = loc_lTemLinha
        THIS.cnt_4c_Botoes.cmd_4c_Btndevolu.Enabled    = loc_lTemLinha
        THIS.cnt_4c_Botoes.cmd_4c_BtnRetCash.Enabled   = loc_lEdicao
        THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Enabled   = loc_lTemLinha
    ENDPROC

    *==========================================================================
    * AlternarPagina - PUBLIC (chamado de fora pelo TesteAutomatico e pelo
    * form pai). Troca a aba ativa de pgf_4c_Paginas (1=Produto, 2=Movimenta-
    * cao, 3=Fiscal, 4=Precificacao).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF !BETWEEN(par_nPagina, 1, THIS.pgf_4c_Paginas.PageCount)
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        *-- Refresh em pagina OCULTA nao pinta (regra #46): o painel do item
        *-- so eh atualizado DEPOIS de a aba virar a ativa.
        IF INLIST(par_nPagina, 1, 3)
            THIS.AtualizarPainelProduto()
        ENDIF

        THIS.pgf_4c_Paginas.Pages(par_nPagina).Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * TemProdutoSelecionado - cursor_4c_Itens posicionado em linha com
    * produto preenchido (equivalente a !Eof('crTpmMvItn') And !Empty(Cpros)
    * usado nos guards When do legado).
    *==========================================================================
    PROTECTED FUNCTION TemProdutoSelecionado()
        RETURN USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") ;
               AND !EMPTY(cursor_4c_Itens.cpros)
    ENDFUNC

    *==========================================================================
    * CarregarDados - Carga da grade de itens da movimentacao. PUBLIC: eh
    * chamado de fora (TesteAutomatico / form pai) e pelo funil de recarga.
    *
    * Equivale ao AddCursor('SigMvItn', ...) que o legado herda do form pai
    * de Movimentacao (crTpmMvItn) seguido de "Select crTpmMvItn / Goto Top"
    * no fim do Init.
    *
    * O BO le para um cursor TEMPORARIO e aqui o alias da grade eh recarregado
    * com SELECT/ZAP/APPEND FROM DBF(): SQLEXEC direto sobre o alias ligado ao
    * Grid o FECHA e RECRIA, zerando o ColumnCount - a grade viraria um
    * retangulo branco sem cabecalho, sem erro e sem log.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_cChave, loc_oErro

        loc_lSucesso = .F.

        IF !USED("cursor_4c_Itens")
            THIS.CriarCursorItens()
        ENDIF

        loc_cChave = THIS.ObterChaveMovimentacao()

        IF EMPTY(loc_cChave)
            *-- Sem movimentacao selecionada a grade abre VAZIA, como no legado
            *-- (o cursor do pai nasce sem linha). Nao eh falha: repinta e sai.
            THIS.PrepararLinhaInicial()
            THIS.RepintarGradeItens()
            THIS.AjustarBotoesPorModo()
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarItens(loc_cChave, "cursor_4c_ItensTmp")
                THIS.ZaparCursorItens()
                IF USED("cursor_4c_ItensTmp")
                    SELECT cursor_4c_Itens
                    APPEND FROM DBF("cursor_4c_ItensTmp")
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_ItensTmp")
                USE IN cursor_4c_ItensTmp
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar os itens da movimenta" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro CarregarDados")
        ENDTRY

        *-- Em edicao o legado fecha o Init entregando a linha de digitacao
        *-- (Count To lnCount / CItem = lnCount / minserelinha)
        THIS.PrepararLinhaInicial()

        *-- Funil unico: popular o cursor NAO repinta a grade (regra #21)
        THIS.RepintarGradeItens()
        THIS.AplicarModoNaGrade()
        THIS.AjustarBotoesPorModo()

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PrepararLinhaInicial - Fecho do Init legado, que em INSERIR/ALTERAR
    * entrega uma linha em branco pronta para digitacao:
    *
    *   Select crTpmMvItn / Set Order To
    *   If Thisform.Op_Escolha = 'ALTERAR' Or crSigCdOpe.SubnObrigs = 3
    *       Count To lnCount / Thisform.CItem = lnCount / Thisform.minserelinha()
    *   Else
    *       If Thisform.Op_Escolha = 'INSERIR'
    *           Count To lnCount / Thisform.CItem = lnCount / minserelinha()
    *       Endif
    *   Endif
    *
    * Em CONSULTAR/EXCLUIR o legado NAO entrega linha nova (a grade abre so
    * com o que foi gravado), e o mesmo vale aqui.
    *==========================================================================
    PROTECTED PROCEDURE PrepararLinhaInicial()
        LOCAL loc_nRegistros

        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Itens
        COUNT TO loc_nRegistros
        THIS.this_nCItem = loc_nRegistros

        RETURN THIS.InserirLinhaGrade()
    ENDPROC

    *==========================================================================
    * RepintarGradeItens - FUNIL UNICO de repintura da grade. Popular o cursor
    * NAO faz a grade exibir as linhas (regra #21): o legado sempre fecha com
    * "Go Top In crTpmMvItn" + "fwGrade.Refresh". Tem de rodar em TODO caminho
    * que mexe no cursor (carga, exclusao de linha, troca de modo) e DEPOIS de
    * trocar o ActivePage - Refresh em pagina oculta nao pinta.
    *==========================================================================
    PROCEDURE RepintarGradeItens()
        IF !USED("cursor_4c_Itens")
            RETURN
        ENDIF

        SELECT cursor_4c_Itens
        GO TOP

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            *-- Reinstala os CheckBox de coluna antes de repintar: se algo
            *-- tiver reatribuido RecordSource/ColumnCount ou fechado o
            *-- alias, os objetos postos nas Columns foram destruidos. A
            *-- instalacao eh idempotente.
            THIS.InstalarCheckBoxesGrade()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ZaparCursorItens - ZAP guardado por SAFETY. SET SAFETY eh escopado por
    * DATA SESSION: este form eh DataSession = 2, e na sessao privada SAFETY
    * vale ON mesmo com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP
    * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
    * esperando um clique que ninguem ve (nao eh erro: em teste headless
    * aparece como timeout sem resultado).
    *
    * ZAP eh a escolha CERTA aqui (o legado faz "Zap In <cursor>"): preserva
    * a estrutura e o binding do Grid. Fechar e recriar o alias derrubaria
    * RecordSource/ControlSource e a grade ficaria vazia com o cursor cheio.
    *==========================================================================
    PROTECTED PROCEDURE ZaparCursorItens()
        LOCAL loc_cSafety

        IF !USED("cursor_4c_Itens")
            RETURN
        ENDIF

        loc_cSafety = SET("SAFETY")
        SET SAFETY OFF

        SELECT cursor_4c_Itens
        ZAP

        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF
    ENDPROC

    *==========================================================================
    * AplicarModoNaGrade - Espelha o par fwGrade/fwGradeR do legado. No legado sao
    * duas grades mutuamente exclusivas sobre o MESMO cursor, e o proprio
    * legado alinha a segunda na posicao da primeira (".Left = fwGrade.Left /
    * .Top = fwGrade.Top / .Height = fwGrade.Height"), isto eh: visualmente
    * eh UMA grade que alterna entre editavel e somente-leitura.
    *
    * Legado: fwGrade  (editavel)      -> INSERIR, ou ALTERAR com AltEtiqs # 1
    *         fwGradeR (somente-leit.) -> EXCLUIR/CONSULTAR, ou ALTERAR com
    *                                     AltEtiqs = 1
    *
    * Column.ReadOnly vem DEPOIS de Grid.ReadOnly: o do grid propaga para as
    * colunas e sobrescreveria (regra #18).
    *==========================================================================
    PROCEDURE AplicarModoNaGrade()
        LOCAL loc_lEditavel

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN
        ENDIF

        loc_lEditavel = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

        WITH THIS.grd_4c_Dados
            .ReadOnly = !loc_lEditavel
            .Enabled  = .T.
            *-- Reserva eh ReadOnly tambem na grade editavel (legado:
            *-- fwGrade.Column20.ReadOnly = .T.)
            .Column20.ReadOnly = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ObterChaveMovimentacao - empdopnums char(29) da movimentacao corrente.
    * Vem do form pai de Movimentacao (TprMvCab no legado); enquanto a
    * integracao com o pai nao esta conectada, cai na property do proprio
    * form, que o chamador preenche antes do Show.
    *==========================================================================
    PROTECTED FUNCTION ObterChaveMovimentacao()
        LOCAL loc_cChave

        loc_cChave = ""

        IF !EMPTY(THIS.this_cEmpDopNums)
            loc_cChave = THIS.this_cEmpDopNums
        ELSE
            IF !EMPTY(THIS.this_cEmps + THIS.this_cDopes) OR THIS.this_nNumes <> 0
                loc_cChave = THIS.this_oBusinessObject.MontarChaveEmpDopNums( ;
                                 THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
            ENDIF
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * InserirLinhaGrade - Equivale a PROCEDURE minserelinha do legado, que eh
    * o "Incluir" desta tela: a inclusao de produto aqui NAO vem de um botao,
    * vem de uma LINHA EM BRANCO entregue na grade para o usuario digitar o
    * codigo. O legado chama este metodo no fim do Init (quando Op_Escolha eh
    * INSERIR ou ALTERAR) e a cada vez que o usuario termina uma linha.
    *
    * Legado:
    *   Select crTpmMvItn / Set Order to CPros / Count to wRegistros
    *   Seek Space(14)                       && procura linha com produto vazio
    *   If Not Eof()                         && achou: nao insere, so desce
    *       If Not ThisForm.lAutPreco / keyboard "{DNARROW}" / EndIf
    *   Else
    *       If wRegistros < crSigCdOpe.qtdites
    *           ThisForm.CItem = ThisForm.CItem + 1
    *           Insert Into crTpmMvItn( Emps, Dopes, Numes, Citens ) Values (...)
    *       EndIf
    *   EndIf
    *   ThisForm.OldCodBarras = 0 / AntCPro = Space(14) / AntValu = Space(3)
    *
    * O cursor migrado nao tem a tag CPros do legado, entao a procura da linha
    * em branco eh LOCATE FOR EMPTY(cpros) - mesmo efeito do Seek Space(14).
    * O "keyboard {DNARROW}" do legado era a forma de levar o foco da grade
    * para a linha nova; aqui o equivalente eh posicionar o cursor nela e
    * repintar, porque a navegacao nao depende da fila de teclado.
    *
    * PUBLIC: o form pai e o harness de teste chamam de fora.
    *==========================================================================
    PROCEDURE InserirLinhaGrade()
        LOCAL loc_nRegistros, loc_lTemLimite, loc_lInseriu

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        loc_lInseriu = .F.

        SELECT cursor_4c_Itens
        COUNT TO loc_nRegistros

        LOCATE FOR EMPTY(cpros)

        IF !FOUND()
            *-- Nenhuma linha em branco na grade: entrega uma nova, respeitando
            *-- o teto de itens da operacao quando ele existe (legado:
            *-- "If wRegistros < crSigCdOpe.qtdites").
            loc_lTemLimite = (THIS.this_nQtdItes > 0)

            IF !loc_lTemLimite OR loc_nRegistros < THIS.this_nQtdItes
                THIS.this_nCItem = THIS.this_nCItem + 1

                INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
                    VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
                            THIS.this_nNumes, THIS.this_nCItem, ;
                            THIS.ObterChaveMovimentacao())

                loc_lInseriu = .T.
            ENDIF
        ENDIF

        *-- Em qualquer um dos dois caminhos a linha corrente passa a ser a de
        *-- digitacao (a que estava em branco, ou a recem-inserida).
        THIS.RepintarGradeItens()
        THIS.AjustarBotoesPorModo()

        RETURN loc_lInseriu
    ENDPROC

    *==========================================================================
    * LimparLinhaGrade - Equivale a PROCEDURE apaite do legado: a linha NAO eh
    * removida, so esvaziada, voltando a ser uma linha de digitacao. O legado
    * usa este caminho quando a linha corrente ja esta sem produto e eh a
    * UNICA em branco (ver ExcluirLinhaGrade).
    *
    * Legado (apaite): Replace DPros/Obs/CodBarras/Utilizas/NumeroNota/Notas,
    * apaga os sub-itens da linha (crTpmMvIts com o mesmo CItens) e zera as
    * celulas da grade (Produto, Operacao, Qtd, Peso, Comprimento, Fator,
    * PesoTot, Valor, Moeda, Total), repondo Operacao com 'E' ou 'S' conforme
    * crSigCdOpe.Opers. A operacao reposta aqui vem da propria linha do legado
    * (nTpOpers) atraves das linhas irmas do cursor, para nao inventar valor
    * que a configuracao da operacao nao deu.
    *==========================================================================
    PROCEDURE LimparLinhaGrade()
        LOCAL loc_nCitens

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Itens
        loc_nCitens = cursor_4c_Itens.citens

        REPLACE cpros      WITH "", ;
                dpros      WITH "", ;
                obs        WITH "", ;
                codbarras  WITH 0, ;
                utilizas   WITH 0, ;
                numeronota WITH "", ;
                notas      WITH ""

        REPLACE qtds    WITH 0, ;
                pesos   WITH 0, ;
                compris WITH 0, ;
                fators  WITH 0, ;
                tpesos  WITH 0, ;
                units   WITH 0, ;
                moedas  WITH "", ;
                totas   WITH 0

        *-- Sub-itens da linha (composicao): no legado moram em crTpmMvIts e
        *-- aqui convivem no mesmo cursor, apontando o pai por citem2.
        DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens

        *-- Volta a posicionar na linha esvaziada (o DELETE FOR varre o cursor).
        *-- LOCATE em vez de SEEK: nao depende de qual tag esta ativa, e a
        *-- renumeracao de itens troca a ordem corrente durante o SCAN.
        LOCATE FOR citens = loc_nCitens
        IF !FOUND()
            GO TOP
        ENDIF

        THIS.RepintarGradeItens()
        THIS.AjustarBotoesPorModo()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExcluirLinhaGrade - Equivale a PROCEDURE deletaritem do legado, que eh o
    * "Excluir" desta tela: exclusao de LINHA da grade de itens (o registro em
    * SigMvItn so eh gravado/removido pelo form pai de Movimentacao, na
    * confirmacao da operacao).
    *
    * Legado (deletaritem):
    *   If !IsEmpty(crTpmMvItn.cpros)
    *       _CItem = CItens / Delete / apaga os sub-itens de cItem2 = _CItem
    *       Delete For cItem2 = _CItem
    *   Else
    *       Select Count(1) From crTpmMvItn Where IsEmpty(cpros) ... xApaga
    *       If xApaga.Total > 1 / Delete / Else / Thisform.ApaIte() / EndIf
    *   EndIf
    *   Select crTpmMvItn / Go Top
    *
    * Isto eh: linha COM produto sai da grade junto com a composicao dela;
    * linha SEM produto so sai se houver outra em branco - se for a unica, ela
    * eh apenas esvaziada, para a grade nunca ficar sem linha de digitacao.
    *
    * PUBLIC: o form pai e o harness de teste chamam de fora.
    *==========================================================================
    PROCEDURE ExcluirLinhaGrade()
        LOCAL loc_nCitens, loc_nEmBranco, loc_nRecno

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Itens

        IF EMPTY(cursor_4c_Itens.cpros)
            *-- COUNT varre o cursor e deixa o ponteiro em EOF: sem repor o
            *-- RECNO, o DELETE abaixo cairia no registro fantasma do fim e
            *-- nao apagaria linha nenhuma (sem erro e sem aviso).
            loc_nRecno = RECNO()
            COUNT FOR EMPTY(cpros) TO loc_nEmBranco
            IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
                GO loc_nRecno
            ENDIF

            IF loc_nEmBranco > 1
                DELETE
            ELSE
                *-- Unica linha em branco: esvazia em vez de remover
                THIS.LimparLinhaGrade()
                RETURN .T.
            ENDIF
        ELSE
            loc_nCitens = cursor_4c_Itens.citens

            DELETE

            *-- Composicao da linha excluida (legado: Delete For cItem2 = _CItem)
            DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens
        ENDIF

        SELECT cursor_4c_Itens
        GO TOP

        RETURN .T.
    ENDPROC

    *==========================================================================
    * RenumerarItensGrade - Equivale ao bloco de renumeracao do btnPApaga.Click
    * do legado, que roda SEMPRE depois de excluir uma linha: as linhas que
    * sobraram recebem citens 1..N em sequencia, e as referencias de
    * composicao (cItem2) acompanham, senao o pai de uma composicao passa a
    * apontar para item que nao existe mais.
    *
    * Legado: Set Order To CItens / Go Top / Cont = 0 / Scan / Cont = Cont + 1
    *         ... Replace cItem2 With Cont For cItem2 = _cIt ... Replace CItens
    *         With Cont / EndScan / Thisform.CItem = Cont
    *==========================================================================
    PROCEDURE RenumerarItensGrade()
        LOCAL loc_nCont, loc_nCitensAnt, loc_nRecno

        IF !USED("cursor_4c_Itens")
            RETURN 0
        ENDIF

        loc_nCont = 0

        SELECT cursor_4c_Itens
        SET ORDER TO
        GO TOP

        SCAN
            loc_nCont      = loc_nCont + 1
            loc_nCitensAnt = cursor_4c_Itens.citens
            loc_nRecno     = RECNO()

            *-- Primeiro as referencias da composicao, depois o proprio item:
            *-- invertido, o Replace de cItem2 nao encontraria mais o valor
            *-- antigo para casar.
            REPLACE citem2 WITH loc_nCont FOR citem2 = loc_nCitensAnt

            GO loc_nRecno
            REPLACE citens WITH loc_nCont
        ENDSCAN

        SET ORDER TO citens

        THIS.this_nCItem = loc_nCont

        RETURN loc_nCont
    ENDPROC

    *==========================================================================
    * GarantirLinhaDeDigitacao - Equivale ao "If Eof() / Insert Into
    * crTpmMvItn(...) Values (..., 1)" que o legado faz no btnPApaga.Click
    * depois de excluir: se a grade ficou sem nenhuma linha, entrega uma nova
    * para o usuario continuar digitando.
    *==========================================================================
    PROCEDURE GarantirLinhaDeDigitacao()
        LOCAL loc_nRegistros

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Itens
        COUNT TO loc_nRegistros

        IF loc_nRegistros > 0
            RETURN .F.
        ENDIF

        THIS.this_nCItem = 1

        INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
            VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
                    THIS.this_nNumes, 1, THIS.ObterChaveMovimentacao())

        RETURN .T.
    ENDPROC

    *==========================================================================
    * TotalizarLinha - Equivale a PROCEDURE total_item do legado:
    *
    *   parameters pMantVal
    *   =ThisForm.ParentForm.Calc_ValIte(,,pMantVal)
    *   ThisForm.fwGrade.Refresh
    *
    * A aritmetica do total do item (unitario x quantidade, fator, moeda,
    * descontos e impostos) eh regra de negocio que mora no Calc_ValIte do
    * form PAI de Movimentacao - este form so delega e repinta. Reescrever a
    * formula aqui gravaria valor diferente do legado sem erro na tela.
    *
    * PUBLIC: os handlers de celula da grade chamam, e o form pai tambem.
    *==========================================================================
    PROCEDURE TotalizarLinha(par_lManterValor)
        LOCAL loc_lManter, loc_lOk, loc_oErro

        loc_lManter = IIF(VARTYPE(par_lManterValor) = "L", par_lManterValor, .F.)
        loc_lOk     = .F.

        IF VARTYPE(THIS.this_oParentForm) = "O"
            IF PEMSTATUS(THIS.this_oParentForm, "Calc_ValIte", 5)
                TRY
                    THIS.this_oParentForm.Calc_ValIte(.F., .F., loc_lManter)
                    loc_lOk = .T.
                CATCH TO loc_oErro
                    MsgErro("Erro ao totalizar o item:" + CHR(13) + ;
                            loc_oErro.Message + CHR(13) + ;
                            "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                            "Proc: " + loc_oErro.Procedure, "Erro TotalizarLinha")
                ENDTRY
            ENDIF
        ENDIF

        THIS.RepintarGradeItens()

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * ValidarItensAntesDeSair - Gate do btnSair.Click do legado ("Retornar"):
    * antes de devolver o controle ao form pai, o legado percorre os itens e,
    * achando problema, exibe a mensagem, devolve o foco a grade e NAO fecha a
    * tela ("If Not IsEmpty(lcMsg) / Messagebox(lcMsg, 48, lcCaption) /
    * ... SetFocus / Return").
    *
    * O legado so valida quando Op_Escolha eh INSERIR/ALTERAR (e no caso
    * especifico de CONSULTAR com crSigCdOpe.DigItens = 8).
    *
    * Das validacoes do legado, as que dependem de cursor de configuracao da
    * operacao (crSigCdOpe, crSigOpCdc, crSigOpCdd, csOpeAut, TmpOperacao) sao
    * guardadas no proprio legado por teste de valor/Seek nesses cursores, e
    * por isso ficam inertes quando a configuracao nao esta carregada - o
    * mesmo comportamento vale aqui. A checagem de consistencia entre item e
    * composicao eh INCONDICIONAL no legado e eh a que roda aqui:
    *
    *   Select a.* From crTpmMvIts a, crTpmMvItn b Where a.citens = b.citens
    *       And a.CPros <> b.CPros Into Cursor ChecItem
    *   If Reccount() > 0 / lcMsg = 'Problema de inconsistencia com o Item '
    *       + Str(ChecItem.citens,4) + ' Produto:' + ChecItem.CPros
    *
    * Devolve .T. quando os itens estao consistentes.
    *==========================================================================
    PROCEDURE ValidarItensAntesDeSair()
        LOCAL loc_lOk, loc_cMsg, loc_cTitulo, loc_nRecno

        loc_lOk     = .T.
        loc_cMsg    = ""
        loc_cTitulo = "Inconsistencia dos Itens"

        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            RETURN .T.
        ENDIF

        IF !USED("cursor_4c_Itens")
            RETURN .T.
        ENDIF

        SELECT cursor_4c_Itens
        loc_nRecno = RECNO()

        *-- Composicao (citem2 aponta o item pai) cujo produto divergiu do
        *-- produto do pai: no legado sao duas tabelas (crTpmMvIts x
        *-- crTpmMvItn) ligadas por citens; aqui convivem no mesmo cursor.
        SELECT a.citens, a.cpros ;
            FROM cursor_4c_Itens a, cursor_4c_Itens b ;
            WHERE a.citem2 <> 0 ;
              AND a.citem2 = b.citens ;
              AND a.cpros <> b.cpros ;
            INTO CURSOR cursor_4c_ChecaItem

        IF USED("cursor_4c_ChecaItem")
            SELECT cursor_4c_ChecaItem
            GO TOP
            IF !EOF()
                loc_cMsg = "Problema de inconsistencia com o Item " + ;
                           STR(cursor_4c_ChecaItem.citens, 4) + ;
                           " Produto:" + ALLTRIM(cursor_4c_ChecaItem.cpros)
            ENDIF
            USE IN cursor_4c_ChecaItem
        ENDIF

        SELECT cursor_4c_Itens
        IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
            GO loc_nRecno
        ENDIF

        IF !EMPTY(loc_cMsg)
            loc_lOk = .F.
            MsgAviso(loc_cMsg, loc_cTitulo)

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - "Retornar" ao form pai (OK.btnSair do legado, que eh
    * Cancel = .T. - ESC cai aqui). O legado valida os itens primeiro e, so
    * passando, reabilita o pai e fecha:
    *
    *   ... validacoes ... If Not IsEmpty(lcMsg) / Messagebox / SetFocus / Return
    *   If llOk / With Thisform.ParentForm / .Enabled = .T. / ... / Endwith / Endif
    *   Thisform.Release
    *
    * A reabilitacao do pai eh obrigatoria: o legado o desabilita ao abrir
    * esta tela (Thisform.ParentForm.Enabled = .f. no Init), e sem o
    * .Enabled = .T. aqui o usuario volta para uma tela de Movimentacao morta.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF !THIS.ValidarItensAntesDeSair()
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            IF PEMSTATUS(THIS.this_oParentForm, "Enabled", 5)
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * Handlers dos botoes de cnt_4c_Botoes (toolbar superior, Top=81)
    *==========================================================================

    *-- "Total de Produtos": Do Form SigOpTot With ThisForm, DataSessionId
    PROCEDURE BtnTotItensClick()
        LOCAL loc_oForm, loc_oErro
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpTot", THIS, THIS.DataSessionId)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Total de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *-- "Cambio de Produtos": Do Form SigOpCot With ParentForm, TprMvCab.Datas
    PROCEDURE BtnCotacaoClick()
        LOCAL loc_oForm, loc_oErro
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpCot", THIS.this_oParentForm)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir C" + CHR(226) + "mbio de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *-- "Alterar Impostos": habilita a pagina Fiscal e navega para ela
    PROCEDURE BtnAltImpsClick()
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("Selecione um Produto Na Grade para alterar impostos.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        THIS.pgf_4c_Paginas.Page3.Enabled = .T.
        THIS.AlternarPagina(3)
    ENDPROC

    *-- "Visualizar Impostos": toggle que leva a pagina Fiscal
    PROCEDURE BtnVerImpsClick()
        IF !THIS.TemProdutoSelecionado()
            THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 0
            THIS.pgf_4c_Paginas.Page3.Enabled          = .F.
            RETURN
        ENDIF

        *-- Legado (fwGrade.AfterRowColChange): llvImp = btnVerImps.Value
        *-- habilita/desabilita a pagina Fiscal e troca a aba ativa.
        IF THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 1
            THIS.pgf_4c_Paginas.Page3.Enabled = .T.
            THIS.AlternarPagina(3)
        ELSE
            THIS.pgf_4c_Paginas.Page3.Enabled = .F.
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *-- "Recalcular Impostos": navega para a pagina Fiscal da linha corrente
    PROCEDURE BtnRecImpsClick()
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("Selecione um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        THIS.AlternarPagina(3)
    ENDPROC

    *-- "Devolucao": Do Form sigoppei (equivalente SigOpExi do legado)
    PROCEDURE BtndevoluClick()
        LOCAL loc_oForm, loc_oErro
        IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpExi", THIS, THIS.DataSessionId)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Devolu" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *-- "Itens Subnivel": Do Form sigoppei With ThisForm, DataSessionId
    PROCEDURE BtnIteSubClick()
        LOCAL loc_oForm, loc_oErro
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpPei", THIS, THIS.DataSessionId)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Itens Subn" + CHR(237) + "vel:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *-- "Importar XML": zera a grade de itens e aciona a importacao
    PROCEDURE CmdXmlClick()
        IF !MsgConfirma("Importar XML ir" + CHR(225) + " substituir todos os itens da grade atual. Continuar?", "Confirmar")
            RETURN
        ENDIF
        THIS.ZaparCursorItens()
        THIS.RepintarGradeItens()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *-- "Carrega Cadastro": zera a grade de itens antes de carregar um lote
    PROCEDURE BtncarregarClick()
        LOCAL loc_cArquivo
        loc_cArquivo = GETFILE("TXT")
        IF EMPTY(loc_cArquivo)
            RETURN
        ENDIF
        THIS.ZaparCursorItens()
        THIS.RepintarGradeItens()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *-- "Retorna Bonus": Do Form ParentForm.OpenCash(Contads,.T.,.F.)
    PROCEDURE BtnRetCashClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "OpenCash", 5)
                THIS.this_oParentForm.OpenCash("", .T., .F.)
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao retornar b" + CHR(244) + "nus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * Handlers dos botoes de cnt_4c_BotoesAcao (toolbar inferior, Top=359)
    *==========================================================================

    *-- "Cadastro de Produtos": Do Form SigOpCgp (cadastro rapido na operacao)
    PROCEDURE BtnCadProClick()
        LOCAL loc_oForm, loc_oErro
        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpCgp", THIS)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Cadastro de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *-- "Exclusao de Produtos": remove a linha corrente da grade.
    *-- Legado (btnPApaga.Click): guard de EOF -> DeletarItem() -> garante uma
    *-- linha na grade -> renumera os itens (e as referencias de composicao)
    *-- -> CItem = Cont -> Go Top -> fwGrade.Refresh + Produto.SetFocus.
    *-- O legado NAO pede confirmacao: a exclusao eh de LINHA do cursor da
    *-- grade, e a gravacao em SigMvItn so acontece quando o form pai confirma
    *-- a movimentacao.
    PROCEDURE BtnPApagaClick()
        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            MsgAviso("Posicione no Produto que Deseja Excluir ... ", "Nada a Fazer")
            RETURN
        ENDIF

        IF !THIS.ExcluirLinhaGrade()
            RETURN
        ENDIF

        THIS.GarantirLinhaDeDigitacao()
        THIS.RenumerarItensGrade()

        SELECT cursor_4c_Itens
        GO TOP

        THIS.RepintarGradeItens()
        THIS.AjustarBotoesPorModo()

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *-- "Carregar Composicao": Do Form SigSubCp (composicao do produto)
    PROCEDURE BtnComposClick()
        LOCAL loc_oForm, loc_oErro
        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
                                      cursor_4c_Itens.citens, THIS.DataSessionId)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *-- "Alteracao de Precos": libera o foco na coluna Valor da grade
    PROCEDURE BtnAltPrecosClick()
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("Selecione um Produto para Ter o Pre" + CHR(231) + "o Alterado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        THIS.grd_4c_Dados.SetFocus()
        THIS.grd_4c_Dados.ActiveColumn = 6
    ENDPROC

    *-- "Procura de Produtos": abre o lookup de produto quando a linha
    *-- corrente ainda nao tem codigo preenchido (igual ao legado)
    PROCEDURE BtnPBuscasClick()
        LOCAL loc_oBusca

        IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") AND !EMPTY(cursor_4c_Itens.cpros)
            MsgAviso("O c" + CHR(243) + "digo do Produto tem que estar vazio para acionar procura!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
                                   "cursor_4c_BuscaPro", "Cpros", "", "Produtos", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro") AND USED("cursor_4c_Itens") ;
               AND !EOF("cursor_4c_Itens")
                SELECT cursor_4c_BuscaPro
                SELECT cursor_4c_Itens
                REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.Cpros), ;
                        dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
    ENDPROC

    *-- "Informar Pedido": Do Form SigOpPed With ThisForm, DataSessionId
    PROCEDURE BtnPedidoClick()
        LOCAL loc_oForm, loc_oErro
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("" + CHR(201) + " necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpPed", THIS, THIS.DataSessionId)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Informar Pedido:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *-- "Substituir Composicao": Do Form SigSubCp With ThisForm, Cpros,
    *-- Citens, DataSessionId, CodTams (igual ao legado)
    PROCEDURE BtnsubcpClick()
        LOCAL loc_oForm, loc_oErro
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
                                      cursor_4c_Itens.citens, THIS.DataSessionId, ;
                                      cursor_4c_Itens.codtams)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Substituir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *-- "Detalhes": Do Form SigOpDet With ParentForm.PoDataMgr, Op_Escolha,
    *-- TprMvCab.Dopes, Cpros, TprMvCab.EmpDopNums
    PROCEDURE BtnDetClick()
        LOCAL loc_oForm, loc_oErro
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpDet", THIS.this_oParentForm, THIS.this_cOpEscolha, ;
                                      "", ALLTRIM(cursor_4c_Itens.cpros), "")
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Detalhes:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *-- "Finalidade": Do Form SigOpIns (finalidade da operacao no item)
    PROCEDURE BtnOptFinClick()
        LOCAL loc_oForm, loc_oErro
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpIns", THIS.this_oParentForm, "", "ITN", "", "")
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Finalidade:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *-- "Descontos": Do Form SigOpDes (descontos por cota)
    PROCEDURE BtnDescClick()
        LOCAL loc_oForm, loc_oErro
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("" + CHR(201) + " necess" + CHR(225) + "rio posicionar em um produto para fazer os descontos!!!", "Aviso")
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpDes", THIS.this_oParentForm)
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Descontos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *-- "Local. Destino": Do Form SigOpLcl/SigOpLcZ With ..., 'DESTINO'
    PROCEDURE BtnLocDesClick()
        LOCAL loc_oForm, loc_oErro
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("" + CHR(201) + " Necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpLcl", THIS.this_oParentForm, THIS.this_cOpEscolha, "DESTINO")
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Localiza" + CHR(231) + CHR(227) + "o de Destino:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *-- "Local. Origem": Do Form SigOpLcl/SigOpLcZ With ..., 'ORIGEM'
    PROCEDURE BtnLocOriClick()
        LOCAL loc_oForm, loc_oErro
        IF !THIS.TemProdutoSelecionado()
            MsgAviso("" + CHR(201) + " Necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
            RETURN
        ENDIF
        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpLcl", THIS.this_oParentForm, THIS.this_cOpEscolha, "ORIGEM")
        CATCH TO loc_oErro
            MostrarErro("Erro ao abrir Localiza" + CHR(231) + CHR(227) + "o de Origem:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaProduto - Page1 (pgProds no legado) "Dados do Produto".
    *
    * Painel do item CORRENTE da grade. No legado quase todo campo daqui tem
    * When() = Return .F. (espelho somente-leitura da linha) e os poucos
    * digitaveis sao: getDPros (descricao, so quando AltDescs = 1), getDocs
    * (documento), getLotes (numero do lote), getVDescs / getPDescs
    * (descontos), getObs (observacao do item), getCodCors / getCodTams (cor e
    * tamanho, com browse), get_prod / get_qtd (conferencia por codigo de
    * barras) e getBusca (procura na grade).
    *
    * Os campos que SAO coluna de SigMvItn usam ControlSource sobre
    * cursor_4c_Itens - exatamente o que o legado faz sobre crTpmMvItn - e por
    * isso acompanham a linha corrente da grade sozinhos. Os de EXIBICAO
    * (preco atual, grupo de venda, referencia, saldo, resta, peso medio) nao
    * sao coluna do item: no legado o AfterRowColChange da grade os preenche a
    * cada troca de linha, e aqui AtualizarPainelProduto() faz o mesmo.
    *
    * cnt_4c_Obs nasce Visible = .F. (painel flutuante da observacao, aberto
    * pelo Click de obj_4c_GetObs) e por isso entra na lista de excecao de
    * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaProduto()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- cnt_4c_Obs (cntObs no legado) - painel flutuante da observacao ---
        loc_oPag.AddObject("cnt_4c_Obs", "Container")
        WITH loc_oPag.cnt_4c_Obs
            .Top         = 1
            .Left        = 194
            .Width       = 792
            .Height      = 171
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH

        loc_oPag.cnt_4c_Obs.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oPag.cnt_4c_Obs.obj_4c_GetObs
            .Top           = 4
            .Left          = 2
            .Width         = 788
            .Height        = 163
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ControlSource = "cursor_4c_Itens.obs"
            .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
            .Visible       = .T.
        ENDWITH

        *-- shp_4c_Shape4 - moldura da area da imagem do produto -------------
        loc_oPag.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPag.shp_4c_Shape4
            .Top           = 2
            .Left          = 2
            .Width         = 192
            .Height        = 167
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- shp_4c_Shape1 - moldura do bloco "Procurar" ----------------------
        loc_oPag.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPag.shp_4c_Shape1
            .Top           = 130
            .Left          = 660
            .Width         = 286
            .Height        = 35
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Descricao do produto (editavel so com AltDescs = 1) --------------
        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Top       = 2
            .Left      = 202
            .Width     = 60
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DPros", "TextBox")
        WITH loc_oPag.txt_4c_DPros
            .Top               = 14
            .Left              = 202
            .Width             = 288
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Format            = "K!"
            .MaxLength         = 65
            .Margin            = 2
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.dpros"
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Visible           = .T.
        ENDWITH

        *-- Preco atual (exibicao - vem de SigCdPro, nao eh coluna do item) --
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 72
            .Left      = 202
            .Width     = 60
            .Height    = 15
            .Caption   = "Pre" + CHR(231) + "o Atual"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_PVens", "TextBox")
        WITH loc_oPag.txt_4c_PVens
            .Top               = 84
            .Left              = 202
            .Width             = 100
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .Value             = 0
            .InputMask         = "99999,999.999"
            .Margin            = 2
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Pre" + CHR(231) + "o Atual"
            .Visible           = .T.
        ENDWITH

        *-- Valor pago (invisivel no legado) ---------------------------------
        loc_oPag.AddObject("lbl_4c_LblValors", "Label")
        WITH loc_oPag.lbl_4c_LblValors
            .Top       = 72
            .Left      = 664
            .Width     = 53
            .Height    = 15
            .Caption   = "Valor Pago"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Valors", "TextBox")
        WITH loc_oPag.txt_4c_Valors
            .Top           = 84
            .Left          = 664
            .Width         = 98
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .Value         = 0
            .InputMask     = "9,999,999.99"
            .MaxLength     = 10
            .Margin        = 2
            .SpecialEffect = 1
            .BackColor     = RGB(255, 255, 220)
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Valor Pago"
            .Visible       = .F.
        ENDWITH

        *-- Observacao do item (abre o painel flutuante cnt_4c_Obs no Click) -
        loc_oPag.AddObject("lbl_4c_LblObs", "Label")
        WITH loc_oPag.lbl_4c_LblObs
            .Top       = 36
            .Left      = 462
            .Width     = 115
            .Height    = 15
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oPag.obj_4c_GetObs
            .Top           = 49
            .Left          = 462
            .Width         = 392
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .Margin        = 2
            .SpecialEffect = 1
            .ControlSource = "cursor_4c_Itens.obs"
            .NullDisplay   = " "
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
            .Visible       = .T.
        ENDWITH

        *-- Codigo de barras do item (somente leitura) -----------------------
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .Top       = 36
            .Left      = 202
            .Width     = 35
            .Height    = 15
            .Caption   = "Barra"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Barras", "TextBox")
        WITH loc_oPag.txt_4c_Barras
            .Top               = 49
            .Left              = 202
            .Width             = 108
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .Margin            = 2
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.codbarras"
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "C" + CHR(243) + "digo de Barras do Produto"
            .Visible           = .T.
        ENDWITH

        *-- Documento (notas) ------------------------------------------------
        loc_oPag.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPag.lbl_4c_Label7
            .Top       = 36
            .Left      = 311
            .Width     = 56
            .Height    = 15
            .Caption   = "Documento"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Docs", "TextBox")
        WITH loc_oPag.txt_4c_Docs
            .Top               = 49
            .Left              = 311
            .Width             = 67
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .InputMask         = "999999"
            .MaxLength         = 6
            .Margin            = 2
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.notas"
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Documento do Produto"
            .Visible           = .T.
        ENDWITH

        *-- Numero do lote ---------------------------------------------------
        loc_oPag.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPag.lbl_4c_Label8
            .Top       = 36
            .Left      = 380
            .Width     = 63
            .Height    = 15
            .Caption   = "N" + CHR(250) + "mero Lote"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Lotes", "TextBox")
        WITH loc_oPag.txt_4c_Lotes
            .Top               = 49
            .Left              = 380
            .Width             = 80
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .InputMask         = "9999999999"
            .MaxLength         = 10
            .Margin            = 2
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.nlotes"
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "N" + CHR(250) + "mero do Lote"
            .Visible           = .T.
        ENDWITH

        *-- Moeda do preco atual ---------------------------------------------
        loc_oPag.AddObject("txt_4c_MoeVs", "TextBox")
        WITH loc_oPag.txt_4c_MoeVs
            .Top               = 84
            .Left              = 303
            .Width             = 31
            .Height            = 21
            .FontName          = "Tahoma"
            .FontSize          = 8
            .MaxLength         = 3
            .Margin            = 2
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.moevs"
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Moeda do Pre" + CHR(231) + "o Atual"
            .Visible           = .T.
        ENDWITH

        *-- Grupo de venda (exibicao) ----------------------------------------
        loc_oPag.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPag.lbl_4c_Label11
            .Top       = 2
            .Left      = 491
            .Width     = 80
            .Height    = 15
            .Caption   = "Grupo de Venda"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_GVendas", "TextBox")
        WITH loc_oPag.txt_4c_GVendas
            .Top               = 14
            .Left              = 491
            .Width             = 261
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .Value             = ""
            .MaxLength         = 40
            .Margin            = 2
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Grupo de Venda"
            .Visible           = .T.
        ENDWITH

        *-- Desconto em valor ------------------------------------------------
        loc_oPag.AddObject("lbl_4c_LblVDescs", "Label")
        WITH loc_oPag.lbl_4c_LblVDescs
            .Top       = 72
            .Left      = 487
            .Width     = 74
            .Height    = 15
            .Caption   = "Valor Desconto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_VDescs", "TextBox")
        WITH loc_oPag.txt_4c_VDescs
            .Top               = 84
            .Left              = 487
            .Width             = 92
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .InputMask         = "999,999.99"
            .Margin            = 2
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.valdescs"
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Valor do Desconto"
            .Visible           = .T.
        ENDWITH

        *-- Desconto em percentual -------------------------------------------
        loc_oPag.AddObject("lbl_4c_LblPDescs", "Label")
        WITH loc_oPag.lbl_4c_LblPDescs
            .Top       = 72
            .Left      = 581
            .Width     = 61
            .Height    = 15
            .Caption   = "% Desconto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_PDescs", "TextBox")
        WITH loc_oPag.txt_4c_PDescs
            .Top               = 84
            .Left              = 581
            .Width             = 79
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .InputMask         = "999.99"
            .Margin            = 2
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.pdescs"
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Percentual do Desconto"
            .Visible           = .T.
        ENDWITH

        *-- Observacoes do pedido (exibicao) ---------------------------------
        loc_oPag.AddObject("obj_4c_GetObsPes", "EditBox")
        WITH loc_oPag.obj_4c_GetObsPes
            .Top           = 107
            .Left          = 202
            .Width         = 200
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .NullDisplay   = " "
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o 1"
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_GetObsPeds", "EditBox")
        WITH loc_oPag.obj_4c_GetObsPeds
            .Top           = 107
            .Left          = 404
            .Width         = 200
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .NullDisplay   = " "
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o 2"
            .Visible       = .T.
        ENDWITH

        *-- Cor e Tamanho (nascem invisiveis, como no legado) ----------------
        loc_oPag.AddObject("lbl_4c_LblCodCors", "Label")
        WITH loc_oPag.lbl_4c_LblCodCors
            .Top       = 2
            .Left      = 753
            .Width     = 19
            .Height    = 15
            .Caption   = "Cor"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPag.AddObject("txt_4c_CodCors", "TextBox")
        WITH loc_oPag.txt_4c_CodCors
            .Top           = 14
            .Left          = 753
            .Width         = 36
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .Alignment     = 3
            .MaxLength     = 4
            .Margin        = 2
            .SpecialEffect = 1
            .ControlSource = "cursor_4c_Itens.codcors"
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Cor do Produto"
            .Visible       = .F.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_LblCodTams", "Label")
        WITH loc_oPag.lbl_4c_LblCodTams
            .Top       = 2
            .Left      = 790
            .Width     = 22
            .Height    = 15
            .Caption   = "Tam"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPag.AddObject("txt_4c_CodTams", "TextBox")
        WITH loc_oPag.txt_4c_CodTams
            .Top           = 14
            .Left          = 790
            .Width         = 36
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .Alignment     = 3
            .MaxLength     = 4
            .Margin        = 2
            .SpecialEffect = 1
            .ControlSource = "cursor_4c_Itens.codtams"
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Tamanho do Produto"
            .Visible       = .F.
        ENDWITH

        *-- cnt_4c_Reffs - referencia do fornecedor (exibicao) ---------------
        loc_oPag.AddObject("cnt_4c_Reffs", "Container")
        WITH loc_oPag.cnt_4c_Reffs
            .Top         = 66
            .Left        = 332
            .Width       = 154
            .Height      = 41
            .BackStyle   = 0
            .BorderWidth = 0
            .BorderColor = RGB(36, 84, 155)
            .Visible     = .T.
        ENDWITH

        loc_oPag.cnt_4c_Reffs.AddObject("lbl_4c_LblReffs", "Label")
        WITH loc_oPag.cnt_4c_Reffs.lbl_4c_LblReffs
            .Top       = 5
            .Left      = 3
            .Width     = 130
            .Height    = 15
            .Caption   = "Refer" + CHR(234) + "ncia do Fornecedor"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.cnt_4c_Reffs.AddObject("txt_4c_Reffs", "TextBox")
        WITH loc_oPag.cnt_4c_Reffs.txt_4c_Reffs
            .Top               = 18
            .Left              = 3
            .Width             = 150
            .Height            = 21
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Value             = ""
            .MaxLength         = 40
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Refer" + CHR(234) + "ncia do Fornecedor"
            .Visible           = .T.
        ENDWITH

        *-- Saldo / Baixa / Resta / Peso medio -------------------------------
        loc_oPag.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPag.lbl_4c_Label4
            .Top       = 72
            .Left      = 765
            .Width     = 35
            .Height    = 15
            .Caption   = "Saldo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Saldo", "TextBox")
        WITH loc_oPag.txt_4c_Saldo
            .Top           = 84
            .Left          = 765
            .Width         = 89
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .FontBold      = .F.
            .Value         = 0
            .MaxLength     = 10
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Saldo"
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag.lbl_4c_Label6
            .Top       = 111
            .Left      = 606
            .Width     = 35
            .Height    = 15
            .Caption   = "Baixa"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Qtbaixa", "TextBox")
        WITH loc_oPag.txt_4c_Qtbaixa
            .Top           = 107
            .Left          = 640
            .Width         = 89
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .FontBold      = .F.
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .ControlSource = "cursor_4c_Itens.qtbaixas"
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Quantidade Baixada"
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPag.lbl_4c_Label9
            .Top       = 112
            .Left      = 729
            .Width     = 35
            .Height    = 15
            .Caption   = "Resta"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Qtresta", "TextBox")
        WITH loc_oPag.txt_4c_Qtresta
            .Top           = 107
            .Left          = 765
            .Width         = 89
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .FontBold      = .F.
            .Value         = 0
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Quantidade Restante"
            .Visible       = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPag.lbl_4c_Label13
            .Top       = 72
            .Left      = 857
            .Width     = 60
            .Height    = 15
            .Caption   = "Peso M" + CHR(233) + "dio"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Peso", "TextBox")
        WITH loc_oPag.txt_4c_Peso
            .Top           = 84
            .Left          = 857
            .Width         = 89
            .Height        = 21
            .FontName      = "Courier New"
            .FontSize      = 8
            .FontBold      = .F.
            .Value         = 0
            .InputMask     = "9,999.999"
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Peso M" + CHR(233) + "dio"
            .Visible       = .T.
        ENDWITH

        *-- Conferencia por codigo: Produto + Qtde ---------------------------
        loc_oPag.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPag.lbl_4c_Label10
            .Top       = 2
            .Left      = 827
            .Width     = 40
            .Height    = 15
            .Caption   = "Produto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__prod", "TextBox")
        WITH loc_oPag.txt_4c__prod
            .Top               = 14
            .Left              = 827
            .Width             = 123
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .Value             = ""
            .MaxLength         = 14
            .Margin            = 2
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "C" + CHR(243) + "digo de Barras do Produto"
            .Visible           = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPag.lbl_4c_Label12
            .Top       = 36
            .Left      = 858
            .Width     = 26
            .Height    = 15
            .Caption   = "Qtde"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__qtd", "TextBox")
        WITH loc_oPag.txt_4c__qtd
            .Top               = 49
            .Left              = 858
            .Width             = 79
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .Value             = 0
            .InputMask         = "99999.99"
            .Margin            = 2
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Quantidade Conferida"
            .Visible           = .T.
        ENDWITH

        *-- Imagem do produto (sobre shp_4c_Shape4; nasce invisivel) ---------
        loc_oPag.AddObject("img_4c_ImgProds", "Image")
        WITH loc_oPag.img_4c_ImgProds
            .Top         = 4
            .Left        = 4
            .Width       = 188
            .Height      = 163
            .Stretch     = 1
            .ToolTipText = "Imagem do Produto [Duplo Click Para Zoom]"
            .Visible     = .F.
        ENDWITH

        *-- Bloco "Procurar" (obj_4c_Opt_Busca + txt_4c_Busca) ---------------
        loc_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag.lbl_4c_Label3
            .Top       = 140
            .Left      = 675
            .Width     = 43
            .Height    = 15
            .Caption   = "Procurar"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_Opt_Busca", "OptionGroup")
        WITH loc_oPag.obj_4c_Opt_Busca
            .Top         = 135
            .Left        = 713
            .Width       = 119
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .AutoSize    = .F.
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Barras"
                .Top       = 5
                .Left      = 5
                .Width     = 49
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Produto"
                .Top       = 5
                .Left      = 58
                .Width     = 56
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        loc_oPag.AddObject("txt_4c_Busca", "TextBox")
        WITH loc_oPag.txt_4c_Busca
            .Top               = 136
            .Left              = 830
            .Width             = 108
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .Value             = ""
            .Format            = "K!"
            .InputMask         = "XXXXXXXXXXXXXX"
            .MaxLength         = 14
            .ReadOnly          = .F.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "C" + CHR(243) + "digo de Barra Para Procura na Grade"
            .Visible           = .T.
        ENDWITH

        *-- Codigo pai (composicao) e fornecedor -----------------------------
        loc_oPag.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPag.lbl_4c_Label14
            .Top       = 127
            .Left      = 202
            .Width     = 42
            .Height    = 15
            .Caption   = "Cod. Pai"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- "Cod. Pai" eh o CONJUNTO do produto (SigCdPro.Conjunts char(6)),
        *-- nao o item pai da composicao: no legado o preenchimento eh
        *-- "getConjunts.Value = crTmpPro.Conjunts". Por isso fica em .Value
        *-- (campo de EXIBICAO, alimentado por AtualizarPainelProduto) e NAO
        *-- com ControlSource em citem2, que eh outra coisa.
        loc_oPag.AddObject("txt_4c_Conjunts", "TextBox")
        WITH loc_oPag.txt_4c_Conjunts
            .Top               = 140
            .Left              = 202
            .Width             = 55
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .Value             = ""
            .MaxLength         = 6
            .Margin            = 2
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "C" + CHR(243) + "digo do Conjunto do Produto"
            .Visible           = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPag.lbl_4c_Label15
            .Top       = 127
            .Left      = 260
            .Width     = 60
            .Height    = 15
            .Caption   = "Fornecedor"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPag.AddObject("txt_4c_GerDIfors", "TextBox")
        WITH loc_oPag.txt_4c_GerDIfors
            .Top               = 140
            .Left              = 260
            .Width             = 261
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .Alignment         = 3
            .Value             = ""
            .MaxLength         = 40
            .Margin            = 2
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Fornecedor"
            .Visible           = .F.
        ENDWITH

        *-- Eventos: o Valid do legado vira LostFocus aqui (regra #47); nada
        *-- fica em KeyPress sem teste explicito de tecla.
        BINDEVENT(loc_oPag.txt_4c__prod,   "LostFocus", THIS, "TxtProdLostFocus")
        BINDEVENT(loc_oPag.txt_4c__qtd,    "LostFocus", THIS, "TxtQtdLostFocus")
        BINDEVENT(loc_oPag.txt_4c_Busca,   "LostFocus", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPag.txt_4c_CodCors, "LostFocus", THIS, "ValidarCodCorLostFocus")
        BINDEVENT(loc_oPag.txt_4c_CodTams, "LostFocus", THIS, "ValidarCodTamLostFocus")
        BINDEVENT(loc_oPag.txt_4c_Docs,    "LostFocus", THIS, "ValidarDocsLostFocus")
        BINDEVENT(loc_oPag.txt_4c_Lotes,   "LostFocus", THIS, "ValidarLotesLostFocus")
        BINDEVENT(loc_oPag.txt_4c_VDescs,  "LostFocus", THIS, "ValidarVDescsLostFocus")
        BINDEVENT(loc_oPag.txt_4c_PDescs,  "LostFocus", THIS, "ValidarPDescsLostFocus")
        BINDEVENT(loc_oPag.obj_4c_GetObs,  "Click",     THIS, "ObsAbrirPainelClick")
        BINDEVENT(loc_oPag.cnt_4c_Obs.obj_4c_GetObs, "LostFocus", THIS, "ObsFecharPainelLostFocus")
        BINDEVENT(loc_oPag.img_4c_ImgProds, "DblClick", THIS, "ImgProdsDblClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaFiscal - Page3 (pgFiscs no legado) "Dados Fiscais".
    *
    * Painel fiscal do item corrente, todo dentro de cnt_4c_Item (CntItem no
    * legado). No legado TODOS os campos daqui tem When() = Return .F. -
    * exibicao pura - EXCETO getNAdis, getNIAdis e getcodfabs, cujo When eh
    * "Return (InList(ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR'))": sao os
    * tres dados de importacao que o usuario informa (numero da adicao, item
    * da adicao e codigo do fabricante estrangeiro).
    *
    * A pagina so eh habilitada pelo legado quando o usuario pede alteracao de
    * impostos (btnAltImps.Click faz "pgfPagina.pgFiscs.Enabled = .t."), e eh
    * isso que HabilitarCampos reproduz.
    *
    * Os campos sao coluna de SigMvItn e por isso usam ControlSource sobre
    * cursor_4c_Itens, acompanhando a linha corrente da grade. Os dois que NAO
    * sao coluna do item (classificacao fiscal e a descricao dela, que vem de
    * SigCdPro/SigCdClf) ficam em .Value e sao preenchidos por
    * AtualizarPainelProduto(), como o AfterRowColChange do legado faz.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaFiscal()
        LOCAL loc_oPag, loc_oCnt
        loc_oPag = THIS.pgf_4c_Paginas.Page3

        loc_oPag.AddObject("cnt_4c_Item", "Container")
        WITH loc_oPag.cnt_4c_Item
            .Top           = -6
            .Left          = 2
            .Width         = 973
            .Height        = 151
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(188, 201, 254)
            .BorderColor   = RGB(36, 84, 155)
            .Visible       = .T.
        ENDWITH

        loc_oCnt = loc_oPag.cnt_4c_Item

        *-- Moldura do bloco de Importacao -----------------------------------
        loc_oCnt.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oCnt.shp_4c_Shape1
            .Top         = 63
            .Left        = 802
            .Width       = 163
            .Height      = 84
            .BackStyle   = 0
            .BorderStyle = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Linha 1: produto, descricao, classificacao fiscal e Obs2 ---------
        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFCPros", 7, 9, 45, "Produto")

        loc_oCnt.AddObject("txt_4c_FCPros", "TextBox")
        WITH loc_oCnt.txt_4c_FCPros
            .Top           = 21
            .Left          = 9
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .InputMask     = "!!!!!!!!!!!!!!"
            .MaxLength     = 14
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .ControlSource = "cursor_4c_Itens.cpros"
            .BackColor     = RGB(251, 254, 226)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_FDPros", "TextBox")
        WITH loc_oCnt.txt_4c_FDPros
            .Top               = 21
            .Left              = 119
            .Width             = 303
            .Height            = 21
            .FontName          = "Courier New"
            .FontSize          = 8
            .MaxLength         = 65
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.dpros"
            .BackColor         = RGB(251, 254, 226)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(90, 90, 90)
            .Visible           = .T.
        ENDWITH

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFClFis", 7, 424, 100, ;
                                  "Classifica" + CHR(231) + CHR(227) + "o Fiscal")

        loc_oCnt.AddObject("txt_4c_FClFis", "TextBox")
        WITH loc_oCnt.txt_4c_FClFis
            .Top           = 21
            .Left          = 424
            .Width         = 89
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Format        = "R"
            .InputMask     = "9999.99.9999"
            .MaxLength     = 12
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BackColor     = RGB(251, 254, 226)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_FDlFis", "TextBox")
        WITH loc_oCnt.txt_4c_FDlFis
            .Top           = 21
            .Left          = 515
            .Width         = 216
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 60
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BackColor     = RGB(251, 254, 226)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label16", 7, 732, 30, "Obs2")

        loc_oCnt.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oCnt.obj_4c_GetObs
            .Top           = 21
            .Left          = 732
            .Width         = 235
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ControlSource = "cursor_4c_Itens.ob2s"
            .NullDisplay   = " "
            .BorderColor   = RGB(90, 90, 90)
            .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o 2"
            .Visible       = .T.
        ENDWITH

        *-- Linha 2: total, IPI, ICMS, ICMS-ST, situacao tributaria ----------
        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFTotal", 48, 10, 35, "Total")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FTotal", 61, 10, 112, ;
                                    "999,999,999.99", "cursor_4c_Itens.totas")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFPipis", 48, 124, 35, "%IPI")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FPipis", 61, 124, 48, ;
                                    "99.99", "cursor_4c_Itens.aliqs")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFVipis", 48, 174, 16, "IPI")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FVipis", 61, 174, 97, ;
                                    "9999,999.99", "cursor_4c_Itens.valipis")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFPIcms", 48, 273, 40, "%ICMS")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FPIcms", 61, 273, 48, ;
                                    "99.99", "cursor_4c_Itens.aliqicms")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFVIcms", 48, 323, 27, "ICMS")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FVIcms", 61, 323, 98, ;
                                    "9999,999.99", "cursor_4c_Itens.icms")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFIcmsS", 48, 424, 88, ;
                                  "ICMS Substitui" + CHR(231) + CHR(227) + "o")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FIcmsS", 61, 424, 96, ;
                                    "9999,999.99", "cursor_4c_Itens.icmss")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label1", 48, 532, 14, "ST")

        loc_oCnt.AddObject("txt_4c_SitTrI", "TextBox")
        WITH loc_oCnt.txt_4c_SitTrI
            .Top           = 61
            .Left          = 524
            .Width         = 43
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Value         = ""
            .MaxLength     = 3
            .ReadOnly      = .T.
            .SpecialEffect = 1
            *-- getSitTrI do legado le crTpmMvItn.SitTrIcms (NAO sitribs, que
            *-- eh outra coluna da mesma tabela)
            .ControlSource = "cursor_4c_Itens.sittricms"
            .BackColor     = RGB(251, 254, 226)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Linha 3: bases de IPI / ICMS / ICMS-ST e CFOP --------------------
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VBipis", 84, 174, 97, ;
                                    "9999,999.99", "cursor_4c_Itens.bcipis")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FBIcms", 84, 323, 98, ;
                                    "9999,999.99", "cursor_4c_Itens.baseicms")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FBIcsS", 84, 424, 96, ;
                                    "9999,999.99", "cursor_4c_Itens.bcicmss")

        loc_oCnt.AddObject("txt_4c_Cfop", "TextBox")
        WITH loc_oCnt.txt_4c_Cfop
            .Top           = 84
            .Left          = 524
            .Width         = 43
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Value         = ""
            .InputMask     = "XXXXXXXXXX"
            .MaxLength     = 10
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .ControlSource = "cursor_4c_Itens.cfops"
            .BackColor     = RGB(251, 254, 226)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Linha 4: base de calculo, PIS, COFINS, ISS, IRRF, INSS, CSSL, II -
        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label5", 111, 13, 67, ;
                                  "Base C" + CHR(225) + "lculos")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VBc", 124, 10, 108, ;
                                    "999,999,999.99", "cursor_4c_Itens.valbases")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label6", 111, 124, 18, "PIS")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_Vpis", 124, 121, 95, ;
                                    "999,999.99", "cursor_4c_Itens.vpis")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label9", 111, 221, 40, "COFINS")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_Vcof", 124, 218, 95, ;
                                    "999,999.99", "cursor_4c_Itens.vcofins")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label13", 111, 318, 18, "ISS")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VIss", 124, 315, 95, ;
                                    "999,999.99", "cursor_4c_Itens.iss")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label8", 111, 415, 26, "IRRF")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VIrrf", 124, 412, 95, ;
                                    "999,999.99", "cursor_4c_Itens.irrf")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label10", 111, 512, 25, "INSS")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VInss", 124, 509, 95, ;
                                    "999,999.99", "cursor_4c_Itens.inss")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label12", 111, 609, 26, "CSSL")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VCssl", 124, 606, 95, ;
                                    "999,999.99", "cursor_4c_Itens.cssl")

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label11", 111, 706, 10, "II")
        THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_Vii", 124, 703, 95, ;
                                    "999,999.99", "cursor_4c_Itens.taxaiis")

        *-- Bloco Importacao: os TRES unicos campos digitaveis desta pagina --
        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label4", 49, 804, 60, ;
                                  "Importa" + CHR(231) + CHR(227) + "o ")
        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label7", 69, 806, 44, ;
                                  "N Adi" + CHR(231) + CHR(227) + "o")

        loc_oCnt.AddObject("txt_4c_NAdis", "TextBox")
        WITH loc_oCnt.txt_4c_NAdis
            .Top               = 84
            .Left              = 806
            .Width             = 31
            .Height            = 21
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .InputMask         = "999"
            .MaxLength         = 3
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.nadis"
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Dado de Importa" + CHR(231) + CHR(227) + ;
                                 "o - Numero da Adi" + CHR(231) + CHR(227) + "o"
            .Visible           = .T.
        ENDWITH

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label2", 69, 875, 59, ;
                                  "Item Adi" + CHR(231) + CHR(227) + "o")

        loc_oCnt.AddObject("txt_4c_NIAdis", "TextBox")
        WITH loc_oCnt.txt_4c_NIAdis
            .Top               = 84
            .Left              = 876
            .Width             = 31
            .Height            = 21
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .InputMask         = "999"
            .MaxLength         = 3
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.niadis"
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Dado de Importa" + CHR(231) + CHR(227) + ;
                                 "o - Numero do item da Adi" + CHR(231) + CHR(227) + "o"
            .Visible           = .T.
        ENDWITH

        THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label3", 108, 806, 121, ;
                                  "C Fabricante Estrangeiro")

        loc_oCnt.AddObject("txt_4c_Codfabs", "TextBox")
        WITH loc_oCnt.txt_4c_Codfabs
            .Top               = 123
            .Left              = 806
            .Width             = 155
            .Height            = 21
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 0
            .Format            = "!"
            .MaxLength         = 6
            .SpecialEffect     = 1
            .ControlSource     = "cursor_4c_Itens.codfabs"
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(90, 90, 90)
            .ToolTipText       = "Dado de Importa" + CHR(231) + CHR(227) + ;
                                 "o - C" + CHR(243) + "digo do Fabricante Estrangeiro"
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarLabelFiscal - Fabrica dos rotulos de cnt_4c_Item. Todos os Say
    * daquele container tem no dump a MESMA assinatura (Tahoma 8, FontBold
    * = .F., BackStyle = 0, ForeColor = 90,90,90) e variam so em Top/Left/
    * Width/Caption, entao repetir 20 blocos WITH identicos aqui so aumentaria
    * a chance de um deles sair com propriedade faltando.
    *
    * Alignment = 0 e AutoSize = .F. com Width explicita: a classe say do
    * legado eh AutoSize, mas AutoSize eh no-op em Label criado por AddObject
    * (regra #23) - a largura tem de vir escrita.
    *==========================================================================
    PROTECTED PROCEDURE AdicionarLabelFiscal(par_oPai, par_cNome, par_nTop, ;
                                             par_nLeft, par_nWidth, par_cCaption)
        par_oPai.AddObject(par_cNome, "Label")

        WITH EVALUATE("par_oPai." + par_cNome)
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = 15
            .Caption   = par_cCaption
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarTextBoxFiscal - Fabrica dos campos numericos de cnt_4c_Item.
    * No dump todos tem a mesma assinatura (Tahoma 8, Alignment = 3, Height
    * = 21, SpecialEffect = 1, BackColor = 251,254,226, BorderColor =
    * 90,90,90) e When() = Return .F., isto eh: exibicao pura - o que aqui
    * vira ReadOnly = .T. (o When do legado nao tem equivalente direto em
    * TextBox criado por AddObject, e ReadOnly reproduz o efeito de nao
    * aceitar digitacao sem esconder o valor).
    *==========================================================================
    PROTECTED PROCEDURE AdicionarTextBoxFiscal(par_oPai, par_cNome, par_nTop, ;
                                               par_nLeft, par_nWidth, ;
                                               par_cMascara, par_cFonte)
        par_oPai.AddObject(par_cNome, "TextBox")

        WITH EVALUATE("par_oPai." + par_cNome)
            .Top           = par_nTop
            .Left          = par_nLeft
            .Width         = par_nWidth
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .InputMask     = par_cMascara
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .ControlSource = par_cFonte
            .BackColor     = RGB(251, 254, 226)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CriarCursorPrecos - Cursor da grade de Precificacao (Page4). No legado a
    * grdPrecos esta ligada a "lpitem", cursor da lista de precificacao que
    * vive no data session do form PAI de Movimentacao; aqui ele eh local e eh
    * populado por CarregarPrecos() a partir de SigOpLpi/SigOpLpr.
    *
    * Criado ANTES de ConfigurarPaginaPrecos porque Column.ControlSource de
    * alias inexistente derruba o Init (regra #41).
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorPrecos()
        IF USED("cursor_4c_Precos")
            USE IN cursor_4c_Precos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Precos ( ;
            lprecos C(30), tabds C(20), units N(11,2), moedas C(3))
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaPrecos - Page4 (pgPrecos no legado) "Precificacao".
    *
    * Grade grdPrecos: lista as precificacoes disponiveis para o produto do
    * item corrente. Nasce Visible = .F. e ReadOnly = .T. no SCX legado (o
    * proprio legado so a mostra quando a operacao trabalha com lista de
    * precos), e por isso entra na lista de excecao de
    * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
    *
    * Ordem de configuracao obrigatoria (regra #41 / Problema 48):
    * ColumnCount -> RecordSource -> ControlSource -> Width -> Header.Caption.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaPrecos()
        LOCAL loc_oPag, loc_oGrd
        loc_oPag = THIS.pgf_4c_Paginas.Page4

        loc_oPag.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = loc_oPag.grd_4c_Dados

        WITH loc_oGrd
            .Top                = 9
            .Left               = 7
            .Width              = 416
            .Height             = 131
            .ColumnCount        = 4
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .AllowHeaderSizing  = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .RecordSource       = "cursor_4c_Precos"
            .Visible            = .F.
        ENDWITH

        WITH loc_oGrd.Column1
            .ControlSource   = "cursor_4c_Precos.lprecos"
            .Width           = 210
            .Movable         = .F.
            .Resizable       = .F.
            .ReadOnly        = .T.
            .FontName        = "Courier New"
            .Header1.Caption = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
            .Visible         = .T.
        ENDWITH

        WITH loc_oGrd.Column2
            .ControlSource   = "cursor_4c_Precos.tabds"
            .Width           = 80
            .Movable         = .F.
            .Resizable       = .F.
            .ReadOnly        = .T.
            .FontName        = "Courier New"
            .Header1.Caption = "Tab.Varia" + CHR(231) + CHR(227) + "o"
            .Visible         = .T.
        ENDWITH

        WITH loc_oGrd.Column3
            .ControlSource   = "cursor_4c_Precos.units"
            .Width           = 70
            .Movable         = .F.
            .Resizable       = .F.
            .ReadOnly        = .T.
            .FontName        = "Courier New"
            .InputMask       = "9999,999.99"
            .Header1.Caption = "Unit" + CHR(225) + "rio"
            .Visible         = .T.
        ENDWITH

        WITH loc_oGrd.Column4
            .ControlSource   = "cursor_4c_Precos.moedas"
            .Width           = 30
            .Movable         = .F.
            .Resizable       = .F.
            .ReadOnly        = .T.
            .FontName        = "Courier New"
            .Header1.Caption = "Moe"
            .Visible         = .T.
        ENDWITH

        WITH loc_oGrd
            .FontName = "Courier New"
            .FontSize = 8
            .HeaderHeight = 16
            .RowHeight    = 16
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarPrecos - Recebe do form PAI as linhas da lista de precificacao e
    * as entrega a grade de Page4.
    *
    * No legado a grdPrecos esta ligada ao cursor "lpitem", que o form PAI de
    * Movimentacao monta e mantem: dentro do SIGOPPRO nao existe UMA linha que
    * popule esse cursor - a tela apenas o exibe. Por isso aqui tambem NAO se
    * inventa consulta: o pai informa o alias que ele montou e este metodo
    * copia as linhas para cursor_4c_Precos, repinta e mostra a grade.
    *
    * Desvio registrado: no SCX legado so Column2 declara ControlSource
    * ("lpitem.tabds") - as outras tres ficaram com ControlSource vazio, o que
    * as deixa em branco na tela. Os headers ("Lista de Precificacao",
    * "Unitario", "Moe"), a MaxLength = 30 da Column1 e a InputMask numerica da
    * Column3 provam a intencao, e por isso as quatro colunas foram ligadas.
    *
    * PUBLIC: eh o form pai quem chama.
    *==========================================================================
    PROCEDURE CarregarPrecos(par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOrigem) <> "C" OR EMPTY(par_cCursorOrigem)
            RETURN .F.
        ENDIF

        IF !USED(ALLTRIM(par_cCursorOrigem))
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Precos")
            THIS.CriarCursorPrecos()
        ENDIF

        TRY
            *-- ZAP (nao fechar/recriar): fechar o alias derrubaria o
            *-- RecordSource da grade e ela viraria um retangulo branco.
            SELECT cursor_4c_Precos
            THIS.ZaparCursor("cursor_4c_Precos")

            *-- APPEND FROM DBF casa os campos por NOME: o alias do pai tem de
            *-- trazer lprecos/tabds/units/moedas.
            SELECT cursor_4c_Precos
            APPEND FROM DBF(ALLTRIM(par_cCursorOrigem))

            GO TOP IN cursor_4c_Precos

            WITH THIS.pgf_4c_Paginas.Page4.grd_4c_Dados
                .Visible = (RECCOUNT("cursor_4c_Precos") > 0)
                .Refresh()
            ENDWITH

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar a lista de precifica" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro CarregarPrecos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ZaparCursor - ZAP guardado por SAFETY para qualquer alias. Irmao de
    * ZaparCursorItens: SET SAFETY eh escopado por DATA SESSION e este form eh
    * DataSession = 2, onde SAFETY volta a ON mesmo com o SET SAFETY OFF do
    * main.prg - e com SAFETY ON o ZAP abre o dialogo "Zap ... Are you sure?"
    * e CONGELA a tela esperando um clique que ninguem ve.
    *==========================================================================
    PROTECTED PROCEDURE ZaparCursor(par_cAlias)
        LOCAL loc_cSafety

        IF VARTYPE(par_cAlias) <> "C" OR !USED(ALLTRIM(par_cAlias))
            RETURN .F.
        ENDIF

        loc_cSafety = SET("SAFETY")
        SET SAFETY OFF

        SELECT (ALLTRIM(par_cAlias))
        ZAP

        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - Handler de AfterRowColChange de grd_4c_Dados.
    *
    * Declara par_nColIndex porque o evento passa esse argumento e handler sem
    * o parametro estoura a cada troca de celula (regra #3). O uso aqui eh o
    * MESMO do legado: carregar o detalhe da LINHA corrente, sem filtrar por
    * coluna - validacao de celula NAO entra aqui (regra #46), ela mora no
    * Valid do TextBox da coluna.
    *
    * PUBLIC: eh alvo de BINDEVENT e tambem do harness de teste.
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        THIS.AtualizarPainelProduto()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * AtualizarPainelProduto - Preenche os campos de EXIBICAO de Page1 e Page3
    * a partir do produto da linha corrente da grade.
    *
    * Transcreve o bloco de preenchimento do fwGrade.AfterRowColChange do
    * legado: consulta SigCdPro (com LEFT JOIN em SigCdCol para a descricao da
    * colecao), SigPrFnc (referencia do fornecedor por conta), SigMvEst (saldo
    * do produto no grupo de estoque), SigCdCli (nome do fornecedor) e
    * SigCdClf (descricao da classificacao fiscal), e devolve:
    *
    *   getPVens/getMoeVs       <- crTmpPro.PVens / .MoeVs
    *   cntReffs.getReffs       <- SigPrFnc.Reffs, com fallback SigCdPro.Reffs
    *   getGVendas              <- Colecoes + " - " + Descs da colecao
    *   getObsPes/getObsPeds    <- crTmpPro.ObsPes / .ObsPeds
    *   getPesoms               <- crTmpPro.Pesoms
    *   gerDIfors               <- SigCdCli.RClis do fornecedor do produto
    *   getsaldo                <- SigMvEst.Sqtds
    *   getqtresta              <- qtds - qtbaixas (qtds quando nada baixado)
    *   lblVDescs/lblPDescs     <- trocam para "Acrescimo" quando ValDescs < 0
    *   getFClFis/getFDlFis     <- classificacao fiscal e a descricao dela
    *
    * Os campos que SAO coluna de SigMvItn nao aparecem aqui: eles tem
    * ControlSource sobre cursor_4c_Itens e acompanham a linha sozinhos - no
    * legado eram atribuidos um a um porque la nao havia ControlSource.
    *
    * PUBLIC: o form pai e o harness chamam de fora.
    *==========================================================================
    PROCEDURE AtualizarPainelProduto()
        LOCAL loc_oPag, loc_oFis, loc_cPro, loc_cSQL, loc_cReff, loc_cDsCol
        LOCAL loc_cNomeFor, loc_cClFis, loc_cDsClFis, loc_nSaldo, loc_nResta
        LOCAL loc_lProsseguir, loc_oErro

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oFis = THIS.pgf_4c_Paginas.Page3.cnt_4c_Item

        loc_cPro = ""
        IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
            loc_cPro = ALLTRIM(cursor_4c_Itens.cpros)
        ENDIF

        *-- Linha sem produto: painel limpo, como no ramo ELSE do legado
        IF EMPTY(loc_cPro)
            THIS.LimparPainelProduto()
            RETURN .F.
        ENDIF

        *-- Sem conexao (validacao de UI / modo teste) nao ha o que consultar;
        *-- os campos ligados ao cursor continuam mostrando o item.
        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            THIS.LimparPainelProduto()
            RETURN .F.
        ENDIF

        loc_lProsseguir = .T.
        loc_cReff       = ""
        loc_cDsCol      = ""
        loc_cNomeFor    = ""
        loc_cClFis      = ""
        loc_cDsClFis    = ""
        loc_nSaldo      = 0

        TRY
            *-- Produto + descricao da colecao -----------------------------
            loc_cSQL = "SELECT a.Cpros, a.CGrus, a.Reffs, a.Situas," + ;
                       " a.DtSituas, a.CUnis, a.Dpros, a.PesoMs, a.MoeVs," + ;
                       " a.PVens, a.Moedas, a.Colecoes, a.ClFiscals," + ;
                       " a.ObsPes, a.ObsPeds, a.Conjunts, a.ifors," + ;
                       " b.Descs AS ColDescs" + ;
                       " FROM SigCdPro a" + ;
                       " LEFT JOIN SigCdCol b ON a.Colecoes = b.Colecoes" + ;
                       " WHERE a.Cpros = " + EscaparSQL(loc_cPro)

            IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ProTmp")
                IF USED("cursor_4c_ProTmp")
                    SELECT cursor_4c_ProTmp
                    GO TOP
                    IF !EOF()
                        loc_cReff    = TratarNulo(cursor_4c_ProTmp.Reffs, "")
                        loc_cDsCol   = TratarNulo(cursor_4c_ProTmp.ColDescs, "")
                        loc_cClFis   = TratarNulo(cursor_4c_ProTmp.ClFiscals, "")
                    ELSE
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ELSE
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Referencia do fornecedor da conta (SigPrFnc sobrepoe a de
                *-- SigCdPro, como no legado)
                loc_cSQL = "SELECT Reffs FROM SigPrFnc" + ;
                           " WHERE Cpros = " + EscaparSQL(loc_cPro) + ;
                           " AND Ifors = " + EscaparSQL(THIS.ObterContaFornecedor())

                IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_FProTmp")
                    IF USED("cursor_4c_FProTmp")
                        SELECT cursor_4c_FProTmp
                        GO TOP
                        IF !EOF()
                            loc_cReff = TratarNulo(cursor_4c_FProTmp.Reffs, loc_cReff)
                        ENDIF
                    ENDIF
                ENDIF

                *-- Saldo do produto no grupo de estoque
                loc_cSQL = "SELECT e.Sqtds FROM SigCdPro p" + ;
                           " LEFT JOIN SigMvEst e ON e.CPros = p.CPros" + ;
                           " AND e.EmpGruEsts = " + EscaparSQL(THIS.ObterGrupoEstoque()) + ;
                           " WHERE p.CPros = " + EscaparSQL(loc_cPro)

                IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_SaldoTmp")
                    IF USED("cursor_4c_SaldoTmp")
                        SELECT cursor_4c_SaldoTmp
                        GO TOP
                        IF !EOF()
                            loc_nSaldo = TratarNulo(cursor_4c_SaldoTmp.Sqtds, 0)
                        ENDIF
                    ENDIF
                ENDIF

                *-- Nome do fornecedor do produto
                SELECT cursor_4c_ProTmp
                loc_cSQL = "SELECT RClis FROM SigCdCli" + ;
                           " WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_ProTmp.ifors, "")))

                IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ForTmp")
                    IF USED("cursor_4c_ForTmp")
                        SELECT cursor_4c_ForTmp
                        GO TOP
                        IF !EOF()
                            loc_cNomeFor = TratarNulo(cursor_4c_ForTmp.RClis, "")
                        ENDIF
                    ENDIF
                ENDIF

                *-- Descricao da classificacao fiscal
                IF !EMPTY(loc_cClFis)
                    loc_cSQL = "SELECT Descricaos FROM SigCdClf" + ;
                               " WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_cClFis))

                    IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ClfTmp")
                        IF USED("cursor_4c_ClfTmp")
                            SELECT cursor_4c_ClfTmp
                            GO TOP
                            IF !EOF()
                                loc_cDsClFis = TratarNulo(cursor_4c_ClfTmp.Descricaos, "")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- Entrega na tela ---------------------------------------
                SELECT cursor_4c_Itens
                loc_nResta = IIF(cursor_4c_Itens.qtbaixas = 0, ;
                                 TratarNulo(cursor_4c_Itens.qtds, 0), ;
                                 TratarNulo(cursor_4c_Itens.qtds, 0) - ;
                                 TratarNulo(cursor_4c_Itens.qtbaixas, 0))

                SELECT cursor_4c_ProTmp
                WITH loc_oPag
                    .txt_4c_PVens.Value   = TratarNulo(cursor_4c_ProTmp.PVens, 0)
                    .txt_4c_Peso.Value    = TratarNulo(cursor_4c_ProTmp.PesoMs, 0)
                    .txt_4c_GVendas.Value = ALLTRIM(TratarNulo(cursor_4c_ProTmp.Colecoes, "")) + ;
                                            IIF(EMPTY(loc_cDsCol), "", ;
                                                " - " + ALLTRIM(loc_cDsCol))
                    .obj_4c_GetObsPes.Value  = ALLTRIM(TratarNulo(cursor_4c_ProTmp.ObsPes, ""))
                    .obj_4c_GetObsPeds.Value = ALLTRIM(TratarNulo(cursor_4c_ProTmp.ObsPeds, ""))
                    .txt_4c_Conjunts.Value   = ALLTRIM(TratarNulo(cursor_4c_ProTmp.Conjunts, ""))
                    .txt_4c_GerDIfors.Value  = ALLTRIM(loc_cNomeFor)
                    .txt_4c_Saldo.Value      = loc_nSaldo
                    .txt_4c_Qtresta.Value    = loc_nResta
                    .cnt_4c_Reffs.txt_4c_Reffs.Value = ALLTRIM(loc_cReff)
                ENDWITH

                *-- Rotulo do desconto vira "Acrescimo" quando o valor eh
                *-- negativo (legado: If crTpmMvItn.ValDescs < 0)
                SELECT cursor_4c_Itens
                IF TratarNulo(cursor_4c_Itens.valdescs, 0) < 0
                    loc_oPag.lbl_4c_LblVDescs.Caption = "Valor Acr" + CHR(233) + "scimo"
                    loc_oPag.lbl_4c_LblPDescs.Caption = "%Acr" + CHR(233) + "scimo"
                ELSE
                    loc_oPag.lbl_4c_LblVDescs.Caption = "Valor Desconto"
                    loc_oPag.lbl_4c_LblPDescs.Caption = "% Desconto"
                ENDIF

                *-- Painel fiscal: os dois campos que nao sao coluna do item
                WITH loc_oFis
                    .txt_4c_FClFis.Value = ALLTRIM(loc_cClFis)
                    .txt_4c_FDlFis.Value = ALLTRIM(loc_cDsClFis)
                ENDWITH
            ELSE
                THIS.LimparPainelProduto()
            ENDIF

            THIS.FecharCursoresPainel()

        CATCH TO loc_oErro
            THIS.FecharCursoresPainel()
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar os dados do produto:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro AtualizarPainelProduto")
            loc_lProsseguir = .F.
        ENDTRY

        RETURN loc_lProsseguir
    ENDPROC

    *==========================================================================
    * ExecutarConsultaPainel - SQLEXEC das consultas de EXIBICAO do painel.
    * Nenhuma delas alimenta grade, entao o alias pode ser fechado e recriado
    * sem risco - o guard testa o BUFFERING antes do TABLEREVERT (regra #52).
    * Falha de consulta nao interrompe o preenchimento: o legado segue com o
    * campo em branco nos mesmos casos.
    *==========================================================================
    PROTECTED FUNCTION ExecutarConsultaPainel(par_cSQL, par_cCursor)
        LOCAL loc_nResultado, loc_lOk

        loc_lOk = .F.

        IF USED(par_cCursor)
            IF CURSORGETPROP("Buffering", par_cCursor) > 1
                TABLEREVERT(.T., par_cCursor)
            ENDIF
            USE IN (par_cCursor)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF loc_nResultado >= 0
            loc_lOk = .T.
        ELSE
            THIS.this_cMensagemErro = CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * FecharCursoresPainel - Fecha os cursores auxiliares do painel e devolve a
    * area de trabalho corrente para cursor_4c_Itens, que eh o alias da grade.
    *==========================================================================
    PROTECTED PROCEDURE FecharCursoresPainel()
        IF USED("cursor_4c_ProTmp")
            USE IN cursor_4c_ProTmp
        ENDIF
        IF USED("cursor_4c_FProTmp")
            USE IN cursor_4c_FProTmp
        ENDIF
        IF USED("cursor_4c_SaldoTmp")
            USE IN cursor_4c_SaldoTmp
        ENDIF
        IF USED("cursor_4c_ForTmp")
            USE IN cursor_4c_ForTmp
        ENDIF
        IF USED("cursor_4c_ClfTmp")
            USE IN cursor_4c_ClfTmp
        ENDIF

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparPainelProduto - Ramo ELSE do fwGrade.AfterRowColChange do legado:
    * linha sem produto deixa o painel em branco.
    *
    * So zera os campos de EXIBICAO (sem ControlSource). Os que estao ligados a
    * cursor_4c_Itens NAO entram aqui: escrever .Value neles gravaria no
    * cursor, apagando o item - eles ja mostram branco porque a linha esta
    * vazia.
    *==========================================================================
    PROCEDURE LimparPainelProduto()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        WITH loc_oPag
            .txt_4c_PVens.Value      = 0
            .txt_4c_Peso.Value       = 0
            .txt_4c_Saldo.Value      = 0
            .txt_4c_Qtresta.Value    = 0
            .txt_4c_GVendas.Value    = ""
            .txt_4c_Conjunts.Value   = ""
            .txt_4c_GerDIfors.Value  = ""
            .obj_4c_GetObsPes.Value  = ""
            .obj_4c_GetObsPeds.Value = ""
            .cnt_4c_Reffs.txt_4c_Reffs.Value = ""
            .img_4c_ImgProds.Picture = ""
            .img_4c_ImgProds.Visible = .F.
            .lbl_4c_LblVDescs.Caption = "Valor Desconto"
            .lbl_4c_LblPDescs.Caption = "% Desconto"
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page3.cnt_4c_Item
            .txt_4c_FClFis.Value = ""
            .txt_4c_FDlFis.Value = ""
        ENDWITH
    ENDPROC

    *==========================================================================
    * ObterContaFornecedor - Conta usada para achar a referencia do fornecedor
    * em SigPrFnc. Legado:
    *
    *   _Ct = Iif(crSigOpCdd.ChkIfors=1, TprMvCab.ContaOs,
    *             Iif(crSigOpCdd.ChkIfors=2, TprMvCab.Contads, ''))
    *
    * crSigOpCdd vive no data session do form PAI. Sem a configuracao, o
    * legado cai no terceiro ramo (string vazia) - e eh esse o default aqui:
    * a conta de ORIGEM quando ela existe, a de DESTINO como alternativa,
    * vazio quando nenhuma veio do pai.
    *==========================================================================
    PROTECTED FUNCTION ObterContaFornecedor()
        LOCAL loc_cConta

        loc_cConta = ""

        DO CASE
            CASE !EMPTY(THIS.this_cContaos)
                loc_cConta = ALLTRIM(THIS.this_cContaos)
            CASE !EMPTY(THIS.this_cContads)
                loc_cConta = ALLTRIM(THIS.this_cContads)
        ENDCASE

        RETURN loc_cConta
    ENDFUNC

    *==========================================================================
    * ObterGrupoEstoque - Chave EmpGruEsts char(23) usada no saldo (SigMvEst).
    * Legado: lcEge = TprMvCab.Emps + TprMvCab.GrupoOs + TprMvCab.ContaOs.
    *
    * Chave POSICIONAL: o padding faz parte dela (emps char(3) + grupo char(10)
    * + conta char(10) = 23 = a largura de EmpGruEsts). ALLTRIM nas partes
    * encurtaria a chave e o SELECT devolveria ZERO linha em silencio
    * (regra #42) - por isso PADR explicito em cada parte.
    *==========================================================================
    PROTECTED FUNCTION ObterGrupoEstoque()
        RETURN PADR(THIS.this_cEmps, 3) + ;
               PADR(THIS.this_cGrupoos, 10) + ;
               PADR(THIS.this_cContaos, 10)
    ENDFUNC

    *==========================================================================
    * BtnBuscarClick - Procura na grade (getBusca do legado, bloco "Procurar"
    * de Page1). NAO eh picker: ele POSICIONA a grade na linha cujo codigo de
    * barras (obj_4c_Opt_Busca = 1) ou cujo produto (= 2) casa com o digitado.
    *
    * Legado (getBusca.Valid + getBusca.LostFocus):
    *   lnOptBusca = This.parent.Opt_Busca.Value
    *   ThisForm.lProcuraCB = .T.
    *   If Not Empty(This.Value)
    *       If lnOptBusca = 1
    *           Select RecNo() As nRecNo From crTpmMvItn
    *               Where CodBarras = Int(Val(lnCBars)) Into Cursor csProcura
    *       Else
    *           Select RecNo() As nRecNo From crTpmMvItn
    *               Where Cpros = lcCpros Into Cursor csProcura
    *       Endif
    *       Select csProcura / Goto Top
    *       If Not Eof() / Select crTpmMvItn / Goto csProcura.nRecNo / Endif
    *   Endif
    *   (LostFocus) This.Value = [] / se lProcuraCB, foco na coluna Produto
    *
    * Ligado ao LostFocus do campo porque no legado a procura mora no Valid,
    * isto eh: dispara ao SAIR do campo (regra #47).
    *
    * PUBLIC: alvo de BINDEVENT e do harness de teste.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPag, loc_cDigitado, loc_nOpcao, loc_nBarra, loc_nRecno
        LOCAL loc_oErro

        loc_oPag     = THIS.pgf_4c_Paginas.Page1
        loc_cDigitado = ALLTRIM(loc_oPag.txt_4c_Busca.Value)
        loc_nOpcao    = loc_oPag.obj_4c_Opt_Busca.Value

        IF EMPTY(loc_cDigitado) OR !USED("cursor_4c_Itens")
            loc_oPag.txt_4c_Busca.Value = ""
            RETURN .F.
        ENDIF

        THIS.this_lProcuraCB = .T.
        loc_nRecno           = 0

        TRY
            SELECT cursor_4c_Itens

            IF loc_nOpcao = 1
                loc_nBarra = INT(VAL(loc_cDigitado))
                LOCATE FOR cursor_4c_Itens.codbarras = loc_nBarra
            ELSE
                LOCATE FOR ALLTRIM(cursor_4c_Itens.cpros) == loc_cDigitado
            ENDIF

            IF FOUND()
                loc_nRecno = RECNO("cursor_4c_Itens")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao procurar na grade:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro BtnBuscarClick")
        ENDTRY

        *-- LostFocus do legado: limpa o campo de procura sempre
        loc_oPag.txt_4c_Busca.Value = ""

        IF loc_nRecno > 0
            SELECT cursor_4c_Itens
            GO loc_nRecno
            THIS.AtualizarPainelProduto()
            THIS.RepintarGradeItens()
            SELECT cursor_4c_Itens
            GO loc_nRecno
            THIS.grd_4c_Dados.Refresh()
        ELSE
            MsgAviso("Item n" + CHR(227) + "o encontrado na grade.", "Procurar")
        ENDIF

        THIS.this_lProcuraCB = .F.

        RETURN (loc_nRecno > 0)
    ENDPROC

    *==========================================================================
    * TxtProdLostFocus - Conferencia por codigo (get_prod do legado).
    *
    * O legado resolve o valor digitado nesta ordem (get_prod.Valid):
    *   1. codigo de barras que JA esta numa linha da grade (Seek em
    *      crTpmMvItn por codbarras) - marca ThisForm.Barra e usa o produto
    *      daquela linha;
    *   2. etiqueta individual em SigOpEtq (com LEFT JOIN em SigOpEta para
    *      aceitar a barra antiga de uma etiqueta reemitida);
    *   3. SigCdPro.Cbars (codigo de barras do cadastro);
    *   4. SigCdPro.Ean13;
    *   5. o proprio valor como CPros.
    * Em qualquer caminho, achando o produto ele confere a unidade: se
    * SigCdUni.etiqs = 'S' recusa com "Codigo Errado - Etiqueta Especial !!".
    * Nao achando, avisa "Produto Nao Cadastrado!!!".
    *
    * fVerificarBarras() (SIGFUNCS.PRG) NAO foi portada. No legado ela apenas
    * ESCOLHE entre o ramo de barras e o ramo de EAN13 - e os dois ramos
    * terminam na mesma consulta a SigCdPro - entao tentar as duas resolucoes
    * em sequencia produz o mesmo resultado sem o wrapper (mesma decisao
    * documentada em FormSigPrEtq, regra #27 "no-op documentado").
    *
    * PUBLIC: alvo de BINDEVENT e do harness de teste.
    *==========================================================================
    PROCEDURE TxtProdLostFocus()
        LOCAL loc_oPag, loc_cDigitado, loc_cProduto

        loc_oPag      = THIS.pgf_4c_Paginas.Page1
        loc_cDigitado = ALLTRIM(loc_oPag.txt_4c__prod.Value)

        THIS.this_nBarra = 0

        IF EMPTY(loc_cDigitado)
            RETURN .F.
        ENDIF

        *-- Guarda de reentrancia: o aviso eh modal, tira o foco e faria o
        *-- proprio LostFocus disparar de novo (regra #37/#47).
        IF THIS.this_lEmLookup
            RETURN .F.
        ENDIF
        THIS.this_lEmLookup = .T.

        loc_cProduto = THIS.ResolverProdutoDigitado(loc_cDigitado)

        IF EMPTY(loc_cProduto)
            THIS.this_lValidOk = .F.
        ELSE
            THIS.this_lValidOk = .T.
            loc_oPag.txt_4c__prod.Value = loc_cProduto
            loc_oPag.txt_4c__prod.Refresh()

            THIS.CarregarImagemProduto(loc_cProduto)

            *-- Legado (get_prod.LostFocus): com ZerQtds = 2 e barra lida, a
            *-- quantidade 1 eh assumida e o fluxo segue para a conferencia.
            IF THIS.this_nZerQtds = 2 AND THIS.this_nBarra <> 0
                loc_oPag.txt_4c__qtd.Value = 1
            ENDIF
        ENDIF

        THIS.this_lEmLookup = .F.

        RETURN THIS.this_lValidOk
    ENDPROC

    *==========================================================================
    * ResolverProdutoDigitado - Resolucao em cascata do valor digitado em
    * get_prod (ver TxtProdLostFocus). Devolve o CPros resolvido, ou "" quando
    * nada casa - nesse caso o aviso ja foi exibido, como no legado.
    *==========================================================================
    PROTECTED FUNCTION ResolverProdutoDigitado(par_cDigitado)
        LOCAL loc_cProduto, loc_nBarra, loc_cSQL, loc_cUnidade, loc_nRecno
        LOCAL loc_oErro

        loc_cProduto = ""
        loc_nBarra   = INT(VAL(par_cDigitado))

        *-- 1. Barra que ja esta numa linha da grade -----------------------
        IF loc_nBarra <> 0 AND USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            loc_nRecno = RECNO()
            LOCATE FOR cursor_4c_Itens.codbarras = loc_nBarra
            IF FOUND()
                THIS.this_nBarra = loc_nBarra
                loc_cProduto     = ALLTRIM(cursor_4c_Itens.cpros)
            ELSE
                IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
                    GO loc_nRecno
                ENDIF
            ENDIF
        ENDIF

        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            IF EMPTY(loc_cProduto)
                MsgAviso("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
                         "o dispon" + CHR(237) + "vel.", "Aten" + CHR(231) + CHR(227) + "o!!!")
            ENDIF
            RETURN loc_cProduto
        ENDIF

        TRY
            *-- 2. Etiqueta individual (SigOpEtq + SigOpEta) ---------------
            IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
                loc_cSQL = "SELECT a.CPros, a.CBars, a.CodTams, a.Contas" + ;
                           " FROM SigOpEtq a" + ;
                           " LEFT JOIN SigOpEta b ON a.cpros = b.cpros" + ;
                           " AND a.cbars = b.cbars_new" + ;
                           " WHERE (a.CBars = " + FormatarNumeroSQL(loc_nBarra, 0) + ;
                           " OR b.cbars_old = " + FormatarNumeroSQL(loc_nBarra, 0) + ")"

                IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_EtqTmp")
                    IF USED("cursor_4c_EtqTmp")
                        SELECT cursor_4c_EtqTmp
                        GO TOP
                        IF !EOF()
                            THIS.this_nBarra = loc_nBarra
                            loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_EtqTmp.CPros, ""))
                        ENDIF
                        USE IN cursor_4c_EtqTmp
                    ENDIF
                ENDIF
            ENDIF

            *-- 3. Codigo de barras do cadastro (SigCdPro.Cbars) -----------
            IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
                loc_cSQL = "SELECT Cpros FROM SigCdPro" + ;
                           " WHERE Cbars = " + FormatarNumeroSQL(loc_nBarra, 0)

                IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_BarTmp")
                    IF USED("cursor_4c_BarTmp")
                        SELECT cursor_4c_BarTmp
                        GO TOP
                        IF !EOF()
                            THIS.this_nBarra = loc_nBarra
                            loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_BarTmp.Cpros, ""))
                        ENDIF
                        USE IN cursor_4c_BarTmp
                    ENDIF
                ENDIF
            ENDIF

            *-- 4. EAN13 do cadastro (SigCdPro.Ean13) ----------------------
            IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
                loc_cSQL = "SELECT Cpros FROM SigCdPro" + ;
                           " WHERE Ean13 = " + FormatarNumeroSQL(loc_nBarra, 0)

                IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_EanTmp")
                    IF USED("cursor_4c_EanTmp")
                        SELECT cursor_4c_EanTmp
                        GO TOP
                        IF !EOF()
                            THIS.this_nBarra = loc_nBarra
                            loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_EanTmp.Cpros, ""))
                        ENDIF
                        USE IN cursor_4c_EanTmp
                    ENDIF
                ENDIF
            ENDIF

            *-- 5. O proprio valor como CPros ------------------------------
            IF EMPTY(loc_cProduto)
                loc_cProduto = par_cDigitado
            ENDIF

            *-- Confere o cadastro do produto e a unidade ------------------
            loc_cSQL = "SELECT a.Cpros, a.Cunis, b.etiqs" + ;
                       " FROM SigCdPro a" + ;
                       " LEFT JOIN SigCdUni b ON a.Cunis = b.Cunis" + ;
                       " WHERE a.Cpros = " + EscaparSQL(loc_cProduto)

            IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ProdTmp")
                IF USED("cursor_4c_ProdTmp")
                    SELECT cursor_4c_ProdTmp
                    GO TOP
                    IF EOF()
                        MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!! " + ;
                                 CHR(13) + loc_cProduto, ;
                                 "Aten" + CHR(231) + CHR(227) + "o!!!")
                        loc_cProduto = ""
                    ELSE
                        loc_cUnidade = UPPER(ALLTRIM(TratarNulo(cursor_4c_ProdTmp.etiqs, "")))
                        *-- Legado: CrSigCdUni.etiqs = 'S' recusa a digitacao
                        *-- manual porque o produto exige etiqueta especial.
                        IF loc_cUnidade == "S"
                            MsgAviso("C" + CHR(243) + "digo Errado - Etiqueta Especial !!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o!!!")
                            loc_cProduto = ""
                        ELSE
                            loc_cProduto = ALLTRIM(TratarNulo(cursor_4c_ProdTmp.Cpros, loc_cProduto))
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_ProdTmp
                ENDIF
            ELSE
                loc_cProduto = ""
            ENDIF

        CATCH TO loc_oErro
            loc_cProduto = ""
            MsgErro("Erro ao resolver o produto digitado:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro ResolverProdutoDigitado")
        ENDTRY

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
        ENDIF

        RETURN loc_cProduto
    ENDFUNC

    *==========================================================================
    * CarregarImagemProduto - Foto do produto em img_4c_ImgProds. Legado
    * (get_prod.Valid e fwGrade.AfterRowColChange):
    *
    *   If CrSigCdOpe.Imagems = 1
    *       imgProds.Visible = .F. / imgProds.Picture = ''
    *       If Not Empty(CrTmpPro.FigJpgs) And Not Isnull(CrTmpPro.FigJpgs)
    *           lcFoto = Strconv(Strtran(... data:image/...;base64, ...),14)
    *           If (StrToFile(lcFoto, lcArquivo3) > 0)
    *               imgProds.Picture = (lcArquivo3) / imgProds.Visible = .T.
    *
    * STRCONV(...,14) decodifica Base64 UMA vez - decodificar duas vezes
    * devolve lixo e o LOADPICTURE/Picture falha sem mensagem.
    *==========================================================================
    PROTECTED PROCEDURE CarregarImagemProduto(par_cProduto)
        LOCAL loc_oImg, loc_cSQL, loc_cFig, loc_cFoto, loc_cArquivo, loc_oErro

        loc_oImg = THIS.pgf_4c_Paginas.Page1.img_4c_ImgProds

        loc_oImg.Visible = .F.
        loc_oImg.Picture = ""

        *-- Legado so carrega a foto quando a operacao pede (Imagems = 1)
        IF THIS.this_nImagems <> 1
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cProduto) <> "C" OR EMPTY(par_cProduto)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT FigJpgs FROM SigCdPro" + ;
                       " WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cProduto))

            IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_FigTmp")
                IF USED("cursor_4c_FigTmp")
                    SELECT cursor_4c_FigTmp
                    GO TOP
                    IF !EOF()
                        loc_cFig = TratarNulo(cursor_4c_FigTmp.FigJpgs, "")

                        IF !EMPTY(loc_cFig)
                            loc_cFig = STRTRAN(loc_cFig, "data:image/png;base64,",  "")
                            loc_cFig = STRTRAN(loc_cFig, "data:image/jpeg;base64,", "")
                            loc_cFig = STRTRAN(loc_cFig, "data:image/jpg;base64,",  "")

                            loc_cFoto    = STRCONV(loc_cFig, 14)
                            loc_cArquivo = ADDBS(SYS(2023)) + "SigOpPro_" + ;
                                           SYS(2015) + ".jpg"

                            IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
                                loc_oImg.Picture = loc_cArquivo
                                loc_oImg.Visible = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_FigTmp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            *-- Foto ausente ou corrompida nao impede a conferencia; o legado
            *-- tambem apenas deixa a area da imagem vazia.
            loc_oImg.Visible = .F.
            loc_oImg.Picture = ""
        ENDTRY

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
        ENDIF

        RETURN loc_oImg.Visible
    ENDPROC

    *==========================================================================
    * TxtQtdLostFocus - Confirma a linha conferida (get_qtd.LostFocus do
    * legado). O par Produto+Qtde desta pagina NAO inclui item novo: ele
    * CONFERE um item que ja esta na grade. Legado:
    *
    *   _Prod = Padr(get_prod.Value,14)
    *   Select crTpmMvItn / Set Order To cpros
    *   If Not IsEmpty(This.Value)
    *       If Empty(Barra) / Seek _Prod / ok = .T. / Endif
    *       If Not Eof()
    *           Do While Empty(Barra) And cpros = _Prod And ok And Not Eof()
    *               If qtds = This.Value And iconfs = .F. / ok = .F. / Exit
    *               Skip
    *           Enddo
    *           If ok / Messagebox('Quantidade Errada !!') / limpa campos
    *           Else  / Replace iconfs With .T. / Refresh / limpa / foco grade
    *       Else / Messagebox('Item nao encontrado !!') / limpa campos
    *       Endif
    *       ... Skip -1 / fwgrade.Refresh / get_prod.SetFocus / Barra = 0
    *   Endif
    *
    * PUBLIC: alvo de BINDEVENT e do harness de teste.
    *==========================================================================
    PROCEDURE TxtQtdLostFocus()
        LOCAL loc_oPag, loc_cProduto, loc_nQtde, loc_lAchouLinha, loc_lConfere
        LOCAL loc_nRecnoAchado, loc_oErro

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_nQtde    = loc_oPag.txt_4c__qtd.Value
        loc_cProduto = PADR(ALLTRIM(loc_oPag.txt_4c__prod.Value), 14)

        IF VARTYPE(loc_nQtde) <> "N" OR loc_nQtde = 0
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        IF THIS.this_lEmLookup
            RETURN .F.
        ENDIF
        THIS.this_lEmLookup = .T.

        loc_lAchouLinha = .F.
        loc_lConfere    = .F.
        loc_nRecnoAchado = 0

        TRY
            SELECT cursor_4c_Itens
            SET ORDER TO
            GO TOP

            *-- Procura a linha ainda nao conferida cuja quantidade bate.
            *-- Com barra lida (this_nBarra) o legado nao exige casar o
            *-- produto: a barra ja identificou a linha.
            SCAN
                IF THIS.this_nBarra <> 0
                    IF cursor_4c_Itens.codbarras <> THIS.this_nBarra
                        LOOP
                    ENDIF
                ELSE
                    IF PADR(cursor_4c_Itens.cpros, 14) <> loc_cProduto
                        LOOP
                    ENDIF
                ENDIF

                loc_lAchouLinha = .T.

                IF cursor_4c_Itens.qtds = loc_nQtde AND !cursor_4c_Itens.iconfs
                    loc_lConfere     = .T.
                    loc_nRecnoAchado = RECNO()
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lConfere
                GO loc_nRecnoAchado
                REPLACE iconfs WITH .T. IN cursor_4c_Itens
            ENDIF

            SET ORDER TO citens

        CATCH TO loc_oErro
            MsgErro("Erro ao conferir o item:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro TxtQtdLostFocus")
        ENDTRY

        DO CASE
            CASE loc_lConfere
                THIS.RepintarGradeItens()
                IF loc_nRecnoAchado > 0
                    SELECT cursor_4c_Itens
                    GO loc_nRecnoAchado
                ENDIF
                THIS.AtualizarPainelProduto()
            CASE loc_lAchouLinha
                MsgAviso("Quantidade Errada !!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            OTHERWISE
                MsgAviso("Item n" + CHR(227) + "o encontrado !!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
        ENDCASE

        *-- Em TODOS os caminhos o legado limpa os dois campos e devolve o
        *-- foco ao codigo, pronto para a leitura seguinte.
        THIS.this_nBarra            = 0
        THIS.this_lEmLookup         = .F.

        IF loc_oPag.txt_4c__prod.Visible AND loc_oPag.txt_4c__prod.Enabled
            loc_oPag.txt_4c__prod.SetFocus()
        ENDIF

        RETURN loc_lConfere
    ENDPROC

    *==========================================================================
    * AbrirLookupCanonico - Padrao canonico do projeto (FormBuscaAuxiliar,
    * regra #37) para os lookups simples de codigo/descricao do painel (Cor,
    * Tamanho): o Init do FormBuscaAuxiliar ja tenta o match exato pelo valor
    * digitado e, nao resolvendo, mostra o Show(); so sob a guarda
    * this_lSelecionou o valor escolhido volta para o controle de codigo (e,
    * quando informado, para o de descricao).
    *
    * par_cTabela            - tabela de origem (SigCdCor, SigCdTam, ...)
    * par_cCampoCodigo       - coluna do codigo (ex.: "Cods")
    * par_cCampoDescricao    - coluna da descricao (ex.: "Descs")
    * par_cTitulo            - titulo do dialogo
    * par_cValorAtual        - valor digitado, usado no match exato do Init
    * par_oControleCodigo    - TextBox que recebe o codigo escolhido
    * par_oControleDescricao - TextBox que recebe a descricao escolhida, ou
    *                          .NULL. quando nao ha controle de descricao
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupCanonico(par_cTabela, par_cCampoCodigo, ;
                                            par_cCampoDescricao, par_cTitulo, ;
                                            par_cValorAtual, par_oControleCodigo, ;
                                            par_oControleDescricao)
        LOCAL loc_oBusca, loc_cCursor

        IF VARTYPE(par_oControleCodigo) <> "O"
            RETURN .F.
        ENDIF

        loc_cCursor = "cursor_4c_BuscaCanonico"

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, par_cTabela, ;
                                   loc_cCursor, par_cCampoCodigo, par_cValorAtual, ;
                                   par_cTitulo, .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna(par_cCampoCodigo, "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna(par_cCampoDescricao, "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                SELECT (loc_cCursor)
                par_oControleCodigo.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoCodigo))

                IF VARTYPE(par_oControleDescricao) = "O"
                    par_oControleDescricao.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoDescricao))
                ENDIF
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarCodCorLostFocus - Cor do item (getCodCors.Valid do legado, que
    * abre fwbuscaext sobre SigCdCor por 'Cods'). Aqui o browse eh o
    * FormBuscaAuxiliar via AbrirLookupCanonico (padrao canonico do projeto).
    *
    * O valor escolhido volta para o proprio TextBox, que tem ControlSource em
    * cursor_4c_Itens.codcors - entao ele grava na linha corrente, igual ao
    * "This.Value = crListaRemota.Cods" do legado.
    *
    * PUBLIC: alvo de BINDEVENT.
    *==========================================================================
    PROCEDURE ValidarCodCorLostFocus()
        LOCAL loc_oPag, loc_cValor

        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodCors.Value))

        *-- Legado: "If !Empty(lcCodCors)" - vazio nao abre browse nenhum
        IF EMPTY(loc_cValor)
            RETURN .F.
        ENDIF

        *-- Guarda de valor-nao-mudou: LostFocus dispara SEMPRE, mas o Valid
        *-- do legado so dispara quando o valor MUDA.
        IF loc_cValor == THIS.this_cUltimoValidarCodCorLostFocusValidado
            RETURN .T.
        ENDIF

        IF THIS.this_lEmLookup
            RETURN .F.
        ENDIF
        THIS.this_lEmLookup = .T.

        THIS.AbrirLookupCanonico("SigCdCor", "Cods", "Descs", ;
                                 "Sele" + CHR(231) + CHR(227) + "o de Cor", ;
                                 loc_cValor, loc_oPag.txt_4c_CodCors, .NULL.)

        THIS.this_cUltimoValidarCodCorLostFocusValidado = ;
            ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodCors.Value))

        THIS.this_lEmLookup = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarCodTamLostFocus - Tamanho do item (getCodTams.Valid do legado,
    * fwbuscaext sobre SigCdTam por 'Cods'). Mesmo desenho de
    * ValidarCodCorLostFocus.
    *==========================================================================
    PROCEDURE ValidarCodTamLostFocus()
        LOCAL loc_oPag, loc_cValor

        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodTams.Value))

        IF EMPTY(loc_cValor)
            RETURN .F.
        ENDIF

        *-- Guarda de valor-nao-mudou: LostFocus dispara SEMPRE, mas o Valid
        *-- do legado so dispara quando o valor MUDA.
        IF loc_cValor == THIS.this_cUltimoValidarCodTamLostFocusValidado
            RETURN .T.
        ENDIF

        IF THIS.this_lEmLookup
            RETURN .F.
        ENDIF
        THIS.this_lEmLookup = .T.

        THIS.AbrirLookupCanonico("SigCdTam", "Cods", "Descs", ;
                                 "Sele" + CHR(231) + CHR(227) + "o de Tamanho", ;
                                 loc_cValor, loc_oPag.txt_4c_CodTams, .NULL.)

        THIS.this_cUltimoValidarCodTamLostFocusValidado = ;
            ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodTams.Value))

        THIS.this_lEmLookup = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarVDescsLostFocus - Desconto em VALOR (getVDescs.Valid do legado):
    *
    *   If !Empty(this.Value) And (This.Value # ThisForm.OldPreco)
    *       If this.Value > 0
    *           Replace Units With UnitOrigs - this.Value in crTpmMvItn
    *       Else
    *           Replace Units With UnitOrigs + this.Value in crTpmMvItn
    *       Endif
    *       ... Replace Utilizas ... / ThisForm.ParentForm.calc_valite()
    *
    * A formula eh TRANSCRITA, nao reescrita (regra #17): valor POSITIVO eh
    * desconto e SUBTRAI do unitario de origem; valor NEGATIVO eh acrescimo e
    * SOMA. Quem recalcula o total do item eh o Calc_ValIte do form pai, via
    * TotalizarLinha().
    *==========================================================================
    *==========================================================================
    * ValidarDocsLostFocus - Documento do item (getDocs.Valid do legado).
    *
    * Duas regras do legado, nesta ordem:
    *
    * 1. VAZIO: "If llNotasObrig Or crSigCdOpe.EditDocs = 5 / Messagebox
    *    ('Obrigatorio Informar Documento do Produto ' + CPros) / Return 0".
    *    llNotasObrig vem de Seek em csOpeAut (cursor de operacao automatica do
    *    form PAI); sem ele carregado o Seek do legado devolve .F. e a condicao
    *    fica so com EditDocs = 5 - mesmo comportamento aqui.
    *
    * 2. PREENCHIDO e crSigCdOpe.ValiNotas = 1: o documento tem de ser UNICO.
    *    a) "Select Emps, Dopes, Numes From SigMvItn Where Notas = '<valor>'" -
    *       achando o MESMO Dopes em OUTRA movimentacao (emps+dopes+numes
    *       diferente da corrente), recusa com "Documento ... Ja Existe !!";
    *    b) nao achando, conta no cursor local quantas linhas usam o mesmo
    *       documento - mais de uma recusa com "Documento ... Ja Lancado Nessa
    *       Operacao !!".
    *
    * 3. crSigOpCdc.OpVlUnis = 1 com produto 'C': o valor unitario do item vem
    *    do documento informado ("Replace Units With LocalEest.valos,
    *    Utilizas With 51"). A acumulacao das parcelas do legado grava no
    *    cursor xPar, que pertence ao form PAI: so roda quando o pai o
    *    entregou (USED("xPar")).
    *
    * O legado tambem normaliza o valor com Transf(Val(This.Value),"@L 999999")
    * - documento eh char(6) com zeros a esquerda.
    *
    * PUBLIC: alvo de BINDEVENT.
    *==========================================================================
    PROCEDURE ValidarDocsLostFocus()
        LOCAL loc_oPag, loc_cNotas, loc_cSQL, loc_cChave, loc_nIguais
        LOCAL loc_lOk, loc_nRecno, loc_oErro

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_lOk  = .T.

        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            RETURN .T.
        ENDIF

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            RETURN .T.
        ENDIF

        loc_cNotas = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_Docs.Value))

        *-- 1. Documento vazio -------------------------------------------
        IF EMPTY(loc_cNotas)
            IF THIS.this_nEditDocs = 5
                MsgAviso("Obrigat" + CHR(243) + "rio Informar Documento do Produto " + ;
                         ALLTRIM(cursor_4c_Itens.cpros), ;
                         "Documento Obrigat" + CHR(243) + "rio")
                loc_lOk = .F.
            ENDIF
            RETURN loc_lOk
        ENDIF

        *-- Normalizacao do legado: 6 posicoes com zeros a esquerda
        loc_cNotas = PADL(ALLTRIM(STR(INT(VAL(loc_cNotas)), 6)), 6, "0")
        loc_oPag.txt_4c_Docs.Value = loc_cNotas

        IF THIS.this_nValiNotas <> 1
            RETURN .T.
        ENDIF

        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            RETURN .T.
        ENDIF

        loc_cChave = THIS.ObterChaveMovimentacao()

        TRY
            *-- 2a. Mesmo documento em OUTRA movimentacao da mesma operacao
            loc_cSQL = "SELECT Emps, Dopes, Numes, empdopnums FROM SigMvItn" + ;
                       " WHERE Notas = " + EscaparSQL(loc_cNotas) + ;
                       " AND Dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20))

            IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_NotaTmp")
                IF USED("cursor_4c_NotaTmp")
                    SELECT cursor_4c_NotaTmp
                    SCAN
                        IF ALLTRIM(TratarNulo(cursor_4c_NotaTmp.empdopnums, "")) <> ;
                           ALLTRIM(loc_cChave)
                            MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + ;
                                     loc_cNotas + " J" + CHR(225) + " Existe !!", ;
                                     "Opera" + CHR(231) + CHR(227) + "o: " + ;
                                     ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Emps, "")) + "-" + ;
                                     ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Dopes, "")) + "-" + ;
                                     ALLTRIM(STR(TratarNulo(cursor_4c_NotaTmp.Numes, 0))))
                            loc_lOk = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                    USE IN cursor_4c_NotaTmp
                ENDIF
            ENDIF

            *-- 2b. Mesmo documento repetido DENTRO desta operacao
            IF loc_lOk
                SELECT cursor_4c_Itens
                loc_nRecno = RECNO()
                COUNT FOR ALLTRIM(cursor_4c_Itens.notas) == loc_cNotas TO loc_nIguais
                IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
                    GO loc_nRecno
                ENDIF

                IF loc_nIguais > 1
                    MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + loc_cNotas + ;
                             " J" + CHR(225) + " Lan" + CHR(231) + "ado Nessa Opera" + ;
                             CHR(231) + CHR(227) + "o !!", ;
                             "Opera" + CHR(231) + CHR(227) + "o: " + ALLTRIM(THIS.this_cDopes))
                    loc_lOk = .F.
                ENDIF
            ENDIF

            *-- 3. Valor unitario vindo do documento (produto 'C')
            IF loc_lOk AND THIS.this_nOpVlUnis = 1 AND ;
               PADR(cursor_4c_Itens.cpros, 14) == PADR("C", 14)
                THIS.AplicarValorDoDocumento(INT(VAL(loc_cNotas)))
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar o documento do produto:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro ValidarDocsLostFocus")
            loc_lOk = .F.
        ENDTRY

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * AplicarValorDoDocumento - Ramo "crSigOpCdc.OpVlUnis = 1" do
    * getDocs.Valid: o valor unitario do item 'C' vem do documento informado.
    *
    * Legado:
    *   lcSql = [Select a.Valos, a.Datas, a.EmpDopNums From SigMvCab a,
    *            SigCdOpe b, SigCdTom c Where a.Dopes = b.Dopes And
    *            b.TipoOps = c.Codigos And c.OpVlUnis = 1 And a.Numes = <n>
    *            Order by A.Datas]
    *   Select LocalEest / Go Bott
    *   If Reccount() > 0
    *       Replace Units With LocalEest.valos, Utilizas With 51 in crTpmMvItn
    *       If crSigCdOpe.parcs = 1 ... soma SigMvPar em xPar ... Replace Units
    *   ThisForm.Calc_ValIte()
    *
    * Utilizas = 51 eh a marca do legado para "preco travado pelo documento":
    * os guards de When de getVDescs/getPDescs e da coluna Valor testam
    * justamente esse valor.
    *
    * A acumulacao das parcelas grava no cursor xPar, que eh do form PAI; ela
    * so roda quando o pai entregou esse cursor.
    *==========================================================================
    PROTECTED PROCEDURE AplicarValorDoDocumento(par_nNumero)
        LOCAL loc_cSQL, loc_nValor, loc_cEdn, loc_nTotPar, loc_lAplicou

        loc_lAplicou = .F.

        IF VARTYPE(par_nNumero) <> "N" OR par_nNumero = 0
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT a.Valos, a.Datas, a.EmpDopNums" + ;
                   " FROM SigMvCab a, SigCdOpe b, SigCdTom c" + ;
                   " WHERE a.Dopes = b.Dopes" + ;
                   " AND b.TipoOps = c.Codigos" + ;
                   " AND c.OpVlUnis = 1" + ;
                   " AND a.Numes = " + FormatarNumeroSQL(par_nNumero, 0) + ;
                   " ORDER BY a.Datas"

        IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_DocValTmp")
            IF USED("cursor_4c_DocValTmp")
                SELECT cursor_4c_DocValTmp
                GO BOTTOM
                IF RECCOUNT("cursor_4c_DocValTmp") > 0
                    loc_nValor = TratarNulo(cursor_4c_DocValTmp.Valos, 0)
                    loc_cEdn   = ALLTRIM(TratarNulo(cursor_4c_DocValTmp.EmpDopNums, ""))

                    SELECT cursor_4c_Itens
                    REPLACE units    WITH loc_nValor, ;
                            utilizas WITH 51 IN cursor_4c_Itens

                    *-- Parcelas: o cursor de destino (xPar) pertence ao form
                    *-- PAI; sem ele entregue, o legado tambem nao soma nada.
                    IF THIS.this_nParcs = 1 AND USED("xPar") AND !EMPTY(loc_cEdn)
                        loc_cSQL = "SELECT Valos FROM SigMvPar" + ;
                                   " WHERE EmpdopNums = " + EscaparSQL(loc_cEdn) + ;
                                   " AND fPags = " + EscaparSQL("P")

                        IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ParTmp")
                            loc_nTotPar = 0
                            IF USED("cursor_4c_ParTmp")
                                SELECT cursor_4c_ParTmp
                                SCAN
                                    SELECT xPar
                                    APPEND BLANK
                                    REPLACE Valos WITH TratarNulo(cursor_4c_ParTmp.Valos, 0) IN xPar
                                    loc_nTotPar = loc_nTotPar + TratarNulo(cursor_4c_ParTmp.Valos, 0)
                                    SELECT cursor_4c_ParTmp
                                ENDSCAN
                                USE IN cursor_4c_ParTmp
                            ENDIF

                            SELECT cursor_4c_Itens
                            REPLACE units WITH loc_nTotPar IN cursor_4c_Itens
                        ENDIF
                    ENDIF

                    loc_lAplicou = .T.
                ENDIF
                IF USED("cursor_4c_DocValTmp")
                    USE IN cursor_4c_DocValTmp
                ENDIF
            ENDIF
        ENDIF

        IF loc_lAplicou
            THIS.TotalizarLinha(.F.)
        ENDIF

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * ValidarLotesLostFocus - Numero do lote (getLotes.Valid do legado).
    *
    * O numero digitado eh COMPOSTO: os 4 primeiros digitos sao o nDopes da
    * operacao que gerou o lote e os 6 ultimos o numero da movimentacao.
    * Legado:
    *
    *   ndope = Val( Left( Str( This.Value, 10 ), 4) )
    *   Cursorquery('SigCdOpe','crSigCdOpe','nDopes',ndope) / Dope = Dopes
    *   If crSigCdOpe.Ctrllotes # 1
    *       Messagebox('Operacao '+Dope+' nao Configurada para gerar No. Lote !!')
    *   Nume = Val( Right( Str( This.Value, 10), 6 ) )
    *   Select EmpDopNums from SigMvCab Where Numes = <Nume> And Dopes = '<Dope>'
    *   If ... Reccount = 0 / Messagebox('Lote N '+...+' nao Existe !!')
    *
    * O "set decimals to 0" do legado existe para o STR nao trazer casas
    * decimais; aqui o INT() sobre o valor digitado faz o mesmo sem mexer num
    * SET global.
    *
    * PUBLIC: alvo de BINDEVENT.
    *==========================================================================
    PROCEDURE ValidarLotesLostFocus()
        LOCAL loc_oPag, loc_nLote, loc_cLote, loc_nDope, loc_nNume
        LOCAL loc_cDope, loc_nCtrl, loc_cSQL, loc_lOk, loc_oErro

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_lOk  = .T.

        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            RETURN .T.
        ENDIF

        loc_nLote = loc_oPag.txt_4c_Lotes.Value

        IF VARTYPE(loc_nLote) <> "N" OR loc_nLote = 0
            RETURN .T.
        ENDIF

        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            RETURN .T.
        ENDIF

        *-- 10 posicoes: 4 da operacao + 6 do numero da movimentacao
        loc_cLote = PADL(ALLTRIM(STR(INT(loc_nLote), 10)), 10, "0")
        loc_nDope = VAL(LEFT(loc_cLote, 4))
        loc_nNume = VAL(RIGHT(loc_cLote, 6))
        loc_cDope = ""
        loc_nCtrl = 0

        TRY
            loc_cSQL = "SELECT Dopes, Ctrllotes FROM SigCdOpe" + ;
                       " WHERE nDopes = " + FormatarNumeroSQL(loc_nDope, 0)

            IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_OpeLoteTmp")
                IF USED("cursor_4c_OpeLoteTmp")
                    SELECT cursor_4c_OpeLoteTmp
                    GO TOP
                    IF !EOF()
                        loc_cDope = ALLTRIM(TratarNulo(cursor_4c_OpeLoteTmp.Dopes, ""))
                        loc_nCtrl = TratarNulo(cursor_4c_OpeLoteTmp.Ctrllotes, 0)
                    ENDIF
                    USE IN cursor_4c_OpeLoteTmp
                ENDIF
            ENDIF

            IF loc_nCtrl <> 1
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + loc_cDope + ;
                         " n" + CHR(227) + "o Configurada para gerar No. Lote !!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_lOk = .F.
            ENDIF

            IF loc_lOk
                loc_cSQL = "SELECT EmpDopNums FROM SigMvCab" + ;
                           " WHERE Numes = " + FormatarNumeroSQL(loc_nNume, 0) + ;
                           " AND Dopes = " + EscaparSQL(PADR(loc_cDope, 20))

                IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_LoteTmp")
                    IF !USED("cursor_4c_LoteTmp") OR RECCOUNT("cursor_4c_LoteTmp") = 0
                        MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
                                 " n" + CHR(227) + "o Existe !!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o!!!")
                        loc_lOk = .F.
                    ENDIF
                    IF USED("cursor_4c_LoteTmp")
                        USE IN cursor_4c_LoteTmp
                    ENDIF
                ELSE
                    MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
                             " n" + CHR(227) + "o Existe !!", ;
                             "Aten" + CHR(231) + CHR(227) + "o!!!")
                    loc_lOk = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar o n" + CHR(250) + "mero do lote:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro ValidarLotesLostFocus")
            loc_lOk = .F.
        ENDTRY

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
        ENDIF

        RETURN loc_lOk
    ENDPROC

    PROCEDURE ValidarVDescsLostFocus()
        LOCAL loc_oPag, loc_nValor, loc_nOrig, loc_oErro

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            RETURN .F.
        ENDIF

        loc_nValor = loc_oPag.txt_4c_VDescs.Value

        IF VARTYPE(loc_nValor) <> "N" OR loc_nValor = 0
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Itens
            loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)

            IF loc_nOrig = 0
                loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
                REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
            ENDIF

            IF loc_nValor > 0
                REPLACE units WITH loc_nOrig - loc_nValor IN cursor_4c_Itens
            ELSE
                REPLACE units WITH loc_nOrig + loc_nValor IN cursor_4c_Itens
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao aplicar o desconto:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro ValidarVDescsLostFocus")
        ENDTRY

        THIS.TotalizarLinha(.F.)
        THIS.AtualizarPainelProduto()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarPDescsLostFocus - Desconto em PERCENTUAL (getPDescs.Valid do
    * legado):
    *
    *   If this.Value > 0
    *       Replace Units With UnitOrigs - ((Abs(this.Value) * UnitOrigs) / 100)
    *   Else
    *       Replace Units With UnitOrigs + ((Abs(this.Value) * UnitOrigs) / 100)
    *
    * Formula TRANSCRITA do legado, com o ABS e a divisao por 100 na mesma
    * ordem (regra #17).
    *==========================================================================
    PROCEDURE ValidarPDescsLostFocus()
        LOCAL loc_oPag, loc_nPerc, loc_nOrig, loc_oErro

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            RETURN .F.
        ENDIF

        loc_nPerc = loc_oPag.txt_4c_PDescs.Value

        IF VARTYPE(loc_nPerc) <> "N" OR loc_nPerc = 0
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Itens
            loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)

            IF loc_nOrig = 0
                loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
                REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
            ENDIF

            IF loc_nPerc > 0
                REPLACE units WITH loc_nOrig - ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
                        IN cursor_4c_Itens
            ELSE
                REPLACE units WITH loc_nOrig + ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
                        IN cursor_4c_Itens
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao aplicar o desconto percentual:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro ValidarPDescsLostFocus")
        ENDTRY

        THIS.TotalizarLinha(.F.)
        THIS.AtualizarPainelProduto()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObsAbrirPainelClick - Abre o painel flutuante da observacao do item
    * (getObs.Click do legado):
    *
    *   cntObs.Visible = .t. / cntObs.ZOrder(0) / cntObs.getObs.SetFocus
    *
    * O ZOrder(0) eh obrigatorio: o painel eh criado ANTES dos outros
    * controles da pagina e sem ele ficaria POR BAIXO deles.
    *
    * Legado (getObs.When): so abre em INSERIR/ALTERAR e com produto na linha.
    *==========================================================================
    PROCEDURE ObsAbrirPainelClick()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
            RETURN .F.
        ENDIF

        IF !THIS.TemProdutoSelecionado()
            RETURN .F.
        ENDIF

        THIS.this_lWhenGetObs = .T.

        loc_oPag.cnt_4c_Obs.Visible = .T.
        loc_oPag.cnt_4c_Obs.ZOrder(0)
        loc_oPag.cnt_4c_Obs.obj_4c_GetObs.SetFocus()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObsFecharPainelLostFocus - Fecha o painel flutuante (cntObs.getObs.
    * LostFocus do legado: "cntObs.Visible = .f. / getObs.SetFocus").
    *
    * Reproduz tambem o getObs.Valid do legado, que recusa sair com a
    * observacao em branco quando a operacao a torna obrigatoria
    * (crSigCdOpe.ObsItems = 1).
    *==========================================================================
    PROCEDURE ObsFecharPainelLostFocus()
        LOCAL loc_oPag, loc_cObs

        *-- Reentrancia: ja estamos fechando o painel (o SetFocus la embaixo
        *-- redispara este mesmo LostFocus).
        IF THIS.this_lFechandoObs
            RETURN .F.
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cObs = ALLTRIM(TratarNulo(loc_oPag.cnt_4c_Obs.obj_4c_GetObs.Value, ""))

        IF THIS.this_lWhenGetObs AND EMPTY(loc_cObs) AND THIS.this_nObsItems = 1
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Preenchimento da " + ;
                     "Observa" + CHR(231) + CHR(227) + "o Para Cada Produto ... ", ;
                     "Observa" + CHR(231) + CHR(227) + "o do Item Obrigat" + ;
                     CHR(243) + "ria")
            RETURN .F.
        ENDIF

        THIS.this_lWhenGetObs = .F.

        loc_oPag.cnt_4c_Obs.Visible = .F.

        *-- Tirar o foco do EditBox do painel dispara o LostFocus dele, que eh
        *-- ESTE metodo: sem a guarda a chamada se aninha indefinidamente.
        IF loc_oPag.obj_4c_GetObs.Visible AND loc_oPag.obj_4c_GetObs.Enabled
            THIS.this_lFechandoObs = .T.
            loc_oPag.obj_4c_GetObs.SetFocus()
            THIS.this_lFechandoObs = .F.
        ENDIF

        THIS.RepintarGradeItens()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ImgProdsDblClick - Zoom da foto do produto (imgProds.DblClick do legado,
    * cuja dica de uso esta no proprio ToolTipText: "[Duplo Click Para Zoom]").
    * O legado grava a foto em arquivo temporario e abre a tela de zoom; aqui o
    * arquivo ja foi gravado por CarregarImagemProduto e eh ele que vai para o
    * visualizador de imagem do sistema operacional.
    *==========================================================================
    PROCEDURE ImgProdsDblClick()
        LOCAL loc_oImg, loc_cArquivo, loc_oErro

        loc_oImg     = THIS.pgf_4c_Paginas.Page1.img_4c_ImgProds
        loc_cArquivo = ALLTRIM(loc_oImg.Picture)

        IF EMPTY(loc_cArquivo) OR !FILE(loc_cArquivo)
            MsgAviso("Produto sem imagem cadastrada.", "Imagem do Produto")
            RETURN .F.
        ENDIF

        TRY
            RUN /N2 EXPLORER.EXE (loc_cArquivo)
        CATCH TO loc_oErro
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a " + ;
                     "imagem do produto.", "Imagem do Produto")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * KeyPress - Teclas de atalho da tela. Legado (SIGOPPRO.KeyPress):
    *
    *   LPARAMETERS nKeyCode, nShiftAltCtrl
    *   If nKeyCode = -4 And ThisForm.btnPBuscas.Enabled    && F5
    *       NoDefault
    *       ThisForm.btnPBuscas.Click()
    *   EndIf
    *
    * KeyPreview = .T. na classe faz o evento chegar aqui antes do controle
    * com foco. -4 eh o codigo do F5 em KeyPress de FORM.
    *==========================================================================
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = -4
            IF THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPBuscas.Enabled
                NODEFAULT
                THIS.BtnPBuscasClick()
                RETURN
            ENDIF
        ENDIF

        DODEFAULT(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Liga/desliga os campos digitaveis conforme o modo.
    *
    * No legado cada campo decide sozinho pelo When(): a maioria retorna .F.
    * (exibicao pura) e os digitaveis retornam
    * "InList(Op_Escolha,'INSERIR','ALTERAR')" combinado com a configuracao da
    * operacao - getDPros exige AltDescs = 1 (ou descricao comecando por "."),
    * getDocs exige EditDocs, getLotes exige Ctrllotes = 2, getVDescs/getPDescs
    * exigem Confes # 1. A pagina Fiscal inteira so eh habilitada quando o
    * usuario pede alteracao de impostos (btnAltImps.Click faz
    * "pgFiscs.Enabled = .t.").
    *
    * Os campos de EXIBICAO ficam de fora: eles nasceram ReadOnly = .T. e
    * continuam assim em qualquer modo, como no legado.
    *
    * PUBLIC: o form pai troca o modo de fora (Op_Escolha vem dele).
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lEdita, loc_oPag

        loc_lEdita = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, ;
                         INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))

        *-- Page1 (pgProds) ------------------------------------------------
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH loc_oPag
            *-- getDPros: legado exige AltDescs = 1 OU descricao iniciada
            *-- por "." (produto de descricao livre)
            .txt_4c_DPros.ReadOnly = !(loc_lEdita AND THIS.PodeEditarDescricao())

            .txt_4c_Docs.ReadOnly   = !loc_lEdita
            .txt_4c_Lotes.ReadOnly  = !loc_lEdita
            .txt_4c_VDescs.ReadOnly = !loc_lEdita
            .txt_4c_PDescs.ReadOnly = !loc_lEdita
            .txt_4c_MoeVs.ReadOnly  = !loc_lEdita
            .txt_4c_CodCors.ReadOnly = !loc_lEdita
            .txt_4c_CodTams.ReadOnly = !loc_lEdita

            .obj_4c_GetObs.ReadOnly              = !loc_lEdita
            .cnt_4c_Obs.obj_4c_GetObs.ReadOnly   = !loc_lEdita

            *-- Conferencia por codigo: o legado habilita o campo de
            *-- quantidade apenas com o codigo preenchido (get_qtd.When =
            *-- "Return (Not Empty(Get_prod.Value))")
            .txt_4c__prod.Enabled = loc_lEdita
            .txt_4c__qtd.Enabled  = loc_lEdita AND ;
                                    !EMPTY(ALLTRIM(.txt_4c__prod.Value))

            *-- A procura na grade funciona em qualquer modo (getBusca.When =
            *-- "Return .t." no legado)
            .txt_4c_Busca.Enabled = .T.
        ENDWITH

        *-- Page3 (pgFiscs): habilitada so em alteracao de impostos --------
        THIS.pgf_4c_Paginas.Page3.Enabled = loc_lEdita AND ;
                                            (THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 1)

        WITH THIS.pgf_4c_Paginas.Page3.cnt_4c_Item
            .txt_4c_NAdis.ReadOnly   = !loc_lEdita
            .txt_4c_NIAdis.ReadOnly  = !loc_lEdita
            .txt_4c_Codfabs.ReadOnly = !loc_lEdita
        ENDWITH

        *-- Page2 (pgContas): no legado so getLPrecos eh editavel; os espelhos
        *-- de Origem/Destino/Empresa tem When() = Return .F.
        WITH THIS.pgf_4c_Paginas.Page2
            .cnt_4c_LPrecos.txt_4c_LPrecos.ReadOnly = !loc_lEdita
            .cnt_4c_TabDs.txt_4c_TabDes.ReadOnly    = !loc_lEdita
            .cnt_4c_TpFats.txt_4c_TpFats.ReadOnly   = !loc_lEdita
            .cnt_4c_Moedas.txt_4c_Moedas.ReadOnly   = !loc_lEdita
        ENDWITH

        RETURN loc_lEdita
    ENDPROC

    *==========================================================================
    * PodeEditarDescricao - Guard do getDPros.When do legado:
    *
    *   Return( Inlist(Op_Escolha,'INSERIR','ALTERAR') And
    *           ( crSigCdOpe.AltDescs = 1 Or Left(crTpmMvItn.Dpros,1) = '.' )
    *           And Not IsEmpty(crTpmMvItn.Cpros) )
    *
    * A parte de modo fica em HabilitarCampos; aqui ficam as duas condicoes
    * restantes.
    *==========================================================================
    PROTECTED FUNCTION PodeEditarDescricao()
        LOCAL loc_lPode

        loc_lPode = .F.

        IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
            IF !EMPTY(cursor_4c_Itens.cpros)
                loc_lPode = (THIS.this_nAltDescs = 1) OR ;
                            (LEFT(cursor_4c_Itens.dpros, 1) == ".")
            ENDIF
        ENDIF

        RETURN loc_lPode
    ENDFUNC

    *==========================================================================
    * LimparCampos - Devolve a tela ao estado de linha sem produto: limpa os
    * campos de conferencia e de procura (que nao sao coluna do item) e manda
    * o painel de exibicao para o branco.
    *
    * NAO toca nos campos com ControlSource: escrever .Value neles gravaria no
    * cursor e APAGARIA o item da linha corrente. Quem limpa a LINHA eh
    * LimparLinhaGrade().
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        WITH loc_oPag
            .txt_4c__prod.Value  = ""
            .txt_4c__qtd.Value   = 0
            .txt_4c_Busca.Value  = ""
            .obj_4c_Opt_Busca.Value = 1
            .cnt_4c_Obs.Visible  = .F.
        ENDWITH

        THIS.this_nBarra      = 0
        THIS.this_lProcuraCB  = .F.
        THIS.this_lWhenGetObs = .F.
        THIS.this_cAntCPro    = ""

        THIS.LimparPainelProduto()
    ENDPROC

    *==========================================================================
    * CarregarLista - FUNIL de (re)carga da lista desta tela. A "lista" do
    * SIGOPPRO eh a grade de itens da movimentacao (fwGrade no legado): nao ha
    * Page1=Lista / Page2=Dados como nos cadastros CRUD.
    *
    * Delega a CarregarDados(), que eh quem consulta o BO, recarrega
    * cursor_4c_Itens por ZAP/APPEND (sem derrubar o binding da grade),
    * entrega a linha de digitacao em INSERIR/ALTERAR, repinta e reajusta os
    * botoes. Depois disso atualiza o painel do item corrente.
    *
    * PUBLIC: o harness de teste e o form pai chamam THIS.CarregarLista() de
    * FORA da classe; PROTECTED aqui estouraria em runtime (regra #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.CarregarDados()

        THIS.AtualizarPainelProduto()
        THIS.HabilitarCampos(INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere a LINHA CORRENTE da grade para as properties do
    * sigopproBO, cobrindo TODAS as colunas de SigMvItn que o cursor carrega.
    *
    * O painel de Page1/Page3 eh uma VISTA da linha: os campos digitaveis tem
    * ControlSource sobre cursor_4c_Itens, logo o que o usuario digitou ja esta
    * no cursor quando este metodo roda - ler do cursor eh ler da tela, e eh
    * tambem o que o legado faz (ele grava o cursor inteiro com TABLEUPDATE).
    *
    * Os campos de EXIBICAO (preco atual, saldo, resta, referencia, grupo de
    * venda, peso medio, classificacao fiscal) NAO entram: nao sao coluna de
    * SigMvItn - vem de SigCdPro/SigMvEst/SigCdClf e seriam gravados em
    * coluna que nao existe.
    *
    * Devolve .T. quando havia linha para transferir.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lOk, loc_oBO, loc_oErro

        loc_lOk = .F.

        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            *-- CarregarDoCursor do BO ja mapeia as 120+ colunas de SigMvItn
            *-- uma a uma, com TratarNulo e com o teste de VARTYPE nos campos
            *-- bit. Reescrever a lista aqui criaria duas versoes do mesmo
            *-- mapeamento, que divergem na primeira coluna nova.
            SELECT cursor_4c_Itens
            loc_lOk = loc_oBO.CarregarDoCursor("cursor_4c_Itens")

            IF loc_lOk
                *-- Identificacao da movimentacao: no legado vem de TprMvCab
                *-- (cursor do form pai) e nao da linha do item.
                loc_oBO.this_cEmpdopnums = THIS.ObterChaveMovimentacao()

                IF EMPTY(loc_oBO.this_cEmps)
                    loc_oBO.this_cEmps = PADR(THIS.this_cEmps, 3)
                ENDIF
                IF EMPTY(loc_oBO.this_cDopes)
                    loc_oBO.this_cDopes = PADR(THIS.this_cDopes, 20)
                ENDIF
                IF loc_oBO.this_nNumes = 0
                    loc_oBO.this_nNumes = THIS.this_nNumes
                ENDIF

                *-- Usuario que liberou o preco (ThisForm.usulibs do legado)
                IF EMPTY(loc_oBO.this_cUsulibs) AND TYPE("gc_4c_UsuarioLogado") = "C"
                    loc_oBO.this_cUsulibs = PADR(gc_4c_UsuarioLogado, 10)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lOk = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao transferir o item para o objeto de neg" + CHR(243) + ;
                    "cio:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro FormParaBO")
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * BOParaForm - Caminho inverso de FormParaBO: leva as properties do
    * sigopproBO para a linha da grade e, por consequencia, para o painel de
    * Page1/Page3 (que esta ligado ao cursor por ControlSource).
    *
    * Posiciona PRIMEIRO na linha do item que esta no BO (citens): sem isso a
    * gravacao cairia na linha errada e sobrescreveria outro item - o cursor
    * nao acompanha o BO sozinho.
    *
    * Fecha atualizando o painel de exibicao e repintando a grade: popular o
    * cursor NAO repinta a grade (regra #21).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_lOk, loc_oErro

        loc_lOk = .F.

        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            SELECT cursor_4c_Itens

            *-- Casa a linha pelo numero do item; sem numero, usa a corrente.
            IF loc_oBO.this_nCitens <> 0
                LOCATE FOR cursor_4c_Itens.citens = loc_oBO.this_nCitens
                IF !FOUND()
                    GO TOP
                ENDIF
            ENDIF

            IF !EOF("cursor_4c_Itens")
                REPLACE cidchaves  WITH loc_oBO.this_cCidchaves, ;
                        citens     WITH loc_oBO.this_nCitens, ;
                        citem2     WITH loc_oBO.this_nCitem2, ;
                        cpros      WITH loc_oBO.this_cCpros, ;
                        cpro2s     WITH loc_oBO.this_cCpro2s, ;
                        dpros      WITH loc_oBO.this_cDpros, ;
                        codbarras  WITH loc_oBO.this_nCodbarras, ;
                        barraref   WITH loc_oBO.this_nBarraref, ;
                        cunis      WITH loc_oBO.this_cCunis, ;
                        cunips     WITH loc_oBO.this_cCunips, ;
                        fators     WITH loc_oBO.this_nFators, ;
                        opers      WITH loc_oBO.this_cOpers IN cursor_4c_Itens

                REPLACE qtds       WITH loc_oBO.this_nQtds, ;
                        aqtds      WITH loc_oBO.this_nAqtds, ;
                        qtbaixas   WITH loc_oBO.this_nQtbaixas, ;
                        qtbxprods  WITH loc_oBO.this_nQtbxprods, ;
                        qtprods    WITH loc_oBO.this_nQtprods, ;
                        qtreservas WITH loc_oBO.this_nQtreservas, ;
                        qtresres   WITH loc_oBO.this_nQtresres, ;
                        pesos      WITH loc_oBO.this_nPesos, ;
                        tpesos     WITH loc_oBO.this_nTpesos, ;
                        compris    WITH loc_oBO.this_nCompris IN cursor_4c_Itens

                REPLACE units      WITH loc_oBO.this_nUnits, ;
                        unit2s     WITH loc_oBO.this_nUnit2s, ;
                        unitorigs  WITH loc_oBO.this_nUnitorigs, ;
                        unitinfs   WITH loc_oBO.this_nUnitinfs, ;
                        unitembs   WITH loc_oBO.this_nUnitembs, ;
                        univals    WITH loc_oBO.this_nUnivals, ;
                        moedas     WITH loc_oBO.this_cMoedas, ;
                        moevs      WITH loc_oBO.this_cMoevs, ;
                        moefats    WITH loc_oBO.this_cMoefats, ;
                        moevals    WITH loc_oBO.this_nMoevals, ;
                        fatvals    WITH loc_oBO.this_nFatvals, ;
                        totas      WITH loc_oBO.this_nTotas IN cursor_4c_Itens

                REPLACE valdescs   WITH loc_oBO.this_nValdescs, ;
                        descvals   WITH loc_oBO.this_nDescvals, ;
                        pdescs     WITH loc_oBO.this_nPdescs, ;
                        motdscs    WITH loc_oBO.this_cMotdscs, ;
                        vcoms      WITH loc_oBO.this_nVcoms, ;
                        valrats    WITH loc_oBO.this_nValrats, ;
                        codlprecs  WITH loc_oBO.this_nCodlprecs, ;
                        nchvtbds   WITH loc_oBO.this_nNchvtbds, ;
                        ncodigos   WITH loc_oBO.this_nNcodigos, ;
                        utilizas   WITH loc_oBO.this_nUtilizas IN cursor_4c_Itens

                *-- codcors / codtams / servicos NAO entram: nao sao coluna de
                *-- SigMvItn (sao do SUB-ITEM, que no legado mora no cursor
                *-- crTpmMvIts e aqui convive no mesmo cursor da grade). O BO
                *-- nao tem - e nao pode ter - property para elas; quem as
                *-- persiste eh o form PAI, junto com a composicao.
                REPLACE locals     WITH loc_oBO.this_cLocals, ;
                        localos    WITH loc_oBO.this_cLocalos, ;
                        abrevis    WITH loc_oBO.this_cAbrevis, ;
                        itemped    WITH loc_oBO.this_cItemped, ;
                        pedidoweb  WITH loc_oBO.this_cPedidoweb, ;
                        obs        WITH loc_oBO.this_cObs, ;
                        ob2s       WITH loc_oBO.this_cOb2s, ;
                        notas      WITH loc_oBO.this_cNotas, ;
                        numeronota WITH loc_oBO.this_cNumeronota, ;
                        nlotes     WITH loc_oBO.this_nNlotes IN cursor_4c_Itens

                REPLACE aliqs      WITH loc_oBO.this_nAliqs, ;
                        valipis    WITH loc_oBO.this_nValipis, ;
                        bcipis     WITH loc_oBO.this_nBcipis, ;
                        baseipi2s  WITH loc_oBO.this_nBaseipi2s, ;
                        baseipi3s  WITH loc_oBO.this_nBaseipi3s, ;
                        tpipis     WITH loc_oBO.this_cTpipis, ;
                        aliqicms   WITH loc_oBO.this_nAliqicms, ;
                        icms       WITH loc_oBO.this_nIcms, ;
                        icmss      WITH loc_oBO.this_nIcmss, ;
                        baseicms   WITH loc_oBO.this_nBaseicms, ;
                        bcicmss    WITH loc_oBO.this_nBcicmss, ;
                        baseicm2s  WITH loc_oBO.this_nBaseicm2s, ;
                        baseicm3s  WITH loc_oBO.this_nBaseicm3s IN cursor_4c_Itens

                REPLACE sitribs    WITH loc_oBO.this_cSitribs, ;
                        sittricms  WITH loc_oBO.this_cSittricms, ;
                        cfops      WITH loc_oBO.this_cCfops, ;
                        valbases   WITH loc_oBO.this_nValbases, ;
                        vpis       WITH loc_oBO.this_nVpis, ;
                        vcofins    WITH loc_oBO.this_nVcofins, ;
                        aliqpis    WITH loc_oBO.this_nAliqpis, ;
                        aliqcofs   WITH loc_oBO.this_nAliqcofs, ;
                        iss        WITH loc_oBO.this_nIss, ;
                        irrf       WITH loc_oBO.this_nIrrf, ;
                        inss       WITH loc_oBO.this_nInss, ;
                        cssl       WITH loc_oBO.this_nCssl IN cursor_4c_Itens

                REPLACE taxaiis    WITH loc_oBO.this_nTaxaiis, ;
                        aliqiis    WITH loc_oBO.this_nAliqiis, ;
                        aliqorigs  WITH loc_oBO.this_nAliqorigs, ;
                        origmercs  WITH loc_oBO.this_cOrigmercs, ;
                        nadis      WITH loc_oBO.this_nNadis, ;
                        niadis     WITH loc_oBO.this_nNiadis, ;
                        codfabs    WITH loc_oBO.this_cCodfabs, ;
                        pfcpst     WITH loc_oBO.this_nPfcpst, ;
                        vfcpst     WITH loc_oBO.this_nVfcpst, ;
                        ratdacs    WITH loc_oBO.this_nRatdacs, ;
                        ratfrts    WITH loc_oBO.this_nRatfrts, ;
                        ratsegs    WITH loc_oBO.this_nRatsegs, ;
                        raticms    WITH loc_oBO.this_nRaticms, ;
                        raticmds   WITH loc_oBO.this_nRaticmds IN cursor_4c_Itens

                REPLACE emps       WITH loc_oBO.this_cEmps, ;
                        dopes      WITH loc_oBO.this_cDopes, ;
                        dopesorig  WITH loc_oBO.this_cDopesorig, ;
                        numes      WITH loc_oBO.this_nNumes, ;
                        numolds    WITH loc_oBO.this_nNumolds, ;
                        empdopnums WITH loc_oBO.this_cEmpdopnums, ;
                        empos      WITH loc_oBO.this_cEmpos, ;
                        ifors      WITH loc_oBO.this_cIfors, ;
                        nrcons     WITH loc_oBO.this_cNrcons, ;
                        ntrans     WITH loc_oBO.this_nNtrans, ;
                        datatrans  WITH loc_oBO.this_dDatatrans, ;
                        dtalts     WITH loc_oBO.this_dDtalts, ;
                        usulibs    WITH loc_oBO.this_cUsulibs, ;
                        gravacao   WITH loc_oBO.this_cGravacao IN cursor_4c_Itens

                REPLACE idpro      WITH loc_oBO.this_nIdpro, ;
                        tipos      WITH loc_oBO.this_cTipos, ;
                        ckpresente WITH loc_oBO.this_nCkpresente, ;
                        etiesps    WITH loc_oBO.this_lEtiesps, ;
                        fvals      WITH loc_oBO.this_lFvals, ;
                        iconfs     WITH loc_oBO.this_lIconfs, ;
                        chksubn    WITH loc_oBO.this_lChksubn, ;
                        lcancelas  WITH loc_oBO.this_lLcancelas, ;
                        chaveexterna WITH loc_oBO.this_cChaveexterna IN cursor_4c_Itens

                REPLACE propriedades       WITH loc_oBO.this_cPropriedades, ;
                        unidade1           WITH loc_oBO.this_cUnidade1, ;
                        resultado1         WITH loc_oBO.this_cResultado1, ;
                        valorMinimo        WITH loc_oBO.this_cValorMinimo, ;
                        valorMaximo        WITH loc_oBO.this_cValorMaximo, ;
                        metodoReferencia1  WITH loc_oBO.this_cMetodoReferencia1 ;
                        IN cursor_4c_Itens

                loc_lOk = .T.
            ENDIF

        CATCH TO loc_oErro
            loc_lOk = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao trazer o item do objeto de neg" + CHR(243) + "cio:" + ;
                    CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro BOParaForm")
        ENDTRY

        IF loc_lOk
            *-- Popular o cursor NAO repinta a grade nem os campos ligados a
            *-- ele por ControlSource (regra #21): o Refresh das paginas eh o
            *-- que faz o painel mostrar o que acabou de ser gravado na linha.
            THIS.RepintarGradeItens()
            THIS.pgf_4c_Paginas.Page1.Refresh()
            THIS.pgf_4c_Paginas.Page3.Refresh()
            THIS.AtualizarPainelProduto()
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Caminho de ESC/Cancelar da tela.
    *
    * No SCX legado o botao de saida eh OK.btnSair, Caption "Retornar", com
    * Command1.Cancel = .T. - isto eh: Encerrar e Cancelar sao o MESMO botao,
    * e ESC cai nele. Nao existe no legado um "Cancelar" que descarte
    * alteracoes (quem grava ou descarta a movimentacao eh o form PAI, na
    * confirmacao da operacao), entao inventar um aqui mudaria o
    * comportamento da tela.
    *
    * Por isso este handler delega ao funil de saida, que valida os itens,
    * reabilita o form pai e fecha.
    *
    * PUBLIC: eh o nome que o harness de teste chama de FORA da classe
    * (regra #3).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        RETURN THIS.BtnEncerrarClick()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopproBO.prg):
*====================================================================
* sigopproBO.prg
*
* Business Object para o painel de Produtos (FormSigOpPro)
* Form OPERACIONAL embutido na tela de Movimentacao (Entrada/Saida)
* Entidade principal: Item de Movimentacao - tabela SigMvItn
* Cursor de trabalho repassado pelo form pai: crTpmMvItn/TprMvCab
* Chave primaria: cidchaves char(20)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigopproBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvItn)
    this_nAqtds              = 0     && aqtds numeric(9,3)
    this_nCitens             = 0     && citens numeric(10,0)
    this_nCodbarras          = 0     && codbarras numeric(14,0)
    this_cCpros              = ""    && cpros char(14)
    this_cCunis              = ""    && cunis char(3)
    this_dDatatrans          = {}    && datatrans datetime NULL
    this_nDescvals           = 0     && descvals numeric(7,2)
    this_cDopes              = ""    && dopes char(20)
    this_cDpros              = ""    && dpros char(65)
    this_cEmps               = ""    && emps char(3)
    this_lEtiesps            = .F.   && etiesps bit
    this_nFators             = 0     && fators numeric(8,3)
    this_nFatvals            = 0     && fatvals numeric(15,6)
    this_lFvals              = .F.   && fvals bit
    this_lIconfs             = .F.   && iconfs bit
    this_cLocals             = ""    && locals char(10)
    this_cMoedas             = ""    && moedas char(3)
    this_cMoefats            = ""    && moefats char(3)
    this_nMoevals            = 0     && moevals numeric(15,6)
    this_cNotas              = ""    && notas char(6)
    this_cNrcons             = ""    && nrcons char(10)
    this_nNtrans             = 0     && ntrans numeric(6,0)
    this_nNumes              = 0     && numes numeric(6,0)
    this_nNumolds            = 0     && numolds numeric(6,0)
    this_cObs                = ""    && obs text NULL
    this_cOpers              = ""    && opers char(1)
    this_nPesos              = 0     && pesos numeric(9,3)
    this_nQtbaixas           = 0     && qtbaixas numeric(9,3)
    this_nQtbxprods          = 0     && qtbxprods numeric(9,3)
    this_nQtds               = 0     && qtds numeric(9,3)
    this_nQtprods            = 0     && qtprods numeric(9,3)
    this_nTotas              = 0     && totas numeric(11,2)
    this_nTpesos             = 0     && tpesos numeric(11,2)
    this_nUnitembs           = 0     && unitembs numeric(11,4)
    this_nUnits              = 0     && units numeric(15,6)
    this_nUnivals            = 0     && univals numeric(15,6)
    this_nVcoms              = 0     && vcoms numeric(8,2)
    this_nAliqs              = 0     && aliqs numeric(4,2)
    this_cSitribs            = ""    && sitribs char(2)
    this_cTpipis             = ""    && tpipis char(1)
    this_nValipis            = 0     && valipis numeric(11,2)
    this_nAliqicms           = 0     && aliqicms numeric(5,2)
    this_nValdescs           = 0     && valdescs numeric(9,2)
    this_cEmpos              = ""    && empos char(3)
    this_cMoevs              = ""    && moevs char(3)
    this_nUtilizas            = 0     && utilizas numeric(4,0)
    this_nNcodigos           = 0     && ncodigos numeric(10,0)
    this_nQtreservas         = 0     && qtreservas numeric(9,3)
    this_cCidchaves          = ""    && cidchaves char(20) - PK
    this_nNlotes             = 0     && nlotes numeric(10,0)
    this_dDtalts             = {}    && dtalts datetime NULL
    this_cEmpdopnums         = ""    && empdopnums char(29)
    this_nBaseicms           = 0     && baseicms numeric(11,2)
    this_lChksubn            = .F.   && chksubn bit
    this_nUnit2s             = 0     && unit2s numeric(15,6)
    this_cUsulibs            = ""    && usulibs char(10)
    this_nValrats            = 0     && valrats numeric(14,6)
    this_nCodlprecs          = 0     && codlprecs numeric(6,0)
    this_cCunips             = ""    && cunips char(3)
    this_cMotdscs            = ""    && motdscs char(10)
    this_cTipos              = ""    && tipos char(1)
    this_nUnitinfs           = 0     && unitinfs numeric(14,6)
    this_cCpro2s             = ""    && cpro2s char(50)
    this_cAbrevis            = ""    && abrevis char(3)
    this_nBcicmss            = 0     && bcicmss numeric(15,2)
    this_nBcipis             = 0     && bcipis numeric(15,2)
    this_nIcms               = 0     && icms numeric(15,2)
    this_nIcmss              = 0     && icmss numeric(15,2)
    this_nPdescs             = 0     && pdescs numeric(5,2)
    this_nNchvtbds           = 0     && nchvtbds numeric(6,0)
    this_nIdpro              = 0     && idpro numeric(10,0)
    this_nUnitorigs          = 0     && unitorigs numeric(14,6)
    this_cOrigmercs          = ""    && origmercs char(1)
    this_nBaseicm2s          = 0     && baseicm2s numeric(11,2)
    this_nBaseicm3s          = 0     && baseicm3s numeric(11,2)
    this_nBaseipi2s          = 0     && baseipi2s numeric(11,2)
    this_nBaseipi3s          = 0     && baseipi3s numeric(11,2)
    this_cCfops              = ""    && cfops char(10)
    this_nRatdacs            = 0     && ratdacs numeric(11,2)
    this_nRatfrts            = 0     && ratfrts numeric(11,2)
    this_nRaticmds           = 0     && raticmds numeric(11,2)
    this_nRaticms            = 0     && raticms numeric(11,2)
    this_nRatsegs            = 0     && ratsegs numeric(11,2)
    this_cSittricms          = ""    && sittricms char(3)
    this_nAliqiis            = 0     && aliqiis numeric(4,2)
    this_nCitem2             = 0     && citem2 numeric(10,0)
    this_nTaxaiis            = 0     && taxaiis numeric(11,2)
    this_nVcofins            = 0     && vcofins numeric(11,2)
    this_nVpis               = 0     && vpis numeric(11,2)
    this_nAliqorigs          = 0     && aliqorigs numeric(4,2)
    this_lLcancelas          = .F.   && lcancelas bit
    this_nCompris            = 0     && compris numeric(6,2)
    this_cCodfabs            = ""    && codfabs char(60)
    this_nNadis              = 0     && nadis numeric(3,0)
    this_nNiadis             = 0     && niadis numeric(3,0)
    this_nAliqcofs           = 0     && aliqcofs numeric(4,2)
    this_nAliqpis            = 0     && aliqpis numeric(4,2)
    this_nCssl               = 0     && cssl numeric(11,2)
    this_nInss               = 0     && inss numeric(11,2)
    this_nIrrf               = 0     && irrf numeric(11,2)
    this_nIss                = 0     && iss numeric(11,2)
    this_nValbases           = 0     && valbases numeric(11,2)
    this_cLocalos            = ""    && localos char(10)
    this_nPfcpst             = 0     && pfcpst numeric(5,2)
    this_nVfcpst             = 0     && vfcpst numeric(11,2)
    this_cOb2s               = ""    && ob2s char(100)
    this_cPedidoweb          = ""    && pedidoweb char(50)
    this_nQtresres           = 0     && qtresres numeric(9,3)
    this_nBarraref           = 0     && barraref numeric(14,0)
    this_cItemped            = ""    && itemped char(4)
    this_cNumeronota         = ""    && numeronota char(10)
    this_cDopesorig          = ""    && dopesorig char(20)
    this_cChaveexterna       = ""    && chaveexterna char(33)
    this_nCkpresente         = 0     && ckpresente numeric(1,0)
    this_cGravacao           = ""    && gravacao char(20)
    this_cIfors              = ""    && ifors char(10)
    this_cPropriedades       = ""    && propriedades nvarchar(40) NULL
    this_cUnidade1           = ""    && unidade1 nvarchar(15) NULL
    this_cResultado1         = ""    && resultado1 nvarchar(15) NULL
    this_cValorMinimo        = ""    && valorMinimo nvarchar(15) NULL
    this_cValorMaximo        = ""    && valorMaximo nvarchar(15) NULL
    this_cMetodoReferencia1  = ""    && metodoReferencia1 nvarchar(15) NULL

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "sigopproBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia uma linha de SigMvItn (cursor populado
    * por SQLEXEC) para as properties da entidade. NAO e PROTECTED
    * (regra #51 - BusinessBase declara publico).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nAqtds        = TratarNulo(aqtds, 0)
            THIS.this_nCitens       = TratarNulo(citens, 0)
            THIS.this_nCodbarras    = TratarNulo(codbarras, 0)
            THIS.this_cCpros        = TratarNulo(cpros, "")
            THIS.this_cCunis        = TratarNulo(cunis, "")
            THIS.this_dDatatrans    = TratarNulo(datatrans, {})
            THIS.this_nDescvals     = TratarNulo(descvals, 0)
            THIS.this_cDopes        = TratarNulo(dopes, "")
            THIS.this_cDpros        = TratarNulo(dpros, "")
            THIS.this_cEmps         = TratarNulo(emps, "")
            THIS.this_lEtiesps      = IIF(VARTYPE(etiesps) = "L", etiesps, (NVL(etiesps, 0) = 1))
            THIS.this_nFators       = TratarNulo(fators, 0)
            THIS.this_nFatvals      = TratarNulo(fatvals, 0)
            THIS.this_lFvals        = IIF(VARTYPE(fvals) = "L", fvals, (NVL(fvals, 0) = 1))
            THIS.this_lIconfs       = IIF(VARTYPE(iconfs) = "L", iconfs, (NVL(iconfs, 0) = 1))
            THIS.this_cLocals       = TratarNulo(locals, "")
            THIS.this_cMoedas       = TratarNulo(moedas, "")
            THIS.this_cMoefats      = TratarNulo(moefats, "")
            THIS.this_nMoevals      = TratarNulo(moevals, 0)
            THIS.this_cNotas        = TratarNulo(notas, "")
            THIS.this_cNrcons       = TratarNulo(nrcons, "")
            THIS.this_nNtrans       = TratarNulo(ntrans, 0)
            THIS.this_nNumes        = TratarNulo(numes, 0)
            THIS.this_nNumolds      = TratarNulo(numolds, 0)
            THIS.this_cObs          = TratarNulo(obs, "")
            THIS.this_cOpers        = TratarNulo(opers, "")
            THIS.this_nPesos        = TratarNulo(pesos, 0)
            THIS.this_nQtbaixas     = TratarNulo(qtbaixas, 0)
            THIS.this_nQtbxprods    = TratarNulo(qtbxprods, 0)
            THIS.this_nQtds         = TratarNulo(qtds, 0)
            THIS.this_nQtprods      = TratarNulo(qtprods, 0)
            THIS.this_nTotas        = TratarNulo(totas, 0)
            THIS.this_nTpesos       = TratarNulo(tpesos, 0)
            THIS.this_nUnitembs     = TratarNulo(unitembs, 0)
            THIS.this_nUnits        = TratarNulo(units, 0)
            THIS.this_nUnivals      = TratarNulo(univals, 0)
            THIS.this_nVcoms        = TratarNulo(vcoms, 0)
            THIS.this_nAliqs        = TratarNulo(aliqs, 0)
            THIS.this_cSitribs      = TratarNulo(sitribs, "")
            THIS.this_cTpipis       = TratarNulo(tpipis, "")
            THIS.this_nValipis      = TratarNulo(valipis, 0)
            THIS.this_nAliqicms     = TratarNulo(aliqicms, 0)
            THIS.this_nValdescs     = TratarNulo(valdescs, 0)
            THIS.this_cEmpos        = TratarNulo(empos, "")
            THIS.this_cMoevs        = TratarNulo(moevs, "")
            THIS.this_nUtilizas     = TratarNulo(utilizas, 0)
            THIS.this_nNcodigos     = TratarNulo(ncodigos, 0)
            THIS.this_nQtreservas   = TratarNulo(qtreservas, 0)
            THIS.this_cCidchaves    = TratarNulo(cidchaves, "")
            THIS.this_nNlotes       = TratarNulo(nlotes, 0)
            THIS.this_dDtalts       = TratarNulo(dtalts, {})
            THIS.this_cEmpdopnums   = TratarNulo(empdopnums, "")
            THIS.this_nBaseicms     = TratarNulo(baseicms, 0)
            THIS.this_lChksubn      = IIF(VARTYPE(chksubn) = "L", chksubn, (NVL(chksubn, 0) = 1))
            THIS.this_nUnit2s       = TratarNulo(unit2s, 0)
            THIS.this_cUsulibs      = TratarNulo(usulibs, "")
            THIS.this_nValrats      = TratarNulo(valrats, 0)
            THIS.this_nCodlprecs    = TratarNulo(codlprecs, 0)
            THIS.this_cCunips       = TratarNulo(cunips, "")
            THIS.this_cMotdscs      = TratarNulo(motdscs, "")
            THIS.this_cTipos        = TratarNulo(tipos, "")
            THIS.this_nUnitinfs     = TratarNulo(unitinfs, 0)
            THIS.this_cCpro2s       = TratarNulo(cpro2s, "")
            THIS.this_cAbrevis      = TratarNulo(abrevis, "")
            THIS.this_nBcicmss      = TratarNulo(bcicmss, 0)
            THIS.this_nBcipis       = TratarNulo(bcipis, 0)
            THIS.this_nIcms         = TratarNulo(icms, 0)
            THIS.this_nIcmss        = TratarNulo(icmss, 0)
            THIS.this_nPdescs       = TratarNulo(pdescs, 0)
            THIS.this_nNchvtbds     = TratarNulo(nchvtbds, 0)
            THIS.this_nIdpro        = TratarNulo(idpro, 0)
            THIS.this_nUnitorigs    = TratarNulo(unitorigs, 0)
            THIS.this_cOrigmercs    = TratarNulo(origmercs, "")
            THIS.this_nBaseicm2s    = TratarNulo(baseicm2s, 0)
            THIS.this_nBaseicm3s    = TratarNulo(baseicm3s, 0)
            THIS.this_nBaseipi2s    = TratarNulo(baseipi2s, 0)
            THIS.this_nBaseipi3s    = TratarNulo(baseipi3s, 0)
            THIS.this_cCfops        = TratarNulo(cfops, "")
            THIS.this_nRatdacs      = TratarNulo(ratdacs, 0)
            THIS.this_nRatfrts      = TratarNulo(ratfrts, 0)
            THIS.this_nRaticmds     = TratarNulo(raticmds, 0)
            THIS.this_nRaticms      = TratarNulo(raticms, 0)
            THIS.this_nRatsegs      = TratarNulo(ratsegs, 0)
            THIS.this_cSittricms    = TratarNulo(sittricms, "")
            THIS.this_nAliqiis      = TratarNulo(aliqiis, 0)
            THIS.this_nCitem2       = TratarNulo(citem2, 0)
            THIS.this_nTaxaiis      = TratarNulo(taxaiis, 0)
            THIS.this_nVcofins      = TratarNulo(vcofins, 0)
            THIS.this_nVpis         = TratarNulo(vpis, 0)
            THIS.this_nAliqorigs    = TratarNulo(aliqorigs, 0)
            THIS.this_lLcancelas    = IIF(VARTYPE(lcancelas) = "L", lcancelas, (NVL(lcancelas, 0) = 1))
            THIS.this_nCompris      = TratarNulo(compris, 0)
            THIS.this_cCodfabs      = TratarNulo(codfabs, "")
            THIS.this_nNadis        = TratarNulo(nadis, 0)
            THIS.this_nNiadis       = TratarNulo(niadis, 0)
            THIS.this_nAliqcofs     = TratarNulo(aliqcofs, 0)
            THIS.this_nAliqpis      = TratarNulo(aliqpis, 0)
            THIS.this_nCssl         = TratarNulo(cssl, 0)
            THIS.this_nInss         = TratarNulo(inss, 0)
            THIS.this_nIrrf         = TratarNulo(irrf, 0)
            THIS.this_nIss          = TratarNulo(iss, 0)
            THIS.this_nValbases     = TratarNulo(valbases, 0)
            THIS.this_cLocalos      = TratarNulo(localos, "")
            THIS.this_nPfcpst       = TratarNulo(pfcpst, 0)
            THIS.this_nVfcpst       = TratarNulo(vfcpst, 0)
            THIS.this_cOb2s         = TratarNulo(ob2s, "")
            THIS.this_cPedidoweb    = TratarNulo(pedidoweb, "")
            THIS.this_nQtresres     = TratarNulo(qtresres, 0)
            THIS.this_nBarraref     = TratarNulo(barraref, 0)
            THIS.this_cItemped      = TratarNulo(itemped, "")
            THIS.this_cNumeronota   = TratarNulo(numeronota, "")
            THIS.this_cDopesorig    = TratarNulo(dopesorig, "")
            THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")
            THIS.this_nCkpresente   = TratarNulo(ckpresente, 0)
            THIS.this_cGravacao     = TratarNulo(gravacao, "")
            THIS.this_cIfors        = TratarNulo(ifors, "")
            THIS.this_cPropriedades       = TratarNulo(propriedades, "")
            THIS.this_cUnidade1           = TratarNulo(unidade1, "")
            THIS.this_cResultado1         = TratarNulo(resultado1, "")
            THIS.this_cValorMinimo        = TratarNulo(valorMinimo, "")
            THIS.this_cValorMaximo        = TratarNulo(valorMaximo, "")
            THIS.this_cMetodoReferencia1  = TratarNulo(metodoReferencia1, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Monta a chave POSICIONAL empdopnums
    * char(29), igual ao legado (SIGMVSBN: Emps + Dopes + Str(Numes,6)).
    * Regra #42: o padding FAZ PARTE da chave - PADR explicito nas
    * partes (Emps char(3) + Dopes char(20) + 6 = 29). ALLTRIM nas
    * partes encurta a chave, ela nunca casa e o SELECT devolve ZERO
    * linhas em silencio.
    *====================================================================
    FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes

        loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

        RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
    ENDFUNC

    *====================================================================
    * CarregarItens - Le os itens de UMA movimentacao (empdopnums) para
    * um cursor TEMPORARIO. Equivale ao AddCursor('SigMvItn', ...) que o
    * legado herda do form pai de Movimentacao.
    *
    * NUNCA faz SQLEXEC sobre o alias ligado a grade: isso FECHA e RECRIA
    * o alias, zera o ColumnCount e a grade vira um retangulo branco
    * (sem erro e sem log). O chamador recarrega o alias da grade com
    * SELECT/ZAP/APPEND FROM DBF() a partir deste cursor temporario.
    *
    * par_cEmpDopNums - chave char(29) da movimentacao (ver
    *                   MontarChaveEmpDopNums)
    * par_cCursorTmp  - alias do cursor temporario de destino
    *====================================================================
    FUNCTION CarregarItens(par_cEmpDopNums, par_cCursorTmp)
        LOCAL loc_cSQL, loc_cCursor, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = IIF(VARTYPE(par_cCursorTmp) = "C" AND !EMPTY(par_cCursorTmp), ;
                           ALLTRIM(par_cCursorTmp), "cursor_4c_ItensTmp")

        IF VARTYPE(par_cEmpDopNums) <> "C" OR EMPTY(par_cEmpDopNums)
            THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + ;
                                      "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            *-- Alias do cursor temporario fechado antes do SQLEXEC; o guard
            *-- testa o BUFFERING, nunca so o USED (regra #52).
            IF USED(loc_cCursor)
                IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                    TABLEREVERT(.T., loc_cCursor)
                ENDIF
                USE IN (loc_cCursor)
            ENDIF

            *-- Lista de colunas EXPLICITA e identica a do CREATE CURSOR do
            *-- form: o APPEND FROM DBF() casa os campos por NOME.
            loc_cSQL = "SELECT aqtds, citens, codbarras, cpros, cunis," + ;
                       " datatrans, descvals, dopes, dpros, emps," + ;
                       " etiesps, fators, fatvals, fvals, iconfs," + ;
                       " locals, moedas, moefats, moevals, notas," + ;
                       " nrcons, ntrans, numes, numolds, obs," + ;
                       " opers, pesos, qtbaixas, qtbxprods, qtds," + ;
                       " qtprods, totas, tpesos, unitembs, units," + ;
                       " univals, vcoms, aliqs, sitribs, tpipis," + ;
                       " valipis, aliqicms, valdescs, empos, moevs," + ;
                       " utilizas, ncodigos, qtreservas, cidchaves, nlotes," + ;
                       " dtalts, empdopnums, baseicms, chksubn, unit2s," + ;
                       " usulibs, valrats, codlprecs, cunips, motdscs," + ;
                       " tipos, unitinfs, cpro2s, abrevis, bcicmss," + ;
                       " bcipis, icms, icmss, pdescs, nchvtbds," + ;
                       " idpro, unitorigs, origmercs, baseicm2s, baseicm3s," + ;
                       " baseipi2s, baseipi3s, cfops, ratdacs, ratfrts," + ;
                       " raticmds, raticms, ratsegs, sittricms, aliqiis," + ;
                       " citem2, taxaiis, vcofins, vpis, aliqorigs," + ;
                       " lcancelas, compris, codfabs, nadis, niadis," + ;
                       " aliqcofs, aliqpis, cssl, inss, irrf," + ;
                       " iss, valbases, localos, pfcpst, vfcpst," + ;
                       " ob2s, pedidoweb, qtresres, barraref, itemped," + ;
                       " numeronota, dopesorig, chaveexterna, ckpresente," + ;
                       " gravacao, ifors, propriedades, unidade1, resultado1," + ;
                       " valorMinimo, valorMaximo, metodoReferencia1" + ;
                       " FROM SigMvItn" + ;
                       " WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums) + ;
                       " ORDER BY citens"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar os itens da movimenta" + CHR(231) + ;
                            CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, ;
                            "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao carregar os itens da movimenta" + CHR(231) + ;
                        CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
                        "sigopproBO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
    * nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *====================================================================
    * Inserir - INSERT completo em SigMvItn. cidchaves (PK Fortyus) e
    * gerada aqui se ainda vazia (regra #22 - fUniqueIds(), NUNCA string
    * vazia, senao o 2o registro colide no indice unico).
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidchaves)
            THIS.this_cCidchaves = fUniqueIds()
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvItn (
                    aqtds, citens, codbarras, cpros, cunis, datatrans,
                    descvals, dopes, dpros, emps, etiesps, fators,
                    fatvals, fvals, iconfs, locals, moedas, moefats,
                    moevals, notas, nrcons, ntrans, numes, numolds,
                    obs, opers, pesos, qtbaixas, qtbxprods, qtds,
                    qtprods, totas, tpesos, unitembs, units, univals,
                    vcoms, aliqs, sitribs, tpipis, valipis, aliqicms,
                    valdescs, empos, moevs, utilizas, ncodigos, qtreservas,
                    cidchaves, nlotes, dtalts, empdopnums, baseicms, chksubn,
                    unit2s, usulibs, valrats, codlprecs, cunips, motdscs,
                    tipos, unitinfs, cpro2s, abrevis, bcicmss, bcipis,
                    icms, icmss, pdescs, nchvtbds, idpro, unitorigs,
                    origmercs, baseicm2s, baseicm3s, baseipi2s, baseipi3s, cfops,
                    ratdacs, ratfrts, raticmds, raticms, ratsegs, sittricms,
                    aliqiis, citem2, taxaiis, vcofins, vpis, aliqorigs,
                    lcancelas, compris, codfabs, nadis, niadis, aliqcofs,
                    aliqpis, cssl, inss, irrf, iss, valbases,
                    localos, pfcpst, vfcpst, ob2s, pedidoweb, qtresres,
                    barraref, itemped, numeronota, dopesorig, chaveexterna, ckpresente,
                    gravacao, ifors, propriedades, unidade1, resultado1, valorMinimo,
                    valorMaximo, metodoReferencia1
                )
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nAqtds, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nCitens, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodbarras, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCunis, 3))>>,
                    <<IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))>>,
                    <<FormatarNumeroSQL(THIS.this_nDescvals, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cDpros, 65))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<IIF(THIS.this_lEtiesps, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFators, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nFatvals, 6)>>,
                    <<IIF(THIS.this_lFvals, 1, 0)>>,
                    <<IIF(THIS.this_lIconfs, 1, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoedas, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoefats, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nMoevals, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cNotas, 6))>>,
                    <<EscaparSQL(LEFT(THIS.this_cNrcons, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
                    <<IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs))>>,
                    <<EscaparSQL(LEFT(THIS.this_cOpers, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nPesos, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtbaixas, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtbxprods, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtds, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtprods, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nTotas, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpesos, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitembs, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnits, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnivals, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nVcoms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cSitribs, 2))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTpipis, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nValipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqicms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoevs, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nUtilizas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNcodigos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtreservas, 3)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
                    <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    <<IIF(EMPTY(THIS.this_dDtalts), "NULL", FormatarDataSQL(THIS.this_dDtalts))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicms, 2)>>,
                    <<IIF(THIS.this_lChksubn, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnit2s, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsulibs, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nValrats, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodlprecs, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCunips, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMotdscs, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTipos, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitinfs, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpro2s, 50))>>,
                    <<EscaparSQL(LEFT(THIS.this_cAbrevis, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nBcicmss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBcipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPdescs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nNchvtbds, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIdpro, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitorigs, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cOrigmercs, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicm2s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicm3s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseipi2s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseipi3s, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCfops, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nRatdacs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRatfrts, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRaticmds, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRaticms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRatsegs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cSittricms, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqiis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCitem2, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTaxaiis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqorigs, 2)>>,
                    <<IIF(THIS.this_lLcancelas, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCompris, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCodfabs, 60))>>,
                    <<FormatarNumeroSQL(THIS.this_nNadis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNiadis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqcofs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCssl, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nInss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIrrf, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValbases, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cLocalos, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nPfcpst, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVfcpst, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cOb2s, 100))>>,
                    <<EscaparSQL(LEFT(THIS.this_cPedidoweb, 50))>>,
                    <<FormatarNumeroSQL(THIS.this_nQtresres, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nBarraref, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cItemped, 4))>>,
                    <<EscaparSQL(LEFT(THIS.this_cNumeronota, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopesorig, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>,
                    <<FormatarNumeroSQL(THIS.this_nCkpresente, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cGravacao, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cIfors, 10))>>,
                    <<IIF(EMPTY(THIS.this_cPropriedades), "NULL", EscaparSQL(LEFT(THIS.this_cPropriedades, 40)))>>,
                    <<IIF(EMPTY(THIS.this_cUnidade1), "NULL", EscaparSQL(LEFT(THIS.this_cUnidade1, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cResultado1), "NULL", EscaparSQL(LEFT(THIS.this_cResultado1, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cValorMinimo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cValorMaximo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cMetodoReferencia1), "NULL", EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15)))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao inserir item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao inserir item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "sigopproBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE completo em SigMvItn pela PK cidchaves.
    * cidchaves identifica o registro e NAO entra no SET.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvItn SET
                    aqtds        = <<FormatarNumeroSQL(THIS.this_nAqtds, 3)>>,
                    citens       = <<FormatarNumeroSQL(THIS.this_nCitens, 0)>>,
                    codbarras    = <<FormatarNumeroSQL(THIS.this_nCodbarras, 0)>>,
                    cpros        = <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    cunis        = <<EscaparSQL(LEFT(THIS.this_cCunis, 3))>>,
                    datatrans    = <<IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))>>,
                    descvals     = <<FormatarNumeroSQL(THIS.this_nDescvals, 2)>>,
                    dopes        = <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    dpros        = <<EscaparSQL(LEFT(THIS.this_cDpros, 65))>>,
                    emps         = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    etiesps      = <<IIF(THIS.this_lEtiesps, 1, 0)>>,
                    fators       = <<FormatarNumeroSQL(THIS.this_nFators, 3)>>,
                    fatvals      = <<FormatarNumeroSQL(THIS.this_nFatvals, 6)>>,
                    fvals        = <<IIF(THIS.this_lFvals, 1, 0)>>,
                    iconfs       = <<IIF(THIS.this_lIconfs, 1, 0)>>,
                    locals       = <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
                    moedas       = <<EscaparSQL(LEFT(THIS.this_cMoedas, 3))>>,
                    moefats      = <<EscaparSQL(LEFT(THIS.this_cMoefats, 3))>>,
                    moevals      = <<FormatarNumeroSQL(THIS.this_nMoevals, 6)>>,
                    notas        = <<EscaparSQL(LEFT(THIS.this_cNotas, 6))>>,
                    nrcons       = <<EscaparSQL(LEFT(THIS.this_cNrcons, 10))>>,
                    ntrans       = <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
                    numes        = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    numolds      = <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
                    obs          = <<IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs))>>,
                    opers        = <<EscaparSQL(LEFT(THIS.this_cOpers, 1))>>,
                    pesos        = <<FormatarNumeroSQL(THIS.this_nPesos, 3)>>,
                    qtbaixas     = <<FormatarNumeroSQL(THIS.this_nQtbaixas, 3)>>,
                    qtbxprods    = <<FormatarNumeroSQL(THIS.this_nQtbxprods, 3)>>,
                    qtds         = <<FormatarNumeroSQL(THIS.this_nQtds, 3)>>,
                    qtprods      = <<FormatarNumeroSQL(THIS.this_nQtprods, 3)>>,
                    totas        = <<FormatarNumeroSQL(THIS.this_nTotas, 2)>>,
                    tpesos       = <<FormatarNumeroSQL(THIS.this_nTpesos, 2)>>,
                    unitembs     = <<FormatarNumeroSQL(THIS.this_nUnitembs, 4)>>,
                    units        = <<FormatarNumeroSQL(THIS.this_nUnits, 6)>>,
                    univals      = <<FormatarNumeroSQL(THIS.this_nUnivals, 6)>>,
                    vcoms        = <<FormatarNumeroSQL(THIS.this_nVcoms, 2)>>,
                    aliqs        = <<FormatarNumeroSQL(THIS.this_nAliqs, 2)>>,
                    sitribs      = <<EscaparSQL(LEFT(THIS.this_cSitribs, 2))>>,
                    tpipis       = <<EscaparSQL(LEFT(THIS.this_cTpipis, 1))>>,
                    valipis      = <<FormatarNumeroSQL(THIS.this_nValipis, 2)>>,
                    aliqicms     = <<FormatarNumeroSQL(THIS.this_nAliqicms, 2)>>,
                    valdescs     = <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
                    empos        = <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
                    moevs        = <<EscaparSQL(LEFT(THIS.this_cMoevs, 3))>>,
                    utilizas     = <<FormatarNumeroSQL(THIS.this_nUtilizas, 0)>>,
                    ncodigos     = <<FormatarNumeroSQL(THIS.this_nNcodigos, 0)>>,
                    qtreservas   = <<FormatarNumeroSQL(THIS.this_nQtreservas, 3)>>,
                    nlotes       = <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    dtalts       = <<IIF(EMPTY(THIS.this_dDtalts), "NULL", FormatarDataSQL(THIS.this_dDtalts))>>,
                    empdopnums   = <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
                    baseicms     = <<FormatarNumeroSQL(THIS.this_nBaseicms, 2)>>,
                    chksubn      = <<IIF(THIS.this_lChksubn, 1, 0)>>,
                    unit2s       = <<FormatarNumeroSQL(THIS.this_nUnit2s, 6)>>,
                    usulibs      = <<EscaparSQL(LEFT(THIS.this_cUsulibs, 10))>>,
                    valrats      = <<FormatarNumeroSQL(THIS.this_nValrats, 6)>>,
                    codlprecs    = <<FormatarNumeroSQL(THIS.this_nCodlprecs, 0)>>,
                    cunips       = <<EscaparSQL(LEFT(THIS.this_cCunips, 3))>>,
                    motdscs      = <<EscaparSQL(LEFT(THIS.this_cMotdscs, 10))>>,
                    tipos        = <<EscaparSQL(LEFT(THIS.this_cTipos, 1))>>,
                    unitinfs     = <<FormatarNumeroSQL(THIS.this_nUnitinfs, 6)>>,
                    cpro2s       = <<EscaparSQL(LEFT(THIS.this_cCpro2s, 50))>>,
                    abrevis      = <<EscaparSQL(LEFT(THIS.this_cAbrevis, 3))>>,
                    bcicmss      = <<FormatarNumeroSQL(THIS.this_nBcicmss, 2)>>,
                    bcipis       = <<FormatarNumeroSQL(THIS.this_nBcipis, 2)>>,
                    icms         = <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    icmss        = <<FormatarNumeroSQL(THIS.this_nIcmss, 2)>>,
                    pdescs       = <<FormatarNumeroSQL(THIS.this_nPdescs, 2)>>,
                    nchvtbds     = <<FormatarNumeroSQL(THIS.this_nNchvtbds, 0)>>,
                    idpro        = <<FormatarNumeroSQL(THIS.this_nIdpro, 0)>>,
                    unitorigs    = <<FormatarNumeroSQL(THIS.this_nUnitorigs, 6)>>,
                    origmercs    = <<EscaparSQL(LEFT(THIS.this_cOrigmercs, 1))>>,
                    baseicm2s    = <<FormatarNumeroSQL(THIS.this_nBaseicm2s, 2)>>,
                    baseicm3s    = <<FormatarNumeroSQL(THIS.this_nBaseicm3s, 2)>>,
                    baseipi2s    = <<FormatarNumeroSQL(THIS.this_nBaseipi2s, 2)>>,
                    baseipi3s    = <<FormatarNumeroSQL(THIS.this_nBaseipi3s, 2)>>,
                    cfops        = <<EscaparSQL(LEFT(THIS.this_cCfops, 10))>>,
                    ratdacs      = <<FormatarNumeroSQL(THIS.this_nRatdacs, 2)>>,
                    ratfrts      = <<FormatarNumeroSQL(THIS.this_nRatfrts, 2)>>,
                    raticmds     = <<FormatarNumeroSQL(THIS.this_nRaticmds, 2)>>,
                    raticms      = <<FormatarNumeroSQL(THIS.this_nRaticms, 2)>>,
                    ratsegs      = <<FormatarNumeroSQL(THIS.this_nRatsegs, 2)>>,
                    sittricms    = <<EscaparSQL(LEFT(THIS.this_cSittricms, 3))>>,
                    aliqiis      = <<FormatarNumeroSQL(THIS.this_nAliqiis, 2)>>,
                    citem2       = <<FormatarNumeroSQL(THIS.this_nCitem2, 0)>>,
                    taxaiis      = <<FormatarNumeroSQL(THIS.this_nTaxaiis, 2)>>,
                    vcofins      = <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
                    vpis         = <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
                    aliqorigs    = <<FormatarNumeroSQL(THIS.this_nAliqorigs, 2)>>,
                    lcancelas    = <<IIF(THIS.this_lLcancelas, 1, 0)>>,
                    compris      = <<FormatarNumeroSQL(THIS.this_nCompris, 2)>>,
                    codfabs      = <<EscaparSQL(LEFT(THIS.this_cCodfabs, 60))>>,
                    nadis        = <<FormatarNumeroSQL(THIS.this_nNadis, 0)>>,
                    niadis       = <<FormatarNumeroSQL(THIS.this_nNiadis, 0)>>,
                    aliqcofs     = <<FormatarNumeroSQL(THIS.this_nAliqcofs, 2)>>,
                    aliqpis      = <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    cssl         = <<FormatarNumeroSQL(THIS.this_nCssl, 2)>>,
                    inss         = <<FormatarNumeroSQL(THIS.this_nInss, 2)>>,
                    irrf         = <<FormatarNumeroSQL(THIS.this_nIrrf, 2)>>,
                    iss          = <<FormatarNumeroSQL(THIS.this_nIss, 2)>>,
                    valbases     = <<FormatarNumeroSQL(THIS.this_nValbases, 2)>>,
                    localos      = <<EscaparSQL(LEFT(THIS.this_cLocalos, 10))>>,
                    pfcpst       = <<FormatarNumeroSQL(THIS.this_nPfcpst, 2)>>,
                    vfcpst       = <<FormatarNumeroSQL(THIS.this_nVfcpst, 2)>>,
                    ob2s         = <<EscaparSQL(LEFT(THIS.this_cOb2s, 100))>>,
                    pedidoweb    = <<EscaparSQL(LEFT(THIS.this_cPedidoweb, 50))>>,
                    qtresres     = <<FormatarNumeroSQL(THIS.this_nQtresres, 3)>>,
                    barraref     = <<FormatarNumeroSQL(THIS.this_nBarraref, 0)>>,
                    itemped      = <<EscaparSQL(LEFT(THIS.this_cItemped, 4))>>,
                    numeronota   = <<EscaparSQL(LEFT(THIS.this_cNumeronota, 10))>>,
                    dopesorig    = <<EscaparSQL(LEFT(THIS.this_cDopesorig, 20))>>,
                    chaveexterna = <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>,
                    ckpresente   = <<FormatarNumeroSQL(THIS.this_nCkpresente, 0)>>,
                    gravacao     = <<EscaparSQL(LEFT(THIS.this_cGravacao, 20))>>,
                    ifors        = <<EscaparSQL(LEFT(THIS.this_cIfors, 10))>>,
                    propriedades = <<IIF(EMPTY(THIS.this_cPropriedades), "NULL", EscaparSQL(LEFT(THIS.this_cPropriedades, 40)))>>,
                    unidade1     = <<IIF(EMPTY(THIS.this_cUnidade1), "NULL", EscaparSQL(LEFT(THIS.this_cUnidade1, 15)))>>,
                    resultado1   = <<IIF(EMPTY(THIS.this_cResultado1), "NULL", EscaparSQL(LEFT(THIS.this_cResultado1, 15)))>>,
                    valorMinimo  = <<IIF(EMPTY(THIS.this_cValorMinimo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)))>>,
                    valorMaximo  = <<IIF(EMPTY(THIS.this_cValorMaximo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)))>>,
                    metodoReferencia1 = <<IIF(EMPTY(THIS.this_cMetodoReferencia1), "NULL", EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15)))>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao atualizar item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao atualizar item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "sigopproBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

