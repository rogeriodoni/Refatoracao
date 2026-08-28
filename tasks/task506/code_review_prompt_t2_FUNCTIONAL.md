# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [METODO-INEXISTENTE] Metodo 'THIS.AtualizarLinhaGrid()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirBuscaConta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirBuscaCpf()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AtualizarTotaisNaTela()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.EncerrarClick()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormPzo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1955 linhas total):

*-- Linhas 9 a 171:
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
93:                     THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
94:                     THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
95:                     THIS.ConfigurarPaginaLista()
96:                     THIS.ConfigurarBotaoEncerrar()
97:                     THIS.BindEventos()
98: 
99:                     *-- Atualizar totais iniciais na tela (usando totais da NF do pai)
100:                     THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
101:                     THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
102:                     THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
103:                     THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
104:                     THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
105:                     THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado
106: 
107:                     *-- Posicionar na primeira linha e atualizar containers
108:                     IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
109:                         SELECT CsPrazE
110:                         GO TOP
111:                         THIS.AtualizarLinhaGrid(1)
112:                     ENDIF
113: 
114:                     loc_lSucesso = .T.
115:                 ENDIF
116:             ENDIF
117: 
118:         CATCH TO loc_oErro
119:             MsgErro(loc_oErro.Message + CHR(13) + ;
120:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
121:                     "Procedure: " + loc_oErro.Procedure, ;
122:                     "Erro em FormPzo.InicializarForm")
123:         ENDTRY
124: 
125:         RETURN loc_lSucesso
126:     ENDPROC
127: 
128:     *==========================================================================
129:     * ConfigurarCabecalho - Container escuro com titulo do form
130:     *==========================================================================
131:     PROTECTED PROCEDURE ConfigurarCabecalho()
132:         LOCAL loc_oCnt
133:         THIS.AddObject("cnt_4c_Sombra", "Container")
134:         loc_oCnt = THIS.cnt_4c_Sombra
135:         WITH loc_oCnt
136:             .Top         = 0
137:             .Left        = 0
138:             .Width       = THIS.Width
139:             .Height      = 80
140:             .BorderWidth = 0
141:             .BackColor   = RGB(100, 100, 100)
142:             .Visible     = .T.
143:         ENDWITH
144:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oCnt.lbl_4c_Sombra
146:             .FontBold      = .T.
147:             .FontName      = "Tahoma"
148:             .FontSize      = 18
149:             .FontUnderline = .F.
150:             .WordWrap      = .T.
151:             .Alignment     = 0
152:             .BackStyle     = 0
153:             .AutoSize      = .F.
154:             .Caption       = "Prazo / Conta de Entrega"
155:             .Height        = 40
156:             .Left          = 10
157:             .Top           = 18
158:             .Width         = 769
159:             .ForeColor     = RGB(0, 0, 0)
160:             .Visible       = .T.
161:         ENDWITH
162:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
163:         WITH loc_oCnt.lbl_4c_Titulo
164:             .FontBold   = .T.
165:             .FontName   = "Tahoma"
166:             .FontSize   = 18
167:             .WordWrap   = .T.
168:             .Alignment  = 0
169:             .BackStyle  = 0
170:             .AutoSize   = .F.
171:             .Caption    = "Prazo / Conta de Entrega"

*-- Linhas 181 a 276:
181:     *==========================================================================
182:     * ConfigurarPaginaLista - Orquestra lado LISTA: grid, entrega e binding
183:     *==========================================================================
184:     PROTECTED PROCEDURE ConfigurarPaginaLista()
185:         *-- 1. Grid de operacoes (estrutura de colunas)
186:         THIS.ConfigurarGrid()
187: 
188:         *-- 2. Campos suplementares/DADOS (totais + observacao)
189:         THIS.ConfigurarPaginaDados()
190: 
191:         *-- 3. Container de entrega (inicialmente oculto ate selecao de linha)
192:         THIS.ConfigurarContainerEntrega()
193: 
194:         *-- 4. Conectar grid ao cursor CsPrazE (RecordSource + ControlSources)
195:         THIS.ConfigurarGridDados()
196: 
197:         *-- 5. Formas decorativas (Shape1/3/4/5 do original SCX)
198:         THIS.ConfigurarFormas()
199:     ENDPROC
200: 
201:     *==========================================================================
202:     * ConfigurarPaginaDados - Campos DADOS parte 1 (totais + observacao)
203:     *   Forma OPERACIONAL sem PageFrame - agrega os controles de dados abaixo
204:     *   do grid: area de totais Frete/Desp/Seguro + container de observacao
205:     *==========================================================================
206:     PROTECTED PROCEDURE ConfigurarPaginaDados()
207:         *-- Area de totais (Frete/Despesas Acessorias/Seguro): 6 labels + 6 textboxes
208:         THIS.ConfigurarAreaTotais()
209: 
210:         *-- Container de observacao (codigo + memo, oculto ate selecao de linha)
211:         THIS.ConfigurarContainerObservacao()
212:     ENDPROC
213: 
214:     *==========================================================================
215:     * AlternarPagina - Alterna visibilidade dos paineis suplementares por linha
216:     *   par_nDtEntrs : valor do campo DtEntrs da operacao corrente
217:     *   par_nDigObs  : valor do campo DigObs da operacao corrente
218:     *==========================================================================
219:     FUNCTION AlternarPagina(par_nDtEntrs, par_nDigObs)
220:         LOCAL loc_nDtEntrs, loc_nDigObs
221:         loc_nDtEntrs = IIF(VARTYPE(par_nDtEntrs) = "N", par_nDtEntrs, 0)
222:         loc_nDigObs  = IIF(VARTYPE(par_nDigObs)  = "N", par_nDigObs,  0)
223: 
224:         *-- Entrega visivel quando DtEntrs IN (3,4,5,6) - tipos de entrega com destinatario
225:         THIS.cnt_4c_Entrega.Visible    = INLIST(loc_nDtEntrs, 3, 4, 5, 6)
226: 
227:         *-- Observacao visivel quando DigObs IN (1,3) - digitacao de observacao permitida
228:         THIS.cnt_4c_Observacao.Visible = INLIST(loc_nDigObs, 1, 3)
229: 
230:         THIS.Refresh()
231:     ENDPROC
232: 
233:     *==========================================================================
234:     * ConfigurarGrid - Grid principal mostrando CsPrazE por operacao
235:     *==========================================================================
236:     PROTECTED PROCEDURE ConfigurarGrid()
237:         LOCAL loc_oGrid, loc_oCol
238: 
239:         THIS.AddObject("grd_4c_Dados", "Grid")
240:         loc_oGrid = THIS.grd_4c_Dados
241: 
242:         WITH loc_oGrid
243:             .Top               = 89
244:             .Left              = 7
245:             .Width             = 889
246:             .Height            = 246
247:             .ColumnCount       = 5
248:             .FontName          = "Verdana"
249:             .FontSize          = 8
250:             .AllowHeaderSizing = .F.
251:             .AllowRowSizing    = .F.
252:             .DeleteMark        = .F.
253:             .HeaderHeight      = 20
254:             .RowHeight         = 16
255:             .ScrollBars        = 2
256:             .SplitBar          = .F.
257:             .GridLineColor     = RGB(238, 238, 238)
258:             .Themes            = .F.
259:             .Visible           = .T.
260:         ENDWITH
261: 
262:         *-- Column1: Movimentacao (Dopes) - somente leitura
263:         loc_oCol = loc_oGrid.Column1
264:         WITH loc_oCol
265:             .ColumnOrder      = 1
266:             .Width            = 290
267:             .ReadOnly         = .T.
268:             .FontName         = "Verdana"
269:             .FontSize         = 8
270:         ENDWITH
271:         loc_oCol.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
272:         loc_oCol.Header1.FontName  = "Verdana"
273:         loc_oCol.Header1.FontSize  = 8
274:         loc_oCol.Header1.Alignment = 2
275:         loc_oCol.Text1.BorderStyle = 0
276:         loc_oCol.Text1.Margin      = 0

