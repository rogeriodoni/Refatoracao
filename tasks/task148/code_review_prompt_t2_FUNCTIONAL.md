# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (20)
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
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Peso' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr.Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct.Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr.Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct.Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Dados' (parent: SIGPDMP7.Pagina.Dados): Top original=4 vs migrado 'grd_4c_Dados' Top=146 (diff=142px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp7.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2086 linhas total):

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
81:                         empdnps C(33), emps C(3),;
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

*-- Linhas 1113 a 1136:
1113:         *----------------------------------------------------------------------
1114:         *-- Grid GradeOperacao (Top=117+29=146, Left=592, Width=171, Height=218)
1115:         *-- Legado: RecordSource=TmpOperacao; Column1 oculto; grid inicia Visible=.F.
1116:         *-- Preenchido pelos sub-formularios de operacao via cursor TmpOperacao
1117:         *----------------------------------------------------------------------
1118:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
1119:         loc_oPagina.grd_4c_Dados.ColumnCount = 1
1120: 
1121:         WITH loc_oPagina.grd_4c_Dados
1122:             .Top                = 146
1123:             .Left               = 592
1124:             .Width              = 171
1125:             .Height             = 218
1126:             .FontName           = "Tahoma"
1127:             .FontSize           = 8
1128:             .ForeColor          = RGB(90, 90, 90)
1129:             .BackColor          = RGB(255, 255, 255)
1130:             .GridLineColor      = RGB(238, 238, 238)
1131:             .HighlightBackColor = RGB(255, 255, 255)
1132:             .HighlightForeColor = RGB(15, 41, 104)
1133:             .HighlightStyle     = 2
1134:             .DeleteMark         = .F.
1135:             .RecordMark         = .F.
1136:             .ReadOnly           = .T.

