# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (15)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_PROCURAR, CNT_4C_IMPCHMAT. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3527 linhas total):

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

*-- Linhas 402 a 445:
402:     ENDPROC
403: 
404:     *--------------------------------------------------------------------------
405:     PROTECTED PROCEDURE ConfigurarGrid()
406:     *  Grid grd_4c_Dados (10 colunas) + cmd_4c_Tudo1 + cmd_4c_Apaga1.
407:     *  Original: Top=233, Left=24, Width=710, Height=291 -> escala 1.25x.
408:     *--------------------------------------------------------------------------
409:         THIS.AddObject("grd_4c_Dados", "Grid")
410:         THIS.grd_4c_Dados.ColumnCount = 10
411:         WITH THIS.grd_4c_Dados
412:             .Top               = 233
413:             .Left              = 30
414:             .Width             = 888
415:             .Height            = 291
416:             .FontName          = "Tahoma"
417:             .AllowHeaderSizing = .F.
418:             .AllowRowSizing    = .F.
419:             .DeleteMark        = .F.
420:             .ReadOnly          = .F.
421:             .ScrollBars        = 2
422:             .GridLineColor     = RGB(238, 238, 238)
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

*-- Linhas 676 a 772:
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
693:                           "CNT_4C_CABECALHO", ;
694:                           "CNT_4C_JUSTIFICATIVA", ;
695:                           "CNT_4C_IMPCHMAT", ;
696:                           "CNT_4C_PROCURAR")
697:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
698:                        loc_oControl.ControlCount > 0
699:                         THIS.TornarControlesVisiveis(loc_oControl)
700:                     ENDIF
701:                     LOOP
702:                 ENDIF
703: 
704:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
705:                     loc_oControl.Visible = .T.
706:                 ENDIF
707: 
708:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
709:                    loc_oControl.ControlCount > 0
710:                     THIS.TornarControlesVisiveis(loc_oControl)
711:                 ENDIF
712:             ENDIF
713:         ENDFOR
714:     ENDPROC
715: 
716:     *--------------------------------------------------------------------------
717:     PROTECTED PROCEDURE ConfigurarPaginaLista()
718:     *  Form OPERACIONAL: layout FLAT (sem Page1/Page2 do padrao CRUD).
719:     *  Este metodo agrega a configuracao equivalente a "Page1 (Lista)":
720:     *    - obj_4c_CmdGok (CommandGroup com 9 botoes operacionais)
721:     *    - grd_4c_Dados (Grid principal de cheques, 10 colunas)
722:     *    - cmd_4c_Tudo1 / cmd_4c_Apaga1 (Marcar/Desmarcar Todos)
723:     *    - Filtros (Grupo, Conta, Periodo, Processar, Favorecido)
724:     *  Chamado por InicializarForm (compatibilidade com pipeline de migracao).
725:     *--------------------------------------------------------------------------
726:         THIS.ConfigurarGrupoBotoes()
727:         THIS.ConfigurarGrid()
728:         THIS.ConfigurarFiltros()
729:     ENDPROC
730: 
731:     *--------------------------------------------------------------------------
732:     PROTECTED PROCEDURE ConfigurarFiltros()
733:     *  Cria a area de filtros entre o cabecalho e o grid.
734:     *  Linha 1 (Top~163): Grupo (lookup) | Periodo (datas)
735:     *  Linha 2 (Top~190): Conta (lookup) | Processar
736:     *  Rodape (Top=530): TxtFavorecido
737:     *  Shapes decorativas ao redor das duas areas (filtros e grade).
738:     *  Posicoes: escala 1.25x horizontal do original 800px.
739:     *--------------------------------------------------------------------------
740: 
741:         *-- Shape2: borda ao redor da area de filtros (original Top=156, Width=774)
742:         THIS.AddObject("shp_4c_Shape2", "Shape")
743:         WITH THIS.shp_4c_Shape2
744:             .Top         = 156
745:             .Left        = 23
746:             .Width       = 968
747:             .Height      = 66
748:             .BackStyle   = 0
749:             .BorderStyle = 1
750:             .BorderWidth = 1
751:             .BorderColor = RGB(136, 189, 188)
752:             .Visible     = .T.
753:         ENDWITH
754:         THIS.shp_4c_Shape2.ZOrder(1)
755: 
756:         *-- Shape1: borda ao redor da grade de cheques (original Top=227, Width=774)
757:         THIS.AddObject("shp_4c_Shape1", "Shape")
758:         WITH THIS.shp_4c_Shape1
759:             .Top         = 227
760:             .Left        = 23
761:             .Width       = 968
762:             .Height      = 301
763:             .BackStyle   = 0
764:             .BorderStyle = 1
765:             .BorderWidth = 1
766:             .BorderColor = RGB(136, 189, 188)
767:             .Visible     = .T.
768:         ENDWITH
769:         THIS.shp_4c_Shape1.ZOrder(1)
770: 
771:         *-- Label "Grupo :" (original Label3: Top=167, Left=34)
772:         THIS.AddObject("lbl_4c_Label3", "Label")

*-- Linhas 827 a 848:
827:             .ForeColor = RGB(0, 0, 0)
828:             .Visible   = .T.
829:         ENDWITH
830: 
831:         *-- TextBox data inicial (original Dt_inicial: Top=163, Left=598, class fweditdata)
832:         THIS.AddObject("txt_4c_Dt_inicial", "TextBox")
833:         WITH THIS.txt_4c_Dt_inicial
834:             .Top         = 163
835:             .Left        = 748
836:             .Width       = 86
837:             .Height      = 25
838:             .Value       = DATE()
839:             .Format      = "D"
840:             .FontName    = "Tahoma"
841:             .FontSize    = 8
842:             .BorderStyle = 1
843:             .Visible     = .T.
844:         ENDWITH
845: 
846:         *-- Label "a" (original Say2: Top=167, Left=686)
847:         THIS.AddObject("lbl_4c_Say2", "Label")
848:         WITH THIS.lbl_4c_Say2

*-- Linhas 857 a 893:
857:             .ForeColor = RGB(0, 0, 0)
858:             .Visible   = .T.
859:         ENDWITH
860: 
861:         *-- TextBox data final (original Dt_final: Top=163, Left=701, class fweditdata)
862:         THIS.AddObject("txt_4c_Dt_final", "TextBox")
863:         WITH THIS.txt_4c_Dt_final
864:             .Top         = 163
865:             .Left        = 858
866:             .Width       = 86
867:             .Height      = 25
868:             .Value       = DATE()
869:             .Format      = "D"
870:             .FontName    = "Tahoma"
871:             .FontSize    = 8
872:             .BorderStyle = 1
873:             .Visible     = .T.
874:         ENDWITH
875: 
876:         *-- Botao Processar (original Command2: Top=191, Left=598, Width=88, Height=24)
877:         THIS.AddObject("cmd_4c_Command2", "CommandButton")
878:         WITH THIS.cmd_4c_Command2
879:             .Top         = 191
880:             .Left        = 748
881:             .Width       = 110
882:             .Height      = 24
883:             .Caption     = "Processar"
884:             .FontName    = "Tahoma"
885:             .FontSize    = 8
886:             .FontBold    = .F.
887:             .ForeColor   = RGB(0, 0, 0)
888:             .BackColor   = RGB(236, 233, 216)
889:             .Themes      = .T.
890:             .Visible     = .T.
891:         ENDWITH
892: 
893:         *-- Label "Conta :" (original Label1: Top=194, Left=34, Width=38)

*-- Linhas 968 a 1022:
968:     ENDPROC
969: 
970:     *--------------------------------------------------------------------------
971:     PROTECTED PROCEDURE ConfigurarPaginaDados()
972:     *  Form OPERACIONAL: nao ha PageFrame. Este metodo agrega a configuracao
973:     *  dos containers flutuantes:
974:     *    Fase 5: cnt_4c_Justificativa + cnt_4c_Procurar
975:     *    Fase 6: cnt_4c_Impchmat (adicionado em Edit seguinte)
976:     *--------------------------------------------------------------------------
977:         THIS.ConfigurarContainerJustificativa()
978:         THIS.ConfigurarContainerProcurar()
979:     ENDPROC
980: 
981:     *--------------------------------------------------------------------------
982:     PROTECTED PROCEDURE ConfigurarContainerJustificativa()
983:     *  Container flutuante para digitacao da justificativa de cancelamento.
984:     *  Original: cntjustificativa - Top=532, Left=395, Width=350, Height=69.
985:     *  Escala 1.25x horizontal -> Left=494, Width=438.
986:     *  Exibido por BtnExcluirChqClick (Fase 6); oculto por CmdGconfCancelarClick.
987:     *--------------------------------------------------------------------------
988:         THIS.AddObject("cnt_4c_Justificativa", "Container")
989:         WITH THIS.cnt_4c_Justificativa
990:             .Top         = 532
991:             .Left        = 494
992:             .Width       = 438
993:             .Height      = 69
994:             .BackStyle   = 1
995:             .BackColor   = RGB(236, 233, 216)
996:             .BorderWidth = 1
997:             .Visible     = .F.
998: 
999:             *-- Label descricao (original: Label5, top=5, left=6, width=143)
1000:             .AddObject("lbl_4c_Label5", "Label")
1001:             WITH .lbl_4c_Label5
1002:                 .Top       = 5
1003:                 .Left      = 6
1004:                 .Width     = 179
1005:                 .Height    = 15
1006:                 .Caption   = "Justificativa do cancelamento"
1007:                 .FontName  = "Tahoma"
1008:                 .FontSize  = 8
1009:                 .BackStyle = 0
1010:                 .ForeColor = RGB(0, 0, 0)
1011:                 .Visible   = .T.
1012:             ENDWITH
1013: 
1014:             *-- EditBox para digitar a justificativa (original: get_justificativa, fwmemo)
1015:             *  Top=21, Left=3, Width=238, Height=44 -> Width=298 (escala 1.25x)
1016:             .AddObject("obj_4c_Get_justificativa", "EditBox")
1017:             WITH .obj_4c_Get_justificativa
1018:                 .Top         = 21
1019:                 .Left        = 3
1020:                 .Width       = 298
1021:                 .Height      = 44
1022:                 .Value       = ""

*-- Linhas 1080 a 1123:
1080:     ENDPROC
1081: 
1082:     *--------------------------------------------------------------------------
1083:     PROTECTED PROCEDURE ConfigurarContainerProcurar()
1084:     *  Container flutuante para pesquisa de cheque por banco/agencia/conta/numero.
1085:     *  Original: cntProcurar - Top=284, Left=240, Width=314, Height=218.
1086:     *  Escala 1.25x horizontal -> Left=300, Width=393.
1087:     *  Exibido por BtnProcurarClick (Buttons(4) - Fase 6); oculto por Voltar.
1088:     *  Tambem integra leitura de CMC-7 (leitor de codigo de barras).
1089:     *--------------------------------------------------------------------------
1090:         THIS.AddObject("cnt_4c_Procurar", "Container")
1091:         WITH THIS.cnt_4c_Procurar
1092:             .Top         = 284
1093:             .Left        = 300
1094:             .Width       = 393
1095:             .Height      = 218
1096:             .BackStyle   = 1
1097:             .BackColor   = RGB(236, 233, 216)
1098:             .BorderWidth = 1
1099:             .Visible     = .F.
1100: 
1101:             *-- Label titulo (original: Label1, top=8, left=12, width=54, caption="Procurar")
1102:             .AddObject("lbl_4c_Label1", "Label")
1103:             WITH .lbl_4c_Label1
1104:                 .Top       = 8
1105:                 .Left      = 12
1106:                 .Width     = 68
1107:                 .Height    = 16
1108:                 .Caption   = "Procurar"
1109:                 .FontName  = "Tahoma"
1110:                 .FontSize  = 8
1111:                 .FontBold  = .T.
1112:                 .BackStyle = 0
1113:                 .ForeColor = RGB(0, 0, 0)
1114:                 .Visible   = .T.
1115:             ENDWITH
1116: 
1117:             *-- Label "Banco :" (original: lblBanco, top=139, left=36)
1118:             .AddObject("lbl_4c_LblBanco", "Label")
1119:             WITH .lbl_4c_LblBanco
1120:                 .Top       = 139
1121:                 .Left      = 45
1122:                 .Width     = 48
1123:                 .Height    = 15

