* ProbarF4SigOpVdi818b.prg
* Probe headless da Fase 4 (task818) - DOIS passos:
*   A) instancia FormSigOpVdi (gb_4c_ValidandoUI = .T., sem banco) e prova
*      que a tela ABRE, inspecionando grades/botoes criados;
*   B) cria a mao os 5 cursores que o BO criaria (sem SQL), deixa CORRENTE
*      um alias de PRIMEIRA COLUNA CHARACTER - que e justamente a condicao
*      que fazia o Column.AddObject do CheckBox estourar - e chama
*      oForm.CarregarDados() para provar o bind + a instalacao do CheckBox.
SET SAFETY OFF
SET RESOURCE OFF
= SYS(2335, 0)   && modo unattended - sem isso o VFP headless pode TRAVAR

LOCAL loc_cLog, loc_oForm, loc_oPag
loc_cLog = "C:\4c\automation\_probe818f4b.txt"

= STRTOFILE("P0 inicio" + CHR(13) + CHR(10), loc_cLog)

ON ERROR DO RegErro WITH ERROR(), MESSAGE(), LINENO(), PROGRAM()

CD "C:\4c\projeto\app\start"
DO config.prg
= STRTOFILE("P1 config.prg OK" + CHR(13) + CHR(10), loc_cLog, 1)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpVdiBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpVdi.prg") ADDITIVE
= STRTOFILE("P2 SET PROCEDURE OK" + CHR(13) + CHR(10), loc_cLog, 1)

PUBLIC gnConnHandle, gb_4c_ValidandoUI, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = -1
gb_4c_ValidandoUI      = .T.
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe818f4b_erros.txt"
= STRTOFILE("", gc_4c_ArquivoErroTeste)

*===========================================================================
* PASSO A - a tela abre?
*===========================================================================
loc_oForm = CREATEOBJECT("FormSigOpVdi")
= STRTOFILE("P3 CREATEOBJECT VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cLog, 1)

IF VARTYPE(loc_oForm) != "O"
    = STRTOFILE("FORM_CRIADO=NAO" + CHR(13) + CHR(10), loc_cLog, 1)
    IF FILE(gc_4c_ArquivoErroTeste)
        = STRTOFILE("--- DIALOGOS ---" + CHR(13) + CHR(10) + ;
                    FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), loc_cLog, 1)
    ENDIF
    = STRTOFILE("P9 FIM" + CHR(13) + CHR(10), loc_cLog, 1)
    QUIT
ENDIF

= STRTOFILE("FORM_CRIADO=SIM" + CHR(13) + CHR(10) + ;
            "Caption=[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10) + ;
            "BaseClass=[" + loc_oForm.BaseClass + "]" + CHR(13) + CHR(10) + ;
            "Width=" + TRANSFORM(loc_oForm.Width) + " Height=" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10) + ;
            "PageCount=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.PageCount) + ;
            " Tabs=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Tabs) + ;
            " ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + CHR(13) + CHR(10) + ;
            "DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId) + CHR(13) + CHR(10), loc_cLog, 1)

loc_oPag = loc_oForm.pgf_4c_Paginas.Page1
= STRTOFILE("Page1.ControlCount=" + TRANSFORM(loc_oPag.ControlCount) + CHR(13) + CHR(10), loc_cLog, 1)

= STRTOFILE("--- PASSO A: grades/botoes criados ---" + CHR(13) + CHR(10), loc_cLog, 1)
= ChecaGrade(loc_oPag, "grd_4c_Empresas",     loc_cLog)
= ChecaGrade(loc_oPag, "grd_4c_Tipos",        loc_cLog)
= ChecaGrade(loc_oPag, "grd_4c_GrandeGrupo",  loc_cLog)
= ChecaGrade(loc_oPag, "grd_4c_GrupoProduto", loc_cLog)
= ChecaGrade(loc_oPag, "grd_4c_Operacoes",    loc_cLog)

