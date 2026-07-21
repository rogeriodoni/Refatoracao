# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1039 linhas total):

*-- Linhas 11 a 32:
11: * Layout original (800px) escalado para 1000px (fator 1.25)
12: * Estrutura flat:
13: *   cnt_4c_Cabecalho (Top=0, L=0, W=1000, H=80)
14: *   cmd_4c_Encerrar  (Top=3, L=910, W=75, H=75) - standalone sobre cabecalho
15: *   cmd_4c_Atualizar (Top=3, L=825, W=75, H=75) - standalone sobre cabecalho
16: *   Labels filtros + txt_4c_CProsI/F + txt_4c_CGrus + cmd_4c_Selecionar (Top=135)
17: *   grd_4c_Dados     (Top=164, L=15, W=960, H=343)
18: *==============================================================================
19: 
20: DEFINE CLASS FormSigPrDsc AS FormBase
21: 
22:     *--------------------------------------------------------------------------
23:     * Propriedades visuais (identicas ao legado, width escalado 800->1000)
24:     *--------------------------------------------------------------------------
25:     Height      = 600
26:     Width       = 1000
27:     BorderStyle = 2
28:     AutoCenter  = .T.
29:     ShowTips    = .T.
30:     TitleBar    = 0
31:     ShowWindow = 1
32:     ControlBox  = .F.

*-- Linhas 57 a 65:
57: 
58:         TRY
59:             *-- Caption com acentos via CHR()
60:             THIS.Caption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"
61: 
62:             *-- Criar Business Object
63:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrDscBO")
64:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
65: 

*-- Linhas 87 a 96:
87:                     THIS.ConfigurarCabecalho()
88: 
89:                     *-- Propagar Caption para labels do cabecalho
90:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
91:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
92: 
93:                     *-- Configurar botoes de acao no canto superior direito
94:                     THIS.ConfigurarBotoes()
95: 
96:                     *-- Configurar area de filtros/input (equivalente Page2 Dados em OPERACIONAL)

*-- Linhas 142 a 179:
142: 
143:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
144:         WITH THIS.cnt_4c_Cabecalho
145:             .Top         = 0
146:             .Left        = 0
147:             .Width       = 1000
148:             .Height      = 80
149:             .BackStyle   = 1
150:             .BackColor   = RGB(100, 100, 100)
151:             .BorderWidth = 0
152: 
153:             .AddObject("lbl_4c_Sombra", "Label")
154:             WITH .lbl_4c_Sombra
155:                 .Top      = 18
156:                 .Left     = 10
157:                 .Width    = THIS.Width
158:                 .Height   = 40
159:                 .Caption  = loc_cCaption
160:                 .FontName = "Tahoma"
161:                 .FontSize = 18
162:                 .FontBold = .T.
163:                 .BackStyle = 0
164:                 .AutoSize  = .F.
165:                 .ForeColor = RGB(0, 0, 0)
166:             ENDWITH
167: 
168:             .AddObject("lbl_4c_Titulo", "Label")
169:             WITH .lbl_4c_Titulo
170:                 .Top      = 17
171:                 .Left     = 10
172:                 .Width    = THIS.Width
173:                 .Height   = 46
174:                 .Caption  = loc_cCaption
175:                 .FontName = "Tahoma"
176:                 .FontSize = 18
177:                 .FontBold = .T.
178:                 .BackStyle = 0
179:                 .AutoSize  = .F.

*-- Linhas 186 a 200:
186:     PROTECTED PROCEDURE ConfigurarBotoes
187:     *==========================================================================
188:         *-- btnSair (Encerrar): Top=3, Left=725 no legado 800px -> Left=905 em 1000px
189:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
190:         WITH THIS.cmd_4c_Encerrar
191:             .Top             = 3
192:             .Left            = 905
193:             .Width           = 75
194:             .Height          = 75
195:             .Caption         = "Encerrar"
196:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
197:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
198:             .Themes          = .T.
199:             .FontName        = "Tahoma"
200:             .FontSize        = 8

