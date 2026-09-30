*-- Instancia FormSIGPRCOT carregando SO as dependencias dele, sem o
*-- ConfigurarAmbiente() completo (que BLOQUEIA nesta maquina, antes de
*-- qualquer form - ver probe_stage.txt: checkpoint C alcancado, D nunca).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cotmin.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
LOCAL loc_oE
STRTOFILE("A: inicio" + CHR(13)+CHR(10), "C:\4c\automation\probe_cotmin.txt")
TRY
    CD C:\4c\projeto\app\start
    DO config.prg          && define as globais gc_4c_Caminho* (nao bloqueia)
    STRTOFILE("B: config.prg OK" + CHR(13)+CHR(10), "C:\4c\automation\probe_cotmin.txt", 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRCOTBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRCOT.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13)+CHR(10), "C:\4c\automation\probe_cotmin.txt", 1)

    STRTOFILE(ExercitarMoeda("USD") + CHR(13)+CHR(10), "C:\4c\automation\probe_cotmin.txt", 1)
    STRTOFILE(ExercitarMoeda("R$")  + CHR(13)+CHR(10), "C:\4c\automation\probe_cotmin.txt", 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), "C:\4c\automation\probe_cotmin.txt", 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), "C:\4c\automation\probe_cotmin.txt", 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13)+CHR(10), "C:\4c\automation\probe_cotmin.txt", 1)
QUIT

FUNCTION ExercitarMoeda(par_cMoeda)
    LOCAL loc_oForm, loc_cOut, loc_oE2, loc_dRef, loc_cAntes, loc_cDepois
    loc_cOut = "moeda [" + par_cMoeda + "] "
    TRY
        loc_oForm = CREATEOBJECT("FormSIGPRCOT", .NULL., par_cMoeda)
        IF VARTYPE(loc_oForm) != "O"
            RETURN loc_cOut + "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
        ENDIF
        loc_cOut = loc_cOut + "Init OK Cols=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + " "

        SET DATASESSION TO loc_oForm.DataSessionId
        SET NULL OFF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados ( ;
            cidchaves C(20), cmoes C(3), datas T, horas C(8), ;
            valos N(11,6), dtalts T, usuars C(10))
        loc_dRef = DATETIME(2026, 9, 27, 0, 0, 0)
        INSERT INTO cursor_4c_Dados (cidchaves,cmoes,datas,horas,valos) ;
            VALUES ("CH1", par_cMoeda, loc_dRef, "09:30", 5.4321)
        INSERT INTO cursor_4c_Dados (cidchaves,cmoes,datas,horas,valos) ;
            VALUES ("CH2", par_cMoeda, loc_dRef, "10:00", 1.0)
        SELECT cursor_4c_Dados
        INDEX ON cidchaves TAG CidChaves
        INDEX ON cmoes + DTOS(datas) + horas TAG Cotacaos

        *-- na linha CH2, digita a hora que a CH1 ja tem -> DUPLICIDADE
        SET ORDER TO CidChaves
        =SEEK("CH2")
        loc_oForm.grd_4c_Dados.Column3.Text1.Value = "09:30"
        loc_cAntes = loc_oForm.grd_4c_Dados.Column3.Text1.Value
        loc_oForm.ValidarCelulaHora(13, 0)
        loc_cDepois = loc_oForm.grd_4c_Dados.Column3.Text1.Value
        loc_cOut = loc_cOut + "| DUP antes=[" + loc_cAntes + "] depois=[" + loc_cDepois + ;
                   "] aviso=" + TRANSFORM(loc_cDepois == "  :  ")

        *-- hora inedita -> NAO deve acusar
        SET ORDER TO CidChaves
        =SEEK("CH2")
        loc_oForm.grd_4c_Dados.Column3.Text1.Value = "23:59"
        loc_oForm.ValidarCelulaHora(13, 0)
        loc_cDepois = loc_oForm.grd_4c_Dados.Column3.Text1.Value
        loc_cOut = loc_cOut + " | INEDITA depois=[" + loc_cDepois + "] falsoPositivo=" + ;
                   TRANSFORM(loc_cDepois == "  :  ")

        loc_oForm.Release()
        SET DATASESSION TO 1
    CATCH TO loc_oE2
        loc_cOut = loc_cOut + " EXCEPTION: " + loc_oE2.Message + ;
                   " Linha:" + TRANSFORM(loc_oE2.LineNo) + " Proc:" + loc_oE2.Procedure
    ENDTRY
    RETURN loc_cOut
ENDFUNC
