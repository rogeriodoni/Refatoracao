* ProbeSigOpOrcF7.prg
* Instancia Formsigoporc (task781, Fase 7) headless e confere o que a fase
* entregou: os botoes principais, o binding de Click de cada um e o escopo
* PUBLIC dos handlers (regra #51 - BINDEVENT/chamada externa nao alcanca
* metodo PROTECTED).
SET SAFETY OFF
SET RESOURCE OFF

#DEFINE OUTFILE "C:\4c\automation\_probe781f7.txt"

STRTOFILE("[1] inicio" + CHR(13) + CHR(10), OUTFILE)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe781f7_dialogs.txt"

DO (ADDBS("C:\4c\projeto\app\start") + "config.prg")
STRTOFILE("[2] config.prg ok" + CHR(13) + CHR(10), OUTFILE, 1)

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
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigoporcBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigoporc.prg") ADDITIVE
STRTOFILE("[3] SET PROCEDURE ok" + CHR(13) + CHR(10), OUTFILE, 1)

LOCAL loc_oForm, loc_oErro, loc_cMsg, loc_nI, loc_cNome, loc_aBotoes, loc_aHandlers
loc_cMsg = ""

DIMENSION loc_aBotoes[10]
loc_aBotoes[1]  = "cmd_4c_IncluirLinha"
loc_aBotoes[2]  = "cmd_4c_ExcluirLinha"
loc_aBotoes[3]  = "cmd_4c_IncluirParcela"
loc_aBotoes[4]  = "cmd_4c_ExcluirParcela"
loc_aBotoes[5]  = "cmd_4c_Procurar"
loc_aBotoes[6]  = "cmd_4c_TotItens"
loc_aBotoes[7]  = "cmd_4c_IteSub"
loc_aBotoes[8]  = "cmd_4c_InsBlo"
loc_aBotoes[9]  = "cmd_4c_InsSub"
loc_aBotoes[10] = "cmd_4c_CadPro"

DIMENSION loc_aHandlers[11]
loc_aHandlers[1]  = "BtnIncluirLinhaClick"
loc_aHandlers[2]  = "BtnExcluirLinhaClick"
loc_aHandlers[3]  = "BtnIncluirParcelaClick"
loc_aHandlers[4]  = "BtnExcluirParcelaClick"
loc_aHandlers[5]  = "BtnProcurarClick"
loc_aHandlers[6]  = "BtnTotalItensClick"
loc_aHandlers[7]  = "BtnItensSubnivelClick"
loc_aHandlers[8]  = "BtnInserirBlocoClick"
loc_aHandlers[9]  = "BtnInserirSubBlocoClick"
loc_aHandlers[10] = "BtnCadastroProdutoClick"
loc_aHandlers[11] = "BtnSalvarClick"