*-- Linhas 1345 a 1459:
1345:     ENDPROC
1346: 
1347:     *--------------------------------------------------------------------------
1348:     PROCEDURE AlternarPagina(par_nVisao)
1349:     *  Gerencia visibilidade dos containers flutuantes.
1350:     *  par_nVisao: 0=Grade principal, 1=Procurar, 2=Impressao Matricial
1351:     *  Containers (cnt_4c_Procurar, cnt_4c_Impchmat) criados nas Fases 5+.
1352:     *--------------------------------------------------------------------------
1353:         DO CASE
1354:         CASE par_nVisao = 0
1355:             *-- Retorna para a visao principal
1356:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
1357:                 THIS.cnt_4c_Procurar.Enabled = .F.
1358:                 THIS.cnt_4c_Procurar.Visible = .F.
1359:             ENDIF
1360:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
1361:                 THIS.cnt_4c_Impchmat.Enabled = .F.
1362:                 THIS.cnt_4c_Impchmat.Visible = .F.
1363:             ENDIF
1364:             THIS.grd_4c_Dados.Enabled         = .T.
1365:             THIS.txt_4c_CdContas.Enabled      = .T.
1366:             THIS.txt_4c_DsContas.Enabled      = .T.
1367:             THIS.txt_4c_TxtFavorecido.Enabled = .T.
1368:             THIS.obj_4c_CmdGok.Enabled        = .T.
1369:             THIS.cmd_4c_Tudo1.Visible         = .T.
1370:             THIS.cmd_4c_Apaga1.Visible        = .T.
1371:         CASE par_nVisao = 1
1372:             *-- Exibe painel Procurar, desabilita grade
1373:             THIS.grd_4c_Dados.Enabled         = .F.
1374:             THIS.txt_4c_CdContas.Enabled      = .F.
1375:             THIS.txt_4c_DsContas.Enabled      = .F.
1376:             THIS.txt_4c_TxtFavorecido.Enabled = .F.
1377:             THIS.obj_4c_CmdGok.Enabled        = .F.
1378:             THIS.cmd_4c_Tudo1.Visible         = .F.
1379:             THIS.cmd_4c_Apaga1.Visible        = .F.
1380:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
1381:                 THIS.cnt_4c_Procurar.Enabled = .T.
1382:                 THIS.cnt_4c_Procurar.Visible = .T.
1383:             ENDIF
1384:         CASE par_nVisao = 2
1385:             *-- Exibe painel Impressao Matricial, desabilita grade
1386:             THIS.grd_4c_Dados.Enabled         = .F.
1387:             THIS.txt_4c_CdContas.Enabled      = .F.
1388:             THIS.txt_4c_DsContas.Enabled      = .F.
1389:             THIS.txt_4c_TxtFavorecido.Enabled = .F.
1390:             THIS.obj_4c_CmdGok.Enabled        = .F.
1391:             THIS.cmd_4c_Tudo1.Visible         = .F.
1392:             THIS.cmd_4c_Apaga1.Visible        = .F.
1393:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
1394:                 THIS.cnt_4c_Impchmat.Enabled = .T.
1395:                 THIS.cnt_4c_Impchmat.Visible = .T.
1396:             ENDIF
1397:         ENDCASE
1398:     ENDPROC
1399: 
1400:     *--------------------------------------------------------------------------
1401:     PROCEDURE Destroy()
1402:     *--------------------------------------------------------------------------
1403:         TRY
1404:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1405:                 THIS.this_oBusinessObject.LiberarCursores()
1406:                 THIS.this_oBusinessObject = .NULL.
1407:             ENDIF
1408:         CATCH TO loc_oErro
1409:             MsgErro(loc_oErro.Message, "Erro ao encerrar")
1410:         ENDTRY
1411:         DODEFAULT()
1412:     ENDPROC
1413: 
1414:     *==========================================================================
1415:     *  FASE 6/8 - cnt_4c_Impchmat + RegistrarBINDEVENTs + event handlers
1416:     *==========================================================================
1417: 
1418:     *--------------------------------------------------------------------------
1419:     PROTECTED PROCEDURE ConfigurarContainerImpchmat()
1420:     *  Container flutuante para impressao matricial por faixa de numeros.
1421:     *  Original: impchmat - Top=284, Left=240, Width=314, Height=218.
1422:     *  Escala 1.25x horizontal -> Left=300, Width=393.
1423:     *--------------------------------------------------------------------------
1424:         THIS.AddObject("cnt_4c_Impchmat", "Container")
1425:         WITH THIS.cnt_4c_Impchmat
1426:             .Top         = 284
1427:             .Left        = 300
1428:             .Width       = 393
1429:             .Height      = 218
1430:             .BackStyle   = 1
1431:             .BackColor   = RGB(255, 255, 255)
1432:             .BorderWidth = 1
1433:             .Visible     = .F.
1434: 
1435:             .AddObject("lbl_4c_Label1", "Label")
1436:             WITH .lbl_4c_Label1
1437:                 .Top       = 8
1438:                 .Left      = 12
1439:                 .Width     = 81
1440:                 .Height    = 16
1441:                 .Caption   = "Impress" + CHR(227) + "o"
1442:                 .FontName  = "Tahoma"
1443:                 .FontSize  = 8
1444:                 .FontBold  = .T.
1445:                 .BackStyle = 0
1446:                 .ForeColor = RGB(90, 90, 90)
1447:                 .Visible   = .T.
1448:             ENDWITH
1449: 
1450:             .AddObject("lbl_4c_LblBanco", "Label")
1451:             WITH .lbl_4c_LblBanco
1452:                 .Top       = 157
1453:                 .Left      = 83
1454:                 .Width     = 48
1455:                 .Height    = 15
1456:                 .Caption   = "Banco :"
1457:                 .FontName  = "Tahoma"
1458:                 .FontSize  = 8
1459:                 .BackStyle = 0

*-- Linhas 1592 a 1690:
1592:     ENDPROC
1593: 
1594:     *--------------------------------------------------------------------------
1595:     PROTECTED PROCEDURE RegistrarBINDEVENTs()
1596:     *  Registra todos os eventos dos controles nos handlers PUBLIC do form.
1597:     *--------------------------------------------------------------------------
1598:         *-- CommandGroup principal (9 botoes)
1599:         BINDEVENT(THIS.obj_4c_CmdGok, "Click", THIS, "CmdGokClick")
1600: 
1601:         *-- Grid: navegacao de linha e scroll
1602:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange",  THIS, "GrdAfterRowColChange")
1603:         BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange", THIS, "GrdBeforeRowColChange")
1604:         BINDEVENT(THIS.grd_4c_Dados, "Scrolled",           THIS, "GrdScrolled")
1605:         BINDEVENT(THIS.grd_4c_Dados, "DoScroll",           THIS, "GrdDoScroll")
1606: 
1607:         *-- Grid: Header da coluna NCopias
1608:         BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "HeaderNcopiasClick")
1609: 
1610:         *-- Grid: CheckBox coluna Imprime
1611:         BINDEVENT(THIS.grd_4c_Dados.Column10.chk_4c_Imprime, "KeyPress", THIS, "ChkImprimeKeyPress")
1612:         BINDEVENT(THIS.grd_4c_Dados.Column10.chk_4c_Imprime, "MouseUp",  THIS, "ChkImprimeMouseUp")
1613: 
1614:         *-- Botoes marcar/desmarcar
1615:         BINDEVENT(THIS.cmd_4c_Apaga1,   "Click", THIS, "CmdApaga1Click")
1616:         BINDEVENT(THIS.cmd_4c_Tudo1,    "Click", THIS, "CmdTudo1Click")
1617:         BINDEVENT(THIS.cmd_4c_Command2, "Click", THIS, "Command2Click")
1618: 
1619:         *-- Campos de filtro: GotFocus salva valor anterior; KeyPress valida ao sair
1620:         BINDEVENT(THIS.txt_4c_CdGrupos,  "GotFocus", THIS, "CdGruposGotFocus")
1621:         BINDEVENT(THIS.txt_4c_CdGrupos,  "KeyPress", THIS, "CdGruposKeyPress")
1622:         BINDEVENT(THIS.txt_4c_DsGrupos,  "GotFocus", THIS, "DsGruposGotFocus")
1623:         BINDEVENT(THIS.txt_4c_DsGrupos,  "KeyPress", THIS, "DsGruposKeyPress")
1624:         BINDEVENT(THIS.txt_4c_CdContas,  "GotFocus", THIS, "CdContasGotFocus")
1625:         BINDEVENT(THIS.txt_4c_CdContas,  "KeyPress", THIS, "CdContasKeyPress")
1626:         BINDEVENT(THIS.txt_4c_DsContas,  "GotFocus", THIS, "DsContasGotFocus")
1627:         BINDEVENT(THIS.txt_4c_DsContas,  "KeyPress", THIS, "DsContasKeyPress")
1628:         BINDEVENT(THIS.txt_4c_Dt_inicial,"GotFocus", THIS, "DtInicialGotFocus")
1629:         BINDEVENT(THIS.txt_4c_Dt_inicial,"KeyPress", THIS, "DtInicialKeyPress")
1630:         BINDEVENT(THIS.txt_4c_Dt_final,  "GotFocus", THIS, "DtFinalGotFocus")
1631:         BINDEVENT(THIS.txt_4c_Dt_final,  "KeyPress", THIS, "DtFinalKeyPress")
1632: 
1633:         *-- Container Justificativa: CommandGroup confirmar/cancelar
1634:         BINDEVENT(THIS.cnt_4c_Justificativa.obj_4c_CmdGconf, "Click", THIS, "CmdGconfClick")
1635: 
1636:         *-- Container ImpChMat: CommandGroup imprimir/encerrar + campos
1637:         BINDEVENT(THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar, "Click",    THIS, "ImpchmatCmdGprocurarClick")
1638:         BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Banco,         "KeyPress", THIS, "ImpchmatBancoKeyPress")
1639:         BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chini,         "KeyPress", THIS, "ImpchmatChiniKeyPress")
1640:         BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chfin,         "KeyPress", THIS, "ImpchmatChfinKeyPress")
1641: 
1642:         *-- Container Procurar: CommandGroup pesquisar/cancelar + campos
1643:         BINDEVENT(THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar, "Click",    THIS, "ProcurarCmdgprocurarClick")
1644:         BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Banco,         "KeyPress", THIS, "ProcurarBancoKeyPress")
1645:         BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Emissao,       "GotFocus", THIS, "ProcurarEmissaoGotFocus")
1646:         BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Valor,         "GotFocus", THIS, "ProcurarValorGotFocus")
1647:     ENDPROC
1648: 
1649:     *--------------------------------------------------------------------------
1650:     PROCEDURE MExibeCheques(par_lSeek)
1651:     *  Atualiza a grade de cheques aplicando filtro de conta e marcacoes zeradas.
1652:     *  par_lSeek = .T.: posiciona no fim do cursor (apos incluir/alterar).
1653:     *--------------------------------------------------------------------------
1654:         LOCAL loc_lSeek
1655: 
1656:         IF TYPE("par_lSeek") = "L"
1657:             loc_lSeek = par_lSeek
1658:         ELSE
1659:             loc_lSeek = .F.
1660:         ENDIF
1661: 
1662:         THIS.LockScreen = .T.
1663: 
1664:         TRY
1665:             IF USED("CsSigCqChi")
1666:                 UPDATE CsSigCqChi SET nMarca1s = 0 WHERE nMarca1s = 1
1667:             ENDIF
1668: 
1669:             IF EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
1670:                 SELECT CsSigCqChi
1671:                 SET ORDER TO NCopias
1672:                 IF loc_lSeek
1673:                     SEEK CHR(255) IN CsSigCqChi ORDER NCopias ASCENDING
1674:                 ENDIF
1675:             ELSE
1676:                 SELECT CsSigCqChi
1677:                 SET ORDER TO Contas
1678:                 SET KEY TO ALLTRIM(THIS.txt_4c_CdContas.Value)
1679:                 IF loc_lSeek
1680:                     SEEK ALLTRIM(THIS.txt_4c_CdContas.Value) + CHR(255) IN CsSigCqChi ORDER Contas ASCENDING
1681:                 ENDIF
1682:             ENDIF
1683: 
1684:             THIS.obj_4c_CmdGok.Buttons(4).Enabled = .T.
1685:             THIS.obj_4c_CmdGok.Refresh
1686:             THIS.grd_4c_Dados.Refresh
1687: 
1688:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
1689:                 THIS.txt_4c_TxtFavorecido.Value = ALLTRIM(CsSigCqChi.favos)
1690:             ENDIF

