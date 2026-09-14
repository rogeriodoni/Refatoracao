# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (16)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_PROCURAR, CNT_4C_IMPCHMAT. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).
- [LAYOUT-POSITION] Controle 'Dt_inicial' (parent: SIGPRCHR): Left original=598 vs migrado 'txt_4c_Dt_inicial' Left=748 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Dt_final' (parent: SIGPRCHR): Left original=701 vs migrado 'txt_4c_Dt_final' Left=858 (diff=157px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGPRCHR): Left original=686 vs migrado 'lbl_4c_Say2' Left=840 (diff=154px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRCHR): Left original=550 vs migrado 'lbl_4c_Label2' Left=688 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Command2' (parent: SIGPRCHR): Left original=598 vs migrado 'cmd_4c_Command2' Left=748 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGPRCHR.cntjustificativa): Top original=5 vs migrado 'lbl_4c_Label5' Top=534 (diff=529px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'impchmat' (parent: SIGPRCHR): Top original=284 vs migrado 'cnt_4c_Impchmat' Top=8 (diff=276px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'impchmat' (parent: SIGPRCHR): Left original=240 vs migrado 'cnt_4c_Impchmat' Left=12 (diff=228px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCHR.impchmat): Top original=8 vs migrado 'lbl_4c_Label1' Top=194 (diff=186px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCHR.impchmat): Left original=12 vs migrado 'lbl_4c_Label1' Left=43 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCHR.cntProcurar): Top original=8 vs migrado 'lbl_4c_Label1' Top=194 (diff=186px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCHR.cntProcurar): Left original=12 vs migrado 'lbl_4c_Label1' Left=43 (diff=31px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3526 linhas total):

*-- Linhas 8 a 206:
8: *   BD   -> SigCqChi / SigCdmp / SigOpFp / SigCdCli / SigCdPit
9: *   CODE -> arquitetura em camadas (FormBase / SigPrChrBO)
10: *
11: * FASE 3/8: Estrutura base - DEFINE CLASS, Init, InicializarForm,
12: *           ConfigurarPageFrame, ConfigurarCabecalho, TornarControlesVisiveis,
13: *           Destroy. Tambem: ConfigurarGrupoBotoes (obj_4c_CmdGok 9 botoes),
14: *           ConfigurarGrid (grd_4c_Dados 10 colunas, cmd_4c_Tudo1/Apaga1).
15: * FASE 4/8: ConfigurarFiltros (Shape2/Shape1, Grupo/Conta/Periodo lookups,
16: *           Processar, TxtFavorecido), AlternarPagina.
17: * FASE 5/8: Propriedades de estado do form. ConfigurarPaginaDados(),
18: *           ConfigurarContainerJustificativa (cnt_4c_Justificativa),
19: *           ConfigurarContainerProcurar (cnt_4c_Procurar).
20: * Fases 6+: cnt_4c_Impchmat, BINDEVENTs e handlers de eventos.
21: *==============================================================================
22: DEFINE CLASS FormSigPrChr AS FormBase
23: 
24:     *-- Dimensoes (escala 1.25x do original 800x600)
25:     Width        = 1000
26:     Height       = 600
27: 
28:     *-- Form sem barra de titulo (identico ao legado TitleBar=0)
29:     TitleBar     = 0
30:     ShowWindow   = 1
31:     WindowType   = 1
32:     ControlBox   = .F.
33:     Closable     = .F.
34:     MaxButton    = .F.
35:     MinButton    = .F.
36:     Movable      = .F.
37: 
38:     *-- Aparencia
39:     AutoCenter   = .T.
40:     DataSession  = 2
41:     ShowTips     = .T.
42:     ClipControls = .F.
43:     BorderStyle  = 2
44:     FontName     = "Tahoma"
45:     FontSize     = 8
46: 
47:     *-- Business Object
48:     this_oBusinessObject = .NULL.
49: 
50:     *-- Propriedades de estado do form (antecessores de campos e flags de operacao)
51:     this_lLeCheque         = .F.
52:     this_cChqLido          = ""
53:     this_lLeitor           = .F.
54:     this_lInicio           = .F.
55:     this_lChMatIni         = .F.
56:     this_dAntDtIni         = {}
57:     this_dAntDtFin         = {}
58:     this_cAntCdGrupo       = ""
59:     this_cAntDsGrupo       = ""
60:     this_cAntCdConta       = ""
61:     this_cAntDsConta       = ""
62:     this_lExcluirDocumento = .T.
63:     this_lExcluirCheque    = .T.
64: 
65:     *--------------------------------------------------------------------------
66:     PROCEDURE Init()
67:     *  DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
68:     *--------------------------------------------------------------------------
69:         RETURN DODEFAULT()
70:     ENDPROC
71: 
72:     *--------------------------------------------------------------------------
73:     PROTECTED PROCEDURE InicializarForm()
74:     *  Cria toda a estrutura visual do form OPERACIONAL.
75:     *  Fases 4+ adicionarao controles via Read+Edit.
76:     *--------------------------------------------------------------------------
77:         LOCAL loc_lSucesso
78:         loc_lSucesso = .F.
79: 
80:         TRY
81:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
82:                 *-- Modo validacao UI: configura estrutura visual sem SQL
83:                 THIS.ConfigurarPageFrame()
84:                 THIS.ConfigurarCabecalho()
85:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
87:                 THIS.ConfigurarGrupoBotoes()
88:                 THIS.ConfigurarGrid()
89:                 THIS.ConfigurarFiltros()
90:                 THIS.ConfigurarContainerJustificativa()
91:                 THIS.ConfigurarContainerProcurar()
92:                 THIS.ConfigurarContainerImpchmat()
93:                 THIS.TornarControlesVisiveis(THIS)
94:                 THIS.RegistrarBINDEVENTs()
95:                 loc_lSucesso = .T.
96:             ELSE
97:                 *-- Verificar conexao principal
98:                 IF gnConnHandle <= 0
99:                     MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
100:                             "o estabelecida.", "Erro de Conex" + CHR(227) + "o")
101:                 ELSE
102:                     *-- Criar Business Object
103:                     THIS.this_oBusinessObject = CREATEOBJECT("SigPrChrBO")
104:                     IF VARTYPE(THIS.this_oBusinessObject) != "O"
105:                         MsgErro("Falha ao criar objeto de neg" + CHR(243) + "cios.", "Erro")
106:                     ELSE
107:                         *-- Carregar cursores iniciais (CrSigCdmp, CrContas, CsSigCqChi vazio)
108:                         IF THIS.this_oBusinessObject.CarregarCursoresIniciais()
109:                             *-- Configurar layout base (Picture, Caption, dimensoes)
110:                             THIS.ConfigurarPageFrame()
111: 
112:                             *-- Cabecalho cinza escuro com titulo
113:                             THIS.ConfigurarCabecalho()
114:                             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
115:                             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
116: 
117:                             *-- Grupo de botoes, grid e filtros
118:                             THIS.ConfigurarGrupoBotoes()
119:                             THIS.ConfigurarGrid()
120:                             THIS.ConfigurarFiltros()
121:                             THIS.ConfigurarContainerJustificativa()
122:                             THIS.ConfigurarContainerProcurar()
123:                             THIS.ConfigurarContainerImpchmat()
124: 
125:                             *-- Tornar controles visiveis (containers flutuantes permanecem ocultos)
126:                             THIS.TornarControlesVisiveis(THIS)
127: 
128:                             *-- Registrar BINDEVENTs apos controles criados
129:                             THIS.RegistrarBINDEVENTs()
130: 
131:                             loc_lSucesso = .T.
132:                         ENDIF
133:                     ENDIF
134:                 ENDIF
135:             ENDIF
136:         CATCH TO loc_oErro
137:             MsgErro(loc_oErro.Message, "Erro")
138:         ENDTRY
139: 
140:         RETURN loc_lSucesso
141:     ENDPROC
142: 
143:     *--------------------------------------------------------------------------
144:     PROTECTED PROCEDURE ConfigurarPageFrame()
145:     *  Configuracao base do form OPERACIONAL (layout flat, sem PageFrame).
146:     *  O nome e mantido por convencao do pipeline de migracao.
147:     *--------------------------------------------------------------------------
148:         LOCAL loc_cImgFundo
149: 
150:         *-- Titulo (TitleBar=0, nao exibido, mas util para rastreamento)
151:         THIS.Caption = "Processamento de Cheques"
152: 
153:         *-- Imagem de fundo do framework (identica ao legado new_background.jpg)
154:         loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
155:         IF FILE(loc_cImgFundo)
156:             THIS.Picture = loc_cImgFundo
157:         ENDIF
158: 
159:         *-- Reforca dimensoes canonicas (1.25x do original 800x600)
160:         THIS.Width      = 1000
161:         THIS.Height     = 600
162:         THIS.AutoCenter = .T.
163:     ENDPROC
164: 
165:     *--------------------------------------------------------------------------
166:     PROTECTED PROCEDURE ConfigurarCabecalho()
167:     *  Container cinza escuro com labels de sombra e titulo (cntSombra no legado).
168:     *  Original: Top=0, Left=0, Width=800, Height=80 -> novo: Width=1000.
169:     *--------------------------------------------------------------------------
170:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
171:         WITH THIS.cnt_4c_Cabecalho
172:             .Top         = 0
173:             .Left        = 0
174:             .Width       = 1000
175:             .Height      = 80
176:             .BackStyle   = 1
177:             .BackColor   = RGB(100, 100, 100)
178:             .BorderWidth = 0
179:             .Visible     = .T.
180: 
181:             *-- Label sombra (efeito de profundidade - ForeColor preto, ligeiramente deslocada)
182:             .AddObject("lbl_4c_Sombra", "Label")
183:             WITH .lbl_4c_Sombra
184:                 .Top       = 25
185:                 .Left      = 10
186:                 .Width     = 1000
187:                 .Height    = 40
188:                 .AutoSize  = .F.
189:                 .BackStyle = 0
190:                 .FontBold  = .T.
191:                 .FontName  = "Tahoma"
192:                 .FontSize  = 18
193:                 .ForeColor = RGB(0, 0, 0)
194:                 .Caption   = "Processamento de Cheques"
195:                 .Visible   = .T.
196:             ENDWITH
197: 
198:             *-- Label titulo (ForeColor branco sobre fundo cinza escuro)
199:             .AddObject("lbl_4c_Titulo", "Label")
200:             WITH .lbl_4c_Titulo
201:                 .Top       = 24
202:                 .Left      = 10
203:                 .Width     = 1000
204:                 .Height    = 46
205:                 .AutoSize  = .F.
206:                 .BackStyle = 0

*-- Linhas 215 a 258:
215:     ENDPROC
216: 
217:     *--------------------------------------------------------------------------
218:     PROTECTED PROCEDURE ConfigurarGrupoBotoes()
219:     *  CommandGroup obj_4c_CmdGok com 9 botoes. Escala 1.25x (original Top=-3, Left=11, Width=789).
220:     *--------------------------------------------------------------------------
221:         THIS.AddObject("obj_4c_CmdGok", "CommandGroup")
222:         WITH THIS.obj_4c_CmdGok
223:             .Top           = -3
224:             .Left          = 14
225:             .Width         = 986
226:             .Height        = 160
227:             .ButtonCount   = 9
228:             .BackStyle     = 0
229:             .BorderStyle   = 0
230:             .SpecialEffect = 1
231:             .Value         = 1
232:             .AutoSize      = .F.
233:             .Themes        = .F.
234:             .BorderColor   = RGB(136, 189, 188)
235:             .Visible       = .T.
236: 
237:             *-- Buttons(1): Documento (original Left=473 -> 591)
238:             WITH .Buttons(1)
239:                 .Top             = 121
240:                 .Left            = 591
241:                 .Height          = 37
242:                 .Width           = 120
243:                 .Caption         = "\<Documento"
244:                 .FontBold        = .T.
245:                 .FontItalic      = .T.
246:                 .PicturePosition = 1
247:                 .ForeColor       = RGB(90, 90, 90)
248:                 .BackColor       = RGB(255, 255, 255)
249:                 .Themes          = .F.
250:                 .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
251:             ENDWITH
252: 
253:             *-- Buttons(2): Encerrar (original Left=713 -> 891)
254:             WITH .Buttons(2)
255:                 .Top             = 6
256:                 .Left            = 891
257:                 .Height          = 75
258:                 .Width           = 75

*-- Linhas 401 a 445:
401:         ENDWITH
402:     ENDPROC
403: 
404:     *--------------------------------------------------------------------------
405:     PROTECTED PROCEDURE ConfigurarGrid()
406:     *  Grid grd_4c_Dados (10 colunas) + cmd_4c_Tudo1 + cmd_4c_Apaga1.
407:     *  Original: Top=233, Left=24, Width=710, Height=291 -> escala 1.25x.
408:     *--------------------------------------------------------------------------
409:         THIS.AddObject("grd_4c_Dados", "Grid")
410:         WITH THIS.grd_4c_Dados
411:             .Top               = 233
412:             .Left              = 30
413:             .Width             = 888
414:             .Height            = 291
415:             .FontName          = "Tahoma"
416:             .AllowHeaderSizing = .F.
417:             .AllowRowSizing    = .F.
418:             .DeleteMark        = .F.
419:             .ReadOnly          = .F.
420:             .ScrollBars        = 2
421:             .GridLineColor     = RGB(238, 238, 238)
422:             .ColumnCount       = 10
423:             .Visible           = .T.
424: 
425:             *-- Column1 (clnDatas): ColumnOrder=10, aparece como 10a coluna
426:             WITH .Column1
427:                 .ColumnOrder       = 10
428:                 .Width             = 99
429:                 .Movable           = .F.
430:                 .Resizable         = .F.
431:                 .ReadOnly          = .T.
432:                 .FontName          = "Tahoma"
433:                 .Header1.Caption   = "Data"
434:                 .Header1.FontName  = "Tahoma"
435:                 .Header1.Alignment = 2
436:                 .Header1.ForeColor = RGB(90, 90, 90)
437:                 .Text1.BorderStyle = 0
438:                 .Text1.Format      = "K"
439:                 .Text1.Margin      = 0
440:                 .Text1.MaxLength   = 10
441:                 .Text1.ReadOnly    = .T.
442:                 .Text1.ForeColor   = RGB(0, 0, 0)
443:                 .Text1.FontName    = "Tahoma"
444:             ENDWITH
445: 

