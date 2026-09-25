# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [METODO-INEXISTENTE] Metodo 'THIS.ArvoreDisponivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterTextoDataHora()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterTextoHora()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterCargoAtual()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarChaveAtual()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltro()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2578 linhas total):

*-- Linhas 22 a 74:
22: * FASE 3/8 - ESTRUTURA BASE: DEFINE CLASS, propriedades de estado (espelham
23: * as PUBLIC/propriedades customizadas do form legado - paEmpDopNums,
24: * pcEmpDopNums, lacoficina, pnniveis, pnNodeExp, pldblclick, Automatico),
25: * Init()/InicializarForm()/Destroy().
26: *
27: * FASE 4/8 - CONTROLES: ConfigurarControles() cria shp_4c_Shape1 (decorativo,
28: * atras da barra de botoes), cmd_4c_BtnOperacao ("Movimento"),
29: * cmd_4c_BtnOficina ("Producao", Visible=.F. - fiel ao legado),
30: * obj_4c_Commandgroup1 (6 botoes: Expandir/Retrair/Encerrar/Anterior/
31: * Imprimir/Proximo) e obj_4c_TreeView (arvore hierarquica - controle ActiveX
32: * de terceiros ctTree.ocx/DBI Technologies, sem substituto nativo VFP9;
33: * instanciado via OLEControl com o mesmo ProgID do legado, guardado em
34: * TRY/CATCH e pulado em modo teste). TornarControlesVisiveis() torna tudo
35: * visivel apos o AddObject, preservando BtnOficina.Visible=.F.
36: * Ainda na Fase 4, o metodo de carga desta tela: CarregarDados() (equivalente
37: * ao MakeTree legado) monta a chave EmpDopNums, pede os dados ao SIGMVMVTBO e
38: * manda PopularArvore() desenhar os niveis 1 (operacao) e 2 (produtos), com
39: * PrepararArvore()/ArvoreDisponivel() cuidando do controle ActiveX. Como no
40: * legado, CarregarDados() roda sozinho no Init quando Automatico = .T.
41: * Nenhum evento de controle esta ligado ainda (fica para a Fase 7-8).
42: *
43: * MEDIDO no VFP9 em 2026-09-25 (ver "cttree.ocx" abaixo): com o OCX ausente,
44: * AddObject("OLEControl", "cttree.cttreeview") devolve OLE error 0x800401f3
45: * ("classe invalida"), que o TRY/CATCH PEGA - a tela abre sem a arvore em vez
46: * de travar. NAO trocar por "MSComctlLib.TreeCtrl" (TreeView da MSCOMCTL.OCX):
47: * medido na mesma bateria, ele TRAVA o VFP9 num dialogo modal de licenca de
48: * design-time que o TRY/CATCH nao intercepta.
49: *
50: * FASE 5/8 - FILTRO (Empresa/Operacao/Numero/Periodo): ConfigurarFiltros()
51: * cria lbl_4c_Label1..5 + txt_4c_CEmp/txt_4c_Dopes/txt_4c_Numes/txt_4c_DtI/
52: * txt_4c_DtF, direto na Form (fiel ao legado - sem Page2, sem container).
53: * Posicoes/tamanhos/mascaras TRANSCRITOS do dump do SCX (Top=127/131,
54: * Lefts 42..692, MaxLength/InputMask por campo). Label4 e Label5 tinham
55: * ForeColor = RGB(231,254,253) no SCX (quase-branco, ilegivel sobre o
56: * fundo claro da Picture do form) - escurecido para RGB(36,84,155), igual
57: * aos irmaos Label1/2/3 (CLAUDE.md regra #12 - quase-branco escurece para
58: * a cor das labels irmas). Label5 eh o "a" (CHR(224)) entre GetDtI e GetDtF
59: * ("Periodo : de __ a __").
60: * AplicarParametrosAbertura() reproduz o trecho do Init legado que preenche
61: * GetCEmp/GetDopes/GetNumes a partir de par_cEmps/par_cDopes/par_nNumes
62: * (pcEmps/pcDopes/pcNumes), incluindo o ReadOnly quando os tres estao
63: * presentes e o Enabled = .F. dos 5 campos quando this_lAutomatico = .T.
64: * (drill direto - o usuario nao deve poder editar o filtro que abriu a
65: * tela). No legado o ReadOnly e o Automatico sao a MESMA expressao - o "E"
66: * dos TRES parametros - entao os dois saem de this_lAutomatico (ver o Init):
67: * recebendo so parte do filtro a tela abre com o que veio PRE-PREENCHIDO mas
68: * EDITAVEL, que e o comportamento do legado. O MakeTree() do legado (aqui
69: * CarregarDados()) continua chamado logo depois, como ja estava na Fase 4.
70: * MEDIDO no VFP9 em 2026-09-25 (test_fase5_sigmvmvt.prg): os 5 campos batem
71: * com o dump do SCX em Top/Left/Width/Height/MaxLength; o InputMask
72: * "999999" que o SCX declara nos dois campos de data e REESCRITO pelo
73: * proprio VFP para "99/99/9999" quando o .Value passa a ser DATE (o Init
74: * legado faz GetDtI.Value = Ctod('')), entao transcrever o mask do SCX nao

*-- Linhas 83 a 174:
83: *     BtnEncerrarClick/BtnAnteriorClick/BtnImprimirClick/BtnProximoClick
84: *     (Command1..Command6.Click do legado)
85: *   - cmd_4c_BtnOperacao/cmd_4c_BtnOficina -> BtnOperacaoClick/BtnOficinaClick,
86: *     que abrem SigMvExp/SigRePPd (fora do escopo desta task - CREATEOBJECT
87: *     guardado em TRY/CATCH, com MsgAviso se o modulo migrado ainda nao
88: *     existir, em vez de estourar "Class definition ... is not found")
89: *   - obj_4c_TreeView -> TreeViewGotFocus/TreeViewKeyPress/TreeViewNodeClick
90: *   - txt_4c_CEmp/txt_4c_Numes/txt_4c_DtI/txt_4c_DtF -> GotFocus/LostFocus
91: *     completando o que a Fase 5 deixou (so CEmp/Dopes.KeyPress); Valid do
92: *     legado virou KeyPress em ENTER/TAB (CEmpKeyPress/DopesKeyPress ja
93: *     existiam; NumesKeyPress/DtFKeyPress disparam MakeTree/MakeList - aqui
94: *     CarregarDados()/CarregarListaPeriodo())
95: *
96: * FASE 8/8 - RECURSAO DA ARVORE (niveis 3+): SubNivel()/HiNivel()/NoHiPro()/
97: * NoProd() sao a orquestracao do lado do Form (equivalente a ThisForm.
98: * SubNivel/HiNivel/NoHiPro/NoProd do legado) sobre os metodos de consulta ja
99: * existentes em SIGMVMVTBO.prg desde as Fases 1-2 (ObterSubNivel/
100: * ObterHistoricoNivel/ObterNoHiPro/ObterNoProd). PopularArvore() dispara
101: * SubNivel(3,...)/HiNivel(3,...) por produto (dentro do Scan de
102: * cursor_4c_Itens) e SubNivel(2,...)/HiNivel(2,...) uma vez no fim -
103: * exatamente onde o maketree legado dispara. Os quatro se chamam
104: * mutuamente ate profundidade 50 (this_nNiveis, mesmo teto do legado) ou ate
105: * o EmpDopNums cair em "NF - TRF SIMBOLICA" (fim de cadeia). Dedup em dois
106: * arrays de escopo Form: this_aHistorico (equivalente a ThisForm.
107: * pcEmpDopNums, reiniciado a cada CarregarDados) e this_aOperacoes
108: * (equivalente a ThisForm.paOperacoes, escopo de FORM - nao reseta entre
109: * cargas, igual ao legado).
110: *
111: * Cada chamada a BO/SQLEXEC troca a work area corrente - por isso todo
112: * SCAN sobre um cursor de nivel se reseleciona apos QUALQUER chamada
113: * aninhada, antes de continuar a leitura da linha ou de deixar o SCAN
114: * avancar (a mesma disciplina do "Select &lcSqlFile."/"Select &lcTmpSub"
115: * espalhado pelo hinivel/subnivel/nohipro/noprod legado - SCAN em VFP nao
116: * preserva sozinho a alias de origem quando o corpo do loop troca de work
117: * area).
118: *
119: * DOIS DESVIOS DELIBERADOS do dump legado, cada um documentado em comentario
120: * no proprio metodo (NoHiPro/NoProd) - ambos looked like erros de
121: * digitacao/copia-e-cola que tornariam o ramo correspondente um no-op
122: * silencioso (nunca desenha nada) se transcritos literalmente, o que
123: * contraria a regra do projeto de paridade funcional completa:
124: *   1. NoHiPro: "If Ascan(ThisForm.paOperacoes,EmpDopNums)" sem "= 0" no
125: *      dump (o par simetrico em NoProd usa "= 0" corretamente) -
126: *      normalizado para "= 0".
127: *   2. NoProd (ramo "pnNivel <> 3"): chamada a HiNivel com 5 argumentos
128: *      (assinatura declarada tem 3) - normalizado para a mesma assinatura
129: *      de 3 argumentos que o SubNivel vizinho, no MESMO bloco, ja usa
130: *      corretamente.
131: *
132: * CHAMADA:
133: *   loForm = CREATEOBJECT("FormSIGMVMVT")                 && sem drill direto
134: *   loForm = CREATEOBJECT("FormSIGMVMVT", .T., cEmps, cDopes, nNumes) && modal
135: *                                                          && + Automatico
136: *   loForm.Show()
137: *==============================================================================
138: 
139: DEFINE CLASS FormSIGMVMVT AS FormBase
140: 
141:     *-- Dimensoes e comportamento identicos ao legado (SIGMVMVT.SCX)
142:     Height       = 600
143:     Width        = 800
144:     AutoCenter   = .T.
145:     BorderStyle  = 2
146:     ShowWindow = 1
147:     WindowType = 1
148:     ControlBox   = .F.
149:     Closable     = .F.
150:     MaxButton    = .F.
151:     MinButton    = .T.
152:     ClipControls = .F.
153:     ShowTips     = .T.
154:     Themes       = .F.
155:     FontName     = "Verdana"
156:     FontSize     = 8
157:     DataSession  = 2
158: 
159:     *-- Parametros de abertura (Parameters plModal, pcEmps, pcDopes, pcNumes
160:     *-- do Init legado) - permitem abrir a tela ja "no meio" de uma operacao
161:     *-- especifica, sem passar pelo filtro de Empresa/Operacao/Periodo.
162:     this_lModal      = .F.   && plModal - WindowType = Iif(plModal, 1, 0)
163:     this_cEmpsParam  = ""    && pcEmps
164:     this_cDopesParam = ""    && pcDopes
165:     this_nNumesParam = 0     && pcNumes
166: 
167:     *-- Init legado, transcrito LITERALMENTE:
168:     *--   Automatico = Not Empty(pcEmps) And Not Empty(pcDopes) And Not Empty(pcNumes)
169:     *-- E' um "E" dos TRES parametros, nao um "OU": so com Empresa + Operacao +
170:     *-- Numero a tela abriu ja no meio de uma operacao (drill direto). Com "OU",
171:     *-- receber so a Empresa ja ligaria o modo automatico, e o Init desabilitaria
172:     *-- os 5 campos do filtro (ver AplicarParametrosAbertura) e dispararia a
173:     *-- carga - o usuario ficaria com a tela TRAVADA e VAZIA, sem como completar
174:     *-- Operacao/Numero. A mesma expressao serve de ReadOnly no legado, entao ela

