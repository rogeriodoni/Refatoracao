# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Itens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Itens.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrPcp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1144 linhas total):

*-- Linhas 3 a 25:
3: * Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
4: * Migrado de: SIGPRPCP.SCX
5: * Fase 8/8 - COMPLETO: Todos os metodos implementados
6: *
7: * OBJETOS MIGRADOS (100%):
8: *   cnt_4c_Sombra + lbl_4c_Sombra + lbl_4c_Titulo  (cntSombra do legado)
9: *   grd_4c_Dados  (Grade 6 colunas - grade principal de selecao)
10: *   grd_4c_Itens  (GradeItem 4 colunas - itens da OP selecionada)
11: *   cmd_4c_Confirmar (Salva), cmd_4c_Cancelar (Sair)
12: *   txt_4c_Info (Text1 - identificacao da OP), lbl_4c_Cliente, txt_4c_Cliente
13: *   lbl_4c_Ordenacao, cbo_4c_Ordenacao (Cmb_Concilia - ordenacao da grade)
14: *   lbl_4c_TabDica (Label1 - dica TAB)
15: *   shp_4c_Shape4 + img_4c_FigJpg (foto do produto - Visible=.F. por padrao)
16: *
17: * NOTA: Nenhum campo de lookup (F4/F5) - original tem todos os campos
18: * somente-leitura ou preenchidos programaticamente via AfterRowColChange.
19: * Os uticos campos editaveis sao Column1 (Priors) da grade principal.
20: *==============================================================================
21: 
22: DEFINE CLASS FormSigPrPcp AS FormBase
23: 
24:     *-- Propriedades visuais (copiadas exatamente do original SIGPRPCP)
25:     Height       = 600

*-- Linhas 45 a 103:
45:     this_cArquivoTempImg = ""
46: 
47:     *==========================================================================
48:     PROCEDURE Init()
49:     *==========================================================================
50:         *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4)
51:         SET DATE TO BRITISH
52:         SET CENTURY ON
53:         RETURN DODEFAULT()
54:     ENDPROC
55: 
56:     *==========================================================================
57:     PROTECTED PROCEDURE InicializarForm
58:     *==========================================================================
59:         LOCAL loc_lSucesso, loc_oErro
60:         loc_lSucesso = .F.
61: 
62:         TRY
63:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrPcpBO")
64:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
65:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrPcpBO.", "Erro")
66:             ELSE
67:                 THIS.this_cArquivoTempImg = SYS(2023) + "\SigPrPcp.jpg"
68: 
69:                 IF !THIS.this_oBusinessObject.ObterConfiguracaoPam()
70:                     MsgErro("Falha ao carregar configura" + CHR(231) + CHR(227) + "o do sistema (SigCdPam).", "Erro")
71:                 ELSE
72:                     *-- Criar cursor base para dados PCP (zTmppPcp do legado)
73:                     SET NULL ON
74:                     CREATE CURSOR cursor_4c_PcpDados ( ;
75:                         Priors    N(6)    NULL, ;
76:                         Nenvs     N(10)   NULL, ;
77:                         Nops      N(10)   NULL, ;
78:                         Emps      C(3)    NULL, ;
79:                         Dopes     C(20)   NULL, ;
80:                         Numes     N(6)    NULL, ;
81:                         Contas    C(10)   NULL, ;
82:                         Rclis     C(40)   NULL, ;
83:                         PrazoEnts T       NULL, ;
84:                         Cpros     C(14)   NULL, ;
85:                         Qtds      N(9,3)  NULL, ;
86:                         aPriors   N(6)    NULL  ;
87:                     )
88:                     SET NULL OFF
89: 
90:                     IF !THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
91:                         MsgErro("Erro no Processamento dos Dados...", "Erro")
92:                     ELSE
93:                         *-- Criar cursor de selecao consolidado (zTmpSelecao do legado)
94:                         SET NULL ON
95:                         SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
96:                                         PrazoEnts, Priors, aPriors ;
97:                             FROM cursor_4c_PcpDados ;
98:                             INTO CURSOR cursor_4c_Selecao READWRITE
99:                         SET NULL OFF
100: 
101:                         *-- Indexar cursor de selecao para ordenacao
102:                         SELECT cursor_4c_Selecao
103:                         INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum

*-- Linhas 124 a 296:
124:                         THIS.ConfigurarPaginaDados()
125:                         THIS.ConfigurarControlesAuxiliares()
126:                         THIS.ConfigurarImagemProduto()
127:                         THIS.TornarControlesVisiveis()
128: 
129:                         *-- Propagar titulo para labels do cabecalho
130:                         THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
131:                         THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
132: 
133:                         *-- Carregar dados nos grids e vincular eventos
134:                         THIS.CarregarGrades()
135:                         THIS.VincularEventos()
136: 
137:                         loc_lSucesso = .T.
138:                     ENDIF
139:                 ENDIF
140:             ENDIF
141:         CATCH TO loc_oErro
142:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
143:                     " PROC=" + loc_oErro.Procedure, ;
144:                     "Erro FormSigPrPcp.InicializarForm")
145:         ENDTRY
146: 
147:         RETURN loc_lSucesso
148:     ENDPROC
149: 
150:     *==========================================================================
151:     * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
152:     *==========================================================================
153:     PROTECTED PROCEDURE ConfigurarPageFrame
154:         THIS.Picture      = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
155:         THIS.ClipControls = .F.
156:     ENDPROC
157: 
158:     *==========================================================================
159:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra do legado)
160:     *==========================================================================
161:     PROTECTED PROCEDURE ConfigurarCabecalho
162:         THIS.AddObject("cnt_4c_Sombra", "Container")
163:         WITH THIS.cnt_4c_Sombra
164:             .Visible     = .T.
165:             .Top         = 0
166:             .Left        = 0
167:             .Width       = THIS.Width
168:             .Height      = 80
169:             .BorderWidth = 0
170:             .BackColor   = RGB(100,100,100)
171:         ENDWITH
172:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
173:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
174:             .FontBold      = .T.
175:             .FontName      = "Tahoma"
176:             .FontSize      = 18
177:             .FontUnderline = .F.
178:             .WordWrap      = .T.
179:             .Alignment     = 0
180:             .AutoSize      = .F.
181:             .BackStyle     = 0
182:             .Caption       = THIS.Caption
183:             .Height        = 40
184:             .Left          = 10
185:             .Top           = 18
186:             .Width         = THIS.Width
187:             .ForeColor     = RGB(0,0,0)
188:             .Visible       = .T.
189:         ENDWITH
190:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
191:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
192:             .FontBold   = .T.
193:             .FontName   = "Tahoma"
194:             .FontSize   = 18
195:             .WordWrap   = .T.
196:             .Alignment  = 0
197:             .AutoSize   = .F.
198:             .BackStyle  = 0
199:             .Caption    = THIS.Caption
200:             .Height     = 46
201:             .Left       = 10
202:             .Top        = 17
203:             .Width      = THIS.Width
204:             .ForeColor  = RGB(255,255,255)
205:             .Visible    = .T.
206:         ENDWITH
207:     ENDPROC
208: 
209:     *==========================================================================
210:     * TornarControlesVisiveis - Torna controles do form visiveis recursivamente
211:     * NOTA: img_4c_FigJpg e shp_4c_Shape4 sao excluidos (Visible=.F. por default)
212:     *==========================================================================
213:     PROTECTED PROCEDURE TornarControlesVisiveis
214:         LOCAL loc_nI, loc_oObj
215:         FOR loc_nI = 1 TO THIS.ControlCount
216:             loc_oObj = THIS.Controls(loc_nI)
217:             IF VARTYPE(loc_oObj) = "O"
218:                 IF INLIST(UPPER(loc_oObj.Name), "IMG_4C_FIGJPG", "SHP_4C_SHAPE4")
219:                     THIS.TornarSubControlesVisiveis(loc_oObj)
220:                     LOOP
221:                 ENDIF
222:                 IF PEMSTATUS(loc_oObj, "Visible", 5)
223:                     loc_oObj.Visible = .T.
224:                 ENDIF
225:                 IF PEMSTATUS(loc_oObj, "ControlCount", 5) AND loc_oObj.ControlCount > 0
226:                     THIS.TornarSubControlesVisiveis(loc_oObj)
227:                 ENDIF
228:             ENDIF
229:         ENDFOR
230:     ENDPROC
231: 
232:     *==========================================================================
233:     * TornarSubControlesVisiveis - Recursao interna de TornarControlesVisiveis
234:     *==========================================================================
235:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
236:         LOCAL loc_nI, loc_oObj
237:         FOR loc_nI = 1 TO par_oContainer.ControlCount
238:             loc_oObj = par_oContainer.Controls(loc_nI)
239:             IF VARTYPE(loc_oObj) = "O"
240:                 IF PEMSTATUS(loc_oObj, "Visible", 5)
241:                     loc_oObj.Visible = .T.
242:                 ENDIF
243:                 IF PEMSTATUS(loc_oObj, "ControlCount", 5) AND loc_oObj.ControlCount > 0
244:                     THIS.TornarSubControlesVisiveis(loc_oObj)
245:                 ENDIF
246:             ENDIF
247:         ENDFOR
248:     ENDPROC
249: 
250:     *==========================================================================
251:     * ConfigurarPaginaLista - Monta a "lista" (grade principal Dados + grade Itens
252:     * + container de botoes de acao) equivalente a Page1 do padrao CRUD.
253:     * Em forms OPERACIONAIS sem PageFrame, este metodo consolida a configuracao
254:     * da area principal de trabalho (grids + botoes canonicos Confirmar/Sair).
255:     *==========================================================================
256:     PROTECTED PROCEDURE ConfigurarPaginaLista
257:         *-- Grade principal (Grade do legado) - lado esquerdo, 6 colunas
258:         THIS.AddObject("grd_4c_Dados", "Grid")
259:         WITH THIS.grd_4c_Dados
260:             .Top           = 110
261:             .Left          = 0
262:             .Width         = 469
263:             .Height        = 398
264:             .ColumnCount   = 6
265:             .FontName      = "Tahoma"
266:             .FontSize      = 8
267:             .DeleteMark    = .F.
268:             .RecordMark    = .F.
269:             .ReadOnly      = .T.
270:             .RowHeight     = 16
271:             .ScrollBars    = 2
272:             .GridLineColor = RGB(238,238,238)
273:             .Visible       = .T.
274: 
275:             WITH .Column1
276:                 .Width             = 50
277:                 .Movable           = .F.
278:                 .Resizable         = .F.
279:                 .ReadOnly          = .F.
280:                 .Header1.Caption   = "Prioridade"
281:                 .Header1.Alignment = 2
282:                 .Header1.ForeColor = RGB(0,0,0)
283:                 .Text1.InputMask   = "999999"
284:                 .Text1.BorderStyle = 0
285:                 .Text1.Margin      = 0
286:                 .Text1.ForeColor   = RGB(0,0,0)
287:                 .Text1.BackColor   = RGB(255,255,255)
288:             ENDWITH
289: 
290:             WITH .Column2
291:                 .Width             = 31
292:                 .Movable           = .F.
293:                 .Resizable         = .F.
294:                 .ReadOnly          = .T.
295:                 .Header1.Caption   = "Emp"
296:                 .Header1.Alignment = 2

*-- Linhas 357 a 378:
357:                 .Text1.BackColor   = RGB(255,255,255)
358:             ENDWITH
359:         ENDWITH
360: 
361:         *-- Grade de itens (GradeItem do legado) - lado direito, 4 colunas
362:         THIS.AddObject("grd_4c_Itens", "Grid")
363:         WITH THIS.grd_4c_Itens
364:             .Top           = 131
365:             .Left          = 470
366:             .Width         = 329
367:             .Height        = 325
368:             .ColumnCount   = 4
369:             .FontName      = "Tahoma"
370:             .FontSize      = 8
371:             .DeleteMark    = .F.
372:             .RecordMark    = .F.
373:             .ReadOnly      = .T.
374:             .RowHeight     = 16
375:             .ScrollBars    = 2
376:             .GridLineColor = RGB(238,238,238)
377:             .Visible       = .T.
378: 

*-- Linhas 438 a 481:
438:     *==========================================================================
439:     * ConfigurarBotoes - Cria botoes Confirmar e Cancelar
440:     *==========================================================================
441:     PROTECTED PROCEDURE ConfigurarBotoes
442:         *-- Botao Confirmar (Salva do legado)
443:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
444:         WITH THIS.cmd_4c_Confirmar
445:             .Top        = 3
446:             .Left       = 650
447:             .Height     = 75
448:             .Width      = 75
449:             .FontBold   = .T.
450:             .FontItalic = .T.
451:             .FontName   = "Comic Sans MS"
452:             .FontSize   = 8
453:             .WordWrap   = .F.
454:             .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
455:             .Caption    = "Confirmar"
456:             .ForeColor  = RGB(90,90,90)
457:             .BackColor  = RGB(255,255,255)
458:             .Themes           = .T.
459:             .Visible    = .T.
460:         ENDWITH
461: 
462:         *-- Botao Cancelar/Sair (Sair do legado)
463:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
464:         WITH THIS.cmd_4c_Cancelar
465:             .Top        = 3
466:             .Left       = 725
467:             .Height     = 75
468:             .Width      = 75
469:             .FontBold   = .T.
470:             .FontItalic = .T.
471:             .FontName   = "Comic Sans MS"
472:             .FontSize   = 8
473:             .WordWrap   = .F.
474:             .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
475:             .Cancel     = .T.
476:             .Caption    = "Encerrar"
477:             .ForeColor  = RGB(90,90,90)
478:             .BackColor  = RGB(255,255,255)
479:             .Themes           = .T.
480:             .Visible    = .T.
481:         ENDWITH

