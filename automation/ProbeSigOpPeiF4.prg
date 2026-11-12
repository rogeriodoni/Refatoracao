*==============================================================================
* ProbeSigOpPeiF4.prg - Probe da FASE 4 de Formsigoppei (grade + botao).
*
* Mede DUAS aberturas:
*   A) SEM os cursores do form pai  -> prova que a tela abre e a grade fica
*                                      vinculada ao cursor vazio (regra #41)
*   B) COM xBaixa/xBaixa2 populados -> prova que CarregarLista devolve .T.,
*                                      que o cursor de exibicao recebe LINHA
*                                      (nao basta o metodo devolver .T.) e que
*                                      a grade continua com as 7 colunas, as
*                                      larguras e os headers do legado DEPOIS
*                                      do rebind.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

#DEFINE OUTFILE "C:\4c\_tmp_probe_f4.txt"

STRTOFILE("[1] inicio" + CHR(13) + CHR(10), OUTFILE)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\_tmp_probe_f4_err.txt"

DO (ADDBS("C:\4c\projeto\app\start") + "config.prg")

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigoppeiBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigoppei.prg") ADDITIVE
STRTOFILE("[2] SET PROCEDURE ok" + CHR(13) + CHR(10), OUTFILE, 1)

LOCAL loc_cMsg, loc_oPaiFake
loc_cMsg = ""

*-- Cenario A: sem cursor do pai
loc_cMsg = loc_cMsg + "=== CENARIO A: sem xBaixa/xBaixa2 ===" + CHR(13) + CHR(10)
loc_cMsg = loc_cMsg + MedirForm(.NULL.)

*-- Cenario B: cursores do pai de pe, com a estrutura EXATA do dump legado
loc_cMsg = loc_cMsg + CHR(13) + CHR(10) + "=== CENARIO B: xBaixa/xBaixa2 populados ===" + CHR(13) + CHR(10)

CREATE CURSOR xBaixa  (CPros C(14), Qtds N(12,3), QtBaixas N(12,3), ;
                       QtProds N(12,3), pVens N(15,6), Moevs C(3))
INSERT INTO xBaixa  VALUES ("1111", 10, 4, 10, 0, "   ")
INSERT INTO xBaixa  VALUES ("2222", 25, 5, 25, 0, "   ")

CREATE CURSOR xBaixa2 (CPros C(14), CodCors C(4), CodTams C(4), ;
                       Qtds N(12,3), QtBaixas N(12,3), QtProds N(12,3))
INSERT INTO xBaixa2 VALUES ("1111", "AZ ", "M  ", 10, 4, 10)

*-- Pai FALSO na sessao de dados DESTE .prg (DataSessionId = 1), que eh onde
*-- os cursores acima vivem - eh o contrato do Init (par_oFormPai + sessao).
loc_oPaiFake = CREATEOBJECT("Form")
loc_cMsg = loc_cMsg + "pai fake DataSessionId=" + TRANSFORM(loc_oPaiFake.DataSessionId) + CHR(13) + CHR(10)

loc_cMsg = loc_cMsg + MedirForm(loc_oPaiFake)

