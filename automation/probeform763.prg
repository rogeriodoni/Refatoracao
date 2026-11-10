SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
CLOSE ALL
CLEAR ALL

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoBase, gc_4c_CaminhoIcones, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, gc_4c_ArquivoErroTeste

gnConnHandle        = -1
gb_4c_ModoTeste     = .T.
gb_4c_ValidandoUI   = .T.
gc_4c_CaminhoBase   = "C:\4c\projeto\app\start"
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\probeform763_erro.txt"

SET PATH TO ("C:\4c\projeto\app\start,C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais,C:\4c\vbmp")
SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\validators.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpLocBO.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpLoc.prg" ADDITIVE

LOCAL loc_cOut, loc_oErro, loc_oForm, loc_nI, loc_nEv
loc_cOut = "PROBE FormSigOpLoc - " + TTOC(DATETIME()) + CHR(13) + CHR(10)

*-- CENARIO 1: SEM crSigOpOco. Deixa um alias ESTRANHO selecionado, com a 1a
*-- coluna CHARACTER, para expor o risco de auto-bind do ColumnCount.
CREATE CURSOR crOutroQualquer (texto C(20), numero N(5,0))
INSERT INTO crOutroQualquer VALUES ("ALIAS ESTRANHO", 7)
SELECT crOutroQualquer

