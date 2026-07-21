# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1376 linhas total):

*-- Linhas 38 a 275:
38:     this_cArqDBFPath = ""
39: 
40:     *==========================================================================
41:     PROCEDURE Init()
42:     *==========================================================================
43:         RETURN DODEFAULT()
44:     ENDPROC
45: 
46:     *==========================================================================
47:     PROTECTED PROCEDURE ConfigurarPageFrame()
48:     *==========================================================================
49:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
50:         THIS.ScrollBars = 0
51:         THIS.ShowTips   = .T.
52:     ENDPROC
53: 
54:     *==========================================================================
55:     PROTECTED PROCEDURE InicializarForm()
56:     *==========================================================================
57:         LOCAL loc_lSucesso, loc_oErro, loc_cArquivo
58:         loc_lSucesso = .F.
59: 
60:         TRY
61:             THIS.ConfigurarPageFrame()
62: 
63:             *-- Verificar existencia do ArqDBF (tabela VFP de catalogo de campos)
64:             loc_cArquivo = SYS(5) + SYS(2003) + "\ArqDBF"
65:             IF !FILE(loc_cArquivo + ".dbf")
66:                 MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + " no diret" + CHR(243) + "rio do Sistema!!!", ;
67:                     "Aten" + CHR(231) + CHR(227) + "o")
68:             ELSE
69:                 THIS.this_cArqDBFPath = loc_cArquivo
70: 
71:                 THIS.this_oBusinessObject = CREATEOBJECT("sigprmdpBO")
72:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
73:                     MsgErro("Erro ao criar sigprmdpBO.", "Erro InicializarForm")
74:                 ELSE
75:                     *-- Buscar configuracao de calculo de custos (SigCdPaC)
76:                     THIS.this_oBusinessObject.BuscarCalcCustos()
77:                     THIS.this_lCalculaCusto = THIS.this_oBusinessObject.this_lCalculaCusto
78: 
79:                     *-- Inicializar cursor csContas (pares de substituicao)
80:                     IF !THIS.this_oBusinessObject.InicializarCursorContas()
81:                         MsgErro("Falha ao inicializar cursor de substitui" + CHR(231) + CHR(245) + "es.", ;
82:                             "Erro InicializarForm")
83:                     ELSE
84:                         THIS.ConfigurarCabecalho()
85:                         THIS.ConfigurarPaginaLista()
86: 
87:                         *-- cnt_4c_Result fica oculto ate o processamento (painel de progresso)
88:                         THIS.TornarControlesVisiveis(THIS)
89: 
90:                         loc_lSucesso = .T.
91:                     ENDIF
92:                 ENDIF
93:             ENDIF
94:         CATCH TO loc_oErro
95:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
96:                 " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprmdp")
97:         ENDTRY
98: 
99:         RETURN loc_lSucesso
100:     ENDPROC
101: 
102:     *==========================================================================
103:     PROTECTED PROCEDURE ConfigurarCabecalho()
104:     *==========================================================================
105:         LOCAL loc_oErro
106: 
107:         TRY
108:             *-- Container do cabecalho (cntSombra do legado)
109:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
110:             WITH THIS.cnt_4c_Cabecalho
111:                 .Top         = 0
112:                 .Left        = 0
113:                 .Width       = THIS.Width
114:                 .Height      = 80
115:                 .BackStyle   = 1
116:                 .BackColor   = RGB(100, 100, 100)
117:                 .BorderWidth = 0
118:                 .Visible     = .T.
119:             ENDWITH
120: 
121:             *-- Label sombra ? efeito de sombra no titulo (lblSombra do legado)
122:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
123:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
124:                 .AutoSize   = .F.
125:                 .FontBold   = .T.
126:                 .FontName   = "Tahoma"
127:                 .FontSize   = 18
128:                 .WordWrap   = .T.
129:                 .Alignment  = 0
130:                 .BackStyle  = 0
131:                 .Caption    = THIS.Caption
132:                 .Height     = 40
133:                 .Left       = 10
134:                 .Top        = 18
135:                 .Width      = THIS.cnt_4c_Cabecalho.Width
136:                 .ForeColor  = RGB(0, 0, 0)
137:             ENDWITH
138: 
139:             *-- Label titulo ? texto visivel sobre a sombra (lblTitulo do legado)
140:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
141:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
142:                 .AutoSize    = .F.
143:                 .FontBold    = .T.
144:                 .FontName    = "Tahoma"
145:                 .FontSize    = 18
146:                 .WordWrap    = .T.
147:                 .Alignment   = 0
148:                 .BackStyle   = 0
149:                 .Caption     = THIS.Caption
150:                 .Height      = 46
151:                 .Left        = 10
152:                 .Top         = 17
153:                 .Width       = THIS.cnt_4c_Cabecalho.Width
154:                 .ForeColor   = RGB(255, 255, 255)
155:                 .ToolTipText = "T" + CHR(237) + "tulo"
156:             ENDWITH
157: 
158:         CATCH TO loc_oErro
159:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
160:                 "Erro ConfigurarCabecalho Formsigprmdp")
161:         ENDTRY
162:     ENDPROC
163: 
164:     *==========================================================================
165:     * TornarControlesVisiveis
166:     * cnt_4c_Result comeca oculto ? recursa filhos mas nao seta Visible do container
167:     *==========================================================================
168:     PROCEDURE TornarControlesVisiveis(par_oContainer)
169:         LOCAL loc_i, loc_oControl
170: 
171:         FOR loc_i = 1 TO par_oContainer.ControlCount
172:             loc_oControl = par_oContainer.Controls(loc_i)
173: 
174:             IF VARTYPE(loc_oControl) != "O"
175:                 LOOP
176:             ENDIF
177: 
178:             IF UPPER(loc_oControl.Name) = "CNT_4C_RESULT"
179:                 IF PEMSTATUS(loc_oControl, "Controls", 5)
180:                     THIS.TornarControlesVisiveis(loc_oControl)
181:                 ENDIF
182:                 LOOP
183:             ENDIF
184: 
185:             IF PEMSTATUS(loc_oControl, "Visible", 5)
186:                 loc_oControl.Visible = .T.
187:             ENDIF
188: 
189:             IF PEMSTATUS(loc_oControl, "Controls", 5)
190:                 THIS.TornarControlesVisiveis(loc_oControl)
191:             ENDIF
192:         ENDFOR
193:     ENDPROC
194: 
195:     *==========================================================================
196:     PROCEDURE Destroy()
197:     *==========================================================================
198:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
199:             THIS.this_oBusinessObject = .NULL.
200:         ENDIF
201:         IF USED("csContas")
202:             USE IN csContas
203:         ENDIF
204:         DODEFAULT()
205:     ENDPROC
206: 
207:     *==========================================================================
208:     PROTECTED PROCEDURE ConfigurarPaginaLista()
209:     *==========================================================================
210:         LOCAL loc_oErro
211:         TRY
212:             THIS.ConfigurarBotoes()
213:             THIS.ConfigurarGrade()
214:             THIS.ConfigurarPaginaDados()
215:         CATCH TO loc_oErro
216:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
217:                 "Erro ConfigurarPaginaLista Formsigprmdp")
218:         ENDTRY
219:     ENDPROC
220: 
221:     *==========================================================================
222:     * ConfigurarPaginaDados
223:     * Form OPERACIONAL de layout flat (800x270, sem PageFrame): nao existe Page2.
224:     * Todos os campos de exibicao (cnt_4c_Result com txt_4c_Cpros, txt_4c_Arquivo,
225:     * cnt_4c_Barra com shp_4c_ShpBarra e lbl_4c_LblPorcento, alem dos labels
226:     * "Produto :", "Arquivo/Campo :" e "Progresso :") sao criados em
227:     * ConfigurarPainelResultado, delegada aqui para satisfazer o contrato da
228:     * pipeline multi-fase.
229:     *==========================================================================
230:     PROTECTED PROCEDURE ConfigurarPaginaDados()
231:         THIS.ConfigurarPainelResultado()
232:     ENDPROC
233: 
234:     *==========================================================================
235:     PROTECTED PROCEDURE ConfigurarBotoes()
236:     *==========================================================================
237:         LOCAL loc_oErro
238:         TRY
239:             *-- Shape decorativo de fundo (Shape1 do legado): Top=7,Left=502,W=90,H=110
240:             THIS.AddObject("shp_4c_Shape1", "Shape")
241:             WITH THIS.shp_4c_Shape1
242:                 .Top         = 7
243:                 .Left        = 502
244:                 .Height      = 110
245:                 .Width       = 90
246:                 .BackStyle   = 0
247:                 .BorderStyle = 0
248:                 .BorderColor = RGB(136, 189, 188)
249:                 .Visible     = .T.
250:             ENDWITH
251: 
252:             THIS.AddObject("cmd_4c_BtnIncluir", "CommandButton")
253:             WITH THIS.cmd_4c_BtnIncluir
254:                 .Top        = 3
255:                 .Left       = 425
256:                 .Height     = 75
257:                 .Width      = 75
258:                 .FontBold   = .T.
259:                 .FontItalic = .T.
260:                 .FontName   = "Comic Sans MS"
261:                 .FontSize   = 8
262:                 .ForeColor  = RGB(90, 90, 90)
263:                 .BackColor  = RGB(255, 255, 255)
264:                 .Themes           = .T.
265:                 .Caption    = "\<Incluir"
266:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
267:                 .TabIndex   = 1
268:                 .Visible    = .T.
269:             ENDWITH
270: 
271:             THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
272:             WITH THIS.cmd_4c_BtnExcluir
273:                 .Top        = 3
274:                 .Left       = 500
275:                 .Height     = 75

