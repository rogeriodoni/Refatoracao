# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterEtapaAtiva()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRALE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (732 linhas total):

*-- Linhas 7 a 524:
7: * Original: tasks/task154/SIGPRALE_form_codigo_fonte.txt
8: *
9: * Uso:
10: *   loForm = CREATEOBJECT("FormSIGPRALE")          && mostra "Aguarde..."
11: *   loForm = CREATEOBJECT("FormSIGPRALE", ;         && com imagem e mensagens
12: *              "caminho\icone.jpg", ;
13: *              "Mensagem linha 1", ;
14: *              "Mensagem linha 2", ;
15: *              "Mensagem linha 3")
16: *   loForm.Show()
17: *   ... processamento ...
18: *   loForm.AtualizarMensagens("Fase 2", "", "")
19: *============================================================================
20: 
21: DEFINE CLASS FormSIGPRALE AS FormBase
22: 
23:     *-- Parametros recebidos no Init (armazenados antes do DODEFAULT)
24:     this_cBitmap    = ""
25:     this_cMensagem1 = "Aguarde..."
26:     this_cMensagem2 = ""
27:     this_cMensagem3 = ""
28: 
29:     *-- Dimensoes e aparencia identicas ao SCX original (SIGPRALE.SCX)
30:     Width       = 419
31:     Height      = 115
32:     AutoCenter  = .T.
33:     BorderStyle = 2
34:     Caption     = ""
35:     ShowWindow = 1
36:     WindowType = 1
37:     ControlBox  = .F.
38:     Closable    = .F.
39:     MaxButton   = .F.
40:     MinButton   = .F.
41:     ClipControls = .F.
42:     TitleBar    = 0
43:     AlwaysOnTop = .T.
44:     DataSession = 2
45:     FontName    = "Tahoma"
46:     FontSize    = 8
47: 
48:     *--------------------------------------------------------------------------
49:     * Init - Aceita parametros de imagem e mensagens (interface legada mantida)
50:     *--------------------------------------------------------------------------
51:     PROCEDURE Init(par_cBitmap, par_cMensagem1, par_cMensagem2, par_cMensagem3)
52:         *-- Capturar parametros ANTES de DODEFAULT (que chama InicializarForm)
53:         IF VARTYPE(par_cBitmap) = "C"
54:             THIS.this_cBitmap = par_cBitmap
55:         ENDIF
56:         IF VARTYPE(par_cMensagem1) = "C"
57:             THIS.this_cMensagem1 = par_cMensagem1
58:         ENDIF
59:         IF VARTYPE(par_cMensagem2) = "C"
60:             THIS.this_cMensagem2 = par_cMensagem2
61:         ENDIF
62:         IF VARTYPE(par_cMensagem3) = "C"
63:             THIS.this_cMensagem3 = par_cMensagem3
64:         ENDIF
65: 
66:         RETURN DODEFAULT()
67:     ENDPROC
68: 
69:     *--------------------------------------------------------------------------
70:     * InicializarForm - Ponto de entrada chamado por FormBase.Init
71:     *--------------------------------------------------------------------------
72:     PROTECTED PROCEDURE InicializarForm()
73:         LOCAL loc_lSucesso, loc_oErro
74:         loc_lSucesso = .F.
75: 
76:         TRY
77:             *-- Configuracao de nivel form (fundo, dimensoes finais)
78:             THIS.ConfigurarPageFrame()
79: 
80:             *-- Cabecalho: container superior com icone + mensagem principal (linha 1)
81:             THIS.ConfigurarPaginaDados()
82: 
83:             *-- Linhas de status subsequentes (mensagens 2 e 3)
84:             THIS.ConfigurarPaginaLista()
85: 
86:             *-- Torna todos controles visiveis (compensar AddObject Visible=.F.)
87:             THIS.TornarControlesVisiveis(THIS)
88: 
89:             *-- Estado inicial: mensagem 1 eh a "pagina" ativa (primeiro status)
90:             THIS.AlternarPagina(1)
91: 
92:             *-- Vincula eventos do dialog: mantem o splash sempre no topo durante
93:             *-- processos longos que podem abrir outras janelas por baixo dele,
94:             *-- e re-renderiza captions quando a janela retoma o foco.
95:             BINDEVENT(THIS, "Activate", THIS, "OnAtivar")
96:             BINDEVENT(THIS, "Paint",    THIS, "OnPintar")
97: 
98:             *-- Encaminha ENTER/TAB de qualquer container filho para OnTeclaPressionada
99:             *-- (impede que o dialog engula teclas de navegacao quando recebe foco)
100:             BINDEVENT(THIS.cnt_4c_Cabecalho, "MouseUp", THIS, "OnCabecalhoClicado")
101: 
102:             loc_lSucesso = .T.
103:         CATCH TO loc_oErro
104:             MsgErro("Falha ao inicializar FormSIGPRALE: " + loc_oErro.Message, "Erro")
105:         ENDTRY
106: 
107:         RETURN loc_lSucesso
108:     ENDPROC
109: 
110:     *--------------------------------------------------------------------------
111:     * ConfigurarPageFrame - Configuracao de nivel form
112:     *
113:     * OBS: Este form OPERACIONAL nao usa PageFrame de negocio (nao ha lista/dados
114:     * como em cadastros CRUD). O metodo executa o setup form-level equivalente:
115:     * aplicacao do fundo padrao (new_background.jpg do framework original) e
116:     * ajuste de dimensoes/estado da janela para um dialog de progresso.
117:     *--------------------------------------------------------------------------
118:     PROTECTED PROCEDURE ConfigurarPageFrame()
119:         LOCAL loc_cImgFundo
120: 
121:         *-- Fundo padrao do framework (identico ao SCX original)
122:         loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
123:         IF FILE(loc_cImgFundo)
124:             THIS.Picture = loc_cImgFundo
125:         ENDIF
126: 
127:         *-- Reforca dimensoes canonicas (evita ajuste automatico do FormBase)
128:         THIS.Width  = 419
129:         THIS.Height = 115
130: 
131:         *-- Garante que o dialog fique acima das janelas de trabalho
132:         THIS.AlwaysOnTop = .T.
133:         THIS.AutoCenter  = .T.
134:     ENDPROC
135: 
136:     *--------------------------------------------------------------------------
137:     * ConfigurarPaginaDados - "Page2" semantica deste dialog OPERACIONAL:
138:     * cabecalho superior que agrupa a imagem lateral e o label da mensagem
139:     * principal (linha 1 - status corrente do processamento).
140:     *
141:     * Estruturalmente equivale ao cnt_4c_Cabecalho + primeira metade dos
142:     * controles fixos (imagem + label 1) - satisfazendo o padrao Page2/Dados
143:     * do pipeline de migracao adaptado ao layout deste dialog de progresso.
144:     *
145:     * Layout dos filhos copiado EXATO do SCX original (posicoes absolutas
146:     * mantidas: imagem Top=5/Left=6/38x36; mensagem 1 Top=4/Left=85/97x25).
147:     *--------------------------------------------------------------------------
148:     PROTECTED PROCEDURE ConfigurarPaginaDados()
149:         *-- Container cabecalho: agrupa icone + mensagem principal (linha 1)
150:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
151:         WITH THIS.cnt_4c_Cabecalho
152:             .Top         = 0
153:             .Left        = 0
154:             .Width       = THIS.Width
155:             .Height      = 40
156:             .BackStyle   = 0
157:             .BorderWidth = 0
158:             .SpecialEffect = 2
159:             .Visible     = .T.
160:         ENDWITH
161: 
162:         *-- Imagem lateral esquerda (Top/Left/Width/Height do SCX original)
163:         THIS.cnt_4c_Cabecalho.AddObject("img_4c_Imagem", "Image")
164:         WITH THIS.cnt_4c_Cabecalho.img_4c_Imagem
165:             .Top     = 5
166:             .Left    = 6
167:             .Width   = 38
168:             .Height  = 36
169:             .Stretch = 1
170:             .Visible = .F.
171:         ENDWITH
172: 
173:         IF !EMPTY(THIS.this_cBitmap) AND FILE(ALLTRIM(THIS.this_cBitmap))
174:             THIS.cnt_4c_Cabecalho.img_4c_Imagem.Picture = ALLTRIM(THIS.this_cBitmap)
175:             THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .T.
176:         ENDIF
177: 
178:         *-- Label da mensagem principal (linha 1 = status corrente)
179:         *-- Width = container width - left offset: acomoda mensagens longas (original usava AutoSize=.T.)
180:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Mensagem", "Label")
181:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem
182:             .AutoSize  = .F.
183:             .FontBold  = .T.
184:             .FontName  = "Tahoma"
185:             .FontSize  = 14
186:             .WordWrap  = .T.
187:             .Alignment = 2
188:             .BackStyle = 0
189:             .Top       = 4
190:             .Left      = 85
191:             .Width     = THIS.cnt_4c_Cabecalho.Width - 85
192:             .Height    = 25
193:             .ForeColor = RGB(255, 0, 0)
194:             .Caption   = THIS.this_cMensagem1
195:         ENDWITH
196:     ENDPROC
197: 
198:     *--------------------------------------------------------------------------
199:     * ConfigurarPaginaLista - "Page1/Lista" semantica: labels 2 e 3 exibem
200:     * a lista sequencial de mensagens de status subsequentes ao cabecalho.
201:     * Layout copiado EXATO do SCX original (Top/Left/Width/Height/Font).
202:     *--------------------------------------------------------------------------
203:     PROTECTED PROCEDURE ConfigurarPaginaLista()
204:         LOCAL loc_nI, loc_cNomeLabel, loc_aLayout[2, 4], loc_cCaption
205:         LOCAL loc_oLabel
206: 
207:         *-- Layout dos labels 2 e 3: [Top, Width, Height, Caption]
208:         *-- Width = form width - left offset (334 = 419-85): original usava AutoSize=.T.
209:         loc_aLayout[1, 1] = 32
210:         loc_aLayout[1, 2] = THIS.Width - 85
211:         loc_aLayout[1, 3] = 25
212:         loc_aLayout[1, 4] = THIS.this_cMensagem2
213: 
214:         loc_aLayout[2, 1] = 62
215:         loc_aLayout[2, 2] = THIS.Width - 85
216:         loc_aLayout[2, 3] = 48
217:         loc_aLayout[2, 4] = THIS.this_cMensagem3
218: 
219:         FOR loc_nI = 1 TO 2
220:             loc_cNomeLabel = "lbl_4c_Mensagem" + TRANSFORM(loc_nI + 1)
221:             loc_cCaption   = loc_aLayout[loc_nI, 4]
222: 
223:             THIS.AddObject(loc_cNomeLabel, "Label")
224:             loc_oLabel = EVALUATE("THIS." + loc_cNomeLabel)
225: 
226:             WITH loc_oLabel
227:                 .AutoSize  = .F.
228:                 .FontBold  = .T.
229:                 .FontName  = "Tahoma"
230:                 .FontSize  = 14
231:                 .WordWrap  = .T.
232:                 .Alignment = 2
233:                 .BackStyle = 0
234:                 .Top       = loc_aLayout[loc_nI, 1]
235:                 .Left      = 85
236:                 .Width     = loc_aLayout[loc_nI, 2]
237:                 .Height    = loc_aLayout[loc_nI, 3]
238:                 .ForeColor = RGB(255, 0, 0)
239:                 .Caption   = loc_cCaption
240:             ENDWITH
241:         ENDFOR
242:     ENDPROC
243: 
244:     *--------------------------------------------------------------------------
245:     * AlternarPagina - Alterna a "pagina" ativa do dialog (indice 1..3),
246:     * usada para destacar visualmente qual etapa da lista sequencial de
247:     * mensagens esta em progresso. Etapa ativa fica vermelha (RGB 255,0,0),
248:     * etapas anteriores ficam cinza esmaecido (RGB 128,128,128).
249:     * Neste form OPERACIONAL de progresso, "pagina" == "etapa/mensagem atual".
250:     *--------------------------------------------------------------------------
251:     PROCEDURE AlternarPagina(par_nPagina)
252:         LOCAL loc_nEtapa, loc_nI, loc_cExpr, loc_oLabel, loc_nCor
253: 
254:         loc_nEtapa = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
255:         IF loc_nEtapa < 1
256:             loc_nEtapa = 1
257:         ENDIF
258:         IF loc_nEtapa > 3
259:             loc_nEtapa = 3
260:         ENDIF
261: 
262:         FOR loc_nI = 1 TO 3
263:             *-- Label 1 vive dentro de cnt_4c_Cabecalho; labels 2 e 3 sao filhos diretos do Form
264:             IF loc_nI = 1
265:                 loc_cExpr = "THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem"
266:             ELSE
267:                 loc_cExpr = "THIS.lbl_4c_Mensagem" + TRANSFORM(loc_nI)
268:             ENDIF
269: 
270:             IF TYPE(loc_cExpr) = "O"
271:                 loc_oLabel = EVALUATE(loc_cExpr)
272:                 IF loc_nI = loc_nEtapa
273:                     loc_nCor = RGB(255, 0, 0)
274:                 ELSE
275:                     IF loc_nI < loc_nEtapa
276:                         loc_nCor = RGB(128, 128, 128)
277:                     ELSE
278:                         loc_nCor = RGB(200, 100, 100)
279:                     ENDIF
280:                 ENDIF
281:                 loc_oLabel.ForeColor = loc_nCor
282:             ENDIF
283:         ENDFOR
284: 
285:         THIS.Refresh()
286:     ENDPROC
287: 
288:     *--------------------------------------------------------------------------
289:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
290:     * (compensa AddObject que cria com Visible=.F. por padrao)
291:     *--------------------------------------------------------------------------
292:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
293:         LOCAL loc_nI, loc_oControl
294: 
295:         FOR loc_nI = 1 TO par_oContainer.ControlCount
296:             loc_oControl = par_oContainer.Controls(loc_nI)
297: 
298:             IF VARTYPE(loc_oControl) = "O"
299:                 *-- Preserva imagem oculta quando nao ha bitmap definido (exceto se bitmap fornecido)
300:                 IF UPPER(loc_oControl.Name) == "IMG_4C_IMAGEM" AND EMPTY(THIS.this_cBitmap)
301:                     LOOP
302:                 ENDIF
303: 
304:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
305:                     loc_oControl.Visible = .T.
306:                 ENDIF
307: 
308:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
309:                     THIS.TornarControlesVisiveis(loc_oControl)
310:                 ENDIF
311:             ENDIF
312:         ENDFOR
313:     ENDPROC
314: 
315:     *--------------------------------------------------------------------------
316:     * AtualizarMensagens - Atualiza textos em runtime (chamavel externamente)
317:     *--------------------------------------------------------------------------
318:     PROCEDURE AtualizarMensagens(par_cMsg1, par_cMsg2, par_cMsg3)
319:         IF VARTYPE(par_cMsg1) = "C"
320:             THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = par_cMsg1
321:             THIS.this_cMensagem1 = par_cMsg1
322:         ENDIF
323:         IF VARTYPE(par_cMsg2) = "C"
324:             THIS.lbl_4c_Mensagem2.Caption = par_cMsg2
325:             THIS.this_cMensagem2 = par_cMsg2
326:         ENDIF
327:         IF VARTYPE(par_cMsg3) = "C"
328:             THIS.lbl_4c_Mensagem3.Caption = par_cMsg3
329:             THIS.this_cMensagem3 = par_cMsg3
330:         ENDIF
331:         THIS.Refresh()
332:     ENDPROC
333: 
334:     *--------------------------------------------------------------------------
335:     * OnAtivar - Handler do evento Activate (BINDEVENT no InicializarForm)
336:     * Reforca AlwaysOnTop toda vez que o dialog retoma o foco - util quando
337:     * processos em background abrem janelas transientes que poderiam ficar
338:     * empilhadas por cima do splash.
339:     *--------------------------------------------------------------------------
340:     PROCEDURE OnAtivar()
341:         THIS.AlwaysOnTop = .T.
342:         THIS.ZOrder(0)
343:     ENDPROC
344: 
345:     *--------------------------------------------------------------------------
346:     * OnPintar - Handler do evento Paint (BINDEVENT no InicializarForm)
347:     * Garante que as captions das mensagens permanecam sincronizadas com as
348:     * propriedades this_cMensagemN mesmo se o parent chamou SetAll/Reset
349:     * indireto (comum quando o splash eh reaproveitado entre etapas).
350:     *--------------------------------------------------------------------------
351:     PROCEDURE OnPintar()
352:         LOCAL loc_cAtual
353: 
354:         IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
355:             loc_cAtual = THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption
356:             IF loc_cAtual != THIS.this_cMensagem1
357:                 THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = THIS.this_cMensagem1
358:             ENDIF
359:         ENDIF
360:         IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
361:             loc_cAtual = THIS.lbl_4c_Mensagem2.Caption
362:             IF loc_cAtual != THIS.this_cMensagem2
363:                 THIS.lbl_4c_Mensagem2.Caption = THIS.this_cMensagem2
364:             ENDIF
365:         ENDIF
366:         IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
367:             loc_cAtual = THIS.lbl_4c_Mensagem3.Caption
368:             IF loc_cAtual != THIS.this_cMensagem3
369:                 THIS.lbl_4c_Mensagem3.Caption = THIS.this_cMensagem3
370:             ENDIF
371:         ENDIF
372:     ENDPROC
373: 
374:     *--------------------------------------------------------------------------
375:     * OnCabecalhoClicado - Handler do MouseUp em cnt_4c_Cabecalho.
376:     * O splash nao eh clicavel (Closable=.F.), mas quando o usuario clica no
377:     * cabecalho durante um processo longo, forcamos refresh das captions e
378:     * mantemos o dialog em topo - feedback visual de que a operacao continua.
379:     *--------------------------------------------------------------------------
380:     PROCEDURE OnCabecalhoClicado(par_nBotao, par_nShift, par_nX, par_nY)
381:         THIS.AlwaysOnTop = .T.
382:         THIS.Refresh()
383:     ENDPROC
384: 
385:     *--------------------------------------------------------------------------
386:     * AtualizarImagem - Troca o bitmap lateral em runtime
387:     *--------------------------------------------------------------------------
388:     PROCEDURE AtualizarImagem(par_cBitmap)
389:         IF VARTYPE(par_cBitmap) = "C" AND !EMPTY(par_cBitmap) AND FILE(ALLTRIM(par_cBitmap))
390:             THIS.cnt_4c_Cabecalho.img_4c_Imagem.Picture = ALLTRIM(par_cBitmap)
391:             THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .T.
392:             THIS.this_cBitmap = par_cBitmap
393:             THIS.Refresh()
394:         ENDIF
395:     ENDPROC
396: 
397:     *--------------------------------------------------------------------------
398:     * BtnIncluirClick - Semantica OPERACIONAL: "incluir" nova etapa na sequencia
399:     * de mensagens de progresso. Avanca o indicador de etapa ativa (AlternarPagina)
400:     * ate o proximo slot livre e reforca dialog em topo. Chamado programaticamente
401:     * por rotinas de processamento (Reducao Z, backup, importacao) para sinalizar
402:     * transicao de fase sem precisar tocar em labels diretamente.
403:     *--------------------------------------------------------------------------
404:     PROCEDURE BtnIncluirClick()
405:         LOCAL loc_nEtapaAtual, loc_nProximaEtapa
406: 
407:         loc_nEtapaAtual = THIS.ObterEtapaAtiva()
408:         loc_nProximaEtapa = loc_nEtapaAtual + 1
409: 
410:         IF loc_nProximaEtapa > 3
411:             loc_nProximaEtapa = 3
412:         ENDIF
413: 
414:         THIS.AlternarPagina(loc_nProximaEtapa)
415:         THIS.AlwaysOnTop = .T.
416:         THIS.ZOrder(0)
417:         THIS.Refresh()
418:     ENDPROC
419: 
420:     *--------------------------------------------------------------------------
421:     * BtnAlterarClick - Semantica OPERACIONAL: "alterar" as mensagens exibidas
422:     * a partir das propriedades this_cMensagemN. Rotinas externas atualizam as
423:     * propriedades e chamam este metodo para materializar as mudancas nos labels
424:     * (equivalente ao AtualizarMensagens usando o estado interno atual).
425:     *--------------------------------------------------------------------------
426:     PROCEDURE BtnAlterarClick()
427:         IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
428:             THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = THIS.this_cMensagem1
429:         ENDIF
430:         IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
431:             THIS.lbl_4c_Mensagem2.Caption = THIS.this_cMensagem2
432:         ENDIF
433:         IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
434:             THIS.lbl_4c_Mensagem3.Caption = THIS.this_cMensagem3
435:         ENDIF
436: 
437:         IF !EMPTY(THIS.this_cBitmap) AND FILE(ALLTRIM(THIS.this_cBitmap))
438:             THIS.cnt_4c_Cabecalho.img_4c_Imagem.Picture = ALLTRIM(THIS.this_cBitmap)
439:             THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .T.
440:         ENDIF
441: 
442:         THIS.Refresh()
443:     ENDPROC
444: 
445:     *--------------------------------------------------------------------------
446:     * BtnVisualizarClick - Semantica OPERACIONAL: "visualizar" o splash na frente.
447:     * Forca o dialog para o topo do Z-order e re-sincroniza captions com o estado
448:     * interno. Util quando rotinas em background abrem janelas transientes que
449:     * empilharam por cima do splash e o usuario perdeu de vista o feedback.
450:     *--------------------------------------------------------------------------
451:     PROCEDURE BtnVisualizarClick()
452:         THIS.AlwaysOnTop = .T.
453:         THIS.ZOrder(0)
454: 
455:         *-- Re-sincroniza labels com estado interno (mesmo comportamento do OnPintar)
456:         THIS.OnPintar()
457: 
458:         *-- Se a etapa nao foi definida ainda, comeca na primeira
459:         IF THIS.ObterEtapaAtiva() < 1
460:             THIS.AlternarPagina(1)
461:         ENDIF
462: 
463:         THIS.Show()
464:         THIS.Refresh()
465:     ENDPROC
466: 
467:     *--------------------------------------------------------------------------
468:     * BtnExcluirClick - Semantica OPERACIONAL: "excluir" a ultima mensagem de
469:     * status exibida. Limpa o slot mais avancado que tem conteudo (3->2->1),
470:     * permitindo que rotinas de processamento sinalizem "etapa concluida"
471:     * removendo o texto correspondente da sequencia visivel.
472:     *--------------------------------------------------------------------------
473:     PROCEDURE BtnExcluirClick()
474:         DO CASE
475:             CASE !EMPTY(THIS.this_cMensagem3)
476:                 THIS.this_cMensagem3 = ""
477:                 IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
478:                     THIS.lbl_4c_Mensagem3.Caption = ""
479:                 ENDIF
480:                 THIS.AlternarPagina(2)
481: 
482:             CASE !EMPTY(THIS.this_cMensagem2)
483:                 THIS.this_cMensagem2 = ""
484:                 IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
485:                     THIS.lbl_4c_Mensagem2.Caption = ""
486:                 ENDIF
487:                 THIS.AlternarPagina(1)
488: 
489:             CASE !EMPTY(THIS.this_cMensagem1)
490:                 THIS.this_cMensagem1 = ""
491:                 IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
492:                     THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = ""
493:                 ENDIF
494:         ENDCASE
495: 
496:         THIS.Refresh()
497:     ENDPROC
498: 
499:     *--------------------------------------------------------------------------
500:     * ObterEtapaAtiva - Helper interno: retorna qual das 3 mensagens esta como
501:     * etapa ativa (vermelha RGB 255,0,0). Usado por BtnIncluirClick para saber
502:     * qual eh a proxima etapa a destacar.
503:     *--------------------------------------------------------------------------
504:     PROTECTED FUNCTION ObterEtapaAtiva()
505:         LOCAL loc_nCor, loc_nEtapa
506:         loc_nEtapa = 0
507: 
508:         IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
509:             loc_nCor = THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.ForeColor
510:             IF loc_nCor = RGB(255, 0, 0)
511:                 loc_nEtapa = 1
512:             ENDIF
513:         ENDIF
514: 
515:         IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
516:             loc_nCor = THIS.lbl_4c_Mensagem2.ForeColor
517:             IF loc_nCor = RGB(255, 0, 0)
518:                 loc_nEtapa = 2
519:             ENDIF
520:         ENDIF
521: 
522:         IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
523:             loc_nCor = THIS.lbl_4c_Mensagem3.ForeColor
524:             IF loc_nCor = RGB(255, 0, 0)

