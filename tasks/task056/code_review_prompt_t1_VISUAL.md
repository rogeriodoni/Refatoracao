# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Custo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TotItens' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECMV.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1413 linhas total):

*-- Linhas 12 a 20:
12: *     Grupo: codigo + descricao (SigCdGcr.codigos / descrs)
13: *     Conta: codigo + descricao (SigCdCli.iclis / rclis)
14: *
15: * Posicoes: Page1.Top = Form.Top_original - PageFrame.Top(85)
16: *==============================================================================
17: 
18: DEFINE CLASS FormSIGRECMV AS FormBase
19: 
20:     *-- Dimensoes exatas do original: Width=800, Height=400

*-- Linhas 55 a 63:
55:         loc_lContinuar = .T.
56: 
57:         TRY
58:             THIS.Caption = "CMV - Custo M" + CHR(233) + "dio de Venda"
59: 
60:             IF TYPE("gc_4c_CaminhoIcones") = "U"
61:                 gc_4c_CaminhoIcones = ""
62:             ENDIF
63:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 85 a 94:
85:             IF loc_lContinuar
86:                 THIS.ConfigurarCabecalho()
87:                 THIS.ConfigurarPageFrame()
88:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
89:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
90:                 THIS.ConfigurarPaginaLista()
91:                 THIS.ConfigurarPaginaDados()
92:                 THIS.LimparCampos()
93:                 loc_lSucesso = .T.
94:             ENDIF

*-- Linhas 114 a 179:
114:         loc_oCab = THIS.cnt_4c_Cabecalho
115: 
116:         WITH loc_oCab
117:             .Top         = 0
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 80
121:             .BackStyle   = 1
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125: 
126:             .AddObject("lbl_4c_Sombra", "Label")
127:             WITH .lbl_4c_Sombra
128:                 .Top       = 22
129:                 .Left      = 22
130:                 .Width     = THIS.Width
131:                 .Height    = 30
132:                 .Caption   = "CMV - Custo M" + CHR(233) + "dio de Venda"
133:                 .FontName  = "Tahoma"
134:                 .FontSize  = 14
135:                 .FontBold  = .T.
136:                 .ForeColor = RGB(0, 0, 0)
137:                 .BackStyle = 0
138:                 .Visible   = .T.
139:             ENDWITH
140: 
141:             .AddObject("lbl_4c_Titulo", "Label")
142:             WITH .lbl_4c_Titulo
143:                 .Top       = 20
144:                 .Left      = 20
145:                 .Width     = THIS.Width
146:                 .Height    = 30
147:                 .Caption   = "CMV - Custo M" + CHR(233) + "dio de Venda"
148:                 .FontName  = "Tahoma"
149:                 .FontSize  = 14
150:                 .FontBold  = .T.
151:                 .ForeColor = RGB(255, 255, 255)
152:                 .BackStyle = 0
153:                 .Visible   = .T.
154:             ENDWITH
155: 
156:             *-- CommandGroup com 4 botoes (framework frmrelatorio)
157:             *   Lefts dos botoes: 5, 71, 137, 203 (incremento 66, Width=65 cada)
158:             .AddObject("cmg_4c_Botoes", "CommandGroup")
159:             WITH .cmg_4c_Botoes
160:                 .Top           = 0
161:                 .Left          = 527
162:                 .Width         = THIS.Width
163:                 .Height        = 80
164:                 .ButtonCount   = 4
165:                 .BackStyle     = 0
166:                 .BorderColor   = RGB(136, 189, 188)
167:                 .SpecialEffect = 1
168:                 .Themes        = .F.
169:                 .Visible       = .T.
170: 
171:                 WITH .Buttons(1)
172:                     .Caption         = "Visualizar"
173:                     .Top             = 5
174:                     .Left            = 5
175:                     .Width           = THIS.Width
176:                     .Height          = 70
177:                     .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
178:                     .PicturePosition = 13
179:                     .FontBold        = .T.

*-- Linhas 186 a 196:
186:                 ENDWITH
187: 
188:                 WITH .Buttons(2)
189:                     .Caption         = "Imprimir"
190:                     .Top             = 5
191:                     .Left            = 71
192:                     .Width           = THIS.Width
193:                     .Height          = 70
194:                     .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
195:                     .PicturePosition = 13
196:                     .FontName        = "Tahoma"

*-- Linhas 205 a 215:
205:                 ENDWITH
206: 
207:                 WITH .Buttons(3)
208:                     .Caption         = "Doc. Excel"
209:                     .Top             = 5
210:                     .Left            = 137
211:                     .Width           = THIS.Width
212:                     .Height          = 70
213:                     .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
214:                     .PicturePosition = 13
215:                     .FontName        = "Tahoma"

*-- Linhas 224 a 234:
224:                 ENDWITH
225: 
226:                 WITH .Buttons(4)
227:                     .Caption         = "Sair"
228:                     .Top             = 5
229:                     .Left            = 203
230:                     .Width           = THIS.Width
231:                     .Height          = 70
232:                     .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
233:                     .PicturePosition = 13
234:                     .Cancel          = .T.

