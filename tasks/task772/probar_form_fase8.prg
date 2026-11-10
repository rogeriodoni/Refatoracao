*==============================================================================
* probar_form_fase8.prg - Prova da Fase 8 (eventos auxiliares e consolidacao).
*
* Mede, pelo ARQUIVO DE SAIDA (nao pelo exit code):
*   P1 o form instancia com os metodos novos
*   P2 os TRES handlers novos EXISTEM e sao PUBLIC (PEMSTATUS attr 2 = .F.) -
*      metodo PROTECTED eh ignorado em silencio por BINDEVENT (CLAUDE.md #3);
*      e os dois auxiliares (EmpilharChaveNavegacao/AbrirFormZoomImagem)
*      existem e sao PROTECTED, porque so sao chamados de dentro da classe
*   P3 o BINDEVENT do img_4c_Imagem.DblClick foi ENTREGUE (AEVENTS)
*   P4 TreeViewKeyPress: guarda de argumento nao-numerico, ESC (27) e tecla
*      qualquer nao estouram
*   P5 TreeViewNodeClick com a arvore AUSENTE (ctTree.ocx nao registrado):
*      guarda barra e o estado de navegacao NAO muda
*   P6 TreeViewNodeClick com a arvore PRESENTE (StubArvoreFase8), os tres
*      cargos que decidem o ramo:
*        (a) cargo VAZIO  -> ELSE de fora; estado segue vazio (caso REAL do
*            legado, que nunca atribui cargo a no nenhum)
*        (b) cargo NUMERICO 0 -> tem de valer "vazio" tambem (TRANSFORM(0)
*            daria "0", que NAO eh vazio, e tornaria alcancavel o drill)
*        (c) cargo com TEXTO -> 1o clique REGISTRA; 2o clique no MESMO no
*            dispara o drill (empilha a chave + troca a chave corrente);
*            cargo DIFERENTE so re-registra
*   P7 EmpilharChaveNavegacao: a 1a chave ocupa o elemento que o Init criou e
*      da 2a em diante o array CRESCE (as tres linhas de pilha do legado)
*   P8 ImgImagemDblClick: sem cursor de produto eh no-op; COM cursor extrai a
*      foto para um .Jpg temporario, avisa que o SigOpZom nao esta migrado
*      (MsgAviso, suprimido em modo teste), APAGA o temporario e REPOE a area
*      de trabalho do chamador
*
* O cursor de produto eh criado DENTRO da datasession do form (DataSession=2):
* cursor criado na sessao do probe seria invisivel para os metodos do form.
*
* NAO fica provado aqui o laco por no (NodeLevel/NodeExpanded) nem o redesenho
* da arvore: exige o ctTree.ocx registrado - ver stubarvorefase8.prg.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, loForm, loErro, lcArqSaida, loStub, loTree, lcAliasAntes
LOCAL lnJpgAntes, lnJpgDepois, lnSessaoProbe
LOCAL ARRAY laEv[1, 5]
LOCAL ARRAY laArqTmp[1]
PUBLIC gc_ArqProbe8
gc_ArqProbe8 = "C:\4c\tasks\task772\probar_form_fase8_resultado.txt"
lcArqSaida   = gc_ArqProbe8
lcSaida      = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task772\probar_form_fase8_erros.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPNOP")
SET PROCEDURE TO C:\4c\tasks\task772\stubbosigopnop.prg ADDITIVE
SET PROCEDURE TO C:\4c\tasks\task772\stubarvorefase8.prg ADDITIVE

lcSaida = lcSaida + "M2 ambiente ok" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

ON ERROR DO TratarErroProbe8 WITH ERROR(), MESSAGE(), PROGRAM(), LINENO()

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

*-- ===== P2: metodos novos - escopo =====
lcSaida = lcSaida + "P2 TreeViewKeyPress existe=" + ;
          TRANSFORM(PEMSTATUS(loForm, "TreeViewKeyPress", 5)) + ;
          " protected=" + TRANSFORM(PEMSTATUS(loForm, "TreeViewKeyPress", 2)) + ;
          " (esperado .T./.F.)" + CHR(13) + CHR(10)
lcSaida = lcSaida + "P2 TreeViewNodeClick existe=" + ;
          TRANSFORM(PEMSTATUS(loForm, "TreeViewNodeClick", 5)) + ;
          " protected=" + TRANSFORM(PEMSTATUS(loForm, "TreeViewNodeClick", 2)) + ;
          " (esperado .T./.F.)" + CHR(13) + CHR(10)
lcSaida = lcSaida + "P2 ImgImagemDblClick existe=" + ;
          TRANSFORM(PEMSTATUS(loForm, "ImgImagemDblClick", 5)) + ;
          " protected=" + TRANSFORM(PEMSTATUS(loForm, "ImgImagemDblClick", 2)) + ;
          " (esperado .T./.F.)" + CHR(13) + CHR(10)
lcSaida = lcSaida + "P2 EmpilharChaveNavegacao existe=" + ;
          TRANSFORM(PEMSTATUS(loForm, "EmpilharChaveNavegacao", 5)) + ;
          " protected=" + TRANSFORM(PEMSTATUS(loForm, "EmpilharChaveNavegacao", 2)) + ;
          " (esperado .T./.T.)" + CHR(13) + CHR(10)
lcSaida = lcSaida + "P2 AbrirFormZoomImagem existe=" + ;
          TRANSFORM(PEMSTATUS(loForm, "AbrirFormZoomImagem", 5)) + ;
          " protected=" + TRANSFORM(PEMSTATUS(loForm, "AbrirFormZoomImagem", 2)) + ;
          " (esperado .T./.T.)" + CHR(13) + CHR(10)
lcSaida = lcSaida + "P2 this_cChaveNavegacao existe=" + ;
          TRANSFORM(PEMSTATUS(loForm, "this_cChaveNavegacao", 5)) + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P3: BINDEVENT do DblClick da imagem =====
IF AEVENTS(laEv, loForm.img_4c_Imagem) > 0
    lcSaida = lcSaida + "P3 img_4c_Imagem <- " + TRANSFORM(laEv[1, 2]) + " -> " + ;
              TRANSFORM(laEv[1, 4]) + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "P3 img_4c_Imagem SEM BINDEVENT" + CHR(13) + CHR(10)
ENDIF
lcSaida = lcSaida + "P3 arvore no form (sem OCX)=" + ;
          TRANSFORM(PEMSTATUS(loForm.cnt_4c_Container1, "obj_4c_TreeView", 5)) + ;
          " (esperado .F. nesta maquina)" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P4: TreeViewKeyPress =====
loForm.TreeViewKeyPress()
lcSaida = lcSaida + "P4 KeyPress sem argumento -> sobreviveu" + CHR(13) + CHR(10)
loForm.TreeViewKeyPress(65)
lcSaida = lcSaida + "P4 KeyPress 65 (tecla qualquer) -> sobreviveu" + CHR(13) + CHR(10)
loForm.TreeViewKeyPress(27)
lcSaida = lcSaida + "P4 KeyPress 27 (ESC) -> sobreviveu, form VARTYPE=" + ;
          VARTYPE(loForm) + " (esperado O: RELEASE WINDOWS nao fecha form)" + ;
          CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P5: NodeClick com a arvore AUSENTE =====
loForm.this_cUltimoNoClicado = "SENTINELA"
loForm.TreeViewNodeClick(0, 0)
lcSaida = lcSaida + "P5 NodeClick sem arvore -> this_cUltimoNoClicado=[" + ;
          loForm.this_cUltimoNoClicado + "] (esperado SENTINELA: guarda barrou)" + ;
          CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P6: NodeClick com a arvore PRESENTE (stub) =====
loForm.cnt_4c_Container1.AddObject("obj_4c_TreeView", "StubArvoreFase8")
loTree = loForm.cnt_4c_Container1.obj_4c_TreeView
lcSaida = lcSaida + "P6 stub instalado VARTYPE=" + VARTYPE(loTree) + CHR(13) + CHR(10)

*-- (a) cargo VAZIO - o caso REAL do legado
loForm.this_cUltimoNoClicado = ""
loTree.uCargoFalso = ""
loForm.TreeViewNodeClick(0, 0)
loForm.TreeViewNodeClick(0, 0)
lcSaida = lcSaida + "P6a cargo vazio, 2 cliques -> ultimoNo=[" + ;
          loForm.this_cUltimoNoClicado + "] chaveNav=[" + ;
          loForm.this_cChaveNavegacao + "] (esperado ultimoNo vazio e chaveNav intacta: drill " + ;
          "inalcancavel, como no legado)" + CHR(13) + CHR(10)

*-- (b) cargo NUMERICO zero - tem de valer "vazio"
loForm.this_cUltimoNoClicado = ""
loForm.this_cChaveNavegacao  = STR(0, 6)   && valor que o InicializarForm poe
loTree.uCargoFalso = 0
loForm.TreeViewNodeClick(0, 0)
loForm.TreeViewNodeClick(0, 0)
lcSaida = lcSaida + "P6b cargo numerico 0, 2 cliques -> ultimoNo=[" + ;
          TRANSFORM(loForm.this_cUltimoNoClicado) + "] chaveNav=[" + ;
          TRANSFORM(loForm.this_cChaveNavegacao) + "] (esperado ultimoNo vazio e " + ;
          "chaveNav intacta - TRANSFORM(0) daria 0 e abriria o drill)" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- (c) cargo com TEXTO - 1o clique registra, 2o clique no MESMO no drilla
loForm.this_cUltimoNoClicado = ""
loForm.this_cChaveNavegacao  = STR(0, 6)   && valor que o InicializarForm poe
DIMENSION loForm.this_aEmpDopNums[1]
loForm.this_aEmpDopNums[1] = ""

loTree.uCargoFalso = "001MALOTE                   3"
loForm.TreeViewNodeClick(0, 0)
lcSaida = lcSaida + "P6c 1o clique -> ultimoNo=[" + loForm.this_cUltimoNoClicado + ;
          "] chaveNav=[" + loForm.this_cChaveNavegacao + ;
          "] (esperado ultimoNo = cargo, chaveNav ainda = STR(0,6))" + CHR(13) + CHR(10)

loForm.TreeViewNodeClick(0, 0)
lcSaida = lcSaida + "P6c 2o clique no MESMO no -> chaveNav=[" + ;
          loForm.this_cChaveNavegacao + "] pilha[1]=[" + ;
          TRANSFORM(loForm.this_aEmpDopNums[1]) + "] ALEN=" + ;
          TRANSFORM(ALEN(loForm.this_aEmpDopNums)) + ;
          " (esperado chaveNav = cargo, pilha[1] = chave ANTERIOR STR(0,6), ALEN 1)" + ;
          CHR(13) + CHR(10)

loTree.uCargoFalso = "002OUTRO                    7"
loForm.TreeViewNodeClick(0, 0)
lcSaida = lcSaida + "P6c cargo DIFERENTE -> ultimoNo=[" + ;
          loForm.this_cUltimoNoClicado + "] ALEN=" + ;
          TRANSFORM(ALEN(loForm.this_aEmpDopNums)) + ;
          " (esperado re-registro, sem crescer a pilha)" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P7: pilha de chaves, pelo caminho PUBLICO =====
*-- EmpilharChaveNavegacao eh PROTECTED de proposito (so o NodeClick a chama),
*-- entao a pilha eh exercitada por DOIS drills seguidos: cada drill empilha a
*-- chave ANTERIOR e passa a chave corrente a ser o cargo do no.
DIMENSION loForm.this_aEmpDopNums[1]
loForm.this_aEmpDopNums[1]   = ""
loForm.this_cUltimoNoClicado = ""
loForm.this_cChaveNavegacao  = STR(0, 6)   && valor que o InicializarForm poe

loTree.uCargoFalso = "CHAVE-A"
loForm.TreeViewNodeClick(0, 0)
loForm.TreeViewNodeClick(0, 0)
lcSaida = lcSaida + "P7 1o drill -> ALEN=" + TRANSFORM(ALEN(loForm.this_aEmpDopNums)) + ;
          " [1]=[" + loForm.this_aEmpDopNums[1] + "] chaveNav=[" + ;
          loForm.this_cChaveNavegacao + "] (esperado ALEN 1, [1] = STR(0,6), " + ;
          "chaveNav CHAVE-A)" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

loTree.uCargoFalso = "CHAVE-B"
loForm.TreeViewNodeClick(0, 0)
loForm.TreeViewNodeClick(0, 0)
lcSaida = lcSaida + "P7 2o drill -> ALEN=" + TRANSFORM(ALEN(loForm.this_aEmpDopNums)) + ;
          " chaveNav=[" + loForm.this_cChaveNavegacao + ;
          "] (esperado ALEN 2, chaveNav CHAVE-B)" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

IF ALEN(loForm.this_aEmpDopNums) >= 2
    lcSaida = lcSaida + "P7 pilha -> [1]=[" + loForm.this_aEmpDopNums[1] + ;
              "] [2]=[" + loForm.this_aEmpDopNums[2] + ;
              "] (esperado [1] = STR(0,6) e [2] CHAVE-A)" + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "P7 pilha NAO CRESCEU" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcSaida, lcArqSaida)

