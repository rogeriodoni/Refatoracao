* ProbeF4SigOpTrf814.prg
* Instancia FormSigOpTrf (Fase 4) e grava o estado das 2 grades + 5
* botoes + chamada de CarregarLista (sem conexao - prova do caminho
* gracioso) num TXT. Mesma abordagem do ProbeF3SigOpTrf814.prg: nao
* roda config.prg (SQL Server inacessivel nesta maquina), so carrega as
* classes base e as globais que o Form/BO leem.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f4_sigoptrf814.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_oFormPaiFake, loc_lCarregou
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpTrfBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpTrf.prg" ADDITIVE

    loc_oFormPaiFake = CREATEOBJECT("Form")
    loc_oFormPaiFake.Enabled = .F.

    loc_oForm = CREATEOBJECT("FormSigOpTrf", loc_oFormPaiFake, "001234", 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_cSaida = "OK: FormSigOpTrf instanciado" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "ControlCount=[" + TRANSFORM(loc_oForm.ControlCount) + "]" + CHR(13) + CHR(10)

        *-- grd_4c_Operacoes (GradeOpe)
        IF PEMSTATUS(loc_oForm, "grd_4c_Operacoes", 5)
            WITH loc_oForm.grd_4c_Operacoes
                loc_cSaida = loc_cSaida + "grd_4c_Operacoes: Top=[" + TRANSFORM(.Top) + ;
                    "] Left=[" + TRANSFORM(.Left) + "] Width=[" + TRANSFORM(.Width) + ;
                    "] Height=[" + TRANSFORM(.Height) + "] ColumnCount=[" + TRANSFORM(.ColumnCount) + ;
                    "] RecordMark=[" + TRANSFORM(.RecordMark) + "]" + CHR(13) + CHR(10)
                loc_cSaida = loc_cSaida + "grd_4c_Operacoes.Column1: Width=[" + TRANSFORM(.Column1.Width) + ;
                    "] Header=[" + .Column1.Header1.Caption + "] ReadOnly=[" + TRANSFORM(.Column1.ReadOnly) + ;
                    "]" + CHR(13) + CHR(10)
            ENDWITH
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: grd_4c_Operacoes nao existe" + CHR(13) + CHR(10)
        ENDIF

        *-- grd_4c_Itens (GradePro)
        IF PEMSTATUS(loc_oForm, "grd_4c_Itens", 5)
            WITH loc_oForm.grd_4c_Itens
                loc_cSaida = loc_cSaida + "grd_4c_Itens: Top=[" + TRANSFORM(.Top) + ;
                    "] Left=[" + TRANSFORM(.Left) + "] Width=[" + TRANSFORM(.Width) + ;
                    "] Height=[" + TRANSFORM(.Height) + "] ColumnCount=[" + TRANSFORM(.ColumnCount) + ;
                    "]" + CHR(13) + CHR(10)
                loc_cSaida = loc_cSaida + "grd_4c_Itens.Column1(Produto): Width=[" + TRANSFORM(.Column1.Width) + ;
                    "] Header=[" + .Column1.Header1.Caption + "] ReadOnly=[" + TRANSFORM(.Column1.ReadOnly) + ;
                    "] MaxLength=[" + TRANSFORM(.Column1.Text1.MaxLength) + "]" + CHR(13) + CHR(10)
                loc_cSaida = loc_cSaida + "grd_4c_Itens.Column2(Descricao): Width=[" + TRANSFORM(.Column2.Width) + ;
                    "] Header=[" + .Column2.Header1.Caption + "] ReadOnly=[" + TRANSFORM(.Column2.ReadOnly) + ;
                    "] MaxLength=[" + TRANSFORM(.Column2.Text1.MaxLength) + "]" + CHR(13) + CHR(10)
            ENDWITH
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: grd_4c_Itens nao existe" + CHR(13) + CHR(10)
        ENDIF

        *-- Shape1
        IF PEMSTATUS(loc_oForm, "shp_4c_Shape1", 5)
            loc_cSaida = loc_cSaida + "shp_4c_Shape1: Top=[" + TRANSFORM(loc_oForm.shp_4c_Shape1.Top) + ;
                "] Left=[" + TRANSFORM(loc_oForm.shp_4c_Shape1.Left) + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: shp_4c_Shape1 nao existe" + CHR(13) + CHR(10)
        ENDIF

        *-- Os 5 botoes
        LOCAL loc_aBotoes(5), loc_nI, loc_cNomeBtn
        loc_aBotoes(1) = "cmd_4c_CmdSair"
        loc_aBotoes(2) = "cmd_4c_CmdInserir"
        loc_aBotoes(3) = "cmd_4c_CmdExcluir"
        loc_aBotoes(4) = "cmd_4c_Command2"
        loc_aBotoes(5) = "cmd_4c_Command1"

        FOR loc_nI = 1 TO 5
            loc_cNomeBtn = loc_aBotoes(loc_nI)
            IF PEMSTATUS(loc_oForm, loc_cNomeBtn, 5)
                loc_cSaida = loc_cSaida + loc_cNomeBtn + ": Top=[" + TRANSFORM(EVALUATE("loc_oForm." + loc_cNomeBtn + ".Top")) + ;
                    "] Left=[" + TRANSFORM(EVALUATE("loc_oForm." + loc_cNomeBtn + ".Left")) + ;
                    "] Width=[" + TRANSFORM(EVALUATE("loc_oForm." + loc_cNomeBtn + ".Width")) + ;
                    "] Height=[" + TRANSFORM(EVALUATE("loc_oForm." + loc_cNomeBtn + ".Height")) + ;
                    "] Caption=[" + EVALUATE("loc_oForm." + loc_cNomeBtn + ".Caption") + ;
                    "] Visible=[" + TRANSFORM(EVALUATE("loc_oForm." + loc_cNomeBtn + ".Visible")) + ;
                    "]" + CHR(13) + CHR(10)
            ELSE
                loc_cSaida = loc_cSaida + "FALHA: " + loc_cNomeBtn + " nao existe" + CHR(13) + CHR(10)
            ENDIF
        ENDFOR

        *-- CarregarLista sem conexao (gnConnHandle indefinido) - prova do
        *-- caminho gracioso (sem exception, sem travar)
        loc_lCarregou = loc_oForm.CarregarLista()
        loc_cSaida = loc_cSaida + "CarregarListaSemConexao=[" + TRANSFORM(loc_lCarregou) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_cMensagemErro=[" + loc_oForm.this_cMensagemErro + "]" + CHR(13) + CHR(10)

        loc_oForm.Release()
        loc_cSaida = loc_cSaida + "PaiReabilitadoAposRelease=[" + TRANSFORM(loc_oFormPaiFake.Enabled) + "]" + CHR(13) + CHR(10)
        loc_oFormPaiFake.Release()
    ELSE
        loc_cSaida = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "ERRO: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f4_sigoptrf814.txt")

QUIT
