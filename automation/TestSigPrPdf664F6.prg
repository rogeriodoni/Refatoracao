*-- Prova de runtime da Fase 6 do Formsigprpdf (task664 / SIGPRPDF):
*--   1) o form INSTANCIA (Init de form grande falha em cadeia - "abriu" so se
*--      prova instanciando);
*--   2) os 4 controles novos do painel de e-mail existem com a geometria do SCX;
*--   3) SincronizarCamposParaBO espelha TELA -> BO (o controle eh a fonte);
*--   4) ValidarDadosEnvio reproduz os 3 guards BLOQUEANTES do
*--      Cmd_GerarPDF.Click legado, com a mensagem e o campo certos.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXCLUSIVE OFF
SET CONSOLE OFF

LOCAL lcLog, lcBase, loForm, loErr, loPainel, loBO, llOk, lcDlg, loPai, loEmail
LOCAL lcNome, lnI, lnEsperaT, lnEsperaL, lnEsperaW, lnEsperaH

lcBase = "C:\4c\projeto\app\"
lcLog  = "C:\4c\automation\TestSigPrPdf664F6_saida.txt"
STRTOFILE("=== TESTE FASE 6 Formsigprpdf (task664) ===" + CHR(13) + CHR(10), lcLog)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_CaminhoReports
PUBLIC gc_4c_UsuarioLogado, gc_4c_ArquivoErroTeste, gc_4c_ArquivoDialogosTeste
gnConnHandle               = -1
gb_4c_ModoTeste            = .T.
gb_4c_ValidandoUI          = .T.
gc_4c_CaminhoIcones        = "C:\4c\vbmp\"
gc_4c_CaminhoFramework     = "C:\4c\Framework\"
gc_4c_CaminhoReports       = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado        = "TESTE"
gc_4c_ArquivoErroTeste     = "C:\4c\automation\TestSigPrPdf664F6_erros.txt"
gc_4c_ArquivoDialogosTeste = "C:\4c\automation\TestSigPrPdf664F6_dialogs.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    ERASE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_ArquivoDialogosTeste)
    ERASE (gc_4c_ArquivoDialogosTeste)
ENDIF