= ChecaBotao(loc_oPag, "cmd_4c_BtnMarca",    loc_cLog)
= ChecaBotao(loc_oPag, "cmd_4c_BtnDesmarca", loc_cLog)
= ChecaBotao(loc_oPag, "cmd_4c_Command1",    loc_cLog)
= ChecaBotao(loc_oPag, "cmd_4c_Command2",    loc_cLog)
= ChecaBotao(loc_oPag, "cmd_4c_BtnMarGde",   loc_cLog)
= ChecaBotao(loc_oPag, "cmd_4c_BtnDesGde",   loc_cLog)
= ChecaBotao(loc_oPag, "cmd_4c_BtnMarGrp",   loc_cLog)
= ChecaBotao(loc_oPag, "cmd_4c_BtnDesGrp",   loc_cLog)
= ChecaGrupo(loc_oPag, "cmg_4c_Empresas",    loc_cLog)
= ChecaGrupo(loc_oPag, "cmg_4c_Filtros",     loc_cLog)

= STRTOFILE("chk_4c_Ck_MarcaEmp: existe=" + ;
    TRANSFORM(PEMSTATUS(loc_oPag, "chk_4c_Ck_MarcaEmp", 5)) + ;
    " Value=" + TRANSFORM(loc_oPag.chk_4c_Ck_MarcaEmp.Value) + CHR(13) + CHR(10), loc_cLog, 1)

*===========================================================================
* PASSO B - cursores a mao (sem banco) + CarregarDados()
*===========================================================================
= STRTOFILE("--- PASSO B: bind + CheckBox ---" + CHR(13) + CHR(10), loc_cLog, 1)

*-- Cursor de form com DataSession = 2 tem de ser criado DENTRO da sessao
SET DATASESSION TO loc_oForm.DataSessionId
= STRTOFILE("datasession corrente=" + TRANSFORM(SET("DATASESSION")) + CHR(13) + CHR(10), loc_cLog, 1)

CREATE CURSOR cursor_4c_Empresas (Imps N(1), cemps C(3), razas C(40))
INSERT INTO cursor_4c_Empresas VALUES (0, "001", "EMPRESA UM")
INSERT INTO cursor_4c_Empresas VALUES (0, "002", "EMPRESA DOIS")

CREATE CURSOR cursor_4c_TiposOperacao (nMarcas N(1), CCodigos C(2), Codigos N(2), CDescricaos C(50))
INSERT INTO cursor_4c_TiposOperacao VALUES (0, " 1", 1, " 1-VENDA")
INSERT INTO cursor_4c_TiposOperacao VALUES (0, " 2", 2, " 2-DEVOLUCAO")

CREATE CURSOR cursor_4c_GrandeGrupo (nMarcas N(1), Codigos C(3), CDescricaos C(50))
INSERT INTO cursor_4c_GrandeGrupo VALUES (1, "A01", "A01-JOIAS")

CREATE CURSOR cursor_4c_GrupoProduto (nMarcas N(1), Mercs C(3), Codigos C(3), CDescricaos C(50))
INSERT INTO cursor_4c_GrupoProduto VALUES (1, "A01", "G01", "G01-ANEIS")

CREATE CURSOR cursor_4c_Operacoes (nMarcas N(1), Dopes C(20), TipoOps N(2))
INSERT INTO cursor_4c_Operacoes VALUES (0, "VENDA BALCAO", 1)

*-- DECOY: alias CORRENTE com PRIMEIRA coluna CHARACTER. Era exatamente esta
*-- situacao que fazia o Grid se auto-ligar a texto e o AddObject do CheckBox
*-- estourar "Value : Data type mismatch".
CREATE CURSOR cursor_4c_Decoy (TextoPrimeiro C(10), NumDepois N(5))
INSERT INTO cursor_4c_Decoy VALUES ("XYZ", 1)
SELECT cursor_4c_Decoy
= STRTOFILE("alias corrente antes do CarregarDados=[" + ALIAS() + "]" + ;
            " tipo col1=" + TYPE("cursor_4c_Decoy.TextoPrimeiro") + CHR(13) + CHR(10), loc_cLog, 1)

loc_oForm.CarregarDados()
= STRTOFILE("P5 CarregarDados executado" + CHR(13) + CHR(10), loc_cLog, 1)

= ChecaGradeLigada(loc_oPag, "grd_4c_Empresas",     "cursor_4c_Empresas",      loc_cLog)
= ChecaGradeLigada(loc_oPag, "grd_4c_Tipos",        "cursor_4c_TiposOperacao", loc_cLog)
= ChecaGradeLigada(loc_oPag, "grd_4c_GrandeGrupo",  "cursor_4c_GrandeGrupo",   loc_cLog)
= ChecaGradeLigada(loc_oPag, "grd_4c_GrupoProduto", "cursor_4c_GrupoProduto",  loc_cLog)
= ChecaGradeLigada(loc_oPag, "grd_4c_Operacoes",    "cursor_4c_Operacoes",     loc_cLog)

