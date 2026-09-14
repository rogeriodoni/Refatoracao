# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRCPD): Top original=104 vs migrado 'cnt_4c_Container1' Top=8 (diff=96px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container2' (parent: SIGPRCPD): Top original=104 vs migrado 'cnt_4c_Container2' Top=10 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container2' (parent: SIGPRCPD): Left original=288 vs migrado 'cnt_4c_Container2' Left=9 (diff=279px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1094 linhas total):

*-- Linhas 9 a 181:
9: *   CODE -> arquitetura em camadas (FormBase / sigprcpdBO)
10: *
11: * CHAMADA:
12: *   loForm = CREATEOBJECT("Formsigprcpd", cFase, cUnidade, dData, nCodigo)
13: *   loForm.Show()
14: *   par_cFase    = Fase/Setor (char)
15: *   par_cUnidade = Unidade de producao (char, vazio = todas)
16: *   par_dData    = Data de referencia (date)
17: *   par_nCodigo  = codigos PK de SigCdPcz (numeric)
18: *==============================================================================
19: 
20: DEFINE CLASS Formsigprcpd AS FormBase
21: 
22:     *-- Propriedades visuais (identicas ao legado)
23:     Height      = 600
24:     Width       = 800
25:     BorderStyle = 2
26:     AutoCenter  = .T.
27:     Caption     = "Capacidade Produtiva"
28:     TitleBar    = 0
29:     ShowWindow = 1
30:     ControlBox  = .F.
31:     Closable    = .F.
32:     MaxButton   = .F.
33:     MinButton   = .F.
34:     Movable     = .F.
35:     ClipControls = .F.
36:     DataSession  = 2
37:     WindowType   = 1
38: 
39:     *-- Parametros recebidos pelo Init (espelho de RESERVED3 do legado)
40:     this_nCodigo   = 0    && codigos PK de SigCdPcz
41:     this_cSetor    = ""   && Fase/Setor
42:     this_cUnidade  = ""   && Unidade de producao (vazio = todas)
43:     this_dData     = {}   && Data de referencia
44: 
45:     *-- Variaveis de estado
46:     this_cModoAtual = "CONSULTA"
47: 
48:     *==========================================================================
49:     PROCEDURE Init
50:     *==========================================================================
51:         LPARAMETERS par_cFase, par_cUnidade, par_dData, par_nCodigo
52: 
53:         *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
54:         *-- tenha acesso a eles via THIS.*
55:         IF VARTYPE(par_cFase) = "C"
56:             THIS.this_cSetor = ALLTRIM(par_cFase)
57:         ENDIF
58:         IF VARTYPE(par_cUnidade) = "C"
59:             THIS.this_cUnidade = ALLTRIM(par_cUnidade)
60:         ENDIF
61:         IF VARTYPE(par_dData) = "D"
62:             THIS.this_dData = par_dData
63:         ENDIF
64:         IF VARTYPE(par_nCodigo) = "N"
65:             THIS.this_nCodigo = par_nCodigo
66:         ENDIF
67: 
68:         RETURN DODEFAULT()
69:     ENDPROC
70: 
71:     *==========================================================================
72:     PROTECTED PROCEDURE InicializarForm
73:     *==========================================================================
74:         LOCAL loc_lSucesso, loc_oErro
75:         loc_lSucesso = .F.
76: 
77:         TRY
78:             *-- Fundo do form (identico ao legado: new_background.jpg)
79:             THIS.ConfigurarPageFrame()
80: 
81:             *-- Criar Business Object
82:             THIS.this_oBusinessObject = CREATEOBJECT("sigprcpdBO")
83:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
84:                 MsgErro("Falha ao criar sigprcpdBO.", "Erro Formsigprcpd")
85:             ELSE
86:                 *-- Cabecalho cinza superior (cntSombra do legado)
87:                 THIS.ConfigurarCabecalho()
88:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
89:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
90: 
91:                 *-- Container de filtros (Container1 do legado: Fase/Data)
92:                 THIS.ConfigurarContainer1()
93: 
94:                 *-- Container de capacidade (Container2 do legado: Cap/Utz/Sld)
95:                 THIS.ConfigurarContainer2()
96: 
97:                 *-- Area principal do form (grade + botao Encerrar)
98:                 *-- Agregado em ConfigurarPaginaLista por convencao do pipeline
99:                 THIS.ConfigurarPaginaLista()
100: 
101:                 *-- Area de detalhe do produto (labels/textboxes abaixo da grade)
102:                 THIS.ConfigurarDetalhesProduto()
103: 
104:                 *-- Tornar controles visiveis (AddObject cria Visible=.F.)
105:                 THIS.TornarControlesVisiveis()
106: 
107:                 *-- Guard: pular carregamento de dados se validando UI sem conexao SQL
108:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
109:                     IF gnConnHandle > 0
110:                         THIS.CarregarDados()
111:                     ELSE
112:                         MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
113:                                 "Erro Formsigprcpd")
114:                     ENDIF
115:                 ENDIF
116: 
117:                 loc_lSucesso = .T.
118:             ENDIF
119:         CATCH TO loc_oErro
120:             MsgErro("Erro ao inicializar Formsigprcpd: " + loc_oErro.Message + ;
121:                     " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
122:                     " Proc=" + loc_oErro.Procedure, "Erro")
123:         ENDTRY
124: 
125:         RETURN loc_lSucesso
126:     ENDPROC
127: 
128:     *==========================================================================
129:     PROTECTED PROCEDURE ConfigurarPageFrame
130:     *==========================================================================
131:         LOCAL loc_cImgFundo
132:         *-- Form OPERACIONAL flat (sem PageFrame CRUD)
133:         *-- Configura picture de fundo identico ao legado
134:         loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
135:         IF FILE(loc_cImgFundo)
136:             THIS.Picture = loc_cImgFundo
137:         ENDIF
138:     ENDPROC
139: 
140:     *==========================================================================
141:     PROTECTED PROCEDURE ConfigurarCabecalho
142:     *==========================================================================
143:         LOCAL loc_nW
144:         loc_nW = THIS.Width
145: 
146:         *-- Container cabecalho cinza (cntSombra do legado)
147:         *-- Propriedades originais: Top=1, Left=1, Width=800, Height=80
148:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
149:         WITH THIS.cnt_4c_Cabecalho
150:             .Top        = 1
151:             .Left       = 1
152:             .Width      = loc_nW - 2
153:             .Height     = 80
154:             .BackStyle  = 1
155:             .BackColor  = RGB(100, 100, 100)
156:             .BorderWidth = 0
157: 
158:             *-- Label sombra (texto escuro, deslocado 1px para efeito profundidade)
159:             .AddObject("lbl_4c_Sombra", "Label")
160:             WITH .lbl_4c_Sombra
161:                 .AutoSize  = .F.
162:                 .Width     = loc_nW - 2
163:                 .Height    = 40
164:                 .Top       = 18
165:                 .Left      = 10
166:                 .Caption   = "Capacidade Produtiva"
167:                 .FontName  = "Tahoma"
168:                 .FontSize  = 18
169:                 .FontBold  = .T.
170:                 .BackStyle = 0
171:                 .ForeColor = RGB(0, 0, 0)
172:                 .WordWrap  = .T.
173:                 .Alignment = 0
174:             ENDWITH
175: 
176:             *-- Label titulo (branco sobre cinza)
177:             .AddObject("lbl_4c_Titulo", "Label")
178:             WITH .lbl_4c_Titulo
179:                 .AutoSize  = .F.
180:                 .Width     = loc_nW - 2
181:                 .Height    = 46

