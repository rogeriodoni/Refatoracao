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
- [GRID-HEADER] Header Caption 'Grupo Orig.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Orig.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo Dest.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Dest.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Peso' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo Orig.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Orig.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo Dest.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Dest.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Industrialização. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp7.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2084 linhas total):

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

*-- Linhas 1151 a 1225:
1151:             .Visible            = .F.  && Inicia oculto (preenchido pelos sub-forms)
1152:         ENDWITH
1153: 
1154:         *-- Vincular RecordSource do grid ao cursor TmpOperacao (criado em InicializarForm)
1155:         IF USED("TmpOperacao")
1156:             loc_oPagina.grd_4c_Dados.RecordSource = "TmpOperacao"
1157:             loc_oPagina.grd_4c_Dados.Column1.ControlSource = "TmpOperacao.Codigos"
1158:         ENDIF
1159: 
1160:         *-- BINDEVENTs para botoes de acao da Page2
1161:         BINDEVENT(loc_oPagina.cmd_4c_Operacao,    "Click", THIS, "BtnOperacaoClick")
1162:         BINDEVENT(loc_oPagina.cmd_4c_Componentes, "Click", THIS, "BtnComponentesClick")
1163:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas,   "Click", THIS, "BtnEtiquetasClick")
1164:         BINDEVENT(loc_oPagina.cmd_4c_Dados,       "Click", THIS, "BtnDadosClick")
1165:         BINDEVENT(loc_oPagina.cmd_4c_Boleto,      "Click", THIS, "BtnBoletoClick")
1166:         BINDEVENT(loc_oPagina.cmd_4c_Documento,   "Click", THIS, "BtnDocumentoClick")
1167: 
1168:         *-- Vincular eventos dos botoes da Page2
1169:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1170:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1171: 
1172:         THIS.TornarControlesVisiveis(loc_oPagina)
1173: 
1174:         *-- Restaurar Visible=.F. do grid apos TornarControlesVisiveis (que seta tudo para .T.)
1175:         IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1176:             loc_oPagina.grd_4c_Dados.Visible = .F.
1177:         ENDIF
1178:     ENDPROC
1179: 
1180:     *--------------------------------------------------------------------------
1181:     * CarregarLista - Executa Buscar() no BO e atualiza o grid de lista
1182:     * O grid (grd_4c_Lista) e adicionado na Fase 4; usa PEMSTATUS para nao
1183:     * crashar quando chamado antes da Fase 4 ser aplicada
1184:     *--------------------------------------------------------------------------
1185:     PROCEDURE CarregarLista()
1186:         LOCAL loc_lResultado, loc_oGrid
1187:         loc_lResultado = .F.
1188: 
1189:         TRY
1190:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1191:                 loc_lResultado = .T.
1192:             ELSE
1193:                 IF !THIS.this_oBusinessObject.Buscar(THIS.this_cPQuery)
1194:                     loc_lResultado = .F.
1195:                 ELSE
1196:                     *-- Configurar grid quando existir (adicionado na Fase 4)
1197:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1198:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1199:                         loc_oGrid.ColumnCount = 9
1200:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1201:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numps"
1202:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
1203:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.totpesos"
1204:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.dopps"
1205:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.usuars"
1206:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupoos"
1207:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contaos"
1208:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.grupods"
1209:                         loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.contads"
1210:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1211:                         loc_oGrid.Column2.Header1.Caption = "Data"
1212:                         loc_oGrid.Column3.Header1.Caption = "Peso"
1213:                         loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1214:                         loc_oGrid.Column5.Header1.Caption = "Usu" + CHR(225) + "rio"
1215:                         loc_oGrid.Column6.Header1.Caption = "Grupo Orig."
1216:                         loc_oGrid.Column7.Header1.Caption = "Conta Orig."
1217:                         loc_oGrid.Column8.Header1.Caption = "Grupo Dest."
1218:                         loc_oGrid.Column9.Header1.Caption = "Conta Dest."
1219:                         THIS.FormatarGridLista(loc_oGrid)
1220:                     ENDIF
1221:                     loc_lResultado = .T.
1222:                 ENDIF
1223:             ENDIF
1224:         CATCH TO loException
1225:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 1232 a 1500:
1232:     *--------------------------------------------------------------------------
1233:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1234:     *--------------------------------------------------------------------------
1235:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1236:         LOCAL loc_lResultado
1237:         loc_lResultado = .F.
1238: 
1239:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1240:             loc_lResultado = .F.
1241:         ELSE
1242:             TRY
1243:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1244:                 IF par_nPagina = 1
1245:                     THIS.CarregarLista()
1246:                 ENDIF
1247:                 loc_lResultado = .T.
1248:             CATCH TO loException
1249:                 MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
1250:             ENDTRY
1251:         ENDIF
1252: 
1253:         RETURN loc_lResultado
1254:     ENDPROC
1255: 
1256:     *--------------------------------------------------------------------------
1257:     * FormatarGridLista - Aplica formatacao visual padrao ao grid de lista
1258:     *--------------------------------------------------------------------------
1259:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1260:         WITH par_oGrid
1261:             .FontName = "Tahoma"
1262:             .FontSize = 8
1263:         ENDWITH
1264:     ENDPROC
1265: 
1266:     *--------------------------------------------------------------------------
1267:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1268:     * Itera Pages de PageFrames e Controls de Containers
1269:     *--------------------------------------------------------------------------
1270:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1271:         LOCAL loc_nI, loc_oObjeto, loc_nP
1272: 
1273:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1274:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1275: 
1276:             IF VARTYPE(loc_oObjeto) = "O"
1277:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1278:                     loc_oObjeto.Visible = .T.
1279:                 ENDIF
1280: 
1281:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1282:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1283:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1284:                     ENDFOR
1285:                 ENDIF
1286: 
1287:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1288:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1289:                 ENDIF
1290:             ENDIF
1291:         ENDFOR
1292:     ENDPROC
1293: 
1294:     *--------------------------------------------------------------------------
1295:     * GridListaAfterRowColChange - Atualiza this_cDopp ao mover linha no grid
1296:     *--------------------------------------------------------------------------
1297:     PROCEDURE GridListaAfterRowColChange(par_nColIndex)
1298:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1299:             SELECT cursor_4c_Dados
1300:             THIS.this_cDopp = ALLTRIM(cursor_4c_Dados.dopps)
1301:         ENDIF
1302:     ENDPROC
1303: 
1304:     *--------------------------------------------------------------------------
1305:     * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
1306:     *--------------------------------------------------------------------------
1307:     PROCEDURE BtnIncluirClick()
1308:         THIS.this_oBusinessObject.NovoRegistro()
1309:         THIS.LimparCampos()
1310:         THIS.this_cPcEscolha  = "INSERIR"
1311:         THIS.this_cModoAtual  = "INCLUIR"
1312:         THIS.HabilitarCampos(.T.)
1313:         THIS.AjustarBotoesPorModo()
1314:         THIS.AlternarPagina(2)
1315:     ENDPROC
1316: 
1317:     *--------------------------------------------------------------------------
1318:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
1319:     *--------------------------------------------------------------------------
1320:     PROCEDURE BtnVisualizarClick()
1321:         LOCAL loc_cCodigo
1322:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1323:             MsgAviso("Selecione um registro para visualizar.", "")
1324:             RETURN
1325:         ENDIF
1326:         SELECT cursor_4c_Dados
1327:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1328:         IF EMPTY(loc_cCodigo)
1329:             MsgAviso("Selecione um registro para visualizar.", "")
1330:             RETURN
1331:         ENDIF
1332:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1333:             THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
1334:             THIS.this_cPcEscolha = "CONSULTAR"
1335:             THIS.this_cModoAtual = "VISUALIZAR"
1336:             THIS.BOParaForm()
1337:             THIS.HabilitarCampos(.F.)
1338:             THIS.AjustarBotoesPorModo()
1339:             THIS.AlternarPagina(2)
1340:         ELSE
1341:             MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
1342:         ENDIF
1343:     ENDPROC
1344: 
1345:     *--------------------------------------------------------------------------
1346:     * BtnAlterarClick - Carrega registro selecionado para edicao
1347:     *--------------------------------------------------------------------------
1348:     PROCEDURE BtnAlterarClick()
1349:         LOCAL loc_cCodigo
1350:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1351:             MsgAviso("Selecione um registro para alterar.", "")
1352:             RETURN
1353:         ENDIF
1354:         SELECT cursor_4c_Dados
1355:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1356:         IF EMPTY(loc_cCodigo)
1357:             MsgAviso("Selecione um registro para alterar.", "")
1358:             RETURN
1359:         ENDIF
1360:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1361:             THIS.this_oBusinessObject.EditarRegistro()
1362:             THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
1363:             THIS.this_cPcEscolha = "ALTERAR"
1364:             THIS.this_cModoAtual = "ALTERAR"
1365:             THIS.BOParaForm()
1366:             THIS.HabilitarCampos(.T.)
1367:             THIS.AjustarBotoesPorModo()
1368:             THIS.AlternarPagina(2)
1369:         ELSE
1370:             MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
1371:         ENDIF
1372:     ENDPROC
1373: 
1374:     *--------------------------------------------------------------------------
1375:     * BtnExcluirClick - Confirma e exclui registro selecionado
1376:     *--------------------------------------------------------------------------
1377:     PROCEDURE BtnExcluirClick()
1378:         LOCAL loc_cCodigo
1379:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1380:             MsgAviso("Selecione um registro para excluir.", "")
1381:             RETURN
1382:         ENDIF
1383:         SELECT cursor_4c_Dados
1384:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
1385:         IF EMPTY(loc_cCodigo)
1386:             MsgAviso("Selecione um registro para excluir.", "")
1387:             RETURN
1388:         ENDIF
1389:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirmar Exclus" + CHR(227) + "o")
1390:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1391:                 IF THIS.this_oBusinessObject.Excluir()
1392:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1393:                     THIS.CarregarLista()
1394:                 ELSE
1395:                     MsgErro("Erro ao excluir o registro.", "Erro")
1396:                 ENDIF
1397:             ELSE
1398:                 MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Erro")
1399:             ENDIF
1400:         ENDIF
1401:     ENDPROC
1402: 
1403:     *--------------------------------------------------------------------------
1404:     * BtnBuscarClick - Filtra lista por codigo, operacao ou usuario
1405:     *--------------------------------------------------------------------------
1406:     PROCEDURE BtnBuscarClick()
1407:         LOCAL loc_cFiltro
1408:         loc_cFiltro = INPUTBOX("Informe o c" + CHR(243) + "digo, opera" + CHR(231) + ;
1409:             CHR(227) + "o ou usu" + CHR(225) + "rio:", "Buscar")
1410:         IF VARTYPE(loc_cFiltro) = "C"
1411:             THIS.this_cPQuery = ALLTRIM(loc_cFiltro)
1412:             THIS.CarregarLista()
1413:         ENDIF
1414:     ENDPROC
1415: 
1416:     *--------------------------------------------------------------------------
1417:     * BtnEncerrarClick - Fecha o formulario
1418:     *--------------------------------------------------------------------------
1419:     PROCEDURE BtnEncerrarClick()
1420:         THIS.Release()
1421:     ENDPROC
1422: 
1423:     *--------------------------------------------------------------------------
1424:     * BtnSalvarClick - Transfere Form->BO e chama Salvar(); volta para lista
1425:     *--------------------------------------------------------------------------
1426:     PROCEDURE BtnSalvarClick()
1427:         LOCAL loc_lSucesso
1428:         loc_lSucesso = .F.
1429: 
1430:         TRY
1431:             THIS.FormParaBO()
1432:             IF THIS.this_oBusinessObject.Salvar()
1433:                 MsgInfo("Registro salvo com sucesso!", "")
1434:                 THIS.this_cModoAtual = "LISTA"
1435:                 THIS.AlternarPagina(1)
1436:                 loc_lSucesso = .T.
1437:             ELSE
1438:                 MsgErro("Erro ao salvar o registro.", "Erro")
1439:             ENDIF
1440:         CATCH TO loException
1441:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
1442:         ENDTRY
1443: 
1444:         RETURN loc_lSucesso
1445:     ENDPROC
1446: 
1447:     *--------------------------------------------------------------------------
1448:     * BtnCancelarClick - Cancela edicao e retorna para lista recarregada
1449:     *--------------------------------------------------------------------------
1450:     PROCEDURE BtnCancelarClick()
1451:         THIS.this_cModoAtual = "LISTA"
1452:         THIS.AlternarPagina(1)
1453:         THIS.CarregarLista()
1454:     ENDPROC
1455: 
1456:     *--------------------------------------------------------------------------
1457:     * FormParaBO - Transfere valores do formulario para o Business Object
1458:     * Usa PEMSTATUS para acessar controles da Page2 com seguranca
1459:     *--------------------------------------------------------------------------
1460:     PROTECTED PROCEDURE FormParaBO()
1461:         LOCAL loc_oPg2, loc_oBO
1462:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1463:         loc_oBO  = THIS.this_oBusinessObject
1464: 
1465:         *-- Empresa e operacao
1466:         loc_oBO.this_cEmps  = THIS.this_cPEmps
1467:         loc_oBO.this_cDopps = THIS.this_cDopp
1468: 
1469:         *-- Container central de dados (cntDados)
1470:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1471:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1472:                 loc_oBO.this_cCidchaves = ALLTRIM(loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value)
1473:             ENDIF
1474:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1475:                 loc_oBO.this_dDatas = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
1476:             ENDIF
1477:         ENDIF
1478: 
1479:         *-- Origem
1480:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1481:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1482:                 loc_oBO.this_cGrupoos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value)
1483:             ENDIF
1484:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1485:                 loc_oBO.this_cContaos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value)
1486:             ENDIF
1487:         ENDIF
1488: 
1489:         *-- Destino
1490:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1491:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1492:                 loc_oBO.this_cGrupods = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value)
1493:             ENDIF
1494:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1495:                 loc_oBO.this_cContads = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value)
1496:             ENDIF
1497:         ENDIF
1498: 
1499:         *-- Responsavel
1500:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)