PUBLIC go_4c_Sistema
go_4c_Sistema = CREATEOBJECT("Custom")
go_4c_Sistema.AddProperty("cCodEmpresa", "001")
go_4c_Sistema.AddProperty("cEmpresa", "TESTE")
go_4c_Sistema.AddProperty("cCNPJ", "")
go_4c_Sistema.AddProperty("DirFiscais", "C:\4c\automation\")

SET PATH TO (lcBase + "utils," + lcBase + "classes," + lcBase + "forms\operacionais," + lcBase + "start")

*-- FXP velho faz o harness rodar codigo antigo: apagar antes e recompilar
IF FILE(lcBase + "classes\sigprpdfbo.fxp")
    ERASE (lcBase + "classes\sigprpdfbo.fxp")
ENDIF
IF FILE(lcBase + "forms\operacionais\formsigprpdf.fxp")
    ERASE (lcBase + "forms\operacionais\formsigprpdf.fxp")
ENDIF
COMPILE (lcBase + "classes\sigprpdfBO.prg")
COMPILE (lcBase + "forms\operacionais\Formsigprpdf.prg")
STRTOFILE("BO  .fxp recriado  : " + TRANSFORM(FILE(lcBase + "classes\sigprpdfbo.fxp")) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("FORM.fxp recriado  : " + TRANSFORM(FILE(lcBase + "forms\operacionais\formsigprpdf.fxp")) + CHR(13) + CHR(10), lcLog, 1)

SET PROCEDURE TO (lcBase + "utils\functions.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "utils\messages.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "utils\validators.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\dataaccess.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\formbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\gridbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\sigprpdfBO.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "forms\operacionais\Formsigprpdf.prg") ADDITIVE

*-- Form PAI simulado (poformParent); pcAssunto vem no 2o parametro do Init
loPai = CREATEOBJECT("Custom")
loPai.AddProperty("Contaemail", "destino@cliente.com.br")
loPai.AddProperty("pcArqEmail", "")
loPai.AddProperty("oEmail", .NULL.)

*-- ============================ 1) INSTANCIA ============================
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Formsigprpdf", loPai, "Relatorio de Teste")
CATCH TO loErr
    STRTOFILE("EXCECAO no CREATEOBJECT: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
              " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

STRTOFILE("VARTYPE(loForm)    : " + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, 1)
IF VARTYPE(loForm) != "O"
    STRTOFILE("RESULTADO: FALHA - form nao instanciou" + CHR(13) + CHR(10), lcLog, 1)
    QUIT
ENDIF

loPainel = loForm.cnt_4c_CtnSaida_Email
loBO     = loForm.this_oBusinessObject

*-- ===================== 2) OS 4 CONTROLES NOVOS ========================
STRTOFILE(CHR(13) + CHR(10) + "--- 2) controles novos (medido / esperado do SCX) ---" + CHR(13) + CHR(10), lcLog, 1)

LOCAL ARRAY laAlvo(4, 5)
laAlvo(1,1) = "lbl_4c_LblEmail_Assunto"
laAlvo(1,2) =  99
laAlvo(1,3) =  21
laAlvo(1,4) =  45
laAlvo(1,5) =  15
laAlvo(2,1) = "txt_4c_TxtEmail_Assunto"
laAlvo(2,2) =  95
laAlvo(2,3) =  68
laAlvo(2,4) = 404
laAlvo(2,5) =  23
laAlvo(3,1) = "lbl_4c_LblEmail_Corpo"
laAlvo(3,2) = 127
laAlvo(3,3) =  32
laAlvo(3,4) =  34
laAlvo(3,5) =  15
laAlvo(4,1) = "obj_4c_EdtEmail_Corpo"
laAlvo(4,2) = 125
laAlvo(4,3) =  68
laAlvo(4,4) = 404
laAlvo(4,5) =  53

FOR lnI = 1 TO 4
    lcNome    = laAlvo(lnI, 1)
    lnEsperaT = laAlvo(lnI, 2)
    lnEsperaL = laAlvo(lnI, 3)
    lnEsperaW = laAlvo(lnI, 4)
    lnEsperaH = laAlvo(lnI, 5)

    IF TYPE("loPainel." + lcNome) = "O"
        STRTOFILE(PADR(lcNome, 26) + ;
            " base=" + PADR(EVALUATE("loPainel." + lcNome + ".BaseClass"), 14) + ;
            " T=" + PADL(TRANSFORM(EVALUATE("loPainel." + lcNome + ".Top")), 4) + "/" + PADL(TRANSFORM(lnEsperaT), 4) + ;
            " L=" + PADL(TRANSFORM(EVALUATE("loPainel." + lcNome + ".Left")), 4) + "/" + PADL(TRANSFORM(lnEsperaL), 4) + ;
            " W=" + PADL(TRANSFORM(EVALUATE("loPainel." + lcNome + ".Width")), 4) + "/" + PADL(TRANSFORM(lnEsperaW), 4) + ;
            " H=" + PADL(TRANSFORM(EVALUATE("loPainel." + lcNome + ".Height")), 4) + "/" + PADL(TRANSFORM(lnEsperaH), 4) + ;
            " Vis=" + TRANSFORM(EVALUATE("loPainel." + lcNome + ".Visible")) + CHR(13) + CHR(10), lcLog, 1)
    ELSE
        STRTOFILE(PADR(lcNome, 26) + " *** AUSENTE ***" + CHR(13) + CHR(10), lcLog, 1)
    ENDIF
ENDFOR

STRTOFILE("ScrollBars Corpo (SCX nao declara -> default 2): " + ;
          TRANSFORM(loPainel.obj_4c_EdtEmail_Corpo.ScrollBars) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("ScrollBars CC    (SCX declara 0)               : " + ;
          TRANSFORM(loPainel.obj_4c_TxtEmail_CC.ScrollBars) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("Assunto inicial (pcAssunto do Init)            : [" + ;
          ALLTRIM(loPainel.txt_4c_TxtEmail_Assunto.Value) + "]" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("Para inicial (oParentForm.Contaemail)          : [" + ;
          ALLTRIM(loPainel.obj_4c_TxtEmail_EnviarPara.Value) + "]" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("Corpo: Top+Height = " + ;
          TRANSFORM(loPainel.obj_4c_EdtEmail_Corpo.Top + loPainel.obj_4c_EdtEmail_Corpo.Height) + ;
          " <= container.Height = " + TRANSFORM(loPainel.Height) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("Total de controles no painel (esperado 10)     : " + ;
          TRANSFORM(loPainel.ControlCount) + CHR(13) + CHR(10), lcLog, 1)

*-- ================ 3) SincronizarCamposParaBO (TELA -> BO) ==============
STRTOFILE(CHR(13) + CHR(10) + "--- 3) SincronizarCamposParaBO (o controle eh a fonte) ---" + CHR(13) + CHR(10), lcLog, 1)

loPainel.txt_4c_TxtEmail_EnviarDE.Value   = "  remetente@empresa.com  "
loPainel.obj_4c_TxtEmail_EnviarPara.Value = "  cliente@dominio.com  "
loPainel.obj_4c_TxtEmail_CC.Value         = " copia@dominio.com "
loPainel.txt_4c_TxtEmail_Assunto.Value    = " Fechamento Mensal "
loPainel.obj_4c_EdtEmail_Corpo.Value      = " Segue em anexo. "
loForm.chk_4c_Chk_EMAIL.Value             = 1

loForm.SincronizarCamposParaBO()

STRTOFILE("this_cEmailDe      = [" + loBO.this_cEmailDe      + "]" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("this_cEmailPara    = [" + loBO.this_cEmailPara    + "]" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("this_cEmailCC      = [" + loBO.this_cEmailCC      + "]" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("this_cEmailAssunto = [" + loBO.this_cEmailAssunto + "]" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("this_cEmailCorpo   = [" + loBO.this_cEmailCorpo   + "]" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("this_lEnviarEmail  = " + TRANSFORM(loBO.this_lEnviarEmail) + ;
          "  VARTYPE=" + VARTYPE(loBO.this_lEnviarEmail) + " (tem de ser L)" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("this_nTipoArquivo  = " + TRANSFORM(loBO.this_nTipoArquivo) + ;
          "  VARTYPE=" + VARTYPE(loBO.this_nTipoArquivo) + " (tem de ser N)" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("this_cArquivoSaida = [" + loBO.this_cArquivoSaida + "]" + CHR(13) + CHR(10), lcLog, 1)

*-- =============== 4) ValidarDadosEnvio - os 3 guards ===================
STRTOFILE(CHR(13) + CHR(10) + "--- 4) ValidarDadosEnvio (guards do Cmd_GerarPDF.Click) ---" + CHR(13) + CHR(10), lcLog, 1)

*-- 4a) arquivo de saida vazio, e-mail desmarcado -> recusa no 1o guard
loForm.chk_4c_Chk_EMAIL.Value       = 0
loBO.this_lContaEmailCarregada      = .T.
loForm.txt_4c_TxtNomeArqSaida.Value = ""
llOk = loForm.ValidarDadosEnvio()
STRTOFILE("4a arquivo vazio              -> " + TRANSFORM(llOk) + ;
          "  campo=[" + loBO.this_cCampoInvalido + "]  msg=[" + loBO.this_cMensagemErro + "]" + CHR(13) + CHR(10), lcLog, 1)

*-- 4b) arquivo ok e e-mail DESMARCADO -> aprova sem olhar DE/PARA
loForm.txt_4c_TxtNomeArqSaida.Value       = "C:\4c\automation\FORTYUSPDF.PDF"
loPainel.txt_4c_TxtEmail_EnviarDE.Value   = ""
loPainel.obj_4c_TxtEmail_EnviarPara.Value = ""
llOk = loForm.ValidarDadosEnvio()
STRTOFILE("4b sem e-mail, DE/PARA vazios -> " + TRANSFORM(llOk) + "  (esperado .T.)" + CHR(13) + CHR(10), lcLog, 1)

*-- 4c) e-mail marcado e campo DE vazio -> recusa no 2o guard
loForm.chk_4c_Chk_EMAIL.Value = 1
loForm.AlternarPainelEmail(.T.)
llOk = loForm.ValidarDadosEnvio()
STRTOFILE("4c e-mail, DE vazio           -> " + TRANSFORM(llOk) + ;
          "  campo=[" + loBO.this_cCampoInvalido + "]  msg=[" + loBO.this_cMensagemErro + "]" + CHR(13) + CHR(10), lcLog, 1)

*-- 4d) DE preenchido e PARA vazio -> recusa no 3o guard
loPainel.txt_4c_TxtEmail_EnviarDE.Value = "remetente@empresa.com"
llOk = loForm.ValidarDadosEnvio()
STRTOFILE("4d e-mail, PARA vazio         -> " + TRANSFORM(llOk) + ;
          "  campo=[" + loBO.this_cCampoInvalido + "]  msg=[" + loBO.this_cMensagemErro + "]" + CHR(13) + CHR(10), lcLog, 1)

*-- 4e) tudo preenchido -> aprova
loPainel.obj_4c_TxtEmail_EnviarPara.Value = "cliente@dominio.com"
llOk = loForm.ValidarDadosEnvio()
STRTOFILE("4e tudo preenchido            -> " + TRANSFORM(llOk) + "  (esperado .T.)" + CHR(13) + CHR(10), lcLog, 1)

*-- 4f) o objeto de envio sai com os valores da TELA (prova do espelho)
loEmail = loBO.MontarDadosEnvioEmail()
IF VARTYPE(loEmail) = "O"
    STRTOFILE("4f oEMAIL cFrom=[" + loEmail.cFrom + "] cTO=[" + loEmail.cTO + ;
              "] cAssunto=[" + loEmail.cAssunto + "] cAnexo=[" + loEmail.cAnexo + "]" + CHR(13) + CHR(10), lcLog, 1)
ELSE
    STRTOFILE("4f MontarDadosEnvioEmail devolveu NAO-OBJETO" + CHR(13) + CHR(10), lcLog, 1)
ENDIF

*-- Dialogos exibidos (MsgAviso eh capturado em arquivo no modo teste)
lcDlg = ""
IF FILE(gc_4c_ArquivoDialogosTeste)
    lcDlg = FILETOSTR(gc_4c_ArquivoDialogosTeste)
ENDIF
STRTOFILE(CHR(13) + CHR(10) + "--- dialogos capturados ---" + CHR(13) + CHR(10) + lcDlg + CHR(13) + CHR(10), lcLog, 1)

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("--- ERROS ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), lcLog, 1)
ELSE
    STRTOFILE("--- ERROS: nenhum ---" + CHR(13) + CHR(10), lcLog, 1)
ENDIF

loForm.Release()
STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
QUIT
