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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1091 linhas total):

*-- Linhas 9 a 179:
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
88: 
89:                 *-- Container de filtros (Container1 do legado: Fase/Data)
90:                 THIS.ConfigurarContainer1()
91: 
92:                 *-- Container de capacidade (Container2 do legado: Cap/Utz/Sld)
93:                 THIS.ConfigurarContainer2()
94: 
95:                 *-- Area principal do form (grade + botao Encerrar)
96:                 *-- Agregado em ConfigurarPaginaLista por convencao do pipeline
97:                 THIS.ConfigurarPaginaLista()
98: 
99:                 *-- Area de detalhe do produto (labels/textboxes abaixo da grade)
100:                 THIS.ConfigurarDetalhesProduto()
101: 
102:                 *-- Tornar controles visiveis (AddObject cria Visible=.F.)
103:                 THIS.TornarControlesVisiveis()
104: 
105:                 *-- Guard: pular carregamento de dados se validando UI sem conexao SQL
106:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
107:                     IF gnConnHandle > 0
108:                         THIS.CarregarDados()
109:                     ELSE
110:                         MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
111:                                 "Erro Formsigprcpd")
112:                     ENDIF
113:                 ENDIF
114: 
115:                 loc_lSucesso = .T.
116:             ENDIF
117:         CATCH TO loc_oErro
118:             MsgErro("Erro ao inicializar Formsigprcpd: " + loc_oErro.Message + ;
119:                     " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
120:                     " Proc=" + loc_oErro.Procedure, "Erro")
121:         ENDTRY
122: 
123:         RETURN loc_lSucesso
124:     ENDPROC
125: 
126:     *==========================================================================
127:     PROTECTED PROCEDURE ConfigurarPageFrame
128:     *==========================================================================
129:         LOCAL loc_cImgFundo
130:         *-- Form OPERACIONAL flat (sem PageFrame CRUD)
131:         *-- Configura picture de fundo identico ao legado
132:         loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
133:         IF FILE(loc_cImgFundo)
134:             THIS.Picture = loc_cImgFundo
135:         ENDIF
136:     ENDPROC
137: 
138:     *==========================================================================
139:     PROTECTED PROCEDURE ConfigurarCabecalho
140:     *==========================================================================
141:         LOCAL loc_nW
142:         loc_nW = THIS.Width
143: 
144:         *-- Container cabecalho cinza (cntSombra do legado)
145:         *-- Propriedades originais: Top=1, Left=1, Width=800, Height=80
146:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
147:         WITH THIS.cnt_4c_Cabecalho
148:             .Top        = 1
149:             .Left       = 1
150:             .Width      = loc_nW - 2
151:             .Height     = 80
152:             .BackStyle  = 1
153:             .BackColor  = RGB(100, 100, 100)
154:             .BorderWidth = 0
155: 
156:             *-- Label sombra (texto escuro, deslocado 1px para efeito profundidade)
157:             .AddObject("lbl_4c_Sombra", "Label")
158:             WITH .lbl_4c_Sombra
159:                 .AutoSize  = .F.
160:                 .Width     = loc_nW - 2
161:                 .Height    = 40
162:                 .Top       = 18
163:                 .Left      = 10
164:                 .Caption   = "Capacidade Produtiva"
165:                 .FontName  = "Tahoma"
166:                 .FontSize  = 18
167:                 .FontBold  = .T.
168:                 .BackStyle = 0
169:                 .ForeColor = RGB(0, 0, 0)
170:                 .WordWrap  = .T.
171:                 .Alignment = 0
172:             ENDWITH
173: 
174:             *-- Label titulo (branco sobre cinza)
175:             .AddObject("lbl_4c_Titulo", "Label")
176:             WITH .lbl_4c_Titulo
177:                 .AutoSize  = .F.
178:                 .Width     = loc_nW - 2
179:                 .Height    = 46

