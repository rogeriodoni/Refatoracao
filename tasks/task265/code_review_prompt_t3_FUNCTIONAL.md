# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_IMPCHMAT, CNT_4C_PROCURAR. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2643 linhas total):

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
867:                 .FontName       = "Tahoma"
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

*-- Linhas 1442 a 2643:
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
1665:         LOCAL loc_oControl
1666:         FOR EACH loc_oControl IN THIS.Controls
1667:             IF VARTYPE(loc_oControl) != "O"
1668:                 LOOP
1669:             ENDIF
1670:             *-- Containers flutuantes ficam Visible=.F. por default (toggled pelos botoes)
1671:             IF INLIST(UPPER(loc_oControl.Name), ;
1672:                       "CNT_4C_SOMBRA", ;
1673:                       "CNT_4C_JUSTIFICATIVA", ;
1674:                       "CNT_4C_IMPCHMAT", ;
1675:                       "CNT_4C_PROCURAR")
1676:                 *-- Recursar dentro para tornar filhos visiveis sem mudar o proprio container
1677:                 THIS.TornarSubControlesVisiveis(loc_oControl)
1678:                 LOOP
1679:             ENDIF
1680:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1681:                 loc_oControl.Visible = .T.
1682:             ENDIF
1683:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1684:                 THIS.TornarSubControlesVisiveis(loc_oControl)
1685:             ENDIF
1686:         ENDFOR
1687:     ENDPROC
1688: 
1689:     *==========================================================================
1690:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
1691:     *==========================================================================
1692:         LOCAL loc_oControl
1693:         FOR EACH loc_oControl IN par_oContainer.Controls
1694:             IF VARTYPE(loc_oControl) != "O"
1695:                 LOOP
1696:             ENDIF
1697:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1698:                 loc_oControl.Visible = .T.
1699:             ENDIF
1700:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1701:                 THIS.TornarSubControlesVisiveis(loc_oControl)
1702:             ENDIF
1703:         ENDFOR
1704:     ENDPROC
1705: 
1706:     *==========================================================================
1707:     * --- HANDLERS DE EVENTOS ---
1708:     *==========================================================================
1709: 
1710:     *-- Grid AfterRowColChange: atualiza painel inferior ao navegar
1711:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
1712:         THIS.LockScreen = .T.
1713:         THIS.AtualizarBotoesLinhaCorrente()
1714:         THIS.LockScreen = .F.
1715:     ENDPROC
1716: 
1717:     *-- Grid Checkbox KeyPress: toggle de selecao via ENTER ou SPACE
1718:     PROCEDURE GrdChkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1719:         LOCAL loc_cCursor, loc_cChave, loc_nRecno
1720:         IF INLIST(par_nKeyCode, 13, 32)
1721:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1722:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1723:                 SELECT (loc_cCursor)
1724:                 loc_nRecno = RECNO()
1725:                 loc_cChave = ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques)
1726:                 UPDATE (loc_cCursor) SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
1727:                     WHERE ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques) = m.loc_cChave ;
1728:                     AND NEmitidos = 0 AND NCancelas = 0
1729:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1730:                     GOTO loc_nRecno IN (loc_cCursor)
1731:                 ENDIF
1732:                 THIS.grd_4c_Dados.Refresh()
1733:             ENDIF
1734:             NODEFAULT
1735:         ENDIF
1736:     ENDPROC
1737: 
1738:     *-- Grid Checkbox MouseDown: delegar para KeyPress com SPACE
1739:     PROCEDURE GrdChkMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1740:         THIS.GrdChkKeyPress(32, 0)
1741:         NODEFAULT
1742:     ENDPROC
1743: 
1744:     *-- Header NCopias Click: reordenar por NCopias (sem conta filtrada)
1745:     PROCEDURE GrdHeaderNCopias()
1746:         LOCAL loc_cCursor
1747:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1748:         IF EMPTY(THIS.txt_4c_CdContas.Value) AND UPPER(ORDER(loc_cCursor)) != "NCOPIAS"
1749:             THIS.ExibirCheques(.F.)
1750:         ENDIF
1751:     ENDPROC
1752: 
1753:     *-- Botao Processar: valida periodo e dispara MontarCheques
1754:     PROCEDURE BtnProcessarClick()
1755:         IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
1756:             MsgAviso("Data Final menor que Data Inicial !!!", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
1757:             THIS.txt_4c_DtInicial.SetFocus()
1758:             RETURN
1759:         ENDIF
1760:         THIS.MontarCheques(.F.)
1761:     ENDPROC
1762: 
1763:     *-- Botao SelTudo: marca todos os cheques nao-emitidos nao-cancelados
1764:     PROCEDURE BtnSelTudoClick()
1765:         LOCAL loc_cCursor, loc_nRecno
1766:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1767:         IF USED(loc_cCursor)
1768:             SELECT (loc_cCursor)
1769:             loc_nRecno = RECNO()
1770:             UPDATE (loc_cCursor) SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
1771:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1772:                 GOTO loc_nRecno IN (loc_cCursor)
1773:             ENDIF
1774:             THIS.grd_4c_Dados.Refresh()
1775:         ENDIF
1776:     ENDPROC
1777: 
1778:     *-- Botao Apaga: desmarca todos os cheques selecionados
1779:     PROCEDURE BtnApagaClick()
1780:         LOCAL loc_cCursor, loc_nRecno
1781:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1782:         IF USED(loc_cCursor)
1783:             SELECT (loc_cCursor)
1784:             loc_nRecno = RECNO()
1785:             UPDATE (loc_cCursor) SET NMarca1s = 0 WHERE NMarca1s = 1
1786:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1787:                 GOTO loc_nRecno IN (loc_cCursor)
1788:             ENDIF
1789:             THIS.grd_4c_Dados.Refresh()
1790:         ENDIF
1791:     ENDPROC
1792: 
1793:     *-- Botao Encerrar
1794:     PROCEDURE BtnEncerrarClick()
1795:         THIS.Release()
1796:     ENDPROC
1797: 
1798:     *-- Botao Documento: abre SigCdPgr para o cheque corrente
1799:     PROCEDURE BtnDocumentoClick()
1800:         LOCAL loc_lCarregou, loc_nRecno, loc_cCursor
1801:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1802: 
1803:         THIS.LockScreen = .T.
1804:         loc_nRecno = RECNO(loc_cCursor)
1805: 
1806:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1807:             SELECT (loc_cCursor)
1808:             DO FORM SigCdPgr WITH ;
1809:                 LEFT(ALLTRIM(Dopes), 1), .T., ;
1810:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1811:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1812:                 GOTO loc_nRecno IN (loc_cCursor)
1813:             ENDIF
1814:             THIS.ExibirCheques(.F.)
1815:         ENDIF
1816: 
1817:         THIS.LockScreen = .F.
1818:     ENDPROC
1819: 
1820:     *-- Botao Imprimir: abre FormSigReEch para visualizar/imprimir o cheque corrente
1821:     PROCEDURE BtnImprimirClick()
1822:         LOCAL loc_lCarregou, loc_cCursor
1823:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1824: 
1825:         IF !USED(loc_cCursor) OR EOF(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1826:             MsgAviso("Nenhum cheque selecionado para visualizar.", "Imprimir")
1827:             RETURN
1828:         ENDIF
1829: 
1830:         IF THIS.CarregarConta()
1831:             SELECT (loc_cCursor)
1832:             DO FORM FormSigReEch WITH ;
1833:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes, "CONSULTAR", ALLTRIM(NCheques)
1834:             THIS.ExibirCheques(.F.)
1835:         ENDIF
1836:     ENDPROC
1837: 
1838:     *-- Botao Recibo: abre SigRerec para o cheque corrente
1839:     PROCEDURE BtnReciboClick()
1840:         LOCAL loc_lCarregou
1841:         IF THIS.CarregarConta()
1842:             DO FORM SigRerec WITH THIS, "RECIBO"
1843:         ENDIF
1844:     ENDPROC
1845: 
1846:     *-- Botao Excluir Documento
1847:     PROCEDURE BtnExcluiDocClick()
1848:         LOCAL loc_nRecno, loc_cCursor, loc_lCarregou
1849:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1850: 
1851:         THIS.LockScreen = .T.
1852:         loc_nRecno = RECNO(loc_cCursor)
1853: 
1854:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1855:             SELECT (loc_cCursor)
1856:             DO FORM SigCdPgr WITH ;
1857:                 LEFT(ALLTRIM(Dopes), 1), .F., ;
1858:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1859:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1860:                 GOTO loc_nRecno IN (loc_cCursor)
1861:             ENDIF
1862:             THIS.ExibirCheques(.F.)
1863:         ENDIF
1864: 
1865:         THIS.LockScreen = .F.
1866:     ENDPROC
1867: 
1868:     *-- Botao Cheque: imprime fisicamente cheques marcados em impressora de cheque
1869:     PROCEDURE BtnImpchqClick()
1870:         LOCAL loc_cCursor, loc_oErro, loc_cBancos
1871:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1872: 
1873:         IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1874:             MsgAviso("Nenhum cheque dispon" + CHR(237) + "vel.", "Cheque")
1875:             RETURN
1876:         ENDIF
1877: 
1878:         TRY
1879:             IF USED("cursor_4c_TmpBanco")
1880:                 USE IN cursor_4c_TmpBanco
1881:             ENDIF
1882: 
1883:             SELECT DISTINCT Bancos FROM (loc_cCursor) WHERE NMarca1s = 1 ;
1884:               INTO CURSOR cursor_4c_TmpBanco
1885: 
1886:             SELECT cursor_4c_TmpBanco
1887:             GO TOP
1888:             IF EOF("cursor_4c_TmpBanco")
1889:                 MsgAviso("Nenhum cheque selecionado para impress" + CHR(227) + "o.", "Cheque")
1890:                 USE IN cursor_4c_TmpBanco
1891:                 RETURN
1892:             ENDIF
1893: 
1894:             IF RECCOUNT("cursor_4c_TmpBanco") > 1
1895:                 MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", ;
1896:                     "Aten" + CHR(231) + CHR(227) + "o")
1897:                 USE IN cursor_4c_TmpBanco
1898:                 RETURN
1899:             ENDIF
1900: 
1901:             loc_cBancos = ALLTRIM(cursor_4c_TmpBanco.Bancos)
1902:             USE IN cursor_4c_TmpBanco
1903: 
1904:             IF USED("cursor_4c_ImpTemp")
1905:                 USE IN cursor_4c_ImpTemp
1906:             ENDIF
1907: 
1908:             SELECT Bancos, Agencias, NContas, NCheques, cIdChaves, ;
1909:                    Valors, Datas, NEmitidos, NCancelas, Favos ;
1910:               FROM (loc_cCursor) ;
1911:              WHERE NMarca1s = 1 ;
1912:              ORDER BY Bancos, NCheques ;
1913:               INTO CURSOR cursor_4c_ImpTemp READWRITE
1914: 
1915:             THIS.this_oBusinessObject.ImprimirCheques(loc_cBancos)
1916: 
1917:             IF USED("cursor_4c_ImpTemp")
1918:                 USE IN cursor_4c_ImpTemp
1919:             ENDIF
1920: 
1921:             THIS.ExibirCheques(.F.)
1922: 
1923:         CATCH TO loc_oErro
1924:             MsgErro(loc_oErro.Message, "Erro ao imprimir cheque")
1925:         ENDTRY
1926:     ENDPROC
1927: 
1928:     *-- Botao Chq. Matric.: activa container de impressao matricial
1929:     PROCEDURE BtnChmatClick()
1930:         THIS.this_lChMatIni = .T.
1931:         WITH THIS.cnt_4c_Impchmat
1932:             .Enabled = .T.
1933:             .Visible = .T.
1934:             .txt_4c_Banco.Value = ""
1935:             .txt_4c_Chini.Value = ""
1936:             .txt_4c_Chfin.Value = ""
1937:             .txt_4c_Banco.SetFocus()
1938:         ENDWITH
1939:         THIS.cmg_4c_Acoes.Enabled = .F.
1940:         THIS.Refresh()
1941:     ENDPROC
1942: 
1943:     *-- Botao Excluir Cheque: confirma e exclui cheque cancelado
1944:     PROCEDURE BtnExcluirChqClick()
1945:         LOCAL loc_cCursor, loc_cSQL, loc_nOk, loc_cMensa, loc_oErro
1946:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1947: 
1948:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
1949:             RETURN
1950:         ENDIF
1951: 
1952:         SELECT (loc_cCursor)
1953:         IF NCancelas = 1 AND THIS.this_lExcluirCheque
1954:             IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
1955:                            ALLTRIM(Bancos) + " / " + ALLTRIM(Agencias) + ;
1956:                            " / " + ALLTRIM(Ncontas) + " / " + ALLTRIM(Ncheques) + " ?")
1957:                 TRY
1958:                     loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(Cidchaves))
1959:                     IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1960:                         loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado : " + ;
1961:                                      ALLTRIM(Bancos) + "/" + ALLTRIM(Agencias) + ;
1962:                                      "/" + ALLTRIM(Ncontas) + "/" + ALLTRIM(Ncheques)
1963:                         THIS.this_oBusinessObject.RegistrarAuditoria("DELETE")
1964:                     ELSE
1965:                         MsgErro("Falha ao excluir cheque.", "Erro")
1966:                     ENDIF
1967:                 CATCH TO loc_oErro
1968:                     MsgErro(loc_oErro.Message, "Erro")
1969:                 ENDTRY
1970:                 THIS.ExibirCheques(.F.)
1971:             ENDIF
1972:         ENDIF
1973:     ENDPROC
1974: 
1975:     *-- Botao Procurar: activa container de busca de cheque
1976:     PROCEDURE BtnProcurarClick()
1977:         THIS.this_lPlInicio = .T.
1978:         WITH THIS.cnt_4c_Procurar
1979:             .Visible = .T.
1980:             .Enabled = .T.
1981:             .txt_4c_BancoP.SetFocus()
1982:         ENDWITH
1983:         WITH THIS.cmg_4c_Acoes
1984:             .Buttons(1).Enabled = .F.
1985:             .Buttons(2).Enabled = .F.
1986:             .Buttons(3).Enabled = .F.
1987:             .Buttons(4).Enabled = .F.
1988:             .Buttons(5).Enabled = .F.
1989:             .Buttons(6).Enabled = .F.
1990:         ENDWITH
1991:         THIS.txt_4c_CdContas.Enabled   = .F.
1992:         THIS.txt_4c_DsContas.Enabled   = .F.
1993:         THIS.grd_4c_Dados.Enabled      = .F.
1994:         THIS.txt_4c_Favorecido.Enabled = .F.
1995:         THIS.Refresh()
1996:     ENDPROC
1997: 
1998:     *-- Botao Confirmar Justificativa: cancela cheque com justificativa
1999:     PROCEDURE BtnConfJustClick()
2000:         LOCAL loc_nRecno, loc_cCursor, loc_cJust, loc_lCarregou, loc_oErro
2001: 
2002:         IF EMPTY(THIS.cnt_4c_Justificativa.txt_4c_Justificativa.Value)
2003:             MsgAviso("Aten" + CHR(231) + CHR(227) + "o, justificativa em Branco", "")
2004:             THIS.cnt_4c_Justificativa.txt_4c_Justificativa.SetFocus()
2005:             RETURN
2006:         ENDIF
2007: 
2008:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2009:         THIS.LockScreen = .T.
2010:         loc_nRecno = RECNO(loc_cCursor)
2011: 
2012:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
2013:             TRY
2014:                 SELECT (loc_cCursor)
2015:                 THIS.Enabled = .F.
2016:                 DO FORM SigCdPgr WITH ;
2017:                     LEFT(ALLTRIM(Dopes), 1), .F., ;
2018:                     ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
2019:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2020:                     GOTO loc_nRecno IN (loc_cCursor)
2021:                 ENDIF
2022:                 THIS.ExibirCheques(.F.)
2023:                 THIS.Enabled = .T.
2024:                 THIS.cnt_4c_Justificativa.Visible = .F.
2025:             CATCH TO loc_oErro
2026:                 THIS.Enabled = .T.
2027:                 MsgErro(loc_oErro.Message, "Erro")
2028:             ENDTRY
2029:         ENDIF
2030: 
2031:         THIS.LockScreen = .F.
2032:     ENDPROC
2033: 
2034:     *-- Botao Cancelar Justificativa
2035:     PROCEDURE BtnCancJustClick()
2036:         THIS.cnt_4c_Justificativa.Enabled = .F.
2037:         THIS.cnt_4c_Justificativa.Visible = .F.
2038:     ENDPROC
2039: 
2040:     *-- Botao Imprimir Matricial: imprime cheques por faixa (impchmat)
2041:     PROCEDURE BtnImpChmatClick()
2042:         LOCAL loc_cBanco, loc_cChIni, loc_cChFin, loc_cSQL, loc_oErro
2043: 
2044:         WITH THIS.cnt_4c_Impchmat
2045:             loc_cBanco = ALLTRIM(.txt_4c_Banco.Value)
2046:             loc_cChIni = ALLTRIM(.txt_4c_Chini.Value)
2047:             loc_cChFin = ALLTRIM(.txt_4c_Chfin.Value)
2048:             .Visible     = .T.
2049:         ENDWITH
2050: 
2051:         IF EMPTY(loc_cBanco)
2052:             MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2053:             THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
2054:             RETURN
2055:         ENDIF
2056:         IF EMPTY(loc_cChIni)
2057:             MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2058:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
2059:             RETURN
2060:         ENDIF
2061:         IF EMPTY(loc_cChFin)
2062:             MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2063:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
2064:             RETURN
2065:         ENDIF
2066:         IF loc_cChFin < loc_cChIni
2067:             MsgAviso("Cheque final menor que o inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
2068:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
2069:             RETURN
2070:         ENDIF
2071: 
2072:         TRY
2073:             loc_cSQL = "SELECT bancos, valors, ncheques, datas, emitidos, cancelas, favos " + ;
2074:                        "FROM SigCqChi " + ;
2075:                        "WHERE bancos = " + EscaparSQL(loc_cBanco) + ;
2076:                        " AND ncheques BETWEEN " + EscaparSQL(loc_cChIni) + ;
2077:                        " AND " + EscaparSQL(loc_cChFin) + ;
2078:                        " ORDER BY ncheques"
2079: 
2080:             IF USED("cursor_4c_MatrizTemp")
2081:                 USE IN cursor_4c_MatrizTemp
2082:             ENDIF
2083: 
2084:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizTemp") > 0
2085:                 THIS.this_oBusinessObject.ImprimirChequesMatricial()
2086:                 USE IN cursor_4c_MatrizTemp
2087:             ELSE
2088:                 MsgAviso("Nenhum cheque encontrado na faixa informada.", "Impress" + CHR(227) + "o")
2089:             ENDIF
2090: 
2091:         CATCH TO loc_oErro
2092:             MsgErro(loc_oErro.Message, "Erro ao imprimir matricial")
2093:         ENDTRY
2094:     ENDPROC
2095: 
2096:     *-- Botao Encerrar Matricial: fecha container impchmat e reactiva acoes
2097:     PROCEDURE BtnCancChmatClick()
2098:         THIS.LockScreen = .T.
2099:         THIS.cmg_4c_Acoes.Enabled    = .T.
2100:         THIS.cnt_4c_Impchmat.Enabled  = .F.
2101:         THIS.cnt_4c_Impchmat.Visible  = .F.
2102:         THIS.ExibirCheques(.F.)
2103:         THIS.LockScreen = .F.
2104:     ENDPROC
2105: 
2106:     *-- Botao Procurar (exec no container): busca cheque por banco/agencia/conta/cheque/emissao/valor
2107:     PROCEDURE BtnProcurarExecClick()
2108:         LOCAL loc_oCnt, loc_cCursor
2109:         loc_oCnt    = THIS.cnt_4c_Procurar
2110:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2111: 
2112:         SET NEAR ON
2113: 
2114:         loc_oCnt.txt_4c_BancoP.Value = PADR(ALLTRIM(loc_oCnt.txt_4c_BancoP.Value), 3)
2115: 
2116:         SELECT (loc_cCursor)
2117:         DO CASE
2118:             CASE !EMPTY(loc_oCnt.txt_4c_EmissaoP.Value)
2119:                 SET ORDER TO Emissao
2120:                 SEEK DTOS(loc_oCnt.txt_4c_EmissaoP.Value) + ;
2121:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2122:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2123:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2124:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2125:             CASE !EMPTY(loc_oCnt.txt_4c_ValorP.Value)
2126:                 SET ORDER TO Valor
2127:                 SEEK STR(loc_oCnt.txt_4c_ValorP.Value, 12, 2) + ;
2128:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2129:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2130:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2131:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2132:             OTHERWISE
2133:                 SET ORDER TO Cheque
2134:                 SEEK ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2135:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2136:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2137:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2138:         ENDCASE
2139: 
2140:         SET NEAR OFF
2141: 
2142:         *-- Ocultar container e reativar controles principais
2143:         THIS.txt_4c_CdContas.Enabled   = .T.
2144:         THIS.txt_4c_DsContas.Enabled   = .T.
2145:         THIS.grd_4c_Dados.Enabled      = .T.
2146:         THIS.txt_4c_Favorecido.Enabled = .T.
2147:         THIS.AtualizarBotoesPermissao()
2148:         THIS.cnt_4c_Procurar.Visible   = .F.
2149:         THIS.cnt_4c_Procurar.Enabled   = .F.
2150:         THIS.ExibirCheques(.F.)
2151:     ENDPROC
2152: 
2153:     *-- Botao Encerrar Procurar
2154:     PROCEDURE BtnCancProcurarClick()
2155:         THIS.LockScreen = .T.
2156:         THIS.txt_4c_CdContas.Enabled   = .T.
2157:         THIS.txt_4c_DsContas.Enabled   = .T.
2158:         THIS.grd_4c_Dados.Enabled      = .T.
2159:         THIS.txt_4c_Favorecido.Enabled = .T.
2160:         THIS.AtualizarBotoesPermissao()
2161:         THIS.cnt_4c_Procurar.Visible   = .F.
2162:         THIS.cnt_4c_Procurar.Enabled   = .F.
2163:         THIS.ExibirCheques(.F.)
2164:         THIS.LockScreen = .F.
2165:     ENDPROC
2166: 
2167:     *-- KeyPress no campo Banco do container de impressao matricial (leitor magnetico)
2168:     PROCEDURE TxtBancoImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2169:         *-- CHR(60) = inicio de leitura CMC7 do leitor de cheques
2170:         IF par_nKeyCode = 60
2171:             IF !THIS.this_lPlLeCheque
2172:                 THIS.this_cPcChqLido = ""
2173:             ENDIF
2174:             THIS.this_lPlLeCheque = .T.
2175:         ENDIF
2176:         IF THIS.this_lPlLeCheque
2177:             NODEFAULT
2178:             THIS.this_cPcChqLido = THIS.this_cPcChqLido + CHR(par_nKeyCode)
2179:         ENDIF
2180:         *-- CHR(58) = fim de leitura
2181:         IF par_nKeyCode = 58
2182:             THIS.this_lPlLeCheque = .F.
2183:         ENDIF
2184:     ENDPROC
2185: 
2186:     *-- KeyPress no campo Banco do container Procurar (leitor magnetico)
2187:     PROCEDURE TxtBancoProcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2188:         IF par_nKeyCode = 60
2189:             IF !THIS.this_lPlLeCheque
2190:                 THIS.this_cPcChqLido = ""
2191:             ENDIF
2192:             THIS.this_lPlLeCheque = .T.
2193:         ENDIF
2194:         IF THIS.this_lPlLeCheque
2195:             NODEFAULT
2196:             THIS.this_cPcChqLido = THIS.this_cPcChqLido + CHR(par_nKeyCode)
2197:         ENDIF
2198:         IF par_nKeyCode = 58
2199:             THIS.this_lPlLeCheque = .F.
2200:         ENDIF
2201:     ENDPROC
2202: 
2203:     *-- Valid do campo Banco no Procurar: processa dado do leitor ou TAB
2204:     PROCEDURE TxtBancoProcValid()
2205:         LOCAL loc_oCnt, loc_cLeitor
2206:         loc_oCnt = THIS.cnt_4c_Procurar
2207: 
2208:         IF THIS.this_lPlLeCheque
2209:             loc_cLeitor = THIS.this_cPcChqLido
2210:         ELSE
2211:             loc_cLeitor = ""
2212:         ENDIF
2213: 
2214:         THIS.this_lPlLeitor = .F.
2215: 
2216:         IF LASTKEY() = 9
2217:             KEYBOARD "{CTRL+TAB}"
2218:         ELSE
2219:             THIS.this_lPlLeitor = .T.
2220:             IF LEN(loc_cLeitor) >= 33
2221:                 *-- Decodificar CMC7: banco(2-4), agencia(5-8), conta(23-32), cheque(14-19)
2222:                 loc_oCnt.txt_4c_BancoP.Value   = SUBSTR(loc_cLeitor, 2, 3)
2223:                 loc_oCnt.txt_4c_AgenciaP.Value = SUBSTR(loc_cLeitor, 5, 4)
2224:                 loc_oCnt.txt_4c_ContaP.Value   = SUBSTR(loc_cLeitor, 23, 10)
2225:                 loc_oCnt.txt_4c_ChequeP.Value  = SUBSTR(loc_cLeitor, 14, 6)
2226:                 THIS.Refresh()
2227:             ENDIF
2228:         ENDIF
2229:     ENDPROC
2230: 
2231:     *-- When no campo emissao do Procurar: so habilita se valor estiver vazio
2232:     PROCEDURE TxtEmissaoProcWhen()
2233:         RETURN EMPTY(THIS.cnt_4c_Procurar.txt_4c_ValorP.Value)
2234:     ENDPROC
2235: 
2236:     *-- When no campo valor do Procurar: so habilita se emissao estiver vazia
2237:     PROCEDURE TxtValorProcWhen()
2238:         RETURN EMPTY(THIS.cnt_4c_Procurar.txt_4c_EmissaoP.Value)
2239:     ENDPROC
2240: 
2241:     *-- Valid data inicial: ajustar data final e limpar grid se mudou
2242:     PROCEDURE TxtDtInicialValid()
2243:         IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
2244:             THIS.txt_4c_DtFinal.Value = THIS.txt_4c_DtInicial.Value
2245:         ENDIF
2246:         IF THIS.txt_4c_DtInicial.Value != THIS.this_dAntDtIni
2247:             LOCAL loc_cCursor
2248:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2249:             IF USED(loc_cCursor)
2250:                 ZAP IN (loc_cCursor)
2251:                 THIS.grd_4c_Dados.Refresh()
2252:             ENDIF
2253:         ENDIF
2254:         THIS.this_dAntDtIni = THIS.txt_4c_DtInicial.Value
2255:     ENDPROC
2256: 
2257:     *-- Valid data final: ajustar data inicial e limpar grid se mudou
2258:     PROCEDURE TxtDtFinalValid()
2259:         IF THIS.txt_4c_DtFinal.Value < THIS.txt_4c_DtInicial.Value
2260:             THIS.txt_4c_DtInicial.Value = THIS.txt_4c_DtFinal.Value
2261:         ENDIF
2262:         IF THIS.txt_4c_DtFinal.Value != THIS.this_dAntDtFin
2263:             LOCAL loc_cCursor
2264:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2265:             IF USED(loc_cCursor)
2266:                 ZAP IN (loc_cCursor)
2267:                 THIS.grd_4c_Dados.Refresh()
2268:             ENDIF
2269:         ENDIF
2270:         THIS.this_dAntDtFin = THIS.txt_4c_DtFinal.Value
2271:     ENDPROC
2272: 
2273:     *-- KeyPress no codigo do grupo: F4/Enter/Tab abre lookup de grupos contabeis
2274:     PROCEDURE TxtCdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2275:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2276:             RETURN
2277:         ENDIF
2278:         LOCAL loc_cVal, loc_oForm, loc_cSQL
2279:         loc_cVal = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2280: 
2281:         IF !EMPTY(loc_cVal)
2282:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(codigos) = " + ;
2283:                        EscaparSQL(loc_cVal)
2284:             IF USED("cursor_4c_GrupoOk")
2285:                 USE IN cursor_4c_GrupoOk
2286:             ENDIF
2287:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOk") > 0
2288:                 SELECT cursor_4c_GrupoOk
2289:                 GO TOP
2290:                 IF !EOF("cursor_4c_GrupoOk")
2291:                     THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.codigos)
2292:                     THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.descrs)
2293:                     THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(cursor_4c_GrupoOk.codigos)
2294:                     USE IN cursor_4c_GrupoOk
2295:                     IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2296:                         ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2297:                         THIS.grd_4c_Dados.Refresh()
2298:                     ENDIF
2299:                     THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2300:                     RETURN
2301:                 ENDIF
2302:                 USE IN cursor_4c_GrupoOk
2303:             ENDIF
2304:         ELSE
2305:             THIS.txt_4c_DsGrupos.Value = ""
2306:             THIS.this_oBusinessObject.this_cCdGrupos = ""
2307:             IF THIS.this_cAntCdGrupo != ""
2308:                 ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2309:                 THIS.grd_4c_Dados.Refresh()
2310:             ENDIF
2311:             THIS.this_cAntCdGrupo = ""
2312:             RETURN
2313:         ENDIF
2314: 
2315:         *-- Nao encontrado: abrir picker
2316:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2317:                     "SigCdGcr", "cursor_4c_GrupoLookup", ;
2318:                     "codigos", loc_cVal, ;
2319:                     "Grupos Cont" + CHR(225) + "beis", .T., .T., "")
2320:         IF VARTYPE(loc_oForm) = "O"
2321:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2322:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2323:             loc_oForm.Show()
2324:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2325:                 SELECT cursor_4c_GrupoLookup
2326:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2327:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2328:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2329:             ENDIF
2330:         ENDIF
2331:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2332:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2333:             THIS.grd_4c_Dados.Refresh()
2334:         ENDIF
2335:         THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2336:     ENDPROC
2337: 
2338:     *-- KeyPress na descricao do grupo: F4/Enter/Tab abre lookup por descricao
2339:     PROCEDURE TxtDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2340:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2341:             RETURN
2342:         ENDIF
2343:         LOCAL loc_cVal, loc_oForm
2344:         loc_cVal = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2345: 
2346:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2347:                     "SigCdGcr", "cursor_4c_GrupoLookup", ;
2348:                     "descrs", loc_cVal, ;
2349:                     "Grupos Cont" + CHR(225) + "beis", .T., .T., "")
2350:         IF VARTYPE(loc_oForm) = "O"
2351:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2352:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2353:             loc_oForm.Show()
2354:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2355:                 SELECT cursor_4c_GrupoLookup
2356:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2357:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2358:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2359:             ENDIF
2360:         ENDIF
2361:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntDsGrupo
2362:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2363:             THIS.grd_4c_Dados.Refresh()
2364:         ENDIF
2365:         THIS.this_cAntDsGrupo = THIS.txt_4c_CdGrupos.Value
2366:     ENDPROC
2367: 
2368:     *-- KeyPress no codigo da conta: F4/Enter/Tab abre lookup de contas
2369:     PROCEDURE TxtCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2370:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2371:             RETURN
2372:         ENDIF
2373:         LOCAL loc_cVal, loc_oForm, loc_cSQL
2374:         loc_cVal = ALLTRIM(THIS.txt_4c_CdContas.Value)
2375: 
2376:         IF !EMPTY(loc_cVal)
2377:             IF USED("cursor_4c_Contas") AND SEEK(loc_cVal, "cursor_4c_Contas", "IClis")
2378:                 SELECT cursor_4c_Contas
2379:                 THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2380:                 THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2381:                 THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2382:                 IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2383:                     ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2384:                     THIS.grd_4c_Dados.Refresh()
2385:                 ENDIF
2386:                 THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2387:                 RETURN
2388:             ENDIF
2389:         ELSE
2390:             THIS.txt_4c_DsContas.Value = ""
2391:             THIS.this_oBusinessObject.this_cCdContas = ""
2392:             IF THIS.this_cAntCdConta != ""
2393:                 ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2394:                 THIS.grd_4c_Dados.Refresh()
2395:             ENDIF
2396:             THIS.this_cAntCdConta = ""
2397:             RETURN
2398:         ENDIF
2399: 
2400:         *-- Nao encontrado: abrir picker usando SQLEXEC LIKE no cursor_4c_ContasLookup
2401:         THIS.AbrirLookupContas(loc_cVal, "C")
2402:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2403:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2404:             THIS.grd_4c_Dados.Refresh()
2405:         ENDIF
2406:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2407:     ENDPROC
2408: 
2409:     *-- KeyPress na descricao da conta: F4/Enter/Tab abre lookup por nome
2410:     PROCEDURE TxtDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2411:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2412:             RETURN
2413:         ENDIF
2414:         LOCAL loc_cVal
2415:         loc_cVal = ALLTRIM(THIS.txt_4c_DsContas.Value)
2416: 
2417:         THIS.AbrirLookupContas(loc_cVal, "D")
2418:         IF THIS.txt_4c_DsContas.Value != THIS.this_cAntDsConta
2419:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2420:             THIS.grd_4c_Dados.Refresh()
2421:         ENDIF
2422:         THIS.this_cAntDsConta = THIS.txt_4c_DsContas.Value
2423:     ENDPROC
2424: 
2425:     *-- AbrirLookupContas - Abre picker de contas bancarias via FormBuscaAuxiliar com Init params
2426:     *   par_cVal: valor digitado pelo usuario (prefixo para LIKE)
2427:     *   par_cModo: "C" busca por codigo (IClis), "D" busca por descricao (RClis)
2428:     PROCEDURE AbrirLookupContas(par_cVal, par_cModo)
2429:         LOCAL loc_cSQL, loc_cCampo, loc_oForm, loc_cGrupo
2430: 
2431:         loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2432: 
2433:         IF par_cModo = "C"
2434:             loc_cCampo = "IClis"
2435:             IF EMPTY(par_cVal)
2436:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2437:             ELSE
2438:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2439:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2440:             ENDIF
2441:         ELSE
2442:             loc_cCampo = "RClis"
2443:             IF EMPTY(par_cVal)
2444:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2445:             ELSE
2446:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2447:                            "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2448:             ENDIF
2449:         ENDIF
2450: 
2451:         IF !EMPTY(loc_cGrupo)
2452:             IF EMPTY(par_cVal)
2453:                 loc_cSQL = loc_cSQL + " WHERE RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2454:             ELSE
2455:                 loc_cSQL = loc_cSQL + " AND RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2456:             ENDIF
2457:         ENDIF
2458: 
2459:         loc_cSQL = loc_cSQL + " ORDER BY IClis"
2460: 
2461:         IF USED("cursor_4c_ContasLookup")
2462:             USE IN cursor_4c_ContasLookup
2463:         ENDIF
2464: 
2465:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasLookup") < 1
2466:             RETURN
2467:         ENDIF
2468: 
2469:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2470:                     "", "cursor_4c_ContasLookup", ;
2471:                     loc_cCampo, ALLTRIM(par_cVal), ;
2472:                     "Contas", .T., .T., "")
2473:         IF VARTYPE(loc_oForm) != "O"
2474:             RETURN
2475:         ENDIF
2476: 
2477:         loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2478:         loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
2479:         loc_oForm.Show()
2480: 
2481:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ContasLookup")
2482:             SELECT cursor_4c_ContasLookup
2483:             THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2484:             THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2485:             THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2486:         ENDIF
2487: 
2488:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2489:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2490:             THIS.grd_4c_Dados.Refresh()
2491:         ENDIF
2492:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2493:     ENDPROC
2494: 
2495:     *-- LostFocus do txt_4c_Chfin: padroniza para 6 digitos com zeros a esquerda
2496:     PROCEDURE TxtChfinLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2497:         IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)
2498:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ;
2499:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
2500:         ENDIF
2501:     ENDPROC
2502: 
2503:     *-- LostFocus do txt_4c_Chini: padroniza para 6 digitos com zeros a esquerda
2504:     PROCEDURE TxtChiniLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2505:         IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
2506:             THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ;
2507:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
2508:         ENDIF
2509:     ENDPROC
2510: 
2511:     *==========================================================================
2512:     * --- ALIASES DE COMPATIBILIDADE COM PIPELINE MULTI-FASE ---
2513:     * OPERACIONAL nao tem Page1/Page2 CRUD; estes metodos existem para que
2514:     * o validador do pipeline encontre as assinaturas esperadas.
2515:     *==========================================================================
2516: 
2517:     *-- CarregarLista: alias de MontarCheques (pipeline exige este nome)
2518:     PROCEDURE CarregarLista()
2519:         RETURN THIS.MontarCheques(.F.)
2520:     ENDPROC
2521: 
2522:     *-- FormParaBO: sincroniza filtros da UI para o BO antes de processar
2523:     PROCEDURE FormParaBO()
2524:         THIS.this_oBusinessObject.this_cCdGrupos  = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2525:         THIS.this_oBusinessObject.this_cDsGrupos  = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2526:         THIS.this_oBusinessObject.this_cCdContas  = ALLTRIM(THIS.txt_4c_CdContas.Value)
2527:         THIS.this_oBusinessObject.this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
2528:         THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
2529:         THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
2530:     ENDPROC
2531: 
2532:     *-- BOParaForm: alias de ExibirCheques (pipeline exige este nome)
2533:     PROCEDURE BOParaForm()
2534:         THIS.ExibirCheques(.F.)
2535:     ENDPROC
2536: 
2537:     *-- BtnSalvarClick: alias de BtnProcessarClick (mapeamento OPERACIONAL)
2538:     PROCEDURE BtnSalvarClick()
2539:         THIS.BtnProcessarClick()
2540:     ENDPROC
2541: 
2542:     *-- BtnCancelarClick: alias de BtnEncerrarClick (mapeamento OPERACIONAL)
2543:     PROCEDURE BtnCancelarClick()
2544:         THIS.BtnEncerrarClick()
2545:     ENDPROC
2546: 
2547:     *-- HabilitarCampos: stub N/A (OPERACIONAL gerencia habilitacao via AtualizarBotoesLinhaCorrente)
2548:     PROCEDURE HabilitarCampos(par_lHabilitar)
2549:         IF VARTYPE(THIS.txt_4c_CdGrupos) = "O"
2550:             THIS.txt_4c_CdGrupos.Enabled  = par_lHabilitar
2551:             THIS.txt_4c_DsGrupos.Enabled  = par_lHabilitar
2552:             THIS.txt_4c_CdContas.Enabled  = par_lHabilitar
2553:             THIS.txt_4c_DsContas.Enabled  = par_lHabilitar
2554:             THIS.txt_4c_DtInicial.Enabled = par_lHabilitar
2555:             THIS.txt_4c_DtFinal.Enabled   = par_lHabilitar
2556:         ENDIF
2557:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
2558:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
2559:         ENDIF
2560:     ENDPROC
2561: 
2562:     *-- BtnIncluirClick: stub N/A - OPERACIONAL nao tem modo INCLUIR
2563:     PROCEDURE BtnIncluirClick()
2564:         THIS.BtnDocumentoClick()
2565:     ENDPROC
2566: 
2567:     *-- BtnAlterarClick: stub N/A - OPERACIONAL nao tem modo ALTERAR
2568:     PROCEDURE BtnAlterarClick()
2569:         THIS.BtnDocumentoClick()
2570:     ENDPROC
2571: 
2572:     *-- BtnVisualizarClick: alias de BtnImprimirClick (visualizacao do cheque via FormSigReEch)
2573:     PROCEDURE BtnVisualizarClick()
2574:         THIS.BtnImprimirClick()
2575:     ENDPROC
2576: 
2577:     *-- BtnExcluirClick: alias de BtnExcluirChqClick (exclusao do cheque cancelado)
2578:     PROCEDURE BtnExcluirClick()
2579:         THIS.BtnExcluirChqClick()
2580:     ENDPROC
2581: 
2582:     *-- BtnBuscarClick: alias de BtnProcurarClick (mapeamento OPERACIONAL)
2583:     PROCEDURE BtnBuscarClick()
2584:         THIS.BtnProcurarClick()
2585:     ENDPROC
2586: 
2587:     *-- LimparCampos: reseta campos de filtro da UI (OPERACIONAL: limpa filtros, nao campos de dados)
2588:     PROCEDURE LimparCampos()
2589:         THIS.txt_4c_CdGrupos.Value  = ""
2590:         THIS.txt_4c_DsGrupos.Value  = ""
2591:         THIS.txt_4c_CdContas.Value  = ""
2592:         THIS.txt_4c_DsContas.Value  = ""
2593:         THIS.txt_4c_DtInicial.Value = DATE()
2594:         THIS.txt_4c_DtFinal.Value   = DATE()
2595:         THIS.txt_4c_Favorecido.Value = ""
2596:         THIS.this_cAntCdGrupo = ""
2597:         THIS.this_cAntDsGrupo = ""
2598:         THIS.this_cAntCdConta = ""
2599:         THIS.this_cAntDsConta = ""
2600:         THIS.this_dAntDtIni   = {}
2601:         THIS.this_dAntDtFin   = {}
2602:         THIS.this_oBusinessObject.this_cCdGrupos  = ""
2603:         THIS.this_oBusinessObject.this_cDsGrupos  = ""
2604:         THIS.this_oBusinessObject.this_cCdContas  = ""
2605:         THIS.this_oBusinessObject.this_cDsContas  = ""
2606:         THIS.this_oBusinessObject.this_dDtInicial = DATE()
2607:         THIS.this_oBusinessObject.this_dDtFinal   = DATE()
2608:     ENDPROC
2609: 
2610:     *-- AjustarBotoesPorModo: stub N/A (OPERACIONAL nao tem ciclo INCLUIR/ALTERAR/VISUALIZAR)
2611:     PROCEDURE AjustarBotoesPorModo()
2612:         THIS.AtualizarBotoesPermissao()
2613:         THIS.AtualizarBotoesLinhaCorrente()
2614:     ENDPROC
2615: 
2616:     *==========================================================================
2617:     PROCEDURE Destroy
2618:     *==========================================================================
2619:         IF USED("cursor_4c_Pgr")
2620:             USE IN cursor_4c_Pgr
2621:         ENDIF
2622:         IF USED("cursor_4c_MatrizTemp")
2623:             USE IN cursor_4c_MatrizTemp
2624:         ENDIF
2625:         IF USED("cursor_4c_ImpTemp")
2626:             USE IN cursor_4c_ImpTemp
2627:         ENDIF
2628:         IF USED("cursor_4c_GrupoOk")
2629:             USE IN cursor_4c_GrupoOk
2630:         ENDIF
2631:         IF USED("cursor_4c_GrupoLookup")
2632:             USE IN cursor_4c_GrupoLookup
2633:         ENDIF
2634:         IF USED("cursor_4c_ContasLookup")
2635:             USE IN cursor_4c_ContasLookup
2636:         ENDIF
2637:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2638:             THIS.this_oBusinessObject = .NULL.
2639:         ENDIF
2640:         DODEFAULT()
2641:     ENDPROC
2642: 
2643: ENDDEFINE