*-- Linhas 210 a 227:
210:             .Cancel          = .T.
211:             .ZOrderSet       = 1
212:         ENDWITH
213:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
214: 
215:         *-- btnAtualizar: Top=3, Left=650 no legado 800px -> Left=820 em 1000px
216:         THIS.AddObject("cmd_4c_Atualizar", "CommandButton")
217:         WITH THIS.cmd_4c_Atualizar
218:             .Top             = 3
219:             .Left            = 820
220:             .Width           = 75
221:             .Height          = 75
222:             .Caption         = "Atualizar"
223:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
224:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
225:             .Themes          = .T.
226:             .FontName        = "Tahoma"
227:             .FontSize        = 8

*-- Linhas 236 a 410:
236:             .AutoSize        = .F.
237:             .Enabled         = .F.
238:         ENDWITH
239:         BINDEVENT(THIS.cmd_4c_Atualizar, "Click", THIS, "BtnAtualizarClick")
240:     ENDPROC
241: 
242:     *==========================================================================
243:     PROTECTED PROCEDURE ConfigurarFiltros
244:     *==========================================================================
245:         *-- "Produtos de :" Say3 - Left=155 em 800px -> Left=194 em 1000px
246:         THIS.AddObject("lbl_4c_LblProdutos", "Label")
247:         WITH THIS.lbl_4c_LblProdutos
248:             .Top      = 138
249:             .Left     = 194
250:             .Width    = 95
251:             .Height   = 18
252:             .Caption  = "Produtos de :"
253:             .FontName = "Tahoma"
254:             .FontSize = 8
255:             .FontBold = .T.
256:             .AutoSize = .F.
257:             .ForeColor = RGB(90, 90, 90)
258:             .BackStyle = 0
259:         ENDWITH
260: 
261:         *-- getCProsI - Left=233 em 800px -> Left=291 em 1000px
262:         THIS.AddObject("txt_4c_CProsI", "TextBox")
263:         WITH THIS.txt_4c_CProsI
264:             .Top       = 135
265:             .Left      = 291
266:             .Width     = 135
267:             .Height    = 23
268:             .Value     = ""
269:             .MaxLength = 14
270:             .Format    = "K"
271:             .FontName  = "Tahoma"
272:             .FontSize  = 8
273:         ENDWITH
274:         BINDEVENT(THIS.txt_4c_CProsI, "KeyPress", THIS, "TxtCProsIKeyPress")
275: 
276:         *-- "ate" label - Say1 Left=345 em 800px -> Left=431 em 1000px
277:         THIS.AddObject("lbl_4c_Ate", "Label")
278:         WITH THIS.lbl_4c_Ate
279:             .Top      = 138
280:             .Left     = 431
281:             .Width    = 26
282:             .Height   = 18
283:             .Caption  = "at" + CHR(233)
284:             .FontName = "Tahoma"
285:             .FontSize = 8
286:             .FontBold = .T.
287:             .AutoSize = .F.
288:             .ForeColor = RGB(90, 90, 90)
289:             .BackStyle = 0
290:         ENDWITH
291: 
292:         *-- getCProsF - Left=370 em 800px -> Left=462 em 1000px
293:         THIS.AddObject("txt_4c_CProsF", "TextBox")
294:         WITH THIS.txt_4c_CProsF
295:             .Top       = 135
296:             .Left      = 462
297:             .Width     = 135
298:             .Height    = 23
299:             .Value     = ""
300:             .MaxLength = 14
301:             .Format    = "K"
302:             .FontName  = "Tahoma"
303:             .FontSize  = 8
304:         ENDWITH
305:         BINDEVENT(THIS.txt_4c_CProsF, "KeyPress", THIS, "TxtCProsFKeyPress")
306: 
307:         *-- "Grupo de Produto :" - Say2 Left=505 em 800px -> Left=631 em 1000px
308:         THIS.AddObject("lbl_4c_LblGrupo", "Label")
309:         WITH THIS.lbl_4c_LblGrupo
310:             .Top      = 138
311:             .Left     = 631
312:             .Width    = 134
313:             .Height   = 18
314:             .Caption  = "Grupo de Produto :"
315:             .FontName = "Tahoma"
316:             .FontSize = 8
317:             .FontBold = .T.
318:             .AutoSize = .F.
319:             .ForeColor = RGB(90, 90, 90)
320:             .BackStyle = 0
321:         ENDWITH
322: 
323:         *-- getCGrus - Left=614 em 800px -> Left=768 em 1000px
324:         THIS.AddObject("txt_4c_CGrus", "TextBox")
325:         WITH THIS.txt_4c_CGrus
326:             .Top       = 135
327:             .Left      = 768
328:             .Width     = 39
329:             .Height    = 23
330:             .Value     = ""
331:             .MaxLength = 3
332:             .Format    = "K"
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:         ENDWITH
336:         BINDEVENT(THIS.txt_4c_CGrus, "KeyPress", THIS, "TxtCGrusKeyPress")
337: 
338:         *-- btnSelecionar (arrow/search) - Left=744 em 800px -> Left=818 em 1000px
339:         *-- Original: a_arrow6.bmp (nao portado) -> usar geral_procura_60.jpg
340:         THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
341:         WITH THIS.cmd_4c_Selecionar
342:             .Top             = 116
343:             .Left            = 818
344:             .Width           = 75
345:             .Height          = 27
346:             .Caption         = "Selecionar"
347:             .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
348:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
349:             .Themes          = .T.
350:             .FontName        = "Tahoma"
351:             .FontSize        = 8
352:             .FontBold        = .T.
353:             .ForeColor       = RGB(90, 90, 90)
354:             .BackColor       = RGB(255, 255, 255)
355:             .SpecialEffect   = 0
356:             .MousePointer    = 15
357:             .ToolTipText     = "Selecionar"
358:         ENDWITH
359:         BINDEVENT(THIS.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
360:     ENDPROC
361: 
362:     *==========================================================================
363:     * ConfigurarPaginaDados - configura area de input/filtros (equivalente Page2 Dados)
364:     * Em OPERACIONAL flat, os TextBoxes de entrada (CProsI, CProsF, CGrus) e Labels
365:     * associados correspondem funcionalmente aos "campos da Page2 Dados" do padrao CRUD:
366:     * eh a area onde o usuario digita/seleciona parametros antes de acionar Selecionar.
367:     *==========================================================================
368:     PROTECTED PROCEDURE ConfigurarPaginaDados
369:         THIS.ConfigurarFiltros()
370:     ENDPROC
371: 
372:     *==========================================================================
373:     * ConfigurarPaginaLista - configura grade de resultados (equivalente Page1 Lista)
374:     * Em OPERACIONAL flat, o grid grd_4c_Dados corresponde funcionalmente a Page1
375:     * Lista do padrao CRUD: eh o output visual dos registros processados.
376:     *==========================================================================
377:     PROTECTED PROCEDURE ConfigurarPaginaLista
378:         THIS.ConfigurarGrade()
379:     ENDPROC
380: 
381:     *==========================================================================
382:     * AlternarPagina - stub para OPERACIONAL (sem alternancia de paginas)
383:     * Forms OPERACIONAIS flat nao possuem Page1/Page2 como forms CRUD.
384:     *==========================================================================
385:     PROCEDURE AlternarPagina
386:         LPARAMETERS par_nPagina
387:         *-- Nao aplicavel: layout flat sem PageFrame de alternancia
388:     ENDPROC
389: 
390:     *==========================================================================
391:     PROTECTED PROCEDURE ConfigurarGrade
392:     *==========================================================================
393:         *-- Grade - Top=164, Left=15, Width=769 em 800px -> Width=960 em 1000px
394:         THIS.AddObject("grd_4c_Dados", "Grid")
395:         WITH THIS.grd_4c_Dados
396:             .Top               = 164
397:             .Left              = 15
398:             .Width             = 960
399:             .Height            = 343
400:             .ColumnCount       = 3
401:             .RecordSource      = "cursor_4c_Produtos"
402:             .Column1.ControlSource = "cursor_4c_Produtos.CPros"
403:             .Column2.ControlSource = "cursor_4c_Produtos.Portugues"
404:             .Column3.ControlSource = "cursor_4c_Produtos.Traduzido"
405:             .RecordMark        = .F.
406:             .DeleteMark        = .F.
407:             .AllowHeaderSizing = .F.
408:             .AllowRowSizing    = .F.
409:             .RowHeight         = 17
410:             .HeaderHeight      = 17

*-- Linhas 419 a 448:
419:             WITH .Column1
420:                 .ControlSource = "cursor_4c_Produtos.CPros"
421:                 .Width         = 135
422:                 .Header1.Caption   = "C" + CHR(243) + "digo"
423:                 .Header1.FontName  = "Tahoma"
424:                 .Header1.FontSize  = 8
425:                 .Header1.Alignment = 2
426:                 .ReadOnly          = .T.
427:             ENDWITH
428: 
429:             WITH .Column2
430:                 .ControlSource = "cursor_4c_Produtos.Portugues"
431:                 .Width         = 363
432:                 .ReadOnly          = .T.
433:                 .Header1.Caption   = "Portugu" + CHR(234) + "s"
434:                 .Header1.FontName  = "Tahoma"
435:                 .Header1.FontSize  = 8
436:                 .Header1.Alignment = 2
437:             ENDWITH
438: 
439:             WITH .Column3
440:                 .ControlSource = "cursor_4c_Produtos.Traduzido"
441:                 .Width         = 424
442:                 .ReadOnly          = .T.
443:                 .Header1.Caption   = "Traduzido"
444:                 .Header1.FontName  = "Tahoma"
445:                 .Header1.FontSize  = 8
446:                 .Header1.Alignment = 2
447:             ENDWITH
448:         ENDWITH

*-- Linhas 504 a 529:
504:         LOCAL loc_lSucesso, loc_oErro
505:         loc_lSucesso = .F.
506:         TRY
507:             THIS.cmd_4c_Atualizar.Enabled = .F.
508:             loc_lSucesso = THIS.this_oBusinessObject.GravarDescricoes()
509:             IF loc_lSucesso
510:                 LOCAL loc_nTotal
511:                 loc_nTotal = THIS.this_oBusinessObject.this_nTotalGravados
512:                 MsgInfo("Foram gravados " + TRANSFORM(loc_nTotal) + " produto(s).", ;
513:                         "Processamento Conclu" + CHR(237) + "do")
514:                 THIS.grd_4c_Dados.Refresh()
515:             ENDIF
516:         CATCH TO loc_oErro
517:             MsgErro(loc_oErro.Message, "Erro")
518:         ENDTRY
519:     ENDPROC
520: 
521:     PROCEDURE BtnSelecionarClick
522:         LOCAL loc_lSucesso, loc_oErro
523:         loc_lSucesso = .F.
524:         TRY
525:             *-- Validar: ao menos um filtro deve ser preenchido
526:             IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) AND ;
527:                EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value)) AND ;
528:                EMPTY(ALLTRIM(THIS.txt_4c_CGrus.Value))
529:                 MsgAviso("Nenhum filtro foi informado.", "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 551 a 585:
551:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarTraducoes()
552: 
553:                 IF loc_lSucesso
554:                     THIS.cmd_4c_Atualizar.Enabled = .T.
555:                 ELSE
556:                     THIS.cmd_4c_Atualizar.Enabled = .F.
557:                 ENDIF
558: 
559:                 *-- Recarregar grid (ColumnCount ANTES de RecordSource - regra critica)
560:                 THIS.grd_4c_Dados.ColumnCount  = 3
561:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
562:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.CPros"
563:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.Portugues"
564:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.Traduzido"
565:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "digo"
566:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Portugu" + CHR(234) + "s"
567:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Traduzido"
568:                 SELECT cursor_4c_Produtos
569:                 GO TOP
570:                 THIS.grd_4c_Dados.Refresh()
571: 
572:             ENDIF && filtros preenchidos
573: 
574:         CATCH TO loc_oErro
575:             MsgErro(loc_oErro.Message, "Erro")
576:         ENDTRY
577:     ENDPROC
578: 
579:     *-- KeyPress do txt_4c_CProsI: valida produto e abre picker se nao encontrado
580:     PROCEDURE TxtCProsIKeyPress
581:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
582:         LOCAL loc_cCPros, loc_cSQL, loc_oErro
583: 
584:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
585:             RETURN

*-- Linhas 832 a 852:
832: 
833:             *-- Zera o cursor do grid
834:             IF USED("cursor_4c_Produtos")
835:                 SELECT cursor_4c_Produtos
836:                 ZAP
837:                 THIS.grd_4c_Dados.Refresh()
838:             ENDIF
839: 
840:             THIS.cmd_4c_Atualizar.Enabled = .F.
841:             THIS.this_cModoAtual = "SELECIONAR"
842: 
843:             *-- Foca no primeiro campo de filtro
844:             THIS.txt_4c_CProsI.SetFocus()
845:         CATCH TO loc_oErro
846:             MsgErro(loc_oErro.Message, "Erro")
847:         ENDTRY
848:     ENDPROC
849: 
850:     PROCEDURE BtnAlterarClick
851:         *-- No form OPERACIONAL SigPrDsc, "Alterar" significa gravar as descricoes
852:         *-- editadas no grid de volta a tabela SigCdPro (mesma acao do btnAtualizar).

*-- Linhas 860 a 880:
860:             THIS.BtnSelecionarClick()
861: 
862:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
863:                 SELECT cursor_4c_Produtos
864:                 GO TOP
865:                 THIS.grd_4c_Dados.SetFocus()
866:             ENDIF
867:         CATCH TO loc_oErro
868:             MsgErro(loc_oErro.Message, "Erro")
869:         ENDTRY
870:     ENDPROC
871: 
872:     PROCEDURE BtnExcluirClick
873:         LOCAL loc_lConfirma, loc_oErro
874:         TRY
875:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
876:                 MsgAviso("Nenhum produto selecionado para remover.", ;
877:                         "Aten" + CHR(231) + CHR(227) + "o")
878:                 RETURN
879:             ENDIF
880: 

*-- Linhas 886 a 906:
886:             IF loc_lConfirma
887:                 LOCAL loc_nRestantes
888:                 SELECT cursor_4c_Produtos
889:                 DELETE
890:                 SET DELETED ON
891:                 THIS.grd_4c_Dados.Refresh()
892: 
893:                 *-- Conta registros nao-deletados restantes (COUNT nao aceita IN <alias> em VFP9)
894:                 SELECT cursor_4c_Produtos
895:                 COUNT FOR NOT DELETED() TO loc_nRestantes
896:                 THIS.cmd_4c_Atualizar.Enabled = (loc_nRestantes > 0)
897:             ENDIF
898:         CATCH TO loc_oErro
899:             MsgErro(loc_oErro.Message, "Erro")
900:         ENDTRY
901:     ENDPROC
902: 
903:     *==========================================================================
904:     * METODOS DE INTERFACE FORMBASE (OPERACIONAL)
905:     * Implementacao especifica do form OPERACIONAL SigPrDsc.
906:     * Substituem stubs do FormBase com logica real do form.

*-- Linhas 957 a 966:
957:             THIS.txt_4c_CProsF.Enabled = par_lHabilitar
958:             THIS.txt_4c_CGrus.Enabled  = par_lHabilitar
959:         ENDIF
960:         IF PEMSTATUS(THIS, "cmd_4c_Selecionar", 5)
961:             THIS.cmd_4c_Selecionar.Enabled = par_lHabilitar
962:         ENDIF
963:     ENDPROC
964: 
965:     *-- LimparCampos: limpa filtros de selecao e zera o grid de resultados
966:     PROTECTED PROCEDURE LimparCampos

*-- Linhas 974 a 1007:
974:         ENDIF
975:         IF USED("cursor_4c_Produtos")
976:             SELECT cursor_4c_Produtos
977:             ZAP
978:         ENDIF
979:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
980:             THIS.grd_4c_Dados.Refresh()
981:         ENDIF
982:         IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
983:             THIS.cmd_4c_Atualizar.Enabled = .F.
984:         ENDIF
985:         THIS.HabilitarCampos(.T.)
986:         THIS.this_cModoAtual = "SELECIONAR"
987:     ENDPROC
988: 
989:     *-- CarregarLista: carrega dados iniciais (dicionario de traducoes SigCdDic)
990:     *-- Em OPERACIONAL SigPrDsc a "lista" eh o dicionario; produtos sao carregados
991:     *-- apenas ao acionar Selecionar.
992:     PROCEDURE CarregarLista
993:         RETURN THIS.CarregarDados()
994:     ENDPROC
995: 
996:     *-- AjustarBotoesPorModo: ajusta estado dos botoes conforme produtos no grid
997:     *-- Atualizar habilitado apenas quando ha produtos processados no cursor
998:     PROCEDURE AjustarBotoesPorModo
999:         LOCAL loc_lTemProdutos
1000:         loc_lTemProdutos = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1001:         IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
1002:             THIS.cmd_4c_Atualizar.Enabled = loc_lTemProdutos
1003:         ENDIF
1004:     ENDPROC
1005: 
1006:     *==========================================================================
1007:     PROCEDURE Destroy


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*==============================================================================
* SigPrDscBO.prg - Business Object para Montagem de Descricao de Produtos
* Herda de BusinessBase
* Tabela principal: SigCdPro (atualiza DscCompras/ObsCompras/DPros)
* Tabelas auxiliares: SigCdDic (dicionario), SigCdGrp, SigCdCor, SigPrPrt
*==============================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdPro"
    this_cCampoChave = "CPros"

    *--------------------------------------------------------------------------
    * Filtros de selecao de produtos
    *--------------------------------------------------------------------------
    this_cCProsI = ""  && produto inicial do intervalo C(14)
    this_cCProsF = ""  && produto final do intervalo   C(14)
    this_cCGrus  = ""  && grupo de produto (filtro alternativo) C(3)

    *--------------------------------------------------------------------------
    * Controle de processamento e gravacao
    *--------------------------------------------------------------------------
    this_nTotalProcessados = 0
    this_nTotalGravados    = 0
    this_lGravadoOk        = .F.

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCProsI + "-" + THIS.this_cCProsF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    * Cursor esperado: alias de SigCdPro com ao menos CPros/CGrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCProsI = TratarNulo(CPros, "C")
                THIS.this_cCProsF = TratarNulo(CPros, "C")
                THIS.this_cCGrus  = TratarNulo(CGrus, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDicionario - carrega dicionario de traducoes de SigCdDic
    * Popula cursor_4c_Dicionario (Expressao/Traducao, ordenado por tamanho desc)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDicionario()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dicionario")
                USE IN cursor_4c_Dicionario
            ENDIF
            loc_cSQL = "SELECT Expressao, Traducao " + ;
                       "FROM SigCdDic " + ;
                       "WHERE Idioma = 'INGLES    ' " + ;
                       "ORDER BY LEN(Expressao) DESC, Expressao"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario") < 1
                MsgErro("Falha ao carregar dicion" + CHR(225) + "rio de tradu" + CHR(231) + CHR(245) + "es.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - SELECT de produtos baseado nos filtros do BO
    * Popula cursor_4c_ProdTemp (CPros apenas - lista de codigos)
    * Pre-requisito: this_cCProsI/F e this_cCGrus ja setados pelo form
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPrI, loc_cPrF, loc_cGru, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cPrI = PADR(THIS.this_cCProsI, 14)
            loc_cPrF = PADR(THIS.this_cCProsF, 14)
            loc_cGru = PADR(THIS.this_cCGrus, 3)

            IF !EMPTY(ALLTRIM(loc_cGru))
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CGrus = " + EscaparSQL(ALLTRIM(loc_cGru)) + " " + ;
                           "ORDER BY CPros"
            ELSE
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CPros BETWEEN " + EscaparSQL(loc_cPrI) + " AND " + EscaparSQL(loc_cPrF) + " " + ;
                           "ORDER BY CPros"
            ENDIF

            IF USED("cursor_4c_ProdTemp")
                USE IN cursor_4c_ProdTemp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdTemp") < 1
                MsgErro("Falha ao buscar produtos.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarTraducoes - processa produtos e preenche cursor_4c_Produtos
    * Equivalente ao PROCEDURE processamento do legado (SIGPRDSC.processamento)
    * Pre-requisito: cursor_4c_Dicionario carregado via BuscarDicionario()
    * Pre-requisito: cursor_4c_Produtos criado pelo form (CREATE CURSOR)
    * Pos-execucao: cursor_4c_Produtos contem (CPros/Portugues/Traduzido/DscCompras/ObsCompras)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarTraducoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPro, loc_cDes, loc_cIni
        LOCAL loc_cIng, loc_nGrD, loc_oProg, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Busca lista de produtos no SQL Server
            IF !THIS.BuscarProdutos()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_ProdTemp") OR RECCOUNT("cursor_4c_ProdTemp") = 0
                MsgAviso("Nenhum produto encontrado para os filtros informados.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Zera cursor de resultado do form
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ENDIF

            THIS.this_nTotalProcessados = 0

            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Processando Tradu" + CHR(231) + CHR(245) + "es...", ;
                RECCOUNT("cursor_4c_ProdTemp"))
            loc_oProg.Show

            SELECT cursor_4c_ProdTemp
            GO TOP
            SCAN
                loc_cPro = ALLTRIM(cursor_4c_ProdTemp.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                IF !EMPTY(loc_cPro)
                    loc_cDes = ""

                    *-- Busca dados complementares: grupo + cor do produto
                    loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, " + ;
                               "b.DGrus, b.Mercs, b.MontaGrDs, c.Descs " + ;
                               "FROM SigCdPro a " + ;
                               "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                               "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                               "WHERE a.CPros = " + EscaparSQL(loc_cPro)

                    IF USED("cursor_4c_LocalPro")
                        USE IN cursor_4c_LocalPro
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") >= 1
                        SELECT cursor_4c_LocalPro
                        GO TOP
                        loc_nGrD = NVL(cursor_4c_LocalPro.MontaGrDs, 0)
                        IF loc_nGrD = 1
                            *-- MontaGrDs=1: incluir descricao do grupo (DGrus) + cor (Descs)
                            loc_cDes = ALLTRIM(;
                                ALLTRIM(NVL(cursor_4c_LocalPro.DGrus, "")) + " " + ;
                                ALLTRIM(NVL(cursor_4c_LocalPro.Descs, "")))
                        ELSE
                            *-- MontaGrDs=0: apenas descricao de cor (Descs)
                            loc_cDes = ALLTRIM(NVL(cursor_4c_LocalPro.Descs, ""))
                        ENDIF

                        IF !EMPTY(loc_cDes)
                            loc_cIng = loc_cDes

                            *-- Aplica substituicoes do dicionario portugues->ingles
                            IF USED("cursor_4c_Dicionario")
                                SELECT cursor_4c_Dicionario
                                GO TOP
                                SCAN
                                    loc_cIng = STRTRAN(loc_cIng, ;
                                        ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                        ALLTRIM(cursor_4c_Dicionario.Traducao))
                                ENDSCAN
                            ENDIF

                            *-- Remove aspas simples e duplas (protecao SQL)
                            loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                            loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                            *-- Insere no cursor de produtos (DscCompras=traduzido, ObsCompras=portugues)
                            SELECT cursor_4c_Produtos
                            INSERT INTO cursor_4c_Produtos ;
                                (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                                VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)

                            THIS.this_nTotalProcessados = THIS.this_nTotalProcessados + 1
                        ENDIF

                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            SELECT cursor_4c_Produtos
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDescricoes - grava descricoes nos produtos (UPDATE SigCdPro)
    * Equivalente ao PROCEDURE gravacao do legado (SIGPRDSC.gravacao)
    * Pre-requisito: cursor_4c_Produtos populado por ProcessarTraducoes()
    * Cada produto: UPDATE SigCdPro + DELETE SigPrPrt com commit individual
    *--------------------------------------------------------------------------
    PROCEDURE GravarDescricoes()
        LOCAL loc_lSucesso, loc_lOks, loc_cSQL, loc_cPro
        LOCAL loc_oProg, loc_nTotal, loc_oErro
        loc_lSucesso = .F.
        loc_lOks     = .T.
        TRY
            IF !USED("cursor_4c_Produtos")
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_nTotal = RECCOUNT("cursor_4c_Produtos")
            IF loc_nTotal = 0
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.this_nTotalGravados = 0
            THIS.this_lGravadoOk     = .F.

            loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nTotal)
            loc_oProg.Show

            SELECT cursor_4c_Produtos
            GO TOP
            SCAN WHILE loc_lOks
                loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                *-- UPDATE SigCdPro: DscCompras, ObsCompras, DPros
                loc_cSQL = "UPDATE SigCdPro " + ;
                           "SET DscCompras = " + EscaparSQL(cursor_4c_Produtos.DscCompras) + ", " + ;
                               "ObsCompras = " + EscaparSQL(cursor_4c_Produtos.ObsCompras) + ", " + ;
                               "DPros = " + EscaparSQL(PADR(ALLTRIM(cursor_4c_Produtos.Portugues), 40)) + " " + ;
                           "WHERE CPros = " + EscaparSQL(loc_cPro)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao atualizar produto " + loc_cPro + " em SigCdPro.", "Erro")
                    loc_lOks = .F.
                ENDIF

                IF loc_lOks
                    *-- DELETE FROM SigPrPrt: remove produto enviado
                    loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Falha ao excluir produto " + loc_cPro + " de SigPrPrt.", "Erro")
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF loc_lOks
                    SQLCOMMIT(gnConnHandle)
                    THIS.this_nTotalGravados = THIS.this_nTotalGravados + 1
                ELSE
                    SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            IF loc_lOks
                THIS.this_lGravadoOk = .T.
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - grava as descricoes traduzidas (equivalente a UPDATE em lote)
    * Form OPERACIONAL: unico caminho de persistencia disponivel.
    * Espelha o botao btnAtualizar do legado -> chama gravacao/GravarDescricoes.
    * RegistrarAuditoria eh disparada dentro de GravarDescricoes ao final do lote.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.GravarDescricoes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - nao aplicavel a este form OPERACIONAL (nao cria produtos novos)
    * O form atualiza descricoes de produtos ja existentes em SigCdPro.
    * Delegamos a Atualizar para manter contrato de BusinessBase e evitar
    * insercao acidental de registros pelo fluxo padrao Salvar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.Atualizar()
    ENDPROC

ENDDEFINE

