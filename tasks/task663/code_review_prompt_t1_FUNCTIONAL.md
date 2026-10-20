# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrPcp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1356 linhas total):

*-- Linhas 15 a 131:
15: * so sao chamados via THIS. de dentro da propria classe - chamar de fora
16: * estoura "Property X is not found" por design (regra do CLAUDE.md sobre
17: * hooks protegidos de FormBase, NAO e bug).
18: *
19: * OBJETOS MIGRADOS (100%):
20: *   cnt_4c_Sombra + lbl_4c_Sombra + lbl_4c_Titulo  (cntSombra do legado)
21: *   grd_4c_Dados  (Grade 6 colunas - grade principal de selecao)
22: *   grd_4c_Itens  (GradeItem 4 colunas - itens da OP selecionada)
23: *   cmd_4c_Confirmar (Salva), cmd_4c_Cancelar (Sair)
24: *   txt_4c_Info (Text1 - identificacao da OP), lbl_4c_Cliente, txt_4c_Cliente
25: *   lbl_4c_Ordenacao, cbo_4c_Ordenacao (Cmb_Concilia - ordenacao da grade)
26: *   lbl_4c_TabDica (Label1 - dica TAB)
27: *   shp_4c_Shape4 + img_4c_FigJpg (foto do produto - Visible=.F. por padrao)
28: *
29: * AUDITORIA DE LOOKUP (Fase 6) - o dump SIGPRPCP_form_codigo_fonte.txt foi
30: * varrido pelos padroes de busca do legado Fortyus: fwBuscaExt, fwBuscaSel,
31: * fwBuscaInt (generico "fwbusca"), mAddColuna, sigacess( e a familia
32: * Acesso(Campos|Contab|Contas|Empresa|Grupos|MovInd|MovMto|Produto|Titulo).
33: * Resultado: ZERO ocorrencias. O form legado nao consulta tabela auxiliar a
34: * partir de codigo digitado, logo nao ha FormBuscaAuxiliar a criar aqui -
35: * inventar um violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup".
36: *
37: * CAMPOS NAO DIGITAVEIS (todos somente-leitura no legado):
38: *   Get_Cliente  -> PROCEDURE When / Return .f.   (txt_4c_Cliente, ReadOnly)
39: *   Text1        -> preenchido por Grade.AfterRowColChange (txt_4c_Info)
40: *   Grade.Column2..6 e GradeItem.Column1..4 -> Column.ReadOnly = .T.
41: *
42: * UNICO CAMPO DIGITAVEL: Grade.Column1.Text1 (Priors, InputMask "999999"),
43: * com Column1.ReadOnly = .F. A regra que o governa nao esta num Valid - esta
44: * no Salva.Click do legado ("If m.Priors = 0 And m.aPriors = 0 / Loop"), e por
45: * isso nasce nesta fase como ValidarPrioridades(); a Fase 7/8 apenas chama.
46: * O legado tem LostFocus na celula: TAB alterna entre as duas grades.
47: *==============================================================================
48: 
49: DEFINE CLASS FormSigPrPcp AS FormBase
50: 
51:     *-- Propriedades visuais (copiadas exatamente do original SIGPRPCP)
52:     Height       = 600
53:     Width        = 800
54:     Caption      = "Prioriza" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(245) + "es para Planejamento de Produ" + CHR(231) + CHR(227) + "o"
55:     AutoCenter   = .T.
56:     BorderStyle  = 2
57:     TitleBar     = 0
58:     DataSession  = 2
59:     ShowWindow   = 1
60:     WindowType   = 1
61:     ControlBox   = .F.
62:     Closable     = .F.
63:     MaxButton    = .F.
64:     MinButton    = .F.
65:     Movable      = .F.
66:     ClipControls = .F.
67:     ShowTips     = .T.
68:     KeyPreview   = .T.
69: 
70:     *-- Estado / Negocio
71:     this_oBusinessObject = .NULL.
72:     this_cArquivoTempImg = ""
73:     this_lTrocandoGrade  = .F.   && guarda de reentrancia do TAB entre as grades
74: 
75:     *==========================================================================
76:     PROCEDURE Init()
77:     *==========================================================================
78:         *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4)
79:         SET DATE TO BRITISH
80:         SET CENTURY ON
81:         RETURN DODEFAULT()
82:     ENDPROC
83: 
84:     *==========================================================================
85:     PROTECTED PROCEDURE InicializarForm
86:     *==========================================================================
87:         LOCAL loc_lSucesso, loc_oErro
88:         loc_lSucesso = .F.
89: 
90:         TRY
91:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrPcpBO")
92:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
93:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrPcpBO.", "Erro")
94:             ELSE
95:                 THIS.this_cArquivoTempImg = SYS(2023) + "\SigPrPcp.jpg"
96: 
97:                 *-- Tentar carregar configuracao do sistema (continua mesmo se BD indisponivel)
98:                 IF !THIS.this_oBusinessObject.ObterConfiguracaoPam()
99:                     MsgErro("Falha ao carregar configura" + CHR(231) + CHR(227) + "o do sistema (SigCdPam).", "Erro")
100:                 ENDIF
101: 
102:                 *-- Criar cursor base para dados PCP (zTmppPcp do legado)
103:                 SET NULL ON
104:                 CREATE CURSOR cursor_4c_PcpDados ( ;
105:                     Priors    N(6)    NULL, ;
106:                     Nenvs     N(10)   NULL, ;
107:                     Nops      N(10)   NULL, ;
108:                     Emps      C(3)    NULL, ;
109:                     Dopes     C(20)   NULL, ;
110:                     Numes     N(6)    NULL, ;
111:                     Contas    C(10)   NULL, ;
112:                     Rclis     C(40)   NULL, ;
113:                     PrazoEnts T       NULL, ;
114:                     Cpros     C(14)   NULL, ;
115:                     Qtds      N(9,3)  NULL, ;
116:                     aPriors   N(6)    NULL  ;
117:                 )
118:                 SET NULL OFF
119: 
120:                 *-- Processar OPs (cursor fica vazio se BD indisponivel)
121:                 IF !THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
122:                     MsgErro("Erro no Processamento dos Dados...", "Erro")
123:                 ENDIF
124: 
125:                 *-- Criar cursor de selecao consolidado (zTmpSelecao do legado)
126:                 SET NULL ON
127:                 SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
128:                                 PrazoEnts, Priors, aPriors ;
129:                     FROM cursor_4c_PcpDados ;
130:                     INTO CURSOR cursor_4c_Selecao READWRITE
131:                 SET NULL OFF