*-- Linhas 208 a 350:
208: 
209:     *==========================================================================
210:     * Init - Recebe os parametros de abertura e repassa para FormBase.Init()
211:     * (que chama InicializarForm() atraves de DODEFAULT()).
212:     *==========================================================================
213:     PROCEDURE Init(par_lModal, par_cEmps, par_cDopes, par_nNumes)
214:         THIS.this_lModal      = IIF(TYPE("par_lModal") = "L", par_lModal, .F.)
215:         THIS.this_cEmpsParam  = IIF(TYPE("par_cEmps")  = "C", ALLTRIM(par_cEmps), "")
216:         THIS.this_cDopesParam = IIF(TYPE("par_cDopes") = "C", ALLTRIM(par_cDopes), "")
217:         THIS.this_nNumesParam = IIF(TYPE("par_nNumes") = "N", par_nNumes, 0)
218: 
219:         THIS.this_lAutomatico = !EMPTY(THIS.this_cEmpsParam) ;
220:             AND !EMPTY(THIS.this_cDopesParam) ;
221:             AND THIS.this_nNumesParam != 0
222: 
223:         THIS.WindowType = IIF(THIS.this_lModal, 1, 0)
224: 
225:         RETURN DODEFAULT()
226:     ENDPROC
227: 
228:     *==========================================================================
229:     * InicializarForm - Instancia o Business Object, reinicializa o estado
230:     * de navegacao da arvore e cria os controles visuais (Fase 4). Os campos
231:     * de filtro (Label1..5 + GetcEmp/GetDopes/GetNumes/GetDtI/GetDtF) entram
232:     * nas Fases 5 a 6.
233:     *==========================================================================
234:     PROTECTED PROCEDURE InicializarForm
235:         LOCAL loc_lSucesso
236:         loc_lSucesso = .F.
237: 
238:         THIS.this_oBusinessObject = CREATEOBJECT("SIGMVMVTBO")
239: 
240:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
241:             MsgErro("Falha ao criar SIGMVMVTBO", "Erro")
242:         ELSE
243:             THIS.Caption = "Acompanhamento Operacional"
244: 
245:             *-- Picture = ..\framework\imagens\new_background.jpg no legado -
246:             *-- caminho resolvido via gc_4c_CaminhoFramework (regra CLAUDE.md
247:             *-- #27/Pattern #170 - NUNCA gc_4c_CaminhoBase + "Framework\...").
248:             IF FILE(gc_4c_CaminhoFramework + "imagens\new_background.jpg")
249:                 THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
250:             ENDIF
251: 
252:             *-- Reinicializa o estado de navegacao da arvore (equivalente ao
253:             *-- bloco inicial do Init legado - Declare .../pnNodeExp/lacoficina).
254:             DIMENSION THIS.this_aEmpDopNums[1]
255:             THIS.this_aEmpDopNums[1] = ""
256: 
257:             DIMENSION THIS.this_aHistorico[1, 2]
258:             THIS.this_aHistorico[1, 1] = ""
259:             THIS.this_aHistorico[1, 2] = ""
260: 
261:             DIMENSION THIS.this_aOperacoes[1]
262:             THIS.this_aOperacoes[1] = ""
263: 
264:             THIS.this_lAcOficina     = .F.
265:             THIS.this_nNiveis        = 0
266:             THIS.this_nNodeExp       = 0
267:             THIS.this_nIndiceClicado = 0
268:             THIS.this_lRetorno       = .F.
269: 
270:             THIS.ConfigurarControles()
271:             THIS.ConfigurarFiltros()
272: 
273:             THIS.TornarControlesVisiveis(THIS)
274: 
275:             *-- Init legado: preenche GetCEmp/GetDopes/GetNumes a partir dos
276:             *-- parametros de abertura e trava os campos quando Automatico.
277:             THIS.AplicarParametrosAbertura()
278: 
279:             *-- Init legado: If ThisForm.Automatico ... ThisForm.MakeTree().
280:             *-- Abriu com Empresa/Operacao/Numero ja definidos (drill direto),
281:             *-- entao a arvore ja e' montada sem passar pelo filtro. A falha de
282:             *-- carga NAO impede a tela de abrir (o BO ja avisa o usuario).
283:             IF THIS.this_lAutomatico AND ;
284:                (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
285:                (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
286:                 THIS.CarregarDados()
287:             ENDIF
288: 
289:             loc_lSucesso = .T.
290:         ENDIF
291: 
292:         RETURN loc_lSucesso
293:     ENDPROC
294: 
295:     *==========================================================================
296:     * ConfigurarControles - Cria os controles visuais da tela (layout FLAT,
297:     * sem PageFrame - controles direto na Form, fieis ao SIGMVMVT.SCX):
298:     *   shp_4c_Shape1        - retangulo decorativo atras da barra de botoes
299:     *   cmd_4c_BtnOperacao   - botao "Movimento" (unico modo hoje implementado)
300:     *   cmd_4c_BtnOficina    - botao "Producao" (Visible=.F. no legado)
301:     *   obj_4c_Commandgroup1 - 6 botoes: Expandir/Retrair/Encerrar/Anterior/
302:     *                          Imprimir/Proximo
303:     *   obj_4c_TreeView      - arvore hierarquica (equivalente ao "grid" desta
304:     *                          tela - controle ActiveX de terceiros ctTree.ocx/
305:     *                          DBI Technologies, NAO portavel para VFP9 nativo;
306:     *                          instanciado via OLEControl com o MESMO ProgID
307:     *                          do legado, guardado em TRY/CATCH porque o OCX
308:     *                          pode nao estar registrado na maquina)
309:     *==========================================================================
310:     PROTECTED PROCEDURE ConfigurarControles
311:         LOCAL loc_oErrOle
312: 
313:         *-- shp_4c_Shape1 (decorativo, atras da barra de botoes - criado
314:         *-- ANTES para o CommandGroup desenhar por cima)
315:         THIS.AddObject("shp_4c_Shape1", "Shape")
316:         WITH THIS.shp_4c_Shape1
317:             .Top         = 5
318:             .Left        = 698
319:             .Height      = 110
320:             .Width       = 90
321:             .BackStyle   = 0
322:             .BorderColor = RGB(136, 189, 188)
323:             .Visible     = .T.
324:         ENDWITH
325: 
326:         *-- cmd_4c_BtnOperacao ("Movimento")
327:         THIS.AddObject("cmd_4c_BtnOperacao", "CommandButton")
328:         WITH THIS.cmd_4c_BtnOperacao
329:             .Top               = 12
330:             .Left              = 12
331:             .Height            = 100
332:             .Width             = 80
333:             .FontName          = "Verdana"
334:             .FontSize          = 8
335:             .WordWrap          = .T.
336:             .Picture            = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
337:             .Cancel            = .T.
338:             .Caption           = "Movimento"
339:             .ForeColor         = RGB(36, 84, 155)
340:             .BackColor         = RGB(255, 255, 255)
341:             .DisabledBackColor = RGB(255, 255, 255)
342:             .Themes           = .T.
343:             .Visible           = .T.
344:         ENDWITH
345: 
346:         *-- cmd_4c_BtnOficina ("Producao" - Visible=.F. no legado, mantido fiel)
347:         THIS.AddObject("cmd_4c_BtnOficina", "CommandButton")
348:         WITH THIS.cmd_4c_BtnOficina
349:             .Top               = 12
350:             .Left              = 92

*-- Linhas 489 a 586:
489: 
490:         *-- Eventos dos botoes (Fase 7) - cada Buttons(N) tem o proprio Click
491:         *-- no legado (Command1.Click .. Command6.Click), nao o Click do
492:         *-- grupo. BINDEVENT so funciona com metodo PUBLIC (CLAUDE.md #3).
493:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnExpandirClick")
494:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnRetrairClick")
495:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(3), "Click", THIS, "BtnEncerrarClick")
496:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(4), "Click", THIS, "BtnAnteriorClick")
497:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(5), "Click", THIS, "BtnImprimirClick")
498:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(6), "Click", THIS, "BtnProximoClick")
499:         BINDEVENT(THIS.cmd_4c_BtnOperacao, "Click", THIS, "BtnOperacaoClick")
500:         BINDEVENT(THIS.cmd_4c_BtnOficina,  "Click", THIS, "BtnOficinaClick")
501: 
502:         *-- obj_4c_TreeView (ctTree.ocx / DBI Technologies, copyright 1998 -
503:         *-- controle ActiveX de terceiros do legado, sem substituto nativo
504:         *-- VFP9). ATENCAO: o SCX so preserva o caminho do OCX (OLEObject =
505:         *-- c:\windows\syswow64\cttree.ocx), NAO o ProgID/CLSID exato - nao
506:         *-- ha como confirmar "cttree.cttreeview" sem uma maquina com o OCX
507:         *-- registrado. Se a instanciacao abaixo falhar por ProgID incorreto
508:         *-- (em vez de OCX ausente), conferir o ProgID real via OLEVIEW ou
509:         *-- regedit (HKCR\TypeLib) numa maquina legado e corrigir a string.
510:         *-- Nao instanciar em modo teste: AddObject OLEControl pode travar
511:         *-- sem usuario, e o OCX pode nao estar registrado na maquina de
512:         *-- build - nesse caso a arvore fica ausente mas o resto da tela
513:         *-- funciona (guard em TRY/CATCH, sem impedir a abertura do form).
514:         IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
515:            (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
516:             TRY
517:                 THIS.AddObject("obj_4c_TreeView", "OLEControl", "cttree.cttreeview")
518:                 WITH THIS.obj_4c_TreeView
519:                     .Top     = 156
520:                     .Left    = 33
521:                     .Height  = 430
522:                     .Width   = 734
523:                     .Visible = .T.
524:                 ENDWITH
525: 
526:                 *-- GotFocus/KeyPress/NodeClick do TreeView legado.
527:                 BINDEVENT(THIS.obj_4c_TreeView, "GotFocus",  THIS, "TreeViewGotFocus")
528:                 BINDEVENT(THIS.obj_4c_TreeView, "KeyPress",  THIS, "TreeViewKeyPress")
529:                 BINDEVENT(THIS.obj_4c_TreeView, "NodeClick", THIS, "TreeViewNodeClick")
530:             CATCH TO loc_oErrOle
531:                 MsgErro("Controle de " + CHR(225) + "rvore (ctTree.ocx) indispon" + ;
532:                         CHR(237) + "vel nesta esta" + CHR(231) + CHR(227) + "o: " + ;
533:                         loc_oErrOle.Message, "Aviso")
534:             ENDTRY
535:         ENDIF
536:     ENDPROC
537: 
538:     *==========================================================================
539:     * ConfigurarFiltros - Cria o filtro de Empresa/Operacao/Numero/Periodo
540:     * (Label1..Label5 + GetcEmp/GetDopes/GetNumes/GetDtI/GetDtF do legado),
541:     * controles direto na Form (sem Page2/container - fiel ao SIGMVMVT.SCX,
542:     * que tambem os cria direto em sigmvmvt). Posicoes/tamanhos/mascaras
543:     * TRANSCRITOS do dump (CLAUDE.md regra #23 - Width declarado no SCX,
544:     * Alignment nao declarado fica 0/esquerda).
545:     *==========================================================================
546:     PROTECTED PROCEDURE ConfigurarFiltros
547:         *-- lbl_4c_Label1 ("Empresa :")
548:         THIS.AddObject("lbl_4c_Label1", "Label")
549:         WITH THIS.lbl_4c_Label1
550:             .Top       = 131
551:             .Left      = 42
552:             .Width     = 61
553:             .Height    = 15
554:             .BackStyle = 0
555:             .FontName  = "Verdana"
556:             .FontSize  = 8
557:             .ForeColor = RGB(36, 84, 155)
558:             .Caption   = "Empresa :"
559:             .Visible   = .T.
560:         ENDWITH
561: 
562:         *-- txt_4c_CEmp (GetcEmp) - char(3), SigCdEmp.Cemps
563:         THIS.AddObject("txt_4c_CEmp", "TextBox")
564:         WITH THIS.txt_4c_CEmp
565:             .Top               = 127
566:             .Left              = 104
567:             .Width             = 39
568:             .Height            = 23
569:             .MaxLength         = 3
570:             .TabIndex          = 2
571:             .Value             = ""
572:             .DisabledBackColor = RGB(255, 255, 255)
573:             .DisabledForeColor = RGB(0, 0, 128)
574:             .Visible           = .T.
575:         ENDWITH
576: 
577:         *-- lbl_4c_Label2 ("Operacao :")
578:         THIS.AddObject("lbl_4c_Label2", "Label")
579:         WITH THIS.lbl_4c_Label2
580:             .Top       = 131
581:             .Left      = 154
582:             .Width     = 66
583:             .Height    = 15
584:             .BackStyle = 0
585:             .FontName  = "Verdana"
586:             .FontSize  = 8

*-- Linhas 706 a 1090:
706:         ENDWITH
707: 
708:         *-- Lookups (F4/ENTER/TAB) do filtro - GetcEmp.Valid e GetDopes.Valid
709:         *-- do legado (fwBuscaExt). CLAUDE.md #3/#33-corolario: BINDEVENT so
710:         *-- funciona com metodo PUBLIC; handlers com LPARAMETERS explicito
711:         *-- na 1a linha (regra "KeyPress handler").
712:         BINDEVENT(THIS.txt_4c_CEmp,  "KeyPress", THIS, "CEmpKeyPress")
713:         BINDEVENT(THIS.txt_4c_Dopes, "KeyPress", THIS, "DopesKeyPress")
714: 
715:         *-- Demais eventos do filtro (Fase 7) - GotFocus/LostFocus fieis ao
716:         *-- legado; Valid substituido por KeyPress em ENTER/TAB (CLAUDE.md -
717:         *-- BINDEVENT "Valid" nao dispara de forma confiavel em TextBox).
718:         BINDEVENT(THIS.txt_4c_CEmp,  "GotFocus",  THIS, "CEmpGotFocus")
719:         BINDEVENT(THIS.txt_4c_Numes, "GotFocus",  THIS, "NumesGotFocus")
720:         BINDEVENT(THIS.txt_4c_Numes, "KeyPress",  THIS, "NumesKeyPress")
721:         *-- NAO renomear para algo terminado em "LostFocus": o CorretorAutomatico
722:         *-- (Pattern #74, heuristica "d") reescreve TODO BINDEVENT LostFocus cujo
723:         *-- handler termine em "LostFocus" para KeyPress, por causa do risco de
724:         *-- recursao com FormBuscaAuxiliar - esta tela nao abre lookup aqui, mas
725:         *-- o nome ainda dispara o falso positivo. Handler chama-se
726:         *-- NumesAoSairDoCampo por isso.
727:         BINDEVENT(THIS.txt_4c_Numes, "LostFocus", THIS, "NumesAoSairDoCampo")
728:         BINDEVENT(THIS.txt_4c_DtI,   "GotFocus",  THIS, "DtIGotFocus")
729:         BINDEVENT(THIS.txt_4c_DtF,   "GotFocus",  THIS, "DtFGotFocus")
730:         BINDEVENT(THIS.txt_4c_DtF,   "KeyPress",  THIS, "DtFKeyPress")
731:     ENDPROC
732: 
733:     *==========================================================================
734:     * CEmpKeyPress - equivalente a GetcEmp.Valid do legado. Dispara em
735:     * ENTER(13)/TAB(9)/F4(115) (CLAUDE.md regra do KeyPress de lookup - so F4
736:     * deixaria o usuario preso apos digitar e dar TAB).
737:     *==========================================================================
738:     PROCEDURE CEmpKeyPress
739:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
740: 
741:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
742:             RETURN
743:         ENDIF
744: 
745:         THIS.AbrirLookupEmpresa()
746:     ENDPROC
747: 
748:     *==========================================================================
749:     * AbrirLookupEmpresa - tenta o match EXATO primeiro (SIGMVMVTBO.
750:     * ValidarEmpresa, equivalente ao Seek/Select do fwBuscaExt); nao achando,
751:     * abre o picker direto (CLAUDE.md - MsgAviso antes do picker eh
752:     * anti-padrao: o campo digitado vira o prefixo de busca).
753:     *==========================================================================
754:     PROTECTED PROCEDURE AbrirLookupEmpresa
755:         LOCAL loc_cValor
756: 
757:         IF !EMPTY(THIS.txt_4c_CEmp.Value)
758:             loc_cValor = ALLTRIM(TRANSFORM(THIS.txt_4c_CEmp.Value))
759: 
760:             IF THIS.this_oBusinessObject.ValidarEmpresa(loc_cValor)
761:                 THIS.txt_4c_CEmp.Value = THIS.this_oBusinessObject.this_cEmps
762:                 RETURN
763:             ENDIF
764: 
765:             THIS.AbrirBuscaEmpresa(loc_cValor)
766:         ENDIF
767:     ENDPROC
768: 
769:     *==========================================================================
770:     * AbrirBuscaEmpresa - FormBuscaAuxiliar sobre SigCdEmp (Cemps/Razsocs -
771:     * as MESMAS colunas do fwBuscaExt legado: 'cEmps'/'RazSocs'; docs\schema.sql
772:     * confirma as duas em SigCdEmp, entao nao ha grafia inventada aqui -
773:     * CLAUDE.md regra #44 veta Emps/NComps, nao Razsocs).
774:     * Assinatura do CREATEOBJECT com HANDLE em 1o lugar (CLAUDE.md #36) e
775:     * contrato this_lAchouRegistro/this_lSelecionou (CLAUDE.md #37).
776:     *==========================================================================
777:     PROTECTED PROCEDURE AbrirBuscaEmpresa(par_cValorDigitado)
778:         LOCAL loc_oBusca
779: 
780:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
781:             "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", ;
782:             ALLTRIM(TRANSFORM(par_cValorDigitado)), "Buscar Empresa")
783: 
784:         IF VARTYPE(loc_oBusca) = "O"
785:             IF !loc_oBusca.this_lAchouRegistro
786:                 loc_oBusca.mAddColuna("Cemps",   "", "C" + CHR(243) + "digo")
787:                 loc_oBusca.mAddColuna("Razsocs", "", "Raz" + CHR(227) + "o Social")
788:                 loc_oBusca.Show()
789:             ENDIF
790: 
791:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
792:                 SELECT cursor_4c_BuscaEmp
793:                 THIS.txt_4c_CEmp.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
794:             ENDIF
795: 
796:             IF USED("cursor_4c_BuscaEmp")
797:                 USE IN cursor_4c_BuscaEmp
798:             ENDIF
799:             loc_oBusca.Release()
800:         ENDIF
801:     ENDPROC
802: 
803:     *==========================================================================
804:     * DopesKeyPress - equivalente a GetDopes.Valid do legado.
805:     *==========================================================================
806:     PROCEDURE DopesKeyPress
807:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
808: 
809:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
810:             RETURN
811:         ENDIF
812: 
813:         IF EMPTY(THIS.txt_4c_Dopes.Value)
814:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Deve ser informada !!!", ;
815:                      "Aten" + CHR(231) + CHR(227) + "o")
816:         ELSE
817:             THIS.AbrirLookupOperacao()
818:         ENDIF
819: 
820:         *-- "ThisForm.BtnOficina.Visible = ThisForm.lAcOficina" do fim do
821:         *-- GetDopes.Valid legado - roda em QUALQUER desfecho (achou, nao
822:         *-- achou+picker, campo vazio), por isso fica fora do IF acima.
823:         THIS.cmd_4c_BtnOficina.Visible = THIS.this_lAcOficina
824:     ENDPROC
825: 
826:     *==========================================================================
827:     * AbrirLookupOperacao - tenta o match EXATO (SIGMVMVTBO.ValidarOperacao);
828:     * nao achando, abre o picker direto. Em qualquer resultado que preencha
829:     * txt_4c_Dopes, reproduz o trecho do legado
830:     * "ThisForm.lAcOficina = fChecaAcesso(padl(CsSigCdOpe.nDopes,8,'0'),
831:     * 'OPPEND')" via AtualizarAcessoOficina().
832:     *==========================================================================
833:     PROTECTED PROCEDURE AbrirLookupOperacao
834:         LOCAL loc_cValor
835: 
836:         THIS.this_lAcOficina = .F.
837: 
838:         IF !EMPTY(THIS.txt_4c_Dopes.Value)
839:             loc_cValor = ALLTRIM(TRANSFORM(THIS.txt_4c_Dopes.Value))
840: 
841:             IF THIS.this_oBusinessObject.ValidarOperacao(loc_cValor)
842:                 THIS.txt_4c_Dopes.Value = THIS.this_oBusinessObject.this_cDopes
843:                 THIS.AtualizarAcessoOficina()
844:                 RETURN
845:             ENDIF
846: 
847:             THIS.AbrirBuscaOperacao(loc_cValor)
848:         ENDIF
849:     ENDPROC
850: 
851:     *==========================================================================
852:     * AbrirBuscaOperacao - FormBuscaAuxiliar sobre SigCdOpe. CLAUDE.md regra
853:     * "SigCdOpe eh single-column": Dopes eh PK E descricao ao mesmo tempo -
854:     * UMA UNICA mAddColuna, NUNCA descrs/Descrs (coluna que nao existe nessa
855:     * tabela).
856:     *==========================================================================
857:     PROTECTED PROCEDURE AbrirBuscaOperacao(par_cValorDigitado)
858:         LOCAL loc_oBusca
859: 
860:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
861:             "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
862:             ALLTRIM(TRANSFORM(par_cValorDigitado)), ;
863:             "Buscar Opera" + CHR(231) + CHR(227) + "o")
864: 
865:         IF VARTYPE(loc_oBusca) = "O"
866:             IF !loc_oBusca.this_lAchouRegistro
867:                 loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
868:                 loc_oBusca.Show()
869:             ENDIF
870: 
871:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
872:                 SELECT cursor_4c_BuscaOpe
873:                 THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
874:                 THIS.AtualizarAcessoOficina()
875:             ENDIF
876: 
877:             IF USED("cursor_4c_BuscaOpe")
878:                 USE IN cursor_4c_BuscaOpe
879:             ENDIF
880:             loc_oBusca.Release()
881:         ENDIF
882:     ENDPROC
883: 
884:     *==========================================================================
885:     * AtualizarAcessoOficina - "ThisForm.lAcOficina = fChecaAcesso(
886:     * padl(CsSigCdOpe.nDopes,8,'0'), 'OPPEND')" do legado (fim do
887:     * GetDopes.Valid). fChecaAcesso e' stub global (utils\functions.prg) que
888:     * devolve .T. quando o Framework de permissoes nao esta disponivel - o
889:     * flag e' espelhado tambem no BO (this_lAcOficina), que e' quem consome a
890:     * checagem na navegacao de niveis 3+ (Fases 7-8).
891:     *==========================================================================
892:     PROTECTED PROCEDURE AtualizarAcessoOficina
893:         LOCAL loc_nCodOpe
894: 
895:         THIS.this_lAcOficina = .F.
896: 
897:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.txt_4c_Dopes.Value)
898:             loc_nCodOpe = THIS.this_oBusinessObject.ObterCodigoOperacao( ;
899:                 ALLTRIM(TRANSFORM(THIS.txt_4c_Dopes.Value)))
900: 
901:             IF loc_nCodOpe >= 0
902:                 THIS.this_lAcOficina = fChecaAcesso(PADL(TRANSFORM(loc_nCodOpe), 8, "0"), "OPPEND")
903:             ENDIF
904:         ENDIF
905: 
906:         THIS.this_oBusinessObject.this_lAcOficina = THIS.this_lAcOficina
907:     ENDPROC
908: 
909:     *==========================================================================
910:     * CEmpGotFocus - equivalente a GetcEmp.GotFocus: entrar de novo no campo
911:     * Empresa reinicia a busca (limpa a arvore e os campos Operacao/Numero).
912:     *==========================================================================
913:     PROCEDURE CEmpGotFocus
914:         IF THIS.ArvoreDisponivel()
915:             THIS.obj_4c_TreeView.ClearNodes
916:         ENDIF
917: 
918:         THIS.txt_4c_Dopes.Value = ""
919:         THIS.txt_4c_Numes.Value = 0
920:     ENDPROC
921: 
922:     *==========================================================================
923:     * NumesGotFocus - equivalente a GetNumes.GotFocus: entrar no campo Numero
924:     * zera o filtro de periodo (os dois modos de busca - por operacao ou por
925:     * periodo - sao mutuamente exclusivos no legado).
926:     *==========================================================================
927:     PROCEDURE NumesGotFocus
928:         THIS.txt_4c_DtI.Value = {}
929:         THIS.txt_4c_DtF.Value = {}
930:     ENDPROC
931: 
932:     *==========================================================================
933:     * NumesAoSairDoCampo - equivalente a GetNumes.LostFocus: com numero
934:     * informado, zera o nivel de expansao corrente e manda o foco para o
935:     * botao Expandir (Buttons(1) do obj_4c_Commandgroup1 - Command1 no
936:     * legado). NAO chamar "NumesLostFocus": o CorretorAutomatico reescreve
937:     * qualquer BINDEVENT LostFocus cujo handler termine em "LostFocus" para
938:     * KeyPress (Pattern #74 - risco de recursao com FormBuscaAuxiliar), o que
939:     * quebraria este handler (dispararia a cada tecla, roubando o foco do
940:     * campo enquanto o usuario ainda digita).
941:     *==========================================================================
942:     PROCEDURE NumesAoSairDoCampo
943:         IF THIS.txt_4c_Numes.Value != 0
944:             THIS.this_nNodeExp = 0
945:             THIS.obj_4c_Commandgroup1.Buttons(1).SetFocus()
946:         ENDIF
947:     ENDPROC
948: 
949:     *==========================================================================
950:     * NumesKeyPress - equivalente a GetNumes.Valid: com Empresa/Operacao/
951:     * Numero preenchidos, monta a arvore de detalhe da operacao (MakeTree).
952:     *==========================================================================
953:     PROCEDURE NumesKeyPress
954:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
955: 
956:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
957:             RETURN
958:         ENDIF
959: 
960:         IF THIS.txt_4c_Numes.Value = 0
961:             RETURN
962:         ENDIF
963: 
964:         IF EMPTY(THIS.txt_4c_CEmp.Value)
965:             MsgAviso("Empresa Deve ser Informada !!", "Aten" + CHR(231) + CHR(227) + "o")
966:             RETURN
967:         ENDIF
968: 
969:         IF EMPTY(THIS.txt_4c_Dopes.Value)
970:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Deve ser Informada !!", ;
971:                      "Aten" + CHR(231) + CHR(227) + "o")
972:             RETURN
973:         ENDIF
974: 
975:         IF THIS.CarregarDados()
976:             THIS.this_lRetorno = .T.
977:         ENDIF
978:     ENDPROC
979: 
980:     *==========================================================================
981:     * DtIGotFocus - equivalente a GetDtI.GotFocus: entrar no campo Data
982:     * Inicial zera o Numero (busca por periodo, nao por operacao especifica).
983:     *==========================================================================
984:     PROCEDURE DtIGotFocus
985:         THIS.txt_4c_Numes.Value = 0
986:     ENDPROC
987: 
988:     *==========================================================================
989:     * DtFGotFocus - equivalente a GetDtF.GotFocus.
990:     *==========================================================================
991:     PROCEDURE DtFGotFocus
992:         THIS.this_nNodeExp      = 0
993:         THIS.txt_4c_Numes.Value = 0
994:     ENDPROC
995: 
996:     *==========================================================================
997:     * DtFKeyPress - equivalente a GetDtF.Valid: com Data Inicial e (Empresa OU
998:     * Operacao) preenchidas, exige as duas e lista as operacoes do periodo
999:     * (MakeList).
1000:     *==========================================================================
1001:     PROCEDURE DtFKeyPress
1002:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1003: 
1004:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1005:             RETURN
1006:         ENDIF
1007: 
1008:         IF EMPTY(THIS.txt_4c_DtI.Value)
1009:             MsgAviso("Data Inicial Inv" + CHR(225) + "lida !!!", ;
1010:                      "Aten" + CHR(231) + CHR(227) + "o")
1011:             RETURN
1012:         ENDIF
1013: 
1014:         IF EMPTY(THIS.txt_4c_DtF.Value)
1015:             RETURN
1016:         ENDIF
1017: 
1018:         IF EMPTY(THIS.txt_4c_CEmp.Value) AND EMPTY(THIS.txt_4c_Dopes.Value)
1019:             RETURN
1020:         ENDIF
1021: 
1022:         IF EMPTY(THIS.txt_4c_CEmp.Value)
1023:             MsgAviso("Empresa Deve ser Informada !!", "Aten" + CHR(231) + CHR(227) + "o")
1024:             RETURN
1025:         ENDIF
1026: 
1027:         IF EMPTY(THIS.txt_4c_Dopes.Value)
1028:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Deve ser Informada !!", ;
1029:                      "Aten" + CHR(231) + CHR(227) + "o")
1030:             RETURN
1031:         ENDIF
1032: 
1033:         IF THIS.CarregarListaPeriodo()
1034:             THIS.this_lRetorno = .F.
1035:         ENDIF
1036:     ENDPROC
1037: 
1038:     *==========================================================================
1039:     * AplicarParametrosAbertura - Reproduz o trecho do Init legado que usa os
1040:     * parametros de abertura (pcEmps/pcDopes/pcNumes) para pre-preencher o
1041:     * filtro:
1042:     *   If !IsEmpty(pcEmps)  -> GetCEmp.Value  = Alltrim(pcEmps)
1043:     *   If !IsEmpty(pcDopes) -> GetDopes.Value = pcDopes
1044:     *   If !IsEmpty(pcNumes) -> GetNumes.Value = pcNumes
1045:     *   GetCEmp/GetDopes/GetNumes.ReadOnly = (os 3 preenchidos)
1046:     *   If Automatico (os 3 preenchidos) -> Enabled = .F. nos 5 campos
1047:     * Roda DEPOIS de ConfigurarFiltros (os controles ja existem) e ANTES do
1048:     * CarregarDados() automatico, exatamente como no Init legado.
1049:     *==========================================================================
1050:     PROTECTED PROCEDURE AplicarParametrosAbertura
1051:         LOCAL loc_lTravado
1052: 
1053:         *-- No legado o ReadOnly dos tres campos e' a MESMA expressao do
1054:         *-- Automatico (! IsEmpty(pcEmps) And ! IsEmpty(pcDopes) And
1055:         *-- ! IsEmpty(pcNumes)), calculada logo acima no Init. Reusar a
1056:         *-- property em vez de repetir a conta evita que as duas divirjam.
1057:         loc_lTravado = THIS.this_lAutomatico
1058: 
1059:         IF !EMPTY(THIS.this_cEmpsParam)
1060:             THIS.txt_4c_CEmp.Value = THIS.this_cEmpsParam
1061:         ENDIF
1062:         THIS.txt_4c_CEmp.ReadOnly = loc_lTravado
1063: 
1064:         IF !EMPTY(THIS.this_cDopesParam)
1065:             THIS.txt_4c_Dopes.Value = THIS.this_cDopesParam
1066:         ENDIF
1067:         THIS.txt_4c_Dopes.ReadOnly = loc_lTravado
1068: 
1069:         IF THIS.this_nNumesParam != 0
1070:             THIS.txt_4c_Numes.Value = THIS.this_nNumesParam
1071:         ENDIF
1072:         THIS.txt_4c_Numes.ReadOnly = loc_lTravado
1073: 
1074:         IF THIS.this_lAutomatico
1075:             THIS.txt_4c_CEmp.Enabled  = .F.
1076:             THIS.txt_4c_Dopes.Enabled = .F.
1077:             THIS.txt_4c_Numes.Enabled = .F.
1078:             THIS.txt_4c_DtI.Enabled   = .F.
1079:             THIS.txt_4c_DtF.Enabled   = .F.
1080:         ENDIF
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     * ArvoreDisponivel - .T. quando o controle ActiveX da arvore foi criado
1085:     * com sucesso em ConfigurarControles. O ctTree.ocx pode nao estar
1086:     * registrado na estacao (ou o form estar em modo teste), e nesse caso
1087:     * TODA chamada a API de nos tem de ser evitada - o objeto simplesmente
1088:     * nao existe e qualquer referencia derrubaria o metodo.
1089:     *==========================================================================
1090:     PROTECTED FUNCTION ArvoreDisponivel()

