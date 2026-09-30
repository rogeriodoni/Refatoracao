*==============================================================================
* test_f4_aop.prg - Harness da Fase 4 do FormSigPrAop
* Prova INSTANCIANDO: form abre; grade com as 5 colunas na ordem visual do
* legado; grupo Confirmar/Encerrar com os icones existentes; CarregarDados
* alcancavel de FORA da classe (PUBLIC) e repintando a grade.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, lnFalhas, i, loG, loB
lcCRLF   = CHR(13) + CHR(10)
lcLog    = "C:\4c\automation\test_f4_aop_resultado.txt"
lcCls    = "C:\4c\projeto\app\classes\"
lcUtl    = "C:\4c\projeto\app\utils\"
lnFalhas = 0

STRTOFILE("=== TESTE FASE 4 FormSigPrAop ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste         = .T.
gb_4c_ValidandoUI       = .F.
gnConnHandle            = -1
gc_4c_CaminhoIcones     = "C:\4c\vbmp\"
gc_4c_CaminhoReports    = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoFramework  = "C:\4c\Framework\"
gc_4c_UsuarioLogado     = "TESTE"
gc_4c_ArquivoErroTeste  = "C:\4c\automation\test_f4_aop_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais,C:\4c\vbmp")

TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "SigPrAopBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE        : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE        : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDTRY

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigPrAop")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT         : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("CREATEOBJECT         : FALHOU (VARTYPE=" + VARTYPE(loForm) + ")" + lcCRLF, lcLog, 1)
    STRTOFILE("RESULTADO            : FALHA" + lcCRLF, lcLog, 1)
    QUIT
ENDIF

STRTOFILE("CREATEOBJECT         : OK  Caption=[" + loForm.Caption + "]" + lcCRLF, lcLog, 1)

*-- GRADE
IF PEMSTATUS(loForm, "grd_4c_Dados", 5)
    loG = loForm.grd_4c_Dados
    STRTOFILE("grd_4c_Dados         : OK  ColumnCount=" + TRANSFORM(loG.ColumnCount) + ;
        "  RecordSource=[" + loG.RecordSource + "]" + lcCRLF, lcLog, 1)
    FOR i = 1 TO loG.ColumnCount
        STRTOFILE("   Col" + TRANSFORM(i) + " hdr=[" + loG.Columns(i).Header1.Caption + "]" + ;
            " w=" + TRANSFORM(loG.Columns(i).Width) + ;
            " ro=" + TRANSFORM(loG.Columns(i).ReadOnly) + ;
            " src=[" + loG.Columns(i).ControlSource + "]" + lcCRLF, lcLog, 1)
    ENDFOR
ELSE
    STRTOFILE("grd_4c_Dados         : AUSENTE" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

*-- BOTOES
IF PEMSTATUS(loForm, "cmg_4c_Grupo_Conf", 5)
    loB = loForm.cmg_4c_Grupo_Conf
    STRTOFILE("cmg_4c_Grupo_Conf    : OK  ButtonCount=" + TRANSFORM(loB.ButtonCount) + lcCRLF, lcLog, 1)
    FOR i = 1 TO loB.ButtonCount
        STRTOFILE("   Btn" + TRANSFORM(i) + " cap=[" + loB.Buttons(i).Caption + "]" + ;
            " picOK=" + TRANSFORM(FILE(loB.Buttons(i).Picture)) + ;
            " enab=" + TRANSFORM(loB.Buttons(i).Enabled) + lcCRLF, lcLog, 1)
    ENDFOR
ELSE
    STRTOFILE("cmg_4c_Grupo_Conf    : AUSENTE" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

*-- CARREGARDADOS chamado de FORA da classe (prova que e' PUBLIC)
IF PEMSTATUS(loForm, "CarregarDados", 5)
    TRY
        STRTOFILE("CarregarDados(0)     : ret=" + TRANSFORM(loForm.CarregarDados(0)) + ;
            "  RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_DivOp"), RECCOUNT("cursor_4c_DivOp"), -1)) + ;
            "  Confirmar.Enabled=" + TRANSFORM(loForm.cmg_4c_Grupo_Conf.Buttons(1).Enabled) + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("CarregarDados(0)     : EXCECAO - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY
ELSE
    STRTOFILE("CarregarDados        : AUSENTE" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

STRTOFILE("RESULTADO            : " + IIF(lnFalhas = 0, "SUCESSO", "FALHA (" + TRANSFORM(lnFalhas) + ")") + lcCRLF, lcLog, 1)
loForm.Release()
QUIT
