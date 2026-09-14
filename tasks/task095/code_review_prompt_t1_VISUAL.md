# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 275: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREEVV.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1478 linhas total):

*-- Linhas 9 a 18:
9: *   - Grupo cont" + CHR(225) + "bil    (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
10: *   - Conta cont" + CHR(225) + "bil    (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
11: *   - Faixa de valor    (valor inicial / valor final)
12: *   - Incluir Franquias (checkbox)
13: *   - Incluir Zerados   (checkbox)
14: *
15: * FASES 3-7/8 - Estrutura base + corre" + CHR(231) + CHR(245) + "es visuais PILAR 1 + Eventos
16: *   * Propriedades visuais do form (Closable=.F. adicionado - Fase 5)
17: *   * Init() / InicializarForm() / Destroy()
18: *   * ConfigurarCabecalho()  (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)

*-- Linhas 81 a 89:
81:         loc_lSucesso   = .F.
82:         loc_lContinuar = .T.
83:         TRY
84:             THIS.Caption = "Estoque Por Valor de Venda"
85: 
86:             IF TYPE("gc_4c_CaminhoIcones") = "U"
87:                 gc_4c_CaminhoIcones = ""
88:             ENDIF
89:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 109 a 118:
109:                 THIS.ConfigurarPaginaDados()
110:                 THIS.LimparCampos()
111: 
112:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
114: 
115:                 *-- Vincular Click do CommandGroup (equivale ao Click do legado)
116:                 THIS.VincularEventosBotoes()
117: 
118:                 THIS.Visible   = .T.

*-- Linhas 135 a 175:
135:     PROTECTED PROCEDURE ConfigurarCabecalho()
136:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
137:         WITH THIS.cnt_4c_Cabecalho
138:             .Top         = 0
139:             .Left        = 0
140:             .Width       = THIS.Width
141:             .Height      = 80
142:             .BackStyle   = 1
143:             .BackColor   = RGB(100, 100, 100)
144:             .BorderWidth = 0
145:             .Visible     = .T.
146: 
147:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
148:             .AddObject("lbl_4c_Sombra", "Label")
149:             WITH .lbl_4c_Sombra
150:                 .Top       = 22
151:                 .Left      = 22
152:                 .Width     = THIS.Width
153:                 .Height    = 30
154:                 .Caption   = "Estoque Por Valor de Venda"
155:                 .FontName  = "Tahoma"
156:                 .FontSize  = 14
157:                 .FontBold  = .T.
158:                 .ForeColor = RGB(0, 0, 0)
159:                 .BackStyle = 0
160:                 .Visible   = .T.
161:             ENDWITH
162: 
163:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
164:             .AddObject("lbl_4c_Titulo", "Label")
165:             WITH .lbl_4c_Titulo
166:                 .Top       = 20
167:                 .Left      = 20
168:                 .Width     = THIS.Width
169:                 .Height    = 30
170:                 .Caption   = "Estoque Por Valor de Venda"
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 14
173:                 .FontBold  = .T.
174:                 .ForeColor = RGB(255, 255, 255)
175:                 .BackStyle = 0

*-- Linhas 181 a 214:
181:     *--------------------------------------------------------------------------
182:     * ConfigurarBotoes - CommandGroup com bot" + CHR(245) + "es de relat" + CHR(243) + "rio
183:     *   Geometria EXATA do framework frmrelatorio (btnReport).
184:     *   Original: btnReport.Left=526, Top=3, Width~273, Height=80
185:     *   Lefts dos bot" + CHR(245) + "es: 5 / 71 / 137 / 203 (incrementos de 66)
186:     *   Eventos Click vinculados nas fases seguintes (Fase 7).
187:     *--------------------------------------------------------------------------
188:     PROTECTED PROCEDURE ConfigurarBotoes()
189:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
190:         WITH THIS.cmg_4c_Botoes
191:             .Top           = 0
192:             .Left          = 529
193:             .Width         = 273
194:             .Height        = 80
195:             .ButtonCount   = 4
196:             .BackStyle     = 0
197:             .BorderStyle   = 0
198:             .BorderColor   = RGB(136, 189, 188)
199:             .SpecialEffect = 1
200:             .Themes        = .F.
201:             .Visible       = .T.
202: 
203:             *-- Visualizar (preview em tela)
204:             WITH .Buttons(1)
205:                 .Top             = 5
206:                 .Left            = 5
207:                 .Width           = 65
208:                 .Height          = 70
209:                 .Caption         = "Visualizar"
210:                 .FontBold        = .T.
211:                 .FontItalic      = .T.
212:                 .BackColor       = RGB(255, 255, 255)
213:                 .ForeColor       = RGB(90, 90, 90)
214:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 222 a 236:
222: 
223:             *-- Imprimir (impressora padr" + CHR(227) + "o)
224:             WITH .Buttons(2)
225:                 .Top             = 5
226:                 .Left            = 71
227:                 .Width           = 65
228:                 .Height          = 70
229:                 .Caption         = "Imprimir"
230:                 .FontName        = "Comic Sans MS"
231:                 .FontBold        = .T.
232:                 .FontItalic      = .T.
233:                 .FontSize        = 8
234:                 .BackColor       = RGB(255, 255, 255)
235:                 .ForeColor       = RGB(90, 90, 90)
236:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 244 a 258:
244: 
245:             *-- Excel (exportar dados)
246:             WITH .Buttons(3)
247:                 .Top             = 5
248:                 .Left            = 137
249:                 .Width           = 65
250:                 .Height          = 70
251:                 .Caption         = "Excel"
252:                 .FontName        = "Comic Sans MS"
253:                 .FontBold        = .T.
254:                 .FontItalic      = .T.
255:                 .FontSize        = 8
256:                 .BackColor       = RGB(255, 255, 255)
257:                 .ForeColor       = RGB(90, 90, 90)
258:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 266 a 281:
266: 
267:             *-- Encerrar (fechar form)
268:             WITH .Buttons(4)
269:                 .Top             = 5
270:                 .Left            = 203
271:                 .Width           = 65
272:                 .Height          = 70
273:                 .Caption         = "Encerrar"
274:                 .Cancel          = .T.
275:                 .FontName        = "Comic Sans MS"
276:                 .FontBold        = .T.
277:                 .FontItalic      = .T.
278:                 .FontSize        = 8
279:                 .BackColor       = RGB(255, 255, 255)
280:                 .ForeColor       = RGB(90, 90, 90)
281:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 306 a 321:
306:         loc_oPgf.PageCount = 1
307: 
308:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form
309:         loc_oPgf.Top    = 85
310:         loc_oPgf.Left   = -1
311:         loc_oPgf.Width  = THIS.Width + 2
312:         loc_oPgf.Height = THIS.Height - 85
313:         loc_oPgf.Tabs   = .F.
314: 
315:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
316:         loc_oPgf.Page1.Caption   = "Filtros"
317:         loc_oPgf.Page1.FontName  = "Tahoma"
318:         loc_oPgf.Page1.FontSize  = 8
319:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
320:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
321:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 337 a 371:
337:     *--------------------------------------------------------------------------
338:     * ConfigurarPaginaFiltros - Cria todos os controles de filtro em Page1
339:     * Posicoes relativas a Page1 = posicao original no form - PageFrame.Top (85)
340:     * Mapeamento: Say3=lbl_4c_Label3, getTabela=txt_4c_Tabela, etc.
341:     *--------------------------------------------------------------------------
342:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
343:         LOCAL loc_oPag, loc_oErro
344:         TRY
345:             loc_oPag = THIS.pgf_4c_Paginas.Page1
346: 
347:             *-- Rotulo: Tab. Desconto : (Say3 original: top=111 -> 111-85=26)
348:             loc_oPag.AddObject("lbl_4c_Label3", "Label")
349:             WITH loc_oPag.lbl_4c_Label3
350:                 .Top       = 26
351:                 .Left      = 194
352:                 .Width     = 79
353:                 .Height    = 18
354:                 .Caption   = "Tab. Desconto :"
355:                 .FontName  = "Tahoma"
356:                 .FontSize  = 8
357:                 .ForeColor = RGB(90, 90, 90)
358:                 .BackStyle = 0
359:                 .Visible   = .T.
360:             ENDWITH
361: 
362:             *-- Codigo da tabela de desconto (getTabela: top=108 -> 23)
363:             loc_oPag.AddObject("txt_4c_Tabela", "TextBox")
364:             WITH loc_oPag.txt_4c_Tabela
365:                 .Top         = 23
366:                 .Left        = 278
367:                 .Width       = 80
368:                 .Height      = 23
369:                 .Value       = ""
370:                 .FontName    = "Tahoma"
371:                 .FontSize    = 8

*-- Linhas 379 a 388:
379:             *-- Descricao da tabela de desconto (getDTabela: top=108 -> 23)
380:             loc_oPag.AddObject("txt_4c_DTabela", "TextBox")
381:             WITH loc_oPag.txt_4c_DTabela
382:                 .Top         = 23
383:                 .Left        = 360
384:                 .Width       = 255
385:                 .Height      = 23
386:                 .Value       = ""
387:                 .FontName    = "Tahoma"
388:                 .FontSize    = 8

*-- Linhas 394 a 420:
394:             BINDEVENT(loc_oPag.txt_4c_DTabela, "DblClick", THIS, "DTabelaDblClick")
395: 
396:             *-- Rotulo: Grupo : (Say4 original: top=137 -> 52)
397:             loc_oPag.AddObject("lbl_4c_Label4", "Label")
398:             WITH loc_oPag.lbl_4c_Label4
399:                 .Top       = 52
400:                 .Left      = 235
401:                 .Width     = 38
402:                 .Height    = 18
403:                 .Caption   = "Grupo :"
404:                 .FontName  = "Tahoma"
405:                 .FontSize  = 8
406:                 .ForeColor = RGB(90, 90, 90)
407:                 .BackStyle = 0
408:                 .Visible   = .T.
409:             ENDWITH
410: 
411:             *-- Codigo do grupo contabil (getGrupo: top=133 -> 48)
412:             loc_oPag.AddObject("txt_4c_Grupo", "TextBox")
413:             WITH loc_oPag.txt_4c_Grupo
414:                 .Top         = 48
415:                 .Left        = 278
416:                 .Width       = 80
417:                 .Height      = 25
418:                 .Value       = ""
419:                 .MaxLength   = 10
420:                 .FontName    = "Tahoma"

*-- Linhas 430 a 439:
430:             *-- Editavel: usuario digita descricao p/ busca reversa (replica getDGrupo.Valid + fAcessoContab)
431:             loc_oPag.AddObject("txt_4c_DGrupo", "TextBox")
432:             WITH loc_oPag.txt_4c_DGrupo
433:                 .Top         = 48
434:                 .Left        = 360
435:                 .Width       = 150
436:                 .Height      = 25
437:                 .Value       = ""
438:                 .MaxLength   = 20
439:                 .FontName    = "Tahoma"

*-- Linhas 446 a 472:
446:             BINDEVENT(loc_oPag.txt_4c_DGrupo, "DblClick", THIS, "DGrupoDblClick")
447: 
448:             *-- Rotulo: Conta : (lbl_estoque original: top=165 -> 80)
449:             loc_oPag.AddObject("lbl_4c_Lbl_estoque", "Label")
450:             WITH loc_oPag.lbl_4c_Lbl_estoque
451:                 .Top       = 80
452:                 .Left      = 235
453:                 .Width     = 38
454:                 .Height    = 18
455:                 .Caption   = "Conta :"
456:                 .FontName  = "Tahoma"
457:                 .FontSize  = 8
458:                 .ForeColor = RGB(90, 90, 90)
459:                 .BackStyle = 0
460:                 .Visible   = .T.
461:             ENDWITH
462: 
463:             *-- Codigo da conta contabil (getConta: top=160 -> 75)
464:             loc_oPag.AddObject("txt_4c_Conta", "TextBox")
465:             WITH loc_oPag.txt_4c_Conta
466:                 .Top         = 75
467:                 .Left        = 278
468:                 .Width       = 80
469:                 .Height      = 25
470:                 .Value       = ""
471:                 .MaxLength   = 10
472:                 .FontName    = "Tahoma"

*-- Linhas 481 a 490:
481:             *-- Descricao da conta contabil (getDConta: top=160 -> 75) - somente leitura
482:             loc_oPag.AddObject("txt_4c_DConta", "TextBox")
483:             WITH loc_oPag.txt_4c_DConta
484:                 .Top         = 75
485:                 .Left        = 360
486:                 .Width       = 298
487:                 .Height      = 25
488:                 .Value       = ""
489:                 .MaxLength   = 40
490:                 .FontName    = "Tahoma"

*-- Linhas 497 a 610:
497:             BINDEVENT(loc_oPag.txt_4c_DConta, "DblClick", THIS, "DContaDblClick")
498: 
499:             *-- Rotulo: Faixa de Valor : (Say1 original: top=190 -> 105)
500:             loc_oPag.AddObject("lbl_4c_Label1", "Label")
501:             WITH loc_oPag.lbl_4c_Label1
502:                 .Top       = 105
503:                 .Left      = 196
504:                 .Width     = 77
505:                 .Height    = 18
506:                 .Caption   = "Faixa de Valor :"
507:                 .FontName  = "Tahoma"
508:                 .FontSize  = 8
509:                 .ForeColor = RGB(90, 90, 90)
510:                 .BackStyle = 0
511:                 .Visible   = .T.
512:             ENDWITH
513: 
514:             *-- Valor inicial da faixa (getValorIni: top=187 -> 102)
515:             loc_oPag.AddObject("txt_4c_ValorIni", "TextBox")
516:             WITH loc_oPag.txt_4c_ValorIni
517:                 .Top       = 102
518:                 .Left      = 278
519:                 .Width     = 80
520:                 .Height    = 23
521:                 .Value     = 0
522:                 .InputMask = "9999999.99"
523:                 .FontName  = "Tahoma"
524:                 .FontSize  = 8
525:                 .ForeColor = RGB(0, 0, 0)
526:                 .Visible   = .T.
527:             ENDWITH
528: 
529:             *-- Separador de faixa (Say2 original: top=190 -> 105, CHR(224)=a-grave="a")
530:             loc_oPag.AddObject("lbl_4c_Label2", "Label")
531:             WITH loc_oPag.lbl_4c_Label2
532:                 .Top       = 105
533:                 .Left      = 364
534:                 .Width     = 8
535:                 .Height    = 18
536:                 .Caption   = CHR(224)
537:                 .FontName  = "Tahoma"
538:                 .FontSize  = 8
539:                 .ForeColor = RGB(90, 90, 90)
540:                 .BackStyle = 0
541:                 .Visible   = .T.
542:             ENDWITH
543: 
544:             *-- Valor final da faixa (getValorFin: top=187 -> 102)
545:             loc_oPag.AddObject("txt_4c_ValorFin", "TextBox")
546:             WITH loc_oPag.txt_4c_ValorFin
547:                 .Top       = 102
548:                 .Left      = 374
549:                 .Width     = 80
550:                 .Height    = 23
551:                 .Value     = 0
552:                 .InputMask = "9999999.99"
553:                 .FontName  = "Tahoma"
554:                 .FontSize  = 8
555:                 .ForeColor = RGB(0, 0, 0)
556:                 .Visible   = .T.
557:             ENDWITH
558: 
559:             *-- Checkbox: Incluir Franquias (chkFranquias: top=213 -> 128)
560:             loc_oPag.AddObject("chk_4c_ChkFranquias", "CheckBox")
561:             WITH loc_oPag.chk_4c_ChkFranquias
562:                 .Top      = 128
563:                 .Left     = 278
564:                 .Width    = 130
565:                 .Height   = 20
566:                 .Caption  = "Incluir Franquias"
567:                 .Value    = 0
568:                 .FontName = "Tahoma"
569:                 .FontSize = 8
570:                 .Visible  = .T.
571:             ENDWITH
572: 
573:             *-- Checkbox: Incluir Zerados (chkZerados: top=213 -> 128)
574:             loc_oPag.AddObject("chk_4c_ChkZerados", "CheckBox")
575:             WITH loc_oPag.chk_4c_ChkZerados
576:                 .Top      = 128
577:                 .Left     = 418
578:                 .Width    = 130
579:                 .Height   = 20
580:                 .Caption  = "Incluir Zerados"
581:                 .Value    = 0
582:                 .FontName = "Tahoma"
583:                 .FontSize = 8
584:                 .Visible  = .T.
585:             ENDWITH
586: 
587:             *-- Container de mensagem (cntMensagem original: top=510, off-screen em form height=300)
588:             loc_oPag.AddObject("cnt_4c_Mensagem", "Container")
589:             WITH loc_oPag.cnt_4c_Mensagem
590:                 .Top       = 300
591:                 .Left      = 152
592:                 .Width     = 473
593:                 .Height    = 56
594:                 .BackStyle = 1
595:                 .BackColor = RGB(255, 255, 200)
596:                 .BorderWidth = 1
597:                 .Visible   = .F.
598: 
599:                 .AddObject("lbl_4c_LblMensagem", "Label")
600:                 WITH .lbl_4c_LblMensagem
601:                     .Top       = 18
602:                     .Left      = 20
603:                     .Width     = 445
604:                     .Height    = 22
605:                     .Caption   = "Aguarde!!!"
606:                     .FontName  = "Tahoma"
607:                     .FontSize  = 8
608:                     .ForeColor = RGB(90, 90, 90)
609:                     .BackStyle = 0
610:                     .Visible   = .T.

*-- Linhas 1347 a 1355:
1347:             loc_oPag.txt_4c_Conta.FontSize = 9
1348: 
1349:             *-- lblMensagem: propriedades originais (FontBold=.T., FontSize=12, Alignment=2 centralizado, ForeColor azul)
1350:             WITH loc_oPag.cnt_4c_Mensagem.lbl_4c_LblMensagem
1351:                 .FontBold  = .T.
1352:                 .FontSize  = 12
1353:                 .Alignment = 2
1354:                 .ForeColor = RGB(0, 0, 128)
1355:             ENDWITH


### BO (C:\4c\projeto\app\classes\SIGREEVVBO.prg):
*==============================================================================
* SIGREEVVBO.PRG
* Business Object para Relatorio - Estoque Por Valor de Venda (SIGREEVV)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvEst, SigCdPro, SigCdMoe, SigCdEmp
* Relatorio FRX: SigReEvv.frx
*
* Filtros:
*   - Tabela de desconto (codigo + descricao + percentual - SigOpTdz)
*   - Grupo contabil    (codigo + descricao)
*   - Conta contabil    (codigo + descricao)
*   - Faixa de valor    (valor inicial / valor final)
*   - Incluir Franquias (checkbox)
*   - Incluir Zerados   (checkbox)
*==============================================================================

DEFINE CLASS SIGREEVVBO AS RelatorioBase

    *-- Filtro: tabela de desconto (SigOpTdz)
    this_cCodTab     = ""    && Codigo da tabela de desconto (getTabela no legado)
    this_cDsTab      = ""    && Descricao da tabela de desconto (getDTabela no legado)
    this_nPercentual = 0     && Percentual de desconto (Descos de SigOpTdz)

    *-- Filtro: grupo contabil
    this_cGrupo      = ""    && Codigo do grupo contabil (getGrupo no legado)
    this_cDGrupo     = ""    && Descricao do grupo contabil (getDGrupo no legado)

    *-- Filtro: conta contabil
    this_cConta      = ""    && Codigo da conta contabil (getConta no legado)
    this_cDConta     = ""    && Descricao da conta contabil (getDConta no legado)

    *-- Filtro: faixa de valor de venda
    this_nValorIni   = 0     && Valor inicial da faixa (getValorIni no legado)
    this_nValorFin   = 0     && Valor final da faixa (getValorFin no legado)

    *-- Filtro: opcoes de inclusao
    this_lFranquias  = .F.   && Incluir empresas franquias (chkFranquias no legado)
    this_lZerados    = .F.   && Incluir itens com quantidade zerada (chkZerados no legado)

    *-- Cursor de saida populado por PrepararDados() - usado pelo REPORT FORM SigReEvv
    this_cCursorDados = "crImprimir"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de estoque por valor de venda
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvEst"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCotacao - Busca cotacao da moeda em SigCdCot (equivale a fBuscarCotacao)
    * par_cMoeda: codigo da moeda (3 chars)
    * Retorna: valor da cotacao (0 se nao encontrada)
    *--------------------------------------------------------------------------
    PROCEDURE ObterCotacao(par_cMoeda)
        LOCAL loc_nValor, loc_nResult
        loc_nValor = 0
        IF !EMPTY(par_cMoeda)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                " ORDER BY datas DESC, horas DESC", ;
                "cursor_4c_CotacaoTemp")
            IF loc_nResult > 0
                SELECT cursor_4c_CotacaoTemp
                IF !EOF()
                    loc_nValor = cursor_4c_CotacaoTemp.valos
                ENDIF
                USE IN cursor_4c_CotacaoTemp
            ENDIF
        ENDIF
        RETURN loc_nValor
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio Estoque Por Valor de Venda
    * Replica logica do PROCEDURE processamento do SIGREEVV.SCX legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lOk, loc_oErro
        LOCAL loc_cTab, loc_cGru, loc_cCon, loc_cDtb
        LOCAL loc_nVlI, loc_nVlF, loc_nPct
        LOCAL loc_llFra, loc_llZer
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cSubTitulo, loc_cFaixa, loc_cEmpresa
        LOCAL loc_cEmpCod
        LOCAL loc_nTot, loc_nOrd

        loc_lSucesso = .F.
        loc_lOk      = .T.

        TRY
            *-- Extrair filtros das propriedades do BO
            loc_cTab  = PADR(ALLTRIM(THIS.this_cCodTab), 10)
            loc_cGru  = PADR(ALLTRIM(THIS.this_cGrupo),  10)
            loc_cCon  = PADR(ALLTRIM(THIS.this_cConta),  10)
            loc_cDtb  = PADR(ALLTRIM(THIS.this_cDsTab),  30)
            loc_nVlI  = THIS.this_nValorIni
            loc_nVlF  = THIS.this_nValorFin
            loc_nPct  = 1 - (THIS.this_nPercentual / 100)
            loc_llFra = THIS.this_lFranquias
            loc_llZer = THIS.this_lZerados

            *-- Subtitulo e faixa de valor para cabecalho do relatorio
            loc_cSubTitulo = "Tabela : " + ALLTRIM(loc_cTab) + " - " + ALLTRIM(loc_cDtb) + ;
                IIF(EMPTY(ALLTRIM(loc_cGru)), "", " - Grupo : " + ALLTRIM(loc_cGru)) + ;
                IIF(EMPTY(ALLTRIM(loc_cCon)), "", " - Conta : " + ALLTRIM(loc_cCon))
            loc_cFaixa = ALLTRIM(STR(loc_nVlI, 10)) + " / " + ALLTRIM(STR(loc_nVlF, 10))

            *-- Obter codigo da empresa atual
            loc_cEmpCod = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cEmpresa = loc_cEmpCod

            *-- Criar cursor de cabecalho do relatorio
            IF USED("crCabecalho")
                USE IN crCabecalho
            ENDIF
            CREATE CURSOR crCabecalho (Empresa c(80), Titulo c(80), SubTitulo c(80), ;
                Faixa c(80), MedFaixa n(10,2), MedGeral n(10,2))
            INSERT INTO crCabecalho (Empresa, Titulo, SubTitulo, Faixa) ;
                VALUES (loc_cEmpresa, "Estoque Por Valor de Venda", loc_cSubTitulo, loc_cFaixa)

            *-- PASSO 1: Cotacoes de todas as moedas (Valor=cotacao propria, ValCustos=cotacao equivalente)
            IF USED("crSigCdMoe")
                USE IN crSigCdMoe
            ENDIF
            loc_cSQL = "SELECT cmoes, moeqs, qtdeqs, " + ;
                "CAST(0 AS NUMERIC(15,6)) AS Valor, " + ;
                "CAST(0 AS NUMERIC(15,6)) AS ValCustos " + ;
                "FROM SigCdMoe ORDER BY cmoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao consultar moedas (SigCdMoe)"
                loc_lOk = .F.
            ENDIF

            IF loc_lOk
                SELECT crSigCdMoe
                SCAN
                    IF !EMPTY(ALLTRIM(crSigCdMoe.moeqs))
                        REPLACE ValCustos WITH THIS.ObterCotacao(ALLTRIM(crSigCdMoe.moeqs)) * ;
                            crSigCdMoe.qtdeqs IN crSigCdMoe
                    ELSE
                        REPLACE ValCustos WITH THIS.ObterCotacao(ALLTRIM(crSigCdMoe.cmoes)) IN crSigCdMoe
                    ENDIF
                    REPLACE Valor WITH THIS.ObterCotacao(ALLTRIM(crSigCdMoe.cmoes)) IN crSigCdMoe
                ENDSCAN
            ENDIF

            *-- PASSO 2: Estoque agrupado por empresa e produto (com filtros de grupo/conta)
            IF loc_lOk
                IF USED("crSigMvEst")
                    USE IN crSigMvEst
                ENDIF
                loc_cSQL = "SELECT emps, cpros, SUM(sqtds) AS SQtds " + ;
                    "FROM SigMvEst " + ;
                    "WHERE 0 = 0" + ;
                    IIF(EMPTY(ALLTRIM(loc_cGru)), "", " AND grupos = " + EscaparSQL(ALLTRIM(loc_cGru))) + ;
                    IIF(EMPTY(ALLTRIM(loc_cCon)), "", " AND estos = " + EscaparSQL(ALLTRIM(loc_cCon))) + ;
                    " GROUP BY emps, cpros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvEst")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar estoques (SigMvEst)"
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                SELECT crSigMvEst
                INDEX ON cpros TAG cpros
            ENDIF

            *-- PASSO 3: Empresas a excluir (inativas, sem funcionarios, franquias se aplicavel)
            IF loc_lOk
                IF USED("crSigCdEmpExcl")
                    USE IN crSigCdEmpExcl
                ENDIF
                loc_cSQL = "SELECT cemps FROM SigCdEmp " + ;
                    "WHERE nemps < 1" + ;
                    IIF(loc_llFra, "", " OR nums = '1' ") + ;
                    "ORDER BY cemps"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmpExcl")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar empresas (SigCdEmp)"
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                SET DELETED ON
                SELECT crSigCdEmpExcl
                SCAN
                    DELETE FROM crSigMvEst WHERE emps = crSigCdEmpExcl.cemps
                ENDSCAN
                USE IN crSigCdEmpExcl
            ENDIF

            *-- PASSO 4: Dados dos produtos (preco venda, moeda, custo, moeda custo)
            IF loc_lOk
                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF
                loc_cSQL = "SELECT cpros, pvens, moevs, custofs, moecusfs " + ;
                    "FROM SigCdPro ORDER BY cpros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar produtos (SigCdPro)"
                    loc_lOk = .F.
                ENDIF
            ENDIF

            *-- PASSO 5: Calcular valor de venda (estoque x preco x cotacao x percentual desconto)
            IF loc_lOk
                IF USED("crVenda")
                    USE IN crVenda
                ENDIF
                SELECT a.emps, a.cpros, ;
                    a.SQtds * b.pvens * c.Valor * loc_nPct AS PVens, ;
                    b.moevs, a.SQtds, a.SQtds * b.custofs AS CustoFs, b.moecusfs ;
                    FROM crSigMvEst a, crSigCdPro b, crSigCdMoe c ;
                    WHERE a.cpros = b.cpros AND b.moevs = c.cmoes ;
                    INTO CURSOR crVenda READWRITE
                IF USED("crSigMvEst")
                    USE IN crSigMvEst
                ENDIF
            ENDIF

            *-- PASSO 6: Converter custo para moeda base usando ValCustos da moeda
            IF loc_lOk
                IF USED("crProcessar")
                    USE IN crProcessar
                ENDIF
                SELECT a.emps, a.cpros, a.PVens, a.moevs, a.SQtds, ;
                    a.CustoFs * b.ValCustos AS CustoFs, a.moecusfs ;
                    FROM crVenda a, crSigCdMoe b ;
                    WHERE a.moecusfs = b.cmoes ;
                    ORDER BY a.emps, a.cpros ;
                    INTO CURSOR crProcessar READWRITE
                IF USED("crVenda")
                    USE IN crVenda
                ENDIF
                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF
                IF USED("crSigCdMoe")
                    USE IN crSigCdMoe
                ENDIF
            ENDIF

            *-- PASSO 7: Totalizar por empresa - todas as quantidades e valores
            IF loc_lOk
                IF USED("crTotPorEmp")
                    USE IN crTotPorEmp
                ENDIF
                SELECT emps, SUM(SQtds) AS Qtds, SUM(PVens) AS Total, SUM(CustoFs) AS TotalCusto ;
                    FROM crProcessar ;
                    GROUP BY emps ;
                    INTO CURSOR crTotPorEmp READWRITE
            ENDIF

            *-- PASSO 8: Totalizar por empresa - apenas itens dentro da faixa de valor informada
            IF loc_lOk
                IF USED("crTotPorFxa")
                    USE IN crTotPorFxa
                ENDIF
                SELECT emps, SUM(SQtds) AS Qtds, SUM(PVens) AS Total, SUM(CustoFs) AS TotalCusto ;
                    FROM crProcessar ;
                    WHERE (PVens / SQtds) BETWEEN loc_nVlI AND loc_nVlF ;
                    GROUP BY emps ;
                    INTO CURSOR crTotPorFxa READWRITE
                IF USED("crProcessar")
                    USE IN crProcessar
                ENDIF
            ENDIF

            *-- PASSO 9: Montar cursor final crImprimir com LEFT JOIN faixa e geral por empresa
            IF loc_lOk
                IF USED("crImprimir")
                    USE IN crImprimir
                ENDIF
                SELECT a.emps, ;
                    VAL(STR(NVL(b.Qtds, 0), 15, 2)) AS QtdsFaixa, ;
                    VAL(STR(NVL(b.Total, 0), 15, 2)) AS TotalFaixa, ;
                    VAL(STR(a.Qtds, 15, 2)) AS QtdsGeral, ;
                    VAL(STR(a.Total, 15, 2)) AS TotalGeral, ;
                    0.00 AS PctFaixa, 0.00 AS PctGeral, ;
                    VAL(STR(a.TotalCusto, 15, 2)) AS TotCusGeral, ;
                    VAL(STR(NVL(b.TotalCusto, 0), 15, 2)) AS TotCusFaixa, ;
                    0 AS Ordem ;
                    FROM crTotPorEmp a LEFT JOIN crTotPorFxa b ON a.emps = b.emps ;
                    ORDER BY a.emps ;
                    INTO CURSOR crImprimir READWRITE
                IF USED("crTotPorEmp")
                    USE IN crTotPorEmp
                ENDIF
                IF USED("crTotPorFxa")
                    USE IN crTotPorFxa
                ENDIF
            ENDIF

            *-- PASSO 10: Calcular percentuais e marcar como excluidos os zerados (se !llZer)
            IF loc_lOk
                SELECT crImprimir
                SUM TotalFaixa TO loc_nTot
                loc_nOrd = 0
                GO TOP
                SCAN
                    IF crImprimir.TotalFaixa <> 0
                        REPLACE PctFaixa WITH (crImprimir.TotalFaixa / loc_nTot) * 100, ;
                            PctGeral WITH (crImprimir.TotalFaixa / crImprimir.TotalGeral) * 100 ;
                            IN crImprimir
                    ENDIF
                    IF !loc_llZer AND EMPTY(crImprimir.QtdsFaixa)
                        DELETE IN crImprimir
                    ELSE
                        loc_nOrd = loc_nOrd + 1
                        REPLACE Ordem WITH loc_nOrd IN crImprimir
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 11: Calcular medias e atualizar cabecalho do relatorio
            IF loc_lOk
                IF USED("crMedias")
                    USE IN crMedias
                ENDIF
                SELECT AVG(PctFaixa) AS MedFaixa, AVG(PctGeral) AS MedGeral ;
                    FROM crImprimir ;
                    INTO CURSOR crMedias
                GO TOP IN crMedias
                REPLACE MedFaixa WITH NVL(crMedias.MedFaixa, 0), ;
                    MedGeral WITH NVL(crMedias.MedGeral, 0) IN crCabecalho
                USE IN crMedias
            ENDIF

            IF loc_lOk
                SELECT crImprimir
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Relat" + CHR(243) + "rio Estoque Por Valor de Venda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "SigReEvv") TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe o relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "SigReEvv") PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria de tabela
    * Retorna identificador composto dos filtros usado para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TAB=" + ALLTRIM(THIS.this_cCodTab) + ;
                     ";GRU=" + ALLTRIM(THIS.this_cGrupo) + ;
                     ";CON=" + ALLTRIM(THIS.this_cConta) + ;
                     ";VLI=" + ALLTRIM(STR(THIS.this_nValorIni, 15, 2)) + ;
                     ";VLF=" + ALLTRIM(STR(THIS.this_nValorFin, 15, 2)) + ;
                     ";PCT=" + ALLTRIM(STR(THIS.this_nPercentual, 6, 2)) + ;
                     ";FRA=" + IIF(THIS.this_lFranquias, "S", "N") + ;
                     ";ZER=" + IIF(THIS.this_lZerados, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao
    * par_cAliasCursor: cursor com colunas no formato preset
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + ;
                                          CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.cCodTab") = "C"
                        THIS.this_cCodTab = ALLTRIM(m.cCodTab)
                    ENDIF
                    IF TYPE("m.cDsTab") = "C"
                        THIS.this_cDsTab = ALLTRIM(m.cDsTab)
                    ENDIF
                    IF TYPE("m.nPercentual") = "N"
                        THIS.this_nPercentual = m.nPercentual
                    ENDIF
                    IF TYPE("m.cGrupo") = "C"
                        THIS.this_cGrupo = ALLTRIM(m.cGrupo)
                    ENDIF
                    IF TYPE("m.cDGrupo") = "C"
                        THIS.this_cDGrupo = ALLTRIM(m.cDGrupo)
                    ENDIF
                    IF TYPE("m.cConta") = "C"
                        THIS.this_cConta = ALLTRIM(m.cConta)
                    ENDIF
                    IF TYPE("m.cDConta") = "C"
                        THIS.this_cDConta = ALLTRIM(m.cDConta)
                    ENDIF
                    IF TYPE("m.nValorIni") = "N"
                        THIS.this_nValorIni = m.nValorIni
                    ENDIF
                    IF TYPE("m.nValorFin") = "N"
                        THIS.this_nValorFin = m.nValorFin
                    ENDIF
                    IF TYPE("m.lFranquias") = "L"
                        THIS.this_lFranquias = m.lFranquias
                    ENDIF
                    IF TYPE("m.lZerados") = "L"
                        THIS.this_lZerados = m.lZerados
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Aplica as mesmas validacoes do Click do legado
    * (Tabela obrigatoria, Valor Inicial >= 0, Valor Inicial <= Valor Final)
    * Retorna .T. se filtros estao validos, .F. caso contrario (mensagem em this_cMensagemErro)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(ALLTRIM(THIS.this_cCodTab))
            THIS.this_cMensagemErro = "Tabela de Desconto Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nValorIni < 0
            THIS.this_cMensagemErro = "Faixa Inicial de Valor Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nValorIni > THIS.this_nValorFin
            THIS.this_cMensagemErro = "Faixa Inicial de Valor Maior do Que a Final!!!"
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                loc_lSucesso = THIS.Imprimir()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Valida filtros obrigatorios, delega para Visualizar() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                loc_lSucesso = THIS.Visualizar()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZACAO")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReEvv") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de todos os cursores criados pelo relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(11), loc_nI
        loc_aCursores(1)  = "crCabecalho"
        loc_aCursores(2)  = "crSigCdMoe"
        loc_aCursores(3)  = "crSigMvEst"
        loc_aCursores(4)  = "crSigCdEmpExcl"
        loc_aCursores(5)  = "crSigCdPro"
        loc_aCursores(6)  = "crVenda"
        loc_aCursores(7)  = "crProcessar"
        loc_aCursores(8)  = "crTotPorEmp"
        loc_aCursores(9)  = "crTotPorFxa"
        loc_aCursores(10) = "crImprimir"
        loc_aCursores(11) = "crMedias"
        FOR loc_nI = 1 TO 11
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

ENDDEFINE