*-- Linhas 1158 a 1313:
1158:     *   AddImage(LoadPicture('\vbmp\depend3.bmp'))  -> 2 (produto/item)
1159:     *   AddImage(LoadPicture('\vbmp\OHist.Ico'))    -> 3 (operacao paga)
1160:     *==========================================================================
1161:     PROTECTED PROCEDURE PrepararArvore()
1162:         LOCAL loc_oErro
1163: 
1164:         IF THIS.ArvoreDisponivel()
1165:             TRY
1166:                 WITH THIS.obj_4c_TreeView
1167:                     IF !THIS.this_lImagensArvore
1168:                         .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "Form4.Ico"))
1169:                         .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "depend3.bmp"))
1170:                         .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "OHist.Ico"))
1171:                         THIS.this_lImagensArvore = .T.
1172:                     ENDIF
1173: 
1174:                     .ClearNodes
1175:                     .TipsDisplay   = .T.
1176:                     .ExpandOnDClick
1177:                     .SmallIcons    = .T.
1178:                     .PicAlign      = 0
1179:                     .SelectedStyle = 2
1180:                     .PictureType   = 1
1181:                 ENDWITH
1182:             CATCH TO loc_oErro
1183:                 MsgErro("Falha ao preparar a " + CHR(225) + "rvore: " + loc_oErro.Message, "Erro")
1184:             ENDTRY
1185:         ENDIF
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * CarregarDados - Metodo de carga desta tela (equivalente ao MakeTree do
1190:     * legado). Monta a chave EmpDopNums a partir do filtro, pede os dados ao
1191:     * SIGMVMVTBO e desenha os dois primeiros niveis da arvore:
1192:     *   nivel 1 - a operacao (SigMvCab): Emp - Operacao - Numero - Nota -
1193:     *             Data - Usuario - DtAlt - UsuAlt, NodeCargo = EmpDopNums
1194:     *   nivel 2 - os produtos da operacao (SigMvItn): Produto - Descricao -
1195:     *             Qtde, NodeCargo = 'PRODUTO'
1196:     * Os niveis 3+ (SubNivel/HiNivel do legado, ja portados como consultas em
1197:     * SIGMVMVTBO) sao acionados pelos botoes de navegacao, junto com os
1198:     * eventos das Fases 7-8.
1199:     *
1200:     * Texto dos nos e icones TRANSCRITOS do legado (PROCEDURE maketree), sem
1201:     * reescrever: Iif(ChkPagos,3,1) para a operacao e icone 2 para o produto.
1202:     *==========================================================================
1203:     PROCEDURE CarregarDados()
1204:         LOCAL loc_lSucesso, loc_cEmps, loc_cDopes, loc_nNumes, loc_cEmpDopNums
1205:         LOCAL loc_oErro, loc_lCarregou
1206: 
1207:         loc_lSucesso  = .F.
1208:         loc_lCarregou = .F.
1209: 
1210:         *-- FormParaBO eh a fonte UNICA da transferencia filtro -> BO (e ja
1211:         *-- monta Padr(GetCEmp,3)+Padr(GetDopes,20)+Str(GetNumes,6) do legado);
1212:         *-- ele mesmo reporta quando o Business Object nao esta disponivel.
1213:         IF THIS.FormParaBO()
1214:             WITH THIS.this_oBusinessObject
1215:                 loc_cEmps       = ALLTRIM(.this_cEmps)
1216:                 loc_cDopes      = ALLTRIM(.this_cDopes)
1217:                 loc_nNumes      = .this_nNumes
1218:                 loc_cEmpDopNums = .this_cEmpDopNums
1219:             ENDWITH
1220: 
1221:             IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR loc_nNumes = 0
1222:                 MsgAviso("Empresa, Opera" + CHR(231) + CHR(227) + "o e N" + CHR(250) + ;
1223:                          "mero devem ser informados !!", "Aten" + CHR(231) + CHR(227) + "o")
1224:             ELSE
1225:                 *-- SQLEXEC com handle invalido DISPARA excecao em vez de
1226:                 *-- devolver -1 (medido: "Connection handle is invalid" saindo
1227:                 *-- de SIGMVMVTBO.CarregarOperacao). Sem este TRY o usuario
1228:                 *-- veria o "Program Error" CRU do VFP no lugar do dialogo do
1229:                 *-- sistema. RETURN so DEPOIS do ENDTRY (CLAUDE.md #1).
1230:                 TRY
1231:                     loc_lCarregou = THIS.this_oBusinessObject.CarregarOperacao( ;
1232:                         loc_cEmps, loc_cDopes, loc_nNumes)
1233: 
1234:                     IF loc_lCarregou
1235:                         IF !THIS.this_oBusinessObject.CarregarItens(loc_cEmpDopNums)
1236:                             MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
1237:                                      "Aten" + CHR(231) + CHR(227) + "o")
1238:                         ENDIF
1239: 
1240:                         *-- ThisForm.pcEmpDopNums[1,1] / [1,2] = 1 do MakeTree
1241:                         DIMENSION THIS.this_aHistorico[1, 2]
1242:                         THIS.this_aHistorico[1, 1] = loc_cEmpDopNums
1243:                         THIS.this_aHistorico[1, 2] = 1
1244: 
1245:                         THIS.PopularArvore(loc_cEmpDopNums)
1246: 
1247:                         THIS.this_nNodeExp = 1
1248:                         loc_lSucesso = .T.
1249:                     ELSE
1250:                         MsgAviso(IIF(EMPTY(THIS.this_oBusinessObject.this_cMensagemErro), ;
1251:                             "Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Localizada !!", ;
1252:                             THIS.this_oBusinessObject.this_cMensagemErro), ;
1253:                             "Aten" + CHR(231) + CHR(227) + "o")
1254:                     ENDIF
1255:                 CATCH TO loc_oErro
1256:                     MsgErro("Falha ao consultar a opera" + CHR(231) + CHR(227) + "o: " + ;
1257:                         loc_oErro.Message + CHR(13) + ;
1258:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1259:                         "Procedure: " + loc_oErro.Procedure, "Erro")
1260:                 ENDTRY
1261:             ENDIF
1262:         ENDIF
1263: 
1264:         RETURN loc_lSucesso
1265:     ENDPROC
1266: 
1267:     *==========================================================================
1268:     * PopularArvore - Desenha os nos a partir dos cursores ja carregados pelo
1269:     * BO (cursor_4c_Cab = SigMvCab, cursor_4c_Itens = SigMvItn). Separado de
1270:     * CarregarDados para que a consulta continue valendo mesmo quando o
1271:     * controle ActiveX da arvore nao esta disponivel na estacao.
1272:     *==========================================================================
1273:     PROTECTED PROCEDURE PopularArvore(par_cEmpDopNums)
1274:         LOCAL loc_oErro, loc_nNo, loc_cTexto, loc_nIconeCab, loc_cProduto
1275: 
1276:         IF THIS.ArvoreDisponivel()
1277:             THIS.PrepararArvore()
1278: 
1279:             TRY
1280:                 IF USED("cursor_4c_Cab")
1281:                     SELECT cursor_4c_Cab
1282:                     GO TOP
1283: 
1284:                     *-- Iif(crSigMvCab.ChkPagos, 3, 1) do legado. A coluna bit
1285:                     *-- chega ora Logico ora Numerico conforme o driver, por
1286:                     *-- isso le-se a property ja normalizada pelo BO (#13).
1287:                     loc_nIconeCab = IIF(THIS.this_oBusinessObject.this_lChkPagos, 3, 1)
1288: 
1289:                     loc_cTexto = ALLTRIM(TratarNulo(cursor_4c_Cab.Emps, "")) + " - " + ;
1290:                         ALLTRIM(TratarNulo(cursor_4c_Cab.Dopes, "")) + " - " + ;
1291:                         ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Cab.Numes, 0), "999999")) + " - " + ;
1292:                         ALLTRIM(TratarNulo(cursor_4c_Cab.Notas, "")) + " - " + ;
1293:                         DTOC(ConverterParaData(cursor_4c_Cab.Datas)) + " - " + ;
1294:                         ALLTRIM(TratarNulo(cursor_4c_Cab.Usuars, "")) + " - " + ;
1295:                         DTOC(ConverterParaData(cursor_4c_Cab.DtAlts)) + " - " + ;
1296:                         ALLTRIM(TratarNulo(cursor_4c_Cab.Usuals, ""))
1297: 
1298:                     WITH THIS.obj_4c_TreeView
1299:                         loc_nNo = .AddPictureNode(loc_cTexto, 0, 1, loc_nIconeCab, 0, 0)
1300:                         .NodeHeader(loc_nNo)     = .T.
1301:                         .NodeExpanded(loc_nNo)   = .T.
1302:                         .NodeShowChecks(loc_nNo) = .F.
1303:                         .NodeFontBold(loc_nNo)   = 2
1304:                         .NodeCargo(loc_nNo)      = ALLTRIM(TratarNulo(par_cEmpDopNums, ""))
1305:                     ENDWITH
1306:                 ENDIF
1307: 
1308:                 IF USED("cursor_4c_Itens")
1309:                     SELECT cursor_4c_Itens
1310:                     GO TOP
1311: 
1312:                     SCAN
1313:                         loc_cProduto = ALLTRIM(TratarNulo(cursor_4c_Itens.cPros, ""))

