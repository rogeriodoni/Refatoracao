# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupTamanho()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCor()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_nPesoFixs define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_nPesoFixs.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp9.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2155 linhas total):

*-- Linhas 38 a 109:
38:     *==========================================================================
39:     * Init - Recebe referencia ao form pai e compartilha datasession
40:     *==========================================================================
41:     PROCEDURE Init(par_oParentForm)
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44:         IF VARTYPE(par_oParentForm) <> "O"
45:             MsgErro("FormSigPdMp9 requer referencia ao form pai.", "Erro")
46:             RETURN .F.
47:         ENDIF
48:         THIS.this_oPaiForm = par_oParentForm
49:         THIS.DataSessionId = par_oParentForm.DataSessionId
50:         loc_lSucesso = DODEFAULT()
51:         RETURN loc_lSucesso
52:     ENDPROC
53: 
54:     *==========================================================================
55:     * InicializarForm - Hook de FormBase: configura todos os controles
56:     *==========================================================================
57:     PROTECTED PROCEDURE InicializarForm()
58:         LOCAL loc_lSucesso, loc_oErro
59:         loc_lSucesso = .F.
60:         TRY
61:             *-- Imagem de fundo
62:             LOCAL loc_cImagem
63:             loc_cImagem = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\imagens\new_background.jpg"
64:             IF FILE(loc_cImagem)
65:                 THIS.Picture = loc_cImagem
66:             ENDIF
67: 
68:             *-- Cria Business Object
69:             THIS.this_oBusinessObject = CREATEOBJECT("SigPdMp9BO")
70:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
71: 
72:             *-- Data de referencia para cotacoes
73:             IF USED("TmpNens")
74:                 SELECT TmpNens
75:                 GO TOP
76:                 THIS.this_oBusinessObject.this_dDataMovimento = NVL(Datas, DATE())
77:             ENDIF
78: 
79:             *-- Codigo de acesso ao programa (crSigCdOpd.Ndopps)
80:             IF USED("crSigCdOpd")
81:                 SELECT crSigCdOpd
82:                 GO TOP
83:                 THIS.this_cProgAcesso = "P" + PADL(TRANSFORM(NVL(Ndopps, 0)), 8, "0")
84:                 THIS.this_oBusinessObject.this_cProgAcesso = THIS.this_cProgAcesso
85:             ENDIF
86: 
87:             *-- Cria cursores locais de trabalho
88:             THIS.CriarCursoresLocais()
89: 
90:             *-- Aparencia base do form (OPERACIONAL sem PageFrame Page1/Page2)
91:             THIS.ConfigurarPageFrame()
92: 
93:             *-- Interface
94:             THIS.ConfigurarCabecalho()
95:             THIS.ConfigurarPaginaLista()
96:             THIS.ConfigurarPaginaDados()
97:             THIS.ConfigurarBalanca()
98: 
99:             *-- Verifica permissao de liberar peso
100:             THIS.this_lLiberaPeso = THIS.this_oBusinessObject.BuscarPermissaoLiberaPeso()
101: 
102:             *-- Inicializa PesoFixs a partir de xNensI
103:             THIS.InicializarPesoFixs()
104: 
105:             *-- Posiciona xPesa no inicio
106:             IF USED("xPesa")
107:                 SELECT xPesa
108:                 SET ORDER TO Amarra
109:                 GO TOP

*-- Linhas 123 a 166:
123:     *==========================================================================
124:     * CriarCursoresLocais - Cria CrSigCdNei e xNensiE na datasession compartilhada
125:     *==========================================================================
126:     PROTECTED PROCEDURE CriarCursoresLocais()
127:         LOCAL loc_oErro
128:         TRY
129:             SET NULL OFF
130: 
131:             *-- CrSigCdNei: buffer local de movimentos antes de gravar no SQL Server
132:             IF USED("CrSigCdNei")
133:                 SELECT CrSigCdNei
134:                 ZAP
135:             ELSE
136:                 CREATE CURSOR CrSigCdNei ( ;
137:                     Emps      C(3),    ;
138:                     Dopps     C(10),   ;
139:                     Numps     N(10,0), ;
140:                     Nops      N(10,0), ;
141:                     Nenvs     N(10,0), ;
142:                     CMats     C(14),   ;
143:                     CDescs    C(40),   ;
144:                     CUnis     C(3),    ;
145:                     Tpops     C(3),    ;
146:                     Cats      C(6),    ;
147:                     Obss      C(40),   ;
148:                     AQtds     N(11,3), ;
149:                     Qtds      N(11,3), ;
150:                     Pesos     N(11,3), ;
151:                     FlagIncs  L,       ;
152:                     Fators    N(11,3), ;
153:                     Moedas    C(3),    ;
154:                     Servicos  L,       ;
155:                     GrupoFins C(10),   ;
156:                     nLotes    N(8,3),  ;
157:                     PesoFixs  N(3,0),  ;
158:                     cIdChaves C(20),   ;
159:                     EmpDNPs   C(23),   ;
160:                     Peso2s    N(11,3), ;
161:                     CustoFs   N(11,2), ;
162:                     MoeCusFs  C(3)     ;
163:                 )
164:             ENDIF
165: 
166:             *-- xNensiE: cursor auxiliar para rateio de peso por envelope

*-- Linhas 195 a 263:
195:     * Forms OPERACIONAIS nao tem PageFrame Page1/Page2 como CRUD.
196:     * Este metodo define propriedades visuais globais do form.
197:     *==========================================================================
198:     PROTECTED PROCEDURE ConfigurarPageFrame()
199:         THIS.BackColor  = RGB(212, 208, 200)
200:         THIS.ScrollBars = 0
201:         THIS.ShowTips   = .T.
202:         THIS.SetAll("FontName", "Tahoma")
203:         THIS.SetAll("FontSize", 8)
204:     ENDPROC
205: 
206:     *==========================================================================
207:     * Destroy - Libera objetos e cursores
208:     *==========================================================================
209:     PROCEDURE Destroy()
210:         THIS.this_oBusinessObject = .NULL.
211:         IF USED("CrSigCdNei")
212:             USE IN CrSigCdNei
213:         ENDIF
214:         IF USED("xNensiE")
215:             USE IN xNensiE
216:         ENDIF
217:         DODEFAULT()
218:     ENDPROC
219: 
220:     *==========================================================================
221:     * ConfigurarCabecalho - Container de titulo com efeito sombra
222:     *==========================================================================
223:     PROTECTED PROCEDURE ConfigurarCabecalho()
224:         LOCAL loc_cTitulo
225:         loc_cTitulo = "Pesagem de Pe" + CHR(231) + "as"
226:         THIS.AddObject("cnt_4c_Sombra", "Container")
227:         WITH THIS.cnt_4c_Sombra
228:             .Top         = 0
229:             .Left        = 0
230:             .Width       = 1100
231:             .Height      = 80
232:             .BorderWidth = 0
233:             .BackColor   = RGB(100, 100, 100)
234:             .AddObject("lbl_4c_Sombra", "Label")
235:             WITH .lbl_4c_Sombra
236:                 .FontBold   = .T.
237:                 .FontName   = "Tahoma"
238:                 .FontSize   = 18
239:                 .WordWrap   = .T.
240:                 .Alignment  = 0
241:                 .BackStyle  = 0
242:                 .Caption    = loc_cTitulo
243:                 .Height     = 40
244:                 .Left       = 10
245:                 .Top        = 18
246:                 .Width      = THIS.Width
247:                 .ForeColor  = RGB(0, 0, 0)
248:                 .Visible    = .T.
249:             ENDWITH
250:             .AddObject("lbl_4c_Titulo", "Label")
251:             WITH .lbl_4c_Titulo
252:                 .FontBold   = .T.
253:                 .FontName   = "Tahoma"
254:                 .FontSize   = 18
255:                 .WordWrap   = .T.
256:                 .Alignment  = 0
257:                 .BackStyle  = 0
258:                 .Caption    = loc_cTitulo
259:                 .Height     = 46
260:                 .Left       = 10
261:                 .Top        = 17
262:                 .Width      = THIS.Width
263:                 .ForeColor  = RGB(255, 255, 255)

*-- Linhas 270 a 329:
270:     *==========================================================================
271:     * ConfigurarPaginaLista - Configura a "pagina" principal do form OPERACIONAL
272:     * Em forms OPERACIONAIS nao ha PageFrame Page1/Page2 como nos CRUD.
273:     * Esta procedure agrupa Grid (lista de pecas) e Rodape (botoes de acao):
274:     *   - cmd_4c_Resumo    - Abre janela de resumo (SigPdM10)
275:     *   - cmd_4c_CustoP    - Visualiza custos do produto (apenas com permissao)
276:     *   - cmd_4c_Processar - Confirma pesagem e segue para SigPdM11
277:     *   - cmd_4c_Cancelar  - Cancela e fecha o form
278:     * O legado nao usa botoes CRUD (Incluir/Alterar/Excluir/Buscar) porque
279:     * a pesagem ja recebe a lista de pecas pronta do form pai.
280:     *==========================================================================
281:     PROTECTED PROCEDURE ConfigurarPaginaLista()
282:         THIS.ConfigurarGrid()
283:         THIS.ConfigurarRodape()
284:     ENDPROC
285: 
286:     *==========================================================================
287:     * ConfigurarGrid - Grid GradeItens com 9 colunas ligadas a xPesa
288:     *==========================================================================
289:     PROTECTED PROCEDURE ConfigurarGrid()
290:         LOCAL loc_lAcesso, loc_lLibObss, loc_lTrfPesas
291:         loc_lAcesso  = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
292:         loc_lLibObss = .F.
293:         loc_lTrfPesas = .F.
294:         IF USED("crSigCdPam")
295:             SELECT crSigCdPam
296:             GO TOP
297:             IF VARTYPE(crSigCdPam.LibObss) = "L"
298:                 loc_lLibObss = crSigCdPam.LibObss
299:             ELSE
300:                 IF VARTYPE(crSigCdPam.LibObss) = "L"
301:                     loc_lLibObss = crSigCdPam.LibObss
302:                 ELSE
303:                     IF VARTYPE(crSigCdPam.LibObss) = "L"
304:                         loc_lLibObss = crSigCdPam.LibObss
305:                     ELSE
306:                         loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
307:                     ENDIF
308:                 ENDIF
309:             ENDIF
310:         ENDIF
311:         IF USED("crSigCdOpd")
312:             SELECT crSigCdOpd
313:             GO TOP
314:             IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
315:                 loc_lTrfPesas = crSigCdOpd.TrfPesas
316:             ELSE
317:                 IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
318:                     loc_lTrfPesas = crSigCdOpd.TrfPesas
319:                 ELSE
320:                     IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
321:                         loc_lTrfPesas = crSigCdOpd.TrfPesas
322:                     ELSE
323:                         loc_lTrfPesas = (NVL(crSigCdOpd.TrfPesas, 0) = 1)
324:                     ENDIF
325:                 ENDIF
326:             ENDIF
327:         ENDIF
328: 
329:         THIS.AddObject("grd_4c_Itens", "Grid")

