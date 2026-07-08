# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_SERVICO, CNT_4C_CONTAINER2. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigpdmp2.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2993 linhas total):

*-- Linhas 19 a 77:
19: 
20:     pnIdConn = 0
21: 
22:     PROCEDURE Init(par_nConn)
23:         THIS.pnIdConn = par_nConn
24:     ENDPROC
25: 
26:     PROCEDURE SqlExecute(par_cSQL, par_cAlias)
27:         LOCAL loc_nRet, loc_oErro
28:         loc_nRet = -1
29:         TRY
30:             loc_nRet = SQLEXEC(THIS.pnIdConn, par_cSQL, par_cAlias)
31:         CATCH TO loc_oErro
32:             MsgErro(loc_oErro.Message, "Erro SqlExecute")
33:         ENDTRY
34:         RETURN loc_nRet
35:     ENDPROC
36: 
37:     PROCEDURE CursorQuery(par_cTabela, par_cAlias, par_cCampoChave, par_xValor, par_cCampos)
38:         LOCAL loc_cSQL, loc_cCampos, loc_cWhere, loc_nRet, loc_oErro
39:         loc_nRet    = -1
40:         loc_cCampos = IIF(EMPTY(par_cCampos), "*", par_cCampos)
41:         IF VARTYPE(par_xValor) = "N"
42:             loc_cWhere = par_cCampoChave + " = " + TRANSFORM(par_xValor)
43:         ELSE
44:             loc_cWhere = par_cCampoChave + " = '" + ALLTRIM(TRANSFORM(par_xValor)) + "'"
45:         ENDIF
46:         loc_cSQL = "SELECT " + loc_cCampos + " FROM " + par_cTabela + ;
47:                    " WHERE " + loc_cWhere
48:         TRY
49:             loc_nRet = SQLEXEC(THIS.pnIdConn, loc_cSQL, par_cAlias)
50:             IF loc_nRet >= 1 AND USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
51:                 GO TOP IN (par_cAlias)
52:             ENDIF
53:         CATCH TO loc_oErro
54:             MsgErro(loc_oErro.Message, "Erro CursorQuery")
55:         ENDTRY
56:         RETURN loc_nRet
57:     ENDPROC
58: 
59: ENDDEFINE
60: 
61: *==============================================================================
62: * Formsigpdmp2 - Form operacional de componentes de producao
63: *==============================================================================
64: DEFINE CLASS Formsigpdmp2 AS FormBase
65: 
66:     *--------------------------------------------------------------------------
67:     * Propriedades visuais - EXATAS do original SIGPDMP2
68:     *--------------------------------------------------------------------------
69:     Width        = 1000
70:     Height       = 600
71:     BorderStyle  = 2
72:     TitleBar     = 0
73:     ShowWindow = 1
74:     ControlBox   = .F.
75:     Closable     = .F.
76:     MaxButton    = .F.
77:     MinButton    = .F.

*-- Linhas 125 a 240:
125:     * par_oFormPai: referencia ao form de producao que abriu este sub-form
126:     * par_nDatSes:  ID da datasession do form pai (para acesso a cursores)
127:     *==========================================================================
128:     PROCEDURE Init(par_oFormPai, par_nDatSes)
129:         IF VARTYPE(par_oFormPai) = "O"
130:             THIS.ParentForm   = par_oFormPai
131:             THIS.pcEscolha    = par_oFormPai.pcEscolha
132:             THIS.pEmps        = par_oFormPai.pEmps
133:             THIS.this_nDatSes = par_nDatSes
134:             IF par_nDatSes > 0
135:                 SET DATASESSION TO par_nDatSes
136:             ENDIF
137:         ENDIF
138:         RETURN DODEFAULT()
139:     ENDPROC
140: 
141:     *==========================================================================
142:     * InicializarForm - Hook chamado por FormBase.Init()
143:     * Cria estrutura visual base e inicializa BO.
144:     * REGRA: NUNCA usar RETURN dentro de TRY/CATCH - usar loc_lSucesso.
145:     *==========================================================================
146:     PROTECTED PROCEDURE InicializarForm()
147:         LOCAL loc_lSucesso, loc_oErro
148: 
149:         loc_lSucesso = .F.
150:         THIS.LockScreen = .T.
151: 
152:         TRY
153:             *-- Proxy para compatibilidade com sub-forms legados
154:             THIS.poDataMgr = CREATEOBJECT("DataMgrProxy", gnConnHandle)
155:             IF VARTYPE(THIS.poDataMgr) != "O"
156:                 MsgErro("Falha ao criar DataMgrProxy.", "Erro")
157:             ELSE
158:                 *-- Business Object dos componentes
159:                 THIS.this_oBusinessObject = CREATEOBJECT("sigpdmp2BO")
160:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
161:                     MsgErro("Falha ao instanciar sigpdmp2BO.", "Erro")
162:                 ELSE
163:                     *-- Sincroniza contexto do form pai com o BO
164:                     THIS.this_oBusinessObject.this_cPcEscolha = THIS.pcEscolha
165:                     THIS.this_oBusinessObject.this_cPEmps     = THIS.pEmps
166: 
167:                     *-- Imagem de fundo (replica legado: new_background.jpg)
168:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
169: 
170:                     *-- Cria estrutura visual base
171:                     THIS.ConfigurarCabecalho()
172:                     THIS.ConfigurarContainerOperacao()
173:                     THIS.ConfigurarContainersAuxiliares()
174:                     THIS.ConfigurarPaginaLista()
175:                     THIS.ConfigurarCheckboxes()
176:                     THIS.ConfigurarContainer2()
177:                     THIS.ConfigurarPaginaDados()
178: 
179:                     *-- Tornar controles visiveis (filtrando containers flutuantes)
180:                     THIS.TornarControlesVisiveis(THIS)
181:                     THIS.ConfigurarEstadoInicial()
182: 
183:                     THIS.LockScreen = .F.
184:                     loc_lSucesso = .T.
185:                 ENDIF
186:             ENDIF
187: 
188:         CATCH TO loc_oErro
189:             THIS.LockScreen = .F.
190:             MsgErro(loc_oErro.Message, "Erro InicializarForm Componentes")
191:         ENDTRY
192: 
193:         RETURN loc_lSucesso
194:     ENDPROC
195: 
196:     *==========================================================================
197:     * ConfigurarCabecalho - Container escuro de titulo
198:     * Replica: cntSombra (Top=0, Left=0, Width=1100, Height=80) + lblSombra/lblTitulo
199:     *==========================================================================
200:     PROTECTED PROCEDURE ConfigurarCabecalho()
201:         LOCAL loc_oCnt, loc_oErro
202: 
203:         TRY
204:             THIS.AddObject("cnt_4c_Sombra", "Container")
205:             loc_oCnt = THIS.cnt_4c_Sombra
206:             WITH loc_oCnt
207:                 .Top         = 0
208:                 .Left        = 0
209:                 .Width       = 1100
210:                 .Height      = 80
211:                 .BackStyle   = 1
212:                 .BackColor   = RGB(100, 100, 100)
213:                 .BorderWidth = 0
214:                 .Visible     = .T.
215:             ENDWITH
216: 
217:             *-- lblSombra: label de sombra (preto) atras do titulo
218:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
219:             WITH loc_oCnt.lbl_4c_LblSombra
220:                 .Top       = 18
221:                 .Left      = 10
222:                 .Width     = 769
223:                 .Height    = 40
224:                 .Caption   = "Componentes"
225:                 .FontName  = "Tahoma"
226:                 .FontSize  = 18
227:                 .FontBold  = .T.
228:                 .ForeColor = RGB(0, 0, 0)
229:                 .BackStyle = 0
230:                 .WordWrap  = .T.
231:                 .Alignment = 0
232:                 .Visible   = .T.
233:             ENDWITH
234: 
235:             *-- lblTitulo: label branco sobre fundo cinza
236:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
237:             WITH loc_oCnt.lbl_4c_LblTitulo
238:                 .Top       = 17
239:                 .Left      = 10
240:                 .Width     = 769

*-- Linhas 261 a 335:
261:     * Os campos filhos (Say4, GetEmpresa, GetOperacao, GetCodigo) sao
262:     * adicionados na Fase 5 (campos de dados). Container criado vazio aqui.
263:     *==========================================================================
264:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
265:         LOCAL loc_oErro
266: 
267:         TRY
268:             THIS.AddObject("cnt_4c_Operacao", "Container")
269:             WITH THIS.cnt_4c_Operacao
270:                 .Top           = 158
271:                 .Left          = 15
272:                 .Width         = 382
273:                 .Height        = 34
274:                 .BackStyle     = 0
275:                 .BorderWidth   = 0
276:                 .SpecialEffect = 0
277:                 .Visible       = .T.
278:             ENDWITH
279: 
280:         CATCH TO loc_oErro
281:             MsgErro(loc_oErro.Message, "Erro ao configurar container Opera" + CHR(231) + CHR(227) + "o")
282:         ENDTRY
283:     ENDPROC
284: 
285:     *==========================================================================
286:     * ConfigurarContainersAuxiliares - Cria containers flutuantes (Visible=.F.)
287:     * REGRA: TornarControlesVisiveis() filtra estes containers para nao os
288:     * forcar visiveis. Sao exibidos sob demanda por logica de botoes/eventos.
289:     *
290:     * Container1   - painel auxiliar oculto (uso especifico - Top=501, L=13)
291:     * Cnt_Servico  - painel de servicos (Top=501, L=404), aparece quando
292:     *                xNensi.Servicos = .T. na linha corrente do grid
293:     * Container2   - painel de lotes (Top=207, L=287), aparece via cmdLotes.Click
294:     *==========================================================================
295:     PROTECTED PROCEDURE ConfigurarContainersAuxiliares()
296:         LOCAL loc_oErro
297: 
298:         TRY
299:             *-- Container1: painel auxiliar oculto
300:             THIS.AddObject("cnt_4c_Container1", "Container")
301:             WITH THIS.cnt_4c_Container1
302:                 .Top         = 501
303:                 .Left        = 13
304:                 .Width       = 389
305:                 .Height      = 97
306:                 .BackStyle   = 0
307:                 .BackColor   = RGB(255, 255, 255)
308:                 .BorderWidth = 0
309:                 .Visible     = .F.
310:             ENDWITH
311: 
312:             *-- Cnt_Servico: painel de servicos (campos do servico da linha)
313:             THIS.AddObject("cnt_4c_Servico", "Container")
314:             WITH THIS.cnt_4c_Servico
315:                 .Top         = 501
316:                 .Left        = 404
317:                 .Width       = 371
318:                 .Height      = 97
319:                 .BackStyle   = 0
320:                 .BackColor   = RGB(255, 255, 255)
321:                 .BorderWidth = 0
322:                 .Visible     = .F.
323:             ENDWITH
324: 
325:             *-- Container2: painel de lotes (grid de lotes + botao OK)
326:             THIS.AddObject("cnt_4c_Container2", "Container")
327:             WITH THIS.cnt_4c_Container2
328:                 .Top         = 207
329:                 .Left        = 287
330:                 .Width       = 432
331:                 .Height      = 264
332:                 .BackStyle   = 1
333:                 .BackColor   = RGB(255, 255, 255)
334:                 .BorderWidth = 1
335:                 .Visible     = .F.

