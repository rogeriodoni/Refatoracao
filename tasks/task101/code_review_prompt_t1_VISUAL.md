# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (35)
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Razão Social' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Razão Social' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'DesmarcarOpe' (parent: SIGREFFI): Top original=403 vs migrado 'cmd_4c_DesmarcarOpe' Top=318 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'MarcarOpe' (parent: SIGREFFI): Top original=363 vs migrado 'cmd_4c_DesmarcarOpe' Top=318 (diff=45px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'DesmarcarEmp' (parent: SIGREFFI): Top original=209 vs migrado 'cmd_4c_DesmarcarEmp' Top=124 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'MarcarEmp' (parent: SIGREFFI): Top original=169 vs migrado 'cmd_4c_MarcarEmp' Top=84 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Lista_Atra' (parent: SIGREFFI): Top original=313 vs migrado 'obj_4c_Opt_lista_atra' Top=5 (diff=308px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Lista_Atra' (parent: SIGREFFI): Left original=180 vs migrado 'obj_4c_Opt_lista_atra' Left=5 (diff=175px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Lista_op' (parent: SIGREFFI): Top original=348 vs migrado 'obj_4c_Opt_lista_op' Top=5 (diff=343px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Lista_op' (parent: SIGREFFI): Left original=180 vs migrado 'obj_4c_Opt_lista_op' Left=5 (diff=175px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Consid_Atra' (parent: SIGREFFI): Top original=331 vs migrado 'obj_4c_Opt_consid_atra' Top=5 (diff=326px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Consid_Atra' (parent: SIGREFFI): Left original=180 vs migrado 'obj_4c_Opt_consid_atra' Left=5 (diff=175px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'DesmarcarDisp' (parent: SIGREFFI): Top original=456 vs migrado 'cmd_4c_DesmarcarDisp' Top=371 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'MarcarDisp' (parent: SIGREFFI): Top original=416 vs migrado 'cmd_4c_MarcarDisp' Top=331 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_situa' (parent: SIGREFFI): Top original=240 vs migrado 'obj_4c_Opt_situa' Top=5 (diff=235px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_situa' (parent: SIGREFFI): Left original=94 vs migrado 'obj_4c_Opt_situa' Left=5 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_ordem_impressao' (parent: SIGREFFI): Top original=258 vs migrado 'obj_4c_Opt_ordem_impressao' Top=5 (diff=253px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_ordem_impressao' (parent: SIGREFFI): Left original=94 vs migrado 'obj_4c_Opt_ordem_impressao' Left=5 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_nr_tipo' (parent: SIGREFFI): Top original=223 vs migrado 'obj_4c_Opt_nr_tipo' Top=5 (diff=218px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_nr_tipo' (parent: SIGREFFI): Left original=94 vs migrado 'obj_4c_Opt_nr_tipo' Left=5 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Data' (parent: SIGREFFI): Top original=134 vs migrado 'obj_4c_Opt_Data' Top=5 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Data' (parent: SIGREFFI): Left original=275 vs migrado 'obj_4c_Opt_Data' Left=5 (diff=270px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreffi.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2325 linhas total):

*-- Linhas 15 a 25:
15: *   - Previsto (Sim/N" + CHR(227) + "o/Ambos)
16: *   - Saldo (Anterior / Na Data)
17: *   - Atrasos (Considerar / Listar / Listar C" + CHR(243) + "d. Opera" + CHR(231) + CHR(227) + "o)
18: *   - Empresas selecion" + CHR(225) + "veis (Grid1 com CheckBox - SigCdEmp)
19: *   - Disponibilidades selecion" + CHR(225) + "veis (Grid2 com CheckBox - SigCdDis)
20: *   - Opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos selecion" + CHR(225) + "veis (Grd_Oper com CheckBox - SigOpOpe)
21: *
22: * FASES 3-7/8 COMPLETO - Form: Estrutura Base + Grids + Filtros + Lookups + Eventos
23: *   * Propriedades visuais do form
24: *   * Init() / InicializarForm() / Destroy()
25: *   * ConfigurarCabecalho()   (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)

*-- Linhas 80 a 88:
80:         loc_lSucesso   = .F.
81:         loc_lContinuar = .T.
82:         TRY
83:             THIS.Caption = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico"
84: 
85:             IF TYPE("gc_4c_CaminhoIcones") = "U"
86:                 gc_4c_CaminhoIcones = ""
87:             ENDIF
88:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 116 a 125:
116:                 *-- PageFrame com p" + CHR(225) + "gina de filtros
117:                 THIS.ConfigurarPageFrame()
118: 
119:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
120:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
121: 
122:                 *-- Controles de filtro na Page1 do PageFrame (grids selecionaveis + botoes)
123:                 THIS.ConfigurarPaginaLista()
124: 
125:                 *-- Garante que a unica pagina disponivel esteja ativa

*-- Linhas 153 a 230:
153:     PROTECTED PROCEDURE ConfigurarCabecalho()
154:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
155:         WITH THIS.cnt_4c_Cabecalho
156:             .Top         = 0
157:             .Left        = 0
158:             .Width       = THIS.Width
159:             .Height      = 80
160:             .BackStyle   = 1
161:             .BackColor   = RGB(100, 100, 100)
162:             .BorderWidth = 0
163:             .Visible     = .T.
164: 
165:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
166:             .AddObject("lbl_4c_Sombra", "Label")
167:             WITH .lbl_4c_Sombra
168:                 .Top       = 22
169:                 .Left      = 22
170:                 .Width     = THIS.Width
171:                 .Height    = 30
172:                 .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico"
173:                 .FontName  = "Tahoma"
174:                 .FontSize  = 14
175:                 .FontBold  = .T.
176:                 .ForeColor = RGB(0, 0, 0)
177:                 .BackStyle = 0
178:                 .Visible   = .T.
179:             ENDWITH
180: 
181:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
182:             .AddObject("lbl_4c_Titulo", "Label")
183:             WITH .lbl_4c_Titulo
184:                 .Top       = 20
185:                 .Left      = 20
186:                 .Width     = THIS.Width
187:                 .Height    = 30
188:                 .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico"
189:                 .FontName  = "Tahoma"
190:                 .FontSize  = 14
191:                 .FontBold  = .T.
192:                 .ForeColor = RGB(255, 255, 255)
193:                 .BackStyle = 0
194:                 .Visible   = .T.
195:             ENDWITH
196:         ENDWITH
197:     ENDPROC
198: 
199:     *--------------------------------------------------------------------------
200:     * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es do relat" + CHR(243) + "rio
201:     *   Original: btnReport.Left=527, Top=3
202:     *   Bot" + CHR(245) + "es: Visualiza(Left=6), Imprime(72), DocExcel(138), Sair(204)
203:     *--------------------------------------------------------------------------
204:     PROTECTED PROCEDURE ConfigurarBotoes()
205:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
206:         WITH THIS.cmg_4c_Botoes
207:             .Top           = 0
208:             .Left          = 529
209:             .Width         = 273
210:             .Height        = 80
211:             .ButtonCount   = 4
212:             .BackStyle     = 0
213:             .BorderStyle   = 0
214:             .BorderColor   = RGB(136, 189, 188)
215:             .SpecialEffect = 1
216:             .Themes        = .F.
217:             .Visible       = .T.
218: 
219:             *-- Visualizar (preview em tela)
220:             WITH .Buttons(1)
221:                 .Top             = 5
222:                 .Left            = 5
223:                 .Width           = 65
224:                 .Height          = 70
225:                 .Caption         = "Visualizar"
226:                 .FontBold        = .T.
227:                 .FontItalic      = .T.
228:                 .BackColor       = RGB(255, 255, 255)
229:                 .ForeColor       = RGB(90, 90, 90)
230:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 238 a 250:
238: 
239:             *-- Imprimir (impressora com di" + CHR(225) + "logo)
240:             WITH .Buttons(2)
241:                 .Top             = 5
242:                 .Left            = 71
243:                 .Width           = 65
244:                 .Height          = 70
245:                 .Caption         = "Imprimir"
246:                 .FontName        = "Tahoma"
247:                 .FontBold        = .T.
248:                 .FontItalic      = .T.
249:                 .FontSize        = 8
250:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 260 a 272:
260: 
261:             *-- Excel (exportar para XLS)
262:             WITH .Buttons(3)
263:                 .Top             = 5
264:                 .Left            = 137
265:                 .Width           = 65
266:                 .Height          = 70
267:                 .Caption         = "Excel"
268:                 .FontName        = "Tahoma"
269:                 .FontBold        = .T.
270:                 .FontItalic      = .T.
271:                 .FontSize        = 8
272:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 282 a 294:
282: 
283:             *-- Encerrar (fechar form - ESC)
284:             WITH .Buttons(4)
285:                 .Top             = 5
286:                 .Left            = 203
287:                 .Width           = 65
288:                 .Height          = 70
289:                 .Caption         = "Encerrar"
290:                 .Cancel          = .T.
291:                 .FontName        = "Tahoma"
292:                 .FontBold        = .T.
293:                 .FontItalic      = .T.
294:                 .FontSize        = 8

*-- Linhas 320 a 335:
320:         loc_oPgf.PageCount = 1
321: 
322:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form
323:         loc_oPgf.Top    = 85
324:         loc_oPgf.Left   = -1
325:         loc_oPgf.Width  = THIS.Width + 2
326:         loc_oPgf.Height = THIS.Height - 85
327:         loc_oPgf.Tabs   = .F.
328: 
329:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
330:         loc_oPgf.Page1.Caption   = "Filtros"
331:         loc_oPgf.Page1.FontName  = "Tahoma"
332:         loc_oPgf.Page1.FontSize  = 8
333:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
334:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
335:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 342 a 350:
342:     * ConfigurarPaginaLista - Grids selecionaveis e botoes Marcar/Desmarcar (FASE 4/8)
343:     *   Em forms REPORT, a "Pagina Lista" hospeda os grids que listam itens
344:     *   selecionaveis pelo usuario (Empresas, Disponibilidades, Operacoes).
345:     *   Cada grid tem CheckBox na Column1 ligado a coluna LOGICAL do cursor +
346:     *   2 botoes laterais (Marcar todos / Desmarcar todos).
347:     *   Fases 5-6 adicionam controles de filtro (periodo, moeda, opcoes, etc.)
348:     *--------------------------------------------------------------------------
349:     PROTECTED PROCEDURE ConfigurarPaginaLista()
350:         LOCAL loc_oPag, loc_oErro

*-- Linhas 400 a 427:
400:         LOCAL loc_oGrd, loc_oErro
401:         TRY
402:             *-- Label Empresas (original: top=136, left=376, width=57)
403:             par_oPag.AddObject("lbl_4c_LblEmpresas", "Label")
404:             WITH par_oPag.lbl_4c_LblEmpresas
405:                 .Top       = 51
406:                 .Left      = 376
407:                 .Width     = 57
408:                 .Height    = 15
409:                 .Caption   = "Empresas"
410:                 .FontName  = "Tahoma"
411:                 .FontSize  = 8
412:                 .ForeColor = RGB(90, 90, 90)
413:                 .BackStyle = 0
414:                 .Visible   = .T.
415:             ENDWITH
416: 
417:             *-- Grid de empresas (original: top=152, left=377, width=341, height=111)
418:             par_oPag.AddObject("grd_4c_Empresas", "Grid")
419:             loc_oGrd = par_oPag.grd_4c_Empresas
420:             WITH loc_oGrd
421:                 .Top                = 67
422:                 .Left               = 377
423:                 .Width              = 341
424:                 .Height             = 111
425:                 .ColumnCount        = 3
426:                 .FontName           = "Verdana"
427:                 .FontSize           = 8

*-- Linhas 441 a 450:
441:                 .Column3.Width = 251
442: 
443:                 *-- REGRA: AddObject("Check1") ANTES de ControlSource (evita Error 1767)
444:                 .Column1.AddObject("Check1", "CheckBox")
445:                 .Column1.Check1.Caption   = ""
446:                 .Column1.Check1.Value     = 0
447:                 .Column1.Check1.Visible   = .T.
448:                 .Column1.CurrentControl   = "Check1"
449:                 .Column1.Resizable        = .F.
450:                 .Column2.ReadOnly         = .T.

*-- Linhas 461 a 550:
461:                 .Column3.ControlSource = "cursor_4c_Emp.Razas"
462: 
463:                 *-- Headers SEMPRE APOS ControlSource
464:                 .Column1.Header1.Caption = ""
465:                 .Column2.Header1.Caption = "C" + CHR(243) + "digo"
466:                 .Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
467: 
468:                 .Visible = .T.
469:             ENDWITH
470: 
471:             *-- Botao Marcar Empresas (original: top=169, left=720, w=40, h=40)
472:             par_oPag.AddObject("cmd_4c_MarcarEmp", "CommandButton")
473:             WITH par_oPag.cmd_4c_MarcarEmp
474:                 .Top           = 84
475:                 .Left          = 720
476:                 .Width         = 40
477:                 .Height        = 40
478:                 .Caption       = "Sel"
479:                 .FontName      = "Tahoma"
480:                 .FontSize      = 8
481:                 .FontBold      = .T.
482:                 .BackColor     = RGB(255, 255, 255)
483:                 .ForeColor     = RGB(90, 90, 90)
484:                 .SpecialEffect = 0
485:                 .Themes        = .F.
486:                 .ToolTipText   = "Marcar Todas as Empresas"
487:                 .Visible       = .T.
488:             ENDWITH
489:             BINDEVENT(par_oPag.cmd_4c_MarcarEmp, "Click", THIS, "BtnMarcarEmpClick")
490: 
491:             *-- Botao Desmarcar Empresas (original: top=209, left=720, w=40, h=40)
492:             par_oPag.AddObject("cmd_4c_DesmarcarEmp", "CommandButton")
493:             WITH par_oPag.cmd_4c_DesmarcarEmp
494:                 .Top           = 124
495:                 .Left          = 720
496:                 .Width         = 40
497:                 .Height        = 40
498:                 .Caption       = "Des"
499:                 .FontName      = "Tahoma"
500:                 .FontSize      = 8
501:                 .FontBold      = .T.
502:                 .BackColor     = RGB(255, 255, 255)
503:                 .ForeColor     = RGB(90, 90, 90)
504:                 .SpecialEffect = 0
505:                 .Themes        = .F.
506:                 .ToolTipText   = "Desmarcar Todas as Empresas"
507:                 .Visible       = .T.
508:             ENDWITH
509:             BINDEVENT(par_oPag.cmd_4c_DesmarcarEmp, "Click", THIS, "BtnDesmarcarEmpClick")
510: 
511:         CATCH TO loc_oErro
512:             MsgErro(loc_oErro.Message, "ConfigurarGridEmpresas")
513:         ENDTRY
514:     ENDPROC
515: 
516:     *--------------------------------------------------------------------------
517:     * ConfigurarGridDisponibilidades - Grid de selecao de disponibilidades
518:     *   Layout original: top=399, left=57, width=196, height=111
519:     *   Posicao em Page1: top=314 (399-85), left=57
520:     *   Cursores: cursor_4c_Disp (ImpDisps LOGICAL, Grupos, Contas)
521:     *--------------------------------------------------------------------------
522:     PROTECTED PROCEDURE ConfigurarGridDisponibilidades(par_oPag)
523:         LOCAL loc_oGrd, loc_oErro
524:         TRY
525:             *-- Label Disponibilidades (original: top=381, left=63, width=99)
526:             par_oPag.AddObject("lbl_4c_LblDisps", "Label")
527:             WITH par_oPag.lbl_4c_LblDisps
528:                 .Top       = 296
529:                 .Left      = 63
530:                 .Width     = 99
531:                 .Height    = 15
532:                 .Caption   = " Disponibilidades "
533:                 .FontName  = "Tahoma"
534:                 .FontSize  = 8
535:                 .ForeColor = RGB(90, 90, 90)
536:                 .BackStyle = 0
537:                 .Visible   = .T.
538:             ENDWITH
539: 
540:             *-- Grid de disponibilidades (original: top=399, left=57, width=196, height=111)
541:             par_oPag.AddObject("grd_4c_Disps", "Grid")
542:             loc_oGrd = par_oPag.grd_4c_Disps
543:             WITH loc_oGrd
544:                 .Top                = 314
545:                 .Left               = 57
546:                 .Width              = 196
547:                 .Height             = 111
548:                 .ColumnCount        = 3
549:                 .FontName           = "Verdana"
550:                 .FontSize           = 8

*-- Linhas 563 a 572:
563:                 .Column2.Width = 75
564:                 .Column3.Width = 96
565: 
566:                 .Column1.AddObject("Check1", "CheckBox")
567:                 .Column1.Check1.Caption   = ""
568:                 .Column1.Check1.Value     = 0
569:                 .Column1.Check1.Visible   = .T.
570:                 .Column1.CurrentControl   = "Check1"
571:                 .Column1.Resizable        = .F.
572:                 .Column2.ReadOnly         = .T.

*-- Linhas 580 a 669:
580:                 .Column2.ControlSource = "cursor_4c_Disp.Grupos"
581:                 .Column3.ControlSource = "cursor_4c_Disp.Contas"
582: 
583:                 .Column1.Header1.Caption = ""
584:                 .Column2.Header1.Caption = "Grupo"
585:                 .Column3.Header1.Caption = "Conta"
586: 
587:                 .Visible = .T.
588:             ENDWITH
589: 
590:             *-- Botao Marcar Disponibilidades (original: top=416, left=256, w=40, h=40)
591:             par_oPag.AddObject("cmd_4c_MarcarDisp", "CommandButton")
592:             WITH par_oPag.cmd_4c_MarcarDisp
593:                 .Top           = 318
594:                 .Left          = 256
595:                 .Width         = 40
596:                 .Height        = 40
597:                 .Caption       = "Sel"
598:                 .FontName      = "Tahoma"
599:                 .FontSize      = 8
600:                 .FontBold      = .T.
601:                 .BackColor     = RGB(255, 255, 255)
602:                 .ForeColor     = RGB(90, 90, 90)
603:                 .SpecialEffect = 0
604:                 .Themes        = .F.
605:                 .ToolTipText   = "Marcar Todas as Disponibilidades"
606:                 .Visible       = .T.
607:             ENDWITH
608:             BINDEVENT(par_oPag.cmd_4c_MarcarDisp, "Click", THIS, "BtnMarcarDispClick")
609: 
610:             *-- Botao Desmarcar Disponibilidades (original: top=456, left=256, w=40, h=40)
611:             par_oPag.AddObject("cmd_4c_DesmarcarDisp", "CommandButton")
612:             WITH par_oPag.cmd_4c_DesmarcarDisp
613:                 .Top           = 371
614:                 .Left          = 256
615:                 .Width         = 40
616:                 .Height        = 40
617:                 .Caption       = "Des"
618:                 .FontName      = "Tahoma"
619:                 .FontSize      = 8
620:                 .FontBold      = .T.
621:                 .BackColor     = RGB(255, 255, 255)
622:                 .ForeColor     = RGB(90, 90, 90)
623:                 .SpecialEffect = 0
624:                 .Themes        = .F.
625:                 .ToolTipText   = "Desmarcar Todas as Disponibilidades"
626:                 .Visible       = .T.
627:             ENDWITH
628:             BINDEVENT(par_oPag.cmd_4c_DesmarcarDisp, "Click", THIS, "BtnDesmarcarDispClick")
629: 
630:         CATCH TO loc_oErro
631:             MsgErro(loc_oErro.Message, "ConfigurarGridDisponibilidades")
632:         ENDTRY
633:     ENDPROC
634: 
635:     *--------------------------------------------------------------------------
636:     * ConfigurarGridOperacoes - Grid de selecao de operacoes de titulos
637:     *   Layout original: top=336, left=380, width=277, height=130
638:     *   Posicao em Page1: top=251 (336-85), left=380
639:     *   Cursores: cursor_4c_Oper (SeleOp LOGICAL, Dopes, Opers)
640:     *--------------------------------------------------------------------------
641:     PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPag)
642:         LOCAL loc_oGrd, loc_oErro
643:         TRY
644:             *-- Label Operacoes de Titulos (original: top=317, left=377, width=120)
645:             par_oPag.AddObject("lbl_4c_LblOper", "Label")
646:             WITH par_oPag.lbl_4c_LblOper
647:                 .Top       = 232
648:                 .Left      = 377
649:                 .Width     = 120
650:                 .Height    = 15
651:                 .Caption   = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos"
652:                 .FontName  = "Tahoma"
653:                 .FontSize  = 8
654:                 .ForeColor = RGB(90, 90, 90)
655:                 .BackStyle = 0
656:                 .Visible   = .T.
657:             ENDWITH
658: 
659:             *-- Grid de operacoes (original: top=336, left=380, width=277, height=130)
660:             par_oPag.AddObject("grd_4c_Oper", "Grid")
661:             loc_oGrd = par_oPag.grd_4c_Oper
662:             WITH loc_oGrd
663:                 .Top                = 251
664:                 .Left               = 380
665:                 .Width              = 277
666:                 .Height             = 130
667:                 .ColumnCount        = 3
668:                 .FontName           = "Verdana"
669:                 .FontSize           = 8

*-- Linhas 682 a 691:
682:                 .Column2.Width = 65
683:                 .Column3.Width = 187
684: 
685:                 .Column1.AddObject("Check1", "CheckBox")
686:                 .Column1.Check1.Caption   = ""
687:                 .Column1.Check1.Value     = 0
688:                 .Column1.Check1.Visible   = .T.
689:                 .Column1.CurrentControl   = "Check1"
690:                 .Column1.Resizable        = .F.
691:                 .Column2.ReadOnly         = .T.

*-- Linhas 699 a 762:
699:                 .Column2.ControlSource = "cursor_4c_Oper.Dopes"
700:                 .Column3.ControlSource = "cursor_4c_Oper.Opers"
701: 
702:                 .Column1.Header1.Caption = ""
703:                 .Column2.Header1.Caption = "C" + CHR(243) + "digo"
704:                 .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
705: 
706:                 .Visible = .T.
707:             ENDWITH
708: 
709:             *-- Botao Marcar Operacoes (original: top=363, left=659, w=40, h=40)
710:             par_oPag.AddObject("cmd_4c_MarcarOpe", "CommandButton")
711:             WITH par_oPag.cmd_4c_MarcarOpe
712:                 .Top           = 278
713:                 .Left          = 659
714:                 .Width         = 40
715:                 .Height        = 40
716:                 .Caption       = "Sel"
717:                 .FontName      = "Tahoma"
718:                 .FontSize      = 8
719:                 .FontBold      = .T.
720:                 .BackColor     = RGB(255, 255, 255)
721:                 .ForeColor     = RGB(90, 90, 90)
722:                 .SpecialEffect = 0
723:                 .Themes        = .F.
724:                 .ToolTipText   = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
725:                 .Visible       = .T.
726:             ENDWITH
727:             BINDEVENT(par_oPag.cmd_4c_MarcarOpe, "Click", THIS, "BtnMarcarOpeClick")
728: 
729:             *-- Botao Desmarcar Operacoes (original: top=403, left=659, w=40, h=40)
730:             par_oPag.AddObject("cmd_4c_DesmarcarOpe", "CommandButton")
731:             WITH par_oPag.cmd_4c_DesmarcarOpe
732:                 .Top           = 318
733:                 .Left          = 659
734:                 .Width         = 40
735:                 .Height        = 40
736:                 .Caption       = "Des"
737:                 .FontName      = "Tahoma"
738:                 .FontSize      = 8
739:                 .FontBold      = .T.
740:                 .BackColor     = RGB(255, 255, 255)
741:                 .ForeColor     = RGB(90, 90, 90)
742:                 .SpecialEffect = 0
743:                 .Themes        = .F.
744:                 .ToolTipText   = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
745:                 .Visible       = .T.
746:             ENDWITH
747:             BINDEVENT(par_oPag.cmd_4c_DesmarcarOpe, "Click", THIS, "BtnDesmarcarOpeClick")
748: 
749:         CATCH TO loc_oErro
750:             MsgErro(loc_oErro.Message, "ConfigurarGridOperacoes")
751:         ENDTRY
752:     ENDPROC
753: 
754:     *--------------------------------------------------------------------------
755:     * LimparCampos - Inicializa campos de filtro com valores padrao
756:     *   Todos os filtros: Periodo, Moeda, Tipo/Situacao/Ordem, Opcoes/Previsto/Atrasos/Saldo
757:     *   Valores padrao conforme original Init(): tipo=Pagamentos, situa=Baixados, ordem=Vencimento
758:     *--------------------------------------------------------------------------
759:     PROCEDURE LimparCampos()
760:         LOCAL loc_oPag, loc_oErro
761:         TRY
762:             IF VARTYPE(THIS.pgf_4c_Paginas) != "O"

*-- Linhas 1039 a 1126:
1039:             *== SECAO PERIODO ================================================
1040: 
1041:             *-- Label "Periodo :" (original top=138 -> Page1 top=53)
1042:             par_oPag.AddObject("lbl_4c_Periodo", "Label")
1043:             WITH par_oPag.lbl_4c_Periodo
1044:                 .Top       = 53
1045:                 .Left      = 52
1046:                 .Width     = 45
1047:                 .Height    = 15
1048:                 .Caption   = "Per" + CHR(237) + "odo :"
1049:                 .FontName  = "Tahoma"
1050:                 .FontSize  = 8
1051:                 .ForeColor = RGB(90, 90, 90)
1052:                 .BackStyle = 0
1053:                 .Visible   = .T.
1054:             ENDWITH
1055: 
1056:             *-- Data inicial (original top=134 -> Page1 top=49)
1057:             par_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
1058:             WITH par_oPag.txt_4c__dt_inicial
1059:                 .Top      = 49
1060:                 .Left     = 100
1061:                 .Width    = 80
1062:                 .Height   = 25
1063:                 .Value    = {}
1064:                 .Format   = "K"
1065:                 .FontName = "Tahoma"
1066:                 .FontSize = 8
1067:                 .Visible  = .T.
1068:             ENDWITH
1069: 
1070:             *-- Separador " a " (original top=139 -> Page1 top=54)
1071:             par_oPag.AddObject("lbl_4c_PeriodoA", "Label")
1072:             WITH par_oPag.lbl_4c_PeriodoA
1073:                 .Top       = 54
1074:                 .Left      = 184
1075:                 .Width     = 8
1076:                 .Height    = 15
1077:                 .Caption   = CHR(224)
1078:                 .BackStyle = 0
1079:                 .Visible   = .T.
1080:             ENDWITH
1081: 
1082:             *-- Data final (original top=134, left=194 -> Page1 top=49)
1083:             par_oPag.AddObject("txt_4c__dt_final", "TextBox")
1084:             WITH par_oPag.txt_4c__dt_final
1085:                 .Top      = 49
1086:                 .Left     = 194
1087:                 .Width    = 80
1088:                 .Height   = 25
1089:                 .Value    = {}
1090:                 .Format   = "K"
1091:                 .FontName = "Tahoma"
1092:                 .FontSize = 8
1093:                 .Visible  = .T.
1094:             ENDWITH
1095: 
1096:             *-- Opt_Data: Vencimento / Lancamento (original top=134, left=275 -> Page1 top=49)
1097:             par_oPag.AddObject("obj_4c_Opt_Data", "OptionGroup")
1098:             WITH par_oPag.obj_4c_Opt_Data
1099:                 .Top           = 49
1100:                 .Left          = 275
1101:                 .Width         = 97
1102:                 .Height        = 46
1103:                 .ButtonCount   = 2
1104:                 .BackStyle     = 0
1105:                 .BorderStyle   = 0
1106:                 .SpecialEffect = 1
1107:                 .Visible       = .T.
1108:                 WITH .Buttons(1)
1109:                     .Caption   = "Vencimento"
1110:                     .Top       = 5
1111:                     .Left      = 5
1112:                     .Width     = 73
1113:                     .Height    = 15
1114:                     .BackStyle = 0
1115:                     .ForeColor = RGB(90, 90, 90)
1116:                     .AutoSize  = .T.
1117:                 ENDWITH
1118:                 WITH .Buttons(2)
1119:                     .Caption   = "Lan" + CHR(231) + "amento"
1120:                     .Top       = 24
1121:                     .Left      = 5
1122:                     .Width     = 76
1123:                     .Height    = 15
1124:                     .BackStyle = 0
1125:                     .FontName  = "Tahoma"
1126:                     .FontSize  = 8

*-- Linhas 1133 a 1159:
1133:             *== SECAO MOEDA DE REFERENCIA =====================================
1134: 
1135:             *-- Label "Moeda :" (original top=165 -> Page1 top=80)
1136:             par_oPag.AddObject("lbl_4c_Moeda", "Label")
1137:             WITH par_oPag.lbl_4c_Moeda
1138:                 .Top       = 80
1139:                 .Left      = 56
1140:                 .Width     = 41
1141:                 .Height    = 15
1142:                 .Caption   = "Moeda :"
1143:                 .FontName  = "Tahoma"
1144:                 .FontSize  = 8
1145:                 .ForeColor = RGB(90, 90, 90)
1146:                 .BackStyle = 0
1147:                 .Visible   = .T.
1148:             ENDWITH
1149: 
1150:             *-- Codigo moeda referencia (original top=161, left=100 -> Page1 top=76)
1151:             par_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
1152:             WITH par_oPag.txt_4c__cd_moeda
1153:                 .Top           = 76
1154:                 .Left          = 100
1155:                 .Width         = 31
1156:                 .Height        = 25
1157:                 .Value         = ""
1158:                 .MaxLength     = 3
1159:                 .Format        = "K"

*-- Linhas 1172 a 1181:
1172:             *-- Descricao moeda referencia (original top=161, left=132 -> Page1 top=76)
1173:             par_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
1174:             WITH par_oPag.txt_4c__ds_moeda
1175:                 .Top      = 76
1176:                 .Left     = 132
1177:                 .Width    = 115
1178:                 .Height   = 25
1179:                 .Value    = ""
1180:                 .MaxLength = 15
1181:                 .Format   = "K"

*-- Linhas 1189 a 1215:
1189:             *== SECAO MOEDA DE CONVERSAO =====================================
1190: 
1191:             *-- Label "Moe Conv :" (original top=190 -> Page1 top=105)
1192:             par_oPag.AddObject("lbl_4c_MoeConv", "Label")
1193:             WITH par_oPag.lbl_4c_MoeConv
1194:                 .Top       = 105
1195:                 .Left      = 40
1196:                 .Width     = 57
1197:                 .Height    = 15
1198:                 .Caption   = "Moe Conv :"
1199:                 .FontName  = "Tahoma"
1200:                 .FontSize  = 8
1201:                 .ForeColor = RGB(90, 90, 90)
1202:                 .BackStyle = 0
1203:                 .Visible   = .T.
1204:             ENDWITH
1205: 
1206:             *-- Codigo moeda conversao (original top=187, left=100 -> Page1 top=102)
1207:             par_oPag.AddObject("txt_4c_MoeConv", "TextBox")
1208:             WITH par_oPag.txt_4c_MoeConv
1209:                 .Top           = 102
1210:                 .Left          = 100
1211:                 .Width         = 31
1212:                 .Height        = 25
1213:                 .Value         = ""
1214:                 .MaxLength     = 3
1215:                 .Format        = "K"

*-- Linhas 1228 a 1237:
1228:             *-- Descricao moeda conversao (original top=187, left=132 -> Page1 top=102)
1229:             par_oPag.AddObject("txt_4c_DMoeConv", "TextBox")
1230:             WITH par_oPag.txt_4c_DMoeConv
1231:                 .Top      = 102
1232:                 .Left     = 132
1233:                 .Width    = 115
1234:                 .Height   = 25
1235:                 .Value    = ""
1236:                 .MaxLength = 15
1237:                 .Format   = "K"

*-- Linhas 1245 a 1500:
1245:             *== SECAO OPCOES =================================================
1246: 
1247:             *-- Label2 "Opcoes" secao header (original top=214 -> Page1 top=129)
1248:             par_oPag.AddObject("lbl_4c_SecaoOpcoes", "Label")
1249:             WITH par_oPag.lbl_4c_SecaoOpcoes
1250:                 .Top        = 129
1251:                 .Left       = 24
1252:                 .Width      = 43
1253:                 .Height     = 15
1254:                 .Caption    = "Op" + CHR(231) + CHR(245) + "es"
1255:                 .FontName   = "Tahoma"
1256:                 .FontSize   = 8
1257:                 .FontBold   = .T.
1258:                 .FontItalic = .T.
1259:                 .ForeColor  = RGB(90, 90, 90)
1260:                 .BackStyle  = 0
1261:                 .Visible    = .T.
1262:             ENDWITH
1263: 
1264:             *-- Label "Tipo :" (original top=230 -> Page1 top=145)
1265:             par_oPag.AddObject("lbl_4c_Tipo", "Label")
1266:             WITH par_oPag.lbl_4c_Tipo
1267:                 .Top       = 145
1268:                 .Left      = 66
1269:                 .Width     = 29
1270:                 .Height    = 15
1271:                 .Caption   = "Tipo :"
1272:                 .FontSize  = 8
1273:                 .ForeColor = RGB(90, 90, 90)
1274:                 .BackStyle = 0
1275:                 .Visible   = .T.
1276:             ENDWITH
1277: 
1278:             *-- opt_nr_tipo: Pagamentos/Recebimentos/Ambos
1279:             *   (original top=223, left=94 -> Page1 top=138)
1280:             par_oPag.AddObject("obj_4c_Opt_nr_tipo", "OptionGroup")
1281:             WITH par_oPag.obj_4c_Opt_nr_tipo
1282:                 .Top           = 138
1283:                 .Left          = 94
1284:                 .Width         = 262
1285:                 .Height        = 27
1286:                 .ButtonCount   = 3
1287:                 .BackStyle     = 0
1288:                 .BorderStyle   = 0
1289:                 .SpecialEffect = 0
1290:                 .Visible       = .T.
1291:                 WITH .Buttons(1)
1292:                     .Caption   = "Pagamentos"
1293:                     .Top       = 5
1294:                     .Left      = 5
1295:                     .Width     = 77
1296:                     .Height    = 15
1297:                     .BackStyle = 0
1298:                     .ForeColor = RGB(90, 90, 90)
1299:                     .AutoSize  = .T.
1300:                 ENDWITH
1301:                 WITH .Buttons(2)
1302:                     .Caption   = "Recebimentos"
1303:                     .Top       = 5
1304:                     .Left      = 95
1305:                     .Height    = 15
1306:                     .BackStyle = 0
1307:                     .FontName  = "Tahoma"
1308:                     .FontSize  = 8
1309:                     .ForeColor = RGB(90, 90, 90)
1310:                     .AutoSize  = .T.
1311:                 ENDWITH
1312:                 WITH .Buttons(3)
1313:                     .Caption   = "Ambos"
1314:                     .Top       = 5
1315:                     .Left      = 196
1316:                     .Width     = 61
1317:                     .Height    = 17
1318:                     .BackStyle = 0
1319:                     .FontName  = "Tahoma"
1320:                     .FontSize  = 8
1321:                     .ForeColor = RGB(90, 90, 90)
1322:                     .AutoSize  = .T.
1323:                 ENDWITH
1324:                 .Value = 3
1325:             ENDWITH
1326: 
1327:             *-- Label "Situacao :" (original top=244 -> Page1 top=159)
1328:             par_oPag.AddObject("lbl_4c_Situa", "Label")
1329:             WITH par_oPag.lbl_4c_Situa
1330:                 .Top       = 159
1331:                 .Left      = 47
1332:                 .Width     = 50
1333:                 .Height    = 15
1334:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
1335:                 .FontName  = "Tahoma"
1336:                 .FontSize  = 8
1337:                 .ForeColor = RGB(90, 90, 90)
1338:                 .BackStyle = 0
1339:                 .Visible   = .T.
1340:             ENDWITH
1341: 
1342:             *-- opt_situa: 1=Baixados 2=Abertos 3=Todos
1343:             *   (original top=240, left=94 -> Page1 top=155)
1344:             par_oPag.AddObject("obj_4c_Opt_situa", "OptionGroup")
1345:             WITH par_oPag.obj_4c_Opt_situa
1346:                 .Top           = 155
1347:                 .Left          = 94
1348:                 .Width         = 254
1349:                 .Height        = 27
1350:                 .ButtonCount   = 3
1351:                 .BackStyle     = 0
1352:                 .BorderStyle   = 0
1353:                 .SpecialEffect = 0
1354:                 .Visible       = .T.
1355:                 WITH .Buttons(1)
1356:                     .Caption   = "Baixados"
1357:                     .Top       = 5
1358:                     .Left      = 5
1359:                     .Width     = 61
1360:                     .Height    = 15
1361:                     .BackStyle = 0
1362:                     .ForeColor = RGB(90, 90, 90)
1363:                     .AutoSize  = .T.
1364:                 ENDWITH
1365:                 WITH .Buttons(2)
1366:                     .Caption   = "Pendentes"
1367:                     .Top       = 5
1368:                     .Left      = 93
1369:                     .Height    = 15
1370:                     .BackStyle = 0
1371:                     .FontName  = "Tahoma"
1372:                     .FontSize  = 8
1373:                     .ForeColor = RGB(90, 90, 90)
1374:                     .AutoSize  = .T.
1375:                 ENDWITH
1376:                 WITH .Buttons(3)
1377:                     .Caption   = "Todos"
1378:                     .Top       = 5
1379:                     .Left      = 196
1380:                     .Width     = 53
1381:                     .Height    = 17
1382:                     .BackStyle = 0
1383:                     .FontName  = "Tahoma"
1384:                     .FontSize  = 8
1385:                     .ForeColor = RGB(90, 90, 90)
1386:                     .AutoSize  = .T.
1387:                 ENDWITH
1388:                 .Value = 2
1389:             ENDWITH
1390: 
1391:             *-- Label "Ordem :" (original top=262 -> Page1 top=177)
1392:             par_oPag.AddObject("lbl_4c_Ordem", "Label")
1393:             WITH par_oPag.lbl_4c_Ordem
1394:                 .Top       = 177
1395:                 .Left      = 56
1396:                 .Width     = 41
1397:                 .Height    = 15
1398:                 .Caption   = "Ordem :"
1399:                 .FontName  = "Tahoma"
1400:                 .FontSize  = 8
1401:                 .ForeColor = RGB(90, 90, 90)
1402:                 .BackStyle = 0
1403:                 .Visible   = .T.
1404:             ENDWITH
1405: 
1406:             *-- opt_ordem_impressao: Vencimento / Grupo/Conta
1407:             *   (original top=258, left=94 -> Page1 top=173)
1408:             par_oPag.AddObject("obj_4c_Opt_ordem_impressao", "OptionGroup")
1409:             WITH par_oPag.obj_4c_Opt_ordem_impressao
1410:                 .Top           = 173
1411:                 .Left          = 94
1412:                 .Width         = 185
1413:                 .Height        = 25
1414:                 .ButtonCount   = 2
1415:                 .BackStyle     = 0
1416:                 .BorderStyle   = 0
1417:                 .SpecialEffect = 0
1418:                 .Visible       = .T.
1419:                 WITH .Buttons(1)
1420:                     .Caption   = "Vencimento"
1421:                     .Top       = 5
1422:                     .Left      = 5
1423:                     .Width     = 73
1424:                     .Height    = 15
1425:                     .BackStyle = 0
1426:                     .AutoSize  = .T.
1427:                 ENDWITH
1428:                 WITH .Buttons(2)
1429:                     .Caption   = "Grupo / Conta"
1430:                     .Top       = 5
1431:                     .Left      = 94
1432:                     .Height    = 15
1433:                     .BackStyle = 0
1434:                     .FontName  = "Tahoma"
1435:                     .FontSize  = 8
1436:                     .AutoSize  = .T.
1437:                 ENDWITH
1438:                 .Value = 1
1439:             ENDWITH
1440: 
1441:             *== SECAO OPCOES NF ==============================================
1442: 
1443:             *-- Say3 "Opcoes :" (original top=281 -> Page1 top=196)
1444:             par_oPag.AddObject("lbl_4c_OpcoesSay", "Label")
1445:             WITH par_oPag.lbl_4c_OpcoesSay
1446:                 .Top       = 196
1447:                 .Left      = 52
1448:                 .Width     = 45
1449:                 .Height    = 15
1450:                 .Caption   = "Op" + CHR(231) + CHR(245) + "es :"
1451:                 .FontName  = "Tahoma"
1452:                 .FontSize  = 8
1453:                 .ForeColor = RGB(90, 90, 90)
1454:                 .BackStyle = 0
1455:                 .Visible   = .T.
1456:             ENDWITH
1457: 
1458:             *-- optOpcoes: Sim/Nao/Ambos (original top=277, left=94 -> Page1 top=192)
1459:             par_oPag.AddObject("obj_4c_Opt_opcoes", "OptionGroup")
1460:             WITH par_oPag.obj_4c_Opt_opcoes
1461:                 .Top           = 192
1462:                 .Left          = 94
1463:                 .Width         = 251
1464:                 .Height        = 25
1465:                 .ButtonCount   = 3
1466:                 .BackStyle     = 0
1467:                 .BorderStyle   = 0
1468:                 .SpecialEffect = 0
1469:                 .Visible       = .T.
1470:                 WITH .Buttons(1)
1471:                     .Caption   = "Sim"
1472:                     .Top       = 5
1473:                     .Left      = 5
1474:                     .Width     = 34
1475:                     .Height    = 15
1476:                     .BackStyle = 0
1477:                     .ForeColor = RGB(90, 90, 90)
1478:                     .AutoSize  = .T.
1479:                 ENDWITH
1480:                 WITH .Buttons(2)
1481:                     .Caption   = "N" + CHR(227) + "o"
1482:                     .Top       = 5
1483:                     .Left      = 92
1484:                     .Width     = 37
1485:                     .Height    = 15
1486:                     .BackStyle = 0
1487:                     .FontName  = "Tahoma"
1488:                     .FontSize  = 8
1489:                     .ForeColor = RGB(90, 90, 90)
1490:                     .AutoSize  = .T.
1491:                 ENDWITH
1492:                 WITH .Buttons(3)
1493:                     .Caption   = "Ambos"
1494:                     .Top       = 5
1495:                     .Left      = 196
1496:                     .Width     = 50
1497:                     .Height    = 15
1498:                     .BackStyle = 0
1499:                     .FontName  = "Tahoma"
1500:                     .FontSize  = 8

*-- Linhas 1507 a 1566:
1507:             *== SECAO PREVISTO ===============================================
1508: 
1509:             *-- Say4 "Previsto :" (original top=299 -> Page1 top=214)
1510:             par_oPag.AddObject("lbl_4c_Previsto", "Label")
1511:             WITH par_oPag.lbl_4c_Previsto
1512:                 .Top       = 214
1513:                 .Left      = 49
1514:                 .Width     = 48
1515:                 .Height    = 15
1516:                 .Caption   = "Previsto :"
1517:                 .FontName  = "Tahoma"
1518:                 .FontSize  = 8
1519:                 .ForeColor = RGB(90, 90, 90)
1520:                 .BackStyle = 0
1521:                 .Visible   = .T.
1522:             ENDWITH
1523: 
1524:             *-- OptPrev: Sim/Nao/Ambos (original top=296, left=94 -> Page1 top=211)
1525:             par_oPag.AddObject("obj_4c_Opt_prev", "OptionGroup")
1526:             WITH par_oPag.obj_4c_Opt_prev
1527:                 .Top           = 211
1528:                 .Left          = 94
1529:                 .Width         = 256
1530:                 .Height        = 27
1531:                 .ButtonCount   = 3
1532:                 .BackStyle     = 0
1533:                 .BorderStyle   = 0
1534:                 .SpecialEffect = 0
1535:                 .Visible       = .T.
1536:                 WITH .Buttons(1)
1537:                     .Caption   = "Sim"
1538:                     .Top       = 5
1539:                     .Left      = 5
1540:                     .Width     = 57
1541:                     .Height    = 17
1542:                     .BackStyle = 0
1543:                     .ForeColor = RGB(90, 90, 90)
1544:                     .AutoSize  = .F.
1545:                 ENDWITH
1546:                 WITH .Buttons(2)
1547:                     .Caption   = "N" + CHR(227) + "o"
1548:                     .Top       = 5
1549:                     .Left      = 92
1550:                     .Width     = 57
1551:                     .Height    = 17
1552:                     .BackStyle = 0
1553:                     .FontName  = "Tahoma"
1554:                     .FontSize  = 8
1555:                     .ForeColor = RGB(90, 90, 90)
1556:                     .AutoSize  = .F.
1557:                 ENDWITH
1558:                 WITH .Buttons(3)
1559:                     .Caption   = "Ambos"
1560:                     .Top       = 5
1561:                     .Left      = 196
1562:                     .Width     = 55
1563:                     .Height    = 17
1564:                     .BackStyle = 0
1565:                     .FontName  = "Tahoma"
1566:                     .FontSize  = 8

*-- Linhas 1573 a 1620:
1573:             *== SECAO ATRASOS ================================================
1574: 
1575:             *-- Say8 "Listar Atrasos :" (original top=318 -> Page1 top=233)
1576:             par_oPag.AddObject("lbl_4c_ListaAtrasos", "Label")
1577:             WITH par_oPag.lbl_4c_ListaAtrasos
1578:                 .Top       = 233
1579:                 .Left      = 82
1580:                 .Width     = 75
1581:                 .Height    = 15
1582:                 .Caption   = "Listar Atrasos :"
1583:                 .FontName  = "Tahoma"
1584:                 .FontSize  = 8
1585:                 .ForeColor = RGB(90, 90, 90)
1586:                 .BackStyle = 0
1587:                 .Visible   = .T.
1588:             ENDWITH
1589: 
1590:             *-- opt_Lista_Atra: Sim/Nao (original top=313, left=180 -> Page1 top=228)
1591:             par_oPag.AddObject("obj_4c_Opt_lista_atra", "OptionGroup")
1592:             WITH par_oPag.obj_4c_Opt_lista_atra
1593:                 .Top           = 228
1594:                 .Left          = 180
1595:                 .Width         = 172
1596:                 .Height        = 27
1597:                 .ButtonCount   = 2
1598:                 .BackStyle     = 0
1599:                 .BorderStyle   = 0
1600:                 .SpecialEffect = 0
1601:                 .Visible       = .T.
1602:                 WITH .Buttons(1)
1603:                     .Caption   = "Sim"
1604:                     .Top       = 5
1605:                     .Left      = 5
1606:                     .Width     = 57
1607:                     .Height    = 17
1608:                     .BackStyle = 0
1609:                     .ForeColor = RGB(90, 90, 90)
1610:                     .AutoSize  = .F.
1611:                 ENDWITH
1612:                 WITH .Buttons(2)
1613:                     .Caption   = "N" + CHR(227) + "o"
1614:                     .Top       = 5
1615:                     .Left      = 110
1616:                     .Width     = 57
1617:                     .Height    = 17
1618:                     .BackStyle = 0
1619:                     .FontName  = "Tahoma"
1620:                     .FontSize  = 8

*-- Linhas 1626 a 1725:
1626:             BINDEVENT(par_oPag.obj_4c_Opt_lista_atra, "InteractiveChange", THIS, "OptListaAtraChange")
1627: 
1628:             *-- Say7 "Considerar Atrasos :" (original top=335 -> Page1 top=250)
1629:             par_oPag.AddObject("lbl_4c_ConsidAtrasos", "Label")
1630:             WITH par_oPag.lbl_4c_ConsidAtrasos
1631:                 .Top       = 250
1632:                 .Left      = 51
1633:                 .Width     = 101
1634:                 .Height    = 15
1635:                 .Caption   = "Considerar Atrasos :"
1636:                 .FontName  = "Tahoma"
1637:                 .FontSize  = 8
1638:                 .ForeColor = RGB(90, 90, 90)
1639:                 .BackStyle = 0
1640:                 .Visible   = .T.
1641:             ENDWITH
1642: 
1643:             *-- opt_Consid_Atra: Sim/Nao (original top=331, left=180 -> Page1 top=246)
1644:             par_oPag.AddObject("obj_4c_Opt_consid_atra", "OptionGroup")
1645:             WITH par_oPag.obj_4c_Opt_consid_atra
1646:                 .Top           = 246
1647:                 .Left          = 180
1648:                 .Width         = 172
1649:                 .Height        = 27
1650:                 .ButtonCount   = 2
1651:                 .BackStyle     = 0
1652:                 .BorderStyle   = 0
1653:                 .SpecialEffect = 0
1654:                 .Visible       = .T.
1655:                 WITH .Buttons(1)
1656:                     .Caption   = "Sim"
1657:                     .Top       = 5
1658:                     .Left      = 5
1659:                     .Width     = 57
1660:                     .Height    = 17
1661:                     .BackStyle = 0
1662:                     .ForeColor = RGB(90, 90, 90)
1663:                     .AutoSize  = .F.
1664:                 ENDWITH
1665:                 WITH .Buttons(2)
1666:                     .Caption   = "N" + CHR(227) + "o"
1667:                     .Top       = 5
1668:                     .Left      = 110
1669:                     .Width     = 57
1670:                     .Height    = 17
1671:                     .BackStyle = 0
1672:                     .FontName  = "Tahoma"
1673:                     .FontSize  = 8
1674:                     .ForeColor = RGB(90, 90, 90)
1675:                     .AutoSize  = .F.
1676:                 ENDWITH
1677:                 .Value = 2
1678:             ENDWITH
1679: 
1680:             *-- Say9 "Listar Cod. Operacao :" (original top=352 -> Page1 top=267)
1681:             par_oPag.AddObject("lbl_4c_ListaCodOp", "Label")
1682:             WITH par_oPag.lbl_4c_ListaCodOp
1683:                 .Top       = 267
1684:                 .Left      = 41
1685:                 .Width     = 111
1686:                 .Height    = 15
1687:                 .Caption   = "Listar C" + CHR(243) + "d. Opera" + CHR(231) + CHR(227) + "o :"
1688:                 .FontName  = "Tahoma"
1689:                 .FontSize  = 8
1690:                 .ForeColor = RGB(90, 90, 90)
1691:                 .BackStyle = 0
1692:                 .Visible   = .T.
1693:             ENDWITH
1694: 
1695:             *-- Opt_Lista_op: Sim/Nao (original top=348, left=180 -> Page1 top=263)
1696:             par_oPag.AddObject("obj_4c_Opt_lista_op", "OptionGroup")
1697:             WITH par_oPag.obj_4c_Opt_lista_op
1698:                 .Top           = 263
1699:                 .Left          = 180
1700:                 .Width         = 172
1701:                 .Height        = 27
1702:                 .ButtonCount   = 2
1703:                 .BackStyle     = 0
1704:                 .BorderStyle   = 0
1705:                 .SpecialEffect = 0
1706:                 .Visible       = .T.
1707:                 WITH .Buttons(1)
1708:                     .Caption   = "Sim"
1709:                     .Top       = 5
1710:                     .Left      = 5
1711:                     .Width     = 57
1712:                     .Height    = 17
1713:                     .BackStyle = 0
1714:                     .ForeColor = RGB(90, 90, 90)
1715:                     .AutoSize  = .F.
1716:                 ENDWITH
1717:                 WITH .Buttons(2)
1718:                     .Caption   = "N" + CHR(227) + "o"
1719:                     .Top       = 5
1720:                     .Left      = 110
1721:                     .Width     = 57
1722:                     .Height    = 17
1723:                     .BackStyle = 0
1724:                     .FontName  = "Tahoma"
1725:                     .FontSize  = 8

*-- Linhas 1732 a 1779:
1732:             *== SECAO SALDO ==================================================
1733: 
1734:             *-- Say5 "Saldo :" (original top=514 -> Page1 top=429)
1735:             par_oPag.AddObject("lbl_4c_Saldo", "Label")
1736:             WITH par_oPag.lbl_4c_Saldo
1737:                 .Top       = 429
1738:                 .Left      = 58
1739:                 .Width     = 35
1740:                 .Height    = 15
1741:                 .Caption   = "Saldo :"
1742:                 .FontName  = "Tahoma"
1743:                 .FontSize  = 8
1744:                 .ForeColor = RGB(90, 90, 90)
1745:                 .BackStyle = 0
1746:                 .Visible   = .T.
1747:             ENDWITH
1748: 
1749:             *-- OptSaldo: Anterior/Na Data (original top=509, left=99 -> Page1 top=424)
1750:             par_oPag.AddObject("obj_4c_Opt_saldo", "OptionGroup")
1751:             WITH par_oPag.obj_4c_Opt_saldo
1752:                 .Top           = 424
1753:                 .Left          = 99
1754:                 .Width         = 137
1755:                 .Height        = 25
1756:                 .ButtonCount   = 2
1757:                 .BackStyle     = 0
1758:                 .BorderStyle   = 0
1759:                 .SpecialEffect = 0
1760:                 .Visible       = .T.
1761:                 WITH .Buttons(1)
1762:                     .Caption   = "Anterior"
1763:                     .Top       = 5
1764:                     .Left      = 5
1765:                     .Width     = 57
1766:                     .Height    = 15
1767:                     .BackStyle = 0
1768:                     .ForeColor = RGB(90, 90, 90)
1769:                     .AutoSize  = .T.
1770:                 ENDWITH
1771:                 WITH .Buttons(2)
1772:                     .Caption   = "Na Data"
1773:                     .Top       = 5
1774:                     .Left      = 75
1775:                     .Width     = 57
1776:                     .Height    = 15
1777:                     .BackStyle = 0
1778:                     .FontName  = "Tahoma"
1779:                     .FontSize  = 8

*-- Linhas 2211 a 2236:
2211:             loc_oPag.obj_4c_Opt_lista_op.Enabled        = .T.
2212:             loc_oPag.obj_4c_Opt_saldo.Enabled           = .T.
2213:             loc_oPag.grd_4c_Empresas.Enabled            = .T.
2214:             loc_oPag.grd_4c_Disps.Enabled               = .T.
2215:             loc_oPag.grd_4c_Oper.Enabled                = .T.
2216:             loc_oPag.cmd_4c_MarcarEmp.Enabled           = .T.
2217:             loc_oPag.cmd_4c_DesmarcarEmp.Enabled        = .T.
2218:             loc_oPag.cmd_4c_MarcarDisp.Enabled          = .T.
2219:             loc_oPag.cmd_4c_DesmarcarDisp.Enabled       = .T.
2220:             loc_oPag.cmd_4c_MarcarOpe.Enabled           = .T.
2221:             loc_oPag.cmd_4c_DesmarcarOpe.Enabled        = .T.
2222: 
2223:             *-- Consid. Atrasos: somente habilitado se Listar Atrasos = Sim
2224:             IF VARTYPE(loc_oPag.obj_4c_Opt_consid_atra) = "O"
2225:                 loc_oPag.obj_4c_Opt_consid_atra.Enabled = (loc_oPag.obj_4c_Opt_lista_atra.Value = 1)
2226:             ENDIF
2227: 
2228:         CATCH TO loc_oErro
2229:             MsgErro(loc_oErro.Message, "HabilitarCampos")
2230:         ENDTRY
2231:     ENDPROC
2232: 
2233:     *--------------------------------------------------------------------------
2234:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
2235:     *   Em forms REPORT nao ha modos CRUD. Botoes de relatorio estao sempre
2236:     *   habilitados. Metodo mantido para conformidade com API padrao.

*-- Linhas 2279 a 2289:
2279:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Emp.ImpEmps"
2280:                 loc_oGrd.Column2.ControlSource  = "cursor_4c_Emp.Cemps"
2281:                 loc_oGrd.Column3.ControlSource  = "cursor_4c_Emp.Razas"
2282:                 loc_oGrd.Column1.Header1.Caption = ""
2283:                 loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "digo"
2284:                 loc_oGrd.Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
2285:                 loc_oGrd.Refresh()
2286:             ENDIF
2287: 
2288:             *-- Atualizar grid de disponibilidades
2289:             IF VARTYPE(loc_oPag.grd_4c_Disps) = "O"

*-- Linhas 2295 a 2305:
2295:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Disp.ImpDisps"
2296:                 loc_oGrd.Column2.ControlSource  = "cursor_4c_Disp.Grupos"
2297:                 loc_oGrd.Column3.ControlSource  = "cursor_4c_Disp.Contas"
2298:                 loc_oGrd.Column1.Header1.Caption = ""
2299:                 loc_oGrd.Column2.Header1.Caption = "Grupo"
2300:                 loc_oGrd.Column3.Header1.Caption = "Conta"
2301:                 loc_oGrd.Refresh()
2302:             ENDIF
2303: 
2304:             *-- Atualizar grid de operacoes de titulos
2305:             IF VARTYPE(loc_oPag.grd_4c_Oper) = "O"

*-- Linhas 2311 a 2321:
2311:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Oper.SeleOp"
2312:                 loc_oGrd.Column2.ControlSource  = "cursor_4c_Oper.Dopes"
2313:                 loc_oGrd.Column3.ControlSource  = "cursor_4c_Oper.Opers"
2314:                 loc_oGrd.Column1.Header1.Caption = ""
2315:                 loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "digo"
2316:                 loc_oGrd.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2317:                 loc_oGrd.Refresh()
2318:             ENDIF
2319: 
2320:         CATCH TO loc_oErro
2321:             MsgErro(loc_oErro.Message, "CarregarLista")

