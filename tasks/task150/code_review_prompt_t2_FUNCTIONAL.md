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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp9.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2205 linhas total):

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
95:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
96:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
97:             THIS.ConfigurarPaginaLista()
98:             THIS.ConfigurarPaginaDados()
99:             THIS.ConfigurarBalanca()
100: 
101:             *-- Verifica permissao de liberar peso
102:             THIS.this_lLiberaPeso = THIS.this_oBusinessObject.BuscarPermissaoLiberaPeso()
103: 
104:             *-- Inicializa PesoFixs a partir de xNensI
105:             THIS.InicializarPesoFixs()
106: 
107:             *-- Posiciona xPesa no inicio
108:             IF USED("xPesa")
109:                 SELECT xPesa

*-- Linhas 125 a 168:
125:     *==========================================================================
126:     * CriarCursoresLocais - Cria CrSigCdNei e xNensiE na datasession compartilhada
127:     *==========================================================================
128:     PROTECTED PROCEDURE CriarCursoresLocais()
129:         LOCAL loc_oErro
130:         TRY
131:             SET NULL OFF
132: 
133:             *-- CrSigCdNei: buffer local de movimentos antes de gravar no SQL Server
134:             IF USED("CrSigCdNei")
135:                 SELECT CrSigCdNei
136:                 ZAP
137:             ELSE
138:                 CREATE CURSOR CrSigCdNei ( ;
139:                     Emps      C(3),    ;
140:                     Dopps     C(10),   ;
141:                     Numps     N(10,0), ;
142:                     Nops      N(10,0), ;
143:                     Nenvs     N(10,0), ;
144:                     CMats     C(14),   ;
145:                     CDescs    C(40),   ;
146:                     CUnis     C(3),    ;
147:                     Tpops     C(3),    ;
148:                     Cats      C(6),    ;
149:                     Obss      C(40),   ;
150:                     AQtds     N(11,3), ;
151:                     Qtds      N(11,3), ;
152:                     Pesos     N(11,3), ;
153:                     FlagIncs  L,       ;
154:                     Fators    N(11,3), ;
155:                     Moedas    C(3),    ;
156:                     Servicos  L,       ;
157:                     GrupoFins C(10),   ;
158:                     nLotes    N(8,3),  ;
159:                     PesoFixs  N(3,0),  ;
160:                     cIdChaves C(20),   ;
161:                     EmpDNPs   C(23),   ;
162:                     Peso2s    N(11,3), ;
163:                     CustoFs   N(11,2), ;
164:                     MoeCusFs  C(3)     ;
165:                 )
166:             ENDIF
167: 
168:             *-- xNensiE: cursor auxiliar para rateio de peso por envelope

*-- Linhas 197 a 265:
197:     * Forms OPERACIONAIS nao tem PageFrame Page1/Page2 como CRUD.
198:     * Este metodo define propriedades visuais globais do form.
199:     *==========================================================================
200:     PROTECTED PROCEDURE ConfigurarPageFrame()
201:         THIS.BackColor  = RGB(212, 208, 200)
202:         THIS.ScrollBars = 0
203:         THIS.ShowTips   = .T.
204:         THIS.SetAll("FontName", "Tahoma")
205:         THIS.SetAll("FontSize", 8)
206:     ENDPROC
207: 
208:     *==========================================================================
209:     * Destroy - Libera objetos e cursores
210:     *==========================================================================
211:     PROCEDURE Destroy()
212:         THIS.this_oBusinessObject = .NULL.
213:         IF USED("CrSigCdNei")
214:             USE IN CrSigCdNei
215:         ENDIF
216:         IF USED("xNensiE")
217:             USE IN xNensiE
218:         ENDIF
219:         DODEFAULT()
220:     ENDPROC
221: 
222:     *==========================================================================
223:     * ConfigurarCabecalho - Container de titulo com efeito sombra
224:     *==========================================================================
225:     PROTECTED PROCEDURE ConfigurarCabecalho()
226:         LOCAL loc_cTitulo
227:         loc_cTitulo = "Pesagem de Pe" + CHR(231) + "as"
228:         THIS.AddObject("cnt_4c_Sombra", "Container")
229:         WITH THIS.cnt_4c_Sombra
230:             .Top         = 0
231:             .Left        = 0
232:             .Width       = 1100
233:             .Height      = 80
234:             .BorderWidth = 0
235:             .BackColor   = RGB(100, 100, 100)
236:             .AddObject("lbl_4c_Sombra", "Label")
237:             WITH .lbl_4c_Sombra
238:                 .FontBold   = .T.
239:                 .FontName   = "Tahoma"
240:                 .FontSize   = 18
241:                 .WordWrap   = .T.
242:                 .Alignment  = 0
243:                 .BackStyle  = 0
244:                 .Caption    = loc_cTitulo
245:                 .Height     = 40
246:                 .Left       = 10
247:                 .Top        = 18
248:                 .Width      = THIS.Width
249:                 .ForeColor  = RGB(0, 0, 0)
250:                 .Visible    = .T.
251:             ENDWITH
252:             .AddObject("lbl_4c_Titulo", "Label")
253:             WITH .lbl_4c_Titulo
254:                 .FontBold   = .T.
255:                 .FontName   = "Tahoma"
256:                 .FontSize   = 18
257:                 .WordWrap   = .T.
258:                 .Alignment  = 0
259:                 .BackStyle  = 0
260:                 .Caption    = loc_cTitulo
261:                 .Height     = 46
262:                 .Left       = 10
263:                 .Top        = 17
264:                 .Width      = THIS.Width
265:                 .ForeColor  = RGB(255, 255, 255)

*-- Linhas 272 a 331:
272:     *==========================================================================
273:     * ConfigurarPaginaLista - Configura a "pagina" principal do form OPERACIONAL
274:     * Em forms OPERACIONAIS nao ha PageFrame Page1/Page2 como nos CRUD.
275:     * Esta procedure agrupa Grid (lista de pecas) e Rodape (botoes de acao):
276:     *   - cmd_4c_Resumo    - Abre janela de resumo (SigPdM10)
277:     *   - cmd_4c_CustoP    - Visualiza custos do produto (apenas com permissao)
278:     *   - cmd_4c_Processar - Confirma pesagem e segue para SigPdM11
279:     *   - cmd_4c_Cancelar  - Cancela e fecha o form
280:     * O legado nao usa botoes CRUD (Incluir/Alterar/Excluir/Buscar) porque
281:     * a pesagem ja recebe a lista de pecas pronta do form pai.
282:     *==========================================================================
283:     PROTECTED PROCEDURE ConfigurarPaginaLista()
284:         THIS.ConfigurarGrid()
285:         THIS.ConfigurarRodape()
286:     ENDPROC
287: 
288:     *==========================================================================
289:     * ConfigurarGrid - Grid GradeItens com 9 colunas ligadas a xPesa
290:     *==========================================================================
291:     PROTECTED PROCEDURE ConfigurarGrid()
292:         LOCAL loc_lAcesso, loc_lLibObss, loc_lTrfPesas
293:         loc_lAcesso  = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
294:         loc_lLibObss = .F.
295:         loc_lTrfPesas = .F.
296:         IF USED("crSigCdPam")
297:             SELECT crSigCdPam
298:             GO TOP
299:             IF VARTYPE(crSigCdPam.LibObss) = "L"
300:                 loc_lLibObss = crSigCdPam.LibObss
301:             ELSE
302:                 IF VARTYPE(crSigCdPam.LibObss) = "L"
303:                     loc_lLibObss = crSigCdPam.LibObss
304:                 ELSE
305:                     IF VARTYPE(crSigCdPam.LibObss) = "L"
306:                         loc_lLibObss = crSigCdPam.LibObss
307:                     ELSE
308:                         IF VARTYPE(crSigCdPam.LibObss) = "L"
309:                             loc_lLibObss = crSigCdPam.LibObss
310:                         ELSE
311:                             IF VARTYPE(crSigCdPam.LibObss) = "L"
312:                                 loc_lLibObss = crSigCdPam.LibObss
313:                             ELSE
314:                                 loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
315:                             ENDIF
316:                         ENDIF
317:                     ENDIF
318:                 ENDIF
319:             ENDIF
320:         ENDIF
321:         IF USED("crSigCdOpd")
322:             SELECT crSigCdOpd
323:             GO TOP
324:             IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
325:                 loc_lTrfPesas = crSigCdOpd.TrfPesas
326:             ELSE
327:                 IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
328:                     loc_lTrfPesas = crSigCdOpd.TrfPesas
329:                 ELSE
330:                     IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
331:                         loc_lTrfPesas = crSigCdOpd.TrfPesas