*-- Linhas 366 a 826:
366:                 .Text1.ForeColor   = RGB(0, 0, 0)
367:                 .Text1.BackColor   = RGB(255, 255, 255)
368:             ENDWITH
369:             BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "When", THIS, "GradeCol1TextWhen")
370: 
371:             *-- Column2: Observacao (Obs) - editavel com LibObss=1 e INSERIR
372:             WITH .Column2
373:                 .ControlSource     = "xPesa.Obs"
374:                 .ColumnOrder       = 6
375:                 .Width             = 100
376:                 .Movable           = .F.
377:                 .Resizable         = .F.
378:                 .ReadOnly          = !loc_lLibObss
379:                 .FontSize          = 8
380:                 .Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
381:                 .Header1.FontName  = "Tahoma"
382:                 .Header1.FontSize  = 8
383:                 .Header1.Alignment = 2
384:                 .Text1.FontSize    = 8
385:                 .Text1.BorderStyle = 0
386:                 .Text1.Margin      = 0
387:                 .Text1.ForeColor   = RGB(0, 0, 0)
388:                 .Text1.BackColor   = RGB(255, 255, 255)
389:             ENDWITH
390:             BINDEVENT(THIS.grd_4c_Itens.Column2.Text1, "When", THIS, "GradeCol2TextWhen")
391: 
392:             *-- Column3: Movimentacao (Oper) - ReadOnly
393:             WITH .Column3
394:                 .ControlSource     = "xPesa.Oper"
395:                 .ColumnOrder       = 4
396:                 .Width             = 221
397:                 .Movable           = .F.
398:                 .Resizable         = .F.
399:                 .ReadOnly          = .T.
400:                 .FontSize          = 8
401:                 .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
402:                 .Header1.FontName  = "Tahoma"
403:                 .Header1.FontSize  = 8
404:                 .Header1.Alignment = 2
405:                 .Text1.FontSize    = 8
406:                 .Text1.BorderStyle = 0
407:                 .Text1.Margin      = 0
408:                 .Text1.ReadOnly    = .T.
409:                 .Text1.ForeColor   = RGB(0, 0, 0)
410:                 .Text1.BackColor   = RGB(255, 255, 255)
411:             ENDWITH
412:             BINDEVENT(THIS.grd_4c_Itens.Column3.Text1, "When", THIS, "GradeCol3TextWhen")
413: 
414:             *-- Column4: Tamanho (Tams) - lookup SigCdTam, editavel com LibObss=1
415:             WITH .Column4
416:                 .ControlSource     = "xPesa.Tams"
417:                 .ColumnOrder       = 8
418:                 .Width             = 40
419:                 .Movable           = .F.
420:                 .Resizable         = .F.
421:                 .ReadOnly          = .F.
422:                 .FontSize          = 8
423:                 .Header1.Caption   = "Tam"
424:                 .Header1.FontName  = "Tahoma"
425:                 .Header1.FontSize  = 8
426:                 .Header1.Alignment = 2
427:                 .Text1.FontSize    = 8
428:                 .Text1.BorderStyle = 0
429:                 .Text1.Margin      = 0
430:                 .Text1.ReadOnly    = .F.
431:                 .Text1.ForeColor   = RGB(0, 0, 0)
432:                 .Text1.BackColor   = RGB(255, 255, 255)
433:             ENDWITH
434:             BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "When",     THIS, "GradeCol4TextWhen")
435:             BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "KeyPress", THIS, "GradeCol4TextKeyPress")
436:             BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "DblClick", THIS, "GradeCol4TextDblClick")
437: 
438:             *-- Column5: Quantidade (Qtds) - ReadOnly (editavel se LibObss<>1)
439:             WITH .Column5
440:                 .ControlSource     = "xPesa.Qtds"
441:                 .ColumnOrder       = 5
442:                 .Width             = 100
443:                 .Movable           = .F.
444:                 .Resizable         = .F.
445:                 .ReadOnly          = .T.
446:                 .FontBold          = .T.
447:                 .FontSize          = 8
448:                 .Format            = "K"
449:                 .Header1.Caption   = "Quantidade"
450:                 .Header1.FontName  = "Tahoma"
451:                 .Header1.FontSize  = 8
452:                 .Header1.Alignment = 2
453:                 .Text1.FontBold    = .T.
454:                 .Text1.FontSize    = 8
455:                 .Text1.BorderStyle = 0
456:                 .Text1.Format      = "K"
457:                 .Text1.Margin      = 0
458:                 .Text1.ReadOnly    = .T.
459:                 .Text1.ForeColor   = RGB(0, 0, 0)
460:                 .Text1.BackColor   = RGB(255, 255, 255)
461:             ENDWITH
462:             BINDEVENT(THIS.grd_4c_Itens.Column5.Text1, "When", THIS, "GradeCol5TextWhen")
463: 
464:             *-- Column6: Peso (Peso) - campo editavel principal com logica de balanca
465:             WITH .Column6
466:                 .ControlSource     = "xPesa.Peso"
467:                 .ColumnOrder       = 9
468:                 .Width             = 100
469:                 .Movable           = .F.
470:                 .Resizable         = .F.
471:                 .ReadOnly          = .F.
472:                 .FontBold          = .T.
473:                 .FontSize          = 8
474:                 .Header1.Caption   = "Peso"
475:                 .Header1.FontName  = "Tahoma"
476:                 .Header1.FontSize  = 8
477:                 .Header1.Alignment = 2
478:                 .Text1.FontBold    = .T.
479:                 .Text1.FontSize    = 8
480:                 .Text1.BorderStyle = 0
481:                 .Text1.Margin      = 0
482:                 .Text1.ReadOnly    = .F.
483:                 .Text1.ForeColor   = RGB(0, 0, 0)
484:                 .Text1.BackColor   = RGB(255, 255, 255)
485:             ENDWITH
486:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "When",      THIS, "GradeCol6TextWhen")
487:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "Valid",     THIS, "GradeCol6TextValid")
488:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "KeyPress", THIS, "GradeCol6TextLostFocus")
489: 
490:             *-- Column7: Cor (Cors) - lookup SigCdCor, editavel com LibObss=1
491:             WITH .Column7
492:                 .ControlSource     = "xPesa.Cors"
493:                 .ColumnOrder       = 7
494:                 .Width             = 40
495:                 .Movable           = .F.
496:                 .Resizable         = .F.
497:                 .ReadOnly          = .F.
498:                 .FontSize          = 8
499:                 .Header1.Caption   = "Cor"
500:                 .Header1.FontName  = "Tahoma"
501:                 .Header1.FontSize  = 8
502:                 .Header1.Alignment = 2
503:                 .Text1.FontSize    = 8
504:                 .Text1.BorderStyle = 0
505:                 .Text1.Margin      = 0
506:                 .Text1.ReadOnly    = .F.
507:                 .Text1.ForeColor   = RGB(0, 0, 0)
508:                 .Text1.BackColor   = RGB(255, 255, 255)
509:             ENDWITH
510:             BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "When",     THIS, "GradeCol7TextWhen")
511:             BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "KeyPress", THIS, "GradeCol7TextKeyPress")
512:             BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "DblClick", THIS, "GradeCol7TextDblClick")
513: 
514:             *-- Column8: Barras (Cbars) - ReadOnly
515:             WITH .Column8
516:                 .ControlSource     = "xPesa.Cbars"
517:                 .ColumnOrder       = 2
518:                 .Width             = 110
519:                 .Movable           = .F.
520:                 .Resizable         = .F.
521:                 .ReadOnly          = .T.
522:                 .FontSize          = 8
523:                 .Header1.Caption   = "Barras"
524:                 .Header1.FontName  = "Tahoma"
525:                 .Header1.FontSize  = 8
526:                 .Header1.Alignment = 2
527:                 .Text1.FontSize    = 8
528:                 .Text1.BorderStyle = 0
529:                 .Text1.Margin      = 0
530:                 .Text1.ReadOnly    = .T.
531:                 .Text1.ForeColor   = RGB(0, 0, 0)
532:                 .Text1.BackColor   = RGB(255, 255, 255)
533:             ENDWITH
534:             BINDEVENT(THIS.grd_4c_Itens.Column8.Text1, "When", THIS, "GradeCol8TextWhen")
535: 
536:             *-- Column9: Custo (CustoFs) - ReadOnly, visivel apenas com permissao CUSTOP
537:             WITH .Column9
538:                 .ControlSource     = "xPesa.CustoFs"
539:                 .ColumnOrder       = 1
540:                 .Movable           = .F.
541:                 .Resizable         = .F.
542:                 .ReadOnly          = .T.
543:                 .FontSize          = 8
544:                 .Header1.Caption   = "Custo"
545:                 .Header1.FontName  = "Tahoma"
546:                 .Header1.FontSize  = 8
547:                 .Header1.Alignment = 2
548:                 .Text1.FontSize    = 8
549:                 .Text1.BorderStyle = 0
550:                 .Text1.Margin      = 0
551:                 .Text1.ReadOnly    = .T.
552:                 .Text1.ForeColor   = RGB(0, 0, 0)
553:                 .Text1.BackColor   = RGB(255, 255, 255)
554:             ENDWITH
555:             BINDEVENT(THIS.grd_4c_Itens.Column9.Text1, "When",     THIS, "GradeCol9TextWhen")
556:             BINDEVENT(THIS.grd_4c_Itens.Column9.Text1, "DblClick", THIS, "GradeCol9TextDblClick")
557: 
558:             *-- Cor dinamica: peca especial em vermelho
559:             .SetAll("DynamicForeColor", ;
560:                     "IIF(xPesa.Especial,RGB(255,0,0),RGB(0,0,0))", "Column")
561: 
562:             *-- Ajuste de largura Column9 por permissao de acesso
563:             IF loc_lAcesso
564:                 .Column9.Width = 72
565:             ELSE
566:                 .Column9.Width  = 1
567:                 .Column3.Width  = .Column3.Width + 71
568:             ENDIF
569: 
570:             .Visible = .T.
571:         ENDWITH
572:     ENDPROC
573: 
574:     *==========================================================================
575:     * ConfigurarRodape - Botoes de acao, peso medio e indicador de peca especial
576:     *==========================================================================
577:     PROTECTED PROCEDURE ConfigurarRodape()
578:         LOCAL loc_cIconPath, loc_lAcesso
579:         loc_cIconPath = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\imagens\"
580:         loc_lAcesso   = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
581: 
582:         *-- Label "Peso medio :"
583:         THIS.AddObject("lbl_4c_PesoMedio", "Label")
584:         WITH THIS.lbl_4c_PesoMedio
585:             .FontSize  = 8
586:             .Caption   = "Peso m" + CHR(233) + "dio :"
587:             .Left      = 49
588:             .Top       = 88
589:             .BackStyle = 0
590:             .ForeColor = RGB(90, 90, 90)
591:             .Visible   = .T.
592:         ENDWITH
593: 
594:         *-- TextBox Peso Medio (equivalente a get_pesom do legado)
595:         THIS.AddObject("txt_4c_PesoMedio", "TextBox")
596:         WITH THIS.txt_4c_PesoMedio
597:             .FontUnderline = .T.
598:             .Alignment     = 3
599:             .Value         = 0
600:             .Height        = 23
601:             .InputMask     = "999.999"
602:             .Left          = 114
603:             .TabIndex      = 6
604:             .Top           = 84
605:             .Width         = 72
606:             .ForeColor     = RGB(0, 0, 0)
607:             .Visible       = .T.
608:         ENDWITH
609:         BINDEVENT(THIS.txt_4c_PesoMedio, "LostFocus", THIS, "TxtPesoMedioValid")
610: 
611:         *-- Indicador de peca especial (caixa vermelha decorativa - Botao1 do legado)
612:         THIS.AddObject("txt_4c_Especial", "TextBox")
613:         WITH THIS.txt_4c_Especial
614:             .Height        = 20
615:             .Left          = 12
616:             .SpecialEffect = 1
617:             .ToolTipText   = "Pe" + CHR(231) + "a Especial"
618:             .Top           = 86
619:             .Width         = 27
620:             .BackColor     = RGB(255, 0, 0)
621:             .ReadOnly      = .T.
622:             .Visible       = .T.
623:         ENDWITH
624:         BINDEVENT(THIS.txt_4c_Especial, "When", THIS, "TxtEspecialWhen")
625: 
626:         *-- Botao Resumo
627:         THIS.AddObject("cmd_4c_Resumo", "CommandButton")
628:         WITH THIS.cmd_4c_Resumo
629:             .Top       = 3
630:             .Left      = 700
631:             .Height    = 75
632:             .Width     = 75
633:             .Caption   = "\<Resumo"
634:             .Themes    = .F.
635:             .ForeColor = RGB(90, 90, 90)
636:             .BackColor = RGB(255, 255, 255)
637:             IF FILE(loc_cIconPath + "geral_documento_60.jpg")
638:                 .Picture = loc_cIconPath + "geral_documento_60.jpg"
639:             ENDIF
640:             .Visible   = .T.
641:         ENDWITH
642:         BINDEVENT(THIS.cmd_4c_Resumo, "Click", THIS, "BtnResumoClick")
643: 
644:         *-- Botao CustoP (visivel apenas com permissao CUSTOP)
645:         THIS.AddObject("cmd_4c_CustoP", "CommandButton")
646:         WITH THIS.cmd_4c_CustoP
647:             .Top         = 3
648:             .Left        = 775
649:             .Height      = 75
650:             .Width       = 75
651:             .Caption     = "Cus\<tos"
652:             .ToolTipText = "Custo Produ" + CHR(231) + CHR(227) + "o"
653:             .Themes      = .F.
654:             .ForeColor   = RGB(90, 90, 90)
655:             .BackColor   = RGB(255, 255, 255)
656:             IF FILE(loc_cIconPath + "geral_calculadora_60.jpg")
657:                 .Picture = loc_cIconPath + "geral_calculadora_60.jpg"
658:             ENDIF
659:             .Visible     = loc_lAcesso
660:         ENDWITH
661:         BINDEVENT(THIS.cmd_4c_CustoP, "Click", THIS, "BtnCustoPClick")
662: 
663:         *-- Botao Processar (Confirmar)
664:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
665:         WITH THIS.cmd_4c_Processar
666:             .Top       = 3
667:             .Left      = 850
668:             .Height    = 75
669:             .Width     = 75
670:             .Caption   = "\<Confirmar"
671:             .Themes    = .F.
672:             .ForeColor = RGB(90, 90, 90)
673:             .BackColor = RGB(255, 255, 255)
674:             IF FILE(loc_cIconPath + "cadastro_salvar_60.jpg")
675:                 .Picture = loc_cIconPath + "cadastro_salvar_60.jpg"
676:             ENDIF
677:             .Visible   = .T.
678:         ENDWITH
679:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
680: 
681:         *-- Botao Cancelar
682:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
683:         WITH THIS.cmd_4c_Cancelar
684:             .Top       = 3
685:             .Left      = 925
686:             .Height    = 75
687:             .Width     = 75
688:             .Cancel    = .T.
689:             .Caption   = "Encerrar"
690:             .Themes    = .F.
691:             .ForeColor = RGB(90, 90, 90)
692:             .BackColor = RGB(255, 255, 255)
693:             IF FILE(loc_cIconPath + "cadastro_cancelar_60.jpg")
694:                 .Picture = loc_cIconPath + "cadastro_cancelar_60.jpg"
695:             ENDIF
696:             .Visible   = .T.
697:         ENDWITH
698:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
699:     ENDPROC
700: 
701:     *==========================================================================
702:     * ConfigurarPaginaDados - Elementos visuais decorativos do form OPERACIONAL
703:     * Forms OPERACIONAIS nao tem Page2/PaginaDados como nos CRUD.
704:     * Este metodo adiciona as shapes visuais do legado (Shape2 e Shape1)
705:     * que flanqueiam a area de cabecalho e botoes respectivamente.
706:     * Shape2: moldura esquerda (area de identificacao do form)
707:     * Shape1: moldura direita (area de botoes de acao)
708:     *==========================================================================
709:     PROTECTED PROCEDURE ConfigurarPaginaDados()
710:         LOCAL loc_oErro
711:         TRY
712:             *-- Shape2: moldura decorativa lado esquerdo (area de titulo)
713:             THIS.AddObject("shp_4c_Shape2", "Shape")
714:             WITH THIS.shp_4c_Shape2
715:                 .Top         = 11
716:                 .Left        = 10
717:                 .Height      = 110
718:                 .Width       = 172
719:                 .BackStyle   = 0
720:                 .BorderStyle = 0
721:                 .BorderColor = RGB(136, 189, 188)
722:                 .Visible     = .T.
723:             ENDWITH
724: 
725:             *-- Shape1: moldura decorativa lado direito (area dos botoes de acao)
726:             THIS.AddObject("shp_4c_Shape1", "Shape")
727:             WITH THIS.shp_4c_Shape1
728:                 .Top         = 11
729:                 .Left        = 817
730:                 .Height      = 110
731:                 .Width       = 172
732:                 .BackStyle   = 0
733:                 .BorderStyle = 0
734:                 .BorderColor = RGB(0, 0, 0)
735:                 .Visible     = .T.
736:             ENDWITH
737:         CATCH TO loc_oErro
738:             MsgErro(loc_oErro.Message, "Erro ao configurar elementos visuais")
739:         ENDTRY
740:     ENDPROC
741: 
742:     *==========================================================================
743:     * ConfigurarBalanca - Conecta controle de balanca serial do framework
744:     * Configurado a partir de crSigCdPam (Porta, Velocidade, Paridade, etc.)
745:     *==========================================================================
746:     PROTECTED PROCEDURE ConfigurarBalanca()
747:         LOCAL loc_oErro
748:         THIS.this_lTemBalanca = .F.
749:         TRY
750:             IF USED("crSigCdPam")
751:             SELECT crSigCdPam
752:             GO TOP
753:             LOCAL loc_cVcx
754:             loc_cVcx = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\framework.vcx"
755:             IF FILE(loc_cVcx)
756:             SET CLASSLIB TO (loc_cVcx) ADDITIVE
757:             THIS.AddObject("bal_4c_Balanca", "balan" + CHR(231) + "a")
758:             WITH THIS.bal_4c_Balanca
759:                 .Top          = 84
760:                 .Left         = 924
761:                 .Height       = 36
762:                 .Width        = 24
763:                 .Porta        = NVL(crSigCdPam.BalPortas, 0)
764:                 .Velocidade   = NVL(crSigCdPam.BalVelocs, 0)
765:                 .TipoParidade = NVL(crSigCdPam.BalTppars, 0)
766:                 .Bits         = NVL(crSigCdPam.BalBits,   0)
767:                 .Paridade     = NVL(crSigCdPam.BalParids, 0)
768:                 IF NVL(crSigCdPam.BalPortas, 0) = 0
769:                     .Leitura = "T"
770:                 ENDIF
771:                 .Visible      = .T.
772:             ENDWITH
773:             THIS.this_lTemBalanca = .T.
774:             ENDIF && FILE(loc_cVcx)
775:             ENDIF && USED("crSigCdPam")
776:         CATCH TO loc_oErro
777:             *-- Balanca nao disponivel - pesagem manual
778:         ENDTRY
779:     ENDPROC
780: 
781:     *==========================================================================
782:     * InicializarPesoFixs - Calcula PesoFixs para cada peca em xPesa
783:     * a partir dos pesos fixos acumulados em xNensi (Rateio=3, !Visivel)
784:     * Replica logica de Select/Index/Scan no Init do legado
785:     *==========================================================================
786:     PROTECTED PROCEDURE InicializarPesoFixs()
787:         LOCAL loc_oErro, loc_lPesMatPs
788:         loc_lPesMatPs = .F.
789:         TRY
790:             IF USED("xPesa") AND USED("xNensI") AND USED("crSigCdOpd")
791:             SELECT crSigCdOpd
792:             GO TOP
793:             loc_lPesMatPs = (NVL(crSigCdOpd.pesMatPs, 0) <> 0)
794:             IF loc_lPesMatPs
795: 
796:             *-- Total de pecas por envelope
797:             IF USED("tPesa_4c")
798:                 USE IN tPesa_4c
799:             ENDIF
800:             SELECT Nenvs, SUM(Qtds) AS Qtds ;
801:               FROM xPesa ;
802:              GROUP BY Nenvs ;
803:               INTO CURSOR tPesa_4c
804: 
805:             *-- Peso fixo (Rateio=3, !Visivel) por envelope
806:             IF USED("xRateio_4c")
807:                 USE IN xRateio_4c
808:             ENDIF
809:             SELECT a.Nenvs, SUM(a.Pesos) AS Pesos, b.Qtds ;
810:               FROM xNensI a, tPesa_4c b ;
811:              WHERE !IIF(VARTYPE(a.Visivel)="L", a.Visivel, NVL(a.Visivel,0)=1) ;
812:                AND NVL(a.Rateio, 0) = 3 ;
813:                AND a.Nenvs = b.Nenvs ;
814:              GROUP BY a.Nenvs, b.Qtds ;
815:               INTO CURSOR xRateio_4c
816: 
817:             IF RECCOUNT("xRateio_4c") > 0
818:                 SELECT xRateio_4c
819:                 INDEX ON NVL(Nenvs, 0) TAG Nenvs
820: 
821:                 SELECT xPesa
822:                 SCAN
823:                     LOCAL loc_nNenv, loc_nQtds, loc_nPesoFixs
824:                     loc_nNenv    = NVL(xPesa.Nenvs, 0)
825:                     loc_nQtds    = NVL(xPesa.Qtds, 0)
826:                     loc_nPesoFixs = 0

