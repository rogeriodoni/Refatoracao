# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'cmdsair' (parent: SIGPRITE): Left original=725 vs migrado 'shp_4c_CmdSair' Left=691 (diff=34px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprite.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1568 linhas total):

*-- Linhas 40 a 190:
40:     *-- Arquivo temporario para imagem do produto
41:     this_cArquivoTemp = ""
42: 
43:     *-- Mensagem de erro para InicializarForm
44:     this_cMensagemErro = ""
45: 
46:     *==========================================================================
47:     PROCEDURE Init(par_cEmp, par_cDop, par_nNum, par_lDis, par_cCnx)
48:     *==========================================================================
49:         IF PCOUNT() >= 4
50:             THIS.this_cEmp        = IIF(VARTYPE(par_cEmp) = "C", ALLTRIM(par_cEmp), "")
51:             THIS.this_cDop        = IIF(VARTYPE(par_cDop) = "C", ALLTRIM(par_cDop), "")
52:             THIS.this_nNum        = IIF(VARTYPE(par_nNum)  = "N", par_nNum, 0)
53:             THIS.this_lChecaDisps = IIF(VARTYPE(par_lDis)  = "L", par_lDis, .F.)
54:         ENDIF
55:         RETURN DODEFAULT()
56:     ENDPROC
57: 
58:     *==========================================================================
59:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
60:     *==========================================================================
61:     PROTECTED PROCEDURE InicializarForm()
62:         LOCAL loc_lSucesso, loc_oErro
63:         loc_lSucesso = .F.
64: 
65:         TRY
66:             THIS.this_oBusinessObject = CREATEOBJECT("sigpriteBO")
67: 
68:             *-- Aplicar background do form (equivalente ao Page.Picture do CRUD)
69:             THIS.ConfigurarPageFrame()
70: 
71:             *-- Verificar conexao antes de prosseguir
72:             IF gnConnHandle <= 0
73:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
74:                     MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + CHR(227) + "o " + ;
75:                             "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
76:                     loc_lSucesso = .F.
77:                 ENDIF
78:             ENDIF
79: 
80:             *-- Passar parametros para o BO
81:             THIS.this_oBusinessObject.this_cEmp        = THIS.this_cEmp
82:             THIS.this_oBusinessObject.this_cDop        = THIS.this_cDop
83:             THIS.this_oBusinessObject.this_nNum        = THIS.this_nNum
84:             THIS.this_oBusinessObject.this_lChecaDisps = THIS.this_lChecaDisps
85:             THIS.this_oBusinessObject.this_cEmpDopNum  = PADR(THIS.this_cEmp, 3) + ;
86:                                                          PADR(THIS.this_cDop, 20) + ;
87:                                                          STR(THIS.this_nNum, 6)
88: 
89:             *-- Arquivo temporario para imagem do produto
90:             THIS.this_cArquivoTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
91: 
92:             *-- Titulo do form: "Empresa - Operacao - Numero - Itens"
93:             THIS.Caption = THIS.this_cEmp + " - " + THIS.this_cDop + " - " + ;
94:                            ALLTRIM(STR(THIS.this_nNum, 6)) + " - Itens"
95: 
96:             *-- Inicializar cursores no BO
97:             THIS.this_oBusinessObject.InicializarCursores()
98: 
99:             *-- Carregar info da operacao (Imagems)
100:             IF gnConnHandle > 0
101:                 THIS.this_oBusinessObject.CarregarInfoOperacao(THIS.this_cDop)
102:             ENDIF
103: 
104:             *-- Construir interface visual
105:             THIS.LockScreen = .T.
106: 
107:             THIS.ConfigurarCabecalho()
108:             THIS.ConfigurarBotoesAcao()
109:             THIS.ConfigurarShapes()
110:             THIS.ConfigurarPaginaLista()
111:             THIS.TornarControlesVisiveis()
112:             THIS.ConfigurarBINDEVENTs()
113: 
114:             *-- Carregar dados (pular em modo de validacao de UI)
115:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
116:                 IF gnConnHandle > 0
117:                     THIS.CarregarItens()
118:                 ENDIF
119:             ENDIF
120: 
121:             THIS.LockScreen = .F.
122:             loc_lSucesso = .T.
123: 
124:         CATCH TO loc_oErro
125:             THIS.this_cMensagemErro = loc_oErro.Message
126:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
127:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
128:         ENDTRY
129: 
130:         RETURN loc_lSucesso
131:     ENDPROC
132: 
133:     *==========================================================================
134:     * ConfigurarPageFrame - Aplica background do form
135:     * Forms OPERACIONAIS nao usam PageFrame (layout customizado direto no Form),
136:     * mas o metodo eh mantido para compatibilidade com o padrao FormBase.
137:     * Aqui apenas define a imagem de fundo equivalente ao Page.Picture do CRUD.
138:     *==========================================================================
139:     PROTECTED PROCEDURE ConfigurarPageFrame()
140:         LOCAL loc_cImgFundo
141:         loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
142:         IF FILE(loc_cImgFundo)
143:             THIS.Picture = loc_cImgFundo
144:         ENDIF
145:     ENDPROC
146: 
147:     *==========================================================================
148:     * ConfigurarCabecalho - Container cinza superior com titulo
149:     *==========================================================================
150:     PROTECTED PROCEDURE ConfigurarCabecalho()
151:         THIS.AddObject("cnt_4c_Sombra", "Container")
152:         WITH THIS.cnt_4c_Sombra
153:             .Top         = 0
154:             .Left        = 0
155:             .Width       = THIS.Width
156:             .Height      = 80
157:             .BackColor   = RGB(100, 100, 100)
158:             .BorderWidth = 0
159:             .Visible     = .T.
160: 
161:             .AddObject("lbl_4c_Sombra", "Label")
162:             WITH .lbl_4c_Sombra
163:                 .Top           = 18
164:                 .Left          = 10
165:                 .AutoSize      = .F.
166:                 .Width         = THIS.Width
167:                 .Height        = 40
168:                 .FontBold      = .T.
169:                 .FontName      = "Tahoma"
170:                 .FontSize      = 18
171:                 .FontUnderline = .F.
172:                 .BackStyle     = 0
173:                 .WordWrap      = .T.
174:                 .Alignment     = 0
175:                 .ForeColor     = RGB(0, 0, 0)
176:                 .Caption       = THIS.Caption
177:                 .Visible       = .T.
178:             ENDWITH
179: 
180:             .AddObject("lbl_4c_Titulo", "Label")
181:             WITH .lbl_4c_Titulo
182:                 .Top           = 17
183:                 .Left          = 10
184:                 .AutoSize      = .F.
185:                 .Width         = THIS.Width
186:                 .Height        = 46
187:                 .FontBold      = .T.
188:                 .FontName      = "Tahoma"
189:                 .FontSize      = 18
190:                 .BackStyle     = 0

