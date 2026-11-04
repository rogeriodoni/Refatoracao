*==============================================================================
* MedirSetFilterThis.prg - Mede se SET FILTER TO <expr com THIS.prop> sobrevive
* a troca de contexto de objeto. SET FILTER guarda a EXPRESSAO como texto e a
* reavalia a cada acesso a registro - a duvida eh contra QUE objeto o THIS eh
* resolvido nessa reavaliacao.
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXACT ON

LOCAL lcOut, loA, loB, loErr
lcOut = "=== SET FILTER TO <THIS.prop> x troca de contexto ===" + CHR(13) + CHR(10)

CREATE CURSOR crTeste (Tipos C(20))
INSERT INTO crTeste (Tipos) VALUES (PADR("TIPO A", 20))
INSERT INTO crTeste (Tipos) VALUES (PADR("TIPO A", 20))
INSERT INTO crTeste (Tipos) VALUES (PADR("TIPO B", 20))
INSERT INTO crTeste (Tipos) VALUES (PADR("TIPO B", 20))
INSERT INTO crTeste (Tipos) VALUES (PADR("TIPO B", 20))

loA = CREATEOBJECT("DonoDoFiltro")
loB = CREATEOBJECT("OutroObjeto")

*-- 1) filtro aplicado DE DENTRO do objeto que tem a property
lcOut = lcOut + CHR(13) + CHR(10) + "--- 1) THIS.prop, GO TOP de DENTRO do dono ---" + CHR(13) + CHR(10)
lcOut = lcOut + loA.AplicarComThis(PADR("TIPO B", 20))

*-- 2) mesmo filtro, GO TOP de DENTRO de OUTRO objeto
lcOut = lcOut + CHR(13) + CHR(10) + "--- 2) mesmo filtro, GO TOP de dentro de OUTRO objeto ---" + CHR(13) + CHR(10)
lcOut = lcOut + loB.AndarNoCursor()

*-- 3) mesmo filtro, GO TOP do programa PRINCIPAL (sem objeto algum)
lcOut = lcOut + CHR(13) + CHR(10) + "--- 3) mesmo filtro, GO TOP do programa principal ---" + CHR(13) + CHR(10)
TRY
    SELECT crTeste
    GO TOP
    lcOut = lcOut + "   OK - RECNO=" + TRANSFORM(RECNO()) + ;
            " Tipos=[" + ALLTRIM(crTeste.Tipos) + "]" + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "   ERRO: " + loErr.Message + CHR(13) + CHR(10)
ENDTRY
lcOut = lcOut + "   FILTER() = [" + FILTER("crTeste") + "]" + CHR(13) + CHR(10)

*-- 4) filtro com o valor BAKED como literal (macro-expansao)
lcOut = lcOut + CHR(13) + CHR(10) + "--- 4) filtro com valor LITERAL (macro) ---" + CHR(13) + CHR(10)
lcOut = lcOut + loA.AplicarComLiteral(PADR("TIPO B", 20))
lcOut = lcOut + CHR(13) + CHR(10) + "   ... e agora andando de OUTRO objeto:" + CHR(13) + CHR(10)
lcOut = lcOut + loB.AndarNoCursor()
lcOut = lcOut + CHR(13) + CHR(10) + "   ... e do programa principal:" + CHR(13) + CHR(10)
TRY
    SELECT crTeste
    GO TOP
    lcOut = lcOut + "   OK - RECNO=" + TRANSFORM(RECNO()) + ;
            " Tipos=[" + ALLTRIM(crTeste.Tipos) + "]" + CHR(13) + CHR(10)
    COUNT TO lnQ
    lcOut = lcOut + "   linhas visiveis = " + TRANSFORM(lnQ) + " (esperado 3)" + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "   ERRO: " + loErr.Message + CHR(13) + CHR(10)
ENDTRY
lcOut = lcOut + "   FILTER() = [" + FILTER("crTeste") + "]" + CHR(13) + CHR(10)

= STRTOFILE(lcOut, "C:\4c\automation\medir_setfilter_this.txt")
QUIT


DEFINE CLASS DonoDoFiltro AS Custom
    this_cTipoSelecionado = ""

    PROCEDURE AplicarComThis(par_cTipo)
        LOCAL loc_cR, loc_oErro, lnQ
        THIS.this_cTipoSelecionado = par_cTipo
        loc_cR = ""
        TRY
            SELECT crTeste
            SET FILTER TO Tipos == THIS.this_cTipoSelecionado
            GO TOP
            COUNT TO lnQ
            GO TOP
            loc_cR = "   OK - RECNO=" + TRANSFORM(RECNO()) + ;
                     " Tipos=[" + ALLTRIM(crTeste.Tipos) + "]" + ;
                     " visiveis=" + TRANSFORM(lnQ) + " (esperado 3)" + CHR(13) + CHR(10)
        CATCH TO loc_oErro
            loc_cR = "   ERRO: " + loc_oErro.Message + CHR(13) + CHR(10)
        ENDTRY
        loc_cR = loc_cR + "   FILTER() = [" + FILTER("crTeste") + "]" + CHR(13) + CHR(10)
        RETURN loc_cR
    ENDPROC

    PROCEDURE AplicarComLiteral(par_cTipo)
        LOCAL loc_cR, loc_oErro, loc_cExpr, lnQ
        THIS.this_cTipoSelecionado = par_cTipo
        loc_cR = ""
        loc_cExpr = "Tipos == " + CHR(34) + STRTRAN(par_cTipo, CHR(34), "") + CHR(34)
        TRY
            SELECT crTeste
            SET FILTER TO &loc_cExpr
            GO TOP
            COUNT TO lnQ
            GO TOP
            loc_cR = "   OK - RECNO=" + TRANSFORM(RECNO()) + ;
                     " Tipos=[" + ALLTRIM(crTeste.Tipos) + "]" + ;
                     " visiveis=" + TRANSFORM(lnQ) + " (esperado 3)" + CHR(13) + CHR(10)
        CATCH TO loc_oErro
            loc_cR = "   ERRO: " + loc_oErro.Message + CHR(13) + CHR(10)
        ENDTRY
        loc_cR = loc_cR + "   FILTER() = [" + FILTER("crTeste") + "]" + CHR(13) + CHR(10)
        RETURN loc_cR
    ENDPROC
ENDDEFINE


DEFINE CLASS OutroObjeto AS Custom
    PROCEDURE AndarNoCursor()
        LOCAL loc_cR, loc_oErro
        loc_cR = ""
        TRY
            SELECT crTeste
            GO TOP
            loc_cR = "   OK - RECNO=" + TRANSFORM(RECNO()) + ;
                     " Tipos=[" + ALLTRIM(crTeste.Tipos) + "]" + CHR(13) + CHR(10)
        CATCH TO loc_oErro
            loc_cR = "   ERRO: " + loc_oErro.Message + CHR(13) + CHR(10)
        ENDTRY
        RETURN loc_cR
    ENDPROC
ENDDEFINE
