*------------------------------------------------------------------------------
* SIGPRESTBO.prg - Business Object para Gerar Estrutura de Arquivos DBF
* Herdado de: BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS SIGPRESTBO AS BusinessBase

    *-- Configuracao da entidade (sem tabela SQL Server - opera em DBFs locais)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Opcoes de processamento (mapeiam checkboxes do form)
    this_lGeraArquivos = .T.
    this_lGeraIndices  = .T.

    *-- Estado do processamento
    this_cMensagem    = ""
    this_cDiretorioBase = ""
    this_lProcessando = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso

        TRY
            loc_lSucesso = DODEFAULT()
            IF !loc_lSucesso
                loc_lSucesso = .F.
            ENDIF

            this_cTabela        = ""
            this_cCampoChave    = ""
            this_lGeraArquivos  = .T.
            this_lGeraIndices   = .T.
            this_cMensagem      = ""
            this_cDiretorioBase = ""
            this_lProcessando   = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        IF !this_lGeraArquivos AND !this_lGeraIndices
            this_cMensagemErro = "Selecione pelo menos uma op" + CHR(231) + ;
                CHR(227) + "o de gera" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION Inserir()
    *--------------------------------------------------------------------------
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarEstrutura - Gera ArqDBF.dbf (estrutura) e ArqInd.dbf (indices)
    * a partir de todos os .DBF encontrados no diretorio basededados\
    *--------------------------------------------------------------------------
    FUNCTION GerarEstrutura(par_lGeraArquivos, par_lGeraIndices)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_loBarra, loc_lnArq, loc_lcArquivo
        LOCAL loc_lnGeraArq, loc_lnGeraInd, loc_lnCampos, loc_lnCCampos
        LOCAL loc_lcDbc, loc_lnKey, loc_lcChave, loc_lcFiltro, loc_lcTag
        LOCAL loc_lcDirAtual, loc_lInterrompido
        LOCAL ARRAY loc_laArq[1]
        LOCAL ARRAY loc_laCampos[1]

        loc_lSucesso      = .F.
        loc_lInterrompido = .F.
        loc_lcDirAtual    = ADDBS(SYS(5)) + CURDIR()

        TRY
            this_lProcessando = .T.
            this_cMensagem    = ""

            CLOSE TABLES ALL
            SET DEFAULT TO ".\basededados\"

            IF par_lGeraArquivos

                SELECT 0

                CREATE TABLE ArqDBF FREE ;
                    ( Arquivos c(20), Dbcs c(50), Campos c(20), Tipos c(1), ;
                      Tamanhos n(3), Fracaos n(2), C_05s l, C_06s l, ;
                      C_07s c(20), C_08s c(20), C_09s c(20), C_10s c(20), ;
                      C_11s c(20), C_12s c(20), C_13s c(20), C_14s c(20), ;
                      C_15s c(20), C_16s c(20) )

                INDEX ON Arquivos + Campos TAG ArqCamp

                loc_lnArq = ADIR(loc_laArq, "*.Dbf")
                =ASORT(loc_laArq)

                loc_loBarra = CREATEOBJECT("fwProgressBar", ;
                    "Processando Estrutura de Arquivos.", loc_lnArq)
                loc_loBarra.Titulo.FontBold = .T.
                loc_loBarra.Show()

                FOR loc_lnGeraArq = 1 TO loc_lnArq

                    loc_lcArquivo = loc_laArq(loc_lnGeraArq, 1)

                    loc_loBarra.Update(.T.)
                    loc_loBarra.SubTitulo.Caption = ;
                        "Processando Arquivo : " + ALLTRIM(loc_lcArquivo)

                    IF INLIST(ALLTRIM(loc_lcArquivo), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                        LOOP
                    ENDIF

                    USE (loc_lcArquivo) IN 0 ALIAS TmpArquivo AGAIN

                    SELECT TmpArquivo
                    loc_lcDbc    = ALLTRIM(JUSTFNAME(CURSORGETPROP("DataBase")))
                    loc_lnCampos = AFIELDS(loc_laCampos)

                    FOR loc_lnCCampos = 1 TO loc_lnCampos

                        IF loc_lnCCampos = 1
                            IF EMPTY(loc_laCampos(loc_lnCCampos, 12))
                                loc_laCampos(loc_lnCCampos, 12) = ;
                                    STRTRAN(loc_lcArquivo, ".DBF", "")
                            ENDIF
                        ENDIF

                        SELECT ArqDBF
                        INSERT INTO ArqDBF ;
                            ( Arquivos, Dbcs, Campos, Tipos, Tamanhos, Fracaos, ;
                              C_05s, C_06s, C_07s, C_08s, C_09s, C_10s, ;
                              C_11s, C_12s, C_13s, C_14s, C_15s, C_16s ) ;
                            VALUES ;
                            ( loc_lcArquivo, loc_lcDbc, ;
                              loc_laCampos(loc_lnCCampos, 1), loc_laCampos(loc_lnCCampos, 2), ;
                              loc_laCampos(loc_lnCCampos, 3), loc_laCampos(loc_lnCCampos, 4), ;
                              loc_laCampos(loc_lnCCampos, 5), loc_laCampos(loc_lnCCampos, 6), ;
                              loc_laCampos(loc_lnCCampos, 7), loc_laCampos(loc_lnCCampos, 8), ;
                              loc_laCampos(loc_lnCCampos, 9), loc_laCampos(loc_lnCCampos, 10), ;
                              loc_laCampos(loc_lnCCampos, 11), loc_laCampos(loc_lnCCampos, 12), ;
                              loc_laCampos(loc_lnCCampos, 13), loc_laCampos(loc_lnCCampos, 14), ;
                              loc_laCampos(loc_lnCCampos, 15), loc_laCampos(loc_lnCCampos, 16) )

                    ENDFOR

                    USE IN TmpArquivo

                ENDFOR

                loc_loBarra.Complete("Finalizando Processo de Estrutura.")

            ENDIF

            CLOSE TABLES ALL

            IF par_lGeraIndices AND !FILE("ArqDBF.Dbf")
                MsgAviso("Antes de gerar os " + CHR(237) + "ndices, " + CHR(233) + ;
                    " necess" + CHR(225) + "rio que seja gerada a Estrutura de Arquivos...", "")
                this_cMensagem    = "Processamento Interrompido."
                this_lProcessando = .F.
                loc_lInterrompido = .T.
            ENDIF

            IF par_lGeraIndices AND !loc_lInterrompido

                SELECT 0
                USE ArqDBF ORDER ArqCamp

                loc_lnArq = ADIR(loc_laArq, "*.Dbf")
                =ASORT(loc_laArq)

                IF FILE("ArqInd.Dbf")
                    DELETE FILE ArqInd.Dbf
                    DELETE FILE ArqInd.Cdx
                ENDIF

                CREATE TABLE ArqInd FREE ;
                    ( Arquivos c(20), Tags c(15), Indices c(240), ;
                      Filtros c(240), Indexs l, c_12s c(20) )
                INDEX ON Arquivos + Tags TAG Arquivos
                INDEX ON Arquivos TAG Temp UNIQUE

                loc_loBarra = CREATEOBJECT("fwProgressBar", ;
                    "Processando " + CHR(205) + "ndices de Arquivos.", loc_lnArq)
                loc_loBarra.Titulo.FontBold = .T.
                loc_loBarra.Show()

                FOR loc_lnGeraInd = 1 TO loc_lnArq

                    loc_lcArquivo = loc_laArq(loc_lnGeraInd, 1)

                    loc_loBarra.Update(.T.)
                    loc_loBarra.SubTitulo.Caption = ;
                        "Processando Arquivo : " + ALLTRIM(loc_lcArquivo)

                    IF INLIST(ALLTRIM(loc_lcArquivo), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                        LOOP
                    ENDIF

                    SELECT 0
                    USE (loc_lcArquivo) ALIAS TmpArquivo AGAIN

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

            ENDIF

            IF !loc_lInterrompido
                CLOSE TABLES ALL
                this_cMensagem    = "Processamento Finalizado."
                this_lProcessando = .F.
                loc_lSucesso      = .T.
                SET DEFAULT TO (loc_lcDirAtual)
                THIS.CarregarLogoTipo()
            ELSE
                SET DEFAULT TO (loc_lcDirAtual)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, ;
                "Erro na Gera" + CHR(231) + CHR(227) + "o de Estrutura")
            this_cMensagem    = "Erro no processamento."
            this_lProcessando = .F.
            loc_lSucesso      = .F.

            TRY
                CLOSE TABLES ALL
                SET DEFAULT TO (loc_lcDirAtual)
            CATCH
            ENDTRY
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarLogoTipo - Garante cursor csLogoTipo disponivel (usado pelo sistema)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLogoTipo()
    *--------------------------------------------------------------------------
        LOCAL loc_oErro

        TRY
            IF !USED("csLogoTipo")
                SQLEXEC(gnConnHandle, "SELECT Logos FROM SigCdPam", "csLogoTipo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar logo")
        ENDTRY
    ENDPROC

ENDDEFINE
