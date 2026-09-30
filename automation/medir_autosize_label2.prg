*==============================================================================
* medir_autosize_label2.prg - Reproduz a ORDEM EXATA de propriedades do
* ConfigurarControles() do FormSIGPRALE para os 3 labels, com AutoSize = .T.
* (como esta hoje) e com AutoSize = .F., e confere as 3 geometrias contra o
* dump do SCX (mensagem 97x25, mensagem2 221x25, mensagem3 248x48).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF

LOCAL lcLog, lcCRLF, loF, i, lcNome, llAuto
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\automation\medir_autosize_label2.txt"

LOCAL ARRAY laCap[3], laW[3], laH[3], laT[3]
laCap[1] = "Aguarde..."
laCap[2] = "Finalizando Reduc" + CHR(227) + "o Z."
laCap[3] = "Por Favor. N" + CHR(227) + "o Desligue a impressora Fiscal."
laW[1] = 97  && dump
laW[2] = 221
laW[3] = 248
laH[1] = 25
laH[2] = 25
laH[3] = 48
laT[1] = 4
laT[2] = 32
laT[3] = 62

STRTOFILE("=== ORDEM EXATA do ConfigurarControles() do FormSIGPRALE ===" + lcCRLF, lcLog, 0)
STRTOFILE("Dump SCX: mensagem 97x25 T=4 | mensagem2 221x25 T=32 | mensagem3 248x48 T=62" + lcCRLF + lcCRLF, lcLog, 1)

LOCAL lnCaso
FOR lnCaso = 1 TO 2
    llAuto = (lnCaso = 1)
    loF = CREATEOBJECT("Form")
    loF.Width  = 419
    loF.Height = 115
    STRTOFILE("--- AutoSize = " + IIF(llAuto, ".T. (como esta hoje)", ".F. (proposto)") + " ---" + lcCRLF, lcLog, 1)
    FOR i = 1 TO 3
        lcNome = "lb" + TRANSFORM(i)
        loF.AddObject(lcNome, "Label")
        WITH EVALUATE("loF." + lcNome)
            .AutoSize  = llAuto
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .WordWrap  = .T.
            .Alignment = 2
            .BackStyle = 0
            .Caption   = laCap[i]
            .Top       = laT[i]
            .Left      = 85
            .Width     = laW[i]
            .Height    = laH[i]
            .ForeColor = RGB(255,0,0)
            .Visible   = .T.
        ENDWITH
        STRTOFILE("  label" + TRANSFORM(i) + " esperado " + TRANSFORM(laW[i]) + "x" + TRANSFORM(laH[i]) + ;
            "  obtido " + TRANSFORM(EVALUATE("loF." + lcNome + ".Width")) + "x" + ;
            TRANSFORM(EVALUATE("loF." + lcNome + ".Height")) + ;
            "  T=" + TRANSFORM(EVALUATE("loF." + lcNome + ".Top")) + ;
            IIF(EVALUATE("loF." + lcNome + ".Width") = laW[i] AND ;
                EVALUATE("loF." + lcNome + ".Height") = laH[i], "   OK", "   DIVERGE") + lcCRLF, lcLog, 1)
    ENDFOR
    *-- E depois da troca de Caption que o Init legado faz
    loF.lb3.Caption = "Etapa 3 de 3 - aguarde a impressora fiscal concluir a Reducao Z"
    STRTOFILE("  label3 apos trocar Caption em runtime: " + ;
        TRANSFORM(loF.lb3.Width) + "x" + TRANSFORM(loF.lb3.Height) + lcCRLF + lcCRLF, lcLog, 1)
    loF = .NULL.
ENDFOR

STRTOFILE("FIM" + lcCRLF, lcLog, 1)
QUIT
