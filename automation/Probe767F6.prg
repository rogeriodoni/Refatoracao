SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

lcLog = "C:\4c\automation\Probe767F6.log"
STRTOFILE("", lcLog)
#DEFINE L CHR(13) + CHR(10)

*-- compila primeiro, com o .fxp apagado (senao o probe roda codigo velho)
lcCls = "C:\4c\projeto\app\classes\TextBoxGridLookup.prg"
lcPrg = "C:\4c\projeto\app\forms\operacionais\FormSigOpMop.prg"
lcErr = "C:\4c\projeto\app\forms\operacionais\FormSigOpMop.err"
lcFxp = "C:\4c\projeto\app\forms\operacionais\FormSigOpMop.fxp"
lcFxc = "C:\4c\projeto\app\classes\TextBoxGridLookup.fxp"
IF FILE(lcFxp)
    ERASE (lcFxp)
ENDIF
IF FILE(lcFxc)
    ERASE (lcFxc)
ENDIF
IF FILE(lcErr)
    ERASE (lcErr)
ENDIF
COMPILE (lcCls)
COMPILE (lcPrg)
STRTOFILE("COMPILE: FXP=" + IIF(FILE(lcFxp), "SIM", "NAO") + ;
    "  FXP_CLS=" + IIF(FILE(lcFxc), "SIM", "NAO") + ;
    "  ERR=" + IIF(FILE(lcErr), "SIM", "NAO") + L, lcLog, 1)
IF FILE(lcErr)
    STRTOFILE(FILETOSTR(lcErr) + L, lcLog, 1)
ENDIF

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_CaminhoReports
PUBLIC gc_4c_ArquivoErroTeste, gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_CaminhoBase

gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoBase      = "C:\4c\projeto\app\start"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\Probe767F6_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"
STRTOFILE("", gc_4c_ArquivoErroTeste)
go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")

SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"  ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\validators.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\gridbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbuscaauxiliar.prg" ADDITIVE
SET PROCEDURE TO (lcCls) ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpMopBO.prg"   ADDITIVE
SET PROCEDURE TO (lcPrg) ADDITIVE

*-- form PAI simulado: o Init faz ParentForm.Enabled = .F.
loPai = CREATEOBJECT("Form")

STRTOFILE(L + "=== instanciacao ===" + L, lcLog, 1)
loF = CREATEOBJECT("FormSigOpMop", loPai, 1, "INSERIR", "VENDA")

IF VARTYPE(loF) != "O"
    STRTOFILE("FALHOU: CREATEOBJECT devolveu " + VARTYPE(loF) + L, lcLog, 1)
    STRTOFILE("dialogos: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]" + L, lcLog, 1)
    QUIT
ENDIF

STRTOFILE("OK - form instanciado. Caption=[" + loF.Caption + "]" + L, lcLog, 1)

*-- celulas customizadas das 4 colunas editaveis
STRTOFILE(L + "=== CurrentControl / Sparse / MaxLength por coluna ===" + L, lcLog, 1)
loG = loF.grd_4c_Dados
FOR lnI = 1 TO 7
    lcCC = EVALUATE("loG.Column" + TRANSFORM(lnI) + ".CurrentControl")
    llSp = EVALUATE("loG.Column" + TRANSFORM(lnI) + ".Sparse")
    llRO = EVALUATE("loG.Column" + TRANSFORM(lnI) + ".ReadOnly")
    lcML = "-"
    IF PEMSTATUS(EVALUATE("loG.Column" + TRANSFORM(lnI)), lcCC, 5)
        loCtl = EVALUATE("loG.Column" + TRANSFORM(lnI) + "." + lcCC)
        IF PEMSTATUS(loCtl, "MaxLength", 5)
            lcML = TRANSFORM(loCtl.MaxLength)
        ENDIF
        lcCls2 = loCtl.Class
    ELSE
        lcCls2 = "<AUSENTE>"
    ENDIF
    STRTOFILE("Column" + TRANSFORM(lnI) + ": CC=[" + lcCC + "] classe=[" + lcCls2 + ;
        "] Sparse=" + TRANSFORM(llSp) + " ReadOnly=" + TRANSFORM(llRO) + ;
        " MaxLength=" + lcML + L, lcLog, 1)
ENDFOR

*-- os delegates que as classes de celula procuram por PEMSTATUS
STRTOFILE(L + "=== delegates esperados pelas celulas ===" + L, lcLog, 1)
lcLista = "CelulaMovimentacaoMopEditavel,ValidarMovimentacaoMopExec," + ;
          "MovimentacaoMopLostFocusExec,CelulaCoresMopEditavel,ValidarCoresMopExec," + ;
          "GrandeGrupoMopGotFocusExec,ValidarGrandeGrupoMopExec," + ;
          "GrandeGrupoMopLostFocusExec,ValidarEmpresaMopExec,ObterOperacaoInativa," + ;
          "ValidarMovimentacaoMopCorpo,ValidarGrandeGrupoMopCorpo,ValidarEmpresaMopCorpo"
FOR lnI = 1 TO ALINES(laM, STRTRAN(lcLista, ",", CHR(13)))
    lcM = ALLTRIM(laM[lnI])
    STRTOFILE(PADR(lcM, 34) + " existe=" + TRANSFORM(PEMSTATUS(loF, lcM, 5)) + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loF, lcM, 2)) + L, lcLog, 1)
ENDFOR