*-- Linhas 361 a 452:
361:     *==========================================================================
362:     * ConfigurarGridDados - Define RecordSource/ControlSources e coloracao
363:     *==========================================================================
364:     PROTECTED PROCEDURE ConfigurarGridDados()
365:         LOCAL loc_oGrid
366:         LOCAL loc_cDynFc, loc_nQtdSc, loc_nVez, loc_nCor
367:         loc_oGrid = THIS.grd_4c_Dados
368: 
369:         loc_oGrid.RecordSource     = "CsPrazE"
370:         loc_oGrid.RecordSourceType = 1
371:         loc_oGrid.Column1.ControlSource = "CsPrazE.Dopes"
372:         loc_oGrid.Column2.ControlSource = "CsPrazE.Prazos"
373:         loc_oGrid.Column3.ControlSource = "CsPrazE.VlFretes"
374:         loc_oGrid.Column4.ControlSource = "CsPrazE.DespAces"
375:         loc_oGrid.Column5.ControlSource = "CsPrazE.VlSeguros"
376:         loc_oGrid.Refresh()
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
403:                 loc_cDynFc = loc_cDynFc + "0" + REPLICATE(")", loc_nQtdSc)
404:                 loc_oGrid.SetAll("DynamicForeColor", loc_cDynFc, "Column")
405:             ENDIF
406:         ENDIF
407:     ENDPROC
408: 
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
871:             .FontName    = "Tahoma"
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

*-- Linhas 975 a 1018:
975:         CATCH TO loc_oErro
976:             MsgErro(loc_oErro.Message + CHR(13) + ;
977:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
978:                     "Procedure: " + loc_oErro.Procedure, ;
979:                     "Erro em FormPzo.AtualizarTotaisNaTela")
980:         ENDTRY
981:     ENDPROC
982: 
983:     *==========================================================================
984:     * ValidarConta - LostFocus txt_4c_Conta: busca e valida conta de entrega
985:     *==========================================================================
986:     FUNCTION ValidarConta()
987:         LOCAL loc_cConta, loc_lOk
988:         loc_cConta = ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_Conta.Value)
989: 
990:         IF EMPTY(loc_cConta)
991:             THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
992:             THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
993:             THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly    = .F.
994:             THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly = .F.
995:             IF USED("CsPrazE")
996:                 REPLACE ContaEs WITH "" IN CsPrazE
997:             ENDIF
998:             RETURN
999:         ENDIF
1000: 
1001:         loc_lOk = THIS.this_oBusinessObject.CarregarInfoConta(loc_cConta, ;
1002:                       THIS.this_oBusinessObject.this_nChCtEntrs)
1003:         IF loc_lOk
1004:             THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = THIS.this_oBusinessObject.this_cGetConta
1005:             THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = THIS.this_oBusinessObject.this_cGetCpf
1006:             THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = THIS.this_oBusinessObject.this_cGetDConta
1007:             THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly    = .T.
1008:             THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly = .T.
1009:         ELSE
1010:             THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
1011:             THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
1012:             THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
1013:             THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly    = .F.
1014:             THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly = .F.
1015:             IF USED("CsPrazE")
1016:                 REPLACE ContaEs WITH "" IN CsPrazE
1017:             ENDIF
1018:             THIS.AbrirBuscaConta(loc_cConta)

