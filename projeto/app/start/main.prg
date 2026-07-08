*==============================================================================
* MAIN.PRG
* Programa principal de inicializacao do sistema
* Responsabilidade: inicializar ambiente, conectar ao banco, abrir menu
*==============================================================================

*------------------------------------------------------------------------------
* Programa Principal
*------------------------------------------------------------------------------
PROCEDURE Main()
    * Limpa ambiente
    CLEAR ALL
    CLEAR

    * Exibe mensagem de inicializacao
    WAIT WINDOW "Inicializando sistema..." NOWAIT

    * Carrega configuracoes
    DO config.prg

    * Configura ambiente
    ConfigurarAmbiente()

    * Configura SET's globais
    ConfigurarSETs()

    * Conecta ao banco de dados
    IF !ConectarBancoDados()
        WAIT CLEAR
        MESSAGEBOX("N" + CHR(227) + "o foi poss" + CHR(237) + "vel conectar ao banco de dados." + CHR(13) + ;
                   "O sistema ser" + CHR(225) + " encerrado.", ;
                   16, ;
                   "Erro de Conex" + CHR(227) + "o")
        RETURN
    ENDIF

    WAIT CLEAR

    * Exibe tela de apresentacao (splash screen) - opcional
    * DO splash.prg

    * Abre menu principal
    CriarMenuPrincipal()

    * Mantem o sistema ativo ate o usuario sair (menu)
    * Quando o usuario escolher "Sair" no menu, CLEAR EVENTS sera chamado
    * e a execucao continuara aqui
    READ EVENTS

    * Ao sair do menu, desconecta do banco
    DesconectarBancoDados()

    * Limpa variaveis publicas
    LimparVariaveisPublicas()

    * Mensagem de encerramento
    MESSAGEBOX("Sistema encerrado com sucesso.", 64, "At" + CHR(233) + " logo!")

    CLEAR ALL
    QUIT
ENDPROC

*------------------------------------------------------------------------------
* ConectarBancoDados - Estabelece conexao com SQL Server
* Retorno: .T. se conectou com sucesso, .F. se erro
*------------------------------------------------------------------------------
PROCEDURE ConectarBancoDados()
    LOCAL lcStringConexao, lnHandle, llConectado
    PUBLIC gnConnHandle

    llConectado = .F.

    TRY
        * Obtem string de conexao
        lcStringConexao = ObterStringConexao()

        * Tenta conectar
        lnHandle = SQLSTRINGCONNECT(lcStringConexao)

        IF lnHandle < 0
            * Erro na conexao
            LOCAL ARRAY laErro[1]
            AERROR(laErro)

            MESSAGEBOX("Erro ao conectar ao banco de dados:" + CHR(13) + ;
                       laErro[2], ;
                       16, ;
                       "Erro SQL")

            llConectado = .F.
        ELSE
            * Armazena handle da conexao
            gnConnHandle = lnHandle

            * Configura timeout de queries
            DB_QUERY_TIMEOUT=60
            SQLSETPROP(gnConnHandle, "QueryTimeOut", DB_QUERY_TIMEOUT)

            * Configura para retornar sempre array de erros
            SQLSETPROP(gnConnHandle, "DispWarnings", .T.)

            llConectado = .T.

            *-- Carregar codigo da empresa do banco
            CarregarEmpresa(lnHandle)
        ENDIF

    CATCH TO loException
        MESSAGEBOX("Exce" + CHR(231) + CHR(227) + "o ao conectar ao banco:" + CHR(13) + ;
                   loException.Message, ;
                   16, ;
                   "Erro")

        llConectado = .F.
    ENDTRY

    RETURN llConectado
ENDPROC

*------------------------------------------------------------------------------
* DesconectarBancoDados - Fecha conexao com SQL Server
*------------------------------------------------------------------------------
PROCEDURE DesconectarBancoDados()
    IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
        SQLDISCONNECT(gnConnHandle)
        gnConnHandle = 0
    ENDIF
ENDPROC

