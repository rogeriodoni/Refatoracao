*-- ProbeF4SigOpPgc786.prg
*-- Instancia FormSIGOPPGC (Fase 4) carregando so as dependencias dele.
*-- Prova:
*--   (1) caminho do harness: CREATEOBJECT sem argumento nenhum (sem form pai,
*--       sem crSigOpFp) - Init() tem guardas VARTYPE para os 4 parametros;
*--   (2) caminho real: form pai + crSigOpFp (cursor de forma de pagamento)
*--       na mesma sessao de dados, conferindo grd_4c_Dados (ColumnCount/
*--       RecordSource/ControlSource/Width/InputMask/Header) e os botoes
*--       cmd_4c_Ok/cmd_4c_Cancela (geometria, Caption, Picture).
*-- Regra CLAUDE.md #1: nenhum RETURN dentro de TRY/CATCH.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_f4pgc.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

#DEFINE SAIDA "C:\4c\automation\probe_f4pgc.txt"

LOCAL loc_oE
STRTOFILE("A: inicio" + CHR(13) + CHR(10), SAIDA)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), SAIDA, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + ;
                 gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGOPPGCBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPPGC.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), SAIDA, 1)

    STRTOFILE(ExercitarSemArgs() + CHR(13) + CHR(10), SAIDA, 1)
    STRTOFILE(ExercitarComPai() + CHR(13) + CHR(10), SAIDA, 1)
    STRTOFILE(ExercitarFunil() + CHR(13) + CHR(10), SAIDA, 1)

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), SAIDA, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), SAIDA, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), SAIDA, 1)
QUIT


*-- (1) Caminho do harness: CREATEOBJECT sem argumento nenhum.
FUNCTION ExercitarSemArgs()
    LOCAL loc_oForm, loc_cOut, loc_oE2, loc_oGrid

    loc_cOut = "(1) sem args: "

    TRY
        IF USED("BarBonus")
            USE IN BarBonus
        ENDIF

        loc_oForm = CREATEOBJECT("FormSIGOPPGC")

        IF VARTYPE(loc_oForm) != "O"
            loc_cOut = loc_cOut + "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
        ELSE
            loc_oGrid = loc_oForm.grd_4c_Dados

            loc_cOut = loc_cOut + "Init OK" + ;
                " | W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
                " | BO=" + VARTYPE(loc_oForm.this_oBusinessObject) + ;
                " | BarBonus aberto=" + TRANSFORM(USED("BarBonus")) + ;
                " reccount=" + TRANSFORM(IIF(USED("BarBonus"), RECCOUNT("BarBonus"), -1)) + ;
                " | grade ColCount=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
                " RecSrc=[" + ALLTRIM(loc_oGrid.RecordSource) + "]"

            loc_oGrid = .NULL.
            loc_oForm.Release()
            loc_oForm = .NULL.
        ENDIF
    CATCH TO loc_oE2
        loc_cOut = loc_cOut + "EXCEPTION: " + loc_oE2.Message + ;
            " Linha:" + TRANSFORM(loc_oE2.LineNo) + " Proc:" + loc_oE2.Procedure
    ENDTRY

    RETURN loc_cOut
ENDFUNC