*-- Linhas 341 a 1210:
341:     ENDPROC
342: 
343:     *==========================================================================
344:     * TornarControlesVisiveis - Recursivo, FILTRA containers flutuantes
345:     * Containers cnt_4c_Container1, cnt_4c_Servico, cnt_4c_Container2 sao
346:     * gerenciados pela logica de negocio (toggle Visible) e NAO devem ser
347:     * forcados visiveis aqui. Sub-controles dentro deles tambem sao pulados.
348:     *==========================================================================
349:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
350:         LOCAL loc_nI, loc_oObjeto, loc_cNome
351: 
352:         FOR loc_nI = 1 TO par_oContainer.ControlCount
353:             loc_oObjeto = par_oContainer.Controls(loc_nI)
354: 
355:             IF VARTYPE(loc_oObjeto) = "O"
356:                 loc_cNome = UPPER(loc_oObjeto.Name)
357: 
358:                 *-- Pula containers flutuantes (gerenciados por logica de negocio)
359:                 IF INLIST(loc_cNome, "CNT_4C_SOMBRA", "CNT_4C_CONTAINER1", "CNT_4C_SERVICO", "CNT_4C_CONTAINER2", "CHK_4C_REPRETRAB")
360:                     LOOP
361:                 ENDIF
362: 
363:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
364:                     loc_oObjeto.Visible = .T.
365:                 ENDIF
366: 
367:                 *-- Recursao para containers com filhos
368:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
369:                     IF loc_oObjeto.ControlCount > 0
370:                         THIS.TornarControlesVisiveis(loc_oObjeto)
371:                     ENDIF
372:                 ENDIF
373:             ENDIF
374:         ENDFOR
375:     ENDPROC
376: 
377:     *==========================================================================
378:     * Destroy - Limpa referencias e fecha o BO
379:     *==========================================================================
380:     PROCEDURE Destroy()
381:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
382:             THIS.this_oBusinessObject = .NULL.
383:         ENDIF
384:         IF VARTYPE(THIS.poDataMgr) = "O"
385:             THIS.poDataMgr = .NULL.
386:         ENDIF
387:         THIS.ParentForm = .NULL.
388:         DODEFAULT()
389:     ENDPROC
390: 
391:     *==========================================================================
392:     * ConfigurarGradePrincipal - Grade de 13 colunas ligada ao cursor xNensi
393:     * Replica: Grade (Top=189, Left=13, Width=890, Height=309) do SIGPDMP2
394:     * Cols: Seq|SigCdPro|Descr|CUnida|SigCdRpo|CUniPs|Qtde|
395:     *        SigCdSvc|Qtps|SigCdTma|RepRetrab(oculta)|Cors|Tams
396:     * Cols 12/13 dinamicas: Width=1 ate SigCdGrp ter Cores/Tams=.T.
397:     *==========================================================================
398:     PROTECTED PROCEDURE ConfigurarGradePrincipal()
399:         LOCAL loc_oGrd, loc_oCol, loc_oCtrl, loc_oErro
400: 
401:         TRY
402:             THIS.AddObject("grd_4c_Dados", "GridBase")
403:             loc_oGrd = THIS.grd_4c_Dados
404:             WITH loc_oGrd
405:                 .Top              = 189
406:                 .Left             = 13
407:                 .Width            = 890
408:                 .Height           = 309
409:                 .RecordSource     = "xNensi"
410:                 .RecordSourceType = 1
411:                 .ColumnCount      = 13
412:                 .DeleteMark       = .F.
413:                 .ReadOnly         = .F.
414:                 .FontName         = "Tahoma"
415:                 .FontSize         = 8
416:                 .GridLines        = 1
417:                 .ScrollBars       = 3
418:                 .Visible          = .T.
419:             ENDWITH
420:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
421: 
422:             *-- Coluna 1: Seq (somente leitura)
423:             loc_oCol = loc_oGrd.Columns(1)
424:             WITH loc_oCol
425:                 .Width           = 35
426:                 .ReadOnly        = .T.
427:                 .Header1.Caption = "OF / Envelope"
428:             ENDWITH
429:             loc_oCol.Controls(1).ControlSource = "xNensi.Seq"
430: 
431:             *-- Coluna 2: SigCdPro - produto (lookup)
432:             loc_oCol = loc_oGrd.Columns(2)
433:             WITH loc_oCol
434:                 .Width           = 70
435:                 .ReadOnly        = .F.
436:                 .Header1.Caption = "Componente"
437:             ENDWITH
438:             loc_oCtrl = loc_oCol.Controls(1)
439:             loc_oCtrl.ControlSource = "xNensi.SigCdPro"
440:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col2GotFocus")
441:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col2ValidarComponente")
442:             BINDEVENT(loc_oCtrl, "KeyPress", THIS, "Col2KeyPress")
443: 
444:             *-- Coluna 3: Descr (somente leitura - derivada do produto)
445:             loc_oCol = loc_oGrd.Columns(3)
446:             WITH loc_oCol
447:                 .Width           = 200
448:                 .ReadOnly        = .T.
449:                 .Header1.Caption = "Envelope"
450:             ENDWITH
451:             loc_oCol.Controls(1).ControlSource = "xNensi.Descr"
452: 
453:             *-- Coluna 4: CUnida - unidade principal (somente leitura)
454:             loc_oCol = loc_oGrd.Columns(4)
455:             WITH loc_oCol
456:                 .Width           = 45
457:                 .ReadOnly        = .T.
458:                 .Header1.Caption = "Uni"
459:             ENDWITH
460:             loc_oCol.Controls(1).ControlSource = "xNensi.CUnida"
461: 
462:             *-- Coluna 5: SigCdRpo - roteiro/processo (lookup com logica CodAcb/Peso)
463:             loc_oCol = loc_oGrd.Columns(5)
464:             WITH loc_oCol
465:                 .Width           = 60
466:                 .ReadOnly        = .F.
467:                 .Header1.Caption = "Peso Fabr."
468:             ENDWITH
469:             loc_oCtrl = loc_oCol.Controls(1)
470:             loc_oCtrl.ControlSource = "xNensi.SigCdRpo"
471:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col5GotFocus")
472:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col5ValidarRoteiro")
473: 
474:             *-- Coluna 6: CUniPs - unidade de pecas (somente leitura)
475:             loc_oCol = loc_oGrd.Columns(6)
476:             WITH loc_oCol
477:                 .Width           = 45
478:                 .ReadOnly        = .T.
479:                 .Header1.Caption = "Lote"
480:             ENDWITH
481:             loc_oCol.Controls(1).ControlSource = "xNensi.CUniPs"
482: 
483:             *-- Coluna 7: Qtde - quantidade principal
484:             loc_oCol = loc_oGrd.Columns(7)
485:             WITH loc_oCol
486:                 .Width           = 65
487:                 .ReadOnly        = .F.
488:                 .Header1.Caption = "Quantidade"
489:             ENDWITH
490:             loc_oCtrl = loc_oCol.Controls(1)
491:             loc_oCtrl.ControlSource = "xNensi.Qtde"
492:             loc_oCtrl.Format = "9999.999"
493:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col7GotFocus")
494:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col7ValidarQuantidade")
495: 
496:             *-- Coluna 8: SigCdSvc - servico (lookup em crSigCdSvc do pai)
497:             loc_oCol = loc_oGrd.Columns(8)
498:             WITH loc_oCol
499:                 .Width           = 60
500:                 .ReadOnly        = .F.
501:                 .Header1.Caption = "Cat."
502:             ENDWITH
503:             loc_oCtrl = loc_oCol.Controls(1)
504:             loc_oCtrl.ControlSource = "xNensi.SigCdSvc"
505:             BINDEVENT(loc_oCtrl, "When",  THIS, "Col8WhenServico")
506:             BINDEVENT(loc_oCtrl, "Valid", THIS, "Col8ValidarServico")
507: 
508:             *-- Coluna 9: Qtps - quantidade em pecas
509:             loc_oCol = loc_oGrd.Columns(9)
510:             WITH loc_oCol
511:                 .Width           = 65
512:                 .ReadOnly        = .F.
513:                 .Header1.Caption = "Saldo"
514:             ENDWITH
515:             loc_oCtrl = loc_oCol.Controls(1)
516:             loc_oCtrl.ControlSource = "xNensi.Qtps"
517:             loc_oCtrl.Format = "9999.999"
518:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col9GotFocus")
519:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col9ValidarQtps")
520: 
521:             *-- Coluna 10: SigCdTma - tipo de material (lookup)
522:             loc_oCol = loc_oGrd.Columns(10)
523:             WITH loc_oCol
524:                 .Width           = 60
525:                 .ReadOnly        = .F.
526:                 .Header1.Caption = "Tipo de Material"
527:             ENDWITH
528:             loc_oCtrl = loc_oCol.Controls(1)
529:             loc_oCtrl.ControlSource = "xNensi.SigCdTma"
530:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col10GotFocus")
531:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col10ValidarTipoMaterial")
532: 
533:             *-- Coluna 11: RepRetrab - sempre oculta (gerenciada via BO legado)
534:             loc_oCol = loc_oGrd.Columns(11)
535:             WITH loc_oCol
536:                 .Width           = 1
537:                 .ReadOnly        = .T.
538:                 .Visible         = .F.
539:                 .Header1.Caption = ""
540:             ENDWITH
541:             loc_oCol.Controls(1).ControlSource = "xNensi.RepRetrab"
542: 
543:             *-- Coluna 12: Cors - cor (dinamica: Width=1 ate grupo ter Cores=.T.)
544:             loc_oCol = loc_oGrd.Columns(12)
545:             WITH loc_oCol
546:                 .Width           = 1
547:                 .ReadOnly        = .F.
548:                 .Header1.Caption = "Cor"
549:             ENDWITH
550:             loc_oCtrl = loc_oCol.Controls(1)
551:             loc_oCtrl.ControlSource = "xNensi.Cors"
552:             BINDEVENT(loc_oCtrl, "When",  THIS, "Col12WhenCor")
553:             BINDEVENT(loc_oCtrl, "Valid", THIS, "Col12ValidarCor")
554: 
555:             *-- Coluna 13: Tams - tamanho (dinamica: Width=1 ate grupo ter Tams=.T.)
556:             loc_oCol = loc_oGrd.Columns(13)
557:             WITH loc_oCol
558:                 .Width           = 1
559:                 .ReadOnly        = .F.
560:                 .Header1.Caption = "Tam"
561:             ENDWITH
562:             loc_oCtrl = loc_oCol.Controls(1)
563:             loc_oCtrl.ControlSource = "xNensi.Tams"
564:             BINDEVENT(loc_oCtrl, "When",  THIS, "Col13WhenTamanho")
565:             BINDEVENT(loc_oCtrl, "Valid", THIS, "Col13ValidarTamanho")
566: 
567:         CATCH TO loc_oErro
568:             MsgErro(loc_oErro.Message, "Erro ao configurar grade principal")
569:         ENDTRY
570:     ENDPROC
571: 
572:     *==========================================================================
573:     * GrdDadosAfterRowColChange - Atualiza Get_Descr/Get_Obs e Cnt_Servico
574:     * BINDEVENT: AfterRowColChange do grd_4c_Dados
575:     * Replica: Grade.Procedure do SIGPDMP2 - mostra/oculta Cnt_Servico,
576:     * recalcula total (Fators*Qtds) e determina AlteraServico.
577:     *==========================================================================
578:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
579:         LOCAL loc_nTotal, loc_oErro
580: 
581:         TRY
582:             IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi")
583:                 *-- Atualiza descricao e observacao abaixo do grid
584:                 IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
585:                     THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
586:                 ENDIF
587:                 IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
588:                     THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
589:                     THIS.txt_4c_GetObs.Refresh()
590:                 ENDIF
591: 
592:                 *-- Gestao do painel Cnt_Servico
593:                 IF PEMSTATUS(THIS, "cnt_4c_Servico", 5)
594:                     THIS.AlteraServico = .F.
595:                     IF NVL(xNensi.Servicos, .F.)
596:                         THIS.cnt_4c_Servico.Visible = .T.
597:                         THIS.cnt_4c_Servico.Refresh()
598:                         *-- Recalcula total: Round(Fators * Qtds, 2)
599:                         loc_nTotal = ROUND(NVL(xNensi.Fators, 0) * NVL(xNensi.Qtds, 0), 2)
600:                         IF PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetTotal", 5)
601:                             THIS.cnt_4c_Servico.txt_4c_GetTotal.Value = loc_nTotal
602:                             THIS.cnt_4c_Servico.txt_4c_GetTotal.Refresh()
603:                         ENDIF
604:                         *-- AlteraServico: ServAuto=1 sem Fators ou ServAuto=2 permitem edicao
605:                         IF (NVL(xNensi.ServAuto, 0) = 1 AND NVL(xNensi.Fators, 0) = 0) ;
606:                                 OR NVL(xNensi.ServAuto, 0) = 2
607:                             THIS.AlteraServico = .T.
608:                         ENDIF
609:                     ELSE
610:                         THIS.cnt_4c_Servico.Visible = .F.
611:                     ENDIF
612:                 ENDIF
613:             ENDIF
614:         CATCH TO loc_oErro
615:             MsgErro(loc_oErro.Message, "Erro AfterRowColChange grade")
616:         ENDTRY
617:     ENDPROC
618: 
619:     *==========================================================================
620:     * Col2GotFocus - Armazena SigCdPro anterior para rollback em caso de erro
621:     *==========================================================================
622:     PROCEDURE Col2GotFocus()
623:         IF USED("xNensi") AND !EOF("xNensi")
624:             THIS.AntValue = ALLTRIM(NVL(xNensi.SigCdPro, ""))
625:         ENDIF
626:     ENDPROC
627: 
628:     *==========================================================================
629:     * Col2KeyPress - F4 (115) abre FormBuscaAuxiliar para selecao de produto
630:     *==========================================================================
631:     PROCEDURE Col2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
632:         LOCAL loc_oForm, loc_cCod, loc_oErro
633: 
634:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
635:             TRY
636:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
637:                     "SigCdPro", "SigCdPro,Descr", "SigCdPro", ;
638:                     "Busca de Produtos", "")
639:                 IF VARTYPE(loc_oForm) = "O"
640:                     loc_oForm.Show()
641:                     loc_cCod = loc_oForm.this_cResultado
642:                     loc_oForm = .NULL.
643:                     IF !EMPTY(loc_cCod)
644:                         REPLACE xNensi.SigCdPro WITH loc_cCod
645:                         THIS.Col2ValidarComponente()
646:                     ENDIF
647:                 ENDIF
648:             CATCH TO loc_oErro
649:                 MsgErro(loc_oErro.Message, "Erro ao abrir busca de produto")
650:             ENDTRY
651:         ENDIF
652:     ENDPROC
653: 
654:     *==========================================================================
655:     * Col2ValidarComponente - Valida SigCdPro e preenche Descr/CUnida/CUniPs
656:     * Valid: busca em SigCdPro e ajusta colunas Cors/Tams conforme SigCdGrp
657:     *==========================================================================
658:     PROCEDURE Col2ValidarComponente()
659:         LOCAL loc_lRet, loc_cCod, loc_oErro
660:         loc_lRet = .T.
661: 
662:         TRY
663:             IF USED("xNensi") AND !EOF("xNensi")
664:                 loc_cCod = ALLTRIM(NVL(xNensi.SigCdPro, ""))
665:                 IF EMPTY(loc_cCod)
666:                     REPLACE xNensi.Descr  WITH ""
667:                     REPLACE xNensi.CUnida WITH ""
668:                     REPLACE xNensi.CUniPs WITH ""
669:                     THIS.AntValue = ""
670:                 ELSE
671:                     IF THIS.poDataMgr.CursorQuery("SigCdPro", "cursor_4c_Prod", ;
672:                             "SigCdPro", loc_cCod, ;
673:                             "SigCdPro,Descr,CUnida,CUniPs,SigCdGrp") >= 1 ;
674:                             AND USED("cursor_4c_Prod") ;
675:                             AND RECCOUNT("cursor_4c_Prod") > 0
676:                         REPLACE xNensi.Descr  WITH ALLTRIM(cursor_4c_Prod.Descr)
677:                         REPLACE xNensi.CUnida WITH ALLTRIM(cursor_4c_Prod.CUnida)
678:                         REPLACE xNensi.CUniPs WITH ALLTRIM(cursor_4c_Prod.CUniPs)
679:                         THIS.AjustarColunasCoresTamanhos(ALLTRIM(cursor_4c_Prod.SigCdGrp))
680:                         THIS.AntValue = loc_cCod
681:                         USE IN cursor_4c_Prod
682:                     ELSE
683:                         IF USED("cursor_4c_Prod")
684:                             USE IN cursor_4c_Prod
685:                         ENDIF
686:                         REPLACE xNensi.SigCdPro WITH THIS.AntValue
687:                         MsgAviso("Produto n" + CHR(227) + "o encontrado.", ;
688:                             "Aten" + CHR(231) + CHR(227) + "o")
689:                         loc_lRet = .F.
690:                     ENDIF
691:                 ENDIF
692:             ENDIF
693:         CATCH TO loc_oErro
694:             MsgErro(loc_oErro.Message, "Erro ValidarComponente")
695:             loc_lRet = .T.
696:         ENDTRY
697: 
698:         RETURN loc_lRet
699:     ENDPROC
700: 
701:     *==========================================================================
702:     * AjustarColunasCoresTamanhos - Expande col12/col13 conforme flags do grupo
703:     * par_cSigCdGrp: codigo do grupo do produto atual da linha
704:     *==========================================================================
705:     PROCEDURE AjustarColunasCoresTamanhos(par_cSigCdGrp)
706:         LOCAL loc_lCores, loc_lTams, loc_oErro
707: 
708:         TRY
709:             loc_lCores = .F.
710:             loc_lTams  = .F.
711:             IF !EMPTY(par_cSigCdGrp)
712:                 IF THIS.poDataMgr.CursorQuery("SigCdGrp", "cursor_4c_Grp", ;
713:                         "SigCdGrp", par_cSigCdGrp, "SigCdGrp,Cores,Tams") >= 1 ;
714:                         AND USED("cursor_4c_Grp") ;
715:                         AND RECCOUNT("cursor_4c_Grp") > 0
716:                     loc_lCores = (VARTYPE(cursor_4c_Grp.Cores) = "L" AND cursor_4c_Grp.Cores = .T.)
717:                     loc_lTams  = (VARTYPE(cursor_4c_Grp.Tams)  = "L" AND cursor_4c_Grp.Tams  = .T.)
718:                     USE IN cursor_4c_Grp
719:                 ENDIF
720:             ENDIF
721:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
722:                 THIS.grd_4c_Dados.Columns(12).Width = IIF(loc_lCores, 38, 1)
723:                 THIS.grd_4c_Dados.Columns(13).Width = IIF(loc_lTams,  24, 1)
724:             ENDIF
725:         CATCH TO loc_oErro
726:             MsgErro(loc_oErro.Message, "Erro ao ajustar colunas Cores/Tams")
727:         ENDTRY
728:     ENDPROC
729: 
730:     *==========================================================================
731:     * Col5GotFocus - Armazena SigCdRpo anterior e peso associado
732:     *==========================================================================
733:     PROCEDURE Col5GotFocus()
734:         IF USED("xNensi") AND !EOF("xNensi")
735:             THIS.AntValueP = ALLTRIM(NVL(xNensi.SigCdRpo, ""))
736:         ENDIF
737:     ENDPROC
738: 
739:     *==========================================================================
740:     * Col5ValidarRoteiro - Valida SigCdRpo e aplica logica CodAcb/Peso
741:     * Column5 Valid: lookup SigCdRpo com CodAcb para peso associado
742:     *==========================================================================
743:     PROCEDURE Col5ValidarRoteiro()
744:         LOCAL loc_lRet, loc_cCod, loc_cAcb, loc_oErro
745:         loc_lRet = .T.
746: 
747:         TRY
748:             IF USED("xNensi") AND !EOF("xNensi")
749:                 loc_cCod = ALLTRIM(NVL(xNensi.SigCdRpo, ""))
750:                 IF EMPTY(loc_cCod)
751:                     THIS.AntValueP = ""
752:                     THIS.AntPeso   = 0
753:                 ELSE
754:                     IF THIS.poDataMgr.CursorQuery("SigCdRpo", "cursor_4c_Rpo", ;
755:                             "SigCdRpo", loc_cCod, "SigCdRpo,CodAcb") >= 1 ;
756:                             AND USED("cursor_4c_Rpo") ;
757:                             AND RECCOUNT("cursor_4c_Rpo") > 0
758:                         loc_cAcb = ALLTRIM(NVL(cursor_4c_Rpo.CodAcb, ""))
759:                         USE IN cursor_4c_Rpo
760:                         THIS.AntValueP = loc_cCod
761:                         IF !EMPTY(loc_cAcb)
762:                             IF THIS.poDataMgr.CursorQuery("CodAcb", "cursor_4c_Acb", ;
763:                                     "CodAcb", loc_cAcb, "CodAcb,Peso") >= 1 ;
764:                                     AND USED("cursor_4c_Acb") ;
765:                                     AND RECCOUNT("cursor_4c_Acb") > 0
766:                                 THIS.AntPeso = NVL(cursor_4c_Acb.Peso, 0)
767:                                 USE IN cursor_4c_Acb
768:                             ELSE
769:                                 IF USED("cursor_4c_Acb")
770:                                     USE IN cursor_4c_Acb
771:                                 ENDIF
772:                                 THIS.AntPeso = 0
773:                             ENDIF
774:                         ENDIF
775:                     ELSE
776:                         IF USED("cursor_4c_Rpo")
777:                             USE IN cursor_4c_Rpo
778:                         ENDIF
779:                         REPLACE xNensi.SigCdRpo WITH THIS.AntValueP
780:                         MsgAviso("Roteiro n" + CHR(227) + "o encontrado.", ;
781:                             "Aten" + CHR(231) + CHR(227) + "o")
782:                         loc_lRet = .F.
783:                     ENDIF
784:                 ENDIF
785:             ENDIF
786:         CATCH TO loc_oErro
787:             MsgErro(loc_oErro.Message, "Erro ValidarRoteiro")
788:             loc_lRet = .T.
789:         ENDTRY
790: 
791:         RETURN loc_lRet
792:     ENDPROC
793: 
794:     *==========================================================================
795:     * Col7GotFocus - Armazena Qtde anterior para rollback
796:     *==========================================================================
797:     PROCEDURE Col7GotFocus()
798:         IF USED("xNensi") AND !EOF("xNensi")
799:             THIS.AntQtde = NVL(xNensi.Qtde, 0)
800:         ENDIF
801:     ENDPROC
802: 
803:     *==========================================================================
804:     * Col7ValidarQuantidade - Qtde nao pode ser negativa
805:     *==========================================================================
806:     PROCEDURE Col7ValidarQuantidade()
807:         LOCAL loc_lRet, loc_oErro
808:         loc_lRet = .T.
809: 
810:         TRY
811:             IF USED("xNensi") AND !EOF("xNensi")
812:                 IF NVL(xNensi.Qtde, 0) < 0
813:                     REPLACE xNensi.Qtde WITH THIS.AntQtde
814:                     MsgAviso("Quantidade n" + CHR(227) + "o pode ser negativa.", ;
815:                         "Aten" + CHR(231) + CHR(227) + "o")
816:                     loc_lRet = .F.
817:                 ELSE
818:                     THIS.AntQtde = NVL(xNensi.Qtde, 0)
819:                 ENDIF
820:             ENDIF
821:         CATCH TO loc_oErro
822:             MsgErro(loc_oErro.Message, "Erro ValidarQuantidade")
823:             loc_lRet = .T.
824:         ENDTRY
825: 
826:         RETURN loc_lRet
827:     ENDPROC
828: 
829:     *==========================================================================
830:     * Col8WhenServico - Permite edicao de SigCdSvc apenas se Servicos=.T.
831:     *==========================================================================
832:     PROCEDURE Col8WhenServico()
833:         LOCAL loc_lRet
834:         loc_lRet = .F.
835:         IF USED("xNensi") AND !EOF("xNensi")
836:             loc_lRet = NVL(xNensi.Servicos, .F.)
837:         ENDIF
838:         RETURN loc_lRet
839:     ENDPROC
840: 
841:     *==========================================================================
842:     * Col8ValidarServico - Valida SigCdSvc contra cursor crSigCdSvc do form pai
843:     * Column8 Valid: fwBuscaSel em crSigCdSvc
844:     *==========================================================================
845:     PROCEDURE Col8ValidarServico()
846:         LOCAL loc_lRet, loc_cCod, loc_oErro
847:         loc_lRet = .T.
848: 
849:         TRY
850:             IF USED("xNensi") AND !EOF("xNensi")
851:                 loc_cCod = ALLTRIM(NVL(xNensi.SigCdSvc, ""))
852:                 IF !EMPTY(loc_cCod)
853:                     IF USED("crSigCdSvc")
854:                         SELECT crSigCdSvc
855:                         LOCATE FOR ALLTRIM(crSigCdSvc.SigCdSvc) = loc_cCod
856:                         IF !FOUND("crSigCdSvc")
857:                             REPLACE xNensi.SigCdSvc WITH ""
858:                             MsgAviso("Servi" + CHR(231) + "o n" + CHR(227) + "o encontrado.", ;
859:                                 "Aten" + CHR(231) + CHR(227) + "o")
860:                             loc_lRet = .F.
861:                         ENDIF
862:                     ENDIF
863:                 ENDIF
864:             ENDIF
865:         CATCH TO loc_oErro
866:             MsgErro(loc_oErro.Message, "Erro ValidarServico")
867:             loc_lRet = .T.
868:         ENDTRY
869: 
870:         RETURN loc_lRet
871:     ENDPROC
872: 
873:     *==========================================================================
874:     * Col9GotFocus - Armazena Qtps anterior para rollback
875:     *==========================================================================
876:     PROCEDURE Col9GotFocus()
877:         IF USED("xNensi") AND !EOF("xNensi")
878:             THIS.AntValueP = NVL(xNensi.Qtps, 0)
879:         ENDIF
880:     ENDPROC
881: 
882:     *==========================================================================
883:     * Col9ValidarQtps - Qtps nao pode ser negativa
884:     *==========================================================================
885:     PROCEDURE Col9ValidarQtps()
886:         LOCAL loc_lRet, loc_oErro
887:         loc_lRet = .T.
888: 
889:         TRY
890:             IF USED("xNensi") AND !EOF("xNensi")
891:                 IF NVL(xNensi.Qtps, 0) < 0
892:                     REPLACE xNensi.Qtps WITH THIS.AntValueP
893:                     MsgAviso("Quantidade em pe" + CHR(231) + "as n" + CHR(227) + "o pode ser negativa.", ;
894:                         "Aten" + CHR(231) + CHR(227) + "o")
895:                     loc_lRet = .F.
896:                 ELSE
897:                     THIS.AntValueP = NVL(xNensi.Qtps, 0)
898:                 ENDIF
899:             ENDIF
900:         CATCH TO loc_oErro
901:             MsgErro(loc_oErro.Message, "Erro ValidarQtps")
902:             loc_lRet = .T.
903:         ENDTRY
904: 
905:         RETURN loc_lRet
906:     ENDPROC
907: 
908:     *==========================================================================
909:     * Col10GotFocus - Armazena SigCdTma anterior para rollback
910:     *==========================================================================
911:     PROCEDURE Col10GotFocus()
912:         IF USED("xNensi") AND !EOF("xNensi")
913:             THIS.AntValue = ALLTRIM(NVL(xNensi.SigCdTma, ""))
914:         ENDIF
915:     ENDPROC
916: 
917:     *==========================================================================
918:     * Col10ValidarTipoMaterial - Valida SigCdTma na tabela de tipos de material
919:     *==========================================================================
920:     PROCEDURE Col10ValidarTipoMaterial()
921:         LOCAL loc_lRet, loc_cCod, loc_oErro
922:         loc_lRet = .T.
923: 
924:         TRY
925:             IF USED("xNensi") AND !EOF("xNensi")
926:                 loc_cCod = ALLTRIM(NVL(xNensi.SigCdTma, ""))
927:                 IF !EMPTY(loc_cCod)
928:                     IF THIS.poDataMgr.CursorQuery("SigCdTma", "cursor_4c_Tma", ;
929:                             "SigCdTma", loc_cCod, "SigCdTma") >= 1 ;
930:                             AND USED("cursor_4c_Tma") ;
931:                             AND RECCOUNT("cursor_4c_Tma") > 0
932:                         THIS.AntValue = loc_cCod
933:                         USE IN cursor_4c_Tma
934:                     ELSE
935:                         IF USED("cursor_4c_Tma")
936:                             USE IN cursor_4c_Tma
937:                         ENDIF
938:                         REPLACE xNensi.SigCdTma WITH THIS.AntValue
939:                         MsgAviso("Tipo de material n" + CHR(227) + "o encontrado.", ;
940:                             "Aten" + CHR(231) + CHR(227) + "o")
941:                         loc_lRet = .F.
942:                     ENDIF
943:                 ENDIF
944:             ENDIF
945:         CATCH TO loc_oErro
946:             MsgErro(loc_oErro.Message, "Erro ValidarTipoMaterial")
947:             loc_lRet = .T.
948:         ENDTRY
949: 
950:         RETURN loc_lRet
951:     ENDPROC
952: 
953:     *==========================================================================
954:     * Col12WhenCor - Permite edicao de Cors apenas quando col12.Width > 1
955:     * (col12.Width e expandida por AjustarColunasCoresTamanhos quando Cores=.T.)
956:     *==========================================================================
957:     PROCEDURE Col12WhenCor()
958:         LOCAL loc_lRet
959:         loc_lRet = .F.
960:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
961:             loc_lRet = (THIS.grd_4c_Dados.Columns(12).Width > 1)
962:         ENDIF
963:         RETURN loc_lRet
964:     ENDPROC
965: 
966:     *==========================================================================
967:     * Col12ValidarCor - Valida Cors na tabela SigCdCor
968:     *==========================================================================
969:     PROCEDURE Col12ValidarCor()
970:         LOCAL loc_lRet, loc_cCod, loc_oErro
971:         loc_lRet = .T.
972: 
973:         TRY
974:             IF USED("xNensi") AND !EOF("xNensi")
975:                 loc_cCod = ALLTRIM(NVL(xNensi.Cors, ""))
976:                 IF !EMPTY(loc_cCod)
977:                     IF THIS.poDataMgr.CursorQuery("SigCdCor", "cursor_4c_Cor", ;
978:                             "SigCdCor", loc_cCod, "SigCdCor") >= 1 ;
979:                             AND USED("cursor_4c_Cor") ;
980:                             AND RECCOUNT("cursor_4c_Cor") > 0
981:                         USE IN cursor_4c_Cor
982:                     ELSE
983:                         IF USED("cursor_4c_Cor")
984:                             USE IN cursor_4c_Cor
985:                         ENDIF
986:                         REPLACE xNensi.Cors WITH ""
987:                         MsgAviso("Cor n" + CHR(227) + "o encontrada.", ;
988:                             "Aten" + CHR(231) + CHR(227) + "o")
989:                         loc_lRet = .F.
990:                     ENDIF
991:                 ENDIF
992:             ENDIF
993:         CATCH TO loc_oErro
994:             MsgErro(loc_oErro.Message, "Erro ValidarCor")
995:             loc_lRet = .T.
996:         ENDTRY
997: 
998:         RETURN loc_lRet
999:     ENDPROC
1000: 
1001:     *==========================================================================
1002:     * Col13WhenTamanho - Permite edicao de Tams apenas quando col13.Width > 1
1003:     *==========================================================================
1004:     PROCEDURE Col13WhenTamanho()
1005:         LOCAL loc_lRet
1006:         loc_lRet = .F.
1007:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1008:             loc_lRet = (THIS.grd_4c_Dados.Columns(13).Width > 1)
1009:         ENDIF
1010:         RETURN loc_lRet
1011:     ENDPROC
1012: 
1013:     *==========================================================================
1014:     * Col13ValidarTamanho - Valida Tams na tabela SigCdTam
1015:     *==========================================================================
1016:     PROCEDURE Col13ValidarTamanho()
1017:         LOCAL loc_lRet, loc_cCod, loc_oErro
1018:         loc_lRet = .T.
1019: 
1020:         TRY
1021:             IF USED("xNensi") AND !EOF("xNensi")
1022:                 loc_cCod = ALLTRIM(NVL(xNensi.Tams, ""))
1023:                 IF !EMPTY(loc_cCod)
1024:                     IF THIS.poDataMgr.CursorQuery("SigCdTam", "cursor_4c_Tam", ;
1025:                             "SigCdTam", loc_cCod, "SigCdTam") >= 1 ;
1026:                             AND USED("cursor_4c_Tam") ;
1027:                             AND RECCOUNT("cursor_4c_Tam") > 0
1028:                         USE IN cursor_4c_Tam
1029:                     ELSE
1030:                         IF USED("cursor_4c_Tam")
1031:                             USE IN cursor_4c_Tam
1032:                         ENDIF
1033:                         REPLACE xNensi.Tams WITH ""
1034:                         MsgAviso("Tamanho n" + CHR(227) + "o encontrado.", ;
1035:                             "Aten" + CHR(231) + CHR(227) + "o")
1036:                         loc_lRet = .F.
1037:                     ENDIF
1038:                 ENDIF
1039:             ENDIF
1040:         CATCH TO loc_oErro
1041:             MsgErro(loc_oErro.Message, "Erro ValidarTamanho")
1042:             loc_lRet = .T.
1043:         ENDTRY
1044: 
1045:         RETURN loc_lRet
1046:     ENDPROC
1047: 
1048:     *==========================================================================
1049:     * ConfigurarBotoesPrincipais - 6 botoes: Sair, Lotes, EncerraPCC,
1050:     *   Inserir, Alterar, Excluir
1051:     * Layouts exatos do layout.json:
1052:     *   Sair/ok:     Top=2,   Left=921, W=75, H=75
1053:     *   Lotes:       Top=81,  Left=846, W=75, H=75
1054:     *   EncerraPCC:  Top=81,  Left=771, W=75, H=75 (Visible=.F. inicial)
1055:     *   Inserir:     Top=222, Left=906, W=75, H=75
1056:     *   Alterar:     Top=297, Left=906, W=75, H=75
1057:     *   Excluir:     Top=372, Left=906, W=75, H=75
1058:     *==========================================================================
1059:     PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
1060:         LOCAL loc_oBtn, loc_oErro
1061: 
1062:         TRY
1063:             *-- Botao Sair (ok): valida todos os componentes e fecha o form
1064:             THIS.AddObject("cmd_4c_Sair", "CommandButton")
1065:             loc_oBtn = THIS.cmd_4c_Sair
1066:             WITH loc_oBtn
1067:                 .Top      = 2
1068:                 .Left     = 921
1069:                 .Width    = 75
1070:                 .Height   = 75
1071:                 .Caption  = "Encerrar"
1072:                 .FontName = "Tahoma"
1073:                 .FontSize = 8
1074:                 .Visible  = .T.
1075:             ENDWITH
1076:             BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
1077: 
1078:             *-- Botao Lotes: toggle do painel de lotes (cnt_4c_Container2)
1079:             THIS.AddObject("cmd_4c_Lotes", "CommandButton")
1080:             loc_oBtn = THIS.cmd_4c_Lotes
1081:             WITH loc_oBtn
1082:                 .Top      = 81
1083:                 .Left     = 846
1084:                 .Width    = 75
1085:                 .Height   = 75
1086:                 .Caption  = "Lotes"
1087:                 .FontName = "Tahoma"
1088:                 .FontSize = 8
1089:                 .Visible  = .T.
1090:             ENDWITH
1091:             BINDEVENT(THIS.cmd_4c_Lotes, "Click", THIS, "BtnLotesClick")
1092: 
1093:             *-- Botao EncerraPCC: oculto ate crSigCdOpd.Pccs = .T.
1094:             THIS.AddObject("cmd_4c_EncerraPCC", "CommandButton")
1095:             loc_oBtn = THIS.cmd_4c_EncerraPCC
1096:             WITH loc_oBtn
1097:                 .Top      = 81
1098:                 .Left     = 771
1099:                 .Width    = 75
1100:                 .Height   = 75
1101:                 .Caption  = "Encerra" + CHR(10) + "PCC"
1102:                 .FontName = "Tahoma"
1103:                 .FontSize = 8
1104:                 .Visible  = .F.
1105:             ENDWITH
1106:             BINDEVENT(THIS.cmd_4c_EncerraPCC, "Click", THIS, "BtnEncerraPCCClick")
1107: 
1108:             *-- Botao Inserir: adiciona nova linha em xNensi
1109:             THIS.AddObject("cmd_4c_Inserir", "CommandButton")
1110:             loc_oBtn = THIS.cmd_4c_Inserir
1111:             WITH loc_oBtn
1112:                 .Top      = 222
1113:                 .Left     = 906
1114:                 .Width    = 75
1115:                 .Height   = 75
1116:                 .Caption  = "Inserir"
1117:                 .FontName = "Tahoma"
1118:                 .FontSize = 8
1119:                 .Visible  = .T.
1120:                 .Enabled  = !THIS.InibeInserir
1121:             ENDWITH
1122:             BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")
1123: 
1124:             *-- Botao Alterar: abre SigPdM14 para edicao detalhada
1125:             THIS.AddObject("cmd_4c_Alterar", "CommandButton")
1126:             loc_oBtn = THIS.cmd_4c_Alterar
1127:             WITH loc_oBtn
1128:                 .Top      = 297
1129:                 .Left     = 906
1130:                 .Width    = 75
1131:                 .Height   = 75
1132:                 .Caption  = "Alterar"
1133:                 .FontName = "Tahoma"
1134:                 .FontSize = 8
1135:                 .Visible  = .T.
1136:                 .Enabled  = !THIS.InibeAlterar
1137:             ENDWITH
1138:             BINDEVENT(THIS.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
1139: 
1140:             *-- Botao Excluir: remove linha corrente de xNensi
1141:             THIS.AddObject("cmd_4c_Excluir", "CommandButton")
1142:             loc_oBtn = THIS.cmd_4c_Excluir
1143:             WITH loc_oBtn
1144:                 .Top      = 372
1145:                 .Left     = 906
1146:                 .Width    = 75
1147:                 .Height   = 75
1148:                 .Caption  = "Excluir"
1149:                 .FontName = "Tahoma"
1150:                 .FontSize = 8
1151:                 .Visible  = .T.
1152:                 .Enabled  = !THIS.InibeExcluir
1153:             ENDWITH
1154:             BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
1155: 
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message, "Erro ao configurar bot" + CHR(245) + "es principais")
1158:         ENDTRY
1159:     ENDPROC
1160: 
1161:     *==========================================================================
1162:     * BtnSairClick - Valida todos os componentes e fecha o form
1163:     * Replica: ok.Click do SIGPDMP2 (validacao completa: TpOps/Cats, DupTpOps, Cor/Tam)
1164:     * Em modo consulta (pcEscolha != INSERIR/ALTERAR) fecha sem validar.
1165:     * Validacoes para GrOdns <> 1:
1166:     *   - Cada linha com SigCdPro deve ter TpOps ou Cats preenchido
1167:     *   - TpOps nao pode ser duplicado se DupTpOps=1 em SigOpOpt
1168:     *   - Registros com CodnConfs: ChkLiber = .T.
1169:     *==========================================================================
1170:     PROCEDURE BtnSairClick()
1171:         LOCAL loc_lOk, loc_lDispNensi, loc_lDupTpO, loc_lChkLiber
1172:         LOCAL loc_nRecAtual, loc_cCod, loc_cTpOps, loc_cCats, loc_nDupOpt, loc_oErro
1173: 
1174:         loc_lOk = .T.
1175: 
1176:         IF !INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
1177:             *-- Consulta/visualizacao: fecha sem validar
1178:             THIS.Release()
1179:             RETURN
1180:         ENDIF
1181: 
1182:         loc_nRecAtual  = 0
1183:         loc_lDispNensi = .F.
1184:         loc_lDupTpO    = .F.
1185:         loc_lChkLiber  = .F.
1186: 
1187:         TRY
1188:             IF USED("xNensi") AND RECCOUNT("xNensi") > 0
1189:                 loc_nRecAtual = RECNO("xNensi")
1190: 
1191:                 *-- Validacao por linha somente quando GrOdns <> 1
1192:                 IF !(USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0 ;
1193:                         AND NVL(crSigCdOpd.GrOdns, 0) = 1)
1194: 
1195:                     GO TOP IN xNensi
1196:                     DO WHILE !EOF("xNensi") AND !loc_lDispNensi
1197:                         loc_cCod   = ALLTRIM(NVL(xNensi.SigCdPro, ""))
1198:                         loc_cTpOps = ALLTRIM(NVL(xNensi.TpOps, ""))
1199:                         loc_cCats  = ALLTRIM(NVL(xNensi.Cats, ""))
1200: 
1201:                         IF !EMPTY(loc_cCod)
1202:                             *-- CodnConfs preenchido: ha liberacao em aberto
1203:                             IF !EMPTY(ALLTRIM(NVL(xNensi.CodnConfs, "")))
1204:                                 loc_lChkLiber = .T.
1205:                             ENDIF
1206: 
1207:                             *-- TpOps e Cats nao podem ser vazios simultaneamente
1208:                             IF EMPTY(loc_cTpOps) AND EMPTY(loc_cCats)
1209:                                 loc_lDispNensi = .T.
1210:                                 EXIT

