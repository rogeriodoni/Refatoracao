# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (22)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=6 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Tipo' Top=10 (diff=421px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRETQ): Top original=415 vs migrado 'lbl_4c_Label11' Top=594 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRETQ): Left original=23 vs migrado 'lbl_4c_Label11' Left=556 (diff=533px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Impressora' Top=52 (diff=379px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRETQ): Left original=260 vs migrado 'obj_4c_Opt_Impressora' Left=9 (diff=251px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_separador' (parent: SIGPRETQ): Top original=412 vs migrado 'obj_4c_Opt_separador' Top=5 (diff=407px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_separador' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_Opt_separador' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGPRETQ): Top original=589 vs migrado 'obj_4c_OptOrdem' Top=4 (diff=585px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_OptOrdem' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_peso' (parent: SIGPRETQ): Top original=535 vs migrado 'obj_4c_Opt_peso' Top=5 (diff=530px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_peso' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_Opt_peso' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCompos' (parent: SIGPRETQ): Top original=562 vs migrado 'obj_4c_OptCompos' Top=5 (diff=557px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCompos' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_OptCompos' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Preco' (parent: SIGPRETQ): Top original=439 vs migrado 'obj_4c_Opt_Preco' Top=7 (diff=432px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Preco' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_Opt_Preco' Left=8 (diff=593px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2672 linhas total):

*-- Linhas 34 a 88:
34: 
35:     *--------------------------------------------------------------------------
36:     * Init - Cria BO e inicializa form via DODEFAULT()
37:     * DODEFAULT() chama FormBase.Init() que chama InicializarForm()
38:     *--------------------------------------------------------------------------
39:     PROCEDURE Init()
40:         THIS.this_oBusinessObject = CREATEOBJECT("SigPrEtqBO")
41:         RETURN DODEFAULT()
42:     ENDPROC
43: 
44:     *--------------------------------------------------------------------------
45:     * InicializarForm - Chamado por FormBase.Init()
46:     * Cria cursor local dbImpressao e configura estrutura visual base
47:     *--------------------------------------------------------------------------
48:     PROTECTED PROCEDURE InicializarForm()
49:         LOCAL loc_lSucesso, loc_oErro
50: 
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             *-- Fundo do form (new_background.jpg como no original)
55:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
56: 
57:             *-- Criar cursor local dbImpressao (estrutura identica ao legado)
58:             IF USED("dbImpressao")
59:                 USE IN dbImpressao
60:             ENDIF
61: 
62:             SET NULL ON
63:             CREATE CURSOR dbImpressao ;
64:                 (Cpros       C(14)   NULL, ;
65:                  DPros       C(40)   NULL, ;
66:                  Reffs       C(40)   NULL, ;
67:                  Qtds        N(10,3) NULL, ;
68:                  QtdeEtiq    N(10,3) NULL, ;
69:                  Pedido      C(30)   NULL, ;
70:                  Obs         C(10)   NULL, ;
71:                  PVens       N(12,2) NULL, ;
72:                  PrecoDe     N(12,2) NULL, ;
73:                  Parcelas    N(2,0)  NULL, ;
74:                  Cpros2      C(14)   NULL, ;
75:                  Cpros3      C(14)   NULL, ;
76:                  Cpros4      C(14)   NULL, ;
77:                  empos       C(3)    NULL, ;
78:                  empdopnums  C(29)   NULL, ;
79:                  citens      N(10,0) NULL, ;
80:                  Pesos       N(12,2) NULL, ;
81:                  CodTams     C(4)    NULL, ;
82:                  DPro2s      C(45)   NULL)
83:             SET NULL OFF
84:             SET DELETED ON
85: 
86:             INDEX ON Cpros   TAG Cpros
87:             INDEX ON RECNO() TAG Registros
88:             SET ORDER TO

*-- Linhas 95 a 273:
95:             THIS.CarregarTiposEtiqueta()
96:             THIS.CarregarImpressoras()
97: 
98:             *-- BINDEVENT grid: AfterRowColChange para lookup de colunas
99:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
100: 
101:             *-- BINDEVENT Opt_Preco: ao mudar opcao de preco, toggle Parcelas
102:             BINDEVENT(THIS.obj_4c_Opt_Preco, "InteractiveChange", THIS, "OptPrecoInteractiveChange")
103: 
104:             *-- Torna controles visiveis (compensar AddObject Visible=.F. default)
105:             THIS.TornarControlesVisiveis(THIS)
106: 
107:             loc_lSucesso = .T.
108: 
109:         CATCH TO loc_oErro
110:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
111:                     " PROC=" + loc_oErro.Procedure, ;
112:                     "Erro FormSigPrEtq.InicializarForm")
113:         ENDTRY
114: 
115:         RETURN loc_lSucesso
116:     ENDPROC
117: 
118:     *--------------------------------------------------------------------------
119:     * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
120:     * cntSombra (cabecalho cinza) com labels de titulo.
121:     * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
122:     * estrutura fixa do topo (equivalente ao "frame" da tela), mantendo o
123:     * contrato do pipeline multi-fase (validacao busca "ConfigurarPageFrame").
124:     * Original: cntSombra Top=0, Left=0, Width=840, Height=80, BackColor=100,100,100
125:     * lblSombra: ForeColor=RGB(0,0,0) (sombra preta)
126:     * lblTitulo: ForeColor=RGB(255,255,255) (texto branco)
127:     *--------------------------------------------------------------------------
128:     PROTECTED PROCEDURE ConfigurarPageFrame()
129:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
130:         WITH THIS.cnt_4c_Cabecalho
131:             .Top       = 0
132:             .Left      = 0
133:             .Width     = THIS.Width
134:             .Height    = 80
135:             .BackStyle = 1
136:             .BackColor = RGB(100,100,100)
137:             .BorderWidth = 0
138: 
139:             .AddObject("lbl_4c_Sombra", "Label")
140:             WITH .lbl_4c_Sombra
141:                 .AutoSize  = .F.
142:                 .FontBold  = .T.
143:                 .FontName  = "Tahoma"
144:                 .FontSize  = 18
145:                 .WordWrap  = .T.
146:                 .Alignment = 0
147:                 .BackStyle = 0
148:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
149:                 .Height    = 40
150:                 .Left      = 10
151:                 .Top       = 18
152:                 .Width     = .Parent.Width
153:                 .ForeColor = RGB(0,0,0)
154:             ENDWITH
155: 
156:             .AddObject("lbl_4c_Titulo", "Label")
157:             WITH .lbl_4c_Titulo
158:                 .AutoSize  = .F.
159:                 .FontBold  = .T.
160:                 .FontName  = "Tahoma"
161:                 .FontSize  = 18
162:                 .WordWrap  = .T.
163:                 .Alignment = 0
164:                 .BackStyle = 0
165:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
166:                 .Height    = 46
167:                 .Left      = 10
168:                 .Top       = 17
169:                 .Width     = .Parent.Width
170:                 .ForeColor = RGB(255,255,255)
171:             ENDWITH
172:         ENDWITH
173:     ENDPROC
174: 
175:     *--------------------------------------------------------------------------
176:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
177:     * Percorre Controls E Pages (PageFrame) para garantir visibilidade
178:     * EXCECAO: obj_4c_Opt_Impressora permanece oculto (sobreposicao com Opt_Tipo)
179:     *--------------------------------------------------------------------------
180:     PROCEDURE TornarControlesVisiveis(par_oContainer)
181:         LOCAL loc_nI, loc_oControl
182: 
183:         FOR loc_nI = 1 TO par_oContainer.ControlCount
184:             loc_oControl = par_oContainer.Controls(loc_nI)
185: 
186:             IF VARTYPE(loc_oControl) = "O"
187:                 *-- Manter Opt_Impressora oculto (vestigial, sobrepoe Opt_Tipo)
188:                 IF UPPER(loc_oControl.Name) = "OBJ_4C_OPT_IMPRESSORA"
189:                     LOOP
190:                 ENDIF
191: 
192:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
193:                     loc_oControl.Visible = .T.
194:                 ENDIF
195: 
196:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
197:                     LOCAL loc_nP
198:                     FOR loc_nP = 1 TO loc_oControl.PageCount
199:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
200:                     ENDFOR
201:                 ENDIF
202: 
203:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
204:                     THIS.TornarControlesVisiveis(loc_oControl)
205:                 ENDIF
206:             ENDIF
207:         ENDFOR
208:     ENDPROC
209: 
210:     *--------------------------------------------------------------------------
211:     * Destroy - Libera BO e fecha cursor local dbImpressao
212:     *--------------------------------------------------------------------------
213:     PROCEDURE Destroy()
214:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
215:             THIS.this_oBusinessObject = .NULL.
216:         ENDIF
217: 
218:         IF USED("dbImpressao")
219:             USE IN dbImpressao
220:         ENDIF
221: 
222:         IF USED("cursor_4c_ImpreV")
223:             USE IN cursor_4c_ImpreV
224:         ENDIF
225: 
226:         DODEFAULT()
227:     ENDPROC
228: 
229:     *--------------------------------------------------------------------------
230:     * ConfigurarPaginaLista - Cria controles principais do form OPERACIONAL:
231:     * label titulo, grid grd_4c_Dados (7 colunas), botoes de acao e BTNREPORT
232:     *--------------------------------------------------------------------------
233:     PROTECTED PROCEDURE ConfigurarPaginaLista()
234:         LOCAL loc_oErro
235: 
236:         TRY
237:             *-- Label titulo da grade
238:             THIS.AddObject("lbl_4c_Lbl_titulo", "Label")
239:             WITH THIS.lbl_4c_Lbl_titulo
240:                 .AutoSize  = .T.
241:                 .FontBold  = .T.
242:                 .FontName  = "Tahoma"
243:                 .FontSize  = 8
244:                 .BackStyle = 0
245:                 .Caption   = " \<Etiquetas Selecionadas "
246:                 .Height    = 15
247:                 .Left      = 10
248:                 .Top       = 203
249:                 .Width     = 138
250:                 .ForeColor = RGB(90,90,90)
251:             ENDWITH
252: 
253:             *-- Grid principal
254:             THIS.AddObject("grd_4c_Dados", "Grid")
255:             WITH THIS.grd_4c_Dados
256:                 .Top          = 216
257:                 .Left         = 12
258:                 .Width        = 818
259:                 .Height       = 157
260:                 .RecordMark   = .F.
261:                 .DeleteMark   = .F.
262:                 .FontName     = "Tahoma"
263:                 .FontSize     = 8
264:                 .HeaderHeight = 17
265:                 .RowHeight    = 17
266:                 .ScrollBars   = 2
267:                 .ColumnCount  = 7
268:                 .RecordSource = "dbImpressao"
269: 
270:                 *-- Column1: Produto (cpros)
271:                 WITH .Column1
272:                     .ControlSource = "dbImpressao.cpros"
273:                     .Width         = 110

*-- Linhas 485 a 544:
485:                 .FontName        = "Tahoma"
486:                 .FontSize        = 8
487:             ENDWITH
488:             BINDEVENT(THIS.cmd_4c_Btnexcluir, "Click", THIS, "BtnExcluirClick")
489: 
490:             *-- Botao Carregar itens da movimentacao
491:             THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
492:             WITH THIS.cmd_4c_BtnCarregar
493:                 .Top             = 159
494:                 .Left            = 373
495:                 .Height          = 26
496:                 .Width           = 26
497:                 .Caption         = ""
498:                 .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
499:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
500:                 .Themes          = .T.
501:                 .FontName        = "Tahoma"
502:                 .FontSize        = 8
503:             ENDWITH
504:             BINDEVENT(THIS.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")
505: 
506:             *-- CommandGroup BTNREPORT: Imprimir + Encerrar
507:             THIS.AddObject("obj_4c_BTNREPORT", "CommandGroup")
508:             WITH THIS.obj_4c_BTNREPORT
509:                 .ButtonCount = 2
510:                 .BackStyle   = 0
511:                 .BorderStyle = 0
512:                 .Height      = 85
513:                 .Left        = 676
514:                 .Top         = -2
515:                 .Width       = 161
516:                 .AutoSize    = .T.
517: 
518:                 WITH .Buttons(1)
519:                     .Top        = 5
520:                     .Left       = 5
521:                     .Height     = 75
522:                     .Width      = 75
523:                     .FontBold   = .T.
524:                     .FontItalic = .T.
525:                     .WordWrap   = .T.
526:                     .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
527:                     .Caption    = "\<Imprimir"
528:                     .ForeColor  = RGB(90,90,90)
529:                     .BackColor  = RGB(255,255,255)
530:                     .Themes     = .F.
531:                     .Name       = "Imprime"
532:                 ENDWITH
533: 
534:                 WITH .Buttons(2)
535:                     .Top        = 5
536:                     .Left       = 81
537:                     .Height     = 75
538:                     .Width      = 75
539:                     .FontBold   = .T.
540:                     .FontItalic = .T.
541:                     .FontName   = "Comic Sans MS"
542:                     .FontSize   = 8
543:                     .WordWrap   = .T.
544:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 550 a 614:
550:                     .Name       = "Sair"
551:                 ENDWITH
552:             ENDWITH
553:             BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(1), "Click", THIS, "BtnImprimeClick")
554:             BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(2), "Click", THIS, "BtnSairClick")
555: 
556:         CATCH TO loc_oErro
557:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
558:                     " PROC=" + loc_oErro.Procedure, ;
559:                     "Erro FormSigPrEtq.ConfigurarPaginaLista")
560:         ENDTRY
561:     ENDPROC
562: 
563:     *--------------------------------------------------------------------------
564:     * AlternarPagina - Form OPERACIONAL sem PageFrame; sempre retorna .T.
565:     *--------------------------------------------------------------------------
566:     PROCEDURE AlternarPagina(par_nPagina)
567:         RETURN .T.
568:     ENDPROC
569: 
570:     *--------------------------------------------------------------------------
571:     * BtnImprimeClick - Imprime etiquetas selecionadas via BO.ImprimirEtiquetas
572:     * Reordena dbImpressao conforme OptOrdem antes de chamar SigOpEtq
573:     *--------------------------------------------------------------------------
574:     PROCEDURE BtnImprimeClick()
575:         LOCAL loc_lSucesso, loc_oErro, loc_lContinuar
576: 
577:         loc_lSucesso   = .F.
578:         loc_lContinuar = .T.
579: 
580:         TRY
581:             IF !MsgConfirma("Confirma a Impress" + CHR(227) + "o de Etiquetas ?")
582:                 loc_lContinuar = .F.
583:             ENDIF
584: 
585:             IF loc_lContinuar
586:                 *-- Reordenar dbImpressao: remove Qtds<=0 e ordena conforme opcao
587:                 SELECT * FROM dbImpressao WHERE 0=1 INTO CURSOR cursor_4c_Ordenado READWRITE
588: 
589:                 SELECT dbImpressao
590:                 DELETE FROM dbImpressao WHERE Qtds <= 0
591: 
592:                 IF THIS.obj_4c_OptOrdem.Value = 1
593:                     SET ORDER TO Cpros
594:                 ELSE
595:                     SET ORDER TO Registros
596:                 ENDIF
597: 
598:                 SELECT dbImpressao
599:                 SCAN
600:                     SCATTER MEMVAR MEMO
601:                     INSERT INTO cursor_4c_Ordenado FROM MEMVAR
602:                 ENDSCAN
603: 
604:                 ZAP IN dbImpressao
605:                 SET ORDER TO
606: 
607:                 SELECT cursor_4c_Ordenado
608:                 SCAN
609:                     SCATTER MEMVAR MEMO
610:                     INSERT INTO dbImpressao FROM MEMVAR
611:                 ENDSCAN
612: 
613:                 IF USED("cursor_4c_Ordenado")
614:                     USE IN cursor_4c_Ordenado

