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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2700 linhas total):

*-- Linhas 34 a 172:
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
89:             APPEND BLANK
90: 
91:             THIS.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
92: 
93:             *-- Estrutura visual: cabecalho cinza + todos os controles do form plano
94:             THIS.ConfigurarPageFrame()
95:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
96:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
97:             THIS.ConfigurarPaginaLista()
98:             THIS.ConfigurarPaginaDados()
99:             THIS.CarregarTiposEtiqueta()
100:             THIS.CarregarImpressoras()
101: 
102:             *-- BINDEVENT grid: AfterRowColChange para lookup de colunas
103:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
104: 
105:             *-- BINDEVENT Opt_Preco: ao mudar opcao de preco, toggle Parcelas
106:             BINDEVENT(THIS.obj_4c_Opt_Preco, "InteractiveChange", THIS, "OptPrecoInteractiveChange")
107: 
108:             *-- Torna controles visiveis (compensar AddObject Visible=.F. default)
109:             THIS.TornarControlesVisiveis(THIS)
110: 
111:             loc_lSucesso = .T.
112: 
113:         CATCH TO loc_oErro
114:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
115:                     " PROC=" + loc_oErro.Procedure, ;
116:                     "Erro FormSigPrEtq.InicializarForm")
117:         ENDTRY
118: 
119:         RETURN loc_lSucesso
120:     ENDPROC
121: 
122:     *--------------------------------------------------------------------------
123:     * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
124:     * cntSombra (cabecalho cinza) com labels de titulo.
125:     * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
126:     * estrutura fixa do topo (equivalente ao "frame" da tela), mantendo o
127:     * contrato do pipeline multi-fase (validacao busca "ConfigurarPageFrame").
128:     * Original: cntSombra Top=0, Left=0, Width=840, Height=80, BackColor=100,100,100
129:     * lblSombra: ForeColor=RGB(0,0,0) (sombra preta)
130:     * lblTitulo: ForeColor=RGB(255,255,255) (texto branco)
131:     *--------------------------------------------------------------------------
132:     PROTECTED PROCEDURE ConfigurarPageFrame()
133:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH THIS.cnt_4c_Cabecalho
135:             .Top       = 0
136:             .Left      = 0
137:             .Width     = THIS.Width
138:             .Height    = 80
139:             .BackStyle = 1
140:             .BackColor = RGB(100,100,100)
141:             .BorderWidth = 0
142:             .Visible   = .T.
143: 
144:             .AddObject("lbl_4c_Sombra", "Label")
145:             WITH .lbl_4c_Sombra
146:                 .AutoSize  = .F.
147:                 .FontBold  = .T.
148:                 .FontName  = "Tahoma"
149:                 .FontSize  = 18
150:                 .WordWrap  = .T.
151:                 .Alignment = 0
152:                 .BackStyle = 0
153:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
154:                 .Height    = 40
155:                 .Left      = 10
156:                 .Top       = 18
157:                 .Width     = .Parent.Width
158:                 .ForeColor = RGB(0,0,0)
159:             ENDWITH
160: 
161:             .AddObject("lbl_4c_Titulo", "Label")
162:             WITH .lbl_4c_Titulo
163:                 .AutoSize  = .F.
164:                 .FontBold  = .T.
165:                 .FontName  = "Tahoma"
166:                 .FontSize  = 18
167:                 .WordWrap  = .T.
168:                 .Alignment = 0
169:                 .BackStyle = 0
170:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
171:                 .Height    = 46
172:                 .Left      = 10

*-- Linhas 178 a 282:
178:     ENDPROC
179: 
180:     *--------------------------------------------------------------------------
181:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
182:     * Percorre Controls E Pages (PageFrame) para garantir visibilidade
183:     * EXCECAO: obj_4c_Opt_Impressora permanece oculto (sobreposicao com Opt_Tipo)
184:     *--------------------------------------------------------------------------
185:     PROCEDURE TornarControlesVisiveis(par_oContainer)
186:         LOCAL loc_nI, loc_oControl
187: 
188:         FOR loc_nI = 1 TO par_oContainer.ControlCount
189:             loc_oControl = par_oContainer.Controls(loc_nI)
190: 
191:             IF VARTYPE(loc_oControl) = "O"
192:                 *-- Containers com visibilidade gerenciada manualmente:
193:                 *-- recursao nos filhos antes do LOOP para nao deixa-los hidden permanente
194:                 IF INLIST(UPPER(loc_oControl.Name), "OBJ_4C_OPT_IMPRESSORA", "CNT_4C_CABECALHO")
195:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
196:                         THIS.TornarControlesVisiveis(loc_oControl)
197:                     ENDIF
198:                     LOOP
199:                 ENDIF
200: 
201:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
202:                     loc_oControl.Visible = .T.
203:                 ENDIF
204: 
205:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
206:                     LOCAL loc_nP
207:                     FOR loc_nP = 1 TO loc_oControl.PageCount
208:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
209:                     ENDFOR
210:                 ENDIF
211: 
212:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
213:                     THIS.TornarControlesVisiveis(loc_oControl)
214:                 ENDIF
215:             ENDIF
216:         ENDFOR
217:     ENDPROC
218: 
219:     *--------------------------------------------------------------------------
220:     * Destroy - Libera BO e fecha cursor local dbImpressao
221:     *--------------------------------------------------------------------------
222:     PROCEDURE Destroy()
223:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
224:             THIS.this_oBusinessObject = .NULL.
225:         ENDIF
226: 
227:         IF USED("dbImpressao")
228:             USE IN dbImpressao
229:         ENDIF
230: 
231:         IF USED("cursor_4c_ImpreV")
232:             USE IN cursor_4c_ImpreV
233:         ENDIF
234: 
235:         DODEFAULT()
236:     ENDPROC
237: 
238:     *--------------------------------------------------------------------------
239:     * ConfigurarPaginaLista - Cria controles principais do form OPERACIONAL:
240:     * label titulo, grid grd_4c_Dados (7 colunas), botoes de acao e BTNREPORT
241:     *--------------------------------------------------------------------------
242:     PROTECTED PROCEDURE ConfigurarPaginaLista()
243:         LOCAL loc_oErro
244: 
245:         TRY
246:             *-- Label titulo da grade
247:             THIS.AddObject("lbl_4c_Lbl_titulo", "Label")
248:             WITH THIS.lbl_4c_Lbl_titulo
249:                 .AutoSize  = .T.
250:                 .FontBold  = .T.
251:                 .FontName  = "Tahoma"
252:                 .FontSize  = 8
253:                 .BackStyle = 0
254:                 .Caption   = " \<Etiquetas Selecionadas "
255:                 .Height    = 15
256:                 .Left      = 10
257:                 .Top       = 203
258:                 .Width     = 138
259:                 .ForeColor = RGB(90,90,90)
260:             ENDWITH
261: 
262:             *-- Grid principal
263:             THIS.AddObject("grd_4c_Dados", "Grid")
264:             WITH THIS.grd_4c_Dados
265:                 .Top          = 216
266:                 .Left         = 12
267:                 .Width        = 818
268:                 .Height       = 157
269:                 .RecordMark   = .F.
270:                 .DeleteMark   = .F.
271:                 .FontName     = "Tahoma"
272:                 .FontSize     = 8
273:                 .HeaderHeight = 17
274:                 .RowHeight    = 17
275:                 .ScrollBars   = 2
276:                 .ColumnCount  = 7
277:                 .RecordSource = "dbImpressao"
278: 
279:                 *-- Column1: Produto (cpros)
280:                 WITH .Column1
281:                     .ControlSource = "dbImpressao.cpros"
282:                     .Width         = 110

*-- Linhas 494 a 553:
494:                 .FontName        = "Tahoma"
495:                 .FontSize        = 8
496:             ENDWITH
497:             BINDEVENT(THIS.cmd_4c_Btnexcluir, "Click", THIS, "BtnExcluirClick")
498: 
499:             *-- Botao Carregar itens da movimentacao
500:             THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
501:             WITH THIS.cmd_4c_BtnCarregar
502:                 .Top             = 159
503:                 .Left            = 373
504:                 .Height          = 26
505:                 .Width           = 26
506:                 .Caption         = ""
507:                 .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
508:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
509:                 .Themes          = .T.
510:                 .FontName        = "Tahoma"
511:                 .FontSize        = 8
512:             ENDWITH
513:             BINDEVENT(THIS.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")
514: 
515:             *-- CommandGroup BTNREPORT: Imprimir + Encerrar
516:             THIS.AddObject("obj_4c_BTNREPORT", "CommandGroup")
517:             WITH THIS.obj_4c_BTNREPORT
518:                 .ButtonCount = 2
519:                 .BackStyle   = 0
520:                 .BorderStyle = 0
521:                 .Height      = 85
522:                 .Left        = 676
523:                 .Top         = -2
524:                 .Width       = 161
525:                 .AutoSize    = .T.
526: 
527:                 WITH .Buttons(1)
528:                     .Top        = 5
529:                     .Left       = 5
530:                     .Height     = 75
531:                     .Width      = 75
532:                     .FontBold   = .T.
533:                     .FontItalic = .T.
534:                     .WordWrap   = .T.
535:                     .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
536:                     .Caption    = "\<Imprimir"
537:                     .ForeColor  = RGB(90,90,90)
538:                     .BackColor  = RGB(255,255,255)
539:                     .Themes     = .F.
540:                     .Name       = "Imprime"
541:                 ENDWITH
542: 
543:                 WITH .Buttons(2)
544:                     .Top        = 5
545:                     .Left       = 81
546:                     .Height     = 75
547:                     .Width      = 75
548:                     .FontBold   = .T.
549:                     .FontItalic = .T.
550:                     .FontName   = "Tahoma"
551:                     .FontSize   = 8
552:                     .WordWrap   = .T.
553:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 559 a 623:
559:                     .Name       = "Sair"
560:                 ENDWITH
561:             ENDWITH
562:             BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(1), "Click", THIS, "BtnImprimeClick")
563:             BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(2), "Click", THIS, "BtnSairClick")
564: 
565:         CATCH TO loc_oErro
566:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
567:                     " PROC=" + loc_oErro.Procedure, ;
568:                     "Erro FormSigPrEtq.ConfigurarPaginaLista")
569:         ENDTRY
570:     ENDPROC
571: 
572:     *--------------------------------------------------------------------------
573:     * AlternarPagina - Form OPERACIONAL sem PageFrame; sempre retorna .T.
574:     *--------------------------------------------------------------------------
575:     PROCEDURE AlternarPagina(par_nPagina)
576:         RETURN .T.
577:     ENDPROC
578: 
579:     *--------------------------------------------------------------------------
580:     * BtnImprimeClick - Imprime etiquetas selecionadas via BO.ImprimirEtiquetas
581:     * Reordena dbImpressao conforme OptOrdem antes de chamar SigOpEtq
582:     *--------------------------------------------------------------------------
583:     PROCEDURE BtnImprimeClick()
584:         LOCAL loc_lSucesso, loc_oErro, loc_lContinuar
585: 
586:         loc_lSucesso   = .F.
587:         loc_lContinuar = .T.
588: 
589:         TRY
590:             IF !MsgConfirma("Confirma a Impress" + CHR(227) + "o de Etiquetas ?")
591:                 loc_lContinuar = .F.
592:             ENDIF
593: 
594:             IF loc_lContinuar
595:                 *-- Reordenar dbImpressao: remove Qtds<=0 e ordena conforme opcao
596:                 SELECT * FROM dbImpressao WHERE 0=1 INTO CURSOR cursor_4c_Ordenado READWRITE
597: 
598:                 SELECT dbImpressao
599:                 DELETE FROM dbImpressao WHERE Qtds <= 0
600: 
601:                 IF THIS.obj_4c_OptOrdem.Value = 1
602:                     SET ORDER TO Cpros
603:                 ELSE
604:                     SET ORDER TO Registros
605:                 ENDIF
606: 
607:                 SELECT dbImpressao
608:                 SCAN
609:                     SCATTER MEMVAR MEMO
610:                     INSERT INTO cursor_4c_Ordenado FROM MEMVAR
611:                 ENDSCAN
612: 
613:                 ZAP IN dbImpressao
614:                 SET ORDER TO
615: 
616:                 SELECT cursor_4c_Ordenado
617:                 SCAN
618:                     SCATTER MEMVAR MEMO
619:                     INSERT INTO dbImpressao FROM MEMVAR
620:                 ENDSCAN
621: 
622:                 IF USED("cursor_4c_Ordenado")
623:                     USE IN cursor_4c_Ordenado

