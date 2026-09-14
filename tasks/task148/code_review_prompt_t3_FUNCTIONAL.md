# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Peso' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr.Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct.Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr.Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct.Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp7.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2077 linhas total):

*-- Linhas 49 a 116:
49:     * pQuery : filtro/query para a lista (WHERE livre ou valor de busca)
50:     * pForm  : referencia ao formulario pai que abriu este form
51:     *--------------------------------------------------------------------------
52:     PROCEDURE Init(par_cQuery, par_oFormPai)
53:         THIS.this_cPQuery    = IIF(VARTYPE(par_cQuery)   = "C", ALLTRIM(par_cQuery), "")
54:         THIS.this_oParentForm = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
55:         IF VARTYPE(par_oFormPai) = "O" AND PEMSTATUS(par_oFormPai, "cCodEmpresa", 5)
56:             THIS.this_cPEmps = ALLTRIM(par_oFormPai.cCodEmpresa)
57:         ENDIF
58:         RETURN DODEFAULT()
59:     ENDPROC
60: 
61:     *--------------------------------------------------------------------------
62:     * InicializarForm - Chamado pelo FormBase.Init()
63:     * Cria BO, cursores de trabalho, monta PageFrame e carrega lista inicial
64:     *--------------------------------------------------------------------------
65:     PROTECTED PROCEDURE InicializarForm()
66:         LOCAL loc_lSucesso
67:         loc_lSucesso = .F.
68: 
69:         TRY
70:             THIS.Caption = "Movimenta" + CHR(231) + CHR(227) + "o por Funcion" + CHR(225) + "rio"
71: 
72:             THIS.this_oBusinessObject = CREATEOBJECT("sigpdmp7BO")
73: 
74:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
75:                 MostrarErro("Erro ao criar sigpdmp7BO", "Erro Cr" + CHR(237) + "tico")
76:             ELSE
77:                 *-- Cursor placeholder para grid de lista (SigCdNec - colunas do SELECT do BO)
78:                 IF !USED("cursor_4c_Dados")
79:                     SET NULL ON
80:                     CREATE CURSOR cursor_4c_Dados (;
81:                         cidchaves C(20), empdnps C(33), emps C(3),;
82:                         dopps C(20), numps N(10,0), datas D,;
83:                         totpesos N(11,3), usuars C(10),;
84:                         grupoos C(10), contaos C(10),;
85:                         grupods C(10), contads C(10))
86:                     SET NULL OFF
87:                 ENDIF
88: 
89:                 *-- Cursor placeholder para GradeOperacao (TmpOperacao - legado: criacursor)
90:                 IF !USED("TmpOperacao")
91:                     SET NULL ON
92:                     CREATE CURSOR TmpOperacao (Codigos N(12,0))
93:                     SET NULL OFF
94:                 ENDIF
95: 
96:                 THIS.ConfigurarPageFrame()
97:                 THIS.ConfigurarPaginaLista()
98:                 THIS.ConfigurarPaginaDados()
99: 
100:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
101:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
102: 
103:                 *-- Inicializar empresa via sistema global se nao recebida via parametro
104:                 IF EMPTY(THIS.this_cPEmps) AND VARTYPE(go_4c_Sistema) = "O"
105:                     THIS.this_cPEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
106:                 ENDIF
107: 
108:                 THIS.pgf_4c_Paginas.Visible   = .T.
109:                 THIS.pgf_4c_Paginas.ActivePage = 1
110:                 THIS.this_cModoAtual = "LISTA"
111: 
112:                 *-- Nao executar SQL durante validacao de UI (sem conexao)
113:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
114:                     THIS.CarregarLista()
115:                 ENDIF
116: 

*-- Linhas 130 a 213:
130:     * Top=-29 oculta abas do PageFrame; todos os controles nas Pages: Top += 29
131:     * Legado: Pagina.Top=-29, Left=-1, Width=1005, Height=635
132:     *--------------------------------------------------------------------------
133:     PROTECTED PROCEDURE ConfigurarPageFrame()
134:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
135: 
136:         WITH THIS.pgf_4c_Paginas
137:             .Top       = -29
138:             .Left      = -1
139:             .Width     = 1005
140:             .Height    = 631   && 635-4: Tabs=.F. via AddObject adiciona +4 ao Page.Height em runtime
141:             .PageCount = 2
142:             .Tabs      = .F.
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
147:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
148:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
149: 
150:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
151:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
152:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
153:     ENDPROC
154: 
155:     *--------------------------------------------------------------------------
156:     * ConfigurarPaginaLista - Page1: cabecalho, container botoes CRUD (vazio),
157:     *   container saida com Encerrar
158:     * Compensacao PageFrame.Top=-29: controles de topo: Top += 29
159:     * Botoes CRUD e grid adicionados na Fase 4
160:     *--------------------------------------------------------------------------
161:     PROTECTED PROCEDURE ConfigurarPaginaLista()
162:         LOCAL loc_oPagina
163:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
164: 
165:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
166:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
167: 
168:         *-- Container de cabecalho (fundo cinza escuro com titulo)
169:         *-- Legado: cntSombra.Top=2->31 (comp.); Width=1100; BackColor=RGB(100,100,100)
170:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
171:         WITH loc_oPagina.cnt_4c_Cabecalho
172:             .Top         = 31
173:             .Left        = 0
174:             .Width       = 1003
175:             .Height      = 80
176:             .BackStyle   = 1
177:             .BackColor   = RGB(100, 100, 100)
178:             .BorderWidth = 0
179:             .Visible     = .T.
180:         ENDWITH
181: 
182:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
183:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
184:             .Caption   = THIS.Caption
185:             .Top       = 15
186:             .Left      = 10
187:             .Width     = 769
188:             .Height    = 40
189:             .FontName  = "Tahoma"
190:             .FontSize  = 16
191:             .FontBold  = .T.
192:             .ForeColor = RGB(0, 0, 0)
193:             .BackStyle = 0
194:             .Visible   = .T.
195:         ENDWITH
196: 
197:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
198:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
199:             .Caption   = THIS.Caption
200:             .Top       = 18
201:             .Left      = 10
202:             .Width     = 769
203:             .Height    = 46
204:             .FontName  = "Tahoma"
205:             .FontSize  = 16
206:             .FontBold  = .T.
207:             .ForeColor = RGB(255, 255, 255)
208:             .BackStyle = 0
209:             .Visible   = .T.
210:         ENDWITH
211: 
212:         *-- Container de botoes CRUD com 5 botoes de acao
213:         *-- Legado: Grupo_op.Left=542, Top=-1+29=28, Width=385, Height=85