*-- Linhas 487 a 530:
487:     * agrupa os controles de exibicao de contexto da operacao selecionada:
488:     * txt_4c_Info (identificacao da OP), lbl_4c_Cliente e txt_4c_Cliente.
489:     *==========================================================================
490:     PROTECTED PROCEDURE ConfigurarPaginaDados
491:         *-- Caixa de identificacao da operacao selecionada (Text1 do legado)
492:         *-- Exibe: "EMP OPERACAO NUMES" ao navegar na grade principal
493:         THIS.AddObject("txt_4c_Info", "TextBox")
494:         WITH THIS.txt_4c_Info
495:             .Top         = 110
496:             .Left        = 470
497:             .Width       = 329
498:             .Height      = 21
499:             .FontBold    = .T.
500:             .FontName    = "Tahoma"
501:             .FontSize    = 8
502:             .Alignment   = 2
503:             .ForeColor   = RGB(0,0,0)
504:             .BackColor   = RGB(0,128,255)
505:             .ReadOnly    = .T.
506:             .BorderStyle = 0
507:             .Value       = ""
508:             .Visible     = .T.
509:         ENDWITH
510: 
511:         *-- Label "Cliente" (Say3 do legado)
512:         THIS.AddObject("lbl_4c_Cliente", "Label")
513:         WITH THIS.lbl_4c_Cliente
514:             .AutoSize   = .T.
515:             .FontBold   = .F.
516:             .FontItalic = .F.
517:             .FontName   = "Tahoma"
518:             .FontSize   = 8
519:             .BackStyle  = 0
520:             .Caption    = "Cliente"
521:             .Left       = 23
522:             .Top        = 515
523:             .ForeColor  = RGB(90,90,90)
524:             .Visible    = .T.
525:         ENDWITH
526: 
527:         *-- Caixa do cliente (Get_Cliente do legado - somente leitura, preenchida via Grade)
528:         THIS.AddObject("txt_4c_Cliente", "TextBox")
529:         WITH THIS.txt_4c_Cliente
530:             .FontBold    = .T.

*-- Linhas 546 a 589:
546:     *==========================================================================
547:     * ConfigurarControlesAuxiliares - Cria controles de filtros e ordenacao
548:     *==========================================================================
549:     PROTECTED PROCEDURE ConfigurarControlesAuxiliares
550:         *-- Label "Ordenacao" (lbl_lancamentos do legado)
551:         THIS.AddObject("lbl_4c_Ordenacao", "Label")
552:         WITH THIS.lbl_4c_Ordenacao
553:             .AutoSize   = .T.
554:             .FontBold   = .F.
555:             .FontItalic = .F.
556:             .FontName   = "Tahoma"
557:             .FontSize   = 8
558:             .BackStyle  = 0
559:             .Caption    = "Ordena" + CHR(231) + CHR(227) + "o :"
560:             .Left       = 16
561:             .Top        = 545
562:             .ForeColor  = RGB(90,90,90)
563:             .Visible    = .T.
564:         ENDWITH
565: 
566:         *-- ComboBox de ordenacao (Cmb_Concilia do legado)
567:         THIS.AddObject("cbo_4c_Ordenacao", "ComboBox")
568:         WITH THIS.cbo_4c_Ordenacao
569:             .FontName      = "Tahoma"
570:             .FontSize      = 8
571:             .RowSourceType = 0
572:             .Style         = 2
573:             .Height        = 24
574:             .Left          = 80
575:             .Top           = 540
576:             .Width         = 140
577:             .Visible       = .T.
578:         ENDWITH
579: 
580:         *-- Label de dica TAB (Label1 do legado)
581:         THIS.AddObject("lbl_4c_TabDica", "Label")
582:         WITH THIS.lbl_4c_TabDica
583:             .AutoSize   = .T.
584:             .FontBold   = .F.
585:             .FontItalic = .F.
586:             .FontName   = "Tahoma"
587:             .FontSize   = 8
588:             .BackStyle  = 0
589:             .Caption    = "[ < TAB > para mudar de Grade ] "

