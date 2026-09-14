# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 489: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 512: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGmi.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1169 linhas total):

*-- Linhas 67 a 76:
67:                 THIS.ConfigurarBindings()
68: 
69:                 *-- Propagar titulo para labels do cabecalho
70:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
71:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
72: 
73:                 THIS.TornarControlesVisiveis()
74: 
75:                 loc_lSucesso = .T.
76:             ENDIF

*-- Linhas 96 a 141:
96:     PROTECTED PROCEDURE ConfigurarCabecalho
97:         THIS.AddObject("cnt_4c_Sombra", "Container")
98:         WITH THIS.cnt_4c_Sombra
99:             .Top        = 0
100:             .Left       = 0
101:             .Width      = THIS.Width
102:             .Height     = 80
103:             .BackColor  = RGB(100, 100, 100)
104:             .BorderWidth = 0
105:             .BackStyle  = 1
106: 
107:             .AddObject("lbl_4c_Sombra", "Label")
108:             WITH .lbl_4c_Sombra
109:                 .AutoSize   = .F.
110:                 .BackStyle  = 0
111:                 .Caption    = ""
112:                 .FontBold   = .T.
113:                 .FontName   = "Tahoma"
114:                 .FontSize   = 18
115:                 .ForeColor  = RGB(0, 0, 0)
116:                 .Height     = 40
117:                 .Left       = 10
118:                 .Top        = 18
119:                 .Width      = THIS.Width
120:                 .WordWrap   = .T.
121:                 .Alignment  = 0
122:                 .Visible    = .T.
123:             ENDWITH
124: 
125:             .AddObject("lbl_4c_Titulo", "Label")
126:             WITH .lbl_4c_Titulo
127:                 .AutoSize    = .F.
128:                 .BackStyle   = 0
129:                 .Caption     = ""
130:                 .FontBold    = .T.
131:                 .FontName    = "Tahoma"
132:                 .FontSize    = 18
133:                 .ForeColor   = RGB(255, 255, 255)
134:                 .Height      = 46
135:                 .Left        = 10
136:                 .Top         = 17
137:                 .Width       = THIS.Width
138:                 .WordWrap    = .T.
139:                 .Alignment   = 0
140:                 .ToolTipText = "T" + CHR(237) + "tulo"
141:                 .Visible     = .T.

*-- Linhas 179 a 188:
179: 
180:         THIS.LimparCampos()
181: 
182:         IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
183:             THIS.cmd_4c_Processa.Enabled = .T.
184:         ENDIF
185:         IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
186:             THIS.txt_4c_CdEmpresa.SetFocus()
187:         ENDIF
188:     ENDPROC

