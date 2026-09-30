SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprdft_f5.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_nI, loc_oC, loc_cFoco
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    *-- ConfigurarAmbiente() NAO eh chamado: conecta em 192.168.200.10, que
    *-- esta inalcancavel nesta maquina e bloqueia o probe (ver memoria).
    PUBLIC gnConnHandle
    gnConnHandle = -1

    *-- MAS o carregamento das classes/forms mora DENTRO de ConfigurarAmbiente
    *-- (config.prg linhas 304-399): pular o metodo sem repor esses
    *-- SET PROCEDURE faz CREATEOBJECT estourar "Class definition
    *-- FORMSIGPRDFT is not found" - o probe mediria a propria falta de setup,
    *-- nao o form. Carregar so as dependencias, como ProbeSigprdft.prg faz.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigprdftBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprdft.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("Formsigprdft")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

        *-- (1) BackStyle do CommandGroup de saida (SCX legado: 0)
        loc_cRes = loc_cRes + "obj_4c_SAIDA.BackStyle = " + ;
            TRANSFORM(loc_oForm.obj_4c_SAIDA.BackStyle) + "   (legado: 0)" + CHR(13) + CHR(10)
        loc_cRes = loc_cRes + "lbl_4c_Titulo.ToolTipText = [" + ;
            loc_oForm.cnt_4c_Cabecalho.lbl_4c_Titulo.ToolTipText + "]" + CHR(13) + CHR(10)

        *-- (2) TabIndex de cada controle do form
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "--- TabIndex por controle ---" + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO loc_oForm.ControlCount
            loc_oC = loc_oForm.Controls(loc_nI)
            IF PEMSTATUS(loc_oC, "TabIndex", 5)
                loc_cRes = loc_cRes + PADR(loc_oC.Name, 24) + " TabIndex=" + ;
                    PADL(TRANSFORM(loc_oC.TabIndex), 2) + ;
                    "  TabStop=" + IIF(PEMSTATUS(loc_oC, "TabStop", 5), TRANSFORM(loc_oC.TabStop), "n/a") + CHR(13) + CHR(10)
            ENDIF
        ENDFOR

        *-- (3) sequencia efetiva de FOCO: focalizaveis ordenados por TabIndex
        loc_cFoco = ""
        LOCAL loc_nT, loc_nJ
        FOR loc_nT = 1 TO 20
            FOR loc_nJ = 1 TO loc_oForm.ControlCount
                loc_oC = loc_oForm.Controls(loc_nJ)
                IF PEMSTATUS(loc_oC, "TabIndex", 5) AND PEMSTATUS(loc_oC, "TabStop", 5)
                    IF loc_oC.TabIndex = loc_nT AND loc_oC.TabStop
                        loc_cFoco = loc_cFoco + IIF(EMPTY(loc_cFoco), "", " -> ") + loc_oC.Name
                    ENDIF
                ENDIF
            ENDFOR
        ENDFOR
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "--- Ordem efetiva de FOCO ---" + CHR(13) + CHR(10) + ;
            loc_cFoco + CHR(13) + CHR(10)

        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_sigprdft_f5.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_sigprdft_f5.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprdft_f5.txt")
QUIT
