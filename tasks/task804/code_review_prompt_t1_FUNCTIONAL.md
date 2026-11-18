# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH THIS.grd_4c_SubN define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_SubN.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_SubS define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_SubS.RecordSource).
- [GRID-HEADER] Header Caption '  #  ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Operação Sub-Nível, #, O, P, C, S, Obs, Tp.Fat, T, Sub-Nível do Sub-Nível. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption '  #  ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Operação Sub-Nível, #, O, P, C, S, Obs, Tp.Fat, T, Sub-Nível do Sub-Nível. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSno.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1976 linhas total):

*-- Linhas 24 a 60:
24:     *-- Equivalente a plInverte do legado.
25:     this_lModoInverso = .F.
26: 
27:     *-- .T. quando algum lookup de celula da grade alterou dado (equivalente
28:     *-- ao ThisForm.lHouveAlt do legado, setado nos Valid de Column1/7/8 de
29:     *-- grd_4c_SubN e de Column1 de grd_4c_SubS) - consultado pelo botao
30:     *-- Encerrar para decidir se ha algo a persistir.
31:     this_lHouveAlt = .F.
32: 
33:     *-- Equivalentes a ThisForm.lHouveIns/lHouveExcl do legado - junto com
34:     *-- this_lHouveAlt, decidem se cmd_4c_Sair tem alguma coisa a gravar.
35:     this_lHouveIns  = .F.
36:     this_lHouveExcl = .F.
37: 
38:     *-- Listas separadas por "|" com os cidchaves de linhas criadas NESTA
39:     *-- sessao (ainda nao persistidas) - decide Inserir/NovoRegistro() x
40:     *-- Atualizar/EditarRegistro() no funil de gravacao do Encerrar. Sem
41:     *-- buffer de VFP (view remota com TableUpdate), e preciso rastrear isso
42:     *-- manualmente: aqui nao ha como distinguir "linha nova" de "linha
43:     *-- carregada do banco" so pelo conteudo do cursor.
44:     this_cCidChavesNovas         = ""    && grd_4c_SubN / cursor_4c_SubNiveis (SigOpCsn)
45:     this_cCidChavesOssNovas      = ""    && grd_4c_SubS / cursor_4c_SubSubNiveis (SigOpOss)
46: 
47:     *-- Snapshot dos cidchaves de SigOpOss que JA existiam no banco quando o
48:     *-- form abriu (capturado em CarregarDados) - usado no Encerrar para
49:     *-- saber se uma linha agora em branco/excluida precisa de DELETE no SQL
50:     *-- Server ou so foi descartada localmente (nunca foi gravada).
51:     this_cCidChavesOssOriginais  = ""
52: 
53:     *-- Propriedades visuais (replicadas do SIGOPSNO.SCX)
54:     DataSession  = 2
55:     ShowWindow   = 1
56:     WindowType   = 1
57:     Height       = 430
58:     Width        = 620
59:     AutoCenter   = .T.
60:     TitleBar     = 0

