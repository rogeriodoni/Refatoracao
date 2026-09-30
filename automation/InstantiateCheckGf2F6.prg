SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_gf2_f6.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_nEv, loc_oCbo, loc_nSes
LOCAL ARRAY gaEv[1]
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGf2BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGf2.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSigPrGf2")

    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ELSE
        loc_cRes = "OK instanciou W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height)

        *-- (1) cnt_4c_Aguarde (campo restante da Fase 6) com a geometria do dump
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "Aguarde T/L/W/H=" + ;
            TRANSFORM(loc_oForm.cnt_4c_Aguarde.Top) + "/" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.Left) + "/" + ;
            TRANSFORM(loc_oForm.cnt_4c_Aguarde.Width) + "/" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.Height) + ;
            " Vis=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.Visible) + ;
            " L1=[" + ALLTRIM(loc_oForm.cnt_4c_Aguarde.lbl_4c_Label1.Caption) + "]" + ;
            " L1vis=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.lbl_4c_Label1.Visible) + ;
            " L2=[" + ALLTRIM(loc_oForm.cnt_4c_Aguarde.lbl_4c_Label2.Caption) + "]" + ;
            " L2vis=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.lbl_4c_Label2.Visible)

        *-- (2) BINDEVENT de Click/GotFocus registrados no combo (AEVENTS: 2 args, evento na col 3)
        loc_oCbo = loc_oForm.cnt_4c_Grf2.cbo_4c_CmbChave1
        loc_nEv  = AEVENTS(gaEv, loc_oCbo)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "BINDEVENT no combo=" + TRANSFORM(loc_nEv)
        FOR loc_nSes = 1 TO loc_nEv
            loc_cRes = loc_cRes + " [" + gaEv[loc_nSes, 3] + "->" + gaEv[loc_nSes, 4] + "]"
        ENDFOR

        *-- (3) ValidarLinhaChave com combo VAZIO: gate ListCount>0 do legado => 0
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "ValidarLinhaChave(combo vazio): 1->" + TRANSFORM(loc_oForm.ValidarLinhaChave(1)) + ;
            " 0->" + TRANSFORM(loc_oForm.ValidarLinhaChave(0))

        *-- (4) Popula o combo e repete: Iif(Type=='N' .And. >0, n, 1) do legado
        loc_oCbo.AddItem("001")
        loc_oCbo.AddItem("002")
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "ValidarLinhaChave(2 itens): 2->"  + TRANSFORM(loc_oForm.ValidarLinhaChave(2)) + ;
            " 0->"   + TRANSFORM(loc_oForm.ValidarLinhaChave(0)) + ;
            " -5->"  + TRANSFORM(loc_oForm.ValidarLinhaChave(-5)) + ;
            " 'x'->" + TRANSFORM(loc_oForm.ValidarLinhaChave("x")) + ;
            " nada->" + TRANSFORM(loc_oForm.ValidarLinhaChave())

        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "ObterChaveSelecionada: 1=[" + loc_oForm.ObterChaveSelecionada(1) + "]" + ;
            " 2=[" + loc_oForm.ObterChaveSelecionada(2) + "]" + ;
            " 99=[" + loc_oForm.ObterChaveSelecionada(99) + "]" + ;
            " 'x'=[" + loc_oForm.ObterChaveSelecionada("x") + "]"

        *-- (5) crRel1 tem de nascer DENTRO da sessao privada do form (DataSession=2)
        loc_nSes = SET("DATASESSION")
        SET DATASESSION TO loc_oForm.DataSessionId
        CREATE CURSOR crRel1 (cEmps C(3), cTitulo1s C(40), cTitulo2s C(40), ;
                              cEmpresas C(50), cStranomes C(10), nFalhas N(12,2), nPesoccbs N(12,2))
        INSERT INTO crRel1 VALUES ("001", "Falha X Recup", "2026", "MARCELLA BAHIA", "JAN", 10.5, 20.25)
        INSERT INTO crRel1 VALUES ("001", "Falha X Recup", "2026", "MARCELLA BAHIA", "FEV", 30.75, 40.00)
        SET DATASESSION TO loc_nSes

        *-- (6) O Click do combo (transcricao do Click legado) roda de ponta a ponta
        loc_oCbo.ListIndex = 1
        loc_oForm.CboChave1Click()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "CboChave1Click()=rodou" + ;
            " AguardeVis(pos)=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.Visible) + ;
            " LockScreen=" + TRANSFORM(loc_oForm.LockScreen) + ;
            " GraficoGerado=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lGraficoGerado) + ;
            " Chave=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cChaveAtual) + "]" + ;
            " Meses=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalMeses) + ;
            " Falha=[" + STRTRAN(ALLTRIM(loc_oForm.this_oBusinessObject.this_cSerieFalha), CHR(9), "|") + "]"

        *-- (7) GotFocus (transcricao de 1 linha do legado)
        loc_oForm.CboChave1GotFocus()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "CboChave1GotFocus()=rodou" + ;
            " OleEnabled=" + TRANSFORM(loc_oForm.cnt_4c_Grf1.obj_4c_OleGrafico1.Enabled)

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCECAO: " + loc_oErro.Message + ;
               " | Linha:" + TRANSFORM(loc_oErro.LineNo) + " | Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "--- DIALOGOS CAPTURADOS ---" + CHR(13) + CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_gf2_f6.txt")
QUIT
