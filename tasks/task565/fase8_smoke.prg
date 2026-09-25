*-- Smoke test da Fase 8: prova o par FormParaBO / BOParaForm no objeto REAL
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

PUBLIC gb_4c_ValidandoUI, gb_4c_ModoTeste
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.

LOCAL lcOut, loForm, loBO, loPag, loAdic, loApr, loSol, lcLog, loErro
lcOut = "C:\4c\tasks\task565\fase8_smoke.txt"
lcLog = ""

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.

TRY
    loForm = CREATEOBJECT("SmokeFormsigmvcot")

    IF VARTYPE(loForm) != "O"
        lcLog = lcLog + "FALHOU: CREATEOBJECT nao devolveu objeto" + CHR(13)
    ELSE
        lcLog = lcLog + "OK: form instanciado" + CHR(13)

        loBO  = loForm.this_oBusinessObject
        loPag = loForm.pgf_4c_Paginas.Page3

        *-- 1) BO -> Form
        loBO.this_nCodigos    = 4321
        loBO.this_cSolicitas  = "USR01"
        loBO.this_cDeptos     = "DPT09"
        loBO.this_cComprador  = "CPR07"
        loBO.this_dDtCotas    = DATE()
        loBO.this_dDtValids   = DATE() + 15
        loBO.this_dDtPagtos   = DATE() + 30
        loBO.this_nPrioris    = 3
        loBO.this_cContaEs    = "CLI0001"
        loBO.this_cJustificas = "Justificativa de teste"
        loBO.this_cAprovador  = "APR02"
        loBO.this_dDtAprovs   = DATE() - 1
        loBO.this_nChkAprovs  = 1

        IF loForm.PubBOParaForm()
            lcLog = lcLog + "OK: BOParaForm devolveu .T." + CHR(13)
        ELSE
            lcLog = lcLog + "FALHOU: BOParaForm devolveu .F." + CHR(13)
        ENDIF

        loAdic = loPag.pgf_4c_ComplCots.Page1
        loApr  = loPag.pgf_4c_ComplCots.Page2
        loSol  = loPag.pgf_4c_ComplCots.Page3

        lcLog = lcLog + "  Codigos   : " + ALLTRIM(loPag.txt_4c_Codigos.Value) + CHR(13)
        lcLog = lcLog + "  Solicitas : " + ALLTRIM(loPag.txt_4c_Solicitas.Value) + CHR(13)
        lcLog = lcLog + "  Deptos    : " + ALLTRIM(loPag.txt_4c_Deptos.Value) + CHR(13)
        lcLog = lcLog + "  DtValids  : " + DTOC(loPag.txt_4c_DtValids.Value) + CHR(13)
        lcLog = lcLog + "  Prioris   : " + ALLTRIM(STR(loPag.cbo_4c_Prioris.ListIndex)) + CHR(13)
        lcLog = lcLog + "  ContaEs   : " + ALLTRIM(loAdic.txt_4c_ContaEs.Value) + CHR(13)
        lcLog = lcLog + "  JustGeral : " + ALLTRIM(loAdic.obj_4c_GetJustGeral.Value) + CHR(13)
        lcLog = lcLog + "  ChkAprov  : " + ALLTRIM(STR(loApr.chk_4c_ChkAprovador.Value)) + CHR(13)

        *-- 2) Form -> BO: simula o usuario digitando SEM sair do campo
        loPag.txt_4c_Deptos.Value      = "DPT99"
        loPag.txt_4c_DtValids.Value    = DATE() + 60
        loPag.cbo_4c_Prioris.ListIndex = 2
        loApr.txt_4c_Aprovador.Value   = "APR77"
        loApr.chk_4c_ChkAprovador.Value = 0
        loAdic.obj_4c_GetJustGeral.Value = "Alterada na tela"

        IF loForm.PubFormParaBO()
            lcLog = lcLog + "OK: FormParaBO devolveu .T." + CHR(13)
        ELSE
            lcLog = lcLog + "FALHOU: FormParaBO devolveu .F." + CHR(13)
        ENDIF

        lcLog = lcLog + "  BO.Deptos    : " + ALLTRIM(loBO.this_cDeptos) + " (esperado DPT99)" + CHR(13)
        lcLog = lcLog + "  BO.DtValids  : " + DTOC(loBO.this_dDtValids) + " (esperado " + DTOC(DATE() + 60) + ")" + CHR(13)
        lcLog = lcLog + "  BO.Prioris   : " + ALLTRIM(STR(loBO.this_nPrioris)) + " (esperado 2)" + CHR(13)
        lcLog = lcLog + "  BO.Aprovador : " + ALLTRIM(loBO.this_cAprovador) + " (esperado APR77)" + CHR(13)
        lcLog = lcLog + "  BO.Justificas: " + ALLTRIM(loBO.this_cJustificas) + CHR(13)
        lcLog = lcLog + "  BO.ChkAprovs : " + ALLTRIM(STR(loBO.this_nChkAprovs)) + " (esperado 1 - NAO recolhido de proposito)" + CHR(13)
        lcLog = lcLog + "  BO.Codigos   : " + ALLTRIM(STR(loBO.this_nCodigos)) + " (esperado 4321 - dono e o BO)" + CHR(13)

        *-- 3) BtnCancelarClick despacha pela pagina corrente (2 -> volta p/ 1)
        loForm.AlternarPagina(2)
        loForm.BtnCancelarClick()
        lcLog = lcLog + "OK: BtnCancelarClick (Page2) -> ActivePage = " + ;
            ALLTRIM(STR(loForm.pgf_4c_Paginas.ActivePage)) + " (esperado 1)" + CHR(13)

        loForm.Release()
        lcLog = lcLog + "OK: form liberado" + CHR(13)
    ENDIF
CATCH TO loErro
    lcLog = lcLog + "EXCECAO: " + loErro.Message + " | LN=" + TRANSFORM(loErro.LineNo) + ;
        " | PROC=" + loErro.Procedure + CHR(13)
ENDTRY

STRTOFILE(lcLog, lcOut)
QUIT

*-- Subclasse so para o teste: metodos PROTECTED (hooks de FormBase) so podem
*-- ser chamados de DENTRO da hierarquia da classe.
DEFINE CLASS SmokeFormsigmvcot AS Formsigmvcot
    PROCEDURE PubFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE PubBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC
ENDDEFINE
