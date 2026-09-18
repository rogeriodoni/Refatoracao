*==============================================================================
* MAIN.PRG
* Programa principal de inicializacao do sistema
* Responsabilidade: inicializar ambiente, conectar ao banco, abrir menu
*==============================================================================

*------------------------------------------------------------------------------
* Inicia execucao
*
* Em VFP todo codigo de nivel superior tem de vir ANTES da primeira PROCEDURE.
* Com o "DO Main" no FIM do arquivo, o COMPILE acusa "Statement is not in a
* procedure" e o .prg nao compila.
*------------------------------------------------------------------------------
DO Main
RETURN
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

            * Suprime dialog nativo ODBC em erro de SQL (Nome de objeto invalido, etc).
            * BOs checam loc_nResult < 1 + AERROR() e exibem MsgErro amigavel.
            SQLSETPROP(gnConnHandle, "DispWarnings", .F.)

            llConectado = .T.

            *-- Carregar codigo da empresa do banco
            CarregarEmpresa(lnHandle)

            *-- Gerenciador de conexoes NOMEADAS do legado Fortyus (Erro163_Aba1)
            CriarObjectConnLegado(lcStringConexao)
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
* CriarObjectConnLegado - Instancia goSistema.ObjectConn (cOpenConn)
*
* Os VCXs legado Fortyus pedem conexao POR NOME, nao por handle:
*
*     .poDataMgr = CreateObject('fSqlConector', 'cep')      && fwcep/frmceps.Init
*     loCon      = CreateObject('fSqlConector', 'sige')
*     .poDataMgr = CreateObject('fSqlConector', ThisForm.Name)
*
* e o fSqlConector (classes\sigclcnx.PRG) resolve esse nome assim:
*
*     If (Type([goSistema.ObjectConn]) = [O])
*         This.pnIdConn = goSistema.ObjectConn.Connect(@pNum, pOkc)
*     EndIf
*     If (This.pnIdConn > 0) ... Else This.pnIdConn = -1
*
* Sem o ObjectConn o pnIdConn ficava -1 e o fwcep exibia
* 'Impossivel Efetuar Conexao Com o Servidor de Banco de Dados...' (titulo
* 'CreateObject') - o erro ao digitar o CEP no Cadastro de Cliente.
*
* cOpenConn eh a classe legado ORIGINAL, usada sem alteracao: o Init dela
* conecta, le dbo.SigConn (cIdConns / cStrgConns) e monta o array de conexoes
* nomeadas. pTrv = 1 faz duas coisas necessarias aqui:
*   - limita a UMA tentativa de leitura (sem isso o Init insiste por 30s);
*   - registra a NOSSA string sob o nome default quando ele nao esta na SigConn,
*     que eh o fallback usado por todo nome nao cadastrado (nome de form, etc).
*
* O nome default eh 'sige' porque eh o unico id de conexao que o Framework
* referencia literalmente (framework.vcx: CreateObject('fSqlConector','sige')).
*
* O Init do cOpenConn reescreve os defaults de conexao no handle 0
* (ConnectTimeOut 60, Transactions 2, ...); os nossos sao reaplicados no fim
* para nao mudar o comportamento das conexoes criadas pelos BOs.
*------------------------------------------------------------------------------
PROCEDURE CriarObjectConnLegado(par_cStringConexao)
    LOCAL loc_oConn, loc_oErro

    IF TYPE("go_4c_Sistema") <> "O"
        RETURN
    ENDIF

    TRY
        IF !PEMSTATUS(go_4c_Sistema, "ObjectConn", 5)
            ADDPROPERTY(go_4c_Sistema, "ObjectConn", .NULL.)
        ENDIF

        loc_oConn = CREATEOBJECT("cOpenConn", par_cStringConexao, "sige", 1)

        IF VARTYPE(loc_oConn) = "O"
            go_4c_Sistema.ObjectConn = loc_oConn
        ENDIF

        *-- Restaura os defaults do handle 0 mexidos pelo Init do cOpenConn
        SQLSETPROP(0, "ConnectTimeOut", 30)
        SQLSETPROP(0, "DispLogin", 3)
        SQLSETPROP(0, "DispWarnings", .F.)

    CATCH TO loc_oErro
        *-- Sem dialog: o sistema funciona sem ObjectConn (so os lookups de CEP
        *-- por nome de conexao ficam indisponiveis, com a mensagem do proprio
        *-- VCX). Fica o rastro em log para nao engolir o erro (regra #9).
        STRTOFILE("[" + TTOC(DATETIME()) + "] CriarObjectConnLegado: " + ;
                  loc_oErro.Message + CHR(13) + CHR(10), ;
                  ADDBS(gc_4c_CaminhoBase) + "ObjectConn_Erro.log", 1)
    ENDTRY
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

