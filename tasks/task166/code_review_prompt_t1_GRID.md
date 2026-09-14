# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 399: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg) - TRECHOS RELEVANTES PARA PASS GRID (758 linhas total):

*-- Linhas 5 a 23:
5: * Chamada: CREATEOBJECT("FormSIGPRCOT", "USD")
6: *   par_cMoes = Codigo da moeda (C(3), ex: "USD", "EUR", "BRL")
7: * Aberto por: FormMoe (botao de cotacoes da moeda selecionada)
8: * Layout: cnt_4c_Cabecalho (80px) + grd_4c_Cotacoes + 3 botoes
9: * Fase 3/8: Estrutura base completa (Init, cabecalho, grid, botoes, handlers)
10: * Fase 4/8: Colunas do grid (ControlSource, Headers, InputMask) + BINDEVENTs de celula
11: * Fase 5/8: BINDEVENTs de validacao nas celulas (Data/Cotacao/Hora KeyPress)
12: * Fase 6/8: SetFocus apos Inserir/Excluir (UX PILAR 1); form completo - sem
13: *           Page2, lookups ou campos adicionais (form de grid inline puro)
14: * Fase 7/8: BtnIncluirClick/BtnExcluirClick delegam para Cmd*; Alterar/Visualizar
15: *           sao no-ops (compatibilidade FormBase, dialog sem Page2 separada)
16: *===============================================================================
17: DEFINE CLASS FormSIGPRCOT AS FormBase
18: 
19:     *-- Dimensoes exatas do original (SIGPRCOT Width=537, Height=377)
20:     Width        = 537
21:     Height       = 377
22:     AutoCenter   = .T.
23:     TitleBar     = 0

*-- Linhas 116 a 151:
116:     * ConfigurarPaginaLista - Monta o corpo do dialog: grid de cotacoes e botoes
117:     * Como este form OPERACIONAL nao possui PageFrame (nao ha Page1/Page2),
118:     * a "pagina lista" corresponde ao proprio form. Este metodo agrega o
119:     * Grid (grd_4c_Cotacoes) e os botoes CRUD (Inserir/Excluir/Encerrar) que
120:     * substituem os equivalentes do SCX legado (inserir/delete/sair).
121:     *===========================================================================
122:     PROTECTED PROCEDURE ConfigurarPaginaLista()
123:         *-- Grid de cotacoes com colunas Data, Hora, Cotacao e BINDEVENTs
124:         THIS.ConfigurarGrid()
125: 
126:         *-- Botoes Inserir / Excluir / Encerrar com BINDEVENT de Click
127:         THIS.ConfigurarBotoes()
128:     ENDPROC
129: 
130:     *===========================================================================
131:     * ConfigurarPaginaDados - Sem Page2 neste form OPERACIONAL
132:     * Dialog modal com grid de edicao inline. Metodo de compatibilidade
133:     * com o pipeline de migracao multi-fase.
134:     *===========================================================================
135:     PROTECTED PROCEDURE ConfigurarPaginaDados()
136:         *-- No-op: toda edicao ocorre diretamente nas celulas de grd_4c_Cotacoes
137:         RETURN
138:     ENDPROC
139: 
140:     *===========================================================================
141:     * AlternarPagina - Compatibilidade com contrato de forms multi-pagina
142:     * Este form OPERACIONAL nao possui PageFrame (dialog modal de uma unica
143:     * vista). O metodo existe para compatibilidade com o pipeline de migracao
144:     * e com forms que herdam/consultam este contrato. Nao ha pagina para
145:     * ativar - a unica pagina eh o proprio form.
146:     *===========================================================================
147:     PROCEDURE AlternarPagina(par_nPagina)
148:         *-- No-op: dialog modal sem pages. par_nPagina eh ignorado.
149:         RETURN
150:     ENDPROC
151: 

