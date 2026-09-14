# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=29 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=542 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=83 vs migrado 'obj_4c_Opc_situacao' Top=130 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=102 vs migrado 'obj_4c_Opc_situacao' Left=735 (diff=633px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=331 vs migrado 'chk_4c_Fwoption1' Top=172 (diff=159px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=180 vs migrado 'chk_4c_Fwoption1' Left=879 (diff=699px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (12560 linhas total):

*-- Linhas 31 a 401:
31:     *--------------------------------------------------------------------------
32:     * Init - Inicializacao do formulario
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *--------------------------------------------------------------------------
40:     * InicializarForm - Configuracao inicial do formulario
41:     *--------------------------------------------------------------------------
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             *-- Criar instancia do Business Object
48:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
49: 
50:             IF ISNULL(THIS.this_oBusinessObject)
51:                 MostrarErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
52:                 loc_lSucesso = .F.
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.ConfigurarPaginaLista()
56:                 THIS.ConfigurarPaginaDados()
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:                 *-- Guards LostFocus: evita reabrir lookup se valor nao mudou
60:                 THIS.this_cUltimoTxtTamLostFocusValidado       = ""
61:                 THIS.this_cUltimoTxtCorLostFocusValidado       = ""
62:                 THIS.this_cUltimoTxtConquilhaLostFocusValidado = ""
63:                 THIS.this_cUltimoTxtClfiscalLostFocusValidado  = ""
64:                 THIS.this_cUltimoTxtDclfiscalLostFocusValidado = ""
65:                 THIS.this_cUltimoTxtOrigmercLostFocusValidado  = ""
66:                 THIS.this_cUltimoTxtSittricmLostFocusValidado  = ""
67:                 THIS.this_cUltimoTxtTpTribLostFocusValidado    = ""
68:                 THIS.this_cUltimoTxtMetalLostFocusValidado     = ""
69:                 THIS.this_cUltimoTxtMvalorLostFocusValidado    = ""
70:                 THIS.this_cUltimoTxtTeorLostFocusValidado      = ""
71: 
72:                 *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
73:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
74:                     IF !THIS.CarregarLista()
75:                         *-- Se falhar ao carregar, nao impede abertura
76:                     ENDIF
77:                 ENDIF
78: 
79:                 THIS.pgf_4c_Paginas.Visible = .T.
80:                 THIS.pgf_4c_Paginas.ActivePage = 1
81:                 THIS.this_cModoAtual = "LISTA"
82:                 loc_lSucesso = .T.
83:             ENDIF
84: 
85:         CATCH TO loException
86:             MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
87:             loc_lSucesso = .F.
88:         ENDTRY
89: 
90:         RETURN loc_lSucesso
91:     ENDPROC
92: 
93:     *--------------------------------------------------------------------------
94:     * ConfigurarPageFrame - Configura o PageFrame principal
95:     * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
96:     *--------------------------------------------------------------------------
97:     PROTECTED PROCEDURE ConfigurarPageFrame()
98:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
99: 
100:         WITH THIS.pgf_4c_Paginas
101:             .Top       = -29
102:             .Left      = 0
103:             .Width     = 1003
104:             .Height    = 600
105:             .PageCount = 2
106:             .Tabs      = .F.
107:             .Visible   = .T.
108: 
109:             *-- Page1 - Lista
110:             .Page1.Caption   = "Lista"
111:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page1.BackColor = RGB(255, 255, 255)
113: 
114:             *-- Page2 - Dados
115:             .Page2.Caption   = "Dados"
116:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117:             .Page2.BackColor = RGB(255, 255, 255)
118:         ENDWITH
119:     ENDPROC
120: 
121:     *--------------------------------------------------------------------------
122:     * ConfigurarPaginaLista - Configura Page1 (Lista)
123:     * Compensacao +29 em TODOS os controles (Top_original + 29)
124:     * FASE 4: Cabecalho, Botoes CRUD, Saida, Filtros completos, Grid
125:     *--------------------------------------------------------------------------
126:     PROTECTED PROCEDURE ConfigurarPaginaLista()
127:         LOCAL loc_oPagina
128:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
129: 
130:         *-- Container de cabecalho (cntSombra: Top=2 -> 31)
131:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
132:         WITH loc_oPagina.cnt_4c_Cabecalho
133:             .Top         = 31
134:             .Left        = 0
135:             .Width       = 1020
136:             .Height      = 80
137:             .BackStyle   = 1
138:             .BackColor   = RGB(53, 53, 53)
139:             .BorderWidth = 0
140:             .Visible     = .T.
141:         ENDWITH
142: 
143:         *-- Sombra do titulo (lbl_4c_Sombra: Top=15, Left=10)
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Caption   = "Cadastro de Produtos"
147:             .Top       = 17
148:             .Left      = 12
149:             .Width     = 769
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .BackStyle = 0
155:             .ForeColor = RGB(0, 0, 0)
156:             .Visible   = .T.
157:         ENDWITH
158: 
159:         *-- Titulo do cabecalho (lbl_4c_Titulo: Top=18, Left=10)
160:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
161:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
162:             .Caption   = "Cadastro de Produtos"
163:             .Top       = 15
164:             .Left      = 10
165:             .Width     = 769
166:             .Height    = 46
167:             .FontName  = "Tahoma"
168:             .FontSize  = 16
169:             .FontBold  = .T.
170:             .BackStyle = 0
171:             .ForeColor = RGB(255, 255, 255)
172:             .Visible   = .T.
173:         ENDWITH
174: 
175:         *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0 -> 29)
176:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
177:         WITH loc_oPagina.cnt_4c_Botoes
178:             .Top         = 29
179:             .Left        = 542
180:             .Width       = 390
181:             .Height      = 85
182:             .BackStyle = 1
183:             .BackColor = RGB(53, 53, 53)
184:             .BorderWidth = 0
185:             .Visible     = .T.
186:         ENDWITH
187: 
188:         *-- Botao Incluir (Left=5)
189:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
190:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
191:             .Caption         = "Incluir"
192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
193:             .PicturePosition = 13
194:             .Width           = 75
195:             .Height          = 75
196:             .Left            = 5
197:             .Top             = 5
198:             .FontName        = "Tahoma"
199:             .FontSize        = 8
200:             .Themes          = .F.
201:             .SpecialEffect   = 0
202:             .BackColor       = RGB(255, 255, 255)
203:             .ForeColor       = RGB(90, 90, 90)
204:             .Visible         = .T.
205:         ENDWITH
206:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
207: 
208:         *-- Botao Visualizar (Left=80)
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
211:             .Caption         = "Visualizar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
213:             .PicturePosition = 13
214:             .Width           = 75
215:             .Height          = 75
216:             .Left            = 80
217:             .Top             = 5
218:             .FontName        = "Tahoma"
219:             .FontSize        = 8
220:             .Themes          = .F.
221:             .SpecialEffect   = 0
222:             .BackColor       = RGB(255, 255, 255)
223:             .ForeColor       = RGB(90, 90, 90)
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
227: 
228:         *-- Botao Alterar (Left=155)
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
231:             .Caption         = "Alterar"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
233:             .PicturePosition = 13
234:             .Width           = 75
235:             .Height          = 75
236:             .Left            = 155
237:             .Top             = 5
238:             .FontName        = "Tahoma"
239:             .FontSize        = 8
240:             .Themes          = .F.
241:             .SpecialEffect   = 0
242:             .BackColor       = RGB(255, 255, 255)
243:             .ForeColor       = RGB(90, 90, 90)
244:             .Visible         = .T.
245:         ENDWITH
246:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
247: 
248:         *-- Botao Excluir (Left=230)
249:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
250:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
251:             .Caption         = "Excluir"
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:             .PicturePosition = 13
254:             .Width           = 75
255:             .Height          = 75
256:             .Left            = 230
257:             .Top             = 5
258:             .FontName        = "Tahoma"
259:             .FontSize        = 8
260:             .Themes          = .F.
261:             .SpecialEffect   = 0
262:             .BackColor       = RGB(255, 255, 255)
263:             .ForeColor       = RGB(90, 90, 90)
264:             .Visible         = .T.
265:         ENDWITH
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         *-- Botao Buscar (Left=305)
269:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
271:             .Caption         = "Buscar"
272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
273:             .PicturePosition = 13
274:             .Width           = 75
275:             .Height          = 75
276:             .Left            = 305
277:             .Top             = 5
278:             .FontName        = "Tahoma"
279:             .FontSize        = 8
280:             .Themes          = .F.
281:             .SpecialEffect   = 0
282:             .BackColor       = RGB(255, 255, 255)
283:             .ForeColor       = RGB(90, 90, 90)
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
287: 
288:         *-- Container de saida (Grupo_Saida: Left=935, Top=0 -> 29)
289:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
290:         WITH loc_oPagina.cnt_4c_Saida
291:             .Top         = 29
292:             .Left        = 935
293:             .Width       = 60
294:             .Height      = 85
295:             .BackStyle = 1
296:             .BackColor = RGB(53, 53, 53)
297:             .BorderWidth = 0
298:             .Visible     = .T.
299:         ENDWITH
300: 
301:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
302:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
303:             .Caption         = "X"
304:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
305:             .PicturePosition = 13
306:             .Width           = 50
307:             .Height          = 75
308:             .Left            = 5
309:             .Top             = 5
310:             .FontName        = "Tahoma"
311:             .FontSize        = 8
312:             .Themes          = .F.
313:             .SpecialEffect   = 0
314:             .BackColor       = RGB(255, 255, 255)
315:             .ForeColor       = RGB(90, 90, 90)
316:             .Visible         = .T.
317:         ENDWITH
318:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
319: 
320:         *-- Container de filtros (cntFiltros: Top=116, Left=5, com +29 de compensacao)
321:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
322:         WITH loc_oPagina.cnt_4c_Filtros
323:             .Top         = 116
324:             .Left        = 5
325:             .Width       = 535
326:             .Height      = 65
327:             .BackStyle   = 1
328:             .BackColor   = RGB(245, 245, 245)
329:             .BorderWidth = 1
330:             .Visible     = .T.
331:         ENDWITH
332: 
333:         *-- Label "Grupo de Produto:"
334:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
335:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
336:             .Caption   = "Grupo de Produto:"
337:             .Top       = 18
338:             .Left      = 5
339:             .Width     = 110
340:             .Height    = 15
341:             .FontName  = "Tahoma"
342:             .FontSize  = 8
343:             .BackStyle = 0
344:             .ForeColor = RGB(60, 60, 60)
345:             .Visible   = .T.
346:         ENDWITH
347: 
348:         *-- getCgru -> txt_4c_Cgru (codigo do grupo, F4 abre lookup)
349:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Cgru", "TextBox")
350:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru
351:             .Top      = 14
352:             .Left     = 116
353:             .Width    = 31
354:             .Height   = 23
355:             .FontName = "Tahoma"
356:             .FontSize = 8
357:             .Value    = ""
358:             .Visible  = .T.
359:         ENDWITH
360:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru, "KeyPress",  THIS, "TxtCgruKeyPress")
361:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru, "LostFocus", THIS, "TxtCgruLostFocus")
362: 
363:         *-- getDgru -> txt_4c_Dgru (descricao do grupo, somente leitura)
364:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Dgru", "TextBox")
365:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru
366:             .Top      = 14
367:             .Left     = 149
368:             .Width    = 154
369:             .Height   = 23
370:             .FontName = "Tahoma"
371:             .FontSize = 8
372:             .Value    = ""
373:             .ReadOnly = .T.
374:             .Visible  = .T.
375:         ENDWITH
376: 
377:         *-- Label "Ultima Alteracao:"
378:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
379:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
380:             .Caption   = CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o:"
381:             .Top       = 43
382:             .Left      = 5
383:             .Width     = 110
384:             .Height    = 15
385:             .FontName  = "Tahoma"
386:             .FontSize  = 8
387:             .BackStyle = 0
388:             .ForeColor = RGB(60, 60, 60)
389:             .Visible   = .T.
390:         ENDWITH
391: 
392:         *-- getDtIni -> txt_4c_DtIni (data inicial do filtro de alteracao)
393:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
394:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
395:             .Top      = 39
396:             .Left     = 116
397:             .Width    = 85
398:             .Height   = 23
399:             .FontName = "Tahoma"
400:             .FontSize = 8
401:             .Value    = ""

*-- Linhas 431 a 474:
431:         ENDWITH
432: 
433:         *-- optFilSituas -> opt_4c_Situas (1=Todos, 2=Ativos, 3=Inativos)
434:         loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_Situas", "OptionGroup")
435:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Situas
436:             .Top         = 15
437:             .Left        = 348
438:             .Width       = 182
439:             .Height      = 20
440:             .ButtonCount = 3
441:             .Value       = 1
442:             .BorderStyle = 0
443:             .Visible     = .T.
444:         ENDWITH
445: 
446:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_Situas
447:             .Buttons(1).Caption   = "Todos"
448:             .Buttons(1).Left      = 0
449:             .Buttons(1).Top       = 0
450:             .Buttons(1).Width     = 55
451:             .Buttons(1).Height    = 18
452:             .Buttons(1).FontName  = "Tahoma"
453:             .Buttons(1).FontSize  = 8
454:             .Buttons(1).ForeColor = RGB(60, 60, 60)
455:             .Buttons(1).BackStyle = 0
456:             .Buttons(1).Themes    = .F.
457:             .Buttons(1).AutoSize  = .F.
458: 
459:             .Buttons(2).Caption   = "Ativos"
460:             .Buttons(2).Left      = 60
461:             .Buttons(2).Top       = 0
462:             .Buttons(2).Width     = 55
463:             .Buttons(2).Height    = 18
464:             .Buttons(2).FontName  = "Tahoma"
465:             .Buttons(2).FontSize  = 8
466:             .Buttons(2).ForeColor = RGB(60, 60, 60)
467:             .Buttons(2).BackStyle = 0
468:             .Buttons(2).Themes    = .F.
469:             .Buttons(2).AutoSize  = .F.
470: 
471:             .Buttons(3).Caption   = "Inativos"
472:             .Buttons(3).Left      = 120
473:             .Buttons(3).Top       = 0
474:             .Buttons(3).Width     = 62

*-- Linhas 480 a 563:
480:             .Buttons(3).Themes    = .F.
481:             .Buttons(3).AutoSize  = .F.
482:         ENDWITH
483:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
484: 
485:         *----------------------------------------------------------------------
486:         *-- Criar cursor placeholder ANTES do grid (para RecordSource estavel)
487:         *-- Campos identicos ao que ProdutoBO.Buscar() cria
488:         *----------------------------------------------------------------------
489:         IF !USED("cursor_4c_Dados")
490:             SET NULL ON
491:             CREATE CURSOR cursor_4c_Dados (;
492:                 cpros    C(14), dpros  C(65), cgrus C(3), ;
493:                 sgrus    C(6),  reffs  C(40), ;
494:                 usuaalts C(20), situas N(1,0))
495:             SET NULL OFF
496:         ENDIF
497: 
498:         *----------------------------------------------------------------------
499:         *-- Grid principal da lista (Grade: Top=183, Left=5)
500:         *-- ColumnCount e Visible no WITH; RecordSource FORA do WITH
501:         *----------------------------------------------------------------------
502:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
503:         WITH loc_oPagina.grd_4c_Lista
504:             .Top         = 183
505:             .Left        = 5
506:             .Width       = 950
507:             .Height      = 389
508:             .ColumnCount = 7
509:             .Visible     = .T.
510:             .RecordMark   = .F.
511:             .DeleteMark   = .F.
512:         ENDWITH
513: 
514:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
515:         loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
516: 
517:         *-- ControlSources e larguras APOS RecordSource
518:         loc_oPagina.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.cpros"
519:         loc_oPagina.grd_4c_Lista.Column1.Width            = 70
520:         loc_oPagina.grd_4c_Lista.Column1.ReadOnly         = .T.
521:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption  = "Produto"
522: 
523:         loc_oPagina.grd_4c_Lista.Column2.ControlSource   = "cursor_4c_Dados.dpros"
524:         loc_oPagina.grd_4c_Lista.Column2.Width            = 315
525:         loc_oPagina.grd_4c_Lista.Column2.ReadOnly         = .T.
526:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
527: 
528:         loc_oPagina.grd_4c_Lista.Column3.ControlSource   = "cursor_4c_Dados.cgrus"
529:         loc_oPagina.grd_4c_Lista.Column3.Width            = 55
530:         loc_oPagina.grd_4c_Lista.Column3.ReadOnly         = .T.
531:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption  = "Grupo"
532: 
533:         loc_oPagina.grd_4c_Lista.Column4.ControlSource   = "cursor_4c_Dados.sgrus"
534:         loc_oPagina.grd_4c_Lista.Column4.Width            = 70
535:         loc_oPagina.grd_4c_Lista.Column4.ReadOnly         = .T.
536:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption  = "Subgrp."
537: 
538:         loc_oPagina.grd_4c_Lista.Column5.ControlSource   = "cursor_4c_Dados.reffs"
539:         loc_oPagina.grd_4c_Lista.Column5.Width            = 225
540:         loc_oPagina.grd_4c_Lista.Column5.ReadOnly         = .T.
541:         loc_oPagina.grd_4c_Lista.Column5.Header1.Caption  = "Ref. Fornecedor"
542: 
543:         loc_oPagina.grd_4c_Lista.Column6.ControlSource   = "cursor_4c_Dados.usuaalts"
544:         loc_oPagina.grd_4c_Lista.Column6.Width            = 150
545:         loc_oPagina.grd_4c_Lista.Column6.ReadOnly         = .T.
546:         loc_oPagina.grd_4c_Lista.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
547: 
548:         loc_oPagina.grd_4c_Lista.Column7.ControlSource   = "cursor_4c_Dados.situas"
549:         loc_oPagina.grd_4c_Lista.Column7.Width            = 30
550:         loc_oPagina.grd_4c_Lista.Column7.ReadOnly         = .T.
551:         loc_oPagina.grd_4c_Lista.Column7.Header1.Caption  = "I"
552: 
553:         *-- Formatacao padrao (Verdana 8, gridlines, RowHeight=16)
554:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
555: 
556:         *-- Label de contagem de produtos (lblProdutos: Top=584 + 29 = 613 -> 575)
557:         loc_oPagina.AddObject("lbl_4c_Contagem", "Label")
558:         WITH loc_oPagina.lbl_4c_Contagem
559:             .Caption   = "Produtos Selecionados : 0"
560:             .Top       = 575
561:             .Left      = 38
562:             .Width     = 200
563:             .Height    = 15

*-- Linhas 569 a 675:
569:         ENDWITH
570: 
571:         *-- Tornar controles visiveis (apenas prefixos validos)
572:         THIS.TornarControlesVisiveis(loc_oPagina)
573:     ENDPROC
574: 
575:     *--------------------------------------------------------------------------
576:     * ConfigurarPaginaDados - Configura Page2 (Dados)
577:     * FASE 4/5: Botoes Salvar/Cancelar + PageFrame interno (7 abas) + pgDados
578:     * Compensacao +29 em controles de Page2; controles de pgf_4c_Dados sem compensacao
579:     *--------------------------------------------------------------------------
580:     PROTECTED PROCEDURE ConfigurarPaginaDados()
581:         LOCAL loc_oPagina, loc_oPgfDados
582:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
583: 
584:         *-- Container de botoes de acao (Grupo_Salva: Top=4 -> 33, Left=842)
585:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
586:         WITH loc_oPagina.cnt_4c_BotoesAcao
587:             .Top         = 33
588:             .Left        = 842
589:             .Width       = 160
590:             .Height      = 85
591:             .BackStyle = 1
592:             .BackColor = RGB(53, 53, 53)
593:             .BorderWidth = 0
594:             .Visible     = .T.
595:         ENDWITH
596: 
597:         *-- Botao Salvar (Left=5)
598:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
599:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
600:             .Caption         = "Salvar"
601:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
602:             .PicturePosition = 13
603:             .Width           = 75
604:             .Height          = 75
605:             .Left            = 5
606:             .Top             = 5
607:             .FontName        = "Tahoma"
608:             .FontSize        = 8
609:             .Themes          = .F.
610:             .SpecialEffect   = 0
611:             .BackColor       = RGB(255, 255, 255)
612:             .ForeColor       = RGB(90, 90, 90)
613:             .Visible         = .T.
614:         ENDWITH
615:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
616: 
617:         *-- Botao Cancelar (Left=80)
618:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
619:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
620:             .Caption         = "Cancelar"
621:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
622:             .PicturePosition = 13
623:             .Width           = 75
624:             .Height          = 75
625:             .Left            = 80
626:             .Top             = 5
627:             .FontName        = "Tahoma"
628:             .FontSize        = 8
629:             .Themes          = .F.
630:             .SpecialEffect   = 0
631:             .BackColor       = RGB(255, 255, 255)
632:             .ForeColor       = RGB(90, 90, 90)
633:             .Visible         = .T.
634:         ENDWITH
635:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
636: 
637:         *----------------------------------------------------------------------
638:         *-- PageFrame interno com 7 abas de dados
639:         *-- Legado: pgframeDados Top=-54, Left=-1, Width=1003, Height=656
640:         *-- Compensacao outer PF (-29) + inner PF (-54) = total -83 para controles internos
641:         *-- Top relativo a Page2: -54 + 29 = -25
642:         *----------------------------------------------------------------------
643:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
644:         loc_oPgfDados = loc_oPagina.pgf_4c_Dados
645: 
646:         WITH loc_oPgfDados
647:             .Top       = -25
648:             .Left      = -1
649:             .Width     = 1003
650:             .Height    = 656
651:             .PageCount = 7
652:             .Tabs      = .T.
653:             .Visible   = .T.
654:             .TabStyle  = 0
655:         ENDWITH
656: 
657:         *-- Aba 1: Dados Gerais (pgDados)
658:         WITH loc_oPgfDados.Page1
659:             .Caption   = "Dados"
660:             .BackColor = RGB(255, 255, 255)
661:         ENDWITH
662: 
663:         *-- Aba 2: Composicao (pgComposicao)
664:         WITH loc_oPgfDados.Page2
665:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
666:             .BackColor = RGB(255, 255, 255)
667:         ENDWITH
668: 
669:         *-- Aba 3: Dados Fiscais (pgDadosFiscais)
670:         WITH loc_oPgfDados.Page3
671:             .Caption   = "Dados Fiscais"
672:             .BackColor = RGB(255, 255, 255)
673:         ENDWITH
674: 
675:         *-- Aba 4: Fases de Producao (PgDadosFaseP)

*-- Linhas 718 a 770:
718:         THIS.ConfigurarPgPgDesigner()
719: 
720:         *-- Tornar controles visiveis
721:         THIS.TornarControlesVisiveis(loc_oPagina)
722:     ENDPROC
723: 
724:     *==========================================================================
725:     * FASE 9 - Aba Composicao (pgComposicao - Page2 do pgf_4c_Dados)
726:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao
727:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
728:     * 144 controles: 3 grids (14+15+3 cols), 2 cmd groups, textboxes, labels, shapes
729:     *==========================================================================
730:     PROTECTED PROCEDURE ConfigurarPgpgComposicao()
731:         LOCAL loc_oPg, loc_oGrd
732: 
733:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
734: 
735:         *----------------------------------------------------------------------
736:         *-- Cursor placeholder para grdCompo (SigPrCpo)
737:         *-- Campos: cpros(PK), mats(material), dcomps(descricao), unicompos(un),
738:         *--         pcompos(valor), qtds(qtde), totals(total), bloqueio(moeda),
739:         *--         obscompos(obs), etiq(E), consumo(consumo), qtd2(qtde cons),
740:         *--         uni2(un cons), ord(ordem), matrizes(material alternativo)
741:         *----------------------------------------------------------------------
742:         IF !USED("cursor_4c_Compo")
743:             SET NULL ON
744:             CREATE CURSOR cursor_4c_Compo (;
745:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
746:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
747:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
748:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
749:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
750:                 cgrus    C(3),  moeds    C(5))
751:             SET NULL OFF
752:         ENDIF
753: 
754:         *----------------------------------------------------------------------
755:         *-- Cursor placeholder para grdsubcp (SigSubCp)
756:         *----------------------------------------------------------------------
757:         IF !USED("cursor_4c_SubCp")
758:             SET NULL ON
759:             CREATE CURSOR cursor_4c_SubCp (;
760:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
761:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
762:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
763:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
764:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
765:                 tamanhos C(20))
766:             SET NULL OFF
767:         ENDIF
768: 
769:         *----------------------------------------------------------------------
770:         *-- Cursor placeholder para GradeGRUPO (TotGrupo)

*-- Linhas 872 a 916:
872:             .ForeColor     = RGB(36, 84, 155)
873:             .Visible       = .T.
874:         ENDWITH
875:         BINDEVENT(loc_oPg.txt_4c_MatP, "KeyPress",  THIS, "TxtMatPKeyPress")
876:         BINDEVENT(loc_oPg.txt_4c_MatP, "LostFocus", THIS, "TxtMatPLostFocus")
877: 
878:         *----------------------------------------------------------------------
879:         *-- Grid grdCompo (14 colunas) - Composicao do produto
880:         *-- Top:148 Left:6 Width:943 Height:147
881:         *----------------------------------------------------------------------
882:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
883:         WITH loc_oPg.grd_4c_Compo
884:             .Top         = 148
885:             .Left        = 6
886:             .Width       = 943
887:             .Height      = 147
888:             .ColumnCount = 14
889:             .FontName    = "Verdana"
890:             .FontSize    = 8
891:             .GridLines   = 3
892:             .GridLineWidth = 1
893:             .GridLineColor = RGB(238, 238, 238)
894:             .RecordMark  = .F.
895:             .DeleteMark  = .F.
896:             .AllowRowSizing = .F.
897:             .ReadOnly    = .F.
898:             .BackColor   = RGB(255, 255, 255)
899:             .ForeColor   = RGB(90, 90, 90)
900:             .HighlightBackColor = RGB(220, 230, 242)
901:             .HighlightForeColor = RGB(15, 41, 104)
902:             .HighlightStyle = 2
903:             .RowHeight   = 16
904:             .ScrollBars  = 2
905:             .Visible     = .T.
906:         ENDWITH
907: 
908:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
909:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
910: 
911:         *-- Configurar colunas do grd_4c_Compo APOS RecordSource
912:         WITH loc_oPg.grd_4c_Compo
913:             *-- Col1: Material (C14) W:80
914:             .Column1.Header1.Caption       = "Material"
915:             .Column1.Width                 = 80
916:             .Column1.ControlSource         = "cursor_4c_Compo.mats"

*-- Linhas 992 a 1143:
992:             .Column14.Width                = 83
993:             .Column14.ControlSource        = "cursor_4c_Compo.matrizes"
994:         ENDWITH
995:         BINDEVENT(loc_oPg.grd_4c_Compo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
996: 
997:         *----------------------------------------------------------------------
998:         *-- Botoes do grdCompo (cmdgCompo: 5 botoes, Right of grid)
999:         *-- Container em T:145 L:947 W:50 H:210 (cada botao 50x42)
1000:         *----------------------------------------------------------------------
1001:         loc_oPg.AddObject("cnt_4c_BotoesCompo", "Container")
1002:         WITH loc_oPg.cnt_4c_BotoesCompo
1003:             .Top         = 145
1004:             .Left        = 947
1005:             .Width       = 50
1006:             .Height      = 210
1007:             .BackStyle = 1
1008:             .BackColor = RGB(53, 53, 53)
1009:             .BorderWidth = 0
1010:             .Visible     = .T.
1011:         ENDWITH
1012: 
1013:         *-- Botao 1: Inserir componente
1014:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_InserirCompo", "CommandButton")
1015:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo
1016:             .Caption     = "+"
1017:             .Top         = 0
1018:             .Left        = 0
1019:             .Width       = 50
1020:             .Height      = 42
1021:             .FontName    = "Tahoma"
1022:             .FontSize    = 10
1023:             .FontBold    = .T.
1024:             .Themes      = .F.
1025:             .SpecialEffect = 0
1026:             .BackColor   = RGB(255, 255, 255)
1027:             .ForeColor   = RGB(0, 128, 0)
1028:             .Visible     = .T.
1029:         ENDWITH
1030:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_InserirCompo, "Click", THIS, "CmdInserirCompoClick")
1031: 
1032:         *-- Botao 2: Excluir componente
1033:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_ExcluirCompo", "CommandButton")
1034:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_ExcluirCompo
1035:             .Caption     = "-"
1036:             .Top         = 42
1037:             .Left        = 0
1038:             .Width       = 50
1039:             .Height      = 42
1040:             .FontName    = "Tahoma"
1041:             .FontSize    = 10
1042:             .FontBold    = .T.
1043:             .Themes      = .F.
1044:             .SpecialEffect = 0
1045:             .BackColor   = RGB(255, 255, 255)
1046:             .ForeColor   = RGB(192, 0, 0)
1047:             .Visible     = .T.
1048:         ENDWITH
1049:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_ExcluirCompo, "Click", THIS, "CmdExcluirCompoClick")
1050: 
1051:         *-- Botao 3: Calcular preco (fornecedor)
1052:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_CalcFornec", "CommandButton")
1053:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_CalcFornec
1054:             .Caption     = "F"
1055:             .Top         = 84
1056:             .Left        = 0
1057:             .Width       = 50
1058:             .Height      = 42
1059:             .FontName    = "Tahoma"
1060:             .FontSize    = 9
1061:             .Themes      = .F.
1062:             .SpecialEffect = 0
1063:             .BackColor   = RGB(255, 255, 255)
1064:             .ForeColor   = RGB(90, 90, 90)
1065:             .Visible     = .T.
1066:         ENDWITH
1067:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_CalcFornec, "Click", THIS, "CmdCalcFornecClick")
1068: 
1069:         *-- Botao 4: Atualizar composicao
1070:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_AtualizarCompo", "CommandButton")
1071:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarCompo
1072:             .Caption     = "A"
1073:             .Top         = 126
1074:             .Left        = 0
1075:             .Width       = 50
1076:             .Height      = 42
1077:             .FontName    = "Tahoma"
1078:             .FontSize    = 9
1079:             .Themes      = .F.
1080:             .SpecialEffect = 0
1081:             .BackColor   = RGB(255, 255, 255)
1082:             .ForeColor   = RGB(90, 90, 90)
1083:             .Visible     = .T.
1084:         ENDWITH
1085:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarCompo, "Click", THIS, "CmdAtualizarCompoClick")
1086: 
1087:         *-- Botao 5: Atualizar pesos
1088:         loc_oPg.cnt_4c_BotoesCompo.AddObject("cmd_4c_AtualizarPesos", "CommandButton")
1089:         WITH loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarPesos
1090:             .Caption     = "P"
1091:             .Top         = 168
1092:             .Left        = 0
1093:             .Width       = 50
1094:             .Height      = 42
1095:             .FontName    = "Tahoma"
1096:             .FontSize    = 9
1097:             .Themes      = .F.
1098:             .SpecialEffect = 0
1099:             .BackColor   = RGB(255, 255, 255)
1100:             .ForeColor   = RGB(90, 90, 90)
1101:             .Visible     = .T.
1102:         ENDWITH
1103:         BINDEVENT(loc_oPg.cnt_4c_BotoesCompo.cmd_4c_AtualizarPesos, "Click", THIS, "CmdAtualizarPesosClick")
1104: 
1105:         *----------------------------------------------------------------------
1106:         *-- Grid grdsubcp (15 colunas) - Sub-componentes
1107:         *-- Top:348 Left:6 Width:943 Height:83
1108:         *----------------------------------------------------------------------
1109:         loc_oPg.AddObject("grd_4c_SubCp", "Grid")
1110:         WITH loc_oPg.grd_4c_SubCp
1111:             .Top         = 348
1112:             .Left        = 6
1113:             .Width       = 943
1114:             .Height      = 83
1115:             .ColumnCount = 15
1116:             .FontName    = "Verdana"
1117:             .FontSize    = 8
1118:             .GridLines   = 3
1119:             .GridLineWidth = 1
1120:             .GridLineColor = RGB(238, 238, 238)
1121:             .RecordMark  = .F.
1122:             .DeleteMark  = .F.
1123:             .AllowRowSizing = .F.
1124:             .ReadOnly    = .F.
1125:             .BackColor   = RGB(255, 255, 255)
1126:             .ForeColor   = RGB(90, 90, 90)
1127:             .HighlightBackColor = RGB(220, 230, 242)
1128:             .HighlightForeColor = RGB(15, 41, 104)
1129:             .HighlightStyle = 2
1130:             .RowHeight   = 16
1131:             .ScrollBars  = 2
1132:             .Visible     = .T.
1133:         ENDWITH
1134: 
1135:         *-- RecordSource FORA do WITH
1136:         loc_oPg.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
1137: 
1138:         *-- Configurar colunas do grd_4c_SubCp APOS RecordSource
1139:         WITH loc_oPg.grd_4c_SubCp
1140:             .Column1.Header1.Caption       = "Material"
1141:             .Column1.Width                 = 75
1142:             .Column1.ControlSource         = "cursor_4c_SubCp.mats"
1143: 

*-- Linhas 1209 a 1306:
1209:             .Column15.ControlSource        = "cursor_4c_SubCp.tamanhos"
1210:             .Column15.Alignment            = 0
1211:         ENDWITH
1212:         BINDEVENT(loc_oPg.grd_4c_SubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
1213: 
1214:         *----------------------------------------------------------------------
1215:         *-- Botoes do grdsubcp (cmdgSubCp: 2 botoes, Right of grid)
1216:         *-- Container em T:345 L:947 W:50 H:90 (cada botao 50x45)
1217:         *----------------------------------------------------------------------
1218:         loc_oPg.AddObject("cnt_4c_BotoesSubCp", "Container")
1219:         WITH loc_oPg.cnt_4c_BotoesSubCp
1220:             .Top         = 345
1221:             .Left        = 947
1222:             .Width       = 50
1223:             .Height      = 90
1224:             .BackStyle = 1
1225:             .BackColor = RGB(53, 53, 53)
1226:             .BorderWidth = 0
1227:             .Visible     = .T.
1228:         ENDWITH
1229: 
1230:         *-- Botao 1: Inserir sub-componente
1231:         loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_InserirSubCp", "CommandButton")
1232:         WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp
1233:             .Caption     = "+"
1234:             .Top         = 0
1235:             .Left        = 0
1236:             .Width       = 50
1237:             .Height      = 45
1238:             .FontName    = "Tahoma"
1239:             .FontSize    = 10
1240:             .FontBold    = .T.
1241:             .Themes      = .F.
1242:             .SpecialEffect = 0
1243:             .BackColor   = RGB(255, 255, 255)
1244:             .ForeColor   = RGB(0, 128, 0)
1245:             .Visible     = .T.
1246:         ENDWITH
1247:         BINDEVENT(loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_InserirSubCp, "Click", THIS, "CmdInserirSubCpClick")
1248: 
1249:         *-- Botao 2: Excluir sub-componente
1250:         loc_oPg.cnt_4c_BotoesSubCp.AddObject("cmd_4c_ExcluirSubCp", "CommandButton")
1251:         WITH loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_ExcluirSubCp
1252:             .Caption     = "-"
1253:             .Top         = 45
1254:             .Left        = 0
1255:             .Width       = 50
1256:             .Height      = 45
1257:             .FontName    = "Tahoma"
1258:             .FontSize    = 10
1259:             .FontBold    = .T.
1260:             .Themes      = .F.
1261:             .SpecialEffect = 0
1262:             .BackColor   = RGB(255, 255, 255)
1263:             .ForeColor   = RGB(192, 0, 0)
1264:             .Visible     = .T.
1265:         ENDWITH
1266:         BINDEVENT(loc_oPg.cnt_4c_BotoesSubCp.cmd_4c_ExcluirSubCp, "Click", THIS, "CmdExcluirSubCpClick")
1267: 
1268:         *----------------------------------------------------------------------
1269:         *-- Descricao / Substitui (abaixo grdsubcp)
1270:         *-- Say3: "Descricao :" (T:435 L:39 W:55)
1271:         *-- get_desccp: (T:432 L:99 W:298 H:21) - readonly
1272:         *-- Say5: "Substitui :" (T:435 L:465 W:50)
1273:         *-- get_matsub: (T:432 L:517 W:108 H:21) - readonly
1274:         *----------------------------------------------------------------------
1275:         loc_oPg.AddObject("lbl_4c_DescCp", "Label")
1276:         WITH loc_oPg.lbl_4c_DescCp
1277:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
1278:             .Top       = 435
1279:             .Left      = 39
1280:             .Width     = 55
1281:             .Height    = 15
1282:             .FontName  = "Tahoma"
1283:             .FontSize  = 8
1284:             .BackStyle = 0
1285:             .ForeColor = RGB(90, 90, 90)
1286:             .Visible   = .T.
1287:         ENDWITH
1288: 
1289:         loc_oPg.AddObject("txt_4c_DescCp", "TextBox")
1290:         WITH loc_oPg.txt_4c_DescCp
1291:             .Top           = 432
1292:             .Left          = 99
1293:             .Width         = 298
1294:             .Height        = 21
1295:             .FontName      = "Tahoma"
1296:             .FontSize      = 8
1297:             .MaxLength     = 65
1298:             .Value         = ""
1299:             .SpecialEffect = 1
1300:             .Enabled       = .F.
1301:             .Visible       = .T.
1302:         ENDWITH
1303: 
1304:         loc_oPg.AddObject("lbl_4c_Substitui", "Label")
1305:         WITH loc_oPg.lbl_4c_Substitui
1306:             .Caption   = "Substitui :"

*-- Linhas 1435 a 1494:
1435:             .Themes    = .F.
1436:             .Visible   = .T.
1437:         ENDWITH
1438:         BINDEVENT(loc_oPg.chk_4c_LiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
1439: 
1440:         loc_oPg.AddObject("chk_4c_LiberaVenda", "CheckBox")
1441:         WITH loc_oPg.chk_4c_LiberaVenda
1442:             .Caption   = ""
1443:             .Top       = 459
1444:             .Left      = 323
1445:             .Width     = 39
1446:             .Height    = 38
1447:             .FontName  = "Tahoma"
1448:             .FontSize  = 8
1449:             .Value     = 0
1450:             .BackStyle = 0
1451:             .Themes    = .F.
1452:             .Visible   = .T.
1453:         ENDWITH
1454:         BINDEVENT(loc_oPg.chk_4c_LiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
1455: 
1456:         *----------------------------------------------------------------------
1457:         *-- Linha separadora - Shape6 (T:497 L:9 W:158 H:2 - secao custo)
1458:         *-- Shape4 (T:498 L:323 W:158 H:2 - secao venda)
1459:         *----------------------------------------------------------------------
1460:         loc_oPg.AddObject("shp_4c_Shape6", "Shape")
1461:         WITH loc_oPg.shp_4c_Shape6
1462:             .Top         = 497
1463:             .Left        = 9
1464:             .Width       = 158
1465:             .Height      = 2
1466:             .FillStyle   = 0
1467:             .BackStyle   = 1
1468:             .FillColor   = RGB(128, 128, 128)
1469:             .BorderStyle = 1
1470:             .Visible     = .T.
1471:         ENDWITH
1472: 
1473:         loc_oPg.AddObject("shp_4c_Shape4", "Shape")
1474:         WITH loc_oPg.shp_4c_Shape4
1475:             .Top         = 498
1476:             .Left        = 323
1477:             .Width       = 158
1478:             .Height      = 2
1479:             .FillStyle   = 0
1480:             .BackStyle   = 1
1481:             .FillColor   = RGB(128, 128, 128)
1482:             .BorderStyle = 1
1483:             .Visible     = .T.
1484:         ENDWITH
1485: 
1486:         *----------------------------------------------------------------------
1487:         *-- Secao CUSTO (controlada por chkLiberaCusto)
1488:         *-- lblCompra: "Preco de Custo (Moeda 1)" T:502 L:9 W:127
1489:         *-- getPcus: T:517 L:9 W:115 H:23
1490:         *-- getMoec: T:517 L:127 W:31 H:23 (moeda custo 1)
1491:         *-- lblCuVda: "Fator de Custo (Moeda 2)" T:502 L:161 W:126
1492:         *-- getFcusto: T:517 L:161 W:115 H:23
1493:         *-- getMoepc: T:517 L:279 W:31 H:23 (moeda custo 2)
1494:         *-- Say8: "Total " T:542 L:161 W:29

*-- Linhas 1533 a 1849:
1533:             .Enabled       = .F.
1534:             .Visible       = .T.
1535:         ENDWITH
1536:         BINDEVENT(loc_oPg.txt_4c_Pcus, "LostFocus", THIS, "TxtPcusLostFocus")
1537: 
1538:         loc_oPg.AddObject("txt_4c_Moec", "TextBox")
1539:         WITH loc_oPg.txt_4c_Moec
1540:             .Top           = 517
1541:             .Left          = 127
1542:             .Width         = 31
1543:             .Height        = 23
1544:             .FontName      = "Tahoma"
1545:             .FontSize      = 8
1546:             .MaxLength     = 5
1547:             .Value         = ""
1548:             .SpecialEffect = 1
1549:             .ForeColor     = RGB(36, 84, 155)
1550:             .Enabled       = .F.
1551:             .Visible       = .T.
1552:         ENDWITH
1553:         BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress",  THIS, "TxtMoecKeyPress")
1554:         BINDEVENT(loc_oPg.txt_4c_Moec, "LostFocus", THIS, "TxtMoecLostFocus")
1555: 
1556:         loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
1557:         WITH loc_oPg.lbl_4c_LblCuVda
1558:             .Caption   = "Fator de Custo (Moeda 2)"
1559:             .Top       = 502
1560:             .Left      = 161
1561:             .Width     = 126
1562:             .Height    = 15
1563:             .FontName  = "Tahoma"
1564:             .FontSize  = 8
1565:             .BackStyle = 0
1566:             .ForeColor = RGB(90, 90, 90)
1567:             .Visible   = .T.
1568:         ENDWITH
1569: 
1570:         loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
1571:         WITH loc_oPg.txt_4c_Fcusto
1572:             .Top           = 517
1573:             .Left          = 161
1574:             .Width         = 115
1575:             .Height        = 23
1576:             .FontName      = "Tahoma"
1577:             .FontSize      = 8
1578:             .Value         = 0.0
1579:             .SpecialEffect = 1
1580:             .ForeColor     = RGB(36, 84, 155)
1581:             .Enabled       = .F.
1582:             .Visible       = .T.
1583:         ENDWITH
1584:         BINDEVENT(loc_oPg.txt_4c_Fcusto, "LostFocus", THIS, "TxtFcustoLostFocus")
1585: 
1586:         loc_oPg.AddObject("txt_4c_Moepc", "TextBox")
1587:         WITH loc_oPg.txt_4c_Moepc
1588:             .Top           = 517
1589:             .Left          = 279
1590:             .Width         = 31
1591:             .Height        = 23
1592:             .FontName      = "Tahoma"
1593:             .FontSize      = 8
1594:             .MaxLength     = 5
1595:             .Value         = ""
1596:             .SpecialEffect = 1
1597:             .ForeColor     = RGB(36, 84, 155)
1598:             .Enabled       = .F.
1599:             .Visible       = .T.
1600:         ENDWITH
1601:         BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress",  THIS, "TxtMoepcKeyPress")
1602:         BINDEVENT(loc_oPg.txt_4c_Moepc, "LostFocus", THIS, "TxtMoepcLostFocus")
1603: 
1604:         loc_oPg.AddObject("lbl_4c_LblTotalCusto", "Label")
1605:         WITH loc_oPg.lbl_4c_LblTotalCusto
1606:             .Caption   = "Total "
1607:             .Top       = 542
1608:             .Left      = 161
1609:             .Width     = 29
1610:             .Height    = 15
1611:             .FontName  = "Tahoma"
1612:             .FontSize  = 8
1613:             .BackStyle = 0
1614:             .ForeColor = RGB(90, 90, 90)
1615:             .Visible   = .T.
1616:         ENDWITH
1617: 
1618:         loc_oPg.AddObject("txt_4c_Custof", "TextBox")
1619:         WITH loc_oPg.txt_4c_Custof
1620:             .Top           = 557
1621:             .Left          = 161
1622:             .Width         = 115
1623:             .Height        = 23
1624:             .FontName      = "Tahoma"
1625:             .FontSize      = 8
1626:             .Value         = 0.0
1627:             .SpecialEffect = 1
1628:             .ForeColor     = RGB(36, 84, 155)
1629:             .Enabled       = .F.
1630:             .Visible       = .T.
1631:         ENDWITH
1632:         BINDEVENT(loc_oPg.txt_4c_Custof, "LostFocus", THIS, "TxtCustofLostFocus")
1633: 
1634:         loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
1635:         WITH loc_oPg.txt_4c_Moecusf
1636:             .Top           = 557
1637:             .Left          = 279
1638:             .Width         = 31
1639:             .Height        = 23
1640:             .FontName      = "Tahoma"
1641:             .FontSize      = 8
1642:             .MaxLength     = 5
1643:             .Value         = ""
1644:             .SpecialEffect = 1
1645:             .ForeColor     = RGB(36, 84, 155)
1646:             .Enabled       = .F.
1647:             .Visible       = .T.
1648:         ENDWITH
1649:         BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress",  THIS, "TxtMoecusfKeyPress")
1650:         BINDEVENT(loc_oPg.txt_4c_Moecusf, "LostFocus", THIS, "TxtMoecusfLostFocus")
1651: 
1652:         loc_oPg.AddObject("lbl_4c_LblMkp", "Label")
1653:         WITH loc_oPg.lbl_4c_LblMkp
1654:             .Caption   = "MKP"
1655:             .Top       = 542
1656:             .Left      = 9
1657:             .Width     = 22
1658:             .Height    = 15
1659:             .FontName  = "Tahoma"
1660:             .FontSize  = 8
1661:             .BackStyle = 0
1662:             .ForeColor = RGB(90, 90, 90)
1663:             .Visible   = .T.
1664:         ENDWITH
1665: 
1666:         loc_oPg.AddObject("txt_4c_GetCmkpc", "TextBox")
1667:         WITH loc_oPg.txt_4c_GetCmkpc
1668:             .Top           = 557
1669:             .Left          = 9
1670:             .Width         = 24
1671:             .Height        = 23
1672:             .FontName      = "Tahoma"
1673:             .FontSize      = 8
1674:             .MaxLength     = 5
1675:             .Value         = ""
1676:             .SpecialEffect = 1
1677:             .ForeColor     = RGB(36, 84, 155)
1678:             .Enabled       = .F.
1679:             .Visible       = .T.
1680:         ENDWITH
1681:         BINDEVENT(loc_oPg.txt_4c_GetCmkpc, "KeyPress",  THIS, "TxtGetCmkpcKeyPress")
1682:         BINDEVENT(loc_oPg.txt_4c_GetCmkpc, "LostFocus", THIS, "TxtGetCmkpcLostFocus")
1683: 
1684:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
1685:         WITH loc_oPg.lbl_4c_LblValAdics
1686:             .Caption   = "Valor Adicional"
1687:             .Top       = 542
1688:             .Left      = 64
1689:             .Width     = 71
1690:             .Height    = 15
1691:             .FontName  = "Tahoma"
1692:             .FontSize  = 8
1693:             .BackStyle = 0
1694:             .ForeColor = RGB(90, 90, 90)
1695:             .Visible   = .T.
1696:         ENDWITH
1697: 
1698:         loc_oPg.AddObject("txt_4c_GetPftioc", "TextBox")
1699:         WITH loc_oPg.txt_4c_GetPftioc
1700:             .Top           = 557
1701:             .Left          = 64
1702:             .Width         = 94
1703:             .Height        = 23
1704:             .FontName      = "Tahoma"
1705:             .FontSize      = 8
1706:             .MaxLength     = 5
1707:             .Value         = ""
1708:             .SpecialEffect = 1
1709:             .ForeColor     = RGB(36, 84, 155)
1710:             .Enabled       = .F.
1711:             .Visible       = .T.
1712:         ENDWITH
1713:         BINDEVENT(loc_oPg.txt_4c_GetPftioc, "KeyPress",  THIS, "TxtGetPftiocKeyPress")
1714:         BINDEVENT(loc_oPg.txt_4c_GetPftioc, "LostFocus", THIS, "TxtGetPftiocLostFocus")
1715: 
1716:         *-- chkPlanCus (T:556 L:36 W:25 H:25) - plano custo
1717:         loc_oPg.AddObject("chk_4c_PlanCus", "CheckBox")
1718:         WITH loc_oPg.chk_4c_PlanCus
1719:             .Caption   = ""
1720:             .Top       = 556
1721:             .Left      = 36
1722:             .Width     = 25
1723:             .Height    = 25
1724:             .Value     = 0
1725:             .BackStyle = 0
1726:             .Themes    = .F.
1727:             .Enabled   = .F.
1728:             .Visible   = .T.
1729:         ENDWITH
1730:         BINDEVENT(loc_oPg.chk_4c_PlanCus, "Click", THIS, "ChkPlanCusClick")
1731: 
1732:         loc_oPg.AddObject("lbl_4c_PesoMedio", "Label")
1733:         WITH loc_oPg.lbl_4c_PesoMedio
1734:             .Caption   = "Peso M" + CHR(233) + "dio"
1735:             .Top       = 581
1736:             .Left      = 10
1737:             .Width     = 56
1738:             .Height    = 15
1739:             .FontName  = "Tahoma"
1740:             .FontSize  = 8
1741:             .BackStyle = 0
1742:             .ForeColor = RGB(90, 90, 90)
1743:             .Visible   = .T.
1744:         ENDWITH
1745: 
1746:         loc_oPg.AddObject("txt_4c_Pesom", "TextBox")
1747:         WITH loc_oPg.txt_4c_Pesom
1748:             .Top           = 596
1749:             .Left          = 10
1750:             .Width         = 79
1751:             .Height        = 23
1752:             .FontName      = "Tahoma"
1753:             .FontSize      = 8
1754:             .Value         = 0.0
1755:             .SpecialEffect = 1
1756:             .ForeColor     = RGB(36, 84, 155)
1757:             .Enabled       = .F.
1758:             .Visible       = .T.
1759:         ENDWITH
1760:         BINDEVENT(loc_oPg.txt_4c_Pesom, "LostFocus", THIS, "TxtPesomLostFocus")
1761: 
1762:         *-- cmdPesoM: "..." T:597 L:92 W:26 H:23
1763:         loc_oPg.AddObject("cmd_4c_PesoM", "CommandButton")
1764:         WITH loc_oPg.cmd_4c_PesoM
1765:             .Caption     = "..."
1766:             .Top         = 597
1767:             .Left        = 92
1768:             .Width       = 26
1769:             .Height      = 23
1770:             .FontName    = "Tahoma"
1771:             .FontSize    = 8
1772:             .Themes      = .F.
1773:             .SpecialEffect = 0
1774:             .BackColor   = RGB(255, 255, 255)
1775:             .ForeColor   = RGB(90, 90, 90)
1776:             .Enabled     = .F.
1777:             .Visible     = .T.
1778:         ENDWITH
1779:         BINDEVENT(loc_oPg.cmd_4c_PesoM, "Click", THIS, "CmdPesoMClick")
1780: 
1781:         loc_oPg.AddObject("lbl_4c_LblCotacao", "Label")
1782:         WITH loc_oPg.lbl_4c_LblCotacao
1783:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
1784:             .Top       = 581
1785:             .Left      = 161
1786:             .Width     = 42
1787:             .Height    = 15
1788:             .FontName  = "Tahoma"
1789:             .FontSize  = 8
1790:             .BackStyle = 0
1791:             .ForeColor = RGB(90, 90, 90)
1792:             .Visible   = .T.
1793:         ENDWITH
1794: 
1795:         loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
1796:         WITH loc_oPg.txt_4c_CotaCalcP
1797:             .Top           = 596
1798:             .Left          = 161
1799:             .Width         = 115
1800:             .Height        = 23
1801:             .FontName      = "Tahoma"
1802:             .FontSize      = 8
1803:             .Value         = 0.0
1804:             .SpecialEffect = 1
1805:             .ForeColor     = RGB(36, 84, 155)
1806:             .Enabled       = .F.
1807:             .Visible       = .T.
1808:         ENDWITH
1809:         BINDEVENT(loc_oPg.txt_4c_CotaCalcP, "LostFocus", THIS, "TxtCotaCalcPLostFocus")
1810: 
1811:         *----------------------------------------------------------------------
1812:         *-- Secao VENDA (controlada por chkLiberaVenda)
1813:         *-- lblMkpVenda: "MKP Ideal" T:504 L:324 W:49
1814:         *-- getMargem: T:517 L:323 W:89 H:23
1815:         *-- Say24: "Sts" T:542 L:324 W:17
1816:         *-- getStatus: T:557 L:324 W:31 H:23 (status lookup SigCdPst)
1817:         *-- lblMkpApl: "MKP Aplic." T:581 L:324 W:51
1818:         *-- getMarkupA: T:596 L:323 W:62 H:23
1819:         *-- Chk_Pvenda: T:595 L:387 W:25 H:25
1820:         *-- chkPlanVen: T:556 L:387 W:25 H:25
1821:         *-- Say14: "MKP" T:542 L:360 W:22
1822:         *-- Getftio: T:557 L:360 W:24 H:23 (MKP fator)
1823:         *-- lblIdeal: "Preco Ideal (Moeda 1)" T:503 L:416 W:111
1824:         *-- Say13: "Valor Adicional" T:542 L:416 W:71
1825:         *-- Get_Pftio: T:557 L:416 W:110 H:23 (fator adicional)
1826:         *-- getMoeda: T:517 L:529 W:31 H:23 (moeda venda ideal)
1827:         *-- Say12: "Fator" T:542 L:563 W:28
1828:         *-- Get_mftio: T:557 L:529 W:31 H:23 (moeda fator)
1829:         *-- getFIdeals: T:517 L:563 W:110 H:23
1830:         *-- getPvideal: T:517 L:416 W:110 H:23 (preco ideal)
1831:         *-- lblVenda: "Preco Atual (Moeda 2)" T:581 L:416 W:115
1832:         *-- getMoepv: T:557 L:677 W:31 H:23 (moeda preco venda)
1833:         *-- getMoev: T:596 L:529 W:31 H:23 (moeda venda)
1834:         *-- getFvenda: T:557 L:563 W:110 H:23 (fator venda)
1835:         *-- getPven: T:596 L:416 W:110 H:23 (preco venda)
1836:         *-- lblFIdeals: "Fator Ideal" T:503 L:563 W:55
1837:         *-- lblFAtuals: "Fator Atual" T:581 L:563 W:56
1838:         *-- getFAtuals: T:596 L:563 W:110 H:23
1839:         *-- Say25: "Financeiro" T:581 L:678 W:51
1840:         *-- Get_Encarg: T:595 L:678 W:62 H:23
1841:         *-- cmdCalcVals: T:507 L:678 W:40 H:40
1842:         *----------------------------------------------------------------------
1843: 
1844:         loc_oPg.AddObject("lbl_4c_LblMkpVenda", "Label")
1845:         WITH loc_oPg.lbl_4c_LblMkpVenda
1846:             .Caption   = "MKP Ideal"
1847:             .Top       = 504
1848:             .Left      = 324
1849:             .Width     = 49

*-- Linhas 1869 a 2147:
1869:             .Enabled       = .F.
1870:             .Visible       = .T.
1871:         ENDWITH
1872:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TxtMargemLostFocus")
1873: 
1874:         loc_oPg.AddObject("lbl_4c_LblSts", "Label")
1875:         WITH loc_oPg.lbl_4c_LblSts
1876:             .Caption   = "Sts"
1877:             .Top       = 542
1878:             .Left      = 324
1879:             .Width     = 17
1880:             .Height    = 15
1881:             .FontName  = "Tahoma"
1882:             .FontSize  = 8
1883:             .BackStyle = 0
1884:             .ForeColor = RGB(90, 90, 90)
1885:             .Visible   = .T.
1886:         ENDWITH
1887: 
1888:         loc_oPg.AddObject("txt_4c_GetStatus", "TextBox")
1889:         WITH loc_oPg.txt_4c_GetStatus
1890:             .Top           = 557
1891:             .Left          = 324
1892:             .Width         = 31
1893:             .Height        = 23
1894:             .FontName      = "Tahoma"
1895:             .FontSize      = 8
1896:             .MaxLength     = 5
1897:             .Value         = ""
1898:             .SpecialEffect = 1
1899:             .ForeColor     = RGB(36, 84, 155)
1900:             .Enabled       = .F.
1901:             .Visible       = .T.
1902:         ENDWITH
1903:         BINDEVENT(loc_oPg.txt_4c_GetStatus, "KeyPress",  THIS, "TxtGetStatusKeyPress")
1904:         BINDEVENT(loc_oPg.txt_4c_GetStatus, "LostFocus", THIS, "TxtGetStatusLostFocus")
1905: 
1906:         loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
1907:         WITH loc_oPg.lbl_4c_LblMkpApl
1908:             .Caption   = "MKP Aplic."
1909:             .Top       = 581
1910:             .Left      = 324
1911:             .Width     = 51
1912:             .Height    = 15
1913:             .FontName  = "Tahoma"
1914:             .FontSize  = 8
1915:             .BackStyle = 0
1916:             .ForeColor = RGB(90, 90, 90)
1917:             .Visible   = .T.
1918:         ENDWITH
1919: 
1920:         loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
1921:         WITH loc_oPg.txt_4c_MarkupA
1922:             .Top           = 596
1923:             .Left          = 323
1924:             .Width         = 62
1925:             .Height        = 23
1926:             .FontName      = "Tahoma"
1927:             .FontSize      = 8
1928:             .Value         = 0.0
1929:             .SpecialEffect = 1
1930:             .ForeColor     = RGB(36, 84, 155)
1931:             .Enabled       = .F.
1932:             .Visible       = .T.
1933:         ENDWITH
1934:         BINDEVENT(loc_oPg.txt_4c_MarkupA, "LostFocus", THIS, "TxtMarkupALostFocus")
1935: 
1936:         *-- Chk_Pvenda (T:595 L:387 W:25 H:25) - usa preco de venda atual
1937:         loc_oPg.AddObject("chk_4c_PVenda", "CheckBox")
1938:         WITH loc_oPg.chk_4c_PVenda
1939:             .Caption   = ""
1940:             .Top       = 595
1941:             .Left      = 387
1942:             .Width     = 25
1943:             .Height    = 25
1944:             .Value     = 0
1945:             .BackStyle = 0
1946:             .Themes    = .F.
1947:             .Enabled   = .F.
1948:             .Visible   = .T.
1949:         ENDWITH
1950:         BINDEVENT(loc_oPg.chk_4c_PVenda, "Click", THIS, "ChkPVendaClick")
1951: 
1952:         *-- chkPlanVen (T:556 L:387 W:25 H:25) - plano venda
1953:         loc_oPg.AddObject("chk_4c_PlanVen", "CheckBox")
1954:         WITH loc_oPg.chk_4c_PlanVen
1955:             .Caption   = ""
1956:             .Top       = 556
1957:             .Left      = 387
1958:             .Width     = 25
1959:             .Height    = 25
1960:             .Value     = 0
1961:             .BackStyle = 0
1962:             .Themes    = .F.
1963:             .Enabled   = .F.
1964:             .Visible   = .T.
1965:         ENDWITH
1966:         BINDEVENT(loc_oPg.chk_4c_PlanVen, "Click", THIS, "ChkPlanVenClick")
1967: 
1968:         loc_oPg.AddObject("lbl_4c_LblMkpFat", "Label")
1969:         WITH loc_oPg.lbl_4c_LblMkpFat
1970:             .Caption   = "MKP"
1971:             .Top       = 542
1972:             .Left      = 360
1973:             .Width     = 22
1974:             .Height    = 15
1975:             .FontName  = "Tahoma"
1976:             .FontSize  = 8
1977:             .BackStyle = 0
1978:             .ForeColor = RGB(90, 90, 90)
1979:             .Visible   = .T.
1980:         ENDWITH
1981: 
1982:         loc_oPg.AddObject("txt_4c_Getftio", "TextBox")
1983:         WITH loc_oPg.txt_4c_Getftio
1984:             .Top           = 557
1985:             .Left          = 360
1986:             .Width         = 24
1987:             .Height        = 23
1988:             .FontName      = "Tahoma"
1989:             .FontSize      = 8
1990:             .MaxLength     = 5
1991:             .Value         = ""
1992:             .SpecialEffect = 1
1993:             .ForeColor     = RGB(36, 84, 155)
1994:             .Enabled       = .F.
1995:             .Visible       = .T.
1996:         ENDWITH
1997:         BINDEVENT(loc_oPg.txt_4c_Getftio, "KeyPress",  THIS, "TxtGetftioKeyPress")
1998:         BINDEVENT(loc_oPg.txt_4c_Getftio, "LostFocus", THIS, "TxtGetftioLostFocus")
1999: 
2000:         loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
2001:         WITH loc_oPg.lbl_4c_LblIdeal
2002:             .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
2003:             .Top       = 503
2004:             .Left      = 416
2005:             .Width     = 111
2006:             .Height    = 15
2007:             .FontName  = "Tahoma"
2008:             .FontSize  = 8
2009:             .BackStyle = 0
2010:             .ForeColor = RGB(90, 90, 90)
2011:             .Visible   = .T.
2012:         ENDWITH
2013: 
2014:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
2015:         WITH loc_oPg.txt_4c_Pvideal
2016:             .Top           = 517
2017:             .Left          = 416
2018:             .Width         = 110
2019:             .Height        = 23
2020:             .FontName      = "Tahoma"
2021:             .FontSize      = 8
2022:             .Value         = 0.0
2023:             .SpecialEffect = 1
2024:             .ForeColor     = RGB(36, 84, 155)
2025:             .Enabled       = .F.
2026:             .Visible       = .T.
2027:         ENDWITH
2028:         BINDEVENT(loc_oPg.txt_4c_Pvideal, "LostFocus", THIS, "TxtPvidealLostFocus")
2029: 
2030:         loc_oPg.AddObject("lbl_4c_LblValAdicV", "Label")
2031:         WITH loc_oPg.lbl_4c_LblValAdicV
2032:             .Caption   = "Valor Adicional"
2033:             .Top       = 542
2034:             .Left      = 416
2035:             .Width     = 71
2036:             .Height    = 15
2037:             .FontName  = "Tahoma"
2038:             .FontSize  = 8
2039:             .BackStyle = 0
2040:             .ForeColor = RGB(90, 90, 90)
2041:             .Visible   = .T.
2042:         ENDWITH
2043: 
2044:         loc_oPg.AddObject("txt_4c_GetPftio", "TextBox")
2045:         WITH loc_oPg.txt_4c_GetPftio
2046:             .Top           = 557
2047:             .Left          = 416
2048:             .Width         = 110
2049:             .Height        = 23
2050:             .FontName      = "Tahoma"
2051:             .FontSize      = 8
2052:             .MaxLength     = 5
2053:             .Value         = ""
2054:             .SpecialEffect = 1
2055:             .ForeColor     = RGB(36, 84, 155)
2056:             .Enabled       = .F.
2057:             .Visible       = .T.
2058:         ENDWITH
2059: 
2060:         loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
2061:         WITH loc_oPg.txt_4c_Moeda
2062:             .Top           = 517
2063:             .Left          = 529
2064:             .Width         = 31
2065:             .Height        = 23
2066:             .FontName      = "Tahoma"
2067:             .FontSize      = 8
2068:             .MaxLength     = 5
2069:             .Value         = ""
2070:             .SpecialEffect = 1
2071:             .ForeColor     = RGB(36, 84, 155)
2072:             .Enabled       = .F.
2073:             .Visible       = .T.
2074:         ENDWITH
2075:         BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress",  THIS, "TxtMoedaKeyPress")
2076:         BINDEVENT(loc_oPg.txt_4c_Moeda, "LostFocus", THIS, "TxtMoedaLostFocus")
2077: 
2078:         loc_oPg.AddObject("lbl_4c_LblFatorI", "Label")
2079:         WITH loc_oPg.lbl_4c_LblFatorI
2080:             .Caption   = "Fator"
2081:             .Top       = 542
2082:             .Left      = 563
2083:             .Width     = 28
2084:             .Height    = 15
2085:             .FontName  = "Tahoma"
2086:             .FontSize  = 8
2087:             .BackStyle = 0
2088:             .ForeColor = RGB(90, 90, 90)
2089:             .Visible   = .T.
2090:         ENDWITH
2091: 
2092:         loc_oPg.AddObject("txt_4c_GetMftio", "TextBox")
2093:         WITH loc_oPg.txt_4c_GetMftio
2094:             .Top           = 557
2095:             .Left          = 529
2096:             .Width         = 31
2097:             .Height        = 23
2098:             .FontName      = "Tahoma"
2099:             .FontSize      = 8
2100:             .MaxLength     = 5
2101:             .Value         = ""
2102:             .SpecialEffect = 1
2103:             .ForeColor     = RGB(36, 84, 155)
2104:             .Enabled       = .F.
2105:             .Visible       = .T.
2106:         ENDWITH
2107:         BINDEVENT(loc_oPg.txt_4c_GetMftio, "LostFocus", THIS, "TxtGetMftioLostFocus")
2108: 
2109:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
2110:         WITH loc_oPg.lbl_4c_LblFIdeals
2111:             .Caption   = "Fator Ideal"
2112:             .Top       = 503
2113:             .Left      = 563
2114:             .Width     = 55
2115:             .Height    = 15
2116:             .FontName  = "Tahoma"
2117:             .FontSize  = 8
2118:             .BackStyle = 0
2119:             .ForeColor = RGB(90, 90, 90)
2120:             .Visible   = .T.
2121:         ENDWITH
2122: 
2123:         loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
2124:         WITH loc_oPg.txt_4c_FIdeals
2125:             .Top           = 517
2126:             .Left          = 563
2127:             .Width         = 110
2128:             .Height        = 23
2129:             .FontName      = "Tahoma"
2130:             .FontSize      = 8
2131:             .Value         = 0.0
2132:             .SpecialEffect = 1
2133:             .ForeColor     = RGB(36, 84, 155)
2134:             .Enabled       = .F.
2135:             .Visible       = .T.
2136:         ENDWITH
2137: 
2138:         loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
2139:         WITH loc_oPg.lbl_4c_LblVenda
2140:             .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
2141:             .Top       = 581
2142:             .Left      = 416
2143:             .Width     = 115
2144:             .Height    = 15
2145:             .FontName  = "Tahoma"
2146:             .FontSize  = 8
2147:             .BackStyle = 0

*-- Linhas 2164 a 2258:
2164:             .Enabled       = .F.
2165:             .Visible       = .T.
2166:         ENDWITH
2167:         BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress",  THIS, "TxtMoepvKeyPress")
2168:         BINDEVENT(loc_oPg.txt_4c_Moepv, "LostFocus", THIS, "TxtMoepvLostFocus")
2169: 
2170:         loc_oPg.AddObject("txt_4c_Moev", "TextBox")
2171:         WITH loc_oPg.txt_4c_Moev
2172:             .Top           = 596
2173:             .Left          = 529
2174:             .Width         = 31
2175:             .Height        = 23
2176:             .FontName      = "Tahoma"
2177:             .FontSize      = 8
2178:             .MaxLength     = 5
2179:             .Value         = ""
2180:             .SpecialEffect = 1
2181:             .ForeColor     = RGB(36, 84, 155)
2182:             .Enabled       = .F.
2183:             .Visible       = .T.
2184:         ENDWITH
2185:         BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress",  THIS, "TxtMoevKeyPress")
2186:         BINDEVENT(loc_oPg.txt_4c_Moev, "LostFocus", THIS, "TxtMoevLostFocus")
2187: 
2188:         loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
2189:         WITH loc_oPg.txt_4c_Fvenda
2190:             .Top           = 557
2191:             .Left          = 563
2192:             .Width         = 110
2193:             .Height        = 23
2194:             .FontName      = "Tahoma"
2195:             .FontSize      = 8
2196:             .Value         = 0.0
2197:             .SpecialEffect = 1
2198:             .ForeColor     = RGB(36, 84, 155)
2199:             .Enabled       = .F.
2200:             .Visible       = .T.
2201:         ENDWITH
2202:         BINDEVENT(loc_oPg.txt_4c_Fvenda, "LostFocus", THIS, "TxtFvendaLostFocus")
2203: 
2204:         loc_oPg.AddObject("txt_4c_Pven", "TextBox")
2205:         WITH loc_oPg.txt_4c_Pven
2206:             .Top           = 596
2207:             .Left          = 416
2208:             .Width         = 110
2209:             .Height        = 23
2210:             .FontName      = "Tahoma"
2211:             .FontSize      = 8
2212:             .Value         = 0.0
2213:             .SpecialEffect = 1
2214:             .ForeColor     = RGB(36, 84, 155)
2215:             .Enabled       = .F.
2216:             .Visible       = .T.
2217:         ENDWITH
2218:         BINDEVENT(loc_oPg.txt_4c_Pven, "LostFocus", THIS, "TxtPvenLostFocus")
2219: 
2220:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
2221:         WITH loc_oPg.lbl_4c_LblFAtuals
2222:             .Caption   = "Fator Atual"
2223:             .Top       = 581
2224:             .Left      = 563
2225:             .Width     = 56
2226:             .Height    = 15
2227:             .FontName  = "Tahoma"
2228:             .FontSize  = 8
2229:             .BackStyle = 0
2230:             .ForeColor = RGB(90, 90, 90)
2231:             .Visible   = .T.
2232:         ENDWITH
2233: 
2234:         loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
2235:         WITH loc_oPg.txt_4c_FAtuals
2236:             .Top           = 596
2237:             .Left          = 563
2238:             .Width         = 110
2239:             .Height        = 23
2240:             .FontName      = "Tahoma"
2241:             .FontSize      = 8
2242:             .Value         = 0.0
2243:             .SpecialEffect = 1
2244:             .ForeColor     = RGB(36, 84, 155)
2245:             .Enabled       = .F.
2246:             .Visible       = .T.
2247:         ENDWITH
2248: 
2249:         loc_oPg.AddObject("lbl_4c_LblFinanc", "Label")
2250:         WITH loc_oPg.lbl_4c_LblFinanc
2251:             .Caption   = "Financeiro"
2252:             .Top       = 581
2253:             .Left      = 678
2254:             .Width     = 51
2255:             .Height    = 15
2256:             .FontName  = "Tahoma"
2257:             .FontSize  = 8
2258:             .BackStyle = 0

*-- Linhas 2274 a 2336:
2274:             .Enabled       = .F.
2275:             .Visible       = .T.
2276:         ENDWITH
2277:         BINDEVENT(loc_oPg.txt_4c_GetEncarg, "LostFocus", THIS, "TxtGetEncargLostFocus")
2278: 
2279:         *-- cmdCalcVals (T:507 L:678 W:40 H:40) - calcular valores
2280:         loc_oPg.AddObject("cmd_4c_CalcVals", "CommandButton")
2281:         WITH loc_oPg.cmd_4c_CalcVals
2282:             .Caption     = "Calc."
2283:             .Top         = 507
2284:             .Left        = 678
2285:             .Width       = 40
2286:             .Height      = 40
2287:             .FontName    = "Tahoma"
2288:             .FontSize    = 7
2289:             .Themes      = .F.
2290:             .SpecialEffect = 0
2291:             .BackColor   = RGB(255, 255, 255)
2292:             .ForeColor   = RGB(90, 90, 90)
2293:             .Enabled     = .F.
2294:             .Visible     = .T.
2295:         ENDWITH
2296:         BINDEVENT(loc_oPg.cmd_4c_CalcVals, "Click", THIS, "CmdCalcValsClick")
2297: 
2298:         *----------------------------------------------------------------------
2299:         *-- Container cntMtPrima (T:511 L:752 W:242 H:108)
2300:         *-- Controles internos: Composicao, Montagem, Digitos, Ordem, Casas
2301:         *----------------------------------------------------------------------
2302:         loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
2303:         WITH loc_oPg.cnt_4c_MtPrima
2304:             .Top         = 511
2305:             .Left        = 752
2306:             .Width       = 242
2307:             .Height      = 108
2308:             .BackStyle   = 1
2309:             .BackColor   = RGB(240, 240, 240)
2310:             .BorderWidth = 1
2311:             .Visible     = .T.
2312:         ENDWITH
2313: 
2314:         *-- lblCompos: "Composicao :" T:1 L:6 W:66
2315:         loc_oPg.cnt_4c_MtPrima.AddObject("lbl_4c_LblCompos", "Label")
2316:         WITH loc_oPg.cnt_4c_MtPrima.lbl_4c_LblCompos
2317:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
2318:             .Top       = 1
2319:             .Left      = 6
2320:             .Width     = 66
2321:             .Height    = 15
2322:             .FontName  = "Tahoma"
2323:             .FontSize  = 8
2324:             .BackStyle = 0
2325:             .ForeColor = RGB(90, 90, 90)
2326:             .Visible   = .T.
2327:         ENDWITH
2328: 
2329:         *-- getCompos: T:18 L:6 W:233
2330:         loc_oPg.cnt_4c_MtPrima.AddObject("txt_4c_Compos", "TextBox")
2331:         WITH loc_oPg.cnt_4c_MtPrima.txt_4c_Compos
2332:             .Top           = 18
2333:             .Left          = 6
2334:             .Width         = 233
2335:             .Height        = 21
2336:             .FontName      = "Tahoma"

*-- Linhas 2468 a 3294:
2468: 
2469:     *==========================================================================
2470:     * FASE 9 - Handlers publicos da aba Composicao
2471:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
2472:     *==========================================================================
2473: 
2474:     *--------------------------------------------------------------------------
2475:     * GrdCompoAfterRowColChange - Atualiza Get_Desc e getObsOFs ao navegar
2476:     *--------------------------------------------------------------------------
2477:     PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
2478:         LOCAL loc_oPg
2479:         TRY
2480:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2481:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
2482:                 loc_oPg.txt_4c_Desc.Value  = ALLTRIM(cursor_4c_Compo.dcomps)
2483:                 loc_oPg.txt_4c_MatSub.Value = ALLTRIM(cursor_4c_Compo.matrizes)
2484:             ENDIF
2485:         CATCH TO loc_oErro
2486:             *-- silencioso: refresh de display nao deve bloquear navegacao
2487:         ENDTRY
2488:     ENDPROC
2489: 
2490:     *--------------------------------------------------------------------------
2491:     * GrdSubCpAfterRowColChange - Atualiza get_desccp e get_matsub ao navegar
2492:     *--------------------------------------------------------------------------
2493:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
2494:         LOCAL loc_oPg
2495:         TRY
2496:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2497:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
2498:                 loc_oPg.txt_4c_DescCp.Value  = ALLTRIM(cursor_4c_SubCp.dcomps)
2499:                 loc_oPg.txt_4c_MatSub.Value  = ALLTRIM(cursor_4c_SubCp.matrizes)
2500:             ENDIF
2501:         CATCH TO loc_oErro
2502:             *-- silencioso
2503:         ENDTRY
2504:     ENDPROC
2505: 
2506:     *--------------------------------------------------------------------------
2507:     * ChkLiberaCustoClick - Habilita/desabilita campos de custo
2508:     *--------------------------------------------------------------------------
2509:     PROCEDURE ChkLiberaCustoClick()
2510:         LOCAL loc_oPg, loc_lLivre
2511:         TRY
2512:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2513:             loc_lLivre = (loc_oPg.chk_4c_LiberaCusto.Value = 1) AND ;
2514:                          INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2515:             loc_oPg.txt_4c_Pcus.Enabled       = loc_lLivre
2516:             loc_oPg.txt_4c_Moec.Enabled        = loc_lLivre
2517:             loc_oPg.txt_4c_Fcusto.Enabled      = loc_lLivre
2518:             loc_oPg.txt_4c_Moepc.Enabled       = loc_lLivre
2519:             loc_oPg.txt_4c_Custof.Enabled      = loc_lLivre
2520:             loc_oPg.txt_4c_Moecusf.Enabled     = loc_lLivre
2521:             loc_oPg.txt_4c_GetCmkpc.Enabled    = loc_lLivre
2522:             loc_oPg.txt_4c_GetPftioc.Enabled   = loc_lLivre
2523:             loc_oPg.chk_4c_PlanCus.Enabled     = loc_lLivre
2524:             loc_oPg.txt_4c_Pesom.Enabled        = loc_lLivre
2525:             loc_oPg.cmd_4c_PesoM.Enabled        = loc_lLivre
2526:             loc_oPg.txt_4c_CotaCalcP.Enabled   = loc_lLivre
2527:         CATCH TO loc_oErro
2528:             MsgErro(loc_oErro.Message, "Erro ao alterar libera" + CHR(231) + CHR(227) + "o custo")
2529:         ENDTRY
2530:     ENDPROC
2531: 
2532:     *--------------------------------------------------------------------------
2533:     * ChkLiberaVendaClick - Habilita/desabilita campos de venda
2534:     *--------------------------------------------------------------------------
2535:     PROCEDURE ChkLiberaVendaClick()
2536:         LOCAL loc_oPg, loc_lLivre
2537:         TRY
2538:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2539:             loc_lLivre = (loc_oPg.chk_4c_LiberaVenda.Value = 1) AND ;
2540:                          INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2541:             loc_oPg.txt_4c_Margem.Enabled      = loc_lLivre
2542:             loc_oPg.txt_4c_GetStatus.Enabled   = loc_lLivre
2543:             loc_oPg.txt_4c_MarkupA.Enabled     = loc_lLivre
2544:             loc_oPg.chk_4c_PVenda.Enabled      = loc_lLivre
2545:             loc_oPg.chk_4c_PlanVen.Enabled     = loc_lLivre
2546:             loc_oPg.txt_4c_Getftio.Enabled     = loc_lLivre
2547:             loc_oPg.txt_4c_Pvideal.Enabled     = loc_lLivre
2548:             loc_oPg.txt_4c_Moeda.Enabled        = loc_lLivre
2549:             loc_oPg.txt_4c_GetPftio.Enabled    = loc_lLivre
2550:             loc_oPg.txt_4c_GetMftio.Enabled    = loc_lLivre
2551:             loc_oPg.txt_4c_FIdeals.Enabled     = loc_lLivre
2552:             loc_oPg.txt_4c_Moepv.Enabled        = loc_lLivre
2553:             loc_oPg.txt_4c_Moev.Enabled         = loc_lLivre
2554:             loc_oPg.txt_4c_Fvenda.Enabled       = loc_lLivre
2555:             loc_oPg.txt_4c_Pven.Enabled         = loc_lLivre
2556:             loc_oPg.txt_4c_FAtuals.Enabled      = loc_lLivre
2557:             loc_oPg.txt_4c_GetEncarg.Enabled    = loc_lLivre
2558:         CATCH TO loc_oErro
2559:             MsgErro(loc_oErro.Message, "Erro ao alterar libera" + CHR(231) + CHR(227) + "o venda")
2560:         ENDTRY
2561:     ENDPROC
2562: 
2563:     *--------------------------------------------------------------------------
2564:     * CmdInserirCompoClick - Adiciona nova linha na composicao
2565:     *--------------------------------------------------------------------------
2566:     PROCEDURE CmdInserirCompoClick()
2567:         TRY
2568:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2569:                 RETURN
2570:             ENDIF
2571:             IF USED("cursor_4c_Compo")
2572:                 SELECT cursor_4c_Compo
2573:                 APPEND BLANK
2574:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2575:             ENDIF
2576:         CATCH TO loc_oErro
2577:             MsgErro(loc_oErro.Message, "Erro ao inserir componente")
2578:         ENDTRY
2579:     ENDPROC
2580: 
2581:     *--------------------------------------------------------------------------
2582:     * CmdExcluirCompoClick - Remove linha da composicao
2583:     *--------------------------------------------------------------------------
2584:     PROCEDURE CmdExcluirCompoClick()
2585:         LOCAL loc_lConfirma
2586:         TRY
2587:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2588:                 RETURN
2589:             ENDIF
2590:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
2591:                 loc_lConfirma = MsgConfirma("Excluir componente selecionado?")
2592:                 IF loc_lConfirma
2593:                     SELECT cursor_4c_Compo
2594:                     DELETE
2595:                     IF !EOF()
2596:                         SKIP
2597:                         SKIP -1
2598:                     ENDIF
2599:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2600:                 ENDIF
2601:             ENDIF
2602:         CATCH TO loc_oErro
2603:             MsgErro(loc_oErro.Message, "Erro ao excluir componente")
2604:         ENDTRY
2605:     ENDPROC
2606: 
2607:     *--------------------------------------------------------------------------
2608:     * CmdCalcFornecClick - Recalcula precos de custo via fornecedor
2609:     *--------------------------------------------------------------------------
2610:     PROCEDURE CmdCalcFornecClick()
2611:         TRY
2612:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2613:                 RETURN
2614:             ENDIF
2615:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2616:                 THIS.this_oBusinessObject.CalcFornec()
2617:             ENDIF
2618:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2619:         CATCH TO loc_oErro
2620:             MsgErro(loc_oErro.Message, "Erro ao calcular por fornecedor")
2621:         ENDTRY
2622:     ENDPROC
2623: 
2624:     *--------------------------------------------------------------------------
2625:     * CmdAtualizarCompoClick - Atualiza composicao (recalcula totais/grupos)
2626:     *--------------------------------------------------------------------------
2627:     PROCEDURE CmdAtualizarCompoClick()
2628:         TRY
2629:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2630:                 RETURN
2631:             ENDIF
2632:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2633:                 THIS.this_oBusinessObject.AtualizarComposicao()
2634:             ENDIF
2635:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2636:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Grupo.Refresh()
2637:         CATCH TO loc_oErro
2638:             MsgErro(loc_oErro.Message, "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o")
2639:         ENDTRY
2640:     ENDPROC
2641: 
2642:     *--------------------------------------------------------------------------
2643:     * CmdAtualizarPesosClick - Atualiza pesos medios dos componentes
2644:     *--------------------------------------------------------------------------
2645:     PROCEDURE CmdAtualizarPesosClick()
2646:         TRY
2647:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2648:                 THIS.this_oBusinessObject.AtualizarPesos()
2649:             ENDIF
2650:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2651:         CATCH TO loc_oErro
2652:             MsgErro(loc_oErro.Message, "Erro ao atualizar pesos")
2653:         ENDTRY
2654:     ENDPROC
2655: 
2656:     *--------------------------------------------------------------------------
2657:     * CmdInserirSubCpClick - Adiciona linha no grid de sub-componentes
2658:     *--------------------------------------------------------------------------
2659:     PROCEDURE CmdInserirSubCpClick()
2660:         TRY
2661:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2662:                 RETURN
2663:             ENDIF
2664:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo") AND ;
2665:                !EMPTY(cursor_4c_Compo.mats)
2666:                 IF USED("cursor_4c_SubCp")
2667:                     SELECT cursor_4c_SubCp
2668:                     APPEND BLANK
2669:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2670:                 ENDIF
2671:             ELSE
2672:                 MsgAviso("Selecione um componente antes de adicionar sub-componente.")
2673:             ENDIF
2674:         CATCH TO loc_oErro
2675:             MsgErro(loc_oErro.Message, "Erro ao inserir sub-componente")
2676:         ENDTRY
2677:     ENDPROC
2678: 
2679:     *--------------------------------------------------------------------------
2680:     * CmdExcluirSubCpClick - Remove linha do grid de sub-componentes
2681:     *--------------------------------------------------------------------------
2682:     PROCEDURE CmdExcluirSubCpClick()
2683:         LOCAL loc_lConfirma
2684:         TRY
2685:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2686:                 RETURN
2687:             ENDIF
2688:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
2689:                 loc_lConfirma = MsgConfirma("Excluir sub-componente selecionado?")
2690:                 IF loc_lConfirma
2691:                     SELECT cursor_4c_SubCp
2692:                     DELETE
2693:                     IF !EOF()
2694:                         SKIP
2695:                         SKIP -1
2696:                     ENDIF
2697:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2698:                 ENDIF
2699:             ENDIF
2700:         CATCH TO loc_oErro
2701:             MsgErro(loc_oErro.Message, "Erro ao excluir sub-componente")
2702:         ENDTRY
2703:     ENDPROC
2704: 
2705:     *--------------------------------------------------------------------------
2706:     * CmdCalcValsClick - Calcular valores de preco/custo/venda
2707:     *--------------------------------------------------------------------------
2708:     PROCEDURE CmdCalcValsClick()
2709:         TRY
2710:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2711:                 THIS.this_oBusinessObject.CalcVals()
2712:             ENDIF
2713:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Refresh()
2714:         CATCH TO loc_oErro
2715:             MsgErro(loc_oErro.Message, "Erro ao calcular valores")
2716:         ENDTRY
2717:     ENDPROC
2718: 
2719:     *--------------------------------------------------------------------------
2720:     * CmdPesoMClick - Atualizar peso medio do produto
2721:     *--------------------------------------------------------------------------
2722:     PROCEDURE CmdPesoMClick()
2723:         TRY
2724:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2725:                 THIS.this_oBusinessObject.AtualizarPesoMedio()
2726:             ENDIF
2727:         CATCH TO loc_oErro
2728:             MsgErro(loc_oErro.Message, "Erro ao atualizar peso m" + CHR(233) + "dio")
2729:         ENDTRY
2730:     ENDPROC
2731: 
2732:     *--------------------------------------------------------------------------
2733:     * ChkPlanCusClick - Plano de custo
2734:     *--------------------------------------------------------------------------
2735:     PROCEDURE ChkPlanCusClick()
2736:         *-- chkPlanCus.Valid: If Value=1, Do Form SigOpPcu With ThisForm,'C'
2737:         *-- Na migracao: exibe mensagem de funcionalidade em desenvolvimento
2738:         TRY
2739:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.chk_4c_PlanCus.Value = 0
2740:         CATCH TO loc_oErro
2741:             *-- silencioso
2742:         ENDTRY
2743:     ENDPROC
2744: 
2745:     *--------------------------------------------------------------------------
2746:     * ChkPVendaClick - Usar preco de venda atual no calculo
2747:     *--------------------------------------------------------------------------
2748:     PROCEDURE ChkPVendaClick()
2749:         *-- chkPVenda.Click: recalcular
2750:         TRY
2751:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2752:                 THIS.this_oBusinessObject.CalcPreco()
2753:             ENDIF
2754:         CATCH TO loc_oErro
2755:             MsgErro(loc_oErro.Message, "Erro ao calcular pre" + CHR(231) + "o")
2756:         ENDTRY
2757:     ENDPROC
2758: 
2759:     *--------------------------------------------------------------------------
2760:     * ChkPlanVenClick - Plano de venda
2761:     *--------------------------------------------------------------------------
2762:     PROCEDURE ChkPlanVenClick()
2763:         *-- chkPlanVen.Valid: If Value=1, Do Form SigOpPcu With ThisForm,'V'
2764:         TRY
2765:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.chk_4c_PlanVen.Value = 0
2766:         CATCH TO loc_oErro
2767:             *-- silencioso
2768:         ENDTRY
2769:     ENDPROC
2770: 
2771:     *--------------------------------------------------------------------------
2772:     * Moeda lookups F4 para todos os campos de moeda da aba Composicao
2773:     *--------------------------------------------------------------------------
2774:     PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2775:         IF par_nKeyCode = 115 && F4
2776:             THIS.AbrirLookupMoedaCompo("txt_4c_Moec")
2777:         ENDIF
2778:     ENDPROC
2779: 
2780:     PROCEDURE TxtMoecLostFocus()
2781:         THIS.ValidarMoedaCompo("txt_4c_Moec")
2782:     ENDPROC
2783: 
2784:     PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2785:         IF par_nKeyCode = 115 && F4
2786:             THIS.AbrirLookupMoedaCompo("txt_4c_Moepc")
2787:         ENDIF
2788:     ENDPROC
2789: 
2790:     PROCEDURE TxtMoepcLostFocus()
2791:         THIS.ValidarMoedaCompo("txt_4c_Moepc")
2792:         THIS.CalcPrecoCompo()
2793:     ENDPROC
2794: 
2795:     PROCEDURE TxtMoecusfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2796:         IF par_nKeyCode = 115 && F4
2797:             THIS.AbrirLookupMoedaCompo("txt_4c_Moecusf")
2798:         ENDIF
2799:     ENDPROC
2800: 
2801:     PROCEDURE TxtMoecusfLostFocus()
2802:         THIS.ValidarMoedaCompo("txt_4c_Moecusf")
2803:         THIS.CalcPrecoCompo()
2804:     ENDPROC
2805: 
2806:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2807:         IF par_nKeyCode = 115 && F4
2808:             THIS.AbrirLookupMoedaCompo("txt_4c_Moeda")
2809:         ENDIF
2810:     ENDPROC
2811: 
2812:     PROCEDURE TxtMoedaLostFocus()
2813:         THIS.ValidarMoedaCompo("txt_4c_Moeda")
2814:         THIS.CalcPrecoCompo()
2815:     ENDPROC
2816: 
2817:     PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2818:         IF par_nKeyCode = 115 && F4
2819:             THIS.AbrirLookupMoedaCompo("txt_4c_Moepv")
2820:         ENDIF
2821:     ENDPROC
2822: 
2823:     PROCEDURE TxtMoepvLostFocus()
2824:         THIS.ValidarMoedaCompo("txt_4c_Moepv")
2825:     ENDPROC
2826: 
2827:     PROCEDURE TxtMoevKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2828:         IF par_nKeyCode = 115 && F4
2829:             THIS.AbrirLookupMoedaCompo("txt_4c_Moev")
2830:         ENDIF
2831:     ENDPROC
2832: 
2833:     PROCEDURE TxtMoevLostFocus()
2834:         THIS.ValidarMoedaCompo("txt_4c_Moev")
2835:     ENDPROC
2836: 
2837:     *--------------------------------------------------------------------------
2838:     * AbrirLookupMoedaCompo - Abre FormBuscaAuxiliar para SigCdMoe
2839:     *--------------------------------------------------------------------------
2840:     PROCEDURE AbrirLookupMoedaCompo(par_cCampo)
2841:         LOCAL loc_oPg, loc_oBusca, loc_cAtual, loc_oCtrl
2842:         TRY
2843:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2844:             loc_oCtrl  = EVALUATE("loc_oPg." + par_cCampo)
2845:             loc_cAtual = ALLTRIM(loc_oCtrl.Value)
2846: 
2847:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2848:                 "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cAtual, ;
2849:                 "Buscar Moeda")
2850:             IF VARTYPE(loc_oBusca) = "O"
2851:                 IF !loc_oBusca.this_lAchouRegistro
2852:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
2853:                     loc_oBusca.mAddColuna("DMoes", "", "Moeda")
2854:                     loc_oBusca.Show()
2855:                 ENDIF
2856:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2857:                     loc_oCtrl.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2858:                 ENDIF
2859:                 loc_oBusca.Release()
2860:             ENDIF
2861:             IF USED("cursor_4c_BuscaMoe")
2862:                 USE IN cursor_4c_BuscaMoe
2863:             ENDIF
2864:         CATCH TO loc_oErro
2865:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
2866:         ENDTRY
2867:     ENDPROC
2868: 
2869:     *--------------------------------------------------------------------------
2870:     * ValidarMoedaCompo - Valida codigo de moeda via SQLEXEC
2871:     *--------------------------------------------------------------------------
2872:     PROCEDURE ValidarMoedaCompo(par_cCampo)
2873:         LOCAL loc_oPg, loc_oCtrl, loc_cMoe, loc_nRet
2874:         TRY
2875:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
2876:                 RETURN
2877:             ENDIF
2878:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2879:             loc_oCtrl = EVALUATE("loc_oPg." + par_cCampo)
2880:             loc_cMoe  = ALLTRIM(loc_oCtrl.Value)
2881:             IF EMPTY(loc_cMoe)
2882:                 RETURN
2883:             ENDIF
2884:             loc_nRet = SQLEXEC(gnConnHandle, ;
2885:                 "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoe), ;
2886:                 "cursor_4c_TmpMoe")
2887:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpMoe") < 1
2888:                 MsgAviso("Moeda '" + loc_cMoe + "' n" + CHR(227) + "o encontrada!")
2889:                 loc_oCtrl.Value = ""
2890:             ENDIF
2891:             IF USED("cursor_4c_TmpMoe")
2892:                 USE IN cursor_4c_TmpMoe
2893:             ENDIF
2894:         CATCH TO loc_oErro
2895:             MsgErro(loc_oErro.Message, "Erro ao validar moeda")
2896:         ENDTRY
2897:     ENDPROC
2898: 
2899:     *--------------------------------------------------------------------------
2900:     * CalcPrecoCompo - Chama calculo de preco pelo BO
2901:     *--------------------------------------------------------------------------
2902:     PROCEDURE CalcPrecoCompo()
2903:         TRY
2904:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2905:                 THIS.this_oBusinessObject.CalcPreco()
2906:             ENDIF
2907:         CATCH TO loc_oErro
2908:             MsgErro(loc_oErro.Message, "Erro ao calcular pre" + CHR(231) + "o")
2909:         ENDTRY
2910:     ENDPROC
2911: 
2912:     *--------------------------------------------------------------------------
2913:     * TxtPcusLostFocus - Recalcular ao sair do preco de custo
2914:     *--------------------------------------------------------------------------
2915:     PROCEDURE TxtPcusLostFocus()
2916:         THIS.CalcPrecoCompo()
2917:     ENDPROC
2918: 
2919:     *--------------------------------------------------------------------------
2920:     * TxtFcustoLostFocus - Recalcular ao sair do fator de custo
2921:     *--------------------------------------------------------------------------
2922:     PROCEDURE TxtFcustoLostFocus()
2923:         THIS.CalcPrecoCompo()
2924:     ENDPROC
2925: 
2926:     *--------------------------------------------------------------------------
2927:     * TxtCustofLostFocus - Recalcular ao sair do custo total
2928:     *--------------------------------------------------------------------------
2929:     PROCEDURE TxtCustofLostFocus()
2930:         THIS.CalcPrecoCompo()
2931:     ENDPROC
2932: 
2933:     *--------------------------------------------------------------------------
2934:     * TxtGetCmkpcKeyPress / LostFocus - MKP custo (F4 = lookup SigPrFti)
2935:     *--------------------------------------------------------------------------
2936:     PROCEDURE TxtGetCmkpcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2937:         IF par_nKeyCode = 115 && F4
2938:             THIS.AbrirLookupFtioCusto()
2939:         ENDIF
2940:     ENDPROC
2941: 
2942:     PROCEDURE TxtGetCmkpcLostFocus()
2943:         THIS.CalcPrecoCompo()
2944:     ENDPROC
2945: 
2946:     PROCEDURE AbrirLookupFtioCusto()
2947:         LOCAL loc_oPg, loc_oBusca, loc_cAtual, loc_nRet
2948:         TRY
2949:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
2950:                 RETURN
2951:             ENDIF
2952:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2953:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_GetCmkpc.Value)
2954:             loc_nRet = SQLEXEC(gnConnHandle, ;
2955:                 "SELECT Cods, Descs, Moedas, Valors, TpFtios FROM SigPrFti WHERE Tipos = 1", ;
2956:                 "cursor_4c_ListaFtioCusto")
2957:             IF loc_nRet > 0
2958:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2959:                     "SigPrFti", "cursor_4c_BuscaFtioCusto", "Cods", loc_cAtual, ;
2960:                     "Fator de Custo")
2961:                 IF VARTYPE(loc_oBusca) = "O"
2962:                     IF !loc_oBusca.this_lAchouRegistro
2963:                         loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "d.")
2964:                         loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2965:                         loc_oBusca.mAddColuna("Moedas", "", "Moeda")
2966:                         loc_oBusca.Show()
2967:                     ENDIF
2968:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioCusto")
2969:                         loc_oPg.txt_4c_GetCmkpc.Value = ALLTRIM(cursor_4c_BuscaFtioCusto.Cods)
2970:                     ENDIF
2971:                     loc_oBusca.Release()
2972:                 ENDIF
2973:                 IF USED("cursor_4c_BuscaFtioCusto")
2974:                     USE IN cursor_4c_BuscaFtioCusto
2975:                 ENDIF
2976:             ENDIF
2977:             IF USED("cursor_4c_ListaFtioCusto")
2978:                 USE IN cursor_4c_ListaFtioCusto
2979:             ENDIF
2980:         CATCH TO loc_oErro
2981:             MsgErro(loc_oErro.Message, "Erro ao buscar fator de custo")
2982:         ENDTRY
2983:     ENDPROC
2984: 
2985:     *--------------------------------------------------------------------------
2986:     * TxtGetPftiocKeyPress / LostFocus - Fator adicional custo
2987:     *--------------------------------------------------------------------------
2988:     PROCEDURE TxtGetPftiocKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2989:         IF par_nKeyCode = 115 && F4
2990:             THIS.AbrirLookupFtioCusto()
2991:         ENDIF
2992:     ENDPROC
2993: 
2994:     PROCEDURE TxtGetPftiocLostFocus()
2995:         THIS.CalcPrecoCompo()
2996:     ENDPROC
2997: 
2998:     *--------------------------------------------------------------------------
2999:     * TxtPesomLostFocus - Recalcular ao sair do peso medio
3000:     *--------------------------------------------------------------------------
3001:     PROCEDURE TxtPesomLostFocus()
3002:         THIS.CalcPrecoCompo()
3003:     ENDPROC
3004: 
3005:     *--------------------------------------------------------------------------
3006:     * TxtCotaCalcPLostFocus - Recalcular ao sair da cotacao
3007:     *--------------------------------------------------------------------------
3008:     PROCEDURE TxtCotaCalcPLostFocus()
3009:         THIS.CalcPrecoCompo()
3010:     ENDPROC
3011: 
3012:     *--------------------------------------------------------------------------
3013:     * TxtGetftioKeyPress / LostFocus - MKP Fator venda (F4 = lookup SigPrFti)
3014:     *--------------------------------------------------------------------------
3015:     PROCEDURE TxtGetftioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3016:         IF par_nKeyCode = 115 && F4
3017:             THIS.AbrirLookupFtioVenda()
3018:         ENDIF
3019:     ENDPROC
3020: 
3021:     PROCEDURE TxtGetftioLostFocus()
3022:         THIS.CalcPrecoCompo()
3023:     ENDPROC
3024: 
3025:     PROCEDURE AbrirLookupFtioVenda()
3026:         LOCAL loc_oPg, loc_oBusca, loc_cAtual, loc_nRet
3027:         TRY
3028:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
3029:                 RETURN
3030:             ENDIF
3031:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3032:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Getftio.Value)
3033:             loc_nRet = SQLEXEC(gnConnHandle, ;
3034:                 "SELECT Cods, Descs FROM SigPrFti", ;
3035:                 "cursor_4c_ListaFtioVenda")
3036:             IF loc_nRet > 0
3037:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3038:                     "SigPrFti", "cursor_4c_BuscaFtioVenda", "Cods", loc_cAtual, ;
3039:                     "Fator de Venda")
3040:                 IF VARTYPE(loc_oBusca) = "O"
3041:                     IF !loc_oBusca.this_lAchouRegistro
3042:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3043:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3044:                         loc_oBusca.Show()
3045:                     ENDIF
3046:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioVenda")
3047:                         loc_oPg.txt_4c_Getftio.Value = ALLTRIM(cursor_4c_BuscaFtioVenda.Cods)
3048:                     ENDIF
3049:                     loc_oBusca.Release()
3050:                 ENDIF
3051:                 IF USED("cursor_4c_BuscaFtioVenda")
3052:                     USE IN cursor_4c_BuscaFtioVenda
3053:                 ENDIF
3054:             ENDIF
3055:             IF USED("cursor_4c_ListaFtioVenda")
3056:                 USE IN cursor_4c_ListaFtioVenda
3057:             ENDIF
3058:         CATCH TO loc_oErro
3059:             MsgErro(loc_oErro.Message, "Erro ao buscar fator de venda")
3060:         ENDTRY
3061:     ENDPROC
3062: 
3063:     *--------------------------------------------------------------------------
3064:     * TxtMargemLostFocus - Recalcular ao sair da margem
3065:     *--------------------------------------------------------------------------
3066:     PROCEDURE TxtMargemLostFocus()
3067:         THIS.CalcPrecoCompo()
3068:     ENDPROC
3069: 
3070:     *--------------------------------------------------------------------------
3071:     * TxtPvidealLostFocus - Recalcular ao sair do preco ideal
3072:     *--------------------------------------------------------------------------
3073:     PROCEDURE TxtPvidealLostFocus()
3074:         THIS.CalcPrecoCompo()
3075:     ENDPROC
3076: 
3077:     *--------------------------------------------------------------------------
3078:     * TxtGetStatusKeyPress / LostFocus - Status do produto (F4 = lookup SigCdPst)
3079:     *--------------------------------------------------------------------------
3080:     PROCEDURE TxtGetStatusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3081:         IF par_nKeyCode = 115 && F4
3082:             THIS.AbrirLookupStatusCompo()
3083:         ENDIF
3084:     ENDPROC
3085: 
3086:     PROCEDURE TxtGetStatusLostFocus()
3087:         LOCAL loc_oPg, loc_cSts, loc_nRet
3088:         TRY
3089:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
3090:                 RETURN
3091:             ENDIF
3092:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3093:             loc_cSts = ALLTRIM(loc_oPg.txt_4c_GetStatus.Value)
3094:             IF EMPTY(loc_cSts)
3095:                 RETURN
3096:             ENDIF
3097:             loc_nRet = SQLEXEC(gnConnHandle, ;
3098:                 "SELECT Cods FROM SigCdPst WHERE Cods = " + EscaparSQL(loc_cSts), ;
3099:                 "cursor_4c_TmpSts")
3100:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpSts") < 1
3101:                 MsgAviso("Status '" + loc_cSts + "' n" + CHR(227) + "o encontrado!")
3102:                 loc_oPg.txt_4c_GetStatus.Value = ""
3103:             ENDIF
3104:             IF USED("cursor_4c_TmpSts")
3105:                 USE IN cursor_4c_TmpSts
3106:             ENDIF
3107:         CATCH TO loc_oErro
3108:             MsgErro(loc_oErro.Message, "Erro ao validar status")
3109:         ENDTRY
3110:     ENDPROC
3111: 
3112:     PROCEDURE AbrirLookupStatusCompo()
3113:         LOCAL loc_oPg, loc_oBusca, loc_cAtual
3114:         TRY
3115:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3116:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_GetStatus.Value)
3117:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3118:                 "SigCdPst", "cursor_4c_BuscaSts", "Cods", loc_cAtual, ;
3119:                 "Buscar Status")
3120:             IF VARTYPE(loc_oBusca) = "O"
3121:                 IF !loc_oBusca.this_lAchouRegistro
3122:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3123:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3124:                     loc_oBusca.Show()
3125:                 ENDIF
3126:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSts")
3127:                     loc_oPg.txt_4c_GetStatus.Value = ALLTRIM(cursor_4c_BuscaSts.Cods)
3128:                 ENDIF
3129:                 loc_oBusca.Release()
3130:             ENDIF
3131:             IF USED("cursor_4c_BuscaSts")
3132:                 USE IN cursor_4c_BuscaSts
3133:             ENDIF
3134:         CATCH TO loc_oErro
3135:             MsgErro(loc_oErro.Message, "Erro ao buscar status")
3136:         ENDTRY
3137:     ENDPROC
3138: 
3139:     *--------------------------------------------------------------------------
3140:     * TxtMarkupALostFocus - Recalcular ao sair do markup aplicado
3141:     *--------------------------------------------------------------------------
3142:     PROCEDURE TxtMarkupALostFocus()
3143:         THIS.CalcPrecoCompo()
3144:     ENDPROC
3145: 
3146:     *--------------------------------------------------------------------------
3147:     * TxtFvendaLostFocus - Recalcular ao sair do fator de venda
3148:     *--------------------------------------------------------------------------
3149:     PROCEDURE TxtFvendaLostFocus()
3150:         THIS.CalcPrecoCompo()
3151:     ENDPROC
3152: 
3153:     *--------------------------------------------------------------------------
3154:     * TxtPvenLostFocus - Recalcular ao sair do preco de venda
3155:     *--------------------------------------------------------------------------
3156:     PROCEDURE TxtPvenLostFocus()
3157:         THIS.CalcPrecoCompo()
3158:     ENDPROC
3159: 
3160:     *--------------------------------------------------------------------------
3161:     * TxtGetMftioLostFocus - Recalcular ao sair do fator moeda
3162:     *--------------------------------------------------------------------------
3163:     PROCEDURE TxtGetMftioLostFocus()
3164:         THIS.CalcPrecoCompo()
3165:     ENDPROC
3166: 
3167:     *--------------------------------------------------------------------------
3168:     * TxtGetEncargLostFocus - Validar valor financeiro (encargos)
3169:     *--------------------------------------------------------------------------
3170:     PROCEDURE TxtGetEncargLostFocus()
3171:         LOCAL loc_oPg
3172:         TRY
3173:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3174:             IF loc_oPg.txt_4c_GetEncarg.Value < 0
3175:                 MsgAviso("Valor inv" + CHR(225) + "lido!")
3176:                 loc_oPg.txt_4c_GetEncarg.Value = 0
3177:             ENDIF
3178:         CATCH TO loc_oErro
3179:             MsgErro(loc_oErro.Message, "Erro ao validar encargo")
3180:         ENDTRY
3181:     ENDPROC
3182: 
3183:     *--------------------------------------------------------------------------
3184:     * TxtMatPKeyPress / LostFocus - Material Principal (F4 = lookup SigCdPro)
3185:     *--------------------------------------------------------------------------
3186:     PROCEDURE TxtMatPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3187:         IF par_nKeyCode = 115 && F4
3188:             THIS.AbrirLookupMatP()
3189:         ENDIF
3190:     ENDPROC
3191: 
3192:     PROCEDURE TxtMatPLostFocus()
3193:         LOCAL loc_oPg, loc_cMatP, loc_nRet
3194:         TRY
3195:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
3196:                 RETURN
3197:             ENDIF
3198:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3199:             loc_cMatP = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
3200:             IF EMPTY(loc_cMatP)
3201:                 loc_oPg.txt_4c_Desc.Value = ""
3202:                 RETURN
3203:             ENDIF
3204:             loc_nRet = SQLEXEC(gnConnHandle, ;
3205:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cMatP), ;
3206:                 "cursor_4c_TmpMatP")
3207:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpMatP") > 0
3208:                 loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_TmpMatP.dpros)
3209:             ELSE
3210:                 MsgAviso("Produto '" + loc_cMatP + "' n" + CHR(227) + "o encontrado!")
3211:                 loc_oPg.txt_4c_MatP.Value = ""
3212:                 loc_oPg.txt_4c_Desc.Value = ""
3213:             ENDIF
3214:             IF USED("cursor_4c_TmpMatP")
3215:                 USE IN cursor_4c_TmpMatP
3216:             ENDIF
3217:         CATCH TO loc_oErro
3218:             MsgErro(loc_oErro.Message, "Erro ao validar material principal")
3219:         ENDTRY
3220:     ENDPROC
3221: 
3222:     PROCEDURE AbrirLookupMatP()
3223:         LOCAL loc_oPg, loc_oBusca, loc_cAtual
3224:         TRY
3225:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3226:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
3227:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3228:                 "SigCdPro", "cursor_4c_BuscaMatP", "cpros", loc_cAtual, ;
3229:                 "Buscar Material Principal")
3230:             IF VARTYPE(loc_oBusca) = "O"
3231:                 IF !loc_oBusca.this_lAchouRegistro
3232:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
3233:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3234:                     loc_oBusca.Show()
3235:                 ENDIF
3236:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatP")
3237:                     loc_oPg.txt_4c_MatP.Value  = ALLTRIM(cursor_4c_BuscaMatP.cpros)
3238:                     loc_oPg.txt_4c_Desc.Value  = ALLTRIM(cursor_4c_BuscaMatP.dpros)
3239:                 ENDIF
3240:                 loc_oBusca.Release()
3241:             ENDIF
3242:             IF USED("cursor_4c_BuscaMatP")
3243:                 USE IN cursor_4c_BuscaMatP
3244:             ENDIF
3245:         CATCH TO loc_oErro
3246:             MsgErro(loc_oErro.Message, "Erro ao buscar material principal")
3247:         ENDTRY
3248:     ENDPROC
3249: 
3250:     *--------------------------------------------------------------------------
3251:     * CarregarLista - Carrega registros no grid usando filtros da UI
3252:     * Legado: fCarregaGrade() leia cntFiltros.getCgru/optFilSituas
3253:     *--------------------------------------------------------------------------
3254:     PROCEDURE CarregarLista()
3255:         LOCAL loc_lResultado, loc_cFiltro, loc_oPagina
3256:         LOCAL loc_cCgru, loc_nSitI, loc_nSitF, loc_oGrid
3257:         loc_lResultado = .F.
3258: 
3259:         *-- Guard: pular se validando UI (sem conexao SQL)
3260:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3261:             RETURN .T.
3262:         ENDIF
3263: 
3264:         TRY
3265:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
3266: 
3267:             *-- Capturar filtros da UI (com guard de existencia)
3268:             loc_cCgru = ""
3269:             loc_nSitI = 1
3270:             loc_nSitF = 2
3271: 
3272:             IF VARTYPE(loc_oPagina.cnt_4c_Filtros) = "O"
3273:                 loc_cCgru = ALLTRIM(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value)
3274: 
3275:                 *-- optFilSituas: 1=Todos, 2=Ativos(situas=1), 3=Inativos(situas=2)
3276:                 loc_nSitI = IIF(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas.Value = 3, 2, 1)
3277:                 loc_nSitF = IIF(loc_oPagina.cnt_4c_Filtros.opt_4c_Situas.Value = 2, 1, 2)
3278:             ENDIF
3279: 
3280:             *-- Construir WHERE clause
3281:             loc_cFiltro = "situas BETWEEN " + TRANSFORM(loc_nSitI) + " AND " + TRANSFORM(loc_nSitF)
3282:             IF !EMPTY(loc_cCgru)
3283:                 loc_cFiltro = loc_cFiltro + " AND cgrus = " + EscaparSQL(loc_cCgru)
3284:             ENDIF
3285: 
3286:             *-- Buscar dados via BO (ZAP+APPEND preserva estrutura do cursor/grid)
3287:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
3288: 
3289:                 *-- Redefinir headers APOS cada Buscar() (VFP9 pode resetar)
3290:                 IF VARTYPE(loc_oPagina.grd_4c_Lista) = "O"
3291:                     loc_oGrid = loc_oPagina.grd_4c_Lista
3292:                     loc_oGrid.Column1.Header1.Caption = "Produto"
3293:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3294:                     loc_oGrid.Column3.Header1.Caption = "Grupo"

*-- Linhas 3300 a 3752:
3300:                 ENDIF
3301: 
3302:                 *-- Atualizar contagem
3303:                 IF VARTYPE(loc_oPagina.lbl_4c_Contagem) = "O"
3304:                     loc_oPagina.lbl_4c_Contagem.Caption = "Produtos Selecionados : " + ;
3305:                         TRANSFORM(RECCOUNT("cursor_4c_Dados"))
3306:                 ENDIF
3307: 
3308:                 loc_lResultado = .T.
3309:             ENDIF
3310: 
3311:         CATCH TO loException
3312:             MsgErro("Erro ao carregar lista:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
3313:             loc_lResultado = .F.
3314:         ENDTRY
3315: 
3316:         RETURN loc_lResultado
3317:     ENDPROC
3318: 
3319:     *--------------------------------------------------------------------------
3320:     * AlternarPagina - Navega entre paginas do PageFrame principal
3321:     * Page1=Lista, Page2=Dados
3322:     *--------------------------------------------------------------------------
3323:     PROCEDURE AlternarPagina(par_nPagina)
3324: 
3325:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3326:             RETURN
3327:         ENDIF
3328: 
3329:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3330: 
3331:         *-- Ao voltar para Page1, recarregar lista
3332:         IF par_nPagina = 1
3333:             IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
3334:                 THIS.CarregarLista()
3335:             ENDIF
3336:         ENDIF
3337:     ENDPROC
3338: 
3339:     *--------------------------------------------------------------------------
3340:     * TxtCgruKeyPress - F4 abre lookup de grupos de produto
3341:     * BINDEVENT requer PUBLIC + LPARAMETERS declarados
3342:     *--------------------------------------------------------------------------
3343:     PROCEDURE TxtCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3344:         IF par_nKeyCode = 115 && F4
3345:             THIS.AbrirLookupGrupo()
3346:         ENDIF
3347:     ENDPROC
3348: 
3349:     *--------------------------------------------------------------------------
3350:     * TxtCgruLostFocus - Valida codigo do grupo ao sair do campo
3351:     *--------------------------------------------------------------------------
3352:     PROCEDURE TxtCgruLostFocus()
3353:         LOCAL loc_oPagina, loc_cCgru, loc_nRet
3354:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
3355:         loc_cCgru   = ALLTRIM(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value)
3356: 
3357:         IF EMPTY(loc_cCgru)
3358:             loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
3359:             THIS.CarregarLista()
3360:             RETURN
3361:         ENDIF
3362: 
3363:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3364:             TRY
3365:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3366:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
3367:                     "cursor_4c_TmpGrupo")
3368: 
3369:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGrupo") > 0
3370:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_TmpGrupo.dgrus)
3371:                 ELSE
3372:                     MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
3373:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
3374:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
3375:                 ENDIF
3376: 
3377:                 IF USED("cursor_4c_TmpGrupo")
3378:                     USE IN cursor_4c_TmpGrupo
3379:                 ENDIF
3380:             CATCH TO loc_oErro
3381:                 MsgErro(loc_oErro.Message, "Erro ao validar grupo")
3382:             ENDTRY
3383:         ENDIF
3384: 
3385:         THIS.CarregarLista()
3386:     ENDPROC
3387: 
3388:     *--------------------------------------------------------------------------
3389:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para SigCdGrp
3390:     *--------------------------------------------------------------------------
3391:     PROCEDURE AbrirLookupGrupo()
3392:         LOCAL loc_oBusca, loc_oPagina
3393:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
3394: 
3395:         TRY
3396:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3397:                 "SigCdGrp", "cursor_4c_BuscaGrupo", "cgrus", "", ;
3398:                 "Buscar Grupo de Produto")
3399: 
3400:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3401:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
3402:             loc_oBusca.Show()
3403: 
3404:             IF loc_oBusca.this_lSelecionou
3405:                 IF USED("cursor_4c_BuscaGrupo")
3406:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
3407:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrupo.dgrus)
3408:                     THIS.CarregarLista()
3409:                 ENDIF
3410:             ENDIF
3411: 
3412:             IF USED("cursor_4c_BuscaGrupo")
3413:                 USE IN cursor_4c_BuscaGrupo
3414:             ENDIF
3415:             loc_oBusca.Release()
3416: 
3417:         CATCH TO loc_oErro
3418:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
3419:         ENDTRY
3420:     ENDPROC
3421: 
3422:     *--------------------------------------------------------------------------
3423:     * OptSituasChange - Recarrega lista ao mudar filtro de situacao
3424:     *--------------------------------------------------------------------------
3425:     PROCEDURE OptSituasChange()
3426:         THIS.CarregarLista()
3427:     ENDPROC
3428: 
3429:     *--------------------------------------------------------------------------
3430:     * TornarControlesVisiveis - Torna visiveis apenas controles nomeados
3431:     * Evita tornar visiveis containers flutuantes (Visible=.F. por design)
3432:     *--------------------------------------------------------------------------
3433:     PROCEDURE TornarControlesVisiveis(par_oContainer)
3434: 
3435:         LOCAL loc_i, loc_oCtrl, loc_cNome, loc_lPrefixoValido
3436: 
3437:         IF VARTYPE(par_oContainer) # "O"
3438:             RETURN
3439:         ENDIF
3440: 
3441:         FOR loc_i = 1 TO par_oContainer.ControlCount
3442:             loc_oCtrl          = par_oContainer.Controls(loc_i)
3443:             loc_cNome          = loc_oCtrl.Name
3444:             loc_lPrefixoValido = INLIST(LEFT(loc_cNome, 4), "cnt_", "txt_", "lbl_", "cmd_", "chk_", "cmb_", "grd_", "pgf_")
3445: 
3446:             IF loc_lPrefixoValido
3447:                 *-- Nao forcar Visible=.T. em containers ocultos por design
3448:                 IF INLIST(LEFT(loc_cNome, 4), "cnt_", "pgf_") AND !loc_oCtrl.Visible
3449:                     *-- Container oculto por design - pular
3450:                 ELSE
3451:                     loc_oCtrl.Visible = .T.
3452:                     IF loc_oCtrl.ControlCount > 0
3453:                         THIS.TornarControlesVisiveis(loc_oCtrl)
3454:                     ENDIF
3455:                 ENDIF
3456:             ENDIF
3457:         ENDFOR
3458:     ENDPROC
3459: 
3460:     *--------------------------------------------------------------------------
3461:     * FormatarGridLista - Aplica formatacao padrao ao grid de lista
3462:     *--------------------------------------------------------------------------
3463:     PROCEDURE FormatarGridLista(par_oGrid)
3464: 
3465:         IF VARTYPE(par_oGrid) # "O"
3466:             RETURN
3467:         ENDIF
3468: 
3469:         WITH par_oGrid
3470:             .FontName           = "Verdana"
3471:             .FontSize           = 8
3472:             .GridLines          = 3
3473:             .GridLineWidth      = 1
3474:             .GridLineColor      = RGB(238, 238, 238)
3475:             .RecordMark         = .F.
3476:             .DeleteMark         = .F.
3477:             .AllowRowSizing     = .F.
3478:             .ReadOnly           = .T.
3479:             .BackColor          = RGB(255, 255, 255)
3480:             .ForeColor          = RGB(90, 90, 90)
3481:             .HighlightBackColor = RGB(255, 255, 255)
3482:             .HighlightForeColor = RGB(15, 41, 104)
3483:             .HighlightStyle     = 2
3484:             .RowHeight          = 16
3485:             .ScrollBars         = 2
3486:         ENDWITH
3487:     ENDPROC
3488: 
3489:     *--------------------------------------------------------------------------
3490:     * BtnIncluirClick - Incluir novo produto
3491:     *--------------------------------------------------------------------------
3492:     PROCEDURE BtnIncluirClick()
3493:         LOCAL loc_lResultado
3494:         loc_lResultado = .F.
3495: 
3496:         TRY
3497:             THIS.this_oBusinessObject.NovoRegistro()
3498:             THIS.LimparCampos()
3499:             THIS.this_cModoAtual = "INCLUIR"
3500:             THIS.HabilitarCampos(.T.)
3501:             THIS.AjustarBotoesPorModo()
3502:             THIS.AlternarPagina(2)
3503:             loc_lResultado = .T.
3504:         CATCH TO loc_oErro
3505:             MsgErro(loc_oErro.Message, "Erro ao incluir produto")
3506:         ENDTRY
3507: 
3508:         RETURN loc_lResultado
3509:     ENDPROC
3510: 
3511:     *--------------------------------------------------------------------------
3512:     * BtnVisualizarClick - Visualizar produto selecionado
3513:     *--------------------------------------------------------------------------
3514:     PROCEDURE BtnVisualizarClick()
3515:         LOCAL loc_cCodigo, loc_lResultado
3516:         loc_lResultado = .F.
3517: 
3518:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3519:             MsgAviso("Nenhum registro selecionado!")
3520:             RETURN .F.
3521:         ENDIF
3522: 
3523:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
3524: 
3525:         TRY
3526:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3527:                 THIS.BOParaForm()
3528:                 THIS.this_cModoAtual = "VISUALIZAR"
3529:                 THIS.HabilitarCampos(.F.)
3530:                 THIS.AjustarBotoesPorModo()
3531:                 THIS.AlternarPagina(2)
3532:                 loc_lResultado = .T.
3533:             ENDIF
3534:         CATCH TO loc_oErro
3535:             MsgErro(loc_oErro.Message, "Erro ao visualizar produto")
3536:         ENDTRY
3537: 
3538:         RETURN loc_lResultado
3539:     ENDPROC
3540: 
3541:     *--------------------------------------------------------------------------
3542:     * BtnAlterarClick - Alterar produto selecionado
3543:     *--------------------------------------------------------------------------
3544:     PROCEDURE BtnAlterarClick()
3545:         LOCAL loc_cCodigo, loc_lResultado
3546:         loc_lResultado = .F.
3547: 
3548:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3549:             MsgAviso("Nenhum registro selecionado!")
3550:             RETURN .F.
3551:         ENDIF
3552: 
3553:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
3554: 
3555:         TRY
3556:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3557:                 THIS.this_oBusinessObject.EditarRegistro()
3558:                 THIS.BOParaForm()
3559:                 THIS.this_cModoAtual = "ALTERAR"
3560:                 THIS.HabilitarCampos(.T.)
3561:                 THIS.AjustarBotoesPorModo()
3562:                 THIS.AlternarPagina(2)
3563:                 loc_lResultado = .T.
3564:             ENDIF
3565:         CATCH TO loc_oErro
3566:             MsgErro(loc_oErro.Message, "Erro ao alterar produto")
3567:         ENDTRY
3568: 
3569:         RETURN loc_lResultado
3570:     ENDPROC
3571: 
3572:     *--------------------------------------------------------------------------
3573:     * BtnExcluirClick - Excluir produto selecionado
3574:     * Legado: verifica uso em outros registros antes de excluir
3575:     *--------------------------------------------------------------------------
3576:     PROCEDURE BtnExcluirClick()
3577:         LOCAL loc_cCodigo, loc_cDescricao, loc_lResultado
3578:         loc_lResultado = .F.
3579: 
3580:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3581:             MsgAviso("Nenhum registro selecionado!")
3582:             RETURN .F.
3583:         ENDIF
3584: 
3585:         loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
3586:         loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
3587: 
3588:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto:" + CHR(13) + loc_cCodigo + " - " + loc_cDescricao + "?")
3589:             TRY
3590:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3591:                     IF THIS.this_oBusinessObject.Excluir()
3592:                         MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
3593:                         THIS.CarregarLista()
3594:                         loc_lResultado = .T.
3595:                     ENDIF
3596:                 ENDIF
3597:             CATCH TO loc_oErro
3598:                 MsgErro(loc_oErro.Message, "Erro ao excluir produto")
3599:             ENDTRY
3600:         ENDIF
3601: 
3602:         RETURN loc_lResultado
3603:     ENDPROC
3604: 
3605:     *--------------------------------------------------------------------------
3606:     * BtnBuscarClick - Abre busca auxiliar de produtos
3607:     *--------------------------------------------------------------------------
3608:     PROCEDURE BtnBuscarClick()
3609:         LOCAL loc_oBusca
3610: 
3611:         TRY
3612:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
3613: 
3614:             loc_oBusca.mAddColuna("cpros", "", "Produto")
3615:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3616:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3617: 
3618:             loc_oBusca.Show()
3619: 
3620:             IF loc_oBusca.this_lSelecionou
3621:                 IF USED("cursor_4c_Busca")
3622:                     LOCAL loc_cCodigo
3623:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
3624: 
3625:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3626:                         THIS.BOParaForm()
3627:                         THIS.this_cModoAtual = "VISUALIZAR"
3628:                         THIS.HabilitarCampos(.F.)
3629:                         THIS.AlternarPagina(2)
3630:                     ENDIF
3631:                 ENDIF
3632:             ENDIF
3633: 
3634:             IF USED("cursor_4c_Busca")
3635:                 USE IN cursor_4c_Busca
3636:             ENDIF
3637:             loc_oBusca.Release()
3638: 
3639:         CATCH TO loException
3640:             MostrarErro("Erro ao buscar produto:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
3641:         ENDTRY
3642:     ENDPROC
3643: 
3644:     *--------------------------------------------------------------------------
3645:     * BtnEncerrarClick - Fechar o formulario
3646:     *--------------------------------------------------------------------------
3647:     PROCEDURE BtnEncerrarClick()
3648:         THIS.Release()
3649:     ENDPROC
3650: 
3651:     *--------------------------------------------------------------------------
3652:     * BtnSalvarClick - Salvar produto
3653:     * Valida campos obrigatorios, transfere Form->BO e chama Salvar()
3654:     *--------------------------------------------------------------------------
3655:     PROCEDURE BtnSalvarClick()
3656:         LOCAL loc_lResultado, loc_oPg, loc_cCpro, loc_cDpro
3657:         loc_lResultado = .F.
3658: 
3659:         *-- Validacoes FORA do TRY (VFP9: nunca RETURN dentro de TRY/CATCH)
3660:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3661:             RETURN .F.
3662:         ENDIF
3663:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3664:         loc_cCpro = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
3665:         loc_cDpro = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)
3666: 
3667:         IF EMPTY(loc_cCpro)
3668:             MsgAviso("C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio!", "Valida" + CHR(231) + CHR(227) + "o")
3669:             loc_oPg.txt_4c_Cpro.SetFocus()
3670:             RETURN .F.
3671:         ENDIF
3672: 
3673:         IF EMPTY(loc_cDpro)
3674:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o do produto obrigat" + CHR(243) + "ria!", "Valida" + CHR(231) + CHR(227) + "o")
3675:             loc_oPg.txt_4c_Dpro.SetFocus()
3676:             RETURN .F.
3677:         ENDIF
3678: 
3679:         TRY
3680:             THIS.FormParaBO()
3681: 
3682:             IF THIS.this_oBusinessObject.Salvar()
3683:                 MsgSucesso("Produto salvo com sucesso!")
3684:                 THIS.this_cModoAtual = "LISTA"
3685:                 THIS.AjustarBotoesPorModo()
3686:                 THIS.AlternarPagina(1)  && AlternarPagina(1) ja chama CarregarLista()
3687:                 loc_lResultado = .T.
3688:             ENDIF
3689:             *-- Erros de validacao: exibidos por ValidarDados() via MsgAviso (form permanece em Dados)
3690:             *-- Erros de BD: exibidos por Inserir/Atualizar via MsgErro (form permanece em Dados)
3691: 
3692:         CATCH TO loc_oErro
3693:             MsgErro("Erro ao salvar produto:" + CHR(13) + "Linha: " + ;
3694:                 TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "Erro")
3695:         ENDTRY
3696: 
3697:         RETURN loc_lResultado
3698:     ENDPROC
3699: 
3700:     *--------------------------------------------------------------------------
3701:     * BtnCancelarClick - Cancelar operacao
3702:     *--------------------------------------------------------------------------
3703:     PROCEDURE BtnCancelarClick()
3704:         THIS.this_cModoAtual = "LISTA"
3705:         THIS.AlternarPagina(1)
3706:         THIS.CarregarLista()
3707:     ENDPROC
3708: 
3709:     *--------------------------------------------------------------------------
3710:     * FormParaBO - Transfere dados do Form para o BO (campos pgDados Fase 5)
3711:     *--------------------------------------------------------------------------
3712:     PROTECTED PROCEDURE FormParaBO()
3713:         LOCAL loc_oPg
3714:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3715: 
3716:         WITH THIS.this_oBusinessObject
3717:             .this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
3718:             .this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)
3719:             .this_nSituas   = loc_oPg.obj_4c_Opc_situacao.Value
3720:             .this_cCproeqs  = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
3721:             .this_cDpro2s   = ALLTRIM(loc_oPg.txt_4c_DPro2s.Value)
3722:             .this_nCbars    = ALLTRIM(loc_oPg.txt_4c_Cbar.Value)
3723:             .this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
3724:             .this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Merc.Value)
3725:             .this_cIdecpros = ALLTRIM(loc_oPg.txt_4c_IdeCPros.Value)
3726:             .this_nEan13    = ALLTRIM(loc_oPg.txt_4c_EAN13.Value)
3727:             .this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
3728:             .this_cConjunts = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)
3729:             .this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
3730:             .this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Col.Value)
3731:             .this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
3732:             .this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Refs.Value)
3733:             *-- Fase 6: campos adicionais
3734:             .this_cCodfinp    = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
3735:             .this_cCodacbs    = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
3736:             .this_cCclass     = ALLTRIM(loc_oPg.txt_4c_Class.Value)
3737:             .this_cLocals     = ALLTRIM(loc_oPg.txt_4c_Local.Value)
3738:             .this_nPesobs     = ALLTRIM(loc_oPg.txt_4c_PesoBs.Value)
3739:             .this_nPesoms     = ALLTRIM(loc_oPg.txt_4c_Pmedio.Value)
3740:             .this_cCunis      = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
3741:             .this_cCunips     = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
3742:             .this_cCodident   = ALLTRIM(loc_oPg.txt_4c_CodIdent.Value)
3743:             .this_nTents      = ALLTRIM(loc_oPg.txt_4c_TEnts.Value)
3744:             .this_lConsigs    = (loc_oPg.chk_4c_Consig.Value = 1)
3745:             .this_lFabrproprs = (loc_oPg.chk_4c_FabrProprs.Value = 1)
3746:             .this_lEncoms     = (loc_oPg.chk_4c_Encoms.Value = 1)
3747:             .this_nTamps      = ALLTRIM(loc_oPg.txt_4c_Tamps.Value)
3748:             .this_nTamhs      = ALLTRIM(loc_oPg.txt_4c_Tamhs.Value)
3749:             .this_nTamls      = ALLTRIM(loc_oPg.txt_4c_Tamls.Value)
3750:             .this_nVolumes    = ALLTRIM(loc_oPg.txt_4c_Volumes.Value)
3751:             .this_cDsccompras = loc_oPg.edt_4c_DscCompras.Value
3752:             .this_cDpro3s     = loc_oPg.edt_4c_DPro3s.Value

*-- Linhas 3771 a 3814:
3771:     *--------------------------------------------------------------------------
3772:     * BOParaForm - Transfere dados do BO para o Form (campos pgDados Fase 5)
3773:     *--------------------------------------------------------------------------
3774:     PROTECTED PROCEDURE BOParaForm()
3775:         LOCAL loc_oPg
3776:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3777: 
3778:         WITH THIS.this_oBusinessObject
3779:             loc_oPg.txt_4c_Cpro.Value              = ALLTRIM(.this_cCpros)
3780:             loc_oPg.txt_4c_Dpro.Value              = ALLTRIM(.this_cDpros)
3781:             loc_oPg.obj_4c_Opc_situacao.Value      = IIF(.this_nSituas = 2, 2, 1)
3782:             loc_oPg.txt_4c_CProEq.Value            = ALLTRIM(.this_cCproeqs)
3783:             loc_oPg.txt_4c_DPro2s.Value            = ALLTRIM(.this_cDpro2s)
3784:             *-- cbars e ean13 sao numericos: converter para string de exibicao
3785:             loc_oPg.txt_4c_Cbar.Value              = IIF(.this_nCbars = 0, "", LTRIM(STR(.this_nCbars, 14, 0)))
3786:             loc_oPg.txt_4c_CgruP.Value             = ALLTRIM(.this_cCgrus)
3787:             loc_oPg.txt_4c_DgruP.Value             = ""
3788:             loc_oPg.txt_4c_Merc.Value              = ALLTRIM(.this_cMercs)
3789:             loc_oPg.txt_4c_IdeCPros.Value          = ALLTRIM(.this_cIdecpros)
3790:             loc_oPg.txt_4c_EAN13.Value             = IIF(.this_nEan13 = 0, "", LTRIM(STR(.this_nEan13, 13, 0)))
3791:             loc_oPg.txt_4c_CSGru.Value             = ALLTRIM(.this_cSgrus)
3792:             loc_oPg.txt_4c_DsGru.Value             = ""
3793:             loc_oPg.txt_4c_Conjunto.Value          = ALLTRIM(.this_cConjunts)
3794:             loc_oPg.txt_4c_Lin.Value               = ALLTRIM(.this_cLinhas)
3795:             loc_oPg.txt_4c_DLin.Value              = ""
3796:             loc_oPg.txt_4c_Col.Value               = ALLTRIM(.this_cColecoes)
3797:             loc_oPg.txt_4c_DCol.Value              = ""
3798:             loc_oPg.txt_4c_Ifor.Value              = ALLTRIM(.this_cIfors)
3799:             loc_oPg.txt_4c_Dfor.Value              = ""
3800:             loc_oPg.txt_4c_Refs.Value              = ALLTRIM(.this_cReffs)
3801:             *-- Fase 6: campos adicionais
3802:             loc_oPg.txt_4c_CodFinP.Value   = ALLTRIM(.this_cCodfinp)
3803:             loc_oPg.txt_4c_DFinP.Value     = ""
3804:             loc_oPg.txt_4c_CodAcb.Value    = ALLTRIM(.this_cCodacbs)
3805:             loc_oPg.txt_4c_DAcb.Value      = ""
3806:             loc_oPg.txt_4c_Class.Value     = ALLTRIM(.this_cCclass)
3807:             loc_oPg.txt_4c_DClass.Value    = ""
3808:             loc_oPg.txt_4c_Local.Value     = ALLTRIM(.this_cLocals)
3809:             loc_oPg.txt_4c_PesoBs.Value    = IIF(.this_nPesobs = 0, "", LTRIM(STR(.this_nPesobs, 10, 3)))
3810:             loc_oPg.txt_4c_Pmedio.Value    = IIF(.this_nPesoms = 0, "", LTRIM(STR(.this_nPesoms, 11, 3)))
3811:             loc_oPg.txt_4c_Estoques.Value  = ""
3812:             loc_oPg.txt_4c_QtdEsts.Value   = ""
3813:             *-- Custo/Venda/Fator (display only - readonly)
3814:             loc_oPg.txt_4c_Ctotal.Value    = IIF(.this_nCustofs = 0, "", LTRIM(STR(.this_nCustofs, 14, 5)))

*-- Linhas 3874 a 3917:
3874:     *--------------------------------------------------------------------------
3875:     * LimparCampos - Limpa todos os campos do formulario (pgDados Fase 5)
3876:     *--------------------------------------------------------------------------
3877:     PROTECTED PROCEDURE LimparCampos()
3878:         LOCAL loc_oPg
3879:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3880:             RETURN
3881:         ENDIF
3882:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3883:         IF VARTYPE(loc_oPg.txt_4c_Cpro) # "O"
3884:             RETURN
3885:         ENDIF
3886: 
3887:         loc_oPg.txt_4c_Cpro.Value              = ""
3888:         loc_oPg.txt_4c_Dpro.Value              = ""
3889:         loc_oPg.obj_4c_Opc_situacao.Value      = 1
3890:         loc_oPg.txt_4c_CProEq.Value            = ""
3891:         loc_oPg.txt_4c_DPro2s.Value            = ""
3892:         loc_oPg.txt_4c_Cbar.Value              = ""
3893:         loc_oPg.txt_4c_CgruP.Value             = ""
3894:         loc_oPg.txt_4c_DgruP.Value             = ""
3895:         loc_oPg.txt_4c_Merc.Value              = ""
3896:         loc_oPg.txt_4c_IdeCPros.Value          = ""
3897:         loc_oPg.txt_4c_EAN13.Value             = ""
3898:         loc_oPg.txt_4c_CSGru.Value             = ""
3899:         loc_oPg.txt_4c_DsGru.Value             = ""
3900:         loc_oPg.txt_4c_Conjunto.Value          = ""
3901:         loc_oPg.txt_4c_Lin.Value               = ""
3902:         loc_oPg.txt_4c_DLin.Value              = ""
3903:         loc_oPg.txt_4c_Col.Value               = ""
3904:         loc_oPg.txt_4c_DCol.Value              = ""
3905:         loc_oPg.txt_4c_Ifor.Value              = ""
3906:         loc_oPg.txt_4c_Dfor.Value              = ""
3907:         loc_oPg.txt_4c_Refs.Value              = ""
3908: 
3909:         *-- Fase 6
3910:         IF VARTYPE(loc_oPg.txt_4c_CodFinP) # "O"
3911:             RETURN
3912:         ENDIF
3913:         loc_oPg.txt_4c_CodFinP.Value   = ""
3914:         loc_oPg.txt_4c_DFinP.Value     = ""
3915:         loc_oPg.txt_4c_CodAcb.Value    = ""
3916:         loc_oPg.txt_4c_DAcb.Value      = ""
3917:         loc_oPg.txt_4c_Class.Value     = ""

*-- Linhas 3964 a 4007:
3964:     *--------------------------------------------------------------------------
3965:     * HabilitarCampos - Habilita/desabilita campos conforme modo (Fase 5)
3966:     *--------------------------------------------------------------------------
3967:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3968:         LOCAL loc_oPg
3969:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
3970:             RETURN
3971:         ENDIF
3972:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
3973:         IF VARTYPE(loc_oPg.txt_4c_Cpro) # "O"
3974:             RETURN
3975:         ENDIF
3976: 
3977:         *-- Codigo do produto: habilitado apenas em INCLUIR (PK nao pode mudar)
3978:         loc_oPg.txt_4c_Cpro.Enabled           = IIF(THIS.this_cModoAtual = "INCLUIR", par_lHabilitar, .F.)
3979:         loc_oPg.txt_4c_Dpro.Enabled           = par_lHabilitar
3980:         loc_oPg.obj_4c_Opc_situacao.Enabled   = par_lHabilitar
3981:         loc_oPg.txt_4c_CProEq.Enabled         = par_lHabilitar
3982:         loc_oPg.txt_4c_DPro2s.Enabled         = par_lHabilitar
3983:         loc_oPg.txt_4c_Cbar.Enabled           = par_lHabilitar
3984:         loc_oPg.txt_4c_CgruP.Enabled          = par_lHabilitar
3985:         loc_oPg.txt_4c_Merc.Enabled           = par_lHabilitar
3986:         loc_oPg.txt_4c_IdeCPros.Enabled       = par_lHabilitar
3987:         loc_oPg.txt_4c_EAN13.Enabled          = par_lHabilitar
3988:         loc_oPg.txt_4c_CSGru.Enabled          = par_lHabilitar
3989:         loc_oPg.txt_4c_Conjunto.Enabled       = par_lHabilitar
3990:         loc_oPg.txt_4c_Lin.Enabled            = par_lHabilitar
3991:         loc_oPg.txt_4c_Col.Enabled            = par_lHabilitar
3992:         loc_oPg.txt_4c_Ifor.Enabled           = par_lHabilitar
3993:         loc_oPg.txt_4c_Refs.Enabled           = par_lHabilitar
3994: 
3995:         *-- Fase 6 - campos editaveis
3996:         IF VARTYPE(loc_oPg.txt_4c_CodFinP) # "O"
3997:             RETURN
3998:         ENDIF
3999:         loc_oPg.txt_4c_CodFinP.Enabled    = par_lHabilitar
4000:         loc_oPg.txt_4c_CodAcb.Enabled     = par_lHabilitar
4001:         loc_oPg.txt_4c_Class.Enabled      = par_lHabilitar
4002:         loc_oPg.txt_4c_Local.Enabled      = par_lHabilitar
4003:         loc_oPg.txt_4c_PesoBs.Enabled     = par_lHabilitar
4004:         loc_oPg.txt_4c_Pmedio.Enabled     = par_lHabilitar
4005:         loc_oPg.txt_4c_Cuni.Enabled       = par_lHabilitar
4006:         loc_oPg.txt_4c_Cunip.Enabled      = par_lHabilitar
4007:         loc_oPg.txt_4c_CodIdent.Enabled   = par_lHabilitar

*-- Linhas 4034 a 4077:
4034:     * ConfigurarPgDados - Configura campos da aba Dados (primeiros 50%)
4035:     * Legado: pgDados controles T:130-T:298 (sem compensacao adicional)
4036:     *--------------------------------------------------------------------------
4037:     PROTECTED PROCEDURE ConfigurarPgDados()
4038:         LOCAL loc_oPg
4039:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4040: 
4041:         *-- Linha 1 (T:130-134): Produto / Descricao / Situacao
4042:         *-- Label2: "Produto :" (T:134 L:58 W:53 FontBold)
4043:         loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
4044:         WITH loc_oPg.lbl_4c_LblProduto
4045:             .Caption   = "Produto :"
4046:             .Top       = 134
4047:             .Left      = 58
4048:             .Width     = 53
4049:             .Height    = 15
4050:             .FontName  = "Tahoma"
4051:             .FontSize  = 8
4052:             .FontBold  = .T.
4053:             .BackStyle = 0
4054:             .ForeColor = RGB(90, 90, 90)
4055:             .Visible   = .T.
4056:         ENDWITH
4057: 
4058:         *-- getCpro -> txt_4c_Cpro (T:130 L:113 W:108 H:23) - PK do produto
4059:         loc_oPg.AddObject("txt_4c_Cpro", "TextBox")
4060:         WITH loc_oPg.txt_4c_Cpro
4061:             .Top           = 130
4062:             .Left          = 113
4063:             .Width         = 108
4064:             .Height        = 23
4065:             .FontName      = "Tahoma"
4066:             .FontSize      = 8
4067:             .MaxLength     = 14
4068:             .Value         = ""
4069:             .SpecialEffect = 1
4070:             .Visible       = .T.
4071:         ENDWITH
4072: 
4073:         *-- getDpro -> txt_4c_Dpro (T:130 L:222 W:290 H:23) - descricao
4074:         loc_oPg.AddObject("txt_4c_Dpro", "TextBox")
4075:         WITH loc_oPg.txt_4c_Dpro
4076:             .Top           = 130
4077:             .Left          = 222

*-- Linhas 4087 a 4130:
4087: 
4088:         *-- opc_situacao -> obj_4c_Opc_situacao (T:130 L:735 W:142 H:25)
4089:         *-- Value=1 Ativo, Value=2 Inativo (situas numeric no banco)
4090:         loc_oPg.AddObject("obj_4c_Opc_situacao", "OptionGroup")
4091:         WITH loc_oPg.obj_4c_Opc_situacao
4092:             .Top         = 130
4093:             .Left        = 735
4094:             .Width       = 142
4095:             .Height      = 25
4096:             .ButtonCount = 2
4097:             .Value       = 1
4098:             .BorderStyle = 0
4099:             .Visible     = .T.
4100:         ENDWITH
4101:         WITH loc_oPg.obj_4c_Opc_situacao
4102:             .Buttons(1).Caption   = "Ativo"
4103:             .Buttons(1).Left      = 5
4104:             .Buttons(1).Top       = 5
4105:             .Buttons(1).Height    = 15
4106:             .Buttons(1).FontName  = "Tahoma"
4107:             .Buttons(1).FontSize  = 8
4108:             .Buttons(1).ForeColor = RGB(90, 90, 90)
4109:             .Buttons(1).BackStyle = 0
4110:             .Buttons(1).AutoSize  = .T.
4111:             .Buttons(1).Themes    = .F.
4112: 
4113:             .Buttons(2).Caption   = "Inativo - Ap" + CHR(243) + "s :"
4114:             .Buttons(2).Left      = 50
4115:             .Buttons(2).Top       = 5
4116:             .Buttons(2).Height    = 15
4117:             .Buttons(2).FontName  = "Tahoma"
4118:             .Buttons(2).FontSize  = 8
4119:             .Buttons(2).ForeColor = RGB(90, 90, 90)
4120:             .Buttons(2).BackStyle = 0
4121:             .Buttons(2).AutoSize  = .T.
4122:             .Buttons(2).Themes    = .F.
4123:         ENDWITH
4124: 
4125:         *-- Linha 2 (T:133-158): Equivalente / Descritivo / Barra
4126:         *-- Say2: "Equivalente :" (T:137 L:560 W:65)
4127:         loc_oPg.AddObject("lbl_4c_LblEquivalente", "Label")
4128:         WITH loc_oPg.lbl_4c_LblEquivalente
4129:             .Caption   = "Equivalente :"
4130:             .Top       = 137

*-- Linhas 4153 a 4197:
4153:             .ForeColor     = RGB(36, 84, 155)
4154:             .Visible       = .T.
4155:         ENDWITH
4156:         BINDEVENT(loc_oPg.txt_4c_CProEq, "KeyPress",  THIS, "TxtCProEqKeyPress")
4157:         BINDEVENT(loc_oPg.txt_4c_CProEq, "LostFocus", THIS, "TxtCProEqLostFocus")
4158: 
4159:         *-- Say10: "Descritivo :" (T:158 L:55 W:56)
4160:         loc_oPg.AddObject("lbl_4c_LblDPro2", "Label")
4161:         WITH loc_oPg.lbl_4c_LblDPro2
4162:             .Caption   = "Descritivo :"
4163:             .Top       = 158
4164:             .Left      = 55
4165:             .Width     = 56
4166:             .Height    = 15
4167:             .FontName  = "Tahoma"
4168:             .FontSize  = 8
4169:             .BackStyle = 0
4170:             .ForeColor = RGB(90, 90, 90)
4171:             .Visible   = .T.
4172:         ENDWITH
4173: 
4174:         *-- getDPro2s -> txt_4c_DPro2s (T:154 L:113 W:399 H:23) - 2a descricao
4175:         loc_oPg.AddObject("txt_4c_DPro2s", "TextBox")
4176:         WITH loc_oPg.txt_4c_DPro2s
4177:             .Top           = 154
4178:             .Left          = 113
4179:             .Width         = 399
4180:             .Height        = 23
4181:             .FontName      = "Tahoma"
4182:             .FontSize      = 8
4183:             .MaxLength     = 45
4184:             .Value         = ""
4185:             .SpecialEffect = 1
4186:             .Visible       = .T.
4187:         ENDWITH
4188: 
4189:         *-- Say15: "Barra :" (T:157 L:590 W:35)
4190:         loc_oPg.AddObject("lbl_4c_LblBarra", "Label")
4191:         WITH loc_oPg.lbl_4c_LblBarra
4192:             .Caption   = "Barra :"
4193:             .Top       = 157
4194:             .Left      = 590
4195:             .Width     = 35
4196:             .Height    = 15
4197:             .FontName  = "Tahoma"

*-- Linhas 4248 a 4292:
4248:             .SpecialEffect = 1
4249:             .Visible       = .T.
4250:         ENDWITH
4251:         BINDEVENT(loc_oPg.txt_4c_CgruP, "KeyPress",  THIS, "TxtCgruPKeyPress")
4252:         BINDEVENT(loc_oPg.txt_4c_CgruP, "LostFocus", THIS, "TxtCgruPLostFocus")
4253: 
4254:         *-- getDgru -> txt_4c_DgruP (T:178 L:145 W:171 H:23) - desc grupo (readonly)
4255:         loc_oPg.AddObject("txt_4c_DgruP", "TextBox")
4256:         WITH loc_oPg.txt_4c_DgruP
4257:             .Top           = 178
4258:             .Left          = 145
4259:             .Width         = 171
4260:             .Height        = 23
4261:             .FontName      = "Tahoma"
4262:             .FontSize      = 8
4263:             .ReadOnly      = .T.
4264:             .Value         = ""
4265:             .SpecialEffect = 1
4266:             .Visible       = .T.
4267:         ENDWITH
4268: 
4269:         *-- getMerc -> txt_4c_Merc (T:178 L:318 W:31 H:23) - mercadoria
4270:         loc_oPg.AddObject("txt_4c_Merc", "TextBox")
4271:         WITH loc_oPg.txt_4c_Merc
4272:             .Top           = 178
4273:             .Left          = 318
4274:             .Width         = 31
4275:             .Height        = 23
4276:             .FontName      = "Tahoma"
4277:             .FontSize      = 8
4278:             .MaxLength     = 3
4279:             .Value         = ""
4280:             .SpecialEffect = 1
4281:             .BackColor     = RGB(231, 242, 254)
4282:             .Visible       = .T.
4283:         ENDWITH
4284: 
4285:         *-- Say23: "Identificador :" (T:182 L:408 W:70)
4286:         loc_oPg.AddObject("lbl_4c_LblIdeCPros", "Label")
4287:         WITH loc_oPg.lbl_4c_LblIdeCPros
4288:             .Caption   = "Identificador :"
4289:             .Top       = 182
4290:             .Left      = 408
4291:             .Width     = 70
4292:             .Height    = 15

*-- Linhas 4374 a 4590:
4374:             .SpecialEffect = 1
4375:             .Visible       = .T.
4376:         ENDWITH
4377:         BINDEVENT(loc_oPg.txt_4c_CSGru, "KeyPress",  THIS, "TxtCSGruKeyPress")
4378:         BINDEVENT(loc_oPg.txt_4c_CSGru, "LostFocus", THIS, "TxtCSGruLostFocus")
4379: 
4380:         *-- GetDsGru -> txt_4c_DsGru (T:202 L:166 W:150 H:23) - desc subgrupo (readonly)
4381:         loc_oPg.AddObject("txt_4c_DsGru", "TextBox")
4382:         WITH loc_oPg.txt_4c_DsGru
4383:             .Top           = 202
4384:             .Left          = 166
4385:             .Width         = 150
4386:             .Height        = 23
4387:             .FontName      = "Tahoma"
4388:             .FontSize      = 8
4389:             .ReadOnly      = .T.
4390:             .Value         = ""
4391:             .SpecialEffect = 1
4392:             .Visible       = .T.
4393:         ENDWITH
4394: 
4395:         *-- Say37: "Conjunto :" (T:206 L:408 W:53)
4396:         loc_oPg.AddObject("lbl_4c_LblConjunto", "Label")
4397:         WITH loc_oPg.lbl_4c_LblConjunto
4398:             .Caption   = "Conjunto :"
4399:             .Top       = 206
4400:             .Left      = 408
4401:             .Width     = 53
4402:             .Height    = 15
4403:             .FontName  = "Tahoma"
4404:             .FontSize  = 8
4405:             .BackStyle = 0
4406:             .ForeColor = RGB(90, 90, 90)
4407:             .Visible   = .T.
4408:         ENDWITH
4409: 
4410:         *-- getConjunto -> txt_4c_Conjunto (T:202 L:460 W:52 H:23)
4411:         loc_oPg.AddObject("txt_4c_Conjunto", "TextBox")
4412:         WITH loc_oPg.txt_4c_Conjunto
4413:             .Top           = 202
4414:             .Left          = 460
4415:             .Width         = 52
4416:             .Height        = 23
4417:             .FontName      = "Tahoma"
4418:             .FontSize      = 8
4419:             .Value         = ""
4420:             .SpecialEffect = 1
4421:             .Visible       = .T.
4422:         ENDWITH
4423:         BINDEVENT(loc_oPg.txt_4c_Conjunto, "KeyPress",  THIS, "TxtConjuntoKeyPress")
4424: 
4425:         *-- Linha 5 (T:226-230): Linha
4426:         *-- Say16: "Linha :" (T:230 L:77 W:34)
4427:         loc_oPg.AddObject("lbl_4c_LblLinha", "Label")
4428:         WITH loc_oPg.lbl_4c_LblLinha
4429:             .Caption   = "Linha :"
4430:             .Top       = 230
4431:             .Left      = 77
4432:             .Width     = 34
4433:             .Height    = 15
4434:             .FontName  = "Tahoma"
4435:             .FontSize  = 8
4436:             .BackStyle = 0
4437:             .ForeColor = RGB(90, 90, 90)
4438:             .Visible   = .T.
4439:         ENDWITH
4440: 
4441:         *-- GetLin -> txt_4c_Lin (T:226 L:113 W:80 H:23) - codigo de linha
4442:         loc_oPg.AddObject("txt_4c_Lin", "TextBox")
4443:         WITH loc_oPg.txt_4c_Lin
4444:             .Top           = 226
4445:             .Left          = 113
4446:             .Width         = 80
4447:             .Height        = 23
4448:             .FontName      = "Tahoma"
4449:             .FontSize      = 8
4450:             .Value         = ""
4451:             .SpecialEffect = 1
4452:             .Visible       = .T.
4453:         ENDWITH
4454:         BINDEVENT(loc_oPg.txt_4c_Lin, "KeyPress",  THIS, "TxtLinKeyPress")
4455:         BINDEVENT(loc_oPg.txt_4c_Lin, "LostFocus", THIS, "TxtLinLostFocus")
4456: 
4457:         *-- GetDLin -> txt_4c_DLin (T:226 L:194 W:318 H:23) - desc linha (readonly)
4458:         loc_oPg.AddObject("txt_4c_DLin", "TextBox")
4459:         WITH loc_oPg.txt_4c_DLin
4460:             .Top           = 226
4461:             .Left          = 194
4462:             .Width         = 318
4463:             .Height        = 23
4464:             .FontName      = "Tahoma"
4465:             .FontSize      = 8
4466:             .ReadOnly      = .T.
4467:             .Value         = ""
4468:             .SpecialEffect = 1
4469:             .Visible       = .T.
4470:         ENDWITH
4471: 
4472:         *-- Linha 6 (T:250-253): Grupo de Venda (Colecoes)
4473:         *-- Say17: "Grupo de Venda :" (T:253 L:25 W:86)
4474:         loc_oPg.AddObject("lbl_4c_LblGVenda", "Label")
4475:         WITH loc_oPg.lbl_4c_LblGVenda
4476:             .Caption   = "Grupo de Venda :"
4477:             .Top       = 253
4478:             .Left      = 25
4479:             .Width     = 86
4480:             .Height    = 15
4481:             .FontName  = "Tahoma"
4482:             .FontSize  = 8
4483:             .BackStyle = 0
4484:             .ForeColor = RGB(90, 90, 90)
4485:             .Visible   = .T.
4486:         ENDWITH
4487: 
4488:         *-- GetCol -> txt_4c_Col (T:250 L:113 W:80 H:23) - colecoes (grupo venda)
4489:         loc_oPg.AddObject("txt_4c_Col", "TextBox")
4490:         WITH loc_oPg.txt_4c_Col
4491:             .Top           = 250
4492:             .Left          = 113
4493:             .Width         = 80
4494:             .Height        = 23
4495:             .FontName      = "Tahoma"
4496:             .FontSize      = 8
4497:             .Value         = ""
4498:             .SpecialEffect = 1
4499:             .Visible       = .T.
4500:         ENDWITH
4501:         BINDEVENT(loc_oPg.txt_4c_Col, "KeyPress",  THIS, "TxtColKeyPress")
4502:         BINDEVENT(loc_oPg.txt_4c_Col, "LostFocus", THIS, "TxtColLostFocus")
4503: 
4504:         *-- GetDCol -> txt_4c_DCol (T:250 L:194 W:318 H:23) - desc grupo venda (readonly)
4505:         loc_oPg.AddObject("txt_4c_DCol", "TextBox")
4506:         WITH loc_oPg.txt_4c_DCol
4507:             .Top           = 250
4508:             .Left          = 194
4509:             .Width         = 318
4510:             .Height        = 23
4511:             .FontName      = "Tahoma"
4512:             .FontSize      = 8
4513:             .ReadOnly      = .T.
4514:             .Value         = ""
4515:             .SpecialEffect = 1
4516:             .Visible       = .T.
4517:         ENDWITH
4518: 
4519:         *-- Linha 7 (T:274-278): Fornecedor
4520:         *-- Say11: "Fornecedor :" (T:278 L:47 W:64)
4521:         loc_oPg.AddObject("lbl_4c_LblFornecedor", "Label")
4522:         WITH loc_oPg.lbl_4c_LblFornecedor
4523:             .Caption   = "Fornecedor :"
4524:             .Top       = 278
4525:             .Left      = 47
4526:             .Width     = 64
4527:             .Height    = 15
4528:             .FontName  = "Tahoma"
4529:             .FontSize  = 8
4530:             .BackStyle = 0
4531:             .ForeColor = RGB(90, 90, 90)
4532:             .Visible   = .T.
4533:         ENDWITH
4534: 
4535:         *-- getIfor -> txt_4c_Ifor (T:274 L:113 W:80 H:23) - codigo fornecedor
4536:         loc_oPg.AddObject("txt_4c_Ifor", "TextBox")
4537:         WITH loc_oPg.txt_4c_Ifor
4538:             .Top           = 274
4539:             .Left          = 113
4540:             .Width         = 80
4541:             .Height        = 23
4542:             .FontName      = "Tahoma"
4543:             .FontSize      = 8
4544:             .MaxLength     = 10
4545:             .Value         = ""
4546:             .SpecialEffect = 1
4547:             .Visible       = .T.
4548:         ENDWITH
4549:         BINDEVENT(loc_oPg.txt_4c_Ifor, "KeyPress",  THIS, "TxtIforKeyPress")
4550:         BINDEVENT(loc_oPg.txt_4c_Ifor, "LostFocus", THIS, "TxtIforLostFocus")
4551: 
4552:         *-- getDfor -> txt_4c_Dfor (T:274 L:194 W:318 H:23) - desc fornecedor (readonly)
4553:         loc_oPg.AddObject("txt_4c_Dfor", "TextBox")
4554:         WITH loc_oPg.txt_4c_Dfor
4555:             .Top           = 274
4556:             .Left          = 194
4557:             .Width         = 318
4558:             .Height        = 23
4559:             .FontName      = "Tahoma"
4560:             .FontSize      = 8
4561:             .ReadOnly      = .T.
4562:             .Value         = ""
4563:             .SpecialEffect = 1
4564:             .Visible       = .T.
4565:         ENDWITH
4566: 
4567:         *-- Linha 8 (T:298-301): Ref. Fornecedor
4568:         *-- Say12: "Ref. Fornecedor :" (T:301 L:23 W:88)
4569:         loc_oPg.AddObject("lbl_4c_LblRefs", "Label")
4570:         WITH loc_oPg.lbl_4c_LblRefs
4571:             .Caption   = "Ref. Fornecedor :"
4572:             .Top       = 301
4573:             .Left      = 23
4574:             .Width     = 88
4575:             .Height    = 15
4576:             .FontName  = "Tahoma"
4577:             .FontSize  = 8
4578:             .BackStyle = 0
4579:             .ForeColor = RGB(90, 90, 90)
4580:             .Visible   = .T.
4581:         ENDWITH
4582: 
4583:         *-- getRefs -> txt_4c_Refs (T:298 L:113 W:152 H:23) - referencia fornecedor
4584:         loc_oPg.AddObject("txt_4c_Refs", "TextBox")
4585:         WITH loc_oPg.txt_4c_Refs
4586:             .Top           = 298
4587:             .Left          = 113
4588:             .Width         = 152
4589:             .Height        = 23
4590:             .FontName      = "Tahoma"

*-- Linhas 4603 a 4646:
4603:     * PreencherDescricoesPgDados - Busca descricoes dos campos lookup (readonly)
4604:     * Chamado por BOParaForm apos preencher codigos
4605:     *--------------------------------------------------------------------------
4606:     PROCEDURE PreencherDescricoesPgDados()
4607:         LOCAL loc_oPg, loc_cCod, loc_nRet
4608:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4609: 
4610:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4611:             RETURN
4612:         ENDIF
4613: 
4614:         TRY
4615:             *-- Descricao do Grupo (cgrus -> SigCdGrp.dgrus)
4616:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4617:             IF !EMPTY(loc_cCod)
4618:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4619:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
4620:                     "cursor_4c_TmpDgru")
4621:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpDgru") > 0
4622:                     loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpDgru.dgrus)
4623:                 ENDIF
4624:                 IF USED("cursor_4c_TmpDgru")
4625:                     USE IN cursor_4c_TmpDgru
4626:                 ENDIF
4627:             ENDIF
4628: 
4629:             *-- Descricao do SubGrupo (sgrus -> SigCdPsg.descricaos, filtrado por cgrus)
4630:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4631:             IF !EMPTY(loc_cCod)
4632:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4633:                     "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cCod) + ;
4634:                     " AND cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CgruP.Value)), ;
4635:                     "cursor_4c_TmpSGru")
4636:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4637:                     loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4638:                 ENDIF
4639:                 IF USED("cursor_4c_TmpSGru")
4640:                     USE IN cursor_4c_TmpSGru
4641:                 ENDIF
4642:             ENDIF
4643: 
4644:             *-- Descricao da Linha (linhas -> SigCdLin.descs)
4645:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4646:             IF !EMPTY(loc_cCod)

*-- Linhas 4690 a 5258:
4690: 
4691:     *==========================================================================
4692:     * HANDLERS DE EVENTOS - Lookups da Aba Dados (Fase 5)
4693:     * BINDEVENT exige PUBLIC: sem prefixo PROTECTED
4694:     *==========================================================================
4695: 
4696:     *--------------------------------------------------------------------------
4697:     * TxtCgruP - F4 abre lookup de grupos; LostFocus valida codigo
4698:     *--------------------------------------------------------------------------
4699:     PROCEDURE TxtCgruPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4700:         IF par_nKeyCode = 115 && F4
4701:             THIS.AbrirLookupGrupoP2()
4702:         ENDIF
4703:     ENDPROC
4704: 
4705:     PROCEDURE TxtCgruPLostFocus()
4706:         LOCAL loc_oPg, loc_cCgru, loc_nRet
4707:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4708:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4709: 
4710:         IF EMPTY(loc_cCgru)
4711:             loc_oPg.txt_4c_DgruP.Value = ""
4712:             RETURN
4713:         ENDIF
4714:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4715:             RETURN
4716:         ENDIF
4717: 
4718:         TRY
4719:             loc_nRet = SQLEXEC(gnConnHandle, ;
4720:                 "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
4721:                 "cursor_4c_TmpGruP")
4722:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGruP") > 0
4723:                 loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpGruP.dgrus)
4724:                 *-- Limpar subgrupo ao trocar grupo
4725:                 loc_oPg.txt_4c_CSGru.Value = ""
4726:                 loc_oPg.txt_4c_DsGru.Value = ""
4727:             ELSE
4728:                 MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
4729:                 loc_oPg.txt_4c_CgruP.Value = ""
4730:                 loc_oPg.txt_4c_DgruP.Value = ""
4731:             ENDIF
4732:             IF USED("cursor_4c_TmpGruP")
4733:                 USE IN cursor_4c_TmpGruP
4734:             ENDIF
4735:         CATCH TO loc_oErro
4736:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4737:         ENDTRY
4738:     ENDPROC
4739: 
4740:     PROCEDURE AbrirLookupGrupoP2()
4741:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
4742:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4743:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4744: 
4745:         TRY
4746:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4747:                 "SigCdGrp", "cursor_4c_BuscaGruP", "cgrus", loc_cAtual, ;
4748:                 "Buscar Grupo de Produto")
4749:             IF VARTYPE(loc_oBusca) = "O"
4750:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4751:                     IF USED("cursor_4c_BuscaGruP")
4752:                         loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
4753:                         loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
4754:                         loc_oPg.txt_4c_CSGru.Value = ""
4755:                         loc_oPg.txt_4c_DsGru.Value = ""
4756:                     ENDIF
4757:                 ELSE
4758:                     IF !loc_oBusca.this_lAchouRegistro
4759:                     loc_oBusca.mAddColuna("cgrus", "", "Grupo")
4760:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4761:                     loc_oBusca.Show()
4762:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruP")
4763:                         loc_oPg.txt_4c_CgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.cgrus)
4764:                         loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_BuscaGruP.dgrus)
4765:                         loc_oPg.txt_4c_CSGru.Value = ""
4766:                         loc_oPg.txt_4c_DsGru.Value = ""
4767:                     ENDIF
4768:                     ENDIF
4769:                 ENDIF
4770:                 loc_oBusca.Release()
4771:             ENDIF
4772:             IF USED("cursor_4c_BuscaGruP")
4773:                 USE IN cursor_4c_BuscaGruP
4774:             ENDIF
4775:         CATCH TO loc_oErro
4776:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
4777:         ENDTRY
4778:     ENDPROC
4779: 
4780:     *--------------------------------------------------------------------------
4781:     * TxtCSGru - F4 abre lookup de subgrupos filtrados por cgrus; LostFocus valida
4782:     *--------------------------------------------------------------------------
4783:     PROCEDURE TxtCSGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4784:         IF par_nKeyCode = 115 && F4
4785:             THIS.AbrirLookupSubGrupo()
4786:         ENDIF
4787:     ENDPROC
4788: 
4789:     PROCEDURE TxtCSGruLostFocus()
4790:         LOCAL loc_oPg, loc_cSGru, loc_cCgru, loc_nRet
4791:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4792:         loc_cSGru = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4793:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4794: 
4795:         IF EMPTY(loc_cSGru)
4796:             loc_oPg.txt_4c_DsGru.Value = ""
4797:             RETURN
4798:         ENDIF
4799:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4800:             RETURN
4801:         ENDIF
4802: 
4803:         TRY
4804:             loc_nRet = SQLEXEC(gnConnHandle, ;
4805:                 "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cSGru) + ;
4806:                 IIF(EMPTY(loc_cCgru), "", " AND cgrus = " + EscaparSQL(loc_cCgru)), ;
4807:                 "cursor_4c_TmpSGru")
4808:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4809:                 loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4810:             ELSE
4811:                 MsgAviso("Subgrupo '" + loc_cSGru + "' n" + CHR(227) + "o encontrado!")
4812:                 loc_oPg.txt_4c_CSGru.Value = ""
4813:                 loc_oPg.txt_4c_DsGru.Value = ""
4814:             ENDIF
4815:             IF USED("cursor_4c_TmpSGru")
4816:                 USE IN cursor_4c_TmpSGru
4817:             ENDIF
4818:         CATCH TO loc_oErro
4819:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
4820:         ENDTRY
4821:     ENDPROC
4822: 
4823:     PROCEDURE AbrirLookupSubGrupo()
4824:         LOCAL loc_oBusca, loc_oPg, loc_cCgru, loc_cAtual
4825:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4826:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4827:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4828: 
4829:         TRY
4830:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4831:                 "SigCdPsg", "cursor_4c_BuscaSGru", "codigos", loc_cAtual, ;
4832:                 "Buscar Subgrupo", .F., .T., ;
4833:                 IIF(EMPTY(loc_cCgru), "", "cgrus = " + EscaparSQL(loc_cCgru)))
4834:             IF VARTYPE(loc_oBusca) = "O"
4835:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4836:                     IF USED("cursor_4c_BuscaSGru")
4837:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4838:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4839:                     ENDIF
4840:                 ELSE
4841:                     IF !loc_oBusca.this_lAchouRegistro
4842:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
4843:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4844:                     loc_oBusca.Show()
4845:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
4846:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4847:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4848:                     ENDIF
4849:                     ENDIF
4850:                 ENDIF
4851:                 loc_oBusca.Release()
4852:             ENDIF
4853:             IF USED("cursor_4c_BuscaSGru")
4854:                 USE IN cursor_4c_BuscaSGru
4855:             ENDIF
4856:         CATCH TO loc_oErro
4857:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
4858:         ENDTRY
4859:     ENDPROC
4860: 
4861:     *--------------------------------------------------------------------------
4862:     * TxtLin - F4 abre lookup de linhas; LostFocus valida codigo
4863:     *--------------------------------------------------------------------------
4864:     PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4865:         IF par_nKeyCode = 115 && F4
4866:             THIS.AbrirLookupLinha()
4867:         ENDIF
4868:     ENDPROC
4869: 
4870:     PROCEDURE TxtLinLostFocus()
4871:         LOCAL loc_oPg, loc_cLin, loc_nRet
4872:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4873:         loc_cLin = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4874: 
4875:         IF EMPTY(loc_cLin)
4876:             loc_oPg.txt_4c_DLin.Value = ""
4877:             RETURN
4878:         ENDIF
4879:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4880:             RETURN
4881:         ENDIF
4882: 
4883:         TRY
4884:             loc_nRet = SQLEXEC(gnConnHandle, ;
4885:                 "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLin), ;
4886:                 "cursor_4c_TmpLin")
4887:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
4888:                 loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
4889:             ELSE
4890:                 MsgAviso("Linha '" + loc_cLin + "' n" + CHR(227) + "o encontrada!")
4891:                 loc_oPg.txt_4c_Lin.Value  = ""
4892:                 loc_oPg.txt_4c_DLin.Value = ""
4893:             ENDIF
4894:             IF USED("cursor_4c_TmpLin")
4895:                 USE IN cursor_4c_TmpLin
4896:             ENDIF
4897:         CATCH TO loc_oErro
4898:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
4899:         ENDTRY
4900:     ENDPROC
4901: 
4902:     PROCEDURE AbrirLookupLinha()
4903:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
4904:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4905:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4906: 
4907:         TRY
4908:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4909:                 "SigCdLin", "cursor_4c_BuscaLin", "linhas", loc_cAtual, ;
4910:                 "Buscar Linha")
4911:             IF VARTYPE(loc_oBusca) = "O"
4912:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4913:                     IF USED("cursor_4c_BuscaLin")
4914:                         loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
4915:                         loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
4916:                     ENDIF
4917:                 ELSE
4918:                     IF !loc_oBusca.this_lAchouRegistro
4919:                     loc_oBusca.mAddColuna("linhas", "", "Linha")
4920:                     loc_oBusca.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4921:                     loc_oBusca.Show()
4922:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
4923:                         loc_oPg.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_BuscaLin.linhas)
4924:                         loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_BuscaLin.descs)
4925:                     ENDIF
4926:                     ENDIF
4927:                 ENDIF
4928:                 loc_oBusca.Release()
4929:             ENDIF
4930:             IF USED("cursor_4c_BuscaLin")
4931:                 USE IN cursor_4c_BuscaLin
4932:             ENDIF
4933:         CATCH TO loc_oErro
4934:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
4935:         ENDTRY
4936:     ENDPROC
4937: 
4938:     *--------------------------------------------------------------------------
4939:     * TxtCol - F4 abre lookup de grupos de venda (SIGCDCOL); LostFocus valida
4940:     *--------------------------------------------------------------------------
4941:     PROCEDURE TxtColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4942:         IF par_nKeyCode = 115 && F4
4943:             THIS.AbrirLookupGVenda()
4944:         ENDIF
4945:     ENDPROC
4946: 
4947:     PROCEDURE TxtColLostFocus()
4948:         LOCAL loc_oPg, loc_cCol, loc_nRet
4949:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4950:         loc_cCol = ALLTRIM(loc_oPg.txt_4c_Col.Value)
4951: 
4952:         IF EMPTY(loc_cCol)
4953:             loc_oPg.txt_4c_DCol.Value = ""
4954:             RETURN
4955:         ENDIF
4956:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
4957:             RETURN
4958:         ENDIF
4959: 
4960:         TRY
4961:             loc_nRet = SQLEXEC(gnConnHandle, ;
4962:                 "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCol), ;
4963:                 "cursor_4c_TmpCol")
4964:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
4965:                 loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
4966:             ELSE
4967:                 MsgAviso("Grupo de Venda '" + loc_cCol + "' n" + CHR(227) + "o encontrado!")
4968:                 loc_oPg.txt_4c_Col.Value  = ""
4969:                 loc_oPg.txt_4c_DCol.Value = ""
4970:             ENDIF
4971:             IF USED("cursor_4c_TmpCol")
4972:                 USE IN cursor_4c_TmpCol
4973:             ENDIF
4974:         CATCH TO loc_oErro
4975:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
4976:         ENDTRY
4977:     ENDPROC
4978: 
4979:     PROCEDURE AbrirLookupGVenda()
4980:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
4981:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
4982:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Col.Value)
4983: 
4984:         TRY
4985:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4986:                 "SIGCDCOL", "cursor_4c_BuscaCol", "colecoes", loc_cAtual, ;
4987:                 "Buscar Grupo de Venda")
4988:             IF VARTYPE(loc_oBusca) = "O"
4989:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4990:                     IF USED("cursor_4c_BuscaCol")
4991:                         loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
4992:                         loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
4993:                     ENDIF
4994:                 ELSE
4995:                     IF !loc_oBusca.this_lAchouRegistro
4996:                     loc_oBusca.mAddColuna("colecoes", "", "C" + CHR(243) + "digo")
4997:                     loc_oBusca.mAddColuna("descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
4998:                     loc_oBusca.Show()
4999:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
5000:                         loc_oPg.txt_4c_Col.Value  = ALLTRIM(cursor_4c_BuscaCol.colecoes)
5001:                         loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_BuscaCol.descs)
5002:                     ENDIF
5003:                     ENDIF
5004:                 ENDIF
5005:                 loc_oBusca.Release()
5006:             ENDIF
5007:             IF USED("cursor_4c_BuscaCol")
5008:                 USE IN cursor_4c_BuscaCol
5009:             ENDIF
5010:         CATCH TO loc_oErro
5011:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo de venda")
5012:         ENDTRY
5013:     ENDPROC
5014: 
5015:     *--------------------------------------------------------------------------
5016:     * TxtIfor - F4 abre lookup de fornecedores (SigCdCli); LostFocus valida
5017:     *--------------------------------------------------------------------------
5018:     PROCEDURE TxtIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5019:         IF par_nKeyCode = 115 && F4
5020:             THIS.AbrirLookupFornecedor()
5021:         ENDIF
5022:     ENDPROC
5023: 
5024:     PROCEDURE TxtIforLostFocus()
5025:         LOCAL loc_oPg, loc_cIfor, loc_nRet
5026:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5027:         loc_cIfor = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
5028: 
5029:         IF EMPTY(loc_cIfor)
5030:             loc_oPg.txt_4c_Dfor.Value = ""
5031:             RETURN
5032:         ENDIF
5033:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
5034:             RETURN
5035:         ENDIF
5036: 
5037:         TRY
5038:             loc_nRet = SQLEXEC(gnConnHandle, ;
5039:                 "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cIfor), ;
5040:                 "cursor_4c_TmpIfor")
5041:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
5042:                 loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
5043:             ELSE
5044:                 MsgAviso("Fornecedor '" + loc_cIfor + "' n" + CHR(227) + "o encontrado!")
5045:                 loc_oPg.txt_4c_Ifor.Value = ""
5046:                 loc_oPg.txt_4c_Dfor.Value = ""
5047:             ENDIF
5048:             IF USED("cursor_4c_TmpIfor")
5049:                 USE IN cursor_4c_TmpIfor
5050:             ENDIF
5051:         CATCH TO loc_oErro
5052:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5053:         ENDTRY
5054:     ENDPROC
5055: 
5056:     PROCEDURE AbrirLookupFornecedor()
5057:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
5058:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5059:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
5060: 
5061:         TRY
5062:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5063:                 "SigCdCli", "cursor_4c_BuscaIfor", "iclis", loc_cAtual, ;
5064:                 "Buscar Fornecedor")
5065:             IF VARTYPE(loc_oBusca) = "O"
5066:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
5067:                     IF USED("cursor_4c_BuscaIfor")
5068:                         loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
5069:                         loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
5070:                     ENDIF
5071:                 ELSE
5072:                     IF !loc_oBusca.this_lAchouRegistro
5073:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
5074:                     loc_oBusca.mAddColuna("rclis", "", "Nome/Raz" + CHR(227) + "o Social")
5075:                     loc_oBusca.Show()
5076:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
5077:                         loc_oPg.txt_4c_Ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.iclis)
5078:                         loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.rclis)
5079:                     ENDIF
5080:                     ENDIF
5081:                 ENDIF
5082:                 loc_oBusca.Release()
5083:             ENDIF
5084:             IF USED("cursor_4c_BuscaIfor")
5085:                 USE IN cursor_4c_BuscaIfor
5086:             ENDIF
5087:         CATCH TO loc_oErro
5088:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
5089:         ENDTRY
5090:     ENDPROC
5091: 
5092:     *--------------------------------------------------------------------------
5093:     * TxtCProEq - F4 abre lookup de produto equivalente; LostFocus valida
5094:     *--------------------------------------------------------------------------
5095:     PROCEDURE TxtCProEqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5096:         IF par_nKeyCode = 115 && F4
5097:             THIS.AbrirLookupProdEq()
5098:         ENDIF
5099:     ENDPROC
5100: 
5101:     PROCEDURE TxtCProEqLostFocus()
5102:         LOCAL loc_oPg, loc_cCpro, loc_nRet
5103:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5104:         loc_cCpro = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
5105: 
5106:         IF EMPTY(loc_cCpro)
5107:             RETURN
5108:         ENDIF
5109:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
5110:             RETURN
5111:         ENDIF
5112: 
5113:         TRY
5114:             loc_nRet = SQLEXEC(gnConnHandle, ;
5115:                 "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpro), ;
5116:                 "cursor_4c_TmpProEq")
5117:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpProEq") = 0
5118:                 MsgAviso("Produto equivalente '" + loc_cCpro + "' n" + CHR(227) + "o encontrado!")
5119:                 loc_oPg.txt_4c_CProEq.Value = ""
5120:             ENDIF
5121:             IF USED("cursor_4c_TmpProEq")
5122:                 USE IN cursor_4c_TmpProEq
5123:             ENDIF
5124:         CATCH TO loc_oErro
5125:             MsgErro(loc_oErro.Message, "Erro ao validar produto equivalente")
5126:         ENDTRY
5127:     ENDPROC
5128: 
5129:     PROCEDURE AbrirLookupProdEq()
5130:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
5131:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5132:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)
5133: 
5134:         TRY
5135:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5136:                 "SigCdPro", "cursor_4c_BuscaProEq", "cpros", loc_cAtual, ;
5137:                 "Buscar Produto Equivalente")
5138:             IF VARTYPE(loc_oBusca) = "O"
5139:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
5140:                     IF USED("cursor_4c_BuscaProEq")
5141:                         loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
5142:                     ENDIF
5143:                 ELSE
5144:                     IF !loc_oBusca.this_lAchouRegistro
5145:                     loc_oBusca.mAddColuna("cpros", "", "Produto")
5146:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
5147:                     loc_oBusca.Show()
5148:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProEq")
5149:                         loc_oPg.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaProEq.cpros)
5150:                     ENDIF
5151:                     ENDIF
5152:                 ENDIF
5153:                 loc_oBusca.Release()
5154:             ENDIF
5155:             IF USED("cursor_4c_BuscaProEq")
5156:                 USE IN cursor_4c_BuscaProEq
5157:             ENDIF
5158:         CATCH TO loc_oErro
5159:             MsgErro(loc_oErro.Message, "Erro ao buscar produto equivalente")
5160:         ENDTRY
5161:     ENDPROC
5162: 
5163:     *--------------------------------------------------------------------------
5164:     * TxtConjunto - F4 abre lookup de conjuntos (valores distintos de SigCdPro)
5165:     *--------------------------------------------------------------------------
5166:     PROCEDURE TxtConjuntoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5167:         IF par_nKeyCode = 115 && F4
5168:             THIS.AbrirLookupConjunto()
5169:         ENDIF
5170:     ENDPROC
5171: 
5172:     PROCEDURE AbrirLookupConjunto()
5173:         LOCAL loc_oBusca, loc_oPg, loc_nRet
5174:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5175: 
5176:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
5177:             RETURN
5178:         ENDIF
5179: 
5180:         TRY
5181:             *-- Busca conjuntos distintos ja cadastrados em SigCdPro
5182:             loc_nRet = SQLEXEC(gnConnHandle, ;
5183:                 "SELECT DISTINCT conjunts FROM SigCdPro WHERE LTRIM(RTRIM(conjunts)) <> '' ORDER BY conjunts", ;
5184:                 "cursor_4c_BuscaCnj")
5185: 
5186:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaCnj") > 0
5187:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5188:                 IF VARTYPE(loc_oBusca) = "O"
5189:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
5190:                     loc_oBusca.this_cTitulo        = "Buscar Conjunto"
5191:                     loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
5192:                     loc_oBusca.Show()
5193:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
5194:                         loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
5195:                     ENDIF
5196:                     loc_oBusca.Release()
5197:                 ENDIF
5198:             ENDIF
5199: 
5200:             IF USED("cursor_4c_BuscaCnj")
5201:                 USE IN cursor_4c_BuscaCnj
5202:             ENDIF
5203:         CATCH TO loc_oErro
5204:             MsgErro(loc_oErro.Message, "Erro ao buscar conjunto")
5205:         ENDTRY
5206:     ENDPROC
5207: 
5208:     *==========================================================================
5209:     * FASE 6 - Configuracao da Aba Dados (pgDados - campos restantes)
5210:     *==========================================================================
5211: 
5212:     *--------------------------------------------------------------------------
5213:     * ConfigurarPgDadosP2 - Configura campos restantes da aba Dados
5214:     * Cobre: Qt.Pedido, Garantia, Dimensoes fisicas, Ultima Compra,
5215:     *        Modelo, Acabamento, Classif., Local, Custos, Unidades,
5216:     *        Auditoria, CodIdent, Checkboxes, Memos, Dimensoes embalagem
5217:     *--------------------------------------------------------------------------
5218:     PROTECTED PROCEDURE ConfigurarPgDadosP2()
5219:         LOCAL loc_oPg
5220:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
5221: 
5222:         *----------------------------------------------------------------------
5223:         *-- CheckBox fwoption1: "Peso Variavel" (T:172 L:879 W:90 H:15)
5224:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados - prodvars
5225:         *----------------------------------------------------------------------
5226:         loc_oPg.AddObject("chk_4c_Fwoption1", "CheckBox")
5227:         WITH loc_oPg.chk_4c_Fwoption1
5228:             .Caption   = "Peso Vari" + CHR(225) + "vel"
5229:             .Top       = 172
5230:             .Left      = 879
5231:             .Width     = 90
5232:             .Height    = 15
5233:             .Value     = 0
5234:             .FontName  = "Tahoma"
5235:             .FontSize  = 8
5236:             .BackStyle = 0
5237:             .Themes    = .F.
5238:             .Enabled   = .F.
5239:             .Visible   = .T.
5240:         ENDWITH
5241: 
5242:         *----------------------------------------------------------------------
5243:         *-- Qt. Pedido (T:221 L:626) + Garantia (T:224 L:880)
5244:         *----------------------------------------------------------------------
5245:         loc_oPg.AddObject("lbl_4c_LblQtPed", "Label")
5246:         WITH loc_oPg.lbl_4c_LblQtPed
5247:             .Caption   = "Qt. Pedido :"
5248:             .Top       = 224
5249:             .Left      = 541
5250:             .Width     = 80
5251:             .Height    = 15
5252:             .FontName  = "Tahoma"
5253:             .FontSize  = 8
5254:             .BackStyle = 0
5255:             .ForeColor = RGB(90, 90, 90)
5256:             .Visible   = .T.
5257:         ENDWITH
5258: 

*-- Linhas 5676 a 5720:
5676:             .SpecialEffect = 1
5677:             .Visible       = .T.
5678:         ENDWITH
5679:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "KeyPress",  THIS, "TxtCodFinPKeyPress")
5680:         BINDEVENT(loc_oPg.txt_4c_CodFinP, "LostFocus", THIS, "TxtCodFinPLostFocus")
5681: 
5682:         *-- Say35: "Peso Bruto :" (T:326 L:336 W:61)
5683:         loc_oPg.AddObject("lbl_4c_LblPesoBs", "Label")
5684:         WITH loc_oPg.lbl_4c_LblPesoBs
5685:             .Caption   = "Peso Bruto :"
5686:             .Top       = 326
5687:             .Left      = 336
5688:             .Width     = 61
5689:             .Height    = 15
5690:             .FontName  = "Tahoma"
5691:             .FontSize  = 8
5692:             .BackStyle = 0
5693:             .ForeColor = RGB(90, 90, 90)
5694:             .Visible   = .T.
5695:         ENDWITH
5696: 
5697:         *-- getPesoBs -> txt_4c_PesoBs (T:322 L:401 W:111 H:23) - pesobs numeric(7,3)
5698:         loc_oPg.AddObject("txt_4c_PesoBs", "TextBox")
5699:         WITH loc_oPg.txt_4c_PesoBs
5700:             .Top           = 322
5701:             .Left          = 401
5702:             .Width         = 111
5703:             .Height        = 23
5704:             .FontName      = "Tahoma"
5705:             .FontSize      = 8
5706:             .MaxLength     = 10
5707:             .Value         = ""
5708:             .SpecialEffect = 1
5709:             .Visible       = .T.
5710:         ENDWITH
5711: 
5712:         *----------------------------------------------------------------------
5713:         *-- Acabamento (T:346) - lblAcabamento: "Acabamento :" (T:350 L:7)
5714:         *----------------------------------------------------------------------
5715:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
5716:         WITH loc_oPg.lbl_4c_LblAcabamento
5717:             .Caption   = "Acabamento :"
5718:             .Top       = 350
5719:             .Left      = 7
5720:             .Width     = 104

*-- Linhas 5755 a 5799:
5755:             .SpecialEffect = 1
5756:             .Visible       = .T.
5757:         ENDWITH
5758:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "KeyPress",  THIS, "TxtCodAcbKeyPress")
5759:         BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "TxtCodAcbLostFocus")
5760: 
5761:         *-- Say34: "Peso Liquido :" (T:350 L:329 W:68)
5762:         loc_oPg.AddObject("lbl_4c_LblPmedio", "Label")
5763:         WITH loc_oPg.lbl_4c_LblPmedio
5764:             .Caption   = "Peso L" + CHR(237) + "quido :"
5765:             .Top       = 350
5766:             .Left      = 329
5767:             .Width     = 68
5768:             .Height    = 15
5769:             .FontName  = "Tahoma"
5770:             .FontSize  = 8
5771:             .BackStyle = 0
5772:             .ForeColor = RGB(90, 90, 90)
5773:             .Visible   = .T.
5774:         ENDWITH
5775: 
5776:         *-- getPmedio -> txt_4c_Pmedio (T:346 L:401 W:111 H:23) - pesoms numeric(8,3)
5777:         loc_oPg.AddObject("txt_4c_Pmedio", "TextBox")
5778:         WITH loc_oPg.txt_4c_Pmedio
5779:             .Top           = 346
5780:             .Left          = 401
5781:             .Width         = 111
5782:             .Height        = 23
5783:             .FontName      = "Tahoma"
5784:             .FontSize      = 8
5785:             .MaxLength     = 10
5786:             .Value         = ""
5787:             .SpecialEffect = 1
5788:             .Visible       = .T.
5789:         ENDWITH
5790: 
5791:         *----------------------------------------------------------------------
5792:         *-- Estoque (T:353) - Say28: "Estoque :" (T:357 L:577 W:48)
5793:         *----------------------------------------------------------------------
5794:         loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
5795:         WITH loc_oPg.lbl_4c_LblEstoque
5796:             .Caption   = "Estoque :"
5797:             .Top       = 357
5798:             .Left      = 577
5799:             .Width     = 48

*-- Linhas 5885 a 5961:
5885:             .SpecialEffect = 1
5886:             .Visible       = .T.
5887:         ENDWITH
5888:         BINDEVENT(loc_oPg.txt_4c_Class, "KeyPress",  THIS, "TxtClassKeyPress")
5889:         BINDEVENT(loc_oPg.txt_4c_Class, "LostFocus", THIS, "TxtClassLostFocus")
5890: 
5891:         *-- Say5: "Local :" (T:374 L:364 W:33)
5892:         loc_oPg.AddObject("lbl_4c_LblLocal", "Label")
5893:         WITH loc_oPg.lbl_4c_LblLocal
5894:             .Caption   = "Local :"
5895:             .Top       = 374
5896:             .Left      = 364
5897:             .Width     = 33
5898:             .Height    = 15
5899:             .FontName  = "Tahoma"
5900:             .FontSize  = 8
5901:             .BackStyle = 0
5902:             .ForeColor = RGB(90, 90, 90)
5903:             .Visible   = .T.
5904:         ENDWITH
5905: 
5906:         *-- Get_Local -> txt_4c_Local (T:370 L:401 W:111 H:23) - locals char(10)
5907:         loc_oPg.AddObject("txt_4c_Local", "TextBox")
5908:         WITH loc_oPg.txt_4c_Local
5909:             .Top           = 370
5910:             .Left          = 401
5911:             .Width         = 111
5912:             .Height        = 23
5913:             .FontName      = "Tahoma"
5914:             .FontSize      = 8
5915:             .MaxLength     = 10
5916:             .Value         = ""
5917:             .SpecialEffect = 1
5918:             .Visible       = .T.
5919:         ENDWITH
5920:         BINDEVENT(loc_oPg.txt_4c_Local, "KeyPress",  THIS, "TxtLocalKeyPress")
5921:         BINDEVENT(loc_oPg.txt_4c_Local, "LostFocus", THIS, "TxtLocalLostFocus")
5922: 
5923:         *----------------------------------------------------------------------
5924:         *-- Custo (T:375) - Say3: "Valor de Custo :" (T:379 L:546 W:79)
5925:         *----------------------------------------------------------------------
5926:         loc_oPg.AddObject("lbl_4c_LblCusto", "Label")
5927:         WITH loc_oPg.lbl_4c_LblCusto
5928:             .Caption   = "Valor de Custo :"
5929:             .Top       = 379
5930:             .Left      = 546
5931:             .Width     = 79
5932:             .Height    = 15
5933:             .FontName  = "Tahoma"
5934:             .FontSize  = 8
5935:             .BackStyle = 0
5936:             .ForeColor = RGB(90, 90, 90)
5937:             .Visible   = .T.
5938:         ENDWITH
5939: 
5940:         *-- getCtotal -> txt_4c_Ctotal (T:375 L:626 W:127 H:21) - custofs (display)
5941:         loc_oPg.AddObject("txt_4c_Ctotal", "TextBox")
5942:         WITH loc_oPg.txt_4c_Ctotal
5943:             .Top           = 375
5944:             .Left          = 626
5945:             .Width         = 127
5946:             .Height        = 21
5947:             .FontName      = "Tahoma"
5948:             .FontSize      = 8
5949:             .ReadOnly      = .T.
5950:             .MaxLength     = 14
5951:             .Value         = ""
5952:             .SpecialEffect = 1
5953:             .ForeColor     = RGB(36, 84, 155)
5954:             .BackColor     = RGB(224, 235, 235)
5955:             .Visible       = .T.
5956:         ENDWITH
5957: 
5958:         *-- getMctotal -> txt_4c_Mctotal (T:375 L:754 W:31 H:21) - moecusfs (display)
5959:         loc_oPg.AddObject("txt_4c_Mctotal", "TextBox")
5960:         WITH loc_oPg.txt_4c_Mctotal
5961:             .Top           = 375

*-- Linhas 6052 a 6143:
6052:             .SpecialEffect = 1
6053:             .Visible       = .T.
6054:         ENDWITH
6055:         BINDEVENT(loc_oPg.txt_4c_Cuni, "KeyPress",  THIS, "TxtCuniKeyPress")
6056:         BINDEVENT(loc_oPg.txt_4c_Cuni, "LostFocus", THIS, "TxtCuniLostFocus")
6057: 
6058:         *-- Get_Duni -> txt_4c_DUni (T:394 L:145 W:150 H:23) - desc unid1 (readonly)
6059:         loc_oPg.AddObject("txt_4c_DUni", "TextBox")
6060:         WITH loc_oPg.txt_4c_DUni
6061:             .Top           = 394
6062:             .Left          = 145
6063:             .Width         = 150
6064:             .Height        = 23
6065:             .FontName      = "Tahoma"
6066:             .FontSize      = 8
6067:             .ReadOnly      = .T.
6068:             .Value         = ""
6069:             .SpecialEffect = 1
6070:             .Visible       = .T.
6071:         ENDWITH
6072: 
6073:         *-- Say18: "(2) :" (T:398 L:301 W:23)
6074:         loc_oPg.AddObject("lbl_4c_LblUnid2", "Label")
6075:         WITH loc_oPg.lbl_4c_LblUnid2
6076:             .Caption   = "(2) :"
6077:             .Top       = 398
6078:             .Left      = 301
6079:             .Width     = 23
6080:             .Height    = 15
6081:             .FontName  = "Tahoma"
6082:             .FontSize  = 8
6083:             .BackStyle = 0
6084:             .ForeColor = RGB(90, 90, 90)
6085:             .Visible   = .T.
6086:         ENDWITH
6087: 
6088:         *-- Get_cunip -> txt_4c_Cunip (T:394 L:330 W:31 H:23) - cunips char(3)
6089:         loc_oPg.AddObject("txt_4c_Cunip", "TextBox")
6090:         WITH loc_oPg.txt_4c_Cunip
6091:             .Top           = 394
6092:             .Left          = 330
6093:             .Width         = 31
6094:             .Height        = 23
6095:             .FontName      = "Tahoma"
6096:             .FontSize      = 8
6097:             .MaxLength     = 3
6098:             .Value         = ""
6099:             .SpecialEffect = 1
6100:             .Visible       = .T.
6101:         ENDWITH
6102:         BINDEVENT(loc_oPg.txt_4c_Cunip, "KeyPress",  THIS, "TxtCunipKeyPress")
6103:         BINDEVENT(loc_oPg.txt_4c_Cunip, "LostFocus", THIS, "TxtCunipLostFocus")
6104: 
6105:         *-- get_dunip -> txt_4c_DUnip (T:394 L:362 W:150 H:23) - desc unid2 (readonly)
6106:         loc_oPg.AddObject("txt_4c_DUnip", "TextBox")
6107:         WITH loc_oPg.txt_4c_DUnip
6108:             .Top           = 394
6109:             .Left          = 362
6110:             .Width         = 150
6111:             .Height        = 23
6112:             .FontName      = "Tahoma"
6113:             .FontSize      = 8
6114:             .ReadOnly      = .T.
6115:             .Value         = ""
6116:             .SpecialEffect = 1
6117:             .Visible       = .T.
6118:         ENDWITH
6119: 
6120:         *----------------------------------------------------------------------
6121:         *-- Preco Venda + Auditoria linha 1 (T:397)
6122:         *-- Say4: "Valor de Venda :" (T:400 L:505 W:120)
6123:         *----------------------------------------------------------------------
6124:         loc_oPg.AddObject("lbl_4c_LblPvenda", "Label")
6125:         WITH loc_oPg.lbl_4c_LblPvenda
6126:             .Caption   = "Valor de Venda :"
6127:             .Top       = 400
6128:             .Left      = 505
6129:             .Width     = 120
6130:             .Height    = 15
6131:             .FontName  = "Tahoma"
6132:             .FontSize  = 8
6133:             .BackStyle = 0
6134:             .ForeColor = RGB(90, 90, 90)
6135:             .Visible   = .T.
6136:         ENDWITH
6137: 
6138:         *-- getPvenda -> txt_4c_Pvenda (T:397 L:626 W:127 H:21) - pvens (display)
6139:         loc_oPg.AddObject("txt_4c_Pvenda", "TextBox")
6140:         WITH loc_oPg.txt_4c_Pvenda
6141:             .Top           = 397
6142:             .Left          = 626
6143:             .Width         = 127

*-- Linhas 6671 a 6714:
6671:     *--------------------------------------------------------------------------
6672:     * PreencherDescricoesPgDadosP2 - Busca descricoes de unidades (readonly)
6673:     *--------------------------------------------------------------------------
6674:     PROCEDURE PreencherDescricoesPgDadosP2()
6675:         LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
6676:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6677: 
6678:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6679:             RETURN
6680:         ENDIF
6681:         IF VARTYPE(loc_oPg.txt_4c_Cuni) # "O"
6682:             RETURN
6683:         ENDIF
6684: 
6685:         TRY
6686:             *-- Descricao Unidade 1 (cunis -> SigCdUni.dunis)
6687:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6688:             IF !EMPTY(loc_cCod)
6689:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6690:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6691:                     "cursor_4c_TmpUni")
6692:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUni") > 0
6693:                     loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpUni.dunis)
6694:                 ENDIF
6695:                 IF USED("cursor_4c_TmpUni")
6696:                     USE IN cursor_4c_TmpUni
6697:                 ENDIF
6698:             ENDIF
6699: 
6700:             *-- Descricao Unidade 2 (cunips -> SigCdUni.dunis)
6701:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6702:             IF !EMPTY(loc_cCod)
6703:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6704:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6705:                     "cursor_4c_TmpUnip")
6706:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUnip") > 0
6707:                     loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpUnip.dunis)
6708:                 ENDIF
6709:                 IF USED("cursor_4c_TmpUnip")
6710:                     USE IN cursor_4c_TmpUnip
6711:                 ENDIF
6712:             ENDIF
6713: 
6714:             *-- Descricao Modelo (codfinp -> SigCdFip.descs)

*-- Linhas 6777 a 7290:
6777: 
6778:     *==========================================================================
6779:     * HANDLERS DE EVENTOS - Lookups da Aba Dados (Fase 6)
6780:     * BINDEVENT exige PUBLIC: sem prefixo PROTECTED
6781:     *==========================================================================
6782: 
6783:     *--------------------------------------------------------------------------
6784:     * TxtCuni - F4 abre lookup de unidades; LostFocus valida codigo
6785:     *--------------------------------------------------------------------------
6786:     PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6787:         IF par_nKeyCode = 115 && F4
6788:             THIS.AbrirLookupUnidade1()
6789:         ENDIF
6790:     ENDPROC
6791: 
6792:     PROCEDURE TxtCuniLostFocus()
6793:         LOCAL loc_oPg, loc_cCuni, loc_nRet
6794:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6795:         loc_cCuni = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6796: 
6797:         IF EMPTY(loc_cCuni)
6798:             loc_oPg.txt_4c_DUni.Value = ""
6799:             RETURN
6800:         ENDIF
6801:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6802:             RETURN
6803:         ENDIF
6804: 
6805:         TRY
6806:             loc_nRet = SQLEXEC(gnConnHandle, ;
6807:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCuni), ;
6808:                 "cursor_4c_TmpCuni")
6809:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCuni") > 0
6810:                 loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpCuni.dunis)
6811:             ELSE
6812:                 MsgAviso("Unidade '" + loc_cCuni + "' n" + CHR(227) + "o encontrada!")
6813:                 loc_oPg.txt_4c_Cuni.Value = ""
6814:                 loc_oPg.txt_4c_DUni.Value = ""
6815:             ENDIF
6816:             IF USED("cursor_4c_TmpCuni")
6817:                 USE IN cursor_4c_TmpCuni
6818:             ENDIF
6819:         CATCH TO loc_oErro
6820:             MsgErro(loc_oErro.Message, "Erro ao validar unidade")
6821:         ENDTRY
6822:     ENDPROC
6823: 
6824:     PROCEDURE AbrirLookupUnidade1()
6825:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6826:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6827:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6828: 
6829:         TRY
6830:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6831:                 "SigCdUni", "cursor_4c_BuscaUni", "cunis", loc_cAtual, ;
6832:                 "Buscar Unidade")
6833:             IF VARTYPE(loc_oBusca) = "O"
6834:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6835:                     IF USED("cursor_4c_BuscaUni")
6836:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6837:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6838:                     ENDIF
6839:                 ELSE
6840:                     IF !loc_oBusca.this_lAchouRegistro
6841:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6842:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6843:                     loc_oBusca.Show()
6844:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
6845:                         loc_oPg.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_BuscaUni.cunis)
6846:                         loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_BuscaUni.dunis)
6847:                     ENDIF
6848:                     ENDIF
6849:                 ENDIF
6850:                 loc_oBusca.Release()
6851:             ENDIF
6852:             IF USED("cursor_4c_BuscaUni")
6853:                 USE IN cursor_4c_BuscaUni
6854:             ENDIF
6855:         CATCH TO loc_oErro
6856:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
6857:         ENDTRY
6858:     ENDPROC
6859: 
6860:     *--------------------------------------------------------------------------
6861:     * TxtCunip - F4 abre lookup de unidades 2; LostFocus valida codigo
6862:     *--------------------------------------------------------------------------
6863:     PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6864:         IF par_nKeyCode = 115 && F4
6865:             THIS.AbrirLookupUnidade2()
6866:         ENDIF
6867:     ENDPROC
6868: 
6869:     PROCEDURE TxtCunipLostFocus()
6870:         LOCAL loc_oPg, loc_cCunip, loc_nRet
6871:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6872:         loc_cCunip = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6873: 
6874:         IF EMPTY(loc_cCunip)
6875:             loc_oPg.txt_4c_DUnip.Value = ""
6876:             RETURN
6877:         ENDIF
6878:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6879:             RETURN
6880:         ENDIF
6881: 
6882:         TRY
6883:             loc_nRet = SQLEXEC(gnConnHandle, ;
6884:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCunip), ;
6885:                 "cursor_4c_TmpCunip")
6886:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCunip") > 0
6887:                 loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpCunip.dunis)
6888:             ELSE
6889:                 MsgAviso("Unidade '" + loc_cCunip + "' n" + CHR(227) + "o encontrada!")
6890:                 loc_oPg.txt_4c_Cunip.Value = ""
6891:                 loc_oPg.txt_4c_DUnip.Value = ""
6892:             ENDIF
6893:             IF USED("cursor_4c_TmpCunip")
6894:                 USE IN cursor_4c_TmpCunip
6895:             ENDIF
6896:         CATCH TO loc_oErro
6897:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
6898:         ENDTRY
6899:     ENDPROC
6900: 
6901:     PROCEDURE AbrirLookupUnidade2()
6902:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6903:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6904:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6905: 
6906:         TRY
6907:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6908:                 "SigCdUni", "cursor_4c_BuscaUnip", "cunis", loc_cAtual, ;
6909:                 "Buscar Unidade 2")
6910:             IF VARTYPE(loc_oBusca) = "O"
6911:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6912:                     IF USED("cursor_4c_BuscaUnip")
6913:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6914:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6915:                     ENDIF
6916:                 ELSE
6917:                     IF !loc_oBusca.this_lAchouRegistro
6918:                     loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
6919:                     loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
6920:                     loc_oBusca.Show()
6921:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnip")
6922:                         loc_oPg.txt_4c_Cunip.Value = ALLTRIM(cursor_4c_BuscaUnip.cunis)
6923:                         loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_BuscaUnip.dunis)
6924:                     ENDIF
6925:                     ENDIF
6926:                 ENDIF
6927:                 loc_oBusca.Release()
6928:             ENDIF
6929:             IF USED("cursor_4c_BuscaUnip")
6930:                 USE IN cursor_4c_BuscaUnip
6931:             ENDIF
6932:         CATCH TO loc_oErro
6933:             MsgErro(loc_oErro.Message, "Erro ao buscar unidade 2")
6934:         ENDTRY
6935:     ENDPROC
6936: 
6937:     *--------------------------------------------------------------------------
6938:     * TxtCodFinP - F4 abre lookup de modelos (SigCdFip); LostFocus valida
6939:     *--------------------------------------------------------------------------
6940:     PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6941:         IF par_nKeyCode = 115 && F4
6942:             THIS.AbrirLookupModelo()
6943:         ENDIF
6944:     ENDPROC
6945: 
6946:     PROCEDURE TxtCodFinPLostFocus()
6947:         LOCAL loc_oPg, loc_cCod, loc_nRet
6948:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6949:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6950: 
6951:         IF EMPTY(loc_cCod)
6952:             loc_oPg.txt_4c_DFinP.Value = ""
6953:             RETURN
6954:         ENDIF
6955:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
6956:             RETURN
6957:         ENDIF
6958: 
6959:         TRY
6960:             loc_nRet = SQLEXEC(gnConnHandle, ;
6961:                 "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6962:                 "cursor_4c_TmpFinP")
6963:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6964:                 loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6965:             ELSE
6966:                 MsgAviso("Modelo '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
6967:                 loc_oPg.txt_4c_CodFinP.Value = ""
6968:                 loc_oPg.txt_4c_DFinP.Value   = ""
6969:             ENDIF
6970:             IF USED("cursor_4c_TmpFinP")
6971:                 USE IN cursor_4c_TmpFinP
6972:             ENDIF
6973:         CATCH TO loc_oErro
6974:             MsgErro(loc_oErro.Message, "Erro ao validar modelo")
6975:         ENDTRY
6976:     ENDPROC
6977: 
6978:     PROCEDURE AbrirLookupModelo()
6979:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
6980:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6981:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6982: 
6983:         TRY
6984:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6985:                 "SigCdFip", "cursor_4c_BuscaFinP", "cods", loc_cAtual, ;
6986:                 "Buscar Modelo")
6987:             IF VARTYPE(loc_oBusca) = "O"
6988:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
6989:                     IF USED("cursor_4c_BuscaFinP")
6990:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
6991:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
6992:                     ENDIF
6993:                 ELSE
6994:                     IF !loc_oBusca.this_lAchouRegistro
6995:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
6996:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
6997:                     loc_oBusca.Show()
6998:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
6999:                         loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_BuscaFinP.cods)
7000:                         loc_oPg.txt_4c_DFinP.Value   = ALLTRIM(cursor_4c_BuscaFinP.descs)
7001:                     ENDIF
7002:                     ENDIF
7003:                 ENDIF
7004:                 loc_oBusca.Release()
7005:             ENDIF
7006:             IF USED("cursor_4c_BuscaFinP")
7007:                 USE IN cursor_4c_BuscaFinP
7008:             ENDIF
7009:         CATCH TO loc_oErro
7010:             MsgErro(loc_oErro.Message, "Erro ao buscar modelo")
7011:         ENDTRY
7012:     ENDPROC
7013: 
7014:     *--------------------------------------------------------------------------
7015:     * TxtCodAcb - F4 abre lookup de acabamentos (SigCdAca); LostFocus valida
7016:     *--------------------------------------------------------------------------
7017:     PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7018:         IF par_nKeyCode = 115 && F4
7019:             THIS.AbrirLookupAcabamento()
7020:         ENDIF
7021:     ENDPROC
7022: 
7023:     PROCEDURE TxtCodAcbLostFocus()
7024:         LOCAL loc_oPg, loc_cCod, loc_nRet
7025:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7026:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
7027: 
7028:         IF EMPTY(loc_cCod)
7029:             loc_oPg.txt_4c_DAcb.Value = ""
7030:             RETURN
7031:         ENDIF
7032:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7033:             RETURN
7034:         ENDIF
7035: 
7036:         TRY
7037:             loc_nRet = SQLEXEC(gnConnHandle, ;
7038:                 "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
7039:                 "cursor_4c_TmpAcb")
7040:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
7041:                 loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
7042:             ELSE
7043:                 MsgAviso("Acabamento '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7044:                 loc_oPg.txt_4c_CodAcb.Value = ""
7045:                 loc_oPg.txt_4c_DAcb.Value   = ""
7046:             ENDIF
7047:             IF USED("cursor_4c_TmpAcb")
7048:                 USE IN cursor_4c_TmpAcb
7049:             ENDIF
7050:         CATCH TO loc_oErro
7051:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
7052:         ENDTRY
7053:     ENDPROC
7054: 
7055:     PROCEDURE AbrirLookupAcabamento()
7056:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
7057:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7058:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
7059: 
7060:         TRY
7061:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7062:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", loc_cAtual, ;
7063:                 "Buscar Acabamento")
7064:             IF VARTYPE(loc_oBusca) = "O"
7065:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7066:                     IF USED("cursor_4c_BuscaAcb")
7067:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7068:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7069:                     ENDIF
7070:                 ELSE
7071:                     IF !loc_oBusca.this_lAchouRegistro
7072:                     loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
7073:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7074:                     loc_oBusca.Show()
7075:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
7076:                         loc_oPg.txt_4c_CodAcb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
7077:                         loc_oPg.txt_4c_DAcb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
7078:                     ENDIF
7079:                     ENDIF
7080:                 ENDIF
7081:                 loc_oBusca.Release()
7082:             ENDIF
7083:             IF USED("cursor_4c_BuscaAcb")
7084:                 USE IN cursor_4c_BuscaAcb
7085:             ENDIF
7086:         CATCH TO loc_oErro
7087:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
7088:         ENDTRY
7089:     ENDPROC
7090: 
7091:     *--------------------------------------------------------------------------
7092:     * TxtClass - F4 abre lookup de classificacoes (SigCdCls); LostFocus valida
7093:     * SigCdCls: filtrado por cgrus do grupo de produto corrente
7094:     *--------------------------------------------------------------------------
7095:     PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7096:         IF par_nKeyCode = 115 && F4
7097:             THIS.AbrirLookupClassificacao()
7098:         ENDIF
7099:     ENDPROC
7100: 
7101:     PROCEDURE TxtClassLostFocus()
7102:         LOCAL loc_oPg, loc_cCod, loc_cCgru, loc_nRet
7103:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7104:         loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
7105:         loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
7106: 
7107:         IF EMPTY(loc_cCod)
7108:             loc_oPg.txt_4c_DClass.Value = ""
7109:             RETURN
7110:         ENDIF
7111:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7112:             RETURN
7113:         ENDIF
7114: 
7115:         TRY
7116:             loc_nRet = SQLEXEC(gnConnHandle, ;
7117:                 "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
7118:                 IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
7119:                 "cursor_4c_TmpClass")
7120:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
7121:                 loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
7122:             ELSE
7123:                 MsgAviso("Classifica" + CHR(231) + CHR(227) + "o '" + loc_cCod + "' n" + CHR(227) + "o encontrada!")
7124:                 loc_oPg.txt_4c_Class.Value  = ""
7125:                 loc_oPg.txt_4c_DClass.Value = ""
7126:             ENDIF
7127:             IF USED("cursor_4c_TmpClass")
7128:                 USE IN cursor_4c_TmpClass
7129:             ENDIF
7130:         CATCH TO loc_oErro
7131:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
7132:         ENDTRY
7133:     ENDPROC
7134: 
7135:     PROCEDURE AbrirLookupClassificacao()
7136:         LOCAL loc_oBusca, loc_oPg, loc_cAtual, loc_cCgru
7137:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7138:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Class.Value)
7139:         loc_cCgru  = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
7140: 
7141:         TRY
7142:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7143:                 "SigCdCls", "cursor_4c_BuscaClass", "cods", loc_cAtual, ;
7144:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o", .F., .T., ;
7145:                 IIF(EMPTY(loc_cCgru), "", "(cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"))
7146:             IF VARTYPE(loc_oBusca) = "O"
7147:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7148:                     IF USED("cursor_4c_BuscaClass")
7149:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7150:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7151:                     ENDIF
7152:                 ELSE
7153:                     IF !loc_oBusca.this_lAchouRegistro
7154:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7155:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7156:                     loc_oBusca.Show()
7157:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7158:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7159:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7160:                     ENDIF
7161:                     ENDIF
7162:                 ENDIF
7163:                 loc_oBusca.Release()
7164:             ENDIF
7165:             IF USED("cursor_4c_BuscaClass")
7166:                 USE IN cursor_4c_BuscaClass
7167:             ENDIF
7168:         CATCH TO loc_oErro
7169:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
7170:         ENDTRY
7171:     ENDPROC
7172: 
7173:     *--------------------------------------------------------------------------
7174:     * TxtLocal - F4 abre lookup de locais (SigPrLcl); LostFocus valida
7175:     *--------------------------------------------------------------------------
7176:     PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7177:         IF par_nKeyCode = 115 && F4
7178:             THIS.AbrirLookupLocal()
7179:         ENDIF
7180:     ENDPROC
7181: 
7182:     PROCEDURE TxtLocalLostFocus()
7183:         LOCAL loc_oPg, loc_cCod, loc_nRet
7184:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7185:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)
7186: 
7187:         IF EMPTY(loc_cCod)
7188:             RETURN
7189:         ENDIF
7190:         IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
7191:             RETURN
7192:         ENDIF
7193: 
7194:         TRY
7195:             loc_nRet = SQLEXEC(gnConnHandle, ;
7196:                 "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
7197:                 "cursor_4c_TmpLocal")
7198:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpLocal") = 0
7199:                 MsgAviso("Local '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7200:                 loc_oPg.txt_4c_Local.Value = ""
7201:             ENDIF
7202:             IF USED("cursor_4c_TmpLocal")
7203:                 USE IN cursor_4c_TmpLocal
7204:             ENDIF
7205:         CATCH TO loc_oErro
7206:             MsgErro(loc_oErro.Message, "Erro ao validar local")
7207:         ENDTRY
7208:     ENDPROC
7209: 
7210:     PROCEDURE AbrirLookupLocal()
7211:         LOCAL loc_oBusca, loc_oPg, loc_cAtual
7212:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7213:         loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Local.Value)
7214: 
7215:         TRY
7216:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7217:                 "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", loc_cAtual, ;
7218:                 "Buscar Local")
7219:             IF VARTYPE(loc_oBusca) = "O"
7220:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7221:                     IF USED("cursor_4c_BuscaLocal")
7222:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7223:                     ENDIF
7224:                 ELSE
7225:                     IF !loc_oBusca.this_lAchouRegistro
7226:                     loc_oBusca.mAddColuna("codigos",    "", "Local")
7227:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
7228:                     loc_oBusca.Show()
7229:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
7230:                         loc_oPg.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
7231:                     ENDIF
7232:                     ENDIF
7233:                 ENDIF
7234:                 loc_oBusca.Release()
7235:             ENDIF
7236:             IF USED("cursor_4c_BuscaLocal")
7237:                 USE IN cursor_4c_BuscaLocal
7238:             ENDIF
7239:         CATCH TO loc_oErro
7240:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
7241:         ENDTRY
7242:     ENDPROC
7243: 
7244:     *==========================================================================
7245:     * FASE 11 - Aba Consulta de Componentes (PgDadosConsP - Page5 do pgf_4c_Dados)
7246:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP
7247:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
7248:     * Controles: GrdCons(9 cols), Getqtcpnt, Say7, chkFund, Say1, grDTEMP(2 cols)
7249:     *==========================================================================
7250:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP()
7251:         LOCAL loc_oPg, loc_oGrd
7252: 
7253:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
7254: 
7255:         *----------------------------------------------------------------------
7256:         *-- Cursor placeholder para GrdCons (SigPrCpo + SigCdPrf + SigCdCat)
7257:         *-- Campos: mats(comp), qtds(qtde), unicompos(uni), Grupos(fase code),
7258:         *--         Descrs(fase desc), Ordems(ord), consumo, Cods(cat), dcats(cat desc)
7259:         *----------------------------------------------------------------------
7260:         IF !USED("cursor_4c_GrdCons")
7261:             SET NULL ON
7262:             CREATE CURSOR cursor_4c_GrdCons (;
7263:                 mats      C(14), ;
7264:                 qtds      N(12,4), ;
7265:                 unicompos C(5), ;
7266:                 Grupos    C(3), ;
7267:                 Descrs    C(65), ;
7268:                 Ordems    N(5,0), ;
7269:                 consumo   N(12,4), ;
7270:                 Cods      C(5), ;
7271:                 dcats     C(65), ;
7272:                 Dopes     C(5))
7273:             SET NULL OFF
7274:         ENDIF
7275: 
7276:         *----------------------------------------------------------------------
7277:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7278:         *----------------------------------------------------------------------
7279:         IF !USED("cursor_4c_GrDTEMP")
7280:             SET NULL ON
7281:             CREATE CURSOR cursor_4c_GrDTEMP (;
7282:                 agrup C(30), ;
7283:                 tempo N(12,4))
7284:             SET NULL OFF
7285:         ENDIF
7286: 
7287:         *----------------------------------------------------------------------
7288:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7289:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7290:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao

*-- Linhas 7387 a 7434:
7387:             .Column9.ReadOnly        = .F.
7388:         ENDWITH
7389: 
7390:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7391:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7392:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7393:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7394:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7395: 
7396:         *----------------------------------------------------------------------
7397:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7398:         *----------------------------------------------------------------------
7399:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7400:         WITH loc_oPg.lbl_4c_Label7
7401:             .Caption   = "Qtde Componentes : "
7402:             .Top       = 523
7403:             .Left      = 25
7404:             .Width     = 105
7405:             .Height    = 15
7406:             .FontName  = "Tahoma"
7407:             .FontSize  = 8
7408:             .BackStyle = 0
7409:             .ForeColor = RGB(90, 90, 90)
7410:             .Visible   = .T.
7411:         ENDWITH
7412: 
7413:         *----------------------------------------------------------------------
7414:         *-- TextBox Getqtcpnt (T:519 L:131 W:31 H:23)
7415:         *-- Legado When: Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
7416:         *-- Habilitado somente em modo edicao (via HabilitarCampos/DesabilitarCampos)
7417:         *----------------------------------------------------------------------
7418:         loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
7419:         WITH loc_oPg.txt_4c_Qtcpnt
7420:             .Top           = 519
7421:             .Left          = 131
7422:             .Width         = 31
7423:             .Height        = 23
7424:             .FontName      = "Tahoma"
7425:             .FontSize      = 8
7426:             .Value         = 0
7427:             .SpecialEffect = 1
7428:             .ForeColor     = RGB(36, 84, 155)
7429:             .Enabled       = .F.
7430:             .Visible       = .T.
7431:         ENDWITH
7432: 
7433:         *----------------------------------------------------------------------
7434:         *-- CheckBox chkFund (T:544 L:10 W:182 H:15)

*-- Linhas 7525 a 7787:
7525: 
7526:     *==========================================================================
7527:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7528:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7529:     *==========================================================================
7530: 
7531:     *--------------------------------------------------------------------------
7532:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7533:     *--------------------------------------------------------------------------
7534:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
7535:         TRY
7536:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7537:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7538:             ENDIF
7539:         CATCH TO loc_oErro
7540:             *-- silencioso: refresh de navegacao nao deve bloquear
7541:         ENDTRY
7542:     ENDPROC
7543: 
7544:     *--------------------------------------------------------------------------
7545:     * GrdConsCol4KeyPress - F4 abre lookup de Fase (SigCdPrf) para coluna Grupos
7546:     * Legado: Column4.Text1.Valid = fwBuscaInt on crSigCdPrf index GrpOrdem
7547:     *--------------------------------------------------------------------------
7548:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7549:         LOCAL loc_oBusca, loc_cAtual, loc_oPg
7550:         IF par_nKeyCode = 115  && F4
7551:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7552:                 RETURN
7553:             ENDIF
7554:             TRY
7555:                 loc_cAtual = ""
7556:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7557:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7558:                 ENDIF
7559:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7560:                     "SigCdPrf", "cursor_4c_BuscaPrf", "Grupos", loc_cAtual, ;
7561:                     "Buscar Fase")
7562:                 IF VARTYPE(loc_oBusca) = "O"
7563:                     IF !loc_oBusca.this_lAchouRegistro
7564:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7565:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7566:                         loc_oBusca.Show()
7567:                     ENDIF
7568:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7569:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7570:                             SELECT cursor_4c_GrdCons
7571:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7572:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7573:                         ENDIF
7574:                     ENDIF
7575:                     loc_oBusca.Release()
7576:                 ENDIF
7577:                 IF USED("cursor_4c_BuscaPrf")
7578:                     USE IN cursor_4c_BuscaPrf
7579:                 ENDIF
7580:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7581:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7582:                 ENDIF
7583:             CATCH TO loc_oErro
7584:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7585:             ENDTRY
7586:         ENDIF
7587:     ENDPROC
7588: 
7589:     *--------------------------------------------------------------------------
7590:     * GrdConsCol5KeyPress - F4 abre lookup de Descricao de Fase (SigCdPrf)
7591:     * Legado: Column5.Text1.Valid = fwBuscaInt on crSigCdPrf by Descrs
7592:     *         Apos selecao: Replace Grupos, Ordems, Dopes in crSigPrCpo
7593:     * Habilitado somente quando Column4 (Grupos) estiver vazio
7594:     *--------------------------------------------------------------------------
7595:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7596:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos
7597:         IF par_nKeyCode = 115  && F4
7598:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7599:                 RETURN
7600:             ENDIF
7601:             *-- Column5 so editavel quando Column4 (Grupos) esta vazio
7602:             loc_cGrupos = ""
7603:             IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7604:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GrdCons.Grupos, ""))
7605:             ENDIF
7606:             IF !EMPTY(loc_cGrupos)
7607:                 RETURN
7608:             ENDIF
7609:             TRY
7610:                 loc_cAtual = ""
7611:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7612:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Descrs, ""))
7613:                 ENDIF
7614:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7615:                     "SigCdPrf", "cursor_4c_BuscaPrf2", "Descrs", loc_cAtual, ;
7616:                     "Buscar Descri" + CHR(231) + CHR(227) + "o de Fase")
7617:                 IF VARTYPE(loc_oBusca) = "O"
7618:                     IF !loc_oBusca.this_lAchouRegistro
7619:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
7620:                         loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "d.")
7621:                         loc_oBusca.mAddColuna("Ordems", "", "Ord.")
7622:                         loc_oBusca.Show()
7623:                     ENDIF
7624:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7625:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7626:                             SELECT cursor_4c_GrdCons
7627:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7628:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7629:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7630:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7631:                             ENDIF
7632:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7633:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7634:                             ENDIF
7635:                         ENDIF
7636:                     ENDIF
7637:                     loc_oBusca.Release()
7638:                 ENDIF
7639:                 IF USED("cursor_4c_BuscaPrf2")
7640:                     USE IN cursor_4c_BuscaPrf2
7641:                 ENDIF
7642:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7643:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7644:                 ENDIF
7645:             CATCH TO loc_oErro
7646:                 MsgErro(loc_oErro.Message, "Erro ao buscar descri" + CHR(231) + CHR(227) + "o de fase")
7647:             ENDTRY
7648:         ENDIF
7649:     ENDPROC
7650: 
7651:     *--------------------------------------------------------------------------
7652:     * GrdConsCol8KeyPress - F4 abre lookup de Categoria (SigCdCat) para coluna Cods
7653:     * Legado: Column8.Text1.Valid = fwBuscaExt on SigCdCat by Cods
7654:     *         Apos selecao: Column8 = Cods; Column9 (dcats) = Descs
7655:     *--------------------------------------------------------------------------
7656:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
7657:         LOCAL loc_oBusca, loc_cAtual
7658:         IF par_nKeyCode = 115  && F4
7659:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
7660:                 RETURN
7661:             ENDIF
7662:             TRY
7663:                 loc_cAtual = ""
7664:                 IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7665:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GrdCons.Cods, ""))
7666:                 ENDIF
7667:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7668:                     "SigCdCat", "cursor_4c_BuscaCat", "Cods", loc_cAtual, ;
7669:                     "Buscar Categoria")
7670:                 IF VARTYPE(loc_oBusca) = "O"
7671:                     IF !loc_oBusca.this_lAchouRegistro
7672:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
7673:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7674:                         loc_oBusca.Show()
7675:                     ENDIF
7676:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7677:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7678:                             SELECT cursor_4c_GrdCons
7679:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7680:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7681:                         ENDIF
7682:                     ENDIF
7683:                     loc_oBusca.Release()
7684:                 ENDIF
7685:                 IF USED("cursor_4c_BuscaCat")
7686:                     USE IN cursor_4c_BuscaCat
7687:                 ENDIF
7688:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7689:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7690:                 ENDIF
7691:             CATCH TO loc_oErro
7692:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7693:             ENDTRY
7694:         ENDIF
7695:     ENDPROC
7696: 
7697:     *==========================================================================
7698:     * FASE 10 - Aba Custo (pgCusto - Page6 do pgf_4c_Dados)
7699:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
7700:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7701:     * Controles: cmbTipos, grdCompo(12 cols), cmdgCompo(2 btn),
7702:     *            Say16/Get_Desc, Say2/getDGruCompos, Say3, Shape2, GradeGRUPO2(3 cols)
7703:     *==========================================================================
7704:     PROTECTED PROCEDURE ConfigurarPgpgCusto()
7705:         LOCAL loc_oPg, loc_oGrd
7706: 
7707:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7708: 
7709:         *----------------------------------------------------------------------
7710:         *-- Cursors cursor_4c_Compo e cursor_4c_Grupo sao compartilhados
7711:         *-- com pgComposicao (criados em ConfigurarPgpgComposicao).
7712:         *-- Nao recriar - usar os ja existentes.
7713:         *----------------------------------------------------------------------
7714: 
7715:         *----------------------------------------------------------------------
7716:         *-- Tipo: lbl_4c_Label1 + cbo_4c_CmbTipos
7717:         *-- Say1: "Tipo :" T:159 L:112 W:29
7718:         *-- cmbTipos: T:154 L:143 W:187 H:23
7719:         *----------------------------------------------------------------------
7720:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
7721:         WITH loc_oPg.lbl_4c_Label1
7722:             .Caption   = "Tipo :"
7723:             .Top       = 159
7724:             .Left      = 112
7725:             .Width     = 29
7726:             .Height    = 15
7727:             .FontName  = "Tahoma"
7728:             .FontSize  = 8
7729:             .BackStyle = 0
7730:             .ForeColor = RGB(90, 90, 90)
7731:             .Visible   = .T.
7732:         ENDWITH
7733: 
7734:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
7735:         WITH loc_oPg.cbo_4c_CmbTipos
7736:             .Top           = 154
7737:             .Left          = 143
7738:             .Width         = 187
7739:             .Height        = 23
7740:             .FontName      = "Tahoma"
7741:             .FontSize      = 8
7742:             .RowSourceType = 0
7743:             .Value         = ""
7744:             .SpecialEffect = 1
7745:             .Visible       = .T.
7746:         ENDWITH
7747:         BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
7748: 
7749:         *----------------------------------------------------------------------
7750:         *-- Grid grdCompo (12 colunas) - Composicao de custo
7751:         *-- T:178 L:34 W:813 H:230 - usa cursor_4c_Compo (compartilhado)
7752:         *-- Colunas: Item, Descricao, Un, Valor, Qtd, Total, Moe,
7753:         *--          Observacao, Etiq, Consumo, Qtd, Un
7754:         *----------------------------------------------------------------------
7755:         loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
7756:         WITH loc_oPg.grd_4c_CustoCompo
7757:             .Top               = 178
7758:             .Left              = 34
7759:             .Width             = 813
7760:             .Height            = 230
7761:             .ColumnCount       = 12
7762:             .FontName          = "Verdana"
7763:             .FontSize          = 8
7764:             .GridLines         = 3
7765:             .GridLineWidth     = 1
7766:             .GridLineColor     = RGB(238, 238, 238)
7767:             .RecordMark        = .F.
7768:             .DeleteMark        = .F.
7769:             .AllowRowSizing    = .F.
7770:             .ReadOnly          = .F.
7771:             .BackColor         = RGB(255, 255, 255)
7772:             .ForeColor         = RGB(90, 90, 90)
7773:             .HighlightBackColor = RGB(220, 230, 242)
7774:             .HighlightForeColor = RGB(15, 41, 104)
7775:             .HighlightStyle    = 2
7776:             .RowHeight         = 16
7777:             .ScrollBars        = 2
7778:             .Visible           = .T.
7779:         ENDWITH
7780: 
7781:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7782:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7783: 
7784:         *-- Configurar colunas APOS RecordSource
7785:         WITH loc_oPg.grd_4c_CustoCompo
7786:             *-- Col1: Item/Material (C14) W:80
7787:             .Column1.Header1.Caption   = "Item"

*-- Linhas 7854 a 7951:
7854:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7855:             .Column12.ReadOnly         = .T.
7856:         ENDWITH
7857:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7858: 
7859:         *----------------------------------------------------------------------
7860:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7861:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7862:         *----------------------------------------------------------------------
7863:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7864:         WITH loc_oPg.cnt_4c_BotoesCusto
7865:             .Top         = 240
7866:             .Left        = 851
7867:             .Width       = 50
7868:             .Height      = 90
7869:             .BackStyle = 1
7870:             .BackColor = RGB(53, 53, 53)
7871:             .BorderWidth = 0
7872:             .Visible     = .T.
7873:         ENDWITH
7874: 
7875:         *-- Botao 1: Inserir componente de custo
7876:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_InserirCusto", "CommandButton")
7877:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto
7878:             .Caption       = "+"
7879:             .Top           = 0
7880:             .Left          = 0
7881:             .Width         = 50
7882:             .Height        = 45
7883:             .FontName      = "Tahoma"
7884:             .FontSize      = 10
7885:             .FontBold      = .T.
7886:             .Themes        = .F.
7887:             .SpecialEffect = 0
7888:             .BackColor     = RGB(255, 255, 255)
7889:             .ForeColor     = RGB(0, 128, 0)
7890:             .Visible       = .T.
7891:         ENDWITH
7892:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_InserirCusto, "Click", THIS, "CmdInserirCustoClick")
7893: 
7894:         *-- Botao 2: Excluir componente de custo
7895:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_ExcluirCusto", "CommandButton")
7896:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto
7897:             .Caption       = "-"
7898:             .Top           = 45
7899:             .Left          = 0
7900:             .Width         = 50
7901:             .Height        = 45
7902:             .FontName      = "Tahoma"
7903:             .FontSize      = 10
7904:             .FontBold      = .T.
7905:             .Themes        = .F.
7906:             .SpecialEffect = 0
7907:             .BackColor     = RGB(255, 255, 255)
7908:             .ForeColor     = RGB(192, 0, 0)
7909:             .Visible       = .T.
7910:         ENDWITH
7911:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_ExcluirCusto, "Click", THIS, "CmdExcluirCustoClick")
7912: 
7913:         *----------------------------------------------------------------------
7914:         *-- Linha Descricao / Grupo (abaixo do grid e botoes)
7915:         *-- Say16: "Descricao :" T:415 L:52 W:55
7916:         *-- Get_Desc: T:412 L:116 W:304 H:21 - readonly (When=.F.)
7917:         *-- Say2: "Grupo :" T:415 L:479 W:38
7918:         *-- getDGruCompos: T:412 L:522 W:304 H:21 - readonly (When=.F.)
7919:         *----------------------------------------------------------------------
7920:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
7921:         WITH loc_oPg.lbl_4c_Label16
7922:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
7923:             .Top       = 415
7924:             .Left      = 52
7925:             .Width     = 55
7926:             .Height    = 15
7927:             .FontName  = "Tahoma"
7928:             .FontSize  = 8
7929:             .BackStyle = 0
7930:             .ForeColor = RGB(90, 90, 90)
7931:             .Visible   = .T.
7932:         ENDWITH
7933: 
7934:         loc_oPg.AddObject("txt_4c_CustoDesc", "TextBox")
7935:         WITH loc_oPg.txt_4c_CustoDesc
7936:             .Top           = 412
7937:             .Left          = 116
7938:             .Width         = 304
7939:             .Height        = 21
7940:             .FontName      = "Tahoma"
7941:             .FontSize      = 8
7942:             .MaxLength     = 65
7943:             .Value         = ""
7944:             .SpecialEffect = 1
7945:             .Enabled       = .F.
7946:             .Visible       = .T.
7947:         ENDWITH
7948: 
7949:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
7950:         WITH loc_oPg.lbl_4c_Label2
7951:             .Caption   = "Grupo :"

*-- Linhas 8064 a 8239:
8064:     *--------------------------------------------------------------------------
8065:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8066:     *--------------------------------------------------------------------------
8067:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8068:         LOCAL loc_oPg, loc_nRet
8069:         TRY
8070:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8071:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8072:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8073:                 *-- Buscar descricao do grupo
8074:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8075:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8076:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8077:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8078:                         "cursor_4c_TmpGrpCusto")
8079:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8080:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)
8081:                     ELSE
8082:                         loc_oPg.txt_4c_DGruCompos.Value = ""
8083:                     ENDIF
8084:                     IF USED("cursor_4c_TmpGrpCusto")
8085:                         USE IN cursor_4c_TmpGrpCusto
8086:                     ENDIF
8087:                 ELSE
8088:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8089:                 ENDIF
8090:             ENDIF
8091:         CATCH TO loc_oErro
8092:             *-- silencioso: refresh de display nao deve bloquear navegacao
8093:         ENDTRY
8094:     ENDPROC
8095: 
8096:     *--------------------------------------------------------------------------
8097:     * CboTiposCustoInteractiveChange - Filtra composicao pelo tipo selecionado
8098:     *--------------------------------------------------------------------------
8099:     PROCEDURE CboTiposCustoInteractiveChange()
8100:         LOCAL loc_oPg
8101:         TRY
8102:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8103:             IF USED("cursor_4c_Compo")
8104:                 GO TOP IN cursor_4c_Compo
8105:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8106:             ENDIF
8107:         CATCH TO loc_oErro
8108:             MsgErro(loc_oErro.Message, "Erro ao filtrar por tipo")
8109:         ENDTRY
8110:     ENDPROC
8111: 
8112:     *--------------------------------------------------------------------------
8113:     * CmdInserirCustoClick - Insere nova linha de custo no grdCompo (pgCusto)
8114:     *--------------------------------------------------------------------------
8115:     PROCEDURE CmdInserirCustoClick()
8116:         LOCAL loc_oPg, loc_cTipo
8117:         TRY
8118:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8119:                 RETURN
8120:             ENDIF
8121:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8122:             loc_cTipo = ""
8123:             IF VARTYPE(loc_oPg.cbo_4c_CmbTipos) = "O"
8124:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8125:             ENDIF
8126:             IF USED("cursor_4c_Compo")
8127:                 SELECT cursor_4c_Compo
8128:                 GO TOP IN cursor_4c_Compo
8129:                 LOCATE FOR EMPTY(mats)
8130:                 IF EOF("cursor_4c_Compo")
8131:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8132:                 ENDIF
8133:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8134:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8135:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8136:                 ENDIF
8137:             ENDIF
8138:         CATCH TO loc_oErro
8139:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8140:         ENDTRY
8141:     ENDPROC
8142: 
8143:     *--------------------------------------------------------------------------
8144:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8145:     *--------------------------------------------------------------------------
8146:     PROCEDURE CmdExcluirCustoClick()
8147:         LOCAL loc_oPg
8148:         TRY
8149:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8150:                 RETURN
8151:             ENDIF
8152:             IF USED("cursor_4c_Compo")
8153:                 SELECT cursor_4c_Compo
8154:                 IF !EOF("cursor_4c_Compo")
8155:                     DELETE
8156:                     IF !EOF("cursor_4c_Compo")
8157:                         SKIP
8158:                         SKIP -1
8159:                     ENDIF
8160:                     GO BOTTOM IN cursor_4c_Compo
8161:                 ENDIF
8162:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8163:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8164:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8165:             ENDIF
8166:         CATCH TO loc_oErro
8167:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8168:         ENDTRY
8169:     ENDPROC
8170: 
8171:     *--------------------------------------------------------------------------
8172:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
8173:     * LISTA/VISUALIZAR: Salvar desabilitado; INCLUIR/ALTERAR: Salvar habilitado
8174:     *--------------------------------------------------------------------------
8175:     PROCEDURE AjustarBotoesPorModo()
8176:         LOCAL loc_oPg2, loc_lEditando
8177:         loc_lEditando = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
8178: 
8179:         IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
8180:             RETURN
8181:         ENDIF
8182: 
8183:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
8184: 
8185:         IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
8186:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar) = "O"
8187:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEditando
8188:             ENDIF
8189:         ENDIF
8190:     ENDPROC
8191: 
8192:     *==========================================================================
8193:     * FASE 12 - Aba Fases de Producao (PgDadosFaseP - Page4 do pgf_4c_Dados)
8194:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP
8195:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8196:     * Controles: 2 grids (GradFase 5col + grdMatrizes 3col), 8 textboxes,
8197:     *            2 checkboxes, 1 editbox, labels, shapes, images, 8 commandbuttons
8198:     *==========================================================================
8199:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP()
8200:         LOCAL loc_oPg, loc_oGrd
8201:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8202: 
8203:         *----------------------------------------------------------------------
8204:         *-- Cursor placeholder cursor_4c_GradFase (SigCdPrf + SigCdGcr JOIN)
8205:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8206:         *----------------------------------------------------------------------
8207:         IF !USED("cursor_4c_GradFase")
8208:             SET NULL ON
8209:             CREATE CURSOR cursor_4c_GradFase (;
8210:                 Ordems   N(5,0), ;
8211:                 Grupos   C(10), ;
8212:                 Descrs   C(65), ;
8213:                 UniPrdts C(10), ;
8214:                 MatPrdts C(15), ;
8215:                 Obs      M, ;
8216:                 FigProcs M)
8217:             SET NULL OFF
8218:         ENDIF
8219: 
8220:         *----------------------------------------------------------------------
8221:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8222:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8223:         *----------------------------------------------------------------------
8224:         IF !USED("cursor_4c_SigPrMtz")
8225:             SET NULL ON
8226:             CREATE CURSOR cursor_4c_SigPrMtz (;
8227:                 CMats C(14), ;
8228:                 DLocs C(40), ;
8229:                 Qtds  N(3,0))
8230:             SET NULL OFF
8231:         ENDIF
8232: 
8233:         *----------------------------------------------------------------------
8234:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8235:         *----------------------------------------------------------------------
8236:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8237:         WITH loc_oPg.shp_4c_ShpFig
8238:             .Top         = 152
8239:             .Left        = 231

*-- Linhas 8260 a 8303:
8260:             .Stretch = 2
8261:             .Visible = .F.
8262:         ENDWITH
8263:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
8264: 
8265:         *----------------------------------------------------------------------
8266:         *-- Grid GradFase (T:152 L:527 W:420 H:312) - 5 colunas fases de producao
8267:         *-- Legado: SIGCDPRO.PgDadosFaseP.GradFase (fwgrade)
8268:         *-- Cols: Ordem | Fase | Utilizacao | Uni. Produtiva | Material
8269:         *----------------------------------------------------------------------
8270:         loc_oPg.AddObject("grd_4c_GradFase", "Grid")
8271:         loc_oGrd = loc_oPg.grd_4c_GradFase
8272: 
8273:         WITH loc_oGrd
8274:             .Top                = 152
8275:             .Left               = 527
8276:             .Width              = 420
8277:             .Height             = 312
8278:             .FontName           = "Tahoma"
8279:             .FontSize           = 8
8280:             .ColumnCount        = 5
8281:             .GridLines          = 3
8282:             .GridLineWidth      = 1
8283:             .GridLineColor      = RGB(238, 238, 238)
8284:             .RecordMark         = .F.
8285:             .DeleteMark         = .F.
8286:             .AllowRowSizing     = .F.
8287:             .ReadOnly           = .F.
8288:             .BackColor          = RGB(255, 255, 255)
8289:             .ForeColor          = RGB(90, 90, 90)
8290:             .HighlightBackColor = RGB(220, 230, 242)
8291:             .HighlightForeColor = RGB(15, 41, 104)
8292:             .HighlightStyle     = 2
8293:             .RowHeight          = 16
8294:             .ScrollBars         = 2
8295:             .Themes             = .F.
8296:             .Visible            = .T.
8297:         ENDWITH
8298: 
8299:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8300:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8301: 
8302:         *-- Configurar colunas APOS RecordSource
8303:         WITH loc_oPg.grd_4c_GradFase

*-- Linhas 8337 a 8514:
8337:             .Column5.ReadOnly        = .F.
8338:         ENDWITH
8339: 
8340:         *-- BINDEVENT: GradFase
8341:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8342:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8343:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8344:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8345:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8346:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8347: 
8348:         *----------------------------------------------------------------------
8349:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8350:         *-- Legado: inserir.Click - insere nova linha com resequenciamento
8351:         *----------------------------------------------------------------------
8352:         loc_oPg.AddObject("cmd_4c_IncluirFase", "CommandButton")
8353:         WITH loc_oPg.cmd_4c_IncluirFase
8354:             .Caption       = "+"
8355:             .Top           = 152
8356:             .Left          = 950
8357:             .Width         = 38
8358:             .Height        = 38
8359:             .FontName      = "Tahoma"
8360:             .FontSize      = 10
8361:             .FontBold      = .T.
8362:             .Themes        = .F.
8363:             .SpecialEffect = 0
8364:             .BackColor     = RGB(255, 255, 255)
8365:             .ForeColor     = RGB(0, 128, 0)
8366:             .Visible       = .T.
8367:         ENDWITH
8368:         BINDEVENT(loc_oPg.cmd_4c_IncluirFase, "Click", THIS, "CmdIncluirFaseClick")
8369: 
8370:         *----------------------------------------------------------------------
8371:         *-- Botao Excluir Fase (excluir: T:192 L:950 W:38 H:38)
8372:         *-- Legado: excluir.Click - exclui linha corrente e resequencia
8373:         *----------------------------------------------------------------------
8374:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
8375:         WITH loc_oPg.cmd_4c_ExcluirFase
8376:             .Caption       = "-"
8377:             .Top           = 192
8378:             .Left          = 950
8379:             .Width         = 38
8380:             .Height        = 38
8381:             .FontName      = "Tahoma"
8382:             .FontSize      = 10
8383:             .FontBold      = .T.
8384:             .Themes        = .F.
8385:             .SpecialEffect = 0
8386:             .BackColor     = RGB(255, 255, 255)
8387:             .ForeColor     = RGB(192, 0, 0)
8388:             .Visible       = .T.
8389:         ENDWITH
8390:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "CmdExcluirFaseClick")
8391: 
8392:         *----------------------------------------------------------------------
8393:         *-- Botao Alternativa (Alternativa: T:232 L:950 W:38 H:38)
8394:         *-- Legado: Alternativa.Click - copia linha corrente como alternativa
8395:         *----------------------------------------------------------------------
8396:         loc_oPg.AddObject("cmd_4c_AlternativaFase", "CommandButton")
8397:         WITH loc_oPg.cmd_4c_AlternativaFase
8398:             .Caption       = "A"
8399:             .Top           = 232
8400:             .Left          = 950
8401:             .Width         = 38
8402:             .Height        = 38
8403:             .FontName      = "Tahoma"
8404:             .FontSize      = 9
8405:             .Themes        = .F.
8406:             .SpecialEffect = 0
8407:             .BackColor     = RGB(255, 255, 255)
8408:             .ForeColor     = RGB(90, 90, 90)
8409:             .Visible       = .T.
8410:         ENDWITH
8411:         BINDEVENT(loc_oPg.cmd_4c_AlternativaFase, "Click", THIS, "CmdAlternativaFaseClick")
8412: 
8413:         *----------------------------------------------------------------------
8414:         *-- Botao Ficha Tecnica (CmdFicha: T:152 L:482 W:38 H:38)
8415:         *-- Legado: CmdFicha.Click - gera ficha tecnica com REPORT FORM
8416:         *----------------------------------------------------------------------
8417:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
8418:         WITH loc_oPg.cmd_4c_CmdFicha
8419:             .Caption       = "F"
8420:             .Top           = 152
8421:             .Left          = 482
8422:             .Width         = 38
8423:             .Height        = 38
8424:             .FontName      = "Tahoma"
8425:             .FontSize      = 9
8426:             .Themes        = .F.
8427:             .SpecialEffect = 0
8428:             .BackColor     = RGB(255, 255, 255)
8429:             .ForeColor     = RGB(90, 90, 90)
8430:             .Visible       = .T.
8431:         ENDWITH
8432:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
8433: 
8434:         *----------------------------------------------------------------------
8435:         *-- Botao Selecionar Imagem (cmdgFigura: T:192 L:482 W:40 H:40)
8436:         *-- Legado: cmdgFigura.Click - abre seletor GetPict JPG/BMP
8437:         *----------------------------------------------------------------------
8438:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
8439:         WITH loc_oPg.cmd_4c_CmdgFigura
8440:             .Caption       = "I"
8441:             .Top           = 192
8442:             .Left          = 482
8443:             .Width         = 40
8444:             .Height        = 40
8445:             .FontName      = "Tahoma"
8446:             .FontSize      = 9
8447:             .Themes        = .F.
8448:             .SpecialEffect = 0
8449:             .BackColor     = RGB(255, 255, 255)
8450:             .ForeColor     = RGB(90, 90, 90)
8451:             .Visible       = .T.
8452:         ENDWITH
8453:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
8454: 
8455:         *----------------------------------------------------------------------
8456:         *-- Botao Capturar Webcam (cmdgFigCam: T:232 L:482 W:40 H:40)
8457:         *-- Legado: cmdgFigCam.Click - captura imagem via SigImage form
8458:         *----------------------------------------------------------------------
8459:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
8460:         WITH loc_oPg.cmd_4c_CmdgFigCam
8461:             .Caption       = "C"
8462:             .Top           = 232
8463:             .Left          = 482
8464:             .Width         = 40
8465:             .Height        = 40
8466:             .FontName      = "Tahoma"
8467:             .FontSize      = 9
8468:             .Themes        = .F.
8469:             .SpecialEffect = 0
8470:             .BackColor     = RGB(255, 255, 255)
8471:             .ForeColor     = RGB(90, 90, 90)
8472:             .Visible       = .T.
8473:         ENDWITH
8474:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
8475: 
8476:         *----------------------------------------------------------------------
8477:         *-- Label Say1: "Descricao :" (T:474 L:527 W:67 H:17)
8478:         *----------------------------------------------------------------------
8479:         loc_oPg.AddObject("lbl_4c_Label1FP", "Label")
8480:         WITH loc_oPg.lbl_4c_Label1FP
8481:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
8482:             .Top       = 474
8483:             .Left      = 527
8484:             .Width     = 67
8485:             .Height    = 17
8486:             .FontName  = "Tahoma"
8487:             .FontSize  = 8
8488:             .BackStyle = 0
8489:             .ForeColor = RGB(90, 90, 90)
8490:             .Visible   = .T.
8491:         ENDWITH
8492: 
8493:         *----------------------------------------------------------------------
8494:         *-- TextBox Get_Desc (T:471 L:595 W:395 H:23) - descricao da fase
8495:         *-- Readonly - preenchido pelo GradFaseAfterRowColChange (campo Descrs)
8496:         *----------------------------------------------------------------------
8497:         loc_oPg.AddObject("txt_4c_Desc", "TextBox")
8498:         WITH loc_oPg.txt_4c_Desc
8499:             .Top           = 471
8500:             .Left          = 595
8501:             .Width         = 395
8502:             .Height        = 23
8503:             .Value         = ""
8504:             .FontName      = "Tahoma"
8505:             .FontSize      = 8
8506:             .ReadOnly      = .T.
8507:             .SpecialEffect = 1
8508:             .ForeColor     = RGB(36, 84, 155)
8509:             .BackColor     = RGB(240, 240, 240)
8510:             .Visible       = .T.
8511:         ENDWITH
8512: 
8513:         *----------------------------------------------------------------------
8514:         *-- EditBox Get_Obs (T:497 L:527 W:463 H:122) - observacoes da fase

*-- Linhas 8632 a 8675:
8632:             .Enabled       = .F.
8633:             .Visible       = .T.
8634:         ENDWITH
8635:         BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "TxtConquilhaLostFocus")
8636: 
8637:         *-- Label Say9: "Peso Brilhante :" (T:231 L:58 W:77 H:15)
8638:         loc_oPg.AddObject("lbl_4c_Label9FP", "Label")
8639:         WITH loc_oPg.lbl_4c_Label9FP
8640:             .Caption   = "Peso Brilhante :"
8641:             .Top       = 451
8642:             .Left      = 884
8643:             .Width     = 77
8644:             .Height    = 15
8645:             .FontName  = "Tahoma"
8646:             .FontSize  = 8
8647:             .BackStyle = 0
8648:             .ForeColor = RGB(90, 90, 90)
8649:             .Visible   = .T.
8650:         ENDWITH
8651: 
8652:         *-- TextBox getPesoBris (T:227 L:137 W:80 H:23)
8653:         *-- Legado: pesobris de SigCdPro
8654:         loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
8655:         WITH loc_oPg.txt_4c_PesoBris
8656:             .Top           = 227
8657:             .Left          = 137
8658:             .Width         = 80
8659:             .Height        = 23
8660:             .Value         = 0
8661:             .FontName      = "Tahoma"
8662:             .FontSize      = 8
8663:             .SpecialEffect = 1
8664:             .ForeColor     = RGB(36, 84, 155)
8665:             .Enabled       = .F.
8666:             .Visible       = .T.
8667:         ENDWITH
8668: 
8669:         *-- Label Say10: "Peso Metal :" (T:256 L:74 W:61 H:15)
8670:         loc_oPg.AddObject("lbl_4c_Label10FP", "Label")
8671:         WITH loc_oPg.lbl_4c_Label10FP
8672:             .Caption   = "Peso Metal :"
8673:             .Top       = 451
8674:             .Left      = 967
8675:             .Width     = 61

*-- Linhas 8761 a 8804:
8761:             .Enabled       = .F.
8762:             .Visible       = .T.
8763:         ENDWITH
8764:         BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "TxtCorLostFocus")
8765: 
8766:         *-- CheckBox opc_CravCera: "Cravacao em Cera" (T:306 L:180 W:120 H:15)
8767:         *-- Legado: cravcers de SigCdPro (numeric 1,0 com semantica booleana)
8768:         loc_oPg.AddObject("chk_4c_Opc_CravCera", "CheckBox")
8769:         WITH loc_oPg.chk_4c_Opc_CravCera
8770:             .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
8771:             .Top       = 306
8772:             .Left      = 180
8773:             .Width     = 120
8774:             .Height    = 15
8775:             .Value     = 0
8776:             .FontName  = "Tahoma"
8777:             .FontSize  = 8
8778:             .BackStyle = 0
8779:             .Themes    = .F.
8780:             .Enabled   = .F.
8781:             .Visible   = .T.
8782:         ENDWITH
8783: 
8784:         *-- Label Say2: "Tamanho Padrao :" (T:331 L:45 W:90 H:15)
8785:         loc_oPg.AddObject("lbl_4c_Label2FP", "Label")
8786:         WITH loc_oPg.lbl_4c_Label2FP
8787:             .Caption   = "Tamanho Padr" + CHR(227) + "o :"
8788:             .Top       = 331
8789:             .Left      = 45
8790:             .Width     = 90
8791:             .Height    = 15
8792:             .FontName  = "Tahoma"
8793:             .FontSize  = 8
8794:             .BackStyle = 0
8795:             .ForeColor = RGB(90, 90, 90)
8796:             .Visible   = .T.
8797:         ENDWITH
8798: 
8799:         *-- TextBox getTam: tamanho padrao (T:327 L:137 W:38 H:23)
8800:         *-- Legado: codtams de SigCdPro - LostFocus lookup SigCdTam
8801:         loc_oPg.AddObject("txt_4c_Tam", "TextBox")
8802:         WITH loc_oPg.txt_4c_Tam
8803:             .Top           = 327
8804:             .Left          = 137

*-- Linhas 8812 a 8888:
8812:             .Enabled       = .F.
8813:             .Visible       = .T.
8814:         ENDWITH
8815:         BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "TxtTamLostFocus")
8816: 
8817:         *-- Label lblAcabamento: "Acabamento :" (T:356 L:16 W:119 H:15)
8818:         loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
8819:         WITH loc_oPg.lbl_4c_LblAcabamento
8820:             .Caption   = "Acabamento :"
8821:             .Top       = 356
8822:             .Left      = 16
8823:             .Width     = 119
8824:             .Height    = 15
8825:             .FontName  = "Tahoma"
8826:             .FontSize  = 8
8827:             .BackStyle = 0
8828:             .ForeColor = RGB(90, 90, 90)
8829:             .Visible   = .T.
8830:         ENDWITH
8831: 
8832:         *-- TextBox get_codacb: codigo acabamento (T:352 L:137 W:38 H:23)
8833:         *-- Legado: codacbs de SigCdPro - LostFocus lookup SigCdAca
8834:         loc_oPg.AddObject("txt_4c__codacb", "TextBox")
8835:         WITH loc_oPg.txt_4c__codacb
8836:             .Top           = 352
8837:             .Left          = 137
8838:             .Width         = 38
8839:             .Height        = 23
8840:             .Value         = ""
8841:             .FontName      = "Tahoma"
8842:             .FontSize      = 8
8843:             .SpecialEffect = 1
8844:             .ForeColor     = RGB(36, 84, 155)
8845:             .Enabled       = .F.
8846:             .Visible       = .T.
8847:         ENDWITH
8848:         BINDEVENT(loc_oPg.txt_4c__codacb, "LostFocus", THIS, "TxtCodacbLostFocus")
8849: 
8850:         *-- TextBox get_Dacb: descricao acabamento (T:352 L:177 W:207 H:23)
8851:         *-- Legado: When=.F. (readonly sempre) - preenchido pelo lookup de get_codacb
8852:         loc_oPg.AddObject("txt_4c__Dacb", "TextBox")
8853:         WITH loc_oPg.txt_4c__Dacb
8854:             .Top           = 352
8855:             .Left          = 177
8856:             .Width         = 207
8857:             .Height        = 23
8858:             .Value         = ""
8859:             .FontName      = "Tahoma"
8860:             .FontSize      = 8
8861:             .ReadOnly      = .T.
8862:             .SpecialEffect = 1
8863:             .ForeColor     = RGB(36, 84, 155)
8864:             .BackColor     = RGB(240, 240, 240)
8865:             .Enabled       = .F.
8866:             .Visible       = .T.
8867:         ENDWITH
8868: 
8869:         *----------------------------------------------------------------------
8870:         *-- Secao inferior esquerda: grdMatrizes + botoes + imagem borracha
8871:         *----------------------------------------------------------------------
8872: 
8873:         *-- Grid grdMatrizes (T:380 L:7 W:246 H:240) - 3 colunas: Matriz|Local|Qtde
8874:         *-- Legado: grdMatrizes com crSigPrMtz (matrizes do produto)
8875:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
8876:         loc_oGrd = loc_oPg.grd_4c_Matrizes
8877: 
8878:         WITH loc_oGrd
8879:             .Top                = 380
8880:             .Left               = 7
8881:             .Width              = 246
8882:             .Height             = 240
8883:             .FontName           = "Tahoma"
8884:             .FontSize           = 8
8885:             .ColumnCount        = 3
8886:             .GridLines          = 3
8887:             .GridLineWidth      = 1
8888:             .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 8928 a 9055:
8928:             .Column3.ReadOnly        = .F.
8929:         ENDWITH
8930: 
8931:         *-- BINDEVENT: grdMatrizes
8932:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8933:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8934: 
8935:         *----------------------------------------------------------------------
8936:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8937:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8938:         *----------------------------------------------------------------------
8939:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8940:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8941:             .Caption       = "+"
8942:             .Top           = 380
8943:             .Left          = 258
8944:             .Width         = 38
8945:             .Height        = 38
8946:             .FontName      = "Tahoma"
8947:             .FontSize      = 10
8948:             .FontBold      = .T.
8949:             .Themes        = .F.
8950:             .SpecialEffect = 0
8951:             .BackColor     = RGB(255, 255, 255)
8952:             .ForeColor     = RGB(0, 128, 0)
8953:             .Visible       = .T.
8954:         ENDWITH
8955:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")
8956: 
8957:         *----------------------------------------------------------------------
8958:         *-- Botao Excluir Matriz (btnExcluiMtz: T:420 L:258 W:38 H:38)
8959:         *-- Legado: btnExcluiMtz.Click - exclui linha de crSigPrMtz
8960:         *----------------------------------------------------------------------
8961:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
8962:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
8963:             .Caption       = "-"
8964:             .Top           = 420
8965:             .Left          = 258
8966:             .Width         = 38
8967:             .Height        = 38
8968:             .FontName      = "Tahoma"
8969:             .FontSize      = 10
8970:             .FontBold      = .T.
8971:             .Themes        = .F.
8972:             .SpecialEffect = 0
8973:             .BackColor     = RGB(255, 255, 255)
8974:             .ForeColor     = RGB(192, 0, 0)
8975:             .Visible       = .T.
8976:         ENDWITH
8977:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")
8978: 
8979:         *----------------------------------------------------------------------
8980:         *-- Shape: shpBorracha (T:464 L:258 W:236 H:156) - borda imagem borracha
8981:         *----------------------------------------------------------------------
8982:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
8983:         WITH loc_oPg.shp_4c_ShpBorracha
8984:             .Top         = 464
8985:             .Left        = 258
8986:             .Width       = 236
8987:             .Height      = 156
8988:             .BackStyle   = 1
8989:             .BackColor   = RGB(255, 255, 255)
8990:             .BorderColor = RGB(192, 192, 192)
8991:             .BorderWidth = 1
8992:             .Visible     = .T.
8993:         ENDWITH
8994: 
8995:         *----------------------------------------------------------------------
8996:         *-- Image: ImgBorracha (T:465 L:260 W:232 H:154) - imagem borracha da matriz
8997:         *-- Legado: GrdMatrizes.AfterRowColChange carrega SigCdPro da matriz corrente
8998:         *----------------------------------------------------------------------
8999:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
9000:         WITH loc_oPg.img_4c_ImgBorracha
9001:             .Top     = 465
9002:             .Left    = 260
9003:             .Width   = 232
9004:             .Height  = 154
9005:             .Picture = ""
9006:             .Stretch = 2
9007:             .Visible = .F.
9008:         ENDWITH
9009:     ENDPROC
9010: 
9011:     *--------------------------------------------------------------------------
9012:     * PreencherCamposFaseP - Popula controles da aba FaseP a partir do BO
9013:     * Chamado por BOParaForm apos carregar dados de SigCdPro
9014:     *--------------------------------------------------------------------------
9015:     PROTECTED PROCEDURE PreencherCamposFaseP()
9016:         LOCAL loc_oPg, loc_oPg1
9017:         TRY
9018:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9019:                 RETURN
9020:             ENDIF
9021:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9022:             IF VARTYPE(loc_oPg) # "O"
9023:                 RETURN
9024:             ENDIF
9025:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9026:             WITH THIS.this_oBusinessObject
9027:                 IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
9028:                     loc_oPg.txt_4c_Qmin.Value = IIF(.this_nQmins = 0, 0, .this_nQmins)
9029:                 ENDIF
9030:                 IF VARTYPE(loc_oPg.txt_4c_CodGarras) = "O"
9031:                     loc_oPg.txt_4c_CodGarras.Value = ALLTRIM(.this_cCodgarras)
9032:                 ENDIF
9033:                 IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
9034:                     loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(.this_cConquilhas)
9035:                 ENDIF
9036:                 IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
9037:                     loc_oPg.txt_4c_PesoBris.Value = .this_nPesobris
9038:                 ENDIF
9039:                 IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
9040:                     loc_oPg.txt_4c_PesoMetal.Value = .this_nPesometal
9041:                 ENDIF
9042:                 IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
9043:                     loc_oPg.txt_4c_PesoPdrs.Value = .this_nPesopdrs
9044:                 ENDIF
9045:                 IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
9046:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(.this_cCodcors)
9047:                 ENDIF
9048:                 IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
9049:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(.this_cCodtams)
9050:                 ENDIF
9051:                 IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
9052:                     loc_oPg.txt_4c__codacb.Value = ALLTRIM(.this_cCodacbs)
9053:                 ENDIF
9054:                 IF VARTYPE(loc_oPg.txt_4c__Dacb) = "O"
9055:                     loc_oPg.txt_4c__Dacb.Value = ""

*-- Linhas 9070 a 9113:
9070:     * LerCamposFaseP - Le controles da aba FaseP e transfere para o BO
9071:     * Chamado por FormParaBO antes de salvar
9072:     *--------------------------------------------------------------------------
9073:     PROTECTED PROCEDURE LerCamposFaseP()
9074:         LOCAL loc_oPg, loc_oPg1
9075:         TRY
9076:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9077:                 RETURN
9078:             ENDIF
9079:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9080:             IF VARTYPE(loc_oPg) # "O"
9081:                 RETURN
9082:             ENDIF
9083:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9084:             WITH THIS.this_oBusinessObject
9085:                 IF VARTYPE(loc_oPg.txt_4c_Qmin) = "O"
9086:                     .this_nQmins = loc_oPg.txt_4c_Qmin.Value
9087:                 ENDIF
9088:                 IF VARTYPE(loc_oPg.txt_4c_Conquilha) = "O"
9089:                     .this_cConquilhas = ALLTRIM(loc_oPg.txt_4c_Conquilha.Value)
9090:                 ENDIF
9091:                 IF VARTYPE(loc_oPg.txt_4c_PesoBris) = "O"
9092:                     .this_nPesobris = loc_oPg.txt_4c_PesoBris.Value
9093:                 ENDIF
9094:                 IF VARTYPE(loc_oPg.txt_4c_PesoMetal) = "O"
9095:                     .this_nPesometal = loc_oPg.txt_4c_PesoMetal.Value
9096:                 ENDIF
9097:                 IF VARTYPE(loc_oPg.txt_4c_PesoPdrs) = "O"
9098:                     .this_nPesopdrs = loc_oPg.txt_4c_PesoPdrs.Value
9099:                 ENDIF
9100:                 IF VARTYPE(loc_oPg.txt_4c_Cor) = "O"
9101:                     .this_cCodcors = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
9102:                 ENDIF
9103:                 IF VARTYPE(loc_oPg.txt_4c_Tam) = "O"
9104:                     .this_cCodtams = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
9105:                 ENDIF
9106:                 IF VARTYPE(loc_oPg.txt_4c__codacb) = "O"
9107:                     .this_cCodacbs = ALLTRIM(loc_oPg.txt_4c__codacb.Value)
9108:                 ENDIF
9109:                 IF VARTYPE(loc_oPg.chk_4c_Opc_CravCera) = "O"
9110:                     .this_lCravcers = (loc_oPg.chk_4c_Opc_CravCera.Value = 1)
9111:                 ENDIF
9112:                 IF VARTYPE(loc_oPg1) = "O" AND VARTYPE(loc_oPg1.chk_4c_Fwoption1) = "O"
9113:                     .this_nProdvars = IIF(loc_oPg1.chk_4c_Fwoption1.Value = 1, 1, 0)

*-- Linhas 9120 a 9165:
9120: 
9121:     *--------------------------------------------------------------------------
9122:     * GradFaseAfterRowColChange - Atualiza imagem e descricao ao navegar GradFase
9123:     * Legado: GradFase.AfterRowColChange (Procedure) - carrega FigProcs, Get_Desc, Get_Obs
9124:     *--------------------------------------------------------------------------
9125:     PROCEDURE GradFaseAfterRowColChange(par_nColIndex)
9126:         LOCAL loc_oPg, loc_lcArquivo
9127:         TRY
9128:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9129:                 RETURN
9130:             ENDIF
9131:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9132:             IF VARTYPE(loc_oPg) # "O"
9133:                 RETURN
9134:             ENDIF
9135: 
9136:             *-- Atualizar descricao da fase (campo Descrs do cursor)
9137:             IF VARTYPE(loc_oPg.txt_4c_Desc) = "O"
9138:                 loc_oPg.txt_4c_Desc.Value = ""
9139:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9140:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
9141:                 ENDIF
9142:             ENDIF
9143: 
9144:             *-- Atualizar observacoes da fase (campo Obs de crSigCdPrf se disponivel)
9145:             IF VARTYPE(loc_oPg.obj_4c_Get_Obs) = "O"
9146:                 loc_oPg.obj_4c_Get_Obs.Value = ""
9147:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9148:                     IF TYPE("cursor_4c_GradFase.Obs") # "U"
9149:                         loc_oPg.obj_4c_Get_Obs.Value = NVL(cursor_4c_GradFase.Obs, "")
9150:                     ENDIF
9151:                 ENDIF
9152:             ENDIF
9153: 
9154:             *-- Atualizar imagem da fase (campo FigProcs de crSigCdPrf se disponivel)
9155:             IF VARTYPE(loc_oPg.img_4c_ImgFigJpg) = "O"
9156:                 CLEAR RESOURCES
9157:                 loc_oPg.img_4c_ImgFigJpg.Picture = ""
9158:                 loc_oPg.img_4c_ImgFigJpg.Visible = .F.
9159:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9160:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9161:                         IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
9162:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9163:                             IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
9164:                                 loc_oPg.img_4c_ImgFigJpg.Picture  = loc_lcArquivo
9165:                                 loc_oPg.img_4c_ImgFigJpg.Visible  = .T.

*-- Linhas 9179 a 9427:
9179:     * GradFaseCol1GotFocus - Salva valor atual de Ordem antes de editar
9180:     * Legado: GradFase.Column1.Text1.GotFocus = "ThisForm.AntOrd = This.Value"
9181:     *--------------------------------------------------------------------------
9182:     PROCEDURE GradFaseCol1GotFocus()
9183:         TRY
9184:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9185:                 THIS.this_nAntOrdFase = cursor_4c_GradFase.Ordems
9186:             ENDIF
9187:         CATCH TO loc_oErro
9188:             MsgErro(loc_oErro.Message, "Erro ao registrar ordem anterior")
9189:         ENDTRY
9190:     ENDPROC
9191: 
9192:     *--------------------------------------------------------------------------
9193:     * GradFaseCol1LostFocus - Resequencia fases se ordem foi alterada
9194:     * Legado: GradFase.Column1.Text1.LostFocus - reordena SCAN por Ordem2
9195:     *--------------------------------------------------------------------------
9196:     PROCEDURE GradFaseCol1LostFocus()
9197:         LOCAL loc_lResultado, loc_nPonteiro, loc_nNovaOrdem, loc_nOrdem2
9198:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9199:             RETURN
9200:         ENDIF
9201:         loc_lResultado = .T.
9202:         TRY
9203:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9204:                 loc_lResultado = .F.
9205:             ENDIF
9206:             IF loc_lResultado
9207:                 loc_nNovaOrdem = cursor_4c_GradFase.Ordems
9208:                 IF loc_nNovaOrdem <= 0 OR loc_nNovaOrdem = THIS.this_nAntOrdFase
9209:                     loc_lResultado = .F.
9210:                 ENDIF
9211:             ENDIF
9212:             IF loc_lResultado
9213:                 *-- Calcular Ordem2 para resequenciamento
9214:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")
9215:                 SELECT cursor_4c_GradFase
9216:                 SCAN
9217:                     IF RECNO() # loc_nPonteiro
9218:                         REPLACE Ordems WITH cursor_4c_GradFase.Ordems IN cursor_4c_GradFase
9219:                     ENDIF
9220:                 ENDSCAN
9221:                 GO loc_nPonteiro IN cursor_4c_GradFase
9222:                 SELECT cursor_4c_GradFase
9223:                 *-- Reordenar por Ordems para refletir nova sequencia
9224:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9225:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9226:                 ENDIF
9227:             ENDIF
9228:         CATCH TO loc_oErro
9229:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9230:         ENDTRY
9231:     ENDPROC
9232: 
9233:     *--------------------------------------------------------------------------
9234:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9235:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9236:     *         Apos selecao: preenche Grupos e Descrs no cursor
9237:     *--------------------------------------------------------------------------
9238:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9239:         LOCAL loc_oBusca, loc_cAtual
9240:         IF par_nKeyCode = 115  && F4
9241:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9242:                 RETURN
9243:             ENDIF
9244:             TRY
9245:                 loc_cAtual = ""
9246:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9247:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9248:                 ENDIF
9249:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9250:                     "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cAtual, ;
9251:                     "Buscar Fase de Produ" + CHR(231) + CHR(227) + "o")
9252:                 IF VARTYPE(loc_oBusca) = "O"
9253:                     IF !loc_oBusca.this_lAchouRegistro
9254:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
9255:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
9256:                         loc_oBusca.Show()
9257:                     ENDIF
9258:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9259:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9260:                             SELECT cursor_4c_GradFase
9261:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9262:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9263:                         ENDIF
9264:                     ENDIF
9265:                     loc_oBusca.Release()
9266:                 ENDIF
9267:                 IF USED("cursor_4c_BuscaGcr")
9268:                     USE IN cursor_4c_BuscaGcr
9269:                 ENDIF
9270:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9271:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9272:                 ENDIF
9273:             CATCH TO loc_oErro
9274:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9275:             ENDTRY
9276:         ENDIF
9277:     ENDPROC
9278: 
9279:     *--------------------------------------------------------------------------
9280:     * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
9281:     * Legado: Column4.Text1.Valid = fwBuscaInt on SigCdUpd filtered by Grupos
9282:     *         Apos selecao: preenche UniPrdts no cursor
9283:     *--------------------------------------------------------------------------
9284:     PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9285:         LOCAL loc_oBusca, loc_cAtual, loc_cGrupos, loc_cSQL, loc_nRet
9286:         IF par_nKeyCode = 115  && F4
9287:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9288:                 RETURN
9289:             ENDIF
9290:             TRY
9291:                 loc_cAtual  = ""
9292:                 loc_cGrupos = ""
9293:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9294:                     loc_cAtual  = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9295:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9296:                 ENDIF
9297:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9298:                 IF !EMPTY(loc_cGrupos)
9299:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9300:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9301:                 ELSE
9302:                     loc_cSQL = "SELECT DISTINCT UniPrdts FROM SigCdUpd"
9303:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9304:                 ENDIF
9305:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaUpd")
9306:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9307:                         "SigCdUpd", "cursor_4c_BuscaUpd2", "UniPrdts", loc_cAtual, ;
9308:                         "Buscar Uni. Produtiva")
9309:                     IF VARTYPE(loc_oBusca) = "O"
9310:                         IF !loc_oBusca.this_lAchouRegistro
9311:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9312:                             loc_oBusca.Show()
9313:                         ENDIF
9314:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9315:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9316:                                 SELECT cursor_4c_GradFase
9317:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9318:                             ENDIF
9319:                         ENDIF
9320:                         loc_oBusca.Release()
9321:                     ENDIF
9322:                     IF USED("cursor_4c_BuscaUpd2")
9323:                         USE IN cursor_4c_BuscaUpd2
9324:                     ENDIF
9325:                 ENDIF
9326:                 IF USED("cursor_4c_BuscaUpd")
9327:                     USE IN cursor_4c_BuscaUpd
9328:                 ENDIF
9329:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9330:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9331:                 ENDIF
9332:             CATCH TO loc_oErro
9333:                 MsgErro(loc_oErro.Message, "Erro ao buscar Uni. Produtiva")
9334:             ENDTRY
9335:         ENDIF
9336:     ENDPROC
9337: 
9338:     *--------------------------------------------------------------------------
9339:     * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt) para coluna MatPrdts
9340:     * Legado: Column5.Text1.Valid = fwBuscaExt on SigOpOpt by Cods
9341:     *         Apos selecao: preenche MatPrdts no cursor
9342:     *--------------------------------------------------------------------------
9343:     PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9344:         LOCAL loc_oBusca, loc_cAtual
9345:         IF par_nKeyCode = 115  && F4
9346:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9347:                 RETURN
9348:             ENDIF
9349:             TRY
9350:                 loc_cAtual = ""
9351:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9352:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9353:                 ENDIF
9354:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9355:                     "SigOpOpt", "cursor_4c_BuscaOpt", "Cods", loc_cAtual, ;
9356:                     "Buscar Tipo de Material")
9357:                 IF VARTYPE(loc_oBusca) = "O"
9358:                     IF !loc_oBusca.this_lAchouRegistro
9359:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9360:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9361:                         loc_oBusca.Show()
9362:                     ENDIF
9363:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9364:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9365:                             SELECT cursor_4c_GradFase
9366:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9367:                         ENDIF
9368:                     ENDIF
9369:                     loc_oBusca.Release()
9370:                 ENDIF
9371:                 IF USED("cursor_4c_BuscaOpt")
9372:                     USE IN cursor_4c_BuscaOpt
9373:                 ENDIF
9374:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9375:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9376:                 ENDIF
9377:             CATCH TO loc_oErro
9378:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9379:             ENDTRY
9380:         ENDIF
9381:     ENDPROC
9382: 
9383:     *--------------------------------------------------------------------------
9384:     * GrdMatrizesAfterRowColChange - Carrega imagem da borracha da matriz selecionada
9385:     * Legado: grdMatrizes.Procedure(AfterRowColChange) - query SigCdPro e mostra FigJpgs
9386:     *--------------------------------------------------------------------------
9387:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9388:         LOCAL loc_oPg, loc_lcArquivo, loc_cSQL, loc_nRet
9389:         TRY
9390:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9391:                 RETURN
9392:             ENDIF
9393:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9394:             IF VARTYPE(loc_oPg) # "O"
9395:                 RETURN
9396:             ENDIF
9397: 
9398:             *-- Limpar imagem anterior
9399:             CLEAR RESOURCES
9400:             loc_oPg.img_4c_ImgBorracha.Picture = ""
9401:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9402: 
9403:             *-- Carregar imagem da borracha do produto-matriz corrente
9404:             IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9405:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9406:                     loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
9407:                                EscaparSQL(ALLTRIM(cursor_4c_SigPrMtz.CMats))
9408:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImgPro")
9409:                     IF loc_nRet > 0 AND USED("cursor_4c_LocalImgPro")
9410:                         GO TOP IN cursor_4c_LocalImgPro
9411:                         IF !EOF("cursor_4c_LocalImgPro")
9412:                             IF TYPE("cursor_4c_LocalImgPro.FigJpgs") # "U"
9413:                                 IF !EMPTY(NVL(cursor_4c_LocalImgPro.FigJpgs, ""))
9414:                                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_bor.jpg"
9415:                                     IF STRTOFILE(cursor_4c_LocalImgPro.FigJpgs, loc_lcArquivo) > 0
9416:                                         loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9417:                                         loc_oPg.img_4c_ImgBorracha.Visible = .T.
9418:                                     ENDIF
9419:                                 ENDIF
9420:                             ENDIF
9421:                         ENDIF
9422:                         USE IN cursor_4c_LocalImgPro
9423:                     ENDIF
9424:                 ENDIF
9425:             ENDIF
9426: 
9427:             loc_oPg.grd_4c_Matrizes.Refresh()

*-- Linhas 9435 a 10138:
9435:     * Legado: grdMatrizes.Column1.Text1.Valid = fwBuscaInt on crMatrizes by CPros
9436:     *         Apos selecao: preenche CMats e DLocs no cursor_4c_SigPrMtz
9437:     *--------------------------------------------------------------------------
9438:     PROCEDURE GrdMatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9439:         LOCAL loc_oBusca, loc_cAtual
9440:         IF par_nKeyCode = 115  && F4
9441:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9442:                 RETURN
9443:             ENDIF
9444:             TRY
9445:                 loc_cAtual = ""
9446:                 IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9447:                     loc_cAtual = ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, ""))
9448:                 ENDIF
9449:                 *-- Busca na tabela SigCdPro (produtos que sao matrizes)
9450:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9451:                     "SigCdPro", "cursor_4c_BuscaMatriz", "CPros", loc_cAtual, ;
9452:                     "Buscar Matriz")
9453:                 IF VARTYPE(loc_oBusca) = "O"
9454:                     IF !loc_oBusca.this_lAchouRegistro
9455:                         loc_oBusca.mAddColuna("CPros",  "", "Matriz")
9456:                         loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
9457:                         loc_oBusca.mAddColuna("Locals", "", "Local")
9458:                         loc_oBusca.Show()
9459:                     ENDIF
9460:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9461:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9462:                             SELECT cursor_4c_SigPrMtz
9463:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9464:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9465:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9466:                             ENDIF
9467:                         ENDIF
9468:                     ENDIF
9469:                     loc_oBusca.Release()
9470:                 ENDIF
9471:                 IF USED("cursor_4c_BuscaMatriz")
9472:                     USE IN cursor_4c_BuscaMatriz
9473:                 ENDIF
9474:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9475:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9476:                 ENDIF
9477:             CATCH TO loc_oErro
9478:                 MsgErro(loc_oErro.Message, "Erro ao buscar matriz")
9479:             ENDTRY
9480:         ENDIF
9481:     ENDPROC
9482: 
9483:     *--------------------------------------------------------------------------
9484:     * CmdIncluirFaseClick - Insere nova linha de fase em cursor_4c_GradFase
9485:     * Legado: inserir.Click - calcula proximo Ordems e insere com resequenciamento
9486:     *--------------------------------------------------------------------------
9487:     PROCEDURE CmdIncluirFaseClick()
9488:         LOCAL loc_oPg, loc_nOrdem
9489:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9490:             RETURN
9491:         ENDIF
9492:         TRY
9493:             IF !USED("cursor_4c_GradFase")
9494:                 RETURN
9495:             ENDIF
9496:             *-- Calcular proximo numero de ordem
9497:             loc_nOrdem = 0
9498:             IF !EOF("cursor_4c_GradFase")
9499:                 SELECT MAX(Ordems) AS nMaxOrdem FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpOrd NOFILTER
9500:                 IF USED("cursor_4c_TmpOrd") AND !EOF("cursor_4c_TmpOrd")
9501:                     loc_nOrdem = NVL(cursor_4c_TmpOrd.nMaxOrdem, 0)
9502:                 ENDIF
9503:                 IF USED("cursor_4c_TmpOrd")
9504:                     USE IN cursor_4c_TmpOrd
9505:                 ENDIF
9506:             ENDIF
9507:             loc_nOrdem = loc_nOrdem + 1
9508:             *-- Inserir nova linha
9509:             INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9510:                 VALUES (loc_nOrdem, "", "", "", "")
9511:             *-- Posicionar no novo registro e focar grid
9512:             GO BOTTOM IN cursor_4c_GradFase
9513:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9514:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9515:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9516:                     loc_oPg.grd_4c_GradFase.Refresh()
9517:                     loc_oPg.grd_4c_GradFase.SetFocus()
9518:                 ENDIF
9519:             ENDIF
9520:         CATCH TO loc_oErro
9521:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9522:         ENDTRY
9523:     ENDPROC
9524: 
9525:     *--------------------------------------------------------------------------
9526:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9527:     * Legado: excluir.Click - DELETE e resequencia Ordems
9528:     *--------------------------------------------------------------------------
9529:     PROCEDURE CmdExcluirFaseClick()
9530:         LOCAL loc_oPg, loc_lResultado
9531:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9532:             RETURN
9533:         ENDIF
9534:         loc_lResultado = .T.
9535:         TRY
9536:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9537:                 loc_lResultado = .F.
9538:             ENDIF
9539:             IF loc_lResultado
9540:                 IF !MsgConfirma("Excluir fase selecionada?")
9541:                     loc_lResultado = .F.
9542:                 ENDIF
9543:             ENDIF
9544:             IF loc_lResultado
9545:                 SELECT cursor_4c_GradFase
9546:                 DELETE
9547:                 IF !EOF("cursor_4c_GradFase")
9548:                     SKIP
9549:                 ENDIF
9550:                 IF EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
9551:                     GO BOTTOM IN cursor_4c_GradFase
9552:                 ENDIF
9553:                 *-- Resequenciar Ordems
9554:                 LOCAL loc_nSeq
9555:                 loc_nSeq = 1
9556:                 GO TOP IN cursor_4c_GradFase
9557:                 SCAN FOR !DELETED()
9558:                     REPLACE Ordems WITH loc_nSeq
9559:                     loc_nSeq = loc_nSeq + 1
9560:                 ENDSCAN
9561:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9562:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9563:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9564:                         loc_oPg.grd_4c_GradFase.Refresh()
9565:                     ENDIF
9566:                 ENDIF
9567:             ENDIF
9568:         CATCH TO loc_oErro
9569:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9570:         ENDTRY
9571:     ENDPROC
9572: 
9573:     *--------------------------------------------------------------------------
9574:     * CmdAlternativaFaseClick - Copia linha corrente como alternativa
9575:     * Legado: Alternativa.Click - duplica linha com mesmo Grupos mas nova Ordems
9576:     *--------------------------------------------------------------------------
9577:     PROCEDURE CmdAlternativaFaseClick()
9578:         LOCAL loc_oPg, loc_lResultado, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat
9579:         LOCAL loc_nOrdem
9580:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9581:             RETURN
9582:         ENDIF
9583:         loc_lResultado = .T.
9584:         TRY
9585:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
9586:                 loc_lResultado = .F.
9587:             ENDIF
9588:             IF loc_lResultado
9589:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_GradFase.Grupos, "")))
9590:                     MsgAviso("Selecione uma fase para criar alternativa.")
9591:                     loc_lResultado = .F.
9592:                 ENDIF
9593:             ENDIF
9594:             IF loc_lResultado
9595:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_GradFase.Grupos, ""))
9596:                 loc_cDescrs = ALLTRIM(NVL(cursor_4c_GradFase.Descrs, ""))
9597:                 loc_cUni    = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9598:                 loc_cMat    = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9599:                 *-- Calcular proxima ordem
9600:                 SELECT MAX(Ordems) AS nMaxOrd FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpAlt NOFILTER
9601:                 loc_nOrdem = 1
9602:                 IF USED("cursor_4c_TmpAlt") AND !EOF("cursor_4c_TmpAlt")
9603:                     loc_nOrdem = NVL(cursor_4c_TmpAlt.nMaxOrd, 0) + 1
9604:                 ENDIF
9605:                 IF USED("cursor_4c_TmpAlt")
9606:                     USE IN cursor_4c_TmpAlt
9607:                 ENDIF
9608:                 *-- Inserir copia como alternativa
9609:                 INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9610:                     VALUES (loc_nOrdem, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat)
9611:                 GO BOTTOM IN cursor_4c_GradFase
9612:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9613:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9614:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9615:                         loc_oPg.grd_4c_GradFase.Refresh()
9616:                     ENDIF
9617:                 ENDIF
9618:             ENDIF
9619:         CATCH TO loc_oErro
9620:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9621:         ENDTRY
9622:     ENDPROC
9623: 
9624:     *--------------------------------------------------------------------------
9625:     * CmdFichaClick - Gera ficha tecnica do produto (REPORT FORM)
9626:     * Legado: CmdFicha.Click - cria CsCabecalho cursor e REPORT FORM TP_FasePro
9627:     *--------------------------------------------------------------------------
9628:     PROCEDURE CmdFichaClick()
9629:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cNmEmp
9630:         loc_lResultado = .T.
9631:         TRY
9632:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
9633:                 loc_lResultado = .F.
9634:             ENDIF
9635:             IF loc_lResultado
9636:                 IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))
9637:                     MsgAviso("Produto n" + CHR(227) + "o selecionado.")
9638:                     loc_lResultado = .F.
9639:                 ENDIF
9640:             ENDIF
9641:             IF loc_lResultado
9642:                 *-- Nome da empresa ja disponivel em go_4c_Sistema.cEmpresa
9643:                 loc_cNmEmp = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
9644:                 *-- Preparar cursor de cabecalho para o relatorio
9645:                 IF USED("CsCabecalho")
9646:                     USE IN CsCabecalho
9647:                 ENDIF
9648:                 CREATE CURSOR CsCabecalho (;
9649:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9650:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9651:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9652:                     _nPeso N(9,2))
9653:                 WITH THIS.this_oBusinessObject
9654:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9655:                         VALUES (loc_cNmEmp, ;
9656:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9657:                                 ALLTRIM(.this_cCpros), ;
9658:                                 ALLTRIM(.this_cDpros), ;
9659:                                 ALLTRIM(.this_cCgrus), ;
9660:                                 .this_nPesobs)
9661:                 ENDWITH
9662:                 *-- Verificar e executar relatorio
9663:                 LOCAL loc_cRepPath
9664:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9665:                 IF FILE(loc_cRepPath)
9666:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9667:                 ELSE
9668:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")
9669:                 ENDIF
9670:                 IF USED("CsCabecalho")
9671:                     USE IN CsCabecalho
9672:                 ENDIF
9673:             ENDIF
9674:         CATCH TO loc_oErro
9675:             MsgErro(loc_oErro.Message, "Erro ao gerar ficha t" + CHR(233) + "cnica")
9676:         ENDTRY
9677:     ENDPROC
9678: 
9679:     *--------------------------------------------------------------------------
9680:     * CmdgFiguraClick - Seleciona imagem JPG/BMP para a fase corrente
9681:     * Legado: cmdgFigura.Click - GETPICT e armazena em crSigCdPrf.FigProcs
9682:     *--------------------------------------------------------------------------
9683:     PROCEDURE CmdgFiguraClick()
9684:         LOCAL loc_lResultado, loc_cFigura, loc_cArquivo
9685:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9686:             RETURN
9687:         ENDIF
9688:         loc_lResultado = .T.
9689:         TRY
9690:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9691:                 loc_lResultado = .F.
9692:             ENDIF
9693:             IF loc_lResultado
9694:                 *-- Abrir seletor de arquivo de imagem
9695:                 loc_cFigura = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", ;
9696:                     "Nome do Arquivo:", "Selecionar"))
9697:                 IF !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9698:                     *-- Armazenar imagem binaria no campo memo FigProcs
9699:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9700:                         SELECT cursor_4c_GradFase
9701:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9702:                     ENDIF
9703:                     *-- Atualizar exibicao da imagem
9704:                     THIS.GradFaseAfterRowColChange(0)
9705:                 ENDIF
9706:             ENDIF
9707:         CATCH TO loc_oErro
9708:             MsgErro(loc_oErro.Message, "Erro ao selecionar imagem")
9709:         ENDTRY
9710:     ENDPROC
9711: 
9712:     *--------------------------------------------------------------------------
9713:     * CmdgFigCamClick - Captura imagem via webcam (SigImage form)
9714:     * Legado: cmdgFigCam.Click - DO form SigImage TO lcFigura e armazena
9715:     *--------------------------------------------------------------------------
9716:     PROCEDURE CmdgFigCamClick()
9717:         LOCAL loc_lResultado, loc_cFigura
9718:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9719:             RETURN
9720:         ENDIF
9721:         loc_lResultado = .T.
9722:         TRY
9723:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9724:                 loc_lResultado = .F.
9725:             ENDIF
9726:             IF loc_lResultado
9727:                 loc_cFigura = ""
9728:                 *-- Acionar captura de webcam via form legado SigImage
9729:                 IF FILE(gc_4c_CaminhoBase + "SigImage.scx")
9730:                     DO FORM (gc_4c_CaminhoBase + "SigImage") TO loc_cFigura
9731:                 ELSE
9732:                     MsgAviso("Captura de imagem (SigImage) n" + CHR(227) + "o dispon" + CHR(237) + "vel.")
9733:                     loc_lResultado = .F.
9734:                 ENDIF
9735:                 IF loc_lResultado AND !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9736:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9737:                         SELECT cursor_4c_GradFase
9738:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9739:                     ENDIF
9740:                     THIS.GradFaseAfterRowColChange(0)
9741:                 ENDIF
9742:             ENDIF
9743:         CATCH TO loc_oErro
9744:             MsgErro(loc_oErro.Message, "Erro ao capturar imagem via webcam")
9745:         ENDTRY
9746:     ENDPROC
9747: 
9748:     *--------------------------------------------------------------------------
9749:     * ImgFigJpgClick - Abre imagem da fase em zoom (SigOpZom form)
9750:     * Legado: ImgFigJpg.Click - StrToFile e DO form SigOpZom
9751:     *--------------------------------------------------------------------------
9752:     PROCEDURE ImgFigJpgClick()
9753:         LOCAL loc_lcArquivo
9754:         TRY
9755:             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9756:                 IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9757:                     IF !EMPTY(NVL(cursor_4c_GradFase.FigProcs, ""))
9758:                         loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_zoom.jpg"
9759:                         IF STRTOFILE(cursor_4c_GradFase.FigProcs, loc_lcArquivo) > 0
9760:                             IF FILE(loc_lcArquivo)
9761:                                 DO FORM SigOpZom WITH loc_lcArquivo, .F.
9762:                             ENDIF
9763:                         ENDIF
9764:                     ENDIF
9765:                 ENDIF
9766:             ENDIF
9767:         CATCH TO loc_oErro
9768:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem em zoom")
9769:         ENDTRY
9770:     ENDPROC
9771: 
9772:     *--------------------------------------------------------------------------
9773:     * BtnInsereMtxClick - Insere nova linha de matriz em cursor_4c_SigPrMtz
9774:     * Legado: btnInsereMtx.Click - Insert Into crSigPrMtz se vazio
9775:     *--------------------------------------------------------------------------
9776:     PROCEDURE BtnInsereMtxClick()
9777:         LOCAL loc_oPg, loc_lResultado
9778:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9779:             RETURN
9780:         ENDIF
9781:         loc_lResultado = .T.
9782:         TRY
9783:             IF !USED("cursor_4c_SigPrMtz")
9784:                 loc_lResultado = .F.
9785:             ENDIF
9786:             IF loc_lResultado
9787:                 *-- Verificar se ja existe linha vazia (evitar duplicatas)
9788:                 GO TOP IN cursor_4c_SigPrMtz
9789:                 LOCATE FOR EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9790:                 IF !EOF("cursor_4c_SigPrMtz")
9791:                     *-- Ja existe linha vazia - apenas focar
9792:                     loc_lResultado = .F.
9793:                 ENDIF
9794:             ENDIF
9795:             IF loc_lResultado
9796:                 INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9797:                 GO BOTTOM IN cursor_4c_SigPrMtz
9798:             ENDIF
9799:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9800:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9801:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9802:                     loc_oPg.grd_4c_Matrizes.Refresh()
9803:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9804:                 ENDIF
9805:             ENDIF
9806:         CATCH TO loc_oErro
9807:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9808:         ENDTRY
9809:     ENDPROC
9810: 
9811:     *--------------------------------------------------------------------------
9812:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9813:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9814:     *--------------------------------------------------------------------------
9815:     PROCEDURE BtnExcluiMtzClick()
9816:         LOCAL loc_oPg, loc_lResultado
9817:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9818:             RETURN
9819:         ENDIF
9820:         loc_lResultado = .T.
9821:         TRY
9822:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9823:                 loc_lResultado = .F.
9824:             ENDIF
9825:             IF loc_lResultado
9826:                 SELECT cursor_4c_SigPrMtz
9827:                 DELETE
9828:                 *-- Se cursor ficou vazio, reinsere linha placeholder
9829:                 GO TOP IN cursor_4c_SigPrMtz
9830:                 LOCATE FOR !DELETED()
9831:                 IF EOF("cursor_4c_SigPrMtz")
9832:                     INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9833:                 ENDIF
9834:             ENDIF
9835:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9836:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9837:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9838:                     loc_oPg.grd_4c_Matrizes.Refresh()
9839:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9840:                 ENDIF
9841:             ENDIF
9842:         CATCH TO loc_oErro
9843:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9844:         ENDTRY
9845:     ENDPROC
9846: 
9847:     *--------------------------------------------------------------------------
9848:     * TxtCodacbLostFocus - Valida e busca acabamento (SigCdAca) ao sair do campo
9849:     * Legado: get_codacb.Valid = fwBuscaExt on SigCdAca by Cods
9850:     *         Apos selecao: preenche txt_4c__Dacb e atualiza BO
9851:     *--------------------------------------------------------------------------
9852:     PROCEDURE TxtCodacbLostFocus()
9853:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9854:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9855:             RETURN
9856:         ENDIF
9857:         loc_lResultado = .T.
9858:         TRY
9859:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9860:                 loc_lResultado = .F.
9861:             ENDIF
9862:             IF loc_lResultado
9863:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9864:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c__codacb.Value, ""))
9865:                 IF EMPTY(loc_cCod)
9866:                     loc_oPg.txt_4c__Dacb.Value = ""
9867:                     THIS.this_oBusinessObject.this_cCodacbs = ""
9868:                     loc_lResultado = .F.
9869:                 ENDIF
9870:             ENDIF
9871:             IF loc_lResultado
9872:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9873:                     "SigCdAca", "cursor_4c_BuscaAca", "Cods", loc_cCod, ;
9874:                     "Buscar Acabamento")
9875:                 IF VARTYPE(loc_oBusca) = "O"
9876:                     IF !loc_oBusca.this_lAchouRegistro
9877:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9878:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9879:                         loc_oBusca.Show()
9880:                     ENDIF
9881:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAca")
9882:                         loc_oPg.txt_4c__codacb.Value = ALLTRIM(NVL(cursor_4c_BuscaAca.Cods, ""))
9883:                         loc_oPg.txt_4c__Dacb.Value   = ALLTRIM(NVL(cursor_4c_BuscaAca.Descrs, ""))
9884:                         THIS.this_oBusinessObject.this_cCodacbs = loc_oPg.txt_4c__codacb.Value
9885:                     ELSE
9886:                         loc_oPg.txt_4c__codacb.Value = ""
9887:                         loc_oPg.txt_4c__Dacb.Value   = ""
9888:                         THIS.this_oBusinessObject.this_cCodacbs = ""
9889:                     ENDIF
9890:                     loc_oBusca.Release()
9891:                 ENDIF
9892:                 IF USED("cursor_4c_BuscaAca")
9893:                     USE IN cursor_4c_BuscaAca
9894:                 ENDIF
9895:             ENDIF
9896:         CATCH TO loc_oErro
9897:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
9898:         ENDTRY
9899:     ENDPROC
9900: 
9901:     *--------------------------------------------------------------------------
9902:     * TxtTamLostFocus - Valida e busca tamanho (SigCdTam) ao sair do campo
9903:     * Legado: getTam.Valid = fwBuscaExt on SigCdTam by Cods
9904:     *--------------------------------------------------------------------------
9905:     PROCEDURE TxtTamLostFocus()
9906:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9907:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9908:             RETURN
9909:         ENDIF
9910:         *-- Guard: evita reabrir lookup se valor nao mudou
9911:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9912:             LOCAL loc_cGuardaTam
9913:             loc_cGuardaTam = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Tam.Value, ""))
9914:             IF loc_cGuardaTam = THIS.this_cUltimoTxtTamLostFocusValidado
9915:                 RETURN
9916:             ENDIF
9917:             THIS.this_cUltimoTxtTamLostFocusValidado = loc_cGuardaTam
9918:         ENDIF
9919:         loc_lResultado = .T.
9920:         TRY
9921:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9922:                 loc_lResultado = .F.
9923:             ENDIF
9924:             IF loc_lResultado
9925:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9926:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Tam.Value, ""))
9927:                 IF EMPTY(loc_cCod)
9928:                     THIS.this_oBusinessObject.this_cCodtams = ""
9929:                     loc_lResultado = .F.
9930:                 ENDIF
9931:             ENDIF
9932:             IF loc_lResultado
9933:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9934:                     "SigCdTam", "cursor_4c_BuscaTam", "Cods", loc_cCod, ;
9935:                     "Buscar Tamanho Padr" + CHR(227) + "o")
9936:                 IF VARTYPE(loc_oBusca) = "O"
9937:                     IF !loc_oBusca.this_lAchouRegistro
9938:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
9939:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9940:                         loc_oBusca.Show()
9941:                     ENDIF
9942:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
9943:                         loc_oPg.txt_4c_Tam.Value = ALLTRIM(NVL(cursor_4c_BuscaTam.Cods, ""))
9944:                         THIS.this_oBusinessObject.this_cCodtams = loc_oPg.txt_4c_Tam.Value
9945:                     ELSE
9946:                         loc_oPg.txt_4c_Tam.Value = ""
9947:                         THIS.this_oBusinessObject.this_cCodtams = ""
9948:                     ENDIF
9949:                     loc_oBusca.Release()
9950:                 ENDIF
9951:                 IF USED("cursor_4c_BuscaTam")
9952:                     USE IN cursor_4c_BuscaTam
9953:                 ENDIF
9954:             ENDIF
9955:         CATCH TO loc_oErro
9956:             MsgErro(loc_oErro.Message, "Erro ao validar tamanho")
9957:         ENDTRY
9958:     ENDPROC
9959: 
9960:     *--------------------------------------------------------------------------
9961:     * TxtCorLostFocus - Valida e busca cor padrao (SigCdCor) ao sair do campo
9962:     * Legado: getCor.Valid = fwBuscaExt on SigCdCor by Cods
9963:     *--------------------------------------------------------------------------
9964:     PROCEDURE TxtCorLostFocus()
9965:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
9966:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9967:             RETURN
9968:         ENDIF
9969:         *-- Guard: evita reabrir lookup se valor nao mudou
9970:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9971:             LOCAL loc_cGuardaCor
9972:             loc_cGuardaCor = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Cor.Value, ""))
9973:             IF loc_cGuardaCor = THIS.this_cUltimoTxtCorLostFocusValidado
9974:                 RETURN
9975:             ENDIF
9976:             THIS.this_cUltimoTxtCorLostFocusValidado = loc_cGuardaCor
9977:         ENDIF
9978:         loc_lResultado = .T.
9979:         TRY
9980:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
9981:                 loc_lResultado = .F.
9982:             ENDIF
9983:             IF loc_lResultado
9984:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9985:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Cor.Value, ""))
9986:                 IF EMPTY(loc_cCod)
9987:                     THIS.this_oBusinessObject.this_cCodcors = ""
9988:                     loc_lResultado = .F.
9989:                 ENDIF
9990:             ENDIF
9991:             IF loc_lResultado
9992:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9993:                     "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cCod, ;
9994:                     "Buscar Cor Padr" + CHR(227) + "o")
9995:                 IF VARTYPE(loc_oBusca) = "O"
9996:                     IF !loc_oBusca.this_lAchouRegistro
9997:                         loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
9998:                         loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9999:                         loc_oBusca.Show()
10000:                     ENDIF
10001:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
10002:                         loc_oPg.txt_4c_Cor.Value = ALLTRIM(NVL(cursor_4c_BuscaCor.cods, ""))
10003:                         THIS.this_oBusinessObject.this_cCodcors = loc_oPg.txt_4c_Cor.Value
10004:                     ELSE
10005:                         loc_oPg.txt_4c_Cor.Value = ""
10006:                         THIS.this_oBusinessObject.this_cCodcors = ""
10007:                     ENDIF
10008:                     loc_oBusca.Release()
10009:                 ENDIF
10010:                 IF USED("cursor_4c_BuscaCor")
10011:                     USE IN cursor_4c_BuscaCor
10012:                 ENDIF
10013:             ENDIF
10014:         CATCH TO loc_oErro
10015:             MsgErro(loc_oErro.Message, "Erro ao validar cor")
10016:         ENDTRY
10017:     ENDPROC
10018: 
10019:     *--------------------------------------------------------------------------
10020:     * TxtConquilhaLostFocus - Valida conquilha (SigCdCnq) ao sair do campo
10021:     * Legado: getConquilha.Valid = SQL SELECT conquilhas FROM SigCdCnq + fwBuscaInt
10022:     *--------------------------------------------------------------------------
10023:     PROCEDURE TxtConquilhaLostFocus()
10024:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
10025:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10026:             RETURN
10027:         ENDIF
10028:         *-- Guard: evita reabrir lookup se valor nao mudou
10029:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
10030:             LOCAL loc_cGuardaCnq
10031:             loc_cGuardaCnq = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Conquilha.Value, ""))
10032:             IF loc_cGuardaCnq = THIS.this_cUltimoTxtConquilhaLostFocusValidado
10033:                 RETURN
10034:             ENDIF
10035:             THIS.this_cUltimoTxtConquilhaLostFocusValidado = loc_cGuardaCnq
10036:         ENDIF
10037:         loc_lResultado = .T.
10038:         TRY
10039:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10040:                 loc_lResultado = .F.
10041:             ENDIF
10042:             IF loc_lResultado
10043:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10044:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Conquilha.Value, ""))
10045:                 IF EMPTY(loc_cCod)
10046:                     THIS.this_oBusinessObject.this_cConquilhas = ""
10047:                     loc_lResultado = .F.
10048:                 ENDIF
10049:             ENDIF
10050:             IF loc_lResultado
10051:                 *-- Buscar conquilhas disponiveis em SigCdCnq
10052:                 loc_cSQL = "SELECT DISTINCT conquilhas FROM SigCdCnq"
10053:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaCnq")
10054:                 IF loc_nRet > 0 AND USED("cursor_4c_ListaCnq")
10055:                     SELECT cursor_4c_ListaCnq
10056:                     LOCATE FOR ALLTRIM(NVL(conquilhas, "")) = PADR(loc_cCod, 10)
10057:                     IF !EOF("cursor_4c_ListaCnq")
10058:                         *-- Encontrado direto
10059:                         loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_ListaCnq.conquilhas)
10060:                         THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10061:                     ELSE
10062:                         *-- Nao encontrado - abrir lookup
10063:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10064:                             "SigCdCnq", "cursor_4c_BuscaCnq", "conquilhas", loc_cCod, ;
10065:                             "Buscar Conquilha")
10066:                         IF VARTYPE(loc_oBusca) = "O"
10067:                             IF !loc_oBusca.this_lAchouRegistro
10068:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10069:                                 loc_oBusca.Show()
10070:                             ENDIF
10071:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnq")
10072:                                 loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(NVL(cursor_4c_BuscaCnq.conquilhas, ""))
10073:                                 THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10074:                             ELSE
10075:                                 loc_oPg.txt_4c_Conquilha.Value = ""
10076:                                 THIS.this_oBusinessObject.this_cConquilhas = ""
10077:                             ENDIF
10078:                             loc_oBusca.Release()
10079:                         ENDIF
10080:                         IF USED("cursor_4c_BuscaCnq")
10081:                             USE IN cursor_4c_BuscaCnq
10082:                         ENDIF
10083:                     ENDIF
10084:                     USE IN cursor_4c_ListaCnq
10085:                 ENDIF
10086:             ENDIF
10087:         CATCH TO loc_oErro
10088:             MsgErro(loc_oErro.Message, "Erro ao validar conquilha")
10089:         ENDTRY
10090:     ENDPROC
10091: 
10092:     *==========================================================================
10093:     * FASE 13 - Aba Dados Fiscais (pgDadosFiscais - Page3 do pgf_4c_Dados)
10094:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais
10095:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10096:     * Controles: 16 textboxes, 11 labels, 1 editbox, 1 combobox, 1 grid(3col), 1 button
10097:     *==========================================================================
10098:     PROTECTED PROCEDURE ConfigurarPgPgDadosFiscais()
10099:         LOCAL loc_oPg, loc_oGrd
10100:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10101: 
10102:         *----------------------------------------------------------------------
10103:         *-- Cursor placeholder cursor_4c_Cmv (SigCdCmv - Valor Grama)
10104:         *-- Campos: Datas, ValCuss, Moedas (readonly grid)
10105:         *----------------------------------------------------------------------
10106:         IF !USED("cursor_4c_Cmv")
10107:             SET NULL ON
10108:             CREATE CURSOR cursor_4c_Cmv (;
10109:                 Datas   D, ;
10110:                 ValCuss N(12,3), ;
10111:                 Moedas  C(3))
10112:             SET NULL OFF
10113:         ENDIF
10114: 
10115:         *----------------------------------------------------------------------
10116:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10117:         *----------------------------------------------------------------------
10118:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10119:         WITH loc_oPg.lbl_4c_LblGruCus
10120:             .Caption   = "Grupo C.C. :"
10121:             .Top       = 165
10122:             .Left      = 138
10123:             .Width     = 63
10124:             .Height    = 15
10125:             .FontName  = "Tahoma"
10126:             .FontSize  = 8
10127:             .BackStyle = 0
10128:             .ForeColor = RGB(90, 90, 90)
10129:             .Visible   = .T.
10130:         ENDWITH
10131: 
10132:         loc_oPg.AddObject("lbl_4c_LblContaCus", "Label")
10133:         WITH loc_oPg.lbl_4c_LblContaCus
10134:             .Caption   = "Conta C.C. :"
10135:             .Top       = 189
10136:             .Left      = 138
10137:             .Width     = 63
10138:             .Height    = 15

*-- Linhas 10431 a 10700:
10431:             .Enabled       = .F.
10432:             .Visible       = .T.
10433:         ENDWITH
10434:         BINDEVENT(loc_oPg.txt_4c_Gruccus, "LostFocus", THIS, "TxtGruccusFiscLostFocus")
10435: 
10436:         *-- get_dgruccus: Descricao Grupo CC (T:161 L:288 W:318 H:23) readonly
10437:         loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
10438:         WITH loc_oPg.txt_4c_Dgruccus
10439:             .Top           = 161
10440:             .Left          = 288
10441:             .Width         = 318
10442:             .Height        = 23
10443:             .Value         = ""
10444:             .FontName      = "Tahoma"
10445:             .FontSize      = 8
10446:             .SpecialEffect = 1
10447:             .ForeColor     = RGB(36, 84, 155)
10448:             .ReadOnly      = .T.
10449:             .Enabled       = .F.
10450:             .Visible       = .T.
10451:         ENDWITH
10452: 
10453:         *-- get_contaccus: Conta de Custo (T:186 L:206 W:80 H:23)
10454:         loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
10455:         WITH loc_oPg.txt_4c_Contaccus
10456:             .Top           = 186
10457:             .Left          = 206
10458:             .Width         = 80
10459:             .Height        = 23
10460:             .Value         = ""
10461:             .FontName      = "Tahoma"
10462:             .FontSize      = 8
10463:             .SpecialEffect = 1
10464:             .ForeColor     = RGB(36, 84, 155)
10465:             .Enabled       = .F.
10466:             .Visible       = .T.
10467:         ENDWITH
10468:         BINDEVENT(loc_oPg.txt_4c_Contaccus, "LostFocus", THIS, "TxtContaccusFiscLostFocus")
10469: 
10470:         *-- get_dcontaccus: Descricao Conta CC (T:186 L:288 W:318 H:23) readonly
10471:         loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
10472:         WITH loc_oPg.txt_4c_Dcontaccus
10473:             .Top           = 186
10474:             .Left          = 288
10475:             .Width         = 318
10476:             .Height        = 23
10477:             .Value         = ""
10478:             .FontName      = "Tahoma"
10479:             .FontSize      = 8
10480:             .SpecialEffect = 1
10481:             .ForeColor     = RGB(36, 84, 155)
10482:             .ReadOnly      = .T.
10483:             .Enabled       = .F.
10484:             .Visible       = .T.
10485:         ENDWITH
10486: 
10487:         *----------------------------------------------------------------------
10488:         *-- TextBoxes da area Fiscal Principal
10489:         *----------------------------------------------------------------------
10490:         *-- getClfiscal: Classificacao Fiscal (T:211 L:206 W:94 H:23)
10491:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
10492:         WITH loc_oPg.txt_4c_Clfiscal
10493:             .Top           = 211
10494:             .Left          = 206
10495:             .Width         = 94
10496:             .Height        = 23
10497:             .Value         = ""
10498:             .FontName      = "Tahoma"
10499:             .FontSize      = 8
10500:             .SpecialEffect = 1
10501:             .ForeColor     = RGB(36, 84, 155)
10502:             .Enabled       = .F.
10503:             .Visible       = .T.
10504:         ENDWITH
10505:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "LostFocus", THIS, "TxtClfiscalFiscLostFocus")
10506: 
10507:         *-- getDclfiscal: Descricao Classif. Fiscal (T:211 L:303 W:303 H:23) readonly
10508:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
10509:         WITH loc_oPg.txt_4c_Dclfiscal
10510:             .Top           = 211
10511:             .Left          = 303
10512:             .Width         = 303
10513:             .Height        = 23
10514:             .Value         = ""
10515:             .FontName      = "Tahoma"
10516:             .FontSize      = 8
10517:             .SpecialEffect = 1
10518:             .ForeColor     = RGB(36, 84, 155)
10519:             .ReadOnly      = .T.
10520:             .Enabled       = .F.
10521:             .Visible       = .T.
10522:         ENDWITH
10523:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "LostFocus", THIS, "TxtDclfiscalFiscLostFocus")
10524: 
10525:         *-- getOrigmerc: Origem Mercadoria (T:236 L:206 W:17 H:23)
10526:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
10527:         WITH loc_oPg.txt_4c_Origmerc
10528:             .Top           = 236
10529:             .Left          = 206
10530:             .Width         = 17
10531:             .Height        = 23
10532:             .Value         = ""
10533:             .FontName      = "Tahoma"
10534:             .FontSize      = 8
10535:             .SpecialEffect = 1
10536:             .ForeColor     = RGB(36, 84, 155)
10537:             .Enabled       = .F.
10538:             .Visible       = .T.
10539:         ENDWITH
10540:         BINDEVENT(loc_oPg.txt_4c_Origmerc, "LostFocus", THIS, "TxtOrigmercFiscLostFocus")
10541: 
10542:         *-- getDorigmerc: Descricao Origem (T:236 L:226 W:380 H:23)
10543:         *-- Visivel apenas quando Origmerc vazio (readonly com busca reversa)
10544:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
10545:         WITH loc_oPg.txt_4c_Dorigmerc
10546:             .Top           = 236
10547:             .Left          = 226
10548:             .Width         = 380
10549:             .Height        = 23
10550:             .Value         = ""
10551:             .FontName      = "Tahoma"
10552:             .FontSize      = 8
10553:             .SpecialEffect = 1
10554:             .ForeColor     = RGB(36, 84, 155)
10555:             .ReadOnly      = .T.
10556:             .Enabled       = .F.
10557:             .Visible       = .T.
10558:         ENDWITH
10559: 
10560:         *-- getSittricm: Situacao Tributaria ICMS (T:261 L:206 W:31 H:23)
10561:         loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
10562:         WITH loc_oPg.txt_4c_Sittricm
10563:             .Top           = 261
10564:             .Left          = 206
10565:             .Width         = 31
10566:             .Height        = 23
10567:             .Value         = ""
10568:             .FontName      = "Tahoma"
10569:             .FontSize      = 8
10570:             .SpecialEffect = 1
10571:             .ForeColor     = RGB(36, 84, 155)
10572:             .Enabled       = .F.
10573:             .Visible       = .T.
10574:         ENDWITH
10575:         BINDEVENT(loc_oPg.txt_4c_Sittricm, "LostFocus", THIS, "TxtSittricmFiscLostFocus")
10576: 
10577:         *-- getDsittricm: Descricao Sit. Trib. ICMS (T:261 L:240 W:366 H:23) readonly
10578:         loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
10579:         WITH loc_oPg.txt_4c_Dsittricm
10580:             .Top           = 261
10581:             .Left          = 240
10582:             .Width         = 366
10583:             .Height        = 23
10584:             .Value         = ""
10585:             .FontName      = "Tahoma"
10586:             .FontSize      = 8
10587:             .SpecialEffect = 1
10588:             .ForeColor     = RGB(36, 84, 155)
10589:             .ReadOnly      = .T.
10590:             .Enabled       = .F.
10591:             .Visible       = .T.
10592:         ENDWITH
10593: 
10594:         *-- Get_CodServs: Cod. Servicos ICMS (T:286 L:206 W:38 H:23)
10595:         loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
10596:         WITH loc_oPg.txt_4c_CodServs
10597:             .Top           = 286
10598:             .Left          = 206
10599:             .Width         = 38
10600:             .Height        = 23
10601:             .Value         = ""
10602:             .FontName      = "Tahoma"
10603:             .FontSize      = 8
10604:             .SpecialEffect = 1
10605:             .ForeColor     = RGB(36, 84, 155)
10606:             .Enabled       = .F.
10607:             .Visible       = .T.
10608:         ENDWITH
10609:         BINDEVENT(loc_oPg.txt_4c_CodServs, "LostFocus", THIS, "TxtCodServsFiscLostFocus")
10610: 
10611:         *-- getIcms: Aliquota ICMS (T:286 L:342 W:45 H:23)
10612:         loc_oPg.AddObject("txt_4c_Icms", "TextBox")
10613:         WITH loc_oPg.txt_4c_Icms
10614:             .Top           = 286
10615:             .Left          = 342
10616:             .Width         = 45
10617:             .Height        = 23
10618:             .Value         = 0
10619:             .FontName      = "Tahoma"
10620:             .FontSize      = 8
10621:             .SpecialEffect = 1
10622:             .ForeColor     = RGB(36, 84, 155)
10623:             .Enabled       = .F.
10624:             .Visible       = .T.
10625:         ENDWITH
10626: 
10627:         *-- Get_TpTrib: Tipo Tributacao (T:286 L:513 W:38 H:23)
10628:         loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
10629:         WITH loc_oPg.txt_4c_TpTrib
10630:             .Top           = 286
10631:             .Left          = 513
10632:             .Width         = 38
10633:             .Height        = 23
10634:             .Value         = ""
10635:             .FontName      = "Tahoma"
10636:             .FontSize      = 8
10637:             .SpecialEffect = 1
10638:             .ForeColor     = RGB(36, 84, 155)
10639:             .Enabled       = .F.
10640:             .Visible       = .T.
10641:         ENDWITH
10642:         BINDEVENT(loc_oPg.txt_4c_TpTrib, "LostFocus", THIS, "TxtTpTribFiscLostFocus")
10643: 
10644:         *-- getiat: IAT - Arredondamento/Truncamento (T:286 L:589 W:17 H:23) MaxLength=1
10645:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
10646:         WITH loc_oPg.txt_4c_Iat
10647:             .Top           = 286
10648:             .Left          = 589
10649:             .Width         = 17
10650:             .Height        = 23
10651:             .Value         = ""
10652:             .FontName      = "Tahoma"
10653:             .FontSize      = 8
10654:             .SpecialEffect = 1
10655:             .ForeColor     = RGB(36, 84, 155)
10656:             .MaxLength     = 1
10657:             .Enabled       = .F.
10658:             .Visible       = .T.
10659:         ENDWITH
10660:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "TxtIatFiscLostFocus")
10661: 
10662:         *----------------------------------------------------------------------
10663:         *-- ComboBox cmbIpi: Tipo IPI (T:311 L:206 W:108 H:25)
10664:         *-- Items: '' | Tributado | Isento | Outros
10665:         *----------------------------------------------------------------------
10666:         loc_oPg.AddObject("cmb_4c_Ipi", "ComboBox")
10667:         WITH loc_oPg.cmb_4c_Ipi
10668:             .Top           = 311
10669:             .Left          = 206
10670:             .Width         = 108
10671:             .Height        = 25
10672:             .FontName      = "Tahoma"
10673:             .FontSize      = 8
10674:             .SpecialEffect = 1
10675:             .Style         = 2
10676:             .Enabled       = .F.
10677:             .Visible       = .T.
10678:         ENDWITH
10679:         loc_oPg.cmb_4c_Ipi.Clear()
10680:         loc_oPg.cmb_4c_Ipi.AddItem(PADR("", 10))
10681:         loc_oPg.cmb_4c_Ipi.AddItem("Tributado")
10682:         loc_oPg.cmb_4c_Ipi.AddItem("Isento   ")
10683:         loc_oPg.cmb_4c_Ipi.AddItem("Outros   ")
10684: 
10685:         *-- Get_AliqIPI: Aliquota IPI (T:311 L:425 W:45 H:25)
10686:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
10687:         WITH loc_oPg.txt_4c_AliqIPI
10688:             .Top           = 311
10689:             .Left          = 425
10690:             .Width         = 45
10691:             .Height        = 25
10692:             .Value         = 0
10693:             .FontName      = "Tahoma"
10694:             .FontSize      = 8
10695:             .SpecialEffect = 1
10696:             .ForeColor     = RGB(36, 84, 155)
10697:             .Enabled       = .F.
10698:             .Visible       = .T.
10699:         ENDWITH
10700: 

*-- Linhas 10732 a 10775:
10732:             .Enabled         = .F.
10733:             .Visible         = .T.
10734:         ENDWITH
10735:         BINDEVENT(loc_oPg.cmd_4c_DescFis, "Click", THIS, "CmdDescFisClick")
10736: 
10737:         *----------------------------------------------------------------------
10738:         *-- EditBox mgetdescfi: Descricao Fiscal (T:338 L:206 W:509 H:89)
10739:         *----------------------------------------------------------------------
10740:         loc_oPg.AddObject("obj_4c_Descfis", "EditBox")
10741:         WITH loc_oPg.obj_4c_Descfis
10742:             .Top           = 338
10743:             .Left          = 206
10744:             .Width         = 509
10745:             .Height        = 89
10746:             .Value         = ""
10747:             .FontName      = "Tahoma"
10748:             .FontSize      = 8
10749:             .SpecialEffect = 1
10750:             .ForeColor     = RGB(36, 84, 155)
10751:             .Enabled       = .F.
10752:             .Visible       = .T.
10753:         ENDWITH
10754: 
10755:         *----------------------------------------------------------------------
10756:         *-- TextBoxes area ECF / Metal / Teor / Valor
10757:         *----------------------------------------------------------------------
10758:         *-- getDescEcfs: Descricao ECF (T:429 L:206 W:213 H:23)
10759:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
10760:         WITH loc_oPg.txt_4c_DescEcfs
10761:             .Top           = 429
10762:             .Left          = 206
10763:             .Width         = 213
10764:             .Height        = 23
10765:             .Value         = ""
10766:             .FontName      = "Tahoma"
10767:             .FontSize      = 8
10768:             .SpecialEffect = 1
10769:             .ForeColor     = RGB(36, 84, 155)
10770:             .MaxLength     = 29
10771:             .Enabled       = .F.
10772:             .Visible       = .T.
10773:         ENDWITH
10774: 
10775:         *-- Get_metal: Metal (T:429 L:537 W:24 H:23)

*-- Linhas 10787 a 10830:
10787:             .Enabled       = .F.
10788:             .Visible       = .T.
10789:         ENDWITH
10790:         BINDEVENT(loc_oPg.txt_4c_Metal, "LostFocus", THIS, "TxtMetalFiscLostFocus")
10791: 
10792:         *-- Get_DesMetal: Descricao Metal (T:429 L:564 W:150 H:23) readonly
10793:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
10794:         WITH loc_oPg.txt_4c_DesMetal
10795:             .Top           = 429
10796:             .Left          = 564
10797:             .Width         = 150
10798:             .Height        = 23
10799:             .Value         = ""
10800:             .FontName      = "Tahoma"
10801:             .FontSize      = 8
10802:             .SpecialEffect = 1
10803:             .ForeColor     = RGB(36, 84, 155)
10804:             .ReadOnly      = .T.
10805:             .Enabled       = .F.
10806:             .Visible       = .T.
10807:         ENDWITH
10808: 
10809:         *-- getValor: Valor Estimado (T:454 L:206 W:108 H:23) numeric
10810:         loc_oPg.AddObject("txt_4c_ValorEstim", "TextBox")
10811:         WITH loc_oPg.txt_4c_ValorEstim
10812:             .Top           = 454
10813:             .Left          = 206
10814:             .Width         = 108
10815:             .Height        = 23
10816:             .Value         = 0
10817:             .FontName      = "Tahoma"
10818:             .FontSize      = 8
10819:             .SpecialEffect = 1
10820:             .ForeColor     = RGB(36, 84, 155)
10821:             .Enabled       = .F.
10822:             .Visible       = .T.
10823:         ENDWITH
10824: 
10825:         *-- GetMvalor: Moeda do Valor (T:454 L:317 W:31 H:23) - lookup SigCdMoe
10826:         loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
10827:         WITH loc_oPg.txt_4c_Mvalor
10828:             .Top           = 454
10829:             .Left          = 317
10830:             .Width         = 31

*-- Linhas 10837 a 10897:
10837:             .Enabled       = .F.
10838:             .Visible       = .T.
10839:         ENDWITH
10840:         BINDEVENT(loc_oPg.txt_4c_Mvalor, "LostFocus", THIS, "TxtMvalorFiscLostFocus")
10841: 
10842:         *-- Get_teor: Teor (T:454 L:537 W:24 H:23)
10843:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
10844:         WITH loc_oPg.txt_4c_Teor
10845:             .Top           = 454
10846:             .Left          = 537
10847:             .Width         = 24
10848:             .Height        = 23
10849:             .Value         = ""
10850:             .FontName      = "Tahoma"
10851:             .FontSize      = 8
10852:             .SpecialEffect = 1
10853:             .ForeColor     = RGB(36, 84, 155)
10854:             .Enabled       = .F.
10855:             .Visible       = .T.
10856:         ENDWITH
10857:         BINDEVENT(loc_oPg.txt_4c_Teor, "LostFocus", THIS, "TxtTeorFiscLostFocus")
10858: 
10859:         *-- Get_DesTeor: Descricao Teor (T:454 L:564 W:150 H:23) readonly
10860:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
10861:         WITH loc_oPg.txt_4c_DesTeor
10862:             .Top           = 454
10863:             .Left          = 564
10864:             .Width         = 150
10865:             .Height        = 23
10866:             .Value         = ""
10867:             .FontName      = "Tahoma"
10868:             .FontSize      = 8
10869:             .SpecialEffect = 1
10870:             .ForeColor     = RGB(36, 84, 155)
10871:             .ReadOnly      = .T.
10872:             .Enabled       = .F.
10873:             .Visible       = .T.
10874:         ENDWITH
10875: 
10876:         *-- getIPPTCST: IPPT/CST (T:479 L:206 W:108 H:23) readonly (When=.f.)
10877:         loc_oPg.AddObject("txt_4c_IpptCST", "TextBox")
10878:         WITH loc_oPg.txt_4c_IpptCST
10879:             .Top           = 479
10880:             .Left          = 206
10881:             .Width         = 108
10882:             .Height        = 23
10883:             .Value         = ""
10884:             .FontName      = "Tahoma"
10885:             .FontSize      = 8
10886:             .SpecialEffect = 1
10887:             .ForeColor     = RGB(36, 84, 155)
10888:             .ReadOnly      = .T.
10889:             .Enabled       = .F.
10890:             .Visible       = .T.
10891:         ENDWITH
10892: 
10893:         *----------------------------------------------------------------------
10894:         *-- Grid grdCmv: Valor do Grama Produzido (T:338 L:754 W:223 H:141)
10895:         *-- Colunas: Periodo | Valor Custo GR | Moe (readonly)
10896:         *----------------------------------------------------------------------
10897:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")

*-- Linhas 10944 a 10987:
10944:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10945:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10946:     *--------------------------------------------------------------------------
10947:     PROTECTED PROCEDURE PreencherCamposFiscais()
10948:         LOCAL loc_oPg, loc_cIpiVal
10949:         TRY
10950:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10951:                 RETURN
10952:             ENDIF
10953:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10954:             IF VARTYPE(loc_oPg) # "O"
10955:                 RETURN
10956:             ENDIF
10957:             WITH THIS.this_oBusinessObject
10958:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
10959:                     loc_oPg.txt_4c_Gruccus.Value = ALLTRIM(.this_cGruccus)
10960:                 ENDIF
10961:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
10962:                     loc_oPg.txt_4c_Contaccus.Value = ALLTRIM(.this_cContaccus)
10963:                 ENDIF
10964:                 IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
10965:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(.this_cClfiscals)
10966:                 ENDIF
10967:                 IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
10968:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(.this_cOrigmercs)
10969:                 ENDIF
10970:                 IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
10971:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(.this_cSittricms)
10972:                 ENDIF
10973:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
10974:                     loc_oPg.txt_4c_CodServs.Value = ALLTRIM(.this_cCodservs)
10975:                 ENDIF
10976:                 IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
10977:                     loc_oPg.txt_4c_Icms.Value = .this_nIcms
10978:                 ENDIF
10979:                 IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
10980:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(.this_cTptribs)
10981:                 ENDIF
10982:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
10983:                     loc_oPg.txt_4c_Iat.Value = ALLTRIM(.this_cIats)
10984:                 ENDIF
10985:                 *-- cmbIpi: converte this_cIpis (T/I/O/'') para texto do combo
10986:                 IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
10987:                     DO CASE

*-- Linhas 11030 a 11073:
11030:     * LerCamposFiscais - Le controles de pgDadosFiscais e transfere para o BO
11031:     * Chamado por FormParaBO antes de salvar
11032:     *--------------------------------------------------------------------------
11033:     PROTECTED PROCEDURE LerCamposFiscais()
11034:         LOCAL loc_oPg, loc_cIpiTxt
11035:         TRY
11036:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11037:                 RETURN
11038:             ENDIF
11039:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11040:             IF VARTYPE(loc_oPg) # "O"
11041:                 RETURN
11042:             ENDIF
11043:             WITH THIS.this_oBusinessObject
11044:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
11045:                     .this_cGruccus = ALLTRIM(loc_oPg.txt_4c_Gruccus.Value)
11046:                 ENDIF
11047:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
11048:                     .this_cContaccus = ALLTRIM(loc_oPg.txt_4c_Contaccus.Value)
11049:                 ENDIF
11050:                 IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
11051:                     .this_cClfiscals = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
11052:                 ENDIF
11053:                 IF VARTYPE(loc_oPg.txt_4c_Origmerc) = "O"
11054:                     .this_cOrigmercs = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
11055:                 ENDIF
11056:                 IF VARTYPE(loc_oPg.txt_4c_Sittricm) = "O"
11057:                     .this_cSittricms = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
11058:                 ENDIF
11059:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
11060:                     .this_cCodservs = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
11061:                 ENDIF
11062:                 IF VARTYPE(loc_oPg.txt_4c_Icms) = "O"
11063:                     .this_nIcms = loc_oPg.txt_4c_Icms.Value
11064:                 ENDIF
11065:                 IF VARTYPE(loc_oPg.txt_4c_TpTrib) = "O"
11066:                     .this_cTptribs = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
11067:                 ENDIF
11068:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
11069:                     .this_cIats = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
11070:                 ENDIF
11071:                 *-- cmbIpi: converte texto para char(1)
11072:                 IF VARTYPE(loc_oPg.cmb_4c_Ipi) = "O"
11073:                     loc_cIpiTxt = UPPER(LEFT(ALLTRIM(loc_oPg.cmb_4c_Ipi.Value), 1))

*-- Linhas 11110 a 11834:
11110:     *--------------------------------------------------------------------------
11111:     * TxtClfiscalFiscLostFocus - Lookup SigCdClf por Codigos
11112:     *--------------------------------------------------------------------------
11113:     PROCEDURE TxtClfiscalFiscLostFocus()
11114:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11115:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11116:             RETURN
11117:         ENDIF
11118:         *-- Guard: evita reabrir lookup se valor nao mudou
11119:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11120:             LOCAL loc_cGuardaClf
11121:             loc_cGuardaClf = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Clfiscal.Value, ""))
11122:             IF loc_cGuardaClf = THIS.this_cUltimoTxtClfiscalLostFocusValidado
11123:                 RETURN
11124:             ENDIF
11125:             THIS.this_cUltimoTxtClfiscalLostFocusValidado = loc_cGuardaClf
11126:         ENDIF
11127:         loc_lResultado = .T.
11128:         TRY
11129:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11130:                 loc_lResultado = .F.
11131:             ENDIF
11132:             IF loc_lResultado
11133:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11134:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
11135:                 IF EMPTY(loc_cCod)
11136:                     THIS.this_oBusinessObject.this_cClfiscals = ""
11137:                     IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11138:                         loc_oPg.txt_4c_Dclfiscal.Value = ""
11139:                     ENDIF
11140:                     loc_lResultado = .F.
11141:                 ENDIF
11142:             ENDIF
11143:             IF loc_lResultado
11144:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11145:                     "SigCdClf", "cursor_4c_BuscaClf", "Codigos", loc_cCod, ;
11146:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11147:                 IF VARTYPE(loc_oBusca) = "O"
11148:                     IF !loc_oBusca.this_lAchouRegistro
11149:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11150:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11151:                         loc_oBusca.Show()
11152:                     ENDIF
11153:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11154:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Codigos, ""))
11155:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11156:                             loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClf.Descricaos, ""))
11157:                         ENDIF
11158:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11159:                     ELSE
11160:                         loc_oPg.txt_4c_Clfiscal.Value = ""
11161:                         IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O"
11162:                             loc_oPg.txt_4c_Dclfiscal.Value = ""
11163:                         ENDIF
11164:                         THIS.this_oBusinessObject.this_cClfiscals = ""
11165:                     ENDIF
11166:                     loc_oBusca.Release()
11167:                 ENDIF
11168:                 IF USED("cursor_4c_BuscaClf")
11169:                     USE IN cursor_4c_BuscaClf
11170:                 ENDIF
11171:             ENDIF
11172:         CATCH TO loc_oErro
11173:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11174:         ENDTRY
11175:     ENDPROC
11176: 
11177:     *--------------------------------------------------------------------------
11178:     * TxtDclfiscalFiscLostFocus - Busca reversa SigCdClf por Descricaos
11179:     * Ativado quando getClfiscal esta vazio
11180:     *--------------------------------------------------------------------------
11181:     PROCEDURE TxtDclfiscalFiscLostFocus()
11182:         LOCAL loc_oPg, loc_oBusca, loc_cDesc, loc_lResultado
11183:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11184:             RETURN
11185:         ENDIF
11186:         *-- Guard: evita reabrir lookup se valor nao mudou
11187:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11188:             LOCAL loc_cGuardaDClf
11189:             loc_cGuardaDClf = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Dclfiscal.Value, ""))
11190:             IF loc_cGuardaDClf = THIS.this_cUltimoTxtDclfiscalLostFocusValidado
11191:                 RETURN
11192:             ENDIF
11193:             THIS.this_cUltimoTxtDclfiscalLostFocusValidado = loc_cGuardaDClf
11194:         ENDIF
11195:         loc_lResultado = .T.
11196:         TRY
11197:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11198:                 loc_lResultado = .F.
11199:             ENDIF
11200:             IF loc_lResultado
11201:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11202:                 *-- Apenas ativo quando codigo vazio
11203:                 IF NOT EMPTY(ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, "")))
11204:                     loc_lResultado = .F.
11205:                 ENDIF
11206:             ENDIF
11207:             IF loc_lResultado
11208:                 loc_cDesc = ALLTRIM(NVL(loc_oPg.txt_4c_Dclfiscal.Value, ""))
11209:                 IF EMPTY(loc_cDesc)
11210:                     loc_lResultado = .F.
11211:                 ENDIF
11212:             ENDIF
11213:             IF loc_lResultado
11214:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11215:                     "SigCdClf", "cursor_4c_BuscaClfR", "Descricaos", loc_cDesc, ;
11216:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11217:                 IF VARTYPE(loc_oBusca) = "O"
11218:                     IF !loc_oBusca.this_lAchouRegistro
11219:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11220:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11221:                         loc_oBusca.Show()
11222:                     ENDIF
11223:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClfR")
11224:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(NVL(cursor_4c_BuscaClfR.Codigos, ""))
11225:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(NVL(cursor_4c_BuscaClfR.Descricaos, ""))
11226:                         THIS.this_oBusinessObject.this_cClfiscals = loc_oPg.txt_4c_Clfiscal.Value
11227:                     ENDIF
11228:                     loc_oBusca.Release()
11229:                 ENDIF
11230:                 IF USED("cursor_4c_BuscaClfR")
11231:                     USE IN cursor_4c_BuscaClfR
11232:                 ENDIF
11233:             ENDIF
11234:         CATCH TO loc_oErro
11235:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal")
11236:         ENDTRY
11237:     ENDPROC
11238: 
11239:     *--------------------------------------------------------------------------
11240:     * TxtOrigmercFiscLostFocus - Lookup SigCdOrg por Codigos (origem mercadoria)
11241:     *--------------------------------------------------------------------------
11242:     PROCEDURE TxtOrigmercFiscLostFocus()
11243:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11244:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11245:             RETURN
11246:         ENDIF
11247:         *-- Guard: evita reabrir lookup se valor nao mudou
11248:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11249:             LOCAL loc_cGuardaOrg
11250:             loc_cGuardaOrg = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Origmerc.Value, ""))
11251:             IF loc_cGuardaOrg = THIS.this_cUltimoTxtOrigmercLostFocusValidado
11252:                 RETURN
11253:             ENDIF
11254:             THIS.this_cUltimoTxtOrigmercLostFocusValidado = loc_cGuardaOrg
11255:         ENDIF
11256:         loc_lResultado = .T.
11257:         TRY
11258:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11259:                 loc_lResultado = .F.
11260:             ENDIF
11261:             IF loc_lResultado
11262:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11263:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Origmerc.Value, ""))
11264:                 IF EMPTY(loc_cCod)
11265:                     THIS.this_oBusinessObject.this_cOrigmercs = ""
11266:                     IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11267:                         loc_oPg.txt_4c_Dorigmerc.Value = ""
11268:                     ENDIF
11269:                     loc_lResultado = .F.
11270:                 ENDIF
11271:             ENDIF
11272:             IF loc_lResultado
11273:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11274:                     "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", loc_cCod, ;
11275:                     "Buscar Origem da Mercadoria")
11276:                 IF VARTYPE(loc_oBusca) = "O"
11277:                     IF !loc_oBusca.this_lAchouRegistro
11278:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11279:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11280:                         loc_oBusca.Show()
11281:                     ENDIF
11282:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11283:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Codigos, ""))
11284:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11285:                             loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(NVL(cursor_4c_BuscaOrg.Descricaos, ""))
11286:                         ENDIF
11287:                         THIS.this_oBusinessObject.this_cOrigmercs = loc_oPg.txt_4c_Origmerc.Value
11288:                     ELSE
11289:                         loc_oPg.txt_4c_Origmerc.Value = ""
11290:                         IF VARTYPE(loc_oPg.txt_4c_Dorigmerc) = "O"
11291:                             loc_oPg.txt_4c_Dorigmerc.Value = ""
11292:                         ENDIF
11293:                         THIS.this_oBusinessObject.this_cOrigmercs = ""
11294:                     ENDIF
11295:                     loc_oBusca.Release()
11296:                 ENDIF
11297:                 IF USED("cursor_4c_BuscaOrg")
11298:                     USE IN cursor_4c_BuscaOrg
11299:                 ENDIF
11300:             ENDIF
11301:         CATCH TO loc_oErro
11302:             MsgErro(loc_oErro.Message, "Erro ao buscar origem da mercadoria")
11303:         ENDTRY
11304:     ENDPROC
11305: 
11306:     *--------------------------------------------------------------------------
11307:     * TxtSittricmFiscLostFocus - Lookup SigCdIcm por Codigos (sit. trib. ICMS)
11308:     *--------------------------------------------------------------------------
11309:     PROCEDURE TxtSittricmFiscLostFocus()
11310:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11311:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11312:             RETURN
11313:         ENDIF
11314:         *-- Guard: evita reabrir lookup se valor nao mudou
11315:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11316:             LOCAL loc_cGuardaIcm
11317:             loc_cGuardaIcm = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Sittricm.Value, ""))
11318:             IF loc_cGuardaIcm = THIS.this_cUltimoTxtSittricmLostFocusValidado
11319:                 RETURN
11320:             ENDIF
11321:             THIS.this_cUltimoTxtSittricmLostFocusValidado = loc_cGuardaIcm
11322:         ENDIF
11323:         loc_lResultado = .T.
11324:         TRY
11325:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11326:                 loc_lResultado = .F.
11327:             ENDIF
11328:             IF loc_lResultado
11329:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11330:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Sittricm.Value, ""))
11331:                 IF EMPTY(loc_cCod)
11332:                     THIS.this_oBusinessObject.this_cSittricms = ""
11333:                     IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11334:                         loc_oPg.txt_4c_Dsittricm.Value = ""
11335:                     ENDIF
11336:                     loc_lResultado = .F.
11337:                 ENDIF
11338:             ENDIF
11339:             IF loc_lResultado
11340:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11341:                     "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", loc_cCod, ;
11342:                     "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11343:                 IF VARTYPE(loc_oBusca) = "O"
11344:                     IF !loc_oBusca.this_lAchouRegistro
11345:                         loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "d.")
11346:                         loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11347:                         loc_oBusca.Show()
11348:                     ENDIF
11349:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11350:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Codigos, ""))
11351:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11352:                             loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(NVL(cursor_4c_BuscaIcm.Descricaos, ""))
11353:                         ENDIF
11354:                         THIS.this_oBusinessObject.this_cSittricms = loc_oPg.txt_4c_Sittricm.Value
11355:                     ELSE
11356:                         loc_oPg.txt_4c_Sittricm.Value = ""
11357:                         IF VARTYPE(loc_oPg.txt_4c_Dsittricm) = "O"
11358:                             loc_oPg.txt_4c_Dsittricm.Value = ""
11359:                         ENDIF
11360:                         THIS.this_oBusinessObject.this_cSittricms = ""
11361:                     ENDIF
11362:                     loc_oBusca.Release()
11363:                 ENDIF
11364:                 IF USED("cursor_4c_BuscaIcm")
11365:                     USE IN cursor_4c_BuscaIcm
11366:                 ENDIF
11367:             ENDIF
11368:         CATCH TO loc_oErro
11369:             MsgErro(loc_oErro.Message, "Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
11370:         ENDTRY
11371:     ENDPROC
11372: 
11373:     *--------------------------------------------------------------------------
11374:     * TxtCodServsFiscLostFocus - Armazena codigo de servicos no BO
11375:     *--------------------------------------------------------------------------
11376:     PROCEDURE TxtCodServsFiscLostFocus()
11377:         LOCAL loc_oPg
11378:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11379:             RETURN
11380:         ENDIF
11381:         TRY
11382:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11383:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11384:                 IF VARTYPE(loc_oPg.txt_4c_CodServs) = "O"
11385:                     THIS.this_oBusinessObject.this_cCodservs = ALLTRIM(NVL(loc_oPg.txt_4c_CodServs.Value, ""))
11386:                 ENDIF
11387:             ENDIF
11388:         CATCH TO loc_oErro
11389:             MsgErro(loc_oErro.Message, "Erro ao atualizar c" + CHR(243) + "digo de servi" + CHR(231) + "os")
11390:         ENDTRY
11391:     ENDPROC
11392: 
11393:     *--------------------------------------------------------------------------
11394:     * TxtTpTribFiscLostFocus - Lookup SigPrTri por Tipos (tipo tributacao)
11395:     *--------------------------------------------------------------------------
11396:     PROCEDURE TxtTpTribFiscLostFocus()
11397:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11398:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11399:             RETURN
11400:         ENDIF
11401:         *-- Guard: evita reabrir lookup se valor nao mudou
11402:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11403:             LOCAL loc_cGuardaTri
11404:             loc_cGuardaTri = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_TpTrib.Value, ""))
11405:             IF loc_cGuardaTri = THIS.this_cUltimoTxtTpTribLostFocusValidado
11406:                 RETURN
11407:             ENDIF
11408:             THIS.this_cUltimoTxtTpTribLostFocusValidado = loc_cGuardaTri
11409:         ENDIF
11410:         loc_lResultado = .T.
11411:         TRY
11412:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11413:                 loc_lResultado = .F.
11414:             ENDIF
11415:             IF loc_lResultado
11416:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11417:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_TpTrib.Value, ""))
11418:                 IF EMPTY(loc_cCod)
11419:                     THIS.this_oBusinessObject.this_cTptribs = ""
11420:                     loc_lResultado = .F.
11421:                 ENDIF
11422:             ENDIF
11423:             IF loc_lResultado
11424:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11425:                     "SigPrTri", "cursor_4c_BuscaTri", "Tipos", loc_cCod, ;
11426:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11427:                 IF VARTYPE(loc_oBusca) = "O"
11428:                     IF !loc_oBusca.this_lAchouRegistro
11429:                         loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11430:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11431:                         loc_oBusca.Show()
11432:                     ENDIF
11433:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11434:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(NVL(cursor_4c_BuscaTri.Tipos, ""))
11435:                         THIS.this_oBusinessObject.this_cTptribs = loc_oPg.txt_4c_TpTrib.Value
11436:                     ELSE
11437:                         loc_oPg.txt_4c_TpTrib.Value = ""
11438:                         THIS.this_oBusinessObject.this_cTptribs = ""
11439:                     ENDIF
11440:                     loc_oBusca.Release()
11441:                 ENDIF
11442:                 IF USED("cursor_4c_BuscaTri")
11443:                     USE IN cursor_4c_BuscaTri
11444:                 ENDIF
11445:             ENDIF
11446:         CATCH TO loc_oErro
11447:             MsgErro(loc_oErro.Message, "Erro ao buscar tipo de tributa" + CHR(231) + CHR(227) + "o")
11448:         ENDTRY
11449:     ENDPROC
11450: 
11451:     *--------------------------------------------------------------------------
11452:     * TxtIatFiscLostFocus - Valida IAT: apenas 'A', 'T' ou vazio
11453:     *--------------------------------------------------------------------------
11454:     PROCEDURE TxtIatFiscLostFocus()
11455:         LOCAL loc_oPg, loc_cVal
11456:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11457:             RETURN
11458:         ENDIF
11459:         TRY
11460:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11461:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11462:                 IF VARTYPE(loc_oPg.txt_4c_Iat) = "O"
11463:                     loc_cVal = UPPER(ALLTRIM(NVL(loc_oPg.txt_4c_Iat.Value, "")))
11464:                     IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "A", "T")
11465:                         MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11466:                             "Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
11467:                         loc_oPg.txt_4c_Iat.Value = ""
11468:                         THIS.this_oBusinessObject.this_cIats = ""
11469:                     ELSE
11470:                         THIS.this_oBusinessObject.this_cIats = loc_cVal
11471:                     ENDIF
11472:                 ENDIF
11473:             ENDIF
11474:         CATCH TO loc_oErro
11475:             MsgErro(loc_oErro.Message, "Erro ao validar IAT")
11476:         ENDTRY
11477:     ENDPROC
11478: 
11479:     *--------------------------------------------------------------------------
11480:     * TxtMvalorFiscLostFocus - Lookup SigCdMoe por CMoes (moeda do valor)
11481:     *--------------------------------------------------------------------------
11482:     PROCEDURE TxtMvalorFiscLostFocus()
11483:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado
11484:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11485:             RETURN
11486:         ENDIF
11487:         *-- Guard: evita reabrir lookup se valor nao mudou
11488:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11489:             LOCAL loc_cGuardaMoe
11490:             loc_cGuardaMoe = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Mvalor.Value, ""))
11491:             IF loc_cGuardaMoe = THIS.this_cUltimoTxtMvalorLostFocusValidado
11492:                 RETURN
11493:             ENDIF
11494:             THIS.this_cUltimoTxtMvalorLostFocusValidado = loc_cGuardaMoe
11495:         ENDIF
11496:         loc_lResultado = .T.
11497:         TRY
11498:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11499:                 loc_lResultado = .F.
11500:             ENDIF
11501:             IF loc_lResultado
11502:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11503:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Mvalor.Value, ""))
11504:                 IF EMPTY(loc_cCod)
11505:                     THIS.this_oBusinessObject.this_cMoedas = ""
11506:                     loc_lResultado = .F.
11507:                 ENDIF
11508:             ENDIF
11509:             IF loc_lResultado
11510:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11511:                     "SigCdMoe", "cursor_4c_BuscaMoeFisc", "cmoes", loc_cCod, ;
11512:                     "Buscar Moeda")
11513:                 IF VARTYPE(loc_oBusca) = "O"
11514:                     IF !loc_oBusca.this_lAchouRegistro
11515:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
11516:                         loc_oBusca.mAddColuna("dmoes", "", "Moeda")
11517:                         loc_oBusca.Show()
11518:                     ENDIF
11519:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeFisc")
11520:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(NVL(cursor_4c_BuscaMoeFisc.cmoes, ""))
11521:                         THIS.this_oBusinessObject.this_cMoedas = loc_oPg.txt_4c_Mvalor.Value
11522:                     ELSE
11523:                         loc_oPg.txt_4c_Mvalor.Value = ""
11524:                         THIS.this_oBusinessObject.this_cMoedas = ""
11525:                     ENDIF
11526:                     loc_oBusca.Release()
11527:                 ENDIF
11528:                 IF USED("cursor_4c_BuscaMoeFisc")
11529:                     USE IN cursor_4c_BuscaMoeFisc
11530:                 ENDIF
11531:             ENDIF
11532:         CATCH TO loc_oErro
11533:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
11534:         ENDTRY
11535:     ENDPROC
11536: 
11537:     *--------------------------------------------------------------------------
11538:     * TxtMetalFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos='M'
11539:     *--------------------------------------------------------------------------
11540:     PROCEDURE TxtMetalFiscLostFocus()
11541:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
11542:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11543:             RETURN
11544:         ENDIF
11545:         *-- Guard: evita reabrir lookup se valor nao mudou
11546:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11547:             LOCAL loc_cGuardaMtl
11548:             loc_cGuardaMtl = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Metal.Value, ""))
11549:             IF loc_cGuardaMtl = THIS.this_cUltimoTxtMetalLostFocusValidado
11550:                 RETURN
11551:             ENDIF
11552:             THIS.this_cUltimoTxtMetalLostFocusValidado = loc_cGuardaMtl
11553:         ENDIF
11554:         loc_lResultado = .T.
11555:         TRY
11556:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11557:                 loc_lResultado = .F.
11558:             ENDIF
11559:             IF loc_lResultado
11560:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11561:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Metal.Value, ""))
11562:                 IF EMPTY(loc_cCod)
11563:                     THIS.this_oBusinessObject.this_cMetals = ""
11564:                     IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11565:                         loc_oPg.txt_4c_DesMetal.Value = ""
11566:                     ENDIF
11567:                     loc_lResultado = .F.
11568:                 ENDIF
11569:             ENDIF
11570:             IF loc_lResultado
11571:                 *-- Carregar lista de metais (Tipos='M') para lookup
11572:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos = 'M'"
11573:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlM")
11574:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlM")
11575:                     *-- Verificar se codigo existe diretamente
11576:                     SELECT cursor_4c_BuscaMtlM
11577:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11578:                     IF !EOF("cursor_4c_BuscaMtlM")
11579:                         IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11580:                             loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlM.Descs, ""))
11581:                         ENDIF
11582:                         THIS.this_oBusinessObject.this_cMetals = loc_cCod
11583:                     ELSE
11584:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11585:                             "SigCdMtl", "cursor_4c_BuscaMtlSel", "Codigos", loc_cCod, ;
11586:                             "Buscar Metal")
11587:                         IF VARTYPE(loc_oBusca) = "O"
11588:                             IF !loc_oBusca.this_lAchouRegistro
11589:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11590:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11591:                                 loc_oBusca.Show()
11592:                             ENDIF
11593:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtlSel")
11594:                                 loc_oPg.txt_4c_Metal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Codigos, ""))
11595:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11596:                                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlSel.Descs, ""))
11597:                                 ENDIF
11598:                                 THIS.this_oBusinessObject.this_cMetals = loc_oPg.txt_4c_Metal.Value
11599:                             ELSE
11600:                                 loc_oPg.txt_4c_Metal.Value = ""
11601:                                 IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11602:                                     loc_oPg.txt_4c_DesMetal.Value = ""
11603:                                 ENDIF
11604:                                 THIS.this_oBusinessObject.this_cMetals = ""
11605:                             ENDIF
11606:                             loc_oBusca.Release()
11607:                         ENDIF
11608:                         IF USED("cursor_4c_BuscaMtlSel")
11609:                             USE IN cursor_4c_BuscaMtlSel
11610:                         ENDIF
11611:                     ENDIF
11612:                     USE IN cursor_4c_BuscaMtlM
11613:                 ENDIF
11614:             ENDIF
11615:         CATCH TO loc_oErro
11616:             MsgErro(loc_oErro.Message, "Erro ao buscar metal")
11617:         ENDTRY
11618:     ENDPROC
11619: 
11620:     *--------------------------------------------------------------------------
11621:     * TxtTeorFiscLostFocus - Lookup SigCdMtl por Codigos WHERE Tipos<>'M'
11622:     *--------------------------------------------------------------------------
11623:     PROCEDURE TxtTeorFiscLostFocus()
11624:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
11625:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11626:             RETURN
11627:         ENDIF
11628:         *-- Guard: evita reabrir lookup se valor nao mudou
11629:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11630:             LOCAL loc_cGuardaTeor
11631:             loc_cGuardaTeor = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.txt_4c_Teor.Value, ""))
11632:             IF loc_cGuardaTeor = THIS.this_cUltimoTxtTeorLostFocusValidado
11633:                 RETURN
11634:             ENDIF
11635:             THIS.this_cUltimoTxtTeorLostFocusValidado = loc_cGuardaTeor
11636:         ENDIF
11637:         loc_lResultado = .T.
11638:         TRY
11639:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11640:                 loc_lResultado = .F.
11641:             ENDIF
11642:             IF loc_lResultado
11643:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11644:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Teor.Value, ""))
11645:                 IF EMPTY(loc_cCod)
11646:                     THIS.this_oBusinessObject.this_cTeors = ""
11647:                     IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11648:                         loc_oPg.txt_4c_DesTeor.Value = ""
11649:                     ENDIF
11650:                     loc_lResultado = .F.
11651:                 ENDIF
11652:             ENDIF
11653:             IF loc_lResultado
11654:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos <> 'M'"
11655:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlT")
11656:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlT")
11657:                     SELECT cursor_4c_BuscaMtlT
11658:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11659:                     IF !EOF("cursor_4c_BuscaMtlT")
11660:                         IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11661:                             loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlT.Descs, ""))
11662:                         ENDIF
11663:                         THIS.this_oBusinessObject.this_cTeors = loc_cCod
11664:                     ELSE
11665:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11666:                             "SigCdMtl", "cursor_4c_BuscaTeorSel", "Codigos", loc_cCod, ;
11667:                             "Buscar Teor")
11668:                         IF VARTYPE(loc_oBusca) = "O"
11669:                             IF !loc_oBusca.this_lAchouRegistro
11670:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11671:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11672:                                 loc_oBusca.Show()
11673:                             ENDIF
11674:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTeorSel")
11675:                                 loc_oPg.txt_4c_Teor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Codigos, ""))
11676:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11677:                                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaTeorSel.Descs, ""))
11678:                                 ENDIF
11679:                                 THIS.this_oBusinessObject.this_cTeors = loc_oPg.txt_4c_Teor.Value
11680:                             ELSE
11681:                                 loc_oPg.txt_4c_Teor.Value = ""
11682:                                 IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11683:                                     loc_oPg.txt_4c_DesTeor.Value = ""
11684:                                 ENDIF
11685:                                 THIS.this_oBusinessObject.this_cTeors = ""
11686:                             ENDIF
11687:                             loc_oBusca.Release()
11688:                         ENDIF
11689:                         IF USED("cursor_4c_BuscaTeorSel")
11690:                             USE IN cursor_4c_BuscaTeorSel
11691:                         ENDIF
11692:                     ENDIF
11693:                     USE IN cursor_4c_BuscaMtlT
11694:                 ENDIF
11695:             ENDIF
11696:         CATCH TO loc_oErro
11697:             MsgErro(loc_oErro.Message, "Erro ao buscar teor")
11698:         ENDTRY
11699:     ENDPROC
11700: 
11701:     *--------------------------------------------------------------------------
11702:     * TxtGruccusFiscLostFocus - Armazena grupo de custo no BO
11703:     *--------------------------------------------------------------------------
11704:     PROCEDURE TxtGruccusFiscLostFocus()
11705:         LOCAL loc_oPg
11706:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11707:             RETURN
11708:         ENDIF
11709:         TRY
11710:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11711:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11712:                 IF VARTYPE(loc_oPg.txt_4c_Gruccus) = "O"
11713:                     THIS.this_oBusinessObject.this_cGruccus = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
11714:                 ENDIF
11715:             ENDIF
11716:         CATCH TO loc_oErro
11717:             MsgErro(loc_oErro.Message, "Erro ao atualizar grupo de custo")
11718:         ENDTRY
11719:     ENDPROC
11720: 
11721:     *--------------------------------------------------------------------------
11722:     * TxtContaccusFiscLostFocus - Armazena conta de custo no BO
11723:     *--------------------------------------------------------------------------
11724:     PROCEDURE TxtContaccusFiscLostFocus()
11725:         LOCAL loc_oPg
11726:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11727:             RETURN
11728:         ENDIF
11729:         TRY
11730:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
11731:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11732:                 IF VARTYPE(loc_oPg.txt_4c_Contaccus) = "O"
11733:                     THIS.this_oBusinessObject.this_cContaccus = ALLTRIM(NVL(loc_oPg.txt_4c_Contaccus.Value, ""))
11734:                 ENDIF
11735:             ENDIF
11736:         CATCH TO loc_oErro
11737:             MsgErro(loc_oErro.Message, "Erro ao atualizar conta de custo")
11738:         ENDTRY
11739:     ENDPROC
11740: 
11741:     *--------------------------------------------------------------------------
11742:     * CmdDescFisClick - Gerar Descricao Fiscal automatica
11743:     * Legado: fGerDescFis(0, crSigCdPro.CPros, ThisForm.poDataMgr)
11744:     *--------------------------------------------------------------------------
11745:     PROCEDURE CmdDescFisClick()
11746:         LOCAL loc_oPg, loc_cCpro
11747:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11748:             RETURN
11749:         ENDIF
11750:         TRY
11751:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
11752:                 RETURN
11753:             ENDIF
11754:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
11755:             loc_cCpro = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11756:             IF EMPTY(loc_cCpro)
11757:                 MsgAviso("Informe o c" + CHR(243) + "digo do produto antes de gerar a descri" + ;
11758:                     CHR(231) + CHR(227) + "o fiscal.", "Aten" + CHR(231) + CHR(227) + "o")
11759:                 RETURN
11760:             ENDIF
11761:             *-- Gerar descricao fiscal a partir dos campos fiscais
11762:             *-- Legado usa fGerDescFis() - funcao de framework nao disponivel
11763:             *-- Implementacao simplificada: combina classificacao + origem + ICMS
11764:             LOCAL loc_cDescFis
11765:             loc_cDescFis = ""
11766:             IF VARTYPE(loc_oPg.txt_4c_Clfiscal) = "O"
11767:                 loc_cDescFis = ALLTRIM(NVL(loc_oPg.txt_4c_Clfiscal.Value, ""))
11768:             ENDIF
11769:             IF VARTYPE(loc_oPg.txt_4c_Dclfiscal) = "O" AND !EMPTY(loc_oPg.txt_4c_Dclfiscal.Value)
11770:                 IF !EMPTY(loc_cDescFis)
11771:                     loc_cDescFis = loc_cDescFis + " - "
11772:                 ENDIF
11773:                 loc_cDescFis = loc_cDescFis + ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
11774:             ENDIF
11775:             IF !EMPTY(loc_cDescFis)
11776:                 IF VARTYPE(loc_oPg.obj_4c_Descfis) = "O"
11777:                     loc_oPg.obj_4c_Descfis.Value = loc_cDescFis
11778:                     THIS.this_oBusinessObject.this_cDescfis = loc_cDescFis
11779:                 ENDIF
11780:             ELSE
11781:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!", "Aten" + CHR(231) + CHR(227) + "o")
11782:             ENDIF
11783:         CATCH TO loc_oErro
11784:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11785:         ENDTRY
11786:     ENDPROC
11787: 
11788:     *==========================================================================
11789:     * FASE 14 - Aba Designer (pgDesigner - Page7 do pgf_4c_Dados)
11790:     * Legado: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner
11791:     * Acesso: THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11792:     * Controles: 2 grids (4col + 1col), 1 editbox, 1 label, 3 buttons, 1 image, 1 shape
11793:     *==========================================================================
11794:     PROTECTED PROCEDURE ConfigurarPgPgDesigner()
11795:         LOCAL loc_oPg, loc_oGrd
11796:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11797: 
11798:         *----------------------------------------------------------------------
11799:         *-- Cursor placeholder cursor_4c_SigPrTar (SigPrTar - Tarefas Designer)
11800:         *-- Campos: DtInis, DtFims, Usuars, Tarefas, ObsTars
11801:         *----------------------------------------------------------------------
11802:         IF !USED("cursor_4c_SigPrTar")
11803:             SET NULL ON
11804:             CREATE CURSOR cursor_4c_SigPrTar (;
11805:                 DtInis  D NULL, ;
11806:                 DtFims  D NULL, ;
11807:                 Usuars  C(10), ;
11808:                 Tarefas C(10), ;
11809:                 ObsTars M)
11810:             SET NULL OFF
11811:         ENDIF
11812: 
11813:         *----------------------------------------------------------------------
11814:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11815:         *-- Campos: Arquivos
11816:         *----------------------------------------------------------------------
11817:         IF !USED("cursor_4c_SigPrArq")
11818:             SET NULL ON
11819:             CREATE CURSOR cursor_4c_SigPrArq (;
11820:                 Arquivos C(200))
11821:             SET NULL OFF
11822:         ENDIF
11823: 
11824:         *----------------------------------------------------------------------
11825:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11826:         *----------------------------------------------------------------------
11827:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11828:         WITH loc_oPg.shp_4c_ArqFundo
11829:             .Top         = 415
11830:             .Left        = 584
11831:             .Width       = 407
11832:             .Height      = 202
11833:             .BackColor   = RGB(230, 230, 230)
11834:             .BorderColor = RGB(180, 180, 180)

*-- Linhas 11914 a 12560:
11914:             .Column4.Resizable         = .F.
11915:             .Column4.ReadOnly          = .F.
11916:         ENDWITH
11917:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11918: 
11919:         *----------------------------------------------------------------------
11920:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11921:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11922:         *----------------------------------------------------------------------
11923:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11924:         WITH loc_oPg.obj_4c_ObsTarefas
11925:             .Top              = 160
11926:             .Left             = 584
11927:             .Width            = 407
11928:             .Height           = 238
11929:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11930:             .FontName         = "Tahoma"
11931:             .FontSize         = 8
11932:             .SpecialEffect    = 1
11933:             .ForeColor        = RGB(36, 84, 155)
11934:             .Enabled          = .T.
11935:             .Visible          = .T.
11936:         ENDWITH
11937: 
11938:         *----------------------------------------------------------------------
11939:         *-- btnIniTarefa: Iniciar Tarefa (T:168 L:509 W:42 H:42)
11940:         *----------------------------------------------------------------------
11941:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11942:         WITH loc_oPg.cmd_4c_IniTarefa
11943:             .Top             = 168
11944:             .Left            = 509
11945:             .Width           = 42
11946:             .Height          = 42
11947:             .Caption         = ""
11948:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.bmp"
11949:             .FontName        = "Tahoma"
11950:             .FontSize        = 8
11951:             .Themes          = .F.
11952:             .ToolTipText     = "Iniciar Nova Tarefa"
11953:             .Enabled         = .F.
11954:             .Visible         = .T.
11955:         ENDWITH
11956:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
11957: 
11958:         *----------------------------------------------------------------------
11959:         *-- btnFimTarefa: Encerrar Tarefa (T:203 L:509 W:42 H:42)
11960:         *----------------------------------------------------------------------
11961:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
11962:         WITH loc_oPg.cmd_4c_FimTarefa
11963:             .Top             = 203
11964:             .Left            = 509
11965:             .Width           = 42
11966:             .Height          = 42
11967:             .Caption         = ""
11968:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_26.bmp"
11969:             .FontName        = "Tahoma"
11970:             .FontSize        = 8
11971:             .Themes          = .F.
11972:             .ToolTipText     = "Encerrar Tarefa"
11973:             .Enabled         = .F.
11974:             .Visible         = .T.
11975:         ENDWITH
11976:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
11977: 
11978:         *----------------------------------------------------------------------
11979:         *-- grdArquivos: Grade de Arquivos (T:415 L:10 W:495 H:202) 1 coluna
11980:         *----------------------------------------------------------------------
11981:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
11982:         WITH loc_oPg.grd_4c_Arquivos
11983:             .Top         = 415
11984:             .Left        = 10
11985:             .Width       = 495
11986:             .Height      = 202
11987:             .ColumnCount = 1
11988:             .FontName    = "Tahoma"
11989:             .FontSize    = 8
11990:             .DeleteMark  = .F.
11991:             .ScrollBars  = 2
11992:             .ReadOnly    = .T.
11993:             .Themes      = .F.
11994:             .Visible     = .T.
11995:             .RecordMark   = .F.
11996:         ENDWITH
11997:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
11998:         WITH loc_oPg.grd_4c_Arquivos
11999:             .Column1.ControlSource     = "cursor_4c_SigPrArq.Arquivos"
12000:             .Column1.Header1.Caption   = "Arquivos Para Designer"
12001:             .Column1.Header1.FontName  = "Tahoma"
12002:             .Column1.Header1.FontSize  = 8
12003:             .Column1.Header1.Alignment = 2
12004:             .Column1.Width             = 464
12005:             .Column1.Movable           = .F.
12006:             .Column1.Resizable         = .F.
12007:             .Column1.ReadOnly          = .T.
12008:         ENDWITH
12009:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
12010: 
12011:         *----------------------------------------------------------------------
12012:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
12013:         *----------------------------------------------------------------------
12014:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
12015:         WITH loc_oPg.cmd_4c_InsArqs
12016:             .Top             = 416
12017:             .Left            = 509
12018:             .Width           = 42
12019:             .Height          = 42
12020:             .Caption         = ""
12021:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"
12022:             .FontName        = "Tahoma"
12023:             .FontSize        = 8
12024:             .Themes          = .F.
12025:             .ToolTipText     = "Inserir Arquivo"
12026:             .Enabled         = .F.
12027:             .Visible         = .T.
12028:         ENDWITH
12029:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
12030: 
12031:         *----------------------------------------------------------------------
12032:         *-- btnOpnArqs: Abrir Arquivo (T:500 L:509 W:42 H:42)
12033:         *----------------------------------------------------------------------
12034:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
12035:         WITH loc_oPg.cmd_4c_OpnArqs
12036:             .Top             = 500
12037:             .Left            = 509
12038:             .Width           = 42
12039:             .Height          = 42
12040:             .Caption         = ""
12041:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.bmp"
12042:             .FontName        = "Tahoma"
12043:             .FontSize        = 8
12044:             .Themes          = .F.
12045:             .ToolTipText     = "Abrir Arquivo"
12046:             .Enabled         = .T.
12047:             .Visible         = .T.
12048:         ENDWITH
12049:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
12050: 
12051:         *----------------------------------------------------------------------
12052:         *-- btnExcArqs: Excluir Arquivo (T:458 L:509 W:42 H:42)
12053:         *----------------------------------------------------------------------
12054:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
12055:         WITH loc_oPg.cmd_4c_ExcArqs
12056:             .Top             = 458
12057:             .Left            = 509
12058:             .Width           = 42
12059:             .Height          = 42
12060:             .Caption         = ""
12061:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.bmp"
12062:             .FontName        = "Tahoma"
12063:             .FontSize        = 8
12064:             .Themes          = .F.
12065:             .ToolTipText     = "Excluir Arquivo"
12066:             .Enabled         = .F.
12067:             .Visible         = .T.
12068:         ENDWITH
12069:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
12070: 
12071:         *----------------------------------------------------------------------
12072:         *-- imgArqJpg: Imagem do arquivo (T:417 L:586 W:403 H:198)
12073:         *----------------------------------------------------------------------
12074:         loc_oPg.AddObject("img_4c_ArqJpg", "Image")
12075:         WITH loc_oPg.img_4c_ArqJpg
12076:             .Top         = 417
12077:             .Left        = 586
12078:             .Width       = 403
12079:             .Height      = 198
12080:             .Stretch     = 1
12081:             .Visible     = .F.
12082:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
12083:         ENDWITH
12084:         BINDEVENT(loc_oPg.img_4c_ArqJpg, "Click", THIS, "ImgArqJpgClick")
12085: 
12086:         *----------------------------------------------------------------------
12087:         *-- Bindings When / Valid / LostFocus para Column4 (campo Tarefa)
12088:         *----------------------------------------------------------------------
12089:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
12090:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
12091:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
12092: 
12093:         *----------------------------------------------------------------------
12094:         *-- Binding When para EditBox Obs da Tarefa
12095:         *----------------------------------------------------------------------
12096:         BINDEVENT(loc_oPg.obj_4c_ObsTarefas, "When", THIS, "ObsTarefasWhen")
12097: 
12098:         *----------------------------------------------------------------------
12099:         *-- Bindings When para botoes de tarefa
12100:         *----------------------------------------------------------------------
12101:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "When", THIS, "BtnIniTarefaWhen")
12102:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "When", THIS, "BtnFimTarefaWhen")
12103: 
12104:         *----------------------------------------------------------------------
12105:         *-- Binding When para Column1 do grdArquivos
12106:         *----------------------------------------------------------------------
12107:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
12108: 
12109:         *----------------------------------------------------------------------
12110:         *-- Bindings When para botoes de arquivo
12111:         *----------------------------------------------------------------------
12112:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "When", THIS, "BtnInsArqsWhen")
12113:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "When", THIS, "BtnOpnArqsWhen")
12114:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "When", THIS, "BtnExcArqsWhen")
12115:     ENDPROC
12116: 
12117:     *--------------------------------------------------------------------------
12118:     * GrdDesignerAfterRowColChange - Atualiza EditBox Obs ao mudar linha da grade
12119:     * Legado: grdDesigner.Procedure (AfterRowColChange) ? refresh getObsTarefas
12120:     *--------------------------------------------------------------------------
12121:     PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
12122:         LOCAL loc_oPg
12123:         TRY
12124:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12125:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12126:                 IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12127:                     *-- Sincronizar editbox com observacao da tarefa selecionada
12128:                     IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12129:                         loc_oPg.obj_4c_ObsTarefas.Value = NVL(cursor_4c_SigPrTar.ObsTars, "")
12130:                     ELSE
12131:                         loc_oPg.obj_4c_ObsTarefas.Value = ""
12132:                     ENDIF
12133:                     loc_oPg.obj_4c_ObsTarefas.Refresh()
12134:                 ENDIF
12135:             ENDIF
12136:         CATCH TO loc_oErro
12137:             MsgErro(loc_oErro.Message, "Erro ao atualizar observa" + CHR(231) + CHR(227) + "o da tarefa")
12138:         ENDTRY
12139:     ENDPROC
12140: 
12141:     *--------------------------------------------------------------------------
12142:     * GrdArquivosAfterRowColChange - Mostra imagem do arquivo selecionado
12143:     * Legado: grdArquivos.Procedure (AfterRowColChange) ? mostra imagem JPG/BMP
12144:     *--------------------------------------------------------------------------
12145:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
12146:         LOCAL loc_oPg, loc_cArq, loc_cExt
12147:         TRY
12148:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12149:                 RETURN
12150:             ENDIF
12151:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12152:             IF VARTYPE(loc_oPg.img_4c_ArqJpg) # "O"
12153:                 RETURN
12154:             ENDIF
12155:             CLEAR RESOURCES
12156:             loc_oPg.img_4c_ArqJpg.Picture = ""
12157:             loc_oPg.img_4c_ArqJpg.Visible = .F.
12158:             IF USED("cursor_4c_SigPrArq") AND !EOF("cursor_4c_SigPrArq")
12159:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12160:                 IF !EMPTY(loc_cArq) AND AT(".", loc_cArq) > 0
12161:                     loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
12162:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12163:                         loc_oPg.img_4c_ArqJpg.Picture  = loc_cArq
12164:                         loc_oPg.img_4c_ArqJpg.Visible  = .T.
12165:                     ENDIF
12166:                 ENDIF
12167:             ENDIF
12168:         CATCH TO loc_oErro
12169:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem do arquivo")
12170:         ENDTRY
12171:     ENDPROC
12172: 
12173:     *--------------------------------------------------------------------------
12174:     * BtnIniTarefaClick - Inicia nova tarefa para o usuario logado
12175:     * Legado: btnIniTarefa.Click - verifica tarefa nao encerrada, insere novo registro
12176:     *--------------------------------------------------------------------------
12177:     PROCEDURE BtnIniTarefaClick()
12178:         LOCAL loc_lResultado
12179:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12180:             RETURN
12181:         ENDIF
12182:         loc_lResultado = .T.
12183:         TRY
12184:             IF !USED("cursor_4c_SigPrTar")
12185:                 loc_lResultado = .F.
12186:             ENDIF
12187:             IF loc_lResultado
12188:                 *-- Verificar se existe tarefa nao encerrada para este usuario
12189:                 SELECT cursor_4c_SigPrTar
12190:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12191:                     AND EMPTY(NVL(DtFims, {}))
12192:                 IF !EOF("cursor_4c_SigPrTar")
12193:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12194:                         CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12195:                     loc_lResultado = .F.
12196:                 ENDIF
12197:             ENDIF
12198:             IF loc_lResultado
12199:                 *-- Verificar se existe tarefa sem codigo informado
12200:                 SELECT cursor_4c_SigPrTar
12201:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12202:                     AND EMPTY(Tarefas)
12203:                 IF !EOF("cursor_4c_SigPrTar")
12204:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", "Aten" + CHR(231) + CHR(227) + "o")
12205:                     loc_lResultado = .F.
12206:                 ENDIF
12207:             ENDIF
12208:             IF loc_lResultado
12209:                 *-- Inserir nova tarefa com data/hora de inicio
12210:                 SELECT cursor_4c_SigPrTar
12211:                 APPEND BLANK
12212:                 REPLACE cursor_4c_SigPrTar.DtInis  WITH DATE()
12213:                 REPLACE cursor_4c_SigPrTar.Usuars  WITH PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
12214:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12215:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12216:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12217:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12218:                 ENDIF
12219:             ENDIF
12220:         CATCH TO loc_oErro
12221:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12222:         ENDTRY
12223:     ENDPROC
12224: 
12225:     *--------------------------------------------------------------------------
12226:     * BtnFimTarefaClick - Encerra tarefa do usuario logado
12227:     * Legado: btnFimTarefa.Click - valida usuario e data, replace DtFims
12228:     *--------------------------------------------------------------------------
12229:     PROCEDURE BtnFimTarefaClick()
12230:         LOCAL loc_lResultado
12231:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12232:             RETURN
12233:         ENDIF
12234:         loc_lResultado = .T.
12235:         TRY
12236:             IF !USED("cursor_4c_SigPrTar") OR EOF("cursor_4c_SigPrTar")
12237:                 loc_lResultado = .F.
12238:             ENDIF
12239:             IF loc_lResultado
12240:                 IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) # ALLTRIM(gc_4c_UsuarioLogado)
12241:                     MsgAviso("Essa tarefa n" + CHR(227) + "o pertence a esse usu" + CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12242:                     loc_lResultado = .F.
12243:                 ENDIF
12244:             ENDIF
12245:             IF loc_lResultado
12246:                 IF !EMPTY(cursor_4c_SigPrTar.DtFims)
12247:                     MsgAviso("Essa tarefa j" + CHR(225) + " se encontra finalizada!", "Aten" + CHR(231) + CHR(227) + "o")
12248:                     loc_lResultado = .F.
12249:                 ENDIF
12250:             ENDIF
12251:             IF loc_lResultado
12252:                 SELECT cursor_4c_SigPrTar
12253:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12254:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12255:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12256:                 ENDIF
12257:             ENDIF
12258:         CATCH TO loc_oErro
12259:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12260:         ENDTRY
12261:     ENDPROC
12262: 
12263:     *--------------------------------------------------------------------------
12264:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12265:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12266:     *--------------------------------------------------------------------------
12267:     PROCEDURE BtnInsArqsClick()
12268:         LOCAL loc_cArq, loc_lResultado
12269:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12270:             RETURN
12271:         ENDIF
12272:         loc_lResultado = .T.
12273:         TRY
12274:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12275:             IF EMPTY(loc_cArq)
12276:                 loc_lResultado = .F.
12277:             ENDIF
12278:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12279:                 SELECT cursor_4c_SigPrArq
12280:                 APPEND BLANK
12281:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12282:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12283:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12284:                 ENDIF
12285:             ENDIF
12286:         CATCH TO loc_oErro
12287:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12288:         ENDTRY
12289:     ENDPROC
12290: 
12291:     *--------------------------------------------------------------------------
12292:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12293:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12294:     *--------------------------------------------------------------------------
12295:     PROCEDURE BtnOpnArqsClick()
12296:         LOCAL loc_cArq, loc_oApp, loc_lResultado
12297:         loc_lResultado = .T.
12298:         TRY
12299:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12300:                 loc_lResultado = .F.
12301:             ENDIF
12302:             IF loc_lResultado
12303:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12304:                 IF EMPTY(loc_cArq)
12305:                     loc_lResultado = .F.
12306:                 ENDIF
12307:             ENDIF
12308:             IF loc_lResultado
12309:                 IF !FILE(loc_cArq)
12310:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArq, "Aten" + CHR(231) + CHR(227) + "o")
12311:                     loc_lResultado = .F.
12312:                 ENDIF
12313:             ENDIF
12314:             IF loc_lResultado
12315:                 loc_oApp = CREATEOBJECT("Shell.Application")
12316:                 IF VARTYPE(loc_oApp) = "O"
12317:                     loc_oApp.Open(loc_cArq)
12318:                 ENDIF
12319:             ENDIF
12320:         CATCH TO loc_oErro
12321:             MsgErro(loc_oErro.Message, "Erro ao abrir arquivo")
12322:         ENDTRY
12323:     ENDPROC
12324: 
12325:     *--------------------------------------------------------------------------
12326:     * BtnExcArqsClick - Exclui arquivo da lista de arquivos designer
12327:     * Legado: btnExcArqs.Click - Delete In crSigPrArq + Refresh
12328:     *--------------------------------------------------------------------------
12329:     PROCEDURE BtnExcArqsClick()
12330:         LOCAL loc_lResultado
12331:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12332:             RETURN
12333:         ENDIF
12334:         loc_lResultado = .T.
12335:         TRY
12336:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12337:                 loc_lResultado = .F.
12338:             ENDIF
12339:             IF loc_lResultado
12340:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
12341:                     loc_lResultado = .F.
12342:                 ENDIF
12343:             ENDIF
12344:             IF loc_lResultado
12345:                 SELECT cursor_4c_SigPrArq
12346:                 DELETE
12347:                 IF !EOF("cursor_4c_SigPrArq")
12348:                     SKIP
12349:                     SKIP -1
12350:                 ENDIF
12351:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12352:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12353:                 ENDIF
12354:                 *-- Limpar imagem ao excluir arquivo
12355:                 LOCAL loc_oPg
12356:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12357:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12358:                     CLEAR RESOURCES
12359:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12360:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12361:                 ENDIF
12362:             ENDIF
12363:         CATCH TO loc_oErro
12364:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12365:         ENDTRY
12366:     ENDPROC
12367: 
12368:     *--------------------------------------------------------------------------
12369:     * ImgArqJpgClick - Abre imagem em modo zoom (form SigOpZom)
12370:     * Legado: imgArqJpg.Click - Do Form SigOpZom With lcArq, "Arquivo : " + lcArq
12371:     *--------------------------------------------------------------------------
12372:     PROCEDURE ImgArqJpgClick()
12373:         LOCAL loc_cArq, loc_cExt, loc_lResultado
12374:         loc_lResultado = .T.
12375:         TRY
12376:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12377:                 loc_lResultado = .F.
12378:             ENDIF
12379:             IF loc_lResultado
12380:                 loc_cArq = ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, ""))
12381:                 IF EMPTY(loc_cArq) OR !FILE(loc_cArq)
12382:                     loc_lResultado = .F.
12383:                 ENDIF
12384:             ENDIF
12385:             IF loc_lResultado
12386:                 IF AT(".", loc_cArq) > 0
12387:                     loc_cExt = UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq)))
12388:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12389:                         *-- Tentar abrir zoom form se disponivel
12390:                         IF PEMSTATUS("FormSigOpZom", "NAME", 5) OR FILE(gc_4c_CaminhoForms + "SigOpZom.prg")
12391:                             DO FORM (gc_4c_CaminhoForms + "SigOpZom") WITH loc_cArq, "Arquivo : " + loc_cArq
12392:                         ELSE
12393:                             *-- Fallback: abrir com aplicativo padrao do SO
12394:                             LOCAL loc_oApp
12395:                             loc_oApp = CREATEOBJECT("Shell.Application")
12396:                             IF VARTYPE(loc_oApp) = "O"
12397:                                 loc_oApp.Open(loc_cArq)
12398:                             ENDIF
12399:                         ENDIF
12400:                     ENDIF
12401:                 ENDIF
12402:             ENDIF
12403:         CATCH TO loc_oErro
12404:             MsgErro(loc_oErro.Message, "Erro ao abrir imagem em zoom")
12405:         ENDTRY
12406:     ENDPROC
12407: 
12408:     *--------------------------------------------------------------------------
12409:     * GrdDesignerCol4When - Permite edicao somente para usuario dono da tarefa nao finalizada
12410:     * Legado: grdDesigner.Column4.Text1.When
12411:     *--------------------------------------------------------------------------
12412:     PROCEDURE GrdDesignerCol4When()
12413:         LOCAL loc_lResult
12414:         loc_lResult = .F.
12415:         TRY
12416:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12417:                 IF USED("cursor_4c_SigPrTar") AND !EOF("cursor_4c_SigPrTar")
12418:                     IF ALLTRIM(NVL(cursor_4c_SigPrTar.Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12419:                         AND EMPTY(cursor_4c_SigPrTar.DtFims)
12420:                         loc_lResult = .T.
12421:                     ENDIF
12422:                 ENDIF
12423:             ENDIF
12424:         CATCH TO loc_oErro
12425:             MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de edi" + CHR(231) + CHR(227) + "o")
12426:         ENDTRY
12427:         RETURN loc_lResult
12428:     ENDPROC
12429: 
12430:     *--------------------------------------------------------------------------
12431:     * GrdDesignerCol4Valid - Valida codigo de tarefa, abre lookup se nao encontrado
12432:     * Legado: grdDesigner.Column4.Text1.Valid - fwBuscaInt crTarefas CodCads/DesCads
12433:     *--------------------------------------------------------------------------
12434:     PROCEDURE GrdDesignerCol4Valid()
12435:         LOCAL loc_lResult, loc_cCodigo, loc_oBusca, loc_oPg
12436:         loc_lResult = .T.
12437:         TRY
12438:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
12439:                 loc_lResultado = .T.
12440:             ENDIF
12441:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12442:             loc_cCodigo = ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, ""))
12443:             IF !EMPTY(loc_cCodigo)
12444:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12445:                     "sigcdtar", "cursor_4c_BuscaTar", "codcads", loc_cCodigo, ;
12446:                     "Buscar Tarefa")
12447:                 IF VARTYPE(loc_oBusca) = "O"
12448:                     IF !loc_oBusca.this_lAchouRegistro
12449:                         loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "d.")
12450:                         loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
12451:                         loc_oBusca.Show()
12452:                     ENDIF
12453:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12454:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ALLTRIM(NVL(cursor_4c_BuscaTar.codcads, ""))
12455:                     ELSE
12456:                         loc_oPg.grd_4c_Designer.Column4.Text1.Value = ""
12457:                     ENDIF
12458:                     loc_oBusca.Release()
12459:                 ENDIF
12460:                 IF USED("cursor_4c_BuscaTar")
12461:                     USE IN cursor_4c_BuscaTar
12462:                 ENDIF
12463:             ENDIF
12464:         CATCH TO loc_oErro
12465:             MsgErro(loc_oErro.Message, "Erro ao validar tarefa")
12466:         ENDTRY
12467:         RETURN loc_lResult
12468:     ENDPROC
12469: 
12470:     *--------------------------------------------------------------------------
12471:     * GrdDesignerCol4LostFocus - Ao sair com Enter de tarefa nao vazia, foca ObsTarefas
12472:     * Legado: grdDesigner.Column4.Text1.LostFocus
12473:     *--------------------------------------------------------------------------
12474:     PROCEDURE GrdDesignerCol4LostFocus()
12475:         LOCAL loc_oPg
12476:         TRY
12477:             IF LASTKEY() = 13
12478:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12479:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12480:                     IF VARTYPE(loc_oPg.grd_4c_Designer.Column4.Text1) = "O"
12481:                         IF !EMPTY(ALLTRIM(NVL(loc_oPg.grd_4c_Designer.Column4.Text1.Value, "")))
12482:                             IF VARTYPE(loc_oPg.obj_4c_ObsTarefas) = "O"
12483:                                 loc_oPg.obj_4c_ObsTarefas.SetFocus()
12484:                             ENDIF
12485:                         ENDIF
12486:                     ENDIF
12487:                 ENDIF
12488:             ENDIF
12489:         CATCH TO loc_oErro
12490:             MsgErro(loc_oErro.Message, "Erro ao mover foco para observa" + CHR(231) + CHR(227) + "o")
12491:         ENDTRY
12492:     ENDPROC
12493: 
12494:     *--------------------------------------------------------------------------
12495:     * ObsTarefasWhen - Permite edicao somente em INCLUIR/ALTERAR
12496:     * Legado: getObsTarefas.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12497:     *--------------------------------------------------------------------------
12498:     PROCEDURE ObsTarefasWhen()
12499:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12500:     ENDPROC
12501: 
12502:     *--------------------------------------------------------------------------
12503:     * BtnIniTarefaWhen - Habilita botao Iniciar Tarefa somente em INCLUIR/ALTERAR
12504:     * Legado: btnIniTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12505:     *--------------------------------------------------------------------------
12506:     PROCEDURE BtnIniTarefaWhen()
12507:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12508:     ENDPROC
12509: 
12510:     *--------------------------------------------------------------------------
12511:     * BtnFimTarefaWhen - Habilita botao Encerrar Tarefa somente em INCLUIR/ALTERAR
12512:     * Legado: btnFimTarefa.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12513:     *--------------------------------------------------------------------------
12514:     PROCEDURE BtnFimTarefaWhen()
12515:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12516:     ENDPROC
12517: 
12518:     *--------------------------------------------------------------------------
12519:     * GrdArquivosCol1When - Permite foco em Column1 somente em INCLUIR/ALTERAR
12520:     * Legado: grdArquivos.Column1.Text1.When
12521:     *--------------------------------------------------------------------------
12522:     PROCEDURE GrdArquivosCol1When()
12523:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12524:     ENDPROC
12525: 
12526:     *--------------------------------------------------------------------------
12527:     * BtnInsArqsWhen - Habilita botao Inserir Arquivo somente em INCLUIR/ALTERAR
12528:     * Legado: btnInsArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12529:     *--------------------------------------------------------------------------
12530:     PROCEDURE BtnInsArqsWhen()
12531:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12532:     ENDPROC
12533: 
12534:     *--------------------------------------------------------------------------
12535:     * BtnOpnArqsWhen - Habilita botao Abrir Arquivo sempre
12536:     * Legado: btnOpnArqs.When - Return .t.
12537:     *--------------------------------------------------------------------------
12538:     PROCEDURE BtnOpnArqsWhen()
12539:         RETURN .T.
12540:     ENDPROC
12541: 
12542:     *--------------------------------------------------------------------------
12543:     * BtnExcArqsWhen - Habilita botao Excluir Arquivo somente em INCLUIR/ALTERAR
12544:     * Legado: btnExcArqs.When - Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
12545:     *--------------------------------------------------------------------------
12546:     PROCEDURE BtnExcArqsWhen()
12547:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12548:     ENDPROC
12549: 
12550:     *--------------------------------------------------------------------------
12551:     * Destroy - Liberar recursos
12552:     *--------------------------------------------------------------------------
12553:     PROCEDURE Destroy()
12554:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
12555:             THIS.this_oBusinessObject = .NULL.
12556:         ENDIF
12557:         DODEFAULT()
12558:     ENDPROC
12559: 
12560: ENDDEFINE

