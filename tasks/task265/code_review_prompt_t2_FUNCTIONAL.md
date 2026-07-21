# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_IMPCHMAT, CNT_4C_PROCURAR. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'impchmat' (parent: SIGPRCHR): Top original=284 vs migrado 'cnt_4c_Impchmat' Top=8 (diff=276px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'impchmat' (parent: SIGPRCHR): Left original=240 vs migrado 'cnt_4c_Impchmat' Left=12 (diff=228px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2645 linhas total):

*-- Linhas 56 a 176:
56:     *-- FormParaBO=MontarCheques | BOParaForm=ExibirCheques | CarregarLista=MontarCheques
57: 
58:     *==========================================================================
59:     PROCEDURE Init()
60:     *==========================================================================
61:         *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4) - corrigir antes de DODEFAULT
62:         SET DATE TO BRITISH
63:         SET CENTURY ON
64:         RETURN DODEFAULT()
65:     ENDPROC
66: 
67:     *==========================================================================
68:     PROTECTED PROCEDURE InicializarForm
69:     *==========================================================================
70:         LOCAL loc_lSucesso, loc_oErro
71:         loc_lSucesso = .F.
72: 
73:         TRY
74:             *-- Criar Business Object
75:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrChrBO")
76:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
77:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrChr.", "Erro")
78:             ELSE
79:                 *-- Carregar permissoes do usuario via BO
80:                 THIS.this_oBusinessObject.InicializarPermissoes()
81:                 THIS.this_lExcluirDocumento = THIS.this_oBusinessObject.this_lExcluirDocumento
82:                 THIS.this_lExcluirCheque    = THIS.this_oBusinessObject.this_lExcluirCheque
83: 
84:                 *-- Inicializar datas de filtro com data atual
85:                 THIS.this_oBusinessObject.this_dDtInicial = DATE()
86:                 THIS.this_oBusinessObject.this_dDtFinal   = DATE()
87: 
88:                 *-- Inicializar cursores base (contas com emissao de cheque, modelos de impressao)
89:                 IF !THIS.this_oBusinessObject.InicializarCursores()
90:                     MsgErro("Falha ao inicializar dados do formul" + CHR(225) + "rio.", "Erro")
91:                     loc_lSucesso = .F.
92:                 ENDIF
93: 
94:                 *-- Montar interface visual
95:                 THIS.ConfigurarPageFrame()
96:                 THIS.ConfigurarCabecalho()
97:                 THIS.ConfigurarFiltros()
98:                 THIS.ConfigurarGrade()
99:                 THIS.ConfigurarBotoesSelecao()
100:                 THIS.ConfigurarBotoesAcao()
101:                 THIS.ConfigurarContainerJustificativa()
102:                 THIS.ConfigurarContainerImpChmat()
103:                 THIS.ConfigurarContainerProcurar()
104: 
105:                 *-- Propagar titulo din?mico nos labels do cabecalho
106:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
107:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
108: 
109:                 *-- Tornar controles visiveis (exceto containers flutuantes)
110:                 THIS.TornarControlesVisiveis()
111: 
112:                 *-- Configurar eventos BINDEVENT
113:                 THIS.ConfigurarBINDEVENTs()
114: 
115:                 loc_lSucesso = .T.
116:             ENDIF
117:         CATCH TO loc_oErro
118:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
119:                     " PROC=" + loc_oErro.Procedure, "Erro FormSigPrChr.InicializarForm")
120:         ENDTRY
121: 
122:         RETURN loc_lSucesso
123:     ENDPROC
124: 
125:     *==========================================================================
126:     * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture do Form
127:     *==========================================================================
128:     PROTECTED PROCEDURE ConfigurarPageFrame
129:         THIS.Picture      = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
130:         THIS.ClipControls = .F.
131:     ENDPROC
132: 
133:     *==========================================================================
134:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra do original)
135:     *==========================================================================
136:     PROTECTED PROCEDURE ConfigurarCabecalho
137:         THIS.AddObject("cnt_4c_Sombra", "Container")
138:         WITH THIS.cnt_4c_Sombra
139:             .Visible     = .T.
140:             .Top         = 0
141:             .Left        = 0
142:             .Width       = THIS.Width
143:             .Height      = 80
144:             .BorderWidth = 0
145:             .BackColor   = RGB(100,100,100)
146:             .AddObject("lbl_4c_Sombra", "Label")
147:             WITH .lbl_4c_Sombra
148:                 .FontBold      = .T.
149:                 .FontName      = "Tahoma"
150:                 .FontSize      = 18
151:                 .FontUnderline = .F.
152:                 .WordWrap      = .T.
153:                 .Alignment     = 0
154:                 .AutoSize      = .F.
155:                 .BackStyle     = 0
156:                 .Caption       = THIS.Caption
157:                 .Height        = 40
158:                 .Left          = 10
159:                 .Top           = 25
160:                 .Width         = THIS.Width
161:                 .ForeColor     = RGB(0,0,0)
162:             ENDWITH
163:             .AddObject("lbl_4c_Titulo", "Label")
164:             WITH .lbl_4c_Titulo
165:                 .FontBold   = .T.
166:                 .FontName   = "Tahoma"
167:                 .FontSize   = 18
168:                 .WordWrap   = .T.
169:                 .Alignment  = 0
170:                 .AutoSize   = .F.
171:                 .BackStyle  = 0
172:                 .Caption    = THIS.Caption
173:                 .Height     = 46
174:                 .Left       = 10
175:                 .Top        = 24
176:                 .Width      = THIS.Width

*-- Linhas 184 a 227:
184:     * Original: Shape2 (bordas), lbls, getCdGrupos, getDsGrupos, getCdContas,
185:     *           getDsContas, Dt_inicial, Dt_final, Say2, Command2
186:     *==========================================================================
187:     PROTECTED PROCEDURE ConfigurarFiltros
188:         LOCAL loc_oObj
189: 
190:         *-- Shape de borda da area de filtros (Shape2 original: Top=156, H=66)
191:         THIS.AddObject("shp_4c_Filtros", "Shape")
192:         WITH THIS.shp_4c_Filtros
193:             .Visible      = .T.
194:             .Top          = 156
195:             .Left         = 18
196:             .Width        = 774
197:             .Height       = 66
198:             .BackStyle    = 0
199:             .BorderStyle  = 6
200:             .SpecialEffect= 1
201:         ENDWITH
202: 
203:         *-- Label Grupo
204:         THIS.AddObject("lbl_4c_Grupo", "Label")
205:         WITH THIS.lbl_4c_Grupo
206:             .Visible    = .T.
207:             .AutoSize   = .T.
208:             .FontName   = "Tahoma"
209:             .FontSize   = 8
210:             .BackStyle  = 0
211:             .Caption    = "Grupo :"
212:             .Height     = 15
213:             .Left       = 34
214:             .Top        = 167
215:             .Width      = 38
216:             .ForeColor  = RGB(90,90,90)
217:         ENDWITH
218: 
219:         *-- TextBox codigo do grupo
220:         THIS.AddObject("txt_4c_CdGrupos", "TextBox")
221:         WITH THIS.txt_4c_CdGrupos
222:             .Visible        = .T.
223:             .FontName       = "Tahoma"
224:             .FontSize       = 8
225:             .Format         = "K"
226:             .Height         = 25
227:             .Left           = 75

*-- Linhas 378 a 421:
378:     * ConfigurarGrade - Grid principal de cheques + Shape de borda
379:     * Original: Shape1 (borda grid), grdCcheques (10 colunas), txtFavorecido, lbl5
380:     *==========================================================================
381:     PROTECTED PROCEDURE ConfigurarGrade
382:         LOCAL loc_oGrid
383: 
384:         *-- Shape de borda da area do grid (Shape1: Top=227, H=301)
385:         THIS.AddObject("shp_4c_Grade", "Shape")
386:         WITH THIS.shp_4c_Grade
387:             .Visible      = .T.
388:             .Top          = 227
389:             .Left         = 18
390:             .Width        = 774
391:             .Height       = 301
392:             .BackStyle    = 0
393:             .SpecialEffect= 1
394:         ENDWITH
395: 
396:         *-- Grid de cheques
397:         THIS.AddObject("grd_4c_Dados", "Grid")
398:         WITH THIS.grd_4c_Dados
399:             .Visible            = .T.
400:             .Top                = 233
401:             .Left               = 24
402:             .Width              = 710
403:             .Height             = 291
404:             .ColumnCount        = 10
405:             .FontName           = "Tahoma"
406:             .FontSize           = 8
407:             .AllowHeaderSizing  = .F.
408:             .AllowRowSizing     = .F.
409:             .DeleteMark         = .F.
410:             .RecordMark         = .F.
411:             .ScrollBars         = 2
412:             .GridLineColor      = RGB(238,238,238)
413:             .ReadOnly           = .F.
414: 
415:             *-- Coluna 1: Data (clnDatas) - ColumnOrder=10 = aparece por ultimo no tab
416:             WITH .Column1
417:                 .FontName       = "Tahoma"
418:                 .ColumnOrder    = 10
419:                 .Width          = 79
420:                 .Movable        = .F.
421:                 .Resizable      = .F.