*------------------------------------------------------------------------------
* ConfigurarSETs - Define configuracoes globais do VFP
*------------------------------------------------------------------------------
PROCEDURE ConfigurarSETs()
    * Formato de data
    SET DATE TO DMY
    SET CENTURY ON
    SET MARK TO "/"

    * Formato numerico
    SET DECIMALS TO 2
    SET POINT TO ","
    SET SEPARATOR TO "."

    * Formato de moeda
    SET CURRENCY TO "R$ "
    SET CURRENCY LEFT

    * Comportamento
    SET BELL OFF
    SET CONFIRM ON
    SET DELETED ON
    SET EXACT ON
    SET NEAR OFF
    SET SAFETY OFF
    SET TALK OFF
    SET NOTIFY OFF
    SET ESCAPE OFF

    * Performance
    SET OPTIMIZE ON
    SET REPROCESS TO AUTOMATIC

    * Interface
    SET STATUS BAR ON
    SET SYSMENU TO DEFAULT
    SET CLOCK STATUS

    * Codepage
    SET COLLATE TO "GENERAL"

    * Compatibilidade
    SET STRICTDATE TO 0
ENDPROC

*------------------------------------------------------------------------------
* LimparVariaveisPublicas - Remove variaveis publicas
*------------------------------------------------------------------------------
PROCEDURE LimparVariaveisPublicas()
    IF TYPE("gnConnHandle") = "N"
        RELEASE gnConnHandle
    ENDIF

    IF TYPE("gcCaminhoBase") = "C"
        RELEASE gcCaminhoBase
    ENDIF

    IF TYPE("gcCaminhoClasses") = "C"
        RELEASE gcCaminhoClasses
    ENDIF

    IF TYPE("gcCaminhoUtils") = "C"
        RELEASE gcCaminhoUtils
    ENDIF

    IF TYPE("gcCaminhoForms") = "C"
        RELEASE gcCaminhoForms
    ENDIF

    IF TYPE("gcCaminhoIcones") = "C"
        RELEASE gcCaminhoIcones
    ENDIF

    IF TYPE("gb_4c_ValidandoUI") = "L"
        RELEASE gb_4c_ValidandoUI
    ENDIF
ENDPROC

*------------------------------------------------------------------------------
* TestarConexao - Testa conexao com banco de dados
* Funcao auxiliar para debug/manutencao
*------------------------------------------------------------------------------
FUNCTION TestarConexao()
    LOCAL lcSQL, lnResultado, llConexaoOK

    llConexaoOK = .F.

    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
        RETURN llConexaoOK
    ENDIF

    TRY
        * Executa query simples para testar
        lcSQL = "SELECT 1 AS Teste"
        lnResultado = SQLEXEC(gnConnHandle, lcSQL, "curTeste")

        IF lnResultado > 0
            USE IN curTeste
            llConexaoOK = .T.
        ENDIF

    CATCH TO loException
        llConexaoOK = .F.
    ENDTRY

    RETURN llConexaoOK
ENDFUNC

*------------------------------------------------------------------------------
* CarregarEmpresa - Busca codigo da empresa no banco e atualiza go_4c_Sistema
*------------------------------------------------------------------------------
PROCEDURE CarregarEmpresa(par_nHandle)
    LOCAL loc_nResult, loc_cEmpresa
    loc_cEmpresa = ""

    TRY
        loc_nResult = SQLEXEC(par_nHandle, ;
            "SELECT TOP 1 Emps FROM SigMvCcr ORDER BY Emps", "cursor_4c_Empresa")

        IF loc_nResult >= 0 AND USED("cursor_4c_Empresa") AND RECCOUNT("cursor_4c_Empresa") > 0
            loc_cEmpresa = ALLTRIM(cursor_4c_Empresa.Emps)
        ENDIF

        IF USED("cursor_4c_Empresa")
            USE IN cursor_4c_Empresa
        ENDIF
    CATCH
        *-- Silencioso - mantem valor padrao do config.prg
    ENDTRY

    IF !EMPTY(loc_cEmpresa)
        go_4c_Sistema.cCodEmpresa = loc_cEmpresa
        _EMPR = loc_cEmpresa
    ENDIF
ENDPROC

*------------------------------------------------------------------------------
* Inicia execucao
*------------------------------------------------------------------------------
DO Main