*-- Linhas 1362 a 1418:
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * HiNivel - equivalente ao PROCEDURE hinivel do legado: historico de
1366:     * baixa/producao (SigMvPec+SigMvCab+SigMvItn UNION ALL SigOpDev+SigMvCab+
1367:     * SigMvItn) de um EmpDopNums, desenhando um no "(-)" por linha nova
1368:     * (dedup em this_aHistorico - equivalente a ThisForm.pcEmpDopNums) e
1369:     * recursando em SubNivel/HiNivel do proximo nivel enquanto
1370:     * this_nNiveis <= 50 (mesmo teto do legado) e o EmpDopNums nao for
1371:     * "NF - TRF SIMBOLICA" (fim de cadeia no legado).
1372:     *
1373:     * Cada chamada a BO/SQLEXEC troca a work area corrente - por isso o
1374:     * cursor do nivel eh re-selecionado apos qualquer chamada aninhada, antes
1375:     * de continuar a leitura da linha ou de deixar o SCAN avancar (mesma
1376:     * disciplina do "Select &lcSqlFile." espalhado pelo hinivel legado).
1377:     *==========================================================================
1378:     PROTECTED PROCEDURE HiNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
1379:         LOCAL loc_cCursorHi, loc_nCodigos, loc_cEmpSubns, loc_nCodOpe, loc_cDopesOpe
1380:         LOCAL loc_nNumes, loc_cEmpDopFilho, loc_cChaveDedup, loc_nPos
1381:         LOCAL loc_cCursorDet, loc_cTexto, loc_cDtt, loc_nNo, loc_lChkPagos
1382:         LOCAL loc_lTemProduto, loc_oErro
1383: 
1384:         IF !THIS.ArvoreDisponivel()
1385:             RETURN
1386:         ENDIF
1387: 
1388:         loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros))
1389: 
1390:         TRY
1391:             loc_cCursorHi = THIS.this_oBusinessObject.ObterHistoricoNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
1392: 
1393:             IF EMPTY(loc_cCursorHi) OR !USED(loc_cCursorHi)
1394:                 RETURN
1395:             ENDIF
1396: 
1397:             SELECT (loc_cCursorHi)
1398:             SCAN
1399:                 loc_nCodigos  = Codigos
1400:                 loc_cEmpSubns = ALLTRIM(TratarNulo(EmpSubns, ""))
1401: 
1402:                 loc_nCodOpe   = INT(loc_nCodigos / 1000000)
1403:                 loc_cDopesOpe = THIS.this_oBusinessObject.ObterDopesPorCodigo(loc_nCodOpe)
1404:                 loc_nNumes    = VAL(RIGHT(ALLTRIM(TRANSFORM(loc_nCodigos)), 6))
1405: 
1406:                 loc_cEmpDopFilho = loc_cEmpSubns + PADR(loc_cDopesOpe, 20) + STR(loc_nNumes, 6)
1407:                 loc_cChaveDedup  = par_cEmpDopNums + loc_cEmpDopFilho + IIF(loc_lTemProduto, par_cCPros, SPACE(14))
1408: 
1409:                 IF USED(loc_cCursorHi)
1410:                     SELECT (loc_cCursorHi)
1411:                 ENDIF
1412: 
1413:                 loc_nPos = ASCAN(THIS.this_aHistorico, loc_cChaveDedup)
1414: 
1415:                 IF loc_nPos = 0 AND !(loc_cEmpDopFilho == THIS.this_aHistorico[1, 1])
1416:                     DIMENSION THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1) + 1, 2]
1417:                     THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 1] = loc_cChaveDedup
1418:                     THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 2] = par_nNivel

*-- Linhas 1467 a 1516:
1467:     ENDPROC
1468: 
1469:     *==========================================================================
1470:     * SubNivel - equivalente ao PROCEDURE subnivel do legado: mesma familia
1471:     * de consulta de HiNivel, mas filtrando pelo CODIGO da operacao
1472:     * (nDopes*1000000 + numero) em vez do EmpDopNums, desenhando um no "(+)"
1473:     * por linha nova. Diferente de HiNivel, os dados do no vem direto da
1474:     * linha do cursor (sem uma segunda consulta de detalhe).
1475:     *==========================================================================
1476:     PROTECTED PROCEDURE SubNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
1477:         LOCAL loc_cCursorSub, loc_nCodOpe, loc_nCodigo, loc_cChaveDedup, loc_nPos
1478:         LOCAL loc_cTexto, loc_cDtt, loc_nNo, loc_lChkPagos, loc_cEmpDopFilho
1479:         LOCAL loc_lTemProduto, loc_oErro
1480: 
1481:         IF !THIS.ArvoreDisponivel()
1482:             RETURN
1483:         ENDIF
1484: 
1485:         loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros))
1486: 
1487:         TRY
1488:             loc_nCodOpe = THIS.this_oBusinessObject.ObterCodigoOperacao(SUBSTR(par_cEmpDopNums, 4, 20))
1489:             IF loc_nCodOpe < 0
1490:                 RETURN
1491:             ENDIF
1492:             loc_nCodigo = loc_nCodOpe * 1000000 + VAL(RIGHT(par_cEmpDopNums, 6))
1493: 
1494:             loc_cCursorSub = THIS.this_oBusinessObject.ObterSubNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
1495: 
1496:             IF EMPTY(loc_cCursorSub) OR !USED(loc_cCursorSub)
1497:                 RETURN
1498:             ENDIF
1499: 
1500:             SELECT (loc_cCursorSub)
1501:             SCAN
1502:                 loc_cEmpDopFilho = ALLTRIM(TratarNulo(EmpDopNums, ""))
1503:                 loc_cChaveDedup  = ALLTRIM(TRANSFORM(loc_nCodigo)) + loc_cEmpDopFilho + ;
1504:                     IIF(loc_lTemProduto, par_cCPros, SPACE(6))
1505: 
1506:                 loc_nPos = ASCAN(THIS.this_aHistorico, loc_cChaveDedup)
1507: 
1508:                 IF loc_nPos = 0 AND !(loc_cEmpDopFilho == THIS.this_aHistorico[1, 1])
1509:                     DIMENSION THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1) + 1, 2]
1510:                     THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 1] = loc_cChaveDedup
1511:                     THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 2] = par_nNivel
1512: 
1513:                     loc_cDtt = THIS.ObterTextoDataHora(Datas) + " (" + THIS.ObterTextoHora(Datars) + ")"
1514:                     loc_lChkPagos = TratarNulo(ChkPagos, .F.)
1515: 
1516:                     loc_cTexto = "(+) " + ;

*-- Linhas 1561 a 1646:
1561:                 "vel " + TRANSFORM(par_nNivel) + "): " + loc_oErro.Message, "Erro")
1562:         ENDTRY
1563:     ENDPROC
1564: 
1565:     *==========================================================================
1566:     * NoHiPro - equivalente ao PROCEDURE nohipro do legado: baixas de
1567:     * estoque/producao ligadas ao CODIGO (nDopes*1000000+numero) do
1568:     * EmpDopNums informado, com saldo agregado zero (BO.ObterNoHiPro/
1569:     * DeduplicarSaldo). Cada linha nova (dedup em this_aOperacoes -
1570:     * equivalente a ThisForm.paOperacoes) recursa em NoProd/NoHiPro e, fora
1571:     * do nivel 3, tambem em SubNivel/HiNivel do proximo nivel.
1572:     *
1573:     * DESVIO DELIBERADO do dump legado, registrado aqui (regra CLAUDE.md
1574:     * #28/#31 - divergencia de comportamento entre migrado e legado exige
1575:     * comentario explicito): o dump tem "If Ascan(ThisForm.paOperacoes,
1576:     * EmpDopNums)" SEM "= 0" nem "<> 0" (ao contrario do NoProd logo abaixo,
1577:     * que usa corretamente "= 0"). Ascan devolve 0 (falso) na PRIMEIRA vez
1578:     * que um EmpDopNums aparece - a leitura literal do dump faria este bloco
1579:     * NUNCA desenhar nenhum no na primeira ocorrencia (a checagem so fica
1580:     * verdadeira depois que o item JA foi adicionado por outro caminho), ou
1581:     * seja, o ramo NoHiPro ficaria estruturalmente morto (nunca dispara na
1582:     * entrada natural do dedup). Tratado como erro de digitacao (falta do
1583:     * "= 0", igual ao par simetrico em NoProd) e normalizado para "= 0" -
1584:     * NAO reproduzir o "bug" faria a funcionalidade nunca aparecer, o que
1585:     * contraria a regra do projeto de paridade funcional completa.
1586:     *==========================================================================
1587:     PROTECTED PROCEDURE NoHiPro(par_nNivel, par_cEmps, par_cEmpDopNums, par_cCPros)
1588:         LOCAL loc_cCursorDedup, loc_cEDN, loc_cEmpSubns, loc_nCodigos, loc_cCursorCab
1589:         LOCAL loc_cDados, loc_cDados1, loc_nNo, loc_lChkPagos, loc_oErro
1590: 
1591:         IF !THIS.ArvoreDisponivel()
1592:             RETURN
1593:         ENDIF
1594: 
1595:         TRY
1596:             loc_cCursorDedup = THIS.this_oBusinessObject.ObterNoHiPro(par_nNivel, par_cEmps, par_cEmpDopNums, par_cCPros)
1597: 
1598:             IF EMPTY(loc_cCursorDedup) OR !USED(loc_cCursorDedup)
1599:                 RETURN
1600:             ENDIF
1601: 
1602:             SELECT (loc_cCursorDedup)
1603:             GO TOP
1604:             loc_cDados1 = "Inicio"
1605: 
1606:             IF !EOF(loc_cCursorDedup)
1607:                 SCAN
1608:                     loc_cEDN      = ALLTRIM(TratarNulo(EmpDopNums, ""))
1609:                     loc_cEmpSubns = ALLTRIM(TratarNulo(EmpSubns, ""))
1610:                     loc_nCodigos  = Codigos
1611:                     loc_lChkPagos = TratarNulo(ChkPagos, .F.)
1612: 
1613:                     IF ASCAN(THIS.this_aOperacoes, loc_cEDN) = 0
1614:                         IF ALEN(THIS.this_aOperacoes, 1) = 1 AND EMPTY(THIS.this_aOperacoes[1])
1615:                             THIS.this_aOperacoes[1] = loc_cEDN
1616:                         ELSE
1617:                             DIMENSION THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1) + 1]
1618:                             THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1)] = loc_cEDN
1619:                         ENDIF
1620: 
1621:                         loc_cDados = ALLTRIM(TratarNulo(Emps, "")) + " - " + ;
1622:                             ALLTRIM(TratarNulo(Dopes, "")) + " - " + ;
1623:                             ALLTRIM(TRANSFORM(TratarNulo(Numes, 0), "999999")) + " - " + ;
1624:                             ALLTRIM(TratarNulo(Notas, "")) + " - " + ;
1625:                             DTOC(ConverterParaData(TratarNulo(Datas, {}))) + " - "
1626: 
1627:                         loc_cCursorCab = THIS.this_oBusinessObject.ObterCabecalhoOperacao(loc_cEDN)
1628:                         IF !EMPTY(loc_cCursorCab) AND USED(loc_cCursorCab) AND !EOF(loc_cCursorCab)
1629:                             SELECT (loc_cCursorCab)
1630:                             loc_cDados = loc_cDados + ALLTRIM(TratarNulo(Usuars, "")) + " - " + ;
1631:                                 DTOC(ConverterParaData(TratarNulo(DtAlts, {}))) + " - " + ;
1632:                                 ALLTRIM(TratarNulo(Usuals, ""))
1633:                         ENDIF
1634: 
1635:                         IF USED(loc_cCursorDedup)
1636:                             SELECT (loc_cCursorDedup)
1637:                         ENDIF
1638: 
1639:                         IF loc_cDados != loc_cDados1
1640:                             IF THIS.ArvoreDisponivel()
1641:                                 WITH THIS.obj_4c_TreeView
1642:                                     loc_nNo = .AddPictureNode(loc_cDados, 0, par_nNivel, IIF(loc_lChkPagos, 3, 1), 0, 0)
1643:                                     .NodeHeader(loc_nNo)     = .F.
1644:                                     .NodeExpanded(loc_nNo)   = .F.
1645:                                     .NodeShowChecks(loc_nNo) = .F.
1646:                                     .NodeFontBold(loc_nNo)   = 1

