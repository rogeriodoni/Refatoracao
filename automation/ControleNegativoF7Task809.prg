*==============================================================================
* ControleNegativoF7Task809.prg - CONTROLE NEGATIVO do QueryUnload.
*
* Subclasse de Formsigoptef com o QueryUnload ARRANCADO (devolve .T. e nao
* chama NODEFAULT, que eh o comportamento herdado de FormBase). Se o Alt+F4
* DESTRUIR esta subclasse, fica provado que o override da classe migrada eh o
* que mantem o objeto vivo - sem isso, "o positivo passou" nao distingue
* conserto de coincidencia.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcPath, loF, loc_oErro
lcPath = "C:\4c\automation\_f7t809_negativo.txt"

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_UsuarioLogado
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f7t809_erros_neg.txt"
gc_4c_UsuarioLogado    = "PROBE"

STRTOFILE("N1 inicio" + CHR(13) + CHR(10), lcPath)

DECLARE INTEGER SendMessage IN "user32.dll" ;
    INTEGER hWnd, INTEGER wMsg, INTEGER wParam, INTEGER lParam

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
                 gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
                 gc_4c_CaminhoIcones)

    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigoptefBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigoptef.prg") ADDITIVE

    STRTOFILE("N2 dependencias OK" + CHR(13) + CHR(10), lcPath, 1)
CATCH TO loc_oErro
    STRTOFILE("N2 SETUP FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), lcPath, 1)
ENDTRY

TRY
    loF = CREATEOBJECT("ProbeSemQueryUnload809")
    STRTOFILE("N3_CRIOU=" + VARTYPE(loF) + CHR(13) + CHR(10), lcPath, 1)
    loF.Show(2)
    SendMessage(loF.HWnd, 0x0010, 0, 0)
    STRTOFILE("N3_VARTYPE_DEPOIS=" + VARTYPE(loF) + CHR(13) + CHR(10), lcPath, 1)
    IF VARTYPE(loF) = "O"
        STRTOFILE("N3_RESULTADO=OBJETO VIVO (negativo NAO reproduziu)" + CHR(13) + CHR(10), lcPath, 1)
    ELSE
        STRTOFILE("N3_RESULTADO=DESTRUIDO (negativo reproduziu o defeito)" + CHR(13) + CHR(10), lcPath, 1)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("N3_ERRO=" + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), lcPath, 1)
ENDTRY

*-- Leitura DEPOIS do fechamento: eh aqui que o defeito se manifesta no
*-- chamador, com "<var> is not an object".
TRY
    STRTOFILE("N4_LEITURA_POS=" + TRANSFORM(loF.this_nValPago) + CHR(13) + CHR(10), lcPath, 1)
CATCH TO loc_oErro
    STRTOFILE("N4_LEITURA_POS_ERRO=" + loc_oErro.Message + CHR(13) + CHR(10), lcPath, 1)
ENDTRY

STRTOFILE("FIM" + CHR(13) + CHR(10), lcPath, 1)
QUIT

DEFINE CLASS ProbeSemQueryUnload809 AS Formsigoptef
    *-- QueryUnload ARRANCADO: devolve .T. (autoriza o fechamento) e NAO chama
    *-- NODEFAULT - exatamente o que a classe migrada faria se o override dela
    *-- nao existisse, porque eh o comportamento herdado de FormBase.
    PROCEDURE QueryUnload()
        RETURN .T.
    ENDPROC
ENDDEFINE