*-- Linhas 382 a 442:
382:         ENDWITH
383: 
384:         *-- Vincular eventos dos botoes e do grid da Page1
385:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
386:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
387:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
388:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
391:         BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GridListaAfterRowColChange")
392: 
393:         THIS.TornarControlesVisiveis(loc_oPagina)
394:     ENDPROC
395: 
396:     *--------------------------------------------------------------------------
397:     * ConfigurarPaginaDados - Page2: todos os controles de edicao
398:     * Fase 5: cnt_4c_Dados (Codigo/Data/NomeOperacao) + cnt_4c_Origem (Grupo/Conta/Nome)
399:     * Fase 6: cnt_4c_Destino, cnt_4c_Responsavel, botoes de acao, grid, memo
400:     * Compensacao PageFrame.Top=-29: controles diretos na Page: Top += 29
401:     *--------------------------------------------------------------------------
402:     PROTECTED PROCEDURE ConfigurarPaginaDados()
403:         LOCAL loc_oPagina
404:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
405: 
406:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
407:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
408: 
409:         *----------------------------------------------------------------------
410:         *-- Container central de dados (cntDados - Top=117+29=146, Left=8)
411:         *-- Contem: Codigo, Data, label NomeOperacao
412:         *----------------------------------------------------------------------
413:         loc_oPagina.AddObject("cnt_4c_Dados", "Container")
414:         WITH loc_oPagina.cnt_4c_Dados
415:             .Top         = 146
416:             .Left        = 8
417:             .Width       = 571
418:             .Height      = 75
419:             .BackStyle   = 1
420:             .BackColor   = RGB(255, 255, 255)
421:             .BorderWidth = 0
422:             .Visible     = .T.
423:         ENDWITH
424: 
425:         *-- Linha separadora horizontal
426:         loc_oPagina.cnt_4c_Dados.AddObject("lin_4c_Line1", "Line")
427:         WITH loc_oPagina.cnt_4c_Dados.lin_4c_Line1
428:             .Top     = 22
429:             .Left    = 11
430:             .Width   = 340
431:             .Height  = 0
432:             .Visible = .T.
433:         ENDWITH
434: 
435:         *-- Label "C?digo " (Say2)
436:         loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label2", "Label")
437:         WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label2
438:             .Caption   = "C" + CHR(243) + "digo "
439:             .Top       = 6
440:             .Left      = 11
441:             .AutoSize  = .T.
442:             .BackStyle = 0

*-- Linhas 513 a 557:
513:             .Visible   = .T.
514:         ENDWITH
515: 
516:         *-- BINDEVENT: Valid da data valida periodo bloqueado (LostFocus no lugar do Valid do legado)
517:         BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data, "LostFocus", THIS, "ValidarDataMov")
518: 
519:         *----------------------------------------------------------------------
520:         *-- Container Origem (Origem.Top=198+29=227, Left=7, Width=571, Height=75)
521:         *-- Todos os campos sao somente leitura (When=Return .F. no legado)
522:         *-- Preenchidos automaticamente ao selecionar operacao
523:         *----------------------------------------------------------------------
524:         loc_oPagina.AddObject("cnt_4c_Origem", "Container")
525:         WITH loc_oPagina.cnt_4c_Origem
526:             .Top         = 227
527:             .Left        = 7
528:             .Width       = 571
529:             .Height      = 75
530:             .BackStyle   = 1
531:             .BackColor   = RGB(255, 255, 255)
532:             .BorderWidth = 0
533:             .Visible     = .T.
534:         ENDWITH
535: 
536:         *-- Label "Origem" (Say4)
537:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Label4", "Label")
538:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Label4
539:             .Caption   = "Origem"
540:             .Top       = 6
541:             .Left      = 11
542:             .AutoSize  = .T.
543:             .BackStyle = 0
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .FontBold  = .T.
547:             .ForeColor = RGB(90, 90, 90)
548:             .Visible   = .T.
549:         ENDWITH
550: 
551:         *-- Linha separadora Origem
552:         loc_oPagina.cnt_4c_Origem.AddObject("lin_4c_Line1", "Line")
553:         WITH loc_oPagina.cnt_4c_Origem.lin_4c_Line1
554:             .Top     = 22
555:             .Left    = 11
556:             .Width   = 340
557:             .Height  = 0