*-- Idempotencia: chamar de novo nao pode estourar "already defined"
loc_oForm.CarregarDados()
= STRTOFILE("P6 CarregarDados 2a vez OK (idempotente)" + CHR(13) + CHR(10), loc_cLog, 1)

*-- Alternancia: dispara o handler do CheckBox de Tipos e confere o cursor
SELECT cursor_4c_TiposOperacao
GO TOP
= STRTOFILE("antes do toggle: nMarcas=" + TRANSFORM(cursor_4c_TiposOperacao.nMarcas) + CHR(13) + CHR(10), loc_cLog, 1)
loc_oForm.ChkTipoKeyPress(13, 0)
SELECT cursor_4c_TiposOperacao
GO TOP
= STRTOFILE("depois do toggle: nMarcas=" + TRANSFORM(cursor_4c_TiposOperacao.nMarcas) + ;
            " | Operacoes.nMarcas=" + TRANSFORM(cursor_4c_Operacoes.nMarcas) + CHR(13) + CHR(10), loc_cLog, 1)

*-- Marcacao em lote
loc_oForm.BtnMarcaClick()
SELECT cursor_4c_TiposOperacao
GO TOP
= STRTOFILE("apos BtnMarcaClick: Tipos.nMarcas=" + TRANSFORM(cursor_4c_TiposOperacao.nMarcas) + CHR(13) + CHR(10), loc_cLog, 1)
loc_oForm.BtnDesmarcaClick()
SELECT cursor_4c_TiposOperacao
GO TOP
= STRTOFILE("apos BtnDesmarcaClick: Tipos.nMarcas=" + TRANSFORM(cursor_4c_TiposOperacao.nMarcas) + CHR(13) + CHR(10), loc_cLog, 1)

*-- Empresas em lote (coluna Imps NUMERICA)
loc_oPag.chk_4c_Ck_MarcaEmp.Value = 1
loc_oForm.CkMarcaEmpClick()
SELECT cursor_4c_Empresas
GO TOP
= STRTOFILE("apos CkMarcaEmpClick(1): Empresas.Imps=" + TRANSFORM(cursor_4c_Empresas.Imps) + CHR(13) + CHR(10), loc_cLog, 1)

SET DATASESSION TO 1
loc_oForm.Release()
= STRTOFILE("P7 Release OK" + CHR(13) + CHR(10), loc_cLog, 1)

IF FILE(gc_4c_ArquivoErroTeste)
    = STRTOFILE("--- DIALOGOS SUPRIMIDOS ---" + CHR(13) + CHR(10) + ;
                FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), loc_cLog, 1)
ENDIF

= STRTOFILE("P9 FIM" + CHR(13) + CHR(10), loc_cLog, 1)
QUIT

PROCEDURE RegErro(par_nErro, par_cMsg, par_nLinha, par_cProg)
    = STRTOFILE("!! ERRO " + TRANSFORM(par_nErro) + " [" + par_cMsg + "] linha " + ;
                TRANSFORM(par_nLinha) + " em " + par_cProg + CHR(13) + CHR(10), ;
                "C:\4c\automation\_probe818f4b.txt", 1)
ENDPROC

PROCEDURE ChecaGrade(par_oPag, par_cNome, par_cLog)
    LOCAL loc_oG
    IF !PEMSTATUS(par_oPag, par_cNome, 5)
        = STRTOFILE(par_cNome + ": AUSENTE" + CHR(13) + CHR(10), par_cLog, 1)
        RETURN
    ENDIF
    loc_oG = EVALUATE("par_oPag." + par_cNome)
    = STRTOFILE(par_cNome + ": ColumnCount=" + TRANSFORM(loc_oG.ColumnCount) + ;
                " Visible=" + TRANSFORM(loc_oG.Visible) + ;
                " Top=" + TRANSFORM(loc_oG.Top) + " Left=" + TRANSFORM(loc_oG.Left) + ;
                " W=" + TRANSFORM(loc_oG.Width) + " H=" + TRANSFORM(loc_oG.Height) + ;
                CHR(13) + CHR(10), par_cLog, 1)