*-- Linhas 208 a 314:
208:     ENDPROC
209: 
210:     *===========================================================================
211:     * ConfigurarGrid - Cria grd_4c_Cotacoes com colunas, headers e BINDEVENTs
212:     * Colunas: data(Col1), hora(Col3/Order=2), cotacao(Col2/Order=3)
213:     *===========================================================================
214:     PROTECTED PROCEDURE ConfigurarGrid()
215:         THIS.AddObject("grd_4c_Cotacoes", "Grid")
216:         WITH THIS.grd_4c_Cotacoes
217:             .Top               = 85
218:             .Left              = 133
219:             .Width             = 270
220:             .Height            = 283
221:             .ColumnCount       = 3
222:             .FontName          = "Courier New"
223:             .FontSize          = 8
224:             .RowHeight         = 20
225:             .DeleteMark        = .F.
226:             .RecordMark        = .F.
227:             .ScrollBars        = 2
228:             .ReadOnly          = .F.
229:             .AllowHeaderSizing = .T.
230:             .Visible           = .T.
231: 
232:             *-- Column1: data (datas) - exibida na 1a posicao (ColumnOrder default)
233:             WITH .Column1
234:                 .Width         = 80
235:                 .Movable       = .F.
236:                 .Resizable     = .F.
237:                 .ReadOnly      = .F.
238:                 .SelectOnEntry = .F.
239:                 .Format        = "K"
240:                 .ControlSource = "cursor_4c_Cotacoes.datas"
241:                 .Header1.Caption   = "Data"
242:                 .Header1.Alignment = 2
243:                 .Text1.FontName    = "Courier New"
244:                 .Text1.BorderStyle = 0
245:                 .Text1.Format      = "K"
246:                 .Text1.Margin      = 0
247:                 .Text1.ReadOnly    = .F.
248:                 .Text1.ForeColor   = RGB(0, 0, 0)
249:                 .Text1.BackColor   = RGB(255, 255, 255)
250:             ENDWITH
251: 
252:             *-- Column2: cotacao (valos) - ColumnOrder=3, exibida na 3a posicao
253:             WITH .Column2
254:                 .ColumnOrder   = 3
255:                 .Width         = 101
256:                 .Movable       = .F.
257:                 .Resizable     = .F.
258:                 .ReadOnly      = .F.
259:                 .SelectOnEntry = .F.
260:                 .Format        = "K"
261:                 .InputMask     = "99999.9999999"
262:                 .ControlSource = "cursor_4c_Cotacoes.valos"
263:                 .Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
264:                 .Header1.Alignment = 2
265:                 .Text1.FontName    = "Courier New"
266:                 .Text1.BorderStyle = 0
267:                 .Text1.Format      = "K"
268:                 .Text1.Margin      = 0
269:                 .Text1.ReadOnly    = .F.
270:                 .Text1.ForeColor   = RGB(0, 0, 0)
271:                 .Text1.BackColor   = RGB(255, 255, 255)
272:             ENDWITH
273: 
274:             *-- Column3: hora (horas) - ColumnOrder=2, exibida na 2a posicao
275:             WITH .Column3
276:                 .ColumnOrder   = 2
277:                 .Width         = 55
278:                 .Movable       = .F.
279:                 .Resizable     = .F.
280:                 .ReadOnly      = .F.
281:                 .InputMask     = "99:99"
282:                 .ControlSource = "cursor_4c_Cotacoes.horas"
283:                 .Header1.Caption   = "Hora"
284:                 .Header1.Alignment = 2
285:                 .Text1.FontName    = "Courier New"
286:                 .Text1.BorderStyle = 0
287:                 .Text1.Margin      = 0
288:                 .Text1.ForeColor   = RGB(0, 0, 0)
289:                 .Text1.BackColor   = RGB(255, 255, 255)
290:             ENDWITH
291:         ENDWITH
292: 
293:         *-- BINDEVENT: AfterRowColChange - controle de editabilidade por linha
294:         BINDEVENT(THIS.grd_4c_Cotacoes, "AfterRowColChange", THIS, "GrdAfterRowColChange")
295: 
296:         *-- BINDEVENT: KeyPress nas celulas de data, cotacao e hora para validacao
297:         BINDEVENT(THIS.grd_4c_Cotacoes.Column1.Text1, "KeyPress", THIS, "GrdDataKeyPress")
298:         BINDEVENT(THIS.grd_4c_Cotacoes.Column2.Text1, "KeyPress", THIS, "GrdCotacaoKeyPress")
299:         BINDEVENT(THIS.grd_4c_Cotacoes.Column3.Text1, "KeyPress", THIS, "GrdHoraKeyPress")
300:     ENDPROC
301: 
302:     *===========================================================================
303:     * ConfigurarBotoes - Cria cmd_4c_Inserir, cmd_4c_Excluir, cmd_4c_Encerrar
304:     * com BINDEVENT para os handlers de Click
305:     *===========================================================================
306:     PROTECTED PROCEDURE ConfigurarBotoes()
307:         *-- cmd_4c_Inserir (Left=312, TabIndex=1)
308:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
309:         WITH THIS.cmd_4c_Inserir
310:             .Top             = 3
311:             .Left            = 312
312:             .Width           = 75
313:             .Height          = 75
314:             .FontName        = "Comic Sans MS"