*-- Linhas 75 a 472:
75:     * par_cEscolha      : modo do form pai (INSERIR/ALTERAR/VISUALIZAR)
76:     * par_lModoInverso  : .T. = modo inverso (ver this_lModoInverso)
77:     *==========================================================================
78:     PROCEDURE Init(par_oParentForm, par_cOperacaoPai, par_cEscolha, par_lModoInverso)
79:         LOCAL loc_lSucesso, loc_oErro
80: 
81:         loc_lSucesso = .F.
82: 
83:         TRY
84:             IF VARTYPE(par_oParentForm) = "O" AND !ISNULL(par_oParentForm)
85:                 THIS.this_oParentForm         = par_oParentForm
86:                 THIS.this_oParentForm.Enabled = .F.
87:             ENDIF
88: 
89:             THIS.this_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")
90:             THIS.this_cEscolha     = IIF(VARTYPE(par_cEscolha)     = "C", par_cEscolha,     "")
91:             THIS.this_lModoInverso = IIF(VARTYPE(par_lModoInverso) = "L", par_lModoInverso, .F.)
92: 
93:             *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY do DataSession=2)
94:             *-- e em seguida THIS.InicializarForm()
95:             loc_lSucesso = DODEFAULT()
96:         CATCH TO loc_oErro
97:             MsgErro(loc_oErro.Message + CHR(13) + ;
98:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
99:                     "Procedure: " + loc_oErro.Procedure, ;
100:                     "Erro ao abrir Sub-N" + CHR(237) + "veis da Opera" + CHR(231) + CHR(227) + "o")
101:             IF VARTYPE(THIS.this_oParentForm) = "O"
102:                 THIS.this_oParentForm.Enabled = .T.
103:             ENDIF
104:         ENDTRY
105: 
106:         RETURN loc_lSucesso
107:     ENDPROC
108: 
109:     *==========================================================================
110:     * InicializarForm - Cria o Business Object e a interface do usuario
111:     *==========================================================================
112:     PROTECTED PROCEDURE InicializarForm()
113:         LOCAL loc_lSucesso, loc_cTitulo, loc_oErro
114: 
115:         loc_lSucesso = .F.
116: 
117:         TRY
118:             *-- DataSession=2 nasce no default do VFP (regra #9.4) - SET
119:             *-- DELETED nao herda o SET DELETED ON do config.prg. Sem repor
120:             *-- aqui, o DELETE local de CmdExcluirClick marca a linha mas ela
121:             *-- continua aparecendo em grd_4c_SubN (o Skip/Skip-1 do legado so
122:             *-- funciona com DELETED ON) - usuario clica Excluir e nada muda
123:             *-- na tela.
124:             SET DELETED ON
125: 
126:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpSnoBO")
127:             THIS.ForeColor            = RGB(36, 84, 155)
128: 
129:             *-- Titulo baseado na operacao pai e no modo (direto/inverso),
130:             *-- igual ao legado (lcOperacao = crSigCdOpe.Dopes no Init do SCX)
131:             IF THIS.this_lModoInverso
132:                 loc_cTitulo = "Opera" + CHR(231) + CHR(245) + "es do Sub-N" + CHR(237) + "vel " + ;
133:                               ALLTRIM(PROPER(THIS.this_cOperacaoPai))
134:             ELSE
135:                 loc_cTitulo = "Subn" + CHR(237) + "veis da Opera" + CHR(231) + CHR(227) + "o " + ;
136:                               ALLTRIM(PROPER(THIS.this_cOperacaoPai))
137:             ENDIF
138:             THIS.Caption = loc_cTitulo
139: 
140:             *-- Fundo do form (new_background.jpg do legado, pasta vbmp)
141:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
142:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
143:             ENDIF
144: 
145:             *-- Cria containers e controles base
146:             THIS.ConfigurarPageFrame()
147: 
148:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
149:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
150: 
151:             *-- Fase 4: grades de Sub-Nivel/Sub-Sub-Nivel (estrutura, sem bind)
152:             *-- e os botoes Inserir/Excluir/Encerrar + separador. Top=3..36 cai
153:             *-- DENTRO da area do cabecalho (Top=0..80 - regra #11), por isso
154:             *-- sao criados DEPOIS dele, para desenhar por cima.
155:             THIS.ConfigurarGradeSubN()
156:             THIS.ConfigurarGradeSubS()
157:             THIS.ConfigurarBotoes()
158:             THIS.ConfigurarLegendas()
159: 
160:             *-- Fase 6: liga os eventos dos CheckBox O/P/C/S/T da grade de
161:             *-- sub-niveis e o AfterRowColChange mestre-detalhe. Vai DEPOIS
162:             *-- de ConfigurarGradeSubN/SubS (os controles tem de existir) e
163:             *-- ANTES de CarregarDados - religar apos a carga duplicaria o
164:             *-- handler e o toggle se anularia.
165:             THIS.ConfigurarBINDEVENTs()
166: 
167:             THIS.TornarControlesVisiveis(THIS)
168: 
169:             *-- Fase 4: funil unico de carga - religa as duas grades ao
170:             *-- resultado do BO e repinta (regra #21)
171:             THIS.CarregarDados()
172: 
173:             loc_lSucesso = .T.
174:         CATCH TO loc_oErro
175:             MsgErro(loc_oErro.Message + CHR(13) + ;
176:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
177:                     "Procedure: " + loc_oErro.Procedure, ;
178:                     "Erro em InicializarForm")
179:         ENDTRY
180: 
181:         RETURN loc_lSucesso
182:     ENDPROC
183: 
184:     *==========================================================================
185:     * ConfigurarPageFrame - Cria os containers base do form operacional
186:     * Form OPERACIONAL sem PageFrame (SIGOPSNO legado eh single-page)
187:     * Fase 3: apenas o cabecalho (cnt_4c_Cabecalho)
188:     * Fase 4: GradeSubN, GradeSubS, os botoes Inserir/Excluir/Encerrar e o
189:     *         Shape separador (shp_4c_Separador)
190:     * Fase 5: labels de legenda (Say1 a Say5) - ver ConfigurarLegendas()
191:     *==========================================================================
192:     PROTECTED PROCEDURE ConfigurarPageFrame()
193:         LOCAL loc_oErro
194: 
195:         TRY
196:             *-- Cabecalho escuro (cntSombra do legado: Top=0, W=800, H=80)
197:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
198:             WITH THIS.cnt_4c_Cabecalho
199:                 .Top         = 0
200:                 .Left        = 0
201:                 .Width       = THIS.Width
202:                 .Height      = 80
203:                 .BackStyle   = 1
204:                 .BackColor   = RGB(100, 100, 100)
205:                 .BorderWidth = 0
206:                 .Visible     = .T.
207:             ENDWITH
208: 
209:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
210:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
211:                 .FontBold  = .T.
212:                 .FontName  = "Tahoma"
213:                 .FontSize  = 18
214:                 .WordWrap  = .T.
215:                 .Alignment = 0
216:                 .BackStyle = 0
217:                 .AutoSize  = .F.
218:                 .Caption   = ""
219:                 .Height    = 40
220:                 .Left      = 10
221:                 .Top       = 18
222:                 .Width     = THIS.Width - 20
223:                 .ForeColor = RGB(0, 0, 0)
224:             ENDWITH
225: 
226:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
227:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
228:                 .FontBold  = .T.
229:                 .FontName  = "Tahoma"
230:                 .FontSize  = 18
231:                 .WordWrap  = .T.
232:                 .Alignment = 0
233:                 .BackStyle = 0
234:                 .AutoSize  = .F.
235:                 .Caption   = ""
236:                 .Height    = 46
237:                 .Left      = 10
238:                 .Top       = 17
239:                 .Width     = THIS.Width - 20
240:                 .ForeColor = RGB(255, 255, 255)
241:             ENDWITH
242:         CATCH TO loc_oErro
243:             MsgErro(loc_oErro.Message + CHR(13) + ;
244:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
245:                     "Procedure: " + loc_oErro.Procedure, ;
246:                     "Erro em ConfigurarPageFrame")
247:         ENDTRY
248:     ENDPROC
249: 
250:     *==========================================================================
251:     * ConfigurarGradeSubN - grd_4c_SubN (mapeamento.json: SIGOPSNO.GradeSubN)
252:     * 9 colunas transcritas do dump (tasks\task804\SigOpSno_form_codigo_fonte.
253:     * txt). Colunas 3/4/5/6/9 sao CheckBox de grade (flags O/P/C/S/T); as
254:     * demais sao TextBox.
255:     *
256:     * SO propriedade que NAO depende de dado (regra #41): geometria,
257:     * ColumnCount, Movable/Resizable/ReadOnly, fontes, cores e InputMask. O
258:     * bind (RecordSource/ControlSource/Width/Header1.Caption) mora em
259:     * VincularGradeSubN(), chamado pelo funil CarregarDados().
260:     *
261:     * Column3/4/5/6/9 tem Check1 no dump mas so Column9 declara
262:     * CurrentControl="Check1" explicitamente - sem o CurrentControl nos
263:     * demais a coluna continua desenhando o Text1 e o CheckBox nunca aparece
264:     * (regra #18). Os cinco recebem CurrentControl + Sparse = .F. aqui.
265:     *
266:     * RecordMark/DeleteMark = .F. (regra do projeto para Grid criado por
267:     * AddObject em form OPERACIONAL).
268:     *==========================================================================
269:     PROTECTED PROCEDURE ConfigurarGradeSubN()
270:         THIS.AddObject("grd_4c_SubN", "Grid")
271: 
272:         WITH THIS.grd_4c_SubN
273:             .Top           = 173
274:             .Left          = 7
275:             .Width         = 394
276:             .Height        = 238
277:             .FontName      = "Tahoma"
278:             .FontSize      = 8
279:             .DeleteMark    = .F.
280:             .RecordMark    = .F.
281:             .RowHeight     = 16
282:             .ScrollBars    = 2
283:             .TabIndex      = 1
284:             .GridLineColor = RGB(238, 238, 238)
285:             .ColumnCount   = 9
286:         ENDWITH
287: 
288:         *-- Column1 - Operacao Sub-Nivel (editavel: codigo digitado p/ Inserir)
289:         WITH THIS.grd_4c_SubN.Column1
290:             .FontName  = "Tahoma"
291:             .FontSize  = 8
292:             .Width     = 150
293:             .Movable   = .F.
294:             .Resizable = .F.
295:             .ReadOnly  = .F.
296:             .Header1.FontName  = "Tahoma"
297:             .Header1.FontSize  = 8
298:             .Header1.Alignment = 2
299:             .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o Sub-N" + CHR(237) + "vel"
300:             .Header1.ForeColor = RGB(255, 0, 0)
301:             .Text1.FontName    = "Tahoma"
302:             .Text1.FontSize    = 8
303:             .Text1.BorderStyle = 0
304:             .Text1.Margin      = 0
305:             .Text1.ForeColor   = RGB(0, 0, 0)
306:             .Text1.BackColor   = RGB(255, 255, 255)
307: 
308:             *-- Lookup de Operacao (legado: fwBuscaExt contra SigCdOpe) -
309:             *-- celula com When/Valid/LostFocus embutidos (regra #18/#46),
310:             *-- instalada POR CIMA do Text1 (CurrentControl)
311:             .AddObject("txt_4c_Operacao", "TextBoxCelulaSno_4c")
312:             .txt_4c_Operacao.this_cCelula = "OPERACAO"
313:             .CurrentControl = "txt_4c_Operacao"
314:             .Sparse         = .F.
315:         ENDWITH
316: 
317:         *-- Column2 - # (nDopes, numero sequencial da operacao) - ReadOnly
318:         WITH THIS.grd_4c_SubN.Column2
319:             .FontName  = "Tahoma"
320:             .FontSize  = 8
321:             .Width     = 38
322:             .Movable   = .F.
323:             .Resizable = .F.
324:             .ReadOnly  = .T.
325:             .InputMask = "9999"
326:             .Header1.FontName  = "Tahoma"
327:             .Header1.FontSize  = 8
328:             .Header1.Alignment = 2
329:             .Header1.Caption   = "  #  "
330:             .Text1.FontName    = "Tahoma"
331:             .Text1.FontSize    = 8
332:             .Text1.BorderStyle = 0
333:             .Text1.Margin      = 0
334:             .Text1.ReadOnly    = .T.
335:             .Text1.ForeColor   = RGB(0, 0, 0)
336:             .Text1.BackColor   = RGB(255, 255, 255)
337:         ENDWITH
338: 
339:         *-- Column3 - "O" = Obrigatorio (CheckBox)
340:         WITH THIS.grd_4c_SubN.Column3
341:             .FontName  = "Tahoma"
342:             .FontSize  = 8
343:             .Width     = 21
344:             .Movable   = .F.
345:             .Resizable = .F.
346:             .Sparse    = .F.
347:             .BackColor = RGB(255, 125, 125)
348:             .Header1.FontName  = "Tahoma"
349:             .Header1.FontSize  = 8
350:             .Header1.Alignment = 2
351:             .Header1.Caption   = "O"
352:         ENDWITH
353:         THIS.grd_4c_SubN.Column3.AddObject("Check1", "CheckBox")
354:         WITH THIS.grd_4c_SubN.Column3.Check1
355:             .Top       = 30
356:             .Left      = 5
357:             .Height    = 17
358:             .Width     = 60
359:             .FontName  = "Tahoma"
360:             .FontSize  = 8
361:             .Alignment = 2
362:             .Caption   = ""
363:             .ForeColor = RGB(0, 0, 0)
364:             .BackColor = RGB(255, 125, 125)
365:         ENDWITH
366:         THIS.grd_4c_SubN.Column3.CurrentControl = "Check1"
367: 
368:         *-- Column4 - "P" = Baixa SubNivel do SubNivel c/Pago (CheckBox)
369:         WITH THIS.grd_4c_SubN.Column4
370:             .FontName  = "Tahoma"
371:             .FontSize  = 8
372:             .Width     = 21
373:             .Movable   = .F.
374:             .Resizable = .F.
375:             .Sparse    = .F.
376:             .BackColor = RGB(204, 230, 255)
377:             .Header1.FontName  = "Tahoma"
378:             .Header1.FontSize  = 8
379:             .Header1.Alignment = 2
380:             .Header1.Caption   = "P"
381:             .Header1.ForeColor = RGB(0, 128, 255)
382:         ENDWITH
383:         THIS.grd_4c_SubN.Column4.AddObject("Check1", "CheckBox")
384:         WITH THIS.grd_4c_SubN.Column4.Check1
385:             .Top       = 30
386:             .Left      = 7
387:             .Height    = 17
388:             .Width     = 60
389:             .FontName  = "Tahoma"
390:             .FontSize  = 8
391:             .Alignment = 2
392:             .Caption   = ""
393:             .ForeColor = RGB(0, 0, 0)
394:             .BackColor = RGB(204, 230, 255)
395:         ENDWITH
396:         THIS.grd_4c_SubN.Column4.CurrentControl = "Check1"
397: 
398:         *-- Column5 - "C" = Cancela Baixa SubNivel do SubNivel c/Pago (CheckBox)
399:         WITH THIS.grd_4c_SubN.Column5
400:             .FontName  = "Tahoma"
401:             .FontSize  = 8
402:             .Width     = 21
403:             .Movable   = .F.
404:             .Resizable = .F.
405:             .Sparse    = .F.
406:             .BackColor = RGB(255, 203, 151)
407:             .Header1.FontName  = "Tahoma"
408:             .Header1.FontSize  = 8
409:             .Header1.Alignment = 2
410:             .Header1.Caption   = "C"
411:             .Header1.ForeColor = RGB(255, 128, 0)
412:         ENDWITH
413:         THIS.grd_4c_SubN.Column5.AddObject("Check1", "CheckBox")
414:         WITH THIS.grd_4c_SubN.Column5.Check1
415:             .Top       = 30
416:             .Left      = 4
417:             .Height    = 17
418:             .Width     = 60
419:             .FontName  = "Tahoma"
420:             .FontSize  = 8
421:             .Alignment = 2
422:             .Caption   = ""
423:             .ForeColor = RGB(0, 0, 0)
424:             .BackColor = RGB(255, 203, 151)
425:         ENDWITH
426:         THIS.grd_4c_SubN.Column5.CurrentControl = "Check1"
427: 
428:         *-- Column6 - "S" = Controle de Status (Aprovado/Reprovado) (CheckBox)
429:         WITH THIS.grd_4c_SubN.Column6
430:             .FontName  = "Tahoma"
431:             .FontSize  = 8
432:             .Width     = 21
433:             .Movable   = .F.
434:             .Resizable = .F.
435:             .Sparse    = .F.
436:             .BackColor = RGB(255, 230, 255)
437:             .Header1.FontName  = "Tahoma"
438:             .Header1.FontSize  = 8
439:             .Header1.Alignment = 2
440:             .Header1.Caption   = "S"
441:         ENDWITH
442:         THIS.grd_4c_SubN.Column6.AddObject("Check1", "CheckBox")
443:         WITH THIS.grd_4c_SubN.Column6.Check1
444:             .Top       = 31
445:             .Left      = 5
446:             .Height    = 17
447:             .Width     = 60
448:             .FontName  = "Tahoma"
449:             .FontSize  = 8
450:             .Alignment = 0
451:             .Caption   = ""
452:             .BackColor = RGB(255, 230, 255)
453:         ENDWITH
454:         THIS.grd_4c_SubN.Column6.CurrentControl = "Check1"
455: 
456:         *-- Column7 - Obs (codigo da observacao, numeric(3,0), TextBox)
457:         WITH THIS.grd_4c_SubN.Column7
458:             .FontName    = "Tahoma"
459:             .FontSize    = 8
460:             .ColumnOrder = 8
461:             .Width       = 31
462:             .Movable     = .F.
463:             .Resizable   = .F.
464:             .ReadOnly    = .F.
465:             .InputMask   = "999"
466:             .Header1.FontName  = "Tahoma"
467:             .Header1.FontSize  = 8
468:             .Header1.Alignment = 2
469:             .Header1.Caption   = "Obs"
470:             .Text1.FontName    = "Tahoma"
471:             .Text1.FontSize    = 8
472:             .Text1.BorderStyle = 0

*-- Linhas 484 a 504:
484:             .CurrentControl = "txt_4c_Obs"
485:             .Sparse         = .F.
486:         ENDWITH
487: 
488:         *-- Column8 - Tp.Fat (tipo de faturamento, char(3), TextBox)
489:         WITH THIS.grd_4c_SubN.Column8
490:             .FontName    = "Tahoma"
491:             .FontSize    = 8
492:             .ColumnOrder = 9
493:             .Width       = 31
494:             .Movable     = .F.
495:             .Resizable   = .F.
496:             .ReadOnly    = .F.
497:             .Header1.FontName  = "Tahoma"
498:             .Header1.FontSize  = 8
499:             .Header1.Alignment = 2
500:             .Header1.Caption   = "Tp.Fat"
501:             .Text1.FontName    = "Tahoma"
502:             .Text1.FontSize    = 8
503:             .Text1.BorderStyle = 0
504:             .Text1.Margin      = 0

*-- Linhas 514 a 599:
514:             .Sparse         = .F.
515:         ENDWITH
516: 
517:         *-- Column9 - "T" = Atualiza Grupo/Conta de Origem conforme SubNivel
518:         *-- (CheckBox - dump ja declara CurrentControl="Check1" para esta)
519:         WITH THIS.grd_4c_SubN.Column9
520:             .FontName    = "Tahoma"
521:             .FontSize    = 8
522:             .ColumnOrder = 7
523:             .Width       = 21
524:             .Movable     = .F.
525:             .Resizable   = .F.
526:             .Sparse      = .F.
527:             .BackColor   = RGB(128, 255, 0)
528:             .Header1.FontName  = "Tahoma"
529:             .Header1.FontSize  = 8
530:             .Header1.Alignment = 2
531:             .Header1.Caption   = "T"
532:             .Text1.BorderStyle = 0
533:             .Text1.Margin      = 0
534:             .Text1.ForeColor   = RGB(0, 0, 0)
535:             .Text1.BackColor   = RGB(128, 255, 0)
536:         ENDWITH
537:         THIS.grd_4c_SubN.Column9.AddObject("Check1", "CheckBox")
538:         WITH THIS.grd_4c_SubN.Column9.Check1
539:             .Top       = 27
540:             .Left      = 4
541:             .Height    = 17
542:             .Width     = 60
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .Alignment = 0
546:             .Caption   = ""
547:         ENDWITH
548:         THIS.grd_4c_SubN.Column9.CurrentControl = "Check1"
549: 
550:         RETURN .T.
551:     ENDPROC
552: 
553:     *==========================================================================
554:     * ConfigurarGradeSubS - grd_4c_SubS (mapeamento.json: SIGOPSNO.GradeSubS)
555:     * 1 coluna, lista os sub-sub-niveis (SigOpOss.Dopess) do sub-nivel
556:     * CORRENTE da grade acima. O filtro por linha corrente (Set Key To) eh
557:     * feito no AfterRowColChange - Fase 8; aqui so a estrutura (regra #41).
558:     *==========================================================================
559:     PROTECTED PROCEDURE ConfigurarGradeSubS()
560:         THIS.AddObject("grd_4c_SubS", "Grid")
561: 
562:         WITH THIS.grd_4c_SubS
563:             .Top           = 173
564:             .Left          = 410
565:             .Width         = 182
566:             .Height        = 238
567:             .FontName      = "Tahoma"
568:             .FontSize      = 8
569:             .DeleteMark    = .F.
570:             .RecordMark    = .F.
571:             .RowHeight     = 16
572:             .ScrollBars    = 2
573:             .TabIndex      = 2
574:             .GridLineColor = RGB(238, 238, 238)
575:             .ColumnCount   = 1
576:         ENDWITH
577: 
578:         WITH THIS.grd_4c_SubS.Column1
579:             .FontName  = "Tahoma"
580:             .FontSize  = 8
581:             .Width     = 150
582:             .Movable   = .F.
583:             .Resizable = .F.
584:             .ReadOnly  = .F.
585:             .Header1.FontName  = "Tahoma"
586:             .Header1.FontSize  = 8
587:             .Header1.Alignment = 2
588:             .Header1.Caption   = "Sub-N" + CHR(237) + "vel do Sub-N" + CHR(237) + "vel"
589:             .Header1.ForeColor = RGB(255, 0, 0)
590:             .Text1.FontName    = "Tahoma"
591:             .Text1.FontSize    = 8
592:             .Text1.BorderStyle = 0
593:             .Text1.Margin      = 0
594:             .Text1.ForeColor   = RGB(0, 0, 0)
595:             .Text1.BackColor   = RGB(255, 255, 255)
596: 
597:             *-- Lookup de Sub-Sub-Nivel (legado: fwBuscaInt local restrito
598:             *-- as operacoes que usam o sub-nivel corrente como filho) -
599:             *-- celula com When/Valid/LostFocus embutidos (regra #18/#46)

*-- Linhas 607 a 658:
607:     ENDPROC
608: 
609:     *==========================================================================
610:     * ConfigurarLegendas - lbl_4c_Label1 a lbl_4c_Label5 (mapeamento.json:
611:     * Say1 a Say5). Explicam o significado das colunas O/P/C/S/T de
612:     * grd_4c_SubN. Classe "say" do legado NAO declara Width/Alignment
613:     * (regra #23): AutoSize=.T. e no-op em Label criado por AddObject, por
614:     * isso aqui vai Alignment=0 (esquerda, igual ao legado) + Width explicita
615:     * que caiba o texto - a area (Top=94..166) fica livre, acima das grades
616:     * (Top=173), sem risco de sobreposicao mesmo com Width generosa.
617:     *==========================================================================
618:     PROTECTED PROCEDURE ConfigurarLegendas()
619:         THIS.AddObject("lbl_4c_Label1", "Label")
620:         WITH THIS.lbl_4c_Label1
621:             .FontBold  = .T.
622:             .FontName  = "Tahoma"
623:             .FontSize  = 8
624:             .BackStyle = 0
625:             .AutoSize  = .F.
626:             .Alignment = 0
627:             .Left      = 7
628:             .Top       = 94
629:             .Width     = 300
630:             .Height    = 14
631:             .ForeColor = RGB(216, 39, 70)
632:             .Caption   = "O = Obrigat" + CHR(243) + "rio"
633:         ENDWITH
634: 
635:         THIS.AddObject("lbl_4c_Label2", "Label")
636:         WITH THIS.lbl_4c_Label2
637:             .FontBold  = .T.
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .BackStyle = 0
641:             .AutoSize  = .F.
642:             .Alignment = 0
643:             .Left      = 7
644:             .Top       = 108
645:             .Width     = 400
646:             .Height    = 14
647:             .ForeColor = RGB(0, 128, 255)
648:             .Caption   = "P = Bx SubNivel do SubNivel c/Pago"
649:         ENDWITH
650: 
651:         THIS.AddObject("lbl_4c_Label3", "Label")
652:         WITH THIS.lbl_4c_Label3
653:             .FontBold  = .T.
654:             .FontName  = "Tahoma"
655:             .FontSize  = 8
656:             .BackStyle = 0
657:             .AutoSize  = .F.
658:             .Alignment = 0

*-- Linhas 698 a 753:
698: 
699:         RETURN .T.
700:     ENDPROC
701: 
702:     *==========================================================================
703:     * VincularGradeSubN - liga grd_4c_SubN a cursor_4c_SubNiveis
704:     *
705:     * Column1 muda de sentido conforme o modo (regra #41/Problema 48: a
706:     * largura/caption sao reaplicadas DEPOIS do bind, porque RecordSource as
707:     * reseta):
708:     *   - modo DIRETO:  Column1 mostra o CODIGO do sub-nivel (cnivels)
709:     *   - modo INVERSO: Column1 mostra a OPERACAO que usa esta como sub-nivel
710:     *     (cdopes) - o cursor traz as duas colunas sempre (SigOpSnoBO.
711:     *     ListarSubNiveis faz o JOIN com SigCdOpe nos dois modos).
712:     *==========================================================================
713:     PROTECTED PROCEDURE VincularGradeSubN()
714:         LOCAL loc_cColuna1
715: 
716:         IF !USED("cursor_4c_SubNiveis")
717:             RETURN .F.
718:         ENDIF
719: 
720:         loc_cColuna1 = IIF(THIS.this_lModoInverso, "cdopes", "cnivels")
721: 
722:         WITH THIS.grd_4c_SubN
723:             .RecordSource          = ""
724:             .RecordSource          = "cursor_4c_SubNiveis"
725:             .Column1.ControlSource = "cursor_4c_SubNiveis." + loc_cColuna1
726:             .Column2.ControlSource = "cursor_4c_SubNiveis.ndopes"
727:             .Column3.ControlSource = "cursor_4c_SubNiveis.obrigs"
728:             .Column4.ControlSource = "cursor_4c_SubNiveis.pgsubnns"
729:             .Column5.ControlSource = "cursor_4c_SubNiveis.cbxpagos"
730:             .Column6.ControlSource = "cursor_4c_SubNiveis.tstatus"
731:             .Column7.ControlSource = "cursor_4c_SubNiveis.codobs"
732:             .Column8.ControlSource = "cursor_4c_SubNiveis.tpfats"
733:             .Column9.ControlSource = "cursor_4c_SubNiveis.ckatcta"
734: 
735:             *-- Reaplicar largura/cabecalho DEPOIS do bind (RecordSource reseta)
736:             .Column1.Width = 150
737:             .Column2.Width = 38
738:             .Column3.Width = 21
739:             .Column4.Width = 21
740:             .Column5.Width = 21
741:             .Column6.Width = 21
742:             .Column7.Width = 31
743:             .Column8.Width = 31
744:             .Column9.Width = 21
745: 
746:             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o Sub-N" + CHR(237) + "vel"
747:             .Column2.Header1.Caption = "  #  "
748:             .Column3.Header1.Caption = "O"
749:             .Column4.Header1.Caption = "P"
750:             .Column5.Header1.Caption = "C"
751:             .Column6.Header1.Caption = "S"
752:             .Column7.Header1.Caption = "Obs"
753:             .Column8.Header1.Caption = "Tp.Fat"

*-- Linhas 815 a 900:
815: 
816:         RETURN .T.
817:     ENDPROC
818: 
819:     *==========================================================================
820:     * VincularGradeSubS - liga grd_4c_SubS a cursor_4c_SubSubNiveis
821:     *==========================================================================
822:     PROTECTED PROCEDURE VincularGradeSubS()
823:         IF !USED("cursor_4c_SubSubNiveis")
824:             RETURN .F.
825:         ENDIF
826: 
827:         WITH THIS.grd_4c_SubS
828:             .RecordSource          = ""
829:             .RecordSource          = "cursor_4c_SubSubNiveis"
830:             .Column1.ControlSource = "cursor_4c_SubSubNiveis.dopess"
831: 
832:             .Column1.Width           = 150
833:             .Column1.Header1.Caption = "Sub-N" + CHR(237) + "vel do Sub-N" + CHR(237) + "vel"
834: 
835:             *-- CurrentControl/Sparse resetados pelo rebind - reaplicar
836:             *-- (regra #18/Problema 48, idempotente)
837:             .Column1.CurrentControl = "txt_4c_SubSub"
838:             .Column1.Sparse         = .F.
839:         ENDWITH
840: 
841:         RETURN .T.
842:     ENDPROC
843: 
844:     *==========================================================================
845:     * ConfigurarBotoes - cmd_4c_Inserir / cmd_4c_Excluir / cmd_4c_Sair +
846:     * shp_4c_Separador (mapeamento.json: cmdInserir/cmdExcluir/cmdSair/
847:     * Shape1). Geometria/Picture/Caption transcritos do dump; propriedades
848:     * comuns vem da classe fwbtng do Framework legado (Width=80, Height=100,
849:     * FontBold=.T., FontItalic=.T., FontName="Comic Sans MS", FontSize=8,
850:     * WordWrap=.T., MousePointer=15, ForeColor=RGB(90,90,90),
851:     * BackColor=RGB(255,255,255), Themes=.F. - docs\FRAMEWORK_class_codigo_
852:     * fonte.txt).
853:     *
854:     * Visibilidade/Enabled de Inserir/Excluir e a posicao/largura do
855:     * separador sao TRANSCRITAS do Init legado (nao sao Click - ficam aqui
856:     * porque sao estado inicial, calculado a partir de this_cEscolha/
857:     * this_lModoInverso, ja conhecidos neste ponto). Click dos tres botoes
858:     * fica para fase posterior (nenhum metodo vazio - regra de completude).
859:     *==========================================================================
860:     PROTECTED PROCEDURE ConfigurarBotoes()
861:         LOCAL loc_lMostraInserirExcluir
862: 
863:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
864:         WITH THIS.cmd_4c_Inserir
865:             .Top         = 3
866:             .Left        = 394
867:             .Width        = 80
868:             .Height       = 100
869:             .FontBold     = .T.
870:             .FontItalic   = .T.
871:             .FontName     = "Comic Sans MS"
872:             .FontSize     = 8
873:             .WordWrap     = .T.
874:             .MousePointer = 15
875:             .ForeColor    = RGB(90, 90, 90)
876:             .BackColor    = RGB(255, 255, 255)
877:             .Themes           = .T.
878:             .TabIndex     = 9
879:             .Caption      = "Inserir"
880:             IF FILE(gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg")
881:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
882:             ENDIF
883:         ENDWITH
884: 
885:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
886:         WITH THIS.cmd_4c_Excluir
887:             .Top          = 3
888:             .Left         = 469
889:             .Width        = 80
890:             .Height       = 100
891:             .FontBold     = .T.
892:             .FontItalic   = .T.
893:             .FontName     = "Comic Sans MS"
894:             .FontSize     = 8
895:             .WordWrap     = .T.
896:             .MousePointer = 15
897:             .ForeColor    = RGB(90, 90, 90)
898:             .BackColor    = RGB(255, 255, 255)
899:             .Themes           = .T.
900:             .TabIndex     = 7

*-- Linhas 984 a 1857:
984:     * Devolve .F. sem estourar quando o BO ainda nao existe (gb_4c_ValidandoUI);
985:     * nao impede o form de abrir.
986:     *==========================================================================
987:     PROCEDURE CarregarDados()
988:         LOCAL loc_lSucesso, loc_oErro, loc_cAliasAnterior
989:         loc_lSucesso = .F.
990: 
991:         *-- Reset do estado de rastreamento (regra: CarregarDados eh o funil
992:         *-- unico de carga - mesmo chamado uma unica vez hoje, o reset evita
993:         *-- estado velho sobreviver caso o metodo volte a ser chamado)
994:         THIS.this_lHouveAlt              = .F.
995:         THIS.this_lHouveIns               = .F.
996:         THIS.this_lHouveExcl              = .F.
997:         THIS.this_cCidChavesNovas         = ""
998:         THIS.this_cCidChavesOssNovas      = ""
999:         THIS.this_cCidChavesOssOriginais  = ""
1000: 
1001:         TRY
1002:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1003: 
1004:                 IF THIS.this_oBusinessObject.ListarSubNiveis(THIS.this_cOperacaoPai, ;
1005:                        THIS.this_lModoInverso)
1006:                     THIS.VincularGradeSubN()
1007:                     IF USED("cursor_4c_SubNiveis")
1008:                         SELECT cursor_4c_SubNiveis
1009:                         GO TOP
1010:                     ENDIF
1011:                 ENDIF
1012: 
1013:                 IF THIS.this_oBusinessObject.ListarSubSubNiveis(THIS.this_cOperacaoPai)
1014:                     THIS.VincularGradeSubS()
1015:                     IF USED("cursor_4c_SubSubNiveis")
1016:                         SELECT cursor_4c_SubSubNiveis
1017:                         GO TOP
1018: 
1019:                         *-- Snapshot dos cidchaves ja gravados no banco
1020:                         *-- (usado por PersistirSubSubNiveis no Encerrar)
1021:                         loc_cAliasAnterior = ALIAS()
1022:                         SELECT cursor_4c_SubSubNiveis
1023:                         SCAN
1024:                             IF !EMPTY(ALLTRIM(NVL(cidchaves, "")))
1025:                                 THIS.this_cCidChavesOssOriginais = ;
1026:                                     THIS.this_cCidChavesOssOriginais + "|" + ALLTRIM(cidchaves)
1027:                             ENDIF
1028:                         ENDSCAN
1029:                         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1030:                             SELECT (loc_cAliasAnterior)
1031:                         ENDIF
1032:                     ENDIF
1033:                 ENDIF
1034: 
1035:                 THIS.Refresh()
1036:                 IF PEMSTATUS(THIS, "grd_4c_SubN", 5)
1037:                     THIS.grd_4c_SubN.Refresh()
1038:                 ENDIF
1039:                 IF PEMSTATUS(THIS, "grd_4c_SubS", 5)
1040:                     THIS.grd_4c_SubS.Refresh()
1041:                 ENDIF
1042: 
1043:                 *-- Legado: o Init termina com ThisForm.GradeSubN.
1044:                 *-- AfterRowColChange() - escopa a grade de sub-sub-niveis
1045:                 *-- ao sub-nivel da PRIMEIRA linha ja na abertura. Sem esta
1046:                 *-- chamada a grade da direita abriria listando os sub-sub-
1047:                 *-- niveis de TODOS os sub-niveis da operacao.
1048:                 THIS.GradeSubNAfterRowColChange(1)
1049: 
1050:                 loc_lSucesso = .T.
1051:             ENDIF
1052:         CATCH TO loc_oErro
1053:             MsgErro(loc_oErro.Message + CHR(13) + ;
1054:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1055:                     "Procedure: " + loc_oErro.Procedure, ;
1056:                     "Erro em CarregarDados")
1057:         ENDTRY
1058: 
1059:         RETURN loc_lSucesso
1060:     ENDPROC
1061: 
1062:     *==========================================================================
1063:     * CelulaSnoEditavel - When das celulas de lookup instaladas em
1064:     * txt_4c_Operacao/txt_4c_Obs/txt_4c_TpFat (grd_4c_SubN) e txt_4c_SubSub
1065:     * (grd_4c_SubS), chamado por TextBoxCelulaSno_4c.When() (textboxgrid
1066:     * lookup.PRG). PUBLIC - a classe delega via THISFORM (regra #46).
1067:     *==========================================================================
1068:     PROCEDURE CelulaSnoEditavel(par_cCelula, par_oTxt)
1069:         DO CASE
1070:         CASE par_cCelula == "OPERACAO"
1071:             *-- Legado (GradeSubN.Column1.Text1.When): Return (crSigOpCsn.
1072:             *-- cDopes = crSigCdOpe.Dopes) And IsEmpty(crSigOpCsn.cNivels) -
1073:             *-- so editavel enquanto a linha ainda nao tem sub-nivel
1074:             *-- definido. No modo inverso Inserir fica desabilitado
1075:             *-- (ConfigurarBotoes), entao nunca ha linha nova para editar.
1076:             IF THIS.this_lModoInverso OR !USED("cursor_4c_SubNiveis")
1077:                 RETURN .F.
1078:             ENDIF
1079:             RETURN ALLTRIM(cursor_4c_SubNiveis.cdopes) == ALLTRIM(THIS.this_cOperacaoPai) ;
1080:                    AND EMPTY(cursor_4c_SubNiveis.cnivels)
1081: 
1082:         CASE par_cCelula == "SUBSUB"
1083:             *-- Legado (GradeSubS.Column1.Text1.When): Return Not IsEmpty(
1084:             *-- crSigOpCsn.cNivels) - a linha mestre de grd_4c_SubN (sub-
1085:             *-- nivel corrente) precisa ja ter um codigo de operacao.
1086:             IF !USED("cursor_4c_SubNiveis")
1087:                 RETURN .F.
1088:             ENDIF
1089:             RETURN !EMPTY(cursor_4c_SubNiveis.cnivels)
1090:         ENDCASE
1091: 
1092:         RETURN .T.
1093:     ENDPROC
1094: 
1095:     *==========================================================================
1096:     * ValidarCelulaSnoExec - Valid das celulas de lookup (regra #46: valida
1097:     * na saida da CELULA, nunca em AfterRowColChange). Recebe o proprio
1098:     * TextBox - dentro do Valid o valor digitado esta em par_oTxt.Value e
1099:     * AINDA NAO chegou ao cursor da grade (regra #46).
1100:     *==========================================================================
1101:     PROCEDURE ValidarCelulaSnoExec(par_cCelula, par_oTxt)
1102:         DO CASE
1103:         CASE par_cCelula == "OPERACAO" OR par_cCelula == "TPFAT"
1104:             IF EMPTY(ALLTRIM(NVL(par_oTxt.Value, "")))
1105:                 RETURN .T.
1106:             ENDIF
1107: 
1108:         CASE par_cCelula == "OBS"
1109:             IF NVL(par_oTxt.Value, 0) = 0
1110:                 RETURN .T.
1111:             ENDIF
1112: 
1113:         CASE par_cCelula == "SUBSUB"
1114:             IF EMPTY(ALLTRIM(NVL(par_oTxt.Value, ""))) OR !USED("cursor_4c_SubNiveis") ;
1115:                OR EMPTY(ALLTRIM(cursor_4c_SubNiveis.cnivels))
1116:                 RETURN .T.
1117:             ENDIF
1118:         ENDCASE
1119: 
1120:         THIS.ResolverLookupCelulaSno(par_cCelula, par_oTxt)
1121: 
1122:         RETURN .T.
1123:     ENDPROC
1124: 
1125:     *==========================================================================
1126:     * AbrirLookupCelulaSno - F4/F5/duplo clique (afordancia do sistema novo,
1127:     * padrao dos demais lookups de grade do projeto) - abre o picker direto,
1128:     * mesmo com o campo vazio (mostra o universo inteiro).
1129:     *==========================================================================
1130:     PROCEDURE AbrirLookupCelulaSno(par_cCelula, par_oTxt)
1131:         IF par_cCelula == "SUBSUB"
1132:             IF !USED("cursor_4c_SubNiveis") OR EMPTY(ALLTRIM(cursor_4c_SubNiveis.cnivels))
1133:                 RETURN
1134:             ENDIF
1135:         ENDIF
1136: 
1137:         THIS.ResolverLookupCelulaSno(par_cCelula, par_oTxt)
1138:         par_oTxt.Refresh()
1139:     ENDPROC
1140: 
1141:     *==========================================================================
1142:     * ResolverLookupCelulaSno - corpo comum do Valid e do F4/F5/duplo clique.
1143:     * Tenta o match exato (o Init de FormBuscaAuxiliar ja faz isso - regra
1144:     * #37) e, nao achando, mostra o picker; so atribui par_oTxt.Value sob a
1145:     * guarda this_lSelecionou (regra #37 - nunca fora dela, senao o campo
1146:     * digitado eh zerado quando o usuario cancela).
1147:     *==========================================================================
1148:     PROTECTED PROCEDURE ResolverLookupCelulaSno(par_cCelula, par_oTxt)
1149:         LOCAL loc_cValor, loc_oBusca, loc_cDopesMestre
1150: 
1151:         loc_cValor = ALLTRIM(TRANSFORM(NVL(par_oTxt.Value, "")))
1152: 
1153:         DO CASE
1154:         CASE par_cCelula == "OPERACAO"
1155:             *-- Legado: fwBuscaExt contra SigCdOpe (Dopes/nDopes)
1156:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
1157:                 "cursor_4c_BuscaOperSub", "Dopes", loc_cValor, ;
1158:                 "Cadastro de Opera" + CHR(231) + CHR(245) + "es")
1159: 
1160:             IF VARTYPE(loc_oBusca) = "O"
1161:                 IF !loc_oBusca.this_lAchouRegistro
1162:                     loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1163:                     loc_oBusca.mAddColuna("Ndopes", "", " # ")
1164:                     loc_oBusca.Show()
1165:                 ENDIF
1166:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOperSub")
1167:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaOperSub.Dopes)
1168:                     *-- Column2 ("#") da grade espelha o ndopes da operacao
1169:                     *-- ESCOLHIDA agora, nao o que veio do JOIN no load inicial
1170:                     IF USED("cursor_4c_SubNiveis")
1171:                         REPLACE cursor_4c_SubNiveis.ndopes WITH NVL(cursor_4c_BuscaOperSub.Ndopes, 0)
1172:                     ENDIF
1173:                     THIS.this_lHouveAlt = .T.
1174:                 ENDIF
1175:                 loc_oBusca.Release()
1176:             ENDIF
1177:             IF USED("cursor_4c_BuscaOperSub")
1178:                 USE IN cursor_4c_BuscaOperSub
1179:             ENDIF
1180: 
1181:         CASE par_cCelula == "OBS"
1182:             *-- Legado: fwBuscaExt contra SigCdObs (Codigos/Observas - mas
1183:             *-- Observas eh MEMO; a grade do picker usa descrs char(80), a
1184:             *-- descricao canonica da tabela, para exibir sem os cuidados de
1185:             *-- memo-em-grid que o legado fazia so com MLine() na coluna)
1186:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdObs", ;
1187:                 "cursor_4c_BuscaObsSno", "Codigos", loc_cValor, ;
1188:                 "Cadastro de Observa" + CHR(231) + CHR(245) + "es")
1189: 
1190:             IF VARTYPE(loc_oBusca) = "O"
1191:                 IF !loc_oBusca.this_lAchouRegistro
1192:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1193:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1194:                     loc_oBusca.Show()
1195:                 ENDIF
1196:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObsSno")
1197:                     par_oTxt.Value = NVL(cursor_4c_BuscaObsSno.Codigos, 0)
1198:                     THIS.this_lHouveAlt = .T.
1199:                 ENDIF
1200:                 loc_oBusca.Release()
1201:             ENDIF
1202:             IF USED("cursor_4c_BuscaObsSno")
1203:                 USE IN cursor_4c_BuscaObsSno
1204:             ENDIF
1205: 
1206:         CASE par_cCelula == "TPFAT"
1207:             *-- Legado: fwBuscaExt contra SigCdTif (Codigos/Descricaos)
1208:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTif", ;
1209:                 "cursor_4c_BuscaTifSno", "Codigos", loc_cValor, ;
1210:                 "Cadastro de Tipo de Faturamento")
1211: 
1212:             IF VARTYPE(loc_oBusca) = "O"
1213:                 IF !loc_oBusca.this_lAchouRegistro
1214:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1215:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1216:                     loc_oBusca.Show()
1217:                 ENDIF
1218:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTifSno")
1219:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaTifSno.Codigos)
1220:                     THIS.this_lHouveAlt = .T.
1221:                 ENDIF
1222:                 loc_oBusca.Release()
1223:             ENDIF
1224:             IF USED("cursor_4c_BuscaTifSno")
1225:                 USE IN cursor_4c_BuscaTifSno
1226:             ENDIF
1227: 
1228:         CASE par_cCelula == "SUBSUB"
1229:             *-- Legado: lcDopes = crSigOpCsn.cNivels (sub-nivel CORRENTE na
1230:             *-- grade mestre) + Select cDopes From SigOpCsn Where cNivels =
1231:             *-- lcDopes, e o typed value eh buscado NESSE universo (fwBuscaInt
1232:             *-- local) - aqui via FormBuscaAuxiliar + par_cFiltro (regra #36)
1233:             IF !USED("cursor_4c_SubNiveis")
1234:                 RETURN
1235:             ENDIF
1236:             loc_cDopesMestre = ALLTRIM(cursor_4c_SubNiveis.cnivels)
1237:             IF EMPTY(loc_cDopesMestre)
1238:                 RETURN
1239:             ENDIF
1240: 
1241:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpCsn", ;
1242:                 "cursor_4c_BuscaSubSub", "cdopes", loc_cValor, ;
1243:                 "Sub-N" + CHR(237) + "veis", .F., .F., ;
1244:                 "cnivels = " + EscaparSQL(loc_cDopesMestre))
1245: 
1246:             IF VARTYPE(loc_oBusca) = "O"
1247:                 IF !loc_oBusca.this_lAchouRegistro
1248:                     loc_oBusca.mAddColuna("cdopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1249:                     loc_oBusca.Show()
1250:                 ENDIF
1251:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSubSub")
1252:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaSubSub.cdopes)
1253:                     THIS.this_lHouveAlt = .T.
1254:                 ENDIF
1255:                 loc_oBusca.Release()
1256:             ENDIF
1257:             IF USED("cursor_4c_BuscaSubSub")
1258:                 USE IN cursor_4c_BuscaSubSub
1259:             ENDIF
1260:         ENDCASE
1261:     ENDPROC
1262: 
1263:     *==========================================================================
1264:     * CelulaSnoLostFocusExec - LostFocus das celulas de lookup.
1265:     *   OPERACAO - legado: If IsEmpty(This.Value) / ThisForm.cmdSair.SetFocus
1266:     *     (linha ficou sem sub-nivel - foca o botao de saida).
1267:     *   SUBSUB   - legado: garante uma linha vazia em crSigOpOss (Append
1268:     *     Blank com cDopes/cNivels/CidChaves da linha mestre) para o usuario
1269:     *     continuar incluindo sub-sub-niveis sem reclicar em Inserir.
1270:     *==========================================================================
1271:     PROCEDURE CelulaSnoLostFocusExec(par_cCelula, par_oTxt)
1272:         LOCAL loc_cDopesMestre, loc_cNivelsMestre, loc_cAliasAnterior, loc_cNovoId
1273: 
1274:         DO CASE
1275:         CASE par_cCelula == "OPERACAO"
1276:             IF EMPTY(ALLTRIM(NVL(par_oTxt.Value, ""))) AND PEMSTATUS(THIS, "cmd_4c_Sair", 5)
1277:                 THIS.cmd_4c_Sair.SetFocus()
1278:             ENDIF
1279: 
1280:         CASE par_cCelula == "SUBSUB"
1281:             IF !EMPTY(ALLTRIM(NVL(par_oTxt.Value, ""))) AND USED("cursor_4c_SubNiveis") ;
1282:                AND USED("cursor_4c_SubSubNiveis")
1283:                 loc_cDopesMestre  = ALLTRIM(cursor_4c_SubNiveis.cdopes)
1284:                 loc_cNivelsMestre = ALLTRIM(cursor_4c_SubNiveis.cnivels)
1285: 
1286:                 loc_cAliasAnterior = ALIAS()
1287:                 SELECT cursor_4c_SubSubNiveis
1288:                 LOCATE FOR ALLTRIM(cnivels) == loc_cNivelsMestre AND EMPTY(dopess)
1289:                 IF !FOUND()
1290:                     loc_cNovoId = fUniqueIds()
1291:                     APPEND BLANK
1292:                     REPLACE cdopes    WITH loc_cDopesMestre, ;
1293:                             cnivels   WITH loc_cNivelsMestre, ;
1294:                             cidchaves WITH loc_cNovoId
1295:                     THIS.this_cCidChavesOssNovas = THIS.this_cCidChavesOssNovas + "|" + loc_cNovoId
1296:                 ENDIF
1297:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1298:                     SELECT (loc_cAliasAnterior)
1299:                 ENDIF
1300: 
1301:                 THIS.grd_4c_SubS.Refresh()
1302:             ENDIF
1303:         ENDCASE
1304:     ENDPROC
1305: 
1306:     *==========================================================================
1307:     * ConfigurarBINDEVENTs - Fase 6: liga os eventos dos controles criados
1308:     * nas fases anteriores aos metodos PUBLIC deste form.
1309:     *
1310:     * As celulas de LOOKUP (Column1/7/8 de grd_4c_SubN e Column1 de
1311:     * grd_4c_SubS) NAO entram aqui: BINDEVENT em When/Valid/LostFocus de
1312:     * TextBox de Column nao eh confiavel (regra #46), por isso esses eventos
1313:     * moram na classe TextBoxCelulaSno_4c, que delega para
1314:     * CelulaSnoEditavel/ValidarCelulaSnoExec/CelulaSnoLostFocusExec.
1315:     *
1316:     * O que se liga por BINDEVENT:
1317:     *   1) Os CheckBox das colunas O/P/C/S/T de grd_4c_SubN. O legado
1318:     *      SUPRIME o toggle nativo (Click/MouseUp = NoDefault) e alterna o
1319:     *      valor por codigo no MouseDown e no KeyPress (13/32) - sem isso a
1320:     *      marca fica inerte (CLAUDE.md, grid checkbox toggle). Transcrito
1321:     *      do dump: nos cinco CheckBox eh o MouseDown que alterna, NAO o
1322:     *      MouseUp.
1323:     *   2) O AfterRowColChange de grd_4c_SubN, que escopa a grade de
1324:     *      sub-sub-niveis ao sub-nivel da linha corrente - uso legitimo do
1325:     *      evento (mestre-detalhe, regra #46), nao validacao de celula.
1326:     *
1327:     * Chamado UMA unica vez (InicializarForm). Os objetos Check1 sobrevivem
1328:     * ao rebind de RecordSource feito em VincularGradeSubN (so reatribuir
1329:     * ColumnCount recria as Columns - regra #183), entao religar depois da
1330:     * carga duplicaria o handler e o toggle se anularia.
1331:     *==========================================================================
1332:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1333:         *-- Botoes principais (cmd_4c_Inserir/Excluir/Sair, criados por
1334:         *-- AddObject - sem BINDEVENT o Click deles nunca dispara)
1335:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
1336:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
1337:         BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "CmdSairClick")
1338: 
1339:         *-- Column3 "O" = Obrigatorio (SigOpCsn.obrigs)
1340:         BINDEVENT(THIS.grd_4c_SubN.Column3.Check1, "MouseDown", THIS, "ChkObrigsMouseDown")
1341:         BINDEVENT(THIS.grd_4c_SubN.Column3.Check1, "MouseUp",   THIS, "ChkObrigsMouseUp")
1342:         BINDEVENT(THIS.grd_4c_SubN.Column3.Check1, "Click",     THIS, "ChkObrigsClick")
1343:         BINDEVENT(THIS.grd_4c_SubN.Column3.Check1, "KeyPress",  THIS, "ChkObrigsKeyPress")
1344: 
1345:         *-- Column4 "P" = Baixa SubNivel do SubNivel c/Pago (SigOpCsn.pgsubnns)
1346:         BINDEVENT(THIS.grd_4c_SubN.Column4.Check1, "MouseDown", THIS, "ChkPgSubNnsMouseDown")
1347:         BINDEVENT(THIS.grd_4c_SubN.Column4.Check1, "MouseUp",   THIS, "ChkPgSubNnsMouseUp")
1348:         BINDEVENT(THIS.grd_4c_SubN.Column4.Check1, "Click",     THIS, "ChkPgSubNnsClick")
1349:         BINDEVENT(THIS.grd_4c_SubN.Column4.Check1, "KeyPress",  THIS, "ChkPgSubNnsKeyPress")
1350: 
1351:         *-- Column5 "C" = Cancela Baixa SubNivel c/Pago (SigOpCsn.cbxpagos)
1352:         BINDEVENT(THIS.grd_4c_SubN.Column5.Check1, "MouseDown", THIS, "ChkCbxPagosMouseDown")
1353:         BINDEVENT(THIS.grd_4c_SubN.Column5.Check1, "MouseUp",   THIS, "ChkCbxPagosMouseUp")
1354:         BINDEVENT(THIS.grd_4c_SubN.Column5.Check1, "Click",     THIS, "ChkCbxPagosClick")
1355:         BINDEVENT(THIS.grd_4c_SubN.Column5.Check1, "KeyPress",  THIS, "ChkCbxPagosKeyPress")
1356: 
1357:         *-- Column6 "S" = Controle de Status Aprovado/Reprovado (SigOpCsn.tstatus)
1358:         BINDEVENT(THIS.grd_4c_SubN.Column6.Check1, "MouseDown", THIS, "ChkTStatusMouseDown")
1359:         BINDEVENT(THIS.grd_4c_SubN.Column6.Check1, "MouseUp",   THIS, "ChkTStatusMouseUp")
1360:         BINDEVENT(THIS.grd_4c_SubN.Column6.Check1, "Click",     THIS, "ChkTStatusClick")
1361:         BINDEVENT(THIS.grd_4c_SubN.Column6.Check1, "KeyPress",  THIS, "ChkTStatusKeyPress")
1362: 
1363:         *-- Column9 "T" = Atualiza Grupo/Conta de Origem (SigOpCsn.ckatcta)
1364:         BINDEVENT(THIS.grd_4c_SubN.Column9.Check1, "MouseDown", THIS, "ChkCkAtCtaMouseDown")
1365:         BINDEVENT(THIS.grd_4c_SubN.Column9.Check1, "MouseUp",   THIS, "ChkCkAtCtaMouseUp")
1366:         BINDEVENT(THIS.grd_4c_SubN.Column9.Check1, "Click",     THIS, "ChkCkAtCtaClick")
1367:         BINDEVENT(THIS.grd_4c_SubN.Column9.Check1, "KeyPress",  THIS, "ChkCkAtCtaKeyPress")
1368: 
1369:         *-- Grade de sub-niveis: troca de linha reescopa a grade de
1370:         *-- sub-sub-niveis (legado: GradeSubN.AfterRowColChange)
1371:         BINDEVENT(THIS.grd_4c_SubN, "AfterRowColChange", THIS, "GradeSubNAfterRowColChange")
1372: 
1373:         RETURN .T.
1374:     ENDPROC
1375: 
1376:     *==========================================================================
1377:     * AlternarMarcaSubN - Alterna 0<->1 a coluna numeric(1,0) da linha
1378:     * corrente de cursor_4c_SubNiveis e repinta a grade.
1379:     *
1380:     * Legado (os cinco CheckBox de grd_4c_SubN, MouseDown e KeyPress):
1381:     *     ThisForm.lHouveAlt = .t.
1382:     *     m.<col> = Iif(crSigOpCsn.<col>=1, 0, 1)
1383:     *     Select crSigOpCsn
1384:     *     Gather Memvar Fields <col>
1385:     *     ThisForm.GradeSubN.Refresh
1386:     *
1387:     * As cinco colunas sao numeric(1,0) NOT NULL no schema (SigOpCsn) - o
1388:     * valor alternado eh NUMERICO, nunca logico. REPLACE (expr) WITH aceita
1389:     * name expression em VFP9, e eh a unica forma correta de gravar campo de
1390:     * cursor escolhido em tempo de execucao (STORE TO () falha em campo).
1391:     *
1392:     * O legado NAO condiciona o toggle ao modo: a marca alterna mesmo em
1393:     * VISUALIZAR, e eh o botao Encerrar que decide se grava (ele so persiste
1394:     * quando Inserir ou Excluir estao visiveis). Transcrito assim de
1395:     * proposito - nao acrescentar guard de modo aqui.
1396:     *
1397:     * par_cCampo : nome da coluna do cursor (obrigs/pgsubnns/cbxpagos/
1398:     *              tstatus/ckatcta)
1399:     *==========================================================================
1400:     PROCEDURE AlternarMarcaSubN(par_cCampo)
1401:         LOCAL loc_cAliasAnterior, loc_lFeito, loc_oErro
1402: 
1403:         loc_lFeito = .F.
1404: 
1405:         TRY
1406:             IF VARTYPE(par_cCampo) = "C" AND !EMPTY(par_cCampo) ;
1407:                AND USED("cursor_4c_SubNiveis")
1408: 
1409:                 loc_cAliasAnterior = ALIAS()
1410:                 SELECT cursor_4c_SubNiveis
1411: 
1412:                 IF !EOF() AND !BOF()
1413:                     THIS.this_lHouveAlt = .T.
1414:                     REPLACE (par_cCampo) WITH IIF(NVL(EVALUATE(par_cCampo), 0) = 1, 0, 1)
1415:                     loc_lFeito = .T.
1416:                 ENDIF
1417: 
1418:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1419:                     SELECT (loc_cAliasAnterior)
1420:                 ENDIF
1421: 
1422:                 IF loc_lFeito AND PEMSTATUS(THIS, "grd_4c_SubN", 5)
1423:                     THIS.grd_4c_SubN.Refresh()
1424:                 ENDIF
1425:             ENDIF
1426:         CATCH TO loc_oErro
1427:             MsgErro(loc_oErro.Message + CHR(13) + ;
1428:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1429:                     "Procedure: " + loc_oErro.Procedure, ;
1430:                     "Erro em AlternarMarcaSubN")
1431:         ENDTRY
1432: 
1433:         RETURN loc_lFeito
1434:     ENDPROC
1435: 
1436:     *==========================================================================
1437:     * Handlers dos CheckBox das colunas O/P/C/S/T de grd_4c_SubN.
1438:     * Um quarteto por coluna porque BINDEVENT nao informa qual controle
1439:     * disparou - os quatro delegam ao funil AlternarMarcaSubN.
1440:     * MouseDown alterna; MouseUp e Click apenas SUPRIMEM o toggle nativo
1441:     * (NODEFAULT), senao o valor alternaria duas vezes e nada mudaria.
1442:     * KeyPress alterna em ENTER(13) e ESPACO(32), igual ao legado.
1443:     *==========================================================================
1444: 
1445:     *-- Column3 "O" = Obrigatorio
1446:     PROCEDURE ChkObrigsMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1447:         THIS.AlternarMarcaSubN("obrigs")
1448:         NODEFAULT
1449:     ENDPROC
1450: 
1451:     PROCEDURE ChkObrigsMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1452:         NODEFAULT
1453:     ENDPROC
1454: 
1455:     PROCEDURE ChkObrigsClick()
1456:         NODEFAULT
1457:     ENDPROC
1458: 
1459:     PROCEDURE ChkObrigsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1460:         IF INLIST(par_nKeyCode, 13, 32)
1461:             THIS.AlternarMarcaSubN("obrigs")
1462:             NODEFAULT
1463:         ENDIF
1464:     ENDPROC
1465: 
1466:     *-- Column4 "P" = Baixa SubNivel do SubNivel c/Pago
1467:     PROCEDURE ChkPgSubNnsMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1468:         THIS.AlternarMarcaSubN("pgsubnns")
1469:         NODEFAULT
1470:     ENDPROC
1471: 
1472:     PROCEDURE ChkPgSubNnsMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1473:         NODEFAULT
1474:     ENDPROC
1475: 
1476:     PROCEDURE ChkPgSubNnsClick()
1477:         NODEFAULT
1478:     ENDPROC
1479: 
1480:     PROCEDURE ChkPgSubNnsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1481:         IF INLIST(par_nKeyCode, 13, 32)
1482:             THIS.AlternarMarcaSubN("pgsubnns")
1483:             NODEFAULT
1484:         ENDIF
1485:     ENDPROC
1486: 
1487:     *-- Column5 "C" = Cancela Baixa SubNivel do SubNivel c/Pago
1488:     PROCEDURE ChkCbxPagosMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1489:         THIS.AlternarMarcaSubN("cbxpagos")
1490:         NODEFAULT
1491:     ENDPROC
1492: 
1493:     PROCEDURE ChkCbxPagosMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1494:         NODEFAULT
1495:     ENDPROC
1496: 
1497:     PROCEDURE ChkCbxPagosClick()
1498:         NODEFAULT
1499:     ENDPROC
1500: 
1501:     PROCEDURE ChkCbxPagosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1502:         IF INLIST(par_nKeyCode, 13, 32)
1503:             THIS.AlternarMarcaSubN("cbxpagos")
1504:             NODEFAULT
1505:         ENDIF
1506:     ENDPROC
1507: 
1508:     *-- Column6 "S" = Controle de Status (Aprovado/Reprovado)
1509:     PROCEDURE ChkTStatusMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1510:         THIS.AlternarMarcaSubN("tstatus")
1511:         NODEFAULT
1512:     ENDPROC
1513: 
1514:     PROCEDURE ChkTStatusMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1515:         NODEFAULT
1516:     ENDPROC
1517: 
1518:     PROCEDURE ChkTStatusClick()
1519:         NODEFAULT
1520:     ENDPROC
1521: 
1522:     PROCEDURE ChkTStatusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1523:         IF INLIST(par_nKeyCode, 13, 32)
1524:             THIS.AlternarMarcaSubN("tstatus")
1525:             NODEFAULT
1526:         ENDIF
1527:     ENDPROC
1528: 
1529:     *-- Column9 "T" = Atualiza Grupo e Conta de Origem conforme o SubNivel
1530:     PROCEDURE ChkCkAtCtaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1531:         THIS.AlternarMarcaSubN("ckatcta")
1532:         NODEFAULT
1533:     ENDPROC
1534: 
1535:     PROCEDURE ChkCkAtCtaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1536:         NODEFAULT
1537:     ENDPROC
1538: 
1539:     PROCEDURE ChkCkAtCtaClick()
1540:         NODEFAULT
1541:     ENDPROC
1542: 
1543:     PROCEDURE ChkCkAtCtaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1544:         IF INLIST(par_nKeyCode, 13, 32)
1545:             THIS.AlternarMarcaSubN("ckatcta")
1546:             NODEFAULT
1547:         ENDIF
1548:     ENDPROC
1549: 
1550:     *==========================================================================
1551:     * GradeSubNAfterRowColChange - escopa grd_4c_SubS ao sub-nivel da linha
1552:     * corrente de grd_4c_SubN (mestre-detalhe). Uso LEGITIMO de
1553:     * AfterRowColChange (regra #46): nao valida celula nenhuma, so reage a
1554:     * troca de linha - por isso NAO filtra por par_nColIndex.
1555:     *
1556:     * Legado (GradeSubN.AfterRowColChange):
1557:     *     Select CrSigOpOss
1558:     *     Set Order To
1559:     *     Set Order To cNivels
1560:     *     Locate For cNivels = crSigOpCsn.cNivels
1561:     *     If Eof()
1562:     *         Append Blank
1563:     *         Replace cNivels With ..., cDopes With ..., CidChaves with fUniqueIds()
1564:     *     Endif
1565:     *     Set Key To crSigOpCsn.cNivels
1566:     *     Go Top
1567:     *     ThisForm.GradeSubS.Refresh
1568:     *     Select CrSigOpCsn
1569:     *
1570:     * O "Set Order To" sem argumento ANTES do "Set Order To cNivels" eh o que
1571:     * derruba o SET KEY da linha anterior - sem ele o LOCATE sairia escopado
1572:     * pelo filtro antigo e sempre cairia em Eof(), inserindo uma linha em
1573:     * branco a cada troca de linha. A chave passada ao SET KEY eh o cnivels
1574:     * INTEIRO (char(20) do cursor), nao um prefixo: com SET EXACT ON ligado
1575:     * no config.prg, chave parcial devolveria zero linhas.
1576:     *
1577:     * O APPEND BLANK grava so no cursor local (a persistencia eh do Encerrar).
1578:     *==========================================================================
1579:     PROCEDURE GradeSubNAfterRowColChange(par_nColIndex)
1580:         LOCAL loc_cNivelsMestre, loc_cDopesMestre, loc_oErro, loc_cNovoId
1581: 
1582:         TRY
1583:             IF USED("cursor_4c_SubNiveis") AND USED("cursor_4c_SubSubNiveis")
1584:                 SELECT cursor_4c_SubNiveis
1585:                 IF !EOF() AND !BOF()
1586:                     loc_cNivelsMestre = cursor_4c_SubNiveis.cnivels
1587:                     loc_cDopesMestre  = cursor_4c_SubNiveis.cdopes
1588: 
1589:                     SELECT cursor_4c_SubSubNiveis
1590:                     SET ORDER TO
1591:                     SET ORDER TO cnivels
1592:                     LOCATE FOR cnivels = loc_cNivelsMestre
1593:                     IF EOF()
1594:                         loc_cNovoId = fUniqueIds()
1595:                         APPEND BLANK
1596:                         REPLACE cnivels   WITH loc_cNivelsMestre, ;
1597:                                 cdopes    WITH loc_cDopesMestre,  ;
1598:                                 cidchaves WITH loc_cNovoId
1599:                         THIS.this_cCidChavesOssNovas = THIS.this_cCidChavesOssNovas + "|" + loc_cNovoId
1600:                     ENDIF
1601:                     SET KEY TO loc_cNivelsMestre
1602:                     GO TOP
1603: 
1604:                     IF PEMSTATUS(THIS, "grd_4c_SubS", 5)
1605:                         THIS.grd_4c_SubS.Refresh()
1606:                     ENDIF
1607: 
1608:                     SELECT cursor_4c_SubNiveis
1609:                 ENDIF
1610:             ENDIF
1611:         CATCH TO loc_oErro
1612:             MsgErro(loc_oErro.Message + CHR(13) + ;
1613:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1614:                     "Procedure: " + loc_oErro.Procedure, ;
1615:                     "Erro em GradeSubNAfterRowColChange")
1616:         ENDTRY
1617:     ENDPROC
1618: 
1619:     *==========================================================================
1620:     * CmdInserirClick - cmd_4c_Inserir.Click (so visivel em modo direto -
1621:     * ConfigurarBotoes). Transcrito do legado:
1622:     *     Thisform.lHouveIns = .T.
1623:     *     Select crSigOpCsn
1624:     *     Locate for cDopes = crSigCdOpe.Dopes .and. cnivels = Space(20)
1625:     *     If Eof()
1626:     *         Insert Into crSigOpCsn (cDopes, CidChaves) Values (crSigCdOpe.
1627:     *             Dopes, fUniqueIds())
1628:     *     Endif
1629:     *     Thisform.GradeSubN.Column1.SetFocus
1630:     *
1631:     * So cria a linha em BRANCO no cursor LOCAL - igual ao legado (view
1632:     * buferizada), a gravacao no SQL Server so acontece no Encerrar
1633:     * (PersistirSubNiveis). A linha nova entra em this_cCidChavesNovas para
1634:     * o funil de gravacao saber que eh INSERT, nao UPDATE.
1635:     *==========================================================================
1636:     PROCEDURE CmdInserirClick()
1637:         LOCAL loc_cAliasAnterior, loc_cCidChaves, loc_oErro
1638: 
1639:         TRY
1640:             IF USED("cursor_4c_SubNiveis")
1641:                 THIS.this_lHouveIns = .T.
1642: 
1643:                 loc_cAliasAnterior = ALIAS()
1644:                 SELECT cursor_4c_SubNiveis
1645: 
1646:                 LOCATE FOR ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai) AND EMPTY(cnivels)
1647:                 IF !FOUND()
1648:                     loc_cCidChaves = fUniqueIds()
1649:                     APPEND BLANK
1650:                     REPLACE cdopes    WITH THIS.this_cOperacaoPai, ;
1651:                             cidchaves WITH loc_cCidChaves
1652:                     THIS.this_cCidChavesNovas = THIS.this_cCidChavesNovas + "|" + loc_cCidChaves
1653:                 ENDIF
1654: 
1655:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1656:                     SELECT (loc_cAliasAnterior)
1657:                 ENDIF
1658: 
1659:                 IF PEMSTATUS(THIS, "grd_4c_SubN", 5)
1660:                     THIS.grd_4c_SubN.Refresh()
1661:                     THIS.grd_4c_SubN.SetFocus()
1662:                     THIS.grd_4c_SubN.ActiveColumn = 1
1663:                 ENDIF
1664:             ENDIF
1665:         CATCH TO loc_oErro
1666:             MsgErro(loc_oErro.Message + CHR(13) + ;
1667:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1668:                     "Procedure: " + loc_oErro.Procedure, ;
1669:                     "Erro em CmdInserirClick")
1670:         ENDTRY
1671:     ENDPROC
1672: 
1673:     *==========================================================================
1674:     * CmdExcluirClick - cmd_4c_Excluir.Click (so visivel em modo direto).
1675:     * Transcrito do legado:
1676:     *     Select crSigOpCsn
1677:     *     If Not Eof() And (crSigOpCsn.cDopes = crSigCdOpe.Dopes)
1678:     *         Thisform.lHouveExcl = .T.
1679:     *         Delete
1680:     *         Skip
1681:     *         Skip - 1
1682:     *     Endif
1683:     *     Thisform.GradeSubN.Refresh
1684:     *
1685:     * So marca a linha corrente como excluida no cursor LOCAL (SET DELETED
1686:     * ON, fixado pelo FormBase para DataSession=2, esconde a linha da grade
1687:     * de imediato) - o DELETE efetivo no SQL Server so acontece no Encerrar
1688:     * (PersistirSubNiveis), e so quando a linha ja existia no banco (linha
1689:     * nova excluida antes de salvar so some, sem SQL nenhum).
1690:     *==========================================================================
1691:     PROCEDURE CmdExcluirClick()
1692:         LOCAL loc_oErro
1693: 
1694:         TRY
1695:             IF USED("cursor_4c_SubNiveis")
1696:                 SELECT cursor_4c_SubNiveis
1697:                 IF !EOF() AND ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai)
1698:                     THIS.this_lHouveExcl = .T.
1699:                     DELETE
1700:                     SKIP
1701:                     SKIP -1
1702:                 ENDIF
1703:             ENDIF
1704: 
1705:             IF PEMSTATUS(THIS, "grd_4c_SubN", 5)
1706:                 THIS.grd_4c_SubN.Refresh()
1707:             ENDIF
1708:         CATCH TO loc_oErro
1709:             MsgErro(loc_oErro.Message + CHR(13) + ;
1710:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1711:                     "Procedure: " + loc_oErro.Procedure, ;
1712:                     "Erro em CmdExcluirClick")
1713:         ENDTRY
1714:     ENDPROC
1715: 
1716:     *==========================================================================
1717:     * CmdSairClick - cmd_4c_Sair.Click (Cancel = .T. - tambem dispara no ESC).
1718:     * Transcrito do legado:
1719:     *     If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1720:     *         If (Thisform.lHouveExcl Or Thisform.lHouveIns Or ThisForm.lHouveAlt)
1721:     *             Select CrSigOpOss / Set Order To / Delete For DopeSS = ' '
1722:     *             ... TableUpdate('crSigOpCsn') + TableUpdate('crSigOpOss') +
1723:     *                 Commit, com RollBack e MessageBox se qualquer etapa falhar
1724:     *         Endif
1725:     *     ENDIF
1726:     *     Thisform.ParentForm.Enabled = .T.
1727:     *     Thisform.mCtrlBotoes(.T.)
1728:     *     ThisForm.Release
1729:     *
1730:     * "Thisform.ParentForm.Enabled = .T." e o reabilitar do pai ja sao feitos
1731:     * no Destroy() deste form (chamado por Release()); "mCtrlBotoes(.T.)" do
1732:     * legado reabilita BOTOES especificos do pai porque la o pai so ficava
1733:     * com os controles desabilitados individualmente - aqui o Init ja
1734:     * desabilita o FORM PAI INTEIRO (This.this_oParentForm.Enabled = .F.),
1735:     * entao reabilitar o form basta, sem metodo equivalente a chamar.
1736:     *
1737:     * Modo VISUALIZAR/inverso (Inserir e Excluir ambos invisiveis): o legado
1738:     * NAO persiste nada, so fecha - mesmo que o usuario tenha mexido nos
1739:     * CheckBox (this_lHouveAlt), que alternam independente do modo.
1740:     *==========================================================================
1741:     PROCEDURE CmdSairClick()
1742:         LOCAL loc_lPrecisaPersistir, loc_lSucesso, loc_cAliasAnterior, loc_oErro
1743: 
1744:         loc_lSucesso = .T.
1745: 
1746:         TRY
1747:             IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible
1748:                 loc_lPrecisaPersistir = THIS.this_lHouveExcl OR THIS.this_lHouveIns OR THIS.this_lHouveAlt
1749: 
1750:                 IF loc_lPrecisaPersistir
1751:                     *-- Legado: Select CrSigOpOss / Set Order To / Delete For
1752:                     *-- DopeSS = ' ' - descarta sub-sub-niveis cujo codigo
1753:                     *-- nunca foi preenchido (novos abandonados ou existentes
1754:                     *-- que o usuario apagou), ANTES de persistir
1755:                     IF USED("cursor_4c_SubSubNiveis")
1756:                         loc_cAliasAnterior = ALIAS()
1757:                         SELECT cursor_4c_SubSubNiveis
1758:                         SET ORDER TO
1759:                         DELETE FOR EMPTY(ALLTRIM(NVL(dopess, "")))
1760:                         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1761:                             SELECT (loc_cAliasAnterior)
1762:                         ENDIF
1763:                     ENDIF
1764: 
1765:                     loc_lSucesso = THIS.PersistirSubNiveis() AND THIS.PersistirSubSubNiveis()
1766: 
1767:                     IF !loc_lSucesso
1768:                         MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o dos dados do Cadastro de " + ;
1769:                             "Opera" + CHR(231) + CHR(245) + "es.", "Erro")
1770:                     ENDIF
1771:                 ENDIF
1772:             ENDIF
1773:         CATCH TO loc_oErro
1774:             loc_lSucesso = .F.
1775:             MsgErro(loc_oErro.Message + CHR(13) + ;
1776:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1777:                     "Procedure: " + loc_oErro.Procedure, ;
1778:                     "Erro em CmdSairClick")
1779:         ENDTRY
1780: 
1781:         *-- So fecha se a gravacao deu certo (ou nao havia nada a gravar) -
1782:         *-- em erro, o usuario pode corrigir o dado e tentar de novo
1783:         IF loc_lSucesso
1784:             THIS.Release()
1785:         ENDIF
1786:     ENDPROC
1787: 
1788:     *==========================================================================
1789:     * PersistirSubNiveis - grava no SQL Server as linhas de cursor_4c_
1790:     * SubNiveis (SigOpCsn) alteradas nesta sessao - exclusoes primeiro,
1791:     * depois inclusoes/atualizacoes. Chamado so por CmdSairClick.
1792:     *
1793:     * Sem buffer de VFP (sem TableUpdate), a persistencia eh linha-a-linha
1794:     * via SQLEXEC (this_oBusinessObject.Salvar/Excluir) em vez de duas
1795:     * chamadas em bloco - o resultado final (tudo gravado, ou erro reportado
1796:     * e NADA de novo persistido a partir do ponto de falha) eh equivalente.
1797:     *
1798:     * Transcricao fiel ao legado (regra #17): o Encerrar legado NAO filtra
1799:     * linhas de SigOpCsn com cnivels em branco antes de gravar - so filtra
1800:     * SigOpOss (feito em CmdSairClick, antes de chamar este metodo).
1801:     *==========================================================================
1802:     PROTECTED PROCEDURE PersistirSubNiveis()
1803:         LOCAL loc_cAliasAnterior, loc_lSucesso, loc_cCidChaves, loc_lNovo, loc_cDeletedStatus
1804: 
1805:         loc_lSucesso = .T.
1806: 
1807:         IF !USED("cursor_4c_SubNiveis")
1808:             RETURN .T.
1809:         ENDIF
1810: 
1811:         loc_cAliasAnterior = ALIAS()
1812:         SELECT cursor_4c_SubNiveis
1813: 
1814:         *-- Exclusoes - so chama Excluir() no banco quando a linha ja
1815:         *-- existia antes desta sessao (linha nova excluida sem nunca ter
1816:         *-- sido gravada so some do cursor local, sem SQL). Com SET DELETED
1817:         *-- ON (InicializarForm), SCAN pula as linhas marcadas ANTES mesmo de
1818:         *-- avaliar o FOR - abrir mao disso temporariamente para alcancar as
1819:         *-- linhas excluidas (mesmo padrao de PersistirSubSubNiveis).
1820:         loc_cDeletedStatus = SET("DELETED")
1821:         SET DELETED OFF
1822:         SCAN FOR DELETED()
1823:             loc_cCidChaves = ALLTRIM(cidchaves)
1824:             IF !EMPTY(loc_cCidChaves) AND ;
1825:                !("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesNovas + "|"))
1826:                 THIS.this_oBusinessObject.this_cCidChaves = loc_cCidChaves
1827:                 IF !THIS.this_oBusinessObject.Excluir()
1828:                     loc_lSucesso = .F.
1829:                 ENDIF
1830:             ENDIF
1831:         ENDSCAN
1832:         SET DELETED &loc_cDeletedStatus
1833: 
1834:         *-- Inclusoes/atualizacoes das linhas vivas
1835:         SCAN FOR !DELETED()
1836:             loc_cCidChaves = ALLTRIM(cidchaves)
1837:             loc_lNovo      = ("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesNovas + "|"))
1838: 
1839:             WITH THIS.this_oBusinessObject
1840:                 .this_cCidChaves  = loc_cCidChaves
1841:                 .this_cCDopes     = ALLTRIM(cursor_4c_SubNiveis.cdopes)
1842:                 .this_cCNivels    = ALLTRIM(cursor_4c_SubNiveis.cnivels)
1843:                 .this_nObrigs     = NVL(cursor_4c_SubNiveis.obrigs, 0)
1844:                 .this_nPgSubNNs   = NVL(cursor_4c_SubNiveis.pgsubnns, 0)
1845:                 .this_nCBxPagos   = NVL(cursor_4c_SubNiveis.cbxpagos, 0)
1846:                 .this_nTStatus    = NVL(cursor_4c_SubNiveis.tstatus, 0)
1847:                 .this_nCkAtCta    = NVL(cursor_4c_SubNiveis.ckatcta, 0)
1848:                 .this_nTrfCtaDSor = NVL(cursor_4c_SubNiveis.trfctadsor, 0)
1849:                 .this_nCodObs     = NVL(cursor_4c_SubNiveis.codobs, 0)
1850:                 .this_cTpFats     = ALLTRIM(NVL(cursor_4c_SubNiveis.tpfats, ""))
1851:             ENDWITH
1852: 
1853:             IF loc_lNovo
1854:                 THIS.this_oBusinessObject.NovoRegistro()
1855:             ELSE
1856:                 THIS.this_oBusinessObject.EditarRegistro()
1857:             ENDIF

*-- Linhas 1872 a 1924:
1872:     * PersistirSubSubNiveis - grava no SQL Server as linhas de cursor_4c_
1873:     * SubSubNiveis (SigOpOss) alteradas nesta sessao. Chamado so por
1874:     * CmdSairClick, DEPOIS do "Delete For Empty(dopess)" que descarta as
1875:     * linhas em branco (feito em CmdSairClick).
1876:     *
1877:     * Nao ha botao de exclusao individual para grd_4c_SubS no legado - a
1878:     * UNICA forma de remover um sub-sub-nivel eh apagar o codigo digitado
1879:     * (fica com dopess em branco), por isso a exclusao aqui so trata linhas
1880:     * que o "Delete For Empty(dopess)" marcou E que ja existiam no banco
1881:     * (this_cCidChavesOssOriginais); linha nova descartada em branco nunca
1882:     * chega a existir no SQL Server.
1883:     *==========================================================================
1884:     PROTECTED PROCEDURE PersistirSubSubNiveis()
1885:         LOCAL loc_cAliasAnterior, loc_lSucesso, loc_cCidChaves, loc_cDeletedStatus
1886: 
1887:         loc_lSucesso = .T.
1888: 
1889:         IF !USED("cursor_4c_SubSubNiveis")
1890:             RETURN .T.
1891:         ENDIF
1892: 
1893:         loc_cAliasAnterior = ALIAS()
1894:         SELECT cursor_4c_SubSubNiveis
1895: 
1896:         *-- Exclusoes - as linhas marcadas Delete (dopess em branco) ficam
1897:         *-- escondidas do SCAN normal por SET DELETED ON; abrir mao disso
1898:         *-- temporariamente so para varrer as marcadas
1899:         loc_cDeletedStatus = SET("DELETED")
1900:         SET DELETED OFF
1901:         SCAN FOR DELETED()
1902:             loc_cCidChaves = ALLTRIM(cidchaves)
1903:             IF !EMPTY(loc_cCidChaves) AND ;
1904:                ("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesOssOriginais + "|")) AND ;
1905:                !("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesOssNovas + "|"))
1906:                 THIS.this_oBusinessObject.this_cCidChavesOss = loc_cCidChaves
1907:                 IF !THIS.this_oBusinessObject.ExcluirSubSubNivel()
1908:                     loc_lSucesso = .F.
1909:                 ENDIF
1910:             ENDIF
1911:         ENDSCAN
1912:         SET DELETED &loc_cDeletedStatus
1913: 
1914:         *-- Inclusoes/atualizacoes das linhas vivas (dopess preenchido)
1915:         SCAN FOR !DELETED()
1916:             loc_cCidChaves = ALLTRIM(cidchaves)
1917: 
1918:             WITH THIS.this_oBusinessObject
1919:                 .this_cCidChavesOss = loc_cCidChaves
1920:                 .this_cCDopesOss    = ALLTRIM(cursor_4c_SubSubNiveis.cdopes)
1921:                 .this_cCNivelsOss   = ALLTRIM(cursor_4c_SubSubNiveis.cnivels)
1922:                 .this_cDopess       = ALLTRIM(cursor_4c_SubSubNiveis.dopess)
1923:             ENDWITH
1924: 

*-- Linhas 1941 a 1976:
1941:     ENDPROC
1942: 
1943:     *==========================================================================
1944:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1945:     * Este form nao possui containers flutuantes (sem filtro de excecao)
1946:     *==========================================================================
1947:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1948:         LOCAL loc_nI, loc_oControl
1949: 
1950:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1951:             loc_oControl = par_oContainer.Controls(loc_nI)
1952:             IF VARTYPE(loc_oControl) = "O"
1953:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1954:                     loc_oControl.Visible = .T.
1955:                 ENDIF
1956:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1957:                    loc_oControl.ControlCount > 0
1958:                     THIS.TornarControlesVisiveis(loc_oControl)
1959:                 ENDIF
1960:             ENDIF
1961:         ENDFOR
1962:     ENDPROC
1963: 
1964:     *==========================================================================
1965:     * Destroy - Reabilita o form pai ao fechar este popup
1966:     *==========================================================================
1967:     PROCEDURE Destroy()
1968:         IF VARTYPE(THIS.this_oParentForm) = "O"
1969:             THIS.this_oParentForm.Enabled = .T.
1970:             THIS.this_oParentForm         = .NULL.
1971:         ENDIF
1972: 
1973:         DODEFAULT()
1974:     ENDPROC
1975: 
1976: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpSnoBO.prg):
*==============================================================================
* SigOpSnoBO.prg - Business Object para Sub-Niveis da Operacao
* Tabela principal: SigOpCsn | PK: cidchaves
* Tabela secundaria: SigOpOss (Sub-Sub-Nivel por Sub-Nivel) | PK: cidchaves
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpSnoBO AS BusinessBase

    *-- Propriedades da entidade principal (mapeamento para tabela SigOpCsn)
    *-- PK
    this_cCidChaves     = ""    && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())

    *-- Chaves de relacionamento
    this_cCDopes        = ""    && cdopes char(20) NOT NULL - FK SigCdOpe.dopes (operacao pai)
    this_cCNivels       = ""    && cnivels char(20) NOT NULL - FK SigCdOpe.dopes (operacao usada como sub-nivel)

    *-- Flags / controles (numeric(1,0)) - ver CheckBox das colunas O/P/C/S/T da grade
    this_nObrigs        = 0     && obrigs numeric(1,0) NOT NULL - "O" = Obrigatorio
    this_nPgSubNNs      = 0     && pgsubnns numeric(1,0) NOT NULL - "P" = Bx SubNivel do SubNivel c/Pago
    this_nCBxPagos      = 0     && cbxpagos numeric(1,0) NOT NULL - "C" = Cancela Bx SubNivel do SubNivel c/Pago
    this_nTStatus       = 0     && tstatus numeric(1,0) NOT NULL - "S" = Controle de Status (Aprovado/Reprovado)
    this_nCkAtCta       = 0     && ckatcta numeric(1,0) NOT NULL - "T" = Atualiza o Grupo e Conta de Origem conforme o SubNivel
    this_nTrfCtaDSor    = 0     && trfctadsor numeric(1,0) NOT NULL - sem controle na tela (grava 0 - regra de INSERT NOT NULL)

    *-- Lookups
    this_nCodObs        = 0     && codobs numeric(3,0) NOT NULL - FK SigCdObs.Codigos (Observacao)
    this_cTpFats        = ""    && tpfats char(3) NOT NULL - FK SigCdTif.Codigos (Tipo de Faturamento)

    *-- Campo de exibicao (JOIN com SigCdOpe, somente leitura, nao persiste em SigOpCsn)
    this_nNDopes        = 0     && SigCdOpe.ndopes - numero sequencial da operacao (exibido no modo inverso)

    *-- Propriedades da entidade secundaria (tabela SigOpOss - sub-sub-nivel por sub-nivel)
    this_cCidChavesOss  = ""    && cidchaves char(20) NOT NULL - PK de SigOpOss (gerada com fUniqueIds())
    this_cCDopesOss     = ""    && cdopes char(20) NOT NULL - FK SigCdOpe.dopes (operacao pai, copiado de this_cCDopes)
    this_cCNivelsOss    = ""    && cnivels char(20) NOT NULL - FK copiado de this_cCNivels (sub-nivel ao qual pertence)
    this_cDopess        = ""    && dopess char(20) NOT NULL - FK SigCdOpe.dopes (sub-sub-nivel)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpCsn"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades do sub-nivel a partir de um
    * cursor posicionado em uma linha de SigOpCsn (ou de um SELECT que inclua
    * as mesmas colunas + o campo de exibicao opcional "ndopes", vindo do
    * JOIN com SigCdOpe)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCDopes     = TratarNulo(cdopes,     "C")
                THIS.this_cCNivels    = TratarNulo(cnivels,    "C")
                THIS.this_nObrigs     = TratarNulo(obrigs,     "N")
                THIS.this_nPgSubNNs   = TratarNulo(pgsubnns,   "N")
                THIS.this_nCBxPagos   = TratarNulo(cbxpagos,   "N")
                THIS.this_nTStatus    = TratarNulo(tstatus,    "N")
                THIS.this_nCkAtCta    = TratarNulo(ckatcta,    "N")
                THIS.this_nTrfCtaDSor = TratarNulo(trfctadsor, "N")
                THIS.this_nCodObs     = TratarNulo(codobs,     "N")
                THIS.this_cTpFats     = TratarNulo(tpfats,     "C")

                *-- Campo de exibicao vindo do JOIN com SigCdOpe (presente so
                *-- quando o SELECT que populou o cursor o incluiu)
                IF TYPE(par_cAliasCursor + ".ndopes") != "U"
                    THIS.this_nNDopes = TratarNulo(ndopes, "N")
                ENDIF

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui um novo sub-nivel (linha de SigOpCsn) no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- cidchaves eh a PK Fortyus (regra #22): gerar com fUniqueIds(),
            *-- NUNCA deixar vazia - senao o 2o registro colide no indice unico
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpCsn" + ;
                       " (cdopes, cnivels, cidchaves, obrigs, cbxpagos, codobs," + ;
                       "  pgsubnns, tstatus, tpfats, ckatcta, trfctadsor)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopes) + ", " + ;
                       EscaparSQL(THIS.this_cCNivels) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nObrigs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCBxPagos, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodObs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPgSubNNs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTStatus, 0) + ", " + ;
                       EscaparSQL(THIS.this_cTpFats) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCkAtCta, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTrfCtaDSor, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSno")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSno")
                USE IN cursor_4c_InsSno
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um sub-nivel (linha de SigOpCsn) existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpCsn SET" + ;
                       " cdopes     = " + EscaparSQL(THIS.this_cCDopes) + "," + ;
                       " cnivels    = " + EscaparSQL(THIS.this_cCNivels) + "," + ;
                       " obrigs     = " + FormatarNumeroSQL(THIS.this_nObrigs, 0) + "," + ;
                       " cbxpagos   = " + FormatarNumeroSQL(THIS.this_nCBxPagos, 0) + "," + ;
                       " codobs     = " + FormatarNumeroSQL(THIS.this_nCodObs, 0) + "," + ;
                       " pgsubnns   = " + FormatarNumeroSQL(THIS.this_nPgSubNNs, 0) + "," + ;
                       " tstatus    = " + FormatarNumeroSQL(THIS.this_nTStatus, 0) + "," + ;
                       " tpfats     = " + EscaparSQL(THIS.this_cTpFats) + "," + ;
                       " ckatcta    = " + FormatarNumeroSQL(THIS.this_nCkAtCta, 0) + "," + ;
                       " trfctadsor = " + FormatarNumeroSQL(THIS.this_nTrfCtaDSor, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSno")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSno")
                USE IN cursor_4c_UpdSno
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove um sub-nivel (linha de SigOpCsn) do banco.
    * Remove TAMBEM os sub-sub-niveis (SigOpOss) que dependem dele, pois o
    * legado permite excluir o sub-nivel so quando ele ainda eh o corrente na
    * grade (cmdExcluir.Click do SCX) e nao deixa registros orfaos em SigOpOss.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOss" + ;
                       " WHERE cidchaves IN (" + ;
                       " SELECT cidchaves FROM SigOpCsn WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelOssDep")
            IF USED("cursor_4c_DelOssDep")
                USE IN cursor_4c_DelOssDep
            ENDIF

            loc_cSQL = "DELETE FROM SigOpCsn" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelSno")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelSno")
                USE IN cursor_4c_DelSno
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarSubNiveis - Popula cursor_4c_SubNiveis com os sub-niveis da
    * operacao (modo direto, equivalente ao legado "ReQuery('crSigOpCsn')"
    * filtrado por cdopes) ou com as operacoes que usam a operacao como
    * sub-nivel (modo inverso, equivalente ao "lcSql = Select a.*,b.nDopes
    * From SigOpCsn a Inner Join SigCdOpe b ... Where a.cNivels = ...").
    *
    * O JOIN com SigCdOpe traz ndopes (Column2 "#" da grade) da OPERACAO QUE
    * VARIA linha a linha - cnivels no modo direto (a coluna que o usuario
    * escolhe via lookup em cada sub-nivel), cdopes no modo inverso -, NUNCA
    * da coluna fixa pelo filtro WHERE. Juntar sempre por a.cdopes faria toda
    * linha, em modo direto, mostrar o ndopes da OPERACAO PAI repetido (pai
    * eh fixo pelo WHERE), em vez do ndopes de cada sub-nivel escolhido.
    * LEFT JOIN (nao INNER): linha com a coluna variavel ainda vazia (recem
    * inserida, antes do lookup) nao pode desaparecer do cursor.
    * Cursor READWRITE (regra sobre Grid com coluna editavel): as colunas O/
    * P/C/S/T sao CheckBox de grade e o codigo/observacao/tipo de fat. sao
    * TextBox editaveis na grade.
    *--------------------------------------------------------------------------
    FUNCTION ListarSubNiveis(par_cOperacaoPai, par_lModoInverso)
        LOCAL loc_cOperacaoPai, loc_lInverso, loc_cCampoFiltro, loc_cCampoJoin, ;
              loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")
        loc_lInverso     = IIF(VARTYPE(par_lModoInverso) = "L", par_lModoInverso, .F.)
        loc_cCampoFiltro = IIF(loc_lInverso, "a.cnivels", "a.cdopes")
        loc_cCampoJoin   = IIF(loc_lInverso, "a.cdopes", "a.cnivels")

        TRY
            loc_cSQL = "SELECT a.*, b.ndopes AS ndopes" + ;
                       " FROM SigOpCsn a LEFT JOIN SigCdOpe b ON " + loc_cCampoJoin + " = b.dopes" + ;
                       " WHERE " + loc_cCampoFiltro + " = " + EscaparSQL(loc_cOperacaoPai) + ;
                       " ORDER BY a.cnivels"

            IF USED("cursor_4c_SubNivTmp")
                USE IN cursor_4c_SubNivTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubNivTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SubNiveis")
                    USE IN cursor_4c_SubNiveis
                ENDIF
                SELECT * FROM cursor_4c_SubNivTmp INTO CURSOR cursor_4c_SubNiveis READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar sub-n" + CHR(237) + "veis da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SubNivTmp")
                USE IN cursor_4c_SubNivTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ListarSubNiveis:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ListarSubSubNiveis - Popula cursor_4c_SubSubNiveis com os sub-sub-niveis
    * (SigOpOss) da operacao, equivalente ao legado "lcSql = Select * From
    * SigOpOss Where cDopes = ...", igual nos dois modos (direto/inverso).
    * Cursor READWRITE: a grade de sub-sub-niveis recebe linhas novas via
    * Append Blank no AfterRowColChange da grade de sub-niveis (Fase 8).
    *--------------------------------------------------------------------------
    FUNCTION ListarSubSubNiveis(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")

        TRY
            loc_cSQL = "SELECT * FROM SigOpOss" + ;
                       " WHERE cdopes = " + EscaparSQL(loc_cOperacaoPai)

            IF USED("cursor_4c_SubSubNivTmp")
                USE IN cursor_4c_SubSubNivTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubSubNivTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SubSubNiveis")
                    USE IN cursor_4c_SubSubNiveis
                ENDIF
                SELECT * FROM cursor_4c_SubSubNivTmp INTO CURSOR cursor_4c_SubSubNiveis READWRITE
                INDEX ON cnivels TAG cnivels
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar sub-sub-n" + CHR(237) + "veis da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SubSubNivTmp")
                USE IN cursor_4c_SubSubNivTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ListarSubSubNiveis:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSubSubNivelDoCursor - Carrega as propriedades do sub-sub-nivel
    * (SigOpOss) a partir de um cursor posicionado numa linha dessa tabela.
    * PUBLIC: chamado diretamente pelo Form (padrao operacional, regra do
    * cabecalho de BusinessBase sobre Inserir/Atualizar/Oss serem chamados
    * de fora em telas que nao seguem o fluxo unico de FormParaBO/BOParaForm).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubSubNivelDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChavesOss = TratarNulo(cidchaves, "C")
                THIS.this_cCDopesOss    = TratarNulo(cdopes,    "C")
                THIS.this_cCNivelsOss   = TratarNulo(cnivels,   "C")
                THIS.this_cDopess       = TratarNulo(dopess,    "C")
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirSubSubNivel - Inclui um novo sub-sub-nivel (linha de SigOpOss)
    *--------------------------------------------------------------------------
    PROCEDURE InserirSubSubNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCidChavesOss)
                THIS.this_cCidChavesOss = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpOss (cdopes, cidchaves, cnivels, dopess)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopesOss) + ", " + ;
                       EscaparSQL(THIS.this_cCidChavesOss) + ", " + ;
                       EscaparSQL(THIS.this_cCNivelsOss) + ", " + ;
                       EscaparSQL(THIS.this_cDopess) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsOss")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sub-sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsOss")
                USE IN cursor_4c_InsOss
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.InserirSubSubNivel:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSubSubNivel - Atualiza o sub-sub-nivel (dopess) de uma linha
    * de SigOpOss ja existente. O legado (view remota com buffer) nao
    * precisa disso - o TableUpdate final grava o valor corrente da linha,
    * nova ou editada, da mesma forma. Sem view buferizada, a linha editada
    * (cidchaves ja gravado antes) exige UPDATE explicito - so INSERT
    * duplicaria a linha com o mesmo cidchaves.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSubSubNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOss SET" + ;
                       " cdopes  = " + EscaparSQL(THIS.this_cCDopesOss) + "," + ;
                       " cnivels = " + EscaparSQL(THIS.this_cCNivelsOss) + "," + ;
                       " dopess  = " + EscaparSQL(THIS.this_cDopess) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesOss)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdOss")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sub-sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdOss")
                USE IN cursor_4c_UpdOss
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.AtualizarSubSubNivel:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirSubSubNivel - Remove um sub-sub-nivel (linha de SigOpOss)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirSubSubNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOss" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesOss)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelOss")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sub-sub-n" + CHR(237) + "vel da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelOss")
                USE IN cursor_4c_DelOss
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSnoBO.ExcluirSubSubNivel:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

