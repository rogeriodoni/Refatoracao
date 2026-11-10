*==============================================================================
* probar_form_fase7.prg - Prova da Fase 7 (eventos principais dos botoes).
*
* Mede, pelo ARQUIVO DE SAIDA (nao pelo exit code):
*   P1 o form instancia com os tres handlers novos
*   P2 os tres handlers EXISTEM e sao PUBLIC (PEMSTATUS attr 2 = .F.) - metodo
*      PROTECTED eh ignorado em silencio por BINDEVENT (CLAUDE.md #3)
*   P3 o BINDEVENT foi ENTREGUE: AEVENTS em cada botao devolve THIS + o nome
*      do handler
*   P4 Expandir/Regredir com a arvore AUSENTE (ctTree.ocx nao registrado nesta
*      maquina) nao estouram e nao mexem no contador - eh o comportamento de
*      estacao sem o OCX
*   P5 Expandir/Regredir com a arvore PRESENTE (stub StubArvoreFase7,
*      ListCount = 0): a aritmetica do contador, inclusive a assimetria do
*      legado - Expandir so avanca se achou no (llExpande), Regredir recua
*      sempre que a guarda passa, e nao recua abaixo de zero
*   P6 Encerrar: apaga o temporario (chama o BO), zera this_cArquivoFigura e
*      RELEASE o form (VARTYPE passa a "X")
*
* NAO fica provado aqui o laco por no (NodeLevel/NodeExpanded): exige o
* ctTree.ocx registrado, e array VFP eh 1-based contra o laco 0-based do
* legado - ver o cabecalho de stubarvorefase7.prg.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, loForm, loErro, lcArqSaida, loStub, loTree, lnAntes, lnDepois
LOCAL ARRAY laEv[1, 5]
PUBLIC gc_ArqProbe7
gc_ArqProbe7 = "C:\4c\tasks\task772\probar_form_fase7_resultado.txt"
lcArqSaida   = gc_ArqProbe7
lcSaida      = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task772\probar_form_fase7_erros.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPNOP")
SET PROCEDURE TO C:\4c\tasks\task772\stubbosigopnop.prg ADDITIVE
SET PROCEDURE TO C:\4c\tasks\task772\stubarvorefase7.prg ADDITIVE

lcSaida = lcSaida + "M2 ambiente ok" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

ON ERROR DO TratarErroProbe7 WITH ERROR(), MESSAGE(), PROGRAM(), LINENO()

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPNOP")
CATCH TO loErro
    lcSaida = lcSaida + "EXCECAO Init: " + loErro.Message + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loForm) != "O"
    lcSaida = lcSaida + "RESULTADO=NAO INSTANCIOU" + CHR(13) + CHR(10)
    STRTOFILE(lcSaida, lcArqSaida)
    ON ERROR
    QUIT
ENDIF

lcSaida = lcSaida + "P1 form instanciou (VARTYPE=" + VARTYPE(loForm) + ")" + CHR(13) + CHR(10)

*-- ===== P2: handlers existem e sao PUBLIC =====
lcSaida = lcSaida + "P2 CmdEncerrarClick existe=" + ;
          TRANSFORM(PEMSTATUS(loForm, "CmdEncerrarClick", 5)) + ;
          " protected=" + TRANSFORM(PEMSTATUS(loForm, "CmdEncerrarClick", 2)) + CHR(13) + CHR(10)
lcSaida = lcSaida + "P2 CmdExpandirClick existe=" + ;
          TRANSFORM(PEMSTATUS(loForm, "CmdExpandirClick", 5)) + ;
          " protected=" + TRANSFORM(PEMSTATUS(loForm, "CmdExpandirClick", 2)) + CHR(13) + CHR(10)