*-- Linhas 1152 a 1493:
1152:             .Visible            = .F.  && Inicia oculto (preenchido pelos sub-forms)
1153:         ENDWITH
1154: 
1155:         *-- Vincular RecordSource do grid ao cursor TmpOperacao (criado em InicializarForm)
1156:         IF USED("TmpOperacao")
1157:             loc_oPagina.grd_4c_Dados.RecordSource = "TmpOperacao"
1158:             loc_oPagina.grd_4c_Dados.Column1.ControlSource = "TmpOperacao.Codigos"
1159:         ENDIF
1160: 
1161:         *-- BINDEVENTs para botoes de acao da Page2
1162:         BINDEVENT(loc_oPagina.cmd_4c_Operacao,    "Click", THIS, "BtnOperacaoClick")
1163:         BINDEVENT(loc_oPagina.cmd_4c_Componentes, "Click", THIS, "BtnComponentesClick")
1164:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas,   "Click", THIS, "BtnEtiquetasClick")
1165:         BINDEVENT(loc_oPagina.cmd_4c_Dados,       "Click", THIS, "BtnDadosClick")
1166:         BINDEVENT(loc_oPagina.cmd_4c_Boleto,      "Click", THIS, "BtnBoletoClick")
1167:         BINDEVENT(loc_oPagina.cmd_4c_Documento,   "Click", THIS, "BtnDocumentoClick")
1168: 
1169:         *-- Vincular eventos dos botoes da Page2
1170:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1171:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1172: 
1173:         THIS.TornarControlesVisiveis(loc_oPagina)
1174: 
1175:         *-- Restaurar Visible=.F. do grid apos TornarControlesVisiveis (que seta tudo para .T.)
1176:         IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1177:             loc_oPagina.grd_4c_Dados.Visible = .F.
1178:         ENDIF
1179:     ENDPROC
1180: 
1181:     *--------------------------------------------------------------------------
1182:     * CarregarLista - Executa Buscar() no BO e atualiza o grid de lista
1183:     * O grid (grd_4c_Lista) e adicionado na Fase 4; usa PEMSTATUS para nao
1184:     * crashar quando chamado antes da Fase 4 ser aplicada
1185:     *--------------------------------------------------------------------------
1186:     PROCEDURE CarregarLista()
1187:         LOCAL loc_lResultado, loc_oGrid
1188:         loc_lResultado = .F.
1189: 
1190:         TRY
1191:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1192:                 loc_lResultado = .T.
1193:             ELSE
1194:                 IF !THIS.this_oBusinessObject.Buscar(THIS.this_cPQuery)
1195:                     loc_lResultado = .F.
1196:                 ELSE
1197:                     *-- Configurar grid quando existir (adicionado na Fase 4)
1198:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1199:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1200:                         loc_oGrid.ColumnCount = 9
1201:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1202:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numps"
1203:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
1204:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.totpesos"
1205:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.dopps"
1206:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.usuars"
1207:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupoos"
1208:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contaos"
1209:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.grupods"
1210:                         loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.contads"
1211:                         THIS.FormatarGridLista(loc_oGrid)
1212:                     ENDIF
1213:                     loc_lResultado = .T.
1214:                 ENDIF
1215:             ENDIF
1216:         CATCH TO loException
1217:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
1218:             loc_lResultado = .F.
1219:         ENDTRY
1220: 
1221:         RETURN loc_lResultado
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------
1225:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1226:     *--------------------------------------------------------------------------
1227:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1228:         LOCAL loc_lResultado
1229:         loc_lResultado = .F.
1230: 
1231:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1232:             loc_lResultado = .F.
1233:         ELSE
1234:             TRY
1235:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1236:                 IF par_nPagina = 1
1237:                     THIS.CarregarLista()
1238:                 ENDIF
1239:                 loc_lResultado = .T.
1240:             CATCH TO loException
1241:                 MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
1242:             ENDTRY
1243:         ENDIF
1244: 
1245:         RETURN loc_lResultado
1246:     ENDPROC
1247: 
1248:     *--------------------------------------------------------------------------
1249:     * FormatarGridLista - Aplica formatacao visual padrao ao grid de lista
1250:     *--------------------------------------------------------------------------
1251:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1252:         WITH par_oGrid
1253:             .FontName = "Tahoma"
1254:             .FontSize = 8
1255:         ENDWITH
1256:     ENDPROC
1257: 
1258:     *--------------------------------------------------------------------------
1259:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1260:     * Itera Pages de PageFrames e Controls de Containers
1261:     *--------------------------------------------------------------------------
1262:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1263:         LOCAL loc_nI, loc_oObjeto, loc_nP
1264: 
1265:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1266:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1267: 
1268:             IF VARTYPE(loc_oObjeto) = "O"
1269:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
1270:                    !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
1271:                     loc_oObjeto.Visible = .T.
1272:                 ENDIF
1273: 
1274:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1275:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1276:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1277:                     ENDFOR
1278:                 ENDIF
1279: 
1280:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1281:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1282:                 ENDIF
1283:             ENDIF
1284:         ENDFOR
1285:     ENDPROC
1286: 
1287:     *--------------------------------------------------------------------------
1288:     * GridListaAfterRowColChange - Atualiza this_cDopp ao mover linha no grid
1289:     *--------------------------------------------------------------------------
1290:     PROCEDURE GridListaAfterRowColChange(par_nColIndex)
1291:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1292:             SELECT cursor_4c_Dados
1293:             THIS.this_cDopp = ALLTRIM(cursor_4c_Dados.dopps)
1294:         ENDIF
1295:     ENDPROC
1296: 
1297:     *--------------------------------------------------------------------------
1298:     * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
1299:     *--------------------------------------------------------------------------
1300:     PROCEDURE BtnIncluirClick()
1301:         THIS.this_oBusinessObject.NovoRegistro()
1302:         THIS.LimparCampos()
1303:         THIS.this_cPcEscolha  = "INSERIR"
1304:         THIS.this_cModoAtual  = "INCLUIR"
1305:         THIS.HabilitarCampos(.T.)
1306:         THIS.AjustarBotoesPorModo()
1307:         THIS.AlternarPagina(2)
1308:     ENDPROC
1309: 
1310:     *--------------------------------------------------------------------------
1311:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
1312:     *--------------------------------------------------------------------------
1313:     PROCEDURE BtnVisualizarClick()
1314:         LOCAL loc_cCodigo
1315:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1316:             MsgAviso("Selecione um registro para visualizar.", "")
1317:             RETURN
1318:         ENDIF
1319:         SELECT cursor_4c_Dados
1320:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1321:         IF EMPTY(loc_cCodigo)
1322:             MsgAviso("Selecione um registro para visualizar.", "")
1323:             RETURN
1324:         ENDIF
1325:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1326:             THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
1327:             THIS.this_cPcEscolha = "CONSULTAR"
1328:             THIS.this_cModoAtual = "VISUALIZAR"
1329:             THIS.BOParaForm()
1330:             THIS.HabilitarCampos(.F.)
1331:             THIS.AjustarBotoesPorModo()
1332:             THIS.AlternarPagina(2)
1333:         ELSE
1334:             MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
1335:         ENDIF
1336:     ENDPROC
1337: 
1338:     *--------------------------------------------------------------------------
1339:     * BtnAlterarClick - Carrega registro selecionado para edicao
1340:     *--------------------------------------------------------------------------
1341:     PROCEDURE BtnAlterarClick()
1342:         LOCAL loc_cCodigo
1343:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1344:             MsgAviso("Selecione um registro para alterar.", "")
1345:             RETURN
1346:         ENDIF
1347:         SELECT cursor_4c_Dados
1348:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1349:         IF EMPTY(loc_cCodigo)
1350:             MsgAviso("Selecione um registro para alterar.", "")
1351:             RETURN
1352:         ENDIF
1353:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1354:             THIS.this_oBusinessObject.EditarRegistro()
1355:             THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
1356:             THIS.this_cPcEscolha = "ALTERAR"
1357:             THIS.this_cModoAtual = "ALTERAR"
1358:             THIS.BOParaForm()
1359:             THIS.HabilitarCampos(.T.)
1360:             THIS.AjustarBotoesPorModo()
1361:             THIS.AlternarPagina(2)
1362:         ELSE
1363:             MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
1364:         ENDIF
1365:     ENDPROC
1366: 
1367:     *--------------------------------------------------------------------------
1368:     * BtnExcluirClick - Confirma e exclui registro selecionado
1369:     *--------------------------------------------------------------------------
1370:     PROCEDURE BtnExcluirClick()
1371:         LOCAL loc_cCodigo
1372:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1373:             MsgAviso("Selecione um registro para excluir.", "")
1374:             RETURN
1375:         ENDIF
1376:         SELECT cursor_4c_Dados
1377:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1378:         IF EMPTY(loc_cCodigo)
1379:             MsgAviso("Selecione um registro para excluir.", "")
1380:             RETURN
1381:         ENDIF
1382:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirmar Exclus" + CHR(227) + "o")
1383:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1384:                 IF THIS.this_oBusinessObject.Excluir()
1385:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1386:                     THIS.CarregarLista()
1387:                 ELSE
1388:                     MsgErro("Erro ao excluir o registro.", "Erro")
1389:                 ENDIF
1390:             ELSE
1391:                 MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Erro")
1392:             ENDIF
1393:         ENDIF
1394:     ENDPROC
1395: 
1396:     *--------------------------------------------------------------------------
1397:     * BtnBuscarClick - Filtra lista por codigo, operacao ou usuario
1398:     *--------------------------------------------------------------------------
1399:     PROCEDURE BtnBuscarClick()
1400:         LOCAL loc_cFiltro
1401:         loc_cFiltro = INPUTBOX("Informe o c" + CHR(243) + "digo, opera" + CHR(231) + ;
1402:             CHR(227) + "o ou usu" + CHR(225) + "rio:", "Buscar")
1403:         IF VARTYPE(loc_cFiltro) = "C"
1404:             THIS.this_cPQuery = ALLTRIM(loc_cFiltro)
1405:             THIS.CarregarLista()
1406:         ENDIF
1407:     ENDPROC
1408: 
1409:     *--------------------------------------------------------------------------
1410:     * BtnEncerrarClick - Fecha o formulario
1411:     *--------------------------------------------------------------------------
1412:     PROCEDURE BtnEncerrarClick()
1413:         THIS.Release()
1414:     ENDPROC
1415: 
1416:     *--------------------------------------------------------------------------
1417:     * BtnSalvarClick - Transfere Form->BO e chama Salvar(); volta para lista
1418:     *--------------------------------------------------------------------------
1419:     PROCEDURE BtnSalvarClick()
1420:         LOCAL loc_lSucesso
1421:         loc_lSucesso = .F.
1422: 
1423:         TRY
1424:             THIS.FormParaBO()
1425:             IF THIS.this_oBusinessObject.Salvar()
1426:                 MsgInfo("Registro salvo com sucesso!", "")
1427:                 THIS.this_cModoAtual = "LISTA"
1428:                 THIS.AlternarPagina(1)
1429:                 loc_lSucesso = .T.
1430:             ELSE
1431:                 MsgErro("Erro ao salvar o registro.", "Erro")
1432:             ENDIF
1433:         CATCH TO loException
1434:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
1435:         ENDTRY
1436: 
1437:         RETURN loc_lSucesso
1438:     ENDPROC
1439: 
1440:     *--------------------------------------------------------------------------
1441:     * BtnCancelarClick - Cancela edicao e retorna para lista recarregada
1442:     *--------------------------------------------------------------------------
1443:     PROCEDURE BtnCancelarClick()
1444:         THIS.this_cModoAtual = "LISTA"
1445:         THIS.AlternarPagina(1)
1446:         THIS.CarregarLista()
1447:     ENDPROC
1448: 
1449:     *--------------------------------------------------------------------------
1450:     * FormParaBO - Transfere valores do formulario para o Business Object
1451:     * Usa PEMSTATUS para acessar controles da Page2 com seguranca
1452:     *--------------------------------------------------------------------------
1453:     PROTECTED PROCEDURE FormParaBO()
1454:         LOCAL loc_oPg2, loc_oBO
1455:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1456:         loc_oBO  = THIS.this_oBusinessObject
1457: 
1458:         *-- Empresa e operacao
1459:         loc_oBO.this_cEmps  = THIS.this_cPEmps
1460:         loc_oBO.this_cDopps = THIS.this_cDopp
1461: 
1462:         *-- Container central de dados (cntDados)
1463:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1464:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1465:                 loc_oBO.this_cCidchaves = ALLTRIM(loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value)
1466:             ENDIF
1467:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1468:                 loc_oBO.this_dDatas = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
1469:             ENDIF
1470:         ENDIF
1471: 
1472:         *-- Origem
1473:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1474:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1475:                 loc_oBO.this_cGrupoos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value)
1476:             ENDIF
1477:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1478:                 loc_oBO.this_cContaos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value)
1479:             ENDIF
1480:         ENDIF
1481: 
1482:         *-- Destino
1483:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1484:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1485:                 loc_oBO.this_cGrupods = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value)
1486:             ENDIF
1487:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1488:                 loc_oBO.this_cContads = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value)
1489:             ENDIF
1490:         ENDIF
1491: 
1492:         *-- Responsavel
1493:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)

