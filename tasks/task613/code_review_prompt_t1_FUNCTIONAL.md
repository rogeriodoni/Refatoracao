# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_GRF1, CNT_4C_GRF2, CNT_4C_AGUARDE. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Draw()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf2.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1412 linhas total):

*-- Linhas 6 a 177:
6: * Tipo: OPERACIONAL - form PLANO sem PageFrame (layout.json: todos os objetos
7: *       sao filhos diretos de SIGPRGF2). Aberto pelo form pai FormSigPrGf1
8: *       (BtnProcessarClick, ja completo) via
9: *       CREATEOBJECT("FormSigPrGf2", THIS), depois de processar e deixar
10: *       pronto o cursor agregado por mes no alias GLOBAL "crRel1" (o legado
11: *       abria com "Do Form SigPrGf2 With ThisForm").
12: *
13: * BO: SigPrGf2BO (sem tabela propria - so agrega/formata o cursor de origem
14: *     recebido do form pai; ver SigPrGf2BO.PopularChaves/GerarGrafico)
15: *
16: * Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init, cabecalho)
17: * Atualizado em: Fase 4 - CommandGroup obj_4c_CmdgGrafico (Grafico/Encerrar).
18: *                BINDEVENT dos 2 botoes fica para a Fase 7/8, junto com
19: *                mGeraGrafico/Report Form/fechamento do form (mesmo padrao
20: *                de FormSigPrGf1.ConfigurarBotoesAcao).
21: * Atualizado em: Fase 5 - cnt_4c_Grf1 (container flutuante do dump legado,
22: *                Top=120/Left=17/Width=770/Height=429/BackColor=branco) com
23: *                obj_4c_OleGrafico1 (OleBoundControl, Top=19/Left=5/
24: *                Width=760/Height=390). Container comeca Visible=.F.
25: *                (transcrito do Init legado: ".cntGrf1.Visible = .f." antes
26: *                de mGeraGrafico e ".t." depois) e por isso eh filtrado em
27: *                TornarControlesVisiveis, mesmo padrao de FormSigReCmg
28: *                (cnt_4c_Grf1/cnt_4c_Grf2/cnt_4c_Aguarde sao flutuantes,
29: *                controlados pelo Init/eventos, nao pelo
30: *                TornarControlesVisiveis generico). .ControlSource NAO eh
31: *                setado aqui - o legado so faz
32: *                ".cntGrf1.oleGrafico1.ControlSource = 'crGrafico1.gGrafico1s'"
33: *                dentro de mGeraGrafico, depois que o cursor crGrafico1 (e o
34: *                registro correspondente) ja existe; setar antes estouraria
35: *                alias inexistente (mesma familia da regra de
36: *                Column.ControlSource antes do cursor existir). Fica para a
37: *                Fase 7/8, junto com o resto de mGeraGrafico.
38: * Atualizado em: Fase 6 - cnt_4c_Grf2 (container flutuante do dump legado,
39: *                Top=558/Left=559/Width=228/Height=35/BackColor=branco)
40: *                com lbl_4c_LblChave1 ("Grupo / Vendedor :") e
41: *                cbo_4c_CmbChave1 (ComboBox Style=2/ColumnCount=1/
42: *                FontName="Courier New"). Container comeca Visible=.F. e
43: *                fica filtrado em TornarControlesVisiveis, mesmo padrao de
44: *                cnt_4c_Grf1: o Init legado faz ".cntGrf2.Visible = .f."
45: *                tanto ANTES quanto DEPOIS de mGeraGrafico (o combo de
46: *                selecao de chave nunca aparece neste fluxo).
47: *
48: *                LOOKUPS: o SCX legado NAO tem lookup nenhum - zero
49: *                fwBuscaExt / fwBuscaSel / sigacess() / mAddColuna /
50: *                Acesso*() no dump inteiro (SigPrGf2_form_codigo_fonte.txt).
51: *                Esta tela eh um visualizador de grafico: o unico campo de
52: *                entrada eh o ComboBox Style=2 (dropdown LIST), que nao
53: *                aceita digitacao e cuja lista o proprio form monta a partir
54: *                do cursor de origem recebido do pai. Criar um
55: *                AbrirLookup*/FormBuscaAuxiliar aqui seria INVENTAR tabela de
56: *                lookup que o legado nao consulta - viola o PILAR 1 e a regra
57: *                "NUNCA inventar tabelas de lookup que nao existem no
58: *                original".
59: *
60: *                CAMPOS RESTANTES (ultimo container estatico do dump):
61: *                cnt_4c_Aguarde (Top=288/Left=312/Width=207/Height=49/
62: *                BorderWidth=5/BackColor=branco) com lbl_4c_Label1
63: *                ("Aguarde...", Verdana 10 bold, ForeColor=RGB(255,0,0)) e
64: *                lbl_4c_Label2 ("Processando Dados...", Verdana 10 bold
65: *                condensada). Com ele, TODOS os 14 objetos da arvore do SCX
66: *                legado estao criados.
67: *
68: *                COMPORTAMENTO DO CAMPO (o que substitui o lookup nesta
69: *                tela): os DOIS eventos que o legado tem no cmbChave1 -
70: *                Click e GotFocus - ligados por BINDEVENT, mais a guarda que
71: *                o legado aplica ao indice do combo antes de usa-lo
72: *                (ValidarLinhaChave, transcrita de "m.lnLinhaCmb1 =
73: *                Iif((Type('m.lnLinhaCmb1')=='N'.And.m.lnLinhaCmb1>0),
74: *                m.lnLinhaCmb1,1)" somada ao gate
75: *                "If .cntGrf2.cmbChave1.ListCount>0" do mGeraGrafico) e a
76: *                leitura do item selecionado (ObterChaveSelecionada,
77: *                transcrita de "m.lcChave1 =
78: *                .cntGrf2.cmbChave1.List(m.lnLinhaCmb1)").
79: *                CboChave1Click reproduz o Click legado inteiro: exibe
80: *                cnt_4c_Aguarde, Refresh/Draw, LockScreen, desabilita os
81: *                OleBoundControl, gera o grafico da chave escolhida
82: *                (SigPrGf2BO.GerarGrafico, ja completo desde a Fase 2),
83: *                devolve o foco ao combo e esconde o Aguarde.
84: *
85: *                O AddItem dos valores, o ListIndex=1 inicial, o
86: *                reposicionamento/redimensionamento dinamico do proprio
87: *                cntGrf2 (calculados a partir do tamanho dos valores de
88: *                crRel1.cEmps) e o DESENHO do MSGraph no OleBoundControl
89: *                (Append General + ControlSource + propriedades do chart)
90: *                ficam para a Fase 7/8, junto com o resto de mGeraGrafico e
91: *                com os Click dos 2 botoes de obj_4c_CmdgGrafico.
92: *
93: * Atualizado em: Fase 7/8 - fecha o mgeragrafico legado: PopularComboChaves()
94: *                (AddItem + reposicionamento de cnt_4c_Grf2, so na 1a chamada,
95: *                guardado pelo ListCount) e DesenharGrafico() (cursor LOCAL
96: *                cursor_4c_OleGrafico1 - equivalente a crGrafico1, com o
97: *                binario do OLE que o BO nao guarda - Append General +
98: *                ControlSource + toda a formatacao do MSGraph.Chart), ambos
99: *                por tras de MGeraGrafico() (fonte UNICA, chamada tanto por
100: *                ExecutarCargaInicial() - equivalente ao trecho do Init
101: *                legado que chama ".mGeraGrafico()" antes do Show() - quanto
102: *                por CboChave1Click(), que agora delega em vez de duplicar
103: *                Validar/Obter/Gerar). BINDEVENT dos 2 botoes de
104: *                obj_4c_CmdgGrafico: Buttons(1) "Grafico" -> BtnGraficoClick
105: *                (Report Form do registro atual do cache, igual ao
106: *                cmdImprimir.Click legado) e Buttons(2) "Encerrar" ->
107: *                BtnEncerrarClick (fecha o cursor do OLE, libera o form e
108: *                reabilita this_oFormPai, igual ao cmdSair.Click legado).
109: *                Medido no VFP9 (2026-09-29): fluxo pai->filho fim-a-fim
110: *                (crRel1 populado na sessao privada do pai, filho aberto com
111: *                CREATEOBJECT("FormSigPrGf2", <pai>)) prova o combo populado,
112: *                o BO gerando a serie certa e a troca de chave regenerando -
113: *                o unico ponto que a maquina de teste nao cobre eh o proprio
114: *                APPEND GENERAL CLASS "MSGraph.Chart", porque este ambiente
115: *                nao tem esse OLE server registrado (OLE error 0x800401f3);
116: *                por isso DesenharGrafico() isola o INSERT/APPEND GENERAL num
117: *                TRY proprio e desfaz a linha de cache se falhar - sem o
118: *                rollback, a mesma chave nunca mais tentaria desenhar (ficaria
119: *                para sempre com o cache "encontrado" e o gGrafico1s vazio).
120: *
121: * CONTRATO COM O FORM PAI (FormSigPrGf1, ja completo - ver o comentario acima
122: * de "CREATEOBJECT("FormSigPrGf2", THIS)" em FormSigPrGf1.BtnProcessarClick)
123: * --------------------------------------------------------------------------
124: * 1) CREATEOBJECT("FormSigPrGf2", <form pai>) - UM parametro, a referencia do
125: *    form pai (par_loForm1, mesmo nome do "loForm1" recebido pelo Init
126: *    legado). Sem parametro, THIS.this_oFormPai aponta para o proprio form
127: *    (equivalente a "Iif(Type('m.loForm1')=='O',m.loForm1,ThisForm)" do
128: *    legado).
129: * 2) THIS.DataSessionId = par_loForm1.DataSessionId ANTES do DODEFAULT() -
130: *    entra na MESMA sessao privada do pai (DataSession=2 dele) para enxergar
131: *    o cursor global "crRel1" que o pai populou antes de abrir este form.
132: * 3) WindowType = 0 (modeless, TRANSCRITO do legado - NAO trocar para 1): o
133: *    pai (FormSigPrGf1.BtnProcessarClick) so faz THIS.Enabled = .F. depois de
134: *    confirmar VARTYPE(...) = "O" do CREATEOBJECT e NUNCA chama .Show() no
135: *    filho - quem se mostra eh o proprio filho.
136: * 4) O legado mostra a tela no proprio Init (".Show()" dentro de
137: *    "With ThisForm"), por isso InicializarForm chama THIS.Show() ao final -
138: *    seguro aqui porque WindowType = 0 nao bloqueia (a regra do CLAUDE.md
139: *    sobre Show() modal dentro de TRY fechar a tela nao se aplica a form
140: *    modeless, so a WindowType = 1).
141: *==============================================================================
142: 
143: DEFINE CLASS FormSigPrGf2 AS FormBase
144: 
145:     *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
146:     *-- SIGPRGF2.SCX: Width=800, Height=600 (layout.json) - dialogo de
147:     *-- grafico, sem necessidade de escalar para o canonico 1000x600 (esse
148:     *-- canonico vale para forms CRUD frmcadastro).
149:     Width        = 800
150:     Height       = 600
151:     AutoCenter   = .T.
152:     Caption      = "Gr" + CHR(225) + "fico de Falha X Recupera" + CHR(231) + CHR(227) + "o Mensal"
153:     WindowType   = 0
154:     ShowWindow = 1
155:     ControlBox   = .F.
156:     MaxButton    = .F.
157:     MinButton    = .F.
158:     TitleBar     = 0
159:     BorderStyle  = 1
160: 
161:     *-- DataSession = 2 transcrito do SCX. So vale quando este form eh aberto
162:     *-- SEM form pai (this_oFormPai = THIS): nesse caso ganha sessao privada
163:     *-- propria. Quando ha form pai, Init() troca THIS.DataSessionId pela
164:     *-- sessao dele ANTES do DODEFAULT() - ver contrato no cabecalho.
165:     DataSession  = 2
166: 
167:     *-- Business Object
168:     this_oBusinessObject = .NULL.
169: 
170:     *-- Referencia do form pai (poForm1 do legado). Reabilitado no Encerrar
171:     *-- (Fase 7/8, migracao de cmdSair.Click).
172:     this_oFormPai = .NULL.
173: 
174:     *-- Cache LOCAL do binario do grafico (MSGraph.Chart) por chave -
175:     *-- equivalente ao crGrafico1 do legado (gGrafico1s g(4)/cChave1s c(100)/
176:     *-- cempresas c(254)/ctitulo1s c(128)). O BO (this_oBusinessObject) so
177:     *-- guarda o TEXTO das series (this_cLabelsMeses/this_cSerieFalha/

*-- Linhas 184 a 334:
184:     * "Lparameters loForm1" do legado) e assume a DataSessionId dele ANTES do
185:     * DODEFAULT(), para enxergar o cursor "crRel1" que o pai ja populou.
186:     *==========================================================================
187:     PROCEDURE Init()
188:         LPARAMETERS par_loForm1
189: 
190:         LOCAL loc_oErro
191: 
192:         TRY
193:             IF VARTYPE(par_loForm1) = "O"
194:                 THIS.this_oFormPai = par_loForm1
195:                 THIS.DataSessionId = par_loForm1.DataSessionId
196:             ELSE
197:                 THIS.this_oFormPai = THIS
198:             ENDIF
199:         CATCH TO loc_oErro
200:             MsgErro(loc_oErro.Message + CHR(13) + ;
201:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
202:                 "Procedure: " + loc_oErro.Procedure, "Erro em Init")
203:         ENDTRY
204: 
205:         RETURN DODEFAULT()
206:     ENDPROC
207: 
208:     *==========================================================================
209:     * InicializarForm - Instancia o BO, aponta o cursor de origem (alias
210:     * GLOBAL "crRel1", equivalente ao crRel1 do legado - regra #22/PILAR 3: o
211:     * BO nao adivinha o nome, o Form eh quem sabe o contrato com o pai), monta
212:     * o cabecalho e exibe o form (equivalente ao ".Show()" dentro do
213:     * "With ThisForm" do Init legado).
214:     *==========================================================================
215:     PROTECTED PROCEDURE InicializarForm()
216:         LOCAL loc_lSucesso, loc_oErro
217:         loc_lSucesso = .F.
218: 
219:         TRY
220:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf2BO")
221: 
222:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
223:                 THIS.this_oBusinessObject.this_cCursorOrigem = "crRel1"
224: 
225:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
226: 
227:                 THIS.ConfigurarPageFrame()
228: 
229:                 THIS.TornarControlesVisiveis(THIS)
230: 
231:                 THIS.ExecutarCargaInicial()
232: 
233:                 *-- Pulado em harness headless (gb_4c_ModoTeste/
234:                 *-- gb_4c_ValidandoUI): sem janela de verdade o Show() de um
235:                 *-- form modeless so faria o processo depender de uma UI que
236:                 *-- nao existe no teste automatizado.
237:                 IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) AND ;
238:                    !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
239:                     THIS.Show()
240:                 ENDIF
241: 
242:                 loc_lSucesso = .T.
243:             ELSE
244:                 MsgErro("Erro ao criar SigPrGf2BO. VARTYPE retornou: " + ;
245:                     VARTYPE(THIS.this_oBusinessObject), "FormSigPrGf2.InicializarForm")
246:             ENDIF
247:         CATCH TO loc_oErro
248:             MsgErro(loc_oErro.Message + CHR(13) + ;
249:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
250:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGf2.InicializarForm")
251:         ENDTRY
252: 
253:         RETURN loc_lSucesso
254:     ENDPROC
255: 
256:     *==========================================================================
257:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGF2 nao tem
258:     * PageFrame no legado (layout flat) - nome mantido apenas como ponto de
259:     * entrada arquitetural padrao (mesmo papel em FormSigPrGf1/FormFop).
260:     *
261:     * Roteiro das proximas fases:
262:     *   Fase 3 (feita) - ConfigurarCabecalho()
263:     *   Fase 4 (feita) - ConfigurarBotoesGrafico() (obj_4c_CmdgGrafico,
264:     *                      CommandGroup com 2 botoes: Grafico/Encerrar)
265:     *   Fase 5 (feita) - ConfigurarGrf1() (cnt_4c_Grf1 flutuante +
266:     *                      obj_4c_OleGrafico1)
267:     *   Fase 6 (esta)  - ConfigurarGrf2() (cnt_4c_Grf2 flutuante + combo
268:     *                      cbo_4c_CmbChave1 + lbl_4c_LblChave1),
269:     *                      ConfigurarAguarde() (cnt_4c_Aguarde + os 2 labels)
270:     *                      e ConfigurarEventos() (BINDEVENT Click/GotFocus do
271:     *                      combo - o legado nao tem lookup nenhum)
272:     *   Fase 7/8        - BINDEVENT dos 2 botoes de obj_4c_CmdgGrafico e
273:     *                      mGeraGrafico (carga do combo + desenho do MSGraph)
274:     *
275:     * ConfigurarEventos() vai por ULTIMO de proposito: BINDEVENT so resolve
276:     * referencia de objeto que JA existe, entao todo AddObject tem de ter
277:     * acontecido antes.
278:     *==========================================================================
279:     PROTECTED PROCEDURE ConfigurarPageFrame()
280:         THIS.ConfigurarCabecalho()
281:         THIS.ConfigurarBotoesGrafico()
282:         THIS.ConfigurarGrf1()
283:         THIS.ConfigurarGrf2()
284:         THIS.ConfigurarAguarde()
285:         THIS.ConfigurarEventos()
286:     ENDPROC
287: 
288:     *==========================================================================
289:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
290:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
291:     * BackColor=RGB(100,100,100) (layout.json) - copiado sem escala, pois
292:     * THIS.Width ja eh 800 (identico ao legado).
293:     *==========================================================================
294:     PROTECTED PROCEDURE ConfigurarCabecalho()
295:         LOCAL loc_oCnt, loc_oErro
296: 
297:         TRY
298:             THIS.AddObject("cnt_4c_Sombra", "Container")
299:             loc_oCnt = THIS.cnt_4c_Sombra
300:             WITH loc_oCnt
301:                 .Top         = 0
302:                 .Left        = 0
303:                 .Width       = THIS.Width
304:                 .Height      = 80
305:                 .BorderWidth = 0
306:                 .BackColor   = RGB(100, 100, 100)
307:                 .Visible     = .T.
308:             ENDWITH
309: 
310:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
311:             WITH loc_oCnt.lbl_4c_LblSombra
312:                 .FontBold      = .T.
313:                 .FontName      = "Tahoma"
314:                 .FontSize      = 18
315:                 .FontUnderline = .F.
316:                 .WordWrap      = .T.
317:                 .Alignment     = 0
318:                 .BackStyle     = 0
319:                 .AutoSize      = .F.
320:                 .Caption       = THIS.Caption
321:                 .Height        = 40
322:                 .Left          = 10
323:                 .Top           = 18
324:                 .Width         = 769
325:                 .ForeColor     = RGB(0, 0, 0)
326:                 .Visible       = .T.
327:             ENDWITH
328: 
329:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
330:             WITH loc_oCnt.lbl_4c_LblTitulo
331:                 .FontBold   = .T.
332:                 .FontName   = "Tahoma"
333:                 .FontSize   = 18
334:                 .WordWrap   = .T.

*-- Linhas 346 a 404:
346:         CATCH TO loc_oErro
347:             MsgErro(loc_oErro.Message + CHR(13) + ;
348:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
349:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
350:         ENDTRY
351:     ENDPROC
352: 
353:     *==========================================================================
354:     * ConfigurarBotoesGrafico - CommandGroup obj_4c_CmdgGrafico com os 2
355:     * botoes do legado (cmdgGrafico, ButtonCount=2): Buttons(1)=Grafico
356:     * (cmdImprimir, dispara Report Form SigPrGf1 - migracao na Fase 7/8) e
357:     * Buttons(2)=Encerrar (cmdSair, fecha o form e reabilita o pai). Geometria
358:     * e cores copiadas do dump (SigPrGf2_form_codigo_fonte.txt) -
359:     * Left=644/Top=-3/Width=160/Height=85 no grupo, botoes 75x75 em
360:     * Left=5/80. BINDEVENT do Click fica para a Fase 7/8 (junto com
361:     * mGeraGrafico/Report Form/fechamento), mesmo padrao de
362:     * FormSigPrGf1.ConfigurarBotoesAcao.
363:     *==========================================================================
364:     PROTECTED PROCEDURE ConfigurarBotoesGrafico()
365:         LOCAL loc_oErro
366: 
367:         TRY
368:             THIS.AddObject("obj_4c_CmdgGrafico", "CommandGroup")
369:             WITH THIS.obj_4c_CmdgGrafico
370:                 .ButtonCount   = 2
371:                 .BackStyle     = 0
372:                 .BorderStyle   = 0
373:                 .SpecialEffect = 1
374:                 .Top           = -3
375:                 .Left          = 644
376:                 .Width         = 160
377:                 .Height        = 85
378:                 .Value         = 0
379:                 .BorderColor   = RGB(136, 189, 188)
380:                 .TabIndex      = 4
381:                 .AutoSize      = .T.
382:                 .Visible       = .T.
383: 
384:                 WITH .Buttons(1)
385:                     *-- "\<Gr" + CHR(225) + "fico" - acelerador Alt+G do
386:                     *-- legado (Command1.Caption = "\<Gr醘ico" no dump,
387:                     *-- CHR(225)=a-acute corrompido na extracao em texto).
388:                     .Caption         = "\<Gr" + CHR(225) + "fico"
389:                     .Left            = 5
390:                     .Top             = 5
391:                     .Width           = 75
392:                     .Height          = 75
393:                     .FontName        = "Comic Sans MS"
394:                     .FontSize        = 8
395:                     .FontBold        = .T.
396:                     .FontItalic      = .T.
397:                     .ForeColor       = RGB(90, 90, 90)
398:                     .BackColor       = RGB(255, 255, 255)
399:                     .Themes          = .F.
400:                     .SpecialEffect   = 0
401:                     .PicturePosition = 13
402:                     .Picture         = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
403:                     .WordWrap        = .T.
404:                     .MousePointer    = 15

*-- Linhas 430 a 546:
430:         CATCH TO loc_oErro
431:             MsgErro(loc_oErro.Message + CHR(13) + ;
432:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
433:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesGrafico")
434:         ENDTRY
435:     ENDPROC
436: 
437:     *==========================================================================
438:     * ConfigurarGrf1 - cnt_4c_Grf1, container flutuante que hospeda o grafico
439:     * (obj_4c_OleGrafico1, OleBoundControl). Geometria e cores copiadas do
440:     * dump (SigPrGf2_form_codigo_fonte.txt): cntGrf1 Top=120/Left=17/
441:     * Width=770/Height=429/BackStyle=1/BackColor=branco; oleGrafico1 dentro
442:     * dele em Top=19/Left=5/Width=760/Height=390.
443:     *
444:     * Container comeca Visible=.F. (transcrito do Init legado -
445:     * ".cntGrf1.Visible = .f." ate mGeraGrafico terminar, ".t." depois) e por
446:     * isso NAO passa por TornarControlesVisiveis (ver filtro abaixo) - quem
447:     * vai alternar a visibilidade eh a logica de Init/mGeraGrafico da
448:     * Fase 7/8, igual ao padrao de FormSigReCmg.
449:     *
450:     * .ControlSource do OLE NAO eh setado aqui: o legado so faz
451:     * ".ControlSource = 'crGrafico1.gGrafico1s'" dentro de mGeraGrafico,
452:     * depois que o cursor crGrafico1 e o registro correspondente ja existem -
453:     * setar antes estouraria alias inexistente. Fica para a Fase 7/8.
454:     *==========================================================================
455:     PROTECTED PROCEDURE ConfigurarGrf1()
456:         LOCAL loc_oErro
457: 
458:         TRY
459:             THIS.AddObject("cnt_4c_Grf1", "Container")
460:             WITH THIS.cnt_4c_Grf1
461:                 .Top           = 120
462:                 .Left          = 17
463:                 .Width         = 770
464:                 .Height        = 429
465:                 .BackStyle     = 1
466:                 .SpecialEffect = 0
467:                 .BackColor     = RGB(255, 255, 255)
468:                 .Visible       = .F.
469: 
470:                 .AddObject("obj_4c_OleGrafico1", "OleBoundControl")
471:                 WITH .obj_4c_OleGrafico1
472:                     .Top     = 19
473:                     .Left    = 5
474:                     .Width   = 760
475:                     .Height  = 390
476:                     .Visible = .T.
477:                 ENDWITH
478:             ENDWITH
479:         CATCH TO loc_oErro
480:             MsgErro(loc_oErro.Message + CHR(13) + ;
481:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
482:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrf1")
483:         ENDTRY
484:     ENDPROC
485: 
486:     *==========================================================================
487:     * ConfigurarGrf2 - cnt_4c_Grf2, container flutuante que hospeda o combo de
488:     * selecao de chave do grafico (cbo_4c_CmbChave1 + lbl_4c_LblChave1).
489:     * Geometria e cores copiadas do dump (SigPrGf2_form_codigo_fonte.txt):
490:     * cntGrf2 Top=558/Left=559/Width=228/Height=35/BackStyle=1/BackColor=branco;
491:     * cmbChave1 Top=4/Left=129/Width=86/Height=25/Style=2 (dropdown list)/
492:     * ColumnCount=1/FontName="Courier New"; lblChave1 Top=9/Left=7/Width=94/
493:     * Height=15/AutoSize=.T./FontName="Tahoma"/FontSize=8/
494:     * ForeColor=RGB(90,90,90) (regra #12/canonico - Say sem ForeColor
495:     * declarado no legado, mas aqui o dump ja traz 90,90,90 explicito).
496:     *
497:     * Container comeca Visible=.F. (transcrito do Init legado -
498:     * ".cntGrf2.Visible = .f." tanto ANTES quanto DEPOIS de mGeraGrafico, isto
499:     * eh, o legado nunca exibe este container neste fluxo com uma unica
500:     * empresa/vendedor) e por isso NAO passa por TornarControlesVisiveis (ver
501:     * filtro abaixo), mesmo padrao de cnt_4c_Grf1/FormSigReCmg. Geometria e
502:     * conteudo do combo (AddItem/ListIndex/reposicionamento dinamico do
503:     * proprio cntGrf2) ficam para a Fase 7/8, dentro de mGeraGrafico - aqui
504:     * so a estrutura estatica do dump eh criada.
505:     *==========================================================================
506:     PROTECTED PROCEDURE ConfigurarGrf2()
507:         LOCAL loc_oCnt, loc_oErro
508: 
509:         TRY
510:             THIS.AddObject("cnt_4c_Grf2", "Container")
511:             loc_oCnt = THIS.cnt_4c_Grf2
512:             WITH loc_oCnt
513:                 .Top           = 558
514:                 .Left          = 559
515:                 .Width         = 228
516:                 .Height        = 35
517:                 .BackStyle     = 1
518:                 .SpecialEffect = 0
519:                 .BackColor     = RGB(255, 255, 255)
520:                 .Visible       = .F.
521:             ENDWITH
522: 
523:             *-- .AddObject FORA do WITH do pai + WITH com caminho EXPLICITO
524:             *-- (nao ".filho" relativo) - WITH aninhado apos AddObject descarta
525:             *-- Caption/ForeColor em silencio (mesmo padrao de
526:             *-- ConfigurarCabecalho acima).
527:             loc_oCnt.AddObject("lbl_4c_LblChave1", "Label")
528:             WITH loc_oCnt.lbl_4c_LblChave1
529:                 *-- .AutoSize = .F. embora o dump traga .T.: AutoSize eh no-op
530:                 *-- em Label criado por AddObject (a Width fica no default 100)
531:                 *-- e, com WordWrap, ainda DESCARTA a .Height. Width/Height
532:                 *-- transcritos do SCX ja SAO o auto-size que o Form Designer
533:                 *-- calculou, logo fixa-los eh reproducao fiel (regra #23).
534:                 .AutoSize  = .F.
535:                 .FontName  = "Tahoma"
536:                 .FontSize  = 8
537:                 .BackStyle = 0
538:                 .Caption   = "Grupo / Vendedor :"
539:                 .Height    = 15
540:                 .Left      = 7
541:                 .Top       = 9
542:                 .Width     = 94
543:                 .ForeColor = RGB(90, 90, 90)
544:                 .Visible   = .T.
545:             ENDWITH
546: 

*-- Linhas 559 a 627:
559:         CATCH TO loc_oErro
560:             MsgErro(loc_oErro.Message + CHR(13) + ;
561:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
562:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrf2")
563:         ENDTRY
564:     ENDPROC
565: 
566:     *==========================================================================
567:     * ConfigurarAguarde - cnt_4c_Aguarde, ultimo container estatico do dump
568:     * legado (cntAguarde): a caixinha branca "Aguarde... / Processando
569:     * Dados..." exibida enquanto o grafico eh gerado. Geometria e cores
570:     * copiadas do dump (SigPrGf2_form_codigo_fonte.txt): cntAguarde
571:     * Top=288/Left=312/Width=207/Height=49/BorderWidth=5/SpecialEffect=0/
572:     * BackColor=branco; Label1 "Aguarde..." Top=7/Left=69/Width=78/Height=18/
573:     * Verdana 10 bold/BackStyle=0/ForeColor=RGB(255,0,0); Label2 "Processando
574:     * Dados..." Top=24/Left=34/Width=159/Height=18/Verdana 10 bold/
575:     * FontCondense=.T./Alignment=0/BackStyle=0.
576:     *
577:     * Label2 NAO declara ForeColor no dump - canonico RGB(90,90,90)
578:     * (regra #12). Aqui os dois labels ficam sobre container OPACO branco,
579:     * entao ambos sao legiveis; RGB(90,90,90) mantem o padrao do projeto.
580:     *
581:     * Container comeca Visible=.F.: o Init legado o deixa .t. durante o
582:     * processamento e .f. ao terminar (".cntAguarde.Visible = .f." como
583:     * estado final), e o Click do combo faz o mesmo ciclo. Por isso NAO passa
584:     * por TornarControlesVisiveis - quem alterna eh CboChave1Click (e, na
585:     * Fase 7/8, o fluxo de Init/mGeraGrafico).
586:     *==========================================================================
587:     PROTECTED PROCEDURE ConfigurarAguarde()
588:         LOCAL loc_oCnt, loc_oErro
589: 
590:         TRY
591:             THIS.AddObject("cnt_4c_Aguarde", "Container")
592:             loc_oCnt = THIS.cnt_4c_Aguarde
593:             WITH loc_oCnt
594:                 .Top           = 288
595:                 .Left          = 312
596:                 .Width         = 207
597:                 .Height        = 49
598:                 .BorderWidth   = 5
599:                 .SpecialEffect = 0
600:                 .BackStyle     = 1
601:                 .BackColor     = RGB(255, 255, 255)
602:                 .Visible       = .F.
603:             ENDWITH
604: 
605:             *-- .AddObject FORA do WITH do pai + WITH com caminho EXPLICITO
606:             *-- (nao ".filho" relativo) - WITH aninhado apos AddObject descarta
607:             *-- Caption/ForeColor em silencio.
608:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
609:             WITH loc_oCnt.lbl_4c_Label1
610:                 *-- .AutoSize = .F. embora o dump traga .T. (regra #23)
611:                 .AutoSize  = .F.
612:                 .FontBold  = .T.
613:                 .FontName  = "Verdana"
614:                 .FontSize  = 10
615:                 .BackStyle = 0
616:                 .Caption   = "Aguarde..."
617:                 .Height    = 18
618:                 .Left      = 69
619:                 .Top       = 7
620:                 .Width     = 78
621:                 .ForeColor = RGB(255, 0, 0)
622:                 .Visible   = .T.
623:             ENDWITH
624: 
625:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
626:             WITH loc_oCnt.lbl_4c_Label2
627:                 .AutoSize     = .F.

*-- Linhas 642 a 800:
642:         CATCH TO loc_oErro
643:             MsgErro(loc_oErro.Message + CHR(13) + ;
644:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
645:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAguarde")
646:         ENDTRY
647:     ENDPROC
648: 
649:     *==========================================================================
650:     * ConfigurarEventos - Liga por BINDEVENT os DOIS eventos que o SCX legado
651:     * tem no cmbChave1, e SO esses dois (o dump nao tem mais nenhum evento de
652:     * campo - zero Valid, zero KeyPress, zero LostFocus, zero lookup):
653:     *
654:     *   SIGPRGF2.cntGrf2.cmbChave1.Click    -> CboChave1Click
655:     *   SIGPRGF2.cntGrf2.cmbChave1.GotFocus -> CboChave1GotFocus
656:     *
657:     * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
658:     * metodo PROTECTED. Nenhum dos dois eventos leva parametro, por isso os
659:     * handlers tambem nao declaram LPARAMETERS.
660:     *
661:     * Fase 7/8 (esta): BINDEVENT dos 2 botoes de obj_4c_CmdgGrafico -
662:     * Buttons(1) "Grafico" (cmdImprimir do legado) -> BtnGraficoClick,
663:     * Buttons(2) "Encerrar" (cmdSair do legado) -> BtnEncerrarClick.
664:     *==========================================================================
665:     PROTECTED PROCEDURE ConfigurarEventos()
666:         LOCAL loc_oErro
667: 
668:         TRY
669:             BINDEVENT(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1, "Click", ;
670:                 THIS, "CboChave1Click")
671: 
672:             BINDEVENT(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1, "GotFocus", ;
673:                 THIS, "CboChave1GotFocus")
674: 
675:             BINDEVENT(THIS.obj_4c_CmdgGrafico.Buttons(1), "Click", ;
676:                 THIS, "BtnGraficoClick")
677: 
678:             BINDEVENT(THIS.obj_4c_CmdgGrafico.Buttons(2), "Click", ;
679:                 THIS, "BtnEncerrarClick")
680:         CATCH TO loc_oErro
681:             MsgErro(loc_oErro.Message + CHR(13) + ;
682:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
683:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventos")
684:         ENDTRY
685:     ENDPROC
686: 
687:     *==========================================================================
688:     * ExecutarCargaInicial - Estados de visibilidade + primeira chamada de
689:     * MGeraGrafico(), equivalente ao trecho do Init legado entre o
690:     * "With ThisForm" e o ".Show()" final:
691:     *
692:     *   .cntAguarde.Visible = .t. / .cntGrf1.Visible = .f. /
693:     *   .cntGrf2.Visible = .f. / .cmdgGrafico.Visible = .f.
694:     *   .cntGrf2.cmbChave1.Clear
695:     *   .mGeraGrafico()
696:     *   .cntAguarde.Visible = .f. / .cntGrf1.Visible = .t. /
697:     *   .cntGrf2.Visible = .f. / .cmdgGrafico.Visible = .t.
698:     *   .cntGrf2.cmbChave1.ListIndex = 1
699:     *   .cntGrf2.cmbChave1.SetFocus
700:     *
701:     * DIVERGENCIA DELIBERADA: o legado intercala Refresh()/Show()/Draw() e
702:     * LockScreen .t./.f./.t. DUAS VEZES antes deste trecho, so para reduzir
703:     * flicker numa maquina antiga enquanto mostra a janela ainda com
704:     * "Aguarde..." antes de calcular o grafico. O estado VISIVEL final
705:     * (containers, combo populado no item 1, grafico desenhado) e o mesmo
706:     * se este metodo rodar por completo ANTES do THIS.Show() unico do
707:     * InicializarForm - por isso o dance de Show()/LockScreen intermediario
708:     * nao foi reproduzido (nao ha diferenca de ESTADO, so de flicker, sem
709:     * forma segura de testar flicker num harness headless). SetFocus final
710:     * do legado NAO eh chamado aqui: cnt_4c_Grf2 fica Visible = .F. nos dois
711:     * estados (ver comentario de ConfigurarGrf2 - o combo de selecao nunca
712:     * aparece neste fluxo) e SetFocus em controle dentro de container
713:     * invisivel estoura em runtime.
714:     *==========================================================================
715:     PROTECTED PROCEDURE ExecutarCargaInicial()
716:         LOCAL loc_oErro
717: 
718:         TRY
719:             THIS.cnt_4c_Aguarde.Visible     = .T.
720:             THIS.cnt_4c_Grf1.Visible        = .F.
721:             THIS.cnt_4c_Grf2.Visible        = .F.
722:             THIS.obj_4c_CmdgGrafico.Visible = .F.
723: 
724:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear
725: 
726:             THIS.MGeraGrafico(1)
727: 
728:             THIS.cnt_4c_Aguarde.Visible     = .F.
729:             THIS.cnt_4c_Grf1.Visible        = .T.
730:             THIS.cnt_4c_Grf2.Visible        = .F.
731:             THIS.obj_4c_CmdgGrafico.Visible = .T.
732: 
733:             IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
734:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
735:             ENDIF
736:         CATCH TO loc_oErro
737:             MsgErro(loc_oErro.Message + CHR(13) + ;
738:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
739:                 "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarCargaInicial")
740:         ENDTRY
741:     ENDPROC
742: 
743:     *==========================================================================
744:     * PopularComboChaves - Preenche cbo_4c_CmbChave1 com as chaves distintas
745:     * do cursor de origem (this_oBusinessObject.PopularChaves(), Fase 1/2 ja
746:     * completa) e reposiciona/redimensiona cnt_4c_Grf2, replicando o bloco
747:     * "If Empty(.cntGrf2.cmbChave1.ListCount)" do mgeragrafico legado (linhas
748:     * 420-467 do dump). So roda de fato UMA vez por form (guard pelo proprio
749:     * ListCount) - chamadas seguintes de MGeraGrafico() so pulam este bloco,
750:     * igual ao "If Empty(...)" do legado.
751:     *
752:     * m.lnTmStr1 do legado (Len(laVendedor(1)), 1o elemento do array
753:     * Select Distinct SEM AllTrim - cEmps eh char de largura fixa, entao
754:     * todos os elementos tem o MESMO Len) vira aqui o MAIOR comprimento
755:     * entre as chaves ja TRIMADAS por PopularChaves (regra #22/PILAR 3: o BO
756:     * ja decidiu usar ALLTRIM na Fase 1/2, entao os comprimentos podem
757:     * variar) - o maior valor preserva o alinhamento em coluna do PadR
758:     * usado no AddItem.
759:     *==========================================================================
760:     PROTECTED PROCEDURE PopularComboChaves()
761:         LOCAL loc_oCnt, loc_oCombo, loc_oLabel, loc_nTamanho, loc_cAlias, loc_oErro
762: 
763:         loc_oCnt   = THIS.cnt_4c_Grf2
764:         loc_oCombo = loc_oCnt.cbo_4c_CmbChave1
765:         loc_oLabel = loc_oCnt.lbl_4c_LblChave1
766: 
767:         IF loc_oCombo.ListCount > 0
768:             RETURN
769:         ENDIF
770: 
771:         TRY
772:             IF THIS.this_oBusinessObject.PopularChaves()
773:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorChaves
774: 
775:                 loc_nTamanho = 1
776:                 SELECT (loc_cAlias)
777:                 SCAN
778:                     loc_nTamanho = MAX(loc_nTamanho, LEN(ALLTRIM(Chaves)))
779:                 ENDSCAN
780: 
781:                 *-- Legado: With .cntGrf2 / With .lblChave1 / .Left=5 / .Top=10
782:                 loc_oLabel.Left = 5
783:                 loc_oLabel.Top  = 10
784: 
785:                 loc_oCombo.Clear
786:                 loc_oCombo.Alignment         = 0
787:                 loc_oCombo.ColumnCount       = 0
788:                 loc_oCombo.ColumnLines       = .F.
789:                 loc_oCombo.IncrementalSearch = .T.
790:                 loc_oCombo.FontName          = "Courier New"
791:                 loc_oCombo.FontSize          = 9
792:                 loc_oCombo.RowSourceType     = 0
793:                 loc_oCombo.Style             = 2
794:                 loc_oCombo.ReadOnly          = .T.
795:                 loc_oCombo.Format            = "K"
796:                 loc_oCombo.Sorted            = .F.
797:                 loc_oCombo.SpecialEffect     = 0
798:                 loc_oCombo.Width             = (loc_nTamanho * 7 + 9) + 20
799:                 loc_oCombo.Height            = 25
800:                 loc_oCombo.Top               = 5

*-- Linhas 814 a 922:
814:         CATCH TO loc_oErro
815:             MsgErro(loc_oErro.Message + CHR(13) + ;
816:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
817:                 "Procedure: " + loc_oErro.Procedure, "Erro em PopularComboChaves")
818:         ENDTRY
819:     ENDPROC
820: 
821:     *==========================================================================
822:     * MGeraGrafico - Equivalente ao mgeragrafico legado (LParameters
823:     * lnLinhaCmb1): popula o combo de chaves na PRIMEIRA chamada
824:     * (PopularComboChaves, guardado pelo proprio ListCount), valida a linha
825:     * recebida (ValidarLinhaChave - gate "If .cntGrf2.cmbChave1.ListCount>0"
826:     * do legado), pede ao BO os dados da chave selecionada
827:     * (this_oBusinessObject.GerarGrafico) e, se OK, desenha o MSGraph.Chart
828:     * no OleBoundControl (DesenharGrafico).
829:     *
830:     * Fonte UNICA de geracao - chamado por ExecutarCargaInicial() (migracao
831:     * do ".mGeraGrafico()" dentro do Init legado) e por CboChave1Click()
832:     * (migracao do ".mGeraGrafico(.cntGrf2.cmbChave1.ListIndex)" dentro do
833:     * Click legado do combo), sem duplicar a logica nos dois lugares.
834:     *==========================================================================
835:     PROTECTED PROCEDURE MGeraGrafico(par_nLinha)
836:         LOCAL loc_nLinha, loc_cChave, loc_lResultado, loc_oErro
837: 
838:         loc_lResultado = .F.
839: 
840:         TRY
841:             THIS.PopularComboChaves()
842: 
843:             loc_nLinha = THIS.ValidarLinhaChave(par_nLinha)
844: 
845:             IF loc_nLinha > 0
846:                 loc_cChave = THIS.ObterChaveSelecionada(loc_nLinha)
847: 
848:                 IF !EMPTY(loc_cChave)
849:                     IF THIS.this_oBusinessObject.GerarGrafico(loc_cChave)
850:                         loc_lResultado = THIS.DesenharGrafico()
851:                     ENDIF
852:                 ENDIF
853:             ENDIF
854:         CATCH TO loc_oErro
855:             MsgErro(loc_oErro.Message + CHR(13) + ;
856:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
857:                 "Procedure: " + loc_oErro.Procedure, "Erro em MGeraGrafico")
858:         ENDTRY
859: 
860:         RETURN loc_lResultado
861:     ENDPROC
862: 
863:     *==========================================================================
864:     * DesenharGrafico - Renderiza o grafico (MSGraph.Chart) no
865:     * OleBoundControl para a chave que this_oBusinessObject.GerarGrafico() ja
866:     * calculou. Mantem this_cCursorOleGrafico ("cursor_4c_OleGrafico1"),
867:     * cache LOCAL do binario do grafico por chave - equivalente ao crGrafico1
868:     * do legado (gGrafico1s g(4)/cChave1s c(100)/cempresas c(254)/
869:     * ctitulo1s c(128)). O BO nao guarda esse binario (PILAR 3: BO nao
870:     * manipula OLE) - so o texto (labels/series), ja em
871:     * this_oBusinessObject.this_cLabelsMeses/this_cSerieFalha/
872:     * this_cSerieRecuperacao.
873:     *
874:     * Transcricao de mgeragrafico legado (linhas 486-634 do dump): Locate
875:     * por chave no cursor de cache -> achou (cache hit) => so reposiciona o
876:     * registro corrente e faz Refresh (o ControlSource fixo em
877:     * "<cursor>.gGrafico1s" reflete o registro corrente); nao achou => monta
878:     * o General a partir das series do BO (mesmo layout Data() do legado:
879:     * lcStrg1+CRLF+lcStrg2+CRLF+lcStrg3 = this_cLabelsMeses/this_cSerieFalha/
880:     * this_cSerieRecuperacao) e aplica toda a formatacao do chart.
881:     *==========================================================================
882:     PROTECTED PROCEDURE DesenharGrafico()
883:         LOCAL loc_oBO, loc_oOle, loc_cChavePad, loc_cDataChart, loc_nGrupo, ;
884:               loc_nMes, loc_lResultado, loc_lFalhaOle, loc_oErro, loc_oErroOle
885: 
886:         loc_lResultado = .F.
887:         loc_lFalhaOle  = .F.
888:         loc_oBO        = THIS.this_oBusinessObject
889:         loc_oOle       = THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
890: 
891:         TRY
892:             IF !USED(THIS.this_cCursorOleGrafico)
893:                 CREATE CURSOR (THIS.this_cCursorOleGrafico) ;
894:                     (gGrafico1s G(4), cChave1s C(100), cEmpresas C(254), cTitulo1s C(128))
895:                 INDEX ON cChave1s TAG cChave1s
896:             ENDIF
897: 
898:             loc_cChavePad = PADR(ALLTRIM(loc_oBO.this_cChaveAtual), 100)
899: 
900:             SELECT (THIS.this_cCursorOleGrafico)
901:             LOCATE FOR cChave1s == loc_cChavePad
902: 
903:             IF !FOUND()
904:                 loc_cDataChart = loc_oBO.this_cLabelsMeses + CHR(13) + CHR(10) + ;
905:                     loc_oBO.this_cSerieFalha + CHR(13) + CHR(10) + ;
906:                     loc_oBO.this_cSerieRecuperacao
907: 
908:                 *-- INSERT/APPEND GENERAL isolados num TRY proprio: se o OLE
909:                 *-- server "MSGraph.Chart" nao estiver registrado na maquina
910:                 *-- (medido: OLE error 0x800401f3 "Cadeia de caracteres de
911:                 *-- classe invalida"), a linha de cache JA FOI inserida antes
912:                 *-- do APPEND GENERAL estourar - sem desfazer, a PROXIMA
913:                 *-- chamada para a MESMA chave acharia essa linha via LOCATE
914:                 *-- (FOUND()=.T.) e trataria como cache HIT, nunca mais
915:                 *-- tentando desenhar (gGrafico1s ficaria para sempre vazio,
916:                 *-- sem erro nenhum). Por isso a linha eh apagada no CATCH.
917:                 TRY
918:                     INSERT INTO (THIS.this_cCursorOleGrafico) (cChave1s, cTitulo1s, cEmpresas) ;
919:                         VALUES (loc_cChavePad, LEFT(loc_oBO.this_cTitulo1, 128), loc_oBO.this_cEmpresaAtual)
920: 
921:                     APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" DATA (loc_cDataChart)
922:                 CATCH TO loc_oErroOle

*-- Linhas 1079 a 1412:
1079:         CATCH TO loc_oErro
1080:             MsgErro(loc_oErro.Message + CHR(13) + ;
1081:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1082:                 "Procedure: " + loc_oErro.Procedure, "Erro em DesenharGrafico")
1083:         ENDTRY
1084: 
1085:         RETURN loc_lResultado
1086:     ENDPROC
1087: 
1088:     *==========================================================================
1089:     * ValidarLinhaChave - Guarda que o legado aplica ao indice do combo antes
1090:     * de usa-lo, transcrita do mGeraGrafico (duas linhas, nao uma):
1091:     *
1092:     *   m.lnLinhaCmb1 = Iif((Type('m.lnLinhaCmb1')=='N'.And.m.lnLinhaCmb1>0), ;
1093:     *                        m.lnLinhaCmb1,1)
1094:     *   ...
1095:     *   If .cntGrf2.cmbChave1.ListCount>0
1096:     *
1097:     * Devolve 0 quando o combo ainda nao tem item nenhum (gate do ListCount:
1098:     * nada a selecionar, nada a gerar) e, quando tem, o indice normalizado -
1099:     * valor nao numerico ou <= 0 vira 1, exatamente como o Iif do legado.
1100:     *
1101:     * Sem TRY/CATCH de proposito: so le propriedades do proprio combo e faz
1102:     * aritmetica; quem chama (CboChave1Click) ja roda dentro de TRY/CATCH.
1103:     *==========================================================================
1104:     PROCEDURE ValidarLinhaChave(par_nLinha)
1105:         LOCAL loc_nLinha, loc_nTotal
1106: 
1107:         loc_nTotal = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount
1108: 
1109:         IF VARTYPE(loc_nTotal) != "N" OR loc_nTotal <= 0
1110:             RETURN 0
1111:         ENDIF
1112: 
1113:         loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" AND par_nLinha > 0, par_nLinha, 1)
1114: 
1115:         RETURN loc_nLinha
1116:     ENDPROC
1117: 
1118:     *==========================================================================
1119:     * ObterChaveSelecionada - Le o item do combo correspondente a linha ja
1120:     * validada. Transcricao de "m.lcChave1 =
1121:     * .cntGrf2.cmbChave1.List(m.lnLinhaCmb1)" do mGeraGrafico legado.
1122:     *
1123:     * O BETWEEN protege o .List() de indice fora de faixa - no legado esse
1124:     * caso caia no "On Error m.llError = .f." que o mGeraGrafico instala e
1125:     * seguia em silencio; aqui devolve string vazia e o chamador simplesmente
1126:     * nao gera grafico, sem alterar valor nenhum.
1127:     *
1128:     * ALLTRIM aqui casa com o contrato do BO: os itens do combo sao gravados
1129:     * com PadR (mGeraGrafico legado) e SigPrGf2BO.GerarGrafico compara com
1130:     * ALLTRIM dos dois lados (ALLTRIM(cEmps) == ALLTRIM(par_cChave)).
1131:     *==========================================================================
1132:     PROCEDURE ObterChaveSelecionada(par_nLinha)
1133:         LOCAL loc_cChave, loc_oCombo
1134: 
1135:         loc_cChave = ""
1136:         loc_oCombo = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1
1137: 
1138:         IF VARTYPE(par_nLinha) = "N" AND BETWEEN(par_nLinha, 1, loc_oCombo.ListCount)
1139:             loc_cChave = ALLTRIM(loc_oCombo.List(par_nLinha))
1140:         ENDIF
1141: 
1142:         RETURN loc_cChave
1143:     ENDPROC
1144: 
1145:     *==========================================================================
1146:     * CboChave1Click - Handler do Click do combo "Grupo / Vendedor :".
1147:     * Transcricao do PROCEDURE Click legado (SIGPRGF2.cntGrf2.cmbChave1):
1148:     *
1149:     *   .cntAguarde.Visible = .t. / .Refresh / .Draw / .LockScreen = .t.
1150:     *   .SetAll('Enabled',.f.,'Oleboundcontrol')
1151:     *   .mGeraGrafico(.cntGrf2.cmbChave1.ListIndex)
1152:     *   .cntGrf2.cmbChave1.SetFocus
1153:     *   .cntAguarde.Visible = .f. / .Refresh / .Draw / .LockScreen = .f.
1154:     *
1155:     * A parte de DADOS do mGeraGrafico eh SigPrGf2BO.GerarGrafico (completo
1156:     * desde a Fase 2); a parte de DESENHO (Append General + ControlSource do
1157:     * OleBoundControl + propriedades do MSGraph) entra na Fase 7/8.
1158:     *
1159:     * PUBLIC (sem PROTECTED): exigencia do BINDEVENT.
1160:     *
1161:     * A mensagem de falha eh exibida DEPOIS do ENDTRY, com a tela ja
1162:     * destravada - dialogo aberto com LockScreen = .T. deixa a janela
1163:     * congelada por tras. O LockScreen = .F. mora no FINALLY para valer
1164:     * tambem quando o CATCH dispara.
1165:     *==========================================================================
1166:     PROCEDURE CboChave1Click()
1167:         LOCAL loc_cAviso, loc_oErro
1168: 
1169:         loc_cAviso = ""
1170: 
1171:         TRY
1172:             THIS.cnt_4c_Aguarde.Visible = .T.
1173:             THIS.Refresh()
1174:             THIS.Draw()
1175:             THIS.LockScreen = .T.
1176: 
1177:             *-- Legado: .SetAll('Enabled',.f.,'Oleboundcontrol') - congela o
1178:             *-- grafico atual enquanto o novo eh calculado.
1179:             THIS.SetAll("Enabled", .F., "OleBoundControl")
1180: 
1181:             *-- Legado: .mGeraGrafico(.cntGrf2.cmbChave1.ListIndex) - fonte
1182:             *-- unica com ExecutarCargaInicial() (ver MGeraGrafico acima).
1183:             IF !THIS.MGeraGrafico(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
1184:                 loc_cAviso = THIS.this_oBusinessObject.this_cMensagemErro
1185:             ENDIF
1186: 
1187:             THIS.cnt_4c_Aguarde.Visible = .F.
1188:             THIS.Refresh()
1189:             THIS.Draw()
1190: 
1191:             *-- SetFocus so com o container visivel e o combo habilitado -
1192:             *-- SetFocus em controle invisivel/desabilitado dispara erro.
1193:             IF THIS.cnt_4c_Grf2.Visible AND ;
1194:                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Visible AND ;
1195:                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled
1196:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
1197:             ENDIF
1198:         CATCH TO loc_oErro
1199:             MsgErro(loc_oErro.Message + CHR(13) + ;
1200:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1201:                 "Procedure: " + loc_oErro.Procedure, "Erro em CboChave1Click")
1202:         FINALLY
1203:             THIS.LockScreen = .F.
1204:         ENDTRY
1205: 
1206:         IF !EMPTY(loc_cAviso)
1207:             MsgAviso(loc_cAviso, "Gr" + CHR(225) + "fico")
1208:         ENDIF
1209:     ENDPROC
1210: 
1211:     *==========================================================================
1212:     * CboChave1GotFocus - Handler do GotFocus do combo. Transcricao literal do
1213:     * PROCEDURE GotFocus legado, que tem UMA linha:
1214:     *
1215:     *   ThisForm.SetAll('Enabled',.f.,'Oleboundcontrol')
1216:     *
1217:     * PUBLIC (sem PROTECTED): exigencia do BINDEVENT.
1218:     *==========================================================================
1219:     PROCEDURE CboChave1GotFocus()
1220:         LOCAL loc_oErro
1221: 
1222:         TRY
1223:             THIS.SetAll("Enabled", .F., "OleBoundControl")
1224:         CATCH TO loc_oErro
1225:             MsgErro(loc_oErro.Message + CHR(13) + ;
1226:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1227:                 "Procedure: " + loc_oErro.Procedure, "Erro em CboChave1GotFocus")
1228:         ENDTRY
1229:     ENDPROC
1230: 
1231:     *==========================================================================
1232:     * BtnGraficoClick - Buttons(1) "Grafico" do obj_4c_CmdgGrafico. Transcricao
1233:     * do cmdImprimir.Click legado:
1234:     *
1235:     *   Local lnRecno1
1236:     *   With ThisForm
1237:     *       .LockScreen = .t.
1238:     *       m.lnRecno1 = RecNo('crGrafico1')
1239:     *       Select ('crGrafico1')
1240:     *       Report Form SigPrGf1 Next 1 To Printer Prompt Noconsole
1241:     *       If BetWeen(m.lnRecno1,1,RecCount('crGrafico1'))
1242:     *           GoTo m.lnRecno1 In ('crGrafico1')
1243:     *       EndIf
1244:     *       .cntGrf2.cmbChave1.SetFocus
1245:     *       .Refresh / .Draw / .LockScreen = .f.
1246:     *   EndWith
1247:     *
1248:     * crGrafico1 -> this_cCursorOleGrafico (cursor_4c_OleGrafico1, criado em
1249:     * DesenharGrafico()). Guard IF FILE(...) antes do REPORT FORM (regra
1250:     * CLAUDE.md sobre .Picture/.frx ausente falhar em silencio e sobre o
1251:     * helper canonico de REPORT FORM) - SigPrGf1.frx nao existe no acervo
1252:     * (nem em origem\, nem no historico do git): a impressao real so
1253:     * funciona quando o arquivo for adicionado a
1254:     * projeto\app\reports\SigPrGf1.frx; ate la o usuario ve o aviso
1255:     * descritivo em vez de um erro cru do VFP ou, peor, silencio total.
1256:     *==========================================================================
1257:     PROCEDURE BtnGraficoClick()
1258:         LOCAL loc_nRecnoAtual, loc_cFrx, loc_oErro
1259: 
1260:         TRY
1261:             THIS.LockScreen = .T.
1262: 
1263:             loc_nRecnoAtual = RECNO(THIS.this_cCursorOleGrafico)
1264: 
1265:             SELECT (THIS.this_cCursorOleGrafico)
1266: 
1267:             loc_cFrx = FULLPATH(gc_4c_CaminhoReports + "SigPrGf1.frx")
1268: 
1269:             IF !FILE(loc_cFrx)
1270:                 MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
1271:                     "o encontrado: " + loc_cFrx, "Erro")
1272:             ELSE
1273:                 REPORT FORM (gc_4c_CaminhoReports + "SigPrGf1") NEXT 1 TO PRINTER PROMPT NOCONSOLE
1274:             ENDIF
1275: 
1276:             IF BETWEEN(loc_nRecnoAtual, 1, RECCOUNT(THIS.this_cCursorOleGrafico))
1277:                 GO loc_nRecnoAtual IN (THIS.this_cCursorOleGrafico)
1278:             ENDIF
1279: 
1280:             *-- SetFocus so com o container visivel e o combo habilitado -
1281:             *-- SetFocus em controle invisivel/desabilitado dispara erro.
1282:             IF THIS.cnt_4c_Grf2.Visible AND ;
1283:                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Visible AND ;
1284:                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled
1285:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
1286:             ENDIF
1287: 
1288:             THIS.Refresh()
1289:             THIS.Draw()
1290:         CATCH TO loc_oErro
1291:             MsgErro(loc_oErro.Message + CHR(13) + ;
1292:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1293:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnGraficoClick")
1294:         FINALLY
1295:             THIS.LockScreen = .F.
1296:         ENDTRY
1297:     ENDPROC
1298: 
1299:     *==========================================================================
1300:     * BtnEncerrarClick - Buttons(2) "Encerrar" do obj_4c_CmdgGrafico.
1301:     * Transcricao do cmdSair.Click legado:
1302:     *
1303:     *   With ThisForm
1304:     *       .LockScreen = .t.
1305:     *       .cntGrf1.oleGrafico1.ControlSource = ''
1306:     *       If Used('crGrafico1')
1307:     *           Use In ('crGrafico1')
1308:     *       EndIf
1309:     *       .Release / .Refresh / .LockScreen = .f.
1310:     *       If Type('ThisForm.poForm1')=='O'
1311:     *           .poForm1.LockScreen = .t.
1312:     *           .poForm1.Enabled = .t.
1313:     *           .poForm1.LockScreen = .f.
1314:     *       EndIf
1315:     *   EndWith
1316:     *
1317:     * poForm1 -> this_oFormPai. Guard adicional (!= THIS) para o caso deste
1318:     * form ter sido aberto SEM form pai (Init: this_oFormPai = THIS quando
1319:     * par_loForm1 nao eh objeto) - nesse caso nao ha ninguem para reabilitar.
1320:     * crRel1 (cursor global do form pai) NAO eh fechado aqui - ver Destroy().
1321:     *==========================================================================
1322:     PROCEDURE BtnEncerrarClick()
1323:         LOCAL loc_oErro
1324: 
1325:         TRY
1326:             THIS.LockScreen = .T.
1327: 
1328:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1329: 
1330:             IF USED(THIS.this_cCursorOleGrafico)
1331:                 USE IN (THIS.this_cCursorOleGrafico)
1332:             ENDIF
1333: 
1334:             THIS.Release()
1335:             THIS.Refresh()
1336:             THIS.LockScreen = .F.
1337: 
1338:             IF VARTYPE(THIS.this_oFormPai) = "O" AND !(THIS.this_oFormPai == THIS)
1339:                 THIS.this_oFormPai.LockScreen = .T.
1340:                 THIS.this_oFormPai.Enabled    = .T.
1341:                 THIS.this_oFormPai.LockScreen = .F.
1342:             ENDIF
1343:         CATCH TO loc_oErro
1344:             MsgErro(loc_oErro.Message + CHR(13) + ;
1345:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1346:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnEncerrarClick")
1347:         ENDTRY
1348:     ENDPROC
1349: 
1350:     *==========================================================================
1351:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1352:     * (AddObject cria com Visible=.F. por padrao)
1353:     *
1354:     * FILTRO: cnt_4c_Grf1/cnt_4c_Grf2/cnt_4c_Aguarde sao containers flutuantes
1355:     * (Visible controlado pelo Init/mGeraGrafico e por CboChave1Click - ver
1356:     * comentarios de ConfigurarGrf1/ConfigurarGrf2/ConfigurarAguarde), nao
1357:     * pelo TornarControlesVisiveis generico. Mesmo padrao de FormSigReCmg.
1358:     *
1359:     * O skip RECURSA antes do LOOP: o LOOP preserva o Visible = .F. do
1360:     * PROPRIO container (que eh o que se quer), mas os FILHOS dele precisam
1361:     * ficar Visible = .T., senao o container aparece VAZIO quando o codigo o
1362:     * exibe (CorretorAutomatico #109). Aqui os filhos ja nascem com
1363:     * .Visible = .T. explicito nos Configurar*, e a recursao mantem isso
1364:     * verdadeiro mesmo se algum filho for acrescentado sem o .Visible.
1365:     *==========================================================================
1366:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1367:         LOCAL loc_nI, loc_oControl
1368: 
1369:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1370:             loc_oControl = par_oContainer.Controls(loc_nI)
1371: 
1372:             IF VARTYPE(loc_oControl) = "O"
1373:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_GRF1", "CNT_4C_GRF2", "CNT_4C_AGUARDE")
1374:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1375:                         THIS.TornarControlesVisiveis(loc_oControl)
1376:                     ENDIF
1377:                     LOOP
1378:                 ENDIF
1379: 
1380:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1381:                     loc_oControl.Visible = .T.
1382:                 ENDIF
1383: 
1384:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1385:                     THIS.TornarControlesVisiveis(loc_oControl)
1386:                 ENDIF
1387:             ENDIF
1388:         ENDFOR
1389:     ENDPROC
1390: 
1391:     *==========================================================================
1392:     * Destroy - Fecha this_cCursorOleGrafico (cache local do binario do OLE -
1393:     * BtnEncerrarClick ja fecha no fluxo normal, mas Destroy pode disparar por
1394:     * outro caminho, ex.: pai chamando .Release() direto em vez do botao) e
1395:     * solta a referencia do Business Object (SigPrGf2BO.Destroy() fecha
1396:     * this_cCursorChaves/this_cCursorGrafico, cursores locais que nunca tocam
1397:     * SQL Server). O cursor global "crRel1" NAO eh fechado aqui: quem o cria
1398:     * eh o form pai (FormSigPrGf1), e eh ele quem o fecha no proprio Destroy -
1399:     * fechar aqui derrubaria o cursor debaixo do pai se o usuario fechar o
1400:     * grafico e processar outro periodo em seguida.
1401:     *==========================================================================
1402:     PROCEDURE Destroy()
1403:         IF !EMPTY(THIS.this_cCursorOleGrafico) AND USED(THIS.this_cCursorOleGrafico)
1404:             USE IN (THIS.this_cCursorOleGrafico)
1405:         ENDIF
1406: 
1407:         THIS.this_oBusinessObject = .NULL.
1408: 
1409:         DODEFAULT()
1410:     ENDPROC
1411: 
1412: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGf2BO.prg):
*============================================================================
* SigPrGf2BO.prg - Business Object para "Grafico de Falha X Recuperacao
* Mensal" (SIGPRGF2)
*
* Form OPERACIONAL (SIGPRGF2 / FormSigPrGf2): tela de EXIBICAO de grafico
* (MSGraph.Chart via OleBoundControl), aberta pelo form pai (equivalente ao
* SIGPRGF1/FormSigPrGf1) que ja processou e deixou pronto um cursor agregado
* por mes (crRel1 no legado; normalmente SigPrGf1BO.this_cCursorResultado no
* sistema novo). O SIGPRGF2 nao processa dados novos contra o banco - ele so
* agrupa/formata o que ja veio no cursor de origem, monta as series do
* grafico (Falha/Recuperacao) por mes e mantem um cache por chave (empresa)
* para nao recalcular ao trocar no combo.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server, so agrega o cursor de origem.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrGf2BO AS BusinessBase

    *==========================================================================
    * Cursor de origem (crRel1 do legado) - resultado agregado por mes,
    * fornecido pelo form pai. NAO e populado por este BO; apenas consultado
    * (Select Distinct .../ Scan While ... do mGeraGrafico legado).
    *==========================================================================
    this_cCursorOrigem = ""

    *==========================================================================
    * Cursor com as chaves distintas do cursor de origem, para popular o
    * combo "Grupo / Vendedor :" (cmbChave1 - equivalente a "Select Distinct
    * a.cEmps From crRel1 a Order By 1 Into Array laVendedor" do legado).
    * Usamos cursor em vez de ARRAY para nao depender de escopo de m.array.
    *==========================================================================
    this_cCursorChaves = ""

    *==========================================================================
    * Cursor cache dos graficos ja gerados por chave (equivalente a
    * crGrafico1: gGrafico1s g(4)/cChave1s c(100)/cempresas c(254)/
    * ctitulo1s c(128)). A parte binaria do OLE (Append General ... Class
    * 'MSGraph.Chart') e responsabilidade do Form (glue com o OleBoundControl);
    * este BO cuida so da chave/titulos/series text-based.
    *==========================================================================
    this_cCursorGrafico = ""

    *==========================================================================
    * Chave (empresa) atualmente selecionada no combo (cChave1s do legado)
    *==========================================================================
    this_cChaveAtual = ""

    *==========================================================================
    * Titulos do grafico da chave atual (cTitulo1s/ctitulo2s do cursor de
    * origem - mGeraGrafico monta m.lcTitulo1 = AllTrim(cTitulo1s) + Chr(13)
    * + AllTrim(ctitulo2s))
    *==========================================================================
    this_cTitulo1      = ""
    this_cTitulo2      = ""
    this_cEmpresaAtual = ""

    *==========================================================================
    * Series do grafico (lnNgrupos fixo = 2: Falha e Recuperacao) e a
    * contagem de meses agregados na chave atual (lnNmeses)
    *==========================================================================
    this_nTotalGrupos = 2
    this_nTotalMeses  = 0

    *==========================================================================
    * Strings TAB-separadas com rotulos de mes e valores das duas series
    * (lcStrg1/lcStrg2/lcStrg3 do mGeraGrafico legado). O Form usa essas
    * strings para montar o Data() do Append General no OleBoundControl.
    *==========================================================================
    this_cLabelsMeses      = ""
    this_cSerieFalha       = ""
    this_cSerieRecuperacao = ""

    *==========================================================================
    * Flags de estado
    *==========================================================================
    this_lChaveEmCache  = .F.  && .T. quando a chave ja tinha grafico no cache (Locate achou)
    this_lGraficoGerado = .F.  && .T. quando ha dados validos para desenhar o grafico

    *==========================================================================
    * Init - Nao ha tabela proprietaria (form so exibe/agrega o que o form
    * pai processou), entao this_cTabela/this_cCampoChave ficam vazios.
    * Inicializa os nomes canonicos dos cursores de trabalho deste BO.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cCursorChaves  = "cursor_4c_Chaves"
            THIS.this_cCursorGrafico = "cursor_4c_Grafico"

            THIS.this_nTotalGrupos = 2
            THIS.this_nTotalMeses  = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Decisao de arquitetura (Fase 2 - CRUD): SIGPRGF2 eh um VISUALIZADOR de
    * grafico (Falha X Recuperacao Mensal) que so agrega/formata o cursor de
    * origem (crRel1 no legado, this_cCursorOrigem aqui) recebido do form pai
    * (equivalente ao SigPrGf1). O dump do legado nao tem NENHUM Insert
    * Into/Update/Delete From contra tabela do SQL Server: o unico Insert Into
    * do metodo mgeragrafico grava no cursor LOCAL crGrafico1 (cache de
    * graficos ja montados por chave), que aqui vira THIS.this_cCursorGrafico
    * dentro de GerarGrafico(). CarregarDoCursor() mapeia as colunas desse
    * cache; Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos
    * neste BO porque o comportamento padrao herdado de BusinessBase (recusar
    * a operacao) ja eh o correto para um BO sem tabela proprietaria.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia uma linha do cursor de cache de graficos
    * (this_cCursorGrafico, layout identico ao crGrafico1 legado) para as
    * propriedades do BO. Usado apos LOCATE/SEEK em GerarGrafico() ou por
    * quem precisar inspecionar uma linha ja posicionada do cache.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cChaveAtual      = ALLTRIM(TratarNulo(cChave1s, ""))
            THIS.this_cEmpresaAtual    = TratarNulo(cEmpresas, "")
            THIS.this_cTitulo1         = TratarNulo(cTitulo1s, "")
            THIS.this_cLabelsMeses     = TratarNulo(cLabelsMeses, "")
            THIS.this_cSerieFalha      = TratarNulo(cSerieFalha, "")
            THIS.this_cSerieRecuperacao = TratarNulo(cSerieRecuperacao, "")
            THIS.this_nTotalMeses      = OCCURS(CHR(9), THIS.this_cLabelsMeses)

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do grafico atualmente selecionado (equivalente
    * ao cChave1s do cache legado). Nao ha tabela proprietaria neste BO; a
    * chave existe so para identificar a linha do cache de graficos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChaveAtual)
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularChaves - Monta THIS.this_cCursorChaves com as chaves distintas do
    * cursor de origem (equivalente a "Select Distinct a.cEmps From crRel1
    * Order By 1 Into Array laVendedor" do mGeraGrafico legado). O Form usa
    * este cursor para popular o combo "Grupo / Vendedor :" (cmbChave1).
    *--------------------------------------------------------------------------
    PROCEDURE PopularChaves()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorChaves)
                    USE IN (THIS.this_cCursorChaves)
                ENDIF

                SELECT DISTINCT ALLTRIM(cEmps) AS Chaves ;
                    FROM (THIS.this_cCursorOrigem) ;
                    ORDER BY 1 ;
                    INTO CURSOR (THIS.this_cCursorChaves) READWRITE

                IF RECCOUNT(THIS.this_cCursorChaves) > 0
                    GO TOP IN (THIS.this_cCursorChaves)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarGrafico - Equivalente ao mGeraGrafico legado (parte de dados: o
    * desenho do OLE/MSGraph.Chart fica por conta do Form). Se a chave ja
    * esta no cache (this_cCursorGrafico), so recarrega as propriedades a
    * partir dele (LOCATE, igual ao "Locate For crGrafico1.cChave1s==..." do
    * legado). Senao, varre this_cCursorOrigem (equivalente ao "Scan While
    * crRel1.cEmps==m.lcChave1" do legado), monta os rotulos de mes e as duas
    * series (Falha/Recuperacao) separados por TAB e grava a linha nova no
    * cache - so entao Insert Into acontece, e sempre no cursor LOCAL, nunca
    * no SQL Server.
    *--------------------------------------------------------------------------
    PROCEDURE GerarGrafico(par_cChave)
        LOCAL loc_lResultado, loc_oErro, loc_cChavePad, loc_cTitulo1, ;
              loc_cEmpresa, loc_cLabelsMeses, loc_cSerieFalha, ;
              loc_cSerieRecuperacao, loc_nMeses, loc_cPointAntigo, ;
              loc_cSeparAntigo

        loc_lResultado           = .F.
        THIS.this_lChaveEmCache  = .F.
        THIS.this_lGraficoGerado = .F.

        TRY
            IF EMPTY(par_cChave) OR !USED(THIS.this_cCursorOrigem)
                THIS.this_cMensagemErro = "Chave n" + CHR(227) + "o informada ou cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cChavePad = PADR(ALLTRIM(par_cChave), 100)
                THIS.this_cChaveAtual = ALLTRIM(par_cChave)

                IF !USED(THIS.this_cCursorGrafico)
                    CREATE CURSOR (THIS.this_cCursorGrafico) ;
                        (cChave1s C(100), cEmpresas C(254), cTitulo1s M, ;
                         cLabelsMeses M, cSerieFalha M, cSerieRecuperacao M)
                    INDEX ON cChave1s TAG cChave1s
                ENDIF

                SELECT (THIS.this_cCursorGrafico)
                LOCATE FOR cChave1s == loc_cChavePad

                IF FOUND()
                    THIS.this_lChaveEmCache     = .T.
                    THIS.this_cEmpresaAtual     = TratarNulo(cEmpresas, "")
                    THIS.this_cTitulo1          = TratarNulo(cTitulo1s, "")
                    * cTitulo2s nao existe no cache (crGrafico1 legado so guarda
                    * o titulo ja concatenado) - fica vazio ate a proxima geracao
                    THIS.this_cTitulo2          = ""
                    THIS.this_cLabelsMeses      = TratarNulo(cLabelsMeses, "")
                    THIS.this_cSerieFalha       = TratarNulo(cSerieFalha, "")
                    THIS.this_cSerieRecuperacao = TratarNulo(cSerieRecuperacao, "")
                    THIS.this_nTotalMeses       = OCCURS(CHR(9), THIS.this_cLabelsMeses)
                    THIS.this_lGraficoGerado    = .T.
                    loc_lResultado = .T.
                ELSE
                    SELECT (THIS.this_cCursorOrigem)
                    LOCATE FOR ALLTRIM(cEmps) == ALLTRIM(par_cChave)

                    IF !FOUND()
                        THIS.this_cMensagemErro = "Nenhum registro encontrado para a chave [" + ALLTRIM(par_cChave) + "]."
                    ELSE
                        loc_cTitulo1 = ALLTRIM(cTitulo1s) + CHR(13) + ALLTRIM(cTitulo2s)
                        THIS.this_cTitulo2 = ALLTRIM(TratarNulo(cTitulo2s, ""))
                        loc_cEmpresa = TratarNulo(cEmpresas, "")

                        loc_cLabelsMeses      = ""
                        loc_cSerieFalha       = "Falha"
                        loc_cSerieRecuperacao = "Recupera" + CHR(231) + CHR(227) + "o"
                        loc_nMeses = 0

                        * Isolamento de locale igual ao mGeraGrafico legado -
                        * TRANSFORM abaixo usa picture fixa "999,999,999.99"
                        loc_cPointAntigo = SET("POINT")
                        loc_cSeparAntigo = SET("SEPARATOR")
                        SET POINT TO ","
                        SET SEPARATOR TO "."

                        TRY
                            SCAN WHILE ALLTRIM(cEmps) == ALLTRIM(par_cChave)
                                loc_nMeses = loc_nMeses + 1
                                loc_cLabelsMeses      = loc_cLabelsMeses + CHR(9) + ALLTRIM(TratarNulo(cStranomes, ""))
                                loc_cSerieFalha       = loc_cSerieFalha + CHR(9) + ALLTRIM(TRANSFORM(NVL(nFalhas, 0), "999,999,999.99"))
                                loc_cSerieRecuperacao = loc_cSerieRecuperacao + CHR(9) + ALLTRIM(TRANSFORM(NVL(nPesoccbs, 0), "999,999,999.99"))
                            ENDSCAN
                        FINALLY
                            SET POINT TO (loc_cPointAntigo)
                            SET SEPARATOR TO (loc_cSeparAntigo)
                        ENDTRY

                        SELECT (THIS.this_cCursorGrafico)
                        INSERT INTO (THIS.this_cCursorGrafico) ;
                            (cChave1s, cEmpresas, cTitulo1s, cLabelsMeses, cSerieFalha, cSerieRecuperacao) ;
                            VALUES (loc_cChavePad, loc_cEmpresa, loc_cTitulo1, loc_cLabelsMeses, loc_cSerieFalha, loc_cSerieRecuperacao)

                        THIS.this_cTitulo1          = loc_cTitulo1
                        THIS.this_cEmpresaAtual     = loc_cEmpresa
                        THIS.this_cLabelsMeses      = loc_cLabelsMeses
                        THIS.this_cSerieFalha       = loc_cSerieFalha
                        THIS.this_cSerieRecuperacao = loc_cSerieRecuperacao
                        THIS.this_nTotalMeses       = loc_nMeses
                        THIS.this_lChaveEmCache     = .F.
                        THIS.this_lGraficoGerado    = .T.
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais deste BO (nunca tocam SQL Server)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cCursorChaves) AND USED(THIS.this_cCursorChaves)
            USE IN (THIS.this_cCursorChaves)
        ENDIF

        IF !EMPTY(THIS.this_cCursorGrafico) AND USED(THIS.this_cCursorGrafico)
            USE IN (THIS.this_cCursorGrafico)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

