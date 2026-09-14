# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 188: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg) - TRECHOS RELEVANTES PARA PASS GRID (819 linhas total):

*-- Linhas 51 a 77:
51: 
52:                 *-- Criar cursor de trabalho das divisoes da O.P.
53:                 *-- Estrutura identica ao Temp_DivOp do legado (evento Load)
54:                 SET NULL ON
55:                 CREATE CURSOR cursor_4c_DivOp ;
56:                     (Qtds    N(12,3) NULL, QtdDivs N(12,3) NULL, ;
57:                      Dopes   C(20),        Numes   N(6,0)  NULL, ;
58:                      Dataes  D      NULL,  Obss    M       NULL, ;
59:                      Nops    N(10,0)NULL,  SeqDivs N(3,0)  NULL, ;
60:                      Cpros   C(10),        CodCors C(4),          ;
61:                      CodTams C(4),         cItens  N(10,0) NULL)
62:                 SET NULL OFF
63: 
64:                 *-- Construir controles visuais do form
65:                 THIS.ConfigurarPageFrame()
66:                 THIS.ConfigurarPaginaLista()
67:                 THIS.ConfigurarPaginaDados()
68: 
69:                 *-- Propagar Caption correto para labels do cabecalho
70:                 loc_cCaption = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
71:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = loc_cCaption
72:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = loc_cCaption
73: 
74:                 *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
75:                 THIS.TornarControlesVisiveis(THIS)
76: 
77:                 loc_lSucesso = .T.

*-- Linhas 164 a 287:
164:     *==========================================================================
165:     * ConfigurarPaginaLista - Grid (5 colunas), EditBox e CommandGroup.
166:     * Chamado antes de ConfigurarPaginaDados pois os handlers de txt_4c_OP
167:     * referenciam grd_4c_Dados e cmg_4c_Conf criados aqui.
168:     * Escala: original 702x436 -> novo 1000x600 (ScaleX=1.424, ScaleY=1.376)
169:     *==========================================================================
170:     PROTECTED PROCEDURE ConfigurarPaginaLista()
171:         *-- Grid de divisoes da O.P. com 5 colunas (Pedido, Cor, Tam, Qtd.Atual, Quantidade)
172:         THIS.AddObject("grd_4c_Dados", "Grid")
173:         WITH THIS.grd_4c_Dados
174:             .Top           = 195
175:             .Left          = 71
176:             .Width         = 629
177:             .Height        = 285
178:             .FontName      = "Arial"
179:             .FontSize      = 8
180:             .DeleteMark    = .F.
181:             .RecordMark    = .F.
182:             .GridLines     = 3
183:             .GridLineWidth = 1
184:             .HeaderHeight  = 17
185:             .RowHeight     = 17
186:             .ScrollBars    = 2
187:             .ColumnCount   = 5
188:             .RecordSource  = "cursor_4c_DivOp"
189: 
190:             *-- Column1: Pedido (Dopes + Numes - equivale a fGerMascara(Numes) do legado)
191:             WITH .Column1
192:                 .Width             = 256
193:                 .Alignment         = 0
194:                 .ControlSource     = "ALLTRIM(cursor_4c_DivOp.Dopes) + ' ' + TRANSFORM(cursor_4c_DivOp.Numes)"
195:                 .ReadOnly          = .T.
196:                 .Movable           = .F.
197:                 .Resizable         = .F.
198:                 .FontName          = "Arial"
199:                 .FontSize          = 8
200:                 .ForeColor         = RGB(0, 0, 0)
201:                 .Header1.Caption   = "Pedido"
202:                 .Header1.FontName  = "Arial"
203:                 .Header1.FontSize  = 8
204:                 .Header1.Alignment = 2
205:             ENDWITH
206: 
207:             *-- Column2: Cor (CodCors)
208:             WITH .Column2
209:                 .Width             = 54
210:                 .Alignment         = 0
211:                 .ControlSource     = "cursor_4c_DivOp.CodCors"
212:                 .ReadOnly          = .T.
213:                 .Movable           = .F.
214:                 .Resizable         = .F.
215:                 .FontName          = "Arial"
216:                 .FontSize          = 8
217:                 .Header1.Caption   = "Cor"
218:                 .Header1.FontSize  = 8
219:                 .Header1.Alignment = 2
220:             ENDWITH
221: 
222:             *-- Column3: Tam (CodTams)
223:             WITH .Column3
224:                 .Width             = 54
225:                 .Alignment         = 0
226:                 .ControlSource     = "cursor_4c_DivOp.CodTams"
227:                 .ReadOnly          = .T.
228:                 .Movable           = .F.
229:                 .Resizable         = .F.
230:                 .FontName          = "Arial"
231:                 .FontSize          = 8
232:                 .Header1.Caption   = "Tam"
233:                 .Header1.FontSize  = 8
234:                 .Header1.Alignment = 2
235:             ENDWITH
236: 
237:             *-- Column4: Qtd.Atual (Qtds - quantidade original, readonly)
238:             WITH .Column4
239:                 .Width             = 114
240:                 .Alignment         = 1
241:                 .ControlSource     = "cursor_4c_DivOp.Qtds"
242:                 .ReadOnly          = .T.
243:                 .Movable           = .F.
244:                 .Resizable         = .F.
245:                 .FontName          = "Arial"
246:                 .FontSize          = 8
247:                 .InputMask         = "999,999.999"
248:                 .Header1.Caption   = "Qtd.Atual"
249:                 .Header1.FontName  = "Arial"
250:                 .Header1.FontSize  = 8
251:                 .Header1.Alignment = 2
252:             ENDWITH
253: 
254:             *-- Column5: Quantidade nova (QtdDivs - editavel pelo usuario, Format=K limpa zeros)
255:             WITH .Column5
256:                 .Width             = 114
257:                 .Alignment         = 1
258:                 .ControlSource     = "cursor_4c_DivOp.QtdDivs"
259:                 .ReadOnly          = .F.
260:                 .Format            = "K"
261:                 .Movable           = .F.
262:                 .Resizable         = .F.
263:                 .FontName          = "Arial"
264:                 .FontSize          = 8
265:                 .Header1.Caption   = "Quantidade"
266:                 .Header1.FontName  = "Arial"
267:                 .Header1.FontSize  = 8
268:                 .Header1.Alignment = 2
269:             ENDWITH
270:         ENDWITH
271:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
272:         THIS.FormatarGridLista(THIS.grd_4c_Dados)
273: 
274:         *-- EditBox de observacoes da divisao selecionada (readonly, vinculada ao cursor)
275:         THIS.AddObject("edt_4c_Obss", "EditBox")
276:         WITH THIS.edt_4c_Obss
277:             .Top               = 490
278:             .Left              = 68
279:             .Width             = 632
280:             .Height            = 96
281:             .ReadOnly          = .T.
282:             .FontName          = "Tahoma"
283:             .FontSize          = 8
284:             .ControlSource     = "cursor_4c_DivOp.Obss"
285:             .DisabledBackColor = RGB(255, 255, 255)
286:         ENDWITH
287: 