*-- Linhas 621 a 652:
621:                 .CurrentControl = "chk_4c_Imprime"
622:             ENDWITH
623:         ENDWITH
624: 
625:         *-- RecordSource e ControlSources FORA do WITH (evita auto-bind sobrescrever ControlSources)
626:         THIS.grd_4c_Dados.RecordSource                              = "CsSigCqChi"
627:         THIS.grd_4c_Dados.Column1.ControlSource                    = "CsSigCqChi.datas"
628:         THIS.grd_4c_Dados.Column2.ControlSource                    = "CsSigCqChi.contas"
629:         THIS.grd_4c_Dados.Column3.ControlSource                    = "CsSigCqChi.ncopias"
630:         THIS.grd_4c_Dados.Column4.ControlSource                    = "CsSigCqChi.bancos"
631:         THIS.grd_4c_Dados.Column5.ControlSource                    = "CsSigCqChi.agencias"
632:         THIS.grd_4c_Dados.Column6.ControlSource                    = "CsSigCqChi.ncontas"
633:         THIS.grd_4c_Dados.Column7.ControlSource                    = "CsSigCqChi.ncheques"
634:         THIS.grd_4c_Dados.Column8.ControlSource                    = "IIF(CsSigCqChi.NCancelas=1,'Cancelado',IIF(CsSigCqChi.NEmitidos>0,'Emitido','N'+CHR(227)+'o Emitido'))"
635:         THIS.grd_4c_Dados.Column9.ControlSource                    = "CsSigCqChi.valors"
636:         THIS.grd_4c_Dados.Column10.ControlSource                   = "CsSigCqChi.NMarca1s"
637:         THIS.grd_4c_Dados.Column10.chk_4c_Imprime.ControlSource   = "CsSigCqChi.NMarca1s"
638: 
639:         *-- Botao Marcar Todos (original Top=334, Left=742 -> 928)
640:         THIS.AddObject("cmd_4c_Tudo1", "CommandButton")
641:         WITH THIS.cmd_4c_Tudo1
642:             .Top         = 334
643:             .Left        = 928
644:             .Height      = 40
645:             .Width       = 40
646:             .FontName    = "Verdana"
647:             .FontSize    = 8
648:             .Caption     = ""
649:             .TabStop     = .F.
650:             .ToolTipText = "Marca tudo"
651:             .ForeColor   = RGB(36, 84, 155)
652:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 676 a 771:
676:     ENDPROC
677: 
678:     *--------------------------------------------------------------------------
679:     PROCEDURE TornarControlesVisiveis(par_oContainer)
680:     *  Torna todos os controles visiveis recursivamente.
681:     *  Containers flutuantes (cnt_4c_Justificativa, cnt_4c_Impchmat,
682:     *  cnt_4c_Procurar) permanecem ocultos ao abrir, mas seus filhos sao
683:     *  tornados visiveis para exibicao correta quando o container for ativado.
684:     *--------------------------------------------------------------------------
685:         LOCAL loc_i, loc_oControl
686: 
687:         FOR loc_i = 1 TO par_oContainer.ControlCount
688:             loc_oControl = par_oContainer.Controls(loc_i)
689: 
690:             IF VARTYPE(loc_oControl) = "O"
691:                 *-- Containers flutuantes: tornar filhos visiveis sem revelar o container
692:                 IF INLIST(UPPER(loc_oControl.Name), ;
693:                           "CNT_4C_JUSTIFICATIVA", ;
694:                           "CNT_4C_IMPCHMAT", ;
695:                           "CNT_4C_PROCURAR")
696:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
697:                        loc_oControl.ControlCount > 0
698:                         THIS.TornarControlesVisiveis(loc_oControl)
699:                     ENDIF
700:                     LOOP
701:                 ENDIF
702: 
703:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
704:                     loc_oControl.Visible = .T.
705:                 ENDIF
706: 
707:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
708:                    loc_oControl.ControlCount > 0
709:                     THIS.TornarControlesVisiveis(loc_oControl)
710:                 ENDIF
711:             ENDIF
712:         ENDFOR
713:     ENDPROC
714: 
715:     *--------------------------------------------------------------------------
716:     PROTECTED PROCEDURE ConfigurarPaginaLista()
717:     *  Form OPERACIONAL: layout FLAT (sem Page1/Page2 do padrao CRUD).
718:     *  Este metodo agrega a configuracao equivalente a "Page1 (Lista)":
719:     *    - obj_4c_CmdGok (CommandGroup com 9 botoes operacionais)
720:     *    - grd_4c_Dados (Grid principal de cheques, 10 colunas)
721:     *    - cmd_4c_Tudo1 / cmd_4c_Apaga1 (Marcar/Desmarcar Todos)
722:     *    - Filtros (Grupo, Conta, Periodo, Processar, Favorecido)
723:     *  Chamado por InicializarForm (compatibilidade com pipeline de migracao).
724:     *--------------------------------------------------------------------------
725:         THIS.ConfigurarGrupoBotoes()
726:         THIS.ConfigurarGrid()
727:         THIS.ConfigurarFiltros()
728:     ENDPROC
729: 
730:     *--------------------------------------------------------------------------
731:     PROTECTED PROCEDURE ConfigurarFiltros()
732:     *  Cria a area de filtros entre o cabecalho e o grid.
733:     *  Linha 1 (Top~163): Grupo (lookup) | Periodo (datas)
734:     *  Linha 2 (Top~190): Conta (lookup) | Processar
735:     *  Rodape (Top=530): TxtFavorecido
736:     *  Shapes decorativas ao redor das duas areas (filtros e grade).
737:     *  Posicoes: escala 1.25x horizontal do original 800px.
738:     *--------------------------------------------------------------------------
739: 
740:         *-- Shape2: borda ao redor da area de filtros (original Top=156, Width=774)
741:         THIS.AddObject("shp_4c_Shape2", "Shape")
742:         WITH THIS.shp_4c_Shape2
743:             .Top         = 156
744:             .Left        = 23
745:             .Width       = 968
746:             .Height      = 66
747:             .BackStyle   = 0
748:             .BorderStyle = 1
749:             .BorderWidth = 1
750:             .BorderColor = RGB(136, 189, 188)
751:             .Visible     = .T.
752:         ENDWITH
753:         THIS.shp_4c_Shape2.ZOrder(1)
754: 
755:         *-- Shape1: borda ao redor da grade de cheques (original Top=227, Width=774)
756:         THIS.AddObject("shp_4c_Shape1", "Shape")
757:         WITH THIS.shp_4c_Shape1
758:             .Top         = 227
759:             .Left        = 23
760:             .Width       = 968
761:             .Height      = 301
762:             .BackStyle   = 0
763:             .BorderStyle = 1
764:             .BorderWidth = 1
765:             .BorderColor = RGB(136, 189, 188)
766:             .Visible     = .T.
767:         ENDWITH
768:         THIS.shp_4c_Shape1.ZOrder(1)
769: 
770:         *-- Label "Grupo :" (original Label3: Top=167, Left=34)
771:         THIS.AddObject("lbl_4c_Label3", "Label")

*-- Linhas 826 a 847:
826:             .ForeColor = RGB(0, 0, 0)
827:             .Visible   = .T.
828:         ENDWITH
829: 
830:         *-- TextBox data inicial (original Dt_inicial: Top=163, Left=598, class fweditdata)
831:         THIS.AddObject("txt_4c_Dt_inicial", "TextBox")
832:         WITH THIS.txt_4c_Dt_inicial
833:             .Top         = 163
834:             .Left        = 748
835:             .Width       = 86
836:             .Height      = 25
837:             .Value       = DATE()
838:             .Format      = "D"
839:             .FontName    = "Tahoma"
840:             .FontSize    = 8
841:             .BorderStyle = 1
842:             .Visible     = .T.
843:         ENDWITH
844: 
845:         *-- Label "a" (original Say2: Top=167, Left=686)
846:         THIS.AddObject("lbl_4c_Say2", "Label")
847:         WITH THIS.lbl_4c_Say2

*-- Linhas 856 a 892:
856:             .ForeColor = RGB(0, 0, 0)
857:             .Visible   = .T.
858:         ENDWITH
859: 
860:         *-- TextBox data final (original Dt_final: Top=163, Left=701, class fweditdata)
861:         THIS.AddObject("txt_4c_Dt_final", "TextBox")
862:         WITH THIS.txt_4c_Dt_final
863:             .Top         = 163
864:             .Left        = 858
865:             .Width       = 86
866:             .Height      = 25
867:             .Value       = DATE()
868:             .Format      = "D"
869:             .FontName    = "Tahoma"
870:             .FontSize    = 8
871:             .BorderStyle = 1
872:             .Visible     = .T.
873:         ENDWITH
874: 
875:         *-- Botao Processar (original Command2: Top=191, Left=598, Width=88, Height=24)
876:         THIS.AddObject("cmd_4c_Command2", "CommandButton")
877:         WITH THIS.cmd_4c_Command2
878:             .Top         = 191
879:             .Left        = 748
880:             .Width       = 110
881:             .Height      = 24
882:             .Caption     = "Processar"
883:             .FontName    = "Tahoma"
884:             .FontSize    = 8
885:             .FontBold    = .F.
886:             .ForeColor   = RGB(0, 0, 0)
887:             .BackColor   = RGB(236, 233, 216)
888:             .Themes      = .T.
889:             .Visible     = .T.
890:         ENDWITH
891: 
892:         *-- Label "Conta :" (original Label1: Top=194, Left=34, Width=38)

*-- Linhas 967 a 1021:
967:     ENDPROC
968: 
969:     *--------------------------------------------------------------------------
970:     PROTECTED PROCEDURE ConfigurarPaginaDados()
971:     *  Form OPERACIONAL: nao ha PageFrame. Este metodo agrega a configuracao
972:     *  dos containers flutuantes:
973:     *    Fase 5: cnt_4c_Justificativa + cnt_4c_Procurar
974:     *    Fase 6: cnt_4c_Impchmat (adicionado em Edit seguinte)
975:     *--------------------------------------------------------------------------
976:         THIS.ConfigurarContainerJustificativa()
977:         THIS.ConfigurarContainerProcurar()
978:     ENDPROC
979: 
980:     *--------------------------------------------------------------------------
981:     PROTECTED PROCEDURE ConfigurarContainerJustificativa()
982:     *  Container flutuante para digitacao da justificativa de cancelamento.
983:     *  Original: cntjustificativa - Top=532, Left=395, Width=350, Height=69.
984:     *  Escala 1.25x horizontal -> Left=494, Width=438.
985:     *  Exibido por BtnExcluirChqClick (Fase 6); oculto por CmdGconfCancelarClick.
986:     *--------------------------------------------------------------------------
987:         THIS.AddObject("cnt_4c_Justificativa", "Container")
988:         WITH THIS.cnt_4c_Justificativa
989:             .Top         = 532
990:             .Left        = 494
991:             .Width       = 438
992:             .Height      = 69
993:             .BackStyle   = 1
994:             .BackColor   = RGB(236, 233, 216)
995:             .BorderWidth = 1
996:             .Visible     = .F.
997: 
998:             *-- Label descricao (original: Label5, top=5, left=6, width=143)
999:             .AddObject("lbl_4c_Label5", "Label")
1000:             WITH .lbl_4c_Label5
1001:                 .Top       = 5
1002:                 .Left      = 6
1003:                 .Width     = 179
1004:                 .Height    = 15
1005:                 .Caption   = "Justificativa do cancelamento"
1006:                 .FontName  = "Tahoma"
1007:                 .FontSize  = 8
1008:                 .BackStyle = 0
1009:                 .ForeColor = RGB(0, 0, 0)
1010:                 .Visible   = .T.
1011:             ENDWITH
1012: 
1013:             *-- EditBox para digitar a justificativa (original: get_justificativa, fwmemo)
1014:             *  Top=21, Left=3, Width=238, Height=44 -> Width=298 (escala 1.25x)
1015:             .AddObject("obj_4c_Get_justificativa", "EditBox")
1016:             WITH .obj_4c_Get_justificativa
1017:                 .Top         = 21
1018:                 .Left        = 3
1019:                 .Width       = 298
1020:                 .Height      = 44
1021:                 .Value       = ""

*-- Linhas 1079 a 1122:
1079:     ENDPROC
1080: 
1081:     *--------------------------------------------------------------------------
1082:     PROTECTED PROCEDURE ConfigurarContainerProcurar()
1083:     *  Container flutuante para pesquisa de cheque por banco/agencia/conta/numero.
1084:     *  Original: cntProcurar - Top=284, Left=240, Width=314, Height=218.
1085:     *  Escala 1.25x horizontal -> Left=300, Width=393.
1086:     *  Exibido por BtnProcurarClick (Buttons(4) - Fase 6); oculto por Voltar.
1087:     *  Tambem integra leitura de CMC-7 (leitor de codigo de barras).
1088:     *--------------------------------------------------------------------------
1089:         THIS.AddObject("cnt_4c_Procurar", "Container")
1090:         WITH THIS.cnt_4c_Procurar
1091:             .Top         = 284
1092:             .Left        = 300
1093:             .Width       = 393
1094:             .Height      = 218
1095:             .BackStyle   = 1
1096:             .BackColor   = RGB(236, 233, 216)
1097:             .BorderWidth = 1
1098:             .Visible     = .F.
1099: 
1100:             *-- Label titulo (original: Label1, top=8, left=12, width=54, caption="Procurar")
1101:             .AddObject("lbl_4c_Label1", "Label")
1102:             WITH .lbl_4c_Label1
1103:                 .Top       = 8
1104:                 .Left      = 12
1105:                 .Width     = 68
1106:                 .Height    = 16
1107:                 .Caption   = "Procurar"
1108:                 .FontName  = "Tahoma"
1109:                 .FontSize  = 8
1110:                 .FontBold  = .T.
1111:                 .BackStyle = 0
1112:                 .ForeColor = RGB(0, 0, 0)
1113:                 .Visible   = .T.
1114:             ENDWITH
1115: 
1116:             *-- Label "Banco :" (original: lblBanco, top=139, left=36)
1117:             .AddObject("lbl_4c_LblBanco", "Label")
1118:             WITH .lbl_4c_LblBanco
1119:                 .Top       = 139
1120:                 .Left      = 45
1121:                 .Width     = 48
1122:                 .Height    = 15

