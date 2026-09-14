# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (23)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=6 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Tipo' Top=10 (diff=421px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRETQ): Top original=415 vs migrado 'lbl_4c_Label11' Top=594 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRETQ): Left original=23 vs migrado 'lbl_4c_Label11' Left=556 (diff=533px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Impressora' Top=6 (diff=425px, tolerancia=30px)
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2712 linhas total):

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
194:                 IF INLIST(UPPER(loc_oControl.Name), "OBJ_4C_OPT_IMPRESSORA")
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
1206:                 .ButtonCount   = 2
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
1224:                     .Top       = 6
1225:                     .Width     = 130
1226:                     .Themes    = .F.
1227:                 ENDWITH
1228:                 WITH .Buttons(2)
1229:                     .AutoSize  = .F.
1230:                     .BackStyle = 0
1231:                     .Caption   = "Windows"
1232:                     .ForeColor = RGB(36,84,155)
1233:                     .Height    = 16
1234:                     .Left      = 149
1235:                     .Style     = 0
1236:                     .Top       = 6
1237:                     .Width     = 80
1238:                     .Themes    = .F.
1239:                 ENDWITH
1240:             ENDWITH
1241: 
1242:             *-- Labels "Sistema" e "Windows" (acima do Get_Printer)
1243:             THIS.AddObject("lbl_4c_Label12", "Label")

*-- Linhas 1288 a 1403:
1288:                 .ColumnCount   = 1
1289:                 .ColumnWidths  = "239"
1290:             ENDWITH
1291:             BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "CboGetPrinterInteractiveChange")
1292: 
1293:             *-- Separadora (label + OptionGroup)
1294:             THIS.AddObject("lbl_4c_Lbl_Separador", "Label")
1295:             WITH THIS.lbl_4c_Lbl_Separador
1296:                 .AutoSize  = .T.
1297:                 .FontBold  = .F.
1298:                 .FontName  = "Tahoma"
1299:                 .FontSize  = 8
1300:                 .BackStyle = 0
1301:                 .Caption   = "Separadora :"
1302:                 .Height    = 15
1303:                 .Left      = 532
1304:                 .Top       = 417
1305:                 .Width     = 65
1306:                 .ForeColor = RGB(90,90,90)
1307:             ENDWITH
1308: 
1309:             THIS.AddObject("obj_4c_Opt_separador", "OptionGroup")
1310:             WITH THIS.obj_4c_Opt_separador
1311:                 .AutoSize      = .F.
1312:                 .ButtonCount   = 2
1313:                 .BackStyle     = 0
1314:                 .Value         = 1
1315:                 .Height        = 25
1316:                 .Left          = 601
1317:                 .SpecialEffect = 1
1318:                 .Top           = 412
1319:                 .Width         = 198
1320:                 .Themes        = .F.
1321:                 WITH .Buttons(1)
1322:                     .AutoSize  = .T.
1323:                     .BackStyle = 0
1324:                     .Caption   = "Sim"
1325:                     .ForeColor = RGB(90,90,90)
1326:                     .Height    = 15
1327:                     .Left      = 5
1328:                     .Top       = 5
1329:                     .Width     = 34
1330:                     .Themes    = .F.
1331:                 ENDWITH
1332:                 WITH .Buttons(2)
1333:                     .AutoSize  = .T.
1334:                     .BackStyle = 0
1335:                     .Caption   = "N" + CHR(227) + "o"
1336:                     .FontName  = "Tahoma"
1337:                     .FontSize  = 8
1338:                     .ForeColor = RGB(90,90,90)
1339:                     .Height    = 15
1340:                     .Left      = 70
1341:                     .Top       = 5
1342:                     .Width     = 37
1343:                     .Themes    = .F.
1344:                 ENDWITH
1345:             ENDWITH
1346: 
1347:             *-- Preco (label + OptionGroup 6 botoes)
1348:             THIS.AddObject("lbl_4c_Label8", "Label")
1349:             WITH THIS.lbl_4c_Label8
1350:                 .AutoSize  = .T.
1351:                 .FontBold  = .F.
1352:                 .FontName  = "Tahoma"
1353:                 .FontSize  = 8
1354:                 .BackStyle = 0
1355:                 .Caption   = "Pre" + CHR(231) + "o :"
1356:                 .Height    = 15
1357:                 .Left      = 561
1358:                 .Top       = 440
1359:                 .Width     = 36
1360:                 .ForeColor = RGB(90,90,90)
1361:             ENDWITH
1362: 
1363:             THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
1364:             WITH THIS.obj_4c_Opt_Preco
1365:                 .AutoSize      = .F.
1366:                 .ButtonCount   = 6
1367:                 .BackStyle     = 0
1368:                 .Value         = 1
1369:                 .Height        = 95
1370:                 .Left          = 601
1371:                 .SpecialEffect = 1
1372:                 .Top           = 439
1373:                 .Width         = 198
1374:                 .Themes        = .F.
1375:                 WITH .Buttons(1)
1376:                     .AutoSize  = .T.
1377:                     .BackStyle = 0
1378:                     .Caption   = "Sim"
1379:                     .ForeColor = RGB(90,90,90)
1380:                     .Height    = 15
1381:                     .Left      = 8
1382:                     .Top       = 7
1383:                     .Width     = 34
1384:                     .Themes    = .F.
1385:                 ENDWITH
1386:                 WITH .Buttons(2)
1387:                     .AutoSize  = .T.
1388:                     .BackStyle = 0
1389:                     .Caption   = "N" + CHR(227) + "o"
1390:                     .FontName  = "Tahoma"
1391:                     .FontSize  = 8
1392:                     .ForeColor = RGB(90,90,90)
1393:                     .Height    = 15
1394:                     .Left      = 61
1395:                     .Top       = 7
1396:                     .Width     = 37
1397:                     .Themes    = .F.
1398:                 ENDWITH
1399:                 WITH .Buttons(3)
1400:                     .AutoSize  = .T.
1401:                     .BackStyle = 0
1402:                     .Caption   = "Ideal"
1403:                     .FontName  = "Tahoma"

