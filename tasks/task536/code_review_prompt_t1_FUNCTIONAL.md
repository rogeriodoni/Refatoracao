# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (22)
- [BINDEVENT-PARAMS] Handler 'ValidarTransTipo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTransTipo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDirGeracao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDirGeracao(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDirLeitura' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDirLeitura(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDirRecepcao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDirRecepcao(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDirArquivar' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDirArquivar(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarFtpSenha' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarFtpSenha(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSenha2' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSenha2(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGradeOperacao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGradeOperacao(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGradeSNT3' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGradeSNT3(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGradeSNT4' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGradeSNT4(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGradeLocalEntrega' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGradeLocalEntrega(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGradeApagas' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGradeApagas(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGradeNumeras' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGradeNumeras(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGradeDtTrans' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGradeDtTrans(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGradeTituloOperacao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGradeTituloOperacao(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGradeTituloSNA' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGradeTituloSNA(par_nKeyCode, par_nShiftAltCtrl)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Grade' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Titulos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Transporte' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Operação, Pg, Bx, Empds, Operação Destino, Local Entrega, Del, DD, NN, DT, S/N/A. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Operação, Pg, Bx, Empds, Operação Destino, Local Entrega, Del, DD, NN, DT, S/N/A. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'chklocdel' (parent: SIGCDTME.Pagina.Dados.Pageframe1.Page1): Top original=210 vs migrado 'chk_4c_Chklocdel' Top=313 (diff=103px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkftpdel' (parent: SIGCDTME.Pagina.Dados.Pageframe1.Page1): Top original=210 vs migrado 'chk_4c_Chkftpdel' Top=313 (diff=103px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTme.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2788 linhas total):

*-- Linhas 24 a 159:
24: 
25:     *-- Guardas anti-repeticao para LostFocus (Problema 45: LostFocus dispara
26:     *-- sempre, ao contrario de Valid que so dispara quando o valor muda)
27:     this_cUltimoTransTipo   = ""
28:     this_cUltimoDirGeracao  = ""
29:     this_cUltimoDirLeitura  = ""
30:     this_cUltimoDirRecepcao = ""
31:     this_cUltimoDirArquivar = ""
32: 
33:     *===========================================================================
34:     * Init - Inicializa o formulario
35:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
36:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
37:     *===========================================================================
38:     PROCEDURE Init()
39:         RETURN DODEFAULT()
40:     ENDPROC
41: 
42:     *===========================================================================
43:     * InicializarForm - Configura estrutura completa
44:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
45:     *===========================================================================
46:     PROTECTED PROCEDURE InicializarForm()
47:         LOCAL loc_lSucesso
48:         loc_lSucesso = .F.
49: 
50:         TRY
51:             THIS.this_oBusinessObject = CREATEOBJECT("TmeBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
54:                 MostrarErro("Erro ao criar TmeBO" + CHR(13) + ;
55:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
56:                     "FormTme.InicializarForm")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Visible = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"
66: 
67:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
68:                     IF PEMSTATUS(THIS, "CarregarLista", 5)
69:                         THIS.CarregarLista()
70:                     ENDIF
71:                 ENDIF
72: 
73:                 loc_lSucesso = .T.
74:             ENDIF
75: 
76:         CATCH TO loException
77:             MostrarErro("Erro ao inicializar FormTme:" + CHR(13) + ;
78:                 loException.Message + CHR(13) + ;
79:                 "Linha: " + TRANSFORM(loException.LineNo), ;
80:                 "FormTme.InicializarForm")
81:         ENDTRY
82: 
83:         RETURN loc_lSucesso
84:     ENDPROC
85: 
86:     *===========================================================================
87:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
88:     * Top=-29 para esconder abas; controles compensam +29 no Top
89:     *===========================================================================
90:     PROTECTED PROCEDURE ConfigurarPageFrame()
91:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
92: 
93:         WITH THIS.pgf_4c_Paginas
94:             .PageCount = 2
95:             .Top       = -29
96:             .Left      = 0
97:             .Width     = THIS.Width
98:             .Height    = THIS.Height + 29
99:             .Tabs      = .F.
100:             .Visible   = .T.
101: 
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page1.BackColor = RGB(255, 255, 255)
105: 
106:             .Page2.Caption   = "Dados"
107:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.BackColor = RGB(255, 255, 255)
109:         ENDWITH
110: 
111:         THIS.ConfigurarPaginaLista()
112:         THIS.ConfigurarPaginaDados()
113:     ENDPROC
114: 
115:     *===========================================================================
116:     * ConfigurarPaginaLista - Page1: cabecalho + Grid + botoes CRUD completos
117:     * Grid: cursor_4c_Dados (tipoemps, tipos, emps, descrs) - populado por CarregarLista()
118:     *===========================================================================
119:     PROTECTED PROCEDURE ConfigurarPaginaLista()
120:         LOCAL loc_oPagina
121:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
122: 
123:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
124: 
125:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
126:         *-- Original: Top=1. Com compensacao +29: Top=31
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = THIS.Caption
141:             .Top       = 15
142:             .Left      = 10
143:             .Width     = 769
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = THIS.Caption
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = 769

*-- Linhas 204 a 515:
204:             .AutoSize        = .F.
205:             .Visible         = .T.
206:         ENDWITH
207:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
208: 
209:         *-- Botao Visualizar (Left=80)
210:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
211:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
212:             .Caption         = "Visualizar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
214:             .PicturePosition = 13
215:             .Top             = 5
216:             .Left            = 80
217:             .Width           = 75
218:             .Height          = 75
219:             .FontName        = "Tahoma"
220:             .FontBold        = .T.
221:             .FontItalic      = .T.
222:             .FontSize        = 8
223:             .ForeColor       = RGB(90, 90, 90)
224:             .BackColor       = RGB(255, 255, 255)
225:             .Themes          = .F.
226:             .SpecialEffect   = 0
227:             .MousePointer    = 15
228:             .WordWrap        = .T.
229:             .AutoSize        = .F.
230:             .Visible         = .T.
231:         ENDWITH
232:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
233: 
234:         *-- Botao Alterar (Left=155)
235:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
236:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
237:             .Caption         = "Alterar"
238:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
239:             .PicturePosition = 13
240:             .Top             = 5
241:             .Left            = 155
242:             .Width           = 75
243:             .Height          = 75
244:             .FontName        = "Tahoma"
245:             .FontBold        = .T.
246:             .FontItalic      = .T.
247:             .FontSize        = 8
248:             .ForeColor       = RGB(90, 90, 90)
249:             .BackColor       = RGB(255, 255, 255)
250:             .Themes          = .F.
251:             .SpecialEffect   = 0
252:             .MousePointer    = 15
253:             .WordWrap        = .T.
254:             .AutoSize        = .F.
255:             .Visible         = .T.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
258: 
259:         *-- Botao Excluir (Left=230)
260:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
261:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
262:             .Caption         = "Excluir"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
264:             .PicturePosition = 13
265:             .Top             = 5
266:             .Left            = 230
267:             .Width           = 75
268:             .Height          = 75
269:             .FontName        = "Tahoma"
270:             .FontBold        = .T.
271:             .FontItalic      = .T.
272:             .FontSize        = 8
273:             .ForeColor       = RGB(90, 90, 90)
274:             .BackColor       = RGB(255, 255, 255)
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .MousePointer    = 15
278:             .WordWrap        = .T.
279:             .AutoSize        = .F.
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
283: 
284:         *-- Botao Buscar (Left=305)
285:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
287:             .Caption         = "Buscar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:             .PicturePosition = 13
290:             .Top             = 5
291:             .Left            = 305
292:             .Width           = 75
293:             .Height          = 75
294:             .FontName        = "Tahoma"
295:             .FontBold        = .T.
296:             .FontItalic      = .T.
297:             .FontSize        = 8
298:             .ForeColor       = RGB(90, 90, 90)
299:             .BackColor       = RGB(255, 255, 255)
300:             .Themes          = .F.
301:             .SpecialEffect   = 0
302:             .MousePointer    = 15
303:             .WordWrap        = .T.
304:             .AutoSize        = .F.
305:             .Visible         = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
308: 
309:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
310:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
311:         WITH loc_oPagina.cnt_4c_Saida
312:             .Top         = 29
313:             .Left        = 917
314:             .Width       = 90
315:             .Height      = 85
316:             .BackStyle = 1
317:             .BackColor = RGB(255, 255, 255)
318:             .BorderWidth = 0
319:             .Visible     = .T.
320:         ENDWITH
321: 
322:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
323:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
324:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
325:             .Caption         = "Encerrar"
326:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
327:             .PicturePosition = 13
328:             .Top             = 5
329:             .Left            = 5
330:             .Width           = 75
331:             .Height          = 75
332:             .FontName        = "Tahoma"
333:             .FontBold        = .T.
334:             .FontItalic      = .T.
335:             .FontSize        = 8
336:             .ForeColor       = RGB(90, 90, 90)
337:             .BackColor       = RGB(255, 255, 255)
338:             .Themes          = .F.
339:             .SpecialEffect   = 0
340:             .MousePointer    = 15
341:             .WordWrap        = .T.
342:             .AutoSize        = .F.
343:             .Visible         = .T.
344:         ENDWITH
345:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
346: 
347:         *-- Grid de listagem de transportes
348:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
349:         *-- Colunas: tipos (Transporte), emps (Empresa), descrs (Descricao)
350:         *-- tipoemps (PK concatenada) permanece no cursor mas nao eh exibida
351:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
352:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
353:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
354:         WITH loc_oPagina.grd_4c_Lista
355:             .Top                = 117
356:             .Left               = 26
357:             .Width              = 880
358:             .Height             = 498
359:             .FontName           = "Verdana"
360:             .FontSize           = 8
361:             .ForeColor          = RGB(90, 90, 90)
362:             .BackColor          = RGB(255, 255, 255)
363:             .GridLineColor      = RGB(238, 238, 238)
364:             .HighlightBackColor = RGB(255, 255, 255)
365:             .HighlightForeColor = RGB(15, 41, 104)
366:             .HighlightStyle     = 2
367:             .DeleteMark         = .F.
368:             .RecordMark         = .F.
369:             .RowHeight          = 16
370:             .ScrollBars         = 2
371:             .GridLines          = 3
372:             .Visible            = .T.
373:         ENDWITH
374:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
375: 
376:         THIS.TornarControlesVisiveis(loc_oPagina)
377:     ENDPROC
378: 
379:     *===========================================================================
380:     * CarregarLista - Carrega dados no grid da Page1
381:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
382:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
383:     *===========================================================================
384:     PROCEDURE CarregarLista()
385:         LOCAL loc_lResultado, loc_oGrid
386:         loc_lResultado = .F.
387: 
388:         TRY
389:             IF !THIS.this_oBusinessObject.Buscar("")
390:                 loc_lResultado = .F.
391:             ELSE
392:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
393: 
394:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
395:                 loc_oGrid.ColumnCount = 3
396:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
397: 
398:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
399:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
400:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
401:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
402: 
403:                 loc_oGrid.Column1.Width = 150
404:                 loc_oGrid.Column2.Width = 80
405:                 loc_oGrid.Column3.Width = 640
406: 
407:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
408:                 loc_oGrid.Column1.Header1.Caption = "Transporte"
409:                 loc_oGrid.Column2.Header1.Caption = "Emp"
410:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
411: 
412:                 THIS.FormatarGridLista(loc_oGrid)
413:                 loc_lResultado = .T.
414:             ENDIF
415: 
416:         CATCH TO loException
417:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
418:                 "Linha: " + TRANSFORM(loException.LineNo), ;
419:                 "FormTme.CarregarLista")
420:             loc_lResultado = .F.
421:         ENDTRY
422: 
423:         RETURN loc_lResultado
424:     ENDPROC
425: 
426:     *===========================================================================
427:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
428:     *===========================================================================
429:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
430:         TRY
431:             WITH par_oGrid
432:                 .FontName = "Tahoma"
433:                 .FontSize = 8
434:             ENDWITH
435:         CATCH TO loException
436:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
437:                 "FormTme.FormatarGridLista")
438:         ENDTRY
439:     ENDPROC
440: 
441:     *===========================================================================
442:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
443:     * Ao voltar para Page1, recarrega a lista
444:     *===========================================================================
445:     PROCEDURE AlternarPagina(par_nPagina)
446:         LOCAL loc_lResultado
447:         loc_lResultado = .F.
448: 
449:         TRY
450:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
451:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
452:             ELSE
453:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
454: 
455:                 IF par_nPagina = 1
456:                     THIS.this_cModoAtual = "LISTA"
457:                     THIS.CarregarLista()
458:                 ENDIF
459: 
460:                 loc_lResultado = .T.
461:             ENDIF
462: 
463:         CATCH TO loException
464:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
465:                 "FormTme.AlternarPagina")
466:         ENDTRY
467: 
468:         RETURN loc_lResultado
469:     ENDPROC
470: 
471:     *===========================================================================
472:     * ConfigurarPaginaDados - Page2: cabecalho + container de acao (vazio)
473:     * Campos e botoes Confirmar/Cancelar serao adicionados em fases futuras
474:     *===========================================================================
475:     PROTECTED PROCEDURE ConfigurarPaginaDados()
476:         LOCAL loc_oPagina
477:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
478: 
479:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
480: 
481:         *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
482:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
483:         WITH loc_oPagina.cnt_4c_Cabecalho
484:             .Top           = 29
485:             .Left          = 0
486:             .Width         = THIS.Width
487:             .Height        = 80
488:             .BackColor     = RGB(100, 100, 100)
489:             .BorderWidth   = 0
490:             .SpecialEffect = 0
491:             .Visible       = .T.
492: 
493:             .AddObject("lbl_4c_Sombra", "Label")
494:             WITH .lbl_4c_Sombra
495:                 .Caption   = THIS.Caption
496:                 .Top       = 15
497:                 .Left      = 10
498:                 .Width     = THIS.Width
499:                 .Height    = 40
500:                 .FontName  = "Tahoma"
501:                 .FontSize  = 16
502:                 .FontBold  = .T.
503:                 .ForeColor = RGB(0, 0, 0)
504:                 .BackStyle = 0
505:                 .AutoSize  = .F.
506:                 .Visible   = .T.
507:             ENDWITH
508: 
509:             .AddObject("lbl_4c_Titulo", "Label")
510:             WITH .lbl_4c_Titulo
511:                 .Caption   = THIS.Caption
512:                 .Top       = 18
513:                 .Left      = 10
514:                 .Width     = THIS.Width
515:                 .Height    = 46

*-- Linhas 560 a 628:
560:             .AutoSize        = .F.
561:             .Visible         = .T.
562:         ENDWITH
563:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
564: 
565:         *-- Botao Cancelar (Left=80)
566:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
567:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
568:             .Caption         = "Encerrar"
569:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
570:             .PicturePosition = 13
571:             .Top             = 5
572:             .Left            = 80
573:             .Width           = 75
574:             .Height          = 75
575:             .FontName        = "Tahoma"
576:             .FontBold        = .T.
577:             .FontItalic      = .T.
578:             .FontSize        = 8
579:             .ForeColor       = RGB(90, 90, 90)
580:             .BackColor       = RGB(255, 255, 255)
581:             .Themes          = .F.
582:             .SpecialEffect   = 0
583:             .MousePointer    = 15
584:             .WordWrap        = .T.
585:             .AutoSize        = .F.
586:             .Visible         = .T.
587:         ENDWITH
588:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
589: 
590:         *-- FASE 5/8 - Campos Principais Parte 1 (Secao "Configuracao do
591:         *-- Transporte" do legado: Pageframe1.Page1, Top original 12..149).
592:         *-- FASE 6/8 - Campos Restantes Parte 2 (Secao "Configuracao da area
593:         *-- do FTP" do legado: Pageframe1.Page1, Top original 185..306).
594:         *-- Traducao de coordenadas: Top_novo = Top_original + 103
595:         *-- (compensa cabecalho canonico Top=29/Height=80 -> minimo 109).
596:         THIS.AdicionarCamposIdentificacao(loc_oPagina)
597:         THIS.AdicionarCamposTransporte(loc_oPagina)
598:         THIS.AdicionarCamposFtp(loc_oPagina)
599: 
600:         *-- FASE 9 - PageFrame interno (legado Pageframe1.Page2.Configuracao, 3
601:         *-- sub-paginas: Titulos/Pag/Rec/Lote Chq, Operacoes de Estoque e
602:         *-- Configuracao). Posicionado abaixo da secao FTP, que termina em
603:         *-- Top=411 (shp_4c_DivisorFtpFim). Page2 = legado Configuracao.Page1
604:         *-- "Operacoes de Estoque" (grid de 11 colunas) - conteudo desta fase.
605:         loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
606:         WITH loc_oPagina.pgf_4c_DadosInternos
607:             .PageCount = 3
608:             .Top       = 420
609:             .Left      = 6
610:             .Width     = 689
611:             .Height    = 291
612:             .Visible   = .T.
613: 
614:             .Page1.Caption   = "Titulos/Pag/Rec/Lote Chq"
615:             .Page1.FontName  = "Tahoma"
616:             .Page1.FontSize  = 8
617:             .Page1.BackColor = RGB(255, 255, 255)
618:             .Page1.ForeColor = RGB(90, 90, 90)
619: 
620:             .Page2.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Estoque"
621:             .Page2.FontName  = "Tahoma"
622:             .Page2.FontSize  = 8
623:             .Page2.BackColor = RGB(255, 255, 255)
624:             .Page2.ForeColor = RGB(90, 90, 90)
625: 
626:             .Page3.Caption   = "Configura" + CHR(231) + CHR(227) + "o"
627:             .Page3.FontName  = "Tahoma"
628:             .Page3.FontSize  = 8

*-- Linhas 640 a 691:
640:         THIS.ConfigurarPgPage1()
641:         THIS.ConfigurarPgPage2()
642: 
643:         THIS.TornarControlesVisiveis(loc_oPagina)
644:     ENDPROC
645: 
646:     *===========================================================================
647:     * AdicionarCamposIdentificacao - Linha de identificacao (fora da caixa
648:     * "Configuracao do Transporte"): Processo/Tipos, Empresa, Descricao,
649:     * Tipo de Extensao do Arquivo. Legado: Top 12/16.
650:     *===========================================================================
651:     PROTECTED PROCEDURE AdicionarCamposIdentificacao(par_oPagina)
652:         *-- Processo (Tipos) - chave do transporte
653:         par_oPagina.AddObject("lbl_4c_Processo", "Label")
654:         WITH par_oPagina.lbl_4c_Processo
655:             .Caption   = "Processo :"
656:             .Top       = 119
657:             .Left      = 18
658:             .Width     = 62
659:             .Height    = 15
660:             .FontName  = "Tahoma"
661:             .FontSize  = 8
662:             .ForeColor = RGB(90, 90, 90)
663:             .BackStyle = 0
664:             .AutoSize  = .F.
665:             .Visible   = .T.
666:         ENDWITH
667: 
668:         par_oPagina.AddObject("txt_4c_Tipos", "TextBox")
669:         WITH par_oPagina.txt_4c_Tipos
670:             .Top       = 115
671:             .Left      = 85
672:             .Width     = 52
673:             .Height    = 23
674:             .FontName  = "Tahoma"
675:             .FontSize  = 8
676:             .ForeColor = RGB(0, 0, 0)
677:             .BackColor = RGB(255, 255, 255)
678:             .Value     = ""
679:             .Visible   = .T.
680:         ENDWITH
681: 
682:         *-- Empresa (Emps) - fAcessoEmpresa() NAO foi portada, campo simples
683:         par_oPagina.AddObject("lbl_4c_Empresa", "Label")
684:         WITH par_oPagina.lbl_4c_Empresa
685:             .Caption   = "Empresa :"
686:             .Top       = 119
687:             .Left      = 142
688:             .Width     = 60
689:             .Height    = 15
690:             .FontName  = "Tahoma"
691:             .FontSize  = 8

*-- Linhas 777 a 820:
777:     * geracao, No.Transporte Ok, diretorio de leitura, Nao Checar Sequencia,
778:     * diretorio de recepcao, diretorio para arquivar.
779:     *===========================================================================
780:     PROTECTED PROCEDURE AdicionarCamposTransporte(par_oPagina)
781:         *-- Divisor + titulo da secao (Shape3 + Say15 do legado)
782:         par_oPagina.AddObject("shp_4c_DivisorTransporte", "Shape")
783:         WITH par_oPagina.shp_4c_DivisorTransporte
784:             .Top     = 147
785:             .Left    = 6
786:             .Width   = 690
787:             .Height  = 2
788:             .Visible = .T.
789:         ENDWITH
790: 
791:         par_oPagina.AddObject("lbl_4c_SecaoTransporte", "Label")
792:         WITH par_oPagina.lbl_4c_SecaoTransporte
793:             .Caption   = " Configura" + CHR(231) + CHR(227) + "o do Transporte"
794:             .Top       = 150
795:             .Left      = 6
796:             .Width     = 250
797:             .Height    = 18
798:             .FontName  = "Tahoma"
799:             .FontSize  = 8
800:             .FontBold  = .T.
801:             .ForeColor = RGB(90, 90, 90)
802:             .BackStyle = 0
803:             .AutoSize  = .F.
804:             .Visible   = .T.
805:         ENDWITH
806: 
807:         *-- Transporte (Dados) - lookup SigPrTrn.Codigos (F4/LostFocus)
808:         par_oPagina.AddObject("lbl_4c_TransporteDados", "Label")
809:         WITH par_oPagina.lbl_4c_TransporteDados
810:             .Caption   = "Transporte (Dados) :"
811:             .Top       = 157
812:             .Left      = 506
813:             .Width     = 120
814:             .Height    = 15
815:             .FontName  = "Tahoma"
816:             .FontSize  = 8
817:             .ForeColor = RGB(90, 90, 90)
818:             .BackStyle = 0
819:             .AutoSize  = .F.
820:             .Visible   = .T.

*-- Linhas 833 a 908:
833:             .Value     = ""
834:             .Visible   = .T.
835:         ENDWITH
836:         BINDEVENT(par_oPagina.txt_4c_TransTipo, "KeyPress", THIS, "TeclaTransTipo")
837:         BINDEVENT(par_oPagina.txt_4c_TransTipo, "KeyPress", THIS, "ValidarTransTipo")
838: 
839:         *-- Transporte - diretorio de geracao/gravacao (drivets)
840:         par_oPagina.AddObject("lbl_4c_Transporte", "Label")
841:         WITH par_oPagina.lbl_4c_Transporte
842:             .Caption   = "Transporte :"
843:             .Top       = 183
844:             .Left      = 15
845:             .Width     = 62
846:             .Height    = 15
847:             .FontName  = "Tahoma"
848:             .FontSize  = 8
849:             .ForeColor = RGB(90, 90, 90)
850:             .BackStyle = 0
851:             .AutoSize  = .F.
852:             .Visible   = .T.
853:         ENDWITH
854: 
855:         par_oPagina.AddObject("txt_4c_DirGeracao", "TextBox")
856:         WITH par_oPagina.txt_4c_DirGeracao
857:             .Top       = 180
858:             .Left      = 79
859:             .Width     = 430
860:             .Height    = 23
861:             .FontName  = "Tahoma"
862:             .FontSize  = 8
863:             .ForeColor = RGB(0, 0, 0)
864:             .BackColor = RGB(255, 255, 255)
865:             .Value     = ""
866:             .Visible   = .T.
867:         ENDWITH
868:         BINDEVENT(par_oPagina.txt_4c_DirGeracao, "KeyPress", THIS, "ValidarDirGeracao")
869: 
870:         *-- No. Transporte Ok (clrarqs) - numerico
871:         par_oPagina.AddObject("lbl_4c_NoTransporteOk", "Label")
872:         WITH par_oPagina.lbl_4c_NoTransporteOk
873:             .Caption   = "No. Transporte Ok :"
874:             .Top       = 184
875:             .Left      = 555
876:             .Width     = 120
877:             .Height    = 15
878:             .FontName  = "Tahoma"
879:             .FontSize  = 8
880:             .ForeColor = RGB(90, 90, 90)
881:             .BackStyle = 0
882:             .AutoSize  = .F.
883:             .Visible   = .T.
884:         ENDWITH
885: 
886:         par_oPagina.AddObject("txt_4c_ClrArqOks", "TextBox")
887:         WITH par_oPagina.txt_4c_ClrArqOks
888:             .Top       = 180
889:             .Left      = 650
890:             .Width     = 31
891:             .Height    = 23
892:             .FontName  = "Tahoma"
893:             .FontSize  = 8
894:             .ForeColor = RGB(0, 0, 0)
895:             .BackColor = RGB(255, 255, 255)
896:             .InputMask = "999"
897:             .Value     = ""
898:             .Visible   = .T.
899:         ENDWITH
900: 
901:         *-- Leitura - diretorio de leitura do zip (drivels)
902:         par_oPagina.AddObject("lbl_4c_Leitura", "Label")
903:         WITH par_oPagina.lbl_4c_Leitura
904:             .Caption   = "Leitura :"
905:             .Top       = 205
906:             .Left      = 35
907:             .Width     = 42
908:             .Height    = 15

*-- Linhas 927 a 1048:
927:             .Value     = ""
928:             .Visible   = .T.
929:         ENDWITH
930:         BINDEVENT(par_oPagina.txt_4c_DirLeitura, "KeyPress", THIS, "ValidarDirLeitura")
931: 
932:         *-- Nao Checar Sequencia (nchkseqs)
933:         par_oPagina.AddObject("chk_4c_Seqnum", "CheckBox")
934:         WITH par_oPagina.chk_4c_Seqnum
935:             .Caption   = "N" + CHR(227) + "o Checar Sequ" + CHR(234) + "ncia "
936:             .Top       = 207
937:             .Left      = 531
938:             .Width     = 129
939:             .Height    = 15
940:             .FontName  = "Tahoma"
941:             .FontSize  = 8
942:             .ForeColor = RGB(90, 90, 90)
943:             .BackStyle = 0
944:             .Value     = 0
945:             .Visible   = .T.
946:         ENDWITH
947: 
948:         *-- Recepcao - diretorio de recepcao do transporte (drivers)
949:         par_oPagina.AddObject("lbl_4c_Recepcao", "Label")
950:         WITH par_oPagina.lbl_4c_Recepcao
951:             .Caption   = "Recep" + CHR(231) + CHR(227) + "o :"
952:             .Top       = 228
953:             .Left      = 21
954:             .Width     = 56
955:             .Height    = 15
956:             .FontName  = "Tahoma"
957:             .FontSize  = 8
958:             .ForeColor = RGB(90, 90, 90)
959:             .BackStyle = 0
960:             .AutoSize  = .F.
961:             .Visible   = .T.
962:         ENDWITH
963: 
964:         par_oPagina.AddObject("txt_4c_DirRecepcao", "TextBox")
965:         WITH par_oPagina.txt_4c_DirRecepcao
966:             .Top       = 225
967:             .Left      = 79
968:             .Width     = 430
969:             .Height    = 23
970:             .FontName  = "Tahoma"
971:             .FontSize  = 8
972:             .ForeColor = RGB(0, 0, 0)
973:             .BackColor = RGB(255, 255, 255)
974:             .Value     = ""
975:             .Visible   = .T.
976:         ENDWITH
977:         BINDEVENT(par_oPagina.txt_4c_DirRecepcao, "KeyPress", THIS, "ValidarDirRecepcao")
978: 
979:         *-- Arquivar - diretorio para arquivar arquivo recebido (paths, opcional)
980:         par_oPagina.AddObject("lbl_4c_Arquivar", "Label")
981:         WITH par_oPagina.lbl_4c_Arquivar
982:             .Caption   = "Arquivar :"
983:             .Top       = 252
984:             .Left      = 27
985:             .Width     = 50
986:             .Height    = 15
987:             .FontName  = "Tahoma"
988:             .FontSize  = 8
989:             .ForeColor = RGB(90, 90, 90)
990:             .BackStyle = 0
991:             .AutoSize  = .F.
992:             .Visible   = .T.
993:         ENDWITH
994: 
995:         par_oPagina.AddObject("txt_4c_DirArquivar", "TextBox")
996:         WITH par_oPagina.txt_4c_DirArquivar
997:             .Top       = 249
998:             .Left      = 79
999:             .Width     = 430
1000:             .Height    = 23
1001:             .FontName  = "Tahoma"
1002:             .FontSize  = 8
1003:             .ForeColor = RGB(0, 0, 0)
1004:             .BackColor = RGB(255, 255, 255)
1005:             .Value     = ""
1006:             .Visible   = .T.
1007:         ENDWITH
1008:         BINDEVENT(par_oPagina.txt_4c_DirArquivar, "KeyPress", THIS, "ValidarDirArquivar")
1009: 
1010:         *-- Caixa decorativa em torno de "Prox.Transp." e "Prox.Recebe" (Shape2 do legado)
1011:         par_oPagina.AddObject("shp_4c_CaixaProximos", "Shape")
1012:         WITH par_oPagina.shp_4c_CaixaProximos
1013:             .Top     = 230
1014:             .Left    = 516
1015:             .Width   = 172
1016:             .Height  = 48
1017:             .Visible = .T.
1018:         ENDWITH
1019: 
1020:         *-- Proximo Numero de Transporte (sem ControlSource no legado - campo
1021:         *-- desvinculado, nao gravado na tabela)
1022:         par_oPagina.AddObject("lbl_4c_ProxTransp", "Label")
1023:         WITH par_oPagina.lbl_4c_ProxTransp
1024:             .Caption   = "Pr" + CHR(243) + "x.Transp."
1025:             .Top       = 235
1026:             .Left      = 523
1027:             .Width     = 90
1028:             .Height    = 15
1029:             .FontName  = "Tahoma"
1030:             .FontSize  = 8
1031:             .ForeColor = RGB(90, 90, 90)
1032:             .BackStyle = 0
1033:             .AutoSize  = .F.
1034:             .Visible   = .T.
1035:         ENDWITH
1036: 
1037:         par_oPagina.AddObject("txt_4c_ProxTransp", "TextBox")
1038:         WITH par_oPagina.txt_4c_ProxTransp
1039:             .Top       = 250
1040:             .Left      = 529
1041:             .Width     = 58
1042:             .Height    = 23
1043:             .FontName  = "Tahoma"
1044:             .FontSize  = 8
1045:             .ForeColor = RGB(0, 0, 0)
1046:             .BackColor = RGB(255, 255, 255)
1047:             .InputMask = "999999"
1048:             .Value     = ""

*-- Linhas 1098 a 1141:
1098:     * endereco FTP, usuario, senha (+ redigita confirmacao), pasta de envio,
1099:     * pasta de recepcao.
1100:     *===========================================================================
1101:     PROTECTED PROCEDURE AdicionarCamposFtp(par_oPagina)
1102:         *-- Titulo da secao (Say12 do legado)
1103:         par_oPagina.AddObject("lbl_4c_SecaoFtp", "Label")
1104:         WITH par_oPagina.lbl_4c_SecaoFtp
1105:             .Caption   = " Configura" + CHR(231) + CHR(227) + "o da " + CHR(225) + "rea do FTP "
1106:             .Top       = 288
1107:             .Left      = 5
1108:             .Width     = 194
1109:             .Height    = 18
1110:             .FontName  = "Tahoma"
1111:             .FontSize  = 8
1112:             .FontBold  = .T.
1113:             .ForeColor = RGB(90, 90, 90)
1114:             .BackStyle = 0
1115:             .AutoSize  = .F.
1116:             .Visible   = .T.
1117:         ENDWITH
1118: 
1119:         *-- Tipo de Conexao (tpconexao) - D=Dial-Up / B=Banda Larga
1120:         par_oPagina.AddObject("lbl_4c_TipoConexao", "Label")
1121:         WITH par_oPagina.lbl_4c_TipoConexao
1122:             .Caption   = "Tipo de Conex" + CHR(227) + "o :"
1123:             .Top       = 314
1124:             .Left      = 27
1125:             .Width     = 90
1126:             .Height    = 15
1127:             .FontName  = "Tahoma"
1128:             .FontSize  = 8
1129:             .ForeColor = RGB(90, 90, 90)
1130:             .BackStyle = 0
1131:             .AutoSize  = .F.
1132:             .Visible   = .T.
1133:         ENDWITH
1134: 
1135:         par_oPagina.AddObject("txt_4c_Tpconexao", "TextBox")
1136:         WITH par_oPagina.txt_4c_Tpconexao
1137:             .Top       = 310
1138:             .Left      = 122
1139:             .Width     = 28
1140:             .Height    = 23
1141:             .FontName  = "Tahoma"

*-- Linhas 1299 a 1342:
1299:             .Value        = ""
1300:             .Visible      = .T.
1301:         ENDWITH
1302:         BINDEVENT(par_oPagina.txt_4c_Ftpsenha, "KeyPress", THIS, "ValidarFtpSenha")
1303: 
1304:         par_oPagina.AddObject("lbl_4c_Senha", "Label")
1305:         WITH par_oPagina.lbl_4c_Senha
1306:             .Caption   = "Senha :"
1307:             .Top       = 359
1308:             .Left      = 483
1309:             .Width     = 39
1310:             .Height    = 15
1311:             .FontName  = "Tahoma"
1312:             .FontSize  = 8
1313:             .ForeColor = RGB(90, 90, 90)
1314:             .BackStyle = 0
1315:             .AutoSize  = .F.
1316:             .Visible   = .T.
1317:         ENDWITH
1318: 
1319:         *-- Pasta p/Recepcao (dirftpls)
1320:         par_oPagina.AddObject("txt_4c_Dirftpls", "TextBox")
1321:         WITH par_oPagina.txt_4c_Dirftpls
1322:             .Top       = 379
1323:             .Left      = 122
1324:             .Width     = 330
1325:             .Height    = 23
1326:             .FontName  = "Tahoma"
1327:             .FontSize  = 8
1328:             .ForeColor = RGB(0, 0, 0)
1329:             .BackColor = RGB(255, 255, 255)
1330:             .Value     = ""
1331:             .Visible   = .T.
1332:         ENDWITH
1333: 
1334:         par_oPagina.AddObject("lbl_4c_PastaRecepcao", "Label")
1335:         WITH par_oPagina.lbl_4c_PastaRecepcao
1336:             .Caption   = "Pasta p/Recep" + CHR(231) + CHR(227) + "o :"
1337:             .Top       = 381
1338:             .Left      = 21
1339:             .Width     = 96
1340:             .Height    = 15
1341:             .FontName  = "Tahoma"
1342:             .FontSize  = 8

*-- Linhas 1362 a 1496:
1362:             .Value        = ""
1363:             .Visible      = .T.
1364:         ENDWITH
1365:         BINDEVENT(par_oPagina.txt_4c_Senha2, "KeyPress", THIS, "ValidarSenha2")
1366: 
1367:         par_oPagina.AddObject("lbl_4c_Redigita", "Label")
1368:         WITH par_oPagina.lbl_4c_Redigita
1369:             .Caption   = "Redigita :"
1370:             .Top       = 382
1371:             .Left      = 474
1372:             .Width     = 48
1373:             .Height    = 15
1374:             .FontName  = "Tahoma"
1375:             .FontSize  = 8
1376:             .ForeColor = RGB(90, 90, 90)
1377:             .BackStyle = 0
1378:             .AutoSize  = .F.
1379:             .Visible   = .T.
1380:         ENDWITH
1381: 
1382:         *-- Divisor de fechamento da caixa "Configuracao da area do FTP" (Shape4 do legado)
1383:         par_oPagina.AddObject("shp_4c_DivisorFtpFim", "Shape")
1384:         WITH par_oPagina.shp_4c_DivisorFtpFim
1385:             .Top     = 409
1386:             .Left    = 4
1387:             .Width   = 690
1388:             .Height  = 2
1389:             .Visible = .T.
1390:         ENDWITH
1391:     ENDPROC
1392: 
1393:     *===========================================================================
1394:     * ConfigurarPgPage1 - pgf_4c_DadosInternos.Page2 (legado Pageframe1.Page2.
1395:     * Configuracao.Page1 "Operacoes de Estoque"): grid grd_4c_Grade (11
1396:     * colunas, cursor_4c_Grade = csGrade legado) + 14 labels de legenda S/N/T
1397:     * abaixo da grade. fAcessoEmpresa()/fAcessoMovmto()/fAcessoContas() NAO
1398:     * foram portadas (memoria do projeto) - colunas Emp/Empds/Operacao
1399:     * Destino/Local Entrega ficam como campos simples, sem lookup.
1400:     *===========================================================================
1401:     PROTECTED PROCEDURE ConfigurarPgPage1()
1402:         LOCAL loc_oPgN, loc_nCol
1403: 
1404:         IF !USED("cursor_4c_Grade")
1405:             CREATE CURSOR cursor_4c_Grade (tipoemps C(9), emps C(3), dopes C(20), ;
1406:                 cidchaves C(20), chkpagos C(1), chksubns C(1), empds C(3), ;
1407:                 dopeds C(20), contaes C(10), apagas C(1), ndias N(2), ;
1408:                 numeras C(1), dttrans C(1))
1409:         ENDIF
1410: 
1411:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2
1412: 
1413:         *-- Grid de operacoes (csGrade no legado)
1414:         loc_oPgN.AddObject("grd_4c_Grade", "Grid")
1415:         loc_oPgN.grd_4c_Grade.ColumnCount  = 11
1416:         loc_oPgN.grd_4c_Grade.RecordSource = "cursor_4c_Grade"
1417:         WITH loc_oPgN.grd_4c_Grade
1418:             .Top               = 1
1419:             .Left              = 55
1420:             .Width             = 595
1421:             .Height            = 241
1422:             .FontName          = "Tahoma"
1423:             .FontSize          = 8
1424:             .AllowHeaderSizing = .F.
1425:             .AllowRowSizing    = .F.
1426:             .DeleteMark        = .F.
1427:             .RecordMark        = .F.
1428:             .HeaderHeight      = 16
1429:             .RowHeight         = 16
1430:             .ScrollBars        = 2
1431:             .GridLineColor     = RGB(238, 238, 238)
1432:             .Visible           = .T.
1433: 
1434:             .Column1.ControlSource = "cursor_4c_Grade.emps"
1435:             .Column1.Width         = 34
1436:             .Column1.Movable       = .F.
1437:             .Column1.Resizable     = .F.
1438: 
1439:             .Column2.ControlSource = "cursor_4c_Grade.dopes"
1440:             .Column2.Width         = 148
1441:             .Column2.Movable       = .F.
1442:             .Column2.Resizable     = .F.
1443: 
1444:             .Column3.ControlSource = "cursor_4c_Grade.chkpagos"
1445:             .Column3.Width         = 17
1446:             .Column3.ColumnOrder   = 4
1447:             .Column3.Movable       = .F.
1448:             .Column3.Resizable     = .F.
1449: 
1450:             .Column4.ControlSource = "cursor_4c_Grade.chksubns"
1451:             .Column4.Width         = 17
1452:             .Column4.ColumnOrder   = 5
1453:             .Column4.Movable       = .F.
1454:             .Column4.Resizable     = .F.
1455: 
1456:             .Column5.ControlSource = "cursor_4c_Grade.empds"
1457:             .Column5.Width         = 31
1458:             .Column5.ColumnOrder   = 3
1459:             .Column5.Movable       = .F.
1460:             .Column5.Resizable     = .F.
1461: 
1462:             .Column6.ControlSource = "cursor_4c_Grade.dopeds"
1463:             .Column6.Width         = 140
1464:             .Column6.Movable       = .F.
1465:             .Column6.Resizable     = .F.
1466: 
1467:             .Column7.ControlSource = "cursor_4c_Grade.contaes"
1468:             .Column7.Width         = 78
1469:             .Column7.Movable       = .F.
1470:             .Column7.Resizable     = .F.
1471: 
1472:             .Column8.ControlSource = "cursor_4c_Grade.apagas"
1473:             .Column8.Width         = 27
1474: 
1475:             .Column9.ControlSource = "cursor_4c_Grade.ndias"
1476:             .Column9.Width         = 24
1477: 
1478:             .Column10.ControlSource = "cursor_4c_Grade.numeras"
1479:             .Column10.Width         = 27
1480: 
1481:             .Column11.ControlSource = "cursor_4c_Grade.dttrans"
1482:             .Column11.Width         = 20
1483:             .Column11.Movable       = .F.
1484:             .Column11.Resizable     = .F.
1485:             .Column11.ForeColor     = RGB(0, 0, 0)
1486: 
1487:             *-- Headers (OBRIGATORIO apos RecordSource/ControlSource)
1488:             .Column1.Header1.Caption  = "Emp"
1489:             .Column2.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
1490:             .Column3.Header1.Caption  = "Pg"
1491:             .Column4.Header1.Caption  = "Bx"
1492:             .Column5.Header1.Caption  = "Empds"
1493:             .Column6.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o Destino"
1494:             .Column7.Header1.Caption  = "Local Entrega"
1495:             .Column8.Header1.Caption  = "Del"
1496:             .Column9.Header1.Caption  = "DD"

*-- Linhas 1528 a 1577:
1528: 
1529:         *-- Validacoes (LostFocus - fAcessoEmpresa/fAcessoMovmto/fAcessoContas
1530:         *-- NAO foram portadas: colunas 1/5/6/7 ficam sem lookup, campo simples)
1531:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column2.Text1,  "KeyPress", THIS, "ValidarGradeOperacao")
1532:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column3.Text1,  "KeyPress", THIS, "ValidarGradeSNT3")
1533:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column4.Text1,  "KeyPress", THIS, "ValidarGradeSNT4")
1534:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column7.Text1,  "KeyPress", THIS, "ValidarGradeLocalEntrega")
1535:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column8.Text1,  "KeyPress", THIS, "ValidarGradeApagas")
1536:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column10.Text1, "KeyPress", THIS, "ValidarGradeNumeras")
1537:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column11.Text1, "KeyPress", THIS, "ValidarGradeDtTrans")
1538: 
1539:         *-- Legenda [S]im/[N]ao/[T]odos - Pg/Bx (Label1..Label10 do legado)
1540:         loc_oPgN.AddObject("lbl_4c_LegendaPg", "Label")
1541:         WITH loc_oPgN.lbl_4c_LegendaPg
1542:             .Caption   = "[    ]im / [    ]ao / [    ]odos"
1543:             .Top       = 247
1544:             .Left      = 69
1545:             .Width     = 137
1546:             .Height    = 13
1547:             .FontName  = "Tahoma"
1548:             .FontSize  = 7
1549:             .FontBold  = .T.
1550:             .ForeColor = RGB(90, 90, 90)
1551:             .BackStyle = 0
1552:             .AutoSize  = .T.
1553:             .Visible   = .T.
1554:         ENDWITH
1555: 
1556:         loc_oPgN.AddObject("lbl_4c_LegendaBx", "Label")
1557:         WITH loc_oPgN.lbl_4c_LegendaBx
1558:             .Caption   = "[    ]im / [    ]ao / [    ]odos"
1559:             .Top       = 247
1560:             .Left      = 318
1561:             .Width     = 137
1562:             .Height    = 13
1563:             .FontName  = "Tahoma"
1564:             .FontSize  = 7
1565:             .FontBold  = .T.
1566:             .ForeColor = RGB(90, 90, 90)
1567:             .BackStyle = 0
1568:             .AutoSize  = .T.
1569:             .Visible   = .T.
1570:         ENDWITH
1571: 
1572:         loc_oPgN.AddObject("lbl_4c_RotuloPg", "Label")
1573:         WITH loc_oPgN.lbl_4c_RotuloPg
1574:             .Caption   = "Pg(Pago) : "
1575:             .Top       = 247
1576:             .Left      = 12
1577:             .Width     = 59