ENDPROC

PROCEDURE ChecaGradeLigada(par_oPag, par_cNome, par_cCursor, par_cLog)
    LOCAL loc_oG, loc_cTxt
    IF !PEMSTATUS(par_oPag, par_cNome, 5)
        = STRTOFILE(par_cNome + ": AUSENTE" + CHR(13) + CHR(10), par_cLog, 1)
        RETURN
    ENDIF
    loc_oG = EVALUATE("par_oPag." + par_cNome)
    loc_cTxt = par_cNome + ":" + ;
        " RecordSource=[" + loc_oG.RecordSource + "]" + ;
        " ColumnCount=" + TRANSFORM(loc_oG.ColumnCount) + ;
        " Col1.ControlSource=[" + loc_oG.Column1.ControlSource + "]" + ;
        " Col1.Check1=" + TRANSFORM(PEMSTATUS(loc_oG.Column1, "Check1", 5)) + ;
        " Col1.CurrentControl=[" + loc_oG.Column1.CurrentControl + "]" + ;
        " Col1.Sparse=" + TRANSFORM(loc_oG.Column1.Sparse) + ;
        " Col1.ReadOnly=" + TRANSFORM(loc_oG.Column1.ReadOnly) + ;
        " Col1.Width=" + TRANSFORM(loc_oG.Column1.Width) + ;
        " Col2.Header=[" + ALLTRIM(loc_oG.Column2.Header1.Caption) + "]" + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT(par_cCursor))
    IF PEMSTATUS(loc_oG.Column1, "Check1", 5)
        loc_cTxt = loc_cTxt + " Check1.Value=" + TRANSFORM(loc_oG.Column1.Check1.Value) + ;
                   " Check1.VARTYPE=" + VARTYPE(loc_oG.Column1.Check1.Value)
        LOCAL ARRAY laEv[1]
        IF AEVENTS(laEv, loc_oG.Column1.Check1) > 0
            loc_cTxt = loc_cTxt + " handlers=" + TRANSFORM(AEVENTS(laEv, loc_oG.Column1.Check1))
        ELSE
            loc_cTxt = loc_cTxt + " handlers=0"
        ENDIF
    ENDIF
    = STRTOFILE(loc_cTxt + CHR(13) + CHR(10), par_cLog, 1)
ENDPROC

PROCEDURE ChecaBotao(par_oPag, par_cNome, par_cLog)
    LOCAL loc_oB
    IF !PEMSTATUS(par_oPag, par_cNome, 5)
        = STRTOFILE(par_cNome + ": AUSENTE" + CHR(13) + CHR(10), par_cLog, 1)
        RETURN
    ENDIF
    loc_oB = EVALUATE("par_oPag." + par_cNome)
    = STRTOFILE(par_cNome + ": Visible=" + TRANSFORM(loc_oB.Visible) + ;
                " Themes=" + TRANSFORM(loc_oB.Themes) + ;
                " Pic=[" + JUSTFNAME(loc_oB.Picture) + "]" + ;
                " DisPic=[" + JUSTFNAME(loc_oB.DisabledPicture) + "]" + ;
                " Top=" + TRANSFORM(loc_oB.Top) + " Left=" + TRANSFORM(loc_oB.Left) + ;
                CHR(13) + CHR(10), par_cLog, 1)
ENDPROC

PROCEDURE ChecaGrupo(par_oPag, par_cNome, par_cLog)
    LOCAL loc_oG
    IF !PEMSTATUS(par_oPag, par_cNome, 5)
        = STRTOFILE(par_cNome + ": AUSENTE" + CHR(13) + CHR(10), par_cLog, 1)
        RETURN
    ENDIF
    loc_oG = EVALUATE("par_oPag." + par_cNome)
    = STRTOFILE(par_cNome + ": ButtonCount=" + TRANSFORM(loc_oG.ButtonCount) + ;
                " Visible=" + TRANSFORM(loc_oG.Visible) + ;
                " B1.Pic=[" + JUSTFNAME(loc_oG.Buttons(1).Picture) + "]" + ;
                " B2.Pic=[" + JUSTFNAME(loc_oG.Buttons(2).Picture) + "]" + ;
                CHR(13) + CHR(10), par_cLog, 1)
ENDPROC