*-- Linhas 189 a 238:
189:                 .ForeColor = RGB(255, 255, 255)
190:                 .WordWrap  = .T.
191:                 .Alignment = 0
192:             ENDWITH
193:         ENDWITH
194:         THIS.cnt_4c_Cabecalho.Visible = .T.
195:     ENDPROC
196: 
197:     *==========================================================================
198:     PROTECTED PROCEDURE ConfigurarContainer1
199:     *==========================================================================
200:         *-- Container de filtros: Fase e Data (Container1 do legado)
201:         *-- Propriedades originais: Top=104, Left=8, Width=278, Height=36
202:         THIS.AddObject("cnt_4c_Container1", "Container")
203:         WITH THIS.cnt_4c_Container1
204:             .Top          = 104
205:             .Left         = 8
206:             .Width        = 278
207:             .Height       = 36
208:             .BackStyle    = 0
209:             .BorderWidth  = 0
210:             .SpecialEffect = 0
211: 
212:             *-- Label "Fase :"
213:             .AddObject("lbl_4c_Fase", "Label")
214:             WITH .lbl_4c_Fase
215:                 .FontBold  = .T.
216:                 .FontName  = "Tahoma"
217:                 .FontSize  = 8
218:                 .BackStyle = 0
219:                 .Caption   = "Fase :"
220:                 .Height    = 17
221:                 .Left      = 2
222:                 .Top       = 8
223:                 .Width     = 40
224:                 .ForeColor = RGB(90, 90, 90)
225:             ENDWITH
226: 
227:             *-- TextBox Fase (somente leitura, preenche em CarregarDados)
228:             .AddObject("txt_4c_Fase", "TextBox")
229:             WITH .txt_4c_Fase
230:                 .FontBold  = .T.
231:                 .FontName  = "Tahoma"
232:                 .FontSize  = 8
233:                 .Height    = 23
234:                 .Left      = 44
235:                 .Top       = 5
236:                 .Width     = 100
237:                 .BackColor = RGB(255, 198, 140)
238:                 .ReadOnly  = .T.

*-- Linhas 272 a 315:
272:     ENDPROC
273: 
274:     *==========================================================================
275:     PROTECTED PROCEDURE ConfigurarContainer2
276:     *==========================================================================
277:         *-- Container de capacidade: Cap / Utz / Sld (Container2 do legado)
278:         *-- Propriedades originais: Top=104, Left=288, Width=504, Height=36
279:         THIS.AddObject("cnt_4c_Container2", "Container")
280:         WITH THIS.cnt_4c_Container2
281:             .Top          = 104
282:             .Left         = 288
283:             .Width        = 504
284:             .Height       = 36
285:             .BackStyle    = 0
286:             .BorderWidth  = 0
287:             .SpecialEffect = 0
288: 
289:             *-- Label "Capacidade:"
290:             .AddObject("lbl_4c_Capacidade", "Label")
291:             WITH .lbl_4c_Capacidade
292:                 .FontBold  = .T.
293:                 .FontName  = "Tahoma"
294:                 .FontSize  = 8
295:                 .BackStyle = 0
296:                 .Caption   = "Capacidade:"
297:                 .Height    = 15
298:                 .Left      = 9
299:                 .Top       = 10
300:                 .Width     = 70
301:                 .ForeColor = RGB(90, 90, 90)
302:             ENDWITH
303: 
304:             *-- TextBox Capacidade (somente leitura)
305:             .AddObject("txt_4c_Cap", "TextBox")
306:             WITH .txt_4c_Cap
307:                 .FontBold  = .T.
308:                 .FontName  = "Tahoma"
309:                 .FontSize  = 8
310:                 .Height    = 23
311:                 .InputMask = "99999"
312:                 .Left      = 81
313:                 .Top       = 5
314:                 .Width     = 63
315:                 .BackColor = RGB(255, 216, 176)