*-- Linhas 1516 a 1559:
1516:     * BOParaForm - Transfere valores do Business Object para o formulario
1517:     * Usa PEMSTATUS para acessar controles da Page2 com seguranca
1518:     *--------------------------------------------------------------------------
1519:     PROTECTED PROCEDURE BOParaForm()
1520:         LOCAL loc_oPg2, loc_oBO
1521:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1522:         loc_oBO  = THIS.this_oBusinessObject
1523: 
1524:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1525:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1526:                 loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cCidchaves)
1527:             ENDIF
1528:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1529:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = loc_oBO.this_dDatas
1530:             ENDIF
1531:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
1532:                 loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ALLTRIM(loc_oBO.this_cDopps)
1533:             ENDIF
1534:         ENDIF
1535: 
1536:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1537:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1538:                 loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupoos)
1539:             ENDIF
1540:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1541:                 loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContaos)
1542:             ENDIF
1543:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
1544:                 loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
1545:             ENDIF
1546:         ENDIF
1547: 
1548:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1549:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1550:                 loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupods)
1551:             ENDIF
1552:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1553:                 loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContads)
1554:             ENDIF
1555:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
1556:                 loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
1557:             ENDIF
1558:         ENDIF
1559: 

*-- Linhas 1577 a 1620:
1577:     *--------------------------------------------------------------------------
1578:     * HabilitarCampos - Habilita/desabilita controles editaveis da Page2
1579:     *--------------------------------------------------------------------------
1580:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1581:         LOCAL loc_oPg2
1582:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1583: 
1584:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1585:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1586:                 loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Enabled = ;
1587:                     par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1588:             ENDIF
1589:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1590:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Enabled = par_lHabilitar
1591:             ENDIF
1592:         ENDIF
1593: 
1594:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1595:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1596:                 loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.ReadOnly = !par_lHabilitar
1597:             ENDIF
1598:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1599:                 loc_oPg2.cnt_4c_Origem.txt_4c_Conta.ReadOnly = !par_lHabilitar
1600:             ENDIF
1601:         ENDIF
1602: 
1603:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1604:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1605:                 loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.ReadOnly = !par_lHabilitar
1606:             ENDIF
1607:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1608:                 loc_oPg2.cnt_4c_Destino.txt_4c_Conta.ReadOnly = !par_lHabilitar
1609:             ENDIF
1610:         ENDIF
1611: 
1612:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
1613:             IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
1614:                 loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.ReadOnly = !par_lHabilitar
1615:             ENDIF
1616:             IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
1617:                 loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.ReadOnly = !par_lHabilitar
1618:             ENDIF
1619:         ENDIF
1620: 