*-- Linhas 1682 a 1748:
1682:     ENDPROC
1683: 
1684:     *==========================================================================
1685:     * NoProd - equivalente ao PROCEDURE noprod do legado: mesma logica de
1686:     * NoHiPro, mas filtrando pelo EmpDopNums reconstruido a partir do codigo
1687:     * do produto/operacao (par_nCodigo). Dedup em this_aOperacoes com
1688:     * "= 0" - igual ao dump original (o par simetrico correto de NoHiPro).
1689:     *
1690:     * DESVIO DELIBERADO do dump legado, registrado aqui (mesma regra do
1691:     * NoHiPro acima): a chamada final do bloco "pnNivel <> 3" do dump
1692:     * ("ThisForm.HINivel(pnNivel+1, EmpSubns, Int(codigos/1000000),
1693:     * Val(Right(Alltrim(Str(Codigos)),6)), pccPros)") passa 5 argumentos para
1694:     * um metodo declarado com 3 parametros (par_nNivel, par_cEmpDopNums,
1695:     * par_cCPros) - o 2o argumento (EmpSubns, so 3 caracteres) cairia em
1696:     * par_cEmpDopNums no lugar de um EmpDopNums completo, e o 3o (um NUMERO)
1697:     * cairia em par_cCPros no lugar do produto - os 2 argumentos extras
1698:     * seriam descartados em silencio pelo VFP (chamada com mais argumentos
1699:     * que parametros nao eh erro). Efeito prático: SUBSTR(par_cEmpDopNums,
1700:     * 4,20) sobre uma string de 3 chars devolve "", ObterDopesPorCodigo(0)
1701:     * nao acha nada - o ramo inteiro vira no-op silencioso. Tratado como
1702:     * copia-e-cola malfeita (o SubNivel logo acima, no MESMO bloco, ja chama
1703:     * com os 3 argumentos corretos: par_nNivel+1, loc_cEDN, par_cCPros) e
1704:     * normalizado para a mesma assinatura de 3 argumentos - mesma razao do
1705:     * desvio documentado em NoHiPro (funcionalidade completa > bug replicado
1706:     * que so produz no-op silencioso).
1707:     *==========================================================================
1708:     PROTECTED PROCEDURE NoProd(par_nNivel, par_cEmps, par_nCodigo, par_cCPros)
1709:         LOCAL loc_cCursorDedup, loc_cEDN, loc_cEmpSubns, loc_nCodigos, loc_cCursorCab
1710:         LOCAL loc_cDados, loc_cDados1, loc_nNo, loc_lChkPagos, loc_oErro
1711: 
1712:         IF !THIS.ArvoreDisponivel()
1713:             RETURN
1714:         ENDIF
1715: 
1716:         TRY
1717:             loc_cCursorDedup = THIS.this_oBusinessObject.ObterNoProd(par_nNivel, par_cEmps, par_nCodigo, par_cCPros)
1718: 
1719:             IF EMPTY(loc_cCursorDedup) OR !USED(loc_cCursorDedup)
1720:                 RETURN
1721:             ENDIF
1722: 
1723:             SELECT (loc_cCursorDedup)
1724:             GO TOP
1725:             loc_cDados1 = "Inicio"
1726: 
1727:             IF !EOF(loc_cCursorDedup)
1728:                 SCAN
1729:                     loc_cEDN      = ALLTRIM(TratarNulo(EmpDopNums, ""))
1730:                     loc_cEmpSubns = ALLTRIM(TratarNulo(EmpSubns, ""))
1731:                     loc_nCodigos  = Codigos
1732:                     loc_lChkPagos = TratarNulo(ChkPagos, .F.)
1733: 
1734:                     IF ASCAN(THIS.this_aOperacoes, loc_cEDN) = 0
1735:                         IF ALEN(THIS.this_aOperacoes, 1) = 1 AND EMPTY(THIS.this_aOperacoes[1])
1736:                             THIS.this_aOperacoes[1] = loc_cEDN
1737:                         ELSE
1738:                             DIMENSION THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1) + 1]
1739:                             THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1)] = loc_cEDN
1740:                         ENDIF
1741: 
1742:                         loc_cDados = ALLTRIM(TratarNulo(Emps, "")) + " - " + ;
1743:                             ALLTRIM(TratarNulo(Dopes, "")) + " - " + ;
1744:                             ALLTRIM(TRANSFORM(TratarNulo(Numes, 0), "999999")) + " - " + ;
1745:                             ALLTRIM(TratarNulo(Notas, "")) + " - " + ;
1746:                             DTOC(ConverterParaData(TratarNulo(Datas, {}))) + " - "
1747: 
1748:                         loc_cCursorCab = THIS.this_oBusinessObject.ObterCabecalhoOperacao(loc_cEDN)