*-- Linhas 427 a 531:
427:     ENDPROC
428: 
429:     *==========================================================================
430:     PROTECTED PROCEDURE ConfigurarBotaoEncerrar
431:     *==========================================================================
432:         *-- Botao Encerrar (Sair do legado: Top=4, Left=725, Cancel=.T.)
433:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
434:         WITH THIS.cmd_4c_Encerrar
435:             .Top            = 4
436:             .Left           = 725
437:             .Width          = 75
438:             .Height         = 75
439:             .Caption        = "Encerrar"
440:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
441:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
442:             .Cancel         = .T.
443:             .FontName       = "Tahoma"
444:             .FontSize       = 8
445:             .FontBold       = .T.
446:             .FontItalic     = .T.
447:             .ForeColor      = RGB(90, 90, 90)
448:             .BackColor      = RGB(255, 255, 255)
449:             .Themes         = .T.
450:             .SpecialEffect  = 0
451:             .PicturePosition = 13
452:             .WordWrap       = .T.
453:             .AutoSize       = .F.
454:             .MousePointer   = 15
455:         ENDWITH
456:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
457:     ENDPROC
458: 
459:     *==========================================================================
460:     PROTECTED PROCEDURE TornarControlesVisiveis
461:     *==========================================================================
462:         LPARAMETERS par_oContainer
463:         LOCAL loc_oContainer, loc_i, loc_oControl
464: 
465:         IF VARTYPE(par_oContainer) = "O"
466:             loc_oContainer = par_oContainer
467:         ELSE
468:             loc_oContainer = THIS
469:         ENDIF
470: 
471:         FOR loc_i = 1 TO loc_oContainer.ControlCount
472:             loc_oControl = loc_oContainer.Controls(loc_i)
473:             IF VARTYPE(loc_oControl) = "O"
474:                 *-- Recursao para sub-containers
475:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
476:                     THIS.TornarControlesVisiveis(loc_oControl)
477:                 ENDIF
478:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
479:                     *-- img_4c_FigJpg e shp_4c_Shape4 sao flutuantes: iniciam Visible=.F.
480:                     *-- e ficam visiveis apenas quando ha foto do produto
481:                     *-- cnt_4c_Cabecalho gerencia propria visibilidade em ConfigurarCabecalho
482:                     IF !INLIST(LOWER(loc_oControl.Name), "img_4c_figjpg", "shp_4c_shape4", "cnt_4c_cabecalho")
483:                         loc_oControl.Visible = .T.
484:                     ENDIF
485:                 ENDIF
486:             ENDIF
487:         ENDFOR
488:     ENDPROC
489: 
490:     *==========================================================================
491:     PROCEDURE CarregarDados
492:     *==========================================================================
493:         LOCAL loc_lSucesso, loc_oErro
494:         loc_lSucesso = .F.
495: 
496:         TRY
497:             loc_lSucesso = THIS.this_oBusinessObject.CarregarDados(;
498:                 THIS.this_nCodigo, ;
499:                 THIS.this_cSetor, ;
500:                 THIS.this_cUnidade, ;
501:                 THIS.this_dData)
502: 
503:             IF loc_lSucesso
504:                 *-- Preencher Container1: Fase e Data
505:                 THIS.cnt_4c_Container1.txt_4c_Fase.Value = THIS.this_cSetor
506:                 THIS.cnt_4c_Container1.txt_4c_Data.Value = THIS.this_dData
507: 
508:                 *-- Preencher Container2: Capacidade, Utilizado, Saldo
509:                 THIS.cnt_4c_Container2.txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
510:                 THIS.cnt_4c_Container2.txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
511:                 THIS.cnt_4c_Container2.txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo
512: 
513:                 *-- Bind do grid (ColumnCount ANTES de RecordSource - regra critica)
514:                 THIS.grd_4c_Dados.ColumnCount  = 8
515:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
516: 
517:                 *-- Configurar colunas (APOS RecordSource para evitar reset de headers)
518:                 *-- ColumnOrder=1 em Column8: Unidade Prod. aparece primeiro (identico ao legado)
519:                 WITH THIS.grd_4c_Dados
520:                     WITH .Column1
521:                         .ColumnOrder   = 2
522:                         .Width         = 80
523:                         .Alignment     = 2
524:                         .Movable       = .F.
525:                         .Resizable     = .F.
526:                         .ReadOnly      = .T.
527:                         .ControlSource = "cursor_4c_Dados.Nenvs"
528:                         .Header1.Caption   = "Envelope"
529:                         .Header1.FontName  = "Tahoma"
530:                         .Header1.FontSize  = 8
531:                         .Header1.Alignment = 2

