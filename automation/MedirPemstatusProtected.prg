*==============================================================================
* MedirPemstatusProtected.prg - o probe da task701 mostrou dois valores que
* IMPRIMEM .T. e tem VARTYPE "L", mas comparados com "=" devolvem .F.:
*   prot = PEMSTATUS(oForm, "<metodo protegido>", 2)
*   esp  = .T. (literal passado por DO ... WITH)
* Mede o que PEMSTATUS devolve DE FATO quando o membro E protegido.
* Importa para o projeto: a tecnica de medir escopo da regra #51 depende disso.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXACT ON

#DEFINE SAI "C:\4c\automation\medir_pemstatus_protected.txt"
STRTOFILE("=== PEMSTATUS(obj, membro, 2) com membro PROTEGIDO ===" + CHR(13) + CHR(10), SAI)

LOCAL loc_oX, loc_uProt, loc_uPub

loc_oX = CREATEOBJECT("ClasseComProtegido")

loc_uProt = PEMSTATUS(loc_oX, "MetodoProtegido", 2)
loc_uPub  = PEMSTATUS(loc_oX, "MetodoPublico",   2)

DO Lin WITH "protegido: VARTYPE",        VARTYPE(loc_uProt)
DO Lin WITH "protegido: TRANSFORM",      TRANSFORM(loc_uProt)
DO Lin WITH "protegido: STR/valor cru",  "[" + TRANSFORM(loc_uProt) + "]"
DO Lin WITH "protegido: = .T.",          TRANSFORM(loc_uProt = .T.)
DO Lin WITH "protegido: == .T.",         TRANSFORM(loc_uProt == .T.)
DO Lin WITH "protegido: NOT (negacao)",  TRANSFORM(NOT loc_uProt)
DO Lin WITH "protegido: IIF devolve",    IIF(loc_uProt, "ramo-verdadeiro", "ramo-falso")
DO Lin WITH "protegido: = 1 (numerico)", TRANSFORM(loc_uProt = 1)
DO Lin WITH "protegido: INT()",          TRANSFORM(IIF(VARTYPE(loc_uProt) = "N", loc_uProt, -99))

DO Lin WITH "publico:   VARTYPE",        VARTYPE(loc_uPub)
DO Lin WITH "publico:   TRANSFORM",      TRANSFORM(loc_uPub)
DO Lin WITH "publico:   = .F.",          TRANSFORM(loc_uPub = .F.)
DO Lin WITH "publico:   IIF devolve",    IIF(loc_uPub, "ramo-verdadeiro", "ramo-falso")

*-- o contraste que o probe viu: prot comparado com um LITERAL vs com o
*-- retorno de outro PEMSTATUS protegido
DO Lin WITH "prot = outro prot",         TRANSFORM(loc_uProt = PEMSTATUS(loc_oX, "MetodoProtegido", 2))

QUIT

PROCEDURE Lin(pcRotulo, pcValor)
    STRTOFILE("   " + PADR(pcRotulo, 32) + " -> " + TRANSFORM(pcValor) + CHR(13) + CHR(10), SAI, 1)
ENDPROC


DEFINE CLASS ClasseComProtegido AS Custom

    PROTECTED PROCEDURE MetodoProtegido()
        RETURN .T.
    ENDPROC

    PROCEDURE MetodoPublico()
        RETURN .T.
    ENDPROC

ENDDEFINE
