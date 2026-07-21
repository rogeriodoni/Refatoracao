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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1373 linhas total):

*-- Linhas 38 a 278:
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
85:                         THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
86:                         THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
87:                         THIS.ConfigurarPaginaLista()
88: 
89:                         *-- cnt_4c_Result fica oculto ate o processamento (painel de progresso)
90:                         THIS.TornarControlesVisiveis(THIS)
91: 
92:                         loc_lSucesso = .T.
93:                     ENDIF
94:                 ENDIF
95:             ENDIF
96:         CATCH TO loc_oErro
97:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
98:                 " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprmdp")
99:         ENDTRY
100: 
101:         RETURN loc_lSucesso
102:     ENDPROC
103: 
104:     *==========================================================================
105:     PROTECTED PROCEDURE ConfigurarCabecalho()
106:     *==========================================================================
107:         LOCAL loc_oErro
108: 
109:         TRY
110:             *-- Container do cabecalho (cntSombra do legado)
111:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
112:             WITH THIS.cnt_4c_Cabecalho
113:                 .Top         = 0
114:                 .Left        = 0
115:                 .Width       = THIS.Width
116:                 .Height      = 80
117:                 .BackStyle   = 1
118:                 .BackColor   = RGB(100, 100, 100)
119:                 .BorderWidth = 0
120:                 .Visible     = .T.
121:             ENDWITH
122: 
123:             *-- Label sombra ? efeito de sombra no titulo (lblSombra do legado)
124:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
125:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
126:                 .AutoSize   = .F.
127:                 .FontBold   = .T.
128:                 .FontName   = "Tahoma"
129:                 .FontSize   = 18
130:                 .WordWrap   = .T.
131:                 .Alignment  = 0
132:                 .BackStyle  = 0
133:                 .Caption    = THIS.Caption
134:                 .Height     = 40
135:                 .Left       = 10
136:                 .Top        = 18
137:                 .Width      = THIS.cnt_4c_Cabecalho.Width
138:                 .ForeColor  = RGB(0, 0, 0)
139:             ENDWITH
140: 
141:             *-- Label titulo ? texto visivel sobre a sombra (lblTitulo do legado)
142:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
143:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
144:                 .AutoSize    = .F.
145:                 .FontBold    = .T.
146:                 .FontName    = "Tahoma"
147:                 .FontSize    = 18
148:                 .WordWrap    = .T.
149:                 .Alignment   = 0
150:                 .BackStyle   = 0
151:                 .Caption     = THIS.Caption
152:                 .Height      = 46
153:                 .Left        = 10
154:                 .Top         = 17
155:                 .Width       = THIS.cnt_4c_Cabecalho.Width
156:                 .ForeColor   = RGB(255, 255, 255)
157:                 .ToolTipText = "T" + CHR(237) + "tulo"
158:             ENDWITH
159: 
160:         CATCH TO loc_oErro
161:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
162:                 "Erro ConfigurarCabecalho Formsigprmdp")
163:         ENDTRY
164:     ENDPROC
165: 
166:     *==========================================================================
167:     * TornarControlesVisiveis
168:     * Containers ocultos por design (cnt_4c_Result, cnt_4c_Cabecalho): recursa
169:     * filhos mas NAO forca Visible=.T. no container pai.
170:     *==========================================================================
171:     PROCEDURE TornarControlesVisiveis(par_oContainer)
172:         LOCAL loc_i, loc_oControl
173: 
174:         FOR loc_i = 1 TO par_oContainer.ControlCount
175:             loc_oControl = par_oContainer.Controls(loc_i)
176: 
177:             IF VARTYPE(loc_oControl) != "O"
178:                 LOOP
179:             ENDIF
180: 
181:             IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_RESULT", "CNT_4C_CABECALHO")
182:                 IF PEMSTATUS(loc_oControl, "Controls", 5)
183:                     THIS.TornarControlesVisiveis(loc_oControl)
184:                 ENDIF
185:                 LOOP
186:             ENDIF
187: 
188:             IF PEMSTATUS(loc_oControl, "Visible", 5)
189:                 loc_oControl.Visible = .T.
190:             ENDIF
191: 
192:             IF PEMSTATUS(loc_oControl, "Controls", 5)
193:                 THIS.TornarControlesVisiveis(loc_oControl)
194:             ENDIF
195:         ENDFOR
196:     ENDPROC
197: 
198:     *==========================================================================
199:     PROCEDURE Destroy()
200:     *==========================================================================
201:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
202:             THIS.this_oBusinessObject = .NULL.
203:         ENDIF
204:         IF USED("csContas")
205:             USE IN csContas
206:         ENDIF
207:         DODEFAULT()
208:     ENDPROC
209: 
210:     *==========================================================================
211:     PROTECTED PROCEDURE ConfigurarPaginaLista()
212:     *==========================================================================
213:         LOCAL loc_oErro
214:         TRY
215:             THIS.ConfigurarBotoes()
216:             THIS.ConfigurarGrade()
217:             THIS.ConfigurarPaginaDados()
218:         CATCH TO loc_oErro
219:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
220:                 "Erro ConfigurarPaginaLista Formsigprmdp")
221:         ENDTRY
222:     ENDPROC
223: 
224:     *==========================================================================
225:     * ConfigurarPaginaDados
226:     * Form OPERACIONAL de layout flat (800x270, sem PageFrame): nao existe Page2.
227:     * Todos os campos de exibicao (cnt_4c_Result com txt_4c_Cpros, txt_4c_Arquivo,
228:     * cnt_4c_Barra com shp_4c_ShpBarra e lbl_4c_LblPorcento, alem dos labels
229:     * "Produto :", "Arquivo/Campo :" e "Progresso :") sao criados em
230:     * ConfigurarPainelResultado, delegada aqui para satisfazer o contrato da
231:     * pipeline multi-fase.
232:     *==========================================================================
233:     PROTECTED PROCEDURE ConfigurarPaginaDados()
234:         THIS.ConfigurarPainelResultado()
235:     ENDPROC
236: 
237:     *==========================================================================
238:     PROTECTED PROCEDURE ConfigurarBotoes()
239:     *==========================================================================
240:         LOCAL loc_oErro
241:         TRY
242:             *-- Shape decorativo de fundo (Shape1 do legado): Top=7,Left=502,W=90,H=110
243:             THIS.AddObject("shp_4c_Shape1", "Shape")
244:             WITH THIS.shp_4c_Shape1
245:                 .Top         = 7
246:                 .Left        = 502
247:                 .Height      = 110
248:                 .Width       = 90
249:                 .BackStyle   = 0
250:                 .BorderStyle = 0
251:                 .BorderColor = RGB(136, 189, 188)
252:                 .Visible     = .T.
253:             ENDWITH
254: 
255:             THIS.AddObject("cmd_4c_BtnIncluir", "CommandButton")
256:             WITH THIS.cmd_4c_BtnIncluir
257:                 .Top        = 3
258:                 .Left       = 425
259:                 .Height     = 75
260:                 .Width      = 75
261:                 .FontBold   = .T.
262:                 .FontItalic = .T.
263:                 .FontName   = "Tahoma"
264:                 .FontSize   = 8
265:                 .ForeColor  = RGB(90, 90, 90)
266:                 .BackColor  = RGB(255, 255, 255)
267:                 .Themes           = .T.
268:                 .Caption    = "\<Incluir"
269:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
270:                 .TabIndex   = 1
271:                 .Visible    = .T.
272:             ENDWITH
273: 
274:             THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
275:             WITH THIS.cmd_4c_BtnExcluir
276:                 .Top        = 3
277:                 .Left       = 500
278:                 .Height     = 75