*-- Linhas 384 a 844:
384:                 .Text1.ForeColor   = RGB(0, 0, 0)
385:                 .Text1.BackColor   = RGB(255, 255, 255)
386:             ENDWITH
387:             BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "When", THIS, "GradeCol1TextWhen")
388: 
389:             *-- Column2: Observacao (Obs) - editavel com LibObss=1 e INSERIR
390:             WITH .Column2
391:                 .ControlSource     = "xPesa.Obs"
392:                 .ColumnOrder       = 6
393:                 .Width             = 100
394:                 .Movable           = .F.
395:                 .Resizable         = .F.
396:                 .ReadOnly          = !loc_lLibObss
397:                 .FontSize          = 8
398:                 .Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
399:                 .Header1.FontName  = "Tahoma"
400:                 .Header1.FontSize  = 8
401:                 .Header1.Alignment = 2
402:                 .Text1.FontSize    = 8
403:                 .Text1.BorderStyle = 0
404:                 .Text1.Margin      = 0
405:                 .Text1.ForeColor   = RGB(0, 0, 0)
406:                 .Text1.BackColor   = RGB(255, 255, 255)
407:             ENDWITH
408:             BINDEVENT(THIS.grd_4c_Itens.Column2.Text1, "When", THIS, "GradeCol2TextWhen")
409: 
410:             *-- Column3: Movimentacao (Oper) - ReadOnly
411:             WITH .Column3
412:                 .ControlSource     = "xPesa.Oper"
413:                 .ColumnOrder       = 4
414:                 .Width             = 221
415:                 .Movable           = .F.
416:                 .Resizable         = .F.
417:                 .ReadOnly          = .T.
418:                 .FontSize          = 8
419:                 .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
420:                 .Header1.FontName  = "Tahoma"
421:                 .Header1.FontSize  = 8
422:                 .Header1.Alignment = 2
423:                 .Text1.FontSize    = 8
424:                 .Text1.BorderStyle = 0
425:                 .Text1.Margin      = 0
426:                 .Text1.ReadOnly    = .T.
427:                 .Text1.ForeColor   = RGB(0, 0, 0)
428:                 .Text1.BackColor   = RGB(255, 255, 255)
429:             ENDWITH
430:             BINDEVENT(THIS.grd_4c_Itens.Column3.Text1, "When", THIS, "GradeCol3TextWhen")
431: 
432:             *-- Column4: Tamanho (Tams) - lookup SigCdTam, editavel com LibObss=1
433:             WITH .Column4
434:                 .ControlSource     = "xPesa.Tams"
435:                 .ColumnOrder       = 8
436:                 .Width             = 40
437:                 .Movable           = .F.
438:                 .Resizable         = .F.
439:                 .ReadOnly          = .F.
440:                 .FontSize          = 8
441:                 .Header1.Caption   = "Tam"
442:                 .Header1.FontName  = "Tahoma"
443:                 .Header1.FontSize  = 8
444:                 .Header1.Alignment = 2
445:                 .Text1.FontSize    = 8
446:                 .Text1.BorderStyle = 0
447:                 .Text1.Margin      = 0
448:                 .Text1.ReadOnly    = .F.
449:                 .Text1.ForeColor   = RGB(0, 0, 0)
450:                 .Text1.BackColor   = RGB(255, 255, 255)
451:             ENDWITH
452:             BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "When",     THIS, "GradeCol4TextWhen")
453:             BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "KeyPress", THIS, "GradeCol4TextKeyPress")
454:             BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "DblClick", THIS, "GradeCol4TextDblClick")
455: 
456:             *-- Column5: Quantidade (Qtds) - ReadOnly (editavel se LibObss<>1)
457:             WITH .Column5
458:                 .ControlSource     = "xPesa.Qtds"
459:                 .ColumnOrder       = 5
460:                 .Width             = 100
461:                 .Movable           = .F.
462:                 .Resizable         = .F.
463:                 .ReadOnly          = .T.
464:                 .FontBold          = .T.
465:                 .FontSize          = 8
466:                 .Format            = "K"
467:                 .Header1.Caption   = "Quantidade"
468:                 .Header1.FontName  = "Tahoma"
469:                 .Header1.FontSize  = 8
470:                 .Header1.Alignment = 2
471:                 .Text1.FontBold    = .T.
472:                 .Text1.FontSize    = 8
473:                 .Text1.BorderStyle = 0
474:                 .Text1.Format      = "K"
475:                 .Text1.Margin      = 0
476:                 .Text1.ReadOnly    = .T.
477:                 .Text1.ForeColor   = RGB(0, 0, 0)
478:                 .Text1.BackColor   = RGB(255, 255, 255)
479:             ENDWITH
480:             BINDEVENT(THIS.grd_4c_Itens.Column5.Text1, "When", THIS, "GradeCol5TextWhen")
481: 
482:             *-- Column6: Peso (Peso) - campo editavel principal com logica de balanca
483:             WITH .Column6
484:                 .ControlSource     = "xPesa.Peso"
485:                 .ColumnOrder       = 9
486:                 .Width             = 100
487:                 .Movable           = .F.
488:                 .Resizable         = .F.
489:                 .ReadOnly          = .F.
490:                 .FontBold          = .T.
491:                 .FontSize          = 8
492:                 .Header1.Caption   = "Peso"
493:                 .Header1.FontName  = "Tahoma"
494:                 .Header1.FontSize  = 8
495:                 .Header1.Alignment = 2
496:                 .Text1.FontBold    = .T.
497:                 .Text1.FontSize    = 8
498:                 .Text1.BorderStyle = 0
499:                 .Text1.Margin      = 0
500:                 .Text1.ReadOnly    = .F.
501:                 .Text1.ForeColor   = RGB(0, 0, 0)
502:                 .Text1.BackColor   = RGB(255, 255, 255)
503:             ENDWITH
504:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "When",      THIS, "GradeCol6TextWhen")
505:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "Valid",     THIS, "GradeCol6TextValid")
506:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "KeyPress", THIS, "GradeCol6TextLostFocus")
507: 
508:             *-- Column7: Cor (Cors) - lookup SigCdCor, editavel com LibObss=1
509:             WITH .Column7
510:                 .ControlSource     = "xPesa.Cors"
511:                 .ColumnOrder       = 7
512:                 .Width             = 40
513:                 .Movable           = .F.
514:                 .Resizable         = .F.
515:                 .ReadOnly          = .F.
516:                 .FontSize          = 8
517:                 .Header1.Caption   = "Cor"
518:                 .Header1.FontName  = "Tahoma"
519:                 .Header1.FontSize  = 8
520:                 .Header1.Alignment = 2
521:                 .Text1.FontSize    = 8
522:                 .Text1.BorderStyle = 0
523:                 .Text1.Margin      = 0
524:                 .Text1.ReadOnly    = .F.
525:                 .Text1.ForeColor   = RGB(0, 0, 0)
526:                 .Text1.BackColor   = RGB(255, 255, 255)
527:             ENDWITH
528:             BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "When",     THIS, "GradeCol7TextWhen")
529:             BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "KeyPress", THIS, "GradeCol7TextKeyPress")
530:             BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "DblClick", THIS, "GradeCol7TextDblClick")
531: 
532:             *-- Column8: Barras (Cbars) - ReadOnly
533:             WITH .Column8
534:                 .ControlSource     = "xPesa.Cbars"
535:                 .ColumnOrder       = 2
536:                 .Width             = 110
537:                 .Movable           = .F.
538:                 .Resizable         = .F.
539:                 .ReadOnly          = .T.
540:                 .FontSize          = 8
541:                 .Header1.Caption   = "Barras"
542:                 .Header1.FontName  = "Tahoma"
543:                 .Header1.FontSize  = 8
544:                 .Header1.Alignment = 2
545:                 .Text1.FontSize    = 8
546:                 .Text1.BorderStyle = 0
547:                 .Text1.Margin      = 0
548:                 .Text1.ReadOnly    = .T.
549:                 .Text1.ForeColor   = RGB(0, 0, 0)
550:                 .Text1.BackColor   = RGB(255, 255, 255)
551:             ENDWITH
552:             BINDEVENT(THIS.grd_4c_Itens.Column8.Text1, "When", THIS, "GradeCol8TextWhen")
553: 
554:             *-- Column9: Custo (CustoFs) - ReadOnly, visivel apenas com permissao CUSTOP
555:             WITH .Column9
556:                 .ControlSource     = "xPesa.CustoFs"
557:                 .ColumnOrder       = 1
558:                 .Movable           = .F.
559:                 .Resizable         = .F.
560:                 .ReadOnly          = .T.
561:                 .FontSize          = 8
562:                 .Header1.Caption   = "Custo"
563:                 .Header1.FontName  = "Tahoma"
564:                 .Header1.FontSize  = 8
565:                 .Header1.Alignment = 2
566:                 .Text1.FontSize    = 8
567:                 .Text1.BorderStyle = 0
568:                 .Text1.Margin      = 0
569:                 .Text1.ReadOnly    = .T.
570:                 .Text1.ForeColor   = RGB(0, 0, 0)
571:                 .Text1.BackColor   = RGB(255, 255, 255)
572:             ENDWITH
573:             BINDEVENT(THIS.grd_4c_Itens.Column9.Text1, "When",     THIS, "GradeCol9TextWhen")
574:             BINDEVENT(THIS.grd_4c_Itens.Column9.Text1, "DblClick", THIS, "GradeCol9TextDblClick")
575: 
576:             *-- Cor dinamica: peca especial em vermelho
577:             .SetAll("DynamicForeColor", ;
578:                     "IIF(xPesa.Especial,RGB(255,0,0),RGB(0,0,0))", "Column")
579: 
580:             *-- Ajuste de largura Column9 por permissao de acesso
581:             IF loc_lAcesso
582:                 .Column9.Width = 72
583:             ELSE
584:                 .Column9.Width  = 1
585:                 .Column3.Width  = .Column3.Width + 71
586:             ENDIF
587: 
588:             .Visible = .T.
589:         ENDWITH
590:     ENDPROC
591: 
592:     *==========================================================================
593:     * ConfigurarRodape - Botoes de acao, peso medio e indicador de peca especial
594:     *==========================================================================
595:     PROTECTED PROCEDURE ConfigurarRodape()
596:         LOCAL loc_cIconPath, loc_lAcesso
597:         loc_cIconPath = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\imagens\"
598:         loc_lAcesso   = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
599: 
600:         *-- Label "Peso medio :"
601:         THIS.AddObject("lbl_4c_PesoMedio", "Label")
602:         WITH THIS.lbl_4c_PesoMedio
603:             .FontSize  = 8
604:             .Caption   = "Peso m" + CHR(233) + "dio :"
605:             .Left      = 49
606:             .Top       = 88
607:             .BackStyle = 0
608:             .ForeColor = RGB(90, 90, 90)
609:             .Visible   = .T.
610:         ENDWITH
611: 
612:         *-- TextBox Peso Medio (equivalente a get_pesom do legado)
613:         THIS.AddObject("txt_4c_PesoMedio", "TextBox")
614:         WITH THIS.txt_4c_PesoMedio
615:             .FontUnderline = .T.
616:             .Alignment     = 3
617:             .Value         = 0
618:             .Height        = 23
619:             .InputMask     = "999.999"
620:             .Left          = 114
621:             .TabIndex      = 6
622:             .Top           = 84
623:             .Width         = 72
624:             .ForeColor     = RGB(0, 0, 0)
625:             .Visible       = .T.
626:         ENDWITH
627:         BINDEVENT(THIS.txt_4c_PesoMedio, "LostFocus", THIS, "TxtPesoMedioValid")
628: 
629:         *-- Indicador de peca especial (caixa vermelha decorativa - Botao1 do legado)
630:         THIS.AddObject("txt_4c_Especial", "TextBox")
631:         WITH THIS.txt_4c_Especial
632:             .Height        = 20
633:             .Left          = 12
634:             .SpecialEffect = 1
635:             .ToolTipText   = "Pe" + CHR(231) + "a Especial"
636:             .Top           = 86
637:             .Width         = 27
638:             .BackColor     = RGB(255, 0, 0)
639:             .ReadOnly      = .T.
640:             .Visible       = .T.
641:         ENDWITH
642:         BINDEVENT(THIS.txt_4c_Especial, "When", THIS, "TxtEspecialWhen")
643: 
644:         *-- Botao Resumo
645:         THIS.AddObject("cmd_4c_Resumo", "CommandButton")
646:         WITH THIS.cmd_4c_Resumo
647:             .Top       = 3
648:             .Left      = 700
649:             .Height    = 75
650:             .Width     = 75
651:             .Caption   = "\<Resumo"
652:             .Themes    = .F.
653:             .ForeColor = RGB(90, 90, 90)
654:             .BackColor = RGB(255, 255, 255)
655:             IF FILE(loc_cIconPath + "geral_documento_60.jpg")
656:                 .Picture = loc_cIconPath + "geral_documento_60.jpg"
657:             ENDIF
658:             .Visible   = .T.
659:         ENDWITH
660:         BINDEVENT(THIS.cmd_4c_Resumo, "Click", THIS, "BtnResumoClick")
661: 
662:         *-- Botao CustoP (visivel apenas com permissao CUSTOP)
663:         THIS.AddObject("cmd_4c_CustoP", "CommandButton")
664:         WITH THIS.cmd_4c_CustoP
665:             .Top         = 3
666:             .Left        = 775
667:             .Height      = 75
668:             .Width       = 75
669:             .Caption     = "Cus\<tos"
670:             .ToolTipText = "Custo Produ" + CHR(231) + CHR(227) + "o"
671:             .Themes      = .F.
672:             .ForeColor   = RGB(90, 90, 90)
673:             .BackColor   = RGB(255, 255, 255)
674:             IF FILE(loc_cIconPath + "geral_calculadora_60.jpg")
675:                 .Picture = loc_cIconPath + "geral_calculadora_60.jpg"
676:             ENDIF
677:             .Visible     = loc_lAcesso
678:         ENDWITH
679:         BINDEVENT(THIS.cmd_4c_CustoP, "Click", THIS, "BtnCustoPClick")
680: 
681:         *-- Botao Processar (Confirmar)
682:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
683:         WITH THIS.cmd_4c_Processar
684:             .Top       = 3
685:             .Left      = 850
686:             .Height    = 75
687:             .Width     = 75
688:             .Caption   = "\<Confirmar"
689:             .Themes    = .F.
690:             .ForeColor = RGB(90, 90, 90)
691:             .BackColor = RGB(255, 255, 255)
692:             IF FILE(loc_cIconPath + "cadastro_salvar_60.jpg")
693:                 .Picture = loc_cIconPath + "cadastro_salvar_60.jpg"
694:             ENDIF
695:             .Visible   = .T.
696:         ENDWITH
697:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
698: 
699:         *-- Botao Cancelar
700:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
701:         WITH THIS.cmd_4c_Cancelar
702:             .Top       = 3
703:             .Left      = 925
704:             .Height    = 75
705:             .Width     = 75
706:             .Cancel    = .T.
707:             .Caption   = "Encerrar"
708:             .Themes    = .F.
709:             .ForeColor = RGB(90, 90, 90)
710:             .BackColor = RGB(255, 255, 255)
711:             IF FILE(loc_cIconPath + "cadastro_cancelar_60.jpg")
712:                 .Picture = loc_cIconPath + "cadastro_cancelar_60.jpg"
713:             ENDIF
714:             .Visible   = .T.
715:         ENDWITH
716:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
717:     ENDPROC
718: 
719:     *==========================================================================
720:     * ConfigurarPaginaDados - Elementos visuais decorativos do form OPERACIONAL
721:     * Forms OPERACIONAIS nao tem Page2/PaginaDados como nos CRUD.
722:     * Este metodo adiciona as shapes visuais do legado (Shape2 e Shape1)
723:     * que flanqueiam a area de cabecalho e botoes respectivamente.
724:     * Shape2: moldura esquerda (area de identificacao do form)
725:     * Shape1: moldura direita (area de botoes de acao)
726:     *==========================================================================
727:     PROTECTED PROCEDURE ConfigurarPaginaDados()
728:         LOCAL loc_oErro
729:         TRY
730:             *-- Shape2: moldura decorativa lado esquerdo (area de titulo)
731:             THIS.AddObject("shp_4c_Shape2", "Shape")
732:             WITH THIS.shp_4c_Shape2
733:                 .Top         = 11
734:                 .Left        = 10
735:                 .Height      = 110
736:                 .Width       = 172
737:                 .BackStyle   = 0
738:                 .BorderStyle = 0
739:                 .BorderColor = RGB(136, 189, 188)
740:                 .Visible     = .T.
741:             ENDWITH
742: 
743:             *-- Shape1: moldura decorativa lado direito (area dos botoes de acao)
744:             THIS.AddObject("shp_4c_Shape1", "Shape")
745:             WITH THIS.shp_4c_Shape1
746:                 .Top         = 11
747:                 .Left        = 817
748:                 .Height      = 110
749:                 .Width       = 172
750:                 .BackStyle   = 0
751:                 .BorderStyle = 0
752:                 .BorderColor = RGB(0, 0, 0)
753:                 .Visible     = .T.
754:             ENDWITH
755:         CATCH TO loc_oErro
756:             MsgErro(loc_oErro.Message, "Erro ao configurar elementos visuais")
757:         ENDTRY
758:     ENDPROC
759: 
760:     *==========================================================================
761:     * ConfigurarBalanca - Conecta controle de balanca serial do framework
762:     * Configurado a partir de crSigCdPam (Porta, Velocidade, Paridade, etc.)
763:     *==========================================================================
764:     PROTECTED PROCEDURE ConfigurarBalanca()
765:         LOCAL loc_oErro
766:         THIS.this_lTemBalanca = .F.
767:         TRY
768:             IF USED("crSigCdPam")
769:             SELECT crSigCdPam
770:             GO TOP
771:             LOCAL loc_cVcx
772:             loc_cVcx = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\framework.vcx"
773:             IF FILE(loc_cVcx)
774:             SET CLASSLIB TO (loc_cVcx) ADDITIVE
775:             THIS.AddObject("bal_4c_Balanca", "balan" + CHR(231) + "a")
776:             WITH THIS.bal_4c_Balanca
777:                 .Top          = 84
778:                 .Left         = 924
779:                 .Height       = 36
780:                 .Width        = 24
781:                 .Porta        = NVL(crSigCdPam.BalPortas, 0)
782:                 .Velocidade   = NVL(crSigCdPam.BalVelocs, 0)
783:                 .TipoParidade = NVL(crSigCdPam.BalTppars, 0)
784:                 .Bits         = NVL(crSigCdPam.BalBits,   0)
785:                 .Paridade     = NVL(crSigCdPam.BalParids, 0)
786:                 IF NVL(crSigCdPam.BalPortas, 0) = 0
787:                     .Leitura = "T"
788:                 ENDIF
789:                 .Visible      = .T.
790:             ENDWITH
791:             THIS.this_lTemBalanca = .T.
792:             ENDIF && FILE(loc_cVcx)
793:             ENDIF && USED("crSigCdPam")
794:         CATCH TO loc_oErro
795:             *-- Balanca nao disponivel - pesagem manual
796:         ENDTRY
797:     ENDPROC
798: 
799:     *==========================================================================
800:     * InicializarPesoFixs - Calcula PesoFixs para cada peca em xPesa
801:     * a partir dos pesos fixos acumulados em xNensi (Rateio=3, !Visivel)
802:     * Replica logica de Select/Index/Scan no Init do legado
803:     *==========================================================================
804:     PROTECTED PROCEDURE InicializarPesoFixs()
805:         LOCAL loc_oErro, loc_lPesMatPs
806:         loc_lPesMatPs = .F.
807:         TRY
808:             IF USED("xPesa") AND USED("xNensI") AND USED("crSigCdOpd")
809:             SELECT crSigCdOpd
810:             GO TOP
811:             loc_lPesMatPs = (NVL(crSigCdOpd.pesMatPs, 0) <> 0)
812:             IF loc_lPesMatPs
813: 
814:             *-- Total de pecas por envelope
815:             IF USED("tPesa_4c")
816:                 USE IN tPesa_4c
817:             ENDIF
818:             SELECT Nenvs, SUM(Qtds) AS Qtds ;
819:               FROM xPesa ;
820:              GROUP BY Nenvs ;
821:               INTO CURSOR tPesa_4c
822: 
823:             *-- Peso fixo (Rateio=3, !Visivel) por envelope
824:             IF USED("xRateio_4c")
825:                 USE IN xRateio_4c
826:             ENDIF
827:             SELECT a.Nenvs, SUM(a.Pesos) AS Pesos, b.Qtds ;
828:               FROM xNensI a, tPesa_4c b ;
829:              WHERE !IIF(VARTYPE(a.Visivel)="L", a.Visivel, NVL(a.Visivel,0)=1) ;
830:                AND NVL(a.Rateio, 0) = 3 ;
831:                AND a.Nenvs = b.Nenvs ;
832:              GROUP BY a.Nenvs, b.Qtds ;
833:               INTO CURSOR xRateio_4c
834: 
835:             IF RECCOUNT("xRateio_4c") > 0
836:                 SELECT xRateio_4c
837:                 INDEX ON NVL(Nenvs, 0) TAG Nenvs
838: 
839:                 SELECT xPesa
840:                 SCAN
841:                     LOCAL loc_nNenv, loc_nQtds, loc_nPesoFixs
842:                     loc_nNenv    = NVL(xPesa.Nenvs, 0)
843:                     loc_nQtds    = NVL(xPesa.Qtds, 0)
844:                     loc_nPesoFixs = 0

