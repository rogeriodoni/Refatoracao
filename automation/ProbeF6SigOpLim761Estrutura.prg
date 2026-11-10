SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON
SET EXACT ON

lcLog = "C:\4c\automation\ProbeF6SigOpLim761Estrutura.log"
STRTOFILE("", lcLog)

#DEFINE L CHR(13) + CHR(10)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_CaminhoReports
PUBLIC gc_4c_ArquivoErroTeste, gc_4c_UsuarioLogado, go_4c_Sistema
PUBLIC gc_4c_CaminhoBase

gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoBase      = "C:\4c\projeto\app\start"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\ProbeF6SigOpLim761Estrutura_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"
STRTOFILE("", gc_4c_ArquivoErroTeste)

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "EMPRESA TESTE")
ADDPROPERTY(go_4c_Sistema, "cCNPJ", "")

SET PATH TO ("C:\4c\projeto\app\utils,C:\4c\projeto\app\classes,C:\4c\projeto\app\forms,C:\4c\projeto\app\forms\operacionais")

SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"  ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\validators.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\gridbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbuscaauxiliar.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpLimBO.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpLim.prg" ADDITIVE

*==============================================================================
* CENARIO 1 - fluxo normal ("D", com Motivo): usuario + motivo + senha
*==============================================================================
STRTOFILE("=== CENARIO 1: Tipo D, Motivo=.T., valor 500,00 (10%) ===" + L, lcLog, 1)

loF = .NULL.
loF = CREATEOBJECT("FormSigOpLim", 3, 500.00, 10.00, "D", .NULL., .NULL., .T.)

STRTOFILE("VARTYPE(form) ........... " + VARTYPE(loF) + L, lcLog, 1)

IF VARTYPE(loF) <> "O"
    STRTOFILE("ABORTADO: form nao instanciou" + L, lcLog, 1)
    STRTOFILE("dialogs: " + FILETOSTR(gc_4c_ArquivoErroTeste) + L, lcLog, 1)
    QUIT
ENDIF

STRTOFILE("Caption ................. [" + loF.Caption + "]" + L, lcLog, 1)
STRTOFILE("lblSombra.Caption ....... [" + loF.cnt_4c_Sombra.lbl_4c_Sombra.Caption + "]" + L, lcLog, 1)
STRTOFILE("lblTitulo.Caption ....... [" + loF.cnt_4c_Sombra.lbl_4c_Titulo.Caption + "]" + L, lcLog, 1)
STRTOFILE("Frase.Caption ........... [" + loF.lbl_4c_Frase.Caption + "]" + L, lcLog, 1)
STRTOFILE("this_lSoMotivo .......... " + TRANSFORM(loF.this_lSoMotivo) + L, lcLog, 1)
STRTOFILE("this_cTipo .............. [" + loF.this_cTipo + "]" + L, lcLog, 1)
STRTOFILE("this_lMotivo ............ " + TRANSFORM(loF.this_lMotivo) + L, lcLog, 1)

STRTOFILE("--- campos PARTE 2 (Fase 6) ---" + L, lcLog, 1)
STRTOFILE("lbl_4c_Label3 existe .... " + TRANSFORM(PEMSTATUS(loF, "lbl_4c_Label3", 5)) + L, lcLog, 1)
STRTOFILE("txt_4c_Senha existe ..... " + TRANSFORM(PEMSTATUS(loF, "txt_4c_Senha", 5)) + L, lcLog, 1)
WITH loF.lbl_4c_Label3
    STRTOFILE("Label3  L/T/W/H ......... " + TRANSFORM(.Left) + "/" + TRANSFORM(.Top) + ;
        "/" + TRANSFORM(.Width) + "/" + TRANSFORM(.Height) + ;
        "  Caption=[" + .Caption + "]  AutoSize=" + TRANSFORM(.AutoSize) + ;
        "  Align=" + TRANSFORM(.Alignment) + "  Fore=" + TRANSFORM(.ForeColor) + L, lcLog, 1)
ENDWITH
WITH loF.txt_4c_Senha
    STRTOFILE("Senha   L/T/W/H ......... " + TRANSFORM(.Left) + "/" + TRANSFORM(.Top) + ;
        "/" + TRANSFORM(.Width) + "/" + TRANSFORM(.Height) + L, lcLog, 1)
    STRTOFILE("Senha   PasswordChar .... [" + .PasswordChar + "]  InputMask=[" + .InputMask + ;
        "]  MaxLength=" + TRANSFORM(.MaxLength) + "  Format=[" + .Format + "]" + L, lcLog, 1)
    STRTOFILE("Senha   Align/BackStyle . " + TRANSFORM(.Alignment) + "/" + TRANSFORM(.BackStyle) + ;
        "  Themes=" + TRANSFORM(.Themes) + "  Border=" + TRANSFORM(.BorderColor) + L, lcLog, 1)
