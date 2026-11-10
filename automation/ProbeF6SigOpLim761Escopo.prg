SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

lcLog = "C:\4c\automation\ProbeF6SigOpLim761Escopo.log"
STRTOFILE("", lcLog)
#DEFINE L CHR(13) + CHR(10)

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
gc_4c_ArquivoErroTeste = "C:\4c\automation\ProbeF6SigOpLim761Escopo_dialogs.txt"
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
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpLimBO.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpLim.prg" ADDITIVE

*==============================================================================
* Regra #51 - metodo do BO chamado pelo FORM nao pode ser PROTECTED em
* NENHUM nivel da heranca. PEMSTATUS(obj, m, 2) = .T. significa Protected.
*==============================================================================
STRTOFILE("=== regra #51: escopo dos metodos do BO chamados pelo FORM ===" + L, lcLog, 1)

loBO = CREATEOBJECT("SigOpLimBO")
STRTOFILE("VARTYPE(BO) = " + VARTYPE(loBO) + L, lcLog, 1)

IF VARTYPE(loBO) = "O"
    lnFalhas = 0
    FOR lnK = 1 TO 10
        lcM = ICASE( ;
            lnK = 1,  "BuscarMotivos", ;
            lnK = 2,  "BuscarUsuariosAutorizados", ;
            lnK = 3,  "CarregarDoCursor", ;
            lnK = 4,  "CarregarMotivoDoCursor", ;
            lnK = 5,  "ComporAutorizacaoSoMotivo", ;
            lnK = 6,  "ComporAutorizacaoSenhaLivre", ;
            lnK = 7,  "ComporAutorizacaoUsuarioSenha", ;
            lnK = 8,  "ValidarSenhaUsuario", ;
            lnK = 9,  "ValidarEConsumirSenhaLivre", ;
                      "GeraSenha")
        llExiste = PEMSTATUS(loBO, lcM, 5)
        llProt   = PEMSTATUS(loBO, lcM, 2)
        IF !llExiste OR llProt
            lnFalhas = lnFalhas + 1
        ENDIF
        STRTOFILE(IIF(!llExiste OR llProt, "!!! ", "OK  ") + PADR(lcM, 32) + ;
            " existe=" + TRANSFORM(llExiste) + "  protected=" + TRANSFORM(llProt) + L, lcLog, 1)
    ENDFOR
    STRTOFILE("falhas = " + TRANSFORM(lnFalhas) + "  (esp 0)" + L, lcLog, 1)

    *-- metodos que DEVEM continuar PROTECTED (nunca chamados de fora)
    STRTOFILE(L + "--- devem ser PROTECTED (esp .T.) ---" + L, lcLog, 1)
    FOR lnK = 1 TO 2
        lcM = IIF(lnK = 1, "ObterChavePrimaria", "FiltrarMotivosPorClassificacao")
        STRTOFILE(PADR(lcM, 32) + " protected=" + TRANSFORM(PEMSTATUS(loBO, lcM, 2)) + L, lcLog, 1)
    ENDFOR

    loBO = .NULL.
ENDIF

*==============================================================================
* Caminho de composicao da autorizacao, acionado pelo FORM, sem conexao SQL:
* nao pode derrubar o dialogo (RegistrarAuditoria faz SQL com handle -1)
*==============================================================================
STRTOFILE(L + "=== ComporAutorizacao* com gnConnHandle = -1 ===" + L, lcLog, 1)

loF = CREATEOBJECT("FormSigOpLim", 0, 0, 0, "D", .T.)
IF VARTYPE(loF) = "O"
    loF.txt_4c__Motivo.Value = "7"

    *-- so-motivo: o legado compoe Space(10) + codigo
    loF.this_oBusinessObject.ComporAutorizacaoSoMotivo("7")
    STRTOFILE("SoMotivo  -> ZSenha=[" + loF.this_oBusinessObject.this_cZSenha + "]  LEN=" + ;
        TRANSFORM(LEN(loF.this_oBusinessObject.this_cZSenha)) + ;
        "  Autorizado=" + TRANSFORM(loF.this_oBusinessObject.this_lAutorizado) + L, lcLog, 1)

    *-- usuario+senha, Tipo D: usuarios do cursor + motivo
    loF.this_oBusinessObject.this_cUsuarios = "OPERADOR  "
    loF.this_oBusinessObject.ComporAutorizacaoUsuarioSenha("DIGITADO", "7")
    STRTOFILE("Usu+Senha -> ZSenha=[" + loF.this_oBusinessObject.this_cZSenha + "]" + L, lcLog, 1)

    *-- Tipo X devolve o usuario DIGITADO
    loF.this_oBusinessObject.this_cTipo = "X"
    loF.this_oBusinessObject.ComporAutorizacaoUsuarioSenha("DIGITADO", "7")
    STRTOFILE("Tipo X    -> ZSenha=[" + loF.this_oBusinessObject.this_cZSenha + "]" + L, lcLog, 1)

    *-- Tipo L devolve o usuario logado
    loF.this_oBusinessObject.ComporAutorizacaoSenhaLivre()
    STRTOFILE("Tipo L    -> ZSenha=[" + loF.this_oBusinessObject.this_cZSenha + "]" + L, lcLog, 1)

    STRTOFILE("form ainda vivo = " + VARTYPE(loF) + "  (esp O)" + L, lcLog, 1)
    loF.Release()
ELSE
    STRTOFILE("FALHOU ao instanciar: " + VARTYPE(loF) + L, lcLog, 1)
ENDIF

STRTOFILE(L + "=== dialogos suprimidos ===" + L, lcLog, 1)
STRTOFILE(FILETOSTR(gc_4c_ArquivoErroTeste) + L, lcLog, 1)
STRTOFILE("FIM" + L, lcLog, 1)
QUIT