*-- Linhas 848 a 891:
848:     ENDPROC
849: 
850:     *--------------------------------------------------------------------------
851:     * HANDLERS DE GRID - Eventos do Grid grd_4c_Itens (PUBLIC para BINDEVENT)
852:     *--------------------------------------------------------------------------
853: 
854:     *==========================================================================
855:     * GradeCol1TextWhen - Produto (sempre ReadOnly)
856:     *==========================================================================
857:     FUNCTION GradeCol1TextWhen()
858:         RETURN .F.
859:     ENDFUNC
860: 
861:     *==========================================================================
862:     * GradeCol2TextWhen - Observacao: editavel apenas com LibObss=1 e modo INSERIR
863:     *==========================================================================
864:     FUNCTION GradeCol2TextWhen()
865:         LOCAL loc_lLibObss, loc_lModoInserir
866:         loc_lLibObss = .F.
867:         loc_lModoInserir = .F.
868:         IF USED("crSigCdPam")
869:             SELECT crSigCdPam
870:             GO TOP
871:             IF VARTYPE(crSigCdPam.LibObss) = "L"
872:                 loc_lLibObss = crSigCdPam.LibObss
873:             ELSE
874:                 IF VARTYPE(crSigCdPam.LibObss) = "L"
875:                     loc_lLibObss = crSigCdPam.LibObss
876:                 ELSE
877:                     IF VARTYPE(crSigCdPam.LibObss) = "L"
878:                         loc_lLibObss = crSigCdPam.LibObss
879:                     ELSE
880:                         loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
881:                     ENDIF
882:                 ENDIF
883:             ENDIF
884:         ENDIF
885:         IF VARTYPE(THIS.this_oPaiForm) = "O"
886:             loc_lModoInserir = (ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR")
887:         ENDIF
888:         RETURN loc_lLibObss AND loc_lModoInserir
889:     ENDFUNC
890: 
891:     *==========================================================================

*-- Linhas 925 a 983:
925:     ENDFUNC
926: 
927:     *==========================================================================
928:     * AbrirLookupTamanho - Abre FormBuscaAuxiliar em SigCdTam
929:     *==========================================================================
930:     FUNCTION AbrirLookupTamanho()
931:         LOCAL loc_cValor, loc_oBusca, loc_oErro
932:         TRY
933:             loc_cValor = ""
934:             IF VARTYPE(THIS.grd_4c_Itens) = "O" AND ;
935:                VARTYPE(THIS.grd_4c_Itens.Column4) = "O" AND ;
936:                VARTYPE(THIS.grd_4c_Itens.Column4.Text1) = "O"
937:                 loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column4.Text1.Value, ""))
938:             ENDIF
939:             IF EMPTY(loc_cValor) AND USED("xPesa")
940:                 SELECT xPesa
941:                 loc_cValor = ALLTRIM(NVL(Tams, ""))
942:             ENDIF
943:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
944:                 "SigCdTam", "cursor_4c_TamBusca", "Cods", loc_cValor, ;
945:                 "Sele" + CHR(231) + CHR(227) + "o de Tamanho", .T.)
946:             IF VARTYPE(loc_oBusca) = "O"
947:                 IF !loc_oBusca.this_lAchouRegistro
948:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
949:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
950:                     loc_oBusca.Show()
951:                 ENDIF
952:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TamBusca")
953:                     IF USED("xPesa")
954:                         SELECT xPesa
955:                         REPLACE Tams WITH ALLTRIM(cursor_4c_TamBusca.Cods)
956:                     ENDIF
957:                 ENDIF
958:                 loc_oBusca.Release()
959:             ENDIF
960:             IF USED("cursor_4c_TamBusca")
961:                 USE IN cursor_4c_TamBusca
962:             ENDIF
963:         CATCH TO loc_oErro
964:             MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
965:         ENDTRY
966:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
967:             THIS.grd_4c_Itens.Refresh()
968:         ENDIF
969:     ENDFUNC
970: 
971:     *==========================================================================
972:     * GradeCol5TextWhen - Quantidade: editavel apenas se LibObss <> 1
973:     *==========================================================================
974:     FUNCTION GradeCol5TextWhen()
975:         IF USED("crSigCdPam")
976:             SELECT crSigCdPam
977:             GO TOP
978:             RETURN NVL(crSigCdPam.LibObss, 0) <> 1
979:         ENDIF
980:         RETURN .F.
981:     ENDFUNC
982: 
983:     *==========================================================================

