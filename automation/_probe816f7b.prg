*==============================================================================
* _probe816f7b.prg - Complemento do _probe816f7: prova os BINDEVENT dos dois
* botoes com a assinatura CERTA de AEVENTS (DOIS argumentos; evento na coluna
* 3 e metodo delegate na coluna 4) e mede o estado das flags de modo teste
* depois de config.prg/ConfigurarAmbiente.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe816f7b_dialogs.txt"
gb_4c_ValidandoUI      = .T.
gnConnHandle           = 0

LOCAL lcOut, loForm, lcR, lnI, lnQtd, loErr
LOCAL ARRAY laEv[1]
lcOut = "C:\4c\automation\_probe816f7b_out.txt"

ON ERROR STRTOFILE("ON ERROR: " + MESSAGE() + " LINENO=" + TRANSFORM(LINENO()) + ;
    CHR(13) + CHR(10), lcOut, .T.)

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("Formsigopvci")

lcR = "FLAGS pos-config: ModoTeste=" + TRANSFORM(gb_4c_ModoTeste) + ;
    " ValidandoUI=" + TRANSFORM(gb_4c_ValidandoUI) + ;
    " ArquivoErro=[" + gc_4c_ArquivoErroTeste + "]" + ;
    " gnConnHandle=" + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10)

loForm = CREATEOBJECT("Formsigopvci")
lcR = lcR + "VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    TRY
        lnQtd = AEVENTS(laEv, loForm.cmg_4c_Botoes.Buttons(1))
        lcR = lcR + "Buttons(1) binds=" + TRANSFORM(lnQtd) + CHR(13) + CHR(10)
        FOR lnI = 1 TO ALEN(laEv, 1)
            lcR = lcR + "  B1 evento=[" + laEv[lnI, 3] + "] metodo=[" + ;
                laEv[lnI, 4] + "]" + CHR(13) + CHR(10)
        ENDFOR
    CATCH TO loErr
        lcR = lcR + "AEVENTS B1 ERRO: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY

    TRY
        lnQtd = AEVENTS(laEv, loForm.cmg_4c_Botoes.Buttons(2))
        lcR = lcR + "Buttons(2) binds=" + TRANSFORM(lnQtd) + CHR(13) + CHR(10)
        FOR lnI = 1 TO ALEN(laEv, 1)
            lcR = lcR + "  B2 evento=[" + laEv[lnI, 3] + "] metodo=[" + ;
                laEv[lnI, 4] + "]" + CHR(13) + CHR(10)
        ENDFOR
    CATCH TO loErr
        lcR = lcR + "AEVENTS B2 ERRO: " + loErr.Message + CHR(13) + CHR(10)
    ENDTRY

    *-- Captions reais dos dois botoes (confere o pareamento handler x botao)
    lcR = lcR + "Buttons(1).Caption=[" + loForm.cmg_4c_Botoes.Buttons(1).Caption + "]" + CHR(13) + CHR(10)
    lcR = lcR + "Buttons(2).Caption=[" + loForm.cmg_4c_Botoes.Buttons(2).Caption + ;
        "] Cancel=" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(2).Cancel) + CHR(13) + CHR(10)

    *-- Uma MsgAviso direta, para provar que o desvio a arquivo funciona
    MsgAviso("PROBE: mensagem de teste", "")
    lcR = lcR + "dialogs existe=" + TRANSFORM(FILE(gc_4c_ArquivoErroTeste)) + ;
        " tamanho=" + TRANSFORM(IIF(FILE(gc_4c_ArquivoErroTeste), ;
        LEN(FILETOSTR(gc_4c_ArquivoErroTeste)), -1)) + CHR(13) + CHR(10)

    loForm.Release()
ENDIF

STRTOFILE(lcR, lcOut)
QUIT