*-- Linhas 635 a 873:
635: 
636:         CATCH TO loc_oErro
637:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
638:                     " PROC=" + loc_oErro.Procedure, ;
639:                     "Erro FormSigPrEtq.BtnImprimeClick")
640:         ENDTRY
641: 
642:         RETURN loc_lSucesso
643:     ENDPROC
644: 
645:     *--------------------------------------------------------------------------
646:     * BtnSairClick - Encerra o formulario
647:     *--------------------------------------------------------------------------
648:     PROCEDURE BtnSairClick()
649:         THIS.Release()
650:     ENDPROC
651: 
652:     *--------------------------------------------------------------------------
653:     * BtnExcluirClick - Exclui o item corrente da grade dbImpressao
654:     *--------------------------------------------------------------------------
655:     PROCEDURE BtnExcluirClick()
656:         LOCAL loc_oErro
657: 
658:         TRY
659:             SELECT dbImpressao
660:             DELETE
661:             LOCATE FOR .F.
662: 
663:             SELECT dbImpressao
664:             GO TOP IN dbImpressao
665:             IF EOF("dbImpressao")
666:                 APPEND BLANK IN dbImpressao
667:             ENDIF
668:             GO TOP IN dbImpressao
669: 
670:             THIS.grd_4c_Dados.Refresh()
671: 
672:         CATCH TO loc_oErro
673:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
674:                     " PROC=" + loc_oErro.Procedure, ;
675:                     "Erro FormSigPrEtq.BtnExcluirClick")
676:         ENDTRY
677:     ENDPROC
678: 
679:     *--------------------------------------------------------------------------
680:     * BtnCarregarClick - Carrega itens da movimentacao na grade dbImpressao
681:     *--------------------------------------------------------------------------
682:     PROCEDURE BtnCarregarClick()
683:         LOCAL loc_lSucesso, loc_oErro, loc_nItens, loc_lContinuar
684: 
685:         loc_lSucesso   = .F.
686:         loc_lContinuar = .T.
687: 
688:         TRY
689:             *-- Validar campos obrigatorios (controles criados na Fase 5)
690:             IF EMPTY(THIS.txt_4c_Emps.Value)
691:                 MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!")
692:                 THIS.txt_4c_Emps.SetFocus
693:                 loc_lContinuar = .F.
694:             ENDIF
695: 
696:             IF loc_lContinuar AND EMPTY(THIS.txt_4c_Dopes.Value)
697:                 MsgAviso("A Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Foi Informada!!!")
698:                 THIS.txt_4c_Dopes.SetFocus
699:                 loc_lContinuar = .F.
700:             ENDIF
701: 
702:             IF loc_lContinuar AND EMPTY(THIS.txt_4c_Numes.Value)
703:                 MsgAviso("O C" + CHR(243) + "digo N" + CHR(227) + "o Foi Informado!!!")
704:                 THIS.txt_4c_Numes.SetFocus
705:                 loc_lContinuar = .F.
706:             ENDIF
707: 
708:             IF loc_lContinuar
709:                 *-- Verificar se ja existem etiquetas na grade e confirmar substituicao
710:                 SELECT Cpros FROM dbImpressao WHERE !EMPTY(Cpros) INTO CURSOR cursor_4c_TmpDig
711:                 IF _TALLY > 0
712:                     loc_lContinuar = MsgConfirma("Existem Etiquetas na Grade! " + ;
713:                         "Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?")
714:                 ENDIF
715:                 IF USED("cursor_4c_TmpDig")
716:                     USE IN cursor_4c_TmpDig
717:                 ENDIF
718:             ENDIF
719: 
720:             IF loc_lContinuar
721:                 ZAP IN dbImpressao
722: 
723:                 loc_nItens = THIS.this_oBusinessObject.CarregarPorMovimentacao( ;
724:                     THIS.txt_4c_Emps.Value, ;
725:                     THIS.txt_4c_Dopes.Value, ;
726:                     THIS.txt_4c_Numes.Value, ;
727:                     (THIS.chk_4c_ChkOperacoes.Value = 1))
728: 
729:                 IF loc_nItens <= 0
730:                     MsgAviso("A Opera" + CHR(231) + CHR(227) + "o Informada N" + CHR(227) + ;
731:                              "o Possui It" + CHR(234) + "ns a Serem Carregados!!!")
732:                     THIS.txt_4c_Emps.SetFocus
733:                 ELSE
734:                     *-- Aplicar lista de precos por item se preenchida e nao em modo chkLista
735:                     IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value)
736:                         SELECT dbImpressao
737:                         SCAN
738:                             IF !EMPTY(dbImpressao.Cpros)
739:                                 THIS.this_oBusinessObject.AplicarListaPrecoNoItem( ;
740:                                     THIS.txt_4c_Lpreco.Value, ;
741:                                     ALLTRIM(dbImpressao.Cpros))
742:                             ENDIF
743:                         ENDSCAN
744:                     ENDIF
745:                 ENDIF
746: 
747:                 SELECT dbImpressao
748:                 IF RECCOUNT("dbImpressao") = 0
749:                     APPEND BLANK IN dbImpressao
750:                 ENDIF
751:                 GO TOP IN dbImpressao
752: 
753:                 THIS.grd_4c_Dados.Refresh()
754:             ENDIF
755: 
756:             loc_lSucesso = .T.
757: 
758:         CATCH TO loc_oErro
759:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
760:                     " PROC=" + loc_oErro.Procedure, ;
761:                     "Erro FormSigPrEtq.BtnCarregarClick")
762:         ENDTRY
763: 
764:         RETURN loc_lSucesso
765:     ENDPROC
766: 
767:     *--------------------------------------------------------------------------
768:     * ConfigurarPaginaDados - Cria controles de filtros/parametros (Parte 1):
769:     * Secao Lista de Precos, Movimentacoes e Tipo de Etiqueta
770:     *--------------------------------------------------------------------------
771:     PROTECTED PROCEDURE ConfigurarPaginaDados()
772:         LOCAL loc_oErro
773: 
774:         TRY
775:             *-- Secao Lista de Precos (Top 86-130)
776:             THIS.AddObject("lbl_4c_Label2", "Label")
777:             WITH THIS.lbl_4c_Label2
778:                 .AutoSize  = .T.
779:                 .FontBold  = .T.
780:                 .FontName  = "Tahoma"
781:                 .FontSize  = 8
782:                 .BackStyle = 0
783:                 .Caption   = " \<Lista de Pre" + CHR(231) + "os "
784:                 .Height    = 15
785:                 .Left      = 20
786:                 .Top       = 86
787:                 .Width     = 93
788:                 .ForeColor = RGB(90,90,90)
789:             ENDWITH
790: 
791:             THIS.AddObject("chk_4c_ChkLista", "CheckBox")
792:             WITH THIS.chk_4c_ChkLista
793:                 .AutoSize  = .T.
794:                 .Alignment = 0
795:                 .BackStyle = 0
796:                 .Caption   = "Carrega " + CHR(205) + "tens"
797:                 .Height    = 15
798:                 .Left      = 24
799:                 .Top       = 102
800:                 .Width     = 85
801:                 .Value     = 1
802:                 .FontName  = "Tahoma"
803:                 .FontSize  = 8
804:                 .ForeColor = RGB(90,90,90)
805:             ENDWITH
806: 
807:             THIS.AddObject("txt_4c_Lpreco", "TextBox")
808:             WITH THIS.txt_4c_Lpreco
809:                 .Format    = "K!"
810:                 .Height    = 22
811:                 .Left      = 132
812:                 .Top       = 105
813:                 .Width     = 294
814:                 .Value     = ""
815:                 .MaxLength = 30
816:                 .FontName  = "Tahoma"
817:                 .FontSize  = 8
818:             ENDWITH
819:             BINDEVENT(THIS.txt_4c_Lpreco, "KeyPress", THIS, "TxtLprecoKeyPress")
820: 
821:             THIS.AddObject("txt_4c_LPreco2", "TextBox")
822:             WITH THIS.txt_4c_LPreco2
823:                 .Format    = "K!"
824:                 .Height    = 22
825:                 .Left      = 132
826:                 .Top       = 128
827:                 .Width     = 294
828:                 .Value     = ""
829:                 .MaxLength = 30
830:                 .FontName  = "Tahoma"
831:                 .FontSize  = 8
832:             ENDWITH
833:             BINDEVENT(THIS.txt_4c_LPreco2, "KeyPress", THIS, "TxtLPreco2KeyPress")
834: 
835:             *-- Secao Movimentacoes (Top 154-195)
836:             THIS.AddObject("lbl_4c_Label4", "Label")
837:             WITH THIS.lbl_4c_Label4
838:                 .AutoSize  = .T.
839:                 .FontBold  = .T.
840:                 .FontName  = "Tahoma"
841:                 .FontSize  = 8
842:                 .BackStyle = 0
843:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
844:                 .Height    = 15
845:                 .Left      = 20
846:                 .Top       = 154
847:                 .Width     = 92
848:                 .ForeColor = RGB(90,90,90)
849:             ENDWITH
850: 
851:             THIS.AddObject("chk_4c_ChkOperacoes", "CheckBox")
852:             WITH THIS.chk_4c_ChkOperacoes
853:                 .AutoSize  = .T.
854:                 .Alignment = 0
855:                 .BackStyle = 0
856:                 .Caption   = "Carrega " + CHR(205) + "tens"
857:                 .Height    = 15
858:                 .Left      = 24
859:                 .Top       = 169
860:                 .Width     = 85
861:                 .Value     = 1
862:                 .FontName  = "Tahoma"
863:                 .FontSize  = 8
864:                 .ForeColor = RGB(90,90,90)
865:             ENDWITH
866: 
867:             THIS.AddObject("lbl_4c_Label5", "Label")
868:             WITH THIS.lbl_4c_Label5
869:                 .AutoSize  = .T.
870:                 .FontBold  = .T.
871:                 .FontName  = "Tahoma"
872:                 .FontSize  = 8
873:                 .BackStyle = 0

*-- Linhas 921 a 1057:
921:                 .FontName  = "Tahoma"
922:                 .FontSize  = 8
923:             ENDWITH
924:             BINDEVENT(THIS.txt_4c_Emps, "KeyPress", THIS, "TxtEmpsKeyPress")
925: 
926:             THIS.AddObject("txt_4c_Dopes", "TextBox")
927:             WITH THIS.txt_4c_Dopes
928:                 .Format    = "K!"
929:                 .Height    = 23
930:                 .Left      = 165
931:                 .Top       = 174
932:                 .Width     = 150
933:                 .Value     = ""
934:                 .MaxLength = 20
935:                 .FontName  = "Tahoma"
936:                 .FontSize  = 8
937:             ENDWITH
938:             BINDEVENT(THIS.txt_4c_Dopes, "KeyPress", THIS, "TxtDopesKeyPress")
939: 
940:             THIS.AddObject("txt_4c_Numes", "TextBox")
941:             WITH THIS.txt_4c_Numes
942:                 .Alignment = 3
943:                 .Value     = 0
944:                 .Format    = "K"
945:                 .Height    = 23
946:                 .InputMask = "999999"
947:                 .Left      = 317
948:                 .MaxLength = 6
949:                 .Top       = 174
950:                 .Width     = 52
951:                 .FontName  = "Tahoma"
952:                 .FontSize  = 8
953:             ENDWITH
954: 
955:             *-- Secao Tipo de Etiqueta (Top 415-615)
956:             THIS.AddObject("shp_4c_Shape3", "Shape")
957:             WITH THIS.shp_4c_Shape3
958:                 .Top           = 431
959:                 .Left          = 260
960:                 .Width         = 254
961:                 .Height        = 106
962:                 .BackStyle     = 0
963:                 .BorderWidth   = 1
964:                 .SpecialEffect = 1
965:             ENDWITH
966: 
967:             THIS.AddObject("lbl_4c_Label1", "Label")
968:             WITH THIS.lbl_4c_Label1
969:                 .AutoSize  = .T.
970:                 .FontBold  = .T.
971:                 .FontName  = "Tahoma"
972:                 .FontSize  = 8
973:                 .BackStyle = 0
974:                 .Caption   = " Tipo de Etiqueta "
975:                 .Height    = 15
976:                 .Left      = 23
977:                 .Top       = 415
978:                 .Width     = 99
979:                 .ForeColor = RGB(90,90,90)
980:             ENDWITH
981: 
982:             *-- Opt_Tipo: ButtonCount=1 provisorio; CarregarTiposEtiqueta() re-popula
983:             THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
984:             WITH THIS.obj_4c_Opt_Tipo
985:                 .ButtonCount   = 1
986:                 .BackStyle     = 0
987:                 .Value         = 1
988:                 .Height        = 182
989:                 .Left          = 13
990:                 .SpecialEffect = 1
991:                 .Top           = 431
992:                 .Width         = 240
993:                 .Themes        = .F.
994:                 WITH .Buttons(1)
995:                     .AutoSize  = .F.
996:                     .Width     = 197
997:                     .Caption   = " \<a. Rabicho"
998:                     .ForeColor = RGB(90,90,90)
999:                     .Top       = 10
1000:                     .BackStyle = 0
1001:                     .Height    = 16
1002:                     .Left      = 9
1003:                 ENDWITH
1004:             ENDWITH
1005: 
1006:             *-- Container Impressora (Cnt_Impressora: Top=539, Left=260, 254x74)
1007:             THIS.AddObject("cnt_4c__Impressora", "Container")
1008:             WITH THIS.cnt_4c__Impressora
1009:                 .Top         = 539
1010:                 .Left        = 260
1011:                 .Width       = 254
1012:                 .Height      = 74
1013:                 .BackStyle   = 0
1014:                 .BorderWidth = 0
1015: 
1016:                 *-- Opcao impressora: Allegro / Zebra ZPL / Zebra EPL
1017:                 .AddObject("obj_4c_Opcao_imp", "OptionGroup")
1018:                 WITH .obj_4c_Opcao_imp
1019:                     .AutoSize    = .F.
1020:                     .ButtonCount = 3
1021:                     .Height      = 24
1022:                     .Left        = 5
1023:                     .Top         = 3
1024:                     .Width       = 241
1025:                     WITH .Buttons(1)
1026:                         .AutoSize  = .T.
1027:                         .BackStyle = 0
1028:                         .Caption   = "Allegro"
1029:                         .ForeColor = RGB(90,90,90)
1030:                         .Left      = 2
1031:                         .Top       = 4
1032:                         .Width     = 51
1033:                     ENDWITH
1034:                     WITH .Buttons(2)
1035:                         .AutoSize  = .T.
1036:                         .BackStyle = 0
1037:                         .Caption   = "Zebra ZPL"
1038:                         .FontName  = "Tahoma"
1039:                         .FontSize  = 8
1040:                         .ForeColor = RGB(90,90,90)
1041:                         .Left      = 75
1042:                         .Top       = 4
1043:                         .Width     = 66
1044:                     ENDWITH
1045:                     WITH .Buttons(3)
1046:                         .AutoSize  = .T.
1047:                         .BackStyle = 0
1048:                         .Caption   = "Zebra EPL"
1049:                         .FontName  = "Tahoma"
1050:                         .FontSize  = 8
1051:                         .ForeColor = RGB(90,90,90)
1052:                         .Height    = 15
1053:                         .Left      = 164
1054:                         .Top       = 4
1055:                         .Width     = 66
1056:                     ENDWITH
1057:                 ENDWITH