*-- Linhas 255 a 316:
255:     *--------------------------------------------------------------------------
256:     * ConfigurarPageFrame - PageFrame com 1 pagina de filtros
257:     *   Form: Width=800, Height=400
258:     *   Cabecalho Height=80; PageFrame.Top=85, Height=315
259:     *--------------------------------------------------------------------------
260:     PROTECTED PROCEDURE ConfigurarPageFrame()
261:         LOCAL loc_oPgf
262:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
263:         loc_oPgf = THIS.pgf_4c_Paginas
264: 
265:         loc_oPgf.PageCount = 1
266:         loc_oPgf.Top       = 85
267:         loc_oPgf.Left      = -1
268:         loc_oPgf.Width     = THIS.Width + 2
269:         loc_oPgf.Height    = THIS.Height - 85
270:         loc_oPgf.Tabs      = .F.
271: 
272:         loc_oPgf.Page1.Caption   = "Filtros"
273:         loc_oPgf.Page1.FontName  = "Tahoma"
274:         loc_oPgf.Page1.FontSize  = 8
275:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
276:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
277:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
278: 
279:         loc_oPgf.Visible    = .T.
280:         loc_oPgf.ActivePage = 1
281:     ENDPROC
282: 
283:     *--------------------------------------------------------------------------
284:     * ConfigurarPaginaLista - Controles de filtro na Page1
285:     *   Posicoes: Page1.Top = Form.Top_original - PageFrame.Top(85)
286:     *   Secoes: Periodo (Mes/Ano), Moeda, Operacao CMV, Custo Geral (Grupo/Conta)
287:     *--------------------------------------------------------------------------
288:     PROTECTED PROCEDURE ConfigurarPaginaLista()
289:         LOCAL loc_oPagina
290:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
291: 
292:         *-- ===== PERIODO: Mes / Ano (orig top=131/128 -> pg top=46/43) =====
293: 
294:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
295:         WITH loc_oPagina.lbl_4c_Periodo
296:             .Top       = 46
297:             .Left      = 199
298:             .Width     = 28
299:             .Height    = 18
300:             .Caption   = "M" + CHR(234) + "s :"
301:             .FontName  = "Tahoma"
302:             .FontSize  = 8
303:             .ForeColor = RGB(90, 90, 90)
304:             .BackStyle = 0
305:             .Visible   = .T.
306:         ENDWITH
307: 
308:         loc_oPagina.AddObject("txt_4c_Mes", "TextBox")
309:         WITH loc_oPagina.txt_4c_Mes
310:             .Top           = 43
311:             .Left          = 231
312:             .Width         = 24
313:             .Height        = 21
314:             .Value         = ""
315:             .MaxLength     = 2
316:             .InputMask     = "99"

*-- Linhas 323 a 348:
323:         ENDWITH
324:         BINDEVENT(loc_oPagina.txt_4c_Mes, "KeyPress", THIS, "TeclaMes")
325: 
326:         loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
327:         WITH loc_oPagina.lbl_4c_PeriodoA
328:             .Top       = 45
329:             .Left      = 267
330:             .Width     = 28
331:             .Height    = 18
332:             .Caption   = "Ano :"
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:             .ForeColor = RGB(90, 90, 90)
336:             .BackStyle = 0
337:             .Visible   = .T.
338:         ENDWITH
339: 
340:         loc_oPagina.AddObject("txt_4c_Ano", "TextBox")
341:         WITH loc_oPagina.txt_4c_Ano
342:             .Top           = 43
343:             .Left          = 298
344:             .Width         = 38
345:             .Height        = 21
346:             .Value         = ""
347:             .MaxLength     = 4
348:             .InputMask     = "9999"

*-- Linhas 356 a 381:
356: 
357:         *-- ===== MOEDA: Codigo + Descricao (orig top=162/159 -> pg top=77/74) =====
358: 
359:         loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
360:         WITH loc_oPagina.lbl_4c_Moeda
361:             .Top       = 77
362:             .Left      = 183
363:             .Width     = 44
364:             .Height    = 15
365:             .Caption   = "Moeda : "
366:             .FontName  = "Tahoma"
367:             .FontSize  = 8
368:             .ForeColor = RGB(90, 90, 90)
369:             .BackStyle = 0
370:             .Visible   = .T.
371:         ENDWITH
372: 
373:         loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
374:         WITH loc_oPagina.txt_4c_CdMoeda
375:             .Top           = 74
376:             .Left          = 231
377:             .Width         = 31
378:             .Height        = 21
379:             .Value         = ""
380:             .MaxLength     = 10
381:             .SpecialEffect = 1

*-- Linhas 390 a 399:
390: 
391:         loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
392:         WITH loc_oPagina.txt_4c_DsMoeda
393:             .Top           = 74
394:             .Left          = 264
395:             .Width         = 115
396:             .Height        = 21
397:             .Value         = ""
398:             .MaxLength     = 60
399:             .SpecialEffect = 1

*-- Linhas 410 a 456:
410: 
411:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
412:         WITH loc_oPagina.shp_4c_Shape2
413:             .Top     = 112
414:             .Left    = 175
415:             .Width   = 246
416:             .Height  = 49
417:             .Visible = .T.
418:         ENDWITH
419: 
420:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
421:         WITH loc_oPagina.lbl_4c_Label2
422:             .Top       = 115
423:             .Left      = 182
424:             .Width     = 137
425:             .Height    = 18
426:             .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o da produ" + CHR(231) + CHR(227) + "o"
427:             .FontName  = "Tahoma"
428:             .FontSize  = 8
429:             .ForeColor = RGB(90, 90, 90)
430:             .BackStyle = 0
431:             .Visible   = .T.
432:         ENDWITH
433: 
434:         loc_oPagina.AddObject("lbl_4c_Dopes", "Label")
435:         WITH loc_oPagina.lbl_4c_Dopes
436:             .Top       = 138
437:             .Left      = 194
438:             .Width     = 56
439:             .Height    = 18
440:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
441:             .FontName  = "Tahoma"
442:             .FontSize  = 8
443:             .ForeColor = RGB(90, 90, 90)
444:             .BackStyle = 0
445:             .Visible   = .T.
446:         ENDWITH
447: 
448:         loc_oPagina.AddObject("txt_4c_NmOperacao", "TextBox")
449:         WITH loc_oPagina.txt_4c_NmOperacao
450:             .Top           = 135
451:             .Left          = 260
452:             .Width         = 150
453:             .Height        = 21
454:             .Value         = ""
455:             .MaxLength     = 20
456:             .SpecialEffect = 1