*-- Linhas 346 a 402:
346:                 .Visible    = .T.
347:             ENDWITH
348: 
349:             BINDEVENT(THIS.cmd_4c_BtnIncluir,   "Click", THIS, "BtnIncluirClick")
350:             BINDEVENT(THIS.cmd_4c_BtnExcluir,   "Click", THIS, "BtnExcluirClick")
351:             BINDEVENT(THIS.cmd_4c_Exporta,      "Click", THIS, "BtnExportaClick")
352:             BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "BtnProcessarClick")
353:             BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "BtnSairClick")
354: 
355:         CATCH TO loc_oErro
356:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
357:                 "Erro ConfigurarBotoes Formsigprmdp")
358:         ENDTRY
359:     ENDPROC
360: 
361:     *==========================================================================
362:     PROTECTED PROCEDURE ConfigurarGrade()
363:     *==========================================================================
364:         LOCAL loc_oErro, loc_oGrd
365:         TRY
366:             THIS.AddObject("grd_4c_Dados", "Grid")
367:             loc_oGrd = THIS.grd_4c_Dados
368:             WITH loc_oGrd
369:                 .Top               = 101
370:                 .Left              = 147
371:                 .Width             = 269
372:                 .Height            = 148
373:                 .ColumnCount       = 2
374:                 .AllowHeaderSizing = .F.
375:                 .AllowRowSizing    = .F.
376:                 .DeleteMark        = .F.
377:                 .RecordMark        = .F.
378:                 .HeaderHeight      = 18
379:                 .RowHeight         = 18
380:                 .ScrollBars        = 2
381:                 .FontName          = "Verdana"
382:                 .FontSize          = 8
383:                 .ForeColor         = RGB(90, 90, 90)
384:                 .BackColor         = RGB(255, 255, 255)
385:                 .GridLineColor     = RGB(238, 238, 238)
386:                 .HighlightStyle    = 2
387:                 .TabIndex          = 5
388:                 .RecordSource      = "csContas"
389:                 WITH .Column1
390:                     .Width         = 118
391:                     .ControlSource = "csContas.CprosAnt"
392:                     WITH .Header1
393:                         .FontName  = "Tahoma"
394:                         .FontSize  = 8
395:                         .Alignment = 2
396:                         .Caption   = "C" + CHR(243) + "digo Original"
397:                     ENDWITH
398:                     WITH .Text1
399:                         .BorderStyle = 0
400:                         .Margin      = 0
401:                         .ForeColor   = RGB(0, 0, 0)
402:                         .BackColor   = RGB(255, 255, 255)