*-- Linhas 644 a 882:
644: 
645:         CATCH TO loc_oErro
646:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
647:                     " PROC=" + loc_oErro.Procedure, ;
648:                     "Erro FormSigPrEtq.BtnImprimeClick")
649:         ENDTRY
650: 
651:         RETURN loc_lSucesso
652:     ENDPROC
653: 
654:     *--------------------------------------------------------------------------
655:     * BtnSairClick - Encerra o formulario
656:     *--------------------------------------------------------------------------
657:     PROCEDURE BtnSairClick()
658:         THIS.Release()
659:     ENDPROC
660: 
661:     *--------------------------------------------------------------------------
662:     * BtnExcluirClick - Exclui o item corrente da grade dbImpressao
663:     *--------------------------------------------------------------------------
664:     PROCEDURE BtnExcluirClick()
665:         LOCAL loc_oErro
666: 
667:         TRY
668:             SELECT dbImpressao
669:             DELETE
670:             LOCATE FOR .F.
671: 
672:             SELECT dbImpressao
673:             GO TOP IN dbImpressao
674:             IF EOF("dbImpressao")
675:                 APPEND BLANK IN dbImpressao
676:             ENDIF
677:             GO TOP IN dbImpressao
678: 
679:             THIS.grd_4c_Dados.Refresh()
680: 
681:         CATCH TO loc_oErro
682:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
683:                     " PROC=" + loc_oErro.Procedure, ;
684:                     "Erro FormSigPrEtq.BtnExcluirClick")
685:         ENDTRY
686:     ENDPROC
687: 
688:     *--------------------------------------------------------------------------
689:     * BtnCarregarClick - Carrega itens da movimentacao na grade dbImpressao
690:     *--------------------------------------------------------------------------
691:     PROCEDURE BtnCarregarClick()
692:         LOCAL loc_lSucesso, loc_oErro, loc_nItens, loc_lContinuar
693: 
694:         loc_lSucesso   = .F.
695:         loc_lContinuar = .T.
696: 
697:         TRY
698:             *-- Validar campos obrigatorios (controles criados na Fase 5)
699:             IF EMPTY(THIS.txt_4c_Emps.Value)
700:                 MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!")
701:                 THIS.txt_4c_Emps.SetFocus
702:                 loc_lContinuar = .F.
703:             ENDIF
704: 
705:             IF loc_lContinuar AND EMPTY(THIS.txt_4c_Dopes.Value)
706:                 MsgAviso("A Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Foi Informada!!!")
707:                 THIS.txt_4c_Dopes.SetFocus
708:                 loc_lContinuar = .F.
709:             ENDIF
710: 
711:             IF loc_lContinuar AND EMPTY(THIS.txt_4c_Numes.Value)
712:                 MsgAviso("O C" + CHR(243) + "digo N" + CHR(227) + "o Foi Informado!!!")
713:                 THIS.txt_4c_Numes.SetFocus
714:                 loc_lContinuar = .F.
715:             ENDIF
716: 
717:             IF loc_lContinuar
718:                 *-- Verificar se ja existem etiquetas na grade e confirmar substituicao
719:                 SELECT Cpros FROM dbImpressao WHERE !EMPTY(Cpros) INTO CURSOR cursor_4c_TmpDig
720:                 IF _TALLY > 0
721:                     loc_lContinuar = MsgConfirma("Existem Etiquetas na Grade! " + ;
722:                         "Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?")
723:                 ENDIF
724:                 IF USED("cursor_4c_TmpDig")
725:                     USE IN cursor_4c_TmpDig
726:                 ENDIF
727:             ENDIF
728: 
729:             IF loc_lContinuar
730:                 ZAP IN dbImpressao
731: 
732:                 loc_nItens = THIS.this_oBusinessObject.CarregarPorMovimentacao( ;
733:                     THIS.txt_4c_Emps.Value, ;
734:                     THIS.txt_4c_Dopes.Value, ;
735:                     THIS.txt_4c_Numes.Value, ;
736:                     (THIS.chk_4c_ChkOperacoes.Value = 1))
737: 
738:                 IF loc_nItens <= 0
739:                     MsgAviso("A Opera" + CHR(231) + CHR(227) + "o Informada N" + CHR(227) + ;
740:                              "o Possui It" + CHR(234) + "ns a Serem Carregados!!!")
741:                     THIS.txt_4c_Emps.SetFocus
742:                 ELSE
743:                     *-- Aplicar lista de precos por item se preenchida e nao em modo chkLista
744:                     IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value)
745:                         SELECT dbImpressao
746:                         SCAN
747:                             IF !EMPTY(dbImpressao.Cpros)
748:                                 THIS.this_oBusinessObject.AplicarListaPrecoNoItem( ;
749:                                     THIS.txt_4c_Lpreco.Value, ;
750:                                     ALLTRIM(dbImpressao.Cpros))
751:                             ENDIF
752:                         ENDSCAN
753:                     ENDIF
754:                 ENDIF
755: 
756:                 SELECT dbImpressao
757:                 IF RECCOUNT("dbImpressao") = 0
758:                     APPEND BLANK IN dbImpressao
759:                 ENDIF
760:                 GO TOP IN dbImpressao
761: 
762:                 THIS.grd_4c_Dados.Refresh()
763:             ENDIF
764: 
765:             loc_lSucesso = .T.
766: 
767:         CATCH TO loc_oErro
768:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
769:                     " PROC=" + loc_oErro.Procedure, ;
770:                     "Erro FormSigPrEtq.BtnCarregarClick")
771:         ENDTRY
772: 
773:         RETURN loc_lSucesso
774:     ENDPROC
775: 
776:     *--------------------------------------------------------------------------
777:     * ConfigurarPaginaDados - Cria controles de filtros/parametros (Parte 1):
778:     * Secao Lista de Precos, Movimentacoes e Tipo de Etiqueta
779:     *--------------------------------------------------------------------------
780:     PROTECTED PROCEDURE ConfigurarPaginaDados()
781:         LOCAL loc_oErro
782: 
783:         TRY
784:             *-- Secao Lista de Precos (Top 86-130)
785:             THIS.AddObject("lbl_4c_Label2", "Label")
786:             WITH THIS.lbl_4c_Label2
787:                 .AutoSize  = .T.
788:                 .FontBold  = .T.
789:                 .FontName  = "Tahoma"
790:                 .FontSize  = 8
791:                 .BackStyle = 0
792:                 .Caption   = " \<Lista de Pre" + CHR(231) + "os "
793:                 .Height    = 15
794:                 .Left      = 20
795:                 .Top       = 86
796:                 .Width     = 93
797:                 .ForeColor = RGB(90,90,90)
798:             ENDWITH
799: 
800:             THIS.AddObject("chk_4c_ChkLista", "CheckBox")
801:             WITH THIS.chk_4c_ChkLista
802:                 .AutoSize  = .T.
803:                 .Alignment = 0
804:                 .BackStyle = 0
805:                 .Caption   = "Carrega " + CHR(205) + "tens"
806:                 .Height    = 15
807:                 .Left      = 24
808:                 .Top       = 102
809:                 .Width     = 85
810:                 .Value     = 1
811:                 .FontName  = "Tahoma"
812:                 .FontSize  = 8
813:                 .ForeColor = RGB(90,90,90)
814:             ENDWITH
815: 
816:             THIS.AddObject("txt_4c_Lpreco", "TextBox")
817:             WITH THIS.txt_4c_Lpreco
818:                 .Format    = "K!"
819:                 .Height    = 22
820:                 .Left      = 132
821:                 .Top       = 105
822:                 .Width     = 294
823:                 .Value     = ""
824:                 .MaxLength = 30
825:                 .FontName  = "Tahoma"
826:                 .FontSize  = 8
827:             ENDWITH
828:             BINDEVENT(THIS.txt_4c_Lpreco, "KeyPress", THIS, "TxtLprecoKeyPress")
829: 
830:             THIS.AddObject("txt_4c_LPreco2", "TextBox")
831:             WITH THIS.txt_4c_LPreco2
832:                 .Format    = "K!"
833:                 .Height    = 22
834:                 .Left      = 132
835:                 .Top       = 128
836:                 .Width     = 294
837:                 .Value     = ""
838:                 .MaxLength = 30
839:                 .FontName  = "Tahoma"
840:                 .FontSize  = 8
841:             ENDWITH
842:             BINDEVENT(THIS.txt_4c_LPreco2, "KeyPress", THIS, "TxtLPreco2KeyPress")
843: 
844:             *-- Secao Movimentacoes (Top 154-195)
845:             THIS.AddObject("lbl_4c_Label4", "Label")
846:             WITH THIS.lbl_4c_Label4
847:                 .AutoSize  = .T.
848:                 .FontBold  = .T.
849:                 .FontName  = "Tahoma"
850:                 .FontSize  = 8
851:                 .BackStyle = 0
852:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
853:                 .Height    = 15
854:                 .Left      = 20
855:                 .Top       = 154
856:                 .Width     = 92
857:                 .ForeColor = RGB(90,90,90)
858:             ENDWITH
859: 
860:             THIS.AddObject("chk_4c_ChkOperacoes", "CheckBox")
861:             WITH THIS.chk_4c_ChkOperacoes
862:                 .AutoSize  = .T.
863:                 .Alignment = 0
864:                 .BackStyle = 0
865:                 .Caption   = "Carrega " + CHR(205) + "tens"
866:                 .Height    = 15
867:                 .Left      = 24
868:                 .Top       = 169
869:                 .Width     = 85
870:                 .Value     = 1
871:                 .FontName  = "Tahoma"
872:                 .FontSize  = 8
873:                 .ForeColor = RGB(90,90,90)
874:             ENDWITH
875: 
876:             THIS.AddObject("lbl_4c_Label5", "Label")
877:             WITH THIS.lbl_4c_Label5
878:                 .AutoSize  = .T.
879:                 .FontBold  = .T.
880:                 .FontName  = "Tahoma"
881:                 .FontSize  = 8
882:                 .BackStyle = 0