*-- Linhas 1077 a 1189:
1077:             IF loc_nValorAtual <> 0 AND loc_nValorAtual <> THIS.this_nOldValue
1078:                 *-- Valor negativo: nao permitido
1079:                 IF loc_nValorAtual < 0
1080:                     MsgAviso("O Peso N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
1081:                     IF USED("xPesa")
1082:                         SELECT xPesa
1083:                         REPLACE Peso WITH THIS.this_nOldValue
1084:                     ENDIF
1085:                     loc_lValido = .F.
1086:                 ELSE
1087:                     THIS.this_lAlterou = .T.
1088: 
1089:             *-- Verifica tolerancia de diferenca de peso
1090:             IF !THIS.this_oBusinessObject.VerificarDiferencaPeso(loc_nValorAtual)
1091:                 *-- Fora do limite - calcula valores para mensagem
1092:                 loc_nPesagem  = 0
1093:                 loc_nDifPesags = 0
1094:                 IF USED("crSigCdPam")
1095:                     SELECT crSigCdPam
1096:                     GO TOP
1097:                     loc_nDifPesags = NVL(crSigCdPam.DifPesags, 0)
1098:                 ENDIF
1099:                 IF loc_nQtds <> 0
1100:                     loc_nPesagem = (loc_nValorAtual / loc_nQtds) - loc_nPesoFixs
1101:                 ENDIF
1102: 
1103:                 MsgAviso("Peso Diferente do Peso da Tabela e fora do Limite de " + ;
1104:                     TRANSFORM(loc_nDifPesags, "@Z 999.99%") + CHR(13) + ;
1105:                     "Real: " + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z 9999.999")), "")
1106: 
1107:                 IF THIS.this_lLiberaPeso
1108:                     *-- Solicita senha de autorizacao (SigOpSen)
1109:                     LOCAL loc_cRetorno, loc_lOk, loc_cInfo
1110:                     loc_cRetorno = ""
1111:                     loc_cInfo    = "Libera Pesagem R:" + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z999.999"))
1112:                     DO FORM SigOpSen WITH "LIBPESO", loc_cInfo, "" TO loc_cRetorno
1113:                     CLEAR TYPEAHEAD
1114:                     loc_lOk = (LEFT(ALLTRIM(loc_cRetorno), 1) = "*")
1115:                     IF !loc_lOk
1116:                         MsgAviso("Pesagem n" + CHR(227) + "o autorizada!!!", "")
1117:                         IF USED("xPesa")
1118:                             SELECT xPesa
1119:                             REPLACE Peso WITH 0
1120:                         ENDIF
1121:                         loc_lValido = .F.
1122:                     ELSE
1123:                         IF USED("xPesa")
1124:                             SELECT xPesa
1125:                             REPLACE UsuLibs WITH PADR(SUBSTR(loc_cRetorno, 2), 10)
1126:                         ENDIF
1127:                     ENDIF
1128:                 ELSE
1129:                     IF USED("xPesa")
1130:                         SELECT xPesa
1131:                         REPLACE Peso WITH THIS.this_nOldValue
1132:                     ENDIF
1133:                     loc_lValido = .F.
1134:                 ENDIF
1135:             ENDIF && !VerificarDiferencaPeso
1136:                 ENDIF && loc_nValorAtual >= 0
1137:             ENDIF && loc_nValorAtual <> 0
1138:         CATCH TO loc_oErro
1139:             MsgErro(loc_oErro.Message, "Erro na valida" + CHR(231) + CHR(227) + "o do peso")
1140:             loc_lValido = .T.
1141:         ENDTRY
1142:         RETURN loc_lValido
1143:     ENDFUNC
1144: 
1145:     *==========================================================================
1146:     * GradeCol6TextLostFocus - Apos saida do campo Peso: rateio, custo, especial
1147:     * Replica Column6.Text1.LostFocus do legado
1148:     *==========================================================================
1149:     PROCEDURE GradeCol6TextLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1150:         LOCAL loc_nValorAtual, loc_nRecno, loc_nNenv, loc_oErro
1151:         LOCAL loc_lEspecial, loc_nNops, loc_cCpros, loc_nCusto
1152:         TRY
1153:             IF USED("xPesa")
1154:                 SELECT xPesa
1155:                 loc_nValorAtual = NVL(Peso, 0)
1156:             ENDIF
1157:             IF loc_nValorAtual <> 0 AND THIS.this_lAlterou
1158:                 SELECT xPesa
1159:                 loc_nRecno    = RECNO()
1160:                 loc_nNenv     = NVL(Nenvs, 0)
1161:                 loc_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
1162:                 loc_nNops     = NVL(Nops, 0)
1163:                 loc_cCpros    = ALLTRIM(NVL(Cpros, ""))
1164: 
1165:             *-- Distribui rateio de peso entre materiais do envelope
1166:             THIS.this_oBusinessObject.DistribuirRateio(loc_nRecno)
1167: 
1168:             *-- Calcula custo de producao e atualiza xPesa.CustoFs
1169:             loc_nCusto = THIS.this_oBusinessObject.CalcularCustoProducao(loc_nNops, loc_cCpros)
1170:             IF USED("xPesa")
1171:                 SELECT xPesa
1172:                 IF loc_nRecno > 0
1173:                     GO loc_nRecno
1174:                 ENDIF
1175:                 REPLACE CustoFs WITH loc_nCusto
1176:             ENDIF
1177: 
1178:             *-- Peca especial: processa composicao SigPrCpo
1179:             IF loc_lEspecial
1180:                 THIS.ProcessarPesoEspecial(loc_nNenv, loc_nNops, loc_cCpros, loc_nRecno)
1181:             ENDIF
1182: 
1183:             *-- Navegacao: avanca para proxima peca
1184:             IF USED("xPesa")
1185:                 SELECT xPesa
1186:                 IF loc_nRecno > 0
1187:                     GO loc_nRecno
1188:                 ENDIF
1189:                 SKIP

*-- Linhas 1237 a 1340:
1237:     ENDFUNC
1238: 
1239:     *==========================================================================
1240:     * AbrirLookupCor - Abre FormBuscaAuxiliar em SigCdCor
1241:     *==========================================================================
1242:     FUNCTION AbrirLookupCor()
1243:         LOCAL loc_cValor, loc_oBusca, loc_oErro
1244:         TRY
1245:             loc_cValor = ""
1246:             IF VARTYPE(THIS.grd_4c_Itens) = "O" AND ;
1247:                VARTYPE(THIS.grd_4c_Itens.Column7) = "O" AND ;
1248:                VARTYPE(THIS.grd_4c_Itens.Column7.Text1) = "O"
1249:                 loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column7.Text1.Value, ""))
1250:             ENDIF
1251:             IF EMPTY(loc_cValor) AND USED("xPesa")
1252:                 SELECT xPesa
1253:                 loc_cValor = ALLTRIM(NVL(Cors, ""))
1254:             ENDIF
1255:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1256:                 "SigCdCor", "cursor_4c_CorBusca", "Cods", loc_cValor, ;
1257:                 "Sele" + CHR(231) + CHR(227) + "o de Cor", .T.)
1258:             IF VARTYPE(loc_oBusca) = "O"
1259:                 IF !loc_oBusca.this_lAchouRegistro
1260:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1261:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1262:                     loc_oBusca.Show()
1263:                 ENDIF
1264:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CorBusca")
1265:                     IF USED("xPesa")
1266:                         SELECT xPesa
1267:                         REPLACE Cors WITH ALLTRIM(cursor_4c_CorBusca.Cods)
1268:                     ENDIF
1269:                 ENDIF
1270:                 loc_oBusca.Release()
1271:             ENDIF
1272:             IF USED("cursor_4c_CorBusca")
1273:                 USE IN cursor_4c_CorBusca
1274:             ENDIF
1275:         CATCH TO loc_oErro
1276:             MsgErro(loc_oErro.Message, "Erro ao buscar cor")
1277:         ENDTRY
1278:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
1279:             THIS.grd_4c_Itens.Refresh()
1280:         ENDIF
1281:     ENDFUNC
1282: 
1283:     *==========================================================================
1284:     * GradeCol8TextWhen - Barras (ReadOnly)
1285:     *==========================================================================
1286:     FUNCTION GradeCol8TextWhen()
1287:         RETURN .F.
1288:     ENDFUNC
1289: 
1290:     *==========================================================================
1291:     * GradeCol9TextWhen - Custo (ReadOnly)
1292:     *==========================================================================
1293:     FUNCTION GradeCol9TextWhen()
1294:         RETURN .F.
1295:     ENDFUNC
1296: 
1297:     *==========================================================================
1298:     * GradeCol9TextDblClick - Custo: abre SigCdPro se tiver permissao CUSTOP
1299:     *==========================================================================
1300:     PROCEDURE GradeCol9TextDblClick()
1301:         LOCAL loc_nRecno, loc_oErro
1302:         TRY
1303:             IF fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP") AND USED("xPesa")
1304:                 SELECT xPesa
1305:                 loc_nRecno = RECNO()
1306:                 DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
1307:                 SELECT xPesa
1308:                 IF loc_nRecno > 0
1309:                     GO loc_nRecno
1310:                 ENDIF
1311:             ENDIF
1312:         CATCH TO loc_oErro
1313:             MsgErro(loc_oErro.Message, "Erro ao abrir produto")
1314:         ENDTRY
1315:     ENDPROC
1316: 
1317:     *==========================================================================
1318:     * TxtEspecialWhen - Indicador visual de peca especial (ReadOnly decorativo)
1319:     *==========================================================================
1320:     FUNCTION TxtEspecialWhen()
1321:         RETURN .F.
1322:     ENDFUNC
1323: 
1324:     *==========================================================================
1325:     * TxtPesoMedioValid - Distribui peso medio por todas as pecas do cursor xPesa
1326:     * Replica get_pesom.Valid do legado
1327:     *==========================================================================
1328:     FUNCTION TxtPesoMedioValid()
1329:         LOCAL loc_nPesoMedio, loc_oErro
1330:         TRY
1331:             loc_nPesoMedio = NVL(THIS.txt_4c_PesoMedio.Value, 0)
1332:             IF !EMPTY(loc_nPesoMedio) AND loc_nPesoMedio <> 0
1333:                 THIS.this_oBusinessObject.AtualizarPesoMedio(loc_nPesoMedio)
1334:                 IF VARTYPE(THIS.grd_4c_Itens) = "O"
1335:                     THIS.grd_4c_Itens.Refresh()
1336:                 ENDIF
1337:             ENDIF
1338:         CATCH TO loc_oErro
1339:             MsgErro(loc_oErro.Message, "Erro ao distribuir peso m" + CHR(233) + "dio")
1340:         ENDTRY

*-- Linhas 1349 a 1663:
1349:     * BtnIncluirClick - Adiciona nova pe" + CHR(231) + "a na grade de pesagem
1350:     * Form OPERACIONAL: Incluir adiciona linha em xPesa para nova pesagem
1351:     *==========================================================================
1352:     PROCEDURE BtnIncluirClick()
1353:         LOCAL loc_oErro
1354:         TRY
1355:             IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
1356:                !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
1357:                 MsgAviso("Inclus" + CHR(227) + "o de pe" + CHR(231) + "a permitida apenas em modo Inserir/Alterar.", "Aviso")
1358:                 RETURN
1359:             ENDIF
1360:             IF !USED("xPesa")
1361:                 MsgAviso("Cursor de pesagem n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
1362:                 RETURN
1363:             ENDIF
1364:             SELECT xPesa
1365:             APPEND BLANK
1366:             REPLACE Peso WITH 0, Qtds WITH 1
1367:             THIS.this_lAlterou = .T.
1368:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1369:                 THIS.grd_4c_Itens.Refresh()
1370:                 THIS.grd_4c_Itens.SetFocus()
1371:             ENDIF
1372:         CATCH TO loc_oErro
1373:             MsgErro(loc_oErro.Message, "Erro ao incluir pe" + CHR(231) + "a")
1374:         ENDTRY
1375:     ENDPROC
1376: 
1377:     *==========================================================================
1378:     * BtnAlterarClick - Foca grade na pe" + CHR(231) + "a corrente para editar peso
1379:     * Form OPERACIONAL: Alterar = editar peso da pe" + CHR(231) + "a corrente
1380:     *==========================================================================
1381:     PROCEDURE BtnAlterarClick()
1382:         LOCAL loc_oErro
1383:         TRY
1384:             IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
1385:                !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
1386:                 MsgAviso("Altera" + CHR(231) + CHR(227) + "o permitida apenas em modo Inserir/Alterar.", "Aviso")
1387:                 RETURN
1388:             ENDIF
1389:             IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
1390:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "as para alterar.", "Aviso")
1391:                 RETURN
1392:             ENDIF
1393:             SELECT xPesa
1394:             IF EOF() OR BOF()
1395:                 GO TOP
1396:             ENDIF
1397:             THIS.this_lAlterou = .T.
1398:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1399:                 THIS.grd_4c_Itens.SetFocus()
1400:                 IF PEMSTATUS(THIS.grd_4c_Itens, "Column6", 5)
1401:                     THIS.grd_4c_Itens.Column6.SetFocus()
1402:                 ENDIF
1403:             ENDIF
1404:         CATCH TO loc_oErro
1405:             MsgErro(loc_oErro.Message, "Erro ao alterar pe" + CHR(231) + "a")
1406:         ENDTRY
1407:     ENDPROC
1408: 
1409:     *==========================================================================
1410:     * BtnVisualizarClick - Exibe custo/composi" + CHR(231) + CHR(227) + "o da pe" + CHR(231) + "a corrente
1411:     * Form OPERACIONAL: Visualizar abre SigCdPro com produto corrente
1412:     *==========================================================================
1413:     PROCEDURE BtnVisualizarClick()
1414:         LOCAL loc_oErro, loc_nRecno, loc_cCpros
1415:         TRY
1416:             IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
1417:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "a para visualizar.", "Aviso")
1418:                 RETURN
1419:             ENDIF
1420:             IF !fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
1421:                 MsgAviso("Sem permiss" + CHR(227) + "o para visualizar custo.", "Aviso")
1422:                 RETURN
1423:             ENDIF
1424:             SELECT xPesa
1425:             loc_nRecno = RECNO()
1426:             loc_cCpros = ALLTRIM(NVL(Cpros, ""))
1427:             IF EMPTY(loc_cCpros)
1428:                 MsgAviso("Pe" + CHR(231) + "a sem produto associado.", "Aviso")
1429:                 RETURN
1430:             ENDIF
1431:             DO FORM SigCdPro WITH "PESAGEM", loc_cCpros
1432:             SELECT xPesa
1433:             IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
1434:                 GO loc_nRecno
1435:             ENDIF
1436:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1437:                 THIS.grd_4c_Itens.Refresh()
1438:             ENDIF
1439:         CATCH TO loc_oErro
1440:             MsgErro(loc_oErro.Message, "Erro ao visualizar pe" + CHR(231) + "a")
1441:         ENDTRY
1442:     ENDPROC
1443: 
1444:     *==========================================================================
1445:     * BtnExcluirClick - Zera peso da pe" + CHR(231) + "a corrente (desfaz pesagem)
1446:     * Form OPERACIONAL: Excluir zera Peso e PesoFixs da linha corrente
1447:     *==========================================================================
1448:     PROCEDURE BtnExcluirClick()
1449:         LOCAL loc_oErro, loc_lConfirma
1450:         TRY
1451:             IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
1452:                !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
1453:                 MsgAviso("Exclus" + CHR(227) + "o permitida apenas em modo Inserir/Alterar.", "Aviso")
1454:                 RETURN
1455:             ENDIF
1456:             IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
1457:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "a para excluir.", "Aviso")
1458:                 RETURN
1459:             ENDIF
1460:             SELECT xPesa
1461:             IF EOF() OR BOF()
1462:                 GO TOP
1463:             ENDIF
1464:             loc_lConfirma = MsgConfirma("Confirma desfazer a pesagem desta pe" + CHR(231) + "a?", "Confirma" + CHR(231) + CHR(227) + "o")
1465:             IF !loc_lConfirma
1466:                 RETURN
1467:             ENDIF
1468:             SELECT xPesa
1469:             REPLACE Peso WITH 0
1470:             IF TYPE("xPesa.PesoFixs") <> "U"
1471:                 REPLACE PesoFixs WITH 0
1472:             ENDIF
1473:             THIS.this_lAlterou = .T.
1474:             THIS.this_nOldValue = 0
1475:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1476:                 THIS.grd_4c_Itens.Refresh()
1477:                 THIS.grd_4c_Itens.SetFocus()
1478:             ENDIF
1479:         CATCH TO loc_oErro
1480:             MsgErro(loc_oErro.Message, "Erro ao excluir pesagem")
1481:         ENDTRY
1482:     ENDPROC
1483: 
1484:     *==========================================================================
1485:     * BtnResumoClick - Abre form de resumo SigPdM10 com referencia ao form pai
1486:     *==========================================================================
1487:     PROCEDURE BtnResumoClick()
1488:         DO FORM SigPdM10 WITH THIS.this_oPaiForm
1489:     ENDPROC
1490: 
1491:     *==========================================================================
1492:     * BtnCustoPClick - Abre SigCdPro no modo PESAGEM para a peca selecionada
1493:     *==========================================================================
1494:     PROCEDURE BtnCustoPClick()
1495:         LOCAL loc_nRecno, loc_oErro
1496:         TRY
1497:             IF fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP") AND ;
1498:                VARTYPE(THIS.this_oPaiForm) = "O" AND ;
1499:                INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
1500:                 IF USED("xPesa")
1501:                     SELECT xPesa
1502:                     loc_nRecno = RECNO()
1503:                     DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
1504:                     SELECT xPesa
1505:                     IF loc_nRecno > 0
1506:                         LOCATE FOR RECNO() = loc_nRecno
1507:                     ENDIF
1508:                 ENDIF
1509:             ENDIF
1510:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1511:                 THIS.grd_4c_Itens.SetFocus()
1512:             ENDIF
1513:         CATCH TO loc_oErro
1514:             MsgErro(loc_oErro.Message, "Erro ao abrir custo de produto")
1515:         ENDTRY
1516:     ENDPROC
1517: 
1518:     *==========================================================================
1519:     * BtnProcessarClick - Valida que todas as pecas foram pesadas e encerra
1520:     * Replica Processar.Click do legado
1521:     *==========================================================================
1522:     PROCEDURE BtnProcessarClick()
1523:         LOCAL loc_oErro, loc_lPodeProsseguir
1524:         loc_lPodeProsseguir = .T.
1525:         TRY
1526:             *-- Valida pesagem completa apenas no modo INSERIR
1527:             IF VARTYPE(THIS.this_oPaiForm) = "O" AND ;
1528:                ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR"
1529:                 IF USED("xPesa")
1530:                     SELECT xPesa
1531:                     SCAN
1532:                         IF NVL(Peso, 0) = 0
1533:                             MsgAviso("Existe Uma Pe" + CHR(231) + "a Que N" + CHR(227) + ;
1534:                                      "o Foi Pesada!!!", "")
1535:                             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1536:                                 THIS.grd_4c_Itens.Refresh()
1537:                             ENDIF
1538:                             loc_lPodeProsseguir = .F.
1539:                             EXIT
1540:                         ENDIF
1541:                     ENDSCAN
1542:                 ENDIF
1543:             ENDIF
1544: 
1545:             IF loc_lPodeProsseguir AND USED("xNensiS") AND RECCOUNT("xNensiS") > 0
1546:                 DO FORM SigPdM11 WITH THIS.this_oPaiForm, THIS.DataSessionId
1547:             ENDIF
1548: 
1549:             *-- Habilita form pai e fecha
1550:             IF loc_lPodeProsseguir
1551:                 IF VARTYPE(THIS.this_oPaiForm) = "O"
1552:                     THIS.this_oPaiForm.Enabled = .T.
1553:                 ENDIF
1554:                 THIS.Release()
1555:             ENDIF
1556:         CATCH TO loc_oErro
1557:             MsgErro(loc_oErro.Message, "Erro ao processar pesagem")
1558:         ENDTRY
1559:     ENDPROC
1560: 
1561:     *==========================================================================
1562:     * BtnCancelarClick - Cancela pesagem e fecha o form
1563:     *==========================================================================
1564:     PROCEDURE BtnCancelarClick()
1565:         IF VARTYPE(THIS.this_oPaiForm) = "O"
1566:             THIS.this_oPaiForm.Enabled = .T.
1567:         ENDIF
1568:         THIS.Release()
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1573:     * OPERACIONAL: nao ha containers flutuantes a excluir neste form
1574:     *==========================================================================
1575:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1576:         LOCAL loc_nI, loc_oObjeto
1577:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1578:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1579:             IF VARTYPE(loc_oObjeto) = "O"
1580:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1581:                     loc_oObjeto.Visible = .T.
1582:                 ENDIF
1583:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1584:                     LOCAL loc_nP
1585:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1586:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1587:                     ENDFOR
1588:                 ENDIF
1589:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1590:                     IF loc_oObjeto.ControlCount > 0
1591:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1592:                     ENDIF
1593:                 ENDIF
1594:             ENDIF
1595:         ENDFOR
1596:     ENDPROC
1597: 
1598:     *==========================================================================
1599:     * AlternarPagina - Sem alternancia de paginas em form OPERACIONAL
1600:     * Reposiciona cursor xPesa e atualiza grid
1601:     *==========================================================================
1602:     PROCEDURE AlternarPagina(par_nPagina)
1603:         LOCAL loc_oErro
1604:         TRY
1605:             IF USED("xPesa")
1606:                 SELECT xPesa
1607:                 GO TOP
1608:             ENDIF
1609:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1610:                 THIS.grd_4c_Itens.Refresh()
1611:             ENDIF
1612:         CATCH TO loc_oErro
1613:             MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
1614:         ENDTRY
1615:     ENDPROC
1616: 
1617:     *==========================================================================
1618:     * ProcessarPesoEspecial - Logica de composicao para peca especial
1619:     * Constroi CrTmpCompo a partir de CrSigCdNei + servicos externos
1620:     * Grava SigPrCpo e abre SigCdPro para revisao
1621:     * Replica logica da secao IF xpesa.Especial de Column6.Text1.LostFocus
1622:     *==========================================================================
1623:     PROTECTED PROCEDURE ProcessarPesoEspecial(par_nNenv, par_nNops, par_cCpros, par_nRecno)
1624:         LOCAL loc_oErro, loc_cSQL, loc_nRet, loc_lSucesso
1625:         LOCAL loc_nMtPrimas, loc_lTemOpEopp
1626:         LOCAL loc_cCMats, loc_nPeso2, loc_nQtds
1627:         LOCAL loc_cDpros, loc_cCunis, loc_cCuniPs, loc_cCgrus2, loc_nCustoFs, loc_cMoeCusFs, loc_cEtiPads
1628:         LOCAL loc_cSvcCpros, loc_nSvcQtds, loc_cSvcEtiPads
1629:         LOCAL loc_cSvcDpros, loc_cSvcCunis, loc_cSvcCuniPs, loc_cSvcCgrus, loc_nSvcCustoFs, loc_cSvcMoeCusFs
1630:         loc_lSucesso = .F.
1631:         TRY
1632:             *-- 1. Tipo de materia prima do grupo do produto (MtPrimas)
1633:             loc_cSQL = "SELECT b.mtprimas FROM SigCdPro a " + ;
1634:                        "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
1635:                        "WHERE a.Cpros = " + EscaparSQL(par_cCpros)
1636:             IF USED("cursor_4c_EspGruTip")
1637:                 USE IN cursor_4c_EspGruTip
1638:             ENDIF
1639:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspGruTip")
1640:             loc_nMtPrimas = 0
1641:             IF loc_nRet >= 1
1642:                 SELECT cursor_4c_EspGruTip
1643:                 GO TOP
1644:                 loc_nMtPrimas = NVL(MtPrimas, 0)
1645:                 USE IN cursor_4c_EspGruTip
1646:             ENDIF
1647: 
1648:             *-- 2. Carrega composicao atual do SQL Server em CrTmpCompo
1649:             loc_cSQL = "SELECT * FROM SigPrCpo WHERE Cpros = " + EscaparSQL(par_cCpros)
1650:             IF USED("CrTmpCompo")
1651:                 USE IN CrTmpCompo
1652:             ENDIF
1653:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpCompo")
1654:             IF loc_nRet >= 1
1655:             *-- Indexa por Mats e reseta TpAlts
1656:             SELECT CrTmpCompo
1657:             INDEX ON ALLTRIM(NVL(Mats, "")) TAG Mats
1658:             REPLACE ALL TpAlts WITH 0
1659: 
1660:             *-- 3. Servicos do cadastro (SigCdSvc)
1661:             loc_cSQL = "SELECT Mats, cCats FROM SigCdSvc WHERE Mats <> ' '"
1662:             IF USED("CsTmpSer")
1663:                 USE IN CsTmpSer

