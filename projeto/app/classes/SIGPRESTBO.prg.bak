*==============================================================================
* SIGPRESTBO.prg - Business Object para Gerar Estrutura de Arquivos
* Herda de: BusinessBase
* Autor: Sistema 4C
*==============================================================================

DEFINE CLASS SIGPRESTBO AS BusinessBase

    *-- Configuracao da entidade
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Opcoes de processamento
    this_lGeraArquivos = .T.
    this_lGeraIndices  = .T.

    *-- Estado do processamento
    this_cMensagem    = ""
    this_cDirAtual    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF TYPE("lGeraArquivos") = "L"
                THIS.this_lGeraArquivos = lGeraArquivos
            ENDIF
            IF TYPE("lGeraIndices") = "L"
                THIS.this_lGeraIndices = lGeraIndices
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarEstrutura - Escaneia DBFs locais e grava estrutura em ArqDBF.DBF
    *--------------------------------------------------------------------------
    FUNCTION GerarEstrutura(par_cDirAtual)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lnArq, loc_lcArquivo, loc_lnGeraArq
        LOCAL loc_lcDbc, loc_lnCampos, loc_lnCCampos, loc_lcCampo, loc_loBarra
        LOCAL loc_laArq[1], loc_laCampos[1]

        loc_lSucesso = .F.

        TRY
            SET SAFETY OFF
            SET DEFAULT TO (par_cDirAtual)

            IF USED("ArqDBF")
                USE IN ArqDBF
            ENDIF
            IF FILE("ArqDBF.DBF")
                DELETE FILE ArqDBF.DBF
            ENDIF
            IF FILE("ArqDBF.CDX")
                DELETE FILE ArqDBF.CDX
            ENDIF

            SELECT 0
            CREATE TABLE ArqDBF FREE ( ;
                Arquivos c(20), Dbcs c(50), Campos c(20), Tipos c(1), ;
                Tamanhos n(3), Fracaos n(2), C_05s l, C_06s l, ;
                C_07s c(20), C_08s c(20), C_09s c(20), C_10s c(20), ;
                C_11s c(20), C_12s c(20), C_13s c(20), C_14s c(20), ;
                C_15s c(20), C_16s c(20) )

            INDEX ON Arquivos + Campos TAG ArqCamp

            loc_lnArq = ADIR(loc_laArq, '*.Dbf')
            IF loc_lnArq > 0
                ASORT(loc_laArq)
            ENDIF

            loc_loBarra = CREATEOBJECT('fwProgressBar', ;
                'Processando Estrutura de Arquivos.', loc_lnArq)
            loc_loBarra.Titulo.FontBold = .T.
            loc_loBarra.Show

            FOR loc_lnGeraArq = 1 TO loc_lnArq
                loc_lcArquivo = loc_laArq(loc_lnGeraArq, 1)

                loc_loBarra.Update(.T.)
                loc_loBarra.SubTitulo.Caption = ;
                    'Processando Arquivo : ' + ALLTRIM(loc_lcArquivo)

                IF INLIST(ALLTRIM(UPPER(loc_lcArquivo)), ;
                    'ARQDBF.DBF', 'ARQIND.DBF', 'FOXUSER.DBF')
                    LOOP
                ENDIF

                USE &loc_lcArquivo IN 0 ALIAS TmpArquivo AGAIN

                SELECT TmpArquivo
                loc_lcDbc    = ALLTRIM(JUSTFNAME(CURSORGETPROP("DataBase")))
                loc_lnCampos = AFIELDS(loc_laCampos)

                FOR loc_lnCCampos = 1 TO loc_lnCampos
                    IF loc_lnCCampos = 1
                        IF EMPTY(loc_laCampos(loc_lnCCampos, 12))
                            loc_laCampos(loc_lnCCampos, 12) = ;
                                STRTRAN(loc_lcArquivo, '.DBF', '')
                        ENDIF
                    ENDIF
                    loc_lcCampo = PADR(UPPER( ;
                        ALLTRIM(JUSTSTEM(loc_lcArquivo)) + '.' + ;
                        ALLTRIM(loc_laCampos(loc_lnCCampos, 1))), 64)

                    SELECT ArqDBF
                    INSERT INTO ArqDBF ( ;
                        Arquivos, Dbcs, Campos, Tipos, ;
                        Tamanhos, Fracaos, C_05s, C_06s, ;
                        C_07s, C_08s, C_09s, C_10s, ;
                        C_11s, C_12s, C_13s, C_14s, ;
                        C_15s, C_16s ) ;
                    VALUES ( ;
                        loc_lcArquivo, loc_lcDbc, ;
                        loc_laCampos(loc_lnCCampos, 1), ;
                        loc_laCampos(loc_lnCCampos, 2), ;
                        loc_laCampos(loc_lnCCampos, 3), ;
                        loc_laCampos(loc_lnCCampos, 4), ;
                        loc_laCampos(loc_lnCCampos, 5), ;
                        loc_laCampos(loc_lnCCampos, 6), ;
                        loc_laCampos(loc_lnCCampos, 7), ;
                        loc_laCampos(loc_lnCCampos, 8), ;
                        loc_laCampos(loc_lnCCampos, 9), ;
                        loc_laCampos(loc_lnCCampos, 10), ;
                        loc_laCampos(loc_lnCCampos, 11), ;
                        loc_laCampos(loc_lnCCampos, 12), ;
                        loc_laCampos(loc_lnCCampos, 13), ;
                        loc_laCampos(loc_lnCCampos, 14), ;
                        loc_laCampos(loc_lnCCampos, 15), ;
                        loc_laCampos(loc_lnCCampos, 16) )
                ENDFOR

                USE IN TmpArquivo
            ENDFOR

            loc_loBarra.Complete("Finalizando Processo de Estrutura.")

            THIS.this_cDirAtual = par_cDirAtual
            THIS.this_cMensagem = "Estrutura gerada com sucesso."
            THIS.RegistrarAuditoria("GERAR_ESTRUTURA")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + ")", ;
                "Erro ao Gerar Estrutura")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIndices - Escaneia CDX dos DBFs locais e grava em ArqInd.DBF
    *--------------------------------------------------------------------------
    FUNCTION GerarIndices(par_cDirAtual)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lnArq, loc_lcArquivo, loc_lnGeraInd
        LOCAL loc_lnKey, loc_lcChave, loc_lcFiltro, loc_lcTag, loc_loBarra
        LOCAL loc_laArq[1]

        loc_lSucesso = .F.

        TRY
            SET SAFETY OFF
            SET DEFAULT TO (par_cDirAtual)

            IF !FILE("ArqDBF.DBF")
                MsgAviso("Antes de gerar os " + CHR(205) + "ndices, " + ;
                    CHR(233) + " necess" + CHR(225) + "rio que seja gerada " + ;
                    "a Estrutura de Arquivos...", "Aviso")
                THIS.this_cMensagem = "Processamento Interrompido."
            ELSE
                IF USED("ArqDBF")
                    USE IN ArqDBF
                ENDIF
                SELECT 0
                USE ArqDBF ORDER ArqCamp

                loc_lnArq = ADIR(loc_laArq, '*.Dbf')
                IF loc_lnArq > 0
                    ASORT(loc_laArq)
                ENDIF

                IF USED("ArqInd")
                    USE IN ArqInd
                ENDIF
                IF FILE('ArqInd.DBF')
                    DELETE FILE ArqInd.DBF
                ENDIF
                IF FILE('ArqInd.CDX')
                    DELETE FILE ArqInd.CDX
                ENDIF

                CREATE TABLE ArqInd FREE ( ;
                    Arquivos c(20), Tags c(15), ;
                    Indices c(240), Filtros c(240), ;
                    Indexs l, c_12s c(20) )
                INDEX ON Arquivos + Tags TAG Arquivos
                INDEX ON Arquivos TAG Temp UNIQUE

                loc_loBarra = CREATEOBJECT('fwProgressBar', ;
                    'Processando ' + CHR(205) + 'ndices de Arquivos.', loc_lnArq)
                loc_loBarra.Titulo.FontBold = .T.
                loc_loBarra.Show

                FOR loc_lnGeraInd = 1 TO loc_lnArq
                    loc_lcArquivo = loc_laArq(loc_lnGeraInd, 1)

                    loc_loBarra.Update(.T.)
                    loc_loBarra.SubTitulo.Caption = ;
                        'Processando Arquivo : ' + ALLTRIM(loc_lcArquivo)

                    IF INLIST(ALLTRIM(UPPER(loc_lcArquivo)), ;
                        'ARQDBF.DBF', 'ARQIND.DBF', 'FOXUSER.DBF')
                        LOOP
                    ENDIF

                    SELECT 0
                    USE &loc_lcArquivo ALIAS TmpArquivo AGAIN

                    loc_lnKey = 1
                    DO WHILE !EMPTY(TAG(loc_lnKey))
                        loc_lcChave  = KEY(loc_lnKey)
                        loc_lcFiltro = SYS(2021, loc_lnKey)
                        loc_lcTag    = TAG(loc_lnKey)

                        INSERT INTO ArqInd ( Arquivos, Tags, Indices, Filtros ) ;
                        VALUES ( loc_lcArquivo, loc_lcTag, loc_lcChave, loc_lcFiltro )

                        SELECT TmpArquivo
                        loc_lnKey = loc_lnKey + 1
                    ENDDO
                    USE
                ENDFOR

                loc_loBarra.Complete("Finalizando Processo de " + CHR(205) + "ndice.")

                THIS.this_cDirAtual = par_cDirAtual
                THIS.this_cMensagem = CHR(205) + "ndices gerados com sucesso."
                THIS.RegistrarAuditoria("GERAR_INDICES")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + ")", ;
                "Erro ao Gerar " + CHR(205) + "ndices")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarLogo - Carrega logo da empresa via SQL Server
    *--------------------------------------------------------------------------
    FUNCTION CarregarLogo()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED('csLogoTipo')
                SQLEXEC(gnConnHandle, ;
                    "SELECT Logos FROM SigCdPam", "csLogoTipo")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Carregar Logo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Operacao CRUD nao aplicavel a BO utilitario OPERACIONAL
    * SIGPREST nao tem tabela transacional (this_cTabela = "")
    * Para gerar estrutura/indices use GerarEstrutura() e GerarIndices()
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "BO utilit" + CHR(225) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD. " + ;
            "Use GerarEstrutura() e GerarIndices()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao CRUD nao aplicavel a BO utilitario OPERACIONAL
    * SIGPREST nao tem tabela transacional (this_cTabela = "")
    * Para gerar estrutura/indices use GerarEstrutura() e GerarIndices()
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "BO utilit" + CHR(225) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD. " + ;
            "Use GerarEstrutura() e GerarIndices()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Operacao CRUD nao aplicavel a BO utilitario OPERACIONAL
    * SIGPREST nao tem tabela transacional (this_cTabela = "")
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "BO utilit" + CHR(225) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do processo de geracao em LogAuditoria
    * Loga qual operacao foi executada (Estrutura, Indices ou ambas)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cDescricao, loc_cUsuario, loc_cOperacao
        LOCAL loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cOperacao = IIF(EMPTY(par_cOperacao), "PROCESS", ALLTRIM(par_cOperacao))
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "SYSTEM")

            loc_cDescricao = "Utilit" + CHR(225) + "rio: SIGPREST (Gerar Estrutura)"
            IF THIS.this_lGeraArquivos
                loc_cDescricao = loc_cDescricao + " | Estrutura=Sim"
            ELSE
                loc_cDescricao = loc_cDescricao + " | Estrutura=Nao"
            ENDIF
            IF THIS.this_lGeraIndices
                loc_cDescricao = loc_cDescricao + " | " + CHR(205) + "ndices=Sim"
            ELSE
                loc_cDescricao = loc_cDescricao + " | " + CHR(205) + "ndices=Nao"
            ENDIF
            IF !EMPTY(THIS.this_cDirAtual)
                loc_cDescricao = loc_cDescricao + " | Dir=" + ALLTRIM(THIS.this_cDirAtual)
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria" + ;
                       " (Usuario, DataHora, Operacao, Tabela, ChaveRegistro, DadosNovos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cOperacao) + ", " + ;
                       EscaparSQL("SIGPREST") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cDescricao) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + ")", ;
                "Erro em RegistrarAuditoria")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