*-- Linhas 1808 a 1890:
1808:     * operacoes de uma Empresa+Operacao dentro do intervalo GetDtI/GetDtF -
1809:     * usado quando o usuario nao informa o Numero e sim um periodo.
1810:     *==========================================================================
1811:     PROCEDURE CarregarListaPeriodo()
1812:         LOCAL loc_lSucesso, loc_cEmps, loc_cDopes, loc_dDtI, loc_dDtF
1813: 
1814:         loc_lSucesso = .F.
1815: 
1816:         *-- Mesma fonte unica de CarregarDados: FormParaBO transfere o filtro
1817:         *-- (e reporta BO ausente), aqui so se le o que ele gravou.
1818:         IF THIS.FormParaBO()
1819:             WITH THIS.this_oBusinessObject
1820:                 loc_cEmps  = ALLTRIM(.this_cEmps)
1821:                 loc_cDopes = ALLTRIM(.this_cDopes)
1822:                 loc_dDtI   = .this_dDtI
1823:                 loc_dDtF   = .this_dDtF
1824:             ENDWITH
1825: 
1826:             IF THIS.this_oBusinessObject.BuscarPorPeriodo(loc_cEmps, loc_cDopes, ;
1827:                     loc_dDtI, loc_dDtF)
1828:                 THIS.PopularArvoreLista()
1829:                 THIS.this_nNodeExp = 0
1830:                 loc_lSucesso = .T.
1831:             ELSE
1832:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
1833:                          "Aten" + CHR(231) + CHR(227) + "o")
1834:             ENDIF
1835:         ENDIF
1836: 
1837:         RETURN loc_lSucesso
1838:     ENDPROC
1839: 
1840:     *==========================================================================
1841:     * PopularArvoreLista - Desenha os nos de nivel 1 a partir de
1842:     * cursor_4c_Lista (equivalente ao Scan de crSigMvCab no MakeList legado).
1843:     * NodeCargo usa o MESMO formato fixo (Emps(3)+Dopes(20)+Numes(6)) do
1844:     * cursor_4c_Cab em PopularArvore - o legado grava NodeCargo SEM PADR aqui
1845:     * (Emps+Dopes+Transform(Numes)), mas a leitura (Command4/Command6/
1846:     * btnOperacao/BtnOficina) sempre faz Left(.,3)/Substr(.,4,20)/Substr(.,24)
1847:     * assumindo largura fixa; manter o formato fixo evita quebrar a navegacao
1848:     * quando o drill comeca por uma linha da LISTA em vez da ARVORE.
1849:     *==========================================================================
1850:     PROTECTED PROCEDURE PopularArvoreLista()
1851:         LOCAL loc_oErro, loc_nNo, loc_cTexto, loc_nIcone
1852: 
1853:         IF THIS.ArvoreDisponivel()
1854:             THIS.PrepararArvore()
1855: 
1856:             TRY
1857:                 IF USED("cursor_4c_Lista")
1858:                     SELECT cursor_4c_Lista
1859:                     GO TOP
1860: 
1861:                     SCAN
1862:                         loc_nIcone = IIF(cursor_4c_Lista.ChkPagos, 3, 1)
1863: 
1864:                         loc_cTexto = ALLTRIM(TratarNulo(cursor_4c_Lista.Emps, "")) + " - " + ;
1865:                             ALLTRIM(TratarNulo(cursor_4c_Lista.Dopes, "")) + " - " + ;
1866:                             ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Lista.Numes, 0), "999999")) + " - " + ;
1867:                             ALLTRIM(TratarNulo(cursor_4c_Lista.Notas, "")) + " - " + ;
1868:                             DTOC(ConverterParaData(cursor_4c_Lista.Datas)) + ;
1869:                             IIF(!ISNULL(cursor_4c_Lista.Qtds), " - Qtde : " + ;
1870:                                 ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Lista.Qtds, 0), "999,999.99")), "")
1871: 
1872:                         WITH THIS.obj_4c_TreeView
1873:                             loc_nNo = .AddPictureNode(loc_cTexto, 0, 1, loc_nIcone, 0, 0)
1874:                             .NodeHeader(loc_nNo)     = .F.
1875:                             .NodeExpanded(loc_nNo)   = .F.
1876:                             .NodeShowChecks(loc_nNo) = .F.
1877:                             .NodeFontBold(loc_nNo)   = 1
1878:                             .NodeCargo(loc_nNo)      = PADR(ALLTRIM(TratarNulo(cursor_4c_Lista.Emps, "")), 3) + ;
1879:                                 PADR(ALLTRIM(TratarNulo(cursor_4c_Lista.Dopes, "")), 20) + ;
1880:                                 STR(TratarNulo(cursor_4c_Lista.Numes, 0), 6)
1881:                         ENDWITH
1882:                     ENDSCAN
1883:                 ENDIF
1884: 
1885:                 WITH THIS.obj_4c_TreeView
1886:                     .ReDraw(.T.)
1887:                     .Refresh()
1888:                 ENDWITH
1889:             CATCH TO loc_oErro
1890:                 MsgErro("Falha ao montar a lista de opera" + CHR(231) + CHR(245) + "es: " + ;

*-- Linhas 1929 a 2261:
1929:     * TreeViewGotFocus - equivalente ao GotFocus do TreeView legado: sem
1930:     * Empresa preenchida, nao deixa o foco parado na arvore.
1931:     *==========================================================================
1932:     PROCEDURE TreeViewGotFocus
1933:         IF EMPTY(THIS.txt_4c_CEmp.Value)
1934:             KEYBOARD "{TAB}"
1935:         ENDIF
1936:     ENDPROC
1937: 
1938:     *==========================================================================
1939:     * TreeViewKeyPress - equivalente ao KeyPress do TreeView legado (ActiveX,
1940:     * assinatura LPARAMETERS keyascii - so 1 parametro, diferente do KeyPress
1941:     * nativo de TextBox).
1942:     *==========================================================================
1943:     PROCEDURE TreeViewKeyPress
1944:         LPARAMETERS par_nKeyAscii
1945: 
1946:         IF par_nKeyAscii = 27
1947:             RELEASE WINDOWS
1948:         ENDIF
1949:     ENDPROC
1950: 
1951:     *==========================================================================
1952:     * TreeViewNodeClick - equivalente ao NodeClick do TreeView legado
1953:     * (LPARAMETERS nindex, ncolumn -> ThisForm.plDblClick = nIndex). Guarda o
1954:     * indice do no marcado para os botoes de navegacao (Proximo/Movimento/
1955:     * Producao) lerem via ObterCargoAtual.
1956:     *==========================================================================
1957:     PROCEDURE TreeViewNodeClick
1958:         LPARAMETERS par_nIndex, par_nColumn
1959: 
1960:         THIS.this_nIndiceClicado = par_nIndex
1961:     ENDPROC
1962: 
1963:     *==========================================================================
1964:     * BtnExpandirClick - equivalente a Command1.Click: expande todos os nos
1965:     * do proximo nivel de profundidade.
1966:     *==========================================================================
1967:     PROCEDURE BtnExpandirClick
1968:         LOCAL loc_nNo, loc_lExpandiu, loc_oErro
1969: 
1970:         IF !THIS.ArvoreDisponivel()
1971:             RETURN
1972:         ENDIF
1973: 
1974:         loc_lExpandiu = .F.
1975: 
1976:         TRY
1977:             WITH THIS.obj_4c_TreeView
1978:                 FOR loc_nNo = 0 TO .ListCount - 1
1979:                     IF THIS.this_nNodeExp + 1 = .NodeLevel(loc_nNo)
1980:                         .NodeExpanded(loc_nNo) = .T.
1981:                         loc_lExpandiu = .T.
1982:                     ENDIF
1983:                 ENDFOR
1984:             ENDWITH
1985: 
1986:             IF loc_lExpandiu
1987:                 THIS.this_nNodeExp = THIS.this_nNodeExp + 1
1988:             ENDIF
1989:         CATCH TO loc_oErro
1990:             MsgErro("Falha ao expandir a " + CHR(225) + "rvore: " + loc_oErro.Message, "Erro")
1991:         ENDTRY
1992:     ENDPROC
1993: 
1994:     *==========================================================================
1995:     * BtnRetrairClick - equivalente a Command2.Click: recolhe o nivel de
1996:     * profundidade corrente.
1997:     *==========================================================================
1998:     PROCEDURE BtnRetrairClick
1999:         LOCAL loc_nNo, loc_oErro
2000: 
2001:         IF !THIS.ArvoreDisponivel()
2002:             RETURN
2003:         ENDIF
2004: 
2005:         TRY
2006:             IF THIS.this_nNodeExp > 0
2007:                 WITH THIS.obj_4c_TreeView
2008:                     FOR loc_nNo = 0 TO .ListCount - 1
2009:                         IF THIS.this_nNodeExp = .NodeLevel(loc_nNo)
2010:                             .NodeExpanded(loc_nNo) = .F.
2011:                         ENDIF
2012:                     ENDFOR
2013:                 ENDWITH
2014:                 THIS.this_nNodeExp = THIS.this_nNodeExp - 1
2015:             ELSE
2016:                 THIS.this_nNodeExp = 0
2017:             ENDIF
2018:         CATCH TO loc_oErro
2019:             MsgErro("Falha ao retrair a " + CHR(225) + "rvore: " + loc_oErro.Message, "Erro")
2020:         ENDTRY
2021:     ENDPROC
2022: 
2023:     *==========================================================================
2024:     * BtnEncerrarClick - equivalente a Command3.Click ("[ESC] Sair").
2025:     *==========================================================================
2026:     PROCEDURE BtnEncerrarClick
2027:         THIS.Release()
2028:     ENDPROC
2029: 
2030:     *==========================================================================
2031:     * BtnAnteriorClick - equivalente a Command4.Click: desempilha
2032:     * this_aEmpDopNums (paEmpDopNums) e volta a exibir a posicao anterior -
2033:     * lista por periodo (this_lRetorno = .F. e pilha vazia) ou arvore de
2034:     * detalhe (senao).
2035:     *==========================================================================
2036:     PROCEDURE BtnAnteriorClick
2037:         LOCAL loc_nUltimo, loc_cChave
2038: 
2039:         loc_nUltimo = ALEN(THIS.this_aEmpDopNums, 1)
2040: 
2041:         IF EMPTY(THIS.this_aEmpDopNums[loc_nUltimo])
2042:             RETURN
2043:         ENDIF
2044: 
2045:         loc_cChave = THIS.this_aEmpDopNums[loc_nUltimo]
2046: 
2047:         *-- Left(.,3) / Substr(.,4,20) / Substr(.,24) do Command4 legado,
2048:         *-- concentrados em DefinirFiltroPorChave (que grava no BO e reflete
2049:         *-- na tela por BOParaForm, mantendo os dois lados coerentes).
2050:         THIS.DefinirFiltroPorChave(loc_cChave)
2051: 
2052:         IF loc_nUltimo = 1
2053:             THIS.this_aEmpDopNums[1] = ""
2054:         ELSE
2055:             DIMENSION THIS.this_aEmpDopNums[loc_nUltimo - 1]
2056:         ENDIF
2057: 
2058:         IF EMPTY(THIS.this_aEmpDopNums[1]) AND !THIS.this_lRetorno
2059:             THIS.txt_4c_Numes.Value = 0
2060:             THIS.CarregarListaPeriodo()
2061:         ELSE
2062:             THIS.CarregarDados()
2063:         ENDIF
2064:     ENDPROC
2065: 
2066:     *==========================================================================
2067:     * BtnImprimirClick - equivalente a Command5.Click ("DO FORM SigReMre WITH
2068:     * ThisForm"). SigReMre eh outro form do legado (relatorio de movimento),
2069:     * fora do escopo desta migracao - tenta instanciar o modulo migrado
2070:     * (FormSIGREMRE) e avisa se ainda nao existir, em vez de estourar "Class
2071:     * definition ... is not found".
2072:     *==========================================================================
2073:     PROCEDURE BtnImprimirClick
2074:         LOCAL loc_oForm, loc_oErro
2075: 
2076:         THIS.Enabled = .F.
2077: 
2078:         TRY
2079:             loc_oForm = CREATEOBJECT("FormSIGREMRE", THIS)
2080:         CATCH TO loc_oErro
2081:             loc_oForm = .NULL.
2082:         ENDTRY
2083: 
2084:         IF VARTYPE(loc_oForm) = "O"
2085:             loc_oForm.Show()
2086:         ELSE
2087:             THIS.Enabled = .T.
2088:             MsgAviso("M" + CHR(243) + "dulo de impress" + CHR(227) + "o (SigReMre) " + ;
2089:                 "ainda n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
2090:                 "vel nesta vers" + CHR(227) + "o.", "Aviso")
2091:         ENDIF
2092:     ENDPROC
2093: 
2094:     *==========================================================================
2095:     * BtnProximoClick - equivalente a Command6.Click: empilha a posicao atual
2096:     * e avanca para o no marcado (drill-down manual pela arvore).
2097:     *==========================================================================
2098:     PROCEDURE BtnProximoClick
2099:         LOCAL loc_cCargo
2100: 
2101:         loc_cCargo = THIS.ObterCargoAtual()
2102: 
2103:         IF loc_cCargo == "PRODUTO"
2104:             MsgAviso("Produto", "Aten" + CHR(231) + CHR(227) + "o")
2105:             RETURN
2106:         ENDIF
2107: 
2108:         IF EMPTY(loc_cCargo)
2109:             RETURN
2110:         ENDIF
2111: 
2112:         IF !EMPTY(THIS.this_aEmpDopNums[1])
2113:             DIMENSION THIS.this_aEmpDopNums[ALEN(THIS.this_aEmpDopNums, 1) + 1]
2114:         ENDIF
2115:         THIS.this_aEmpDopNums[ALEN(THIS.this_aEmpDopNums, 1)] = THIS.MontarChaveAtual()
2116: 
2117:         *-- Mesma decomposicao do Command6 legado, via DefinirFiltroPorChave.
2118:         THIS.DefinirFiltroPorChave(loc_cCargo)
2119: 
2120:         THIS.CarregarDados()
2121:         THIS.this_nIndiceClicado = 0
2122:     ENDPROC
2123: 
2124:     *==========================================================================
2125:     * BtnOperacaoClick - equivalente a btnOperacao.Click ("Movimento"): abre o
2126:     * detalhe do movimento do no marcado na arvore.
2127:     *==========================================================================
2128:     PROCEDURE BtnOperacaoClick
2129:         LOCAL loc_cCargo, loc_cEmps, loc_cDopes, loc_nNumes
2130: 
2131:         loc_cCargo = THIS.ObterCargoAtual()
2132: 
2133:         IF loc_cCargo == "PRODUTO"
2134:             MsgAviso("Produto", "Aten" + CHR(231) + CHR(227) + "o")
2135:             RETURN
2136:         ENDIF
2137: 
2138:         IF EMPTY(loc_cCargo)
2139:             RETURN
2140:         ENDIF
2141: 
2142:         loc_cEmps  = LEFT(loc_cCargo, 3)
2143:         loc_cDopes = SUBSTR(loc_cCargo, 4, 20)
2144:         loc_nNumes = VAL(ALLTRIM(SUBSTR(loc_cCargo, 24)))
2145: 
2146:         IF !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND loc_nNumes != 0
2147:             THIS.AbrirFormMovimento(loc_cDopes, loc_nNumes, loc_cEmps)
2148:         ENDIF
2149:     ENDPROC
2150: 
2151:     *==========================================================================
2152:     * AbrirFormMovimento - "Do Form SigMvExp with lcDopes, 'C', lnNumes,
2153:     * lcEmps, .t." do legado. SigMvExp.SCX esta fora do escopo desta
2154:     * migracao (task574 eh so o SIGMVMVT) - tenta o modulo migrado
2155:     * (FormSIGMVEXP, mesma convencao <SCX> -> Form<SCX> usada neste form) e
2156:     * avisa se ainda nao existir.
2157:     *==========================================================================
2158:     PROTECTED PROCEDURE AbrirFormMovimento(par_cDopes, par_nNumes, par_cEmps)
2159:         LOCAL loc_oForm, loc_oErro
2160: 
2161:         TRY
2162:             loc_oForm = CREATEOBJECT("FormSIGMVEXP", par_cDopes, "C", par_nNumes, par_cEmps, .T.)
2163:         CATCH TO loc_oErro
2164:             loc_oForm = .NULL.
2165:         ENDTRY
2166: 
2167:         IF VARTYPE(loc_oForm) = "O"
2168:             loc_oForm.Show()
2169:         ELSE
2170:             MsgAviso("M" + CHR(243) + "dulo de detalhe do movimento (SigMvExp) " + ;
2171:                 "ainda n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
2172:                 "vel nesta vers" + CHR(227) + "o.", "Aviso")
2173:         ENDIF
2174:     ENDPROC
2175: 
2176:     *==========================================================================
2177:     * BtnOficinaClick - equivalente a BtnOficina.Click ("Producao" - Visible
2178:     * so quando this_lAcOficina, ver AtualizarAcessoOficina/DopesKeyPress).
2179:     *==========================================================================
2180:     PROCEDURE BtnOficinaClick
2181:         LOCAL loc_cCargo, loc_cEmps, loc_cDopes, loc_nNumes
2182: 
2183:         loc_cCargo = THIS.ObterCargoAtual()
2184: 
2185:         IF loc_cCargo == "PRODUTO"
2186:             MsgAviso("Produto", "Aten" + CHR(231) + CHR(227) + "o")
2187:             RETURN
2188:         ENDIF
2189: 
2190:         IF EMPTY(loc_cCargo)
2191:             RETURN
2192:         ENDIF
2193: 
2194:         loc_cEmps  = LEFT(loc_cCargo, 3)
2195:         loc_cDopes = SUBSTR(loc_cCargo, 4, 20)
2196:         loc_nNumes = VAL(ALLTRIM(SUBSTR(loc_cCargo, 24)))
2197: 
2198:         IF !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND loc_nNumes != 0
2199:             THIS.AbrirFormOficina(loc_cDopes, loc_nNumes)
2200:         ENDIF
2201:     ENDPROC
2202: 
2203:     *==========================================================================
2204:     * AbrirFormOficina - "laParam(1)=2, laParam(2)=lcDopes, laParam(3)=
2205:     * lnNumes / Do Form SigRePPd With .F.,'SigRePPd',laParam" do legado.
2206:     * SigRePPd esta fora do escopo desta migracao - tenta o modulo migrado
2207:     * (FormSIGREPPD) e avisa se ainda nao existir.
2208:     *==========================================================================
2209:     PROTECTED PROCEDURE AbrirFormOficina(par_cDopes, par_nNumes)
2210:         LOCAL loc_oForm, loc_oErro
2211: 
2212:         TRY
2213:             loc_oForm = CREATEOBJECT("FormSIGREPPD", 2, par_cDopes, par_nNumes)
2214:         CATCH TO loc_oErro
2215:             loc_oForm = .NULL.
2216:         ENDTRY
2217: 
2218:         IF VARTYPE(loc_oForm) = "O"
2219:             loc_oForm.Show()
2220:         ELSE
2221:             MsgAviso("M" + CHR(243) + "dulo de produ" + CHR(231) + CHR(227) + "o (SigRePPd) " + ;
2222:                 "ainda n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
2223:                 "vel nesta vers" + CHR(227) + "o.", "Aviso")
2224:         ENDIF
2225:     ENDPROC
2226: 
2227:     *==========================================================================
2228:     * ADAPTADORES DE NOME CRUD (Fase 8) -------------------------------------
2229:     *
2230:     * O pipeline cobra de TODO form os nomes canonicos FormParaBO/BOParaForm/
2231:     * CarregarLista/BtnCancelarClick + um handler de acao. Este form eh uma
2232:     * CONSULTA em arvore (ver nota no cabecalho): nao tem Page2 de Dados, nem
2233:     * grade de listagem, nem gravacao - o legado nao tem UM SO Insert/Update/
2234:     * Delete/TableUpdate (conferido no dump: zero ocorrencias). Os nomes
2235:     * entram portanto como ADAPTADORES, cada um mapeado para o equivalente
2236:     * REAL nesta tela - nenhum corpo vazio, nenhum botao inventado:
2237:     *
2238:     *   FormParaBO        -> leva o filtro da tela (Empresa/Operacao/Numero/
2239:     *                        Periodo) para as properties do BO, montando a
2240:     *                        chave EmpDopNums; fonte UNICA dessa transferencia
2241:     *   BOParaForm        -> traz o filtro do BO de volta para os 5 campos
2242:     *                        (usado pela navegacao Anterior/Proximo)
2243:     *   CarregarLista     -> "recarrega a superficie consultavel": despacha
2244:     *                        para CarregarDados (arvore de uma operacao,
2245:     *                        MakeTree do legado) ou CarregarListaPeriodo
2246:     *                        (lista por periodo, MakeList do legado)
2247:     *   BtnExecutarClick  -> a acao desta tela: aplicar o filtro e consultar.
2248:     *                        No legado ela nao mora num botao proprio - sai do
2249:     *                        Valid de GetNumes (MakeTree) e de GetDtF
2250:     *                        (MakeList); o handler expoe essa acao com o nome
2251:     *                        do pipeline SEM criar botao que o SCX nao tem
2252:     *   BtnBuscarClick    -> mesmo sentido de "Buscar": delega para o acima
2253:     *   BtnCancelarClick  -> "descartar o que foi digitado": limpa o filtro e
2254:     *                        a arvore, devolvendo o foco ao 1o campo
2255:     *
2256:     * NAO existe BtnSalvarClick: o legado eh somente-leitura, e o proprio
2257:     * SIGMVMVTBO sobrescreve Inserir/Atualizar/ExecutarExclusao para
2258:     * documentar essa regra. Criar um handler de gravar aqui inventaria
2259:     * funcionalidade (violaria o PILAR 1) ou seria stub vazio (proibido pela
2260:     * regra de completude).
2261:     *

*-- Linhas 2364 a 2578:
2364:     * repete em Command4/Command6 (Left(.,3) / Substr(.,4,20) / Substr(.,24))
2365:     * e reflete na tela por BOParaForm, mantendo BO e campos coerentes.
2366:     *==========================================================================
2367:     PROTECTED PROCEDURE DefinirFiltroPorChave(par_cChave)
2368:         LOCAL loc_cChave
2369: 
2370:         loc_cChave = PADR(TratarNulo(par_cChave, ""), 29)
2371: 
2372:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2373:             WITH THIS.this_oBusinessObject
2374:                 .this_cEmps  = ALLTRIM(LEFT(loc_cChave, 3))
2375:                 .this_cDopes = ALLTRIM(SUBSTR(loc_cChave, 4, 20))
2376:                 .this_nNumes = VAL(ALLTRIM(SUBSTR(loc_cChave, 24)))
2377:                 .this_cEmpDopNums = PADR(.this_cEmps, 3) + PADR(.this_cDopes, 20) + ;
2378:                     STR(.this_nNumes, 6)
2379:             ENDWITH
2380: 
2381:             THIS.BOParaForm()
2382:         ENDIF
2383:     ENDPROC
2384: 
2385:     *==========================================================================
2386:     * CarregarLista - Recarrega a superficie consultavel desta tela (a arvore,
2387:     * que eh o "grid" do SIGMVMVT). Despacha para o mesmo par de metodos que o
2388:     * legado dispara do Valid dos campos:
2389:     *   Empresa + Operacao + Numero  -> CarregarDados()        (MakeTree)
2390:     *   Empresa + Operacao + Periodo -> CarregarListaPeriodo() (MakeList)
2391:     * Sem filtro suficiente NAO avisa nada e apenas limpa a arvore: este
2392:     * metodo tambem eh chamado pelo harness com a tela em branco, e um
2393:     * MsgAviso ali travaria o teste (os dois metodos de carga ja avisam
2394:     * quando o usuario aciona a consulta de verdade).
2395:     *==========================================================================
2396:     PROCEDURE CarregarLista()
2397:         LOCAL loc_lSucesso, loc_cEmps, loc_cDopes, loc_nNumes, loc_dDtI, loc_dDtF
2398: 
2399:         loc_lSucesso = .F.
2400: 
2401:         IF THIS.FormParaBO()
2402:             WITH THIS.this_oBusinessObject
2403:                 loc_cEmps  = ALLTRIM(.this_cEmps)
2404:                 loc_cDopes = ALLTRIM(.this_cDopes)
2405:                 loc_nNumes = .this_nNumes
2406:                 loc_dDtI   = .this_dDtI
2407:                 loc_dDtF   = .this_dDtF
2408:             ENDWITH
2409: 
2410:             DO CASE
2411:             CASE !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND loc_nNumes != 0
2412:                 loc_lSucesso = THIS.CarregarDados()
2413: 
2414:             CASE !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND ;
2415:                  !EMPTY(loc_dDtI)  AND !EMPTY(loc_dDtF)
2416:                 loc_lSucesso = THIS.CarregarListaPeriodo()
2417: 
2418:             OTHERWISE
2419:                 THIS.PrepararArvore()
2420:                 loc_lSucesso = .T.
2421:             ENDCASE
2422:         ENDIF
2423: 
2424:         RETURN loc_lSucesso
2425:     ENDPROC
2426: 
2427:     *==========================================================================
2428:     * HabilitarCampos - Liga/desliga os 5 campos do filtro. Nunca reabilita
2429:     * quando this_lAutomatico: a tela aberta por drill direto (Empresa +
2430:     * Operacao + Numero vindos do chamador) tem o filtro TRAVADO no legado
2431:     * (ver AplicarParametrosAbertura), e reabilitar aqui deixaria o usuario
2432:     * alterar a chave que abriu a tela.
2433:     *==========================================================================
2434:     PROCEDURE HabilitarCampos(par_lHabilitar)
2435:         LOCAL loc_lHabilitar
2436: 
2437:         loc_lHabilitar = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.) ;
2438:             AND !THIS.this_lAutomatico
2439: 
2440:         THIS.txt_4c_CEmp.Enabled  = loc_lHabilitar
2441:         THIS.txt_4c_Dopes.Enabled = loc_lHabilitar
2442:         THIS.txt_4c_Numes.Enabled = loc_lHabilitar
2443:         THIS.txt_4c_DtI.Enabled   = loc_lHabilitar
2444:         THIS.txt_4c_DtF.Enabled   = loc_lHabilitar
2445:     ENDPROC
2446: 
2447:     *==========================================================================
2448:     * LimparCampos - Zera o filtro, o estado de navegacao e a arvore. Eh o
2449:     * "recomecar a consulta" desta tela: reune o que o legado faz em
2450:     * GetcEmp.GotFocus (ClearNodes + limpa Operacao/Numero) e em
2451:     * GetNumes.GotFocus (zera o periodo), mais a pilha de navegacao.
2452:     * Respeita o drill direto (Automatico): ali o filtro nao se apaga.
2453:     *
2454:     * PROTECTED igual ao FormBase (formbase.prg:276) - a protecao eh HERDADA,
2455:     * declarar sem PROTECTED aqui nao afrouxaria nada (MEDIDO no VFP9 em
2456:     * 2026-09-25: chamada externa estoura "Property LIMPARCAMPOS is not
2457:     * found"). Quem limpa de fora eh BtnCancelarClick, que eh PUBLIC.
2458:     *==========================================================================
2459:     PROTECTED PROCEDURE LimparCampos()
2460:         IF !THIS.this_lAutomatico
2461:             THIS.txt_4c_CEmp.Value  = ""
2462:             THIS.txt_4c_Dopes.Value = ""
2463:             THIS.txt_4c_Numes.Value = 0
2464:             THIS.txt_4c_DtI.Value   = {}
2465:             THIS.txt_4c_DtF.Value   = {}
2466:         ENDIF
2467: 
2468:         *-- Estado de navegacao da arvore (mesmo bloco do InicializarForm)
2469:         DIMENSION THIS.this_aEmpDopNums[1]
2470:         THIS.this_aEmpDopNums[1] = ""
2471: 
2472:         DIMENSION THIS.this_aHistorico[1, 2]
2473:         THIS.this_aHistorico[1, 1] = ""
2474:         THIS.this_aHistorico[1, 2] = ""
2475: 
2476:         THIS.this_nNiveis        = 0
2477:         THIS.this_nNodeExp       = 0
2478:         THIS.this_nIndiceClicado = 0
2479:         THIS.this_lRetorno       = .F.
2480: 
2481:         THIS.PrepararArvore()
2482:     ENDPROC
2483: 
2484:     *==========================================================================
2485:     * AjustarBotoesPorModo - Reaplica o que o legado controla por ESTADO.
2486:     * O legado NAO habilita/desabilita os 6 botoes do Commandgroup1: Command4
2487:     * (Anterior) e Command6 (Proximo) checam a pilha/o no selecionado DENTRO
2488:     * do proprio Click (ver BtnAnteriorClick/BtnProximoClick), e inventar
2489:     * Enabled aqui mudaria a UX do legado (PILAR 1). O que ele de fato
2490:     * controla por estado sao duas coisas:
2491:     *   ThisForm.BtnOficina.Visible = ThisForm.lAcOficina  (fim de GetDopes.Valid)
2492:     *   os 5 campos do filtro travados quando Automatico = .T.  (Init)
2493:     *==========================================================================
2494:     PROCEDURE AjustarBotoesPorModo()
2495:         THIS.cmd_4c_BtnOficina.Visible = THIS.this_lAcOficina
2496:         THIS.HabilitarCampos(!THIS.this_lAutomatico)
2497:     ENDPROC
2498: 
2499:     *==========================================================================
2500:     * BtnExecutarClick - A acao desta tela: aplicar o filtro e consultar.
2501:     * No legado ela nao tem botao proprio - nasce do Valid de GetNumes
2502:     * (MakeTree) e do Valid de GetDtF (MakeList), ja portados em
2503:     * NumesKeyPress/DtFKeyPress. Aqui a mesma acao ganha o nome que o
2504:     * pipeline cobra, SEM criar botao que o SCX nao tem (o SCX declara
2505:     * exatamente 8 botoes: os 6 do Commandgroup1 + Movimento + Producao).
2506:     *==========================================================================
2507:     PROCEDURE BtnExecutarClick()
2508:         RETURN THIS.CarregarLista()
2509:     ENDPROC
2510: 
2511:     *==========================================================================
2512:     * BtnBuscarClick - "Buscar" nesta tela eh executar a consulta do filtro;
2513:     * delega para BtnExecutarClick para nao haver duas implementacoes da
2514:     * mesma acao divergindo com o tempo.
2515:     *==========================================================================
2516:     PROCEDURE BtnBuscarClick()
2517:         RETURN THIS.BtnExecutarClick()
2518:     ENDPROC
2519: 
2520:     *==========================================================================
2521:     * BtnCancelarClick - "Descartar o que foi digitado": limpa o filtro e a
2522:     * arvore e devolve o foco ao 1o campo. NAO fecha a tela - fechar eh o
2523:     * Encerrar (Command3, Cancel = .T., ver BtnEncerrarClick); e o harness
2524:     * aciona BtnCancelarClick, que fechando derrubaria as verificacoes
2525:     * seguintes.
2526:     *==========================================================================
2527:     PROCEDURE BtnCancelarClick()
2528:         THIS.LimparCampos()
2529: 
2530:         *-- SetFocus SEM TRY/CATCH, de proposito. MEDIDO no VFP9 em 2026-09-25
2531:         *-- (test_setfocus_nao_mostrado.prg): TextBox.SetFocus() NAO estoura em
2532:         *-- nenhum dos casos temidos - form nunca mostrado (harness headless),
2533:         *-- controle Enabled = .F. (drill direto) ou Visible = .F.; nos tres
2534:         *-- vira no-op. Um TRY aqui so poderia esconder erro de verdade com
2535:         *-- CATCH silencioso (proibido - CLAUDE.md #9), ja que MsgErro a cada
2536:         *-- Cancelar seria ruido. O guard abaixo fica pelo SENTIDO (nao levar o
2537:         *-- foco a campo travado), nao por medo de excecao.
2538:         IF THIS.txt_4c_CEmp.Enabled AND THIS.txt_4c_CEmp.Visible
2539:             THIS.txt_4c_CEmp.SetFocus()
2540:         ENDIF
2541:     ENDPROC
2542: 
2543:     *==========================================================================
2544:     * TornarControlesVisiveis - Torna os controles filhos visiveis apos o
2545:     * AddObject (que os cria com Visible=.F. por padrao), preservando
2546:     * BtnOficina.Visible=.F. (fiel ao legado - regra "skip com LOOP" nao
2547:     * recursa em containers, aqui nao ha container a recursar).
2548:     *==========================================================================
2549:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2550:         LOCAL loc_nI, loc_oObjeto
2551: 
2552:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2553:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2554: 
2555:             IF VARTYPE(loc_oObjeto) = "O"
2556:                 IF UPPER(loc_oObjeto.Name) = "CMD_4C_BTNOFICINA"
2557:                     LOOP
2558:                 ENDIF
2559: 
2560:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2561:                     loc_oObjeto.Visible = .T.
2562:                 ENDIF
2563: 
2564:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2565:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2566:                 ENDIF
2567:             ENDIF
2568:         ENDFOR
2569:     ENDPROC
2570: 
2571:     *==========================================================================
2572:     * Destroy
2573:     *==========================================================================
2574:     PROCEDURE Destroy
2575:         DODEFAULT()
2576:     ENDPROC
2577: 
2578: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGMVMVTBO.prg):
*==============================================================================
* SIGMVMVTBO.PRG
* Business Object - Acompanhamento Operacional (SIGMVMVT)
* Consulta hierarquica (TreeView) de movimentos por Empresa/Operacao/Numero,
* percorrendo SigMvCab / SigMvItn / SigMvPec / SigOpDev / SigCdOpe.
* Heranca: BusinessBase
*
* NOTA IMPORTANTE (paridade com o legado): o SIGMVMVT eh um formulario de
* CONSULTA (drill-down em arvore) - o codigo fonte original (Init, MakeTree,
* MakeList, HiNivel, SubNivel, NoHiPro, NoProd) faz SOMENTE SELECT nas tabelas
* de movimento. Nao existe, em lugar nenhum do legado, INSERT/UPDATE/DELETE em
* SigMvCab/SigMvItn/SigMvPec/SigOpDev disparado por este formulario - por isso
* Inserir()/Atualizar()/ExecutarExclusao() ficam sobrescritos abaixo apenas
* para documentar essa regra de negocio (BO somente-leitura), e os metodos
* reais adicionados nesta fase sao os de CONSULTA hierarquica que o Form
* (Fase 3) vai usar para montar a arvore.
*==============================================================================

DEFINE CLASS SIGMVMVTBO AS BusinessBase

    *-- Filtro de selecao da operacao (espelha GetcEmp/GetDopes/GetNumes do legado)
    this_cEmps  = ""     && SigMvCab.emps  char(3)  - empresa
    this_cDopes = ""     && SigMvCab.dopes char(20) - codigo da operacao (FK SigCdOpe.Dopes)
    this_nNumes = 0      && SigMvCab.numes numeric(6,0) - numero da operacao

    *-- Filtro de periodo (usado em MakeList - GetDtI/GetDtF do legado)
    this_dDtI = {}       && Data inicial do periodo
    this_dDtF = {}       && Data final do periodo

    *-- Chave composta usada em todas as consultas hierarquicas (WHERE EmpDopNums = ...)
    * Formato: PADR(Emps,3) + PADR(Dopes,20) + STR(Numes,6)
    this_cEmpDopNums = ""

    *-- Dados do registro-raiz carregado (SigMvCab), preenchidos por CarregarDoCursor
    this_cCidChaves = ""    && SigMvCab.cidchaves char(20) - PK
    this_cNotas     = ""    && SigMvCab.notas     char(6)
    this_dDatas     = {}    && SigMvCab.datas     datetime
    this_dDatars    = {}    && SigMvCab.datars    datetime
    this_lChkPagos  = .F.   && SigMvCab.chkpagos  bit
    this_cUsuars    = ""    && SigMvCab.usuars    char(10)
    this_dDtAlts    = {}    && SigMvCab.dtalts    datetime
    this_cUsuals    = ""    && SigMvCab.usuals    char(10)

    *-- Flags de controle (espelham propriedades do form legado)
    this_lAcOficina  = .F.   && ThisForm.lacoficina - acesso a producao/oficina (fChecaAcesso)
    this_lAutomatico = .F.   && ThisForm.Automatico - form aberto ja com Emps/Dopes/Numes definidos
    this_nNiveis     = 0     && ThisForm.pnNiveis - contador de profundidade da recursao da arvore

    *-- Mensagem tecnica devolvida por SQLEXEC quando a conexao/consulta falha
    this_cMensagemSQL = ""

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigMvCab")

        THIS.this_cCampoChave = "EmpDopNums"

        THIS.this_cEmps  = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0

        THIS.this_dDtI = {}
        THIS.this_dDtF = {}

        THIS.this_cEmpDopNums = ""

        THIS.this_cCidChaves = ""
        THIS.this_cNotas     = ""
        THIS.this_dDatas     = {}
        THIS.this_dDatars    = {}
        THIS.this_lChkPagos  = .F.
        THIS.this_cUsuars    = ""
        THIS.this_dDtAlts    = {}
        THIS.this_cUsuals    = ""

        THIS.this_lAcOficina  = .F.
        THIS.this_lAutomatico = .F.
        THIS.this_nNiveis     = 0

        THIS.this_cMensagemSQL = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor (registro de SigMvCab) para
    * as propriedades this_. Segue o padrao canonico: SELECT (alias) antes de
    * acessar os campos diretamente (nunca campo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCidChaves  = ALLTRIM(TratarNulo(cidchaves, ""))
        THIS.this_cEmps       = ALLTRIM(TratarNulo(emps, ""))
        THIS.this_cDopes      = ALLTRIM(TratarNulo(dopes, ""))
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_cEmpDopNums = ALLTRIM(TratarNulo(empdopnums, ""))
        THIS.this_cNotas      = ALLTRIM(TratarNulo(notas, ""))
        THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
        THIS.this_dDatars     = ConverterParaData(TratarNulo(datars, {}))
        THIS.this_lChkPagos   = TratarNulo(chkpagos, .F.)
        THIS.this_cUsuars     = ALLTRIM(TratarNulo(usuars, ""))
        THIS.this_dDtAlts     = ConverterParaData(TratarNulo(dtalts, {}))
        THIS.this_cUsuals     = ALLTRIM(TratarNulo(usuals, ""))

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave de negocio usada nesta tela (EmpDopNums),
    * consistente com o que o legado usa em TODAS as consultas hierarquicas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - o Acompanhamento Operacional eh
    * consulta pura (drill-down); o legado nunca grava nem exclui a partir
    * desta tela. Mantidos sobrescritos apenas para deixar a regra explicita -
    * nenhum botao do form (Fase 3) chama Salvar()/Excluir() deste BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Acompanhamento Operacional " + CHR(233) + ;
            " tela de consulta - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Acompanhamento Operacional " + CHR(233) + ;
            " tela de consulta - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Acompanhamento Operacional " + CHR(233) + ;
            " tela de consulta - n" + CHR(227) + "o exclui registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - equivalente ao lookup de GetcEmp.Valid (fwBuscaExt) e ao
    * "Select * From SigCdEmp Where cEmps = ?" do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lAchou

        loc_lAchou = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_cMensagemSQL  = ""

        IF EMPTY(ALLTRIM(TratarNulo(par_cEmps, "")))
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_Emp")
            USE IN cursor_4c_Emp
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cEmps))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")

        IF loc_nResultado > 0 AND !EOF("cursor_4c_Emp")
            loc_lAchou = .T.
            THIS.this_cEmps = ALLTRIM(cursor_4c_Emp.Cemps)
        ELSE
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada."
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacao - equivalente ao lookup de GetDopes.Valid (fwBuscaExt).
    * O acesso a producao/oficina (fChecaAcesso) permanece responsabilidade do
    * Form, que grava o resultado em THIS.this_lAcOficina apos chamar este
    * metodo (mesma divisao do legado, onde a checagem fica no proprio Valid).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lAchou

        loc_lAchou = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_cMensagemSQL  = ""

        IF EMPTY(ALLTRIM(TratarNulo(par_cDopes, "")))
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF

        loc_cSQL = "SELECT Dopes, nDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")

        IF loc_nResultado > 0 AND !EOF("cursor_4c_Ope")
            loc_lAchou = .T.
            THIS.this_cDopes = ALLTRIM(cursor_4c_Ope.Dopes)
        ELSE
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada."
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCodigoOperacao - Select nDopes From SigCdOpe Where Dopes = ?
    * Retorna -1 quando nao encontra (o codigo nDopes real eh sempre >= 0).
    *--------------------------------------------------------------------------
    PROCEDURE ObterCodigoOperacao(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_nCodigo

        loc_nCodigo = -1

        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF

        loc_cSQL = "SELECT nDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")

        IF loc_nResultado > 0 AND !EOF("cursor_4c_Ope")
            loc_nCodigo = cursor_4c_Ope.nDopes
        ELSE
            THIS.this_cMensagemSQL = CapturarErroSQL()
        ENDIF

        RETURN loc_nCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDopesPorCodigo - Select Dopes From SigCdOpe Where nDopes = ?
    * (caminho inverso de ObterCodigoOperacao, usado por NoProd)
    *--------------------------------------------------------------------------
    PROCEDURE ObterDopesPorCodigo(par_nCodigoOperacao)
        LOCAL loc_cSQL, loc_nResultado, loc_cDopes

        loc_cDopes = ""

        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF

        loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE nDopes = " + FormatarNumeroSQL(par_nCodigoOperacao, 0)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")

        IF loc_nResultado > 0 AND !EOF("cursor_4c_Ope")
            loc_cDopes = ALLTRIM(cursor_4c_Ope.Dopes)
        ELSE
            THIS.this_cMensagemSQL = CapturarErroSQL()
        ENDIF

        RETURN loc_cDopes
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - equivalente ao Init (AddCursor crSigMvCab) + trecho
    * inicial do MakeTree (Requery + Go Top + Eof = "Operacao Nao Localizada").
    * Monta this_cEmpDopNums a partir de Emps/Dopes/Numes e busca o registro.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacao(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_cMensagemSQL  = ""

        THIS.this_cEmps  = ALLTRIM(TratarNulo(par_cEmps, ""))
        THIS.this_cDopes = ALLTRIM(TratarNulo(par_cDopes, ""))
        THIS.this_nNumes = TratarNulo(par_nNumes, 0)

        THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

        IF USED("cursor_4c_Cab")
            USE IN cursor_4c_Cab
        ENDIF

        loc_cSQL = "SELECT * FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cab")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Localizada !!"
        ELSE
            SELECT cursor_4c_Cab
            GO TOP
            IF EOF("cursor_4c_Cab")
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Localizada !!"
            ELSE
                THIS.CarregarDoCursor("cursor_4c_Cab")
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - equivalente a lcQryEesti do Init / trecho de MakeTree que
    * percorre crSigMvItn (nivel 2 da arvore: produto/quantidade).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_cChave

        loc_cChave = ALLTRIM(TratarNulo(par_cEmpDopNums, THIS.this_cEmpDopNums))
        THIS.this_cMensagemSQL = ""

        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF

        loc_cSQL = "SELECT EmpDopNums, cPros, dPros, SUM(Qtds) AS Qtds " + ;
            "FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cChave) + " " + ;
            "GROUP BY EmpDopNums, cPros, dPros " + ;
            "ORDER BY EmpDopNums, cPros, dPros"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Erro ao carregar itens da opera" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorPeriodo - equivalente a MakeList: lista as operacoes de uma
    * Empresa+Operacao dentro do periodo informado (nivel 1 da arvore, quando
    * o form nao abre ja "Automatico" com Emps/Dopes/Numes definidos).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorPeriodo(par_cEmps, par_cDopes, par_dDtIni, par_dDtFim)
        LOCAL loc_cSQL, loc_nResultado, loc_cDtIniSQL, loc_cDtFimSQL

        THIS.this_cEmps  = ALLTRIM(TratarNulo(par_cEmps, ""))
        THIS.this_cDopes = ALLTRIM(TratarNulo(par_cDopes, ""))
        THIS.this_dDtI   = ConverterParaData(par_dDtIni)
        THIS.this_dDtF   = ConverterParaData(par_dDtFim)
        THIS.this_cMensagemSQL = ""

        loc_cDtIniSQL = FormatarDataSQL(THIS.this_dDtI)

        * Fim do periodo com hora 23:59:59 (fDtoSQL(..., '23:59:59') do legado)
        loc_cDtFimSQL = FormatarDataSQL(THIS.this_dDtF)
        IF loc_cDtFimSQL != "NULL"
            loc_cDtFimSQL = LEFT(loc_cDtFimSQL, LEN(loc_cDtFimSQL) - 1) + " 23:59:59'"
        ENDIF

        IF USED("cursor_4c_Lista")
            USE IN cursor_4c_Lista
        ENDIF

        loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Notas, a.Datas, a.Datars, a.ChkPagos, SUM(b.Qtds) AS Qtds " + ;
            "FROM SigMvCab a " + ;
            "LEFT JOIN SigMvItn b ON a.EmpDopNums = b.EmpDopNums " + ;
            "WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + " " + ;
            "AND a.Dopes = " + EscaparSQL(THIS.this_cDopes) + " " + ;
            "AND a.Datas BETWEEN " + loc_cDtIniSQL + " AND " + loc_cDtFimSQL + " " + ;
            "GROUP BY a.Datas, a.Datars, a.Emps, a.Dopes, a.Numes, a.Notas, a.ChkPagos " + ;
            "ORDER BY a.Datas, a.Datars, a.Emps, a.Dopes, a.Numes, a.Notas, a.ChkPagos"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(245) + "es no per" + CHR(237) + "odo."
            RETURN .F.
        ENDIF

        IF EOF("cursor_4c_Lista")
            THIS.this_cMensagemErro = "N" + CHR(227) + "o Foi Localizada Nenhuma Opera" + CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDetalheNivel - equivalente a lcQryBx dentro de HiNivel: dados de
    * cabecalho (SigMvCab) + quantidade (SigMvItn) de UM EmpDopNums, usados
    * para montar o texto do no da arvore.
    *--------------------------------------------------------------------------
    PROCEDURE ObterDetalheNivel(par_cEmpDopNums, par_nNivel, par_cCPros)
        LOCAL loc_cSQL, loc_nResultado, loc_lTemProduto

        loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros) AND par_nNivel = 3)
        THIS.this_cMensagemSQL = ""

        IF USED("cursor_4c_Detalhe")
            USE IN cursor_4c_Detalhe
        ENDIF

        loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.Usuars, a.DtAlts, a.Usuals, " + ;
            "c.EmpDopNums, SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvCab a " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE " + IIF(loc_lTemProduto, "c.Cpros = " + EscaparSQL(par_cCPros) + " AND ", "") + ;
            "a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
            "GROUP BY a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.Usuars, a.DtAlts, a.Usuals, c.EmpDopNums"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Detalhe")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN "cursor_4c_Detalhe"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterHistoricoNivel - equivalente a HiNivel: historico de baixa/producao
    * (SigMvPec + SigMvCab + SigMvItn, UNION ALL SigOpDev + SigMvCab + SigMvItn)
    * de um EmpDopNums. Retorna o NOME do cursor (cursor_4c_HiEstPe<nivel>)
    * para o Form fazer SELECT/SCAN, ou "" se falhar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterHistoricoNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
        LOCAL loc_cSQL, loc_cCursor, loc_nResultado, loc_lTemProduto

        loc_cCursor = "cursor_4c_HiEstPe" + TRANSFORM(par_nNivel)
        loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros))
        THIS.this_cMensagemSQL = ""

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
            "SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvPec a " + ;
            "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
            IIF(loc_lTemProduto, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "AND 0 = 1 ") + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps AS EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
            "SUM(c.Qtds) AS Qtds " + ;
            "FROM SigOpDev a " + ;
            "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
            IIF(loc_lTemProduto AND par_nNivel = 3, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "") + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
            "ORDER BY b.Datas, b.Datars, b.EmpDopNums, 14"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN loc_cCursor
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterSubNivel - equivalente a SubNivel: mesma consulta de HiNivel, mas
    * filtrando por a.Codigos (nDopes*1000000 + numero) em vez de EmpDopNums.
    * Retorna o NOME do cursor (cursor_4c_SubEstPe<nivel>), ou "" se falhar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterSubNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
        LOCAL loc_nCodOpe, loc_nCodigo, loc_cCursor, loc_cSQL, loc_nResultado, loc_lTemProduto

        THIS.this_cMensagemSQL = ""

        loc_nCodOpe = THIS.ObterCodigoOperacao(SUBSTR(par_cEmpDopNums, 4, 20))
        IF loc_nCodOpe < 0
            RETURN ""
        ENDIF

        loc_nCodigo = loc_nCodOpe * 1000000 + VAL(RIGHT(par_cEmpDopNums, 6))
        loc_cCursor = "cursor_4c_SubEstPe" + TRANSFORM(par_nNivel)
        loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros))

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
            "SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvPec a " + ;
            "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE a.Codigos = " + FormatarNumeroSQL(loc_nCodigo, 0) + " " + ;
            "AND a.EmpSubns = " + EscaparSQL(LEFT(par_cEmpDopNums, 3)) + " " + ;
            IIF(loc_lTemProduto, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "AND 0 = 1 ") + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps AS EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
            "SUM(c.Qtds) AS Qtds " + ;
            "FROM SigOpDev a " + ;
            "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE a.Codigos = " + FormatarNumeroSQL(loc_nCodigo, 0) + " " + ;
            IIF(loc_lTemProduto AND par_nNivel = 3, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "") + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
            "ORDER BY b.Datas, b.Datars, b.EmpDopNums, 14"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN loc_cCursor
    ENDPROC

    *--------------------------------------------------------------------------
    * DeduplicarSaldo - equivalente ao trecho comum de NoHiPro/NoProd:
    *   Select ... Sum(qtds) As qtds From <cursor origem> Group By ...
    *       Into Cursor crTmpSub<nivel> ReadWrite
    *   Delete For qtds <> 0
    * (mantem so as combinacoes cujo saldo agregado eh ZERO). PROTECTED: eh
    * detalhe interno de ObterNoHiPro/ObterNoProd, nao chamado pelo Form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DeduplicarSaldo(par_cCursorOrigem, par_nNivel)
        LOCAL loc_cCursorDedup

        loc_cCursorDedup = "cursor_4c_TmpSub" + TRANSFORM(par_nNivel)

        IF USED(loc_cCursorDedup)
            USE IN (loc_cCursorDedup)
        ENDIF

        SELECT a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns, SUM(qtds) AS qtds ;
            FROM (par_cCursorOrigem) a ;
            GROUP BY a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns ;
            INTO CURSOR (loc_cCursorDedup) READWRITE

        SELECT (loc_cCursorDedup)
        DELETE FOR qtds <> 0
        GO TOP

        RETURN loc_cCursorDedup
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCabecalhoOperacao - equivalente a csSigMvCab dentro de NoHiPro/
    * NoProd: Usuars/DtAlts/Usuals de UM EmpDopNums, usados no texto do no.
    *--------------------------------------------------------------------------
    PROCEDURE ObterCabecalhoOperacao(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado

        THIS.this_cMensagemSQL = ""

        IF USED("cursor_4c_CabInfo")
            USE IN cursor_4c_CabInfo
        ENDIF

        loc_cSQL = "SELECT Usuars, DtAlts, Usuals FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabInfo")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN "cursor_4c_CabInfo"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNoHiPro - equivalente a NoHiPro: baixas de estoque/producao ligadas
    * ao CODIGO (nDopes*1000000 + numero) do EmpDopNums informado, com o
    * agrupamento+filtro de saldo zero (DeduplicarSaldo). Retorna o NOME do
    * cursor deduplicado (cursor_4c_TmpSub<nivel>), ou "" se falhar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterNoHiPro(par_nNivel, par_cEmps, par_cEmpDopNums, par_cCPros)
        LOCAL loc_nCodOpe, loc_cCodigo, loc_cCursor, loc_cSQL, loc_nResultado

        THIS.this_cMensagemSQL = ""

        loc_nCodOpe = THIS.ObterCodigoOperacao(SUBSTR(par_cEmpDopNums, 4, 20))
        IF loc_nCodOpe < 0
            RETURN ""
        ENDIF

        loc_cCodigo = FormatarNumeroSQL(loc_nCodOpe * 1000000 + VAL(RIGHT(par_cEmpDopNums, 6)), 0)
        loc_cCursor = "cursor_4c_BxEst" + TRANSFORM(par_nNivel)

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns, SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvPec a, SigMvCab b, SigMvItn c " + ;
            "WHERE a.Codigos = " + loc_cCodigo + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpDopNums = c.EmpDopNums " + ;
            "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
            "FROM SigMvPec a, SigMvCab b " + ;
            "WHERE a.Codigos = " + loc_cCodigo + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.Emps AS EmpSubns, SUM(c.Qtds) AS Qtds " + ;
            "FROM SigOpDev a, SigMvCab b, SigMvItn c " + ;
            "WHERE a.Codigos = " + loc_cCodigo + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpDopNums = c.EmpDopNums " + ;
            "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN THIS.DeduplicarSaldo(loc_cCursor, par_nNivel)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNoProd - equivalente a NoProd: mesma logica de ObterNoHiPro, mas
    * filtrando por EmpDopNums reconstruido a partir do codigo do produto/
    * operacao (par_nCodigo). Retorna o NOME do cursor deduplicado
    * (cursor_4c_TmpSub<nivel>), ou "" se falhar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterNoProd(par_nNivel, par_cEmps, par_nCodigo, par_cCPros)
        LOCAL loc_nCodOpe, loc_cDopes, loc_nNumero, loc_cEmpDopNums, loc_cCursor, loc_cSQL, loc_nResultado

        THIS.this_cMensagemSQL = ""

        loc_nCodOpe = INT(par_nCodigo / 1000000)
        loc_cDopes  = THIS.ObterDopesPorCodigo(loc_nCodOpe)
        IF EMPTY(loc_cDopes)
            RETURN ""
        ENDIF

        loc_nNumero     = MOD(par_nCodigo, 1000000)
        loc_cEmpDopNums = par_cEmps + PADR(loc_cDopes, 20) + STR(loc_nNumero, 6)
        loc_cCursor     = "cursor_4c_BxEstProd" + TRANSFORM(par_nNivel)

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns, SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvPec a, SigMvCab b, SigMvItn c " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpDopNums = c.EmpDopNums " + ;
            "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
            "FROM SigMvPec a, SigMvCab b " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.Emps AS EmpSubns, 0 AS Qtds " + ;
            "FROM SigOpDev a, SigMvCab b " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN THIS.DeduplicarSaldo(loc_cCursor, par_nNivel)
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - fecha os cursores auxiliares de escopo fixo (os numerados por
    * nivel de recursao sao fechados pelo proprio Form conforme a arvore eh
    * percorrida, ja que o nivel maximo eh dinamico - ate 50, igual ao legado).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores[6], loc_nI

        loc_aCursores[1] = "cursor_4c_Cab"
        loc_aCursores[2] = "cursor_4c_Itens"
        loc_aCursores[3] = "cursor_4c_Lista"
        loc_aCursores[4] = "cursor_4c_Ope"
        loc_aCursores[5] = "cursor_4c_Emp"
        loc_aCursores[6] = "cursor_4c_CabInfo"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

