*==============================================================================
* ProbePpp666F4.prg - Instancia FormSigPrPpp headless (Fase 4 / task666) e
* mede o que a fase acrescentou:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve objeto) - "a tela abre"
*       so se prova INSTANCIANDO, porque Init de form grande falha em cadeia;
*   (2) os controles do SCX legado existem com a geometria do dump e o
*       CommandGroup no prefixo canonico cmg_4c_ (PILAR 3);
*   (3) o Picture do botao Encerrar aponta para arquivo que EXISTE
*       (.Picture inexistente falha em SILENCIO - regra #25);
*   (4) as duas grades estao ligadas aos cursores do BO com ColumnCount,
*       ControlSource, Header1.Caption e Column.Width preservados (regra #41);
*   (5) escopo: CarregarDados/RepintarGrades tem de ser PUBLIC, porque o
*       harness os chama de FORA da classe (regra #3/#51 - PEMSTATUS(...,2)
*       deve dar .F.);
*   (6) CarregarDados SEM o cursor de origem TprMvCab (que quem popula eh o
*       form PAI) devolve .F. com mensagem, sem estourar Program Error cru;
*   (7) CarregarDados COM TprMvCab populado a mao carrega as 2 grades, e
*       RepintarGrades deixa a grade MESTRE como area de trabalho corrente.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ppp666_f4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oCmg, loc_nI, loc_oGrid, loc_cTxt
loc_cOut = "C:\4c\automation\probe_ppp666_f4_result.txt"
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
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRPPPBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRPPP.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) Init completo
    loc_oForm = CREATEOBJECT("FormSigPrPpp")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"FORM W=" + TRANSFORM(loc_oForm.Width) + ;
                  " H=" + TRANSFORM(loc_oForm.Height) + ;
                  " DataSession=" + TRANSFORM(loc_oForm.DataSession) + ;
                  " TitleBar=" + TRANSFORM(loc_oForm.TitleBar) + ;
                  " BorderStyle=" + TRANSFORM(loc_oForm.BorderStyle) + ;
                  " Caption=[" + ALLTRIM(loc_oForm.Caption) + "]", loc_cOut, 1)

        *-- (2) Controles do legado
        STRTOFILE(CHR(13)+CHR(10)+"CONTROLES ControlCount=" + TRANSFORM(loc_oForm.ControlCount), loc_cOut, 1)
        FOR loc_nI = 1 TO loc_oForm.ControlCount
            STRTOFILE(CHR(13)+CHR(10)+"  [" + TRANSFORM(loc_nI) + "] " + ;
                      PADR(loc_oForm.Controls(loc_nI).Name, 24) + ;
                      " base=" + PADR(loc_oForm.Controls(loc_nI).BaseClass, 14) + ;
                      " T=" + TRANSFORM(loc_oForm.Controls(loc_nI).Top) + ;
                      " L=" + TRANSFORM(loc_oForm.Controls(loc_nI).Left) + ;
                      " W=" + TRANSFORM(loc_oForm.Controls(loc_nI).Width) + ;
                      " H=" + TRANSFORM(loc_oForm.Controls(loc_nI).Height) + ;
                      " Vis=" + TRANSFORM(loc_oForm.Controls(loc_nI).Visible), loc_cOut, 1)
        ENDFOR

        STRTOFILE(CHR(13)+CHR(10)+"CMG canonico existe=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "cmg_4c_Grp_operacao", 5)) + ;
                  " nome antigo existe=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "obj_4c_Grp_operacao", 5)), loc_cOut, 1)

        *-- (3) Icone do Encerrar tem de EXISTIR em disco
        loc_oCmg = loc_oForm.cmg_4c_Grp_operacao
        STRTOFILE(CHR(13)+CHR(10)+"CMG ButtonCount=" + TRANSFORM(loc_oCmg.ButtonCount) + ;
                  " BackStyle=" + TRANSFORM(loc_oCmg.BackStyle) + ;
                  " Btn1 Cap=[" + ALLTRIM(loc_oCmg.Buttons(1).Caption) + "]" + ;
                  " Cancel=" + TRANSFORM(loc_oCmg.Buttons(1).Cancel) + ;
                  " Pic=[" + JUSTFNAME(loc_oCmg.Buttons(1).Picture) + "]=" + ;
                  IIF(FILE(loc_oCmg.Buttons(1).Picture), "OK", "FALTA"), loc_cOut, 1)

        *-- (4) As duas grades: binding + headers + larguras
        loc_oGrid = loc_oForm.grd_4c_Operacoes
        loc_cTxt = CHR(13)+CHR(10)+"GRID OPERACOES RecordSource=[" + loc_oGrid.RecordSource + ;
                   "] ColumnCount=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
                   " ReadOnly=" + TRANSFORM(loc_oGrid.ReadOnly)
        FOR loc_nI = 1 TO loc_oGrid.ColumnCount
            loc_cTxt = loc_cTxt + CHR(13)+CHR(10)+"  Col" + TRANSFORM(loc_nI) + ;
                " CS=[" + loc_oGrid.Columns(loc_nI).ControlSource + "]" + ;
                " W=" + TRANSFORM(loc_oGrid.Columns(loc_nI).Width) + ;
                " Hdr=[" + ALLTRIM(loc_oGrid.Columns(loc_nI).Header1.Caption) + "]"
        ENDFOR
        STRTOFILE(loc_cTxt, loc_cOut, 1)

        loc_oGrid = loc_oForm.grd_4c_Itens
        loc_cTxt = CHR(13)+CHR(10)+"GRID ITENS RecordSource=[" + loc_oGrid.RecordSource + ;
                   "] ColumnCount=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
                   " ReadOnly=" + TRANSFORM(loc_oGrid.ReadOnly)
        FOR loc_nI = 1 TO loc_oGrid.ColumnCount
            loc_cTxt = loc_cTxt + CHR(13)+CHR(10)+"  Col" + TRANSFORM(loc_nI) + ;
                " CS=[" + loc_oGrid.Columns(loc_nI).ControlSource + "]" + ;
                " W=" + TRANSFORM(loc_oGrid.Columns(loc_nI).Width) + ;
                " Hdr=[" + ALLTRIM(loc_oGrid.Columns(loc_nI).Header1.Caption) + "]"
        ENDFOR
        STRTOFILE(loc_cTxt, loc_cOut, 1)

        *-- (5) Escopo: metodo chamado de FORA nao pode ser PROTECTED
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO(prot) CarregarDados=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarDados",2)) + ;
                  " RepintarGrades=" + TRANSFORM(PEMSTATUS(loc_oForm,"RepintarGrades",2)) + ;
                  " BO.CarregarOperacoes=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject,"CarregarOperacoes",2)) + ;
                  " BO.GarantirCursorOperacoes=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject,"GarantirCursorOperacoes",2)), loc_cOut, 1)

        *-- (6) CarregarDados SEM o cursor de origem (o pai nao rodou)
        STRTOFILE(CHR(13)+CHR(10)+"CarregarDados(sem TprMvCab) retorno=" + ;
                  TRANSFORM(loc_oForm.CarregarDados()) + ;
                  " MsgBO=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]", loc_cOut, 1)

        *-- RepintarGrades sozinho tambem nao pode estourar
        loc_oForm.RepintarGrades()
        STRTOFILE(CHR(13)+CHR(10)+"RepintarGrades(vazio)=OK", loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