*-- Linhas 1239 a 1342:
1239:                 ENDIF
1240: 
1241:                 IF loc_lDispNensi
1242:                     MsgAviso("Tipo de material n" + CHR(227) + "o informado em um dos componentes.", ;
1243:                         "Aten" + CHR(231) + CHR(227) + "o")
1244:                     loc_lOk = .F.
1245:                 ENDIF
1246:             ENDIF
1247:         CATCH TO loc_oErro
1248:             MsgErro(loc_oErro.Message, "Erro ao validar componentes")
1249:             loc_lOk = .F.
1250:         ENDTRY
1251: 
1252:         IF loc_lOk
1253:             THIS.Release()
1254:         ENDIF
1255:     ENDPROC
1256: 
1257:     *==========================================================================
1258:     * BtnLotesClick - Toggle visibilidade do painel de lotes (cnt_4c_Container2)
1259:     *==========================================================================
1260:     PROCEDURE BtnLotesClick()
1261:         LOCAL loc_oErro
1262: 
1263:         TRY
1264:             IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
1265:                 THIS.cnt_4c_Container2.Visible = !THIS.cnt_4c_Container2.Visible
1266:                 IF THIS.cnt_4c_Container2.Visible
1267:                     IF USED("TmpNens") AND PEMSTATUS(THIS.cnt_4c_Container2, "grd_4c_Lotes", 5)
1268:                         THIS.cnt_4c_Container2.grd_4c_Lotes.Refresh()
1269:                     ENDIF
1270:                 ENDIF
1271:             ENDIF
1272:         CATCH TO loc_oErro
1273:             MsgErro(loc_oErro.Message, "Erro ao abrir painel de lotes")
1274:         ENDTRY
1275:     ENDPROC
1276: 
1277:     *==========================================================================
1278:     * BtnEncerraPCCClick - Abre SigPdMp8 para encerramento de PCC
1279:     * Visivel apenas quando crSigCdOpd.Pccs = .T. (ver ConfigurarEstadoInicial)
1280:     *==========================================================================
1281:     PROCEDURE BtnEncerraPCCClick()
1282:         LOCAL loc_oErro
1283: 
1284:         TRY
1285:             DO FORM SigPdMp8 WITH THIS
1286:         CATCH TO loc_oErro
1287:             MsgErro(loc_oErro.Message, "Erro ao encerrar PCC")
1288:         ENDTRY
1289:     ENDPROC
1290: 
1291:     *==========================================================================
1292:     * BtnInserirClick - Insere nova linha em xNensi com valores iniciais de TmpNens
1293:     * Replica: Inserir.Click do SIGPDMP2 (INSERT INTO com campos de TmpNens/crSigCdOpd)
1294:     * Nao insere se ja existe linha vazia (Nops=0 + Cmats em branco), exceto
1295:     * quando CompAgru=1 e PsFaseAnt <> 0 (agregacao de componentes permitida).
1296:     *==========================================================================
1297:     PROCEDURE BtnInserirClick()
1298:         LOCAL loc_lPode, loc_cEmps, loc_cDopps, loc_nNumps, loc_cTpPadrao, loc_oErro
1299: 
1300:         loc_lPode = .T.
1301:         IF !THIS.LibInserir
1302:             MsgAviso("Inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida.", ;
1303:                 "Aten" + CHR(231) + CHR(227) + "o")
1304:             loc_lPode = .F.
1305:         ENDIF
1306: 
1307:         IF loc_lPode AND !INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
1308:             loc_lPode = .F.
1309:         ENDIF
1310: 
1311:         IF loc_lPode
1312:             TRY
1313:                 IF USED("xNensi")
1314:                     *-- Obter campos iniciais de TmpNens e crSigCdOpd (datasession do pai)
1315:                     loc_cEmps     = ""
1316:                     loc_cDopps    = ""
1317:                     loc_nNumps    = 0
1318:                     loc_cTpPadrao = ""
1319:                     IF USED("TmpNens") AND RECCOUNT("TmpNens") > 0
1320:                         GO TOP IN TmpNens
1321:                         loc_cEmps  = ALLTRIM(NVL(TmpNens.Emps, ""))
1322:                         loc_cDopps = ALLTRIM(NVL(TmpNens.Dopps, ""))
1323:                         loc_nNumps = NVL(TmpNens.Numps, 0)
1324:                     ENDIF
1325:                     IF USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0
1326:                         GO TOP IN crSigCdOpd
1327:                         loc_cTpPadrao = ALLTRIM(NVL(crSigCdOpd.TpPadraos, ""))
1328:                     ENDIF
1329: 
1330:                     *-- Verifica se ja existe linha vazia (Nops=0 + Cmats em branco)
1331:                     SELECT xNensi
1332:                     SET ORDER TO NopMatCat
1333:                     IF !SEEK(STR(0, 10) + SPACE(13))
1334:                         *-- Sem linha vazia: inserir nova com valores iniciais
1335:                         INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
1336:                             VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadrao, .T.)
1337:                     ELSE
1338:                         *-- Linha vazia existe: inserir somente se CompAgru=1 e PsFaseAnt<>0
1339:                         IF THIS.CompAgru = 1 AND NVL(xNensi.PsFaseAnt, 0) <> 0
1340:                             INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
1341:                                 VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadrao, .T.)
1342:                         ENDIF

