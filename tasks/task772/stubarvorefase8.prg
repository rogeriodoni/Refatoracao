*==============================================================================
* stubarvorefase8.prg - Arvore FALSA usada SO pelo probe da Fase 8.
*
* Irmao de stubarvorefase7.prg (mesmo motivo: o ctTree.ocx NAO esta registrado
* nesta maquina - medido em tasks\task772\octest_fase7.txt), acrescentando o
* que a Fase 8 precisa medir e a Fase 7 nao usava:
*
*   NodeCargo(<indice>) - METODO (nao array), porque o form chama
*       .NodeCargo(par_nIndex) com par_nIndex 0-BASED (transcrito do legado) e
*       array de VFP eh 1-based. O valor devolvido eh configuravel por
*       cCargoFalso/uCargoFalso para o probe poder medir os TRES casos que
*       mudam o ramo do TreeViewNodeClick: cargo vazio (o caso REAL do legado,
*       que nunca atribui cargo a no algum), cargo NUMERICO zero (tem de
*       continuar valendo "vazio", senao um TRANSFORM descuidado tornaria
*       alcancavel um ramo que no legado nunca roda) e cargo com texto.
*
* ListCount = 0 pelo mesmo motivo do stub da Fase 7 (ver o cabecalho dele).
*==============================================================================
DEFINE CLASS StubArvoreFase8 AS Custom

    ListCount = 0

    *-- Valor que NodeCargo devolve. Comeca VAZIO = o estado real do legado.
    uCargoFalso = ""

    nChamadasNodeCargo = 0

    DIMENSION NodeLevel[1]
    DIMENSION NodeExpanded[1]

    PROCEDURE Init
        THIS.NodeLevel[1]    = 0
        THIS.NodeExpanded[1] = .F.
        RETURN .T.
    ENDPROC

    PROCEDURE NodeCargo(par_nIndice)
        THIS.nChamadasNodeCargo = THIS.nChamadasNodeCargo + 1
        RETURN THIS.uCargoFalso
    ENDPROC

ENDDEFINE
