* ProbeSigOpOrcF8.prg
* Instancia Formsigoporc (task781, Fase 8) headless e EXERCITA o que a fase
* entregou - nao basta "existe o metodo": chama FormParaBO/BOParaForm/
* HabilitarCampos/AjustarBotoesPorModo/CarregarLista/LimparCampos com uma
* linha real no cursor de itens e confere o efeito de cada um.
* Em especial prova o conserto de CriarCursorItens (tpesos/univals/utilizas):
* antes dele BO.CarregarDoCursor devolvia .F. com "Variable TPESOS is not found".
SET SAFETY OFF
SET RESOURCE OFF

#DEFINE OUTFILE "C:\4c\automation\_probe781f8.txt"
#DEFINE CRLF    CHR(13) + CHR(10)

STRTOFILE("[1] inicio" + CRLF, OUTFILE)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe781f8_dialogs.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

DO (ADDBS("C:\4c\projeto\app\start") + "config.prg")
STRTOFILE("[2] config.prg ok" + CRLF, OUTFILE, 1)

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
STRTOFILE("[3] SET PROCEDURE ok" + CRLF, OUTFILE, 1)

LOCAL loc_oForm, loc_oErro, loc_cMsg, loc_nI, loc_cNome, loc_aMetodos, ;
    loc_cItens, loc_lOk, loc_nAntes
loc_cMsg = ""

DIMENSION loc_aMetodos[8]
loc_aMetodos[1] = "CarregarLista"
loc_aMetodos[2] = "FormParaBO"
loc_aMetodos[3] = "BOParaForm"
loc_aMetodos[4] = "HabilitarCampos"
loc_aMetodos[5] = "AjustarBotoesPorModo"
loc_aMetodos[6] = "LimparCampos"
loc_aMetodos[7] = "BtnCancelarClick"
loc_aMetodos[8] = "BtnSalvarClick"