*-- Linhas 187 a 236:
187:                 .ForeColor = RGB(255, 255, 255)
188:                 .WordWrap  = .T.
189:                 .Alignment = 0
190:             ENDWITH
191:         ENDWITH
192:         THIS.cnt_4c_Cabecalho.Visible = .T.
193:     ENDPROC
194: 
195:     *==========================================================================
196:     PROTECTED PROCEDURE ConfigurarContainer1
197:     *==========================================================================
198:         *-- Container de filtros: Fase e Data (Container1 do legado)
199:         *-- Propriedades originais: Top=104, Left=8, Width=278, Height=36
200:         THIS.AddObject("cnt_4c_Container1", "Container")
201:         WITH THIS.cnt_4c_Container1
202:             .Top          = 104
203:             .Left         = 8
204:             .Width        = 278
205:             .Height       = 36
206:             .BackStyle    = 0
207:             .BorderWidth  = 0
208:             .SpecialEffect = 0
209: 
210:             *-- Label "Fase :"
211:             .AddObject("lbl_4c_Fase", "Label")
212:             WITH .lbl_4c_Fase
213:                 .FontBold  = .T.
214:                 .FontName  = "Tahoma"
215:                 .FontSize  = 8
216:                 .BackStyle = 0
217:                 .Caption   = "Fase :"
218:                 .Height    = 17
219:                 .Left      = 2
220:                 .Top       = 8
221:                 .Width     = 40
222:                 .ForeColor = RGB(90, 90, 90)
223:             ENDWITH
224: 
225:             *-- TextBox Fase (somente leitura, preenche em CarregarDados)
226:             .AddObject("txt_4c_Fase", "TextBox")
227:             WITH .txt_4c_Fase
228:                 .FontBold  = .T.
229:                 .FontName  = "Tahoma"
230:                 .FontSize  = 8
231:                 .Height    = 23
232:                 .Left      = 44
233:                 .Top       = 5
234:                 .Width     = 100
235:                 .BackColor = RGB(255, 198, 140)
236:                 .ReadOnly  = .T.

*-- Linhas 270 a 313:
270:     ENDPROC
271: 
272:     *==========================================================================
273:     PROTECTED PROCEDURE ConfigurarContainer2
274:     *==========================================================================
275:         *-- Container de capacidade: Cap / Utz / Sld (Container2 do legado)
276:         *-- Propriedades originais: Top=104, Left=288, Width=504, Height=36
277:         THIS.AddObject("cnt_4c_Container2", "Container")
278:         WITH THIS.cnt_4c_Container2
279:             .Top          = 104
280:             .Left         = 288
281:             .Width        = 504
282:             .Height       = 36
283:             .BackStyle    = 0
284:             .BorderWidth  = 0
285:             .SpecialEffect = 0
286: 
287:             *-- Label "Capacidade:"
288:             .AddObject("lbl_4c_Capacidade", "Label")
289:             WITH .lbl_4c_Capacidade
290:                 .FontBold  = .T.
291:                 .FontName  = "Tahoma"
292:                 .FontSize  = 8
293:                 .BackStyle = 0
294:                 .Caption   = "Capacidade:"
295:                 .Height    = 15
296:                 .Left      = 9
297:                 .Top       = 10
298:                 .Width     = 70
299:                 .ForeColor = RGB(90, 90, 90)
300:             ENDWITH
301: 
302:             *-- TextBox Capacidade (somente leitura)
303:             .AddObject("txt_4c_Cap", "TextBox")
304:             WITH .txt_4c_Cap
305:                 .FontBold  = .T.
306:                 .FontName  = "Tahoma"
307:                 .FontSize  = 8
308:                 .Height    = 23
309:                 .InputMask = "99999"
310:                 .Left      = 81
311:                 .Top       = 5
312:                 .Width     = 63
313:                 .BackColor = RGB(255, 216, 176)