*-- Linhas 866 a 909:
866:     ENDPROC
867: 
868:     *--------------------------------------------------------------------------
869:     * HANDLERS DE GRID - Eventos do Grid grd_4c_Itens (PUBLIC para BINDEVENT)
870:     *--------------------------------------------------------------------------
871: 
872:     *==========================================================================
873:     * GradeCol1TextWhen - Produto (sempre ReadOnly)
874:     *==========================================================================
875:     FUNCTION GradeCol1TextWhen()
876:         RETURN .F.
877:     ENDFUNC
878: 
879:     *==========================================================================
880:     * GradeCol2TextWhen - Observacao: editavel apenas com LibObss=1 e modo INSERIR
881:     *==========================================================================
882:     FUNCTION GradeCol2TextWhen()
883:         LOCAL loc_lLibObss, loc_lModoInserir
884:         loc_lLibObss = .F.
885:         loc_lModoInserir = .F.
886:         IF USED("crSigCdPam")
887:             SELECT crSigCdPam
888:             GO TOP
889:             IF VARTYPE(crSigCdPam.LibObss) = "L"
890:                 loc_lLibObss = crSigCdPam.LibObss
891:             ELSE
892:                 IF VARTYPE(crSigCdPam.LibObss) = "L"
893:                     loc_lLibObss = crSigCdPam.LibObss
894:                 ELSE
895:                     IF VARTYPE(crSigCdPam.LibObss) = "L"
896:                         loc_lLibObss = crSigCdPam.LibObss
897:                     ELSE
898:                         IF VARTYPE(crSigCdPam.LibObss) = "L"
899:                             loc_lLibObss = crSigCdPam.LibObss
900:                         ELSE
901:                             IF VARTYPE(crSigCdPam.LibObss) = "L"
902:                                 loc_lLibObss = crSigCdPam.LibObss
903:                             ELSE
904:                                 loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
905:                             ENDIF
906:                         ENDIF
907:                     ENDIF
908:                 ENDIF
909:             ENDIF

