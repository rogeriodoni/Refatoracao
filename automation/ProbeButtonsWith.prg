*==============================================================================
* ProbeButtonsWith.prg - resolve a CONTRADICAO entre dois artefatos do pipeline
* sobre como configurar OptionGroup.Buttons(N) criado por AddObject:
*
*   migration-patterns / prompt : WITH ANINHADO dentro do WITH pai eh o CORRETO;
*                                 o errado eh WITH com caminho completo separado.
*   memoria (Erro42)            : os DOIS padroes WITH falham; o fix eh capturar
*                                 o botao numa variavel LOCAL antes do WITH.
*
* Mede os quatro padroes em classe (que eh o contexto real de um Form migrado).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_oT, loc_cOut
loc_cOut = "PROBE OptionGroup.Buttons(N) - " + TTOC(DATETIME()) + CHR(13) + CHR(10) + ;
           "(contexto: metodo de classe, OptionGroup criado por AddObject)" + CHR(13) + CHR(10)

loc_oT   = CREATEOBJECT("ProbeHost")
loc_cOut = loc_cOut + "A WITH ANINHADO dentro do WITH pai .......... " + loc_oT.TestarAninhado()   + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "B WITH caminho COMPLETO separado ............ " + loc_oT.TestarCompleto()   + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "C LOCAL capturado + WITH na variavel ........ " + loc_oT.TestarLocal()      + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "D atribuicao direta SEM WITH ................ " + loc_oT.TestarDireto()     + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\probe_buttons_with_result.txt")
QUIT

DEFINE CLASS ProbeHost AS Form
    PROCEDURE Init()
        THIS.AddObject("opt_4c_A", "OptionGroup")
        THIS.AddObject("opt_4c_B", "OptionGroup")
        THIS.AddObject("opt_4c_C", "OptionGroup")
        THIS.AddObject("opt_4c_D", "OptionGroup")
        THIS.opt_4c_A.ButtonCount = 2
        THIS.opt_4c_B.ButtonCount = 2
        THIS.opt_4c_C.ButtonCount = 2
        THIS.opt_4c_D.ButtonCount = 2
    ENDPROC

    *-- A: exatamente o que FormSigPrCfn faz hoje (linhas 617-650)
    PROCEDURE TestarAninhado()
        LOCAL loc_c, loc_oE
        TRY
            WITH THIS.opt_4c_A
                .ButtonCount = 2
                WITH .Buttons(1)
                    .Caption = "Simples"
                    .Enabled = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "Composto"
                ENDWITH
            ENDWITH
            loc_c = "OK    B1=[" + THIS.opt_4c_A.Buttons(1).Caption + "] Ena=" + ;
                    TRANSFORM(THIS.opt_4c_A.Buttons(1).Enabled) + ;
                    " B2=[" + THIS.opt_4c_A.Buttons(2).Caption + "]"
        CATCH TO loc_oE
            loc_c = "FALHOU -> " + loc_oE.Message
        ENDTRY
        RETURN loc_c
    ENDPROC

    *-- B: WITH com caminho completo, fora de qualquer WITH pai
    PROCEDURE TestarCompleto()
        LOCAL loc_c, loc_oE
        TRY
            WITH THIS.opt_4c_B.Buttons(1)
                .Caption = "Simples"
            ENDWITH
            WITH THIS.opt_4c_B.Buttons(2)
                .Caption = "Composto"
            ENDWITH
            loc_c = "OK    B1=[" + THIS.opt_4c_B.Buttons(1).Caption + "]" + ;
                    " B2=[" + THIS.opt_4c_B.Buttons(2).Caption + "]"
        CATCH TO loc_oE
            loc_c = "FALHOU -> " + loc_oE.Message
        ENDTRY
        RETURN loc_c
    ENDPROC

    *-- C: o que a memoria recomenda
    PROCEDURE TestarLocal()
        LOCAL loc_c, loc_oE, loc_oB1, loc_oB2
        TRY
            loc_oB1 = THIS.opt_4c_C.Buttons(1)
            loc_oB2 = THIS.opt_4c_C.Buttons(2)
            WITH loc_oB1
                .Caption = "Simples"
            ENDWITH
            WITH loc_oB2
                .Caption = "Composto"
            ENDWITH
            loc_c = "OK    B1=[" + THIS.opt_4c_C.Buttons(1).Caption + "]" + ;
                    " B2=[" + THIS.opt_4c_C.Buttons(2).Caption + "]"
        CATCH TO loc_oE
            loc_c = "FALHOU -> " + loc_oE.Message
        ENDTRY
        RETURN loc_c
    ENDPROC

    *-- D: o que HabilitarCampos faz (atribuicao direta, sem WITH)
    PROCEDURE TestarDireto()
        LOCAL loc_c, loc_oE
        TRY
            THIS.opt_4c_D.Buttons(1).Caption = "Simples"
            THIS.opt_4c_D.Buttons(2).Caption = "Composto"
            THIS.opt_4c_D.Buttons(1).Enabled = .F.
            loc_c = "OK    B1=[" + THIS.opt_4c_D.Buttons(1).Caption + "] Ena=" + ;
                    TRANSFORM(THIS.opt_4c_D.Buttons(1).Enabled) + ;
                    " B2=[" + THIS.opt_4c_D.Buttons(2).Caption + "]"
        CATCH TO loc_oE
            loc_c = "FALHOU -> " + loc_oE.Message
        ENDTRY
        RETURN loc_c
    ENDPROC
ENDDEFINE