*-- Linhas 349 a 405:
349:                 .Visible    = .T.
350:             ENDWITH
351: 
352:             BINDEVENT(THIS.cmd_4c_BtnIncluir,   "Click", THIS, "BtnIncluirClick")
353:             BINDEVENT(THIS.cmd_4c_BtnExcluir,   "Click", THIS, "BtnExcluirClick")
354:             BINDEVENT(THIS.cmd_4c_Exporta,      "Click", THIS, "BtnExportaClick")
355:             BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "BtnProcessarClick")
356:             BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "BtnSairClick")
357: 
358:         CATCH TO loc_oErro
359:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
360:                 "Erro ConfigurarBotoes Formsigprmdp")
361:         ENDTRY
362:     ENDPROC
363: 
364:     *==========================================================================
365:     PROTECTED PROCEDURE ConfigurarGrade()
366:     *==========================================================================
367:         LOCAL loc_oErro, loc_oGrd
368:         TRY
369:             THIS.AddObject("grd_4c_Dados", "Grid")
370:             loc_oGrd = THIS.grd_4c_Dados
371:             WITH loc_oGrd
372:                 .Top               = 101
373:                 .Left              = 147
374:                 .Width             = 269
375:                 .Height            = 148
376:                 .ColumnCount       = 2
377:                 .AllowHeaderSizing = .F.
378:                 .AllowRowSizing    = .F.
379:                 .DeleteMark        = .F.
380:                 .RecordMark        = .F.
381:                 .HeaderHeight      = 18
382:                 .RowHeight         = 18
383:                 .ScrollBars        = 2
384:                 .FontName          = "Verdana"
385:                 .FontSize          = 8
386:                 .ForeColor         = RGB(90, 90, 90)
387:                 .BackColor         = RGB(255, 255, 255)
388:                 .GridLineColor     = RGB(238, 238, 238)
389:                 .HighlightStyle    = 2
390:                 .TabIndex          = 5
391:                 .RecordSource      = "csContas"
392:                 WITH .Column1
393:                     .Width         = 118
394:                     .ControlSource = "csContas.CprosAnt"
395:                     WITH .Header1
396:                         .FontName  = "Tahoma"
397:                         .FontSize  = 8
398:                         .Alignment = 2
399:                         .Caption   = "C" + CHR(243) + "digo Original"
400:                     ENDWITH
401:                     WITH .Text1
402:                         .BorderStyle = 0
403:                         .Margin      = 0
404:                         .ForeColor   = RGB(0, 0, 0)
405:                         .BackColor   = RGB(255, 255, 255)