*-- Linhas 1152 a 1226:
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
1211:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1212:                         loc_oGrid.Column2.Header1.Caption = "Data"
1213:                         loc_oGrid.Column3.Header1.Caption = "Peso"
1214:                         loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1215:                         loc_oGrid.Column5.Header1.Caption = "Usu" + CHR(225) + "rio"
1216:                         loc_oGrid.Column6.Header1.Caption = "Gr.Origem"
1217:                         loc_oGrid.Column7.Header1.Caption = "Ct.Origem"
1218:                         loc_oGrid.Column8.Header1.Caption = "Gr.Destino"
1219:                         loc_oGrid.Column9.Header1.Caption = "Ct.Destino"
1220:                         THIS.FormatarGridLista(loc_oGrid)
1221:                     ENDIF
1222:                     loc_lResultado = .T.
1223:                 ENDIF
1224:             ENDIF
1225:         CATCH TO loException
1226:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 1233 a 1502:
1233:     *--------------------------------------------------------------------------
1234:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1235:     *--------------------------------------------------------------------------
1236:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1237:         LOCAL loc_lResultado
1238:         loc_lResultado = .F.
1239: 
1240:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1241:             loc_lResultado = .F.
1242:         ELSE
1243:             TRY
1244:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1245:                 IF par_nPagina = 1
1246:                     THIS.CarregarLista()
1247:                 ENDIF
1248:                 loc_lResultado = .T.
1249:             CATCH TO loException
1250:                 MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
1251:             ENDTRY
1252:         ENDIF
1253: 
1254:         RETURN loc_lResultado
1255:     ENDPROC
1256: 
1257:     *--------------------------------------------------------------------------
1258:     * FormatarGridLista - Aplica formatacao visual padrao ao grid de lista
1259:     *--------------------------------------------------------------------------
1260:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1261:         WITH par_oGrid
1262:             .FontName = "Tahoma"
1263:             .FontSize = 8
1264:         ENDWITH
1265:     ENDPROC
1266: 
1267:     *--------------------------------------------------------------------------
1268:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1269:     * Itera Pages de PageFrames e Controls de Containers
1270:     *--------------------------------------------------------------------------
1271:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1272:         LOCAL loc_nI, loc_oObjeto, loc_nP
1273: 
1274:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1275:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1276: 
1277:             IF VARTYPE(loc_oObjeto) = "O"
1278:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
1279:                    !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
1280:                     loc_oObjeto.Visible = .T.
1281:                 ENDIF
1282: 
1283:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1284:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1285:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1286:                     ENDFOR
1287:                 ENDIF
1288: 
1289:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1290:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1291:                 ENDIF
1292:             ENDIF
1293:         ENDFOR
1294:     ENDPROC
1295: 
1296:     *--------------------------------------------------------------------------
1297:     * GridListaAfterRowColChange - Atualiza this_cDopp ao mover linha no grid
1298:     *--------------------------------------------------------------------------
1299:     PROCEDURE GridListaAfterRowColChange(par_nColIndex)
1300:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1301:             SELECT cursor_4c_Dados
1302:             THIS.this_cDopp = ALLTRIM(cursor_4c_Dados.dopps)
1303:         ENDIF
1304:     ENDPROC
1305: 
1306:     *--------------------------------------------------------------------------
1307:     * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
1308:     *--------------------------------------------------------------------------
1309:     PROCEDURE BtnIncluirClick()
1310:         THIS.this_oBusinessObject.NovoRegistro()
1311:         THIS.LimparCampos()
1312:         THIS.this_cPcEscolha  = "INSERIR"
1313:         THIS.this_cModoAtual  = "INCLUIR"
1314:         THIS.HabilitarCampos(.T.)
1315:         THIS.AjustarBotoesPorModo()
1316:         THIS.AlternarPagina(2)
1317:     ENDPROC
1318: 
1319:     *--------------------------------------------------------------------------
1320:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
1321:     *--------------------------------------------------------------------------
1322:     PROCEDURE BtnVisualizarClick()
1323:         LOCAL loc_cCodigo
1324:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1325:             MsgAviso("Selecione um registro para visualizar.", "")
1326:             RETURN
1327:         ENDIF
1328:         SELECT cursor_4c_Dados
1329:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.empdnps)
1330:         IF EMPTY(loc_cCodigo)
1331:             MsgAviso("Selecione um registro para visualizar.", "")
1332:             RETURN
1333:         ENDIF
1334:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1335:             THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
1336:             THIS.this_cPcEscolha = "CONSULTAR"
1337:             THIS.this_cModoAtual = "VISUALIZAR"
1338:             THIS.BOParaForm()
1339:             THIS.HabilitarCampos(.F.)
1340:             THIS.AjustarBotoesPorModo()
1341:             THIS.AlternarPagina(2)
1342:         ELSE
1343:             MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
1344:         ENDIF
1345:     ENDPROC
1346: 
1347:     *--------------------------------------------------------------------------
1348:     * BtnAlterarClick - Carrega registro selecionado para edicao
1349:     *--------------------------------------------------------------------------
1350:     PROCEDURE BtnAlterarClick()
1351:         LOCAL loc_cCodigo
1352:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1353:             MsgAviso("Selecione um registro para alterar.", "")
1354:             RETURN
1355:         ENDIF
1356:         SELECT cursor_4c_Dados
1357:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.empdnps)
1358:         IF EMPTY(loc_cCodigo)
1359:             MsgAviso("Selecione um registro para alterar.", "")
1360:             RETURN
1361:         ENDIF
1362:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1363:             THIS.this_oBusinessObject.EditarRegistro()
1364:             THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
1365:             THIS.this_cPcEscolha = "ALTERAR"
1366:             THIS.this_cModoAtual = "ALTERAR"
1367:             THIS.BOParaForm()
1368:             THIS.HabilitarCampos(.T.)
1369:             THIS.AjustarBotoesPorModo()
1370:             THIS.AlternarPagina(2)
1371:         ELSE
1372:             MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
1373:         ENDIF
1374:     ENDPROC
1375: 
1376:     *--------------------------------------------------------------------------
1377:     * BtnExcluirClick - Confirma e exclui registro selecionado
1378:     *--------------------------------------------------------------------------
1379:     PROCEDURE BtnExcluirClick()
1380:         LOCAL loc_cCodigo
1381:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1382:             MsgAviso("Selecione um registro para excluir.", "")
1383:             RETURN
1384:         ENDIF
1385:         SELECT cursor_4c_Dados
1386:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.empdnps)
1387:         IF EMPTY(loc_cCodigo)
1388:             MsgAviso("Selecione um registro para excluir.", "")
1389:             RETURN
1390:         ENDIF
1391:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirmar Exclus" + CHR(227) + "o")
1392:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1393:                 IF THIS.this_oBusinessObject.Excluir()
1394:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1395:                     THIS.CarregarLista()
1396:                 ELSE
1397:                     MsgErro("Erro ao excluir o registro.", "Erro")
1398:                 ENDIF
1399:             ELSE
1400:                 MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Erro")
1401:             ENDIF
1402:         ENDIF
1403:     ENDPROC
1404: 
1405:     *--------------------------------------------------------------------------
1406:     * BtnBuscarClick - Filtra lista por codigo, operacao ou usuario
1407:     *--------------------------------------------------------------------------
1408:     PROCEDURE BtnBuscarClick()
1409:         LOCAL loc_cFiltro
1410:         loc_cFiltro = INPUTBOX("Informe o c" + CHR(243) + "digo, opera" + CHR(231) + ;
1411:             CHR(227) + "o ou usu" + CHR(225) + "rio:", "Buscar")
1412:         IF VARTYPE(loc_cFiltro) = "C"
1413:             THIS.this_cPQuery = ALLTRIM(loc_cFiltro)
1414:             THIS.CarregarLista()
1415:         ENDIF
1416:     ENDPROC
1417: 
1418:     *--------------------------------------------------------------------------
1419:     * BtnEncerrarClick - Fecha o formulario
1420:     *--------------------------------------------------------------------------
1421:     PROCEDURE BtnEncerrarClick()
1422:         THIS.Release()
1423:     ENDPROC
1424: 
1425:     *--------------------------------------------------------------------------
1426:     * BtnSalvarClick - Transfere Form->BO e chama Salvar(); volta para lista
1427:     *--------------------------------------------------------------------------
1428:     PROCEDURE BtnSalvarClick()
1429:         LOCAL loc_lSucesso
1430:         loc_lSucesso = .F.
1431: 
1432:         TRY
1433:             THIS.FormParaBO()
1434:             IF THIS.this_oBusinessObject.Salvar()
1435:                 MsgInfo("Registro salvo com sucesso!", "")
1436:                 THIS.this_cModoAtual = "LISTA"
1437:                 THIS.AlternarPagina(1)
1438:                 loc_lSucesso = .T.
1439:             ELSE
1440:                 MsgErro("Erro ao salvar o registro.", "Erro")
1441:             ENDIF
1442:         CATCH TO loException
1443:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
1444:         ENDTRY
1445: 
1446:         RETURN loc_lSucesso
1447:     ENDPROC
1448: 
1449:     *--------------------------------------------------------------------------
1450:     * BtnCancelarClick - Cancela edicao e retorna para lista recarregada
1451:     *--------------------------------------------------------------------------
1452:     PROCEDURE BtnCancelarClick()
1453:         THIS.this_cModoAtual = "LISTA"
1454:         THIS.AlternarPagina(1)
1455:         THIS.CarregarLista()
1456:     ENDPROC
1457: 
1458:     *--------------------------------------------------------------------------
1459:     * FormParaBO - Transfere valores do formulario para o Business Object
1460:     * Usa PEMSTATUS para acessar controles da Page2 com seguranca
1461:     *--------------------------------------------------------------------------
1462:     PROTECTED PROCEDURE FormParaBO()
1463:         LOCAL loc_oPg2, loc_oBO
1464:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1465:         loc_oBO  = THIS.this_oBusinessObject
1466: 
1467:         *-- Empresa e operacao
1468:         loc_oBO.this_cEmps  = THIS.this_cPEmps
1469:         loc_oBO.this_cDopps = THIS.this_cDopp
1470: 
1471:         *-- Container central de dados (cntDados)
1472:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1473:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1474:                 loc_oBO.this_cCidchaves = ALLTRIM(loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value)
1475:             ENDIF
1476:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1477:                 loc_oBO.this_dDatas = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
1478:             ENDIF
1479:         ENDIF
1480: 
1481:         *-- Origem
1482:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1483:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1484:                 loc_oBO.this_cGrupoos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value)
1485:             ENDIF
1486:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1487:                 loc_oBO.this_cContaos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value)
1488:             ENDIF
1489:         ENDIF
1490: 
1491:         *-- Destino
1492:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1493:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1494:                 loc_oBO.this_cGrupods = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value)
1495:             ENDIF
1496:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1497:                 loc_oBO.this_cContads = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value)
1498:             ENDIF
1499:         ENDIF
1500: 
1501:         *-- Responsavel
1502:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)