*-- Linhas 951 a 1009:
951:     ENDFUNC
952: 
953:     *==========================================================================
954:     * AbrirLookupTamanho - Abre FormBuscaAuxiliar em SigCdTam
955:     *==========================================================================
956:     FUNCTION AbrirLookupTamanho()
957:         LOCAL loc_cValor, loc_oBusca, loc_oErro
958:         TRY
959:             loc_cValor = ""
960:             IF VARTYPE(THIS.grd_4c_Itens) = "O" AND ;
961:                VARTYPE(THIS.grd_4c_Itens.Column4) = "O" AND ;
962:                VARTYPE(THIS.grd_4c_Itens.Column4.Text1) = "O"
963:                 loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column4.Text1.Value, ""))
964:             ENDIF
965:             IF EMPTY(loc_cValor) AND USED("xPesa")
966:                 SELECT xPesa
967:                 loc_cValor = ALLTRIM(NVL(Tams, ""))
968:             ENDIF
969:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
970:                 "SigCdTam", "cursor_4c_TamBusca", "Cods", loc_cValor, ;
971:                 "Sele" + CHR(231) + CHR(227) + "o de Tamanho", .T.)
972:             IF VARTYPE(loc_oBusca) = "O"
973:                 IF !loc_oBusca.this_lAchouRegistro
974:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
975:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
976:                     loc_oBusca.Show()
977:                 ENDIF
978:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TamBusca")
979:                     IF USED("xPesa")
980:                         SELECT xPesa
981:                         REPLACE Tams WITH ALLTRIM(cursor_4c_TamBusca.Cods)
982:                     ENDIF
983:                 ENDIF
984:                 loc_oBusca.Release()
985:             ENDIF
986:             IF USED("cursor_4c_TamBusca")
987:                 USE IN cursor_4c_TamBusca
988:             ENDIF
989:         CATCH TO loc_oErro
990:             MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
991:         ENDTRY
992:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
993:             THIS.grd_4c_Itens.Refresh()
994:         ENDIF
995:     ENDFUNC
996: 
997:     *==========================================================================
998:     * GradeCol5TextWhen - Quantidade: editavel apenas se LibObss <> 1
999:     *==========================================================================
1000:     FUNCTION GradeCol5TextWhen()
1001:         IF USED("crSigCdPam")
1002:             SELECT crSigCdPam
1003:             GO TOP
1004:             RETURN NVL(crSigCdPam.LibObss, 0) <> 1
1005:         ENDIF
1006:         RETURN .F.
1007:     ENDFUNC
1008: 
1009:     *==========================================================================