*-- Linhas 156 a 328:
156:                 THIS.ConfigurarPaginaDados()
157:                 THIS.ConfigurarControlesAuxiliares()
158:                 THIS.ConfigurarImagemProduto()
159:                 THIS.TornarControlesVisiveis()
160: 
161:                 *-- Propagar titulo para labels do cabecalho
162:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
163:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
164: 
165:                 *-- Carregar dados nos grids e vincular eventos
166:                 THIS.CarregarGrades()
167:                 THIS.VincularEventos()
168: 
169:                 loc_lSucesso = .T.
170:             ENDIF
171:         CATCH TO loc_oErro
172:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
173:                     " PROC=" + loc_oErro.Procedure, ;
174:                     "Erro FormSigPrPcp.InicializarForm")
175:         ENDTRY
176: 
177:         RETURN loc_lSucesso
178:     ENDPROC
179: 
180:     *==========================================================================
181:     * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
182:     *==========================================================================
183:     PROTECTED PROCEDURE ConfigurarPageFrame
184:         THIS.Picture      = gc_4c_CaminhoIcones + "new_background.jpg"
185:         THIS.ClipControls = .F.
186:     ENDPROC
187: 
188:     *==========================================================================
189:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra do legado)
190:     *==========================================================================
191:     PROTECTED PROCEDURE ConfigurarCabecalho
192:         THIS.AddObject("cnt_4c_Sombra", "Container")
193:         WITH THIS.cnt_4c_Sombra
194:             .Visible     = .T.
195:             .Top         = 0
196:             .Left        = 0
197:             .Width       = THIS.Width
198:             .Height      = 80
199:             .BorderWidth = 0
200:             .BackColor   = RGB(100,100,100)
201:         ENDWITH
202:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
203:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
204:             .FontBold      = .T.
205:             .FontName      = "Tahoma"
206:             .FontSize      = 18
207:             .FontUnderline = .F.
208:             .WordWrap      = .T.
209:             .Alignment     = 0
210:             .AutoSize      = .F.
211:             .BackStyle     = 0
212:             .Caption       = THIS.Caption
213:             .Height        = 40
214:             .Left          = 10
215:             .Top           = 18
216:             .Width         = THIS.Width
217:             .ForeColor     = RGB(0,0,0)
218:             .Visible       = .T.
219:         ENDWITH
220:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
221:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
222:             .FontBold   = .T.
223:             .FontName   = "Tahoma"
224:             .FontSize   = 18
225:             .WordWrap   = .T.
226:             .Alignment  = 0
227:             .AutoSize   = .F.
228:             .BackStyle  = 0
229:             .Caption    = THIS.Caption
230:             .Height     = 46
231:             .Left       = 10
232:             .Top        = 17
233:             .Width      = THIS.Width
234:             .ForeColor  = RGB(255,255,255)
235:             .Visible    = .T.
236:         ENDWITH
237:     ENDPROC
238: 
239:     *==========================================================================
240:     * TornarControlesVisiveis - Torna controles do form visiveis recursivamente
241:     * NOTA: img_4c_FigJpg e shp_4c_Shape4 sao excluidos (Visible=.F. por default)
242:     *==========================================================================
243:     PROTECTED PROCEDURE TornarControlesVisiveis
244:         LOCAL loc_nI, loc_oObj
245:         FOR loc_nI = 1 TO THIS.ControlCount
246:             loc_oObj = THIS.Controls(loc_nI)
247:             IF VARTYPE(loc_oObj) = "O"
248:                 IF INLIST(UPPER(loc_oObj.Name), "IMG_4C_FIGJPG", "SHP_4C_SHAPE4")
249:                     LOOP
250:                 ENDIF
251:                 IF PEMSTATUS(loc_oObj, "Visible", 5)
252:                     loc_oObj.Visible = .T.
253:                 ENDIF
254:                 IF PEMSTATUS(loc_oObj, "ControlCount", 5) AND loc_oObj.ControlCount > 0
255:                     THIS.TornarSubControlesVisiveis(loc_oObj)
256:                 ENDIF
257:             ENDIF
258:         ENDFOR
259:     ENDPROC
260: 
261:     *==========================================================================
262:     * TornarSubControlesVisiveis - Recursao interna de TornarControlesVisiveis
263:     *==========================================================================
264:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
265:         LOCAL loc_nI, loc_oObj
266:         IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
267:             RETURN
268:         ENDIF
269:         FOR loc_nI = 1 TO par_oContainer.ControlCount
270:             loc_oObj = par_oContainer.Controls(loc_nI)
271:             IF VARTYPE(loc_oObj) = "O"
272:                 IF PEMSTATUS(loc_oObj, "Visible", 5)
273:                     loc_oObj.Visible = .T.
274:                 ENDIF
275:                 IF PEMSTATUS(loc_oObj, "ControlCount", 5) AND loc_oObj.ControlCount > 0
276:                     THIS.TornarSubControlesVisiveis(loc_oObj)
277:                 ENDIF
278:             ENDIF
279:         ENDFOR
280:     ENDPROC
281: 
282:     *==========================================================================
283:     * ConfigurarPaginaLista - Monta a "lista" (grade principal Dados + grade Itens
284:     * + container de botoes de acao) equivalente a Page1 do padrao CRUD.
285:     * Em forms OPERACIONAIS sem PageFrame, este metodo consolida a configuracao
286:     * da area principal de trabalho (grids + botoes canonicos Confirmar/Sair).
287:     *==========================================================================
288:     PROTECTED PROCEDURE ConfigurarPaginaLista
289:         *-- Grade principal (Grade do legado) - lado esquerdo, 6 colunas
290:         THIS.AddObject("grd_4c_Dados", "Grid")
291:         WITH THIS.grd_4c_Dados
292:             .Top           = 110
293:             .Left          = 0
294:             .Width         = 469
295:             .Height        = 398
296:             .ColumnCount   = 6
297:             .FontName      = "Tahoma"
298:             .FontSize      = 8
299:             .DeleteMark    = .F.
300:             .RecordMark    = .F.
301:             .ReadOnly      = .T.
302:             .RowHeight     = 16
303:             .ScrollBars    = 2
304:             .GridLineColor = RGB(238,238,238)
305:             .Visible       = .T.
306: 
307:             WITH .Column1
308:                 .Width             = 50
309:                 .Movable           = .F.
310:                 .Resizable         = .F.
311:                 .ReadOnly          = .F.
312:                 .Header1.Caption   = "Prioridade"
313:                 .Header1.Alignment = 2
314:                 .Header1.ForeColor = RGB(0,0,0)
315:                 .Text1.InputMask   = "999999"
316:                 .Text1.BorderStyle = 0
317:                 .Text1.Margin      = 0
318:                 .Text1.ForeColor   = RGB(0,0,0)
319:                 .Text1.BackColor   = RGB(255,255,255)
320:             ENDWITH
321: 
322:             WITH .Column2
323:                 .Width             = 31
324:                 .Movable           = .F.
325:                 .Resizable         = .F.
326:                 .ReadOnly          = .T.
327:                 .Header1.Caption   = "Emp"
328:                 .Header1.Alignment = 2

