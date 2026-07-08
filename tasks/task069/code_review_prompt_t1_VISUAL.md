# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 179: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 200: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 221: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 242: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecsm.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1624 linhas total):

*-- Linhas 7 a 15:
7: * Herda de : FormBase
8: *
9: * Filtros  : periodo, empresa, grupo (SigCdCrg), conta/vendedor (SigCdCli),
10: *            moeda (SigCdMoe), opcao de relatorio (4), checkbox comissao zerada
11: * Relatorios: SigReCs1 (nOpt=3), SigReCs2 (nOpt=1,2,4)
12: *==============================================================================
13: 
14: DEFINE CLASS Formsigrecsm AS FormBase
15: 

*-- Linhas 63 a 71:
63:                 THIS.this_oRelatorio = CREATEOBJECT("sigrecsmBO")
64: 
65:                 THIS.ConfigurarCabecalho()
66:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67:                 THIS.ConfigurarBotoes()
68:                 THIS.ConfigurarCampos()
69:                 THIS.ConfigurarBINDEVENTs()
70: 
71:                 THIS.InicializarValoresPadrao()

*-- Linhas 124 a 185:
124:     PROTECTED PROCEDURE ConfigurarCabecalho()
125:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH THIS.cnt_4c_Cabecalho
127:             .Top         = 0
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133:             .Visible     = .T.
134:         ENDWITH
135: 
136:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
137:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
138:             .Top       = 25
139:             .Left      = 20
140:             .AutoSize  = .T.
141:             .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
142:                          "o por Condi" + CHR(231) + CHR(227) + "o de Pagamento"
143:             .FontName  = "Tahoma"
144:             .FontSize  = 14
145:             .FontBold  = .T.
146:             .ForeColor = RGB(255, 255, 255)
147:             .BackStyle = 0
148:             .Visible   = .T.
149:         ENDWITH
150:         THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible = .T.
151:         THIS.cnt_4c_Cabecalho.Visible = .T.
152:     ENDPROC
153: 
154:     *--------------------------------------------------------------------------
155:     * ConfigurarBotoes - CommandGroup com 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
156:     *--------------------------------------------------------------------------
157:     PROTECTED PROCEDURE ConfigurarBotoes()
158:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
159:         WITH THIS.cmg_4c_Botoes
160:             .Top           = 0
161:             .Left          = 529
162:             .Width         = 273
163:             .Height        = 80
164:             .ButtonCount   = 4
165:             .BackStyle     = 0
166:             .BorderStyle   = 0
167:             .BorderColor   = RGB(136, 189, 188)
168:             .SpecialEffect = 1
169:             .Themes        = .F.
170:             .Visible       = .T.
171:         ENDWITH
172: 
173:         WITH THIS.cmg_4c_Botoes.Buttons(1)
174:             .Top             = 5
175:             .Left            = 5
176:             .Width           = 65
177:             .Height          = 70
178:             .Caption         = "Visualizar"
179:             .FontName        = "Comic Sans MS"
180:             .FontBold        = .T.
181:             .FontItalic      = .T.
182:             .FontSize        = 8
183:             .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
184:             .PicturePosition = 13
185:             .SpecialEffect   = 0

*-- Linhas 192 a 206:
192:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
193: 
194:         WITH THIS.cmg_4c_Botoes.Buttons(2)
195:             .Top             = 5
196:             .Left            = 71
197:             .Width           = 65
198:             .Height          = 70
199:             .Caption         = "Imprimir"
200:             .FontName        = "Comic Sans MS"
201:             .FontBold        = .T.
202:             .FontItalic      = .T.
203:             .FontSize        = 8
204:             .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
205:             .PicturePosition = 13
206:             .SpecialEffect   = 0

*-- Linhas 213 a 227:
213:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
214: 
215:         WITH THIS.cmg_4c_Botoes.Buttons(3)
216:             .Top             = 5
217:             .Left            = 137
218:             .Width           = 65
219:             .Height          = 70
220:             .Caption         = "Excel"
221:             .FontName        = "Comic Sans MS"
222:             .FontBold        = .T.
223:             .FontItalic      = .T.
224:             .FontSize        = 8
225:             .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
226:             .PicturePosition = 13
227:             .SpecialEffect   = 0