*-- Linhas 1361 a 1433:
1361:     * Replica: Alterar.Click do SIGPDMP2 - exige TpOps preenchido antes de abrir
1362:     * SigPdM14 ainda nao migrado: chama form legado via DO FORM
1363:     *==========================================================================
1364:     PROCEDURE BtnAlterarClick()
1365:         LOCAL loc_oErro
1366: 
1367:         TRY
1368:             IF USED("xNensi") AND RECCOUNT("xNensi") > 0 AND !EOF("xNensi")
1369:                 IF INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
1370:                     IF EMPTY(ALLTRIM(NVL(xNensi.TpOps, "")))
1371:                         MsgAviso("Informar o Tipo de Material antes de Alterar.", ;
1372:                             "Aten" + CHR(231) + CHR(227) + "o")
1373:                     ELSE
1374:                         DO FORM SigPdM14 WITH THIS
1375:                         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1376:                             THIS.grd_4c_Dados.Refresh()
1377:                         ENDIF
1378:                     ENDIF
1379:                 ENDIF
1380:             ENDIF
1381:         CATCH TO loc_oErro
1382:             MsgErro(loc_oErro.Message, "Erro ao alterar componente")
1383:         ENDTRY
1384:     ENDPROC
1385: 
1386:     *==========================================================================
1387:     * BtnExcluirClick - Remove linha(s) de xNensi com logica de agrupamento
1388:     * Replica: Excluir.Click do SIGPDMP2
1389:     * - SepPedras=4: exclui todos com mesmo Cmats (exceto servicos)
1390:     * - ChkQtdPs=4 + FlagIncs: exclui agrupados por Cmats+Amarracao
1391:     * - Padrao: exclui agrupados por FlagIncs+Cmats+(Nenvs/Nops ou Amarracao)
1392:     *==========================================================================
1393:     PROCEDURE BtnExcluirClick()
1394:         LOCAL loc_lConfirma, loc_cCod, loc_nNenvs, loc_cMats, loc_nNops
1395:         LOCAL loc_nAmr, loc_lFlagIncs, loc_nSepPedras, loc_nChkQtdPs, loc_oErro
1396: 
1397:         loc_lConfirma = .F.
1398:         TRY
1399:             IF USED("xNensi") AND RECCOUNT("xNensi") > 0 AND !EOF("xNensi")
1400:                 IF !INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
1401:                     RETURN
1402:                 ENDIF
1403:                 loc_cCod      = ALLTRIM(NVL(xNensi.SigCdPro, ""))
1404:                 loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + ;
1405:                     "o do componente '" + loc_cCod + "'?", ;
1406:                     "Confirmar Exclus" + CHR(227) + "o")
1407:                 IF loc_lConfirma
1408:                     *-- Captura campos da linha corrente para logica de exclusao agrupada
1409:                     loc_nNenvs    = NVL(xNensi.Nenvs, 0)
1410:                     loc_cMats     = ALLTRIM(NVL(xNensi.Cmats, ""))
1411:                     loc_nNops     = NVL(xNensi.Nops, 0)
1412:                     loc_nAmr      = NVL(xNensi.Amarracao, 0)
1413:                     loc_lFlagIncs = (VARTYPE(xNensi.FlagIncs) = "L" AND xNensi.FlagIncs)
1414: 
1415:                     *-- Flags de operacao para determinar modo de exclusao
1416:                     loc_nSepPedras = 0
1417:                     loc_nChkQtdPs  = 0
1418:                     IF USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0
1419:                         GO TOP IN crSigCdOpd
1420:                         loc_nSepPedras = NVL(crSigCdOpd.SepPedras, 0)
1421:                         loc_nChkQtdPs  = NVL(crSigCdOpd.ChkQtdPs, 0)
1422:                     ENDIF
1423: 
1424:                     SELECT xNensi
1425:                     SET ORDER TO
1426: 
1427:                     IF loc_nSepPedras = 4
1428:                         *-- SepPedras=4: remove todos com mesmo material (exceto servicos)
1429:                         DELETE ALL FOR ;
1430:                             !EMPTY(Cmats) AND ;
1431:                             ALLTRIM(Cmats) = loc_cMats AND ;
1432:                             !NVL(Servicos, .F.)
1433:                     ELSE