*-- (2) Caminho real: form pai + crSigOpFp (forma de pagamento) na mesma
*-- sessao - contrato "LParameters poForm, pnDataSes, poValor, pConexao".
FUNCTION ExercitarComPai()
    LOCAL loc_oForm, loc_oPai, loc_cOut, loc_oE2, loc_oGrid, loc_oBtnOk, loc_oBtnCancela

    loc_cOut = "(2) com pai: "

    TRY
        IF USED("crSigOpFp")
            USE IN crSigOpFp
        ENDIF
        IF USED("BarBonus")
            USE IN BarBonus
        ENDIF

        CREATE CURSOR crSigOpFp (fpags C(20), VlrFpgs N(14, 2))
        INSERT INTO crSigOpFp (fpags, VlrFpgs) VALUES ("BONUS", 10.50)

        loc_oPai = CREATEOBJECT("Form")

        loc_oForm = CREATEOBJECT("FormSIGOPPGC", loc_oPai, loc_oPai.DataSessionId, 100, .NULL.)

        IF VARTYPE(loc_oForm) != "O"
            loc_cOut = loc_cOut + "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
        ELSE
            loc_oGrid        = loc_oForm.grd_4c_Dados
            loc_oBtnOk       = loc_oForm.cmd_4c_Ok
            loc_oBtnCancela  = loc_oForm.cmd_4c_Cancela

            loc_cOut = loc_cOut + "Init OK" + ;
                " | paiEnabled=" + TRANSFORM(loc_oPai.Enabled) + ;
                " | this_nSaldoRecebido=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nSaldoInicial)

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    grade T/L/W/H=" + TRANSFORM(loc_oGrid.Top) + "/" + ;
                    TRANSFORM(loc_oGrid.Left) + "/" + TRANSFORM(loc_oGrid.Width) + "/" + ;
                    TRANSFORM(loc_oGrid.Height) + ;
                " ColCount=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
                " RO=" + TRANSFORM(loc_oGrid.ReadOnly) + ;
                " RecSrc=[" + ALLTRIM(loc_oGrid.RecordSource) + "]"

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    col1 CtrlSrc=[" + ALLTRIM(loc_oGrid.Column1.ControlSource) + "]" + ;
                " W=" + TRANSFORM(loc_oGrid.Column1.Width) + ;
                " InputMask=[" + ALLTRIM(loc_oGrid.Column1.InputMask) + "]" + ;
                " RO=" + TRANSFORM(loc_oGrid.Column1.ReadOnly) + ;
                " hdr=[" + ALLTRIM(loc_oGrid.Column1.Header1.Caption) + "]"

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    col2 CtrlSrc=[" + ALLTRIM(loc_oGrid.Column2.ControlSource) + "]" + ;
                " W=" + TRANSFORM(loc_oGrid.Column2.Width) + ;
                " RO=" + TRANSFORM(loc_oGrid.Column2.ReadOnly) + ;
                " hdr=[" + ALLTRIM(loc_oGrid.Column2.Header1.Caption) + "]"

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    btnOk T/L/W/H=" + TRANSFORM(loc_oBtnOk.Top) + "/" + ;
                    TRANSFORM(loc_oBtnOk.Left) + "/" + TRANSFORM(loc_oBtnOk.Width) + "/" + ;
                    TRANSFORM(loc_oBtnOk.Height) + ;
                " cap=[" + ALLTRIM(loc_oBtnOk.Caption) + "]" + ;
                " cancel=" + TRANSFORM(loc_oBtnOk.Cancel) + ;
                " picOK=" + TRANSFORM(FILE(loc_oBtnOk.Picture)) + ;
                " vis=" + TRANSFORM(loc_oBtnOk.Visible)

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    btnCancela T/L/W/H=" + TRANSFORM(loc_oBtnCancela.Top) + "/" + ;
                    TRANSFORM(loc_oBtnCancela.Left) + "/" + TRANSFORM(loc_oBtnCancela.Width) + "/" + ;
                    TRANSFORM(loc_oBtnCancela.Height) + ;
                " cap=[" + ALLTRIM(loc_oBtnCancela.Caption) + "]" + ;
                " picOK=" + TRANSFORM(FILE(loc_oBtnCancela.Picture)) + ;
                " vis=" + TRANSFORM(loc_oBtnCancela.Visible)

            *-- prova de que a celula Codigos eh editavel e grava no cursor:
            *-- REPLACE direto no alias ligado a grade (o Valid real so entra
            *-- na Fase 6/8) - confirma que ControlSource aponta pro cursor
            *-- certo e que a coluna nao esta travada.
            IF USED("BarBonus")
                INSERT INTO BarBonus (Codigos, Valors) VALUES (1234567890, 0)
                loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                    "    BarBonus reccount=" + TRANSFORM(RECCOUNT("BarBonus")) + ;
                    " col1Value(1aLinha)=" + TRANSFORM(loc_oGrid.Column1.Text1.Value)
            ENDIF

            loc_oGrid       = .NULL.
            loc_oBtnOk      = .NULL.
            loc_oBtnCancela = .NULL.
            loc_oForm.Release()
            loc_oForm = .NULL.
        ENDIF

        IF USED("crSigOpFp")
            USE IN crSigOpFp
        ENDIF
        IF USED("BarBonus")
            USE IN BarBonus
        ENDIF

        loc_oPai = .NULL.
    CATCH TO loc_oE2
        loc_cOut = loc_cOut + "EXCEPTION: " + loc_oE2.Message + ;
            " Linha:" + TRANSFORM(loc_oE2.LineNo) + " Proc:" + loc_oE2.Procedure
    ENDTRY

    RETURN loc_cOut
