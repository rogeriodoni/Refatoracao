*==============================================================================
* sigproerBO.prg - Business Object para Reimpressao SiTef
* Form original: SIGPROER.SCX
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS sigproerBO AS BusinessBase

    *-- Parametros recebidos na abertura do form
    this_cEndSitef   = ""   && Endereco servidor SiTef
    this_cCaixa      = ""   && Identificador do caixa
    this_cNSU        = ""   && Numero Sequencial Unico
    this_cData       = ""   && Data da transacao original
    this_cHora       = ""   && Hora da transacao original
    this_cValor      = ""   && Valor da transacao (string formatada para DLL)
    this_cCodEstabs  = ""   && Codigo do estabelecimento

    *-- Dados da empresa carregados de SigCdEmp
    this_cEmpresa    = ""   && Cemps char(3)
    this_cIdTerminal = ""   && Identificador do terminal composto (Empresa+Caixa)

    *-- Estado do protocolo SiTef (equivalente as PUBLICs do legado)
    this_nProximoComando = 0    && ProximoComando
    this_nTipoCampo      = 0    && TipoCampo
    this_nTamanhoMinimo  = 0    && TamanhoMinimo
    this_nTamanhoMaximo  = 0    && TamanhoMaximo
    this_cBuffer         = ""   && Buffer 2000 bytes (preenchido com Chr(0))
    this_nContinua       = 0    && lnContinua (flag de continuacao da DLL)
    this_lIdentificado   = .F.  && ltIdent

    *-- Acumula linhas do cupom durante protocolo (tipos 121/122)
    this_cCupom      = ""

    *-- Ultima mensagem recebida do SiTef (tipo <> 30)
    this_cMensagem   = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta: NSU + Caixa + Data
    * (SIGPROER nao persiste entidade CRUD; chave usada apenas para auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cNSU) + "|" + ;
                     ALLTRIM(THIS.this_cCaixa) + "|" + ;
                     ALLTRIM(THIS.this_cData)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida parametros recebidos antes do protocolo SiTef
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(THIS.this_cEndSitef)
            MsgAviso("Endere" + CHR(231) + "o do servidor SiTef n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(THIS.this_cCaixa)
            MsgAviso("Identificador do caixa n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura estado do BO a partir de cursor de parametros
    * (SIGPROER nao tem tabela persistente; este metodo hidrata os parametros
    *  quando recebidos via cursor em vez de parametros diretos do Init)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF
            SELECT (par_cAliasCursor)
            IF RECCOUNT(par_cAliasCursor) = 0
                loc_lSucesso = .F.
            ENDIF
            *-- Mapeia colunas do cursor para propriedades
            IF TYPE(par_cAliasCursor + ".EndSitef") != "U"
                THIS.this_cEndSitef = ALLTRIM(NVL(EndSitef, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Caixa") != "U"
                THIS.this_cCaixa = ALLTRIM(NVL(Caixa, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".NSU") != "U"
                THIS.this_cNSU = ALLTRIM(NVL(NSU, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Data") != "U"
                THIS.this_cData = ALLTRIM(NVL(Data, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Hora") != "U"
                THIS.this_cHora = ALLTRIM(NVL(Hora, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Valor") != "U"
                THIS.this_cValor = ALLTRIM(NVL(Valor, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".CodEstabs") != "U"
                THIS.this_cCodEstabs = ALLTRIM(NVL(CodEstabs, ""))
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Executa reimpressao via protocolo SiTef
    * Em SIGPROER, "inserir" significa executar o ciclo completo de reimpressao
    * (SIGPROER nao grava em tabela do banco; a "persistencia" sao os arquivos
    *  IntPos.001 e IntPos.STS gravados por MontaRetorno/RetornoFalha)
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.CarregarDadosEmpresa()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.IniciarProtocolo()
                loc_lSucesso = .F.
            ENDIF
            *-- Auditoria da operacao de reimpressao
            THIS.RegistrarAuditoria("REIMPRESSAO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa reimpressao (executa nova tentativa do ciclo SiTef)
    * (SIGPROER nao possui entidade persistente para atualizar; reaproveita
    *  o ciclo de Inserir com registro de auditoria diferente)
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.CarregarDadosEmpresa()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.IniciarProtocolo()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("REPROCESSAMENTO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao de reimpressao SiTef em LogAuditoria
    *--------------------------------------------------------------------------
    FUNCTION RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_cEmpresa, loc_oErro
        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            IF EMPTY(loc_cEmpresa) AND TYPE("go_4c_Sistema") = "O"
                loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, ChaveRegistro, Operacao, DadosNovos) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                       EscaparSQL("SIGPROER") + ", " + ;
                       EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                       EscaparSQL(LEFT(par_cOperacao, 10)) + ", " + ;
                       EscaparSQL(LEFT("NSU=" + ALLTRIM(THIS.this_cNSU) + ;
                                       " Caixa=" + ALLTRIM(THIS.this_cCaixa) + ;
                                       " Data=" + ALLTRIM(THIS.this_cData), 200)) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao pode bloquear operacao principal; apenas registra erro
            IF TYPE("loc_oErro") = "O"
                MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
            ENDIF
        ENDTRY
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDadosEmpresa()
        *-- Carrega codigo empresa de SigCdEmp e monta IdTerminal
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0 AND ;
               USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                THIS.this_cEmpresa = ALLTRIM(NVL(Cemps, ""))
            ELSE
                THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
            *-- ID loja: pcCodEstabs se informado, senao "00000" + empresa
            IF EMPTY(THIS.this_cCodEstabs)
                THIS.this_cIdTerminal = "00000" + THIS.this_cEmpresa
            ELSE
                THIS.this_cIdTerminal = THIS.this_cCodEstabs
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION IniciarProtocolo()
        *-- Chama ConfiguraIntSiTefInterativo e IniciaFuncaoSiTefInterativo
        LOCAL loc_lSucesso, loc_cValores, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- ID terminal = empresa + caixa (6 digitos)
            LOCAL loc_cIdTerminal
            loc_cIdTerminal = ALLTRIM(THIS.this_cEmpresa) + ;
                              TRANSFORM(VAL(THIS.this_cCaixa), "@L 999999")

            IF ConfiguraIntSiTefInterativo(THIS.this_cEndSitef, THIS.this_cIdTerminal, loc_cIdTerminal, 0) <> 0
                THIS.RetornoFalha("Sem comunicacao com SiTef")
                loc_lSucesso = .F.
            ENDIF
            IF !EMPTY(THIS.this_cValor)
                loc_cValores = STRTRAN(ALLTRIM(TRANSFORM(VAL(THIS.this_cValor), "999999999999.99")), ".", ",")
            ELSE
                loc_cValores = ""
            ENDIF
            IF IniciaFuncaoSiTefInterativo(IIF(EMPTY(THIS.this_cData), 114, 113), loc_cValores, "1", "", "", "", "") <> 10000
                THIS.RetornoFalha("Sem comunicacao com SiTef")
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ExecutarCicloSiTef()
        *-- Loop ContinuaFuncaoSiTefInterativo ate TipoCampo=500 (aguarda cartao/senha)
        *-- Retorna o ultimo lnRetorno da DLL (0=ok, <0=falha, 10000=continua)
        LOCAL loc_nProxCmd, loc_nTipoCampo, loc_nTamMin, loc_nTamMax
        LOCAL loc_cBuffer, loc_nContinua, loc_nRetorno, loc_nTipo

        loc_nTipo      = 1
        loc_nProxCmd   = 0
        loc_nTipoCampo = 0
        loc_nTamMin    = 0
        loc_nTamMax    = 0
        loc_cBuffer    = REPLICATE(CHR(0), 2000)
        loc_nContinua  = 0
        loc_nRetorno   = 0
        THIS.this_cMensagem = ""

        DO WHILE loc_nTipoCampo <> 500
            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

            THIS.this_nProximoComando = loc_nProxCmd
            THIS.this_nTipoCampo      = loc_nTipoCampo
            THIS.this_nTamanhoMinimo  = loc_nTamMin
            THIS.this_nTamanhoMaximo  = loc_nTamMax
            THIS.this_cBuffer         = loc_cBuffer

            IF loc_nRetorno < 0
                THIS.this_cMensagem = loc_cBuffer
                RETURN loc_nRetorno
            ENDIF

            IF loc_nProxCmd = 30 AND !EMPTY(THIS.this_cNSU)
                IF loc_nTipo = 1
                    loc_cBuffer = TRANSFORM(VAL(THIS.this_cNSU), "@L 999999999")
                    loc_cBuffer = loc_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_cBuffer))
                    loc_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    loc_cBuffer = THIS.this_cData + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cData))
                    loc_nContinua = 1000
                    loc_nTipo = 3
                    LOOP
                ENDIF
            ENDIF

            IF loc_nProxCmd <> 30
                THIS.this_cMensagem = loc_cBuffer
                loc_cBuffer   = REPLICATE(CHR(0), 2000)
                loc_nContinua = 0
            ENDIF
        ENDDO

        RETURN loc_nRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ProcessarRespostaGetSenha(par_cValor)
        *-- Processa resposta apos leitura do cartao (equivale a GetSenha.LostFocus)
        LOCAL loc_nProxCmd, loc_nTipoCampo, loc_nTamMin, loc_nTamMax
        LOCAL loc_cBuffer, loc_nContinua, loc_nRetorno, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCupom    = ""
            THIS.this_cMensagem = ""
            loc_cBuffer   = ALLTRIM(par_cValor) + REPLICATE(CHR(0), 2000 - LEN(ALLTRIM(par_cValor)))
            loc_nContinua = 1000
            loc_nProxCmd  = THIS.this_nProximoComando
            loc_nTipoCampo = THIS.this_nTipoCampo
            loc_nTamMin   = THIS.this_nTamanhoMinimo
            loc_nTamMax   = THIS.this_nTamanhoMaximo

            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)
            loc_nContinua = 0

            DO WHILE loc_nRetorno = 10000
                loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                    @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                    @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

                IF loc_nRetorno < 0
                    THIS.RetornoFalha(THIS.this_cMensagem)
                    loc_lSucesso = .F.
                ENDIF
                IF UPPER(ALLTRIM(loc_cBuffer)) = "DOC INEXISTENTE"
                    THIS.RetornoFalha("DOC INEXISTENTE")
                    loc_lSucesso = .F.
                ENDIF
                IF loc_nTipoCampo = 121 AND EMPTY(THIS.this_cCupom)
                    THIS.this_cCupom = loc_cBuffer + loc_cBuffer
                ENDIF
                IF loc_nTipoCampo = 122
                    THIS.this_cCupom = THIS.this_cCupom + loc_cBuffer
                ENDIF
                IF loc_nProxCmd = 20
                    loc_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
                    loc_nContinua = 1000
                    LOOP
                ELSE
                    THIS.this_cMensagem = loc_cBuffer
                    loc_cBuffer   = REPLICATE(CHR(0), 2000)
                    loc_nContinua = 0
                ENDIF
            ENDDO

            IF loc_nRetorno = 0
                THIS.MontaRetorno(THIS.this_cCupom)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ProcessarRespostaSenha(par_cValor)
        *-- Processa resposta apos digitacao da senha (equivale a SENHA.LostFocus)
        LOCAL loc_nProxCmd, loc_nTipoCampo, loc_nTamMin, loc_nTamMax
        LOCAL loc_cBuffer, loc_nContinua, loc_nRetorno, loc_lSucesso, loc_lVias, loc_oErro
        loc_lSucesso = .F.
        loc_lVias    = .F.
        TRY
            THIS.this_cCupom    = ""
            THIS.this_cMensagem = ""
            loc_cBuffer   = ALLTRIM(par_cValor) + REPLICATE(CHR(0), 2000 - LEN(ALLTRIM(par_cValor)))
            loc_nContinua = 1000
            loc_nProxCmd  = THIS.this_nProximoComando
            loc_nTipoCampo = THIS.this_nTipoCampo
            loc_nTamMin   = THIS.this_nTamanhoMinimo
            loc_nTamMax   = THIS.this_nTamanhoMaximo

            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)
            loc_nContinua = 0

            DO WHILE loc_nRetorno = 10000
                loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                    @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                    @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

                IF loc_nRetorno < 0
                    THIS.RetornoFalha(THIS.this_cMensagem)
                    loc_lSucesso = .F.
                ENDIF
                IF UPPER(ALLTRIM(loc_cBuffer)) = "DOC INEXISTENTE"
                    THIS.RetornoFalha("DOC INEXISTENTE")
                    loc_lSucesso = .F.
                ENDIF
                IF loc_nProxCmd = 30 AND loc_nTipoCampo = 515
                    loc_cBuffer = THIS.this_cData + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cData))
                    LOOP
                ENDIF
                IF loc_nProxCmd = 30 AND loc_nTipoCampo = 516
                    IF !EMPTY(THIS.this_cValor)
                        loc_cBuffer = TRANSFORM(VAL(THIS.this_cNSU), "@L 999999")
                    ELSE
                        loc_cBuffer = TRANSFORM(VAL(THIS.this_cNSU), "@L 999999999")
                    ENDIF
                    loc_cBuffer = loc_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_cBuffer))
                    LOOP
                ENDIF
                IF loc_nTipoCampo = 121 AND EMPTY(THIS.this_cCupom)
                    THIS.this_cCupom = loc_cBuffer + loc_cBuffer
                ENDIF
                IF loc_nTipoCampo = 122
                    THIS.this_cCupom = THIS.this_cCupom + loc_cBuffer
                ENDIF
                IF loc_lVias
                    loc_cBuffer   = "3" + REPLICATE(CHR(0), 1999)
                    loc_lVias     = .F.
                    LOOP
                ENDIF
                IF UPPER(ALLTRIM(loc_cBuffer)) = "VIA A SER REIMPRESSA"
                    loc_lVias = .T.
                ENDIF
                IF loc_nProxCmd = 20
                    loc_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
                    loc_nContinua = 1000
                    LOOP
                ELSE
                    THIS.this_cMensagem = loc_cBuffer
                    loc_cBuffer   = REPLICATE(CHR(0), 2000)
                    loc_nContinua = 0
                ENDIF
            ENDDO

            IF loc_nRetorno = 0
                THIS.MontaRetorno(THIS.this_cCupom)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION MontaRetorno(par_cCupom)
        *-- Grava arquivos IntPos.001 e IntPos.STS com resposta de sucesso
        LOCAL loc_cCupom, loc_lPos, loc_nLinha, loc_oErro
        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + ALLTRIM(THIS.this_cNSU))
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")

            loc_cCupom  = par_cCupom
            loc_lPos    = 1
            loc_nLinha  = 1
            DO WHILE loc_lPos <> 0
                loc_lPos = AT(CHR(10), loc_cCupom)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + ;
                    " = " + IIF(loc_lPos <> 0, SUBSTR(loc_cCupom, 1, loc_lPos - 1), loc_cCupom))
                loc_cCupom = SUBSTR(loc_cCupom, loc_lPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO

            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION RetornoFalha(par_cMensagem)
        *-- Grava arquivos IntPos.001 e IntPos.STS com resposta de falha
        LOCAL loc_oErro
        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMensagem)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