*-- Linhas 1698 a 1741:
1698:     ENDPROC
1699: 
1700:     *--------------------------------------------------------------------------
1701:     PROCEDURE MontaChq(par_lPosiciona)
1702:     *  Carrega o cursor CsSigCqChi via SQL conforme os filtros da tela.
1703:     *  par_lPosiciona = .T.: reposiciona no cheque atual apos recarregar.
1704:     *--------------------------------------------------------------------------
1705:         LOCAL loc_lResultado, loc_lPosiciona, loc_cBusca
1706:         LOCAL loc_cCdGrupo, loc_cCdConta, loc_cQuery, loc_nQueryOk
1707:         PRIVATE pDtInicial, pDtFinal
1708: 
1709:         loc_lResultado = .F.
1710: 
1711:         TRY
1712:             loc_lPosiciona = (TYPE("par_lPosiciona") = "L" AND par_lPosiciona)
1713: 
1714:             IF loc_lPosiciona AND USED("CsSigCqChi") AND !EOF("CsSigCqChi")
1715:                 loc_cBusca = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
1716:                              CsSigCqChi.ncontas  + CsSigCqChi.ncheques
1717:             ELSE
1718:                 loc_cBusca = ""
1719:             ENDIF
1720: 
1721:             pDtInicial   = THIS.txt_4c_Dt_inicial.Value
1722:             pDtFinal     = THIS.txt_4c_Dt_final.Value
1723:             loc_cCdGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
1724:             loc_cCdConta = ALLTRIM(THIS.txt_4c_CdContas.Value)
1725: 
1726:             THIS.LockScreen = .T.
1727:             WAIT WINDOW "Aguarde! Selecionando Cheques..." NOWAIT
1728: 
1729:             IF USED("CsSigCqChi")
1730:                 THIS.grd_4c_Dados.RecordSource = ""
1731:                 USE IN CsSigCqChi
1732:             ENDIF
1733: 
1734:             IF EMPTY(loc_cCdConta)
1735:                 loc_cQuery = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias," + ;
1736:                              " a.ncontas, a.ncheques, a.contas," + ;
1737:                              " a.valors, a.favos, a.ncopias, a.emitidos, a.nemissoes, a.cancelas," + ;
1738:                              " a.cidchaves, a.JustCanc, 0 as NEmitidos, 0 as NCancelas, 0 as NMarca1s" + ;
1739:                              " FROM SigCqChi a" + ;
1740:                              " WHERE a.datas BETWEEN ?pDtInicial AND ?pDtFinal"
1741:                 loc_cQuery = loc_cQuery + ;