TRY
    loc_oForm = CREATEOBJECT("Formsigoporc", .NULL., "001", "ORCAMENTO", 1, "0001", "ALTERAR")
    STRTOFILE("[4] CREATEOBJECT retornou VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUTFILE, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_cMsg = loc_cMsg + "INSTANCIOU    = SIM" + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "Caption       = [" + loc_oForm.Caption + "]" + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "Width/Height  = " + TRANSFORM(loc_oForm.Width) + " x " + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "BO VARTYPE    = " + VARTYPE(loc_oForm.this_oBusinessObject) + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "Op_Escolha    = [" + loc_oForm.this_cOpEscolha + "]" + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "ControlCount  = " + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10)

        loc_cMsg = loc_cMsg + "--- botoes (existencia / Caption / Enabled / Visible / handler ligado) ---" + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO ALEN(loc_aBotoes)
            loc_cNome = loc_aBotoes[loc_nI]
            IF PEMSTATUS(loc_oForm, loc_cNome, 5)
                loc_cMsg = loc_cMsg + "  " + PADR(loc_cNome, 24) + ;
                    " Cap=[" + ALLTRIM(EVALUATE("loc_oForm." + loc_cNome + ".Caption")) + "]" + ;
                    " Vis=" + TRANSFORM(EVALUATE("loc_oForm." + loc_cNome + ".Visible")) + ;
                    " Ena=" + TRANSFORM(EVALUATE("loc_oForm." + loc_cNome + ".Enabled")) + ;
                    " Top=" + TRANSFORM(EVALUATE("loc_oForm." + loc_cNome + ".Top")) + ;
                    " Left=" + TRANSFORM(EVALUATE("loc_oForm." + loc_cNome + ".Left")) + CHR(13) + CHR(10)
            ELSE
                loc_cMsg = loc_cMsg + "  " + PADR(loc_cNome, 24) + " AUSENTE" + CHR(13) + CHR(10)
            ENDIF
        ENDFOR

        *-- obj_4c_OK eh CommandGroup: nao tem Caption (regra #33), a legenda
        *-- mora no Buttons(1).
        IF PEMSTATUS(loc_oForm, "obj_4c_OK", 5)
            loc_cMsg = loc_cMsg + "  " + PADR("obj_4c_OK", 24) + ;
                " ButtonCount=" + TRANSFORM(loc_oForm.obj_4c_OK.ButtonCount) + ;
                " Btn1Cap=[" + ALLTRIM(loc_oForm.obj_4c_OK.Buttons(1).Caption) + "]" + ;
                " Vis=" + TRANSFORM(loc_oForm.obj_4c_OK.Visible) + ;
                " Ena=" + TRANSFORM(loc_oForm.obj_4c_OK.Enabled) + ;
                " Top=" + TRANSFORM(loc_oForm.obj_4c_OK.Top) + ;
                " Left=" + TRANSFORM(loc_oForm.obj_4c_OK.Left) + CHR(13) + CHR(10)
        ELSE
            loc_cMsg = loc_cMsg + "  obj_4c_OK AUSENTE" + CHR(13) + CHR(10)
        ENDIF

        loc_cMsg = loc_cMsg + "--- handlers: existe / PROTECTED? (regra #51: tem de ser .F.) ---" + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO ALEN(loc_aHandlers)
            loc_cNome = loc_aHandlers[loc_nI]
            loc_cMsg = loc_cMsg + "  " + PADR(loc_cNome, 26) + ;
                " existe=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cNome, 5)) + ;
                " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cNome, 2)) + CHR(13) + CHR(10)
        ENDFOR

        loc_cMsg = loc_cMsg + "--- grades ---" + CHR(13) + CHR(10)
        IF PEMSTATUS(loc_oForm, "grd_4c_Itens", 5)
            loc_cMsg = loc_cMsg + "  grd_4c_Itens ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Itens.ColumnCount) + ;
                " RecordSource=[" + loc_oForm.grd_4c_Itens.RecordSource + "]" + CHR(13) + CHR(10)
        ENDIF
        IF PEMSTATUS(loc_oForm, "grd_4c_Parcelas", 5)
            loc_cMsg = loc_cMsg + "  grd_4c_Parcelas ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Parcelas.ColumnCount) + ;
                " RecordSource=[" + loc_oForm.grd_4c_Parcelas.RecordSource + "]" + CHR(13) + CHR(10)
        ENDIF

        loc_oForm.Release()
        loc_cMsg = loc_cMsg + "RELEASE = OK" + CHR(13) + CHR(10)
    ELSE
        loc_cMsg = loc_cMsg + "INSTANCIOU = NAO (VARTYPE=" + VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cMsg = loc_cMsg + "EXCECAO: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cMsg = loc_cMsg + "--- dialogos suprimidos ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cMsg = loc_cMsg + "dialogos suprimidos: NENHUM" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cMsg, OUTFILE, 1)
STRTOFILE("[5] fim" + CHR(13) + CHR(10), OUTFILE, 1)
QUIT