*-- Linhas 380 a 399:
380:             THIS.cmg_4c_Conf.Buttons(1).Enabled = .F.
381:         ENDIF
382: 
383:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
384:             THIS.grd_4c_Dados.Refresh
385:         ENDIF
386: 
387:         IF VARTYPE(THIS.edt_4c_Obss) = "O"
388:             THIS.edt_4c_Obss.Refresh
389:         ENDIF
390: 
391:         IF VARTYPE(THIS.txt_4c_OP) = "O"
392:             THIS.txt_4c_OP.SetFocus
393:         ENDIF
394:     ENDPROC
395: 
396:     *==========================================================================
397:     * TxtOPGotFocus - Desabilita Confirmar ao entrar no campo O.P.
398:     * Equivalente ao Get_OP.When do legado: impede confirmar com OP anterior
399:     *==========================================================================

*-- Linhas 420 a 461:
420:                 ZAP
421:             ENDIF
422:             THIS.txt_4c_Produto.Value = ""
423:             THIS.grd_4c_Dados.Refresh
424:             RETURN
425:         ENDIF
426: 
427:         loc_nNops = VAL(ALLTRIM(THIS.txt_4c_OP.Value))
428:         IF loc_nNops = 0
429:             RETURN
430:         ENDIF
431: 
432:         IF THIS.this_oBusinessObject.CarregarOP(loc_nNops)
433:             THIS.txt_4c_Produto.Value               = THIS.this_oBusinessObject.this_cCodPds
434:             THIS.cmg_4c_Conf.Buttons(1).Enabled     = .T.
435: 
436:             IF USED("cursor_4c_DivOp") AND !EOF("cursor_4c_DivOp")
437:                 *-- Foca Column5 (Quantidade editavel) equivalente ao Grade.Column2.Text1.SetFocus do legado
438:                 THIS.grd_4c_Dados.ActiveColumn = 5
439:                 THIS.grd_4c_Dados.SetFocus
440:             ENDIF
441:         ELSE
442:             THIS.txt_4c_OP.Value      = ""
443:             THIS.txt_4c_Produto.Value = ""
444:         ENDIF
445: 
446:         THIS.grd_4c_Dados.Refresh
447:     ENDPROC
448: 
449:     *==========================================================================
450:     * GrdDadosAfterRowColChange - Atualiza EditBox de Observacoes ao navegar
451:     * Equivalente ao Grade.AfterRowColChange do legado
452:     *==========================================================================
453:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
454:         IF VARTYPE(THIS.edt_4c_Obss) = "O"
455:             THIS.edt_4c_Obss.Refresh
456:         ENDIF
457:     ENDPROC
458: 
459:     *==========================================================================
460:     * BtnConfirmarClick - Grava quantidades alteradas no servidor SQL
461:     * Equivalente ao Grupo_Conf.Salva.Click do legado