*-- Linhas 1450 a 1665:
1450:                 ENDWITH
1451:             ENDWITH
1452: 
1453:             *-- Peso (label + OptionGroup)
1454:             THIS.AddObject("lbl_4c_Label9", "Label")
1455:             WITH THIS.lbl_4c_Label9
1456:                 .AutoSize  = .T.
1457:                 .FontBold  = .F.
1458:                 .FontName  = "Tahoma"
1459:                 .FontSize  = 8
1460:                 .BackStyle = 0
1461:                 .Caption   = "Peso :"
1462:                 .Height    = 15
1463:                 .Left      = 565
1464:                 .Top       = 540
1465:                 .Width     = 32
1466:                 .ForeColor = RGB(90,90,90)
1467:             ENDWITH
1468: 
1469:             THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
1470:             WITH THIS.obj_4c_Opt_peso
1471:                 .AutoSize      = .F.
1472:                 .ButtonCount   = 2
1473:                 .BackStyle     = 0
1474:                 .Value         = 1
1475:                 .Height        = 25
1476:                 .Left          = 601
1477:                 .SpecialEffect = 1
1478:                 .Top           = 535
1479:                 .Width         = 198
1480:                 .Themes        = .F.
1481:                 WITH .Buttons(1)
1482:                     .AutoSize  = .F.
1483:                     .BackStyle = 0
1484:                     .Caption   = "Sim"
1485:                     .ForeColor = RGB(90,90,90)
1486:                     .Height    = 15
1487:                     .Left      = 5
1488:                     .Top       = 5
1489:                     .Width     = 41
1490:                     .Themes    = .F.
1491:                 ENDWITH
1492:                 WITH .Buttons(2)
1493:                     .AutoSize  = .F.
1494:                     .BackStyle = 0
1495:                     .Caption   = "N" + CHR(227) + "o"
1496:                     .FontName  = "Tahoma"
1497:                     .FontSize  = 8
1498:                     .ForeColor = RGB(90,90,90)
1499:                     .Height    = 15
1500:                     .Left      = 70
1501:                     .Top       = 5
1502:                     .Width     = 41
1503:                     .Themes    = .F.
1504:                 ENDWITH
1505:             ENDWITH
1506: 
1507:             *-- Composicao (label + OptionGroup)
1508:             THIS.AddObject("lbl_4c_Label10", "Label")
1509:             WITH THIS.lbl_4c_Label10
1510:                 .AutoSize  = .T.
1511:                 .FontBold  = .F.
1512:                 .FontName  = "Tahoma"
1513:                 .FontSize  = 8
1514:                 .BackStyle = 0
1515:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
1516:                 .Height    = 15
1517:                 .Left      = 531
1518:                 .Top       = 567
1519:                 .Width     = 66
1520:                 .ForeColor = RGB(90,90,90)
1521:             ENDWITH
1522: 
1523:             THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
1524:             WITH THIS.obj_4c_OptCompos
1525:                 .AutoSize      = .F.
1526:                 .ButtonCount   = 2
1527:                 .BackStyle     = 0
1528:                 .Value         = 1
1529:                 .Height        = 25
1530:                 .Left          = 601
1531:                 .SpecialEffect = 1
1532:                 .Top           = 562
1533:                 .Width         = 198
1534:                 .Themes        = .F.
1535:                 WITH .Buttons(1)
1536:                     .AutoSize  = .F.
1537:                     .BackStyle = 0
1538:                     .Caption   = "Sim"
1539:                     .ForeColor = RGB(90,90,90)
1540:                     .Height    = 15
1541:                     .Left      = 5
1542:                     .Top       = 5
1543:                     .Width     = 41
1544:                     .Themes    = .F.
1545:                 ENDWITH
1546:                 WITH .Buttons(2)
1547:                     .AutoSize  = .F.
1548:                     .BackStyle = 0
1549:                     .Caption   = "N" + CHR(227) + "o"
1550:                     .FontName  = "Tahoma"
1551:                     .FontSize  = 8
1552:                     .ForeColor = RGB(90,90,90)
1553:                     .Height    = 15
1554:                     .Left      = 70
1555:                     .Top       = 5
1556:                     .Width     = 41
1557:                     .Themes    = .F.
1558:                 ENDWITH
1559:             ENDWITH
1560: 
1561:             *-- Ordem (label + OptionGroup)
1562:             THIS.AddObject("lbl_4c_Label11", "Label")
1563:             WITH THIS.lbl_4c_Label11
1564:                 .AutoSize  = .T.
1565:                 .FontBold  = .F.
1566:                 .FontName  = "Tahoma"
1567:                 .FontSize  = 8
1568:                 .BackStyle = 0
1569:                 .Caption   = "Ordem :"
1570:                 .Height    = 15
1571:                 .Left      = 556
1572:                 .Top       = 594
1573:                 .Width     = 41
1574:                 .ForeColor = RGB(90,90,90)
1575:             ENDWITH
1576: 
1577:             THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
1578:             WITH THIS.obj_4c_OptOrdem
1579:                 .AutoSize      = .F.
1580:                 .ButtonCount   = 2
1581:                 .BackStyle     = 0
1582:                 .Value         = 1
1583:                 .Height        = 25
1584:                 .Left          = 601
1585:                 .SpecialEffect = 1
1586:                 .Top           = 589
1587:                 .Width         = 198
1588:                 .Themes        = .F.
1589:                 WITH .Buttons(1)
1590:                     .AutoSize  = .T.
1591:                     .BackStyle = 0
1592:                     .Caption   = "Produto"
1593:                     .ForeColor = RGB(90,90,90)
1594:                     .Height    = 15
1595:                     .Left      = 5
1596:                     .Top       = 4
1597:                     .Width     = 56
1598:                     .Themes    = .F.
1599:                 ENDWITH
1600:                 WITH .Buttons(2)
1601:                     .AutoSize  = .T.
1602:                     .BackStyle = 0
1603:                     .Caption   = "Nenhuma"
1604:                     .FontName  = "Tahoma"
1605:                     .FontSize  = 8
1606:                     .ForeColor = RGB(90,90,90)
1607:                     .Height    = 15
1608:                     .Left      = 70
1609:                     .Top       = 4
1610:                     .Width     = 63
1611:                     .Themes    = .F.
1612:                 ENDWITH
1613:             ENDWITH
1614: 
1615:         CATCH TO loc_oErro
1616:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1617:                     " PROC=" + loc_oErro.Procedure, ;
1618:                     "Erro FormSigPrEtq.ConfigurarPaginaDados")
1619:         ENDTRY
1620:     ENDPROC
1621: 
1622:     *--------------------------------------------------------------------------
1623:     * CarregarTiposEtiqueta - Popula obj_4c_Opt_Tipo dinamicamente via SigCdTpe
1624:     *--------------------------------------------------------------------------
1625:     PROTECTED PROCEDURE CarregarTiposEtiqueta()
1626:         LOCAL loc_oErro, loc_lSucesso, loc_nTipos, loc_nI, loc_nTop, loc_nHeight
1627: 
1628:         loc_lSucesso = .F.
1629:         loc_nI      = 1
1630:         loc_nTop    = 10
1631:         loc_nHeight = 15
1632: 
1633:         TRY
1634:             IF SQLEXEC(gnConnHandle, ;
1635:                 "SELECT nTipos, RTRIM(cEtiquetas) AS cEtiquetas " + ;
1636:                 "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
1637:                 "cursor_4c_TiposEti") > 0
1638: 
1639:                 SELECT cursor_4c_TiposEti
1640:                 loc_nTipos = RECCOUNT("cursor_4c_TiposEti")
1641: 
1642:                 IF loc_nTipos > 0
1643:                     WITH THIS.obj_4c_Opt_Tipo
1644:                         .ButtonCount = loc_nTipos
1645:                         SELECT cursor_4c_TiposEti
1646:                         GO TOP IN cursor_4c_TiposEti
1647:                         DO WHILE !EOF("cursor_4c_TiposEti")
1648:                             WITH .Buttons(loc_nI)
1649:                                 .AutoSize  = .F.
1650:                                 .Width     = 197
1651:                                 .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
1652:                                              ALLTRIM(cursor_4c_TiposEti.cEtiquetas)
1653:                                 .ForeColor = RGB(90,90,90)
1654:                                 .Tag       = ALLTRIM(STR(cursor_4c_TiposEti.nTipos))
1655:                                 .Top       = loc_nTop
1656:                                 .BackStyle = 0
1657:                                 .Height    = 16
1658:                                 .Left      = 9
1659:                                 .Themes    = .F.
1660:                             ENDWITH
1661:                             loc_nI      = loc_nI + 1
1662:                             loc_nTop    = loc_nTop + 20
1663:                             loc_nHeight = loc_nHeight + 20
1664:                             SKIP IN cursor_4c_TiposEti
1665:                         ENDDO