*-- Linhas 234 a 248:
234:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
235: 
236:         WITH THIS.cmg_4c_Botoes.Buttons(4)
237:             .Top             = 5
238:             .Left            = 203
239:             .Width           = 65
240:             .Height          = 70
241:             .Caption         = "Encerrar"
242:             .FontName        = "Comic Sans MS"
243:             .FontBold        = .T.
244:             .FontItalic      = .T.
245:             .FontSize        = 8
246:             .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
247:             .PicturePosition = 13
248:             .SpecialEffect   = 0

*-- Linhas 263 a 344:
263:     PROTECTED PROCEDURE ConfigurarCampos()
264: 
265:         *-- === PERIODO top=96/101 ===
266:         THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
267:         WITH THIS.lbl_4c_Lbl_periodo
268:             .Top       = 101
269:             .Left      = 169
270:             .AutoSize  = .T.
271:             .Caption   = "Per" + CHR(237) + "odo :"
272:             .FontName  = "Tahoma"
273:             .FontSize  = 8
274:             .BackStyle = 0
275:             .ForeColor = RGB(90, 90, 90)
276:             .Visible   = .T.
277:         ENDWITH
278: 
279:         THIS.AddObject("txt_4c__dt_inicial", "TextBox")
280:         WITH THIS.txt_4c__dt_inicial
281:             .Top           = 96
282:             .Left          = 218
283:             .Width         = 79
284:             .Height        = 25
285:             .FontName      = "Tahoma"
286:             .FontSize      = 9
287:             .Format        = "K"
288:             .SpecialEffect = 1
289:             .BorderColor   = RGB(100, 100, 100)
290:             .Value         = DATE()
291:             .Visible       = .T.
292:         ENDWITH
293: 
294:         THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
295:         WITH THIS.lbl_4c_Lbl_periodo_a
296:             .Top       = 103
297:             .Left      = 301
298:             .AutoSize  = .T.
299:             .Caption   = "a"
300:             .FontName  = "Tahoma"
301:             .FontSize  = 8
302:             .BackStyle = 0
303:             .ForeColor = RGB(90, 90, 90)
304:             .Visible   = .T.
305:         ENDWITH
306: 
307:         THIS.AddObject("txt_4c__dt_final", "TextBox")
308:         WITH THIS.txt_4c__dt_final
309:             .Top           = 96
310:             .Left          = 312
311:             .Width         = 79
312:             .Height        = 25
313:             .FontName      = "Tahoma"
314:             .FontSize      = 9
315:             .Format        = "K"
316:             .SpecialEffect = 1
317:             .BorderColor   = RGB(100, 100, 100)
318:             .Value         = DATE()
319:             .Visible       = .T.
320:         ENDWITH
321: 
322:         *-- === EMPRESA top=124/129 ===
323:         THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
324:         WITH THIS.lbl_4c_Lbl_empresa
325:             .Top       = 129
326:             .Left      = 164
327:             .AutoSize  = .T.
328:             .Caption   = "Empresa :"
329:             .FontName  = "Tahoma"
330:             .FontSize  = 8
331:             .BackStyle = 0
332:             .ForeColor = RGB(90, 90, 90)
333:             .Visible   = .T.
334:         ENDWITH
335: 
336:         THIS.AddObject("txt_4c__empresa", "TextBox")
337:         WITH THIS.txt_4c__empresa
338:             .Top           = 124
339:             .Left          = 218
340:             .Width         = 31
341:             .Height        = 25
342:             .FontName      = "Tahoma"
343:             .FontSize      = 9
344:             .Format        = "K!"

*-- Linhas 352 a 361:
352: 
353:         THIS.AddObject("txt_4c__empresa_desc", "TextBox")
354:         WITH THIS.txt_4c__empresa_desc
355:             .Top           = 124
356:             .Left          = 251
357:             .Width         = 290
358:             .Height        = 25
359:             .FontName      = "Tahoma"
360:             .FontSize      = 9
361:             .Format        = "K"

*-- Linhas 367 a 391:
367:         ENDWITH
368: 
369:         *-- === GRUPO (SigCdCrg) top=152/157 ===
370:         THIS.AddObject("lbl_4c_Lbl_grupo", "Label")
371:         WITH THIS.lbl_4c_Lbl_grupo
372:             .Top       = 157
373:             .Left      = 176
374:             .AutoSize  = .T.
375:             .Caption   = "Grupo :"
376:             .FontName  = "Tahoma"
377:             .FontSize  = 8
378:             .BackStyle = 0
379:             .ForeColor = RGB(90, 90, 90)
380:             .Visible   = .T.
381:         ENDWITH
382: 
383:         THIS.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
384:         WITH THIS.txt_4c__Cd_GrEstoque
385:             .Top           = 152
386:             .Left          = 218
387:             .Width         = 79
388:             .Height        = 25
389:             .FontName      = "Tahoma"
390:             .FontSize      = 9
391:             .Format        = "K!"

