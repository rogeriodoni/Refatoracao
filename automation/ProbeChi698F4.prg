*==============================================================================
* ProbeChi698F4.prg - Instancia FormSigOpChi headless (Fase 4 / task698) e mede
* o que a fase acrescentou:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve objeto);
*   (2) as TRES grades nascem com a geometria do SCX legado;
*   (3) as duas barras de botoes existem, com ButtonCount/Left/Caption do dump
*       e .Picture apontando para arquivo que EXISTE (Picture inexistente falha
*       em SILENCIO - o botao so nao desenha icone);
*   (4) ordem de AddObject: a faixa do cabecalho vem ANTES das barras de botoes;
*   (5) escopo dos metodos chamados de fora (tem de ser PUBLIC);
*   (6) AlternarPagina troca ActivePage e o Enabled das duas Pages nos DOIS
*       sentidos (o caminho de volta reabilita o que a ida desabilitou).
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
* Nao depende de SQL Server: roda no ramo de ModoTeste do CarregarDados.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_chi698_f4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oPg2, loc_nI, loc_oBtn
loc_cOut = "C:\4c\automation\probe_chi698_f4_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpChiBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpChi.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) Init completo
    loc_oForm = CREATEOBJECT("FormSigOpChi")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_oPg2 = loc_oForm.pgf_4c_Paginas.Page2

        *-- (2) Geometria das tres grades
        STRTOFILE(CHR(13)+CHR(10)+"--- GRADES ---", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"grd_4c_Cheque    CC=" + TRANSFORM(loc_oPg2.grd_4c_Cheque.ColumnCount) + ;
            " T=" + TRANSFORM(loc_oPg2.grd_4c_Cheque.Top) + ;
            " L=" + TRANSFORM(loc_oPg2.grd_4c_Cheque.Left) + ;
            " W=" + TRANSFORM(loc_oPg2.grd_4c_Cheque.Width) + ;
            " H=" + TRANSFORM(loc_oPg2.grd_4c_Cheque.Height) + ;
            " RecMark=" + TRANSFORM(loc_oPg2.grd_4c_Cheque.RecordMark) + ;
            " Vis=" + TRANSFORM(loc_oPg2.grd_4c_Cheque.Visible), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"grd_4c_Movimenta CC=" + TRANSFORM(loc_oPg2.grd_4c_Movimenta.ColumnCount) + ;
            " T=" + TRANSFORM(loc_oPg2.grd_4c_Movimenta.Top) + ;
            " L=" + TRANSFORM(loc_oPg2.grd_4c_Movimenta.Left) + ;
            " W=" + TRANSFORM(loc_oPg2.grd_4c_Movimenta.Width) + ;
            " H=" + TRANSFORM(loc_oPg2.grd_4c_Movimenta.Height) + ;
            " RecMark=" + TRANSFORM(loc_oPg2.grd_4c_Movimenta.RecordMark) + ;
            " Vis=" + TRANSFORM(loc_oPg2.grd_4c_Movimenta.Visible), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"grd_4c_Prorrog   CC=" + TRANSFORM(loc_oPg2.grd_4c_Prorrog.ColumnCount) + ;
            " T=" + TRANSFORM(loc_oPg2.grd_4c_Prorrog.Top) + ;
            " L=" + TRANSFORM(loc_oPg2.grd_4c_Prorrog.Left) + ;
            " W=" + TRANSFORM(loc_oPg2.grd_4c_Prorrog.Width) + ;
            " H=" + TRANSFORM(loc_oPg2.grd_4c_Prorrog.Height) + ;
            " Vis=" + TRANSFORM(loc_oPg2.grd_4c_Prorrog.Visible), loc_cOut, 1)

        *-- (3) Barras de botoes + existencia do arquivo de icone
        STRTOFILE(CHR(13)+CHR(10)+"--- BOTOES ---", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"cmg_4c_Botoes BC=" + TRANSFORM(loc_oPg2.cmg_4c_Botoes.ButtonCount) + ;
            " T=" + TRANSFORM(loc_oPg2.cmg_4c_Botoes.Top) + ;
            " L=" + TRANSFORM(loc_oPg2.cmg_4c_Botoes.Left) + ;
            " W=" + TRANSFORM(loc_oPg2.cmg_4c_Botoes.Width) + ;
            " H=" + TRANSFORM(loc_oPg2.cmg_4c_Botoes.Height), loc_cOut, 1)
        FOR loc_nI = 1 TO loc_oPg2.cmg_4c_Botoes.ButtonCount
            loc_oBtn = loc_oPg2.cmg_4c_Botoes.Buttons(loc_nI)
            STRTOFILE(CHR(13)+CHR(10)+"  Btn" + TRANSFORM(loc_nI) + ;
                " L=" + TRANSFORM(loc_oBtn.Left) + " T=" + TRANSFORM(loc_oBtn.Top) + ;
                " [" + ALLTRIM(loc_oBtn.Caption) + "]" + ;
                " PicOK=" + TRANSFORM(FILE(loc_oBtn.Picture)) + ;
                " En=" + TRANSFORM(loc_oBtn.Enabled) + ;
                " Vis=" + TRANSFORM(loc_oBtn.Visible), loc_cOut, 1)
        ENDFOR
        loc_oBtn = loc_oPg2.cmg_4c_Saida.Buttons(1)
        STRTOFILE(CHR(13)+CHR(10)+"cmg_4c_Saida BC=" + TRANSFORM(loc_oPg2.cmg_4c_Saida.ButtonCount) + ;
            " L=" + TRANSFORM(loc_oPg2.cmg_4c_Saida.Left) + ;
            " W=" + TRANSFORM(loc_oPg2.cmg_4c_Saida.Width) + ;
            " Btn1=[" + ALLTRIM(loc_oBtn.Caption) + "]" + ;
            " PicOK=" + TRANSFORM(FILE(loc_oBtn.Picture)), loc_cOut, 1)

        *-- (4) Ordem de AddObject da Page2
        STRTOFILE(CHR(13)+CHR(10)+"--- ORDEM AddObject Page2 ---", loc_cOut, 1)
        FOR loc_nI = 1 TO loc_oPg2.ControlCount
            STRTOFILE(CHR(13)+CHR(10)+"  " + TRANSFORM(loc_nI) + ": " + ;
                loc_oPg2.Controls(loc_nI).Name, loc_cOut, 1)
        ENDFOR

        *-- (5) Escopo dos metodos chamados de fora (2 = Protected)
        STRTOFILE(CHR(13)+CHR(10)+"--- ESCOPO (.T. = PROTECTED = PROBLEMA) ---", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"AlternarPagina=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "AlternarPagina", 2)) + ;
            " CarregarDados=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 2)) + ;
            " AjustarBotoesHistorico=" + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesHistorico", 2)) + ;
            " RepintarGradesHistorico=" + TRANSFORM(PEMSTATUS(loc_oForm, "RepintarGradesHistorico", 2)) + ;
            " CmgSaidaClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "CmgSaidaClick", 2)), loc_cOut, 1)

        *-- (6) AlternarPagina nos dois sentidos
        STRTOFILE(CHR(13)+CHR(10)+"--- ALTERNARPAGINA ---", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"inicial  Active=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " P1En=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.Enabled) + ;
            " P2En=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.Enabled), loc_cOut, 1)
        loc_oForm.AlternarPagina(1)
        STRTOFILE(CHR(13)+CHR(10)+"apos (1) Active=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " P1En=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.Enabled) + ;
            " P2En=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.Enabled), loc_cOut, 1)
        loc_oForm.AlternarPagina(2)
        STRTOFILE(CHR(13)+CHR(10)+"apos (2) Active=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " P1En=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.Enabled) + ;
            " P2En=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.Enabled) + ;
            " Btn2En=" + TRANSFORM(loc_oPg2.cmg_4c_Botoes.Buttons(2).Enabled), loc_cOut, 1)
        loc_oForm.AlternarPagina(1)
        STRTOFILE(CHR(13)+CHR(10)+"volta(1) Active=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " P1En=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.Enabled) + ;
            " P2En=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.Enabled), loc_cOut, 1)

        *-- CarregarDados em ModoTeste devolve .F. SEM estourar
        STRTOFILE(CHR(13)+CHR(10)+"CarregarDados(modoteste)=" + ;
            TRANSFORM(loc_oForm.CarregarDados()), loc_cOut, 1)
        loc_oForm.RepintarGradesHistorico()
        STRTOFILE(CHR(13)+CHR(10)+"RepintarGradesHistorico OK", loc_cOut, 1)

        loc_oForm.Release()
    ENDIF

    STRTOFILE(CHR(13)+CHR(10)+"=== FIM OK ===", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"*** ERRO: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