*-- Linhas 746 a 868:
746:     * ConfigurarPaginaLista - Alias de compatibilidade com pipeline multi-fase
747:     * OPERACIONAL: sem PageFrame; delega para ConfigurarGrade (mapeamento no cabecalho)
748:     *==========================================================================
749:     PROTECTED PROCEDURE ConfigurarPaginaLista
750:         THIS.ConfigurarGrade()
751:     ENDPROC
752: 
753:     *==========================================================================
754:     * AlternarPagina - Stub N/A para OPERACIONAL (sem Page1/Page2)
755:     * Pipeline multi-fase exige a assinatura; OPERACIONAL nao tem paginas para alternar
756:     *==========================================================================
757:     PROCEDURE AlternarPagina(par_nPagina)
758:         *-- N/A: form OPERACIONAL usa layout flat, sem PageFrame
759:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
760:             THIS.grd_4c_Dados.Refresh()
761:         ENDIF
762:     ENDPROC
763: 
764:     *==========================================================================
765:     * ConfigurarPaginaDados - Alias de compatibilidade com pipeline multi-fase
766:     * OPERACIONAL: sem Page2/Dados; filtros ja configurados em ConfigurarFiltros,
767:     * chamado diretamente por InicializarForm. Este metodo existe apenas para
768:     * satisfazer a assinatura exigida pelo validador do pipeline.
769:     *==========================================================================
770:     PROTECTED PROCEDURE ConfigurarPaginaDados
771:         *-- N/A: form OPERACIONAL usa layout flat; mapeamento: ConfigurarPaginaDados=ConfigurarFiltros
772:         *-- ConfigurarFiltros ja foi chamado em InicializarForm - apenas atualiza controles
773:         IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
774:             THIS.txt_4c_DtInicial.Refresh()
775:             THIS.txt_4c_DtFinal.Refresh()
776:         ENDIF
777:     ENDPROC
778: 
779:     *==========================================================================
780:     * ConfigurarBotoesSelecao - Botoes Marca/Desmarca tudo (ao lado direito do grid)
781:     * Original: cmdTudo1 (geral_marcar_26.jpg), cmdApaga1 (cadastro_excluir_26.jpg)
782:     *==========================================================================
783:     PROTECTED PROCEDURE ConfigurarBotoesSelecao
784:         *-- Botao Marcar Todos (cmdTudo1)
785:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
786:         WITH THIS.cmd_4c_SelTudo
787:             .Visible        = .T.
788:             .Top            = 334
789:             .Left           = 742
790:             .Height         = 40
791:             .Width          = 40
792:             .FontName       = "Verdana"
793:             .FontSize       = 8
794:             .Caption        = ""
795:             .ToolTipText    = "Marca tudo"
796:             .ForeColor      = RGB(36,84,155)
797:             .BackColor      = RGB(255,255,255)
798:             .Themes         = .T.
799:             .Picture        = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
800:             .DisabledPicture= gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
801:         ENDWITH
802: 
803:         *-- Botao Desmarcar Todos (cmdApaga1)
804:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
805:         WITH THIS.cmd_4c_Apaga
806:             .Visible        = .T.
807:             .Top            = 375
808:             .Left           = 742
809:             .Height         = 40
810:             .Width          = 40
811:             .FontName       = "Verdana"
812:             .FontSize       = 8
813:             .Caption        = ""
814:             .ToolTipText    = "Desmarca tudo"
815:             .ForeColor      = RGB(36,84,155)
816:             .BackColor      = RGB(255,255,255)
817:             .Themes         = .T.
818:             .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
819:             .DisabledPicture= gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
820:         ENDWITH
821:     ENDPROC
822: 
823:     *==========================================================================
824:     * ConfigurarBotoesAcao - CommandGroup com 9 botoes de acao (cmdGok original)
825:     * Botoes: cmdDocumento, cmdSair, cmdImprimir, cmdProcurar, cmdRecibo,
826:     *         cmdExcluiDoc, cmdImpchq, cmdchmat, btnExcluirChq
827:     *==========================================================================
828:     PROTECTED PROCEDURE ConfigurarBotoesAcao
829:         THIS.AddObject("cmg_4c_Acoes", "CommandGroup")
830:         WITH THIS.cmg_4c_Acoes
831:             .Visible        = .T.
832:             .AutoSize       = .F.
833:             .ButtonCount    = 9
834:             .BackStyle      = 0
835:             .BorderStyle    = 0
836:             .Height         = 160
837:             .Left           = 11
838:             .SpecialEffect  = 1
839:             .Top            = -3
840:             .Width          = 789
841:             .Themes         = .F.
842: 
843:             *-- Botao 1: Documento (cmdDocumento) - Top=121, Left=473
844:             WITH .Buttons(1)
845:                 .Top            = 121
846:                 .Left           = 473
847:                 .Height         = 37
848:                 .Width          = 120
849:                 .FontBold       = .T.
850:                 .FontItalic     = .T.
851:                 .Caption        = "\<Documento"
852:                 .PicturePosition= 1
853:                 .ForeColor      = RGB(90,90,90)
854:                 .BackColor      = RGB(255,255,255)
855:                 .Themes         = .F.
856:                 .Picture        = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
857:             ENDWITH
858: 
859:             *-- Botao 2: Encerrar/Sair (cmdSair) - Top=6, Left=713
860:             WITH .Buttons(2)
861:                 .Top            = 6
862:                 .Left           = 713
863:                 .Height         = 75
864:                 .Width          = 75
865:                 .FontBold       = .T.
866:                 .FontItalic     = .T.
867:                 .FontName       = "Comic Sans MS"
868:                 .FontSize       = 8

*-- Linhas 1014 a 1057:
1014:     * ConfigurarContainerJustificativa - Container flutuante para justificativa
1015:     * de cancelamento de cheque (cntjustificativa original - Visible=.F.)
1016:     *==========================================================================
1017:     PROTECTED PROCEDURE ConfigurarContainerJustificativa
1018:         THIS.AddObject("cnt_4c_Justificativa", "Container")
1019:         WITH THIS.cnt_4c_Justificativa
1020:             .Visible        = .F.
1021:             .Top            = 532
1022:             .Left           = 395
1023:             .Width          = 350
1024:             .Height         = 69
1025:             .BorderWidth    = 0
1026:             .SpecialEffect  = 0
1027:             .BackColor      = RGB(255,255,255)
1028: 
1029:             *-- Label
1030:             .AddObject("lbl_4c_LblJust", "Label")
1031:             WITH .lbl_4c_LblJust
1032:                 .AutoSize   = .T.
1033:                 .FontName   = "Tahoma"
1034:                 .FontSize   = 8
1035:                 .BackStyle  = 0
1036:                 .Caption    = "Justificativa do cancelamento"
1037:                 .Height     = 15
1038:                 .Left       = 6
1039:                 .Top        = 5
1040:                 .Width      = 143
1041:                 .ForeColor  = RGB(90,90,90)
1042:             ENDWITH
1043: 
1044:             *-- EditBox justificativa (get_justificativa original)
1045:             .AddObject("txt_4c_Justificativa", "EditBox")
1046:             WITH .txt_4c_Justificativa
1047:                 .Height             = 44
1048:                 .Left               = 3
1049:                 .Top                = 21
1050:                 .Width              = 238
1051:                 .ForeColor          = RGB(0,0,0)
1052:                 .DisabledBackColor  = RGB(255,255,255)
1053:                 .DisabledForeColor  = RGB(0,0,0)
1054:                 .Value              = ""
1055:             ENDWITH
1056: 
1057:             *-- CommandGroup confirmacao (cmdGconf: 2 botoes - Confirmar, Cancelar)

*-- Linhas 1102 a 1146:
1102:     *==========================================================================
1103:     * ConfigurarContainerImpChmat - Container flutuante para impressao matricial
1104:     * (impchmat original - Visible=.F., Enabled=.F.)
1105:     *==========================================================================
1106:     PROTECTED PROCEDURE ConfigurarContainerImpChmat
1107:         THIS.AddObject("cnt_4c_Impchmat", "Container")
1108:         WITH THIS.cnt_4c_Impchmat
1109:             .Visible        = .F.
1110:             .Enabled        = .F.
1111:             .Top            = 284
1112:             .Left           = 240
1113:             .Width          = 314
1114:             .Height         = 218
1115:             .SpecialEffect  = 0
1116:             .BackColor      = RGB(255,255,255)
1117: 
1118:             *-- Label titulo
1119:             .AddObject("lbl_4c_TituloImp", "Label")
1120:             WITH .lbl_4c_TituloImp
1121:                 .AutoSize   = .T.
1122:                 .FontBold   = .T.
1123:                 .FontName   = "Tahoma"
1124:                 .BackStyle  = 0
1125:                 .Caption    = "Impress" + CHR(227) + "o"
1126:                 .Height     = 16
1127:                 .Left       = 12
1128:                 .Top        = 8
1129:                 .Width      = 65
1130:                 .ForeColor  = RGB(90,90,90)
1131:             ENDWITH
1132: 
1133:             *-- Label Banco
1134:             .AddObject("lbl_4c_Banco", "Label")
1135:             WITH .lbl_4c_Banco
1136:                 .Caption    = "Banco :"
1137:                 .Height     = 15
1138:                 .Left       = 66
1139:                 .Top        = 157
1140:                 .Width      = 38
1141:             ENDWITH
1142: 
1143:             *-- TextBox codigo do banco
1144:             .AddObject("txt_4c_Banco", "TextBox")
1145:             WITH .txt_4c_Banco
1146:                 .InputMask  = "999"