*-- Linhas 385 a 418:
385: 
386:     *===========================================================================
387:     * CarregarCotacoes - Busca cotacoes da moeda e vincula ao grid
388:     *===========================================================================
389:     PROCEDURE CarregarCotacoes()
390:         LOCAL loc_lSucesso
391:         loc_lSucesso = .F.
392:         TRY
393:             IF EMPTY(THIS.this_cMoes)
394:                 MsgAviso("C" + CHR(243) + "digo da moeda n" + CHR(227) + "o informado.", "Aviso")
395:             ELSE
396:                 loc_lSucesso = THIS.this_oBusinessObject.BuscarCotacoes(THIS.this_cMoes)
397:                 IF loc_lSucesso AND USED("cursor_4c_Cotacoes")
398:                     THIS.grd_4c_Cotacoes.ColumnCount = 3
399:                     THIS.grd_4c_Cotacoes.RecordSource = "cursor_4c_Cotacoes"
400:                     SELECT cursor_4c_Cotacoes
401:                     GO BOTTOM
402:                     THIS.this_nIncluir = 0
403:                     THIS.grd_4c_Cotacoes.Refresh()
404:                 ENDIF
405:             ENDIF
406:         CATCH TO loc_oErro
407:             MsgErro(loc_oErro.Message, "Erro ao carregar cota" + CHR(231) + CHR(245) + "es")
408:         ENDTRY
409:         RETURN loc_lSucesso
410:     ENDPROC
411: 
412:     *===========================================================================
413:     * CmdInserirClick - Insere nova cotacao para hoje nesta moeda
414:     * Replica inserir.Click do legado: verifica duplicata de hoje, insere nova
415:     * linha e posiciona grid para edicao do valor (valos)
416:     *===========================================================================
417:     PROCEDURE CmdInserirClick()
418:         LOCAL loc_lJaExiste

*-- Linhas 438 a 458:
438:                         GO BOTTOM
439:                         THIS.this_nIncluir = RECNO()
440:                     ENDIF
441:                     THIS.grd_4c_Cotacoes.Refresh()
442:                     *-- Posicionar foco na coluna Data para usuario digitar imediatamente
443:                     THIS.grd_4c_Cotacoes.SetFocus()
444:                 ENDIF
445:             ENDIF
446:         CATCH TO loc_oErro
447:             MsgErro(loc_oErro.Message, "Erro ao inserir cota" + CHR(231) + CHR(227) + "o")
448:         ENDTRY
449:     ENDPROC
450: 
451:     *===========================================================================
452:     * CmdExcluirClick - Exclui cotacao selecionada no grid
453:     * Replica delete.Click do legado: remove do SQL e recarrega cursor
454:     *===========================================================================
455:     PROCEDURE CmdExcluirClick()
456:         LOCAL loc_cCidChaves, loc_lProsseguir
457:         TRY
458:             loc_cCidChaves  = ""

*-- Linhas 473 a 491:
473:                     THIS.this_nIncluir = 0
474:                     THIS.CarregarCotacoes()
475:                     *-- Reposicionar foco no grid apos exclusao (comportamento do legado)
476:                     THIS.grd_4c_Cotacoes.SetFocus()
477:                 ENDIF
478:             ENDIF
479:         CATCH TO loc_oErro
480:             MsgErro(loc_oErro.Message, "Erro ao excluir cota" + CHR(231) + CHR(227) + "o")
481:         ENDTRY
482:     ENDPROC
483: 
484:     *===========================================================================
485:     * CmdEncerrarClick - Persiste alteracoes no SQL Server e fecha o form
486:     * Replica sair.Click do legado: remove invalidos, atualiza validos, fecha
487:     *===========================================================================
488:     PROCEDURE CmdEncerrarClick()
489:         TRY
490:             THIS.this_oBusinessObject.SalvarCotacoes()
491:         CATCH TO loc_oErro