ENDWITH

STRTOFILE("--- visibilidade (Tipo D + Motivo) ---" + L, lcLog, 1)
STRTOFILE("Frase/Lbl1/Motivo ....... " + TRANSFORM(loF.lbl_4c_Frase.Visible) + "/" + ;
    TRANSFORM(loF.lbl_4c_Label1.Visible) + "/" + TRANSFORM(loF.txt_4c__Motivo.Visible) + L, lcLog, 1)
STRTOFILE("Lbl2/Usuario ............ " + TRANSFORM(loF.lbl_4c_Label2.Visible) + "/" + ;
    TRANSFORM(loF.txt_4c_Usuario.Visible) + L, lcLog, 1)
STRTOFILE("Lbl3/Senha (esp .F./.F.)  " + TRANSFORM(loF.lbl_4c_Label3.Visible) + "/" + ;
    TRANSFORM(loF.txt_4c_Senha.Visible) + L, lcLog, 1)

STRTOFILE("--- gates (When do legado) ---" + L, lcLog, 1)
STRTOFILE("Motivo.Enabled (esp .T.)  " + TRANSFORM(loF.txt_4c__Motivo.Enabled) + L, lcLog, 1)
STRTOFILE("Senha.Enabled  (esp .F.)  " + TRANSFORM(loF.txt_4c_Senha.Enabled) + L, lcLog, 1)
loF.txt_4c_Usuario.Value = "OPERADOR"
loF.ValidarAcessoSenha()
STRTOFILE("Senha.Enabled c/ usuario  " + TRANSFORM(loF.txt_4c_Senha.Enabled) + "  (esp .T.)" + L, lcLog, 1)
loF.txt_4c_Usuario.Value = ""
loF.ValidarAcessoSenha()
STRTOFILE("Senha.Enabled s/ usuario  " + TRANSFORM(loF.txt_4c_Senha.Enabled) + "  (esp .F.)" + L, lcLog, 1)

STRTOFILE("--- TabIndex (SCX: Motivo=1 Usuario=2 Senha=3) ---" + L, lcLog, 1)
STRTOFILE("Motivo/Usuario/Senha .... " + TRANSFORM(loF.txt_4c__Motivo.TabIndex) + "/" + ;
    TRANSFORM(loF.txt_4c_Usuario.TabIndex) + "/" + TRANSFORM(loF.txt_4c_Senha.TabIndex) + L, lcLog, 1)

STRTOFILE("--- BINDEVENT (AEVENTS com o objeto de ORIGEM; col 3=evento 4=metodo) ---" + L, lcLog, 1)
LOCAL ARRAY laEv[1]
FOR lnK = 1 TO 3
    lcNome = ICASE(lnK = 1, "txt_4c__Motivo", lnK = 2, "txt_4c_Usuario", "txt_4c_Senha")
    loCtl  = EVALUATE("loF." + lcNome)
    lnQtd  = AEVENTS(laEv, loCtl)
    lcLin  = PADR(lcNome, 16) + "= " + TRANSFORM(lnQtd) + " : "
    FOR lnJ = 1 TO lnQtd
        lcLin = lcLin + "[" + laEv[lnJ, 3] + " -> " + laEv[lnJ, 4] + "] "
    ENDFOR
    STRTOFILE(lcLin + L, lcLog, 1)
ENDFOR

STRTOFILE("--- escopo PUBLIC dos delegados (regra #3: PEMSTATUS(.,2) deve ser .F.) ---" + L, lcLog, 1)
FOR lnK = 1 TO 10
    lcM = ICASE(lnK = 1,  "ValidarMotivo",       lnK = 2,  "ValidarUsuario", ;
                lnK = 3,  "ValidarSenha",        lnK = 4,  "MotivoKeyPress", ;
                lnK = 5,  "MotivoDblClick",      lnK = 6,  "UsuarioKeyPress", ;
                lnK = 7,  "UsuarioDblClick",     lnK = 8,  "AbrirBuscaMotivo", ;
                lnK = 9,  "AbrirBuscaUsuario",   "ObterResultado")
    STRTOFILE(PADR(lcM, 20) + " existe=" + TRANSFORM(PEMSTATUS(loF, lcM, 5)) + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loF, lcM, 2)) + L, lcLog, 1)