*-- Linhas 201 a 244:
201:     *==========================================================================
202:     * ConfigurarBotoesAcao - Botoes de acao: Encerrar, Subniveis, Entrega
203:     *==========================================================================
204:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
205:         *-- Botao Encerrar (cmdsair original - Top=3, Left=725 no legado 800px)
206:         *-- Proporcional para 1000px: Left = 917 (padrao canonico)
207:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
208:         WITH THIS.cmd_4c_Encerrar
209:             .Top            = 3
210:             .Left           = 917
211:             .Width          = 75
212:             .Height         = 75
213:             .Caption        = "Encerrar"
214:             .Cancel         = .T.
215:             .ToolTipText    = "[Esc] Encerrar"
216:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
217:             .FontBold       = .T.
218:             .FontItalic     = .T.
219:             .FontName       = "Comic Sans MS"
220:             .FontSize       = 8
221:             .ForeColor      = RGB(90, 90, 90)
222:             .BackColor      = RGB(255, 255, 255)
223:             .Themes           = .T.
224:             .SpecialEffect  = 0
225:             .PicturePosition = 13
226:             .MousePointer   = 15
227:             .WordWrap       = .T.
228:             .AutoSize       = .F.
229:             .Visible        = .T.
230:         ENDWITH
231: 
232:         *-- Botao Subniveis (Top=460, Left=691 no legado 800px)
233:         *-- Proporcional para 1000px: Left = 691 + 200 = 891 -> usar 691 (sem pgf, form nao tem pgf)
234:         *-- Legado original Left=691 em form 800px - manter proporcao em 1000px: Left=891-200=691
235:         *-- Na verdade o form nao tem pageframe entao manteremos os valores originais
236:         *-- O form operacional nao usa PageFrame, entao nao ha compensacao de Top
237:         THIS.AddObject("cmd_4c_Subniveis", "CommandButton")
238:         WITH THIS.cmd_4c_Subniveis
239:             .Top            = 460
240:             .Left           = 691
241:             .Width          = 75
242:             .Height         = 75
243:             .Caption        = "\<Subniveis"
244:             .Picture        = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"

*-- Linhas 285 a 328:
285:     *==========================================================================
286:     * ConfigurarShapes - Shapes decorativos do layout original
287:     *==========================================================================
288:     PROTECTED PROCEDURE ConfigurarShapes()
289:         *-- shpProdutos: borda ao redor da area de grids (Top=113, Left=21)
290:         THIS.AddObject("shp_4c_Produtos", "Shape")
291:         WITH THIS.shp_4c_Produtos
292:             .Top         = 113
293:             .Left        = 21
294:             .Height      = 320
295:             .Width       = 757
296:             .BackStyle   = 0
297:             .BorderColor = RGB(90, 90, 90)
298:             .Visible     = .T.
299:         ENDWITH
300: 
301:         *-- Shape5: borda ao redor da area de descricao/observacao (Top=438)
302:         THIS.AddObject("shp_4c_Descricao", "Shape")
303:         WITH THIS.shp_4c_Descricao
304:             .Top         = 438
305:             .Left        = 21
306:             .Height      = 121
307:             .Width       = 584
308:             .BackStyle   = 0
309:             .Curvature   = 0
310:             .BackColor   = RGB(255, 255, 255)
311:             .BorderColor = RGB(90, 90, 90)
312:             .Visible     = .T.
313:         ENDWITH
314: 
315:         *-- Shape1: borda ao redor do botao Encerrar (Top=7, Left=691)
316:         THIS.AddObject("shp_4c_CmdSair", "Shape")
317:         WITH THIS.shp_4c_CmdSair
318:             .Top         = 7
319:             .Left        = 691
320:             .Height      = 110
321:             .Width       = 90
322:             .BackStyle   = 0
323:             .BorderStyle = 0
324:             .BorderColor = RGB(136, 189, 188)
325:             .Visible     = .T.
326:         ENDWITH
327: 
328:         *-- shpDisps: indicador visual de disponibilidade (pequeno quadrado)

*-- Linhas 342 a 385:
342:     *==========================================================================
343:     * ConfigurarGrdCabec - Grid de cabecalho (informacoes da OP, 4 colunas)
344:     *==========================================================================
345:     PROTECTED PROCEDURE ConfigurarGrdCabec()
346:         THIS.AddObject("grd_4c_Cabec", "Grid")
347:         WITH THIS.grd_4c_Cabec
348:             .Top              = 118
349:             .Left             = 26
350:             .Width            = 731
351:             .Height           = 35
352:             .ColumnCount      = 4
353:             .FontName         = "Arial"
354:             .AllowHeaderSizing = .F.
355:             .AllowRowSizing   = .F.
356:             .DeleteMark       = .F.
357:             .RecordMark       = .F.
358:             .ReadOnly         = .T.
359:             .ScrollBars       = 0
360:             .HeaderHeight     = 17
361:             .Panel            = 1
362:             .RecordSource     = "cursor_4c_Itens"
363:             .Visible          = .T.
364: 
365:             *-- Coluna 1: Produto (codigo)
366:             WITH .Column1
367:                 .FontName       = "Arial"
368:                 .Width          = 226
369:                 .ReadOnly       = .T.
370:                 .ControlSource  = "cursor_4c_Itens.CPros"
371:                 WITH .Header1
372:                     .FontBold   = .T.
373:                     .FontName   = "Tahoma"
374:                     .FontSize   = 8
375:                     .Alignment  = 2
376:                     .Caption    = "Produto"
377:                 ENDWITH
378:                 WITH .Text1
379:                     .FontName   = "Arial"
380:                     .BorderStyle = 0
381:                     .Margin     = 0
382:                     .ReadOnly   = .T.
383:                     .ForeColor  = RGB(0, 0, 0)
384:                     .BackColor  = RGB(255, 255, 255)
385:                 ENDWITH