*-- Linhas 219 a 327:
219:         *-- Decorativo Shape1
220:         THIS.AddObject("shp_4c_Shape1", "Shape")
221:         WITH THIS.shp_4c_Shape1
222:             .Top         = 7
223:             .Left        = 698
224:             .Width       = 46
225:             .Height      = 41
226:             .BackStyle   = 0
227:             .BorderStyle = 0
228:             .BorderColor = RGB(136, 189, 188)
229:             .Visible     = .T.
230:         ENDWITH
231: 
232:         *-- Empresa
233:         THIS.AddObject("lbl_4c_LblEmpresa", "Label")
234:         WITH THIS.lbl_4c_LblEmpresa
235:             .AutoSize  = .T.
236:             .Caption   = "Empresa : "
237:             .Left      = 211
238:             .Top       = 118
239:             .BackStyle = 0
240:             .FontName  = "Tahoma"
241:             .FontSize  = 8
242:             .Visible   = .T.
243:         ENDWITH
244: 
245:         THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
246:         WITH THIS.txt_4c_CdEmpresa
247:             .FontName      = "Courier New"
248:             .FontSize      = 9
249:             .Format        = "K"
250:             .Height        = 25
251:             .Left          = 268
252:             .MaxLength     = 3
253:             .InputMask     = "XXX"
254:             .SpecialEffect = 0
255:             .Top           = 113
256:             .Width         = 31
257:             .Value         = ""
258:             .Visible       = .T.
259:         ENDWITH
260: 
261:         THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
262:         WITH THIS.txt_4c_DsEmpresa
263:             .FontName  = "Courier New"
264:             .FontSize  = 9
265:             .Format    = "K"
266:             .Height    = 25
267:             .Left      = 348
268:             .MaxLength = 40
269:             .Top       = 113
270:             .Width     = 290
271:             .Value     = ""
272:             .Visible   = .T.
273:         ENDWITH
274: 
275:         *-- Grupo de Estoque
276:         THIS.AddObject("lbl_4c_Say1", "Label")
277:         WITH THIS.lbl_4c_Say1
278:             .AutoSize  = .T.
279:             .Caption   = "Grupo de Estoque : "
280:             .Left      = 166
281:             .Top       = 142
282:             .BackStyle = 0
283:             .FontName  = "Tahoma"
284:             .FontSize  = 8
285:             .Visible   = .T.
286:         ENDWITH
287: 
288:         THIS.AddObject("txt_4c_CdGrEstoque", "TextBox")
289:         WITH THIS.txt_4c_CdGrEstoque
290:             .FontName  = "Courier New"
291:             .FontSize  = 9
292:             .Format    = "K"
293:             .Height    = 25
294:             .Left      = 268
295:             .MaxLength = 10
296:             .Top       = 138
297:             .Width     = 80
298:             .Value     = ""
299:             .Visible   = .T.
300:         ENDWITH
301: 
302:         THIS.AddObject("txt_4c_DsGrEstoque", "TextBox")
303:         WITH THIS.txt_4c_DsGrEstoque
304:             .FontName  = "Courier New"
305:             .FontSize  = 9
306:             .Format    = "K"
307:             .Height    = 25
308:             .Left      = 348
309:             .MaxLength = 20
310:             .Top       = 138
311:             .Width     = 150
312:             .Value     = ""
313:             .Visible   = .T.
314:         ENDWITH
315: 
316:         *-- Estoque (Conta)
317:         THIS.AddObject("lbl_4c_LblEstoque", "Label")
318:         WITH THIS.lbl_4c_LblEstoque
319:             .AutoSize  = .T.
320:             .Caption   = "Estoque : "
321:             .Left      = 213
322:             .Top       = 168
323:             .BackStyle = 0
324:             .FontName  = "Tahoma"
325:             .FontSize  = 8
326:             .Visible   = .T.
327:         ENDWITH

*-- Linhas 335 a 372:
335:             .BorderStyle   = 1
336:             .Format        = "K"
337:             .Height        = 25
338:             .Left          = 268
339:             .MaxLength     = 10
340:             .SpecialEffect = 0
341:             .Top           = 163
342:             .Width         = 80
343:             .Value         = ""
344:             .Visible       = .T.
345:         ENDWITH
346: 
347:         THIS.AddObject("txt_4c_DsEstoque", "TextBox")
348:         WITH THIS.txt_4c_DsEstoque
349:             .FontName  = "Courier New"
350:             .FontSize  = 9
351:             .Format    = "K"
352:             .Height    = 25
353:             .Left      = 348
354:             .MaxLength = 40
355:             .Top       = 163
356:             .Width     = 290
357:             .Value     = ""
358:             .Visible   = .T.
359:         ENDWITH
360: 
361:         *-- Linha de Producao
362:         THIS.AddObject("lbl_4c_Say2", "Label")
363:         WITH THIS.lbl_4c_Say2
364:             .AutoSize  = .T.
365:             .Caption   = "Linha de Produ" + CHR(231) + CHR(227) + "o : "
366:             .Left      = 164
367:             .Top       = 193
368:             .BackStyle = 0
369:             .FontName  = "Tahoma"
370:             .FontSize  = 8
371:             .Visible   = .T.
372:         ENDWITH

*-- Linhas 380 a 417:
380:             .BorderStyle   = 1
381:             .Format        = "K"
382:             .Height        = 25
383:             .Left          = 268
384:             .MaxLength     = 10
385:             .SpecialEffect = 0
386:             .Top           = 188
387:             .Width         = 80
388:             .Value         = ""
389:             .Visible       = .T.
390:         ENDWITH
391: 
392:         THIS.AddObject("txt_4c_DsLinha", "TextBox")
393:         WITH THIS.txt_4c_DsLinha
394:             .FontName  = "Courier New"
395:             .FontSize  = 9
396:             .Format    = "K"
397:             .Height    = 25
398:             .Left      = 348
399:             .MaxLength = 40
400:             .Top       = 188
401:             .Width     = 290
402:             .Value     = ""
403:             .Visible   = .T.
404:         ENDWITH
405: 
406:         *-- Somente Negativos
407:         THIS.AddObject("lbl_4c_Say3", "Label")
408:         WITH THIS.lbl_4c_Say3
409:             .AutoSize  = .T.
410:             .Caption   = "Somente Negativos :"
411:             .Left      = 162
412:             .Top       = 218
413:             .BackStyle = 0
414:             .FontName  = "Tahoma"
415:             .FontSize  = 8
416:             .Visible   = .T.
417:         ENDWITH