ENDFOR

STRTOFILE("--- parametros sincronizados no BO ---" + L, lcLog, 1)
WITH loF.this_oBusinessObject
    STRTOFILE("BO Tipo/ValDesc/PDescs/TotIte = [" + .this_cTipo + "]/" + ;
        TRANSFORM(.this_nValDesc) + "/" + TRANSFORM(.this_nPDescs) + "/" + ;
        TRANSFORM(.this_nTotIte) + L, lcLog, 1)
    STRTOFILE("BO Motivo/CheckBin/CheckTbd  = " + TRANSFORM(.this_lMotivo) + "/" + ;
        TRANSFORM(.this_lCheckBin) + "/" + TRANSFORM(.this_lCheckTbd) + L, lcLog, 1)
    STRTOFILE("BO Emps/ClaConta/SoMotivo    = [" + .this_cEmps + "]/[" + ;
        .this_cClaConta + "]/" + TRANSFORM(.this_lSoMotivo) + L, lcLog, 1)
ENDWITH

STRTOFILE("--- FecharDialogo: Hide mantem o objeto vivo e cacheia o retorno ---" + L, lcLog, 1)
loF.this_oBusinessObject.this_cZSenha = "OPERADOR  01"
loF.FecharDialogo(.T.)
STRTOFILE("pos-Fechar VARTYPE ...... " + VARTYPE(loF) + "  (esp O)" + L, lcLog, 1)
STRTOFILE("pos-Fechar Visible ...... " + TRANSFORM(loF.Visible) + "  (esp .F.)" + L, lcLog, 1)
STRTOFILE("ObterResultado() ........ [" + TRANSFORM(loF.ObterResultado()) + "]  tipo=" + ;
    VARTYPE(loF.ObterResultado()) + L, lcLog, 1)
STRTOFILE("this_lEncerrando ........ " + TRANSFORM(loF.this_lEncerrando) + L, lcLog, 1)
STRTOFILE("reentrancia: ValidarSenha apos encerrar (nao deve fazer nada)" + L, lcLog, 1)
loF.ValidarSenha()
STRTOFILE("ObterResultado() ainda .. [" + TRANSFORM(loF.ObterResultado()) + "]" + L, lcLog, 1)

loF.Release()
STRTOFILE("pos-Release VARTYPE ..... " + VARTYPE(loF) + "  (esp X)" + L, lcLog, 1)

*==============================================================================
* CENARIO 2 - senha livre (Tipo "L")
*==============================================================================
STRTOFILE(L + "=== CENARIO 2: Tipo L (senha livre) ===" + L, lcLog, 1)
loF2 = CREATEOBJECT("FormSigOpLim", 0, 0, 0, "L")
IF VARTYPE(loF2) = "O"
    STRTOFILE("Lbl1/Motivo (esp .F./.F.) " + TRANSFORM(loF2.lbl_4c_Label1.Visible) + "/" + ;
        TRANSFORM(loF2.txt_4c__Motivo.Visible) + L, lcLog, 1)
    STRTOFILE("Lbl2/Usuario (esp .F./.F.)" + TRANSFORM(loF2.lbl_4c_Label2.Visible) + "/" + ;
        TRANSFORM(loF2.txt_4c_Usuario.Visible) + L, lcLog, 1)
    STRTOFILE("Lbl3/Senha  (esp .T./.T.) " + TRANSFORM(loF2.lbl_4c_Label3.Visible) + "/" + ;
        TRANSFORM(loF2.txt_4c_Senha.Visible) + L, lcLog, 1)
    STRTOFILE("Senha.Enabled (esp .T.) . " + TRANSFORM(loF2.txt_4c_Senha.Enabled) + L, lcLog, 1)
    STRTOFILE("this_lSoMotivo (esp .F.)  " + TRANSFORM(loF2.this_lSoMotivo) + ;
        "  <- Tipo L entra no ramo proprio" + L, lcLog, 1)
    loF2.Release()
ELSE
    STRTOFILE("FALHOU: " + VARTYPE(loF2) + L, lcLog, 1)
ENDIF

