*==============================================================================
* test_fase7_sigmvpdt.prg - Fase 7 do FormSigMvPdt: eventos do(s) botao(oes)
*
* O legado SIGMVPDT tem UM UNICO botao (Processo) e NENHUM botao CRUD - este
* teste prova as duas coisas no objeto instanciado, e exercita o que a Fase 7
* acrescentou: a falha de BuscarOperacao deixando de ser muda (this_lErro).
*
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL e trava em
* execucao desatendida). Sem COMPILE nesta sessao (ver test_fase4_sigmvmvt).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCRLF, lcDlg
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\automation\vfp_helpers\test_fase7_sigmvpdt_resultado.txt"
lcDlg  = "C:\4c\automation\vfp_helpers\test_fase7_sigmvpdt_dialogs.txt"

STRTOFILE("=== TESTE FASE 7 FormSigMvPdt ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = lcDlg

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")
SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\FormErro.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\dataaccess.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\formbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\SigMvPdtBO.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\forms\operacionais\FormSigMvPdt.prg") ADDITIVE

*-- 1) Instanciacao (Init -> InicializarForm -> ConfigurarControles).
*-- SEM Show(): o Activate dispararia o despacho modal e travaria o harness.
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigMvPdt", "OP001", " ", 0, "")
CATCH TO loErr
    STRTOFILE("[FALHA] CREATEOBJECT: " + loErr.Message + ;
              " (linha " + TRANSFORM(loErr.LineNo) + ")" + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("[FALHA] form nao instanciou - VARTYPE=" + VARTYPE(loForm) + lcCRLF, lcLog, 1)
    QUIT
ENDIF

STRTOFILE("[OK] form instanciou - BaseClass=" + loForm.BaseClass + ;
          " Width=" + TRANSFORM(loForm.Width) + ;
          " Height=" + TRANSFORM(loForm.Height) + lcCRLF, lcLog, 1)

*-- 2) O UNICO botao do legado existe, com as propriedades do dump.
IF PEMSTATUS(loForm, "cmd_4c_Processo", 5)
    STRTOFILE("[OK] cmd_4c_Processo existe: Top=" + TRANSFORM(loForm.cmd_4c_Processo.Top) + ;
              " Left="    + TRANSFORM(loForm.cmd_4c_Processo.Left) + ;
              " Width="   + TRANSFORM(loForm.cmd_4c_Processo.Width) + ;
              " Height="  + TRANSFORM(loForm.cmd_4c_Processo.Height) + ;
              " Caption=[" + loForm.cmd_4c_Processo.Caption + "]" + ;
              " Visible=" + TRANSFORM(loForm.cmd_4c_Processo.Visible) + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("[FALHA] cmd_4c_Processo NAO existe" + lcCRLF, lcLog, 1)
ENDIF

*-- 3) O evento do botao existe e eh alcancavel de FORA da classe (o harness
*-- TesteAutomatico chama assim - regra #3: PROTECTED falharia em runtime).
STRTOFILE("[INFO] PEMSTATUS CmdProcessoClick=" + ;
          TRANSFORM(PEMSTATUS(loForm, "CmdProcessoClick", 5)) + lcCRLF, lcLog, 1)

*-- 4) Os 4 nomes CRUD tem de estar AUSENTES (o legado nao tem CRUD).
LOCAL laCrud[4], lnI, lcNome
laCrud[1] = "BtnIncluirClick"
laCrud[2] = "BtnAlterarClick"
laCrud[3] = "BtnVisualizarClick"
laCrud[4] = "BtnExcluirClick"
FOR lnI = 1 TO 4
    lcNome = laCrud[lnI]
    IF PEMSTATUS(loForm, lcNome, 5)
        STRTOFILE("[ATENCAO] " + lcNome + " EXISTE (o legado nao tem CRUD)" + lcCRLF, lcLog, 1)
    ELSE
        STRTOFILE("[OK] " + lcNome + " ausente, como no legado" + lcCRLF, lcLog, 1)
    ENDIF
ENDFOR

*-- 5) O que a Fase 7 acrescentou: com gnConnHandle = -1 a BuscarOperacao
*-- falha, e a falha NAO pode mais ser muda. Esperado: this_lErro = .T.,
*-- mensagem no _dialogs.txt e o despacho tentado ainda assim (o legado
*-- despacha independentemente do resultado do CursorQuery).
STRTOFILE("[INFO] this_lErro ANTES do evento=" + TRANSFORM(loForm.this_lErro) + lcCRLF, lcLog, 1)

TRY
    loForm.CmdProcessoClick()
    STRTOFILE("[OK] CmdProcessoClick executou sem excecao" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[FALHA] CmdProcessoClick: " + loErr.Message + ;
              " (linha " + TRANSFORM(loErr.LineNo) + " proc " + loErr.Procedure + ")" + lcCRLF, lcLog, 1)
ENDTRY

*-- O proprio evento faz THIS.Release() no fim (contrato do despachante -
*-- Fase 6), entao a referencia pode ja ter caido: conferir antes de ler.
IF VARTYPE(loForm) = "O"
    STRTOFILE("[INFO] this_lErro DEPOIS do evento=" + TRANSFORM(loForm.this_lErro) + lcCRLF, lcLog, 1)
    STRTOFILE("[INFO] form AINDA vivo apos o evento (Release nao derrubou a referencia local)" + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("[OK] form liberado pelo proprio evento - VARTYPE=" + VARTYPE(loForm) + ;
              " (Release do despachante, Fase 6)" + lcCRLF, lcLog, 1)
ENDIF

STRTOFILE("=== FIM ===" + lcCRLF, lcLog, 1)
QUIT