*-- Linhas 1677 a 1814:
1677: 
1678:         CATCH TO loc_oErro
1679:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1680:                     " PROC=" + loc_oErro.Procedure, ;
1681:                     "Erro FormSigPrEtq.CarregarTiposEtiqueta")
1682:         ENDTRY
1683: 
1684:         RETURN loc_lSucesso
1685:     ENDPROC
1686: 
1687:     *--------------------------------------------------------------------------
1688:     * TxtLprecoKeyPress - KeyPress do campo Lista de Precos principal
1689:     *--------------------------------------------------------------------------
1690:     PROCEDURE TxtLprecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1691:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1692:             RETURN
1693:         ENDIF
1694:         THIS.AbrirBuscaLPreco(THIS.txt_4c_Lpreco)
1695:     ENDPROC
1696: 
1697:     *--------------------------------------------------------------------------
1698:     * TxtLPreco2KeyPress - KeyPress do campo Lista de Precos adicional
1699:     *--------------------------------------------------------------------------
1700:     PROCEDURE TxtLPreco2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1701:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1702:             RETURN
1703:         ENDIF
1704:         THIS.AbrirBuscaLPreco(THIS.txt_4c_LPreco2)
1705:     ENDPROC
1706: 
1707:     *--------------------------------------------------------------------------
1708:     * AbrirBuscaLPreco - Lookup SigCdLpc; se txt_4c_Lpreco + chkLista=1 carrega itens
1709:     *--------------------------------------------------------------------------
1710:     PROTECTED PROCEDURE AbrirBuscaLPreco(par_oTxt)
1711:         LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet
1712: 
1713:         loc_lSucesso  = .F.
1714:         loc_lEncontrado = .F.
1715: 
1716:         TRY
1717:             loc_cValor = ALLTRIM(par_oTxt.Value)
1718: 
1719:             *-- Tenta match exato
1720:             IF !EMPTY(loc_cValor)
1721:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1722:                     "SELECT TOP 1 RTRIM(LPrecos) AS LPrecos FROM SigCdLpc " + ;
1723:                     "WHERE RTRIM(LPrecos) = " + EscaparSQL(loc_cValor), ;
1724:                     "cursor_4c_ChkLpc")
1725:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkLpc")
1726:                     par_oTxt.Value = ALLTRIM(cursor_4c_ChkLpc.LPrecos)
1727:                     loc_lEncontrado = .T.
1728:                     IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
1729:                        THIS.chk_4c_ChkLista.Value = 1
1730:                         THIS.CarregarItensListaPreco(par_oTxt.Value)
1731:                     ENDIF
1732:                 ENDIF
1733:                 IF USED("cursor_4c_ChkLpc")
1734:                     USE IN cursor_4c_ChkLpc
1735:                 ENDIF
1736:             ENDIF
1737: 
1738:             *-- Match nao encontrado: abre picker
1739:             IF !loc_lEncontrado
1740:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLpc", ;
1741:                     "cursor_4c_BuscaLpc", "LPrecos", loc_cValor, ;
1742:                     "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
1743:                 IF VARTYPE(loc_oLookup) = "O"
1744:                     loc_oLookup.mAddColuna("LPrecos", "", "Lista de Pre" + CHR(231) + "os")
1745:                     loc_oLookup.Show()
1746:                     IF loc_oLookup.this_lSelecionou
1747:                         par_oTxt.Value = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
1748:                         IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
1749:                            THIS.chk_4c_ChkLista.Value = 1
1750:                             THIS.CarregarItensListaPreco(par_oTxt.Value)
1751:                         ENDIF
1752:                     ENDIF
1753:                     IF USED("cursor_4c_BuscaLpc")
1754:                         USE IN cursor_4c_BuscaLpc
1755:                     ENDIF
1756:                 ENDIF
1757:             ENDIF
1758: 
1759:             loc_lSucesso = .T.
1760: 
1761:         CATCH TO loc_oErro
1762:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1763:                     " PROC=" + loc_oErro.Procedure, ;
1764:                     "Erro FormSigPrEtq.AbrirBuscaLPreco")
1765:         ENDTRY
1766: 
1767:         RETURN loc_lSucesso
1768:     ENDPROC
1769: 
1770:     *--------------------------------------------------------------------------
1771:     * CarregarItensListaPreco - Popula dbImpressao com itens de SigCdLpi
1772:     * Verifica validade do preco; se expirado, busca preco atual em SigCdPro
1773:     *--------------------------------------------------------------------------
1774:     PROTECTED PROCEDURE CarregarItensListaPreco(par_cLPreco)
1775:         LOCAL loc_oErro, loc_lSucesso, loc_cSQL, loc_nPVens, loc_nPrecoDe, loc_nRetPro
1776: 
1777:         loc_lSucesso = .F.
1778: 
1779:         TRY
1780:             ZAP IN dbImpressao
1781: 
1782:             loc_cSQL = "SELECT RTRIM(a.LPrecos) AS LPrecos, RTRIM(a.CPros) AS Cpros, " + ;
1783:                        "RTRIM(a.DPros) AS DPros, a.PVens, a.Precode AS PrecoDe, " + ;
1784:                        "a.VencIs, a.VencFs " + ;
1785:                        "FROM SigCdLpi a " + ;
1786:                        "WHERE RTRIM(a.LPrecos) = " + EscaparSQL(par_cLPreco)
1787: 
1788:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpreI") > 0
1789:                 SELECT cursor_4c_LpreI
1790:                 SCAN
1791:                     loc_nPVens   = cursor_4c_LpreI.PVens
1792:                     loc_nPrecoDe = cursor_4c_LpreI.PrecoDe
1793: 
1794:                     *-- Se preco da lista expirou, usa preco atual do produto
1795:                     IF !BETWEEN(DATETIME(), cursor_4c_LpreI.VencIs, cursor_4c_LpreI.VencFs)
1796:                         loc_nRetPro = SQLEXEC(gnConnHandle, ;
1797:                             "SELECT TOP 1 PVens, PrecoDe FROM SigCdPro " + ;
1798:                             "WHERE RTRIM(CPros) = " + ;
1799:                             EscaparSQL(ALLTRIM(cursor_4c_LpreI.Cpros)), ;
1800:                             "cursor_4c_LproPro")
1801:                         IF loc_nRetPro > 0 AND !EOF("cursor_4c_LproPro")
1802:                             loc_nPVens   = cursor_4c_LproPro.PVens
1803:                             loc_nPrecoDe = cursor_4c_LproPro.PrecoDe
1804:                         ENDIF
1805:                         IF USED("cursor_4c_LproPro")
1806:                             USE IN cursor_4c_LproPro
1807:                         ENDIF
1808:                     ENDIF
1809: 
1810:                     INSERT INTO dbImpressao ;
1811:                         (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
1812:                     VALUES ;
1813:                         (cursor_4c_LpreI.Cpros, cursor_4c_LpreI.DPros, 1, 1, ;
1814:                          PADR(par_cLPreco, 10), loc_nPVens, ;

*-- Linhas 1831 a 2094:
1831: 
1832:         CATCH TO loc_oErro
1833:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1834:                     " PROC=" + loc_oErro.Procedure, ;
1835:                     "Erro FormSigPrEtq.CarregarItensListaPreco")
1836:         ENDTRY
1837: 
1838:         RETURN loc_lSucesso
1839:     ENDPROC
1840: 
1841:     *--------------------------------------------------------------------------
1842:     * TxtEmpsKeyPress - KeyPress do campo Empresa
1843:     *--------------------------------------------------------------------------
1844:     PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1845:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1846:             RETURN
1847:         ENDIF
1848:         THIS.AbrirBuscaEmps()
1849:     ENDPROC
1850: 
1851:     *--------------------------------------------------------------------------
1852:     * AbrirBuscaEmps - Lookup Empresa (SigCdEmp -> Cemps + Razas)
1853:     *--------------------------------------------------------------------------
1854:     PROTECTED PROCEDURE AbrirBuscaEmps()
1855:         LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet
1856: 
1857:         loc_lSucesso  = .F.
1858:         loc_lEncontrado = .F.
1859: 
1860:         TRY
1861:             loc_cValor = ALLTRIM(THIS.txt_4c_Emps.Value)
1862: 
1863:             *-- Tenta match exato
1864:             IF !EMPTY(loc_cValor)
1865:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1866:                     "SELECT TOP 1 RTRIM(Cemps) AS Cemps FROM SigCdEmp " + ;
1867:                     "WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cValor), ;
1868:                     "cursor_4c_ChkEmp")
1869:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkEmp")
1870:                     THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_ChkEmp.Cemps)
1871:                     loc_lEncontrado = .T.
1872:                 ENDIF
1873:                 IF USED("cursor_4c_ChkEmp")
1874:                     USE IN cursor_4c_ChkEmp
1875:                 ENDIF
1876:             ENDIF
1877: 
1878:             *-- Abre picker se nao encontrou match exato
1879:             IF !loc_lEncontrado
1880:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1881:                     "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
1882:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")
1883:                 IF VARTYPE(loc_oLookup) = "O"
1884:                     loc_oLookup.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1885:                     loc_oLookup.mAddColuna("Razas", "", "Empresa")
1886:                     loc_oLookup.Show()
1887:                     IF loc_oLookup.this_lSelecionou
1888:                         THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1889:                     ENDIF
1890:                     IF USED("cursor_4c_BuscaEmp")
1891:                         USE IN cursor_4c_BuscaEmp
1892:                     ENDIF
1893:                 ENDIF
1894:             ENDIF
1895: 
1896:             loc_lSucesso = .T.
1897: 
1898:         CATCH TO loc_oErro
1899:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1900:                     " PROC=" + loc_oErro.Procedure, ;
1901:                     "Erro FormSigPrEtq.AbrirBuscaEmps")
1902:         ENDTRY
1903: 
1904:         RETURN loc_lSucesso
1905:     ENDPROC
1906: 
1907:     *--------------------------------------------------------------------------
1908:     * TxtDopesKeyPress - KeyPress do campo Operacao
1909:     *--------------------------------------------------------------------------
1910:     PROCEDURE TxtDopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1911:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1912:             RETURN
1913:         ENDIF
1914:         THIS.AbrirBuscaDopes()
1915:     ENDPROC
1916: 
1917:     *--------------------------------------------------------------------------
1918:     * AbrirBuscaDopes - Lookup Operacao (SigCdOpe - single-column: Dopes = PK+descricao)
1919:     *--------------------------------------------------------------------------
1920:     PROTECTED PROCEDURE AbrirBuscaDopes()
1921:         LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet
1922: 
1923:         loc_lSucesso  = .F.
1924:         loc_lEncontrado = .F.
1925: 
1926:         TRY
1927:             loc_cValor = ALLTRIM(THIS.txt_4c_Dopes.Value)
1928: 
1929:             *-- Tenta match exato
1930:             IF !EMPTY(loc_cValor)
1931:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1932:                     "SELECT TOP 1 RTRIM(Dopes) AS Dopes FROM SigCdOpe " + ;
1933:                     "WHERE RTRIM(Dopes) = " + EscaparSQL(loc_cValor), ;
1934:                     "cursor_4c_ChkOpe")
1935:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkOpe")
1936:                     THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ChkOpe.Dopes)
1937:                     loc_lEncontrado = .T.
1938:                 ENDIF
1939:                 IF USED("cursor_4c_ChkOpe")
1940:                     USE IN cursor_4c_ChkOpe
1941:                 ENDIF
1942:             ENDIF
1943: 
1944:             *-- Abre picker (SigCdOpe: Dopes eh PK e descricao - coluna unica)
1945:             IF !loc_lEncontrado
1946:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
1947:                     "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
1948:                     "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
1949:                 IF VARTYPE(loc_oLookup) = "O"
1950:                     loc_oLookup.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1951:                     loc_oLookup.Show()
1952:                     IF loc_oLookup.this_lSelecionou
1953:                         THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1954:                     ENDIF
1955:                     IF USED("cursor_4c_BuscaOpe")
1956:                         USE IN cursor_4c_BuscaOpe
1957:                     ENDIF
1958:                 ENDIF
1959:             ENDIF
1960: 
1961:             loc_lSucesso = .T.
1962: 
1963:         CATCH TO loc_oErro
1964:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1965:                     " PROC=" + loc_oErro.Procedure, ;
1966:                     "Erro FormSigPrEtq.AbrirBuscaDopes")
1967:         ENDTRY
1968: 
1969:         RETURN loc_lSucesso
1970:     ENDPROC
1971: 
1972:     *--------------------------------------------------------------------------
1973:     * CarregarImpressoras - Popula cursor_4c_ImpreV com impressoras do sistema
1974:     * e configura cbo_4c_Get_Printer
1975:     *--------------------------------------------------------------------------
1976:     PROTECTED PROCEDURE CarregarImpressoras()
1977:         LOCAL loc_oErro, loc_nTotal, loc_nI, la_4c_Printers
1978: 
1979:         TRY
1980:             IF USED("cursor_4c_ImpreV")
1981:                 USE IN cursor_4c_ImpreV
1982:             ENDIF
1983: 
1984:             SET NULL ON
1985:             CREATE CURSOR cursor_4c_ImpreV (impresS C(100) NULL)
1986:             SET NULL OFF
1987: 
1988:             DIMENSION la_4c_Printers(1, 3)
1989:             loc_nTotal = APRINTERS(la_4c_Printers)
1990: 
1991:             IF loc_nTotal > 0
1992:                 FOR loc_nI = 1 TO loc_nTotal
1993:                     INSERT INTO cursor_4c_ImpreV VALUES (la_4c_Printers[loc_nI, 1])
1994:                 ENDFOR
1995:             ENDIF
1996: 
1997:             IF RECCOUNT("cursor_4c_ImpreV") = 0
1998:                 INSERT INTO cursor_4c_ImpreV VALUES ("Impressora Padr" + CHR(227) + "o")
1999:             ENDIF
2000: 
2001:             GO TOP IN cursor_4c_ImpreV
2002: 
2003:             THIS.cbo_4c_Get_Printer.RowSourceType = 2
2004:             THIS.cbo_4c_Get_Printer.RowSource     = "cursor_4c_ImpreV"
2005:             THIS.cbo_4c_Get_Printer.BoundColumn   = 1
2006:             THIS.cbo_4c_Get_Printer.BoundTo       = .F.
2007:             THIS.cbo_4c_Get_Printer.Refresh()
2008: 
2009:         CATCH TO loc_oErro
2010:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2011:                     " PROC=" + loc_oErro.Procedure, ;
2012:                     "Erro FormSigPrEtq.CarregarImpressoras")
2013:         ENDTRY
2014:     ENDPROC
2015: 
2016:     *--------------------------------------------------------------------------
2017:     * CboGetPrinterInteractiveChange - Ao mudar impressora, resetar ajustes
2018:     *--------------------------------------------------------------------------
2019:     PROCEDURE CboGetPrinterInteractiveChange()
2020:         WITH THIS.cnt_4c__Impressora
2021:             .obj_4c_Spn_AjVerts.Value = 0
2022:             .obj_4c_Spn_AjHorzs.Value = 0
2023:             .obj_4c_Spn_AjDenss.Value = 20
2024:             .obj_4c_Spn_AjVelos.Value = 3
2025:             .Visible     = .T.
2026:         ENDWITH
2027:     ENDPROC
2028: 
2029:     *--------------------------------------------------------------------------
2030:     * GrdDadosAfterRowColChange - Valida coluna anterior ao mudar coluna no grid
2031:     * par_nColIndex = nova coluna; this_nColAnt = coluna anterior
2032:     *--------------------------------------------------------------------------
2033:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2034: 
2035:         DO CASE
2036:         CASE THIS.this_nColAnt = 1
2037:             THIS.ValidarCpros()
2038:         CASE THIS.this_nColAnt = 4
2039:             THIS.ValidarReffs()
2040:         CASE THIS.this_nColAnt = 2
2041:             THIS.ValidarDpros()
2042:         CASE THIS.this_nColAnt = 3
2043:             THIS.ValidarQtds()
2044:         ENDCASE
2045: 
2046:         THIS.this_nColAnt = par_nColIndex
2047:         THIS.AtualizarEstadoColunas()
2048:     ENDPROC
2049: 
2050:     *--------------------------------------------------------------------------
2051:     * ValidarCpros - Valida/lookup do campo Produto (Column1) no grid
2052:     * Tenta EAN13, depois CPros exato, senao abre FormBuscaAuxiliar
2053:     *--------------------------------------------------------------------------
2054:     PROCEDURE ValidarCpros()
2055:         LOCAL loc_oErro, loc_cProd, loc_nCod, loc_nRet, loc_lSucesso, loc_oBusca
2056: 
2057:         loc_lSucesso = .F.
2058: 
2059:         TRY
2060:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2061:                 RETURN
2062:             ENDIF
2063: 
2064:             loc_cProd = ALLTRIM(NVL(dbImpressao.Cpros, ""))
2065: 
2066:             *-- Campo vazio: limpar descricao
2067:             IF EMPTY(loc_cProd)
2068:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
2069:                 THIS.grd_4c_Dados.Refresh()
2070:                 RETURN
2071:             ENDIF
2072: 
2073:             *-- 1. Tentar match por EAN13 (numerico inteiro)
2074:             loc_nCod = INT(VAL(loc_cProd))
2075:             IF loc_nCod > 0
2076:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2077:                     "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2078:                     "PVens, PrecoDe FROM SigCdPro " + ;
2079:                     "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod), ;
2080:                     "cursor_4c_PrEan")
2081:                 IF loc_nRet > 0 AND !EOF("cursor_4c_PrEan")
2082:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrEan.Cpros), 14)
2083:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_PrEan.DPros), 40)
2084:                     dbImpressao.PVens   = cursor_4c_PrEan.PVens
2085:                     dbImpressao.PrecoDe = cursor_4c_PrEan.PrecoDe
2086:                     THIS.grd_4c_Dados.Refresh()
2087:                     IF USED("cursor_4c_PrEan")
2088:                         USE IN cursor_4c_PrEan
2089:                     ENDIF
2090:                     RETURN
2091:                 ENDIF
2092:                 IF USED("cursor_4c_PrEan")
2093:                     USE IN cursor_4c_PrEan
2094:                 ENDIF

