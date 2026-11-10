*-- MedirImageNatural744.prg
*-- Mede o tamanho NATURAL dos arquivos dos 3 outros sites do projeto que
*-- declaram Width/Height ANTES do .Picture com Stretch default (0 = Clip).
*-- Se o natural = o declarado, nao ha desvio; se difere, o declarado eh
*-- silenciosamente descartado.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE OUT "C:\4c\automation\medir_image_natural744_out.txt"

LOCAL loc_cR, loc_oF, loc_nI, loc_cArq, loc_nW, loc_nH
LOCAL ARRAY loc_aCaso[3, 4]

loc_aCaso[1, 1] = "FormRPT.img_4c_Orientacao"
loc_aCaso[1, 2] = "C:\4c\vbmp\Rpt_Orientacao_Retrato_26.JPG"
loc_aCaso[1, 3] = 130
loc_aCaso[1, 4] = 116

loc_aCaso[2, 1] = "Formsigmvitn.img_4c_Image1"
loc_aCaso[2, 2] = "C:\4c\vbmp\b_arrow2.bmp"
loc_aCaso[2, 3] = 25
loc_aCaso[2, 4] = 25

loc_aCaso[3, 1] = "Formsigmvitn.img_4c_Image2"
loc_aCaso[3, 2] = "C:\4c\vbmp\b_arrow2.bmp"
loc_aCaso[3, 3] = 25
loc_aCaso[3, 4] = 25

loc_cR = ""
loc_oF = CREATEOBJECT("Form")

FOR loc_nI = 1 TO 3
    loc_cArq = loc_aCaso[loc_nI, 2]
    IF !FILE(loc_cArq)
        loc_cR = loc_cR + PADR(loc_aCaso[loc_nI, 1], 30) + " ARQUIVO AUSENTE [" + loc_cArq + "]" + CHR(13) + CHR(10)
        LOOP
    ENDIF

    *-- reproduz a ordem do codigo: W/H e DEPOIS Picture, Stretch default
    loc_oF.AddObject("img" + TRANSFORM(loc_nI), "Image")
    STORE loc_aCaso[loc_nI, 3] TO ("loc_oF.img" + TRANSFORM(loc_nI) + ".Width")
    STORE loc_aCaso[loc_nI, 4] TO ("loc_oF.img" + TRANSFORM(loc_nI) + ".Height")
    STORE loc_cArq             TO ("loc_oF.img" + TRANSFORM(loc_nI) + ".Picture")

    loc_nW = EVALUATE("loc_oF.img" + TRANSFORM(loc_nI) + ".Width")
    loc_nH = EVALUATE("loc_oF.img" + TRANSFORM(loc_nI) + ".Height")

    loc_cR = loc_cR + PADR(loc_aCaso[loc_nI, 1], 30) + ;
             " declarado=" + TRANSFORM(loc_aCaso[loc_nI, 3]) + "x" + TRANSFORM(loc_aCaso[loc_nI, 4]) + ;
             " efetivo=" + TRANSFORM(loc_nW) + "x" + TRANSFORM(loc_nH) + ;
             IIF(loc_nW = loc_aCaso[loc_nI, 3] AND loc_nH = loc_aCaso[loc_nI, 4], ;
                 "  -> IGUAL (sem desvio)", "  -> DESVIO") + CHR(13) + CHR(10)
ENDFOR

STRTOFILE(loc_cR, OUT)
QUIT
