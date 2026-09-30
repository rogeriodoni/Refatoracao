SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_eop_f6.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_nAnt, loc_nDep
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    *-- So as dependencias (sem ConfigurarAmbiente: ele varre TODOS os forms)
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrEopBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrEop.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSigPrEop", .NULL., "Prev. Entrega", "", "")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height)

        *-- Fase 6: os DOIS pares label/campo existem e sao somente-exibicao
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "lbl_descricao=[" + loc_oForm.lbl_4c_Lbl_descricao.Caption + "]" + ;
            " txtOperacao(L=" + TRANSFORM(loc_oForm.txt_4c__Operacao.Left) + ;
            ",RO=" + TRANSFORM(loc_oForm.txt_4c__Operacao.ReadOnly) + ")" + CHR(13) + CHR(10) + ;
            "lbl_Label1=["    + loc_oForm.lbl_4c_Label1.Caption + "]" + ;
            " txtNumes(L="    + TRANSFORM(loc_oForm.txt_4c__Numes.Left) + ;
            ",RO="            + TRANSFORM(loc_oForm.txt_4c__Numes.ReadOnly) + ")"

        *-- BINDEVENT do AfterRowColChange de fato registrado na grade
        loc_nAnt = AEVENTS(gaEv, loc_oForm.grd_4c_Dados)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "BINDEVENT_na_grade=" + TRANSFORM(loc_nAnt) + " evento=[" + IIF(loc_nAnt > 0, gaEv[1,3], "") + "] handler=[" + IIF(loc_nAnt > 0, gaEv[1,4], "") + "]"

        *-- Handler do AfterRowColChange responde com o parametro do evento
        loc_oForm.GridAfterRowColChange(1)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "GridAfterRowColChange(1)=OK"

        *-- Validacao do cursor: SEM cursor tem de recusar (.F.)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "Validar(cursor inexistente)=" + TRANSFORM(loc_oForm.ValidarCursorOperacoes("cursor_nao_existe"))

        *-- Cursor COMPLETO (as 9 colunas) tem de aceitar (.T.)
        CREATE CURSOR cursor_4c_ProbeOk (Selecionada N(1), Datas D, Emps C(3), ;
            PrazoEnts D, Contas C(20), RClis C(60), Conjuges C(60), Dopes C(20), Numes N(6))
        APPEND BLANK
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "Validar(cursor completo)=" + TRANSFORM(loc_oForm.ValidarCursorOperacoes("cursor_4c_ProbeOk"))

        *-- Cursor INCOMPLETO (sem Conjuges/Numes) tem de recusar (.F.)
        CREATE CURSOR cursor_4c_ProbeBad (Selecionada N(1), Datas D, Emps C(3), ;
            PrazoEnts D, Contas C(20), RClis C(60), Dopes C(20))
        APPEND BLANK
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "Validar(cursor incompleto)=" + TRANSFORM(loc_oForm.ValidarCursorOperacoes("cursor_4c_ProbeBad"))

        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = "EXCECAO: " + loc_oErro.Message + " | Linha:" + TRANSFORM(loc_oErro.LineNo) + ;
               " | Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "--- DIALOGOS CAPTURADOS ---" + CHR(13) + CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_eop_f6.txt")
QUIT
