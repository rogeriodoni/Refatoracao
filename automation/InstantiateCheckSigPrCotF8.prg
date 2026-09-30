*-- Fase 8 / FormSIGPRCOT: exercita os hooks PROTECTED FormParaBO/BOParaForm
*-- via SUBCLASSE (script solto nao alcanca membro protegido - so subclasse).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_prcot_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = "FAIL(v1)"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("ProbeSigPrCot", .NULL., "USD")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
                   " Cols=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount)

        *-- sem cursor: os dois hooks devem devolver .F. SEM estourar
        loc_cRes = loc_cRes + " | semCursor: " + loc_oForm.ProbeHooks()

        *-- com cursor (DataSession PRIVADA - criar DENTRO da sessao do form,
        *-- senao USED() dentro dos metodos da .F.)
        SET DATASESSION TO loc_oForm.DataSessionId
        SET NULL OFF
        CREATE CURSOR cursor_4c_Dados ( ;
            cidchaves C(20), cmoes C(3), datas T, horas C(8), ;
            valos N(11,6), dtalts T, usuars C(10))
        APPEND BLANK
        REPLACE cidchaves WITH "CHAVE0000000000001", ;
                cmoes     WITH "USD", ;
                datas     WITH DATETIME(), ;
                horas     WITH "09:30", ;
                valos     WITH 5.432100 ;
             IN cursor_4c_Dados

        loc_cRes = loc_cRes + " | comCursor: " + loc_oForm.ProbeHooks()
        loc_cRes = loc_cRes + " | roundTrip: " + loc_oForm.ProbeRoundTrip()

        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_prcot_f8.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_prcot_f8.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_prcot_f8_result.txt")
QUIT

DEFINE CLASS ProbeSigPrCot AS FormSIGPRCOT
    PROCEDURE ProbeHooks()
        LOCAL loc_c, loc_oE
        loc_c = "v1"
        TRY
            loc_c = loc_c + " FormParaBO=" + TRANSFORM(THIS.FormParaBO())
        CATCH TO loc_oE
            loc_c = loc_c + " FormParaBO=ERRO[" + loc_oE.Message + "]"
        ENDTRY
        TRY
            loc_c = loc_c + " BOParaForm=" + TRANSFORM(THIS.BOParaForm())
        CATCH TO loc_oE
            loc_c = loc_c + " BOParaForm=ERRO[" + loc_oE.Message + "]"
        ENDTRY
        RETURN loc_c
    ENDPROC

    *-- Prova o round-trip linha -> BO -> linha: le a linha, MUTA o BO e grava
    *-- de volta; a linha tem de refletir exatamente o que o BO passou a ter.
    PROCEDURE ProbeRoundTrip()
        LOCAL loc_c, loc_oE
        loc_c = ""
        TRY
            THIS.FormParaBO()
            loc_c = "BOleu: moeda=[" + ALLTRIM(THIS.this_oBusinessObject.this_cMoeda) + "]" + ;
                    " hora=[" + ALLTRIM(THIS.this_oBusinessObject.this_cHora) + "]" + ;
                    " valor=" + TRANSFORM(THIS.this_oBusinessObject.this_nValor) + ;
                    " chave=[" + ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves) + "]"

            THIS.this_oBusinessObject.this_cHora  = "18:45"
            THIS.this_oBusinessObject.this_nValor = 7.250000
            THIS.this_oBusinessObject.this_cUsuario = "PROBE"
            THIS.BOParaForm()

            loc_c = loc_c + " || linhaPos: hora=[" + ALLTRIM(cursor_4c_Dados.horas) + "]" + ;
                    " valor=" + TRANSFORM(cursor_4c_Dados.valos) + ;
                    " usuars=[" + ALLTRIM(cursor_4c_Dados.usuars) + "]" + ;
                    " chave=[" + ALLTRIM(cursor_4c_Dados.cidchaves) + "]"
        CATCH TO loc_oE
            loc_c = loc_c + " ERRO[" + loc_oE.Message + " Ln:" + TRANSFORM(loc_oE.LineNo) + ;
                    " Proc:" + loc_oE.Procedure + "]"
        ENDTRY
        RETURN loc_c
    ENDPROC
ENDDEFINE