*-- Linhas 1632 a 1675:
1632:     *--------------------------------------------------------------------------
1633:     * LimparCampos - Limpa valores dos controles da Page2
1634:     *--------------------------------------------------------------------------
1635:     PROTECTED PROCEDURE LimparCampos()
1636:         LOCAL loc_oPg2
1637:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1638: 
1639:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1640:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
1641:                 loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ""
1642:             ENDIF
1643:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1644:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
1645:             ENDIF
1646:             IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
1647:                 loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ""
1648:             ENDIF
1649:         ENDIF
1650: 
1651:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1652:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
1653:                 loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ""
1654:             ENDIF
1655:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
1656:                 loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ""
1657:             ENDIF
1658:             IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
1659:                 loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
1660:             ENDIF
1661:         ENDIF
1662: 
1663:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
1664:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
1665:                 loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ""
1666:             ENDIF
1667:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
1668:                 loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ""
1669:             ENDIF
1670:             IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
1671:                 loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
1672:             ENDIF
1673:         ENDIF
1674: 
1675:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)

*-- Linhas 1692 a 2084:
1692:     *--------------------------------------------------------------------------
1693:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
1694:     *--------------------------------------------------------------------------
1695:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1696:         LOCAL loc_oPg1, loc_oPg2, loc_lLista, loc_lEditar
1697:         loc_oPg1   = THIS.pgf_4c_Paginas.Page1
1698:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1699:         loc_lLista  = (THIS.this_cModoAtual = "LISTA")
1700:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1701: 
1702:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1703:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1704:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
1705:             ENDIF
1706:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1707:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
1708:             ENDIF
1709:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1710:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
1711:             ENDIF
1712:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1713:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
1714:             ENDIF
1715:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1716:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
1717:             ENDIF
1718:         ENDIF
1719: 
1720:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1721:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1722:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1723:             ENDIF
1724:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1725:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1726:             ENDIF
1727:         ENDIF
1728:     ENDPROC
1729: 
1730:     *--------------------------------------------------------------------------
1731:     * ValidarDataMov - Valida data da movimentacao ao sair do campo
1732:     * Legado: Dt_data.Valid - verifica fVerificaBloqueio e fBloqueioPorPeriodo
1733:     * No novo sistema: verifica se a data esta dentro do periodo permitido pelo BO
1734:     * Tambem bloqueia alteracao de data quando ja existem envelopes (TmpOperacao)
1735:     *--------------------------------------------------------------------------
1736:     PROCEDURE ValidarDataMov()
1737:         LOCAL loc_oPg2, loc_dData, loc_lBloqueado, loc_nContEnv
1738:         loc_lBloqueado = .F.
1739: 
1740:         TRY
1741:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1742: 
1743:             IF !PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
1744:                 RETURN
1745:             ENDIF
1746:             IF !PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
1747:                 RETURN
1748:             ENDIF
1749: 
1750:             loc_dData = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
1751: 
1752:             IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1753:                 RETURN
1754:             ENDIF
1755: 
1756:             IF EMPTY(loc_dData)
1757:                 MsgAviso("Informe uma data v" + CHR(225) + "lida.", "")
1758:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
1759:                 RETURN
1760:             ENDIF
1761: 
1762:             *-- Verifica se ja existem envelopes/ops lancados (TmpOperacao)
1763:             *-- Legado: Count to _LnCont For Codigos > 0
1764:             IF USED("TmpOperacao")
1765:                 SELECT TmpOperacao
1766:                 COUNT TO loc_nContEnv FOR Codigos > 0
1767:                 IF loc_nContEnv > 0
1768:                     MsgAviso("A Data s" + CHR(243) + "mente pode ser alterada antes de Informar Envelopes/Ops", "")
1769:                     loc_lBloqueado = .T.
1770:                 ENDIF
1771:             ENDIF
1772: 
1773:             *-- Verifica bloqueio de periodo no BO
1774:             IF !loc_lBloqueado
1775:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1776:                     IF THIS.this_oBusinessObject.VerificarPeriodoBloqueado(loc_dData)
1777:                         MsgAviso("Per" + CHR(237) + "odo Bloqueado!!!", "")
1778:                         loc_lBloqueado = .T.
1779:                     ENDIF
1780:                 ENDIF
1781:             ENDIF
1782: 
1783:             IF loc_lBloqueado
1784:                 loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
1785:             ENDIF
1786: 
1787:         CATCH TO loException
1788:             MostrarErro("Erro ao validar data:" + CHR(13) + loException.Message, "Erro")
1789:         ENDTRY
1790:     ENDPROC
1791: 
1792:     *--------------------------------------------------------------------------
1793:     * BtnOperacaoClick - Abre sub-formulario de operacoes (legado: SigPdMp5)
1794:     * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xMfas -> Do Form SigPdMp5
1795:     *--------------------------------------------------------------------------
1796:     PROCEDURE BtnOperacaoClick()
1797:         LOCAL loc_cFormPath
1798:         IF THIS.this_cPcEscolha = "PROCURAR"
1799:             RETURN
1800:         ENDIF
1801:         TRY
1802:             THIS.Enabled = .F.
1803:             IF USED("xMfas")
1804:                 SELECT xMfas
1805:                 SET ORDER TO
1806:             ENDIF
1807:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp5.scx"
1808:             IF FILE(loc_cFormPath)
1809:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1810:             ELSE
1811:                 MsgAviso("Subformul" + CHR(225) + "rio de Opera" + CHR(231) + CHR(245) + "es (SigPdMp5) n" + ;
1812:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1813:             ENDIF
1814:             THIS.Enabled = .T.
1815:         CATCH TO loException
1816:             THIS.Enabled = .T.
1817:             MostrarErro("Erro ao abrir Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
1818:         ENDTRY
1819:     ENDPROC
1820: 
1821:     *--------------------------------------------------------------------------
1822:     * BtnComponentesClick - Abre sub-formulario de componentes (legado: SigPdMp2)
1823:     * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xNensi -> Do Form SigPdMp2
1824:     *--------------------------------------------------------------------------
1825:     PROCEDURE BtnComponentesClick()
1826:         LOCAL loc_cFormPath
1827:         IF THIS.this_cPcEscolha = "PROCURAR"
1828:             RETURN
1829:         ENDIF
1830:         TRY
1831:             THIS.Enabled = .F.
1832:             IF USED("xNensi")
1833:                 SELECT xNensi
1834:                 SET ORDER TO
1835:             ENDIF
1836:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp2.scx"
1837:             IF FILE(loc_cFormPath)
1838:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1839:             ELSE
1840:                 MsgAviso("Subformul" + CHR(225) + "rio de Componentes (SigPdMp2) n" + ;
1841:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1842:             ENDIF
1843:             THIS.Enabled = .T.
1844:         CATCH TO loException
1845:             THIS.Enabled = .T.
1846:             MostrarErro("Erro ao abrir Componentes:" + CHR(13) + loException.Message, "Erro")
1847:         ENDTRY
1848:     ENDPROC
1849: 
1850:     *--------------------------------------------------------------------------
1851:     * BtnEtiquetasClick - Abre sub-formulario de etiquetas/pesagem
1852:     * Legado: If pcEscolha<>'PROCURAR':
1853:     *   If crSigCdPam.AltPesas=1 -> Select xOpi -> Do Form SigPdMp3
1854:     *   Else -> Select xPesa -> Do Form SigPdMp9
1855:     *--------------------------------------------------------------------------
1856:     PROCEDURE BtnEtiquetasClick()
1857:         LOCAL loc_cFormPath, loc_lAltPesas
1858:         IF THIS.this_cPcEscolha = "PROCURAR"
1859:             RETURN
1860:         ENDIF
1861:         TRY
1862:             THIS.Enabled = .F.
1863:             loc_lAltPesas = .F.
1864: 
1865:             *-- Verifica flag AltPesas no cursor de parametros (crSigCdPam)
1866:             IF USED("crSigCdPam") AND PEMSTATUS(crSigCdPam, "AltPesas", 8)
1867:                 loc_lAltPesas = (crSigCdPam.AltPesas = 1)
1868:             ENDIF
1869: 
1870:             IF loc_lAltPesas
1871:                 IF USED("xOpi")
1872:                     SELECT xOpi
1873:                     GO TOP
1874:                 ENDIF
1875:                 loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp3.scx"
1876:                 IF FILE(loc_cFormPath)
1877:                     DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1878:                 ELSE
1879:                     MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp3) n" + ;
1880:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1881:                 ENDIF
1882:             ELSE
1883:                 IF USED("xPesa")
1884:                     SELECT xPesa
1885:                     GO TOP
1886:                 ENDIF
1887:                 loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp9.scx"
1888:                 IF FILE(loc_cFormPath)
1889:                     DO FORM (loc_cFormPath) WITH THIS
1890:                 ELSE
1891:                     MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp9) n" + ;
1892:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1893:                 ENDIF
1894:             ENDIF
1895:             THIS.Enabled = .T.
1896:         CATCH TO loException
1897:             THIS.Enabled = .T.
1898:             MostrarErro("Erro ao abrir Etiquetas:" + CHR(13) + loException.Message, "Erro")
1899:         ENDTRY
1900:     ENDPROC
1901: 
1902:     *--------------------------------------------------------------------------
1903:     * BtnDadosClick - Abre sub-formulario de complemento de dados (legado: SigOpInf)
1904:     * Legado: Do Form SigOpInf With ThisForm, ThisForm.DataSessionId
1905:     *--------------------------------------------------------------------------
1906:     PROCEDURE BtnDadosClick()
1907:         LOCAL loc_cFormPath
1908:         TRY
1909:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpInf.scx"
1910:             IF FILE(loc_cFormPath)
1911:                 DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
1912:             ELSE
1913:                 MsgAviso("Subformul" + CHR(225) + "rio de Complemento (SigOpInf) n" + ;
1914:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1915:             ENDIF
1916:         CATCH TO loException
1917:             MostrarErro("Erro ao abrir Complemento:" + CHR(13) + loException.Message, "Erro")
1918:         ENDTRY
1919:     ENDPROC
1920: 
1921:     *--------------------------------------------------------------------------
1922:     * BtnBoletoClick - Impressao de boleto se operacao permite
1923:     * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Boletos=1 -> ImpBol()
1924:     *--------------------------------------------------------------------------
1925:     PROCEDURE BtnBoletoClick()
1926:         LOCAL loc_lPermite
1927:         loc_lPermite = .F.
1928:         TRY
1929:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
1930:                 SELECT crSigCdOpd
1931:                 SET NEAR ON
1932:                 SEEK THIS.this_cDopp ORDER TAG Dopps
1933:                 SET NEAR OFF
1934:                 IF FOUND() AND !EOF("crSigCdOpd")
1935:                     loc_lPermite = (crSigCdOpd.Boletos = 1)
1936:                 ENDIF
1937:             ENDIF
1938:             IF loc_lPermite
1939:                 THIS.ImpBol()
1940:             ELSE
1941:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
1942:                     "o permite impress" + CHR(227) + "o de boleto.", "")
1943:             ENDIF
1944:         CATCH TO loException
1945:             MostrarErro("Erro ao imprimir boleto:" + CHR(13) + loException.Message, "Erro")
1946:         ENDTRY
1947:     ENDPROC
1948: 
1949:     *--------------------------------------------------------------------------
1950:     * BtnDocumentoClick - Impressao de documento se operacao permite
1951:     * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Docus=1 -> Do SigPrIdc
1952:     *--------------------------------------------------------------------------
1953:     PROCEDURE BtnDocumentoClick()
1954:         LOCAL loc_lPermite, loc_cPrgPath
1955:         loc_lPermite = .F.
1956:         TRY
1957:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
1958:                 SELECT crSigCdOpd
1959:                 SET NEAR ON
1960:                 SEEK THIS.this_cDopp ORDER TAG Dopps
1961:                 SET NEAR OFF
1962:                 IF FOUND() AND !EOF("crSigCdOpd")
1963:                     loc_lPermite = (crSigCdOpd.Docus = 1)
1964:                 ENDIF
1965:             ENDIF
1966:             IF loc_lPermite AND USED("TmpNens") AND !EOF("TmpNens")
1967:                 SELECT TmpNens
1968: 
1969:                 *-- Atualiza cursor crSigCdNec para registro corrente
1970:                 IF USED("crSigCdOpd")
1971:                     SELECT crSigCdOpd
1972:                     SET NEAR ON
1973:                     SEEK ALLTRIM(TmpNens.Dopps) ORDER TAG Dopps
1974:                     SET NEAR OFF
1975:                 ENDIF
1976: 
1977:                 loc_cPrgPath = gc_4c_CaminhoBase + "..\Framework\SigPrIdc.prg"
1978:                 IF FILE(loc_cPrgPath)
1979:                     DO (loc_cPrgPath) WITH ;
1980:                         ALLTRIM(TmpNens.Emps), ALLTRIM(TmpNens.Dopps), TmpNens.Numps, ;
1981:                         0, crSigCdOpd.QtdDocs, .F., .F., .F., .F., .F., .F., THIS
1982:                 ELSE
1983:                     MsgAviso("Rotina de impress" + CHR(227) + "o de documento (SigPrIdc) n" + ;
1984:                         CHR(227) + "o dispon" + CHR(237) + "vel.", "")
1985:                 ENDIF
1986:             ELSE
1987:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
1988:                     "o permite impress" + CHR(227) + "o de documento.", "")
1989:             ENDIF
1990:         CATCH TO loException
1991:             MostrarErro("Erro ao imprimir documento:" + CHR(13) + loException.Message, "Erro")
1992:         ENDTRY
1993:     ENDPROC
1994: 
1995:     *--------------------------------------------------------------------------
1996:     * ImpBol - Impressao de boleto via sub-formulario SigOpIbo
1997:     * Legado: Do Form SigOpIbo With Thisform, 2, This.Titulo
1998:     *--------------------------------------------------------------------------
1999:     PROCEDURE ImpBol()
2000:         LOCAL loc_cFormPath
2001:         TRY
2002:             loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpIbo.scx"
2003:             IF FILE(loc_cFormPath)
2004:                 DO FORM (loc_cFormPath) WITH THIS, 2, THIS.this_cTitulo
2005:             ELSE
2006:                 MsgAviso("Subformul" + CHR(225) + "rio de boleto (SigOpIbo) n" + ;
2007:                     CHR(227) + "o dispon" + CHR(237) + "vel.", "")
2008:             ENDIF
2009:         CATCH TO loException
2010:             MostrarErro("Erro ao imprimir boleto (ImpBol):" + CHR(13) + loException.Message, "Erro")
2011:         ENDTRY
2012:     ENDPROC
2013: 
2014:     *--------------------------------------------------------------------------
2015:     * Activate - Gerencia foco automatico ao ativar o formulario
2016:     * Legado: Activate -> Seek(Dopp, crSigCdOpd, Dopps) + SetFocus nos campos
2017:     * this_lAtFoco controla se deve setar foco (evita loop na 1a abertura)
2018:     *--------------------------------------------------------------------------
2019:     PROCEDURE Activate()
2020:         LOCAL loc_oPg2
2021:         TRY
2022:             DODEFAULT()
2023: 
2024:             *-- Posiciona cursor de operacoes no Dopp corrente
2025:             IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
2026:                 SELECT crSigCdOpd
2027:                 SET NEAR ON
2028:                 SEEK THIS.this_cDopp ORDER TAG Dopps
2029:                 SET NEAR OFF
2030:             ENDIF
2031: 
2032:             *-- Coloca foco no campo adequado conforme modo
2033:             IF THIS.this_lAtFoco
2034:                 THIS.this_lAtFoco = .F.
2035:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2036: 
2037:                 DO CASE
2038:                     CASE THIS.this_cPcEscolha = "PROCURAR"
2039:                         IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5) AND ;
2040:                            PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
2041:                             loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.SetFocus
2042:                         ENDIF
2043: 
2044:                     CASE INLIST(THIS.this_cPcEscolha, "CONSULTAR", "EXCLUIR")
2045:                         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5) AND ;
2046:                            PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
2047:                             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
2048:                         ENDIF
2049:                 ENDCASE
2050:             ENDIF
2051: 
2052:             *-- Garantir cursor TmpNens no topo se disponivel
2053:             IF USED("TmpNens")
2054:                 SELECT TmpNens
2055:                 GO TOP
2056:             ENDIF
2057: 
2058:         CATCH TO loException
2059:             *-- Erros de foco nao devem travar a interface
2060:         ENDTRY
2061:     ENDPROC
2062: 
2063:     *--------------------------------------------------------------------------
2064:     * Destroy - Libera recursos ao fechar o formulario
2065:     *--------------------------------------------------------------------------
2066:     PROCEDURE Destroy()
2067:         LOCAL loc_oErro
2068:         TRY
2069:             IF USED("cursor_4c_Dados")
2070:                 USE IN cursor_4c_Dados
2071:             ENDIF
2072:             IF USED("TmpOperacao")
2073:                 USE IN TmpOperacao
2074:             ENDIF
2075:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2076:                 THIS.this_oBusinessObject = .NULL.
2077:             ENDIF
2078:         CATCH TO loc_oErro
2079:             *-- Ignorar erros no Destroy para nao bloquear fechamento
2080:         ENDTRY
2081:         DODEFAULT()
2082:     ENDPROC
2083: 
2084: ENDDEFINE


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