*-- Linhas 1968 a 2155:
1968:     * Form OPERACIONAL: xPesa ja vem pre-carregado do form pai.
1969:     * Este metodo apenas reposiciona e rebind o RecordSource quando necessario.
1970:     *==========================================================================
1971:     PROCEDURE CarregarLista()
1972:         LOCAL loc_oErro
1973:         TRY
1974:             IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
1975:                 SELECT xPesa
1976:                 GO TOP
1977:                 WITH THIS.grd_4c_Itens
1978:                     .RecordSource = "xPesa"
1979:                     .Column1.Header1.Caption = "Produto"
1980:                     .Column2.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
1981:                     .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1982:                     .Column4.Header1.Caption = "Tam"
1983:                     .Column5.Header1.Caption = "Quantidade"
1984:                     .Column6.Header1.Caption = "Peso"
1985:                     .Column7.Header1.Caption = "Cor"
1986:                     .Column8.Header1.Caption = "Barras"
1987:                     .Column9.Header1.Caption = "Custo"
1988:                     .Refresh()
1989:                 ENDWITH
1990:             ENDIF
1991:         CATCH TO loc_oErro
1992:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de pe" + CHR(231) + "as")
1993:         ENDTRY
1994:     ENDPROC
1995: 
1996:     *==========================================================================
1997:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo do form pai
1998:     * INSERIR/ALTERAR: Processar habilitado, grid editavel
1999:     * VISUALIZAR: apenas Resumo, CustoP e Cancelar habilitados
2000:     *==========================================================================
2001:     PROCEDURE AjustarBotoesPorModo()
2002:         LOCAL loc_cModo, loc_lEdicao, loc_lAcesso
2003:         loc_cModo   = ""
2004:         loc_lEdicao = .F.
2005:         loc_lAcesso = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
2006:         IF VARTYPE(THIS.this_oPaiForm) = "O"
2007:             loc_cModo   = ALLTRIM(NVL(THIS.this_oPaiForm.pcEscolha, ""))
2008:             loc_lEdicao = INLIST(loc_cModo, "INSERIR", "ALTERAR")
2009:         ENDIF
2010:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
2011:             THIS.cmd_4c_Processar.Enabled = loc_lEdicao
2012:         ENDIF
2013:         IF VARTYPE(THIS.cmd_4c_CustoP) = "O"
2014:             THIS.cmd_4c_CustoP.Visible  = loc_lAcesso
2015:             THIS.cmd_4c_CustoP.Enabled  = loc_lAcesso AND loc_lEdicao
2016:         ENDIF
2017:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2018:             THIS.txt_4c_PesoMedio.ReadOnly = !loc_lEdicao
2019:         ENDIF
2020:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
2021:             THIS.grd_4c_Itens.ReadOnly = !loc_lEdicao
2022:         ENDIF
2023:     ENDPROC
2024: 
2025:     *==========================================================================
2026:     * FormParaBO - Transfere valores do form para o Business Object
2027:     * Form OPERACIONAL: o principal e o cursor xPesa (gerenciado diretamente).
2028:     * Aqui transferimos apenas estado auxiliar (peso medio, prog acesso).
2029:     *==========================================================================
2030:     PROTECTED PROCEDURE FormParaBO()
2031:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
2032:             RETURN
2033:         ENDIF
2034:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2035:             THIS.this_oBusinessObject.this_nPesoMedio = NVL(THIS.txt_4c_PesoMedio.Value, 0)
2036:         ENDIF
2037:         THIS.this_oBusinessObject.this_cProgAcesso    = THIS.this_cProgAcesso
2038:         THIS.this_oBusinessObject.this_lAlterou       = THIS.this_lAlterou
2039:         THIS.this_oBusinessObject.this_nOldValue      = THIS.this_nOldValue
2040:         THIS.this_oBusinessObject.this_lLiberaPeso    = THIS.this_lLiberaPeso
2041:         IF USED("xPesa")
2042:             SELECT xPesa
2043:             THIS.this_oBusinessObject.this_cCpros   = ALLTRIM(NVL(Cpros,    ""))
2044:             THIS.this_oBusinessObject.this_cObs     = ALLTRIM(NVL(Obs,      ""))
2045:             THIS.this_oBusinessObject.this_cOper    = ALLTRIM(NVL(Oper,     ""))
2046:             THIS.this_oBusinessObject.this_nQtds    = NVL(Qtds,    0)
2047:             THIS.this_oBusinessObject.this_nPeso    = NVL(Peso,    0)
2048:             THIS.this_oBusinessObject.this_cTams    = ALLTRIM(NVL(Tams,     ""))
2049:             THIS.this_oBusinessObject.this_cCors    = ALLTRIM(NVL(Cors,     ""))
2050:             THIS.this_oBusinessObject.this_cCbars   = ALLTRIM(NVL(Cbars,    ""))
2051:             THIS.this_oBusinessObject.this_nCustoFs = NVL(CustoFs, 0)
2052:             THIS.this_oBusinessObject.this_nNops    = NVL(Nops,    0)
2053:             THIS.this_oBusinessObject.this_nNenvs   = NVL(Nenvs,   0)
2054:             THIS.this_oBusinessObject.this_nPesoFixs = NVL(PesoFixs, 0)
2055:             THIS.this_oBusinessObject.this_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
2056:         ENDIF
2057:     ENDPROC
2058: 
2059:     *==========================================================================
2060:     * BOParaForm - Transfere valores do Business Object para o form
2061:     * Form OPERACIONAL: restaura peso medio e atualiza grid
2062:     *==========================================================================
2063:     PROTECTED PROCEDURE BOParaForm()
2064:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
2065:             RETURN
2066:         ENDIF
2067:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2068:             THIS.txt_4c_PesoMedio.Value = NVL(THIS.this_oBusinessObject.this_nPesoMedio, 0)
2069:         ENDIF
2070:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
2071:             THIS.grd_4c_Itens.Refresh()
2072:         ENDIF
2073:     ENDPROC
2074: 
2075:     *==========================================================================
2076:     * HabilitarCampos - Habilita ou desabilita edicao conforme par_lHabilitar
2077:     * Form OPERACIONAL: controla grid e campo de peso medio
2078:     *==========================================================================
2079:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2080:         LOCAL loc_lLibObss
2081:         loc_lLibObss = .F.
2082:         IF USED("crSigCdPam")
2083:             SELECT crSigCdPam
2084:             GO TOP
2085:             IF VARTYPE(crSigCdPam.LibObss) = "L"
2086:                 loc_lLibObss = crSigCdPam.LibObss
2087:             ELSE
2088:                 IF VARTYPE(crSigCdPam.LibObss) = "L"
2089:                     loc_lLibObss = crSigCdPam.LibObss
2090:                 ELSE
2091:                     IF VARTYPE(crSigCdPam.LibObss) = "L"
2092:                         loc_lLibObss = crSigCdPam.LibObss
2093:                     ELSE
2094:                         loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
2095:                     ENDIF
2096:                 ENDIF
2097:             ENDIF
2098:         ENDIF
2099:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2100:             THIS.txt_4c_PesoMedio.ReadOnly = !par_lHabilitar
2101:         ENDIF
2102:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
2103:             IF !par_lHabilitar
2104:                 THIS.grd_4c_Itens.ReadOnly = .T.
2105:             ELSE
2106:                 THIS.grd_4c_Itens.ReadOnly = .F.
2107:                 THIS.grd_4c_Itens.Column4.ReadOnly = !loc_lLibObss
2108:                 THIS.grd_4c_Itens.Column6.ReadOnly = .F.
2109:                 THIS.grd_4c_Itens.Column7.ReadOnly = !loc_lLibObss
2110:             ENDIF
2111:         ENDIF
2112:     ENDPROC
2113: 
2114:     *==========================================================================
2115:     * LimparCampos - Zera campos de entrada do form
2116:     * Form OPERACIONAL: zera peso medio e reposiciona grid no inicio
2117:     *==========================================================================
2118:     PROTECTED PROCEDURE LimparCampos()
2119:         THIS.this_lAlterou  = .F.
2120:         THIS.this_nOldValue = 0
2121:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2122:             THIS.txt_4c_PesoMedio.Value = 0
2123:         ENDIF
2124:         IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
2125:             SELECT xPesa
2126:             GO TOP
2127:             THIS.grd_4c_Itens.Refresh()
2128:         ENDIF
2129:     ENDPROC
2130: 
2131:     *==========================================================================
2132:     * BtnSalvarClick - Equivalente a BtnProcessarClick para forms OPERACIONAIS
2133:     * Confirma a pesagem e encerra o form (chamado pelo FormBase se necessario)
2134:     *==========================================================================
2135:     PROCEDURE BtnSalvarClick()
2136:         THIS.BtnProcessarClick()
2137:     ENDPROC
2138: 
2139:     *==========================================================================
2140:     * BtnBuscarClick - Recarrega/reposiciona o grid com os dados do cursor xPesa
2141:     * Form OPERACIONAL: sem busca por codigo; apenas refresh da lista de pecas
2142:     *==========================================================================
2143:     PROCEDURE BtnBuscarClick()
2144:         THIS.CarregarLista()
2145:     ENDPROC
2146: 
2147:     *==========================================================================
2148:     * BtnEncerrarClick - Equivalente a Cancelar para forms OPERACIONAIS
2149:     * Habilita form pai e fecha sem processar a pesagem
2150:     *==========================================================================
2151:     PROCEDURE BtnEncerrarClick()
2152:         THIS.BtnCancelarClick()
2153:     ENDPROC
2154: 
2155: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdMp9BO.prg):
*------------------------------------------------------------------------------
* SigPdMp9BO.prg - Business Object: Pesagem de Pe" + CHR(231) + "as
* Herda de BusinessBase
* Tabela principal: SigPrCpo (composi" + CHR(231) + CHR(227) + "o especial de pe" + CHR(231) + "as)
* Cursor de trabalho: xPesa (gerenciado pelo form pai SigPdM8/similar)
*------------------------------------------------------------------------------
DEFINE CLASS SigPdMp9BO AS BusinessBase

    *-- Dados da linha atual do cursor xPesa (grid GradeItens)
    this_cCpros      = ""    && Codigo do produto (Column1 - Produto)
    this_cObs        = ""    && Observacao (Column2 - Observa" + CHR(231) + CHR(227) + "o)
    this_cOper       = ""    && Opera" + CHR(231) + CHR(227) + "o/Movimenta" + CHR(231) + CHR(227) + "o (Column3)
    this_nQtds       = 0     && Quantidade (Column5 - Quantidade)
    this_nPeso       = 0     && Peso (Column6 - Peso)
    this_cTams       = ""    && Codigo do tamanho (Column4 - Tam)
    this_cCors       = ""    && Codigo da cor (Column7 - Cor)
    this_cCbars      = ""    && Codigo de barras (Column8 - Barras)
    this_nCustoFs    = 0     && Custo de produ" + CHR(231) + CHR(227) + "o (Column9 - Custo)
    this_lEspecial   = .F.   && Flag pe" + CHR(231) + "a especial (DynamicForeColor vermelho)
    this_nNops       = 0     && N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o
    this_nNenvs      = 0     && N" + CHR(250) + "mero do envelope/pe" + CHR(231) + "a
    this_nPesoFixs   = 0     && Peso fixo da pe" + CHR(231) + "a
    this_cUsuLibs    = ""    && Usu" + CHR(225) + "rio que liberou pesagem fora do limite
    this_cMatPs      = ""    && Material da pe" + CHR(231) + "a (para rateio)
    this_nPeso2s     = 0     && Peso secund" + CHR(225) + "rio da pe" + CHR(231) + "a

    *-- Estado do processo de pesagem
    this_lAlterou    = .F.   && Indica se peso foi alterado na linha atual
    this_lLiberaPeso = .F.   && Indica se usu" + CHR(225) + "rio tem permiss" + CHR(227) + "o para liberar pesagem
    this_nOldValue   = 0     && Valor anterior do peso antes da edi" + CHR(231) + CHR(227) + "o
    this_nPesoMedio  = 0     && Peso m" + CHR(233) + "dio calculado (campo get_pesom)

    *-- C" + CHR(243) + "digo de acesso ao programa para verifica" + CHR(231) + CHR(227) + "o de permiss" + CHR(227) + "o (fChecaAcesso)
    this_cProgAcesso = ""    && Ex: 'P00000001' constru" + CHR(237) + "do a partir de Ndopps

    *-- Data de refer" + CHR(234) + "ncia para cota" + CHR(231) + CHR(245) + "es de moeda (de TmpNens.Datas)
    this_dDataMovimento = {} && Data da movimenta" + CHR(231) + CHR(227) + "o atual

    *-- Propriedades de composi" + CHR(231) + CHR(227) + "o SigPrCpo (para INSERT/UPDATE via ExecutarInsercao/ExecutarAtualizacao)
    this_cIdChaves       = ""   && cidchaves char(20) PRIMARY KEY
    this_cMats           = ""   && mats char(14) - c" + CHR(243) + "digo do material
    this_cCgrus          = ""   && cgrus char(3) - c" + CHR(243) + "digo do grupo
    this_cCats           = ""   && cats char(6) - categoria
    this_cDcompos        = ""   && dcompos char(40) - descri" + CHR(231) + CHR(227) + "o da composi" + CHR(231) + CHR(227) + "o
    this_cDscGrp         = ""   && dscgrp char(20) - descri" + CHR(231) + CHR(227) + "o do grupo
    this_cEtiqs          = ""   && etiqs char(1) - etiqueta
    this_cGrupos         = ""   && grupos char(10) - grupos
    this_cMoeds          = ""   && moeds char(3) - moeda
    this_cObsCompos      = ""   && obscompos char(10) - observa" + CHR(231) + CHR(227) + "o
    this_nOrdems         = 0    && ordems numeric(2,0) - ordem
    this_nPcompos        = 0    && pcompos numeric(11,3) - pre" + CHR(231) + "o
    this_nQtdsCompo      = 0    && qtds numeric(8,3) - quantidade na composi" + CHR(231) + CHR(227) + "o
    this_nQtscons        = 0    && qtscons numeric(8,3) - qtd consumida
    this_cUniCompos      = ""   && unicompos char(3) - unidade
    this_cCompos         = ""   && compos char(10) - composi" + CHR(231) + CHR(227) + "o
    this_nOrdCompos      = 0    && ordcompos numeric(2,0) - ordem composi" + CHR(231) + CHR(227) + "o
    this_nQtdCvs         = 0    && qtdcvs numeric(11,3) - qtd convertida
    this_nVlrCvs         = 0    && vlrcvs numeric(11,2) - valor convertido
    this_dDtMovs         = {}   && dtmovs - data do movimento
    this_cCuniPs         = ""   && cunips char(3) - unidade peso
    this_nMarkCvs        = 0    && markcvs numeric(9,6) - markup convertido
    this_nPesos          = 0    && pesos numeric(8,3) - peso na composi" + CHR(231) + CHR(227) + "o
    this_nTotas          = 0    && totas numeric(11,3) - total
    this_nTpAlts         = 0    && tpalts numeric(1,0) - tipo de altera" + CHR(231) + CHR(227) + "o
    this_nVlrPvs         = 0    && vlrpvs numeric(11,2) - valor venda
    this_nOrdTs          = 0    && ordts numeric(2,0) - ordem t
    this_cTipos          = ""   && tipos char(20) - tipos
    this_cMatriz         = ""   && matriz char(14) - matriz
    this_cObsOfs         = ""   && obsofs char(120) - obs ofertas
    this_nPedraPrincipal = 0    && PedraPrincipal numeric(1,0)

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrCpo"
        THIS.this_cCampoChave = "cIdChaves"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna cIdChaves do registro atual
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor xPesa
    * par_cAliasCursor: alias do cursor (tipicamente "xPesa")
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCpros    = ALLTRIM(NVL(Cpros,    ""))
            THIS.this_cObs      = ALLTRIM(NVL(Obs,      ""))
            THIS.this_cOper     = ALLTRIM(NVL(Oper,     ""))
            THIS.this_nQtds     = NVL(Qtds,     0)
            THIS.this_nPeso     = NVL(Peso,     0)
            THIS.this_cTams     = ALLTRIM(NVL(Tams,    ""))
            THIS.this_cCors     = ALLTRIM(NVL(Cors,    ""))
            THIS.this_cCbars    = ALLTRIM(NVL(Cbars,   ""))
            THIS.this_nCustoFs  = NVL(CustoFs,  0)
            THIS.this_lEspecial = IIF(VARTYPE(Especial) = "L", Especial, NVL(Especial, 0) = 1)
            THIS.this_nNops     = NVL(Nops,     0)
            THIS.this_nNenvs    = NVL(Nenvs,    0)
            THIS.this_nPesoFixs = NVL(PesoFixs, 0)
            THIS.this_cUsuLibs  = ALLTRIM(NVL(UsuLibs, ""))
            THIS.this_cMatPs    = ALLTRIM(NVL(MatPs,   ""))
            THIS.this_nPeso2s   = NVL(Peso2s,   0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados m" + CHR(237) + "nimos antes de gravar SigPrCpo
    *==========================================================================
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            MsgAviso("O c" + CHR(243) + "digo do produto deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cMats)
            MsgAviso("O c" + CHR(243) + "digo do material deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarInsercao - INSERT INTO SigPrCpo com os dados das propriedades do BO
    *==========================================================================
    PROTECTED FUNCTION ExecutarInsercao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                       "cidchaves, cpros, mats, cgrus, cats, dcompos, dscgrp, etiqs, grupos, " + ;
                       "moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, " + ;
                       "ordcompos, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, " + ;
                       "tpalts, vlrpvs, ordts, tipos, matriz, obsofs, datatrans, PedraPrincipal) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves)        + ", " + ;
                       EscaparSQL(THIS.this_cCpros)           + ", " + ;
                       EscaparSQL(THIS.this_cMats)            + ", " + ;
                       EscaparSQL(THIS.this_cCgrus)           + ", " + ;
                       EscaparSQL(THIS.this_cCats)            + ", " + ;
                       EscaparSQL(THIS.this_cDcompos)         + ", " + ;
                       EscaparSQL(THIS.this_cDscGrp)          + ", " + ;
                       EscaparSQL(THIS.this_cEtiqs)           + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)          + ", " + ;
                       EscaparSQL(THIS.this_cMoeds)           + ", " + ;
                       EscaparSQL(THIS.this_cObsCompos)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcompos)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdsCompo)+ ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtscons)  + ", " + ;
                       EscaparSQL(THIS.this_cUniCompos)       + ", " + ;
                       EscaparSQL(THIS.this_cCompos)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdCompos)+ ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdCvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrCvs)   + ", " + ;
                       "GETDATE(), "                          + ;
                       EscaparSQL(THIS.this_cCuniPs)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMarkCvs)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpAlts)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrPvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdTs)    + ", " + ;
                       EscaparSQL(THIS.this_cTipos)           + ", " + ;
                       EscaparSQL(THIS.this_cMatriz)          + ", " + ;
                       EscaparSQL(THIS.this_cObsOfs)          + ", " + ;
                       "GETDATE(), "                          + ;
                       FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao inserir composi" + CHR(231) + CHR(227) + "o em SigPrCpo.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir SigPrCpo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarAtualizacao - UPDATE SigPrCpo WHERE cpros = AND mats =
    *==========================================================================
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCpros) OR EMPTY(THIS.this_cMats)
                MsgErro("Produto ou material n" + CHR(227) + "o informado para UPDATE.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigPrCpo SET " + ;
                       "cgrus = "     + EscaparSQL(THIS.this_cCgrus)            + ", " + ;
                       "cats = "      + EscaparSQL(THIS.this_cCats)             + ", " + ;
                       "dcompos = "   + EscaparSQL(THIS.this_cDcompos)          + ", " + ;
                       "dscgrp = "    + EscaparSQL(THIS.this_cDscGrp)           + ", " + ;
                       "etiqs = "     + EscaparSQL(THIS.this_cEtiqs)            + ", " + ;
                       "grupos = "    + EscaparSQL(THIS.this_cGrupos)           + ", " + ;
                       "moeds = "     + EscaparSQL(THIS.this_cMoeds)            + ", " + ;
                       "obscompos = " + EscaparSQL(THIS.this_cObsCompos)        + ", " + ;
                       "ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems)    + ", " + ;
                       "pcompos = "   + FormatarNumeroSQL(THIS.this_nPcompos)   + ", " + ;
                       "qtds = "      + FormatarNumeroSQL(THIS.this_nQtdsCompo) + ", " + ;
                       "qtscons = "   + FormatarNumeroSQL(THIS.this_nQtscons)   + ", " + ;
                       "unicompos = " + EscaparSQL(THIS.this_cUniCompos)        + ", " + ;
                       "compos = "    + EscaparSQL(THIS.this_cCompos)           + ", " + ;
                       "ordcompos = " + FormatarNumeroSQL(THIS.this_nOrdCompos) + ", " + ;
                       "qtdcvs = "    + FormatarNumeroSQL(THIS.this_nQtdCvs)    + ", " + ;
                       "vlrcvs = "    + FormatarNumeroSQL(THIS.this_nVlrCvs)    + ", " + ;
                       "dtmovs = GETDATE(), " + ;
                       "cunips = "    + EscaparSQL(THIS.this_cCuniPs)           + ", " + ;
                       "markcvs = "   + FormatarNumeroSQL(THIS.this_nMarkCvs)   + ", " + ;
                       "pesos = "     + FormatarNumeroSQL(THIS.this_nPesos)     + ", " + ;
                       "totas = "     + FormatarNumeroSQL(THIS.this_nTotas)     + ", " + ;
                       "tpalts = "    + FormatarNumeroSQL(THIS.this_nTpAlts)    + ", " + ;
                       "vlrpvs = "    + FormatarNumeroSQL(THIS.this_nVlrPvs)    + ", " + ;
                       "ordts = "     + FormatarNumeroSQL(THIS.this_nOrdTs)     + ", " + ;
                       "tipos = "     + EscaparSQL(THIS.this_cTipos)            + ", " + ;
                       "matriz = "    + EscaparSQL(THIS.this_cMatriz)           + ", " + ;
                       "obsofs = "    + EscaparSQL(THIS.this_cObsOfs)           + ", " + ;
                       "PedraPrincipal = " + FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ;
                       " WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                       " AND mats = "    + EscaparSQL(THIS.this_cMats)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao atualizar composi" + CHR(231) + CHR(227) + "o em SigPrCpo.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar SigPrCpo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPermissaoLiberaPeso - Verifica se existe usu" + CHR(225) + "rio com senha de libera" + CHR(231) + CHR(227) + "o
    * Seta this_lLiberaPeso e retorna .T. se ao menos um usu" + CHR(225) + "rio tem LibPess='S'
    * Replica: lcSql = [Select Count(*) as Senha From SigCdUsu Where LibPess = 'S' And Senhas <> ' ']
    *==========================================================================
    FUNCTION BuscarPermissaoLiberaPeso()
        LOCAL loc_lPodeLiberar, loc_cSQL, loc_nRet, loc_oErro
        loc_lPodeLiberar = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS Senha FROM SigCdUsu " + ;
                       "WHERE LibPess = 'S' AND Senhas <> ' '"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSenha")
            IF loc_nRet >= 1
                SELECT cursor_4c_TmpSenha
                GO TOP
                IF NVL(Senha, 0) > 0
                    loc_lPodeLiberar = .T.
                ENDIF
                IF USED("cursor_4c_TmpSenha")
                    USE IN cursor_4c_TmpSenha
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de peso")
        ENDTRY
        THIS.this_lLiberaPeso = loc_lPodeLiberar
        RETURN loc_lPodeLiberar
    ENDFUNC

    *==========================================================================
    * VerificarDiferencaPeso - Valida se novo peso est" + CHR(225) + " dentro do limite tolerado
    * par_nPesoNovo: valor do peso digitado pelo usu" + CHR(225) + "rio
    * Retorna .T. se dentro do limite (ou sem configura" + CHR(231) + CHR(227) + "o de limite)
    *         .F. se fora do limite (form deve tratar autoriza" + CHR(231) + CHR(227) + "o)
    * Replica logica de Column6.Text1.Valid do legado
    *==========================================================================
    FUNCTION VerificarDiferencaPeso(par_nPesoNovo)
        LOCAL loc_lDentroLimite, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_nDifPesags, loc_cDifPes, loc_nPesoMs
        LOCAL loc_nPesagem, loc_nXDif, loc_nSinals
        loc_lDentroLimite = .T.
        TRY
            *-- Busca flag de controle de diferenca de peso da empresa
            loc_cSQL = "SELECT DifPes FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDif")
            IF loc_nRet < 1
                loc_lSucesso = .T.
            ENDIF
            SELECT cursor_4c_EmpDif
            GO TOP
            loc_cDifPes = ALLTRIM(NVL(DifPes, ""))
            IF USED("cursor_4c_EmpDif")
                USE IN cursor_4c_EmpDif
            ENDIF

            *-- Busca tolerancia da parametrizacao (crSigCdPam.DifPesags, .Sinals)
            IF !USED("crSigCdPam")
                loc_lSucesso = .T.
            ENDIF
            SELECT crSigCdPam
            GO TOP
            loc_nDifPesags = NVL(DifPesags, 0)
            loc_nSinals    = NVL(Sinals, 0)

            IF loc_nDifPesags = 0 OR loc_cDifPes <> "S"
                loc_lSucesso = .T.
            ENDIF

            *-- Busca peso nominal do produto
            loc_cSQL = "SELECT PesoMs FROM SigCdPro " + ;
                       "WHERE Cpros = " + EscaparSQL(THIS.this_cCpros)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProPeso")
            IF loc_nRet < 1
                loc_lSucesso = .T.
            ENDIF
            SELECT cursor_4c_ProPeso
            GO TOP
            loc_nPesoMs = NVL(PesoMs, 0)
            IF USED("cursor_4c_ProPeso")
                USE IN cursor_4c_ProPeso
            ENDIF

            IF loc_nPesoMs = 0
                loc_lSucesso = .T.
            ENDIF

            *-- Calcula peso real por pe" + CHR(231) + "a e percentual de diferen" + CHR(231) + "a
            loc_nPesagem = 0
            IF THIS.this_nQtds <> 0
                loc_nPesagem = (par_nPesoNovo / THIS.this_nQtds) - THIS.this_nPesoFixs
            ENDIF

            IF loc_nPesagem <> loc_nPesoMs
                loc_nXDif = (((loc_nPesagem / loc_nPesoMs) - 1) * 100)
                IF (loc_nXDif < (loc_nDifPesags * -1) AND loc_nSinals <> 1) OR ;
                   (loc_nXDif > loc_nDifPesags AND loc_nSinals <> 2)
                    loc_lDentroLimite = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar diferen" + CHR(231) + "a de peso")
            loc_lDentroLimite = .T.
        ENDTRY
        RETURN loc_lDentroLimite
    ENDFUNC

    *==========================================================================
    * AtualizarPesoMedio - Distribui peso m" + CHR(233) + "dio por todas as pe" + CHR(231) + "as do cursor xPesa
    * par_nPesoMedio: valor do campo get_pesom
    * Replica logica de get_pesom.Valid do legado
    *==========================================================================
    FUNCTION AtualizarPesoMedio(par_nPesoMedio)
        LOCAL loc_lSucesso, loc_nTotal, loc_nPesoPorUnid, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED("xPesa") OR par_nPesoMedio = 0
                loc_lSucesso = .F.
            ENDIF
            SELECT xPesa
            SUM Qtds TO loc_nTotal
            IF loc_nTotal = 0
                loc_lSucesso = .F.
            ENDIF
            loc_nPesoPorUnid = par_nPesoMedio / loc_nTotal
            SELECT xPesa
            SCAN
                REPLACE Peso WITH NVL(Qtds, 0) * loc_nPesoPorUnid
            ENDSCAN
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar peso m" + CHR(233) + "dio")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CalcularCustoProducao - Calcula custo de produ" + CHR(231) + CHR(227) + "o de uma pe" + CHR(231) + "a
    * par_nNops: n" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o
    * par_cCpros: c" + CHR(243) + "digo do produto
    * Retorna valor num" + CHR(233) + "rico do custo calculado
    * Replica logica de custoproducao do legado (usa CrSigCdNei local)
    *==========================================================================
    FUNCTION CalcularCustoProducao(par_nNops, par_cCpros)
        LOCAL loc_nCusto, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cMoeda, loc_nMoev, loc_nMoem
        LOCAL loc_nValor, loc_cMoedaItem, loc_lRetrab
        loc_nCusto = 0
        TRY
            *-- Busca dados do produto principal para cambio
            loc_cSQL = "SELECT MoeCusfs, CustoFs, pVens, Moevs FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCpros)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpPro")
            IF loc_nRet < 1
                loc_lSucesso = 0
            ENDIF
            SELECT cursor_4c_CpPro
            GO TOP
            loc_cMoeda = ALLTRIM(NVL(MoeCusfs, ""))
            IF USED("cursor_4c_CpPro")
                USE IN cursor_4c_CpPro
            ENDIF

            loc_nMoev = fBuscarCotacao(loc_cMoeda, THIS.this_dDataMovimento, gnConnHandle)

            *-- Soma custo de materiais do cursor local CrSigCdNei (por opera" + CHR(231) + CHR(227) + "o)
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                SCAN FOR Nops = par_nNops
                    IF EMPTY(NVL(Cmats, "")) OR IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                        LOOP
                    ENDIF
                    loc_cMoedaItem = ALLTRIM(NVL(MoeCusFs, ""))
                    loc_nMoem = fBuscarCotacao(loc_cMoedaItem, THIS.this_dDataMovimento, gnConnHandle)
                    SELECT CrSigCdNei
                    loc_nCusto = loc_nCusto + ;
                                 (NVL(Qtds,0) * NVL(CustoFs,0) * IIF(loc_nMoev=0, 1, loc_nMoem / loc_nMoev))
                ENDSCAN
            ENDIF

            *-- Busca servi" + CHR(231) + "os terceirizados no SQL Server
            loc_cSQL = "SELECT a.cMats, c.Retrabs, a.Qtds, a.Coefs, a.Fators, a.Moedas " + ;
                       "FROM SigCdNei a " + ;
                       "JOIN SigCdSvc b ON a.cMats = b.ccats AND b.Cpros <> ' ' " + ;
                       "JOIN SigCdNec c ON a.EmpDnps = c.EmpDnPs " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(par_nNops) + ;
                       " AND a.Servicos = 1 AND a.cMats <> ' '"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpSvc")
            IF loc_nRet >= 1
                SELECT cursor_4c_CpSvc
                SCAN
                    loc_lRetrab    = IIF(VARTYPE(Retrabs)="L", Retrabs, NVL(Retrabs,0)=1)
                    loc_cMoedaItem = ALLTRIM(NVL(cursor_4c_CpSvc.Moedas, ""))
                    IF loc_lRetrab AND NVL(Coefs,0) <> 0
                        loc_nValor = ROUND(NVL(Coefs,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                    ELSE
                        loc_nValor = ROUND(NVL(Fators,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                    ENDIF

                    IF loc_nValor = 0
                        LOCAL loc_cMatsSvc
                        loc_cMatsSvc = ALLTRIM(NVL(cursor_4c_CpSvc.cMats, ""))
                        loc_cSQL = "SELECT p.MoeCusfs, p.CustoFs, p.pVens, p.Moevs, g.pvCompos " + ;
                                   "FROM SigCdPro p LEFT JOIN SigCdGrp g ON p.Cgrus = g.Cgrus " + ;
                                   "WHERE p.CPros = " + EscaparSQL(loc_cMatsSvc)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpProSvc")
                        IF loc_nRet >= 1
                            SELECT cursor_4c_CpProSvc
                            GO TOP
                            IF NVL(pvCompos,0) = 2
                                loc_nValor     = ROUND(NVL(pVens,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                                loc_cMoedaItem = ALLTRIM(NVL(Moevs,""))
                            ELSE
                                loc_nValor     = ROUND(NVL(CustoFs,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                                loc_cMoedaItem = ALLTRIM(NVL(MoeCusfs,""))
                            ENDIF
                            IF USED("cursor_4c_CpProSvc")
                                USE IN cursor_4c_CpProSvc
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_nMoem = fBuscarCotacao(loc_cMoedaItem, THIS.this_dDataMovimento, gnConnHandle)
                    SELECT cursor_4c_CpSvc
                    loc_nCusto = loc_nCusto + (loc_nValor * IIF(loc_nMoev=0, 1, loc_nMoem / loc_nMoev))
                ENDSCAN
                IF USED("cursor_4c_CpSvc")
                    USE IN cursor_4c_CpSvc
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao calcular custo de produ" + CHR(231) + CHR(227) + "o")
            loc_nCusto = 0
        ENDTRY
        RETURN loc_nCusto
    ENDFUNC

    *==========================================================================
    * DistribuirRateio - Distribui peso entre os materiais do envelope
    * par_nAmarra: RECNO() da linha atual de xPesa
    * Popula cursor local CrSigCdNei com os materiais e pesos distribuidos
    * Replica logica de ratpeso do legado
    *==========================================================================
    FUNCTION DistribuirRateio(par_nAmarra)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNenv, loc_cMatP, loc_nPesagem, loc_nPesoAnt, loc_nRecnoRateio
        LOCAL loc_nDifPeso, loc_nTotGrava, loc_cSQL, loc_nRet, loc_lTemOuro
        LOCAL loc_cEmps, loc_cDopps, loc_nNumps, loc_cEmpDnPs
        LOCAL loc_nPsFaseAnt, loc_nDivisor
        loc_lSucesso = .F.
        TRY
            IF !USED("crSigCdOpd") OR !USED("xNensiE") OR !USED("TmpNens")
                MsgErro("Cursores de opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o est" + CHR(227) + "o abertos.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Posiciona crSigCdOpd pelo tipo de opera" + CHR(231) + CHR(227) + "o
            SELECT crSigCdOpd
            SET ORDER TO Dopps
            SELECT TmpNens
            GO TOP
            SEEK ALLTRIM(NVL(TmpNens.Dopps, "")) IN crSigCdOpd

            *-- Zera cursores de trabalho para reprocessamento
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                ZAP
            ENDIF
            SELECT xNensiE
            ZAP

            *-- Copia xNensI para xNensiE e calcula totais
            IF USED("xNensI")
                SELECT xNensI
                SET ORDER TO
                SELECT xNensiE
                APPEND FROM DBF("xNensI")
                SUM Pesos TO loc_nTotGrava FOR Visivel AND !IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                SET ORDER TO Rateio
                DELETE ALL FOR EMPTY(NVL(Nops,"")) AND EMPTY(NVL(CMats,"")) AND ;
                              EMPTY(NVL(Cats,"")) AND NVL(Rateio,0) <> 1
                GO TOP
            ENDIF

            *-- Rateio especial para etiquetas tipo 1 ou 3
            IF INLIST(NVL(crSigCdOpd.Etiqs, 0), 1, 3)
                IF USED("xRateio")
                    USE IN xRateio
                ENDIF
                SELECT xPesa
                SELECT Nenvs, MatPs, Peso AS Pesos ;
                FROM xPesa WHERE RECNO() = par_nAmarra ;
                INTO CURSOR xRateio

                SELECT xRateio
                SCAN
                    loc_nNenv        = NVL(Nenvs, 0)
                    loc_cMatP        = ALLTRIM(NVL(MatPs, ""))
                    loc_nPesagem     = NVL(Pesos, 0)
                    loc_nPesoAnt     = 0
                    loc_nRecnoRateio = 0
                    loc_lTemOuro     = .F.

                    SELECT xNensiE
                    SET ORDER TO Nenvs
                    IF SEEK(loc_nNenv)
                        SCAN WHILE NVL(Nenvs,0) = loc_nNenv
                            IF ALLTRIM(NVL(CMats,"")) = loc_cMatP
                                loc_lTemOuro = .T.
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_lTemOuro
                        SELECT TmpNens
                        GO TOP
                        INSERT INTO xNensiE (Nenvs, Nops, Numps, CMats, PsFaseAnt, Pesos, Qtds, Rateio) ;
                        VALUES (loc_nNenv, loc_nNenv, NVL(Numps,0), loc_cMatP, ;
                                loc_nPesagem, loc_nPesagem, loc_nPesagem, 2)
                    ENDIF

                    SELECT xNensiE
                    SCAN FOR NVL(Rateio,0) = 3 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        loc_nPesagem = loc_nPesagem - NVL(Pesos, 0)
                    ENDSCAN

                    SCAN FOR NVL(Rateio,0) = 2 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        IF loc_nRecnoRateio = 0
                            loc_nRecnoRateio = RECNO()
                        ENDIF
                        loc_nPesoAnt = loc_nPesoAnt + NVL(PsFaseAnt, 0)
                    ENDSCAN

                    loc_nDifPeso = loc_nPesagem - loc_nPesoAnt
                    SCAN FOR NVL(Rateio,0) = 2 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        loc_nPsFaseAnt = NVL(PsFaseAnt, 0)
                        loc_nDivisor   = IIF(loc_nPesoAnt = 0, 1, loc_nPesoAnt)
                        REPLACE Pesos WITH ROUND(loc_nPsFaseAnt + (loc_nPsFaseAnt / loc_nDivisor * loc_nDifPeso), 2), ;
                                Qtds  WITH ROUND(loc_nPsFaseAnt + (loc_nPsFaseAnt / loc_nDivisor * loc_nDifPeso), 2)
                        loc_nPesagem = loc_nPesagem - NVL(Pesos, 0)
                    ENDSCAN

                    IF loc_nRecnoRateio <> 0 AND loc_nPesagem <> 0
                        GO loc_nRecnoRateio
                        REPLACE Pesos WITH NVL(Pesos,0) + loc_nPesagem, ;
                                Qtds  WITH NVL(Qtds,0)  + loc_nPesagem
                    ENDIF

                    SELECT xRateio
                ENDSCAN
                IF USED("xRateio")
                    USE IN xRateio
                ENDIF
            ENDIF

            *-- Grava xNensiE no cursor local CrSigCdNei com dados do SQL Server
            SELECT TmpNens
            GO TOP
            loc_cEmps    = ALLTRIM(NVL(TmpNens.Emps,  ""))
            loc_cDopps   = ALLTRIM(NVL(TmpNens.Dopps, ""))
            loc_nNumps   = NVL(TmpNens.Numps, 0)
            loc_cEmpDnPs = loc_cEmps + loc_cDopps + STR(loc_nNumps, 10)

            SELECT xNensiE
            SET ORDER TO Gravar
            SCAN FOR NVL(Qtds,0) <> 0 OR NVL(Pesos,0) <> 0 OR ;
                     (USED("crSigCdOpd") AND NVL(crSigCdOpd.ReiNops, 0) = 1)

                *-- Busca custo e flags do produto/grupo para este material
                loc_cSQL = "SELECT g.CEstoqs, g.pvCompos, g.Varias, " + ;
                           "p.CGrus, p.CustoFs, p.MoeCusFs, p.pVens, p.Moevs " + ;
                           "FROM SigCdPro p LEFT JOIN SigCdGrp g ON p.CGrus = g.CGrus " + ;
                           "WHERE p.Cpros = " + EscaparSQL(ALLTRIM(NVL(xNensiE.CMats,"")))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PgRateio")

                IF USED("CrSigCdNei")
                    INSERT INTO CrSigCdNei ;
                    (Emps, Dopps, Numps, Nops, Nenvs, CMats, CDescs, CUnis, Tpops, Cats, Obss, ;
                     AQtds, Qtds, Pesos, FlagIncs, Fators, Moedas, Servicos, GrupoFins, ;
                     nLotes, PesoFixs, cIdChaves, EmpDNPs, Peso2s) ;
                    VALUES ;
                    (loc_cEmps, loc_cDopps, loc_nNumps, ;
                     NVL(xNensiE.NOps,0), NVL(xNensiE.Nenvs,0), ;
                     ALLTRIM(NVL(xNensiE.CMats,"")),   ALLTRIM(NVL(xNensiE.CDescs,"")), ;
                     ALLTRIM(NVL(xNensiE.CUnis,"")),   ALLTRIM(NVL(xNensiE.Tpops,"")), ;
                     ALLTRIM(NVL(xNensiE.Cats,"")),    ALLTRIM(NVL(xNensiE.Obss,"")), ;
                     NVL(xNensiE.AQtds,0), NVL(xNensiE.Qtds,0), NVL(xNensiE.Pesos,0), ;
                     IIF(VARTYPE(xNensiE.FlagIncs)="L", xNensiE.FlagIncs, NVL(xNensiE.FlagIncs,0)=1), ;
                     NVL(xNensiE.Fators,0), ALLTRIM(NVL(xNensiE.Moedas,"")), ;
                     IIF(VARTYPE(xNensiE.Servicos)="L", xNensiE.Servicos, NVL(xNensiE.Servicos,0)=1), ;
                     ALLTRIM(NVL(xNensiE.GrupoFins,"")), ;
                     NVL(xNensiE.nLotes,0), NVL(xNensiE.PesoFixs,0), ;
                     ALLTRIM(fUniqueIds()), loc_cEmpDnPs, NVL(xNensiE.Peso2s,0))

                    *-- Atualiza custo/moeda e flag PesoFixs baseado no grupo do produto
                    IF loc_nRet >= 1 AND USED("cursor_4c_PgRateio")
                        SELECT cursor_4c_PgRateio
                        GO TOP
                        SELECT CrSigCdNei
                        GO BOTTOM
                        IF NVL(cursor_4c_PgRateio.pvCompos, 0) = 2
                            REPLACE CustoFs  WITH NVL(cursor_4c_PgRateio.pVens,    0), ;
                                    MoeCusfs WITH ALLTRIM(NVL(cursor_4c_PgRateio.Moevs,""))
                        ELSE
                            REPLACE CustoFs  WITH NVL(cursor_4c_PgRateio.CustoFs,  0), ;
                                    MoeCusFs WITH ALLTRIM(NVL(cursor_4c_PgRateio.MoeCusFs,""))
                        ENDIF
                        IF USED("crSigCdOpd") AND NVL(crSigCdOpd.PesoFixs,0) = 1 AND ;
                           NVL(cursor_4c_PgRateio.Varias,0) = 1
                            REPLACE PesoFixs WITH 1
                        ENDIF
                        IF USED("cursor_4c_PgRateio")
                            USE IN cursor_4c_PgRateio
                        ENDIF
                    ENDIF
                ENDIF
                SELECT xNensiE
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao distribuir rateio de peso")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarComposicaoEspecial - Grava composi" + CHR(231) + CHR(227) + "o especial no SQL Server (SigPrCpo)
    * par_cAliasCursor: cursor local com dados (ex: "CsSigPrCpo")
    *   - Cursor deve ter campos do SigPrCpo (ideal: construido via SELECT * FROM SigPrCpo)
    *   - Campos m" + CHR(237) + "nimos: cpros, mats, qtds, pesos, dcompos, unicompos, cunips,
    *     cgrus, pcompos, moeds, dtmovs, tpalts, cidchaves, etiqs
    * Replica: Thisform.Podatamgr.update('CsSigPrCpo') do legado
    * Retorna .T. se sucesso, .F. se falha
    *==========================================================================
    FUNCTION GravarComposicaoEspecial(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cCpros, loc_cIdChaves, loc_nTpAlts
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cAliasCursor)
                MsgErro("Cursor " + par_cAliasCursor + " n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)
            GO TOP
            IF EOF()
                loc_lSucesso = .T.
            ENDIF

            *-- Remove composi" + CHR(231) + CHR(227) + "o anterior do produto no SQL Server
            loc_cCpros = ALLTRIM(NVL(cpros, ""))
            IF !EMPTY(loc_cCpros)
                loc_cSQL = "DELETE FROM SigPrCpo WHERE cpros = " + EscaparSQL(loc_cCpros)
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            *-- Insere cada linha v" + CHR(225) + "lida (TpAlts > 0)
            SELECT (par_cAliasCursor)
            GO TOP
            DO WHILE !EOF()
                loc_nTpAlts = NVL(TpAlts, 0)
                IF loc_nTpAlts > 0
                    loc_cIdChaves = ALLTRIM(NVL(cIdChaves, ""))
                    IF EMPTY(loc_cIdChaves)
                        loc_cIdChaves = ALLTRIM(fUniqueIds())
                    ENDIF
                    loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                               "cidchaves, cpros, mats, cgrus, cats, dcompos, dscgrp, etiqs, " + ;
                               "grupos, moeds, obscompos, ordems, pcompos, qtds, qtscons, " + ;
                               "unicompos, compos, ordcompos, qtdcvs, vlrcvs, dtmovs, cunips, " + ;
                               "markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, " + ;
                               "obsofs, datatrans, PedraPrincipal) " + ;
                               "VALUES (" + ;
                               EscaparSQL(loc_cIdChaves)                          + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cpros,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(mats,      "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cgrus,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cats,      "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(dcompos,   "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(dscgrp,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(etiqs,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(grupos,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(moeds,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(obscompos, "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(ordems,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(pcompos,     0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtds,        0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtscons,     0))             + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(unicompos, "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(compos,    "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(ordcompos,   0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtdcvs,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(vlrcvs,      0))             + ", " + ;
                               "GETDATE(), "                                               + ;
                               EscaparSQL(ALLTRIM(NVL(cunips,    "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(markcvs,     0))             + ", " + ;
                               FormatarNumeroSQL(NVL(pesos,       0))             + ", " + ;
                               FormatarNumeroSQL(NVL(totas,       0))             + ", " + ;
                               FormatarNumeroSQL(NVL(tpalts,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(vlrpvs,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(ordts,       0))             + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(tipos,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(matriz,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(obsofs,    "")))            + ", " + ;
                               "GETDATE(), "                                               + ;
                               FormatarNumeroSQL(NVL(PedraPrincipal, 0))          + ")"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nRet < 1
                        MsgErro("Falha ao gravar composi" + CHR(231) + CHR(227) + "o especial. " + ;
                                "Produto: " + ALLTRIM(NVL(cpros,"")), "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
                SELECT (par_cAliasCursor)
                SKIP
            ENDDO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar composi" + CHR(231) + CHR(227) + "o especial")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarSigCdNei - Persiste cursor local CrSigCdNei no SQL Server (SigCdNei)
    * Equivalente ao poDataMgr.update('CrSigCdNei') do legado
    * Chamado pelo form em BtnProcessarClick ap" + CHR(243) + "s todas as pe" + CHR(231) + "as pesadas
    * Retorna .T. se sucesso, .F. se falha
    *==========================================================================
    FUNCTION GravarSigCdNei()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_lFlagIncs, loc_lServicos
        loc_lSucesso = .F.
        TRY
            IF !USED("CrSigCdNei") OR RECCOUNT("CrSigCdNei") = 0
                loc_lSucesso = .T.
            ENDIF
            SELECT CrSigCdNei
            GO TOP
            DO WHILE !EOF()
                loc_lFlagIncs = IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                loc_lServicos = IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)

                loc_cSQL = "INSERT INTO SigCdNei (" + ;
                           "emps, dopps, numps, nops, nenvs, cmats, cdescs, cunis, tpops, cats, " + ;
                           "obss, aqtds, qtds, pesos, flagincs, fators, moedas, servicos, " + ;
                           "grupofins, nlotes, pesofixs, cidchaves, empdnps, peso2s, " + ;
                           "custofs, moecusfs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(ALLTRIM(NVL(Emps,      ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Dopps,     ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(Numps,       0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Nops,        0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Nenvs,       0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CMats,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CDescs,    ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CUnis,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Tpops,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Cats,      ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Obss,      ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(AQtds,       0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Qtds,        0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Pesos,       0))  + ", " + ;
                           IIF(loc_lFlagIncs, "1", "0")            + ", " + ;
                           FormatarNumeroSQL(NVL(Fators,      0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Moedas,    ""))) + ", " + ;
                           IIF(loc_lServicos, "1", "0")            + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(GrupoFins, ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(nLotes,      0))  + ", " + ;
                           FormatarNumeroSQL(NVL(PesoFixs,    0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(cIdChaves, ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(EmpDNPs,   ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(Peso2s,      0))  + ", " + ;
                           FormatarNumeroSQL(NVL(CustoFs,     0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(MoeCusFs,  ""))) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet < 1
                    MsgErro("Falha ao gravar SigCdNei (Nenvs=" + ;
                            TRANSFORM(NVL(Nenvs,0)) + ")", "Erro")
                    loc_lSucesso = .F.
                ENDIF
                SELECT CrSigCdNei
                SKIP
            ENDDO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar SigCdNei")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