*-- Linhas 470 a 513:
470:     *==========================================================================
471:     * ConfigurarBotoes - Cria botoes Confirmar e Cancelar
472:     *==========================================================================
473:     PROTECTED PROCEDURE ConfigurarBotoes
474:         *-- Botao Confirmar (Salva do legado)
475:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
476:         WITH THIS.cmd_4c_Confirmar
477:             .Top        = 3
478:             .Left       = 650
479:             .Height     = 75
480:             .Width      = 75
481:             .FontBold   = .T.
482:             .FontItalic = .T.
483:             .FontName   = "Tahoma"
484:             .FontSize   = 8
485:             .WordWrap   = .F.
486:             .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
487:             .Caption    = "Confirmar"
488:             .ForeColor  = RGB(90,90,90)
489:             .BackColor  = RGB(255,255,255)
490:             .Themes           = .T.
491:             .Visible    = .T.
492:         ENDWITH
493: 
494:         *-- Botao Cancelar/Sair (Sair do legado)
495:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
496:         WITH THIS.cmd_4c_Cancelar
497:             .Top        = 3
498:             .Left       = 725
499:             .Height     = 75
500:             .Width      = 75
501:             .FontBold   = .T.
502:             .FontItalic = .T.
503:             .FontName   = "Tahoma"
504:             .FontSize   = 8
505:             .WordWrap   = .F.
506:             .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
507:             .Cancel     = .T.
508:             .Caption    = "Encerrar"
509:             .ForeColor  = RGB(90,90,90)
510:             .BackColor  = RGB(255,255,255)
511:             .Themes           = .T.
512:             .Visible    = .T.
513:         ENDWITH

*-- Linhas 519 a 562:
519:     * agrupa os controles de exibicao de contexto da operacao selecionada:
520:     * txt_4c_Info (identificacao da OP), lbl_4c_Cliente e txt_4c_Cliente.
521:     *==========================================================================
522:     PROTECTED PROCEDURE ConfigurarPaginaDados
523:         *-- Caixa de identificacao da operacao selecionada (Text1 do legado)
524:         *-- Exibe: "EMP OPERACAO NUMES" ao navegar na grade principal
525:         THIS.AddObject("txt_4c_Info", "TextBox")
526:         WITH THIS.txt_4c_Info
527:             .Top         = 110
528:             .Left        = 470
529:             .Width       = 329
530:             .Height      = 21
531:             .FontBold    = .T.
532:             .FontName    = "Tahoma"
533:             .FontSize    = 8
534:             .Alignment   = 2
535:             .ForeColor   = RGB(0,0,0)
536:             .BackColor   = RGB(0,128,255)
537:             .ReadOnly    = .T.
538:             .Value       = ""
539:             .Visible     = .T.
540:         ENDWITH
541: 
542:         *-- Label "Cliente" (Say3 do legado)
543:         THIS.AddObject("lbl_4c_Cliente", "Label")
544:         WITH THIS.lbl_4c_Cliente
545:             .AutoSize   = .T.
546:             .FontBold   = .F.
547:             .FontItalic = .F.
548:             .FontName   = "Tahoma"
549:             .FontSize   = 8
550:             .BackStyle  = 0
551:             .Caption    = "Cliente"
552:             .Left       = 23
553:             .Top        = 515
554:             .ForeColor  = RGB(90,90,90)
555:             .Visible    = .T.
556:         ENDWITH
557: 
558:         *-- Caixa do cliente (Get_Cliente do legado - somente leitura, preenchida via Grade)
559:         THIS.AddObject("txt_4c_Cliente", "TextBox")
560:         WITH THIS.txt_4c_Cliente
561:             .FontBold    = .T.
562:             .FontName    = "Tahoma"