*-- Linhas 1518 a 1561:
1518:     * BOParaForm - Transfere valores do Business Object para o formulario
1519:     * Usa PEMSTATUS para acessar controles da Page2 com seguranca
1520:     *--------------------------------------------------------------------------
1521:     PROTECTED PROCEDURE BOParaForm()
1522:         LOCAL loc_oPg2, loc_oBO
1523:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1524:         loc_oBO  = THIS.this_oBusinessObject
1525: 
1526:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1527:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1528:                 loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cCidchaves)
1529:             ENDIF
1530:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1531:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = loc_oBO.this_dDatas
1532:             ENDIF
1533:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
1534:                 loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ALLTRIM(loc_oBO.this_cDopps)
1535:             ENDIF
1536:         ENDIF
1537: 
1538:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1539:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1540:                 loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupoos)
1541:             ENDIF
1542:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1543:                 loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContaos)
1544:             ENDIF
1545:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
1546:                 loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
1547:             ENDIF
1548:         ENDIF
1549: 
1550:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1551:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1552:                 loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupods)
1553:             ENDIF
1554:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1555:                 loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContads)
1556:             ENDIF
1557:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
1558:                 loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
1559:             ENDIF
1560:         ENDIF
1561: 

*-- Linhas 1579 a 1622:
1579:     *--------------------------------------------------------------------------
1580:     * HabilitarCampos - Habilita/desabilita controles editaveis da Page2
1581:     *--------------------------------------------------------------------------
1582:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1583:         LOCAL loc_oPg2
1584:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1585: 
1586:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1587:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1588:                 loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Enabled = ;
1589:                     par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1590:             ENDIF
1591:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1592:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Enabled = par_lHabilitar
1593:             ENDIF
1594:         ENDIF
1595: 
1596:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1597:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1598:                 loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.ReadOnly = !par_lHabilitar
1599:             ENDIF
1600:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1601:                 loc_oPg2.cnt_4c_Origem.txt_4c_Conta.ReadOnly = !par_lHabilitar
1602:             ENDIF
1603:         ENDIF
1604: 
1605:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1606:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1607:                 loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.ReadOnly = !par_lHabilitar
1608:             ENDIF
1609:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1610:                 loc_oPg2.cnt_4c_Destino.txt_4c_Conta.ReadOnly = !par_lHabilitar
1611:             ENDIF
1612:         ENDIF
1613: 
1614:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
1615:             IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
1616:                 loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.ReadOnly = !par_lHabilitar
1617:             ENDIF
1618:             IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
1619:                 loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.ReadOnly = !par_lHabilitar
1620:             ENDIF
1621:         ENDIF
1622: 