*-- Linhas 1762 a 1952:
1762:             .Visible   = .T.
1763:         ENDWITH
1764: 
1765:         THIS.TornarControlesVisiveis(loc_oPgN)
1766:     ENDPROC
1767: 
1768:     *===========================================================================
1769:     * ValidarGradeOperacao - LostFocus da coluna "Opera" + CHR(231)+CHR(227) +
1770:     * "o" (Dopes) do grid de opera" + CHR(231) + CHR(245) + "es. Reproduz o
1771:     * aviso do Valid legado: PAGAMENTO/RECEBIMENTO devem ser informados na
1772:     * aba "Titulos/Pag/Rec/Lote Chq", nao aqui. fAcessoMovmto() NAO foi
1773:     * portada - sem lookup, apenas o aviso.
1774:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1775:     *===========================================================================
1776:     PROCEDURE ValidarGradeOperacao()
1777:         LOCAL loc_oGrid, loc_cValor
1778:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade
1779:         loc_cValor = ALLTRIM(UPPER(loc_oGrid.Column2.Text1.Value))
1780: 
1781:         IF INLIST(loc_cValor, "PAGAMENTO", "RECEBIMENTO")
1782:             MsgAviso('Favor informar as opera' + CHR(231) + CHR(245) + 'es de PAGAMENTO/RECEBIMENTO na Aba "Titulos/Pag/Rec/Lote Chq"', ;
1783:                 "Aten" + CHR(231) + CHR(227) + "o")
1784:             loc_oGrid.Column2.Text1.Value = ""
1785:         ENDIF
1786:     ENDPROC
1787: 
1788:     *===========================================================================
1789:     * ValidarGradeSNT3/ValidarGradeSNT4 - LostFocus das colunas "Pg"/"Bx"
1790:     * (S/N/T) do grid de opera" + CHR(231) + CHR(245) + "es
1791:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1792:     *===========================================================================
1793:     PROCEDURE ValidarGradeSNT3()
1794:         LOCAL loc_oText
1795:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column3.Text1
1796:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N", "T")
1797:             MsgAviso("Informe [S]im / [N]ao / [T]odos")
1798:         ENDIF
1799:     ENDPROC
1800: 
1801:     PROCEDURE ValidarGradeSNT4()
1802:         LOCAL loc_oText
1803:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column4.Text1
1804:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N", "T")
1805:             MsgAviso("Informe [S]im / [N]ao / [T]odos")
1806:         ENDIF
1807:     ENDPROC
1808: 
1809:     *===========================================================================
1810:     * ValidarGradeLocalEntrega - LostFocus da coluna "Local Entrega" (ContaEs).
1811:     * fAcessoContas() NAO foi portada (memoria do projeto: lookup UX proibido
1812:     * quando a funcao nao existe de fato) - campo simples. Reproduz apenas o
1813:     * retorno de foco do legado para a coluna 1.
1814:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1815:     *===========================================================================
1816:     PROCEDURE ValidarGradeLocalEntrega()
1817:         THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column1.SetFocus()
1818:     ENDPROC
1819: 
1820:     *===========================================================================
1821:     * ValidarGradeApagas - LostFocus da coluna "Del" (S/N). Se [S], confirma a
1822:     * delecao dos dados apos a geracao do transporte; se recusado, limpa o
1823:     * valor (adaptacao do Valid legado - Return .f. mantinha o foco na
1824:     * celula, o que nao se aplica a um handler de LostFocus).
1825:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1826:     *===========================================================================
1827:     PROCEDURE ValidarGradeApagas()
1828:         LOCAL loc_oText
1829:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column8.Text1
1830: 
1831:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N")
1832:             MsgAviso("Informe [S]im / [N]ao / [ ]")
1833:         ELSE
1834:             IF UPPER(loc_oText.Value) == "S"
1835:                 IF !MsgConfirma("Confirma Dele" + CHR(231) + CHR(227) + "o dos Dados ap" + CHR(243) + "s a gera" + CHR(231) + CHR(227) + "o do Transporte?")
1836:                     loc_oText.Value = ""
1837:                 ENDIF
1838:             ENDIF
1839:         ENDIF
1840:     ENDPROC
1841: 
1842:     *===========================================================================
1843:     * ValidarGradeNumeras - LostFocus da coluna "NN" (troca numeracao, S/N).
1844:     * Se [S], confirma a troca de numeracao na recepcao dos dados; se
1845:     * recusado, limpa o valor (mesma adaptacao de ValidarGradeApagas).
1846:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1847:     *===========================================================================
1848:     PROCEDURE ValidarGradeNumeras()
1849:         LOCAL loc_oText
1850:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column10.Text1
1851: 
1852:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N")
1853:             MsgAviso("Informe [S]im / [N]ao / [ ]")
1854:         ELSE
1855:             IF UPPER(loc_oText.Value) == "S"
1856:                 IF !MsgConfirma("Confirma Troca da Numera" + CHR(231) + CHR(227) + "o desta Opera" + CHR(231) + CHR(227) + "o Na Recep" + CHR(231) + CHR(227) + "o dos Dados ?")
1857:                     loc_oText.Value = ""
1858:                 ENDIF
1859:             ENDIF
1860:         ENDIF
1861:     ENDPROC
1862: 
1863:     *===========================================================================
1864:     * ValidarGradeDtTrans - LostFocus da coluna "DT" (S/N). Se [S], confirma o
1865:     * envio da movimentacao com a data de transporte ja preenchida na
1866:     * recepcao dos dados; se recusado, limpa o valor (mesma adaptacao de
1867:     * ValidarGradeApagas).
1868:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1869:     *===========================================================================
1870:     PROCEDURE ValidarGradeDtTrans()
1871:         LOCAL loc_oText
1872:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column11.Text1
1873: 
1874:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N")
1875:             MsgAviso("Informe [S]im / [N]ao / [ ]")
1876:         ELSE
1877:             IF UPPER(loc_oText.Value) == "S"
1878:                 IF !MsgConfirma("Confirma Enviar a Movimenta" + CHR(231) + CHR(227) + "o com a Data de Transporte j" + CHR(225) + " Preenchida na Opera" + CHR(231) + CHR(227) + "o Na Recep" + CHR(231) + CHR(227) + "o dos Dados ?")
1879:                     loc_oText.Value = ""
1880:                 ENDIF
1881:             ENDIF
1882:         ENDIF
1883:     ENDPROC
1884: 
1885:     *===========================================================================
1886:     * ConfigurarPgPage2 - pgf_4c_DadosInternos.Page1 (legado Pageframe1.Page2.
1887:     * Configuracao.Page2 "Titulos/Pag/Rec/Lote Chq"): grid grd_4c_Titulos (3
1888:     * colunas, cursor_4c_Titulos = CsTitulo legado - mesmo cursor que
1889:     * TmeBO.this_cCursorTitulos/BuscarTitulos ja usam) + 4 labels de legenda
1890:     * S/N/A abaixo da grade. Coluna 1 (Emp): fAcessoEmpresa() NAO foi portada
1891:     * (memoria do projeto) - fica como campo simples, sem lookup. Coluna 2
1892:     * (Opera" + CHR(231) + CHR(227) + "o): fwBuscaSel legado -> equivalente
1893:     * moderno FormBuscaAuxiliar (Modo 2, cursor local cursor_4c_Operacoes
1894:     * montado por TmeBO.BuscarOperacoesDisponiveis).
1895:     *===========================================================================
1896:     PROTECTED PROCEDURE ConfigurarPgPage2()
1897:         LOCAL loc_oPgN, loc_nCol
1898: 
1899:         IF !USED("cursor_4c_Titulos")
1900:             CREATE CURSOR cursor_4c_Titulos (tipoemps C(9), emps C(3), dopes C(20), ;
1901:                 cidchaves C(20), cnotas C(1), empds C(3))
1902:         ENDIF
1903: 
1904:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
1905: 
1906:         *-- Grid de titulos/pagamentos/recebimentos/lote de cheque (CsTitulo no legado)
1907:         loc_oPgN.AddObject("grd_4c_Titulos", "Grid")
1908:         loc_oPgN.grd_4c_Titulos.ColumnCount  = 3
1909:         loc_oPgN.grd_4c_Titulos.RecordSource = "cursor_4c_Titulos"
1910:         WITH loc_oPgN.grd_4c_Titulos
1911:             .Top               = 1
1912:             .Left              = 222
1913:             .Width             = 260
1914:             .Height            = 242
1915:             .FontName          = "Tahoma"
1916:             .FontSize          = 8
1917:             .AllowHeaderSizing = .F.
1918:             .AllowRowSizing    = .F.
1919:             .DeleteMark        = .F.
1920:             .RecordMark        = .F.
1921:             .HeaderHeight      = 16
1922:             .RowHeight         = 16
1923:             .ScrollBars        = 2
1924:             .GridLineColor     = RGB(238, 238, 238)
1925:             .Visible           = .T.
1926: 
1927:             .Column1.ControlSource = "cursor_4c_Titulos.emps"
1928:             .Column1.Width         = 40
1929:             .Column1.Movable       = .F.
1930:             .Column1.Resizable     = .F.
1931: 
1932:             .Column2.ControlSource = "cursor_4c_Titulos.dopes"
1933:             .Column2.Width         = 150
1934:             .Column2.Movable       = .F.
1935:             .Column2.Resizable     = .F.
1936: 
1937:             .Column3.ControlSource = "cursor_4c_Titulos.cnotas"
1938:             .Column3.Width         = 38
1939:             .Column3.Movable       = .F.
1940:             .Column3.Resizable     = .F.
1941: 
1942:             *-- Headers (OBRIGATORIO apos RecordSource/ControlSource)
1943:             .Column1.Header1.Caption = "Emp"
1944:             .Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1945:             .Column3.Header1.Caption = "S/N/A"
1946:         ENDWITH
1947: 
1948:         *-- Text1 de cada coluna: fonte/alinhamento/sem borda (padrao legado)
1949:         FOR loc_nCol = 1 TO 3
1950:             WITH loc_oPgN.grd_4c_Titulos.Columns(loc_nCol).Text1
1951:                 .FontName    = "Tahoma"
1952:                 .FontSize    = 8