*-- Linhas 930 a 1067:
930:                 .FontName  = "Tahoma"
931:                 .FontSize  = 8
932:             ENDWITH
933:             BINDEVENT(THIS.txt_4c_Emps, "KeyPress", THIS, "TxtEmpsKeyPress")
934: 
935:             THIS.AddObject("txt_4c_Dopes", "TextBox")
936:             WITH THIS.txt_4c_Dopes
937:                 .Format    = "K!"
938:                 .Height    = 23
939:                 .Left      = 165
940:                 .Top       = 174
941:                 .Width     = 150
942:                 .Value     = ""
943:                 .MaxLength = 20
944:                 .FontName  = "Tahoma"
945:                 .FontSize  = 8
946:             ENDWITH
947:             BINDEVENT(THIS.txt_4c_Dopes, "KeyPress", THIS, "TxtDopesKeyPress")
948: 
949:             THIS.AddObject("txt_4c_Numes", "TextBox")
950:             WITH THIS.txt_4c_Numes
951:                 .Alignment = 3
952:                 .Value     = 0
953:                 .Format    = "K"
954:                 .Height    = 23
955:                 .InputMask = "999999"
956:                 .Left      = 317
957:                 .MaxLength = 6
958:                 .Top       = 174
959:                 .Width     = 52
960:                 .FontName  = "Tahoma"
961:                 .FontSize  = 8
962:             ENDWITH
963: 
964:             *-- Secao Tipo de Etiqueta (Top 415-615)
965:             THIS.AddObject("shp_4c_Shape3", "Shape")
966:             WITH THIS.shp_4c_Shape3
967:                 .Top           = 431
968:                 .Left          = 260
969:                 .Width         = 254
970:                 .Height        = 106
971:                 .BackStyle     = 0
972:                 .BorderWidth   = 1
973:                 .SpecialEffect = 1
974:             ENDWITH
975: 
976:             THIS.AddObject("lbl_4c_Label1", "Label")
977:             WITH THIS.lbl_4c_Label1
978:                 .AutoSize  = .T.
979:                 .FontBold  = .T.
980:                 .FontName  = "Tahoma"
981:                 .FontSize  = 8
982:                 .BackStyle = 0
983:                 .Caption   = " Tipo de Etiqueta "
984:                 .Height    = 15
985:                 .Left      = 23
986:                 .Top       = 415
987:                 .Width     = 99
988:                 .ForeColor = RGB(90,90,90)
989:             ENDWITH
990: 
991:             *-- Opt_Tipo: ButtonCount=1 provisorio; CarregarTiposEtiqueta() re-popula
992:             THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
993:             WITH THIS.obj_4c_Opt_Tipo
994:                 .ButtonCount   = 1
995:                 .BackStyle     = 0
996:                 .Value         = 1
997:                 .Height        = 182
998:                 .Left          = 13
999:                 .SpecialEffect = 1
1000:                 .Top           = 431
1001:                 .Width         = 240
1002:                 .Themes        = .F.
1003:                 WITH .Buttons(1)
1004:                     .AutoSize  = .F.
1005:                     .Width     = 197
1006:                     .Caption   = " \<a. Rabicho"
1007:                     .ForeColor = RGB(90,90,90)
1008:                     .Top       = 10
1009:                     .BackStyle = 0
1010:                     .Height    = 16
1011:                     .Left      = 9
1012:                     .Themes    = .F.
1013:                 ENDWITH
1014:             ENDWITH
1015: 
1016:             *-- Container Impressora (Cnt_Impressora: Top=539, Left=260, 254x74)
1017:             THIS.AddObject("cnt_4c__Impressora", "Container")
1018:             WITH THIS.cnt_4c__Impressora
1019:                 .Top         = 539
1020:                 .Left        = 260
1021:                 .Width       = 254
1022:                 .Height      = 74
1023:                 .BackStyle   = 0
1024:                 .BorderWidth = 0
1025: 
1026:                 *-- Opcao impressora: Allegro / Zebra ZPL / Zebra EPL
1027:                 .AddObject("obj_4c_Opcao_imp", "OptionGroup")
1028:                 WITH .obj_4c_Opcao_imp
1029:                     .AutoSize    = .F.
1030:                     .ButtonCount = 3
1031:                     .Height      = 24
1032:                     .Left        = 5
1033:                     .Top         = 3
1034:                     .Width       = 241
1035:                     WITH .Buttons(1)
1036:                         .AutoSize  = .T.
1037:                         .BackStyle = 0
1038:                         .Caption   = "Allegro"
1039:                         .ForeColor = RGB(90,90,90)
1040:                         .Left      = 2
1041:                         .Top       = 4
1042:                         .Width     = 51
1043:                     ENDWITH
1044:                     WITH .Buttons(2)
1045:                         .AutoSize  = .T.
1046:                         .BackStyle = 0
1047:                         .Caption   = "Zebra ZPL"
1048:                         .FontName  = "Tahoma"
1049:                         .FontSize  = 8
1050:                         .ForeColor = RGB(90,90,90)
1051:                         .Left      = 75
1052:                         .Top       = 4
1053:                         .Width     = 66
1054:                         .Themes    = .F.
1055:                     ENDWITH
1056:                     WITH .Buttons(3)
1057:                         .AutoSize  = .T.
1058:                         .BackStyle = 0
1059:                         .Caption   = "Zebra EPL"
1060:                         .FontName  = "Tahoma"
1061:                         .FontSize  = 8
1062:                         .ForeColor = RGB(90,90,90)
1063:                         .Height    = 15
1064:                         .Left      = 164
1065:                         .Top       = 4
1066:                         .Width     = 66
1067:                         .Themes    = .F.

*-- Linhas 1200 a 1243:
1200:             ENDWITH
1201: 
1202:             *-- Opt_Impressora (Visible=.F. - vestigial, sobrepoe Opt_Tipo)
1203:             THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1204:             WITH THIS.obj_4c_Opt_Impressora
1205:                 .AutoSize      = .F.
1206:                 .ButtonCount   = 1
1207:                 .BackStyle     = 0
1208:                 .Value         = 1
1209:                 .Height        = 47
1210:                 .Left          = 260
1211:                 .SpecialEffect = 1
1212:                 .Top           = 431
1213:                 .Width         = 254
1214:                 .Themes        = .F.
1215:                 .Visible       = .F.
1216:                 WITH .Buttons(1)
1217:                     .AutoSize  = .F.
1218:                     .BackStyle = 0
1219:                     .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1220:                     .ForeColor = RGB(36,84,155)
1221:                     .Height    = 16
1222:                     .Left      = 9
1223:                     .Style     = 0
1224:                     .Top       = 52
1225:                     .Width     = 210
1226:                     .Themes    = .F.
1227:                 ENDWITH
1228:             ENDWITH
1229: 
1230:             *-- Labels "Sistema" e "Windows" (acima do Get_Printer)
1231:             THIS.AddObject("lbl_4c_Label12", "Label")
1232:             WITH THIS.lbl_4c_Label12
1233:                 .AutoSize  = .T.
1234:                 .FontBold  = .T.
1235:                 .FontName  = "Tahoma"
1236:                 .FontSize  = 8
1237:                 .BackStyle = 0
1238:                 .Caption   = "Sistema"
1239:                 .Height    = 15
1240:                 .Left      = 270
1241:                 .Top       = 437
1242:                 .Width     = 48
1243:                 .ForeColor = RGB(90,90,90)

*-- Linhas 1276 a 1391:
1276:                 .ColumnCount   = 1
1277:                 .ColumnWidths  = "239"
1278:             ENDWITH
1279:             BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "CboGetPrinterInteractiveChange")
1280: 
1281:             *-- Separadora (label + OptionGroup)
1282:             THIS.AddObject("lbl_4c_Lbl_Separador", "Label")
1283:             WITH THIS.lbl_4c_Lbl_Separador
1284:                 .AutoSize  = .T.
1285:                 .FontBold  = .F.
1286:                 .FontName  = "Tahoma"
1287:                 .FontSize  = 8
1288:                 .BackStyle = 0
1289:                 .Caption   = "Separadora :"
1290:                 .Height    = 15
1291:                 .Left      = 532
1292:                 .Top       = 417
1293:                 .Width     = 65
1294:                 .ForeColor = RGB(90,90,90)
1295:             ENDWITH
1296: 
1297:             THIS.AddObject("obj_4c_Opt_separador", "OptionGroup")
1298:             WITH THIS.obj_4c_Opt_separador
1299:                 .AutoSize      = .F.
1300:                 .ButtonCount   = 2
1301:                 .BackStyle     = 0
1302:                 .Value         = 1
1303:                 .Height        = 25
1304:                 .Left          = 601
1305:                 .SpecialEffect = 1
1306:                 .Top           = 412
1307:                 .Width         = 198
1308:                 .Themes        = .F.
1309:                 WITH .Buttons(1)
1310:                     .AutoSize  = .T.
1311:                     .BackStyle = 0
1312:                     .Caption   = "Sim"
1313:                     .ForeColor = RGB(90,90,90)
1314:                     .Height    = 15
1315:                     .Left      = 5
1316:                     .Top       = 5
1317:                     .Width     = 34
1318:                     .Themes    = .F.
1319:                 ENDWITH
1320:                 WITH .Buttons(2)
1321:                     .AutoSize  = .T.
1322:                     .BackStyle = 0
1323:                     .Caption   = "N" + CHR(227) + "o"
1324:                     .FontName  = "Tahoma"
1325:                     .FontSize  = 8
1326:                     .ForeColor = RGB(90,90,90)
1327:                     .Height    = 15
1328:                     .Left      = 70
1329:                     .Top       = 5
1330:                     .Width     = 37
1331:                     .Themes    = .F.
1332:                 ENDWITH
1333:             ENDWITH
1334: 
1335:             *-- Preco (label + OptionGroup 6 botoes)
1336:             THIS.AddObject("lbl_4c_Label8", "Label")
1337:             WITH THIS.lbl_4c_Label8
1338:                 .AutoSize  = .T.
1339:                 .FontBold  = .F.
1340:                 .FontName  = "Tahoma"
1341:                 .FontSize  = 8
1342:                 .BackStyle = 0
1343:                 .Caption   = "Pre" + CHR(231) + "o :"
1344:                 .Height    = 15
1345:                 .Left      = 561
1346:                 .Top       = 440
1347:                 .Width     = 36
1348:                 .ForeColor = RGB(90,90,90)
1349:             ENDWITH
1350: 
1351:             THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
1352:             WITH THIS.obj_4c_Opt_Preco
1353:                 .AutoSize      = .F.
1354:                 .ButtonCount   = 6
1355:                 .BackStyle     = 0
1356:                 .Value         = 1
1357:                 .Height        = 95
1358:                 .Left          = 601
1359:                 .SpecialEffect = 1
1360:                 .Top           = 439
1361:                 .Width         = 198
1362:                 .Themes        = .F.
1363:                 WITH .Buttons(1)
1364:                     .AutoSize  = .T.
1365:                     .BackStyle = 0
1366:                     .Caption   = "Sim"
1367:                     .ForeColor = RGB(90,90,90)
1368:                     .Height    = 15
1369:                     .Left      = 8
1370:                     .Top       = 7
1371:                     .Width     = 34
1372:                     .Themes    = .F.
1373:                 ENDWITH
1374:                 WITH .Buttons(2)
1375:                     .AutoSize  = .T.
1376:                     .BackStyle = 0
1377:                     .Caption   = "N" + CHR(227) + "o"
1378:                     .FontName  = "Tahoma"
1379:                     .FontSize  = 8
1380:                     .ForeColor = RGB(90,90,90)
1381:                     .Height    = 15
1382:                     .Left      = 61
1383:                     .Top       = 7
1384:                     .Width     = 37
1385:                     .Themes    = .F.
1386:                 ENDWITH
1387:                 WITH .Buttons(3)
1388:                     .AutoSize  = .T.
1389:                     .BackStyle = 0
1390:                     .Caption   = "Ideal"
1391:                     .FontName  = "Tahoma"

