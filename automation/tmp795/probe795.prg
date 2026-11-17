*-- Probe de instanciacao de FormSIGOPRES (Fase 3 - estrutura base)
*-- Carrega SO as dependencias do form (NAO chama ConfigurarAmbiente - ela bloqueia)
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcSaida, lcPasso
lcSaida = "C:\4c\automation\tmp795\probe795_r1.txt"

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_UsuarioLogado
gnConnHandle      = 0
gb_4c_ModoTeste   = .T.
gb_4c_ValidandoUI = .T.
gc_4c_UsuarioLogado = "TESTE"

STRTOFILE("PASSO=config.prg" + CHR(13) + CHR(10), lcSaida)

DO ("C:\4c\projeto\app\start\config.prg")

STRTOFILE("PASSO=set procedure" + CHR(13) + CHR(10), lcSaida, 1)

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
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGOPRESBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSIGOPRES.prg") ADDITIVE

STRTOFILE("PASSO=createobject" + CHR(13) + CHR(10), lcSaida, 1)

LOCAL loForm, loErro, lcMsg
loForm = .NULL.

TRY
    loForm = CREATEOBJECT("FormSIGOPRES")
CATCH TO loErro
    lcMsg = "EXCECAO=" + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
            " PROC=" + loErro.Procedure
    STRTOFILE(lcMsg + CHR(13) + CHR(10), lcSaida, 1)
ENDTRY