*-- Linhas 398 a 407:
398: 
399:         THIS.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
400:         WITH THIS.txt_4c__Ds_GrEstoque
401:             .Top           = 152
402:             .Left          = 299
403:             .Width         = 150
404:             .Height        = 25
405:             .FontName      = "Tahoma"
406:             .FontSize      = 9
407:             .Format        = "K"

*-- Linhas 413 a 437:
413:         ENDWITH
414: 
415:         *-- === CONTA / VENDEDOR (SigCdCli) top=180/185 ===
416:         THIS.AddObject("lbl_4c_Lbl_estoque", "Label")
417:         WITH THIS.lbl_4c_Lbl_estoque
418:             .Top       = 185
419:             .Left      = 176
420:             .AutoSize  = .T.
421:             .Caption   = "Conta :"
422:             .FontName  = "Tahoma"
423:             .FontSize  = 8
424:             .BackStyle = 0
425:             .ForeColor = RGB(90, 90, 90)
426:             .Visible   = .T.
427:         ENDWITH
428: 
429:         THIS.AddObject("txt_4c__cd_estoque", "TextBox")
430:         WITH THIS.txt_4c__cd_estoque
431:             .Top           = 180
432:             .Left          = 218
433:             .Width         = 79
434:             .Height        = 25
435:             .FontName      = "Tahoma"
436:             .FontSize      = 9
437:             .Format        = "K!"

*-- Linhas 444 a 453:
444: 
445:         THIS.AddObject("txt_4c__ds_estoque", "TextBox")
446:         WITH THIS.txt_4c__ds_estoque
447:             .Top           = 180
448:             .Left          = 299
449:             .Width         = 290
450:             .Height        = 25
451:             .FontName      = "Tahoma"
452:             .FontSize      = 9
453:             .Format        = "K"

*-- Linhas 459 a 483:
459:         ENDWITH
460: 
461:         *-- === MOEDA (SigCdMoe) top=208/213 ===
462:         THIS.AddObject("lbl_4c_Label6", "Label")
463:         WITH THIS.lbl_4c_Label6
464:             .Top       = 213
465:             .Left      = 173
466:             .AutoSize  = .T.
467:             .Caption   = "Moeda :"
468:             .FontName  = "Tahoma"
469:             .FontSize  = 8
470:             .BackStyle = 0
471:             .ForeColor = RGB(90, 90, 90)
472:             .Visible   = .T.
473:         ENDWITH
474: 
475:         THIS.AddObject("txt_4c_Cmoeda", "TextBox")
476:         WITH THIS.txt_4c_Cmoeda
477:             .Top           = 208
478:             .Left          = 218
479:             .Width         = 31
480:             .Height        = 25
481:             .FontName      = "Tahoma"
482:             .FontSize      = 9
483:             .Format        = "K!"

*-- Linhas 491 a 500:
491: 
492:         THIS.AddObject("txt_4c_Dmoeda", "TextBox")
493:         WITH THIS.txt_4c_Dmoeda
494:             .Top           = 208
495:             .Left          = 251
496:             .Width         = 115
497:             .Height        = 25
498:             .FontName      = "Tahoma"
499:             .FontSize      = 9
500:             .Format        = "K"