ENDFUNC


*-- (3) Funil de carga CarregarDados (Fase 4) - mede o que o gate cobra e o
*-- que o harness faz: metodo PUBLIC chamado de FORA da classe, sem
*-- argumento, com e sem o alias do chamador; e idempotencia (largura e
*-- caption de cabecalho preservados depois de um 2o bind, que reseta os
*-- dois - Problema 48 / regra #41).
*-- O cursor nasce na datasession PRIVADA do form (DataSession = 2), entao
*-- medir de fora exige SET DATASESSION TO loc_oForm.DataSessionId e voltar.
FUNCTION ExercitarFunil()
    LOCAL loc_oForm, loc_cOut, loc_oE2, loc_oGrid, loc_nSessaoProbe
    LOCAL loc_lProt, loc_l1a, loc_l2a

    loc_cOut        = "(3) funil CarregarDados: "
    loc_nSessaoProbe = SET("DATASESSION")

    TRY
        loc_oForm = CREATEOBJECT("FormSIGOPPGC")

        IF VARTYPE(loc_oForm) != "O"
            loc_cOut = loc_cOut + "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
        ELSE
            *-- escopo: PEMSTATUS(...,2) = .T. significaria PROTECTED, que
            *-- quebraria a chamada do harness em runtime (regra #3).
            loc_lProt = PEMSTATUS(loc_oForm, "CarregarDados", 2)

            *-- chamada de FORA da classe, sem argumento - exatamente como o
            *-- TesteAutomatico.prg faz.
            loc_l1a = loc_oForm.CarregarDados()
            loc_l2a = loc_oForm.CarregarDados()

            loc_cOut = loc_cOut + "Init OK" + ;
                " | PEMSTATUS(...,2)[PROTECTED]=" + TRANSFORM(loc_lProt) + ;
                " | 1a chamada=" + TRANSFORM(loc_l1a) + ;
                " 2a chamada=" + TRANSFORM(loc_l2a)

            *-- medir dentro da datasession do form
            SET DATASESSION TO loc_oForm.DataSessionId
            loc_oGrid = loc_oForm.grd_4c_Dados
            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    alias=[" + loc_oForm.this_cCursorGrade + "]" + ;
                " USED=" + TRANSFORM(USED(loc_oForm.this_cCursorGrade)) + ;
                " RecSrc=[" + ALLTRIM(loc_oGrid.RecordSource) + "]" + ;
                " ColCount=" + TRANSFORM(loc_oGrid.ColumnCount)
            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    pos-2o-bind col1 W=" + TRANSFORM(loc_oGrid.Column1.Width) + ;
                " hdr=[" + ALLTRIM(loc_oGrid.Column1.Header1.Caption) + "]" + ;
                " mask=[" + ALLTRIM(loc_oGrid.Column1.InputMask) + "]" + ;
                " | col2 hdr=[" + ALLTRIM(loc_oGrid.Column2.Header1.Caption) + "]" + ;
                " RO=" + TRANSFORM(loc_oGrid.Column2.ReadOnly)
            loc_oGrid = .NULL.
            SET DATASESSION TO loc_nSessaoProbe

            loc_oForm.Release()
            loc_oForm = .NULL.
        ENDIF
    CATCH TO loc_oE2
        SET DATASESSION TO loc_nSessaoProbe
        loc_cOut = loc_cOut + "EXCEPTION: " + loc_oE2.Message + ;
            " Linha:" + TRANSFORM(loc_oE2.LineNo) + " Proc:" + loc_oE2.Procedure
    ENDTRY

    RETURN loc_cOut
ENDFUNC