*-- Linhas 1188 a 1231:
1188:             ENDWITH
1189: 
1190:             *-- Opt_Impressora (Visible=.F. - vestigial, sobrepoe Opt_Tipo)
1191:             THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1192:             WITH THIS.obj_4c_Opt_Impressora
1193:                 .AutoSize      = .F.
1194:                 .ButtonCount   = 1
1195:                 .BackStyle     = 0
1196:                 .Value         = 1
1197:                 .Height        = 47
1198:                 .Left          = 260
1199:                 .SpecialEffect = 1
1200:                 .Top           = 431
1201:                 .Width         = 254
1202:                 .Themes        = .F.
1203:                 .Visible       = .F.
1204:                 WITH .Buttons(1)
1205:                     .AutoSize  = .F.
1206:                     .BackStyle = 0
1207:                     .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1208:                     .ForeColor = RGB(36,84,155)
1209:                     .Height    = 16
1210:                     .Left      = 9
1211:                     .Style     = 0
1212:                     .Top       = 52
1213:                     .Width     = 210
1214:                 ENDWITH
1215:             ENDWITH
1216: 
1217:             *-- Labels "Sistema" e "Windows" (acima do Get_Printer)
1218:             THIS.AddObject("lbl_4c_Label12", "Label")
1219:             WITH THIS.lbl_4c_Label12
1220:                 .AutoSize  = .T.
1221:                 .FontBold  = .T.
1222:                 .FontName  = "Tahoma"
1223:                 .FontSize  = 8
1224:                 .BackStyle = 0
1225:                 .Caption   = "Sistema"
1226:                 .Height    = 15
1227:                 .Left      = 270
1228:                 .Top       = 437
1229:                 .Width     = 48
1230:                 .ForeColor = RGB(90,90,90)
1231:             ENDWITH

*-- Linhas 1263 a 1376:
1263:                 .ColumnCount   = 1
1264:                 .ColumnWidths  = "239"
1265:             ENDWITH
1266:             BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "CboGetPrinterInteractiveChange")
1267: 
1268:             *-- Separadora (label + OptionGroup)
1269:             THIS.AddObject("lbl_4c_Lbl_Separador", "Label")
1270:             WITH THIS.lbl_4c_Lbl_Separador
1271:                 .AutoSize  = .T.
1272:                 .FontBold  = .F.
1273:                 .FontName  = "Tahoma"
1274:                 .FontSize  = 8
1275:                 .BackStyle = 0
1276:                 .Caption   = "Separadora :"
1277:                 .Height    = 15
1278:                 .Left      = 532
1279:                 .Top       = 417
1280:                 .Width     = 65
1281:                 .ForeColor = RGB(90,90,90)
1282:             ENDWITH
1283: 
1284:             THIS.AddObject("obj_4c_Opt_separador", "OptionGroup")
1285:             WITH THIS.obj_4c_Opt_separador
1286:                 .AutoSize      = .F.
1287:                 .ButtonCount   = 2
1288:                 .BackStyle     = 0
1289:                 .Value         = 1
1290:                 .Height        = 25
1291:                 .Left          = 601
1292:                 .SpecialEffect = 1
1293:                 .Top           = 412
1294:                 .Width         = 198
1295:                 .Themes        = .F.
1296:                 WITH .Buttons(1)
1297:                     .AutoSize  = .T.
1298:                     .BackStyle = 0
1299:                     .Caption   = "Sim"
1300:                     .ForeColor = RGB(90,90,90)
1301:                     .Height    = 15
1302:                     .Left      = 5
1303:                     .Top       = 5
1304:                     .Width     = 34
1305:                 ENDWITH
1306:                 WITH .Buttons(2)
1307:                     .AutoSize  = .T.
1308:                     .BackStyle = 0
1309:                     .Caption   = "N" + CHR(227) + "o"
1310:                     .FontName  = "Tahoma"
1311:                     .FontSize  = 8
1312:                     .ForeColor = RGB(90,90,90)
1313:                     .Height    = 15
1314:                     .Left      = 70
1315:                     .Top       = 5
1316:                     .Width     = 37
1317:                 ENDWITH
1318:             ENDWITH
1319: 
1320:             *-- Preco (label + OptionGroup 6 botoes)
1321:             THIS.AddObject("lbl_4c_Label8", "Label")
1322:             WITH THIS.lbl_4c_Label8
1323:                 .AutoSize  = .T.
1324:                 .FontBold  = .F.
1325:                 .FontName  = "Tahoma"
1326:                 .FontSize  = 8
1327:                 .BackStyle = 0
1328:                 .Caption   = "Pre" + CHR(231) + "o :"
1329:                 .Height    = 15
1330:                 .Left      = 561
1331:                 .Top       = 440
1332:                 .Width     = 36
1333:                 .ForeColor = RGB(90,90,90)
1334:             ENDWITH
1335: 
1336:             THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
1337:             WITH THIS.obj_4c_Opt_Preco
1338:                 .AutoSize      = .F.
1339:                 .ButtonCount   = 6
1340:                 .BackStyle     = 0
1341:                 .Value         = 1
1342:                 .Height        = 95
1343:                 .Left          = 601
1344:                 .SpecialEffect = 1
1345:                 .Top           = 439
1346:                 .Width         = 198
1347:                 .Themes        = .F.
1348:                 WITH .Buttons(1)
1349:                     .AutoSize  = .T.
1350:                     .BackStyle = 0
1351:                     .Caption   = "Sim"
1352:                     .ForeColor = RGB(90,90,90)
1353:                     .Height    = 15
1354:                     .Left      = 8
1355:                     .Top       = 7
1356:                     .Width     = 34
1357:                 ENDWITH
1358:                 WITH .Buttons(2)
1359:                     .AutoSize  = .T.
1360:                     .BackStyle = 0
1361:                     .Caption   = "N" + CHR(227) + "o"
1362:                     .FontName  = "Tahoma"
1363:                     .FontSize  = 8
1364:                     .ForeColor = RGB(90,90,90)
1365:                     .Height    = 15
1366:                     .Left      = 61
1367:                     .Top       = 7
1368:                     .Width     = 37
1369:                 ENDWITH
1370:                 WITH .Buttons(3)
1371:                     .AutoSize  = .T.
1372:                     .BackStyle = 0
1373:                     .Caption   = "Ideal"
1374:                     .FontName  = "Tahoma"
1375:                     .FontSize  = 8
1376:                     .ForeColor = RGB(90,90,90)

*-- Linhas 1417 a 1626:
1417:                 ENDWITH
1418:             ENDWITH
1419: 
1420:             *-- Peso (label + OptionGroup)
1421:             THIS.AddObject("lbl_4c_Label9", "Label")
1422:             WITH THIS.lbl_4c_Label9
1423:                 .AutoSize  = .T.
1424:                 .FontBold  = .F.
1425:                 .FontName  = "Tahoma"
1426:                 .FontSize  = 8
1427:                 .BackStyle = 0
1428:                 .Caption   = "Peso :"
1429:                 .Height    = 15
1430:                 .Left      = 565
1431:                 .Top       = 540
1432:                 .Width     = 32
1433:                 .ForeColor = RGB(90,90,90)
1434:             ENDWITH
1435: 
1436:             THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
1437:             WITH THIS.obj_4c_Opt_peso
1438:                 .AutoSize      = .F.
1439:                 .ButtonCount   = 2
1440:                 .BackStyle     = 0
1441:                 .Value         = 1
1442:                 .Height        = 25
1443:                 .Left          = 601
1444:                 .SpecialEffect = 1
1445:                 .Top           = 535
1446:                 .Width         = 198
1447:                 .Themes        = .F.
1448:                 WITH .Buttons(1)
1449:                     .AutoSize  = .F.
1450:                     .BackStyle = 0
1451:                     .Caption   = "Sim"
1452:                     .ForeColor = RGB(90,90,90)
1453:                     .Height    = 15
1454:                     .Left      = 5
1455:                     .Top       = 5
1456:                     .Width     = 41
1457:                 ENDWITH
1458:                 WITH .Buttons(2)
1459:                     .AutoSize  = .F.
1460:                     .BackStyle = 0
1461:                     .Caption   = "N" + CHR(227) + "o"
1462:                     .FontName  = "Tahoma"
1463:                     .FontSize  = 8
1464:                     .ForeColor = RGB(90,90,90)
1465:                     .Height    = 15
1466:                     .Left      = 70
1467:                     .Top       = 5
1468:                     .Width     = 41
1469:                 ENDWITH
1470:             ENDWITH
1471: 
1472:             *-- Composicao (label + OptionGroup)
1473:             THIS.AddObject("lbl_4c_Label10", "Label")
1474:             WITH THIS.lbl_4c_Label10
1475:                 .AutoSize  = .T.
1476:                 .FontBold  = .F.
1477:                 .FontName  = "Tahoma"
1478:                 .FontSize  = 8
1479:                 .BackStyle = 0
1480:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
1481:                 .Height    = 15
1482:                 .Left      = 531
1483:                 .Top       = 567
1484:                 .Width     = 66
1485:                 .ForeColor = RGB(90,90,90)
1486:             ENDWITH
1487: 
1488:             THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
1489:             WITH THIS.obj_4c_OptCompos
1490:                 .AutoSize      = .F.
1491:                 .ButtonCount   = 2
1492:                 .BackStyle     = 0
1493:                 .Value         = 1
1494:                 .Height        = 25
1495:                 .Left          = 601
1496:                 .SpecialEffect = 1
1497:                 .Top           = 562
1498:                 .Width         = 198
1499:                 .Themes        = .F.
1500:                 WITH .Buttons(1)
1501:                     .AutoSize  = .F.
1502:                     .BackStyle = 0
1503:                     .Caption   = "Sim"
1504:                     .ForeColor = RGB(90,90,90)
1505:                     .Height    = 15
1506:                     .Left      = 5
1507:                     .Top       = 5
1508:                     .Width     = 41
1509:                 ENDWITH
1510:                 WITH .Buttons(2)
1511:                     .AutoSize  = .F.
1512:                     .BackStyle = 0
1513:                     .Caption   = "N" + CHR(227) + "o"
1514:                     .FontName  = "Tahoma"
1515:                     .FontSize  = 8
1516:                     .ForeColor = RGB(90,90,90)
1517:                     .Height    = 15
1518:                     .Left      = 70
1519:                     .Top       = 5
1520:                     .Width     = 41
1521:                 ENDWITH
1522:             ENDWITH
1523: 
1524:             *-- Ordem (label + OptionGroup)
1525:             THIS.AddObject("lbl_4c_Label11", "Label")
1526:             WITH THIS.lbl_4c_Label11
1527:                 .AutoSize  = .T.
1528:                 .FontBold  = .F.
1529:                 .FontName  = "Tahoma"
1530:                 .FontSize  = 8
1531:                 .BackStyle = 0
1532:                 .Caption   = "Ordem :"
1533:                 .Height    = 15
1534:                 .Left      = 556
1535:                 .Top       = 594
1536:                 .Width     = 41
1537:                 .ForeColor = RGB(90,90,90)
1538:             ENDWITH
1539: 
1540:             THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
1541:             WITH THIS.obj_4c_OptOrdem
1542:                 .AutoSize      = .F.
1543:                 .ButtonCount   = 2
1544:                 .BackStyle     = 0
1545:                 .Value         = 1
1546:                 .Height        = 25
1547:                 .Left          = 601
1548:                 .SpecialEffect = 1
1549:                 .Top           = 589
1550:                 .Width         = 198
1551:                 .Themes        = .F.
1552:                 WITH .Buttons(1)
1553:                     .AutoSize  = .T.
1554:                     .BackStyle = 0
1555:                     .Caption   = "Produto"
1556:                     .ForeColor = RGB(90,90,90)
1557:                     .Height    = 15
1558:                     .Left      = 5
1559:                     .Top       = 4
1560:                     .Width     = 56
1561:                 ENDWITH
1562:                 WITH .Buttons(2)
1563:                     .AutoSize  = .T.
1564:                     .BackStyle = 0
1565:                     .Caption   = "Nenhuma"
1566:                     .FontName  = "Tahoma"
1567:                     .FontSize  = 8
1568:                     .ForeColor = RGB(90,90,90)
1569:                     .Height    = 15
1570:                     .Left      = 70
1571:                     .Top       = 4
1572:                     .Width     = 63
1573:                 ENDWITH
1574:             ENDWITH
1575: 
1576:         CATCH TO loc_oErro
1577:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1578:                     " PROC=" + loc_oErro.Procedure, ;
1579:                     "Erro FormSigPrEtq.ConfigurarPaginaDados")
1580:         ENDTRY
1581:     ENDPROC
1582: 
1583:     *--------------------------------------------------------------------------
1584:     * CarregarTiposEtiqueta - Popula obj_4c_Opt_Tipo dinamicamente via SigCdTpe
1585:     *--------------------------------------------------------------------------
1586:     PROTECTED PROCEDURE CarregarTiposEtiqueta()
1587:         LOCAL loc_oErro, loc_lSucesso, loc_nTipos, loc_nI, loc_nTop, loc_nHeight
1588: 
1589:         loc_lSucesso = .F.
1590:         loc_nI      = 1
1591:         loc_nTop    = 10
1592:         loc_nHeight = 15
1593: 
1594:         TRY
1595:             IF SQLEXEC(gnConnHandle, ;
1596:                 "SELECT nTipos, RTRIM(cEtiquetas) AS cEtiquetas " + ;
1597:                 "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
1598:                 "cursor_4c_TiposEti") > 0
1599: 
1600:                 SELECT cursor_4c_TiposEti
1601:                 loc_nTipos = RECCOUNT("cursor_4c_TiposEti")
1602: 
1603:                 IF loc_nTipos > 0
1604:                     WITH THIS.obj_4c_Opt_Tipo
1605:                         .ButtonCount = loc_nTipos
1606:                         SELECT cursor_4c_TiposEti
1607:                         GO TOP IN cursor_4c_TiposEti
1608:                         DO WHILE !EOF("cursor_4c_TiposEti")
1609:                             WITH .Buttons(loc_nI)
1610:                                 .AutoSize  = .F.
1611:                                 .Width     = 197
1612:                                 .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
1613:                                              ALLTRIM(cursor_4c_TiposEti.cEtiquetas)
1614:                                 .ForeColor = RGB(90,90,90)
1615:                                 .Tag       = ALLTRIM(STR(cursor_4c_TiposEti.nTipos))
1616:                                 .Top       = loc_nTop
1617:                                 .BackStyle = 0
1618:                                 .Height    = 16
1619:                                 .Left      = 9
1620:                             ENDWITH
1621:                             loc_nI      = loc_nI + 1
1622:                             loc_nTop    = loc_nTop + 20
1623:                             loc_nHeight = loc_nHeight + 20
1624:                             SKIP IN cursor_4c_TiposEti
1625:                         ENDDO
1626:                         .Height = loc_nHeight