*-- Linhas 526 a 550:
526:             SELECT cursor_4c_Cotacoes
527:             IF RECNO() != THIS.this_nIncluir OR THIS.this_nIncluir = 0
528:                 THIS.this_nIncluir = 0
529:                 THIS.grd_4c_Cotacoes.Column1.ReadOnly = .T.
530:                 THIS.grd_4c_Cotacoes.Column2.ReadOnly = .T.
531:                 THIS.grd_4c_Cotacoes.Column3.ReadOnly = .T.
532:             ELSE
533:                 THIS.grd_4c_Cotacoes.Column1.ReadOnly = .F.
534:                 THIS.grd_4c_Cotacoes.Column2.ReadOnly = .F.
535:                 THIS.grd_4c_Cotacoes.Column3.ReadOnly = .F.
536:             ENDIF
537:         ENDIF
538:     ENDPROC
539: 
540:     *===========================================================================
541:     * GrdDataKeyPress - Valida que data nao esta vazia ao pressionar ENTER/TAB
542:     * Replica data.Text1.Valid do legado.
543:     *===========================================================================
544:     PROCEDURE GrdDataKeyPress(par_nKeyCode, par_nShiftAltCtrl)
545:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
546:             IF USED("cursor_4c_Cotacoes")
547:                 SELECT cursor_4c_Cotacoes
548:                 IF EMPTY(cursor_4c_Cotacoes.datas)
549:                     MsgAviso("Informe a data da Cota" + CHR(231) + CHR(227) + "o.", "Aviso")
550:                 ENDIF

*-- Linhas 561 a 579:
561:             IF USED("cursor_4c_Cotacoes")
562:                 SELECT cursor_4c_Cotacoes
563:                 GO BOTTOM
564:                 THIS.grd_4c_Cotacoes.Refresh()
565:             ENDIF
566:         ENDIF
567:     ENDPROC
568: 
569:     *===========================================================================
570:     * GrdHoraKeyPress - Verifica cotacao duplicada na data+hora ao pressionar ENTER/TAB
571:     * Replica hora.Text1.Valid do legado: detecta duplicidade e limpa hora.
572:     *===========================================================================
573:     PROCEDURE GrdHoraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
574:         LOCAL loc_cMoes, loc_dData, loc_cHora, loc_lDuplicada
575:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
576:             RETURN
577:         ENDIF
578:         TRY
579:             IF USED("cursor_4c_Cotacoes") AND THIS.this_nIncluir > 0

*-- Linhas 605 a 623:
605:                         IF loc_lDuplicada
606:                             MsgAviso("Cota" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrada !!!", "Aviso")
607:                             REPLACE cursor_4c_Cotacoes.horas WITH "  :  " IN cursor_4c_Cotacoes
608:                             THIS.grd_4c_Cotacoes.Refresh()
609:                         ENDIF
610:                     ENDIF
611:                 ENDIF
612:             ENDIF
613:         CATCH TO loc_oErro
614:             MsgErro(loc_oErro.Message, "Erro ao validar hora")
615:         ENDTRY
616:     ENDPROC
617: 
618:     *===========================================================================
619:     * BtnIncluirClick - Compatibilidade FormBase: delega para CmdInserirClick
620:     * Form OPERACIONAL sem Page2 - insercao ocorre diretamente no grid inline
621:     *===========================================================================
622:     PROCEDURE BtnIncluirClick()
623:         THIS.CmdInserirClick()

*-- Linhas 731 a 753:
731: 
732:     *===========================================================================
733:     * BOParaForm - Compatibilidade FormBase: nao aplicavel neste dialog
734:     * Grid vinculado ao cursor_4c_Cotacoes (RecordSource) - dados ja no grid
735:     * sem necessidade de copia de propriedades BO->TextBoxes
736:     *===========================================================================
737:     PROCEDURE BOParaForm()
738:         *-- No-op: grid usa RecordSource direto no cursor (sem Page2 com TextBoxes)
739:         RETURN
740:     ENDPROC
741: 
742:     *===========================================================================
743:     * Destroy - Libera cursores e encerra o form
744:     *===========================================================================
745:     PROCEDURE Destroy()
746:         IF USED("cursor_4c_Cotacoes")
747:             IF CURSORGETPROP("Buffering", "cursor_4c_Cotacoes") > 1
748:                 TABLEREVERT(.T., "cursor_4c_Cotacoes")
749:             ENDIF
750:             USE IN cursor_4c_Cotacoes
751:         ENDIF
752:         IF USED("cursor_4c_CotacoesTemp")
753:             USE IN cursor_4c_CotacoesTemp