*-- Linhas 421 a 473:
421:                 .Visible = .T.
422:             ENDWITH
423: 
424:             BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtCprosAntKeyPress")
425: 
426:         CATCH TO loc_oErro
427:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
428:                 "Erro ConfigurarGrade Formsigprmdp")
429:         ENDTRY
430:     ENDPROC
431: 
432:     *==========================================================================
433:     PROTECTED PROCEDURE ConfigurarPainelResultado()
434:     *==========================================================================
435:         LOCAL loc_oErro
436:         TRY
437:             THIS.AddObject("cnt_4c_Result", "Container")
438:             WITH THIS.cnt_4c_Result
439:                 .Top           = 101
440:                 .Left          = 440
441:                 .Width         = 213
442:                 .Height        = 146
443:                 .BackStyle     = 0
444:                 .BorderWidth   = 0
445:                 .SpecialEffect = 0
446:                 .TabIndex      = 6
447:                 .Visible     = .T.
448:             ENDWITH
449: 
450:             THIS.cnt_4c_Result.AddObject("lbl_4c_Label2", "Label")
451:             WITH THIS.cnt_4c_Result.lbl_4c_Label2
452:                 .Caption   = "Produto : "
453:                 .Left      = 8
454:                 .Top       = 2
455:                 .FontName  = "Tahoma"
456:                 .FontSize  = 8
457:                 .BackStyle = 0
458:                 .AutoSize  = .T.
459:             ENDWITH
460: 
461:             THIS.cnt_4c_Result.AddObject("txt_4c_Cpros", "TextBox")
462:             WITH THIS.cnt_4c_Result.txt_4c_Cpros
463:                 .Top               = 19
464:                 .Left              = 5
465:                 .Width             = 108
466:                 .Height            = 24
467:                 .FontName          = "Tahoma"
468:                 .FontSize          = 8
469:                 .Alignment         = 3
470:                 .Enabled           = .F.
471:                 .Format            = "K!"
472:                 .ReadOnly          = .T.
473:                 .SpecialEffect     = 1