*-- Linhas 1119 a 1231:
1119:             IF loc_nValorAtual <> 0 AND loc_nValorAtual <> THIS.this_nOldValue
1120:                 *-- Valor negativo: nao permitido
1121:                 IF loc_nValorAtual < 0
1122:                     MsgAviso("O Peso N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
1123:                     IF USED("xPesa")
1124:                         SELECT xPesa
1125:                         REPLACE Peso WITH THIS.this_nOldValue
1126:                     ENDIF
1127:                     loc_lValido = .F.
1128:                 ELSE
1129:                     THIS.this_lAlterou = .T.
1130: 
1131:             *-- Verifica tolerancia de diferenca de peso
1132:             IF !THIS.this_oBusinessObject.VerificarDiferencaPeso(loc_nValorAtual)
1133:                 *-- Fora do limite - calcula valores para mensagem
1134:                 loc_nPesagem  = 0
1135:                 loc_nDifPesags = 0
1136:                 IF USED("crSigCdPam")
1137:                     SELECT crSigCdPam
1138:                     GO TOP
1139:                     loc_nDifPesags = NVL(crSigCdPam.DifPesags, 0)
1140:                 ENDIF
1141:                 IF loc_nQtds <> 0
1142:                     loc_nPesagem = (loc_nValorAtual / loc_nQtds) - loc_nPesoFixs
1143:                 ENDIF
1144: 
1145:                 MsgAviso("Peso Diferente do Peso da Tabela e fora do Limite de " + ;
1146:                     TRANSFORM(loc_nDifPesags, "@Z 999.99%") + CHR(13) + ;
1147:                     "Real: " + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z 9999.999")), "")
1148: 
1149:                 IF THIS.this_lLiberaPeso
1150:                     *-- Solicita senha de autorizacao (SigOpSen)
1151:                     LOCAL loc_cRetorno, loc_lOk, loc_cInfo
1152:                     loc_cRetorno = ""
1153:                     loc_cInfo    = "Libera Pesagem R:" + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z999.999"))
1154:                     DO FORM SigOpSen WITH "LIBPESO", loc_cInfo, "" TO loc_cRetorno
1155:                     CLEAR TYPEAHEAD
1156:                     loc_lOk = (LEFT(ALLTRIM(loc_cRetorno), 1) = "*")
1157:                     IF !loc_lOk
1158:                         MsgAviso("Pesagem n" + CHR(227) + "o autorizada!!!", "")
1159:                         IF USED("xPesa")
1160:                             SELECT xPesa
1161:                             REPLACE Peso WITH 0
1162:                         ENDIF
1163:                         loc_lValido = .F.
1164:                     ELSE
1165:                         IF USED("xPesa")
1166:                             SELECT xPesa
1167:                             REPLACE UsuLibs WITH PADR(SUBSTR(loc_cRetorno, 2), 10)
1168:                         ENDIF
1169:                     ENDIF
1170:                 ELSE
1171:                     IF USED("xPesa")
1172:                         SELECT xPesa
1173:                         REPLACE Peso WITH THIS.this_nOldValue
1174:                     ENDIF
1175:                     loc_lValido = .F.
1176:                 ENDIF
1177:             ENDIF && !VerificarDiferencaPeso
1178:                 ENDIF && loc_nValorAtual >= 0
1179:             ENDIF && loc_nValorAtual <> 0
1180:         CATCH TO loc_oErro
1181:             MsgErro(loc_oErro.Message, "Erro na valida" + CHR(231) + CHR(227) + "o do peso")
1182:             loc_lValido = .T.
1183:         ENDTRY
1184:         RETURN loc_lValido
1185:     ENDFUNC
1186: 
1187:     *==========================================================================
1188:     * GradeCol6TextLostFocus - Apos saida do campo Peso: rateio, custo, especial
1189:     * Replica Column6.Text1.LostFocus do legado
1190:     *==========================================================================
1191:     PROCEDURE GradeCol6TextLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1192:         LOCAL loc_nValorAtual, loc_nRecno, loc_nNenv, loc_oErro
1193:         LOCAL loc_lEspecial, loc_nNops, loc_cCpros, loc_nCusto
1194:         TRY
1195:             IF USED("xPesa")
1196:                 SELECT xPesa
1197:                 loc_nValorAtual = NVL(Peso, 0)
1198:             ENDIF
1199:             IF loc_nValorAtual <> 0 AND THIS.this_lAlterou
1200:                 SELECT xPesa
1201:                 loc_nRecno    = RECNO()
1202:                 loc_nNenv     = NVL(Nenvs, 0)
1203:                 loc_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
1204:                 loc_nNops     = NVL(Nops, 0)
1205:                 loc_cCpros    = ALLTRIM(NVL(Cpros, ""))
1206: 
1207:             *-- Distribui rateio de peso entre materiais do envelope
1208:             THIS.this_oBusinessObject.DistribuirRateio(loc_nRecno)
1209: 
1210:             *-- Calcula custo de producao e atualiza xPesa.CustoFs
1211:             loc_nCusto = THIS.this_oBusinessObject.CalcularCustoProducao(loc_nNops, loc_cCpros)
1212:             IF USED("xPesa")
1213:                 SELECT xPesa
1214:                 IF loc_nRecno > 0
1215:                     GO loc_nRecno
1216:                 ENDIF
1217:                 REPLACE CustoFs WITH loc_nCusto
1218:             ENDIF
1219: 
1220:             *-- Peca especial: processa composicao SigPrCpo
1221:             IF loc_lEspecial
1222:                 THIS.ProcessarPesoEspecial(loc_nNenv, loc_nNops, loc_cCpros, loc_nRecno)
1223:             ENDIF
1224: 
1225:             *-- Navegacao: avanca para proxima peca
1226:             IF USED("xPesa")
1227:                 SELECT xPesa
1228:                 IF loc_nRecno > 0
1229:                     GO loc_nRecno
1230:                 ENDIF
1231:                 SKIP

*-- Linhas 1279 a 1382:
1279:     ENDFUNC
1280: 
1281:     *==========================================================================
1282:     * AbrirLookupCor - Abre FormBuscaAuxiliar em SigCdCor
1283:     *==========================================================================
1284:     FUNCTION AbrirLookupCor()
1285:         LOCAL loc_cValor, loc_oBusca, loc_oErro
1286:         TRY
1287:             loc_cValor = ""
1288:             IF VARTYPE(THIS.grd_4c_Itens) = "O" AND ;
1289:                VARTYPE(THIS.grd_4c_Itens.Column7) = "O" AND ;
1290:                VARTYPE(THIS.grd_4c_Itens.Column7.Text1) = "O"
1291:                 loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column7.Text1.Value, ""))
1292:             ENDIF
1293:             IF EMPTY(loc_cValor) AND USED("xPesa")
1294:                 SELECT xPesa
1295:                 loc_cValor = ALLTRIM(NVL(Cors, ""))
1296:             ENDIF
1297:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1298:                 "SigCdCor", "cursor_4c_CorBusca", "Cods", loc_cValor, ;
1299:                 "Sele" + CHR(231) + CHR(227) + "o de Cor", .T.)
1300:             IF VARTYPE(loc_oBusca) = "O"
1301:                 IF !loc_oBusca.this_lAchouRegistro
1302:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1303:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1304:                     loc_oBusca.Show()
1305:                 ENDIF
1306:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CorBusca")
1307:                     IF USED("xPesa")
1308:                         SELECT xPesa
1309:                         REPLACE Cors WITH ALLTRIM(cursor_4c_CorBusca.Cods)
1310:                     ENDIF
1311:                 ENDIF
1312:                 loc_oBusca.Release()
1313:             ENDIF
1314:             IF USED("cursor_4c_CorBusca")
1315:                 USE IN cursor_4c_CorBusca
1316:             ENDIF
1317:         CATCH TO loc_oErro
1318:             MsgErro(loc_oErro.Message, "Erro ao buscar cor")
1319:         ENDTRY
1320:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
1321:             THIS.grd_4c_Itens.Refresh()
1322:         ENDIF
1323:     ENDFUNC
1324: 
1325:     *==========================================================================
1326:     * GradeCol8TextWhen - Barras (ReadOnly)
1327:     *==========================================================================
1328:     FUNCTION GradeCol8TextWhen()
1329:         RETURN .F.
1330:     ENDFUNC
1331: 
1332:     *==========================================================================
1333:     * GradeCol9TextWhen - Custo (ReadOnly)
1334:     *==========================================================================
1335:     FUNCTION GradeCol9TextWhen()
1336:         RETURN .F.
1337:     ENDFUNC
1338: 
1339:     *==========================================================================
1340:     * GradeCol9TextDblClick - Custo: abre SigCdPro se tiver permissao CUSTOP
1341:     *==========================================================================
1342:     PROCEDURE GradeCol9TextDblClick()
1343:         LOCAL loc_nRecno, loc_oErro
1344:         TRY
1345:             IF fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP") AND USED("xPesa")
1346:                 SELECT xPesa
1347:                 loc_nRecno = RECNO()
1348:                 DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
1349:                 SELECT xPesa
1350:                 IF loc_nRecno > 0
1351:                     GO loc_nRecno
1352:                 ENDIF
1353:             ENDIF
1354:         CATCH TO loc_oErro
1355:             MsgErro(loc_oErro.Message, "Erro ao abrir produto")
1356:         ENDTRY
1357:     ENDPROC
1358: 
1359:     *==========================================================================
1360:     * TxtEspecialWhen - Indicador visual de peca especial (ReadOnly decorativo)
1361:     *==========================================================================
1362:     FUNCTION TxtEspecialWhen()
1363:         RETURN .F.
1364:     ENDFUNC
1365: 
1366:     *==========================================================================
1367:     * TxtPesoMedioValid - Distribui peso medio por todas as pecas do cursor xPesa
1368:     * Replica get_pesom.Valid do legado
1369:     *==========================================================================
1370:     FUNCTION TxtPesoMedioValid()
1371:         LOCAL loc_nPesoMedio, loc_oErro
1372:         TRY
1373:             loc_nPesoMedio = NVL(THIS.txt_4c_PesoMedio.Value, 0)
1374:             IF !EMPTY(loc_nPesoMedio) AND loc_nPesoMedio <> 0
1375:                 THIS.this_oBusinessObject.AtualizarPesoMedio(loc_nPesoMedio)
1376:                 IF VARTYPE(THIS.grd_4c_Itens) = "O"
1377:                     THIS.grd_4c_Itens.Refresh()
1378:                 ENDIF
1379:             ENDIF
1380:         CATCH TO loc_oErro
1381:             MsgErro(loc_oErro.Message, "Erro ao distribuir peso m" + CHR(233) + "dio")
1382:         ENDTRY