*-- Linhas 1964 a 2008:
1964: 
1965:         *-- Validacoes (LostFocus - fAcessoEmpresa NAO foi portada: coluna 1
1966:         *-- fica sem lookup, campo simples)
1967:         BINDEVENT(loc_oPgN.grd_4c_Titulos.Column2.Text1, "KeyPress", THIS, "ValidarGradeTituloOperacao")
1968:         BINDEVENT(loc_oPgN.grd_4c_Titulos.Column3.Text1, "KeyPress", THIS, "ValidarGradeTituloSNA")
1969: 
1970:         *-- Legenda [S]im/[N]ao/[A]mbos (Label1/5/7/9 do legado)
1971:         loc_oPgN.AddObject("lbl_4c_LegendaSNA", "Label")
1972:         WITH loc_oPgN.lbl_4c_LegendaSNA
1973:             .Caption   = "[ S ]im / [ N ]ao / [ A ]mbos"
1974:             .Top       = 248
1975:             .Left      = 270
1976:             .Width     = 155
1977:             .Height    = 15
1978:             .FontName  = "Tahoma"
1979:             .FontSize  = 8
1980:             .FontBold  = .T.
1981:             .ForeColor = RGB(90, 90, 90)
1982:             .BackStyle = 0
1983:             .AutoSize  = .T.
1984:             .Visible   = .T.
1985:         ENDWITH
1986: 
1987:         loc_oPgN.AddObject("lbl_4c_SnaS", "Label")
1988:         WITH loc_oPgN.lbl_4c_SnaS
1989:             .Caption   = "S"
1990:             .Top       = 247
1991:             .Left      = 278
1992:             .Width     = 10
1993:             .Height    = 16
1994:             .FontName  = "Tahoma"
1995:             .FontSize  = 8
1996:             .FontBold  = .T.
1997:             .ForeColor = RGB(90, 90, 90)
1998:             .BackStyle = 0
1999:             .AutoSize  = .T.
2000:             .Visible   = .T.
2001:         ENDWITH
2002: 
2003:         loc_oPgN.AddObject("lbl_4c_SnaN", "Label")
2004:         WITH loc_oPgN.lbl_4c_SnaN
2005:             .Caption   = "N"
2006:             .Top       = 247
2007:             .Left      = 326
2008:             .Width     = 10

