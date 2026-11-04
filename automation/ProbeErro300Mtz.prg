*==============================================================================
* ProbeErro300Mtz.prg - Erro300. O SalvarDetalhe monta o SQL numa LOCAL, entao
* a conferencia da LISTA de colunas eh textual (schema x INSERT, feita fora).
* Aqui se prova o que so runtime responde:
*   1) o SCAN le Acm_Jan..Acm_Dez e ChkValida nas DUAS formas de cursor que o
*      BO produz (CriarCursorDetalheVazio = Logico, CarregarDetalhe = Numerico)
*      sem estourar "Variable ACM_xxx is not found"
*   2) ConverterParaLogico cobre Logico / Numerico / NULL / Character
*   3) fUniqueIds() cabe em cidchaves char(20) e nao repete
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_mtz300.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

PUBLIC gcLog300, go_4c_Sistema
gcLog300 = "C:\4c\automation\probe_erro300_mtz.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLog300)

LOCAL loc_oE, loc_oBO, loc_nI, loc_cK1, loc_cK2, loc_lRet

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "mtzBO.prg")        ADDITIVE
    Log300("B: deps carregadas")

    go_4c_Sistema = CREATEOBJECT("Empty")
    ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")

    loc_cK1 = fUniqueIds()
    loc_cK2 = fUniqueIds()
    Log300("C: fUniqueIds() = [" + loc_cK1 + "] LEN=" + TRANSFORM(LEN(loc_cK1)) + ;
           "  (cidchaves eh char(20)) | cabe? " + TRANSFORM(LEN(ALLTRIM(loc_cK1)) <= 20) + ;
           " | 2a chamada difere? " + TRANSFORM(loc_cK1 != loc_cK2))

    Log300("D: ConverterParaLogico -> .T./" + TRANSFORM(ConverterParaLogico(.T.)) + ;
           "  .F./" + TRANSFORM(ConverterParaLogico(.F.)) + ;
           "  1/" + TRANSFORM(ConverterParaLogico(1)) + ;
           "  0/" + TRANSFORM(ConverterParaLogico(0)) + ;
           "  NULL/" + TRANSFORM(ConverterParaLogico(.NULL.)) + ;
           "  'S'/" + TRANSFORM(ConverterParaLogico("S")))

    loc_oBO = CREATEOBJECT("mtzBOEspiao")
    Log300("E: BO espiao -> VARTYPE=" + VARTYPE(loc_oBO))

    *-- (a) cursor como o CriarCursorDetalheVazio cria: ChkValida LOGICO
    Log300("F: --- cursor do INCLUIR (ChkValida Logico) ---")
    Log300("   CriarCursorDetalheVazio = " + ;
           TRANSFORM(loc_oBO.CriarCursorDetalheVazio("999")))
    SELECT cursor_4c_MtI
    Log300("   CidChaves=[" + ALLTRIM(CidChaves) + "] LEN=" + ;
           TRANSFORM(LEN(ALLTRIM(CidChaves))) + ;
           " | VARTYPE(ChkValida)=" + VARTYPE(ChkValida) + ;
           " | FCOUNT=" + TRANSFORM(FCOUNT("cursor_4c_MtI")))
    REPLACE Grupos WITH "11101", Contas WITH "1110100002", ;
            Val_Jan WITH 10, Val_Fev WITH 10, Val_Mar WITH 10, ;
            ChkValida WITH .T. IN cursor_4c_MtI
    loc_lRet = loc_oBO.ExporSalvarDetalhe("999", .T.)
    Log300("   SalvarDetalhe = " + TRANSFORM(loc_lRet) + ;
           "  (esperado .F.: SQLEXEC com handle 0; o que importa eh NAO estourar)")

    *-- (b) cursor como o CarregarDetalhe traz: ChkValida NUMERICO
    Log300("G: --- cursor do ALTERAR (ChkValida Numerico) ---")
    IF USED("cursor_4c_MtI")
        USE IN cursor_4c_MtI
    ENDIF
    CREATE CURSOR cursor_4c_MtI (Codigo C(3), CidChaves C(20), Grupos C(10), Contas C(10), ;
        Val_Jan N(14,2), Val_Fev N(14,2), Val_Mar N(14,2), Val_Abr N(14,2), ;
        Val_Mai N(14,2), Val_Jun N(14,2), Val_Jul N(14,2), Val_Ago N(14,2), ;
        Val_Set N(14,2), Val_Out N(14,2), Val_Nov N(14,2), Val_Dez N(14,2), ;
        Acm_Jan N(14,2), Acm_Fev N(14,2), Acm_Mar N(14,2), Acm_Abr N(14,2), ;
        Acm_Mai N(14,2), Acm_Jun N(14,2), Acm_Jul N(14,2), Acm_Ago N(14,2), ;
        Acm_Set N(14,2), Acm_Out N(14,2), Acm_Nov N(14,2), Acm_Dez N(14,2), ;
        Total N(18,2), ChkValida N(1,0))
    INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, Acm_Jan, ChkValida) ;
        VALUES ("999", LEFT(fUniqueIds(), 20), "22202", "2220100001", 77.5, 1)
    GO TOP
    Log300("   VARTYPE(ChkValida)=" + VARTYPE(ChkValida) + " valor=" + TRANSFORM(ChkValida) + ;
           " | Acm_Jan=" + TRANSFORM(Acm_Jan))
    loc_lRet = loc_oBO.ExporSalvarDetalhe("999", .T.)
    Log300("   SalvarDetalhe = " + TRANSFORM(loc_lRet))

    *-- (c) cursor SEM as colunas Acm_* (forma antiga) - tem de ACUSAR, provando
    *-- que o SCAN realmente le essas colunas agora
    Log300("H: --- cursor SEM Acm_* (controle negativo) ---")
    IF USED("cursor_4c_MtI")
        USE IN cursor_4c_MtI
    ENDIF
    CREATE CURSOR cursor_4c_MtI (Codigo C(3), CidChaves C(20), Grupos C(10), Contas C(10), ;
        Val_Jan N(14,2), Val_Fev N(14,2), Val_Mar N(14,2), Val_Abr N(14,2), ;
        Val_Mai N(14,2), Val_Jun N(14,2), Val_Jul N(14,2), Val_Ago N(14,2), ;
        Val_Set N(14,2), Val_Out N(14,2), Val_Nov N(14,2), Val_Dez N(14,2), ;
        ChkValida L)
    INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas) ;
        VALUES ("999", LEFT(fUniqueIds(), 20), "33303", "3330100001")
    GO TOP
    loc_lRet = loc_oBO.ExporSalvarDetalhe("999", .T.)
    Log300("   SalvarDetalhe = " + TRANSFORM(loc_lRet) + ;
           " (esperado .F. com erro de variavel - o SCAN LE mesmo os Acm_*)")

CATCH TO loc_oE
    Log300("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
           " | Proc:" + loc_oE.Procedure)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    Log300("DIALOGOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    Log300("DIALOGOS: nenhum")
ENDIF
Log300("Z: fim")
QUIT

PROCEDURE Log300(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcLog300, 1)
ENDPROC

*-- Subclasse so de teste: Init vazio (o Init do mtzBO tenta conectar e trava o
*-- VFP headless) + wrapper PUBLIC para o SalvarDetalhe, que eh PROTECTED.
DEFINE CLASS mtzBOEspiao AS mtzBO
    PROCEDURE Init()
        RETURN .T.
    ENDPROC

    PROCEDURE ExporSalvarDetalhe(par_cCodigo, par_lSomenteInserir)
        RETURN THIS.SalvarDetalhe(par_cCodigo, par_lSomenteInserir)
    ENDPROC
ENDDEFINE
