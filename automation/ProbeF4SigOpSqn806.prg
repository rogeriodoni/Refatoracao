* ProbeF4SigOpSqn806.prg
* Fase 4 / task806 - prova que FormSigOpSqn INSTANCIA com a grade e os botoes
* criados, e que CarregarDados traz LINHA de verdade (regra #42: conferir
* RECCOUNT, nao o retorno .T.).
*
* NAO chama ConfigurarAmbiente() - ele nao retorna nesta maquina e o probe
* morreria por timeout antes do CREATEOBJECT. Carrega a mao so o que este
* form usa.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cRel, loc_oForm, loc_cOpe, loc_nRecs, loc_oErro, loc_oGrd, loc_cConn

loc_cOut = "C:\4c\automation\_f4sqn_probe.txt"
loc_cRel = "CHECKPOINT 1 - script vivo" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f4sqn_erros.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "PROBE"

CD C:\4c\projeto\app\start
DO config.prg

loc_cRel = loc_cRel + "CHECKPOINT 2 - config.prg OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpSqnBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpSqn.prg") ADDITIVE

loc_cRel = loc_cRel + "CHECKPOINT 3 - SET PROCEDURE OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*-- Conexao real (SQL Server alcancavel nesta sessao) - eh o que permite
*-- provar que a grade recebe LINHA, nao so que o form abre
loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@"
gnConnHandle = SQLSTRINGCONNECT(loc_cConn)

loc_cRel = loc_cRel + "CHECKPOINT 4 - gnConnHandle = " + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*-- Escolhe uma operacao-pai que REALMENTE tenha sequencia gravada
loc_cOpe = ""
IF gnConnHandle > 0
    IF SQLEXEC(gnConnHandle, "SELECT TOP 1 cdopes, COUNT(*) AS qtd FROM SigMvCxs " + ;
            "GROUP BY cdopes ORDER BY COUNT(*) DESC", "cur_ope") > 0
        IF RECCOUNT("cur_ope") > 0
            SELECT cur_ope
            GO TOP
            loc_cOpe = ALLTRIM(cur_ope.cdopes)
            loc_cRel = loc_cRel + "OPERACAO ESCOLHIDA = [" + loc_cOpe + "]  linhas em SigMvCxs = " + ;
                TRANSFORM(cur_ope.qtd) + CHR(13) + CHR(10)
        ENDIF
        USE IN cur_ope
    ENDIF
ENDIF
STRTOFILE(loc_cRel, loc_cOut)

TRY
    loc_oForm = CREATEOBJECT("FormSigOpSqn", .NULL., loc_cOpe, "ALTERAR", 1)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cRel = loc_cRel + "VARTYPE(loc_oForm) = [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