*-- Linhas 1072 a 1148:
1072:             IF loc_lContinuar
1073:                 loc_cIClis = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
1074:                 IF EMPTY(loc_cIClis)
1075:                     MsgAviso("Informe a Conta de Entrega antes de selecionar o Local.", ;
1076:                              "Aviso")
1077:                     loc_lContinuar = .F.
1078:                 ENDIF
1079:             ENDIF
1080: 
1081:             IF loc_lContinuar
1082:                 *-- Buscar dados do cliente para abrir FormEnd
1083:                 loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = '" + ;
1084:                            ALLTRIM(loc_cIClis) + "'"
1085:                 IF USED("crTSigDCompCli")
1086:                     USE IN crTSigDCompCli
1087:                 ENDIF
1088:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTSigDCompCli")
1089:                 IF loc_nResult >= 1
1090:                     SELECT crTSigDCompCli
1091:                     GO TOP
1092:                     loc_cGrupo = ALLTRIM(NVL(crTSigDCompCli.Grupos, ""))
1093:                     loc_cNome  = ALLTRIM(NVL(crTSigDCompCli.RClis,  ""))
1094:                     loc_nLocal = NVL(CsPrazE.LocalEnts, 0)
1095: 
1096:                     DO FORM FormEnd WITH ;
1097:                         loc_cGrupo, loc_cIClis, loc_cNome, ;
1098:                         THIS.this_oBusinessObject.this_cEscolha, .NULL., loc_nLocal
1099:                 ENDIF
1100:                 IF USED("crTSigDCompCli")
1101:                     USE IN crTSigDCompCli
1102:                 ENDIF
1103:             ENDIF
1104: 
1105:         CATCH TO loc_oErro
1106:             MsgErro(loc_oErro.Message + CHR(13) + ;
1107:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1108:                     "Procedure: " + loc_oErro.Procedure, ;
1109:                     "Erro em FormPzo.EntLocalClick")
1110:         ENDTRY
1111:     ENDPROC
1112: 
1113:     *==========================================================================
1114:     * ValidarCpf - KeyPress txt_4c_Cpf: valida CPF/CNPJ e preenche Conta/Nome
1115:     * Dispara em Enter(13), Tab(9) ou F4(115)
1116:     *==========================================================================
1117:     FUNCTION ValidarCpf(par_nKeyCode, par_nShiftAltCtrl)
1118:         LOCAL loc_cCpf, loc_cCpfFmt, loc_nLen, loc_cSQL, loc_nResult, loc_oErro
1119:         LOCAL loc_lSucesso
1120:         loc_lSucesso = .F.
1121: 
1122:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1123:             RETURN
1124:         ENDIF
1125: 
1126:         loc_cCpf = ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_Cpf.Value)
1127:         IF EMPTY(loc_cCpf)
1128:             RETURN
1129:         ENDIF
1130: 
1131:         *-- Remover formatacao (pontos, tracinho, barra)
1132:         loc_cCpf = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
1133:         loc_nLen = LEN(ALLTRIM(loc_cCpf))
1134:         IF loc_nLen <= 11
1135:             loc_cCpfFmt = TRANSFORM(loc_cCpf, "@R 999.999.999-99")
1136:         ELSE
1137:             loc_cCpfFmt = TRANSFORM(loc_cCpf, "@R 99.999.999/9999-99")
1138:         ENDIF
1139:         THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = loc_cCpfFmt
1140: 
1141:         TRY
1142:             loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE " + ;
1143:                        "RTRIM(Cpfs) = " + EscaparSQL(ALLTRIM(loc_cCpfFmt))
1144:             IF USED("cursor_4c_BuscaCpf")
1145:                 USE IN cursor_4c_BuscaCpf
1146:             ENDIF
1147:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")
1148: 

*-- Linhas 1167 a 1270:
1167:         CATCH TO loc_oErro
1168:             MsgErro(loc_oErro.Message + CHR(13) + ;
1169:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1170:                     "Procedure: " + loc_oErro.Procedure, ;
1171:                     "Erro em FormPzo.ValidarCpf")
1172:         ENDTRY
1173:     ENDPROC
1174: 
1175:     *==========================================================================
1176:     * AbrirBuscaCpf - Abre FormBuscaAuxiliar filtrado por CPF (Pattern A)
1177:     *==========================================================================
1178:     FUNCTION AbrirBuscaCpf(par_cFiltro)
1179:         LOCAL loc_cSQL, loc_nResult, loc_oForm, loc_oErro
1180: 
1181:         TRY
1182:             *-- SQL filtrado por CPF ou codigo (starts-with)
1183:             loc_cSQL = "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis " + ;
1184:                        "FROM SigCdCli WHERE RTRIM(Cpfs) LIKE " + ;
1185:                        EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
1186:                        " OR RTRIM(IClis) LIKE " + ;
1187:                        EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
1188:                        " ORDER BY Cpfs"
1189:             IF USED("cursor_4c_BuscaCpf")
1190:                 USE IN cursor_4c_BuscaCpf
1191:             ENDIF
1192:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")
1193:             IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCpf") = 0
1194:                 IF USED("cursor_4c_BuscaCpf")
1195:                     USE IN cursor_4c_BuscaCpf
1196:                 ENDIF
1197:                 *-- Fallback: lista completa
1198:                 SQLEXEC(gnConnHandle, ;
1199:                     "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis FROM SigCdCli ORDER BY Cpfs", ;
1200:                     "cursor_4c_BuscaCpf")
1201:             ENDIF
1202: 
1203:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1204:             IF VARTYPE(loc_oForm) = "O"
1205:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaCpf"
1206:                 loc_oForm.DefinirCursor("cursor_4c_BuscaCpf", "IClis", "Cpfs", ;
1207:                     "Busca por CPF / CNPJ")
1208:                 IF loc_oForm.Mostrar()
1209:                     THIS.cnt_4c_Entrega.txt_4c_Cpf.Value   = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1210:                     THIS.cnt_4c_Entrega.txt_4c_Conta.Value = ALLTRIM(loc_oForm.cCodigoSelecionado)
1211:                     IF !EMPTY(loc_oForm.cCodigoSelecionado)
1212:                         THIS.this_oBusinessObject.CarregarInfoConta( ;
1213:                             ALLTRIM(loc_oForm.cCodigoSelecionado), ;
1214:                             THIS.this_oBusinessObject.this_nChCtEntrs)
1215:                         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;
1216:                             THIS.this_oBusinessObject.this_cGetDConta
1217:                         IF USED("CsPrazE")
1218:                             REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1219:                         ENDIF
1220:                     ENDIF
1221:                 ENDIF
1222:             ENDIF
1223:             IF USED("cursor_4c_BuscaCpf")
1224:                 USE IN cursor_4c_BuscaCpf
1225:             ENDIF
1226: 
1227:         CATCH TO loc_oErro
1228:             MsgErro(loc_oErro.Message + CHR(13) + ;
1229:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1230:                     "Procedure: " + loc_oErro.Procedure, ;
1231:                     "Erro em FormPzo.AbrirBuscaCpf")
1232:         ENDTRY
1233:     ENDPROC
1234: 
1235:     *==========================================================================
1236:     * ValidarDConta - KeyPress txt_4c_DConta: busca cliente por nome
1237:     * Dispara em Enter(13), Tab(9) ou F4(115)
1238:     *==========================================================================
1239:     FUNCTION ValidarDConta(par_nKeyCode, par_nShiftAltCtrl)
1240:         LOCAL loc_cDConta, loc_cSQL, loc_nResult, loc_oForm, loc_oErro
1241:         LOCAL loc_lSucesso
1242:         loc_lSucesso = .F.
1243: 
1244:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1245:             RETURN
1246:         ENDIF
1247: 
1248:         loc_cDConta = ALLTRIM(THIS.cnt_4c_Entrega.txt_4c_DConta.Value)
1249:         IF EMPTY(loc_cDConta)
1250:             RETURN
1251:         ENDIF
1252: 
1253:         TRY
1254:             *-- Busca exata por nome (RClis)
1255:             loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + ;
1256:                        "RTRIM(RClis) = " + EscaparSQL(loc_cDConta)
1257:             IF USED("cursor_4c_BuscaDConta")
1258:                 USE IN cursor_4c_BuscaDConta
1259:             ENDIF
1260:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDConta")
1261: 
1262:             IF loc_nResult >= 1 AND !EOF("cursor_4c_BuscaDConta")
1263:                 SELECT cursor_4c_BuscaDConta
1264:                 GO TOP
1265:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(NVL(cursor_4c_BuscaDConta.IClis, ""))
1266:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(NVL(cursor_4c_BuscaDConta.RClis, ""))
1267:                 IF USED("CsPrazE")
1268:                     REPLACE ContaEs WITH ALLTRIM(cursor_4c_BuscaDConta.IClis) IN CsPrazE
1269:                 ENDIF
1270:                 THIS.this_oBusinessObject.CarregarInfoConta( ;

*-- Linhas 1291 a 1456:
1291:                         "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY RClis", ;
1292:                         "cursor_4c_BuscaDConta")
1293:                 ENDIF
1294:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1295:                 IF VARTYPE(loc_oForm) = "O"
1296:                     loc_oForm.this_cCursorDestino = "cursor_4c_BuscaDConta"
1297:                     loc_oForm.DefinirCursor("cursor_4c_BuscaDConta", "IClis", "RClis", ;
1298:                         "Busca de Contas")
1299:                     IF loc_oForm.Mostrar()
1300:                         THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
1301:                         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1302:                         IF !EMPTY(loc_oForm.cCodigoSelecionado)
1303:                             IF USED("CsPrazE")
1304:                                 REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1305:                             ENDIF
1306:                             THIS.this_oBusinessObject.CarregarInfoConta( ;
1307:                                 ALLTRIM(loc_oForm.cCodigoSelecionado), ;
1308:                                 THIS.this_oBusinessObject.this_nChCtEntrs)
1309:                             THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cGetCpf
1310:                         ENDIF
1311:                     ENDIF
1312:                 ENDIF
1313:                 IF USED("cursor_4c_BuscaDConta")
1314:                     USE IN cursor_4c_BuscaDConta
1315:                 ENDIF
1316:             ENDIF
1317: 
1318:         CATCH TO loc_oErro
1319:             MsgErro(loc_oErro.Message + CHR(13) + ;
1320:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1321:                     "Procedure: " + loc_oErro.Procedure, ;
1322:                     "Erro em FormPzo.ValidarDConta")
1323:         ENDTRY
1324:     ENDPROC
1325: 
1326:     *==========================================================================
1327:     * EncerrarClick - Botao Encerrar: valida, grava e fecha o form
1328:     *==========================================================================
1329:     FUNCTION EncerrarClick()
1330:         LOCAL loc_oErro
1331:         TRY
1332:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1333:                 IF THIS.this_oBusinessObject.Confirmar()
1334:                     THIS.Release()
1335:                 ENDIF
1336:             ENDIF
1337:         CATCH TO loc_oErro
1338:             MsgErro(loc_oErro.Message + CHR(13) + ;
1339:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1340:                     "Procedure: " + loc_oErro.Procedure, ;
1341:                     "Erro em FormPzo.EncerrarClick")
1342:         ENDTRY
1343:     ENDPROC
1344: 
1345:     *==========================================================================
1346:     * AbrirBuscaConta - Pattern A: abre FormBuscaAuxiliar para SigCdCli
1347:     *   par_cFiltro: valor digitado (prefixo para filtro LIKE)
1348:     *==========================================================================
1349:     FUNCTION AbrirBuscaConta(par_cFiltro)
1350:         LOCAL loc_cSQL, loc_nResult, loc_oForm, loc_oErro
1351:         LOCAL loc_cFiltro
1352:         loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")
1353: 
1354:         TRY
1355:             *-- SQL filtrado por codigo ou nome (starts-with)
1356:             IF EMPTY(loc_cFiltro)
1357:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis"
1358:             ELSE
1359:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli " + ;
1360:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
1361:                            " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
1362:                            " ORDER BY IClis"
1363:             ENDIF
1364: 
1365:             IF USED("cursor_4c_BuscaCli")
1366:                 USE IN cursor_4c_BuscaCli
1367:             ENDIF
1368:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1369:             IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCli") = 0
1370:                 IF USED("cursor_4c_BuscaCli")
1371:                     USE IN cursor_4c_BuscaCli
1372:                 ENDIF
1373:                 SQLEXEC(gnConnHandle, ;
1374:                     "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis", ;
1375:                     "cursor_4c_BuscaCli")
1376:             ENDIF
1377: 
1378:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1379:             IF VARTYPE(loc_oForm) = "O"
1380:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaCli"
1381:                 loc_oForm.DefinirCursor("cursor_4c_BuscaCli", "IClis", "RClis", ;
1382:                     "Busca de Contas de Entrega")
1383:                 IF loc_oForm.Mostrar()
1384:                     THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
1385:                     THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1386:                     IF !EMPTY(loc_oForm.cCodigoSelecionado)
1387:                         IF USED("CsPrazE")
1388:                             REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1389:                         ENDIF
1390:                         THIS.this_oBusinessObject.CarregarInfoConta( ;
1391:                             ALLTRIM(loc_oForm.cCodigoSelecionado), ;
1392:                             THIS.this_oBusinessObject.this_nChCtEntrs)
1393:                         THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cGetCpf
1394:                     ENDIF
1395:                 ENDIF
1396:             ENDIF
1397:             IF USED("cursor_4c_BuscaCli")
1398:                 USE IN cursor_4c_BuscaCli
1399:             ENDIF
1400: 
1401:         CATCH TO loc_oErro
1402:             MsgErro(loc_oErro.Message + CHR(13) + ;
1403:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1404:                     "Procedure: " + loc_oErro.Procedure, ;
1405:                     "Erro em FormPzo.AbrirBuscaConta")
1406:         ENDTRY
1407:     ENDPROC
1408: 
1409:     *==========================================================================
1410:     * ConfigurarFormas - Shapes decorativos (bordas e separadores)
1411:     *   Shape5: borda ao redor do botao Encerrar (Top=7, Left=903, 86x86)
1412:     *   Shape1: linha separadora Frete (Top=365, Left=44, 194x2)
1413:     *   Shape3: linha separadora Desp.Acess (Top=365, Left=315, 194x2)
1414:     *   Shape4: linha separadora Seguro (Top=365, Left=586, 194x2)
1415:     *==========================================================================
1416:     PROTECTED PROCEDURE ConfigurarFormas()
1417:         *-- Borda decorativa ao redor do container Encerrar
1418:         THIS.AddObject("shp_4c_Shape5", "Shape")
1419:         WITH THIS.shp_4c_Shape5
1420:             .Top         = 7
1421:             .Left        = 903
1422:             .Width       = 86
1423:             .Height      = 86
1424:             .ShapeType   = 0
1425:             .FillStyle   = 1
1426:             .BorderColor = RGB(53, 53, 53)
1427:             .BorderWidth = 2
1428:             .Visible     = .T.
1429:         ENDWITH
1430: 
1431:         *-- Linha separadora horizontal abaixo do label "Total" da area Frete
1432:         THIS.AddObject("shp_4c_Shape1", "Shape")
1433:         WITH THIS.shp_4c_Shape1
1434:             .Top         = 365
1435:             .Left        = 44
1436:             .Width       = 194
1437:             .Height      = 2
1438:             .ShapeType   = 0
1439:             .FillStyle   = 0
1440:             .BackColor   = RGB(90, 90, 90)
1441:             .BorderColor = RGB(90, 90, 90)
1442:             .BorderWidth = 1
1443:             .Visible     = .T.
1444:         ENDWITH
1445: 
1446:         *-- Linha separadora horizontal abaixo do label "Total" da area Despesas
1447:         THIS.AddObject("shp_4c_Shape3", "Shape")
1448:         WITH THIS.shp_4c_Shape3
1449:             .Top         = 365
1450:             .Left        = 315
1451:             .Width       = 194
1452:             .Height      = 2
1453:             .ShapeType   = 0
1454:             .FillStyle   = 0
1455:             .BackColor   = RGB(90, 90, 90)
1456:             .BorderColor = RGB(90, 90, 90)