*-- Linhas 564 a 778:
564:     * AlternarPagina - Mostra/oculta painel de progresso (cntResult do legado)
565:     * par_lMostrar: .T. = mostrar, .F. = ocultar
566:     *==========================================================================
567:     PROCEDURE AlternarPagina(par_lMostrar)
568:         IF PEMSTATUS(THIS, "cnt_4c_Result", 5)
569:             THIS.cnt_4c_Result.Visible = par_lMostrar
570:             IF par_lMostrar
571:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
572:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
573:                 THIS.cnt_4c_Result.txt_4c_Cpros.Value   = ""
574:                 THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
575:             ENDIF
576:         ENDIF
577:     ENDPROC
578: 
579:     *==========================================================================
580:     * BtnSairClick - Encerra o form
581:     *==========================================================================
582:     PROCEDURE BtnSairClick()
583:         THIS.Release
584:     ENDPROC
585: 
586:     *==========================================================================
587:     * BtnIncluirClick - Adiciona linha em branco ao csContas se linha atual estiver completa
588:     *==========================================================================
589:     PROCEDURE BtnIncluirClick()
590:         LOCAL loc_lOK
591:         loc_lOK = .F.
592: 
593:         IF USED("csContas")
594:             SELECT csContas
595:             IF !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) AND ;
596:                !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
597:                 APPEND BLANK
598:                 loc_lOK = .T.
599:             ENDIF
600:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
601:                 THIS.grd_4c_Dados.Refresh
602:                 IF loc_lOK
603:                     THIS.grd_4c_Dados.Column1.SetFocus
604:                 ENDIF
605:             ENDIF
606:         ENDIF
607:     ENDPROC
608: 
609:     *==========================================================================
610:     * BtnExcluirClick - Remove linha selecionada do csContas
611:     *==========================================================================
612:     PROCEDURE BtnExcluirClick()
613:         IF USED("csContas")
614:             SELECT csContas
615:             IF !EOF()
616:                 DELETE
617:             ENDIF
618:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
619:                 THIS.grd_4c_Dados.Refresh
620:                 THIS.grd_4c_Dados.Column1.SetFocus
621:             ENDIF
622:         ENDIF
623:     ENDPROC
624: 
625:     *==========================================================================
626:     * BtnAlterarClick - Coloca a linha corrente do grid em edicao
627:     * Form OPERACIONAL: nao possui botao Alterar visivel; disponivel para
628:     * scripting/atalho externo que precise reposicionar o cursor no par corrente
629:     * para edicao inline no grid csContas.
630:     *==========================================================================
631:     PROCEDURE BtnAlterarClick()
632:         IF !USED("csContas")
633:             RETURN
634:         ENDIF
635: 
636:         SELECT csContas
637:         IF RECCOUNT() = 0
638:             APPEND BLANK
639:         ELSE
640:             IF EOF()
641:                 GO BOTTOM
642:             ENDIF
643:         ENDIF
644: 
645:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
646:             THIS.grd_4c_Dados.Refresh
647:             THIS.grd_4c_Dados.SetFocus
648:             THIS.grd_4c_Dados.Column1.SetFocus
649:             IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "Text1", 5)
650:                 THIS.grd_4c_Dados.Column1.Text1.SelStart  = 0
651:                 THIS.grd_4c_Dados.Column1.Text1.SelLength = ;
652:                     LEN(ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, "")))
653:             ENDIF
654:         ENDIF
655:     ENDPROC
656: 
657:     *==========================================================================
658:     * BtnVisualizarClick - Reposiciona no topo do csContas e atualiza o grid
659:     * Form OPERACIONAL: nao possui botao Visualizar visivel; disponivel para
660:     * scripting/atalho externo que precise mostrar todos os pares carregados
661:     * (pos-importacao XLS) antes de processar.
662:     *==========================================================================
663:     PROCEDURE BtnVisualizarClick()
664:         IF !USED("csContas")
665:             RETURN
666:         ENDIF
667: 
668:         SELECT csContas
669:         SET ORDER TO
670:         GO TOP
671: 
672:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
673:             THIS.grd_4c_Dados.Refresh
674:             THIS.grd_4c_Dados.SetFocus
675:         ENDIF
676:     ENDPROC
677: 
678:     *==========================================================================
679:     * BtnExportaClick - Importa pares de substituicao de planilha XLS para csContas
680:     *==========================================================================
681:     PROCEDURE BtnExportaClick()
682:         LOCAL loc_cArquivo, loc_nImportados, loc_oErro
683:         loc_cArquivo   = ""
684:         loc_nImportados = 0
685: 
686:         TRY
687:             loc_cArquivo = GETFILE("XLS")
688: 
689:             IF EMPTY(loc_cArquivo)
690:                 MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
691:                     "o informado!!!", "Aviso")
692:             ELSE
693:                 IF !FILE(loc_cArquivo)
694:                 MsgErro("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArquivo, "Erro")
695:             ELSE
696:                 loc_nImportados = THIS.this_oBusinessObject.ImportarXLS( ;
697:                     loc_cArquivo, THIS.this_lCheckCadPro)
698: 
699:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
700:                     THIS.grd_4c_Dados.Refresh
701:                 ENDIF
702: 
703:                 IF loc_nImportados > 0
704:                     MsgInfo(TRANSFORM(loc_nImportados) + " par(es) importado(s) com sucesso.", ;
705:                         "Importa" + CHR(231) + CHR(227) + "o")
706:                 ELSE
707:                     MsgAviso("Nenhum par v" + CHR(225) + "lido encontrado na planilha.", ;
708:                         "Importa" + CHR(231) + CHR(227) + "o")
709:                 ENDIF
710:                 ENDIF
711:             ENDIF
712: 
713:         CATCH TO loc_oErro
714:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
715:                 "Erro BtnExportaClick Formsigprmdp")
716:         ENDTRY
717:     ENDPROC
718: 
719:     *==========================================================================
720:     * BtnProcessarClick - Processa substituicao de referencias em todos os arquivos
721:     * Logica baseada em btnProcessar.Click do legado SIGPRMDP
722:     * fRecalculaP/fRecalculaC nao portadas - operacoes de recalculo de saldo omitidas
723:     *==========================================================================
724:     PROCEDURE BtnProcessarClick()
725:         LOCAL loc_cMensagem, loc_oErro
726:         LOCAL loc_nErro, loc_nRec, loc_nCnt, loc_nTtArq, loc_nPct
727:         LOCAL loc_cArq, loc_cCpo, loc_cSql, loc_cChave, loc_cKeyPry, loc_cType
728: 
729:         *-- Validacoes fora do TRY (funcoes tem TRY proprio)
730:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
731:             MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
732:             RETURN
733:         ENDIF
734: 
735:         loc_cMensagem = THIS.this_oBusinessObject.ValidarParesNoGrid( ;
736:             THIS.this_lCheckCadPro, THIS.this_lManterBarra)
737:         IF !EMPTY(loc_cMensagem)
738:             MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o!!!")
739:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
740:                 THIS.grd_4c_Dados.Column1.SetFocus
741:             ENDIF
742:             RETURN
743:         ENDIF
744: 
745:         IF !MsgConfirma("Confirma a Troca das Refer" + CHR(234) + "ncias ?", ;
746:                 "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
747:             RETURN
748:         ENDIF
749: 
750:         IF EMPTY(THIS.this_cArqDBFPath) OR !FILE(THIS.this_cArqDBFPath + ".dbf")
751:             MsgErro("ArqDBF n" + CHR(227) + "o localizado para processamento.", ;
752:                 "Erro de Configura" + CHR(231) + CHR(227) + "o")
753:             RETURN
754:         ENDIF
755: 
756:         loc_nErro = 1
757: 
758:         TRY
759:             IF !USED("ArqDBF")
760:                 USE (THIS.this_cArqDBFPath) IN 0 ALIAS ArqDBF
761:             ENDIF
762: 
763:             *-- Selecionar campos elegiveis: tipo C, tamanho 10 ou 14, nomes especificos de produto
764:             SELECT Arquivos, Campos ;
765:                 FROM ArqDBF ;
766:                 WHERE (Tamanhos = 10 OR Tamanhos = 14) AND ;
767:                     UPPER(Tipos) = "C" AND ;
768:                     ALLTRIM(Arquivos) <> "ARQDBF.DBF" AND ;
769:                     ALLTRIM(Arquivos) <> "SIGTEMPD.DBF" AND ;
770:                     ALLTRIM(Arquivos) <> "SIGTEMPC.DBF" AND ;
771:                     ALLTRIM(Arquivos) <> "SIGTEMPR.DBF" AND ;
772:                     !EMPTY(Dbcs) AND ;
773:                     INLIST(ALLTRIM(Campos), "CMATS","CODCONPADS","CODPDS","CODPROPADS", ;
774:                         "CPROS","PRODUTO","PRODUTOS","CPROEQS","MATPRINCS", ;
775:                         "MATS","MATSUBS","CODGARRAS","OUROS","BRILHANTES") ;
776:                 ORDER BY Arquivos ;
777:                 INTO CURSOR csCampos READWRITE
778:             INDEX ON Arquivos + Campos TAG ArqCpo

*-- Linhas 1065 a 1148:
1065:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1066:                     THIS.grd_4c_Dados.Refresh
1067:                 ENDIF
1068:                 MsgAviso("Existem Produtos que n" + CHR(227) + "o Foram Alterados!!!", ;
1069:                     "Reprocessar!!!")
1070:             ELSE
1071:                 SELECT csContas
1072:                 SET ORDER TO
1073:                 ZAP
1074:                 APPEND BLANK
1075:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1076:                     THIS.grd_4c_Dados.Refresh
1077:                 ENDIF
1078:                 MsgAviso("Todos Os Produtos Foram Alterados!!!", ;
1079:                     "Processamento Encerrado!!!")
1080:             ENDIF
1081: 
1082:         CATCH TO loc_oErro
1083:             SQLEXEC(gnConnHandle, "ROLLBACK")
1084:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1085:                 "Erro BtnProcessarClick Formsigprmdp")
1086:         ENDTRY
1087: 
1088:         THIS.AlternarPagina(.F.)
1089: 
1090:         IF USED("csCampos")
1091:             USE IN csCampos
1092:         ENDIF
1093:         IF USED("csArquivos")
1094:             USE IN csArquivos
1095:         ENDIF
1096:         IF USED("cursor_4c_ChavePrim")
1097:             USE IN cursor_4c_ChavePrim
1098:         ENDIF
1099:         IF USED("ArqDBF")
1100:             USE IN ArqDBF
1101:         ENDIF
1102:     ENDPROC
1103: 
1104:     *==========================================================================
1105:     * TxtCprosAntKeyPress - Lookup de produto no campo Codigo Original (Column1)
1106:     * Disparado por BINDEVENT em grd_4c_Dados.Column1.Text1
1107:     *==========================================================================
1108:     PROCEDURE TxtCprosAntKeyPress
1109:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1110: 
1111:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
1112:             RETURN
1113:         ENDIF
1114: 
1115:         IF THIS.this_lCheckCadPro
1116:             RETURN
1117:         ENDIF
1118: 
1119:         LOCAL loc_cVal, loc_oErro, loc_nErro
1120:         loc_cVal  = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))
1121:         loc_nErro = 0
1122: 
1123:         TRY
1124:             IF EMPTY(loc_cVal)
1125:                 SELECT csContas
1126:                 REPLACE CprosAnt WITH ""
1127:             ELSE
1128:                 IF USED("cursor_4c_TmpPro")
1129:                     USE IN cursor_4c_TmpPro
1130:                 ENDIF
1131:                 loc_nErro = SQLEXEC(gnConnHandle, ;
1132:                     "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cVal), ;
1133:                     "cursor_4c_TmpPro")
1134: 
1135:                 IF loc_nErro > 0 AND USED("cursor_4c_TmpPro") AND ;
1136:                    RECCOUNT("cursor_4c_TmpPro") > 0
1137:                     SELECT cursor_4c_TmpPro
1138:                     loc_cVal = ALLTRIM(NVL(cursor_4c_TmpPro.Cpros, ""))
1139:                     USE IN cursor_4c_TmpPro
1140:                     SELECT csContas
1141:                     REPLACE CprosAnt WITH loc_cVal
1142:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
1143:                 ELSE
1144:                     IF USED("cursor_4c_TmpPro")
1145:                         USE IN cursor_4c_TmpPro
1146:                     ENDIF
1147:                     THIS.AbrirBuscaProduto()
1148:                 ENDIF