*-- Linhas 1391 a 1705:
1391:     * BtnIncluirClick - Adiciona nova pe" + CHR(231) + "a na grade de pesagem
1392:     * Form OPERACIONAL: Incluir adiciona linha em xPesa para nova pesagem
1393:     *==========================================================================
1394:     PROCEDURE BtnIncluirClick()
1395:         LOCAL loc_oErro
1396:         TRY
1397:             IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
1398:                !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
1399:                 MsgAviso("Inclus" + CHR(227) + "o de pe" + CHR(231) + "a permitida apenas em modo Inserir/Alterar.", "Aviso")
1400:                 RETURN
1401:             ENDIF
1402:             IF !USED("xPesa")
1403:                 MsgAviso("Cursor de pesagem n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
1404:                 RETURN
1405:             ENDIF
1406:             SELECT xPesa
1407:             APPEND BLANK
1408:             REPLACE Peso WITH 0, Qtds WITH 1
1409:             THIS.this_lAlterou = .T.
1410:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1411:                 THIS.grd_4c_Itens.Refresh()
1412:                 THIS.grd_4c_Itens.SetFocus()
1413:             ENDIF
1414:         CATCH TO loc_oErro
1415:             MsgErro(loc_oErro.Message, "Erro ao incluir pe" + CHR(231) + "a")
1416:         ENDTRY
1417:     ENDPROC
1418: 
1419:     *==========================================================================
1420:     * BtnAlterarClick - Foca grade na pe" + CHR(231) + "a corrente para editar peso
1421:     * Form OPERACIONAL: Alterar = editar peso da pe" + CHR(231) + "a corrente
1422:     *==========================================================================
1423:     PROCEDURE BtnAlterarClick()
1424:         LOCAL loc_oErro
1425:         TRY
1426:             IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
1427:                !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
1428:                 MsgAviso("Altera" + CHR(231) + CHR(227) + "o permitida apenas em modo Inserir/Alterar.", "Aviso")
1429:                 RETURN
1430:             ENDIF
1431:             IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
1432:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "as para alterar.", "Aviso")
1433:                 RETURN
1434:             ENDIF
1435:             SELECT xPesa
1436:             IF EOF() OR BOF()
1437:                 GO TOP
1438:             ENDIF
1439:             THIS.this_lAlterou = .T.
1440:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1441:                 THIS.grd_4c_Itens.SetFocus()
1442:                 IF PEMSTATUS(THIS.grd_4c_Itens, "Column6", 5)
1443:                     THIS.grd_4c_Itens.Column6.SetFocus()
1444:                 ENDIF
1445:             ENDIF
1446:         CATCH TO loc_oErro
1447:             MsgErro(loc_oErro.Message, "Erro ao alterar pe" + CHR(231) + "a")
1448:         ENDTRY
1449:     ENDPROC
1450: 
1451:     *==========================================================================
1452:     * BtnVisualizarClick - Exibe custo/composi" + CHR(231) + CHR(227) + "o da pe" + CHR(231) + "a corrente
1453:     * Form OPERACIONAL: Visualizar abre SigCdPro com produto corrente
1454:     *==========================================================================
1455:     PROCEDURE BtnVisualizarClick()
1456:         LOCAL loc_oErro, loc_nRecno, loc_cCpros
1457:         TRY
1458:             IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
1459:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "a para visualizar.", "Aviso")
1460:                 RETURN
1461:             ENDIF
1462:             IF !fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
1463:                 MsgAviso("Sem permiss" + CHR(227) + "o para visualizar custo.", "Aviso")
1464:                 RETURN
1465:             ENDIF
1466:             SELECT xPesa
1467:             loc_nRecno = RECNO()
1468:             loc_cCpros = ALLTRIM(NVL(Cpros, ""))
1469:             IF EMPTY(loc_cCpros)
1470:                 MsgAviso("Pe" + CHR(231) + "a sem produto associado.", "Aviso")
1471:                 RETURN
1472:             ENDIF
1473:             DO FORM SigCdPro WITH "PESAGEM", loc_cCpros
1474:             SELECT xPesa
1475:             IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
1476:                 GO loc_nRecno
1477:             ENDIF
1478:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1479:                 THIS.grd_4c_Itens.Refresh()
1480:             ENDIF
1481:         CATCH TO loc_oErro
1482:             MsgErro(loc_oErro.Message, "Erro ao visualizar pe" + CHR(231) + "a")
1483:         ENDTRY
1484:     ENDPROC
1485: 
1486:     *==========================================================================
1487:     * BtnExcluirClick - Zera peso da pe" + CHR(231) + "a corrente (desfaz pesagem)
1488:     * Form OPERACIONAL: Excluir zera Peso e PesoFixs da linha corrente
1489:     *==========================================================================
1490:     PROCEDURE BtnExcluirClick()
1491:         LOCAL loc_oErro, loc_lConfirma
1492:         TRY
1493:             IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
1494:                !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
1495:                 MsgAviso("Exclus" + CHR(227) + "o permitida apenas em modo Inserir/Alterar.", "Aviso")
1496:                 RETURN
1497:             ENDIF
1498:             IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
1499:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "a para excluir.", "Aviso")
1500:                 RETURN
1501:             ENDIF
1502:             SELECT xPesa
1503:             IF EOF() OR BOF()
1504:                 GO TOP
1505:             ENDIF
1506:             loc_lConfirma = MsgConfirma("Confirma desfazer a pesagem desta pe" + CHR(231) + "a?", "Confirma" + CHR(231) + CHR(227) + "o")
1507:             IF !loc_lConfirma
1508:                 RETURN
1509:             ENDIF
1510:             SELECT xPesa
1511:             REPLACE Peso WITH 0
1512:             IF TYPE("xPesa.PesoFixs") <> "U"
1513:                 REPLACE PesoFixs WITH 0
1514:             ENDIF
1515:             THIS.this_lAlterou = .T.
1516:             THIS.this_nOldValue = 0
1517:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1518:                 THIS.grd_4c_Itens.Refresh()
1519:                 THIS.grd_4c_Itens.SetFocus()
1520:             ENDIF
1521:         CATCH TO loc_oErro
1522:             MsgErro(loc_oErro.Message, "Erro ao excluir pesagem")
1523:         ENDTRY
1524:     ENDPROC
1525: 
1526:     *==========================================================================
1527:     * BtnResumoClick - Abre form de resumo SigPdM10 com referencia ao form pai
1528:     *==========================================================================
1529:     PROCEDURE BtnResumoClick()
1530:         DO FORM SigPdM10 WITH THIS.this_oPaiForm
1531:     ENDPROC
1532: 
1533:     *==========================================================================
1534:     * BtnCustoPClick - Abre SigCdPro no modo PESAGEM para a peca selecionada
1535:     *==========================================================================
1536:     PROCEDURE BtnCustoPClick()
1537:         LOCAL loc_nRecno, loc_oErro
1538:         TRY
1539:             IF fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP") AND ;
1540:                VARTYPE(THIS.this_oPaiForm) = "O" AND ;
1541:                INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
1542:                 IF USED("xPesa")
1543:                     SELECT xPesa
1544:                     loc_nRecno = RECNO()
1545:                     DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
1546:                     SELECT xPesa
1547:                     IF loc_nRecno > 0
1548:                         LOCATE FOR RECNO() = loc_nRecno
1549:                     ENDIF
1550:                 ENDIF
1551:             ENDIF
1552:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1553:                 THIS.grd_4c_Itens.SetFocus()
1554:             ENDIF
1555:         CATCH TO loc_oErro
1556:             MsgErro(loc_oErro.Message, "Erro ao abrir custo de produto")
1557:         ENDTRY
1558:     ENDPROC
1559: 
1560:     *==========================================================================
1561:     * BtnProcessarClick - Valida que todas as pecas foram pesadas e encerra
1562:     * Replica Processar.Click do legado
1563:     *==========================================================================
1564:     PROCEDURE BtnProcessarClick()
1565:         LOCAL loc_oErro, loc_lPodeProsseguir
1566:         loc_lPodeProsseguir = .T.
1567:         TRY
1568:             *-- Valida pesagem completa apenas no modo INSERIR
1569:             IF VARTYPE(THIS.this_oPaiForm) = "O" AND ;
1570:                ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR"
1571:                 IF USED("xPesa")
1572:                     SELECT xPesa
1573:                     SCAN
1574:                         IF NVL(Peso, 0) = 0
1575:                             MsgAviso("Existe Uma Pe" + CHR(231) + "a Que N" + CHR(227) + ;
1576:                                      "o Foi Pesada!!!", "")
1577:                             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1578:                                 THIS.grd_4c_Itens.Refresh()
1579:                             ENDIF
1580:                             loc_lPodeProsseguir = .F.
1581:                             EXIT
1582:                         ENDIF
1583:                     ENDSCAN
1584:                 ENDIF
1585:             ENDIF
1586: 
1587:             IF loc_lPodeProsseguir AND USED("xNensiS") AND RECCOUNT("xNensiS") > 0
1588:                 DO FORM SigPdM11 WITH THIS.this_oPaiForm, THIS.DataSessionId
1589:             ENDIF
1590: 
1591:             *-- Habilita form pai e fecha
1592:             IF loc_lPodeProsseguir
1593:                 IF VARTYPE(THIS.this_oPaiForm) = "O"
1594:                     THIS.this_oPaiForm.Enabled = .T.
1595:                 ENDIF
1596:                 THIS.Release()
1597:             ENDIF
1598:         CATCH TO loc_oErro
1599:             MsgErro(loc_oErro.Message, "Erro ao processar pesagem")
1600:         ENDTRY
1601:     ENDPROC
1602: 
1603:     *==========================================================================
1604:     * BtnCancelarClick - Cancela pesagem e fecha o form
1605:     *==========================================================================
1606:     PROCEDURE BtnCancelarClick()
1607:         IF VARTYPE(THIS.this_oPaiForm) = "O"
1608:             THIS.this_oPaiForm.Enabled = .T.
1609:         ENDIF
1610:         THIS.Release()
1611:     ENDPROC
1612: 
1613:     *==========================================================================
1614:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1615:     * OPERACIONAL: nao ha containers flutuantes a excluir neste form
1616:     *==========================================================================
1617:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1618:         LOCAL loc_nI, loc_oObjeto
1619:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1620:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1621:             IF VARTYPE(loc_oObjeto) = "O"
1622:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1623:                     loc_oObjeto.Visible = .T.
1624:                 ENDIF
1625:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1626:                     LOCAL loc_nP
1627:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1628:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1629:                     ENDFOR
1630:                 ENDIF
1631:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1632:                     IF loc_oObjeto.ControlCount > 0
1633:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1634:                     ENDIF
1635:                 ENDIF
1636:             ENDIF
1637:         ENDFOR
1638:     ENDPROC
1639: 
1640:     *==========================================================================
1641:     * AlternarPagina - Sem alternancia de paginas em form OPERACIONAL
1642:     * Reposiciona cursor xPesa e atualiza grid
1643:     *==========================================================================
1644:     PROCEDURE AlternarPagina(par_nPagina)
1645:         LOCAL loc_oErro
1646:         TRY
1647:             IF USED("xPesa")
1648:                 SELECT xPesa
1649:                 GO TOP
1650:             ENDIF
1651:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1652:                 THIS.grd_4c_Itens.Refresh()
1653:             ENDIF
1654:         CATCH TO loc_oErro
1655:             MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
1656:         ENDTRY
1657:     ENDPROC
1658: 
1659:     *==========================================================================
1660:     * ProcessarPesoEspecial - Logica de composicao para peca especial
1661:     * Constroi CrTmpCompo a partir de CrSigCdNei + servicos externos
1662:     * Grava SigPrCpo e abre SigCdPro para revisao
1663:     * Replica logica da secao IF xpesa.Especial de Column6.Text1.LostFocus
1664:     *==========================================================================
1665:     PROTECTED PROCEDURE ProcessarPesoEspecial(par_nNenv, par_nNops, par_cCpros, par_nRecno)
1666:         LOCAL loc_oErro, loc_cSQL, loc_nRet, loc_lSucesso
1667:         LOCAL loc_nMtPrimas, loc_lTemOpEopp
1668:         LOCAL loc_cCMats, loc_nPeso2, loc_nQtds
1669:         LOCAL loc_cDpros, loc_cCunis, loc_cCuniPs, loc_cCgrus2, loc_nCustoFs, loc_cMoeCusFs, loc_cEtiPads
1670:         LOCAL loc_cSvcCpros, loc_nSvcQtds, loc_cSvcEtiPads
1671:         LOCAL loc_cSvcDpros, loc_cSvcCunis, loc_cSvcCuniPs, loc_cSvcCgrus, loc_nSvcCustoFs, loc_cSvcMoeCusFs
1672:         loc_lSucesso = .F.
1673:         TRY
1674:             *-- 1. Tipo de materia prima do grupo do produto (MtPrimas)
1675:             loc_cSQL = "SELECT b.mtprimas FROM SigCdPro a " + ;
1676:                        "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
1677:                        "WHERE a.Cpros = " + EscaparSQL(par_cCpros)
1678:             IF USED("cursor_4c_EspGruTip")
1679:                 USE IN cursor_4c_EspGruTip
1680:             ENDIF
1681:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspGruTip")
1682:             loc_nMtPrimas = 0
1683:             IF loc_nRet >= 1
1684:                 SELECT cursor_4c_EspGruTip
1685:                 GO TOP
1686:                 loc_nMtPrimas = NVL(MtPrimas, 0)
1687:                 USE IN cursor_4c_EspGruTip
1688:             ENDIF
1689: 
1690:             *-- 2. Carrega composicao atual do SQL Server em CrTmpCompo
1691:             loc_cSQL = "SELECT * FROM SigPrCpo WHERE Cpros = " + EscaparSQL(par_cCpros)
1692:             IF USED("CrTmpCompo")
1693:                 USE IN CrTmpCompo
1694:             ENDIF
1695:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpCompo")
1696:             IF loc_nRet >= 1
1697:             *-- Indexa por Mats e reseta TpAlts
1698:             SELECT CrTmpCompo
1699:             INDEX ON ALLTRIM(NVL(Mats, "")) TAG Mats
1700:             REPLACE ALL TpAlts WITH 0
1701: 
1702:             *-- 3. Servicos do cadastro (SigCdSvc)
1703:             loc_cSQL = "SELECT Mats, cCats FROM SigCdSvc WHERE Mats <> ' '"
1704:             IF USED("CsTmpSer")
1705:                 USE IN CsTmpSer