*-- Linhas 636 a 801:
636:                     THIS.grd_4c_Dados.SetFocus
637:                 ENDIF
638:             ELSE
639:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar os dados de capacidade produtiva.", ;
640:                          "Aviso")
641:             ENDIF
642:         CATCH TO loc_oErro
643:             MsgErro("Erro ao carregar dados: " + loc_oErro.Message + ;
644:                     " Ln=" + TRANSFORM(loc_oErro.LineNo), "Erro Formsigprcpd")
645:         ENDTRY
646: 
647:         RETURN loc_lSucesso
648:     ENDPROC
649: 
650:     *==========================================================================
651:     PROCEDURE CmdEncerrarClick
652:     *==========================================================================
653:         THIS.Release()
654:     ENDPROC
655: 
656:     *==========================================================================
657:     PROCEDURE BtnIncluirClick
658:     *==========================================================================
659:         *-- Form OPERACIONAL de consulta de Capacidade Produtiva (read-only):
660:         *-- recarrega os dados do banco (efeito de "refresh completo" da grade).
661:         *-- Equivalente a repetir a chamada do menu com os mesmos parametros.
662:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR gnConnHandle <= 0
663:             RETURN
664:         ENDIF
665:         THIS.CarregarDados()
666:     ENDPROC
667: 
668:     *==========================================================================
669:     PROCEDURE BtnAlterarClick
670:     *==========================================================================
671:         *-- Form OPERACIONAL de consulta (read-only): recarrega os dados do
672:         *-- banco. Identico a BtnIncluirClick por semantica de viewer.
673:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR gnConnHandle <= 0
674:             RETURN
675:         ENDIF
676:         THIS.CarregarDados()
677:     ENDPROC
678: 
679:     *==========================================================================
680:     PROCEDURE BtnVisualizarClick
681:     *==========================================================================
682:         *-- Reposiciona no primeiro registro da grade e re-renderiza detalhes
683:         *-- do produto (foto, descricao, cliente, tempo do envelope) para a
684:         *-- linha corrente. Util quando o preview fica dessincronizado apos
685:         *-- scroll rapido ou LockScreen.
686:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
687:             RETURN
688:         ENDIF
689:         SELECT cursor_4c_Dados
690:         GO TOP
691:         THIS.grd_4c_Dados.Refresh()
692:         THIS.GrdDadosAfterRowColChange(1)
693:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
694:             THIS.grd_4c_Dados.SetFocus()
695:         ENDIF
696:     ENDPROC
697: 
698:     *==========================================================================
699:     PROCEDURE BtnExcluirClick
700:     *==========================================================================
701:         *-- Form OPERACIONAL de consulta (read-only): encerra a janela.
702:         *-- Alias de CmdEncerrarClick (mesmo comportamento do botao Encerrar).
703:         THIS.Release()
704:     ENDPROC
705: 
706:     *==========================================================================
707:     PROTECTED PROCEDURE ConfigurarPaginaLista
708:     *==========================================================================
709:         *-- Form OPERACIONAL flat (sem PageFrame CRUD). Agrega os controles
710:         *-- do "view principal": grade de envelopes/O.P. + botao Encerrar.
711:         *-- Detalhes do produto sao configurados em ConfigurarDetalhesProduto.
712:         THIS.ConfigurarGrade()
713:         THIS.ConfigurarBotaoEncerrar()
714:     ENDPROC
715: 
716:     *==========================================================================
717:     PROTECTED PROCEDURE AlternarPagina
718:     *==========================================================================
719:         LPARAMETERS par_nPagina
720:         *-- Form OPERACIONAL flat: nao possui multiplas paginas. O parametro
721:         *-- eh aceito por compatibilidade com o padrao CRUD do pipeline; a
722:         *-- unica acao util eh recarregar os dados da grade (equivalente a
723:         *-- voltar para a "lista") quando solicitado.
724:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina = 1
725:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND gnConnHandle > 0
726:                 THIS.CarregarDados()
727:             ENDIF
728:         ENDIF
729:     ENDPROC
730: 
731:     *==========================================================================
732:     PROTECTED PROCEDURE ConfigurarGrade
733:     *==========================================================================
734:         *-- Grade principal (Grade do legado): 8 colunas, layout identico ao SCX
735:         *-- Top=139, Left=0, Width=801, Height=310, ColumnCount=8
736:         THIS.AddObject("grd_4c_Dados", "Grid")
737:         WITH THIS.grd_4c_Dados
738:             .Top              = 139
739:             .Left             = 0
740:             .Width            = 801
741:             .Height           = 310
742:             .ColumnCount      = 8
743:             .FontName         = "Arial"
744:             .FontSize         = 8
745:             .ForeColor        = RGB(90, 90, 90)
746:             .BackColor        = RGB(255, 255, 255)
747:             .GridLineColor    = RGB(238, 238, 238)
748:             .HighlightBackColor = RGB(255, 255, 255)
749:             .HighlightForeColor = RGB(15, 41, 104)
750:             .HighlightStyle   = 2
751:             .RecordMark       = .F.
752:             .DeleteMark       = .F.
753:             .RowHeight        = 16
754:             .ScrollBars       = 2
755:             .ReadOnly         = .T.
756:         ENDWITH
757:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
758:     ENDPROC
759: 
760:     *==========================================================================
761:     PROTECTED PROCEDURE ConfigurarDetalhesProduto
762:     *==========================================================================
763:         *-- Shape4: borda ao redor da foto do produto (inicialmente oculto)
764:         THIS.AddObject("shp_4c_Shape4", "Shape")
765:         WITH THIS.shp_4c_Shape4
766:             .Top       = 455
767:             .Left      = 456
768:             .Width     = 148
769:             .Height    = 109
770:             .BackStyle = 1
771:             .BackColor = RGB(200, 200, 200)
772:             .Visible   = .F.
773:         ENDWITH
774: 
775:         *-- FigJpg: imagem do produto decodificada de base64 (inicialmente oculta)
776:         THIS.AddObject("img_4c_FigJpg", "Image")
777:         WITH THIS.img_4c_FigJpg
778:             .Top     = 457
779:             .Left    = 459
780:             .Width   = 143
781:             .Height  = 105
782:             .Stretch = 1
783:             .Visible = .F.
784:         ENDWITH
785: 
786:         *-- Label "Quantidade" (Say1 do legado)
787:         THIS.AddObject("lbl_4c_LblQtde", "Label")
788:         WITH THIS.lbl_4c_LblQtde
789:             .AutoSize  = .F.
790:             .FontName  = "Tahoma"
791:             .FontSize  = 8
792:             .BackStyle = 0
793:             .Caption   = "Quantidade"
794:             .Top       = 455
795:             .Left      = 11
796:             .Width     = 74
797:             .Height    = 15
798:             .ForeColor = RGB(90, 90, 90)
799:         ENDWITH
800: 
801:         *-- TextBox Quantidade (Get_qtde do legado) - SigCdPco.qtds

