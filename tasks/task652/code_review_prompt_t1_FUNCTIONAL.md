# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.ArvoreDisponivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterTextoNivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.TextoNivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCAU.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1157 linhas total):

*-- Linhas 30 a 152:
30: * ClassInfo do dump: "pnnodeexp / podatamgr / *maketree" sao os UNICOS
31: * membros customizados; podatamgr eh substituido pelo gnConnHandle global
32: * do sistema novo, ja usado em SIGOPCAUBO.MontarArvoreAcessos), Init()/
33: * InicializarForm()/Destroy().
34: *
35: * FASE 4/8 - LISTA (ARVORE) + BOTOES + METODO DE CARGA:
36: *   ConfigurarControles() cria, direto na Form (layout flat sem container,
37: *   fiel ao legado):
38: *     lbl_4c_Label1/txt_4c_CUsu/txt_4c_DUsu - filtro por Usuario (codigo+nome)
39: *     lbl_4c_Label2/txt_4c_Grupo             - filtro por Grupo
40: *     cmg_4c_Commandgroup1 - 3 botoes: Expandir Niveis / Recolher Niveis /
41: *                            Encerrar (Command1/Command2/Command3 do legado,
42: *                            cada um com o proprio Click - NAO o Click do
43: *                            grupo). Prefixo canonico cmg_4c_ para
44: *                            CommandGroup (PILAR 3) - mapeamento.json
45: *                            atualizado junto.
46: *     obj_4c_TreeView      - arvore hierarquica (controle ActiveX de terceiros,
47: *                            confirmado "cttree.ocx" embutido no SIGOPCAU.sct,
48: *                            sem substituto nativo VFP9 - instanciado via
49: *                            OLEControl("cttree.cttreeview"), guardado em
50: *                            TRY/CATCH e pulado em gb_4c_ValidandoUI/
51: *                            gb_4c_ModoTeste. NAO trocar por MSComctlLib.
52: *                            TreeCtrl: trava o VFP9 num modal de licenca que
53: *                            TRY/CATCH nao intercepta - mesmo padrao de
54: *                            FormSIGMVMVT.prg/ConfigurarControles)
55: *   CarregarDados() - metodo de carga desta tela, equivalente ao PROCEDURE
56: *                     maketree do legado: pede o cursor de acessos ao
57: *                     SIGOPCAUBO e desenha a arvore inteira (PopularArvore).
58: *   BtnExpandirClick/BtnRecolherClick/BtnEncerrarClick - Command1/2/3.Click
59: *                     do legado, transcritos linha a linha.
60: *   CUsuGotFocus/GrupoGotFocus - GotFocus de GetcUsu/GetGrupo do legado
61: *                     (ClearNodes). GetDUsu NAO declara GotFocus no dump.
62: *
63: * BINDEVENT so eh registrado para handler que JA existe: medido no VFP9 em
64: * 2026-10-17 (automation\medir_bindevent_delegate.prg) que BINDEVENT com
65: * delegate inexistente estoura NA HORA DO BIND com "Property <X> is not
66: * found." - nao eh resolvido em runtime. Como ConfigurarControles roda
67: * dentro de InicializarForm, um bind sem handler derrubaria a abertura da
68: * tela. Por isso os binds de LostFocus (equivalente ao Valid: lookup
69: * fwBuscaExt contra SigCdUsu/SigCdGrA + remontagem da arvore) entram na
70: * Fase 6, JUNTO com os respectivos handlers.
71: *
72: * O Change/KeyPress/NodeClick do TreeView legado NAO sao reproduzidos: no
73: * dump os tres corpos estao vazios ou comentados com *!* ("*!* This.
74: * NodeClick(nIndex)"), isto eh, nao tem comportamento nenhum - criar handler
75: * para eles seria stub.
76: *
77: * As 3 imagens da arvore (Menu1.Bmp = indice 1, x_planilha1.bmp = 2,
78: * MsgStop1.Gif = 3), carregadas no Init legado via AddImage, sao carregadas
79: * UMA unica vez em PrepararArvore() sob guarda de this_lImagensArvore:
80: * AddImage repetido empilharia indices e quebraria os indices fixos 1/2/3
81: * usados em AddPictureNode - mesmo padrao de PrepararArvore() em
82: * FormSIGMVMVT.prg.
83: *
84: * DESVIO DOCUMENTADO (ja registrado em SIGOPCAUBO.prg): no ramo "filtro por
85: * Grupo" do legado (maketree, Else final) o SCX repete por engano
86: * ThisForm.GetcUsu.Value (sempre vazio nesse ramo) no lugar de
87: * ThisForm.GetGrupo.Value - typo que faz a busca por Grupo nunca trazer
88: * nada no legado. O BO usa this_cGrupos (o campo correto), preservando a
89: * INTENCAO da consulta.
90: *
91: * FASE 5/8 - AUDITORIA DE PROPRIEDADES: este legado eh FLAT e SEM Page2 de
92: * Dados (ver nota acima sobre a arvore de objetos nao ter PageFrame nem
93: * Container), e a Fase 4 ja criou os 7 controles de uma vez so dentro de
94: * ConfigurarControles() - nao ha campo NOVO para "a primeira metade"
95: * acrescentar (inventar Page2/ConfigurarPaginaDados violaria o PILAR 1 e a
96: * regra "NUNCA inventar estrutura que o legado nao tem"). O trabalho real
97: * desta fase foi conferir, propriedade a propriedade, o que a Fase 4
98: * transcreveu contra a SECAO 2 do dump: faltava .AutoSize = .T. em
99: * cmg_4c_Commandgroup1 (unica lacuna - os TabIndex de lbl_4c_Label1/Label2
100: * foram deliberadamente NAO transcritos, porque Label nao tem TabStop e
101: * numera-los so embaralharia a ordem dos controles que de fato param o Tab).
102: *
103: * FASE 6/8 - LOOKUPS: implementa os tres PROCEDURE Valid do legado
104: * (GetcUsu/GetDUsu/GetGrupo), que a Fase 4 deixou para esta fase (ver nota
105: * acima sobre BINDEVENT exigir delegate ja existente):
106: *   ValidarCUsu/ValidarCUsuExec   - LostFocus de txt_4c_CUsu (busca por
107: *                                   codigo em SigCdUsu via AbrirBuscaUsuario)
108: *   ValidarDUsu/ValidarDUsuExec   - LostFocus de txt_4c_DUsu (mesma busca,
109: *                                   mas pela coluna nComps - nome)
110: *   ValidarGrupo/ValidarGrupoExec - LostFocus de txt_4c_Grupo (busca em
111: *                                   SigCdGrA via AbrirBuscaGrupo)
112: *   AbrirBuscaUsuario/AbrirBuscaGrupo - abrem FormBuscaAuxiliar (contrato da
113: *                                   regra CLAUDE.md #37: Init ja tenta match
114: *                                   exato; Show() so quando NAO achou).
115: *   AtualizarHabilitacaoFiltros  - equivalente aos tres guards When do
116: *                                   legado (GetcUsu/GetGrupo mutuamente
117: *                                   exclusivos; GetDUsu so digitavel quando
118: *                                   os dois outros estao vazios) - ver nota
119: *                                   no topo do arquivo.
120: * Todos ligados por LostFocus (nunca KeyPress sem testar a tecla - regra
121: * CLAUDE.md #47), com guarda de reentrancia this_lEmLookup (regra #37): o
122: * picker e MODAL e tira o foco do campo, o que poderia redisparar o proprio
123: * LostFocus.
124: *
125: * FASE 7/8 - EVENTOS PRINCIPAIS: NAO adiciona BtnIncluirClick/BtnAlterarClick/
126: * BtnVisualizarClick/BtnExcluirClick. O legado (SIGOPCAU.SCX) nao e um
127: * frmcadastro - a arvore de objetos (ver nota no topo do arquivo) nao tem
128: * Grupo_Op nem pcEscolha propria, e o unico CommandGroup do dump
129: * (Commandgroup1, ButtonCount = 3) ja foi transcrito na Fase 4 como
130: * BtnExpandirClick/BtnRecolherClick/BtnEncerrarClick - esses SAO os "eventos
131: * principais dos botoes" desta tela. Inventar os 4 metodos CRUD canonicos
132: * violaria o PILAR 1 e a regra "NUNCA inventar funcionalidade que o legado
133: * nao tem" (seriam stubs disfarcados, sem nenhum Click correspondente no
134: * SCX original para transcrever).
135: *
136: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL: NAO adiciona
137: * BtnBuscarClick/BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
138: * HabilitarCampos/LimparCampos/CarregarLista/AjustarBotoesPorModo. Esse
139: * conjunto eh convencao do form CRUD (frmcadastro: Page1=Lista populada por
140: * CarregarLista + Page2=Dados com modo INCLUIR/ALTERAR/VISUALIZAR
141: * transferido por FormParaBO/BOParaForm e descartavel por
142: * BtnCancelarClick). O SIGOPCAU nao tem nenhuma dessas pecas no legado (ver
143: * nota no topo do arquivo: raiz "Class: form, BaseClass: form", sem
144: * PageFrame nem pcEscolha) e cada uma ja tem o equivalente real, construido
145: * nas fases anteriores, com o nome que reflete o que de fato faz:
146: *
147: *   BtnBuscarClick    -> nao existe botao "Buscar" no legado. O papel de
148: *                        buscar/filtrar jah eh cumprido pelos tres LostFocus
149: *                        de lookup (ValidarCUsu/ValidarDUsu/ValidarGrupo,
150: *                        Fase 6), que disparam CarregarDados() a cada filtro
151: *                        resolvido - exatamente como o Valid do legado
152: *                        encadeia no MakeTree.

*-- Linhas 202 a 331:
202: * anteriores.
203: *
204: * CHAMADA (menu.prg):
205: *   loForm = CREATEOBJECT("FormSIGOPCAU")
206: *   loForm.Show()
207: *==============================================================================
208: 
209: DEFINE CLASS FormSIGOPCAU AS FormBase
210: 
211:     *-- Dimensoes e comportamento identicos ao legado (SIGOPCAU.SCX)
212:     Height      = 600
213:     Width       = 800
214:     AutoCenter  = .T.
215:     BorderStyle = 2
216:     ControlBox  = .F.
217:     DataSession = 2
218:     ShowTips    = .T.
219: 
220:     *-- Canonico do projeto para form aberto via menu.prg (CREATEOBJECT +
221:     *-- variavel LOCAL + Show()) - NAO transcrever o WindowType=0 implicito
222:     *-- do baseclass "form" do SCX: Show() modeless retorna na hora, a
223:     *-- referencia local cai e o Destroy dispara antes do usuario ver a
224:     *-- tela (435 dos 459 forms do projeto usam este par).
225:     WindowType = 1
226:     ShowWindow = 1
227: 
228:     *-- ThisForm.pnNodeExp do legado - nivel de expansao corrente da arvore,
229:     *-- usado por Command1(Expandir)/Command2(Recolher).
230:     this_nNodeExp = 0
231: 
232:     *-- Guarda de carga unica das 3 imagens da arvore (ver cabecalho).
233:     this_lImagensArvore = .F.
234: 
235:     *-- Guarda de reentrancia dos lookups (regra CLAUDE.md #47/#37): o
236:     *-- picker (FormBuscaAuxiliar) eh MODAL e tira o foco do campo, o que
237:     *-- poderia redisparar o proprio LostFocus. So um dos tres campos pode
238:     *-- estar em foco por vez, entao uma flag unica compartilhada basta.
239:     this_lEmLookup = .F.
240: 
241:     *==========================================================================
242:     * Init - FormBase.Init() (via DODEFAULT) chama InicializarForm() e
243:     * aplica os SETs de data/hora da DataSession privada (regra CLAUDE.md
244:     * #9.4 - obrigatorio por este form ter DataSession = 2).
245:     *==========================================================================
246:     PROCEDURE Init()
247:         RETURN DODEFAULT()
248:     ENDPROC
249: 
250:     *==========================================================================
251:     * InicializarForm - Instancia o Business Object, reinicializa o estado
252:     * de navegacao da arvore e cria os controles visuais.
253:     *==========================================================================
254:     PROTECTED PROCEDURE InicializarForm()
255:         LOCAL loc_lSucesso
256:         loc_lSucesso = .F.
257: 
258:         THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCAUBO")
259: 
260:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
261:             MsgErro("Falha ao criar SIGOPCAUBO", "Erro")
262:         ELSE
263:             THIS.Caption = "Consulta de Acessos de Usu" + CHR(225) + "rio"
264: 
265:             *-- Picture = ..\framework\imagens\new_background.jpg no legado -
266:             *-- caminho resolvido via gc_4c_CaminhoFramework (regra CLAUDE.md
267:             *-- #27/Pattern #170 - NUNCA gc_4c_CaminhoBase + "Framework\...").
268:             IF FILE(gc_4c_CaminhoFramework + "imagens\new_background.jpg")
269:                 THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
270:             ENDIF
271: 
272:             *-- Reinicializa o estado de navegacao da arvore (equivalente ao
273:             *-- "ThisForm.pnNodeExp = 0" ao final do maketree legado).
274:             THIS.this_nNodeExp = 0
275: 
276:             THIS.ConfigurarControles()
277:             THIS.TornarControlesVisiveis(THIS)
278: 
279:             loc_lSucesso = .T.
280:         ENDIF
281: 
282:         RETURN loc_lSucesso
283:     ENDPROC
284: 
285:     *==========================================================================
286:     * ConfigurarControles - Cria os controles visuais da tela (layout FLAT,
287:     * sem PageFrame/Container, direto na Form - fiel ao SIGOPCAU.SCX, ver
288:     * nota no cabecalho do arquivo sobre a ausencia de PageFrame/Container
289:     * no legado). Propriedades transcritas da SECAO 2 do dump.
290:     *==========================================================================
291:     PROTECTED PROCEDURE ConfigurarControles()
292:         LOCAL loc_oErrOle
293: 
294:         *-- lbl_4c_Label1 "Usuario : " (classe label do legado - AutoSize=.T.
295:         *-- no SCX eh no-op em Label criado por AddObject, regra CLAUDE.md
296:         *-- #23: transcrever Width/Height do dump em vez de confiar nisso)
297:         THIS.AddObject("lbl_4c_Label1", "Label")
298:         WITH THIS.lbl_4c_Label1
299:             .Top       = 144
300:             .Left      = 286
301:             .Width     = 64
302:             .Height    = 15
303:             .Alignment = 0
304:             .AutoSize  = .F.
305:             .FontName  = "Verdana"
306:             .FontSize  = 8
307:             .FontBold  = .T.
308:             .BackStyle = 0
309:             .ForeColor = RGB(36, 84, 155)
310:             .Caption   = "Usu" + CHR(225) + "rio : "
311:             .Visible   = .T.
312:         ENDWITH
313: 
314:         *-- txt_4c_CUsu (GetcUsu) - codigo do usuario filtrado
315:         THIS.AddObject("txt_4c_CUsu", "TextBox")
316:         WITH THIS.txt_4c_CUsu
317:             .Top       = 141
318:             .Left      = 348
319:             .Width     = 96
320:             .Height    = 23
321:             .Alignment = 0
322:             .FontName  = "Courier New"
323:             .Format    = "!"
324:             .MaxLength = 10
325:             .TabIndex  = 2
326:             .Value     = ""
327:             .Visible   = .T.
328:         ENDWITH
329: 
330:         *-- txt_4c_DUsu (GetDUsu) - nome do usuario (preenchido pelo lookup)
331:         THIS.AddObject("txt_4c_DUsu", "TextBox")

*-- Linhas 454 a 563:
454:             .Visible = .T.
455:         ENDWITH
456: 
457:         *-- BINDEVENT exige que o metodo delegate JA exista e seja PUBLIC
458:         *-- (regra CLAUDE.md #3 + medicao de 2026-10-17 citada no cabecalho).
459:         BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnExpandirClick")
460:         BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnRecolherClick")
461:         BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(3), "Click", THIS, "BtnEncerrarClick")
462: 
463:         *-- GotFocus dos campos de filtro (ClearNodes, igual ao legado - so
464:         *-- GetcUsu e GetGrupo declaram esse evento no dump).
465:         BINDEVENT(THIS.txt_4c_CUsu,  "GotFocus", THIS, "CUsuGotFocus")
466:         BINDEVENT(THIS.txt_4c_Grupo, "GotFocus", THIS, "GrupoGotFocus")
467: 
468:         *-- Lookup (equivalente ao Valid do legado - fwBuscaExt contra
469:         *-- SigCdUsu/SigCdGrA). Vai em "LostFocus" (ao SAIR do campo), nunca
470:         *-- em "KeyPress" sem testar a tecla (regra CLAUDE.md #47: picker
471:         *-- ligado a KeyPress sem guard abre a CADA tecla digitada).
472:         BINDEVENT(THIS.txt_4c_CUsu,  "LostFocus", THIS, "ValidarCUsu")
473:         BINDEVENT(THIS.txt_4c_DUsu,  "LostFocus", THIS, "ValidarDUsu")
474:         BINDEVENT(THIS.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupo")
475: 
476:         *-- Estado inicial dos guards de exclusividade mutua (GetcUsu.When/
477:         *-- GetGrupo.When/GetDUsu.When do legado - ver AtualizarHabilitacaoFiltros).
478:         THIS.AtualizarHabilitacaoFiltros()
479: 
480:         *-- obj_4c_TreeView - NAO instanciar em modo teste: AddObject
481:         *-- OLEControl pode travar sem usuario, e o OCX pode nao estar
482:         *-- registrado na maquina de build - nesse caso a arvore fica
483:         *-- ausente mas o resto da tela funciona (guard em TRY/CATCH, sem
484:         *-- impedir a abertura do form - ver ArvoreDisponivel()).
485:         IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
486:            (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
487:             TRY
488:                 THIS.AddObject("obj_4c_TreeView", "OLEControl", "cttree.cttreeview")
489:                 WITH THIS.obj_4c_TreeView
490:                     .Top      = 169
491:                     .Left     = 29
492:                     .Height   = 406
493:                     .Width    = 738
494:                     .TabIndex = 4
495:                     .Visible  = .T.
496:                 ENDWITH
497:             CATCH TO loc_oErrOle
498:                 MsgErro("Controle de " + CHR(225) + "rvore (ctTree.ocx) indispon" + ;
499:                         CHR(237) + "vel nesta esta" + CHR(231) + CHR(227) + "o: " + ;
500:                         loc_oErrOle.Message, "Aviso")
501:             ENDTRY
502:         ENDIF
503:     ENDPROC
504: 
505:     *==========================================================================
506:     * TornarControlesVisiveis - AddObject cria controles com Visible = .F.;
507:     * este metodo percorre recursivamente o container e torna tudo visivel.
508:     * Este form nao tem container que nasca oculto no legado (os 7 controles
509:     * sao todos visiveis no SCX), entao nao ha lista de excecao.
510:     *==========================================================================
511:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
512:         LOCAL loc_nI, loc_oObjeto
513: 
514:         FOR loc_nI = 1 TO par_oContainer.ControlCount
515:             loc_oObjeto = par_oContainer.Controls(loc_nI)
516: 
517:             IF VARTYPE(loc_oObjeto) = "O"
518:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
519:                     loc_oObjeto.Visible = .T.
520:                 ENDIF
521: 
522:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
523:                     THIS.TornarControlesVisiveis(loc_oObjeto)
524:                 ENDIF
525:             ENDIF
526:         ENDFOR
527:     ENDPROC
528: 
529:     *==========================================================================
530:     * ArvoreDisponivel - .T. somente quando o OLEControl da arvore foi criado
531:     * com sucesso em ConfigurarControles. O ctTree.ocx pode nao estar
532:     * registrado na estacao (ou o form estar em modo teste) e, nesse caso,
533:     * TODA chamada a API de nos tem de ser evitada - o objeto simplesmente
534:     * nao existe e qualquer referencia derrubaria o metodo.
535:     *==========================================================================
536:     PROTECTED FUNCTION ArvoreDisponivel()
537:         RETURN PEMSTATUS(THIS, "obj_4c_TreeView", 5) AND ;
538:                VARTYPE(THIS.obj_4c_TreeView) = "O"
539:     ENDFUNC
540: 
541:     *==========================================================================
542:     * TextoNivel - Le um elemento do vetor de niveis como TEXTO. DIMENSION
543:     * que CRESCE o vetor inicializa os elementos novos como Logico .F.
544:     * (e o proprio legado testa isso com Type('laNivel[lnNivel]') = 'L'):
545:     * aplicar UPPER()/comparar com string num elemento ainda nao atribuido
546:     * dispararia "Operator/operand type mismatch". Devolver "" reproduz o
547:     * tratamento que o legado da ao elemento nao inicializado.
548:     *==========================================================================
549:     PROTECTED FUNCTION TextoNivel(par_uElemento)
550:         IF VARTYPE(par_uElemento) = "C"
551:             RETURN par_uElemento
552:         ENDIF
553:         RETURN ""
554:     ENDFUNC
555: 
556:     *==========================================================================
557:     * ObterTextoNivel - Transcricao da expressao que o maketree legado repete
558:     * tres vezes para recortar UM nivel do texto hierarquico separado por "-":
559:     *   Alltrim(Substr(lcDesc, Iif(lnNivel=1, 1, At('-',lcDesc,lnNivel-1)+1), ;
560:     *          At('-',lcDesc,lnNivel) - Iif(lnNivel=1,1,At('-',lcDesc,lnNivel-1)+1) - 1))
561:     * Extraida para metodo para nao reescrever a formula em cada site (a
562:     * expressao eh regra de negocio - regra CLAUDE.md #17).
563:     * Quando nao existe o N-esimo "-" a formula original produziria tamanho

*-- Linhas 591 a 755:
591:     * fica por ULTIMO para que uma divergencia de interface do controle nao
592:     * descarte os SETs anteriores.
593:     *==========================================================================
594:     PROTECTED PROCEDURE PrepararArvore()
595:         LOCAL loc_oErro
596: 
597:         IF THIS.ArvoreDisponivel()
598:             TRY
599:                 WITH THIS.obj_4c_TreeView
600:                     IF !THIS.this_lImagensArvore
601:                         .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "Menu1.Bmp"))
602:                         .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "x_planilha1.bmp"))
603:                         .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "MsgStop1.Gif"))
604:                         THIS.this_lImagensArvore = .T.
605:                     ENDIF
606: 
607:                     .ClearNodes
608:                     .TipsDisplay   = .T.
609:                     .SmallIcons    = .T.
610:                     .PicAlign      = 0
611:                     .SelectedStyle = 2
612:                     .PictureType   = 1
613:                     .ExpandOnDClick
614:                 ENDWITH
615:             CATCH TO loc_oErro
616:                 MsgErro("Falha ao preparar a " + CHR(225) + "rvore: " + ;
617:                         loc_oErro.Message + CHR(13) + ;
618:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
619:                         "Procedure: " + loc_oErro.Procedure, "Erro")
620:             ENDTRY
621:         ENDIF
622:     ENDPROC
623: 
624:     *==========================================================================
625:     * LimparArvore - ClearNodes puro, como no GotFocus de GetcUsu/GetGrupo do
626:     * legado ("m.loTree1 = ThisForm.TreeView / m.loTree1.ClearNodes").
627:     * Zera tambem o nivel de expansao corrente, porque sem nos nao ha nivel
628:     * expandido - o legado reseta pnNodeExp no fim do maketree seguinte.
629:     *==========================================================================
630:     PROTECTED PROCEDURE LimparArvore()
631:         LOCAL loc_oErro
632: 
633:         IF THIS.ArvoreDisponivel()
634:             TRY
635:                 THIS.obj_4c_TreeView.ClearNodes
636:                 THIS.this_nNodeExp = 0
637:             CATCH TO loc_oErro
638:                 MsgErro("Falha ao limpar a " + CHR(225) + "rvore: " + ;
639:                         loc_oErro.Message + CHR(13) + ;
640:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
641:                         "Procedure: " + loc_oErro.Procedure, "Erro")
642:             ENDTRY
643:         ENDIF
644:     ENDPROC
645: 
646:     *==========================================================================
647:     * CarregarDados - Metodo de carga desta tela (equivalente ao PROCEDURE
648:     * maketree do legado). Transfere os filtros da tela para o Business
649:     * Object, pede o cursor de acessos (SIGOPCAUBO.MontarArvoreAcessos -
650:     * SigCdAcU/SigCdAcG/SigCdPrg, ou SigCdPrg puro para o super-usuario
651:     * '4CONTROL') e desenha a arvore inteira em PopularArvore().
652:     *
653:     * O guard "pelo menos um filtro preenchido" eh o que o legado escreve nos
654:     * TRES call sites do MakeTree (GetcUsu.Valid/GetDUsu.Valid/GetGrupo.Valid:
655:     * "If ! Empty(This.Value) Or ! Empty(This.Parent.GetGrupo.Value)"). Ele
656:     * mora aqui para o metodo ser seguro vindo de qualquer chamador: sem
657:     * filtro nenhum a consulta por Grupo casaria com grupos em branco.
658:     *==========================================================================
659:     PROCEDURE CarregarDados()
660:         LOCAL loc_lSucesso, loc_cUsuario, loc_cGrupo, loc_oErro
661:         loc_lSucesso = .F.
662: 
663:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
664:             MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel", "Erro")
665:         ELSE
666:             loc_cUsuario = ALLTRIM(THIS.txt_4c_CUsu.Value)
667:             loc_cGrupo   = ALLTRIM(THIS.txt_4c_Grupo.Value)
668: 
669:             IF EMPTY(loc_cUsuario) AND EMPTY(loc_cGrupo)
670:                 *-- Nada a consultar: a arvore fica vazia, como no legado
671:                 *-- (o MakeTree nem eh chamado nessa situacao).
672:                 THIS.LimparArvore()
673:             ELSE
674:                 WITH THIS.this_oBusinessObject
675:                     .this_cUsuarios = loc_cUsuario
676:                     .this_cNComps   = ALLTRIM(THIS.txt_4c_DUsu.Value)
677:                     .this_cGrupos   = loc_cGrupo
678:                 ENDWITH
679: 
680:                 *-- SQLEXEC com handle invalido DISPARA excecao em vez de
681:                 *-- devolver -1; sem este TRY o usuario veria o "Program
682:                 *-- Error" CRU do VFP no lugar do dialogo do sistema.
683:                 *-- RETURN so DEPOIS do ENDTRY (regra CLAUDE.md #1).
684:                 TRY
685:                     IF THIS.this_oBusinessObject.MontarArvoreAcessos()
686:                         THIS.PopularArvore()
687:                         loc_lSucesso = .T.
688:                     ELSE
689:                         MsgAviso(IIF(EMPTY(THIS.this_oBusinessObject.this_cMensagemErro), ;
690:                             "N" + CHR(227) + "o foi poss" + CHR(237) + "vel consultar os acessos.", ;
691:                             THIS.this_oBusinessObject.this_cMensagemErro), ;
692:                             "Aten" + CHR(231) + CHR(227) + "o")
693:                     ENDIF
694:                 CATCH TO loc_oErro
695:                     MsgErro("Falha ao consultar os acessos: " + loc_oErro.Message + CHR(13) + ;
696:                             "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
697:                             "Procedure: " + loc_oErro.Procedure, "Erro")
698:                 ENDTRY
699:             ENDIF
700:         ENDIF
701: 
702:         RETURN loc_lSucesso
703:     ENDPROC
704: 
705:     *==========================================================================
706:     * PopularArvore - Desenha os nos a partir do cursor que o BO acabou de
707:     * popular. Transcricao linha a linha do laco Scan do maketree legado:
708:     * o texto da coluna descricaos eh hierarquico, separado por "-", e cada
709:     * segmento vira um nivel da arvore. O vetor de niveis guarda o caminho
710:     * ja desenhado para nao repetir o no intermediario.
711:     *
712:     * Separado de CarregarDados para que a consulta continue valendo mesmo
713:     * quando o controle ActiveX da arvore nao esta disponivel na estacao.
714:     *==========================================================================
715:     PROTECTED PROCEDURE PopularArvore()
716:         LOCAL loc_oErro, loc_cCursor, loc_cDesc, loc_cDescs, loc_cCargo
717:         LOCAL loc_nNivel, loc_nNo, loc_nPicture, loc_nUltimo
718:         LOCAL ARRAY loc_aNivel[1]
719: 
720:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorArvore
721: 
722:         IF THIS.ArvoreDisponivel() AND USED(loc_cCursor)
723:             THIS.PrepararArvore()
724: 
725:             TRY
726:                 loc_aNivel[1] = ""
727: 
728:                 SELECT (loc_cCursor)
729:                 SCAN
730:                     loc_cDesc = fLimpaTexto(ALLTRIM(TratarNulo(descricaos, "")))
731: 
732:                     *-- NodeCargo = Programas + Parametros do legado, SEM
733:                     *-- ALLTRIM nas partes: eh chave POSICIONAL (programas
734:                     *-- char(15) + parametros char(10) = 25) e encurtar
735:                     *-- qualquer parte quebraria a identificacao do no
736:                     *-- (regra CLAUDE.md #42).
737:                     loc_cCargo = PADR(TratarNulo(programas,  ""), 15) + ;
738:                                  PADR(TratarNulo(parametros, ""), 10)
739: 
740:                     IF AT("-", loc_cDesc) = 0
741:                         *-- Descricao sem "-": no de nivel 1, icone 1
742:                         loc_nNo = THIS.obj_4c_TreeView.AddPictureNode(ALLTRIM(loc_cDesc), 0, 1, 1, 0, 0)
743:                         THIS.ConfigurarNo(loc_nNo, loc_cCargo)
744:                         loc_aNivel[1] = loc_cDesc
745:                     ELSE
746:                         IF !ISNULL(loc_cDesc)
747:                             *-- Localiza em que nivel o caminho desta linha
748:                             *-- deixa de coincidir com o caminho ja desenhado.
749:                             loc_nNivel = 1
750:                             DO WHILE .T.
751:                                 IF ALEN(loc_aNivel) < loc_nNivel
752:                                     DIMENSION loc_aNivel[loc_nNivel]
753:                                     loc_aNivel[loc_nNivel] = ""
754:                                     EXIT
755:                                 ENDIF

*-- Linhas 817 a 1157:
817:                 MsgErro("Falha ao montar a " + CHR(225) + "rvore de acessos: " + ;
818:                         loc_oErro.Message + CHR(13) + ;
819:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
820:                         "Procedure: " + loc_oErro.Procedure, "Erro")
821:             ENDTRY
822:         ENDIF
823:     ENDPROC
824: 
825:     *==========================================================================
826:     * ConfigurarNo - Propriedades que o maketree legado aplica a TODO no
827:     * recem-criado, identicas nos tres sites de AddPictureNode:
828:     *   NodeHeader = .t. / NodeExpanded = .f. / NodeShowChecks = .f. /
829:     *   NodeFontBold = 2 / NodeCargo = Programas + Parametros
830:     *==========================================================================
831:     PROTECTED PROCEDURE ConfigurarNo(par_nNo, par_cCargo)
832:         WITH THIS.obj_4c_TreeView
833:             .NodeHeader(par_nNo)     = .T.
834:             .NodeExpanded(par_nNo)   = .F.
835:             .NodeShowChecks(par_nNo) = .F.
836:             .NodeFontBold(par_nNo)   = 2
837:             .NodeCargo(par_nNo)      = par_cCargo
838:         ENDWITH
839:     ENDPROC
840: 
841:     *==========================================================================
842:     * BtnExpandirClick - Command1.Click do legado ("Expandir Niveis"):
843:     * expande todos os nos do nivel imediatamente abaixo do nivel corrente e
844:     * so avanca pnNodeExp quando houve de fato algo para expandir.
845:     *==========================================================================
846:     PROCEDURE BtnExpandirClick()
847:         LOCAL loc_nNode, loc_lExpande, loc_oErro
848:         loc_lExpande = .F.
849: 
850:         IF THIS.ArvoreDisponivel()
851:             TRY
852:                 WITH THIS.obj_4c_TreeView
853:                     FOR loc_nNode = 0 TO .ListCount - 1
854:                         IF THIS.this_nNodeExp + 1 = .NodeLevel(loc_nNode)
855:                             .NodeExpanded(loc_nNode) = .T.
856:                             loc_lExpande = .T.
857:                         ENDIF
858:                     ENDFOR
859:                 ENDWITH
860: 
861:                 IF loc_lExpande
862:                     THIS.this_nNodeExp = THIS.this_nNodeExp + 1
863:                 ENDIF
864:             CATCH TO loc_oErro
865:                 MsgErro("Falha ao expandir n" + CHR(237) + "veis: " + ;
866:                         loc_oErro.Message + CHR(13) + ;
867:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
868:                         "Procedure: " + loc_oErro.Procedure, "Erro")
869:             ENDTRY
870:         ENDIF
871:     ENDPROC
872: 
873:     *==========================================================================
874:     * BtnRecolherClick - Command2.Click do legado ("Recolher Niveis"):
875:     * recolhe os nos do nivel corrente e volta um nivel.
876:     *==========================================================================
877:     PROCEDURE BtnRecolherClick()
878:         LOCAL loc_nNode, loc_oErro
879: 
880:         IF THIS.ArvoreDisponivel() AND THIS.this_nNodeExp > 0
881:             TRY
882:                 WITH THIS.obj_4c_TreeView
883:                     FOR loc_nNode = 0 TO .ListCount - 1
884:                         IF THIS.this_nNodeExp = .NodeLevel(loc_nNode)
885:                             .NodeExpanded(loc_nNode) = .F.
886:                         ENDIF
887:                     ENDFOR
888:                 ENDWITH
889: 
890:                 THIS.this_nNodeExp = THIS.this_nNodeExp - 1
891:             CATCH TO loc_oErro
892:                 MsgErro("Falha ao recolher n" + CHR(237) + "veis: " + ;
893:                         loc_oErro.Message + CHR(13) + ;
894:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
895:                         "Procedure: " + loc_oErro.Procedure, "Erro")
896:             ENDTRY
897:         ENDIF
898:     ENDPROC
899: 
900:     *==========================================================================
901:     * BtnEncerrarClick - Command3.Click do legado ("Release Windows"), que no
902:     * sistema novo eh o Release() do proprio form (o legado abre a tela como
903:     * janela unica; aqui ela eh modal, aberta por menu.prg).
904:     *==========================================================================
905:     PROCEDURE BtnEncerrarClick()
906:         THIS.Release()
907:     ENDPROC
908: 
909:     *==========================================================================
910:     * CUsuGotFocus / GrupoGotFocus - GotFocus de GetcUsu/GetGrupo do legado:
911:     * ao voltar para o campo de filtro a arvore eh zerada, porque o conteudo
912:     * exibido deixa de corresponder ao filtro que esta sendo digitado.
913:     * GetDUsu NAO declara GotFocus no dump - por isso nao ha DUsuGotFocus.
914:     *==========================================================================
915:     PROCEDURE CUsuGotFocus()
916:         THIS.LimparArvore()
917:     ENDPROC
918: 
919:     PROCEDURE GrupoGotFocus()
920:         THIS.LimparArvore()
921:     ENDPROC
922: 
923:     *==========================================================================
924:     * AtualizarHabilitacaoFiltros - Reproduz a exclusividade mutua dos tres
925:     * guards When do legado:
926:     *   GetcUsu.When  -> Return(Empty(ThisForm.GetGrupo.Value))
927:     *   GetGrupo.When -> Return(Empty(ThisForm.GetcUsu.Value))
928:     *   GetDUsu.When  -> Return(Empty(ThisForm.GetcUsu.Value) And
929:     *                           Empty(ThisForm.GetGrupo.Value))
930:     * No legado, When = .F. impede o campo de RECEBER foco (o Tab salta para
931:     * o proximo controle); aqui o equivalente e .Enabled = .F. - o usuario
932:     * nao consegue comecar a digitar no campo trancado, e o efeito liquido e
933:     * o mesmo: filtrar por Usuario OU por Grupo, nunca os dois ao mesmo
934:     * tempo, e GetDUsu (nome) so aceita digitacao direta quando NENHUM dos
935:     * dois filtros de codigo esta preenchido.
936:     *
937:     * Chamado apos ConfigurarControles (estado inicial) e ao fim de cada
938:     * ValidarXxxExec, pois e quando o CONTEUDO dos campos pode ter mudado
939:     * (preenchido pelo lookup, ou limpo quando o usuario cancela o picker).
940:     *==========================================================================
941:     PROTECTED PROCEDURE AtualizarHabilitacaoFiltros()
942:         LOCAL loc_lTemUsuario, loc_lTemGrupo
943: 
944:         loc_lTemUsuario = !EMPTY(ALLTRIM(THIS.txt_4c_CUsu.Value))
945:         loc_lTemGrupo   = !EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
946: 
947:         THIS.txt_4c_Grupo.Enabled = !loc_lTemUsuario
948:         THIS.txt_4c_CUsu.Enabled  = !loc_lTemGrupo
949:         THIS.txt_4c_DUsu.Enabled  = !loc_lTemUsuario AND !loc_lTemGrupo
950:     ENDPROC
951: 
952:     *==========================================================================
953:     * ValidarCUsu / ValidarCUsuExec - LostFocus de txt_4c_CUsu (GetcUsu.Valid
954:     * do legado): busca o usuario digitado em SigCdUsu e preenche o nome
955:     * (txt_4c_DUsu); nao achando, abre o picker (AbrirBuscaUsuario). Ao
956:     * final, SEMPRE reconsulta a arvore - o legado reavalia a condicao
957:     * "If !Empty(This.Value) Or !Empty(GetGrupo.Value) -> MakeTree" apos o
958:     * bloco de lookup, independente do resultado (CarregarDados() ja cobre
959:     * o caso de ambos os filtros vazios, limpando a arvore).
960:     *
961:     * Guarda de reentrancia (regra CLAUDE.md #37/#47): o picker e MODAL e
962:     * tira o foco do campo, o que poderia redisparar este proprio LostFocus.
963:     * O corpo fica em ValidarCUsuExec para a flag ser SEMPRE liberada.
964:     *==========================================================================
965:     PROCEDURE ValidarCUsu()
966:         IF THIS.this_lEmLookup
967:             RETURN
968:         ENDIF
969:         THIS.this_lEmLookup = .T.
970:         THIS.ValidarCUsuExec()
971:         THIS.this_lEmLookup = .F.
972:     ENDPROC
973: 
974:     PROCEDURE ValidarCUsuExec()
975:         LOCAL loc_cUsuario
976: 
977:         loc_cUsuario = ALLTRIM(THIS.txt_4c_CUsu.Value)
978: 
979:         IF !EMPTY(loc_cUsuario)
980:             THIS.AbrirBuscaUsuario("Usuarios", loc_cUsuario)
981:         ENDIF
982: 
983:         THIS.AtualizarHabilitacaoFiltros()
984:         THIS.CarregarDados()
985:     ENDPROC
986: 
987:     *==========================================================================
988:     * ValidarDUsu / ValidarDUsuExec - LostFocus de txt_4c_DUsu (GetDUsu.Valid
989:     * do legado): mesma logica de ValidarCUsu, mas a busca exata/parcial e
990:     * pelo NOME (coluna nComps), nao pelo codigo.
991:     *==========================================================================
992:     PROCEDURE ValidarDUsu()
993:         IF THIS.this_lEmLookup
994:             RETURN
995:         ENDIF
996:         THIS.this_lEmLookup = .T.
997:         THIS.ValidarDUsuExec()
998:         THIS.this_lEmLookup = .F.
999:     ENDPROC
1000: 
1001:     PROCEDURE ValidarDUsuExec()
1002:         LOCAL loc_cNome
1003: 
1004:         loc_cNome = ALLTRIM(THIS.txt_4c_DUsu.Value)
1005: 
1006:         IF !EMPTY(loc_cNome)
1007:             THIS.AbrirBuscaUsuario("nComps", loc_cNome)
1008:         ENDIF
1009: 
1010:         THIS.AtualizarHabilitacaoFiltros()
1011:         THIS.CarregarDados()
1012:     ENDPROC
1013: 
1014:     *==========================================================================
1015:     * ValidarGrupo / ValidarGrupoExec - LostFocus de txt_4c_Grupo (GetGrupo.
1016:     * Valid do legado): busca o grupo digitado em SigCdGrA; nao achando,
1017:     * abre o picker (AbrirBuscaGrupo).
1018:     *==========================================================================
1019:     PROCEDURE ValidarGrupo()
1020:         IF THIS.this_lEmLookup
1021:             RETURN
1022:         ENDIF
1023:         THIS.this_lEmLookup = .T.
1024:         THIS.ValidarGrupoExec()
1025:         THIS.this_lEmLookup = .F.
1026:     ENDPROC
1027: 
1028:     PROCEDURE ValidarGrupoExec()
1029:         LOCAL loc_cGrupo
1030: 
1031:         loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
1032: 
1033:         IF !EMPTY(loc_cGrupo)
1034:             THIS.AbrirBuscaGrupo(loc_cGrupo)
1035:         ENDIF
1036: 
1037:         THIS.AtualizarHabilitacaoFiltros()
1038:         THIS.CarregarDados()
1039:     ENDPROC
1040: 
1041:     *==========================================================================
1042:     * AbrirBuscaUsuario - Transcricao do bloco fwBuscaExt comum a GetcUsu.
1043:     * Valid e GetDUsu.Valid (so o campo de busca muda: Usuarios ou nComps).
1044:     * Contrato do FormBuscaAuxiliar (regra CLAUDE.md #37): o Init ja tenta o
1045:     * match exato; so mostrar o picker quando NAO achou (this_lAchouRegistro).
1046:     * Preenche os DOIS campos (codigo+nome) quando this_lSelecionou; senao
1047:     * limpa os dois - exatamente o "If lastkey()<>27 ... Else ... Endif" do
1048:     * legado (NAO eh o MsgAviso+clear da regra #50: o legado tambem limpa
1049:     * aqui, e NAO ha aviso nenhum sendo exibido).
1050:     *==========================================================================
1051:     PROTECTED PROCEDURE AbrirBuscaUsuario(par_cCampoBusca, par_cValorBusca)
1052:         LOCAL loc_oBusca, loc_oErro
1053: 
1054:         TRY
1055:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1056:                 "SigCdUsu", "cursor_4c_BuscaUsu", par_cCampoBusca, par_cValorBusca, ;
1057:                 "Sele" + CHR(231) + CHR(227) + "o")
1058: 
1059:             IF VARTYPE(loc_oBusca) = "O"
1060:                 IF !loc_oBusca.this_lAchouRegistro
1061:                     *-- Ordem das colunas segue o legado: a busca por
1062:                     *-- Usuarios mostra Codigo primeiro; a busca por nComps
1063:                     *-- (GetDUsu) mostra Nome primeiro.
1064:                     IF UPPER(par_cCampoBusca) == "USUARIOS"
1065:                         loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
1066:                         loc_oBusca.mAddColuna("nComps", "", "Nome")
1067:                     ELSE
1068:                         loc_oBusca.mAddColuna("nComps", "", "Nome")
1069:                         loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
1070:                     ENDIF
1071:                     loc_oBusca.Show()
1072:                 ENDIF
1073: 
1074:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
1075:                     SELECT cursor_4c_BuscaUsu
1076:                     THIS.txt_4c_CUsu.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
1077:                     THIS.txt_4c_DUsu.Value = ALLTRIM(cursor_4c_BuscaUsu.nComps)
1078:                 ELSE
1079:                     THIS.txt_4c_CUsu.Value = ""
1080:                     THIS.txt_4c_DUsu.Value = ""
1081:                 ENDIF
1082: 
1083:                 loc_oBusca.Release()
1084:             ENDIF
1085: 
1086:             IF USED("cursor_4c_BuscaUsu")
1087:                 USE IN cursor_4c_BuscaUsu
1088:             ENDIF
1089:         CATCH TO loc_oErro
1090:             MsgErro("Falha ao buscar usu" + CHR(225) + "rio: " + loc_oErro.Message + CHR(13) + ;
1091:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1092:                     "Procedure: " + loc_oErro.Procedure, "Erro")
1093:             IF USED("cursor_4c_BuscaUsu")
1094:                 USE IN cursor_4c_BuscaUsu
1095:             ENDIF
1096:         ENDTRY
1097:     ENDPROC
1098: 
1099:     *==========================================================================
1100:     * AbrirBuscaGrupo - Transcricao do bloco fwBuscaExt de GetGrupo.Valid
1101:     * (busca em SigCdGrA pelo codigo do grupo).
1102:     *==========================================================================
1103:     PROTECTED PROCEDURE AbrirBuscaGrupo(par_cValorBusca)
1104:         LOCAL loc_oBusca, loc_oErro
1105: 
1106:         TRY
1107:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1108:                 "SigCdGrA", "cursor_4c_BuscaGrp", "Grupos", par_cValorBusca, ;
1109:                 "Sele" + CHR(231) + CHR(227) + "o")
1110: 
1111:             IF VARTYPE(loc_oBusca) = "O"
1112:                 IF !loc_oBusca.this_lAchouRegistro
1113:                     loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
1114:                     loc_oBusca.mAddColuna("nComps", "", "Nome")
1115:                     loc_oBusca.Show()
1116:                 ENDIF
1117: 
1118:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1119:                     SELECT cursor_4c_BuscaGrp
1120:                     THIS.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.Grupos)
1121:                 ELSE
1122:                     THIS.txt_4c_Grupo.Value = ""
1123:                 ENDIF
1124: 
1125:                 loc_oBusca.Release()
1126:             ENDIF
1127: 
1128:             IF USED("cursor_4c_BuscaGrp")
1129:                 USE IN cursor_4c_BuscaGrp
1130:             ENDIF
1131:         CATCH TO loc_oErro
1132:             MsgErro("Falha ao buscar grupo: " + loc_oErro.Message + CHR(13) + ;
1133:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1134:                     "Procedure: " + loc_oErro.Procedure, "Erro")
1135:             IF USED("cursor_4c_BuscaGrp")
1136:                 USE IN cursor_4c_BuscaGrp
1137:             ENDIF
1138:         ENDTRY
1139:     ENDPROC
1140: 
1141:     *==========================================================================
1142:     * Destroy - Fecha o cursor da arvore de acessos (cursor_4c_Arvore,
1143:     * populado por SIGOPCAUBO.MontarArvoreAcessos) antes de liberar o
1144:     * Business Object. FormBase.Destroy() cuida do this_oBusinessObject e
1145:     * da restauracao do menu principal (regra CLAUDE.md Pattern #145 -
1146:     * DODEFAULT() como ULTIMA linha).
1147:     *==========================================================================
1148:     PROCEDURE Destroy()
1149:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1150:            USED(THIS.this_oBusinessObject.this_cCursorArvore)
1151:             USE IN (THIS.this_oBusinessObject.this_cCursorArvore)
1152:         ENDIF
1153: 
1154:         DODEFAULT()
1155:     ENDPROC
1156: 
1157: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPCAUBO.prg):
*******************************************************************************
* SIGOPCAUBO.prg - Business Object para Consulta de Acessos de Usuario
* (SIGOPCAU)
*
* Tabelas consultadas:
*   SigCdUsu (PK usuarios char(10))        - usuario filtrado (GetcUsu/GetDUsu)
*   SigCdGrA (PK grupos char(10))          - grupo de usuarios filtrado (GetGrupo)
*   SigCdAcU / SigCdAcG / SigCdPrg (Join)  - acessos do usuario/grupo filtrado,
*                                            ou TODOS os programas cadastrados
*                                            em SigCdPrg quando o usuario
*                                            logado eh o super-usuario
*                                            '4CONTROL' (legado: "If
*                                            Upper(Alltrim(Usuar))=[4CONTROL]")
*
* Origem: tasks\task652\SIGOPCAU_form_codigo_fonte.txt - o metodo MakeTree()
* do form legado monta a arvore de Programas/Parametros/Descricaos exibida
* no TreeView (ver comportamento.json: metodosComSQL=1, funcoesExternas=
* ["fLimpaTexto","fwBuscaExt"]).
*
* Natureza: dialogo OPERACIONAL somente-CONSULTA - o legado nao faz nenhum
* Insert/Update/Delete em tabela (so Select/SqlExecute para montar a arvore
* e fwBuscaExt para os 3 lookups de Usuario/Nome/Grupo, ver GetcUsu.Valid/
* GetDUsu.Valid/GetGrupo.Valid). Por isso Inserir()/Atualizar()/
* ExecutarExclusao() permanecerao SEM override nas proximas fases: o
* comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh o
* correto para esta tela.
*
* Herda de: BusinessBase
* Fase 2/8 - MontarArvoreAcessos (consulta real, equivalente ao MakeTree()
* do legado), CarregarDoCursor() e ObterChavePrimaria()
*******************************************************************************

DEFINE CLASS SIGOPCAUBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Criterios de filtro da arvore de acessos (ligados aos campos da tela)
    *--------------------------------------------------------------------------
    this_cUsuarios     = ""   && sigcdusu.usuarios  char(10) - GetcUsu.Value  - codigo do usuario filtrado
    this_cNComps       = ""   && sigcdusu.ncomps    char(30) - GetDUsu.Value  - nome do usuario (preenchido pelo lookup)
    this_cGrupos       = ""   && sigcdgra.grupos    char(10) - GetGrupo.Value - codigo do grupo filtrado

    *--------------------------------------------------------------------------
    * Resultado da consulta (cursor da arvore de Programas/Parametros/
    * Descricaos montado por MontarArvoreAcessos na Fase 2) e espelho da
    * linha corrente, carregado por CarregarDoCursor
    *--------------------------------------------------------------------------
    this_cCursorArvore = "cursor_4c_Arvore"  && nome do cursor populado pela consulta (SigCdAcU/SigCdAcG/SigCdPrg ou SigCdPrg puro p/ super-usuario)
    this_nTotalNodes   = 0                   && RECCOUNT() de this_cCursorArvore apos a consulta

    this_cProgramas    = ""   && programas  char(15)  - coluna corrente de this_cCursorArvore (SigCdPrg.programas)
    this_cParametros   = ""   && parametros char(10)  - coluna corrente de this_cCursorArvore (SigCdPrg.parametros)
    this_cDescricaos   = ""   && descricaos char(150) - coluna corrente de this_cCursorArvore (SigCdPrg.descricaos) - texto hierarquico separado por "-" (cada nivel da arvore)

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdusu"
        THIS.this_cCampoChave = "usuarios"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarArvoreAcessos - Monta this_cCursorArvore com os Programas/
    * Parametros/Descricaos de acesso do usuario ou grupo filtrado em
    * this_cUsuarios/this_cGrupos. Equivalente ao PROCEDURE maketree() do
    * legado (SIGOPCAU_form_codigo_fonte.txt) - o form chama este metodo
    * apos resolver o lookup de Usuario/Grupo e percorre this_cCursorArvore
    * em SCAN para montar os nodes do TreeView.
    *
    * Regra de negocio transcrita do legado:
    *   - this_cUsuarios preenchido:
    *       - super-usuario "4CONTROL" -> ve TODOS os programas cadastrados
    *         em SigCdPrg (sem filtro de acesso)
    *       - qualquer outro usuario    -> ve so os acessos ligados a ele em
    *         SigCdAcU OU herdados do grupo dele via SigCdAcG
    *   - this_cUsuarios vazio (filtro por Grupo) -> mesma consulta de
    *     acessos, filtrando SigCdAcU.Grupos/SigCdAcG.Grupos
    *
    * DESVIO DOCUMENTADO (nao reproduzido): no ramo "filtro por Grupo" o SCX
    * legado repete por engano ThisForm.GetcUsu.Value (sempre vazio nesse
    * ramo, por causa do guard mutuamente exclusivo em GetcUsu.When/
    * GetGrupo.When - um so campo fica habilitado por vez) no lugar de
    * ThisForm.GetGrupo.Value. Esse typo de copia-e-cola faz a busca por
    * Grupo nunca trazer resultado nenhum no legado. Aqui usa-se
    * this_cGrupos (o campo correto), preservando a INTENCAO da consulta -
    * reproduzir o typo tornaria a busca por Grupo sempre vazia, violando a
    * paridade funcional (REGRA FUNDAMENTAL do projeto).
    *
    * A primeira consulta do legado (Select * From SigCdUsu Where Usuarios=
    * ... em crSigCdUsu) foi omitida: o resultado nunca era usado (a unica
    * leitura de crSigCdUsu.supervis esta comentada com *!* no SCX) - a
    * checagem de super-usuario testa a variavel global do usuario LOGADO,
    * nao o usuario filtrado na tela.
    *--------------------------------------------------------------------------
    PROCEDURE MontarArvoreAcessos()
        LOCAL loc_cSQL, loc_nResultado, loc_cUsuario, loc_cGrupo

        THIS.this_cMensagemErro = ""
        THIS.this_nTotalNodes   = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cUsuario = ALLTRIM(THIS.this_cUsuarios)
        loc_cGrupo   = ALLTRIM(THIS.this_cGrupos)

        IF !EMPTY(loc_cUsuario)
            IF UPPER(ALLTRIM(gc_4c_UsuarioLogado)) == "4CONTROL"
                loc_cSQL = "SELECT a.programas, a.parametros, a.descricaos " + ;
                           "FROM SigCdPrg a " + ;
                           "WHERE a.programas <> '' " + ;
                           "GROUP BY a.programas, a.parametros, a.descricaos " + ;
                           "ORDER BY a.descricaos, a.programas, a.parametros"
            ELSE
                loc_cSQL = "SELECT a.programas, a.parametros, c.descricaos " + ;
                           "FROM SigCdAcU a " + ;
                           "LEFT JOIN SigCdAcG b ON a.grupos = b.grupos " + ;
                           "LEFT JOIN SigCdPrg c ON a.programas = c.programas " + ;
                           "AND a.parametros = c.parametros " + ;
                           "WHERE a.programas <> '' AND (a.usuarios = " + EscaparSQL(loc_cUsuario) + ;
                           " OR b.usuarios = " + EscaparSQL(loc_cUsuario) + ") " + ;
                           "GROUP BY a.programas, a.parametros, c.descricaos " + ;
                           "ORDER BY c.descricaos, a.programas, a.parametros"
            ENDIF
        ELSE
            loc_cSQL = "SELECT a.programas, a.parametros, c.descricaos " + ;
                       "FROM SigCdAcU a " + ;
                       "LEFT JOIN SigCdAcG b ON a.grupos = b.grupos " + ;
                       "LEFT JOIN SigCdPrg c ON a.programas = c.programas " + ;
                       "AND a.parametros = c.parametros " + ;
                       "WHERE a.programas <> '' AND (a.grupos = " + EscaparSQL(loc_cGrupo) + ;
                       " OR b.grupos = " + EscaparSQL(loc_cGrupo) + ") " + ;
                       "GROUP BY a.programas, a.parametros, c.descricaos " + ;
                       "ORDER BY c.descricaos, a.programas, a.parametros"
        ENDIF

        IF USED(THIS.this_cCursorArvore)
            USE IN (THIS.this_cCursorArvore)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorArvore)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao consultar acessos: " + CapturarErroSQL()
            RETURN .F.
        ENDIF

        THIS.this_nTotalNodes = RECCOUNT(THIS.this_cCursorArvore)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Espelha a linha corrente de this_cCursorArvore
    * (populado por MontarArvoreAcessos) nas properties this_cProgramas/
    * this_cParametros/this_cDescricaos. Usado pelo form ao percorrer o
    * cursor em SCAN para montar cada node do TreeView.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        THIS.this_cProgramas  = TratarNulo(programas, "")
        THIS.this_cParametros = TratarNulo(parametros, "")
        THIS.this_cDescricaos = TratarNulo(descricaos, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do registro filtrado (usuarios, conforme
    * this_cCampoChave definido no Init). Nunca chamado em runtime porque
    * Inserir()/Atualizar()/ExecutarExclusao() permanecem sem override (ver
    * cabecalho do arquivo) - implementado por completude/consistencia com
    * o restante do projeto (CLAUDE.md: "Override ObterChavePrimaria em
    * cada BO").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuarios)
    ENDPROC

ENDDEFINE