*-- Linhas 425 a 473:
425:             .BorderStyle   = 1
426:             .Format        = "K"
427:             .Height        = 25
428:             .Left          = 268
429:             .MaxLength     = 1
430:             .SpecialEffect = 0
431:             .Top           = 213
432:             .Width         = 17
433:             .Value         = "N"
434:             .Visible       = .T.
435:         ENDWITH
436: 
437:         THIS.AddObject("lbl_4c_Say4", "Label")
438:         WITH THIS.lbl_4c_Say4
439:             .AutoSize  = .T.
440:             .Caption   = "< S / N >"
441:             .Left      = 292
442:             .Top       = 217
443:             .BackStyle = 0
444:             .FontBold  = .T.
445:             .FontName  = "Tahoma"
446:             .FontSize  = 8
447:             .Visible   = .T.
448:         ENDWITH
449: 
450:         *-- Data de Geracao
451:         THIS.AddObject("lbl_4c_SayConta", "Label")
452:         WITH THIS.lbl_4c_SayConta
453:             .AutoSize  = .T.
454:             .Caption   = "Data Gera" + CHR(231) + CHR(227) + "o :"
455:             .Left      = 189
456:             .Top       = 243
457:             .BackStyle = 0
458:             .FontName  = "Tahoma"
459:             .FontSize  = 8
460:             .Visible   = .T.
461:         ENDWITH
462: 
463:         THIS.AddObject("txt_4c_Datai", "TextBox")
464:         WITH THIS.txt_4c_Datai
465:             .Alignment = 3
466:             .Height    = 23
467:             .Left      = 268
468:             .Top       = 238
469:             .Width     = 82
470:             .Value     = DATE() - 7
471:             .Visible   = .T.
472:         ENDWITH
473:     ENDPROC

*-- Linhas 479 a 495:
479:         LOCAL loc_cIcones
480:         loc_cIcones = gc_4c_CaminhoIcones
481: 
482:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
483:         WITH THIS.cmd_4c_Processa
484:             .Top             = 4
485:             .Left            = 648
486:             .Width           = 75
487:             .Height          = 75
488:             .Caption         = "Processar"
489:             .FontName        = "Comic Sans MS"
490:             .FontBold        = .T.
491:             .FontItalic      = .T.
492:             .FontSize        = 8
493:             .ForeColor       = RGB(90, 90, 90)
494:             .BackColor       = RGB(255, 255, 255)
495:             .Themes          = .T.

*-- Linhas 502 a 518:
502:             .Visible         = .T.
503:         ENDWITH
504: 
505:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
506:         WITH THIS.cmd_4c_Cancela
507:             .Top             = 4
508:             .Left            = 723
509:             .Width           = 75
510:             .Height          = 75
511:             .Caption         = "Encerrar"
512:             .FontName        = "Comic Sans MS"
513:             .FontBold        = .T.
514:             .FontItalic      = .T.
515:             .FontSize        = 8
516:             .ForeColor       = RGB(90, 90, 90)
517:             .BackColor       = RGB(255, 255, 255)
518:             .Themes          = .T.

*-- Linhas 540 a 549:
540:         BINDEVENT(THIS.txt_4c_Linha,       "KeyPress", THIS, "TxtLinhaKeyPress")
541:         BINDEVENT(THIS.txt_4c_DsLinha,     "KeyPress", THIS, "TxtDsLinhaKeyPress")
542:         BINDEVENT(THIS.txt_4c_Negativo,    "KeyPress", THIS, "TxtNegativoKeyPress")
543:         BINDEVENT(THIS.cmd_4c_Processa,    "Click",    THIS, "BtnProcessarClick")
544:         BINDEVENT(THIS.cmd_4c_Cancela,     "Click",    THIS, "BtnEncerrarClick")
545:     ENDPROC
546: 
547:     *==========================================================================
548:     * FormParaBO - Transfere valores dos campos para o Business Object
549:     *==========================================================================

*-- Linhas 596 a 605:
596:     PROCEDURE BtnAlterarClick
597:         THIS.LimparCampos()
598:         THIS.AlternarPagina(1)
599:         IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
600:             THIS.cmd_4c_Processa.Enabled = .T.
601:         ENDIF
602:         IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
603:             THIS.txt_4c_CdEmpresa.SetFocus()
604:         ENDIF
605:     ENDPROC