*-- Linhas 1473 a 1529:
1473:     * mantem a logica original (INSERT INTO xNensi + verificacao de linha
1474:     * vazia + suporte a CompAgru/PsFaseAnt).
1475:     *==========================================================================
1476:     PROCEDURE BtnIncluirClick()
1477:         THIS.BtnInserirClick()
1478:     ENDPROC
1479: 
1480:     *==========================================================================
1481:     * BtnVisualizarClick - Alterna o form para modo somente-leitura
1482:     * SIGPDMP2 nao tem botao Visualizar no legado; quando pcEscolha !=
1483:     * INSERIR/ALTERAR a interface ja se comporta como visualizacao (When
1484:     * dos botoes retorna .F.). Este metodo formaliza a entrada em modo
1485:     * VISUALIZAR: trava o grid e os campos de descricao/observacao,
1486:     * desabilita botoes de manipulacao e mantem dados visiveis. Replica
1487:     * a logica implicita do legado quando pcEscolha = 'VISUALIZAR'.
1488:     *==========================================================================
1489:     PROCEDURE BtnVisualizarClick()
1490:         LOCAL loc_oErro
1491: 
1492:         TRY
1493:             THIS.pcEscolha = "VISUALIZAR"
1494:             IF !ISNULL(THIS.this_oBusinessObject) ;
1495:                     AND PEMSTATUS(THIS.this_oBusinessObject, "this_cPcEscolha", 5)
1496:                 THIS.this_oBusinessObject.this_cPcEscolha = "VISUALIZAR"
1497:             ENDIF
1498: 
1499:             *-- Trava grid principal (impede edicao de qualquer coluna)
1500:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1501:                 THIS.grd_4c_Dados.ReadOnly = .T.
1502:                 THIS.grd_4c_Dados.DeleteMark = .F.
1503:             ENDIF
1504: 
1505:             *-- Trava campos de descricao e observacao
1506:             IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
1507:                 THIS.txt_4c_Descr.ReadOnly = .T.
1508:             ENDIF
1509:             IF PEMSTATUS(THIS, "txt_4c_Obs", 5)
1510:                 THIS.txt_4c_Obs.ReadOnly = .T.
1511:             ENDIF
1512:             IF PEMSTATUS(THIS, "txt_4c_Cor", 5)
1513:                 THIS.txt_4c_Cor.ReadOnly = .T.
1514:             ENDIF
1515:             IF PEMSTATUS(THIS, "txt_4c_Tam", 5)
1516:                 THIS.txt_4c_Tam.ReadOnly = .T.
1517:             ENDIF
1518: 
1519:             *-- Desabilita botoes de manipulacao (mantem Sair e Lotes habilitados)
1520:             IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
1521:                 THIS.cmd_4c_Inserir.Enabled = .F.
1522:             ENDIF
1523:             IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
1524:                 THIS.cmd_4c_Alterar.Enabled = .F.
1525:             ENDIF
1526:             IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
1527:                 THIS.cmd_4c_Excluir.Enabled = .F.
1528:             ENDIF
1529:             IF PEMSTATUS(THIS, "cmd_4c_EncerraPCC", 5)

*-- Linhas 1573 a 1672:
1573:     *   chk_4c_RepRetrab  (Left=621): sempre Visible=.F.
1574:     *   chk_4c_Agregado   (Left=696): abre SigPdMp1 (material agregado)
1575:     *==========================================================================
1576:     PROTECTED PROCEDURE ConfigurarCheckboxes()
1577:         LOCAL loc_oChk, loc_oErro
1578: 
1579:         TRY
1580:             *-- chk_4c_Retrabalho: abre form de retrabalho (SigPdM12)
1581:             THIS.AddObject("chk_4c_Retrabalho", "CheckBox")
1582:             loc_oChk = THIS.chk_4c_Retrabalho
1583:             WITH loc_oChk
1584:                 .Top             = 81
1585:                 .Left            = 171
1586:                 .Width           = 75
1587:                 .Height          = 75
1588:                 .Caption         = "Informar Re\<trabalho"
1589:                 .Value           = 0
1590:                 .Style           = 1
1591:                 .WordWrap        = .T.
1592:                 .Alignment       = 2
1593:                 .PicturePosition = 7
1594:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1595:                 .MousePointer    = 15
1596:                 .FontName        = "Tahoma"
1597:                 .FontBold        = .T.
1598:                 .FontItalic      = .T.
1599:                 .FontSize        = 8
1600:                 .ForeColor       = RGB(90, 90, 90)
1601:                 .BackColor       = RGB(255, 255, 255)
1602:                 .Themes          = .F.
1603:                 .Visible         = .T.
1604:             ENDWITH
1605:             BINDEVENT(THIS.chk_4c_Retrabalho, "Click", THIS, "ChkRetrabalhoClick")
1606: 
1607:             *-- chk_4c_RepeteMat: repete tipo de material da linha anterior
1608:             THIS.AddObject("chk_4c_RepeteMat", "CheckBox")
1609:             loc_oChk = THIS.chk_4c_RepeteMat
1610:             WITH loc_oChk
1611:                 .Top             = 81
1612:                 .Left            = 246
1613:                 .Width           = 75
1614:                 .Height          = 75
1615:                 .Caption         = "\<Repete Tipo Material"
1616:                 .Value           = 0
1617:                 .Style           = 1
1618:                 .WordWrap        = .T.
1619:                 .Alignment       = 2
1620:                 .PicturePosition = 7
1621:                 .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
1622:                 .MousePointer    = 15
1623:                 .FontName        = "Tahoma"
1624:                 .FontBold        = .T.
1625:                 .FontItalic      = .T.
1626:                 .FontSize        = 8
1627:                 .ForeColor       = RGB(90, 90, 90)
1628:                 .BackColor       = RGB(255, 255, 255)
1629:                 .Themes          = .F.
1630:                 .Visible         = .T.
1631:             ENDWITH
1632:             BINDEVENT(THIS.chk_4c_RepeteMat, "Click", THIS, "ChkRepeteMatClick")
1633: 
1634:             *-- chk_4c_InserirAuto: insercao automatica apos preencher linha
1635:             THIS.AddObject("chk_4c_InserirAuto", "CheckBox")
1636:             loc_oChk = THIS.chk_4c_InserirAuto
1637:             WITH loc_oChk
1638:                 .Top             = 81
1639:                 .Left            = 321
1640:                 .Width           = 75
1641:                 .Height          = 75
1642:                 .Caption         = "Inserir A\<utom" + CHR(225) + "tico"
1643:                 .Value           = 0
1644:                 .Style           = 1
1645:                 .WordWrap        = .T.
1646:                 .Alignment       = 2
1647:                 .PicturePosition = 7
1648:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1649:                 .MousePointer    = 15
1650:                 .FontName        = "Tahoma"
1651:                 .FontBold        = .T.
1652:                 .FontItalic      = .T.
1653:                 .FontSize        = 8
1654:                 .ForeColor       = RGB(90, 90, 90)
1655:                 .BackColor       = RGB(255, 255, 255)
1656:                 .Themes          = .F.
1657:                 .Visible         = .T.
1658:             ENDWITH
1659: 
1660:             *-- chk_4c_Pagto: pagamento lancado - abre SigPrSer
1661:             THIS.AddObject("chk_4c_Pagto", "CheckBox")
1662:             loc_oChk = THIS.chk_4c_Pagto
1663:             WITH loc_oChk
1664:                 .Top             = 81
1665:                 .Left            = 396
1666:                 .Width           = 75
1667:                 .Height          = 75
1668:                 .Caption         = "\<Pagamento Lan" + CHR(231) + "ado"
1669:                 .Value           = 0
1670:                 .Style           = 1
1671:                 .WordWrap        = .T.
1672:                 .Alignment       = 2

*-- Linhas 1682 a 1782:
1682:                 .Themes          = .F.
1683:                 .Visible         = .T.
1684:             ENDWITH
1685:             BINDEVENT(THIS.chk_4c_Pagto, "Click", THIS, "ChkPagtoClick")
1686: 
1687:             *-- chk_4c_RetrabAnt: retrabalho realizado - abre SigPdM12
1688:             THIS.AddObject("chk_4c_RetrabAnt", "CheckBox")
1689:             loc_oChk = THIS.chk_4c_RetrabAnt
1690:             WITH loc_oChk
1691:                 .Top             = 81
1692:                 .Left            = 471
1693:                 .Width           = 75
1694:                 .Height          = 75
1695:                 .Caption         = "Retrabalho Reali\<zado"
1696:                 .Value           = 0
1697:                 .Style           = 1
1698:                 .WordWrap        = .T.
1699:                 .Alignment       = 2
1700:                 .PicturePosition = 7
1701:                 .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
1702:                 .MousePointer    = 15
1703:                 .FontName        = "Tahoma"
1704:                 .FontBold        = .T.
1705:                 .FontItalic      = .T.
1706:                 .FontSize        = 8
1707:                 .ForeColor       = RGB(90, 90, 90)
1708:                 .BackColor       = RGB(255, 255, 255)
1709:                 .Themes          = .F.
1710:                 .Visible         = .T.
1711:             ENDWITH
1712:             BINDEVENT(THIS.chk_4c_RetrabAnt, "Click", THIS, "ChkRetrabAntClick")
1713: 
1714:             *-- chk_4c_Naoconforme: nao conforme - abre SigPdMp8
1715:             THIS.AddObject("chk_4c_Naoconforme", "CheckBox")
1716:             loc_oChk = THIS.chk_4c_Naoconforme
1717:             WITH loc_oChk
1718:                 .Top             = 81
1719:                 .Left            = 546
1720:                 .Width           = 75
1721:                 .Height          = 75
1722:                 .Caption         = "\<N" + CHR(227) + "o Conformes"
1723:                 .Value           = 0
1724:                 .Style           = 1
1725:                 .WordWrap        = .T.
1726:                 .Alignment       = 2
1727:                 .PicturePosition = 7
1728:                 .Picture         = gc_4c_CaminhoIcones + "geral_defrag_60.jpg"
1729:                 .MousePointer    = 15
1730:                 .FontName        = "Tahoma"
1731:                 .FontBold        = .T.
1732:                 .FontItalic      = .T.
1733:                 .FontSize        = 8
1734:                 .ForeColor       = RGB(90, 90, 90)
1735:                 .BackColor       = RGB(255, 255, 255)
1736:                 .Themes          = .F.
1737:                 .Visible         = .T.
1738:             ENDWITH
1739:             BINDEVENT(THIS.chk_4c_Naoconforme, "Click", THIS, "ChkNaoConformeClick")
1740: 
1741:             *-- chk_4c_RepRetrab: repete retrabalho - sempre oculto (Visible=.F.)
1742:             *-- Filtrado em TornarControlesVisiveis - gerenciado pela logica de negocio
1743:             THIS.AddObject("chk_4c_RepRetrab", "CheckBox")
1744:             loc_oChk = THIS.chk_4c_RepRetrab
1745:             WITH loc_oChk
1746:                 .Top             = 81
1747:                 .Left            = 621
1748:                 .Width           = 75
1749:                 .Height          = 75
1750:                 .Caption         = "R\<epete Retrabalho"
1751:                 .Value           = 0
1752:                 .Style           = 1
1753:                 .WordWrap        = .T.
1754:                 .Alignment       = 2
1755:                 .PicturePosition = 7
1756:                 .Picture         = gc_4c_CaminhoIcones + "geral_adicao_60.jpg"
1757:                 .MousePointer    = 15
1758:                 .FontName        = "Tahoma"
1759:                 .FontBold        = .T.
1760:                 .FontItalic      = .T.
1761:                 .FontSize        = 8
1762:                 .ForeColor       = RGB(90, 90, 90)
1763:                 .BackColor       = RGB(255, 255, 255)
1764:                 .Themes          = .F.
1765:                 .Visible         = .F.
1766:             ENDWITH
1767: 
1768:             *-- chk_4c_Agregado: material agregado - abre SigPdMp1
1769:             THIS.AddObject("chk_4c_Agregado", "CheckBox")
1770:             loc_oChk = THIS.chk_4c_Agregado
1771:             WITH loc_oChk
1772:                 .Top             = 81
1773:                 .Left            = 696
1774:                 .Width           = 75
1775:                 .Height          = 75
1776:                 .Caption         = "\<Material Agregado"
1777:                 .Value           = 0
1778:                 .Style           = 1
1779:                 .WordWrap        = .T.
1780:                 .Alignment       = 2
1781:                 .PicturePosition = 7
1782:                 .Picture         = gc_4c_CaminhoIcones + "geral_palete_60.jpg"