*-- Linhas 2032 a 2788:
2032:             .Visible   = .T.
2033:         ENDWITH
2034: 
2035:         THIS.TornarControlesVisiveis(loc_oPgN)
2036:     ENDPROC
2037: 
2038:     *===========================================================================
2039:     * ValidarGradeTituloOperacao - LostFocus da coluna "Opera" + CHR(231) +
2040:     * CHR(227) + "o" (Dopes) do grid de t" + CHR(237) + "tulos. Reproduz o
2041:     * Valid legado: se o valor nao existir em SigOpOpe nem for uma das
2042:     * operacoes especiais fixas (PAGAMENTO/RECEBIMENTO/LOTE DE CHEQUE), abre
2043:     * FormBuscaAuxiliar (equivalente ao fwBuscaSel legado sobre CrSigOpOpe)
2044:     * para selecao; ao selecionar, marca cnotas = "A" (Replace ... With 'A'
2045:     * in CsTitulo do legado).
2046:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2047:     *===========================================================================
2048:     PROCEDURE ValidarGradeTituloOperacao()
2049:         LOCAL loc_oGrid, loc_cValor, loc_oBusca
2050: 
2051:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1.grd_4c_Titulos
2052:         loc_cValor = ALLTRIM(UPPER(loc_oGrid.Column2.Text1.Value))
2053: 
2054:         IF EMPTY(loc_cValor)
2055:             RETURN
2056:         ENDIF
2057: 
2058:         IF !THIS.this_oBusinessObject.BuscarOperacoesDisponiveis()
2059:             RETURN
2060:         ENDIF
2061: 
2062:         IF USED("cursor_4c_Operacoes")
2063:             IF !SEEK(loc_cValor, "cursor_4c_Operacoes", "dopes")
2064:                 TRY
2065:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2066:                     IF VARTYPE(loc_oBusca) = "O"
2067:                         loc_oBusca.this_cCursorDestino = "cursor_4c_Operacoes"
2068:                         loc_oBusca.this_cTitulo        = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos"
2069:                         loc_oBusca.mAddColuna("dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
2070:                         loc_oBusca.Show()
2071: 
2072:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Operacoes")
2073:                             loc_oGrid.Column2.Text1.Value = ALLTRIM(cursor_4c_Operacoes.dopes)
2074:                             IF USED("cursor_4c_Titulos")
2075:                                 REPLACE cnotas WITH "A" IN cursor_4c_Titulos
2076:                             ENDIF
2077:                         ENDIF
2078:                         loc_oBusca.Release()
2079:                     ENDIF
2080:                 CATCH TO loException
2081:                     MsgErro(loException.Message, "FormTme.ValidarGradeTituloOperacao")
2082:                 ENDTRY
2083:             ENDIF
2084:             USE IN cursor_4c_Operacoes
2085:         ENDIF
2086:     ENDPROC
2087: 
2088:     *===========================================================================
2089:     * ValidarGradeTituloSNA - LostFocus da coluna "S/N/A" do grid de titulos
2090:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2091:     *===========================================================================
2092:     PROCEDURE ValidarGradeTituloSNA()
2093:         LOCAL loc_oText
2094:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1.grd_4c_Titulos.Column3.Text1
2095: 
2096:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N", "A")
2097:             MsgAviso("Informe [S]sim / [N]ao / [A]mbos")
2098:         ENDIF
2099:     ENDPROC
2100: 
2101:     *===========================================================================
2102:     * TeclaTransTipo - KeyPress (F4) para txt_4c_TransTipo
2103:     * PUBLIC + LPARAMETERS obrigatorios (BINDEVENT so funciona com metodo
2104:     * PUBLIC; KeyPress sempre passa 2 parametros - CLAUDE.md regras #2/#38)
2105:     *===========================================================================
2106:     PROCEDURE TeclaTransTipo(par_nKeyCode, par_nShiftAltCtrl)
2107:         IF par_nKeyCode = 63
2108:             THIS.AbrirBuscaTransTipo(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_TransTipo.Value))
2109:         ENDIF
2110:     ENDPROC
2111: 
2112:     *===========================================================================
2113:     * ValidarTransTipo - LostFocus para txt_4c_TransTipo (mesma logica do
2114:     * Valid legado: se preenchido, busca/valida em SigPrTrn). Guard evita
2115:     * reabrir o lookup quando o valor nao mudou desde a ultima validacao.
2116:     *===========================================================================
2117:     PROCEDURE ValidarTransTipo()
2118:         LOCAL loc_cValor
2119:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_TransTipo.Value)
2120: 
2121:         IF loc_cValor == THIS.this_cUltimoTransTipo
2122:             RETURN
2123:         ENDIF
2124:         THIS.this_cUltimoTransTipo = loc_cValor
2125: 
2126:         IF !EMPTY(loc_cValor)
2127:             THIS.AbrirBuscaTransTipo(loc_cValor)
2128:         ENDIF
2129:     ENDPROC
2130: 
2131:     *===========================================================================
2132:     * AbrirBuscaTransTipo - FormBuscaAuxiliar sobre SigPrTrn (Codigos/Descrs)
2133:     *===========================================================================
2134:     PROCEDURE AbrirBuscaTransTipo(par_cValor)
2135:         LOCAL loc_oBusca, loc_oPg2
2136: 
2137:         TRY
2138:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2139: 
2140:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2141:                 "SigPrTrn", "cursor_4c_BuscaTransTipo", "Codigos", par_cValor, ;
2142:                 "Tipo de Transporte")
2143: 
2144:             IF VARTYPE(loc_oBusca) = "O"
2145:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2146:                     IF USED("cursor_4c_BuscaTransTipo")
2147:                         loc_oPg2.txt_4c_TransTipo.Value = ALLTRIM(cursor_4c_BuscaTransTipo.Codigos)
2148:                     ENDIF
2149:                 ELSE
2150:                     IF !loc_oBusca.this_lAchouRegistro
2151:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2152:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2153:                         loc_oBusca.Show()
2154:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTransTipo")
2155:                             loc_oPg2.txt_4c_TransTipo.Value = ALLTRIM(cursor_4c_BuscaTransTipo.Codigos)
2156:                         ELSE
2157:                             loc_oPg2.txt_4c_TransTipo.Value = ""
2158:                         ENDIF
2159:                     ENDIF
2160:                 ENDIF
2161:                 THIS.this_cUltimoTransTipo = ALLTRIM(loc_oPg2.txt_4c_TransTipo.Value)
2162:                 loc_oBusca.Release()
2163:             ENDIF
2164: 
2165:         CATCH TO loException
2166:             MsgErro(loException.Message, "FormTme.AbrirBuscaTransTipo")
2167:         ENDTRY
2168: 
2169:         IF USED("cursor_4c_BuscaTransTipo")
2170:             USE IN cursor_4c_BuscaTransTipo
2171:         ENDIF
2172:     ENDPROC
2173: 
2174:     *===========================================================================
2175:     * ValidarDirGeracao/ValidarDirLeitura/ValidarDirRecepcao/ValidarDirArquivar
2176:     * LostFocus - reproduz o Valid legado: se o diretorio nao existe, oferece
2177:     * GETDIR() para selecao; se confirmado invalido, avisa e limpa o campo.
2178:     * Se existe, normaliza (UPPER + barra final). Guard evita repetir o
2179:     * GETDIR quando o valor nao mudou desde a ultima validacao (Problema 45).
2180:     * Arquivar aceita vazio (campo opcional no legado).
2181:     *===========================================================================
2182:     PROCEDURE ValidarDirGeracao()
2183:         LOCAL loc_cValor
2184:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirGeracao.Value)
2185: 
2186:         IF loc_cValor == THIS.this_cUltimoDirGeracao
2187:             RETURN
2188:         ENDIF
2189: 
2190:         IF !DIRECTORY(loc_cValor)
2191:             loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio Grava" + CHR(231) + CHR(227) + "o do Transporte")
2192:             IF !DIRECTORY(loc_cValor)
2193:                 MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
2194:                 loc_cValor = ""
2195:             ENDIF
2196:         ELSE
2197:             loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
2198:         ENDIF
2199: 
2200:         THIS.this_cUltimoDirGeracao = loc_cValor
2201:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirGeracao.Value = loc_cValor
2202:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirGeracao.Refresh()
2203:     ENDPROC
2204: 
2205:     PROCEDURE ValidarDirLeitura()
2206:         LOCAL loc_cValor
2207:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirLeitura.Value)
2208: 
2209:         IF loc_cValor == THIS.this_cUltimoDirLeitura
2210:             RETURN
2211:         ENDIF
2212: 
2213:         IF !DIRECTORY(loc_cValor)
2214:             loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio Leitura do Zip")
2215:             IF !DIRECTORY(loc_cValor)
2216:                 MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
2217:                 loc_cValor = ""
2218:             ENDIF
2219:         ELSE
2220:             loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
2221:         ENDIF
2222: 
2223:         THIS.this_cUltimoDirLeitura = loc_cValor
2224:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirLeitura.Value = loc_cValor
2225:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirLeitura.Refresh()
2226:     ENDPROC
2227: 
2228:     PROCEDURE ValidarDirRecepcao()
2229:         LOCAL loc_cValor
2230:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirRecepcao.Value)
2231: 
2232:         IF loc_cValor == THIS.this_cUltimoDirRecepcao
2233:             RETURN
2234:         ENDIF
2235: 
2236:         IF !DIRECTORY(loc_cValor)
2237:             loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio Recep" + CHR(231) + CHR(227) + "o do Transporte")
2238:             IF !DIRECTORY(loc_cValor)
2239:                 MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
2240:                 loc_cValor = ""
2241:             ENDIF
2242:         ELSE
2243:             loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
2244:         ENDIF
2245: 
2246:         THIS.this_cUltimoDirRecepcao = loc_cValor
2247:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirRecepcao.Value = loc_cValor
2248:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirRecepcao.Refresh()
2249:     ENDPROC
2250: 
2251:     PROCEDURE ValidarDirArquivar()
2252:         LOCAL loc_cValor
2253:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirArquivar.Value)
2254: 
2255:         IF loc_cValor == THIS.this_cUltimoDirArquivar
2256:             RETURN
2257:         ENDIF
2258: 
2259:         IF !EMPTY(loc_cValor)
2260:             IF !DIRECTORY(loc_cValor)
2261:                 loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio para Arquivar o arquivo recebido")
2262:                 IF !DIRECTORY(loc_cValor)
2263:                     MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
2264:                     loc_cValor = ""
2265:                 ENDIF
2266:             ELSE
2267:                 loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
2268:             ENDIF
2269:         ENDIF
2270: 
2271:         THIS.this_cUltimoDirArquivar = loc_cValor
2272:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirArquivar.Value = loc_cValor
2273:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirArquivar.Refresh()
2274:     ENDPROC
2275: 
2276:     *===========================================================================
2277:     * ValidarFtpSenha - LostFocus para txt_4c_Ftpsenha. Reproduz o Valid
2278:     * legado: codifica o valor digitado usando fDecriptografar() (funcao do
2279:     * Framework legado que, apesar do nome, CODIFICA o valor para gravacao -
2280:     * ver comentario em pafBO.prg linha ~902).
2281:     *===========================================================================
2282:     PROCEDURE ValidarFtpSenha()
2283:         LOCAL loc_oPg2, loc_cValor
2284: 
2285:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2286:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
2287: 
2288:         IF !EMPTY(loc_cValor)
2289:             loc_oPg2.txt_4c_Ftpsenha.Value = fDecriptografar(loc_cValor)
2290:         ENDIF
2291:     ENDPROC
2292: 
2293:     *===========================================================================
2294:     * ValidarSenha2 - LostFocus para txt_4c_Senha2 (campo "Redigita"). Reproduz
2295:     * o Valid legado: compara a senha ja codificada de txt_4c_Ftpsenha com a
2296:     * codificacao do valor redigitado. Se nao conferir, pergunta se o usuario
2297:     * deseja continuar com a senha em branco:
2298:     *   - Confirmou (Sim): limpa AMBOS os campos (senha + redigita)
2299:     *   - Recusou (Nao): limpa apenas o campo de redigita
2300:     *===========================================================================
2301:     PROCEDURE ValidarSenha2()
2302:         LOCAL loc_oPg2, loc_cSenhaCodificada, loc_cRedigitaCodificada
2303: 
2304:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2305: 
2306:         IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value))
2307:             loc_cSenhaCodificada    = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
2308:             loc_cRedigitaCodificada = fDecriptografar(ALLTRIM(loc_oPg2.txt_4c_Senha2.Value))
2309: 
2310:             IF loc_cSenhaCodificada != loc_cRedigitaCodificada
2311:                 IF MsgConfirma("A Senha N" + CHR(227) + "o Confere!!! Deseja Continuar Com a Senha em Branco ?", ;
2312:                         "Erro na Confirma" + CHR(231) + CHR(227) + "o da Senha...")
2313:                     *-- Confirmou: limpa senha + redigita
2314:                     loc_oPg2.txt_4c_Ftpsenha.Value = ""
2315:                     loc_oPg2.txt_4c_Senha2.Value    = ""
2316:                 ELSE
2317:                     *-- Recusou: limpa apenas a redigita
2318:                     loc_oPg2.txt_4c_Senha2.Value = ""
2319:                 ENDIF
2320:             ENDIF
2321:         ENDIF
2322:     ENDPROC
2323: 
2324:     *===========================================================================
2325:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2326:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
2327:     *===========================================================================
2328:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2329:         LOCAL loc_nI, loc_oObjeto, loc_nP
2330: 
2331:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2332:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2333: 
2334:             IF VARTYPE(loc_oObjeto) = "O"
2335:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2336:                     loc_oObjeto.Visible = .T.
2337:                 ENDIF
2338: 
2339:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2340:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2341:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2342:                     ENDFOR
2343:                 ENDIF
2344: 
2345:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2346:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2347:                 ENDIF
2348:             ENDIF
2349:         ENDFOR
2350:     ENDPROC
2351: 
2352:     *===========================================================================
2353:     * BOParaForm - Transfere dados do BusinessObject para os controles da Page2
2354:     * Campos txt_4c_ProxTransp/txt_4c_ProxRecebe/txt_4c_Senha2 sao desvinculados
2355:     * (sem coluna na tabela) - sempre limpos ao carregar um registro.
2356:     *===========================================================================
2357:     PROTECTED PROCEDURE BOParaForm()
2358:         LOCAL loc_oPg2
2359:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2360: 
2361:         TRY
2362:             loc_oPg2.txt_4c_Tipos.Value       = THIS.this_oBusinessObject.this_cTipos
2363:             loc_oPg2.txt_4c_Emps.Value        = THIS.this_oBusinessObject.this_cEmps
2364:             loc_oPg2.txt_4c_Descrs.Value      = THIS.this_oBusinessObject.this_cDescricao
2365:             loc_oPg2.txt_4c_Extensao.Value    = THIS.this_oBusinessObject.this_cExtensao
2366:             loc_oPg2.txt_4c_TransTipo.Value   = THIS.this_oBusinessObject.this_cTipoTransporte
2367:             loc_oPg2.txt_4c_DirGeracao.Value  = THIS.this_oBusinessObject.this_cDirGeracao
2368:             loc_oPg2.txt_4c_ClrArqOks.Value   = TRANSFORM(THIS.this_oBusinessObject.this_nTransporteOk)
2369:             loc_oPg2.txt_4c_DirLeitura.Value  = THIS.this_oBusinessObject.this_cDirLeitura
2370:             loc_oPg2.chk_4c_Seqnum.Value      = THIS.this_oBusinessObject.this_lNaoChecarSequencia
2371:             loc_oPg2.txt_4c_DirRecepcao.Value = THIS.this_oBusinessObject.this_cDirRecepcao
2372:             loc_oPg2.txt_4c_DirArquivar.Value = THIS.this_oBusinessObject.this_cDirArquivar
2373:             loc_oPg2.txt_4c_Tpconexao.Value   = THIS.this_oBusinessObject.this_cTipoConexao
2374:             loc_oPg2.chk_4c_Chklocdel.Value   = THIS.this_oBusinessObject.this_lLimpaDirEnvio
2375:             loc_oPg2.chk_4c_Chkftpdel.Value   = THIS.this_oBusinessObject.this_lLimpaDirFtp
2376:             loc_oPg2.txt_4c_Ftpend.Value      = THIS.this_oBusinessObject.this_cFtpEndereco
2377:             loc_oPg2.txt_4c_Ftpusuario.Value  = THIS.this_oBusinessObject.this_cFtpUsuario
2378:             loc_oPg2.txt_4c_Dirftpts.Value    = THIS.this_oBusinessObject.this_cDirFtpEnvio
2379:             loc_oPg2.txt_4c_Ftpsenha.Value    = THIS.this_oBusinessObject.this_cFtpSenha
2380:             loc_oPg2.txt_4c_Dirftpls.Value    = THIS.this_oBusinessObject.this_cDirFtpRecepcao
2381: 
2382:             *-- Campos desvinculados (nao gravados na tabela)
2383:             loc_oPg2.txt_4c_ProxTransp.Value = ""
2384:             loc_oPg2.txt_4c_ProxRecebe.Value = ""
2385:             loc_oPg2.txt_4c_Senha2.Value     = ""
2386: 
2387:             *-- Sincroniza guardas anti-repeticao (Problema 45) com o valor carregado
2388:             THIS.this_cUltimoTransTipo   = ALLTRIM(loc_oPg2.txt_4c_TransTipo.Value)
2389:             THIS.this_cUltimoDirGeracao  = ALLTRIM(loc_oPg2.txt_4c_DirGeracao.Value)
2390:             THIS.this_cUltimoDirLeitura  = ALLTRIM(loc_oPg2.txt_4c_DirLeitura.Value)
2391:             THIS.this_cUltimoDirRecepcao = ALLTRIM(loc_oPg2.txt_4c_DirRecepcao.Value)
2392:             THIS.this_cUltimoDirArquivar = ALLTRIM(loc_oPg2.txt_4c_DirArquivar.Value)
2393:         CATCH TO loException
2394:             MostrarErro("Erro ao carregar dados no formul" + CHR(225) + "rio:" + CHR(13) + ;
2395:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
2396:                 "FormTme.BOParaForm")
2397:         ENDTRY
2398:     ENDPROC
2399: 
2400:     *===========================================================================
2401:     * LimparCampos - Limpa todos os controles da Page2 (usado em Incluir)
2402:     *===========================================================================
2403:     PROTECTED PROCEDURE LimparCampos()
2404:         LOCAL loc_oPg2
2405:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2406: 
2407:         TRY
2408:             loc_oPg2.txt_4c_Tipos.Value       = ""
2409:             loc_oPg2.txt_4c_Emps.Value        = ""
2410:             loc_oPg2.txt_4c_Descrs.Value      = ""
2411:             loc_oPg2.txt_4c_Extensao.Value    = ""
2412:             loc_oPg2.txt_4c_TransTipo.Value   = ""
2413:             loc_oPg2.txt_4c_DirGeracao.Value  = ""
2414:             loc_oPg2.txt_4c_ClrArqOks.Value   = ""
2415:             loc_oPg2.txt_4c_DirLeitura.Value  = ""
2416:             loc_oPg2.chk_4c_Seqnum.Value      = 0
2417:             loc_oPg2.txt_4c_DirRecepcao.Value = ""
2418:             loc_oPg2.txt_4c_DirArquivar.Value = ""
2419:             loc_oPg2.txt_4c_ProxTransp.Value  = ""
2420:             loc_oPg2.txt_4c_ProxRecebe.Value  = ""
2421:             loc_oPg2.txt_4c_Tpconexao.Value   = ""
2422:             loc_oPg2.chk_4c_Chklocdel.Value   = 0
2423:             loc_oPg2.chk_4c_Chkftpdel.Value   = 0
2424:             loc_oPg2.txt_4c_Ftpend.Value      = ""
2425:             loc_oPg2.txt_4c_Ftpusuario.Value  = ""
2426:             loc_oPg2.txt_4c_Dirftpts.Value    = ""
2427:             loc_oPg2.txt_4c_Ftpsenha.Value    = ""
2428:             loc_oPg2.txt_4c_Dirftpls.Value    = ""
2429:             loc_oPg2.txt_4c_Senha2.Value      = ""
2430: 
2431:             *-- Reseta guardas anti-repeticao (Problema 45)
2432:             THIS.this_cUltimoTransTipo   = ""
2433:             THIS.this_cUltimoDirGeracao  = ""
2434:             THIS.this_cUltimoDirLeitura  = ""
2435:             THIS.this_cUltimoDirRecepcao = ""
2436:             THIS.this_cUltimoDirArquivar = ""
2437:         CATCH TO loException
2438:             MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, ;
2439:                 "FormTme.LimparCampos")
2440:         ENDTRY
2441:     ENDPROC
2442: 
2443:     *===========================================================================
2444:     * HabilitarCampos - Habilita/desabilita os controles da Page2
2445:     * Tipos/Emps (chave) so ficam editaveis em modo INCLUIR
2446:     *===========================================================================
2447:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2448:         LOCAL loc_oPg2, loc_lChaveHabilitar
2449:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2450: 
2451:         TRY
2452:             *-- Chave (Tipos+Emps): editavel apenas em INCLUIR
2453:             loc_lChaveHabilitar = (THIS.this_cModoAtual = "INCLUIR")
2454:             loc_oPg2.txt_4c_Tipos.Enabled = loc_lChaveHabilitar
2455:             loc_oPg2.txt_4c_Emps.Enabled  = loc_lChaveHabilitar
2456: 
2457:             *-- Demais campos
2458:             loc_oPg2.txt_4c_Descrs.Enabled      = par_lHabilitar
2459:             loc_oPg2.txt_4c_Extensao.Enabled    = par_lHabilitar
2460:             loc_oPg2.txt_4c_TransTipo.Enabled   = par_lHabilitar
2461:             loc_oPg2.txt_4c_DirGeracao.Enabled  = par_lHabilitar
2462:             loc_oPg2.txt_4c_ClrArqOks.Enabled   = par_lHabilitar
2463:             loc_oPg2.txt_4c_DirLeitura.Enabled  = par_lHabilitar
2464:             loc_oPg2.chk_4c_Seqnum.Enabled      = par_lHabilitar
2465:             loc_oPg2.txt_4c_DirRecepcao.Enabled = par_lHabilitar
2466:             loc_oPg2.txt_4c_DirArquivar.Enabled = par_lHabilitar
2467:             loc_oPg2.txt_4c_ProxTransp.Enabled  = par_lHabilitar
2468:             loc_oPg2.txt_4c_ProxRecebe.Enabled  = par_lHabilitar
2469:             loc_oPg2.txt_4c_Tpconexao.Enabled   = par_lHabilitar
2470:             loc_oPg2.chk_4c_Chklocdel.Enabled   = par_lHabilitar
2471:             loc_oPg2.chk_4c_Chkftpdel.Enabled   = par_lHabilitar
2472:             loc_oPg2.txt_4c_Ftpend.Enabled      = par_lHabilitar
2473:             loc_oPg2.txt_4c_Ftpusuario.Enabled  = par_lHabilitar
2474:             loc_oPg2.txt_4c_Dirftpts.Enabled    = par_lHabilitar
2475:             loc_oPg2.txt_4c_Ftpsenha.Enabled    = par_lHabilitar
2476:             loc_oPg2.txt_4c_Dirftpls.Enabled    = par_lHabilitar
2477:             loc_oPg2.txt_4c_Senha2.Enabled      = par_lHabilitar
2478:         CATCH TO loException
2479:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
2480:                 "FormTme.HabilitarCampos")
2481:         ENDTRY
2482:     ENDPROC
2483: 
2484:     *===========================================================================
2485:     * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
2486:     * PUBLIC: chamado por TesteAutomatico.prg diretamente de fora da classe
2487:     * (CLAUDE.md regra #3 - BINDEVENT/chamada externa exige metodo PUBLIC)
2488:     *===========================================================================
2489:     PROCEDURE AjustarBotoesPorModo()
2490:         LOCAL loc_oBotoesAcao
2491:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2492: 
2493:         TRY
2494:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2495:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2496:         CATCH TO loException
2497:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
2498:                 "FormTme.AjustarBotoesPorModo")
2499:         ENDTRY
2500:     ENDPROC
2501: 
2502:     *===========================================================================
2503:     * BtnIncluirClick - Prepara Page2 para inclusao de novo transporte
2504:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2505:     *===========================================================================
2506:     PROCEDURE BtnIncluirClick()
2507:         LOCAL loc_lResultado
2508:         loc_lResultado = .F.
2509: 
2510:         TRY
2511:             THIS.this_oBusinessObject.NovoRegistro()
2512:             THIS.LimparCampos()
2513:             THIS.this_cModoAtual = "INCLUIR"
2514:             THIS.HabilitarCampos(.T.)
2515:             THIS.AjustarBotoesPorModo()
2516:             THIS.AlternarPagina(2)
2517:             loc_lResultado = .T.
2518:         CATCH TO loException
2519:             MostrarErro("Erro ao incluir transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2520:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2521:                 "FormTme.BtnIncluirClick")
2522:         ENDTRY
2523: 
2524:         RETURN loc_lResultado
2525:     ENDPROC
2526: 
2527:     *===========================================================================
2528:     * BtnVisualizarClick - Abre o transporte selecionado em modo somente leitura
2529:     * PUBLIC: BINDEVENT (Click do botao + DblClick do grid) exige metodo PUBLIC
2530:     *===========================================================================
2531:     PROCEDURE BtnVisualizarClick()
2532:         LOCAL loc_cTipoEmps, loc_lResultado
2533:         loc_lResultado = .F.
2534: 
2535:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2536:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
2537:         ELSE
2538:             SELECT cursor_4c_Dados
2539:             loc_cTipoEmps = ALLTRIM(cursor_4c_Dados.tipoemps)
2540: 
2541:             TRY
2542:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipoEmps)
2543:                     THIS.BOParaForm()
2544:                     THIS.this_cModoAtual = "VISUALIZAR"
2545:                     THIS.HabilitarCampos(.F.)
2546:                     THIS.AjustarBotoesPorModo()
2547:                     THIS.AlternarPagina(2)
2548:                     loc_lResultado = .T.
2549:                 ELSE
2550:                     MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Visualizar")
2551:                 ENDIF
2552:             CATCH TO loException
2553:                 MostrarErro("Erro ao visualizar transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2554:                     "Linha: " + TRANSFORM(loException.LineNo), ;
2555:                     "FormTme.BtnVisualizarClick")
2556:             ENDTRY
2557:         ENDIF
2558: 
2559:         RETURN loc_lResultado
2560:     ENDPROC
2561: 
2562:     *===========================================================================
2563:     * BtnAlterarClick - Abre o transporte selecionado para edicao
2564:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2565:     *===========================================================================
2566:     PROCEDURE BtnAlterarClick()
2567:         LOCAL loc_cTipoEmps, loc_lResultado
2568:         loc_lResultado = .F.
2569: 
2570:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2571:             MsgAviso("Nenhum registro selecionado.", "Alterar")
2572:         ELSE
2573:             SELECT cursor_4c_Dados
2574:             loc_cTipoEmps = ALLTRIM(cursor_4c_Dados.tipoemps)
2575: 
2576:             TRY
2577:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipoEmps)
2578:                     THIS.this_oBusinessObject.EditarRegistro()
2579:                     THIS.BOParaForm()
2580:                     THIS.this_cModoAtual = "ALTERAR"
2581:                     THIS.HabilitarCampos(.T.)
2582:                     THIS.AjustarBotoesPorModo()
2583:                     THIS.AlternarPagina(2)
2584:                     loc_lResultado = .T.
2585:                 ELSE
2586:                     MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Alterar")
2587:                 ENDIF
2588:             CATCH TO loException
2589:                 MostrarErro("Erro ao alterar transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2590:                     "Linha: " + TRANSFORM(loException.LineNo), ;
2591:                     "FormTme.BtnAlterarClick")
2592:             ENDTRY
2593:         ENDIF
2594: 
2595:         RETURN loc_lResultado
2596:     ENDPROC
2597: 
2598:     *===========================================================================
2599:     * BtnExcluirClick - Exclui o transporte selecionado apos confirmacao
2600:     * (TmeBO.ExecutarExclusao ja remove SigCdMei/SigCdMet antes de SigCdMe)
2601:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2602:     *===========================================================================
2603:     PROCEDURE BtnExcluirClick()
2604:         LOCAL loc_cTipoEmps, loc_lResultado
2605:         loc_lResultado = .F.
2606: 
2607:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2608:             MsgAviso("Nenhum registro selecionado.", "Excluir")
2609:         ELSE
2610:             SELECT cursor_4c_Dados
2611:             loc_cTipoEmps = ALLTRIM(cursor_4c_Dados.tipoemps)
2612: 
2613:             IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipoEmps)
2614:                 MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Excluir")
2615:             ELSE
2616:                 IF MsgConfirmaExclusao()
2617:                     TRY
2618:                         IF THIS.this_oBusinessObject.Excluir()
2619:                             MsgExcluidoSucesso()
2620:                             THIS.CarregarLista()
2621:                             loc_lResultado = .T.
2622:                         ENDIF
2623:                     CATCH TO loException
2624:                         MostrarErro("Erro ao excluir transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2625:                             "Linha: " + TRANSFORM(loException.LineNo), ;
2626:                             "FormTme.BtnExcluirClick")
2627:                     ENDTRY
2628:                 ENDIF
2629:             ENDIF
2630:         ENDIF
2631: 
2632:         RETURN loc_lResultado
2633:     ENDPROC
2634: 
2635:     *===========================================================================
2636:     * BtnBuscarClick - Localiza um transporte na lista via FormBuscaAuxiliar
2637:     * (SigCdMe, chave "tipos") e posiciona o grid no registro selecionado
2638:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2639:     *===========================================================================
2640:     PROCEDURE BtnBuscarClick()
2641:         LOCAL loc_oBusca, loc_cTipoEmps
2642:         loc_cTipoEmps = ""
2643: 
2644:         TRY
2645:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2646:                 "SigCdMe", "cursor_4c_BuscaTme", "tipos", "", ;
2647:                 "Buscar Transporte")
2648: 
2649:             IF VARTYPE(loc_oBusca) = "O"
2650:                 loc_oBusca.mAddColuna("tipos",  "", "Transporte")
2651:                 loc_oBusca.mAddColuna("emps",   "", "Emp")
2652:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2653:                 loc_oBusca.Show()
2654: 
2655:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTme")
2656:                     SELECT cursor_4c_BuscaTme
2657:                     loc_cTipoEmps = ALLTRIM(cursor_4c_BuscaTme.tipoemps)
2658:                 ENDIF
2659: 
2660:                 loc_oBusca.Release()
2661:             ENDIF
2662: 
2663:             IF USED("cursor_4c_BuscaTme")
2664:                 USE IN cursor_4c_BuscaTme
2665:             ENDIF
2666: 
2667:             IF !EMPTY(loc_cTipoEmps) AND USED("cursor_4c_Dados")
2668:                 SELECT cursor_4c_Dados
2669:                 LOCATE FOR ALLTRIM(tipoemps) == loc_cTipoEmps
2670:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2671:             ENDIF
2672: 
2673:         CATCH TO loException
2674:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormTme.BtnBuscarClick")
2675:             IF USED("cursor_4c_BuscaTme")
2676:                 USE IN cursor_4c_BuscaTme
2677:             ENDIF
2678:         ENDTRY
2679:     ENDPROC
2680: 
2681:     *===========================================================================
2682:     * BtnEncerrarClick - Fecha o formulario
2683:     * PADRAO CANONICO CLAUDE.md #10: NAO chamar Release() apos - FormBase cuida
2684:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2685:     *===========================================================================
2686:     PROCEDURE BtnEncerrarClick()
2687:         THIS.Release()
2688:     ENDPROC
2689: 
2690:     *===========================================================================
2691:     * FormParaBO - Transfere dados da Page2 para o BusinessObject antes de
2692:     * salvar. this_cTipoEmps (PK) eh calculado dentro de TmeBO.ValidarDados()
2693:     * a partir de this_cTipos + this_cEmps - nao precisa ser setado aqui.
2694:     *===========================================================================
2695:     PROTECTED PROCEDURE FormParaBO()
2696:         LOCAL loc_oPg2
2697:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2698: 
2699:         THIS.this_oBusinessObject.this_cTipos              = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tipos.Value))
2700:         THIS.this_oBusinessObject.this_cEmps               = UPPER(ALLTRIM(loc_oPg2.txt_4c_Emps.Value))
2701:         THIS.this_oBusinessObject.this_cDescricao          = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
2702:         THIS.this_oBusinessObject.this_cExtensao           = UPPER(ALLTRIM(loc_oPg2.txt_4c_Extensao.Value))
2703:         THIS.this_oBusinessObject.this_cTipoTransporte     = UPPER(ALLTRIM(loc_oPg2.txt_4c_TransTipo.Value))
2704:         THIS.this_oBusinessObject.this_cDirGeracao         = ALLTRIM(loc_oPg2.txt_4c_DirGeracao.Value)
2705:         THIS.this_oBusinessObject.this_nTransporteOk       = loc_oPg2.txt_4c_ClrArqOks.Value
2706:         THIS.this_oBusinessObject.this_cDirLeitura         = ALLTRIM(loc_oPg2.txt_4c_DirLeitura.Value)
2707:         THIS.this_oBusinessObject.this_lNaoChecarSequencia = loc_oPg2.chk_4c_Seqnum.Value
2708:         THIS.this_oBusinessObject.this_cDirRecepcao        = ALLTRIM(loc_oPg2.txt_4c_DirRecepcao.Value)
2709:         THIS.this_oBusinessObject.this_cDirArquivar        = ALLTRIM(loc_oPg2.txt_4c_DirArquivar.Value)
2710:         THIS.this_oBusinessObject.this_cTipoConexao        = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tpconexao.Value))
2711:         THIS.this_oBusinessObject.this_lLimpaDirEnvio      = loc_oPg2.chk_4c_Chklocdel.Value
2712:         THIS.this_oBusinessObject.this_lLimpaDirFtp        = loc_oPg2.chk_4c_Chkftpdel.Value
2713:         THIS.this_oBusinessObject.this_cFtpEndereco        = ALLTRIM(loc_oPg2.txt_4c_Ftpend.Value)
2714:         THIS.this_oBusinessObject.this_cFtpUsuario         = ALLTRIM(loc_oPg2.txt_4c_Ftpusuario.Value)
2715:         THIS.this_oBusinessObject.this_cDirFtpEnvio        = ALLTRIM(loc_oPg2.txt_4c_Dirftpts.Value)
2716:         THIS.this_oBusinessObject.this_cFtpSenha           = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
2717:         THIS.this_oBusinessObject.this_cDirFtpRecepcao     = ALLTRIM(loc_oPg2.txt_4c_Dirftpls.Value)
2718:     ENDPROC
2719: 
2720:     *===========================================================================
2721:     * BtnSalvarClick - Salva o transporte (INCLUIR/ALTERAR) via TmeBO.Salvar()
2722:     * Validacoes de campo obrigatorio ficam em TmeBO.ValidarDados() (Codigo do
2723:     * Transporte / Empresa - espelha o Valid legado do CmdBotoes.Click).
2724:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2725:     *===========================================================================
2726:     PROCEDURE BtnSalvarClick()
2727:         LOCAL loc_lResultado
2728:         loc_lResultado = .F.
2729: 
2730:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2731:             RETURN loc_lResultado
2732:         ENDIF
2733: 
2734:         TRY
2735:             THIS.FormParaBO()
2736: 
2737:             IF THIS.this_oBusinessObject.Salvar()
2738:                 MsgSucesso("Transporte salvo com sucesso!")
2739:                 THIS.AlternarPagina(1)
2740:                 loc_lResultado = .T.
2741:             ENDIF
2742:         CATCH TO loException
2743:             MostrarErro("Erro ao salvar transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2744:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2745:                 "FormTme.BtnSalvarClick")
2746:         ENDTRY
2747: 
2748:         RETURN loc_lResultado
2749:     ENDPROC
2750: 
2751:     *===========================================================================
2752:     * BtnCancelarClick - Cancela a edicao e volta para a lista (recarregada)
2753:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2754:     *===========================================================================
2755:     PROCEDURE BtnCancelarClick()
2756:         THIS.AlternarPagina(1)
2757:         THIS.this_cModoAtual = "LISTA"
2758:         THIS.CarregarLista()
2759:     ENDPROC
2760: 
2761:     *===========================================================================
2762:     * Destroy - Libera recursos ao fechar o formulario
2763:     *===========================================================================
2764:     PROCEDURE Destroy()
2765:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2766:             THIS.this_oBusinessObject = .NULL.
2767:         ENDIF
2768: 
2769:         IF USED("cursor_4c_Dados")
2770:             USE IN cursor_4c_Dados
2771:         ENDIF
2772: 
2773:         IF USED("cursor_4c_Itens")
2774:             USE IN cursor_4c_Itens
2775:         ENDIF
2776: 
2777:         IF USED("cursor_4c_Titulos")
2778:             USE IN cursor_4c_Titulos
2779:         ENDIF
2780: 
2781:         IF USED("cursor_4c_Grade")
2782:             USE IN cursor_4c_Grade
2783:         ENDIF
2784: 
2785:         DODEFAULT()
2786:     ENDPROC
2787: 
2788: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TmeBO.prg):
*====================================================================
* TmeBO.prg
*
* Business Object para Cadastro de Transporte de Movimentacao de
* Estoque (Configuracao de Transporte/FTP entre empresas)
* Tabela principal: SigCdMe (PK: tipoemps = Tipos + Emps)
* Tabelas de detalhe (grids da Page2.Configuracao):
*   - SigCdMeI (Page1 do PageFrame de Configuracao - Operacoes/Itens)
*   - SigCdMeT (Page2 do PageFrame de Configuracao - Titulos)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TmeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdMe)
    this_cTipoEmps            = ""    && tipoemps    char(9)  - PK (concatenacao Tipos+Emps)
    this_cTipos               = ""    && tipos       char(6)  - codigo do Processo/Transporte
    this_cEmps                = ""    && emps        char(3)  - codigo da Empresa
    this_cDescricao           = ""    && descrs      char(20) - descricao do transporte
    this_cExtensao            = ""    && extensao    char(3)  - tipo de extensao do arquivo
    this_cDirGeracao          = ""    && drivets     char(60) - diretorio de geracao/gravacao do transporte
    this_cDirLeitura          = ""    && drivels     char(60) - diretorio de leitura do zip
    this_cDirRecepcao         = ""    && drivers     char(60) - diretorio de recepcao do transporte
    this_cDirArquivar         = ""    && paths       char(60) - diretorio para arquivar o arquivo recebido
    this_cTipoConexao         = ""    && tpconexao   char(1)  - D=Dial-Up / B=Banda Larga
    this_cFtpEndereco         = ""    && ftpend      char(50) - endereco do FTP
    this_cFtpUsuario          = ""    && ftpusuario  char(50) - usuario do FTP
    this_cFtpSenha            = ""    && ftpsenha    char(20) - senha do FTP (criptografada)
    this_cDirFtpEnvio         = ""    && dirftpts    char(60) - pasta para envio (FTP)
    this_cDirFtpRecepcao      = ""    && dirftpls    char(60) - pasta para recepcao (FTP)
    this_lNaoChecarSequencia  = .F.   && nchkseqs    bit      - nao checar sequencia
    this_nTransporteOk        = 0     && clrarqs     numeric(3,0) - numero do transporte OK / limpar arqs OK
    this_cTipoTransporte      = ""    && transtipo   char(6)  - tipo transporte (lookup SigPrTrn.Codigos)
    this_lLimpaDirEnvio       = .F.   && locdel      bit      - limpa diretorio de envio
    this_lLimpaDirFtp         = .F.   && ftpdel      bit      - limpa diretorio do FTP
    this_cEmpDs               = ""    && empds       char(3)  - empresa de destino

    *-- Cursores dos grids de detalhe (Page2.Configuracao.Page1/Page2)
    this_cCursorItens         = "cursor_4c_Itens"     && grid de Operacoes/Itens (tabela SigCdMeI)
    this_cCursorTitulos       = "cursor_4c_Titulos"   && grid de Titulos (tabela SigCdMeT)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMe"
            THIS.this_cCampoChave = "tipoemps"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TmeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTipoEmps)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTipoEmps           = TratarNulo(tipoemps,   "C")
                THIS.this_cTipos              = TratarNulo(tipos,      "C")
                THIS.this_cEmps               = TratarNulo(emps,       "C")
                THIS.this_cDescricao          = TratarNulo(descrs,     "C")
                THIS.this_cExtensao           = TratarNulo(extensao,   "C")
                THIS.this_cDirGeracao         = TratarNulo(drivets,    "C")
                THIS.this_cDirLeitura         = TratarNulo(drivels,    "C")
                THIS.this_cDirRecepcao        = TratarNulo(drivers,    "C")
                THIS.this_cDirArquivar        = TratarNulo(paths,      "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_lNaoChecarSequencia = ConverterParaLogico(nchkseqs)
                THIS.this_nTransporteOk       = TratarNulo(clrarqs,    "N")
                THIS.this_cTipoTransporte     = TratarNulo(transtipo,  "C")
                THIS.this_lLimpaDirEnvio      = ConverterParaLogico(locdel)
                THIS.this_lLimpaDirFtp        = ConverterParaLogico(ftpdel)
                THIS.this_cEmpDs              = TratarNulo(empds,      "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TmeBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cTipos)
            MsgAviso("C" + CHR(243) + "digo do Transporte Tem Que Ser Preenchido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmps)
            MsgAviso("C" + CHR(243) + "digo da Empresa Tem Que Ser Preenchido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            THIS.this_cTipoEmps = PADR(THIS.this_cTipos, 6) + PADR(THIS.this_cEmps, 3)
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarChaveExistente(THIS.this_cTipoEmps)
                MsgAviso("Transporte j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarChaveExistente - Verifica se tipoemps ja existe no banco
    *====================================================================
    PROCEDURE VerificarChaveExistente(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdMe" + ;
                " WHERE tipoemps = " + EscaparSQL(par_cChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChave")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkChave")
                SELECT cursor_4c_ChkChave
                loc_lExiste = (cursor_4c_ChkChave.qtd > 0)
                USE IN cursor_4c_ChkChave
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar transporte:" + CHR(13) + loException.Message, "TmeBO.VerificarChaveExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdMe
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdMe (tipoemps, tipos, emps, descrs, extensao,
                    drivets, drivels, drivers, paths, tpconexao,
                    ftpend, ftpusuario, ftpsenha, dirftpts, dirftpls,
                    nchkseqs, clrarqs, transtipo, locdel, ftpdel, empds)
                VALUES (
                    <<EscaparSQL(THIS.this_cTipoEmps)>>,
                    <<EscaparSQL(THIS.this_cTipos)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cExtensao)>>,
                    <<EscaparSQL(THIS.this_cDirGeracao)>>,
                    <<EscaparSQL(THIS.this_cDirLeitura)>>,
                    <<EscaparSQL(THIS.this_cDirRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirArquivar)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    <<EscaparSQL(THIS.this_cTipoTransporte)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirEnvio, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cEmpDs)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TmeBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdMe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdMe
                SET descrs     = <<EscaparSQL(THIS.this_cDescricao)>>,
                    extensao   = <<EscaparSQL(THIS.this_cExtensao)>>,
                    drivets    = <<EscaparSQL(THIS.this_cDirGeracao)>>,
                    drivels    = <<EscaparSQL(THIS.this_cDirLeitura)>>,
                    drivers    = <<EscaparSQL(THIS.this_cDirRecepcao)>>,
                    paths      = <<EscaparSQL(THIS.this_cDirArquivar)>>,
                    tpconexao  = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    ftpend     = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpusuario = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    ftpsenha   = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    dirftpts   = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    dirftpls   = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    nchkseqs   = <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    clrarqs    = <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    transtipo  = <<EscaparSQL(THIS.this_cTipoTransporte)>>,
                    locdel     = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirEnvio, 1, 0), 0)>>,
                    ftpdel     = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    empds      = <<EscaparSQL(THIS.this_cEmpDs)>>
                WHERE tipoemps = <<EscaparSQL(THIS.this_cTipoEmps)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TmeBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdMe e seus detalhes
    * (SigCdMeI = Operacoes/Itens, SigCdMeT = Titulos)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMei WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir itens do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigCdMet WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir t" + CHR(237) + "tulos do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCdMe WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TmeBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com tipoemps, tipos, emps, descrs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (tipoemps C(9), tipos C(6), emps C(3), descrs C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT tipoemps, tipos, emps, descrs FROM SigCdMe"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY tipos, emps"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar transportes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TmeBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (tipoemps)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, tipos, emps, descrs, extensao,
                    drivets, drivels, drivers, paths, tpconexao,
                    ftpend, ftpusuario, ftpsenha, dirftpts, dirftpls,
                    nchkseqs, clrarqs, transtipo, locdel, ftpdel, empds
                FROM SigCdMe
                WHERE tipoemps = <<EscaparSQL(par_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Transporte n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TmeBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItens - Carrega grid de Operacoes/Itens (SigCdMeI) do transporte
    * Legado: csGrade (TipoEmps, Emps, Dopes, cIdChaves, ChkPagos, ChkSubns,
    *         EmpDs, DopeDs, ContaEs, Apagas, nDias, Numeras, DtTrans)
    *====================================================================
    PROCEDURE BuscarItens(par_cTipoEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, emps, dopes, cidchaves, chkpagos, chksubns,
                    empds, dopeds, contaes, apagas, ndias, numeras, dttrans
                FROM SigCdMei
                WHERE tipoemps = <<EscaparSQL(par_cTipoEmps)>>
                ORDER BY dopes
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorItens))

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar itens do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar itens:" + CHR(13) + loException.Message, "TmeBO.BuscarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarTitulos - Carrega grid de Titulos (SigCdMeT) do transporte
    * Legado: CsTitulo (TipoEmps, Emps, Dopes, cIdChaves, cNotas)
    *====================================================================
    PROCEDURE BuscarTitulos(par_cTipoEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorTitulos)
                USE IN (THIS.this_cCursorTitulos)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, emps, dopes, cidchaves, cnotas, empds
                FROM SigCdMet
                WHERE tipoemps = <<EscaparSQL(par_cTipoEmps)>>
                ORDER BY dopes
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTitulos))

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar t" + CHR(237) + "tulos do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar t" + CHR(237) + "tulos:" + CHR(13) + loException.Message, "TmeBO.BuscarTitulos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarOperacoesDisponiveis - Lista de operacoes para o lookup da
    * coluna "Operacao" do grid de Titulos (Pagina Titulos/Pag/Rec/Lote
    * Chq). Legado: CrSigOpOpe (Init) = SELECT Dopes FROM SigOpOpe + 3
    * operacoes especiais fixas que nao existem na tabela (PAGAMENTO,
    * RECEBIMENTO, LOTE DE CHEQUE) - tratadas apenas nesta pagina.
    * Retorna cursor_4c_Operacoes (dopes), indexado por dopes.
    *====================================================================
    PROCEDURE BuscarOperacoesDisponiveis()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_cSQL = "SELECT dopes FROM SigOpOpe"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Operacoes
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("PAGAMENTO")
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("RECEBIMENTO")
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("LOTE DE CHEQUE")
                SELECT cursor_4c_Operacoes
                INDEX ON dopes TAG dopes
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es dispon" + CHR(237) + "veis:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "TmeBO.BuscarOperacoesDisponiveis")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

