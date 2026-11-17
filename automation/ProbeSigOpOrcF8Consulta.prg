* ProbeSigOpOrcF8Consulta.prg
* Fase 8 / task781 - modo CONSULTAR: confere que AjustarBotoesPorModo e
* HabilitarCampos travam a tela e que BtnSalvarClick DELEGA para
* BtnCancelarClick (sai sem gravar, sem tocar no SQL Server).
SET SAFETY OFF
SET RESOURCE OFF

#DEFINE OUTFILE "C:\4c\automation\_probe781f8consulta.txt"
#DEFINE CRLF    CHR(13) + CHR(10)

STRTOFILE("[1] inicio" + CRLF, OUTFILE)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe781f8consulta_dialogs.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

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
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigoporcBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigoporc.prg") ADDITIVE
STRTOFILE("[2] carga ok" + CRLF, OUTFILE, 1)

LOCAL loc_oForm, loc_oErro, loc_cMsg, loc_cItens
loc_cMsg = ""

TRY
    loc_oForm = CREATEOBJECT("Formsigoporc", .NULL., "001", "ORCAMENTO", 1, "0001", "CONSULTAR")

    IF VARTYPE(loc_oForm) <> "O"
        loc_cMsg = loc_cMsg + "INSTANCIOU = NAO (VARTYPE=" + VARTYPE(loc_oForm) + ")" + CRLF
    ELSE
        loc_cMsg = loc_cMsg + "Op_Escolha = [" + loc_oForm.this_cOpEscolha + "]" + CRLF

        loc_cMsg = loc_cMsg + "--- campos (esperado Ena=.F. em CONSULTAR) ---" + CRLF
        loc_cMsg = loc_cMsg + "  contingente=" + TRANSFORM(loc_oForm.txt_4c_Contingente.Enabled) + ;
            " taxaadm=" + TRANSFORM(loc_oForm.txt_4c_TaxaAdm.Enabled) + ;
            " bv=" + TRANSFORM(loc_oForm.txt_4c_BV.Enabled) + ;
            " imposto=" + TRANSFORM(loc_oForm.txt_4c_Imposto.Enabled) + ;
            " impservico=" + TRANSFORM(loc_oForm.txt_4c_ImpostoServico.Enabled) + ;
            " margem=" + TRANSFORM(loc_oForm.txt_4c_Margem.Enabled) + ;
            " novogrupo=" + TRANSFORM(loc_oForm.txt_4c_NovoGrupo.Enabled) + CRLF

        loc_cMsg = loc_cMsg + "--- botoes (esperado Ena=.F., menos TotItens/OK) ---" + CRLF
        loc_cMsg = loc_cMsg + "  incluirlinha=" + TRANSFORM(loc_oForm.cmd_4c_IncluirLinha.Enabled) + ;
            " excluirlinha=" + TRANSFORM(loc_oForm.cmd_4c_ExcluirLinha.Enabled) + ;
            " insblo=" + TRANSFORM(loc_oForm.cmd_4c_InsBlo.Enabled) + ;
            " inssub=" + TRANSFORM(loc_oForm.cmd_4c_InsSub.Enabled) + ;
            " itesub=" + TRANSFORM(loc_oForm.cmd_4c_IteSub.Enabled) + ;
            " cadpro=" + TRANSFORM(loc_oForm.cmd_4c_CadPro.Enabled) + CRLF
        loc_cMsg = loc_cMsg + "  totitens=" + TRANSFORM(loc_oForm.cmd_4c_TotItens.Enabled) + ;
            " OK=" + TRANSFORM(loc_oForm.obj_4c_OK.Enabled) + CRLF
        loc_cMsg = loc_cMsg + "  so-icone (nunca desabilitados - #106): incluirparcela=" + ;
            TRANSFORM(loc_oForm.cmd_4c_IncluirParcela.Enabled) + ;
            " excluirparcela=" + TRANSFORM(loc_oForm.cmd_4c_ExcluirParcela.Enabled) + ;
            " procurar=" + TRANSFORM(loc_oForm.cmd_4c_Procurar.Enabled) + CRLF

        *-- Uma linha no cursor, para provar que NADA e gravado ao sair
        loc_cItens = loc_oForm.this_oBusinessObject.this_cCursorItens
        SELECT (loc_cItens)
        APPEND BLANK
        REPLACE citens WITH 1, dpros WITH "ITEM EM CONSULTA"

        *-- BtnSalvarClick em CONSULTAR: o legado pula o bloco inteiro e so
        *-- fecha. Se delegar certo a BtnCancelarClick, os cursores somem e
        *-- NAO ha SQLEXEC (gnConnHandle = 0 estouraria e apareceria em
        *-- "dialogos suprimidos").
        loc_oForm.BtnSalvarClick()
        loc_cMsg = loc_cMsg + "--- BtnSalvarClick em CONSULTAR ---" + CRLF
        loc_cMsg = loc_cMsg + "  USED(itens)=" + TRANSFORM(USED("cursor_4c_Itens")) + ;
            " USED(parcelas)=" + TRANSFORM(USED("cursor_4c_Parcelas")) + ;
            " form VARTYPE=" + VARTYPE(loc_oForm) + " (esperado .F./.F./X)" + CRLF
    ENDIF
CATCH TO loc_oErro
    loc_cMsg = loc_cMsg + "EXCECAO: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CRLF
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cMsg = loc_cMsg + "--- dialogos suprimidos ---" + CRLF + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CRLF
ELSE
    loc_cMsg = loc_cMsg + "dialogos suprimidos: NENHUM" + CRLF
ENDIF

STRTOFILE(loc_cMsg, OUTFILE, 1)
STRTOFILE("[3] fim" + CRLF, OUTFILE, 1)
QUIT