*-- Linhas 2115 a 2712:
2115:             ENDIF
2116: 
2117:             *-- 3. Nao encontrado: abrir picker de produto
2118:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2119:                 "cursor_4c_BuscaPro", "CPros", loc_cProd, ;
2120:                 "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
2121:             IF VARTYPE(loc_oBusca) = "O"
2122:                 loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2123:                 loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2124:                 loc_oBusca.Show()
2125:                 IF loc_oBusca.this_lSelecionou
2126:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaPro.CPros), 14)
2127:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaPro.DPros), 40)
2128:                 ENDIF
2129:                 IF USED("cursor_4c_BuscaPro")
2130:                     USE IN cursor_4c_BuscaPro
2131:                 ENDIF
2132:                 loc_oBusca.Release()
2133:             ENDIF
2134: 
2135:             THIS.grd_4c_Dados.Refresh()
2136:             loc_lSucesso = .T.
2137: 
2138:         CATCH TO loc_oErro
2139:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2140:                     " PROC=" + loc_oErro.Procedure, ;
2141:                     "Erro FormSigPrEtq.ValidarCpros")
2142:         ENDTRY
2143: 
2144:         RETURN loc_lSucesso
2145:     ENDPROC
2146: 
2147:     *--------------------------------------------------------------------------
2148:     * ValidarDpros - Valida/lookup do campo Descricao (Column2) no grid
2149:     * Tenta match exato por DPros; senao abre FormBuscaAuxiliar
2150:     *--------------------------------------------------------------------------
2151:     PROCEDURE ValidarDpros()
2152:         LOCAL loc_oErro, loc_cDesc, loc_nRet, loc_lSucesso, loc_oBusca
2153: 
2154:         loc_lSucesso = .F.
2155: 
2156:         TRY
2157:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2158:                 RETURN
2159:             ENDIF
2160: 
2161:             loc_cDesc = ALLTRIM(NVL(dbImpressao.DPros, ""))
2162: 
2163:             *-- Campo vazio: limpar cpros
2164:             IF EMPTY(loc_cDesc)
2165:                 dbImpressao.Cpros = SPACE(14)
2166:                 THIS.grd_4c_Dados.Refresh()
2167:                 RETURN
2168:             ENDIF
2169: 
2170:             *-- Tentar match por DPros
2171:             loc_nRet = SQLEXEC(gnConnHandle, ;
2172:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros " + ;
2173:                 "FROM SigCdPro WHERE RTRIM(DPros) = " + EscaparSQL(loc_cDesc), ;
2174:                 "cursor_4c_PrDp")
2175:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrDp")
2176:                 dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrDp.Cpros), 14)
2177:                 THIS.grd_4c_Dados.Refresh()
2178:                 IF USED("cursor_4c_PrDp")
2179:                     USE IN cursor_4c_PrDp
2180:                 ENDIF
2181:                 RETURN
2182:             ENDIF
2183:             IF USED("cursor_4c_PrDp")
2184:                 USE IN cursor_4c_PrDp
2185:             ENDIF
2186: 
2187:             *-- Nao encontrado: abrir picker por descricao
2188:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2189:                 "cursor_4c_BuscaProD", "DPros", loc_cDesc, ;
2190:                 "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
2191:             IF VARTYPE(loc_oBusca) = "O"
2192:                 loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2193:                 loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2194:                 loc_oBusca.Show()
2195:                 IF loc_oBusca.this_lSelecionou
2196:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaProD.CPros), 14)
2197:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaProD.DPros), 40)
2198:                 ENDIF
2199:                 IF USED("cursor_4c_BuscaProD")
2200:                     USE IN cursor_4c_BuscaProD
2201:                 ENDIF
2202:                 loc_oBusca.Release()
2203:             ENDIF
2204: 
2205:             THIS.grd_4c_Dados.Refresh()
2206:             loc_lSucesso = .T.
2207: 
2208:         CATCH TO loc_oErro
2209:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2210:                     " PROC=" + loc_oErro.Procedure, ;
2211:                     "Erro FormSigPrEtq.ValidarDpros")
2212:         ENDTRY
2213: 
2214:         RETURN loc_lSucesso
2215:     ENDPROC
2216: 
2217:     *--------------------------------------------------------------------------
2218:     * ValidarReffs - Valida/lookup do campo Ref.Fornecedor (Column4) no grid
2219:     * Busca em SigCdPro por Dpro2s; preenche cpros+dpros+precos se achar
2220:     *--------------------------------------------------------------------------
2221:     PROCEDURE ValidarReffs()
2222:         LOCAL loc_oErro, loc_cReff, loc_nRet, loc_lSucesso, loc_oBusca
2223: 
2224:         loc_lSucesso = .F.
2225: 
2226:         TRY
2227:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2228:                 RETURN
2229:             ENDIF
2230: 
2231:             loc_cReff = ALLTRIM(NVL(dbImpressao.Reffs, ""))
2232: 
2233:             IF EMPTY(loc_cReff)
2234:                 RETURN
2235:             ENDIF
2236: 
2237:             *-- Tentar match por Dpro2s (referencia do fornecedor)
2238:             loc_nRet = SQLEXEC(gnConnHandle, ;
2239:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2240:                 "RTRIM(DPro2s) AS DPro2s, PVens, PrecoDe " + ;
2241:                 "FROM SigCdPro WHERE RTRIM(DPro2s) = " + EscaparSQL(loc_cReff), ;
2242:                 "cursor_4c_PrRff")
2243:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrRff")
2244:                 dbImpressao.Cpros   = PADR(ALLTRIM(cursor_4c_PrRff.Cpros), 14)
2245:                 dbImpressao.DPros   = PADR(ALLTRIM(cursor_4c_PrRff.DPros), 40)
2246:                 dbImpressao.PVens   = cursor_4c_PrRff.PVens
2247:                 dbImpressao.PrecoDe = cursor_4c_PrRff.PrecoDe
2248:                 THIS.grd_4c_Dados.Refresh()
2249:                 IF USED("cursor_4c_PrRff")
2250:                     USE IN cursor_4c_PrRff
2251:                 ENDIF
2252:                 RETURN
2253:             ENDIF
2254:             IF USED("cursor_4c_PrRff")
2255:                 USE IN cursor_4c_PrRff
2256:             ENDIF
2257: 
2258:             *-- Nao encontrado: abrir picker por Dpro2s
2259:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2260:                 "cursor_4c_BuscaRff", "DPro2s", loc_cReff, ;
2261:                 "Sele" + CHR(231) + CHR(227) + "o por Refer" + CHR(234) + "ncia", .T., .T., "")
2262:             IF VARTYPE(loc_oBusca) = "O"
2263:                 loc_oBusca.mAddColuna("DPro2s", "", "Refer" + CHR(234) + "ncia")
2264:                 loc_oBusca.mAddColuna("CPros",  "", "C" + CHR(243) + "digo")
2265:                 loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
2266:                 loc_oBusca.Show()
2267:                 IF loc_oBusca.this_lSelecionou
2268:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaRff.CPros),  14)
2269:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaRff.DPros),  40)
2270:                     dbImpressao.Reffs = PADR(ALLTRIM(cursor_4c_BuscaRff.DPro2s), 40)
2271:                 ENDIF
2272:                 IF USED("cursor_4c_BuscaRff")
2273:                     USE IN cursor_4c_BuscaRff
2274:                 ENDIF
2275:                 loc_oBusca.Release()
2276:             ENDIF
2277: 
2278:             THIS.grd_4c_Dados.Refresh()
2279:             loc_lSucesso = .T.
2280: 
2281:         CATCH TO loc_oErro
2282:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2283:                     " PROC=" + loc_oErro.Procedure, ;
2284:                     "Erro FormSigPrEtq.ValidarReffs")
2285:         ENDTRY
2286: 
2287:         RETURN loc_lSucesso
2288:     ENDPROC
2289: 
2290:     *--------------------------------------------------------------------------
2291:     * ValidarQtds - Valida campo Quantidade (Column3) no grid
2292:     * Confirma produto valido, define QtdeEtiq e move para proxima linha
2293:     *--------------------------------------------------------------------------
2294:     PROCEDURE ValidarQtds()
2295:         LOCAL loc_oErro, loc_nQtd, loc_cProd, loc_nRet, loc_lSucesso
2296: 
2297:         loc_lSucesso = .F.
2298: 
2299:         TRY
2300:             IF !USED("dbImpressao") OR EOF("dbImpressao")
2301:                 RETURN
2302:             ENDIF
2303: 
2304:             loc_nQtd  = NVL(dbImpressao.Qtds, 0)
2305:             loc_cProd = ALLTRIM(PADR(NVL(dbImpressao.Cpros, ""), 14))
2306: 
2307:             IF EMPTY(loc_cProd)
2308:                 RETURN
2309:             ENDIF
2310: 
2311:             *-- Validar produto existe em SigCdPro
2312:             loc_nRet = SQLEXEC(gnConnHandle, ;
2313:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros FROM SigCdPro " + ;
2314:                 "WHERE RTRIM(CPros) = " + EscaparSQL(loc_cProd), ;
2315:                 "cursor_4c_PrQt")
2316:             IF loc_nRet <= 0 OR EOF("cursor_4c_PrQt")
2317:                 MsgAviso("Produto Inv" + CHR(225) + "lido!!!")
2318:                 IF USED("cursor_4c_PrQt")
2319:                     USE IN cursor_4c_PrQt
2320:                 ENDIF
2321:                 RETURN
2322:             ENDIF
2323:             IF USED("cursor_4c_PrQt")
2324:                 USE IN cursor_4c_PrQt
2325:             ENDIF
2326: 
2327:             *-- Definir quantidade de etiquetas igual a qtds (se maior que 0)
2328:             IF loc_nQtd > 0
2329:                 dbImpressao.QtdeEtiq = loc_nQtd
2330:             ENDIF
2331: 
2332:             THIS.grd_4c_Dados.Refresh()
2333: 
2334:             *-- Avancar para proxima linha (ENTER = nova linha no grid)
2335:             SELECT dbImpressao
2336:             IF !EOF()
2337:                 SKIP
2338:                 IF EOF()
2339:                     APPEND BLANK
2340:                 ENDIF
2341:             ENDIF
2342: 
2343:             THIS.grd_4c_Dados.Refresh()
2344:             THIS.grd_4c_Dados.SetFocus
2345: 
2346:             loc_lSucesso = .T.
2347: 
2348:         CATCH TO loc_oErro
2349:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2350:                     " PROC=" + loc_oErro.Procedure, ;
2351:                     "Erro FormSigPrEtq.ValidarQtds")
2352:         ENDTRY
2353: 
2354:         RETURN loc_lSucesso
2355:     ENDPROC
2356: 
2357:     *--------------------------------------------------------------------------
2358:     * OptPrecoInteractiveChange - Ao mudar opcao de Preco, atualiza Parcelas
2359:     * Original: col_par.Text1.When = (ThisForm.opt_Preco.Value = 6)
2360:     *--------------------------------------------------------------------------
2361:     PROCEDURE OptPrecoInteractiveChange()
2362:         THIS.AtualizarEstadoColunas()
2363:     ENDPROC
2364: 
2365:     *--------------------------------------------------------------------------
2366:     * AtualizarEstadoColunas - Controla editabilidade das colunas do grid
2367:     * Replica comportamento dos When events do original SIGPRETQ:
2368:     *   col_cpros/dpros/DPro2s: editavel somente em linha nova (Cpros vazio)
2369:     *   col_par (Parcelas): editavel somente com Preco = Parcelamento (Value=6)
2370:     *--------------------------------------------------------------------------
2371:     PROCEDURE AtualizarEstadoColunas()
2372:         LOCAL loc_lNovaLinha, loc_lParcelamento
2373: 
2374:         IF !USED("dbImpressao") OR EOF("dbImpressao")
2375:             RETURN
2376:         ENDIF
2377: 
2378:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
2379:             RETURN
2380:         ENDIF
2381: 
2382:         loc_lNovaLinha    = EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2383:         loc_lParcelamento = (THIS.obj_4c_Opt_Preco.Value = 6)
2384: 
2385:         THIS.grd_4c_Dados.col_4c_cpros.ReadOnly  = !loc_lNovaLinha
2386:         THIS.grd_4c_Dados.col_4c_dpros.ReadOnly  = !loc_lNovaLinha
2387:         THIS.grd_4c_Dados.col_4c_DPro2s.ReadOnly = !loc_lNovaLinha
2388:         THIS.grd_4c_Dados.col_4c_par.ReadOnly    = !loc_lParcelamento
2389:     ENDPROC
2390: 
2391:     *--------------------------------------------------------------------------
2392:     * BtnIncluirClick - Inclui linha em branco na grade dbImpressao para
2393:     * entrada manual de um novo produto (equivalente operacional a "novo item").
2394:     * Reposiciona o cursor na nova linha e devolve o foco ao grid.
2395:     *--------------------------------------------------------------------------
2396:     PROCEDURE BtnIncluirClick()
2397:         LOCAL loc_oErro
2398: 
2399:         TRY
2400:             IF !USED("dbImpressao")
2401:                 MsgAviso("A grade de impress" + CHR(227) + "o n" + CHR(227) + ;
2402:                          "o est" + CHR(225) + " dispon" + CHR(237) + "vel!!!")
2403:                 RETURN
2404:             ENDIF
2405: 
2406:             SELECT dbImpressao
2407:             SET ORDER TO
2408: 
2409:             *-- Se a grade tem apenas uma linha em branco padrao, reusa-a
2410:             IF RECCOUNT("dbImpressao") = 1 AND EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2411:                 GO TOP IN dbImpressao
2412:             ELSE
2413:                 APPEND BLANK IN dbImpressao
2414:                 *-- Posiciona na ultima linha (a que acabou de ser criada)
2415:                 SELECT dbImpressao
2416:                 GO BOTTOM IN dbImpressao
2417:             ENDIF
2418: 
2419:             THIS.grd_4c_Dados.Refresh()
2420:             THIS.AtualizarEstadoColunas()
2421: 
2422:             *-- Foca a coluna de produto para digitacao imediata
2423:             IF PEMSTATUS(THIS.grd_4c_Dados, "col_4c_cpros", 5)
2424:                 THIS.grd_4c_Dados.SetFocus()
2425:                 THIS.grd_4c_Dados.ActivateCell( ;
2426:                     RECNO("dbImpressao"), 1)
2427:             ENDIF
2428: 
2429:         CATCH TO loc_oErro
2430:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2431:                     " PROC=" + loc_oErro.Procedure, ;
2432:                     "Erro FormSigPrEtq.BtnIncluirClick")
2433:         ENDTRY
2434:     ENDPROC
2435: 
2436:     *--------------------------------------------------------------------------
2437:     * BtnAlterarClick - Ativa edicao da linha corrente do grid, permitindo
2438:     * ajustar quantidade/etiquetas do item selecionado.
2439:     * Foca a coluna Qtds e destrava colunas quando aplicavel.
2440:     *--------------------------------------------------------------------------
2441:     PROCEDURE BtnAlterarClick()
2442:         LOCAL loc_oErro, loc_nRecno
2443: 
2444:         TRY
2445:             IF !USED("dbImpressao") OR RECCOUNT("dbImpressao") = 0
2446:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens na grade para alterar!!!")
2447:                 RETURN
2448:             ENDIF
2449: 
2450:             SELECT dbImpressao
2451:             loc_nRecno = RECNO("dbImpressao")
2452: 
2453:             IF EOF("dbImpressao") OR EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2454:                 MsgAviso("Selecione um item na grade antes de alterar!!!")
2455:                 THIS.grd_4c_Dados.SetFocus()
2456:                 RETURN
2457:             ENDIF
2458: 
2459:             *-- Permite editar Parcelas se a modalidade Preco = Parcelamento (6)
2460:             IF THIS.obj_4c_Opt_Preco.Value = 6
2461:                 THIS.grd_4c_Dados.col_4c_par.ReadOnly = .F.
2462:             ENDIF
2463: 
2464:             THIS.grd_4c_Dados.Refresh()
2465: 
2466:             *-- Foca coluna de quantidade (indice 3: Cpros=1, DPros=2, Qtds=3)
2467:             THIS.grd_4c_Dados.SetFocus()
2468:             THIS.grd_4c_Dados.ActivateCell(loc_nRecno, 3)
2469: 
2470:         CATCH TO loc_oErro
2471:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2472:                     " PROC=" + loc_oErro.Procedure, ;
2473:                     "Erro FormSigPrEtq.BtnAlterarClick")
2474:         ENDTRY
2475:     ENDPROC
2476: 
2477:     *--------------------------------------------------------------------------
2478:     * BtnVisualizarClick - Exibe resumo dos itens carregados na grade antes
2479:     * da impressao (contagem total, distintos e quantidade agregada).
2480:     * Equivalente operacional a "visualizar antes de imprimir".
2481:     *--------------------------------------------------------------------------
2482:     PROCEDURE BtnVisualizarClick()
2483:         LOCAL loc_oErro, loc_nTotal, loc_nDistintos, loc_nQtdTotal, loc_cMsg
2484: 
2485:         TRY
2486:             IF !USED("dbImpressao") OR RECCOUNT("dbImpressao") = 0
2487:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens carregados na grade!!!")
2488:                 RETURN
2489:             ENDIF
2490: 
2491:             loc_nTotal    = 0
2492:             loc_nDistintos = 0
2493:             loc_nQtdTotal = 0
2494: 
2495:             *-- Conta itens validos (Cpros preenchido)
2496:             SELECT COUNT(*) AS nTot, ;
2497:                    COUNT(DISTINCT Cpros) AS nDist, ;
2498:                    SUM(NVL(QtdeEtiq, 0)) AS nQtd ;
2499:                 FROM dbImpressao ;
2500:                 WHERE !EMPTY(NVL(Cpros, "")) ;
2501:                 INTO CURSOR cursor_4c_TmpResumo
2502: 
2503:             IF USED("cursor_4c_TmpResumo") AND !EOF("cursor_4c_TmpResumo")
2504:                 loc_nTotal     = NVL(cursor_4c_TmpResumo.nTot,  0)
2505:                 loc_nDistintos = NVL(cursor_4c_TmpResumo.nDist, 0)
2506:                 loc_nQtdTotal  = NVL(cursor_4c_TmpResumo.nQtd,  0)
2507:             ENDIF
2508: 
2509:             IF USED("cursor_4c_TmpResumo")
2510:                 USE IN cursor_4c_TmpResumo
2511:             ENDIF
2512: 
2513:             IF loc_nTotal = 0
2514:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
2515:                          " itens v" + CHR(225) + "lidos para impress" + CHR(227) + "o!!!")
2516:                 RETURN
2517:             ENDIF
2518: 
2519:             loc_cMsg = "Resumo da Impress" + CHR(227) + "o de Etiquetas:" + CHR(13) + CHR(13) + ;
2520:                        "Itens na grade....: " + TRANSFORM(loc_nTotal)     + CHR(13) + ;
2521:                        "Produtos distintos: " + TRANSFORM(loc_nDistintos) + CHR(13) + ;
2522:                        "Etiquetas a imprimir: " + TRANSFORM(loc_nQtdTotal, "@R 999,999,999")
2523: 
2524:             MsgInfo(loc_cMsg, "Visualizar Impress" + CHR(227) + "o")
2525: 
2526:             SELECT dbImpressao
2527:             GO TOP IN dbImpressao
2528:             THIS.grd_4c_Dados.Refresh()
2529: 
2530:         CATCH TO loc_oErro
2531:             IF USED("cursor_4c_TmpResumo")
2532:                 USE IN cursor_4c_TmpResumo
2533:             ENDIF
2534:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2535:                     " PROC=" + loc_oErro.Procedure, ;
2536:                     "Erro FormSigPrEtq.BtnVisualizarClick")
2537:         ENDTRY
2538:     ENDPROC
2539: 
2540:     *--------------------------------------------------------------------------
2541:     * FormParaBO - Transfere parametros dos controles do form para o BO
2542:     * Chamado por BtnImprimeClick antes de ImprimirEtiquetas
2543:     *--------------------------------------------------------------------------
2544:     PROCEDURE FormParaBO()
2545:         LOCAL loc_nTipo, loc_oBO
2546: 
2547:         loc_oBO = THIS.this_oBusinessObject
2548: 
2549:         loc_oBO.this_nImpPreco     = THIS.obj_4c_Opt_Preco.Value
2550:         loc_oBO.this_lImpSepar     = (THIS.obj_4c_Opt_separador.Value = 1)
2551:         loc_oBO.this_lImpPeso      = (THIS.obj_4c_Opt_peso.Value = 1)
2552:         loc_oBO.this_lCompo        = (THIS.obj_4c_OptCompos.Value = 1)
2553: 
2554:         loc_nTipo = THIS.obj_4c_Opt_Tipo.Value
2555:         IF loc_nTipo >= 1 AND loc_nTipo <= THIS.obj_4c_Opt_Tipo.ButtonCount
2556:             loc_oBO.this_nTipo  = loc_nTipo
2557:             loc_oBO.this_nTpEti = INT(VAL(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipo).Tag))
2558:         ENDIF
2559: 
2560:         loc_oBO.this_nTpImp        = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value
2561:         loc_oBO.this_nAjVertsPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
2562:         loc_oBO.this_nAjHorzsPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
2563:         loc_oBO.this_nAjDensPrint  = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
2564:         loc_oBO.this_nAjVelosPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value
2565: 
2566:         IF USED("cursor_4c_ImpreV") AND !EOF("cursor_4c_ImpreV")
2567:             loc_oBO.this_cNomeImp = ALLTRIM(NVL(cursor_4c_ImpreV.impresS, ""))
2568:         ELSE
2569:             loc_oBO.this_cNomeImp = ""
2570:         ENDIF
2571: 
2572:         loc_oBO.this_cLp1   = ALLTRIM(THIS.txt_4c_Lpreco.Value)
2573:         loc_oBO.this_cLp2   = ALLTRIM(THIS.txt_4c_LPreco2.Value)
2574:         loc_oBO.this_nOrdem = THIS.obj_4c_OptOrdem.Value
2575:         loc_oBO.this_cDopes = ALLTRIM(THIS.txt_4c_Dopes.Value)
2576:         loc_oBO.this_nNumes = THIS.txt_4c_Numes.Value
2577:     ENDPROC
2578: 
2579:     *--------------------------------------------------------------------------
2580:     * BOParaForm - OPERACIONAL: BO nao carrega registros para edicao.
2581:     * Presente para padrao do pipeline; sem acao real neste form.
2582:     *--------------------------------------------------------------------------
2583:     PROTECTED PROCEDURE BOParaForm()
2584:         *-- OPERACIONAL: dados vem de SQL via BtnCarregarClick/CarregarItensListaPreco
2585:         *-- Nao ha "registro corrente" do BO para carregar nos controles
2586:         RETURN .T.
2587:     ENDPROC
2588: 
2589:     *--------------------------------------------------------------------------
2590:     * CarregarLista - Refresca a exibicao da grade dbImpressao
2591:     * OPERACIONAL: sem lista de cadastro; reposiciona e refresca o grid
2592:     *--------------------------------------------------------------------------
2593:     PROCEDURE CarregarLista()
2594:         IF USED("dbImpressao")
2595:             SELECT dbImpressao
2596:             IF RECCOUNT("dbImpressao") = 0
2597:                 APPEND BLANK IN dbImpressao
2598:             ENDIF
2599:             GO TOP IN dbImpressao
2600:         ENDIF
2601: 
2602:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2603:             THIS.grd_4c_Dados.Refresh()
2604:         ENDIF
2605:     ENDPROC
2606: 
2607:     *--------------------------------------------------------------------------
2608:     * LimparCampos - Limpa filtros de entrada e reseta grade dbImpressao
2609:     *--------------------------------------------------------------------------
2610:     PROCEDURE LimparCampos()
2611:         IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5)
2612:             THIS.txt_4c_Lpreco.Value  = ""
2613:         ENDIF
2614:         IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5)
2615:             THIS.txt_4c_LPreco2.Value = ""
2616:         ENDIF
2617:         IF PEMSTATUS(THIS, "txt_4c_Emps", 5)
2618:             THIS.txt_4c_Emps.Value    = ""
2619:         ENDIF
2620:         IF PEMSTATUS(THIS, "txt_4c_Dopes", 5)
2621:             THIS.txt_4c_Dopes.Value   = ""
2622:         ENDIF
2623:         IF PEMSTATUS(THIS, "txt_4c_Numes", 5)
2624:             THIS.txt_4c_Numes.Value   = 0
2625:         ENDIF
2626: 
2627:         IF USED("dbImpressao")
2628:             ZAP IN dbImpressao
2629:             APPEND BLANK IN dbImpressao
2630:             GO TOP IN dbImpressao
2631:         ENDIF
2632: 
2633:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2634:             THIS.grd_4c_Dados.Refresh()
2635:         ENDIF
2636:     ENDPROC
2637: 
2638:     *--------------------------------------------------------------------------
2639:     * HabilitarCampos - Habilita controles de entrada
2640:     * OPERACIONAL: campos sempre habilitados (sem modos INCLUIR/ALTERAR)
2641:     *--------------------------------------------------------------------------
2642:     PROCEDURE HabilitarCampos()
2643:         IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5)
2644:             THIS.txt_4c_Lpreco.Enabled = .T.
2645:         ENDIF
2646:         IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5)
2647:             THIS.txt_4c_LPreco2.Enabled = .T.
2648:         ENDIF
2649:         IF PEMSTATUS(THIS, "txt_4c_Emps", 5)
2650:             THIS.txt_4c_Emps.Enabled = .T.
2651:         ENDIF
2652:         IF PEMSTATUS(THIS, "txt_4c_Dopes", 5)
2653:             THIS.txt_4c_Dopes.Enabled = .T.
2654:         ENDIF
2655:         IF PEMSTATUS(THIS, "txt_4c_Numes", 5)
2656:             THIS.txt_4c_Numes.Enabled = .T.
2657:         ENDIF
2658:         IF PEMSTATUS(THIS, "chk_4c_ChkLista", 5)
2659:             THIS.chk_4c_ChkLista.Enabled = .T.
2660:         ENDIF
2661:         IF PEMSTATUS(THIS, "chk_4c_ChkOperacoes", 5)
2662:             THIS.chk_4c_ChkOperacoes.Enabled = .T.
2663:         ENDIF
2664:         IF PEMSTATUS(THIS, "cmd_4c_BtnCarregar", 5)
2665:         ENDIF
2666:         IF PEMSTATUS(THIS, "cmd_4c_Btnexcluir", 5)
2667:         ENDIF
2668:     ENDPROC
2669: 
2670:     *--------------------------------------------------------------------------
2671:     * AjustarBotoesPorModo - OPERACIONAL: sem modos CRUD; no-op
2672:     *--------------------------------------------------------------------------
2673:     PROCEDURE AjustarBotoesPorModo()
2674:         *-- OPERACIONAL nao tem modos INCLUIR/ALTERAR/VISUALIZAR
2675:         *-- Botoes sao fixos: Carregar, Excluir, Imprimir, Sair
2676:         RETURN .T.
2677:     ENDPROC
2678: 
2679:     *--------------------------------------------------------------------------
2680:     * BtnEncerrarClick - Fecha o formulario (alias canonico para BtnSairClick)
2681:     *--------------------------------------------------------------------------
2682:     PROCEDURE BtnEncerrarClick()
2683:         THIS.Release()
2684:     ENDPROC
2685: 
2686:     *--------------------------------------------------------------------------
2687:     * BtnBuscarClick - Equivalente operacional de "Buscar": carrega itens
2688:     * da movimentacao para a grade (delega a BtnCarregarClick)
2689:     *--------------------------------------------------------------------------
2690:     PROCEDURE BtnBuscarClick()
2691:         THIS.BtnCarregarClick()
2692:     ENDPROC
2693: 
2694:     *--------------------------------------------------------------------------
2695:     * BtnSalvarClick - Equivalente operacional de "Salvar": confirma impressao
2696:     * (delega a BtnImprimeClick para compatibilidade com pipeline)
2697:     *--------------------------------------------------------------------------
2698:     PROCEDURE BtnSalvarClick()
2699:         THIS.BtnImprimeClick()
2700:     ENDPROC
2701: 
2702:     *--------------------------------------------------------------------------
2703:     * BtnCancelarClick - Equivalente operacional de "Cancelar": limpa campos
2704:     * e reseta a grade sem fechar o formulario
2705:     *--------------------------------------------------------------------------
2706:     PROCEDURE BtnCancelarClick()
2707:         IF MsgConfirma("Limpar campos e reiniciar a grade?")
2708:             THIS.LimparCampos()
2709:         ENDIF
2710:     ENDPROC
2711: 
2712: ENDDEFINE


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