*-- Linhas 1344 a 1458:
1344:     ENDPROC
1345: 
1346:     *--------------------------------------------------------------------------
1347:     PROCEDURE AlternarPagina(par_nVisao)
1348:     *  Gerencia visibilidade dos containers flutuantes.
1349:     *  par_nVisao: 0=Grade principal, 1=Procurar, 2=Impressao Matricial
1350:     *  Containers (cnt_4c_Procurar, cnt_4c_Impchmat) criados nas Fases 5+.
1351:     *--------------------------------------------------------------------------
1352:         DO CASE
1353:         CASE par_nVisao = 0
1354:             *-- Retorna para a visao principal
1355:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
1356:                 THIS.cnt_4c_Procurar.Enabled = .F.
1357:                 THIS.cnt_4c_Procurar.Visible = .F.
1358:             ENDIF
1359:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
1360:                 THIS.cnt_4c_Impchmat.Enabled = .F.
1361:                 THIS.cnt_4c_Impchmat.Visible = .F.
1362:             ENDIF
1363:             THIS.grd_4c_Dados.Enabled         = .T.
1364:             THIS.txt_4c_CdContas.Enabled      = .T.
1365:             THIS.txt_4c_DsContas.Enabled      = .T.
1366:             THIS.txt_4c_TxtFavorecido.Enabled = .T.
1367:             THIS.obj_4c_CmdGok.Enabled        = .T.
1368:             THIS.cmd_4c_Tudo1.Visible         = .T.
1369:             THIS.cmd_4c_Apaga1.Visible        = .T.
1370:         CASE par_nVisao = 1
1371:             *-- Exibe painel Procurar, desabilita grade
1372:             THIS.grd_4c_Dados.Enabled         = .F.
1373:             THIS.txt_4c_CdContas.Enabled      = .F.
1374:             THIS.txt_4c_DsContas.Enabled      = .F.
1375:             THIS.txt_4c_TxtFavorecido.Enabled = .F.
1376:             THIS.obj_4c_CmdGok.Enabled        = .F.
1377:             THIS.cmd_4c_Tudo1.Visible         = .F.
1378:             THIS.cmd_4c_Apaga1.Visible        = .F.
1379:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
1380:                 THIS.cnt_4c_Procurar.Enabled = .T.
1381:                 THIS.cnt_4c_Procurar.Visible = .T.
1382:             ENDIF
1383:         CASE par_nVisao = 2
1384:             *-- Exibe painel Impressao Matricial, desabilita grade
1385:             THIS.grd_4c_Dados.Enabled         = .F.
1386:             THIS.txt_4c_CdContas.Enabled      = .F.
1387:             THIS.txt_4c_DsContas.Enabled      = .F.
1388:             THIS.txt_4c_TxtFavorecido.Enabled = .F.
1389:             THIS.obj_4c_CmdGok.Enabled        = .F.
1390:             THIS.cmd_4c_Tudo1.Visible         = .F.
1391:             THIS.cmd_4c_Apaga1.Visible        = .F.
1392:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
1393:                 THIS.cnt_4c_Impchmat.Enabled = .T.
1394:                 THIS.cnt_4c_Impchmat.Visible = .T.
1395:             ENDIF
1396:         ENDCASE
1397:     ENDPROC
1398: 
1399:     *--------------------------------------------------------------------------
1400:     PROCEDURE Destroy()
1401:     *--------------------------------------------------------------------------
1402:         TRY
1403:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1404:                 THIS.this_oBusinessObject.LiberarCursores()
1405:                 THIS.this_oBusinessObject = .NULL.
1406:             ENDIF
1407:         CATCH TO loc_oErro
1408:             MsgErro(loc_oErro.Message, "Erro ao encerrar")
1409:         ENDTRY
1410:         DODEFAULT()
1411:     ENDPROC
1412: 
1413:     *==========================================================================
1414:     *  FASE 6/8 - cnt_4c_Impchmat + RegistrarBINDEVENTs + event handlers
1415:     *==========================================================================
1416: 
1417:     *--------------------------------------------------------------------------
1418:     PROTECTED PROCEDURE ConfigurarContainerImpchmat()
1419:     *  Container flutuante para impressao matricial por faixa de numeros.
1420:     *  Original: impchmat - Top=284, Left=240, Width=314, Height=218.
1421:     *  Escala 1.25x horizontal -> Left=300, Width=393.
1422:     *--------------------------------------------------------------------------
1423:         THIS.AddObject("cnt_4c_Impchmat", "Container")
1424:         WITH THIS.cnt_4c_Impchmat
1425:             .Top         = 284
1426:             .Left        = 300
1427:             .Width       = 393
1428:             .Height      = 218
1429:             .BackStyle   = 1
1430:             .BackColor   = RGB(255, 255, 255)
1431:             .BorderWidth = 1
1432:             .Visible     = .F.
1433: 
1434:             .AddObject("lbl_4c_Label1", "Label")
1435:             WITH .lbl_4c_Label1
1436:                 .Top       = 8
1437:                 .Left      = 12
1438:                 .Width     = 81
1439:                 .Height    = 16
1440:                 .Caption   = "Impress" + CHR(227) + "o"
1441:                 .FontName  = "Tahoma"
1442:                 .FontSize  = 8
1443:                 .FontBold  = .T.
1444:                 .BackStyle = 0
1445:                 .ForeColor = RGB(90, 90, 90)
1446:                 .Visible   = .T.
1447:             ENDWITH
1448: 
1449:             .AddObject("lbl_4c_LblBanco", "Label")
1450:             WITH .lbl_4c_LblBanco
1451:                 .Top       = 157
1452:                 .Left      = 83
1453:                 .Width     = 48
1454:                 .Height    = 15
1455:                 .Caption   = "Banco :"
1456:                 .FontName  = "Tahoma"
1457:                 .FontSize  = 8
1458:                 .BackStyle = 0

*-- Linhas 1591 a 1744:
1591:     ENDPROC
1592: 
1593:     *--------------------------------------------------------------------------
1594:     PROTECTED PROCEDURE RegistrarBINDEVENTs()
1595:     *  Registra todos os eventos dos controles nos handlers PUBLIC do form.
1596:     *--------------------------------------------------------------------------
1597:         *-- CommandGroup principal (9 botoes)
1598:         BINDEVENT(THIS.obj_4c_CmdGok, "Click", THIS, "CmdGokClick")
1599: 
1600:         *-- Grid: navegacao de linha e scroll
1601:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange",  THIS, "GrdAfterRowColChange")
1602:         BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange", THIS, "GrdBeforeRowColChange")
1603:         BINDEVENT(THIS.grd_4c_Dados, "Scrolled",           THIS, "GrdScrolled")
1604:         BINDEVENT(THIS.grd_4c_Dados, "DoScroll",           THIS, "GrdDoScroll")
1605: 
1606:         *-- Grid: Header da coluna NCopias
1607:         BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "HeaderNcopiasClick")
1608: 
1609:         *-- Grid: CheckBox coluna Imprime
1610:         BINDEVENT(THIS.grd_4c_Dados.Column10.chk_4c_Imprime, "KeyPress", THIS, "ChkImprimeKeyPress")
1611:         BINDEVENT(THIS.grd_4c_Dados.Column10.chk_4c_Imprime, "MouseUp",  THIS, "ChkImprimeMouseUp")
1612: 
1613:         *-- Botoes marcar/desmarcar
1614:         BINDEVENT(THIS.cmd_4c_Apaga1,   "Click", THIS, "CmdApaga1Click")
1615:         BINDEVENT(THIS.cmd_4c_Tudo1,    "Click", THIS, "CmdTudo1Click")
1616:         BINDEVENT(THIS.cmd_4c_Command2, "Click", THIS, "Command2Click")
1617: 
1618:         *-- Campos de filtro: GotFocus salva valor anterior; KeyPress valida ao sair
1619:         BINDEVENT(THIS.txt_4c_CdGrupos,  "GotFocus", THIS, "CdGruposGotFocus")
1620:         BINDEVENT(THIS.txt_4c_CdGrupos,  "KeyPress", THIS, "CdGruposKeyPress")
1621:         BINDEVENT(THIS.txt_4c_DsGrupos,  "GotFocus", THIS, "DsGruposGotFocus")
1622:         BINDEVENT(THIS.txt_4c_DsGrupos,  "KeyPress", THIS, "DsGruposKeyPress")
1623:         BINDEVENT(THIS.txt_4c_CdContas,  "GotFocus", THIS, "CdContasGotFocus")
1624:         BINDEVENT(THIS.txt_4c_CdContas,  "KeyPress", THIS, "CdContasKeyPress")
1625:         BINDEVENT(THIS.txt_4c_DsContas,  "GotFocus", THIS, "DsContasGotFocus")
1626:         BINDEVENT(THIS.txt_4c_DsContas,  "KeyPress", THIS, "DsContasKeyPress")
1627:         BINDEVENT(THIS.txt_4c_Dt_inicial,"GotFocus", THIS, "DtInicialGotFocus")
1628:         BINDEVENT(THIS.txt_4c_Dt_inicial,"KeyPress", THIS, "DtInicialKeyPress")
1629:         BINDEVENT(THIS.txt_4c_Dt_final,  "GotFocus", THIS, "DtFinalGotFocus")
1630:         BINDEVENT(THIS.txt_4c_Dt_final,  "KeyPress", THIS, "DtFinalKeyPress")
1631: 
1632:         *-- Container Justificativa: CommandGroup confirmar/cancelar
1633:         BINDEVENT(THIS.cnt_4c_Justificativa.obj_4c_CmdGconf, "Click", THIS, "CmdGconfClick")
1634: 
1635:         *-- Container ImpChMat: CommandGroup imprimir/encerrar + campos
1636:         BINDEVENT(THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar, "Click",    THIS, "ImpchmatCmdGprocurarClick")
1637:         BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Banco,         "KeyPress", THIS, "ImpchmatBancoKeyPress")
1638:         BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chini,         "KeyPress", THIS, "ImpchmatChiniKeyPress")
1639:         BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chfin,         "KeyPress", THIS, "ImpchmatChfinKeyPress")
1640: 
1641:         *-- Container Procurar: CommandGroup pesquisar/cancelar + campos
1642:         BINDEVENT(THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar, "Click",    THIS, "ProcurarCmdgprocurarClick")
1643:         BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Banco,         "KeyPress", THIS, "ProcurarBancoKeyPress")
1644:         BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Emissao,       "GotFocus", THIS, "ProcurarEmissaoGotFocus")
1645:         BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Valor,         "GotFocus", THIS, "ProcurarValorGotFocus")
1646:     ENDPROC
1647: 
1648:     *--------------------------------------------------------------------------
1649:     PROCEDURE MExibeCheques(par_lSeek)
1650:     *  Atualiza a grade de cheques aplicando filtro de conta e marcacoes zeradas.
1651:     *  par_lSeek = .T.: posiciona no fim do cursor (apos incluir/alterar).
1652:     *--------------------------------------------------------------------------
1653:         LOCAL loc_lSeek
1654: 
1655:         IF TYPE("par_lSeek") = "L"
1656:             loc_lSeek = par_lSeek
1657:         ELSE
1658:             loc_lSeek = .F.
1659:         ENDIF
1660: 
1661:         THIS.LockScreen = .T.
1662: 
1663:         TRY
1664:             IF USED("CsSigCqChi")
1665:                 UPDATE CsSigCqChi SET nMarca1s = 0 WHERE nMarca1s = 1
1666:             ENDIF
1667: 
1668:             IF EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
1669:                 SELECT CsSigCqChi
1670:                 SET ORDER TO NCopias
1671:                 IF loc_lSeek
1672:                     SEEK CHR(255) IN CsSigCqChi ORDER NCopias ASCENDING
1673:                 ENDIF
1674:             ELSE
1675:                 SELECT CsSigCqChi
1676:                 SET ORDER TO Contas
1677:                 SET KEY TO ALLTRIM(THIS.txt_4c_CdContas.Value)
1678:                 IF loc_lSeek
1679:                     SEEK ALLTRIM(THIS.txt_4c_CdContas.Value) + CHR(255) IN CsSigCqChi ORDER Contas ASCENDING
1680:                 ENDIF
1681:             ENDIF
1682: 
1683:             THIS.obj_4c_CmdGok.Buttons(4).Enabled = .T.
1684:             THIS.obj_4c_CmdGok.Refresh
1685:             THIS.grd_4c_Dados.Refresh
1686: 
1687:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
1688:                 THIS.txt_4c_TxtFavorecido.Value = ALLTRIM(CsSigCqChi.favos)
1689:             ENDIF
1690:             THIS.txt_4c_TxtFavorecido.Refresh
1691:             THIS.grd_4c_Dados.Column2.SetFocus
1692:         CATCH TO loc_oErro
1693:             MsgErro(loc_oErro.Message, "Erro em MExibeCheques")
1694:         ENDTRY
1695: 
1696:         THIS.LockScreen = .F.
1697:     ENDPROC
1698: 
1699:     *--------------------------------------------------------------------------
1700:     PROCEDURE MontaChq(par_lPosiciona)
1701:     *  Carrega o cursor CsSigCqChi via SQL conforme os filtros da tela.
1702:     *  par_lPosiciona = .T.: reposiciona no cheque atual apos recarregar.
1703:     *--------------------------------------------------------------------------
1704:         LOCAL loc_lResultado, loc_lPosiciona, loc_cBusca
1705:         LOCAL loc_cCdGrupo, loc_cCdConta, loc_cQuery, loc_nQueryOk
1706:         PRIVATE pDtInicial, pDtFinal
1707: 
1708:         loc_lResultado = .F.
1709: 
1710:         TRY
1711:             loc_lPosiciona = (TYPE("par_lPosiciona") = "L" AND par_lPosiciona)
1712: 
1713:             IF loc_lPosiciona AND USED("CsSigCqChi") AND !EOF("CsSigCqChi")
1714:                 loc_cBusca = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
1715:                              CsSigCqChi.ncontas  + CsSigCqChi.ncheques
1716:             ELSE
1717:                 loc_cBusca = ""
1718:             ENDIF
1719: 
1720:             pDtInicial   = THIS.txt_4c_Dt_inicial.Value
1721:             pDtFinal     = THIS.txt_4c_Dt_final.Value
1722:             loc_cCdGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
1723:             loc_cCdConta = ALLTRIM(THIS.txt_4c_CdContas.Value)
1724: 
1725:             THIS.LockScreen = .T.
1726:             WAIT WINDOW "Aguarde! Selecionando Cheques..." NOWAIT
1727: 
1728:             IF USED("CsSigCqChi")
1729:                 THIS.grd_4c_Dados.RecordSource = ""
1730:                 USE IN CsSigCqChi
1731:             ENDIF
1732: 
1733:             IF EMPTY(loc_cCdConta)
1734:                 loc_cQuery = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias," + ;
1735:                              " a.ncontas, a.ncheques, a.contas," + ;
1736:                              " a.valors, a.favos, a.ncopias, a.emitidos, a.nemissoes, a.cancelas," + ;
1737:                              " a.cidchaves, a.JustCanc, 0 as NEmitidos, 0 as NCancelas, 0 as NMarca1s" + ;
1738:                              " FROM SigCqChi a" + ;
1739:                              " WHERE a.datas BETWEEN ?pDtInicial AND ?pDtFinal"
1740:                 loc_cQuery = loc_cQuery + ;
1741:                              " AND a.Contas IN (SELECT DISTINCT ContaDs FROM SigOpFp WHERE EmiChqs = 1)" + ;
1742:                              " ORDER BY a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias," + ;
1743:                              " a.ncontas, a.ncheques, a.contas, a.valors, a.favos," + ;
1744:                              " a.ncopias, a.emitidos, a.nemissoes, a.cancelas, a.cidchaves"