*-- Linhas 459 a 502:
459:     *==========================================================================
460:     * ConfigurarGrdItens - Grid principal de itens (11 colunas)
461:     *==========================================================================
462:     PROTECTED PROCEDURE ConfigurarGrdItens()
463:         THIS.AddObject("grd_4c_Itens", "Grid")
464:         WITH THIS.grd_4c_Itens
465:             .Top              = 135
466:             .Left             = 26
467:             .Width            = 750
468:             .Height           = 275
469:             .ColumnCount      = 11
470:             .FontName         = "Arial"
471:             .AllowHeaderSizing = .F.
472:             .AllowRowSizing   = .F.
473:             .DeleteMark       = .F.
474:             .RecordMark       = .F.
475:             .ReadOnly         = .T.
476:             .ScrollBars       = 2
477:             .HeaderHeight     = 17
478:             .RecordSource     = "cursor_4c_Itens"
479:             .HighlightBackColor = RGB(255, 255, 255)
480:             .HighlightForeColor = RGB(15, 41, 104)
481:             .HighlightStyle   = 2
482:             .Visible          = .T.
483: 
484:             *-- Col 1: CItens (sequencial do item - sem header)
485:             WITH .Column1
486:                 .FontName       = "Courier New"
487:                 .Width          = 31
488:                 .ReadOnly       = .T.
489:                 .ControlSource  = "cursor_4c_Itens.CItens"
490:                 .InputMask      = "999999"
491:                 WITH .Header1
492:                     .FontName   = "Tahoma"
493:                     .FontSize   = 8
494:                     .Alignment  = 2
495:                     .Caption    = ""
496:                 ENDWITH
497:                 WITH .Text1
498:                     .FontName   = "Courier New"
499:                     .BorderStyle = 0
500:                     .Margin     = 0
501:                     .ReadOnly   = .T.
502:                     .ForeColor  = RGB(0, 0, 0)

*-- Linhas 738 a 781:
738:     * Para forms OPERACIONAIS (sem PageFrame), este metodo agrupa os campos
739:     * de detalhe do item corrente, equivalente a Page2/Dados de CRUD.
740:     *==========================================================================
741:     PROTECTED PROCEDURE ConfigurarPaginaDados()
742:         *-- Label "Descricao Produto"
743:         THIS.AddObject("lbl_4c_DescricaoPro", "Label")
744:         WITH THIS.lbl_4c_DescricaoPro
745:             .Top        = 440
746:             .Left       = 30
747:             .FontSize   = 8
748:             .Caption    = "Descri" + CHR(231) + CHR(227) + "o Produto"
749:             .ForeColor  = RGB(90, 90, 90)
750:             .Visible    = .T.
751:         ENDWITH
752: 
753:         *-- TextBox somente-leitura para descricao do produto (Get_descr original)
754:         THIS.AddObject("txt_4c_Descr", "TextBox")
755:         WITH THIS.txt_4c_Descr
756:             .Top                  = 456
757:             .Left                 = 30
758:             .Width                = 396
759:             .Height               = 23
760:             .FontName             = "Tahoma"
761:             .FontSize             = 8
762:             .ControlSource        = "cursor_4c_Itens.DPros"
763:             .ReadOnly             = .T.
764:             .ForeColor            = RGB(0, 0, 0)
765:             .BackColor            = RGB(255, 255, 255)
766:             .DisabledBackColor    = RGB(255, 255, 255)
767:             .DisabledForeColor    = RGB(192, 192, 192)
768:             .BorderColor          = RGB(100, 100, 100)
769:             .Visible              = .T.
770:         ENDWITH
771: 
772:         *-- Label "Observacao Produto"
773:         THIS.AddObject("lbl_4c_ObsPro", "Label")
774:         WITH THIS.lbl_4c_ObsPro
775:             .Top        = 481
776:             .Left       = 30
777:             .FontSize   = 8
778:             .Caption    = "Observa" + CHR(231) + CHR(227) + "o Produto"
779:             .ForeColor  = RGB(90, 90, 90)
780:             .Visible    = .T.
781:         ENDWITH

*-- Linhas 823 a 866:
823:     *==========================================================================
824:     * ConfigurarGrdRodape - Grid de rodape com totais por moeda (11 colunas)
825:     *==========================================================================
826:     PROTECTED PROCEDURE ConfigurarGrdRodape()
827:         THIS.AddObject("grd_4c_Rodape", "Grid")
828:         WITH THIS.grd_4c_Rodape
829:             .Top              = 404
830:             .Left             = 26
831:             .Width            = 749
832:             .Height           = 25
833:             .ColumnCount      = 11
834:             .FontName         = "Arial"
835:             .AllowHeaderSizing = .F.
836:             .AllowRowSizing   = .F.
837:             .DeleteMark       = .F.
838:             .RecordMark       = .F.
839:             .ReadOnly         = .T.
840:             .ScrollBars       = 2
841:             .HeaderHeight     = 4
842:             .RecordSource     = "cursor_4c_Rodape"
843:             .Visible          = .T.
844: 
845:             *-- As colunas do rodape espelham as do grdItens em largura
846:             *-- mas exibem os totais acumulados por moeda (sem header caption)
847:             *-- Col 1: vazia (alinha com CItens do grdItens)
848:             WITH .Column1
849:                 .FontName       = "Courier New"
850:                 .Width          = 31
851:                 .ReadOnly       = .T.
852:                 .BackColor      = RGB(255, 255, 223)
853:                 .ControlSource  = "cursor_4c_Rodape.CPros"
854:                 WITH .Header1
855:                     .FontName   = "Tahoma"
856:                     .FontSize   = 8
857:                     .Alignment  = 2
858:                     .Caption    = ""
859:                     .BackColor  = RGB(255, 255, 0)
860:                 ENDWITH
861:                 WITH .Text1
862:                     .FontName   = "Courier New"
863:                     .BorderStyle = 0
864:                     .Margin     = 0
865:                     .ReadOnly   = .T.
866:                     .ForeColor  = RGB(0, 0, 0)