*-- Linhas 1509 a 1552:
1509:     * BOParaForm - Transfere valores do Business Object para o formulario
1510:     * Usa PEMSTATUS para acessar controles da Page2 com seguranca
1511:     *--------------------------------------------------------------------------
1512:     PROTECTED PROCEDURE BOParaForm()
1513:         LOCAL loc_oPg2, loc_oBO
1514:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1515:         loc_oBO  = THIS.this_oBusinessObject
1516: 
1517:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1518:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1519:                 loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cCidchaves)
1520:             ENDIF
1521:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1522:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = loc_oBO.this_dDatas
1523:             ENDIF
1524:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
1525:                 loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ALLTRIM(loc_oBO.this_cDopps)
1526:             ENDIF
1527:         ENDIF
1528: 
1529:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1530:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1531:                 loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupoos)
1532:             ENDIF
1533:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1534:                 loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContaos)
1535:             ENDIF
1536:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
1537:                 loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
1538:             ENDIF
1539:         ENDIF
1540: 
1541:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1542:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1543:                 loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupods)
1544:             ENDIF
1545:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1546:                 loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContads)
1547:             ENDIF
1548:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
1549:                 loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
1550:             ENDIF
1551:         ENDIF
1552: 

*-- Linhas 1570 a 1613:
1570:     *--------------------------------------------------------------------------
1571:     * HabilitarCampos - Habilita/desabilita controles editaveis da Page2
1572:     *--------------------------------------------------------------------------
1573:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1574:         LOCAL loc_oPg2
1575:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1576: 
1577:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1578:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1579:                 loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Enabled = ;
1580:                     par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1581:             ENDIF
1582:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1583:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Enabled = par_lHabilitar
1584:             ENDIF
1585:         ENDIF
1586: 
1587:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1588:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1589:                 loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.ReadOnly = !par_lHabilitar
1590:             ENDIF
1591:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1592:                 loc_oPg2.cnt_4c_Origem.txt_4c_Conta.ReadOnly = !par_lHabilitar
1593:             ENDIF
1594:         ENDIF
1595: 
1596:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1597:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1598:                 loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.ReadOnly = !par_lHabilitar
1599:             ENDIF
1600:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1601:                 loc_oPg2.cnt_4c_Destino.txt_4c_Conta.ReadOnly = !par_lHabilitar
1602:             ENDIF
1603:         ENDIF
1604: 
1605:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
1606:             IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
1607:                 loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.ReadOnly = !par_lHabilitar
1608:             ENDIF
1609:             IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
1610:                 loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.ReadOnly = !par_lHabilitar
1611:             ENDIF
1612:         ENDIF
1613: 

*-- Linhas 1625 a 1668:
1625:     *--------------------------------------------------------------------------
1626:     * LimparCampos - Limpa valores dos controles da Page2
1627:     *--------------------------------------------------------------------------
1628:     PROTECTED PROCEDURE LimparCampos()
1629:         LOCAL loc_oPg2
1630:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1631: 
1632:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1633:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1634:                 loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ""
1635:             ENDIF
1636:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1637:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
1638:             ENDIF
1639:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
1640:                 loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ""
1641:             ENDIF
1642:         ENDIF
1643: 
1644:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1645:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1646:                 loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ""
1647:             ENDIF
1648:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1649:                 loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ""
1650:             ENDIF
1651:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
1652:                 loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
1653:             ENDIF
1654:         ENDIF
1655: 
1656:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1657:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1658:                 loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ""
1659:             ENDIF
1660:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1661:                 loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ""
1662:             ENDIF
1663:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
1664:                 loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
1665:             ENDIF
1666:         ENDIF
1667: 
1668:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)