*-- Linhas 1634 a 1677:
1634:     *--------------------------------------------------------------------------
1635:     * LimparCampos - Limpa valores dos controles da Page2
1636:     *--------------------------------------------------------------------------
1637:     PROTECTED PROCEDURE LimparCampos()
1638:         LOCAL loc_oPg2
1639:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1640: 
1641:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1642:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1643:                 loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ""
1644:             ENDIF
1645:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1646:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
1647:             ENDIF
1648:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
1649:                 loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ""
1650:             ENDIF
1651:         ENDIF
1652: 
1653:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1654:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1655:                 loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ""
1656:             ENDIF
1657:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1658:                 loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ""
1659:             ENDIF
1660:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
1661:                 loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
1662:             ENDIF
1663:         ENDIF
1664: 
1665:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1666:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1667:                 loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ""
1668:             ENDIF
1669:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1670:                 loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ""
1671:             ENDIF
1672:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
1673:                 loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
1674:             ENDIF
1675:         ENDIF
1676: 
1677:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)

*-- Linhas 1694 a 2086:
1694:     *--------------------------------------------------------------------------
1695:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
1696:     *--------------------------------------------------------------------------
1697:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1698:         LOCAL loc_oPg1, loc_oPg2, loc_lLista, loc_lEditar
1699:         loc_oPg1   = THIS.pgf_4c_Paginas.Page1
1700:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1701:         loc_lLista  = (THIS.this_cModoAtual = "LISTA")
1702:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1703: 
1704:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1705:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1706:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
1707:             ENDIF
1708:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1709:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
1710:             ENDIF
1711:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1712:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
1713:             ENDIF
1714:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1715:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
1716:             ENDIF
1717:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1718:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
1719:             ENDIF
1720:         ENDIF
1721: 
1722:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1723:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1724:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1725:             ENDIF
1726:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1727:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1728:             ENDIF
1729:         ENDIF
1730:     ENDPROC
1731: 
1732:     *--------------------------------------------------------------------------
1733:     * ValidarDataMov - Valida data da movimentacao ao sair do campo
1734:     * Legado: Dt_data.Valid - verifica fVerificaBloqueio e fBloqueioPorPeriodo
1735:     * No novo sistema: verifica se a data esta dentro do periodo permitido pelo BO
1736:     * Tambem bloqueia alteracao de data quando ja existem envelopes (TmpOperacao)
1737:     *--------------------------------------------------------------------------
1738:     PROCEDURE ValidarDataMov()
1739:         LOCAL loc_oPg2, loc_dData, loc_lBloqueado, loc_nContEnv
1740:         loc_lBloqueado = .F.
1741: 
1742:         TRY
1743:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1744: 
1745:             IF !PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1746:                 RETURN
1747:             ENDIF
1748:             IF !PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1749:                 RETURN
1750:             ENDIF
1751: 
1752:             loc_dData = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
1753: 
1754:             IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1755:                 RETURN
1756:             ENDIF
1757: 
1758:             IF EMPTY(loc_dData)
1759:                 MsgAviso("Informe uma data v" + CHR(225) + "lida.", "")
1760:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
1761:                 RETURN
1762:             ENDIF
1763: 
1764:             *-- Verifica se ja existem envelopes/ops lancados (TmpOperacao)
1765:             *-- Legado: Count to _LnCont For Codigos > 0
1766:             IF USED("TmpOperacao")
1767:                 SELECT TmpOperacao
1768:                 COUNT TO loc_nContEnv FOR Codigos > 0
1769:                 IF loc_nContEnv > 0
1770:                     MsgAviso("A Data s" + CHR(243) + "mente pode ser alterada antes de Informar Envelopes/Ops", "")
1771:                     loc_lBloqueado = .T.
1772:                 ENDIF
1773:             ENDIF
1774: 
1775:             *-- Verifica bloqueio de periodo no BO
1776:             IF !loc_lBloqueado
1777:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1778:                     IF THIS.this_oBusinessObject.VerificarPeriodoBloqueado(loc_dData)
1779:                         MsgAviso("Per" + CHR(237) + "odo Bloqueado!!!", "")
1780:                         loc_lBloqueado = .T.
1781:                     ENDIF
1782:                 ENDIF
1783:             ENDIF
1784: 
1785:             IF loc_lBloqueado
1786:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
1787:             ENDIF
1788: 
1789:         CATCH TO loException
1790:             MostrarErro("Erro ao validar data:" + CHR(13) + loException.Message, "Erro")
1791:         ENDTRY
1792:     ENDPROC
1793: 
1794:     *--------------------------------------------------------------------------
1795:     * BtnOperacaoClick - Abre sub-formulario de operacoes (legado: SigPdMp5)
1796:     * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xMfas -> Do Form SigPdMp5
1797:     *--------------------------------------------------------------------------
1798:     PROCEDURE BtnOperacaoClick()
1799:         LOCAL loc_cFormPath
1800:         IF THIS.this_cPcEscolha = "PROCURAR"
1801:             RETURN
1802:         ENDIF
1803:         TRY
1804:             THIS.Enabled = .F.
1805:             IF USED("xMfas")
1806:                 SELECT xMfas
1807:                 SET ORDER TO
1808:             ENDIF
1809:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp5.scx"
1810:             IF FILE(loc_cFormPath)
1811:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1812:             ELSE
1813:                 MsgAviso("Subformul" + CHR(225) + "rio de Opera" + CHR(231) + CHR(245) + "es (SigPdMp5) n" + ;
1814:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1815:             ENDIF
1816:             THIS.Enabled = .T.
1817:         CATCH TO loException
1818:             THIS.Enabled = .T.
1819:             MostrarErro("Erro ao abrir Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
1820:         ENDTRY
1821:     ENDPROC
1822: 
1823:     *--------------------------------------------------------------------------
1824:     * BtnComponentesClick - Abre sub-formulario de componentes (legado: SigPdMp2)
1825:     * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xNensi -> Do Form SigPdMp2
1826:     *--------------------------------------------------------------------------
1827:     PROCEDURE BtnComponentesClick()
1828:         LOCAL loc_cFormPath
1829:         IF THIS.this_cPcEscolha = "PROCURAR"
1830:             RETURN
1831:         ENDIF
1832:         TRY
1833:             THIS.Enabled = .F.
1834:             IF USED("xNensi")
1835:                 SELECT xNensi
1836:                 SET ORDER TO
1837:             ENDIF
1838:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp2.scx"
1839:             IF FILE(loc_cFormPath)
1840:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1841:             ELSE
1842:                 MsgAviso("Subformul" + CHR(225) + "rio de Componentes (SigPdMp2) n" + ;
1843:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1844:             ENDIF
1845:             THIS.Enabled = .T.
1846:         CATCH TO loException
1847:             THIS.Enabled = .T.
1848:             MostrarErro("Erro ao abrir Componentes:" + CHR(13) + loException.Message, "Erro")
1849:         ENDTRY
1850:     ENDPROC
1851: 
1852:     *--------------------------------------------------------------------------
1853:     * BtnEtiquetasClick - Abre sub-formulario de etiquetas/pesagem
1854:     * Legado: If pcEscolha<>'PROCURAR':
1855:     *   If crSigCdPam.AltPesas=1 -> Select xOpi -> Do Form SigPdMp3
1856:     *   Else -> Select xPesa -> Do Form SigPdMp9
1857:     *--------------------------------------------------------------------------
1858:     PROCEDURE BtnEtiquetasClick()
1859:         LOCAL loc_cFormPath, loc_lAltPesas
1860:         IF THIS.this_cPcEscolha = "PROCURAR"
1861:             RETURN
1862:         ENDIF
1863:         TRY
1864:             THIS.Enabled = .F.
1865:             loc_lAltPesas = .F.
1866: 
1867:             *-- Verifica flag AltPesas no cursor de parametros (crSigCdPam)
1868:             IF USED("crSigCdPam") AND PEMSTATUS(crSigCdPam, "AltPesas", 8)
1869:                 loc_lAltPesas = (crSigCdPam.AltPesas = 1)
1870:             ENDIF
1871: 
1872:             IF loc_lAltPesas
1873:                 IF USED("xOpi")
1874:                     SELECT xOpi
1875:                     GO TOP
1876:                 ENDIF
1877:                 loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp3.scx"
1878:                 IF FILE(loc_cFormPath)
1879:                     DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1880:                 ELSE
1881:                     MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp3) n" + ;
1882:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1883:                 ENDIF
1884:             ELSE
1885:                 IF USED("xPesa")
1886:                     SELECT xPesa
1887:                     GO TOP
1888:                 ENDIF
1889:                 loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp9.scx"
1890:                 IF FILE(loc_cFormPath)
1891:                     DO FORM (loc_cFormPath) WITH THIS
1892:                 ELSE
1893:                     MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp9) n" + ;
1894:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1895:                 ENDIF
1896:             ENDIF
1897:             THIS.Enabled = .T.
1898:         CATCH TO loException
1899:             THIS.Enabled = .T.
1900:             MostrarErro("Erro ao abrir Etiquetas:" + CHR(13) + loException.Message, "Erro")
1901:         ENDTRY
1902:     ENDPROC
1903: 
1904:     *--------------------------------------------------------------------------
1905:     * BtnDadosClick - Abre sub-formulario de complemento de dados (legado: SigOpInf)
1906:     * Legado: Do Form SigOpInf With ThisForm, ThisForm.DataSessionId
1907:     *--------------------------------------------------------------------------
1908:     PROCEDURE BtnDadosClick()
1909:         LOCAL loc_cFormPath
1910:         TRY
1911:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpInf.scx"
1912:             IF FILE(loc_cFormPath)
1913:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1914:             ELSE
1915:                 MsgAviso("Subformul" + CHR(225) + "rio de Complemento (SigOpInf) n" + ;
1916:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1917:             ENDIF
1918:         CATCH TO loException
1919:             MostrarErro("Erro ao abrir Complemento:" + CHR(13) + loException.Message, "Erro")
1920:         ENDTRY
1921:     ENDPROC
1922: 
1923:     *--------------------------------------------------------------------------
1924:     * BtnBoletoClick - Impressao de boleto se operacao permite
1925:     * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Boletos=1 -> ImpBol()
1926:     *--------------------------------------------------------------------------
1927:     PROCEDURE BtnBoletoClick()
1928:         LOCAL loc_lPermite
1929:         loc_lPermite = .F.
1930:         TRY
1931:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
1932:                 SELECT crSigCdOpd
1933:                 SET NEAR ON
1934:                 SEEK THIS.this_cDopp ORDER TAG Dopps
1935:                 SET NEAR OFF
1936:                 IF FOUND() AND !EOF("crSigCdOpd")
1937:                     loc_lPermite = (crSigCdOpd.Boletos = 1)
1938:                 ENDIF
1939:             ENDIF
1940:             IF loc_lPermite
1941:                 THIS.ImpBol()
1942:             ELSE
1943:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
1944:                     "o permite impress" + CHR(227) + "o de boleto.", "")
1945:             ENDIF
1946:         CATCH TO loException
1947:             MostrarErro("Erro ao imprimir boleto:" + CHR(13) + loException.Message, "Erro")
1948:         ENDTRY
1949:     ENDPROC
1950: 
1951:     *--------------------------------------------------------------------------
1952:     * BtnDocumentoClick - Impressao de documento se operacao permite
1953:     * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Docus=1 -> Do SigPrIdc
1954:     *--------------------------------------------------------------------------
1955:     PROCEDURE BtnDocumentoClick()
1956:         LOCAL loc_lPermite, loc_cPrgPath
1957:         loc_lPermite = .F.
1958:         TRY
1959:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
1960:                 SELECT crSigCdOpd
1961:                 SET NEAR ON
1962:                 SEEK THIS.this_cDopp ORDER TAG Dopps
1963:                 SET NEAR OFF
1964:                 IF FOUND() AND !EOF("crSigCdOpd")
1965:                     loc_lPermite = (crSigCdOpd.Docus = 1)
1966:                 ENDIF
1967:             ENDIF
1968:             IF loc_lPermite AND USED("TmpNens") AND !EOF("TmpNens")
1969:                 SELECT TmpNens
1970: 
1971:                 *-- Atualiza cursor crSigCdNec para registro corrente
1972:                 IF USED("crSigCdOpd")
1973:                     SELECT crSigCdOpd
1974:                     SET NEAR ON
1975:                     SEEK ALLTRIM(TmpNens.Dopps) ORDER TAG Dopps
1976:                     SET NEAR OFF
1977:                 ENDIF
1978: 
1979:                 loc_cPrgPath = gc_4c_CaminhoBase + "..\Framework\SigPrIdc.prg"
1980:                 IF FILE(loc_cPrgPath)
1981:                     DO (loc_cPrgPath) WITH ;
1982:                         ALLTRIM(TmpNens.Emps), ALLTRIM(TmpNens.Dopps), TmpNens.Numps, ;
1983:                         0, crSigCdOpd.QtdDocs, .F., .F., .F., .F., .F., .F., THIS
1984:                 ELSE
1985:                     MsgAviso("Rotina de impress" + CHR(227) + "o de documento (SigPrIdc) n" + ;
1986:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1987:                 ENDIF
1988:             ELSE
1989:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
1990:                     "o permite impress" + CHR(227) + "o de documento.", "")
1991:             ENDIF
1992:         CATCH TO loException
1993:             MostrarErro("Erro ao imprimir documento:" + CHR(13) + loException.Message, "Erro")
1994:         ENDTRY
1995:     ENDPROC
1996: 
1997:     *--------------------------------------------------------------------------
1998:     * ImpBol - Impressao de boleto via sub-formulario SigOpIbo
1999:     * Legado: Do Form SigOpIbo With Thisform, 2, This.Titulo
2000:     *--------------------------------------------------------------------------
2001:     PROCEDURE ImpBol()
2002:         LOCAL loc_cFormPath
2003:         TRY
2004:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpIbo.scx"
2005:             IF FILE(loc_cFormPath)
2006:                 DO FORM (loc_cFormPath) WITH THIS, 2, THIS.this_cTitulo
2007:             ELSE
2008:                 MsgAviso("Subformul" + CHR(225) + "rio de boleto (SigOpIbo) n" + ;
2009:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
2010:             ENDIF
2011:         CATCH TO loException
2012:             MostrarErro("Erro ao imprimir boleto (ImpBol):" + CHR(13) + loException.Message, "Erro")
2013:         ENDTRY
2014:     ENDPROC
2015: 
2016:     *--------------------------------------------------------------------------
2017:     * Activate - Gerencia foco automatico ao ativar o formulario
2018:     * Legado: Activate -> Seek(Dopp, crSigCdOpd, Dopps) + SetFocus nos campos
2019:     * this_lAtFoco controla se deve setar foco (evita loop na 1a abertura)
2020:     *--------------------------------------------------------------------------
2021:     PROCEDURE Activate()
2022:         LOCAL loc_oPg2
2023:         TRY
2024:             DODEFAULT()
2025: 
2026:             *-- Posiciona cursor de operacoes no Dopp corrente
2027:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
2028:                 SELECT crSigCdOpd
2029:                 SET NEAR ON
2030:                 SEEK THIS.this_cDopp ORDER TAG Dopps
2031:                 SET NEAR OFF
2032:             ENDIF
2033: 
2034:             *-- Coloca foco no campo adequado conforme modo
2035:             IF THIS.this_lAtFoco
2036:                 THIS.this_lAtFoco = .F.
2037:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2038: 
2039:                 DO CASE
2040:                     CASE THIS.this_cPcEscolha = "PROCURAR"
2041:                         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5) AND ;
2042:                            PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
2043:                             loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.SetFocus
2044:                         ENDIF
2045: 
2046:                     CASE INLIST(THIS.this_cPcEscolha, "CONSULTAR", "EXCLUIR")
2047:                         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5) AND ;
2048:                            PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
2049:                             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
2050:                         ENDIF
2051:                 ENDCASE
2052:             ENDIF
2053: 
2054:             *-- Garantir cursor TmpNens no topo se disponivel
2055:             IF USED("TmpNens")
2056:                 SELECT TmpNens
2057:                 GO TOP
2058:             ENDIF
2059: 
2060:         CATCH TO loException
2061:             *-- Erros de foco nao devem travar a interface
2062:         ENDTRY
2063:     ENDPROC
2064: 
2065:     *--------------------------------------------------------------------------
2066:     * Destroy - Libera recursos ao fechar o formulario
2067:     *--------------------------------------------------------------------------
2068:     PROCEDURE Destroy()
2069:         LOCAL loc_oErro
2070:         TRY
2071:             IF USED("cursor_4c_Dados")
2072:                 USE IN cursor_4c_Dados
2073:             ENDIF
2074:             IF USED("TmpOperacao")
2075:                 USE IN TmpOperacao
2076:             ENDIF
2077:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2078:                 THIS.this_oBusinessObject = .NULL.
2079:             ENDIF
2080:         CATCH TO loc_oErro
2081:             *-- Ignorar erros no Destroy para nao bloquear fechamento
2082:         ENDTRY
2083:         DODEFAULT()
2084:     ENDPROC
2085: 
2086: ENDDEFINE


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
                       " WHERE empdnps = " + EscaparSQL(ALLTRIM(par_cChave))

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

            loc_cSQL = "SELECT empdnps, emps, dopps, numps," + ;
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
                           "WHERE empdnps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpdnps))

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
                           " WHERE empdnps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpdnps))

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