*-- Linhas 1845 a 1888:
1845:     ENDPROC
1846: 
1847:     *--------------------------------------------------------------------------
1848:     PROCEDURE CarregaConta()
1849:     *  Carrega TmpConta com dados de pagamento do cheque selecionado em CsSigCqChi.
1850:     *  Chamado por BtnImprimirClick e BtnReciboClick antes de abrir subform.
1851:     *--------------------------------------------------------------------------
1852:         LOCAL loc_lResultado, loc_cChave, loc_cSQL, loc_nQueryOk
1853: 
1854:         loc_lResultado = .F.
1855: 
1856:         TRY
1857:             IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
1858:                 loc_lResultado = .F.
1859:             ENDIF
1860: 
1861:             loc_cChave = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)
1862: 
1863:             IF USED("TmpPrIt")
1864:                 USE IN TmpPrIt
1865:             ENDIF
1866: 
1867:             loc_cSQL = "SELECT emps, dopes, numes, empos, grupos, contas, tipos, nopers, opers," + ;
1868:                        " acertos, cotacaos, valos, moedas, hists, vencs, datas" + ;
1869:                        " FROM SigCdPit" + ;
1870:                        " WHERE empdopnums = " + EscaparSQL(loc_cChave) + ;
1871:                        " ORDER BY emps, dopes, numes, grupos, contas, nopers"
1872: 
1873:             loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPrIt")
1874:             IF loc_nQueryOk < 1
1875:                 MsgErro("Falha ao carregar pagamentos.", "Erro")
1876:                 loc_lResultado = .F.
1877:             ENDIF
1878: 
1879:             IF USED("TmpConta")
1880:                 USE IN TmpConta
1881:             ENDIF
1882: 
1883:             SET NULL ON
1884:             CREATE CURSOR TmpConta (grupos C(10) NULL, contas C(10) NULL, flag L NULL, ;
1885:                 valos N(12,2) NULL, acerto N(12,2) NULL, moedas C(3) NULL, ;
1886:                 datas D NULL, vencs D NULL, hists C(50) NULL, nomes C(50) NULL, ;
1887:                 emps C(3) NULL, nopers N(9,0) NULL, dopes C(20) NULL, numes N(6,0) NULL, ;
1888:                 tipos C(1) NULL, fpags C(12) NULL, opers C(1) NULL, baixa N(12,2) NULL, ;

*-- Linhas 1973 a 2317:
1973:     *--------------------------------------------------------------------------
1974:     *  Helper: atualiza estado dos botoes e justificativa conforme linha do grid
1975:     *--------------------------------------------------------------------------
1976:     PROTECTED PROCEDURE AtualizarEstadoGrid()
1977:         LOCAL loc_lCancelas
1978: 
1979:         IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
1980:             RETURN
1981:         ENDIF
1982: 
1983:         loc_lCancelas = (CsSigCqChi.NCancelas <> 0)
1984: 
1985:         THIS.txt_4c_TxtFavorecido.Value = ALLTRIM(CsSigCqChi.favos)
1986: 
1987:         THIS.obj_4c_CmdGok.Buttons(1).Enabled = !loc_lCancelas                              && Documento
1988:         THIS.obj_4c_CmdGok.Buttons(6).Enabled = (!loc_lCancelas AND THIS.this_lExcluirDocumento) && ExcluiDoc
1989:         THIS.obj_4c_CmdGok.Buttons(3).Enabled = !loc_lCancelas                              && Imprimir
1990:         THIS.obj_4c_CmdGok.Buttons(5).Enabled = !loc_lCancelas                              && Recibo
1991:         THIS.obj_4c_CmdGok.Buttons(9).Enabled = (loc_lCancelas AND THIS.this_lExcluirCheque) && ExcluirChq
1992: 
1993:         IF loc_lCancelas
1994:             WITH THIS.cnt_4c_Justificativa
1995:                 .Visible = .T.
1996:                 .obj_4c_Get_justificativa.Width    = 346
1997:                 .obj_4c_Get_justificativa.ReadOnly = .T.
1998:                 .obj_4c_Get_justificativa.Refresh
1999:                 .obj_4c_CmdGconf.Enabled = .F.
2000:                 .obj_4c_CmdGconf.Visible = .F.
2001:             ENDWITH
2002:         ELSE
2003:             WITH THIS.cnt_4c_Justificativa
2004:                 .Visible = .F.
2005:                 .obj_4c_Get_justificativa.ReadOnly = .F.
2006:                 .obj_4c_CmdGconf.Enabled = .F.
2007:                 .obj_4c_CmdGconf.Visible = .F.
2008:             ENDWITH
2009:         ENDIF
2010: 
2011:         THIS.txt_4c_TxtFavorecido.Refresh
2012:         THIS.obj_4c_CmdGok.Refresh
2013:     ENDPROC
2014: 
2015:     *-- Grid: AfterRowColChange
2016:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
2017:         THIS.AtualizarEstadoGrid()
2018:     ENDPROC
2019: 
2020:     *-- Grid: BeforeRowColChange
2021:     PROCEDURE GrdBeforeRowColChange(par_nColIndex)
2022:         THIS.AtualizarEstadoGrid()
2023:     ENDPROC
2024: 
2025:     *-- Grid: Scrolled
2026:     PROCEDURE GrdScrolled(par_nDirection)
2027:         THIS.AtualizarEstadoGrid()
2028:     ENDPROC
2029: 
2030:     *-- Grid: DoScroll
2031:     PROCEDURE GrdDoScroll(par_nDirection)
2032:         THIS.AtualizarEstadoGrid()
2033:     ENDPROC
2034: 
2035:     *-- Grid: Header da coluna NCopias
2036:     PROCEDURE HeaderNcopiasClick()
2037:         IF EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value)) AND ;
2038:            UPPER(ORDER("CsSigCqChi")) <> "NCOPIAS"
2039:             THIS.MExibeCheques(.F.)
2040:         ENDIF
2041:     ENDPROC
2042: 
2043:     *-- Grid: CheckBox Imprime - KeyPress (ENTER/SPACE toggle marca)
2044:     PROCEDURE ChkImprimeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2045:         LOCAL loc_nRecno, loc_cChave
2046: 
2047:         IF INLIST(par_nKeyCode, 13, 32)
2048:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
2049:                 loc_nRecno = RECNO("CsSigCqChi")
2050:                 loc_cChave = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
2051:                              CsSigCqChi.ncontas + CsSigCqChi.ncheques
2052:                 UPDATE CsSigCqChi SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
2053:                   WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
2054:                     AND NEmitidos = 0 AND NCancelas = 0
2055:                 THIS.grd_4c_Dados.Refresh
2056:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2057:                     GOTO loc_nRecno IN CsSigCqChi
2058:                 ENDIF
2059:             ENDIF
2060:         ENDIF
2061:     ENDPROC
2062: 
2063:     *-- Grid: CheckBox Imprime - MouseUp (simula KeyPress com SPACE)
2064:     PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nX, par_nY)
2065:         THIS.ChkImprimeKeyPress(32, 0)
2066:     ENDPROC
2067: 
2068:     *==========================================================================
2069:     *  Handlers do CommandGroup principal (obj_4c_CmdGok)
2070:     *==========================================================================
2071:     PROCEDURE CmdGokClick()
2072:         DO CASE
2073:         CASE THIS.obj_4c_CmdGok.Value = 1  && Documento
2074:             THIS.BtnDocumentoClick()
2075:         CASE THIS.obj_4c_CmdGok.Value = 2  && Encerrar
2076:             THIS.BtnEncerrarClick()
2077:         CASE THIS.obj_4c_CmdGok.Value = 3  && Imprimir
2078:             THIS.BtnImprimirClick()
2079:         CASE THIS.obj_4c_CmdGok.Value = 4  && Procurar
2080:             THIS.BtnProcurarClick()
2081:         CASE THIS.obj_4c_CmdGok.Value = 5  && Recibo
2082:             THIS.BtnReciboClick()
2083:         CASE THIS.obj_4c_CmdGok.Value = 6  && Exclui Doc.
2084:             THIS.BtnExcluiDocClick()
2085:         CASE THIS.obj_4c_CmdGok.Value = 7  && Cheque (jato de tinta)
2086:             THIS.BtnImpchqClick()
2087:         CASE THIS.obj_4c_CmdGok.Value = 8  && Chq. Matric.
2088:             THIS.BtnCmdchmatClick()
2089:         CASE THIS.obj_4c_CmdGok.Value = 9  && Excluir Chq.
2090:             THIS.BtnExcluirChqClick()
2091:         ENDCASE
2092:     ENDPROC
2093: 
2094:     *-- Botao 1: Documento (abre SigCdPgr)
2095:     PROCEDURE BtnDocumentoClick()
2096:         LOCAL loc_nRecno, loc_cEDNs
2097: 
2098:         THIS.LockScreen = .T.
2099: 
2100:         TRY
2101:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
2102:                 loc_nRecno = RECNO("CsSigCqChi")
2103:                 loc_cEDNs  = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)
2104: 
2105:                 DO FORM SigCdPgr WITH LEFT(CsSigCqChi.dopes, 1), .T., ;
2106:                     CsSigCqChi.emps, CsSigCqChi.dopes, CsSigCqChi.numes
2107:                 SigCdPgr.AlwaysOnTop = .T.
2108: 
2109:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2110:                     GOTO loc_nRecno IN CsSigCqChi
2111:                 ENDIF
2112:                 THIS.MExibeCheques(.F.)
2113:             ELSE
2114:                 THIS.MExibeCheques(.T.)
2115:             ENDIF
2116:         CATCH TO loc_oErro
2117:             MsgErro(loc_oErro.Message, "Erro ao abrir Documento")
2118:         ENDTRY
2119: 
2120:         THIS.LockScreen = .F.
2121:     ENDPROC
2122: 
2123:     *-- Botao 2: Encerrar
2124:     PROCEDURE BtnEncerrarClick()
2125:         IF USED("TmpConta")
2126:             USE IN TmpConta
2127:         ENDIF
2128:         IF USED("CrContas")
2129:             USE IN CrContas
2130:         ENDIF
2131:         THIS.Release()
2132:     ENDPROC
2133: 
2134:     *-- Botao 3: Imprimir (abre SigReEch)
2135:     PROCEDURE BtnImprimirClick()
2136:         LOCAL loc_lCarrega
2137: 
2138:         TRY
2139:             loc_lCarrega = THIS.CarregaConta()
2140:             IF loc_lCarrega AND USED("CsSigCqChi") AND !EOF("CsSigCqChi")
2141:                 DO FORM SigReEch WITH CsSigCqChi.emps, CsSigCqChi.dopes, ;
2142:                     CsSigCqChi.numes, "CONSULTAR", CsSigCqChi.ncheques
2143:             ENDIF
2144:         CATCH TO loc_oErro
2145:             MsgErro(loc_oErro.Message, "Erro ao abrir Imprimir")
2146:         ENDTRY
2147:     ENDPROC
2148: 
2149:     *-- Botao 4: Procurar (exibe container cnt_4c_Procurar)
2150:     PROCEDURE BtnProcurarClick()
2151:         THIS.this_lInicio = .T.
2152: 
2153:         THIS.LockScreen = .T.
2154:         THIS.this_lInicio = .F.
2155: 
2156:         THIS.txt_4c_CdContas.Enabled      = .F.
2157:         THIS.txt_4c_DsContas.Enabled      = .F.
2158:         THIS.grd_4c_Dados.Enabled         = .F.
2159:         THIS.txt_4c_TxtFavorecido.Enabled = .F.
2160:         THIS.obj_4c_CmdGok.Enabled        = .F.
2161: 
2162:         IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
2163:             THIS.cnt_4c_Procurar.Enabled = .T.
2164:             THIS.cnt_4c_Procurar.Visible = .T.
2165:             THIS.cnt_4c_Procurar.txt_4c_Banco.SetFocus
2166:         ENDIF
2167: 
2168:         THIS.Refresh
2169:         THIS.LockScreen = .F.
2170:     ENDPROC
2171: 
2172:     *-- Botao 5: Recibo (abre SigRerec)
2173:     PROCEDURE BtnReciboClick()
2174:         LOCAL loc_lCarrega
2175: 
2176:         TRY
2177:             loc_lCarrega = THIS.CarregaConta()
2178:             IF loc_lCarrega
2179:                 DO FORM SigRerec WITH THIS, "RECIBO"
2180:             ENDIF
2181:         CATCH TO loc_oErro
2182:             MsgErro(loc_oErro.Message, "Erro ao abrir Recibo")
2183:         ENDTRY
2184:     ENDPROC
2185: 
2186:     *-- Botao 6: Exclui Doc. (mostra container justificativa para exclusao)
2187:     PROCEDURE BtnExcluiDocClick()
2188:         WITH THIS.cnt_4c_Justificativa
2189:             .Visible = .T.
2190:             .obj_4c_Get_justificativa.Value    = ""
2191:             .obj_4c_Get_justificativa.Width    = 298
2192:             .obj_4c_Get_justificativa.ReadOnly = .F.
2193:             .obj_4c_Get_justificativa.SetFocus
2194:             .obj_4c_CmdGconf.Enabled           = .T.
2195:             .obj_4c_CmdGconf.Visible           = .T.
2196:             .obj_4c_CmdGconf.Buttons(1).Enabled = .T.
2197:         ENDWITH
2198:     ENDPROC
2199: 
2200:     *-- Botao 7: Cheque (impressora jato de tinta)
2201:     PROCEDURE BtnImpchqClick()
2202:         LOCAL loc_nRecno, loc_cSQL, loc_nQueryOk
2203:         LOCAL Array loc_aPrinters(1)
2204:         LOCAL loc_nPrinters, loc_cNomeImp, loc_cNomeImpPath, loc_lEncontrou
2205:         LOCAL loc_cPrnIni, loc_nMaxCol, loc_nLivl, loc_nClvl
2206:         LOCAL loc_nLivExt1, loc_nClvExt1, loc_nLivExt2, loc_nClvExt2
2207:         LOCAL loc_nLiNom, loc_nClNom, loc_nLiCid, loc_nClCid
2208:         LOCAL loc_nLiDia, loc_nClDia, loc_nLiMes, loc_nClMes, loc_nLiAno, loc_nClAno
2209:         LOCAL loc_cPgChq, loc_cStrgMes
2210:         LOCAL loc_cPoint, loc_cSeparator
2211: 
2212:         TRY
2213:             IF !USED("CsSigCqChi") OR !SEEK(1, "CsSigCqChi", "NMarca1s")
2214:                 MsgAviso("Nenhum cheque selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
2215:                 RETURN
2216:             ENDIF
2217: 
2218:             loc_cPoint     = SET("Point")
2219:             loc_cSeparator = SET("Separator")
2220:             loc_cStrgMes   = "Janeiro  FevereiroMar" + CHR(231) + CHR(227) + "o    Abril    " + ;
2221:                              "Maio     Junho    Julho    Agosto   Setembro Outubro  Novembro Dezembro "
2222: 
2223:             *-- Buscar impressoras configuradas para cheque (CrSigCdmp.nchqfs=1)
2224:             IF USED("CrImp1")
2225:                 USE IN CrImp1
2226:             ENDIF
2227: 
2228:             SELECT DISTINCT Impres as cNomeImp1s, SPACE(100) as cNomeImp2s, 0 as nMarca1s ;
2229:               FROM CrSigCdmp ;
2230:              WHERE nchqfs = 1 ;
2231:              ORDER BY Impres ;
2232:               INTO CURSOR CrImp1 READWRITE
2233: 
2234:             IF EOF("CrImp1")
2235:                 MsgAviso("Nenhuma impressora de cheque configurada!", "Aten" + CHR(231) + CHR(227) + "o")
2236:                 USE IN CrImp1
2237:                 RETURN
2238:             ENDIF
2239: 
2240:             *-- Identificar impressoras instaladas no sistema
2241:             loc_nPrinters = APRINTERS(loc_aPrinters)
2242:             SELECT CrImp1
2243:             GO TOP
2244:             SCAN
2245:                 loc_cNomeImp = LOWER(ALLTRIM(CrImp1.cNomeImp1s))
2246:                 loc_lEncontrou = .F.
2247:                 LOCAL loc_n
2248:                 FOR loc_n = 1 TO loc_nPrinters
2249:                     IF LOWER(ALLTRIM(JUSTFNAME(loc_aPrinters(loc_n, 1)))) == loc_cNomeImp
2250:                         loc_cNomeImpPath = ALLTRIM(loc_aPrinters(loc_n, 1))
2251:                         SCATTER MEMVAR
2252:                         m.cNomeImp2s = loc_cNomeImpPath
2253:                         m.nMarca1s   = 1
2254:                         GATHER MEMVAR FIELDS cNomeImp2s, nMarca1s
2255:                         loc_lEncontrou = .T.
2256:                         EXIT
2257:                     ENDIF
2258:                 ENDFOR
2259:             ENDSCAN
2260: 
2261:             IF USED("CrImp2")
2262:                 USE IN CrImp2
2263:             ENDIF
2264:             SELECT DISTINCT cNomeImp1s, cNomeImp2s ;
2265:               FROM CrImp1 ;
2266:              WHERE nMarca1s = 1 ;
2267:              ORDER BY cNomeImp1s ;
2268:               INTO CURSOR CrImp2 READWRITE
2269: 
2270:             USE IN CrImp1
2271: 
2272:             SELECT CrImp2
2273:             INDEX ON cNomeImp2s TAG cNomeImp2s
2274:             GO TOP
2275: 
2276:             IF EOF("CrImp2")
2277:                 MsgAviso("Nenhuma impressora de cheque instalada!", "Aten" + CHR(231) + CHR(227) + "o")
2278:                 USE IN CrImp2
2279:                 RETURN
2280:             ENDIF
2281: 
2282:             *-- Selecionar impressora (se mais de uma disponivel)
2283:             IF RECCOUNT("CrImp2") > 1
2284:                 loc_cNomeImpPath = GETPRINTER()
2285:                 IF EMPTY(loc_cNomeImpPath)
2286:                     USE IN CrImp2
2287:                     RETURN
2288:                 ENDIF
2289:                 SEEK loc_cNomeImpPath IN CrImp2 ORDER cNomeImp2s
2290:                 IF EOF("CrImp2")
2291:                     GO TOP
2292:                 ENDIF
2293:             ENDIF
2294: 
2295:             IF LASTKEY() = 27
2296:                 USE IN CrImp2
2297:                 RETURN
2298:             ENDIF
2299: 
2300:             loc_cNomeImp     = ALLTRIM(CrImp2.cNomeImp1s)
2301:             loc_cNomeImpPath = ALLTRIM(CrImp2.cNomeImp2s)
2302:             USE IN CrImp2
2303: 
2304:             *-- Obter configuracoes da impressora
2305:             IF !SEEK(loc_cNomeImp, "CrSigCdmp", "impres")
2306:                 MsgErro("Configuracao da impressora nao encontrada.", "Erro")
2307:                 RETURN
2308:             ENDIF
2309: 
2310:             loc_cPrnIni   = ALLTRIM(CrSigCdmp.fontes)
2311:             loc_nMaxCol   = CrSigCdmp.maxcols
2312:             loc_nLivl     = CrSigCdmp.nlivl1s
2313:             loc_nClvl     = CrSigCdmp.nclvl1s
2314:             loc_nLivExt1  = CrSigCdmp.nlivext1s
2315:             loc_nClvExt1  = CrSigCdmp.nclvext1s
2316:             loc_nLivExt2  = CrSigCdmp.nlivext2s
2317:             loc_nClvExt2  = CrSigCdmp.nclvext2s

*-- Linhas 2436 a 2532:
2436:     ENDPROC
2437: 
2438:     *-- Botao 8: Chq. Matric. (impressora matricial por faixa ou selecionados)
2439:     PROCEDURE BtnCmdchmatClick()
2440:         LOCAL loc_nRecno, loc_cSQL, loc_nQueryOk
2441: 
2442:         TRY
2443:             IF !USED("CsSigCqChi")
2444:                 RETURN
2445:             ENDIF
2446: 
2447:             SELECT CsSigCqChi
2448:             loc_nRecno = RECNO()
2449: 
2450:             IF USED("TmpChi")
2451:                 USE IN TmpChi
2452:             ENDIF
2453: 
2454:             SELECT DISTINCT bancos ;
2455:               FROM CsSigCqChi ;
2456:              WHERE NMarca1s = 1 ;
2457:               INTO CURSOR TmpChi
2458: 
2459:             SELECT TmpChi
2460:             GO TOP
2461: 
2462:             IF !EOF()
2463:                 IF RECCOUNT("TmpChi") > 1
2464:                     MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", "Aten" + CHR(231) + CHR(227) + "o")
2465:                     SELECT CsSigCqChi
2466:                     GOTO loc_nRecno
2467:                     THIS.grd_4c_Dados.SetFocus
2468:                     RETURN
2469:                 ENDIF
2470: 
2471:                 SELECT bancos, valors, ncheques, datas, NEmitidos, NCancelas, favos ;
2472:                   FROM CsSigCqChi ;
2473:                  WHERE NMarca1s = 1 ;
2474:                  ORDER BY bancos, ncheques ;
2475:                   INTO CURSOR CrCheque
2476: 
2477:                 SELECT CrCheque
2478:                 LOCATE FOR NEmitidos = 1
2479:                 IF FOUND()
2480:                     IF MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
2481:                                    "Confirma impress" + CHR(227) + "o?", ;
2482:                                    "Aten" + CHR(231) + CHR(227) + "o")
2483:                         MsgAviso("Verifique se a impressora est" + CHR(225) + ;
2484:                                  " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
2485:                     ELSE
2486:                         IF USED("CrCheque")
2487:                             USE IN CrCheque
2488:                         ENDIF
2489:                         RETURN
2490:                     ENDIF
2491:                 ELSE
2492:                     MsgAviso("Verifique se a impressora est" + CHR(225) + ;
2493:                              " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
2494:                 ENDIF
2495: 
2496:                 GO TOP
2497: 
2498:                 DO SigIpChq.prg WITH THIS
2499: 
2500:                 PUBLIC xImpOk
2501:                 IF TYPE("xImpOk") = "L" AND xImpOk
2502:                     SELECT CrCheque
2503:                     GO TOP
2504:                     SCAN
2505:                         PRIVATE pBancos2, pNCheques2
2506:                         pBancos2   = CrCheque.bancos
2507:                         pNCheques2 = CrCheque.ncheques
2508:                         loc_cSQL   = "UPDATE SigCqChi SET emitidos = 1" + ;
2509:                                      " WHERE bancos = ?pBancos2 AND ncheques = ?pNCheques2"
2510:                         loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2511:                         IF loc_nQueryOk < 1
2512:                             MsgErro("Falha ao atualizar emissao.", "Erro")
2513:                             RETURN
2514:                         ENDIF
2515:                         UPDATE CsSigCqChi SET NEmitidos = 1 ;
2516:                           WHERE bancos = CrCheque.bancos AND ncheques = CrCheque.ncheques
2517:                         SELECT CrCheque
2518:                     ENDSCAN
2519:                     THIS.this_oBusinessObject.Commit()
2520:                 ENDIF
2521: 
2522:                 IF USED("CrCheque")
2523:                     USE IN CrCheque
2524:                 ENDIF
2525:                 SELECT CsSigCqChi
2526:                 GOTO loc_nRecno
2527:                 THIS.grd_4c_Dados.Refresh
2528:             ELSE
2529:                 *-- Nenhum cheque marcado: abrir painel de faixa matricial
2530:                 THIS.this_lChMatIni = .T.
2531:                 THIS.AtivarImpChmat()
2532:             ENDIF

*-- Linhas 2538 a 3144:
2538:         CATCH TO loc_oErro
2539:             MsgErro(loc_oErro.Message, "Erro em Chq. Matric.")
2540:         ENDTRY
2541:     ENDPROC
2542: 
2543:     *-- Ativa painel cnt_4c_Impchmat (equivalente ao impchmat.Init do legado)
2544:     PROCEDURE AtivarImpChmat()
2545:         IF !THIS.this_lChMatIni
2546:             RETURN
2547:         ENDIF
2548: 
2549:         THIS.LockScreen = .T.
2550:         THIS.this_lChMatIni = .F.
2551: 
2552:         THIS.cnt_4c_Impchmat.txt_4c_Banco.Value = ""
2553:         THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ""
2554:         THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ""
2555: 
2556:         THIS.obj_4c_CmdGok.Enabled        = .F.
2557:         THIS.cnt_4c_Impchmat.Enabled       = .T.
2558:         THIS.cnt_4c_Impchmat.Visible       = .T.
2559:         THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus
2560:         THIS.Refresh
2561:         THIS.LockScreen = .F.
2562:     ENDPROC
2563: 
2564:     *-- Botao 9: Excluir Chq. (exclui cheque cancelado)
2565:     PROCEDURE BtnExcluirChqClick()
2566:         LOCAL loc_cSQL, loc_nQueryOk, loc_cMensa
2567: 
2568:         IF USED("CsSigCqChi") AND !EOF("CsSigCqChi") AND ;
2569:            CsSigCqChi.NCancelas = 1 AND THIS.this_lExcluirCheque
2570:             IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
2571:                            CsSigCqChi.bancos + " / " + CsSigCqChi.agencias + ;
2572:                            " / " + CsSigCqChi.ncontas + " / " + CsSigCqChi.ncheques + " ?", ;
2573:                            "Exclus" + CHR(227) + "o de cheque cancelado")
2574: 
2575:                 PRIVATE pCidChaveDel
2576:                 pCidChaveDel = CsSigCqChi.cidchaves
2577:                 loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
2578:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2579: 
2580:                 IF loc_nQueryOk >= 1
2581:                     THIS.this_oBusinessObject.Commit()
2582:                     SELECT CsSigCqChi
2583:                     DELETE
2584:                     THIS.grd_4c_Dados.Refresh
2585:                 ELSE
2586:                     MsgErro("Falha ao excluir cheque.", "Erro")
2587:                 ENDIF
2588:             ENDIF
2589:         ENDIF
2590:     ENDPROC
2591: 
2592:     *==========================================================================
2593:     *  Handlers dos campos de filtro
2594:     *==========================================================================
2595: 
2596:     *-- CdGrupos: salva valor ao entrar
2597:     PROCEDURE CdGruposGotFocus()
2598:         THIS.this_cAntCdGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2599:     ENDPROC
2600: 
2601:     *-- CdGrupos: valida ao sair (ENTER/TAB)
2602:     PROCEDURE CdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2603:         LOCAL loc_cValor, loc_nQueryOk
2604: 
2605:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
2606:             RETURN
2607:         ENDIF
2608: 
2609:         loc_cValor = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2610: 
2611:         IF !EMPTY(loc_cValor)
2612:             PRIVATE pGrupoVal
2613:             pGrupoVal = loc_cValor
2614:             IF USED("cursor_4c_GrupoValida")
2615:                 USE IN cursor_4c_GrupoValida
2616:             ENDIF
2617:             loc_nQueryOk = SQLEXEC(gnConnHandle, ;
2618:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = ?pGrupoVal", ;
2619:                 "cursor_4c_GrupoValida")
2620:             IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
2621:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
2622:                 USE IN cursor_4c_GrupoValida
2623:             ELSE
2624:                 IF USED("cursor_4c_GrupoValida")
2625:                     USE IN cursor_4c_GrupoValida
2626:                 ENDIF
2627:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
2628:                 THIS.txt_4c_CdGrupos.Value = ""
2629:                 THIS.txt_4c_DsGrupos.Value = ""
2630:             ENDIF
2631:         ELSE
2632:             THIS.txt_4c_DsGrupos.Value = ""
2633:         ENDIF
2634: 
2635:         IF ALLTRIM(THIS.txt_4c_CdGrupos.Value) <> THIS.this_cAntCdGrupo
2636:             IF USED("CsSigCqChi")
2637:                 ZAP IN CsSigCqChi
2638:                 THIS.grd_4c_Dados.Refresh
2639:             ENDIF
2640:         ENDIF
2641:     ENDPROC
2642: 
2643:     *-- DsGrupos: salva valor ao entrar; somente editavel quando CdGrupos estiver vazio
2644:     PROCEDURE DsGruposGotFocus()
2645:         THIS.this_cAntDsGrupo = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2646:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdGrupos.Value))
2647:             THIS.txt_4c_CdGrupos.SetFocus
2648:         ENDIF
2649:     ENDPROC
2650: 
2651:     *-- DsGrupos: valida ao sair por descricao
2652:     PROCEDURE DsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2653:         LOCAL loc_cValor, loc_nQueryOk
2654: 
2655:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
2656:             RETURN
2657:         ENDIF
2658: 
2659:         loc_cValor = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2660: 
2661:         IF !EMPTY(loc_cValor)
2662:             PRIVATE pGrupoDesc
2663:             pGrupoDesc = loc_cValor
2664:             IF USED("cursor_4c_GrupoValida")
2665:                 USE IN cursor_4c_GrupoValida
2666:             ENDIF
2667:             loc_nQueryOk = SQLEXEC(gnConnHandle, ;
2668:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Descrs LIKE ?pGrupoDesc + '%'", ;
2669:                 "cursor_4c_GrupoValida")
2670:             IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
2671:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Codigos)
2672:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
2673:                 USE IN cursor_4c_GrupoValida
2674:             ELSE
2675:                 IF USED("cursor_4c_GrupoValida")
2676:                     USE IN cursor_4c_GrupoValida
2677:                 ENDIF
2678:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
2679:                 THIS.txt_4c_CdGrupos.Value = ""
2680:                 THIS.txt_4c_DsGrupos.Value = ""
2681:             ENDIF
2682:         ELSE
2683:             THIS.txt_4c_CdGrupos.Value = ""
2684:         ENDIF
2685: 
2686:         IF ALLTRIM(THIS.txt_4c_DsGrupos.Value) <> THIS.this_cAntDsGrupo
2687:             IF USED("CsSigCqChi")
2688:                 ZAP IN CsSigCqChi
2689:                 THIS.grd_4c_Dados.Refresh
2690:             ENDIF
2691:         ENDIF
2692:     ENDPROC
2693: 
2694:     *-- CdContas: salva valor ao entrar
2695:     PROCEDURE CdContasGotFocus()
2696:         THIS.this_cAntCdConta = ALLTRIM(THIS.txt_4c_CdContas.Value)
2697:     ENDPROC
2698: 
2699:     *-- CdContas: valida ao sair
2700:     PROCEDURE CdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2701:         LOCAL loc_cValor
2702: 
2703:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
2704:             RETURN
2705:         ENDIF
2706: 
2707:         loc_cValor = ALLTRIM(THIS.txt_4c_CdContas.Value)
2708: 
2709:         IF !EMPTY(loc_cValor)
2710:             IF USED("CrContas") AND SEEK(loc_cValor, "CrContas", "IClis")
2711:                 THIS.txt_4c_DsContas.Value = ALLTRIM(CrContas.RClis)
2712:             ELSE
2713:                 MsgAviso("Conta n" + CHR(227) + "o encontrada!", "")
2714:                 THIS.txt_4c_CdContas.Value = ""
2715:                 THIS.txt_4c_DsContas.Value = ""
2716:             ENDIF
2717:         ELSE
2718:             THIS.txt_4c_DsContas.Value = ""
2719:         ENDIF
2720: 
2721:         IF ALLTRIM(THIS.txt_4c_CdContas.Value) <> THIS.this_cAntCdConta
2722:             IF USED("CsSigCqChi")
2723:                 ZAP IN CsSigCqChi
2724:                 THIS.grd_4c_Dados.Refresh
2725:             ENDIF
2726:         ENDIF
2727:     ENDPROC
2728: 
2729:     *-- DsContas: salva valor ao entrar; somente editavel quando CdContas vazio
2730:     PROCEDURE DsContasGotFocus()
2731:         THIS.this_cAntDsConta = ALLTRIM(THIS.txt_4c_DsContas.Value)
2732:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
2733:             THIS.txt_4c_CdContas.SetFocus
2734:         ENDIF
2735:     ENDPROC
2736: 
2737:     *-- DsContas: valida ao sair por nome da conta
2738:     PROCEDURE DsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2739:         LOCAL loc_cValor
2740: 
2741:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
2742:             RETURN
2743:         ENDIF
2744: 
2745:         loc_cValor = ALLTRIM(THIS.txt_4c_DsContas.Value)
2746: 
2747:         IF !EMPTY(loc_cValor)
2748:             IF USED("CrContas") AND SEEK(loc_cValor, "CrContas", "RClis")
2749:                 THIS.txt_4c_CdContas.Value = ALLTRIM(CrContas.IClis)
2750:                 THIS.txt_4c_DsContas.Value = ALLTRIM(CrContas.RClis)
2751:             ELSE
2752:                 MsgAviso("Conta n" + CHR(227) + "o encontrada!", "")
2753:                 THIS.txt_4c_CdContas.Value = ""
2754:                 THIS.txt_4c_DsContas.Value = ""
2755:             ENDIF
2756:         ELSE
2757:             THIS.txt_4c_CdContas.Value = ""
2758:         ENDIF
2759: 
2760:         IF ALLTRIM(THIS.txt_4c_DsContas.Value) <> THIS.this_cAntDsConta
2761:             IF USED("CsSigCqChi")
2762:                 ZAP IN CsSigCqChi
2763:                 THIS.grd_4c_Dados.Refresh
2764:             ENDIF
2765:         ENDIF
2766:     ENDPROC
2767: 
2768:     *-- DtInicial: salva data ao entrar
2769:     PROCEDURE DtInicialGotFocus()
2770:         THIS.this_dAntDtIni = THIS.txt_4c_Dt_inicial.Value
2771:     ENDPROC
2772: 
2773:     *-- DtInicial: valida ao sair
2774:     PROCEDURE DtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2775:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2776:             RETURN
2777:         ENDIF
2778:         IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
2779:             THIS.txt_4c_Dt_final.Value = THIS.txt_4c_Dt_inicial.Value
2780:         ENDIF
2781:         IF THIS.txt_4c_Dt_inicial.Value <> THIS.this_dAntDtIni
2782:             IF USED("CsSigCqChi")
2783:                 ZAP IN CsSigCqChi
2784:                 THIS.grd_4c_Dados.Refresh
2785:             ENDIF
2786:         ENDIF
2787:     ENDPROC
2788: 
2789:     *-- DtFinal: salva data ao entrar
2790:     PROCEDURE DtFinalGotFocus()
2791:         THIS.this_dAntDtFin = THIS.txt_4c_Dt_final.Value
2792:     ENDPROC
2793: 
2794:     *-- DtFinal: valida ao sair
2795:     PROCEDURE DtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2796:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2797:             RETURN
2798:         ENDIF
2799:         IF THIS.txt_4c_Dt_final.Value < THIS.txt_4c_Dt_inicial.Value
2800:             THIS.txt_4c_Dt_inicial.Value = THIS.txt_4c_Dt_final.Value
2801:         ENDIF
2802:         IF THIS.txt_4c_Dt_final.Value <> THIS.this_dAntDtFin
2803:             IF USED("CsSigCqChi")
2804:                 ZAP IN CsSigCqChi
2805:                 THIS.grd_4c_Dados.Refresh
2806:             ENDIF
2807:         ENDIF
2808:     ENDPROC
2809: 
2810:     *-- Botao Desmarcar Todos
2811:     PROCEDURE CmdApaga1Click()
2812:         LOCAL loc_nRecno
2813: 
2814:         IF !USED("CsSigCqChi")
2815:             RETURN
2816:         ENDIF
2817:         loc_nRecno = RECNO("CsSigCqChi")
2818:         UPDATE CsSigCqChi SET NMarca1s = 0 WHERE NMarca1s = 1
2819:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2820:             GOTO loc_nRecno IN CsSigCqChi
2821:         ENDIF
2822:         THIS.grd_4c_Dados.Refresh
2823:     ENDPROC
2824: 
2825:     *-- Botao Marcar Todos
2826:     PROCEDURE CmdTudo1Click()
2827:         LOCAL loc_nRecno
2828: 
2829:         IF !USED("CsSigCqChi")
2830:             RETURN
2831:         ENDIF
2832:         loc_nRecno = RECNO("CsSigCqChi")
2833:         UPDATE CsSigCqChi SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
2834:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2835:             GOTO loc_nRecno IN CsSigCqChi
2836:         ENDIF
2837:         THIS.grd_4c_Dados.Refresh
2838:     ENDPROC
2839: 
2840:     *-- Botao Processar
2841:     PROCEDURE Command2Click()
2842:         IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
2843:             MsgAviso("Data Final menor que Data Inicial !!!", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
2844:             THIS.txt_4c_Dt_inicial.SetFocus
2845:             RETURN
2846:         ENDIF
2847: 
2848:         IF THIS.this_dAntDtIni <> THIS.txt_4c_Dt_inicial.Value OR ;
2849:            THIS.this_dAntDtFin <> THIS.txt_4c_Dt_final.Value OR ;
2850:            THIS.this_cAntCdGrupo <> ALLTRIM(THIS.txt_4c_CdGrupos.Value) OR ;
2851:            THIS.this_cAntCdConta <> ALLTRIM(THIS.txt_4c_CdContas.Value)
2852: 
2853:             IF !THIS.MontaChq(.F.)
2854:                 MsgErro("Falha ao processar cheques.", "Erro")
2855:                 RETURN
2856:             ENDIF
2857: 
2858:             THIS.this_dAntDtIni    = THIS.txt_4c_Dt_inicial.Value
2859:             THIS.this_dAntDtFin    = THIS.txt_4c_Dt_final.Value
2860:             THIS.this_cAntCdGrupo  = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2861:             THIS.this_cAntCdConta  = ALLTRIM(THIS.txt_4c_CdContas.Value)
2862:         ENDIF
2863: 
2864:         THIS.grd_4c_Dados.Column2.SetFocus
2865:     ENDPROC
2866: 
2867:     *==========================================================================
2868:     *  Handlers do container cnt_4c_Justificativa
2869:     *==========================================================================
2870:     PROCEDURE CmdGconfClick()
2871:         LOCAL loc_nRecno
2872: 
2873:         DO CASE
2874:         CASE THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Value = 1  && Confirmar
2875: 
2876:             IF EMPTY(ALLTRIM(THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.Value))
2877:                 MsgAviso("Justificativa em branco!", "Aten" + CHR(231) + CHR(227) + "o")
2878:                 THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.SetFocus
2879:                 RETURN
2880:             ENDIF
2881: 
2882:             THIS.LockScreen = .T.
2883: 
2884:             TRY
2885:                 IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
2886:                     loc_nRecno = RECNO("CsSigCqChi")
2887:                     THIS.Enabled = .F.
2888:                     DO FORM SigCdPgr WITH LEFT(CsSigCqChi.dopes, 1), .F., ;
2889:                         CsSigCqChi.emps, CsSigCqChi.dopes, CsSigCqChi.numes, .T., THIS, ;
2890:                         ALLTRIM(THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.Value)
2891:                     SigCdPgr.AlwaysOnTop = .T.
2892:                 ELSE
2893:                     THIS.MExibeCheques(.T.)
2894:                 ENDIF
2895:             CATCH TO loc_oErro
2896:                 THIS.Enabled = .T.
2897:                 MsgErro(loc_oErro.Message, "Erro ao confirmar cancelamento")
2898:             ENDTRY
2899: 
2900:             THIS.LockScreen = .F.
2901: 
2902:         CASE THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Value = 2  && Cancelar
2903:             THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Enabled = .F.
2904:             THIS.cnt_4c_Justificativa.Visible = .F.
2905:         ENDCASE
2906:     ENDPROC
2907: 
2908:     *==========================================================================
2909:     *  Handlers do container cnt_4c_Impchmat (impressao matricial por faixa)
2910:     *==========================================================================
2911:     PROCEDURE ImpchmatBancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2912:         *-- Leitor CMC-7: inicia captura em < (60) e finaliza em : (58)
2913:         IF par_nKeyCode = 60
2914:             IF !THIS.this_lLeCheque
2915:                 THIS.this_cChqLido = ""
2916:             ENDIF
2917:             THIS.this_lLeCheque = .T.
2918:         ENDIF
2919:         IF THIS.this_lLeCheque
2920:             THIS.this_cChqLido = THIS.this_cChqLido + CHR(par_nKeyCode)
2921:         ENDIF
2922:         IF par_nKeyCode = 58
2923:             THIS.this_lLeCheque = .F.
2924:         ENDIF
2925:     ENDPROC
2926: 
2927:     PROCEDURE ImpchmatChiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2928:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
2929:             THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ;
2930:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
2931:         ENDIF
2932:     ENDPROC
2933: 
2934:     PROCEDURE ImpchmatChfinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2935:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
2936:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ;
2937:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
2938:         ENDIF
2939:     ENDPROC
2940: 
2941:     PROCEDURE ImpchmatCmdGprocurarClick()
2942:         DO CASE
2943:         CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 1  && Imprimir
2944:             THIS.ImpchmatImprimirClick()
2945:         CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 2  && Encerrar
2946:             THIS.ImpchmatEncerrarClick()
2947:         ENDCASE
2948:     ENDPROC
2949: 
2950:     PROCEDURE ImpchmatImprimirClick()
2951:         LOCAL loc_cBanco, loc_cChIni, loc_cChFin
2952: 
2953:         loc_cBanco = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Banco.Value)
2954:         loc_cChIni = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
2955:         loc_cChFin = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)
2956: 
2957:         IF EMPTY(loc_cBanco)
2958:             MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2959:             THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus
2960:             RETURN
2961:         ENDIF
2962:         IF EMPTY(loc_cChIni)
2963:             MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", ;
2964:                      "Aten" + CHR(231) + CHR(227) + "o")
2965:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus
2966:             RETURN
2967:         ENDIF
2968:         IF EMPTY(loc_cChFin)
2969:             MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", ;
2970:                      "Aten" + CHR(231) + CHR(227) + "o")
2971:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus
2972:             RETURN
2973:         ENDIF
2974:         IF loc_cChFin < loc_cChIni
2975:             MsgAviso("N" + CHR(250) + "mero do cheque final menor que o inicial !!!", ;
2976:                      "Aten" + CHR(231) + CHR(227) + "o")
2977:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus
2978:             RETURN
2979:         ENDIF
2980: 
2981:         TRY
2982:             IF USED("CrCheque")
2983:                 USE IN CrCheque
2984:             ENDIF
2985: 
2986:             PRIVATE pBancoFil, pChIniFil, pChFinFil
2987:             pBancoFil = loc_cBanco
2988:             pChIniFil = loc_cChIni
2989:             pChFinFil = loc_cChFin
2990: 
2991:             SELECT bancos, valors, ncheques, datas, favos, NEmitidos ;
2992:               FROM CsSigCqChi ;
2993:              WHERE bancos = ?pBancoFil ;
2994:                AND ncheques BETWEEN ?pChIniFil AND ?pChFinFil ;
2995:                AND NCancelas = 0 ;
2996:              ORDER BY bancos, ncheques ;
2997:               INTO CURSOR CrCheque
2998: 
2999:             SELECT CrCheque
3000:             LOCATE FOR NEmitidos = 1
3001:             IF FOUND()
3002:                 IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
3003:                                 "Confirma impress" + CHR(227) + "o?", ;
3004:                                 "Aten" + CHR(231) + CHR(227) + "o")
3005:                     USE IN CrCheque
3006:                     RETURN
3007:                 ENDIF
3008:             ENDIF
3009: 
3010:             GO TOP
3011:             MsgAviso("Verificar se a impressora est" + CHR(225) + ;
3012:                      " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
3013: 
3014:             DO SigIpChq.prg
3015: 
3016:             PUBLIC xImpOk
3017:             IF TYPE("xImpOk") = "L" AND xImpOk
3018:                 LOCAL loc_cSQL, loc_nQueryOk
3019:                 SELECT CrCheque
3020:                 SCAN
3021:                     PRIVATE pBancoUpd, pNChequeUpd
3022:                     pBancoUpd   = CrCheque.bancos
3023:                     pNChequeUpd = CrCheque.ncheques
3024:                     loc_cSQL = "UPDATE SigCqChi SET emitidos = 1" + ;
3025:                                " WHERE bancos = ?pBancoUpd AND ncheques = ?pNChequeUpd"
3026:                     loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
3027:                     IF loc_nQueryOk < 1
3028:                         MsgErro("Falha ao atualizar emissao.", "Erro")
3029:                         EXIT
3030:                     ENDIF
3031:                     SELECT CrCheque
3032:                 ENDSCAN
3033:             ENDIF
3034: 
3035:             IF USED("CrCheque")
3036:                 USE IN CrCheque
3037:             ENDIF
3038: 
3039:         CATCH TO loc_oErro
3040:             MsgErro(loc_oErro.Message, "Erro na impressao matricial")
3041:         ENDTRY
3042:     ENDPROC
3043: 
3044:     PROCEDURE ImpchmatEncerrarClick()
3045:         THIS.LockScreen = .T.
3046:         THIS.obj_4c_CmdGok.Enabled   = .T.
3047:         THIS.cnt_4c_Impchmat.Enabled  = .F.
3048:         THIS.cnt_4c_Impchmat.Visible  = .F.
3049:         THIS.MExibeCheques(.F.)
3050:         THIS.LockScreen = .F.
3051:     ENDPROC
3052: 
3053:     *==========================================================================
3054:     *  Handlers do container cnt_4c_Procurar (busca por criterios)
3055:     *==========================================================================
3056:     PROCEDURE ProcurarBancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3057:         *-- Leitor CMC-7: inicia em < (60), encerra em : (58)
3058:         IF par_nKeyCode = 60
3059:             IF !THIS.this_lLeCheque
3060:                 THIS.this_cChqLido = ""
3061:             ENDIF
3062:             THIS.this_lLeCheque = .T.
3063:         ENDIF
3064:         IF THIS.this_lLeCheque
3065:             THIS.this_cChqLido = THIS.this_cChqLido + CHR(par_nKeyCode)
3066:         ENDIF
3067:         IF par_nKeyCode = 58
3068:             THIS.this_lLeCheque = .F.
3069:             *-- Processar leitura CMC-7 se codigo completo (>= 33 chars)
3070:             IF LEN(THIS.this_cChqLido) >= 33
3071:                 THIS.cnt_4c_Procurar.txt_4c_Banco.Value   = SUBSTR(THIS.this_cChqLido, 2, 3)
3072:                 THIS.cnt_4c_Procurar.txt_4c_Agencia.Value = SUBSTR(THIS.this_cChqLido, 5, 4)
3073:                 THIS.cnt_4c_Procurar.txt_4c_Conta.Value   = SUBSTR(THIS.this_cChqLido, 23, 10)
3074:                 THIS.cnt_4c_Procurar.txt_4c_Cheque.Value  = SUBSTR(THIS.this_cChqLido, 14, 6)
3075:                 THIS.Refresh
3076:                 THIS.ProcurarPesquisarClick()
3077:             ENDIF
3078:         ENDIF
3079:     ENDPROC
3080: 
3081:     PROCEDURE ProcurarEmissaoGotFocus()
3082:         *-- Mutualmente exclusivo com Valor: somente editavel se Valor vazio
3083:         IF !EMPTY(TRANSFORM(THIS.cnt_4c_Procurar.txt_4c_Valor.Value))
3084:             THIS.cnt_4c_Procurar.txt_4c_Valor.SetFocus
3085:         ENDIF
3086:     ENDPROC
3087: 
3088:     PROCEDURE ProcurarValorGotFocus()
3089:         *-- Mutualmente exclusivo com Emissao: somente editavel se Emissao vazia
3090:         IF !EMPTY(THIS.cnt_4c_Procurar.txt_4c_Emissao.Value)
3091:             THIS.cnt_4c_Procurar.txt_4c_Emissao.SetFocus
3092:         ENDIF
3093:     ENDPROC
3094: 
3095:     PROCEDURE ProcurarCmdgprocurarClick()
3096:         DO CASE
3097:         CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 1  && Pesquisar
3098:             THIS.ProcurarPesquisarClick()
3099:         CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 2  && Cancelar/Encerrar
3100:             THIS.ProcurarCancelarClick()
3101:         ENDCASE
3102:     ENDPROC
3103: 
3104:     PROCEDURE ProcurarPesquisarClick()
3105:         LOCAL loc_cBanco, loc_cAgencia, loc_cConta, loc_cCheque
3106:         LOCAL loc_dEmissao, loc_nValor
3107: 
3108:         loc_cBanco   = PADR(ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Banco.Value), 3)
3109:         loc_cAgencia = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Agencia.Value)
3110:         loc_cConta   = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Conta.Value)
3111:         loc_cCheque  = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Cheque.Value)
3112:         loc_dEmissao = THIS.cnt_4c_Procurar.txt_4c_Emissao.Value
3113:         loc_nValor   = THIS.cnt_4c_Procurar.txt_4c_Valor.Value
3114: 
3115:         SET NEAR ON
3116:         SELECT CsSigCqChi
3117: 
3118:         DO CASE
3119:         CASE !EMPTY(loc_dEmissao) AND VARTYPE(loc_dEmissao) = "D"
3120:             SET ORDER TO Emissao
3121:             SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3122:         CASE loc_nValor <> 0
3123:             SET ORDER TO Valor
3124:             SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3125:         CASE !EMPTY(loc_cBanco)
3126:             SET ORDER TO Cheque
3127:             SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3128:         CASE !EMPTY(loc_cAgencia)
3129:             SET ORDER TO Agencia
3130:             SEEK loc_cAgencia + loc_cConta + loc_cCheque
3131:         CASE !EMPTY(loc_cConta)
3132:             SET ORDER TO Conta
3133:             SEEK loc_cConta + loc_cCheque
3134:         CASE !EMPTY(loc_cCheque)
3135:             SET ORDER TO NCheques
3136:             SEEK loc_cCheque
3137:         ENDCASE
3138: 
3139:         SET NEAR OFF
3140: 
3141:         THIS.LockScreen = .T.
3142:         THIS.txt_4c_CdContas.Enabled      = .T.
3143:         THIS.txt_4c_DsContas.Enabled      = .T.
3144:         THIS.grd_4c_Dados.Enabled         = .T.