*-- Linhas 424 a 476:
424:                 .Visible = .T.
425:             ENDWITH
426: 
427:             BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtCprosAntKeyPress")
428: 
429:         CATCH TO loc_oErro
430:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
431:                 "Erro ConfigurarGrade Formsigprmdp")
432:         ENDTRY
433:     ENDPROC
434: 
435:     *==========================================================================
436:     PROTECTED PROCEDURE ConfigurarPainelResultado()
437:     *==========================================================================
438:         LOCAL loc_oErro
439:         TRY
440:             THIS.AddObject("cnt_4c_Result", "Container")
441:             WITH THIS.cnt_4c_Result
442:                 .Top           = 101
443:                 .Left          = 440
444:                 .Width         = 213
445:                 .Height        = 146
446:                 .BackStyle     = 0
447:                 .BorderWidth   = 0
448:                 .SpecialEffect = 0
449:                 .TabIndex      = 6
450:                 .Visible     = .T.
451:             ENDWITH
452: 
453:             THIS.cnt_4c_Result.AddObject("lbl_4c_Label2", "Label")
454:             WITH THIS.cnt_4c_Result.lbl_4c_Label2
455:                 .Caption   = "Produto : "
456:                 .Left      = 8
457:                 .Top       = 2
458:                 .FontName  = "Tahoma"
459:                 .FontSize  = 8
460:                 .BackStyle = 0
461:                 .AutoSize  = .T.
462:             ENDWITH
463: 
464:             THIS.cnt_4c_Result.AddObject("txt_4c_Cpros", "TextBox")
465:             WITH THIS.cnt_4c_Result.txt_4c_Cpros
466:                 .Top               = 19
467:                 .Left              = 5
468:                 .Width             = 108
469:                 .Height            = 24
470:                 .FontName          = "Tahoma"
471:                 .FontSize          = 8
472:                 .Alignment         = 3
473:                 .Enabled           = .F.
474:                 .Format            = "K!"
475:                 .ReadOnly          = .T.
476:                 .SpecialEffect     = 1