*-- Linhas 925 a 968:
925:     ENDPROC
926: 
927:     *==========================================================================
928:     PROCEDURE GrdDadosAfterRowColChange
929:     *==========================================================================
930:         LPARAMETERS par_nColIndex
931:         LOCAL loc_oErro, loc_cCpros
932:         loc_cCpros = ""
933: 
934:         TRY
935:             THIS.LockScreen = .T.
936: 
937:             *-- Limpar campos de detalhe e foto antes de preencher
938:             THIS.img_4c_FigJpg.Visible = .F.
939:             THIS.img_4c_FigJpg.Picture = ""
940:             THIS.shp_4c_Shape4.Visible = .F.
941:             THIS.txt_4c_Descr.Value    = ""
942:             THIS.txt_4c_Qtde.Value     = 0
943:             THIS.txt_4c_Cliente.Value  = ""
944:             THIS.txt_4c_TEnv.Value     = 0
945: 
946:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
947:                 SELECT cursor_4c_Dados
948:                 loc_cCpros = ALLTRIM(NVL(Cpros, ""))
949: 
950:                 *-- Preencher campos de detalhe da linha corrente
951:                 THIS.txt_4c_Qtde.Value    = NVL(Qtds, 0)
952:                 THIS.txt_4c_Cliente.Value = ALLTRIM(NVL(Rclis, ""))
953:                 THIS.txt_4c_TEnv.Value    = NVL(TempU, 0)
954: 
955:                 *-- Carregar foto e descricao do produto via BO
956:                 IF !EMPTY(loc_cCpros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
957:                     THIS.this_oBusinessObject.CarregarFotoProduto(loc_cCpros)
958: 
959:                     THIS.txt_4c_Descr.Value = ;
960:                         ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescricaoProduto, ""))
961: 
962:                     IF !EMPTY(THIS.this_oBusinessObject.this_cFotoArquivo) AND ;
963:                        FILE(THIS.this_oBusinessObject.this_cFotoArquivo)
964:                         THIS.img_4c_FigJpg.Picture = THIS.this_oBusinessObject.this_cFotoArquivo
965:                         THIS.img_4c_FigJpg.Visible = .T.
966:                         THIS.shp_4c_Shape4.Visible  = .T.
967:                     ENDIF
968:                 ENDIF

