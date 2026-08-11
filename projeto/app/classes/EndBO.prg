*==============================================================================
* EndBO.prg
*
* Business Object para Cadastro de Enderecos de Entrega (SIGCDCEE)
* Tabela: SIGCDCEE
* Herda de: BusinessBase
*
* Form OPERACIONAL: gerencia enderecos de entrega de clientes
* Chamado por: FormCliente (e outros forms de cadastro de clientes)
* Parametros: grupo, IClis, nome, modo, codigos
*==============================================================================

DEFINE CLASS EndBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para SIGCDCEE)
    this_lAtuals    = .F.   && atuals   bit          - endereco ativo/atual
    this_cBairs     = ""    && bairs    char(40)     - bairro
    this_cCeps      = ""    && ceps     char(9)      - CEP
    this_cCidas     = ""    && cidas    char(30)     - cidade
    this_nCodigos   = 0     && codigos  numeric(10,0) - codigo (PK)
    this_cCompls    = ""    && compls   char(50)     - complemento
    this_cContatos  = ""    && contatos char(20)     - contato
    this_cDdds      = ""    && ddds     char(4)      - DDD
    this_cDescrs    = ""    && descrs   char(50)     - descricao do local
    this_cEndes     = ""    && endes    char(60)     - endereco
    this_cEstas     = ""    && estas    char(2)      - estado (UF)
    this_cIClis     = ""    && iclis    char(10)     - codigo do cliente
    this_cNums      = ""    && nums     char(10)     - numero
    this_cPaises    = ""    && paises   char(30)     - pais
    this_cRefers    = ""    && refers   text         - observacoes
    this_cTel1s     = ""    && tel1s    char(20)     - telefone 1
    this_cTel2s     = ""    && tel2s    char(20)     - telefone 2
    this_cIdentrega = ""    && identrega char(50)    - identificador de entrega

    *-- Propriedades operacionais (nao persistidas - contexto do form)
    this_cNome           = ""    && nome do cliente (parametro pDes)
    this_cGrupo          = ""    && grupo do cliente (parametro pGru - para SigCdGcr)
    this_cModo           = ""    && modo: CONSULTAR/INSERIR/ALTERAR
    this_nCodigosBusca   = 0     && codigo do local a localizar (pCod)
    this_nCepObris       = 0     && flag CEP obrigatorio (SigCdGcr.cepobris)
    this_nChkEndDs       = 0     && flag verifica endereco duplicado (SigCdGcr.chkendds)
    this_nChkEndRs       = 0     && flag verifica bairro restrito (SigCdGcr.chkendrs)
    this_lTipoPais       = .F.   && .T. quando pais != BRASIL
    this_cTipoCep        = "1"   && tipo CEP
    this_lEntraInserindo = .F.   && flag: entrou em modo inserir automaticamente

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SIGCDCEE"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Mapeia registro do cursor para propriedades do BO
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos  = NVL(Codigos, 0)
                THIS.this_cIClis    = NVL(ALLTRIM(Iclis), "")
                THIS.this_lAtuals   = IIF(VARTYPE(Atuals) = "L", ;
                                        NVL(Atuals, .F.), NVL(Atuals, 0) <> 0)
                THIS.this_cDescrs   = NVL(ALLTRIM(Descrs), "")
                THIS.this_cCeps     = NVL(ALLTRIM(Ceps), "")
                THIS.this_cPaises   = NVL(ALLTRIM(Paises), "")
                THIS.this_cEndes    = NVL(ALLTRIM(Endes), "")
                THIS.this_cNums     = NVL(ALLTRIM(Nums), "")
                THIS.this_cCompls   = NVL(ALLTRIM(Compls), "")
                THIS.this_cBairs    = NVL(ALLTRIM(Bairs), "")
                THIS.this_cCidas    = NVL(ALLTRIM(Cidas), "")
                THIS.this_cEstas    = NVL(ALLTRIM(Estas), "")
                THIS.this_cDdds     = NVL(ALLTRIM(Ddds), "")
                THIS.this_cTel1s    = NVL(ALLTRIM(Tel1s), "")
                THIS.this_cTel2s    = NVL(ALLTRIM(Tel2s), "")
                THIS.this_cContatos = NVL(ALLTRIM(Contatos), "")
                THIS.this_cRefers   = NVL(Refers, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GerarCodigoUnico - Gera codigo unico para Codigos (PK) em SigCdCeE
    * Substitui fGerUniqueKey('SigCdCeE') do legado
    *====================================================================
    FUNCTION GerarCodigoUnico()
        LOCAL loc_nCodigo, loc_nRet
        loc_nCodigo = 0
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(Codigos), 0) + 1 AS ProxCodigo FROM SigCdCeE", ;
                "cursor_4c_ProxCodigo")
            IF loc_nRet > 0 AND !EOF("cursor_4c_ProxCodigo")
                SELECT cursor_4c_ProxCodigo
                loc_nCodigo = NVL(ProxCodigo, 1)
            ENDIF
            IF USED("cursor_4c_ProxCodigo")
                USE IN cursor_4c_ProxCodigo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.GerarCodigoUnico")
        ENDTRY
        RETURN loc_nCodigo
    ENDFUNC

    *====================================================================
    * Inserir - INSERT INTO SigCdCeE com todos os campos
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nCodigos <= 0
                THIS.this_nCodigos = THIS.GerarCodigoUnico()
            ENDIF
            IF THIS.this_nCodigos <= 0
                MsgErro("Falha ao gerar c" + CHR(243) + "digo para endere" + ;
                    CHR(231) + "o.", "EndBO.Inserir")
            ELSE
                loc_cSQL = "INSERT INTO SigCdCeE " + ;
                    "(Codigos, IClis, Atuals, Descrs, Ceps, Paises," + ;
                    " Endes, Nums, Compls, Bairs, Cidas, Estas," + ;
                    " Ddds, Tel1s, Tel2s, Contatos, Refers) " + ;
                    "VALUES (" + ;
                    FormatarNumeroSQL(THIS.this_nCodigos, 0) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cIClis, 10)) + "," + ;
                    IIF(THIS.this_lAtuals, "1", "0") + "," + ;
                    EscaparSQL(LEFT(THIS.this_cDescrs, 50)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cCeps, 9)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cPaises, 30)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cEndes, 60)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cNums, 10)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cCompls, 50)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cBairs, 40)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cCidas, 30)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cEstas, 2)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cDdds, 4)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cTel1s, 20)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cTel2s, 20)) + "," + ;
                    EscaparSQL(LEFT(THIS.this_cContatos, 20)) + "," + ;
                    EscaparSQL(THIS.this_cRefers) + ")"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha ao inserir endere" + CHR(231) + "o: " + ;
                        ALLTRIM(THIS.this_cDescrs), "EndBO.Inserir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE SigCdCeE com todos os campos
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdCeE SET " + ;
                "Atuals = " + IIF(THIS.this_lAtuals, "1", "0") + "," + ;
                "Descrs = " + EscaparSQL(LEFT(THIS.this_cDescrs, 50)) + "," + ;
                "Ceps = " + EscaparSQL(LEFT(THIS.this_cCeps, 9)) + "," + ;
                "Paises = " + EscaparSQL(LEFT(THIS.this_cPaises, 30)) + "," + ;
                "Endes = " + EscaparSQL(LEFT(THIS.this_cEndes, 60)) + "," + ;
                "Nums = " + EscaparSQL(LEFT(THIS.this_cNums, 10)) + "," + ;
                "Compls = " + EscaparSQL(LEFT(THIS.this_cCompls, 50)) + "," + ;
                "Bairs = " + EscaparSQL(LEFT(THIS.this_cBairs, 40)) + "," + ;
                "Cidas = " + EscaparSQL(LEFT(THIS.this_cCidas, 30)) + "," + ;
                "Estas = " + EscaparSQL(LEFT(THIS.this_cEstas, 2)) + "," + ;
                "Ddds = " + EscaparSQL(LEFT(THIS.this_cDdds, 4)) + "," + ;
                "Tel1s = " + EscaparSQL(LEFT(THIS.this_cTel1s, 20)) + "," + ;
                "Tel2s = " + EscaparSQL(LEFT(THIS.this_cTel2s, 20)) + "," + ;
                "Contatos = " + EscaparSQL(LEFT(THIS.this_cContatos, 20)) + "," + ;
                "Refers = " + EscaparSQL(THIS.this_cRefers) + " " + ;
                "WHERE IClis = " + EscaparSQL(THIS.this_cIClis) + ;
                " AND Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar endere" + CHR(231) + "o: " + ;
                    ALLTRIM(THIS.this_cDescrs), "EndBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE FROM SigCdCeE (chamado por Excluir da BusinessBase)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdCeE " + ;
                "WHERE IClis = " + EscaparSQL(THIS.this_cIClis) + ;
                " AND Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao excluir endere" + CHR(231) + "o: " + ;
                    ALLTRIM(THIS.this_cDescrs), "EndBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarEnderecos - Carrega enderecos do cliente em cursor crCursorCliEE
    * Equivale ao SELECT * FROM SigCdCeE do Init legado
    *====================================================================
    FUNCTION CarregarEnderecos(par_cIClis, par_nCodigo)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("crCursorCliEE")
                USE IN crCursorCliEE
            ENDIF
            DO CASE
                CASE par_nCodigo = 0
                    loc_cSQL = "SELECT * FROM SigCdCeE " + ;
                        "WHERE IClis = " + EscaparSQL(par_cIClis)
                OTHERWISE
                    loc_cSQL = "SELECT * FROM SigCdCeE " + ;
                        "WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                        " AND Codigos = " + FormatarNumeroSQL(par_nCodigo, 0)
            ENDCASE
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crCursorCliEE")
            IF loc_nRet > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar endere" + CHR(231) + "os do cliente " + ;
                    ALLTRIM(par_cIClis), "EndBO.CarregarEnderecos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.CarregarEnderecos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarConfigGrupo - Carrega flags de CepObris/ChkEndDs/ChkEndRs de SigCdGcr
    * Equivale ao SqlExecute de SigCdGcr no Init legado
    *====================================================================
    FUNCTION CarregarConfigGrupo(par_cGrupo)
        LOCAL loc_lSucesso, loc_nRet
        loc_lSucesso = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT CepObris, ChkEndds, ChkEndrs FROM SigCdGcr " + ;
                "WHERE codigos = " + EscaparSQL(par_cGrupo), ;
                "cursor_4c_ConfigGrupo")
            IF loc_nRet > 0 AND !EOF("cursor_4c_ConfigGrupo")
                SELECT cursor_4c_ConfigGrupo
                THIS.this_nCepObris = NVL(CepObris, 2)
                THIS.this_nChkEndDs = IIF(VARTYPE(ChkEndds) = "L", ;
                    IIF(ChkEndds, 1, 0), NVL(ChkEndds, 0))
                THIS.this_nChkEndRs = IIF(VARTYPE(ChkEndrs) = "L", ;
                    IIF(ChkEndrs, 1, 0), NVL(ChkEndrs, 0))
            ELSE
                THIS.this_nCepObris = 2
                THIS.this_nChkEndDs = 0
                THIS.this_nChkEndRs = 0
            ENDIF
            IF USED("cursor_4c_ConfigGrupo")
                USE IN cursor_4c_ConfigGrupo
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.CarregarConfigGrupo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarDuplicidade - Verifica se descricao do local ja existe para o cliente
    * Equivale ao SELECT Descrs FROM SigCdCeE WHERE IClis=... AND Descrs=... do m_confirmar
    *====================================================================
    FUNCTION VerificarDuplicidade(par_cIClis, par_cDescrs, par_nCodigos)
        LOCAL loc_lDuplicado, loc_nRet
        loc_lDuplicado = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nQtd FROM SigCdCeE " + ;
                "WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                " AND RTRIM(Descrs) = " + EscaparSQL(ALLTRIM(par_cDescrs)) + ;
                " AND Codigos <> " + FormatarNumeroSQL(par_nCodigos, 0), ;
                "cursor_4c_DupVerif")
            IF loc_nRet > 0 AND !EOF("cursor_4c_DupVerif")
                SELECT cursor_4c_DupVerif
                loc_lDuplicado = (NVL(nQtd, 0) > 0)
            ENDIF
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarDuplicidade")
        ENDTRY
        RETURN loc_lDuplicado
    ENDFUNC

    *====================================================================
    * VerificarEnderecoDuplicado - Verifica endereco duplicado (usado quando chkendds=1)
    * Equivale ao SELECT iclis FROM SigCdCee WHERE ceps=... AND endes=... do m_confirmar
    * Retorna string com IClis dos clientes que tem mesmo endereco (separados por espaco)
    *====================================================================
    FUNCTION VerificarEnderecoDuplicado(par_cIClis, par_cCep, par_cEnde, par_cBairro, par_nCodigos)
        LOCAL loc_cContas, loc_nRet
        loc_cContas = ""
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT RTRIM(IClis) AS IClis FROM SigCdCeE " + ;
                "WHERE Ceps = " + EscaparSQL(par_cCep) + ;
                " AND RTRIM(Endes) = " + EscaparSQL(ALLTRIM(par_cEnde)) + ;
                " AND RTRIM(Bairs) = " + EscaparSQL(ALLTRIM(par_cBairro)) + ;
                " AND Codigos <> " + FormatarNumeroSQL(par_nCodigos, 0), ;
                "cursor_4c_EndDup")
            IF loc_nRet > 0 AND !EOF("cursor_4c_EndDup")
                SELECT cursor_4c_EndDup
                SCAN
                    loc_cContas = loc_cContas + ALLTRIM(cursor_4c_EndDup.IClis) + " "
                ENDSCAN
            ENDIF
            IF USED("cursor_4c_EndDup")
                USE IN cursor_4c_EndDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarEnderecoDuplicado")
        ENDTRY
        RETURN ALLTRIM(loc_cContas)
    ENDFUNC

    *====================================================================
    * SalvarEnderecos - Sincroniza cursor crCursorCliEE com SigCdCeE no SQL Server
    * Substitui poDataMgr.Update('crCursorCliEE') do m_confirmar legado
    *====================================================================
    FUNCTION SalvarEnderecos(par_cIClis)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        LOCAL loc_lAtuals, loc_nCodigos, loc_cDescrs
        LOCAL loc_cCeps, loc_cPaises, loc_cEndes, loc_cNums
        LOCAL loc_cCompls, loc_cBairs, loc_cCidas, loc_cEstas
        LOCAL loc_cDdds, loc_cTel1s, loc_cTel2s, loc_cContatos, loc_cRefers
        LOCAL loc_nQtdExiste
        loc_lSucesso = .F.
        TRY
            IF !USED("crCursorCliEE")
                MsgErro("Cursor crCursorCliEE n" + CHR(227) + "o est" + CHR(225) + ;
                    " aberto.", "EndBO.SalvarEnderecos")
            ELSE
                THIS.ExcluirSigCdClt(par_cIClis)
                SELECT crCursorCliEE
                SCAN
                    IF !DELETED() AND !EMPTY(RTRIM(crCursorCliEE.Descrs))
                        loc_lAtuals   = IIF(VARTYPE(crCursorCliEE.Atuals) = "L", ;
                            crCursorCliEE.Atuals, crCursorCliEE.Atuals <> 0)
                        loc_nCodigos  = NVL(crCursorCliEE.Codigos, 0)
                        loc_cDescrs   = NVL(ALLTRIM(crCursorCliEE.Descrs), "")
                        loc_cCeps     = NVL(ALLTRIM(crCursorCliEE.Ceps), "")
                        loc_cPaises   = NVL(ALLTRIM(crCursorCliEE.Paises), "")
                        loc_cEndes    = NVL(ALLTRIM(crCursorCliEE.Endes), "")
                        loc_cNums     = NVL(ALLTRIM(crCursorCliEE.Nums), "")
                        loc_cCompls   = NVL(ALLTRIM(crCursorCliEE.Compls), "")
                        loc_cBairs    = NVL(ALLTRIM(crCursorCliEE.Bairs), "")
                        loc_cCidas    = NVL(ALLTRIM(crCursorCliEE.Cidas), "")
                        loc_cEstas    = NVL(ALLTRIM(crCursorCliEE.Estas), "")
                        loc_cDdds     = NVL(ALLTRIM(crCursorCliEE.Ddds), "")
                        loc_cTel1s    = NVL(ALLTRIM(crCursorCliEE.Tel1s), "")
                        loc_cTel2s    = NVL(ALLTRIM(crCursorCliEE.Tel2s), "")
                        loc_cContatos = NVL(ALLTRIM(crCursorCliEE.Contatos), "")
                        loc_cRefers   = NVL(crCursorCliEE.Refers, "")
                        IF loc_nCodigos <= 0
                            loc_nCodigos = THIS.GerarCodigoUnico()
                        ENDIF
                        loc_nRet = SQLEXEC(gnConnHandle, ;
                            "SELECT COUNT(*) AS nQtd FROM SigCdCeE " + ;
                            "WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                            " AND Codigos = " + FormatarNumeroSQL(loc_nCodigos, 0), ;
                            "cursor_4c_ExisteVerif")
                        loc_nQtdExiste = 0
                        IF loc_nRet > 0 AND !EOF("cursor_4c_ExisteVerif")
                            SELECT cursor_4c_ExisteVerif
                            loc_nQtdExiste = NVL(nQtd, 0)
                        ENDIF
                        IF USED("cursor_4c_ExisteVerif")
                            USE IN cursor_4c_ExisteVerif
                        ENDIF
                        IF loc_nQtdExiste > 0
                            loc_cSQL = "UPDATE SigCdCeE SET " + ;
                                "Atuals = " + IIF(loc_lAtuals, "1", "0") + "," + ;
                                "Descrs = " + EscaparSQL(LEFT(loc_cDescrs, 50)) + "," + ;
                                "Ceps = " + EscaparSQL(LEFT(loc_cCeps, 9)) + "," + ;
                                "Paises = " + EscaparSQL(LEFT(loc_cPaises, 30)) + "," + ;
                                "Endes = " + EscaparSQL(LEFT(loc_cEndes, 60)) + "," + ;
                                "Nums = " + EscaparSQL(LEFT(loc_cNums, 10)) + "," + ;
                                "Compls = " + EscaparSQL(LEFT(loc_cCompls, 50)) + "," + ;
                                "Bairs = " + EscaparSQL(LEFT(loc_cBairs, 40)) + "," + ;
                                "Cidas = " + EscaparSQL(LEFT(loc_cCidas, 30)) + "," + ;
                                "Estas = " + EscaparSQL(LEFT(loc_cEstas, 2)) + "," + ;
                                "Ddds = " + EscaparSQL(LEFT(loc_cDdds, 4)) + "," + ;
                                "Tel1s = " + EscaparSQL(LEFT(loc_cTel1s, 20)) + "," + ;
                                "Tel2s = " + EscaparSQL(LEFT(loc_cTel2s, 20)) + "," + ;
                                "Contatos = " + EscaparSQL(LEFT(loc_cContatos, 20)) + "," + ;
                                "Refers = " + EscaparSQL(loc_cRefers) + " " + ;
                                "WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                                " AND Codigos = " + FormatarNumeroSQL(loc_nCodigos, 0)
                        ELSE
                            loc_cSQL = "INSERT INTO SigCdCeE " + ;
                                "(Codigos, IClis, Atuals, Descrs, Ceps, Paises," + ;
                                " Endes, Nums, Compls, Bairs, Cidas, Estas," + ;
                                " Ddds, Tel1s, Tel2s, Contatos, Refers) " + ;
                                "VALUES (" + ;
                                FormatarNumeroSQL(loc_nCodigos, 0) + "," + ;
                                EscaparSQL(LEFT(par_cIClis, 10)) + "," + ;
                                IIF(loc_lAtuals, "1", "0") + "," + ;
                                EscaparSQL(LEFT(loc_cDescrs, 50)) + "," + ;
                                EscaparSQL(LEFT(loc_cCeps, 9)) + "," + ;
                                EscaparSQL(LEFT(loc_cPaises, 30)) + "," + ;
                                EscaparSQL(LEFT(loc_cEndes, 60)) + "," + ;
                                EscaparSQL(LEFT(loc_cNums, 10)) + "," + ;
                                EscaparSQL(LEFT(loc_cCompls, 50)) + "," + ;
                                EscaparSQL(LEFT(loc_cBairs, 40)) + "," + ;
                                EscaparSQL(LEFT(loc_cCidas, 30)) + "," + ;
                                EscaparSQL(LEFT(loc_cEstas, 2)) + "," + ;
                                EscaparSQL(LEFT(loc_cDdds, 4)) + "," + ;
                                EscaparSQL(LEFT(loc_cTel1s, 20)) + "," + ;
                                EscaparSQL(LEFT(loc_cTel2s, 20)) + "," + ;
                                EscaparSQL(LEFT(loc_cContatos, 20)) + "," + ;
                                EscaparSQL(loc_cRefers) + ")"
                        ENDIF
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    SELECT crCursorCliEE
                ENDSCAN
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCeE WHERE IClis = " + EscaparSQL(par_cIClis) + ;
                    " AND (Descrs IS NULL OR RTRIM(Descrs) = '')")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.SalvarEnderecos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExcluirSigCdClt - Limpa SigCdClt do cliente antes de salvar enderecos
    * Equivale ao DELETE FROM SigCdClt WHERE IClis=... do m_confirmar legado
    *====================================================================
    PROTECTED PROCEDURE ExcluirSigCdClt(par_cIClis)
        LOCAL loc_cSQL
        TRY
            loc_cSQL = "DELETE FROM SigCdClt WHERE IClis = " + EscaparSQL(par_cIClis)
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.ExcluirSigCdClt")
        ENDTRY
    ENDPROC

    *====================================================================
    * ObterEnderecoPrincipal - Busca endereco principal do cliente em SigCdCli
    * Usado por m_CopiarP para copiar endereco do cadastro do cliente
    * Cursor resultado: cursor_4c_EndPrincipal
    *====================================================================
    FUNCTION ObterEnderecoPrincipal(par_cIClis)
        LOCAL loc_lSucesso, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_EndPrincipal")
                USE IN cursor_4c_EndPrincipal
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT Ceps, Paises, Endes, Nums, Compls," + ;
                " Bairs, Cidas, Estas, Ddds, Tel1s, Tel2s, Contato" + ;
                " FROM SigCdCli" + ;
                " WHERE IClis = " + EscaparSQL(par_cIClis), ;
                "cursor_4c_EndPrincipal")
            IF loc_nRet > 0 AND !EOF("cursor_4c_EndPrincipal")
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_EndPrincipal")
                    USE IN cursor_4c_EndPrincipal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.ObterEnderecoPrincipal")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarCepRestrito - Verifica se CEP consta em SigCdEnr (chkendrs=1)
    * Equivale ao SELECT * FROM SigCdEnr WHERE Ceps=... do getCeps.LostFocus legado
    *====================================================================
    FUNCTION VerificarCepRestrito(par_cCep)
        LOCAL loc_lRestrito, loc_nRet
        loc_lRestrito = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nQtd FROM SigCdEnr " + ;
                "WHERE Ceps = " + EscaparSQL(par_cCep), ;
                "cursor_4c_CepRestr")
            IF loc_nRet > 0 AND !EOF("cursor_4c_CepRestr")
                SELECT cursor_4c_CepRestr
                loc_lRestrito = (NVL(nQtd, 0) > 0)
            ENDIF
            IF USED("cursor_4c_CepRestr")
                USE IN cursor_4c_CepRestr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarCepRestrito")
        ENDTRY
        RETURN loc_lRestrito
    ENDFUNC

    *====================================================================
    * VerificarBairroRestrito - Verifica se bairro consta em SigCdEnr (chkendrs=1)
    * Equivale ao SELECT * FROM SigCdEnr WHERE Bairs=... do getBairs.LostFocus legado
    *====================================================================
    FUNCTION VerificarBairroRestrito(par_cBairro)
        LOCAL loc_lRestrito, loc_nRet
        loc_lRestrito = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nQtd FROM SigCdEnr " + ;
                "WHERE Bairs = " + EscaparSQL(par_cBairro), ;
                "cursor_4c_BaiRestr")
            IF loc_nRet > 0 AND !EOF("cursor_4c_BaiRestr")
                SELECT cursor_4c_BaiRestr
                loc_lRestrito = (NVL(nQtd, 0) > 0)
            ENDIF
            IF USED("cursor_4c_BaiRestr")
                USE IN cursor_4c_BaiRestr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarBairroRestrito")
        ENDTRY
        RETURN loc_lRestrito
    ENDFUNC

    *====================================================================
    * VerificarEnderecoRestrito - Verifica se logradouro consta em SigCdEnr (chkendrs=1)
    * Equivale ao SELECT * FROM SigCdEnr WHERE Endes=... do getEndes.LostFocus legado
    *====================================================================
    FUNCTION VerificarEnderecoRestrito(par_cEnde)
        LOCAL loc_lRestrito, loc_nRet
        loc_lRestrito = .F.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nQtd FROM SigCdEnr " + ;
                "WHERE Endes = " + EscaparSQL(par_cEnde), ;
                "cursor_4c_EndRestr")
            IF loc_nRet > 0 AND !EOF("cursor_4c_EndRestr")
                SELECT cursor_4c_EndRestr
                loc_lRestrito = (NVL(nQtd, 0) > 0)
            ENDIF
            IF USED("cursor_4c_EndRestr")
                USE IN cursor_4c_EndRestr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.VerificarEnderecoRestrito")
        ENDTRY
        RETURN loc_lRestrito
    ENDFUNC

    *====================================================================
    * ListarEstados - Lista UFs de SigCdUfs para picker do campo Estado
    * Equivale ao fwBuscaExt('SigCdUfs', ...) do getEstas.Valid legado
    * Cursor resultado: cursor_4c_ListaEstados
    *====================================================================
    FUNCTION ListarEstados(par_cFiltro)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT RTRIM(Estados) AS Estados, RTRIM(Descrs) AS Descrs " + ;
                    "FROM SigCdUfs ORDER BY Estados"
            ELSE
                loc_cSQL = "SELECT RTRIM(Estados) AS Estados, RTRIM(Descrs) AS Descrs " + ;
                    "FROM SigCdUfs " + ;
                    "WHERE RTRIM(Estados) LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY Estados"
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaEstados")
            IF loc_nRet > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em EndBO.ListarEstados")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
