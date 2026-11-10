*==============================================================================
* stubarvorefase7.prg - Arvore FALSA usada SO pelo probe da Fase 7.
*
* O ctTree.ocx NAO esta registrado nesta maquina (medido em
* tasks\task772\octest_fase7.txt: "Class definition CTTREE.CTTREEVIEW is not
* found"), entao em modo teste o form nao cria obj_4c_TreeView e os dois
* handlers de navegacao caem na guarda ArvoreDisponivel(). Este objeto eh
* posto no lugar do OCX para que a guarda passe e o CORPO dos handlers seja
* de fato executado.
*
* ListCount = 0 de proposito: array VFP eh 1-BASED e o laco dos handlers eh
* 0-BASED (transcrito do legado, "For lnNode = 0 To ListCount-1"), logo um
* stub de VFP nao consegue atender NodeLevel(0)/NodeExpanded(0). Com
* ListCount = 0 o laco nao itera e o que fica medido eh justamente o que nao
* depende do OCX: a guarda, a leitura de .ListCount dentro do WITH e a
* aritmetica do contador de nivel (incluindo a assimetria llExpande x
* decremento incondicional, que eh do legado).
*==============================================================================
DEFINE CLASS StubArvoreFase7 AS Custom

    ListCount = 0

    *-- Presentes so para o stub parecer com o OCX; nao sao alcancados com
    *-- ListCount = 0 (ver cabecalho).
    DIMENSION NodeLevel[1]
    DIMENSION NodeExpanded[1]

    PROCEDURE Init
        THIS.NodeLevel[1]    = 0
        THIS.NodeExpanded[1] = .F.
        RETURN .T.
    ENDPROC

ENDDEFINE
