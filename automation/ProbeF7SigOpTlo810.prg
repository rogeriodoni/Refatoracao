* ProbeF7SigOpTlo810.prg
* Fase 7 / task810 - prova que FormSigOpTlo INSTANCIA com o rodape de totais
* criado e que AtualizarTotais() escreve os Caption do fecho do Init legado,
* nos DOIS estados do parametro perlocals (desligado = rodape vazio, como o
* legado; ligado = os tres numeros).
*
* Mede tambem a largura RENDERIZADA de cada Caption (TXTWIDTH * FONTMETRIC)
* contra a Width do label, para provar que o texto NAO eh cortado - era esse
* o defeito herdado do SCX (Width = 2 nos tres labels de valor).
*
* NAO chama ConfigurarAmbiente() - ele nao retorna nesta maquina.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cRel, loc_oForm, loc_oErro, loc_nUnit

loc_cOut = "C:\4c\automation\_f7tlo_probe.txt"
loc_cRel = "CHECKPOINT 1 - script vivo" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f7tlo_erros.txt"
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "PROBE"

CD C:\4c\projeto\app\start
DO config.prg

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
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpTloBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpTlo.prg") ADDITIVE

loc_cRel = loc_cRel + "CHECKPOINT 2 - dependencias OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

loc_nUnit = FONTMETRIC(6, "Tahoma", 8, "")

*==============================================================================
* CENARIO A - sem cursor do chamador e sem crSigCdPam (perlocals DESLIGADO)
*==============================================================================
loc_cRel = loc_cRel + CHR(13) + CHR(10) + ;
    "=== CENARIO A: sem cursores do chamador, perlocals ausente ===" + CHR(13) + CHR(10)