*-- lookups SEM conexao: tem de aceitar o valor digitado e NAO abrir picker
*-- (Show() de form modal TRAVARIA este probe - se ele termina, nao abriu)
STRTOFILE(L + "=== lookups sem conexao (gnConnHandle = -1) ===" + L, lcLog, 1)
loTxt = CREATEOBJECT("TextBoxMovimentacaoMop_4c")
loTxt.Value = "VENDA BALCAO"
llR = loF.ValidarMovimentacaoMopExec(loTxt)
STRTOFILE("Movimentacao: retorno=" + TRANSFORM(llR) + "  Value=[" + ;
    ALLTRIM(loTxt.Value) + "]  EmLookup=" + TRANSFORM(loF.this_lEmLookup) + L, lcLog, 1)

loTxt2 = CREATEOBJECT("TextBoxGrandeGrupoMop_4c")
loTxt2.Value = "01"
loF.GrandeGrupoMopGotFocusExec(loTxt2)
llR = loF.ValidarGrandeGrupoMopExec(loTxt2)
STRTOFILE("G.Grp: retorno=" + TRANSFORM(llR) + "  Value=[" + ALLTRIM(loTxt2.Value) + ;
    "]  Tag=[" + ALLTRIM(loTxt2.Tag) + "]  EmLookup=" + TRANSFORM(loF.this_lEmLookup) + L, lcLog, 1)

*-- detector de alteracao: Tag igual nao suja, Tag diferente suja
loF.this_lHouveInsercao = .F.
loF.GrandeGrupoMopLostFocusExec(loTxt2)
STRTOFILE("LostFocus com Tag IGUAL  -> HouveInsercao=" + ;
    TRANSFORM(loF.this_lHouveInsercao) + "  (esp .F.)" + L, lcLog, 1)
loTxt2.Value = "02"
loF.GrandeGrupoMopLostFocusExec(loTxt2)
STRTOFILE("LostFocus com Tag DIFERE -> HouveInsercao=" + ;
    TRANSFORM(loF.this_lHouveInsercao) + "  (esp .T.)" + L, lcLog, 1)

loTxt3 = CREATEOBJECT("TextBoxEmpresaMop_4c")
loTxt3.Value = "001"
llR = loF.ValidarEmpresaMopExec(loTxt3)
STRTOFILE("Emp.: retorno=" + TRANSFORM(llR) + "  Value=[" + ALLTRIM(loTxt3.Value) + ;
    "]  EmLookup=" + TRANSFORM(loF.this_lEmLookup) + L, lcLog, 1)

*-- guarda de reentrancia: com a flag ligada, o wrapper devolve .T. sem entrar
STRTOFILE(L + "=== guarda de reentrancia ===" + L, lcLog, 1)
loF.this_lEmLookup = .T.
loTxt.Value = "XXX"
llR = loF.ValidarMovimentacaoMopExec(loTxt)
STRTOFILE("reentrante: retorno=" + TRANSFORM(llR) + "  Value intacto=[" + ;
    ALLTRIM(loTxt.Value) + "]  flag ainda=" + TRANSFORM(loF.this_lEmLookup) + L, lcLog, 1)
loF.this_lEmLookup = .F.

*-- ObterOperacaoInativa sobre o cursor de configuracao vazio do harness
STRTOFILE(L + "=== ObterOperacaoInativa ===" + L, lcLog, 1)
lcCfg = loF.this_oBusinessObject.this_cCursorConfig
STRTOFILE("cursor config [" + lcCfg + "] USED=" + TRANSFORM(USED(lcCfg)) + ;
    "  RECCOUNT=" + TRANSFORM(IIF(USED(lcCfg), RECCOUNT(lcCfg), -1)) + L, lcLog, 1)
STRTOFILE("inativa('VENDA')=" + TRANSFORM(loF.ObterOperacaoInativa("VENDA")) + ;
    "  inativa('')=" + TRANSFORM(loF.ObterOperacaoInativa("")) + " (esp 0 / 0)" + L, lcLog, 1)

*-- area de trabalho preservada pelos lookups e pelo helper
STRTOFILE(L + "alias corrente ao fim: [" + ALIAS() + "]  (esp o cursor da grade)" + L, lcLog, 1)

*-- MontaGrade de novo: as 4 celulas tem de voltar (idempotencia)
STRTOFILE(L + "=== MontaGrade() novamente (idempotencia) ===" + L, lcLog, 1)
llR = loF.MontaGrade()
STRTOFILE("MontaGrade=" + TRANSFORM(llR) + ;
    "  C1=[" + loG.Column1.CurrentControl + "]" + ;
    "  C3=[" + loG.Column3.CurrentControl + "]" + ;
    "  C4=[" + loG.Column4.CurrentControl + "]" + ;
    "  C6=[" + loG.Column6.CurrentControl + "]" + ;
    "  C7=[" + loG.Column7.CurrentControl + "]" + L, lcLog, 1)
STRTOFILE("larguras: " + TRANSFORM(loG.Column1.Width) + "/" + TRANSFORM(loG.Column2.Width) + ;
    "/" + TRANSFORM(loG.Column3.Width) + "/" + TRANSFORM(loG.Column4.Width) + ;
    "/" + TRANSFORM(loG.Column5.Width) + "/" + TRANSFORM(loG.Column6.Width) + ;
    "/" + TRANSFORM(loG.Column7.Width) + "  (esp 150/38/80/50/45/42/40)" + L, lcLog, 1)
STRTOFILE("headers: [" + loG.Column6.Header1.Caption + "] [" + ;
    loG.Column7.Header1.Caption + "]" + L, lcLog, 1)

loF.Release()
loPai = .NULL.

STRTOFILE(L + "dialogos capturados: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]" + L, lcLog, 1)
STRTOFILE("FIM" + L, lcLog, 1)
QUIT
