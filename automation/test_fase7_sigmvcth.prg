*==============================================================================
* test_fase7_sigmvcth.prg - Harness da Fase 7 do FormSIGMVCTH
*
* Fase 7 = "eventos principais dos botoes". O SIGMVCTH legado tem UM UNICO
* botao (cmdSalva.btnSair, "Retornar", Click = ThisForm.Release) - este
* harness prova que esse botao existe, que o BINDEVENT esta REGISTRADO e que
* o Click chega ao handler PELO EVENTO (nao so por chamada direta).
*
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL e trava em
* execucao desatendida).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lnI, laEv[1], lnEv, llAchouBind
lcLog = "C:\4c\tasks\task566\teste_fase7.txt"
lcCls = "C:\4c\projeto\app\classes\"
lcUtl = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 7 FormSIGMVCTH (eventos dos botoes) ===" + CHR(13) + CHR(10), lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_UsuarioLogado
gb_4c_ModoTeste      = .T.
gb_4c_ValidandoUI    = .F.
gnConnHandle         = -1
gc_4c_CaminhoIcones  = "C:\4c\vbmp\"
gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado  = "TESTE"

*-- Rede de seguranca: erro nao tratado vai para o LOG, nunca para um dialogo
*-- modal (o pipeline roda desatendido - CLAUDE.md regra #6)
ON ERROR STRTOFILE("ERRO NAO TRATADO   : " + MESSAGE() + " | Linha " + TRANSFORM(LINENO()) + CHR(13) + CHR(10), lcLog, 1)

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

*-- 1) Compilacao (apaga o .fxp antes: COMPILE pode NAO reescrever um .fxp
*--    existente e o teste rodaria codigo velho - CLAUDE.md regra #29)
IF FILE(lcCls + "sigmvcthbo.fxp")
    DELETE FILE (lcCls + "sigmvcthbo.fxp")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigmvcth.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigmvcth.fxp"
ENDIF

TRY
    COMPILE (lcCls + "SIGMVCTHBO.prg")
    COMPILE "C:\4c\projeto\app\forms\operacionais\FormSIGMVCTH.prg"
    STRTOFILE("COMPILE            : OK" + CHR(13) + CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("COMPILE            : FALHA - " + loErr.Message + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

STRTOFILE("FXP form regravado : " + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\formsigmvcth.fxp")) + CHR(13) + CHR(10), lcLog, 1)

*-- 2) Dependencias
TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "SIGMVCTHBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGMVCTH.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE      : OK" + CHR(13) + CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE      : FALHA - " + loErr.Message + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

*-- 3) Instanciacao real
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGMVCTH", "PROP0001", 0)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT       : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("CREATEOBJECT       : FALHOU - VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), lcLog, 1)
    QUIT
ENDIF

STRTOFILE("CREATEOBJECT       : OK" + CHR(13) + CHR(10), lcLog, 1)