*-- Linhas 1637 a 1774:
1637: 
1638:         CATCH TO loc_oErro
1639:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1640:                     " PROC=" + loc_oErro.Procedure, ;
1641:                     "Erro FormSigPrEtq.CarregarTiposEtiqueta")
1642:         ENDTRY
1643: 
1644:         RETURN loc_lSucesso
1645:     ENDPROC
1646: 
1647:     *--------------------------------------------------------------------------
1648:     * TxtLprecoKeyPress - KeyPress do campo Lista de Precos principal
1649:     *--------------------------------------------------------------------------
1650:     PROCEDURE TxtLprecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1651:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1652:             RETURN
1653:         ENDIF
1654:         THIS.AbrirBuscaLPreco(THIS.txt_4c_Lpreco)
1655:     ENDPROC
1656: 
1657:     *--------------------------------------------------------------------------
1658:     * TxtLPreco2KeyPress - KeyPress do campo Lista de Precos adicional
1659:     *--------------------------------------------------------------------------
1660:     PROCEDURE TxtLPreco2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1661:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1662:             RETURN
1663:         ENDIF
1664:         THIS.AbrirBuscaLPreco(THIS.txt_4c_LPreco2)
1665:     ENDPROC
1666: 
1667:     *--------------------------------------------------------------------------
1668:     * AbrirBuscaLPreco - Lookup SigCdLpc; se txt_4c_Lpreco + chkLista=1 carrega itens
1669:     *--------------------------------------------------------------------------
1670:     PROTECTED PROCEDURE AbrirBuscaLPreco(par_oTxt)
1671:         LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet
1672: 
1673:         loc_lSucesso  = .F.
1674:         loc_lEncontrado = .F.
1675: 
1676:         TRY
1677:             loc_cValor = ALLTRIM(par_oTxt.Value)
1678: 
1679:             *-- Tenta match exato
1680:             IF !EMPTY(loc_cValor)
1681:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1682:                     "SELECT TOP 1 RTRIM(LPrecos) AS LPrecos FROM SigCdLpc " + ;
1683:                     "WHERE RTRIM(LPrecos) = " + EscaparSQL(loc_cValor), ;
1684:                     "cursor_4c_ChkLpc")
1685:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkLpc")
1686:                     par_oTxt.Value = ALLTRIM(cursor_4c_ChkLpc.LPrecos)
1687:                     loc_lEncontrado = .T.
1688:                     IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
1689:                        THIS.chk_4c_ChkLista.Value = 1
1690:                         THIS.CarregarItensListaPreco(par_oTxt.Value)
1691:                     ENDIF
1692:                 ENDIF
1693:                 IF USED("cursor_4c_ChkLpc")
1694:                     USE IN cursor_4c_ChkLpc
1695:                 ENDIF
1696:             ENDIF
1697: 
1698:             *-- Match nao encontrado: abre picker
1699:             IF !loc_lEncontrado
1700:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLpc", ;
1701:                     "cursor_4c_BuscaLpc", "LPrecos", loc_cValor, ;
1702:                     "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
1703:                 IF VARTYPE(loc_oLookup) = "O"
1704:                     loc_oLookup.mAddColuna("LPrecos", "", "Lista de Pre" + CHR(231) + "os")
1705:                     loc_oLookup.Show()
1706:                     IF loc_oLookup.this_lSelecionou
1707:                         par_oTxt.Value = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
1708:                         IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
1709:                            THIS.chk_4c_ChkLista.Value = 1
1710:                             THIS.CarregarItensListaPreco(par_oTxt.Value)
1711:                         ENDIF
1712:                     ENDIF
1713:                     IF USED("cursor_4c_BuscaLpc")
1714:                         USE IN cursor_4c_BuscaLpc
1715:                     ENDIF
1716:                 ENDIF
1717:             ENDIF
1718: 
1719:             loc_lSucesso = .T.
1720: 
1721:         CATCH TO loc_oErro
1722:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1723:                     " PROC=" + loc_oErro.Procedure, ;
1724:                     "Erro FormSigPrEtq.AbrirBuscaLPreco")
1725:         ENDTRY
1726: 
1727:         RETURN loc_lSucesso
1728:     ENDPROC
1729: 
1730:     *--------------------------------------------------------------------------
1731:     * CarregarItensListaPreco - Popula dbImpressao com itens de SigCdLpi
1732:     * Verifica validade do preco; se expirado, busca preco atual em SigCdPro
1733:     *--------------------------------------------------------------------------
1734:     PROTECTED PROCEDURE CarregarItensListaPreco(par_cLPreco)
1735:         LOCAL loc_oErro, loc_lSucesso, loc_cSQL, loc_nPVens, loc_nPrecoDe, loc_nRetPro
1736: 
1737:         loc_lSucesso = .F.
1738: 
1739:         TRY
1740:             ZAP IN dbImpressao
1741: 
1742:             loc_cSQL = "SELECT RTRIM(a.LPrecos) AS LPrecos, RTRIM(a.CPros) AS Cpros, " + ;
1743:                        "RTRIM(a.DPros) AS DPros, a.PVens, a.Precode AS PrecoDe, " + ;
1744:                        "a.VencIs, a.VencFs " + ;
1745:                        "FROM SigCdLpi a " + ;
1746:                        "WHERE RTRIM(a.LPrecos) = " + EscaparSQL(par_cLPreco)
1747: 
1748:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpreI") > 0
1749:                 SELECT cursor_4c_LpreI
1750:                 SCAN
1751:                     loc_nPVens   = cursor_4c_LpreI.PVens
1752:                     loc_nPrecoDe = cursor_4c_LpreI.PrecoDe
1753: 
1754:                     *-- Se preco da lista expirou, usa preco atual do produto
1755:                     IF !BETWEEN(DATETIME(), cursor_4c_LpreI.VencIs, cursor_4c_LpreI.VencFs)
1756:                         loc_nRetPro = SQLEXEC(gnConnHandle, ;
1757:                             "SELECT TOP 1 PVens, PrecoDe FROM SigCdPro " + ;
1758:                             "WHERE RTRIM(CPros) = " + ;
1759:                             EscaparSQL(ALLTRIM(cursor_4c_LpreI.Cpros)), ;
1760:                             "cursor_4c_LproPro")
1761:                         IF loc_nRetPro > 0 AND !EOF("cursor_4c_LproPro")
1762:                             loc_nPVens   = cursor_4c_LproPro.PVens
1763:                             loc_nPrecoDe = cursor_4c_LproPro.PrecoDe
1764:                         ENDIF
1765:                         IF USED("cursor_4c_LproPro")
1766:                             USE IN cursor_4c_LproPro
1767:                         ENDIF
1768:                     ENDIF
1769: 
1770:                     INSERT INTO dbImpressao ;
1771:                         (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
1772:                     VALUES ;
1773:                         (cursor_4c_LpreI.Cpros, cursor_4c_LpreI.DPros, 1, 1, ;
1774:                          PADR(par_cLPreco, 10), loc_nPVens, ;

*-- Linhas 1791 a 2054:
1791: 
1792:         CATCH TO loc_oErro
1793:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1794:                     " PROC=" + loc_oErro.Procedure, ;
1795:                     "Erro FormSigPrEtq.CarregarItensListaPreco")
1796:         ENDTRY
1797: 
1798:         RETURN loc_lSucesso
1799:     ENDPROC
1800: 
1801:     *--------------------------------------------------------------------------
1802:     * TxtEmpsKeyPress - KeyPress do campo Empresa
1803:     *--------------------------------------------------------------------------
1804:     PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1805:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1806:             RETURN
1807:         ENDIF
1808:         THIS.AbrirBuscaEmps()
1809:     ENDPROC
1810: 
1811:     *--------------------------------------------------------------------------
1812:     * AbrirBuscaEmps - Lookup Empresa (SigCdEmp -> Cemps + Razas)
1813:     *--------------------------------------------------------------------------
1814:     PROTECTED PROCEDURE AbrirBuscaEmps()
1815:         LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet
1816: 
1817:         loc_lSucesso  = .F.
1818:         loc_lEncontrado = .F.
1819: 
1820:         TRY
1821:             loc_cValor = ALLTRIM(THIS.txt_4c_Emps.Value)
1822: 
1823:             *-- Tenta match exato
1824:             IF !EMPTY(loc_cValor)
1825:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1826:                     "SELECT TOP 1 RTRIM(Cemps) AS Cemps FROM SigCdEmp " + ;
1827:                     "WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cValor), ;
1828:                     "cursor_4c_ChkEmp")
1829:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkEmp")
1830:                     THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_ChkEmp.Cemps)
1831:                     loc_lEncontrado = .T.
1832:                 ENDIF
1833:                 IF USED("cursor_4c_ChkEmp")
1834:                     USE IN cursor_4c_ChkEmp
1835:                 ENDIF
1836:             ENDIF
1837: 
1838:             *-- Abre picker se nao encontrou match exato
1839:             IF !loc_lEncontrado
1840:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1841:                     "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
1842:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")
1843:                 IF VARTYPE(loc_oLookup) = "O"
1844:                     loc_oLookup.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1845:                     loc_oLookup.mAddColuna("Razas", "", "Empresa")
1846:                     loc_oLookup.Show()
1847:                     IF loc_oLookup.this_lSelecionou
1848:                         THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1849:                     ENDIF
1850:                     IF USED("cursor_4c_BuscaEmp")
1851:                         USE IN cursor_4c_BuscaEmp
1852:                     ENDIF
1853:                 ENDIF
1854:             ENDIF
1855: 
1856:             loc_lSucesso = .T.
1857: 
1858:         CATCH TO loc_oErro
1859:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1860:                     " PROC=" + loc_oErro.Procedure, ;
1861:                     "Erro FormSigPrEtq.AbrirBuscaEmps")
1862:         ENDTRY
1863: 
1864:         RETURN loc_lSucesso
1865:     ENDPROC
1866: 
1867:     *--------------------------------------------------------------------------
1868:     * TxtDopesKeyPress - KeyPress do campo Operacao
1869:     *--------------------------------------------------------------------------
1870:     PROCEDURE TxtDopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1871:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1872:             RETURN
1873:         ENDIF
1874:         THIS.AbrirBuscaDopes()
1875:     ENDPROC
1876: 
1877:     *--------------------------------------------------------------------------
1878:     * AbrirBuscaDopes - Lookup Operacao (SigCdOpe - single-column: Dopes = PK+descricao)
1879:     *--------------------------------------------------------------------------
1880:     PROTECTED PROCEDURE AbrirBuscaDopes()
1881:         LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet
1882: 
1883:         loc_lSucesso  = .F.
1884:         loc_lEncontrado = .F.
1885: 
1886:         TRY
1887:             loc_cValor = ALLTRIM(THIS.txt_4c_Dopes.Value)
1888: 
1889:             *-- Tenta match exato
1890:             IF !EMPTY(loc_cValor)
1891:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1892:                     "SELECT TOP 1 RTRIM(Dopes) AS Dopes FROM SigCdOpe " + ;
1893:                     "WHERE RTRIM(Dopes) = " + EscaparSQL(loc_cValor), ;
1894:                     "cursor_4c_ChkOpe")
1895:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkOpe")
1896:                     THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ChkOpe.Dopes)
1897:                     loc_lEncontrado = .T.
1898:                 ENDIF
1899:                 IF USED("cursor_4c_ChkOpe")
1900:                     USE IN cursor_4c_ChkOpe
1901:                 ENDIF
1902:             ENDIF
1903: 
1904:             *-- Abre picker (SigCdOpe: Dopes eh PK e descricao - coluna unica)
1905:             IF !loc_lEncontrado
1906:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
1907:                     "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
1908:                     "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
1909:                 IF VARTYPE(loc_oLookup) = "O"
1910:                     loc_oLookup.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1911:                     loc_oLookup.Show()
1912:                     IF loc_oLookup.this_lSelecionou
1913:                         THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1914:                     ENDIF
1915:                     IF USED("cursor_4c_BuscaOpe")
1916:                         USE IN cursor_4c_BuscaOpe
1917:                     ENDIF
1918:                 ENDIF
1919:             ENDIF
1920: 
1921:             loc_lSucesso = .T.
1922: 
1923:         CATCH TO loc_oErro
1924:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1925:                     " PROC=" + loc_oErro.Procedure, ;
1926:                     "Erro FormSigPrEtq.AbrirBuscaDopes")
1927:         ENDTRY
1928: 
1929:         RETURN loc_lSucesso
1930:     ENDPROC
1931: 
1932:     *--------------------------------------------------------------------------
1933:     * CarregarImpressoras - Popula cursor_4c_ImpreV com impressoras do sistema
1934:     * e configura cbo_4c_Get_Printer
1935:     *--------------------------------------------------------------------------
1936:     PROTECTED PROCEDURE CarregarImpressoras()
1937:         LOCAL loc_oErro, loc_nTotal, loc_nI, la_4c_Printers
1938: 
1939:         TRY
1940:             IF USED("cursor_4c_ImpreV")
1941:                 USE IN cursor_4c_ImpreV
1942:             ENDIF
1943: 
1944:             SET NULL ON
1945:             CREATE CURSOR cursor_4c_ImpreV (impresS C(100) NULL)
1946:             SET NULL OFF
1947: 
1948:             DIMENSION la_4c_Printers(1, 3)
1949:             loc_nTotal = APRINTERS(la_4c_Printers)
1950: 
1951:             IF loc_nTotal > 0
1952:                 FOR loc_nI = 1 TO loc_nTotal
1953:                     INSERT INTO cursor_4c_ImpreV VALUES (la_4c_Printers[loc_nI, 1])
1954:                 ENDFOR
1955:             ENDIF
1956: 
1957:             IF RECCOUNT("cursor_4c_ImpreV") = 0
1958:                 INSERT INTO cursor_4c_ImpreV VALUES ("Impressora Padr" + CHR(227) + "o")
1959:             ENDIF
1960: 
1961:             GO TOP IN cursor_4c_ImpreV
1962: 
1963:             THIS.cbo_4c_Get_Printer.RowSourceType = 2
1964:             THIS.cbo_4c_Get_Printer.RowSource     = "cursor_4c_ImpreV"
1965:             THIS.cbo_4c_Get_Printer.BoundColumn   = 1
1966:             THIS.cbo_4c_Get_Printer.BoundTo       = .F.
1967:             THIS.cbo_4c_Get_Printer.Refresh()
1968: 
1969:         CATCH TO loc_oErro
1970:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1971:                     " PROC=" + loc_oErro.Procedure, ;
1972:                     "Erro FormSigPrEtq.CarregarImpressoras")
1973:         ENDTRY
1974:     ENDPROC
1975: 
1976:     *--------------------------------------------------------------------------
1977:     * CboGetPrinterInteractiveChange - Ao mudar impressora, resetar ajustes
1978:     *--------------------------------------------------------------------------
1979:     PROCEDURE CboGetPrinterInteractiveChange()
1980:         WITH THIS.cnt_4c__Impressora
1981:             .obj_4c_Spn_AjVerts.Value = 0
1982:             .obj_4c_Spn_AjHorzs.Value = 0
1983:             .obj_4c_Spn_AjDenss.Value = 20
1984:             .obj_4c_Spn_AjVelos.Value = 3
1985:             .Visible     = .T.
1986:         ENDWITH
1987:     ENDPROC
1988: 
1989:     *--------------------------------------------------------------------------
1990:     * GrdDadosAfterRowColChange - Valida coluna anterior ao mudar coluna no grid
1991:     * par_nColIndex = nova coluna; this_nColAnt = coluna anterior
1992:     *--------------------------------------------------------------------------
1993:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
1994: 
1995:         DO CASE
1996:         CASE THIS.this_nColAnt = 1
1997:             THIS.ValidarCpros()
1998:         CASE THIS.this_nColAnt = 4
1999:             THIS.ValidarReffs()
2000:         CASE THIS.this_nColAnt = 2
2001:             THIS.ValidarDpros()
2002:         CASE THIS.this_nColAnt = 3
2003:             THIS.ValidarQtds()
2004:         ENDCASE
2005: 
2006:         THIS.this_nColAnt = par_nColIndex
2007:         THIS.AtualizarEstadoColunas()
2008:     ENDPROC
2009: 
2010:     *--------------------------------------------------------------------------
2011:     * ValidarCpros - Valida/lookup do campo Produto (Column1) no grid
2012:     * Tenta EAN13, depois CPros exato, senao abre FormBuscaAuxiliar
2013:     *--------------------------------------------------------------------------
2014:     PROCEDURE ValidarCpros()
2015:         LOCAL loc_oErro, loc_cProd, loc_nCod, loc_nRet, loc_lSucesso, loc_oBusca
2016: 
2017:         loc_lSucesso = .F.
2018: 
2019:         TRY
2020:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2021:                 RETURN
2022:             ENDIF
2023: 
2024:             loc_cProd = ALLTRIM(NVL(dbImpressao.Cpros, ""))
2025: 
2026:             *-- Campo vazio: limpar descricao
2027:             IF EMPTY(loc_cProd)
2028:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
2029:                 THIS.grd_4c_Dados.Refresh()
2030:                 RETURN
2031:             ENDIF
2032: 
2033:             *-- 1. Tentar match por EAN13 (numerico inteiro)
2034:             loc_nCod = INT(VAL(loc_cProd))
2035:             IF loc_nCod > 0
2036:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2037:                     "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2038:                     "PVens, PrecoDe FROM SigCdPro " + ;
2039:                     "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod), ;
2040:                     "cursor_4c_PrEan")
2041:                 IF loc_nRet > 0 AND !EOF("cursor_4c_PrEan")
2042:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrEan.Cpros), 14)
2043:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_PrEan.DPros), 40)
2044:                     dbImpressao.PVens   = cursor_4c_PrEan.PVens
2045:                     dbImpressao.PrecoDe = cursor_4c_PrEan.PrecoDe
2046:                     THIS.grd_4c_Dados.Refresh()
2047:                     IF USED("cursor_4c_PrEan")
2048:                         USE IN cursor_4c_PrEan
2049:                     ENDIF
2050:                     RETURN
2051:                 ENDIF
2052:                 IF USED("cursor_4c_PrEan")
2053:                     USE IN cursor_4c_PrEan
2054:                 ENDIF