*-- Linhas 425 a 528:
425:     ENDPROC
426: 
427:     *==========================================================================
428:     PROTECTED PROCEDURE ConfigurarBotaoEncerrar
429:     *==========================================================================
430:         *-- Botao Encerrar (Sair do legado: Top=4, Left=725, Cancel=.T.)
431:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
432:         WITH THIS.cmd_4c_Encerrar
433:             .Top            = 4
434:             .Left           = 725
435:             .Width          = 75
436:             .Height         = 75
437:             .Caption        = "Encerrar"
438:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
439:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
440:             .Cancel         = .T.
441:             .FontName       = "Comic Sans MS"
442:             .FontSize       = 8
443:             .FontBold       = .T.
444:             .FontItalic     = .T.
445:             .ForeColor      = RGB(90, 90, 90)
446:             .BackColor      = RGB(255, 255, 255)
447:             .Themes         = .T.
448:             .SpecialEffect  = 0
449:             .PicturePosition = 13
450:             .WordWrap       = .T.
451:             .AutoSize       = .F.
452:             .MousePointer   = 15
453:         ENDWITH
454:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
455:     ENDPROC
456: 
457:     *==========================================================================
458:     PROTECTED PROCEDURE TornarControlesVisiveis
459:     *==========================================================================
460:         LPARAMETERS par_oContainer
461:         LOCAL loc_oContainer, loc_i, loc_oControl
462: 
463:         IF VARTYPE(par_oContainer) = "O"
464:             loc_oContainer = par_oContainer
465:         ELSE
466:             loc_oContainer = THIS
467:         ENDIF
468: 
469:         FOR loc_i = 1 TO loc_oContainer.ControlCount
470:             loc_oControl = loc_oContainer.Controls(loc_i)
471:             IF VARTYPE(loc_oControl) = "O"
472:                 *-- Recursao para sub-containers
473:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
474:                     THIS.TornarControlesVisiveis(loc_oControl)
475:                 ENDIF
476:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
477:                     *-- img_4c_FigJpg e shp_4c_Shape4 sao flutuantes: iniciam Visible=.F.
478:                     *-- e ficam visiveis apenas quando ha foto do produto
479:                     IF !INLIST(LOWER(loc_oControl.Name), "img_4c_figjpg", "shp_4c_shape4")
480:                         loc_oControl.Visible = .T.
481:                     ENDIF
482:                 ENDIF
483:             ENDIF
484:         ENDFOR
485:     ENDPROC
486: 
487:     *==========================================================================
488:     PROCEDURE CarregarDados
489:     *==========================================================================
490:         LOCAL loc_lSucesso, loc_oErro
491:         loc_lSucesso = .F.
492: 
493:         TRY
494:             loc_lSucesso = THIS.this_oBusinessObject.CarregarDados(;
495:                 THIS.this_nCodigo, ;
496:                 THIS.this_cSetor, ;
497:                 THIS.this_cUnidade, ;
498:                 THIS.this_dData)
499: 
500:             IF loc_lSucesso
501:                 *-- Preencher Container1: Fase e Data
502:                 THIS.cnt_4c_Container1.txt_4c_Fase.Value = THIS.this_cSetor
503:                 THIS.cnt_4c_Container1.txt_4c_Data.Value = THIS.this_dData
504: 
505:                 *-- Preencher Container2: Capacidade, Utilizado, Saldo
506:                 THIS.cnt_4c_Container2.txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
507:                 THIS.cnt_4c_Container2.txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
508:                 THIS.cnt_4c_Container2.txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo
509: 
510:                 *-- Bind do grid (ColumnCount ANTES de RecordSource - regra critica)
511:                 THIS.grd_4c_Dados.ColumnCount  = 8
512:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
513: 
514:                 *-- Configurar colunas (APOS RecordSource para evitar reset de headers)
515:                 *-- ColumnOrder=1 em Column8: Unidade Prod. aparece primeiro (identico ao legado)
516:                 WITH THIS.grd_4c_Dados
517:                     WITH .Column1
518:                         .ColumnOrder   = 2
519:                         .Width         = 80
520:                         .Alignment     = 2
521:                         .Movable       = .F.
522:                         .Resizable     = .F.
523:                         .ReadOnly      = .T.
524:                         .ControlSource = "cursor_4c_Dados.Nenvs"
525:                         .Header1.Caption   = "Envelope"
526:                         .Header1.FontName  = "Tahoma"
527:                         .Header1.FontSize  = 8
528:                         .Header1.Alignment = 2

