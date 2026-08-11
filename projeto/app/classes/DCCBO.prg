*==============================================================================
* DCCBO.prg - Business Object para Descontos Concedido no Caixa
* Origem: SIGCDDCC.SCX
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DCCBO AS BusinessBase

    *-- Campos do cursor xEestDsc (cursor VFP local pre-criado pelo form pai)
    this_cCidchaves = ""    && Chave interna do registro (inserida com '  ')
    this_cMotDscs   = ""    && Codigo do motivo de desconto (de SigCdFs.Codigos)
    this_cDescs     = ""    && Descricao do motivo (auto-preenchida de SigCdFs.Descrs)
    this_nValos     = 0     && Valor do desconto
    this_cObs       = ""    && Observacao livre

    *-- Totalizador calculado (SUM(Valos) de xEestDsc)
    this_nTotal     = 0

    *-- Contexto da operacao (populados pelo form ao inicializar o BO)
    this_cEmpresa   = ""    && Codigo da empresa (filtra SigCdFsI.Emps)
    this_cDopes     = ""    && Operacao corrente (filtra SigCdFsO.Dopes, de TprMvCab.Dopes)
    this_dDatas     = {}    && Data do movimento (filtro de periodo PerInis/PerFins)
    this_cContaDs   = ""    && Conta do cliente (Iclis de TprMvCab.ContaDs)

    *-- Dados do cliente para validacao de aniversario (ChkDtAnivs)
    this_dNascs     = {}    && Data de nascimento do cliente (SigCdCli.Nascs)
    this_dDtnCons   = {}    && Data de concessao (SigCdCli.DtnCons)

    *-- Controle de acesso (verificado via VerificarAcesso antes de habilitar botoes)
    this_lPodeInserir = .F.
    this_lPodeExcluir = .F.

    *-- Modo de operacao herdado do form pai (pcEscolha)
    this_lModoEdicao  = .F. && .T. quando pcEscolha IN ('INSERIR','ALTERAR')

    PROCEDURE Init()
        THIS.this_cTabela     = "XEestDsc"
        THIS.this_cCampoChave = "Cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor xEestDsc para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAlias)
            SELECT (par_cAlias)
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "C")
            THIS.this_cMotDscs   = TratarNulo(MotDscs, "C")
            THIS.this_cDescs     = TratarNulo(Descs, "C")
            THIS.this_nValos     = TratarNulo(Valos, "N")
            THIS.this_cObs       = TratarNulo(Obs, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere linha em branco no cursor local xEestDsc
    * Equivalente ao cmdInserir.Click original (INSERT INTO XEestDsc)
    * OPERACIONAL: opera sobre cursor VFP local, nao SQL Server
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("xEestDsc")
                INSERT INTO xEestDsc (Cidchaves) VALUES ('  ')
                SELECT xEestDsc
                THIS.RegistrarAuditoria("INCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xEestDsc n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", "Erro em Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza linha corrente do cursor xEestDsc com props do BO
    * Equivalente ao commit implicito do grid (ControlSource -> REPLACE)
    * OPERACIONAL: opera sobre cursor VFP local, nao SQL Server
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("xEestDsc")
                SELECT xEestDsc
                IF NOT EOF() AND NOT BOF()
                    REPLACE Cidchaves WITH THIS.this_cCidchaves, ;
                            MotDscs   WITH THIS.this_cMotDscs, ;
                            Descs     WITH THIS.this_cDescs, ;
                            Valos     WITH THIS.this_nValos, ;
                            Obs       WITH THIS.this_cObs ;
                            IN xEestDsc
                    THIS.RegistrarAuditoria("ALTERAR")
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Nenhuma linha selecionada para atualiza" + CHR(231) + CHR(227) + "o.", "Atualizar")
                ENDIF
            ELSE
                MsgErro("Cursor xEestDsc n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", "Erro em Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirLinhaAtual - Exclui linha corrente do cursor xEestDsc
    * Equivalente ao cmdExcluir.Click original
    *--------------------------------------------------------------------------
    FUNCTION ExcluirLinhaAtual()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("xEestDsc")
                SELECT xEestDsc
                IF NOT EOF()
                    DELETE
                    SKIP
                    SKIP -1
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ExcluirLinhaAtual")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarTodos - Valida todas as linhas antes de fechar o form
    * Equivalente ao cmdSair.Click original (parte de validacao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarTodos()
        LOCAL loc_lValido
        loc_lValido = .T.
        TRY
            IF USED("xEestDsc")
                SELECT xEestDsc
                SCAN
                    IF Valos <> 0 AND EMPTY(MotDscs)
                        MsgAviso("Favor informar os dados corretamente. Todos os campos dever" + CHR(227) + "o estar preenchidos.", "Valida" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarTodos")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularTotal - Calcula SUM(Valos) de xEestDsc e armazena em this_nTotal
    * Equivalente ao Column3.LostFocus original
    *--------------------------------------------------------------------------
    FUNCTION CalcularTotal()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("xEestDsc")
                SELECT [] AS agrupar, SUM(Valos) AS valos FROM xEestDsc GROUP BY 1 INTO CURSOR cursor_4c_TotalDcc READWRITE
                IF USED("cursor_4c_TotalDcc")
                    IF !EOF("cursor_4c_TotalDcc")
                        THIS.this_nTotal = NVL(cursor_4c_TotalDcc.valos, 0)
                    ELSE
                        THIS.this_nTotal = 0
                    ENDIF
                    USE IN cursor_4c_TotalDcc
                ELSE
                    THIS.this_nTotal = 0
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CalcularTotal")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMotivos - Carrega cursor_4c_TmpMdsc com motivos disponiveis
    * Replica Column1.Text1.Valid original (queries SQL + filtro VFP local)
    * par_cContaDs - conta/cliente corrente (TprMvCab.ContaDs / Iclis)
    * par_dDatas   - data do movimento (TprMvCab.Datas)
    * par_cDopes   - operacao corrente (TprMvCab.Dopes)
    * par_cEmpresa - codigo da empresa atual
    *--------------------------------------------------------------------------
    FUNCTION BuscarMotivos(par_cContaDs, par_dDatas, par_cDopes, par_cEmpresa)
        LOCAL loc_lSucesso, loc_cSQL, loc_dNascs, loc_dDtnCons
        loc_lSucesso = .F.
        loc_dNascs   = {}
        loc_dDtnCons = {}
        TRY
            *-- 1. Dados do cliente para verificacao de aniversario
            loc_cSQL = "SELECT Nascs, DtnCons FROM SigCdCli WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cContaDs))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli") < 1
                MsgErro("Falha ao carregar dados do cliente.", "Erro em BuscarMotivos")
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_LocalCli") AND !EOF("cursor_4c_LocalCli")
                IF !ISNULL(cursor_4c_LocalCli.Nascs)
                    loc_dNascs = cursor_4c_LocalCli.Nascs
                ENDIF
                IF !ISNULL(cursor_4c_LocalCli.DtnCons)
                    loc_dDtnCons = cursor_4c_LocalCli.DtnCons
                ENDIF
            ENDIF
            THIS.this_dNascs   = loc_dNascs
            THIS.this_dDtnCons = loc_dDtnCons
            IF USED("cursor_4c_LocalCli")
                USE IN cursor_4c_LocalCli
            ENDIF

            *-- 2. Motivos de desconto do SQL Server (SigCdFs + juncoes)
            loc_cSQL = "SELECT a.*, b.Emps, c.Dopes " + ;
                       "FROM SigCdFs a " + ;
                       "LEFT JOIN SigCdFsI b ON a.Codigos = b.Codigos " + ;
                       "LEFT JOIN SigCdFsO c ON a.Codigos = c.Codigos " + ;
                       "WHERE a.Tipos = 'D' AND a.TpDescs <> 2 " + ;
                       "ORDER BY a.Codigos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMdsc2") < 1
                MsgErro("Falha ao carregar motivos de desconto.", "Erro em BuscarMotivos")
                loc_lSucesso = .F.
            ENDIF

            *-- 3. Filtro VFP local por periodo (replica legado: PerInis >= Datas AND PerFins >= Datas)
            SELECT 1 AS Flag, * FROM cursor_4c_LocalMdsc2 ;
                WHERE (ISNULL(PerFins) OR EMPTY(PerFins) OR PerFins >= m.par_dDatas) AND ;
                      (ISNULL(PerInis) OR EMPTY(PerInis) OR PerInis >= m.par_dDatas) ;
                INTO CURSOR cursor_4c_LocalMdsc1 READWRITE

            *-- 4. Marca Flag=0 para registros que falham verificacao de aniversario
            SELECT cursor_4c_LocalMdsc1
            SCAN
                IF ConverterParaLogico(cursor_4c_LocalMdsc1.ChkDtAnivs)
                    IF NOT ( ;
                        (!ISNULL(m.loc_dNascs) AND !EMPTY(m.loc_dNascs) AND MONTH(m.par_dDatas) = MONTH(m.loc_dNascs)) OR ;
                        (!ISNULL(m.loc_dDtnCons) AND !EMPTY(m.loc_dDtnCons) AND MONTH(m.par_dDatas) = MONTH(m.loc_dDtnCons)) ;
                        )
                        REPLACE Flag WITH 0 IN cursor_4c_LocalMdsc1
                    ENDIF
                ENDIF
            ENDSCAN

            *-- 5. Selecao final filtrando por empresa e operacao
            IF USED("cursor_4c_TmpMdsc")
                USE IN cursor_4c_TmpMdsc
            ENDIF
            SELECT DISTINCT Codigos, Descrs FROM cursor_4c_LocalMdsc1 ;
                WHERE NVL(Emps, m.par_cEmpresa) = m.par_cEmpresa ;
                AND NVL(Dopes, m.par_cDopes) = m.par_cDopes ;
                INTO CURSOR cursor_4c_TmpMdsc READWRITE

            SELECT cursor_4c_TmpMdsc
            INDEX ON Codigos TAG Codigos

            IF USED("cursor_4c_LocalMdsc2")
                USE IN cursor_4c_LocalMdsc2
            ENDIF
            IF USED("cursor_4c_LocalMdsc1")
                USE IN cursor_4c_LocalMdsc1
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BuscarMotivos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarMotivo - Verifica codigo em cursor_4c_TmpMdsc e atualiza Descs em xEestDsc
    * par_cCodigos - codigo digitado pelo usuario na coluna Motivo
    * Retorna .T. se encontrado (Descs atualizado); .F. se nao encontrado (Form abre picker)
    *--------------------------------------------------------------------------
    FUNCTION ValidarMotivo(par_cCodigos)
        LOCAL loc_lEncontrado
        loc_lEncontrado = .F.
        TRY
            IF USED("cursor_4c_TmpMdsc")
                IF SEEK(ALLTRIM(m.par_cCodigos), "cursor_4c_TmpMdsc", "Codigos")
                    IF USED("xEestDsc")
                        REPLACE Descs WITH cursor_4c_TmpMdsc.Descrs IN xEestDsc
                    ENDIF
                    loc_lEncontrado = .T.
                ELSE
                    IF USED("xEestDsc")
                        REPLACE Descs WITH ' ' IN xEestDsc
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarMotivo")
        ENDTRY
        RETURN loc_lEncontrado
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDescricao - Limpa Descs quando motivo eh vazio
    * Equivalente ao ELSE de Column1.Text1.Valid quando This.Value eh vazio
    *--------------------------------------------------------------------------
    PROCEDURE LimparDescricao()
        IF USED("xEestDsc")
            REPLACE Descs WITH ' ' IN xEestDsc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores gerenciados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_TmpMdsc")
                USE IN cursor_4c_TmpMdsc
            ENDIF
            IF USED("cursor_4c_TotalDcc")
                USE IN cursor_4c_TotalDcc
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