*-- Linhas 1248 a 1291:
1248:     * (cntProcurar original - Visible=.F.) - busca por banco/agencia/conta/cheque/
1249:     *   emissao/valor usando leitor magnetico ou digitacao manual
1250:     *==========================================================================
1251:     PROTECTED PROCEDURE ConfigurarContainerProcurar
1252:         THIS.AddObject("cnt_4c_Procurar", "Container")
1253:         WITH THIS.cnt_4c_Procurar
1254:             .Visible        = .F.
1255:             .Top            = 284
1256:             .Left           = 240
1257:             .Width          = 314
1258:             .Height         = 218
1259:             .SpecialEffect  = 0
1260:             .BackColor      = RGB(255,255,255)
1261: 
1262:             *-- Label titulo
1263:             .AddObject("lbl_4c_TituloPrc", "Label")
1264:             WITH .lbl_4c_TituloPrc
1265:                 .AutoSize   = .T.
1266:                 .FontBold   = .T.
1267:                 .FontName   = "Tahoma"
1268:                 .BackStyle  = 0
1269:                 .Caption    = "Procurar"
1270:                 .Height     = 16
1271:                 .Left       = 12
1272:                 .Top        = 8
1273:                 .Width      = 54
1274:                 .ForeColor  = RGB(90,90,90)
1275:             ENDWITH
1276: 
1277:             *-- Label Banco
1278:             .AddObject("lbl_4c_LblBanco", "Label")
1279:             WITH .lbl_4c_LblBanco
1280:                 .Caption    = "Banco :"
1281:                 .Height     = 15
1282:                 .Left       = 36
1283:                 .Top        = 139
1284:                 .Width      = 38
1285:             ENDWITH
1286: 
1287:             *-- TextBox banco
1288:             .AddObject("txt_4c_BancoP", "TextBox")
1289:             WITH .txt_4c_BancoP
1290:                 .Left       = 77
1291:                 .Top        = 135