*-- FormParaBO/BOParaForm/LimparCampos sao hooks PROTECTED na FormBase
*-- (formbase.prg:276/280/285) e o override do form NAO alarga o escopo -
*-- PROTECTED em qualquer classe da cadeia prevalece (regra #51). Quem
*-- chama de fora recebe "Property FORMPARABO is not found". Para
*-- exercita-los, o probe instancia uma SUBCLASSE com wrappers publicos
*-- (subclasse alcanca membro protegido da mae) - mesma tecnica que o
*-- CLAUDE.md recomenda para medir escopo sem mexer no codigo de producao.
TRY
    loc_oForm = CREATEOBJECT("ProbeFormsigoporc", .NULL., "001", "ORCAMENTO", 1, "0001", "ALTERAR")
    STRTOFILE("[4] CREATEOBJECT retornou VARTYPE=" + VARTYPE(loc_oForm) + CRLF, OUTFILE, 1)

    IF VARTYPE(loc_oForm) <> "O"
        loc_cMsg = loc_cMsg + "INSTANCIOU = NAO (VARTYPE=" + VARTYPE(loc_oForm) + ")" + CRLF
    ELSE
        loc_cMsg = loc_cMsg + "INSTANCIOU    = SIM" + CRLF
        loc_cMsg = loc_cMsg + "Op_Escolha    = [" + loc_oForm.this_cOpEscolha + "]" + CRLF

        *-- 1) os metodos da fase existem e NAO sao PROTECTED (regra #51/#3)
        loc_cMsg = loc_cMsg + "--- metodos da Fase 8: existe / PROTECTED (tem de ser .F.) ---" + CRLF
        FOR loc_nI = 1 TO ALEN(loc_aMetodos)
            loc_cNome = loc_aMetodos[loc_nI]
            loc_cMsg = loc_cMsg + "  " + PADR(loc_cNome, 22) + ;
                " existe=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cNome, 5)) + ;
                " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cNome, 2)) + CRLF
        ENDFOR

        *-- 2) uma linha REAL no cursor de itens (o que o legado teria depois
        *--    do AddCursor). So assim FormParaBO/CarregarDoCursor sao testados
        *--    de verdade - cursor vazio devolveria .T. sem ler nada.
        loc_cItens = loc_oForm.this_oBusinessObject.this_cCursorItens
        SELECT (loc_cItens)
        APPEND BLANK
        REPLACE citens WITH 7, citem2 WITH 3, citem3 WITH 3, cpros WITH "PRO001", ;
            dpros WITH "PRODUTO DE TESTE", qtds WITH 2, units WITH 10, totas WITH 20, ;
            tota7s WITH 12, tota8s WITH 8, tpesos WITH 1.5, univals WITH 11, ;
            utilizas WITH 4, cidchaves WITH "CHAVE-EXISTENTE-01"
        loc_cMsg = loc_cMsg + "--- cursor de itens ---" + CRLF
        loc_cMsg = loc_cMsg + "  alias=" + loc_cItens + " RECCOUNT=" + ;
            TRANSFORM(RECCOUNT(loc_cItens)) + " citens=" + TRANSFORM(citens) + CRLF

        *-- 3) CarregarDoCursor do BO (conserto tpesos/univals/utilizas)
        loc_lOk = loc_oForm.this_oBusinessObject.CarregarDoCursor(loc_cItens)
        loc_cMsg = loc_cMsg + "  BO.CarregarDoCursor() = " + TRANSFORM(loc_lOk) + ;
            " tpesos=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTpesos) + ;
            " univals=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nUnivals) + ;
            " utilizas=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nUtilizas) + CRLF

        *-- 4) FormParaBO: percentuais da tela -> BO + item corrente
        loc_oForm.txt_4c_Contingente.Value    = 11.11
        loc_oForm.txt_4c_TaxaAdm.Value        = 22.22
        loc_oForm.txt_4c_BV.Value             = 33.33
        loc_oForm.txt_4c_Imposto.Value        = 44.44
        loc_oForm.txt_4c_ImpostoServico.Value = 55.55

        loc_lOk = loc_oForm.TestFormParaBO()
        loc_cMsg = loc_cMsg + "--- FormParaBO ---" + CRLF
        loc_cMsg = loc_cMsg + "  retorno=" + TRANSFORM(loc_lOk) + CRLF
        loc_cMsg = loc_cMsg + "  BO ptax2s=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPTax2s) + ;
            " descs=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nDescs) + ;
            " ptax1s=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPTax1s) + ;
            " acres=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nAcres) + ;
            " ptax3s=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPTax3s) + CRLF
        loc_cMsg = loc_cMsg + "  BO item citens=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nCitens) + ;
            " dpros=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cDpros) + "]" + ;
            " emps=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cEmps) + "]" + ;
            " dopes=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cDopes) + "]" + ;
            " numes=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nNumes) + CRLF

        *-- 5) BOParaForm: volta do BO para a tela (zera os campos antes, para
        *--    provar que foi ele quem preencheu)
        loc_oForm.txt_4c_Contingente.Value    = 0
        loc_oForm.txt_4c_TaxaAdm.Value        = 0
        loc_oForm.txt_4c_BV.Value             = 0
        loc_oForm.txt_4c_Imposto.Value        = 0
        loc_oForm.txt_4c_ImpostoServico.Value = 0

        loc_lOk = loc_oForm.TestBOParaForm()
        loc_cMsg = loc_cMsg + "--- BOParaForm ---" + CRLF
        loc_cMsg = loc_cMsg + "  retorno=" + TRANSFORM(loc_lOk) + ;
            " contingente=" + TRANSFORM(loc_oForm.txt_4c_Contingente.Value) + ;
            " taxaadm=" + TRANSFORM(loc_oForm.txt_4c_TaxaAdm.Value) + ;
            " bv=" + TRANSFORM(loc_oForm.txt_4c_BV.Value) + ;
            " imposto=" + TRANSFORM(loc_oForm.txt_4c_Imposto.Value) + ;
            " impservico=" + TRANSFORM(loc_oForm.txt_4c_ImpostoServico.Value) + CRLF

        *-- 6) HabilitarCampos nos dois sentidos + o forcado por parametro
        loc_oForm.HabilitarCampos(.F.)
        loc_cMsg = loc_cMsg + "--- HabilitarCampos(.F.) ---" + CRLF
        loc_cMsg = loc_cMsg + "  contingente.Ena=" + TRANSFORM(loc_oForm.txt_4c_Contingente.Enabled) + ;
            " margem.Ena=" + TRANSFORM(loc_oForm.txt_4c_Margem.Enabled) + ;
            " novogrupo.Ena=" + TRANSFORM(loc_oForm.txt_4c_NovoGrupo.Enabled) + CRLF

        loc_oForm.HabilitarCampos()
        loc_cMsg = loc_cMsg + "--- HabilitarCampos() (modo " + loc_oForm.this_cOpEscolha + ") ---" + CRLF
        loc_cMsg = loc_cMsg + "  contingente.Ena=" + TRANSFORM(loc_oForm.txt_4c_Contingente.Enabled) + ;
            " margem.Ena=" + TRANSFORM(loc_oForm.txt_4c_Margem.Enabled) + ;
            " procuradpros.Ena=" + TRANSFORM(loc_oForm.txt_4c_ProcuraDpros.Enabled) + ;
            " (lProcura=" + TRANSFORM(loc_oForm.this_lProcura) + ")" + CRLF

        *-- 7) AjustarBotoesPorModo
        loc_oForm.AjustarBotoesPorModo()
        loc_cMsg = loc_cMsg + "--- AjustarBotoesPorModo (modo " + loc_oForm.this_cOpEscolha + ") ---" + CRLF
        loc_cMsg = loc_cMsg + "  incluirlinha.Ena=" + TRANSFORM(loc_oForm.cmd_4c_IncluirLinha.Enabled) + ;
            " insblo.Ena=" + TRANSFORM(loc_oForm.cmd_4c_InsBlo.Enabled) + ;
            " totitens.Ena=" + TRANSFORM(loc_oForm.cmd_4c_TotItens.Enabled) + ;
            " OK.Ena=" + TRANSFORM(loc_oForm.obj_4c_OK.Enabled) + ;
            " procurar.Ena=" + TRANSFORM(loc_oForm.cmd_4c_Procurar.Enabled) + CRLF

        *-- 8) CarregarLista: em modo teste nao le o banco, mas tem de
        *--    revincular, preservar a linha corrente e repintar
        loc_nAntes = RECCOUNT(loc_cItens)
        loc_lOk    = loc_oForm.CarregarLista()
        SELECT (loc_cItens)
        loc_cMsg = loc_cMsg + "--- CarregarLista ---" + CRLF
        loc_cMsg = loc_cMsg + "  retorno=" + TRANSFORM(loc_lOk) + ;
            " RECCOUNT antes=" + TRANSFORM(loc_nAntes) + " depois=" + TRANSFORM(RECCOUNT(loc_cItens)) + ;
            " citens corrente=" + TRANSFORM(citens) + CRLF
        loc_cMsg = loc_cMsg + "  grd itens RecordSource=[" + loc_oForm.grd_4c_Itens.RecordSource + "]" + ;
            " Col1.Width=" + TRANSFORM(loc_oForm.grd_4c_Itens.Column1.Width) + ;
            " Col1.Header=[" + ALLTRIM(loc_oForm.grd_4c_Itens.Column1.Header1.Caption) + "]" + CRLF
        loc_cMsg = loc_cMsg + "  grd parcelas RecordSource=[" + loc_oForm.grd_4c_Parcelas.RecordSource + "]" + ;
            " Col1.Header=[" + ALLTRIM(loc_oForm.grd_4c_Parcelas.Column1.Header1.Caption) + "]" + CRLF

        *-- 9) LimparCampos: estado auxiliar volta ao inicio, percentuais NAO
        loc_oForm.this_lProcura           = .T.
        loc_oForm.txt_4c_ProcuraDpros.Value = "XYZ"
        loc_oForm.this_cAntDpros          = "SUJO"
        loc_oForm.TestLimparCampos()
        loc_cMsg = loc_cMsg + "--- LimparCampos ---" + CRLF
        loc_cMsg = loc_cMsg + "  lProcura=" + TRANSFORM(loc_oForm.this_lProcura) + ;
            " procuradpros=[" + ALLTRIM(loc_oForm.txt_4c_ProcuraDpros.Value) + "]" + ;
            " antdpros=[" + ALLTRIM(loc_oForm.this_cAntDpros) + "]" + ;
            " img.Visible=" + TRANSFORM(loc_oForm.img_4c_Produto.Visible) + CRLF
        loc_cMsg = loc_cMsg + "  percentuais preservados: contingente=" + ;
            TRANSFORM(loc_oForm.txt_4c_Contingente.Value) + ;
            " taxaadm=" + TRANSFORM(loc_oForm.txt_4c_TaxaAdm.Value) + CRLF

        *-- 10) BtnCancelarClick: fecha sem persistir e descarta os cursores
        loc_oForm.BtnCancelarClick()
        loc_cMsg = loc_cMsg + "--- BtnCancelarClick ---" + CRLF
        loc_cMsg = loc_cMsg + "  USED(itens)=" + TRANSFORM(USED("cursor_4c_Itens")) + ;
            " USED(parcelas)=" + TRANSFORM(USED("cursor_4c_Parcelas")) + ;
            " (esperado .F. nos dois)" + CRLF
        loc_cMsg = loc_cMsg + "  form liberado: VARTYPE=" + VARTYPE(loc_oForm) + CRLF
    ENDIF