*-- Linhas 633 a 798:
633:                     THIS.grd_4c_Dados.SetFocus
634:                 ENDIF
635:             ELSE
636:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar os dados de capacidade produtiva.", ;
637:                          "Aviso")
638:             ENDIF
639:         CATCH TO loc_oErro
640:             MsgErro("Erro ao carregar dados: " + loc_oErro.Message + ;
641:                     " Ln=" + TRANSFORM(loc_oErro.LineNo), "Erro Formsigprcpd")
642:         ENDTRY
643: 
644:         RETURN loc_lSucesso
645:     ENDPROC
646: 
647:     *==========================================================================
648:     PROCEDURE CmdEncerrarClick
649:     *==========================================================================
650:         THIS.Release()
651:     ENDPROC
652: 
653:     *==========================================================================
654:     PROCEDURE BtnIncluirClick
655:     *==========================================================================
656:         *-- Form OPERACIONAL de consulta de Capacidade Produtiva (read-only):
657:         *-- recarrega os dados do banco (efeito de "refresh completo" da grade).
658:         *-- Equivalente a repetir a chamada do menu com os mesmos parametros.
659:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR gnConnHandle <= 0
660:             RETURN
661:         ENDIF
662:         THIS.CarregarDados()
663:     ENDPROC
664: 
665:     *==========================================================================
666:     PROCEDURE BtnAlterarClick
667:     *==========================================================================
668:         *-- Form OPERACIONAL de consulta (read-only): recarrega os dados do
669:         *-- banco. Identico a BtnIncluirClick por semantica de viewer.
670:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR gnConnHandle <= 0
671:             RETURN
672:         ENDIF
673:         THIS.CarregarDados()
674:     ENDPROC
675: 
676:     *==========================================================================
677:     PROCEDURE BtnVisualizarClick
678:     *==========================================================================
679:         *-- Reposiciona no primeiro registro da grade e re-renderiza detalhes
680:         *-- do produto (foto, descricao, cliente, tempo do envelope) para a
681:         *-- linha corrente. Util quando o preview fica dessincronizado apos
682:         *-- scroll rapido ou LockScreen.
683:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
684:             RETURN
685:         ENDIF
686:         SELECT cursor_4c_Dados
687:         GO TOP
688:         THIS.grd_4c_Dados.Refresh()
689:         THIS.GrdDadosAfterRowColChange(1)
690:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
691:             THIS.grd_4c_Dados.SetFocus()
692:         ENDIF
693:     ENDPROC
694: 
695:     *==========================================================================
696:     PROCEDURE BtnExcluirClick
697:     *==========================================================================
698:         *-- Form OPERACIONAL de consulta (read-only): encerra a janela.
699:         *-- Alias de CmdEncerrarClick (mesmo comportamento do botao Encerrar).
700:         THIS.Release()
701:     ENDPROC
702: 
703:     *==========================================================================
704:     PROTECTED PROCEDURE ConfigurarPaginaLista
705:     *==========================================================================
706:         *-- Form OPERACIONAL flat (sem PageFrame CRUD). Agrega os controles
707:         *-- do "view principal": grade de envelopes/O.P. + botao Encerrar.
708:         *-- Detalhes do produto sao configurados em ConfigurarDetalhesProduto.
709:         THIS.ConfigurarGrade()
710:         THIS.ConfigurarBotaoEncerrar()
711:     ENDPROC
712: 
713:     *==========================================================================
714:     PROTECTED PROCEDURE AlternarPagina
715:     *==========================================================================
716:         LPARAMETERS par_nPagina
717:         *-- Form OPERACIONAL flat: nao possui multiplas paginas. O parametro
718:         *-- eh aceito por compatibilidade com o padrao CRUD do pipeline; a
719:         *-- unica acao util eh recarregar os dados da grade (equivalente a
720:         *-- voltar para a "lista") quando solicitado.
721:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina = 1
722:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND gnConnHandle > 0
723:                 THIS.CarregarDados()
724:             ENDIF
725:         ENDIF
726:     ENDPROC
727: 
728:     *==========================================================================
729:     PROTECTED PROCEDURE ConfigurarGrade
730:     *==========================================================================
731:         *-- Grade principal (Grade do legado): 8 colunas, layout identico ao SCX
732:         *-- Top=139, Left=0, Width=801, Height=310, ColumnCount=8
733:         THIS.AddObject("grd_4c_Dados", "Grid")
734:         WITH THIS.grd_4c_Dados
735:             .Top              = 139
736:             .Left             = 0
737:             .Width            = 801
738:             .Height           = 310
739:             .ColumnCount      = 8
740:             .FontName         = "Arial"
741:             .FontSize         = 8
742:             .ForeColor        = RGB(90, 90, 90)
743:             .BackColor        = RGB(255, 255, 255)
744:             .GridLineColor    = RGB(238, 238, 238)
745:             .HighlightBackColor = RGB(255, 255, 255)
746:             .HighlightForeColor = RGB(15, 41, 104)
747:             .HighlightStyle   = 2
748:             .RecordMark       = .F.
749:             .DeleteMark       = .F.
750:             .RowHeight        = 16
751:             .ScrollBars       = 2
752:             .ReadOnly         = .T.
753:         ENDWITH
754:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
755:     ENDPROC
756: 
757:     *==========================================================================
758:     PROTECTED PROCEDURE ConfigurarDetalhesProduto
759:     *==========================================================================
760:         *-- Shape4: borda ao redor da foto do produto (inicialmente oculto)
761:         THIS.AddObject("shp_4c_Shape4", "Shape")
762:         WITH THIS.shp_4c_Shape4
763:             .Top       = 455
764:             .Left      = 456
765:             .Width     = 148
766:             .Height    = 109
767:             .BackStyle = 1
768:             .BackColor = RGB(200, 200, 200)
769:             .Visible   = .F.
770:         ENDWITH
771: 
772:         *-- FigJpg: imagem do produto decodificada de base64 (inicialmente oculta)
773:         THIS.AddObject("img_4c_FigJpg", "Image")
774:         WITH THIS.img_4c_FigJpg
775:             .Top     = 457
776:             .Left    = 459
777:             .Width   = 143
778:             .Height  = 105
779:             .Stretch = 1
780:             .Visible = .F.
781:         ENDWITH
782: 
783:         *-- Label "Quantidade" (Say1 do legado)
784:         THIS.AddObject("lbl_4c_LblQtde", "Label")
785:         WITH THIS.lbl_4c_LblQtde
786:             .AutoSize  = .F.
787:             .FontName  = "Tahoma"
788:             .FontSize  = 8
789:             .BackStyle = 0
790:             .Caption   = "Quantidade"
791:             .Top       = 455
792:             .Left      = 11
793:             .Width     = 74
794:             .Height    = 15
795:             .ForeColor = RGB(90, 90, 90)
796:         ENDWITH
797: 
798:         *-- TextBox Quantidade (Get_qtde do legado) - SigCdPco.qtds