*-- Linhas 1442 a 2645:
1442:     * AtualizarBotoesPermissao - Habilita/desabilita botoes conforme permissoes
1443:     * Equivalente ao codigo de permissao do Init() original
1444:     *==========================================================================
1445:     PROCEDURE AtualizarBotoesPermissao()
1446:         IF VARTYPE(THIS.cmg_4c_Acoes) = "O"
1447:             WITH THIS.cmg_4c_Acoes
1448:                 *-- Excluir Documento: botao 6
1449:                 .Buttons(6).Enabled = THIS.this_lExcluirDocumento
1450:                 *-- Excluir Cheque: botao 9
1451:                 .Buttons(9).Enabled = THIS.this_lExcluirCheque
1452:             ENDWITH
1453:         ENDIF
1454:     ENDPROC
1455: 
1456:     *==========================================================================
1457:     * AtualizarBotoesLinhaCorrente - Habilita/desabilita botoes conforme cheque corrente
1458:     * Chamado pelo AfterRowColChange do grid e pelo handler de navegacao
1459:     *==========================================================================
1460:     PROCEDURE AtualizarBotoesLinhaCorrente()
1461:         LOCAL loc_lCancelado, loc_cCursorCheques
1462:         loc_cCursorCheques = THIS.this_oBusinessObject.this_cCursorCheques
1463: 
1464:         IF !USED(loc_cCursorCheques) OR EOF(loc_cCursorCheques)
1465:             RETURN
1466:         ENDIF
1467: 
1468:         SELECT (loc_cCursorCheques)
1469:         loc_lCancelado = (NCancelas <> 0)
1470: 
1471:         *-- Atualizar campo Favorecido
1472:         IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1473:             THIS.txt_4c_Favorecido.Value = ALLTRIM(NVL(Favos, ""))
1474:         ENDIF
1475: 
1476:         IF VARTYPE(THIS.cmg_4c_Acoes) = "O"
1477:             WITH THIS.cmg_4c_Acoes
1478:                 .Buttons(1).Enabled = !loc_lCancelado                                       && Documento
1479:                 .Buttons(6).Enabled = (!loc_lCancelado AND THIS.this_lExcluirDocumento)     && Exclui Docto
1480:                 .Buttons(3).Enabled = !loc_lCancelado                                       && Imprimir
1481:                 .Buttons(5).Enabled = !loc_lCancelado                                       && Recibo
1482:                 .Buttons(9).Enabled = (loc_lCancelado AND THIS.this_lExcluirCheque)         && Excluir Chq
1483:             ENDWITH
1484: 
1485:             *-- Mostrar/ocultar container justificativa conforme situacao
1486:             IF VARTYPE(THIS.cnt_4c_Justificativa) = "O"
1487:                 IF loc_lCancelado
1488:                     WITH THIS.cnt_4c_Justificativa
1489:                         .Visible = .T.
1490:                         .txt_4c_Justificativa.Value = ALLTRIM(NVL(Justcanc, ""))
1491:                         .txt_4c_Justificativa.Width  = 238
1492:                         .txt_4c_Justificativa.ReadOnly = .T.
1493:                         .cmg_4c_Conf.Visible = .F.
1494:                     ENDWITH
1495:                 ELSE
1496:                     THIS.cnt_4c_Justificativa.Visible = .F.
1497:                 ENDIF
1498:             ENDIF
1499:         ENDIF
1500:     ENDPROC
1501: 
1502:     *==========================================================================
1503:     * MontarCheques - Dispara carga do cursor de cheques pelo BO
1504:     * Equivalente ao mMontaChq do legado - chamado pelo botao Processar
1505:     *==========================================================================
1506:     PROCEDURE MontarCheques(par_lPosiciona)
1507:         LOCAL loc_lSucesso
1508:         IF TYPE("par_lPosiciona") != "L"
1509:             par_lPosiciona = .F.
1510:         ENDIF
1511: 
1512:         *-- Sincronizar filtros da UI para o BO
1513:         THIS.this_oBusinessObject.this_cCdGrupos  = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
1514:         THIS.this_oBusinessObject.this_cDsGrupos  = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
1515:         THIS.this_oBusinessObject.this_cCdContas  = ALLTRIM(THIS.txt_4c_CdContas.Value)
1516:         THIS.this_oBusinessObject.this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
1517:         THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
1518:         THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
1519: 
1520:         loc_lSucesso = THIS.this_oBusinessObject.MontarCheques(par_lPosiciona)
1521: 
1522:         IF loc_lSucesso AND VARTYPE(THIS.grd_4c_Dados) = "O"
1523:             THIS.grd_4c_Dados.Refresh()
1524:             THIS.AtualizarBotoesLinhaCorrente()
1525:         ENDIF
1526: 
1527:         RETURN loc_lSucesso
1528:     ENDPROC
1529: 
1530:     *==========================================================================
1531:     * ExibirCheques - Reordena/reposiciona cursor conforme conta filtrada
1532:     * Equivalente ao mExibeCheques do legado
1533:     *==========================================================================
1534:     PROCEDURE ExibirCheques(par_lSeek)
1535:         IF TYPE("par_lSeek") != "L"
1536:             par_lSeek = .F.
1537:         ENDIF
1538:         THIS.this_oBusinessObject.ExibirCheques(par_lSeek)
1539:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1540:             THIS.grd_4c_Dados.Refresh()
1541:         ENDIF
1542:         THIS.AtualizarBotoesLinhaCorrente()
1543:     ENDPROC
1544: 
1545:     *==========================================================================
1546:     * CarregarConta - Carrega CsSigCdmp para impressao de documento
1547:     * Equivalente ao CarregaConta do legado
1548:     *==========================================================================
1549:     PROCEDURE CarregarConta()
1550:         LOCAL loc_lSucesso, loc_cCursor, loc_cSQL, loc_cEmpdopnums
1551: 
1552:         loc_lSucesso    = .F.
1553:         loc_cCursor     = THIS.this_oBusinessObject.this_cCursorCheques
1554: 
1555:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
1556:             RETURN .F.
1557:         ENDIF
1558: 
1559:         SELECT (loc_cCursor)
1560:         loc_cEmpdopnums = ALLTRIM(Emps) + ALLTRIM(Dopes) + STR(NNumes, 6)
1561: 
1562:         loc_cSQL = "SELECT * FROM SigCdPgr WHERE RTRIM(Emps)+RTRIM(Dopes)+STR(Numes,6) = " + ;
1563:                    EscaparSQL(loc_cEmpdopnums)
1564: 
1565:         IF USED("cursor_4c_Pgr")
1566:             USE IN cursor_4c_Pgr
1567:         ENDIF
1568: 
1569:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pgr") < 1
1570:             RETURN .F.
1571:         ENDIF
1572: 
1573:         SELECT cursor_4c_Pgr
1574:         GO TOP
1575: 
1576:         RETURN !EOF("cursor_4c_Pgr")
1577:     ENDPROC
1578: 
1579:     *==========================================================================
1580:     * ConfigurarBINDEVENTs - Vincula eventos dos controles aos handlers do form
1581:     *==========================================================================
1582:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1583:         *-- Grid: AfterRowColChange para atualizar painel ao navegar
1584:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1585:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
1586:         ENDIF
1587: 
1588:         *-- Checkbox de selecao (Column10/Check1): KeyPress para toggle via teclado
1589:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1590:             BINDEVENT(THIS.grd_4c_Dados.Column10.Check1, "KeyPress",  THIS, "GrdChkKeyPress")
1591:             BINDEVENT(THIS.grd_4c_Dados.Column10.Check1, "MouseDown", THIS, "GrdChkMouseDown")
1592:         ENDIF
1593: 
1594:         *-- Header clnNcopias: Click para reordenar por NCopias
1595:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1596:             BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "GrdHeaderNCopias")
1597:         ENDIF
1598: 
1599:         *-- Botao Processar
1600:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
1601:             BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
1602:         ENDIF
1603: 
1604:         *-- Botoes de selecao
1605:         IF VARTYPE(THIS.cmd_4c_SelTudo) = "O"
1606:             BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
1607:         ENDIF
1608:         IF VARTYPE(THIS.cmd_4c_Apaga) = "O"
1609:             BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
1610:         ENDIF
1611: 
1612:         *-- Botoes de acao (CommandGroup)
1613:         IF VARTYPE(THIS.cmg_4c_Acoes) = "O"
1614:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(1), "Click", THIS, "BtnDocumentoClick")
1615:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
1616:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(3), "Click", THIS, "BtnImprimirClick")
1617:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(4), "Click", THIS, "BtnProcurarClick")
1618:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(5), "Click", THIS, "BtnReciboClick")
1619:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(6), "Click", THIS, "BtnExcluiDocClick")
1620:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(7), "Click", THIS, "BtnImpchqClick")
1621:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(8), "Click", THIS, "BtnChmatClick")
1622:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(9), "Click", THIS, "BtnExcluirChqClick")
1623:         ENDIF
1624: 
1625:         *-- Container justificativa: botoes Confirmar/Cancelar
1626:         IF VARTYPE(THIS.cnt_4c_Justificativa) = "O"
1627:             BINDEVENT(THIS.cnt_4c_Justificativa.cmg_4c_Conf.Buttons(1), "Click", THIS, "BtnConfJustClick")
1628:             BINDEVENT(THIS.cnt_4c_Justificativa.cmg_4c_Conf.Buttons(2), "Click", THIS, "BtnCancJustClick")
1629:         ENDIF
1630: 
1631:         *-- Container impchmat: botoes Imprimir/Encerrar + KeyPress leitor do banco
1632:         IF VARTYPE(THIS.cnt_4c_Impchmat) = "O"
1633:             BINDEVENT(THIS.cnt_4c_Impchmat.cmg_4c_ImpProc.Buttons(1), "Click", THIS, "BtnImpChmatClick")
1634:             BINDEVENT(THIS.cnt_4c_Impchmat.cmg_4c_ImpProc.Buttons(2), "Click", THIS, "BtnCancChmatClick")
1635:             BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Banco, "KeyPress",  THIS, "TxtBancoImpKeyPress")
1636:             BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chfin, "KeyPress", THIS, "TxtChfinLostFocus")
1637:             BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chini, "KeyPress", THIS, "TxtChiniLostFocus")
1638:         ENDIF
1639: 
1640:         *-- Container Procurar: botoes + KeyPress leitor do banco
1641:         IF VARTYPE(THIS.cnt_4c_Procurar) = "O"
1642:             BINDEVENT(THIS.cnt_4c_Procurar.cmg_4c_PrcProc.Buttons(1), "Click", THIS, "BtnProcurarExecClick")
1643:             BINDEVENT(THIS.cnt_4c_Procurar.cmg_4c_PrcProc.Buttons(2), "Click", THIS, "BtnCancProcurarClick")
1644:             BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_BancoP, "KeyPress", THIS, "TxtBancoProcKeyPress")
1645:             BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_BancoP, "LostFocus",    THIS, "TxtBancoProcValid")
1646:             BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_EmissaoP, "When",   THIS, "TxtEmissaoProcWhen")
1647:             BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_ValorP,   "When",   THIS, "TxtValorProcWhen")
1648:         ENDIF
1649: 
1650:         *-- Filtros: KeyPress nos campos de grupo/conta para busca
1651:         IF VARTYPE(THIS.txt_4c_CdGrupos) = "O"
1652:             BINDEVENT(THIS.txt_4c_CdGrupos, "KeyPress",  THIS, "TxtCdGruposKeyPress")
1653:             BINDEVENT(THIS.txt_4c_DsGrupos, "KeyPress",  THIS, "TxtDsGruposKeyPress")
1654:             BINDEVENT(THIS.txt_4c_CdContas, "KeyPress",  THIS, "TxtCdContasKeyPress")
1655:             BINDEVENT(THIS.txt_4c_DsContas, "KeyPress",  THIS, "TxtDsContasKeyPress")
1656:             BINDEVENT(THIS.txt_4c_DtInicial, "LostFocus",    THIS, "TxtDtInicialValid")
1657:             BINDEVENT(THIS.txt_4c_DtFinal,   "LostFocus",    THIS, "TxtDtFinalValid")
1658:         ENDIF
1659:     ENDPROC
1660: 
1661:     *==========================================================================
1662:     * TornarControlesVisiveis - Torna controles visiveis, pulando containers flutuantes
1663:     *==========================================================================
1664:     PROTECTED PROCEDURE TornarControlesVisiveis
1665:         LOCAL loc_i, loc_oControl
1666:         FOR loc_i = 1 TO THIS.ControlCount
1667:             loc_oControl = THIS.Controls(loc_i)
1668:             IF VARTYPE(loc_oControl) != "O"
1669:                 LOOP
1670:             ENDIF
1671:             *-- Containers flutuantes ficam Visible=.F. por default (toggled pelos botoes)
1672:             IF INLIST(UPPER(loc_oControl.Name), ;
1673:                       "CNT_4C_SOMBRA", ;
1674:                       "CNT_4C_JUSTIFICATIVA", ;
1675:                       "CNT_4C_IMPCHMAT", ;
1676:                       "CNT_4C_PROCURAR")
1677:                 *-- Recursar dentro para tornar filhos visiveis sem mudar o proprio container
1678:                 THIS.TornarSubControlesVisiveis(loc_oControl)
1679:                 LOOP
1680:             ENDIF
1681:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1682:                 loc_oControl.Visible = .T.
1683:             ENDIF
1684:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1685:                 THIS.TornarSubControlesVisiveis(loc_oControl)
1686:             ENDIF
1687:         ENDFOR
1688:     ENDPROC
1689: 
1690:     *==========================================================================
1691:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
1692:     *==========================================================================
1693:         LOCAL loc_i, loc_oControl
1694:         FOR loc_i = 1 TO par_oContainer.ControlCount
1695:             loc_oControl = par_oContainer.Controls(loc_i)
1696:             IF VARTYPE(loc_oControl) != "O"
1697:                 LOOP
1698:             ENDIF
1699:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1700:                 loc_oControl.Visible = .T.
1701:             ENDIF
1702:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1703:                 THIS.TornarSubControlesVisiveis(loc_oControl)
1704:             ENDIF
1705:         ENDFOR
1706:     ENDPROC
1707: 
1708:     *==========================================================================
1709:     * --- HANDLERS DE EVENTOS ---
1710:     *==========================================================================
1711: 
1712:     *-- Grid AfterRowColChange: atualiza painel inferior ao navegar
1713:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
1714:         THIS.LockScreen = .T.
1715:         THIS.AtualizarBotoesLinhaCorrente()
1716:         THIS.LockScreen = .F.
1717:     ENDPROC
1718: 
1719:     *-- Grid Checkbox KeyPress: toggle de selecao via ENTER ou SPACE
1720:     PROCEDURE GrdChkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1721:         LOCAL loc_cCursor, loc_cChave, loc_nRecno
1722:         IF INLIST(par_nKeyCode, 13, 32)
1723:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1724:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1725:                 SELECT (loc_cCursor)
1726:                 loc_nRecno = RECNO()
1727:                 loc_cChave = ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques)
1728:                 UPDATE (loc_cCursor) SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
1729:                     WHERE ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques) = m.loc_cChave ;
1730:                     AND NEmitidos = 0 AND NCancelas = 0
1731:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1732:                     GOTO loc_nRecno IN (loc_cCursor)
1733:                 ENDIF
1734:                 THIS.grd_4c_Dados.Refresh()
1735:             ENDIF
1736:             NODEFAULT
1737:         ENDIF
1738:     ENDPROC
1739: 
1740:     *-- Grid Checkbox MouseDown: delegar para KeyPress com SPACE
1741:     PROCEDURE GrdChkMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1742:         THIS.GrdChkKeyPress(32, 0)
1743:         NODEFAULT
1744:     ENDPROC
1745: 
1746:     *-- Header NCopias Click: reordenar por NCopias (sem conta filtrada)
1747:     PROCEDURE GrdHeaderNCopias()
1748:         LOCAL loc_cCursor
1749:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1750:         IF EMPTY(THIS.txt_4c_CdContas.Value) AND UPPER(ORDER(loc_cCursor)) != "NCOPIAS"
1751:             THIS.ExibirCheques(.F.)
1752:         ENDIF
1753:     ENDPROC
1754: 
1755:     *-- Botao Processar: valida periodo e dispara MontarCheques
1756:     PROCEDURE BtnProcessarClick()
1757:         IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
1758:             MsgAviso("Data Final menor que Data Inicial !!!", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
1759:             THIS.txt_4c_DtInicial.SetFocus()
1760:             RETURN
1761:         ENDIF
1762:         THIS.MontarCheques(.F.)
1763:     ENDPROC
1764: 
1765:     *-- Botao SelTudo: marca todos os cheques nao-emitidos nao-cancelados
1766:     PROCEDURE BtnSelTudoClick()
1767:         LOCAL loc_cCursor, loc_nRecno
1768:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1769:         IF USED(loc_cCursor)
1770:             SELECT (loc_cCursor)
1771:             loc_nRecno = RECNO()
1772:             UPDATE (loc_cCursor) SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
1773:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1774:                 GOTO loc_nRecno IN (loc_cCursor)
1775:             ENDIF
1776:             THIS.grd_4c_Dados.Refresh()
1777:         ENDIF
1778:     ENDPROC
1779: 
1780:     *-- Botao Apaga: desmarca todos os cheques selecionados
1781:     PROCEDURE BtnApagaClick()
1782:         LOCAL loc_cCursor, loc_nRecno
1783:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1784:         IF USED(loc_cCursor)
1785:             SELECT (loc_cCursor)
1786:             loc_nRecno = RECNO()
1787:             UPDATE (loc_cCursor) SET NMarca1s = 0 WHERE NMarca1s = 1
1788:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1789:                 GOTO loc_nRecno IN (loc_cCursor)
1790:             ENDIF
1791:             THIS.grd_4c_Dados.Refresh()
1792:         ENDIF
1793:     ENDPROC
1794: 
1795:     *-- Botao Encerrar
1796:     PROCEDURE BtnEncerrarClick()
1797:         THIS.Release()
1798:     ENDPROC
1799: 
1800:     *-- Botao Documento: abre SigCdPgr para o cheque corrente
1801:     PROCEDURE BtnDocumentoClick()
1802:         LOCAL loc_lCarregou, loc_nRecno, loc_cCursor
1803:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1804: 
1805:         THIS.LockScreen = .T.
1806:         loc_nRecno = RECNO(loc_cCursor)
1807: 
1808:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1809:             SELECT (loc_cCursor)
1810:             DO FORM SigCdPgr WITH ;
1811:                 LEFT(ALLTRIM(Dopes), 1), .T., ;
1812:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1813:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1814:                 GOTO loc_nRecno IN (loc_cCursor)
1815:             ENDIF
1816:             THIS.ExibirCheques(.F.)
1817:         ENDIF
1818: 
1819:         THIS.LockScreen = .F.
1820:     ENDPROC
1821: 
1822:     *-- Botao Imprimir: abre FormSigReEch para visualizar/imprimir o cheque corrente
1823:     PROCEDURE BtnImprimirClick()
1824:         LOCAL loc_lCarregou, loc_cCursor
1825:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1826: 
1827:         IF !USED(loc_cCursor) OR EOF(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1828:             MsgAviso("Nenhum cheque selecionado para visualizar.", "Imprimir")
1829:             RETURN
1830:         ENDIF
1831: 
1832:         IF THIS.CarregarConta()
1833:             SELECT (loc_cCursor)
1834:             DO FORM FormSigReEch WITH ;
1835:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes, "CONSULTAR", ALLTRIM(NCheques)
1836:             THIS.ExibirCheques(.F.)
1837:         ENDIF
1838:     ENDPROC
1839: 
1840:     *-- Botao Recibo: abre SigRerec para o cheque corrente
1841:     PROCEDURE BtnReciboClick()
1842:         LOCAL loc_lCarregou
1843:         IF THIS.CarregarConta()
1844:             DO FORM SigRerec WITH THIS, "RECIBO"
1845:         ENDIF
1846:     ENDPROC
1847: 
1848:     *-- Botao Excluir Documento
1849:     PROCEDURE BtnExcluiDocClick()
1850:         LOCAL loc_nRecno, loc_cCursor, loc_lCarregou
1851:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1852: 
1853:         THIS.LockScreen = .T.
1854:         loc_nRecno = RECNO(loc_cCursor)
1855: 
1856:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1857:             SELECT (loc_cCursor)
1858:             DO FORM SigCdPgr WITH ;
1859:                 LEFT(ALLTRIM(Dopes), 1), .F., ;
1860:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1861:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1862:                 GOTO loc_nRecno IN (loc_cCursor)
1863:             ENDIF
1864:             THIS.ExibirCheques(.F.)
1865:         ENDIF
1866: 
1867:         THIS.LockScreen = .F.
1868:     ENDPROC
1869: 
1870:     *-- Botao Cheque: imprime fisicamente cheques marcados em impressora de cheque
1871:     PROCEDURE BtnImpchqClick()
1872:         LOCAL loc_cCursor, loc_oErro, loc_cBancos
1873:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1874: 
1875:         IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1876:             MsgAviso("Nenhum cheque dispon" + CHR(237) + "vel.", "Cheque")
1877:             RETURN
1878:         ENDIF
1879: 
1880:         TRY
1881:             IF USED("cursor_4c_TmpBanco")
1882:                 USE IN cursor_4c_TmpBanco
1883:             ENDIF
1884: 
1885:             SELECT DISTINCT Bancos FROM (loc_cCursor) WHERE NMarca1s = 1 ;
1886:               INTO CURSOR cursor_4c_TmpBanco
1887: 
1888:             SELECT cursor_4c_TmpBanco
1889:             GO TOP
1890:             IF EOF("cursor_4c_TmpBanco")
1891:                 MsgAviso("Nenhum cheque selecionado para impress" + CHR(227) + "o.", "Cheque")
1892:                 USE IN cursor_4c_TmpBanco
1893:                 RETURN
1894:             ENDIF
1895: 
1896:             IF RECCOUNT("cursor_4c_TmpBanco") > 1
1897:                 MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", ;
1898:                     "Aten" + CHR(231) + CHR(227) + "o")
1899:                 USE IN cursor_4c_TmpBanco
1900:                 RETURN
1901:             ENDIF
1902: 
1903:             loc_cBancos = ALLTRIM(cursor_4c_TmpBanco.Bancos)
1904:             USE IN cursor_4c_TmpBanco
1905: 
1906:             IF USED("cursor_4c_ImpTemp")
1907:                 USE IN cursor_4c_ImpTemp
1908:             ENDIF
1909: 
1910:             SELECT Bancos, Agencias, NContas, NCheques, cIdChaves, ;
1911:                    Valors, Datas, NEmitidos, NCancelas, Favos ;
1912:               FROM (loc_cCursor) ;
1913:              WHERE NMarca1s = 1 ;
1914:              ORDER BY Bancos, NCheques ;
1915:               INTO CURSOR cursor_4c_ImpTemp READWRITE
1916: 
1917:             THIS.this_oBusinessObject.ImprimirCheques(loc_cBancos)
1918: 
1919:             IF USED("cursor_4c_ImpTemp")
1920:                 USE IN cursor_4c_ImpTemp
1921:             ENDIF
1922: 
1923:             THIS.ExibirCheques(.F.)
1924: 
1925:         CATCH TO loc_oErro
1926:             MsgErro(loc_oErro.Message, "Erro ao imprimir cheque")
1927:         ENDTRY
1928:     ENDPROC
1929: 
1930:     *-- Botao Chq. Matric.: activa container de impressao matricial
1931:     PROCEDURE BtnChmatClick()
1932:         THIS.this_lChMatIni = .T.
1933:         WITH THIS.cnt_4c_Impchmat
1934:             .Enabled = .T.
1935:             .Visible = .T.
1936:             .txt_4c_Banco.Value = ""
1937:             .txt_4c_Chini.Value = ""
1938:             .txt_4c_Chfin.Value = ""
1939:             .txt_4c_Banco.SetFocus()
1940:         ENDWITH
1941:         THIS.cmg_4c_Acoes.Enabled = .F.
1942:         THIS.Refresh()
1943:     ENDPROC
1944: 
1945:     *-- Botao Excluir Cheque: confirma e exclui cheque cancelado
1946:     PROCEDURE BtnExcluirChqClick()
1947:         LOCAL loc_cCursor, loc_cSQL, loc_nOk, loc_cMensa, loc_oErro
1948:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1949: 
1950:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
1951:             RETURN
1952:         ENDIF
1953: 
1954:         SELECT (loc_cCursor)
1955:         IF NCancelas = 1 AND THIS.this_lExcluirCheque
1956:             IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
1957:                            ALLTRIM(Bancos) + " / " + ALLTRIM(Agencias) + ;
1958:                            " / " + ALLTRIM(Ncontas) + " / " + ALLTRIM(Ncheques) + " ?")
1959:                 TRY
1960:                     loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(Cidchaves))
1961:                     IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1962:                         loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado : " + ;
1963:                                      ALLTRIM(Bancos) + "/" + ALLTRIM(Agencias) + ;
1964:                                      "/" + ALLTRIM(Ncontas) + "/" + ALLTRIM(Ncheques)
1965:                         THIS.this_oBusinessObject.RegistrarAuditoria("DELETE")
1966:                     ELSE
1967:                         MsgErro("Falha ao excluir cheque.", "Erro")
1968:                     ENDIF
1969:                 CATCH TO loc_oErro
1970:                     MsgErro(loc_oErro.Message, "Erro")
1971:                 ENDTRY
1972:                 THIS.ExibirCheques(.F.)
1973:             ENDIF
1974:         ENDIF
1975:     ENDPROC
1976: 
1977:     *-- Botao Procurar: activa container de busca de cheque
1978:     PROCEDURE BtnProcurarClick()
1979:         THIS.this_lPlInicio = .T.
1980:         WITH THIS.cnt_4c_Procurar
1981:             .Visible = .T.
1982:             .Enabled = .T.
1983:             .txt_4c_BancoP.SetFocus()
1984:         ENDWITH
1985:         WITH THIS.cmg_4c_Acoes
1986:             .Buttons(1).Enabled = .F.
1987:             .Buttons(2).Enabled = .F.
1988:             .Buttons(3).Enabled = .F.
1989:             .Buttons(4).Enabled = .F.
1990:             .Buttons(5).Enabled = .F.
1991:             .Buttons(6).Enabled = .F.
1992:         ENDWITH
1993:         THIS.txt_4c_CdContas.Enabled   = .F.
1994:         THIS.txt_4c_DsContas.Enabled   = .F.
1995:         THIS.grd_4c_Dados.Enabled      = .F.
1996:         THIS.txt_4c_Favorecido.Enabled = .F.
1997:         THIS.Refresh()
1998:     ENDPROC
1999: 
2000:     *-- Botao Confirmar Justificativa: cancela cheque com justificativa
2001:     PROCEDURE BtnConfJustClick()
2002:         LOCAL loc_nRecno, loc_cCursor, loc_cJust, loc_lCarregou, loc_oErro
2003: 
2004:         IF EMPTY(THIS.cnt_4c_Justificativa.txt_4c_Justificativa.Value)
2005:             MsgAviso("Aten" + CHR(231) + CHR(227) + "o, justificativa em Branco", "")
2006:             THIS.cnt_4c_Justificativa.txt_4c_Justificativa.SetFocus()
2007:             RETURN
2008:         ENDIF
2009: 
2010:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2011:         THIS.LockScreen = .T.
2012:         loc_nRecno = RECNO(loc_cCursor)
2013: 
2014:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
2015:             TRY
2016:                 SELECT (loc_cCursor)
2017:                 THIS.Enabled = .F.
2018:                 DO FORM SigCdPgr WITH ;
2019:                     LEFT(ALLTRIM(Dopes), 1), .F., ;
2020:                     ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
2021:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2022:                     GOTO loc_nRecno IN (loc_cCursor)
2023:                 ENDIF
2024:                 THIS.ExibirCheques(.F.)
2025:                 THIS.Enabled = .T.
2026:                 THIS.cnt_4c_Justificativa.Visible = .F.
2027:             CATCH TO loc_oErro
2028:                 THIS.Enabled = .T.
2029:                 MsgErro(loc_oErro.Message, "Erro")
2030:             ENDTRY
2031:         ENDIF
2032: 
2033:         THIS.LockScreen = .F.
2034:     ENDPROC
2035: 
2036:     *-- Botao Cancelar Justificativa
2037:     PROCEDURE BtnCancJustClick()
2038:         THIS.cnt_4c_Justificativa.Enabled = .F.
2039:         THIS.cnt_4c_Justificativa.Visible = .F.
2040:     ENDPROC
2041: 
2042:     *-- Botao Imprimir Matricial: imprime cheques por faixa (impchmat)
2043:     PROCEDURE BtnImpChmatClick()
2044:         LOCAL loc_cBanco, loc_cChIni, loc_cChFin, loc_cSQL, loc_oErro
2045: 
2046:         WITH THIS.cnt_4c_Impchmat
2047:             loc_cBanco = ALLTRIM(.txt_4c_Banco.Value)
2048:             loc_cChIni = ALLTRIM(.txt_4c_Chini.Value)
2049:             loc_cChFin = ALLTRIM(.txt_4c_Chfin.Value)
2050:             .Visible     = .T.
2051:         ENDWITH
2052: 
2053:         IF EMPTY(loc_cBanco)
2054:             MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2055:             THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
2056:             RETURN
2057:         ENDIF
2058:         IF EMPTY(loc_cChIni)
2059:             MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2060:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
2061:             RETURN
2062:         ENDIF
2063:         IF EMPTY(loc_cChFin)
2064:             MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2065:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
2066:             RETURN
2067:         ENDIF
2068:         IF loc_cChFin < loc_cChIni
2069:             MsgAviso("Cheque final menor que o inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
2070:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
2071:             RETURN
2072:         ENDIF
2073: 
2074:         TRY
2075:             loc_cSQL = "SELECT bancos, valors, ncheques, datas, emitidos, cancelas, favos " + ;
2076:                        "FROM SigCqChi " + ;
2077:                        "WHERE bancos = " + EscaparSQL(loc_cBanco) + ;
2078:                        " AND ncheques BETWEEN " + EscaparSQL(loc_cChIni) + ;
2079:                        " AND " + EscaparSQL(loc_cChFin) + ;
2080:                        " ORDER BY ncheques"
2081: 
2082:             IF USED("cursor_4c_MatrizTemp")
2083:                 USE IN cursor_4c_MatrizTemp
2084:             ENDIF
2085: 
2086:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizTemp") > 0
2087:                 THIS.this_oBusinessObject.ImprimirChequesMatricial()
2088:                 USE IN cursor_4c_MatrizTemp
2089:             ELSE
2090:                 MsgAviso("Nenhum cheque encontrado na faixa informada.", "Impress" + CHR(227) + "o")
2091:             ENDIF
2092: 
2093:         CATCH TO loc_oErro
2094:             MsgErro(loc_oErro.Message, "Erro ao imprimir matricial")
2095:         ENDTRY
2096:     ENDPROC
2097: 
2098:     *-- Botao Encerrar Matricial: fecha container impchmat e reactiva acoes
2099:     PROCEDURE BtnCancChmatClick()
2100:         THIS.LockScreen = .T.
2101:         THIS.cmg_4c_Acoes.Enabled    = .T.
2102:         THIS.cnt_4c_Impchmat.Enabled  = .F.
2103:         THIS.cnt_4c_Impchmat.Visible  = .F.
2104:         THIS.ExibirCheques(.F.)
2105:         THIS.LockScreen = .F.
2106:     ENDPROC
2107: 
2108:     *-- Botao Procurar (exec no container): busca cheque por banco/agencia/conta/cheque/emissao/valor
2109:     PROCEDURE BtnProcurarExecClick()
2110:         LOCAL loc_oCnt, loc_cCursor
2111:         loc_oCnt    = THIS.cnt_4c_Procurar
2112:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2113: 
2114:         SET NEAR ON
2115: 
2116:         loc_oCnt.txt_4c_BancoP.Value = PADR(ALLTRIM(loc_oCnt.txt_4c_BancoP.Value), 3)
2117: 
2118:         SELECT (loc_cCursor)
2119:         DO CASE
2120:             CASE !EMPTY(loc_oCnt.txt_4c_EmissaoP.Value)
2121:                 SET ORDER TO Emissao
2122:                 SEEK DTOS(loc_oCnt.txt_4c_EmissaoP.Value) + ;
2123:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2124:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2125:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2126:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2127:             CASE !EMPTY(loc_oCnt.txt_4c_ValorP.Value)
2128:                 SET ORDER TO Valor
2129:                 SEEK STR(loc_oCnt.txt_4c_ValorP.Value, 12, 2) + ;
2130:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2131:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2132:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2133:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2134:             OTHERWISE
2135:                 SET ORDER TO Cheque
2136:                 SEEK ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2137:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2138:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2139:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2140:         ENDCASE
2141: 
2142:         SET NEAR OFF
2143: 
2144:         *-- Ocultar container e reativar controles principais
2145:         THIS.txt_4c_CdContas.Enabled   = .T.
2146:         THIS.txt_4c_DsContas.Enabled   = .T.
2147:         THIS.grd_4c_Dados.Enabled      = .T.
2148:         THIS.txt_4c_Favorecido.Enabled = .T.
2149:         THIS.AtualizarBotoesPermissao()
2150:         THIS.cnt_4c_Procurar.Visible   = .F.
2151:         THIS.cnt_4c_Procurar.Enabled   = .F.
2152:         THIS.ExibirCheques(.F.)
2153:     ENDPROC
2154: 
2155:     *-- Botao Encerrar Procurar
2156:     PROCEDURE BtnCancProcurarClick()
2157:         THIS.LockScreen = .T.
2158:         THIS.txt_4c_CdContas.Enabled   = .T.
2159:         THIS.txt_4c_DsContas.Enabled   = .T.
2160:         THIS.grd_4c_Dados.Enabled      = .T.
2161:         THIS.txt_4c_Favorecido.Enabled = .T.
2162:         THIS.AtualizarBotoesPermissao()
2163:         THIS.cnt_4c_Procurar.Visible   = .F.
2164:         THIS.cnt_4c_Procurar.Enabled   = .F.
2165:         THIS.ExibirCheques(.F.)
2166:         THIS.LockScreen = .F.
2167:     ENDPROC
2168: 
2169:     *-- KeyPress no campo Banco do container de impressao matricial (leitor magnetico)
2170:     PROCEDURE TxtBancoImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2171:         *-- CHR(60) = inicio de leitura CMC7 do leitor de cheques
2172:         IF par_nKeyCode = 60
2173:             IF !THIS.this_lPlLeCheque
2174:                 THIS.this_cPcChqLido = ""
2175:             ENDIF
2176:             THIS.this_lPlLeCheque = .T.
2177:         ENDIF
2178:         IF THIS.this_lPlLeCheque
2179:             NODEFAULT
2180:             THIS.this_cPcChqLido = THIS.this_cPcChqLido + CHR(par_nKeyCode)
2181:         ENDIF
2182:         *-- CHR(58) = fim de leitura
2183:         IF par_nKeyCode = 58
2184:             THIS.this_lPlLeCheque = .F.
2185:         ENDIF
2186:     ENDPROC
2187: 
2188:     *-- KeyPress no campo Banco do container Procurar (leitor magnetico)
2189:     PROCEDURE TxtBancoProcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2190:         IF par_nKeyCode = 60
2191:             IF !THIS.this_lPlLeCheque
2192:                 THIS.this_cPcChqLido = ""
2193:             ENDIF
2194:             THIS.this_lPlLeCheque = .T.
2195:         ENDIF
2196:         IF THIS.this_lPlLeCheque
2197:             NODEFAULT
2198:             THIS.this_cPcChqLido = THIS.this_cPcChqLido + CHR(par_nKeyCode)
2199:         ENDIF
2200:         IF par_nKeyCode = 58
2201:             THIS.this_lPlLeCheque = .F.
2202:         ENDIF
2203:     ENDPROC
2204: 
2205:     *-- Valid do campo Banco no Procurar: processa dado do leitor ou TAB
2206:     PROCEDURE TxtBancoProcValid()
2207:         LOCAL loc_oCnt, loc_cLeitor
2208:         loc_oCnt = THIS.cnt_4c_Procurar
2209: 
2210:         IF THIS.this_lPlLeCheque
2211:             loc_cLeitor = THIS.this_cPcChqLido
2212:         ELSE
2213:             loc_cLeitor = ""
2214:         ENDIF
2215: 
2216:         THIS.this_lPlLeitor = .F.
2217: 
2218:         IF LASTKEY() = 9
2219:             KEYBOARD "{CTRL+TAB}"
2220:         ELSE
2221:             THIS.this_lPlLeitor = .T.
2222:             IF LEN(loc_cLeitor) >= 33
2223:                 *-- Decodificar CMC7: banco(2-4), agencia(5-8), conta(23-32), cheque(14-19)
2224:                 loc_oCnt.txt_4c_BancoP.Value   = SUBSTR(loc_cLeitor, 2, 3)
2225:                 loc_oCnt.txt_4c_AgenciaP.Value = SUBSTR(loc_cLeitor, 5, 4)
2226:                 loc_oCnt.txt_4c_ContaP.Value   = SUBSTR(loc_cLeitor, 23, 10)
2227:                 loc_oCnt.txt_4c_ChequeP.Value  = SUBSTR(loc_cLeitor, 14, 6)
2228:                 THIS.Refresh()
2229:             ENDIF
2230:         ENDIF
2231:     ENDPROC
2232: 
2233:     *-- When no campo emissao do Procurar: so habilita se valor estiver vazio
2234:     PROCEDURE TxtEmissaoProcWhen()
2235:         RETURN EMPTY(THIS.cnt_4c_Procurar.txt_4c_ValorP.Value)
2236:     ENDPROC
2237: 
2238:     *-- When no campo valor do Procurar: so habilita se emissao estiver vazia
2239:     PROCEDURE TxtValorProcWhen()
2240:         RETURN EMPTY(THIS.cnt_4c_Procurar.txt_4c_EmissaoP.Value)
2241:     ENDPROC
2242: 
2243:     *-- Valid data inicial: ajustar data final e limpar grid se mudou
2244:     PROCEDURE TxtDtInicialValid()
2245:         IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
2246:             THIS.txt_4c_DtFinal.Value = THIS.txt_4c_DtInicial.Value
2247:         ENDIF
2248:         IF THIS.txt_4c_DtInicial.Value != THIS.this_dAntDtIni
2249:             LOCAL loc_cCursor
2250:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2251:             IF USED(loc_cCursor)
2252:                 ZAP IN (loc_cCursor)
2253:                 THIS.grd_4c_Dados.Refresh()
2254:             ENDIF
2255:         ENDIF
2256:         THIS.this_dAntDtIni = THIS.txt_4c_DtInicial.Value
2257:     ENDPROC
2258: 
2259:     *-- Valid data final: ajustar data inicial e limpar grid se mudou
2260:     PROCEDURE TxtDtFinalValid()
2261:         IF THIS.txt_4c_DtFinal.Value < THIS.txt_4c_DtInicial.Value
2262:             THIS.txt_4c_DtInicial.Value = THIS.txt_4c_DtFinal.Value
2263:         ENDIF
2264:         IF THIS.txt_4c_DtFinal.Value != THIS.this_dAntDtFin
2265:             LOCAL loc_cCursor
2266:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2267:             IF USED(loc_cCursor)
2268:                 ZAP IN (loc_cCursor)
2269:                 THIS.grd_4c_Dados.Refresh()
2270:             ENDIF
2271:         ENDIF
2272:         THIS.this_dAntDtFin = THIS.txt_4c_DtFinal.Value
2273:     ENDPROC
2274: 
2275:     *-- KeyPress no codigo do grupo: F4/Enter/Tab abre lookup de grupos contabeis
2276:     PROCEDURE TxtCdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2277:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2278:             RETURN
2279:         ENDIF
2280:         LOCAL loc_cVal, loc_oForm, loc_cSQL
2281:         loc_cVal = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2282: 
2283:         IF !EMPTY(loc_cVal)
2284:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(codigos) = " + ;
2285:                        EscaparSQL(loc_cVal)
2286:             IF USED("cursor_4c_GrupoOk")
2287:                 USE IN cursor_4c_GrupoOk
2288:             ENDIF
2289:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOk") > 0
2290:                 SELECT cursor_4c_GrupoOk
2291:                 GO TOP
2292:                 IF !EOF("cursor_4c_GrupoOk")
2293:                     THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.codigos)
2294:                     THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.descrs)
2295:                     THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(cursor_4c_GrupoOk.codigos)
2296:                     USE IN cursor_4c_GrupoOk
2297:                     IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2298:                         ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2299:                         THIS.grd_4c_Dados.Refresh()
2300:                     ENDIF
2301:                     THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2302:                     RETURN
2303:                 ENDIF
2304:                 USE IN cursor_4c_GrupoOk
2305:             ENDIF
2306:         ELSE
2307:             THIS.txt_4c_DsGrupos.Value = ""
2308:             THIS.this_oBusinessObject.this_cCdGrupos = ""
2309:             IF THIS.this_cAntCdGrupo != ""
2310:                 ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2311:                 THIS.grd_4c_Dados.Refresh()
2312:             ENDIF
2313:             THIS.this_cAntCdGrupo = ""
2314:             RETURN
2315:         ENDIF
2316: 
2317:         *-- Nao encontrado: abrir picker
2318:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2319:                     "SigCdGcr", "cursor_4c_GrupoLookup", ;
2320:                     "codigos", loc_cVal, ;
2321:                     "Grupos Cont" + CHR(225) + "beis", .T., .T., "")
2322:         IF VARTYPE(loc_oForm) = "O"
2323:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2324:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2325:             loc_oForm.Show()
2326:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2327:                 SELECT cursor_4c_GrupoLookup
2328:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2329:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2330:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2331:             ENDIF
2332:         ENDIF
2333:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2334:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2335:             THIS.grd_4c_Dados.Refresh()
2336:         ENDIF
2337:         THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2338:     ENDPROC
2339: 
2340:     *-- KeyPress na descricao do grupo: F4/Enter/Tab abre lookup por descricao
2341:     PROCEDURE TxtDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2342:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2343:             RETURN
2344:         ENDIF
2345:         LOCAL loc_cVal, loc_oForm
2346:         loc_cVal = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2347: 
2348:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2349:                     "SigCdGcr", "cursor_4c_GrupoLookup", ;
2350:                     "descrs", loc_cVal, ;
2351:                     "Grupos Cont" + CHR(225) + "beis", .T., .T., "")
2352:         IF VARTYPE(loc_oForm) = "O"
2353:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2354:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2355:             loc_oForm.Show()
2356:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2357:                 SELECT cursor_4c_GrupoLookup
2358:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2359:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2360:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2361:             ENDIF
2362:         ENDIF
2363:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntDsGrupo
2364:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2365:             THIS.grd_4c_Dados.Refresh()
2366:         ENDIF
2367:         THIS.this_cAntDsGrupo = THIS.txt_4c_CdGrupos.Value
2368:     ENDPROC
2369: 
2370:     *-- KeyPress no codigo da conta: F4/Enter/Tab abre lookup de contas
2371:     PROCEDURE TxtCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2372:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2373:             RETURN
2374:         ENDIF
2375:         LOCAL loc_cVal, loc_oForm, loc_cSQL
2376:         loc_cVal = ALLTRIM(THIS.txt_4c_CdContas.Value)
2377: 
2378:         IF !EMPTY(loc_cVal)
2379:             IF USED("cursor_4c_Contas") AND SEEK(loc_cVal, "cursor_4c_Contas", "IClis")
2380:                 SELECT cursor_4c_Contas
2381:                 THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2382:                 THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2383:                 THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2384:                 IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2385:                     ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2386:                     THIS.grd_4c_Dados.Refresh()
2387:                 ENDIF
2388:                 THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2389:                 RETURN
2390:             ENDIF
2391:         ELSE
2392:             THIS.txt_4c_DsContas.Value = ""
2393:             THIS.this_oBusinessObject.this_cCdContas = ""
2394:             IF THIS.this_cAntCdConta != ""
2395:                 ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2396:                 THIS.grd_4c_Dados.Refresh()
2397:             ENDIF
2398:             THIS.this_cAntCdConta = ""
2399:             RETURN
2400:         ENDIF
2401: 
2402:         *-- Nao encontrado: abrir picker usando SQLEXEC LIKE no cursor_4c_ContasLookup
2403:         THIS.AbrirLookupContas(loc_cVal, "C")
2404:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2405:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2406:             THIS.grd_4c_Dados.Refresh()
2407:         ENDIF
2408:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2409:     ENDPROC
2410: 
2411:     *-- KeyPress na descricao da conta: F4/Enter/Tab abre lookup por nome
2412:     PROCEDURE TxtDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2413:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2414:             RETURN
2415:         ENDIF
2416:         LOCAL loc_cVal
2417:         loc_cVal = ALLTRIM(THIS.txt_4c_DsContas.Value)
2418: 
2419:         THIS.AbrirLookupContas(loc_cVal, "D")
2420:         IF THIS.txt_4c_DsContas.Value != THIS.this_cAntDsConta
2421:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2422:             THIS.grd_4c_Dados.Refresh()
2423:         ENDIF
2424:         THIS.this_cAntDsConta = THIS.txt_4c_DsContas.Value
2425:     ENDPROC
2426: 
2427:     *-- AbrirLookupContas - Abre picker de contas bancarias via FormBuscaAuxiliar com Init params
2428:     *   par_cVal: valor digitado pelo usuario (prefixo para LIKE)
2429:     *   par_cModo: "C" busca por codigo (IClis), "D" busca por descricao (RClis)
2430:     PROCEDURE AbrirLookupContas(par_cVal, par_cModo)
2431:         LOCAL loc_cSQL, loc_cCampo, loc_oForm, loc_cGrupo
2432: 
2433:         loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2434: 
2435:         IF par_cModo = "C"
2436:             loc_cCampo = "IClis"
2437:             IF EMPTY(par_cVal)
2438:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2439:             ELSE
2440:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2441:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2442:             ENDIF
2443:         ELSE
2444:             loc_cCampo = "RClis"
2445:             IF EMPTY(par_cVal)
2446:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2447:             ELSE
2448:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2449:                            "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2450:             ENDIF
2451:         ENDIF
2452: 
2453:         IF !EMPTY(loc_cGrupo)
2454:             IF EMPTY(par_cVal)
2455:                 loc_cSQL = loc_cSQL + " WHERE RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2456:             ELSE
2457:                 loc_cSQL = loc_cSQL + " AND RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2458:             ENDIF
2459:         ENDIF
2460: 
2461:         loc_cSQL = loc_cSQL + " ORDER BY IClis"
2462: 
2463:         IF USED("cursor_4c_ContasLookup")
2464:             USE IN cursor_4c_ContasLookup
2465:         ENDIF
2466: 
2467:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasLookup") < 1
2468:             RETURN
2469:         ENDIF
2470: 
2471:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2472:                     "", "cursor_4c_ContasLookup", ;
2473:                     loc_cCampo, ALLTRIM(par_cVal), ;
2474:                     "Contas", .T., .T., "")
2475:         IF VARTYPE(loc_oForm) != "O"
2476:             RETURN
2477:         ENDIF
2478: 
2479:         loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2480:         loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
2481:         loc_oForm.Show()
2482: 
2483:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ContasLookup")
2484:             SELECT cursor_4c_ContasLookup
2485:             THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2486:             THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2487:             THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2488:         ENDIF
2489: 
2490:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2491:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2492:             THIS.grd_4c_Dados.Refresh()
2493:         ENDIF
2494:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2495:     ENDPROC
2496: 
2497:     *-- LostFocus do txt_4c_Chfin: padroniza para 6 digitos com zeros a esquerda
2498:     PROCEDURE TxtChfinLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2499:         IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)
2500:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ;
2501:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
2502:         ENDIF
2503:     ENDPROC
2504: 
2505:     *-- LostFocus do txt_4c_Chini: padroniza para 6 digitos com zeros a esquerda
2506:     PROCEDURE TxtChiniLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2507:         IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
2508:             THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ;
2509:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
2510:         ENDIF
2511:     ENDPROC
2512: 
2513:     *==========================================================================
2514:     * --- ALIASES DE COMPATIBILIDADE COM PIPELINE MULTI-FASE ---
2515:     * OPERACIONAL nao tem Page1/Page2 CRUD; estes metodos existem para que
2516:     * o validador do pipeline encontre as assinaturas esperadas.
2517:     *==========================================================================
2518: 
2519:     *-- CarregarLista: alias de MontarCheques (pipeline exige este nome)
2520:     PROCEDURE CarregarLista()
2521:         RETURN THIS.MontarCheques(.F.)
2522:     ENDPROC
2523: 
2524:     *-- FormParaBO: sincroniza filtros da UI para o BO antes de processar
2525:     PROCEDURE FormParaBO()
2526:         THIS.this_oBusinessObject.this_cCdGrupos  = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2527:         THIS.this_oBusinessObject.this_cDsGrupos  = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2528:         THIS.this_oBusinessObject.this_cCdContas  = ALLTRIM(THIS.txt_4c_CdContas.Value)
2529:         THIS.this_oBusinessObject.this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
2530:         THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
2531:         THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
2532:     ENDPROC
2533: 
2534:     *-- BOParaForm: alias de ExibirCheques (pipeline exige este nome)
2535:     PROCEDURE BOParaForm()
2536:         THIS.ExibirCheques(.F.)
2537:     ENDPROC
2538: 
2539:     *-- BtnSalvarClick: alias de BtnProcessarClick (mapeamento OPERACIONAL)
2540:     PROCEDURE BtnSalvarClick()
2541:         THIS.BtnProcessarClick()
2542:     ENDPROC
2543: 
2544:     *-- BtnCancelarClick: alias de BtnEncerrarClick (mapeamento OPERACIONAL)
2545:     PROCEDURE BtnCancelarClick()
2546:         THIS.BtnEncerrarClick()
2547:     ENDPROC
2548: 
2549:     *-- HabilitarCampos: stub N/A (OPERACIONAL gerencia habilitacao via AtualizarBotoesLinhaCorrente)
2550:     PROCEDURE HabilitarCampos(par_lHabilitar)
2551:         IF VARTYPE(THIS.txt_4c_CdGrupos) = "O"
2552:             THIS.txt_4c_CdGrupos.Enabled  = par_lHabilitar
2553:             THIS.txt_4c_DsGrupos.Enabled  = par_lHabilitar
2554:             THIS.txt_4c_CdContas.Enabled  = par_lHabilitar
2555:             THIS.txt_4c_DsContas.Enabled  = par_lHabilitar
2556:             THIS.txt_4c_DtInicial.Enabled = par_lHabilitar
2557:             THIS.txt_4c_DtFinal.Enabled   = par_lHabilitar
2558:         ENDIF
2559:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
2560:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
2561:         ENDIF
2562:     ENDPROC
2563: 
2564:     *-- BtnIncluirClick: stub N/A - OPERACIONAL nao tem modo INCLUIR
2565:     PROCEDURE BtnIncluirClick()
2566:         THIS.BtnDocumentoClick()
2567:     ENDPROC
2568: 
2569:     *-- BtnAlterarClick: stub N/A - OPERACIONAL nao tem modo ALTERAR
2570:     PROCEDURE BtnAlterarClick()
2571:         THIS.BtnDocumentoClick()
2572:     ENDPROC
2573: 
2574:     *-- BtnVisualizarClick: alias de BtnImprimirClick (visualizacao do cheque via FormSigReEch)
2575:     PROCEDURE BtnVisualizarClick()
2576:         THIS.BtnImprimirClick()
2577:     ENDPROC
2578: 
2579:     *-- BtnExcluirClick: alias de BtnExcluirChqClick (exclusao do cheque cancelado)
2580:     PROCEDURE BtnExcluirClick()
2581:         THIS.BtnExcluirChqClick()
2582:     ENDPROC
2583: 
2584:     *-- BtnBuscarClick: alias de BtnProcurarClick (mapeamento OPERACIONAL)
2585:     PROCEDURE BtnBuscarClick()
2586:         THIS.BtnProcurarClick()
2587:     ENDPROC
2588: 
2589:     *-- LimparCampos: reseta campos de filtro da UI (OPERACIONAL: limpa filtros, nao campos de dados)
2590:     PROCEDURE LimparCampos()
2591:         THIS.txt_4c_CdGrupos.Value  = ""
2592:         THIS.txt_4c_DsGrupos.Value  = ""
2593:         THIS.txt_4c_CdContas.Value  = ""
2594:         THIS.txt_4c_DsContas.Value  = ""
2595:         THIS.txt_4c_DtInicial.Value = DATE()
2596:         THIS.txt_4c_DtFinal.Value   = DATE()
2597:         THIS.txt_4c_Favorecido.Value = ""
2598:         THIS.this_cAntCdGrupo = ""
2599:         THIS.this_cAntDsGrupo = ""
2600:         THIS.this_cAntCdConta = ""
2601:         THIS.this_cAntDsConta = ""
2602:         THIS.this_dAntDtIni   = {}
2603:         THIS.this_dAntDtFin   = {}
2604:         THIS.this_oBusinessObject.this_cCdGrupos  = ""
2605:         THIS.this_oBusinessObject.this_cDsGrupos  = ""
2606:         THIS.this_oBusinessObject.this_cCdContas  = ""
2607:         THIS.this_oBusinessObject.this_cDsContas  = ""
2608:         THIS.this_oBusinessObject.this_dDtInicial = DATE()
2609:         THIS.this_oBusinessObject.this_dDtFinal   = DATE()
2610:     ENDPROC
2611: 
2612:     *-- AjustarBotoesPorModo: stub N/A (OPERACIONAL nao tem ciclo INCLUIR/ALTERAR/VISUALIZAR)
2613:     PROCEDURE AjustarBotoesPorModo()
2614:         THIS.AtualizarBotoesPermissao()
2615:         THIS.AtualizarBotoesLinhaCorrente()
2616:     ENDPROC
2617: 
2618:     *==========================================================================
2619:     PROCEDURE Destroy
2620:     *==========================================================================
2621:         IF USED("cursor_4c_Pgr")
2622:             USE IN cursor_4c_Pgr
2623:         ENDIF
2624:         IF USED("cursor_4c_MatrizTemp")
2625:             USE IN cursor_4c_MatrizTemp
2626:         ENDIF
2627:         IF USED("cursor_4c_ImpTemp")
2628:             USE IN cursor_4c_ImpTemp
2629:         ENDIF
2630:         IF USED("cursor_4c_GrupoOk")
2631:             USE IN cursor_4c_GrupoOk
2632:         ENDIF
2633:         IF USED("cursor_4c_GrupoLookup")
2634:             USE IN cursor_4c_GrupoLookup
2635:         ENDIF
2636:         IF USED("cursor_4c_ContasLookup")
2637:             USE IN cursor_4c_ContasLookup
2638:         ENDIF
2639:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2640:             THIS.this_oBusinessObject = .NULL.
2641:         ENDIF
2642:         DODEFAULT()
2643:     ENDPROC
2644: 
2645: ENDDEFINE