*-- Linhas 977 a 1094:
977:     ENDPROC
978: 
979:     *==========================================================================
980:     PROTECTED PROCEDURE ConfigurarPaginaDados
981:     *==========================================================================
982:         *-- Form OPERACIONAL flat: nao possui Page2/Dados separada.
983:         *-- Os controles de "detalhe" (Qtde, Descr, Cliente, TEnv, FigJpg,
984:         *-- Shape4, Prioridade) sao criados em ConfigurarDetalhesProduto(),
985:         *-- chamado diretamente por InicializarForm(). Metodo presente por
986:         *-- compatibilidade com o padrao multi-fase do pipeline (Fase 5/8);
987:         *-- nao cria controles (evitar AddObject duplicado).
988:         RETURN .T.
989:     ENDPROC
990: 
991:     *==========================================================================
992:     PROCEDURE CarregarLista
993:     *==========================================================================
994:         *-- Form OPERACIONAL: alias de CarregarDados (compatibilidade pipeline)
995:         THIS.CarregarDados()
996:     ENDPROC
997: 
998:     *==========================================================================
999:     PROCEDURE BOParaForm
1000:     *==========================================================================
1001:         *-- Popula campos de exibicao a partir do BO e do cursor corrente
1002:         IF !USED("cursor_4c_Dados")
1003:             RETURN
1004:         ENDIF
1005: 
1006:         THIS.cnt_4c_Container1.txt_4c_Fase.Value = THIS.this_cSetor
1007:         THIS.cnt_4c_Container1.txt_4c_Data.Value = THIS.this_dData
1008: 
1009:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1010:             THIS.cnt_4c_Container2.txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
1011:             THIS.cnt_4c_Container2.txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
1012:             THIS.cnt_4c_Container2.txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo
1013:         ENDIF
1014:     ENDPROC
1015: 
1016:     *==========================================================================
1017:     PROCEDURE FormParaBO
1018:     *==========================================================================
1019:         *-- Form OPERACIONAL read-only: sem campos editaveis para transferir ao BO
1020:         RETURN .T.
1021:     ENDPROC
1022: 
1023:     *==========================================================================
1024:     PROCEDURE HabilitarCampos
1025:     *==========================================================================
1026:         LPARAMETERS par_lHabilitar
1027:         *-- Form OPERACIONAL: todos os campos sao ReadOnly - sem controles a habilitar
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     PROCEDURE LimparCampos
1032:     *==========================================================================
1033:         *-- Limpa todos os campos de exibicao do form
1034:         THIS.cnt_4c_Container1.txt_4c_Fase.Value = ""
1035:         THIS.cnt_4c_Container1.txt_4c_Data.Value = {}
1036:         THIS.cnt_4c_Container2.txt_4c_Cap.Value  = 0
1037:         THIS.cnt_4c_Container2.txt_4c_Utz.Value  = 0
1038:         THIS.cnt_4c_Container2.txt_4c_Sld.Value  = 0
1039:         THIS.txt_4c_Descr.Value    = ""
1040:         THIS.txt_4c_Qtde.Value     = 0
1041:         THIS.txt_4c_Cliente.Value  = ""
1042:         THIS.txt_4c_TEnv.Value     = 0
1043:         THIS.img_4c_FigJpg.Visible = .F.
1044:         THIS.img_4c_FigJpg.Picture = ""
1045:         THIS.shp_4c_Shape4.Visible = .F.
1046:     ENDPROC
1047: 
1048:     *==========================================================================
1049:     PROCEDURE AjustarBotoesPorModo
1050:     *==========================================================================
1051:         LPARAMETERS par_cModo
1052:         *-- Form OPERACIONAL flat (sem botoes CRUD): sem ajuste de botoes por modo
1053:     ENDPROC
1054: 
1055:     *==========================================================================
1056:     PROCEDURE BtnEncerrarClick
1057:     *==========================================================================
1058:         THIS.Release()
1059:     ENDPROC
1060: 
1061:     *==========================================================================
1062:     PROCEDURE BtnBuscarClick
1063:     *==========================================================================
1064:         *-- Recarrega os dados do banco (refresh da grade de capacidade produtiva)
1065:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR gnConnHandle <= 0
1066:             RETURN
1067:         ENDIF
1068:         THIS.CarregarDados()
1069:     ENDPROC
1070: 
1071:     *==========================================================================
1072:     PROCEDURE BtnSalvarClick
1073:     *==========================================================================
1074:         *-- Form OPERACIONAL read-only: sem acao de salvar
1075:         RETURN .T.
1076:     ENDPROC
1077: 
1078:     *==========================================================================
1079:     PROCEDURE BtnCancelarClick
1080:     *==========================================================================
1081:         *-- Form OPERACIONAL: cancelar = encerrar o visualizador
1082:         THIS.Release()
1083:     ENDPROC
1084: 
1085:     *==========================================================================
1086:     PROCEDURE Destroy
1087:     *==========================================================================
1088:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1089:             THIS.this_oBusinessObject = .NULL.
1090:         ENDIF
1091:         DODEFAULT()
1092:     ENDPROC
1093: 
1094: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcpdBO.prg):
*==============================================================================
* sigprcpdBO.prg - Business Object: Capacidade Produtiva
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Colunas da tabela SigCdPcz (mapeadas 1:1 com o schema)
    this_nCodigo    = 0    && codigos numeric(10,0) NOT NULL - PK
    this_cContas    = ""   && contas char(10) NOT NULL
    this_cCvens     = ""   && cvens char(10) NOT NULL
    this_dData      = {}   && datas datetime NULL
    this_cDopes     = ""   && dopes char(20) NOT NULL
    this_dDtLancs   = {}   && dtlancs datetime NULL
    this_dEmissaoF  = {}   && emissaof datetime NULL
    this_dEmissaoI  = {}   && emissaoi datetime NULL
    this_cEmps      = ""   && emps char(3) NOT NULL
    this_nNumeFs    = 0    && numefs numeric(6,0) NOT NULL
    this_nNumeIs    = 0    && numeis numeric(6,0) NOT NULL
    this_dPrevFs    = {}   && prevfs datetime NULL
    this_dPrevIs    = {}   && previs datetime NULL
    this_cTitulos   = ""   && titulos char(50) NOT NULL

    *-- Parametros de contexto recebidos pelo form chamador
    this_cSetor     = ""   && Fase/Setor (contexto do form)
    this_cUnidade   = ""   && Unidade de producao (vazio = todas)

    *-- Dados de capacidade agregados (SigCdPcP por data/fase/unidade)
    this_nCapacidade  = 0  && Capacidade total em minutos
    this_nUtilizado   = 0  && Minutos utilizados (minutos - saldos)
    this_nSaldo       = 0  && Saldo de minutos

    *-- Dados do produto da linha selecionada no grid
    this_cDescricaoProduto = ""   && Dpros de SigCdPro
    this_cFotoArquivo      = ""   && Caminho temporario do JPEG decodificado

    *-- Dados exibidos abaixo do grid (linha corrente de zTmpPcpOp)
    this_nQtde          = 0   && Qtds da ordem
    this_cClienteNome   = ""  && Rclis do cliente
    this_nTempoEnvelope = 0   && TempU (tempo total do envelope em minutos)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPcz"
        THIS.this_cCampoChave = "codigos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (SigCdPcz.codigos)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(TRANSFORM(THIS.this_nCodigo))
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas de SigCdPcz para as
    * propriedades do BO. Recebe o alias do cursor aberto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nCodigo   = NVL(codigos, 0)
            THIS.this_cContas   = NVL(contas, "")
            THIS.this_cCvens    = NVL(cvens, "")
            THIS.this_dData     = NVL(datas, {})
            THIS.this_cDopes    = NVL(dopes, "")
            THIS.this_dDtLancs  = NVL(dtlancs, {})
            THIS.this_dEmissaoF = NVL(emissaof, {})
            THIS.this_dEmissaoI = NVL(emissaoi, {})
            THIS.this_cEmps     = NVL(emps, "")
            THIS.this_nNumeFs   = NVL(numefs, 0)
            THIS.this_nNumeIs   = NVL(numeis, 0)
            THIS.this_dPrevFs   = NVL(prevfs, {})
            THIS.this_dPrevIs   = NVL(previs, {})
            THIS.this_cTitulos  = NVL(titulos, "")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um novo registro de processo em SigCdPcz.
    * Retorna .T. se sucesso, .F. em falha.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmpresa
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                        "Erro sigprcpdBO.Inserir")
            ELSE
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
                IF EMPTY(loc_cEmpresa)
                    loc_cEmpresa = ALLTRIM(THIS.this_cEmps)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdPcz (" + ;
                    "codigos, contas, cvens, datas, dopes, dtlancs, " + ;
                    "emissaof, emissaoi, emps, numefs, numeis, " + ;
                    "prevfs, previs, titulos" + ;
                    ") VALUES (" + ;
                    FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cCvens, 10)) + ", " + ;
                    FormatarDataSQL(THIS.this_dData) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                    FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                    FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                    FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                    EscaparSQL(LEFT(loc_cEmpresa, 3)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNumeFs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNumeIs, 0) + ", " + ;
                    FormatarDataSQL(THIS.this_dPrevFs) + ", " + ;
                    FormatarDataSQL(THIS.this_dPrevIs) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cTitulos, 50)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Falha ao inserir processo em SigCdPcz.", ;
                            "Erro sigprcpdBO.Inserir")
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro sigprcpdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o registro corrente em SigCdPcz (chave: codigos).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                        "Erro sigprcpdBO.Atualizar")
            ELSE
                IF THIS.this_nCodigo <= 0
                    MsgAviso("Processo sem c" + CHR(243) + "digo: use Inserir para gravar novo registro.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_cSQL = "UPDATE SigCdPcz SET " + ;
                        "contas = "   + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                        "cvens = "    + EscaparSQL(LEFT(THIS.this_cCvens, 10)) + ", " + ;
                        "datas = "    + FormatarDataSQL(THIS.this_dData) + ", " + ;
                        "dopes = "    + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                        "dtlancs = "  + FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                        "emissaof = " + FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                        "emissaoi = " + FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                        "numefs = "   + FormatarNumeroSQL(THIS.this_nNumeFs, 0) + ", " + ;
                        "numeis = "   + FormatarNumeroSQL(THIS.this_nNumeIs, 0) + ", " + ;
                        "prevfs = "   + FormatarDataSQL(THIS.this_dPrevFs) + ", " + ;
                        "previs = "   + FormatarDataSQL(THIS.this_dPrevIs) + ", " + ;
                        "titulos = "  + EscaparSQL(LEFT(THIS.this_cTitulos, 50)) + " " + ;
                        "WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        MsgErro("Falha ao atualizar processo em SigCdPcz.", ;
                                "Erro sigprcpdBO.Atualizar")
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro sigprcpdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_oErro, loc_cSQL, loc_cUsuario, loc_cChave

        TRY
            IF gnConnHandle > 0
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
                loc_cChave   = THIS.ObterChavePrimaria()

                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                    "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                    "VALUES (GETDATE(), " + ;
                    EscaparSQL(loc_cUsuario) + ", " + ;
                    EscaparSQL("SigCdPcz") + ", " + ;
                    EscaparSQL(par_cOperacao) + ", " + ;
                    EscaparSQL(loc_cChave) + ")"

                =SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper fluxo principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega todos os cursores de capacidade produtiva
    * Par?metros: par_nCodigo (SigCdPcz.codigos), par_cFase, par_cUnidade, par_dData
    * Retorna: .T. se sucesso, .F. se falha
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_nCodigo, par_cFase, par_cUnidade, par_dData)
        LOCAL loc_lSucesso, loc_lCont, loc_cSQL, loc_cFiltro, loc_cFiltroA
        loc_lSucesso = .F.
        loc_lCont    = .T.
        loc_cFiltro  = ""
        loc_cFiltroA = ""

        TRY
            THIS.this_nCodigo  = par_nCodigo
            THIS.this_cSetor   = par_cFase
            THIS.this_cUnidade = par_cUnidade
            THIS.this_dData    = par_dData

            IF !EMPTY(par_cUnidade)
                loc_cFiltro  = " AND UniPrdts = " + EscaparSQL(par_cUnidade)
                loc_cFiltroA = " AND a.UniPrdts = " + EscaparSQL(par_cUnidade)
            ENDIF

            *-- 1. Processo (SigCdPcz)
            IF loc_lCont
                loc_cSQL = "SELECT * FROM SigCdPcz WHERE codigos = " + ;
                           FormatarNumeroSQL(par_nCodigo, 0)

                IF USED("cursor_4c_Processo")
                    USE IN cursor_4c_Processo
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Processo") < 1
                    MsgErro("Falha ao carregar processo (SigCdPcz).", "Erro")
                    loc_lCont = .F.
                ENDIF
            ENDIF

            *-- 2. Capacidade agregada (SigCdPcP): minutos, utilizados, saldos
            IF loc_lCont
                loc_cSQL = "SELECT Codigos, " + ;
                           "SUM(minutos) AS Minutos, " + ;
                           "SUM(minutos - Saldos) AS Utilizados, " + ;
                           "SUM(saldos) AS Saldos " + ;
                           "FROM SigCdPcP " + ;
                           "WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
                           " AND Datas = " + FormatarDataSQL(par_dData) + ;
                           " AND Fases = " + EscaparSQL(par_cFase) + ;
                           loc_cFiltro + ;
                           " GROUP BY Codigos"

                IF USED("cursor_4c_Capacidade")
                    USE IN cursor_4c_Capacidade
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Capacidade") < 1
                    MsgErro("Falha ao carregar capacidade (SigCdPcP).", "Erro")
                    loc_lCont = .F.
                ELSE
                    SELECT cursor_4c_Capacidade
                    GO TOP
                    IF !EOF()
                        THIS.this_nCapacidade = NVL(Minutos, 0)
                        THIS.this_nUtilizado  = NVL(Utilizados, 0)
                        THIS.this_nSaldo      = NVL(Saldos, 0)
                    ENDIF
                ENDIF
            ENDIF

            *-- 3. Grade de sequ" + CHR(234) + "ncias (SigCdPcg)
            IF loc_lCont
                loc_cSQL = "SELECT * FROM SigCdPcg " + ;
                           "WHERE datas = " + FormatarDataSQL(par_dData) + ;
                           " AND Fases = " + EscaparSQL(par_cFase) + ;
                           " AND Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
                           loc_cFiltro + ;
                           " ORDER BY Cidchaves"

                IF USED("cursor_4c_Grade")
                    USE IN cursor_4c_Grade
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grade") < 1
                    MsgErro("Falha ao carregar grade (SigCdPcg).", "Erro")
                    loc_lCont = .F.
                ENDIF
            ENDIF

            *-- 4. Ordens com cliente (SigCdPco JOIN SigCdCli)
            IF loc_lCont
                loc_cSQL = "SELECT a.*, " + ;
                           "a.dopes + '-' + STR(a.numes, 6) AS Pedido, " + ;
                           "a.contas + '-' + b.rclis AS cliente, " + ;
                           "b.Rclis " + ;
                           "FROM SigCdPco a, SigCdCli b " + ;
                           "WHERE a.Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
                           " AND a.Fases = " + EscaparSQL(par_cFase) + ;
                           loc_cFiltroA + ;
                           " AND a.Contas = b.Iclis " + ;
                           "ORDER BY a.UniPrdts, a.Seqs, a.Nenvs"

                IF USED("cursor_4c_OrdensTemp")
                    USE IN cursor_4c_OrdensTemp
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OrdensTemp") < 1
                    MsgErro("Falha ao carregar ordens (SigCdPco).", "Erro")
                    loc_lCont = .F.
                ENDIF
            ENDIF

            *-- 5. Agrupamento por envelope/seq (SELECT VFP local)
            IF loc_lCont
                IF USED("cursor_4c_GrupoOp")
                    USE IN cursor_4c_GrupoOp
                ENDIF

                SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, ;
                       SUM(a.Minutos) AS Minutos ;
                FROM cursor_4c_OrdensTemp a, cursor_4c_Grade b ;
                WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                      b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
                GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs ;
                INTO CURSOR cursor_4c_GrupoOp READWRITE
            ENDIF

            *-- 6. Cursor final do grid com TempoReal proporcional (SELECT VFP local)
            IF loc_lCont
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                       IIF(c.Minutos = 0, 0, ;
                           (a.minutos * 60) / (c.Minutos * 60) * (b.Minutos * 60)) AS TempoReal ;
                FROM cursor_4c_OrdensTemp a, cursor_4c_Grade b, cursor_4c_GrupoOp c ;
                WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                      b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
                AND   a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                      c.Fases + c.UniPrdts + STR(c.Nenvs,10) + STR(c.Seqs,2) ;
                ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs ;
                INTO CURSOR cursor_4c_Dados READWRITE

                SELECT cursor_4c_Dados
                GO TOP

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarFotoProduto - Carrega foto e descri" + CHR(231) + CHR(227) + "o do produto selecionado no grid
    * Par?metro: par_cCpros - c?digo do produto (SigCdPro.Cpros)
    * Retorna: .T. se sucesso
    * Efeitos: popula this_cDescricaoProduto e this_cFotoArquivo
    *--------------------------------------------------------------------------
    FUNCTION CarregarFotoProduto(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_cArqTemp, loc_cFotoBase64
        loc_lSucesso = .F.
        THIS.this_cDescricaoProduto = ""
        THIS.this_cFotoArquivo      = ""

        TRY
            loc_cSQL = "SELECT FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + ;
                       EscaparSQL(ALLTRIM(par_cCpros))

            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto") >= 1
                SELECT cursor_4c_Produto
                GO TOP

                IF !EOF()
                    THIS.this_cDescricaoProduto = NVL(Dpros, "")

                    IF !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
                        loc_cArqTemp    = SYS(2023) + "\sigprcpd.jpg"
                        loc_cFotoBase64 = STRCONV(;
                            STRTRAN(;
                                STRTRAN(;
                                    STRTRAN(FigJpgs, "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)

                        IF STRTOFILE(loc_cFotoBase64, loc_cArqTemp) > 0
                            THIS.this_cFotoArquivo = loc_cArqTemp
                        ENDIF
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar foto do produto")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