CATCH TO loc_oErro
    loc_cMsg = loc_cMsg + "EXCECAO: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CRLF
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cMsg = loc_cMsg + "--- dialogos suprimidos (MsgErro/MsgAviso) ---" + CRLF + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CRLF
ELSE
    loc_cMsg = loc_cMsg + "dialogos suprimidos: NENHUM" + CRLF
ENDIF

STRTOFILE(loc_cMsg, OUTFILE, 1)
STRTOFILE("[5] fim" + CRLF, OUTFILE, 1)
QUIT

*==========================================================================
* ProbeFormsigoporc - subclasse SO DE TESTE. Existe para alcancar os hooks
* PROTECTED da FormBase (FormParaBO/BOParaForm/LimparCampos) que o
* Formsigoporc sobrescreve: PROTECTED em qualquer classe da cadeia
* prevalece (regra #51), entao chamar de fora estoura "Property ... is not
* found" - mas uma SUBCLASSE alcanca o membro protegido da mae. Nenhum
* codigo de producao e alterado para testar.
*==========================================================================
DEFINE CLASS ProbeFormsigoporc AS Formsigoporc

	FUNCTION TestFormParaBO()
		RETURN THIS.FormParaBO()
	ENDFUNC

	FUNCTION TestBOParaForm()
		RETURN THIS.BOParaForm()
	ENDFUNC

	PROCEDURE TestLimparCampos()
		THIS.LimparCampos()
	ENDPROC

ENDDEFINE