*-- Linhas 1478 a 1705:
1478:     * BtnIncluirClick - Insere nova linha em CsPrazE (novo prazo/conta)
1479:     * Adiciona registro em branco herdando Dopes/Abrevs da linha corrente
1480:     *==========================================================================
1481:     PROCEDURE BtnIncluirClick()
1482:         LOCAL loc_oErro, loc_cDopes, loc_cAbrevs, loc_dPrazoBase
1483:         LOCAL loc_nDtEntrs, loc_nFiscals, loc_cContaEs
1484: 
1485:         TRY
1486:             IF !USED("CsPrazE")
1487:                 MsgAviso("Cursor de prazos nao esta disponivel.", "Aviso")
1488:                 RETURN
1489:             ENDIF
1490: 
1491:             *-- Capturar valores da linha corrente para herdar
1492:             SELECT CsPrazE
1493:             loc_cDopes    = ALLTRIM(NVL(CsPrazE.Dopes,    ""))
1494:             loc_cAbrevs   = ALLTRIM(NVL(CsPrazE.Abrevs,   ""))
1495:             loc_dPrazoBase= NVL(CsPrazE.Prazos, DATETIME())
1496:             loc_nDtEntrs  = NVL(CsPrazE.DtEntrs,  0)
1497:             loc_nFiscals  = NVL(CsPrazE.nFiscals, 0)
1498:             loc_cContaEs  = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
1499: 
1500:             *-- Adicionar linha em branco herdando contexto
1501:             APPEND BLANK IN CsPrazE
1502:             REPLACE CsPrazE.Dopes     WITH loc_cDopes    ;
1503:                     CsPrazE.Abrevs    WITH loc_cAbrevs   ;
1504:                     CsPrazE.Prazos    WITH loc_dPrazoBase;
1505:                     CsPrazE.DtEntrs   WITH loc_nDtEntrs  ;
1506:                     CsPrazE.nFiscals  WITH loc_nFiscals  ;
1507:                     CsPrazE.nMinEnts  WITH 0             ;
1508:                     CsPrazE.nMaxEnts  WITH 0             ;
1509:                     CsPrazE.VlFretes  WITH 0             ;
1510:                     CsPrazE.DespAces  WITH 0             ;
1511:                     CsPrazE.VlSeguros WITH 0             ;
1512:                     CsPrazE.ContaEs   WITH loc_cContaEs  ;
1513:                     CsPrazE.LocalEnts WITH 0             ;
1514:                     CsPrazE.LocEntObs WITH 0             ;
1515:                     CsPrazE.ContaEs   WITH loc_cContaEs  IN CsPrazE
1516: 
1517:             *-- Reposicionar grid na nova linha e atualizar totais/paineis
1518:             THIS.grd_4c_Dados.Refresh
1519:             THIS.AtualizarLinhaGrid(1)
1520:             THIS.AtualizarTotaisNaTela()
1521: 
1522:         CATCH TO loc_oErro
1523:             MsgErro(loc_oErro.Message + CHR(13) + ;
1524:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1525:                     "Procedure: " + loc_oErro.Procedure, ;
1526:                     "Erro em FormPzo.BtnIncluirClick")
1527:         ENDTRY
1528:     ENDPROC
1529: 
1530:     *==========================================================================
1531:     * BtnAlterarClick - Habilita edicao da linha corrente do grid CsPrazE
1532:     * Posiciona foco na primeira coluna editavel e atualiza paineis suplementares
1533:     *==========================================================================
1534:     PROCEDURE BtnAlterarClick()
1535:         LOCAL loc_oErro
1536: 
1537:         TRY
1538:             IF !USED("CsPrazE") OR RECCOUNT("CsPrazE") = 0
1539:                 MsgAviso("Nenhum prazo disponivel para alteracao.", "Aviso")
1540:                 RETURN
1541:             ENDIF
1542: 
1543:             SELECT CsPrazE
1544:             IF EOF() OR BOF()
1545:                 GO TOP
1546:             ENDIF
1547: 
1548:             *-- Marcar modo edicao no BO (usado por Confirmar)
1549:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1550:                 THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
1551:             ENDIF
1552: 
1553:             *-- Atualizar paineis suplementares para a linha atual
1554:             THIS.AtualizarLinhaGrid(1)
1555: 
1556:             *-- Colocar foco na primeira coluna editavel (Frete)
1557:             THIS.grd_4c_Dados.SetFocus
1558:             THIS.grd_4c_Dados.ActiveColumn = 1
1559:             IF PEMSTATUS(THIS.grd_4c_Dados.Columns(1), "CurrentControl", 5)
1560:                 THIS.grd_4c_Dados.Columns(1).Text1.SetFocus
1561:             ENDIF
1562: 
1563:         CATCH TO loc_oErro
1564:             MsgErro(loc_oErro.Message + CHR(13) + ;
1565:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1566:                     "Procedure: " + loc_oErro.Procedure, ;
1567:                     "Erro em FormPzo.BtnAlterarClick")
1568:         ENDTRY
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     * BtnVisualizarClick - Modo somente-leitura: bloqueia grid e campos editaveis
1573:     * Atualiza paineis suplementares mostrando dados da linha corrente
1574:     *==========================================================================
1575:     PROCEDURE BtnVisualizarClick()
1576:         LOCAL loc_oErro
1577: 
1578:         TRY
1579:             IF !USED("CsPrazE") OR RECCOUNT("CsPrazE") = 0
1580:                 MsgAviso("Nenhum prazo disponivel para visualizacao.", "Aviso")
1581:                 RETURN
1582:             ENDIF
1583: 
1584:             SELECT CsPrazE
1585:             IF EOF() OR BOF()
1586:                 GO TOP
1587:             ENDIF
1588: 
1589:             *-- Marcar modo visualizacao no BO
1590:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1591:                 THIS.this_oBusinessObject.this_cEscolha = "VISUALIZAR"
1592:             ENDIF
1593: 
1594:             *-- Bloquear edicao no grid (todas as colunas ReadOnly)
1595:             THIS.grd_4c_Dados.ReadOnly = .T.
1596: 
1597:             *-- Bloquear campos do painel de entrega e observacao
1598:             THIS.cnt_4c_Entrega.txt_4c_Conta.ReadOnly    = .T.
1599:             THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly   = .T.
1600:             THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly      = .T.
1601:             THIS.cnt_4c_Observacao.txt_4c_CodObs.ReadOnly= .T.
1602:             THIS.cnt_4c_Observacao.txt_4c_Obs.ReadOnly   = .T.
1603: 
1604:             *-- Refrescar paineis suplementares para exibir dados
1605:             THIS.AtualizarLinhaGrid(1)
1606:             THIS.AtualizarTotaisNaTela()
1607: 
1608:         CATCH TO loc_oErro
1609:             MsgErro(loc_oErro.Message + CHR(13) + ;
1610:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1611:                     "Procedure: " + loc_oErro.Procedure, ;
1612:                     "Erro em FormPzo.BtnVisualizarClick")
1613:         ENDTRY
1614:     ENDPROC
1615: 
1616:     *==========================================================================
1617:     * BtnExcluirClick - Remove linha corrente de CsPrazE apos confirmacao
1618:     * Apos exclusao reposiciona no primeiro registro e atualiza totais
1619:     *==========================================================================
1620:     PROCEDURE BtnExcluirClick()
1621:         LOCAL loc_oErro, loc_cDopes
1622: 
1623:         TRY
1624:             IF !USED("CsPrazE") OR RECCOUNT("CsPrazE") = 0
1625:                 MsgAviso("Nenhum prazo disponivel para exclusao.", "Aviso")
1626:                 RETURN
1627:             ENDIF
1628: 
1629:             SELECT CsPrazE
1630:             IF EOF() OR BOF()
1631:                 GO TOP
1632:             ENDIF
1633: 
1634:             loc_cDopes = ALLTRIM(NVL(CsPrazE.Dopes, ""))
1635: 
1636:             IF !MsgConfirma("Confirma a exclusao do prazo da operacao " + ;
1637:                             loc_cDopes + " ?", "Confirmacao")
1638:                 RETURN
1639:             ENDIF
1640: 
1641:             *-- Marcar registro para exclusao e purgar do cursor
1642:             DELETE IN CsPrazE
1643:             SET DELETED ON
1644:             PACK
1645: 
1646:             *-- Reposicionar e atualizar interface
1647:             SELECT CsPrazE
1648:             IF RECCOUNT("CsPrazE") > 0
1649:                 GO TOP
1650:                 THIS.grd_4c_Dados.Refresh
1651:                 THIS.AtualizarLinhaGrid(1)
1652:             ELSE
1653:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
1654:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
1655:                 THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
1656:                 THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
1657:                 THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
1658:             ENDIF
1659: 
1660:             THIS.AtualizarTotaisNaTela()
1661: 
1662:         CATCH TO loc_oErro
1663:             MsgErro(loc_oErro.Message + CHR(13) + ;
1664:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1665:                     "Procedure: " + loc_oErro.Procedure, ;
1666:                     "Erro em FormPzo.BtnExcluirClick")
1667:         ENDTRY
1668:     ENDPROC
1669: 
1670:     *==========================================================================
1671:     * CarregarLista - Reposiciona no primeiro registro e atualiza grid e totais
1672:     *==========================================================================
1673:     FUNCTION CarregarLista()
1674:         LOCAL loc_lSucesso
1675:         loc_lSucesso = .F.
1676: 
1677:         IF USED("CsPrazE")
1678:             SELECT CsPrazE
1679:             IF RECCOUNT("CsPrazE") > 0
1680:                 GO TOP
1681:                 THIS.grd_4c_Dados.Refresh
1682:                 THIS.AtualizarLinhaGrid(1)
1683:                 THIS.AtualizarTotaisNaTela()
1684:                 loc_lSucesso = .T.
1685:             ENDIF
1686:         ENDIF
1687: 
1688:         RETURN loc_lSucesso
1689:     ENDPROC
1690: 
1691:     *==========================================================================
1692:     * FormParaBO - Copia linha corrente do CsPrazE e containers para o BO
1693:     *   (grid edita cursor diretamente via ControlSource; aqui capturamos
1694:     *    os campos auxiliares visiveis nos containers suplementares)
1695:     *==========================================================================
1696:     FUNCTION FormParaBO()
1697:         LOCAL loc_lSucesso, loc_oErro
1698:         loc_lSucesso = .F.
1699: 
1700:         TRY
1701:             IF !USED("CsPrazE")
1702:                 loc_lSucesso = .F.
1703:             ENDIF
1704: 
1705:             SELECT CsPrazE

*-- Linhas 1740 a 1948:
1740:         CATCH TO loc_oErro
1741:             MsgErro(loc_oErro.Message + CHR(13) + ;
1742:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1743:                     "Procedure: " + loc_oErro.Procedure, ;
1744:                     "Erro em FormPzo.FormParaBO")
1745:         ENDTRY
1746: 
1747:         RETURN loc_lSucesso
1748:     ENDPROC
1749: 
1750:     *==========================================================================
1751:     * BOParaForm - Copia propriedades do BO de volta para os controles do form
1752:     *==========================================================================
1753:     FUNCTION BOParaForm()
1754:         LOCAL loc_lSucesso, loc_oErro
1755:         loc_lSucesso = .F.
1756: 
1757:         TRY
1758:             *-- Totalizadores do rodape
1759:             THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
1760:             THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
1761:             THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
1762:             THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
1763:             THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
1764:             THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado
1765: 
1766:             *-- Container de entrega
1767:             IF THIS.cnt_4c_Entrega.Visible
1768:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ;
1769:                     THIS.this_oBusinessObject.this_cGetConta
1770:                 THIS.cnt_4c_Entrega.txt_4c_Cpf.Value    = ;
1771:                     THIS.this_oBusinessObject.this_cGetCpf
1772:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;
1773:                     THIS.this_oBusinessObject.this_cGetDConta
1774:             ENDIF
1775: 
1776:             *-- Container de observacao
1777:             IF THIS.cnt_4c_Observacao.Visible
1778:                 THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = ;
1779:                     THIS.this_oBusinessObject.this_nCodObs
1780:                 THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ;
1781:                     THIS.this_oBusinessObject.this_cObsEs
1782:             ENDIF
1783: 
1784:             THIS.Refresh()
1785:             loc_lSucesso = .T.
1786: 
1787:         CATCH TO loc_oErro
1788:             MsgErro(loc_oErro.Message + CHR(13) + ;
1789:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1790:                     "Procedure: " + loc_oErro.Procedure, ;
1791:                     "Erro em FormPzo.BOParaForm")
1792:         ENDTRY
1793: 
1794:         RETURN loc_lSucesso
1795:     ENDPROC
1796: 
1797:     *==========================================================================
1798:     * HabilitarCampos - Habilita/desabilita controles conforme modo
1799:     *   par_cModo: "INSERIR" | "ALTERAR" | "VISUALIZAR"
1800:     *==========================================================================
1801:     PROCEDURE HabilitarCampos(par_cModo)
1802:         LOCAL loc_lEditar
1803:         loc_lEditar = !INLIST(UPPER(ALLTRIM(par_cModo)), "VISUALIZAR")
1804: 
1805:         *-- Grid: somente-leitura em modo VISUALIZAR
1806:         THIS.grd_4c_Dados.ReadOnly = !loc_lEditar
1807: 
1808:         *-- Container de entrega
1809:         THIS.cnt_4c_Entrega.txt_4c_Conta.ReadOnly    = !loc_lEditar
1810:         THIS.cnt_4c_Entrega.txt_4c_Cpf.ReadOnly      = !loc_lEditar
1811:         THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly   = !loc_lEditar
1812:         THIS.cnt_4c_Entrega.btn_4c_EntLocal.Enabled  = loc_lEditar
1813: 
1814:         *-- Container de observacao (codigo editavel; texto sempre readonly pois e lookup)
1815:         THIS.cnt_4c_Observacao.txt_4c_CodObs.ReadOnly = !loc_lEditar
1816:         THIS.cnt_4c_Observacao.txt_4c_Obs.ReadOnly    = .T.
1817:     ENDPROC
1818: 
1819:     *==========================================================================
1820:     * LimparCampos - Limpa campos dos containers suplementares (entrega/obs)
1821:     *==========================================================================
1822:     PROCEDURE LimparCampos()
1823:         THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
1824:         THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
1825:         THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
1826:         THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
1827:         THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
1828:     ENDPROC
1829: 
1830:     *==========================================================================
1831:     * AjustarBotoesPorModo - Ajusta ReadOnly do grid conforme modo de edicao
1832:     *==========================================================================
1833:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1834:         LOCAL loc_cModo
1835:         loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, "")))
1836: 
1837:         IF EMPTY(loc_cModo) AND VARTYPE(THIS.this_oBusinessObject) = "O"
1838:             loc_cModo = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cEscolha))
1839:         ENDIF
1840: 
1841:         THIS.HabilitarCampos(loc_cModo)
1842:     ENDPROC
1843: 
1844:     *==========================================================================
1845:     * BtnBuscarClick - Recarrega o grid e atualiza totais (refresh)
1846:     *==========================================================================
1847:     PROCEDURE BtnBuscarClick()
1848:         THIS.CarregarLista()
1849:     ENDPROC
1850: 
1851:     *==========================================================================
1852:     * BtnEncerrarClick - Valida prazos/fretes e fecha o form (delega ao BO)
1853:     *==========================================================================
1854:     PROCEDURE BtnEncerrarClick()
1855:         THIS.EncerrarClick()
1856:     ENDPROC
1857: 
1858:     *==========================================================================
1859:     * BtnSalvarClick - Sincroniza campos dos containers com BO e atualiza totais
1860:     *   (grid ja edita CsPrazE via ControlSource; aqui persiste auxiliares)
1861:     *==========================================================================
1862:     PROCEDURE BtnSalvarClick()
1863:         LOCAL loc_oErro
1864: 
1865:         TRY
1866:             IF THIS.FormParaBO()
1867:                 THIS.AtualizarTotaisNaTela()
1868:                 THIS.AjustarBotoesPorModo("")
1869:             ENDIF
1870: 
1871:         CATCH TO loc_oErro
1872:             MsgErro(loc_oErro.Message + CHR(13) + ;
1873:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1874:                     "Procedure: " + loc_oErro.Procedure, ;
1875:                     "Erro em FormPzo.BtnSalvarClick")
1876:         ENDTRY
1877:     ENDPROC
1878: 
1879:     *==========================================================================
1880:     * BtnCancelarClick - Desfaz edicoes nos containers e recarrega da linha
1881:     *==========================================================================
1882:     PROCEDURE BtnCancelarClick()
1883:         LOCAL loc_oErro
1884: 
1885:         TRY
1886:             THIS.LimparCampos()
1887: 
1888:             IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
1889:                 SELECT CsPrazE
1890:                 THIS.AtualizarLinhaGrid(1)
1891:             ENDIF
1892: 
1893:             THIS.grd_4c_Dados.ReadOnly = .F.
1894:             THIS.HabilitarCampos(IIF(VARTYPE(THIS.this_oBusinessObject) = "O", ;
1895:                 THIS.this_oBusinessObject.this_cEscolha, "ALTERAR"))
1896: 
1897:         CATCH TO loc_oErro
1898:             MsgErro(loc_oErro.Message + CHR(13) + ;
1899:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1900:                     "Procedure: " + loc_oErro.Procedure, ;
1901:                     "Erro em FormPzo.BtnCancelarClick")
1902:         ENDTRY
1903:     ENDPROC
1904: 
1905:     *==========================================================================
1906:     * Destroy - Libera cursores locais e BO
1907:     *==========================================================================
1908:     PROCEDURE Destroy()
1909:         LOCAL loc_oErro
1910:         TRY
1911:             IF USED("CsPrazE")
1912:                 USE IN CsPrazE
1913:             ENDIF
1914:             IF USED("CsPedidos")
1915:                 USE IN CsPedidos
1916:             ENDIF
1917:             IF USED("CsPed")
1918:                 USE IN CsPed
1919:             ENDIF
1920:             IF USED("CsPedAnt")
1921:                 USE IN CsPedAnt
1922:             ENDIF
1923:             IF USED("crTodosOpe2")
1924:                 USE IN crTodosOpe2
1925:             ENDIF
1926:             IF USED("CsPedOpe2")
1927:                 USE IN CsPedOpe2
1928:             ENDIF
1929:             IF USED("Itens")
1930:                 USE IN Itens
1931:             ENDIF
1932:             IF USED("LocTmpOpe")
1933:                 USE IN LocTmpOpe
1934:             ENDIF
1935:             IF USED("crLocalObs")
1936:                 USE IN crLocalObs
1937:             ENDIF
1938:             IF USED("cursor_4c_BuscaCpf")
1939:                 USE IN cursor_4c_BuscaCpf
1940:             ENDIF
1941:             IF USED("cursor_4c_BuscaDConta")
1942:                 USE IN cursor_4c_BuscaDConta
1943:             ENDIF
1944:             IF USED("cursor_4c_BuscaCli")
1945:                 USE IN cursor_4c_BuscaCli
1946:             ENDIF
1947:             THIS.this_oBusinessObject = .NULL.
1948:             THIS.this_oFormPai        = .NULL.


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