*-- Linhas 1438 a 1653:
1438:                 ENDWITH
1439:             ENDWITH
1440: 
1441:             *-- Peso (label + OptionGroup)
1442:             THIS.AddObject("lbl_4c_Label9", "Label")
1443:             WITH THIS.lbl_4c_Label9
1444:                 .AutoSize  = .T.
1445:                 .FontBold  = .F.
1446:                 .FontName  = "Tahoma"
1447:                 .FontSize  = 8
1448:                 .BackStyle = 0
1449:                 .Caption   = "Peso :"
1450:                 .Height    = 15
1451:                 .Left      = 565
1452:                 .Top       = 540
1453:                 .Width     = 32
1454:                 .ForeColor = RGB(90,90,90)
1455:             ENDWITH
1456: 
1457:             THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
1458:             WITH THIS.obj_4c_Opt_peso
1459:                 .AutoSize      = .F.
1460:                 .ButtonCount   = 2
1461:                 .BackStyle     = 0
1462:                 .Value         = 1
1463:                 .Height        = 25
1464:                 .Left          = 601
1465:                 .SpecialEffect = 1
1466:                 .Top           = 535
1467:                 .Width         = 198
1468:                 .Themes        = .F.
1469:                 WITH .Buttons(1)
1470:                     .AutoSize  = .F.
1471:                     .BackStyle = 0
1472:                     .Caption   = "Sim"
1473:                     .ForeColor = RGB(90,90,90)
1474:                     .Height    = 15
1475:                     .Left      = 5
1476:                     .Top       = 5
1477:                     .Width     = 41
1478:                     .Themes    = .F.
1479:                 ENDWITH
1480:                 WITH .Buttons(2)
1481:                     .AutoSize  = .F.
1482:                     .BackStyle = 0
1483:                     .Caption   = "N" + CHR(227) + "o"
1484:                     .FontName  = "Tahoma"
1485:                     .FontSize  = 8
1486:                     .ForeColor = RGB(90,90,90)
1487:                     .Height    = 15
1488:                     .Left      = 70
1489:                     .Top       = 5
1490:                     .Width     = 41
1491:                     .Themes    = .F.
1492:                 ENDWITH
1493:             ENDWITH
1494: 
1495:             *-- Composicao (label + OptionGroup)
1496:             THIS.AddObject("lbl_4c_Label10", "Label")
1497:             WITH THIS.lbl_4c_Label10
1498:                 .AutoSize  = .T.
1499:                 .FontBold  = .F.
1500:                 .FontName  = "Tahoma"
1501:                 .FontSize  = 8
1502:                 .BackStyle = 0
1503:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
1504:                 .Height    = 15
1505:                 .Left      = 531
1506:                 .Top       = 567
1507:                 .Width     = 66
1508:                 .ForeColor = RGB(90,90,90)
1509:             ENDWITH
1510: 
1511:             THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
1512:             WITH THIS.obj_4c_OptCompos
1513:                 .AutoSize      = .F.
1514:                 .ButtonCount   = 2
1515:                 .BackStyle     = 0
1516:                 .Value         = 1
1517:                 .Height        = 25
1518:                 .Left          = 601
1519:                 .SpecialEffect = 1
1520:                 .Top           = 562
1521:                 .Width         = 198
1522:                 .Themes        = .F.
1523:                 WITH .Buttons(1)
1524:                     .AutoSize  = .F.
1525:                     .BackStyle = 0
1526:                     .Caption   = "Sim"
1527:                     .ForeColor = RGB(90,90,90)
1528:                     .Height    = 15
1529:                     .Left      = 5
1530:                     .Top       = 5
1531:                     .Width     = 41
1532:                     .Themes    = .F.
1533:                 ENDWITH
1534:                 WITH .Buttons(2)
1535:                     .AutoSize  = .F.
1536:                     .BackStyle = 0
1537:                     .Caption   = "N" + CHR(227) + "o"
1538:                     .FontName  = "Tahoma"
1539:                     .FontSize  = 8
1540:                     .ForeColor = RGB(90,90,90)
1541:                     .Height    = 15
1542:                     .Left      = 70
1543:                     .Top       = 5
1544:                     .Width     = 41
1545:                     .Themes    = .F.
1546:                 ENDWITH
1547:             ENDWITH
1548: 
1549:             *-- Ordem (label + OptionGroup)
1550:             THIS.AddObject("lbl_4c_Label11", "Label")
1551:             WITH THIS.lbl_4c_Label11
1552:                 .AutoSize  = .T.
1553:                 .FontBold  = .F.
1554:                 .FontName  = "Tahoma"
1555:                 .FontSize  = 8
1556:                 .BackStyle = 0
1557:                 .Caption   = "Ordem :"
1558:                 .Height    = 15
1559:                 .Left      = 556
1560:                 .Top       = 594
1561:                 .Width     = 41
1562:                 .ForeColor = RGB(90,90,90)
1563:             ENDWITH
1564: 
1565:             THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
1566:             WITH THIS.obj_4c_OptOrdem
1567:                 .AutoSize      = .F.
1568:                 .ButtonCount   = 2
1569:                 .BackStyle     = 0
1570:                 .Value         = 1
1571:                 .Height        = 25
1572:                 .Left          = 601
1573:                 .SpecialEffect = 1
1574:                 .Top           = 589
1575:                 .Width         = 198
1576:                 .Themes        = .F.
1577:                 WITH .Buttons(1)
1578:                     .AutoSize  = .T.
1579:                     .BackStyle = 0
1580:                     .Caption   = "Produto"
1581:                     .ForeColor = RGB(90,90,90)
1582:                     .Height    = 15
1583:                     .Left      = 5
1584:                     .Top       = 4
1585:                     .Width     = 56
1586:                     .Themes    = .F.
1587:                 ENDWITH
1588:                 WITH .Buttons(2)
1589:                     .AutoSize  = .T.
1590:                     .BackStyle = 0
1591:                     .Caption   = "Nenhuma"
1592:                     .FontName  = "Tahoma"
1593:                     .FontSize  = 8
1594:                     .ForeColor = RGB(90,90,90)
1595:                     .Height    = 15
1596:                     .Left      = 70
1597:                     .Top       = 4
1598:                     .Width     = 63
1599:                     .Themes    = .F.
1600:                 ENDWITH
1601:             ENDWITH
1602: 
1603:         CATCH TO loc_oErro
1604:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1605:                     " PROC=" + loc_oErro.Procedure, ;
1606:                     "Erro FormSigPrEtq.ConfigurarPaginaDados")
1607:         ENDTRY
1608:     ENDPROC
1609: 
1610:     *--------------------------------------------------------------------------
1611:     * CarregarTiposEtiqueta - Popula obj_4c_Opt_Tipo dinamicamente via SigCdTpe
1612:     *--------------------------------------------------------------------------
1613:     PROTECTED PROCEDURE CarregarTiposEtiqueta()
1614:         LOCAL loc_oErro, loc_lSucesso, loc_nTipos, loc_nI, loc_nTop, loc_nHeight
1615: 
1616:         loc_lSucesso = .F.
1617:         loc_nI      = 1
1618:         loc_nTop    = 10
1619:         loc_nHeight = 15
1620: 
1621:         TRY
1622:             IF SQLEXEC(gnConnHandle, ;
1623:                 "SELECT nTipos, RTRIM(cEtiquetas) AS cEtiquetas " + ;
1624:                 "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
1625:                 "cursor_4c_TiposEti") > 0
1626: 
1627:                 SELECT cursor_4c_TiposEti
1628:                 loc_nTipos = RECCOUNT("cursor_4c_TiposEti")
1629: 
1630:                 IF loc_nTipos > 0
1631:                     WITH THIS.obj_4c_Opt_Tipo
1632:                         .ButtonCount = loc_nTipos
1633:                         SELECT cursor_4c_TiposEti
1634:                         GO TOP IN cursor_4c_TiposEti
1635:                         DO WHILE !EOF("cursor_4c_TiposEti")
1636:                             WITH .Buttons(loc_nI)
1637:                                 .AutoSize  = .F.
1638:                                 .Width     = 197
1639:                                 .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
1640:                                              ALLTRIM(cursor_4c_TiposEti.cEtiquetas)
1641:                                 .ForeColor = RGB(90,90,90)
1642:                                 .Tag       = ALLTRIM(STR(cursor_4c_TiposEti.nTipos))
1643:                                 .Top       = loc_nTop
1644:                                 .BackStyle = 0
1645:                                 .Height    = 16
1646:                                 .Left      = 9
1647:                                 .Themes    = .F.
1648:                             ENDWITH
1649:                             loc_nI      = loc_nI + 1
1650:                             loc_nTop    = loc_nTop + 20
1651:                             loc_nHeight = loc_nHeight + 20
1652:                             SKIP IN cursor_4c_TiposEti
1653:                         ENDDO