lcSaida = lcSaida + "P2 CmdRegredirClick existe=" + ;
          TRANSFORM(PEMSTATUS(loForm, "CmdRegredirClick", 5)) + ;
          " protected=" + TRANSFORM(PEMSTATUS(loForm, "CmdRegredirClick", 2)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P3: BINDEVENT entregue (AEVENTS) =====
IF AEVENTS(laEv, loForm.cmg_4c_Commandgroup1.Buttons(1)) > 0
    lcSaida = lcSaida + "P3 Encerrar <- " + TRANSFORM(laEv[1, 2]) + " -> " + ;
              TRANSFORM(laEv[1, 4]) + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "P3 Encerrar SEM BINDEVENT" + CHR(13) + CHR(10)
ENDIF

IF AEVENTS(laEv, loForm.cmd_4c_Fwbtng1) > 0
    lcSaida = lcSaida + "P3 Fwbtng1 <- " + TRANSFORM(laEv[1, 2]) + " -> " + ;
              TRANSFORM(laEv[1, 4]) + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "P3 Fwbtng1 SEM BINDEVENT" + CHR(13) + CHR(10)
ENDIF

IF AEVENTS(laEv, loForm.cmd_4c_Fwbtng2) > 0
    lcSaida = lcSaida + "P3 Fwbtng2 <- " + TRANSFORM(laEv[1, 2]) + " -> " + ;
              TRANSFORM(laEv[1, 4]) + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "P3 Fwbtng2 SEM BINDEVENT" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P4: arvore AUSENTE (estado real desta maquina) =====
lcSaida = lcSaida + "P4 ArvoreDisponivel (sem OCX)=" + ;
          TRANSFORM(PEMSTATUS(loForm.cnt_4c_Container1, "obj_4c_TreeView", 5)) + CHR(13) + CHR(10)

loForm.this_nNodeExp = 1
loForm.CmdExpandirClick()
lcSaida = lcSaida + "P4 Expandir sem arvore -> nNodeExp=" + ;
          TRANSFORM(loForm.this_nNodeExp) + " (esperado 1, guarda barrou)" + CHR(13) + CHR(10)
loForm.CmdRegredirClick()
lcSaida = lcSaida + "P4 Regredir sem arvore -> nNodeExp=" + ;
          TRANSFORM(loForm.this_nNodeExp) + " (esperado 1, guarda barrou)" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P5: arvore PRESENTE (stub, ListCount = 0) =====
loForm.cnt_4c_Container1.AddObject("obj_4c_TreeView", "StubArvoreFase7")
loTree = loForm.cnt_4c_Container1.obj_4c_TreeView
lcSaida = lcSaida + "P5 stub instalado VARTYPE=" + VARTYPE(loTree) + ;
          " ListCount=" + TRANSFORM(loTree.ListCount) + CHR(13) + CHR(10)

loForm.this_nNodeExp = 1
loForm.CmdExpandirClick()
lcSaida = lcSaida + "P5 Expandir arvore vazia -> nNodeExp=" + ;
          TRANSFORM(loForm.this_nNodeExp) + ;
          " (esperado 1: llExpande ficou .F., legado nao avanca)" + CHR(13) + CHR(10)

lnAntes = loForm.this_nNodeExp
loForm.CmdRegredirClick()
lnDepois = loForm.this_nNodeExp
lcSaida = lcSaida + "P5 Regredir de " + TRANSFORM(lnAntes) + " -> nNodeExp=" + ;
          TRANSFORM(lnDepois) + " (esperado 0: legado recua sempre que a guarda passa)" + ;
          CHR(13) + CHR(10)

loForm.CmdRegredirClick()
lcSaida = lcSaida + "P5 Regredir de 0 -> nNodeExp=" + ;
          TRANSFORM(loForm.this_nNodeExp) + " (esperado 0: nunca negativo)" + CHR(13) + CHR(10)

loForm.this_nNodeExp = 3
loForm.CmdRegredirClick()
lcSaida = lcSaida + "P5 Regredir de 3 -> nNodeExp=" + ;
          TRANSFORM(loForm.this_nNodeExp) + " (esperado 2)" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P6: Encerrar =====
loStub = CREATEOBJECT("StubBOSigOpNop")
loStub.this_cArquivoImagem = "C:\4c\tasks\task772\probe7_figura.jpg"
STRTOFILE("falsa figura", loStub.this_cArquivoImagem)
loForm.this_oBusinessObject = loStub
loForm.this_cArquivoFigura  = loStub.this_cArquivoImagem

lcSaida = lcSaida + "P6 antes: arquivo existe=" + ;
          TRANSFORM(FILE("C:\4c\tasks\task772\probe7_figura.jpg")) + ;
          " this_cArquivoFigura=[" + loForm.this_cArquivoFigura + "]" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

loForm.CmdEncerrarClick()

lcSaida = lcSaida + "P6 depois: form VARTYPE=" + VARTYPE(loForm) + ;
          " (esperado X = Release) arquivo existe=" + ;
          TRANSFORM(FILE("C:\4c\tasks\task772\probe7_figura.jpg")) + ;
          " (esperado .F.) stub zerou caminho=" + ;
          TRANSFORM(EMPTY(loStub.this_cArquivoImagem)) + CHR(13) + CHR(10)

lcSaida = lcSaida + "RESULTADO=OK" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)
ON ERROR
QUIT


PROCEDURE TratarErroProbe7(par_nErro, par_cMensagem, par_cPrograma, par_nLinha)
    STRTOFILE("ON ERROR: " + TRANSFORM(par_nErro) + " - " + par_cMensagem + ;
              " | PROG=" + par_cPrograma + " | LINHA=" + TRANSFORM(par_nLinha) + ;
              CHR(13) + CHR(10), gc_ArqProbe7, 1)
ENDPROC
