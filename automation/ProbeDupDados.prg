*==============================================================================
* ProbeDupDados.prg - Dump da geometria REAL da pagina Dados de FormDup (Erro232)
*
* Percorre recursivamente os controles da Page2 depois do Init e grava
* nome / classe / Top / Left / Width / Height / Caption em TSV, com o Top
* convertido para Y de TELA (Top - 29, a compensacao do PageFrame sem abas),
* para comparar direto com o layout.json do SCX legado.
*
* NAO chama Show(): o form eh modal e travaria o harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_dupdados.txt"

#DEFINE OUT "C:\4c\automation\probe_dup_dados.tsv"
#DEFINE LOG "C:\4c\automation\probe_dup_dados.log"

LOCAL loc_oForm, loc_oE

STRTOFILE("", OUT)
STRTOFILE("=== PROBE DADOS - FormDup (Erro232) ===" + CHR(13)+CHR(10), LOG)

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
    SET PROCEDURE TO (gcCaminhoClasses + "DupBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormDup.prg") ADDITIVE

    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
        gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    ENDIF
    STRTOFILE("gnConnHandle = " + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), LOG, 1)

    loc_oForm = CREATEOBJECT("FormDup")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("*** NAO INSTANCIOU ***" + CHR(13)+CHR(10), LOG, 1)
    ELSE
        STRTOFILE("Page2 ControlCount = " + ;
                  TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.ControlCount) + CHR(13)+CHR(10), LOG, 1)
        DO Varre WITH loc_oForm.pgf_4c_Paginas.Page2, "", 0, 0
        loc_oForm.Release()
    ENDIF
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ;
              ", " + loc_oE.Procedure + ")" + CHR(13)+CHR(10), LOG, 1)
ENDTRY

STRTOFILE("=== FIM ===" + CHR(13)+CHR(10), LOG, 1)
QUIT


PROCEDURE Varre(par_oPai, par_cPrefixo, par_nAcumTop, par_nAcumLeft)
    LOCAL loc_nI, loc_o, loc_cCap, loc_nT, loc_nL
    FOR loc_nI = 1 TO par_oPai.ControlCount
        loc_o = par_oPai.Controls(loc_nI)
        loc_nT = par_nAcumTop  + loc_o.Top
        loc_nL = par_nAcumLeft + loc_o.Left

        loc_cCap = ""
        IF PEMSTATUS(loc_o, "Caption", 5)
            loc_cCap = loc_o.Caption
        ENDIF
        loc_cCap = STRTRAN(STRTRAN(loc_cCap, CHR(9), " "), CHR(13), " ")

        STRTOFILE(par_cPrefixo + loc_o.Name + CHR(9) + ;
                  LOWER(loc_o.BaseClass) + CHR(9) + ;
                  TRANSFORM(loc_nT - 29) + CHR(9) + ;
                  TRANSFORM(loc_nL) + CHR(9) + ;
                  TRANSFORM(loc_o.Width) + CHR(9) + ;
                  TRANSFORM(loc_o.Height) + CHR(9) + ;
                  loc_cCap + CHR(13)+CHR(10), OUT, 1)

        IF INLIST(LOWER(loc_o.BaseClass), "container", "pageframe")
            DO Varre WITH loc_o, par_cPrefixo + loc_o.Name + ".", loc_nT, loc_nL
        ENDIF
    NEXT
ENDPROC