TRY
    loc_oForm = CREATEOBJECT("FormSigOpTlo", 1)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cRel = loc_cRel + "VARTYPE(loForm)=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    loc_cRel = loc_cRel + "lbl_4c_Label1 existe=" + ;
        IIF(PEMSTATUS(loc_oForm, "lbl_4c_Label1", 5), ".T.", ".F.") + ;
        " Caption=[" + loc_oForm.lbl_4c_Label1.Caption + "]" + ;
        " L/T/W/H=" + TRANSFORM(loc_oForm.lbl_4c_Label1.Left) + "/" + ;
        TRANSFORM(loc_oForm.lbl_4c_Label1.Top) + "/" + ;
        TRANSFORM(loc_oForm.lbl_4c_Label1.Width) + "/" + ;
        TRANSFORM(loc_oForm.lbl_4c_Label1.Height) + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "lbl_4c_Label2 Caption=[" + loc_oForm.lbl_4c_Label2.Caption + "]" + ;
        " L/T/W/H=" + TRANSFORM(loc_oForm.lbl_4c_Label2.Left) + "/" + ;
        TRANSFORM(loc_oForm.lbl_4c_Label2.Top) + "/" + ;
        TRANSFORM(loc_oForm.lbl_4c_Label2.Width) + "/" + ;
        TRANSFORM(loc_oForm.lbl_4c_Label2.Height) + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "PerLocals do BO=" + ;
        IIF(loc_oForm.this_oBusinessObject.this_lPerLocals, ".T.", ".F.") + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "TotLido Caption=[" + loc_oForm.lbl_4c_Lb_TotLido.Caption + ;
        "] (esperado vazio)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "TotEstoque Caption=[" + loc_oForm.lbl_4c_Lb_TotEstoque.Caption + ;
        "] (esperado vazio)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "Leitura Caption=[" + loc_oForm.lbl_4c_Leitura.Caption + ;
        "] (esperado vazio)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "AtualizarTotais PROTECTED(2)=" + ;
        IIF(PEMSTATUS(loc_oForm, "AtualizarTotais", 2), ".T.", ".F.") + ;
        " (esperado .F.)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "AtualizarTotais() de fora=" + ;
        IIF(loc_oForm.AtualizarTotais(), ".T.", ".F.") + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "cmd_4c_Saida existe=" + ;
        IIF(PEMSTATUS(loc_oForm, "cmd_4c_Saida", 5), ".T.", ".F.") + ;
        " BtnSaidaClick existe=" + ;
        IIF(PEMSTATUS(loc_oForm, "BtnSaidaClick", 5), ".T.", ".F.") + CHR(13) + CHR(10)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

STRTOFILE(loc_cRel, loc_cOut)

*==============================================================================
* CENARIO B - cursores do chamador + crSigCdPam com perlocals LIGADO
*==============================================================================
loc_cRel = loc_cRel + CHR(13) + CHR(10) + ;
    "=== CENARIO B: cursores do chamador, perlocals = .T. ===" + CHR(13) + CHR(10)

CREATE CURSOR crSigCdPam (perlocals L)
INSERT INTO crSigCdPam VALUES (.T.)

CREATE CURSOR cursor_4c_Historico (localis C(10), tipos N(1,0), qtds N(11,3))
INSERT INTO cursor_4c_Historico VALUES ("A01", 1, 10.000)
INSERT INTO cursor_4c_Historico VALUES ("A01", 1,  5.000)
INSERT INTO cursor_4c_Historico VALUES ("B02", 1,  7.000)
INSERT INTO cursor_4c_Historico VALUES ("B02", 2,  3.000)

CREATE CURSOR cursor_4c_Etiqueta (qtds N(9,3))
INSERT INTO cursor_4c_Etiqueta VALUES (1.000)
INSERT INTO cursor_4c_Etiqueta VALUES (1.000)
INSERT INTO cursor_4c_Etiqueta VALUES (1.000)
INSERT INTO cursor_4c_Etiqueta VALUES (1.000)

TRY
    loc_oForm = CREATEOBJECT("FormSigOpTlo", 1)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cRel = loc_cRel + "VARTYPE(loForm)=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    loc_cRel = loc_cRel + "PerLocals do BO=" + ;
        IIF(loc_oForm.this_oBusinessObject.this_lPerLocals, ".T.", ".F.") + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "TotalLido=" + ;
        TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalLido) + ;
        " TotalEstoque=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalEstoque) + ;
        " Perc=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPercLeitura) + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "TotLido    Caption=[" + loc_oForm.lbl_4c_Lb_TotLido.Caption + "]" + ;
        " Width=" + TRANSFORM(loc_oForm.lbl_4c_Lb_TotLido.Width) + ;
        " textoPx=" + TRANSFORM(TXTWIDTH(loc_oForm.lbl_4c_Lb_TotLido.Caption, "Tahoma", 8, "") * loc_nUnit) + ;
        " CABE=" + IIF(TXTWIDTH(loc_oForm.lbl_4c_Lb_TotLido.Caption, "Tahoma", 8, "") * loc_nUnit <= ;
                       loc_oForm.lbl_4c_Lb_TotLido.Width, "SIM", "NAO") + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "TotEstoque Caption=[" + loc_oForm.lbl_4c_Lb_TotEstoque.Caption + "]" + ;
        " Width=" + TRANSFORM(loc_oForm.lbl_4c_Lb_TotEstoque.Width) + ;
        " textoPx=" + TRANSFORM(TXTWIDTH(loc_oForm.lbl_4c_Lb_TotEstoque.Caption, "Tahoma", 8, "") * loc_nUnit) + ;
        " CABE=" + IIF(TXTWIDTH(loc_oForm.lbl_4c_Lb_TotEstoque.Caption, "Tahoma", 8, "") * loc_nUnit <= ;
                       loc_oForm.lbl_4c_Lb_TotEstoque.Width, "SIM", "NAO") + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "Leitura    Caption=[" + loc_oForm.lbl_4c_Leitura.Caption + "]" + ;
        " Width=" + TRANSFORM(loc_oForm.lbl_4c_Leitura.Width) + ;
        " textoPx=" + TRANSFORM(TXTWIDTH(loc_oForm.lbl_4c_Leitura.Caption, "Tahoma", 8, "") * loc_nUnit) + ;
        " CABE=" + IIF(TXTWIDTH(loc_oForm.lbl_4c_Leitura.Caption, "Tahoma", 8, "") * loc_nUnit <= ;
                       loc_oForm.lbl_4c_Leitura.Width, "SIM", "NAO") + CHR(13) + CHR(10)

    *-- a largura do SCX (2px) nao caberia - prova do porque do desvio
    loc_cRel = loc_cRel + "SCX usava Width=2: CABERIA=" + ;
        IIF(TXTWIDTH(loc_oForm.lbl_4c_Lb_TotLido.Caption, "Tahoma", 8, "") * loc_nUnit <= 2, ;
            "SIM", "NAO") + CHR(13) + CHR(10)

    *-- Recarregar tem de atualizar grade E rodape pelo mesmo funil
    loc_cRel = loc_cRel + "Recarregar()=" + ;
        IIF(loc_oForm.Recarregar(1, .F.), ".T.", ".F.") + ;
        " TotLido apos=[" + loc_oForm.lbl_4c_Lb_TotLido.Caption + "]" + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "RECCOUNT(cursor_4c_Locais)=" + ;
        TRANSFORM(IIF(USED("cursor_4c_Locais"), RECCOUNT("cursor_4c_Locais"), -1)) + ;
        " (esperado 2)" + CHR(13) + CHR(10)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

loc_cRel = loc_cRel + CHR(13) + CHR(10) + "FIM DO PROBE" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

QUIT