*-- Linhas 922 a 965:
922:     ENDPROC
923: 
924:     *==========================================================================
925:     PROCEDURE GrdDadosAfterRowColChange
926:     *==========================================================================
927:         LPARAMETERS par_nColIndex
928:         LOCAL loc_oErro, loc_cCpros
929:         loc_cCpros = ""
930: 
931:         TRY
932:             THIS.LockScreen = .T.
933: 
934:             *-- Limpar campos de detalhe e foto antes de preencher
935:             THIS.img_4c_FigJpg.Visible = .F.
936:             THIS.img_4c_FigJpg.Picture = ""
937:             THIS.shp_4c_Shape4.Visible = .F.
938:             THIS.txt_4c_Descr.Value    = ""
939:             THIS.txt_4c_Qtde.Value     = 0
940:             THIS.txt_4c_Cliente.Value  = ""
941:             THIS.txt_4c_TEnv.Value     = 0
942: 
943:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
944:                 SELECT cursor_4c_Dados
945:                 loc_cCpros = ALLTRIM(NVL(Cpros, ""))
946: 
947:                 *-- Preencher campos de detalhe da linha corrente
948:                 THIS.txt_4c_Qtde.Value    = NVL(Qtds, 0)
949:                 THIS.txt_4c_Cliente.Value = ALLTRIM(NVL(Rclis, ""))
950:                 THIS.txt_4c_TEnv.Value    = NVL(TempU, 0)
951: 
952:                 *-- Carregar foto e descricao do produto via BO
953:                 IF !EMPTY(loc_cCpros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
954:                     THIS.this_oBusinessObject.CarregarFotoProduto(loc_cCpros)
955: 
956:                     THIS.txt_4c_Descr.Value = ;
957:                         ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescricaoProduto, ""))
958: 
959:                     IF !EMPTY(THIS.this_oBusinessObject.this_cFotoArquivo) AND ;
960:                        FILE(THIS.this_oBusinessObject.this_cFotoArquivo)
961:                         THIS.img_4c_FigJpg.Picture = THIS.this_oBusinessObject.this_cFotoArquivo
962:                         THIS.img_4c_FigJpg.Visible = .T.
963:                         THIS.shp_4c_Shape4.Visible  = .T.
964:                     ENDIF
965:                 ENDIF