IF VARTYPE(loForm) = "O"
    STRTOFILE("CREATEOBJECT=OK" + CHR(13) + CHR(10), lcSaida, 1)
    STRTOFILE("BaseClass=" + loForm.BaseClass + CHR(13) + CHR(10), lcSaida, 1)
    STRTOFILE("Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10), lcSaida, 1)
    STRTOFILE("Width=" + TRANSFORM(loForm.Width) + " Height=" + TRANSFORM(loForm.Height) + ;
              " TitleBar=" + TRANSFORM(loForm.TitleBar) + " WindowType=" + ;
              TRANSFORM(loForm.WindowType) + CHR(13) + CHR(10), lcSaida, 1)
    STRTOFILE("Picture=[" + loForm.Picture + "] FILE=" + ;
              IIF(FILE(loForm.Picture), "SIM", "NAO") + CHR(13) + CHR(10), lcSaida, 1)
    STRTOFILE("ForeColor=" + TRANSFORM(loForm.ForeColor) + CHR(13) + CHR(10), lcSaida, 1)
    STRTOFILE("ControlCount=" + TRANSFORM(loForm.ControlCount) + CHR(13) + CHR(10), lcSaida, 1)

    STRTOFILE("BO=" + IIF(VARTYPE(loForm.this_oBusinessObject) = "O", ;
              loForm.this_oBusinessObject.Class, "AUSENTE") + CHR(13) + CHR(10), lcSaida, 1)

    IF PEMSTATUS(loForm, "cnt_4c_Sombra", 5)
        STRTOFILE("cnt_4c_Sombra: Top=" + TRANSFORM(loForm.cnt_4c_Sombra.Top) + ;
                  " Left=" + TRANSFORM(loForm.cnt_4c_Sombra.Left) + ;
                  " Width=" + TRANSFORM(loForm.cnt_4c_Sombra.Width) + ;
                  " Height=" + TRANSFORM(loForm.cnt_4c_Sombra.Height) + ;
                  " BackColor=" + TRANSFORM(loForm.cnt_4c_Sombra.BackColor) + ;
                  " Visible=" + TRANSFORM(loForm.cnt_4c_Sombra.Visible) + ;
                  CHR(13) + CHR(10), lcSaida, 1)
        STRTOFILE("lbl_4c_LblTitulo: Caption=[" + ;
                  loForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "] Width=" + ;
                  TRANSFORM(loForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Width) + ;
                  " Height=" + TRANSFORM(loForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Height) + ;
                  " ForeColor=" + TRANSFORM(loForm.cnt_4c_Sombra.lbl_4c_LblTitulo.ForeColor) + ;
                  " AutoSize=" + TRANSFORM(loForm.cnt_4c_Sombra.lbl_4c_LblTitulo.AutoSize) + ;
                  " Visible=" + TRANSFORM(loForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Visible) + ;
                  CHR(13) + CHR(10), lcSaida, 1)
        STRTOFILE("lbl_4c_LblSombra: Caption=[" + ;
                  loForm.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + "] Width=" + ;
                  TRANSFORM(loForm.cnt_4c_Sombra.lbl_4c_LblSombra.Width) + ;
                  " Visible=" + TRANSFORM(loForm.cnt_4c_Sombra.lbl_4c_LblSombra.Visible) + ;
                  CHR(13) + CHR(10), lcSaida, 1)
    ELSE
        STRTOFILE("cnt_4c_Sombra=AUSENTE" + CHR(13) + CHR(10), lcSaida, 1)
    ENDIF

    IF PEMSTATUS(loForm, "shp_4c_Shape1", 5)
        STRTOFILE("shp_4c_Shape1: Top=" + TRANSFORM(loForm.shp_4c_Shape1.Top) + ;
                  " Left=" + TRANSFORM(loForm.shp_4c_Shape1.Left) + ;
                  " Width=" + TRANSFORM(loForm.shp_4c_Shape1.Width) + ;
                  " Height=" + TRANSFORM(loForm.shp_4c_Shape1.Height) + ;
                  " Visible=" + TRANSFORM(loForm.shp_4c_Shape1.Visible) + ;
                  CHR(13) + CHR(10), lcSaida, 1)
    ELSE
        STRTOFILE("shp_4c_Shape1=AUSENTE" + CHR(13) + CHR(10), lcSaida, 1)
    ENDIF

    *-- Parametros repassados ao BO (janela de datas do legado)
    IF VARTYPE(loForm.this_oBusinessObject) = "O"
        STRTOFILE("BO.dtini=" + DTOC(loForm.this_oBusinessObject.this_dDataInicial) + ;
                  " BO.dtfin=" + DTOC(loForm.this_oBusinessObject.this_dDataFinal) + ;
                  " BO.SaldoInicial=" + TRANSFORM(loForm.this_oBusinessObject.this_nSaldoInicial) + ;
                  CHR(13) + CHR(10), lcSaida, 1)
    ENDIF

    STRTOFILE("this_nSaldo=" + TRANSFORM(loForm.this_nSaldo) + ;
              " this_cCursorCabecalho=[" + loForm.this_cCursorCabecalho + "]" + ;
              CHR(13) + CHR(10), lcSaida, 1)

    loForm.Release()
    loForm = .NULL.
    STRTOFILE("RELEASE=OK" + CHR(13) + CHR(10), lcSaida, 1)
ELSE
    STRTOFILE("CREATEOBJECT=FALHOU (VARTYPE=" + VARTYPE(loForm) + ")" + ;
              CHR(13) + CHR(10), lcSaida, 1)
ENDIF

*-- 2a instanciacao: COM parametros, como o chamador real faz
STRTOFILE("PASSO=createobject com parametros" + CHR(13) + CHR(10), lcSaida, 1)

CREATE CURSOR cab_teste (empdopnums C(29), datas D, prazoents D, dopes C(20))
INSERT INTO cab_teste (empdopnums, datas, prazoents, dopes) ;
    VALUES ("001MALOTE                   3", DATE(), DATE() + 15, "VENDA")

CREATE CURSOR item_teste (cpros C(14), qtds N(9,3), qtbaixas N(9,3))
INSERT INTO item_teste (cpros, qtds, qtbaixas) VALUES ("PROD001", 10, 0)

SELECT item_teste

LOCAL loForm2
loForm2 = .NULL.

TRY
    loForm2 = CREATEOBJECT("FormSIGOPRES", 123.456, "cab_teste", "item_teste")
CATCH TO loErro
    STRTOFILE("EXCECAO2=" + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
              " PROC=" + loErro.Procedure + CHR(13) + CHR(10), lcSaida, 1)
ENDTRY

IF VARTYPE(loForm2) = "O"
    STRTOFILE("CREATEOBJECT2=OK" + CHR(13) + CHR(10), lcSaida, 1)
    STRTOFILE("P2 this_nSaldo=" + TRANSFORM(loForm2.this_nSaldo) + ;
              " CursorItem=[" + loForm2.this_cCursorItem + "]" + ;
              " CursorCab=[" + loForm2.this_cCursorCabecalho + "]" + ;
              CHR(13) + CHR(10), lcSaida, 1)
    STRTOFILE("P2 BO.Produto=[" + ALLTRIM(loForm2.this_oBusinessObject.this_cProduto) + "]" + ;
              " BO.Operacao=[" + ALLTRIM(loForm2.this_oBusinessObject.this_cOperacao) + "]" + ;
              " BO.EmpDopNums=[" + loForm2.this_oBusinessObject.this_cEmpDopNums + "]" + ;
              CHR(13) + CHR(10), lcSaida, 1)
    STRTOFILE("P2 BO.dtini=" + DTOC(loForm2.this_oBusinessObject.this_dDataInicial) + ;
              " BO.dtfin=" + DTOC(loForm2.this_oBusinessObject.this_dDataFinal) + ;
              " BO.SaldoInicial=" + TRANSFORM(loForm2.this_oBusinessObject.this_nSaldoInicial) + ;
              CHR(13) + CHR(10), lcSaida, 1)
    loForm2.Release()
    loForm2 = .NULL.
    STRTOFILE("RELEASE2=OK" + CHR(13) + CHR(10), lcSaida, 1)
ELSE
    STRTOFILE("CREATEOBJECT2=FALHOU (VARTYPE=" + VARTYPE(loForm2) + ")" + ;
              CHR(13) + CHR(10), lcSaida, 1)
ENDIF

STRTOFILE("FIM" + CHR(13) + CHR(10), lcSaida, 1)
QUIT