*-- Linhas 506 a 592:
506:         ENDWITH
507: 
508:         *-- === TIPO / OPCAO RELATORIO top=239/240 ===
509:         THIS.AddObject("lbl_4c_Lbl_tipo", "Label")
510:         WITH THIS.lbl_4c_Lbl_tipo
511:             .Top       = 239
512:             .Left      = 182
513:             .AutoSize  = .T.
514:             .Caption   = " Tipo :"
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .BackStyle = 0
518:             .ForeColor = RGB(90, 90, 90)
519:             .Visible   = .T.
520:         ENDWITH
521: 
522:         THIS.AddObject("obj_4c_OptRel", "OptionGroup")
523:         WITH THIS.obj_4c_OptRel
524:             .Top         = 240
525:             .Left        = 217
526:             .Width       = 463
527:             .Height      = 17
528:             .ButtonCount = 4
529:             .BackStyle   = 0
530:             .BorderStyle = 0
531:             .Value       = 1
532: 
533:             .Option1.Caption   = "Si\<nt" + CHR(233) + "tico"
534:             .Option1.FontName  = "Tahoma"
535:             .Option1.FontSize  = 8
536:             .Option1.BackStyle = 0
537:             .Option1.ForeColor = RGB(90, 90, 90)
538:             .Option1.Top       = 1
539:             .Option1.Left      = 1
540:             .Option1.Width     = 59
541:             .Option1.Height    = 15
542:             .Option1.AutoSize  = .T.
543: 
544:             .Option2.Caption   = "\<Anal" + CHR(237) + "tico"
545:             .Option2.FontName  = "Tahoma"
546:             .Option2.FontSize  = 8
547:             .Option2.BackStyle = 0
548:             .Option2.ForeColor = RGB(90, 90, 90)
549:             .Option2.Top       = 1
550:             .Option2.Left      = 80
551:             .Option2.Width     = 58
552:             .Option2.Height    = 15
553:             .Option2.AutoSize  = .T.
554: 
555:             .Option3.Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagamento"
556:             .Option3.FontName  = "Tahoma"
557:             .Option3.FontSize  = 8
558:             .Option3.BackStyle = 0
559:             .Option3.ForeColor = RGB(90, 90, 90)
560:             .Option3.Top       = 1
561:             .Option3.Left      = 162
562:             .Option3.Width     = 134
563:             .Option3.Height    = 15
564:             .Option3.AutoSize  = .T.
565: 
566:             .Option4.Caption   = "Comiss" + CHR(227) + "o dividida"
567:             .Option4.FontName  = "Tahoma"
568:             .Option4.FontSize  = 8
569:             .Option4.BackStyle = 0
570:             .Option4.ForeColor = RGB(90, 90, 90)
571:             .Option4.Top       = 1
572:             .Option4.Left      = 334
573:             .Option4.Width     = 131
574:             .Option4.Height    = 17
575:             .Option4.AutoSize  = .T.
576: 
577:             .Visible = .T.
578:         ENDWITH
579: 
580:         *-- === NAO INCLUIR COMISSAO ZERADA top=258 ===
581:         THIS.AddObject("chk_4c_FwChkComissao", "CheckBox")
582:         WITH THIS.chk_4c_FwChkComissao
583:             .Top           = 258
584:             .Left          = 218
585:             .AutoSize      = .T.
586:             .Alignment     = 0
587:             .Caption       = "N" + CHR(227) + "o incluir comiss" + CHR(227) + "o zerada"
588:             .Value         = 0
589:             .FontName      = "Tahoma"
590:             .FontSize      = 8
591:             .BackStyle     = 0
592:             .ForeColor     = RGB(90, 90, 90)


### BO (C:\4c\projeto\app\classes\sigrecsmBO.prg):
*==============================================================================
* SIGRECSMBO.PRG
* Business Object - Relatorio de Comissao por Condicao de Pagamento
* Herda de RelatorioBase
*
* Formulario original: SIGRECSM.SCX (frmrelatorio)
* Tabelas: SigMvCab, SigMvPar, SigCdOpe, SigOpFp, SigCdEmp, SigCdCli, SigCdCrg
* Relatorios FRX: SigReCs1 (Condicao Pgto), SigReCs2 (Sintetico/Analitico/Dividido)
*
* Cursores FRX (nomes fixos para compatibilidade):
*   cabecalho - cabecalho do relatorio (pNmEmp, pRelTitulo, pRelTitul2, pPeriodo)
*   tempo     - dados principais para nOpt=1,2,4
*   tempo2    - dados agrupados por condicao de pagamento para nOpt=3
*==============================================================================

DEFINE CLASS sigrecsmBO AS RelatorioBase

    *-- Filtros: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros: empresa (SigCdEmp - cemps / razas)
    this_cCemps         = ""
    this_cRazas         = ""

    *-- Filtros: grupo de vendedor (get_cd_grestoque / get_Ds_GrEstoque)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Filtros: vendedor / conta (get_cd_estoque / get_ds_estoque)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Filtros: moeda (SigCdMoe - cmoes / dmoes)
    this_cCmoes         = ""
    this_cDmoes         = ""

    *-- Opcao de relatorio: 1=Sintetico, 2=Analitico, 3=Cond.Pgto, 4=Comissao Dividida
    this_nOptRel        = 1

    *-- Nao incluir comissao zerada (FwChkComissao)
    this_lChkComissao   = .F.

    *-- Cursor de dados principal (nome FRX-compativel)
    this_cCursorDados       = "tempo"
    this_cCursorCabecalho   = "cabecalho"

    *-- Caminhos dos FRX
    *-- FRX1: nOpt=3 (Condicao de Pagamento)
    *-- FRX2: nOpt=1,2,4 (Sintetico, Analitico, Comissao Dividida)
    this_cCaminhoFrx1   = ""
    this_cCaminhoFrx2   = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cCaminhoFrx1 = gc_4c_CaminhoReports + "SigReCs1.frx"
            THIS.this_cCaminhoFrx2 = gc_4c_CaminhoReports + "SigReCs2.frx"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecsmBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa filtros e monta cursores para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado (SIGRECSM)
    *
    * Fluxo:
    *   1. Carrega SigCdCot em cursor_4c_CsmCot (para CarregarCambioCSM)
    *   2. Busca nome da empresa para cabecalho
    *   3. Cria cursor cabecalho com dados do titulo do relatorio
    *   4. SQLEXEC query principal (SigMvCab/Par/Ope/Fp/Emp/Cli/Crg) em cursor_4c_CsmTemp
    *   5. SELECT local de cursor_4c_CsmTemp para cursor tempo (por nOpt)
    *   6. Se this_lChkComissao: remove registros com comissao zero
    *   7. Se nOpt=3: JOIN com SigPrInf para agrupar por condicao pagto em tempo2
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cDGrupo, loc_cConta, loc_cCmoes, loc_cDmoes
        LOCAL loc_nOpt
        LOCAL loc_cDataIni, loc_cDataFim
        LOCAL loc_cEmpWhere, loc_cGrupoWhere, loc_cContaWhere
        LOCAL loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitul2, loc_cPeriodo
        LOCAL loc_cVerVendedor

        loc_lSucesso = .F.

        TRY
            *-- Le filtros do BO
            loc_cEmpresa = PADR(ALLTRIM(THIS.this_cCemps), 3)
            loc_cGrupo   = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
            loc_cDGrupo  = PADR(ALLTRIM(THIS.this_cDsGrEstoque), 20)
            loc_cConta   = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
            loc_cCmoes   = PADR(ALLTRIM(THIS.this_cCmoes), 3)
            loc_cDmoes   = PADR(ALLTRIM(THIS.this_cDmoes), 15)
            loc_nOpt     = THIS.this_nOptRel

            *-- Formata datas para SQL Server
            loc_cDataIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDataFim = "'" + STR(YEAR(THIS.this_dDtFinal), 4) + "-" + ;
                           PADL(LTRIM(STR(MONTH(THIS.this_dDtFinal))), 2, "0") + "-" + ;
                           PADL(LTRIM(STR(DAY(THIS.this_dDtFinal))), 2, "0") + " 23:59:59'"

            *-- ================================================================
            *-- STEP 1: Carrega cotacoes para conversao de moeda (CarregarCambioCSM)
            *-- ================================================================
            IF USED("cursor_4c_CsmCot")
                USE IN cursor_4c_CsmCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", ;
                "cursor_4c_CsmCot")
            IF loc_nResult > 0
                SELECT cursor_4c_CsmCot
                INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            ENDIF

            *-- ================================================================
            *-- STEP 2: Busca nome da empresa para cabecalho do relatorio
            *-- ================================================================
            loc_cNomeEmpresa = ""
            IF USED("cursor_4c_CsmEmp")
                USE IN cursor_4c_CsmEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(ALLTRIM(loc_cEmpresa)), ;
                "cursor_4c_CsmEmp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_CsmEmp")
                SELECT cursor_4c_CsmEmp
                loc_cNomeEmpresa = ALLTRIM(cursor_4c_CsmEmp.razas)
            ENDIF

            *-- ================================================================
            *-- STEP 3: Monta strings do cabecalho e cria cursor cabecalho
            *-- ================================================================
            loc_cRelTitulo = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                             "o de Vendedor por Condi" + CHR(231) + CHR(227) + ;
                             "o de Pagamento"
            loc_cRelTitul2 = "Relat" + CHR(243) + "rio " + ;
                             IIF(loc_nOpt = 1, "Sint" + CHR(233) + "tico", ;
                             IIF(loc_nOpt = 2, "Anal" + CHR(237) + "tico", ;
                             "Tipo Cond.Pagto")) + "  -  " + ;
                             IIF(EMPTY(ALLTRIM(loc_cGrupo)), ;
                             "Todos os Grupos", ;
                             "Grupo :" + ALLTRIM(loc_cGrupo) + ;
                             " - " + ALLTRIM(loc_cDGrupo)) + "  -  " + ;
                             ALLTRIM(loc_cCmoes) + "- " + ALLTRIM(loc_cDmoes)
            loc_cPeriodo   = "Per" + CHR(237) + "odo: " + ;
                             DTOC(THIS.this_dDtInicial) + ;
                             " " + CHR(160) + " " + DTOC(THIS.this_dDtFinal)

            IF USED("cabecalho")
                USE IN cabecalho
            ENDIF
            CREATE CURSOR cabecalho ;
                (pNmEmp C(80), pRelTitulo C(80), pRelTitul2 C(80), pPeriodo C(80))
            INSERT INTO cabecalho (pNmEmp, pRelTitulo, pRelTitul2, pPeriodo) ;
                VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitul2, loc_cPeriodo)

            *-- ================================================================
            *-- STEP 4: Query principal contra SQL Server
            *-- ================================================================
            loc_cEmpWhere   = IIF(EMPTY(ALLTRIM(loc_cEmpresa)), "", ;
                              " AND a.emps = " + EscaparSQL(ALLTRIM(loc_cEmpresa)))
            loc_cGrupoWhere = IIF(EMPTY(ALLTRIM(loc_cGrupo)) OR loc_nOpt = 4, "", ;
                              " AND (a.GrVends = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ;
                              " OR a.GrResps = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ")")
            loc_cContaWhere = IIF(EMPTY(ALLTRIM(loc_cConta)) OR loc_nOpt = 4, "", ;
                              " AND (a.Vends = " + EscaparSQL(ALLTRIM(loc_cConta)) + ;
                              " OR a.Resps = " + EscaparSQL(ALLTRIM(loc_cConta)) + ")")

            IF USED("cursor_4c_CsmTemp")
                USE IN cursor_4c_CsmTemp
            ENDIF

            loc_cSQL = "SELECT a.emps, a.vends, a.datas," + ;
                       " a.dopes, a.numes, a.empdopnums," + ;
                       " b.copers, c.Trocos, c.fpcomiss," + ;
                       " c.fpags, c.infos, d.valos," + ;
                       " d.Moefpgs, d.cotfpgs, e.razas," + ;
                       " f.iClis, f.rclis, f.CCargs," + ;
                       " g.FComis, g.acomis," + ;
                       " a.Resps, h.rclis AS DResps," + ;
                       " h.Ccargs AS CcargResps, a.grvends" + ;
                       " FROM SigMvCab a" + ;
                       " INNER JOIN SigMvPar d ON d.empdopnums = a.empdopnums" + ;
                       " INNER JOIN SigCdOpe b ON d.dopes = b.dopes" + ;
                       " AND b.ccomis = 1" + ;
                       " INNER JOIN SigOpFp c ON d.fpags = c.fpags" + ;
                       " AND c.bxcomis = 1" + ;
                       " INNER JOIN SigCdEmp e ON a.emps = e.cemps" + ;
                       " LEFT JOIN SigCdCli h ON a.Resps = h.Iclis" + ;
                       " LEFT JOIN SigCdCli f ON a.Vends = f.iclis" + ;
                       " LEFT JOIN SigCdCrg g ON f.ccargs = g.ccargs" + ;
                       " WHERE a.datas BETWEEN " + loc_cDataIni + ;
                       " AND " + loc_cDataFim + ;
                       loc_cEmpWhere + loc_cGrupoWhere + loc_cContaWhere + ;
                       " ORDER BY a.emps, a.vends, a.datas," + ;
                       " a.dopes, a.numes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmTemp")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de comiss" + CHR(227) + "o"
                MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados")
                loc_lSucesso = .F.
            ENDIF

            *-- ================================================================
            *-- STEP 5: Processa cursor temporario conforme opcao do relatorio
            *-- ================================================================
            IF USED("tempo")
                USE IN tempo
            ENDIF

            IF loc_nOpt = 1
                *-- Sintetico: vendedor como vends + UNION com responsavel (Resps)
                SELECT vends, datas, emps, fpcomiss, fpags, ;
                       rclis, razas, rclis AS nvens, CCargs, infos, ;
                       FComis, acomis, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots, ;
                       "S" AS OptRel ;
                FROM cursor_4c_CsmTemp ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ;
                UNION ;
                SELECT Resps AS vends, datas, emps, fpcomiss, fpags, ;
                       DResps AS rclis, razas, DResps AS nvens, ;
                       CcargResps AS CCargs, infos, ;
                       FComis, acomis, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots, ;
                       "S" AS OptRel ;
                FROM cursor_4c_CsmTemp ;
                WHERE !EMPTY(Resps) AND vends <> Resps ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ;
                ORDER BY 3, 1, 2, 5 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            IF INLIST(loc_nOpt, 2, 3)
                *-- Analitico / Condicao Pagto: inclui dopes e numes no agrupamento
                SELECT dopes, vends, datas, emps, numes, fpcomiss, fpags, ;
                       rclis, razas, rclis AS nvens, CCargs, infos, ;
                       FComis, acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots ;
                FROM cursor_4c_CsmTemp ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                UNION ;
                SELECT dopes, Resps AS vends, datas, emps, numes, fpcomiss, fpags, ;
                       DResps AS rclis, razas, DResps AS nvens, ;
                       CcargResps AS CCargs, infos, ;
                       FComis, acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots ;
                FROM cursor_4c_CsmTemp ;
                WHERE !EMPTY(Resps) AND vends <> Resps ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY 4, 2, 3, 1, 5, 7 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            IF loc_nOpt = 4
                *-- Comissao dividida: usa grade de comissoes (SigCdCmm) como base
                loc_cVerVendedor = IIF(EMPTY(ALLTRIM(loc_cGrupo)), "", ;
                                   " AND ALLTRIM(a.grvends) = '" + ;
                                   ALLTRIM(loc_cGrupo) + "'")
                loc_cVerVendedor = loc_cVerVendedor + ;
                                   IIF(EMPTY(ALLTRIM(loc_cConta)), "", ;
                                   " AND ALLTRIM(b.contas) = '" + ;
                                   ALLTRIM(loc_cConta) + "'")

                IF USED("cursor_4c_CsmCmm1")
                    USE IN cursor_4c_CsmCmm1
                ENDIF
                loc_cSQL = "SELECT a.*, b.rclis AS nvens" + ;
                           " FROM SigCdCmm a, SigCdCli b" + ;
                           " WHERE a.datas BETWEEN " + loc_cDataIni + ;
                           " AND " + loc_cDataFim + ;
                           " AND a.contas = b.iclis"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmCmm1")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar SigCdCmm"
                    MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados (nOpt=4)")
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_CsmCmm2")
                    USE IN cursor_4c_CsmCmm2
                ENDIF
                SELECT empdopnums, COUNT(contas) AS qtdv ;
                FROM cursor_4c_CsmCmm1 ;
                GROUP BY empdopnums ;
                INTO CURSOR cursor_4c_CsmCmm2

                IF USED("cursor_4c_CsmCdCmm")
                    USE IN cursor_4c_CsmCdCmm
                ENDIF
                SELECT a.*, b.qtdv ;
                FROM cursor_4c_CsmCmm1 a, cursor_4c_CsmCmm2 b ;
                WHERE a.empdopnums = b.empdopnums ;
                INTO CURSOR cursor_4c_CsmCdCmm

                SELECT a.dopes, b.contas AS vends, a.datas, a.emps, a.numes, ;
                       a.fpcomiss, a.fpags, a.rclis, a.razas, b.nvens, ;
                       a.CCargs, a.infos, a.FComis, ;
                       b.percs AS acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(a.CCargs) AND !ISNULL(a.FComis) AND a.FComis = "S", ;
                           b.percs / 100.0, 1.0) AS fatComis, ;
                       SUM(a.valos / b.qtdv * a.cotfpgs / ;
                           CarregarCambioCSM(loc_cCmoes, a.datas)) AS tots ;
                FROM cursor_4c_CsmTemp a, cursor_4c_CsmCdCmm b ;
                WHERE a.empdopnums = b.empdopnums &loc_cVerVendedor ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY 4, 2, 3, 1, 5, 7 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            *-- ================================================================
            *-- STEP 6: Filtro de comissao zerada (FwChkComissao)
            *-- SET DELETED ON (config.prg) ignora registros deletados no REPORT
            *-- ================================================================
            IF THIS.this_lChkComissao AND USED("tempo") AND RECCOUNT("tempo") > 0
                SELECT tempo
                DELETE FROM tempo WHERE ROUND(tots * fpcomiss * fatComis / 100.0, 2) = 0
            ENDIF

            *-- ================================================================
            *-- STEP 7: Para nOpt=3, agrupa por condicao de pagamento (SigPrInf)
            *-- ================================================================
            IF loc_nOpt = 3
                IF USED("cursor_4c_CsmInf")
                    USE IN cursor_4c_CsmInf
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigPrInf", "cursor_4c_CsmInf")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar SigPrInf"
                    MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados (nOpt=3)")
                    loc_lSucesso = .F.
                ENDIF

                IF USED("tempo2")
                    USE IN tempo2
                ENDIF
                SELECT a.emps, a.vends, MAX(a.nvens) AS nvens, ;
                       a.infos, MAX(b.descrs) AS descrs, ;
                       SUM(tots) AS tots, ;
                       MAX(a.razas) AS razas, MAX(a.CCargs) AS ccargs ;
                FROM tempo a, cursor_4c_CsmInf b ;
                WHERE a.infos = b.infos ;
                GROUP BY 1, 2, 4 ;
                ORDER BY 1, 2, 5 ;
                INTO CURSOR tempo2
            ENDIF

            SELECT tempo
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.PrepararDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptRel = 3
                    REPORT FORM (THIS.this_cCaminhoFrx1) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cCaminhoFrx2) TO PRINTER PROMPT NOCONSOLE
                ENDIF
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptRel = 3
                    REPORT FORM (THIS.this_cCaminhoFrx1) PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cCaminhoFrx2) PREVIEW NOCONSOLE
                ENDIF
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOC(THIS.this_dDtInicial) + "|" + DTOC(THIS.this_dDtFinal) + ;
               "|" + ALLTRIM(THIS.this_cCemps) + "|" + ;
               STR(THIS.this_nOptRel, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + ;
                                  "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + ;
                                  "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores locais criados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores[9], loc_i
        loc_aCursores[1] = "cursor_4c_CsmTemp"
        loc_aCursores[2] = "cursor_4c_CsmCot"
        loc_aCursores[3] = "cursor_4c_CsmEmp"
        loc_aCursores[4] = "cursor_4c_CsmCmm1"
        loc_aCursores[5] = "cursor_4c_CsmCmm2"
        loc_aCursores[6] = "cursor_4c_CsmCdCmm"
        loc_aCursores[7] = "cursor_4c_CsmInf"
        loc_aCursores[8] = "cabecalho"
        loc_aCursores[9] = "tempo"

        FOR loc_i = 1 TO 9
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        ENDFOR

        IF USED("tempo2")
            USE IN tempo2
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* CarregarCambioCSM - UDF standalone para calculo de cambio
* Equivalente a fCarregarCambio() do sistema legado, especifico para sigrecsmBO
* Acessivel de dentro de SELECT VFP (nao pode ser metodo de objeto)
*
* Acessa cursor_4c_CsmCot (carregado por sigrecsmBO.PrepararDados)
* Retorna cotacao da moeda na data informada (ou na data imediatamente anterior)
*==============================================================================
FUNCTION CarregarCambioCSM(par_cMoeda, par_dData)
    LOCAL loc_nCotacao, loc_cMoeda, loc_dData

    loc_nCotacao = 1

    IF VARTYPE(par_cMoeda) <> "C" OR EMPTY(par_cMoeda)
        RETURN 1
    ENDIF

    loc_cMoeda = PADR(ALLTRIM(par_cMoeda), 3)

    DO CASE
        CASE VARTYPE(par_dData) = "D"
            loc_dData = par_dData
        CASE VARTYPE(par_dData) = "T"
            loc_dData = TTOD(par_dData)
        OTHERWISE
            loc_dData = DATE()
    ENDCASE

    IF USED("cursor_4c_CsmCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(loc_dData)
        SELECT cursor_4c_CsmCot
        SET ORDER TO CMoeData

        *-- Busca exata na data
        IF SEEK(loc_cMoeda + DTOS(loc_dData))
            loc_nCotacao = cursor_4c_CsmCot.Valos
        ELSE
            *-- Nao encontrou: busca com NEAR para posicionar no mais proximo
            SET NEAR ON
            SEEK(loc_cMoeda + DTOS(loc_dData))
            SET NEAR OFF
            *-- Volta um registro para pegar a taxa mais recente anterior
            IF !BOF()
                SKIP -1
            ENDIF
            IF !BOF() AND ALLTRIM(cursor_4c_CsmCot.CMoes) = ALLTRIM(loc_cMoeda)
                loc_nCotacao = cursor_4c_CsmCot.Valos
            ENDIF
        ENDIF
    ENDIF

    RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
ENDFUNC

