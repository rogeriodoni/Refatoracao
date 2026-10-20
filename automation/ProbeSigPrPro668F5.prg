*==============================================================================
* ProbeSigPrPro668F5.prg - Probe funcional da Fase 5 de FormSIGPRPRO (task668)
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA (Init com os 2 parametros do legado: pFrm, pPro)
*   2) os objetos do SIGPRPRO.SCX existem no migrado
*   3) o cursor placeholder tem as 5 colunas de SigPrCrr - INCLUSIVE cpros
*   4) a grade esta LIGADA a cursor_4c_Carac.caracteris mesmo sem produto
*   5) Column1.Width/Header1.Caption NAO foram resetados pelo RecordSource
*   6) Closable continua .T. (Alt+F4 - saida que o legado tinha)
*   7) Label1 nao invade o TextBox vizinho (AutoSize no-op / regra #23)
*   8) nenhum controle fora da area do Form (regra #30)
*   9) BuscarProduto/BuscarCaracteristicas chamaveis de FORA (regra #51)
*  10) CarregarDoCursor le cursor.cpros sem estourar
*  11) GrdDadosAfterRowColChange copia Compls/Infos da linha corrente
*
* NAO chama Show(): o form eh modal e travaria o harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_sigprpro668.txt"
#DEFINE OUT "C:\4c\automation\probe_sigprpro668_f5.txt"

LOCAL loc_oForm, loc_oBO, loc_cL, loc_nFalhas, loc_oE, loc_i, loc_oC
loc_nFalhas = 0
loc_cL = ""

