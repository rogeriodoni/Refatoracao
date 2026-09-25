*==============================================================================
* test_fase4_sigmvmvt_carga.prg - Fase 4 do FormSIGMVMVT: metodo de carga
*
* Complementa test_fase4_sigmvmvt.prg (que cobre os CONTROLES) exercitando o
* que a Fase 4 acrescentou: CarregarDados/PopularArvore/PrepararArvore/
* ArvoreDisponivel/ObterFiltro, mais a abertura em modo "Automatico".
*
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL e trava em
* execucao desatendida).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, llRes
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\automation\vfp_helpers\test_fase4_sigmvmvt_carga_resultado.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 4 (CARGA) FormSIGMVMVT ===" + lcCRLF, lcLog, 0)

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
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_fase4_sigmvmvt_carga_dialogs.txt"

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

*-- 1) Compilacao: NAO fazer COMPILE aqui. Medido em 2026-09-25: um COMPILE
*-- nesta mesma sessao bloqueia a gravacao de dialogos suprimidos mais
*-- adiante e o VFP trava - artefato do harness, nao do form. A compilacao
*-- e' verificada em processo separado (tmp_t574\onlycompile.prg).
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.err")
    STRTOFILE("COMPILE .err      : " + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.err") + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("COMPILE .err      : NENHUM (compilacao limpa)" + lcCRLF, lcLog, 1)
ENDIF

*-- 2) Dependencias
TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "SIGMVMVTBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE     : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE     : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- 3) Instanciacao SEM drill direto
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGMVMVT")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT      : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) = "O"
    STRTOFILE("CREATEOBJECT      : OK" + lcCRLF, lcLog, 1)

    STRTOFILE("--- METODOS DA FASE 4 (carga) ---" + lcCRLF, lcLog, 1)
    STRTOFILE("CarregarDados     : " + TRANSFORM(PEMSTATUS(loForm, "CarregarDados", 5)) + lcCRLF, lcLog, 1)
    STRTOFILE("PopularArvore     : " + TRANSFORM(PEMSTATUS(loForm, "PopularArvore", 5)) + lcCRLF, lcLog, 1)
    STRTOFILE("PrepararArvore    : " + TRANSFORM(PEMSTATUS(loForm, "PrepararArvore", 5)) + lcCRLF, lcLog, 1)
    STRTOFILE("ArvoreDisponivel  : " + TRANSFORM(PEMSTATUS(loForm, "ArvoreDisponivel", 5)) + lcCRLF, lcLog, 1)
    STRTOFILE("ObterFiltro       : " + TRANSFORM(PEMSTATUS(loForm, "ObterFiltro", 5)) + lcCRLF, lcLog, 1)

    *-- CarregarDados SEM filtro: deve avisar e devolver .F., sem estourar
    TRY
        llRes = loForm.CarregarDados()
        STRTOFILE("CarregarDados(vazio) -> " + TRANSFORM(llRes) + ;
            " (esperado .F.)" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("CarregarDados(vazio) ESTOUROU: " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
    ENDTRY

    *-- CarregarDados COM filtro, sem conexao (gnConnHandle=-1): o BO tem de
    *-- recusar com mensagem e o form devolver .F., ainda sem estourar
    loForm.this_cEmpsParam  = "001"
    loForm.this_cDopesParam = "OPERACAO TESTE"
    loForm.this_nNumesParam = 1
    TRY
        llRes = loForm.CarregarDados()
        STRTOFILE("CarregarDados(filtro/sem conexao) -> " + TRANSFORM(llRes) + ;
            " (esperado .F.)" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("CarregarDados(filtro) ESTOUROU: " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
    ENDTRY

    loForm.Release()
    loForm = .NULL.
ELSE
    STRTOFILE("CREATEOBJECT      : FALHOU" + lcCRLF, lcLog, 1)
ENDIF

*-- 4) Abertura em modo AUTOMATICO (drill direto) - Init legado chama MakeTree
STRTOFILE("--- MODO AUTOMATICO (drill direto) ---" + lcCRLF, lcLog, 1)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGMVMVT", .T., "001", "OPERACAO TESTE", 1)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT(auto) EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) = "O"
    STRTOFILE("CREATEOBJECT(auto): OK | Automatico=" + TRANSFORM(loForm.this_lAutomatico) + ;
        " | WindowType=" + TRANSFORM(loForm.WindowType) + lcCRLF, lcLog, 1)
    loForm.Release()
ELSE
    STRTOFILE("CREATEOBJECT(auto): FALHOU" + lcCRLF, lcLog, 1)
ENDIF

STRTOFILE("--- FIM ---" + lcCRLF, lcLog, 1)

CLOSE ALL
QUIT