*-- Linhas 579 a 622:
579:     *==========================================================================
580:     * ConfigurarControlesAuxiliares - Cria controles de filtros e ordenacao
581:     *==========================================================================
582:     PROTECTED PROCEDURE ConfigurarControlesAuxiliares
583:         *-- Label "Ordenacao" (lbl_lancamentos do legado)
584:         THIS.AddObject("lbl_4c_Ordenacao", "Label")
585:         WITH THIS.lbl_4c_Ordenacao
586:             .AutoSize   = .F.    && no-op em Label por AddObject (regra #23)
587:             .FontBold   = .F.
588:             .FontItalic = .F.
589:             .FontName   = "Tahoma"
590:             .FontSize   = 8
591:             .BackStyle  = 0
592:             .Caption    = "Ordena" + CHR(231) + CHR(227) + "o :"
593:             .Alignment  = 0
594:             .Width      = 62     && Width/Height transcritos do SCX (lbl_lancamentos)
595:             .Height     = 15
596:             .Left       = 16
597:             .Top        = 545
598:             .ForeColor  = RGB(90,90,90)
599:             .Visible    = .T.
600:         ENDWITH
601: 
602:         *-- ComboBox de ordenacao (Cmb_Concilia do legado)
603:         THIS.AddObject("cbo_4c_Ordenacao", "ComboBox")
604:         WITH THIS.cbo_4c_Ordenacao
605:             .FontName      = "Tahoma"
606:             .FontSize      = 8
607:             .RowSourceType = 0
608:             .Style         = 2
609:             .Height        = 24
610:             .Left          = 80
611:             .Top           = 540
612:             .Width         = 140
613:             .Visible       = .T.
614:         ENDWITH
615: 
616:         *-- Label de dica TAB (Label1 do legado)
617:         THIS.AddObject("lbl_4c_TabDica", "Label")
618:         WITH THIS.lbl_4c_TabDica
619:             .AutoSize   = .F.    && no-op em Label por AddObject (regra #23)
620:             .FontBold   = .F.
621:             .FontItalic = .F.
622:             .FontName   = "Tahoma"

*-- Linhas 636 a 707:
636:     *==========================================================================
637:     * ConfigurarImagemProduto - Cria shape e imagem do produto (ocultos por padrao)
638:     *==========================================================================
639:     PROTECTED PROCEDURE ConfigurarImagemProduto
640:         *-- Shape de fundo (Shape4 do legado)
641:         THIS.AddObject("shp_4c_Shape4", "Shape")
642:         WITH THIS.shp_4c_Shape4
643:             .Top         = 461
644:             .Left        = 480
645:             .Width       = 148
646:             .Height      = 109
647:             .BackStyle   = 0
648:             .BorderColor = RGB(90,90,90)
649:             .Visible     = .F.
650:         ENDWITH
651: 
652:         *-- Imagem do produto (FigJpg do legado)
653:         THIS.AddObject("img_4c_FigJpg", "Image")
654:         WITH THIS.img_4c_FigJpg
655:             .Stretch = 1
656:             .Top     = 463
657:             .Left    = 483
658:             .Width   = 143
659:             .Height  = 105
660:             .Visible = .F.
661:         ENDWITH
662:     ENDPROC
663: 
664:     *==========================================================================
665:     * CarregarGrades - Configura RecordSource/ControlSource e popula combo
666:     *==========================================================================
667:     PROTECTED PROCEDURE CarregarGrades
668:         LOCAL loc_lSucesso, loc_oErro
669:         loc_lSucesso = .F.
670: 
671:         TRY
672:             IF !USED("cursor_4c_Selecao") OR !USED("cursor_4c_PcpDados")
673:                 MsgErro("Cursores de dados n" + CHR(227) + "o inicializados.", "Erro")
674:             ELSE
675:                 *-- Vincular grade principal ao cursor de selecao
676:                 THIS.grd_4c_Dados.ColumnCount  = 6
677:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Selecao"
678:                 WITH THIS.grd_4c_Dados
679:                     .Column1.ControlSource = "cursor_4c_Selecao.Priors"
680:                     .Column2.ControlSource = "cursor_4c_Selecao.Emps"
681:                     .Column3.ControlSource = "cursor_4c_Selecao.Dopes"
682:                     .Column4.ControlSource = "cursor_4c_Selecao.Numes"
683:                     .Column5.ControlSource = "cursor_4c_Selecao.Contas"
684:                     .Column6.ControlSource = "cursor_4c_Selecao.PrazoEnts"
685:                     .Refresh()
686:                 ENDWITH
687: 
688:                 *-- Vincular grade de itens ao cursor de dados PCP
689:                 THIS.grd_4c_Itens.ColumnCount  = 4
690:                 THIS.grd_4c_Itens.RecordSource = "cursor_4c_PcpDados"
691:                 WITH THIS.grd_4c_Itens
692:                     .Column1.ControlSource = "cursor_4c_PcpDados.Nenvs"
693:                     .Column2.ControlSource = "cursor_4c_PcpDados.Nops"
694:                     .Column3.ControlSource = "cursor_4c_PcpDados.Cpros"
695:                     .Column4.ControlSource = "cursor_4c_PcpDados.Qtds"
696:                     .Refresh()
697:                 ENDWITH
698: 
699:                 *-- Larguras, legendas e editabilidade POR ULTIMO: BtnVisualizarClick
700:                 *-- destroi (USE IN) e recria os cursores antes de rechamar este
701:                 *-- metodo, e RecordSource sobre cursor recriado devolve as colunas
702:                 *-- ao default 90 com Header "Header1" (regra #41 / Problema 48).
703:                 WITH THIS.grd_4c_Dados
704:                     .Column1.Width = 50
705:                     .Column2.Width = 31
706:                     .Column3.Width = 150
707:                     .Column4.Width = 52

*-- Linhas 752 a 927:
752:             ENDIF
753:         CATCH TO loc_oErro
754:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
755:                     " PROC=" + loc_oErro.Procedure, ;
756:                     "Erro FormSigPrPcp.CarregarGrades")
757:         ENDTRY
758: 
759:         RETURN loc_lSucesso
760:     ENDPROC
761: 
762:     *==========================================================================
763:     * VincularEventos - Estabelece BINDEVENTs para eventos dos controles
764:     *==========================================================================
765:     PROTECTED PROCEDURE VincularEventos
766:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
767:         BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GrdItensAfterRowColChange")
768:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "LostFocus", THIS, "GrdDadosCol1LostFocus")
769:         BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "LostFocus", THIS, "GrdItensCol1LostFocus")
770:         BINDEVENT(THIS.cbo_4c_Ordenacao, "InteractiveChange", THIS, "CboOrdenacaoInteractiveChange")
771:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
772:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
773:     ENDPROC
774: 
775:     *==========================================================================
776:     * AlternarPagina - Alterna foco entre a grade principal (1) e a grade de
777:     * itens (2). Em OPERACIONAL sem PageFrame, este metodo cumpre o papel do
778:     * <TAB> descrito no rodape do form legado ("[ <TAB> para mudar de Grade ]").
779:     *==========================================================================
780:     PROCEDURE AlternarPagina(par_nPagina)
781:         LOCAL loc_nPagina
782:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
783:         DO CASE
784:             CASE loc_nPagina = 1
785:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
786:                     THIS.grd_4c_Dados.SetFocus()
787:                     THIS.grd_4c_Dados.Refresh()
788:                 ENDIF
789:             CASE loc_nPagina = 2
790:                 IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
791:                     THIS.grd_4c_Itens.SetFocus()
792:                     THIS.grd_4c_Itens.Refresh()
793:                 ENDIF
794:         ENDCASE
795:     ENDPROC
796: 
797:     *==========================================================================
798:     * GrdDadosAfterRowColChange - Atualiza paineis ao mudar linha na grade principal
799:     *==========================================================================
800:     PROCEDURE GrdDadosAfterRowColChange
801:         LPARAMETERS par_nColIndex
802:         IF !USED("cursor_4c_Selecao")
803:             RETURN
804:         ENDIF
805:         THIS.LockScreen = .T.
806:         SELECT cursor_4c_Selecao
807:         THIS.txt_4c_Cliente.Value = NVL(cursor_4c_Selecao.Rclis, "")
808:         THIS.txt_4c_Cliente.Refresh()
809:         SELECT cursor_4c_PcpDados
810:         GO TOP
811:         THIS.grd_4c_Itens.Refresh()
812:         THIS.img_4c_FigJpg.Visible = .F.
813:         THIS.img_4c_FigJpg.Picture = ""
814:         SELECT cursor_4c_Selecao
815:         THIS.txt_4c_Info.Value = NVL(cursor_4c_Selecao.Emps, "") + " " + ;
816:             ALLTRIM(NVL(cursor_4c_Selecao.Dopes, "")) + " " + ;
817:             STR(NVL(cursor_4c_Selecao.Numes, 0), 6)
818:         THIS.LockScreen = .F.
819:     ENDPROC
820: 
821:     *==========================================================================
822:     * GrdItensAfterRowColChange - Carrega foto do produto ao mudar linha nos itens
823:     *==========================================================================
824:     PROCEDURE GrdItensAfterRowColChange
825:         LPARAMETERS par_nColIndex
826:         LOCAL loc_cCpros
827:         IF !USED("cursor_4c_PcpDados")
828:             RETURN
829:         ENDIF
830:         THIS.LockScreen = .T.
831:         THIS.img_4c_FigJpg.Visible = .F.
832:         THIS.img_4c_FigJpg.Picture = ""
833:         THIS.shp_4c_Shape4.Visible = .F.
834:         SELECT cursor_4c_PcpDados
835:         IF !EOF("cursor_4c_PcpDados")
836:             loc_cCpros = NVL(cursor_4c_PcpDados.Cpros, "")
837:             IF !EMPTY(loc_cCpros)
838:                 IF THIS.this_oBusinessObject.ObterImagemProduto(loc_cCpros, THIS.this_cArquivoTempImg)
839:                     THIS.img_4c_FigJpg.Picture = THIS.this_cArquivoTempImg
840:                     THIS.img_4c_FigJpg.Visible = .T.
841:                     THIS.shp_4c_Shape4.Visible = .T.
842:                 ENDIF
843:             ENDIF
844:         ENDIF
845:         SELECT cursor_4c_PcpDados
846:         THIS.LockScreen = .F.
847:     ENDPROC
848: 
849:     *==========================================================================
850:     * GrdDadosCol1LostFocus - TAB na coluna Prioridade salta para grade de itens
851:     * Legado: SIGPRPCP.Grade.Column1.Text1.LostFocus
852:     *     If Lastkey() = 9 / ThisForm.GradeItem.SetFocus / EndIf
853:     * LostFocus nao recebe parametro (regra #3: a assinatura segue o evento).
854:     * LASTKEY() so vale no LostFocus: dentro de KeyPress ele devolve a tecla
855:     * ANTERIOR, e o salto entre grades nunca acontecia.
856:     *==========================================================================
857:     PROCEDURE GrdDadosCol1LostFocus
858:         IF THIS.this_lTrocandoGrade
859:             RETURN
860:         ENDIF
861:         IF LASTKEY() = 9
862:             THIS.this_lTrocandoGrade = .T.
863:             THIS.grd_4c_Itens.SetFocus()
864:             THIS.this_lTrocandoGrade = .F.
865:         ENDIF
866:     ENDPROC
867: 
868:     *==========================================================================
869:     * GrdItensCol1LostFocus - TAB na coluna Envelope retorna para grade principal
870:     * Legado: SIGPRPCP.GradeItem.Column1.Text1.LostFocus
871:     *     If Lastkey() = 9 / ThisForm.Grade.SetFocus / EndIf
872:     *==========================================================================
873:     PROCEDURE GrdItensCol1LostFocus
874:         IF THIS.this_lTrocandoGrade
875:             RETURN
876:         ENDIF
877:         IF LASTKEY() = 9
878:             THIS.this_lTrocandoGrade = .T.
879:             THIS.grd_4c_Dados.SetFocus()
880:             THIS.this_lTrocandoGrade = .F.
881:         ENDIF
882:     ENDPROC
883: 
884:     *==========================================================================
885:     * CboOrdenacaoInteractiveChange - Reordena grade principal ao mudar combo
886:     *==========================================================================
887:     PROCEDURE CboOrdenacaoInteractiveChange
888:         IF !USED("cursor_4c_Selecao")
889:             RETURN
890:         ENDIF
891:         SELECT cursor_4c_Selecao
892:         SET RELATION TO
893:         SET ORDER TO
894:         DO CASE
895:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prazo Entrega"
896:                 SET ORDER TO Entrega
897:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Cliente"
898:                 SET ORDER TO Cliente
899:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Operacao"
900:                 SET ORDER TO EmpDopNum
901:             CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prioridade"
902:                 SET ORDER TO Prioridade
903:         ENDCASE
904:         SELECT cursor_4c_Selecao
905:         SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
906:         THIS.grd_4c_Dados.Refresh()
907:     ENDPROC
908: 
909:     *==========================================================================
910:     * ValidarPrioridades - Regra do unico campo digitavel da tela (Priors)
911:     *
912:     * O legado nao tem Valid na celula: a regra que governa a coluna Prioridade
913:     * mora no Salva.Click (SIGPRPCP.Salva), transcrita aqui linha a linha:
914:     *
915:     *     Select zTmpSelecao
916:     *     Scan
917:     *         Scatter Memvar
918:     *         If m.Priors = 0 And m.aPriors = 0
919:     *             Loop
920:     *         Endif
921:     *         ...Update SigMvCab Set Priors = ...
922:     *     EndScan
923:     *
924:     * Ou seja: so vai ao banco a linha cuja prioridade digitada (Priors) OU a
925:     * prioridade ja gravada (aPriors) seja diferente de zero. Sem nenhuma linha
926:     * nessa condicao o Scan do legado roda em vazio, da Commit e fecha a tela -
927:     * o usuario sai achando que gravou. Aqui a ausencia de linha elegivel eh

*-- Linhas 936 a 1140:
936:     *
937:     * PUBLIC: a Fase 7/8 (BtnSalvarClick) chama este metodo de fora.
938:     *==========================================================================
939:     PROCEDURE ValidarPrioridades()
940:         LOCAL loc_lValido, loc_nRegAtual, loc_nElegiveis, loc_nPriors
941:         LOCAL loc_cOpInvalida, loc_nRegInvalido, loc_oErro
942: 
943:         loc_lValido      = .F.
944:         loc_nElegiveis   = 0
945:         loc_nRegInvalido = 0
946:         loc_cOpInvalida  = ""
947: 
948:         TRY
949:             IF !USED("cursor_4c_Selecao")
950:                 MsgAviso("Dados de sele" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
951:                          "o dispon" + CHR(237) + "veis.", "Aten" + CHR(231) + CHR(227) + "o")
952:             ELSE
953:                 SELECT cursor_4c_Selecao
954:                 loc_nRegAtual = RECNO("cursor_4c_Selecao")
955: 
956:                 SCAN
957:                     loc_nPriors = NVL(cursor_4c_Selecao.Priors, 0)
958: 
959:                     *-- Criterio do Salva.Click legado: Priors = 0 E aPriors = 0 -> pula
960:                     IF loc_nPriors <> 0 OR NVL(cursor_4c_Selecao.aPriors, 0) <> 0
961:                         loc_nElegiveis = loc_nElegiveis + 1
962:                     ENDIF
963: 
964:                     *-- Faixa da coluna destino SigMvCab.priors numeric(2,0)
965:                     IF loc_nRegInvalido = 0 AND (loc_nPriors < 0 OR loc_nPriors > 99)
966:                         loc_nRegInvalido = RECNO("cursor_4c_Selecao")
967:                         loc_cOpInvalida  = NVL(cursor_4c_Selecao.Emps, "") + " " + ;
968:                                            ALLTRIM(NVL(cursor_4c_Selecao.Dopes, "")) + " " + ;
969:                                            ALLTRIM(STR(NVL(cursor_4c_Selecao.Numes, 0), 6))
970:                     ENDIF
971:                 ENDSCAN
972: 
973:                 DO CASE
974:                     CASE loc_nRegInvalido > 0
975:                         GO loc_nRegInvalido IN cursor_4c_Selecao
976:                         THIS.grd_4c_Dados.Refresh()
977:                         MsgAviso("Prioridade inv" + CHR(225) + "lida na opera" + CHR(231) + ;
978:                                  CHR(227) + "o " + loc_cOpInvalida + "." + CHR(13) + ;
979:                                  "O valor permitido vai de 0 a 99.", ;
980:                                  "Aten" + CHR(231) + CHR(227) + "o")
981:                         THIS.grd_4c_Dados.SetFocus()
982: 
983:                     CASE loc_nElegiveis = 0
984:                         IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Selecao"))
985:                             GO loc_nRegAtual IN cursor_4c_Selecao
986:                         ENDIF
987:                         MsgAviso("Informe ao menos uma prioridade antes de gravar.", ;
988:                                  "Aten" + CHR(231) + CHR(227) + "o")
989:                         THIS.grd_4c_Dados.SetFocus()
990: 
991:                     OTHERWISE
992:                         IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Selecao"))
993:                             GO loc_nRegAtual IN cursor_4c_Selecao
994:                         ENDIF
995:                         loc_lValido = .T.
996:                 ENDCASE
997:             ENDIF
998:         CATCH TO loc_oErro
999:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1000:                     " PROC=" + loc_oErro.Procedure, ;
1001:                     "Erro FormSigPrPcp.ValidarPrioridades")
1002:         ENDTRY
1003: 
1004:         RETURN loc_lValido
1005:     ENDPROC
1006: 
1007:     *==========================================================================
1008:     * BtnConfirmarClick - Grava prioridades no banco (Salva.Click do legado)
1009:     *
1010:     * Legado: MessageBox('Confirma Gravacao dos Dados!!!') -> Scan -> Update ->
1011:     *         Commit -> ThisForm.Release.
1012:     * A validacao do campo digitavel (ValidarPrioridades) roda ANTES do
1013:     * MessageBox: perguntar "Confirma Gravacao" para em seguida recusar a
1014:     * gravacao faria o usuario responder por uma acao que nao pode acontecer.
1015:     *==========================================================================
1016:     PROCEDURE BtnConfirmarClick
1017:         IF !THIS.ValidarPrioridades()
1018:             RETURN
1019:         ENDIF
1020:         IF !MsgConfirma("Confirma Grava" + CHR(231) + CHR(227) + "o dos Dados!!!")
1021:             RETURN
1022:         ENDIF
1023:         IF THIS.this_oBusinessObject.GravarPrioridades("cursor_4c_Selecao")
1024:             THIS.Release()
1025:         ENDIF
1026:     ENDPROC
1027: 
1028:     *==========================================================================
1029:     * BtnCancelarClick - Confirma abandono da priorizacao (Sair.Click do legado)
1030:     *==========================================================================
1031:     PROCEDURE BtnCancelarClick
1032:         IF MsgConfirma("Deseja Realmente abandonar Prioriza" + CHR(231) + CHR(227) + "o")
1033:             THIS.Release()
1034:         ENDIF
1035:     ENDPROC
1036: 
1037:     *==========================================================================
1038:     * BtnIncluirClick - Ativa edicao de prioridades (foco na grade principal)
1039:     * Mapeamento OPERACIONAL: "incluir" = iniciar entrada de dados de prioridade
1040:     * na coluna Priors da grade principal, posicionando no topo da lista.
1041:     *==========================================================================
1042:     PROCEDURE BtnIncluirClick()
1043:         LOCAL loc_oErro, loc_lProsseguir
1044:         loc_lProsseguir = .T.
1045:         TRY
1046:             IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
1047:                 MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
1048:                          "es para priorizar.", "Aviso")
1049:                 loc_lProsseguir = .F.
1050:             ENDIF
1051:             IF loc_lProsseguir
1052:                 SELECT cursor_4c_Selecao
1053:                 GO TOP
1054:                 THIS.grd_4c_Dados.Refresh()
1055:                 THIS.GrdDadosAfterRowColChange(1)
1056:                 THIS.grd_4c_Dados.SetFocus()
1057:                 THIS.grd_4c_Dados.ActivateCell(1, 1)
1058:             ENDIF
1059:         CATCH TO loc_oErro
1060:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1061:                     "Erro BtnIncluir")
1062:         ENDTRY
1063:     ENDPROC
1064: 
1065:     *==========================================================================
1066:     * BtnAlterarClick - Edita prioridade da linha selecionada na grade principal
1067:     * Mapeamento OPERACIONAL: "alterar" = editar a coluna Priors da linha corrente
1068:     *==========================================================================
1069:     PROCEDURE BtnAlterarClick()
1070:         LOCAL loc_oErro, loc_nLinha, loc_lProsseguir
1071:         loc_lProsseguir = .T.
1072:         TRY
1073:             IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
1074:                 MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
1075:                          "es para alterar.", "Aviso")
1076:                 loc_lProsseguir = .F.
1077:             ENDIF
1078:             IF loc_lProsseguir
1079:                 SELECT cursor_4c_Selecao
1080:                 IF EOF() OR BOF()
1081:                     GO TOP
1082:                 ENDIF
1083:                 loc_nLinha = THIS.grd_4c_Dados.RelativeRow
1084:                 IF loc_nLinha < 1
1085:                     loc_nLinha = 1
1086:                 ENDIF
1087:                 THIS.grd_4c_Dados.SetFocus()
1088:                 THIS.grd_4c_Dados.ActivateCell(loc_nLinha, 1)
1089:             ENDIF
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1092:                     "Erro BtnAlterar")
1093:         ENDTRY
1094:     ENDPROC
1095: 
1096:     *==========================================================================
1097:     * BtnVisualizarClick - Recarrega/reprocessa dados dos grids do zero
1098:     * Mapeamento OPERACIONAL: "visualizar" = refresh completo (reprocessa PCP)
1099:     *==========================================================================
1100:     PROCEDURE BtnVisualizarClick()
1101:         LOCAL loc_oErro, loc_lProsseguir
1102:         loc_lProsseguir = .T.
1103:         TRY
1104:             IF !MsgConfirma("Recarregar todos os dados descarta as altera" + ;
1105:                             CHR(231) + CHR(245) + "es n" + CHR(227) + "o gravadas." + ;
1106:                             CHR(13) + "Confirma?")
1107:                 loc_lProsseguir = .F.
1108:             ENDIF
1109:             IF loc_lProsseguir
1110:                 THIS.LockScreen = .T.
1111: 
1112:             *-- Encerrar relacao e cursores para reprocessar
1113:                 IF USED("cursor_4c_Selecao")
1114:                     SELECT cursor_4c_Selecao
1115:                     SET RELATION TO
1116:                     USE IN cursor_4c_Selecao
1117:                 ENDIF
1118:                 IF USED("cursor_4c_PcpDados")
1119:                     USE IN cursor_4c_PcpDados
1120:                 ENDIF
1121: 
1122:             *-- Recriar cursor base
1123:                 SET NULL ON
1124:                 CREATE CURSOR cursor_4c_PcpDados ( ;
1125:                     Priors    N(6)    NULL, ;
1126:                     Nenvs     N(10)   NULL, ;
1127:                     Nops      N(10)   NULL, ;
1128:                     Emps      C(3)    NULL, ;
1129:                     Dopes     C(20)   NULL, ;
1130:                     Numes     N(6)    NULL, ;
1131:                     Contas    C(10)   NULL, ;
1132:                     Rclis     C(40)   NULL, ;
1133:                     PrazoEnts T       NULL, ;
1134:                     Cpros     C(14)   NULL, ;
1135:                     Qtds      N(9,3)  NULL, ;
1136:                     aPriors   N(6)    NULL  ;
1137:                 )
1138:                 SET NULL OFF
1139: 
1140:                 IF THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")