*-- Linhas 2075 a 2672:
2075:             ENDIF
2076: 
2077:             *-- 3. Nao encontrado: abrir picker de produto
2078:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2079:                 "cursor_4c_BuscaPro", "CPros", loc_cProd, ;
2080:                 "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
2081:             IF VARTYPE(loc_oBusca) = "O"
2082:                 loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2083:                 loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2084:                 loc_oBusca.Show()
2085:                 IF loc_oBusca.this_lSelecionou
2086:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaPro.CPros), 14)
2087:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaPro.DPros), 40)
2088:                 ENDIF
2089:                 IF USED("cursor_4c_BuscaPro")
2090:                     USE IN cursor_4c_BuscaPro
2091:                 ENDIF
2092:                 loc_oBusca.Release()
2093:             ENDIF
2094: 
2095:             THIS.grd_4c_Dados.Refresh()
2096:             loc_lSucesso = .T.
2097: 
2098:         CATCH TO loc_oErro
2099:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2100:                     " PROC=" + loc_oErro.Procedure, ;
2101:                     "Erro FormSigPrEtq.ValidarCpros")
2102:         ENDTRY
2103: 
2104:         RETURN loc_lSucesso
2105:     ENDPROC
2106: 
2107:     *--------------------------------------------------------------------------
2108:     * ValidarDpros - Valida/lookup do campo Descricao (Column2) no grid
2109:     * Tenta match exato por DPros; senao abre FormBuscaAuxiliar
2110:     *--------------------------------------------------------------------------
2111:     PROCEDURE ValidarDpros()
2112:         LOCAL loc_oErro, loc_cDesc, loc_nRet, loc_lSucesso, loc_oBusca
2113: 
2114:         loc_lSucesso = .F.
2115: 
2116:         TRY
2117:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2118:                 RETURN
2119:             ENDIF
2120: 
2121:             loc_cDesc = ALLTRIM(NVL(dbImpressao.DPros, ""))
2122: 
2123:             *-- Campo vazio: limpar cpros
2124:             IF EMPTY(loc_cDesc)
2125:                 dbImpressao.Cpros = SPACE(14)
2126:                 THIS.grd_4c_Dados.Refresh()
2127:                 RETURN
2128:             ENDIF
2129: 
2130:             *-- Tentar match por DPros
2131:             loc_nRet = SQLEXEC(gnConnHandle, ;
2132:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros " + ;
2133:                 "FROM SigCdPro WHERE RTRIM(DPros) = " + EscaparSQL(loc_cDesc), ;
2134:                 "cursor_4c_PrDp")
2135:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrDp")
2136:                 dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrDp.Cpros), 14)
2137:                 THIS.grd_4c_Dados.Refresh()
2138:                 IF USED("cursor_4c_PrDp")
2139:                     USE IN cursor_4c_PrDp
2140:                 ENDIF
2141:                 RETURN
2142:             ENDIF
2143:             IF USED("cursor_4c_PrDp")
2144:                 USE IN cursor_4c_PrDp
2145:             ENDIF
2146: 
2147:             *-- Nao encontrado: abrir picker por descricao
2148:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2149:                 "cursor_4c_BuscaProD", "DPros", loc_cDesc, ;
2150:                 "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
2151:             IF VARTYPE(loc_oBusca) = "O"
2152:                 loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2153:                 loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2154:                 loc_oBusca.Show()
2155:                 IF loc_oBusca.this_lSelecionou
2156:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaProD.CPros), 14)
2157:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaProD.DPros), 40)
2158:                 ENDIF
2159:                 IF USED("cursor_4c_BuscaProD")
2160:                     USE IN cursor_4c_BuscaProD
2161:                 ENDIF
2162:                 loc_oBusca.Release()
2163:             ENDIF
2164: 
2165:             THIS.grd_4c_Dados.Refresh()
2166:             loc_lSucesso = .T.
2167: 
2168:         CATCH TO loc_oErro
2169:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2170:                     " PROC=" + loc_oErro.Procedure, ;
2171:                     "Erro FormSigPrEtq.ValidarDpros")
2172:         ENDTRY
2173: 
2174:         RETURN loc_lSucesso
2175:     ENDPROC
2176: 
2177:     *--------------------------------------------------------------------------
2178:     * ValidarReffs - Valida/lookup do campo Ref.Fornecedor (Column4) no grid
2179:     * Busca em SigCdPro por Dpro2s; preenche cpros+dpros+precos se achar
2180:     *--------------------------------------------------------------------------
2181:     PROCEDURE ValidarReffs()
2182:         LOCAL loc_oErro, loc_cReff, loc_nRet, loc_lSucesso, loc_oBusca
2183: 
2184:         loc_lSucesso = .F.
2185: 
2186:         TRY
2187:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2188:                 RETURN
2189:             ENDIF
2190: 
2191:             loc_cReff = ALLTRIM(NVL(dbImpressao.Reffs, ""))
2192: 
2193:             IF EMPTY(loc_cReff)
2194:                 RETURN
2195:             ENDIF
2196: 
2197:             *-- Tentar match por Dpro2s (referencia do fornecedor)
2198:             loc_nRet = SQLEXEC(gnConnHandle, ;
2199:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2200:                 "RTRIM(DPro2s) AS DPro2s, PVens, PrecoDe " + ;
2201:                 "FROM SigCdPro WHERE RTRIM(DPro2s) = " + EscaparSQL(loc_cReff), ;
2202:                 "cursor_4c_PrRff")
2203:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrRff")
2204:                 dbImpressao.Cpros   = PADR(ALLTRIM(cursor_4c_PrRff.Cpros), 14)
2205:                 dbImpressao.DPros   = PADR(ALLTRIM(cursor_4c_PrRff.DPros), 40)
2206:                 dbImpressao.PVens   = cursor_4c_PrRff.PVens
2207:                 dbImpressao.PrecoDe = cursor_4c_PrRff.PrecoDe
2208:                 THIS.grd_4c_Dados.Refresh()
2209:                 IF USED("cursor_4c_PrRff")
2210:                     USE IN cursor_4c_PrRff
2211:                 ENDIF
2212:                 RETURN
2213:             ENDIF
2214:             IF USED("cursor_4c_PrRff")
2215:                 USE IN cursor_4c_PrRff
2216:             ENDIF
2217: 
2218:             *-- Nao encontrado: abrir picker por Dpro2s
2219:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2220:                 "cursor_4c_BuscaRff", "DPro2s", loc_cReff, ;
2221:                 "Sele" + CHR(231) + CHR(227) + "o por Refer" + CHR(234) + "ncia", .T., .T., "")
2222:             IF VARTYPE(loc_oBusca) = "O"
2223:                 loc_oBusca.mAddColuna("DPro2s", "", "Refer" + CHR(234) + "ncia")
2224:                 loc_oBusca.mAddColuna("CPros",  "", "C" + CHR(243) + "digo")
2225:                 loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
2226:                 loc_oBusca.Show()
2227:                 IF loc_oBusca.this_lSelecionou
2228:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaRff.CPros),  14)
2229:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaRff.DPros),  40)
2230:                     dbImpressao.Reffs = PADR(ALLTRIM(cursor_4c_BuscaRff.DPro2s), 40)
2231:                 ENDIF
2232:                 IF USED("cursor_4c_BuscaRff")
2233:                     USE IN cursor_4c_BuscaRff
2234:                 ENDIF
2235:                 loc_oBusca.Release()
2236:             ENDIF
2237: 
2238:             THIS.grd_4c_Dados.Refresh()
2239:             loc_lSucesso = .T.
2240: 
2241:         CATCH TO loc_oErro
2242:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2243:                     " PROC=" + loc_oErro.Procedure, ;
2244:                     "Erro FormSigPrEtq.ValidarReffs")
2245:         ENDTRY
2246: 
2247:         RETURN loc_lSucesso
2248:     ENDPROC
2249: 
2250:     *--------------------------------------------------------------------------
2251:     * ValidarQtds - Valida campo Quantidade (Column3) no grid
2252:     * Confirma produto valido, define QtdeEtiq e move para proxima linha
2253:     *--------------------------------------------------------------------------
2254:     PROCEDURE ValidarQtds()
2255:         LOCAL loc_oErro, loc_nQtd, loc_cProd, loc_nRet, loc_lSucesso
2256: 
2257:         loc_lSucesso = .F.
2258: 
2259:         TRY
2260:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2261:                 RETURN
2262:             ENDIF
2263: 
2264:             loc_nQtd  = NVL(dbImpressao.Qtds, 0)
2265:             loc_cProd = ALLTRIM(PADR(NVL(dbImpressao.Cpros, ""), 14))
2266: 
2267:             IF EMPTY(loc_cProd)
2268:                 RETURN
2269:             ENDIF
2270: 
2271:             *-- Validar produto existe em SigCdPro
2272:             loc_nRet = SQLEXEC(gnConnHandle, ;
2273:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros FROM SigCdPro " + ;
2274:                 "WHERE RTRIM(CPros) = " + EscaparSQL(loc_cProd), ;
2275:                 "cursor_4c_PrQt")
2276:             IF loc_nRet <= 0 OR EOF("cursor_4c_PrQt")
2277:                 MsgAviso("Produto Inv" + CHR(225) + "lido!!!")
2278:                 IF USED("cursor_4c_PrQt")
2279:                     USE IN cursor_4c_PrQt
2280:                 ENDIF
2281:                 RETURN
2282:             ENDIF
2283:             IF USED("cursor_4c_PrQt")
2284:                 USE IN cursor_4c_PrQt
2285:             ENDIF
2286: 
2287:             *-- Definir quantidade de etiquetas igual a qtds (se maior que 0)
2288:             IF loc_nQtd > 0
2289:                 dbImpressao.QtdeEtiq = loc_nQtd
2290:             ENDIF
2291: 
2292:             THIS.grd_4c_Dados.Refresh()
2293: 
2294:             *-- Avancar para proxima linha (ENTER = nova linha no grid)
2295:             SELECT dbImpressao
2296:             IF !EOF()
2297:                 SKIP
2298:                 IF EOF()
2299:                     APPEND BLANK
2300:                 ENDIF
2301:             ENDIF
2302: 
2303:             THIS.grd_4c_Dados.Refresh()
2304:             THIS.grd_4c_Dados.SetFocus
2305: 
2306:             loc_lSucesso = .T.
2307: 
2308:         CATCH TO loc_oErro
2309:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2310:                     " PROC=" + loc_oErro.Procedure, ;
2311:                     "Erro FormSigPrEtq.ValidarQtds")
2312:         ENDTRY
2313: 
2314:         RETURN loc_lSucesso
2315:     ENDPROC
2316: 
2317:     *--------------------------------------------------------------------------
2318:     * OptPrecoInteractiveChange - Ao mudar opcao de Preco, atualiza Parcelas
2319:     * Original: col_par.Text1.When = (ThisForm.opt_Preco.Value = 6)
2320:     *--------------------------------------------------------------------------
2321:     PROCEDURE OptPrecoInteractiveChange()
2322:         THIS.AtualizarEstadoColunas()
2323:     ENDPROC
2324: 
2325:     *--------------------------------------------------------------------------
2326:     * AtualizarEstadoColunas - Controla editabilidade das colunas do grid
2327:     * Replica comportamento dos When events do original SIGPRETQ:
2328:     *   col_cpros/dpros/DPro2s: editavel somente em linha nova (Cpros vazio)
2329:     *   col_par (Parcelas): editavel somente com Preco = Parcelamento (Value=6)
2330:     *--------------------------------------------------------------------------
2331:     PROCEDURE AtualizarEstadoColunas()
2332:         LOCAL loc_lNovaLinha, loc_lParcelamento
2333: 
2334:         IF !USED("dbImpressao") OR EOF("dbImpressao")
2335:             RETURN
2336:         ENDIF
2337: 
2338:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
2339:             RETURN
2340:         ENDIF
2341: 
2342:         loc_lNovaLinha    = EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2343:         loc_lParcelamento = (THIS.obj_4c_Opt_Preco.Value = 6)
2344: 
2345:         THIS.grd_4c_Dados.col_4c_cpros.ReadOnly  = !loc_lNovaLinha
2346:         THIS.grd_4c_Dados.col_4c_dpros.ReadOnly  = !loc_lNovaLinha
2347:         THIS.grd_4c_Dados.col_4c_DPro2s.ReadOnly = !loc_lNovaLinha
2348:         THIS.grd_4c_Dados.col_4c_par.ReadOnly    = !loc_lParcelamento
2349:     ENDPROC
2350: 
2351:     *--------------------------------------------------------------------------
2352:     * BtnIncluirClick - Inclui linha em branco na grade dbImpressao para
2353:     * entrada manual de um novo produto (equivalente operacional a "novo item").
2354:     * Reposiciona o cursor na nova linha e devolve o foco ao grid.
2355:     *--------------------------------------------------------------------------
2356:     PROCEDURE BtnIncluirClick()
2357:         LOCAL loc_oErro
2358: 
2359:         TRY
2360:             IF !USED("dbImpressao")
2361:                 MsgAviso("A grade de impress" + CHR(227) + "o n" + CHR(227) + ;
2362:                          "o est" + CHR(225) + " dispon" + CHR(237) + "vel!!!")
2363:                 RETURN
2364:             ENDIF
2365: 
2366:             SELECT dbImpressao
2367:             SET ORDER TO
2368: 
2369:             *-- Se a grade tem apenas uma linha em branco padrao, reusa-a
2370:             IF RECCOUNT("dbImpressao") = 1 AND EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2371:                 GO TOP IN dbImpressao
2372:             ELSE
2373:                 APPEND BLANK IN dbImpressao
2374:                 *-- Posiciona na ultima linha (a que acabou de ser criada)
2375:                 SELECT dbImpressao
2376:                 GO BOTTOM IN dbImpressao
2377:             ENDIF
2378: 
2379:             THIS.grd_4c_Dados.Refresh()
2380:             THIS.AtualizarEstadoColunas()
2381: 
2382:             *-- Foca a coluna de produto para digitacao imediata
2383:             IF PEMSTATUS(THIS.grd_4c_Dados, "col_4c_cpros", 5)
2384:                 THIS.grd_4c_Dados.SetFocus()
2385:                 THIS.grd_4c_Dados.ActivateCell( ;
2386:                     RECNO("dbImpressao"), 1)
2387:             ENDIF
2388: 
2389:         CATCH TO loc_oErro
2390:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2391:                     " PROC=" + loc_oErro.Procedure, ;
2392:                     "Erro FormSigPrEtq.BtnIncluirClick")
2393:         ENDTRY
2394:     ENDPROC
2395: 
2396:     *--------------------------------------------------------------------------
2397:     * BtnAlterarClick - Ativa edicao da linha corrente do grid, permitindo
2398:     * ajustar quantidade/etiquetas do item selecionado.
2399:     * Foca a coluna Qtds e destrava colunas quando aplicavel.
2400:     *--------------------------------------------------------------------------
2401:     PROCEDURE BtnAlterarClick()
2402:         LOCAL loc_oErro, loc_nRecno
2403: 
2404:         TRY
2405:             IF !USED("dbImpressao") OR RECCOUNT("dbImpressao") = 0
2406:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens na grade para alterar!!!")
2407:                 RETURN
2408:             ENDIF
2409: 
2410:             SELECT dbImpressao
2411:             loc_nRecno = RECNO("dbImpressao")
2412: 
2413:             IF EOF("dbImpressao") OR EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2414:                 MsgAviso("Selecione um item na grade antes de alterar!!!")
2415:                 THIS.grd_4c_Dados.SetFocus()
2416:                 RETURN
2417:             ENDIF
2418: 
2419:             *-- Permite editar Parcelas se a modalidade Preco = Parcelamento (6)
2420:             IF THIS.obj_4c_Opt_Preco.Value = 6
2421:                 THIS.grd_4c_Dados.col_4c_par.ReadOnly = .F.
2422:             ENDIF
2423: 
2424:             THIS.grd_4c_Dados.Refresh()
2425: 
2426:             *-- Foca coluna de quantidade (indice 3: Cpros=1, DPros=2, Qtds=3)
2427:             THIS.grd_4c_Dados.SetFocus()
2428:             THIS.grd_4c_Dados.ActivateCell(loc_nRecno, 3)
2429: 
2430:         CATCH TO loc_oErro
2431:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2432:                     " PROC=" + loc_oErro.Procedure, ;
2433:                     "Erro FormSigPrEtq.BtnAlterarClick")
2434:         ENDTRY
2435:     ENDPROC
2436: 
2437:     *--------------------------------------------------------------------------
2438:     * BtnVisualizarClick - Exibe resumo dos itens carregados na grade antes
2439:     * da impressao (contagem total, distintos e quantidade agregada).
2440:     * Equivalente operacional a "visualizar antes de imprimir".
2441:     *--------------------------------------------------------------------------
2442:     PROCEDURE BtnVisualizarClick()
2443:         LOCAL loc_oErro, loc_nTotal, loc_nDistintos, loc_nQtdTotal, loc_cMsg
2444: 
2445:         TRY
2446:             IF !USED("dbImpressao") OR RECCOUNT("dbImpressao") = 0
2447:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens carregados na grade!!!")
2448:                 RETURN
2449:             ENDIF
2450: 
2451:             loc_nTotal    = 0
2452:             loc_nDistintos = 0
2453:             loc_nQtdTotal = 0
2454: 
2455:             *-- Conta itens validos (Cpros preenchido)
2456:             SELECT COUNT(*) AS nTot, ;
2457:                    COUNT(DISTINCT Cpros) AS nDist, ;
2458:                    SUM(NVL(QtdeEtiq, 0)) AS nQtd ;
2459:                 FROM dbImpressao ;
2460:                 WHERE !EMPTY(NVL(Cpros, "")) ;
2461:                 INTO CURSOR cursor_4c_TmpResumo
2462: 
2463:             IF USED("cursor_4c_TmpResumo") AND !EOF("cursor_4c_TmpResumo")
2464:                 loc_nTotal     = NVL(cursor_4c_TmpResumo.nTot,  0)
2465:                 loc_nDistintos = NVL(cursor_4c_TmpResumo.nDist, 0)
2466:                 loc_nQtdTotal  = NVL(cursor_4c_TmpResumo.nQtd,  0)
2467:             ENDIF
2468: 
2469:             IF USED("cursor_4c_TmpResumo")
2470:                 USE IN cursor_4c_TmpResumo
2471:             ENDIF
2472: 
2473:             IF loc_nTotal = 0
2474:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
2475:                          " itens v" + CHR(225) + "lidos para impress" + CHR(227) + "o!!!")
2476:                 RETURN
2477:             ENDIF
2478: 
2479:             loc_cMsg = "Resumo da Impress" + CHR(227) + "o de Etiquetas:" + CHR(13) + CHR(13) + ;
2480:                        "Itens na grade....: " + TRANSFORM(loc_nTotal)     + CHR(13) + ;
2481:                        "Produtos distintos: " + TRANSFORM(loc_nDistintos) + CHR(13) + ;
2482:                        "Etiquetas a imprimir: " + TRANSFORM(loc_nQtdTotal, "@R 999,999,999")
2483: 
2484:             MsgInfo(loc_cMsg, "Visualizar Impress" + CHR(227) + "o")
2485: 
2486:             SELECT dbImpressao
2487:             GO TOP IN dbImpressao
2488:             THIS.grd_4c_Dados.Refresh()
2489: 
2490:         CATCH TO loc_oErro
2491:             IF USED("cursor_4c_TmpResumo")
2492:                 USE IN cursor_4c_TmpResumo
2493:             ENDIF
2494:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2495:                     " PROC=" + loc_oErro.Procedure, ;
2496:                     "Erro FormSigPrEtq.BtnVisualizarClick")
2497:         ENDTRY
2498:     ENDPROC
2499: 
2500:     *--------------------------------------------------------------------------
2501:     * FormParaBO - Transfere parametros dos controles do form para o BO
2502:     * Chamado por BtnImprimeClick antes de ImprimirEtiquetas
2503:     *--------------------------------------------------------------------------
2504:     PROCEDURE FormParaBO()
2505:         LOCAL loc_nTipo, loc_oBO
2506: 
2507:         loc_oBO = THIS.this_oBusinessObject
2508: 
2509:         loc_oBO.this_nImpPreco     = THIS.obj_4c_Opt_Preco.Value
2510:         loc_oBO.this_lImpSepar     = (THIS.obj_4c_Opt_separador.Value = 1)
2511:         loc_oBO.this_lImpPeso      = (THIS.obj_4c_Opt_peso.Value = 1)
2512:         loc_oBO.this_lCompo        = (THIS.obj_4c_OptCompos.Value = 1)
2513: 
2514:         loc_nTipo = THIS.obj_4c_Opt_Tipo.Value
2515:         IF loc_nTipo >= 1 AND loc_nTipo <= THIS.obj_4c_Opt_Tipo.ButtonCount
2516:             loc_oBO.this_nTipo  = loc_nTipo
2517:             loc_oBO.this_nTpEti = INT(VAL(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipo).Tag))
2518:         ENDIF
2519: 
2520:         loc_oBO.this_nTpImp        = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value
2521:         loc_oBO.this_nAjVertsPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
2522:         loc_oBO.this_nAjHorzsPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
2523:         loc_oBO.this_nAjDensPrint  = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
2524:         loc_oBO.this_nAjVelosPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value
2525: 
2526:         IF USED("cursor_4c_ImpreV") AND !EOF("cursor_4c_ImpreV")
2527:             loc_oBO.this_cNomeImp = ALLTRIM(NVL(cursor_4c_ImpreV.impresS, ""))
2528:         ELSE
2529:             loc_oBO.this_cNomeImp = ""
2530:         ENDIF
2531: 
2532:         loc_oBO.this_cLp1   = ALLTRIM(THIS.txt_4c_Lpreco.Value)
2533:         loc_oBO.this_cLp2   = ALLTRIM(THIS.txt_4c_LPreco2.Value)
2534:         loc_oBO.this_nOrdem = THIS.obj_4c_OptOrdem.Value
2535:         loc_oBO.this_cDopes = ALLTRIM(THIS.txt_4c_Dopes.Value)
2536:         loc_oBO.this_nNumes = THIS.txt_4c_Numes.Value
2537:     ENDPROC
2538: 
2539:     *--------------------------------------------------------------------------
2540:     * BOParaForm - OPERACIONAL: BO nao carrega registros para edicao.
2541:     * Presente para padrao do pipeline; sem acao real neste form.
2542:     *--------------------------------------------------------------------------
2543:     PROTECTED PROCEDURE BOParaForm()
2544:         *-- OPERACIONAL: dados vem de SQL via BtnCarregarClick/CarregarItensListaPreco
2545:         *-- Nao ha "registro corrente" do BO para carregar nos controles
2546:         RETURN .T.
2547:     ENDPROC
2548: 
2549:     *--------------------------------------------------------------------------
2550:     * CarregarLista - Refresca a exibicao da grade dbImpressao
2551:     * OPERACIONAL: sem lista de cadastro; reposiciona e refresca o grid
2552:     *--------------------------------------------------------------------------
2553:     PROCEDURE CarregarLista()
2554:         IF USED("dbImpressao")
2555:             SELECT dbImpressao
2556:             IF RECCOUNT("dbImpressao") = 0
2557:                 APPEND BLANK IN dbImpressao
2558:             ENDIF
2559:             GO TOP IN dbImpressao
2560:         ENDIF
2561: 
2562:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2563:             THIS.grd_4c_Dados.Refresh()
2564:         ENDIF
2565:     ENDPROC
2566: 
2567:     *--------------------------------------------------------------------------
2568:     * LimparCampos - Limpa filtros de entrada e reseta grade dbImpressao
2569:     *--------------------------------------------------------------------------
2570:     PROCEDURE LimparCampos()
2571:         IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5)
2572:             THIS.txt_4c_Lpreco.Value  = ""
2573:         ENDIF
2574:         IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5)
2575:             THIS.txt_4c_LPreco2.Value = ""
2576:         ENDIF
2577:         IF PEMSTATUS(THIS, "txt_4c_Emps", 5)
2578:             THIS.txt_4c_Emps.Value    = ""
2579:         ENDIF
2580:         IF PEMSTATUS(THIS, "txt_4c_Dopes", 5)
2581:             THIS.txt_4c_Dopes.Value   = ""
2582:         ENDIF
2583:         IF PEMSTATUS(THIS, "txt_4c_Numes", 5)
2584:             THIS.txt_4c_Numes.Value   = 0
2585:         ENDIF
2586: 
2587:         IF USED("dbImpressao")
2588:             ZAP IN dbImpressao
2589:             APPEND BLANK IN dbImpressao
2590:             GO TOP IN dbImpressao
2591:         ENDIF
2592: 
2593:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2594:             THIS.grd_4c_Dados.Refresh()
2595:         ENDIF
2596:     ENDPROC
2597: 
2598:     *--------------------------------------------------------------------------
2599:     * HabilitarCampos - Habilita controles de entrada
2600:     * OPERACIONAL: campos sempre habilitados (sem modos INCLUIR/ALTERAR)
2601:     *--------------------------------------------------------------------------
2602:     PROCEDURE HabilitarCampos()
2603:         IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5)
2604:             THIS.txt_4c_Lpreco.Enabled = .T.
2605:         ENDIF
2606:         IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5)
2607:             THIS.txt_4c_LPreco2.Enabled = .T.
2608:         ENDIF
2609:         IF PEMSTATUS(THIS, "txt_4c_Emps", 5)
2610:             THIS.txt_4c_Emps.Enabled = .T.
2611:         ENDIF
2612:         IF PEMSTATUS(THIS, "txt_4c_Dopes", 5)
2613:             THIS.txt_4c_Dopes.Enabled = .T.
2614:         ENDIF
2615:         IF PEMSTATUS(THIS, "txt_4c_Numes", 5)
2616:             THIS.txt_4c_Numes.Enabled = .T.
2617:         ENDIF
2618:         IF PEMSTATUS(THIS, "chk_4c_ChkLista", 5)
2619:             THIS.chk_4c_ChkLista.Enabled = .T.
2620:         ENDIF
2621:         IF PEMSTATUS(THIS, "chk_4c_ChkOperacoes", 5)
2622:             THIS.chk_4c_ChkOperacoes.Enabled = .T.
2623:         ENDIF
2624:         IF PEMSTATUS(THIS, "cmd_4c_BtnCarregar", 5)
2625:         ENDIF
2626:         IF PEMSTATUS(THIS, "cmd_4c_Btnexcluir", 5)
2627:         ENDIF
2628:     ENDPROC
2629: 
2630:     *--------------------------------------------------------------------------
2631:     * AjustarBotoesPorModo - OPERACIONAL: sem modos CRUD; no-op
2632:     *--------------------------------------------------------------------------
2633:     PROCEDURE AjustarBotoesPorModo()
2634:         *-- OPERACIONAL nao tem modos INCLUIR/ALTERAR/VISUALIZAR
2635:         *-- Botoes sao fixos: Carregar, Excluir, Imprimir, Sair
2636:         RETURN .T.
2637:     ENDPROC
2638: 
2639:     *--------------------------------------------------------------------------
2640:     * BtnEncerrarClick - Fecha o formulario (alias canonico para BtnSairClick)
2641:     *--------------------------------------------------------------------------
2642:     PROCEDURE BtnEncerrarClick()
2643:         THIS.Release()
2644:     ENDPROC
2645: 
2646:     *--------------------------------------------------------------------------
2647:     * BtnBuscarClick - Equivalente operacional de "Buscar": carrega itens
2648:     * da movimentacao para a grade (delega a BtnCarregarClick)
2649:     *--------------------------------------------------------------------------
2650:     PROCEDURE BtnBuscarClick()
2651:         THIS.BtnCarregarClick()
2652:     ENDPROC
2653: 
2654:     *--------------------------------------------------------------------------
2655:     * BtnSalvarClick - Equivalente operacional de "Salvar": confirma impressao
2656:     * (delega a BtnImprimeClick para compatibilidade com pipeline)
2657:     *--------------------------------------------------------------------------
2658:     PROCEDURE BtnSalvarClick()
2659:         THIS.BtnImprimeClick()
2660:     ENDPROC
2661: 
2662:     *--------------------------------------------------------------------------
2663:     * BtnCancelarClick - Equivalente operacional de "Cancelar": limpa campos
2664:     * e reseta a grade sem fechar o formulario
2665:     *--------------------------------------------------------------------------
2666:     PROCEDURE BtnCancelarClick()
2667:         IF MsgConfirma("Limpar campos e reiniciar a grade?")
2668:             THIS.LimparCampos()
2669:         ENDIF
2670:     ENDPROC
2671: 
2672: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SIGPRETQBO.PRG
* Business Object - Impressao de Etiquetas Selecionadas
* Form OPERACIONAL - cursor local dbImpressao, sem tabela principal
*==============================================================================

DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Sem tabela principal (form operacional)
    this_cTabela       = ""
    this_cCampoChave   = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro / entrada do usuario
    *--------------------------------------------------------------------------
    this_cEmps         = ""    && Empresa (3 chars)
    this_cDopes        = ""    && Operacao (20 chars)
    this_nNumes        = 0     && Numero do documento
    this_cLPrecos      = ""    && Lista de precos 1 (30 chars)
    this_cLPrecos2     = ""    && Lista de precos 2 (30 chars)

    *--------------------------------------------------------------------------
    * Configuracao da etiqueta (SigCdPam)
    *--------------------------------------------------------------------------
    this_nMaxTpEtis    = 0     && Numero maximo de tipos de etiqueta
    this_nTpEtiPads    = 0     && Tipo de etiqueta padrao
    this_nMaxImpEti    = 0     && Numero maximo de impressoras
    this_nImpEtis      = 0     && Impressora padrao
    this_cTpInstalas   = ""    && Tipo de instalacao
    this_nAjVerts      = 0     && Ajuste vertical padrao (SigCdPam)
    this_nAjHorzs      = 0     && Ajuste horizontal padrao (SigCdPam)
    this_cTpCBars      = ""    && Tipo de codigo de barras

    *--------------------------------------------------------------------------
    * Configuracao adicional (SigCdPac)
    *--------------------------------------------------------------------------
    this_nAjDens       = 20   && Ajuste de densidade padrao
    this_nAjVelos      = 1    && Ajuste de velocidade padrao
    this_nEtqSeps      = 1    && Etiqueta separadora (1=Sim, 2=Nao)

    *--------------------------------------------------------------------------
    * Opcoes de impressao (espelham controles do form)
    *--------------------------------------------------------------------------
    this_nImpPreco     = 1    && Tipo de preco a imprimir (1-6, opt_Preco.Value)
    this_lImpSepar     = .T.  && Imprimir separadora (opt_separador=1)
    this_lImpPeso      = .T.  && Imprimir peso (opt_peso=1)
    this_lCompo        = .T.  && Imprimir composicao (optCompos=1)
    this_nTipo         = 1    && Indice do tipo de etiqueta (Opt_Tipo.Value)
    this_nTpEti        = 0    && ID do tipo de etiqueta (SigCdTpe.nTipos via Tag)
    this_nTpImp        = 1    && Tipo impressora (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nAjVertsPrint = 0    && Ajuste vertical para impressao (Spn_AjVerts.Value)
    this_nAjHorzsPrint = 0    && Ajuste horizontal para impressao (Spn_AjHorzs.Value)
    this_nAjDensPrint  = 20   && Densidade para impressao (Spn_AjDenss.Value)
    this_nAjVelosPrint = 1    && Velocidade para impressao (spn_AjVelos.Value)
    this_cNomeImp      = ""   && Nome da impressora selecionada (crImpreV.impres)
    this_nImpres       = 0    && Numero de registro da impressora (RECNO crImpreV)
    this_cLp1          = ""   && Lista de precos 1 (passada ao SigOpEtq)
    this_cLp2          = ""   && Lista de precos 2 (passada ao SigOpEtq)
    this_nOrdem        = 1    && Ordem de impressao (1=Produto, 2=Nenhuma)

    *--------------------------------------------------------------------------
    * Campos do cursor dbImpressao (linha corrente)
    *--------------------------------------------------------------------------
    this_cReffs        = ""    && Referencia do fornecedor (dbImpressao.Reffs)
    this_nQtds         = 0     && Quantidade (dbImpressao.Qtds)
    this_nQtdeEtiq     = 0     && Quantidade de etiquetas (dbImpressao.QtdeEtiq)
    this_cPedido       = ""    && Numero do pedido (dbImpressao.Pedido)
    this_cObs          = ""    && Obs / lista de precos usada (dbImpressao.Obs)
    this_nParcelas     = 0     && Numero de parcelas (dbImpressao.Parcelas)
    this_cCpros2       = ""    && Codigo produto 2 (dbImpressao.Cpros2)
    this_cCpros3       = ""    && Codigo produto 3 (dbImpressao.Cpros3)
    this_cCpros4       = ""    && Codigo produto 4 (dbImpressao.Cpros4)
    this_cEmpos        = ""    && Empresa (dbImpressao.empos)
    this_cEmpdopnums   = ""    && Chave emp+ope+num (dbImpressao.empdopnums)
    this_nCitens       = 0     && Numero do item (dbImpressao.citens)
    this_nPesos        = 0     && Peso do item (dbImpressao.Pesos)
    this_cCodTams      = ""    && Codigo do tamanho (dbImpressao.CodTams)

    *--------------------------------------------------------------------------
    * Produto corrente (validado no grid)
    *--------------------------------------------------------------------------
    this_cCpros        = ""   && Codigo do produto (SigCdPro.CPros)
    this_cDpros        = ""   && Descricao do produto (SigCdPro.DPros)
    this_cDpro2s       = ""   && Referencia do fornecedor (SigCdPro.Dpro2s)
    this_cCunis        = ""   && Unidade do produto (SigCdPro.CUnis)
    this_nPVens        = 0    && Preco de venda (SigCdPro.PVens)
    this_nPrecoDe      = 0    && Preco De (SigCdPro.PrecoDe)
    this_nPesoMs       = 0    && Peso do produto (SigCdPro.PesoMs)

    *--------------------------------------------------------------------------
    * INIT - Configura BO sem tabela principal (form operacional)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            DODEFAULT()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracao - Carrega SigCdPam e SigCdPac
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, " + ;
                       "TpInstalas, AjVerts, AjHorzs, TpCBars " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                IF !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_nMaxTpEtis  = NVL(nMaxTpEtis, 7)
                    THIS.this_nTpEtiPads  = NVL(TpEtiPads,  1)
                    THIS.this_nMaxImpEti  = NVL(nMaxImpEti, 5)
                    THIS.this_nImpEtis    = NVL(ImpEtis,    1)
                    THIS.this_cTpInstalas = NVL(TpInstalas, "")
                    THIS.this_nAjVerts    = NVL(AjVerts,    0)
                    THIS.this_nAjHorzs    = NVL(AjHorzs,    0)
                    THIS.this_cTpCBars    = NVL(TpCBars,    "")

                    THIS.this_nAjVertsPrint = THIS.this_nAjVerts
                    THIS.this_nAjHorzsPrint = THIS.this_nAjHorzs
                ENDIF
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_cSQL = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                IF !EOF("cursor_4c_SigCdPac")
                    SELECT cursor_4c_SigCdPac
                    THIS.this_nAjDens   = IIF(EMPTY(NVL(AjDens,  0)), 20, NVL(AjDens,  0))
                    THIS.this_nAjVelos  = IIF(EMPTY(NVL(AjVelos, 0)), 1,  NVL(AjVelos, 0))
                    THIS.this_nEtqSeps  = NVL(EtqSeps, 1)

                    THIS.this_nAjDensPrint  = THIS.this_nAjDens
                    THIS.this_nAjVelosPrint = THIS.this_nAjVelos
                ENDIF
                USE IN cursor_4c_SigCdPac
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarConfiguracao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega SigCdTpe em cursor cursor_4c_TiposEti
    * Retorna: numero de tipos encontrados (0 se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_nTipos, loc_oErro, loc_cSQL

        loc_nTipos = 0

        TRY
            loc_cSQL = "SELECT nTipos, cEtiquetas, cOrdems, nSituas " + ;
                       "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposEti") > 0
                loc_nTipos = _TALLY
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarTiposEtiqueta")
            loc_nTipos = 0
        ENDTRY

        RETURN loc_nTipos
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras disponiveis para o usuario
    * Popula cursor_4c_ImpTemp com campo Impres C(50)
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario

        loc_lSucesso = .F.

        TRY
            loc_cUsuario = EscaparSQL(gc_4c_UsuarioLogado)

            loc_cSQL = "SELECT b.Impres FROM SigSyImp a " + ;
                       "INNER JOIN SigCdmp b ON a.CImps = b.Impres " + ;
                       "WHERE a.UsuAcess = " + loc_cUsuario + ;
                       " AND b.nTpImpres = 2 " + ;
                       "UNION ALL " + ;
                       "SELECT c.Impres FROM SigCdAcG a " + ;
                       "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
                       "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;
                       "WHERE a.Usuarios = " + loc_cUsuario + ;
                       " AND c.nTpImpres = 2"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") <= 0
                loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
                           "WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarImpressoras")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorListaPrecos - Popula dbImpressao via SigCdLpi
    * par_cLPrecos:      codigo da lista de precos
    * par_lCarregarItens: se .T. insere itens no cursor dbImpressao
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorListaPrecos(par_cLPrecos, par_lCarregarItens)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nVal, loc_nValDe
        LOCAL loc_cCPros, loc_cDPros, loc_cLPrecosItem, loc_cSQLPro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cLPrecos), 30))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaIten") <= 0
                MsgErro("Falha ao carregar itens da lista de pre" + CHR(231) + "os.", ;
                        "Erro CarregarPorListaPrecos")
            ELSE
                IF par_lCarregarItens
                    SELECT cursor_4c_ListaIten
                    SCAN
                        loc_nVal        = NVL(PVens,   0)
                        loc_nValDe      = NVL(PrecoDe, 0)
                        loc_cCPros      = ALLTRIM(NVL(CPros,   ""))
                        loc_cDPros      = ALLTRIM(NVL(DPros,   ""))
                        loc_cLPrecosItem = ALLTRIM(NVL(LPrecos, ""))

                        IF !BETWEEN(DATETIME(), VencIs, VencFs)
                            loc_cSQLPro = "SELECT PVens, PrecoDe FROM SigCdPro " + ;
                                          "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))

                            IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProTemp") > 0
                                IF !EOF("cursor_4c_ProTemp")
                                    SELECT cursor_4c_ProTemp
                                    loc_nVal   = NVL(PVens,   0)
                                    loc_nValDe = NVL(PrecoDe, 0)
                                ENDIF
                                USE IN cursor_4c_ProTemp
                                SELECT cursor_4c_ListaIten
                            ENDIF
                        ENDIF

                        INSERT INTO dbImpressao ;
                            (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
                            VALUES ;
                            (loc_cCPros, loc_cDPros, 1, 1, ;
                             loc_cLPrecosItem, loc_nVal, ;
                             go_4c_Sistema.cCodEmpresa, loc_nValDe)
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_ListaIten")
                    USE IN cursor_4c_ListaIten
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarPorListaPrecos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorMovimentacao - Popula dbImpressao via SigMvItn
    * par_cEmps:          empresa (3 chars)
    * par_cDopes:         operacao (20 chars)
    * par_nNumes:         numero do documento
    * par_lCarregarItens: se .T. insere itens no cursor dbImpressao
    * Retorna: numero de itens carregados (-1 em erro, 0 se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorMovimentacao(par_cEmps, par_cDopes, par_nNumes, par_lCarregarItens)
        LOCAL loc_nItens, loc_oErro, loc_cEdn, loc_cSQL
        LOCAL loc_nVen, loc_nValDe, loc_nPes, loc_cSQLPro
        LOCAL loc_cCPros, loc_cDPros, loc_nQtds, loc_nCitens

        loc_nItens = -1

        TRY
            loc_cEdn = PADR(ALLTRIM(par_cEmps), 3) + ;
                       PADR(ALLTRIM(par_cDopes), 20) + ;
                       STR(par_nNumes, 6)

            loc_cSQL = "SELECT CPros, DPros, Units, Qtds, Citens " + ;
                       "FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvIten") <= 0
                MsgErro("Falha ao carregar itens da movimenta" + CHR(231) + CHR(227) + "o.", ;
                        "Erro CarregarPorMovimentacao")
                loc_nItens = -1
            ELSE
                loc_nItens = _TALLY

                IF loc_nItens >= 1 AND par_lCarregarItens
                    SELECT cursor_4c_MvIten
                    SCAN
                        loc_nVen     = 0
                        loc_nValDe   = 0
                        loc_nPes     = 0
                        loc_cCPros   = ALLTRIM(NVL(CPros, ""))
                        loc_cDPros   = ALLTRIM(NVL(DPros, ""))
                        loc_nQtds    = NVL(Qtds,   0)
                        loc_nCitens  = NVL(Citens, 0)

                        loc_cSQLPro = "SELECT PVens, PesoMs, PrecoDe FROM SigCdPro " + ;
                                      "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))

                        IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProLocal") > 0
                            IF !EOF("cursor_4c_ProLocal")
                                SELECT cursor_4c_ProLocal
                                IF NVL(PVens,   0) > 0
                                    loc_nVen   = PVens
                                ENDIF
                                IF NVL(PrecoDe, 0) > 0
                                    loc_nValDe = PrecoDe
                                ENDIF
                                IF NVL(PesoMs,  0) > 0
                                    loc_nPes   = PesoMs
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_ProLocal
                            SELECT cursor_4c_MvIten
                        ENDIF

                        INSERT INTO dbImpressao ;
                            (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, ;
                             empdopnums, citens, Pesos, PrecoDe) ;
                            VALUES ;
                            (loc_cCPros, loc_cDPros, ;
                             loc_nQtds, loc_nQtds, ;
                             loc_cEdn, loc_nVen, ;
                             go_4c_Sistema.cCodEmpresa, ;
                             loc_cEdn, loc_nCitens, loc_nPes, loc_nValDe)
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_MvIten")
                    USE IN cursor_4c_MvIten
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarPorMovimentacao")
            loc_nItens = -1
        ENDTRY

        RETURN loc_nItens
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarListaPrecoNoItem - Aplica preco da lista ao registro corrente
    * de dbImpressao (deve ser chamado com cursor dbImpressao posicionado)
    * par_cLPrecos: codigo da lista de precos
    * par_cCpros:   codigo do produto
    * Retorna: .T. se preco foi aplicado
    *--------------------------------------------------------------------------
    PROCEDURE AplicarListaPrecoNoItem(par_cLPrecos, par_cCpros)
        LOCAL loc_lAplicado, loc_oErro, loc_cSQL, loc_nVal, loc_nValDe
        LOCAL loc_cLPrecosAplic, loc_cSQLPro

        loc_lAplicado = .F.

        TRY
            loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLPrecos, 30)) + ;
                       " AND CPros = "   + EscaparSQL(PADR(par_cCpros,   14))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpiItem") > 0
                SELECT cursor_4c_LpiItem
                GO TOP

                IF !EOF()
                    loc_nVal          = NVL(PVens,   0)
                    loc_nValDe        = NVL(PrecoDe, 0)
                    loc_cLPrecosAplic = ALLTRIM(NVL(LPrecos, ""))

                    IF !BETWEEN(DATETIME(), VencIs, VencFs)
                        loc_cSQLPro = "SELECT PVens, PrecoDe FROM SigCdPro " + ;
                                      "WHERE CPros = " + EscaparSQL(PADR(par_cCpros, 14))

                        IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProPreco") > 0
                            IF !EOF("cursor_4c_ProPreco")
                                SELECT cursor_4c_ProPreco
                                loc_nVal   = NVL(PVens,   0)
                                loc_nValDe = NVL(PrecoDe, 0)
                            ENDIF
                            USE IN cursor_4c_ProPreco
                            SELECT cursor_4c_LpiItem
                        ENDIF
                    ENDIF

                    USE IN cursor_4c_LpiItem

                    REPLACE Obs     WITH loc_cLPrecosAplic, ;
                            PVens   WITH loc_nVal, ;
                            PrecoDe WITH loc_nValDe ;
                            IN dbImpressao

                    loc_lAplicado = .T.
                ELSE
                    USE IN cursor_4c_LpiItem
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro AplicarListaPrecoNoItem")
        ENDTRY

        RETURN loc_lAplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigo - Valida / resolve CPros no SigCdPro
    * Suporta EAN13 (numerico) e pesquisa por CBars e CPros direto
    * Preenche props this_cCpros, this_cDpros, this_nPVens, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorCodigo(par_cValor)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL, loc_nCod, loc_cValorResolvido

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cValor)
                loc_cValorResolvido = par_cValor

                *-- Tentativa 1: resolver como EAN13
                loc_nCod = INT(VAL(par_cValor))
                IF loc_nCod > 0
                    loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro " + ;
                               "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrEan") > 0
                        IF !EOF("cursor_4c_PrEan")
                            SELECT cursor_4c_PrEan
                            loc_cValorResolvido = ALLTRIM(CPros)
                        ENDIF
                        USE IN cursor_4c_PrEan
                    ENDIF
                ENDIF

                *-- Tentativa 2: resolver como codigo de barras (CBars)
                IF LEN(ALLTRIM(par_cValor)) <= 14
                    loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro " + ;
                               "WHERE CBars = " + FormatarNumeroSQL(INT(VAL(par_cValor)))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrBars") > 0
                        IF !EOF("cursor_4c_PrBars")
                            SELECT cursor_4c_PrBars
                            loc_cValorResolvido = ALLTRIM(CPros)
                        ENDIF
                        USE IN cursor_4c_PrBars
                    ENDIF
                ENDIF

                *-- Buscar dados completos por CPros resolvido
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE CPros = " + EscaparSQL(PADR(loc_cValorResolvido, 14))

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrDados") > 0
                    IF !EOF("cursor_4c_PrDados")
                        SELECT cursor_4c_PrDados
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrDados
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorCodigo")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorDescricao - Resolve DPros direto (busca exata)
    * Preenche props this_cCpros, this_cDpros, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorDescricao(par_cDpros)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cDpros)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE DPros = " + EscaparSQL(par_cDpros)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrDescr") > 0
                    IF !EOF("cursor_4c_PrDescr")
                        SELECT cursor_4c_PrDescr
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrDescr
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorDescricao")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorReferencia - Resolve Dpro2s direto (busca exata)
    * Preenche props this_cCpros, this_cDpros, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorReferencia(par_cDpro2s)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cDpro2s)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE Dpro2s = " + EscaparSQL(par_cDpro2s)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrRef") > 0
                    IF !EOF("cursor_4c_PrRef")
                        SELECT cursor_4c_PrRef
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrRef
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorReferencia")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEtiquetaIndividual - Verifica se produto usa etiqueta individual
    * Retorna: .T. se produto usa etiqueta individual E nao permite duplicata
    * (o form bloqueia a impressao desse produto nesse caso)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEtiquetaIndividual(par_cCpros)
        LOCAL loc_lEtqIndividual, loc_oErro, loc_cSQL

        loc_lEtqIndividual = .F.

        TRY
            IF !EMPTY(par_cCpros)
                loc_cSQL = "SELECT u.Etiqs, u.EtiqDups " + ;
                           "FROM SigCdPro p " + ;
                           "INNER JOIN SigCdUni u ON p.CUnis = u.CUnis " + ;
                           "WHERE p.CPros = " + EscaparSQL(PADR(par_cCpros, 14))

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniEtq") > 0
                    IF !EOF("cursor_4c_UniEtq")
                        SELECT cursor_4c_UniEtq
                        IF ALLTRIM(NVL(Etiqs, "")) = "S" AND NVL(EtiqDups, 0) <> 1
                            loc_lEtqIndividual = .T.
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_UniEtq
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro VerificarEtiquetaIndividual")
        ENDTRY

        RETURN loc_lEtqIndividual
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNDopesParaBOP - Busca NDopes de SigCdOpe para montar codigo BOP
    * Retorna: string NDopes (4 chars padded) ou "" se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterNDopesParaBOP(par_cDopes)
        LOCAL loc_cNDopes, loc_oErro, loc_cSQL

        loc_cNDopes = ""

        TRY
            IF !EMPTY(par_cDopes)
                loc_cSQL = "SELECT TOP 1 NDopes FROM SigCdOpe " + ;
                           "WHERE Dopes = " + EscaparSQL(par_cDopes)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeNDop") > 0
                    IF !EOF("cursor_4c_OpeNDop")
                        SELECT cursor_4c_OpeNDop
                        IF !EMPTY(NVL(NDopes, 0))
                            loc_cNDopes = PADL(TRANSFORM(NVL(NDopes, 0)), 4, "0")
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_OpeNDop
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ObterNDopesParaBOP")
        ENDTRY

        RETURN loc_cNDopes
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirEtiquetas - Chama SigOpEtq com os parametros de impressao
    * Retorna: .T. se impressao concluida com sucesso (incluindo Commit)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirEtiquetas()
        LOCAL loc_lSucesso, loc_oErro, loc_cBop, loc_cNDopes

        loc_lSucesso = .F.

        TRY
            loc_cBop = ""
            IF !EMPTY(THIS.this_cDopes) AND THIS.this_nNumes > 0
                loc_cNDopes = THIS.ObterNDopesParaBOP(THIS.this_cDopes)
                IF !EMPTY(loc_cNDopes)
                    loc_cBop = loc_cNDopes + PADL(TRANSFORM(THIS.this_nNumes), 6, "0")
                ENDIF
            ENDIF

            =SigOpEtq(gnConnHandle, ;
                      THIS.this_nImpPreco, ;
                      THIS.this_lImpSepar, ;
                      THIS.this_nTpEti, ;
                      THIS.this_nTpImp, ;
                      THIS.this_nAjVertsPrint, ;
                      THIS.this_nAjHorzsPrint, ;
                      THIS.this_nAjDensPrint, ;
                      .NULL., .NULL., .NULL., ;
                      THIS.this_cNomeImp, ;
                      .NULL., .NULL., ;
                      THIS.this_nAjVelosPrint, ;
                      THIS.this_lImpPeso, ;
                      loc_cBop, ;
                      THIS.this_cLp1, ;
                      THIS.this_cLp2, ;
                      .F., .F., ;
                      THIS.this_lCompo)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ImprimirEtiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades BO a partir de um alias de cursor
    * par_cAliasCursor: alias do cursor (normalmente "dbImpressao")
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCpros       = ALLTRIM(NVL(Cpros,       ""))
                THIS.this_cDpros       = ALLTRIM(NVL(DPros,       ""))
                THIS.this_cReffs       = ALLTRIM(NVL(Reffs,       ""))
                THIS.this_nQtds        = NVL(Qtds,      0)
                THIS.this_nQtdeEtiq    = NVL(QtdeEtiq,  0)
                THIS.this_cPedido      = ALLTRIM(NVL(Pedido,      ""))
                THIS.this_cObs         = ALLTRIM(NVL(Obs,         ""))
                THIS.this_nPVens       = NVL(PVens,     0)
                THIS.this_nPrecoDe     = NVL(PrecoDe,   0)
                THIS.this_nParcelas    = NVL(Parcelas,  0)
                THIS.this_cCpros2      = ALLTRIM(NVL(Cpros2,      ""))
                THIS.this_cCpros3      = ALLTRIM(NVL(Cpros3,      ""))
                THIS.this_cCpros4      = ALLTRIM(NVL(Cpros4,      ""))
                THIS.this_cEmpos       = ALLTRIM(NVL(empos,       ""))
                THIS.this_cEmpdopnums  = ALLTRIM(NVL(empdopnums,  ""))
                THIS.this_nCitens      = NVL(citens,    0)
                THIS.this_nPesos       = NVL(Pesos,     0)
                THIS.this_cCodTams     = ALLTRIM(NVL(CodTams,     ""))
                THIS.this_cDpro2s      = ALLTRIM(NVL(DPro2s,      ""))

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Adiciona nova linha ao cursor local dbImpressao
    * Retorna: .T. se inserido com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("dbImpressao")
                INSERT INTO dbImpressao ;
                    (Cpros, DPros, Reffs, Qtds, QtdeEtiq, ;
                     Pedido, Obs, PVens, PrecoDe, Parcelas, ;
                     Cpros2, Cpros3, Cpros4, empos, empdopnums, ;
                     citens, Pesos, CodTams, DPro2s) ;
                    VALUES ;
                    (THIS.this_cCpros, THIS.this_cDpros, THIS.this_cReffs, ;
                     THIS.this_nQtds, THIS.this_nQtdeEtiq, ;
                     THIS.this_cPedido, THIS.this_cObs, THIS.this_nPVens, ;
                     THIS.this_nPrecoDe, THIS.this_nParcelas, ;
                     THIS.this_cCpros2, THIS.this_cCpros3, THIS.this_cCpros4, ;
                     THIS.this_cEmpos, THIS.this_cEmpdopnums, ;
                     THIS.this_nCitens, THIS.this_nPesos, ;
                     THIS.this_cCodTams, THIS.this_cDpro2s)

                THIS.RegistrarAuditoria("I")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza linha corrente do cursor local dbImpressao
    * Retorna: .T. se atualizado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("dbImpressao") AND !EOF("dbImpressao")
                SELECT dbImpressao

                REPLACE Cpros       WITH THIS.this_cCpros, ;
                        DPros       WITH THIS.this_cDpros, ;
                        Reffs       WITH THIS.this_cReffs, ;
                        Qtds        WITH THIS.this_nQtds, ;
                        QtdeEtiq    WITH THIS.this_nQtdeEtiq, ;
                        Pedido      WITH THIS.this_cPedido, ;
                        Obs         WITH THIS.this_cObs, ;
                        PVens       WITH THIS.this_nPVens, ;
                        PrecoDe     WITH THIS.this_nPrecoDe, ;
                        Parcelas    WITH THIS.this_nParcelas, ;
                        Cpros2      WITH THIS.this_cCpros2, ;
                        Cpros3      WITH THIS.this_cCpros3, ;
                        Cpros4      WITH THIS.this_cCpros4, ;
                        empos       WITH THIS.this_cEmpos, ;
                        empdopnums  WITH THIS.this_cEmpdopnums, ;
                        citens      WITH THIS.this_nCitens, ;
                        Pesos       WITH THIS.this_nPesos, ;
                        CodTams     WITH THIS.this_cCodTams, ;
                        DPro2s      WITH THIS.this_cDpro2s

                THIS.RegistrarAuditoria("A")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o codigo do produto corrente em dbImpressao
    * Form OPERACIONAL: usa CPros como identificador do item corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ""

        IF USED("dbImpressao") AND !EOF("dbImpressao")
            SELECT dbImpressao
            loc_cChave = ALLTRIM(NVL(Cpros, ""))
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Form OPERACIONAL sem tabela principal
    * Sem persistencia em LogAuditoria (cursor local nao eh auditavel)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE

