# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.AtualizarLinhaGrid()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirBuscaConta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirBuscaCpf()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AtualizarTotaisNaTela()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.EncerrarClick()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormPzo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1932 linhas total):

*-- Linhas 9 a 169:
9: *   Cursores necessarios no pai: TprMvCab, CrSigCdOpe, CrSigMvNfi, crTpmMvItn, TprMvCabG
10: *
11: * Fluxo:
12: *   Init armazena referencia ao pai -> DODEFAULT() chama InicializarForm
13: *   InicializarForm cria BO, inicializa CsPrazE e constroi interface plana
14: *   EncerrarClick valida prazos/fretes via BO.Confirmar() e fecha o form
15: *==============================================================================
16: 
17: DEFINE CLASS FormPzo AS FormBase
18: 
19:     *-- Propriedades visuais (pixel-perfect SCX original - PILAR 1)
20:     Width        = 1000
21:     Height       = 600
22:     AutoCenter   = .T.
23:     Caption      = "Prazo / Conta de Entrega"
24:     ShowWindow   = 1
25:     WindowType   = 1
26:     ControlBox   = .F.
27:     Closable     = .F.
28:     MaxButton    = .F.
29:     MinButton    = .F.
30:     TitleBar     = 0
31:     Movable      = .F.
32:     ClipControls = .F.
33:     KeyPreview   = .T.
34:     Themes       = .F.
35:     BorderStyle  = 2
36:     DataSession  = 1
37: 
38:     *-- Referencia ao form pai e BO
39:     this_oFormPai        = .NULL.
40:     this_oBusinessObject = .NULL.
41: 
42:     *==========================================================================
43:     * Init - Armazena referencia ao form pai antes de DODEFAULT
44:     *==========================================================================
45:     PROCEDURE Init(par_oFormPai)
46:         LOCAL loc_lResultado
47:         loc_lResultado = .F.
48: 
49:         IF VARTYPE(par_oFormPai) = "O"
50:             THIS.this_oFormPai = par_oFormPai
51:         ENDIF
52: 
53:         loc_lResultado = DODEFAULT()
54:         RETURN loc_lResultado
55:     ENDPROC
56: 
57:     *==========================================================================
58:     * InicializarForm - Cria BO, inicializa CsPrazE e constroi interface
59:     *==========================================================================
60:     PROTECTED PROCEDURE InicializarForm()
61:         LOCAL loc_lSucesso, loc_oErro
62:         loc_lSucesso = .F.
63: 
64:         TRY
65:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
66: 
67:             *-- Instanciar Business Object
68:             THIS.this_oBusinessObject = CREATEOBJECT("PzoBO")
69:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
70:                 MsgErro("Erro ao criar PzoBO. VARTYPE retornou: " + ;
71:                         VARTYPE(THIS.this_oBusinessObject), "FormPzo.InicializarForm")
72:             ELSE
73:                 *-- Obter modo de edicao do form pai
74:                 IF VARTYPE(THIS.this_oFormPai) = "O"
75:                     IF VARTYPE(THIS.this_oFormPai.this_cModoAtual) = "C" AND ;
76:                        !EMPTY(THIS.this_oFormPai.this_cModoAtual)
77:                         THIS.this_oBusinessObject.this_cEscolha = ;
78:                             THIS.this_oFormPai.this_cModoAtual
79:                     ENDIF
80:                 ENDIF
81: 
82:                 *-- Inicializar dados via BO (cria CsPrazE e demais cursores auxiliares)
83:                 IF THIS.this_oBusinessObject.InicializarDados(THIS.this_oFormPai)
84: 
85:                     *-- Indexar TprMvCabG por Abrevs para os SEEKs na navegacao
86:                     IF USED("TprMvCabG")
87:                         SELECT TprMvCabG
88:                         INDEX ON Abrevs TAG Abrevs
89:                     ENDIF
90: 
91:                     *-- Construir interface plana (sem PageFrame)
92:                     THIS.ConfigurarCabecalho()
93:                     THIS.ConfigurarPaginaLista()
94:                     THIS.ConfigurarBotaoEncerrar()
95:                     THIS.BindEventos()
96: 
97:                     *-- Atualizar totais iniciais na tela (usando totais da NF do pai)
98:                     THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
99:                     THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
100:                     THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
101:                     THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
102:                     THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
103:                     THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado
104: 
105:                     *-- Posicionar na primeira linha e atualizar containers
106:                     IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
107:                         SELECT CsPrazE
108:                         GO TOP
109:                         THIS.AtualizarLinhaGrid(1)
110:                     ENDIF
111: 
112:                     loc_lSucesso = .T.
113:                 ENDIF
114:             ENDIF
115: 
116:         CATCH TO loc_oErro
117:             MsgErro(loc_oErro.Message + CHR(13) + ;
118:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
119:                     "Procedure: " + loc_oErro.Procedure, ;
120:                     "Erro em FormPzo.InicializarForm")
121:         ENDTRY
122: 
123:         RETURN loc_lSucesso
124:     ENDPROC
125: 
126:     *==========================================================================
127:     * ConfigurarCabecalho - Container escuro com titulo do form
128:     *==========================================================================
129:     PROTECTED PROCEDURE ConfigurarCabecalho()
130:         LOCAL loc_oCnt
131:         THIS.AddObject("cnt_4c_Sombra", "Container")
132:         loc_oCnt = THIS.cnt_4c_Sombra
133:         WITH loc_oCnt
134:             .Top         = 0
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BorderWidth = 0
139:             .BackColor   = RGB(100, 100, 100)
140:             .Visible     = .T.
141:         ENDWITH
142:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
143:         WITH loc_oCnt.lbl_4c_Sombra
144:             .FontBold      = .T.
145:             .FontName      = "Tahoma"
146:             .FontSize      = 18
147:             .FontUnderline = .F.
148:             .WordWrap      = .T.
149:             .Alignment     = 0
150:             .BackStyle     = 0
151:             .AutoSize      = .F.
152:             .Caption       = "Prazo / Conta de Entrega"
153:             .Height        = 40
154:             .Left          = 10
155:             .Top           = 18
156:             .Width         = 769
157:             .ForeColor     = RGB(0, 0, 0)
158:             .Visible       = .T.
159:         ENDWITH
160:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
161:         WITH loc_oCnt.lbl_4c_Titulo
162:             .FontBold   = .T.
163:             .FontName   = "Tahoma"
164:             .FontSize   = 18
165:             .WordWrap   = .T.
166:             .Alignment  = 0
167:             .BackStyle  = 0
168:             .AutoSize   = .F.
169:             .Caption    = "Prazo / Conta de Entrega"

*-- Linhas 179 a 274:
179:     *==========================================================================
180:     * ConfigurarPaginaLista - Orquestra lado LISTA: grid, entrega e binding
181:     *==========================================================================
182:     PROTECTED PROCEDURE ConfigurarPaginaLista()
183:         *-- 1. Grid de operacoes (estrutura de colunas)
184:         THIS.ConfigurarGrid()
185: 
186:         *-- 2. Campos suplementares/DADOS (totais + observacao)
187:         THIS.ConfigurarPaginaDados()
188: 
189:         *-- 3. Container de entrega (inicialmente oculto ate selecao de linha)
190:         THIS.ConfigurarContainerEntrega()
191: 
192:         *-- 4. Conectar grid ao cursor CsPrazE (RecordSource + ControlSources)
193:         THIS.ConfigurarGridDados()
194: 
195:         *-- 5. Formas decorativas (Shape1/3/4/5 do original SCX)
196:         THIS.ConfigurarFormas()
197:     ENDPROC
198: 
199:     *==========================================================================
200:     * ConfigurarPaginaDados - Campos DADOS parte 1 (totais + observacao)
201:     *   Forma OPERACIONAL sem PageFrame - agrega os controles de dados abaixo
202:     *   do grid: area de totais Frete/Desp/Seguro + container de observacao
203:     *==========================================================================
204:     PROTECTED PROCEDURE ConfigurarPaginaDados()
205:         *-- Area de totais (Frete/Despesas Acessorias/Seguro): 6 labels + 6 textboxes
206:         THIS.ConfigurarAreaTotais()
207: 
208:         *-- Container de observacao (codigo + memo, oculto ate selecao de linha)
209:         THIS.ConfigurarContainerObservacao()
210:     ENDPROC
211: 
212:     *==========================================================================
213:     * AlternarPagina - Alterna visibilidade dos paineis suplementares por linha
214:     *   par_nDtEntrs : valor do campo DtEntrs da operacao corrente
215:     *   par_nDigObs  : valor do campo DigObs da operacao corrente
216:     *==========================================================================
217:     FUNCTION AlternarPagina(par_nDtEntrs, par_nDigObs)
218:         LOCAL loc_nDtEntrs, loc_nDigObs
219:         loc_nDtEntrs = IIF(VARTYPE(par_nDtEntrs) = "N", par_nDtEntrs, 0)
220:         loc_nDigObs  = IIF(VARTYPE(par_nDigObs)  = "N", par_nDigObs,  0)
221: 
222:         *-- Entrega visivel quando DtEntrs IN (3,4,5,6) - tipos de entrega com destinatario
223:         THIS.cnt_4c_Entrega.Visible    = INLIST(loc_nDtEntrs, 3, 4, 5, 6)
224: 
225:         *-- Observacao visivel quando DigObs IN (1,3) - digitacao de observacao permitida
226:         THIS.cnt_4c_Observacao.Visible = INLIST(loc_nDigObs, 1, 3)
227: 
228:         THIS.Refresh()
229:     ENDPROC
230: 
231:     *==========================================================================
232:     * ConfigurarGrid - Grid principal mostrando CsPrazE por operacao
233:     *==========================================================================
234:     PROTECTED PROCEDURE ConfigurarGrid()
235:         LOCAL loc_oGrid, loc_oCol
236: 
237:         THIS.AddObject("grd_4c_Dados", "Grid")
238:         loc_oGrid = THIS.grd_4c_Dados
239: 
240:         WITH loc_oGrid
241:             .Top               = 89
242:             .Left              = 7
243:             .Width             = 889
244:             .Height            = 246
245:             .ColumnCount       = 5
246:             .FontName          = "Verdana"
247:             .FontSize          = 8
248:             .AllowHeaderSizing = .F.
249:             .AllowRowSizing    = .F.
250:             .DeleteMark        = .F.
251:             .HeaderHeight      = 20
252:             .RowHeight         = 16
253:             .ScrollBars        = 2
254:             .SplitBar          = .F.
255:             .GridLineColor     = RGB(238, 238, 238)
256:             .Themes            = .F.
257:             .Visible           = .T.
258:         ENDWITH
259: 
260:         *-- Column1: Movimentacao (Dopes) - somente leitura
261:         loc_oCol = loc_oGrid.Column1
262:         WITH loc_oCol
263:             .ColumnOrder      = 1
264:             .Width            = 290
265:             .ReadOnly         = .T.
266:             .FontName         = "Verdana"
267:             .FontSize         = 8
268:         ENDWITH
269:         loc_oCol.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
270:         loc_oCol.Header1.FontName  = "Verdana"
271:         loc_oCol.Header1.FontSize  = 8
272:         loc_oCol.Header1.Alignment = 2
273:         loc_oCol.Text1.BorderStyle = 0
274:         loc_oCol.Text1.Margin      = 0

*-- Linhas 359 a 402:
359:     *==========================================================================
360:     * ConfigurarGridDados - Define RecordSource/ControlSources e coloracao
361:     *==========================================================================
362:     PROTECTED PROCEDURE ConfigurarGridDados()
363:         LOCAL loc_oGrid
364:         LOCAL loc_cDynFc, loc_nQtdSc, loc_nVez, loc_nCor
365:         loc_oGrid = THIS.grd_4c_Dados
366: 
367:         WITH loc_oGrid
368:             .RecordSource          = "CsPrazE"
369:             .RecordSourceType      = 1
370:             .Column1.ControlSource = "CsPrazE.Dopes"
371:             .Column2.ControlSource = "CsPrazE.Prazos"
372:             .Column3.ControlSource = "CsPrazE.VlFretes"
373:             .Column4.ControlSource = "CsPrazE.DespAces"
374:             .Column5.ControlSource = "CsPrazE.VlSeguros"
375:             .Refresh()
376:         ENDWITH
377: 
378:         *-- Coloracao dinamica por grupo de operacao (nCors diferencia grupos)
379:         IF USED("CsPedidos")
380:             loc_cDynFc = ""
381:             loc_nQtdSc = 0
382:             loc_nVez   = 0
383:             SELECT CsPedidos
384:             SET ORDER TO nCors
385:             GO TOP
386:             SCAN
387:                 loc_nCor   = CsPedidos.nCors
388:                 loc_cDynFc = loc_cDynFc + "Iif(InList(CsPrazE.Abrevs,"
389:                 loc_nQtdSc = loc_nQtdSc + 1
390:                 SCAN WHILE nCors = loc_nCor
391:                     IF loc_nVez > 0
392:                         loc_cDynFc = loc_cDynFc + ","
393:                     ENDIF
394:                     loc_cDynFc = loc_cDynFc + "'" + ALLTRIM(Abrevs) + "'"
395:                     loc_nVez   = loc_nVez + 1
396:                 ENDSCAN
397:                 SKIP -1
398:                 loc_cDynFc = loc_cDynFc + ")," + ALLTRIM(STR(loc_nCor)) + ","
399:                 loc_nVez = 0
400:             ENDSCAN
401:             SET ORDER TO Abrevs
402:             IF loc_nQtdSc > 0

*-- Linhas 409 a 452:
409:     *==========================================================================
410:     * ConfigurarAreaTotais - Labels e TextBoxes de Frete/Desp.Acess/Seguro
411:     *==========================================================================
412:     PROTECTED PROCEDURE ConfigurarAreaTotais()
413:         *-- Background da area de totais
414:         THIS.AddObject("cnt_4c_BgTotais", "Container")
415:         WITH THIS.cnt_4c_BgTotais
416:             .Top         = 342
417:             .Left        = 7
418:             .Width       = 889
419:             .Height      = 73
420:             .BackStyle   = 1
421:             .BackColor   = RGB(188, 201, 254)
422:             .BorderWidth = 0
423:             .Visible     = .T.
424:         ENDWITH
425: 
426:         *-- === FRETE ===
427:         THIS.AddObject("lbl_4c_FrtTit", "Label")
428:         WITH THIS.lbl_4c_FrtTit
429:             .AutoSize  = .T.
430:             .FontBold  = .T.
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .BackStyle = 0
434:             .Caption   = "Frete"
435:             .Left      = 44
436:             .Top       = 347
437:             .ForeColor = RGB(90, 90, 90)
438:             .Visible   = .T.
439:         ENDWITH
440: 
441:         THIS.AddObject("lbl_4c_FrtTot", "Label")
442:         WITH THIS.lbl_4c_FrtTot
443:             .AutoSize  = .T.
444:             .FontBold  = .F.
445:             .FontName  = "Tahoma"
446:             .FontSize  = 8
447:             .BackStyle = 0
448:             .Caption   = "Total"
449:             .Left      = 44
450:             .Top       = 372
451:             .ForeColor = RGB(90, 90, 90)
452:             .Visible   = .T.

*-- Linhas 646 a 689:
646:     *==========================================================================
647:     * ConfigurarContainerObservacao - cnt_4c_Observacao (Top=422, H=105)
648:     *==========================================================================
649:     PROTECTED PROCEDURE ConfigurarContainerObservacao()
650:         LOCAL loc_oCnt
651: 
652:         THIS.AddObject("cnt_4c_Observacao", "Container")
653:         loc_oCnt = THIS.cnt_4c_Observacao
654:         WITH loc_oCnt
655:             .Top         = 422
656:             .Left        = 7
657:             .Width       = 889
658:             .Height      = 105
659:             .BackStyle   = 1
660:             .BackColor   = RGB(188, 201, 254)
661:             .BorderWidth = 1
662:             .Visible     = .F.
663:         ENDWITH
664: 
665:         loc_oCnt.AddObject("lbl_4c_TitObs", "Label")
666:         WITH loc_oCnt.lbl_4c_TitObs
667:             .FontBold  = .T.
668:             .FontName  = "Tahoma"
669:             .FontSize  = 8
670:             .BackStyle = 0
671:             .Caption   = " Observa" + CHR(231) + CHR(227) + "o "
672:             .Left      = 5
673:             .Top       = 4
674:             .ForeColor = RGB(90, 90, 90)
675:             .Visible   = .T.
676:         ENDWITH
677: 
678:         *-- Codigo da observacao
679:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
680:         WITH loc_oCnt.txt_4c_CodObs
681:             .Alignment = 3
682:             .Value     = 0
683:             .Height    = 24
684:             .InputMask = "999"
685:             .Left      = 10
686:             .Margin    = 0
687:             .Top       = 21
688:             .Width     = 32
689:             .Visible   = .T.

*-- Linhas 705 a 748:
705:     *==========================================================================
706:     * ConfigurarContainerEntrega - cnt_4c_Entrega (Top=534, H=59)
707:     *==========================================================================
708:     PROTECTED PROCEDURE ConfigurarContainerEntrega()
709:         LOCAL loc_oCnt
710: 
711:         THIS.AddObject("cnt_4c_Entrega", "Container")
712:         loc_oCnt = THIS.cnt_4c_Entrega
713:         WITH loc_oCnt
714:             .Top         = 534
715:             .Left        = 7
716:             .Width       = 889
717:             .Height      = 59
718:             .BackStyle   = 1
719:             .BackColor   = RGB(188, 201, 254)
720:             .BorderWidth = 1
721:             .Visible     = .F.
722:         ENDWITH
723: 
724:         loc_oCnt.AddObject("lbl_4c_TitEnt", "Label")
725:         WITH loc_oCnt.lbl_4c_TitEnt
726:             .FontBold  = .T.
727:             .FontName  = "Tahoma"
728:             .FontSize  = 8
729:             .BackStyle = 0
730:             .Caption   = " Entrega "
731:             .Left      = 6
732:             .Top       = 3
733:             .ForeColor = RGB(90, 90, 90)
734:             .Visible   = .T.
735:         ENDWITH
736: 
737:         loc_oCnt.AddObject("lbl_4c_LblConta", "Label")
738:         WITH loc_oCnt.lbl_4c_LblConta
739:             .FontBold  = .F.
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .BackStyle = 0
743:             .Caption   = "Conta"
744:             .Left      = 10
745:             .Top       = 19
746:             .ForeColor = RGB(90, 90, 90)
747:             .Visible   = .T.
748:         ENDWITH

*-- Linhas 843 a 949:
843:     *==========================================================================
844:     * ConfigurarBotaoEncerrar - cnt_4c_Saida com cmd_4c_Encerrar (canonico)
845:     *==========================================================================
846:     PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
847:         LOCAL loc_oCnt
848: 
849:         THIS.AddObject("cnt_4c_Saida", "Container")
850:         loc_oCnt = THIS.cnt_4c_Saida
851:         WITH loc_oCnt
852:             .Top         = 3
853:             .Left        = 917
854:             .Width       = 90
855:             .Height      = 85
856:             .BackStyle   = 0
857:             .BorderWidth = 0
858:             .Visible     = .T.
859:         ENDWITH
860: 
861:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
862:         WITH loc_oCnt.cmd_4c_Encerrar
863:             .Top         = 5
864:             .Left        = 5
865:             .Width       = 75
866:             .Height      = 75
867:             .Caption     = "Encerrar"
868:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
869:             .FontBold    = .T.
870:             .FontItalic  = .T.
871:             .FontName    = "Comic Sans MS"
872:             .FontSize    = 8
873:             .WordWrap    = .T.
874:             .ForeColor   = RGB(90, 90, 90)
875:             .BackColor   = RGB(255, 255, 255)
876:             .Themes      = .F.
877:             .ToolTipText = "[ESC] Encerrar"
878:             .Cancel      = .T.
879:             .Visible     = .T.
880:         ENDWITH
881:     ENDPROC
882: 
883:     *==========================================================================
884:     * BindEventos - Conecta eventos dos controles a metodos do form
885:     *==========================================================================
886:     PROTECTED PROCEDURE BindEventos()
887:         *-- Grid: navegacao de linha atualiza containers de entrega/observacao
888:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "AtualizarLinhaGrid")
889: 
890:         *-- Campos numericos do grid: recalcular totais ao sair
891:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "LostFocus", THIS, "AtualizarTotaisNaTela")
892:         BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "LostFocus", THIS, "AtualizarTotaisNaTela")
893:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "LostFocus", THIS, "AtualizarTotaisNaTela")
894: 
895:         *-- Conta de entrega: validar e preencher CPF/Nome ao sair
896:         BINDEVENT(THIS.cnt_4c_Entrega.txt_4c_Conta, "LostFocus", THIS, "ValidarConta")
897: 
898:         *-- Codigo da observacao: buscar descricao ao sair
899:         BINDEVENT(THIS.cnt_4c_Observacao.txt_4c_CodObs, "LostFocus", THIS, "ValidarObservacao")
900: 
901:         *-- Botao Encerrar: confirmar e fechar
902:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "EncerrarClick")
903: 
904:         *-- Botao local de entrega: abrir FormEnd
905:         BINDEVENT(THIS.cnt_4c_Entrega.btn_4c_EntLocal, "Click", THIS, "EntLocalClick")
906: 
907:         *-- CPF/CNPJ e Nome: KeyPress (Enter/Tab/F4) para lookup
908:         BINDEVENT(THIS.cnt_4c_Entrega.txt_4c_Cpf,    "KeyPress", THIS, "ValidarCpf")
909:         BINDEVENT(THIS.cnt_4c_Entrega.txt_4c_DConta, "KeyPress", THIS, "ValidarDConta")
910:     ENDPROC
911: 
912:     *==========================================================================
913:     * AtualizarLinhaGrid - AfterRowColChange: atualiza containers por operacao
914:     *==========================================================================
915:     FUNCTION AtualizarLinhaGrid(par_nColIndex)
916:         LOCAL loc_cDopes, loc_cConta
917: 
918:         IF !USED("CsPrazE")
919:             RETURN
920:         ENDIF
921:         SELECT CsPrazE
922:         loc_cDopes = ALLTRIM(CsPrazE.Dopes)
923: 
924:         IF THIS.this_oBusinessObject.CarregarInfoLinhaGrid(loc_cDopes)
925:             *-- Alternar visibilidade dos paineis suplementares
926:             THIS.AlternarPagina(THIS.this_oBusinessObject.this_nDtEntrsOpe, ;
927:                                 THIS.this_oBusinessObject.this_nDigObs)
928: 
929:             *-- Atualizar campos de conta de entrega
930:             loc_cConta = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
931:             IF !EMPTY(loc_cConta)
932:                 IF THIS.this_oBusinessObject.CarregarInfoConta(loc_cConta, ;
933:                         THIS.this_oBusinessObject.this_nChCtEntrs)
934:                     THIS.cnt_4c_Entrega.txt_4c_Cpf.Value    = ;
935:                         THIS.this_oBusinessObject.this_cGetCpf
936:                     THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;
937:                         THIS.this_oBusinessObject.this_cGetDConta
938:                 ENDIF
939:             ELSE
940:                 THIS.cnt_4c_Entrega.txt_4c_Cpf.Value    = ""
941:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ""
942:             ENDIF
943:         ENDIF
944: 
945:         *-- Atualizar campos de observacao (SEEK no TprMvCabG indexado por Abrevs)
946:         IF USED("TprMvCabG")
947:             IF SEEK(CsPrazE.Abrevs, "TprMvCabG", "Abrevs")
948:                 THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = NVL(TprMvCabG.CodObs, 0)
949:                 THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ALLTRIM(NVL(TprMvCabG.Obses, ""))

*-- Linhas 1062 a 1138:
1062:             IF loc_lContinuar
1063:                 loc_cIClis = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
1064:                 IF EMPTY(loc_cIClis)
1065:                     MsgAviso("Informe a Conta de Entrega antes de selecionar o Local.", ;
1066:                              "Aviso")
1067:                     loc_lContinuar = .F.
1068:                 ENDIF
1069:             ENDIF
1070: 
1071:             IF loc_lContinuar
1072:                 *-- Buscar dados do cliente para abrir FormEnd
1073:                 loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = '" + ;
1074:                            ALLTRIM(loc_cIClis) + "'"
1075:                 IF USED("crTSigDCompCli")
1076:                     USE IN crTSigDCompCli
1077:                 ENDIF
1078:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTSigDCompCli")
1079:                 IF loc_nResult >= 1
1080:                     SELECT crTSigDCompCli
1081:                     GO TOP
1082:                     loc_cGrupo = ALLTRIM(NVL(crTSigDCompCli.Grupos, ""))
1083:                     loc_cNome  = ALLTRIM(NVL(crTSigDCompCli.RClis,  ""))
1084:                     loc_nLocal = NVL(CsPrazE.LocalEnts, 0)
1085: 
1086:                     DO FORM FormEnd WITH ;
1087:                         loc_cGrupo, loc_cIClis, loc_cNome, ;
1088:                         THIS.this_oBusinessObject.this_cEscolha, .NULL., loc_nLocal
1089:                 ENDIF
1090:                 IF USED("crTSigDCompCli")
1091:                     USE IN crTSigDCompCli
1092:                 ENDIF
1093:             ENDIF
1094: 
1095:         CATCH TO loc_oErro
1096:             MsgErro(loc_oErro.Message + CHR(13) + ;
1097:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1098:                     "Procedure: " + loc_oErro.Procedure, ;
1099:                     "Erro em FormPzo.EntLocalClick")
1100:         ENDTRY
1101:     ENDPROC
1102: 
1103:     *==========================================================================
1104:     * ValidarCpf - KeyPress txt_4c_Cpf: valida CPF/CNPJ e preenche Conta/Nome
1105:     * Dispara em Enter(13), Tab(9) ou F4(115)
1106:     *==========================================================================
1107:     FUNCTION ValidarCpf(par_nKeyCode, par_nShiftAltCtrl)
1108:         LOCAL loc_cCpf, loc_cCpfFmt, loc_nLen, loc_cSQL, loc_nResult, loc_oErro
1109:         LOCAL loc_lSucesso
1110:         loc_lSucesso = .F.
1111: 
1112:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1113:             RETURN
1114:         ENDIF
1115: 
1116:         loc_cCpf = ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_Cpf.Value)
1117:         IF EMPTY(loc_cCpf)
1118:             RETURN
1119:         ENDIF
1120: 
1121:         *-- Remover formatacao (pontos, tracinho, barra)
1122:         loc_cCpf = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
1123:         loc_nLen = LEN(ALLTRIM(loc_cCpf))
1124:         IF loc_nLen <= 11
1125:             loc_cCpfFmt = TRANSFORM(loc_cCpf, "@R 999.999.999-99")
1126:         ELSE
1127:             loc_cCpfFmt = TRANSFORM(loc_cCpf, "@R 99.999.999/9999-99")
1128:         ENDIF
1129:         THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = loc_cCpfFmt
1130: 
1131:         TRY
1132:             loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE " + ;
1133:                        "RTRIM(Cpfs) = " + EscaparSQL(ALLTRIM(loc_cCpfFmt))
1134:             IF USED("cursor_4c_BuscaCpf")
1135:                 USE IN cursor_4c_BuscaCpf
1136:             ENDIF
1137:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")
1138: 

*-- Linhas 1157 a 1259:
1157:         CATCH TO loc_oErro
1158:             MsgErro(loc_oErro.Message + CHR(13) + ;
1159:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1160:                     "Procedure: " + loc_oErro.Procedure, ;
1161:                     "Erro em FormPzo.ValidarCpf")
1162:         ENDTRY
1163:     ENDPROC
1164: 
1165:     *==========================================================================
1166:     * AbrirBuscaCpf - Abre FormBuscaAuxiliar filtrado por CPF (Pattern A)
1167:     *==========================================================================
1168:     FUNCTION AbrirBuscaCpf(par_cFiltro)
1169:         LOCAL loc_cSQL, loc_nResult, loc_oForm, loc_oErro
1170: 
1171:         TRY
1172:             *-- SQL filtrado por CPF ou codigo (starts-with)
1173:             loc_cSQL = "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis " + ;
1174:                        "FROM SigCdCli WHERE RTRIM(Cpfs) LIKE " + ;
1175:                        EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
1176:                        " OR RTRIM(IClis) LIKE " + ;
1177:                        EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
1178:                        " ORDER BY Cpfs"
1179:             IF USED("cursor_4c_BuscaCpf")
1180:                 USE IN cursor_4c_BuscaCpf
1181:             ENDIF
1182:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")
1183:             IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCpf") = 0
1184:                 IF USED("cursor_4c_BuscaCpf")
1185:                     USE IN cursor_4c_BuscaCpf
1186:                 ENDIF
1187:                 *-- Fallback: lista completa
1188:                 SQLEXEC(gnConnHandle, ;
1189:                     "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis FROM SigCdCli ORDER BY Cpfs", ;
1190:                     "cursor_4c_BuscaCpf")
1191:             ENDIF
1192: 
1193:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1194:             IF VARTYPE(loc_oForm) = "O"
1195:                 loc_oForm.DefinirCursor("cursor_4c_BuscaCpf", "IClis", "Cpfs", ;
1196:                     "Busca por CPF / CNPJ")
1197:                 IF loc_oForm.Mostrar()
1198:                     THIS.cnt_4c_Entrega.txt_4c_Cpf.Value   = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1199:                     THIS.cnt_4c_Entrega.txt_4c_Conta.Value = ALLTRIM(loc_oForm.cCodigoSelecionado)
1200:                     IF !EMPTY(loc_oForm.cCodigoSelecionado)
1201:                         THIS.this_oBusinessObject.CarregarInfoConta( ;
1202:                             ALLTRIM(loc_oForm.cCodigoSelecionado), ;
1203:                             THIS.this_oBusinessObject.this_nChCtEntrs)
1204:                         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;
1205:                             THIS.this_oBusinessObject.this_cGetDConta
1206:                         IF USED("CsPrazE")
1207:                             REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1208:                         ENDIF
1209:                     ENDIF
1210:                 ENDIF
1211:             ENDIF
1212:             IF USED("cursor_4c_BuscaCpf")
1213:                 USE IN cursor_4c_BuscaCpf
1214:             ENDIF
1215: 
1216:         CATCH TO loc_oErro
1217:             MsgErro(loc_oErro.Message + CHR(13) + ;
1218:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1219:                     "Procedure: " + loc_oErro.Procedure, ;
1220:                     "Erro em FormPzo.AbrirBuscaCpf")
1221:         ENDTRY
1222:     ENDPROC
1223: 
1224:     *==========================================================================
1225:     * ValidarDConta - KeyPress txt_4c_DConta: busca cliente por nome
1226:     * Dispara em Enter(13), Tab(9) ou F4(115)
1227:     *==========================================================================
1228:     FUNCTION ValidarDConta(par_nKeyCode, par_nShiftAltCtrl)
1229:         LOCAL loc_cDConta, loc_cSQL, loc_nResult, loc_oForm, loc_oErro
1230:         LOCAL loc_lSucesso
1231:         loc_lSucesso = .F.
1232: 
1233:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1234:             RETURN
1235:         ENDIF
1236: 
1237:         loc_cDConta = ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_DConta.Value)
1238:         IF EMPTY(loc_cDConta)
1239:             RETURN
1240:         ENDIF
1241: 
1242:         TRY
1243:             *-- Busca exata por nome (RClis)
1244:             loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + ;
1245:                        "RTRIM(RClis) = " + EscaparSQL(loc_cDConta)
1246:             IF USED("cursor_4c_BuscaDConta")
1247:                 USE IN cursor_4c_BuscaDConta
1248:             ENDIF
1249:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDConta")
1250: 
1251:             IF loc_nResult >= 1 AND !EOF("cursor_4c_BuscaDConta")
1252:                 SELECT cursor_4c_BuscaDConta
1253:                 GO TOP
1254:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(NVL(cursor_4c_BuscaDConta.IClis, ""))
1255:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(NVL(cursor_4c_BuscaDConta.RClis, ""))
1256:                 IF USED("CsPrazE")
1257:                     REPLACE ContaEs WITH ALLTRIM(cursor_4c_BuscaDConta.IClis) IN CsPrazE
1258:                 ENDIF
1259:                 THIS.this_oBusinessObject.CarregarInfoConta( ;

*-- Linhas 1280 a 1433:
1280:                         "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY RClis", ;
1281:                         "cursor_4c_BuscaDConta")
1282:                 ENDIF
1283:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1284:                 IF VARTYPE(loc_oForm) = "O"
1285:                     loc_oForm.DefinirCursor("cursor_4c_BuscaDConta", "IClis", "RClis", ;
1286:                         "Busca de Contas")
1287:                     IF loc_oForm.Mostrar()
1288:                         THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
1289:                         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1290:                         IF !EMPTY(loc_oForm.cCodigoSelecionado)
1291:                             IF USED("CsPrazE")
1292:                                 REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1293:                             ENDIF
1294:                             THIS.this_oBusinessObject.CarregarInfoConta( ;
1295:                                 ALLTRIM(loc_oForm.cCodigoSelecionado), ;
1296:                                 THIS.this_oBusinessObject.this_nChCtEntrs)
1297:                             THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cGetCpf
1298:                         ENDIF
1299:                     ENDIF
1300:                 ENDIF
1301:                 IF USED("cursor_4c_BuscaDConta")
1302:                     USE IN cursor_4c_BuscaDConta
1303:                 ENDIF
1304:             ENDIF
1305: 
1306:         CATCH TO loc_oErro
1307:             MsgErro(loc_oErro.Message + CHR(13) + ;
1308:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1309:                     "Procedure: " + loc_oErro.Procedure, ;
1310:                     "Erro em FormPzo.ValidarDConta")
1311:         ENDTRY
1312:     ENDPROC
1313: 
1314:     *==========================================================================
1315:     * EncerrarClick - Botao Encerrar: valida, grava e fecha o form
1316:     *==========================================================================
1317:     FUNCTION EncerrarClick()
1318:         IF THIS.this_oBusinessObject.Confirmar()
1319:             THIS.Release()
1320:         ENDIF
1321:     ENDPROC
1322: 
1323:     *==========================================================================
1324:     * AbrirBuscaConta - Pattern A: abre FormBuscaAuxiliar para SigCdCli
1325:     *   par_cFiltro: valor digitado (prefixo para filtro LIKE)
1326:     *==========================================================================
1327:     FUNCTION AbrirBuscaConta(par_cFiltro)
1328:         LOCAL loc_cSQL, loc_nResult, loc_oForm, loc_oErro
1329:         LOCAL loc_cFiltro
1330:         loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")
1331: 
1332:         TRY
1333:             *-- SQL filtrado por codigo ou nome (starts-with)
1334:             IF EMPTY(loc_cFiltro)
1335:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis"
1336:             ELSE
1337:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli " + ;
1338:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
1339:                            " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
1340:                            " ORDER BY IClis"
1341:             ENDIF
1342: 
1343:             IF USED("cursor_4c_BuscaCli")
1344:                 USE IN cursor_4c_BuscaCli
1345:             ENDIF
1346:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1347:             IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCli") = 0
1348:                 IF USED("cursor_4c_BuscaCli")
1349:                     USE IN cursor_4c_BuscaCli
1350:                 ENDIF
1351:                 SQLEXEC(gnConnHandle, ;
1352:                     "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis", ;
1353:                     "cursor_4c_BuscaCli")
1354:             ENDIF
1355: 
1356:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1357:             IF VARTYPE(loc_oForm) = "O"
1358:                 loc_oForm.DefinirCursor("cursor_4c_BuscaCli", "IClis", "RClis", ;
1359:                     "Busca de Contas de Entrega")
1360:                 IF loc_oForm.Mostrar()
1361:                     THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
1362:                     THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1363:                     IF !EMPTY(loc_oForm.cCodigoSelecionado)
1364:                         IF USED("CsPrazE")
1365:                             REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1366:                         ENDIF
1367:                         THIS.this_oBusinessObject.CarregarInfoConta( ;
1368:                             ALLTRIM(loc_oForm.cCodigoSelecionado), ;
1369:                             THIS.this_oBusinessObject.this_nChCtEntrs)
1370:                         THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cGetCpf
1371:                     ENDIF
1372:                 ENDIF
1373:             ENDIF
1374:             IF USED("cursor_4c_BuscaCli")
1375:                 USE IN cursor_4c_BuscaCli
1376:             ENDIF
1377: 
1378:         CATCH TO loc_oErro
1379:             MsgErro(loc_oErro.Message + CHR(13) + ;
1380:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1381:                     "Procedure: " + loc_oErro.Procedure, ;
1382:                     "Erro em FormPzo.AbrirBuscaConta")
1383:         ENDTRY
1384:     ENDPROC
1385: 
1386:     *==========================================================================
1387:     * ConfigurarFormas - Shapes decorativos (bordas e separadores)
1388:     *   Shape5: borda ao redor do botao Encerrar (Top=7, Left=903, 86x86)
1389:     *   Shape1: linha separadora Frete (Top=365, Left=44, 194x2)
1390:     *   Shape3: linha separadora Desp.Acess (Top=365, Left=315, 194x2)
1391:     *   Shape4: linha separadora Seguro (Top=365, Left=586, 194x2)
1392:     *==========================================================================
1393:     PROTECTED PROCEDURE ConfigurarFormas()
1394:         *-- Borda decorativa ao redor do container Encerrar
1395:         THIS.AddObject("shp_4c_Shape5", "Shape")
1396:         WITH THIS.shp_4c_Shape5
1397:             .Top         = 7
1398:             .Left        = 903
1399:             .Width       = 86
1400:             .Height      = 86
1401:             .ShapeType   = 0
1402:             .FillStyle   = 1
1403:             .BorderColor = RGB(53, 53, 53)
1404:             .BorderWidth = 2
1405:             .Visible     = .T.
1406:         ENDWITH
1407: 
1408:         *-- Linha separadora horizontal abaixo do label "Total" da area Frete
1409:         THIS.AddObject("shp_4c_Shape1", "Shape")
1410:         WITH THIS.shp_4c_Shape1
1411:             .Top         = 365
1412:             .Left        = 44
1413:             .Width       = 194
1414:             .Height      = 2
1415:             .ShapeType   = 0
1416:             .FillStyle   = 0
1417:             .BackColor   = RGB(90, 90, 90)
1418:             .BorderColor = RGB(90, 90, 90)
1419:             .BorderWidth = 1
1420:             .Visible     = .T.
1421:         ENDWITH
1422: 
1423:         *-- Linha separadora horizontal abaixo do label "Total" da area Despesas
1424:         THIS.AddObject("shp_4c_Shape3", "Shape")
1425:         WITH THIS.shp_4c_Shape3
1426:             .Top         = 365
1427:             .Left        = 315
1428:             .Width       = 194
1429:             .Height      = 2
1430:             .ShapeType   = 0
1431:             .FillStyle   = 0
1432:             .BackColor   = RGB(90, 90, 90)
1433:             .BorderColor = RGB(90, 90, 90)

*-- Linhas 1455 a 1682:
1455:     * BtnIncluirClick - Insere nova linha em CsPrazE (novo prazo/conta)
1456:     * Adiciona registro em branco herdando Dopes/Abrevs da linha corrente
1457:     *==========================================================================
1458:     PROCEDURE BtnIncluirClick()
1459:         LOCAL loc_oErro, loc_cDopes, loc_cAbrevs, loc_dPrazoBase
1460:         LOCAL loc_nDtEntrs, loc_nFiscals, loc_cContaEs
1461: 
1462:         TRY
1463:             IF !USED("CsPrazE")
1464:                 MsgAviso("Cursor de prazos nao esta disponivel.", "Aviso")
1465:                 RETURN
1466:             ENDIF
1467: 
1468:             *-- Capturar valores da linha corrente para herdar
1469:             SELECT CsPrazE
1470:             loc_cDopes    = ALLTRIM(NVL(CsPrazE.Dopes,    ""))
1471:             loc_cAbrevs   = ALLTRIM(NVL(CsPrazE.Abrevs,   ""))
1472:             loc_dPrazoBase= NVL(CsPrazE.Prazos, DATETIME())
1473:             loc_nDtEntrs  = NVL(CsPrazE.DtEntrs,  0)
1474:             loc_nFiscals  = NVL(CsPrazE.nFiscals, 0)
1475:             loc_cContaEs  = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
1476: 
1477:             *-- Adicionar linha em branco herdando contexto
1478:             APPEND BLANK IN CsPrazE
1479:             REPLACE CsPrazE.Dopes     WITH loc_cDopes    ;
1480:                     CsPrazE.Abrevs    WITH loc_cAbrevs   ;
1481:                     CsPrazE.Prazos    WITH loc_dPrazoBase;
1482:                     CsPrazE.DtEntrs   WITH loc_nDtEntrs  ;
1483:                     CsPrazE.nFiscals  WITH loc_nFiscals  ;
1484:                     CsPrazE.nMinEnts  WITH 0             ;
1485:                     CsPrazE.nMaxEnts  WITH 0             ;
1486:                     CsPrazE.VlFretes  WITH 0             ;
1487:                     CsPrazE.DespAces  WITH 0             ;
1488:                     CsPrazE.VlSeguros WITH 0             ;
1489:                     CsPrazE.ContaEs   WITH loc_cContaEs  ;
1490:                     CsPrazE.LocalEnts WITH 0             ;
1491:                     CsPrazE.LocEntObs WITH 0             ;
1492:                     CsPrazE.ContaEs   WITH loc_cContaEs  IN CsPrazE
1493: 
1494:             *-- Reposicionar grid na nova linha e atualizar totais/paineis
1495:             THIS.grd_4c_Dados.Refresh
1496:             THIS.AtualizarLinhaGrid(1)
1497:             THIS.AtualizarTotaisNaTela()
1498: 
1499:         CATCH TO loc_oErro
1500:             MsgErro(loc_oErro.Message + CHR(13) + ;
1501:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1502:                     "Procedure: " + loc_oErro.Procedure, ;
1503:                     "Erro em FormPzo.BtnIncluirClick")
1504:         ENDTRY
1505:     ENDPROC
1506: 
1507:     *==========================================================================
1508:     * BtnAlterarClick - Habilita edicao da linha corrente do grid CsPrazE
1509:     * Posiciona foco na primeira coluna editavel e atualiza paineis suplementares
1510:     *==========================================================================
1511:     PROCEDURE BtnAlterarClick()
1512:         LOCAL loc_oErro
1513: 
1514:         TRY
1515:             IF !USED("CsPrazE") OR RECCOUNT("CsPrazE") = 0
1516:                 MsgAviso("Nenhum prazo disponivel para alteracao.", "Aviso")
1517:                 RETURN
1518:             ENDIF
1519: 
1520:             SELECT CsPrazE
1521:             IF EOF() OR BOF()
1522:                 GO TOP
1523:             ENDIF
1524: 
1525:             *-- Marcar modo edicao no BO (usado por Confirmar)
1526:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1527:                 THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
1528:             ENDIF
1529: 
1530:             *-- Atualizar paineis suplementares para a linha atual
1531:             THIS.AtualizarLinhaGrid(1)
1532: 
1533:             *-- Colocar foco na primeira coluna editavel (Frete)
1534:             THIS.grd_4c_Dados.SetFocus
1535:             THIS.grd_4c_Dados.ActiveColumn = 1
1536:             IF PEMSTATUS(THIS.grd_4c_Dados.Columns(1), "CurrentControl", 5)
1537:                 THIS.grd_4c_Dados.Columns(1).Text1.SetFocus
1538:             ENDIF
1539: 
1540:         CATCH TO loc_oErro
1541:             MsgErro(loc_oErro.Message + CHR(13) + ;
1542:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1543:                     "Procedure: " + loc_oErro.Procedure, ;
1544:                     "Erro em FormPzo.BtnAlterarClick")
1545:         ENDTRY
1546:     ENDPROC
1547: 
1548:     *==========================================================================
1549:     * BtnVisualizarClick - Modo somente-leitura: bloqueia grid e campos editaveis
1550:     * Atualiza paineis suplementares mostrando dados da linha corrente
1551:     *==========================================================================
1552:     PROCEDURE BtnVisualizarClick()
1553:         LOCAL loc_oErro
1554: 
1555:         TRY
1556:             IF !USED("CsPrazE") OR RECCOUNT("CsPrazE") = 0
1557:                 MsgAviso("Nenhum prazo disponivel para visualizacao.", "Aviso")
1558:                 RETURN
1559:             ENDIF
1560: 
1561:             SELECT CsPrazE
1562:             IF EOF() OR BOF()
1563:                 GO TOP
1564:             ENDIF
1565: 
1566:             *-- Marcar modo visualizacao no BO
1567:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1568:                 THIS.this_oBusinessObject.this_cEscolha = "VISUALIZAR"
1569:             ENDIF
1570: 
1571:             *-- Bloquear edicao no grid (todas as colunas ReadOnly)
1572:             THIS.grd_4c_Dados.ReadOnly = .T.
1573: 
1574:             *-- Bloquear campos do painel de entrega e observacao
1575:             THIS.cnt_4c_Entrega.txt_4c_Conta.ReadOnly    = .T.
1576:             THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly   = .T.
1577:             THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly      = .T.
1578:             THIS.cnt_4c_Observacao.txt_4c_CodObs.ReadOnly= .T.
1579:             THIS.cnt_4c_Observacao.txt_4c_Obs.ReadOnly   = .T.
1580: 
1581:             *-- Refrescar paineis suplementares para exibir dados
1582:             THIS.AtualizarLinhaGrid(1)
1583:             THIS.AtualizarTotaisNaTela()
1584: 
1585:         CATCH TO loc_oErro
1586:             MsgErro(loc_oErro.Message + CHR(13) + ;
1587:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1588:                     "Procedure: " + loc_oErro.Procedure, ;
1589:                     "Erro em FormPzo.BtnVisualizarClick")
1590:         ENDTRY
1591:     ENDPROC
1592: 
1593:     *==========================================================================
1594:     * BtnExcluirClick - Remove linha corrente de CsPrazE apos confirmacao
1595:     * Apos exclusao reposiciona no primeiro registro e atualiza totais
1596:     *==========================================================================
1597:     PROCEDURE BtnExcluirClick()
1598:         LOCAL loc_oErro, loc_cDopes
1599: 
1600:         TRY
1601:             IF !USED("CsPrazE") OR RECCOUNT("CsPrazE") = 0
1602:                 MsgAviso("Nenhum prazo disponivel para exclusao.", "Aviso")
1603:                 RETURN
1604:             ENDIF
1605: 
1606:             SELECT CsPrazE
1607:             IF EOF() OR BOF()
1608:                 GO TOP
1609:             ENDIF
1610: 
1611:             loc_cDopes = ALLTRIM(NVL(CsPrazE.Dopes, ""))
1612: 
1613:             IF !MsgConfirma("Confirma a exclusao do prazo da operacao " + ;
1614:                             loc_cDopes + " ?", "Confirmacao")
1615:                 RETURN
1616:             ENDIF
1617: 
1618:             *-- Marcar registro para exclusao e purgar do cursor
1619:             DELETE IN CsPrazE
1620:             SET DELETED ON
1621:             PACK
1622: 
1623:             *-- Reposicionar e atualizar interface
1624:             SELECT CsPrazE
1625:             IF RECCOUNT("CsPrazE") > 0
1626:                 GO TOP
1627:                 THIS.grd_4c_Dados.Refresh
1628:                 THIS.AtualizarLinhaGrid(1)
1629:             ELSE
1630:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
1631:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
1632:                 THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
1633:                 THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
1634:                 THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
1635:             ENDIF
1636: 
1637:             THIS.AtualizarTotaisNaTela()
1638: 
1639:         CATCH TO loc_oErro
1640:             MsgErro(loc_oErro.Message + CHR(13) + ;
1641:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1642:                     "Procedure: " + loc_oErro.Procedure, ;
1643:                     "Erro em FormPzo.BtnExcluirClick")
1644:         ENDTRY
1645:     ENDPROC
1646: 
1647:     *==========================================================================
1648:     * CarregarLista - Reposiciona no primeiro registro e atualiza grid e totais
1649:     *==========================================================================
1650:     FUNCTION CarregarLista()
1651:         LOCAL loc_lSucesso
1652:         loc_lSucesso = .F.
1653: 
1654:         IF USED("CsPrazE")
1655:             SELECT CsPrazE
1656:             IF RECCOUNT("CsPrazE") > 0
1657:                 GO TOP
1658:                 THIS.grd_4c_Dados.Refresh
1659:                 THIS.AtualizarLinhaGrid(1)
1660:                 THIS.AtualizarTotaisNaTela()
1661:                 loc_lSucesso = .T.
1662:             ENDIF
1663:         ENDIF
1664: 
1665:         RETURN loc_lSucesso
1666:     ENDPROC
1667: 
1668:     *==========================================================================
1669:     * FormParaBO - Copia linha corrente do CsPrazE e containers para o BO
1670:     *   (grid edita cursor diretamente via ControlSource; aqui capturamos
1671:     *    os campos auxiliares visiveis nos containers suplementares)
1672:     *==========================================================================
1673:     FUNCTION FormParaBO()
1674:         LOCAL loc_lSucesso, loc_oErro
1675:         loc_lSucesso = .F.
1676: 
1677:         TRY
1678:             IF !USED("CsPrazE")
1679:                 loc_lSucesso = .F.
1680:             ENDIF
1681: 
1682:             SELECT CsPrazE

*-- Linhas 1717 a 1925:
1717:         CATCH TO loc_oErro
1718:             MsgErro(loc_oErro.Message + CHR(13) + ;
1719:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1720:                     "Procedure: " + loc_oErro.Procedure, ;
1721:                     "Erro em FormPzo.FormParaBO")
1722:         ENDTRY
1723: 
1724:         RETURN loc_lSucesso
1725:     ENDPROC
1726: 
1727:     *==========================================================================
1728:     * BOParaForm - Copia propriedades do BO de volta para os controles do form
1729:     *==========================================================================
1730:     FUNCTION BOParaForm()
1731:         LOCAL loc_lSucesso, loc_oErro
1732:         loc_lSucesso = .F.
1733: 
1734:         TRY
1735:             *-- Totalizadores do rodape
1736:             THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
1737:             THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
1738:             THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
1739:             THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
1740:             THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
1741:             THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado
1742: 
1743:             *-- Container de entrega
1744:             IF THIS.cnt_4c_Entrega.Visible
1745:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ;
1746:                     THIS.this_oBusinessObject.this_cGetConta
1747:                 THIS.cnt_4c_Entrega.txt_4c_Cpf.Value    = ;
1748:                     THIS.this_oBusinessObject.this_cGetCpf
1749:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;
1750:                     THIS.this_oBusinessObject.this_cGetDConta
1751:             ENDIF
1752: 
1753:             *-- Container de observacao
1754:             IF THIS.cnt_4c_Observacao.Visible
1755:                 THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = ;
1756:                     THIS.this_oBusinessObject.this_nCodObs
1757:                 THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ;
1758:                     THIS.this_oBusinessObject.this_cObsEs
1759:             ENDIF
1760: 
1761:             THIS.Refresh()
1762:             loc_lSucesso = .T.
1763: 
1764:         CATCH TO loc_oErro
1765:             MsgErro(loc_oErro.Message + CHR(13) + ;
1766:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1767:                     "Procedure: " + loc_oErro.Procedure, ;
1768:                     "Erro em FormPzo.BOParaForm")
1769:         ENDTRY
1770: 
1771:         RETURN loc_lSucesso
1772:     ENDPROC
1773: 
1774:     *==========================================================================
1775:     * HabilitarCampos - Habilita/desabilita controles conforme modo
1776:     *   par_cModo: "INSERIR" | "ALTERAR" | "VISUALIZAR"
1777:     *==========================================================================
1778:     PROCEDURE HabilitarCampos(par_cModo)
1779:         LOCAL loc_lEditar
1780:         loc_lEditar = !INLIST(UPPER(ALLTRIM(par_cModo)), "VISUALIZAR")
1781: 
1782:         *-- Grid: somente-leitura em modo VISUALIZAR
1783:         THIS.grd_4c_Dados.ReadOnly = !loc_lEditar
1784: 
1785:         *-- Container de entrega
1786:         THIS.cnt_4c_Entrega.txt_4c_Conta.ReadOnly    = !loc_lEditar
1787:         THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly      = !loc_lEditar
1788:         THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly   = !loc_lEditar
1789:         THIS.cnt_4c_Entrega.btn_4c_EntLocal.Enabled  = loc_lEditar
1790: 
1791:         *-- Container de observacao (codigo editavel; texto sempre readonly pois e lookup)
1792:         THIS.cnt_4c_Observacao.txt_4c_CodObs.ReadOnly = !loc_lEditar
1793:         THIS.cnt_4c_Observacao.txt_4c_Obs.ReadOnly    = .T.
1794:     ENDPROC
1795: 
1796:     *==========================================================================
1797:     * LimparCampos - Limpa campos dos containers suplementares (entrega/obs)
1798:     *==========================================================================
1799:     PROCEDURE LimparCampos()
1800:         THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
1801:         THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
1802:         THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
1803:         THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
1804:         THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
1805:     ENDPROC
1806: 
1807:     *==========================================================================
1808:     * AjustarBotoesPorModo - Ajusta ReadOnly do grid conforme modo de edicao
1809:     *==========================================================================
1810:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1811:         LOCAL loc_cModo
1812:         loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, "")))
1813: 
1814:         IF EMPTY(loc_cModo) AND VARTYPE(THIS.this_oBusinessObject) = "O"
1815:             loc_cModo = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cEscolha))
1816:         ENDIF
1817: 
1818:         THIS.HabilitarCampos(loc_cModo)
1819:     ENDPROC
1820: 
1821:     *==========================================================================
1822:     * BtnBuscarClick - Recarrega o grid e atualiza totais (refresh)
1823:     *==========================================================================
1824:     PROCEDURE BtnBuscarClick()
1825:         THIS.CarregarLista()
1826:     ENDPROC
1827: 
1828:     *==========================================================================
1829:     * BtnEncerrarClick - Valida prazos/fretes e fecha o form (delega ao BO)
1830:     *==========================================================================
1831:     PROCEDURE BtnEncerrarClick()
1832:         THIS.EncerrarClick()
1833:     ENDPROC
1834: 
1835:     *==========================================================================
1836:     * BtnSalvarClick - Sincroniza campos dos containers com BO e atualiza totais
1837:     *   (grid ja edita CsPrazE via ControlSource; aqui persiste auxiliares)
1838:     *==========================================================================
1839:     PROCEDURE BtnSalvarClick()
1840:         LOCAL loc_oErro
1841: 
1842:         TRY
1843:             IF THIS.FormParaBO()
1844:                 THIS.AtualizarTotaisNaTela()
1845:                 THIS.AjustarBotoesPorModo("")
1846:             ENDIF
1847: 
1848:         CATCH TO loc_oErro
1849:             MsgErro(loc_oErro.Message + CHR(13) + ;
1850:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1851:                     "Procedure: " + loc_oErro.Procedure, ;
1852:                     "Erro em FormPzo.BtnSalvarClick")
1853:         ENDTRY
1854:     ENDPROC
1855: 
1856:     *==========================================================================
1857:     * BtnCancelarClick - Desfaz edicoes nos containers e recarrega da linha
1858:     *==========================================================================
1859:     PROCEDURE BtnCancelarClick()
1860:         LOCAL loc_oErro
1861: 
1862:         TRY
1863:             THIS.LimparCampos()
1864: 
1865:             IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
1866:                 SELECT CsPrazE
1867:                 THIS.AtualizarLinhaGrid(1)
1868:             ENDIF
1869: 
1870:             THIS.grd_4c_Dados.ReadOnly = .F.
1871:             THIS.HabilitarCampos(IIF(VARTYPE(THIS.this_oBusinessObject) = "O", ;
1872:                 THIS.this_oBusinessObject.this_cEscolha, "ALTERAR"))
1873: 
1874:         CATCH TO loc_oErro
1875:             MsgErro(loc_oErro.Message + CHR(13) + ;
1876:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1877:                     "Procedure: " + loc_oErro.Procedure, ;
1878:                     "Erro em FormPzo.BtnCancelarClick")
1879:         ENDTRY
1880:     ENDPROC
1881: 
1882:     *==========================================================================
1883:     * Destroy - Libera cursores locais e BO
1884:     *==========================================================================
1885:     PROCEDURE Destroy()
1886:         LOCAL loc_oErro
1887:         TRY
1888:             IF USED("CsPrazE")
1889:                 USE IN CsPrazE
1890:             ENDIF
1891:             IF USED("CsPedidos")
1892:                 USE IN CsPedidos
1893:             ENDIF
1894:             IF USED("CsPed")
1895:                 USE IN CsPed
1896:             ENDIF
1897:             IF USED("CsPedAnt")
1898:                 USE IN CsPedAnt
1899:             ENDIF
1900:             IF USED("crTodosOpe2")
1901:                 USE IN crTodosOpe2
1902:             ENDIF
1903:             IF USED("CsPedOpe2")
1904:                 USE IN CsPedOpe2
1905:             ENDIF
1906:             IF USED("Itens")
1907:                 USE IN Itens
1908:             ENDIF
1909:             IF USED("LocTmpOpe")
1910:                 USE IN LocTmpOpe
1911:             ENDIF
1912:             IF USED("crLocalObs")
1913:                 USE IN crLocalObs
1914:             ENDIF
1915:             IF USED("cursor_4c_BuscaCpf")
1916:                 USE IN cursor_4c_BuscaCpf
1917:             ENDIF
1918:             IF USED("cursor_4c_BuscaDConta")
1919:                 USE IN cursor_4c_BuscaDConta
1920:             ENDIF
1921:             IF USED("cursor_4c_BuscaCli")
1922:                 USE IN cursor_4c_BuscaCli
1923:             ENDIF
1924:             THIS.this_oBusinessObject = .NULL.
1925:             THIS.this_oFormPai        = .NULL.


### BO (C:\4c\projeto\app\classes\PzoBO.prg):
*==============================================================================
* PzoBO.prg - Business Object para Prazo / Conta de Entrega
* Entidade: Pzo (SIGCDPZO - Prazo e Conta de Entrega por Opera??o)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sub-form de movimenta??o)
*
* Contexto: Sub-form modal chamado por formularios de movimento (ex: SigAtCrp).
* Recebe referencia ao form pai com cursores TprMvCab, CrSigCdOpe, CrSigMvNfi,
* crTpmMvItn, TprMvCabG. Edita CsPrazE (prazos/fretes por opera??o) e grava
* de volta em crTpmMvItn ao confirmar.
*==============================================================================

DEFINE CLASS PzoBO AS BusinessBase

    *-- Identificacao da entidade (referencia principal: SigMvCab)
    this_cTabela         = "SigMvCab"
    this_cCampoChave     = "EmpDnCrds"

    *-- Chave composta do pedido (monta EmpDnCrds = Emps + Dopes + STR(Numes,6))
    this_cEmps           = ""
    this_cDopesParent    = ""
    this_nNumesParent    = 0
    this_cEmpDnCrds      = ""

    *-- Modo de operacao do form pai (INSERIR / ALTERAR / VISUALIZAR)
    this_cEscolha        = ""

    *-- Dados do cabecalho do movimento (TprMvCab) necessarios para validacoes
    this_dDatasParent    = {}
    this_nPrazoEnts      = 0
    this_cLocalEntsParent = ""
    this_cContaEsParent  = ""
    this_nCodObsParent   = 0
    this_cObsEsParent    = ""
    this_cContaDs        = ""
    this_cContaOs        = ""
    this_nValVars        = 0

    *-- Dados da linha corrente do cursor CsPrazE (por opera??o/abreviacao)
    *   Estrutura: CsPrazE (Dopes c(20), Abrevs c(3), Prazos T, DtEntrs n(1),
    *              nMinEnts n(3), nMaxEnts n(3), VlFretes n(12,2), nFiscals n(1),
    *              LocalEnts n(10), ContaEs c(10), LocEntObs n(1),
    *              DespAces n(12,2), VlSeguros n(12,2))
    this_cDopes          = ""
    this_cAbrevs         = ""
    this_dPrazos         = {}
    this_nDtEntrs        = 0
    this_nMinEnts        = 0
    this_nMaxEnts        = 0
    this_nVlFretes       = 0
    this_nFiscals        = 0
    this_nLocalEnts      = 0
    this_cContaEs        = ""
    this_nLocEntObs      = 0
    this_nDespAces       = 0
    this_nVlSeguros      = 0

    *-- Dados da opera??o corrente (LocTmpOpe: SigCdOpe + SigOpCdc)
    this_nExibSits       = 0
    this_nChCtEntrs      = 0
    this_nDtEntrsOpe     = 0
    this_nDigObs         = 0

    *-- Dados de validacao de valores minimos (crTodosOpe2: SigOpCdd)
    this_nChkUteis       = 0
    this_nMinFretes      = 0
    this_nMinSeguros     = 0
    this_nMinDesps       = 0

    *-- Conta de entrega (lookup SigCdCli via LocTmpOpe + CsPrazE.ContaEs)
    this_cGetConta       = ""
    this_cGetDConta      = ""
    this_cGetCpf         = ""

    *-- Observa??o da linha (TprMvCabG: CodObs, ObsEs / Obses)
    this_nCodObs         = 0
    this_cObsEs          = ""

    *-- Totalizadores exibidos no rodape do form
    *   FrtTotal / DespTotal / SegTotal vem de CrSigMvNfi (nota fiscal)
    *   FrtInformado / DespInformado / SegInformado sao somados do CsPrazE
    this_nFrtTotal       = 0
    this_nFrtInformado   = 0
    this_nDespTotal      = 0
    this_nDespInformado  = 0
    this_nSegTotal       = 0
    this_nSegInformado   = 0

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDnCrds"

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cEmpDnCrds
    ENDPROC

    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    *-- Carrega this_ a partir da linha corrente do cursor nomeado.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_cAbrevs    = TratarNulo(Abrevs,    "C")
                THIS.this_dPrazos    = IIF(ISNULL(Prazos), DTOT({}), Prazos)
                THIS.this_nDtEntrs   = TratarNulo(DtEntrs,   "N")
                THIS.this_nMinEnts   = TratarNulo(nMinEnts,  "N")
                THIS.this_nMaxEnts   = TratarNulo(nMaxEnts,  "N")
                THIS.this_nVlFretes  = TratarNulo(VlFretes,  "N")
                THIS.this_nFiscals   = TratarNulo(nFiscals,  "N")
                THIS.this_nLocalEnts = TratarNulo(LocalEnts, "N")
                THIS.this_cContaEs   = TratarNulo(ContaEs,   "C")
                THIS.this_nLocEntObs = TratarNulo(LocEntObs, "N")
                THIS.this_nDespAces  = TratarNulo(DespAces,  "N")
                THIS.this_nVlSeguros = TratarNulo(VlSeguros, "N")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION InicializarDados(par_oFormPai)
    *==========================================================================
    *-- Inicializa CsPrazE a partir dos cursores do formulario pai.
    *-- par_oFormPai: referencia ao form pai (ex: Formsigatcrp).
    *-- Pre-requisito: TprMvCab, CrSigCdOpe, CrSigMvNfi, crTpmMvItn abertos.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_nResult, loc_cEmpDopNum
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Conex" + CHR(227) + "o com banco de dados n" + ;
                        CHR(227) + "o estabelecida.", "Erro")
            ELSE
                IF !USED("TprMvCab")
                    MsgErro("Cursor TprMvCab n" + CHR(227) + "o est" + ;
                            CHR(225) + " aberto.", "Erro")
                ELSE
                    IF !USED("CrSigCdOpe")
                        MsgErro("Cursor CrSigCdOpe n" + CHR(227) + "o est" + ;
                                CHR(225) + " aberto.", "Erro")
                    ELSE
                        *-- Armazenar dados do cabecalho do movimento
                        SELECT TprMvCab
                        THIS.this_cEmps            = ALLTRIM(TprMvCab.Emps)
                        THIS.this_cDopesParent     = ALLTRIM(TprMvCab.Dopes)
                        THIS.this_nNumesParent     = TprMvCab.Numes
                        THIS.this_cEmpDnCrds       = ALLTRIM(TprMvCab.Emps) + ;
                                                     ALLTRIM(TprMvCab.Dopes) + ;
                                                     STR(TprMvCab.Numes, 6)
                        THIS.this_dDatasParent     = TprMvCab.Datas
                        THIS.this_cLocalEntsParent = ALLTRIM(TprMvCab.LocalEnts)
                        THIS.this_cContaEsParent   = ALLTRIM(TprMvCab.ContaEs)
                        THIS.this_nCodObsParent    = TprMvCab.CodObs
                        THIS.this_cObsEsParent     = ALLTRIM(TprMvCab.ObsEs)
                        THIS.this_cContaDs         = ALLTRIM(TprMvCab.ContaDs)
                        THIS.this_cContaOs         = ALLTRIM(TprMvCab.ContaOs)
                        THIS.this_nValVars         = NVL(TprMvCab.ValVars, 0)

                        *-- Carregar totais das notas fiscais
                        IF USED("CrSigMvNfi")
                            SELECT CrSigMvNfi
                            THIS.this_nFrtTotal  = NVL(CrSigMvNfi.VlFretes, 0)
                            THIS.this_nDespTotal = NVL(CrSigMvNfi.DespAces, 0)
                            THIS.this_nSegTotal  = NVL(CrSigMvNfi.VlSeguros, 0)
                        ENDIF

                        *-- Query 1: dados anteriores do movimento em SigMvCab
                        loc_cEmpDopNum = THIS.this_cEmpDnCrds
                        loc_cSQL = "SELECT Dopes, PrazoEnts, LocalEnts, ContaEs, " + ;
                                   "CodObs, ObsEs " + ;
                                   "FROM SigMvCab " + ;
                                   "WHERE EmpDnCrds = '" + ALLTRIM(loc_cEmpDopNum) + "'"
                        IF USED("CsPedAnt")
                            USE IN CsPedAnt
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPedAnt")
                        IF loc_nResult < 1
                            MsgErro("Falha ao carregar dados anteriores (CsPedAnt).", "Erro")
                        ELSE
                            SELECT CsPedAnt
                            INDEX ON Dopes TAG Dopes

                            *-- Query 2: operacoes via SigCdMop + SigCdOpe + SigOpCdc
                            IF USED("CsPed")
                                USE IN CsPed
                            ENDIF
                            loc_cSQL = "SELECT a.cDopes, a.cnivels AS Dopes, " + ;
                                       "a.nCors, a.padraos, " + ;
                                       "b.abrevs, b.DtEntrs, b.nFiscals, " + ;
                                       "c.nMinEnts, c.nMaxEnts " + ;
                                       "FROM SigCdMop a, SigCdOpe b, SigOpCdc c " + ;
                                       "WHERE a.cDopes = '" + ALLTRIM(CrSigCdOpe.Dopes) + "' " + ;
                                       "AND a.cnivels = b.dopes " + ;
                                       "AND b.Abrevs <> ' ' AND b.Dopes = c.Dopes"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPed")
                            IF loc_nResult < 1
                                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(245) + ;
                                        "es do pedido (CsPed).", "Erro")
                            ELSE
                                SELECT CsPed
                                INDEX ON nCors  TAG nCors
                                INDEX ON Abrevs TAG Abrevs

                                *-- Query 3: valores minimos por operacao (SigOpCdd)
                                IF USED("crTodosOpe2")
                                    USE IN crTodosOpe2
                                ENDIF
                                loc_cSQL = "SELECT Dopes, chkUteis, MinFretes, " + ;
                                           "MinSeguros, MinDesps FROM SigOpCdd"
                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTodosOpe2")
                                IF loc_nResult < 1
                                    MsgErro("Falha ao carregar valores m" + CHR(237) + ;
                                            "nimos (crTodosOpe2).", "Erro")
                                ELSE
                                    SELECT crTodosOpe2
                                    INDEX ON Dopes TAG Dopes

                                    *-- Query 4: LocEntObs/chkUteis por operacao
                                    IF USED("CsPedOpe2")
                                        USE IN CsPedOpe2
                                    ENDIF
                                    loc_cSQL = "SELECT b.dopes, c.LocEntObs, c.chkUteis " + ;
                                               "FROM SigCdMop a, SigCdOpe b, SigOpCdd c " + ;
                                               "WHERE a.cDopes = '" + ;
                                               ALLTRIM(CrSigCdOpe.Dopes) + "' " + ;
                                               "AND a.cnivels = b.dopes " + ;
                                               "AND b.Abrevs <> ' ' AND b.Dopes = c.Dopes"
                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPedOpe2")
                                    IF loc_nResult < 1
                                        MsgErro("Falha ao carregar dados de opera" + ;
                                                CHR(231) + CHR(227) + "o (CsPedOpe2).", "Erro")
                                    ELSE
                                        SELECT CsPedOpe2
                                        INDEX ON Dopes TAG Dopes

                                        *-- Abreviaturas distintas dos itens do movimento
                                        IF USED("Itens")
                                            USE IN Itens
                                        ENDIF
                                        SELECT DISTINCT AbrevIs FROM crTpmMvItn ;
                                            WHERE Cpros <> ' ' AND Qtds <> 0 ;
                                            INTO CURSOR Itens READWRITE

                                        *-- Montar CsPedidos: CsPed x Itens
                                        IF USED("CsPedidos")
                                            USE IN CsPedidos
                                        ENDIF
                                        SELECT a.*, 0 AS LocEntObs ;
                                            FROM CsPed a, Itens b ;
                                            WHERE a.Abrevs = b.AbrevIs ;
                                            INTO CURSOR CsPedidos READWRITE
                                        SELECT CsPedidos
                                        INDEX ON nCors  TAG nCors
                                        INDEX ON Abrevs TAG Abrevs

                                        *-- Criar CsPrazE
                                        IF USED("CsPrazE")
                                            USE IN CsPrazE
                                        ENDIF
                                        SET NULL ON
                                        CREATE CURSOR CsPrazE ( ;
                                            Dopes     C(20)    NULL, ;
                                            Abrevs    C(3)     NULL, ;
                                            Prazos    T        NULL, ;
                                            DtEntrs   N(1)     NULL, ;
                                            nMinEnts  N(3)     NULL, ;
                                            nMaxEnts  N(3)     NULL, ;
                                            VlFretes  N(12,2)  NULL, ;
                                            nFiscals  N(1)     NULL, ;
                                            LocalEnts N(10)    NULL, ;
                                            ContaEs   C(10)    NULL, ;
                                            LocEntObs N(1)     NULL, ;
                                            DespAces  N(12,2)  NULL, ;
                                            VlSeguros N(12,2)  NULL )
                                        SET NULL OFF

                                        *-- Popular CsPrazE escaneando CsPedidos
                                        SELECT CsPedidos
                                        SCAN
                                            =SEEK(CsPedidos.Dopes, "CsPedOpe2", "Dopes")

                                            INSERT INTO CsPrazE ;
                                                (Dopes, Abrevs, Prazos, DtEntrs, ;
                                                 nMinEnts, nMaxEnts, VlFretes, ;
                                                 nFiscals, LocEntObs) ;
                                                VALUES ( ;
                                                    CsPedidos.Dopes, ;
                                                    CsPedidos.Abrevs, ;
                                                    IIF(EMPTY(TprMvCab.PrazoEnts), ;
                                                        DTOT({}), ;
                                                        TprMvCab.PrazoEnts), ;
                                                    CsPedidos.DtEntrs, ;
                                                    CsPedidos.nMinEnts, ;
                                                    CsPedidos.nMaxEnts, ;
                                                    0, ;
                                                    CsPedidos.nfiscals, ;
                                                    NVL(CsPedOpe2.LocEntObs, 0) )

                                            SELECT CsPedidos

                                            IF INLIST(CsPedidos.DtEntrs, 3, 4, 5, 6)
                                                REPLACE LocalEnts WITH TprMvCab.LocalEnts, ;
                                                        ContaEs   WITH TprMvCab.ContaEs ;
                                                        IN CsPrazE
                                            ENDIF

                                            INSERT INTO TprMvCabG ;
                                                (Dopes, Abrevs, CodObs, ObsEs) ;
                                                VALUES (CsPedidos.Dopes, ;
                                                        CsPedidos.Abrevs, ;
                                                        TprMvCab.CodObs, ;
                                                        TprMvCab.ObsEs)

                                            SELECT CsPedidos

                                            *-- Restaurar prazos/contas do pedido anterior
                                            =SEEK(CsPedidos.Dopes, "CsPedAnt", "Dopes")
                                            IF !EOF("CsPedAnt")
                                                REPLACE Prazos WITH IIF( ;
                                                        EMPTY(TprMvCab.PrazoEnts), ;
                                                        IIF(EMPTY(CsPedAnt.PrazoEnts), ;
                                                            DTOT({}), ;
                                                            CsPedAnt.PrazoEnts), ;
                                                        TprMvCab.PrazoEnts), ;
                                                        LocalEnts WITH CsPedAnt.LocalEnts, ;
                                                        ContaEs   WITH CsPedAnt.ContaEs ;
                                                        IN CsPrazE
                                                REPLACE CodObs WITH CsPedAnt.CodObs, ;
                                                        ObsEs  WITH CsPedAnt.ObsEs ;
                                                        IN TprMvCabG
                                                SELECT CsPedidos
                                            ENDIF
                                        ENDSCAN

                                        SELECT CsPrazE
                                        GO TOP
                                        IF RECCOUNT("CsPrazE") = 0
                                            MsgAviso("N" + CHR(227) + "o h" + ;
                                                     CHR(225) + " opera" + CHR(231) + ;
                                                     CHR(245) + "es de prazo para " + ;
                                                     "este movimento.", "Aviso")
                                        ELSE
                                            THIS.AtualizarTotais()
                                            loc_lSucesso = .T.
                                        ENDIF
                                    ENDIF  && CsPedOpe2
                                ENDIF  && crTodosOpe2
                            ENDIF  && CsPed
                        ENDIF  && CsPedAnt
                    ENDIF  && CrSigCdOpe
                ENDIF  && TprMvCab
            ENDIF  && gnConnHandle

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoLinhaGrid(par_cDopes)
    *==========================================================================
    *-- Carrega dados de SigCdOpe+SigOpCdc para a linha corrente do grid.
    *-- Popula this_nExibSits, this_nChCtEntrs, this_nDtEntrsOpe, this_nDigObs.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Dopes, a.ExibSits, b.ChCtEntrs, b.DtEntrs, b.DigObs " + ;
                       "FROM SigCdOpe a, SigOpCdc b " + ;
                       "WHERE a.Dopes = '" + ALLTRIM(par_cDopes) + "' " + ;
                       "AND a.dopes = b.dopes"
            IF USED("LocTmpOpe")
                USE IN LocTmpOpe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocTmpOpe")
            IF loc_nResult >= 1
                SELECT LocTmpOpe
                GO TOP
                THIS.this_nExibSits   = NVL(LocTmpOpe.ExibSits,  0)
                THIS.this_nChCtEntrs  = NVL(LocTmpOpe.ChCtEntrs, 0)
                THIS.this_nDtEntrsOpe = NVL(LocTmpOpe.DtEntrs,   0)
                THIS.this_nDigObs     = NVL(LocTmpOpe.DigObs,    0)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Confirmar()
    *==========================================================================
    *-- Valida todos os prazos e atualiza crTpmMvItn com os dados de CsPrazE.
    *-- Retorna .T. se confirmado com sucesso.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_lcMsg, loc_ldDat, loc_ldEnt, loc_tEmpty
        loc_lSucesso = .F.
        loc_tEmpty   = DTOT({})

        TRY
            IF !USED("CsPrazE")
                MsgErro("Cursor CsPrazE n" + CHR(227) + "o est" + CHR(225) + ;
                        " aberto.", "Erro")
            ELSE
                IF !USED("crTpmMvItn")
                    MsgErro("Cursor crTpmMvItn n" + CHR(227) + "o est" + ;
                            CHR(225) + " aberto.", "Erro")
                ELSE
                    *-- Limpar campos de entrega antes de regravar
                    UPDATE crTpmMvItn ;
                        SET PrzEnts   = m.loc_tEmpty, ;
                            ValFrts   = 0, ;
                            LocalEnts = 0, ;
                            ValSegs   = 0, ;
                            ContaEs   = "", ;
                            DespAces  = 0

                    loc_lSucesso = .T.

                    *-- Escanear CsPrazE validando e atualizando crTpmMvItn
                    SELECT CsPrazE
                    SCAN WHILE loc_lSucesso
                        *-- Validar prazo de entrega se operacao exige data
                        IF INLIST(CsPrazE.DtEntrs, 1, 4, 6)
                            IF EMPTY(CsPrazE.Prazos)
                                MsgAviso("Prazo de Entrega da Opera" + CHR(231) + ;
                                         CHR(227) + "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                         " deve ser informado...", ;
                                         "Obrigat" + CHR(243) + "rio")
                                loc_lSucesso = .F.
                            ENDIF

                            IF loc_lSucesso
                                loc_ldDat = TTOD(CsPrazE.Prazos)
                                IF loc_ldDat < THIS.this_dDatasParent
                                    MsgAviso("Prazo de Entrega da Opera" + ;
                                             CHR(231) + CHR(227) + "o " + ;
                                             ALLTRIM(CsPrazE.Dopes) + ;
                                             " deve ser maior que a Data da " + ;
                                             "Movimenta" + CHR(231) + CHR(227) + "o...", ;
                                             "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND CsPrazE.nMinEnts > 0
                                loc_ldEnt = THIS.this_dDatasParent + CsPrazE.nMinEnts
                                IF TTOD(CsPrazE.Prazos) < loc_ldEnt
                                    MsgAviso("Prazo de Entrega M" + CHR(237) + ;
                                             "nimo da Opera" + CHR(231) + CHR(227) + ;
                                             "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                             " " + CHR(233) + " " + DTOC(loc_ldEnt) + ;
                                             "...", "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND CsPrazE.nMaxEnts > 0
                                loc_ldEnt = THIS.this_dDatasParent + CsPrazE.nMaxEnts
                                IF TTOD(CsPrazE.Prazos) > loc_ldEnt
                                    MsgAviso("Prazo de Entrega M" + CHR(225) + ;
                                             "ximo da Opera" + CHR(231) + CHR(227) + ;
                                             "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                             " " + CHR(233) + " " + DTOC(loc_ldEnt) + ;
                                             "...", "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Validar local de entrega obrigatorio
                        IF loc_lSucesso AND CsPrazE.LocEntObs = 1 AND ;
                           INLIST(CsPrazE.DtEntrs, 3, 4, 5, 6) AND ;
                           CsPrazE.LocalEnts = 0
                            MsgAviso("Local de Entrega da Opera" + CHR(231) + ;
                                     CHR(227) + "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                     " n" + CHR(227) + "o Informado!!!", ;
                                     "Obrigat" + CHR(243) + "rio")
                            loc_lSucesso = .F.
                        ENDIF

                        *-- Validar valores minimos (Frete / Desp. Acessorias)
                        IF loc_lSucesso AND USED("crTodosOpe2")
                            =SEEK(CsPrazE.Dopes, "crTodosOpe2", "Dopes")
                            loc_lcMsg = ""
                            IF !EOF("crTodosOpe2")
                                IF !EMPTY(crTodosOpe2.MinFretes) AND ;
                                   (CsPrazE.VlFretes < crTodosOpe2.MinFretes)
                                    loc_lcMsg = loc_lcMsg + ;
                                                IIF(EMPTY(loc_lcMsg), "", " / ") + ;
                                                "Frete"
                                ENDIF
                                IF !EMPTY(crTodosOpe2.MinDesps) AND ;
                                   (CsPrazE.DespAces < crTodosOpe2.MinDesps)
                                    loc_lcMsg = loc_lcMsg + ;
                                                IIF(EMPTY(loc_lcMsg), "", " / ") + ;
                                                "Desp. Acess" + CHR(243) + "rias"
                                ENDIF
                                IF !EMPTY(loc_lcMsg)
                                    MsgAviso("Existem Valores Na Opera" + CHR(231) + ;
                                             CHR(227) + "o Abaixo do M" + CHR(237) + ;
                                             "nimo : " + loc_lcMsg, "ERRO")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF
                            SELECT CsPrazE
                        ENDIF

                        *-- Atualizar crTpmMvItn com dados validados
                        IF loc_lSucesso
                            UPDATE crTpmMvItn SET ;
                                PrzEnts   = CsPrazE.Prazos, ;
                                ValFrts   = CsPrazE.VlFretes, ;
                                LocalEnts = CsPrazE.LocalEnts, ;
                                ValSegs   = CsPrazE.VlSeguros, ;
                                ContaEs   = CsPrazE.ContaEs, ;
                                DespAces  = CsPrazE.DespAces ;
                                WHERE ALLTRIM(AbrevIs) = ALLTRIM(CsPrazE.Abrevs)
                            SELECT CsPrazE
                        ENDIF
                    ENDSCAN

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("ATUALIZAR")
                    ENDIF
                ENDIF  && crTpmMvItn
            ENDIF  && CsPrazE

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Confirmar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarTotais()
    *==========================================================================
    *-- Recalcula this_nFrtInformado/this_nDespInformado/this_nSegInformado.
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF USED("CsPrazE")
                SELECT SUM(NVL(VlFretes, 0))  AS TotFrt, ;
                       SUM(NVL(DespAces, 0))  AS TotDesp, ;
                       SUM(NVL(VlSeguros, 0)) AS TotSeg ;
                    FROM CsPrazE ;
                    INTO CURSOR cursor_4c_TotaisPzo READWRITE
                IF USED("cursor_4c_TotaisPzo")
                    SELECT cursor_4c_TotaisPzo
                    GO TOP
                    THIS.this_nFrtInformado  = NVL(TotFrt,  0)
                    THIS.this_nDespInformado = NVL(TotDesp, 0)
                    THIS.this_nSegInformado  = NVL(TotSeg,  0)
                    USE IN cursor_4c_TotaisPzo
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.AtualizarTotais")
        ENDTRY
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoConta(par_cConta, par_nChCtEntrs)
    *==========================================================================
    *-- Carrega dados de cliente (conta de entrega) de SigCdCli.
    *-- Popula this_cGetConta, this_cGetDConta, this_cGetCpf.
    *-- Retorna .T. se encontrou e passou nas validacoes.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cConta)
                THIS.this_cGetConta  = ""
                THIS.this_cGetDConta = ""
                THIS.this_cGetCpf    = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT IClis, RClis, Cpfs FROM SigCdCli " + ;
                           "WHERE IClis = '" + ALLTRIM(par_cConta) + "'"
                IF USED("CrTmpCli")
                    USE IN CrTmpCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpCli")
                IF loc_nResult < 1
                    MsgErro("Falha ao carregar dados do cliente.", "Erro")
                ELSE
                    SELECT CrTmpCli
                    GO TOP
                    IF !EOF("CrTmpCli")
                        *-- Validar conta de entrega (nao pode ser igual a destino/origem)
                        IF par_nChCtEntrs = 1 AND ;
                           ALLTRIM(CrTmpCli.IClis) == ALLTRIM(THIS.this_cContaDs)
                            MsgAviso("Conta de Entrega Tem que ser diferente da " + ;
                                     "Conta de Destino", ;
                                     "Valida" + CHR(231) + CHR(227) + "o")
                        ELSE
                            IF par_nChCtEntrs = 2 AND ;
                               ALLTRIM(CrTmpCli.IClis) == ALLTRIM(THIS.this_cContaOs)
                                MsgAviso("Conta de Entrega Tem que ser diferente da " + ;
                                         "Conta de Origem", ;
                                         "Valida" + CHR(231) + CHR(227) + "o")
                            ELSE
                                THIS.this_cGetConta  = ALLTRIM(CrTmpCli.IClis)
                                THIS.this_cGetDConta = ALLTRIM(CrTmpCli.RClis)
                                THIS.this_cGetCpf    = ALLTRIM(CrTmpCli.Cpfs)
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("CrTmpCli")
                        USE IN CrTmpCli
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoConta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoObservacao(par_nCodObs, par_cDopesOpe)
    *==========================================================================
    *-- Busca observacao de SigCdObs filtrando pela faixa da operacao.
    *-- Popula this_nCodObs e this_cObsEs. Retorna .T. se encontrou.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        LOCAL loc_nIni, loc_nFim
        loc_lSucesso = .F.

        TRY
            *-- Buscar faixa de observacoes da operacao
            loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
                       "WHERE Dopes = '" + ALLTRIM(par_cDopesOpe) + "'"
            IF USED("LocalOpe")
                USE IN LocalOpe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalOpe")
            IF loc_nResult < 1
                MsgErro("Falha ao carregar dados da opera" + CHR(231) + ;
                        CHR(227) + "o.", "Erro")
            ELSE
                SELECT LocalOpe
                GO TOP
                loc_nIni = IIF(!EOF("LocalOpe") AND !EMPTY(LocalOpe.ObsInis), ;
                               LocalOpe.ObsInis, 0)
                loc_nFim = IIF(!EOF("LocalOpe") AND !EMPTY(LocalOpe.ObsFins), ;
                               LocalOpe.ObsFins, 999)
                IF USED("LocalOpe")
                    USE IN LocalOpe
                ENDIF

                *-- Carregar observacoes na faixa da operacao
                loc_cSQL = "SELECT Codigos, Descrs, Observas FROM SigCdObs " + ;
                           "WHERE Codigos BETWEEN " + TRANSFORM(loc_nIni) + ;
                           " AND " + TRANSFORM(loc_nFim)
                IF USED("crLocalObs")
                    USE IN crLocalObs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalObs")
                IF loc_nResult < 1
                    MsgErro("Falha ao carregar observa" + CHR(231) + CHR(245) + ;
                            "es (crLocalObs).", "Erro")
                ELSE
                    SELECT crLocalObs
                    INDEX ON Codigos TAG Codigos

                    IF SEEK(par_nCodObs, "crLocalObs", "Codigos")
                        THIS.this_nCodObs = NVL(crLocalObs.Codigos, 0)
                        THIS.this_cObsEs  = ALLTRIM(NVL(crLocalObs.Observas, ""))
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoObservacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Inserir()
    *==========================================================================
    *-- Operacional: registra auditoria de insercao se CsPrazE inicializado.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("CsPrazE n" + CHR(227) + "o inicializado. " + ;
                        "Chamar InicializarDados() antes de Inserir().", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Atualizar()
    *==========================================================================
    *-- Operacional: delega para Confirmar() que valida e salva CsPrazE.
    *==========================================================================
        RETURN THIS.Confirmar()
    ENDPROC

    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
    *==========================================================================
        LOCAL loc_oErro, loc_cSQL
        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND ;
               !EMPTY(THIS.this_cEmpDnCrds) AND !EMPTY(gc_4c_UsuarioLogado)
                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                           "(DataHora, Usuario, Operacao, Tabela, " + ;
                           "ChavePrimaria, Empresa) " + ;
                           "VALUES (" + ;
                           "GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL("SigMvCab") + ", " + ;
                           EscaparSQL(THIS.this_cEmpDnCrds) + ", " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