*-- Linhas 467 a 515:
467: 
468:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
469:         WITH loc_oPagina.shp_4c_Shape1
470:             .Top     = 174
471:             .Left    = 174
472:             .Width   = 481
473:             .Height  = 72
474:             .Visible = .T.
475:         ENDWITH
476: 
477:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
478:         WITH loc_oPagina.lbl_4c_Label1
479:             .Top       = 177
480:             .Left      = 181
481:             .Width     = 66
482:             .Height    = 18
483:             .Caption   = "Custo geral"
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .ForeColor = RGB(90, 90, 90)
487:             .BackStyle = 0
488:             .Visible   = .T.
489:         ENDWITH
490: 
491:         *-- Grupo custo: codigo (orig top=281 -> pg top=196) + descricao (mesma linha)
492: 
493:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
494:         WITH loc_oPagina.lbl_4c_Label15
495:             .Top       = 199
496:             .Left      = 214
497:             .Width     = 38
498:             .Height    = 18
499:             .Caption   = "Grupo :"
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .ForeColor = RGB(90, 90, 90)
503:             .BackStyle = 0
504:             .Visible   = .T.
505:         ENDWITH
506: 
507:         loc_oPagina.AddObject("txt_4c_GrupoMov", "TextBox")
508:         WITH loc_oPagina.txt_4c_GrupoMov
509:             .Top           = 196
510:             .Left          = 260
511:             .Width         = 80
512:             .Height        = 21
513:             .Value         = ""
514:             .MaxLength     = 20
515:             .SpecialEffect = 1

*-- Linhas 524 a 533:
524: 
525:         loc_oPagina.AddObject("txt_4c_DGrupoMov", "TextBox")
526:         WITH loc_oPagina.txt_4c_DGrupoMov
527:             .Top           = 196
528:             .Left          = 342
529:             .Width         = 304
530:             .Height        = 21
531:             .Value         = ""
532:             .MaxLength     = 60
533:             .ReadOnly      = .T.

*-- Linhas 543 a 568:
543: 
544:         *-- Conta estoque: codigo (orig top=304 -> pg top=219) + descricao
545: 
546:         loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
547:         WITH loc_oPagina.lbl_4c_Estoque
548:             .Top       = 222
549:             .Left      = 215
550:             .Width     = 38
551:             .Height    = 18
552:             .Caption   = "Conta :"
553:             .FontName  = "Tahoma"
554:             .FontSize  = 8
555:             .ForeColor = RGB(90, 90, 90)
556:             .BackStyle = 0
557:             .Visible   = .T.
558:         ENDWITH
559: 
560:         loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
561:         WITH loc_oPagina.txt_4c_CdEstoque
562:             .Top           = 219
563:             .Left          = 260
564:             .Width         = 80
565:             .Height        = 21
566:             .Value         = ""
567:             .MaxLength     = 20
568:             .SpecialEffect = 1

*-- Linhas 577 a 586:
577: 
578:         loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
579:         WITH loc_oPagina.txt_4c_DsEstoque
580:             .Top           = 219
581:             .Left          = 342
582:             .Width         = 304
583:             .Height        = 21
584:             .Value         = ""
585:             .MaxLength     = 80
586:             .ReadOnly      = .T.

*-- Linhas 613 a 629:
613:             loc_oPg = THIS.pgf_4c_Paginas.Page1
614:             IF VARTYPE(THIS.this_oRelatorio) = "O"
615:                 WITH THIS.this_oRelatorio
616:                     loc_oPg.txt_4c_Mes.Value        = .this_cMes
617:                     loc_oPg.txt_4c_Ano.Value        = .this_cAno
618:                     loc_oPg.txt_4c_NmOperacao.Value = .this_cNmOperacao
619:                     loc_oPg.txt_4c_GrupoMov.Value   = .this_cGrupoMov
620:                     loc_oPg.txt_4c_DGrupoMov.Value  = .this_cDGrupoMov
621:                     loc_oPg.txt_4c_CdEstoque.Value  = .this_cCdEstoque
622:                     loc_oPg.txt_4c_DsEstoque.Value  = .this_cDsEstoque
623:                     loc_oPg.txt_4c_CdMoeda.Value    = .this_cCdMoeda
624:                     loc_oPg.txt_4c_DsMoeda.Value    = .this_cDsMoeda
625:                 ENDWITH
626:             ELSE
627:                 WITH loc_oPg
628:                     .txt_4c_Mes.Value        = ""
629:                     .txt_4c_Ano.Value        = ""


### BO (C:\4c\projeto\app\classes\SIGRECMVBO.prg):
*==============================================================================
* SIGRECMVBO.PRG
* Business Object para Relatorio CMV - Custo Medio de Venda
*
* Herda de: RelatorioBase
* Tabela: SigCdCmv
* Chave: pkchaves = PADR(cpros,14) + PADL(mes,2,'0') + PADL(ano,4,'0')
* Relatorio: SigReCmv.frx
*==============================================================================