*-- Linhas 1799 a 1819:
1799:             ENDIF
1800: 
1801:             THIS.LockScreen = .F.
1802:             WAIT CLEAR
1803: 
1804:             WITH THIS.grd_4c_Dados
1805:                 .RecordSource                           = "CsSigCqChi"
1806:                 .Column10.ControlSource                 = "CsSigCqChi.NMarca1s"
1807:                 .Column10.chk_4c_Imprime.ControlSource = "CsSigCqChi.NMarca1s"
1808:                 .Column1.ControlSource                  = "CsSigCqChi.datas"
1809:                 .Column2.ControlSource                  = "CsSigCqChi.contas"
1810:                 .Column3.ControlSource                  = "CsSigCqChi.ncopias"
1811:                 .Column4.ControlSource                  = "CsSigCqChi.bancos"
1812:                 .Column5.ControlSource                  = "CsSigCqChi.agencias"
1813:                 .Column6.ControlSource                  = "CsSigCqChi.ncontas"
1814:                 .Column7.ControlSource                  = "CsSigCqChi.ncheques"
1815:                 .Column9.ControlSource                  = "CsSigCqChi.valors"
1816:                 .Column8.ControlSource = "IIF(CsSigCqChi.NCancelas=1,'Cancelado'," + ;
1817:                     "IIF(CsSigCqChi.NEmitidos=1," + ;
1818:                     "IIF(CsSigCqChi.ncopias>1,'Reemitido','Emitido')," + ;
1819:                     "'N" + CHR(227) + "o Emitido'))"