*-- ===== P8: ImgImagemDblClick =====
loStub = CREATEOBJECT("StubBOSigOpNop")
loForm.this_oBusinessObject = loStub

*-- (sem cursor de produto: no-op)
loForm.ImgImagemDblClick()
lcSaida = lcSaida + "P8 sem cursor de produto -> sobreviveu (no-op)" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

*-- Cursor de produto DENTRO da datasession do form (DataSession = 2)
lnSessaoProbe = SET("Datasession")
SET DATASESSION TO loForm.DataSessionId
CREATE CURSOR cursor_4c_Produto (Cpros C(14), Dpros C(40), FigJpgs M)
APPEND BLANK
REPLACE Cpros   WITH "0000000000TESTE", ;
        Dpros   WITH "PRODUTO DE TESTE", ;
        FigJpgs WITH "conteudo-falso-de-figura"
GO TOP
*-- Area de trabalho que o metodo tem de REPOR ao sair
CREATE CURSOR cursor_4c_Sentinela (c C(1))
lcAliasAntes = ALIAS()
SET DATASESSION TO (lnSessaoProbe)

lcSaida = lcSaida + "P8 cursor criado na sessao " + TRANSFORM(loForm.DataSessionId) + ;
          ", alias corrente antes=[" + lcAliasAntes + "]" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