*-- Linhas 534 a 732:
534:     * estado interno (this_cMensagemN / this_cBitmap). Util quando o codigo
535:     * externo alterou as propriedades diretamente sem passar por AtualizarMensagens.
536:     *--------------------------------------------------------------------------
537:     PROCEDURE BtnBuscarClick()
538:         THIS.CarregarLista()
539:     ENDPROC
540: 
541:     *--------------------------------------------------------------------------
542:     * BtnEncerrarClick - Encerra o dialog de progresso.
543:     * FormBase.Release() e chamado internamente pelo Destroy.
544:     *--------------------------------------------------------------------------
545:     PROCEDURE BtnEncerrarClick()
546:         THIS.Release()
547:     ENDPROC
548: 
549:     *--------------------------------------------------------------------------
550:     * BtnSalvarClick - Semantica OPERACIONAL: "confirmar" o estado atual das
551:     * mensagens (equivale a um snapshot do progresso corrente). Propaga os
552:     * captions dos labels de volta para as propriedades internas e reforca o
553:     * dialog em topo, sinalizando ao codigo externo que a etapa foi aceita.
554:     *--------------------------------------------------------------------------
555:     PROCEDURE BtnSalvarClick()
556:         IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
557:             THIS.this_cMensagem1 = THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption
558:         ENDIF
559:         IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
560:             THIS.this_cMensagem2 = THIS.lbl_4c_Mensagem2.Caption
561:         ENDIF
562:         IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
563:             THIS.this_cMensagem3 = THIS.lbl_4c_Mensagem3.Caption
564:         ENDIF
565:         THIS.AlwaysOnTop = .T.
566:         THIS.ZOrder(0)
567:         THIS.Refresh()
568:     ENDPROC
569: 
570:     *--------------------------------------------------------------------------
571:     * BtnCancelarClick - Cancela exibicao do dialog e o fecha.
572:     * Limpa mensagens antes de liberar para indicar cancelamento ao chamador
573:     * (chamador pode verificar THIS.this_cMensagem1 == "" para detectar cancel).
574:     *--------------------------------------------------------------------------
575:     PROCEDURE BtnCancelarClick()
576:         THIS.LimparCampos()
577:         THIS.Release()
578:     ENDPROC
579: 
580:     *--------------------------------------------------------------------------
581:     * CarregarLista - Re-sincroniza todos os controles visuais com o estado
582:     * interno (propriedades this_cMensagemN e this_cBitmap). Chamado por
583:     * BtnBuscarClick e sempre que o dialog precisa ser atualizado em bloco.
584:     *--------------------------------------------------------------------------
585:     PROCEDURE CarregarLista()
586:         LOCAL loc_lSucesso
587:         loc_lSucesso = .F.
588: 
589:         TRY
590:             *-- Mensagem principal (linha 1)
591:             IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
592:                 THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = THIS.this_cMensagem1
593:             ENDIF
594: 
595:             *-- Mensagem 2
596:             IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
597:                 THIS.lbl_4c_Mensagem2.Caption = THIS.this_cMensagem2
598:             ENDIF
599: 
600:             *-- Mensagem 3
601:             IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
602:                 THIS.lbl_4c_Mensagem3.Caption = THIS.this_cMensagem3
603:             ENDIF
604: 
605:             *-- Imagem lateral
606:             IF TYPE("THIS.cnt_4c_Cabecalho.img_4c_Imagem") = "O"
607:                 IF !EMPTY(THIS.this_cBitmap) AND FILE(ALLTRIM(THIS.this_cBitmap))
608:                     THIS.cnt_4c_Cabecalho.img_4c_Imagem.Picture = ALLTRIM(THIS.this_cBitmap)
609:                     THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .T.
610:                 ELSE
611:                     THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .F.
612:                 ENDIF
613:             ENDIF
614: 
615:             THIS.AlwaysOnTop = .T.
616:             THIS.ZOrder(0)
617:             THIS.Refresh()
618:             loc_lSucesso = .T.
619:         CATCH TO loc_oErro
620:             MsgErro("Falha ao recarregar dialog de progresso: " + loc_oErro.Message, "Erro")
621:         ENDTRY
622: 
623:         RETURN loc_lSucesso
624:     ENDPROC
625: 
626:     *--------------------------------------------------------------------------
627:     * FormParaBO - Transfere o estado atual dos controles visuais para as
628:     * propriedades do BO (this_cMensagemN, this_cBitmap).
629:     *--------------------------------------------------------------------------
630:     PROCEDURE FormParaBO()
631:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
632:             RETURN .F.
633:         ENDIF
634: 
635:         THIS.this_oBusinessObject.this_cBitmap    = THIS.this_cBitmap
636:         THIS.this_oBusinessObject.this_cMensagem1 = THIS.this_cMensagem1
637:         THIS.this_oBusinessObject.this_cMensagem2 = THIS.this_cMensagem2
638:         THIS.this_oBusinessObject.this_cMensagem3 = THIS.this_cMensagem3
639: 
640:         *-- Sincronizar com captions atuais dos labels (podem ter sido editados)
641:         IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
642:             THIS.this_oBusinessObject.this_cMensagem1 = ;
643:                 THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption
644:         ENDIF
645:         IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
646:             THIS.this_oBusinessObject.this_cMensagem2 = THIS.lbl_4c_Mensagem2.Caption
647:         ENDIF
648:         IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
649:             THIS.this_oBusinessObject.this_cMensagem3 = THIS.lbl_4c_Mensagem3.Caption
650:         ENDIF
651: 
652:         RETURN .T.
653:     ENDPROC
654: 
655:     *--------------------------------------------------------------------------
656:     * BOParaForm - Transfere propriedades do BO para os controles visuais
657:     * e para as propriedades internas do form.
658:     *--------------------------------------------------------------------------
659:     PROCEDURE BOParaForm()
660:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
661:             RETURN .F.
662:         ENDIF
663: 
664:         THIS.this_cBitmap    = THIS.this_oBusinessObject.this_cBitmap
665:         THIS.this_cMensagem1 = THIS.this_oBusinessObject.this_cMensagem1
666:         THIS.this_cMensagem2 = THIS.this_oBusinessObject.this_cMensagem2
667:         THIS.this_cMensagem3 = THIS.this_oBusinessObject.this_cMensagem3
668: 
669:         THIS.CarregarLista()
670:         RETURN .T.
671:     ENDPROC
672: 
673:     *--------------------------------------------------------------------------
674:     * HabilitarCampos - Dialog de progresso nao tem campos de entrada.
675:     * Metodo presente para compatibilidade com o pipeline de migracao.
676:     *--------------------------------------------------------------------------
677:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
678:         *-- Dialog de progresso nao possui campos editaveis
679:         RETURN .T.
680:     ENDPROC
681: 
682:     *--------------------------------------------------------------------------
683:     * LimparCampos - Zera todas as mensagens e oculta a imagem.
684:     * Usado por BtnCancelarClick para sinalizar cancelamento ao chamador.
685:     *--------------------------------------------------------------------------
686:     PROCEDURE LimparCampos()
687:         THIS.this_cBitmap    = ""
688:         THIS.this_cMensagem1 = ""
689:         THIS.this_cMensagem2 = ""
690:         THIS.this_cMensagem3 = ""
691: 
692:         IF TYPE("THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem") = "O"
693:             THIS.cnt_4c_Cabecalho.lbl_4c_Mensagem.Caption = ""
694:         ENDIF
695:         IF TYPE("THIS.lbl_4c_Mensagem2") = "O"
696:             THIS.lbl_4c_Mensagem2.Caption = ""
697:         ENDIF
698:         IF TYPE("THIS.lbl_4c_Mensagem3") = "O"
699:             THIS.lbl_4c_Mensagem3.Caption = ""
700:         ENDIF
701:         IF TYPE("THIS.cnt_4c_Cabecalho.img_4c_Imagem") = "O"
702:             THIS.cnt_4c_Cabecalho.img_4c_Imagem.Visible = .F.
703:         ENDIF
704: 
705:         THIS.Refresh()
706:     ENDPROC
707: 
708:     *--------------------------------------------------------------------------
709:     * AjustarBotoesPorModo - Dialog de progresso nao tem botoes CRUD com
710:     * aparencia variavel por modo. Metodo presente para compatibilidade com o
711:     * pipeline de migracao (chamado por AlternarPagina no contexto CRUD).
712:     *--------------------------------------------------------------------------
713:     PROTECTED PROCEDURE AjustarBotoesPorModo()
714:         *-- Dialog de progresso nao possui botoes CRUD com modo variavel
715:         RETURN .T.
716:     ENDPROC
717: 
718:     *--------------------------------------------------------------------------
719:     * Destroy - Limpeza ao fechar (padrao OPERACIONAL: DODEFAULT obrigatorio)
720:     * Remove os BINDEVENTs registrados no InicializarForm para evitar
721:     * referencias obsoletas na ObjectAssistant do VFP.
722:     *--------------------------------------------------------------------------
723:     PROCEDURE Destroy()
724:         UNBINDEVENTS(THIS, "Activate", THIS, "OnAtivar")
725:         UNBINDEVENTS(THIS, "Paint",    THIS, "OnPintar")
726:         IF TYPE("THIS.cnt_4c_Cabecalho") = "O"
727:             UNBINDEVENTS(THIS.cnt_4c_Cabecalho, "MouseUp", THIS, "OnCabecalhoClicado")
728:         ENDIF
729:         DODEFAULT()
730:     ENDPROC
731: 
732: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRALEBO.prg):
*============================================================================
* SIGPRALEBO.prg - Business Object para SIGPRALE (Aguarde/Progress Dialog)
*============================================================================
* Herda de: BusinessBase
* Entidade: SIGPRALE
* Tabela: (nenhuma - dialog de progresso sem persistencia em banco)
*============================================================================

DEFINE CLASS SIGPRALEBO AS BusinessBase

    *-- Sem tabela/chave - form e apenas visual (aguarde/progresso)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Conteudo exibido no dialog de progresso
    this_cBitmap     = ""
    this_cMensagem1  = ""
    this_cMensagem2  = ""
    this_cMensagem3  = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Dialog sem tabela, sem chave
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do dialog a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cBitmap    = TratarNulo(this_cBitmap,    "C")
                THIS.this_cMensagem1 = TratarNulo(this_cMensagem1, "C")
                THIS.this_cMensagem2 = TratarNulo(this_cMensagem2, "C")
                THIS.this_cMensagem3 = TratarNulo(this_cMensagem3, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Dialog sem persistencia em banco
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Dialog sem persistencia em banco
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Dialog sem persistencia em banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        RETURN .F.
    ENDPROC

ENDDEFINE