*-- Linhas 1157 a 1376:
1157:     ENDPROC
1158: 
1159:     *==========================================================================
1160:     * AbrirBuscaProduto - Abre FormBuscaAuxiliar para selecao de produto (SigCdPro)
1161:     *==========================================================================
1162:     PROCEDURE AbrirBuscaProduto()
1163:         LOCAL loc_oLookup, loc_cVal, loc_oErro
1164:         loc_cVal = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))
1165: 
1166:         TRY
1167:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
1168:                 "cursor_4c_BuscaPro", "CPros", loc_cVal, ;
1169:                 "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
1170:             IF VARTYPE(loc_oLookup) <> "O"
1171:                 MsgErro("Erro ao abrir busca de produto.", "Erro")
1172:             ELSE
1173:                 loc_oLookup.mAddColuna("CPros", "XXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
1174:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1175:                 loc_oLookup.Show()
1176:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaPro")
1177:                     SELECT cursor_4c_BuscaPro
1178:                     loc_cVal = ALLTRIM(NVL(cursor_4c_BuscaPro.CPros, ""))
1179:                     USE IN cursor_4c_BuscaPro
1180:                     SELECT csContas
1181:                     REPLACE CprosAnt WITH loc_cVal
1182:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
1183:                 ELSE
1184:                     IF USED("cursor_4c_BuscaPro")
1185:                         USE IN cursor_4c_BuscaPro
1186:                     ENDIF
1187:                 ENDIF
1188:             ENDIF
1189:         CATCH TO loc_oErro
1190:             IF USED("cursor_4c_BuscaPro")
1191:                 USE IN cursor_4c_BuscaPro
1192:             ENDIF
1193:             MsgErro(loc_oErro.Message, "Erro ao buscar produto")
1194:         ENDTRY
1195:     ENDPROC
1196: 
1197:     *==========================================================================
1198:     * CarregarLista - (Re)inicializa o cursor csContas exibido no grd_4c_Dados
1199:     * Form OPERACIONAL: nao ha SELECT de Grid CRUD; carga = InicializarCursorContas
1200:     * do BO (CREATE CURSOR csContas + INDEX + APPEND BLANK).
1201:     *==========================================================================
1202:     PROCEDURE CarregarLista()
1203:         LOCAL loc_lSucesso, loc_oErro
1204:         loc_lSucesso = .F.
1205: 
1206:         TRY
1207:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1208:                 loc_lSucesso = THIS.this_oBusinessObject.InicializarCursorContas()
1209:             ENDIF
1210: 
1211:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1212:                 IF USED("csContas")
1213:                     THIS.grd_4c_Dados.RecordSource = "csContas"
1214:                 ENDIF
1215:                 THIS.grd_4c_Dados.Refresh
1216:             ENDIF
1217:         CATCH TO loc_oErro
1218:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1219:                 "Erro CarregarLista Formsigprmdp")
1220:         ENDTRY
1221: 
1222:         RETURN loc_lSucesso
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * FormParaBO - Transfere flags e estado do Form para o BusinessObject
1227:     * Copia os 3 flags de controle (CheckCadPro, ManterBarra, CalculaCusto) e o
1228:     * usuario logado que sao consumidos por ValidarParesNoGrid, ImportarXLS e
1229:     * InserirPendencia.
1230:     *==========================================================================
1231:     PROCEDURE FormParaBO()
1232:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1233:             RETURN .F.
1234:         ENDIF
1235: 
1236:         THIS.this_oBusinessObject.this_lCheckCadPro  = THIS.this_lCheckCadPro
1237:         THIS.this_oBusinessObject.this_lManterBarra  = THIS.this_lManterBarra
1238:         THIS.this_oBusinessObject.this_lCalculaCusto = THIS.this_lCalculaCusto
1239:         THIS.this_oBusinessObject.this_cUsuar        = NVL(gc_4c_UsuarioLogado, "")
1240: 
1241:         RETURN .T.
1242:     ENDPROC
1243: 
1244:     *==========================================================================
1245:     * BOParaForm - Transfere flags do BusinessObject para o Form
1246:     * Ao inicializar (BuscarCalcCustos define this_lCalculaCusto no BO a partir
1247:     * de SigCdPaC), replica no Form para uso do usuario.
1248:     *==========================================================================
1249:     PROCEDURE BOParaForm()
1250:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1251:             RETURN .F.
1252:         ENDIF
1253: 
1254:         THIS.this_lCheckCadPro  = THIS.this_oBusinessObject.this_lCheckCadPro
1255:         THIS.this_lManterBarra  = THIS.this_oBusinessObject.this_lManterBarra
1256:         THIS.this_lCalculaCusto = THIS.this_oBusinessObject.this_lCalculaCusto
1257: 
1258:         RETURN .T.
1259:     ENDPROC
1260: 
1261:     *==========================================================================
1262:     * HabilitarCampos - Habilita/desabilita botoes e grid durante processamento
1263:     * Chamado por BtnProcessarClick antes/depois do SCAN principal para evitar
1264:     * cliques em botoes durante execucao.
1265:     *==========================================================================
1266:     PROCEDURE HabilitarCampos(par_lHabilitar)
1267:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1268:             THIS.grd_4c_Dados.Enabled = par_lHabilitar
1269:         ENDIF
1270:         IF PEMSTATUS(THIS, "cmd_4c_BtnIncluir", 5)
1271:             THIS.cmd_4c_BtnIncluir.Enabled = par_lHabilitar
1272:         ENDIF
1273:         IF PEMSTATUS(THIS, "cmd_4c_BtnExcluir", 5)
1274:             THIS.cmd_4c_BtnExcluir.Enabled = par_lHabilitar
1275:         ENDIF
1276:         IF PEMSTATUS(THIS, "cmd_4c_Exporta", 5)
1277:             THIS.cmd_4c_Exporta.Enabled = par_lHabilitar
1278:         ENDIF
1279:         IF PEMSTATUS(THIS, "cmd_4c_BtnProcessar", 5)
1280:             THIS.cmd_4c_BtnProcessar.Enabled = par_lHabilitar
1281:         ENDIF
1282:     ENDPROC
1283: 
1284:     *==========================================================================
1285:     * LimparCampos - Reseta csContas para linha em branco unica + limpa painel
1286:     * de progresso (Produto, Arquivo/Campo, barra de porcento).
1287:     *==========================================================================
1288:     PROCEDURE LimparCampos()
1289:         IF USED("csContas")
1290:             SELECT csContas
1291:             SET ORDER TO
1292:             ZAP
1293:             APPEND BLANK
1294:         ENDIF
1295: 
1296:         IF PEMSTATUS(THIS, "cnt_4c_Result", 5)
1297:             THIS.cnt_4c_Result.txt_4c_Cpros.Value   = ""
1298:             THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
1299:             IF PEMSTATUS(THIS.cnt_4c_Result, "cnt_4c_Barra", 5)
1300:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
1301:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
1302:             ENDIF
1303:             THIS.cnt_4c_Result.Visible = .F.
1304:         ENDIF
1305: 
1306:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1307:             THIS.grd_4c_Dados.Refresh
1308:             IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
1309:                 TRY
1310:                     THIS.grd_4c_Dados.Column1.SetFocus
1311:                 CATCH
1312:                 ENDTRY
1313:             ENDIF
1314:         ENDIF
1315:     ENDPROC
1316: 
1317:     *==========================================================================
1318:     * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme processamento
1319:     * Form OPERACIONAL nao tem modos INCLUIR/ALTERAR/VISUALIZAR; delega para
1320:     * HabilitarCampos(.T.) para reabilitar tudo apos processamento/erro.
1321:     *==========================================================================
1322:     PROCEDURE AjustarBotoesPorModo()
1323:         THIS.HabilitarCampos(.T.)
1324:     ENDPROC
1325: 
1326:     *==========================================================================
1327:     * BtnBuscarClick - Alias para AbrirBuscaProduto (usado pelo padrao CRUD)
1328:     * Form OPERACIONAL: nao tem botao Buscar visivel; disponivel para atalho
1329:     * externo que dispare o lookup de produto.
1330:     *==========================================================================
1331:     PROCEDURE BtnBuscarClick()
1332:         THIS.AbrirBuscaProduto()
1333:     ENDPROC
1334: 
1335:     *==========================================================================
1336:     * BtnEncerrarClick - Alias para BtnSairClick (padrao canonico Encerrar)
1337:     *==========================================================================
1338:     PROCEDURE BtnEncerrarClick()
1339:         THIS.BtnSairClick()
1340:     ENDPROC
1341: 
1342:     *==========================================================================
1343:     * BtnSalvarClick - Delega para BtnProcessarClick
1344:     * Form OPERACIONAL: a acao principal (equivalente a "salvar") eh executar a
1345:     * substituicao de referencias em todos os arquivos configurados.
1346:     *==========================================================================
1347:     PROCEDURE BtnSalvarClick()
1348:         THIS.BtnProcessarClick()
1349:     ENDPROC
1350: 
1351:     *==========================================================================
1352:     * BtnCancelarClick - Cancela pares digitados e reseta csContas
1353:     * Confirma antes se ja existem pares preenchidos para evitar perda acidental.
1354:     *==========================================================================
1355:     PROCEDURE BtnCancelarClick()
1356:         LOCAL loc_lTemDados
1357:         loc_lTemDados = .F.
1358: 
1359:         IF USED("csContas")
1360:             SELECT csContas
1361:             LOCATE FOR !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) OR ;
1362:                 !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
1363:             loc_lTemDados = FOUND()
1364:         ENDIF
1365: 
1366:         IF loc_lTemDados
1367:             IF !MsgConfirma("Descartar os pares informados?", ;
1368:                     "Cancelar Substitui" + CHR(231) + CHR(227) + "o")
1369:                 RETURN
1370:             ENDIF
1371:         ENDIF
1372: 
1373:         THIS.LimparCampos()
1374:     ENDPROC
1375: 
1376: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprmdpBO.prg):
*==============================================================================
* sigprmdpBO.prg - Business Object para Substitui??o de Refer?ncias de Produtos
* Tabela: SigOpClC (opera??es de recalculo de custo/estoque)
* Heran?a: BusinessBase
* Data: 2026-07-17
*==============================================================================
* FASE 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigprmdpBO AS BusinessBase

    *-- Chave e tabela principal (SigOpClC: recalculo de custo/estoque)
    this_cTabela      = "SigOpClC"
    this_cCampoChave  = "CidChaves"

    *-- Flags de controle de comportamento (parametros do form original)
    this_lCheckCadPro   = .F.   && Se .T., pula valida??o do produto no SigCdPro
    this_lManterBarra   = .F.   && Se .T., mant?m o c?digo de barras do produto antigo
    this_lCalculaCusto  = .F.   && Se .T., recalcula custo ap?s substitui??o

    *-- Par de c?digos sendo processado no loop atual
    this_cCprosAnt      = ""    && C?digo de produto antigo (Cpros char(14))
    this_cCprosNov      = ""    && C?digo de produto novo (Cpros char(14))

    *-- Atributos do produto antigo capturados antes do processamento
    this_nBarraAnt      = 0     && C?digo de barras (Cbars) do produto antigo

    *-- Estado de progresso do processamento em lote
    this_nTotal         = 0     && Total de pares a processar (csContas * csCampos)
    this_nProcessados   = 0     && Pares j? processados (para barra de progresso)
    this_nErro          = 0     && C?digo do ?ltimo erro de SQL (< 1 = falha)

    *-- Feedback visual do arquivo/campo sendo processado no momento
    this_cArquivoAtual  = ""    && Nome do arquivo DBF sendo atualizado
    this_cCampoAtual    = ""    && Nome do campo sendo atualizado no arquivo

    *-- C?digo do usu?rio logado (capturado no Init para auditoria)
    this_cUsuar         = ""    && Usuar - usu?rio logado

    *--------------------------------------------------------------------------
    * Init - Configura??o inicial do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        this.this_cTabela     = "SigOpClC"
        this.this_cCampoChave = "CidChaves"

        *-- Captura usu?rio logado para auditoria (fGravarLog)
        IF TYPE("gc_4c_UsuarioLogado") = "C" AND !EMPTY(gc_4c_UsuarioLogado)
            this.this_cUsuar = gc_4c_UsuarioLogado
        ENDIF
    ENDPROC


    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor (csContas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCprosAnt = TratarNulo(CprosAnt, "C")
            THIS.this_cCprosNov = TratarNulo(CprosNov, "C")
            THIS.this_nBarraAnt = TratarNulo(BarraAnt, "N")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna campo chave prim?ria de SigOpClC
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCampoChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados m?nimos antes de Inserir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCprosNov)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto novo " + ;
                CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF EMPTY(go_4c_Sistema.cCodEmpresa)
            THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o configurada no sistema."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere pendencia de recalculo em SigOpClC
    * Sobrescreve BusinessBase.Inserir (chamado por Salvar quando lNovoRegistro=.T.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                FormatarDataSQL(DATE()) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao inserir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cCampoChave = loc_cCidChaves
            THIS.RegistrarAuditoria("INSERT")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza pendencia em SigOpClC (data/usuario da requisicao)
    * Sobrescreve BusinessBase.Atualizar (chamado por Salvar quando lNovoRegistro=.F.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCampoChave)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria ausente para atualiza" + CHR(231) + CHR(227) + "o."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpClC SET " + ;
                "CPros = " + EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                "EmpCPros = " + EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                "Datas = " + FormatarDataSQL(DATE()) + ", " + ;
                "Usuars = " + EscaparSQL(THIS.this_cUsuar) + " " + ;
                "WHERE CidChaves = " + EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao atualizar pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove pend?ncia de rec?lculo de SigOpClC
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpClC WHERE CidChaves = " + ;
                EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao excluir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir de SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas - Cria cursor local de pares de substitui??o
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("csContas")
                USE IN csContas
            ENDIF

            SET NULL ON
            CREATE CURSOR csContas (CprosAnt C(14) NULL, CprosNov C(14) NULL, Flag L NULL, BarraAnt N(8) NULL)
            SET NULL OFF

            INDEX ON CprosAnt + CprosNov TAG Duplica
            INDEX ON CprosAnt TAG CprosAnt
            INDEX ON CprosNov TAG CprosNov
            SET ORDER TO

            INSERT INTO csContas (CprosAnt, CprosNov) VALUES ("", "")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursor de substitui" + CHR(231) + CHR(245) + "es")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCalcCustos - Busca configura??o de c?lculo de custos em SigCdPaC
    * Seta this_lCalculaCusto = .T. se CalcCustos <> 3
    *--------------------------------------------------------------------------
    FUNCTION BuscarCalcCustos()
        LOCAL loc_nCalcCustos, loc_oErro, loc_cSQL
        loc_nCalcCustos = 0

        TRY
            loc_cSQL = "SELECT CalcCustos FROM SigCdPaC ORDER BY CalcCustos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CalcCustos") > 0
                IF USED("cursor_4c_CalcCustos") AND RECCOUNT("cursor_4c_CalcCustos") > 0
                    SELECT cursor_4c_CalcCustos
                    loc_nCalcCustos = NVL(CalcCustos, 0)
                ENDIF
                IF USED("cursor_4c_CalcCustos")
                    USE IN cursor_4c_CalcCustos
                ENDIF
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigCdPaC)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo")
        ENDTRY

        THIS.this_lCalculaCusto = (loc_nCalcCustos <> 3)
        RETURN loc_nCalcCustos
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesNoGrid - Valida todos os pares em csContas antes do processamento
    * Retorna "" se OK, mensagem de erro se houver inconsist?ncia
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesNoGrid(par_lCheckCadPro, par_lManterBarra)
        LOCAL loc_cMensagem, loc_oErro, loc_cSQL, loc_nErro, loc_cEstoqsNov
        loc_cMensagem = ""

        TRY
            SELECT csContas
            GO TOP

            IF EOF()
                loc_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
                loc_lSucesso = loc_cMensagem
            ENDIF

            SELECT csContas
            SCAN
                IF EMPTY(csContas.CprosAnt)
                    loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros, Cbars FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(ALLTRIM(csContas.CprosAnt))
                    loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
                    IF loc_nErro < 1 OR (USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") = 0)
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lSucesso = loc_cMensagem
                    ENDIF
                    IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                        SELECT cursor_4c_TmpPro
                        REPLACE BarraAnt WITH NVL(cursor_4c_TmpPro.Cbars, 0) IN csContas
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                IF par_lManterBarra AND csContas.BarraAnt = 0
                    loc_cMensagem = "Existe Uma Referencia Antigo Sem Barra !!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF EMPTY(csContas.CprosNov)
                    loc_cMensagem = "Existe Uma Referencia Nova Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF csContas.CprosAnt = csContas.CprosNov
                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova Com o Mesmo C" + CHR(243) + "digo!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                    "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                    "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosNov))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0
                    IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                        SELECT cursor_4c_LocalPro
                        loc_cEstoqsNov = ALLTRIM(NVL(cursor_4c_LocalPro.Cestoqs, ""))
                        USE IN cursor_4c_LocalPro

                        loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                            "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                            "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosAnt))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2") > 0
                            IF USED("cursor_4c_LocalPro2") AND RECCOUNT("cursor_4c_LocalPro2") > 0
                                SELECT cursor_4c_LocalPro2
                                IF ALLTRIM(NVL(cursor_4c_LocalPro2.Cestoqs, "")) <> loc_cEstoqsNov
                                    USE IN cursor_4c_LocalPro2
                                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova com Controle de Estoque diferente!!!"
                                    loc_lSucesso = loc_cMensagem
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_LocalPro2")
                                USE IN cursor_4c_LocalPro2
                            ENDIF
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            loc_cMensagem = "Erro na valida" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_cMensagem
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirPendencia - Insere linha em SigOpClC para rec?lculo posterior
    * Chamado no loop de processamento para cada produto/empresa
    *--------------------------------------------------------------------------
    FUNCTION InserirPendencia(par_cEmps, par_cCpros, par_dData)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()
            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(par_cEmps) + ", " + ;
                EscaparSQL(par_cCpros) + ", " + ;
                EscaparSQL(par_cEmps + par_cCpros) + ", " + ;
                FormatarDataSQL(par_dData) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir pend" + CHR(234) + "ncia em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarXLS - Importa pares de substitui??o de planilha Excel para csContas
    * Retorna n?mero de registros importados com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarXLS(par_cArquivoXLS, par_lCheckCadPro)
        LOCAL loc_nImportados, loc_oErro, loc_cSQL, loc_cCprosAnt, loc_cCprosNov
        loc_nImportados = 0

        TRY
            IF !FILE(par_cArquivoXLS)
                MsgErro("Arquivo Excel n" + CHR(227) + "o encontrado: " + par_cArquivoXLS, "Erro")
                loc_lSucesso = 0
            ENDIF

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF

            CREATE CURSOR cursor_4c_Importa (CprosAnt C(14), CprosNov C(14))
            INDEX ON CprosAnt TAG CprosAnt

            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivoXLS) TYPE XLS

            SELECT cursor_4c_Importa
            SCAN
                loc_cCprosAnt = ALLTRIM(cursor_4c_Importa.CprosAnt)
                loc_cCprosNov = ALLTRIM(cursor_4c_Importa.CprosNov)

                IF EMPTY(loc_cCprosAnt) OR EMPTY(loc_cCprosNov) OR loc_cCprosAnt = loc_cCprosNov
                    LOOP
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(loc_cCprosAnt)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") < 1
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_TmpPro")
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                SELECT csContas
                SET ORDER TO Duplica
                IF !SEEK(loc_cCprosAnt + loc_cCprosNov)
                    APPEND BLANK
                    REPLACE CprosAnt WITH loc_cCprosAnt, CprosNov WITH loc_cCprosNov
                    loc_nImportados = loc_nImportados + 1
                ENDIF
            ENDSCAN

            SELECT csContas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao importar planilha Excel")
        ENDTRY

        RETURN loc_nImportados
    ENDFUNC

ENDDEFINE

