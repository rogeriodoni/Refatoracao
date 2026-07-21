# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'cmdsair' (parent: SIGPRITE): Left original=725 vs migrado 'shp_4c_CmdSair' Left=917 (diff=192px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprite.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1578 linhas total):

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
219:             .FontName       = "Tahoma"
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
315:         *-- Shape1: borda ao redor do botao Encerrar
316:         THIS.AddObject("shp_4c_CmdSair", "Shape")
317:         WITH THIS.shp_4c_CmdSair
318:             .Top         = 7
319:             .Left        = 917
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

*-- Linhas 1106 a 1578:
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
1136:         LOCAL loc_i, loc_oCtrl, loc_j, loc_oFilho
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
1150:                 IF UPPER(loc_oCtrl.Name) = "CNT_4C_SOMBRA"
1151:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1152:                         FOR loc_j = 1 TO loc_oCtrl.ControlCount
1153:                             loc_oFilho = loc_oCtrl.Controls(loc_j)
1154:                             IF VARTYPE(loc_oFilho) = "O"
1155:                                 loc_oFilho.Visible = .T.
1156:                             ENDIF
1157:                         ENDFOR
1158:                     ENDIF
1159:                     LOOP
1160:                 ENDIF
1161:                 loc_oCtrl.Visible = .T.
1162:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1163:                     FOR loc_j = 1 TO loc_oCtrl.ControlCount
1164:                         loc_oFilho = loc_oCtrl.Controls(loc_j)
1165:                         IF VARTYPE(loc_oFilho) = "O"
1166:                             loc_oFilho.Visible = .T.
1167:                         ENDIF
1168:                     ENDFOR
1169:                 ENDIF
1170:             ENDIF
1171:         ENDFOR
1172:     ENDPROC
1173: 
1174:     *==========================================================================
1175:     * ConfigurarBINDEVENTs - Vincula eventos de interface
1176:     *==========================================================================
1177:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1178:         *-- Encerrar
1179:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
1180: 
1181:         *-- Subniveis
1182:         BINDEVENT(THIS.cmd_4c_Subniveis, "Click", THIS, "CmdSubniveisClick")
1183: 
1184:         *-- Entrega
1185:         BINDEVENT(THIS.cmd_4c_Entrega, "Click", THIS, "CmdEntregaClick")
1186: 
1187:         *-- Grid itens: mudar linha atualiza imagem e descricao
1188:         BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GrdItensAfterRowColChange")
1189: 
1190:         *-- Duplo clique no produto abre consulta de produto
1191:         BINDEVENT(THIS.grd_4c_Itens.Column2.Text1, "DblClick", THIS, "GrdItensProdutoDblClick")
1192: 
1193:         *-- GrdCabec: evitar foco no cabecalho (redirecionar para grdItens)
1194:         BINDEVENT(THIS.grd_4c_Cabec.Column1.Text1, "GotFocus", THIS, "GrdCabecGotFocus")
1195: 
1196:         *-- GrdRodape: evitar foco no rodape (redirecionar para grdItens)
1197:         BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", THIS, "GrdRodapeGotFocus")
1198: 
1199:         *-- Column2 de grdCabec: armazenar/restaurar valor (estabilidade visual)
1200:         BINDEVENT(THIS.grd_4c_Cabec.Column2.Text1,  "GotFocus",  THIS, "GrdCabecCol2GotFocus")
1201:         BINDEVENT(THIS.grd_4c_Cabec.Column2.Text1,  "KeyPress", THIS, "GrdCabecCol2LostFocus")
1202: 
1203:         *-- Column2 de grdRodape: armazenar/restaurar valor (estabilidade visual)
1204:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus",  THIS, "GrdRodapeCol2GotFocus")
1205:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "KeyPress", THIS, "GrdRodapeCol2LostFocus")
1206:     ENDPROC
1207: 
1208:     *==========================================================================
1209:     * CarregarItens - Executa a consulta SQL e popula os grids
1210:     *==========================================================================
1211:     PROCEDURE CarregarItens()
1212:         LOCAL loc_lResultado
1213:         loc_lResultado = THIS.this_oBusinessObject.BuscarItens()
1214: 
1215:         IF loc_lResultado
1216:             *-- DynamicForeColor: QtdSs=0 em azul, >0 em preto
1217:             THIS.grd_4c_Itens.SetAll("DynamicForeColor", ;
1218:                 "IIF(EMPTY(cursor_4c_Itens.QtdSs), RGB(0,0,255), RGB(0,0,0))", "Column")
1219: 
1220:             *-- DynamicBackColor para disponibilidade (so quando pDis=.T.)
1221:             IF THIS.this_lChecaDisps
1222:                 THIS.grd_4c_Itens.SetAll("DynamicBackColor", ;
1223:                     "IIF(cursor_4c_Itens.Disps < cursor_4c_Itens.QtdSs, " + ;
1224:                     "RGB(255,255,255), RGB(255,255,223))", "Column")
1225:             ENDIF
1226: 
1227:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1228:                 THIS.grd_4c_Itens.Refresh
1229:                 THIS.grd_4c_Rodape.Refresh
1230:                 THIS.grd_4c_Itens.Column1.SetFocus
1231:             ENDIF
1232:         ENDIF
1233:     ENDPROC
1234: 
1235:     *==========================================================================
1236:     * GrdItensAfterRowColChange - Ao mudar linha: atualiza imagem do produto
1237:     *==========================================================================
1238:     PROCEDURE GrdItensAfterRowColChange(par_nColIndex)
1239:         THIS.LockScreen = .T.
1240: 
1241:         THIS.img_4c_FigJpg.Visible  = .F.
1242:         THIS.img_4c_FigJpg.Picture  = ""
1243: 
1244:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1245:             *-- Verificar se operacao tem imagem habilitada (Imagems=1)
1246:             IF THIS.this_oBusinessObject.this_nImagems = 1 AND ;
1247:                !EMPTY(cursor_4c_Itens.CPros)
1248:                 *-- Carregar imagem do produto
1249:                 IF THIS.this_oBusinessObject.CarregarImagemProduto( ;
1250:                         ALLTRIM(cursor_4c_Itens.CPros), THIS.this_cArquivoTemp)
1251:                     IF !EMPTY(THIS.this_oBusinessObject.this_cArquivo)
1252:                         THIS.img_4c_FigJpg.Picture = THIS.this_oBusinessObject.this_cArquivo
1253:                         THIS.img_4c_FigJpg.Visible = .T.
1254:                     ENDIF
1255:                 ENDIF
1256:             ENDIF
1257:         ENDIF
1258: 
1259:         THIS.grd_4c_Itens.Refresh
1260:         THIS.Refresh
1261:         THIS.txt_4c_Obs.Refresh
1262: 
1263:         THIS.LockScreen = .F.
1264:     ENDPROC
1265: 
1266:     *==========================================================================
1267:     * GrdItensProdutoDblClick - Duplo clique no codigo produto: abre SIGOPCGP
1268:     *==========================================================================
1269:     PROCEDURE GrdItensProdutoDblClick()
1270:         LOCAL loc_cCPros
1271:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1272:             loc_cCPros = ALLTRIM(cursor_4c_Itens.CPros)
1273:             IF !EMPTY(loc_cCPros)
1274:                 *-- Abrir form de consulta de produto (Formsigprccp ou equivalente)
1275:                 *-- O legado abria SIGOPCGP.SCX - no novo sistema usar equivalente migrado
1276:                 TRY
1277:                     IF VARTYPE(gobjExt1_sigprite) != "O" OR ISNULL(gobjExt1_sigprite)
1278:                         PUBLIC gobjExt1_sigprite
1279:                         gobjExt1_sigprite = CREATEOBJECT("Formsigprccp")
1280:                         IF VARTYPE(gobjExt1_sigprite) = "O"
1281:                             gobjExt1_sigprite.Show()
1282:                         ENDIF
1283:                     ENDIF
1284:                 CATCH TO loc_oErro
1285:                     MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1286:                             "Erro ao abrir Consulta de Produto")
1287:                 ENDTRY
1288:             ENDIF
1289:         ENDIF
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * GrdCabecGotFocus - Redireciona foco do cabecalho para grdItens
1294:     *==========================================================================
1295:     PROCEDURE GrdCabecGotFocus()
1296:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1297:             THIS.grd_4c_Itens.Column1.SetFocus
1298:         ENDIF
1299:     ENDPROC
1300: 
1301:     *==========================================================================
1302:     * GrdRodapeGotFocus - Redireciona foco do rodape para grdItens
1303:     *==========================================================================
1304:     PROCEDURE GrdRodapeGotFocus()
1305:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1306:             THIS.grd_4c_Itens.Column1.SetFocus
1307:         ENDIF
1308:     ENDPROC
1309: 
1310:     *==========================================================================
1311:     * CmdEncerrarClick - Fecha o form
1312:     *==========================================================================
1313:     PROCEDURE CmdEncerrarClick()
1314:         THIS.Release()
1315:     ENDPROC
1316: 
1317:     *==========================================================================
1318:     * CmdSubniveisClick - Abre form de subniveis (SigMvMvt migrado)
1319:     *==========================================================================
1320:     PROCEDURE CmdSubniveisClick()
1321:         LOCAL loc_cEmp, loc_cDop, loc_nNum
1322:         loc_cEmp = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 1, 3)
1323:         loc_cDop = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 4, 20)
1324:         loc_nNum = INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 24, 6)))
1325: 
1326:         TRY
1327:             LOCAL loc_oFrmSub
1328:             loc_oFrmSub = CREATEOBJECT("FormSigMvMvt", .F., ;
1329:                           ALLTRIM(loc_cEmp), ALLTRIM(loc_cDop), loc_nNum)
1330:             IF VARTYPE(loc_oFrmSub) = "O"
1331:                 loc_oFrmSub.Show()
1332:             ENDIF
1333:         CATCH TO loc_oErro
1334:             MsgErro(loc_oErro.Message, "Erro ao abrir Subniveis")
1335:         ENDTRY
1336:     ENDPROC
1337: 
1338:     *==========================================================================
1339:     * CmdEntregaClick - Abre form de entrega (SigOpDen migrado)
1340:     *==========================================================================
1341:     PROCEDURE CmdEntregaClick()
1342:         LOCAL loc_cEmp, loc_cDop, loc_nNum
1343:         loc_cEmp = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 1, 3)
1344:         loc_cDop = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 4, 20)
1345:         loc_nNum = INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 24, 6)))
1346: 
1347:         TRY
1348:             LOCAL loc_oFrmEnt
1349:             loc_oFrmEnt = CREATEOBJECT("FormSigOpDen", ;
1350:                           ALLTRIM(loc_cEmp), ALLTRIM(loc_cDop), loc_nNum)
1351:             IF VARTYPE(loc_oFrmEnt) = "O"
1352:                 loc_oFrmEnt.Show()
1353:             ENDIF
1354:         CATCH TO loc_oErro
1355:             MsgErro(loc_oErro.Message, "Erro ao abrir Entrega")
1356:         ENDTRY
1357:     ENDPROC
1358: 
1359:     *==========================================================================
1360:     * GrdCabecCol2GotFocus / GrdCabecCol2LostFocus
1361:     * Armazena valor corrente em Tag e restaura ao perder foco (estabilidade
1362:     * visual da coluna separadora do grid de cabecalho - comportamento original)
1363:     *==========================================================================
1364:     PROCEDURE GrdCabecCol2GotFocus()
1365:         THIS.grd_4c_Cabec.Column2.Text1.Tag = TRANSFORM(THIS.grd_4c_Cabec.Column2.Text1.Value)
1366:     ENDPROC
1367: 
1368:     PROCEDURE GrdCabecCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1369:         IF !EMPTY(THIS.grd_4c_Cabec.Column2.Text1.Tag)
1370:             THIS.grd_4c_Cabec.Column2.Text1.Value = THIS.grd_4c_Cabec.Column2.Text1.Tag
1371:         ENDIF
1372:     ENDPROC
1373: 
1374:     *==========================================================================
1375:     * GrdRodapeCol2GotFocus / GrdRodapeCol2LostFocus
1376:     * Idem para o grid de rodape (coluna 2 eh a descricao do produto - exibida
1377:     * em branco no rodape mas precisa preservar o valor entre focos)
1378:     *==========================================================================
1379:     PROCEDURE GrdRodapeCol2GotFocus()
1380:         THIS.grd_4c_Rodape.Column2.Text1.Tag = TRANSFORM(THIS.grd_4c_Rodape.Column2.Text1.Value)
1381:     ENDPROC
1382: 
1383:     PROCEDURE GrdRodapeCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1384:         IF !EMPTY(THIS.grd_4c_Rodape.Column2.Text1.Tag)
1385:             THIS.grd_4c_Rodape.Column2.Text1.Value = THIS.grd_4c_Rodape.Column2.Text1.Tag
1386:         ENDIF
1387:     ENDPROC
1388: 
1389:     *==========================================================================
1390:     * BtnVisualizarClick - Recarrega os itens da OP do banco (refresh do grid)
1391:     * Este form OPERACIONAL eh um viewer read-only. "Visualizar" equivale a
1392:     * recarregar do banco para refletir alteracoes feitas nas telas filhas
1393:     * (Subniveis, Entrega) que podem alterar quantidades baixadas/saldos.
1394:     *==========================================================================
1395:     PROCEDURE BtnVisualizarClick()
1396:         IF gnConnHandle <= 0
1397:             MsgErro("Sem conex" + CHR(227) + "o com o servidor de banco de dados.", ;
1398:                     "Conex" + CHR(227) + "o")
1399:             RETURN
1400:         ENDIF
1401: 
1402:         THIS.LockScreen = .T.
1403:         THIS.this_oBusinessObject.CarregarInfoOperacao(THIS.this_cDop)
1404:         THIS.CarregarItens()
1405:         THIS.LockScreen = .F.
1406:     ENDPROC
1407: 
1408:     *==========================================================================
1409:     * BtnIncluirClick - Abre o form de Subniveis (SigMvMvt)
1410:     * Este form OPERACIONAL nao insere itens diretamente (paridade com legado
1411:     * SIGPRITE.SCX). A inclusao de subniveis eh feita no form dedicado aberto
1412:     * via btnSubniveis. Este metodo redireciona para essa funcionalidade.
1413:     *==========================================================================
1414:     PROCEDURE BtnIncluirClick()
1415:         THIS.CmdSubniveisClick()
1416:     ENDPROC
1417: 
1418:     *==========================================================================
1419:     * BtnAlterarClick - Abre o form de Entrega (SigOpDen)
1420:     * A alteracao das quantidades baixadas/entregues eh feita no form dedicado
1421:     * aberto via btnEntrega (paridade com legado). Este metodo redireciona.
1422:     *==========================================================================
1423:     PROCEDURE BtnAlterarClick()
1424:         THIS.CmdEntregaClick()
1425:     ENDPROC
1426: 
1427:     *==========================================================================
1428:     * BtnExcluirClick - Encerra o form (equivalente ao cmdsair)
1429:     * Este form OPERACIONAL nao suporta exclusao de itens (paridade com legado
1430:     * SIGPRITE.SCX, que eh viewer read-only). A operacao encerra a janela.
1431:     *==========================================================================
1432:     PROCEDURE BtnExcluirClick()
1433:         THIS.Release()
1434:     ENDPROC
1435: 
1436:     *==========================================================================
1437:     * BtnEncerrarClick - Fecha o form (alias canonico para CmdEncerrarClick)
1438:     *==========================================================================
1439:     PROCEDURE BtnEncerrarClick()
1440:         THIS.CmdEncerrarClick()
1441:     ENDPROC
1442: 
1443:     *==========================================================================
1444:     * BtnBuscarClick - Recarrega itens do banco (alias para BtnVisualizarClick)
1445:     *==========================================================================
1446:     PROCEDURE BtnBuscarClick()
1447:         THIS.BtnVisualizarClick()
1448:     ENDPROC
1449: 
1450:     *==========================================================================
1451:     * BtnSalvarClick - Form OPERACIONAL viewer nao tem edicao: encerra
1452:     *==========================================================================
1453:     PROCEDURE BtnSalvarClick()
1454:         THIS.CmdEncerrarClick()
1455:     ENDPROC
1456: 
1457:     *==========================================================================
1458:     * BtnCancelarClick - Form OPERACIONAL viewer nao tem edicao: encerra
1459:     *==========================================================================
1460:     PROCEDURE BtnCancelarClick()
1461:         THIS.CmdEncerrarClick()
1462:     ENDPROC
1463: 
1464:     *==========================================================================
1465:     * CarregarLista - Alias canonico para CarregarItens
1466:     *==========================================================================
1467:     PROCEDURE CarregarLista()
1468:         THIS.CarregarItens()
1469:     ENDPROC
1470: 
1471:     *==========================================================================
1472:     * AjustarBotoesPorModo - Form viewer nao tem modos CRUD; sem alteracao
1473:     *==========================================================================
1474:     PROCEDURE AjustarBotoesPorModo()
1475:         IF VARTYPE(THIS.cmd_4c_Subniveis) = "O"
1476:             THIS.cmd_4c_Subniveis.Enabled = .T.
1477:         ENDIF
1478:         IF VARTYPE(THIS.cmd_4c_Entrega) = "O"
1479:             THIS.cmd_4c_Entrega.Enabled = .T.
1480:         ENDIF
1481:     ENDPROC
1482: 
1483:     *==========================================================================
1484:     * HabilitarCampos - Todos os controles sao somente-leitura neste viewer
1485:     *==========================================================================
1486:     PROCEDURE HabilitarCampos(par_lHabilitar)
1487:         LOCAL loc_lAtivo
1488:         loc_lAtivo = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1489:         IF VARTYPE(THIS.cmd_4c_Subniveis) = "O"
1490:             THIS.cmd_4c_Subniveis.Enabled = loc_lAtivo
1491:         ENDIF
1492:         IF VARTYPE(THIS.cmd_4c_Entrega) = "O"
1493:             THIS.cmd_4c_Entrega.Enabled = loc_lAtivo
1494:         ENDIF
1495:     ENDPROC
1496: 
1497:     *==========================================================================
1498:     * LimparCampos - Limpa os cursores e reseta a exibicao visual
1499:     *==========================================================================
1500:     PROCEDURE LimparCampos()
1501:         IF USED("cursor_4c_Itens")
1502:             SELECT cursor_4c_Itens
1503:             ZAP
1504:         ENDIF
1505:         IF USED("cursor_4c_Rodape")
1506:             SELECT cursor_4c_Rodape
1507:             ZAP
1508:         ENDIF
1509:         THIS.img_4c_FigJpg.Visible = .F.
1510:         THIS.img_4c_FigJpg.Picture = ""
1511:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
1512:             THIS.grd_4c_Itens.Refresh
1513:         ENDIF
1514:         IF VARTYPE(THIS.grd_4c_Rodape) = "O"
1515:             THIS.grd_4c_Rodape.Refresh
1516:         ENDIF
1517:     ENDPROC
1518: 
1519:     *==========================================================================
1520:     * FormParaBO - Form OPERACIONAL viewer: nao ha campos editaveis.
1521:     * Apenas atualiza os parametros de contexto no BO caso o chamador
1522:     * precise repassar novos valores de Emp/Dop/Num antes de recarregar.
1523:     *==========================================================================
1524:     PROCEDURE FormParaBO()
1525:         THIS.this_oBusinessObject.this_cEmp        = THIS.this_cEmp
1526:         THIS.this_oBusinessObject.this_cDop        = THIS.this_cDop
1527:         THIS.this_oBusinessObject.this_nNum        = THIS.this_nNum
1528:         THIS.this_oBusinessObject.this_lChecaDisps = THIS.this_lChecaDisps
1529:         THIS.this_oBusinessObject.this_cEmpDopNum  = PADR(THIS.this_cEmp, 3) + ;
1530:                                                      PADR(THIS.this_cDop, 20) + ;
1531:                                                      STR(THIS.this_nNum, 6)
1532:     ENDPROC
1533: 
1534:     *==========================================================================
1535:     * BOParaForm - Atualiza o titulo do form com base nos parametros correntes
1536:     * do BO. Os grids sao bound ao cursor via ControlSource; o refresh visual
1537:     * eh feito diretamente em CarregarItens/AlternarPagina.
1538:     *==========================================================================
1539:     PROCEDURE BOParaForm()
1540:         THIS.Caption = THIS.this_oBusinessObject.this_cEmp + " - " + ;
1541:                        THIS.this_oBusinessObject.this_cDop + " - " + ;
1542:                        ALLTRIM(STR(THIS.this_oBusinessObject.this_nNum, 6)) + " - Itens"
1543:         IF VARTYPE(THIS.cnt_4c_Sombra) = "O"
1544:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
1545:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
1546:         ENDIF
1547:     ENDPROC
1548: 
1549:     *==========================================================================
1550:     PROCEDURE Destroy()
1551:     *==========================================================================
1552:         LOCAL loc_oErro
1553:         *-- Limpar arquivo temporario de imagem
1554:         IF !EMPTY(THIS.this_cArquivoTemp) AND FILE(THIS.this_cArquivoTemp)
1555:             TRY
1556:                 ERASE (THIS.this_cArquivoTemp)
1557:             CATCH TO loc_oErro
1558:                 MsgErro(loc_oErro.Message, "Erro ao remover imagem tempor" + CHR(225) + "ria")
1559:             ENDTRY
1560:         ENDIF
1561: 
1562:         *-- Liberar cursores do BO
1563:         IF USED("cursor_4c_Itens")
1564:             USE IN cursor_4c_Itens
1565:         ENDIF
1566:         IF USED("cursor_4c_Rodape")
1567:             USE IN cursor_4c_Rodape
1568:         ENDIF
1569: 
1570:         *-- Liberar BO
1571:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1572:             THIS.this_oBusinessObject = .NULL.
1573:         ENDIF
1574: 
1575:         DODEFAULT()
1576:     ENDPROC
1577: 
1578: ENDDEFINE


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