*-- Linhas 1790 a 1944:
1790:                 .Themes          = .F.
1791:                 .Visible         = .T.
1792:             ENDWITH
1793:             BINDEVENT(THIS.chk_4c_Agregado, "Click", THIS, "ChkAgregadoClick")
1794: 
1795:         CATCH TO loc_oErro
1796:             MsgErro(loc_oErro.Message, "Erro ao configurar checkboxes")
1797:         ENDTRY
1798:     ENDPROC
1799: 
1800:     *==========================================================================
1801:     * ChkRetrabalhoClick - Abre SigPdM12 para informar retrabalho
1802:     * Replica: Chk_Retrabalho.Click do SIGPDMP2
1803:     *==========================================================================
1804:     PROCEDURE ChkRetrabalhoClick()
1805:         LOCAL loc_oErro
1806:         TRY
1807:             IF USED("xNensi") AND !EOF("xNensi")
1808:                 DO FORM SigPdM12 WITH THIS
1809:                 THIS.Enabled = .F.
1810:             ENDIF
1811:         CATCH TO loc_oErro
1812:             MsgErro(loc_oErro.Message, "Erro ao abrir retrabalho")
1813:         ENDTRY
1814:     ENDPROC
1815: 
1816:     *==========================================================================
1817:     * ChkRepeteMatClick - Flag de repete tipo material (apenas marca estado)
1818:     *==========================================================================
1819:     PROCEDURE ChkRepeteMatClick()
1820:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1821:             THIS.grd_4c_Dados.Refresh()
1822:         ENDIF
1823:     ENDPROC
1824: 
1825:     *==========================================================================
1826:     * ChkPagtoClick - Abre SigPrSer para lancamento de pagamento
1827:     * Replica: Chk_pagto.Click do SIGPDMP2 - reseta valor e abre form
1828:     *==========================================================================
1829:     PROCEDURE ChkPagtoClick()
1830:         LOCAL loc_oErro
1831:         TRY
1832:             IF PEMSTATUS(THIS, "chk_4c_Pagto", 5)
1833:                 THIS.chk_4c_Pagto.Value = 0
1834:             ENDIF
1835:             DO FORM SigPrSer WITH THIS
1836:             THIS.Enabled = .F.
1837:         CATCH TO loc_oErro
1838:             MsgErro(loc_oErro.Message, "Erro ao abrir pagamento")
1839:         ENDTRY
1840:     ENDPROC
1841: 
1842:     *==========================================================================
1843:     * ChkRetrabAntClick - Abre SigPdM12 para retrabalho realizado (historico)
1844:     * Replica: Chk_RetrabAnt.Click - abre form se xNensiR nao esta em EOF
1845:     *==========================================================================
1846:     PROCEDURE ChkRetrabAntClick()
1847:         LOCAL loc_oErro
1848:         TRY
1849:             IF PEMSTATUS(THIS, "chk_4c_RetrabAnt", 5)
1850:                 THIS.chk_4c_RetrabAnt.Value = 0
1851:             ENDIF
1852:             IF USED("xNensiR") AND !EOF("xNensiR")
1853:                 DO FORM SigPdM12 WITH THIS
1854:                 THIS.Enabled = .F.
1855:             ENDIF
1856:         CATCH TO loc_oErro
1857:             MsgErro(loc_oErro.Message, "Erro ao abrir retrabalho anterior")
1858:         ENDTRY
1859:     ENDPROC
1860: 
1861:     *==========================================================================
1862:     * ChkNaoConformeClick - Abre SigPdMp8 para registrar nao conformidade
1863:     * Replica: chk_naoconforme.Click - abre form se xMfas nao esta em EOF
1864:     *==========================================================================
1865:     PROCEDURE ChkNaoConformeClick()
1866:         LOCAL loc_oErro
1867:         TRY
1868:             IF PEMSTATUS(THIS, "chk_4c_Naoconforme", 5)
1869:                 THIS.chk_4c_Naoconforme.Value = 0
1870:             ENDIF
1871:             IF USED("xMfas") AND !EOF("xMfas")
1872:                 DO FORM SigPdMp8 WITH THIS
1873:                 THIS.Enabled = .F.
1874:             ENDIF
1875:         CATCH TO loc_oErro
1876:             MsgErro(loc_oErro.Message, "Erro ao abrir n" + CHR(227) + "o conformidade")
1877:         ENDTRY
1878:     ENDPROC
1879: 
1880:     *==========================================================================
1881:     * ChkAgregadoClick - Abre SigPdMp1 para visualizar material agregado
1882:     * Replica: Chk_agregado.Click - abre form se xNensi nao esta em EOF
1883:     *==========================================================================
1884:     PROCEDURE ChkAgregadoClick()
1885:         LOCAL loc_oErro
1886:         TRY
1887:             IF PEMSTATUS(THIS, "chk_4c_Agregado", 5)
1888:                 THIS.chk_4c_Agregado.Value = 0
1889:             ENDIF
1890:             IF USED("xNensi") AND !EOF("xNensi")
1891:                 DO FORM SigPdMp1 WITH THIS
1892:                 THIS.Enabled = .F.
1893:             ENDIF
1894:         CATCH TO loc_oErro
1895:             MsgErro(loc_oErro.Message, "Erro ao abrir material agregado")
1896:         ENDTRY
1897:     ENDPROC
1898: 
1899:     *==========================================================================
1900:     * ConfigurarContainer2 - Preenche cnt_4c_Container2 com grade de lotes
1901:     * cnt_4c_Container2: Top=207, Left=287, Width=432, Height=264 (Visible=.F.)
1902:     * Cursor: TmpNens (datasession do form pai) - 3 colunas: Lote, Qtde, Prazo
1903:     *==========================================================================
1904:     PROTECTED PROCEDURE ConfigurarContainer2()
1905:         LOCAL loc_oCnt, loc_oGrd, loc_oCol, loc_oBtn, loc_oErro
1906: 
1907:         TRY
1908:             loc_oCnt = THIS.cnt_4c_Container2
1909: 
1910:             *-- Grade de lotes
1911:             loc_oCnt.AddObject("grd_4c_Lotes", "GridBase")
1912:             loc_oGrd = loc_oCnt.grd_4c_Lotes
1913:             WITH loc_oGrd
1914:                 .Top              = 10
1915:                 .Left             = 5
1916:                 .Width            = 420
1917:                 .Height           = 218
1918:                 .RecordSource     = "TmpNens"
1919:                 .RecordSourceType = 1
1920:                 .ColumnCount      = 3
1921:                 .DeleteMark       = .F.
1922:                 .ReadOnly         = .F.
1923:                 .FontName         = "Tahoma"
1924:                 .FontSize         = 8
1925:                 .Visible          = .T.
1926:             ENDWITH
1927: 
1928:             *-- Coluna 1: Lote
1929:             loc_oCol = loc_oGrd.Columns(1)
1930:             loc_oCol.Width           = 160
1931:             loc_oCol.Header1.Caption = "Lote"
1932:             loc_oCol.Controls(1).ControlSource = "TmpNens.Lote"
1933: 
1934:             *-- Coluna 2: Qtde do lote
1935:             loc_oCol = loc_oGrd.Columns(2)
1936:             loc_oCol.Width           = 120
1937:             loc_oCol.Header1.Caption = "Quantidade"
1938:             loc_oCol.Controls(1).ControlSource = "TmpNens.Qtde"
1939: 
1940:             *-- Coluna 3: Prazo/Vencimento
1941:             loc_oCol = loc_oGrd.Columns(3)
1942:             loc_oCol.Width           = 120
1943:             loc_oCol.Header1.Caption = "Saldo"
1944:             loc_oCol.Controls(1).ControlSource = "TmpNens.Prazo"

*-- Linhas 1956 a 2021:
1956:                 .FontSize = 8
1957:                 .Visible  = .T.
1958:             ENDWITH
1959:             BINDEVENT(loc_oCnt.cmd_4c_OkLotes, "Click", THIS, "BtnOkLotesClick")
1960: 
1961:         CATCH TO loc_oErro
1962:             MsgErro(loc_oErro.Message, "Erro ao configurar painel de lotes")
1963:         ENDTRY
1964:     ENDPROC
1965: 
1966:     *==========================================================================
1967:     * BtnOkLotesClick - Fecha o painel de lotes
1968:     *==========================================================================
1969:     PROCEDURE BtnOkLotesClick()
1970:         IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
1971:             THIS.cnt_4c_Container2.Visible = .F.
1972:         ENDIF
1973:     ENDPROC
1974: 
1975:     *==========================================================================
1976:     * ConfigurarEstadoInicial - Define visibilidade/estado apos TornarControlesVisiveis
1977:     * EncerraPCC: visivel so quando crSigCdOpd.Pccs = .T.
1978:     * Botoes CRUD: Enabled conforme flags Inibe*
1979:     * Grade: posiciona no primeiro registro de xNensi
1980:     *==========================================================================
1981:     PROTECTED PROCEDURE ConfigurarEstadoInicial()
1982:         LOCAL loc_lPccs, loc_oErro
1983: 
1984:         TRY
1985:             *-- EncerraPCC: visivel apenas se OP tem controle PCC
1986:             loc_lPccs = .F.
1987:             IF USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0
1988:                 GO TOP IN crSigCdOpd
1989:                 loc_lPccs = NVL(crSigCdOpd.Pccs, .F.)
1990:             ENDIF
1991:             IF PEMSTATUS(THIS, "cmd_4c_EncerraPCC", 5)
1992:                 THIS.cmd_4c_EncerraPCC.Visible = loc_lPccs
1993:             ENDIF
1994: 
1995:             *-- Botoes CRUD: Enabled baseado nas flags Inibe*
1996:             IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
1997:                 THIS.cmd_4c_Inserir.Enabled = !THIS.InibeInserir
1998:             ENDIF
1999:             IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
2000:                 THIS.cmd_4c_Alterar.Enabled = !THIS.InibeAlterar
2001:             ENDIF
2002:             IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2003:                 THIS.cmd_4c_Excluir.Enabled = !THIS.InibeExcluir
2004:             ENDIF
2005: 
2006:             *-- Grade: posiciona no primeiro registro e atualiza GetDescr/GetObs
2007:             IF USED("xNensi") AND RECCOUNT("xNensi") > 0
2008:                 GO TOP IN xNensi
2009:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2010:                     THIS.grd_4c_Dados.Refresh()
2011:                 ENDIF
2012:                 IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
2013:                     THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
2014:                 ENDIF
2015:                 IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2016:                     THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
2017:                 ENDIF
2018:             ENDIF
2019: 
2020:             *-- Preencher container de Operacao com dados da OP corrente
2021:             IF USED("crSigCdOpd") AND RECCOUNT("crSigCdOpd") > 0