lnJpgAntes = ADIR(laArqTmp, SYS(2023) + "\*.Jpg")

loForm.ImgImagemDblClick()

lnJpgDepois = ADIR(laArqTmp, SYS(2023) + "\*.Jpg")

SET DATASESSION TO loForm.DataSessionId
lcSaida = lcSaida + "P8 depois: alias corrente=[" + ALIAS() + "] (esperado " + ;
          lcAliasAntes + " = area REPOSTA)" + CHR(13) + CHR(10)
SET DATASESSION TO (lnSessaoProbe)

*-- O temporario eh criado com SYS(2015) (nome novo a cada chamada) e apagado
*-- pelo proprio metodo: o que se mede eh o SALDO de .Jpg em SYS(2023), que
*-- tem de ser ZERO (criou e apagou).
lcSaida = lcSaida + "P8 .Jpg em SYS(2023) antes=" + TRANSFORM(lnJpgAntes) + ;
          " depois=" + TRANSFORM(lnJpgDepois) + " saldo=" + ;
          TRANSFORM(lnJpgDepois - lnJpgAntes) + ;
          " (esperado saldo 0: o metodo apaga o que cria)" + CHR(13) + CHR(10)

lcSaida = lcSaida + "RESULTADO=OK" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)
ON ERROR
QUIT


PROCEDURE TratarErroProbe8(par_nErro, par_cMensagem, par_cPrograma, par_nLinha)
    STRTOFILE("ON ERROR: " + TRANSFORM(par_nErro) + " - " + par_cMensagem + ;
              " | PROG=" + par_cPrograma + " | LINHA=" + TRANSFORM(par_nLinha) + ;
              CHR(13) + CHR(10), gc_ArqProbe8, 1)
ENDPROC