*-- Linhas 597 a 943:
597:     *==========================================================================
598:     * ConfigurarImagemProduto - Cria shape e imagem do produto (ocultos por padrao)
599:     *==========================================================================
600:     PROTECTED PROCEDURE ConfigurarImagemProduto
601:         *-- Shape de fundo (Shape4 do legado)
602:         THIS.AddObject("shp_4c_Shape4", "Shape")
603:         WITH THIS.shp_4c_Shape4
604:             .Top         = 461
605:             .Left        = 480
606:             .Width       = 148
607:             .Height      = 109
608:             .BackStyle   = 0
609:             .BorderColor = RGB(90,90,90)
610:             .Visible     = .F.
611:         ENDWITH
612: 
613:         *-- Imagem do produto (FigJpg do legado)
614:         THIS.AddObject("img_4c_FigJpg", "Image")
615:         WITH THIS.img_4c_FigJpg
616:             .Stretch = 1
617:             .Top     = 463
618:             .Left    = 483
619:             .Width   = 143
620:             .Height  = 105
621:             .Visible = .F.
622:         ENDWITH
623:     ENDPROC
624: 
625:     *==========================================================================
626:     * CarregarGrades - Configura RecordSource/ControlSource e popula combo
627:     *==========================================================================
628:     PROTECTED PROCEDURE CarregarGrades
629:         LOCAL loc_lSucesso, loc_oErro
630:         loc_lSucesso = .F.
631: 
632:         TRY
633:             IF !USED("cursor_4c_Selecao") OR !USED("cursor_4c_PcpDados")
634:                 MsgErro("Cursores de dados n" + CHR(227) + "o inicializados.", "Erro")
635:             ELSE
636:                 *-- Vincular grade principal ao cursor de selecao
637:                 WITH THIS.grd_4c_Dados
638:                     .ColumnCount           = 6
639:                     .RecordSource          = "cursor_4c_Selecao"
640:                     .Column1.ControlSource = "cursor_4c_Selecao.Priors"
641:                     .Column2.ControlSource = "cursor_4c_Selecao.Emps"
642:                     .Column3.ControlSource = "cursor_4c_Selecao.Dopes"
643:                     .Column4.ControlSource = "cursor_4c_Selecao.Numes"
644:                     .Column5.ControlSource = "cursor_4c_Selecao.Contas"
645:                     .Column6.ControlSource = "cursor_4c_Selecao.PrazoEnts"
646:                     .Refresh()
647:                 ENDWITH
648: 
649:                 *-- Vincular grade de itens ao cursor de dados PCP
650:                 WITH THIS.grd_4c_Itens
651:                     .ColumnCount           = 4
652:                     .RecordSource          = "cursor_4c_PcpDados"
653:                     .Column1.ControlSource = "cursor_4c_PcpDados.Nenvs"
654:                     .Column2.ControlSource = "cursor_4c_PcpDados.Nops"
655:                     .Column3.ControlSource = "cursor_4c_PcpDados.Cpros"
656:                     .Column4.ControlSource = "cursor_4c_PcpDados.Qtds"
657:                     .Refresh()
658:                 ENDWITH
659: 
660:                 *-- Popular combo de ordenacao (itens sem acento, como no legado)
661:                 WITH THIS.cbo_4c_Ordenacao
662:                     .Clear()
663:                     .AddItem("Operacao")
664:                     .AddItem("Cliente")
665:                     .AddItem("Prazo Entrega")
666:                     .AddItem("Prioridade")
667:                     .Value = "Prazo Entrega"
668:                 ENDWITH
669: 
670:                 *-- Posicionar e atualizar painel de info
671:                 SELECT cursor_4c_PcpDados
672:                 GO TOP
673:                 SELECT cursor_4c_Selecao
674:                 GO TOP
675:                 THIS.grd_4c_Dados.SetFocus()
676:                 THIS.GrdDadosAfterRowColChange(1)
677: 
678:                 loc_lSucesso = .T.
679:             ENDIF
680:         CATCH TO loc_oErro
681:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
682:                     " PROC=" + loc_oErro.Procedure, ;
683:                     "Erro FormSigPrPcp.CarregarGrades")
684:         ENDTRY
685: 
686:         RETURN loc_lSucesso
687:     ENDPROC
688: 
689:     *==========================================================================
690:     * VincularEventos - Estabelece BINDEVENTs para eventos dos controles
691:     *==========================================================================
692:     PROTECTED PROCEDURE VincularEventos
693:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
694:         BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GrdItensAfterRowColChange")
695:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdDadosCol1LostFocus")
696:         BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "KeyPress", THIS, "GrdItensCol1LostFocus")
697:         BINDEVENT(THIS.cbo_4c_Ordenacao, "InteractiveChange", THIS, "CboOrdenacaoInteractiveChange")
698:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
699:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
700:     ENDPROC
701: 
702:     *==========================================================================
703:     * AlternarPagina - Alterna foco entre a grade principal (1) e a grade de
704:     * itens (2). Em OPERACIONAL sem PageFrame, este metodo cumpre o papel do
705:     * <TAB> descrito no rodape do form legado ("[ <TAB> para mudar de Grade ]").
706:     *==========================================================================
707:     PROCEDURE AlternarPagina(par_nPagina)
708:         LOCAL loc_nPagina
709:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
710:         DO CASE
711:             CASE loc_nPagina = 1
712:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
713:                     THIS.grd_4c_Dados.SetFocus()
714:                     THIS.grd_4c_Dados.Refresh()
715:                 ENDIF
716:             CASE loc_nPagina = 2
717:                 IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
718:                     THIS.grd_4c_Itens.SetFocus()
719:                     THIS.grd_4c_Itens.Refresh()
720:                 ENDIF
721:         ENDCASE
722:     ENDPROC
723: 
724:     *==========================================================================
725:     * GrdDadosAfterRowColChange - Atualiza paineis ao mudar linha na grade principal
726:     *==========================================================================
727:     PROCEDURE GrdDadosAfterRowColChange
728:         LPARAMETERS par_nColIndex
729:         IF !USED("cursor_4c_Selecao")
730:             RETURN
731:         ENDIF
732:         THIS.LockScreen = .T.
733:         SELECT cursor_4c_Selecao
734:         THIS.txt_4c_Cliente.Value = NVL(cursor_4c_Selecao.Rclis, "")
735:         THIS.txt_4c_Cliente.Refresh()
736:         SELECT cursor_4c_PcpDados
737:         GO TOP
738:         THIS.grd_4c_Itens.Refresh()
739:         THIS.img_4c_FigJpg.Visible = .F.
740:         THIS.img_4c_FigJpg.Picture = ""
741:         SELECT cursor_4c_Selecao
742:         THIS.txt_4c_Info.Value = NVL(cursor_4c_Selecao.Emps, "") + " " + ;
743:             ALLTRIM(NVL(cursor_4c_Selecao.Dopes, "")) + " " + ;
744:             STR(NVL(cursor_4c_Selecao.Numes, 0), 6)
745:         THIS.LockScreen = .F.
746:     ENDPROC
747: 
748:     *==========================================================================
749:     * GrdItensAfterRowColChange - Carrega foto do produto ao mudar linha nos itens
750:     *==========================================================================
751:     PROCEDURE GrdItensAfterRowColChange
752:         LPARAMETERS par_nColIndex
753:         LOCAL loc_cCpros
754:         IF !USED("cursor_4c_PcpDados")
755:             RETURN
756:         ENDIF
757:         THIS.LockScreen = .T.
758:         THIS.img_4c_FigJpg.Visible = .F.
759:         THIS.img_4c_FigJpg.Picture = ""
760:         THIS.shp_4c_Shape4.Visible = .F.
761:         SELECT cursor_4c_PcpDados
762:         IF !EOF("cursor_4c_PcpDados")
763:             loc_cCpros = NVL(cursor_4c_PcpDados.Cpros, "")
764:             IF !EMPTY(loc_cCpros)
765:                 IF THIS.this_oBusinessObject.ObterImagemProduto(loc_cCpros, THIS.this_cArquivoTempImg)
766:                     THIS.img_4c_FigJpg.Picture = THIS.this_cArquivoTempImg
767:                     THIS.img_4c_FigJpg.Visible = .T.
768:                     THIS.shp_4c_Shape4.Visible = .T.
769:                 ENDIF
770:             ENDIF
771:         ENDIF
772:         SELECT cursor_4c_PcpDados
773:         THIS.LockScreen = .F.
774:     ENDPROC
775: 
776:     *==========================================================================
777:     * GrdDadosCol1LostFocus - TAB na coluna Prioridade salta para grade de itens
778:     *==========================================================================
779:     PROCEDURE GrdDadosCol1LostFocus
780:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
781:         IF LASTKEY() = 9
782:             THIS.grd_4c_Itens.SetFocus()
783:         ENDIF
784:     ENDPROC
785: 
786:     *==========================================================================
787:     * GrdItensCol1LostFocus - TAB na coluna Envelope retorna para grade principal
788:     *==========================================================================
789:     PROCEDURE GrdItensCol1LostFocus
790:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
791:         IF LASTKEY() = 9
792:             THIS.grd_4c_Dados.SetFocus()
793:         ENDIF
794:     ENDPROC
795: 
796:     *==========================================================================
797:     * CboOrdenacaoInteractiveChange - Reordena grade principal ao mudar combo
798:     *==========================================================================
799:     PROCEDURE CboOrdenacaoInteractiveChange
800:         IF !USED("cursor_4c_Selecao")
801:             RETURN
802:         ENDIF
803:         SELECT cursor_4c_Selecao
804:         SET RELATION TO
805:         SET ORDER TO
806:         DO CASE
807:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prazo Entrega"
808:                 SET ORDER TO Entrega
809:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Cliente"
810:                 SET ORDER TO Cliente
811:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Operacao"
812:                 SET ORDER TO EmpDopNum
813:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prioridade"
814:                 SET ORDER TO Prioridade
815:         ENDCASE
816:         SELECT cursor_4c_Selecao
817:         SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
818:         THIS.grd_4c_Dados.Refresh()
819:     ENDPROC
820: 
821:     *==========================================================================
822:     * BtnConfirmarClick - Grava prioridades no banco (Salva.Click do legado)
823:     *==========================================================================
824:     PROCEDURE BtnConfirmarClick
825:         IF !USED("cursor_4c_Selecao")
826:             MsgAviso("Dados de sele" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "veis.")
827:             RETURN
828:         ENDIF
829:         IF !MsgConfirma("Confirma Grava" + CHR(231) + CHR(227) + "o dos Dados!!!")
830:             RETURN
831:         ENDIF
832:         IF THIS.this_oBusinessObject.GravarPrioridades("cursor_4c_Selecao")
833:             THIS.Release()
834:         ENDIF
835:     ENDPROC
836: 
837:     *==========================================================================
838:     * BtnCancelarClick - Confirma abandono da priorizacao (Sair.Click do legado)
839:     *==========================================================================
840:     PROCEDURE BtnCancelarClick
841:         IF MsgConfirma("Deseja Realmente abandonar Prioriza" + CHR(231) + CHR(227) + "o")
842:             THIS.Release()
843:         ENDIF
844:     ENDPROC
845: 
846:     *==========================================================================
847:     * BtnIncluirClick - Ativa edicao de prioridades (foco na grade principal)
848:     * Mapeamento OPERACIONAL: "incluir" = iniciar entrada de dados de prioridade
849:     * na coluna Priors da grade principal, posicionando no topo da lista.
850:     *==========================================================================
851:     PROCEDURE BtnIncluirClick()
852:         LOCAL loc_oErro
853:         TRY
854:             IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
855:                 MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
856:                          "es para priorizar.", "Aviso")
857:                 RETURN
858:             ENDIF
859:             SELECT cursor_4c_Selecao
860:             GO TOP
861:             THIS.grd_4c_Dados.Refresh()
862:             THIS.GrdDadosAfterRowColChange(1)
863:             THIS.grd_4c_Dados.SetFocus()
864:             THIS.grd_4c_Dados.ActivateCell(1, 1)
865:         CATCH TO loc_oErro
866:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
867:                     "Erro BtnIncluir")
868:         ENDTRY
869:     ENDPROC
870: 
871:     *==========================================================================
872:     * BtnAlterarClick - Edita prioridade da linha selecionada na grade principal
873:     * Mapeamento OPERACIONAL: "alterar" = editar a coluna Priors da linha corrente
874:     *==========================================================================
875:     PROCEDURE BtnAlterarClick()
876:         LOCAL loc_oErro, loc_nLinha
877:         TRY
878:             IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
879:                 MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
880:                          "es para alterar.", "Aviso")
881:                 RETURN
882:             ENDIF
883:             SELECT cursor_4c_Selecao
884:             IF EOF() OR BOF()
885:                 GO TOP
886:             ENDIF
887:             loc_nLinha = THIS.grd_4c_Dados.RelativeRow
888:             IF loc_nLinha < 1
889:                 loc_nLinha = 1
890:             ENDIF
891:             THIS.grd_4c_Dados.SetFocus()
892:             THIS.grd_4c_Dados.ActivateCell(loc_nLinha, 1)
893:         CATCH TO loc_oErro
894:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
895:                     "Erro BtnAlterar")
896:         ENDTRY
897:     ENDPROC
898: 
899:     *==========================================================================
900:     * BtnVisualizarClick - Recarrega/reprocessa dados dos grids do zero
901:     * Mapeamento OPERACIONAL: "visualizar" = refresh completo (reprocessa PCP)
902:     *==========================================================================
903:     PROCEDURE BtnVisualizarClick()
904:         LOCAL loc_oErro
905:         TRY
906:             IF !MsgConfirma("Recarregar todos os dados descarta as altera" + ;
907:                             CHR(231) + CHR(245) + "es n" + CHR(227) + "o gravadas." + ;
908:                             CHR(13) + "Confirma?")
909:                 RETURN
910:             ENDIF
911:             THIS.LockScreen = .T.
912: 
913:             *-- Encerrar relacao e cursores para reprocessar
914:             IF USED("cursor_4c_Selecao")
915:                 SELECT cursor_4c_Selecao
916:                 SET RELATION TO
917:                 USE IN cursor_4c_Selecao
918:             ENDIF
919:             IF USED("cursor_4c_PcpDados")
920:                 USE IN cursor_4c_PcpDados
921:             ENDIF
922: 
923:             *-- Recriar cursor base
924:             SET NULL ON
925:             CREATE CURSOR cursor_4c_PcpDados ( ;
926:                 Priors    N(6)    NULL, ;
927:                 Nenvs     N(10)   NULL, ;
928:                 Nops      N(10)   NULL, ;
929:                 Emps      C(3)    NULL, ;
930:                 Dopes     C(20)   NULL, ;
931:                 Numes     N(6)    NULL, ;
932:                 Contas    C(10)   NULL, ;
933:                 Rclis     C(40)   NULL, ;
934:                 PrazoEnts T       NULL, ;
935:                 Cpros     C(14)   NULL, ;
936:                 Qtds      N(9,3)  NULL, ;
937:                 aPriors   N(6)    NULL  ;
938:             )
939:             SET NULL OFF
940: 
941:             IF THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
942:                 *-- Recriar cursor de selecao consolidado
943:                 SET NULL ON

