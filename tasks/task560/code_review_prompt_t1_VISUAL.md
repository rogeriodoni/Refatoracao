# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [GRID-HEADER] Header Caption 'Emp' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Lista de Preço, Tab.Desconto, Unitário, Moe, Produto, Qtd., Peso, Valor, Total, Cor, Tam, Movimentação, Evento, Descrição, , Oper. Crédito, * Operação *, Operação, Código, Nome, Grupo, Segmento, Qtde, Coefs, Teor, M.Obra, Tp, (%), Diferença. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Número' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Lista de Preço, Tab.Desconto, Unitário, Moe, Produto, Qtd., Peso, Valor, Total, Cor, Tam, Movimentação, Evento, Descrição, , Oper. Crédito, * Operação *, Operação, Código, Nome, Grupo, Segmento, Qtde, Coefs, Teor, M.Obra, Tp, (%), Diferença. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Lista de Preço, Tab.Desconto, Unitário, Moe, Produto, Qtd., Peso, Valor, Total, Cor, Tam, Movimentação, Evento, Descrição, , Oper. Crédito, * Operação *, Operação, Código, Nome, Grupo, Segmento, Qtde, Coefs, Teor, M.Obra, Tp, (%), Diferença. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Lista de Preço, Tab.Desconto, Unitário, Moe, Produto, Qtd., Peso, Valor, Total, Cor, Tam, Movimentação, Evento, Descrição, , Oper. Crédito, * Operação *, Operação, Código, Nome, Grupo, Segmento, Qtde, Coefs, Teor, M.Obra, Tp, (%), Diferença. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Lista de Preço, Tab.Desconto, Unitário, Moe, Produto, Qtd., Peso, Valor, Total, Cor, Tam, Movimentação, Evento, Descrição, , Oper. Crédito, * Operação *, Operação, Código, Nome, Grupo, Segmento, Qtde, Coefs, Teor, M.Obra, Tp, (%), Diferença. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGMVCAB.pagina.lista): Top original=132 vs migrado 'cnt_4c_BotoesAcao' Top=33 (diff=99px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGMVCAB.pagina.lista): Left original=28 vs migrado 'cnt_4c_BotoesAcao' Left=842 (diff=814px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'job' (parent: SIGMVCAB.pagina.dados.pgfPrincipal.pgContas): Top original=3 vs migrado 'lbl_4c_Jobs' Top=330 (diff=327px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvcab.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1555 linhas total):

*-- Linhas 17 a 37:
17: *   pgfPrincipal/pgContas do legado); abas Operacional/Informacoes completas
18: *   ficam fora do escopo desta migracao simplificada.
19: * FASE 6/8: Form - Campos restantes (parte 2) e lookups completos
20: * - txt_4c_Tabds/Lprecos (linha 6), txt_4c_Jobs/Fpubls (linha 7),
21: *   txt_4c_Valos (linha 8), txt_4c_Obses memo (linha 9)
22: * - cnt_4c_BotoesAcao: cmd_4c_Confirmar/cmd_4c_Cancelar + BtnSalvarClick/
23: *   BtnCancelarClick
24: * - FormParaBO()/BOParaForm()/LimparCampos()/HabilitarCampos() ligados aos
25: *   fluxos de Incluir/Alterar/Visualizar/Salvar
26: * - Lookups (F4/DblClick) completos para GrupoOs/ContaOs/GrupoDs/ContaDs/
27: *   Vends via AbrirBuscaGrupoConta() (Grupo=SigCdGcr Codigos/Descrs,
28: *   Conta/Vendedor=SigCdCli Iclis/Rclis)
29: * FASE 7/8: Form - BtnBuscarClick (FormBuscaAuxiliar por EmpDopNums +
30: *   LocalizarNaLista), BtnEncerrarClick, Destroy() liberando cursores
31: * FASE 8/8: Form - Consolidacao final: AjustarBotoesPorModo() (Confirmar
32: *   desabilitado + Cancelar vira "Voltar" em VISUALIZAR), chamado junto com
33: *   HabilitarCampos() em BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick.
34: *   Integracao com config.prg (ADIR dinamico, ja cobre classes\*BO.prg e
35: *   forms\cadastros\Form*.prg) e menu.prg (AbrirFormsigmvcab + popMovimentos
36: *   Bar 1) conferida e correta.
37: *==============================================================================