*-- Linhas 974 a 1091:
974:     ENDPROC
975: 
976:     *==========================================================================
977:     PROTECTED PROCEDURE ConfigurarPaginaDados
978:     *==========================================================================
979:         *-- Form OPERACIONAL flat: nao possui Page2/Dados separada.
980:         *-- Os controles de "detalhe" (Qtde, Descr, Cliente, TEnv, FigJpg,
981:         *-- Shape4, Prioridade) sao criados em ConfigurarDetalhesProduto(),
982:         *-- chamado diretamente por InicializarForm(). Metodo presente por
983:         *-- compatibilidade com o padrao multi-fase do pipeline (Fase 5/8);
984:         *-- nao cria controles (evitar AddObject duplicado).
985:         RETURN .T.
986:     ENDPROC
987: 
988:     *==========================================================================
989:     PROCEDURE CarregarLista
990:     *==========================================================================
991:         *-- Form OPERACIONAL: alias de CarregarDados (compatibilidade pipeline)
992:         THIS.CarregarDados()
993:     ENDPROC
994: 
995:     *==========================================================================
996:     PROCEDURE BOParaForm
997:     *==========================================================================
998:         *-- Popula campos de exibicao a partir do BO e do cursor corrente
999:         IF !USED("cursor_4c_Dados")
1000:             RETURN
1001:         ENDIF
1002: 
1003:         THIS.cnt_4c_Container1.txt_4c_Fase.Value = THIS.this_cSetor
1004:         THIS.cnt_4c_Container1.txt_4c_Data.Value = THIS.this_dData
1005: 
1006:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1007:             THIS.cnt_4c_Container2.txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
1008:             THIS.cnt_4c_Container2.txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
1009:             THIS.cnt_4c_Container2.txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo
1010:         ENDIF
1011:     ENDPROC
1012: 
1013:     *==========================================================================
1014:     PROCEDURE FormParaBO
1015:     *==========================================================================
1016:         *-- Form OPERACIONAL read-only: sem campos editaveis para transferir ao BO
1017:         RETURN .T.
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     PROCEDURE HabilitarCampos
1022:     *==========================================================================
1023:         LPARAMETERS par_lHabilitar
1024:         *-- Form OPERACIONAL: todos os campos sao ReadOnly - sem controles a habilitar
1025:     ENDPROC
1026: 
1027:     *==========================================================================
1028:     PROCEDURE LimparCampos
1029:     *==========================================================================
1030:         *-- Limpa todos os campos de exibicao do form
1031:         THIS.cnt_4c_Container1.txt_4c_Fase.Value = ""
1032:         THIS.cnt_4c_Container1.txt_4c_Data.Value = {}
1033:         THIS.cnt_4c_Container2.txt_4c_Cap.Value  = 0
1034:         THIS.cnt_4c_Container2.txt_4c_Utz.Value  = 0
1035:         THIS.cnt_4c_Container2.txt_4c_Sld.Value  = 0
1036:         THIS.txt_4c_Descr.Value    = ""
1037:         THIS.txt_4c_Qtde.Value     = 0
1038:         THIS.txt_4c_Cliente.Value  = ""
1039:         THIS.txt_4c_TEnv.Value     = 0
1040:         THIS.img_4c_FigJpg.Visible = .F.
1041:         THIS.img_4c_FigJpg.Picture = ""
1042:         THIS.shp_4c_Shape4.Visible = .F.
1043:     ENDPROC
1044: 
1045:     *==========================================================================
1046:     PROCEDURE AjustarBotoesPorModo
1047:     *==========================================================================
1048:         LPARAMETERS par_cModo
1049:         *-- Form OPERACIONAL flat (sem botoes CRUD): sem ajuste de botoes por modo
1050:     ENDPROC
1051: 
1052:     *==========================================================================
1053:     PROCEDURE BtnEncerrarClick
1054:     *==========================================================================
1055:         THIS.Release()
1056:     ENDPROC
1057: 
1058:     *==========================================================================
1059:     PROCEDURE BtnBuscarClick
1060:     *==========================================================================
1061:         *-- Recarrega os dados do banco (refresh da grade de capacidade produtiva)
1062:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR gnConnHandle <= 0
1063:             RETURN
1064:         ENDIF
1065:         THIS.CarregarDados()
1066:     ENDPROC
1067: 
1068:     *==========================================================================
1069:     PROCEDURE BtnSalvarClick
1070:     *==========================================================================
1071:         *-- Form OPERACIONAL read-only: sem acao de salvar
1072:         RETURN .T.
1073:     ENDPROC
1074: 
1075:     *==========================================================================
1076:     PROCEDURE BtnCancelarClick
1077:     *==========================================================================
1078:         *-- Form OPERACIONAL: cancelar = encerrar o visualizador
1079:         THIS.Release()
1080:     ENDPROC
1081: 
1082:     *==========================================================================
1083:     PROCEDURE Destroy
1084:     *==========================================================================
1085:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1086:             THIS.this_oBusinessObject = .NULL.
1087:         ENDIF
1088:         DODEFAULT()
1089:     ENDPROC
1090: 
1091: ENDDEFINE


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