*-- Linhas 1844 a 1887:
1844:     ENDPROC
1845: 
1846:     *--------------------------------------------------------------------------
1847:     PROCEDURE CarregaConta()
1848:     *  Carrega TmpConta com dados de pagamento do cheque selecionado em CsSigCqChi.
1849:     *  Chamado por BtnImprimirClick e BtnReciboClick antes de abrir subform.
1850:     *--------------------------------------------------------------------------
1851:         LOCAL loc_lResultado, loc_cChave, loc_cSQL, loc_nQueryOk
1852: 
1853:         loc_lResultado = .F.
1854: 
1855:         TRY
1856:             IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
1857:                 loc_lResultado = .F.
1858:             ENDIF
1859: 
1860:             loc_cChave = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)
1861: 
1862:             IF USED("TmpPrIt")
1863:                 USE IN TmpPrIt
1864:             ENDIF
1865: 
1866:             loc_cSQL = "SELECT emps, dopes, numes, empos, grupos, contas, tipos, nopers, opers," + ;
1867:                        " acertos, cotacaos, valos, moedas, hists, vencs, datas" + ;
1868:                        " FROM SigCdPit" + ;
1869:                        " WHERE empdopnums = " + EscaparSQL(loc_cChave) + ;
1870:                        " ORDER BY emps, dopes, numes, grupos, contas, nopers"
1871: 
1872:             loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPrIt")
1873:             IF loc_nQueryOk < 1
1874:                 MsgErro("Falha ao carregar pagamentos.", "Erro")
1875:                 loc_lResultado = .F.
1876:             ENDIF
1877: 
1878:             IF USED("TmpConta")
1879:                 USE IN TmpConta
1880:             ENDIF
1881: 
1882:             SET NULL ON
1883:             CREATE CURSOR TmpConta (grupos C(10) NULL, contas C(10) NULL, flag L NULL, ;
1884:                 valos N(12,2) NULL, acerto N(12,2) NULL, moedas C(3) NULL, ;
1885:                 datas D NULL, vencs D NULL, hists C(50) NULL, nomes C(50) NULL, ;
1886:                 emps C(3) NULL, nopers N(9,0) NULL, dopes C(20) NULL, numes N(6,0) NULL, ;
1887:                 tipos C(1) NULL, fpags C(12) NULL, opers C(1) NULL, baixa N(12,2) NULL, ;

*-- Linhas 1972 a 2316:
1972:     *--------------------------------------------------------------------------
1973:     *  Helper: atualiza estado dos botoes e justificativa conforme linha do grid
1974:     *--------------------------------------------------------------------------
1975:     PROTECTED PROCEDURE AtualizarEstadoGrid()
1976:         LOCAL loc_lCancelas
1977: 
1978:         IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
1979:             RETURN
1980:         ENDIF
1981: 
1982:         loc_lCancelas = (CsSigCqChi.NCancelas <> 0)
1983: 
1984:         THIS.txt_4c_TxtFavorecido.Value = ALLTRIM(CsSigCqChi.favos)
1985: 
1986:         THIS.obj_4c_CmdGok.Buttons(1).Enabled = !loc_lCancelas                              && Documento
1987:         THIS.obj_4c_CmdGok.Buttons(6).Enabled = (!loc_lCancelas AND THIS.this_lExcluirDocumento) && ExcluiDoc
1988:         THIS.obj_4c_CmdGok.Buttons(3).Enabled = !loc_lCancelas                              && Imprimir
1989:         THIS.obj_4c_CmdGok.Buttons(5).Enabled = !loc_lCancelas                              && Recibo
1990:         THIS.obj_4c_CmdGok.Buttons(9).Enabled = (loc_lCancelas AND THIS.this_lExcluirCheque) && ExcluirChq
1991: 
1992:         IF loc_lCancelas
1993:             WITH THIS.cnt_4c_Justificativa
1994:                 .Visible = .T.
1995:                 .obj_4c_Get_justificativa.Width    = 346
1996:                 .obj_4c_Get_justificativa.ReadOnly = .T.
1997:                 .obj_4c_Get_justificativa.Refresh
1998:                 .obj_4c_CmdGconf.Enabled = .F.
1999:                 .obj_4c_CmdGconf.Visible = .F.
2000:             ENDWITH
2001:         ELSE
2002:             WITH THIS.cnt_4c_Justificativa
2003:                 .Visible = .F.
2004:                 .obj_4c_Get_justificativa.ReadOnly = .F.
2005:                 .obj_4c_CmdGconf.Enabled = .F.
2006:                 .obj_4c_CmdGconf.Visible = .F.
2007:             ENDWITH
2008:         ENDIF
2009: 
2010:         THIS.txt_4c_TxtFavorecido.Refresh
2011:         THIS.obj_4c_CmdGok.Refresh
2012:     ENDPROC
2013: 
2014:     *-- Grid: AfterRowColChange
2015:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
2016:         THIS.AtualizarEstadoGrid()
2017:     ENDPROC
2018: 
2019:     *-- Grid: BeforeRowColChange
2020:     PROCEDURE GrdBeforeRowColChange(par_nColIndex)
2021:         THIS.AtualizarEstadoGrid()
2022:     ENDPROC
2023: 
2024:     *-- Grid: Scrolled
2025:     PROCEDURE GrdScrolled(par_nDirection)
2026:         THIS.AtualizarEstadoGrid()
2027:     ENDPROC
2028: 
2029:     *-- Grid: DoScroll
2030:     PROCEDURE GrdDoScroll(par_nDirection)
2031:         THIS.AtualizarEstadoGrid()
2032:     ENDPROC
2033: 
2034:     *-- Grid: Header da coluna NCopias
2035:     PROCEDURE HeaderNcopiasClick()
2036:         IF EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value)) AND ;
2037:            UPPER(ORDER("CsSigCqChi")) <> "NCOPIAS"
2038:             THIS.MExibeCheques(.F.)
2039:         ENDIF
2040:     ENDPROC
2041: 
2042:     *-- Grid: CheckBox Imprime - KeyPress (ENTER/SPACE toggle marca)
2043:     PROCEDURE ChkImprimeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2044:         LOCAL loc_nRecno, loc_cChave
2045: 
2046:         IF INLIST(par_nKeyCode, 13, 32)
2047:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
2048:                 loc_nRecno = RECNO("CsSigCqChi")
2049:                 loc_cChave = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
2050:                              CsSigCqChi.ncontas + CsSigCqChi.ncheques
2051:                 UPDATE CsSigCqChi SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
2052:                   WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
2053:                     AND NEmitidos = 0 AND NCancelas = 0
2054:                 THIS.grd_4c_Dados.Refresh
2055:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2056:                     GOTO loc_nRecno IN CsSigCqChi
2057:                 ENDIF
2058:             ENDIF
2059:         ENDIF
2060:     ENDPROC
2061: 
2062:     *-- Grid: CheckBox Imprime - MouseUp (simula KeyPress com SPACE)
2063:     PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nX, par_nY)
2064:         THIS.ChkImprimeKeyPress(32, 0)
2065:     ENDPROC
2066: 
2067:     *==========================================================================
2068:     *  Handlers do CommandGroup principal (obj_4c_CmdGok)
2069:     *==========================================================================
2070:     PROCEDURE CmdGokClick()
2071:         DO CASE
2072:         CASE THIS.obj_4c_CmdGok.Value = 1  && Documento
2073:             THIS.BtnDocumentoClick()
2074:         CASE THIS.obj_4c_CmdGok.Value = 2  && Encerrar
2075:             THIS.BtnEncerrarClick()
2076:         CASE THIS.obj_4c_CmdGok.Value = 3  && Imprimir
2077:             THIS.BtnImprimirClick()
2078:         CASE THIS.obj_4c_CmdGok.Value = 4  && Procurar
2079:             THIS.BtnProcurarClick()
2080:         CASE THIS.obj_4c_CmdGok.Value = 5  && Recibo
2081:             THIS.BtnReciboClick()
2082:         CASE THIS.obj_4c_CmdGok.Value = 6  && Exclui Doc.
2083:             THIS.BtnExcluiDocClick()
2084:         CASE THIS.obj_4c_CmdGok.Value = 7  && Cheque (jato de tinta)
2085:             THIS.BtnImpchqClick()
2086:         CASE THIS.obj_4c_CmdGok.Value = 8  && Chq. Matric.
2087:             THIS.BtnCmdchmatClick()
2088:         CASE THIS.obj_4c_CmdGok.Value = 9  && Excluir Chq.
2089:             THIS.BtnExcluirChqClick()
2090:         ENDCASE
2091:     ENDPROC
2092: 
2093:     *-- Botao 1: Documento (abre SigCdPgr)
2094:     PROCEDURE BtnDocumentoClick()
2095:         LOCAL loc_nRecno, loc_cEDNs
2096: 
2097:         THIS.LockScreen = .T.
2098: 
2099:         TRY
2100:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
2101:                 loc_nRecno = RECNO("CsSigCqChi")
2102:                 loc_cEDNs  = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)
2103: 
2104:                 DO FORM SigCdPgr WITH LEFT(CsSigCqChi.dopes, 1), .T., ;
2105:                     CsSigCqChi.emps, CsSigCqChi.dopes, CsSigCqChi.numes
2106:                 SigCdPgr.AlwaysOnTop = .T.
2107: 
2108:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2109:                     GOTO loc_nRecno IN CsSigCqChi
2110:                 ENDIF
2111:                 THIS.MExibeCheques(.F.)
2112:             ELSE
2113:                 THIS.MExibeCheques(.T.)
2114:             ENDIF
2115:         CATCH TO loc_oErro
2116:             MsgErro(loc_oErro.Message, "Erro ao abrir Documento")
2117:         ENDTRY
2118: 
2119:         THIS.LockScreen = .F.
2120:     ENDPROC
2121: 
2122:     *-- Botao 2: Encerrar
2123:     PROCEDURE BtnEncerrarClick()
2124:         IF USED("TmpConta")
2125:             USE IN TmpConta
2126:         ENDIF
2127:         IF USED("CrContas")
2128:             USE IN CrContas
2129:         ENDIF
2130:         THIS.Release()
2131:     ENDPROC
2132: 
2133:     *-- Botao 3: Imprimir (abre SigReEch)
2134:     PROCEDURE BtnImprimirClick()
2135:         LOCAL loc_lCarrega
2136: 
2137:         TRY
2138:             loc_lCarrega = THIS.CarregaConta()
2139:             IF loc_lCarrega AND USED("CsSigCqChi") AND !EOF("CsSigCqChi")
2140:                 DO FORM SigReEch WITH CsSigCqChi.emps, CsSigCqChi.dopes, ;
2141:                     CsSigCqChi.numes, "CONSULTAR", CsSigCqChi.ncheques
2142:             ENDIF
2143:         CATCH TO loc_oErro
2144:             MsgErro(loc_oErro.Message, "Erro ao abrir Imprimir")
2145:         ENDTRY
2146:     ENDPROC
2147: 
2148:     *-- Botao 4: Procurar (exibe container cnt_4c_Procurar)
2149:     PROCEDURE BtnProcurarClick()
2150:         THIS.this_lInicio = .T.
2151: 
2152:         THIS.LockScreen = .T.
2153:         THIS.this_lInicio = .F.
2154: 
2155:         THIS.txt_4c_CdContas.Enabled      = .F.
2156:         THIS.txt_4c_DsContas.Enabled      = .F.
2157:         THIS.grd_4c_Dados.Enabled         = .F.
2158:         THIS.txt_4c_TxtFavorecido.Enabled = .F.
2159:         THIS.obj_4c_CmdGok.Enabled        = .F.
2160: 
2161:         IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
2162:             THIS.cnt_4c_Procurar.Enabled = .T.
2163:             THIS.cnt_4c_Procurar.Visible = .T.
2164:             THIS.cnt_4c_Procurar.txt_4c_Banco.SetFocus
2165:         ENDIF
2166: 
2167:         THIS.Refresh
2168:         THIS.LockScreen = .F.
2169:     ENDPROC
2170: 
2171:     *-- Botao 5: Recibo (abre SigRerec)
2172:     PROCEDURE BtnReciboClick()
2173:         LOCAL loc_lCarrega
2174: 
2175:         TRY
2176:             loc_lCarrega = THIS.CarregaConta()
2177:             IF loc_lCarrega
2178:                 DO FORM SigRerec WITH THIS, "RECIBO"
2179:             ENDIF
2180:         CATCH TO loc_oErro
2181:             MsgErro(loc_oErro.Message, "Erro ao abrir Recibo")
2182:         ENDTRY
2183:     ENDPROC
2184: 
2185:     *-- Botao 6: Exclui Doc. (mostra container justificativa para exclusao)
2186:     PROCEDURE BtnExcluiDocClick()
2187:         WITH THIS.cnt_4c_Justificativa
2188:             .Visible = .T.
2189:             .obj_4c_Get_justificativa.Value    = ""
2190:             .obj_4c_Get_justificativa.Width    = 298
2191:             .obj_4c_Get_justificativa.ReadOnly = .F.
2192:             .obj_4c_Get_justificativa.SetFocus
2193:             .obj_4c_CmdGconf.Enabled           = .T.
2194:             .obj_4c_CmdGconf.Visible           = .T.
2195:             .obj_4c_CmdGconf.Buttons(1).Enabled = .T.
2196:         ENDWITH
2197:     ENDPROC
2198: 
2199:     *-- Botao 7: Cheque (impressora jato de tinta)
2200:     PROCEDURE BtnImpchqClick()
2201:         LOCAL loc_nRecno, loc_cSQL, loc_nQueryOk
2202:         LOCAL Array loc_aPrinters(1)
2203:         LOCAL loc_nPrinters, loc_cNomeImp, loc_cNomeImpPath, loc_lEncontrou
2204:         LOCAL loc_cPrnIni, loc_nMaxCol, loc_nLivl, loc_nClvl
2205:         LOCAL loc_nLivExt1, loc_nClvExt1, loc_nLivExt2, loc_nClvExt2
2206:         LOCAL loc_nLiNom, loc_nClNom, loc_nLiCid, loc_nClCid
2207:         LOCAL loc_nLiDia, loc_nClDia, loc_nLiMes, loc_nClMes, loc_nLiAno, loc_nClAno
2208:         LOCAL loc_cPgChq, loc_cStrgMes
2209:         LOCAL loc_cPoint, loc_cSeparator
2210: 
2211:         TRY
2212:             IF !USED("CsSigCqChi") OR !SEEK(1, "CsSigCqChi", "NMarca1s")
2213:                 MsgAviso("Nenhum cheque selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
2214:                 RETURN
2215:             ENDIF
2216: 
2217:             loc_cPoint     = SET("Point")
2218:             loc_cSeparator = SET("Separator")
2219:             loc_cStrgMes   = "Janeiro  FevereiroMar" + CHR(231) + CHR(227) + "o    Abril    " + ;
2220:                              "Maio     Junho    Julho    Agosto   Setembro Outubro  Novembro Dezembro "
2221: 
2222:             *-- Buscar impressoras configuradas para cheque (CrSigCdmp.nchqfs=1)
2223:             IF USED("CrImp1")
2224:                 USE IN CrImp1
2225:             ENDIF
2226: 
2227:             SELECT DISTINCT Impres as cNomeImp1s, SPACE(100) as cNomeImp2s, 0 as nMarca1s ;
2228:               FROM CrSigCdmp ;
2229:              WHERE nchqfs = 1 ;
2230:              ORDER BY Impres ;
2231:               INTO CURSOR CrImp1 READWRITE
2232: 
2233:             IF EOF("CrImp1")
2234:                 MsgAviso("Nenhuma impressora de cheque configurada!", "Aten" + CHR(231) + CHR(227) + "o")
2235:                 USE IN CrImp1
2236:                 RETURN
2237:             ENDIF
2238: 
2239:             *-- Identificar impressoras instaladas no sistema
2240:             loc_nPrinters = APRINTERS(loc_aPrinters)
2241:             SELECT CrImp1
2242:             GO TOP
2243:             SCAN
2244:                 loc_cNomeImp = LOWER(ALLTRIM(CrImp1.cNomeImp1s))
2245:                 loc_lEncontrou = .F.
2246:                 LOCAL loc_n
2247:                 FOR loc_n = 1 TO loc_nPrinters
2248:                     IF LOWER(ALLTRIM(JUSTFNAME(loc_aPrinters(loc_n, 1)))) == loc_cNomeImp
2249:                         loc_cNomeImpPath = ALLTRIM(loc_aPrinters(loc_n, 1))
2250:                         SCATTER MEMVAR
2251:                         m.cNomeImp2s = loc_cNomeImpPath
2252:                         m.nMarca1s   = 1
2253:                         GATHER MEMVAR FIELDS cNomeImp2s, nMarca1s
2254:                         loc_lEncontrou = .T.
2255:                         EXIT
2256:                     ENDIF
2257:                 ENDFOR
2258:             ENDSCAN
2259: 
2260:             IF USED("CrImp2")
2261:                 USE IN CrImp2
2262:             ENDIF
2263:             SELECT DISTINCT cNomeImp1s, cNomeImp2s ;
2264:               FROM CrImp1 ;
2265:              WHERE nMarca1s = 1 ;
2266:              ORDER BY cNomeImp1s ;
2267:               INTO CURSOR CrImp2 READWRITE
2268: 
2269:             USE IN CrImp1
2270: 
2271:             SELECT CrImp2
2272:             INDEX ON cNomeImp2s TAG cNomeImp2s
2273:             GO TOP
2274: 
2275:             IF EOF("CrImp2")
2276:                 MsgAviso("Nenhuma impressora de cheque instalada!", "Aten" + CHR(231) + CHR(227) + "o")
2277:                 USE IN CrImp2
2278:                 RETURN
2279:             ENDIF
2280: 
2281:             *-- Selecionar impressora (se mais de uma disponivel)
2282:             IF RECCOUNT("CrImp2") > 1
2283:                 loc_cNomeImpPath = GETPRINTER()
2284:                 IF EMPTY(loc_cNomeImpPath)
2285:                     USE IN CrImp2
2286:                     RETURN
2287:                 ENDIF
2288:                 SEEK loc_cNomeImpPath IN CrImp2 ORDER cNomeImp2s
2289:                 IF EOF("CrImp2")
2290:                     GO TOP
2291:                 ENDIF
2292:             ENDIF
2293: 
2294:             IF LASTKEY() = 27
2295:                 USE IN CrImp2
2296:                 RETURN
2297:             ENDIF
2298: 
2299:             loc_cNomeImp     = ALLTRIM(CrImp2.cNomeImp1s)
2300:             loc_cNomeImpPath = ALLTRIM(CrImp2.cNomeImp2s)
2301:             USE IN CrImp2
2302: 
2303:             *-- Obter configuracoes da impressora
2304:             IF !SEEK(loc_cNomeImp, "CrSigCdmp", "impres")
2305:                 MsgErro("Configuracao da impressora nao encontrada.", "Erro")
2306:                 RETURN
2307:             ENDIF
2308: 
2309:             loc_cPrnIni   = ALLTRIM(CrSigCdmp.fontes)
2310:             loc_nMaxCol   = CrSigCdmp.maxcols
2311:             loc_nLivl     = CrSigCdmp.nlivl1s
2312:             loc_nClvl     = CrSigCdmp.nclvl1s
2313:             loc_nLivExt1  = CrSigCdmp.nlivext1s
2314:             loc_nClvExt1  = CrSigCdmp.nclvext1s
2315:             loc_nLivExt2  = CrSigCdmp.nlivext2s
2316:             loc_nClvExt2  = CrSigCdmp.nclvext2s

*-- Linhas 2435 a 3407:
2435:     ENDPROC
2436: 
2437:     *-- Botao 8: Chq. Matric. (impressora matricial por faixa ou selecionados)
2438:     PROCEDURE BtnCmdchmatClick()
2439:         LOCAL loc_nRecno, loc_cSQL, loc_nQueryOk
2440: 
2441:         TRY
2442:             IF !USED("CsSigCqChi")
2443:                 RETURN
2444:             ENDIF
2445: 
2446:             SELECT CsSigCqChi
2447:             loc_nRecno = RECNO()
2448: 
2449:             IF USED("TmpChi")
2450:                 USE IN TmpChi
2451:             ENDIF
2452: 
2453:             SELECT DISTINCT bancos ;
2454:               FROM CsSigCqChi ;
2455:              WHERE NMarca1s = 1 ;
2456:               INTO CURSOR TmpChi
2457: 
2458:             SELECT TmpChi
2459:             GO TOP
2460: 
2461:             IF !EOF()
2462:                 IF RECCOUNT("TmpChi") > 1
2463:                     MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", "Aten" + CHR(231) + CHR(227) + "o")
2464:                     SELECT CsSigCqChi
2465:                     GOTO loc_nRecno
2466:                     THIS.grd_4c_Dados.SetFocus
2467:                     RETURN
2468:                 ENDIF
2469: 
2470:                 SELECT bancos, valors, ncheques, datas, NEmitidos, NCancelas, favos ;
2471:                   FROM CsSigCqChi ;
2472:                  WHERE NMarca1s = 1 ;
2473:                  ORDER BY bancos, ncheques ;
2474:                   INTO CURSOR CrCheque
2475: 
2476:                 SELECT CrCheque
2477:                 LOCATE FOR NEmitidos = 1
2478:                 IF FOUND()
2479:                     IF MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
2480:                                    "Confirma impress" + CHR(227) + "o?", ;
2481:                                    "Aten" + CHR(231) + CHR(227) + "o")
2482:                         MsgAviso("Verifique se a impressora est" + CHR(225) + ;
2483:                                  " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
2484:                     ELSE
2485:                         IF USED("CrCheque")
2486:                             USE IN CrCheque
2487:                         ENDIF
2488:                         RETURN
2489:                     ENDIF
2490:                 ELSE
2491:                     MsgAviso("Verifique se a impressora est" + CHR(225) + ;
2492:                              " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
2493:                 ENDIF
2494: 
2495:                 GO TOP
2496: 
2497:                 DO SigIpChq.prg WITH THIS
2498: 
2499:                 PUBLIC xImpOk
2500:                 IF TYPE("xImpOk") = "L" AND xImpOk
2501:                     SELECT CrCheque
2502:                     GO TOP
2503:                     SCAN
2504:                         PRIVATE pBancos2, pNCheques2
2505:                         pBancos2   = CrCheque.bancos
2506:                         pNCheques2 = CrCheque.ncheques
2507:                         loc_cSQL   = "UPDATE SigCqChi SET emitidos = 1" + ;
2508:                                      " WHERE bancos = ?pBancos2 AND ncheques = ?pNCheques2"
2509:                         loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2510:                         IF loc_nQueryOk < 1
2511:                             MsgErro("Falha ao atualizar emissao.", "Erro")
2512:                             RETURN
2513:                         ENDIF
2514:                         UPDATE CsSigCqChi SET NEmitidos = 1 ;
2515:                           WHERE bancos = CrCheque.bancos AND ncheques = CrCheque.ncheques
2516:                         SELECT CrCheque
2517:                     ENDSCAN
2518:                     THIS.this_oBusinessObject.Commit()
2519:                 ENDIF
2520: 
2521:                 IF USED("CrCheque")
2522:                     USE IN CrCheque
2523:                 ENDIF
2524:                 SELECT CsSigCqChi
2525:                 GOTO loc_nRecno
2526:                 THIS.grd_4c_Dados.Refresh
2527:             ELSE
2528:                 *-- Nenhum cheque marcado: abrir painel de faixa matricial
2529:                 THIS.this_lChMatIni = .T.
2530:                 THIS.AtivarImpChmat()
2531:             ENDIF
2532: 
2533:             IF USED("TmpChi")
2534:                 USE IN TmpChi
2535:             ENDIF
2536: 
2537:         CATCH TO loc_oErro
2538:             MsgErro(loc_oErro.Message, "Erro em Chq. Matric.")
2539:         ENDTRY
2540:     ENDPROC
2541: 
2542:     *-- Ativa painel cnt_4c_Impchmat (equivalente ao impchmat.Init do legado)
2543:     PROCEDURE AtivarImpChmat()
2544:         IF !THIS.this_lChMatIni
2545:             RETURN
2546:         ENDIF
2547: 
2548:         THIS.LockScreen = .T.
2549:         THIS.this_lChMatIni = .F.
2550: 
2551:         THIS.cnt_4c_Impchmat.txt_4c_Banco.Value = ""
2552:         THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ""
2553:         THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ""
2554: 
2555:         THIS.obj_4c_CmdGok.Enabled        = .F.
2556:         THIS.cnt_4c_Impchmat.Enabled       = .T.
2557:         THIS.cnt_4c_Impchmat.Visible       = .T.
2558:         THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus
2559:         THIS.Refresh
2560:         THIS.LockScreen = .F.
2561:     ENDPROC
2562: 
2563:     *-- Botao 9: Excluir Chq. (exclui cheque cancelado)
2564:     PROCEDURE BtnExcluirChqClick()
2565:         LOCAL loc_cSQL, loc_nQueryOk, loc_cMensa
2566: 
2567:         IF USED("CsSigCqChi") AND !EOF("CsSigCqChi") AND ;
2568:            CsSigCqChi.NCancelas = 1 AND THIS.this_lExcluirCheque
2569:             IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
2570:                            CsSigCqChi.bancos + " / " + CsSigCqChi.agencias + ;
2571:                            " / " + CsSigCqChi.ncontas + " / " + CsSigCqChi.ncheques + " ?", ;
2572:                            "Exclus" + CHR(227) + "o de cheque cancelado")
2573: 
2574:                 PRIVATE pCidChaveDel
2575:                 pCidChaveDel = CsSigCqChi.cidchaves
2576:                 loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
2577:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2578: 
2579:                 IF loc_nQueryOk >= 1
2580:                     THIS.this_oBusinessObject.Commit()
2581:                     SELECT CsSigCqChi
2582:                     DELETE
2583:                     THIS.grd_4c_Dados.Refresh
2584:                 ELSE
2585:                     MsgErro("Falha ao excluir cheque.", "Erro")
2586:                 ENDIF
2587:             ENDIF
2588:         ENDIF
2589:     ENDPROC
2590: 
2591:     *==========================================================================
2592:     *  Handlers dos campos de filtro
2593:     *==========================================================================
2594: 
2595:     *-- CdGrupos: salva valor ao entrar
2596:     PROCEDURE CdGruposGotFocus()
2597:         THIS.this_cAntCdGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2598:     ENDPROC
2599: 
2600:     *-- CdGrupos: valida ao sair (ENTER/TAB)
2601:     PROCEDURE CdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2602:         LOCAL loc_cValor, loc_nQueryOk
2603: 
2604:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
2605:             RETURN
2606:         ENDIF
2607: 
2608:         loc_cValor = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2609: 
2610:         IF !EMPTY(loc_cValor)
2611:             PRIVATE pGrupoVal
2612:             pGrupoVal = loc_cValor
2613:             IF USED("cursor_4c_GrupoValida")
2614:                 USE IN cursor_4c_GrupoValida
2615:             ENDIF
2616:             loc_nQueryOk = SQLEXEC(gnConnHandle, ;
2617:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = ?pGrupoVal", ;
2618:                 "cursor_4c_GrupoValida")
2619:             IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
2620:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
2621:                 USE IN cursor_4c_GrupoValida
2622:             ELSE
2623:                 IF USED("cursor_4c_GrupoValida")
2624:                     USE IN cursor_4c_GrupoValida
2625:                 ENDIF
2626:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
2627:                 THIS.txt_4c_CdGrupos.Value = ""
2628:                 THIS.txt_4c_DsGrupos.Value = ""
2629:             ENDIF
2630:         ELSE
2631:             THIS.txt_4c_DsGrupos.Value = ""
2632:         ENDIF
2633: 
2634:         IF ALLTRIM(THIS.txt_4c_CdGrupos.Value) <> THIS.this_cAntCdGrupo
2635:             IF USED("CsSigCqChi")
2636:                 ZAP IN CsSigCqChi
2637:                 THIS.grd_4c_Dados.Refresh
2638:             ENDIF
2639:         ENDIF
2640:     ENDPROC
2641: 
2642:     *-- DsGrupos: salva valor ao entrar; somente editavel quando CdGrupos estiver vazio
2643:     PROCEDURE DsGruposGotFocus()
2644:         THIS.this_cAntDsGrupo = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2645:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdGrupos.Value))
2646:             THIS.txt_4c_CdGrupos.SetFocus
2647:         ENDIF
2648:     ENDPROC
2649: 
2650:     *-- DsGrupos: valida ao sair por descricao
2651:     PROCEDURE DsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2652:         LOCAL loc_cValor, loc_nQueryOk
2653: 
2654:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
2655:             RETURN
2656:         ENDIF
2657: 
2658:         loc_cValor = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2659: 
2660:         IF !EMPTY(loc_cValor)
2661:             PRIVATE pGrupoDesc
2662:             pGrupoDesc = loc_cValor
2663:             IF USED("cursor_4c_GrupoValida")
2664:                 USE IN cursor_4c_GrupoValida
2665:             ENDIF
2666:             loc_nQueryOk = SQLEXEC(gnConnHandle, ;
2667:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Descrs LIKE ?pGrupoDesc + '%'", ;
2668:                 "cursor_4c_GrupoValida")
2669:             IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
2670:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Codigos)
2671:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
2672:                 USE IN cursor_4c_GrupoValida
2673:             ELSE
2674:                 IF USED("cursor_4c_GrupoValida")
2675:                     USE IN cursor_4c_GrupoValida
2676:                 ENDIF
2677:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
2678:                 THIS.txt_4c_CdGrupos.Value = ""
2679:                 THIS.txt_4c_DsGrupos.Value = ""
2680:             ENDIF
2681:         ELSE
2682:             THIS.txt_4c_CdGrupos.Value = ""
2683:         ENDIF
2684: 
2685:         IF ALLTRIM(THIS.txt_4c_DsGrupos.Value) <> THIS.this_cAntDsGrupo
2686:             IF USED("CsSigCqChi")
2687:                 ZAP IN CsSigCqChi
2688:                 THIS.grd_4c_Dados.Refresh
2689:             ENDIF
2690:         ENDIF
2691:     ENDPROC
2692: 
2693:     *-- CdContas: salva valor ao entrar
2694:     PROCEDURE CdContasGotFocus()
2695:         THIS.this_cAntCdConta = ALLTRIM(THIS.txt_4c_CdContas.Value)
2696:     ENDPROC
2697: 
2698:     *-- CdContas: valida ao sair
2699:     PROCEDURE CdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2700:         LOCAL loc_cValor
2701: 
2702:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
2703:             RETURN
2704:         ENDIF
2705: 
2706:         loc_cValor = ALLTRIM(THIS.txt_4c_CdContas.Value)
2707: 
2708:         IF !EMPTY(loc_cValor)
2709:             IF USED("CrContas") AND SEEK(loc_cValor, "CrContas", "IClis")
2710:                 THIS.txt_4c_DsContas.Value = ALLTRIM(CrContas.RClis)
2711:             ELSE
2712:                 MsgAviso("Conta n" + CHR(227) + "o encontrada!", "")
2713:                 THIS.txt_4c_CdContas.Value = ""
2714:                 THIS.txt_4c_DsContas.Value = ""
2715:             ENDIF
2716:         ELSE
2717:             THIS.txt_4c_DsContas.Value = ""
2718:         ENDIF
2719: 
2720:         IF ALLTRIM(THIS.txt_4c_CdContas.Value) <> THIS.this_cAntCdConta
2721:             IF USED("CsSigCqChi")
2722:                 ZAP IN CsSigCqChi
2723:                 THIS.grd_4c_Dados.Refresh
2724:             ENDIF
2725:         ENDIF
2726:     ENDPROC
2727: 
2728:     *-- DsContas: salva valor ao entrar; somente editavel quando CdContas vazio
2729:     PROCEDURE DsContasGotFocus()
2730:         THIS.this_cAntDsConta = ALLTRIM(THIS.txt_4c_DsContas.Value)
2731:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
2732:             THIS.txt_4c_CdContas.SetFocus
2733:         ENDIF
2734:     ENDPROC
2735: 
2736:     *-- DsContas: valida ao sair por nome da conta
2737:     PROCEDURE DsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2738:         LOCAL loc_cValor
2739: 
2740:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
2741:             RETURN
2742:         ENDIF
2743: 
2744:         loc_cValor = ALLTRIM(THIS.txt_4c_DsContas.Value)
2745: 
2746:         IF !EMPTY(loc_cValor)
2747:             IF USED("CrContas") AND SEEK(loc_cValor, "CrContas", "RClis")
2748:                 THIS.txt_4c_CdContas.Value = ALLTRIM(CrContas.IClis)
2749:                 THIS.txt_4c_DsContas.Value = ALLTRIM(CrContas.RClis)
2750:             ELSE
2751:                 MsgAviso("Conta n" + CHR(227) + "o encontrada!", "")
2752:                 THIS.txt_4c_CdContas.Value = ""
2753:                 THIS.txt_4c_DsContas.Value = ""
2754:             ENDIF
2755:         ELSE
2756:             THIS.txt_4c_CdContas.Value = ""
2757:         ENDIF
2758: 
2759:         IF ALLTRIM(THIS.txt_4c_DsContas.Value) <> THIS.this_cAntDsConta
2760:             IF USED("CsSigCqChi")
2761:                 ZAP IN CsSigCqChi
2762:                 THIS.grd_4c_Dados.Refresh
2763:             ENDIF
2764:         ENDIF
2765:     ENDPROC
2766: 
2767:     *-- DtInicial: salva data ao entrar
2768:     PROCEDURE DtInicialGotFocus()
2769:         THIS.this_dAntDtIni = THIS.txt_4c_Dt_inicial.Value
2770:     ENDPROC
2771: 
2772:     *-- DtInicial: valida ao sair
2773:     PROCEDURE DtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2774:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2775:             RETURN
2776:         ENDIF
2777:         IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
2778:             THIS.txt_4c_Dt_final.Value = THIS.txt_4c_Dt_inicial.Value
2779:         ENDIF
2780:         IF THIS.txt_4c_Dt_inicial.Value <> THIS.this_dAntDtIni
2781:             IF USED("CsSigCqChi")
2782:                 ZAP IN CsSigCqChi
2783:                 THIS.grd_4c_Dados.Refresh
2784:             ENDIF
2785:         ENDIF
2786:     ENDPROC
2787: 
2788:     *-- DtFinal: salva data ao entrar
2789:     PROCEDURE DtFinalGotFocus()
2790:         THIS.this_dAntDtFin = THIS.txt_4c_Dt_final.Value
2791:     ENDPROC
2792: 
2793:     *-- DtFinal: valida ao sair
2794:     PROCEDURE DtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2795:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2796:             RETURN
2797:         ENDIF
2798:         IF THIS.txt_4c_Dt_final.Value < THIS.txt_4c_Dt_inicial.Value
2799:             THIS.txt_4c_Dt_inicial.Value = THIS.txt_4c_Dt_final.Value
2800:         ENDIF
2801:         IF THIS.txt_4c_Dt_final.Value <> THIS.this_dAntDtFin
2802:             IF USED("CsSigCqChi")
2803:                 ZAP IN CsSigCqChi
2804:                 THIS.grd_4c_Dados.Refresh
2805:             ENDIF
2806:         ENDIF
2807:     ENDPROC
2808: 
2809:     *-- Botao Desmarcar Todos
2810:     PROCEDURE CmdApaga1Click()
2811:         LOCAL loc_nRecno
2812: 
2813:         IF !USED("CsSigCqChi")
2814:             RETURN
2815:         ENDIF
2816:         loc_nRecno = RECNO("CsSigCqChi")
2817:         UPDATE CsSigCqChi SET NMarca1s = 0 WHERE NMarca1s = 1
2818:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2819:             GOTO loc_nRecno IN CsSigCqChi
2820:         ENDIF
2821:         THIS.grd_4c_Dados.Refresh
2822:     ENDPROC
2823: 
2824:     *-- Botao Marcar Todos
2825:     PROCEDURE CmdTudo1Click()
2826:         LOCAL loc_nRecno
2827: 
2828:         IF !USED("CsSigCqChi")
2829:             RETURN
2830:         ENDIF
2831:         loc_nRecno = RECNO("CsSigCqChi")
2832:         UPDATE CsSigCqChi SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
2833:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2834:             GOTO loc_nRecno IN CsSigCqChi
2835:         ENDIF
2836:         THIS.grd_4c_Dados.Refresh
2837:     ENDPROC
2838: 
2839:     *-- Botao Processar
2840:     PROCEDURE Command2Click()
2841:         IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
2842:             MsgAviso("Data Final menor que Data Inicial !!!", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
2843:             THIS.txt_4c_Dt_inicial.SetFocus
2844:             RETURN
2845:         ENDIF
2846: 
2847:         IF THIS.this_dAntDtIni <> THIS.txt_4c_Dt_inicial.Value OR ;
2848:            THIS.this_dAntDtFin <> THIS.txt_4c_Dt_final.Value OR ;
2849:            THIS.this_cAntCdGrupo <> ALLTRIM(THIS.txt_4c_CdGrupos.Value) OR ;
2850:            THIS.this_cAntCdConta <> ALLTRIM(THIS.txt_4c_CdContas.Value)
2851: 
2852:             IF !THIS.MontaChq(.F.)
2853:                 MsgErro("Falha ao processar cheques.", "Erro")
2854:                 RETURN
2855:             ENDIF
2856: 
2857:             THIS.this_dAntDtIni    = THIS.txt_4c_Dt_inicial.Value
2858:             THIS.this_dAntDtFin    = THIS.txt_4c_Dt_final.Value
2859:             THIS.this_cAntCdGrupo  = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2860:             THIS.this_cAntCdConta  = ALLTRIM(THIS.txt_4c_CdContas.Value)
2861:         ENDIF
2862: 
2863:         THIS.grd_4c_Dados.Column2.SetFocus
2864:     ENDPROC
2865: 
2866:     *==========================================================================
2867:     *  Handlers do container cnt_4c_Justificativa
2868:     *==========================================================================
2869:     PROCEDURE CmdGconfClick()
2870:         LOCAL loc_nRecno
2871: 
2872:         DO CASE
2873:         CASE THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Value = 1  && Confirmar
2874: 
2875:             IF EMPTY(ALLTRIM(THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.Value))
2876:                 MsgAviso("Justificativa em branco!", "Aten" + CHR(231) + CHR(227) + "o")
2877:                 THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.SetFocus
2878:                 RETURN
2879:             ENDIF
2880: 
2881:             THIS.LockScreen = .T.
2882: 
2883:             TRY
2884:                 IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
2885:                     loc_nRecno = RECNO("CsSigCqChi")
2886:                     THIS.Enabled = .F.
2887:                     DO FORM SigCdPgr WITH LEFT(CsSigCqChi.dopes, 1), .F., ;
2888:                         CsSigCqChi.emps, CsSigCqChi.dopes, CsSigCqChi.numes, .T., THIS, ;
2889:                         ALLTRIM(THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.Value)
2890:                     SigCdPgr.AlwaysOnTop = .T.
2891:                 ELSE
2892:                     THIS.MExibeCheques(.T.)
2893:                 ENDIF
2894:             CATCH TO loc_oErro
2895:                 THIS.Enabled = .T.
2896:                 MsgErro(loc_oErro.Message, "Erro ao confirmar cancelamento")
2897:             ENDTRY
2898: 
2899:             THIS.LockScreen = .F.
2900: 
2901:         CASE THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Value = 2  && Cancelar
2902:             THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Enabled = .F.
2903:             THIS.cnt_4c_Justificativa.Visible = .F.
2904:         ENDCASE
2905:     ENDPROC
2906: 
2907:     *==========================================================================
2908:     *  Handlers do container cnt_4c_Impchmat (impressao matricial por faixa)
2909:     *==========================================================================
2910:     PROCEDURE ImpchmatBancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2911:         *-- Leitor CMC-7: inicia captura em < (60) e finaliza em : (58)
2912:         IF par_nKeyCode = 60
2913:             IF !THIS.this_lLeCheque
2914:                 THIS.this_cChqLido = ""
2915:             ENDIF
2916:             THIS.this_lLeCheque = .T.
2917:         ENDIF
2918:         IF THIS.this_lLeCheque
2919:             THIS.this_cChqLido = THIS.this_cChqLido + CHR(par_nKeyCode)
2920:         ENDIF
2921:         IF par_nKeyCode = 58
2922:             THIS.this_lLeCheque = .F.
2923:         ENDIF
2924:     ENDPROC
2925: 
2926:     PROCEDURE ImpchmatChiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2927:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
2928:             THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ;
2929:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
2930:         ENDIF
2931:     ENDPROC
2932: 
2933:     PROCEDURE ImpchmatChfinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2934:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
2935:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ;
2936:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
2937:         ENDIF
2938:     ENDPROC
2939: 
2940:     PROCEDURE ImpchmatCmdGprocurarClick()
2941:         DO CASE
2942:         CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 1  && Imprimir
2943:             THIS.ImpchmatImprimirClick()
2944:         CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 2  && Encerrar
2945:             THIS.ImpchmatEncerrarClick()
2946:         ENDCASE
2947:     ENDPROC
2948: 
2949:     PROCEDURE ImpchmatImprimirClick()
2950:         LOCAL loc_cBanco, loc_cChIni, loc_cChFin
2951: 
2952:         loc_cBanco = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Banco.Value)
2953:         loc_cChIni = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
2954:         loc_cChFin = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)
2955: 
2956:         IF EMPTY(loc_cBanco)
2957:             MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2958:             THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus
2959:             RETURN
2960:         ENDIF
2961:         IF EMPTY(loc_cChIni)
2962:             MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", ;
2963:                      "Aten" + CHR(231) + CHR(227) + "o")
2964:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus
2965:             RETURN
2966:         ENDIF
2967:         IF EMPTY(loc_cChFin)
2968:             MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", ;
2969:                      "Aten" + CHR(231) + CHR(227) + "o")
2970:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus
2971:             RETURN
2972:         ENDIF
2973:         IF loc_cChFin < loc_cChIni
2974:             MsgAviso("N" + CHR(250) + "mero do cheque final menor que o inicial !!!", ;
2975:                      "Aten" + CHR(231) + CHR(227) + "o")
2976:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus
2977:             RETURN
2978:         ENDIF
2979: 
2980:         TRY
2981:             IF USED("CrCheque")
2982:                 USE IN CrCheque
2983:             ENDIF
2984: 
2985:             PRIVATE pBancoFil, pChIniFil, pChFinFil
2986:             pBancoFil = loc_cBanco
2987:             pChIniFil = loc_cChIni
2988:             pChFinFil = loc_cChFin
2989: 
2990:             SELECT bancos, valors, ncheques, datas, favos, NEmitidos ;
2991:               FROM CsSigCqChi ;
2992:              WHERE bancos = ?pBancoFil ;
2993:                AND ncheques BETWEEN ?pChIniFil AND ?pChFinFil ;
2994:                AND NCancelas = 0 ;
2995:              ORDER BY bancos, ncheques ;
2996:               INTO CURSOR CrCheque
2997: 
2998:             SELECT CrCheque
2999:             LOCATE FOR NEmitidos = 1
3000:             IF FOUND()
3001:                 IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
3002:                                 "Confirma impress" + CHR(227) + "o?", ;
3003:                                 "Aten" + CHR(231) + CHR(227) + "o")
3004:                     USE IN CrCheque
3005:                     RETURN
3006:                 ENDIF
3007:             ENDIF
3008: 
3009:             GO TOP
3010:             MsgAviso("Verificar se a impressora est" + CHR(225) + ;
3011:                      " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
3012: 
3013:             DO SigIpChq.prg
3014: 
3015:             PUBLIC xImpOk
3016:             IF TYPE("xImpOk") = "L" AND xImpOk
3017:                 LOCAL loc_cSQL, loc_nQueryOk
3018:                 SELECT CrCheque
3019:                 SCAN
3020:                     PRIVATE pBancoUpd, pNChequeUpd
3021:                     pBancoUpd   = CrCheque.bancos
3022:                     pNChequeUpd = CrCheque.ncheques
3023:                     loc_cSQL = "UPDATE SigCqChi SET emitidos = 1" + ;
3024:                                " WHERE bancos = ?pBancoUpd AND ncheques = ?pNChequeUpd"
3025:                     loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
3026:                     IF loc_nQueryOk < 1
3027:                         MsgErro("Falha ao atualizar emissao.", "Erro")
3028:                         EXIT
3029:                     ENDIF
3030:                     SELECT CrCheque
3031:                 ENDSCAN
3032:             ENDIF
3033: 
3034:             IF USED("CrCheque")
3035:                 USE IN CrCheque
3036:             ENDIF
3037: 
3038:         CATCH TO loc_oErro
3039:             MsgErro(loc_oErro.Message, "Erro na impressao matricial")
3040:         ENDTRY
3041:     ENDPROC
3042: 
3043:     PROCEDURE ImpchmatEncerrarClick()
3044:         THIS.LockScreen = .T.
3045:         THIS.obj_4c_CmdGok.Enabled   = .T.
3046:         THIS.cnt_4c_Impchmat.Enabled  = .F.
3047:         THIS.cnt_4c_Impchmat.Visible  = .F.
3048:         THIS.MExibeCheques(.F.)
3049:         THIS.LockScreen = .F.
3050:     ENDPROC
3051: 
3052:     *==========================================================================
3053:     *  Handlers do container cnt_4c_Procurar (busca por criterios)
3054:     *==========================================================================
3055:     PROCEDURE ProcurarBancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3056:         *-- Leitor CMC-7: inicia em < (60), encerra em : (58)
3057:         IF par_nKeyCode = 60
3058:             IF !THIS.this_lLeCheque
3059:                 THIS.this_cChqLido = ""
3060:             ENDIF
3061:             THIS.this_lLeCheque = .T.
3062:         ENDIF
3063:         IF THIS.this_lLeCheque
3064:             THIS.this_cChqLido = THIS.this_cChqLido + CHR(par_nKeyCode)
3065:         ENDIF
3066:         IF par_nKeyCode = 58
3067:             THIS.this_lLeCheque = .F.
3068:             *-- Processar leitura CMC-7 se codigo completo (>= 33 chars)
3069:             IF LEN(THIS.this_cChqLido) >= 33
3070:                 THIS.cnt_4c_Procurar.txt_4c_Banco.Value   = SUBSTR(THIS.this_cChqLido, 2, 3)
3071:                 THIS.cnt_4c_Procurar.txt_4c_Agencia.Value = SUBSTR(THIS.this_cChqLido, 5, 4)
3072:                 THIS.cnt_4c_Procurar.txt_4c_Conta.Value   = SUBSTR(THIS.this_cChqLido, 23, 10)
3073:                 THIS.cnt_4c_Procurar.txt_4c_Cheque.Value  = SUBSTR(THIS.this_cChqLido, 14, 6)
3074:                 THIS.Refresh
3075:                 THIS.ProcurarPesquisarClick()
3076:             ENDIF
3077:         ENDIF
3078:     ENDPROC
3079: 
3080:     PROCEDURE ProcurarEmissaoGotFocus()
3081:         *-- Mutualmente exclusivo com Valor: somente editavel se Valor vazio
3082:         IF !EMPTY(TRANSFORM(THIS.cnt_4c_Procurar.txt_4c_Valor.Value))
3083:             THIS.cnt_4c_Procurar.txt_4c_Valor.SetFocus
3084:         ENDIF
3085:     ENDPROC
3086: 
3087:     PROCEDURE ProcurarValorGotFocus()
3088:         *-- Mutualmente exclusivo com Emissao: somente editavel se Emissao vazia
3089:         IF !EMPTY(THIS.cnt_4c_Procurar.txt_4c_Emissao.Value)
3090:             THIS.cnt_4c_Procurar.txt_4c_Emissao.SetFocus
3091:         ENDIF
3092:     ENDPROC
3093: 
3094:     PROCEDURE ProcurarCmdgprocurarClick()
3095:         DO CASE
3096:         CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 1  && Pesquisar
3097:             THIS.ProcurarPesquisarClick()
3098:         CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 2  && Cancelar/Encerrar
3099:             THIS.ProcurarCancelarClick()
3100:         ENDCASE
3101:     ENDPROC
3102: 
3103:     PROCEDURE ProcurarPesquisarClick()
3104:         LOCAL loc_cBanco, loc_cAgencia, loc_cConta, loc_cCheque
3105:         LOCAL loc_dEmissao, loc_nValor
3106: 
3107:         loc_cBanco   = PADR(ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Banco.Value), 3)
3108:         loc_cAgencia = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Agencia.Value)
3109:         loc_cConta   = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Conta.Value)
3110:         loc_cCheque  = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Cheque.Value)
3111:         loc_dEmissao = THIS.cnt_4c_Procurar.txt_4c_Emissao.Value
3112:         loc_nValor   = THIS.cnt_4c_Procurar.txt_4c_Valor.Value
3113: 
3114:         SET NEAR ON
3115:         SELECT CsSigCqChi
3116: 
3117:         DO CASE
3118:         CASE !EMPTY(loc_dEmissao) AND VARTYPE(loc_dEmissao) = "D"
3119:             SET ORDER TO Emissao
3120:             SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3121:         CASE loc_nValor <> 0
3122:             SET ORDER TO Valor
3123:             SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3124:         CASE !EMPTY(loc_cBanco)
3125:             SET ORDER TO Cheque
3126:             SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3127:         CASE !EMPTY(loc_cAgencia)
3128:             SET ORDER TO Agencia
3129:             SEEK loc_cAgencia + loc_cConta + loc_cCheque
3130:         CASE !EMPTY(loc_cConta)
3131:             SET ORDER TO Conta
3132:             SEEK loc_cConta + loc_cCheque
3133:         CASE !EMPTY(loc_cCheque)
3134:             SET ORDER TO NCheques
3135:             SEEK loc_cCheque
3136:         ENDCASE
3137: 
3138:         SET NEAR OFF
3139: 
3140:         THIS.LockScreen = .T.
3141:         THIS.txt_4c_CdContas.Enabled      = .T.
3142:         THIS.txt_4c_DsContas.Enabled      = .T.
3143:         THIS.grd_4c_Dados.Enabled         = .T.
3144:         THIS.txt_4c_TxtFavorecido.Enabled = .T.
3145:         THIS.obj_4c_CmdGok.Enabled        = .T.
3146:         THIS.cnt_4c_Procurar.Enabled      = .F.
3147:         THIS.cnt_4c_Procurar.Visible      = .F.
3148:         THIS.MExibeCheques(.F.)
3149:         THIS.LockScreen = .F.
3150:     ENDPROC
3151: 
3152:     PROCEDURE ProcurarCancelarClick()
3153:         THIS.LockScreen = .T.
3154:         THIS.txt_4c_CdContas.Enabled      = .T.
3155:         THIS.txt_4c_DsContas.Enabled      = .T.
3156:         THIS.grd_4c_Dados.Enabled         = .T.
3157:         THIS.txt_4c_TxtFavorecido.Enabled = .T.
3158:         THIS.obj_4c_CmdGok.Enabled        = .T.
3159:         THIS.cnt_4c_Procurar.Enabled      = .F.
3160:         THIS.cnt_4c_Procurar.Visible      = .F.
3161:         THIS.MExibeCheques(.F.)
3162:         THIS.LockScreen = .F.
3163:     ENDPROC
3164: 
3165:     *==========================================================================
3166:     *  Eventos principais dos botoes (mapeamento operacional CRUD)
3167:     *  FormSigPrChr eh OPERACIONAL (processamento de cheques recebidos):
3168:     *   - Incluir     -> ativar container Impchmat (entrada manual de faixa
3169:     *                    de cheques por banco + cheque inicial/final)
3170:     *   - Alterar     -> abrir SigCdPgr para edicao do documento associado
3171:     *   - Visualizar  -> abrir SigReEch (visualizacao/impressao do cheque)
3172:     *   - Excluir     -> excluir cheque cancelado selecionado no grid
3173:     *==========================================================================
3174: 
3175:     *-- Incluir: ativa container de entrada manual (impchmat) para faixa de cheques
3176:     PROCEDURE BtnIncluirClick()
3177:         TRY
3178:             IF EMPTY(THIS.txt_4c_CdContas.Value)
3179:                 MsgAviso("Selecione uma conta antes de incluir cheques.", ;
3180:                          "Aten" + CHR(231) + CHR(227) + "o")
3181:                 THIS.txt_4c_CdContas.SetFocus
3182:                 RETURN
3183:             ENDIF
3184:             THIS.this_lChMatIni = .T.
3185:             THIS.AtivarImpChmat()
3186:         CATCH TO loc_oErro
3187:             MsgErro(loc_oErro.Message, "Erro em Incluir")
3188:         ENDTRY
3189:     ENDPROC
3190: 
3191:     *-- Alterar: abre SigCdPgr do documento vinculado ao cheque corrente
3192:     PROCEDURE BtnAlterarClick()
3193:         LOCAL loc_nRecno, loc_cEDNs, loc_lTemQuery
3194: 
3195:         TRY
3196:             IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
3197:                 MsgAviso("Nenhum cheque selecionado para alterar.", ;
3198:                          "Aten" + CHR(231) + CHR(227) + "o")
3199:                 RETURN
3200:             ENDIF
3201: 
3202:             IF CsSigCqChi.NCancelas <> 0
3203:                 MsgAviso("Cheque cancelado nao pode ser alterado.", ;
3204:                          "Aten" + CHR(231) + CHR(227) + "o")
3205:                 RETURN
3206:             ENDIF
3207: 
3208:             THIS.LockScreen = .T.
3209:             loc_nRecno = RECNO("CsSigCqChi")
3210:             loc_cEDNs  = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)
3211: 
3212:             loc_lTemQuery = .F.
3213:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
3214:                PEMSTATUS(THIS.this_oBusinessObject, "CursorQuery", 5)
3215:                 loc_lTemQuery = THIS.this_oBusinessObject.CursorQuery("SigCdPgr", "", "empdopnums", loc_cEDNs)
3216:             ELSE
3217:                 loc_lTemQuery = .T.
3218:             ENDIF
3219: 
3220:             IF loc_lTemQuery
3221:                 DO FORM SigCdPgr WITH LEFT(CsSigCqChi.dopes, 1), .T., ;
3222:                     CsSigCqChi.emps, CsSigCqChi.dopes, CsSigCqChi.numes
3223:                 IF TYPE("SigCdPgr") = "O"
3224:                     SigCdPgr.AlwaysOnTop = .T.
3225:                 ENDIF
3226:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
3227:                     GOTO loc_nRecno IN CsSigCqChi
3228:                 ENDIF
3229:                 THIS.MExibeCheques(.F.)
3230:             ELSE
3231:                 MsgAviso("Documento associado ao cheque nao encontrado.", ;
3232:                          "Aten" + CHR(231) + CHR(227) + "o")
3233:             ENDIF
3234: 
3235:             THIS.LockScreen = .F.
3236:         CATCH TO loc_oErro
3237:             THIS.LockScreen = .F.
3238:             MsgErro(loc_oErro.Message, "Erro em Alterar")
3239:         ENDTRY
3240:     ENDPROC
3241: 
3242:     *-- Visualizar: abre SigReEch em modo CONSULTAR (visualizacao do cheque)
3243:     PROCEDURE BtnVisualizarClick()
3244:         LOCAL loc_lCarrega
3245: 
3246:         TRY
3247:             IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
3248:                 MsgAviso("Nenhum cheque selecionado para visualizar.", ;
3249:                          "Aten" + CHR(231) + CHR(227) + "o")
3250:                 RETURN
3251:             ENDIF
3252: 
3253:             loc_lCarrega = THIS.CarregaConta()
3254:             IF loc_lCarrega
3255:                 DO FORM SigReEch WITH CsSigCqChi.emps, CsSigCqChi.dopes, ;
3256:                     CsSigCqChi.numes, "CONSULTAR", CsSigCqChi.ncheques
3257:             ENDIF
3258:         CATCH TO loc_oErro
3259:             MsgErro(loc_oErro.Message, "Erro em Visualizar")
3260:         ENDTRY
3261:     ENDPROC
3262: 
3263:     *-- Excluir: exclui cheque cancelado selecionado
3264:     PROCEDURE BtnExcluirClick()
3265:         LOCAL loc_cSQL, loc_nQueryOk, loc_cMensa
3266: 
3267:         TRY
3268:             IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
3269:                 MsgAviso("Nenhum cheque selecionado para excluir.", ;
3270:                          "Aten" + CHR(231) + CHR(227) + "o")
3271:                 RETURN
3272:             ENDIF
3273: 
3274:             IF CsSigCqChi.NCancelas <> 1
3275:                 MsgAviso("Apenas cheques cancelados podem ser exclu" + CHR(237) + "dos.", ;
3276:                          "Aten" + CHR(231) + CHR(227) + "o")
3277:                 RETURN
3278:             ENDIF
3279: 
3280:             IF !THIS.this_lExcluirCheque
3281:                 MsgAviso("Acesso negado para exclus" + CHR(227) + "o de cheques.", ;
3282:                          "Acesso Negado")
3283:                 RETURN
3284:             ENDIF
3285: 
3286:             IF MsgConfirma("Deseja realmente excluir o cheque:" + CHR(13) + ;
3287:                            CsSigCqChi.bancos + " / " + CsSigCqChi.agencias + ;
3288:                            " / " + CsSigCqChi.ncontas + " / " + CsSigCqChi.ncheques + " ?", ;
3289:                            "Exclus" + CHR(227) + "o de cheque cancelado")
3290: 
3291:                 PRIVATE pCidChaveDel
3292:                 pCidChaveDel = CsSigCqChi.cidchaves
3293:                 loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
3294:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
3295: 
3296:                 IF loc_nQueryOk >= 1
3297:                     THIS.this_oBusinessObject.Commit()
3298:                     loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado: " + ;
3299:                                  CsSigCqChi.bancos + "/" + CsSigCqChi.agencias + ;
3300:                                  "/" + CsSigCqChi.ncontas + "/" + CsSigCqChi.ncheques
3301:                     SELECT CsSigCqChi
3302:                     DELETE
3303:                     THIS.grd_4c_Dados.Refresh
3304:                     MsgInfo("Cheque exclu" + CHR(237) + "do com sucesso.", ;
3305:                             "Exclus" + CHR(227) + "o")
3306:                 ELSE
3307:                     MsgErro("Falha ao excluir cheque.", "Erro")
3308:                 ENDIF
3309:             ENDIF
3310:         CATCH TO loc_oErro
3311:             MsgErro(loc_oErro.Message, "Erro em Excluir")
3312:         ENDTRY
3313:     ENDPROC
3314: 
3315:     *==========================================================================
3316:     *  FASE 8/8 - Metodos auxiliares e consolidacao final
3317:     *==========================================================================
3318: 
3319:     *--------------------------------------------------------------------------
3320:     PROCEDURE CarregarLista()
3321:     *  Carrega/atualiza o grid de cheques conforme filtros ativos.
3322:     *--------------------------------------------------------------------------
3323:         THIS.MontaChq(.F.)
3324:     ENDPROC
3325: 
3326:     *--------------------------------------------------------------------------
3327:     PROCEDURE BtnBuscarClick()
3328:     *  Alias do botao Processar: recarrega os cheques conforme filtros atuais.
3329:     *--------------------------------------------------------------------------
3330:         THIS.Command2Click()
3331:     ENDPROC
3332: 
3333:     *--------------------------------------------------------------------------
3334:     PROCEDURE BtnSalvarClick()
3335:     *  Form OPERACIONAL: nao ha CRUD de tabela unica. Confirma transacoes
3336:     *  em aberto e atualiza o grid para refletir o estado atual do cursor.
3337:     *--------------------------------------------------------------------------
3338:         TRY
3339:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3340:                 THIS.this_oBusinessObject.CommitTransacao()
3341:             ENDIF
3342:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3343:                 THIS.grd_4c_Dados.Refresh
3344:             ENDIF
3345:         CATCH TO loc_oErro
3346:             MsgErro(loc_oErro.Message, "Erro ao salvar")
3347:         ENDTRY
3348:     ENDPROC
3349: 
3350:     *--------------------------------------------------------------------------
3351:     PROCEDURE BtnCancelarClick()
3352:     *  Cancela operacao corrente: fecha containers flutuantes e volta a vista principal.
3353:     *--------------------------------------------------------------------------
3354:         IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
3355:             THIS.ProcurarCancelarClick()
3356:         ENDIF
3357:         IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
3358:             THIS.ImpchmatEncerrarClick()
3359:         ENDIF
3360:         IF PEMSTATUS(THIS, "cnt_4c_Justificativa", 5) AND THIS.cnt_4c_Justificativa.Visible
3361:             THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Enabled = .F.
3362:             THIS.cnt_4c_Justificativa.Visible = .F.
3363:         ENDIF
3364:     ENDPROC
3365: 
3366:     *--------------------------------------------------------------------------
3367:     PROCEDURE FormParaBO()
3368:     *  Transfere filtros ativos do form para as propriedades do BO.
3369:     *--------------------------------------------------------------------------
3370:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
3371:             RETURN
3372:         ENDIF
3373: 
3374:         WITH THIS.this_oBusinessObject
3375:             .this_dDtInicial  = THIS.txt_4c_Dt_inicial.Value
3376:             .this_dDtFinal    = THIS.txt_4c_Dt_final.Value
3377:             .this_cCdGrupo    = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
3378:             .this_cDsGrupo    = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
3379:             .this_cCdConta    = ALLTRIM(THIS.txt_4c_CdContas.Value)
3380:             .this_cDsConta    = ALLTRIM(THIS.txt_4c_DsContas.Value)
3381: 
3382:             *-- Painel Impchmat
3383:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
3384:                 .this_cBancoMat = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Banco.Value)
3385:                 .this_cChIniMat = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
3386:                 .this_cChFinMat = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)
3387:             ENDIF
3388: 
3389:             *-- Painel Procurar
3390:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
3391:                 .this_cBancoPrc   = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Banco.Value)
3392:                 .this_cAgenciaPrc = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Agencia.Value)
3393:                 .this_cContaPrc   = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Conta.Value)
3394:                 .this_cChequePrc  = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Cheque.Value)
3395:                 .this_dEmissaoPrc = THIS.cnt_4c_Procurar.txt_4c_Emissao.Value
3396:                 .this_nValorPrc   = THIS.cnt_4c_Procurar.txt_4c_Valor.Value
3397:             ENDIF
3398: 
3399:             *-- Cheque selecionado no grid
3400:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
3401:                 .this_cEmps       = NVL(CsSigCqChi.emps, "")
3402:                 .this_cDopes      = NVL(CsSigCqChi.dopes, "")
3403:                 .this_cNumes      = NVL(STR(CsSigCqChi.numes, 6), "")
3404:                 .this_dDatas      = NVL(CsSigCqChi.datas, {})
3405:                 .this_cBancos     = NVL(CsSigCqChi.bancos, "")
3406:                 .this_cAgencias   = NVL(CsSigCqChi.agencias, "")
3407:                 .this_cNcontas    = NVL(CsSigCqChi.ncontas, "")