*-- Linhas 529 a 547:
529:         IF THIS.this_oBusinessObject.CarregarOP(loc_nNops)
530:             THIS.txt_4c_Produto.Value           = THIS.this_oBusinessObject.this_cCodPds
531:             THIS.cmg_4c_Conf.Buttons(1).Enabled = .T.
532:             THIS.grd_4c_Dados.Refresh
533:             THIS.edt_4c_Obss.Refresh
534:         ELSE
535:             THIS.txt_4c_Produto.Value = ""
536:         ENDIF
537:     ENDPROC
538: 
539:     *==========================================================================
540:     * BtnExcluirClick - Descarta alteracoes locais recarregando dados do servidor.
541:     * Form operacional: "Excluir" = cancelar mudancas no grid antes de confirmar.
542:     * Se nao houver O.P. carregada, apenas reseta o formulario.
543:     *==========================================================================
544:     PROCEDURE BtnExcluirClick()
545:         LOCAL loc_nNops, loc_lConfirma
546: 
547:         IF EMPTY(ALLTRIM(THIS.txt_4c_OP.Value))

*-- Linhas 561 a 588:
561:         ENDIF
562: 
563:         IF THIS.this_oBusinessObject.CarregarOP(loc_nNops)
564:             THIS.grd_4c_Dados.Refresh
565:             THIS.edt_4c_Obss.Refresh
566:         ENDIF
567:     ENDPROC
568: 
569:     *==========================================================================
570:     * ConfigurarPaginaDados - Controles de entrada de dados:
571:     * Labels identificadores e TextBoxes para O.P. e Produto.
572:     * Chamado apos ConfigurarPaginaLista pois os handlers de BINDEVENT
573:     * referenciam grd_4c_Dados (criado naquele metodo).
574:     *==========================================================================
575:     PROTECTED PROCEDURE ConfigurarPaginaDados()
576:         *-- Label "O.P.:"
577:         THIS.AddObject("lbl_4c_Label1", "Label")
578:         WITH THIS.lbl_4c_Label1
579:             .Top       = 128
580:             .Left      = 100
581:             .Width     = 44
582:             .Height    = 18
583:             .Caption   = "O.P. :"
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .BackStyle = 0
587:             .ForeColor = RGB(90, 90, 90)
588:         ENDWITH

*-- Linhas 709 a 728:
709: 
710:         THIS.AjustarBotoesPorModo()
711: 
712:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
713:             THIS.grd_4c_Dados.Refresh
714:         ENDIF
715: 
716:         IF VARTYPE(THIS.edt_4c_Obss) = "O"
717:             THIS.edt_4c_Obss.Refresh
718:         ENDIF
719: 
720:         IF VARTYPE(THIS.txt_4c_OP) = "O"
721:             THIS.txt_4c_OP.SetFocus
722:         ENDIF
723:     ENDPROC
724: 
725:     *==========================================================================
726:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme O.P. carregada
727:     *==========================================================================
728:     PROCEDURE AjustarBotoesPorModo()

*-- Linhas 760 a 787:
760:             THIS.txt_4c_Produto.Value           = THIS.this_oBusinessObject.this_cCodPds
761:             THIS.cmg_4c_Conf.Buttons(1).Enabled = .T.
762:             IF !EOF("cursor_4c_DivOp")
763:                 THIS.grd_4c_Dados.ActiveColumn = 5
764:                 THIS.grd_4c_Dados.SetFocus
765:             ENDIF
766:         ELSE
767:             THIS.txt_4c_OP.Value      = ""
768:             THIS.txt_4c_Produto.Value = ""
769:             THIS.cmg_4c_Conf.Buttons(1).Enabled = .F.
770:         ENDIF
771: 
772:         THIS.grd_4c_Dados.Refresh
773:     ENDPROC
774: 
775:     *==========================================================================
776:     * BtnSalvarClick - Alias de BtnConfirmarClick para compatibilidade FormBase
777:     *==========================================================================
778:     PROCEDURE BtnSalvarClick()
779:         THIS.BtnConfirmarClick()
780:     ENDPROC
781: 
782:     *==========================================================================
783:     * BtnCancelarClick - Cancela operacao corrente e reseta o form
784:     *==========================================================================
785:     PROCEDURE BtnCancelarClick()
786:         THIS.LimparCampos()
787:     ENDPROC

