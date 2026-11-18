* ProbeF7SigOpSts808Form.prg - instancia FormSigOpSts DE VERDADE e exercita os
* tres handlers da Fase 7 (CmdInserirClick/CmdExcluirClick/BtnSairClick).
*
* O que se quer provar, e que so instanciando se prova:
*   - o form abre com os BINDEVENTs da Fase 7 (delegate inexistente estoura
*     NO BIND, dentro do Init)
*   - os tres Click estao de fato LIGADOS aos handlers (AEVENTS)
*   - Inserir acrescenta/reaproveita linha; Excluir marca a linha
*   - o Encerrar BLOQUEIA o fechamento com status duplicado e FECHA nos
*     demais casos (inclusive quando a gravacao falha - comportamento do
*     legado, que confia no RollBack)
*
* A prova vem do arquivo de saida, nao do exit code.
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gcOut, gc_4c_ArquivoErroTeste, gnConnHandle
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f7sts_form_msgs.txt"
gb_4c_ModoTeste   = .T.
gb_4c_ValidandoUI = .F.
gcOut = ""

LOCAL loErr

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    GarantirClasse("FormSigOpSts")
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .F.

    IF TYPE("gnConnHandle") != "N"
        gnConnHandle = -1
    ENDIF
    gcOut = gcOut + "gnConnHandle = " + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10)

    MedirGrade()

    *-- CASO 1: status duplicado -> Encerrar BLOQUEIA o fechamento
    TestarCaso("CASO1 status duplicado", "A|A", .T., "ABERTO")
    *-- CASO 2: status unicos, COM alteracao na sessao -> tenta gravar; sem
    *-- conexao a gravacao falha e o form FECHA do mesmo jeito (legado)
    TestarCaso("CASO2 unicos c/alter", "A|F", .T., "FECHADO")
    *-- CASO 3: sem inclusao nem exclusao -> nao valida, nao grava, FECHA
    TestarCaso("CASO3 sem alteracao", "A|A", .F., "FECHADO")
    *-- CASO 4: DUAS linhas em branco -> duplicidade do status VAZIO (literal
    *-- do legado) -> BLOQUEIA
    TestarCaso("CASO4 2 em branco", "-|-", .T., "ABERTO")

    *-- Handlers e BINDEVENTs sobre um form vivo
    TestarHandlers()

CATCH TO loErr
    gcOut = gcOut + "ERRO GERAL: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(gcOut, "C:\4c\automation\_f7sts_form.txt")
QUIT