*-- Linhas 1106 a 1568:
1106:     * Para este form OPERACIONAL (sem PageFrame), agrupa a configuracao dos
1107:     * grids de cabecalho, itens, area de descricao/imagem e rodape de totais.
1108:     *==========================================================================
1109:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1110:         THIS.ConfigurarGrdCabec()
1111:         THIS.ConfigurarGrdItens()
1112:         THIS.ConfigurarPaginaDados()
1113:         THIS.ConfigurarGrdRodape()
1114:     ENDPROC
1115: 
1116:     *==========================================================================
1117:     * AlternarPagina - Atualiza a exibicao dos grids apos recarregar dados.
1118:     * Para este form OPERACIONAL sem PageFrame, nao ha alternancia de paginas:
1119:     * o metodo sincroniza os tres grids e forca refresh visual sem flickering.
1120:     *==========================================================================
1121:     PROCEDURE AlternarPagina()
1122:         THIS.LockScreen = .T.
1123:         IF USED("cursor_4c_Itens")
1124:             THIS.grd_4c_Cabec.Refresh
1125:             THIS.grd_4c_Itens.Refresh
1126:             THIS.grd_4c_Rodape.Refresh
1127:         ENDIF
1128:         THIS.Refresh
1129:         THIS.LockScreen = .F.
1130:     ENDPROC
1131: 
1132:     *==========================================================================
1133:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1134:     *==========================================================================
1135:     PROCEDURE TornarControlesVisiveis()
1136:         LOCAL loc_i, loc_oCtrl
1137:         FOR loc_i = 1 TO THIS.ControlCount
1138:             loc_oCtrl = THIS.Controls(loc_i)
1139:             IF VARTYPE(loc_oCtrl) = "O"
1140:                 *-- img_4c_FigJpg inicia oculta (gerenciada por AfterRowColChange)
1141:                 *-- shp_4c_Disps e lbl_4c_Disps dependem de this_lChecaDisps
1142:                 IF UPPER(loc_oCtrl.Name) = "IMG_4C_FIGJPG"
1143:                     LOOP
1144:                 ENDIF
1145:                 IF UPPER(loc_oCtrl.Name) = "SHP_4C_DISPS" OR ;
1146:                    UPPER(loc_oCtrl.Name) = "LBL_4C_DISPS"
1147:                     loc_oCtrl.Visible = THIS.this_lChecaDisps
1148:                     LOOP
1149:                 ENDIF
1150:                 loc_oCtrl.Visible = .T.
1151:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1152:                     LOCAL loc_j, loc_oFilho
1153:                     FOR loc_j = 1 TO loc_oCtrl.ControlCount
1154:                         loc_oFilho = loc_oCtrl.Controls(loc_j)
1155:                         IF VARTYPE(loc_oFilho) = "O"
1156:                             loc_oFilho.Visible = .T.
1157:                         ENDIF
1158:                     ENDFOR
1159:                 ENDIF
1160:             ENDIF
1161:         ENDFOR
1162:     ENDPROC
1163: 
1164:     *==========================================================================
1165:     * ConfigurarBINDEVENTs - Vincula eventos de interface
1166:     *==========================================================================
1167:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1168:         *-- Encerrar
1169:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
1170: 
1171:         *-- Subniveis
1172:         BINDEVENT(THIS.cmd_4c_Subniveis, "Click", THIS, "CmdSubniveisClick")
1173: 
1174:         *-- Entrega
1175:         BINDEVENT(THIS.cmd_4c_Entrega, "Click", THIS, "CmdEntregaClick")
1176: 
1177:         *-- Grid itens: mudar linha atualiza imagem e descricao
1178:         BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GrdItensAfterRowColChange")
1179: 
1180:         *-- Duplo clique no produto abre consulta de produto
1181:         BINDEVENT(THIS.grd_4c_Itens.Column2.Text1, "DblClick", THIS, "GrdItensProdutoDblClick")
1182: 
1183:         *-- GrdCabec: evitar foco no cabecalho (redirecionar para grdItens)
1184:         BINDEVENT(THIS.grd_4c_Cabec.Column1.Text1, "GotFocus", THIS, "GrdCabecGotFocus")
1185: 
1186:         *-- GrdRodape: evitar foco no rodape (redirecionar para grdItens)
1187:         BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", THIS, "GrdRodapeGotFocus")
1188: 
1189:         *-- Column2 de grdCabec: armazenar/restaurar valor (estabilidade visual)
1190:         BINDEVENT(THIS.grd_4c_Cabec.Column2.Text1,  "GotFocus",  THIS, "GrdCabecCol2GotFocus")
1191:         BINDEVENT(THIS.grd_4c_Cabec.Column2.Text1,  "KeyPress", THIS, "GrdCabecCol2LostFocus")
1192: 
1193:         *-- Column2 de grdRodape: armazenar/restaurar valor (estabilidade visual)
1194:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus",  THIS, "GrdRodapeCol2GotFocus")
1195:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "KeyPress", THIS, "GrdRodapeCol2LostFocus")
1196:     ENDPROC
1197: 
1198:     *==========================================================================
1199:     * CarregarItens - Executa a consulta SQL e popula os grids
1200:     *==========================================================================
1201:     PROCEDURE CarregarItens()
1202:         LOCAL loc_lResultado
1203:         loc_lResultado = THIS.this_oBusinessObject.BuscarItens()
1204: 
1205:         IF loc_lResultado
1206:             *-- DynamicForeColor: QtdSs=0 em azul, >0 em preto
1207:             THIS.grd_4c_Itens.SetAll("DynamicForeColor", ;
1208:                 "IIF(EMPTY(cursor_4c_Itens.QtdSs), RGB(0,0,255), RGB(0,0,0))", "Column")
1209: 
1210:             *-- DynamicBackColor para disponibilidade (so quando pDis=.T.)
1211:             IF THIS.this_lChecaDisps
1212:                 THIS.grd_4c_Itens.SetAll("DynamicBackColor", ;
1213:                     "IIF(cursor_4c_Itens.Disps < cursor_4c_Itens.QtdSs, " + ;
1214:                     "RGB(255,255,255), RGB(255,255,223))", "Column")
1215:             ENDIF
1216: 
1217:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1218:                 THIS.grd_4c_Itens.Refresh
1219:                 THIS.grd_4c_Rodape.Refresh
1220:                 THIS.grd_4c_Itens.Column1.SetFocus
1221:             ENDIF
1222:         ENDIF
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * GrdItensAfterRowColChange - Ao mudar linha: atualiza imagem do produto
1227:     *==========================================================================
1228:     PROCEDURE GrdItensAfterRowColChange(par_nColIndex)
1229:         THIS.LockScreen = .T.
1230: 
1231:         THIS.img_4c_FigJpg.Visible  = .F.
1232:         THIS.img_4c_FigJpg.Picture  = ""
1233: 
1234:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1235:             *-- Verificar se operacao tem imagem habilitada (Imagems=1)
1236:             IF THIS.this_oBusinessObject.this_nImagems = 1 AND ;
1237:                !EMPTY(cursor_4c_Itens.CPros)
1238:                 *-- Carregar imagem do produto
1239:                 IF THIS.this_oBusinessObject.CarregarImagemProduto( ;
1240:                         ALLTRIM(cursor_4c_Itens.CPros), THIS.this_cArquivoTemp)
1241:                     IF !EMPTY(THIS.this_oBusinessObject.this_cArquivo)
1242:                         THIS.img_4c_FigJpg.Picture = THIS.this_oBusinessObject.this_cArquivo
1243:                         THIS.img_4c_FigJpg.Visible = .T.
1244:                     ENDIF
1245:                 ENDIF
1246:             ENDIF
1247:         ENDIF
1248: 
1249:         THIS.grd_4c_Itens.Refresh
1250:         THIS.Refresh
1251:         THIS.txt_4c_Obs.Refresh
1252: 
1253:         THIS.LockScreen = .F.
1254:     ENDPROC
1255: 
1256:     *==========================================================================
1257:     * GrdItensProdutoDblClick - Duplo clique no codigo produto: abre SIGOPCGP
1258:     *==========================================================================
1259:     PROCEDURE GrdItensProdutoDblClick()
1260:         LOCAL loc_cCPros
1261:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1262:             loc_cCPros = ALLTRIM(cursor_4c_Itens.CPros)
1263:             IF !EMPTY(loc_cCPros)
1264:                 *-- Abrir form de consulta de produto (Formsigprccp ou equivalente)
1265:                 *-- O legado abria SIGOPCGP.SCX - no novo sistema usar equivalente migrado
1266:                 TRY
1267:                     IF VARTYPE(gobjExt1_sigprite) != "O" OR ISNULL(gobjExt1_sigprite)
1268:                         PUBLIC gobjExt1_sigprite
1269:                         gobjExt1_sigprite = CREATEOBJECT("Formsigprccp")
1270:                         IF VARTYPE(gobjExt1_sigprite) = "O"
1271:                             gobjExt1_sigprite.Show()
1272:                         ENDIF
1273:                     ENDIF
1274:                 CATCH TO loc_oErro
1275:                     MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1276:                             "Erro ao abrir Consulta de Produto")
1277:                 ENDTRY
1278:             ENDIF
1279:         ENDIF
1280:     ENDPROC
1281: 
1282:     *==========================================================================
1283:     * GrdCabecGotFocus - Redireciona foco do cabecalho para grdItens
1284:     *==========================================================================
1285:     PROCEDURE GrdCabecGotFocus()
1286:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1287:             THIS.grd_4c_Itens.Column1.SetFocus
1288:         ENDIF
1289:     ENDPROC
1290: 
1291:     *==========================================================================
1292:     * GrdRodapeGotFocus - Redireciona foco do rodape para grdItens
1293:     *==========================================================================
1294:     PROCEDURE GrdRodapeGotFocus()
1295:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1296:             THIS.grd_4c_Itens.Column1.SetFocus
1297:         ENDIF
1298:     ENDPROC
1299: 
1300:     *==========================================================================
1301:     * CmdEncerrarClick - Fecha o form
1302:     *==========================================================================
1303:     PROCEDURE CmdEncerrarClick()
1304:         THIS.Release()
1305:     ENDPROC
1306: 
1307:     *==========================================================================
1308:     * CmdSubniveisClick - Abre form de subniveis (SigMvMvt migrado)
1309:     *==========================================================================
1310:     PROCEDURE CmdSubniveisClick()
1311:         LOCAL loc_cEmp, loc_cDop, loc_nNum
1312:         loc_cEmp = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 1, 3)
1313:         loc_cDop = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 4, 20)
1314:         loc_nNum = INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 24, 6)))
1315: 
1316:         TRY
1317:             LOCAL loc_oFrmSub
1318:             loc_oFrmSub = CREATEOBJECT("FormSigMvMvt", .F., ;
1319:                           ALLTRIM(loc_cEmp), ALLTRIM(loc_cDop), loc_nNum)
1320:             IF VARTYPE(loc_oFrmSub) = "O"
1321:                 loc_oFrmSub.Show()
1322:             ENDIF
1323:         CATCH TO loc_oErro
1324:             MsgErro(loc_oErro.Message, "Erro ao abrir Subniveis")
1325:         ENDTRY
1326:     ENDPROC
1327: 
1328:     *==========================================================================
1329:     * CmdEntregaClick - Abre form de entrega (SigOpDen migrado)
1330:     *==========================================================================
1331:     PROCEDURE CmdEntregaClick()
1332:         LOCAL loc_cEmp, loc_cDop, loc_nNum
1333:         loc_cEmp = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 1, 3)
1334:         loc_cDop = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 4, 20)
1335:         loc_nNum = INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 24, 6)))
1336: 
1337:         TRY
1338:             LOCAL loc_oFrmEnt
1339:             loc_oFrmEnt = CREATEOBJECT("FormSigOpDen", ;
1340:                           ALLTRIM(loc_cEmp), ALLTRIM(loc_cDop), loc_nNum)
1341:             IF VARTYPE(loc_oFrmEnt) = "O"
1342:                 loc_oFrmEnt.Show()
1343:             ENDIF
1344:         CATCH TO loc_oErro
1345:             MsgErro(loc_oErro.Message, "Erro ao abrir Entrega")
1346:         ENDTRY
1347:     ENDPROC
1348: 
1349:     *==========================================================================
1350:     * GrdCabecCol2GotFocus / GrdCabecCol2LostFocus
1351:     * Armazena valor corrente em Tag e restaura ao perder foco (estabilidade
1352:     * visual da coluna separadora do grid de cabecalho - comportamento original)
1353:     *==========================================================================
1354:     PROCEDURE GrdCabecCol2GotFocus()
1355:         THIS.grd_4c_Cabec.Column2.Text1.Tag = TRANSFORM(THIS.grd_4c_Cabec.Column2.Text1.Value)
1356:     ENDPROC
1357: 
1358:     PROCEDURE GrdCabecCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1359:         IF !EMPTY(THIS.grd_4c_Cabec.Column2.Text1.Tag)
1360:             THIS.grd_4c_Cabec.Column2.Text1.Value = THIS.grd_4c_Cabec.Column2.Text1.Tag
1361:         ENDIF
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * GrdRodapeCol2GotFocus / GrdRodapeCol2LostFocus
1366:     * Idem para o grid de rodape (coluna 2 eh a descricao do produto - exibida
1367:     * em branco no rodape mas precisa preservar o valor entre focos)
1368:     *==========================================================================
1369:     PROCEDURE GrdRodapeCol2GotFocus()
1370:         THIS.grd_4c_Rodape.Column2.Text1.Tag = TRANSFORM(THIS.grd_4c_Rodape.Column2.Text1.Value)
1371:     ENDPROC
1372: 
1373:     PROCEDURE GrdRodapeCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1374:         IF !EMPTY(THIS.grd_4c_Rodape.Column2.Text1.Tag)
1375:             THIS.grd_4c_Rodape.Column2.Text1.Value = THIS.grd_4c_Rodape.Column2.Text1.Tag
1376:         ENDIF
1377:     ENDPROC
1378: 
1379:     *==========================================================================
1380:     * BtnVisualizarClick - Recarrega os itens da OP do banco (refresh do grid)
1381:     * Este form OPERACIONAL eh um viewer read-only. "Visualizar" equivale a
1382:     * recarregar do banco para refletir alteracoes feitas nas telas filhas
1383:     * (Subniveis, Entrega) que podem alterar quantidades baixadas/saldos.
1384:     *==========================================================================
1385:     PROCEDURE BtnVisualizarClick()
1386:         IF gnConnHandle <= 0
1387:             MsgErro("Sem conex" + CHR(227) + "o com o servidor de banco de dados.", ;
1388:                     "Conex" + CHR(227) + "o")
1389:             RETURN
1390:         ENDIF
1391: 
1392:         THIS.LockScreen = .T.
1393:         THIS.this_oBusinessObject.CarregarInfoOperacao(THIS.this_cDop)
1394:         THIS.CarregarItens()
1395:         THIS.LockScreen = .F.
1396:     ENDPROC
1397: 
1398:     *==========================================================================
1399:     * BtnIncluirClick - Abre o form de Subniveis (SigMvMvt)
1400:     * Este form OPERACIONAL nao insere itens diretamente (paridade com legado
1401:     * SIGPRITE.SCX). A inclusao de subniveis eh feita no form dedicado aberto
1402:     * via btnSubniveis. Este metodo redireciona para essa funcionalidade.
1403:     *==========================================================================
1404:     PROCEDURE BtnIncluirClick()
1405:         THIS.CmdSubniveisClick()
1406:     ENDPROC
1407: 
1408:     *==========================================================================
1409:     * BtnAlterarClick - Abre o form de Entrega (SigOpDen)
1410:     * A alteracao das quantidades baixadas/entregues eh feita no form dedicado
1411:     * aberto via btnEntrega (paridade com legado). Este metodo redireciona.
1412:     *==========================================================================
1413:     PROCEDURE BtnAlterarClick()
1414:         THIS.CmdEntregaClick()
1415:     ENDPROC
1416: 
1417:     *==========================================================================
1418:     * BtnExcluirClick - Encerra o form (equivalente ao cmdsair)
1419:     * Este form OPERACIONAL nao suporta exclusao de itens (paridade com legado
1420:     * SIGPRITE.SCX, que eh viewer read-only). A operacao encerra a janela.
1421:     *==========================================================================
1422:     PROCEDURE BtnExcluirClick()
1423:         THIS.Release()
1424:     ENDPROC
1425: 
1426:     *==========================================================================
1427:     * BtnEncerrarClick - Fecha o form (alias canonico para CmdEncerrarClick)
1428:     *==========================================================================
1429:     PROCEDURE BtnEncerrarClick()
1430:         THIS.CmdEncerrarClick()
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     * BtnBuscarClick - Recarrega itens do banco (alias para BtnVisualizarClick)
1435:     *==========================================================================
1436:     PROCEDURE BtnBuscarClick()
1437:         THIS.BtnVisualizarClick()
1438:     ENDPROC
1439: 
1440:     *==========================================================================
1441:     * BtnSalvarClick - Form OPERACIONAL viewer nao tem edicao: encerra
1442:     *==========================================================================
1443:     PROCEDURE BtnSalvarClick()
1444:         THIS.CmdEncerrarClick()
1445:     ENDPROC
1446: 
1447:     *==========================================================================
1448:     * BtnCancelarClick - Form OPERACIONAL viewer nao tem edicao: encerra
1449:     *==========================================================================
1450:     PROCEDURE BtnCancelarClick()
1451:         THIS.CmdEncerrarClick()
1452:     ENDPROC
1453: 
1454:     *==========================================================================
1455:     * CarregarLista - Alias canonico para CarregarItens
1456:     *==========================================================================
1457:     PROCEDURE CarregarLista()
1458:         THIS.CarregarItens()
1459:     ENDPROC
1460: 
1461:     *==========================================================================
1462:     * AjustarBotoesPorModo - Form viewer nao tem modos CRUD; sem alteracao
1463:     *==========================================================================
1464:     PROCEDURE AjustarBotoesPorModo()
1465:         IF VARTYPE(THIS.cmd_4c_Subniveis) = "O"
1466:             THIS.cmd_4c_Subniveis.Enabled = .T.
1467:         ENDIF
1468:         IF VARTYPE(THIS.cmd_4c_Entrega) = "O"
1469:             THIS.cmd_4c_Entrega.Enabled = .T.
1470:         ENDIF
1471:     ENDPROC
1472: 
1473:     *==========================================================================
1474:     * HabilitarCampos - Todos os controles sao somente-leitura neste viewer
1475:     *==========================================================================
1476:     PROCEDURE HabilitarCampos(par_lHabilitar)
1477:         LOCAL loc_lAtivo
1478:         loc_lAtivo = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1479:         IF VARTYPE(THIS.cmd_4c_Subniveis) = "O"
1480:             THIS.cmd_4c_Subniveis.Enabled = loc_lAtivo
1481:         ENDIF
1482:         IF VARTYPE(THIS.cmd_4c_Entrega) = "O"
1483:             THIS.cmd_4c_Entrega.Enabled = loc_lAtivo
1484:         ENDIF
1485:     ENDPROC
1486: 
1487:     *==========================================================================
1488:     * LimparCampos - Limpa os cursores e reseta a exibicao visual
1489:     *==========================================================================
1490:     PROCEDURE LimparCampos()
1491:         IF USED("cursor_4c_Itens")
1492:             SELECT cursor_4c_Itens
1493:             ZAP
1494:         ENDIF
1495:         IF USED("cursor_4c_Rodape")
1496:             SELECT cursor_4c_Rodape
1497:             ZAP
1498:         ENDIF
1499:         THIS.img_4c_FigJpg.Visible = .F.
1500:         THIS.img_4c_FigJpg.Picture = ""
1501:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
1502:             THIS.grd_4c_Itens.Refresh
1503:         ENDIF
1504:         IF VARTYPE(THIS.grd_4c_Rodape) = "O"
1505:             THIS.grd_4c_Rodape.Refresh
1506:         ENDIF
1507:     ENDPROC
1508: 
1509:     *==========================================================================
1510:     * FormParaBO - Form OPERACIONAL viewer: nao ha campos editaveis.
1511:     * Apenas atualiza os parametros de contexto no BO caso o chamador
1512:     * precise repassar novos valores de Emp/Dop/Num antes de recarregar.
1513:     *==========================================================================
1514:     PROCEDURE FormParaBO()
1515:         THIS.this_oBusinessObject.this_cEmp        = THIS.this_cEmp
1516:         THIS.this_oBusinessObject.this_cDop        = THIS.this_cDop
1517:         THIS.this_oBusinessObject.this_nNum        = THIS.this_nNum
1518:         THIS.this_oBusinessObject.this_lChecaDisps = THIS.this_lChecaDisps
1519:         THIS.this_oBusinessObject.this_cEmpDopNum  = PADR(THIS.this_cEmp, 3) + ;
1520:                                                      PADR(THIS.this_cDop, 20) + ;
1521:                                                      STR(THIS.this_nNum, 6)
1522:     ENDPROC
1523: 
1524:     *==========================================================================
1525:     * BOParaForm - Atualiza o titulo do form com base nos parametros correntes
1526:     * do BO. Os grids sao bound ao cursor via ControlSource; o refresh visual
1527:     * eh feito diretamente em CarregarItens/AlternarPagina.
1528:     *==========================================================================
1529:     PROCEDURE BOParaForm()
1530:         THIS.Caption = THIS.this_oBusinessObject.this_cEmp + " - " + ;
1531:                        THIS.this_oBusinessObject.this_cDop + " - " + ;
1532:                        ALLTRIM(STR(THIS.this_oBusinessObject.this_nNum, 6)) + " - Itens"
1533:         IF VARTYPE(THIS.cnt_4c_Sombra) = "O"
1534:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
1535:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
1536:         ENDIF
1537:     ENDPROC
1538: 
1539:     *==========================================================================
1540:     PROCEDURE Destroy()
1541:     *==========================================================================
1542:         LOCAL loc_oErro
1543:         *-- Limpar arquivo temporario de imagem
1544:         IF !EMPTY(THIS.this_cArquivoTemp) AND FILE(THIS.this_cArquivoTemp)
1545:             TRY
1546:                 ERASE (THIS.this_cArquivoTemp)
1547:             CATCH TO loc_oErro
1548:                 MsgErro(loc_oErro.Message, "Erro ao remover imagem tempor" + CHR(225) + "ria")
1549:             ENDTRY
1550:         ENDIF
1551: 
1552:         *-- Liberar cursores do BO
1553:         IF USED("cursor_4c_Itens")
1554:             USE IN cursor_4c_Itens
1555:         ENDIF
1556:         IF USED("cursor_4c_Rodape")
1557:             USE IN cursor_4c_Rodape
1558:         ENDIF
1559: 
1560:         *-- Liberar BO
1561:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1562:             THIS.this_oBusinessObject = .NULL.
1563:         ENDIF
1564: 
1565:         DODEFAULT()
1566:     ENDPROC
1567: 
1568: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpriteBO.prg):
*==============================================================================
* sigpriteBO.prg - Business Object para SIGPRITE (Itens de Ordem de Producao)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta de itens de OP - somente leitura)
*==============================================================================