*-- Linhas 2043 a 2110:
2043: 
2044:     *==========================================================================
2045:     * ConfigurarPaginaLista - Monta a "pagina de lista" do form operacional:
2046:     *   - Grade principal (xNensi) com 13 colunas + BINDEVENTs
2047:     *   - Botoes de acao (Sair, Lotes, EncerraPCC, Inserir, Alterar, Excluir)
2048:     * Forms OPERACIONAIS nao tem PageFrame; este metodo agrega o que num CRUD
2049:     * estaria na Page1 (Lista) para manter compatibilidade com a convencao do
2050:     * pipeline e simplificar futura manutencao.
2051:     *==========================================================================
2052:     PROTECTED PROCEDURE ConfigurarPaginaLista()
2053:         LOCAL loc_oErro
2054: 
2055:         TRY
2056:             THIS.ConfigurarGradePrincipal()
2057:             THIS.ConfigurarBotoesPrincipais()
2058:         CATCH TO loc_oErro
2059:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina de lista")
2060:         ENDTRY
2061:     ENDPROC
2062: 
2063:     *==========================================================================
2064:     * ConfigurarPaginaDados - Campos de dados do form (Fase 5 - Parte 1/2)
2065:     * Popula cnt_4c_Operacao (informacoes da OP corrente) + Shape2 (separador)
2066:     * + area de Cor/Tamanho + area de Descricao/Observacao (posicoes corretas
2067:     *   do original: Get_descr Top=529, Get_obs Top=552).
2068:     * Parte 2/2 (Fase 6): cnt_4c_Servico filhos.
2069:     *==========================================================================
2070:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2071:         LOCAL loc_oCnt, loc_oErro
2072: 
2073:         TRY
2074:             *------------------------------------------------------------------
2075:             * Preencher cnt_4c_Operacao (criado vazio em ConfigurarContainerOperacao)
2076:             * Exibe: label "Movimenta??o :" + empresa + descricao OP + codigo prog
2077:             *------------------------------------------------------------------
2078:             loc_oCnt = THIS.cnt_4c_Operacao
2079: 
2080:             loc_oCnt.AddObject("lbl_4c_Say4", "Label")
2081:             WITH loc_oCnt.lbl_4c_Say4
2082:                 .Top       = 9
2083:                 .Left      = 19
2084:                 .Width     = 78
2085:                 .Height    = 15
2086:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
2087:                 .FontName  = "Tahoma"
2088:                 .FontSize  = 8
2089:                 .BackStyle = 0
2090:                 .ForeColor = RGB(0, 0, 0)
2091:                 .Visible   = .T.
2092:             ENDWITH
2093: 
2094:             *-- GetEmpresa: codigo da empresa - preenchido em ConfigurarEstadoInicial
2095:             loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
2096:             WITH loc_oCnt.txt_4c_Empresa
2097:                 .Top         = 5
2098:                 .Left        = 99
2099:                 .Width       = 36
2100:                 .Height      = 23
2101:                 .ReadOnly    = .T.
2102:                 .FontName    = "Tahoma"
2103:                 .FontSize    = 8
2104:                 .BorderStyle = 1
2105:                 .Value       = ""
2106:                 .Visible     = .T.
2107:             ENDWITH
2108: 
2109:             *-- GetOperacao: descricao/numero da OP - preenchido em ConfigurarEstadoInicial
2110:             loc_oCnt.AddObject("txt_4c_OperacaoOp", "TextBox")

*-- Linhas 2283 a 2326:
2283:     * AlternarPagina - Alterna visibilidade dos paineis flutuantes operacionais
2284:     * par_cContainer: "LOTES" | "SERVICO" | "AUX" | "" (fecha todos)
2285:     *==========================================================================
2286:     PROCEDURE AlternarPagina(par_cContainer)
2287:         LOCAL loc_cAlvo, loc_oErro
2288: 
2289:         TRY
2290:             loc_cAlvo = UPPER(ALLTRIM(IIF(VARTYPE(par_cContainer) = "C", par_cContainer, "")))
2291: 
2292:             DO CASE
2293:                 CASE loc_cAlvo = "LOTES" AND PEMSTATUS(THIS, "cnt_4c_Container2", 5)
2294:                     THIS.cnt_4c_Container2.Visible = !THIS.cnt_4c_Container2.Visible
2295:                     IF THIS.cnt_4c_Container2.Visible
2296:                         THIS.cnt_4c_Container2.Refresh()
2297:                     ENDIF
2298: 
2299:                 CASE loc_cAlvo = "SERVICO" AND PEMSTATUS(THIS, "cnt_4c_Servico", 5)
2300:                     THIS.cnt_4c_Servico.Visible = !THIS.cnt_4c_Servico.Visible
2301:                     IF THIS.cnt_4c_Servico.Visible
2302:                         THIS.cnt_4c_Servico.Refresh()
2303:                     ENDIF
2304: 
2305:                 CASE loc_cAlvo = "AUX" AND PEMSTATUS(THIS, "cnt_4c_Container1", 5)
2306:                     THIS.cnt_4c_Container1.Visible = !THIS.cnt_4c_Container1.Visible
2307:                     IF THIS.cnt_4c_Container1.Visible
2308:                         THIS.cnt_4c_Container1.Refresh()
2309:                     ENDIF
2310: 
2311:                 OTHERWISE
2312:                     *-- Sem alvo: fecha todos os paineis flutuantes (estado lista)
2313:                     IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
2314:                         THIS.cnt_4c_Container2.Visible = .F.
2315:                     ENDIF
2316:                     IF PEMSTATUS(THIS, "cnt_4c_Servico", 5)
2317:                         THIS.cnt_4c_Servico.Visible = .F.
2318:                     ENDIF
2319:                     IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
2320:                         THIS.cnt_4c_Container1.Visible = .F.
2321:                     ENDIF
2322:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2323:                         THIS.grd_4c_Dados.SetFocus()
2324:                     ENDIF
2325:             ENDCASE
2326: 

*-- Linhas 2334 a 2379:
2334:     * Replica: Cnt_Servico.* do legado SIGPDMP2
2335:     * Labels: Label2/Label4/Label1/Label5/Label6
2336:     * TextBoxes: GetCpro/GetDpro/GetValor/GetMoeda/GetQtde/GetTotal/GetRetrab
2337:     * BINDEVENTs: When (AlteraServico), LostFocus (recalculo), KeyPress (lookup)
2338:     *==========================================================================
2339:     PROTECTED PROCEDURE ConfigurarCntServico()
2340:         LOCAL loc_oCnt, loc_oErro
2341: 
2342:         TRY
2343:             loc_oCnt = THIS.cnt_4c_Servico
2344: 
2345:             *-- Label2: "Servico :" - rotulo de txt_4c_GetCpro
2346:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
2347:             WITH loc_oCnt.lbl_4c_Label2
2348:                 .Top       = 5
2349:                 .Left      = 31
2350:                 .Width     = 44
2351:                 .Height    = 15
2352:                 .Caption   = "Servi" + CHR(231) + "o :"
2353:                 .AutoSize  = .T.
2354:                 .FontName  = "Tahoma"
2355:                 .FontSize  = 8
2356:                 .BackStyle = 0
2357:                 .ForeColor = RGB(90, 90, 90)
2358:                 .Visible   = .T.
2359:             ENDWITH
2360: 
2361:             *-- txt_4c_GetCpro: codigo do material do servico (ReadOnly)
2362:             loc_oCnt.AddObject("txt_4c_GetCpro", "TextBox")
2363:             WITH loc_oCnt.txt_4c_GetCpro
2364:                 .Top           = 2
2365:                 .Left          = 77
2366:                 .Width         = 113
2367:                 .Height        = 23
2368:                 .ControlSource = "xNensi.cMats"
2369:                 .ReadOnly      = .T.
2370:                 .MaxLength     = 14
2371:                 .FontName      = "Tahoma"
2372:                 .FontSize      = 8
2373:                 .BorderStyle   = 1
2374:                 .BorderColor   = RGB(100, 100, 100)
2375:                 .Visible       = .T.
2376:             ENDWITH
2377: 
2378:             *-- txt_4c_GetDpro: descricao do servico (ReadOnly)
2379:             loc_oCnt.AddObject("txt_4c_GetDpro", "TextBox")

*-- Linhas 2541 a 2731:
2541:                 .Visible       = .T.
2542:             ENDWITH
2543: 
2544:             *-- BINDEVENTs: When - editabilidade controlada por AlteraServico
2545:             BINDEVENT(loc_oCnt.txt_4c_GetValor,  "When", THIS, "CntServicoEditavelWhen")
2546:             BINDEVENT(loc_oCnt.txt_4c_GetMoeda,  "When", THIS, "CntServicoEditavelWhen")
2547:             BINDEVENT(loc_oCnt.txt_4c_GetRetrab, "When", THIS, "CntServicoEditavelWhen")
2548: 
2549:             *-- BINDEVENTs: LostFocus - recalculo de get_total
2550:             BINDEVENT(loc_oCnt.txt_4c_GetValor,  "KeyPress", THIS, "CntServicoGetValorLostFocus")
2551:             BINDEVENT(loc_oCnt.txt_4c_GetRetrab, "KeyPress", THIS, "CntServicoGetRetrabLostFocus")
2552: 
2553:             *-- BINDEVENT: KeyPress em txt_4c_GetMoeda (F4/ENTER/TAB = lookup SigCdMoe)
2554:             BINDEVENT(loc_oCnt.txt_4c_GetMoeda, "KeyPress", THIS, "AbrirLookupMoeda")
2555: 
2556:         CATCH TO loc_oErro
2557:             MsgErro(loc_oErro.Message, "Erro ao configurar Cnt_Servico")
2558:         ENDTRY
2559:     ENDPROC
2560: 
2561:     *==========================================================================
2562:     * CntServicoEditavelWhen - Handler de When para get_valor/get_moeda/GetRetrab
2563:     * Retorna THIS.AlteraServico: .T.=campo editavel, .F.=bloqueado para edicao
2564:     * Replica: When = "RETURN ThisForm.AlteraServico" do legado SIGPDMP2
2565:     *==========================================================================
2566:     FUNCTION CntServicoEditavelWhen()
2567:         RETURN THIS.AlteraServico
2568:     ENDFUNC
2569: 
2570:     *==========================================================================
2571:     * CntServicoGetValorLostFocus - LostFocus de txt_4c_GetValor
2572:     * Recalcula get_total = Round(valor * xNensi.Qtds, 2)
2573:     * Replica: get_valor.LostFocus do legado SIGPDMP2
2574:     *==========================================================================
2575:     PROCEDURE CntServicoGetValorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2576:         LOCAL loc_nTotal, loc_oErro
2577:         TRY
2578:             IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi") ;
2579:                     AND PEMSTATUS(THIS, "cnt_4c_Servico", 5) ;
2580:                     AND PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetTotal", 5)
2581:                 loc_nTotal = ROUND(NVL(THIS.cnt_4c_Servico.txt_4c_GetValor.Value, 0) * NVL(xNensi.Qtds, 0), 2)
2582:                 THIS.cnt_4c_Servico.txt_4c_GetTotal.Value = loc_nTotal
2583:                 THIS.cnt_4c_Servico.txt_4c_GetTotal.Refresh()
2584:             ENDIF
2585:         CATCH TO loc_oErro
2586:             MsgErro(loc_oErro.Message, "Erro LostFocus get_valor")
2587:         ENDTRY
2588:     ENDPROC
2589: 
2590:     *==========================================================================
2591:     * CntServicoGetRetrabLostFocus - LostFocus de txt_4c_GetRetrab
2592:     * Recalcula get_total = Round(retrab * xNensi.Qtds, 2)
2593:     * Replica: Get_Retrab.LostFocus do legado SIGPDMP2
2594:     *==========================================================================
2595:     PROCEDURE CntServicoGetRetrabLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2596:         LOCAL loc_nTotal, loc_oErro
2597:         TRY
2598:             IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi") ;
2599:                     AND PEMSTATUS(THIS, "cnt_4c_Servico", 5) ;
2600:                     AND PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetTotal", 5)
2601:                 loc_nTotal = ROUND(NVL(THIS.cnt_4c_Servico.txt_4c_GetRetrab.Value, 0) * NVL(xNensi.Qtds, 0), 2)
2602:                 THIS.cnt_4c_Servico.txt_4c_GetTotal.Value = loc_nTotal
2603:                 THIS.cnt_4c_Servico.txt_4c_GetTotal.Refresh()
2604:             ENDIF
2605:         CATCH TO loc_oErro
2606:             MsgErro(loc_oErro.Message, "Erro LostFocus Get_Retrab")
2607:         ENDTRY
2608:     ENDPROC
2609: 
2610:     *==========================================================================
2611:     * AbrirLookupMoeda - KeyPress em txt_4c_GetMoeda (F4=115 / ENTER=13 / TAB=9)
2612:     * Lookup SigCdMoe via FormBuscaAuxiliar -> cursor crListaRemota (CMOES, DMOES)
2613:     * Replica: get_moeda.Valid do legado (fwBuscaExt -> SigCdMoe)
2614:     *==========================================================================
2615:     PROCEDURE AbrirLookupMoeda(par_nKeyCode, par_nShiftAltCtrl)
2616:         LOCAL loc_oForm, loc_cValor, loc_oErro
2617:         TRY
2618:             IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
2619:                 IF !PEMSTATUS(THIS, "cnt_4c_Servico", 5)
2620:                     RETURN
2621:                 ENDIF
2622:                 loc_cValor = ALLTRIM(NVL(THIS.cnt_4c_Servico.txt_4c_GetMoeda.Value, ""))
2623:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2624:                     "SigCdMoe", "crListaRemota", "CMOES", loc_cValor, ;
2625:                     "Sele" + CHR(231) + CHR(227) + "o")
2626:                 IF ISNULL(loc_oForm)
2627:                     RETURN
2628:                 ENDIF
2629:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
2630:                     THIS.cnt_4c_Servico.txt_4c_GetMoeda.Value = ALLTRIM(crListaRemota.CMOES)
2631:                     THIS.cnt_4c_Servico.txt_4c_GetMoeda.Refresh()
2632:                 ELSE
2633:                     IF !loc_oForm.this_lAchouRegistro
2634:                     loc_oForm.mAddColuna("CMOES", "", "C" + CHR(243) + "digo")
2635:                     loc_oForm.mAddColuna("DMOES", "", "Descri" + CHR(231) + CHR(227) + "o")
2636:                     loc_oForm.Show()
2637:                     IF loc_oForm.this_lSelecionou ;
2638:                             AND PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetMoeda", 5)
2639:                         THIS.cnt_4c_Servico.txt_4c_GetMoeda.Value = ALLTRIM(crListaRemota.CMOES)
2640:                         THIS.cnt_4c_Servico.txt_4c_GetMoeda.Refresh()
2641:                     ENDIF
2642:                     ENDIF
2643:                 ENDIF
2644:                 IF USED("crListaRemota")
2645:                     USE IN crListaRemota
2646:                 ENDIF
2647:                 loc_oForm.Release()
2648:             ENDIF
2649:         CATCH TO loc_oErro
2650:             MsgErro(loc_oErro.Message, "Erro lookup Moeda")
2651:         ENDTRY
2652:     ENDPROC
2653: 
2654:     *==========================================================================
2655:     * CarregarLista - Vincula grd_4c_Dados ao cursor xNensi e refresca
2656:     * Em forms OPERACIONAIS substitui o CarregarLista CRUD: nao busca SQL,
2657:     * apenas rebinda o grid ao cursor compartilhado do form pai e reposiciona.
2658:     *==========================================================================
2659:     PROCEDURE CarregarLista()
2660:         LOCAL loc_lSucesso, loc_oErro
2661: 
2662:         loc_lSucesso = .F.
2663: 
2664:         TRY
2665:             IF !USED("xNensi")
2666:                 MsgErro("Cursor xNensi n" + CHR(227) + "o dispon" + ;
2667:                     CHR(237) + "vel.", "Erro CarregarLista")
2668:             ELSE
2669:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2670:                     THIS.grd_4c_Dados.RecordSource = "xNensi"
2671:                     THIS.grd_4c_Dados.Refresh()
2672:                 ENDIF
2673:                 IF RECCOUNT("xNensi") > 0
2674:                     GO TOP IN xNensi
2675:                 ENDIF
2676:                 loc_lSucesso = .T.
2677:             ENDIF
2678:         CATCH TO loc_oErro
2679:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de componentes")
2680:         ENDTRY
2681: 
2682:         RETURN loc_lSucesso
2683:     ENDPROC
2684: 
2685:     *==========================================================================
2686:     * FormParaBO - Sincroniza estado do form com o Business Object
2687:     * Para forms OPERACIONAIS que operam sobre cursor VFP compartilhado,
2688:     * os "campos" sao as propriedades de estado: pcEscolha, valores anteriores,
2689:     * flags de controle. Mantem BO em sincronia com o estado corrente.
2690:     *==========================================================================
2691:     PROCEDURE FormParaBO()
2692:         LOCAL loc_oBO, loc_oErro
2693: 
2694:         TRY
2695:             loc_oBO = THIS.this_oBusinessObject
2696:             IF VARTYPE(loc_oBO) != "O"
2697:                 loc_lResultado = .F.
2698:             ENDIF
2699: 
2700:             *-- Modo de operacao
2701:             loc_oBO.this_cPcEscolha     = THIS.pcEscolha
2702:             loc_oBO.this_cPEmps         = THIS.pEmps
2703: 
2704:             *-- Estado operacional
2705:             loc_oBO.this_lInfoLote      = THIS.InfoLote
2706:             loc_oBO.this_lInfoEnve      = THIS.InfoEnve
2707:             loc_oBO.this_lEditaEnve     = THIS.EditaEnve
2708:             loc_oBO.this_nCtrlAgrega    = THIS.CtrlAgrega
2709:             loc_oBO.this_lAlteraServico = THIS.AlteraServico
2710:             loc_oBO.this_nCompAgru      = THIS.CompAgru
2711:             loc_oBO.this_lLibInserir    = THIS.LibInserir
2712:             loc_oBO.this_lInibeInserir  = THIS.InibeInserir
2713:             loc_oBO.this_lInibeAlterar  = THIS.InibeAlterar
2714:             loc_oBO.this_lInibeExcluir  = THIS.InibeExcluir
2715: 
2716:             *-- Valores anteriores (usados nas validacoes do grid)
2717:             loc_oBO.this_cAntValue      = THIS.AntValue
2718:             loc_oBO.this_nAntQtde       = THIS.AntQtde
2719:             loc_oBO.this_nAntPeso       = THIS.AntPeso
2720:             loc_oBO.this_nAntValueP     = THIS.AntValueP
2721:             loc_oBO.this_cObsAnterior   = THIS.ObsAnterior
2722: 
2723:             *-- Linha corrente de xNensi (se disponivel)
2724:             IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi")
2725:                 loc_oBO.this_cCMats     = ALLTRIM(NVL(xNensi.Cmats, ""))
2726:                 loc_oBO.this_nNops      = NVL(xNensi.Nops, 0)
2727:                 loc_oBO.this_nNenvs     = NVL(xNensi.Nenvs, 0)
2728:                 loc_oBO.this_cTpOps     = ALLTRIM(NVL(xNensi.TpOps, ""))
2729:                 loc_oBO.this_nQtds      = NVL(xNensi.Qtds, 0)
2730:                 loc_oBO.this_nPesos     = NVL(xNensi.Pesos, 0)
2731:                 loc_oBO.this_cCats      = ALLTRIM(NVL(xNensi.Cats, ""))