STRTOFILE("=== PROBE Fase 5 - FormSIGPRPRO (task668) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRPROBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRPRO.prg") ADDITIVE

    gnConnHandle = -1
    gb_4c_ModoTeste = .T.

    *-- 1) instanciacao
    loc_oForm = CREATEOBJECT("FormSIGPRPRO", .NULL., "")
    loc_cL = loc_cL + "1) VARTYPE(form) = [" + VARTYPE(loc_oForm) + "]  (esperado O)" + CHR(13) + CHR(10)
    IF VARTYPE(loc_oForm) != "O"
        loc_nFalhas = loc_nFalhas + 1
        STRTOFILE(loc_cL + "ABORTADO: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_cL = loc_cL + "   Caption=[" + loc_oForm.Caption + "] " + ;
             TRANSFORM(loc_oForm.Width) + "x" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

    *-- 2) objetos migrados
    loc_cL = loc_cL + CHR(13) + CHR(10) + "2) OBJETOS:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cnt_4c_Cabecalho        : " + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ..lbl_4c_Sombra         : " + TRANSFORM(PEMSTATUS(loc_oForm.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ..lbl_4c_Titulo         : " + TRANSFORM(PEMSTATUS(loc_oForm.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   shp_4c_Shape            : " + TRANSFORM(PEMSTATUS(loc_oForm, "shp_4c_Shape", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   shp_4c_ShpCodigo        : " + TRANSFORM(PEMSTATUS(loc_oForm, "shp_4c_ShpCodigo", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   shp_4c_Shape1           : " + TRANSFORM(PEMSTATUS(loc_oForm, "shp_4c_Shape1", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   lbl_4c_Label1           : " + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Label1", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_CPros            : " + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_CPros", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_DPros            : " + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_DPros", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   grd_4c_Dados            : " + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_Comples          : " + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_Comples", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   edt_4c_Infos            : " + TRANSFORM(PEMSTATUS(loc_oForm, "edt_4c_Infos", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cmd_4c_Ok               : " + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Ok", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   BaseClass edt_4c_Infos  = [" + loc_oForm.edt_4c_Infos.BaseClass + "] (esperado EditBox)" + CHR(13) + CHR(10)

    *-- 3) placeholder com as 5 colunas de SigPrCrr
    *-- O form eh DataSession = 2: o cursor vive na sessao PRIVADA dele e eh
    *-- invisivel para a sessao do harness. Medir de fora devolve USED() = .F.
    *-- e NAO eh defeito do form - entrar na sessao do form para medir.
    SET DATASESSION TO loc_oForm.DataSessionID
    loc_cL = loc_cL + CHR(13) + CHR(10) + "3) CURSOR PLACEHOLDER (DataSessionID=" + ;
             TRANSFORM(loc_oForm.DataSessionID) + "):" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   USED(cursor_4c_Carac) = " + TRANSFORM(USED("cursor_4c_Carac")) + CHR(13) + CHR(10)
    IF USED("cursor_4c_Carac")
        loc_cL = loc_cL + "   FCOUNT = " + TRANSFORM(FCOUNT("cursor_4c_Carac")) + " (esperado 5)" + CHR(13) + CHR(10)
        FOR loc_i = 1 TO FCOUNT("cursor_4c_Carac")
            loc_cL = loc_cL + "     col" + TRANSFORM(loc_i) + " = [" + FIELD(loc_i, "cursor_4c_Carac") + "]" + CHR(13) + CHR(10)
        ENDFOR
        IF FCOUNT("cursor_4c_Carac") != 5
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
        loc_cL = loc_cL + "   TYPE(cursor.cpros) = [" + TYPE("cursor_4c_Carac.cpros") + "] (esperado C)" + CHR(13) + CHR(10)
        IF TYPE("cursor_4c_Carac.cpros") != "C"
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
    ELSE
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 4/5) grade ligada mesmo sem produto, Width/Header preservados
    *-- (propriedades de objeto - independem de data session)
    SET DATASESSION TO 1
    loc_cL = loc_cL + CHR(13) + CHR(10) + "4/5) GRADE:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   RecordSource            = [" + loc_oForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   Column1.ControlSource   = [" + loc_oForm.grd_4c_Dados.Column1.ControlSource + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   Column1.Width           = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + " (esperado 363, NAO 90)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   Column1.Header1.Caption = [" + loc_oForm.grd_4c_Dados.Column1.Header1.Caption + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   Column1.Text1.FontName  = [" + loc_oForm.grd_4c_Dados.Column1.Text1.FontName + "] (dump: Tahoma)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   Column1.FontName        = [" + loc_oForm.grd_4c_Dados.Column1.FontName + "] (dump: Courier New)" + CHR(13) + CHR(10)
    IF UPPER(ALLTRIM(loc_oForm.grd_4c_Dados.Column1.ControlSource)) != UPPER("cursor_4c_Carac.caracteris")
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    IF loc_oForm.grd_4c_Dados.Column1.Width != 363
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 6) Closable preservado
    loc_cL = loc_cL + CHR(13) + CHR(10) + "6) SAIDA POR TECLADO:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   Closable   = " + TRANSFORM(loc_oForm.Closable) + " (esperado .T. - SCX nao declara)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ControlBox = " + TRANSFORM(loc_oForm.ControlBox) + " (SCX: .F.)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   MaxButton  = " + TRANSFORM(loc_oForm.MaxButton) + " (SCX: .F.)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   TitleBar   = " + TRANSFORM(loc_oForm.TitleBar) + " (SCX: 0)" + CHR(13) + CHR(10)
    IF !loc_oForm.Closable
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 7) Label1 x TextBox vizinho
    loc_cL = loc_cL + CHR(13) + CHR(10) + "7) LABEL x CAMPO (regra #23/#28):" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   lbl_4c_Label1.AutoSize = " + TRANSFORM(loc_oForm.lbl_4c_Label1.AutoSize) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   lbl Left+Width         = " + TRANSFORM(loc_oForm.lbl_4c_Label1.Left + loc_oForm.lbl_4c_Label1.Width) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_CPros.Left      = " + TRANSFORM(loc_oForm.txt_4c_CPros.Left) + CHR(13) + CHR(10)
    IF (loc_oForm.lbl_4c_Label1.Left + loc_oForm.lbl_4c_Label1.Width) > loc_oForm.txt_4c_CPros.Left
        loc_cL = loc_cL + "   *** SOBREPOSICAO ***" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ELSE
        loc_cL = loc_cL + "   sem sobreposicao" + CHR(13) + CHR(10)
    ENDIF

    *-- 8) controles dentro da area do Form
    loc_cL = loc_cL + CHR(13) + CHR(10) + "8) CONTROLE FORA DO PAI (regra #30):" + CHR(13) + CHR(10)
    FOR loc_i = 1 TO loc_oForm.ControlCount
        loc_oC = loc_oForm.Controls(loc_i)
        IF VARTYPE(loc_oC) = "O" AND PEMSTATUS(loc_oC, "Left", 5) AND PEMSTATUS(loc_oC, "Width", 5)
            IF (loc_oC.Left + loc_oC.Width) > loc_oForm.Width OR (loc_oC.Top + loc_oC.Height) > loc_oForm.Height
                loc_cL = loc_cL + "   *** FORA: " + loc_oC.Name + " L+W=" + ;
                         TRANSFORM(loc_oC.Left + loc_oC.Width) + " T+H=" + ;
                         TRANSFORM(loc_oC.Top + loc_oC.Height) + CHR(13) + CHR(10)
                loc_nFalhas = loc_nFalhas + 1
            ENDIF
        ENDIF
    ENDFOR
    loc_cL = loc_cL + "   (nenhuma linha FORA acima = todos dentro)" + CHR(13) + CHR(10)

    *-- 9) escopo dos metodos do BO chamados pelo form
    loc_cL = loc_cL + CHR(13) + CHR(10) + "9) ESCOPO BO (regra #51 - atributo 2 = Protected):" + CHR(13) + CHR(10)
    loc_oBO = loc_oForm.this_oBusinessObject
    loc_cL = loc_cL + "   BuscarProduto         Protected = " + TRANSFORM(PEMSTATUS(loc_oBO, "BuscarProduto", 2)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   BuscarCaracteristicas Protected = " + TRANSFORM(PEMSTATUS(loc_oBO, "BuscarCaracteristicas", 2)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   CarregarDoCursor      Protected = " + TRANSFORM(PEMSTATUS(loc_oBO, "CarregarDoCursor", 2)) + CHR(13) + CHR(10)
    IF PEMSTATUS(loc_oBO, "BuscarProduto", 2) OR PEMSTATUS(loc_oBO, "BuscarCaracteristicas", 2)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_cL = loc_cL + "   handlers do form (BINDEVENT / harness):" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     GrdDadosAfterRowColChange Protected = " + TRANSFORM(PEMSTATUS(loc_oForm, "GrdDadosAfterRowColChange", 2)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     CmdOkClick                Protected = " + TRANSFORM(PEMSTATUS(loc_oForm, "CmdOkClick", 2)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     VincularGrade             Protected = " + TRANSFORM(PEMSTATUS(loc_oForm, "VincularGrade", 2)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     CarregarLista             Protected = " + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     AjustarBotoesPorModo      Protected = " + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 2)) + CHR(13) + CHR(10)

    *-- 10) CarregarDoCursor le cpros sem estourar (na sessao do form)
    loc_cL = loc_cL + CHR(13) + CHR(10) + "10) CarregarDoCursor sobre o placeholder:" + CHR(13) + CHR(10)
    SET DATASESSION TO loc_oForm.DataSessionID
    SELECT cursor_4c_Carac
    APPEND BLANK
    REPLACE cidchaves WITH "CHV001", caracteris WITH "COR", compls WITH "AZUL", cpros WITH "PRD0001"
    TRY
        loc_cL = loc_cL + "   retorno          = " + TRANSFORM(loc_oBO.CarregarDoCursor("cursor_4c_Carac")) + CHR(13) + CHR(10)
        loc_cL = loc_cL + "   this_cCPros      = [" + ALLTRIM(loc_oBO.this_cCPros) + "]" + CHR(13) + CHR(10)
        loc_cL = loc_cL + "   this_cCaracteris = [" + ALLTRIM(loc_oBO.this_cCaracteris) + "]" + CHR(13) + CHR(10)
    CATCH TO loc_oE
        loc_cL = loc_cL + "   ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY

    *-- 11) handler de navegacao da grade
    loc_cL = loc_cL + CHR(13) + CHR(10) + "11) GrdDadosAfterRowColChange:" + CHR(13) + CHR(10)
    TRY
        GO TOP IN cursor_4c_Carac
        loc_oForm.GrdDadosAfterRowColChange(1)
        loc_cL = loc_cL + "   txt_4c_Comples = [" + ALLTRIM(loc_oForm.txt_4c_Comples.Value) + "] (esperado AZUL)" + CHR(13) + CHR(10)
    CATCH TO loc_oE
        loc_cL = loc_cL + "   ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY

    SET DATASESSION TO 1
    loc_oForm.Release()
    loc_oForm = .NULL.

CATCH TO loc_oE
    loc_cL = loc_cL + CHR(13) + CHR(10) + "EXCECAO: " + loc_oE.Message + ;
             " | LN=" + TRANSFORM(loc_oE.LineNo) + " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

loc_cL = loc_cL + CHR(13) + CHR(10) + "=== FALHAS = " + TRANSFORM(loc_nFalhas) + " ===" + CHR(13) + CHR(10)
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cL = loc_cL + "--- ERROS CAPTURADOS EM MODO TESTE ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF
STRTOFILE(loc_cL, OUT, 1)
QUIT