*-- Linhas 1108 a 1129:
1108:         THIS.txt_4c_DsLinha.Enabled     = loc_lHab
1109:         THIS.txt_4c_Negativo.Enabled    = loc_lHab
1110:         THIS.txt_4c_Datai.Enabled       = loc_lHab
1111:         IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
1112:             THIS.cmd_4c_Processa.Enabled = loc_lHab
1113:         ENDIF
1114:     ENDPROC
1115: 
1116:     *==========================================================================
1117:     * AjustarBotoesPorModo - Reativa botoes apos processamento
1118:     *==========================================================================
1119:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1120:         IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
1121:             THIS.cmd_4c_Processa.Enabled = .T.
1122:         ENDIF
1123:         IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
1124:             THIS.cmd_4c_Cancela.Enabled = .T.
1125:         ENDIF
1126:     ENDPROC
1127: 
1128:     *==========================================================================
1129:     * CarregarLista - OPERACIONAL sem grid de lista; presente por compatibilidade


### BO (C:\4c\projeto\app\classes\SigPrGmiBO.prg):
*=============================================================================
* SigPrGmiBO.prg - Business Object: Geracao de Pedido de Estoque Minimo
* Herda de BusinessBase
*=============================================================================

DEFINE CLASS SigPrGmiBO AS BusinessBase

    *-- Filtros do formulario
    this_cEmpresa     = ""   && SigCdEmp.Cemps char(3)
    this_cDsEmpresa   = ""   && SigCdEmp.Razas char(40)
    this_cGrEstoque   = ""   && Grupo de Estoque - codigo char(10)
    this_cDsGrEstoque = ""   && Grupo de Estoque - descricao
    this_cEstoque     = ""   && Conta de Estoque - codigo char(10)
    this_cDsEstoque   = ""   && Conta de Estoque - descricao
    this_cLinha       = ""   && SigCdLin.linhas - codigo char(10)
    this_cDsLinha     = ""   && SigCdLin.descs - descricao char(40)
    this_cNegativo    = "N"  && S = somente saldos negativos
    this_dDatai       = {}   && Data de geracao do pedido
    this_cOperacao    = ""   && SigCdLin.pedidos - operacao associada a linha

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor crSigCdLin para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cLinha    = TratarNulo(linhas, "C")
                THIS.this_cDsLinha  = TratarNulo(descs, "C")
                THIS.this_cOperacao = TratarNulo(pedidos, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmpresa, 3) + PADR(THIS.this_cOperacao, 20) + SPACE(6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursorLinhas - Carrega cursor cursor_4c_SigCdLin para lookup
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCursorLinhas()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT descs, linhas, pedidos FROM SigCdLin ORDER BY descs, linhas, pedidos"
            IF USED("cursor_4c_SigCdLin")
                USE IN cursor_4c_SigCdLin
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdLin") > 0
                SELECT cursor_4c_SigCdLin
                INDEX ON DESCS TAG DESCS
                INDEX ON linhas TAG linhas
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar linhas de produ" + CHR(231) + CHR(227) + "o"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios do filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Empresa"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cGrEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar o Grupo de Estoque"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Conta de Estoque"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cLinha))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Linha de Produ" + CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatai)
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Data de Gera" + CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera pedidos de estoque minimo (acao principal do formulario)
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !THIS.ValidarDados()
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF
            loc_lResultado = THIS.ProcessarPedido()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar pedido")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPedido - Logica completa de geracao de pedidos de estoque minimo
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPedido()
        LOCAL loc_lResultado, loc_cSQL, loc_lTransacaoAberta
        LOCAL loc_cEmpresa, loc_cGrEstoque, loc_cEstoque, loc_cLinha, loc_cNegativo
        LOCAL loc_cOperacao, loc_cGruOrigs, loc_nOpers
        LOCAL loc_nNumero, loc_lnItens, loc_cFornece, loc_cEmpDopNums, loc_cMascNum
        LOCAL loc_cOpers, loc_nIncVal, loc_nTotalReg, loc_cChave
        LOCAL loc_loBarra
        LOCAL loc_cScanCPros, loc_cScanIFors, loc_nScanPVens
        LOCAL loc_cScanMoevs, loc_cScanDpros, loc_nScanQtds

        loc_lResultado       = .F.
        loc_lTransacaoAberta = .F.
        loc_loBarra          = .NULL.
        loc_nNumero          = 0
        loc_lnItens          = 0

        TRY
            *-- Copiar propriedades para vars locais
            loc_cEmpresa   = THIS.this_cEmpresa
            loc_cGrEstoque = THIS.this_cGrEstoque
            loc_cEstoque   = THIS.this_cEstoque
            loc_cLinha     = ALLTRIM(THIS.this_cLinha)
            loc_cNegativo  = THIS.this_cNegativo

            *-- Verificar se a linha possui operacao cadastrada
            loc_cSQL = "SELECT linhas, pedidos FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLinha)
            IF USED("cursor_4c_LinhaOpe")
                USE IN cursor_4c_LinhaOpe
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhaOpe") < 1 OR RECCOUNT("cursor_4c_LinhaOpe") = 0
                MsgAviso("Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o est" + CHR(225) + " cadastrada...", "Aten" + CHR(231) + CHR(227) + "o")
                IF USED("cursor_4c_LinhaOpe")
                    USE IN cursor_4c_LinhaOpe
                ENDIF
                loc_lResultado = .F.
            ENDIF
            SELECT cursor_4c_LinhaOpe
            IF EMPTY(ALLTRIM(pedidos))
                MsgAviso("Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o possui uma Opera" + CHR(231) + CHR(227) + "o cadastrada...", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN cursor_4c_LinhaOpe
                loc_lResultado = .F.
            ENDIF
            loc_cOperacao    = ALLTRIM(pedidos)
            THIS.this_cOperacao = loc_cOperacao
            USE IN cursor_4c_LinhaOpe

            *-- Branch: somente negativos ou abaixo do minimo
            IF ALLTRIM(loc_cNegativo) # "S"

                *-- Ramo 1: Produtos com saldo abaixo do estoque minimo
                loc_cSQL = "SELECT E.emps, E.grupos, E.estos, E.cpros, E.sqtds, " + ;
                    "P.linhas, P.situas, P.qmins, P.ifors, P.pvens, P.moevs, P.dpros " + ;
                    "FROM SigMvEst E " + ;
                    "JOIN SigCdPro P ON E.cpros = P.cpros " + ;
                    "WHERE E.emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.grupos = " + EscaparSQL(loc_cGrEstoque) + ;
                    " AND E.estos = " + EscaparSQL(loc_cEstoque) + ;
                    " AND E.sqtds < P.qmins" + ;
                    " AND P.linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.situas = 1 AND P.qmins > 0 " + ;
                    "ORDER BY E.emps, E.grupos, E.estos, E.cpros"
                IF USED("cursor_4c_Temp1")
                    USE IN cursor_4c_Temp1
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp1") < 1
                    MsgErro("Falha na consulta de estoques abaixo do m" + CHR(237) + "nimo", "Erro")
                    loc_lResultado = .F.
                ENDIF

                *-- Produtos que NAO tem registro em SigMvEst para esta empresa/grupo/conta
                loc_cChave = PADR(loc_cEmpresa, 3) + PADR(loc_cGrEstoque, 10) + PADR(loc_cEstoque, 10)
                loc_cSQL = "SELECT cpros, qmins, ifors, pvens, moevs, dpros " + ;
                    "FROM SigCdPro " + ;
                    "WHERE linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND qmins > 0 AND situas = 1 " + ;
                    "AND " + EscaparSQL(loc_cChave) + " + RTRIM(cpros) " + ;
                    "NOT IN (SELECT RTRIM(empgruests) + RTRIM(cpros) FROM SigMvEst)"
                IF USED("cursor_4c_Temp2")
                    USE IN cursor_4c_Temp2
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp2") < 1
                    MsgErro("Falha na consulta de produtos sem estoque cadastrado", "Erro")
                    IF USED("cursor_4c_Temp1")
                        USE IN cursor_4c_Temp1
                    ENDIF
                    loc_lResultado = .F.
                ENDIF

                *-- UNION ALL: abaixo do minimo + sem registro de estoque
                IF USED("TmpMinimo")
                    USE IN TmpMinimo
                ENDIF
                SET NULL ON
                SELECT m.loc_cEmpresa AS Emps, m.loc_cGrEstoque AS Grupos, ;
                       m.loc_cEstoque AS Estos, cpros, sqtds, qmins, ;
                       qmins - sqtds AS DifProds, ifors, pvens, moevs, dpros ;
                    FROM cursor_4c_Temp1 ;
                    WHERE emps = m.loc_cEmpresa AND grupos = m.loc_cGrEstoque ;
                    AND estos = m.loc_cEstoque ;
                    AND sqtds < qmins AND linhas = m.loc_cLinha ;
                    AND situas = 1 AND qmins > 0 ;
                UNION ALL ;
                SELECT m.loc_cEmpresa AS Emps, m.loc_cGrEstoque AS Grupos, ;
                       m.loc_cEstoque AS Estos, cpros, 0.000 AS sqtds, qmins, ;
                       qmins AS DifProds, ifors, pvens, moevs, dpros ;
                    FROM cursor_4c_Temp2 ;
                INTO CURSOR TmpMinimo READWRITE
                SET NULL OFF

                IF USED("cursor_4c_Temp1")
                    USE IN cursor_4c_Temp1
                ENDIF
                IF USED("cursor_4c_Temp2")
                    USE IN cursor_4c_Temp2
                ENDIF

            ELSE

                *-- Ramo 2: Somente produtos com saldo negativo
                loc_cSQL = "SELECT E.emps, E.grupos, E.estos, E.cpros, E.sqtds, " + ;
                    "P.ifors, P.situas, P.linhas, P.pvens, P.moevs, P.dpros " + ;
                    "FROM SigMvEst E " + ;
                    "JOIN SigCdPro P ON E.cpros = P.cpros " + ;
                    "WHERE E.emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.grupos = " + EscaparSQL(loc_cGrEstoque) + ;
                    " AND E.estos = " + EscaparSQL(loc_cEstoque) + ;
                    " AND E.sqtds < 0" + ;
                    " AND P.linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.situas = 1 " + ;
                    "ORDER BY E.emps, E.grupos, E.estos, E.cpros"
                IF USED("cursor_4c_Temp3")
                    USE IN cursor_4c_Temp3
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp3") < 1
                    MsgErro("Falha na consulta de estoques negativos", "Erro")
                    loc_lResultado = .F.
                ENDIF

                IF USED("TmpMinimo")
                    USE IN TmpMinimo
                ENDIF
                SET NULL ON
                SELECT m.loc_cEmpresa AS Emps, m.loc_cGrEstoque AS Grupos, ;
                       m.loc_cEstoque AS Estos, cpros, sqtds, 0 AS qmins, ;
                       ABS(sqtds) AS DifProds, ifors, pvens, moevs, dpros ;
                    FROM cursor_4c_Temp3 ;
                INTO CURSOR TmpMinimo READWRITE
                SET NULL OFF

                IF USED("cursor_4c_Temp3")
                    USE IN cursor_4c_Temp3
                ENDIF

            ENDIF

            *-- Verificar se ha produtos para processar
            SELECT TmpMinimo
            GO TOP
            IF EOF()
                MsgAviso("Nenhum produto selecionado...", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN TmpMinimo
                loc_lResultado = .F.
            ENDIF

            *-- Buscar pedidos em andamento para descontar do que precisa pedir
            loc_cSQL = "SELECT I.cpros, I.qtds, I.qtbxprods " + ;
                "FROM SigMvCab E " + ;
                "JOIN SigMvItn I ON E.empdopnums = I.empdopnums " + ;
                "JOIN SigCdOpe O ON E.dopes = O.dopes " + ;
                "WHERE E.emps = " + EscaparSQL(loc_cEmpresa) + ;
                " AND (O.globalizas = 1 OR O.globalizas = 2) " + ;
                " AND E.grupods = " + EscaparSQL(loc_cGrEstoque) + ;
                " AND E.contads = " + EscaparSQL(loc_cEstoque)
            IF USED("cursor_4c_Temp4")
                USE IN cursor_4c_Temp4
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp4")

            *-- Calcular total em producao por produto
            IF USED("TmpPedidos")
                USE IN TmpPedidos
            ENDIF
            IF USED("cursor_4c_Temp4") AND RECCOUNT("cursor_4c_Temp4") > 0
                SELECT cpros, SUM(qtds - qtbxprods) AS Produzindo ;
                    FROM cursor_4c_Temp4 ;
                    GROUP BY cpros ;
                    INTO CURSOR TmpPedidos READWRITE
            ELSE
                CREATE CURSOR TmpPedidos (cpros C(14), Produzindo N(11, 3))
            ENDIF
            IF USED("cursor_4c_Temp4")
                USE IN cursor_4c_Temp4
            ENDIF

            *-- Calcular quantidade a pedir: diferenca - ja em producao
            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF
            SELECT M.cpros, M.ifors, M.pvens, M.moevs, M.dpros, ;
                M.DifProds - IIF(ISNULL(P.Produzindo), 0, P.Produzindo) AS Qtds ;
                FROM TmpMinimo M ;
                LEFT JOIN TmpPedidos P ON M.cpros = P.cpros ;
                WHERE M.DifProds > IIF(ISNULL(P.Produzindo), 0, P.Produzindo) ;
                INTO CURSOR TmpProd READWRITE

            IF USED("TmpPedidos")
                USE IN TmpPedidos
            ENDIF
            IF USED("TmpMinimo")
                USE IN TmpMinimo
            ENDIF

            SELECT TmpProd
            GO TOP
            IF EOF()
                MsgAviso("Nenhum produto selecionado...", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN TmpProd
                loc_lResultado = .F.
            ENDIF

            *-- Ordenar por fornecedor + produto para agrupar por pedido
            INDEX ON ifors + cpros TAG ForProd
            COUNT TO loc_nTotalReg

            *-- Barra de progresso
            loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Pedidos...", loc_nTotalReg)
            loc_loBarra.Show()

            *-- Buscar dados da operacao (grupo de origem e tipo entrada/saida)
            loc_cSQL = "SELECT dopes, gruorigs, opers FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cOperacao)
            IF USED("cursor_4c_SigCdOpe")
                USE IN cursor_4c_SigCdOpe
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpe")
            SELECT cursor_4c_SigCdOpe
            GO TOP
            IF EOF()
                loc_cGruOrigs = "ESTOQUE"
                loc_nOpers    = 0
            ELSE
                loc_cGruOrigs = IIF(EMPTY(ALLTRIM(gruorigs)), "ESTOQUE", ALLTRIM(gruorigs))
                loc_nOpers    = IIF(VARTYPE(opers) = "N", NVL(opers, 0), IIF(ALLTRIM(TRANSFORM(opers)) = "1", 1, 0))
            ENDIF
            IF USED("cursor_4c_SigCdOpe")
                USE IN cursor_4c_SigCdOpe
            ENDIF

            *-- Iniciar transacao SQL Server
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacaoAberta = .T.

            *-- SCAN: gerar cabecalhos e itens de pedido agrupados por fornecedor
            loc_cFornece = REPL(CHR(255), 10)
            loc_nNumero  = 0
            loc_lnItens  = 0

            SELECT TmpProd
            SCAN
                loc_loBarra.Update(.T.)

                *-- Capturar campos do registro corrente antes de SQLEXEC
                loc_cScanCPros  = ALLTRIM(TmpProd.cpros)
                loc_cScanIFors  = ALLTRIM(TmpProd.ifors)
                loc_nScanPVens  = TmpProd.pvens
                loc_cScanMoevs  = ALLTRIM(TmpProd.moevs)
                loc_cScanDpros  = LEFT(ALLTRIM(TmpProd.dpros), 65)
                loc_nScanQtds   = TmpProd.Qtds

                IF loc_cFornece # loc_cScanIFors
                    *-- Novo fornecedor: gerar numero e inserir cabecalho SigMvCab
                    loc_nNumero     = fGerUniqueKey(ALLTRIM(loc_cOperacao) + loc_cEmpresa)
                    loc_cFornece    = loc_cScanIFors
                    loc_cEmpDopNums = loc_cEmpresa + PADR(loc_cOperacao, 20) + STR(loc_nNumero, 6)
                    loc_cMascNum    = ALLTRIM(fGerMascara(loc_nNumero))

                    loc_cSQL = "INSERT INTO SigMvCab " + ;
                        "(emps, dopes, numes, datas, datars, mascnum, " + ;
                        " grupoos, contaos, grupods, contads, usuars, empdopnums, cidchaves, dtalts) " + ;
                        "VALUES (" + ;
                        EscaparSQL(loc_cEmpresa) + ", " + ;
                        EscaparSQL(PADR(loc_cOperacao, 20)) + ", " + ;
                        FormatarNumeroSQL(loc_nNumero, 0) + ", " + ;
                        FormatarDataSQL(THIS.this_dDatai) + ", " + ;
                        FormatarDataSQL(THIS.this_dDatai) + ", " + ;
                        EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cGruOrigs, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cFornece, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cGrEstoque, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cEstoque, 10)) + ", " + ;
                        EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                        EscaparSQL(loc_cEmpDopNums) + ", " + ;
                        EscaparSQL(fUniqueIds()) + ", " + ;
                        "GETDATE())"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Falha ao inserir cabe" + CHR(231) + "alho do pedido (SigMvCab)", "Erro")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAberta = .F.
                        loc_loBarra.Complete(.T.)
                        IF USED("TmpProd")
                            USE IN TmpProd
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF
                    loc_lnItens = 0
                ENDIF

                *-- Inserir item do pedido (SigMvItn)
                loc_lnItens  = loc_lnItens + 1
                loc_cOpers   = IIF(loc_nOpers = 1, "E", "S")
                loc_nIncVal  = loc_nScanPVens * loc_nScanQtds

                loc_cSQL = "INSERT INTO SigMvItn " + ;
                    "(emps, dopes, numes, citens, cpros, qtds, units, moedas, opers, totas, dpros, empdopnums, cidchaves, dtalts) " + ;
                    "VALUES (" + ;
                    EscaparSQL(loc_cEmpresa) + ", " + ;
                    EscaparSQL(PADR(loc_cOperacao, 20)) + ", " + ;
                    FormatarNumeroSQL(loc_nNumero, 0) + ", " + ;
                    FormatarNumeroSQL(loc_lnItens, 0) + ", " + ;
                    EscaparSQL(loc_cScanCPros) + ", " + ;
                    FormatarNumeroSQL(loc_nScanQtds, 3) + ", " + ;
                    FormatarNumeroSQL(loc_nScanPVens, 5) + ", " + ;
                    EscaparSQL(LEFT(loc_cScanMoevs, 3)) + ", " + ;
                    EscaparSQL(loc_cOpers) + ", " + ;
                    FormatarNumeroSQL(loc_nIncVal, 2) + ", " + ;
                    EscaparSQL(loc_cScanDpros) + ", " + ;
                    EscaparSQL(loc_cEmpDopNums) + ", " + ;
                    EscaparSQL(fUniqueIds()) + ", " + ;
                    "GETDATE())"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao inserir item do pedido (SigMvItn)", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAberta = .F.
                    loc_loBarra.Complete(.T.)
                    IF USED("TmpProd")
                        USE IN TmpProd
                    ENDIF
                    loc_lResultado = .F.
                ENDIF

                *-- Atualizar totais do cabecalho
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                    "valinis = valinis + " + FormatarNumeroSQL(loc_nIncVal, 2) + ", " + ;
                    "valos = valos + " + FormatarNumeroSQL(loc_nIncVal, 2) + ", " + ;
                    "dtalts = GETDATE() " + ;
                    "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
                SQLEXEC(gnConnHandle, loc_cSQL)

                SELECT TmpProd
            ENDSCAN

            *-- Confirmar transacao
            IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") < 1
                MsgErro("Falha ao confirmar a transa" + CHR(231) + CHR(227) + "o", "Erro")
                loc_lTransacaoAberta = .F.
                loc_loBarra.Complete(.T.)
                IF USED("TmpProd")
                    USE IN TmpProd
                ENDIF
                loc_lResultado = .F.
            ENDIF
            loc_lTransacaoAberta = .F.

            loc_loBarra.Complete(.T.)

            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF

            THIS.RegistrarAuditoria("PEDIDO_ESTOQUE_MINIMO")
            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            IF VARTYPE(loc_loBarra) = "O"
                loc_loBarra.Complete(.T.)
            ENDIF
            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF
            IF USED("TmpMinimo")
                USE IN TmpMinimo
            ENDIF
            IF USED("TmpPedidos")
                USE IN TmpPedidos
            ENDIF
            IF USED("cursor_4c_Temp1")
                USE IN cursor_4c_Temp1
            ENDIF
            IF USED("cursor_4c_Temp2")
                USE IN cursor_4c_Temp2
            ENDIF
            IF USED("cursor_4c_Temp3")
                USE IN cursor_4c_Temp3
            ENDIF
            IF USED("cursor_4c_Temp4")
                USE IN cursor_4c_Temp4
            ENDIF
            IF USED("cursor_4c_LinhaOpe")
                USE IN cursor_4c_LinhaOpe
            ENDIF
            IF USED("cursor_4c_SigCdOpe")
                USE IN cursor_4c_SigCdOpe
            ENDIF
            MsgErro(loc_oErro.Message, "Erro no processamento")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora, Empresa) " + ;
                "VALUES (" + ;
                EscaparSQL("SigMvCab") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe o fluxo principal
        ENDTRY
    ENDPROC

ENDDEFINE

