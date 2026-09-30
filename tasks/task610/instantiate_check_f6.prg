*-- Probe headless da Fase 6 de FormSigPrFem.
*-- NAO chama ConfigurarAmbiente() (BLOQUEIA nesta maquina, antes de qualquer
*-- form): carrega a mao so as dependencias deste form.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task610\vfp_err_f6.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

#DEFINE ARQ_LOG "C:\4c\tasks\task610\instantiate_f6.txt"

LOCAL loc_oE, loc_oForm

STRTOFILE("A: inicio" + CHR(13) + CHR(10), ARQ_LOG)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), ARQ_LOG, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + ;
                 gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrFemBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrFem.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), ARQ_LOG, 1)

    loc_oForm = CREATEOBJECT("FormSigPrFem")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("D: NAO INSTANCIOU VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), ARQ_LOG, 1)
    ELSE
        STRTOFILE("D: Init OK Width=" + TRANSFORM(loc_oForm.Width) + CHR(13) + CHR(10), ARQ_LOG, 1)

        STRTOFILE("E: CONTROLES" + ;
            " Label4="        + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Label4", 5)) + ;
            " Demonstrativo=" + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_Demonstrativo", 5)) + ;
            " Datai="         + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_Datai", 5)) + ;
            " Dataf="         + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_Dataf", 5)) + CHR(13) + CHR(10), ARQ_LOG, 1)

        STRTOFILE("F: LABEL4 Cap=[" + ALLTRIM(loc_oForm.lbl_4c_Label4.Caption) + "]" + ;
            " Left="  + TRANSFORM(loc_oForm.lbl_4c_Label4.Left) + ;
            " Top="   + TRANSFORM(loc_oForm.lbl_4c_Label4.Top) + ;
            " Width=" + TRANSFORM(loc_oForm.lbl_4c_Label4.Width) + ;
            " Visible=" + TRANSFORM(loc_oForm.lbl_4c_Label4.Visible) + CHR(13) + CHR(10), ARQ_LOG, 1)

        STRTOFILE("G: DEMONSTRATIVO Left=" + TRANSFORM(loc_oForm.txt_4c_Demonstrativo.Left) + ;
            " Top="       + TRANSFORM(loc_oForm.txt_4c_Demonstrativo.Top) + ;
            " Width="     + TRANSFORM(loc_oForm.txt_4c_Demonstrativo.Width) + ;
            " Height="    + TRANSFORM(loc_oForm.txt_4c_Demonstrativo.Height) + ;
            " MaxLength=" + TRANSFORM(loc_oForm.txt_4c_Demonstrativo.MaxLength) + ;
            " Format=["   + loc_oForm.txt_4c_Demonstrativo.Format + "]" + ;
            " Visible="   + TRANSFORM(loc_oForm.txt_4c_Demonstrativo.Visible) + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Metodos PUBLIC exigidos pelo BINDEVENT (regra #3)
        STRTOFILE("H: METODOS" + ;
            " TeclaDemonstrativo="      + TRANSFORM(PEMSTATUS(loc_oForm, "TeclaDemonstrativo", 5)) + ;
            " ValidarDemonstrativo="    + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarDemonstrativo", 5)) + ;
            " AbrirBuscaDemonstrativo=" + TRANSFORM(PEMSTATUS(loc_oForm, "AbrirBuscaDemonstrativo", 5)) + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- Exercita so o ramo SEM SQL/picker (campo vazio -> limpa, igual ao
        *-- legado). Ramo com valor preenchido dispara SQLEXEC (rede
        *-- indisponivel nesta maquina - regra de memoria "SqlServer 200.10
        *-- inalcancavel") e abriria FormBuscaAuxiliar modal - fora de escopo
        *-- de um probe headless.
        loc_oForm.txt_4c_Demonstrativo.Value = "ALGO"
        loc_oForm.txt_4c_Demonstrativo.Value = ""
        loc_oForm.ValidarDemonstrativo()
        STRTOFILE("I: ValidarDemonstrativo(vazio) OK Value=[" + ;
            loc_oForm.txt_4c_Demonstrativo.Value + "]" + CHR(13) + CHR(10), ARQ_LOG, 1)

        *-- TeclaDemonstrativo com tecla neutra (nao deve fazer nada)
        loc_oForm.TeclaDemonstrativo(65, 0)
        STRTOFILE("J: TeclaDemonstrativo(tecla neutra) OK" + CHR(13) + CHR(10), ARQ_LOG, 1)

        loc_oForm.Release()
        STRTOFILE("K: Release OK" + CHR(13) + CHR(10), ARQ_LOG, 1)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), ARQ_LOG, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + ;
              FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), ARQ_LOG, 1)
ENDIF

STRTOFILE("Z: fim" + CHR(13) + CHR(10), ARQ_LOG, 1)
QUIT