*-- Linhas 1665 a 1802:
1665: 
1666:         CATCH TO loc_oErro
1667:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1668:                     " PROC=" + loc_oErro.Procedure, ;
1669:                     "Erro FormSigPrEtq.CarregarTiposEtiqueta")
1670:         ENDTRY
1671: 
1672:         RETURN loc_lSucesso
1673:     ENDPROC
1674: 
1675:     *--------------------------------------------------------------------------
1676:     * TxtLprecoKeyPress - KeyPress do campo Lista de Precos principal
1677:     *--------------------------------------------------------------------------
1678:     PROCEDURE TxtLprecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1679:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1680:             RETURN
1681:         ENDIF
1682:         THIS.AbrirBuscaLPreco(THIS.txt_4c_Lpreco)
1683:     ENDPROC
1684: 
1685:     *--------------------------------------------------------------------------
1686:     * TxtLPreco2KeyPress - KeyPress do campo Lista de Precos adicional
1687:     *--------------------------------------------------------------------------
1688:     PROCEDURE TxtLPreco2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1689:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1690:             RETURN
1691:         ENDIF
1692:         THIS.AbrirBuscaLPreco(THIS.txt_4c_LPreco2)
1693:     ENDPROC
1694: 
1695:     *--------------------------------------------------------------------------
1696:     * AbrirBuscaLPreco - Lookup SigCdLpc; se txt_4c_Lpreco + chkLista=1 carrega itens
1697:     *--------------------------------------------------------------------------
1698:     PROTECTED PROCEDURE AbrirBuscaLPreco(par_oTxt)
1699:         LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet
1700: 
1701:         loc_lSucesso  = .F.
1702:         loc_lEncontrado = .F.
1703: 
1704:         TRY
1705:             loc_cValor = ALLTRIM(par_oTxt.Value)
1706: 
1707:             *-- Tenta match exato
1708:             IF !EMPTY(loc_cValor)
1709:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1710:                     "SELECT TOP 1 RTRIM(LPrecos) AS LPrecos FROM SigCdLpc " + ;
1711:                     "WHERE RTRIM(LPrecos) = " + EscaparSQL(loc_cValor), ;
1712:                     "cursor_4c_ChkLpc")
1713:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkLpc")
1714:                     par_oTxt.Value = ALLTRIM(cursor_4c_ChkLpc.LPrecos)
1715:                     loc_lEncontrado = .T.
1716:                     IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
1717:                        THIS.chk_4c_ChkLista.Value = 1
1718:                         THIS.CarregarItensListaPreco(par_oTxt.Value)
1719:                     ENDIF
1720:                 ENDIF
1721:                 IF USED("cursor_4c_ChkLpc")
1722:                     USE IN cursor_4c_ChkLpc
1723:                 ENDIF
1724:             ENDIF
1725: 
1726:             *-- Match nao encontrado: abre picker
1727:             IF !loc_lEncontrado
1728:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLpc", ;
1729:                     "cursor_4c_BuscaLpc", "LPrecos", loc_cValor, ;
1730:                     "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
1731:                 IF VARTYPE(loc_oLookup) = "O"
1732:                     loc_oLookup.mAddColuna("LPrecos", "", "Lista de Pre" + CHR(231) + "os")
1733:                     loc_oLookup.Show()
1734:                     IF loc_oLookup.this_lSelecionou
1735:                         par_oTxt.Value = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
1736:                         IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
1737:                            THIS.chk_4c_ChkLista.Value = 1
1738:                             THIS.CarregarItensListaPreco(par_oTxt.Value)
1739:                         ENDIF
1740:                     ENDIF
1741:                     IF USED("cursor_4c_BuscaLpc")
1742:                         USE IN cursor_4c_BuscaLpc
1743:                     ENDIF
1744:                 ENDIF
1745:             ENDIF
1746: 
1747:             loc_lSucesso = .T.
1748: 
1749:         CATCH TO loc_oErro
1750:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1751:                     " PROC=" + loc_oErro.Procedure, ;
1752:                     "Erro FormSigPrEtq.AbrirBuscaLPreco")
1753:         ENDTRY
1754: 
1755:         RETURN loc_lSucesso
1756:     ENDPROC
1757: 
1758:     *--------------------------------------------------------------------------
1759:     * CarregarItensListaPreco - Popula dbImpressao com itens de SigCdLpi
1760:     * Verifica validade do preco; se expirado, busca preco atual em SigCdPro
1761:     *--------------------------------------------------------------------------
1762:     PROTECTED PROCEDURE CarregarItensListaPreco(par_cLPreco)
1763:         LOCAL loc_oErro, loc_lSucesso, loc_cSQL, loc_nPVens, loc_nPrecoDe, loc_nRetPro
1764: 
1765:         loc_lSucesso = .F.
1766: 
1767:         TRY
1768:             ZAP IN dbImpressao
1769: 
1770:             loc_cSQL = "SELECT RTRIM(a.LPrecos) AS LPrecos, RTRIM(a.CPros) AS Cpros, " + ;
1771:                        "RTRIM(a.DPros) AS DPros, a.PVens, a.Precode AS PrecoDe, " + ;
1772:                        "a.VencIs, a.VencFs " + ;
1773:                        "FROM SigCdLpi a " + ;
1774:                        "WHERE RTRIM(a.LPrecos) = " + EscaparSQL(par_cLPreco)
1775: 
1776:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpreI") > 0
1777:                 SELECT cursor_4c_LpreI
1778:                 SCAN
1779:                     loc_nPVens   = cursor_4c_LpreI.PVens
1780:                     loc_nPrecoDe = cursor_4c_LpreI.PrecoDe
1781: 
1782:                     *-- Se preco da lista expirou, usa preco atual do produto
1783:                     IF !BETWEEN(DATETIME(), cursor_4c_LpreI.VencIs, cursor_4c_LpreI.VencFs)
1784:                         loc_nRetPro = SQLEXEC(gnConnHandle, ;
1785:                             "SELECT TOP 1 PVens, PrecoDe FROM SigCdPro " + ;
1786:                             "WHERE RTRIM(CPros) = " + ;
1787:                             EscaparSQL(ALLTRIM(cursor_4c_LpreI.Cpros)), ;
1788:                             "cursor_4c_LproPro")
1789:                         IF loc_nRetPro > 0 AND !EOF("cursor_4c_LproPro")
1790:                             loc_nPVens   = cursor_4c_LproPro.PVens
1791:                             loc_nPrecoDe = cursor_4c_LproPro.PrecoDe
1792:                         ENDIF
1793:                         IF USED("cursor_4c_LproPro")
1794:                             USE IN cursor_4c_LproPro
1795:                         ENDIF
1796:                     ENDIF
1797: 
1798:                     INSERT INTO dbImpressao ;
1799:                         (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
1800:                     VALUES ;
1801:                         (cursor_4c_LpreI.Cpros, cursor_4c_LpreI.DPros, 1, 1, ;
1802:                          PADR(par_cLPreco, 10), loc_nPVens, ;

*-- Linhas 1819 a 2082:
1819: 
1820:         CATCH TO loc_oErro
1821:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1822:                     " PROC=" + loc_oErro.Procedure, ;
1823:                     "Erro FormSigPrEtq.CarregarItensListaPreco")
1824:         ENDTRY
1825: 
1826:         RETURN loc_lSucesso
1827:     ENDPROC
1828: 
1829:     *--------------------------------------------------------------------------
1830:     * TxtEmpsKeyPress - KeyPress do campo Empresa
1831:     *--------------------------------------------------------------------------
1832:     PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1833:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1834:             RETURN
1835:         ENDIF
1836:         THIS.AbrirBuscaEmps()
1837:     ENDPROC
1838: 
1839:     *--------------------------------------------------------------------------
1840:     * AbrirBuscaEmps - Lookup Empresa (SigCdEmp -> Cemps + Razas)
1841:     *--------------------------------------------------------------------------
1842:     PROTECTED PROCEDURE AbrirBuscaEmps()
1843:         LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet
1844: 
1845:         loc_lSucesso  = .F.
1846:         loc_lEncontrado = .F.
1847: 
1848:         TRY
1849:             loc_cValor = ALLTRIM(THIS.txt_4c_Emps.Value)
1850: 
1851:             *-- Tenta match exato
1852:             IF !EMPTY(loc_cValor)
1853:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1854:                     "SELECT TOP 1 RTRIM(Cemps) AS Cemps FROM SigCdEmp " + ;
1855:                     "WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cValor), ;
1856:                     "cursor_4c_ChkEmp")
1857:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkEmp")
1858:                     THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_ChkEmp.Cemps)
1859:                     loc_lEncontrado = .T.
1860:                 ENDIF
1861:                 IF USED("cursor_4c_ChkEmp")
1862:                     USE IN cursor_4c_ChkEmp
1863:                 ENDIF
1864:             ENDIF
1865: 
1866:             *-- Abre picker se nao encontrou match exato
1867:             IF !loc_lEncontrado
1868:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1869:                     "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
1870:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")
1871:                 IF VARTYPE(loc_oLookup) = "O"
1872:                     loc_oLookup.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1873:                     loc_oLookup.mAddColuna("Razas", "", "Empresa")
1874:                     loc_oLookup.Show()
1875:                     IF loc_oLookup.this_lSelecionou
1876:                         THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1877:                     ENDIF
1878:                     IF USED("cursor_4c_BuscaEmp")
1879:                         USE IN cursor_4c_BuscaEmp
1880:                     ENDIF
1881:                 ENDIF
1882:             ENDIF
1883: 
1884:             loc_lSucesso = .T.
1885: 
1886:         CATCH TO loc_oErro
1887:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1888:                     " PROC=" + loc_oErro.Procedure, ;
1889:                     "Erro FormSigPrEtq.AbrirBuscaEmps")
1890:         ENDTRY
1891: 
1892:         RETURN loc_lSucesso
1893:     ENDPROC
1894: 
1895:     *--------------------------------------------------------------------------
1896:     * TxtDopesKeyPress - KeyPress do campo Operacao
1897:     *--------------------------------------------------------------------------
1898:     PROCEDURE TxtDopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1899:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1900:             RETURN
1901:         ENDIF
1902:         THIS.AbrirBuscaDopes()
1903:     ENDPROC
1904: 
1905:     *--------------------------------------------------------------------------
1906:     * AbrirBuscaDopes - Lookup Operacao (SigCdOpe - single-column: Dopes = PK+descricao)
1907:     *--------------------------------------------------------------------------
1908:     PROTECTED PROCEDURE AbrirBuscaDopes()
1909:         LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet
1910: 
1911:         loc_lSucesso  = .F.
1912:         loc_lEncontrado = .F.
1913: 
1914:         TRY
1915:             loc_cValor = ALLTRIM(THIS.txt_4c_Dopes.Value)
1916: 
1917:             *-- Tenta match exato
1918:             IF !EMPTY(loc_cValor)
1919:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1920:                     "SELECT TOP 1 RTRIM(Dopes) AS Dopes FROM SigCdOpe " + ;
1921:                     "WHERE RTRIM(Dopes) = " + EscaparSQL(loc_cValor), ;
1922:                     "cursor_4c_ChkOpe")
1923:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkOpe")
1924:                     THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ChkOpe.Dopes)
1925:                     loc_lEncontrado = .T.
1926:                 ENDIF
1927:                 IF USED("cursor_4c_ChkOpe")
1928:                     USE IN cursor_4c_ChkOpe
1929:                 ENDIF
1930:             ENDIF
1931: 
1932:             *-- Abre picker (SigCdOpe: Dopes eh PK e descricao - coluna unica)
1933:             IF !loc_lEncontrado
1934:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
1935:                     "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
1936:                     "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
1937:                 IF VARTYPE(loc_oLookup) = "O"
1938:                     loc_oLookup.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1939:                     loc_oLookup.Show()
1940:                     IF loc_oLookup.this_lSelecionou
1941:                         THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1942:                     ENDIF
1943:                     IF USED("cursor_4c_BuscaOpe")
1944:                         USE IN cursor_4c_BuscaOpe
1945:                     ENDIF
1946:                 ENDIF
1947:             ENDIF
1948: 
1949:             loc_lSucesso = .T.
1950: 
1951:         CATCH TO loc_oErro
1952:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1953:                     " PROC=" + loc_oErro.Procedure, ;
1954:                     "Erro FormSigPrEtq.AbrirBuscaDopes")
1955:         ENDTRY
1956: 
1957:         RETURN loc_lSucesso
1958:     ENDPROC
1959: 
1960:     *--------------------------------------------------------------------------
1961:     * CarregarImpressoras - Popula cursor_4c_ImpreV com impressoras do sistema
1962:     * e configura cbo_4c_Get_Printer
1963:     *--------------------------------------------------------------------------
1964:     PROTECTED PROCEDURE CarregarImpressoras()
1965:         LOCAL loc_oErro, loc_nTotal, loc_nI, la_4c_Printers
1966: 
1967:         TRY
1968:             IF USED("cursor_4c_ImpreV")
1969:                 USE IN cursor_4c_ImpreV
1970:             ENDIF
1971: 
1972:             SET NULL ON
1973:             CREATE CURSOR cursor_4c_ImpreV (impresS C(100) NULL)
1974:             SET NULL OFF
1975: 
1976:             DIMENSION la_4c_Printers(1, 3)
1977:             loc_nTotal = APRINTERS(la_4c_Printers)
1978: 
1979:             IF loc_nTotal > 0
1980:                 FOR loc_nI = 1 TO loc_nTotal
1981:                     INSERT INTO cursor_4c_ImpreV VALUES (la_4c_Printers[loc_nI, 1])
1982:                 ENDFOR
1983:             ENDIF
1984: 
1985:             IF RECCOUNT("cursor_4c_ImpreV") = 0
1986:                 INSERT INTO cursor_4c_ImpreV VALUES ("Impressora Padr" + CHR(227) + "o")
1987:             ENDIF
1988: 
1989:             GO TOP IN cursor_4c_ImpreV
1990: 
1991:             THIS.cbo_4c_Get_Printer.RowSourceType = 2
1992:             THIS.cbo_4c_Get_Printer.RowSource     = "cursor_4c_ImpreV"
1993:             THIS.cbo_4c_Get_Printer.BoundColumn   = 1
1994:             THIS.cbo_4c_Get_Printer.BoundTo       = .F.
1995:             THIS.cbo_4c_Get_Printer.Refresh()
1996: 
1997:         CATCH TO loc_oErro
1998:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1999:                     " PROC=" + loc_oErro.Procedure, ;
2000:                     "Erro FormSigPrEtq.CarregarImpressoras")
2001:         ENDTRY
2002:     ENDPROC
2003: 
2004:     *--------------------------------------------------------------------------
2005:     * CboGetPrinterInteractiveChange - Ao mudar impressora, resetar ajustes
2006:     *--------------------------------------------------------------------------
2007:     PROCEDURE CboGetPrinterInteractiveChange()
2008:         WITH THIS.cnt_4c__Impressora
2009:             .obj_4c_Spn_AjVerts.Value = 0
2010:             .obj_4c_Spn_AjHorzs.Value = 0
2011:             .obj_4c_Spn_AjDenss.Value = 20
2012:             .obj_4c_Spn_AjVelos.Value = 3
2013:             .Visible     = .T.
2014:         ENDWITH
2015:     ENDPROC
2016: 
2017:     *--------------------------------------------------------------------------
2018:     * GrdDadosAfterRowColChange - Valida coluna anterior ao mudar coluna no grid
2019:     * par_nColIndex = nova coluna; this_nColAnt = coluna anterior
2020:     *--------------------------------------------------------------------------
2021:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2022: 
2023:         DO CASE
2024:         CASE THIS.this_nColAnt = 1
2025:             THIS.ValidarCpros()
2026:         CASE THIS.this_nColAnt = 4
2027:             THIS.ValidarReffs()
2028:         CASE THIS.this_nColAnt = 2
2029:             THIS.ValidarDpros()
2030:         CASE THIS.this_nColAnt = 3
2031:             THIS.ValidarQtds()
2032:         ENDCASE
2033: 
2034:         THIS.this_nColAnt = par_nColIndex
2035:         THIS.AtualizarEstadoColunas()
2036:     ENDPROC
2037: 
2038:     *--------------------------------------------------------------------------
2039:     * ValidarCpros - Valida/lookup do campo Produto (Column1) no grid
2040:     * Tenta EAN13, depois CPros exato, senao abre FormBuscaAuxiliar
2041:     *--------------------------------------------------------------------------
2042:     PROCEDURE ValidarCpros()
2043:         LOCAL loc_oErro, loc_cProd, loc_nCod, loc_nRet, loc_lSucesso, loc_oBusca
2044: 
2045:         loc_lSucesso = .F.
2046: 
2047:         TRY
2048:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2049:                 RETURN
2050:             ENDIF
2051: 
2052:             loc_cProd = ALLTRIM(NVL(dbImpressao.Cpros, ""))
2053: 
2054:             *-- Campo vazio: limpar descricao
2055:             IF EMPTY(loc_cProd)
2056:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
2057:                 THIS.grd_4c_Dados.Refresh()
2058:                 RETURN
2059:             ENDIF
2060: 
2061:             *-- 1. Tentar match por EAN13 (numerico inteiro)
2062:             loc_nCod = INT(VAL(loc_cProd))
2063:             IF loc_nCod > 0
2064:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2065:                     "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2066:                     "PVens, PrecoDe FROM SigCdPro " + ;
2067:                     "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod), ;
2068:                     "cursor_4c_PrEan")
2069:                 IF loc_nRet > 0 AND !EOF("cursor_4c_PrEan")
2070:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrEan.Cpros), 14)
2071:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_PrEan.DPros), 40)
2072:                     dbImpressao.PVens   = cursor_4c_PrEan.PVens
2073:                     dbImpressao.PrecoDe = cursor_4c_PrEan.PrecoDe
2074:                     THIS.grd_4c_Dados.Refresh()
2075:                     IF USED("cursor_4c_PrEan")
2076:                         USE IN cursor_4c_PrEan
2077:                     ENDIF
2078:                     RETURN
2079:                 ENDIF
2080:                 IF USED("cursor_4c_PrEan")
2081:                     USE IN cursor_4c_PrEan
2082:                 ENDIF