*-- Linhas 567 a 781:
567:     * AlternarPagina - Mostra/oculta painel de progresso (cntResult do legado)
568:     * par_lMostrar: .T. = mostrar, .F. = ocultar
569:     *==========================================================================
570:     PROCEDURE AlternarPagina(par_lMostrar)
571:         IF PEMSTATUS(THIS, "cnt_4c_Result", 5)
572:             THIS.cnt_4c_Result.Visible = par_lMostrar
573:             IF par_lMostrar
574:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
575:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
576:                 THIS.cnt_4c_Result.txt_4c_Cpros.Value   = ""
577:                 THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
578:             ENDIF
579:         ENDIF
580:     ENDPROC
581: 
582:     *==========================================================================
583:     * BtnSairClick - Encerra o form
584:     *==========================================================================
585:     PROCEDURE BtnSairClick()
586:         THIS.Release
587:     ENDPROC
588: 
589:     *==========================================================================
590:     * BtnIncluirClick - Adiciona linha em branco ao csContas se linha atual estiver completa
591:     *==========================================================================
592:     PROCEDURE BtnIncluirClick()
593:         LOCAL loc_lOK
594:         loc_lOK = .F.
595: 
596:         IF USED("csContas")
597:             SELECT csContas
598:             IF !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) AND ;
599:                !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
600:                 APPEND BLANK
601:                 loc_lOK = .T.
602:             ENDIF
603:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
604:                 THIS.grd_4c_Dados.Refresh
605:                 IF loc_lOK
606:                     THIS.grd_4c_Dados.Column1.SetFocus
607:                 ENDIF
608:             ENDIF
609:         ENDIF
610:     ENDPROC
611: 
612:     *==========================================================================
613:     * BtnExcluirClick - Remove linha selecionada do csContas
614:     *==========================================================================
615:     PROCEDURE BtnExcluirClick()
616:         IF USED("csContas")
617:             SELECT csContas
618:             IF !EOF()
619:                 DELETE
620:             ENDIF
621:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
622:                 THIS.grd_4c_Dados.Refresh
623:                 THIS.grd_4c_Dados.Column1.SetFocus
624:             ENDIF
625:         ENDIF
626:     ENDPROC
627: 
628:     *==========================================================================
629:     * BtnAlterarClick - Coloca a linha corrente do grid em edicao
630:     * Form OPERACIONAL: nao possui botao Alterar visivel; disponivel para
631:     * scripting/atalho externo que precise reposicionar o cursor no par corrente
632:     * para edicao inline no grid csContas.
633:     *==========================================================================
634:     PROCEDURE BtnAlterarClick()
635:         IF !USED("csContas")
636:             RETURN
637:         ENDIF
638: 
639:         SELECT csContas
640:         IF RECCOUNT() = 0
641:             APPEND BLANK
642:         ELSE
643:             IF EOF()
644:                 GO BOTTOM
645:             ENDIF
646:         ENDIF
647: 
648:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
649:             THIS.grd_4c_Dados.Refresh
650:             THIS.grd_4c_Dados.SetFocus
651:             THIS.grd_4c_Dados.Column1.SetFocus
652:             IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "Text1", 5)
653:                 THIS.grd_4c_Dados.Column1.Text1.SelStart  = 0
654:                 THIS.grd_4c_Dados.Column1.Text1.SelLength = ;
655:                     LEN(ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, "")))
656:             ENDIF
657:         ENDIF
658:     ENDPROC
659: 
660:     *==========================================================================
661:     * BtnVisualizarClick - Reposiciona no topo do csContas e atualiza o grid
662:     * Form OPERACIONAL: nao possui botao Visualizar visivel; disponivel para
663:     * scripting/atalho externo que precise mostrar todos os pares carregados
664:     * (pos-importacao XLS) antes de processar.
665:     *==========================================================================
666:     PROCEDURE BtnVisualizarClick()
667:         IF !USED("csContas")
668:             RETURN
669:         ENDIF
670: 
671:         SELECT csContas
672:         SET ORDER TO
673:         GO TOP
674: 
675:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
676:             THIS.grd_4c_Dados.Refresh
677:             THIS.grd_4c_Dados.SetFocus
678:         ENDIF
679:     ENDPROC
680: 
681:     *==========================================================================
682:     * BtnExportaClick - Importa pares de substituicao de planilha XLS para csContas
683:     *==========================================================================
684:     PROCEDURE BtnExportaClick()
685:         LOCAL loc_cArquivo, loc_nImportados, loc_oErro
686:         loc_cArquivo   = ""
687:         loc_nImportados = 0
688: 
689:         TRY
690:             loc_cArquivo = GETFILE("XLS")
691: 
692:             IF EMPTY(loc_cArquivo)
693:                 MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
694:                     "o informado!!!", "Aviso")
695:             ELSE
696:                 IF !FILE(loc_cArquivo)
697:                 MsgErro("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArquivo, "Erro")
698:             ELSE
699:                 loc_nImportados = THIS.this_oBusinessObject.ImportarXLS( ;
700:                     loc_cArquivo, THIS.this_lCheckCadPro)
701: 
702:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
703:                     THIS.grd_4c_Dados.Refresh
704:                 ENDIF
705: 
706:                 IF loc_nImportados > 0
707:                     MsgInfo(TRANSFORM(loc_nImportados) + " par(es) importado(s) com sucesso.", ;
708:                         "Importa" + CHR(231) + CHR(227) + "o")
709:                 ELSE
710:                     MsgAviso("Nenhum par v" + CHR(225) + "lido encontrado na planilha.", ;
711:                         "Importa" + CHR(231) + CHR(227) + "o")
712:                 ENDIF
713:                 ENDIF
714:             ENDIF
715: 
716:         CATCH TO loc_oErro
717:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
718:                 "Erro BtnExportaClick Formsigprmdp")
719:         ENDTRY
720:     ENDPROC
721: 
722:     *==========================================================================
723:     * BtnProcessarClick - Processa substituicao de referencias em todos os arquivos
724:     * Logica baseada em btnProcessar.Click do legado SIGPRMDP
725:     * fRecalculaP/fRecalculaC nao portadas - operacoes de recalculo de saldo omitidas
726:     *==========================================================================
727:     PROCEDURE BtnProcessarClick()
728:         LOCAL loc_cMensagem, loc_oErro
729:         LOCAL loc_nErro, loc_nRec, loc_nCnt, loc_nTtArq, loc_nPct
730:         LOCAL loc_cArq, loc_cCpo, loc_cSql, loc_cChave, loc_cKeyPry, loc_cType
731: 
732:         *-- Validacoes fora do TRY (funcoes tem TRY proprio)
733:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
734:             MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
735:             RETURN
736:         ENDIF
737: 
738:         loc_cMensagem = THIS.this_oBusinessObject.ValidarParesNoGrid( ;
739:             THIS.this_lCheckCadPro, THIS.this_lManterBarra)
740:         IF !EMPTY(loc_cMensagem)
741:             MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o!!!")
742:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
743:                 THIS.grd_4c_Dados.Column1.SetFocus
744:             ENDIF
745:             RETURN
746:         ENDIF
747: 
748:         IF !MsgConfirma("Confirma a Troca das Refer" + CHR(234) + "ncias ?", ;
749:                 "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
750:             RETURN
751:         ENDIF
752: 
753:         IF EMPTY(THIS.this_cArqDBFPath) OR !FILE(THIS.this_cArqDBFPath + ".dbf")
754:             MsgErro("ArqDBF n" + CHR(227) + "o localizado para processamento.", ;
755:                 "Erro de Configura" + CHR(231) + CHR(227) + "o")
756:             RETURN
757:         ENDIF
758: 
759:         loc_nErro = 1
760: 
761:         TRY
762:             IF !USED("ArqDBF")
763:                 USE (THIS.this_cArqDBFPath) IN 0 ALIAS ArqDBF
764:             ENDIF
765: 
766:             *-- Selecionar campos elegiveis: tipo C, tamanho 10 ou 14, nomes especificos de produto
767:             SELECT Arquivos, Campos ;
768:                 FROM ArqDBF ;
769:                 WHERE (Tamanhos = 10 OR Tamanhos = 14) AND ;
770:                     UPPER(Tipos) = "C" AND ;
771:                     ALLTRIM(Arquivos) <> "ARQDBF.DBF" AND ;
772:                     ALLTRIM(Arquivos) <> "SIGTEMPD.DBF" AND ;
773:                     ALLTRIM(Arquivos) <> "SIGTEMPC.DBF" AND ;
774:                     ALLTRIM(Arquivos) <> "SIGTEMPR.DBF" AND ;
775:                     !EMPTY(Dbcs) AND ;
776:                     INLIST(ALLTRIM(Campos), "CMATS","CODCONPADS","CODPDS","CODPROPADS", ;
777:                         "CPROS","PRODUTO","PRODUTOS","CPROEQS","MATPRINCS", ;
778:                         "MATS","MATSUBS","CODGARRAS","OUROS","BRILHANTES") ;
779:                 ORDER BY Arquivos ;
780:                 INTO CURSOR csCampos READWRITE
781:             INDEX ON Arquivos + Campos TAG ArqCpo

*-- Linhas 1062 a 1145:
1062:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1063:                     THIS.grd_4c_Dados.Refresh
1064:                 ENDIF
1065:                 MsgAviso("Existem Produtos que n" + CHR(227) + "o Foram Alterados!!!", ;
1066:                     "Reprocessar!!!")
1067:             ELSE
1068:                 SELECT csContas
1069:                 SET ORDER TO
1070:                 ZAP
1071:                 APPEND BLANK
1072:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1073:                     THIS.grd_4c_Dados.Refresh
1074:                 ENDIF
1075:                 MsgAviso("Todos Os Produtos Foram Alterados!!!", ;
1076:                     "Processamento Encerrado!!!")
1077:             ENDIF
1078: 
1079:         CATCH TO loc_oErro
1080:             SQLEXEC(gnConnHandle, "ROLLBACK")
1081:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1082:                 "Erro BtnProcessarClick Formsigprmdp")
1083:         ENDTRY
1084: 
1085:         THIS.AlternarPagina(.F.)
1086: 
1087:         IF USED("csCampos")
1088:             USE IN csCampos
1089:         ENDIF
1090:         IF USED("csArquivos")
1091:             USE IN csArquivos
1092:         ENDIF
1093:         IF USED("cursor_4c_ChavePrim")
1094:             USE IN cursor_4c_ChavePrim
1095:         ENDIF
1096:         IF USED("ArqDBF")
1097:             USE IN ArqDBF
1098:         ENDIF
1099:     ENDPROC
1100: 
1101:     *==========================================================================
1102:     * TxtCprosAntKeyPress - Lookup de produto no campo Codigo Original (Column1)
1103:     * Disparado por BINDEVENT em grd_4c_Dados.Column1.Text1
1104:     *==========================================================================
1105:     PROCEDURE TxtCprosAntKeyPress
1106:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1107: 
1108:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
1109:             RETURN
1110:         ENDIF
1111: 
1112:         IF THIS.this_lCheckCadPro
1113:             RETURN
1114:         ENDIF
1115: 
1116:         LOCAL loc_cVal, loc_oErro, loc_nErro
1117:         loc_cVal  = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))
1118:         loc_nErro = 0
1119: 
1120:         TRY
1121:             IF EMPTY(loc_cVal)
1122:                 SELECT csContas
1123:                 REPLACE CprosAnt WITH ""
1124:             ELSE
1125:                 IF USED("cursor_4c_TmpPro")
1126:                     USE IN cursor_4c_TmpPro
1127:                 ENDIF
1128:                 loc_nErro = SQLEXEC(gnConnHandle, ;
1129:                     "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cVal), ;
1130:                     "cursor_4c_TmpPro")
1131: 
1132:                 IF loc_nErro > 0 AND USED("cursor_4c_TmpPro") AND ;
1133:                    RECCOUNT("cursor_4c_TmpPro") > 0
1134:                     SELECT cursor_4c_TmpPro
1135:                     loc_cVal = ALLTRIM(NVL(cursor_4c_TmpPro.Cpros, ""))
1136:                     USE IN cursor_4c_TmpPro
1137:                     SELECT csContas
1138:                     REPLACE CprosAnt WITH loc_cVal
1139:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
1140:                 ELSE
1141:                     IF USED("cursor_4c_TmpPro")
1142:                         USE IN cursor_4c_TmpPro
1143:                     ENDIF
1144:                     THIS.AbrirBuscaProduto()
1145:                 ENDIF

*-- Linhas 1154 a 1373:
1154:     ENDPROC
1155: 
1156:     *==========================================================================
1157:     * AbrirBuscaProduto - Abre FormBuscaAuxiliar para selecao de produto (SigCdPro)
1158:     *==========================================================================
1159:     PROCEDURE AbrirBuscaProduto()
1160:         LOCAL loc_oLookup, loc_cVal, loc_oErro
1161:         loc_cVal = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))
1162: 
1163:         TRY
1164:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
1165:                 "cursor_4c_BuscaPro", "CPros", loc_cVal, ;
1166:                 "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
1167:             IF VARTYPE(loc_oLookup) <> "O"
1168:                 MsgErro("Erro ao abrir busca de produto.", "Erro")
1169:             ELSE
1170:                 loc_oLookup.mAddColuna("CPros", "XXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
1171:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1172:                 loc_oLookup.Show()
1173:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaPro")
1174:                     SELECT cursor_4c_BuscaPro
1175:                     loc_cVal = ALLTRIM(NVL(cursor_4c_BuscaPro.CPros, ""))
1176:                     USE IN cursor_4c_BuscaPro
1177:                     SELECT csContas
1178:                     REPLACE CprosAnt WITH loc_cVal
1179:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
1180:                 ELSE
1181:                     IF USED("cursor_4c_BuscaPro")
1182:                         USE IN cursor_4c_BuscaPro
1183:                     ENDIF
1184:                 ENDIF
1185:             ENDIF
1186:         CATCH TO loc_oErro
1187:             IF USED("cursor_4c_BuscaPro")
1188:                 USE IN cursor_4c_BuscaPro
1189:             ENDIF
1190:             MsgErro(loc_oErro.Message, "Erro ao buscar produto")
1191:         ENDTRY
1192:     ENDPROC
1193: 
1194:     *==========================================================================
1195:     * CarregarLista - (Re)inicializa o cursor csContas exibido no grd_4c_Dados
1196:     * Form OPERACIONAL: nao ha SELECT de Grid CRUD; carga = InicializarCursorContas
1197:     * do BO (CREATE CURSOR csContas + INDEX + APPEND BLANK).
1198:     *==========================================================================
1199:     PROCEDURE CarregarLista()
1200:         LOCAL loc_lSucesso, loc_oErro
1201:         loc_lSucesso = .F.
1202: 
1203:         TRY
1204:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1205:                 loc_lSucesso = THIS.this_oBusinessObject.InicializarCursorContas()
1206:             ENDIF
1207: 
1208:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1209:                 IF USED("csContas")
1210:                     THIS.grd_4c_Dados.RecordSource = "csContas"
1211:                 ENDIF
1212:                 THIS.grd_4c_Dados.Refresh
1213:             ENDIF
1214:         CATCH TO loc_oErro
1215:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1216:                 "Erro CarregarLista Formsigprmdp")
1217:         ENDTRY
1218: 
1219:         RETURN loc_lSucesso
1220:     ENDPROC
1221: 
1222:     *==========================================================================
1223:     * FormParaBO - Transfere flags e estado do Form para o BusinessObject
1224:     * Copia os 3 flags de controle (CheckCadPro, ManterBarra, CalculaCusto) e o
1225:     * usuario logado que sao consumidos por ValidarParesNoGrid, ImportarXLS e
1226:     * InserirPendencia.
1227:     *==========================================================================
1228:     PROCEDURE FormParaBO()
1229:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1230:             RETURN .F.
1231:         ENDIF
1232: 
1233:         THIS.this_oBusinessObject.this_lCheckCadPro  = THIS.this_lCheckCadPro
1234:         THIS.this_oBusinessObject.this_lManterBarra  = THIS.this_lManterBarra
1235:         THIS.this_oBusinessObject.this_lCalculaCusto = THIS.this_lCalculaCusto
1236:         THIS.this_oBusinessObject.this_cUsuar        = NVL(gc_4c_UsuarioLogado, "")
1237: 
1238:         RETURN .T.
1239:     ENDPROC
1240: 
1241:     *==========================================================================
1242:     * BOParaForm - Transfere flags do BusinessObject para o Form
1243:     * Ao inicializar (BuscarCalcCustos define this_lCalculaCusto no BO a partir
1244:     * de SigCdPaC), replica no Form para uso do usuario.
1245:     *==========================================================================
1246:     PROCEDURE BOParaForm()
1247:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1248:             RETURN .F.
1249:         ENDIF
1250: 
1251:         THIS.this_lCheckCadPro  = THIS.this_oBusinessObject.this_lCheckCadPro
1252:         THIS.this_lManterBarra  = THIS.this_oBusinessObject.this_lManterBarra
1253:         THIS.this_lCalculaCusto = THIS.this_oBusinessObject.this_lCalculaCusto
1254: 
1255:         RETURN .T.
1256:     ENDPROC
1257: 
1258:     *==========================================================================
1259:     * HabilitarCampos - Habilita/desabilita botoes e grid durante processamento
1260:     * Chamado por BtnProcessarClick antes/depois do SCAN principal para evitar
1261:     * cliques em botoes durante execucao.
1262:     *==========================================================================
1263:     PROCEDURE HabilitarCampos(par_lHabilitar)
1264:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1265:             THIS.grd_4c_Dados.Enabled = par_lHabilitar
1266:         ENDIF
1267:         IF PEMSTATUS(THIS, "cmd_4c_BtnIncluir", 5)
1268:             THIS.cmd_4c_BtnIncluir.Enabled = par_lHabilitar
1269:         ENDIF
1270:         IF PEMSTATUS(THIS, "cmd_4c_BtnExcluir", 5)
1271:             THIS.cmd_4c_BtnExcluir.Enabled = par_lHabilitar
1272:         ENDIF
1273:         IF PEMSTATUS(THIS, "cmd_4c_Exporta", 5)
1274:             THIS.cmd_4c_Exporta.Enabled = par_lHabilitar
1275:         ENDIF
1276:         IF PEMSTATUS(THIS, "cmd_4c_BtnProcessar", 5)
1277:             THIS.cmd_4c_BtnProcessar.Enabled = par_lHabilitar
1278:         ENDIF
1279:     ENDPROC
1280: 
1281:     *==========================================================================
1282:     * LimparCampos - Reseta csContas para linha em branco unica + limpa painel
1283:     * de progresso (Produto, Arquivo/Campo, barra de porcento).
1284:     *==========================================================================
1285:     PROCEDURE LimparCampos()
1286:         IF USED("csContas")
1287:             SELECT csContas
1288:             SET ORDER TO
1289:             ZAP
1290:             APPEND BLANK
1291:         ENDIF
1292: 
1293:         IF PEMSTATUS(THIS, "cnt_4c_Result", 5)
1294:             THIS.cnt_4c_Result.txt_4c_Cpros.Value   = ""
1295:             THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
1296:             IF PEMSTATUS(THIS.cnt_4c_Result, "cnt_4c_Barra", 5)
1297:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
1298:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
1299:             ENDIF
1300:             THIS.cnt_4c_Result.Visible = .F.
1301:         ENDIF
1302: 
1303:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1304:             THIS.grd_4c_Dados.Refresh
1305:             IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
1306:                 TRY
1307:                     THIS.grd_4c_Dados.Column1.SetFocus
1308:                 CATCH
1309:                 ENDTRY
1310:             ENDIF
1311:         ENDIF
1312:     ENDPROC
1313: 
1314:     *==========================================================================
1315:     * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme processamento
1316:     * Form OPERACIONAL nao tem modos INCLUIR/ALTERAR/VISUALIZAR; delega para
1317:     * HabilitarCampos(.T.) para reabilitar tudo apos processamento/erro.
1318:     *==========================================================================
1319:     PROCEDURE AjustarBotoesPorModo()
1320:         THIS.HabilitarCampos(.T.)
1321:     ENDPROC
1322: 
1323:     *==========================================================================
1324:     * BtnBuscarClick - Alias para AbrirBuscaProduto (usado pelo padrao CRUD)
1325:     * Form OPERACIONAL: nao tem botao Buscar visivel; disponivel para atalho
1326:     * externo que dispare o lookup de produto.
1327:     *==========================================================================
1328:     PROCEDURE BtnBuscarClick()
1329:         THIS.AbrirBuscaProduto()
1330:     ENDPROC
1331: 
1332:     *==========================================================================
1333:     * BtnEncerrarClick - Alias para BtnSairClick (padrao canonico Encerrar)
1334:     *==========================================================================
1335:     PROCEDURE BtnEncerrarClick()
1336:         THIS.BtnSairClick()
1337:     ENDPROC
1338: 
1339:     *==========================================================================
1340:     * BtnSalvarClick - Delega para BtnProcessarClick
1341:     * Form OPERACIONAL: a acao principal (equivalente a "salvar") eh executar a
1342:     * substituicao de referencias em todos os arquivos configurados.
1343:     *==========================================================================
1344:     PROCEDURE BtnSalvarClick()
1345:         THIS.BtnProcessarClick()
1346:     ENDPROC
1347: 
1348:     *==========================================================================
1349:     * BtnCancelarClick - Cancela pares digitados e reseta csContas
1350:     * Confirma antes se ja existem pares preenchidos para evitar perda acidental.
1351:     *==========================================================================
1352:     PROCEDURE BtnCancelarClick()
1353:         LOCAL loc_lTemDados
1354:         loc_lTemDados = .F.
1355: 
1356:         IF USED("csContas")
1357:             SELECT csContas
1358:             LOCATE FOR !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) OR ;
1359:                 !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
1360:             loc_lTemDados = FOUND()
1361:         ENDIF
1362: 
1363:         IF loc_lTemDados
1364:             IF !MsgConfirma("Descartar os pares informados?", ;
1365:                     "Cancelar Substitui" + CHR(231) + CHR(227) + "o")
1366:                 RETURN
1367:             ENDIF
1368:         ENDIF
1369: 
1370:         THIS.LimparCampos()
1371:     ENDPROC
1372: 
1373: ENDDEFINE


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

