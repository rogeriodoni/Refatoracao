*==============================================================================
* ProbeErro301Mtz.prg - Reproduz no FORM a sequencia Incluir -> Alterar que
* estourava "Error with Column28 - CurrentControl" e prova que agora se cura.
* NOTA: a rotina de log NAO pode se chamar Log() - LOG() eh funcao NATIVA do
* VFP (logaritmo natural) e vence a PROCEDURE do .prg; chamar Log("texto")
* estoura dentro do TRY, o CATCH loga chamando Log() de novo e o processo
* PENDURA sem gravar nada alem da 1a linha.
* As FUNCTION/PROCEDURE ficam no FIM: em .prg o main termina na primeira delas.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC gcL301M, goForm, goGrd, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_mtz301.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

gcL301M = "C:\4c\automation\probe_erro301_mtz.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL301M)

LOCAL loc_oE

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "mtzBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formmtz.prg") ADDITIVE
    LogP301("B: deps carregadas")

    go_4c_Sistema = CREATEOBJECT("Empty")
    ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")

    goForm = CREATEOBJECT("Formmtz")
    LogP301("C: CREATEOBJECT -> VARTYPE=" + VARTYPE(goForm))
    goGrd = goForm.pgf_4c_Paginas.Page2.grd_4c_Dados
    LogP301("   " + Est301())

    *-- PASSO 1 - INCLUIR: cria o cursor e liga a grade
    LogP301("D: --- INCLUIR ---")
    LogP301("   CriarCursorDetalheVazio = " + ;
        TRANSFORM(goForm.this_oBusinessObject.CriarCursorDetalheVazio("999")))
    goForm.this_cModoAtual = "INCLUIR"
    Ligar301()
    LogP301("   " + Est301())

    *-- PASSO 2 - ALTERAR: o CarregarDetalhe FECHA o alias e recria com SQLEXEC.
    *-- Sem banco, reproduzo o efeito: USE IN + recriar no formato do SELECT
    *-- (ChkValida NUMERICO).
    LogP301("E: --- ALTERAR (CarregarDetalhe fecha o alias) ---")
    IF USED("cursor_4c_MtI")
        USE IN cursor_4c_MtI
    ENDIF
    LogP301("   apos USE IN -> ColumnCount=" + TRANSFORM(goGrd.ColumnCount))
    CREATE CURSOR cursor_4c_MtI (Codigo C(3), CidChaves C(20), Grupos C(10), Contas C(10), ;
        Val_Jan N(14,2), Val_Fev N(14,2), Val_Mar N(14,2), Val_Abr N(14,2), ;
        Val_Mai N(14,2), Val_Jun N(14,2), Val_Jul N(14,2), Val_Ago N(14,2), ;
        Val_Set N(14,2), Val_Out N(14,2), Val_Nov N(14,2), Val_Dez N(14,2), ;
        Acm_Jan N(14,2), Acm_Fev N(14,2), Acm_Mar N(14,2), Acm_Abr N(14,2), ;
        Acm_Mai N(14,2), Acm_Jun N(14,2), Acm_Jul N(14,2), Acm_Ago N(14,2), ;
        Acm_Set N(14,2), Acm_Out N(14,2), Acm_Nov N(14,2), Acm_Dez N(14,2), ;
        Total N(18,2), ChkValida N(1,0))
    INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, Val_Jan, ChkValida) ;
        VALUES ("999", LEFT(fUniqueIds(), 20), "11101", "1110100001", 10, 1)
    GO TOP
    goForm.this_cModoAtual = "ALTERAR"
    Ligar301()
    LogP301("   " + Est301())

    *-- PASSO 3 - segunda ida e volta, para provar idempotencia
    LogP301("F: --- 2a volta (Visualizar) ---")
    IF USED("cursor_4c_MtI")
        USE IN cursor_4c_MtI
    ENDIF
    LogP301("   CriarCursorDetalheVazio = " + ;
        TRANSFORM(goForm.this_oBusinessObject.CriarCursorDetalheVazio("888")))
    goForm.this_cModoAtual = "VISUALIZAR"
    Ligar301()
    LogP301("   " + Est301())

    *-- PASSO 4 - os metodos com ColumnCount zerado nao podem estourar
    LogP301("G: --- guarda de ColumnCount ---")
    IF USED("cursor_4c_MtI")
        USE IN cursor_4c_MtI
    ENDIF
    LogP301("   ColumnCount=" + TRANSFORM(goGrd.ColumnCount))
    goForm.FormatarGradeDetalhe()
    goForm.InstalarCelulaValida(goGrd)
    goForm.InstalarCelulasCentroCusto(goGrd)
    LogP301("   os tres metodos rodaram sem estourar com ColumnCount=" + ;
        TRANSFORM(goGrd.ColumnCount))

    goForm.Release()
    LogP301("H: Release OK")

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " | Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), gcL301M, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), gcL301M, 1)
ELSE
    STRTOFILE("DIALOGOS: nenhum" + CHR(13) + CHR(10), gcL301M, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL301M, 1)
QUIT

PROCEDURE LogP301(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL301M, 1)
ENDPROC

*-- Reproduz o miolo do AlternarGradeDetalhe (que eh PROTECTED)
PROCEDURE Ligar301()
    goGrd.ColumnCount  = 28
    goGrd.RecordSource = "cursor_4c_MtI"
    goGrd.Column1.ControlSource  = "cursor_4c_MtI.Grupos"
    goGrd.Column2.ControlSource  = "cursor_4c_MtI.Contas"
    goGrd.Column28.ControlSource = "cursor_4c_MtI.ChkValida"
    goGrd.FontName = "Tahoma"
    goGrd.FontSize = 8
    goForm.FormatarGradeDetalhe()
ENDPROC

FUNCTION Est301()
    LOCAL lcR
    lcR = "ColumnCount=" + TRANSFORM(goGrd.ColumnCount)
    IF goGrd.ColumnCount >= 28
        lcR = lcR + " | C28 chk=" + TRANSFORM(PEMSTATUS(goGrd.Column28, "chk_4c_Check1", 5)) + ;
              " cc=[" + goGrd.Column28.CurrentControl + "]" + ;
              " W=" + TRANSFORM(goGrd.Column28.Width) + ;
              " | C1 cc=[" + goGrd.Column1.CurrentControl + "]" + ;
              " C2 cc=[" + goGrd.Column2.CurrentControl + "]" + ;
              " | C16.W=" + TRANSFORM(goGrd.Column16.Width)
    ENDIF
    RETURN lcR
ENDFUNC
