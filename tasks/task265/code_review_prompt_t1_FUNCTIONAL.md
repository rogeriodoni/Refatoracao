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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2644 linhas total):

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

*-- Linhas 1442 a 2644:
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
1692:         LOCAL loc_i, loc_oControl
1693:         FOR loc_i = 1 TO par_oContainer.ControlCount
1694:             loc_oControl = par_oContainer.Controls(loc_i)
1695:             IF VARTYPE(loc_oControl) != "O"
1696:                 LOOP
1697:             ENDIF
1698:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1699:                 loc_oControl.Visible = .T.
1700:             ENDIF
1701:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1702:                 THIS.TornarSubControlesVisiveis(loc_oControl)
1703:             ENDIF
1704:         ENDFOR
1705:     ENDPROC
1706: 
1707:     *==========================================================================
1708:     * --- HANDLERS DE EVENTOS ---
1709:     *==========================================================================
1710: 
1711:     *-- Grid AfterRowColChange: atualiza painel inferior ao navegar
1712:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
1713:         THIS.LockScreen = .T.
1714:         THIS.AtualizarBotoesLinhaCorrente()
1715:         THIS.LockScreen = .F.
1716:     ENDPROC
1717: 
1718:     *-- Grid Checkbox KeyPress: toggle de selecao via ENTER ou SPACE
1719:     PROCEDURE GrdChkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1720:         LOCAL loc_cCursor, loc_cChave, loc_nRecno
1721:         IF INLIST(par_nKeyCode, 13, 32)
1722:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1723:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1724:                 SELECT (loc_cCursor)
1725:                 loc_nRecno = RECNO()
1726:                 loc_cChave = ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques)
1727:                 UPDATE (loc_cCursor) SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
1728:                     WHERE ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques) = m.loc_cChave ;
1729:                     AND NEmitidos = 0 AND NCancelas = 0
1730:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1731:                     GOTO loc_nRecno IN (loc_cCursor)
1732:                 ENDIF
1733:                 THIS.grd_4c_Dados.Refresh()
1734:             ENDIF
1735:             NODEFAULT
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     *-- Grid Checkbox MouseDown: delegar para KeyPress com SPACE
1740:     PROCEDURE GrdChkMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1741:         THIS.GrdChkKeyPress(32, 0)
1742:         NODEFAULT
1743:     ENDPROC
1744: 
1745:     *-- Header NCopias Click: reordenar por NCopias (sem conta filtrada)
1746:     PROCEDURE GrdHeaderNCopias()
1747:         LOCAL loc_cCursor
1748:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1749:         IF EMPTY(THIS.txt_4c_CdContas.Value) AND UPPER(ORDER(loc_cCursor)) != "NCOPIAS"
1750:             THIS.ExibirCheques(.F.)
1751:         ENDIF
1752:     ENDPROC
1753: 
1754:     *-- Botao Processar: valida periodo e dispara MontarCheques
1755:     PROCEDURE BtnProcessarClick()
1756:         IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
1757:             MsgAviso("Data Final menor que Data Inicial !!!", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
1758:             THIS.txt_4c_DtInicial.SetFocus()
1759:             RETURN
1760:         ENDIF
1761:         THIS.MontarCheques(.F.)
1762:     ENDPROC
1763: 
1764:     *-- Botao SelTudo: marca todos os cheques nao-emitidos nao-cancelados
1765:     PROCEDURE BtnSelTudoClick()
1766:         LOCAL loc_cCursor, loc_nRecno
1767:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1768:         IF USED(loc_cCursor)
1769:             SELECT (loc_cCursor)
1770:             loc_nRecno = RECNO()
1771:             UPDATE (loc_cCursor) SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
1772:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1773:                 GOTO loc_nRecno IN (loc_cCursor)
1774:             ENDIF
1775:             THIS.grd_4c_Dados.Refresh()
1776:         ENDIF
1777:     ENDPROC
1778: 
1779:     *-- Botao Apaga: desmarca todos os cheques selecionados
1780:     PROCEDURE BtnApagaClick()
1781:         LOCAL loc_cCursor, loc_nRecno
1782:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1783:         IF USED(loc_cCursor)
1784:             SELECT (loc_cCursor)
1785:             loc_nRecno = RECNO()
1786:             UPDATE (loc_cCursor) SET NMarca1s = 0 WHERE NMarca1s = 1
1787:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1788:                 GOTO loc_nRecno IN (loc_cCursor)
1789:             ENDIF
1790:             THIS.grd_4c_Dados.Refresh()
1791:         ENDIF
1792:     ENDPROC
1793: 
1794:     *-- Botao Encerrar
1795:     PROCEDURE BtnEncerrarClick()
1796:         THIS.Release()
1797:     ENDPROC
1798: 
1799:     *-- Botao Documento: abre SigCdPgr para o cheque corrente
1800:     PROCEDURE BtnDocumentoClick()
1801:         LOCAL loc_lCarregou, loc_nRecno, loc_cCursor
1802:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1803: 
1804:         THIS.LockScreen = .T.
1805:         loc_nRecno = RECNO(loc_cCursor)
1806: 
1807:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1808:             SELECT (loc_cCursor)
1809:             DO FORM SigCdPgr WITH ;
1810:                 LEFT(ALLTRIM(Dopes), 1), .T., ;
1811:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1812:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1813:                 GOTO loc_nRecno IN (loc_cCursor)
1814:             ENDIF
1815:             THIS.ExibirCheques(.F.)
1816:         ENDIF
1817: 
1818:         THIS.LockScreen = .F.
1819:     ENDPROC
1820: 
1821:     *-- Botao Imprimir: abre FormSigReEch para visualizar/imprimir o cheque corrente
1822:     PROCEDURE BtnImprimirClick()
1823:         LOCAL loc_lCarregou, loc_cCursor
1824:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1825: 
1826:         IF !USED(loc_cCursor) OR EOF(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1827:             MsgAviso("Nenhum cheque selecionado para visualizar.", "Imprimir")
1828:             RETURN
1829:         ENDIF
1830: 
1831:         IF THIS.CarregarConta()
1832:             SELECT (loc_cCursor)
1833:             DO FORM FormSigReEch WITH ;
1834:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes, "CONSULTAR", ALLTRIM(NCheques)
1835:             THIS.ExibirCheques(.F.)
1836:         ENDIF
1837:     ENDPROC
1838: 
1839:     *-- Botao Recibo: abre SigRerec para o cheque corrente
1840:     PROCEDURE BtnReciboClick()
1841:         LOCAL loc_lCarregou
1842:         IF THIS.CarregarConta()
1843:             DO FORM SigRerec WITH THIS, "RECIBO"
1844:         ENDIF
1845:     ENDPROC
1846: 
1847:     *-- Botao Excluir Documento
1848:     PROCEDURE BtnExcluiDocClick()
1849:         LOCAL loc_nRecno, loc_cCursor, loc_lCarregou
1850:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1851: 
1852:         THIS.LockScreen = .T.
1853:         loc_nRecno = RECNO(loc_cCursor)
1854: 
1855:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1856:             SELECT (loc_cCursor)
1857:             DO FORM SigCdPgr WITH ;
1858:                 LEFT(ALLTRIM(Dopes), 1), .F., ;
1859:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1860:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1861:                 GOTO loc_nRecno IN (loc_cCursor)
1862:             ENDIF
1863:             THIS.ExibirCheques(.F.)
1864:         ENDIF
1865: 
1866:         THIS.LockScreen = .F.
1867:     ENDPROC
1868: 
1869:     *-- Botao Cheque: imprime fisicamente cheques marcados em impressora de cheque
1870:     PROCEDURE BtnImpchqClick()
1871:         LOCAL loc_cCursor, loc_oErro, loc_cBancos
1872:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1873: 
1874:         IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1875:             MsgAviso("Nenhum cheque dispon" + CHR(237) + "vel.", "Cheque")
1876:             RETURN
1877:         ENDIF
1878: 
1879:         TRY
1880:             IF USED("cursor_4c_TmpBanco")
1881:                 USE IN cursor_4c_TmpBanco
1882:             ENDIF
1883: 
1884:             SELECT DISTINCT Bancos FROM (loc_cCursor) WHERE NMarca1s = 1 ;
1885:               INTO CURSOR cursor_4c_TmpBanco
1886: 
1887:             SELECT cursor_4c_TmpBanco
1888:             GO TOP
1889:             IF EOF("cursor_4c_TmpBanco")
1890:                 MsgAviso("Nenhum cheque selecionado para impress" + CHR(227) + "o.", "Cheque")
1891:                 USE IN cursor_4c_TmpBanco
1892:                 RETURN
1893:             ENDIF
1894: 
1895:             IF RECCOUNT("cursor_4c_TmpBanco") > 1
1896:                 MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", ;
1897:                     "Aten" + CHR(231) + CHR(227) + "o")
1898:                 USE IN cursor_4c_TmpBanco
1899:                 RETURN
1900:             ENDIF
1901: 
1902:             loc_cBancos = ALLTRIM(cursor_4c_TmpBanco.Bancos)
1903:             USE IN cursor_4c_TmpBanco
1904: 
1905:             IF USED("cursor_4c_ImpTemp")
1906:                 USE IN cursor_4c_ImpTemp
1907:             ENDIF
1908: 
1909:             SELECT Bancos, Agencias, NContas, NCheques, cIdChaves, ;
1910:                    Valors, Datas, NEmitidos, NCancelas, Favos ;
1911:               FROM (loc_cCursor) ;
1912:              WHERE NMarca1s = 1 ;
1913:              ORDER BY Bancos, NCheques ;
1914:               INTO CURSOR cursor_4c_ImpTemp READWRITE
1915: 
1916:             THIS.this_oBusinessObject.ImprimirCheques(loc_cBancos)
1917: 
1918:             IF USED("cursor_4c_ImpTemp")
1919:                 USE IN cursor_4c_ImpTemp
1920:             ENDIF
1921: 
1922:             THIS.ExibirCheques(.F.)
1923: 
1924:         CATCH TO loc_oErro
1925:             MsgErro(loc_oErro.Message, "Erro ao imprimir cheque")
1926:         ENDTRY
1927:     ENDPROC
1928: 
1929:     *-- Botao Chq. Matric.: activa container de impressao matricial
1930:     PROCEDURE BtnChmatClick()
1931:         THIS.this_lChMatIni = .T.
1932:         WITH THIS.cnt_4c_Impchmat
1933:             .Enabled = .T.
1934:             .Visible = .T.
1935:             .txt_4c_Banco.Value = ""
1936:             .txt_4c_Chini.Value = ""
1937:             .txt_4c_Chfin.Value = ""
1938:             .txt_4c_Banco.SetFocus()
1939:         ENDWITH
1940:         THIS.cmg_4c_Acoes.Enabled = .F.
1941:         THIS.Refresh()
1942:     ENDPROC
1943: 
1944:     *-- Botao Excluir Cheque: confirma e exclui cheque cancelado
1945:     PROCEDURE BtnExcluirChqClick()
1946:         LOCAL loc_cCursor, loc_cSQL, loc_nOk, loc_cMensa, loc_oErro
1947:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1948: 
1949:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
1950:             RETURN
1951:         ENDIF
1952: 
1953:         SELECT (loc_cCursor)
1954:         IF NCancelas = 1 AND THIS.this_lExcluirCheque
1955:             IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
1956:                            ALLTRIM(Bancos) + " / " + ALLTRIM(Agencias) + ;
1957:                            " / " + ALLTRIM(Ncontas) + " / " + ALLTRIM(Ncheques) + " ?")
1958:                 TRY
1959:                     loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(Cidchaves))
1960:                     IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1961:                         loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado : " + ;
1962:                                      ALLTRIM(Bancos) + "/" + ALLTRIM(Agencias) + ;
1963:                                      "/" + ALLTRIM(Ncontas) + "/" + ALLTRIM(Ncheques)
1964:                         THIS.this_oBusinessObject.RegistrarAuditoria("DELETE")
1965:                     ELSE
1966:                         MsgErro("Falha ao excluir cheque.", "Erro")
1967:                     ENDIF
1968:                 CATCH TO loc_oErro
1969:                     MsgErro(loc_oErro.Message, "Erro")
1970:                 ENDTRY
1971:                 THIS.ExibirCheques(.F.)
1972:             ENDIF
1973:         ENDIF
1974:     ENDPROC
1975: 
1976:     *-- Botao Procurar: activa container de busca de cheque
1977:     PROCEDURE BtnProcurarClick()
1978:         THIS.this_lPlInicio = .T.
1979:         WITH THIS.cnt_4c_Procurar
1980:             .Visible = .T.
1981:             .Enabled = .T.
1982:             .txt_4c_BancoP.SetFocus()
1983:         ENDWITH
1984:         WITH THIS.cmg_4c_Acoes
1985:             .Buttons(1).Enabled = .F.
1986:             .Buttons(2).Enabled = .F.
1987:             .Buttons(3).Enabled = .F.
1988:             .Buttons(4).Enabled = .F.
1989:             .Buttons(5).Enabled = .F.
1990:             .Buttons(6).Enabled = .F.
1991:         ENDWITH
1992:         THIS.txt_4c_CdContas.Enabled   = .F.
1993:         THIS.txt_4c_DsContas.Enabled   = .F.
1994:         THIS.grd_4c_Dados.Enabled      = .F.
1995:         THIS.txt_4c_Favorecido.Enabled = .F.
1996:         THIS.Refresh()
1997:     ENDPROC
1998: 
1999:     *-- Botao Confirmar Justificativa: cancela cheque com justificativa
2000:     PROCEDURE BtnConfJustClick()
2001:         LOCAL loc_nRecno, loc_cCursor, loc_cJust, loc_lCarregou, loc_oErro
2002: 
2003:         IF EMPTY(THIS.cnt_4c_Justificativa.txt_4c_Justificativa.Value)
2004:             MsgAviso("Aten" + CHR(231) + CHR(227) + "o, justificativa em Branco", "")
2005:             THIS.cnt_4c_Justificativa.txt_4c_Justificativa.SetFocus()
2006:             RETURN
2007:         ENDIF
2008: 
2009:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2010:         THIS.LockScreen = .T.
2011:         loc_nRecno = RECNO(loc_cCursor)
2012: 
2013:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
2014:             TRY
2015:                 SELECT (loc_cCursor)
2016:                 THIS.Enabled = .F.
2017:                 DO FORM SigCdPgr WITH ;
2018:                     LEFT(ALLTRIM(Dopes), 1), .F., ;
2019:                     ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
2020:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2021:                     GOTO loc_nRecno IN (loc_cCursor)
2022:                 ENDIF
2023:                 THIS.ExibirCheques(.F.)
2024:                 THIS.Enabled = .T.
2025:                 THIS.cnt_4c_Justificativa.Visible = .F.
2026:             CATCH TO loc_oErro
2027:                 THIS.Enabled = .T.
2028:                 MsgErro(loc_oErro.Message, "Erro")
2029:             ENDTRY
2030:         ENDIF
2031: 
2032:         THIS.LockScreen = .F.
2033:     ENDPROC
2034: 
2035:     *-- Botao Cancelar Justificativa
2036:     PROCEDURE BtnCancJustClick()
2037:         THIS.cnt_4c_Justificativa.Enabled = .F.
2038:         THIS.cnt_4c_Justificativa.Visible = .F.
2039:     ENDPROC
2040: 
2041:     *-- Botao Imprimir Matricial: imprime cheques por faixa (impchmat)
2042:     PROCEDURE BtnImpChmatClick()
2043:         LOCAL loc_cBanco, loc_cChIni, loc_cChFin, loc_cSQL, loc_oErro
2044: 
2045:         WITH THIS.cnt_4c_Impchmat
2046:             loc_cBanco = ALLTRIM(.txt_4c_Banco.Value)
2047:             loc_cChIni = ALLTRIM(.txt_4c_Chini.Value)
2048:             loc_cChFin = ALLTRIM(.txt_4c_Chfin.Value)
2049:             .Visible     = .T.
2050:         ENDWITH
2051: 
2052:         IF EMPTY(loc_cBanco)
2053:             MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2054:             THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
2055:             RETURN
2056:         ENDIF
2057:         IF EMPTY(loc_cChIni)
2058:             MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2059:             THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
2060:             RETURN
2061:         ENDIF
2062:         IF EMPTY(loc_cChFin)
2063:             MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
2064:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
2065:             RETURN
2066:         ENDIF
2067:         IF loc_cChFin < loc_cChIni
2068:             MsgAviso("Cheque final menor que o inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
2069:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
2070:             RETURN
2071:         ENDIF
2072: 
2073:         TRY
2074:             loc_cSQL = "SELECT bancos, valors, ncheques, datas, emitidos, cancelas, favos " + ;
2075:                        "FROM SigCqChi " + ;
2076:                        "WHERE bancos = " + EscaparSQL(loc_cBanco) + ;
2077:                        " AND ncheques BETWEEN " + EscaparSQL(loc_cChIni) + ;
2078:                        " AND " + EscaparSQL(loc_cChFin) + ;
2079:                        " ORDER BY ncheques"
2080: 
2081:             IF USED("cursor_4c_MatrizTemp")
2082:                 USE IN cursor_4c_MatrizTemp
2083:             ENDIF
2084: 
2085:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizTemp") > 0
2086:                 THIS.this_oBusinessObject.ImprimirChequesMatricial()
2087:                 USE IN cursor_4c_MatrizTemp
2088:             ELSE
2089:                 MsgAviso("Nenhum cheque encontrado na faixa informada.", "Impress" + CHR(227) + "o")
2090:             ENDIF
2091: 
2092:         CATCH TO loc_oErro
2093:             MsgErro(loc_oErro.Message, "Erro ao imprimir matricial")
2094:         ENDTRY
2095:     ENDPROC
2096: 
2097:     *-- Botao Encerrar Matricial: fecha container impchmat e reactiva acoes
2098:     PROCEDURE BtnCancChmatClick()
2099:         THIS.LockScreen = .T.
2100:         THIS.cmg_4c_Acoes.Enabled    = .T.
2101:         THIS.cnt_4c_Impchmat.Enabled  = .F.
2102:         THIS.cnt_4c_Impchmat.Visible  = .F.
2103:         THIS.ExibirCheques(.F.)
2104:         THIS.LockScreen = .F.
2105:     ENDPROC
2106: 
2107:     *-- Botao Procurar (exec no container): busca cheque por banco/agencia/conta/cheque/emissao/valor
2108:     PROCEDURE BtnProcurarExecClick()
2109:         LOCAL loc_oCnt, loc_cCursor
2110:         loc_oCnt    = THIS.cnt_4c_Procurar
2111:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2112: 
2113:         SET NEAR ON
2114: 
2115:         loc_oCnt.txt_4c_BancoP.Value = PADR(ALLTRIM(loc_oCnt.txt_4c_BancoP.Value), 3)
2116: 
2117:         SELECT (loc_cCursor)
2118:         DO CASE
2119:             CASE !EMPTY(loc_oCnt.txt_4c_EmissaoP.Value)
2120:                 SET ORDER TO Emissao
2121:                 SEEK DTOS(loc_oCnt.txt_4c_EmissaoP.Value) + ;
2122:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2123:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2124:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2125:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2126:             CASE !EMPTY(loc_oCnt.txt_4c_ValorP.Value)
2127:                 SET ORDER TO Valor
2128:                 SEEK STR(loc_oCnt.txt_4c_ValorP.Value, 12, 2) + ;
2129:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2130:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2131:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2132:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2133:             OTHERWISE
2134:                 SET ORDER TO Cheque
2135:                 SEEK ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2136:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2137:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2138:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2139:         ENDCASE
2140: 
2141:         SET NEAR OFF
2142: 
2143:         *-- Ocultar container e reativar controles principais
2144:         THIS.txt_4c_CdContas.Enabled   = .T.
2145:         THIS.txt_4c_DsContas.Enabled   = .T.
2146:         THIS.grd_4c_Dados.Enabled      = .T.
2147:         THIS.txt_4c_Favorecido.Enabled = .T.
2148:         THIS.AtualizarBotoesPermissao()
2149:         THIS.cnt_4c_Procurar.Visible   = .F.
2150:         THIS.cnt_4c_Procurar.Enabled   = .F.
2151:         THIS.ExibirCheques(.F.)
2152:     ENDPROC
2153: 
2154:     *-- Botao Encerrar Procurar
2155:     PROCEDURE BtnCancProcurarClick()
2156:         THIS.LockScreen = .T.
2157:         THIS.txt_4c_CdContas.Enabled   = .T.
2158:         THIS.txt_4c_DsContas.Enabled   = .T.
2159:         THIS.grd_4c_Dados.Enabled      = .T.
2160:         THIS.txt_4c_Favorecido.Enabled = .T.
2161:         THIS.AtualizarBotoesPermissao()
2162:         THIS.cnt_4c_Procurar.Visible   = .F.
2163:         THIS.cnt_4c_Procurar.Enabled   = .F.
2164:         THIS.ExibirCheques(.F.)
2165:         THIS.LockScreen = .F.
2166:     ENDPROC
2167: 
2168:     *-- KeyPress no campo Banco do container de impressao matricial (leitor magnetico)
2169:     PROCEDURE TxtBancoImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2170:         *-- CHR(60) = inicio de leitura CMC7 do leitor de cheques
2171:         IF par_nKeyCode = 60
2172:             IF !THIS.this_lPlLeCheque
2173:                 THIS.this_cPcChqLido = ""
2174:             ENDIF
2175:             THIS.this_lPlLeCheque = .T.
2176:         ENDIF
2177:         IF THIS.this_lPlLeCheque
2178:             NODEFAULT
2179:             THIS.this_cPcChqLido = THIS.this_cPcChqLido + CHR(par_nKeyCode)
2180:         ENDIF
2181:         *-- CHR(58) = fim de leitura
2182:         IF par_nKeyCode = 58
2183:             THIS.this_lPlLeCheque = .F.
2184:         ENDIF
2185:     ENDPROC
2186: 
2187:     *-- KeyPress no campo Banco do container Procurar (leitor magnetico)
2188:     PROCEDURE TxtBancoProcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2189:         IF par_nKeyCode = 60
2190:             IF !THIS.this_lPlLeCheque
2191:                 THIS.this_cPcChqLido = ""
2192:             ENDIF
2193:             THIS.this_lPlLeCheque = .T.
2194:         ENDIF
2195:         IF THIS.this_lPlLeCheque
2196:             NODEFAULT
2197:             THIS.this_cPcChqLido = THIS.this_cPcChqLido + CHR(par_nKeyCode)
2198:         ENDIF
2199:         IF par_nKeyCode = 58
2200:             THIS.this_lPlLeCheque = .F.
2201:         ENDIF
2202:     ENDPROC
2203: 
2204:     *-- Valid do campo Banco no Procurar: processa dado do leitor ou TAB
2205:     PROCEDURE TxtBancoProcValid()
2206:         LOCAL loc_oCnt, loc_cLeitor
2207:         loc_oCnt = THIS.cnt_4c_Procurar
2208: 
2209:         IF THIS.this_lPlLeCheque
2210:             loc_cLeitor = THIS.this_cPcChqLido
2211:         ELSE
2212:             loc_cLeitor = ""
2213:         ENDIF
2214: 
2215:         THIS.this_lPlLeitor = .F.
2216: 
2217:         IF LASTKEY() = 9
2218:             KEYBOARD "{CTRL+TAB}"
2219:         ELSE
2220:             THIS.this_lPlLeitor = .T.
2221:             IF LEN(loc_cLeitor) >= 33
2222:                 *-- Decodificar CMC7: banco(2-4), agencia(5-8), conta(23-32), cheque(14-19)
2223:                 loc_oCnt.txt_4c_BancoP.Value   = SUBSTR(loc_cLeitor, 2, 3)
2224:                 loc_oCnt.txt_4c_AgenciaP.Value = SUBSTR(loc_cLeitor, 5, 4)
2225:                 loc_oCnt.txt_4c_ContaP.Value   = SUBSTR(loc_cLeitor, 23, 10)
2226:                 loc_oCnt.txt_4c_ChequeP.Value  = SUBSTR(loc_cLeitor, 14, 6)
2227:                 THIS.Refresh()
2228:             ENDIF
2229:         ENDIF
2230:     ENDPROC
2231: 
2232:     *-- When no campo emissao do Procurar: so habilita se valor estiver vazio
2233:     PROCEDURE TxtEmissaoProcWhen()
2234:         RETURN EMPTY(THIS.cnt_4c_Procurar.txt_4c_ValorP.Value)
2235:     ENDPROC
2236: 
2237:     *-- When no campo valor do Procurar: so habilita se emissao estiver vazia
2238:     PROCEDURE TxtValorProcWhen()
2239:         RETURN EMPTY(THIS.cnt_4c_Procurar.txt_4c_EmissaoP.Value)
2240:     ENDPROC
2241: 
2242:     *-- Valid data inicial: ajustar data final e limpar grid se mudou
2243:     PROCEDURE TxtDtInicialValid()
2244:         IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
2245:             THIS.txt_4c_DtFinal.Value = THIS.txt_4c_DtInicial.Value
2246:         ENDIF
2247:         IF THIS.txt_4c_DtInicial.Value != THIS.this_dAntDtIni
2248:             LOCAL loc_cCursor
2249:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2250:             IF USED(loc_cCursor)
2251:                 ZAP IN (loc_cCursor)
2252:                 THIS.grd_4c_Dados.Refresh()
2253:             ENDIF
2254:         ENDIF
2255:         THIS.this_dAntDtIni = THIS.txt_4c_DtInicial.Value
2256:     ENDPROC
2257: 
2258:     *-- Valid data final: ajustar data inicial e limpar grid se mudou
2259:     PROCEDURE TxtDtFinalValid()
2260:         IF THIS.txt_4c_DtFinal.Value < THIS.txt_4c_DtInicial.Value
2261:             THIS.txt_4c_DtInicial.Value = THIS.txt_4c_DtFinal.Value
2262:         ENDIF
2263:         IF THIS.txt_4c_DtFinal.Value != THIS.this_dAntDtFin
2264:             LOCAL loc_cCursor
2265:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2266:             IF USED(loc_cCursor)
2267:                 ZAP IN (loc_cCursor)
2268:                 THIS.grd_4c_Dados.Refresh()
2269:             ENDIF
2270:         ENDIF
2271:         THIS.this_dAntDtFin = THIS.txt_4c_DtFinal.Value
2272:     ENDPROC
2273: 
2274:     *-- KeyPress no codigo do grupo: F4/Enter/Tab abre lookup de grupos contabeis
2275:     PROCEDURE TxtCdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2276:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2277:             RETURN
2278:         ENDIF
2279:         LOCAL loc_cVal, loc_oForm, loc_cSQL
2280:         loc_cVal = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2281: 
2282:         IF !EMPTY(loc_cVal)
2283:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(codigos) = " + ;
2284:                        EscaparSQL(loc_cVal)
2285:             IF USED("cursor_4c_GrupoOk")
2286:                 USE IN cursor_4c_GrupoOk
2287:             ENDIF
2288:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOk") > 0
2289:                 SELECT cursor_4c_GrupoOk
2290:                 GO TOP
2291:                 IF !EOF("cursor_4c_GrupoOk")
2292:                     THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.codigos)
2293:                     THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.descrs)
2294:                     THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(cursor_4c_GrupoOk.codigos)
2295:                     USE IN cursor_4c_GrupoOk
2296:                     IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2297:                         ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2298:                         THIS.grd_4c_Dados.Refresh()
2299:                     ENDIF
2300:                     THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2301:                     RETURN
2302:                 ENDIF
2303:                 USE IN cursor_4c_GrupoOk
2304:             ENDIF
2305:         ELSE
2306:             THIS.txt_4c_DsGrupos.Value = ""
2307:             THIS.this_oBusinessObject.this_cCdGrupos = ""
2308:             IF THIS.this_cAntCdGrupo != ""
2309:                 ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2310:                 THIS.grd_4c_Dados.Refresh()
2311:             ENDIF
2312:             THIS.this_cAntCdGrupo = ""
2313:             RETURN
2314:         ENDIF
2315: 
2316:         *-- Nao encontrado: abrir picker
2317:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2318:                     "SigCdGcr", "cursor_4c_GrupoLookup", ;
2319:                     "codigos", loc_cVal, ;
2320:                     "Grupos Cont" + CHR(225) + "beis", .T., .T., "")
2321:         IF VARTYPE(loc_oForm) = "O"
2322:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2323:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2324:             loc_oForm.Show()
2325:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2326:                 SELECT cursor_4c_GrupoLookup
2327:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2328:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2329:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2330:             ENDIF
2331:         ENDIF
2332:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2333:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2334:             THIS.grd_4c_Dados.Refresh()
2335:         ENDIF
2336:         THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2337:     ENDPROC
2338: 
2339:     *-- KeyPress na descricao do grupo: F4/Enter/Tab abre lookup por descricao
2340:     PROCEDURE TxtDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2341:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2342:             RETURN
2343:         ENDIF
2344:         LOCAL loc_cVal, loc_oForm
2345:         loc_cVal = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2346: 
2347:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2348:                     "SigCdGcr", "cursor_4c_GrupoLookup", ;
2349:                     "descrs", loc_cVal, ;
2350:                     "Grupos Cont" + CHR(225) + "beis", .T., .T., "")
2351:         IF VARTYPE(loc_oForm) = "O"
2352:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2353:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2354:             loc_oForm.Show()
2355:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2356:                 SELECT cursor_4c_GrupoLookup
2357:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2358:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2359:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2360:             ENDIF
2361:         ENDIF
2362:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntDsGrupo
2363:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2364:             THIS.grd_4c_Dados.Refresh()
2365:         ENDIF
2366:         THIS.this_cAntDsGrupo = THIS.txt_4c_CdGrupos.Value
2367:     ENDPROC
2368: 
2369:     *-- KeyPress no codigo da conta: F4/Enter/Tab abre lookup de contas
2370:     PROCEDURE TxtCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2371:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2372:             RETURN
2373:         ENDIF
2374:         LOCAL loc_cVal, loc_oForm, loc_cSQL
2375:         loc_cVal = ALLTRIM(THIS.txt_4c_CdContas.Value)
2376: 
2377:         IF !EMPTY(loc_cVal)
2378:             IF USED("cursor_4c_Contas") AND SEEK(loc_cVal, "cursor_4c_Contas", "IClis")
2379:                 SELECT cursor_4c_Contas
2380:                 THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2381:                 THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2382:                 THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2383:                 IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2384:                     ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2385:                     THIS.grd_4c_Dados.Refresh()
2386:                 ENDIF
2387:                 THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2388:                 RETURN
2389:             ENDIF
2390:         ELSE
2391:             THIS.txt_4c_DsContas.Value = ""
2392:             THIS.this_oBusinessObject.this_cCdContas = ""
2393:             IF THIS.this_cAntCdConta != ""
2394:                 ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2395:                 THIS.grd_4c_Dados.Refresh()
2396:             ENDIF
2397:             THIS.this_cAntCdConta = ""
2398:             RETURN
2399:         ENDIF
2400: 
2401:         *-- Nao encontrado: abrir picker usando SQLEXEC LIKE no cursor_4c_ContasLookup
2402:         THIS.AbrirLookupContas(loc_cVal, "C")
2403:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2404:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2405:             THIS.grd_4c_Dados.Refresh()
2406:         ENDIF
2407:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2408:     ENDPROC
2409: 
2410:     *-- KeyPress na descricao da conta: F4/Enter/Tab abre lookup por nome
2411:     PROCEDURE TxtDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2412:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2413:             RETURN
2414:         ENDIF
2415:         LOCAL loc_cVal
2416:         loc_cVal = ALLTRIM(THIS.txt_4c_DsContas.Value)
2417: 
2418:         THIS.AbrirLookupContas(loc_cVal, "D")
2419:         IF THIS.txt_4c_DsContas.Value != THIS.this_cAntDsConta
2420:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2421:             THIS.grd_4c_Dados.Refresh()
2422:         ENDIF
2423:         THIS.this_cAntDsConta = THIS.txt_4c_DsContas.Value
2424:     ENDPROC
2425: 
2426:     *-- AbrirLookupContas - Abre picker de contas bancarias via FormBuscaAuxiliar com Init params
2427:     *   par_cVal: valor digitado pelo usuario (prefixo para LIKE)
2428:     *   par_cModo: "C" busca por codigo (IClis), "D" busca por descricao (RClis)
2429:     PROCEDURE AbrirLookupContas(par_cVal, par_cModo)
2430:         LOCAL loc_cSQL, loc_cCampo, loc_oForm, loc_cGrupo
2431: 
2432:         loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2433: 
2434:         IF par_cModo = "C"
2435:             loc_cCampo = "IClis"
2436:             IF EMPTY(par_cVal)
2437:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2438:             ELSE
2439:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2440:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2441:             ENDIF
2442:         ELSE
2443:             loc_cCampo = "RClis"
2444:             IF EMPTY(par_cVal)
2445:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2446:             ELSE
2447:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2448:                            "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2449:             ENDIF
2450:         ENDIF
2451: 
2452:         IF !EMPTY(loc_cGrupo)
2453:             IF EMPTY(par_cVal)
2454:                 loc_cSQL = loc_cSQL + " WHERE RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2455:             ELSE
2456:                 loc_cSQL = loc_cSQL + " AND RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2457:             ENDIF
2458:         ENDIF
2459: 
2460:         loc_cSQL = loc_cSQL + " ORDER BY IClis"
2461: 
2462:         IF USED("cursor_4c_ContasLookup")
2463:             USE IN cursor_4c_ContasLookup
2464:         ENDIF
2465: 
2466:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasLookup") < 1
2467:             RETURN
2468:         ENDIF
2469: 
2470:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2471:                     "", "cursor_4c_ContasLookup", ;
2472:                     loc_cCampo, ALLTRIM(par_cVal), ;
2473:                     "Contas", .T., .T., "")
2474:         IF VARTYPE(loc_oForm) != "O"
2475:             RETURN
2476:         ENDIF
2477: 
2478:         loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2479:         loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
2480:         loc_oForm.Show()
2481: 
2482:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ContasLookup")
2483:             SELECT cursor_4c_ContasLookup
2484:             THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2485:             THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2486:             THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2487:         ENDIF
2488: 
2489:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2490:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2491:             THIS.grd_4c_Dados.Refresh()
2492:         ENDIF
2493:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2494:     ENDPROC
2495: 
2496:     *-- LostFocus do txt_4c_Chfin: padroniza para 6 digitos com zeros a esquerda
2497:     PROCEDURE TxtChfinLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2498:         IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)
2499:             THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ;
2500:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
2501:         ENDIF
2502:     ENDPROC
2503: 
2504:     *-- LostFocus do txt_4c_Chini: padroniza para 6 digitos com zeros a esquerda
2505:     PROCEDURE TxtChiniLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2506:         IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
2507:             THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ;
2508:                 PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
2509:         ENDIF
2510:     ENDPROC
2511: 
2512:     *==========================================================================
2513:     * --- ALIASES DE COMPATIBILIDADE COM PIPELINE MULTI-FASE ---
2514:     * OPERACIONAL nao tem Page1/Page2 CRUD; estes metodos existem para que
2515:     * o validador do pipeline encontre as assinaturas esperadas.
2516:     *==========================================================================
2517: 
2518:     *-- CarregarLista: alias de MontarCheques (pipeline exige este nome)
2519:     PROCEDURE CarregarLista()
2520:         RETURN THIS.MontarCheques(.F.)
2521:     ENDPROC
2522: 
2523:     *-- FormParaBO: sincroniza filtros da UI para o BO antes de processar
2524:     PROCEDURE FormParaBO()
2525:         THIS.this_oBusinessObject.this_cCdGrupos  = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2526:         THIS.this_oBusinessObject.this_cDsGrupos  = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
2527:         THIS.this_oBusinessObject.this_cCdContas  = ALLTRIM(THIS.txt_4c_CdContas.Value)
2528:         THIS.this_oBusinessObject.this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
2529:         THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
2530:         THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
2531:     ENDPROC
2532: 
2533:     *-- BOParaForm: alias de ExibirCheques (pipeline exige este nome)
2534:     PROCEDURE BOParaForm()
2535:         THIS.ExibirCheques(.F.)
2536:     ENDPROC
2537: 
2538:     *-- BtnSalvarClick: alias de BtnProcessarClick (mapeamento OPERACIONAL)
2539:     PROCEDURE BtnSalvarClick()
2540:         THIS.BtnProcessarClick()
2541:     ENDPROC
2542: 
2543:     *-- BtnCancelarClick: alias de BtnEncerrarClick (mapeamento OPERACIONAL)
2544:     PROCEDURE BtnCancelarClick()
2545:         THIS.BtnEncerrarClick()
2546:     ENDPROC
2547: 
2548:     *-- HabilitarCampos: stub N/A (OPERACIONAL gerencia habilitacao via AtualizarBotoesLinhaCorrente)
2549:     PROCEDURE HabilitarCampos(par_lHabilitar)
2550:         IF VARTYPE(THIS.txt_4c_CdGrupos) = "O"
2551:             THIS.txt_4c_CdGrupos.Enabled  = par_lHabilitar
2552:             THIS.txt_4c_DsGrupos.Enabled  = par_lHabilitar
2553:             THIS.txt_4c_CdContas.Enabled  = par_lHabilitar
2554:             THIS.txt_4c_DsContas.Enabled  = par_lHabilitar
2555:             THIS.txt_4c_DtInicial.Enabled = par_lHabilitar
2556:             THIS.txt_4c_DtFinal.Enabled   = par_lHabilitar
2557:         ENDIF
2558:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
2559:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
2560:         ENDIF
2561:     ENDPROC
2562: 
2563:     *-- BtnIncluirClick: stub N/A - OPERACIONAL nao tem modo INCLUIR
2564:     PROCEDURE BtnIncluirClick()
2565:         THIS.BtnDocumentoClick()
2566:     ENDPROC
2567: 
2568:     *-- BtnAlterarClick: stub N/A - OPERACIONAL nao tem modo ALTERAR
2569:     PROCEDURE BtnAlterarClick()
2570:         THIS.BtnDocumentoClick()
2571:     ENDPROC
2572: 
2573:     *-- BtnVisualizarClick: alias de BtnImprimirClick (visualizacao do cheque via FormSigReEch)
2574:     PROCEDURE BtnVisualizarClick()
2575:         THIS.BtnImprimirClick()
2576:     ENDPROC
2577: 
2578:     *-- BtnExcluirClick: alias de BtnExcluirChqClick (exclusao do cheque cancelado)
2579:     PROCEDURE BtnExcluirClick()
2580:         THIS.BtnExcluirChqClick()
2581:     ENDPROC
2582: 
2583:     *-- BtnBuscarClick: alias de BtnProcurarClick (mapeamento OPERACIONAL)
2584:     PROCEDURE BtnBuscarClick()
2585:         THIS.BtnProcurarClick()
2586:     ENDPROC
2587: 
2588:     *-- LimparCampos: reseta campos de filtro da UI (OPERACIONAL: limpa filtros, nao campos de dados)
2589:     PROCEDURE LimparCampos()
2590:         THIS.txt_4c_CdGrupos.Value  = ""
2591:         THIS.txt_4c_DsGrupos.Value  = ""
2592:         THIS.txt_4c_CdContas.Value  = ""
2593:         THIS.txt_4c_DsContas.Value  = ""
2594:         THIS.txt_4c_DtInicial.Value = DATE()
2595:         THIS.txt_4c_DtFinal.Value   = DATE()
2596:         THIS.txt_4c_Favorecido.Value = ""
2597:         THIS.this_cAntCdGrupo = ""
2598:         THIS.this_cAntDsGrupo = ""
2599:         THIS.this_cAntCdConta = ""
2600:         THIS.this_cAntDsConta = ""
2601:         THIS.this_dAntDtIni   = {}
2602:         THIS.this_dAntDtFin   = {}
2603:         THIS.this_oBusinessObject.this_cCdGrupos  = ""
2604:         THIS.this_oBusinessObject.this_cDsGrupos  = ""
2605:         THIS.this_oBusinessObject.this_cCdContas  = ""
2606:         THIS.this_oBusinessObject.this_cDsContas  = ""
2607:         THIS.this_oBusinessObject.this_dDtInicial = DATE()
2608:         THIS.this_oBusinessObject.this_dDtFinal   = DATE()
2609:     ENDPROC
2610: 
2611:     *-- AjustarBotoesPorModo: stub N/A (OPERACIONAL nao tem ciclo INCLUIR/ALTERAR/VISUALIZAR)
2612:     PROCEDURE AjustarBotoesPorModo()
2613:         THIS.AtualizarBotoesPermissao()
2614:         THIS.AtualizarBotoesLinhaCorrente()
2615:     ENDPROC
2616: 
2617:     *==========================================================================
2618:     PROCEDURE Destroy
2619:     *==========================================================================
2620:         IF USED("cursor_4c_Pgr")
2621:             USE IN cursor_4c_Pgr
2622:         ENDIF
2623:         IF USED("cursor_4c_MatrizTemp")
2624:             USE IN cursor_4c_MatrizTemp
2625:         ENDIF
2626:         IF USED("cursor_4c_ImpTemp")
2627:             USE IN cursor_4c_ImpTemp
2628:         ENDIF
2629:         IF USED("cursor_4c_GrupoOk")
2630:             USE IN cursor_4c_GrupoOk
2631:         ENDIF
2632:         IF USED("cursor_4c_GrupoLookup")
2633:             USE IN cursor_4c_GrupoLookup
2634:         ENDIF
2635:         IF USED("cursor_4c_ContasLookup")
2636:             USE IN cursor_4c_ContasLookup
2637:         ENDIF
2638:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2639:             THIS.this_oBusinessObject = .NULL.
2640:         ENDIF
2641:         DODEFAULT()
2642:     ENDPROC
2643: 
2644: ENDDEFINE

