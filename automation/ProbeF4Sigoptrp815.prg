* ProbeF4Sigoptrp815.prg
* Instancia FormSigoptrp (Fase 4) e grava o estado da grade + botoes num TXT.
* NAO roda config.prg: o SQL Server do ambiente nao esta acessivel nesta
* maquina. gb_4c_ValidandoUI pula CarregarLista (SQLEXEC) - a grade fica
* vazia, mas ja formatada por AplicarFormatoGrade.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f4_sigoptrp815.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_oGrid, loc_oFormPaiFake
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SigoptrpBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigoptrp.prg" ADDITIVE

    loc_oFormPaiFake = CREATEOBJECT("Form")
    loc_oFormPaiFake.Enabled = .F.

    loc_oForm = CREATEOBJECT("FormSigoptrp", loc_oFormPaiFake, "001234", 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_cSaida = "OK: FormSigoptrp instanciado" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "ControlCount=[" + TRANSFORM(loc_oForm.ControlCount) + "]" + CHR(13) + CHR(10)

        IF PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)
            loc_oGrid = loc_oForm.grd_4c_Dados
            loc_cSaida = loc_cSaida + "grd_4c_Dados: Visible=[" + TRANSFORM(loc_oGrid.Visible) + ;
                "] ColumnCount=[" + TRANSFORM(loc_oGrid.ColumnCount) + ;
                "] Top=[" + TRANSFORM(loc_oGrid.Top) + "] Left=[" + TRANSFORM(loc_oGrid.Left) + ;
                "] Width=[" + TRANSFORM(loc_oGrid.Width) + "] Height=[" + TRANSFORM(loc_oGrid.Height) + ;
                "]" + CHR(13) + CHR(10)
            loc_cSaida = loc_cSaida + "Column1: Width=[" + TRANSFORM(loc_oGrid.Column1.Width) + ;
                "] ReadOnly=[" + TRANSFORM(loc_oGrid.Column1.ReadOnly) + ;
                "] Header=[" + loc_oGrid.Column1.Header1.Caption + "]" + CHR(13) + CHR(10)
            loc_cSaida = loc_cSaida + "Column2: Width=[" + TRANSFORM(loc_oGrid.Column2.Width) + ;
                "] ReadOnly=[" + TRANSFORM(loc_oGrid.Column2.ReadOnly) + ;
                "] Header=[" + loc_oGrid.Column2.Header1.Caption + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: grd_4c_Dados nao existe" + CHR(13) + CHR(10)
        ENDIF

        IF PEMSTATUS(loc_oForm, "cmd_4c_CmdInserir", 5)
            loc_cSaida = loc_cSaida + "cmd_4c_CmdInserir: Visible=[" + TRANSFORM(loc_oForm.cmd_4c_CmdInserir.Visible) + ;
                "] Left=[" + TRANSFORM(loc_oForm.cmd_4c_CmdInserir.Left) + ;
                "] Caption=[" + loc_oForm.cmd_4c_CmdInserir.Caption + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: cmd_4c_CmdInserir nao existe" + CHR(13) + CHR(10)
        ENDIF

        IF PEMSTATUS(loc_oForm, "cmd_4c_CmdExcluir", 5)
            loc_cSaida = loc_cSaida + "cmd_4c_CmdExcluir: Visible=[" + TRANSFORM(loc_oForm.cmd_4c_CmdExcluir.Visible) + ;
                "] Left=[" + TRANSFORM(loc_oForm.cmd_4c_CmdExcluir.Left) + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: cmd_4c_CmdExcluir nao existe" + CHR(13) + CHR(10)
        ENDIF

        IF PEMSTATUS(loc_oForm, "cmd_4c_CmdSair", 5)
            loc_cSaida = loc_cSaida + "cmd_4c_CmdSair: Visible=[" + TRANSFORM(loc_oForm.cmd_4c_CmdSair.Visible) + ;
                "] Left=[" + TRANSFORM(loc_oForm.cmd_4c_CmdSair.Left) + ;
                "] Caption=[" + loc_oForm.cmd_4c_CmdSair.Caption + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: cmd_4c_CmdSair nao existe" + CHR(13) + CHR(10)
        ENDIF

        IF PEMSTATUS(loc_oForm, "cmd_4c_Cancela", 5)
            loc_cSaida = loc_cSaida + "cmd_4c_Cancela: Visible=[" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Visible) + ;
                "] Left=[" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Left) + ;
                "] Cancel=[" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Cancel) + ;
                "] Caption=[" + loc_oForm.cmd_4c_Cancela.Caption + "]" + CHR(13) + CHR(10)

            *-- Right edge: 725 + 75 = 800 = Form.Width
            loc_cSaida = loc_cSaida + "BordaDireita=[" + ;
                TRANSFORM(loc_oForm.cmd_4c_Cancela.Left + loc_oForm.cmd_4c_Cancela.Width) + ;
                "] FormWidth=[" + TRANSFORM(loc_oForm.Width) + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: cmd_4c_Cancela nao existe" + CHR(13) + CHR(10)
        ENDIF

        *-- Exercita CarregarLista explicitamente (modo teste pula na
        *-- inicializacao) - sem conexao, deve devolver .F. SEM estourar
        loc_cSaida = loc_cSaida + "CarregarListaSemConexao=[" + TRANSFORM(loc_oForm.CarregarLista()) + "]" + CHR(13) + CHR(10)

        loc_oForm.Release()
        loc_oFormPaiFake.Release()
    ELSE
        loc_cSaida = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "ERRO: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f4_sigoptrp815.txt")

QUIT