*-- Linhas 3150 a 3408:
3150:         THIS.LockScreen = .F.
3151:     ENDPROC
3152: 
3153:     PROCEDURE ProcurarCancelarClick()
3154:         THIS.LockScreen = .T.
3155:         THIS.txt_4c_CdContas.Enabled      = .T.
3156:         THIS.txt_4c_DsContas.Enabled      = .T.
3157:         THIS.grd_4c_Dados.Enabled         = .T.
3158:         THIS.txt_4c_TxtFavorecido.Enabled = .T.
3159:         THIS.obj_4c_CmdGok.Enabled        = .T.
3160:         THIS.cnt_4c_Procurar.Enabled      = .F.
3161:         THIS.cnt_4c_Procurar.Visible      = .F.
3162:         THIS.MExibeCheques(.F.)
3163:         THIS.LockScreen = .F.
3164:     ENDPROC
3165: 
3166:     *==========================================================================
3167:     *  Eventos principais dos botoes (mapeamento operacional CRUD)
3168:     *  FormSigPrChr eh OPERACIONAL (processamento de cheques recebidos):
3169:     *   - Incluir     -> ativar container Impchmat (entrada manual de faixa
3170:     *                    de cheques por banco + cheque inicial/final)
3171:     *   - Alterar     -> abrir SigCdPgr para edicao do documento associado
3172:     *   - Visualizar  -> abrir SigReEch (visualizacao/impressao do cheque)
3173:     *   - Excluir     -> excluir cheque cancelado selecionado no grid
3174:     *==========================================================================
3175: 
3176:     *-- Incluir: ativa container de entrada manual (impchmat) para faixa de cheques
3177:     PROCEDURE BtnIncluirClick()
3178:         TRY
3179:             IF EMPTY(THIS.txt_4c_CdContas.Value)
3180:                 MsgAviso("Selecione uma conta antes de incluir cheques.", ;
3181:                          "Aten" + CHR(231) + CHR(227) + "o")
3182:                 THIS.txt_4c_CdContas.SetFocus
3183:                 RETURN
3184:             ENDIF
3185:             THIS.this_lChMatIni = .T.
3186:             THIS.AtivarImpChmat()
3187:         CATCH TO loc_oErro
3188:             MsgErro(loc_oErro.Message, "Erro em Incluir")
3189:         ENDTRY
3190:     ENDPROC
3191: 
3192:     *-- Alterar: abre SigCdPgr do documento vinculado ao cheque corrente
3193:     PROCEDURE BtnAlterarClick()
3194:         LOCAL loc_nRecno, loc_cEDNs, loc_lTemQuery
3195: 
3196:         TRY
3197:             IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
3198:                 MsgAviso("Nenhum cheque selecionado para alterar.", ;
3199:                          "Aten" + CHR(231) + CHR(227) + "o")
3200:                 RETURN
3201:             ENDIF
3202: 
3203:             IF CsSigCqChi.NCancelas <> 0
3204:                 MsgAviso("Cheque cancelado nao pode ser alterado.", ;
3205:                          "Aten" + CHR(231) + CHR(227) + "o")
3206:                 RETURN
3207:             ENDIF
3208: 
3209:             THIS.LockScreen = .T.
3210:             loc_nRecno = RECNO("CsSigCqChi")
3211:             loc_cEDNs  = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)
3212: 
3213:             loc_lTemQuery = .F.
3214:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
3215:                PEMSTATUS(THIS.this_oBusinessObject, "CursorQuery", 5)
3216:                 loc_lTemQuery = THIS.this_oBusinessObject.CursorQuery("SigCdPgr", "", "empdopnums", loc_cEDNs)
3217:             ELSE
3218:                 loc_lTemQuery = .T.
3219:             ENDIF
3220: 
3221:             IF loc_lTemQuery
3222:                 DO FORM SigCdPgr WITH LEFT(CsSigCqChi.dopes, 1), .T., ;
3223:                     CsSigCqChi.emps, CsSigCqChi.dopes, CsSigCqChi.numes
3224:                 IF TYPE("SigCdPgr") = "O"
3225:                     SigCdPgr.AlwaysOnTop = .T.
3226:                 ENDIF
3227:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
3228:                     GOTO loc_nRecno IN CsSigCqChi
3229:                 ENDIF
3230:                 THIS.MExibeCheques(.F.)
3231:             ELSE
3232:                 MsgAviso("Documento associado ao cheque nao encontrado.", ;
3233:                          "Aten" + CHR(231) + CHR(227) + "o")
3234:             ENDIF
3235: 
3236:             THIS.LockScreen = .F.
3237:         CATCH TO loc_oErro
3238:             THIS.LockScreen = .F.
3239:             MsgErro(loc_oErro.Message, "Erro em Alterar")
3240:         ENDTRY
3241:     ENDPROC
3242: 
3243:     *-- Visualizar: abre SigReEch em modo CONSULTAR (visualizacao do cheque)
3244:     PROCEDURE BtnVisualizarClick()
3245:         LOCAL loc_lCarrega
3246: 
3247:         TRY
3248:             IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
3249:                 MsgAviso("Nenhum cheque selecionado para visualizar.", ;
3250:                          "Aten" + CHR(231) + CHR(227) + "o")
3251:                 RETURN
3252:             ENDIF
3253: 
3254:             loc_lCarrega = THIS.CarregaConta()
3255:             IF loc_lCarrega
3256:                 DO FORM SigReEch WITH CsSigCqChi.emps, CsSigCqChi.dopes, ;
3257:                     CsSigCqChi.numes, "CONSULTAR", CsSigCqChi.ncheques
3258:             ENDIF
3259:         CATCH TO loc_oErro
3260:             MsgErro(loc_oErro.Message, "Erro em Visualizar")
3261:         ENDTRY
3262:     ENDPROC
3263: 
3264:     *-- Excluir: exclui cheque cancelado selecionado
3265:     PROCEDURE BtnExcluirClick()
3266:         LOCAL loc_cSQL, loc_nQueryOk, loc_cMensa
3267: 
3268:         TRY
3269:             IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
3270:                 MsgAviso("Nenhum cheque selecionado para excluir.", ;
3271:                          "Aten" + CHR(231) + CHR(227) + "o")
3272:                 RETURN
3273:             ENDIF
3274: 
3275:             IF CsSigCqChi.NCancelas <> 1
3276:                 MsgAviso("Apenas cheques cancelados podem ser exclu" + CHR(237) + "dos.", ;
3277:                          "Aten" + CHR(231) + CHR(227) + "o")
3278:                 RETURN
3279:             ENDIF
3280: 
3281:             IF !THIS.this_lExcluirCheque
3282:                 MsgAviso("Acesso negado para exclus" + CHR(227) + "o de cheques.", ;
3283:                          "Acesso Negado")
3284:                 RETURN
3285:             ENDIF
3286: 
3287:             IF MsgConfirma("Deseja realmente excluir o cheque:" + CHR(13) + ;
3288:                            CsSigCqChi.bancos + " / " + CsSigCqChi.agencias + ;
3289:                            " / " + CsSigCqChi.ncontas + " / " + CsSigCqChi.ncheques + " ?", ;
3290:                            "Exclus" + CHR(227) + "o de cheque cancelado")
3291: 
3292:                 PRIVATE pCidChaveDel
3293:                 pCidChaveDel = CsSigCqChi.cidchaves
3294:                 loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
3295:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
3296: 
3297:                 IF loc_nQueryOk >= 1
3298:                     THIS.this_oBusinessObject.Commit()
3299:                     loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado: " + ;
3300:                                  CsSigCqChi.bancos + "/" + CsSigCqChi.agencias + ;
3301:                                  "/" + CsSigCqChi.ncontas + "/" + CsSigCqChi.ncheques
3302:                     SELECT CsSigCqChi
3303:                     DELETE
3304:                     THIS.grd_4c_Dados.Refresh
3305:                     MsgInfo("Cheque exclu" + CHR(237) + "do com sucesso.", ;
3306:                             "Exclus" + CHR(227) + "o")
3307:                 ELSE
3308:                     MsgErro("Falha ao excluir cheque.", "Erro")
3309:                 ENDIF
3310:             ENDIF
3311:         CATCH TO loc_oErro
3312:             MsgErro(loc_oErro.Message, "Erro em Excluir")
3313:         ENDTRY
3314:     ENDPROC
3315: 
3316:     *==========================================================================
3317:     *  FASE 8/8 - Metodos auxiliares e consolidacao final
3318:     *==========================================================================
3319: 
3320:     *--------------------------------------------------------------------------
3321:     PROCEDURE CarregarLista()
3322:     *  Carrega/atualiza o grid de cheques conforme filtros ativos.
3323:     *--------------------------------------------------------------------------
3324:         THIS.MontaChq(.F.)
3325:     ENDPROC
3326: 
3327:     *--------------------------------------------------------------------------
3328:     PROCEDURE BtnBuscarClick()
3329:     *  Alias do botao Processar: recarrega os cheques conforme filtros atuais.
3330:     *--------------------------------------------------------------------------
3331:         THIS.Command2Click()
3332:     ENDPROC
3333: 
3334:     *--------------------------------------------------------------------------
3335:     PROCEDURE BtnSalvarClick()
3336:     *  Form OPERACIONAL: nao ha CRUD de tabela unica. Confirma transacoes
3337:     *  em aberto e atualiza o grid para refletir o estado atual do cursor.
3338:     *--------------------------------------------------------------------------
3339:         TRY
3340:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3341:                 THIS.this_oBusinessObject.CommitTransacao()
3342:             ENDIF
3343:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3344:                 THIS.grd_4c_Dados.Refresh
3345:             ENDIF
3346:         CATCH TO loc_oErro
3347:             MsgErro(loc_oErro.Message, "Erro ao salvar")
3348:         ENDTRY
3349:     ENDPROC
3350: 
3351:     *--------------------------------------------------------------------------
3352:     PROCEDURE BtnCancelarClick()
3353:     *  Cancela operacao corrente: fecha containers flutuantes e volta a vista principal.
3354:     *--------------------------------------------------------------------------
3355:         IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
3356:             THIS.ProcurarCancelarClick()
3357:         ENDIF
3358:         IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
3359:             THIS.ImpchmatEncerrarClick()
3360:         ENDIF
3361:         IF PEMSTATUS(THIS, "cnt_4c_Justificativa", 5) AND THIS.cnt_4c_Justificativa.Visible
3362:             THIS.cnt_4c_Justificativa.obj_4c_CmdGconf.Enabled = .F.
3363:             THIS.cnt_4c_Justificativa.Visible = .F.
3364:         ENDIF
3365:     ENDPROC
3366: 
3367:     *--------------------------------------------------------------------------
3368:     PROCEDURE FormParaBO()
3369:     *  Transfere filtros ativos do form para as propriedades do BO.
3370:     *--------------------------------------------------------------------------
3371:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
3372:             RETURN
3373:         ENDIF
3374: 
3375:         WITH THIS.this_oBusinessObject
3376:             .this_dDtInicial  = THIS.txt_4c_Dt_inicial.Value
3377:             .this_dDtFinal    = THIS.txt_4c_Dt_final.Value
3378:             .this_cCdGrupo    = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
3379:             .this_cDsGrupo    = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
3380:             .this_cCdConta    = ALLTRIM(THIS.txt_4c_CdContas.Value)
3381:             .this_cDsConta    = ALLTRIM(THIS.txt_4c_DsContas.Value)
3382: 
3383:             *-- Painel Impchmat
3384:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
3385:                 .this_cBancoMat = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Banco.Value)
3386:                 .this_cChIniMat = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
3387:                 .this_cChFinMat = ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)
3388:             ENDIF
3389: 
3390:             *-- Painel Procurar
3391:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
3392:                 .this_cBancoPrc   = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Banco.Value)
3393:                 .this_cAgenciaPrc = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Agencia.Value)
3394:                 .this_cContaPrc   = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Conta.Value)
3395:                 .this_cChequePrc  = ALLTRIM(THIS.cnt_4c_Procurar.txt_4c_Cheque.Value)
3396:                 .this_dEmissaoPrc = THIS.cnt_4c_Procurar.txt_4c_Emissao.Value
3397:                 .this_nValorPrc   = THIS.cnt_4c_Procurar.txt_4c_Valor.Value
3398:             ENDIF
3399: 
3400:             *-- Cheque selecionado no grid
3401:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
3402:                 .this_cEmps       = NVL(CsSigCqChi.emps, "")
3403:                 .this_cDopes      = NVL(CsSigCqChi.dopes, "")
3404:                 .this_cNumes      = NVL(STR(CsSigCqChi.numes, 6), "")
3405:                 .this_dDatas      = NVL(CsSigCqChi.datas, {})
3406:                 .this_cBancos     = NVL(CsSigCqChi.bancos, "")
3407:                 .this_cAgencias   = NVL(CsSigCqChi.agencias, "")
3408:                 .this_cNcontas    = NVL(CsSigCqChi.ncontas, "")