*-- Linhas 3423 a 3526:
3423:     ENDPROC
3424: 
3425:     *--------------------------------------------------------------------------
3426:     PROCEDURE BOParaForm()
3427:     *  Transfere propriedades do BO para os controles do form.
3428:     *--------------------------------------------------------------------------
3429:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
3430:             RETURN
3431:         ENDIF
3432: 
3433:         WITH THIS.this_oBusinessObject
3434:             THIS.txt_4c_Dt_inicial.Value   = IIF(EMPTY(.this_dDtInicial), DATE(), .this_dDtInicial)
3435:             THIS.txt_4c_Dt_final.Value     = IIF(EMPTY(.this_dDtFinal), DATE(), .this_dDtFinal)
3436:             THIS.txt_4c_CdGrupos.Value     = .this_cCdGrupo
3437:             THIS.txt_4c_DsGrupos.Value     = .this_cDsGrupo
3438:             THIS.txt_4c_CdContas.Value     = .this_cCdConta
3439:             THIS.txt_4c_DsContas.Value     = .this_cDsConta
3440: 
3441:             IF !EMPTY(.this_cFavos)
3442:                 THIS.txt_4c_TxtFavorecido.Value = .this_cFavos
3443:             ENDIF
3444: 
3445:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
3446:                 THIS.cnt_4c_Impchmat.txt_4c_Banco.Value = .this_cBancoMat
3447:                 THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = .this_cChIniMat
3448:                 THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = .this_cChFinMat
3449:             ENDIF
3450: 
3451:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
3452:                 THIS.cnt_4c_Procurar.txt_4c_Banco.Value   = .this_cBancoPrc
3453:                 THIS.cnt_4c_Procurar.txt_4c_Agencia.Value = .this_cAgenciaPrc
3454:                 THIS.cnt_4c_Procurar.txt_4c_Conta.Value   = .this_cContaPrc
3455:                 THIS.cnt_4c_Procurar.txt_4c_Cheque.Value  = .this_cChequePrc
3456:                 THIS.cnt_4c_Procurar.txt_4c_Emissao.Value = IIF(EMPTY(.this_dEmissaoPrc), {}, .this_dEmissaoPrc)
3457:                 THIS.cnt_4c_Procurar.txt_4c_Valor.Value   = .this_nValorPrc
3458:             ENDIF
3459:         ENDWITH
3460:     ENDPROC
3461: 
3462:     *--------------------------------------------------------------------------
3463:     PROCEDURE HabilitarCampos(par_lHabilitar)
3464:     *  Habilita ou desabilita os controles de filtro e o grid.
3465:     *--------------------------------------------------------------------------
3466:         LOCAL loc_lHab
3467: 
3468:         IF TYPE("par_lHabilitar") = "L"
3469:             loc_lHab = par_lHabilitar
3470:         ELSE
3471:             loc_lHab = .T.
3472:         ENDIF
3473: 
3474:         THIS.txt_4c_CdGrupos.Enabled       = loc_lHab
3475:         THIS.txt_4c_DsGrupos.Enabled       = loc_lHab
3476:         THIS.txt_4c_CdContas.Enabled       = loc_lHab
3477:         THIS.txt_4c_DsContas.Enabled       = loc_lHab
3478:         THIS.txt_4c_Dt_inicial.Enabled     = loc_lHab
3479:         THIS.txt_4c_Dt_final.Enabled       = loc_lHab
3480:         THIS.cmd_4c_Command2.Enabled       = loc_lHab
3481:         THIS.grd_4c_Dados.Enabled          = loc_lHab
3482:         THIS.txt_4c_TxtFavorecido.Enabled  = loc_lHab
3483:         THIS.obj_4c_CmdGok.Enabled         = loc_lHab
3484: 
3485:         IF loc_lHab
3486:             THIS.cmd_4c_Tudo1.Visible  = .T.
3487:             THIS.cmd_4c_Apaga1.Visible = .T.
3488:         ENDIF
3489:     ENDPROC
3490: 
3491:     *--------------------------------------------------------------------------
3492:     PROCEDURE LimparCampos()
3493:     *  Limpa os filtros e reseta o grid para estado inicial.
3494:     *--------------------------------------------------------------------------
3495:         THIS.txt_4c_CdGrupos.Value      = ""
3496:         THIS.txt_4c_DsGrupos.Value      = ""
3497:         THIS.txt_4c_CdContas.Value      = ""
3498:         THIS.txt_4c_DsContas.Value      = ""
3499:         THIS.txt_4c_Dt_inicial.Value    = DATE()
3500:         THIS.txt_4c_Dt_final.Value      = DATE()
3501:         THIS.txt_4c_TxtFavorecido.Value = ""
3502: 
3503:         THIS.this_cAntCdGrupo = ""
3504:         THIS.this_cAntDsGrupo = ""
3505:         THIS.this_cAntCdConta = ""
3506:         THIS.this_cAntDsConta = ""
3507:         THIS.this_dAntDtIni   = {}
3508:         THIS.this_dAntDtFin   = {}
3509: 
3510:         IF USED("CsSigCqChi")
3511:             ZAP IN CsSigCqChi
3512:         ENDIF
3513: 
3514:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3515:             THIS.grd_4c_Dados.Refresh
3516:         ENDIF
3517:     ENDPROC
3518: 
3519:     *--------------------------------------------------------------------------
3520:     PROCEDURE AjustarBotoesPorModo()
3521:     *  Ajusta os botoes do CommandGroup conforme o cheque selecionado no grid.
3522:     *--------------------------------------------------------------------------
3523:         THIS.AtualizarEstadoGrid()
3524:     ENDPROC
3525: 
3526: ENDDEFINE