*-- Linhas 1685 a 2077:
1685:     *--------------------------------------------------------------------------
1686:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
1687:     *--------------------------------------------------------------------------
1688:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1689:         LOCAL loc_oPg1, loc_oPg2, loc_lLista, loc_lEditar
1690:         loc_oPg1   = THIS.pgf_4c_Paginas.Page1
1691:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1692:         loc_lLista  = (THIS.this_cModoAtual = "LISTA")
1693:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1694: 
1695:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1696:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1697:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
1698:             ENDIF
1699:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1700:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
1701:             ENDIF
1702:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1703:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
1704:             ENDIF
1705:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1706:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
1707:             ENDIF
1708:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1709:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
1710:             ENDIF
1711:         ENDIF
1712: 
1713:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1714:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1715:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1716:             ENDIF
1717:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1718:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1719:             ENDIF
1720:         ENDIF
1721:     ENDPROC
1722: 
1723:     *--------------------------------------------------------------------------
1724:     * ValidarDataMov - Valida data da movimentacao ao sair do campo
1725:     * Legado: Dt_data.Valid - verifica fVerificaBloqueio e fBloqueioPorPeriodo
1726:     * No novo sistema: verifica se a data esta dentro do periodo permitido pelo BO
1727:     * Tambem bloqueia alteracao de data quando ja existem envelopes (TmpOperacao)
1728:     *--------------------------------------------------------------------------
1729:     PROCEDURE ValidarDataMov()
1730:         LOCAL loc_oPg2, loc_dData, loc_lBloqueado, loc_nContEnv
1731:         loc_lBloqueado = .F.
1732: 
1733:         TRY
1734:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1735: 
1736:             IF !PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1737:                 RETURN
1738:             ENDIF
1739:             IF !PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1740:                 RETURN
1741:             ENDIF
1742: 
1743:             loc_dData = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
1744: 
1745:             IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1746:                 RETURN
1747:             ENDIF
1748: 
1749:             IF EMPTY(loc_dData)
1750:                 MsgAviso("Informe uma data v" + CHR(225) + "lida.", "")
1751:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
1752:                 RETURN
1753:             ENDIF
1754: 
1755:             *-- Verifica se ja existem envelopes/ops lancados (TmpOperacao)
1756:             *-- Legado: Count to _LnCont For Codigos > 0
1757:             IF USED("TmpOperacao")
1758:                 SELECT TmpOperacao
1759:                 COUNT TO loc_nContEnv FOR Codigos > 0
1760:                 IF loc_nContEnv > 0
1761:                     MsgAviso("A Data s" + CHR(243) + "mente pode ser alterada antes de Informar Envelopes/Ops", "")
1762:                     loc_lBloqueado = .T.
1763:                 ENDIF
1764:             ENDIF
1765: 
1766:             *-- Verifica bloqueio de periodo no BO
1767:             IF !loc_lBloqueado
1768:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1769:                     IF THIS.this_oBusinessObject.VerificarPeriodoBloqueado(loc_dData)
1770:                         MsgAviso("Per" + CHR(237) + "odo Bloqueado!!!", "")
1771:                         loc_lBloqueado = .T.
1772:                     ENDIF
1773:                 ENDIF
1774:             ENDIF
1775: 
1776:             IF loc_lBloqueado
1777:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
1778:             ENDIF
1779: 
1780:         CATCH TO loException
1781:             MostrarErro("Erro ao validar data:" + CHR(13) + loException.Message, "Erro")
1782:         ENDTRY
1783:     ENDPROC
1784: 
1785:     *--------------------------------------------------------------------------
1786:     * BtnOperacaoClick - Abre sub-formulario de operacoes (legado: SigPdMp5)
1787:     * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xMfas -> Do Form SigPdMp5
1788:     *--------------------------------------------------------------------------
1789:     PROCEDURE BtnOperacaoClick()
1790:         LOCAL loc_cFormPath
1791:         IF THIS.this_cPcEscolha = "PROCURAR"
1792:             RETURN
1793:         ENDIF
1794:         TRY
1795:             THIS.Enabled = .F.
1796:             IF USED("xMfas")
1797:                 SELECT xMfas
1798:                 SET ORDER TO
1799:             ENDIF
1800:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp5.scx"
1801:             IF FILE(loc_cFormPath)
1802:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1803:             ELSE
1804:                 MsgAviso("Subformul" + CHR(225) + "rio de Opera" + CHR(231) + CHR(245) + "es (SigPdMp5) n" + ;
1805:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1806:             ENDIF
1807:             THIS.Enabled = .T.
1808:         CATCH TO loException
1809:             THIS.Enabled = .T.
1810:             MostrarErro("Erro ao abrir Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
1811:         ENDTRY
1812:     ENDPROC
1813: 
1814:     *--------------------------------------------------------------------------
1815:     * BtnComponentesClick - Abre sub-formulario de componentes (legado: SigPdMp2)
1816:     * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xNensi -> Do Form SigPdMp2
1817:     *--------------------------------------------------------------------------
1818:     PROCEDURE BtnComponentesClick()
1819:         LOCAL loc_cFormPath
1820:         IF THIS.this_cPcEscolha = "PROCURAR"
1821:             RETURN
1822:         ENDIF
1823:         TRY
1824:             THIS.Enabled = .F.
1825:             IF USED("xNensi")
1826:                 SELECT xNensi
1827:                 SET ORDER TO
1828:             ENDIF
1829:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp2.scx"
1830:             IF FILE(loc_cFormPath)
1831:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1832:             ELSE
1833:                 MsgAviso("Subformul" + CHR(225) + "rio de Componentes (SigPdMp2) n" + ;
1834:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1835:             ENDIF
1836:             THIS.Enabled = .T.
1837:         CATCH TO loException
1838:             THIS.Enabled = .T.
1839:             MostrarErro("Erro ao abrir Componentes:" + CHR(13) + loException.Message, "Erro")
1840:         ENDTRY
1841:     ENDPROC
1842: 
1843:     *--------------------------------------------------------------------------
1844:     * BtnEtiquetasClick - Abre sub-formulario de etiquetas/pesagem
1845:     * Legado: If pcEscolha<>'PROCURAR':
1846:     *   If crSigCdPam.AltPesas=1 -> Select xOpi -> Do Form SigPdMp3
1847:     *   Else -> Select xPesa -> Do Form SigPdMp9
1848:     *--------------------------------------------------------------------------
1849:     PROCEDURE BtnEtiquetasClick()
1850:         LOCAL loc_cFormPath, loc_lAltPesas
1851:         IF THIS.this_cPcEscolha = "PROCURAR"
1852:             RETURN
1853:         ENDIF
1854:         TRY
1855:             THIS.Enabled = .F.
1856:             loc_lAltPesas = .F.
1857: 
1858:             *-- Verifica flag AltPesas no cursor de parametros (crSigCdPam)
1859:             IF USED("crSigCdPam") AND PEMSTATUS(crSigCdPam, "AltPesas", 8)
1860:                 loc_lAltPesas = (crSigCdPam.AltPesas = 1)
1861:             ENDIF
1862: 
1863:             IF loc_lAltPesas
1864:                 IF USED("xOpi")
1865:                     SELECT xOpi
1866:                     GO TOP
1867:                 ENDIF
1868:                 loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp3.scx"
1869:                 IF FILE(loc_cFormPath)
1870:                     DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1871:                 ELSE
1872:                     MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp3) n" + ;
1873:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1874:                 ENDIF
1875:             ELSE
1876:                 IF USED("xPesa")
1877:                     SELECT xPesa
1878:                     GO TOP
1879:                 ENDIF
1880:                 loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp9.scx"
1881:                 IF FILE(loc_cFormPath)
1882:                     DO FORM (loc_cFormPath) WITH THIS
1883:                 ELSE
1884:                     MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp9) n" + ;
1885:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1886:                 ENDIF
1887:             ENDIF
1888:             THIS.Enabled = .T.
1889:         CATCH TO loException
1890:             THIS.Enabled = .T.
1891:             MostrarErro("Erro ao abrir Etiquetas:" + CHR(13) + loException.Message, "Erro")
1892:         ENDTRY
1893:     ENDPROC
1894: 
1895:     *--------------------------------------------------------------------------
1896:     * BtnDadosClick - Abre sub-formulario de complemento de dados (legado: SigOpInf)
1897:     * Legado: Do Form SigOpInf With ThisForm, ThisForm.DataSessionId
1898:     *--------------------------------------------------------------------------
1899:     PROCEDURE BtnDadosClick()
1900:         LOCAL loc_cFormPath
1901:         TRY
1902:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpInf.scx"
1903:             IF FILE(loc_cFormPath)
1904:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1905:             ELSE
1906:                 MsgAviso("Subformul" + CHR(225) + "rio de Complemento (SigOpInf) n" + ;
1907:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1908:             ENDIF
1909:         CATCH TO loException
1910:             MostrarErro("Erro ao abrir Complemento:" + CHR(13) + loException.Message, "Erro")
1911:         ENDTRY
1912:     ENDPROC
1913: 
1914:     *--------------------------------------------------------------------------
1915:     * BtnBoletoClick - Impressao de boleto se operacao permite
1916:     * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Boletos=1 -> ImpBol()
1917:     *--------------------------------------------------------------------------
1918:     PROCEDURE BtnBoletoClick()
1919:         LOCAL loc_lPermite
1920:         loc_lPermite = .F.
1921:         TRY
1922:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
1923:                 SELECT crSigCdOpd
1924:                 SET NEAR ON
1925:                 SEEK THIS.this_cDopp ORDER TAG Dopps
1926:                 SET NEAR OFF
1927:                 IF FOUND() AND !EOF("crSigCdOpd")
1928:                     loc_lPermite = (crSigCdOpd.Boletos = 1)
1929:                 ENDIF
1930:             ENDIF
1931:             IF loc_lPermite
1932:                 THIS.ImpBol()
1933:             ELSE
1934:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
1935:                     "o permite impress" + CHR(227) + "o de boleto.", "")
1936:             ENDIF
1937:         CATCH TO loException
1938:             MostrarErro("Erro ao imprimir boleto:" + CHR(13) + loException.Message, "Erro")
1939:         ENDTRY
1940:     ENDPROC
1941: 
1942:     *--------------------------------------------------------------------------
1943:     * BtnDocumentoClick - Impressao de documento se operacao permite
1944:     * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Docus=1 -> Do SigPrIdc
1945:     *--------------------------------------------------------------------------
1946:     PROCEDURE BtnDocumentoClick()
1947:         LOCAL loc_lPermite, loc_cPrgPath
1948:         loc_lPermite = .F.
1949:         TRY
1950:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
1951:                 SELECT crSigCdOpd
1952:                 SET NEAR ON
1953:                 SEEK THIS.this_cDopp ORDER TAG Dopps
1954:                 SET NEAR OFF
1955:                 IF FOUND() AND !EOF("crSigCdOpd")
1956:                     loc_lPermite = (crSigCdOpd.Docus = 1)
1957:                 ENDIF
1958:             ENDIF
1959:             IF loc_lPermite AND USED("TmpNens") AND !EOF("TmpNens")
1960:                 SELECT TmpNens
1961: 
1962:                 *-- Atualiza cursor crSigCdNec para registro corrente
1963:                 IF USED("crSigCdOpd")
1964:                     SELECT crSigCdOpd
1965:                     SET NEAR ON
1966:                     SEEK ALLTRIM(TmpNens.Dopps) ORDER TAG Dopps
1967:                     SET NEAR OFF
1968:                 ENDIF
1969: 
1970:                 loc_cPrgPath = gc_4c_CaminhoBase + "..\Framework\SigPrIdc.prg"
1971:                 IF FILE(loc_cPrgPath)
1972:                     DO (loc_cPrgPath) WITH ;
1973:                         ALLTRIM(TmpNens.Emps), ALLTRIM(TmpNens.Dopps), TmpNens.Numps, ;
1974:                         0, crSigCdOpd.QtdDocs, .F., .F., .F., .F., .F., .F., THIS
1975:                 ELSE
1976:                     MsgAviso("Rotina de impress" + CHR(227) + "o de documento (SigPrIdc) n" + ;
1977:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1978:                 ENDIF
1979:             ELSE
1980:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
1981:                     "o permite impress" + CHR(227) + "o de documento.", "")
1982:             ENDIF
1983:         CATCH TO loException
1984:             MostrarErro("Erro ao imprimir documento:" + CHR(13) + loException.Message, "Erro")
1985:         ENDTRY
1986:     ENDPROC
1987: 
1988:     *--------------------------------------------------------------------------
1989:     * ImpBol - Impressao de boleto via sub-formulario SigOpIbo
1990:     * Legado: Do Form SigOpIbo With Thisform, 2, This.Titulo
1991:     *--------------------------------------------------------------------------
1992:     PROCEDURE ImpBol()
1993:         LOCAL loc_cFormPath
1994:         TRY
1995:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpIbo.scx"
1996:             IF FILE(loc_cFormPath)
1997:                 DO FORM (loc_cFormPath) WITH THIS, 2, THIS.this_cTitulo
1998:             ELSE
1999:                 MsgAviso("Subformul" + CHR(225) + "rio de boleto (SigOpIbo) n" + ;
2000:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
2001:             ENDIF
2002:         CATCH TO loException
2003:             MostrarErro("Erro ao imprimir boleto (ImpBol):" + CHR(13) + loException.Message, "Erro")
2004:         ENDTRY
2005:     ENDPROC
2006: 
2007:     *--------------------------------------------------------------------------
2008:     * Activate - Gerencia foco automatico ao ativar o formulario
2009:     * Legado: Activate -> Seek(Dopp, crSigCdOpd, Dopps) + SetFocus nos campos
2010:     * this_lAtFoco controla se deve setar foco (evita loop na 1a abertura)
2011:     *--------------------------------------------------------------------------
2012:     PROCEDURE Activate()
2013:         LOCAL loc_oPg2
2014:         TRY
2015:             DODEFAULT()
2016: 
2017:             *-- Posiciona cursor de operacoes no Dopp corrente
2018:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
2019:                 SELECT crSigCdOpd
2020:                 SET NEAR ON
2021:                 SEEK THIS.this_cDopp ORDER TAG Dopps
2022:                 SET NEAR OFF
2023:             ENDIF
2024: 
2025:             *-- Coloca foco no campo adequado conforme modo
2026:             IF THIS.this_lAtFoco
2027:                 THIS.this_lAtFoco = .F.
2028:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2029: 
2030:                 DO CASE
2031:                     CASE THIS.this_cPcEscolha = "PROCURAR"
2032:                         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5) AND ;
2033:                            PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
2034:                             loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.SetFocus
2035:                         ENDIF
2036: 
2037:                     CASE INLIST(THIS.this_cPcEscolha, "CONSULTAR", "EXCLUIR")
2038:                         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5) AND ;
2039:                            PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
2040:                             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
2041:                         ENDIF
2042:                 ENDCASE
2043:             ENDIF
2044: 
2045:             *-- Garantir cursor TmpNens no topo se disponivel
2046:             IF USED("TmpNens")
2047:                 SELECT TmpNens
2048:                 GO TOP
2049:             ENDIF
2050: 
2051:         CATCH TO loException
2052:             *-- Erros de foco nao devem travar a interface
2053:         ENDTRY
2054:     ENDPROC
2055: 
2056:     *--------------------------------------------------------------------------
2057:     * Destroy - Libera recursos ao fechar o formulario
2058:     *--------------------------------------------------------------------------
2059:     PROCEDURE Destroy()
2060:         LOCAL loc_oErro
2061:         TRY
2062:             IF USED("cursor_4c_Dados")
2063:                 USE IN cursor_4c_Dados
2064:             ENDIF
2065:             IF USED("TmpOperacao")
2066:                 USE IN TmpOperacao
2067:             ENDIF
2068:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2069:                 THIS.this_oBusinessObject = .NULL.
2070:             ENDIF
2071:         CATCH TO loc_oErro
2072:             *-- Ignorar erros no Destroy para nao bloquear fechamento
2073:         ENDTRY
2074:         DODEFAULT()
2075:     ENDPROC
2076: 
2077: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpdmp7BO.prg):
*==============================================================================
* sigpdmp7BO.prg - Business Object para Movimentacao por Funcionario
* Tabela principal: SigCdNec | PK: cidchaves
* Chave de negocio: empdnps (emps + dopps + str(numps,10))
*==============================================================================

