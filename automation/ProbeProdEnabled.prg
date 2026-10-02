*-- Erro188: em VISUALIZAR nenhum campo pode ficar editavel, nas 8 abas.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prodenabled.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prodenabled.txt"
LOCAL loc_oE, loc_oF, loc_cGru, loc_n
STRTOFILE("A: inicio" + CHR(13) + CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gb_4c_ValidandoUI = .F.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "ProdutoBO.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormProduto.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())

    loc_oF = CREATEOBJECT("FormProdEnabled")
    SET DATASESSION TO loc_oF.DataSessionId
    STRTOFILE("B: form OK" + CHR(13) + CHR(10), OUT, 1)

    *-- MODO VISUALIZAR: nada editavel
    loc_oF.this_cModoAtual = "VISUALIZAR"
    loc_oF.ExporHabilitar(.F.)
    DO Contar WITH loc_oF, "VISUALIZAR (esperado 0 editaveis)"

    *-- MODO ALTERAR: quase tudo editavel
    loc_oF.this_cModoAtual = "ALTERAR"
    loc_oF.ExporHabilitar(.T.)
    DO Contar WITH loc_oF, "ALTERAR (esperado MUITOS editaveis)"

    *-- MODO BUSCAR: SO os 7 campos plProcurar do SCX
    loc_oF.this_cModoAtual = "BUSCAR"
    loc_oF.ExporHabilitar(.T.)
    DO Contar WITH loc_oF, "BUSCAR (esperado 7 na aba 1, 0 nas demais)"

    *-- volta para VISUALIZAR: tem de desligar de novo
    loc_oF.this_cModoAtual = "VISUALIZAR"
    loc_oF.ExporHabilitar(.F.)
    DO Contar WITH loc_oF, "VISUALIZAR de novo (esperado 0)"
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
        " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUT, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), OUT, 1)
QUIT

PROCEDURE Contar(par_oF, par_cTag)
    LOCAL loc_nP, loc_oPg, loc_cNomes, loc_nTot, loc_nHab
    STRTOFILE(CHR(13) + CHR(10) + "=== " + par_cTag + " ===" + CHR(13) + CHR(10), OUT, 1)
    FOR loc_nP = 1 TO par_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.PageCount
        loc_oPg = par_oF.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Pages(loc_nP)
        PUBLIC gnTot, gnHab, gcNomes
        gnTot = 0
        gnHab = 0
        gcNomes = ""
        DO Varrer WITH loc_oPg
        STRTOFILE("   aba " + TRANSFORM(loc_nP) + " [" + PADR(loc_oPg.Caption, 14) + "]" + ;
            " editaveis=" + PADL(TRANSFORM(gnHab), 3) + " de " + PADL(TRANSFORM(gnTot), 3) + ;
            IIF(gnHab > 0 AND LEN(gcNomes) > 0, "   " + LEFT(gcNomes, 140), "") + ;
            CHR(13) + CHR(10), OUT, 1)
    ENDFOR
ENDPROC

PROCEDURE Varrer(par_oCnt)
    LOCAL loc_nI, loc_o, loc_cB
    IF VARTYPE(par_oCnt) != "O" OR !PEMSTATUS(par_oCnt, "ControlCount", 5)
        RETURN
    ENDIF
    FOR loc_nI = 1 TO par_oCnt.ControlCount
        loc_o = par_oCnt.Controls(loc_nI)
        IF VARTYPE(loc_o) != "O"
            LOOP
        ENDIF
        loc_cB = UPPER(loc_o.BaseClass)
        IF INLIST(loc_cB, "LABEL", "SHAPE", "IMAGE", "LINE", "SEPARATOR", "GRID")
            LOOP
        ENDIF
        IF INLIST(loc_cB, "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", "SPINNER")
            gnTot = gnTot + 1
            IF loc_o.Enabled
                gnHab = gnHab + 1
                IF LEN(gcNomes) < 140
                    gcNomes = gcNomes + loc_o.Name + " "
                ENDIF
            ENDIF
        ENDIF
        IF PEMSTATUS(loc_o, "ControlCount", 5)
            DO Varrer WITH loc_o
        ENDIF
    ENDFOR
ENDPROC

DEFINE CLASS FormProdEnabled AS FormProduto
    PROCEDURE ExporHabilitar(par_l)
        THIS.HabilitarCampos(par_l)
    ENDPROC
ENDDEFINE
