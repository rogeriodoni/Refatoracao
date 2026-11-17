* ProbeSigOpPagF4.prg
* Prova que Formsigoppag (task782, Fase 4) INSTANCIA de verdade - o Init de
* form grande falha em CADEIA, e "a tela abre" so se prova instanciando.
* NAO usa ConfigurarAmbiente(): o SQL Server 192.168.200.10 nao responde
* nesta maquina e a conexao penduraria o probe. Carrega so as bases, pois
* nem sigoppagBO.Init() nem Formsigoppag.CarregarLista() fazem SQL.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_CaminhoIcones, gc_4c_UsuarioLogado, gnConnHandle

gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe782f4_erro.txt"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_UsuarioLogado    = "TESTE"
gnConnHandle           = -1

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\sigoppagBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\Formsigoppag.prg ADDITIVE

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oGrid, loc_oCnt, loc_nI
loc_cOut = ""

TRY
    loc_oForm = CREATEOBJECT("Formsigoppag")

    loc_cOut = loc_cOut + "VARTYPE_FORM=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

    IF VARTYPE(loc_oForm) = "O"
        loc_cOut = loc_cOut + "BASECLASS=" + loc_oForm.BaseClass + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "CAPTION=" + loc_oForm.Caption + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "WIDTHxHEIGHT=" + TRANSFORM(loc_oForm.Width) + "x" + ;
                   TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "CONTROLCOUNT=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "BO=" + VARTYPE(loc_oForm.this_oBusinessObject) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "CURSOR_USED=" + TRANSFORM(USED("cursor_4c_Condicoes")) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "ALIAS_GRADE=[" + loc_oForm.this_cAliasGrade + "]" + CHR(13) + CHR(10)

        *-- A grade existe e esta ligada, com as 6 colunas na largura do dump?
        IF PEMSTATUS(loc_oForm, "grd_4c_Condicoes", 5)
            loc_oGrid = loc_oForm.grd_4c_Condicoes
            loc_cOut = loc_cOut + "GRID_COLUMNCOUNT=" + TRANSFORM(loc_oGrid.ColumnCount) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "GRID_RECORDSOURCE=[" + loc_oGrid.RecordSource + "]" + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "GRID_FONT=" + loc_oGrid.FontName + "/" + ;
                       TRANSFORM(loc_oGrid.FontSize) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "GRID_READONLY=" + TRANSFORM(loc_oGrid.ReadOnly) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "GRID_HEADERHEIGHT=" + TRANSFORM(loc_oGrid.HeaderHeight) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "GRID_VISIBLE=" + TRANSFORM(loc_oGrid.Visible) + CHR(13) + CHR(10)

            FOR loc_nI = 1 TO loc_oGrid.ColumnCount
                loc_cOut = loc_cOut + "  COL" + TRANSFORM(loc_nI) + ;
                    " ord=" + TRANSFORM(loc_oGrid.Columns(loc_nI).ColumnOrder) + ;
                    " w=" + TRANSFORM(loc_oGrid.Columns(loc_nI).Width) + ;
                    " ro=" + TRANSFORM(loc_oGrid.Columns(loc_nI).ReadOnly) + ;
                    " src=[" + loc_oGrid.Columns(loc_nI).ControlSource + "]" + ;
                    " cap=[" + loc_oGrid.Columns(loc_nI).Header1.Caption + "]" + CHR(13) + CHR(10)
            ENDFOR
        ELSE
            loc_cOut = loc_cOut + "GRID=AUSENTE" + CHR(13) + CHR(10)
        ENDIF

        *-- Os 5 botoes de acao do legado foram criados e couberam no container?
        IF PEMSTATUS(loc_oForm, "cnt_4c_Botoes", 5)
            loc_oCnt = loc_oForm.cnt_4c_Botoes
            loc_cOut = loc_cOut + "CNT_BOTOES Left=" + TRANSFORM(loc_oCnt.Left) + ;
                       " W=" + TRANSFORM(loc_oCnt.Width) + ;
                       " H=" + TRANSFORM(loc_oCnt.Height) + ;
                       " filhos=" + TRANSFORM(loc_oCnt.ControlCount) + CHR(13) + CHR(10)

            FOR loc_nI = 1 TO loc_oCnt.ControlCount
                loc_cOut = loc_cOut + "  BTN " + loc_oCnt.Controls(loc_nI).Name + ;
                    " L=" + TRANSFORM(loc_oCnt.Controls(loc_nI).Left) + ;
                    " T=" + TRANSFORM(loc_oCnt.Controls(loc_nI).Top) + ;
                    " dir=" + TRANSFORM(loc_oCnt.Controls(loc_nI).Left + loc_oCnt.Controls(loc_nI).Width) + ;
                    " vis=" + TRANSFORM(loc_oCnt.Controls(loc_nI).Visible) + ;
                    " pic=" + TRANSFORM(FILE(loc_oCnt.Controls(loc_nI).Picture)) + ;
                    " cap=[" + loc_oCnt.Controls(loc_nI).Caption + "]" + CHR(13) + CHR(10)
            ENDFOR
        ELSE
            loc_cOut = loc_cOut + "CNT_BOTOES=AUSENTE" + CHR(13) + CHR(10)
        ENDIF

        *-- CarregarLista e chamavel de FORA da classe (nao pode ser PROTECTED)
        loc_cOut = loc_cOut + "CARREGARLISTA_2aCHAMADA=" + ;
                   TRANSFORM(loc_oForm.CarregarLista()) + CHR(13) + CHR(10)

        loc_oForm.Release()
    ENDIF

    loc_cOut = loc_cOut + "RESULTADO=SUCESSO" + CHR(13) + CHR(10)

CATCH TO loc_oErro
    loc_cOut = loc_cOut + "RESULTADO=ERRO" + CHR(13) + CHR(10) + ;
        "MSG=" + loc_oErro.Message + CHR(13) + CHR(10) + ;
        "LINHA=" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10) + ;
        "PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10) + ;
        "LINECONTENTS=" + loc_oErro.LineContents + CHR(13) + CHR(10)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "--- MsgErro CAPTURADO ---" + CHR(13) + CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "--- nenhum MsgErro/MsgAviso disparado ---" + CHR(13) + CHR(10)
ENDIF

= STRTOFILE(loc_cOut, "C:\4c\automation\_probe782f4.txt")
QUIT