DEFINE CLASS sigpriteBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros de contexto da OP
    *--------------------------------------------------------------------------
    this_cEmp        = ""    && Empresa (char 3)
    this_cDop        = ""    && Operacao/Documento (char 20)
    this_nNum        = 0     && Numero da OP (numeric 6,0)
    this_cEmpDopNum  = ""    && Chave concatenada: PADR(cEmp,3)+PADR(cDop,20)+STR(nNum,6) = char 29
    this_lChecaDisps = .F.   && Flag: verificar disponibilidade do produto

    *--------------------------------------------------------------------------
    * Item corrente (linha selecionada em grd_4c_Itens)
    *--------------------------------------------------------------------------
    this_nCItens  = 0     && Sequencial do item (numeric 10,0)
    this_cCPros   = ""    && Codigo produto (char 14)
    this_cDPros   = ""    && Descricao produto (char 65)
    this_cObs     = ""    && Observacao (text)
    this_cCUnis   = ""    && Unidade (char 3)
    this_nVolumes = 0     && Volume (numeric 3,0)
    this_cOpers   = ""    && Tipo operacao (char 1)
    this_nQtdOs   = 0     && Quantidade original/SigMvItn.Qtds (numeric 9,3)
    this_nQtdBs   = 0     && Quantidade baixada/SigMvItn.QtBaixas (numeric 9,3)
    this_nQtdSs   = 0     && Quantidade saldo calculada (Qtds - QtBaixas)
    this_nUnits   = 0     && Preco unitario/SigMvItn.Units (numeric 15,6)
    this_cCMoes   = ""    && Codigo moeda/SigMvItn.Moedas (char 3)
    this_nTotas   = 0     && Valor total/SigMvItn.Totas (numeric 11,2)
    this_nDisps   = 0     && Disponibilidade do produto (numeric 9,3)

    *--------------------------------------------------------------------------
    * Controle interno
    *--------------------------------------------------------------------------
    this_cArquivo  = ""    && Caminho arquivo temporario para imagem do produto
    this_nImagems  = 0     && SigCdOpe.Imagems: 1=exibir foto produto, 0=nao

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        THIS.this_cTabela     = "SigMvItn"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE InicializarCursores()
    *==========================================================================
        SET NULL ON
        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Itens (CItens n(10), CPros c(14), DPros c(40), ;
                Obs m(4), CUnis c(3), Volumes n(3), Opers c(1), ;
                QtdOs n(10,3), QtdBs n(10,3), QtdSs n(10,3), ;
                Units n(12,2), CMoes c(3), Totas n(12,2), Disps n(10,3))
        ENDIF
        IF USED("cursor_4c_Rodape")
            SELECT cursor_4c_Rodape
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Rodape (CPros c(14), Volumes n(3), ;
                QtdOs n(10,3), QtdBs n(10,3), QtdSs n(10,3), ;
                CMoes c(3), Totas n(12,2))
        ENDIF
        SET NULL OFF
    ENDPROC

    *==========================================================================
    PROCEDURE BuscarItens()
    *==========================================================================
        LOCAL loc_cSQL, loc_lResultado, loc_nRec
        loc_lResultado = .F.
        loc_nRec       = 0

        TRY
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT a.CItens, a.CPros, a.DPros, a.Obs, a.CUnis, c.Volumes, " + ;
                       "a.Opers, a.Qtds AS QtdOs, a.QtBaixas AS QtdBs, " + ;
                       "(a.Qtds - a.QtBaixas) AS QtdSs, a.Units, a.Moedas AS CMoes, a.Totas " + ;
                       "FROM SigMvItn a, SigCdOpe b, SigCdPro c " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNum) + ;
                       " AND a.Dopes = b.Dopes AND a.CPros = c.CPros " + ;
                       "ORDER BY a.CItens, a.CPros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") < 1
                MsgErro("Falha ao executar consulta de itens da OP.", "Erro SQL")
            ELSE
                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    ZAP
                ENDIF
                IF USED("cursor_4c_Rodape")
                    SELECT cursor_4c_Rodape
                    ZAP
                ENDIF

                *-- Popular cursor_4c_Itens (CItens = numero sequencial como no legado)
                SELECT cursor_4c_DadosTemp
                SCAN
                    loc_nRec = loc_nRec + 1
                    INSERT INTO cursor_4c_Itens ;
                        (CItens, CPros, DPros, Obs, CUnis, Volumes, Opers, ;
                         QtdOs, QtdBs, QtdSs, Units, CMoes, Totas, Disps) ;
                    VALUES ;
                        (loc_nRec, ;
                         cursor_4c_DadosTemp.CPros, ;
                         cursor_4c_DadosTemp.DPros, ;
                         NVL(cursor_4c_DadosTemp.Obs, ""), ;
                         cursor_4c_DadosTemp.CUnis, ;
                         cursor_4c_DadosTemp.Volumes, ;
                         cursor_4c_DadosTemp.Opers, ;
                         cursor_4c_DadosTemp.QtdOs, ;
                         cursor_4c_DadosTemp.QtdBs, ;
                         cursor_4c_DadosTemp.QtdSs, ;
                         cursor_4c_DadosTemp.Units, ;
                         cursor_4c_DadosTemp.CMoes, ;
                         cursor_4c_DadosTemp.Totas, ;
                         0)
                ENDSCAN

                *-- Popular cursor_4c_Rodape (totais por moeda)
                IF USED("cursor_4c_TotalTemp")
                    USE IN cursor_4c_TotalTemp
                ENDIF
                SELECT CMoes, SUM(Volumes) AS Volumes, SUM(QtdOs) AS QtdOs, ;
                       SUM(QtdBs) AS QtdBs, SUM(QtdSs) AS QtdSs, SUM(Totas) AS Totas ;
                  FROM cursor_4c_DadosTemp ;
                 GROUP BY CMoes ;
                  INTO CURSOR cursor_4c_TotalTemp READWRITE

                SELECT cursor_4c_TotalTemp
                SCAN
                    INSERT INTO cursor_4c_Rodape ;
                        (CPros, Volumes, QtdOs, QtdBs, QtdSs, CMoes, Totas) ;
                    VALUES ;
                        ("", ;
                         cursor_4c_TotalTemp.Volumes, ;
                         cursor_4c_TotalTemp.QtdOs, ;
                         cursor_4c_TotalTemp.QtdBs, ;
                         cursor_4c_TotalTemp.QtdSs, ;
                         cursor_4c_TotalTemp.CMoes, ;
                         cursor_4c_TotalTemp.Totas)
                ENDSCAN

                IF USED("cursor_4c_TotalTemp")
                    USE IN cursor_4c_TotalTemp
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF

                IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
                    GO TOP IN cursor_4c_Itens
                ENDIF
                IF USED("cursor_4c_Rodape") AND !EOF("cursor_4c_Rodape")
                    GO TOP IN cursor_4c_Rodape
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao buscar itens")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCItens  = NVL(CItens, 0)
            THIS.this_cCPros   = ALLTRIM(NVL(CPros, ""))
            THIS.this_cDPros   = ALLTRIM(NVL(DPros, ""))
            THIS.this_cObs     = NVL(Obs, "")
            THIS.this_cCUnis   = ALLTRIM(NVL(CUnis, ""))
            THIS.this_nVolumes = NVL(Volumes, 0)
            THIS.this_cOpers   = ALLTRIM(NVL(Opers, ""))
            THIS.this_nQtdOs   = NVL(QtdOs, 0)
            THIS.this_nQtdBs   = NVL(QtdBs, 0)
            THIS.this_nQtdSs   = NVL(QtdSs, 0)
            THIS.this_nUnits   = NVL(Units, 0)
            THIS.this_cCMoes   = ALLTRIM(NVL(CMoes, ""))
            THIS.this_nTotas   = NVL(Totas, 0)
            THIS.this_nDisps   = NVL(Disps, 0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarInfoOperacao(par_cDopes)
    *==========================================================================
        LOCAL loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_SigCdOpeInfo")
                USE IN cursor_4c_SigCdOpeInfo
            ENDIF

            loc_cSQL = "SELECT TOP 1 Imagems FROM SigCdOpe " + ;
                       "WHERE Dopes = " + EscaparSQL(PADR(par_cDopes, 20))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeInfo") > 0
                SELECT cursor_4c_SigCdOpeInfo
                IF !EOF()
                    THIS.this_nImagems = NVL(Imagems, 0)
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("cursor_4c_SigCdOpeInfo")
                USE IN cursor_4c_SigCdOpeInfo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao carregar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarImagemProduto(par_cCPros, par_cArquivo)
    *==========================================================================
        LOCAL loc_cSQL, loc_cFoto, loc_lResultado
        loc_lResultado       = .F.
        THIS.this_cArquivo   = ""

        TRY
            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF

            loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCPros)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgPro") > 0
                SELECT cursor_4c_ImgPro
                IF !EOF() AND !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
                    CLEAR RESOURCES
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, par_cArquivo)
                    THIS.this_cArquivo = par_cArquivo
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao carregar imagem do produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN PADR(THIS.this_cEmpDopNum, 29) + TRANSFORM(THIS.this_nCItens)
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida propriedades obrigatorias antes de Inserir/Atualizar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_cEmp)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cDop)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF THIS.this_nNum <= 0
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero da OP " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cCPros)
            THIS.this_cMensagemErro = "Produto " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF THIS.this_nQtdOs < 0
            THIS.this_cMensagemErro = "Quantidade n" + CHR(227) + "o pode ser negativa."
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cEmpDopNum)
            THIS.this_cEmpDopNum = PADR(THIS.this_cEmp, 3) + PADR(THIS.this_cDop, 20) + ;
                                    STR(THIS.this_nNum, 6)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigMvItn dos campos gerenciados pelo BO
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigMvItn " + ;
                       "(Emps, Dopes, Numes, EmpDopNums, CItens, CPros, DPros, Obs, " + ;
                       "CUnis, Opers, Qtds, QtBaixas, Units, Moedas, Totas, DtAlts) " + ;
                       "VALUES (" + ;
                       EscaparSQL(PADR(THIS.this_cEmp, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDop, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNum, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCItens, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCPros, 14)) + ", " + ;
                       EscaparSQL(PADR(LEFT(THIS.this_cDPros, 65), 65)) + ", " + ;
                       EscaparSQL(THIS.this_cObs) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCUnis, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cOpers, 1)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdBs, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCMoes, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas, 2) + ", " + ;
                       "GETDATE())"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao inserir item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em SigMvItn dos campos gerenciados pelo BO
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigMvItn SET " + ;
                       "CPros    = " + EscaparSQL(PADR(THIS.this_cCPros, 14)) + ", " + ;
                       "DPros    = " + EscaparSQL(PADR(LEFT(THIS.this_cDPros, 65), 65)) + ", " + ;
                       "Obs      = " + EscaparSQL(THIS.this_cObs) + ", " + ;
                       "CUnis    = " + EscaparSQL(PADR(THIS.this_cCUnis, 3)) + ", " + ;
                       "Opers    = " + EscaparSQL(PADR(THIS.this_cOpers, 1)) + ", " + ;
                       "Qtds     = " + FormatarNumeroSQL(THIS.this_nQtdOs, 3) + ", " + ;
                       "QtBaixas = " + FormatarNumeroSQL(THIS.this_nQtdBs, 3) + ", " + ;
                       "Units    = " + FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                       "Moedas   = " + EscaparSQL(PADR(THIS.this_cCMoes, 3)) + ", " + ;
                       "Totas    = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ", " + ;
                       "DtAlts   = GETDATE() " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + " " + ;
                       "  AND CItens = " + FormatarNumeroSQL(THIS.this_nCItens, 0)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigMvItn do item corrente
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + " " + ;
                       "  AND CItens = " + FormatarNumeroSQL(THIS.this_nCItens, 0)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao excluir item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