*-- Linhas 82 a 93:
82:                 THIS.ConfigurarPageFrame()
83: 
84:                 *-- Regra #11 (CLAUDE.md): faixa do cabecalho nas DUAS paginas
85:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
86:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
87:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
88:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
89: 
90:                 THIS.pgf_4c_Paginas.Visible = .T.
91:                 THIS.pgf_4c_Paginas.ActivePage = 1
92:                 THIS.this_cModoAtual = "LISTA"
93: 

*-- Linhas 117 a 136:
117: 
118:         WITH THIS.pgf_4c_Paginas
119:             .PageCount = 2
120:             .Top       = -29
121:             .Left      = 0
122:             .Width     = THIS.Width
123:             .Height    = THIS.Height + 29
124:             .Tabs      = .F.
125:             .Visible   = .T.
126: 
127:             .Page1.Caption   = "Lista"
128:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
129:             .Page1.BackColor = RGB(255, 255, 255)
130: 
131:             .Page2.Caption   = "Dados"
132:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
133:             .Page2.BackColor = RGB(255, 255, 255)
134:         ENDWITH
135: 
136:         THIS.ConfigurarPaginaLista()

*-- Linhas 152 a 189:
152:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina (regra #11)
153:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
154:         WITH loc_oPagina.cnt_4c_Cabecalho
155:             .Top         = 29
156:             .Left        = 0
157:             .Width       = THIS.Width
158:             .Height      = 80
159:             .BackColor   = RGB(100, 100, 100)
160:             .BorderWidth = 0
161:             .Visible     = .T.
162:         ENDWITH
163: 
164:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
165:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
166:             .Caption   = THIS.Caption
167:             .Top       = 15
168:             .Left      = 10
169:             .Width     = THIS.Width - 20
170:             .Height    = 40
171:             .FontName  = "Tahoma"
172:             .FontSize  = 16
173:             .FontBold  = .T.
174:             .ForeColor = RGB(0, 0, 0)
175:             .BackStyle = 0
176:             .AutoSize  = .F.
177:             .Visible   = .T.
178:         ENDWITH
179: 
180:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
181:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
182:             .Caption   = THIS.Caption
183:             .Top       = 18
184:             .Left      = 10
185:             .Width     = THIS.Width - 20
186:             .Height    = 46
187:             .FontName  = "Tahoma"
188:             .FontSize  = 16
189:             .FontBold  = .T.

*-- Linhas 196 a 220:
196:         *-- Container Botoes CRUD (Grupo_op no legado) - canonico
197:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
198:         WITH loc_oPagina.cnt_4c_Botoes
199:             .Top         = 29
200:             .Left        = 542
201:             .Width       = 390
202:             .Height      = 85
203:             .BackStyle   = 0
204:             .BorderWidth = 0
205:             .Visible     = .T.
206:         ENDWITH
207: 
208:         *-- Botao Incluir (Left=5)
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
211:             .Caption         = "Incluir"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
213:             .PicturePosition = 13
214:             .Top             = 5
215:             .Left            = 5
216:             .Width           = 75
217:             .Height          = 75
218:             .FontName        = "Tahoma"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.

*-- Linhas 228 a 245:
228:             .AutoSize        = .F.
229:             .Visible         = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
232: 
233:         *-- Botao Visualizar (Left=80)
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
236:             .Caption         = "Visualizar"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 80
241:             .Width           = 75
242:             .Height          = 75
243:             .FontName        = "Tahoma"
244:             .FontBold        = .T.
245:             .FontItalic      = .T.

*-- Linhas 253 a 270:
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
257: 
258:         *-- Botao Alterar (Left=155)
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
261:             .Caption         = "Alterar"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 155
266:             .Width           = 75
267:             .Height          = 75
268:             .FontName        = "Tahoma"
269:             .FontBold        = .T.
270:             .FontItalic      = .T.

*-- Linhas 278 a 295:
278:             .AutoSize        = .F.
279:             .Visible         = .T.
280:         ENDWITH
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
282: 
283:         *-- Botao Excluir (Left=230)
284:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
285:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
286:             .Caption         = "Excluir"
287:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
288:             .PicturePosition = 13
289:             .Top             = 5
290:             .Left            = 230
291:             .Width           = 75
292:             .Height          = 75
293:             .FontName        = "Tahoma"
294:             .FontBold        = .T.
295:             .FontItalic      = .T.

*-- Linhas 303 a 320:
303:             .AutoSize        = .F.
304:             .Visible         = .T.
305:         ENDWITH
306:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
307: 
308:         *-- Botao Buscar (Left=305)
309:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
310:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
311:             .Caption         = "Buscar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 305
316:             .Width           = 75
317:             .Height          = 75
318:             .FontName        = "Tahoma"
319:             .FontBold        = .T.
320:             .FontItalic      = .T.

*-- Linhas 328 a 357:
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
332: 
333:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
334:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
335:         WITH loc_oPagina.cnt_4c_Saida
336:             .Top         = 29
337:             .Left        = 917
338:             .Width       = 90
339:             .Height      = 85
340:             .BackStyle   = 0
341:             .BorderWidth = 0
342:             .Visible     = .T.
343:         ENDWITH
344: 
345:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
346:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
347:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
348:             .Caption         = "Encerrar"
349:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
350:             .PicturePosition = 13
351:             .Top             = 5
352:             .Left            = 5
353:             .Width           = 75
354:             .Height          = 75
355:             .FontName        = "Tahoma"
356:             .FontBold        = .T.
357:             .FontItalic      = .T.

*-- Linhas 365 a 382:
365:             .AutoSize        = .F.
366:             .Visible         = .T.
367:         ENDWITH
368:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
369: 
370:         *-- Grid de listagem de movimentos
371:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
372:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
373:         *-- ColumnCount FORA do WITH (RecordSource dentro do WITH nao cria colunas imediatamente)
374:         loc_oPagina.grd_4c_Lista.ColumnCount = 7
375:         WITH loc_oPagina.grd_4c_Lista
376:             .Top                = 117
377:             .Left               = 26
378:             .Width              = 880
379:             .Height             = 498
380:             .FontName           = "Verdana"
381:             .FontSize           = 8
382:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 411 a 754:
411:         *-- Container Cabecalho - PRIMEIRO AddObject da pagina (regra #11: faixa nas DUAS paginas)
412:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
413:         WITH loc_oPagina.cnt_4c_Cabecalho
414:             .Top         = 29
415:             .Left        = 0
416:             .Width       = THIS.Width
417:             .Height      = 80
418:             .BackColor   = RGB(100, 100, 100)
419:             .BorderWidth = 0
420:             .Visible     = .T.
421:         ENDWITH
422: 
423:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
424:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
425:             .Caption   = THIS.Caption
426:             .Top       = 15
427:             .Left      = 10
428:             .Width     = THIS.Width - 20
429:             .Height    = 40
430:             .FontName  = "Tahoma"
431:             .FontSize  = 16
432:             .FontBold  = .T.
433:             .ForeColor = RGB(0, 0, 0)
434:             .BackStyle = 0
435:             .AutoSize  = .F.
436:             .Visible   = .T.
437:         ENDWITH
438: 
439:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
440:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
441:             .Caption   = THIS.Caption
442:             .Top       = 18
443:             .Left      = 10
444:             .Width     = THIS.Width - 20
445:             .Height    = 46
446:             .FontName  = "Tahoma"
447:             .FontSize  = 16
448:             .FontBold  = .T.
449:             .ForeColor = RGB(255, 255, 255)
450:             .BackStyle = 0
451:             .AutoSize  = .F.
452:             .Visible   = .T.
453:         ENDWITH
454: 
455:         *-- Container Botoes de Acao (Grupo_salva no legado) - canonico
456:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
457:         WITH loc_oPagina.cnt_4c_BotoesAcao
458:             .Top         = 33
459:             .Left        = 842
460:             .Width       = 160
461:             .Height      = 85
462:             .BackStyle = 1
463:             .BackColor = RGB(255, 255, 255)
464:             .BorderWidth = 0
465:             .Visible     = .T.
466:         ENDWITH
467: 
468:         *-- Botao Confirmar/Salvar (Left=5)
469:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
470:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
471:             .Caption         = "Confirmar"
472:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
473:             .PicturePosition = 13
474:             .Top             = 5
475:             .Left            = 5
476:             .Width           = 75
477:             .Height          = 75
478:             .FontName        = "Tahoma"
479:             .FontBold        = .T.
480:             .FontItalic      = .T.
481:             .FontSize        = 8
482:             .ForeColor       = RGB(90, 90, 90)
483:             .BackColor       = RGB(255, 255, 255)
484:             .Themes          = .F.
485:             .SpecialEffect   = 0
486:             .MousePointer    = 15
487:             .WordWrap        = .T.
488:             .AutoSize        = .F.
489:             .Visible         = .T.
490:         ENDWITH
491:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
492: 
493:         *-- Botao Cancelar (Left=80)
494:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
495:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
496:             .Caption         = "Encerrar"
497:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
498:             .PicturePosition = 13
499:             .Top             = 5
500:             .Left            = 80
501:             .Width           = 75
502:             .Height          = 75
503:             .FontName        = "Tahoma"
504:             .FontBold        = .T.
505:             .FontItalic      = .T.
506:             .FontSize        = 8
507:             .ForeColor       = RGB(90, 90, 90)
508:             .BackColor       = RGB(255, 255, 255)
509:             .Themes          = .F.
510:             .SpecialEffect   = 0
511:             .MousePointer    = 15
512:             .WordWrap        = .T.
513:             .AutoSize        = .F.
514:             .Visible         = .T.
515:         ENDWITH
516:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
517: 
518:         *-- FASE 5/8: Campos principais (parte 1) - identificacao do movimento
519:         *-- Legado: getCodigo/getEmpD/getDatas (pgOperacional) + Origem/Destino
520:         *-- (pgContas.Origem/Destino Get_grupo/Get_conta). Layout simplificado:
521:         *-- campos direto na Page2, sem reproduzir o PageFrame interno pgfPrincipal
522:         *-- (escopo desta fase e a identificacao do movimento; abas Operacional/
523:         *-- Informacoes/Contas completas ficam para fases seguintes).
524: 
525:         *-- Linha 1: Empresa / Operacao / Numero
526:         loc_oPagina.AddObject("lbl_4c_Emps", "Label")
527:         WITH loc_oPagina.lbl_4c_Emps
528:             .Caption   = "Emp :"
529:             .Left      = 30
530:             .Top       = 120
531:             .AutoSize  = .T.
532:             .BackStyle = 0
533:             .FontName  = "Tahoma"
534:             .FontSize  = 8
535:             .ForeColor = RGB(90, 90, 90)
536:             .Visible   = .T.
537:         ENDWITH
538:         loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
539:         WITH loc_oPagina.txt_4c_Emps
540:             .Left          = 65
541:             .Top           = 118
542:             .Width         = 45
543:             .Height        = 21
544:             .MaxLength     = 3
545:             .SpecialEffect = 1
546:             .FontName      = "Tahoma"
547:             .FontSize      = 8
548:             .Visible       = .T.
549:         ENDWITH
550: 
551:         loc_oPagina.AddObject("lbl_4c_Dopes", "Label")
552:         WITH loc_oPagina.lbl_4c_Dopes
553:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
554:             .Left      = 130
555:             .Top       = 120
556:             .AutoSize  = .T.
557:             .BackStyle = 0
558:             .FontName  = "Tahoma"
559:             .FontSize  = 8
560:             .ForeColor = RGB(90, 90, 90)
561:             .Visible   = .T.
562:         ENDWITH
563:         loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
564:         WITH loc_oPagina.txt_4c_Dopes
565:             .Left          = 185
566:             .Top           = 118
567:             .Width         = 200
568:             .Height        = 21
569:             .MaxLength     = 20
570:             .ReadOnly      = .T.
571:             .SpecialEffect = 1
572:             .FontName      = "Tahoma"
573:             .FontSize      = 8
574:             .BackColor     = RGB(240, 240, 240)
575:             .Visible       = .T.
576:         ENDWITH
577: 
578:         loc_oPagina.AddObject("lbl_4c_Numes", "Label")
579:         WITH loc_oPagina.lbl_4c_Numes
580:             .Caption   = "N" + CHR(250) + "mero :"
581:             .Left      = 400
582:             .Top       = 120
583:             .AutoSize  = .T.
584:             .BackStyle = 0
585:             .FontName  = "Tahoma"
586:             .FontSize  = 8
587:             .ForeColor = RGB(90, 90, 90)
588:             .Visible   = .T.
589:         ENDWITH
590:         loc_oPagina.AddObject("txt_4c_Numes", "TextBox")
591:         WITH loc_oPagina.txt_4c_Numes
592:             .Left          = 450
593:             .Top           = 118
594:             .Width         = 90
595:             .Height        = 21
596:             .InputMask     = "999999"
597:             .ReadOnly      = .T.
598:             .SpecialEffect = 1
599:             .FontName      = "Tahoma"
600:             .FontSize      = 8
601:             .BackColor     = RGB(240, 240, 240)
602:             .Visible       = .T.
603:         ENDWITH
604: 
605:         *-- Linha 2: Data
606:         loc_oPagina.AddObject("lbl_4c_Datas", "Label")
607:         WITH loc_oPagina.lbl_4c_Datas
608:             .Caption   = "Data :"
609:             .Left      = 30
610:             .Top       = 155
611:             .AutoSize  = .T.
612:             .BackStyle = 0
613:             .FontName  = "Tahoma"
614:             .FontSize  = 8
615:             .ForeColor = RGB(90, 90, 90)
616:             .Visible   = .T.
617:         ENDWITH
618:         loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
619:         WITH loc_oPagina.txt_4c_Datas
620:             .Left          = 65
621:             .Top           = 153
622:             .Width         = 100
623:             .Height        = 21
624:             .Format        = "K"
625:             .SpecialEffect = 1
626:             .FontName      = "Tahoma"
627:             .FontSize      = 8
628:             .Visible       = .T.
629:         ENDWITH
630: 
631:         *-- Linha 3: Grupo/Conta Origem
632:         loc_oPagina.AddObject("lbl_4c_GrupoOs", "Label")
633:         WITH loc_oPagina.lbl_4c_GrupoOs
634:             .Caption   = "Grupo Origem :"
635:             .Left      = 30
636:             .Top       = 190
637:             .AutoSize  = .T.
638:             .BackStyle = 0
639:             .FontName  = "Tahoma"
640:             .FontSize  = 8
641:             .ForeColor = RGB(90, 90, 90)
642:             .Visible   = .T.
643:         ENDWITH
644:         loc_oPagina.AddObject("txt_4c_GrupoOs", "TextBox")
645:         WITH loc_oPagina.txt_4c_GrupoOs
646:             .Left          = 130
647:             .Top           = 188
648:             .Width         = 80
649:             .Height        = 21
650:             .MaxLength     = 10
651:             .SpecialEffect = 1
652:             .FontName      = "Tahoma"
653:             .FontSize      = 8
654:             .Visible       = .T.
655:         ENDWITH
656: 
657:         loc_oPagina.AddObject("lbl_4c_ContaOs", "Label")
658:         WITH loc_oPagina.lbl_4c_ContaOs
659:             .Caption   = "Conta Origem :"
660:             .Left      = 230
661:             .Top       = 190
662:             .AutoSize  = .T.
663:             .BackStyle = 0
664:             .FontName  = "Tahoma"
665:             .FontSize  = 8
666:             .ForeColor = RGB(90, 90, 90)
667:             .Visible   = .T.
668:         ENDWITH
669:         loc_oPagina.AddObject("txt_4c_ContaOs", "TextBox")
670:         WITH loc_oPagina.txt_4c_ContaOs
671:             .Left          = 330
672:             .Top           = 188
673:             .Width         = 120
674:             .Height        = 21
675:             .MaxLength     = 10
676:             .SpecialEffect = 1
677:             .FontName      = "Tahoma"
678:             .FontSize      = 8
679:             .Visible       = .T.
680:         ENDWITH
681: 
682:         *-- Linha 4: Grupo/Conta Destino
683:         loc_oPagina.AddObject("lbl_4c_GrupoDs", "Label")
684:         WITH loc_oPagina.lbl_4c_GrupoDs
685:             .Caption   = "Grupo Destino :"
686:             .Left      = 30
687:             .Top       = 225
688:             .AutoSize  = .T.
689:             .BackStyle = 0
690:             .FontName  = "Tahoma"
691:             .FontSize  = 8
692:             .ForeColor = RGB(90, 90, 90)
693:             .Visible   = .T.
694:         ENDWITH
695:         loc_oPagina.AddObject("txt_4c_GrupoDs", "TextBox")
696:         WITH loc_oPagina.txt_4c_GrupoDs
697:             .Left          = 130
698:             .Top           = 223
699:             .Width         = 80
700:             .Height        = 21
701:             .MaxLength     = 10
702:             .SpecialEffect = 1
703:             .FontName      = "Tahoma"
704:             .FontSize      = 8
705:             .Visible       = .T.
706:         ENDWITH
707: 
708:         loc_oPagina.AddObject("lbl_4c_ContaDs", "Label")
709:         WITH loc_oPagina.lbl_4c_ContaDs
710:             .Caption   = "Conta Destino :"
711:             .Left      = 230
712:             .Top       = 225
713:             .AutoSize  = .T.
714:             .BackStyle = 0
715:             .FontName  = "Tahoma"
716:             .FontSize  = 8
717:             .ForeColor = RGB(90, 90, 90)
718:             .Visible   = .T.
719:         ENDWITH
720:         loc_oPagina.AddObject("txt_4c_ContaDs", "TextBox")
721:         WITH loc_oPagina.txt_4c_ContaDs
722:             .Left          = 330
723:             .Top           = 223
724:             .Width         = 120
725:             .Height        = 21
726:             .MaxLength     = 10
727:             .SpecialEffect = 1
728:             .FontName      = "Tahoma"
729:             .FontSize      = 8
730:             .Visible       = .T.
731:         ENDWITH
732: 
733:         *-- Linha 5: Vendedor
734:         loc_oPagina.AddObject("lbl_4c_Vends", "Label")
735:         WITH loc_oPagina.lbl_4c_Vends
736:             .Caption   = "Vendedor :"
737:             .Left      = 30
738:             .Top       = 260
739:             .AutoSize  = .T.
740:             .BackStyle = 0
741:             .FontName  = "Tahoma"
742:             .FontSize  = 8
743:             .ForeColor = RGB(90, 90, 90)
744:             .Visible   = .T.
745:         ENDWITH
746:         loc_oPagina.AddObject("txt_4c_Vends", "TextBox")
747:         WITH loc_oPagina.txt_4c_Vends
748:             .Left          = 130
749:             .Top           = 258
750:             .Width         = 120
751:             .Height        = 21
752:             .MaxLength     = 10
753:             .SpecialEffect = 1
754:             .FontName      = "Tahoma"

*-- Linhas 772 a 924:
772:         *-- publicidade, lista de precos, valor e observacao
773: 
774:         *-- Linha 6: Tabela de Desconto / Lista de Precos
775:         loc_oPagina.AddObject("lbl_4c_Tabds", "Label")
776:         WITH loc_oPagina.lbl_4c_Tabds
777:             .Caption   = "Tabela Desc. :"
778:             .Left      = 30
779:             .Top       = 295
780:             .AutoSize  = .T.
781:             .BackStyle = 0
782:             .FontName  = "Tahoma"
783:             .FontSize  = 8
784:             .ForeColor = RGB(90, 90, 90)
785:             .Visible   = .T.
786:         ENDWITH
787:         loc_oPagina.AddObject("txt_4c_Tabds", "TextBox")
788:         WITH loc_oPagina.txt_4c_Tabds
789:             .Left          = 130
790:             .Top           = 293
791:             .Width         = 80
792:             .Height        = 21
793:             .MaxLength     = 10
794:             .SpecialEffect = 1
795:             .FontName      = "Tahoma"
796:             .FontSize      = 8
797:             .Visible       = .T.
798:         ENDWITH
799: 
800:         loc_oPagina.AddObject("lbl_4c_Lprecos", "Label")
801:         WITH loc_oPagina.lbl_4c_Lprecos
802:             .Caption   = "Lista Pre" + CHR(231) + CHR(111) + "s :"
803:             .Left      = 230
804:             .Top       = 295
805:             .AutoSize  = .T.
806:             .BackStyle = 0
807:             .FontName  = "Tahoma"
808:             .FontSize  = 8
809:             .ForeColor = RGB(90, 90, 90)
810:             .Visible   = .T.
811:         ENDWITH
812:         loc_oPagina.AddObject("txt_4c_Lprecos", "TextBox")
813:         WITH loc_oPagina.txt_4c_Lprecos
814:             .Left          = 330
815:             .Top           = 293
816:             .Width         = 120
817:             .Height        = 21
818:             .MaxLength     = 30
819:             .SpecialEffect = 1
820:             .FontName      = "Tahoma"
821:             .FontSize      = 8
822:             .Visible       = .T.
823:         ENDWITH
824: 
825:         *-- Linha 7: Job / Forma de Publicidade
826:         loc_oPagina.AddObject("lbl_4c_Jobs", "Label")
827:         WITH loc_oPagina.lbl_4c_Jobs
828:             .Caption   = "Job :"
829:             .Left      = 30
830:             .Top       = 330
831:             .AutoSize  = .T.
832:             .BackStyle = 0
833:             .FontName  = "Tahoma"
834:             .FontSize  = 8
835:             .ForeColor = RGB(90, 90, 90)
836:             .Visible   = .T.
837:         ENDWITH
838:         loc_oPagina.AddObject("txt_4c_Jobs", "TextBox")
839:         WITH loc_oPagina.txt_4c_Jobs
840:             .Left          = 130
841:             .Top           = 328
842:             .Width         = 80
843:             .Height        = 21
844:             .MaxLength     = 10
845:             .SpecialEffect = 1
846:             .FontName      = "Tahoma"
847:             .FontSize      = 8
848:             .Visible       = .T.
849:         ENDWITH
850: 
851:         loc_oPagina.AddObject("lbl_4c_Fpubls", "Label")
852:         WITH loc_oPagina.lbl_4c_Fpubls
853:             .Caption   = "F. Publicidade :"
854:             .Left      = 230
855:             .Top       = 330
856:             .AutoSize  = .T.
857:             .BackStyle = 0
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .ForeColor = RGB(90, 90, 90)
861:             .Visible   = .T.
862:         ENDWITH
863:         loc_oPagina.AddObject("txt_4c_Fpubls", "TextBox")
864:         WITH loc_oPagina.txt_4c_Fpubls
865:             .Left          = 330
866:             .Top           = 328
867:             .Width         = 60
868:             .Height        = 21
869:             .MaxLength     = 3
870:             .SpecialEffect = 1
871:             .FontName      = "Tahoma"
872:             .FontSize      = 8
873:             .Visible       = .T.
874:         ENDWITH
875: 
876:         *-- Linha 8: Valor
877:         loc_oPagina.AddObject("lbl_4c_Valos", "Label")
878:         WITH loc_oPagina.lbl_4c_Valos
879:             .Caption   = "Valor :"
880:             .Left      = 30
881:             .Top       = 365
882:             .AutoSize  = .T.
883:             .BackStyle = 0
884:             .FontName  = "Tahoma"
885:             .FontSize  = 8
886:             .ForeColor = RGB(90, 90, 90)
887:             .Visible   = .T.
888:         ENDWITH
889:         loc_oPagina.AddObject("txt_4c_Valos", "TextBox")
890:         WITH loc_oPagina.txt_4c_Valos
891:             .Left          = 130
892:             .Top           = 363
893:             .Width         = 120
894:             .Height        = 21
895:             .InputMask     = "999,999,999.99"
896:             .Alignment     = 1
897:             .SpecialEffect = 1
898:             .FontName      = "Tahoma"
899:             .FontSize      = 8
900:             .Visible       = .T.
901:         ENDWITH
902: 
903:         *-- Linha 9: Observacao (memo)
904:         loc_oPagina.AddObject("lbl_4c_Obses", "Label")
905:         WITH loc_oPagina.lbl_4c_Obses
906:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
907:             .Left      = 30
908:             .Top       = 400
909:             .AutoSize  = .T.
910:             .BackStyle = 0
911:             .FontName  = "Tahoma"
912:             .FontSize  = 8
913:             .ForeColor = RGB(90, 90, 90)
914:             .Visible   = .T.
915:         ENDWITH
916:         loc_oPagina.AddObject("txt_4c_Obses", "EditBox")
917:         WITH loc_oPagina.txt_4c_Obses
918:             .Left          = 130
919:             .Top           = 398
920:             .Width         = 500
921:             .Height        = 60
922:             .SpecialEffect = 1
923:             .FontName      = "Tahoma"
924:             .FontSize      = 8

*-- Linhas 966 a 980:
966:                 loc_oGrid.Column7.Width = 130
967: 
968:                 *-- Headers APOS RecordSource (RecordSource reseta os captions)
969:                 loc_oGrid.Column1.Header1.Caption = "Emp"
970:                 loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
971:                 loc_oGrid.Column3.Header1.Caption = "N" + CHR(250) + "mero"
972:                 loc_oGrid.Column4.Header1.Caption = "Data"
973:                 loc_oGrid.Column5.Header1.Caption = "Conta Origem"
974:                 loc_oGrid.Column6.Header1.Caption = "Conta Destino"
975:                 loc_oGrid.Column7.Header1.Caption = "Valor"
976: 
977:                 THIS.FormatarGridLista(loc_oGrid)
978:                 loc_lResultado = .T.
979:             ENDIF
980: 

*-- Linhas 1357 a 1393:
1357:         loc_oPg.txt_4c_Jobs.Enabled     = par_lHabilitar
1358:         loc_oPg.txt_4c_Fpubls.Enabled   = par_lHabilitar
1359:         loc_oPg.txt_4c_Valos.Enabled    = par_lHabilitar
1360:         loc_oPg.txt_4c_Obses.Enabled    = par_lHabilitar
1361: 
1362:         loc_oPg.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1363:     ENDPROC
1364: 
1365:     *===========================================================================
1366:     * AjustarBotoesPorModo - Ajusta caption/estado dos botoes de acao da Page2
1367:     * (cnt_4c_BotoesAcao) conforme this_cModoAtual (INCLUIR/ALTERAR/VISUALIZAR).
1368:     * Chamado junto com HabilitarCampos() apos this_cModoAtual ser definido.
1369:     * Confirmar fica desabilitado em VISUALIZAR (regra #20 CLAUDE.md: falha de
1370:     * gravacao/modo somente-leitura nunca deixa o botao de gravar acionavel);
1371:     * Cancelar vira "Voltar" nesse modo, pois nao ha alteracao a descartar.
1372:     *===========================================================================
1373:     PROCEDURE AjustarBotoesPorModo()
1374:         LOCAL loc_oBotoes
1375:         loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1376: 
1377:         DO CASE
1378:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1379:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .F.
1380:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Voltar"
1381: 
1382:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1383:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
1384:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
1385: 
1386:             OTHERWISE
1387:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
1388:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
1389:         ENDCASE
1390:     ENDPROC
1391: 
1392:     *===========================================================================
1393:     * Lookups (F4/DblClick) - Grupo/Conta Origem, Grupo/Conta Destino, Vendedor