loc_cOut = loc_cOut + CHR(13) + CHR(10) + "CENARIO 1: sem crSigOpOco, alias corrente = crOutroQualquer" + CHR(13) + CHR(10)
TRY
    loc_oForm = CREATEOBJECT("FormSigOpLoc")
    loc_cOut = loc_cOut + "  CREATEOBJECT VARTYPE = [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
    IF VARTYPE(loc_oForm) = "O"
        loc_cOut = loc_cOut + "  ColumnCount = " + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  RecordSource = [" + TRANSFORM(loc_oForm.grd_4c_Dados.RecordSource) + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  C1.CurrentControl = [" + loc_oForm.grd_4c_Dados.Column1.CurrentControl + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  Larguras = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + "/" + ;
            TRANSFORM(loc_oForm.grd_4c_Dados.Column2.Width) + "/" + TRANSFORM(loc_oForm.grd_4c_Dados.Column3.Width) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  CarregarDados() = " + TRANSFORM(loc_oForm.CarregarDados()) + " (esperado .F.)" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  this_cMensagemErro = [" + loc_oForm.this_cMensagemErro + "]" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "  ERRO: " + loc_oErro.Message + " | LN " + ;
        TRANSFORM(loc_oErro.LineNo) + " | " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
loc_oForm = .NULL.

*-- CENARIO 2: COM crSigOpOco na estrutura real de SigOpOco (1a coluna char)
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "CENARIO 2: com crSigOpOco (estrutura de SigOpOco)" + CHR(13) + CHR(10)
CREATE CURSOR crSigOpOco (codigos C(10), descrs C(30), grupos C(10), ;
    contas C(10), dcontas C(50), opers C(2), contabs N(1,0), imps L, notas N(1,0))
INSERT INTO crSigOpOco (codigos, descrs, imps) VALUES ("001", "OCORRENCIA UM", .F.)
INSERT INTO crSigOpOco (codigos, descrs, imps) VALUES ("002", "OCORRENCIA DOIS", .T.)
INSERT INTO crSigOpOco (codigos, descrs, imps) VALUES ("003", "OCORRENCIA TRES", .F.)
SELECT crSigOpOco
GO TOP

TRY
    loc_oForm = CREATEOBJECT("FormSigOpLoc")
    loc_cOut = loc_cOut + "  CREATEOBJECT VARTYPE = [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
    IF VARTYPE(loc_oForm) = "O"
        WITH loc_oForm.grd_4c_Dados
            loc_cOut = loc_cOut + "  ColumnCount = " + TRANSFORM(.ColumnCount) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "  RecordSource = [" + TRANSFORM(.RecordSource) + "] Type=" + TRANSFORM(.RecordSourceType) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "  C1.ControlSource = [" + TRANSFORM(.Column1.ControlSource) + "]" + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "  C2.ControlSource = [" + TRANSFORM(.Column2.ControlSource) + "]" + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "  C3.ControlSource = [" + TRANSFORM(.Column3.ControlSource) + "]" + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "  Larguras = " + TRANSFORM(.Column1.Width) + "/" + ;
                TRANSFORM(.Column2.Width) + "/" + TRANSFORM(.Column3.Width) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "  C1.CurrentControl = [" + .Column1.CurrentControl + "] Sparse=" + ;
                TRANSFORM(.Column1.Sparse) + " ReadOnly=" + TRANSFORM(.Column1.ReadOnly) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "  C2.ReadOnly=" + TRANSFORM(.Column2.ReadOnly) + ;
                " C3.ReadOnly=" + TRANSFORM(.Column3.ReadOnly) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "  chk existe=" + TRANSFORM(PEMSTATUS(.Column1, "chk_4c_Check1", 5)) + ;
                " VARTYPE(.Value)=" + VARTYPE(.Column1.chk_4c_Check1.Value) + ;
                " WxH=" + TRANSFORM(.Column1.chk_4c_Check1.Width) + "x" + TRANSFORM(.Column1.chk_4c_Check1.Height) + ;
                " Visible=" + TRANSFORM(.Column1.chk_4c_Check1.Visible) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "  Grid Top/Left/WxH = " + TRANSFORM(.Top) + "/" + TRANSFORM(.Left) + ;
                "/" + TRANSFORM(.Width) + "x" + TRANSFORM(.Height) + " RowHeight=" + TRANSFORM(.RowHeight) + ;
                " HeaderHeight=" + TRANSFORM(.HeaderHeight) + CHR(13) + CHR(10)
        ENDWITH

        loc_cOut = loc_cOut + "  Objetos: shp=" + TRANSFORM(PEMSTATUS(loc_oForm, "shp_4c_Shape2", 5)) + ;
            " desm=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_DesmarcarEmp", 5)) + ;
            " marc=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_MarcarEmp", 5)) + ;
            " sair=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_BtnSair", 5)) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  TabIndex grade/desm/marc/sair = " + TRANSFORM(loc_oForm.grd_4c_Dados.TabIndex) + ;
            "/" + TRANSFORM(loc_oForm.cmd_4c_DesmarcarEmp.TabIndex) + ;
            "/" + TRANSFORM(loc_oForm.cmd_4c_MarcarEmp.TabIndex) + ;
            "/" + TRANSFORM(loc_oForm.cmd_4c_BtnSair.TabIndex) + CHR(13) + CHR(10)

        loc_cOut = loc_cOut + "  ORDEM DE CRIACAO (ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + "):" + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO loc_oForm.ControlCount
            loc_cOut = loc_cOut + "    [" + TRANSFORM(loc_nI) + "] " + loc_oForm.Controls(loc_nI).Name + ;
                " Visible=" + TRANSFORM(loc_oForm.Controls(loc_nI).Visible) + CHR(13) + CHR(10)
        ENDFOR

        loc_cOut = loc_cOut + "  PROTECTED? (esperado tudo .F.) KeyPress=" + TRANSFORM(PEMSTATUS(loc_oForm, "ChkMarcacaoKeyPress", 2)) + ;
            " MouseUp=" + TRANSFORM(PEMSTATUS(loc_oForm, "ChkMarcacaoMouseUp", 2)) + ;
            " MouseDown=" + TRANSFORM(PEMSTATUS(loc_oForm, "ChkMarcacaoMouseDown", 2)) + ;
            " Click=" + TRANSFORM(PEMSTATUS(loc_oForm, "ChkMarcacaoClick", 2)) + ;
            " CarregarDados=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 2)) + CHR(13) + CHR(10)

        LOCAL ARRAY loc_aEv[1, 5]
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.grd_4c_Dados.Column1.chk_4c_Check1)
        loc_cOut = loc_cOut + "  BINDEVENT na caixa: " + TRANSFORM(loc_nEv) + " ligacao(oes)" + CHR(13) + CHR(10)
        IF loc_nEv > 0
            FOR loc_nI = 1 TO loc_nEv
                loc_cOut = loc_cOut + "    ev=[" + TRANSFORM(loc_aEv[loc_nI, 2]) + "] dest=[" + ;
                    TRANSFORM(loc_aEv[loc_nI, 4]) + "]" + CHR(13) + CHR(10)
            ENDFOR
        ENDIF

        SELECT crSigOpOco
        GO TOP
        loc_cOut = loc_cOut + "  Imps linha1 ANTES = " + TRANSFORM(crSigOpOco.imps) + CHR(13) + CHR(10)
        loc_oForm.ChkMarcacaoKeyPress(32, 0)
        loc_cOut = loc_cOut + "  Imps linha1 pos Espaco = " + TRANSFORM(crSigOpOco.imps) + CHR(13) + CHR(10)
        loc_oForm.ChkMarcacaoMouseUp(1, 0, 0, 0)
        loc_cOut = loc_cOut + "  Imps linha1 pos MouseUp = " + TRANSFORM(crSigOpOco.imps) + CHR(13) + CHR(10)
        loc_oForm.ChkMarcacaoKeyPress(65, 0)
        loc_cOut = loc_cOut + "  Imps linha1 pos tecla A (nao deve mudar) = " + TRANSFORM(crSigOpOco.imps) + CHR(13) + CHR(10)

        loc_oForm.this_oBusinessObject.MarcarTodos()
        SELECT crSigOpOco
        COUNT TO loc_nI FOR imps
        loc_cOut = loc_cOut + "  MarcarTodos -> " + TRANSFORM(loc_nI) + " de " + TRANSFORM(RECCOUNT("crSigOpOco")) + CHR(13) + CHR(10)
        loc_oForm.this_oBusinessObject.DesmarcarTodos()
        SELECT crSigOpOco
        COUNT TO loc_nI FOR imps
        loc_cOut = loc_cOut + "  DesmarcarTodos -> " + TRANSFORM(loc_nI) + CHR(13) + CHR(10)

        loc_cOut = loc_cOut + "  CarregarDados() 2a vez = " + TRANSFORM(loc_oForm.CarregarDados()) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  C1.CurrentControl pos 2a carga = [" + loc_oForm.grd_4c_Dados.Column1.CurrentControl + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  Larguras pos 2a carga = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + "/" + ;
            TRANSFORM(loc_oForm.grd_4c_Dados.Column2.Width) + "/" + TRANSFORM(loc_oForm.grd_4c_Dados.Column3.Width) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  this_cMensagemErro = [" + loc_oForm.this_cMensagemErro + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "  USED(crSigOpOco) ao fim = " + TRANSFORM(USED("crSigOpOco")) + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "  ERRO: " + loc_oErro.Message + " | LN " + ;
        TRANSFORM(loc_oErro.LineNo) + " | " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\probeform763_out.txt")
QUIT
