*==============================================================================
* ProbeDupFonte.prg - Mede a caixa x a fonte dos TextBox da pagina Dados
*
* O legado declara, em CADA TextBox da pagina Dados:
*     FontName="Tahoma" FontSize=8 Height=18 Margin=0 SpecialEffect=1
*     ForeColor=0,0,0
* O migrado pode ter perdido Margin / SpecialEffect / ForeColor - e qualquer um
* deles muda a area UTIL interna da caixa, fazendo o numero parecer maior que
* a caixa.
*
* Mede tambem a altura REAL da fonte (FONTMETRIC) para dizer quanto a caixa
* precisa ter.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_dupfonte.txt"

#DEFINE OUT "C:\4c\automation\probe_dup_fonte.txt"

LOCAL loc_oForm, loc_oPg, loc_oE, loc_nI, loc_o, loc_cN

STRTOFILE("=== PROBE FONTE x CAIXA - FormDup pagina Dados ===" + CHR(13)+CHR(10), OUT)

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

    *-- altura REAL da fonte Tahoma 8 e das vizinhas
    STRTOFILE("FONTMETRIC(1=height) Tahoma  8 = " + TRANSFORM(FONTMETRIC(1, "Tahoma",  8, "")) + CHR(13)+CHR(10), OUT, 1)
    STRTOFILE("FONTMETRIC(1=height) Tahoma  9 = " + TRANSFORM(FONTMETRIC(1, "Tahoma",  9, "")) + CHR(13)+CHR(10), OUT, 1)
    STRTOFILE("FONTMETRIC(1=height) Verdana 8 = " + TRANSFORM(FONTMETRIC(1, "Verdana", 8, "")) + CHR(13)+CHR(10), OUT, 1)
    STRTOFILE("FONTMETRIC(1=height) Verdana 9 = " + TRANSFORM(FONTMETRIC(1, "Verdana", 9, "")) + CHR(13)+CHR(10), OUT, 1)
    STRTOFILE(CHR(13)+CHR(10), OUT, 1)

    loc_oForm = CREATEOBJECT("FormDup")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("*** NAO INSTANCIOU ***" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        STRTOFILE("Form.FontName/Size = " + loc_oForm.FontName + " / " + ;
                  TRANSFORM(loc_oForm.FontSize) + CHR(13)+CHR(10), OUT, 1)
        loc_oPg = loc_oForm.pgf_4c_Paginas.Page2
        STRTOFILE("Page2.FontName/Size = " + loc_oPg.FontName + " / " + ;
                  TRANSFORM(loc_oPg.FontSize) + CHR(13)+CHR(10)+CHR(13)+CHR(10), OUT, 1)

        STRTOFILE("controle         fonte        sz  H   W   Marg SpEf Bord ForeColor" + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE(REPLICATE("-", 74) + CHR(13)+CHR(10), OUT, 1)

        FOR loc_nI = 1 TO loc_oPg.ControlCount
            loc_o = loc_oPg.Controls(loc_nI)
            IF LOWER(loc_o.BaseClass) != "textbox"
                LOOP
            ENDIF
            loc_cN = loc_o.Name
            STRTOFILE(PADR(loc_cN, 17) + ;
                      PADR(loc_o.FontName, 13) + ;
                      PADL(TRANSFORM(loc_o.FontSize), 2) + " " + ;
                      PADL(TRANSFORM(loc_o.Height), 3) + " " + ;
                      PADL(TRANSFORM(loc_o.Width), 3) + " " + ;
                      PADL(TRANSFORM(loc_o.Margin), 4) + " " + ;
                      PADL(TRANSFORM(loc_o.SpecialEffect), 4) + " " + ;
                      PADL(TRANSFORM(loc_o.BorderStyle), 4) + " " + ;
                      TRANSFORM(loc_o.ForeColor) + CHR(13)+CHR(10), OUT, 1)
        NEXT

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13)+CHR(10), OUT, 1)
ENDTRY

STRTOFILE(CHR(13)+CHR(10) + "=== FIM ===" + CHR(13)+CHR(10), OUT, 1)
QUIT
