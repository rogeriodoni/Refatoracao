*-- Probe de instanciacao de FormSigOpPdt (task784, Fase 4).
*-- Carrega SO as dependencias do form - ConfigurarAmbiente() BLOQUEIA nesta
*-- maquina. gnConnHandle = 0 de proposito: CarregarLista detecta "sem
*-- conexao" e NAO emite SQL (o SQL Server 192.168.200.10 eh inalcancavel
*-- aqui e penduraria o processo).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "PROBE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_pdt784.txt"

#DEFINE SAIDA "C:\4c\automation\probe_pdt784f4.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_oE
STRTOFILE("A: inicio" + CHR(13) + CHR(10), SAIDA)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), SAIDA, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpPdtBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpPdt.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), SAIDA, 1)

    STRTOFILE(Exercitar() + CHR(13) + CHR(10), SAIDA, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
        " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), SAIDA, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), SAIDA, 1)
ENDIF

STRTOFILE("Z: fim" + CHR(13) + CHR(10), SAIDA, 1)
QUIT

FUNCTION Exercitar()
    LOCAL loc_oForm, loc_cOut, loc_oE2, loc_oGrid, loc_nI

    loc_cOut = ""
    TRY
        loc_oForm = CREATEOBJECT("FormSigOpPdt")

        IF VARTYPE(loc_oForm) != "O"
            RETURN "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
        ENDIF

        loc_cOut = "Init OK | Caption=[" + loc_oForm.Caption + "]" + ;
            " WxH=" + TRANSFORM(loc_oForm.Width) + "x" + TRANSFORM(loc_oForm.Height) + ;
            " OpEscolha=[" + loc_oForm.this_cOpEscolha + "]" + CHR(13) + CHR(10)

        *-- Grade
        loc_oGrid = loc_oForm.grd_4c_Dados
        loc_cOut = loc_cOut + "GRADE Cols=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
            " RecSrc=[" + loc_oGrid.RecordSource + "]" + ;
            " Top/Left/W/H=" + TRANSFORM(loc_oGrid.Top) + "/" + TRANSFORM(loc_oGrid.Left) + ;
            "/" + TRANSFORM(loc_oGrid.Width) + "/" + TRANSFORM(loc_oGrid.Height) + CHR(13) + CHR(10)

        FOR loc_nI = 1 TO loc_oGrid.ColumnCount
            loc_cOut = loc_cOut + "  Col" + TRANSFORM(loc_nI) + ;
                " W=" + TRANSFORM(loc_oGrid.Columns(loc_nI).Width) + ;
                " Src=[" + loc_oGrid.Columns(loc_nI).ControlSource + "]" + ;
                " CurCtl=[" + loc_oGrid.Columns(loc_nI).CurrentControl + "]" + ;
                " RO=" + TRANSFORM(loc_oGrid.Columns(loc_nI).ReadOnly) + ;
                " Hdr=[" + loc_oGrid.Columns(loc_nI).Header1.Caption + "]" + CHR(13) + CHR(10)
        ENDFOR

        loc_cOut = loc_cOut + "  Check1 existe=" + ;
            TRANSFORM(PEMSTATUS(loc_oGrid.Column1, "Check1", 5)) + ;
            " Sparse1=" + TRANSFORM(loc_oGrid.Column1.Sparse) + CHR(13) + CHR(10)

        *-- Botoes
        loc_cOut = loc_cOut + "SelTudo Vis=" + TRANSFORM(loc_oForm.cmd_4c_SelTudo.Visible) + ;
            " T/L=" + TRANSFORM(loc_oForm.cmd_4c_SelTudo.Top) + "/" + TRANSFORM(loc_oForm.cmd_4c_SelTudo.Left) + ;
            " Pic=" + TRANSFORM(FILE(loc_oForm.cmd_4c_SelTudo.Picture)) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "Apaga   Vis=" + TRANSFORM(loc_oForm.cmd_4c_Apaga.Visible) + ;
            " T/L=" + TRANSFORM(loc_oForm.cmd_4c_Apaga.Top) + "/" + TRANSFORM(loc_oForm.cmd_4c_Apaga.Left) + ;
            " Pic=" + TRANSFORM(FILE(loc_oForm.cmd_4c_Apaga.Picture)) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "Ok      Vis=" + TRANSFORM(loc_oForm.cmd_4c_Ok.Visible) + ;
            " Cap=[" + loc_oForm.cmd_4c_Ok.Caption + "]" + ;
            " Cancel=" + TRANSFORM(loc_oForm.cmd_4c_Ok.Cancel) + ;
            " Pic=" + TRANSFORM(FILE(loc_oForm.cmd_4c_Ok.Picture)) + CHR(13) + CHR(10)

        *-- Metodos que o harness chama de FORA da classe (tem de ser PUBLIC)
        loc_cOut = loc_cOut + "CarregarLista=" + TRANSFORM(loc_oForm.CarregarLista()) + CHR(13) + CHR(10)
        loc_oForm.AjustarBotoesPorModo()
        loc_cOut = loc_cOut + "AjustarBotoesPorModo OK" + CHR(13) + CHR(10)

        *-- Handlers dos botoes com o cursor placeholder VAZIO (sem conexao):
        *-- provam que o laco nao estoura em grade vazia.
        loc_oForm.BtnSelTudoClick()
        loc_oForm.BtnApagaClick()
        loc_cOut = loc_cOut + "BtnSelTudoClick/BtnApagaClick OK (grade vazia)" + CHR(13) + CHR(10)

        *-- Modo != INSERIR: os dois botoes tem de ficar invisiveis
        loc_oForm.this_cOpEscolha = "VISUALIZAR"
        loc_oForm.AjustarBotoesPorModo()
        loc_cOut = loc_cOut + "modo VISUALIZAR -> SelTudo.Visible=" + ;
            TRANSFORM(loc_oForm.cmd_4c_SelTudo.Visible) + ;
            " Apaga.Visible=" + TRANSFORM(loc_oForm.cmd_4c_Apaga.Visible) + ;
            " Ok.Visible=" + TRANSFORM(loc_oForm.cmd_4c_Ok.Visible) + CHR(13) + CHR(10)

        loc_oForm.Release()
    CATCH TO loc_oE2
        loc_cOut = loc_cOut + "EXCEPTION Exercitar: " + loc_oE2.Message + ;
            " Linha:" + TRANSFORM(loc_oE2.LineNo) + " Proc:" + loc_oE2.Procedure
    ENDTRY

    RETURN loc_cOut
ENDFUNC