*-- Linhas 2103 a 2700:
2103:             ENDIF
2104: 
2105:             *-- 3. Nao encontrado: abrir picker de produto
2106:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2107:                 "cursor_4c_BuscaPro", "CPros", loc_cProd, ;
2108:                 "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
2109:             IF VARTYPE(loc_oBusca) = "O"
2110:                 loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2111:                 loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2112:                 loc_oBusca.Show()
2113:                 IF loc_oBusca.this_lSelecionou
2114:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaPro.CPros), 14)
2115:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaPro.DPros), 40)
2116:                 ENDIF
2117:                 IF USED("cursor_4c_BuscaPro")
2118:                     USE IN cursor_4c_BuscaPro
2119:                 ENDIF
2120:                 loc_oBusca.Release()
2121:             ENDIF
2122: 
2123:             THIS.grd_4c_Dados.Refresh()
2124:             loc_lSucesso = .T.
2125: 
2126:         CATCH TO loc_oErro
2127:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2128:                     " PROC=" + loc_oErro.Procedure, ;
2129:                     "Erro FormSigPrEtq.ValidarCpros")
2130:         ENDTRY
2131: 
2132:         RETURN loc_lSucesso
2133:     ENDPROC
2134: 
2135:     *--------------------------------------------------------------------------
2136:     * ValidarDpros - Valida/lookup do campo Descricao (Column2) no grid
2137:     * Tenta match exato por DPros; senao abre FormBuscaAuxiliar
2138:     *--------------------------------------------------------------------------
2139:     PROCEDURE ValidarDpros()
2140:         LOCAL loc_oErro, loc_cDesc, loc_nRet, loc_lSucesso, loc_oBusca
2141: 
2142:         loc_lSucesso = .F.
2143: 
2144:         TRY
2145:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2146:                 RETURN
2147:             ENDIF
2148: 
2149:             loc_cDesc = ALLTRIM(NVL(dbImpressao.DPros, ""))
2150: 
2151:             *-- Campo vazio: limpar cpros
2152:             IF EMPTY(loc_cDesc)
2153:                 dbImpressao.Cpros = SPACE(14)
2154:                 THIS.grd_4c_Dados.Refresh()
2155:                 RETURN
2156:             ENDIF
2157: 
2158:             *-- Tentar match por DPros
2159:             loc_nRet = SQLEXEC(gnConnHandle, ;
2160:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros " + ;
2161:                 "FROM SigCdPro WHERE RTRIM(DPros) = " + EscaparSQL(loc_cDesc), ;
2162:                 "cursor_4c_PrDp")
2163:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrDp")
2164:                 dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrDp.Cpros), 14)
2165:                 THIS.grd_4c_Dados.Refresh()
2166:                 IF USED("cursor_4c_PrDp")
2167:                     USE IN cursor_4c_PrDp
2168:                 ENDIF
2169:                 RETURN
2170:             ENDIF
2171:             IF USED("cursor_4c_PrDp")
2172:                 USE IN cursor_4c_PrDp
2173:             ENDIF
2174: 
2175:             *-- Nao encontrado: abrir picker por descricao
2176:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2177:                 "cursor_4c_BuscaProD", "DPros", loc_cDesc, ;
2178:                 "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
2179:             IF VARTYPE(loc_oBusca) = "O"
2180:                 loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2181:                 loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2182:                 loc_oBusca.Show()
2183:                 IF loc_oBusca.this_lSelecionou
2184:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaProD.CPros), 14)
2185:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaProD.DPros), 40)
2186:                 ENDIF
2187:                 IF USED("cursor_4c_BuscaProD")
2188:                     USE IN cursor_4c_BuscaProD
2189:                 ENDIF
2190:                 loc_oBusca.Release()
2191:             ENDIF
2192: 
2193:             THIS.grd_4c_Dados.Refresh()
2194:             loc_lSucesso = .T.
2195: 
2196:         CATCH TO loc_oErro
2197:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2198:                     " PROC=" + loc_oErro.Procedure, ;
2199:                     "Erro FormSigPrEtq.ValidarDpros")
2200:         ENDTRY
2201: 
2202:         RETURN loc_lSucesso
2203:     ENDPROC
2204: 
2205:     *--------------------------------------------------------------------------
2206:     * ValidarReffs - Valida/lookup do campo Ref.Fornecedor (Column4) no grid
2207:     * Busca em SigCdPro por Dpro2s; preenche cpros+dpros+precos se achar
2208:     *--------------------------------------------------------------------------
2209:     PROCEDURE ValidarReffs()
2210:         LOCAL loc_oErro, loc_cReff, loc_nRet, loc_lSucesso, loc_oBusca
2211: 
2212:         loc_lSucesso = .F.
2213: 
2214:         TRY
2215:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2216:                 RETURN
2217:             ENDIF
2218: 
2219:             loc_cReff = ALLTRIM(NVL(dbImpressao.Reffs, ""))
2220: 
2221:             IF EMPTY(loc_cReff)
2222:                 RETURN
2223:             ENDIF
2224: 
2225:             *-- Tentar match por Dpro2s (referencia do fornecedor)
2226:             loc_nRet = SQLEXEC(gnConnHandle, ;
2227:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2228:                 "RTRIM(DPro2s) AS DPro2s, PVens, PrecoDe " + ;
2229:                 "FROM SigCdPro WHERE RTRIM(DPro2s) = " + EscaparSQL(loc_cReff), ;
2230:                 "cursor_4c_PrRff")
2231:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrRff")
2232:                 dbImpressao.Cpros   = PADR(ALLTRIM(cursor_4c_PrRff.Cpros), 14)
2233:                 dbImpressao.DPros   = PADR(ALLTRIM(cursor_4c_PrRff.DPros), 40)
2234:                 dbImpressao.PVens   = cursor_4c_PrRff.PVens
2235:                 dbImpressao.PrecoDe = cursor_4c_PrRff.PrecoDe
2236:                 THIS.grd_4c_Dados.Refresh()
2237:                 IF USED("cursor_4c_PrRff")
2238:                     USE IN cursor_4c_PrRff
2239:                 ENDIF
2240:                 RETURN
2241:             ENDIF
2242:             IF USED("cursor_4c_PrRff")
2243:                 USE IN cursor_4c_PrRff
2244:             ENDIF
2245: 
2246:             *-- Nao encontrado: abrir picker por Dpro2s
2247:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2248:                 "cursor_4c_BuscaRff", "DPro2s", loc_cReff, ;
2249:                 "Sele" + CHR(231) + CHR(227) + "o por Refer" + CHR(234) + "ncia", .T., .T., "")
2250:             IF VARTYPE(loc_oBusca) = "O"
2251:                 loc_oBusca.mAddColuna("DPro2s", "", "Refer" + CHR(234) + "ncia")
2252:                 loc_oBusca.mAddColuna("CPros",  "", "C" + CHR(243) + "digo")
2253:                 loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
2254:                 loc_oBusca.Show()
2255:                 IF loc_oBusca.this_lSelecionou
2256:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaRff.CPros),  14)
2257:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaRff.DPros),  40)
2258:                     dbImpressao.Reffs = PADR(ALLTRIM(cursor_4c_BuscaRff.DPro2s), 40)
2259:                 ENDIF
2260:                 IF USED("cursor_4c_BuscaRff")
2261:                     USE IN cursor_4c_BuscaRff
2262:                 ENDIF
2263:                 loc_oBusca.Release()
2264:             ENDIF
2265: 
2266:             THIS.grd_4c_Dados.Refresh()
2267:             loc_lSucesso = .T.
2268: 
2269:         CATCH TO loc_oErro
2270:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2271:                     " PROC=" + loc_oErro.Procedure, ;
2272:                     "Erro FormSigPrEtq.ValidarReffs")
2273:         ENDTRY
2274: 
2275:         RETURN loc_lSucesso
2276:     ENDPROC
2277: 
2278:     *--------------------------------------------------------------------------
2279:     * ValidarQtds - Valida campo Quantidade (Column3) no grid
2280:     * Confirma produto valido, define QtdeEtiq e move para proxima linha
2281:     *--------------------------------------------------------------------------
2282:     PROCEDURE ValidarQtds()
2283:         LOCAL loc_oErro, loc_nQtd, loc_cProd, loc_nRet, loc_lSucesso
2284: 
2285:         loc_lSucesso = .F.
2286: 
2287:         TRY
2288:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2289:                 RETURN
2290:             ENDIF
2291: 
2292:             loc_nQtd  = NVL(dbImpressao.Qtds, 0)
2293:             loc_cProd = ALLTRIM(PADR(NVL(dbImpressao.Cpros, ""), 14))
2294: 
2295:             IF EMPTY(loc_cProd)
2296:                 RETURN
2297:             ENDIF
2298: 
2299:             *-- Validar produto existe em SigCdPro
2300:             loc_nRet = SQLEXEC(gnConnHandle, ;
2301:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros FROM SigCdPro " + ;
2302:                 "WHERE RTRIM(CPros) = " + EscaparSQL(loc_cProd), ;
2303:                 "cursor_4c_PrQt")
2304:             IF loc_nRet <= 0 OR EOF("cursor_4c_PrQt")
2305:                 MsgAviso("Produto Inv" + CHR(225) + "lido!!!")
2306:                 IF USED("cursor_4c_PrQt")
2307:                     USE IN cursor_4c_PrQt
2308:                 ENDIF
2309:                 RETURN
2310:             ENDIF
2311:             IF USED("cursor_4c_PrQt")
2312:                 USE IN cursor_4c_PrQt
2313:             ENDIF
2314: 
2315:             *-- Definir quantidade de etiquetas igual a qtds (se maior que 0)
2316:             IF loc_nQtd > 0
2317:                 dbImpressao.QtdeEtiq = loc_nQtd
2318:             ENDIF
2319: 
2320:             THIS.grd_4c_Dados.Refresh()
2321: 
2322:             *-- Avancar para proxima linha (ENTER = nova linha no grid)
2323:             SELECT dbImpressao
2324:             IF !EOF()
2325:                 SKIP
2326:                 IF EOF()
2327:                     APPEND BLANK
2328:                 ENDIF
2329:             ENDIF
2330: 
2331:             THIS.grd_4c_Dados.Refresh()
2332:             THIS.grd_4c_Dados.SetFocus
2333: 
2334:             loc_lSucesso = .T.
2335: 
2336:         CATCH TO loc_oErro
2337:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2338:                     " PROC=" + loc_oErro.Procedure, ;
2339:                     "Erro FormSigPrEtq.ValidarQtds")
2340:         ENDTRY
2341: 
2342:         RETURN loc_lSucesso
2343:     ENDPROC
2344: 
2345:     *--------------------------------------------------------------------------
2346:     * OptPrecoInteractiveChange - Ao mudar opcao de Preco, atualiza Parcelas
2347:     * Original: col_par.Text1.When = (ThisForm.opt_Preco.Value = 6)
2348:     *--------------------------------------------------------------------------
2349:     PROCEDURE OptPrecoInteractiveChange()
2350:         THIS.AtualizarEstadoColunas()
2351:     ENDPROC
2352: 
2353:     *--------------------------------------------------------------------------
2354:     * AtualizarEstadoColunas - Controla editabilidade das colunas do grid
2355:     * Replica comportamento dos When events do original SIGPRETQ:
2356:     *   col_cpros/dpros/DPro2s: editavel somente em linha nova (Cpros vazio)
2357:     *   col_par (Parcelas): editavel somente com Preco = Parcelamento (Value=6)
2358:     *--------------------------------------------------------------------------
2359:     PROCEDURE AtualizarEstadoColunas()
2360:         LOCAL loc_lNovaLinha, loc_lParcelamento
2361: 
2362:         IF !USED("dbImpressao") OR EOF("dbImpressao")
2363:             RETURN
2364:         ENDIF
2365: 
2366:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
2367:             RETURN
2368:         ENDIF
2369: 
2370:         loc_lNovaLinha    = EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2371:         loc_lParcelamento = (THIS.obj_4c_Opt_Preco.Value = 6)
2372: 
2373:         THIS.grd_4c_Dados.col_4c_cpros.ReadOnly  = !loc_lNovaLinha
2374:         THIS.grd_4c_Dados.col_4c_dpros.ReadOnly  = !loc_lNovaLinha
2375:         THIS.grd_4c_Dados.col_4c_DPro2s.ReadOnly = !loc_lNovaLinha
2376:         THIS.grd_4c_Dados.col_4c_par.ReadOnly    = !loc_lParcelamento
2377:     ENDPROC
2378: 
2379:     *--------------------------------------------------------------------------
2380:     * BtnIncluirClick - Inclui linha em branco na grade dbImpressao para
2381:     * entrada manual de um novo produto (equivalente operacional a "novo item").
2382:     * Reposiciona o cursor na nova linha e devolve o foco ao grid.
2383:     *--------------------------------------------------------------------------
2384:     PROCEDURE BtnIncluirClick()
2385:         LOCAL loc_oErro
2386: 
2387:         TRY
2388:             IF !USED("dbImpressao")
2389:                 MsgAviso("A grade de impress" + CHR(227) + "o n" + CHR(227) + ;
2390:                          "o est" + CHR(225) + " dispon" + CHR(237) + "vel!!!")
2391:                 RETURN
2392:             ENDIF
2393: 
2394:             SELECT dbImpressao
2395:             SET ORDER TO
2396: 
2397:             *-- Se a grade tem apenas uma linha em branco padrao, reusa-a
2398:             IF RECCOUNT("dbImpressao") = 1 AND EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2399:                 GO TOP IN dbImpressao
2400:             ELSE
2401:                 APPEND BLANK IN dbImpressao
2402:                 *-- Posiciona na ultima linha (a que acabou de ser criada)
2403:                 SELECT dbImpressao
2404:                 GO BOTTOM IN dbImpressao
2405:             ENDIF
2406: 
2407:             THIS.grd_4c_Dados.Refresh()
2408:             THIS.AtualizarEstadoColunas()
2409: 
2410:             *-- Foca a coluna de produto para digitacao imediata
2411:             IF PEMSTATUS(THIS.grd_4c_Dados, "col_4c_cpros", 5)
2412:                 THIS.grd_4c_Dados.SetFocus()
2413:                 THIS.grd_4c_Dados.ActivateCell( ;
2414:                     RECNO("dbImpressao"), 1)
2415:             ENDIF
2416: 
2417:         CATCH TO loc_oErro
2418:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2419:                     " PROC=" + loc_oErro.Procedure, ;
2420:                     "Erro FormSigPrEtq.BtnIncluirClick")
2421:         ENDTRY
2422:     ENDPROC
2423: 
2424:     *--------------------------------------------------------------------------
2425:     * BtnAlterarClick - Ativa edicao da linha corrente do grid, permitindo
2426:     * ajustar quantidade/etiquetas do item selecionado.
2427:     * Foca a coluna Qtds e destrava colunas quando aplicavel.
2428:     *--------------------------------------------------------------------------
2429:     PROCEDURE BtnAlterarClick()
2430:         LOCAL loc_oErro, loc_nRecno
2431: 
2432:         TRY
2433:             IF !USED("dbImpressao") OR RECCOUNT("dbImpressao") = 0
2434:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens na grade para alterar!!!")
2435:                 RETURN
2436:             ENDIF
2437: 
2438:             SELECT dbImpressao
2439:             loc_nRecno = RECNO("dbImpressao")
2440: 
2441:             IF EOF("dbImpressao") OR EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2442:                 MsgAviso("Selecione um item na grade antes de alterar!!!")
2443:                 THIS.grd_4c_Dados.SetFocus()
2444:                 RETURN
2445:             ENDIF
2446: 
2447:             *-- Permite editar Parcelas se a modalidade Preco = Parcelamento (6)
2448:             IF THIS.obj_4c_Opt_Preco.Value = 6
2449:                 THIS.grd_4c_Dados.col_4c_par.ReadOnly = .F.
2450:             ENDIF
2451: 
2452:             THIS.grd_4c_Dados.Refresh()
2453: 
2454:             *-- Foca coluna de quantidade (indice 3: Cpros=1, DPros=2, Qtds=3)
2455:             THIS.grd_4c_Dados.SetFocus()
2456:             THIS.grd_4c_Dados.ActivateCell(loc_nRecno, 3)
2457: 
2458:         CATCH TO loc_oErro
2459:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2460:                     " PROC=" + loc_oErro.Procedure, ;
2461:                     "Erro FormSigPrEtq.BtnAlterarClick")
2462:         ENDTRY
2463:     ENDPROC
2464: 
2465:     *--------------------------------------------------------------------------
2466:     * BtnVisualizarClick - Exibe resumo dos itens carregados na grade antes
2467:     * da impressao (contagem total, distintos e quantidade agregada).
2468:     * Equivalente operacional a "visualizar antes de imprimir".
2469:     *--------------------------------------------------------------------------
2470:     PROCEDURE BtnVisualizarClick()
2471:         LOCAL loc_oErro, loc_nTotal, loc_nDistintos, loc_nQtdTotal, loc_cMsg
2472: 
2473:         TRY
2474:             IF !USED("dbImpressao") OR RECCOUNT("dbImpressao") = 0
2475:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens carregados na grade!!!")
2476:                 RETURN
2477:             ENDIF
2478: 
2479:             loc_nTotal    = 0
2480:             loc_nDistintos = 0
2481:             loc_nQtdTotal = 0
2482: 
2483:             *-- Conta itens validos (Cpros preenchido)
2484:             SELECT COUNT(*) AS nTot, ;
2485:                    COUNT(DISTINCT Cpros) AS nDist, ;
2486:                    SUM(NVL(QtdeEtiq, 0)) AS nQtd ;
2487:                 FROM dbImpressao ;
2488:                 WHERE !EMPTY(NVL(Cpros, "")) ;
2489:                 INTO CURSOR cursor_4c_TmpResumo
2490: 
2491:             IF USED("cursor_4c_TmpResumo") AND !EOF("cursor_4c_TmpResumo")
2492:                 loc_nTotal     = NVL(cursor_4c_TmpResumo.nTot,  0)
2493:                 loc_nDistintos = NVL(cursor_4c_TmpResumo.nDist, 0)
2494:                 loc_nQtdTotal  = NVL(cursor_4c_TmpResumo.nQtd,  0)
2495:             ENDIF
2496: 
2497:             IF USED("cursor_4c_TmpResumo")
2498:                 USE IN cursor_4c_TmpResumo
2499:             ENDIF
2500: 
2501:             IF loc_nTotal = 0
2502:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
2503:                          " itens v" + CHR(225) + "lidos para impress" + CHR(227) + "o!!!")
2504:                 RETURN
2505:             ENDIF
2506: 
2507:             loc_cMsg = "Resumo da Impress" + CHR(227) + "o de Etiquetas:" + CHR(13) + CHR(13) + ;
2508:                        "Itens na grade....: " + TRANSFORM(loc_nTotal)     + CHR(13) + ;
2509:                        "Produtos distintos: " + TRANSFORM(loc_nDistintos) + CHR(13) + ;
2510:                        "Etiquetas a imprimir: " + TRANSFORM(loc_nQtdTotal, "@R 999,999,999")
2511: 
2512:             MsgInfo(loc_cMsg, "Visualizar Impress" + CHR(227) + "o")
2513: 
2514:             SELECT dbImpressao
2515:             GO TOP IN dbImpressao
2516:             THIS.grd_4c_Dados.Refresh()
2517: 
2518:         CATCH TO loc_oErro
2519:             IF USED("cursor_4c_TmpResumo")
2520:                 USE IN cursor_4c_TmpResumo
2521:             ENDIF
2522:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2523:                     " PROC=" + loc_oErro.Procedure, ;
2524:                     "Erro FormSigPrEtq.BtnVisualizarClick")
2525:         ENDTRY
2526:     ENDPROC
2527: 
2528:     *--------------------------------------------------------------------------
2529:     * FormParaBO - Transfere parametros dos controles do form para o BO
2530:     * Chamado por BtnImprimeClick antes de ImprimirEtiquetas
2531:     *--------------------------------------------------------------------------
2532:     PROCEDURE FormParaBO()
2533:         LOCAL loc_nTipo, loc_oBO
2534: 
2535:         loc_oBO = THIS.this_oBusinessObject
2536: 
2537:         loc_oBO.this_nImpPreco     = THIS.obj_4c_Opt_Preco.Value
2538:         loc_oBO.this_lImpSepar     = (THIS.obj_4c_Opt_separador.Value = 1)
2539:         loc_oBO.this_lImpPeso      = (THIS.obj_4c_Opt_peso.Value = 1)
2540:         loc_oBO.this_lCompo        = (THIS.obj_4c_OptCompos.Value = 1)
2541: 
2542:         loc_nTipo = THIS.obj_4c_Opt_Tipo.Value
2543:         IF loc_nTipo >= 1 AND loc_nTipo <= THIS.obj_4c_Opt_Tipo.ButtonCount
2544:             loc_oBO.this_nTipo  = loc_nTipo
2545:             loc_oBO.this_nTpEti = INT(VAL(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipo).Tag))
2546:         ENDIF
2547: 
2548:         loc_oBO.this_nTpImp        = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value
2549:         loc_oBO.this_nAjVertsPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
2550:         loc_oBO.this_nAjHorzsPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
2551:         loc_oBO.this_nAjDensPrint  = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
2552:         loc_oBO.this_nAjVelosPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value
2553: 
2554:         IF USED("cursor_4c_ImpreV") AND !EOF("cursor_4c_ImpreV")
2555:             loc_oBO.this_cNomeImp = ALLTRIM(NVL(cursor_4c_ImpreV.impresS, ""))
2556:         ELSE
2557:             loc_oBO.this_cNomeImp = ""
2558:         ENDIF
2559: 
2560:         loc_oBO.this_cLp1   = ALLTRIM(THIS.txt_4c_Lpreco.Value)
2561:         loc_oBO.this_cLp2   = ALLTRIM(THIS.txt_4c_LPreco2.Value)
2562:         loc_oBO.this_nOrdem = THIS.obj_4c_OptOrdem.Value
2563:         loc_oBO.this_cDopes = ALLTRIM(THIS.txt_4c_Dopes.Value)
2564:         loc_oBO.this_nNumes = THIS.txt_4c_Numes.Value
2565:     ENDPROC
2566: 
2567:     *--------------------------------------------------------------------------
2568:     * BOParaForm - OPERACIONAL: BO nao carrega registros para edicao.
2569:     * Presente para padrao do pipeline; sem acao real neste form.
2570:     *--------------------------------------------------------------------------
2571:     PROTECTED PROCEDURE BOParaForm()
2572:         *-- OPERACIONAL: dados vem de SQL via BtnCarregarClick/CarregarItensListaPreco
2573:         *-- Nao ha "registro corrente" do BO para carregar nos controles
2574:         RETURN .T.
2575:     ENDPROC
2576: 
2577:     *--------------------------------------------------------------------------
2578:     * CarregarLista - Refresca a exibicao da grade dbImpressao
2579:     * OPERACIONAL: sem lista de cadastro; reposiciona e refresca o grid
2580:     *--------------------------------------------------------------------------
2581:     PROCEDURE CarregarLista()
2582:         IF USED("dbImpressao")
2583:             SELECT dbImpressao
2584:             IF RECCOUNT("dbImpressao") = 0
2585:                 APPEND BLANK IN dbImpressao
2586:             ENDIF
2587:             GO TOP IN dbImpressao
2588:         ENDIF
2589: 
2590:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2591:             THIS.grd_4c_Dados.Refresh()
2592:         ENDIF
2593:     ENDPROC
2594: 
2595:     *--------------------------------------------------------------------------
2596:     * LimparCampos - Limpa filtros de entrada e reseta grade dbImpressao
2597:     *--------------------------------------------------------------------------
2598:     PROCEDURE LimparCampos()
2599:         IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5)
2600:             THIS.txt_4c_Lpreco.Value  = ""
2601:         ENDIF
2602:         IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5)
2603:             THIS.txt_4c_LPreco2.Value = ""
2604:         ENDIF
2605:         IF PEMSTATUS(THIS, "txt_4c_Emps", 5)
2606:             THIS.txt_4c_Emps.Value    = ""
2607:         ENDIF
2608:         IF PEMSTATUS(THIS, "txt_4c_Dopes", 5)
2609:             THIS.txt_4c_Dopes.Value   = ""
2610:         ENDIF
2611:         IF PEMSTATUS(THIS, "txt_4c_Numes", 5)
2612:             THIS.txt_4c_Numes.Value   = 0
2613:         ENDIF
2614: 
2615:         IF USED("dbImpressao")
2616:             ZAP IN dbImpressao
2617:             APPEND BLANK IN dbImpressao
2618:             GO TOP IN dbImpressao
2619:         ENDIF
2620: 
2621:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2622:             THIS.grd_4c_Dados.Refresh()
2623:         ENDIF
2624:     ENDPROC
2625: 
2626:     *--------------------------------------------------------------------------
2627:     * HabilitarCampos - Habilita controles de entrada
2628:     * OPERACIONAL: campos sempre habilitados (sem modos INCLUIR/ALTERAR)
2629:     *--------------------------------------------------------------------------
2630:     PROCEDURE HabilitarCampos()
2631:         IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5)
2632:             THIS.txt_4c_Lpreco.Enabled = .T.
2633:         ENDIF
2634:         IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5)
2635:             THIS.txt_4c_LPreco2.Enabled = .T.
2636:         ENDIF
2637:         IF PEMSTATUS(THIS, "txt_4c_Emps", 5)
2638:             THIS.txt_4c_Emps.Enabled = .T.
2639:         ENDIF
2640:         IF PEMSTATUS(THIS, "txt_4c_Dopes", 5)
2641:             THIS.txt_4c_Dopes.Enabled = .T.
2642:         ENDIF
2643:         IF PEMSTATUS(THIS, "txt_4c_Numes", 5)
2644:             THIS.txt_4c_Numes.Enabled = .T.
2645:         ENDIF
2646:         IF PEMSTATUS(THIS, "chk_4c_ChkLista", 5)
2647:             THIS.chk_4c_ChkLista.Enabled = .T.
2648:         ENDIF
2649:         IF PEMSTATUS(THIS, "chk_4c_ChkOperacoes", 5)
2650:             THIS.chk_4c_ChkOperacoes.Enabled = .T.
2651:         ENDIF
2652:         IF PEMSTATUS(THIS, "cmd_4c_BtnCarregar", 5)
2653:         ENDIF
2654:         IF PEMSTATUS(THIS, "cmd_4c_Btnexcluir", 5)
2655:         ENDIF
2656:     ENDPROC
2657: 
2658:     *--------------------------------------------------------------------------
2659:     * AjustarBotoesPorModo - OPERACIONAL: sem modos CRUD; no-op
2660:     *--------------------------------------------------------------------------
2661:     PROCEDURE AjustarBotoesPorModo()
2662:         *-- OPERACIONAL nao tem modos INCLUIR/ALTERAR/VISUALIZAR
2663:         *-- Botoes sao fixos: Carregar, Excluir, Imprimir, Sair
2664:         RETURN .T.
2665:     ENDPROC
2666: 
2667:     *--------------------------------------------------------------------------
2668:     * BtnEncerrarClick - Fecha o formulario (alias canonico para BtnSairClick)
2669:     *--------------------------------------------------------------------------
2670:     PROCEDURE BtnEncerrarClick()
2671:         THIS.Release()
2672:     ENDPROC
2673: 
2674:     *--------------------------------------------------------------------------
2675:     * BtnBuscarClick - Equivalente operacional de "Buscar": carrega itens
2676:     * da movimentacao para a grade (delega a BtnCarregarClick)
2677:     *--------------------------------------------------------------------------
2678:     PROCEDURE BtnBuscarClick()
2679:         THIS.BtnCarregarClick()
2680:     ENDPROC
2681: 
2682:     *--------------------------------------------------------------------------
2683:     * BtnSalvarClick - Equivalente operacional de "Salvar": confirma impressao
2684:     * (delega a BtnImprimeClick para compatibilidade com pipeline)
2685:     *--------------------------------------------------------------------------
2686:     PROCEDURE BtnSalvarClick()
2687:         THIS.BtnImprimeClick()
2688:     ENDPROC
2689: 
2690:     *--------------------------------------------------------------------------
2691:     * BtnCancelarClick - Equivalente operacional de "Cancelar": limpa campos
2692:     * e reseta a grade sem fechar o formulario
2693:     *--------------------------------------------------------------------------
2694:     PROCEDURE BtnCancelarClick()
2695:         IF MsgConfirma("Limpar campos e reiniciar a grade?")
2696:             THIS.LimparCampos()
2697:         ENDIF
2698:     ENDPROC
2699: 
2700: ENDDEFINE


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

