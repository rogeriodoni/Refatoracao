SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_gl2_f6.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_nSessaoAnt
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGl2BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGl2.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSigPrGl2", .NULL., 1, .F., 0, .F., "", "")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height)

        *-- Fase 6: os campos restantes existem com as propriedades do SCX
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "edt_ObsOperacao(T=" + TRANSFORM(loc_oForm.edt_4c_ObsOperacao.Top) + ;
            ",CS=" + loc_oForm.edt_4c_ObsOperacao.ControlSource + ")" + CHR(13)+CHR(10) + ;
            "txt_Cliente(T="     + TRANSFORM(loc_oForm.txt_4c_Cliente.Top) + ;
            ",RO="               + TRANSFORM(loc_oForm.txt_4c_Cliente.ReadOnly) + ;
            ",CS="               + loc_oForm.txt_4c_Cliente.ControlSource + ")" + CHR(13)+CHR(10) + ;
            "edt_ObsItens(T="    + TRANSFORM(loc_oForm.edt_4c_ObsItens.Top) + ;
            ",CS="               + loc_oForm.edt_4c_ObsItens.ControlSource + ")" + CHR(13)+CHR(10) + ;
            "lbl_Cliente=["      + loc_oForm.lbl_4c_Cliente.Caption + "]" + ;
            " lbl_ObsItens=["    + loc_oForm.lbl_4c_ObsItens.Caption + "]"

        *-- RAMO 1 do legado: grade VAZIA -> "Nenhuma Operacao Foi Selecionada"
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "Validar(grade vazia)=" + TRANSFORM(loc_oForm.ValidarSelecaoOperacoes()) + ;
            " marcadas=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nOperacoesMarcadas) + ;
            " msg=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]"

        *-- Entra na datasession PRIVADA do form (DataSession = 2) para
        *-- alcancar TmpCabec, que vive la dentro
        loc_nSessaoAnt = SET("DATASESSION")
        SET DATASESSION TO loc_oForm.DataSessionId

        *-- RAMO 2: linhas SEM Flag -> continua "nenhuma selecionada"
        SELECT TmpCabec
        APPEND BLANK
        REPLACE Flag WITH .F., Jobs WITH "JOB-A", Emps WITH "001", Dopes WITH "PEDIDO", Numes WITH 1
        APPEND BLANK
        REPLACE Flag WITH .F., Jobs WITH "JOB-B", Emps WITH "001", Dopes WITH "PEDIDO", Numes WITH 2
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "Validar(2 linhas, 0 marcadas)=" + TRANSFORM(loc_oForm.ValidarSelecaoOperacoes()) + ;
            " marcadas=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nOperacoesMarcadas) + ;
            " msg=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]"

        *-- RAMO 3: DUAS marcadas com Jobs DIFERENTES -> recusa por Job
        REPLACE ALL Flag WITH .T. IN TmpCabec
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "Validar(2 marcadas, Jobs difs)=" + TRANSFORM(loc_oForm.ValidarSelecaoOperacoes()) + ;
            " marcadas=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nOperacoesMarcadas) + ;
            " msg=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]"

        *-- RAMO 4: marcadas com o MESMO Job -> passa
        REPLACE ALL Jobs WITH "JOB-A" IN TmpCabec
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "Validar(2 marcadas, mesmo Job)=" + TRANSFORM(loc_oForm.ValidarSelecaoOperacoes()) + ;
            " marcadas=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nOperacoesMarcadas) + ;
            " msg=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]"

        SET DATASESSION TO loc_nSessaoAnt
        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13)+CHR(10) + "EXCECAO: " + loc_oErro.Message + ;
               " | Linha:" + TRANSFORM(loc_oErro.LineNo) + " | Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- DIALOGOS CAPTURADOS ---" + CHR(13)+CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_gl2_f6.txt")
QUIT
