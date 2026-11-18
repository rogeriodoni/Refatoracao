SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gcOut, gc_4c_ArquivoErroTeste
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f7sqn_msgs.txt"
gb_4c_ModoTeste  = .T.
gb_4c_ValidandoUI = .F.
gcOut = ""
LOCAL loErr
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    GarantirClasse("FormSigOpSqn")
    gb_4c_ModoTeste = .T.

    *-- CASO 1: duas linhas com a MESMA operacao -> deve BLOQUEAR o fechamento
    TestarCaso("CASO1 duplicada", "VENDA/OP1/1|VENDA/OP1/2", "ABERTO")
    *-- CASO 2: operacao informada com seq 0 -> deve BLOQUEAR
    TestarCaso("CASO2 seq zero", "VENDA/OP1/0", "ABERTO")
CATCH TO loErr
    gcOut = gcOut + "ERRO GERAL: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(gcOut, "C:\4c\automation\_f7sqn_valid.txt")
QUIT

PROCEDURE TestarCaso(pcNome, pcLinhas, pcEsperado)
    LOCAL loForm, loErr, lnI, laL[1], lcReal, lcL, lcNiv, lnSeq
    TRY
        loForm = CREATEOBJECT("FormSigOpSqn", .NULL., "VENDA", "INSERIR", 1)
        loForm.this_cOperacaoPai   = "VENDA"
        loForm.this_lHouveInclusao = .T.
        loForm.cmd_4c_Inserir.Visible = .T.

        IF USED("cursor_4c_Sequencias")
            USE IN cursor_4c_Sequencias
        ENDIF
        CREATE CURSOR cursor_4c_Sequencias (cdopes C(20), cnivels C(20), seqs N(2,0), cidchaves C(36))
        FOR lnI = 1 TO ALINES(laL, pcLinhas, 1, "|")
            lcL   = laL[lnI]
            lcNiv = SUBSTR(lcL, AT("/", lcL) + 1, RAT("/", lcL) - AT("/", lcL) - 1)
            lnSeq = VAL(SUBSTR(lcL, RAT("/", lcL) + 1))
            INSERT INTO cursor_4c_Sequencias (cdopes, cnivels, seqs, cidchaves) ;
                VALUES ("VENDA", lcNiv, lnSeq, "K" + TRANSFORM(lnI))
        ENDFOR

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
                IIF(lcReal == pcEsperado, " OK", " *** DIVERGE ***") + CHR(13)+CHR(10)

        IF VARTYPE(loForm) = "O" AND !ISNULL(loForm)
            TRY
                loForm.Release()
            CATCH
            ENDTRY
        ENDIF
    CATCH TO loErr
        gcOut = gcOut + PADR(pcNome, 24) + " -> ERRO: " + loErr.Message + ;
                " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13)+CHR(10)
    ENDTRY
ENDPROC