*-- Linhas 3424 a 3527:
3424:     ENDPROC
3425: 
3426:     *--------------------------------------------------------------------------
3427:     PROCEDURE BOParaForm()
3428:     *  Transfere propriedades do BO para os controles do form.
3429:     *--------------------------------------------------------------------------
3430:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
3431:             RETURN
3432:         ENDIF
3433: 
3434:         WITH THIS.this_oBusinessObject
3435:             THIS.txt_4c_Dt_inicial.Value   = IIF(EMPTY(.this_dDtInicial), DATE(), .this_dDtInicial)
3436:             THIS.txt_4c_Dt_final.Value     = IIF(EMPTY(.this_dDtFinal), DATE(), .this_dDtFinal)
3437:             THIS.txt_4c_CdGrupos.Value     = .this_cCdGrupo
3438:             THIS.txt_4c_DsGrupos.Value     = .this_cDsGrupo
3439:             THIS.txt_4c_CdContas.Value     = .this_cCdConta
3440:             THIS.txt_4c_DsContas.Value     = .this_cDsConta
3441: 
3442:             IF !EMPTY(.this_cFavos)
3443:                 THIS.txt_4c_TxtFavorecido.Value = .this_cFavos
3444:             ENDIF
3445: 
3446:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
3447:                 THIS.cnt_4c_Impchmat.txt_4c_Banco.Value = .this_cBancoMat
3448:                 THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = .this_cChIniMat
3449:                 THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = .this_cChFinMat
3450:             ENDIF
3451: 
3452:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
3453:                 THIS.cnt_4c_Procurar.txt_4c_Banco.Value   = .this_cBancoPrc
3454:                 THIS.cnt_4c_Procurar.txt_4c_Agencia.Value = .this_cAgenciaPrc
3455:                 THIS.cnt_4c_Procurar.txt_4c_Conta.Value   = .this_cContaPrc
3456:                 THIS.cnt_4c_Procurar.txt_4c_Cheque.Value  = .this_cChequePrc
3457:                 THIS.cnt_4c_Procurar.txt_4c_Emissao.Value = IIF(EMPTY(.this_dEmissaoPrc), {}, .this_dEmissaoPrc)
3458:                 THIS.cnt_4c_Procurar.txt_4c_Valor.Value   = .this_nValorPrc
3459:             ENDIF
3460:         ENDWITH
3461:     ENDPROC
3462: 
3463:     *--------------------------------------------------------------------------
3464:     PROCEDURE HabilitarCampos(par_lHabilitar)
3465:     *  Habilita ou desabilita os controles de filtro e o grid.
3466:     *--------------------------------------------------------------------------
3467:         LOCAL loc_lHab
3468: 
3469:         IF TYPE("par_lHabilitar") = "L"
3470:             loc_lHab = par_lHabilitar
3471:         ELSE
3472:             loc_lHab = .T.
3473:         ENDIF
3474: 
3475:         THIS.txt_4c_CdGrupos.Enabled       = loc_lHab
3476:         THIS.txt_4c_DsGrupos.Enabled       = loc_lHab
3477:         THIS.txt_4c_CdContas.Enabled       = loc_lHab
3478:         THIS.txt_4c_DsContas.Enabled       = loc_lHab
3479:         THIS.txt_4c_Dt_inicial.Enabled     = loc_lHab
3480:         THIS.txt_4c_Dt_final.Enabled       = loc_lHab
3481:         THIS.cmd_4c_Command2.Enabled       = loc_lHab
3482:         THIS.grd_4c_Dados.Enabled          = loc_lHab
3483:         THIS.txt_4c_TxtFavorecido.Enabled  = loc_lHab
3484:         THIS.obj_4c_CmdGok.Enabled         = loc_lHab
3485: 
3486:         IF loc_lHab
3487:             THIS.cmd_4c_Tudo1.Visible  = .T.
3488:             THIS.cmd_4c_Apaga1.Visible = .T.
3489:         ENDIF
3490:     ENDPROC
3491: 
3492:     *--------------------------------------------------------------------------
3493:     PROCEDURE LimparCampos()
3494:     *  Limpa os filtros e reseta o grid para estado inicial.
3495:     *--------------------------------------------------------------------------
3496:         THIS.txt_4c_CdGrupos.Value      = ""
3497:         THIS.txt_4c_DsGrupos.Value      = ""
3498:         THIS.txt_4c_CdContas.Value      = ""
3499:         THIS.txt_4c_DsContas.Value      = ""
3500:         THIS.txt_4c_Dt_inicial.Value    = DATE()
3501:         THIS.txt_4c_Dt_final.Value      = DATE()
3502:         THIS.txt_4c_TxtFavorecido.Value = ""
3503: 
3504:         THIS.this_cAntCdGrupo = ""
3505:         THIS.this_cAntDsGrupo = ""
3506:         THIS.this_cAntCdConta = ""
3507:         THIS.this_cAntDsConta = ""
3508:         THIS.this_dAntDtIni   = {}
3509:         THIS.this_dAntDtFin   = {}
3510: 
3511:         IF USED("CsSigCqChi")
3512:             ZAP IN CsSigCqChi
3513:         ENDIF
3514: 
3515:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3516:             THIS.grd_4c_Dados.Refresh
3517:         ENDIF
3518:     ENDPROC
3519: 
3520:     *--------------------------------------------------------------------------
3521:     PROCEDURE AjustarBotoesPorModo()
3522:     *  Ajusta os botoes do CommandGroup conforme o cheque selecionado no grid.
3523:     *--------------------------------------------------------------------------
3524:         THIS.AtualizarEstadoGrid()
3525:     ENDPROC
3526: 
3527: ENDDEFINE