*-- Linhas 982 a 1144:
982:     * BtnExcluirClick - Zera prioridade da linha selecionada (Priors = 0)
983:     * Mapeamento OPERACIONAL: "excluir" = remover a prioridade (voltar ao default)
984:     *==========================================================================
985:     PROCEDURE BtnExcluirClick()
986:         LOCAL loc_oErro
987:         TRY
988:             IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
989:                 MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
990:                          "es para atualizar.", "Aviso")
991:                 RETURN
992:             ENDIF
993:             SELECT cursor_4c_Selecao
994:             IF EOF() OR BOF()
995:                 MsgAviso("Selecione uma linha na grade antes de zerar a prioridade.", ;
996:                          "Aviso")
997:                 RETURN
998:             ENDIF
999:             IF NVL(cursor_4c_Selecao.Priors, 0) = 0
1000:                 MsgAviso("A prioridade desta opera" + CHR(231) + CHR(227) + ;
1001:                          "o j" + CHR(225) + " est" + CHR(225) + " zerada.", "Aviso")
1002:                 RETURN
1003:             ENDIF
1004:             IF !MsgConfirma("Zerar prioridade da opera" + CHR(231) + CHR(227) + "o selecionada?")
1005:                 RETURN
1006:             ENDIF
1007:             REPLACE cursor_4c_Selecao.Priors WITH 0
1008:             THIS.grd_4c_Dados.Refresh()
1009:             THIS.GrdDadosAfterRowColChange(1)
1010:         CATCH TO loc_oErro
1011:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1012:                     "Erro BtnExcluir")
1013:         ENDTRY
1014:     ENDPROC
1015: 
1016:     *==========================================================================
1017:     * CarregarLista - Recarrega os grids (wrapper publico de CarregarGrades)
1018:     *==========================================================================
1019:     PROCEDURE CarregarLista()
1020:         THIS.CarregarGrades()
1021:     ENDPROC
1022: 
1023:     *==========================================================================
1024:     * FormParaBO - Carrega propriedades do BO a partir da linha corrente do cursor
1025:     *==========================================================================
1026:     PROCEDURE FormParaBO()
1027:         IF USED("cursor_4c_Selecao") AND !EOF("cursor_4c_Selecao")
1028:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Selecao")
1029:         ENDIF
1030:     ENDPROC
1031: 
1032:     *==========================================================================
1033:     * BOParaForm - Atualiza controles de exibicao a partir das props do BO
1034:     *==========================================================================
1035:     PROCEDURE BOParaForm()
1036:         LOCAL loc_oBO
1037:         loc_oBO = THIS.this_oBusinessObject
1038:         THIS.txt_4c_Info.Value    = ALLTRIM(loc_oBO.this_cEmps) + " " + ;
1039:                                     ALLTRIM(loc_oBO.this_cDopes) + " " + ;
1040:                                     STR(loc_oBO.this_nNumes, 6)
1041:         THIS.txt_4c_Cliente.Value = loc_oBO.this_cRclis
1042:         THIS.txt_4c_Info.Refresh()
1043:         THIS.txt_4c_Cliente.Refresh()
1044:     ENDPROC
1045: 
1046:     *==========================================================================
1047:     * HabilitarCampos - Habilita/desabilita controles conforme disponibilidade
1048:     *==========================================================================
1049:     PROCEDURE HabilitarCampos()
1050:         LOCAL loc_lTemDados
1051:         loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
1052:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
1053:             THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
1054:         ENDIF
1055:         IF PEMSTATUS(THIS, "cbo_4c_Ordenacao", 5)
1056:             THIS.cbo_4c_Ordenacao.Enabled = loc_lTemDados
1057:         ENDIF
1058:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1059:             THIS.grd_4c_Dados.Enabled = loc_lTemDados
1060:         ENDIF
1061:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1062:             THIS.grd_4c_Itens.Enabled = loc_lTemDados
1063:         ENDIF
1064:     ENDPROC
1065: 
1066:     *==========================================================================
1067:     * LimparCampos - Limpa controles de exibicao e oculta imagem do produto
1068:     *==========================================================================
1069:     PROCEDURE LimparCampos()
1070:         THIS.txt_4c_Info.Value    = ""
1071:         THIS.txt_4c_Cliente.Value = ""
1072:         THIS.img_4c_FigJpg.Visible  = .F.
1073:         THIS.img_4c_FigJpg.Picture  = ""
1074:         THIS.shp_4c_Shape4.Visible  = .F.
1075:     ENDPROC
1076: 
1077:     *==========================================================================
1078:     * AjustarBotoesPorModo - Habilita botao Confirmar apenas se houver dados
1079:     *==========================================================================
1080:     PROCEDURE AjustarBotoesPorModo()
1081:         LOCAL loc_lTemDados
1082:         loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
1083:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
1084:             THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
1085:         ENDIF
1086:     ENDPROC
1087: 
1088:     *==========================================================================
1089:     * BtnBuscarClick - Volta ao topo da grade principal e reposiciona painel
1090:     * Mapeamento OPERACIONAL: "buscar" = posicionar no inicio da lista
1091:     *==========================================================================
1092:     PROCEDURE BtnBuscarClick()
1093:         LOCAL loc_oErro
1094:         TRY
1095:             IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
1096:                 MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + "es para exibir.")
1097:                 RETURN
1098:             ENDIF
1099:             SELECT cursor_4c_Selecao
1100:             GO TOP
1101:             THIS.grd_4c_Dados.Refresh()
1102:             THIS.GrdDadosAfterRowColChange(1)
1103:             THIS.grd_4c_Dados.SetFocus()
1104:         CATCH TO loc_oErro
1105:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1106:                     "Erro BtnBuscar")
1107:         ENDTRY
1108:     ENDPROC
1109: 
1110:     *==========================================================================
1111:     * BtnSalvarClick - Alias de BtnConfirmarClick (padrao FormBase)
1112:     *==========================================================================
1113:     PROCEDURE BtnSalvarClick()
1114:         THIS.BtnConfirmarClick()
1115:     ENDPROC
1116: 
1117:     *==========================================================================
1118:     * BtnEncerrarClick - Alias de BtnCancelarClick (padrao FormBase canonico)
1119:     *==========================================================================
1120:     PROCEDURE BtnEncerrarClick()
1121:         THIS.BtnCancelarClick()
1122:     ENDPROC
1123: 
1124:     *==========================================================================
1125:     PROCEDURE Destroy()
1126:     *==========================================================================
1127:         *-- Encerrar relacao entre cursores antes de fechar
1128:         IF USED("cursor_4c_Selecao")
1129:             SELECT cursor_4c_Selecao
1130:             SET RELATION TO
1131:             USE IN cursor_4c_Selecao
1132:         ENDIF
1133:         IF USED("cursor_4c_PcpDados")
1134:             USE IN cursor_4c_PcpDados
1135:         ENDIF
1136:         *-- Remover arquivo temporario de imagem de produto
1137:         IF !EMPTY(THIS.this_cArquivoTempImg) AND FILE(THIS.this_cArquivoTempImg)
1138:             ERASE (THIS.this_cArquivoTempImg)
1139:         ENDIF
1140:         THIS.this_oBusinessObject = .NULL.
1141:         DODEFAULT()
1142:     ENDPROC
1143: 
1144: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrPcpBO.prg):
*==============================================================================
* SigPrPcpBO.prg - Business Object: Priorizacao de Operacoes para PCP
* Tabela principal: SigMvCab (UPDATE Priors)
* Formulario: FormSigPrPcp.prg
*==============================================================================
DEFINE CLASS SigPrPcpBO AS BusinessBase

    *-- Tabela e chave (alvo do UPDATE de prioridades)
    this_cTabela      = "SigMvCab"
    this_cCampoChave  = "EmpDopNums"

    *-- Parametros de configuracao (lidos de SigCdPam)
    this_cOperacao    = ""   && DoppPads - tipo de operacao para planejamento
    this_cServico     = ""   && DoppServs - tipo de servico para planejamento

    *-- Registro corrente do cursor zTmpSelecao / zTmppPcp
    this_nPriors      = 0    && Priors n(6)   - prioridade atual (editavel)
    this_nNenvs       = 0    && nenvs n(10)   - numero envelope
    this_nNops        = 0    && Nops n(10)    - numero OP (SigPdMvf.NOps)
    this_cEmps        = ""   && Emps c(3)     - codigo empresa
    this_cDopes       = ""   && Dopes c(20)   - codigo operacao
    this_nNumes       = 0    && Numes n(6)    - numero da ordem de producao
    this_cContas      = ""   && Contas c(10)  - codigo conta/cliente (SigCdCli.Iclis)
    this_cRclis       = ""   && Rclis c(40)   - razao social do cliente
    this_tPrazoEnts   = {}   && PrazoEnts T   - prazo de entrega (DateTime)
    this_cCpros       = ""   && Cpros c(14)   - codigo do produto (SigCdPro)
    this_nQtds        = 0    && Qtds n(9,3)   - quantidade da OP
    this_nAPriors     = 0    && aPriors n(6)  - prioridade original antes de editar

    *-- Chave concatenada usada em INDEX e RELATION
    this_cEmpDopNum   = ""   && Emps + Dopes + Str(Numes,6)

    *-- Contexto de processamento (SigCdOpd)
    this_cNivels      = ""   && Nivels - nivel da operacao (SigCdOpd)
    this_nChkDests    = 0    && ChkDests n(1,0) - flag destino (SigCdOpd): 3=ignorar

    *-- Dados do item de grade (SigOpPic + SigMvCab + SigCdOpe)
    this_cContaOs     = ""   && ContaOs c(10) - conta origem (SigMvCab)
    this_cContaDs     = ""   && ContaDs c(10) - conta destino (SigMvCab)
    this_nGlobalizas  = 0    && Globalizas n(1,0) - flag globalizacao (SigCdOpe)
    this_nServicos    = 0    && Servicos n(1,0)   - flag servico (SigCdOpe)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave; chama BusinessBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave concatenada do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterConfiguracaoPam - Le DoppPads e DoppServs de SigCdPam
    * Popula: this_cOperacao, this_cServico
    *--------------------------------------------------------------------------
    FUNCTION ObterConfiguracaoPam()
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select DoppPads, DoppServs From SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cOperacao = ALLTRIM(NVL(DoppPads, ""))
                    THIS.this_cServico  = ALLTRIM(NVL(DoppServs, ""))
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades this_* a partir de cursor
    * par_cAliasCursor: alias do cursor (zTmppPcp ou zTmpSelecao)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nPriors    = NVL(Priors, 0)
            THIS.this_nNenvs     = NVL(Nenvs, 0)
            THIS.this_nNops      = NVL(Nops, 0)
            THIS.this_cEmps      = ALLTRIM(NVL(Emps, ""))
            THIS.this_cDopes     = ALLTRIM(NVL(Dopes, ""))
            THIS.this_nNumes     = NVL(Numes, 0)
            THIS.this_cContas    = ALLTRIM(NVL(Contas, ""))
            THIS.this_cRclis     = ALLTRIM(NVL(Rclis, ""))
            THIS.this_tPrazoEnts = NVL(PrazoEnts, {})
            THIS.this_cCpros     = ALLTRIM(NVL(Cpros, ""))
            THIS.this_nQtds      = NVL(Qtds, 0)
            THIS.this_nAPriors   = NVL(aPriors, 0)
            THIS.this_cEmpDopNum = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - Processa OPs em aberto e popula cursor destino (zTmppPcp)
    * Requer: ObterConfiguracaoPam() chamado antes
    * par_cCursorDestino: cursor criado pelo Form (estrutura zTmppPcp)
    *--------------------------------------------------------------------------
    FUNCTION Processar(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cSQL, loc_oErro, loc_oProg
        LOCAL loc_cEmpresa, loc_lEnvelope, loc_nEnv, loc_cCliente, loc_cRclis
        LOCAL loc_cOpCompara, loc_nPop
        LOCAL loc_nMfasNops, loc_nMfasNenvs, loc_nMfasNumps
        LOCAL loc_nPriors, loc_cEmps, loc_cDopes, loc_nNumes
        LOCAL loc_tPrazoEnts, loc_cCpros, loc_nQtds

        loc_lSucesso  = .F.
        loc_lAbortar  = .F.
        loc_cEmpresa  = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(par_cCursorDestino)
                SELECT (par_cCursorDestino)
                ZAP
            ENDIF

            *-- Buscar OPs em aberto de Operacao (DoppPads) em SigCdNec
            loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                       "Where EmpDNps Between " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + STR(0,10)) + ;
                       " And " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + "9999999999") + ;
                       " And ChkSubn = 0 Order By Numps, Dopps, cIdChaves"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend1") < 1
                loc_lAbortar = .T.
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (OpPendente1)")
            ENDIF

            IF !loc_lAbortar
                *-- Buscar OPs em aberto de Servico (DoppServs) em SigCdNec
                loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                           "Where EmpDNps Between " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + STR(0,10)) + ;
                           " And " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + "9999999999") + ;
                           " And ChkSubn = 0 And 0=1 Order By Numps, Dopps, cIdChaves"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend2") < 1
                    loc_lAbortar = .T.
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (OpPendente2)")
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Unir cursores de Operacao e Servico
                SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend1 ;
                    UNION ALL ;
                    SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend2 ;
                    INTO CURSOR cursor_4c_OpPendente READWRITE

                IF USED("cursor_4c_OpPend1")
                    USE IN cursor_4c_OpPend1
                ENDIF
                IF USED("cursor_4c_OpPend2")
                    USE IN cursor_4c_OpPend2
                ENDIF

                SELECT cursor_4c_OpPendente
                loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Ops ...", RECCOUNT())
                loc_oProg.Show()

                SCAN
                    loc_oProg.Update(.T.)

                    *-- Buscar movimentos de producao (SigPdMvf)
                    loc_cSQL = "Select * From SigPdMvf Where Nops = " + ;
                               FormatarNumeroSQL(cursor_4c_OpPendente.Numps, 0) + ;
                               " Order by Nops, CidChaves desc"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas")

                    IF !USED("cursor_4c_TmpMfas") OR RECCOUNT("cursor_4c_TmpMfas") = 0
                        IF USED("cursor_4c_TmpMfas")
                            USE IN cursor_4c_TmpMfas
                        ENDIF
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpMfas
                    GO TOP
                    IF EMPTY(NVL(cursor_4c_TmpMfas.GrupoDs, ""))
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    *-- Salvar valores de TmpMfas antes de trocar work area
                    loc_nMfasNops  = NVL(cursor_4c_TmpMfas.Nops, 0)
                    loc_nMfasNenvs = NVL(cursor_4c_TmpMfas.Nenvs, 0)
                    loc_nMfasNumps = NVL(cursor_4c_TmpMfas.Numps, 0)
                    loc_nPop       = loc_nMfasNops

                    loc_cOpCompara = IIF(ALLTRIM(NVL(cursor_4c_OpPendente.Dopps, "")) = ;
                                        ALLTRIM(THIS.this_cOperacao), ;
                                        THIS.this_cOperacao, THIS.this_cServico)

                    *-- Buscar dados da operacao em SigCdOpd
                    loc_cSQL = "Select * From SigCdOpd Where Dopps = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_TmpMfas.Dopps))
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpd")

                    IF !USED("cursor_4c_SigCdOpd") OR RECCOUNT("cursor_4c_SigCdOpd") = 0
                        IF USED("cursor_4c_SigCdOpd")
                            USE IN cursor_4c_SigCdOpd
                        ENDIF
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    SELECT cursor_4c_SigCdOpd
                    IF NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 3
                        USE IN cursor_4c_SigCdOpd
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    loc_lEnvelope = (ALLTRIM(NVL(cursor_4c_SigCdOpd.Nivels, "")) <> ;
                                    ALLTRIM(loc_cOpCompara) OR ;
                                    NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 1)
                    USE IN cursor_4c_SigCdOpd

                    *-- Query principal: SigOpPic + SigMvCab + SigCdOpe agrupados
                    loc_cSQL = "Select a.Nops, Sum(a.Qtds) as Qtds, b.ContaOs, b.ContaDs, " + ;
                               "b.prazoents, b.empdopNums, b.priors, b.Emps, b.Dopes, b.Numes, " + ;
                               "c.Globalizas, c.Servicos, a.cpros " + ;
                               "From SigOpPic a, SigMvCab b, SigCdOpe c " + ;
                               "Where a.Nops = " + FormatarNumeroSQL(loc_nPop, 0) + ;
                               " And a.EmpDopNums = b.EmpDopNums " + ;
                               "And b.Dopes = c.Dopes " + ;
                               "Group by a.Nops, b.ContaOs, b.ContaDs, b.prazoents, " + ;
                               "b.empdopnums, b.priors, b.emps, b.dopes, " + ;
                               "b.numes, c.globalizas, c.Servicos, a.cpros"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi") < 1
                        USE IN cursor_4c_TmpMfas
                        loc_lAbortar = .T.
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (crTmpOpi)")
                        EXIT
                    ENDIF

                    *-- Processar cada item da OP
                    SELECT cursor_4c_TmpOpi
                    SCAN
                        IF NVL(cursor_4c_TmpOpi.Qtds, 0) <> 0
                            *-- Calcular numero do envelope
                            IF loc_lEnvelope
                                loc_nEnv = loc_nMfasNenvs
                                IF loc_nMfasNenvs = loc_nMfasNops
                                    loc_nEnv = loc_nMfasNumps
                                ENDIF
                            ELSE
                                loc_nEnv = 0
                            ENDIF
                            loc_nEnv = IIF(loc_nEnv = 0, loc_nMfasNops, loc_nEnv)

                            *-- Globalizas=1 ou Servicos=1: usa ContaOs; senao ContaDs
                            IF NVL(cursor_4c_TmpOpi.Globalizas, 0) = 1 OR ;
                               NVL(cursor_4c_TmpOpi.Servicos, 0) = 1
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaOs, ""))
                            ELSE
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaDs, ""))
                            ENDIF

                            *-- Buscar razao social do cliente em SigCdCli
                            loc_cSQL = "Select rclis From SigCdCli Where Iclis = " + ;
                                       EscaparSQL(loc_cCliente)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            loc_cRclis = ""
                            IF USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                                SELECT cursor_4c_TmpCli
                                loc_cRclis = ALLTRIM(NVL(rclis, ""))
                            ENDIF
                            IF USED("cursor_4c_TmpCli")
                                USE IN cursor_4c_TmpCli
                            ENDIF

                            *-- Capturar valores de TmpOpi para o REPLACE
                            SELECT cursor_4c_TmpOpi
                            loc_nPriors    = NVL(cursor_4c_TmpOpi.Priors, 0)
                            loc_cEmps      = ALLTRIM(NVL(cursor_4c_TmpOpi.Emps, ""))
                            loc_cDopes     = ALLTRIM(NVL(cursor_4c_TmpOpi.Dopes, ""))
                            loc_nNumes     = NVL(cursor_4c_TmpOpi.Numes, 0)
                            loc_tPrazoEnts = NVL(cursor_4c_TmpOpi.PrazoEnts, {})
                            loc_cCpros     = ALLTRIM(NVL(cursor_4c_TmpOpi.Cpros, ""))
                            loc_nQtds      = NVL(cursor_4c_TmpOpi.Qtds, 0)

                            *-- Inserir no cursor destino
                            SELECT (par_cCursorDestino)
                            APPEND BLANK
                            REPLACE Priors    WITH loc_nPriors, ;
                                    Nenvs     WITH loc_nEnv, ;
                                    Nops      WITH loc_nMfasNops, ;
                                    Emps      WITH loc_cEmps, ;
                                    Dopes     WITH loc_cDopes, ;
                                    Numes     WITH loc_nNumes, ;
                                    Contas    WITH loc_cCliente, ;
                                    Rclis     WITH LEFT(loc_cRclis, 40), ;
                                    PrazoEnts WITH loc_tPrazoEnts, ;
                                    Cpros     WITH loc_cCpros, ;
                                    Qtds      WITH loc_nQtds, ;
                                    aPriors   WITH loc_nPriors
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_TmpOpi")
                        USE IN cursor_4c_TmpOpi
                    ENDIF
                    IF USED("cursor_4c_TmpMfas")
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                ENDSCAN

                IF VARTYPE(loc_oProg) = "O"
                    loc_oProg.Complete()
                    loc_oProg = .NULL.
                ENDIF

                IF !loc_lAbortar
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Limpeza de cursores temporarios
        IF USED("cursor_4c_OpPend1")
            USE IN cursor_4c_OpPend1
        ENDIF
        IF USED("cursor_4c_OpPend2")
            USE IN cursor_4c_OpPend2
        ENDIF
        IF USED("cursor_4c_OpPendente")
            USE IN cursor_4c_OpPendente
        ENDIF
        IF USED("cursor_4c_TmpMfas")
            USE IN cursor_4c_TmpMfas
        ENDIF
        IF USED("cursor_4c_SigCdOpd")
            USE IN cursor_4c_SigCdOpd
        ENDIF
        IF USED("cursor_4c_TmpOpi")
            USE IN cursor_4c_TmpOpi
        ENDIF
        IF USED("cursor_4c_TmpCli")
            USE IN cursor_4c_TmpCli
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza prioridade de uma OP individual em SigMvCab
    * Usa: this_nPriors, this_cEmps, this_cDopes, this_nNumes
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Update SigMvCab Set Priors = " + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + ;
                       " Where EmpDopNums = " + ;
                       EscaparSQL(THIS.ObterChavePrimaria())
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarPrioridades - Grava todas as prioridades alteradas em lote
    * par_cCursorSelecao: cursor com os registros (ex: "zTmpSelecao")
    * Ignora registros onde Priors=0 E aPriors=0 (sem alteracao)
    *--------------------------------------------------------------------------
    FUNCTION GravarPrioridades(par_cCursorSelecao)
        LOCAL loc_lSucesso, loc_lTransacao, loc_cSQL, loc_oErro
        LOCAL loc_cEdn, loc_nPriors

        loc_lSucesso   = .T.
        loc_lTransacao = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            SELECT (par_cCursorSelecao)
            GO TOP
            SCAN
                IF NVL(Priors, 0) = 0 AND NVL(aPriors, 0) = 0
                    LOOP
                ENDIF

                loc_nPriors = NVL(Priors, 0)
                loc_cEdn    = ALLTRIM(NVL(Emps, "")) + ;
                              ALLTRIM(NVL(Dopes, "")) + ;
                              STR(NVL(Numes, 0), 6)

                loc_cSQL = "Update SigMvCab Set Priors = " + ;
                           FormatarNumeroSQL(loc_nPriors, 0) + ;
                           " Where EmpDopNums = " + EscaparSQL(loc_cEdn)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT")
                THIS.RegistrarAuditoria("GRAVARPRIORIDADES")
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK")
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel completar " + ;
                        "o processamento (commit). Tente novamente!!", ;
                        "Falha na Grava" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterImagemProduto - Busca e grava imagem Base64 de SigCdPro em arquivo
    * par_cCpros: codigo do produto
    * par_cArquivoDestino: caminho completo do arquivo temporario
    * Retorna: .T. se imagem obtida e gravada com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ObterImagemProduto(par_cCpros, par_cArquivoDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_cFoto
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select FigJpgs From SigCdPro Where Cpros = " + ;
                       EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") > 0
                IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                    SELECT cursor_4c_TmpPro
                    IF !EMPTY(NVL(cursor_4c_TmpPro.FigJpgs, ""))
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    cursor_4c_TmpPro.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                        IF STRTOFILE(loc_cFoto, par_cArquivoDestino) > 0
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

