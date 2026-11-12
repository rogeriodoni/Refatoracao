*-- Probe Fase 6 (task780) - a RECUSA DE ABRIR ("Else / Return .f." do Init
*-- legado) em modo PRODUCAO: sem gb_4c_ModoTeste e sem os cursores do pai,
*-- CREATEOBJECT tem de devolver .F. logico, SEM dialogo nenhum.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXCLUSIVE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe780_f6_erro3.txt"

LOCAL lcSaida, lcArq, loForm, loPai, loErr
lcSaida = ""
lcArq   = "C:\4c\automation\vfp_helpers\probe780_f6_recusa_out.txt"

CD "C:\4c\projeto\app\start"

TRY
    DO config.prg
    ConfigurarAmbiente()
    GarantirClasse("Formsigoppei")
    lcSaida = lcSaida + "AMBIENTE_OK" + CHR(13) + CHR(10)
CATCH TO loErr
    lcSaida = lcSaida + "ERRO_AMBIENTE: " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- Agora SAI do modo teste: eh o caminho de PRODUCAO que se quer medir.
gb_4c_ModoTeste = .F.

TRY
    loPai  = CREATEOBJECT("Form")
    *-- sem xBaixa/xBaixa2 na sessao do pai
    IF USED("xBaixa2")
        USE IN xBaixa2
    ENDIF
    IF USED("xBaixa")
        USE IN xBaixa
    ENDIF
    loForm = CREATEOBJECT("Formsigoppei", loPai, loPai.DataSessionId)
    lcSaida = lcSaida + "RECUSA VARTYPE(loForm)=" + VARTYPE(loForm) + ;
        " valor=" + TRANSFORM(loForm) + CHR(13) + CHR(10)
CATCH TO loErr
    lcSaida = lcSaida + "ERRO_RECUSA: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

lcSaida = lcSaida + "FIM" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArq)
QUIT