*------------------------------------------------------------------------------
PROCEDURE MontarForm(pcLinhas, plAlterou)
    LOCAL loForm, lnI, laL[1], lcSt
    loForm = CREATEOBJECT("FormSigOpSts", .NULL., "MALOTE", "INSERIR", 1)

    IF VARTYPE(loForm) != "O"
        RETURN .NULL.
    ENDIF

    loForm.this_cOperacaoPai         = "MALOTE"
    loForm.cmd_4c_Inserir.Visible    = .T.
    loForm.this_oBusinessObject.this_cOperacaoPai   = "MALOTE"
    loForm.this_oBusinessObject.this_lHouveInclusao = plAlterou
    loForm.this_oBusinessObject.this_lHouveExclusao = .F.

    IF USED("cursor_4c_Status")
        USE IN cursor_4c_Status
    ENDIF
    CREATE CURSOR cursor_4c_Status ;
        (cidchaves C(20), dopes C(20), status C(1), descs C(20))

    FOR lnI = 1 TO ALINES(laL, pcLinhas, .F., "|")
        lcSt = ALLTRIM(laL[lnI])
        lcSt = IIF(lcSt == "-", "", LEFT(lcSt, 1))
        INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
            VALUES ("K" + TRANSFORM(lnI), "MALOTE", lcSt, "DESC" + TRANSFORM(lnI))
    ENDFOR

    RETURN loForm
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE TestarCaso(pcNome, pcLinhas, plAlterou, pcEsperado)
    LOCAL loForm, loErr, lcReal
    TRY
        loForm = MontarForm(pcLinhas, plAlterou)

        IF VARTYPE(loForm) != "O"
            gcOut = gcOut + PADR(pcNome, 24) + " -> ERRO: CREATEOBJECT nao devolveu objeto" + ;
                    CHR(13) + CHR(10)
            RETURN
        ENDIF

        loForm.BtnSairClick()

        *-- form vivo? acessar property de objeto liberado estoura
        lcReal = "FECHADO"
        TRY
            IF VARTYPE(loForm) = "O" AND !ISNULL(loForm) AND VARTYPE(loForm.Caption) = "C"
                lcReal = "ABERTO"
            ENDIF
        CATCH
            lcReal = "FECHADO"
        ENDTRY

        gcOut = gcOut + PADR(pcNome, 24) + " -> " + PADR(lcReal, 8) + ;
                " esperado=" + PADR(pcEsperado, 8) + ;
                IIF(lcReal == pcEsperado, " OK", " *** DIVERGE ***") + CHR(13) + CHR(10)

        IF VARTYPE(loForm) = "O" AND !ISNULL(loForm)
            TRY
                loForm.Release()
            CATCH
            ENDTRY
        ENDIF
    CATCH TO loErr
        gcOut = gcOut + PADR(pcNome, 24) + " -> ERRO: " + loErr.Message + ;
                " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + ;
                CHR(13) + CHR(10)
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE TestarHandlers()
    LOCAL loForm, loErr, lnAnt, lnDep, laE[1], lnQ, lnI, lcLig
    TRY
        loForm = MontarForm("A|F", .F.)

        IF VARTYPE(loForm) != "O"
            gcOut = gcOut + "HANDLERS -> ERRO: CREATEOBJECT nao devolveu objeto" + CHR(13) + CHR(10)
            RETURN
        ENDIF

        *-- BINDEVENTs da Fase 7: o Click de cada botao tem de estar ligado
        lcLig = ""
        lcLig = "Inserir=" + LigadoA(loForm.cmd_4c_Inserir, "CLICK") + ;
                " Excluir=" + LigadoA(loForm.cmd_4c_Excluir, "CLICK") + ;
                " Sair="    + LigadoA(loForm.cmd_4c_Sair,    "CLICK")
        gcOut = gcOut + "BINDEVENT Click ligados: " + lcLig + ;
                " (esperado o nome do handler em cada)" + CHR(13) + CHR(10)

        *-- Inserir cria UMA linha em branco
        lnAnt = RECCOUNT("cursor_4c_Status")
        loForm.CmdInserirClick()
        lnDep = RECCOUNT("cursor_4c_Status")
        gcOut = gcOut + "CmdInserirClick (1a) -> " + TRANSFORM(lnAnt) + " para " + ;
                TRANSFORM(lnDep) + IIF(lnDep = lnAnt + 1, " OK", " *** DIVERGE ***") + ;
                " houveInc=" + IIF(loForm.this_oBusinessObject.this_lHouveInclusao, ".T. OK", ".F. *** DIVERGE ***") + ;
                CHR(13) + CHR(10)

        *-- Segundo Inserir REAPROVEITA a linha em branco
        loForm.CmdInserirClick()
        lnDep = RECCOUNT("cursor_4c_Status")
        gcOut = gcOut + "CmdInserirClick (2a) -> RECCOUNT=" + TRANSFORM(lnDep) + ;
                IIF(lnDep = lnAnt + 1, " OK (reaproveitou)", " *** DIVERGE ***") + ;
                CHR(13) + CHR(10)

        *-- Excluir marca a linha corrente (SET DELETED ON esconde da grade)
        SELECT cursor_4c_Status
        GO TOP
        lnAnt = RECCOUNT("cursor_4c_Status")
        loForm.CmdExcluirClick()
        gcOut = gcOut + "CmdExcluirClick -> visiveis=" + ;
                TRANSFORM(ContarVivos()) + " de " + TRANSFORM(lnAnt) + ;
                IIF(ContarVivos() = lnAnt - 1, " OK", " *** DIVERGE ***") + ;
                " houveExc=" + IIF(loForm.this_oBusinessObject.this_lHouveExclusao, ".T. OK", ".F. *** DIVERGE ***") + ;
                CHR(13) + CHR(10)

        IF VARTYPE(loForm) = "O" AND !ISNULL(loForm)
            TRY
                loForm.Release()
            CATCH
            ENDTRY
        ENDIF
    CATCH TO loErr
        gcOut = gcOut + "HANDLERS -> ERRO: " + loErr.Message + ;
                " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + ;
                CHR(13) + CHR(10)
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
FUNCTION ContarVivos()
    LOCAL lnT
    lnT = 0
    IF USED("cursor_4c_Status")
        SELECT cursor_4c_Status
        SCAN
            lnT = lnT + 1
        ENDSCAN
    ENDIF
    RETURN lnT
ENDFUNC

*------------------------------------------------------------------------------
* LigadoA - devolve o nome do metodo ligado ao evento pcEvento do objeto, ou
* "(NENHUM)". AEVENTS aceita SO 2 argumentos: o nome do evento esta na
* coluna 3 do array e o metodo destino na coluna 4.
*------------------------------------------------------------------------------
FUNCTION LigadoA(poObj, pcEvento)
    LOCAL laE[1, 5], lnQ, lnI, lcRet
    lcRet = "(NENHUM)"
    lnQ = AEVENTS(laE, poObj)
    FOR lnI = 1 TO lnQ
        IF UPPER(ALLTRIM(laE[lnI, 3])) == UPPER(ALLTRIM(pcEvento))
            lcRet = ALLTRIM(laE[lnI, 4])
            EXIT
        ENDIF
    ENDFOR
    RETURN lcRet
ENDFUNC

*------------------------------------------------------------------------------
* MedirGrade - mede o estado da grade logo apos o Init, para saber se
* THIS.grd_4c_Dados.Column1 eh alcancavel quando a carga de dados falhou
* (VincularGrade nunca roda) - o "Unknown member COLUMN1" medido no
* CmdInserirClick vem daqui.
*------------------------------------------------------------------------------
PROCEDURE MedirGrade()
    LOCAL loForm, loErr
    TRY
        loForm = CREATEOBJECT("FormSigOpSts", .NULL., "MALOTE", "INSERIR", 1)
        gcOut = gcOut + "GRADE: ColumnCount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + ;
                " RecordSource=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
                " PEMSTATUS(Column1,5)=" + ;
                IIF(PEMSTATUS(loForm.grd_4c_Dados, "Column1", 5), ".T.", ".F.") + CHR(13) + CHR(10)
        TRY
            loForm.grd_4c_Dados.Column1.SetFocus()
            gcOut = gcOut + "GRADE: Column1.SetFocus = OK" + CHR(13) + CHR(10)
        CATCH TO loErr
            gcOut = gcOut + "GRADE: Column1.SetFocus = ERRO " + loErr.Message + CHR(13) + CHR(10)
        ENDTRY
        loForm.Release()
    CATCH TO loErr
        gcOut = gcOut + "GRADE: ERRO " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY
ENDPROC