*==============================================================================
* CENARIO 3 - so motivo (totite+valor+pvalor = 0 e Tipo <> X)
*==============================================================================
STRTOFILE(L + "=== CENARIO 3: so motivo (0/0/0, Tipo D, Motivo=.T.) ===" + L, lcLog, 1)
loF3 = CREATEOBJECT("FormSigOpLim", 0, 0, 0, "D", .NULL., .NULL., .T.)
IF VARTYPE(loF3) = "O"
    STRTOFILE("this_lSoMotivo (esp .T.)  " + TRANSFORM(loF3.this_lSoMotivo) + L, lcLog, 1)
    STRTOFILE("Frase.Caption ........... [" + loF3.lbl_4c_Frase.Caption + "]" + L, lcLog, 1)
    STRTOFILE("Lbl1/Motivo (esp .T./.T.) " + TRANSFORM(loF3.lbl_4c_Label1.Visible) + "/" + ;
        TRANSFORM(loF3.txt_4c__Motivo.Visible) + L, lcLog, 1)
    STRTOFILE("Lbl2/Usuario (esp .F./.F.)" + TRANSFORM(loF3.lbl_4c_Label2.Visible) + "/" + ;
        TRANSFORM(loF3.txt_4c_Usuario.Visible) + L, lcLog, 1)
    loF3.Release()
ELSE
    STRTOFILE("FALHOU: " + VARTYPE(loF3) + L, lcLog, 1)
ENDIF

*==============================================================================
* CENARIO 4 - Tipo X (limites) + sem Motivo
*==============================================================================
STRTOFILE(L + "=== CENARIO 4: Tipo X, Motivo=.F. ===" + L, lcLog, 1)
loF4 = CREATEOBJECT("FormSigOpLim", 0, 0, 0, "X", .NULL., .NULL., .F.)
IF VARTYPE(loF4) = "O"
    STRTOFILE("this_lSoMotivo (esp .F.)  " + TRANSFORM(loF4.this_lSoMotivo) + ;
        "  <- Tipo X nunca eh so-motivo" + L, lcLog, 1)
    STRTOFILE("Frase.Caption ........... [" + loF4.lbl_4c_Frase.Caption + "]" + L, lcLog, 1)
    STRTOFILE("Lbl1/Motivo (esp .F./.F.) " + TRANSFORM(loF4.lbl_4c_Label1.Visible) + "/" + ;
        TRANSFORM(loF4.txt_4c__Motivo.Visible) + L, lcLog, 1)
    STRTOFILE("Lbl2/Usuario (esp .T./.T.)" + TRANSFORM(loF4.lbl_4c_Label2.Visible) + "/" + ;
        TRANSFORM(loF4.txt_4c_Usuario.Visible) + L, lcLog, 1)
    STRTOFILE("Motivo.Enabled (esp .F.)  " + TRANSFORM(loF4.txt_4c__Motivo.Enabled) + L, lcLog, 1)
    loF4.Release()
ELSE
    STRTOFILE("FALHOU: " + VARTYPE(loF4) + L, lcLog, 1)
ENDIF

*==============================================================================
* CENARIO 5 - chave posicional EmpDopNums (regra #42)
*==============================================================================
STRTOFILE(L + "=== CENARIO 5: MontarEmpDopNumsMovimento (chave posicional) ===" + L, lcLog, 1)
CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6, 0))
INSERT INTO TprMvCab VALUES ("001", "MALOTE", 3)
GO TOP IN TprMvCab

loF5 = CREATEOBJECT("FormSigOpLim", 0, 0, 0, "L")
IF VARTYPE(loF5) = "O"
    *-- metodo PROTECTED: alcancado por uma subclasse de teste
    loP = CREATEOBJECT("ProbeSigOpLim", 0, 0, 0, "L")
    IF VARTYPE(loP) = "O"
        lcChave = loP.ProbeChave()
        STRTOFILE("chave ................... [" + lcChave + "]" + L, lcLog, 1)
        STRTOFILE("LEN (esp 29) ............ " + TRANSFORM(LEN(lcChave)) + L, lcLog, 1)
        STRTOFILE("partes 1-3/4-23/24-29 ... [" + SUBSTR(lcChave, 1, 3) + "][" + ;
            SUBSTR(lcChave, 4, 20) + "][" + SUBSTR(lcChave, 24, 6) + "]" + L, lcLog, 1)
        loP.Release()
    ENDIF
    loF5.Release()
ENDIF
USE IN TprMvCab

STRTOFILE(L + "=== dialogos suprimidos no modo teste ===" + L, lcLog, 1)
STRTOFILE(FILETOSTR(gc_4c_ArquivoErroTeste) + L, lcLog, 1)
STRTOFILE(L + "FIM" + L, lcLog, 1)

QUIT

*------------------------------------------------------------------------------
DEFINE CLASS ProbeSigOpLim AS FormSigOpLim
    FUNCTION ProbeChave()
        RETURN THIS.MontarEmpDopNumsMovimento()
    ENDFUNC
ENDDEFINE