*-- Linhas 2010 a 2205:
2010:     * Form OPERACIONAL: xPesa ja vem pre-carregado do form pai.
2011:     * Este metodo apenas reposiciona e rebind o RecordSource quando necessario.
2012:     *==========================================================================
2013:     PROCEDURE CarregarLista()
2014:         LOCAL loc_oErro
2015:         TRY
2016:             IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
2017:                 SELECT xPesa
2018:                 GO TOP
2019:                 THIS.grd_4c_Itens.RecordSource = "xPesa"
2020:                 WITH THIS.grd_4c_Itens
2021:                     .Column1.Header1.Caption = "Produto"
2022:                     .Column2.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
2023:                     .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2024:                     .Column4.Header1.Caption = "Tam"
2025:                     .Column5.Header1.Caption = "Quantidade"
2026:                     .Column6.Header1.Caption = "Peso"
2027:                     .Column7.Header1.Caption = "Cor"
2028:                     .Column8.Header1.Caption = "Barras"
2029:                     .Column9.Header1.Caption = "Custo"
2030:                     .Refresh()
2031:                 ENDWITH
2032:             ENDIF
2033:         CATCH TO loc_oErro
2034:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de pe" + CHR(231) + "as")
2035:         ENDTRY
2036:     ENDPROC
2037: 
2038:     *==========================================================================
2039:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo do form pai
2040:     * INSERIR/ALTERAR: Processar habilitado, grid editavel
2041:     * VISUALIZAR: apenas Resumo, CustoP e Cancelar habilitados
2042:     *==========================================================================
2043:     PROCEDURE AjustarBotoesPorModo()
2044:         LOCAL loc_cModo, loc_lEdicao, loc_lAcesso
2045:         loc_cModo   = ""
2046:         loc_lEdicao = .F.
2047:         loc_lAcesso = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
2048:         IF VARTYPE(THIS.this_oPaiForm) = "O"
2049:             loc_cModo   = ALLTRIM(NVL(THIS.this_oPaiForm.pcEscolha, ""))
2050:             loc_lEdicao = INLIST(loc_cModo, "INSERIR", "ALTERAR")
2051:         ENDIF
2052:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
2053:             THIS.cmd_4c_Processar.Enabled = loc_lEdicao
2054:         ENDIF
2055:         IF VARTYPE(THIS.cmd_4c_CustoP) = "O"
2056:             THIS.cmd_4c_CustoP.Visible  = loc_lAcesso
2057:             THIS.cmd_4c_CustoP.Enabled  = loc_lAcesso AND loc_lEdicao
2058:         ENDIF
2059:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2060:             THIS.txt_4c_PesoMedio.ReadOnly = !loc_lEdicao
2061:         ENDIF
2062:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
2063:             THIS.grd_4c_Itens.ReadOnly = !loc_lEdicao
2064:         ENDIF
2065:     ENDPROC
2066: 
2067:     *==========================================================================
2068:     * FormParaBO - Transfere valores do form para o Business Object
2069:     * Form OPERACIONAL: o principal e o cursor xPesa (gerenciado diretamente).
2070:     * Aqui transferimos apenas estado auxiliar (peso medio, prog acesso).
2071:     *==========================================================================
2072:     PROTECTED PROCEDURE FormParaBO()
2073:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
2074:             RETURN
2075:         ENDIF
2076:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2077:             THIS.this_oBusinessObject.this_nPesoMedio = NVL(THIS.txt_4c_PesoMedio.Value, 0)
2078:         ENDIF
2079:         THIS.this_oBusinessObject.this_cProgAcesso    = THIS.this_cProgAcesso
2080:         THIS.this_oBusinessObject.this_lAlterou       = THIS.this_lAlterou
2081:         THIS.this_oBusinessObject.this_nOldValue      = THIS.this_nOldValue
2082:         THIS.this_oBusinessObject.this_lLiberaPeso    = THIS.this_lLiberaPeso
2083:         IF USED("xPesa")
2084:             SELECT xPesa
2085:             THIS.this_oBusinessObject.this_cCpros   = ALLTRIM(NVL(Cpros,    ""))
2086:             THIS.this_oBusinessObject.this_cObs     = ALLTRIM(NVL(Obs,      ""))
2087:             THIS.this_oBusinessObject.this_cOper    = ALLTRIM(NVL(Oper,     ""))
2088:             THIS.this_oBusinessObject.this_nQtds    = NVL(Qtds,    0)
2089:             THIS.this_oBusinessObject.this_nPeso    = NVL(Peso,    0)
2090:             THIS.this_oBusinessObject.this_cTams    = ALLTRIM(NVL(Tams,     ""))
2091:             THIS.this_oBusinessObject.this_cCors    = ALLTRIM(NVL(Cors,     ""))
2092:             THIS.this_oBusinessObject.this_cCbars   = ALLTRIM(NVL(Cbars,    ""))
2093:             THIS.this_oBusinessObject.this_nCustoFs = NVL(CustoFs, 0)
2094:             THIS.this_oBusinessObject.this_nNops    = NVL(Nops,    0)
2095:             THIS.this_oBusinessObject.this_nNenvs   = NVL(Nenvs,   0)
2096:             THIS.this_oBusinessObject.this_nPesoFixs = NVL(PesoFixs, 0)
2097:             THIS.this_oBusinessObject.this_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
2098:         ENDIF
2099:     ENDPROC
2100: 
2101:     *==========================================================================
2102:     * BOParaForm - Transfere valores do Business Object para o form
2103:     * Form OPERACIONAL: restaura peso medio e atualiza grid
2104:     *==========================================================================
2105:     PROTECTED PROCEDURE BOParaForm()
2106:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
2107:             RETURN
2108:         ENDIF
2109:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2110:             THIS.txt_4c_PesoMedio.Value = NVL(THIS.this_oBusinessObject.this_nPesoMedio, 0)
2111:         ENDIF
2112:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
2113:             THIS.grd_4c_Itens.Refresh()
2114:         ENDIF
2115:     ENDPROC
2116: 
2117:     *==========================================================================
2118:     * HabilitarCampos - Habilita ou desabilita edicao conforme par_lHabilitar
2119:     * Form OPERACIONAL: controla grid e campo de peso medio
2120:     *==========================================================================
2121:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2122:         LOCAL loc_lLibObss
2123:         loc_lLibObss = .F.
2124:         IF USED("crSigCdPam")
2125:             SELECT crSigCdPam
2126:             GO TOP
2127:             IF VARTYPE(crSigCdPam.LibObss) = "L"
2128:                 loc_lLibObss = crSigCdPam.LibObss
2129:             ELSE
2130:                 IF VARTYPE(crSigCdPam.LibObss) = "L"
2131:                     loc_lLibObss = crSigCdPam.LibObss
2132:                 ELSE
2133:                     IF VARTYPE(crSigCdPam.LibObss) = "L"
2134:                         loc_lLibObss = crSigCdPam.LibObss
2135:                     ELSE
2136:                         IF VARTYPE(crSigCdPam.LibObss) = "L"
2137:                             loc_lLibObss = crSigCdPam.LibObss
2138:                         ELSE
2139:                             IF VARTYPE(crSigCdPam.LibObss) = "L"
2140:                                 loc_lLibObss = crSigCdPam.LibObss
2141:                             ELSE
2142:                                 loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
2143:                             ENDIF
2144:                         ENDIF
2145:                     ENDIF
2146:                 ENDIF
2147:             ENDIF
2148:         ENDIF
2149:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2150:             THIS.txt_4c_PesoMedio.ReadOnly = !par_lHabilitar
2151:         ENDIF
2152:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
2153:             IF !par_lHabilitar
2154:                 THIS.grd_4c_Itens.ReadOnly = .T.
2155:             ELSE
2156:                 THIS.grd_4c_Itens.ReadOnly = .F.
2157:                 THIS.grd_4c_Itens.Column4.ReadOnly = !loc_lLibObss
2158:                 THIS.grd_4c_Itens.Column6.ReadOnly = .F.
2159:                 THIS.grd_4c_Itens.Column7.ReadOnly = !loc_lLibObss
2160:             ENDIF
2161:         ENDIF
2162:     ENDPROC
2163: 
2164:     *==========================================================================
2165:     * LimparCampos - Zera campos de entrada do form
2166:     * Form OPERACIONAL: zera peso medio e reposiciona grid no inicio
2167:     *==========================================================================
2168:     PROTECTED PROCEDURE LimparCampos()
2169:         THIS.this_lAlterou  = .F.
2170:         THIS.this_nOldValue = 0
2171:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2172:             THIS.txt_4c_PesoMedio.Value = 0
2173:         ENDIF
2174:         IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
2175:             SELECT xPesa
2176:             GO TOP
2177:             THIS.grd_4c_Itens.Refresh()
2178:         ENDIF
2179:     ENDPROC
2180: 
2181:     *==========================================================================
2182:     * BtnSalvarClick - Equivalente a BtnProcessarClick para forms OPERACIONAIS
2183:     * Confirma a pesagem e encerra o form (chamado pelo FormBase se necessario)
2184:     *==========================================================================
2185:     PROCEDURE BtnSalvarClick()
2186:         THIS.BtnProcessarClick()
2187:     ENDPROC
2188: 
2189:     *==========================================================================
2190:     * BtnBuscarClick - Recarrega/reposiciona o grid com os dados do cursor xPesa
2191:     * Form OPERACIONAL: sem busca por codigo; apenas refresh da lista de pecas
2192:     *==========================================================================
2193:     PROCEDURE BtnBuscarClick()
2194:         THIS.CarregarLista()
2195:     ENDPROC
2196: 
2197:     *==========================================================================
2198:     * BtnEncerrarClick - Equivalente a Cancelar para forms OPERACIONAIS
2199:     * Habilita form pai e fecha sem processar a pesagem
2200:     *==========================================================================
2201:     PROCEDURE BtnEncerrarClick()
2202:         THIS.BtnCancelarClick()
2203:     ENDPROC
2204: 
2205: ENDDEFINE


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