IF VARTYPE(loc_oForm) = "O"
    loc_cRel = loc_cRel + "Caption = [" + loc_oForm.Caption + "]" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "Form WxH = " + TRANSFORM(loc_oForm.Width) + "x" + ;
        TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "--- GRADE" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  grd_4c_Dados existe = " + ;
        IIF(PEMSTATUS(loc_oForm, "grd_4c_Dados", 5), "SIM", "NAO") + CHR(13) + CHR(10)

    IF PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)
        loc_oGrd = loc_oForm.grd_4c_Dados
        loc_cRel = loc_cRel + "  Top/Left/W/H = " + TRANSFORM(loc_oGrd.Top) + "/" + ;
            TRANSFORM(loc_oGrd.Left) + "/" + TRANSFORM(loc_oGrd.Width) + "/" + ;
            TRANSFORM(loc_oGrd.Height) + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "  ColumnCount = " + TRANSFORM(loc_oGrd.ColumnCount) + ;
            "  Visible = " + TRANSFORM(loc_oGrd.Visible) + ;
            "  RecordMark = " + TRANSFORM(loc_oGrd.RecordMark) + ;
            "  DeleteMark = " + TRANSFORM(loc_oGrd.DeleteMark) + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "  RecordSource = [" + loc_oGrd.RecordSource + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "  Col1 CS=[" + loc_oGrd.Column1.ControlSource + "] W=" + ;
            TRANSFORM(loc_oGrd.Column1.Width) + " Hdr=[" + loc_oGrd.Column1.Header1.Caption + ;
            "] RO=" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + ;
            " MaxLen=" + TRANSFORM(loc_oGrd.Column1.Text1.MaxLength) + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "  Col2 CS=[" + loc_oGrd.Column2.ControlSource + "] W=" + ;
            TRANSFORM(loc_oGrd.Column2.Width) + " Hdr=[" + loc_oGrd.Column2.Header1.Caption + ;
            "] RO=" + TRANSFORM(loc_oGrd.Column2.ReadOnly) + ;
            " Mask=[" + loc_oGrd.Column2.InputMask + "]" + CHR(13) + CHR(10)
    ENDIF

    loc_cRel = loc_cRel + "--- CURSOR DA GRADE" + CHR(13) + CHR(10)
    IF USED("cursor_4c_Sequencias")
        loc_nRecs = RECCOUNT("cursor_4c_Sequencias")
        loc_cRel = loc_cRel + "  cursor_4c_Sequencias RECCOUNT = " + TRANSFORM(loc_nRecs) + ;
            "  Buffering = " + TRANSFORM(CURSORGETPROP("Buffering", "cursor_4c_Sequencias")) + ;
            "  ReadOnly = " + TRANSFORM(ISREADONLY("cursor_4c_Sequencias")) + CHR(13) + CHR(10)
        IF loc_nRecs > 0
            SELECT cursor_4c_Sequencias
            GO TOP
            loc_cRel = loc_cRel + "  1a linha: cdopes=[" + ALLTRIM(cdopes) + "] cnivels=[" + ;
                ALLTRIM(cnivels) + "] seqs=" + TRANSFORM(seqs) + CHR(13) + CHR(10)
        ENDIF

        *-- Estrutura do cursor: prova que os ControlSource da grade apontam
        *-- para campo que EXISTE (vale mesmo com a tabela vazia)
        LOCAL ARRAY loc_aCampos[1]
        SELECT cursor_4c_Sequencias
        =AFIELDS(loc_aCampos)
        loc_cRel = loc_cRel + "  campos do cursor:"
        FOR loc_nRecs = 1 TO ALEN(loc_aCampos, 1)
            loc_cRel = loc_cRel + " " + LOWER(ALLTRIM(loc_aCampos[loc_nRecs, 1])) + ;
                "(" + loc_aCampos[loc_nRecs, 2] + TRANSFORM(loc_aCampos[loc_nRecs, 3]) + ")"
        ENDFOR
        loc_cRel = loc_cRel + CHR(13) + CHR(10)
    ELSE
        loc_cRel = loc_cRel + "  cursor_4c_Sequencias AUSENTE" + CHR(13) + CHR(10)
    ENDIF

    loc_cRel = loc_cRel + "--- BOTOES / SHAPE" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Inserir  L=" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Left) + ;
        " T=" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Top) + ;
        " WxH=" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Width) + "x" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Height) + ;
        " Vis=" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Visible) + ;
        " Ena=" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Enabled) + ;
        " Pic=" + IIF(FILE(loc_oForm.cmd_4c_Inserir.Picture), "OK", "AUSENTE") + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Excluir  L=" + TRANSFORM(loc_oForm.cmd_4c_Excluir.Left) + ;
        " Vis=" + TRANSFORM(loc_oForm.cmd_4c_Excluir.Visible) + ;
        " Pic=" + IIF(FILE(loc_oForm.cmd_4c_Excluir.Picture), "OK", "AUSENTE") + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Sair     L=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Left) + ;
        " Vis=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Visible) + ;
        " Cancel=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Cancel) + ;
        " Pic=" + IIF(FILE(loc_oForm.cmd_4c_Sair.Picture), "OK", "AUSENTE") + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Shape    L=" + TRANSFORM(loc_oForm.shp_4c_Separador.Left) + ;
        " W=" + TRANSFORM(loc_oForm.shp_4c_Separador.Width) + ;
        " T=" + TRANSFORM(loc_oForm.shp_4c_Separador.Top) + ;
        " H=" + TRANSFORM(loc_oForm.shp_4c_Separador.Height) + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "--- CABECALHO (fase 3)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  cnt_4c_Cabecalho T/H = " + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.Top) + ;
        "/" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.Height) + ;
        "  Titulo=[" + ALLTRIM(loc_oForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption) + "]" + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "--- CarregarDados chamado DE FORA (metodo PUBLIC)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  retorno = " + TRANSFORM(loc_oForm.CarregarDados()) + ;
        "  RECCOUNT depois = " + IIF(USED("cursor_4c_Sequencias"), ;
        TRANSFORM(RECCOUNT("cursor_4c_Sequencias")), "cursor ausente") + CHR(13) + CHR(10)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

loc_cRel = loc_cRel + "--- ARQUIVO DE ERRO DE TESTE" + CHR(13) + CHR(10)
IF FILE("C:\4c\automation\_f4sqn_erros.txt")
    loc_cRel = loc_cRel + FILETOSTR("C:\4c\automation\_f4sqn_erros.txt") + CHR(13) + CHR(10)
ELSE
    loc_cRel = loc_cRel + "  (vazio - nenhum MsgErro/MsgAviso disparado)" + CHR(13) + CHR(10)
ENDIF

loc_cRel = loc_cRel + "FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

IF gnConnHandle > 0
    =SQLDISCONNECT(gnConnHandle)
ENDIF

QUIT