*-- 4) O botao do legado existe e esta configurado
STRTOFILE("cmg_4c_Botoes      : " + TRANSFORM(PEMSTATUS(loForm, "cmg_4c_Botoes", 5)) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("ButtonCount        : " + TRANSFORM(loForm.cmg_4c_Botoes.ButtonCount) + " (legado: 1)" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("Buttons(1).Name    : [" + ALLTRIM(loForm.cmg_4c_Botoes.Buttons(1).Name) + "]" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("Buttons(1).Caption : [" + ALLTRIM(loForm.cmg_4c_Botoes.Buttons(1).Caption) + "] (legado: Retornar)" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("Buttons(1).Cancel  : " + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(1).Cancel) + " (ESC fecha - legado .T.)" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("Picture existe     : " + TRANSFORM(FILE(loForm.cmg_4c_Botoes.Buttons(1).Picture)) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("Botao Visible      : " + TRANSFORM(loForm.cmg_4c_Botoes.Visible) + CHR(13) + CHR(10), lcLog, 1)

*-- 5) O BINDEVENT do Click esta REGISTRADO?
*--    AEVENTS(Array, oOrigem) - DOIS argumentos (o 3o da "Too many arguments").
*--    Colunas MEDIDAS no VFP9 (automation\probe_aevents.prg, 2026-09-24):
*--      1 = Logico   2 = objeto DELEGATE   3 = nome do EVENTO de origem
*--      4 = nome do METODO delegate        5 = flags
*--    A coluna do evento eh a 3, NAO a 2 (a 2 eh objeto: ALLTRIM nela dispara
*--    "Function argument value, type, or count is invalid").
llAchouBind = .F.
lnEv = AEVENTS(laEv, loForm.cmg_4c_Botoes.Buttons(1))
STRTOFILE("AEVENTS(Buttons(1)): " + TRANSFORM(lnEv) + " binding(s)" + CHR(13) + CHR(10), lcLog, 1)
FOR lnI = 1 TO lnEv
    STRTOFILE("  bind " + TRANSFORM(lnI) + "        : evento [" + ALLTRIM(laEv[lnI, 3]) + ;
        "] -> metodo [" + ALLTRIM(laEv[lnI, 4]) + "]" + CHR(13) + CHR(10), lcLog, 1)
    IF UPPER(ALLTRIM(laEv[lnI, 3])) == "CLICK" AND UPPER(ALLTRIM(laEv[lnI, 4])) == "CMDRETORNARCLICK"
        llAchouBind = .T.
    ENDIF
ENDFOR
STRTOFILE("BINDEVENT Click    : " + IIF(llAchouBind, "OK (Click -> CmdRetornarClick)", "AUSENTE") + CHR(13) + CHR(10), lcLog, 1)

*-- 6) AfterRowColChange da grade (outro evento principal do legado)
llAchouBind = .F.
lnEv = AEVENTS(laEv, loForm.grd_4c_Dados)
STRTOFILE("AEVENTS(grade)     : " + TRANSFORM(lnEv) + " binding(s)" + CHR(13) + CHR(10), lcLog, 1)
FOR lnI = 1 TO lnEv
    STRTOFILE("  bind " + TRANSFORM(lnI) + "        : evento [" + ALLTRIM(laEv[lnI, 3]) + ;
        "] -> metodo [" + ALLTRIM(laEv[lnI, 4]) + "]" + CHR(13) + CHR(10), lcLog, 1)
    IF UPPER(ALLTRIM(laEv[lnI, 3])) == "AFTERROWCOLCHANGE"
        llAchouBind = .T.
    ENDIF
ENDFOR
STRTOFILE("BINDEVENT Grid     : " + IIF(llAchouBind, "OK (AfterRowColChange ligado)", "AUSENTE") + CHR(13) + CHR(10), lcLog, 1)

*-- 7) O handler eh alcancavel de FORA da classe (harness do pipeline chama
*--    assim - CLAUDE.md regra #3: PEMSTATUS nao prova escopo)
STRTOFILE("CmdRetornarClick   : PEMSTATUS=" + TRANSFORM(PEMSTATUS(loForm, "CmdRetornarClick", 5)) + CHR(13) + CHR(10), lcLog, 1)

*-- 8) O Click chega ao handler PELO EVENTO. Disparar Buttons(1).Click()
*--    dispara o BINDEVENT -> CmdRetornarClick -> THIS.Release(). Se o form
*--    for destruido, o evento percorreu a cadeia inteira.
TRY
    loForm.cmg_4c_Botoes.Buttons(1).Click()
    STRTOFILE("Click() via evento : disparado sem excecao" + CHR(13) + CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("Click() via evento : EXCECAO - " + loErr.Message + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

STRTOFILE("Form apos o Click  : " + IIF(VARTYPE(loForm) = "O" AND TYPE("loForm.Name") = "C", ;
    "AINDA VIVO (Release NAO ocorreu)", "LIBERADO (Release ocorreu - evento chegou ao handler)") + CHR(13) + CHR(10), lcLog, 1)

STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), lcLog, 1)
QUIT