STRTOFILE(loc_cMsg, OUTFILE, 1)

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("--- arquivo de erro do FormBase ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUTFILE, 1)
ELSE
    STRTOFILE("arquivo de erro do FormBase: AUSENTE (bom sinal)" + CHR(13) + CHR(10), OUTFILE, 1)
ENDIF

STRTOFILE("[3] fim" + CHR(13) + CHR(10), OUTFILE, 1)
QUIT


FUNCTION MedirForm(par_oPai)
    LOCAL loc_oForm, loc_oErro, loc_cR, loc_oG, loc_nI, loc_cAlias, loc_lCarga, loc_nEv, loc_nJ
    LOCAL ARRAY loc_aEv[1]
    loc_cR = ""

    TRY
        IF VARTYPE(par_oPai) = "O"
            loc_oForm = CREATEOBJECT("Formsigoppei", par_oPai, par_oPai.DataSessionId)
        ELSE
            loc_oForm = CREATEOBJECT("Formsigoppei")
        ENDIF

        IF VARTYPE(loc_oForm) # "O"
            loc_cR = loc_cR + "INSTANCIOU = NAO (VARTYPE=" + VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10)
        ELSE
            loc_cR = loc_cR + "INSTANCIOU = SIM  DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId) + "  ControlCount=" + ;
                TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10)

            loc_cAlias = ALLTRIM(loc_oForm.this_oBusinessObject.this_cCursorItens)
            loc_cR = loc_cR + "cursor exibicao = [" + loc_cAlias + "]" + ;
                "  USED=" + TRANSFORM(USED(loc_cAlias)) + ;
                "  RECCOUNT=" + TRANSFORM(IIF(USED(loc_cAlias), RECCOUNT(loc_cAlias), -1)) + CHR(13) + CHR(10)
            loc_cR = loc_cR + "BO: DadosCarregados=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lDadosCarregados) + ;
                "  TotItens=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotItens) + ;
                "  TotBaixa=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotBaixa) + ;
                "  TotDisp="  + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotDisp) + CHR(13) + CHR(10)

            *-- Re-chamada do funil de FORA da classe: prova que CarregarLista
            *-- eh PUBLIC (regra #3) e que rebindar duas vezes nao degrada.
            loc_lCarga = loc_oForm.CarregarLista()
            loc_cR = loc_cR + "CarregarLista() de fora = " + TRANSFORM(loc_lCarga) + CHR(13) + CHR(10)

            *-- Shape (moldura) e botao
            IF PEMSTATUS(loc_oForm, "shp_4c_Shape1", 5)
                loc_cR = loc_cR + "shp_4c_Shape1: Top=" + TRANSFORM(loc_oForm.shp_4c_Shape1.Top) + ;
                    " Left=" + TRANSFORM(loc_oForm.shp_4c_Shape1.Left) + ;
                    " W=" + TRANSFORM(loc_oForm.shp_4c_Shape1.Width) + ;
                    " H=" + TRANSFORM(loc_oForm.shp_4c_Shape1.Height) + ;
                    " BackStyle=" + TRANSFORM(loc_oForm.shp_4c_Shape1.BackStyle) + ;
                    " BorderStyle=" + TRANSFORM(loc_oForm.shp_4c_Shape1.BorderStyle) + CHR(13) + CHR(10)
            ELSE
                loc_cR = loc_cR + "shp_4c_Shape1 AUSENTE" + CHR(13) + CHR(10)
            ENDIF

            IF PEMSTATUS(loc_oForm, "cmd_4c_BtnCancelar", 5)
                loc_cR = loc_cR + "cmd_4c_BtnCancelar: Top=" + TRANSFORM(loc_oForm.cmd_4c_BtnCancelar.Top) + ;
                    " Left=" + TRANSFORM(loc_oForm.cmd_4c_BtnCancelar.Left) + ;
                    " W=" + TRANSFORM(loc_oForm.cmd_4c_BtnCancelar.Width) + ;
                    " H=" + TRANSFORM(loc_oForm.cmd_4c_BtnCancelar.Height) + ;
                    " Cap=[" + loc_oForm.cmd_4c_BtnCancelar.Caption + "]" + ;
                    " Cancel=" + TRANSFORM(loc_oForm.cmd_4c_BtnCancelar.Cancel) + ;
                    " Themes=" + TRANSFORM(loc_oForm.cmd_4c_BtnCancelar.Themes) + ;
                    " Vis=" + TRANSFORM(loc_oForm.cmd_4c_BtnCancelar.Visible) + CHR(13) + CHR(10)
                loc_cR = loc_cR + "  Picture=[" + loc_oForm.cmd_4c_BtnCancelar.Picture + "]" + ;
                    "  FILE=" + TRANSFORM(FILE(loc_oForm.cmd_4c_BtnCancelar.Picture)) + CHR(13) + CHR(10)
                loc_cR = loc_cR + "  Right=" + TRANSFORM(loc_oForm.cmd_4c_BtnCancelar.Left + loc_oForm.cmd_4c_BtnCancelar.Width) + ;
                    " (Form.Width=" + TRANSFORM(loc_oForm.Width) + ")" + ;
                    "  Bottom=" + TRANSFORM(loc_oForm.cmd_4c_BtnCancelar.Top + loc_oForm.cmd_4c_BtnCancelar.Height) + ;
                    " (faixa=80)" + CHR(13) + CHR(10)
                loc_nEv = AEVENTS(loc_aEv, loc_oForm.cmd_4c_BtnCancelar)
                loc_cR = loc_cR + "  BINDEVENT total=" + TRANSFORM(loc_nEv)
                FOR loc_nJ = 1 TO loc_nEv
                    loc_cR = loc_cR + "  [" + TRANSFORM(loc_aEv[loc_nJ, 2]) + " -> " + TRANSFORM(loc_aEv[loc_nJ, 4]) + "]"
                ENDFOR
                loc_cR = loc_cR + CHR(13) + CHR(10)
                loc_cR = loc_cR + "  BtnCancelarClick PUBLIC(nao-protected) = " + ;
                    TRANSFORM(!PEMSTATUS(loc_oForm, "BtnCancelarClick", 2)) + CHR(13) + CHR(10)
                loc_cR = loc_cR + "  CarregarLista PUBLIC(nao-protected) = " + ;
                    TRANSFORM(!PEMSTATUS(loc_oForm, "CarregarLista", 2)) + CHR(13) + CHR(10)
            ELSE
                loc_cR = loc_cR + "cmd_4c_BtnCancelar AUSENTE" + CHR(13) + CHR(10)
            ENDIF

            *-- Grade
            IF PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)
                loc_oG = loc_oForm.grd_4c_Dados
                loc_cR = loc_cR + "grd_4c_Dados: Top=" + TRANSFORM(loc_oG.Top) + ;
                    " Left=" + TRANSFORM(loc_oG.Left) + ;
                    " W=" + TRANSFORM(loc_oG.Width) + ;
                    " H=" + TRANSFORM(loc_oG.Height) + ;
                    " ColumnCount=" + TRANSFORM(loc_oG.ColumnCount) + ;
                    " ReadOnly=" + TRANSFORM(loc_oG.ReadOnly) + ;
                    " RecordMark=" + TRANSFORM(loc_oG.RecordMark) + ;
                    " DeleteMark=" + TRANSFORM(loc_oG.DeleteMark) + ;
                    " Vis=" + TRANSFORM(loc_oG.Visible) + CHR(13) + CHR(10)
                loc_cR = loc_cR + "  RecordSource=[" + loc_oG.RecordSource + "]" + ;
                    "  HeaderHeight=" + TRANSFORM(loc_oG.HeaderHeight) + ;
                    "  RowHeight=" + TRANSFORM(loc_oG.RowHeight) + ;
                    "  Panel=" + TRANSFORM(loc_oG.Panel) + CHR(13) + CHR(10)

                FOR loc_nI = 1 TO loc_oG.ColumnCount
                    loc_cR = loc_cR + "  Col" + TRANSFORM(loc_nI) + ;
                        ": Cap=[" + loc_oG.Columns(loc_nI).Header1.Caption + "]" + ;
                        " Src=[" + loc_oG.Columns(loc_nI).ControlSource + "]" + ;
                        " W=" + TRANSFORM(loc_oG.Columns(loc_nI).Width) + ;
                        " RO=" + TRANSFORM(loc_oG.Columns(loc_nI).ReadOnly) + ;
                        " Mask=[" + loc_oG.Columns(loc_nI).InputMask + "]" + ;
                        " TxtRO=" + TRANSFORM(loc_oG.Columns(loc_nI).Text1.ReadOnly) + ;
                        " TxtMask=[" + loc_oG.Columns(loc_nI).Text1.InputMask + "]" + CHR(13) + CHR(10)
                ENDFOR
            ELSE
                loc_cR = loc_cR + "grd_4c_Dados AUSENTE" + CHR(13) + CHR(10)
            ENDIF

            *-- O Click real do botao: Release() tem de destruir o objeto
            loc_oForm.BtnCancelarClick()
            loc_cR = loc_cR + "pos BtnCancelarClick: VARTYPE(form)=" + VARTYPE(loc_oForm) + ;
                "  USED(" + loc_cAlias + ")=" + TRANSFORM(USED(loc_cAlias)) + CHR(13) + CHR(10)
        ENDIF
    CATCH TO loc_oErro
        loc_cR = loc_cR + "EXCECAO: " + loc_oErro.Message + ;
            " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
            " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
    ENDTRY

    RETURN loc_cR
ENDFUNC