*-- Linhas 1182 a 1356:
1182:     * BtnExcluirClick - Zera prioridade da linha selecionada (Priors = 0)
1183:     * Mapeamento OPERACIONAL: "excluir" = remover a prioridade (voltar ao default)
1184:     *==========================================================================
1185:     PROCEDURE BtnExcluirClick()
1186:         LOCAL loc_oErro, loc_lProsseguir
1187:         loc_lProsseguir = .T.
1188:         TRY
1189:             IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
1190:                 MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
1191:                          "es para atualizar.", "Aviso")
1192:                 loc_lProsseguir = .F.
1193:             ENDIF
1194:             IF loc_lProsseguir
1195:                 SELECT cursor_4c_Selecao
1196:                 IF EOF() OR BOF()
1197:                     MsgAviso("Selecione uma linha na grade antes de zerar a prioridade.", ;
1198:                              "Aviso")
1199:                     loc_lProsseguir = .F.
1200:                 ENDIF
1201:             ENDIF
1202:             IF loc_lProsseguir
1203:                 IF NVL(cursor_4c_Selecao.Priors, 0) = 0
1204:                     MsgAviso("A prioridade desta opera" + CHR(231) + CHR(227) + ;
1205:                              "o j" + CHR(225) + " est" + CHR(225) + " zerada.", "Aviso")
1206:                     loc_lProsseguir = .F.
1207:                 ENDIF
1208:             ENDIF
1209:             IF loc_lProsseguir
1210:                 IF !MsgConfirma("Zerar prioridade da opera" + CHR(231) + CHR(227) + "o selecionada?")
1211:                     loc_lProsseguir = .F.
1212:                 ENDIF
1213:             ENDIF
1214:             IF loc_lProsseguir
1215:                 REPLACE cursor_4c_Selecao.Priors WITH 0
1216:                 THIS.grd_4c_Dados.Refresh()
1217:                 THIS.GrdDadosAfterRowColChange(1)
1218:             ENDIF
1219:         CATCH TO loc_oErro
1220:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1221:                     "Erro BtnExcluir")
1222:         ENDTRY
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * CarregarLista - Recarrega os grids (wrapper publico de CarregarGrades)
1227:     *==========================================================================
1228:     PROCEDURE CarregarLista()
1229:         THIS.CarregarGrades()
1230:     ENDPROC
1231: 
1232:     *==========================================================================
1233:     * FormParaBO - Carrega propriedades do BO a partir da linha corrente do cursor
1234:     *==========================================================================
1235:     PROCEDURE FormParaBO()
1236:         IF USED("cursor_4c_Selecao") AND !EOF("cursor_4c_Selecao")
1237:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Selecao")
1238:         ENDIF
1239:     ENDPROC
1240: 
1241:     *==========================================================================
1242:     * BOParaForm - Atualiza controles de exibicao a partir das props do BO
1243:     *==========================================================================
1244:     PROCEDURE BOParaForm()
1245:         LOCAL loc_oBO
1246:         loc_oBO = THIS.this_oBusinessObject
1247:         THIS.txt_4c_Info.Value    = ALLTRIM(loc_oBO.this_cEmps) + " " + ;
1248:                                     ALLTRIM(loc_oBO.this_cDopes) + " " + ;
1249:                                     STR(loc_oBO.this_nNumes, 6)
1250:         THIS.txt_4c_Cliente.Value = loc_oBO.this_cRclis
1251:         THIS.txt_4c_Info.Refresh()
1252:         THIS.txt_4c_Cliente.Refresh()
1253:     ENDPROC
1254: 
1255:     *==========================================================================
1256:     * HabilitarCampos - Habilita/desabilita controles conforme disponibilidade
1257:     *==========================================================================
1258:     PROCEDURE HabilitarCampos()
1259:         LOCAL loc_lTemDados
1260:         loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
1261:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
1262:             THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
1263:         ENDIF
1264:         IF PEMSTATUS(THIS, "cbo_4c_Ordenacao", 5)
1265:             THIS.cbo_4c_Ordenacao.Enabled = loc_lTemDados
1266:         ENDIF
1267:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1268:             THIS.grd_4c_Dados.Enabled = loc_lTemDados
1269:         ENDIF
1270:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1271:             THIS.grd_4c_Itens.Enabled = loc_lTemDados
1272:         ENDIF
1273:     ENDPROC
1274: 
1275:     *==========================================================================
1276:     * LimparCampos - Limpa controles de exibicao e oculta imagem do produto
1277:     *==========================================================================
1278:     PROCEDURE LimparCampos()
1279:         THIS.txt_4c_Info.Value    = ""
1280:         THIS.txt_4c_Cliente.Value = ""
1281:         THIS.img_4c_FigJpg.Visible  = .F.
1282:         THIS.img_4c_FigJpg.Picture  = ""
1283:         THIS.shp_4c_Shape4.Visible  = .F.
1284:     ENDPROC
1285: 
1286:     *==========================================================================
1287:     * AjustarBotoesPorModo - Habilita botao Confirmar apenas se houver dados
1288:     *==========================================================================
1289:     PROCEDURE AjustarBotoesPorModo()
1290:         LOCAL loc_lTemDados
1291:         loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
1292:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
1293:             THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
1294:         ENDIF
1295:     ENDPROC
1296: 
1297:     *==========================================================================
1298:     * BtnBuscarClick - Volta ao topo da grade principal e reposiciona painel
1299:     * Mapeamento OPERACIONAL: "buscar" = posicionar no inicio da lista
1300:     *==========================================================================
1301:     PROCEDURE BtnBuscarClick()
1302:         LOCAL loc_oErro, loc_lProsseguir
1303:         loc_lProsseguir = .T.
1304:         TRY
1305:             IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
1306:                 MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + "es para exibir.")
1307:                 loc_lProsseguir = .F.
1308:             ENDIF
1309:             IF loc_lProsseguir
1310:                 SELECT cursor_4c_Selecao
1311:                 GO TOP
1312:                 THIS.grd_4c_Dados.Refresh()
1313:                 THIS.GrdDadosAfterRowColChange(1)
1314:                 THIS.grd_4c_Dados.SetFocus()
1315:             ENDIF
1316:         CATCH TO loc_oErro
1317:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1318:                     "Erro BtnBuscar")
1319:         ENDTRY
1320:     ENDPROC
1321: 
1322:     *==========================================================================
1323:     * BtnSalvarClick - Alias de BtnConfirmarClick (padrao FormBase)
1324:     *==========================================================================
1325:     PROCEDURE BtnSalvarClick()
1326:         THIS.BtnConfirmarClick()
1327:     ENDPROC
1328: 
1329:     *==========================================================================
1330:     * BtnEncerrarClick - Alias de BtnCancelarClick (padrao FormBase canonico)
1331:     *==========================================================================
1332:     PROCEDURE BtnEncerrarClick()
1333:         THIS.BtnCancelarClick()
1334:     ENDPROC
1335: 
1336:     *==========================================================================
1337:     PROCEDURE Destroy()
1338:     *==========================================================================
1339:         *-- Encerrar relacao entre cursores antes de fechar
1340:         IF USED("cursor_4c_Selecao")
1341:             SELECT cursor_4c_Selecao
1342:             SET RELATION TO
1343:             USE IN cursor_4c_Selecao
1344:         ENDIF
1345:         IF USED("cursor_4c_PcpDados")
1346:             USE IN cursor_4c_PcpDados
1347:         ENDIF
1348:         *-- Remover arquivo temporario de imagem de produto
1349:         IF !EMPTY(THIS.this_cArquivoTempImg) AND FILE(THIS.this_cArquivoTempImg)
1350:             ERASE (THIS.this_cArquivoTempImg)
1351:         ENDIF
1352:         THIS.this_oBusinessObject = .NULL.
1353:         DODEFAULT()
1354:     ENDPROC
1355: 
1356: ENDDEFINE


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
    * MontarEmpDopNums - Monta a chave POSICIONAL EmpDopNums char(29)
    *
    * Legado (SIGPRPCP.Salva.Click):
    *     lcEdn = m.Emps + m.Dopes + Str(m.Numes,6)
    * Sem ALLTRIM: o padding FAZ PARTE da chave. Pelo schema,
    * SigMvCab.emps eh char(3), dopes eh char(20) e numes eh numeric(6,0),
    * somando exatamente os 29 de SigMvCab.empdopnums char(29).
    *
    * As properties this_cEmps/this_cDopes sao guardadas com ALLTRIM (vem de
    * CarregarDoCursor), entao o PADR tem de ser explicito aqui - concatenar as
    * partes aparadas produz uma chave curta que o WHERE nunca casa: o UPDATE
    * roda sem erro, afeta ZERO linha e a gravacao nao acontece (regra #42).
    *--------------------------------------------------------------------------
    FUNCTION MontarEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(NVL(par_cEmps, ""), 3) + ;
               PADR(NVL(par_cDopes, ""), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave concatenada do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.MontarEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
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
            THIS.this_cEmpDopNum = THIS.MontarEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
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

    *==========================================================================
    * Inserir() / ExecutarExclusao() - decisao de arquitetura: o legado
    * (SIGPRPCP.Salva.Click) so executa Update SigMvCab Set Priors = ... -
    * nao ha Insert nem Delete em tabela nenhuma neste formulario, que apenas
    * reprioriza Ordens de Producao ja existentes (vindas de SigCdNec/
    * SigPdMvf/SigOpPic). O comportamento padrao herdado de BusinessBase para
    * Inserir()/ExecutarExclusao() permanece correto aqui e NAO e sobrescrito.
    * A gravacao real esta em Atualizar() (registro unico) e
    * GravarPrioridades() (lote, espelhando o Scan do Salva.Click legado).
    *==========================================================================

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
                THIS.this_cEmps   = ALLTRIM(NVL(Emps, ""))
                THIS.this_cDopes  = ALLTRIM(NVL(Dopes, ""))
                THIS.this_nNumes  = NVL(Numes, 0)
                THIS.this_nPriors = loc_nPriors
                loc_cEdn    = THIS.MontarEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)

                loc_cSQL = "Update SigMvCab Set Priors = " + ;
                           FormatarNumeroSQL(loc_nPriors, 0) + ;
                           " Where EmpDopNums = " + EscaparSQL(loc_cEdn)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lSucesso = .F.
                    EXIT
                ENDIF

                *-- Audita cada OP cuja prioridade foi alterada (chave corrente)
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDSCAN

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT")
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