DEFINE CLASS sigpdmp7BO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdNec)
    *-- Identificacao / chaves
    this_cCidchaves  = ""   && cidchaves CHAR(20)   - PK do sistema
    this_cEmpdnps    = ""   && empdnps   CHAR(33)   - Chave de negocio (emps+dopps+numps)
    this_cEmps       = ""   && emps      CHAR(3)    - Empresa
    this_cEmpds      = ""   && empds     CHAR(3)    - Empresa destino
    this_cDopps      = ""   && dopps     CHAR(20)   - Operacao
    this_nNumps      = 0    && numps     NUMERIC(10)- Numero do processo

    *-- Datas
    this_dDatas      = {}   && datas     DATETIME   - Data da movimentacao
    this_dDatars     = {}   && datars    DATETIME   - Data de registro
    this_dDatatrans  = {}   && datatrans DATETIME   - Data da transacao

    *-- Totais e pesos
    this_nTotpesos   = 0    && totpesos  NUMERIC(11,3) - Total de pesos
    this_nPesolancs  = 0    && pesolancs NUMERIC(11,3) - Peso lancado

    *-- Grupos e contas - Origem
    this_cGrupoos    = ""   && grupoos   CHAR(10)   - Grupo de Origem
    this_cContaos    = ""   && contaos   CHAR(10)   - Conta de Origem

    *-- Grupos e contas - Destino
    this_cGrupods    = ""   && grupods   CHAR(10)   - Grupo de Destino
    this_cContads    = ""   && contads   CHAR(10)   - Conta de Destino

    *-- Responsavel/Vendedor
    this_cGrvends    = ""   && grvends   CHAR(10)   - Grupo do responsavel
    this_cVends      = ""   && vends     CHAR(10)   - Vendedor/Responsavel

    *-- Observacao
    this_cObss       = ""   && obss      TEXT       - Observacao

    *-- Usuario
    this_cUsuars     = ""   && usuars    CHAR(10)   - Usuario lancamento
    this_cUsulibs    = ""   && usulibs   CHAR(10)   - Usuario liberacao
    this_cUsuconfs   = ""   && usuconfs  CHAR(10)   - Usuario confirmacao

    *-- Documentos e localidade
    this_cDocus      = ""   && docus     CHAR(10)   - Documento
    this_cLocals     = ""   && locals    CHAR(10)   - Local
    this_cJobs       = ""   && jobs      CHAR(10)   - Job
    this_cCodnconfs  = ""   && codnconfs CHAR(10)   - Codigo nao conformidade
    this_cLibprods   = ""   && libprods  CHAR(10)   - Liberacao producao

    *-- Contadores numericos
    this_nNtrans     = 0    && ntrans    NUMERIC(6) - Numero transacao
    this_nNops       = 0    && nops      NUMERIC(10)- Numero de operacoes
    this_nNaceites   = 0    && naceites  NUMERIC(10)- Numero de aceites
    this_nNumbalds   = 0    && numbalds  NUMERIC(6) - Numero balancete dest
    this_nNumbals    = 0    && numbals   NUMERIC(6) - Numero balancete orig
    this_nCodobs     = 0    && codobs    NUMERIC(3) - Codigo observacao
    this_nNlotes     = 0    && nlotes    NUMERIC(10)- Numero do lote
    this_nChkbaixa   = 0    && chkbaixa  NUMERIC(1) - Check baixa

    *-- Flags logicos (bit)
    this_lChksubn    = .F.  && chksubn   BIT        - Check sub-numero
    this_lImprs      = .F.  && imprs     BIT        - Impresso
    this_lLccs       = .F.  && lccs      BIT        - LCC
    this_lProcbals   = .F.  && procbals  BIT        - Processado balanco orig
    this_lProcdbal   = .F.  && procdbal  BIT        - Processado balanco dest
    this_lRetrabs    = .F.  && retrabs   BIT        - Retrabalho
    this_lAutos      = .F.  && autos     BIT        - Automatico
    this_lNconforms  = .F.  && nconforms BIT        - Nao conformidade

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro("Erro ao inicializar sigpdmp7BO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveComposta - Calcula empdnps a partir dos componentes
    *--------------------------------------------------------------------------
    FUNCTION MontarChaveComposta()
        LOCAL loc_cChave
        loc_cChave = PADR(ALLTRIM(THIS.this_cEmps),  3) + ;
                     PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                     STR(THIS.this_nNumps, 10)
        THIS.this_cEmpdnps = loc_cChave
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir do cursor informado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            *-- Chave primaria e chave composta
            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "")
            THIS.this_cEmpdnps    = TratarNulo(empdnps,    "")
            THIS.this_cEmps       = TratarNulo(emps,       "")
            THIS.this_cEmpds      = TratarNulo(empds,      "")
            THIS.this_cDopps      = TratarNulo(dopps,      "")
            THIS.this_nNumps      = TratarNulo(numps,       0)

            *-- Datas (SQLEXEC retorna DateTime)
            THIS.this_dDatas     = IIF(VARTYPE(datas)     = "T", TTOD(datas),     TratarNulo(datas,     {}))
            THIS.this_dDatars    = IIF(VARTYPE(datars)    = "T", TTOD(datars),    TratarNulo(datars,    {}))
            THIS.this_dDatatrans = IIF(VARTYPE(datatrans) = "T", TTOD(datatrans), TratarNulo(datatrans, {}))

            *-- Totais
            THIS.this_nTotpesos   = TratarNulo(totpesos,   0)
            THIS.this_nPesolancs  = TratarNulo(pesolancs,  0)

            *-- Origem
            THIS.this_cGrupoos    = TratarNulo(grupoos,    "")
            THIS.this_cContaos    = TratarNulo(contaos,    "")

            *-- Destino
            THIS.this_cGrupods    = TratarNulo(grupods,    "")
            THIS.this_cContads    = TratarNulo(contads,    "")

            *-- Responsavel
            THIS.this_cGrvends    = TratarNulo(grvends,    "")
            THIS.this_cVends      = TratarNulo(vends,      "")

            *-- Observacao (campo text/memo)
            THIS.this_cObss       = TratarNulo(obss,       "")

            *-- Usuarios
            THIS.this_cUsuars     = TratarNulo(usuars,     "")
            THIS.this_cUsulibs    = TratarNulo(usulibs,    "")
            THIS.this_cUsuconfs   = TratarNulo(usuconfs,   "")

            *-- Documentos e localidade
            THIS.this_cDocus      = TratarNulo(docus,      "")
            THIS.this_cLocals     = TratarNulo(locals,     "")
            THIS.this_cJobs       = TratarNulo(jobs,       "")
            THIS.this_cCodnconfs  = TratarNulo(codnconfs,  "")
            THIS.this_cLibprods   = TratarNulo(libprods,   "")

            *-- Contadores numericos
            THIS.this_nNtrans     = TratarNulo(ntrans,      0)
            THIS.this_nNops       = TratarNulo(nops,        0)
            THIS.this_nNaceites   = TratarNulo(naceites,    0)
            THIS.this_nNumbalds   = TratarNulo(numbalds,    0)
            THIS.this_nNumbals    = TratarNulo(numbals,     0)
            THIS.this_nCodobs     = TratarNulo(codobs,      0)
            THIS.this_nNlotes     = TratarNulo(nlotes,      0)
            THIS.this_nChkbaixa   = TratarNulo(chkbaixa,   0)

            *-- Flags logicos (BIT -> LOGICAL)
            THIS.this_lChksubn    = (TratarNulo(chksubn,   0) = 1)
            THIS.this_lImprs      = (TratarNulo(imprs,     0) = 1)
            THIS.this_lLccs       = (TratarNulo(lccs,      0) = 1)
            THIS.this_lProcbals   = (TratarNulo(procbals,  0) = 1)
            THIS.this_lProcdbal   = (TratarNulo(procdbal,  0) = 1)
            THIS.this_lRetrabs    = (TratarNulo(retrabs,   0) = 1)
            THIS.this_lAutos      = (TratarNulo(autos,     0) = 1)
            THIS.this_lNconforms  = (TratarNulo(nconforms, 0) = 1)

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria cidchaves
    * par_cChave : valor de cidchaves (C20)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, empdnps, emps, empds, dopps, numps," + ;
                       " datas, datars, datatrans," + ;
                       " totpesos, pesolancs," + ;
                       " grupoos, contaos, grupods, contads," + ;
                       " grvends, vends, obss," + ;
                       " usuars, usulibs, usuconfs," + ;
                       " docus, locals, jobs, codnconfs, libprods," + ;
                       " ntrans, nops, naceites, numbalds, numbals," + ;
                       " codobs, nlotes, chkbaixa," + ;
                       " chksubn, imprs, lccs, procbals, procdbal," + ;
                       " retrabs, autos, nconforms" + ;
                       " FROM SigCdNec" + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cChave))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentacoes para cursor_4c_Dados
    * par_cFiltro : filtro livre (emps ou dopps - pode ser vazio)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE 1=1"

            loc_cSQL = "SELECT cidchaves, empdnps, emps, dopps, numps," + ;
                       " datas, totpesos, usuars," + ;
                       " grupoos, contaos, grupods, contads" + ;
                       " FROM SigCdNec" + ;
                       loc_cWhere + ;
                       " ORDER BY datas DESC, numps DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar movimenta" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCdNec
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves unico se nao informado
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF

            *-- Montar chave composta
            THIS.MontarChaveComposta()

            *-- Usuario logado
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNec (" + ;
                       "cidchaves, empdnps, emps, empds, dopps, numps," + ;
                       " datas, datars, datatrans," + ;
                       " totpesos, pesolancs," + ;
                       " grupoos, contaos, grupods, contads," + ;
                       " grvends, vends, obss," + ;
                       " usuars, usulibs, usuconfs," + ;
                       " docus, locals, jobs, codnconfs, libprods," + ;
                       " ntrans, nops, naceites, numbalds, numbals," + ;
                       " codobs, nlotes, chkbaixa," + ;
                       " chksubn, imprs, lccs, procbals, procdbal," + ;
                       " retrabs, autos, nconforms)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpdnps) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpds) + ", " + ;
                       EscaparSQL(THIS.this_cDopps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatars) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotpesos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesolancs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoos) + ", " + ;
                       EscaparSQL(THIS.this_cContaos) + ", " + ;
                       EscaparSQL(THIS.this_cGrupods) + ", " + ;
                       EscaparSQL(THIS.this_cContads) + ", " + ;
                       EscaparSQL(THIS.this_cGrvends) + ", " + ;
                       EscaparSQL(THIS.this_cVends) + ", " + ;
                       EscaparSQL(THIS.this_cObss) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       EscaparSQL(THIS.this_cUsulibs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuconfs) + ", " + ;
                       EscaparSQL(THIS.this_cDocus) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cJobs) + ", " + ;
                       EscaparSQL(THIS.this_cCodnconfs) + ", " + ;
                       EscaparSQL(THIS.this_cLibprods) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNaceites) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumbalds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumbals) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodobs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNlotes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkbaixa) + ", " + ;
                       IIF(THIS.this_lChksubn,  "1", "0") + ", " + ;
                       IIF(THIS.this_lImprs,    "1", "0") + ", " + ;
                       IIF(THIS.this_lLccs,     "1", "0") + ", " + ;
                       IIF(THIS.this_lProcbals, "1", "0") + ", " + ;
                       IIF(THIS.this_lProcdbal, "1", "0") + ", " + ;
                       IIF(THIS.this_lRetrabs,  "1", "0") + ", " + ;
                       IIF(THIS.this_lAutos,    "1", "0") + ", " + ;
                       IIF(THIS.this_lNconforms,"1", "0") + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir movimenta" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigCdNec
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MostrarErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ELSE
                *-- Remontar chave composta
                THIS.MontarChaveComposta()

                loc_cSQL = "UPDATE SigCdNec SET " + ;
                           "empdnps    = " + EscaparSQL(THIS.this_cEmpdnps) + ", " + ;
                           "emps       = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                           "empds      = " + EscaparSQL(THIS.this_cEmpds) + ", " + ;
                           "dopps      = " + EscaparSQL(THIS.this_cDopps) + ", " + ;
                           "numps      = " + FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                           "datas      = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "datars     = " + FormatarDataSQL(THIS.this_dDatars) + ", " + ;
                           "datatrans  = " + FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                           "totpesos   = " + FormatarNumeroSQL(THIS.this_nTotpesos) + ", " + ;
                           "pesolancs  = " + FormatarNumeroSQL(THIS.this_nPesolancs) + ", " + ;
                           "grupoos    = " + EscaparSQL(THIS.this_cGrupoos) + ", " + ;
                           "contaos    = " + EscaparSQL(THIS.this_cContaos) + ", " + ;
                           "grupods    = " + EscaparSQL(THIS.this_cGrupods) + ", " + ;
                           "contads    = " + EscaparSQL(THIS.this_cContads) + ", " + ;
                           "grvends    = " + EscaparSQL(THIS.this_cGrvends) + ", " + ;
                           "vends      = " + EscaparSQL(THIS.this_cVends) + ", " + ;
                           "obss       = " + EscaparSQL(THIS.this_cObss) + ", " + ;
                           "usuars     = " + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                           "usulibs    = " + EscaparSQL(THIS.this_cUsulibs) + ", " + ;
                           "usuconfs   = " + EscaparSQL(THIS.this_cUsuconfs) + ", " + ;
                           "docus      = " + EscaparSQL(THIS.this_cDocus) + ", " + ;
                           "locals     = " + EscaparSQL(THIS.this_cLocals) + ", " + ;
                           "jobs       = " + EscaparSQL(THIS.this_cJobs) + ", " + ;
                           "codnconfs  = " + EscaparSQL(THIS.this_cCodnconfs) + ", " + ;
                           "libprods   = " + EscaparSQL(THIS.this_cLibprods) + ", " + ;
                           "ntrans     = " + FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                           "nops       = " + FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                           "naceites   = " + FormatarNumeroSQL(THIS.this_nNaceites) + ", " + ;
                           "numbalds   = " + FormatarNumeroSQL(THIS.this_nNumbalds) + ", " + ;
                           "numbals    = " + FormatarNumeroSQL(THIS.this_nNumbals) + ", " + ;
                           "codobs     = " + FormatarNumeroSQL(THIS.this_nCodobs) + ", " + ;
                           "nlotes     = " + FormatarNumeroSQL(THIS.this_nNlotes) + ", " + ;
                           "chkbaixa   = " + FormatarNumeroSQL(THIS.this_nChkbaixa) + ", " + ;
                           "chksubn    = " + IIF(THIS.this_lChksubn,  "1", "0") + ", " + ;
                           "imprs      = " + IIF(THIS.this_lImprs,    "1", "0") + ", " + ;
                           "lccs       = " + IIF(THIS.this_lLccs,     "1", "0") + ", " + ;
                           "procbals   = " + IIF(THIS.this_lProcbals, "1", "0") + ", " + ;
                           "procdbal   = " + IIF(THIS.this_lProcdbal, "1", "0") + ", " + ;
                           "retrabs    = " + IIF(THIS.this_lRetrabs,  "1", "0") + ", " + ;
                           "autos      = " + IIF(THIS.this_lAutos,    "1", "0") + ", " + ;
                           "nconforms  = " + IIF(THIS.this_lNconforms,"1", "0") + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao atualizar movimenta" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigCdNec pela PK cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MostrarErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + ;
                    "o informada para exclus" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigCdNec" + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir movimenta" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarPeriodoBloqueado - Verifica se a data cai em periodo bloqueado
    * Equivalente ao fVerificaBloqueio + fBloqueioPorPeriodo do Framework legado
    * par_dData: data a verificar
    * Retorno: .T. se bloqueado, .F. se permitido
    *--------------------------------------------------------------------------
    PROCEDURE VerificarPeriodoBloqueado(par_dData)
        LOCAL loc_lBloqueado, loc_nResultado, loc_cSQL
        loc_lBloqueado = .F.

        TRY
            IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
                loc_lBloqueado = .F.
            ELSE
                *-- Tenta usar funcoes do Framework legado se disponiveis no ambiente
                TRY
                    IF PEMSTATUS(_VFP, "fVerificaBloqueio", 5) OR ;
                       TYPE("fVerificaBloqueio") = "FP"
                        IF fVerificaBloqueio(par_dData, gnConnHandle) <> 0
                            loc_lBloqueado = .T.
                        ENDIF
                    ENDIF
                CATCH
                    *-- Framework nao disponivel, nao bloquear
                    loc_lBloqueado = .F.
                ENDTRY

                IF !loc_lBloqueado
                    TRY
                        IF PEMSTATUS(_VFP, "fBloqueioPorPeriodo", 5) OR ;
                           TYPE("fBloqueioPorPeriodo") = "FP"
                            IF fBloqueioPorPeriodo(par_dData, gnConnHandle) <> 0
                                loc_lBloqueado = .T.
                            ENDIF
                        ENDIF
                    CATCH
                        *-- Framework nao disponivel, nao bloquear
                        loc_lBloqueado = .F.
                    ENDTRY
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar per" + CHR(237) + "odo:" + ;
                CHR(13) + loException.Message, "Erro")
            loc_lBloqueado = .F.
        ENDTRY

        RETURN loc_lBloqueado
    ENDPROC

ENDDEFINE

