*==============================================================================
* _probeForm783.prg - Probe de instanciacao do FormSigOpPck (Fase 8/task783)
* Descartavel. Nao chama ConfigurarAmbiente() (bloqueia nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE LOGF "C:\4c\automation\_probeForm783.txt"

STRTOFILE("PROBE v1 INICIO " + TTOC(DATETIME()) + CHR(13) + CHR(10), LOGF)

LOCAL loc_oForm, loc_oErro, loc_nI, loc_cOrdem, loc_cEsperado

DO config.prg
=STRTOFILE("CK01 config.prg OK" + CHR(13) + CHR(10), LOGF, 1)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + gc_4c_CaminhoUtils + ;
             "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpPckBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpPck.prg") ADDITIVE
=STRTOFILE("CK02 SET PROCEDURE OK" + CHR(13) + CHR(10), LOGF, 1)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle = 0
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probeForm783_erros.txt"
gc_4c_UsuarioLogado = "PROBE783"
=STRTOFILE("CK03 globais OK (ValidandoUI=" + TRANSFORM(gb_4c_ValidandoUI) + ")" + CHR(13) + CHR(10), LOGF, 1)

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("ProbeFormSigOpPck")
    =STRTOFILE("CK04 CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), LOGF, 1)
CATCH TO loc_oErro
    =STRTOFILE("CK04 CREATEOBJECT FALHOU: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), LOGF, 1)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    =STRTOFILE("CK05 Caption=[" + loc_oForm.Caption + "] BaseClass=[" + loc_oForm.BaseClass + "]" + ;
        " Width=" + TRANSFORM(loc_oForm.Width) + " Height=" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10), LOGF, 1)

    *-- Datas prepreenchidas por BOParaForm (legado: getDcI/getDcF = Date())
    =STRTOFILE("CK06 DcI=[" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.txt_4c_DcI.Value) + "] DcF=[" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.txt_4c_DcF.Value) + "] (hoje=" + DTOC(DATE()) + ")" + ;
        CHR(13) + CHR(10), LOGF, 1)

    *-- Escopo dos metodos novos
    =STRTOFILE("CK07 escopo:" + ;
        " CarregarDados ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 5)) + ;
        " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 2)) + ;
        " | CarregarGradeResultado ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarGradeResultado", 5)) + ;
        " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarGradeResultado", 2)) + ;
        " | AcertaColunas ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "AcertaColunas", 5)) + ;
        " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "AcertaColunas", 2)) + ;
        " | GradePadrao ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "GradePadrao", 5)) + ;
        " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "GradePadrao", 2)) + ;
        " | ColunaDados01Resize ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "ColunaDados01Resize", 5)) + ;
        " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "ColunaDados01Resize", 2)) + ;
        " | GrdDadosProdutoDblClick ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "GrdDadosProdutoDblClick", 5)) + ;
        " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "GrdDadosProdutoDblClick", 2)) + ;
        CHR(13) + CHR(10), LOGF, 1)

    *-- ColumnOrder efetivo x esperado (SCX)
    loc_cOrdem = ""
    FOR loc_nI = 1 TO 16
        loc_cOrdem = loc_cOrdem + TRANSFORM(EVALUATE("loc_oForm.pgf_4c_Paginas.Page2." + ;
            "pgf_4c_Resultados.Page1.grd_4c_Dados.Column" + ALLTRIM(STR(loc_nI)) + ".ColumnOrder")) + ","
    ENDFOR
    loc_cEsperado = "1,9,2,3,11,4,6,7,8,12,13,14,15,10,5,16,"
    =STRTOFILE("CK08 ColumnOrder=[" + loc_cOrdem + "] esperado=[" + loc_cEsperado + "] IGUAL=" + ;
        TRANSFORM(loc_cOrdem == loc_cEsperado) + CHR(13) + CHR(10), LOGF, 1)

    *-- Larguras antes/depois de GradePadrao
    TRY
        loc_cOrdem = ""
        FOR loc_nI = 1 TO 16
            loc_cOrdem = loc_cOrdem + TRANSFORM(EVALUATE("loc_oForm.pgf_4c_Paginas.Page2." + ;
                "pgf_4c_Resultados.Page1.grd_4c_Dados.Column" + ALLTRIM(STR(loc_nI)) + ".Width")) + ","
        ENDFOR
        =STRTOFILE("CK09 Width inicial=[" + loc_cOrdem + "]" + CHR(13) + CHR(10), LOGF, 1)

        loc_oForm.GradePadrao()
        loc_cOrdem = ""
        FOR loc_nI = 1 TO 16
            loc_cOrdem = loc_cOrdem + TRANSFORM(EVALUATE("loc_oForm.pgf_4c_Paginas.Page2." + ;
                "pgf_4c_Resultados.Page1.grd_4c_Dados.Column" + ALLTRIM(STR(loc_nI)) + ".Width")) + ","
        ENDFOR
        =STRTOFILE("CK10 Width pos-GradePadrao=[" + loc_cOrdem + "] esperado=" + ;
            "[31,150,55,71,150,80,110,296,35,35,100,100,290,150,100,25,]" + CHR(13) + CHR(10), LOGF, 1)
    CATCH TO loc_oErro
        =STRTOFILE("CK09/10 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), LOGF, 1)
    ENDTRY

    *-- AcertaColunas GRAVAR -> string posicional; depois LER de volta
    TRY
        loc_oForm.AcertaColunas("GRAVAR")
        =STRTOFILE("CK11 CfgGrade=[" + loc_oForm.pgf_4c_Paginas.Page1.txt_4c_CfgGrade.Value + "] len=" + ;
            TRANSFORM(LEN(loc_oForm.pgf_4c_Paginas.Page1.txt_4c_CfgGrade.Value)) + " (esperado 80)" + ;
            CHR(13) + CHR(10), LOGF, 1)
    CATCH TO loc_oErro
        =STRTOFILE("CK11 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), LOGF, 1)
    ENDTRY

    TRY
        loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.Column3.Width = 777
        loc_oForm.AcertaColunas("LER")
        =STRTOFILE("CK12 pos-LER Column3.Width=" + ;
            TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.Column3.Width) + ;
            " (esperado 55 - restaurado da string)" + CHR(13) + CHR(10), LOGF, 1)
    CATCH TO loc_oErro
        =STRTOFILE("CK12 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), LOGF, 1)
    ENDTRY

    *-- Hooks PROTECTED, via subclasse de probe
    TRY
        =STRTOFILE("CK13 ProbeFormParaBO=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + CHR(13) + CHR(10), LOGF, 1)
    CATCH TO loc_oErro
        =STRTOFILE("CK13 FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), LOGF, 1)
    ENDTRY

    TRY
        =STRTOFILE("CK14 ProbeBOParaForm=" + TRANSFORM(loc_oForm.ProbeBOParaForm()) + CHR(13) + CHR(10), LOGF, 1)
    CATCH TO loc_oErro
        =STRTOFILE("CK14 FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), LOGF, 1)
    ENDTRY

    *-- Navegacao: AlternarPagina(2) repinta a grade; AlternarPagina(1) volta
    TRY
        loc_oForm.AlternarPagina(2)
        =STRTOFILE("CK15 ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " modo=[" + loc_oForm.this_cModoAtual + "]" + CHR(13) + CHR(10), LOGF, 1)
        loc_oForm.AlternarPagina(1)
        =STRTOFILE("CK16 ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " modo=[" + loc_oForm.this_cModoAtual + "]" + CHR(13) + CHR(10), LOGF, 1)
    CATCH TO loc_oErro
        =STRTOFILE("CK15/16 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), LOGF, 1)
    ENDTRY

    *-- Ocultar coluna: com Width != 0 nao abre dialogo nenhum (no-op)
    TRY
        loc_oForm.ColunaDados01Resize()
        =STRTOFILE("CK17 ColunaDados01Resize (Width<>0, no-op) OK - Visible=" + ;
            TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.Column1.Visible) + ;
            CHR(13) + CHR(10), LOGF, 1)
    CATCH TO loc_oErro
        =STRTOFILE("CK17 FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), LOGF, 1)
    ENDTRY

    *-- BINDEVENTs novos registrados?
    TRY
        LOCAL ARRAY laEv[1, 5]
        LOCAL loc_nB
        loc_nB = AEVENTS(laEv, loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.Column1)
        =STRTOFILE("CK18 AEVENTS Column1=" + TRANSFORM(loc_nB) + ;
            IIF(loc_nB > 0, " evt=" + TRANSFORM(laEv[1,3]) + " met=" + TRANSFORM(laEv[1,4]), "") + ;
            CHR(13) + CHR(10), LOGF, 1)
        loc_nB = AEVENTS(laEv, loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados.Column7.Text1)
        =STRTOFILE("CK19 AEVENTS Column7.Text1=" + TRANSFORM(loc_nB) + ;
            IIF(loc_nB > 0, " evt=" + TRANSFORM(laEv[1,3]) + " met=" + TRANSFORM(laEv[1,4]), "") + ;
            CHR(13) + CHR(10), LOGF, 1)
    CATCH TO loc_oErro
        =STRTOFILE("CK18/19 FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), LOGF, 1)
    ENDTRY

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

=STRTOFILE("PROBE FIM" + CHR(13) + CHR(10), LOGF, 1)
QUIT

*------------------------------------------------------------------------------
* Subclasse de probe: alcanca os hooks PROTECTED de FormBase/FormSigOpPck
*------------------------------------------------------------------------------
DEFINE CLASS ProbeFormSigOpPck AS FormSigOpPck

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

ENDDEFINE
