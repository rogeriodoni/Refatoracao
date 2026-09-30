# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 3/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-28 21:48:29] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-28 21:48:29] [INFO] Config FPW: (nao fornecido)
[2026-09-28 21:48:29] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 21:48:29] [INFO] Timeout: 300 segundos
[2026-09-28 21:48:29] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_civiwn1m.prg
[2026-09-28 21:48:29] [INFO] Conteudo do wrapper:
[2026-09-28 21:48:29] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprftp', 'C:\4c\tasks\task611\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprftp', 'C:\4c\tasks\task611\logs\06_testForm.log'
QUIT

[2026-09-28 21:48:29] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_civiwn1m.prg
[2026-09-28 21:48:29] [INFO] VFP output esperado em: C:\4c\tasks\task611\vfp_output.txt
[2026-09-28 21:48:29] [INFO] Executando Visual FoxPro 9...
[2026-09-28 21:48:29] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_civiwn1m.prg
[2026-09-28 21:48:29] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_civiwn1m.prg
[2026-09-28 21:48:29] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprftp
Inicio: 28/09/2026 21:48:29

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 28/09/2026 21:51:41
Duracao: 192 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-28 21:51:41] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-28 21:51:41] [INFO] VFP9 finalizado em 192.3801142 segundos
[2026-09-28 21:51:41] [INFO] Exit Code: 
[2026-09-28 21:51:41] [INFO] 
[2026-09-28 21:51:41] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-28 21:51:41] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_civiwn1m.prg
[2026-09-28 21:51:41] [INFO] 
[2026-09-28 21:51:41] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-28 21:51:41] [INFO] * Auto-generated wrapper for parameters
[2026-09-28 21:51:41] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 21:51:41] [INFO] * Parameters: 'Formsigprftp', 'C:\4c\tasks\task611\logs\06_testForm.log'
[2026-09-28 21:51:41] [INFO] 
[2026-09-28 21:51:41] [INFO] * Anti-dialog protections for unattended execution
[2026-09-28 21:51:41] [INFO] SET SAFETY OFF
[2026-09-28 21:51:41] [INFO] SET RESOURCE OFF
[2026-09-28 21:51:41] [INFO] SET TALK OFF
[2026-09-28 21:51:41] [INFO] SET NOTIFY OFF
[2026-09-28 21:51:41] [INFO] SYS(2335, 0)
[2026-09-28 21:51:41] [INFO] 
[2026-09-28 21:51:41] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprftp', 'C:\4c\tasks\task611\logs\06_testForm.log'
[2026-09-28 21:51:41] [INFO] QUIT
[2026-09-28 21:51:41] [INFO] 
[2026-09-28 21:51:41] [INFO] === Fim do Wrapper.prg ===
[2026-09-28 21:51:41] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg):
*==============================================================================
* Formsigprftp.prg - Form OPERACIONAL: Transferencia e Recebimento de
*                     arquivos via FTP
* Origem  : SIGPRFTP.SCX
* Herda de: FormBase
* Tipo    : OPERACIONAL (modal, sem parametros - a configuracao de FTP da
*           empresa corrente e resolvida internamente via
*           sigprftpBO.ResolverConfiguracaoFtp(go_4c_Sistema.cCodEmpresa),
*           reproduzindo o bloco "With ThisForm...EndWith" do Init legado
*           que antes recebia os 14 parametros cTpEnv/cTpRec/.../lCaseSensitive)
*==============================================================================
* Layout do form (800x600) - layout CUSTOMIZADO, NAO segue o padrao CRUD
* Page1=Lista/Page2=Dados (form OPERACIONAL de raiz "form" generica):
*   shp_4c_Shape1     : moldura decorativa (top=7,left=696,90x110)
*   cnt_4c_Navegacao  : hospeda os 2 PageFrames de navegacao local/FTP
*     pgf_4c_Loc      : PageFrame "Local" - Page1="A Enviar" / Page2="Recebidos"
*     pgf_4c_Ftp      : PageFrame "FTP"   - Page1="Enviados" / Page2="A Receber"
*   GrdProc (Fase 4)  : grid de progresso das operacoes (cursor tmpprog)
*   GrdInf  (Fase 4)  : grid de log/mensagens (cursor logftp)
*   lblprog (Fase 4)  : label de status, rodape do painel de progresso
*   botoes de acao (Fase 4): Conecta/Transfere/Recebe/Rede Dial-Up/Encerrar
*   carga de dados (Fase 4): CarregarDados lista o diretorio remoto do FTP
*                            (WinInet) em cursor_4c_FtpServer; Processa
*                            alimenta o grid de progresso; Inf, o de log
*   ConfigurarPaginaDados (Fase 5): ponto de entrada dos controles de DADOS
*                        das paginas dos 2 PageFrames + o guard de
*                        disponibilidade transcrito do Init legado
*   pgf_4c_Loc (Fase 5): Page1 "A Enviar" (lst_4c_EnvFtp/txt_4c_DirEnvFtp/
*                        cmd_4c_BrowEnvFtp) e Page2 "Recebidos"
*                        (lst_4c_RecFtp/txt_4c_DirRecFtp/cmd_4c_BrowRecFtp);
*                        MontaContainer agora povoa lst_4c_EnvFtp via ADIR;
*                        Activate das paginas sincroniza pgf_4c_Ftp.ActivePage
*   pgf_4c_Ftp (Fase 6) : Page1 "Enviados" (lst_4c_RecLoc/txt_4c_DirRecLoc/
*                        cmd_4c_BrowRecLoc) e Page2 "A Receber"
*                        (lst_4c_EnvLoc/txt_4c_DirEnvLoc/cmd_4c_BrowEnvLoc);
*                        Activate das paginas sincroniza pgf_4c_Loc.ActivePage
*   CboProvedor (Fase 6): cbo_4c_Provedor, combo de provedores Dial-Up
*                        (RowSourceType=5 sobre o array PUBLIC aProvedor,
*                        populado por RasConexao quando this_cTpConnect="D")
*   Transferencia (Fase 7): VerificarArquivoFtp/EnviarArquivoFtp/
*                        ReceberArquivoFtp/RenomearArquivoFtp/ExcluirArquivoFtp
*                        (WinInet FtpOpenFile/FtpPutFile/FtpGetFile/
*                        FtpRenameFile/FtpDeleteFile - equivalentes a
*                        rasfile/rasftpput/rasftpget/renameftpfile/
*                        deleteftpfile do legado); Transferir/Receber agora
*                        percorrem lst_4c_EnvFtp/lst_4c_EnvLoc chamando essas
*                        rotinas arquivo a arquivo (equivalente a
*                        transfere/recebe); Processa grava o arquivo
*                        concluido em lst_4c_RecLoc/lst_4c_RecFtp e, quando
*                        this_lDelLocal/this_lDelHost estao ativos, apaga o
*                        arquivo de origem
*   Consolidacao (Fase 8): BOParaForm/FormParaBO transferem os quatro
*                        diretorios entre BO e tela (bloco ".direnvftp.Value =
*                        ThisForm._DirEnvFtp" do Init legado e o inverso);
*                        CarregarLista eh o ponto unico de recarga (FormParaBO
*                        -> MontaContainer -> repinta os dois grids);
*                        HabilitarCampos consolida o bloco de ".enabled" que o
*                        legado repete em cmdload.Click/transfere/recebe
*==============================================================================
* O QUE NAO SE APLICA A ESTE FORM (legado SEM CRUD - nao inventar superficie):
*   Salvar/Confirmar    : o SCX nao tem botao de gravar e o form nao persiste
*                         nada em tabela de negocio - a acao da tela eh
*                         TRANSFERIR arquivo (BtnExecutarTransferenciaClick /
*                         BtnExecutarRecebimentoClick). O unico registro
*                         gravado eh o log de operacao, via fGravarLog.
*   Cancelar            : nao existe Page2 de Dados nem modo de edicao
*                         cancelavel; o botao que fecha eh "Encerrar"
*                         (cmdsair -> BtnEncerrarClick).
*   Buscar              : o SCX nao tem campo nem botao de procura.
*   AjustarBotoesPorModo: a tela nao tem modo INCLUIR/ALTERAR/VISUALIZAR/
*                         EXCLUIR - o estado dos botoes depende de haver
*                         conexao, e isso eh HabilitarCampos.
*   LimparCampos        : as duas listas "a enviar" ja sao limpas por
*                         MontaContainer no ponto exato em que o legado as
*                         limpa (dentro do IF de cada sentido, so apos a
*                         listagem ter dado certo); as duas listas de
*                         concluidos o legado NUNCA limpa - elas acumulam o
*                         historico da sessao, alimentadas por Processa.
*==============================================================================

DEFINE CLASS Formsigprftp AS FormBase

    Width       = 800
    Height      = 600
    AutoCenter  = .T.
    ShowTips    = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    ShowWindow  = 1     && "As Top-Level Form" - FIXO na classe (igual FormBuscaAuxiliar/
                        && FormErro/FormBuscaSimples): ShowWindow e READ-ONLY em runtime
                        && nesta instalacao do VFP9 (medido em automation\medir_showwindow.txt
                        && - ate um Form nativo vazio recusa THIS.ShowWindow=x no Init com
                        && "Property SHOWWINDOW is read-only"); so WindowType aceita mudanca
                        && em runtime.
    WindowType  = 1
    WindowState = 0
    LockScreen  = .F.
    Themes      = .F.

    this_oBusinessObject      = .NULL.
    this_cProvedorConectado   = ""     && Nome do provedor Dial-Up discado por BtnRedeDialupClick (equivalente a "cProvedor" do legado, consultado no Destroy para desconectar)

    *==========================================================================
    * Init - Dispara a cadeia FormBase.Init -> InicializarForm
    *==========================================================================
    FUNCTION Init()
        *-- Em modo teste: rebaixa para modeless (WindowType=0, aceita mudanca
        *-- em runtime) + Visible=.F. para o VFP9 -T headless nao travar
        *-- tentando exibir um form modal top-level (mesma protecao de
        *-- FormICD/FormICO/FormSIGPRCIC). NAO tocar ShowWindow aqui - fica
        *-- travado no valor fixo da classe (ver comentario acima).
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.WindowType = 0
            THIS.Visible = .F.
        ENDIF

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - Resolve a configuracao de FTP da empresa corrente e
    * cria a estrutura visual base do form (chamado por FormBase.Init)
    *==========================================================================
    PROTECTED FUNCTION InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Em modo teste: retornar sucesso sem criar controles UI nem
        *-- depender de SQLEXEC (SigCdPam/SigCdEmp podem nao existir no
        *-- ambiente de teste headless)
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            THIS.Caption = "Transfer" + CHR(234) + "ncia e Recebimento de arquivos via FTP"

            THIS.this_oBusinessObject = CREATEOBJECT("sigprftpBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Falha ao criar sigprftpBO.", "InicializarForm")
            ELSE
                IF !THIS.this_oBusinessObject.ResolverConfiguracaoFtp(go_4c_Sistema.cCodEmpresa)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Configura" + CHR(231) + CHR(227) + "o de FTP")
                ELSE
                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarCursoresAuxiliares()
                    THIS.ConfigurarGrids()
                    THIS.ConfigurarBotoesAcao()
                    THIS.ConfigurarPaginaDados()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConfigurarPageFrame - Cria a moldura decorativa (Shape1) e o container
    * de navegacao com os 2 PageFrames internos (Local / FTP), reproduzindo
    * fielmente Top/Left/Width/Height/Caption/cores do SCX legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 696
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cnt_4c_Navegacao", "Container")
        WITH THIS.cnt_4c_Navegacao
            .Top         = 128
            .Left        = 88
            .Width       = 620
            .Height      = 194
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- PageFrame "Local" - Page1 = A Enviar / Page2 = Recebidos
        THIS.cnt_4c_Navegacao.AddObject("pgf_4c_Loc", "PageFrame")
        WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc
            .PageCount   = 2
            .Top         = 4
            .Left        = 3
            .Width       = 294
            .Height      = 186
            .TabStretch  = 1
            .ActivePage  = 1
            .Visible     = .T.
        ENDWITH
        WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1
            .Caption   = "A Enviar"
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(0,0,255)
        ENDWITH
        WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page2
            .Caption   = "Recebidos"
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(255,0,0)
        ENDWITH

        *-- PageFrame "FTP" - Page1 = Enviados / Page2 = A Receber
        THIS.cnt_4c_Navegacao.AddObject("pgf_4c_Ftp", "PageFrame")
        WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp
            .PageCount   = 2
            .Top         = 4
            .Left        = 326
            .Width       = 294
            .Height      = 186
            .ActivePage  = 1
            .Visible     = .T.
        ENDWITH
        WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page1
            .Caption   = "Enviados"
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(0,0,255)
        ENDWITH
        WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2
            .Caption   = "A Receber"
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(255,0,0)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCursoresAuxiliares - Cria os cursores locais que sustentam os
    * grids de progresso (equivalente a "Create cursor tmpprog") e de log
    * (equivalente a "Create cursor Logftp") do Init legado. Campos foram
    * renomeados em relacao ao legado (ex.: "local" -> "pastalocal") apenas
    * para evitar colisao com palavras reservadas do VFP9 - sao cursores de
    * memoria, nao tabelas do PILAR 2.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCursoresAuxiliares()
        IF USED("cursor_4c_Progresso")
            USE IN cursor_4c_Progresso
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Progresso (arquivo C(254), tamanho N(12), ;
            pastalocal C(254), pastahost C(254), statusoperacao C(50))
        SET NULL OFF

        IF USED("cursor_4c_Log")
            USE IN cursor_4c_Log
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Log (memo M, cor C(1))
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * ConfigurarGrids - Cria os dois grids do form: GrdProc (progresso das
    * transferencias, ligado a cursor_4c_Progresso) e GrdInf (log de
    * mensagens, ligado a cursor_4c_Log), com Top/Left/Width/Height/fontes/
    * cores/headers fielmente transcritos do SCX legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrids()
        THIS.AddObject("grd_4c_Progresso", "Grid")

        *-- ColumnCount/RecordSource ficam FORA do WITH: acessar .ColumnN
        *-- dentro do mesmo WITH que ainda esta definindo o RecordSource
        *-- estoura 'Unknown member COLUMN1' porque as colunas nao existem
        *-- no momento em que o WITH eh aberto (regra GRID-WITH).
        THIS.grd_4c_Progresso.ColumnCount      = 5
        THIS.grd_4c_Progresso.RecordSourceType = 1
        THIS.grd_4c_Progresso.RecordSource     = "cursor_4c_Progresso"

        WITH THIS.grd_4c_Progresso
            .Top          = 376
            .Left         = 89
            .Width        = 622
            .Height       = 114
            .FontSize     = 8
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .GridLines    = 0
            .HeaderHeight = 15
            .RowHeight    = 15
            .ReadOnly     = .T.
            .ToolTipText  = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"

            .Column1.ControlSource   = "cursor_4c_Progresso.arquivo"
            .Column1.Width           = 81
            .Column1.FontSize        = 8
            .Column1.ReadOnly        = .T.
            .Column1.Header1.Caption = "Arquivo"

            .Column2.ControlSource   = "cursor_4c_Progresso.tamanho"
            .Column2.Width           = 63
            .Column2.FontSize        = 8
            .Column2.ReadOnly        = .T.
            .Column2.Header1.Caption = "Tamanho"

            .Column3.ControlSource   = "cursor_4c_Progresso.pastalocal"
            .Column3.Width           = 107
            .Column3.FontSize        = 8
            .Column3.ReadOnly        = .T.
            .Column3.Header1.Caption = "Pasta Local"

            .Column4.ControlSource   = "cursor_4c_Progresso.pastahost"
            .Column4.Width           = 136
            .Column4.FontSize        = 8
            .Column4.ReadOnly        = .T.
            .Column4.Header1.Caption = "Pasta Host"

            .Column5.ControlSource   = "cursor_4c_Progresso.statusoperacao"
            .Column5.Width           = 207
            .Column5.FontSize        = 8
            .Column5.ReadOnly        = .T.
            .Column5.Header1.Caption = "Status"

            .Visible = .T.
        ENDWITH

        THIS.AddObject("grd_4c_Log", "Grid")

        *-- ColumnCount/RecordSource ficam FORA do WITH pelo mesmo motivo
        *-- do grd_4c_Progresso acima (regra GRID-WITH).
        THIS.grd_4c_Log.ColumnCount      = 1
        THIS.grd_4c_Log.RecordSourceType = 1
        THIS.grd_4c_Log.RecordSource     = "cursor_4c_Log"

        WITH THIS.grd_4c_Log
            .Top           = 323
            .Left          = 89
            .Width         = 622
            .Height        = 52
            .FontBold      = .T.
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLines     = 0
            .GridLineWidth = 1
            .HeaderHeight  = 0
            .RowHeight     = 14
            .ScrollBars    = 2
            .ReadOnly      = .T.
            .ForeColor     = RGB(0,0,0)
            .BackColor     = RGB(255,255,255)
            .GridLineColor = RGB(192,192,192)

            .Column1.ControlSource    = "cursor_4c_Log.memo"
            .Column1.Width            = 599
            .Column1.FontBold         = .T.
            .Column1.FontName         = "Arial"
            .Column1.FontSize         = 8
            .Column1.Alignment        = 0
            .Column1.ReadOnly         = .T.
            .Column1.ForeColor        = RGB(0,0,0)
            .Column1.BackColor        = RGB(255,255,255)
            .Column1.DynamicForeColor = "IIF(cursor_4c_Log.cor='R', RGB(255,255,255), IIF(cursor_4c_Log.cor='G', RGB(0,128,0), IIF(cursor_4c_Log.cor='B', RGB(0,0,255), RGB(0,255,255))))"
            .Column1.DynamicBackColor = "IIF(cursor_4c_Log.cor='R', RGB(255,0,0), RGB(255,255,255))"

            .Column1.Header1.FontBold  = .T.
            .Column1.Header1.FontName  = "Arial"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Memo"
            .Column1.Header1.ForeColor = RGB(0,0,0)
            .Column1.Header1.BackColor = RGB(192,192,192)

            .Visible = .T.
        ENDWITH

        *-- Label de status da operacao corrente (lblprog do legado). Fica
        *-- junto dos grids porque e' o rodape do painel de progresso: o
        *-- PROCEDURE processa escreve nele o tempo decorrido/estimado a cada
        *-- bloco transferido. Classe base "label" (nao a classe "say" do
        *-- Framework), logo AutoSize/Alignment ficam nos defaults - Width e
        *-- Height vem do SCX (rule #23: fixar os dois, nunca usar AutoSize)
        THIS.AddObject("lbl_4c_Progresso", "Label")
        WITH THIS.lbl_4c_Progresso
            .Top       = 512
            .Left      = 245
            .Width     = 437
            .Height    = 16
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0,0,0)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Cria os botoes de acao do form (Conecta,
    * Transfere, Recebe, Rede Dial-Up, Encerrar e os 2 botoes pequenos de
    * transferencia individual dentro de cnt_4c_Navegacao), com o Enabled/
    * Visible inicial calculado como no Init legado: checagem de existencia
    * dos diretorios locais (this_cDirEnvFtp/this_cDirRecFtp) e visibilidade
    * do botao de Dial-Up conforme this_cTpConnect
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_lConfigOk
        loc_lConfigOk = .T.

        THIS.AddObject("cmd_4c_Conectar", "CommandButton")
        WITH THIS.cmd_4c_Conectar
            .Top        = 12
            .Left       = 23
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "a_arrow1.bmp"
            .Caption    = "\<Conecta"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Conectar, "Click", THIS, "BtnConectarClick")

        THIS.AddObject("cmd_4c_Transferir", "CommandButton")
        WITH THIS.cmd_4c_Transferir
            .Top        = 12
            .Left       = 99
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "baix_aut.bmp"
            .Caption    = "\<Transfere"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes           = .T.
            .DisabledPicture  = gc_4c_CaminhoIcones + "baix_aut.bmp"
            .Enabled    = .F.
            .Visible    = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Transferir, "Click", THIS, "BtnExecutarTransferenciaClick")

        THIS.AddObject("cmd_4c_Receber", "CommandButton")
        WITH THIS.cmd_4c_Receber
            .Top        = 12
            .Left       = 174
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "d_disk1.bmp"
            .Caption    = "\<Recebe"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes           = .T.
            .DisabledPicture  = gc_4c_CaminhoIcones + "d_disk1.bmp"
            .Enabled    = .F.
            .Visible    = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Receber, "Click", THIS, "BtnExecutarRecebimentoClick")

        THIS.AddObject("cmd_4c_RedeDialup", "CommandButton")
        WITH THIS.cmd_4c_RedeDialup
            .Top        = 534
            .Left       = 332
            .Width      = 76
            .Height     = 54
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 7
            .Picture    = gc_4c_CaminhoIcones + "c_comm1.bmp"
            .Caption    = "Rede \<Dial-Up"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes           = .T.
            .Visible    = (THIS.this_oBusinessObject.this_cTpConnect == "D")
        ENDWITH
        BINDEVENT(THIS.cmd_4c_RedeDialup, "Click", THIS, "BtnRedeDialupClick")

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top        = 12
            .Left = 5
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes           = .T.
            .Enabled    = .T.
            .Visible    = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        THIS.cnt_4c_Navegacao.AddObject("cmd_4c_EnviaFtp", "CommandButton")
        WITH THIS.cnt_4c_Navegacao.cmd_4c_EnviaFtp
            .Top          = 83
            .Left         = 299
            .Width        = 25
            .Height       = 24
            .FontName     = "Verdana"
            .FontSize     = 8
            .Picture      = gc_4c_CaminhoIcones + "b_arrow2.bmp"
            .Caption      = ""
            .ToolTipText  = "Transfere para FTP"
            .ForeColor    = RGB(36,84,155)
            .BackColor    = RGB(255,255,255)
            .Visible      = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Navegacao.cmd_4c_EnviaFtp, "Click", THIS, "BtnEnviaFtpClick")

        THIS.cnt_4c_Navegacao.AddObject("cmd_4c_RecebeFtp", "CommandButton")
        WITH THIS.cnt_4c_Navegacao.cmd_4c_RecebeFtp
            .Top          = 116
            .Left         = 299
            .Width        = 25
            .Height       = 24
            .FontName     = "Verdana"
            .FontSize     = 8
            .Picture      = gc_4c_CaminhoIcones + "b_arrow1.bmp"
            .Caption      = ""
            .ToolTipText  = "Recebe do FTP"
            .ForeColor    = RGB(36,84,155)
            .BackColor    = RGB(255,255,255)
            .Visible      = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Navegacao.cmd_4c_RecebeFtp, "Click", THIS, "BtnRecebeFtpClick")

        *-- Container1 (cnt_4c_Navegacao) so fica habilitado apos Conecta
        THIS.cnt_4c_Navegacao.Enabled = .F.

        *-- "Checa a existencia dos diretorios locais" (Init legado)
        IF !EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp) AND !DIRECTORY(THIS.this_oBusinessObject.this_cDirEnvFtp)
            THIS.Inf("Diret" + CHR(243) + "rio Local de Envio para FTP n" + CHR(227) + "o existe. Verifique o cadastro de empresas", "R")
            loc_lConfigOk = .F.
        ENDIF
        IF !EMPTY(THIS.this_oBusinessObject.this_cDirRecFtp) AND !DIRECTORY(THIS.this_oBusinessObject.this_cDirRecFtp)
            THIS.Inf("Diret" + CHR(243) + "rio Local de Recebimento do FTP n" + CHR(227) + "o existe. Verifique o cadastro de empresas", "R")
            loc_lConfigOk = .F.
        ENDIF

        THIS.cmd_4c_Conectar.Enabled = loc_lConfigOk

        IF !loc_lConfigOk
            MsgAviso("Erro na parametriza" + CHR(231) + CHR(227) + "o ou na configura" + CHR(231) + CHR(227) + "o da conex" + CHR(227) + "o. Verifique... Opera" + CHR(231) + CHR(227) + "o Cancelada", "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarControlesLocal - Cria os controles de dados do PageFrame
    * "Local" (pgf_4c_Loc): Page1 "A Enviar" (lst_4c_EnvFtp/txt_4c_DirEnvFtp/
    * cmd_4c_BrowEnvFtp) e Page2 "Recebidos" (lst_4c_RecFtp/txt_4c_DirRecFtp/
    * cmd_4c_BrowRecFtp), com Top/Left/Width/Height/ColumnWidths transcritos
    * do SCX legado (lstenvftp/direnvftp/cmdbrowloc de cada pagina - o legado
    * reusa o MESMO nome "cmdbrowloc" nas duas paginas; aqui os botoes
    * recebem nomes distintos por acao, ja que o nome generico colidiria).
    * Os botoes "..." ficam Enabled = .F. porque o legado NUNCA implementa
    * Click para eles (nenhum PROCEDURE Click no dump) - sao decorativos no
    * original. Os controles de dados do PageFrame "FTP" (pgf_4c_Ftp) e o
    * CboProvedor entram na Fase 6.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesLocal()
        LOCAL loc_oPag1, loc_oPag2

        loc_oPag1 = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1
        loc_oPag2 = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page2

        loc_oPag1.AddObject("lst_4c_EnvFtp", "ListBox")
        WITH loc_oPag1.lst_4c_EnvFtp
            .Top          = 26
            .Left         = 2
            .Width        = 286
            .Height       = 130
            .ColumnCount  = 3
            .ColumnWidths = "130,62,83"
            .ColumnLines  = .T.
            .MultiSelect  = .T.
            .FontName     = "Verdana"
            .FontSize     = 8
            .Visible      = .T.
        ENDWITH

        loc_oPag1.AddObject("txt_4c_DirEnvFtp", "TextBox")
        WITH loc_oPag1.txt_4c_DirEnvFtp
            .Top         = 2
            .Left        = 2
            .Width       = 217
            .Height      = 23
            .FontName    = "Verdana"
            .FontSize    = 8
            .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
            .Visible     = .T.
        ENDWITH

        loc_oPag1.AddObject("cmd_4c_BrowEnvFtp", "CommandButton")
        WITH loc_oPag1.cmd_4c_BrowEnvFtp
            .Top       = 2
            .Left      = 222
            .Width     = 22
            .Height    = 22
            .FontName  = "Verdana"
            .FontSize  = 8
            .Caption   = "..."
            .ForeColor = RGB(36,84,155)
            .BackColor = RGB(255,255,255)
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("lst_4c_RecFtp", "ListBox")
        WITH loc_oPag2.lst_4c_RecFtp
            .Top          = 26
            .Left         = 2
            .Width        = 286
            .Height       = 130
            .ColumnCount  = 3
            .ColumnWidths = "135,58,82"
            .ColumnLines  = .T.
            .MultiSelect  = .T.
            .FontName     = "Verdana"
            .FontSize     = 8
            .Visible      = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_DirRecFtp", "TextBox")
        WITH loc_oPag2.txt_4c_DirRecFtp
            .Top         = 2
            .Left        = 2
            .Width       = 217
            .Height      = 23
            .FontName    = "Verdana"
            .FontSize    = 8
            .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
            .Visible     = .T.
        ENDWITH

        loc_oPag2.AddObject("cmd_4c_BrowRecFtp", "CommandButton")
        WITH loc_oPag2.cmd_4c_BrowRecFtp
            .Top       = 2
            .Left      = 222
            .Width     = 22
            .Height    = 22
            .FontName  = "Verdana"
            .FontSize  = 8
            .Caption   = "..."
            .ForeColor = RGB(36,84,155)
            .BackColor = RGB(255,255,255)
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Page.Activate do PageFrame Local (Page1.Activate/Page2.Activate do
        *-- "pgfloc" legado): alem de alternar qual botao pequeno de
        *-- transferencia individual fica habilitado, o legado SINCRONIZA o
        *-- outro PageFrame (This.Parent.Parent.pgfftp.PageN.zorder) - os dois
        *-- ficam LADO A LADO (pgf_4c_Loc Left=3..297 / pgf_4c_Ftp
        *-- Left=326..620, ver layout.json) e mostram a ORIGEM e o DESTINO da
        *-- MESMA operacao, entao escolher "A Enviar" no lado Local tem de
        *-- trazer "Enviados" no lado FTP. Page.ZOrder num PageFrame traz a
        *-- pagina para a frente, ou seja, SELECIONA a pagina: o equivalente
        *-- no migrado eh <pageframe>.ActivePage = N.
        BINDEVENT(loc_oPag1, "Activate", THIS, "PagLocEnviarActivate")
        BINDEVENT(loc_oPag2, "Activate", THIS, "PagLocRecebidosActivate")
    ENDPROC

    *==========================================================================
    * ConfigurarControlesFtp - Cria os controles de dados do PageFrame "FTP"
    * (pgf_4c_Ftp): Page1 "Enviados" (lst_4c_RecLoc/txt_4c_DirRecLoc/
    * cmd_4c_BrowRecLoc, espelhando a pasta REMOTA this_cDirRecLoc) e Page2
    * "A Receber" (lst_4c_EnvLoc/txt_4c_DirEnvLoc/cmd_4c_BrowEnvLoc,
    * espelhando this_cDirEnvLoc), com Top/Left/Width/Height/ColumnWidths
    * transcritos do SCX legado (lstrecloc/dirrecloc/cmdbrowftp de cada
    * pagina - o legado reusa o MESMO nome "cmdbrowftp" nas duas paginas; aqui
    * os botoes recebem nomes distintos por acao, como ja feito em
    * ConfigurarControlesLocal). Os botoes "..." ficam Enabled = .F. porque o
    * legado NUNCA implementa Click para eles (nenhum PROCEDURE Click no
    * dump) - sao decorativos no original.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesFtp()
        LOCAL loc_oPag1, loc_oPag2

        loc_oPag1 = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page1
        loc_oPag2 = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2

        loc_oPag1.AddObject("lst_4c_RecLoc", "ListBox")
        WITH loc_oPag1.lst_4c_RecLoc
            .Top          = 26
            .Left         = 2
            .Width        = 286
            .Height       = 130
            .ColumnCount  = 3
            .ColumnWidths = "135,58,82"
            .ColumnLines  = .T.
            .MultiSelect  = .T.
            .FontName     = "Verdana"
            .FontSize     = 8
            .Visible      = .T.
        ENDWITH

        loc_oPag1.AddObject("txt_4c_DirRecLoc", "TextBox")
        WITH loc_oPag1.txt_4c_DirRecLoc
            .Top         = 2
            .Left        = 2
            .Width       = 217
            .Height      = 23
            .FontName    = "Verdana"
            .FontSize    = 8
            .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
            .Visible     = .T.
        ENDWITH

        loc_oPag1.AddObject("cmd_4c_BrowRecLoc", "CommandButton")
        WITH loc_oPag1.cmd_4c_BrowRecLoc
            .Top       = 2
            .Left      = 223
            .Width     = 22
            .Height    = 22
            .FontName  = "Verdana"
            .FontSize  = 8
            .Caption   = "..."
            .ForeColor = RGB(36,84,155)
            .BackColor = RGB(255,255,255)
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("lst_4c_EnvLoc", "ListBox")
        WITH loc_oPag2.lst_4c_EnvLoc
            .Top          = 26
            .Left         = 2
            .Width        = 286
            .Height       = 130
            .ColumnCount  = 3
            .ColumnWidths = "130,62,83"
            .ColumnLines  = .T.
            .MultiSelect  = .T.
            .FontName     = "Verdana"
            .FontSize     = 8
            .Visible      = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_DirEnvLoc", "TextBox")
        WITH loc_oPag2.txt_4c_DirEnvLoc
            .Top         = 2
            .Left        = 2
            .Width       = 217
            .Height      = 23
            .FontName    = "Verdana"
            .FontSize    = 8
            .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
            .Visible     = .T.
        ENDWITH

        loc_oPag2.AddObject("cmd_4c_BrowEnvLoc", "CommandButton")
        WITH loc_oPag2.cmd_4c_BrowEnvLoc
            .Top       = 2
            .Left      = 223
            .Width     = 22
            .Height    = 22
            .FontName  = "Verdana"
            .FontSize  = 8
            .Caption   = "..."
            .ForeColor = RGB(36,84,155)
            .BackColor = RGB(255,255,255)
            .Themes    = .F.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Page.Activate do PageFrame FTP (pgfftp.Page1.Activate/
        *-- Page2.Activate do legado): espelha, na direcao oposta, o mesmo
        *-- Activate ja ligado em ConfigurarControlesLocal - o dump do legado
        *-- mostra que os DOIS PageFrames (pgfloc e pgfftp) reagem ao
        *-- Activate de qualquer uma das paginas mexendo nos MESMOS botoes
        *-- pequenos This.Parent.Parent.cmdtransfere/cmdrecebe (Container1,
        *-- aqui cnt_4c_Navegacao.cmd_4c_EnviaFtp/cmd_4c_RecebeFtp).
        BINDEVENT(loc_oPag1, "Activate", THIS, "PagFtpEnviadosActivate")
        BINDEVENT(loc_oPag2, "Activate", THIS, "PagFtpAReceberActivate")
    ENDPROC

    *==========================================================================
    * ConfigurarProvedorDialUp - Cria o combo de provedores Dial-Up
    * (CboProvedor do legado) e, quando a conexao configurada for do tipo
    * Dial-Up ("D"), enumera as conexoes RAS cadastradas no Windows via
    * THIS.RasConexao(), preenchendo o array PUBLIC aProvedor que alimenta o
    * RowSource do combo (RowSourceType=5, array). Transcricao do trecho
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarProvedorDialUp()
        PUBLIC ARRAY aProvedor(1)
        aProvedor(1) = ""
        PUBLIC nProvedor
        nProvedor = 1

        THIS.AddObject("cbo_4c_Provedor", "ComboBox")
        WITH THIS.cbo_4c_Provedor
            .Top              = 550
            .Left             = 90
            .Width            = 235
            .Height           = 24
            .Style            = 2
            .RowSourceType    = 5
            .RowSource        = "aProvedor"
            .ColumnCount      = 1
            .ControlSource    = "nProvedor"
            .FirstElement     = 1
            .FontName         = "Verdana"
            .FontSize         = 8
            .Visible          = .F.
        ENDWITH

        IF THIS.this_oBusinessObject.this_cTpConnect == "D"
            THIS.cbo_4c_Provedor.Visible = .T.

            IF THIS.RasConexao("aProvedor") = 0
                RELEASE aProvedor
                PUBLIC ARRAY aProvedor(1)
                aProvedor(1) = ""
                THIS.Inf("N" + CHR(227) + "o existem conex" + CHR(245) + "es DIAL-UP dispon" + CHR(237) + "veis...", "R")
                MsgAviso("N" + CHR(227) + "o existem conex" + CHR(245) + "es dispon" + CHR(237) + "veis...", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.cmd_4c_Conectar.Enabled = .F.
            ELSE
            ENDIF
        ELSE
            THIS.cbo_4c_Provedor.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Ponto de entrada dos controles de DADOS das
    * paginas dos 2 PageFrames de navegacao. Cria os controles da metade
    * "Local" (ConfigurarControlesLocal) e da metade "FTP"
    * (ConfigurarControlesFtp), aplica o guard de disponibilidade que o Init
    * legado executa DEPOIS de montar a tela e, por fim, configura o combo de
    * provedores Dial-Up (ConfigurarProvedorDialUp) - na MESMA ordem do Init
    * legado (controles -> guard de direcao -> CboProvedor/RasConexao).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPgLoc, loc_oPgFtp

        THIS.ConfigurarControlesLocal()
        THIS.ConfigurarControlesFtp()

        *-- Bloco ".pgfloc.Page1.direnvftp.Value = ThisForm._DirEnvFtp" (e os
        *-- outros tres, mais os quatro ToolTipText) que o Init legado executa
        *-- DEPOIS de resolver a configuracao: no migrado isso eh o BOParaForm.
        THIS.BOParaForm()

        loc_oPgLoc = THIS.cnt_4c_Navegacao.pgf_4c_Loc
        loc_oPgFtp = THIS.cnt_4c_Navegacao.pgf_4c_Ftp

        *-- Guard de disponibilidade, transcrito do Init legado (blocos
        *-- "if Empt(_DirEnvFtp) .or. empt(_DirRecLoc)" e
        *-- "if Empt(_DirRecFtp) .or. empt(_DirEnvLoc)"): faltando um dos dois
        *-- diretorios de um sentido, aquele sentido inteiro eh desativado -
        *-- a pagina correspondente nos DOIS PageFrames, o botao pequeno de
        *-- transferencia individual e o botao grande da barra de acao - e a
        *-- navegacao eh levada para a pagina do sentido que continua valido
        *-- (o ".pgfloc.PageN.zOrder" / ".pgfftp.PageN.zOrder" do legado).
        IF EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp) OR EMPTY(THIS.this_oBusinessObject.this_cDirRecLoc)
            loc_oPgLoc.Page1.Enabled = .F.
            loc_oPgFtp.Page1.Enabled = .F.
            loc_oPgLoc.ActivePage    = 2
            loc_oPgFtp.ActivePage    = 2
            THIS.cmd_4c_Transferir.Enabled = .F.
            THIS.Inf("Sistema Configurado somente para Recebimento. Envio Desativado", "G")
        ENDIF

        IF EMPTY(THIS.this_oBusinessObject.this_cDirRecFtp) OR EMPTY(THIS.this_oBusinessObject.this_cDirEnvLoc)
            loc_oPgLoc.Page2.Enabled = .F.
            loc_oPgFtp.Page2.Enabled = .F.
            loc_oPgLoc.ActivePage    = 1
            loc_oPgFtp.ActivePage    = 1
            THIS.cmd_4c_Receber.Enabled = .F.
            THIS.Inf("Sistema Configurado somente para Envio. Recebimento Desativado.", "G")
        ENDIF

        THIS.ConfigurarProvedorDialUp()
    ENDPROC

    *==========================================================================
    * PagLocEnviarActivate / PagLocRecebidosActivate - Activate das paginas
    * do PageFrame Local: alternam o Enabled dos botoes pequenos de
    * transferencia individual (cmd_4c_EnviaFtp/cmd_4c_RecebeFtp), como o
    * legado faz em pgfloc.Page1.Activate/Page2.Activate (cmdtransfere/
    * cmdrecebe.enabled). Metodos PUBLIC - BINDEVENT exige (regra #3).
    *==========================================================================
    PROCEDURE PagLocEnviarActivate()
        *-- "This.Parent.Parent.pgfftp.Page1.zorder" do legado: leva o
        *-- PageFrame FTP para a pagina do MESMO sentido (Enviados). A
        *-- atribuicao so acontece quando o valor muda, para o Activate do
        *-- outro PageFrame (que sincroniza de volta) nao tornar a disparar.
        IF THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage <> 1
            THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage = 1
        ENDIF
    ENDPROC

    PROCEDURE PagLocRecebidosActivate()
        *-- "This.Parent.Parent.pgfftp.Page2.zorder" do legado: leva o
        *-- PageFrame FTP para a pagina do MESMO sentido (A Receber).
        IF THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage <> 2
            THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage = 2
        ENDIF
    ENDPROC

    *==========================================================================
    * PagFtpEnviadosActivate / PagFtpAReceberActivate - Activate das paginas
    * do PageFrame FTP: espelham PagLocEnviarActivate/PagLocRecebidosActivate
    * na direcao oposta, sincronizando pgf_4c_Loc.ActivePage e alternando o
    * Enabled dos mesmos botoes pequenos de transferencia individual, como o
    * legado faz em pgfftp.Page1.Activate/Page2.Activate. Metodos PUBLIC -
    * BINDEVENT exige (regra #3).
    *==========================================================================
    PROCEDURE PagFtpEnviadosActivate()
        *-- "This.Parent.Parent.pgfloc.Page1.zorder" do legado: leva o
        *-- PageFrame Local para a pagina do MESMO sentido (A Enviar).
        IF THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage <> 1
            THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage = 1
        ENDIF
    ENDPROC

    PROCEDURE PagFtpAReceberActivate()
        *-- "This.Parent.Parent.pgfloc.Page2.zorder" do legado: leva o
        *-- PageFrame Local para a pagina do MESMO sentido (Recebidos).
        IF THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage <> 2
            THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage = 2
        ENDIF
    ENDPROC

    *==========================================================================
    * Inf - Registra uma mensagem no grid de log (grd_4c_Log/cursor_4c_Log)
    * e reposiciona o cursor no ultimo registro, equivalente ao PROCEDURE Inf
    * do legado (par_cCor: "R"=erro/vermelho, "G"=sucesso/verde, "B"=info/azul)
    *==========================================================================
    PROTECTED PROCEDURE Inf(par_cTexto, par_cCor)
        LOCAL loc_cAliasAnterior
        loc_cAliasAnterior = ALIAS()

        IF !USED("cursor_4c_Log")
            RETURN
        ENDIF

        SELECT cursor_4c_Log
        APPEND BLANK
        REPLACE memo WITH par_cTexto, cor WITH par_cCor
        GO BOTTOM

        THIS.grd_4c_Log.Refresh()

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF
    ENDPROC

    *==========================================================================
    * WordToC / CToWord - Conversao entre inteiro (4 bytes) e buffer de
    * caracteres usada pelas chamadas RAS/WinInet, equivalente aos metodos
    * homonimos do legado
    *==========================================================================
    PROTECTED PROCEDURE WordToC(par_nNumero)
        RETURN CHR(BITAND(255, par_nNumero)) + ;
               CHR(BITAND(65280, par_nNumero) % 255) + ;
               CHR(BITAND(16711680, par_nNumero) % 255) + ;
               CHR(BITAND(4278190080, par_nNumero) % 255)
    ENDPROC

    PROTECTED PROCEDURE CToWord(par_cBuffer)
        RETURN ASC(SUBSTR(par_cBuffer, 1, 1)) + ;
               ASC(SUBSTR(par_cBuffer, 2, 1)) * 256 + ;
               ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536 + ;
               ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216
    ENDPROC

    *==========================================================================
    * RasAtivas - Enumera as conexoes Dial-Up ATIVAS no momento via RAS API
    * (equivalente ao PROCEDURE rasativas do legado). Devolve a quantidade de
    * conexoes ativas e preenche o array PUBLIC cujo nome e passado em
    * par_cNomeArray com [indice,1]=handle e [indice,2..4]=dados da conexao
    *==========================================================================
    PROTECTED PROCEDURE RasAtivas(par_cNomeArray)
        LOCAL loc_cConexao, loc_cConexoes, loc_nSize, loc_nCount, loc_nResultado, loc_nPos

        DECLARE INTEGER RasEnumConnections IN RASAPI32.DLL ;
            STRING  @loc_cConexoes, ;
            INTEGER @loc_nSize, ;
            INTEGER @loc_nCount

        loc_cConexao  = THIS.WordToC(412) + REPLICATE(CHR(0), 408)
        loc_cConexoes = REPLICATE(loc_cConexao, 16)
        loc_nSize     = LEN(loc_cConexoes)
        loc_nCount    = 0

        loc_nResultado = RasEnumConnections(@loc_cConexoes, @loc_nSize, @loc_nCount)

        IF loc_nCount > 0
            PUBLIC ARRAY &par_cNomeArray.[loc_nCount, 4]

            FOR loc_nPos = 0 TO loc_nCount - 1
                loc_cConexao = SUBSTR(loc_cConexoes, (loc_nPos * 412) + 1, 412)

                &par_cNomeArray.[loc_nPos + 1, 1] = THIS.CToWord(SUBSTR(loc_cConexao, 5, 4))
                &par_cNomeArray.[loc_nPos + 1, 2] = STRTRAN(SUBSTR(loc_cConexao, 9, 257), CHR(0))
                &par_cNomeArray.[loc_nPos + 1, 3] = STRTRAN(SUBSTR(loc_cConexao, 266, 17), CHR(0))
                &par_cNomeArray.[loc_nPos + 1, 4] = STRTRAN(SUBSTR(loc_cConexao, 283, 129), CHR(0))
            ENDFOR
        ENDIF

        RETURN loc_nCount
    ENDPROC

    *==========================================================================
    * RasConexao - Enumera as conexoes Dial-Up CADASTRADAS no Windows (todas,
    * ativas ou nao) via RAS API (equivalente ao PROCEDURE rasENTRADAS do
    * legado - RasEnumEntries; o PROCEDURE rasconexao legado, que DISCA via
    * RasDial, e o rashangup, que derruba a linha, sao codigo MORTO no legado:
    * nenhum Click nem metodo os chama - quem disca e derruba e o
    * "RUN /N Rundll Rnaui.dll,RnaDial" de cmdconect.Click e do Release, ja
    * transcrito em BtnRedeDialupClick e Destroy). Devolve a quantidade de
    * conexoes cadastradas e preenche o
    * array PUBLIC cujo nome e passado em par_cNomeArray com o nome de cada
    * conexao - fonte do RowSource de cbo_4c_Provedor.
    *==========================================================================
    PROTECTED PROCEDURE RasConexao(par_cNomeArray)
        LOCAL loc_cEntradaVazia, loc_cEntradas, loc_nTamanho, loc_nEntradas, ;
            loc_nResultado, loc_cEntrada, loc_nPos

        #DEFINE RAS_MAXENTRYNAME_CX 256

        DECLARE INTEGER RasEnumEntries IN RASAPI32.DLL ;
            INTEGER reserved, ;
            STRING  PhoneBox, ;
            STRING  @loc_cEntradas, ;
            INTEGER @loc_nTamanho, ;
            INTEGER @loc_nEntradas

        loc_cEntradaVazia = THIS.WordToC(264) + REPLICATE(CHR(0), RAS_MAXENTRYNAME_CX)
        loc_cEntradas     = REPLICATE(loc_cEntradaVazia, 255)
        loc_nTamanho      = LEN(loc_cEntradas)
        loc_nEntradas     = 0

        loc_nResultado = RasEnumEntries(0, "", @loc_cEntradas, @loc_nTamanho, @loc_nEntradas)

        IF loc_nEntradas = 0
            RETURN 0
        ENDIF

        RELEASE &par_cNomeArray.
        PUBLIC ARRAY &par_cNomeArray.[loc_nEntradas]

        FOR loc_nPos = 0 TO loc_nEntradas - 1
            loc_cEntrada = SUBSTR(loc_cEntradas, (264 * loc_nPos) + 1, 264)
            &par_cNomeArray.[loc_nPos + 1] = SUBSTR(loc_cEntrada, 5, AT(CHR(0), SUBSTR(loc_cEntrada, 5)) - 1)
        ENDFOR

        RETURN loc_nEntradas
    ENDPROC

    *==========================================================================
    * CarregarDados - Carga de dados do form: lista o diretorio REMOTO do
    * servidor FTP (WinInet: InternetOpen -> InternetConnect ->
    * FtpSetCurrentDirectory -> FtpFindFirstFile/InternetFindNextFile) e
    * popula cursor_4c_FtpServer, que e a fonte de todo o lado "FTP" da tela.
    * Transcricao do PROCEDURE getftpdirectory do legado.
    *
    * par_cDirRemoto : pasta no servidor FTP a listar
    * par_cMascara   : mascara de arquivos (ex.: "*.*")
    * Retorna .T. quando a listagem foi obtida (cursor_4c_FtpServer populado)
    *==========================================================================
    PROCEDURE CarregarDados(par_cDirRemoto, par_cMascara)
        LOCAL loc_nInternet, loc_nFtp, loc_cTempDir, loc_cDiretorio, loc_cMascara
        LOCAL loc_cStruct, loc_nHandle, loc_nResultCode, loc_nResult, loc_lManual
        LOCAL loc_nFResult, loc_lSucesso, loc_cNulo

        #DEFINE ERROR_NO_MORE_FILES_FTP        18
        #DEFINE INTERNET_OPEN_TYPE_DIRECT_FTP   1
        #DEFINE INTERNET_DEFAULT_FTP_PORT_FTP  21
        #DEFINE INTERNET_SERVICE_FTP_FTP        1
        #DEFINE INTERNET_FLAG_PASSIVE_FTP 14217728
        #DEFINE MAX_PATH_FTP                  260

        loc_cNulo    = CHR(0)
        loc_lSucesso = .F.
        loc_lManual  = .F.
        loc_nInternet = 0
        loc_nFtp      = 0

        DECLARE INTEGER FtpFindFirstFile IN WinInet ;
            INTEGER nConnect_Handle, STRING @lpcSearchStr, ;
            STRING @lpcWIN32_FIND_DATA, INTEGER nFlags, INTEGER nContext

        DECLARE INTEGER InternetFindNextFile IN WinInet ;
            INTEGER nConnect_Handle, STRING @lpcWIN32_FIND_DATA

        DECLARE LONG InternetOpen IN "wininet.dll" ;
            STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
            STRING lpszProxyBypass, LONG dwFlags

        DECLARE LONG InternetConnect IN "wininet.dll" ;
            LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
            STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
            LONG dwFlags, LONG dwContext

        DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet

        DECLARE LONG GetLastError IN WIN32API

        DECLARE INTEGER FtpGetCurrentDirectory IN WinInet ;
            INTEGER nConnect_Handle, STRING @lpcDirectory, INTEGER @nMax_Path

        DECLARE INTEGER FtpSetCurrentDirectory IN "wininet.dll" ;
            LONG hFtpSession, STRING lpszDirectory

        loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_FTP, "", "", 0)

        IF loc_nInternet = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            MsgErro("Erro na conex" + CHR(227) + "o com o servidor." + CHR(13) + ;
                THIS.InErrorCase(GetLastError()), "FTP")
        ELSE
            loc_nFtp = InternetConnect(loc_nInternet, ;
                THIS.this_oBusinessObject.this_cFtpAdd, ;
                INTERNET_DEFAULT_FTP_PORT_FTP, ;
                THIS.this_oBusinessObject.this_cFtpUser, ;
                THIS.this_oBusinessObject.this_cFtpPass, ;
                INTERNET_SERVICE_FTP_FTP, INTERNET_FLAG_PASSIVE_FTP, 0)

            IF loc_nFtp = 0
                THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
                    ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
                MsgErro("Erro na conex" + CHR(227) + "o com o servidor FTP." + CHR(13) + ;
                    THIS.InErrorCase(GetLastError()), "FTP")
                InternetCloseHandle(loc_nInternet)
            ELSE
                loc_cTempDir = SPACE(MAX_PATH_FTP)

                FtpSetCurrentDirectory(loc_nFtp, par_cDirRemoto)
                loc_nFResult = FtpGetCurrentDirectory(loc_nFtp, @loc_cTempDir, MAX_PATH_FTP)

                loc_cDiretorio = LEFT(loc_cTempDir, AT(loc_cNulo, loc_cTempDir) - 1)

                IF loc_nFResult <> 1
                    InternetCloseHandle(loc_nFtp)
                    InternetCloseHandle(loc_nInternet)
                ELSE
                    loc_cMascara = par_cMascara + loc_cNulo
                    loc_cStruct  = SPACE(319)

                    loc_nHandle     = FtpFindFirstFile(loc_nFtp, @loc_cMascara, @loc_cStruct, 0, 0)
                    loc_nResultCode = GetLastError()

                    IF loc_nHandle = 0 AND loc_nResultCode = ERROR_NO_MORE_FILES_FTP AND loc_nFtp > 0
                        *-- Diretorio remoto existe mas esta VAZIO: o legado
                        *-- monta uma entrada ficticia "." para o cursor nao
                        *-- ficar inexistente
                        loc_lManual  = .T.
                        loc_lSucesso = .T.
                    ELSE
                        IF loc_nHandle = 0 OR loc_nResultCode = ERROR_NO_MORE_FILES_FTP
                            InternetCloseHandle(loc_nFtp)
                            InternetCloseHandle(loc_nInternet)
                            THIS.Inf("Conex" + CHR(227) + "o terminada - " + ;
                                ALLTRIM(THIS.InErrorCase(GetLastError())) + ;
                                " Handle = " + ALLTRIM(STR(loc_nHandle)), "R")
                        ELSE
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF

                    IF loc_lSucesso
                        IF USED("cursor_4c_FtpServer")
                            USE IN cursor_4c_FtpServer
                        ENDIF

                        SET NULL ON
                        CREATE CURSOR cursor_4c_FtpServer ( ;
                            nome C(240), ;
                            tipo C(10), ;
                            tama C(10), ;
                            data C(16), ;
                            atri C(10))
                        SET NULL OFF

                        INDEX ON nome TAG nome
                        SET ORDER TO nome

                        IF loc_lManual
                            INSERT INTO cursor_4c_FtpServer (nome, tipo, tama, data, atri) ;
                                VALUES (".", "Diret" + CHR(243) + "rio", STR(0), DTOC(DATE()), "D")
                        ELSE
                            THIS.CrackFile(loc_cStruct)

                            loc_nResult = 1

                            DO WHILE loc_nResultCode <> ERROR_NO_MORE_FILES_FTP AND loc_nResult <> 0
                                loc_cStruct     = SPACE(319)
                                loc_nResult     = InternetFindNextFile(loc_nHandle, @loc_cStruct)
                                loc_nResultCode = GetLastError()

                                IF loc_nResultCode <> ERROR_NO_MORE_FILES_FTP AND loc_nResult <> 0
                                    THIS.CrackFile(loc_cStruct)
                                ENDIF
                            ENDDO
                        ENDIF

                        SELECT cursor_4c_FtpServer
                        GO TOP
                    ENDIF

                    InternetCloseHandle(loc_nFtp)
                    InternetCloseHandle(loc_nInternet)
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CrackFile - Desmonta uma estrutura WIN32_FIND_DATA devolvida pelo
    * WinInet e grava a linha correspondente em cursor_4c_FtpServer
    * (transcricao do PROCEDURE crackfile do legado)
    *==========================================================================
    PROTECTED PROCEDURE CrackFile(par_cString)
        LOCAL loc_cArquivo, loc_nSizeHigh, loc_nSizeLow, loc_nTamanho
        LOCAL loc_cTipo, loc_cAtributos, loc_cBufferData, loc_cDataGravacao
        LOCAL loc_cNulo, loc_nPosNulo

        #DEFINE BYTE_1_CF                     1
        #DEFINE BYTE_2_CF                   256
        #DEFINE BYTE_3_CF                 65536
        #DEFINE BYTE_4_CF              16777216
        #DEFINE MAXDWORD_CF          4294967295
        #DEFINE FILE_ATTRIBUTE_DIRECTORY_CF  16
        #DEFINE MAX_PATH_CF                 260

        loc_cNulo = CHR(0)

        loc_cArquivo = SUBSTR(par_cString, 45, MAX_PATH_CF)
        loc_nPosNulo = AT(loc_cNulo, loc_cArquivo)

        IF loc_nPosNulo > 1
            loc_cArquivo = LEFT(loc_cArquivo, loc_nPosNulo - 1)
        ENDIF

        *-- Tamanho do arquivo (dois DWORD)
        loc_nSizeHigh = (ASC(SUBSTR(par_cString, 29, 1)) * BYTE_1_CF) + ;
                        (ASC(SUBSTR(par_cString, 30, 1)) * BYTE_2_CF) + ;
                        (ASC(SUBSTR(par_cString, 31, 1)) * BYTE_3_CF) + ;
                        (ASC(SUBSTR(par_cString, 32, 1)) * BYTE_4_CF)

        loc_nSizeLow  = (ASC(SUBSTR(par_cString, 33, 1)) * BYTE_1_CF) + ;
                        (ASC(SUBSTR(par_cString, 34, 1)) * BYTE_2_CF) + ;
                        (ASC(SUBSTR(par_cString, 35, 1)) * BYTE_3_CF) + ;
                        (ASC(SUBSTR(par_cString, 36, 1)) * BYTE_4_CF)

        loc_nTamanho = (loc_nSizeHigh * MAXDWORD_CF) + loc_nSizeLow

        IF THIS.CToWord(SUBSTR(par_cString, 1, 4)) = FILE_ATTRIBUTE_DIRECTORY_CF
            loc_cTipo = "Diret" + CHR(243) + "rio"
        ELSE
            loc_cTipo = "Arquivo"
        ENDIF

        *-- Data de gravacao (o legado le create/access/write e so usa write)
        loc_cBufferData   = SUBSTR(par_cString, 21, 8)
        loc_cDataGravacao = THIS.CrackDate(loc_cBufferData)

        loc_cAtributos = THIS.CrackAttributes(LEFT(par_cString, 4))

        INSERT INTO cursor_4c_FtpServer (nome, tipo, tama, data, atri) ;
            VALUES (ALLTRIM(loc_cArquivo), ;
                    ALLTRIM(loc_cTipo), ;
                    TRANSFORM(loc_nTamanho, "9999999999"), ;
                    loc_cDataGravacao, ;
                    loc_cAtributos)
    ENDPROC

    *==========================================================================
    * CrackDate - Converte um FILETIME (8 bytes) na data formatada dd/mm/aaaa
    * (transcricao do PROCEDURE crackdate do legado, que desconsidera a hora)
    *==========================================================================
    PROTECTED PROCEDURE CrackDate(par_cBuffer)
        LOCAL loc_cEntrada, loc_nResultado, loc_nDia, loc_nMes, loc_nAno, loc_cData

        #DEFINE BYTE_2_CD 256

        DECLARE INTEGER FileTimeToSystemTime IN Kernel32 ;
            STRING @lpcBuffer, STRING @lpcBuffer2

        loc_cEntrada   = SPACE(16)
        loc_nResultado = FileTimeToSystemTime(@par_cBuffer, @loc_cEntrada)

        IF loc_nResultado = 0
            *-- Falhou: data default do legado
            loc_cData = "1901/01/01"
        ELSE
            loc_nAno = ASC(SUBSTR(loc_cEntrada, 1, 1)) + (ASC(SUBSTR(loc_cEntrada, 2, 1)) * BYTE_2_CD)
            loc_nMes = ASC(SUBSTR(loc_cEntrada, 3, 1)) + (ASC(SUBSTR(loc_cEntrada, 4, 1)) * BYTE_2_CD)
            loc_nDia = ASC(SUBSTR(loc_cEntrada, 7, 1)) + (ASC(SUBSTR(loc_cEntrada, 8, 1)) * BYTE_2_CD)

            loc_cData = PADL(ALLTRIM(STR(loc_nDia)), 2, "0") + "/" + ;
                        PADL(ALLTRIM(STR(loc_nMes)), 2, "0") + "/" + ;
                        ALLTRIM(STR(loc_nAno))
        ENDIF

        RETURN loc_cData
    ENDPROC

    *==========================================================================
    * CrackAttributes - Traduz os 4 bytes de atributos do WIN32_FIND_DATA na
    * letra correspondente (transcricao do PROCEDURE crackattributes do
    * legado - DO CASE, portanto devolve APENAS o primeiro atributo que casar)
    *==========================================================================
    PROTECTED PROCEDURE CrackAttributes(par_cBuffer)
        LOCAL loc_cAtributos, loc_nValor

        #DEFINE BYTE_1_CA                      1
        #DEFINE BYTE_2_CA                    256
        #DEFINE BYTE_3_CA                  65536
        #DEFINE BYTE_4_CA               16777216

        #DEFINE BIT_ATTRIBUTE_READONLY_CA      0
        #DEFINE BIT_ATTRIBUTE_HIDDEN_CA        1
        #DEFINE BIT_ATTRIBUTE_SYSTEM_CA        2
        #DEFINE BIT_ATTRIBUTE_DIRECTORY_CA     4
        #DEFINE BIT_ATTRIBUTE_ARCHIVE_CA       5
        #DEFINE BIT_ATTRIBUTE_NORMAL_CA        7
        #DEFINE BIT_ATTRIBUTE_TEMPORARY_CA     8
        #DEFINE BIT_ATTRIBUTE_COMPRESSED_CA   11
        #DEFINE BIT_ATTRIBUTE_OFFLINE_CA      12

        loc_cAtributos = ""

        loc_nValor = (ASC(SUBSTR(par_cBuffer, 1, 1)) * BYTE_1_CA) + ;
                     (ASC(SUBSTR(par_cBuffer, 2, 1)) * BYTE_2_CA) + ;
                     (ASC(SUBSTR(par_cBuffer, 3, 1)) * BYTE_3_CA) + ;
                     (ASC(SUBSTR(par_cBuffer, 4, 1)) * BYTE_4_CA)

        DO CASE
            CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_READONLY_CA)
                loc_cAtributos = loc_cAtributos + "R"
            CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_HIDDEN_CA)
                loc_cAtributos = loc_cAtributos + "H"
            CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_SYSTEM_CA)
                loc_cAtributos = loc_cAtributos + "S"
            CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_DIRECTORY_CA)
                loc_cAtributos = loc_cAtributos + "D"
            CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_ARCHIVE_CA)
                loc_cAtributos = loc_cAtributos + "A"
            CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_NORMAL_CA)
                loc_cAtributos = loc_cAtributos + "N"
            CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_TEMPORARY_CA)
                loc_cAtributos = loc_cAtributos + "T"
            CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_COMPRESSED_CA)
                loc_cAtributos = loc_cAtributos + "C"
            CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_OFFLINE_CA)
                loc_cAtributos = loc_cAtributos + "O"
        ENDCASE

        RETURN loc_cAtributos
    ENDPROC

    *==========================================================================
    * InErrorCase - Traduz o codigo devolvido por GetLastError() no nome
    * simbolico do erro WinInet/Win32 (transcricao do PROCEDURE inerrorcase
    * do legado, incluindo o formato final "[ <codigo> : <nome> ]")
    *==========================================================================
    PROTECTED PROCEDURE InErrorCase(par_nErro)
        LOCAL loc_cMensagem

        #DEFINE ERROR_INTERNET_BASE_IE 12000

        DO CASE
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 1
                loc_cMensagem = "ERROR_INTERNET_OUT_OF_HANDLES"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 2
                loc_cMensagem = "ERROR_INTERNET_TIMEOUT"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 3
                loc_cMensagem = "ERROR_INTERNET_EXTENDED_ERROR"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 4
                loc_cMensagem = "ERROR_INTERNET_INTERNAL_ERROR"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 5
                loc_cMensagem = "ERROR_INTERNET_INVALID_URL"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 6
                loc_cMensagem = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 7
                loc_cMensagem = "ERROR_INTERNET_NAME_NOT_RESOLVED"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 8
                loc_cMensagem = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 9
                loc_cMensagem = "ERROR_INTERNET_INVALID_OPTION"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 10
                loc_cMensagem = "ERROR_INTERNET_BAD_OPTION_LENGTH"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 11
                loc_cMensagem = "ERROR_INTERNET_OPTION_NOT_SETTABLE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 12
                loc_cMensagem = "ERROR_INTERNET_SHUTDOWN"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 13
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_USER_NAME"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 14
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_PASSWORD"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 15
                loc_cMensagem = "ERROR_INTERNET_LOGIN_FAILURE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 16
                loc_cMensagem = "ERROR_INTERNET_INVALID_OPERATION"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 17
                loc_cMensagem = "ERROR_INTERNET_OPERATION_CANCELLED"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 18
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_HANDLE_TYPE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 19
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_HANDLE_STATE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 20
                loc_cMensagem = "ERROR_INTERNET_NOT_PROXY_REQUEST"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 21
                loc_cMensagem = "ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 22
                loc_cMensagem = "ERROR_INTERNET_BAD_REGISTRY_PARAMETER"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 23
                loc_cMensagem = "ERROR_INTERNET_NO_DIRECT_ACCESS"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 24
                loc_cMensagem = "ERROR_INTERNET_NO_CONTEXT"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 25
                loc_cMensagem = "ERROR_INTERNET_NO_CALLBACK"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 26
                loc_cMensagem = "ERROR_INTERNET_REQUEST_PENDING"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 27
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_FORMAT"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 28
                loc_cMensagem = "ERROR_INTERNET_ITEM_NOT_FOUND"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 29
                loc_cMensagem = "ERROR_INTERNET_CANNOT_CONNECT"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 30
                loc_cMensagem = "ERROR_INTERNET_CONNECTION_ABORTED"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 31
                loc_cMensagem = "ERROR_INTERNET_CONNECTION_RESET"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 32
                loc_cMensagem = "ERROR_INTERNET_FORCE_RETRY"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 33
                loc_cMensagem = "ERROR_INTERNET_INVALID_PROXY_REQUEST"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 34
                loc_cMensagem = "ERROR_INTERNET_NEED_UI"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 36
                loc_cMensagem = "ERROR_INTERNET_HANDLE_EXISTS"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 37
                loc_cMensagem = "ERROR_INTERNET_SEC_CERT_DATE_INVALID"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 38
                loc_cMensagem = "ERROR_INTERNET_SEC_CERT_CN_INVALID"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 39
                loc_cMensagem = "ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 40
                loc_cMensagem = "ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 41
                loc_cMensagem = "ERROR_INTERNET_MIXED_SECURITY"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 42
                loc_cMensagem = "ERROR_INTERNET_CHG_POST_IS_NON_SECURE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 43
                loc_cMensagem = "ERROR_INTERNET_POST_IS_NON_SECURE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 44
                loc_cMensagem = "ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 45
                loc_cMensagem = "ERROR_INTERNET_INVALID_CA"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 46
                loc_cMensagem = "ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 47
                loc_cMensagem = "ERROR_INTERNET_ASYNC_THREAD_FAILED"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 48
                loc_cMensagem = "ERROR_INTERNET_REDIRECT_SCHEME_CHANGE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 49
                loc_cMensagem = "ERROR_INTERNET_DIALOG_PENDING"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 50
                loc_cMensagem = "ERROR_INTERNET_RETRY_DIALOG"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 52
                loc_cMensagem = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 53
                loc_cMensagem = "ERROR_INTERNET_INSERT_CDROM"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 110
                loc_cMensagem = "FTP_TRANSFER_IN_PROGRESS"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 111
                loc_cMensagem = "FTP_DROPPED"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 112
                loc_cMensagem = "FTP_NO_PASSIVE_MODE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 157
                loc_cMensagem = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 158
                loc_cMensagem = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 159
                loc_cMensagem = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 163
                loc_cMensagem = "ERROR_INTERNET_DISCONNECTED"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 164
                loc_cMensagem = "ERROR_INTERNET_SERVER_UNREACHABLE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 165
                loc_cMensagem = "ERROR_INTERNET_PROXY_SERVER_UNREACHABLE"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 166
                loc_cMensagem = "ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 167
                loc_cMensagem = "ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 169
                loc_cMensagem = "ERROR_INTERNET_SEC_INVALID_CERT"
            CASE par_nErro = ERROR_INTERNET_BASE_IE + 170
                loc_cMensagem = "ERROR_INTERNET_SEC_CERT_REVOKED"
            CASE par_nErro = 18
                loc_cMensagem = "ERROR_NO_MORE_FILES"
            CASE par_nErro = 6
                loc_cMensagem = "ERROR_INVALID_HANDLE"
            CASE par_nErro = 2
                loc_cMensagem = "ERROR_FILE_NOT_FOUND"
            CASE par_nErro = 3
                loc_cMensagem = "ERROR_PATH_NOT_FOUND"
            CASE par_nErro = 5
                loc_cMensagem = "ERROR_ACCESS_DENIED"
            CASE par_nErro = 80
                loc_cMensagem = "ERROR_FILE_EXISTS"
            CASE par_nErro = 87
                loc_cMensagem = "ERROR_INVALID_PARAMETER"
            OTHERWISE
                loc_cMensagem = "Unknown Error Message"
        ENDCASE

        loc_cMensagem = "[ " + ALLTRIM(STR(par_nErro)) + " : " + ALLTRIM(loc_cMensagem) + " ]"

        RETURN loc_cMensagem
    ENDPROC

    *==========================================================================
    * SecToHour - Formata uma quantidade de segundos como "Nh, Nm, Ns"
    * (transcricao do PROCEDURE sectohour do legado)
    *==========================================================================
    PROTECTED PROCEDURE SecToHour(par_nSegundos)
        LOCAL loc_nHora, loc_nMinuto, loc_nSegundo

        loc_nHora    = INT(par_nSegundos / 3600)
        loc_nMinuto  = MOD(INT(par_nSegundos / 60), 60)
        loc_nSegundo = MOD(par_nSegundos, 60)

        RETURN IIF(loc_nHora > 0, ALLTRIM(STR(loc_nHora)) + " h, ", "") + ;
               IIF(loc_nMinuto > 0, ALLTRIM(STR(loc_nMinuto)) + " m, ", "") + ;
               ALLTRIM(STR(loc_nSegundo)) + " s"
    ENDPROC

    *==========================================================================
    * Processa - Alimenta o grid de progresso (grd_4c_Progresso /
    * cursor_4c_Progresso) durante uma transferencia, nos 3 estagios do
    * legado: "I"=iniciando (cria a linha), "A"=em andamento (atualiza bytes
    * e percentual), "C"=concluido (fecha a linha e registra no log).
    * Transcricao do PROCEDURE processa do legado.
    *
    * DIVERGENCIA DOCUMENTADA: o legado chama ThisForm.FileCtrlUp(...) neste
    * metodo, mas o controle ActiveX que FileCtrlUp manipula (ThisForm.
    * FileControl) NAO EXISTE no SCX - nao consta da lista de objetos do
    * dump, so das linhas "With ThisForm.FileControl" do proprio FileCtrlUp.
    * Reproduzir essas chamadas geraria "Unknown member FILECONTROL" em
    * runtime, entao elas ficam de fora; o percentual segue visivel na coluna
    * Status do grid e no lbl_4c_Progresso, como no legado.
    *==========================================================================
    PROCEDURE Processa(par_cArquivo, par_nTamanho, par_cPastaLocal, ;
            par_cPastaHost, par_nTransferido, par_nBuffer, ;
            par_nSegIniciais, par_nSegundos, par_cStatus)

        LOCAL loc_nSegundos, loc_cTempoEstimado, loc_cTempoDecorrido, ;
            loc_nIndice, loc_nPos

        loc_nSegundos = par_nSegundos

        IF loc_nSegundos = 0
            *-- Valor minimo de tempo de transferencia (evita divisao por zero)
            loc_nSegundos = 0.001
        ENDIF

        IF !USED("cursor_4c_Progresso")
            RETURN
        ENDIF

        DO CASE
            CASE par_cStatus == "I"
                SELECT cursor_4c_Progresso
                APPEND BLANK
                REPLACE arquivo        WITH par_cArquivo, ;
                        tamanho        WITH par_nTamanho, ;
                        pastalocal     WITH par_cPastaLocal, ;
                        pastahost      WITH par_cPastaHost, ;
                        statusoperacao WITH "0 bytes copiados, 0% completado"

            CASE par_cStatus == "A"
                SELECT cursor_4c_Progresso
                LOCATE FOR cursor_4c_Progresso.arquivo = par_cArquivo

                IF FOUND()
                    REPLACE statusoperacao WITH ;
                        STR(par_nTransferido) + " bytes copiados, " + ;
                        STR(par_nTransferido * 100 / par_nTamanho, 3, 2) + "% completado"

                    loc_cTempoEstimado  = THIS.SecToHour(INT(((par_nTamanho - par_nTransferido) * loc_nSegundos) / par_nTransferido))
                    loc_cTempoDecorrido = THIS.SecToHour(SECONDS() - par_nSegIniciais)

                    THIS.lbl_4c_Progresso.Caption = "Tempo decorrido: " + loc_cTempoDecorrido + ;
                        "   Tempo Estimado : " + loc_cTempoEstimado
                ENDIF

            CASE par_cStatus == "C"
                SELECT cursor_4c_Progresso
                LOCATE FOR cursor_4c_Progresso.arquivo = par_cArquivo

                IF FOUND()
                    REPLACE statusoperacao WITH ;
                        STR(par_nTransferido) + " bytes copiados, " + ;
                        STR(par_nTransferido * 100 / par_nTamanho, 3, 2) + "% completado em " + ;
                        THIS.SecToHour(loc_nSegundos)

                    THIS.lbl_4c_Progresso.Caption = " Transfer" + CHR(234) + "ncia do arquivo [ " + ;
                        par_cArquivo + " ] Conclu" + CHR(237) + "da. OK"

                    THIS.Inf("Arquivo Transferido...", "B")

                    *-- "Atualiza os listbox dos arquivos" do PROCEDURE
                    *-- processa legado: registra o arquivo concluido na
                    *-- lista de DESTINO e, se configurado, apaga o arquivo
                    *-- de ORIGEM (this_lDelLocal para envio / this_lDelHost
                    *-- para recebimento) e o remove da lista de origem
                    IF par_cPastaLocal == THIS.this_oBusinessObject.this_cDirEnvFtp
                        *-- Enviando arquivos para o FTP: registra em
                        *-- lst_4c_RecLoc (pgf_4c_Ftp.Page1 "Enviados")
                        WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page1.lst_4c_RecLoc
                            loc_nIndice = .ListCount + 1
                            .AddItem(par_cArquivo, loc_nIndice, 1)
                            .AddListItem(STR(par_nTamanho), loc_nIndice, 2)
                            .AddListItem(STR(par_nTransferido), loc_nIndice, 3)
                            .Refresh()
                        ENDWITH

                        IF THIS.this_oBusinessObject.this_lDelLocal
                            THIS.Inf("Exclu" + CHR(237) + "ndo o arquivo local " + par_cPastaLocal + par_cArquivo, "B")

                            ERASE (par_cPastaLocal + par_cArquivo)

                            IF FILE(par_cPastaLocal + par_cArquivo)
                                THIS.Inf("Falha na exclus" + CHR(227) + "o do arquivo local " + par_cPastaLocal + par_cArquivo, "R")
                            ELSE
                                THIS.Inf("Arquivo Local " + par_cPastaLocal + par_cArquivo + " foi exclu" + CHR(237) + "do com sucesso", "B")
                            ENDIF

                            *-- Remove o arquivo da lista de origem (lst_4c_EnvFtp)
                            WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
                                FOR loc_nPos = 1 TO .ListCount
                                    IF UPPER(ALLTRIM(.List(loc_nPos, 1))) == UPPER(par_cArquivo)
                                        .RemoveItem(loc_nPos)
                                        EXIT
                                    ENDIF
                                ENDFOR
                            ENDWITH
                        ENDIF
                    ENDIF

                    IF par_cPastaHost == THIS.this_oBusinessObject.this_cDirEnvLoc
                        *-- Recebendo do FTP: registra em lst_4c_RecFtp
                        *-- (pgf_4c_Loc.Page2 "Recebidos")
                        WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page2.lst_4c_RecFtp
                            loc_nIndice = .ListCount + 1
                            .AddItem(par_cArquivo, loc_nIndice, 1)
                            .AddListItem(STR(par_nTamanho), loc_nIndice, 2)
                            .AddListItem(STR(par_nTransferido), loc_nIndice, 3)
                            .Refresh()
                        ENDWITH

                        IF THIS.this_oBusinessObject.this_lDelHost
                            THIS.Inf("Excluindo o arquivo FTP " + par_cPastaHost + par_cArquivo, "B")

                            IF THIS.ExcluirArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
                                    THIS.this_oBusinessObject.this_cFtpUser, ;
                                    THIS.this_oBusinessObject.this_cFtpPass, ;
                                    par_cPastaHost + par_cArquivo)
                                THIS.Inf("Arquivo FTP " + par_cPastaHost + par_cArquivo + " foi exclu" + CHR(237) + "do com sucesso", "B")
                            ELSE
                                THIS.Inf("Falha na exclus" + CHR(227) + "o do arquivo FTP " + par_cPastaHost + par_cArquivo, "R")
                            ENDIF

                            *-- Remove o arquivo da lista de origem (lst_4c_EnvLoc)
                            WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
                                FOR loc_nPos = 1 TO .ListCount
                                    IF UPPER(ALLTRIM(.List(loc_nPos, 1))) == UPPER(par_cArquivo)
                                        .RemoveItem(loc_nPos)
                                        EXIT
                                    ENDIF
                                ENDFOR
                            ENDWITH
                        ENDIF
                    ENDIF
                ENDIF
        ENDCASE

        THIS.grd_4c_Progresso.Refresh()
    ENDPROC

    *==========================================================================
    * MontaContainer - "Monta os pageframes com todos os arquivos a enviar e
    * receber" (equivalente ao PROCEDURE montacontainer do legado): carrega a
    * listagem do diretorio REMOTO (via THIS.CarregarDados), filtra pela
    * mascara this_cTpRec e povoa lst_4c_EnvLoc (Page2 "A Receber" do
    * pgf_4c_Ftp), e lista a pasta LOCAL de envio em lst_4c_EnvFtp,
    * registrando no log o mesmo roteiro do legado.
    *
    * DIVERGENCIA DOCUMENTADA (fiel ao legado, nao simplificada): o cursor
    * remoto (cursor_4c_FtpServer) nao pode ser filtrado por wildcard
    * diretamente - o legado grava cada NOME num arquivo VAZIO dentro de uma
    * pasta TEMPORARIA (Strtofile) e roda ADIR com a mascara this_cTpRec
    * sobre essa pasta, ja que ADIR so filtra arquivos REAIS em disco.
    * Reproduzido aqui com SYS(2023) (pasta temp do Windows) + MKDIR +
    * STRTOFILE + ADIR + ERASE, na MESMA ordem - necessario porque
    * this_cTpRec vem da configuracao da empresa (SigCdEmp) e PODE nao ser
    * "*.*".
    *==========================================================================
    PROTECTED PROCEDURE MontaContainer()
        LOCAL loc_lSucesso, loc_nArquivosLocais, loc_nPos, loc_cPastaTemp, ;
            loc_cDefaultAnterior, loc_nArquivosMascara, loc_nCont, loc_nItem
        LOCAL ARRAY loc_aArquivosLocais[1], loc_aArquivosMascara[1]

        loc_lSucesso = .T.

        THIS.Inf("Carregando os par" + CHR(226) + "metros da tela... Aguarde", "B")

        *-- A Receber do Host: lista o diretorio REMOTO no servidor FTP e
        *-- filtra pela mascara this_cTpRec antes de povoar lst_4c_EnvLoc
        IF !EMPTY(THIS.this_oBusinessObject.this_cDirEnvLoc)
            THIS.Inf("Estabelecendo uma conex" + CHR(227) + "o com o servidor FTP no endere" + CHR(231) + "o " + ;
                THIS.this_oBusinessObject.this_cFtpAdd, "B")

            IF THIS.CarregarDados(THIS.this_oBusinessObject.this_cDirEnvLoc, "*.*") AND USED("cursor_4c_FtpServer")
                THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc.Clear()

                loc_cDefaultAnterior = SYS(5) + SYS(2003)
                loc_cPastaTemp       = ADDBS(SYS(2023)) + SYS(3)
                MKDIR (loc_cPastaTemp)
                SET DEFAULT TO (loc_cPastaTemp)

                SELECT cursor_4c_FtpServer
                SCAN
                    =STRTOFILE("1", cursor_4c_FtpServer.nome)
                ENDSCAN

                loc_nArquivosMascara = ADIR(loc_aArquivosMascara, ALLTRIM(THIS.this_oBusinessObject.this_cTpRec))

                loc_nItem = 0
                FOR loc_nCont = 1 TO loc_nArquivosMascara
                    SELECT cursor_4c_FtpServer
                    LOCATE FOR ALLTRIM(UPPER(cursor_4c_FtpServer.nome)) = ALLTRIM(UPPER(loc_aArquivosMascara[loc_nCont, 1]))
                    IF FOUND() AND SUBSTR(cursor_4c_FtpServer.tipo, 1, 1) == "A"
                        loc_nItem = loc_nItem + 1
                        WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
                            .AddItem(ALLTRIM(cursor_4c_FtpServer.nome), loc_nItem, 1)
                            .AddListItem(cursor_4c_FtpServer.tama, loc_nItem, 2)
                            .AddListItem(cursor_4c_FtpServer.data, loc_nItem, 3)
                        ENDWITH
                    ENDIF
                ENDFOR

                *-- Apaga os arquivos ficticios e, se a pasta ficou vazia, a
                *-- propria pasta temporaria
                FOR loc_nCont = 1 TO ADIR(loc_aArquivosMascara)
                    ERASE (loc_aArquivosMascara[loc_nCont, 1])
                ENDFOR
                IF ADIR(loc_aArquivosMascara) = 0
                    SET DEFAULT TO (SYS(2023))
                    RMDIR (loc_cPastaTemp)
                ENDIF

                SET DEFAULT TO (loc_cDefaultAnterior)

                THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc.Refresh()

                THIS.Inf("Lista de arquivos do servidor j" + CHR(225) + " recebida do " + ;
                    THIS.this_oBusinessObject.this_cFtpAdd, "B")
                THIS.Inf("Pronto para a Transfer" + CHR(234) + "ncia... Clique no bot" + CHR(227) + "o (Transfere/Recebe)", "G")
            ELSE
                THIS.Inf("Lista de arquivos do servidor N" + CHR(227) + "O foi recebida do " + ;
                    THIS.this_oBusinessObject.this_cFtpAdd, "R")
                THIS.Inf("Problema na Transfer" + CHR(234) + "ncia...", "R")
                loc_lSucesso = .F.
            ENDIF
        ENDIF

        *-- Local -> Host (A Enviar para o Host): lista a pasta LOCAL de onde
        *-- os arquivos saem e povoa lst_4c_EnvFtp (equivalente ao bloco
        *-- "Local -> Host" do PROCEDURE montacontainer legado - nome,
        *-- tamanho e data de cada arquivo, ordenados por nome)
        IF loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp)
            THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp.Clear()

            loc_nArquivosLocais = ADIR(loc_aArquivosLocais, ;
                ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvFtp)) + ;
                ALLTRIM(THIS.this_oBusinessObject.this_cTpEnv))

            IF loc_nArquivosLocais > 0
                ASORT(loc_aArquivosLocais)

                FOR loc_nPos = 1 TO loc_nArquivosLocais
                    WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
                        .AddItem(loc_aArquivosLocais[loc_nPos, 1], loc_nPos, 1)
                        .AddListItem(STR(loc_aArquivosLocais[loc_nPos, 2], 10, 0), loc_nPos, 2)
                        .AddListItem(DTOC(loc_aArquivosLocais[loc_nPos, 3]), loc_nPos, 3)
                    ENDWITH
                ENDFOR
            ENDIF

            THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp.Refresh()

            THIS.Inf("Lista de arquivos Locais j" + CHR(225) + " carregada do " + ;
                THIS.this_oBusinessObject.this_cDirEnvFtp, "B")
            THIS.Inf("Pronto para a Transfer" + CHR(234) + "ncia... Clique no bot" + CHR(227) + "o (Transfere)", "G")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VerificarArquivoFtp - Confirma que um arquivo existe no servidor FTP,
    * tentando abri-lo para leitura (equivalente ao PROCEDURE rasfile do
    * legado). Usado antes de receber um arquivo e, apos o envio, para
    * confirmar que o arquivo renomeado ficou disponivel no destino.
    *==========================================================================
    PROTECTED FUNCTION VerificarArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)
        LOCAL loc_nInternet, loc_nFtp, loc_nArquivoFtp, loc_lOk

        #DEFINE INTERNET_OPEN_TYPE_DIRECT_VF   1
        #DEFINE INTERNET_DEFAULT_FTP_PORT_VF  21
        #DEFINE INTERNET_SERVICE_FTP_VF        1
        #DEFINE INTERNET_FLAG_PASSIVE_VF 14217728
        #DEFINE FTP_TRANSFER_TYPE_BINARY_VF    2
        #DEFINE GENERIC_READ_VF       2147483648

        loc_lOk = .F.

        DECLARE LONG InternetOpen IN "wininet.dll" ;
            STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
            STRING lpszProxyBypass, LONG dwFlags

        DECLARE LONG InternetConnect IN "wininet.dll" ;
            LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
            STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
            LONG dwFlags, LONG dwContext

        DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet

        DECLARE LONG GetLastError IN WIN32API

        DECLARE LONG FtpOpenFile IN "wininet.dll" ;
            LONG hFtpSession, STRING lpszFileName, INTEGER fdwAccess, ;
            INTEGER dwFlags, INTEGER dwContext

        THIS.Inf("Estabelecendo uma conex" + CHR(227) + "o com a Internet", "G")
        loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_VF, "", "", 0)

        IF loc_nInternet = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            RETURN .F.
        ENDIF
        THIS.Inf("Conex" + CHR(227) + "o com a Internet aberta com o n" + CHR(250) + "mero: " + TRANSFORM(loc_nInternet), "G")

        loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_VF, ;
            par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_VF, INTERNET_FLAG_PASSIVE_VF, 0)

        IF loc_nFtp = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            InternetCloseHandle(loc_nInternet)
            RETURN .F.
        ENDIF
        THIS.Inf("Abrindo uma sess" + CHR(227) + "o FTP com o ID: " + TRANSFORM(loc_nFtp), "G")

        THIS.Inf("Verificando a exist" + CHR(234) + "ncia do arquivo " + ALLTRIM(par_cArquivoRemoto) + ;
            " da sess" + CHR(227) + "o FTP " + TRANSFORM(loc_nFtp) + " em " + par_cFtpAdd, "G")

        loc_nArquivoFtp = FtpOpenFile(loc_nFtp, par_cArquivoRemoto, GENERIC_READ_VF, FTP_TRANSFER_TYPE_BINARY_VF, 0)

        IF loc_nArquivoFtp = 0
            THIS.Inf("Arquivo " + ALLTRIM(par_cArquivoRemoto) + " da sess" + CHR(227) + "o FTP " + ;
                TRANSFORM(loc_nFtp) + " em " + par_cFtpAdd + " n" + CHR(227) + "o pude ser aberto... Erro", "R")
            loc_lOk = .F.
        ELSE
            THIS.Inf("Arquivo " + ALLTRIM(par_cArquivoRemoto) + " em " + par_cFtpAdd + " verificado com sucesso...", "G")
            loc_lOk = .T.
            InternetCloseHandle(loc_nArquivoFtp)
        ENDIF

        THIS.Inf("Fechando a sess" + CHR(227) + "o deste arquivo... Aguarde...", "B")
        InternetCloseHandle(loc_nFtp)
        InternetCloseHandle(loc_nInternet)

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * RenomearArquivoFtp - Renomeia um arquivo no servidor FTP (equivalente ao
    * PROCEDURE renameftpfile do legado). Usado por EnviarArquivoFtp para
    * restaurar o nome definitivo do arquivo apos o upload do temporario.
    *==========================================================================
    PROTECTED FUNCTION RenomearArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoAntigo, par_cArquivoNovo)
        LOCAL loc_nInternet, loc_nFtp, loc_nResultado, loc_cAntigo, loc_cNovo

        #DEFINE INTERNET_OPEN_TYPE_DIRECT_NF   1
        #DEFINE INTERNET_DEFAULT_FTP_PORT_NF  21
        #DEFINE INTERNET_SERVICE_FTP_NF        1
        #DEFINE INTERNET_FLAG_PASSIVE_NF 14217728

        DECLARE LONG InternetOpen IN "wininet.dll" ;
            STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
            STRING lpszProxyBypass, LONG dwFlags

        DECLARE LONG InternetConnect IN "wininet.dll" ;
            LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
            STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
            LONG dwFlags, LONG dwContext

        DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet

        DECLARE LONG GetLastError IN WIN32API

        DECLARE INTEGER FtpRenameFile IN WinInet ;
            INTEGER nConnect_Handle, STRING @lpcRemoteFile, STRING @lpcNewFile

        loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_NF, "", "", 0)
        IF loc_nInternet = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            RETURN .F.
        ENDIF

        loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_NF, ;
            par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_NF, INTERNET_FLAG_PASSIVE_NF, 0)
        IF loc_nFtp = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            InternetCloseHandle(loc_nInternet)
            RETURN .F.
        ENDIF

        loc_cAntigo = LOWER(ALLTRIM(par_cArquivoAntigo)) + CHR(0)
        loc_cNovo   = LOWER(ALLTRIM(par_cArquivoNovo)) + CHR(0)

        loc_nResultado = FtpRenameFile(loc_nFtp, @loc_cAntigo, @loc_cNovo)

        InternetCloseHandle(loc_nFtp)
        InternetCloseHandle(loc_nInternet)

        RETURN (loc_nResultado = 1)
    ENDFUNC

    *==========================================================================
    * ExcluirArquivoFtp - Apaga um arquivo no servidor FTP (equivalente ao
    * PROCEDURE deleteftpfile do legado), tentando por ate 60 segundos.
    * Usado por Processa quando this_lDelHost esta ativo.
    *==========================================================================
    PROTECTED FUNCTION ExcluirArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)
        LOCAL loc_nInternet, loc_nFtp, loc_cArquivo, loc_nResultado, ;
            loc_lContinua, loc_tSegIni, loc_tSegFim

        #DEFINE INTERNET_OPEN_TYPE_DIRECT_XF   1
        #DEFINE INTERNET_DEFAULT_FTP_PORT_XF  21
        #DEFINE INTERNET_SERVICE_FTP_XF        1
        #DEFINE INTERNET_FLAG_PASSIVE_XF 14217728

        DECLARE LONG InternetOpen IN "wininet.dll" ;
            STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
            STRING lpszProxyBypass, LONG dwFlags

        DECLARE LONG InternetConnect IN "wininet.dll" ;
            LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
            STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
            LONG dwFlags, LONG dwContext

        DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet

        DECLARE LONG GetLastError IN WIN32API

        DECLARE INTEGER FtpDeleteFile IN WinInet ;
            INTEGER nConnect_Handle, STRING @lpcFileName

        loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_XF, "", "", 0)
        IF loc_nInternet = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            RETURN .F.
        ENDIF

        loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_XF, ;
            par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_XF, INTERNET_FLAG_PASSIVE_XF, 0)
        IF loc_nFtp = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            InternetCloseHandle(loc_nInternet)
            RETURN .F.
        ENDIF

        loc_cArquivo   = par_cArquivoRemoto + CHR(0)
        loc_nResultado = 0
        loc_lContinua  = .T.
        loc_tSegIni    = DATETIME()

        DO WHILE loc_lContinua
            loc_nResultado = FtpDeleteFile(loc_nFtp, @loc_cArquivo)
            loc_tSegFim    = DATETIME()
            loc_lContinua  = (!(loc_nResultado == 1) AND (loc_tSegFim - loc_tSegIni) < 60)
        ENDDO

        InternetCloseHandle(loc_nFtp)
        InternetCloseHandle(loc_nInternet)

        RETURN (loc_nResultado = 1)
    ENDFUNC

    *==========================================================================
    * EnviarArquivoFtp - Envia um arquivo LOCAL para o servidor FTP
    * (equivalente ao PROCEDURE rasftpput do legado): sobe o conteudo com
    * FtpPutFile sob um nome TEMPORARIO (extensao trocada por ".ftp"),
    * dispara o Processa "I"/"A" em torno do upload e, tendo sucesso, renomeia
    * o temporario para o nome definitivo e confirma a existencia final com
    * VerificarArquivoFtp.
    *
    * DIVERGENCIA DOCUMENTADA: o legado, apos renomear, ainda chama
    * ThisForm.raslisarq(...) para recarregar uma listagem completa do
    * diretorio remoto (cursor "ftpserver", nao utilizado por nenhum outro
    * ponto do form) so para obter um booleano de confirmacao - na pratica
    * sempre .T. quando a conexao permanece de pe, exatamente a mesma garantia
    * que VerificarArquivoFtp ja fornece de forma direta. Reproduzir essa
    * listagem completa duplicaria CarregarDados/CrackFile sem mudar o
    * resultado observavel (loc_lOk), entao o passo fica resumido a
    * VerificarArquivoFtp - mantendo o efeito (confirmar sucesso do envio),
    * sem inventar comportamento novo.
    *==========================================================================
    PROTECTED FUNCTION EnviarArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoLocal, par_cArquivoRemoto)
        LOCAL loc_nInternet, loc_nFtp, loc_cArquivoTemp, loc_nTamanho, ;
            loc_nSegIni, loc_nSegFim, loc_lOk

        #DEFINE INTERNET_OPEN_TYPE_DIRECT_EF   1
        #DEFINE INTERNET_DEFAULT_FTP_PORT_EF  21
        #DEFINE INTERNET_SERVICE_FTP_EF        1
        #DEFINE INTERNET_FLAG_PASSIVE_EF 14217728
        #DEFINE FTP_TRANSFER_TYPE_BINARY_EF    2

        loc_lOk = .F.

        DECLARE LONG InternetOpen IN "wininet.dll" ;
            STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
            STRING lpszProxyBypass, LONG dwFlags

        DECLARE LONG InternetConnect IN "wininet.dll" ;
            LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
            STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
            LONG dwFlags, LONG dwContext

        DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet

        DECLARE LONG GetLastError IN WIN32API

        DECLARE INTEGER FtpPutFile IN "wininet.dll" ;
            LONG hFtpSession, STRING lpszLocalFile, STRING lpszNewRemoteFile, ;
            LONG dwFlags, LONG dwContext

        loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_EF, "", "", 0)
        IF loc_nInternet = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            RETURN .F.
        ENDIF

        loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_EF, ;
            par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_EF, INTERNET_FLAG_PASSIVE_EF, 0)
        IF loc_nFtp = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            InternetCloseHandle(loc_nInternet)
            RETURN .F.
        ENDIF

        IF !FILE(par_cArquivoLocal)
            THIS.Inf("O arquivo local " + ALLTRIM(par_cArquivoLocal) + " em " + ;
                THIS.this_oBusinessObject.this_cDirEnvFtp + " n" + CHR(227) + "o existe. Por favor verifique.", "R")
            THIS.Inf("Transfer" + CHR(234) + "ncia cancelada!", "R")
            InternetCloseHandle(loc_nFtp)
            InternetCloseHandle(loc_nInternet)
            RETURN .F.
        ENDIF

        THIS.Inf("Iniciando sess" + CHR(227) + "o para o arquivo " + ALLTRIM(par_cArquivoRemoto) + ;
            " na sess" + CHR(227) + "o FTP " + TRANSFORM(loc_nFtp) + " em " + par_cFtpAdd, "G")

        *-- Renomeia o arquivo para temporario ate completar a transferencia
        loc_cArquivoTemp = LEFT(par_cArquivoRemoto, LEN(par_cArquivoRemoto) - 3) + "ftp"
        THIS.Inf("Criando arquivo tempor" + CHR(225) + "rio na sess" + CHR(227) + "o FTP. Arquivo : " + loc_cArquivoTemp, "B")

        loc_nTamanho = LEN(FILETOSTR(par_cArquivoLocal))
        loc_nSegIni  = SECONDS()

        THIS.Processa(JUSTFNAME(par_cArquivoLocal), loc_nTamanho, ;
            THIS.this_oBusinessObject.this_cDirEnvFtp, THIS.this_oBusinessObject.this_cDirRecLoc, ;
            0, 0, 0, 0, "I")

        loc_lOk = (FtpPutFile(loc_nFtp, par_cArquivoLocal, loc_cArquivoTemp, FTP_TRANSFER_TYPE_BINARY_EF, 0) = 1)

        IF loc_lOk
            loc_nSegFim = SECONDS()
            THIS.Processa(JUSTFNAME(par_cArquivoLocal), loc_nTamanho, ;
                THIS.this_oBusinessObject.this_cDirEnvFtp, THIS.this_oBusinessObject.this_cDirRecLoc, ;
                loc_nTamanho, loc_nTamanho, loc_nSegIni, loc_nSegFim, "A")
        ELSE
            THIS.Inf("Arquivo n" + CHR(227) + "o pode ser gravado na " + CHR(225) + "rea FTP especificada. Transfer" + CHR(234) + "ncia cancelada!", "R")
        ENDIF

        InternetCloseHandle(loc_nFtp)
        InternetCloseHandle(loc_nInternet)

        IF loc_lOk
            THIS.Inf("Renomeando arquivo tempor" + CHR(225) + "rio [ " + loc_cArquivoTemp + " ] para [ " + par_cArquivoRemoto, "B")

            IF THIS.RenomearArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, loc_cArquivoTemp, UPPER(par_cArquivoRemoto))
                THIS.Inf("Arquivo renomeado para [ " + par_cArquivoRemoto + " ] com sucesso", "B")
            ELSE
                THIS.Inf("Falha na renomea" + CHR(231) + CHR(227) + "o do arquivo para [ " + par_cArquivoRemoto + " ]. Erro", "R")
            ENDIF

            loc_lOk = THIS.VerificarArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)

            IF loc_lOk
                loc_nSegFim = SECONDS()
                THIS.Processa(JUSTFNAME(par_cArquivoLocal), loc_nTamanho, ;
                    THIS.this_oBusinessObject.this_cDirEnvFtp, THIS.this_oBusinessObject.this_cDirRecLoc, ;
                    loc_nTamanho, 0, loc_nSegIni, loc_nSegFim - loc_nSegIni, "C")
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * ReceberArquivoFtp - Recebe um arquivo do servidor FTP para uma pasta
    * LOCAL (equivalente ao PROCEDURE rasftpget do legado): baixa o conteudo
    * com FtpGetFile sob um nome LOCAL temporario (extensao trocada por
    * ".ftp") e, tendo sucesso, renomeia para o nome definitivo.
    *==========================================================================
    PROTECTED FUNCTION ReceberArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto, par_cArquivoLocal)
        LOCAL loc_nInternet, loc_nFtp, loc_cArquivoTemp, loc_nTamanho, ;
            loc_nSegIni, loc_nSegFim, loc_lOk

        #DEFINE INTERNET_OPEN_TYPE_DIRECT_GF    1
        #DEFINE INTERNET_DEFAULT_FTP_PORT_GF   21
        #DEFINE INTERNET_SERVICE_FTP_GF         1
        #DEFINE INTERNET_FLAG_PASSIVE_GF  14217728
        #DEFINE FILE_ATTRIBUTE_NORMAL_GF      128
        #DEFINE FTP_TRANSFER_TYPE_BINARY_GF     2

        loc_lOk     = .F.
        loc_nTamanho = 0

        DECLARE LONG InternetOpen IN "wininet.dll" ;
            STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
            STRING lpszProxyBypass, LONG dwFlags

        DECLARE LONG InternetConnect IN "wininet.dll" ;
            LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
            STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
            LONG dwFlags, LONG dwContext

        DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet

        DECLARE LONG GetLastError IN WIN32API

        DECLARE INTEGER FtpGetFile IN "wininet.dll" ;
            LONG hFtpSession, STRING lpszRemoteFile, STRING lpszNewFile, ;
            LONG fFailIfExist, LONG dwFlagsAndAttributes, LONG dwFlags, LONG dwContext

        loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_GF, "", "", 0)
        IF loc_nInternet = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            RETURN .F.
        ENDIF

        loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_GF, ;
            par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_GF, INTERNET_FLAG_PASSIVE_GF, 0)
        IF loc_nFtp = 0
            THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
                ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
            InternetCloseHandle(loc_nInternet)
            RETURN .F.
        ENDIF

        *-- Renomeia o arquivo para temporario ate completar a transferencia
        loc_cArquivoTemp = LEFT(par_cArquivoLocal, LEN(par_cArquivoLocal) - 3) + "ftp"
        IF FILE(par_cArquivoLocal)
            DELETE FILE (par_cArquivoLocal)
        ENDIF

        loc_nSegIni = SECONDS()
        THIS.Processa(JUSTFNAME(par_cArquivoRemoto), 99999, ;
            THIS.this_oBusinessObject.this_cDirRecFtp, THIS.this_oBusinessObject.this_cDirEnvLoc, ;
            0, 0, 0, 0, "I")

        loc_lOk = (FtpGetFile(loc_nFtp, par_cArquivoRemoto, loc_cArquivoTemp, .F., ;
            FILE_ATTRIBUTE_NORMAL_GF, FTP_TRANSFER_TYPE_BINARY_GF, 0) = 1)

        loc_nSegFim  = SECONDS()
        loc_nTamanho = LEN(FILETOSTR(loc_cArquivoTemp))

        THIS.Processa(JUSTFNAME(par_cArquivoRemoto), loc_nTamanho, ;
            THIS.this_oBusinessObject.this_cDirRecFtp, THIS.this_oBusinessObject.this_cDirEnvLoc, ;
            loc_nTamanho, 0, loc_nSegIni, loc_nSegFim - loc_nSegIni, "A")

        IF loc_lOk
            THIS.Inf("Renomeando o arquivo [ " + loc_cArquivoTemp + " ] para [ " + par_cArquivoLocal + " ]", "B")

            RENAME (loc_cArquivoTemp) TO (par_cArquivoLocal)

            IF FILE(par_cArquivoLocal)
                THIS.Inf("Arquivo renomeado para [ " + par_cArquivoLocal + " ] com sucesso", "B")
                loc_lOk = .T.
            ELSE
                THIS.Inf("Falha na renomea" + CHR(231) + CHR(227) + "o do arquivo [ " + loc_cArquivoTemp + " ] para [ " + par_cArquivoLocal + " ]. Erro.", "R")
                loc_lOk = .F.
            ENDIF
        ENDIF

        InternetCloseHandle(loc_nFtp)
        InternetCloseHandle(loc_nInternet)

        THIS.Processa(JUSTFNAME(par_cArquivoRemoto), loc_nTamanho, ;
            THIS.this_oBusinessObject.this_cDirRecFtp, THIS.this_oBusinessObject.this_cDirEnvLoc, ;
            loc_nTamanho, 2048, loc_nSegIni, loc_nSegFim - loc_nSegIni, "C")

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * Transferir / Receber - Disparam o envio/recebimento de arquivos
    * (equivalentes aos PROCEDURE transfere/recebe do legado, chamados com
    * par_cModo = "A" para todos os arquivos ou "I" para selecao individual).
    * A origem eh o mesmo ListBox que MontaContainer/lst_4c_* ja mantem
    * populado (lst_4c_EnvFtp para envio, lst_4c_EnvLoc para recebimento);
    * o loop percorre a selecao (ou todos, conforme par_cModo) chamando
    * EnviarArquivoFtp/ReceberArquivoFtp arquivo a arquivo, replicando o
    * DO CASE ptptrans == "I"/"A" e o guard de selecao vazia do legado.
    *==========================================================================
    PROTECTED PROCEDURE Transferir(par_cModo)
        LOCAL loc_oObj, loc_nQtd, loc_nPos, loc_nSelecionados, loc_lOk, ;
            loc_cArquivo, loc_cArquivoLocal, loc_cArquivoRemoto
        LOCAL ARRAY loc_aArquivos[1]

        *-- Le os diretorios da tela para o BO (FormParaBO) antes de montar
        *-- qualquer caminho: e dali que saem this_cDirEnvFtp/this_cDirRecLoc
        IF !THIS.FormParaBO()
            RETURN .F.
        ENDIF

        loc_oObj = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
        loc_nQtd = loc_oObj.ListCount

        IF loc_nQtd <= 0
            THIS.Inf("N" + CHR(227) + "O existe nenhum arquivo a ser Transferido para o FTP.", "B")
            RETURN .F.
        ENDIF

        DIMENSION loc_aArquivos(loc_nQtd)
        loc_nSelecionados = 0

        FOR loc_nPos = 1 TO loc_nQtd
            DO CASE
                CASE par_cModo == "I"
                    IF loc_oObj.Selected(loc_nPos)
                        loc_nSelecionados = loc_nSelecionados + 1
                        loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
                    ELSE
                        loc_aArquivos(loc_nPos) = ""
                    ENDIF
                CASE par_cModo == "A"
                    loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
            ENDCASE
        ENDFOR

        IF par_cModo == "I" AND loc_nSelecionados <= 0
            THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
            MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
            RETURN .F.
        ENDIF

        THIS.HabilitarCampos(.F.)

        loc_lOk = .T.
        FOR loc_nPos = 1 TO loc_nQtd
            loc_cArquivo = loc_aArquivos(loc_nPos)

            IF EMPTY(ALLTRIM(loc_cArquivo))
                LOOP
            ENDIF

            loc_cArquivoLocal  = ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvFtp + ALLTRIM(loc_cArquivo))
            loc_cArquivoRemoto = LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cDirRecLoc + ALLTRIM(loc_cArquivo)))

            THIS.Inf("Processando o arquivo Local " + loc_cArquivoLocal + " para enviar ao FTP", "G")

            fGravarLog("X", THIS.Name, "ENVIO FTP", ;
                SUBSTR("INICIANDO ENVIO DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)

            IF THIS.EnviarArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
                    THIS.this_oBusinessObject.this_cFtpUser, ;
                    THIS.this_oBusinessObject.this_cFtpPass, ;
                    loc_cArquivoLocal, loc_cArquivoRemoto)
                loc_lOk = .T.
                THIS.Inf("Arquivo Local " + loc_cArquivoLocal + " transferido para FTP.", "G")
                fGravarLog("X", THIS.Name, "ENVIO FTP", ;
                    SUBSTR("ENVIO OK DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
            ELSE
                loc_lOk = .F.
                THIS.Inf("Problema: Arquivo Local " + loc_cArquivoLocal + " N" + CHR(227) + "O foi transferido para o FTP.", "R")
                fGravarLog("X", THIS.Name, "ENVIO FTP", ;
                    SUBSTR("FALHA NO ENVIO DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
                EXIT
            ENDIF
        ENDFOR

        IF loc_lOk
            THIS.Inf("Opera" + CHR(231) + CHR(227) + "o de transfer" + CHR(234) + "ncia Conclu" + CHR(237) + "da", "B")
        ELSE
            THIS.Inf("Opera" + CHR(231) + CHR(227) + "o de transfer" + CHR(234) + "ncia N" + CHR(227) + "o foi Conclu" + CHR(237) + "da com " + CHR(234) + "xito", "R")
        ENDIF

        THIS.HabilitarCampos(.T.)

        RETURN loc_lOk
    ENDPROC

    PROTECTED PROCEDURE Receber(par_cModo)
        LOCAL loc_oObj, loc_nQtd, loc_nPos, loc_nSelecionados, loc_lOk, ;
            loc_cArquivo, loc_cArquivoLocal, loc_cArquivoFtp
        LOCAL ARRAY loc_aArquivos[1]

        *-- Le os diretorios da tela para o BO (FormParaBO) antes de montar
        *-- qualquer caminho: e dali que saem this_cDirEnvLoc/this_cDirRecFtp
        IF !THIS.FormParaBO()
            RETURN .F.
        ENDIF

        loc_oObj = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
        loc_nQtd = loc_oObj.ListCount

        IF loc_nQtd <= 0
            THIS.Inf("N" + CHR(227) + "O existe nenhum arquivo a ser recebido do FTP.", "B")
            RETURN .F.
        ENDIF

        DIMENSION loc_aArquivos(loc_nQtd)
        loc_nSelecionados = 0

        FOR loc_nPos = 1 TO loc_nQtd
            DO CASE
                CASE par_cModo == "I"
                    IF loc_oObj.Selected(loc_nPos)
                        loc_nSelecionados = loc_nSelecionados + 1
                        loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
                    ELSE
                        loc_aArquivos(loc_nPos) = ""
                    ENDIF
                CASE par_cModo == "A"
                    loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
            ENDCASE
        ENDFOR

        IF par_cModo == "I" AND loc_nSelecionados <= 0
            THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
            MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
            RETURN .F.
        ENDIF

        THIS.HabilitarCampos(.F.)

        loc_lOk = .T.
        FOR loc_nPos = 1 TO loc_nQtd
            loc_cArquivo = loc_aArquivos(loc_nPos)

            IF EMPTY(ALLTRIM(loc_cArquivo))
                LOOP
            ENDIF

            loc_cArquivoFtp   = ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvLoc + ALLTRIM(loc_cArquivo))
            loc_cArquivoLocal = ALLTRIM(THIS.this_oBusinessObject.this_cDirRecFtp + ALLTRIM(loc_cArquivo))

            THIS.Inf("Processando o arquivo " + loc_cArquivoFtp + " para receber do FTP", "G")

            fGravarLog("X", THIS.Name, "REC FTP", ;
                SUBSTR("INICIANDO RECEPCAO DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)

            IF THIS.VerificarArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
                    THIS.this_oBusinessObject.this_cFtpUser, ;
                    THIS.this_oBusinessObject.this_cFtpPass, loc_cArquivoFtp)
                IF THIS.ReceberArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
                        THIS.this_oBusinessObject.this_cFtpUser, ;
                        THIS.this_oBusinessObject.this_cFtpPass, ;
                        loc_cArquivoFtp, loc_cArquivoLocal)
                    fGravarLog("X", THIS.Name, "REC FTP", ;
                        SUBSTR("RECEPCAO OK DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
                    loc_lOk = .T.
                ELSE
                    fGravarLog("X", THIS.Name, "REC FTP", ;
                        SUBSTR("FALHA NA RECEPCAO DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
                    loc_lOk = .F.
                ENDIF
            ELSE
                loc_lOk = .F.
            ENDIF

            IF loc_lOk
                THIS.Inf("Arquivo " + loc_cArquivoFtp + " Recebido do FTP", "G")
            ELSE
                THIS.Inf("Problema: Arquivo " + loc_cArquivoFtp + " N" + CHR(227) + "O foi Recebido do FTP.", "R")
            ENDIF
        ENDFOR

        IF loc_lOk
            THIS.Inf("Opera" + CHR(231) + CHR(227) + "o de Recebimento Conclu" + CHR(237) + "da", "B")
        ELSE
            THIS.Inf("Opera" + CHR(231) + CHR(227) + "o de Recebimento N" + CHR(227) + "o foi Conclu" + CHR(237) + "da com " + CHR(234) + "xito", "R")
        ENDIF

        THIS.HabilitarCampos(.T.)

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere a configuracao RESOLVIDA (properties do BO) para
    * os quatro campos de diretorio da tela. Transcricao literal do bloco que
    * o Init legado executa depois de resolver a configuracao de FTP:
    *
    *   .pgfloc.Page1.direnvftp.Value = ThisForm._DirEnvFtp
    *   .pgfloc.Page2.dirrecftp.Value = ThisForm._DirRecFtp
    *   .pgfftp.Page1.dirrecloc.Value = ThisForm._DirRecLoc
    *   .pgfftp.Page2.direnvloc.Value = ThisForm._DirEnvLoc
    *   (+ os quatro ToolTipText com os mesmos valores)
    *
    * PROTECTED porque FormBase.BOParaForm eh PROTECTED - VFP9 nao permite
    * ALARGAR o escopo de um metodo herdado.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPgLoc, loc_oPgFtp

        loc_oPgLoc = THIS.cnt_4c_Navegacao.pgf_4c_Loc
        loc_oPgFtp = THIS.cnt_4c_Navegacao.pgf_4c_Ftp

        WITH THIS.this_oBusinessObject
            loc_oPgLoc.Page1.txt_4c_DirEnvFtp.Value       = .this_cDirEnvFtp
            loc_oPgLoc.Page1.txt_4c_DirEnvFtp.ToolTipText = .this_cDirEnvFtp

            loc_oPgLoc.Page2.txt_4c_DirRecFtp.Value       = .this_cDirRecFtp
            loc_oPgLoc.Page2.txt_4c_DirRecFtp.ToolTipText = .this_cDirRecFtp

            loc_oPgFtp.Page1.txt_4c_DirRecLoc.Value       = .this_cDirRecLoc
            loc_oPgFtp.Page1.txt_4c_DirRecLoc.ToolTipText = .this_cDirRecLoc

            loc_oPgFtp.Page2.txt_4c_DirEnvLoc.Value       = .this_cDirEnvLoc
            loc_oPgFtp.Page2.txt_4c_DirEnvLoc.ToolTipText = .this_cDirEnvLoc
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormParaBO - Le de volta os quatro campos de diretorio da tela para as
    * properties do BO, aplicando a MESMA normalizacao do Init legado:
    *   pasta LOCAL  -> ADDBS(LOWER(ALLTRIM(x)))
    *   pasta REMOTA -> LOWER(ALLTRIM(x)) + "/" quando ainda nao termina em "/"
    * (iif(right(cDir,1)=="/" or empt(cDir), cDir, cDir+"/") do legado)
    *
    * Campo em BRANCO nao sobrescreve a property: sem isso um campo apagado
    * zeraria a configuracao resolvida e a transferencia passaria a montar
    * caminho a partir de "" - e os guards de sentido de ConfigurarPaginaDados
    * (que rodam no Init) nao seriam reavaliados. Pasta LOCAL que nao existe
    * no disco aborta e avisa, como o Init legado ja faz com DIRECTORY().
    *
    * DIVERGENCIA DELIBERADA, documentada: no legado os quatro TextBox ficam
    * editaveis (nao tem ReadOnly nem ControlSource) mas NADA le o valor de
    * volta - toda rotina de transferencia usa ThisForm._DirEnvFtp etc. Editar
    * a pasta na tela legada, portanto, nao tem efeito nenhum (os proprios
    * botoes "..." de escolher pasta estao com Enabled = .F. no SCX, sinal de
    * que o caminho de edicao ficou inacabado). Aqui a edicao passa a valer,
    * porque campo habilitado que ignora o que o usuario digita eh defeito, nao
    * comportamento a preservar. Sem edicao, o valor lido eh IDENTICO ao que
    * BOParaForm escreveu (ja normalizado), entao o caminho normal nao muda.
    *
    * PROTECTED porque FormBase.FormParaBO eh PROTECTED (nao alargar escopo).
    * Retorna .T. quando a configuracao lida da tela esta apta a transferir.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_oPgLoc, loc_oPgFtp, loc_lOk, loc_cEnvFtp, loc_cRecFtp, ;
            loc_cRecLoc, loc_cEnvLoc

        loc_lOk = .T.

        loc_oPgLoc = THIS.cnt_4c_Navegacao.pgf_4c_Loc
        loc_oPgFtp = THIS.cnt_4c_Navegacao.pgf_4c_Ftp

        loc_cEnvFtp = LOWER(ALLTRIM(loc_oPgLoc.Page1.txt_4c_DirEnvFtp.Value))
        loc_cRecFtp = LOWER(ALLTRIM(loc_oPgLoc.Page2.txt_4c_DirRecFtp.Value))
        loc_cRecLoc = LOWER(ALLTRIM(loc_oPgFtp.Page1.txt_4c_DirRecLoc.Value))
        loc_cEnvLoc = LOWER(ALLTRIM(loc_oPgFtp.Page2.txt_4c_DirEnvLoc.Value))

        *-- Pastas LOCAIS: precisam existir no disco (o Init legado faz a mesma
        *-- checagem com "if !empt(_DirEnvFtp) and !DIRECTORY(_DirEnvFtp)")
        IF !EMPTY(loc_cEnvFtp) AND !DIRECTORY(loc_cEnvFtp)
            THIS.Inf("A pasta local de envio " + loc_cEnvFtp + " n" + CHR(227) + "o existe. Por favor verifique.", "R")
            MsgAviso("A pasta local de envio informada n" + CHR(227) + "o existe:" + CHR(13) + loc_cEnvFtp, ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        IF !EMPTY(loc_cRecFtp) AND !DIRECTORY(loc_cRecFtp)
            THIS.Inf("A pasta local de recebimento " + loc_cRecFtp + " n" + CHR(227) + "o existe. Por favor verifique.", "R")
            MsgAviso("A pasta local de recebimento informada n" + CHR(227) + "o existe:" + CHR(13) + loc_cRecFtp, ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            WITH THIS.this_oBusinessObject
                IF !EMPTY(loc_cEnvFtp)
                    .this_cDirEnvFtp = ADDBS(loc_cEnvFtp)
                ENDIF

                IF !EMPTY(loc_cRecFtp)
                    .this_cDirRecFtp = ADDBS(loc_cRecFtp)
                ENDIF

                IF !EMPTY(loc_cRecLoc)
                    .this_cDirRecLoc = IIF(RIGHT(loc_cRecLoc, 1) == "/", loc_cRecLoc, loc_cRecLoc + "/")
                ENDIF

                IF !EMPTY(loc_cEnvLoc)
                    .this_cDirEnvLoc = IIF(RIGHT(loc_cEnvLoc, 1) == "/", loc_cEnvLoc, loc_cEnvLoc + "/")
                ENDIF
            ENDWITH

            *-- Reescreve a tela com o valor JA normalizado, para o que o
            *-- usuario ve ser exatamente o que sera usado na transferencia
            THIS.BOParaForm()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * CarregarLista - Ponto unico de (re)carga das listas da tela: le os
    * diretorios da tela para o BO, repovoa as quatro listas via MontaContainer
    * e repinta os dois grids.
    *
    * O GO TOP + Refresh do fim nao eh enfeite: popular cursor NAO repinta
    * grade em VFP9 (o legado sempre fecha com "go bott" + "GrdInf.refresh"),
    * e sem isso a grade fica visualmente vazia com o cursor cheio.
    *
    * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
    * THIS.oForm.CarregarLista() de FORA da classe - regra #3 do CLAUDE.md.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF !THIS.FormParaBO()
            RETURN .F.
        ENDIF

        loc_lSucesso = THIS.MontaContainer()

        *-- Grid de progresso (cursor_4c_Progresso) e grid de log
        *-- (cursor_4c_Log): reposiciona e repinta os dois
        IF USED("cursor_4c_Progresso")
            SELECT cursor_4c_Progresso
            GO TOP
            THIS.grd_4c_Progresso.Refresh()
        ENDIF

        IF USED("cursor_4c_Log")
            SELECT cursor_4c_Log
            GO BOTTOM
            THIS.grd_4c_Log.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Liga/desliga em bloco os controles de acao da tela.
    * Consolida o bloco de ".enabled" que o legado repete em cmdload.Click
    * (IF/ELSE), em transfere e em recebe:
    *
    *   ThisForm.Container1.enabled = .t.     && o legado deixa .t. nos dois
    *   ThisForm.cmdtran.enabled    = <flag>  && ramos - transcrito como esta
    *   ThisForm.cmdrec.enabled     = <flag>
    *   ThisForm.cmdsair.enabled    = <flag>
    *
    * par_lHabilitar = .F. durante a transferencia (trava a tela), .T. ao
    * terminar. cmd_4c_Encerrar segue o flag, como cmdsair no legado.
    *
    * PUBLIC (sem PROTECTED): mesma razao de CarregarLista - o harness chama
    * de fora da classe.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        *-- "ThisForm.Container1.enabled = .t." do legado: fica .T. tanto ao
        *-- iniciar quanto ao terminar a transferencia (transcrito, nao
        *-- "corrigido" - as listas continuam navegaveis durante a operacao)
        THIS.cnt_4c_Navegacao.Enabled  = .T.
        THIS.cmd_4c_Transferir.Enabled = loc_lHabilitar
        THIS.cmd_4c_Receber.Enabled    = loc_lHabilitar
        THIS.cmd_4c_Encerrar.Enabled   = loc_lHabilitar
    ENDPROC

    *==========================================================================
    * BtnConectarClick - Click de cmd_4c_Conectar (cmdload do legado): valida
    * o tipo de conexao (Dial-Up/Banda Larga), tenta conectar quando
    * necessario e, tendo sucesso, habilita os botoes de transferencia
    *==========================================================================
    PROCEDURE BtnConectarClick()
        LOCAL loc_lOk
        loc_lOk = .T.

        THIS.cmd_4c_Conectar.Enabled = .F.

        DO CASE
            CASE THIS.this_oBusinessObject.this_cTpConnect == "D"
                IF THIS.RasAtivas("aAtivas") > 0
                    THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + " conectado " + CHR(224) + " INTERNET", "B")
                    *-- "=ThisForm.MontaContainer()" seguido de "lOk = .t." no
                    *-- legado: o retorno da carga eh DESCARTADO de proposito -
                    *-- listagem que falha nao desabilita a transferencia
                    THIS.CarregarLista()
                    loc_lOk = .T.
                ELSE
                    THIS.Inf("Conex" + CHR(227) + "o " + CHR(224) + " Internet N" + CHR(227) + "o detectada", "R")
                    THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + " Internet via Dial-UP", "B")
                    THIS.cmd_4c_RedeDialup.Visible = .T.
                    loc_lOk = .F.
                ENDIF

            CASE THIS.this_oBusinessObject.this_cTpConnect == "B"
                THIS.Inf("Aguarde a inicializa" + CHR(231) + CHR(227) + "o das rotinas...", "B")
                THIS.Inf("Checando diret" + CHR(243) + "rios locais e conex" + CHR(245) + "es de rede...", "B")
                *-- idem ao ramo "D": o legado faz "lOk = .t." e so depois
                *-- "=ThisForm.MontaContainer()", descartando o retorno
                loc_lOk = .T.
                THIS.CarregarLista()

            OTHERWISE
                THIS.Inf("N" + CHR(227) + "o h" + CHR(225) + " tipo definido de conex" + CHR(227) + "o... Opera" + CHR(231) + CHR(227) + "o Cancelada", "R")
                loc_lOk = .F.
        ENDCASE

        IF loc_lOk
            THIS.cnt_4c_Navegacao.Enabled                  = .T.
            THIS.cmd_4c_Transferir.Enabled                 = .T.
            THIS.cmd_4c_Receber.Enabled                    = .T.
            THIS.cmd_4c_Encerrar.Enabled                   = .T.
            THIS.cmd_4c_Conectar.Enabled                   = .F.
        ELSE
            THIS.Inf("N" + CHR(227) + "o foi detectada nenhuma conex" + CHR(227) + "o... Opera" + CHR(231) + CHR(227) + "o Cancelada", "R")
            THIS.cnt_4c_Navegacao.Enabled                  = .F.
            THIS.cmd_4c_Transferir.Enabled                 = .F.
            THIS.cmd_4c_Receber.Enabled                    = .F.
            THIS.cmd_4c_Encerrar.Enabled                   = .T.
            THIS.cmd_4c_Conectar.Enabled                   = .T.
        ENDIF

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BtnRedeDialupClick - Click de cmd_4c_RedeDialup (cmdconect do legado):
    * dispara a conexao Dial-Up via Rnaui.dll quando um provedor foi
    * selecionado no combo (CboProvedor, adicionado junto com os demais
    * controles de dados do PageFrame)
    *==========================================================================
    PROCEDURE BtnRedeDialupClick()
        LOCAL loc_cProvedor, loc_cComando

        DO CASE
            CASE THIS.this_oBusinessObject.this_cTpConnect == "D"
                IF THIS.RasAtivas("aAtivas") > 0
                    THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + " conectado " + CHR(224) + " INTERNET", "B")
                ELSE
                    THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + " Internet via Dial-UP", "B")
                    *-- VFP9 nao faz short-circuit em AND/OR: TYPE() e o valor
                    *-- da variavel tem de ser checados em IFs separados, senao
                    *-- "nProvedor > 0" estoura "Variable NPROVEDOR is not found"
                    *-- antes de nProvedor existir (CboProvedor, Fase 5-6)
                    IF TYPE("nProvedor") = "N"
                        IF nProvedor > 0
                            loc_cProvedor = aProvedor(nProvedor)
                            THIS.this_cProvedorConectado = loc_cProvedor
                            loc_cComando  = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(loc_cProvedor)
                            &loc_cComando.
                        ELSE
                            THIS.Inf("Nome de Provedor inv" + CHR(225) + "lido.. Selecione um provedor", "R")
                            MsgAviso("Selecione o provedor.", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ELSE
                        THIS.Inf("Nome de Provedor inv" + CHR(225) + "lido.. Selecione um provedor", "R")
                        MsgAviso("Selecione o provedor.", "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF

            OTHERWISE
                THIS.Inf("N" + CHR(227) + "o h" + CHR(225) + " tipo definido de conex" + CHR(227) + "o... Opera" + CHR(231) + CHR(227) + "o Cancelada", "R")
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnExecutarTransferenciaClick / BtnEnviaFtpClick - Click de cmd_4c_Transferir
    * (cmdtran, transfere todos) e cmd_4c_EnviaFtp (cmdtransfere, transfere
    * so os selecionados)
    *==========================================================================
    PROCEDURE BtnExecutarTransferenciaClick()
        THIS.Transferir("A")
    ENDPROC

    PROCEDURE BtnEnviaFtpClick()
        THIS.Transferir("I")
    ENDPROC

    *==========================================================================
    * BtnExecutarRecebimentoClick / BtnRecebeFtpClick - Click de cmd_4c_Receber (cmdrec,
    * recebe todos) e cmd_4c_RecebeFtp (cmdrecebe, recebe so os selecionados)
    *==========================================================================
    PROCEDURE BtnExecutarRecebimentoClick()
        THIS.Receber("A")
    ENDPROC

    PROCEDURE BtnRecebeFtpClick()
        THIS.Receber("I")
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Click de cmd_4c_Encerrar (cmdsair do legado:
    * "ThisForm.release")
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Destroy - Libera o Business Object; a restauracao do menu principal
    * ja e feita por FormBase.Destroy via DODEFAULT()
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_nAtivas, loc_cComando

        *-- "if ThisForm._TpConnect = 'D' ... " do PROCEDURE Release legado:
        *-- se a conexao Dial-Up discada por BtnRedeDialupClick ainda estiver
        *-- ativa ao fechar o form, avisa o usuario e desconecta (a mesma
        *-- chamada RnaDial de novo funciona como toggle e derruba a conexao)
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_oBusinessObject.this_cTpConnect == "D"
            PUBLIC ARRAY aAtivas(1)
            loc_nAtivas = THIS.RasAtivas("aAtivas")

            IF loc_nAtivas > 0
                MsgInfo("A conex" + CHR(227) + "o " + CHR(224) + " internet ainda est" + CHR(225) + " ativa...", "Aten" + CHR(231) + CHR(227) + "o")

                IF !EMPTY(THIS.this_cProvedorConectado)
                    loc_cComando = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(THIS.this_cProvedorConectado)
                    &loc_cComando.
                ENDIF
            ENDIF

            RELEASE aAtivas
        ENDIF

        *-- Fecha os cursores locais do form (equivalente ao "sele logftp /
        *-- use" e "sele tmpprog / use" do Destroy legado)
        IF USED("cursor_4c_Progresso")
            USE IN cursor_4c_Progresso
        ENDIF

        IF USED("cursor_4c_Log")
            USE IN cursor_4c_Log
        ENDIF

        IF USED("cursor_4c_FtpServer")
            USE IN cursor_4c_FtpServer
        ENDIF

        *-- "Release aAtivas, cProvedor, aProvedor" do Destroy legado - os
        *-- arrays/memvars PUBLIC do combo de provedores Dial-Up (criados em
        *-- ConfigurarProvedorDialUp) nao devem sobreviver ao fechamento do form
        IF TYPE("aProvedor") <> "U"
            RELEASE aProvedor
        ENDIF
        IF TYPE("nProvedor") <> "U"
            RELEASE nProvedor
        ENDIF

        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprftpBO.prg):
*============================================================================
* sigprftpBO.prg - Business Object para Transferencia e Recebimento de
*                   arquivos via FTP (form OPERACIONAL, sem CRUD proprio)
*
* Tabela de parametros globais : SigCdPam (PK: cidchaves char(20))
*   Colunas usadas: tptrans, empmasters, grumccrs, conmccrs, vendnts
* Tabela de configuracao/empresa: SigCdEmp (PK: cemps char(3))
*   Colunas usadas: cemps, tpconexao, ftpend, ftpusuario, ftpsenha,
*                    drivets, drivels, dirftpts, dirftpls, locdel, ftpdel
*
* Este BO e SOMENTE-LEITURA em relacao a SigCdPam/SigCdEmp: o form legado
* apenas consulta essas tabelas para resolver a configuracao de FTP da
* empresa (ou da empresa "master", quando SigCdPam.empmasters esta
* preenchido) - o comportamento padrao herdado de BusinessBase (recusar
* Inserir/Atualizar/ExecutarExclusao) ja e o correto para esta entidade.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigprftpBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos pelo Init do form legado (equivalentes as
    * propriedades ThisForm._TpEnv / ._TpRec / ._TpConnect / etc do SIGPRFTP)
    * Representam a configuracao RESOLVIDA que efetivamente comanda a
    * transferencia (combinacao dos parametros de chamada + fallback do
    * cadastro de empresa quando a chamada nao informa os dados).
    *==========================================================================
    this_cTpEnv         = "*.*"  && Mascara de arquivos para Envio (Local -> FTP)
    this_cTpRec         = "*.*"  && Mascara de arquivos para Recebimento (FTP -> Local)
    this_cTpConnect     = ""     && Tipo de conexao: "D"=Dial-Up, "B"=Banda Larga/Direta
    this_cFtpAdd        = ""     && Endereco do servidor FTP
    this_cFtpUser       = ""     && Usuario de acesso ao FTP
    this_cFtpPass       = ""     && Senha de acesso ao FTP (ja descriptografada)
    this_cDirEnvFtp     = ""     && Pasta LOCAL de onde os arquivos sao enviados ao FTP
    this_cDirRecFtp     = ""     && Pasta LOCAL onde os arquivos recebidos do FTP sao gravados
    this_cDirEnvLoc     = ""     && Pasta REMOTA (no FTP) onde os arquivos enviados sao gravados
    this_cDirRecLoc     = ""     && Pasta REMOTA (no FTP) de onde os arquivos sao recebidos
    this_lDelLocal      = .F.    && Exclui o arquivo local apos o envio ao FTP
    this_lDelHost       = .F.    && Exclui o arquivo do FTP apos o recebimento
    this_nTpConect      = 0      && 0=Nenhuma acao automatica, 1=Transfere automatico, 2=Recebe automatico
    this_lCaseSensitive = .F.    && Preserva caixa da senha de FTP (nao converte para minusculo)

    *==========================================================================
    * Propriedades de SigCdPam (parametros gerais do sistema) - carregadas
    * uma unica vez em BuscarParametros() nas proximas fases
    *==========================================================================
    this_cTpTrans    = ""    && char(6)  - Tipo de transferencia padrao do sistema
    this_cEmpMasters = ""    && char(3)  - Empresa "master" cuja config de FTP e usada
    this_cGruMccrs   = ""    && char(10) - Grupo padrao (uso do modulo de FTP/movimento)
    this_cConMccrs   = ""    && char(10) - Conta padrao (uso do modulo de FTP/movimento)
    this_cVendNts    = ""    && char(10) - Vendedor padrao (uso do modulo de FTP/movimento)

    *==========================================================================
    * Propriedades de SigCdEmp (configuracao de FTP da empresa consultada)
    *==========================================================================
    this_cCemps      = ""    && char(3)  - Codigo da empresa cuja config foi carregada
    this_cTpConexao  = ""    && char(1)  - Tipo de conexao cadastrado na empresa
    this_cFtpEnd     = ""    && char(50) - Endereco do servidor FTP cadastrado na empresa
    this_cFtpUsuario = ""    && char(20) - Usuario de FTP cadastrado na empresa
    this_cFtpSenha   = ""    && char(20) - Senha de FTP cadastrada na empresa (criptografada)
    this_cDrivets    = ""    && char(60) - Pasta local de envio cadastrada na empresa
    this_cDrivels    = ""    && char(60) - Pasta local de recebimento cadastrada na empresa
    this_cDirftpts   = ""    && char(60) - Pasta remota de recebimento cadastrada na empresa
    this_cDirftpls   = ""    && char(60) - Pasta remota de envio cadastrada na empresa
    this_lLocDel     = .F.   && bit      - Exclui arquivo local apos envio (config da empresa)
    this_lFtpDel     = .F.   && bit      - Exclui arquivo do FTP apos recebimento (config da empresa)

    *==========================================================================
    * Propriedades de controle/mensagens especificas deste BO
    *==========================================================================
    this_lConfigValida = .F.  && .T. quando a configuracao resolvida esta apta a transferir

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEmp"
            THIS.this_cCampoChave = "cemps"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave primaria para auditoria/identificacao do
    * registro de configuracao de empresa (SigCdEmp) atualmente carregado
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCemps
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas de SigCdEmp (config de FTP da
    * empresa) do cursor para as propriedades this_c*/this_l* do BO.
    * Equivalente ao bloco do Init legado que le "crftpemp" apos o
    * CursorQuery('SigCdEmp', 'crftpemp', 'Cemps', lcBusEmp).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCemps      = ALLTRIM(TratarNulo(cemps, ""))
        THIS.this_cTpConexao  = TratarNulo(tpconexao, "")
        THIS.this_cFtpEnd     = TratarNulo(ftpend, "")
        THIS.this_cFtpUsuario = TratarNulo(ftpusuario, "")
        THIS.this_cFtpSenha   = TratarNulo(ftpsenha, "")
        THIS.this_cDrivets    = TratarNulo(drivets, "")
        THIS.this_cDrivels    = TratarNulo(drivels, "")
        THIS.this_cDirftpts   = TratarNulo(dirftpts, "")
        THIS.this_cDirftpls   = TratarNulo(dirftpls, "")

        * Coluna bit chega ao VFP ora como Logico ora como Numerico
        * conforme o driver - testar VARTYPE antes de comparar (regra #13)
        IF VARTYPE(locdel) = "L"
            THIS.this_lLocDel = locdel
        ELSE
            THIS.this_lLocDel = (NVL(locdel, 0) = 1)
        ENDIF

        IF VARTYPE(ftpdel) = "L"
            THIS.this_lFtpDel = ftpdel
        ELSE
            THIS.this_lFtpDel = (NVL(ftpdel, 0) = 1)
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarParametrosSistema - Carrega a (unica) linha de parametros gerais
    * do sistema em SigCdPam, equivalente a:
    *   ThisForm.poDataMgr.CursorQuery('SigCdPam', 'crftpParam', .f., .f.,
    *     'TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts')
    *==========================================================================
    FUNCTION BuscarParametrosSistema()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_FtpParam")
                USE IN cursor_4c_FtpParam
            ENDIF

            loc_cSQL = "SELECT TOP 1 TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts " + ;
                       "FROM SigCdPam"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtpParam")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_FtpParam") AND RECCOUNT("cursor_4c_FtpParam") > 0
                    SELECT cursor_4c_FtpParam
                    GO TOP
                    THIS.this_cTpTrans    = TratarNulo(TpTrans, "")
                    THIS.this_cEmpMasters = ALLTRIM(TratarNulo(EmpMasters, ""))
                    THIS.this_cGruMccrs   = TratarNulo(GruMccrs, "")
                    THIS.this_cConMccrs   = TratarNulo(ConMccrs, "")
                    THIS.this_cVendNts    = TratarNulo(VendNts, "")
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar par" + CHR(226) + "metros do sistema (SigCdPam)"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_FtpParam")
            USE IN cursor_4c_FtpParam
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BuscarConfiguracaoEmpresa - Carrega a configuracao de FTP cadastrada
    * para a empresa informada (SigCdEmp), equivalente a:
    *   ThisForm.PodataMgr.Cursorquery('SigCdEmp','crftpemp','Cemps',lcBusEmp)
    *==========================================================================
    FUNCTION BuscarConfiguracaoEmpresa(par_cCemps)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado

        loc_lResultado = .F.

        IF EMPTY(par_cCemps)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de empresa n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_FtpEmp")
                USE IN cursor_4c_FtpEmp
            ENDIF

            loc_cSQL = "SELECT Cemps, TpConexao, Ftpend, Ftpusuario, Ftpsenha, " + ;
                       "Drivets, Drivels, Dirftpts, Dirftpls, LocDel, FtpDel " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(PADR(ALLTRIM(par_cCemps), 3))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtpEmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_FtpEmp") AND RECCOUNT("cursor_4c_FtpEmp") > 0
                    SELECT cursor_4c_FtpEmp
                    GO TOP
                    THIS.CarregarDoCursor("cursor_4c_FtpEmp")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o cadastrada ... Opera" + CHR(231) + CHR(227) + "o Cancelada"
                    loc_lResultado = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de FTP da empresa"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_FtpEmp")
            USE IN cursor_4c_FtpEmp
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ResolverConfiguracaoFtp - Orquestra a resolucao da configuracao efetiva
    * de FTP (parametros gerais + empresa "master" ou a propria empresa),
    * reproduzindo o bloco de PROCEDURE Init do form legado:
    *   lcBusEmp = Iif(!Empty(crftpparam.EmpMasters), crftpParam.EmpMasters, _Empr)
    *   ... carrega crftpemp e resolve _TpConnect/_FtpAdd/_FtpUser/_FtpPass/
    *       _DirEnvFtp/_DirRecFtp/_DirRecLoc/_DirEnvLoc/_DelLocal/_DelHost
    *
    * par_cCemps: codigo da empresa CORRENTE (equivalente a _Empr do legado -
    *             o form migrado deve passar go_4c_Sistema.cCodEmpresa)
    *==========================================================================
    FUNCTION ResolverConfiguracaoFtp(par_cCemps)
        LOCAL loc_lResultado, loc_cEmpresaBusca

        loc_lResultado = .F.
        THIS.this_lConfigValida = .F.

        IF !THIS.BuscarParametrosSistema()
            RETURN .F.
        ENDIF

        loc_cEmpresaBusca = IIF(!EMPTY(THIS.this_cEmpMasters), THIS.this_cEmpMasters, ALLTRIM(TratarNulo(par_cCemps, "")))

        IF !THIS.BuscarConfiguracaoEmpresa(loc_cEmpresaBusca)
            RETURN .F.
        ENDIF

        * Resolucao dos campos efetivos de conexao (equivalente ao trecho
        * "With ThisForm ... EndWith" do Init legado que copia crftpemp.*
        * para as propriedades _Tp*/_Ftp*/_Dir*/_Del* do form)
        THIS.this_cTpConnect = UPPER(ALLTRIM(THIS.this_cTpConexao))
        THIS.this_cFtpAdd    = LOWER(ALLTRIM(THIS.this_cFtpEnd))
        THIS.this_cFtpUser   = LOWER(ALLTRIM(THIS.this_cFtpUsuario))

        * fCriptografar: mesma funcao global do legado ja referenciada sem
        * wrapper proprio em SigPrScnBO.prg/sigtosenBO.prg (decodifica a
        * senha gravada no cadastro de empresa para uso efetivo no FTP)
        IF THIS.this_lCaseSensitive
            THIS.this_cFtpPass = ALLTRIM(fCriptografar(THIS.this_cFtpSenha))
        ELSE
            THIS.this_cFtpPass = LOWER(ALLTRIM(fCriptografar(THIS.this_cFtpSenha)))
        ENDIF

        THIS.this_cDirEnvFtp = ADDBS(LOWER(ALLTRIM(THIS.this_cDrivets)))
        THIS.this_cDirRecFtp = ADDBS(LOWER(ALLTRIM(THIS.this_cDrivels)))
        THIS.this_cDirRecLoc = THIS.NormalizarDiretorioRemoto(LOWER(ALLTRIM(THIS.this_cDirftpts)))
        THIS.this_cDirEnvLoc = THIS.NormalizarDiretorioRemoto(LOWER(ALLTRIM(THIS.this_cDirftpls)))
        THIS.this_lDelLocal  = THIS.this_lLocDel
        THIS.this_lDelHost   = THIS.this_lFtpDel

        * Mesma validacao do "Do Case" do Init legado (TpConnect invalido /
        * FtpAdd, FtpUser ou FtpPass vazios cancelam a operacao)
        loc_lResultado = INLIST(THIS.this_cTpConnect, "D", "B") AND ;
                          !EMPTY(THIS.this_cFtpAdd) AND ;
                          !EMPTY(THIS.this_cFtpUser) AND ;
                          !EMPTY(THIS.this_cFtpPass)

        IF !loc_lResultado
            THIS.this_cMensagemErro = "Esta empresa n" + CHR(227) + "o possui uma configura" + CHR(231) + CHR(227) + "o correta de acesso " + CHR(224) + " FTP"
        ENDIF

        THIS.this_lConfigValida = loc_lResultado

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * NormalizarDiretorioRemoto - Garante barra "/" no final do caminho
    * remoto do FTP, equivalente a:
    *   iif(right(cDir,1)=="/" or empt(cDir), cDir, cDir + "/")
    *==========================================================================
    PROTECTED FUNCTION NormalizarDiretorioRemoto(par_cDiretorio)
        IF EMPTY(par_cDiretorio) OR RIGHT(par_cDiretorio, 1) == "/"
            RETURN par_cDiretorio
        ENDIF

        RETURN par_cDiretorio + "/"
    ENDFUNC

ENDDEFINE

