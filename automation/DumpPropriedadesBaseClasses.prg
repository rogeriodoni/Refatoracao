*==============================================================================
* DumpPropriedadesBaseClasses.prg
*
* Dumpa, do PROPRIO VFP9, a lista REAL de propriedades de cada classe base
* usada nos forms migrados. A saida alimenta o VerificarPropriedadesInexistentes.ps1.
*
* MOTIVO (Erro170): OptionGroup / CommandGroup / PageFrame NAO tem ForeColor.
* Atribuir uma propriedade que a classe nao tem COMPILA LIMPO e so estoura em
* RUNTIME, no Init do form ("Property FORECOLOR is not found"). Nao da para
* adivinhar a lista - tem de perguntar ao VFP.
*
* Uso:
*   vfp9.exe -c<config> DumpPropriedadesBaseClasses.prg
*   -> gera automation\propriedades_baseclasses.txt  (CLASSE|prop1,prop2,...)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcSaida, lcOut, loForm, loErr, i, j, lcCls, lnQtd, lcProps
LOCAL ARRAY laCls[24], laMembros[1]

lcSaida = ADDBS(JUSTPATH(SYS(16))) + "propriedades_baseclasses.txt"
lcOut   = ""

laCls[ 1] = "Form"
laCls[ 2] = "Container"
laCls[ 3] = "Label"
laCls[ 4] = "TextBox"
laCls[ 5] = "EditBox"
laCls[ 6] = "CommandButton"
laCls[ 7] = "CommandGroup"
laCls[ 8] = "OptionGroup"
laCls[ 9] = "OptionButton"
laCls[10] = "CheckBox"
laCls[11] = "ComboBox"
laCls[12] = "ListBox"
laCls[13] = "Spinner"
laCls[14] = "Grid"
laCls[15] = "Column"
laCls[16] = "Header"
laCls[17] = "PageFrame"
laCls[18] = "Page"
laCls[19] = "Image"
laCls[20] = "Shape"
laCls[21] = "Line"
laCls[22] = "Timer"
laCls[23] = "ToolBar"
laCls[24] = "Separator"

loForm = CREATEOBJECT("Form")

FOR i = 1 TO ALEN(laCls)
    lcCls  = laCls[i]
    lcProps = ""
    TRY
        DO CASE
        CASE UPPER(lcCls) == "FORM"
            lnQtd = AMEMBERS(laMembros, loForm, 0)
        CASE UPPER(lcCls) == "COLUMN"
            loForm.AddObject("g_" + TRANSFORM(i), "Grid")
            STORE 1 TO ("loForm.g_" + TRANSFORM(i) + ".ColumnCount")
            lnQtd = AMEMBERS(laMembros, EVALUATE("loForm.g_" + TRANSFORM(i) + ".Column1"), 0)
        CASE UPPER(lcCls) == "HEADER"
            loForm.AddObject("gh_" + TRANSFORM(i), "Grid")
            STORE 1 TO ("loForm.gh_" + TRANSFORM(i) + ".ColumnCount")
            lnQtd = AMEMBERS(laMembros, EVALUATE("loForm.gh_" + TRANSFORM(i) + ".Column1.Header1"), 0)
        CASE UPPER(lcCls) == "PAGE"
            loForm.AddObject("pf_" + TRANSFORM(i), "PageFrame")
            STORE 1 TO ("loForm.pf_" + TRANSFORM(i) + ".PageCount")
            lnQtd = AMEMBERS(laMembros, EVALUATE("loForm.pf_" + TRANSFORM(i) + ".Page1"), 0)
        CASE UPPER(lcCls) == "SEPARATOR"
            loForm.AddObject("tb_" + TRANSFORM(i), "ToolBar")
            EVALUATE("loForm.tb_" + TRANSFORM(i) + ".AddObject('sep1','Separator')")
            lnQtd = AMEMBERS(laMembros, EVALUATE("loForm.tb_" + TRANSFORM(i) + ".sep1"), 0)
        OTHERWISE
            loForm.AddObject("o_" + TRANSFORM(i), lcCls)
            lnQtd = AMEMBERS(laMembros, EVALUATE("loForm.o_" + TRANSFORM(i)), 0)
        ENDCASE

        FOR j = 1 TO lnQtd
            lcProps = lcProps + IIF(EMPTY(lcProps), "", ",") + UPPER(ALLTRIM(laMembros[j]))
        ENDFOR
        lcOut = lcOut + UPPER(lcCls) + "|" + lcProps + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + UPPER(lcCls) + "|<<ERRO: " + loErr.Message + ">>" + CHR(13) + CHR(10)
    ENDTRY
NEXT

STRTOFILE(lcOut, lcSaida)
QUIT