DEFINE CLASS SIGRECMVBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigCdCmv"
    this_cCampoChave    = "pkchaves"
    this_cMensagemErro  = ""

    *-- Filtros do formulario
    this_cMes           = ""    && Mes do calculo (formato "MM")
    this_cAno           = ""    && Ano do calculo (formato "YYYY")
    this_cNmOperacao    = ""    && Codigo da operacao de finalizacao da producao
    this_cGrupoMov      = ""    && Codigo do grupo de custo - credito (SigCdGcr.codigos)
    this_cDGrupoMov     = ""    && Descricao do grupo de custo - debito (SigCdGcr.descrs)
    this_cCdEstoque     = ""    && Codigo da conta de estoque (SigCdCli.iclis)
    this_cDsEstoque     = ""    && Descricao da conta de estoque (SigCdCli.rclis)
    this_cCdMoeda       = ""    && Codigo da moeda de conversao (SigCdMoe.CMoes)
    this_cDsMoeda       = ""    && Descricao da moeda (SigCdMoe.DMoes)

    *-- Valores calculados durante o processamento
    this_nCustoGrama    = 0     && Custo por grama produzida (lnCusGr no legado)
    this_nTotalCusto    = 0     && Total do custo de producao no periodo
    this_nTotalPeso     = 0     && Total do peso dos itens produzidos
    this_nTotalQtd      = 0     && Total de quantidade dos itens produzidos

    *-- Propriedades de registro SigCdCmv (CRUD individual)
    this_cPkChaves      = ""    && Chave primaria (cpros+mes+ano)
    this_cCpros         = ""    && Codigo do produto
    this_cDatas         = ""    && Periodo "MM/AAAA"
    this_cMoedas        = ""    && Codigo da moeda
    this_nValCuss       = 0     && Valor do custo unitario

    *-- Cursores de trabalho
    this_cCursorDados   = "crVenda"      && Cursor principal para o relatorio
    this_cCursorOpe     = "crSigCdOpe"   && Operacoes CMV filtradas
    this_cCursorPac     = "crSigCdPac"   && Configuracao padrao PAC
    this_cCursorCmv     = "crSigCdCmv"   && Cursor para gravacao em SigCdCmv

    *-- Configuracao do relatorio
    this_cCaminhoFRX    = ""
    this_cTitulo        = ""

    *--------------------------------------------------------------------------
    * Init - Configura titulo e caminho FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTitulo     = "CMV - Custo da Mercadoria Vendida"
            THIS.this_cCaminhoFRX = gc_4c_CaminhoReports + "SigReCmv.frx"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosIniciais - Carrega cursores SigCdOpe/SigCdPac e define
    * valores default para os campos do formulario nas propriedades this_*
    * Retorna .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosIniciais()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                *-- Carrega operacoes CMV (SigCdOpe filtrada por SigCdTom)
                loc_cSQL = "SELECT a.dopes FROM SigCdOpe a " + ;
                           "INNER JOIN SigCdTom b ON a.TipoOps = b.Codigos " + ;
                           "WHERE b.GeraCmvs = 1 AND a.vendas = 1 " + ;
                           "AND a.caixas = 1 AND a.copers = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpe)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar opera" + CHR(231) + CHR(245) + "es CMV"
                    EXIT
                ENDIF

                *-- Carrega configuracao padrao PAC
                loc_cSQL = "SELECT GruCmvs, ConCmvs, OpeCmvs FROM SigCdPac"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPac)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar configura" + CHR(231) + CHR(227) + CHR(227) + "o PAC"
                    EXIT
                ENDIF

                *-- Mes/ano atual como default
                THIS.this_cMes = PADL(MONTH(DATE()), 2, "0")
                THIS.this_cAno = PADL(YEAR(DATE()), 4, "0")

                *-- Preenche defaults da configuracao PAC
                SELECT (THIS.this_cCursorPac)
                IF !EOF()
                    THIS.this_cNmOperacao = ALLTRIM(NVL(OpeCmvs, ""))
                    THIS.this_cGrupoMov   = ALLTRIM(NVL(GruCmvs, ""))
                    THIS.this_cCdEstoque  = ALLTRIM(NVL(ConCmvs, ""))
                ENDIF

                *-- Busca descricao do grupo de custo (SigCdGcr)
                IF !EMPTY(THIS.this_cGrupoMov)
                    loc_cSQL = "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + ;
                               EscaparSQL(THIS.this_cGrupoMov)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruDescr")
                    IF loc_nResult > 0
                        SELECT cursor_4c_GruDescr
                        IF !EOF()
                            THIS.this_cDGrupoMov = ALLTRIM(NVL(descrs, ""))
                        ENDIF
                        USE IN cursor_4c_GruDescr
                    ENDIF
                ENDIF

                *-- Busca descricao da conta de estoque (SigCdCli)
                IF !EMPTY(THIS.this_cCdEstoque)
                    loc_cSQL = "SELECT TOP 1 rclis FROM SigCdCli WHERE iclis = " + ;
                               EscaparSQL(THIS.this_cCdEstoque)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContDescr")
                    IF loc_nResult > 0
                        SELECT cursor_4c_ContDescr
                        IF !EOF()
                            THIS.this_cDsEstoque = ALLTRIM(NVL(rclis, ""))
                        ENDIF
                        USE IN cursor_4c_ContDescr
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes do processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lOK
        loc_lOK = .T.

        IF EMPTY(THIS.this_cMes) OR EMPTY(THIS.this_cAno)
            THIS.this_cMensagemErro = "M" + CHR(234) + "s e Ano s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
            loc_lOK = .F.
        ENDIF
        IF loc_lOK AND EMPTY(THIS.this_cNmOperacao)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de finaliza" + CHR(231) + CHR(227) + "o da produ" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lOK = .F.
        ENDIF
        IF loc_lOK AND (EMPTY(THIS.this_cGrupoMov) OR EMPTY(THIS.this_cCdEstoque))
            THIS.this_cMensagemErro = "Grupo e conta do custo da produ" + CHR(231) + CHR(227) + "o s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
            loc_lOK = .F.
        ENDIF
        IF loc_lOK AND EMPTY(THIS.this_cCdMoeda)
            THIS.this_cMensagemErro = "Moeda de convers" + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lOK = .F.
        ENDIF

        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao da moeda para a data especificada
    * par_cMoeda: codigo da moeda (SigCdCot.cmoes)
    * par_dData:  data de referencia
    * Retorna: valor numerico da cotacao (1.0 se nao encontrada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResult
        loc_nCotacao = 1

        IF EMPTY(par_cMoeda) OR VARTYPE(par_dData) != "D" OR EMPTY(par_dData)
            RETURN 1
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                       "WHERE cmoes = " + EscaparSQL(par_cMoeda) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cotacao")
            IF loc_nResult > 0
                SELECT cursor_4c_Cotacao
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1)
                    IF loc_nCotacao = 0
                        loc_nCotacao = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_Cotacao
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nCotacao
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Calcula CMV (Custo da Mercadoria Vendida)
    * Reproduz a logica do PROCEDURE processamento do legado
    * Gera cursores crVenda e crCabec para o REPORT FORM
    * Grava em SigCdCmv se usuario confirmar
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cOpeFinal, loc_cGrupo, loc_cConta, loc_cMoeda
        LOCAL loc_nMes, loc_dDtIni, loc_dDtFin, loc_cDtIniSQL, loc_cDtFinSQL
        LOCAL loc_nCotaOpera, loc_lGrava
        LOCAL loc_nSal, loc_cGCM, loc_cMoeOpe, loc_nValor, loc_nCota
        LOCAL loc_nTotCusto, loc_nCusGr
        LOCAL loc_cDopes, loc_nCusto, loc_cMesAtual, loc_cMesItem, loc_cChave
        LOCAL loc_cMesCmvStr, loc_nMesCmv, loc_nAnoCmv, loc_dUltDiaMes
        LOCAL loc_cNmTitulo, loc_cDtPeriodo
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF !THIS.ValidarFiltros()
                    EXIT
                ENDIF

                *-- Captura filtros das propriedades this_*
                loc_cOpeFinal = ALLTRIM(THIS.this_cNmOperacao)
                loc_cGrupo    = ALLTRIM(THIS.this_cGrupoMov)
                loc_cConta    = ALLTRIM(THIS.this_cCdEstoque)
                loc_cMoeda    = ALLTRIM(THIS.this_cCdMoeda)

                *-- Calcula periodo: primeiro e ultimo dia do mes
                loc_nMes   = VAL(THIS.this_cMes)
                loc_dDtIni = DATE(VAL(THIS.this_cAno), loc_nMes, 1)
                IF loc_nMes >= 12
                    loc_dDtFin = DATE(VAL(THIS.this_cAno) + 1, 1, 1) - 1
                ELSE
                    loc_dDtFin = DATE(VAL(THIS.this_cAno), loc_nMes + 1, 1) - 1
                ENDIF
                loc_cDtIniSQL = FormatarDataSQL(loc_dDtIni)
                *-- Data final com 23:59:59 (equivalente a fDtoSQL com hora '23:59:00')
                loc_cDtFinSQL = "'" + PADL(YEAR(loc_dDtFin), 4, "0") + "-" + ;
                                PADL(MONTH(loc_dDtFin), 2, "0") + "-" + ;
                                PADL(DAY(loc_dDtFin), 2, "0") + " 23:59:59'"

                *-- Cotacao da moeda no ultimo dia do mes
                loc_nCotaOpera = THIS.BuscarCotacao(loc_cMoeda, loc_dDtFin)

                *-- Verifica se periodo ja foi calculado
                loc_cSQL = "SELECT DISTINCT valcuss FROM SigCdCmv WHERE datas = " + ;
                           EscaparSQL(PADL(THIS.this_cMes, 2, "0") + "/" + PADL(THIS.this_cAno, 4, "0"))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoIte")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao verificar per" + CHR(237) + "odo (CustoIte)"
                    EXIT
                ENDIF

                loc_lGrava = .T.
                SELECT cursor_4c_CustoIte
                IF RECCOUNT("cursor_4c_CustoIte") > 0
                    loc_lGrava = MsgConfirma("Esse per" + CHR(237) + "odo j" + CHR(225) + ;
                                 " foi calculado o CMV. Gravar valor do recalculado?")
                ENDIF
                USE IN cursor_4c_CustoIte

                *-- Busca itens finalizados da producao (somente se operacao informada)
                IF !EMPTY(loc_cOpeFinal)
                    loc_cSQL = "SELECT cpros, qtds, pesos FROM SigMvItn " + ;
                               "WHERE Dopes = " + EscaparSQL(loc_cOpeFinal) + ;
                               " AND DtAlts BETWEEN " + loc_cDtIniSQL + ;
                               " AND " + loc_cDtFinSQL
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar itens produzidos (crItens)"
                        EXIT
                    ENDIF
                ENDIF

                *-- Cria cursor temporario de acumulacao de custo
                CREATE CURSOR cursor_4c_Custo (Saldos N(11,2))

                *-- Busca saldo do custo de producao (SigMvSlc + SigCdCli)
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos, " + ;
                           "b.RClis, b.Situas, b.Cpfs, b.ContaMats, ' ' AS Matriz " + ;
                           "FROM SigMvSlc a, SigCdCli b " + ;
                           "WHERE a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
                           " AND a.Contas = " + EscaparSQL(loc_cConta) + ;
                           " AND a.Contas = b.IClis " + ;
                           "ORDER BY a.Contas, a.Moedas"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Saldo")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao buscar saldo de custo (crSaldo)"
                    EXIT
                ENDIF

                *-- Calcula saldo total convertendo moedas quando necessario
                loc_nSal = 0
                SELECT cursor_4c_Saldo
                SCAN
                    loc_cGCM    = ALLTRIM(cursor_4c_Saldo.Grupos) + ;
                                  ALLTRIM(cursor_4c_Saldo.Contas) + ;
                                  ALLTRIM(cursor_4c_Saldo.Moedas)
                    loc_cMoeOpe = ALLTRIM(cursor_4c_Saldo.Moedas)

                    loc_cSQL = "SELECT a.Saldos, a.Datas, a.Opers FROM SigMvCcr a " + ;
                               "WHERE a.GruConMoes = " + EscaparSQL(loc_cGCM) + ;
                               " AND a.Datas BETWEEN " + loc_cDtIniSQL + ;
                               " AND " + loc_cDtFinSQL
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMcc1")
                    IF loc_nResult > 0
                        SELECT cursor_4c_TmpMcc1
                        SCAN
                            loc_nValor = cursor_4c_TmpMcc1.Saldos
                            IF loc_cMoeOpe <> loc_cMoeda
                                loc_nCota = THIS.BuscarCotacao(loc_cMoeOpe, cursor_4c_TmpMcc1.Datas)
                                IF loc_nCotaOpera <> 0
                                    loc_nValor = loc_nValor * loc_nCota / loc_nCotaOpera
                                ENDIF
                            ENDIF
                            IF ALLTRIM(cursor_4c_TmpMcc1.Opers) = "D"
                                loc_nSal = loc_nSal + ABS(loc_nValor)
                            ELSE
                                loc_nSal = loc_nSal - ABS(loc_nValor)
                            ENDIF
                            SELECT cursor_4c_TmpMcc1
                        ENDSCAN
                        USE IN cursor_4c_TmpMcc1
                    ENDIF

                    SELECT cursor_4c_Saldo
                ENDSCAN
                USE IN cursor_4c_Saldo

                *-- Registra saldo acumulado no cursor de custo
                SELECT cursor_4c_Custo
                INSERT INTO cursor_4c_Custo (Saldos) VALUES (loc_nSal)

                *-- Soma peso e quantidade dos itens produzidos
                IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
                    SELECT SUM(Pesos) AS TotPeso, SUM(Qtds) AS TotQtd ;
                        FROM cursor_4c_Itens ;
                        INTO CURSOR cursor_4c_TotItens READWRITE
                ELSE
                    CREATE CURSOR cursor_4c_TotItens (TotPeso N(11,2), TotQtd N(11,2))
                    INSERT INTO cursor_4c_TotItens (TotPeso, TotQtd) VALUES (0, 0)
                ENDIF

                *-- Soma saldo total do custo de producao
                SELECT cursor_4c_Custo
                GO TOP
                SUM Saldos TO loc_nTotCusto

                *-- Calcula preco por grama produzida
                SELECT cursor_4c_TotItens
                IF NVL(cursor_4c_TotItens.TotPeso, 0) = 0 OR loc_nTotCusto = 0
                    MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel calcular " + ;
                        "o Custo do Grama Produzido desse per" + CHR(237) + "odo pois n" + CHR(227) + ;
                        "o teve nenhum produto vendido ou custo de produ" + CHR(231) + CHR(227) + ;
                        "o lan" + CHR(231) + "ada.", "CMV")
                    loc_nCusGr = 0
                ELSE
                    loc_nCusGr = ABS(loc_nTotCusto) / ABS(cursor_4c_TotItens.TotPeso)
                ENDIF

                *-- Salva valores calculados nas propriedades do BO
                THIS.this_nCustoGrama = loc_nCusGr
                THIS.this_nTotalCusto = loc_nTotCusto
                THIS.this_nTotalPeso  = NVL(cursor_4c_TotItens.TotPeso, 0)
                THIS.this_nTotalQtd   = NVL(cursor_4c_TotItens.TotQtd, 0)

                *-- Cria cursor principal do relatorio (crVenda) com estrutura do SigMvItn
                loc_cSQL = "SELECT 0 AS ordem, dopes, cpros, qtds, pesos, " + ;
                           "dtalts AS Datas, 00000000.0000 AS ValCuss, " + ;
                           "00000000.0000 AS TotCuss, '  ' AS MoeCuss " + ;
                           "FROM SigMvItn WHERE 0=1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao criar cursor de dados (crVenda)"
                    EXIT
                ENDIF

                *-- Linha 1: totais gerais da producao
                SELECT cursor_4c_TotItens
                INSERT INTO (THIS.this_cCursorDados) ;
                    (ordem, qtds, pesos, TotCuss, ValCuss, MoeCuss) ;
                    VALUES (1, NVL(cursor_4c_TotItens.TotQtd, 0), ;
                            NVL(cursor_4c_TotItens.TotPeso, 0), ;
                            ABS(loc_nTotCusto), loc_nCusGr, loc_cMoeda)

                *-- Calcula custo de cada item vendido por operacao CMV
                SELECT (THIS.this_cCursorOpe)
                SCAN
                    loc_cDopes = ALLTRIM(Dopes)

                    loc_cSQL = "SELECT 2 AS ordem, a.dopes, a.cpros, a.qtds, a.pesos, " + ;
                               "b.Datas, 00000000.0000 AS ValCuss, " + ;
                               "00000000.0000 AS TotCuss, '  ' AS MoeCuss " + ;
                               "FROM SigMvItn a " + ;
                               "INNER JOIN sigopetq b ON a.codbarras = b.cbars " + ;
                               "WHERE a.Dopes = " + EscaparSQL(loc_cDopes) + ;
                               " AND a.DtAlts BETWEEN " + loc_cDtIniSQL + ;
                               " AND " + loc_cDtFinSQL
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvItn")
                    IF loc_nResult > 0
                        *-- Calcula custo unitario de cada item
                        SELECT cursor_4c_SigMvItn
                        SCAN
                            loc_nCusto    = loc_nCusGr
                            loc_cMesAtual = PADL(THIS.this_cMes, 2, "0") + PADL(THIS.this_cAno, 4, "0")
                            loc_cMesItem  = PADL(MONTH(cursor_4c_SigMvItn.Datas), 2, "0") + ;
                                            PADL(YEAR(cursor_4c_SigMvItn.Datas), 4, "0")

                            *-- Item de periodo diferente: busca custo historico em SigCdCmv
                            IF loc_cMesAtual <> loc_cMesItem
                                loc_cChave = PADR(ALLTRIM(cursor_4c_SigMvItn.Cpros), 14) + loc_cMesItem
                                loc_cSQL = "SELECT valcuss, moedas, datas FROM SigCdCmv " + ;
                                           "WHERE pkchaves = " + EscaparSQL(loc_cChave)
                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoIteH")
                                IF loc_nResult > 0
                                    SELECT cursor_4c_CustoIteH
                                    IF !EOF()
                                        loc_nCusto = cursor_4c_CustoIteH.valcuss
                                        IF ALLTRIM(cursor_4c_CustoIteH.moedas) <> loc_cMoeda
                                            loc_cMesCmvStr = ALLTRIM(cursor_4c_CustoIteH.datas)
                                            loc_nMesCmv    = VAL(SUBSTR(loc_cMesCmvStr, 1, 2))
                                            loc_nAnoCmv    = VAL(SUBSTR(loc_cMesCmvStr, 4, 4))
                                            IF loc_nMesCmv >= 12
                                                loc_dUltDiaMes = DATE(loc_nAnoCmv + 1, 1, 1) - 1
                                            ELSE
                                                loc_dUltDiaMes = DATE(loc_nAnoCmv, loc_nMesCmv + 1, 1) - 1
                                            ENDIF
                                            loc_nCota = THIS.BuscarCotacao(ALLTRIM(cursor_4c_CustoIteH.moedas), loc_dUltDiaMes)
                                            IF loc_nCotaOpera <> 0
                                                loc_nCusto = loc_nCusto * loc_nCota / loc_nCotaOpera
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                    USE IN cursor_4c_CustoIteH
                                ENDIF
                            ENDIF

                            SELECT cursor_4c_SigMvItn
                            REPLACE ValCuss WITH loc_nCusto, ;
                                    TotCuss WITH NVL(Pesos * loc_nCusto, 0), ;
                                    MoeCuss WITH loc_cMoeda
                            SELECT cursor_4c_SigMvItn
                        ENDSCAN

                        *-- Adiciona itens calculados ao cursor principal do relatorio
                        SELECT cursor_4c_SigMvItn
                        GO TOP
                        SELECT (THIS.this_cCursorDados)
                        APPEND FROM DBF("cursor_4c_SigMvItn")
                        USE IN cursor_4c_SigMvItn
                    ENDIF

                    SELECT (THIS.this_cCursorOpe)
                ENDSCAN

                *-- Grava em SigCdCmv se confirmado e houver itens
                IF loc_lGrava AND USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
                    THIS.RegistrarCMV(loc_nCusGr)
                ENDIF

                *-- Cursor de cabecalho para o relatorio
                loc_cNmTitulo  = "CMV - Custo da Mercadoria Vendida"
                loc_cDtPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_dDtIni) + ;
                                 " a " + DTOC(loc_dDtFin)
                CREATE CURSOR crCabec (titulos C(80), titulo2s C(80))
                INSERT INTO crCabec (titulos, titulo2s) VALUES (loc_cNmTitulo, loc_cDtPeriodo)

                *-- Posiciona no cursor de dados para o REPORT FORM
                SELECT (THIS.this_cCursorDados)

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega registro do cursor SigCdCmv nas propriedades
    * par_cAliasCursor: nome do alias/cursor com registro posicionado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF() AND !BOF()
                    THIS.this_cPkChaves = ALLTRIM(NVL(pkchaves, ""))
                    THIS.this_cCpros    = ALLTRIM(NVL(cpros, ""))
                    THIS.this_cDatas    = ALLTRIM(NVL(datas, ""))
                    THIS.this_cMoedas   = ALLTRIM(NVL(moedas, ""))
                    THIS.this_nValCuss  = NVL(valcuss, 0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdCmv com as propriedades this_*
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cPkChaves) OR EMPTY(THIS.this_cCpros) OR ;
                   EMPTY(THIS.this_cDatas) OR EMPTY(THIS.this_cMoedas)
                    THIS.this_cMensagemErro = "Campos obrigat" + CHR(243) + "rios n" + CHR(227) + "o preenchidos"
                    EXIT
                ENDIF

                loc_cSQL = "INSERT INTO SigCdCmv " + ;
                           "(pkchaves, cpros, datas, moedas, valcuss) VALUES (" + ;
                           EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                           EscaparSQL(THIS.this_cCpros) + ", " + ;
                           EscaparSQL(THIS.this_cDatas) + ", " + ;
                           EscaparSQL(THIS.this_cMoedas) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nValCuss, 2) + ;
                           ")"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao inserir CMV em SigCdCmv"
                    EXIT
                ENDIF

                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdCmv com as propriedades this_*
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cPkChaves)
                    THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada"
                    EXIT
                ENDIF

                loc_cSQL = "UPDATE SigCdCmv SET " + ;
                           "cpros = "   + EscaparSQL(THIS.this_cCpros) + ", " + ;
                           "datas = "   + EscaparSQL(THIS.this_cDatas) + ", " + ;
                           "moedas = "  + EscaparSQL(THIS.this_cMoedas) + ", " + ;
                           "valcuss = " + FormatarNumeroSQL(THIS.this_nValCuss, 2) + ;
                           " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao atualizar CMV em SigCdCmv"
                    EXIT
                ENDIF

                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarCMV - Grava custo calculado em SigCdCmv (INSERT ou UPDATE)
    * par_nCusGr: custo por grama calculado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarCMV(par_nCusGr)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cPkChaves, loc_cDatas, loc_lExiste
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                loc_cDatas = PADL(THIS.this_cMes, 2, "0") + "/" + PADL(THIS.this_cAno, 4, "0")

                *-- Para cada produto distinto nos itens produzidos
                SELECT DISTINCT cpros FROM cursor_4c_Itens INTO CURSOR cursor_4c_Gravar READWRITE

                SELECT cursor_4c_Gravar
                SCAN
                    loc_cPkChaves = PADR(ALLTRIM(cursor_4c_Gravar.cpros), 14) + ;
                                   PADL(THIS.this_cMes, 2, "0") + ;
                                   PADL(THIS.this_cAno, 4, "0")

                    *-- Verifica se registro ja existe
                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCmv " + ;
                               "WHERE pkchaves = " + EscaparSQL(loc_cPkChaves)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExisteCmv")
                    loc_lExiste = .F.
                    IF loc_nResult > 0
                        SELECT cursor_4c_ExisteCmv
                        IF !EOF()
                            loc_lExiste = NVL(nExiste, 0) > 0
                        ENDIF
                        USE IN cursor_4c_ExisteCmv
                    ENDIF

                    IF loc_lExiste
                        loc_cSQL = "UPDATE SigCdCmv SET " + ;
                                   "valcuss = " + FormatarNumeroSQL(par_nCusGr, 2) + ", " + ;
                                   "moedas = " + EscaparSQL(ALLTRIM(THIS.this_cCdMoeda)) + ", " + ;
                                   "datas = " + EscaparSQL(loc_cDatas) + ;
                                   " WHERE pkchaves = " + EscaparSQL(loc_cPkChaves)
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdCmv " + ;
                                   "(pkchaves, cpros, valcuss, moedas, datas) VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Gravar.cpros)) + ", " + ;
                                   FormatarNumeroSQL(par_nCusGr, 2) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cCdMoeda)) + ", " + ;
                                   EscaparSQL(loc_cDatas) + ;
                                   ")"
                    ENDIF

                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT cursor_4c_Gravar
                ENDSCAN
                USE IN cursor_4c_Gravar

                THIS.RegistrarAuditoria("GERACMV")
                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) NOCONSOLE TO PRINTER
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComDialogo - Prepara dados e abre dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComDialogo()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) NOCONSOLE TO PRINTER PROMPT
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) NOCONSOLE PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna pkchaves do registro corrente
    * Prioridade: this_cPkChaves (setada por CarregarDoCursor/Inserir/Atualizar)
    * Fallback: monta a partir do cursor crVenda + mes/ano correntes
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cCursor, loc_cCpros
        loc_cChave  = ""
        loc_cCursor = THIS.this_cCursorDados
        IF !EMPTY(THIS.this_cPkChaves)
            loc_cChave = ALLTRIM(THIS.this_cPkChaves)
        ELSE
            IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                SELECT (loc_cCursor)
                loc_cCpros = Cpros
                loc_cChave = PADR(ALLTRIM(loc_cCpros), 14) + ;
                             PADL(THIS.this_cMes, 2, "0") + ;
                             PADL(THIS.this_cAno, 4, "0")
            ENDIF
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave
        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF EMPTY(loc_cChave)
                loc_cChave = PADL(THIS.this_cMes, 2, "0") + "/" + PADL(THIS.this_cAno, 4, "0")
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ;
                       ", GETDATE())"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorOpe)
            USE IN (THIS.this_cCursorOpe)
        ENDIF
        IF USED(THIS.this_cCursorPac)
            USE IN (THIS.this_cCursorPac)
        ENDIF
        IF USED("crCabec")
            USE IN crCabec
        ENDIF
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        IF USED("cursor_4c_TotItens")
            USE IN cursor_4c_TotItens
        ENDIF
        IF USED("cursor_4c_Custo")
            USE IN cursor_4c_Custo
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