*-- Linhas 2749 a 2792:
2749:     * Atualiza campos de exibicao a partir do BO (descricoes de lookup,
2750:     * flags de controle, estado dos botoes).
2751:     *==========================================================================
2752:     PROCEDURE BOParaForm()
2753:         LOCAL loc_oBO, loc_oErro
2754: 
2755:         TRY
2756:             loc_oBO = THIS.this_oBusinessObject
2757:             IF VARTYPE(loc_oBO) != "O"
2758:                 loc_lResultado = .F.
2759:             ENDIF
2760: 
2761:             *-- Modo de operacao (pode ter sido alterado pelo sub-form)
2762:             THIS.pcEscolha     = loc_oBO.this_cPcEscolha
2763:             THIS.AlteraServico = loc_oBO.this_lAlteraServico
2764:             THIS.CtrlAgrega    = loc_oBO.this_nCtrlAgrega
2765: 
2766:             *-- Valores anteriores (restaura apos retorno de sub-forms)
2767:             THIS.AntValue    = loc_oBO.this_cAntValue
2768:             THIS.AntQtde     = loc_oBO.this_nAntQtde
2769:             THIS.AntPeso     = loc_oBO.this_nAntPeso
2770:             THIS.AntValueP   = loc_oBO.this_nAntValueP
2771:             THIS.ObsAnterior = loc_oBO.this_cObsAnterior
2772: 
2773:             *-- Atualiza campos de exibicao da linha corrente
2774:             IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi")
2775:                 IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
2776:                     THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
2777:                 ENDIF
2778:                 IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2779:                     THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
2780:                 ENDIF
2781:                 IF PEMSTATUS(THIS, "txt_4c_Cor", 5)
2782:                     THIS.txt_4c_Cor.Value = ALLTRIM(NVL(xNensi.Cors, ""))
2783:                 ENDIF
2784:                 IF PEMSTATUS(THIS, "txt_4c_Tam", 5)
2785:                     THIS.txt_4c_Tam.Value = ALLTRIM(NVL(xNensi.Tams, ""))
2786:                 ENDIF
2787:             ENDIF
2788: 
2789:             *-- Atualiza estado dos botoes de acordo com modo atual
2790:             THIS.AjustarBotoesPorModo()
2791: 
2792:         CATCH TO loc_oErro

*-- Linhas 2801 a 2844:
2801:     * INSERIR/ALTERAR: grid editavel, campos de filtro habilitados
2802:     * VISUALIZAR/demais: grid ReadOnly, campos bloqueados
2803:     *==========================================================================
2804:     PROCEDURE HabilitarCampos()
2805:         LOCAL loc_lEdita, loc_oErro
2806: 
2807:         TRY
2808:             loc_lEdita = INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
2809: 
2810:             *-- Grade principal: modo de edicao
2811:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2812:                 THIS.grd_4c_Dados.ReadOnly    = !loc_lEdita
2813:             ENDIF
2814: 
2815:             *-- Campo de observacao (sempre ReadOnly - exibicao apenas)
2816:             IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2817:                 THIS.txt_4c_GetObs.ReadOnly = .T.
2818:             ENDIF
2819: 
2820:             *-- Campos de cor e tamanho (sempre ReadOnly - preenchidos via grid)
2821:             IF PEMSTATUS(THIS, "txt_4c_Cor", 5)
2822:                 THIS.txt_4c_Cor.ReadOnly = .T.
2823:             ENDIF
2824:             IF PEMSTATUS(THIS, "txt_4c_Tam", 5)
2825:                 THIS.txt_4c_Tam.ReadOnly = .T.
2826:             ENDIF
2827: 
2828:             *-- Botoes de manipulacao
2829:             THIS.AjustarBotoesPorModo()
2830: 
2831:             *-- Checkboxes que abrem forms de edicao
2832:             IF PEMSTATUS(THIS, "chk_4c_Retrabalho", 5)
2833:                 THIS.chk_4c_Retrabalho.Enabled = loc_lEdita
2834:             ENDIF
2835:             IF PEMSTATUS(THIS, "chk_4c_Pagto", 5)
2836:                 THIS.chk_4c_Pagto.Enabled = loc_lEdita
2837:             ENDIF
2838:             IF PEMSTATUS(THIS, "chk_4c_RetrabAnt", 5)
2839:                 THIS.chk_4c_RetrabAnt.Enabled = loc_lEdita
2840:             ENDIF
2841:             IF PEMSTATUS(THIS, "chk_4c_Naoconforme", 5)
2842:                 THIS.chk_4c_Naoconforme.Enabled = loc_lEdita
2843:             ENDIF
2844:             IF PEMSTATUS(THIS, "chk_4c_Agregado", 5)

*-- Linhas 2854 a 2993:
2854:     * LimparCampos - Limpa campos de exibicao (descricao, observacao, cor, tam)
2855:     * Usado ao entrar em modo INCLUIR ou para resetar visualizacao.
2856:     *==========================================================================
2857:     PROCEDURE LimparCampos()
2858:         LOCAL loc_oErro
2859: 
2860:         TRY
2861:             IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
2862:                 THIS.lbl_4c_GetDescr.Caption = ""
2863:             ENDIF
2864:             IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2865:                 THIS.txt_4c_GetObs.Value = ""
2866:             ENDIF
2867:             IF PEMSTATUS(THIS, "txt_4c_Cor", 5)
2868:                 THIS.txt_4c_Cor.Value = ""
2869:             ENDIF
2870:             IF PEMSTATUS(THIS, "txt_4c_Tam", 5)
2871:                 THIS.txt_4c_Tam.Value = ""
2872:             ENDIF
2873: 
2874:             *-- Limpa painel de servico
2875:             IF PEMSTATUS(THIS, "cnt_4c_Servico", 5)
2876:                 IF PEMSTATUS(THIS.cnt_4c_Servico, "txt_4c_GetTotal", 5)
2877:                     THIS.cnt_4c_Servico.txt_4c_GetTotal.Value = 0
2878:                 ENDIF
2879:             ENDIF
2880: 
2881:         CATCH TO loc_oErro
2882:             MsgErro(loc_oErro.Message, "Erro ao limpar campos")
2883:         ENDTRY
2884:     ENDPROC
2885: 
2886:     *==========================================================================
2887:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme pcEscolha e flags
2888:     * INSERIR/ALTERAR + !Inibe*: botoes habilitados
2889:     * VISUALIZAR/demais: todos os botoes de manipulacao desabilitados
2890:     *==========================================================================
2891:     PROCEDURE AjustarBotoesPorModo()
2892:         LOCAL loc_lEdita, loc_oErro
2893: 
2894:         TRY
2895:             loc_lEdita = INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
2896: 
2897:             IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
2898:                 THIS.cmd_4c_Inserir.Enabled = loc_lEdita AND !THIS.InibeInserir
2899:             ENDIF
2900:             IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
2901:                 THIS.cmd_4c_Alterar.Enabled = loc_lEdita AND !THIS.InibeAlterar
2902:             ENDIF
2903:             IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2904:                 THIS.cmd_4c_Excluir.Enabled = loc_lEdita AND !THIS.InibeExcluir
2905:             ENDIF
2906:             IF PEMSTATUS(THIS, "cmd_4c_EncerraPCC", 5)
2907:                 THIS.cmd_4c_EncerraPCC.Enabled = loc_lEdita
2908:             ENDIF
2909: 
2910:             *-- Sair e Lotes: sempre habilitados
2911:             IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
2912:                 THIS.cmd_4c_Sair.Enabled = .T.
2913:             ENDIF
2914:             IF PEMSTATUS(THIS, "cmd_4c_Lotes", 5)
2915:                 THIS.cmd_4c_Lotes.Enabled = .T.
2916:             ENDIF
2917: 
2918:         CATCH TO loc_oErro
2919:             MsgErro(loc_oErro.Message, "Erro ao ajustar bot" + CHR(245) + "es por modo")
2920:         ENDTRY
2921:     ENDPROC
2922: 
2923:     *==========================================================================
2924:     * BtnEncerrarClick - Alias canonico de saida para forms OPERACIONAIS
2925:     * Delega para BtnSairClick que executa a validacao completa (ok.Click legado)
2926:     * antes de fechar o form.
2927:     *==========================================================================
2928:     PROCEDURE BtnEncerrarClick()
2929:         THIS.BtnSairClick()
2930:     ENDPROC
2931: 
2932:     *==========================================================================
2933:     * BtnSalvarClick - Aceita o estado corrente dos componentes e fecha
2934:     * Em forms OPERACIONAIS o "salvar" significa aceitar as alteracoes no
2935:     * cursor xNensi e retornar ao form pai (que gerencia o commit para o banco).
2936:     * Replica a logica do ok.Click do legado: valida e fecha.
2937:     *==========================================================================
2938:     PROCEDURE BtnSalvarClick()
2939:         THIS.BtnSairClick()
2940:     ENDPROC
2941: 
2942:     *==========================================================================
2943:     * BtnCancelarClick - Reverte alteracoes no cursor xNensi e fecha o form
2944:     * Cancela todas as edicoes em andamento: TABLEREVERT .T. desfaz todos os
2945:     * registros alterados/adicionados desde o ultimo TABLEUPDATE.
2946:     * O form pai (SigPdMfa) continua com xNensi no estado anterior a abertura.
2947:     *==========================================================================
2948:     PROCEDURE BtnCancelarClick()
2949:         LOCAL loc_oErro
2950: 
2951:         TRY
2952:             IF USED("xNensi")
2953:                 *-- Desfaz edicoes no buffer da tabela
2954:                 TABLEREVERT(.T., "xNensi")
2955:             ENDIF
2956:             THIS.Release()
2957:         CATCH TO loc_oErro
2958:             MsgErro(loc_oErro.Message, "Erro ao cancelar componentes")
2959:         ENDTRY
2960:     ENDPROC
2961: 
2962:     *==========================================================================
2963:     * BtnBuscarClick - Refresca o grid de componentes (reposiciona no topo)
2964:     * Em forms OPERACIONAIS sem campo de filtro, "buscar" equivale a recarregar
2965:     * a lista a partir do cursor xNensi e posicionar no primeiro registro.
2966:     *==========================================================================
2967:     PROCEDURE BtnBuscarClick()
2968:         LOCAL loc_oErro
2969: 
2970:         TRY
2971:             IF USED("xNensi")
2972:                 SELECT xNensi
2973:                 SET ORDER TO
2974:                 GO TOP
2975:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2976:                     THIS.grd_4c_Dados.Refresh()
2977:                 ENDIF
2978:                 *-- Atualiza campos de exibicao da linha corrente
2979:                 IF !EOF("xNensi")
2980:                     IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
2981:                         THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
2982:                     ENDIF
2983:                     IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2984:                         THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
2985:                     ENDIF
2986:                 ENDIF
2987:             ENDIF
2988:         CATCH TO loc_oErro
2989:             MsgErro(loc_oErro.Message, "Erro ao buscar componentes")
2990:         ENDTRY
2991:     ENDPROC
2992: 
2993: ENDDEFINE

